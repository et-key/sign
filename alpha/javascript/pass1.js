/**
 * Pass1（最小実装）: ブロック階層に沿ってネストした識別子環境（env）の構築。
 *
 * env は { bindings: Map<識別子, カテゴリ>, parent: env|null } という連鎖構造。
 * 予約語が存在しないため、"<...>"で囲まれた文字列は常に識別子と判定できる
 * （classifyAtom と同じ判定基準）。
 *
 * 走査ルール（1スコープぶん）: 各行（フラットなTerm列）を見て、
 *   <id> : ... ? ...   （行内に : があり、その後に ? がある）  → bindings[id] = 'Lambda'
 *   <id> : ...          （: はあるが ? がない）                 → bindings[id] = 'Atom'
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
 */

function buildEnvScope(lines) {
  const bindings = new Map();
  for (const line of lines) {
    if (!Array.isArray(line) || line.length < 2) continue;
    const first = line[0];
    if (typeof first !== "string" || !first.startsWith("<") || !first.endsWith(">")) continue;
    const defineIdx = line.indexOf(":");
    if (defineIdx !== 1) continue; // "<id> :" の形（先頭2要素）のみ対象
    const hasLambda = line.slice(defineIdx + 1).includes("?");
    bindings.set(first, hasLambda ? "Lambda" : "Atom");
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

export { buildEnv, buildEnvScope, childEnv, envLookup };
