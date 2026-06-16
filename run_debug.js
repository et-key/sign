import fs from 'fs';
import path from 'path';
import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';
import { resolveCoproducts, getArity } from './pre_alpha/semanticize/coproduct_resolver.js';
import { transpile } from './pre_alpha/backend/js_codegen.js';
import util from 'util';
import { buildEnvironment, desugarHoles, collectIdentifiers } from './pre_alpha/semanticize/ast_helpers.js';

const fileArg = process.argv[2] || 'pre_alpha/_test_/function/fold.sn';
const filePath = path.resolve(fileArg);

if (!fs.existsSync(filePath)) {
  console.error(`File not found: ${filePath}`);
  process.exit(1);
}

console.log(`=== Debugging: ${fileArg} ===`);
const sourceCode = fs.readFileSync(filePath, 'utf8');

try {
  const pre = preprocess(sourceCode);
  const astProg = parser.parse(pre);
  
  let globalEnv = new Map();
  const rawLines = astProg.filter(line => line !== null && line !== undefined);
  const astLines = rawLines.map(desugarHoles);
  
  astLines.forEach(astLine => {
    buildEnvironment(astLine, globalEnv);
  });
  
  astLines.forEach((astLine, idx) => {
    console.log(`\n--- AST Line ${idx + 1} ---`);
    console.log(util.inspect(astLine, { depth: null, colors: true }));
    
    const resolved = resolveCoproducts(astLine, globalEnv);
    console.log(`\n--- Resolved Coproducts ---`);
    console.log(util.inspect(resolved, { depth: null, colors: true }));
    
    const jsCode = transpile(resolved);
    console.log(`\n--- Transpiled JS ---`);
    console.log(jsCode);
  });
  
} catch (e) {
  console.error("Error:", e);
}
