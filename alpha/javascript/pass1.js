/**
 * Pass1（最小実装）: ブロック階層に沿ってネストした識別子環境（env）の構築。
 *
 * env は { bindings: Map<識別子, Binding>, parent: env|null } という連鎖構造。
 * Binding は { category: 'Lambda'|'Atom', restParam: 'bare'|'bracket'|null,
 * atomType, exported: '#'|'##'|'###'|null } という .ist（type_system.md §5 Pass1a）の
 * ごく一部を先取りした最小スキーマ。exportedは前置export記号（#/##/###）の有無を示す
 * （Pass1b、compiler_pipeline.md §6.3「呼び出しサイトの無いexportはコンパイルエラー」で使う）。
 * 予約語が存在しないため、"<...>"で囲まれた文字列は常に識別子と判定できる
 * （classifyAtom と同じ判定基準）。
 *
 * 走査ルール（1スコープぶん）: 各行（フラットなTerm列）を見て、
 *   <id> : ... ? ...   （行内に : があり、その後に ? がある）  → category = 'Lambda'
 *   <id> : ...          （: はあるが ? がない）                 → category = 'Atom'
 *
 * restParam（list_model.md §2.4 / coproduct_resolver.md §5.4）:
 * Lambdaの仮引数列（`:`と`?`の間のトークン列）を見て、後置マーク済みチルダ前置演算子
 * トークン "~_" （peggyパーサーが `~xs` を ["~_", "<xs>"] という隣接ペアで返す）が
 *   - 仮引数列のトップレベルに直接現れる     → restParam = 'bare'   （例: x ~xs ? ...）
 *   - ネストした配列（[...]ブロック）の中に現れる → restParam = 'bracket'（例: [x ~xs] ? ...）
 *   - どちらにも現れない                    → restParam = null
 * を判定する。bare/bracketの区別が、list_model.md §2.4のLazy(stream)/Eager(実体化)の
 * 区別にそのまま対応する。
 *
 * ネスト: ブロック（[...] {...} (...) やインデントブロック）に遭遇したら、
 * そのブロック内の行だけを対象に新しいスコープ（子env、parent=呼び出し時のenv）を作る。
 * この処理は pass2.js の resolveBlock 側で childEnv() を呼んで再帰する形で行う。
 * 外側スコープの識別子は、内側のブロックから envLookup() の親チェーンを辿って
 * 常に参照できる（ブロックスコープのシャドーイング: 同名を内側で再定義すれば
 * bindings.has() が先に見つかるため自然に内側優先になる）。
 *
 * 【既知の制限】
 * - スコープ検査（未定義識別子の参照エラー等）は一切行わない。
 * - 同一スコープ内での再定義は後勝ちで単純に上書きする。
 * - restParamは仮引数列の構文形だけで判定しており、arity・atom_type・callsites
 *   （type_system.md §5 Pass1b、@refのジェネリック具体化）は未実装。
 */

function containsToken(items, token) {
  for (const t of items) {
    if (t === token) return true;
    if (Array.isArray(t) && containsToken(t, token)) return true;
  }
  return false;
}

function detectRestParamShape(paramTokens) {
  if (paramTokens.includes("~_")) return "bare";
  if (paramTokens.some((t) => Array.isArray(t) && containsToken(t, "~_"))) return "bracket";
  return null;
}

// リテラル1個だけの生トークンから、Layer 2 Atom内部型（type_system.md §2）を判定する。
// pass2.js の classifyAtom と同じ判定基準（循環import回避のためここで別途最小実装）。
// 小数点の有無で Address/Float を区別する（§2「リテラルのlayer制約」）。
function literalAtomType(token) {
  if (typeof token !== "string") return null;
  if (token === "__" || token === "\x00") return "Unit";
  if (token.startsWith("`")) return "String";
  if (token.startsWith("\\")) return "String"; // 文字リテラルはStringと同型
  if (/^0x[0-9a-fA-F]+$/.test(token)) return "Address";
  // `0r`/`0b` はビット列。オーバーフローはラップアラウンドで、`0x` の `__` 収束とは
  // 挙動が異なる（integer_overflow.md §1）。よって `Address` ではなく `Int` 側である。
  if (/^(0r[0-9a-fA-F]+|0b[01]+)$/.test(token)) return "Int";
  // `0u` は Char（String の要素型、`String ≅ List(0u)`）。`\a` と同じく String であり、
  // U+0000 は Char の値域から除外された niche なので Unit（pass3.js と同じ判定）。
  if (/^0u[0-9a-fA-F]+$/.test(token)) return parseInt(token.slice(2), 16) === 0 ? "Unit" : "String";
  if (/^-?[0-9]+\.[0-9]*$/.test(token)) return "Float"; // 小数点あり
  // アドレスは `0x` 記法のみ（type_system.md §3.6）。十進整数は `Int`——ラップアラウンド
  // するので、`__` へ収束する `Address` とは別の型である（integer_overflow.md §1）。
  if (/^-?[0-9]+$/.test(token)) return "Int"; // 小数点なし十進整数
  return null;
}

