// playground.js
import { preprocess } from '../pre_alpha/lexisize/lexer.js';
import * as parser from '../pre_alpha/parse/minimal.js';
import { resolveCoproducts, getArity } from '../pre_alpha/semanticize/coproduct_resolver.js';
import { transpile } from '../pre_alpha/backend/js_codegen.js';
import { RUNTIME_HELPERS_CODE } from '../pre_alpha/backend/runtime_helpers.js';
import { buildEnvironment, desugarHoles, collectIdentifiers } from '../pre_alpha/semanticize/ast_helpers.js';
import { transpileToWasm, getMemoryMap, getStructFields, getTableFunctions } from '../pre_alpha/backend/wasm_codegen.js';

// DOM References
const sourceEditor = document.getElementById('sourceEditor');
const lineNumbers = document.getElementById('lineNumbers');
const astOutput = document.getElementById('astOutput');
const jsOutput = document.getElementById('jsOutput');
const consoleOutput = document.getElementById('consoleOutput');
const runBtn = document.getElementById('runBtn');
const exampleSelect = document.getElementById('exampleSelect');
const clearConsoleBtn = document.getElementById('clearConsoleBtn');
const targetJSRadio = document.getElementById('targetJS');
const targetWASMRadio = document.getElementById('targetWASM');
const transpiledTitle = document.getElementById('transpiledTitle');
const transpiledSubtitle = document.getElementById('transpiledSubtitle');

// Toggle target modes
targetJSRadio.addEventListener('change', updateTargetMode);
targetWASMRadio.addEventListener('change', updateTargetMode);

function updateTargetMode() {
  const isWASM = targetWASMRadio.checked;
  if (isWASM) {
    transpiledTitle.textContent = "Transpiled WebAssembly (WAT)";
    transpiledSubtitle.textContent = "wasm64 Text Format";
    jsOutput.className = "language-wasm";
    if (jsOutput.textContent === '// Transpiled code will appear here...' || jsOutput.textContent === '// Ready to transpile...') {
      jsOutput.textContent = ';; Ready to transpile to WAT...';
    }
  } else {
    transpiledTitle.textContent = "Transpiled JavaScript";
    transpiledSubtitle.textContent = "white_cats ESM Target";
    jsOutput.className = "language-javascript";
    if (jsOutput.textContent === ';; Ready to transpile to WAT...') {
      jsOutput.textContent = '// Ready to transpile...';
    }
  }
}

// Templates definitions for Example Loaders
const EXAMPLES = {
  composition: `\` 1. Function Composition using Space ' '
say : "console.log"
f : x ? x * 2
g : x ? x + 1
say (f g 3)
`,
  partial_app: `\` 1. Partial Application using Hole (_)
say : "console.log"
f : x y ? x + y
partial : f _ 3
say (partial 4)

\` 2. Currying
curried : f 2
say (curried 4)

\` 3. Conditional Maybe Value (Value-based comparisons)
say (10 < 5)
say (5 == 5)
`,
  generator: `\` 1. Higher Order Function Recursive Mapping on Lazy Generator
say : "console.log"
f : x ? x * 2
map : g x ~y ? [@g x] [map g y~]

\` Range evaluation produces [0, 2, 4, 6, 8, 10]
say (map $[* 2,] [0 ~+ 2 ~ 10])
`,
  lists: `\` Atom vs Function Coproduct Resolution
say : "console.log"
a : 1
b : 2
c : 3

say [a b c]
say (a b c)
say (a b c , a b c)
say ([a b c] [a b c])
say ([a b c] , [a b c])

say ([a , b , c] [a , b , c])
say ([a , b , c] , [a , b , c])
`,
  higher_order: `\` Recursive Map using Coproduct and Partial Application
say : "console.log"
f : x ? x * 2
map : g x ~y ? @g x , map g y~

say (map $f 1 2 3 4 5)
say (map $[x ? x * 2] 1 2 3 4 5)
`,
  factorial: `\` Recursive Factorial (Packrat Parsing Test)
say : "console.log"
fact : x ?
	x = 0 : 1
	x = 1 : 1
	x * [fact [x - 1]]

say (fact 5)
`,
  fold: `\` 1. Eager Fold (Trampoline Extraction)
say : "console.log"
add : x y ? x + y
fold_eager : f a x ~y ? fold_eager f [@f a x] y~

say (fold_eager $add 0 1 2 3 4 5)

\` 2. Lazy Fold (Thunk / Double Algebra)
fold_lazy : f a x ~y ? $fold_lazy f [@f a x] y~

step0 : fold_lazy $add 0 1 2 3
step1 : @step0 __
say (@step1 __)
`,
  operators: `\` 1. Inline JavaScript Code
say : "console.log"
say \`hello\` \`world\` 123

\` 2. Range Operators (Eager Arrays)
say (0 ~+ 2 ~ 10)
say (1 ~* 2 ~ 16)

\` 3. Spread Import
js : javascript@
math : js'Math

\` 4. Property Access and Reverse Access
say (math'PI)
PI_val : math'PI
say (PI_val @ math)

\` 5. Object Overwrite (Shallow Copy)
base_obj : js'Object
say (base_obj # prop 42)

\` 6. Logical, Bitwise, Math
say (1 & 1)
say (5 ;; 3)
say (1 << 3)
say (|-5|)
say (5!)

\` 7. Expand Array
arr : 1 , 2 , 3
say (arr~)
`
};

