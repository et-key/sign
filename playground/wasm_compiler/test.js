import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { buildEnvironment } from './semanticize/builder.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { evaluate } from './semanticize/evaluator.js';
import { generateST } from './semanticize/st_generator.js';
import { evaluateType } from './semanticize/type_evaluator.js';

import { analyzeSemantics } from './backend/semantic_analyzer.js';
import { generateWasm } from './backend/wasm_emitter.js';
import wabtFactory from 'wabt';
import util from 'util';

const wabt = await wabtFactory();
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

const argFile = process.argv[2];
const files = argFile ? [argFile] : (fs.existsSync(testDir) ? findTestFiles(testDir) : []);
if (files.length === 0) {
  console.log(`No .sn test files found in ${testDir}`);
}

for (const filePath of files) {
  const tc = fs.readFileSync(filePath, 'utf-8');
  console.log(`\n=== File: ${filePath} ===`);
  let preprocessed = "";
  try {
    // 1. Lexer (前処理)
    preprocessed = preprocess(tc);
    const visible = preprocessed.replace(/\x02/g, '<INDENT>').replace(/\x03/g, '<DEDENT>').replace(/\x04/g, '<ABS_START>').replace(/\x05/g, '<ABS_END>');
    console.log(`[Lexer output]: ${visible.replace(/\n/g, '\\n')}`);

    // 2. PEG Parser (構文解析)
    const astProgram = parser.parse(preprocessed);
    const astLines = astProgram.filter(line => line !== null && line !== undefined);

    // 新しいパイプライン:
    // 1. buildAST (shunting yard)
    // 2. buildEnvironment (スコープとカテゴリ判定)
    // 3. resolveCoproducts (優先順位に基づくAST階層調整)
    // 4. evaluate (値の評価)
    // 5. infer (Algorithm Wによる型推論)
    let globalEnv = new Map();
    let typeEnv = new Map();

    const astTrees = astLines.map(astLine => {
      // 1. Shunting Yard (優先順位解決 -> AST)
      let astTree = buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);

      // 2. 環境構築 (ローカルスコープとカテゴリ判定)
      globalEnv = buildEnvironment(astTree, globalEnv);

      // 3. 優先順位解決 (coproduct_block の還元)
      astTree = resolveCoproducts(astTree, globalEnv);

      // 4. 値の抽象評価 (Partial Evaluation)
      // ASTの部分適用や実行時の簡約を行います。（コード生成用）
      const evalTree = evaluate(astTree, globalEnv);
      if (filePath.endsWith('generator.sn')) {
        console.log(`[DEBUG evalTree]`, JSON.stringify(evalTree, null, 2));
      }

      // 5. ボトムアップ型評価
      fs.writeFileSync('scratch/fib_evalTree.json', JSON.stringify(evalTree, null, 2));
      const resolvedType = evaluateType(evalTree, typeEnv);
      
      // JSONやAssembly用には簡約済みのASTを返しつつ、型情報はST用に別管理すべきですが、
      // ここではSTファイル出力のために resolvedType をASTとして扱います。
      // astTreeの各statementに推論された型をアタッチします。
      let updatedStatements;
      if (astTree && Array.isArray(astTree.statements)) {
        updatedStatements = astTree.statements.map((stmt, i) => {
          if (resolvedType && resolvedType.type === 'coproduct_block' && resolvedType.statements) {
            if (typeof stmt === 'string') {
                return { type: 'Identifier', name: stmt, inferredType: resolvedType.statements[i] };
            }
            return { ...stmt, inferredType: resolvedType.statements[i] };
          }
          return stmt;
        });
        return { ...astTree, statements: updatedStatements, inferredType: resolvedType };
      } else if (Array.isArray(astTree)) {
        updatedStatements = astTree.map((stmt, i) => {
          if (resolvedType && resolvedType.type === 'coproduct_block' && resolvedType.statements) {
            if (typeof stmt === 'string') {
              // Can't spread strings easily without turning them into objects,
              // but we want to attach inferredType... 
              // Wait, primitive strings in AST don't hold properties well. Let's wrap it.
              return { type: 'Identifier', name: stmt, inferredType: resolvedType.statements[i] };
            }
            return { ...stmt, inferredType: resolvedType.statements[i] };
          }
          return stmt;
        });
        return { type: 'file', statements: updatedStatements, inferredType: resolvedType };
      }
      
      if (typeof astTree === 'string') {
          return { type: 'Identifier', name: astTree, inferredType: resolvedType };
      }
      return { ...astTree, inferredType: resolvedType };
    });

    // Write JSON output
    const outPathJson = filePath.replace(/\.(sign|sn)$/, '.json');
    fs.writeFileSync(outPathJson, JSON.stringify(astTrees.length === 1 ? astTrees[0] : astTrees, null, 2), 'utf-8');

    // Write .st Type Signature output
    const outPathSt = filePath.replace(/\.(sign|sn)$/, '.st');
    fs.writeFileSync(outPathSt, JSON.stringify(astTrees, null, 2), 'utf-8');

    // 6. Semantic Analysis & IR Generation
    const irProgram = analyzeSemantics(astTrees);
    
    // Write .ir output for debugging
    const outPathIr = filePath.replace(/\.(sign|sn)$/, '.ir.json');
    fs.writeFileSync(outPathIr, JSON.stringify(irProgram, null, 2), 'utf-8');

    // 7. WASM Emission
    const outPathWat = filePath.replace(/\.(sign|sn)$/, '.wat');
    const watContent = generateWasm(irProgram);
    fs.writeFileSync(outPathWat, watContent, 'utf-8');

    // Compile WAT to WASM and execute
    await compileAndRunWasm(outPathWat);

    console.log(`[Success] Compiled to: ${outPathJson}, ${outPathSt}, and ${outPathWat}`);

  } catch (e) {
    if (e.name === 'SyntaxError') {
       console.log(`[Parse Error] ${e.stack}`);
       const loc = e.location;
       if (loc) {
         const lines = preprocessed.split(/\r?\n/);
         console.log(`Error at line ${loc.start.line}, column ${loc.start.column}:`);
         console.log(lines[loc.start.line - 1]);
         console.log('^'.padStart(loc.start.column));
       }
    } else {
       console.log(`[Error] ${e.stack}`);
    }

    const outPath = filePath.replace(/\.(sign|sn)$/, '.json');
    fs.writeFileSync(outPath, JSON.stringify({ error: e.stack }, null, 2), 'utf-8');
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

/**
 * WATを.wasmにアセンブルし、WebAssembly.instantiateで実行・検証する
 */
async function compileAndRunWasm(watFilePath) {
  try {
    const watText = fs.readFileSync(watFilePath, 'utf8');
    const wasmModule = wabt.parseWat(path.basename(watFilePath), watText, { exceptions: true, mutable_globals: true, simd: true, memory64: true });
    wasmModule.resolveNames();
    wasmModule.validate();
    const binaryOutput = wasmModule.toBinary({ log: true, write_debug_names: true });
    
    // Write .wasm file
    const wasmFilePath = watFilePath.replace(/\.wat$/, '.wasm');
    fs.writeFileSync(wasmFilePath, binaryOutput.buffer);
    
    // Instantiate the WebAssembly module
    const importObject = {
      env: {
        print: (val) => {
          if (val === -1) {
             console.log(`[WASM Print] !_`);
          } else {
             console.log(`[WASM Print] ${val}`);
          }
        }
      }
    };
    const { instance } = await WebAssembly.instantiate(binaryOutput.buffer, importObject);
    if (instance.exports.main) {
      console.log(`[WASM Exec ${path.basename(watFilePath)}] main() = ${instance.exports.main()}`);
    } else if (instance.exports.result) {
      console.log(`[WASM Exec ${path.basename(watFilePath)}] result() = ${instance.exports.result()}`);
    } else {
      console.log(`[WASM Exec ${path.basename(watFilePath)}] No main or result exported.`);
    }
  } catch (e) {
    console.error(`[WASM Error] Failed to compile or run ${watFilePath}:`, e.stack);
  }
}
