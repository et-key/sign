/**
 * Pass1（最小実装）: 識別子環境（env）の構築。
 *
 * 本来のPass1（compiler_pipeline.md）は識別子解決・スコープ検査・.ist生成まで含む
 * 大きな責務を持つが、今回はPass2（coproduct_resolver）がブロックされている
 * 「getCategoryがenvを必要とする」問題を解くための最小限の実装に留める。
 *
 * 走査ルール: 各行（トップレベルのExpression、フラットなTerm列）を見て、
 *   <id> : ... ? ...   （先頭が"<id> :"で、その後ろに ? がある）  → env[id] = 'Lambda'
 *   <id> : ...          （: はあるが ? がない）                    → env[id] = 'Atom'
 * それ以外の行（defineでない）はenvに影響しない。
 *
 * 【既知の制限】
 * - ブロック内部（[...]や{...}、インデントブロック）のネストしたdefineは見ていない。
 *   トップレベルの行のみを対象とする。
 * - 複数回代入・再定義の扱いは未定義（後勝ちで単純に上書きする）。
 * - スコープ検査（未定義識別子の参照エラー等）は一切行わない。
 */

function buildEnv(lines) {
  const env = new Map();
  for (const line of lines) {
    if (!Array.isArray(line) || line.length < 2) continue;
    const first = line[0];
    if (typeof first !== "string" || !first.startsWith("<") || !first.endsWith(">")) continue;
    const defineIdx = line.indexOf(":");
    if (defineIdx !== 1) continue; // "<id> :" の形（先頭2要素が identifier, ":"）のみ対象
    const hasLambda = line.slice(defineIdx + 1).includes("?");
    env.set(first, hasLambda ? "Lambda" : "Atom");
  }
  return env;
}

export { buildEnv };
