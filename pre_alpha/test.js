import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { buildEnvironment } from './semanticize/builder.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { evaluate } from './semanticize/evaluator.js';
// import { annotateContextualOperators, liftLambdas, infer, generateST, Substitution, resetTVarCounter } from './semanticize/analyzer/index.js';
import { generateAArch64 } from './backend/aarch64.js';
import util from 'util';
import fs from 'fs';
import path from 'path';

const testDir = './_test_';

function findTestFiles(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  for (const file of list) {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat && stat.isDirectory()) {
      results = results.concat(findTestFiles(filePath));
    } else if (filePath.endsWith('.sign') || filePath.endsWith('.sn')) {
      results.push(filePath);
    }
  }
  return results;
}

const files = fs.existsSync(testDir) ? findTestFiles(testDir) : [];

if (files.length === 0) {
  console.log(`No .sn test files found in ${testDir}`);
}

for (const filePath of files) {
  const tc = fs.readFileSync(filePath, 'utf-8');
  console.log(`\n=== File: ${filePath} ===`);
  try {
    // 1. Lexer (前処理)
    const preprocessed = preprocess(tc);
    const visible = preprocessed.replace(/\x02/g, '<INDENT>').replace(/\x03/g, '<DEDENT>').replace(/\x04/g, '<ABS_START>').replace(/\x05/g, '<ABS_END>');
    console.log(`[Lexer output]: ${visible.replace(/\n/g, '\\n')}`);

    // 2. PEG Parser (構文解析)
    const astProgram = parser.parse(preprocessed);
    const astLines = astProgram.filter(line => line !== null && line !== undefined);

    // 新しいパイプライン:
    // 1. buildAST (shunting yard)
    // 2. buildEnvironment (スコープと型推測)
    // 3. resolveCoproducts (優先順位に基づくAST階層調整)
    // 4. evaluate (型/値の評価とUnitへの還元)
    let globalEnv = new Map();

    const astTrees = astLines.map(astLine => {
      // 1. Shunting Yard (優先順位解決 -> AST)
      let astTree = buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);

      // 2. 環境構築 (ローカルスコープとカテゴリ判定)
      globalEnv = buildEnvironment(astTree, globalEnv);

      // 3. 優先順位解決 (coproduct_block の還元)
      astTree = resolveCoproducts(astTree, globalEnv);

      // 4. ASTの抽象評価 (型推論 / Unitへの還元)
      astTree = evaluate(astTree, globalEnv);

      return astTree;
    });

    // Write JSON output
    const outPathJson = filePath.replace(/\.(sign|sn)$/, '.json');
    fs.writeFileSync(outPathJson, JSON.stringify(astTrees.length === 1 ? astTrees[0] : astTrees, null, 2), 'utf-8');

    // Write .st Type Signature output (一時的にコメントアウト)
    // const outPathSt = filePath.replace(/\.(sign|sn)$/, '.st');
    // const stContent = generateST(astTrees, lambdaState.lambdas);
    // fs.writeFileSync(outPathSt, stContent, 'utf-8');

    // Write .s AArch64 output
    const outPathS = filePath.replace(/\.(sign|sn)$/, '.s');
    const asmContent = generateAArch64(astTrees);
    fs.writeFileSync(outPathS, asmContent, 'utf-8');

    console.log(`[Success] Compiled to: ${outPathJson} and ${outPathS}`);

  } catch (err) {
    let errMsg = "";
    if (err.location) {
      errMsg = `[Parse Error] Expected ${err.expected.map(e => e.text ? `"${e.text}"` : `[${e.parts.join('')}]`).join(', ')} but "${err.found}" found.`;
    } else {
      errMsg = `[Error] ${err.stack || err.message}`;
    }
    console.error(errMsg);

    const outPath = filePath.replace(/\.(sign|sn)$/, '.json');
    fs.writeFileSync(outPath, JSON.stringify({ error: errMsg }, null, 2), 'utf-8');
    console.log(`[Error] Written to: ${outPath}`);
  }
}

/**
 * AST の type_detail を最終的な代入で解決する
 */
function resolveTypeDetails(node, subst) {
  if (!node || typeof node !== 'object') return;

  if (node.type_detail) {
    node.type_detail = subst.apply(node.type_detail);
  }

  if (node.type === 'operation') {
    resolveTypeDetails(node.left, subst);
    resolveTypeDetails(node.right, subst);
    if (node.operand) resolveTypeDetails(node.operand, subst);
  } else if (node.type === 'block') {
    if (Array.isArray(node.content)) {
      node.content.forEach(c => resolveTypeDetails(c, subst));
    } else {
      resolveTypeDetails(node.content, subst);
    }
  } else if (node.type === 'coproduct_block' && node.statements) {
    node.statements.forEach(s => resolveTypeDetails(s, subst));
  }
}
