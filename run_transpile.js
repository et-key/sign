import fs from 'fs';
import path from 'path';
import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';
import { resolveCoproducts, getArity } from './pre_alpha/semanticize/coproduct_resolver.js';
import { transpile } from './pre_alpha/backend/js_codegen.js';
import { execSync } from 'child_process';
import util from 'util';
import { RUNTIME_HELPERS_CODE } from './pre_alpha/backend/runtime_helpers.js';
import { buildEnvironment, desugarHoles, collectIdentifiers } from './pre_alpha/semanticize/ast_helpers.js';
import { generateTypeScriptDef } from './pre_alpha/backend/ts_codegen.js';
import { transpileToWasm, getMemoryMap, getStructFields } from './pre_alpha/backend/wasm_codegen.js';
import wabt from 'wabt';

// 1. Get the source file argument
const fileArg = process.argv[2] || 'pre_alpha/_test_/function/composition.sn';
const filePath = path.resolve(fileArg);

if (!fs.existsSync(filePath)) {
  console.error(`File not found: ${filePath}`);
  process.exit(1);
}

console.log(`=== Compiling and Transpiling: ${fileArg} ===`);
const sourceCode = fs.readFileSync(filePath, 'utf8');

// 2. Preprocess, Parse, and Resolve Coproducts
const pre = preprocess(sourceCode);
const astProg = parser.parse(pre);
console.log("=== AST ===");
console.log(JSON.stringify(astProg, null, 2));

let globalEnv = new Map();
const rawLines = astProg.filter(line => line !== null && line !== undefined);
const astLines = rawLines.map(desugarHoles);

// Build Environment Map
astLines.forEach(astLine => {
  buildEnvironment(astLine, globalEnv);
});

// Resolve Coproducts and Transpile Statements
const jsStatements = [];
astLines.forEach(astLine => {
  const resolved = resolveCoproducts(astLine, globalEnv);
  
  // Re-build env with resolved tree for accurate type inference later
  buildEnvironment(resolved, globalEnv);
  
  const jsCode = transpile(resolved, globalEnv);
  if (jsCode) {
    jsStatements.push(jsCode);
  }
});

// Collect used identifiers to find undefined ones
const usedIdents = new Set();
astLines.forEach(line => collectIdentifiers(line, usedIdents, globalEnv));

const undefinedIdents = [];
usedIdents.forEach(id => {
  if (!globalEnv.has(`<${id}>`) && id !== '_' && id !== 'print') {
    undefinedIdents.push(id);
  }
});

const undefinedDeclarations = undefinedIdents.map(id => `const ${id} = __unit;`).join('\n');

// 3. Assemble the full executable JS file content
const runtimeHelpers = `
import _ from 'white_cats';
import util from 'util';

${RUNTIME_HELPERS_CODE}
`;

const loggingBlock = `
console.log("=== Execution Result ===");
`;

const fullJsCode = `${runtimeHelpers}\n${undefinedDeclarations}\n${jsStatements.map(s => s + ';').join('\n')}\n${loggingBlock}`;

console.log("=== Generated JavaScript Code ===");
// console.log(fullJsCode);

// 4. Generate TypeScript Definitions
const resolvedLines = astLines.map(astLine => resolveCoproducts(astLine, globalEnv));
const dtsCode = generateTypeScriptDef(resolvedLines, globalEnv);

// 5. Write to files
const jsFilePath = filePath.replace(/\.(sign|sn)$/, '.js');
const dtsFilePath = filePath.replace(/\.(sign|sn)$/, '.d.ts');
const watFilePath = filePath.replace(/\.(sign|sn)$/, '.wat');
const wasmFilePath = filePath.replace(/\.(sign|sn)$/, '.wasm');

fs.writeFileSync(jsFilePath, fullJsCode, 'utf8');
fs.writeFileSync(dtsFilePath, dtsCode, 'utf8');

// Generate WAT
let watCode = '';
try {
  watCode = transpileToWasm(resolvedLines, globalEnv);
  fs.writeFileSync(watFilePath, watCode, 'utf8');
} catch (e) {
  console.error("WASM codegen error:", e.stack || e.message);
}