// 前置export記号のマーク済みトークン（peggyパーサーが `#add` を ["#_", "<add>"] という
// 隣接ペアで返す）→ 記号そのものへの対応表。
const EXPORT_MARKERS = { "#_": "#", "##_": "##", "###_": "###" };

// 仮引数の生トークン列から、消費すべき引数の数（アリティ）を数える。
// 裸の空白区切り形（`x y z`）・ブラケット/インデント形（改行区切り、デフォルト付き含む）の
// どちらにも対応する。restが登場したら Infinity（可変長、常に受け付ける）を返す。
// 単一パラメータ（配列でない裸の1トークン）は null（対象外）を返す——1個適用した時点で
// 元々Atomになるため、この判定が無くても正しく動く（pass2.jsのapply連鎖飽和判定を参照）。
function countArity(paramTokens) {
  if (paramTokens.length === 0) return null;
  if (paramTokens.length === 1 && Array.isArray(paramTokens[0])) {
    return countNestedArity(paramTokens[0]);
  }
  if (paramTokens.length === 1) return null; // 単一の裸パラメータ
  return countBareArity(paramTokens);
}

// 裸の（改行/ブラケット区切りでない）トークン列を1エントリずつ数える。
// "name : default..." は1エントリ（":"以降は読み飛ばす）、"~_ name" が現れたら
// 以降は可変長なのでInfinityを返す。
function countBareArity(tokens) {
  let count = 0;
  let i = 0;
  while (i < tokens.length) {
    if (tokens[i] === "~_") return Infinity;
    count++;
    if (tokens[i + 1] === ":") {
      i = tokens.length; // 残り全部がこのエントリのデフォルト式
      break;
    }
    i++;
  }
  return count;
}

function isFlatLine(x) {
  return Array.isArray(x) && x.every((t) => typeof t === "string");
}

// `name : デフォルト式` の形をした1行か（pass2.js の isParamEntryLine と同じ判定）。
//
// isFlatLine は全要素が文字列であることを要求するため、デフォルト式が括弧やブラケットを
// 含む（`x : (2 + 3)`）と中に配列が現れて false になる。それだけを見て「行ではなく
// 文の並びだ」と扱うと、countStatements が行の中身へ降りていき、最終的に**文字列**を
// 受け取る。文字列に対する `for...of` は1文字ずつ回るため、そこから自分自身を呼び直して
// 無限再帰する——デフォルト引数の中で括弧が一切使えなくなっていた原因がこれである。
// 先頭が識別子で、トップレベルに `:` があれば、中身が入れ子でも1エントリの行である。
function isParamEntryLine(x) {
  if (!Array.isArray(x) || x.indexOf(":") <= 0) return false;
  // 裸の rest にもデフォルトを書ける（`~xs : [2 3 4]`）。名前は印の次にある。
  const head = x[0] === "~_" ? x[1] : x[0];
  return typeof head === "string" && head.startsWith("<");
}

function isTaggedBlockToken(x) {
  return Array.isArray(x) && (x[0] === '"INDENT_"' || x[0] === '"ABS_"');
}

// pass2.jsのpeelBracketEntryTokenと同じロジック（循環import回避のためここで別途最小実装）。
// 複数の裸パラメータの中の1エントリとして書かれたブラケット分割代入パターン
// （例: `dist [h ~t]`の`[h ~t]`）かどうかを判定する。そうであれば、その中身の"~_"等は
// このブラケット自身のサブエントリ用であり、外側の関数のアリティには影響しない
// （＝1個の引数スロットとして数える。countStatements参照）。
function isBracketEntryToken(token) {
  if (!Array.isArray(token)) return false;
  let cur = token;
  while (Array.isArray(cur) && cur.length === 1 && Array.isArray(cur[0]) && !isFlatLine(cur[0]) && !isTaggedBlockToken(cur[0])) {
    cur = cur[0];
  }
  return Array.isArray(cur) && cur.length >= 1 && cur.every((line) => isFlatLine(line) || isTaggedBlockToken(line));
}