// Line Numbering Sync
function updateLineNumbers() {
  const text = sourceEditor.value;
  const lines = text.split('\n');
  const count = lines.length;
  let html = '';
  for (let i = 1; i <= count; i++) {
    html += `<div>${i}</div>`;
  }
  lineNumbers.innerHTML = html;
}

sourceEditor.addEventListener('input', updateLineNumbers);
sourceEditor.addEventListener('scroll', () => {
  lineNumbers.scrollTop = sourceEditor.scrollTop;
});

// Intercept Tab key to insert a physical tab character
sourceEditor.addEventListener('keydown', (e) => {
  if (e.key === 'Tab') {
    e.preventDefault();
    const start = sourceEditor.selectionStart;
    const end = sourceEditor.selectionEnd;
    const value = sourceEditor.value;
    sourceEditor.value = value.substring(0, start) + '\t' + value.substring(end);
    sourceEditor.selectionStart = sourceEditor.selectionEnd = start + 1;
    updateLineNumbers();
  }
});


// Example Loader
exampleSelect.addEventListener('change', () => {
  const selected = exampleSelect.value;
  if (EXAMPLES[selected]) {
    sourceEditor.value = EXAMPLES[selected];
    updateLineNumbers();
    clearOutputViews();
  }
});

// Load default composition example on startup
sourceEditor.value = EXAMPLES.composition;
updateLineNumbers();

// Console Logger redirection
const originalConsoleLog = console.log;
const originalConsoleError = console.error;

function logToConsole(message, type = 'log-msg') {
  const line = document.createElement('div');
  line.className = `console-line ${type}`;
  line.textContent = typeof message === 'string' ? message : inspect(message);
  consoleOutput.appendChild(line);
  consoleOutput.scrollTop = consoleOutput.scrollHeight;
}

clearConsoleBtn.addEventListener('click', () => {
  consoleOutput.innerHTML = '<div class="console-line system-msg">Console cleared.</div>';
});

function clearOutputViews() {
  astOutput.textContent = '{}';
  const isWASM = targetWASMRadio.checked;
  jsOutput.textContent = isWASM ? ';; Ready to transpile to WAT...' : '// Ready to transpile...';
}

// Custom inspect for browser execution representation
function inspect(val, depth = 0) {
  if (val === undefined) return 'undefined';
  if (val === null) return 'null';
  if (typeof val === 'symbol') return val.toString();
  if (typeof val === 'function') {
    return val.name ? `[Function: ${val.name}]` : '[Function (anonymous)]';
  }
  if (Array.isArray(val)) {
    if (val.length === 0) return '[]';
    const items = val.map(v => inspect(v, depth + 1)).join(', ');
    return `[ ${items} ]`;
  }
  if (typeof val === 'object') {
    if (val.constructor && val.constructor.name === 'Address') {
      return `Address { value: ${inspect(val.value, depth + 1)} }`;
    }
    try {
      return JSON.stringify(val);
    } catch (e) {
      return String(val);
    }
  }
  if (typeof val === 'string') {
    return `'${val}'`;
  }
  return String(val);
}

// Expose inspect globally so executed scripts can utilize it for loggingBlock
window.inspect = inspect;

