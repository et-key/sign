import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { annotateContextualOperators, liftLambdas, infer, generateST, Substitution, resetTVarCounter } from './semanticize/analyzer/index.js';
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
    
    const typeEnv = new Map();
    const subst = new Substitution();
    resetTVarCounter();
    
    // ラムダリフティング用の状態を初期化
    const lambdaState = { lambdas: [], counter: 0 };
    
    // 新しいパイプライン:
    // 1. buildAST (shunting yard)
    // 2. annotateContextualOperators (意味タグ)
    // 3. infer (型推論 + coproduct解決 — 型推論後に構造決定)
    // 4. liftLambdas (ラムダリフティング)
    const astTrees = astLines.map(astLine => {
      // 3. Shunting Yard (優先順位解決 -> AST)
      let astTree = buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);
      
      // 4. Semantic Analyzer (意味タグ付与)
      astTree = annotateContextualOperators(astTree);
      
      // 5. Type Inference (制約ベース型推論 + coproduct解決)
      //    resolveCoproducts は型推論内部で実行される
      infer(astTree, typeEnv, subst);
      
      // 6. Lambda Lifting (無名関数の平坦化)
      return liftLambdas(astTree, lambdaState);
    });
    
    // 抽出された無名関数をASTの末尾に結合する
    if (lambdaState.lambdas.length > 0) {
      // ラムダの型推論も実行
      for (const lambda of lambdaState.lambdas) {
        infer(lambda, typeEnv, subst);
      }
      astTrees.push(...lambdaState.lambdas);
    }
    
    // 代入を最終解決
    // (型変数を可能な限り解決する)
    for (const tree of astTrees) {
      resolveTypeDetails(tree, subst);
    }
    
    // Write JSON output
    const outPathJson = filePath.replace(/\.(sign|sn)$/, '.json');
    fs.writeFileSync(outPathJson, JSON.stringify(astTrees.length === 1 ? astTrees[0] : astTrees, null, 2), 'utf-8');
    
    // Write .st Type Signature output
    const outPathSt = filePath.replace(/\.(sign|sn)$/, '.st');
    const stContent = generateST(astTrees, lambdaState.lambdas);
    fs.writeFileSync(outPathSt, stContent, 'utf-8');
    
    console.log(`[Success] AST written to: ${outPathJson} and ${outPathSt}`);
    
  } catch (err) {
    let errMsg = "";
    if (err.location) {
      errMsg = `[Parse Error] Expected ${err.expected.map(e=>e.text?`"${e.text}"`:`[${e.parts.join('')}]`).join(', ')} but "${err.found}" found.`;
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