// 「文の並び」（またはラップされた1文）を再帰的に数える。pass2.jsのflattenParamStatements
// と同じ構造を、生トークンの段階で軽量に再現する（循環import回避のためここで別途最小実装）。
// **ブラケット形＋デフォルト**（`[x ~xs] : [1 2 3]`）を1エントリとして見分ける。
//
// デフォルトが供給するのは**器**であり、分解はその器に対して起きる。だから要求する実引数は
// （デフォルトが無ければ）1個であって、分解後の束縛の数ではない。ここを見ないと
// `[[x ~xs]] : [1 2 3]` が「ブラケット・`:`・デフォルト式」の3スロットとして数えられ、
// 呼び出しが常に部分適用になっていた。
function isBracketEntryWithDefault(stmt) {
  if (!Array.isArray(stmt)) return false;
  const ci = stmt.indexOf(":");
  return ci > 0 && Array.isArray(stmt[0]) && isBracketEntryToken(stmt[0]);
}
function countStatements(node) {
  if (isFlatLine(node)) return countBareArity(node);
  if (isParamEntryLine(node)) return 1;
  // 配列でないもの（文字列トークン等）がここへ来たら1トークンとして数え、降りない。
  // 文字列に対する `for...of` は1文字ずつ回るため、降りると自分自身を呼び直して
  // 無限再帰する（デフォルト式の括弧で実際に踏んだ）。
  if (!Array.isArray(node)) return 1;
  let total = 0;
  for (const stmt of node) {
    let c;
    if (isFlatLine(stmt)) c = countBareArity(stmt);
    else if (isParamEntryLine(stmt)) c = 1; // `name : 式` は括弧を含んでも1スロット
    else if (isBracketEntryWithDefault(stmt)) c = 1; // ブラケット＋デフォルトも1スロット
    else if (isBracketEntryToken(stmt)) c = 1; // 1エントリとしてのブラケット分割代入は1スロット分
    else if (isTaggedBlockToken(stmt)) c = countStatements(stmt[1]);
    else c = countStatements(stmt); // さらにネストした1文（例: func_mixedのブラケット単独文）
    if (c === Infinity) return Infinity;
    total += c;
  }
  return total;
}

// インデント/ブラケット形の仮引数部のエントリ数を数える。
function countNestedArity(token) {
  const lines = Array.isArray(token) && (token[0] === '"INDENT_"' || token[0] === '"ABS_"') ? token[1] : token;
  return countStatements(lines);
}

// 必須アリティ（デフォルト・rest以外の仮引数の数、pass2.jsのbuildParameterListが計算する
// requiredArityと同じ基準）を数える。countArity（総スロット数、デフォルト付きも含めて
// 数える）とは別軸——自動カリー化（markUndersaturatedApplies、project memory:
// project-sign-currying-design）が「デフォルトで埋まる分」を「まだ足りないので部分適用に
// すべき」と誤判定しないために必要。countArity自体は「同じ式内でまだ引数を続けて
// 受け取れるか」の判定に使われ続けるため、そちらの基準は変えない。
function countRequiredArity(paramTokens) {
  if (paramTokens.length === 0) return 0;
  if (paramTokens.length === 1 && Array.isArray(paramTokens[0])) {
    // 仮引数部全体が1個のブラケット（`[a b]`、`[x ~xs]`）なら、**要求する実引数は1個**
    // ——ブラケットは渡された単一の List/Struct をその場で分割代入する（Eagerパターン、
    // list_model.md §2.4）。エントリ数は分解後の束縛の数であって実引数の数ではない。
    // インデントブロック形（デフォルト引数）は別物なので従来通り数える。
    if (!isTaggedBlockToken(paramTokens[0]) && isBracketEntryToken(paramTokens[0])) return 1;
    return countNestedRequiredArity(paramTokens[0]);
  }
  if (paramTokens.length === 1) return 1; // 単一の裸パラメータ（デフォルト無し前提）
  return countBareRequiredArity(paramTokens);
}

function countBareRequiredArity(tokens) {
  let count = 0;
  let i = 0;
  while (i < tokens.length) {
    if (tokens[i] === "~_") {
      i += 2; // rest（"~_"+名前）は必須に数えない
      continue;
    }
    if (tokens[i + 1] === ":") {
      i = tokens.length; // デフォルト付きエントリ：必須に数えない
      break;
    }
    count++;
    i++;
  }
  return count;
}

function countRequiredStatements(node) {
  if (isFlatLine(node)) return countBareRequiredArity(node);
  if (isParamEntryLine(node)) return 0; // デフォルト付きエントリは必須に数えない
  if (!Array.isArray(node)) return 0; // countStatements と同じ理由の防御
  let total = 0;
  for (const stmt of node) {
    let c;
    if (isFlatLine(stmt)) c = countBareRequiredArity(stmt);
    else if (isParamEntryLine(stmt)) c = 0; // デフォルト付きエントリは必須に数えない
    else if (isBracketEntryWithDefault(stmt)) c = 0; // デフォルトがあるので必須ではない
    else if (isBracketEntryToken(stmt)) c = 1; // ブラケット分割代入は常に1個の必須スロット
    else if (isTaggedBlockToken(stmt)) c = countRequiredStatements(stmt[1]);
    else c = countRequiredStatements(stmt);
    total += c;
  }
  return total;
}

