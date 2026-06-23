import fs from 'fs';
import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { desugarHoles, buildEnvironment } from './semanticize/ast_helpers.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { transpileToWasm } from './backend/wasm_codegen.js';

const filePath = './_test_/function/fold_multiline_paren.sn';
const sourceCode = fs.readFileSync(filePath, 'utf8');
const pre = preprocess(sourceCode);
const astProg = parser.parse(pre);

console.log("RAW AST:", JSON.stringify(astProg, null, 2));

let globalEnv = new Map();
const rawLines = astProg.filter(line => line !== null && line !== undefined);
const astLines = rawLines.map(desugarHoles);

astLines.forEach(astLine => {
  buildEnvironment(astLine, globalEnv);
});

const resolvedLines = astLines.map(astLine => {
  const resolved = resolveCoproducts(astLine, globalEnv);
  buildEnvironment(resolved, globalEnv);
  return resolved;
});

console.log("RESOLVED MAP AST:", JSON.stringify(resolvedLines[1], null, 2));

const watCode = transpileToWasm(resolvedLines, globalEnv);
fs.writeFileSync('generator_debug.wat', watCode);
console.log("WAT code written to generator_debug.wat");

import wabt from 'wabt';
const wabtInstance = await wabt();
try {
  const wasmModule = wabtInstance.parseWat('generator_debug.wat', watCode, {
    memory64: true
  });
  const { buffer } = wasmModule.toBinary({});
  console.log("Wabt compile succeeded!");
  
  // Try instantiating
  const wasmInstanced = await WebAssembly.instantiate(buffer, {
    js: {
      pow: (x, y) => Math.pow(x, y)
    }
  });
  console.log("WebAssembly instantiation succeeded!");
} catch (e) {
  console.error("Compile/Instantiate failed:", e.stack || e.message || e);
}