console.log(`\nFiles generated:`);
console.log(`  JS: ${jsFilePath}`);
console.log(`  TS: ${dtsFilePath}`);
if (watCode) console.log(`  WAT: ${watFilePath}`);

// 6. Execute the transpiled JS
try {
  console.log("\n=== Execution Output (JS) ===");
  const output = execSync(`node ${jsFilePath}`, { encoding: 'utf8' });
  console.log(output);
} catch (err) {
  console.error("JS Execution error:", err.stdout || err.stderr || err.message);
}

// 7. Compile and Execute WASM
if (watCode) {
  try {
    console.log("=== Compiling WAT to WASM (using wabt npm package) ===");
    const wabtInstance = await wabt();
    const wasmModule = wabtInstance.parseWat(watFilePath, watCode, {
      memory64: true
    });
    const { buffer } = wasmModule.toBinary({});
    fs.writeFileSync(wasmFilePath, buffer);
    console.log(`  WASM generated: ${wasmFilePath}`);

    console.log("\n=== Execution Output (WASM64) ===");
    
    // Instantiate WASM module (Node.js requires --experimental-wasm-64 for wasm64)
    const wasmInstanced = await WebAssembly.instantiate(buffer, {
      js: {
        pow: (x, y) => Math.pow(x, y)
      }
    });
    const exports = wasmInstanced.instance.exports;

    // Run main entry
    exports.main();

    // Dump linear memory state
    const memory = exports.memory;
    const view = new DataView(memory.buffer);
    const u8 = new Uint8Array(memory.buffer);

    function readWasmString(addr) {
      if (addr === 0n || addr === 0) return 'null';
      let str = '';
      let ptr = Number(addr);
      while (u8[ptr] !== 0 && ptr < u8.length) {
        str += String.fromCharCode(u8[ptr]);
        ptr++;
      }
      return str;
    }

    console.log("\n--- WASM64 Memory Dump (Variables) ---");
    const memoryMap = getMemoryMap();
    const structFields = getStructFields();
    
    // Sort variables by their memory address
    const vars = Array.from(memoryMap.entries()).sort((a, b) => a[1] - b[1]);
    
    vars.forEach(([name, addr]) => {
      const fields = structFields.get(name);
      if (fields) {
        console.log(`${name} (struct):`);
        Object.entries(fields).forEach(([fName, fMeta]) => {
          const fAddr = addr + fMeta.offset;
          dumpValue(`  .${fName}`, fAddr);
        });
      } else {
        dumpValue(name, addr);
      }
    });

    function dumpValue(label, address) {
      const rawI64 = view.getBigInt64(address, true);
      const rawF64 = view.getFloat64(address, true);
      
      let extra = '';
      
      // Is it a potential string pointer?
      if (rawI64 >= 1024n && rawI64 < 2048n) {
        const str = readWasmString(rawI64);
        if (str && /^[a-zA-Z0-9_\-\.\:\/ ]*$/.test(str)) {
          extra += ` -> String: "${str}"`;
        }
      }
      
      // Is it a potential heap object (closure)?
      if (rawI64 >= 2048n && rawI64 < 65536n && (rawI64 % 8n === 0n)) {
        const ptr = Number(rawI64);
        try {
          const tableIdx = view.getBigInt64(ptr + 0, true);
          const expArity = view.getBigInt64(ptr + 8, true);
          const appCount = view.getBigInt64(ptr + 16, true);
          const argsPtr = view.getBigInt64(ptr + 24, true);
          
          if (expArity >= 1n && expArity <= 10n && appCount >= 0n && appCount <= expArity) {
            const argsList = [];
            for (let i = 0n; i < appCount; i++) {
              const argAddr = Number(argsPtr + i * 8n);
              const argVal = view.getBigInt64(argAddr, true);
              const argValF64 = view.getFloat64(argAddr, true);
              argsList.push(`${argVal} (f64: ${argValF64})`);
            }
            extra += ` -> Closure(table_idx: ${tableIdx}, arity: ${appCount}/${expArity}, args: [${argsList.join(', ')}])`;
          }
        } catch(e) {}
      }

      console.log(`  ${label}: raw i64: ${rawI64}, f64: ${rawF64}${extra}`);
    }

  } catch (err) {
    console.error("WASM Execution error:", err.message);
  }
}
