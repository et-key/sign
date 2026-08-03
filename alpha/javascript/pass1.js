/**
 * Pass1（最小実装）: ブロック階層に沿ってネストした識別子環境（env）の構築。
 *
 * env は { bindings: Map<識別子, Binding>, parent: env|null } という連鎖構造。
 * Binding は { category: 'Lambda'|'Atom', restParam: 'bare'|'bracket'|null } という
 * .ist（type_system.md §5 Pass1a）のごく一部を先取りした最小スキーマ。
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

function buildEnvScope(lines) {
  const bindings = new Map();
  for (const line of lines) {
    if (!Array.isArray(line) || line.length < 2) continue;
    const first = line[0];
    if (typeof first !== "string" || !first.startsWith("<") || !first.endsWith(">")) continue;
    const defineIdx = line.indexOf(":");
    if (defineIdx !== 1) continue; // "<id> :" の形（先頭2要素）のみ対象
    const qIdx = line.indexOf("?", defineIdx + 1);
    const hasLambda = qIdx !== -1;
    const restParam = hasLambda ? detectRestParamShape(line.slice(defineIdx + 1, qIdx)) : null;
    bindings.set(first, { category: hasLambda ? "Lambda" : "Atom", restParam });
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
  for (const name of names) bindings.set(name, { category: "Atom", restParam: null });
  return { bindings, parent: parent || null };
}

export { buildEnv, buildEnvScope, childEnv, envLookup, bindEnv };
