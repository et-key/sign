import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { annotateContextualOperators, buildTypeEnvironment, resolveCoproducts, inferType, liftLambdas, generateST } from './semanticize/analyzer/index.js';
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
    
    // ファイルスコープの型環境（Type Environment）を初期化
    const typeEnv = new Map();
    // ラムダリフティング用の状態を初期化
    const lambdaState = { lambdas: [], counter: 0 };
    
    // トップレベルの「式のリスト（Statements Array）」として処理する
    const astTrees = astLines.map(astLine => {
      // 3. Shunting Yard (優先順位解決 -> AST)
      // Lineが単一の配列を返した場合のアンラップ
      let astTree = buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);
      
      // 4. Semantic Analyzer (意味解析: `:` のタグ付け)
      astTree = annotateContextualOperators(astTree);

      // 5. 型環境の更新（グローバル環境に登録）
      buildTypeEnvironment(astTree, typeEnv);
      
      // 6. Static Type Resolution (Coproductの解決)
      const resolved = resolveCoproducts(astTree, typeEnv);
      
      // 7. Type Inference (型の伝播と詳細推論)
      inferType(resolved, typeEnv);
      
      // 8. Lambda Lifting (無名関数の平坦化)
      return liftLambdas(resolved, lambdaState);
    });
    
    // 抽出された無名関数をASTの末尾に結合する
    if (lambdaState.lambdas.length > 0) {
      astTrees.push(...lambdaState.lambdas);
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
      errMsg = `[Parse Error] ${err.message}`;
    }
    console.error(errMsg);
    
    const outPath = filePath.replace(/\.(sign|sn)$/, '.json');
    fs.writeFileSync(outPath, JSON.stringify({ error: errMsg }, null, 2), 'utf-8');
    console.log(`[Error] Written to: ${outPath}`);
  }
}