// Transpiler execution pipeline
runBtn.addEventListener('click', async () => {
  runBtn.classList.add('loading');
  clearOutputViews();
  logToConsole('Starting compilation...', 'system-msg');

  const sourceCode = sourceEditor.value;
  const isWASM = targetWASMRadio.checked;

  try {
    // 1. Preprocess
    const preprocessed = preprocess(sourceCode);

    // 2. PEG Parse
    const astProg = parser.parse(preprocessed);

    let globalEnv = new Map();
    const rawLines = astProg.filter(line => line !== null && line !== undefined);
    const astLines = rawLines.map(desugarHoles);

    // Build Environment Map
    astLines.forEach(astLine => {
      buildEnvironment(astLine, globalEnv);
    });

    const resolvedLines = [];
    astLines.forEach(astLine => {
      const resolved = resolveCoproducts(astLine, globalEnv);
      buildEnvironment(resolved, globalEnv);
      resolvedLines.push(resolved);
    });

    // Build the AST JSON Output
    astOutput.textContent = JSON.stringify(astLines.length === 1 ? astLines[0] : astLines, null, 2);

    if (isWASM) {
      // --- WebAssembly Target Execution Flow ---
      const watCode = transpileToWasm(resolvedLines, globalEnv);
      jsOutput.textContent = watCode;

      logToConsole('Compilation to WAT successful!', 'success-msg');
      logToConsole('Compiling WAT to WASM in browser...', 'system-msg');

      if (typeof window.wabt === 'undefined' && typeof window.WabtModule === 'undefined') {
        throw new Error('WABT (WebAssembly Binary Toolkit) was not loaded. Please ensure the local /wabt.js is correctly served.');
      }

      const wabtFn = window.wabt || window.WabtModule;
      const wabtInstance = await wabtFn();
      let binary;
      try {
        const wasmModule = wabtInstance.parseWat("playground.wat", watCode, { memory64: true });
        const binaryObj = wasmModule.toBinary({});
        binary = binaryObj.buffer;
      } catch (compileErr) {
        throw new Error(`WABT Compile Error:\n${compileErr.message || compileErr}`);
      }

      logToConsole('WASM binary generation successful!', 'success-msg');
      logToConsole('Instantiating WebAssembly module...', 'system-msg');

      const wasmInstanced = await WebAssembly.instantiate(binary, {
        js: {
          pow: (x, y) => Math.pow(x, y)
        }
      });

      logToConsole('Executing WASM main entry...', 'system-msg');
      const exports = wasmInstanced.instance.exports;
      
      // Run main
      exports.main();
      logToConsole('WASM Execution completed successfully.', 'success-msg');

      // Dump variables memory state
      logToConsole('--- WASM64 Memory Dump (Variables) ---', 'system-msg');
      
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

      const memoryMap = getMemoryMap();
      const structFields = getStructFields();
      const tableFunctions = getTableFunctions();
      const vars = Array.from(memoryMap.entries()).sort((a, b) => Number(a[1]) - Number(b[1]));

      vars.forEach(([name, addr]) => {
        const fields = structFields.get(name);
        if (fields) {
          logToConsole(`${name} (struct):`, 'log-msg');
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
        
        // Potential string
        if (rawI64 >= 1024n && rawI64 < 2048n) {
          const str = readWasmString(rawI64);
          if (str && /^[a-zA-Z0-9_\-\.\:\/ ]*$/.test(str)) {
            extra += ` -> String: "${str}"`;
          }
        }
        
        // Potential Function Pointer (Table Index Reference)
        if (rawI64 >= 0n && rawI64 < BigInt(tableFunctions.length)) {
          const funcName = tableFunctions[Number(rawI64)];
          extra += ` -> Function Pointer: ${funcName} (table_idx: ${rawI64})`;
        }

        logToConsole(`  ${label}: raw i64: ${rawI64}, f64: ${rawF64}${extra}`, 'log-msg');
      }

    } else {
      // --- JavaScript Target Execution Flow ---
      const jsStatements = [];
      resolvedLines.forEach(resolved => {
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

      const undefinedDeclarations = undefinedIdents.map(id => {
        const builtins = ['print', 'free', 'reduce_add', 'reduce_sub', 'reduce_mul', 'reduce_div'];
        const name = builtins.includes(id) ? id : `_sig_${id}`;
        return `const ${name} = __unit;`;
      }).join('\n');
      const generatedCodeOnly = `${undefinedDeclarations}\n${jsStatements.map(s => s + ';').join('\n')}`;
      jsOutput.textContent = generatedCodeOnly;

      logToConsole('Compilation successful!', 'success-msg');
      logToConsole('Executing code...', 'system-msg');

      // Intercept standard console.log inside run block
      window.console.log = (msg) => {
        logToConsole(msg, 'log-msg');
        originalConsoleLog(msg);
      };

      const runtimeHelpers = RUNTIME_HELPERS_CODE;
      const executionCode = `
(() => {
  const _ = window._;
  const util = { inspect: window.inspect };
  
  ${runtimeHelpers}
  
  console.log("=== Execution Result ===");
  
  ${generatedCodeOnly}
})()
      `;

      try {
        eval(executionCode);
        logToConsole('Execution completed successfully.', 'success-msg');
      } catch (err) {
        logToConsole(`Runtime Error: ${err.message}`, 'error-msg');
        originalConsoleError(err);
      }
    }

  } catch (err) {
    logToConsole(`Compiler Error: ${err.message}`, 'error-msg');
    originalConsoleError(err);
  } finally {
    // Restore original console.log
    window.console.log = originalConsoleLog;
    runBtn.classList.remove('loading');
  }
});
