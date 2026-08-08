/**
 * コンパイルパイプラインの単一ドライバ（compiler_pipeline.md §3 のフロントエンド Pass 1〜3）。
 *
 * これまで各テスト・playgroundが同じ手順（preprocess → parse → buildEnv → reduceAll）を
 * それぞれコピーして持っており、pass1b と pass3 はどこからも呼ばれていなかった
 * （型を出しても消費者が存在しない状態）。ここに一本化する。
 *
 *   1. preprocess   lexer.js       前処理（separateInfix + markBlock）
 *   2. parse        parser.js      フラットなTerm列（sign.pegjs から生成）
 *   3. buildEnv     pass1.js       Pass 1a: 識別子テーブル（Layer 1 カテゴリ・アリティ）
 *   4. reduceAll    pass2.js       Pass 2: 余積の解決 → 二分木AST
 *   5. specialize   pass1b.js      Pass 1b: ジェネリック仮引数（@ref）の具体化
 *   6. annotate     pass3.js       Pass 3: Layer 2 型を全ノードへ注釈
 *
 * 【Passの順序が type_system.md §5 と食い違っている点】
 * §5 は Pass 1a → Pass 1b → Pass 2 → Pass 3 の順を書いており、呼び出しサイトの収集も
 * 「Pass 1a と同じ線形スキャンで記録する」としている。しかし実装では Pass 1b は Pass 2 の
 * **後**に走る。理由は、呼び出しサイトが何であるかは Pass 2 が余積（スペース）を
 * apply/compose/concat のどれに解決するかを決めるまで確定しないためである——
 * トークン列の段階では `f x` が関数適用なのかリスト構築なのか判定できない。
 * これは B-1（§5 Pass 1a の擬似コード）・B-3（§3.2 の左辺優先ルール）と同じ
 * 「§5 の記述が実装より単純化されている」系の食い違いであり、仕様側の修正候補。
 */

import { preprocess } from "./lexer.js";
import { parse } from "./parser.js";
import { buildEnv } from "./pass1.js";
import { reduceAll } from "./pass2.js";
import { specializeGenericParams } from "./pass1b.js";
import { annotateTypes } from "./pass3.js";

function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}

// Pass 1b: トップレベルの各ラムダ定義について、ジェネリック仮引数（本体で `@` が
// 直接かかっている仮引数）を呼び出しサイトの実引数カテゴリで具体化する。
// 対象が無ければ空のMapが返るだけなので、ジェネリックを含まないプログラムでは実質no-op。
function runPass1b(nodes, env) {
  const specializations = new Map();
  for (const node of nodes) {
    if (!isDefineNode(node) || !node.right || node.right.name !== "lambda") continue;
    const result = specializeGenericParams(node, nodes, env);
    if (result.size > 0) specializations.set(node.left.value, result);
  }
  return specializations;
}

/**
 * ソースを Pass 1〜3 に通し、型注釈済みのASTを返す。
 *
 * @param source Sign のソース文字列
 * @param options.parse パーサーの差し替え（省略時はビルド済みの `parser.js`）。
 *   テストは `sign.pegjs`（正式仕様）から peggy で都度ビルドしたパーサーを渡す——
 *   `parser.js` は `npm run build:parser` の成果物であり、実際に一度8/4時点で
 *   止まったまま `sign.pegjs` の修正が反映されていなかったことがあるため、
 *   テストが文法ソースを直接検証する性質は保つ必要がある。
 * @returns {{ nodes, env, specializations, diagnostics }}
 *   nodes           行ごとの型注釈済みAST（各ノードに `atomType` が載る）
 *   env             Pass 1a の識別子テーブル（.ist 相当、プロセス内メモリのみ）
 *   specializations Pass 1b の具体化結果 Map<関数名, Map<仮引数名, {callsiteCount, categories}>>
 *   diagnostics     コンパイル時に検出した診断（Pass 3b の Unit 収束理由など。現状は空）
 */
function compile(source, options = {}) {
  const parseFn = options.parse || parse;
  const lines = parseFn(preprocess(source));
  const env = buildEnv(lines);
  const nodes = lines.map((line) => reduceAll(line, env));
  const specializations = runPass1b(nodes, env);
  for (const node of nodes) annotateTypes(node, env);
  return { nodes, env, specializations, diagnostics: [] };
}

export { compile };
