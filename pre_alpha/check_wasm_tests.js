import fs from 'fs';
import path from 'path';
import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { buildEnvironment, desugarHoles } from './semanticize/ast_helpers.js';
import { transpileToWasm } from './backend/wasm_codegen.js';
import wabt from 'wabt';

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
  process.exit(0);
}

console.log(`Found ${files.length} test files. Starting WASM compilation & execution checks...`);

let successCount = 0;
let failCount = 0;
const failures = [];

const wabtInstance = await wabt();

for (const filePath of files) {
  try {
    const sourceCode = fs.readFileSync(filePath, 'utf8');
    const pre = preprocess(sourceCode);
    const astProg = parser.parse(pre);

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

    // 1. Transpile to WAT
    const watCode = transpileToWasm(resolvedLines, globalEnv);
    
    // 2. Compile to WASM binary
    const wasmModule = wabtInstance.parseWat(filePath, watCode, {
      memory64: true
    });
    const { buffer } = wasmModule.toBinary({});

    // 3. Instantiate & Execute
    const wasmInstanced = await WebAssembly.instantiate(buffer, {
      js: {
        pow: (x, y) => Math.pow(x, y)
      }
    });

    wasmInstanced.instance.exports.main();
    
    successCount++;
    console.log(`[PASS] ${filePath}`);
  } catch (err) {
    failCount++;
    console.log(`[FAIL] ${filePath}`);
    failures.push({
      path: filePath,
      error: err.stack || err.message
    });
  }
}

console.log(`\n=== WASM Test Suite Results ===`);
console.log(`Total: ${files.length}`);
console.log(`Success: ${successCount}`);
console.log(`Fail: ${failCount}`);

if (failures.length > 0) {
  console.log(`\n--- Failures Details ---`);
  failures.forEach(f => {
    console.log(`\n[FAIL] ${f.path}`);
    console.log(f.error);
  });
  process.exit(1);
} else {
  console.log(`\nAll WASM tests compiled and ran successfully!`);
  process.exit(0);
}
