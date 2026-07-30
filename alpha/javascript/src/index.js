/**
 * Sign Language Alpha JavaScript Compiler Frontend & Backend API
 */

import { preprocess } from './lexer.js';
import { parse } from './parser.js';
import { desugarHoles, buildEnvironment } from './ast_helpers.js';
import { resolveCoproducts } from './coproduct_resolver.js';
import { transpileProgram } from './codegen_js.js';

export { preprocess } from './lexer.js';
export { parse } from './parser.js';
export { desugarHoles, buildEnvironment, inferType } from './ast_helpers.js';
export { resolveCoproducts, getArity, getParamCount } from './coproduct_resolver.js';
export { transpile, transpileProgram } from './codegen_js.js';

/**
 * Sign言語ソースコードを一括でコンパイル・トランスパイルする関数
 */
export function compile(sourceCode) {
  // 1. 前処理 (インデント処理, 演算子前後空白挿入)
  const preprocessed = preprocess(sourceCode);

  // 2. 構文解析 (PEG.js AST)
  const rawAst = parse(preprocessed);
  const astLines = (Array.isArray(rawAst) ? rawAst : [rawAst])
    .filter(line => line !== null && line !== undefined)
    .map(desugarHoles);

  // 3. Pass 1: 環境構築 (識別子テーブル収集)
  const globalEnv = new Map();
  astLines.forEach(line => buildEnvironment(line, globalEnv));

  // 4. Pass 2 & 3: 余積 (Coproduct) 解決
  const resolvedLines = astLines.map(line => {
    const resolved = resolveCoproducts(line, globalEnv);
    buildEnvironment(resolved, globalEnv);
    return resolved;
  });

  // 5. Pass 4: コード生成 (JavaScript)
  const jsCode = transpileProgram(resolvedLines, globalEnv);

  return {
    preprocessed,
    rawAst,
    astLines: resolvedLines,
    globalEnv,
    jsCode
  };
}
