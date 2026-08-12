/**
 * Pass2: coproduct_resolver.md のアルゴリズム実装。
 * Pass1相当(peggyパーサー)が返すフラットなTerm列を、二分木ASTへ縮約する。
 *
 * getCategory は第2引数に env（pass1.js の childEnv/buildEnv が返す、ブロック階層に
 * 沿ってネストしたスコープ連鎖）を受け取る。env未指定、またはenv連鎖のどこにも無い
 * 識別子は Atom にフォールバックする（組み込み `<print>` のみ例外的に Lambda）。
 * ブロック（[...] {...} (...) やインデントブロック）を再帰的に解決する際、
 * resolveBlock がそのブロック内の行だけを対象にした子スコープ（親=呼び出し時のenv）を
 * 自動生成するため、外側スコープの識別子は内側のブロックから常に参照できる。
 *
 * 実装にあたって仕様書(coproduct_resolver.md)に明記がなく、以下の点は仮定を置いた（要レビュー）:
 * 1. 複数の前置/後置演算子が連続する場合（例: `!$x`）の結合順序。
 *    coreに近い方から先に結合する（`!$x` = `!($x)`）という一般的な慣習を採用。
 * 2. 優先度10.1（Unshift/push）の具体的な演算子名。仕様は「Atom|List~ の組み合わせ」としか
 *    書いておらず、方向性の区別が明記されていない。ここでは List~ 側が右なら push、
 *    左なら unshift とした。
 * 3. Block（[...] {...} (...)）の種別（paren/brace/bracket）は grammar.pegjs が
 *    区別を保持しないため、AST上でも区別できていない（kindは "paren" 固定、または
 *    indent/absのみ判別）。
 *
 * 【grammar.pegjs 根本修正済み】以前は Expression の `.flat()` が密着演算子グループと
 * Blockを区別できず、Blockが他の項と混在すると中身が漏れる問題があった（Pass2側の
 * repairLeakedBlocks()という回避策で当座を凌いでいた）。grammar.pegjs 側で以下の3点を
 * 修正したことで根本的に解消し、Pass2側の回避策は不要になった:
 *   - Term: coreが配列（Block）の場合、1階層ラップして返す
 *   - Expression: soloかどうかに関わらず常にflat()する
 *   - Block: indent/abs系もexprsを展開せず1要素として保持する（bracket系と対称に）
 */

import { OPERATOR_DICT } from './operator_table.js';
import { childEnv, envLookup, envLookupScope, bindEnv, EXPORT_MARKERS } from './pass1.js';

// ---- ユーティリティ ----