function countNestedRequiredArity(token) {
  const lines = Array.isArray(token) && isTaggedBlockToken(token) ? token[1] : token;
  return countRequiredStatements(lines);
}

function buildEnvScope(lines) {
  const bindings = new Map();
  for (const line of lines) {
    if (!Array.isArray(line) || line.length < 2) continue;

    // 先頭が前置export記号（#/##/###）なら、その分だけ識別子の位置をずらす。
    let idOffset = 0;
    let exported = null;
    if (typeof line[0] === "string" && EXPORT_MARKERS[line[0]]) {
      exported = EXPORT_MARKERS[line[0]];
      idOffset = 1;
    }

    const first = line[idOffset];
    if (typeof first !== "string" || !first.startsWith("<") || !first.endsWith(">")) continue;
    const defineIdx = line.indexOf(":");
    if (defineIdx !== idOffset + 1) continue; // "[export]<id> :" の形のみ対象
    const qIdx = line.indexOf("?", defineIdx + 1);
    const hasLambda = qIdx !== -1;
    const paramTokens = hasLambda ? line.slice(defineIdx + 1, qIdx) : null;
    const restParam = hasLambda ? detectRestParamShape(paramTokens) : null;
    const arity = hasLambda ? countArity(paramTokens) : null;
    const requiredArity = hasLambda ? countRequiredArity(paramTokens) : null;
    // atomType: `<id> : <リテラル1個>` という最も単純な形のみ、Pass1aで静的に読み取る。
    // 仮引数（本体の使用箇所から逆算が必要、type_system.md §7.1）は未対応・既知の制限。
    const rhs = line.slice(defineIdx + 1);
    const atomType = !hasLambda && rhs.length === 1 ? literalAtomType(rhs[0]) : null;
    // Layer 1（type_system.md §2）の識別子カテゴリは「右辺式のカテゴリ」であって、
    // 「その行にトップレベルの `?` があるか」ではない——`?` だけを見ると
    // `inc : [+ 1]`（部分操作のブラケット＝§2の表でLambda）・`h : f g`（compose＝
    // §3.1でLambda）・`k : f`（Lambdaのエイリアス）・`g : f 1`（アリティ不足の
    // 部分適用）が全部Atomになり、`inc 3` が apply ではなく concat に解決されてしまう。
    // ただし右辺のカテゴリはトークン列のままでは判定できない（縮約後のノードに対する
    // pass2.jsのgetCategoryが唯一の判定器）ため、ここでは右辺のトークン列を持たせるに
    // とどめ、実際の解決はpass2.js側のresolveBindingCategoryが最初の参照時に一度だけ
    // 行ってここへメモ化する（遅延なので前方参照でも順序に依存しない）。
    // 単独のリテラル（atomTypeが読めた形）は確実にAtomなので、保持せず打ち切る。
    const rhsTokens = !hasLambda && atomType === null && rhs.length > 0 ? rhs : null;
    bindings.set(first, { category: hasLambda ? "Lambda" : "Atom", restParam, atomType, exported, arity, requiredArity, rhsTokens });
  }
  return bindings;
}

function childEnv(lines, parent) {
  return { bindings: buildEnvScope(lines), parent: parent || null };
}

function envLookup(env, id) {
  let e = env;
  while (e) {
    if (e.bindings.has(id)) return e.bindings.get(id);
    e = e.parent;
  }
  return undefined;
}

// envLookupと同じ探索だが、見つかったスコープ自身も返す。遅延カテゴリ解決
// （pass2.jsのresolveBindingCategory）が、右辺のトークン列を「その束縛が書かれた
// スコープ」で縮約する必要があるため（参照側の現在のenvではない）。
function envLookupScope(env, id) {
  let e = env;
  while (e) {
    if (e.bindings.has(id)) return { binding: e.bindings.get(id), scope: e };
    e = e.parent;
  }
  return null;
}

// 後方互換: 従来の buildEnv(lines) はトップレベルの env（parent:null）を返す
function buildEnv(lines) {
  return childEnv(lines, null);
}

// 仮引数名だけを{category:'Atom', restParam:null}として登録する軽量スコープ生成。
// buildEnvScopeと違い、`<id> : ... ? ...`という定義行の形を要求しない
// （仮引数はそもそもそのような定義行を持たない裸の識別子のため）。
// pass2.jsのbuildParameterList（let*的な逐次スコープ構築）から使う。
function bindEnv(names, parent) {
  const bindings = new Map();
  for (const name of names) bindings.set(name, { category: "Atom", restParam: null, atomType: null, exported: null, arity: null });
  return { bindings, parent: parent || null };
}

export { buildEnv, buildEnvScope, childEnv, envLookup, envLookupScope, bindEnv, literalAtomType, EXPORT_MARKERS };
