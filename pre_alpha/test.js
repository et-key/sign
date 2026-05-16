import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { annotateContextualOperators, buildTypeEnvironment, resolveCoproducts } from './semanticize/analyzer.js';
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
    const astFlat = astLines.flat(2);
    
    // 3. Shunting Yard (優先順位解決 -> AST)
    let astTree = buildAST(Array.isArray(astFlat) && astFlat.length === 1 && Array.isArray(astFlat[0]) ? astFlat[0] : astFlat);
    
    // 4. Semantic Analyzer (意味解析: `:` のタグ付け)
    astTree = annotateContextualOperators(astTree);

    // 5. Static Type Resolution (Coproductの解決)
    const typeEnv = buildTypeEnvironment(astTree);
    astTree = resolveCoproducts(astTree, typeEnv);
    
    // Write JSON output
    const outPath = filePath.replace(/\.(sign|sn)$/, '.json');
    fs.writeFileSync(outPath, JSON.stringify(astTree, null, 2), 'utf-8');
    console.log(`[Success] AST written to: ${outPath}`);
    
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