const OPERATOR_SYMBOL_RE = /^[!"#$%&'\-=^~|@;+:*,<>/?]+$/;

function isMarkedPrefix(x) {
  // 例: "@_", "!!_"  (末尾が "_"、かつ本体が単なる "_"/"__"ではない)
  return typeof x === "string" && x !== "_" && x !== "__" && x.endsWith("_") && !x.startsWith("_");
}
function isMarkedPostfix(x) {
  // 例: "_@", "_~"
  return typeof x === "string" && x !== "_" && x !== "__" && x.startsWith("_") && !x.endsWith("_");
}
function isBareOperatorToken(x) {
  return typeof x === "string" && OPERATOR_SYMBOL_RE.test(x) && !isMarkedPrefix(x) && !isMarkedPostfix(x);
}

// range 族は部分適用に参加しない。
// list_model.md §2.2 が定める通り、レンジ式の**項の数は「いつ消費するか」の宣言**である
// ——3項（`[2 ~+ 2 ~ 10]`）なら即時消費、2項（`[1 ~+ 1]`）なら終端の無い Pull 型
// イテレータになる。つまり項が欠けた形は既に「終端の無い範囲」という意味を持っており、
// そこへ「引数待ちの関数」という意味を重ねると、同じ記法に2つの読みが乗ってしまう。
// `[1 ~]` のような形は部分適用ではなく、解決できない式として弾く。
const RANGE_OPERATORS = new Set(["~", "~+", "~-", "~*", "~/", "~^"]);
function isPartialCapableOperator(x) {
  return isBareOperatorToken(x) && !RANGE_OPERATORS.has(x);
}

function toNode(x, env) {
  // すでにoperation/blockノードならそのまま、そうでなければAtomリーフとして包む
  if (x && typeof x === "object" && !Array.isArray(x)) return x;
  if (Array.isArray(x)) return resolveBlock(x, env);
  return { type: "atom", kind: classifyAtom(x), value: x };
}

function classifyAtom(s) {
  if (s === "__" || s === "\x00") return "unit";
  if (s === "_") return "hole";
  if (typeof s === "string" && s.startsWith("<") && s.endsWith(">")) return "identifier";
  if (typeof s === "string" && s.startsWith("`")) return "string";
  if (typeof s === "string" && s.startsWith("\\")) return "char";
  if (typeof s === "string" && /^0x[0-9a-fA-F]+$/.test(s)) return "address";
  if (typeof s === "string" && /^(0r[0-9a-fA-F]+|0b[01]+)$/.test(s)) return "register";
  if (typeof s === "string" && /^0u[0-9a-fA-F]+$/.test(s)) return "unicode";
  if (typeof s === "string" && /^-?[0-9]+\.?[0-9]*$/.test(s)) return "number";
  return "unknown";
}

// ---- Step1: 密着した前置/後置演算子の解決 ----
// pre:Prefixes core:Core post:Postfixes は既に隣接した1つのTermとして
// 平坦化されているため、"X_"が連続する塊 → core → "_X"が連続する塊、という
// 隣接パターンを左から右へ貪欲に見つけて畳み込む。
function resolveDensity(rawItems, env) {
  const items = rawItems;
  const out = [];
  let i = 0;
  while (i < items.length) {
    // 前置マーカーを伴わない裸の演算子トークンは、密着グループの外側にあるので素通しする
    if (isBareOperatorToken(items[i])) {
      out.push(items[i]);
      i++;
      continue;
    }
    const preOps = [];
    while (i < items.length && isMarkedPrefix(items[i])) {
      preOps.push(items[i].slice(0, -1)); // "@_" -> "@"
      i++;
    }
    if (i >= items.length) {
      // 前置演算子だけでcoreが無い＝部分適用（Lambdaカテゴリの断片として残す）
      for (const op of preOps) out.push({ type: "operation", op, name: lookup(op, "prefix")?.name, position: "prefix", partial: true });
      break;
    }
    let core = toNode(items[i], env);
    i++;
    const postOps = [];
    while (i < items.length && isMarkedPostfix(items[i])) {
      postOps.push(items[i].slice(1)); // "_@" -> "@"
      i++;
    }
    // coreに近い方から先に結合（前置は右から、後置は左から）
    let node = core;
    for (let k = postOps.length - 1; k >= 0; k--) {
      const op = postOps[k];
      const operand = node;
      node = { type: "operation", op, name: lookup(op, "postfix")?.name, position: "postfix", operand };
      // ポイントフリー記述の前置/後置版（function_guide.md「前置演算子は`[<op>_]`
      // 後置演算子は`[_<op>]`」）: operandが直接hole（`_`）なら、この演算子は
      // まだ値を待っている部分適用とみなす（getCategoryの既存のpartial判定に乗る）。
      if (operand.type === "atom" && operand.kind === "hole") node.partial = true;
    }
    for (let k = preOps.length - 1; k >= 0; k--) {
      const op = preOps[k];
      const operand = node;
      node = { type: "operation", op, name: lookup(op, "prefix")?.name, position: "prefix", operand };
      if (operand.type === "atom" && operand.kind === "hole") node.partial = true;
    }
    out.push(node);
  }
  return out;
}

function lookup(symbol, position) {
  const defs = OPERATOR_DICT[symbol];
  if (!defs) return null;
  return defs.find((d) => d.position === position) || null;
}

// apply[apply[apply[f, a1], a2], a3] のような左結合のapplyチェーンを遡り、
// 消費済みの引数の数（depth）と、根本の呼び出し先ノード（base、通常は識別子）を返す。
function applyChainInfo(node) {
  let depth = 0;
  let n = node;
  while (n && n.type === "operation" && n.name === "apply") {
    depth++;
    n = n.left;
  }
  return { depth, base: n };
}

// 自動カリー化（project memory: project-sign-currying-design）が「丸括弧を跨いだ段階的な
// 適用」（`(f 1) 2 3`のように、部分適用の結果へさらに引数を重ねていく形）でも正しく
// アリティを追跡できるようにするための解決器。素の識別子なら{arity, requiredArity,
// consumed:0}を返す。arity（総スロット数、デフォルト付きも含む）は「同じ式内でまだ
// 引数を続けて受け取れるか」の判定に、requiredArity（デフォルト・rest以外の必須数）は
// 「この呼び出しはカリー化すべきか」の判定に、それぞれ別の目的で使われる（pass1.jsの
// countArity/countRequiredArityの区別と対応）。1行だけのparenブロック（`(...)`）なら
// 中身を再帰的に覗く。apply/partial_applyチェーン（既にいくらか引数が適用された状態）
// なら、そのチェーン自身の深さを「既に消費済み」に加算しつつ、根本の識別子まで再帰的に
// 遡る。既知の有限アリティを持つ識別子へ辿り着けない場合（rest引数・単一裸パラメータ・
// 識別子でない値など）はnullを返す——その場合は元々の「1回の適用で飽和する」既存挙動の
// まま何も変えない。
function resolveKnownArity(node, env) {
  if (!node) return null;
  if (node.type === "atom" && node.kind === "identifier") {
    if (!env) return null;
    const found = envLookupScope(env, node.value);
    // エイリアス（`k : f`）や部分適用（`g : f 1`）は、カテゴリ解決の副産物として
    // 残りアリティが束縛へ書き込まれる。読む前に必ず解決しておく。
    if (found) resolveBindingCategory(found.binding, found.scope);
    const binding = found ? found.binding : undefined;
    // Infinity（rest引数）もここでは許可する——typeof Infinity==="number"なので、
    // getCategoryの「同じ式内でチェーンを伸ばし続けてよいか」判定（depth<arityが
    // 常に真になるべき）にはInfinityが必要。カリー化すべきでない（rest引数は本質的に
    // 可変長でカリー化の概念に合わない）という判断は、呼び出し側のmarkUndersaturatedApplies
    // が個別にInfinityを除外する。
    if (binding && typeof binding.arity === "number") {
      const requiredArity = typeof binding.requiredArity === "number" ? binding.requiredArity : binding.arity;
      return { arity: binding.arity, requiredArity, consumed: 0 };
    }
    return null;
  }
  if (node.type === "block" && node.kind !== "indent" && node.kind !== "abs" && node.lines.length === 1) {
    return resolveKnownArity(node.lines[0], env);
  }
  if (node.type === "operation" && (node.name === "apply" || node.name === "partial_apply")) {
    let depth = 0;
    let n = node;
    while (n && n.type === "operation" && (n.name === "apply" || n.name === "partial_apply")) {
      depth++;
      n = n.left;
    }
    const inner = resolveKnownArity(n, env);
    if (!inner) return null;
    return { arity: inner.arity, requiredArity: inner.requiredArity, consumed: inner.consumed + depth };
  }
  // ラムダノードそのもの。pass1 は束縛のアリティをトークン列から数えるため、`?` を含まない
  // 右辺（ホール脱糖が作ったラムダ、`p : f _ _` など）ではアリティが読めない。pass2 が
  // 組んだ params ノードから直接数えることで、`p 1 2` が2引数の適用として解決される。
  // 単一の裸パラメータは pass1 の countArity と同じく null を返す（1回の適用で飽和する
  // 既存挙動のまま）。rest があれば Infinity——上のコメントの通りここでは許可する。
  if (node.type === "operation" && node.op === "?" && node.left && node.left.type === "params") {
    const entries = node.left.entries || [];
    const arity = entries.some((e) => e.rest) ? Infinity : entries.length;
    const requiredArity = typeof node.left.requiredArity === "number" ? node.left.requiredArity : arity;
    return { arity, requiredArity, consumed: 0 };
  }
  return null;
}

// 自動カリー化（project memory: project-sign-currying-design）: 完全な木を静的に走査し、
// 「既知の（有限）アリティを持つ識別子への apply チェーンで、消費済みの引数の数が
// アリティに届いていない」ノードを見つけたら、その場で node.name を "partial_apply" へ
// リネームする——「アリティ不足を検出したら、その場で構造体＋関数ポインタ相当のものを
// 合成する」という設計を、実行時のinterpreter.jsに判断させず、ここ（コンパイル時に
// 相当するPass2）で完結させるための印付け。interpreter.js側は"partial_apply"を見たら、
// 完全性公理による崩壊（bindParamsの通常経路）を一切通さず、無条件に部分適用クロージャを
// 構築するだけ——「アリティが足りているか」という判断そのものは、もうここで終わっている。
// rest（arity===Infinity）や単一裸パラメータ（arity===null、未追跡）の呼び出し先は対象外
// （元々1回の適用で飽和したものとして正しく動く既存の挙動を変えない）。
// depthが同じ「1本のapplyチェーン」内では最も外側（呼び出し全体の完成形）だけを見ればよく、
// チェーンの内側（.left側）は既にそのdepth計算に含まれているため再帰しない——ただし各段の
// 引数（.right）や呼び出し先（base）自身は、別の独立したapply式を含みうるため再帰する。
function markUndersaturatedApplies(node, env) {
  if (!node || typeof node !== "object") return node;
  if (node.type === "operation" && node.name === "apply") {
    const argNodes = [];
    let n = node;
    while (n && n.type === "operation" && n.name === "apply") {
      argNodes.unshift(n.right);
      n = n.left;
    }
    const base = n;
    for (const a of argNodes) markUndersaturatedApplies(a, env);
    markUndersaturatedApplies(base, env);
    // resolveKnownArityはbaseが素の識別子の場合だけでなく、丸括弧越しの部分適用
    // （`(f 1) 2 3`のbase＝`(f 1)`という1行parenブロック）も透かして見る——
    // これにより複数段の丸括弧を跨いだ段階的な適用でも、最終的に飽和したかどうかを
    // 正しく判定できる（跨いだ先のarity情報が既にmarkUndersaturatedAppliesの再帰で
    // 中の"partial_apply"リネームとして確定済みなので、resolveKnownArityはそれを読むだけ）。
    // カリー化すべきかどうかはrequiredArity（デフォルト・rest以外の必須数）で判定する
    // ——デフォルトで埋まる分は「まだ足りない」とみなさない（例: `g : x\n y:x+1 ?...`
    // に対して`g 3`はrequiredArity=1を満たしているので、カリー化せず通常のデフォルト
    // フォールバックに委ねる）。
    // arity===Infinity（rest引数）はカリー化の対象外——restは本質的に可変長で
    // 「あと何個必須で足りないか」という概念に合わない（0個でも合法に完結する）。
    const info = resolveKnownArity(base, env);
    if (info && info.arity !== Infinity && argNodes.length + info.consumed < info.requiredArity) {
      node.name = "partial_apply";
    }
    return node;
  }
  if (node.type === "block") {
    if (Array.isArray(node.lines)) node.lines.forEach((l) => markUndersaturatedApplies(l, env));
    return node;
  }
  if (node.left !== undefined) markUndersaturatedApplies(node.left, env);
  if (node.right !== undefined) markUndersaturatedApplies(node.right, env);
  if (node.operand !== undefined) markUndersaturatedApplies(node.operand, env);
  return node;
}

// bracket系ブロック（indent/absを除く）が1行だけを保持している場合、その1行を再帰的に
// 覗く（`[+]`のような、演算子1個だけを囲んだブロックの中身を取り出す）。
// `[1 2 3]`のような複数トークンの行は`lines.length===1`のまま（1行の中で構築済みの
// construct連鎖になっているだけ）なので、中身の種類で自然に区別される。
// Layer 1（type_system.md §2）の識別子カテゴリを「右辺式のカテゴリ」として解決する。
// pass1.jsのbuildEnvScopeはトークン列しか見られないため、`?` の有無だけで暫定的に
// Atomと置いた束縛に右辺のトークン列（binding.rhsTokens）を持たせてある。ここで初めて
// 参照されたときに一度だけ縮約し、getCategoryで本当のカテゴリを求めてメモ化する。
//   inc : [+ 1]  → 部分操作のブラケット（§2の表）        → Lambda
//   h   : f g    → Lambda∘Lambda（§3.1のcompose）        → Lambda
//   k   : f      → Lambdaのエイリアス                     → Lambda
//   g   : f 1    → アリティ不足の部分適用（partial_apply）→ Lambda
//   d   : 1 2 3  → concat                                 → Atom（従来通り）
// 遅延にしているのは前方参照のため——定義行より前の行から参照されても、参照された
// その時点で解決すればよく、行順への依存が生まれない（Pass1aの「前方参照を含む全識別子の
// 構造型が確定する」という性質を壊さない）。
// 自己参照（`f : f`、相互参照する2つの定義）は解決中フラグで打ち切ってAtomに倒す
// ——このケースは元々値としても循環しており、Lambdaと見なす根拠が無い。
function resolveBindingCategory(binding, scope) {
  if (!binding || !binding.rhsTokens) return binding ? binding.category : "Atom";
  if (binding.__resolving) return "Atom";
  binding.__resolving = true;
  try {
    const node = reduceAll(binding.rhsTokens, scope);
    const category = getCategory(node, scope);
    binding.category = category;
    binding.rhsNode = node;
    if (category === "Lambda") {
      // アリティも右辺から引き継ぐ（`k : f` のエイリアスや `g : f 1` の部分適用が、
      // 残りの引数を受け取れる回数を正しく知るため）。consumedは既に適用済みの数。
      const info = resolveKnownArity(node, scope);
      if (info) {
        binding.arity = info.arity - info.consumed;
        binding.requiredArity = info.requiredArity - info.consumed;
      }
    }
    return category;
  } catch (e) {
    // 右辺が単独では縮約できない形（縮約器が例外を投げる形）だった場合は、
    // 従来通りAtomのまま扱う——ここは分類のための先読みであり、本番の縮約は
    // 定義行そのものを処理するときに改めて行われる（そこで出るべき例外はそこで出る）。
    return "Atom";
  } finally {
    binding.__resolving = false;
    binding.rhsTokens = null; // 解決済み（成否によらず一度きり）
  }
}

// 識別子ノードなら、その束縛の右辺ノード（resolveBindingCategoryがメモ化したもの）へ
// 置き換える。ポイントフリー判定（isBarePointfreeChainBase / isPointfreeLambda）が
// `add : [+]` のように名前を経由したポイントフリーも見抜けるようにするため。
function derefBoundNode(node, env) {
  if (!env || !node || node.type !== "atom" || node.kind !== "identifier") return node;
  const found = envLookupScope(env, node.value);
  if (!found) return node;
  resolveBindingCategory(found.binding, found.scope);
  return found.binding.rhsNode || node;
}

function unwrapSoloBlock(node) {
  while (node && node.type === "block" && node.kind !== "indent" && node.kind !== "abs" && node.lines.length === 1) {
    node = node.lines[0];
  }
  return node;
}

// ---- getCategory (coproduct_resolver.md §2) ----
// env: pass1.js が構築した識別子環境の連鎖（{bindings, parent}）。
// 未指定ならすべてAtom扱いにフォールバック。
// closed: この式が**カッコで閉じられている**か。閉じられていれば、既に requiredArity を
// 満たした適用はそこで値に確定する（デフォルト引数が埋まって呼び出しが発火する）。
// 閉じられていない裸の連鎖は、同じ式の中でさらに引数を取ってデフォルトを上書きできるため、
// arity（総スロット数）まで Lambda のままにしておく必要がある——`f 3 99` の 99 が
// デフォルト `b` を上書きする形がこれにあたる。
function getCategory(node, env, closed = false) {
  if (!node || typeof node !== "object") return "Atom";
  if (node.type === "operation") {
    if (node.op === "?") return "Lambda"; // 関数定義
    if (node.name === "compose") return "Lambda";
    if (node.partial) return "Lambda"; // オペランド不足の部分適用
    if (node.position === "prefix" && node.op === "@") return "Lambda"; // 前置@（Input）
    // `!__` は Id射（categorical_truth.md §6）＝呼び出せる恒等射なのでLambda。
    // これが無いと `!__ 5`（guide/operator_table.md 147行目の `__ 5 == !__ 5`）が
    // apply ではなく concat に解決されてしまう。`!<非Unit>` は `__` に落ちるのでAtomのまま。
    if (node.position === "prefix" && node.op === "!" && node.operand && node.operand.type === "atom" && node.operand.kind === "unit") return "Lambda";
    // 自動カリー化（markUndersaturatedApplies）が既にアリティ不足と静的判定して
    // リネーム済みのノード。定義上つねに「まだ引数を受け取れる」ため、無条件にLambda
    // （depthとarityの再チェックは不要——ここへ来る時点でpass2が既に判定済み）。
    if (node.name === "partial_apply") return "Lambda";
    if (node.name === "apply") {
      // 多引数関数（params[]が複数エントリ、pass1.jsのarity）は、1回のapplyでは
      // 飽和しない場合がある。左に伸びるapplyチェーンの深さ（=消費済みの引数の数）が
      // 呼び出し先のarityにまだ届いていなければ、まだ引数を受け取れるLambdaのまま
      // 扱う（次のAtomとの結合が construct ではなく apply になるように）。
      // アリティが不明（単一パラメータ・rest・ブラケット等）な場合は、従来通り
      // 1回の適用で即座にAtom（飽和済み）として扱う。
      const { depth, base } = applyChainInfo(node);
      // resolveKnownArityはbaseが素の識別子の場合だけでなく、丸括弧を挟んだ部分適用の
      // 結果（`(f 1) 2`のbase＝`(f 1)`という1行parenブロック）も透かして見る——
      // 自動カリー化が複数段の丸括弧を跨いでも正しくLambdaのまま扱われるように。
      const info = resolveKnownArity(base, env);
      // カッコで閉じられている場合だけ requiredArity で判定する。閉じた時点で
      // デフォルトが埋まって呼び出しが発火するため、結果は値（Atom）である。
      // これが無いと、デフォルトを持つ関数を必須引数だけで呼んだ括弧付きの式が
      // 「まだ引数を取れる Lambda」と誤判定され、`g (f 3)` が compose に化けたり
      // `(f 3) 99` が「Lambdaではない値を関数として適用」で落ちたりしていた。
      const limit = closed && typeof info?.requiredArity === "number" ? info.requiredArity : info?.arity;
      if (info && depth + info.consumed < limit) {
        return "Lambda";
      }
      // 【注意】ポイントフリー記述の完全に裸な中置演算子（`[+]`）が複数引数を貪欲に
      // 取り込む挙動は、ここ（getCategory）ではなくreduceOnceのPhase2（apply）専用の
      // 特例として実装している（isBarePointfreeChainBase参照）。ここで「常にLambda」に
      // してしまうと、Phase2で使い切った後のPhase3（apply_reverse）でも依然Lambdaと
      // 誤判定され、既に確定した計算結果（`[+](3)(4)`のような値）がまた関数として
      // 呼ばれようとしてしまう（`1 2 [+] 3 4`で実際に踏んだ）。apply連鎖は、名前付き
      // 識別子と同様に既知のarityが無い限り、1回の適用で即座にAtom（飽和済み）として
      // 扱うのが正しい——ポイントフリーの多引数消費はPhase2内で完結させる。
    }
    // 通常の演算ノード（算術・concat等）はAtom
    return "Atom";
  }
  if (node.type === "atom") {
    if (node.kind === "identifier") {
      if (env) {
        const found = envLookupScope(env, node.value);
        // 右辺のカテゴリがまだ未解決（pass1が `?` の有無だけで暫定的にAtomと置いた）なら
        // ここで解決する。解決済み・元からLambdaならそのまま返る。
        if (found !== null) return resolveBindingCategory(found.binding, found.scope);
      }
      // envに無い場合、組み込み関数名のみLambda扱い
      if (["<print>"].includes(node.value)) return "Lambda";
      return "Atom";
    }
    return "Atom";
  }
  if (node.type === "block") {
    // ポイントフリー記述（function_guide.md「任意のカッコで演算子を囲むことで関数として
    // 扱う」）: `[+]`はbracketブロック{lines:[partialノード1個]}という形になるため、
    // 中身を見ずに常にAtomを返すと外側の余積解決でLambdaとして扱われない。1行だけの
    // bracket系ブロック（indent/absを除く）は、中身のカテゴリをそのまま継承する
    // （`[1 2 3]`のような通常のListは中身がconstructでAtomのままなので影響なし）。
    if (node.kind !== "indent" && node.kind !== "abs" && node.lines.length === 1) {
      // カッコは**引数リストを閉じる**。中身が既に requiredArity を満たした適用なら、
      // そこで値に確定する（closed=true を渡してarityではなくrequiredArityで判定させる）。
      return getCategory(node.lines[0], env, true);
    }
    return "Atom";
  }
  return "Atom";
}

// identifierノードのenv上のBinding（{category, restParam}）を取得する。
// getCategoryと違い、Lambdaのrestパラメータ形状（coproduct_resolver.md §5.4）を
// 見るために生のBindingそのものが必要な箇所（coproductReduceのapply分岐）で使う。
function identifierBinding(node, env) {
  if (!env || !node || node.type !== "atom" || node.kind !== "identifier") return undefined;
  return envLookup(env, node.value);
}

// bの「List性」を判定する。素のブロック（[1 2 3]等）か、後置~でマークされたブロックかを見て、
// { isList, tilde } を返す（tilde=trueなら意図的な展開渡し、falseなら素の塊渡し）。
// §5.4の検査専用。isRealListValueを使い、`(col + 1)`のような単なるグルーピングの括弧を
// Listと誤判定しない（下のAtom-Atom分岐のpush/concat判定は従来通りisListLikeを直接使う
// ——あちらは「並置された両辺の構造をどう結合するか」の判断で、意味が異なる）。
function listShape(node) {
  if (isRealListValue(node)) return { isList: true, tilde: false };
  if (hasPostfixTilde(node) && isRealListValue(node.operand)) return { isList: true, tilde: true };
  return { isList: false, tilde: false };
}

function isListLike(node) {
  return node && node.type === "block" && (node.kind === "bracket" || node.kind === "brace" || node.kind === "paren");
}

// 中身がList値を構築する演算（余積・直積・範囲）かどうか。isRealListValueが使う。
const LIST_PRODUCING_NAMES = new Set([
  "construct", "concat", "push", "unshift", "product",
  "range", "range_arithmetic", "range_arithmetic_rev",
  "range_geometric", "range_geometric_rev", "range_power",
]);

// ブロックが「本当にList値」なのか、単なる式のグルーピングなのかを判定する。
// isListLikeは中身を一切見ずに括弧ブロックを全てList扱いするため、`(col + 1)` のような
// 優先順位のためだけの括弧までListと見なしてしまう。§5.4の検査（Listを後置~なしで
// 裸rest関数へ渡す誤用の拒否）にそれを使うと、正当な `f (a + 1)` が誤ってTypeErrorに
// なる（8-Queensをrestパラメータで書き直そうとして発覚）。
// 複数行のブロックはList/構造体リテラル、1行なら中身が余積/直積/範囲の構築演算である
// 場合のみList——単一のリテラル・識別子・算術式はスカラーのグルーピングに過ぎない。
function isRealListValue(node) {
  if (!isListLike(node)) return false;
  if (!Array.isArray(node.lines) || node.lines.length !== 1) return true;
  const inner = node.lines[0];
  if (!inner || inner.type !== "operation") return false;
  return LIST_PRODUCING_NAMES.has(inner.name);
}

function hasPostfixTilde(node) {
  return node && node.type === "operation" && node.op === "~" && node.position === "postfix";
}

function mk(name, left, right) {
  return { type: "operation", op: " ", name, position: "infix", left, right };
}

// coproduct_resolver.md §3の優先度表（10.5〜10.0）
function coproductReduce(a, b, env) {
  const catA = getCategory(a, env), catB = getCategory(b, env);
  if (catA === "Lambda" && catB === "Lambda") return mk("compose", a, b);
  if (catA === "Lambda" && catB === "Atom") {
    // coproduct_resolver.md §5.4: 裸のrestパラメータ（`x ~xs ? ...`）を持つLambdaに
    // 後置~なしでListを渡すのは、意図（各要素を位置引数に分配）と乖離した挙動
    // （list全体が単一のxに束縛されxsが空になる）になるため、TypeErrorで拒否する。
    // ブラケット形式（`[x ~xs] ? ...`）はrestParam==='bracket'であり対象外。
    const binding = identifierBinding(a, env);
    if (binding && binding.restParam === "bare") {
      const shape = listShape(b);
      if (shape.isList && !shape.tilde) {
        throw new TypeError(
          `coproduct_resolver.md §5.4違反: 裸のrestパラメータ ('${a.value} ~xs' 形式) を持つ関数に、List を後置 ~ なしで渡すことはできません（意図: 各要素を位置引数に分配するなら 後置~ を付けてください）`
        );
      }
    }
    return mk("apply", a, b);
  }
  if (catA === "Atom" && catB === "Lambda") return mk("apply_reverse", a, b);
  if (catA === "Atom" && catB === "Atom") {
    // 10.1/10.2 の判定には isRealListValue を使う（isListLike ではない）。
    // isListLike は中身を見ずに括弧ブロックを全て List 扱いするため、
    // `(col + 1)` のような優先順位のためだけの括弧まで List と誤認する。
    // その結果 `` `x` (`y`) `` が construct ではなく push に落ち、String 同士の
    // 連結（§3.2 の余積族）が起きずに2要素のリストになっていた——Sign で
    // 字句解析器を書こうとして発覚（`(s ' 0) (f (s ' 1~))` が文字列を連結せず
    // ペアを積み上げる）。§5.4 の検査では既に isRealListValue へ移行済みだったが、
    // ここだけ古い判定のまま残っていた。
    const listA = isRealListValue(a) || (hasPostfixTilde(a) && isRealListValue(a.operand));
    const listB = isRealListValue(b) || (hasPostfixTilde(b) && isRealListValue(b.operand));
    if (listA && listB) {
      const tA = hasPostfixTilde(a), tB = hasPostfixTilde(b);
      if (tA && tB) return mk("concat", a, b); // §5.2-1: 双方~ → concat
      // §5.2-2: ~なし → マージしない、独立したAtom（2つの参照のリスト）として保たれる。
      // list_model.md §2.2が明言する等価性「[1 2] [3 4] = 1 2 , 3 4」通り、product
      // （カンマ）と同じノードとして扱う——以前はnullを返して「そのまま未縮約で放置」
      // していたため、この2項だけが行全体だった場合にitems.length!==1のまま
      // unresolvedへ落ち、評価側で静かにUnitへ収束してしまっていた
      // （`[1 2 3] [1 2 3]`が2次元配列にならずUnitになるバグ）。
      return mk("product", a, b);
    }
    if ((listA && !listB) || (!listA && listB)) {
      // 10.1: Atom|List~ の組み合わせ → Unshift/push（仕様に方向の明記なし、上記コメント参照）
      return listB ? mk("push", a, b) : mk("unshift", a, b);
    }
    return mk("construct", a, b); // 10.0: Atom Atom → 直和/双積
  }
  return null;
}

// ---- Step2: 優先順位に基づく総当たり縮約（coproduct_resolver.md §4） ----
//
// coproduct_resolver.md §4は「10.5(compose)→10.4(apply)→10.3(apply_reverse)→10.2〜10.0
// (concat/push/unshift/construct)の順に、各優先度をリスト全体に対して使い尽くしてから
// 次へ進む」という段階的マルチパスを規定している。以前はtier===10をひとまとめにし、
// 隣接ペアを左から見て最初にマッチしたものを即座に縮約する単一グリーディスキャンに
// なっていたため、この優先順位が守られていなかった（例: `5 inc 3` で本来10.4(apply)が
// 先に `inc 3` を縮約すべきところ、実際は左端の `5 inc` が10.3(apply_reverse)として
// 先に縮約されてしまっていた）。COPRODUCT_PHASESで4段階に明示的に分割し、各段階を
// 使い尽くしてから次へ進むことで仕様通りの優先順位を保証する。
//
// これにより、apply_reverse（UFCS的な `receiver method` 記法、`f : [foo bar ~this] ? ...`
// のようなオブジェクト指向的呼び出しを意図）は「そのLambdaが右側に通常適用できるAtomを
// 持たない場合のみ」発動するフォールバックになる——両隣にAtomがあるLambdaは常にapply
// （右のAtomへの通常適用）が先に確定するため、apply_reverseが途中のAtomを横取りすることはない。
// concat/push/unshift/constructの3つ（10.2〜10.0）はcoproductReduce内部でリスト形状のみから
// 相互排他的に決まり、tier間の競合が無いため、引き続き1フェーズにまとめている。
// ポイントフリー記述で「複数の実引数を貪欲に消費し続けるべき」apply連鎖の根本（base）
// かどうかを判定する。対象は2パターン: (1) 完全に裸な中置演算子（`[+]`、left/right両方
// null、function_guide.md「複数の引数を貪欲に演算する」）、(2) 末尾カンマの写像糖衣構文
// （`[* 2,]`、pointfreeMap、function_guide.md「そのすべてに適用される」——`[* 2,] 1 2 3
// 4 5`のように複数の位置引数へ写像する場合、そのすべてをapply連鎖で集めきる必要がある）。
// `[+]`のようにbracketブロックでラップされたまま渡ってくる場合はunwrapSoloBlockで
// 中身を覗く。Phase2（apply）専用の特例判定にのみ使う——getCategory本体には反映しない
// （下記COPRODUCT_PHASESのコメント参照）。
function isBarePointfreeChainBase(node, env) {
  const { base } = applyChainInfo(node);
  return isGreedyPointfree(base, env);
}

// 「複数の実引数を貪欲に消費し続けるべき」ポイントフリーかどうか。
// `add : [+]` のように名前を経由していても同じ判定が要る（type_system.md §6.1の
// `#add : [+]` → `add 1 2` = 3）ため、束縛の右辺ノードまで透かして見る。
function isGreedyPointfree(node, env) {
  const unwrapped = unwrapSoloBlock(derefBoundNode(unwrapSoloBlock(node), env));
  if (!unwrapped || unwrapped.type !== "operation") return false;
  // 合成（`f g`）は左→右のパイプライン順（`(f g)(x) = g(f(x))`）なので、実引数は
  // **左の関数**へ渡る。左が貪欲なポイントフリーなら合成全体も貪欲でなければならない。
  // これが無いと `[* 2,] [+] 1 2 3 4 5` が、合成へ引数を1個だけ渡して残りを
  // concat してしまう（`[2 2 3 4 5]`）。
  if (unwrapped.name === "compose") return isGreedyPointfree(unwrapped.left, env);
  if (!unwrapped.partial) return false;
  return unwrapped.pointfreeMap === true || (unwrapped.left === null && unwrapped.right === null);
}

// ポイントフリー記述由来のLambda（`[+]`のような裸の演算子、`[+ 1]`のような部分適用、
// およびそのapply連鎖）かどうかを判定する。演算子の種類（算術・比較・前置・後置いずれも
// ポイントフリー記述できる、function_guide.md）を問わず一律で判定する。
function isPointfreeLambda(node, env) {
  const unwrapped = unwrapSoloBlock(derefBoundNode(unwrapSoloBlock(node), env));
  if (!unwrapped || unwrapped.type !== "operation") return false;
  if (unwrapped.partial) return true;
  if (unwrapped.name === "apply") {
    const { base } = applyChainInfo(unwrapped);
    const unwrappedBase = unwrapSoloBlock(derefBoundNode(unwrapSoloBlock(base), env));
    return !!(unwrappedBase && unwrappedBase.type === "operation" && unwrappedBase.partial);
  }
  return false;
}

const COPRODUCT_PHASES = [
  { match: (catA, catB) => catA === "Lambda" && catB === "Lambda" }, // 10.5: compose
  {
    match: (catA, catB) => catA === "Lambda" && catB === "Atom",
    // ポイントフリー記述の完全に裸な中置演算子（`[+]`）は「複数の引数を貪欲に演算する」
    // （function_guide.md）——getCategoryでは通常のarity判定と同様1回の適用で即座に
    // Atom（飽和済み）として扱うが、Phase2（apply）だけはこの特例で「まだ右にAtomが
    // あれば貪欲に食う」を許可する。これをgetCategory本体に持ち込むと、Phase2で使い
    // 切った後のPhase3（apply_reverse）でも依然Lambdaと誤判定され、既に確定した計算
    // 結果（`[+](3)(4)`）がまた関数として呼ばれようとしてしまう（`1 2 [+] 3 4`で実際に
    // 踏んだバグ）。Phase2内だけで完結させることで、Phase2が尽きた時点（＝これ以上
    // 右にAtomが無い時点）で自然にAtomへ確定する。
    extendPointfree: true,
  }, // 10.4: apply
  {
    // 10.3: apply_reverse。ポイントフリー由来のLambda（`[+]`/`[+ 1]`等、演算子の種類を
    // 問わない）はapply_reverseの対象から除外する（8/5の設計合意）。ポイントフリーは
    // 常に前置適用（`[+ 1] 5`）という一つの呼び出し方だけを持ち、UFCS的なreceiver記法
    // （`x f`）という別経路を重ねない——「一つのことを表現する方法は一つ」の方針、かつ
    // `5 [+]`のような曖昧な読み（5をどちら側の被演算子とみなすか不定）を防ぐ。
    match: (catA, catB, a, b, env) => catA === "Atom" && catB === "Lambda" && !isPointfreeLambda(b, env),
  },
  { match: (catA, catB) => catA === "Atom" && catB === "Atom" }, // 10.2〜10.0: concat/push/unshift/construct
];

// 連鎖比較（comparison.md §4）の対象となる比較演算子（tier12）。構造比較の
// `==`/`!==`（tier8）は §2.1 が明示的にこの規則の適用外としているため含めない。
const CHAIN_COMPARE_OPS = new Set(["<", "<=", "=", ">=", ">", "!="]);

function reduceOnce(items, tier, env, phase) {
  for (let i = 0; i < items.length - 1; i++) {
    const a = items[i];
    const b = items[i + 1];
    if (isBareOperatorToken(b)) {
      const entry = lookup(b, "infix");
      if (entry && entry.precedence === tier && i + 2 < items.length && !isBareOperatorToken(items[i + 2])) {
        // 三項連鎖比較（comparison.md §4）。`L < C < R` は二項の左結合
        // （`(L < C) < R`）ではなく、パース段階で単一のノードへまとめる——左結合だと
        // 「左辺が算術単位元(0/1)なら右辺」という§2.1の規則を1段目が食ってしまい、
        // 中央の項が返らない（`5 < 7 < 10` が 7 ではなく 5 になる）。
        // ここ（tier12の縮約時点）は、より高い優先順位の演算子が既にノードへ畳まれ、
        // より低い優先順位の演算子（`&`等）はまだ裸のトークンのまま残っている段階なので、
        // 「隣り合う2つの比較演算子」＝連鎖、で正しく判定できる（`x < 3 & y > 4` の
        // `<` と `>` は間に `&` を挟むため隣り合わず、連鎖と誤認しない）。
        const op2 = items[i + 3];
        if (CHAIN_COMPARE_OPS.has(b) && typeof op2 === "string" && CHAIN_COMPARE_OPS.has(op2)) {
          // §4.1「同一の比較演算子の連鎖のみが許容」（`A < B > C` は構文エラー）。
          if (op2 !== b) {
            throw new SyntaxError(`comparison.md §4.1違反: 連鎖比較は同一の比較演算子のみ許容されます（'${b}' と '${op2}' が混在）`);
          }
          if (i + 4 >= items.length || isBareOperatorToken(items[i + 4])) {
            throw new SyntaxError(`連鎖比較 '${b}' の右辺がありません`);
          }
          if (typeof items[i + 5] === "string" && CHAIN_COMPARE_OPS.has(items[i + 5])) {
            throw new SyntaxError(`comparison.md §4は三項までの連鎖比較（L ${b} C ${b} R）を定義しています（4項以上は未定義）`);
          }
          const node = {
            type: "operation",
            op: b,
            name: "chain_compare",
            compareName: entry.name,
            position: "infix",
            left: toNode(a, env),
            middle: toNode(items[i + 2], env),
            right: toNode(items[i + 4], env),
          };
          items.splice(i, 5, node);
          return true;
        }
        const left = toNode(a, env);
        const right = toNode(items[i + 2], env);
        const node = { type: "operation", op: b, name: entry.name, position: "infix", left, right };
        items.splice(i, 3, node);
        return true;
      }
      continue;
    }
    if (tier === 10 && !isBareOperatorToken(a) && !isBareOperatorToken(b)) {
      const left = toNode(a, env);
      const right = toNode(b, env);
      const catA = getCategory(left, env), catB = getCategory(right, env);
      if (phase && phase.extendPointfree && catB === "Atom" && isBarePointfreeChainBase(left, env)) {
        items.splice(i, 2, mk("apply", left, right));
        return true;
      }
      if (phase && !phase.match(catA, catB, left, right, env)) continue;
      const node = coproductReduce(left, right, env);
      if (node) {
        items.splice(i, 2, node);
        return true;
      }
    }
  }
  return false;
}

// ---- Lambda定義行（トップレベルに `?` を持つ行）の専用処理 ----
//
// `:`(define, precedence=1)と`?`(lambda, precedence=2)は演算子テーブル上もっとも低い
// 優先度で、reduceAllは26→1の順で処理するため、この2つは総当たり縮約の最後の最後に
// しか処理されない。一方スペース(余積)はtier=10で固定的に先に処理される。
// そのため、仮引数部をそのまま総当たり縮約に素通しすると、`?`が実際に処理される
// 「前」に、仮引数部の中身が既存の汎用ルールで誤って確定してしまう
// （例: `g x` → construct[g,x]、`y : x + 1` → define[y, add[x,1]]、
//   どちらも「仮引数の宣言」であって「値の式」ではないのに、区別なく解決されてしまう）。
// これを避けるため、行の中にトップレベルの `?` があれば、総当たり縮約に渡す前に
// 仮引数部を切り出し、buildParameterList で専用に処理する。

function isIdentifierToken(x) {
  return typeof x === "string" && x.startsWith("<") && x.endsWith(">");
}

// ブラケット／インデントブロックの仮引数部の「1行」を解析する。1行が常に1エントリとは
// 限らない——`[x ~xs]`のように、デフォルトを持たない複数の裸パラメータが1行に同居する
// ケースがあるため、配列（複数エントリ）を返す。
//   ["<y>", ":", "<x>", "+", "1"] → [{ name: "<y>", rest: false, defaultTokens: ["<x>","+","1"] }]
//   ["<x>"]                       → [{ name: "<x>", rest: false, defaultTokens: null }]
//   ["<x>", "~_", "<xs>"]         → [{name:"<x>",...}, { name: "<xs>", rest: true, defaultTokens: null }]
function parseParamLine(tokens) {
  const colonIdx = tokens.indexOf(":");
  if (colonIdx !== -1) {
    // "name : defaultExpr..." という1エントリ（rest付きデフォルトは現行仕様に例が無く未対応）
    return [{ name: tokens[0], rest: false, defaultTokens: tokens.slice(colonIdx + 1) }];
  }
  // ":" が無ければ、裸の複数パラメータが1行に並んでいる可能性がある（例: "x ~xs"）
  return splitBareParamTokens(tokens);
}

// ブラケット（[x ~xs]等）／インデントブロック（デフォルト引数）の仮引数部から、
// 「1行=1エントリ」の行配列を取り出す。resolveBlockのkind判定と対称。
function extractParamLines(token) {
  if (Array.isArray(token) && token[0] === '"INDENT_"') return token[1];
  if (Array.isArray(token) && token[0] === '"ABS_"') return token[1];
  return token; // bracket系: tokenそのものがexprs（行の配列）
}

function isTaggedBlock(x) {
  return Array.isArray(x) && (x[0] === '"INDENT_"' || x[0] === '"ABS_"');
}
function isFlatTokenLine(x) {
  return Array.isArray(x) && x.every((t) => typeof t === "string");
}

// extractParamLinesが返す「文の並び」を、1文=1識別子宣言の生トークン列（flat token line）の
// 配列へ正規化する。grammarのTerm規則（配列coreを持つ単独の項は1階層ラップされる）により、
// 仮引数部がインデントブロックの中に単独のブラケット（例: function_guide.mdのfunc_mixed、
// `[`を定義行より深くインデントして書く形式）を1文として含む場合、その1文はさらに
// 「本来のブラケットのExpressions（複数の実パラメータ行）」を1階層ラップした形で現れる。
// 再帰的にラップを剥がして、最終的に全ての要素がflat token lineになるまで平坦化する。
function flattenParamStatements(node) {
  if (isFlatTokenLine(node)) return [node];
  return node.flatMap((stmt) => {
    if (isFlatTokenLine(stmt)) return [stmt];
    if (isTaggedBlock(stmt)) return flattenParamStatements(stmt[1]);
    // 文字列以外の要素を含む配列 = さらに複数文（またはラップされた1文）としてネストしている
    return flattenParamStatements(stmt);
  });
}

// tokenが「複数の裸パラメータの中の1エントリとして書かれたブラケット分割代入パターン」
// （例: `dist [h ~t]`の`[h ~t]`、`walk :\n\tdist\n\t[h ~t]\n ?`の`[h ~t]`行）かどうかを判定し、
// そうであれば中身（flat token lineの配列＝そのブラケット自身の各行）を返す。そうでなければnull。
// isBracketParamListと同じTerm-wrap剥がしロジックだが、対象が「パラメータリスト全体」では
// なく「その中の1エントリ」である点が異なる（剥がす前の段階でTerm-wrapが1段少ないため、
// 剥がし回数は0回で済むこともある——単一行`dist [h ~t]`の場合がそれ）。
function peelBracketEntryToken(token) {
  if (!Array.isArray(token)) return null;
  let cur = token;
  while (Array.isArray(cur) && cur.length === 1 && Array.isArray(cur[0]) && !isFlatTokenLine(cur[0]) && !isTaggedBlock(cur[0])) {
    cur = cur[0];
  }
  if (Array.isArray(cur) && cur.length >= 1 && cur.every((line) => isFlatTokenLine(line) || isTaggedBlock(line))) {
    return cur;
  }
  return null;
}

// peelBracketEntryTokenが返した「ブラケットの中身の各行」から、そのブラケット自身の
// サブエントリ列（[x ~xs]と同じ形の{name,rest,defaultTokens}配列）を作る。
function parseBracketSubEntries(lines) {
  return flattenParamStatements(lines).flatMap(parseParamLine);
}

// extractParamLinesが返す「文の並び」を、1文=1エントリに変換する。flattenParamStatements
// と違い、ブラケット分割代入パターン（peelBracketEntryTokenで判定できる文）に出会ったら
// それ以上剥がさず、{name:null, pattern:[...]}という1個のネストしたエントリとして扱う
// （他の裸パラメータと混在する1エントリとしてのブラケット分割代入、list_model.md §2.4/2.5の
// 「1個の実引数をブラケットへ分割代入する」パターンを、複数パラメータの中の1個の位置にも
// 一般化したもの）。
function parseParamStatements(lines) {
  if (isFlatTokenLine(lines)) return parseParamLine(lines);
  return lines.flatMap((stmt) => {
    if (isFlatTokenLine(stmt)) return parseParamLine(stmt);
    if (isTaggedBlock(stmt)) return parseParamStatements(stmt[1]);
    const bracketLines = peelBracketEntryToken(stmt);
    if (bracketLines) {
      return [{ name: null, pattern: parseBracketSubEntries(bracketLines), rest: false, defaultTokens: null }];
    }
    return parseParamStatements(stmt);
  });
}

// 裸の（ブラケット／インデントで囲まれていない）仮引数トークン列を、1識別子=1エントリに分割する。
// デフォルト式は裸形式では**仕様違反**のため非対応（bracket/indent形式のみ対応）。
// デフォルト引数を書くときは必ずインデントブロック形式にする:
//   f :
//       x
//       y : __
//    ? ...
// 個々のトークンがさらに配列（`dist [h ~t]`の`[h ~t]`のような、1エントリとしてのブラケット
// 分割代入パターン）の場合は、ブラケット自身のサブエントリ列を持つ1個のパターンエントリにする。
function splitBareParamTokens(tokens) {
  const entries = [];
  let i = 0;
  while (i < tokens.length) {
    if (tokens[i] === "~_") {
      entries.push({ name: tokens[i + 1], rest: true, defaultTokens: null });
      i += 2;
    } else if (Array.isArray(tokens[i])) {
      const bracketLines = peelBracketEntryToken(tokens[i]);
      if (bracketLines) {
        entries.push({ name: null, pattern: parseBracketSubEntries(bracketLines), rest: false, defaultTokens: null });
      }
      i += 1;
    } else {
      entries.push({ name: tokens[i], rest: false, defaultTokens: null });
      i += 1;
    }
  }
  return entries;
}

// paramTokens[0]（`[x ~xs]`のような単一要素）が、真の意味でのブラケット仮引数リスト
// （list_model.md §2.4のEagerパターン、実引数を分割代入で受け取る）か、単に複数行に
// またがって書かれた裸のデフォルト引数形式（`g:\n x\n y:x+1\n?...`）かを判定する。
// どちらも生トークンの形はINDENT_タグの有無だけでは区別しきれない——func_mixed
// （function_guide.md）のようにブラケットが定義行より深くインデントされて単独の1文として
// 書かれると、grammarのTerm規則で1階層余分にラップされ、外側だけ見るとINDENT_タグ付きに
// 見えてしまうため（README「Lambda仮引数部の専用処理」参照）。
// 判定方法: INDENT_/ABS_タグが無ければ直接ブラケット。タグ付きなら、その中身が
// 「唯一の要素で、かつさらに入れ子になった（flat token lineでもタグ付きでもない）配列」で
// ある限り再帰的に剥がしていき（flattenParamStatementsと同じTerm-wrap剥がしロジック）、
// 実際に1回でも剥がせて、かつ最終的に「複数のflat token line（＝ブラケットの各行）」に
// 行き着いた場合のみブラケットとみなす。単に「1個の裸パラメータだけがインデントブロックに
// 単独で書かれている」ケース（それ自体がflat token line）や、「複数の裸パラメータ行が
// 直接並んでいる」通常のデフォルト引数形式は、どちらもfalseになる。
function isBracketParamList(token) {
  if (!Array.isArray(token)) return false;
  if (!isTaggedBlock(token)) return true;
  let inner = token[1];
  let peeled = false;
  while (Array.isArray(inner) && inner.length === 1 && Array.isArray(inner[0]) && !isFlatTokenLine(inner[0]) && !isTaggedBlock(inner[0])) {
    inner = inner[0];
    peeled = true;
  }
  return peeled && Array.isArray(inner) && inner.length >= 1 && inner.every((line) => isFlatTokenLine(line) || isTaggedBlock(line));
}

// 仮引数部の生トークン列を解析し、{ node, scope } を返す。
// scope は let* 的な逐次束縛（自分より前のパラメータ + 外側スコープのみ参照可能）を
// 反映した子スコープで、後続のデフォルト式・関数本体の両方から使われる。
function buildParameterList(paramTokens, env) {
  // 単一の裸パラメータ（デフォルト・rest無し）は既存挙動をそのまま保つ
  // （identifierノード1つを返す。9/9テスト等、既存の出力形状との後方互換のため）。
  if (paramTokens.length === 1 && isIdentifierToken(paramTokens[0])) {
    const name = paramTokens[0];
    const scope = bindEnv([name], env);
    return { node: toNode(name, scope), scope };
  }
  if (paramTokens.length === 0) {
    return { node: null, scope: env };
  }

  let rawEntries;
  let isBracket = false;
  if (paramTokens.length === 1 && Array.isArray(paramTokens[0])) {
    // ブラケット([x ~xs])形式、またはインデントブロック（デフォルト引数）形式
    isBracket = isBracketParamList(paramTokens[0]);
    const paramLines = extractParamLines(paramTokens[0]);
    // isBracket（パラメータリスト全体が1個のブラケット）の場合はそのブラケット自身の
    // 各行をそのまま完全に平坦化する（従来通り）。isBracket=falseの複数行デフォルト引数
    // 形式では、途中に混在するブラケット分割代入パターン（1エントリとしての`[h ~t]`）を
    // 平坦化で潰さないよう、parseParamStatementsを使う。
    rawEntries = isBracket ? flattenParamStatements(paramLines).flatMap(parseParamLine) : parseParamStatements(paramLines);
  } else {
    // 裸の空白区切り形式（例: g x, x ~xs, dist [h ~t]）
    rawEntries = splitBareParamTokens(paramTokens);
  }

  const allNames = new Set(rawEntries.map((e) => e.name));
  const boundSoFar = new Set();
  let scope = env;
  const entries = [];
  for (const raw of rawEntries) {
    if (raw.pattern) {
      // 混在パラメータ内のブラケット分割代入エントリ（例: `dist [h ~t]`の`[h ~t]`）。
      // 名前を持たず、対応する1個の実引数をpattern（サブエントリ列）へ分割代入する
      // （interpreter.jsのbindParams参照）。デフォルトは現行未対応。
      entries.push({ name: null, pattern: raw.pattern, rest: false, default: null });
      // パターン内の各サブエントリ名も、後続パラメータのデフォルト式から参照できるよう
      // スコープへ加える（let*的な逐次スコープの一貫性のため）。
      const patternNames = raw.pattern.map((e) => e.name).filter((n) => typeof n === "string");
      if (patternNames.length > 0) scope = bindEnv(patternNames, scope);
      continue;
    }
    if (raw.defaultTokens) {
      // let*的な逐次スコープの強制: デフォルト式は自分より前に束縛済みのパラメータのみ
      // 参照できる。同一パラメータリスト内の「まだ束縛されていない」識別子
      // （自分自身、または後ろのパラメータ）への参照は前方参照としてエラーにする
      // （7月30日の設計スレッドが意図した「通常の未定義識別子エラーとしてPass1で弾ける」）。
      checkNoForwardReference(raw.defaultTokens, raw.name, allNames, boundSoFar);
    }
    // デフォルト式は「自分より前に束縛済みのパラメータ」+外側スコープのみ参照できる（let*）。
    const defaultNode = raw.defaultTokens ? reduceAll(raw.defaultTokens, scope) : null;
    entries.push({ name: raw.name, rest: raw.rest, default: defaultNode });
    scope = bindEnv([raw.name], scope); // このパラメータ自身を、次のパラメータ以降から見えるようにする
    boundSoFar.add(raw.name);
  }
  // デフォルトを持つ仮引数は、実際の評価（未実装）ではアリティ計算から除外される
  // （function_guide.md「関数適用時」節）。値の評価をしなくても構造だけから機械的に
  // 求まる部分として、実質アリティ（デフォルト・rest以外の仮引数の数）だけ先に持たせておく。
  const requiredArity = entries.filter((e) => !e.rest && e.default === null).length;
  // bracket: true の場合、interpreter.js の bindParams は「呼び出し側が渡した単一の
  // List/Struct実引数を、この仮引数リストへ分割代入する」という別経路（Eagerパターン、
  // list_model.md §2.4）を通る。裸の複数行デフォルト引数形式（isBracketParamList参照）
  // ではfalseのままで、既存の位置引数ストリーム的な束縛（stream/pull型）を維持する。
  return { node: { type: "params", entries, requiredArity, bracket: isBracket }, scope };
}

// 同一パラメータリスト内で、まだ束縛されていない識別子（自分自身 or 後ろのパラメータ）への
// 前方参照を検出する。tokens は defaultTokens の生トークン列（ネストした配列も再帰的に見る）。
function checkNoForwardReference(tokens, paramName, allNames, boundSoFar) {
  for (const t of tokens) {
    if (Array.isArray(t)) {
      checkNoForwardReference(t, paramName, allNames, boundSoFar);
      continue;
    }
    if (isIdentifierToken(t) && allNames.has(t) && !boundSoFar.has(t)) {
      throw new ReferenceError(
        `パラメータ '${paramName}' のデフォルト式が、まだ束縛されていない識別子 '${t}' を参照しています（let*的な逐次スコープでは、自分より前に宣言されたパラメータのみ参照できます）`
      );
    }
  }
}

function resolveLambdaLine(rawItems, qIdx, env) {
  // 先頭が前置export記号（#/##/###）なら、その分だけ識別子の位置をずらす
  // （pass1.jsのbuildEnvScopeと対称。例: `##f : x ? x + 1` → ["##_","<f>",":",...]）。
  let idx = 0;
  let exported = null;
  if (typeof rawItems[0] === "string" && EXPORT_MARKERS[rawItems[0]]) {
    exported = EXPORT_MARKERS[rawItems[0]];
    idx = 1;
  }

  let nameToken = null;
  let paramsStart = idx;
  if (isIdentifierToken(rawItems[idx]) && rawItems[idx + 1] === ":") {
    nameToken = rawItems[idx];
    paramsStart = idx + 2;
  }
  const paramTokens = rawItems.slice(paramsStart, qIdx);
  const bodyTokens = rawItems.slice(qIdx + 1);

  const { node: paramNode, scope } = buildParameterList(paramTokens, env);
  const bodyNode = reduceAll(bodyTokens, scope);
  // 関数本体のインデントブロックは match_case の連鎖である（function_guide.md）。
  // 同じ `識別子 : 値` という行が、本体では「条件が真なら右辺」、カッコの中では
  // 「構造体のフィールド」を意味する——境界はカッコであって、ブロックの見た目ではない。
  // 印を付けておかないと評価器から区別できず、本体の `ready : send` が条件分岐ではなく
  // ready の再束縛になってしまう（仮引数を条件にできない）。
  // 定義の右辺のインデントブロック（`link :` 直下の設定宣言など）はラムダ本体では
  // ないため、この印が付かず従来通り構造体になれる。
  if (bodyNode && bodyNode.type === "block" && bodyNode.kind === "indent") bodyNode.isFunctionBody = true;
  // scope（仮引数を束縛した子スコープ）をノードへ残す。resolveBlockと同じ理由——
  // 本体を後から歩く側が、仮引数を「未定義識別子」と誤検出しないようにするため。
  const lambdaNode = { type: "operation", op: "?", name: "lambda", position: "infix", left: paramNode, right: bodyNode, scope };

  if (nameToken) {
    return { type: "operation", op: ":", name: "define", position: "infix", left: toNode(nameToken, env), right: lambdaNode, exported };
  }
  return lambdaNode;
}

function reduceAll(rawItems, env) {
  // ラムダ定義行（トップレベルに `?` を持つ行）は、仮引数部が総当たり縮約に誤って
  // 素通しされないよう、先に専用ロジックへ分岐する（上記コメント参照）。
  const qIdx = rawItems.indexOf("?");
  if (qIdx !== -1) {
    return resolveLambdaLine(rawItems, qIdx, env);
  }

  // 前置export記号つきの「非ラムダ」定義行（`#pi : 3`、`#add : [+]`）。ラムダ定義行は
  // resolveLambdaLineが記号を剥がして define.exported に畳んでいたが、こちらは総当たり
  // 縮約に素通しされ `define(export_internal(<pi>), 3)` という形になっていた——
  // interpreter.jsのdefineはleftを識別子atomと決め打ちして`node.left.value`を読むため、
  // 名前がundefinedのまま束縛され「定義したのに未定義」という状態になっていた
  // （type_system.md §6.1の`#add : [+]`がまさにこの形）。ラムダ側と同じく、ここで
  // 記号を剥がして exported として畳み、defineノードの形をラムダ/非ラムダで揃える。
  if (typeof rawItems[0] === "string" && EXPORT_MARKERS[rawItems[0]] && isIdentifierToken(rawItems[1]) && rawItems[2] === ":") {
    const node = reduceAll(rawItems.slice(1), env);
    if (node && node.type === "operation" && node.name === "define") node.exported = EXPORT_MARKERS[rawItems[0]];
    return node;
  }

  // 【意図的に対応しない】カンマと`:`を1行に混在させる形（例: `foo : 1, bar : 2`）は、
  // `:`(precedence=1)が`,`(precedence=8)より優先度が低いことに起因して総当たり縮約が
  // 誤って隣接トークンを結合してしまう。一時期トップレベルの","を先に分割する回避策を
  // 入れたが、この書き方自体がlist_model.md/pattern_guide.mdの構造体リテラル例（すべて
  // 改行区切り）のどこにも登場しない、こちらで作った未定義入力への対症療法だったため
  // 撤去した。「一つのことを表現する方法は一つ」という方針により、構造体は改行区切りの
  // 形だけをサポートする（`pass3.js`のinferAtomTypeも改行区切りの形のみ判定）。

  // 演算子トークン（裸の記号文字列）は reduceOnce の走査で判定する必要があるため、
  // ここでは atom/block のみを変換し、演算子文字列はそのまま残す。
  let items = resolveDensity(rawItems, env).map((x) => (isBareOperatorToken(x) ? x : toNode(x, env)));
  // tier 26(escape) から 1(export) まで、高い方から低い方へ処理
  for (let tier = 26; tier >= 1; tier--) {
    let guard = 0;
    if (tier === 10) {
      // coproduct_resolver.md §4: compose→apply→apply_reverse→concat/push/constructの
      // 4段階を、それぞれ使い尽くしてから次へ進む（COPRODUCT_PHASES参照）。
      for (const phase of COPRODUCT_PHASES) {
        while (reduceOnce(items, tier, env, phase)) {
          if (++guard > 10000) throw new Error("reduceAll: possible infinite loop at tier " + tier);
        }
      }
      continue;
    }
    while (reduceOnce(items, tier, env)) {
      if (++guard > 10000) throw new Error("reduceAll: possible infinite loop at tier " + tier);
    }
  }
  // ポイントフリー記述（function_guide.md「ポイントフリー記述」）: 総当たり縮約後も
  // 縮約しきれず残った「裸の中置演算子トークン単体」（例: `[+]`）、または「裸の中置演算子
  // トークン＋右オペランド1個・左オペランド無し」（例: `[+ 1]`）は、部分適用の
  // Lambdaとして扱う。reduceOnceの汎用中置演算子マッチは「オペランド 演算子 オペランド」
  // の並び（items[i]=左辺, items[i+1]=演算子, items[i+2]=右辺）しか見ないため、演算子が
  // 列の先頭に来るこの形は総当たり縮約の対象外のまま残る——ここで拾ってpartialノードに
  // 変換する。getCategoryの既存ルール（`if (node.partial) return "Lambda"`）でLambdaに
  // 分類される。
  if (items.length === 1 && typeof items[0] === "string" && isPartialCapableOperator(items[0])) {
    const entry = lookup(items[0], "infix");
    if (entry) return { type: "operation", op: items[0], name: entry.name, position: "infix", partial: true, left: null, right: null };
  }
  if (items.length === 2 && typeof items[0] === "string" && isPartialCapableOperator(items[0])) {
    const entry = lookup(items[0], "infix");
    if (entry) return { type: "operation", op: items[0], name: entry.name, position: "infix", partial: true, left: null, right: items[1] };
  }
  // 左辺束縛（`[1 -]` = `x ? 1 - x`）。上の右辺束縛（`[- 1]` = `x ? x - 1`）と対称で、
  // 非可換な演算子（`-` `/` `'` 等）では両方が必要になる——位置形が片側しか無いと、
  // もう片方はホール（`[1 - _]`）でしか書けず、同じ概念に2つの書き方が生まれてしまう。
  //
  // 曖昧さは空白の規則が既に消している（operator_table.md 基本原則）。後置演算子は
  // 対象値に密着していなければならないため、`[5!]` は後置の階乗（完成した式）、
  // `[5 !]` は中置として読まれる。`!` に中置の定義は無いので後者はここで拾われず
  // unresolved のまま残る——`x ! y` という中置が存在しない以上それが正しい。
  // 後置と中置を兼ねる `~` `@` も同じ規則で分かれる。
  if (items.length === 2 && typeof items[1] === "string" && isPartialCapableOperator(items[1])) {
    const entry = lookup(items[1], "infix");
    if (entry) return { type: "operation", op: items[1], name: entry.name, position: "infix", partial: true, left: items[0], right: null };
  }
  // 末尾カンマによる写像糖衣構文（function_guide.md「単項式の後ろに`,`を付けたポイント
  // フリー記述は、そのすべてに適用される」、例: `[* 2,]`）。「演算子＋右オペランド1個＋
  // 末尾の裸カンマ」という形（`,`自体は右にオペランドが無いため通常のproduct縮約が
  // 素通りする）を拾い、pointfreeMapフラグを立てる。
  if (
    items.length === 3 &&
    typeof items[0] === "string" &&
    isPartialCapableOperator(items[0]) &&
    items[2] === ","
  ) {
    const entry = lookup(items[0], "infix");
    if (entry) return { type: "operation", op: items[0], name: entry.name, position: "infix", partial: true, left: null, right: items[1], pointfreeMap: true };
  }

  if (items.length !== 1) {
    // 未縮約の要素が残っている（未対応の演算子等）。診断のためそのまま返す。
    return { type: "unresolved", items };
  }
  // 字句として書かれた `_` はここでラムダへ静的脱糖する（hole_desugaring.md）。
  // ラムダ定義行（上の qIdx 分岐）は本体が内側の reduceAll を通るため、ここには来ない。
  return desugarHoles(markUndersaturatedApplies(items[0], env), env);
}

// --- 部分適用のホール（`_`）の静的脱糖（hole_desugaring.md） ---
//
// 字句として直接書かれた `_` は「まだ値の決まっていない引数スロット」であり、
// コンパイル時にラムダへ変換する。実行時に流通する `__`（Unit）とは別物である
// ——動的な計算の結果 Unit になった値が部分適用を誘発しないよう、両者は分離されている
// （`g 1 (3 < 2)` は部分適用ではなくデフォルト引数へのフォールバックになる）。
//
// **作用域はカッコで区切られる。** ブロックの各行は resolveBlock → reduceAll を通るため、
// ブロック内のホールはその行のレベルで包まれ、外側へは漏れない。
//
//   `[_ ' 0] [3 , 4]`  ホールはブロックの中 → `[$p0 ? $p0 ' 0] [3 , 4]`  → 3
//   `[+] _ _ 3 4 5`    ホールはブロックの外 → `$p0 $p1 ? [+] $p0 $p1 3 4 5`
//   `h : g _ 5`        定義行は右辺だけを包む → `h : $p0 ? g $p0 5`
function isHoleNode(n) {
  return !!n && n.type === "atom" && n.kind === "hole";
}

// ホールを見つけて生成識別子へ置き換え、その名前を names へ左から順に積む。
// ブロックの中へは降りない——各ブロックが自分の行で処理済みだからである。
// `partial` が立ったノード（`[!_]` のようなポイントフリーの前置/後置）も対象外で、
// そちらは既にポイントフリーの機構が「引数待ち」として扱っている。
// 空白（適用・構造構築）とカンマは「引数や要素が並ぶ位置」なので、そこへ置かれた `_` は
// 引数のプレースホルダとして正しい（`add _ 10`、`t 1 _ 3`）。それ以外の中置演算子は、
// 欠けている側を**位置で**示せる——右辺を束縛するなら `[OP c]`、左辺なら `[c OP]`。
// したがって `[_ ' 0]` や `[1 - _]` はホールを使う理由が無く、同じ概念に2通りの書き方を
// 生むだけなので原理4 で弾く。前置/後置（`[!_]` `[_!]`）のホールは、オペランドが1つしか
// 無いためどちらの固定位置かを示すのに要る——そちらは partial が立っており下の早期returnで
// この検査に到達しない。
const STRUCTURAL_INFIX = new Set([
  "construct",
  "concat",
  "push",
  "unshift",
  "apply",
  "apply_reverse",
  "compose",
  "product",
]);

function replaceHoles(node, names) {
  if (!node || typeof node !== "object") return;
  if (node.type !== "operation" || node.partial) return;
  for (const side of ["left", "right", "operand"]) {
    const child = node[side];
    if (child === undefined || child === null) continue;
    if (isHoleNode(child)) {
      if (node.position === "infix" && !STRUCTURAL_INFIX.has(node.name)) {
        throw new SyntaxError(
          `中置演算子 '${node.op}' のオペランドに '_' は書けません。` +
            `欠けている側は位置で示します——右辺を束縛するなら [${node.op} c]、` +
            `左辺なら [c ${node.op}] と書きます`
        );
      }
      const name = "<$p" + names.length + ">";
      names.push(name);
      node[side] = { type: "atom", kind: "identifier", value: name };
    } else {
      replaceHoles(child, names);
    }
  }
}

function desugarHoles(node, env) {
  if (!node || typeof node !== "object") return node;
  // 定義行は右辺だけが対象。左辺（定義される名前）まで包むと定義そのものが消える。
  if (node.type === "operation" && node.name === "define") {
    node.right = desugarHoles(node.right, env);
    return node;
  }
  if (isHoleNode(node)) return node; // 単独の `_` は包む意味が無いのでそのまま
  const names = [];
  replaceHoles(node, names);
  if (names.length === 0) return node;
  const scope = bindEnv(names, env);
  // 単一パラメータは identifier ノード、複数は params ノード
  // （buildParameterList が返す形と揃える——interpreter の paramEntriesOf が両方を扱う）。
  const paramNode =
    names.length === 1
      ? { type: "atom", kind: "identifier", value: names[0] }
      : {
          type: "params",
          entries: names.map((n) => ({ name: n, rest: false, default: null })),
          requiredArity: names.length,
          bracket: false,
        };
  return { type: "operation", op: "?", name: "lambda", position: "infix", left: paramNode, right: node, scope };
}

// ---- ブロック（[...] {...} (...) インデント／絶対値）の解決 ----
// grammar.pegjs修正後: bracket系(`[` `{` `(`)は exprs をそのまま返し、
// indent/abs系は [MARKER, exprs, MARKER?] という「exprsを1要素として保持した」
// 配列を返す（以前は ...exprs と展開しており、bracket系と保護膜の厚みが
// 非対称でExpressionのflat()で漏れる原因になっていたが、修正済み）。
function resolveBlock(term, env) {
  let kind = "paren"; // 【既知の制限】paren/brace/bracketはgrammar.pegjs側で区別されないため固定値
  let exprsArray;
  if (Array.isArray(term) && term[0] === '"INDENT_"') {
    kind = "indent";
    exprsArray = term[1];
  } else if (Array.isArray(term) && term[0] === '"ABS_"') {
    kind = "abs";
    exprsArray = term[1];
  } else {
    exprsArray = term; // bracket系: term がそのまま exprs
  }
  // このブロック内の行だけを対象にした子スコープを作る（ネストしたスコープ連鎖）
  const inner = childEnv(exprsArray.filter(Array.isArray), env);
  const lines = exprsArray.map((line) => (Array.isArray(line) ? reduceAll(line, inner) : toNode(line, inner)));
  // 子スコープをノードへ残す。これが無いと、縮約が終わった後にASTを歩く側（pass3の
  // annotateTypes、Pass 3b の未定義識別子検出）が「ブロック内の識別子を外側のenvで
  // 解決してしまう」——ブロック内で定義された識別子のatomTypeが読めないだけでなく、
  // 未定義識別子の静的検出が偽陽性だらけになる。
  return { type: "block", kind, lines, scope: inner };
}

export { reduceAll, getCategory, resolveDensity };
