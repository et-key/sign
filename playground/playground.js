// playground.js
import { preprocess } from '../pre_alpha/lexisize/lexer.js';
import * as parser from '../pre_alpha/parse/minimal.js';
import { resolveCoproducts, getArity } from '../pre_alpha/semanticize/coproduct_resolver.js';
import { transpile } from '../pre_alpha/backend/js_codegen.js';
import { RUNTIME_HELPERS_CODE } from '../pre_alpha/backend/runtime_helpers.js';
import { buildEnvironment, desugarHoles, collectIdentifiers } from '../pre_alpha/semanticize/ast_helpers.js';

// DOM References
const sourceEditor = document.getElementById('sourceEditor');
const lineNumbers = document.getElementById('lineNumbers');
const astOutput = document.getElementById('astOutput');
const jsOutput = document.getElementById('jsOutput');
const consoleOutput = document.getElementById('consoleOutput');
const runBtn = document.getElementById('runBtn');
const exampleSelect = document.getElementById('exampleSelect');
const clearConsoleBtn = document.getElementById('clearConsoleBtn');

// Templates definitions for Example Loaders
const EXAMPLES = {
  composition: `\` 1. Function Composition using Space ' '
f : x ? x * 2
g : x ? x + 1
result : f g 3
`,
  partial_app: `\` 1. Partial Application using Hole (_)
f : x y ? x + y
partial : f _ 3
partial_result : partial 4

\` 2. Currying
curried : f 2
result_curried : curried 4

\` 3. Conditional Maybe Value (Value-based comparisons)
check : 10 < 5
check2 : 5 == 5
`,
  generator: `\` 1. Higher Order Function Recursive Mapping on Lazy Generator
f : x ? x * 2
map : g x ~y ? [@g x] [map g y~]

\` Range evaluation produces [0, 2, 4, 6, 8, 10]
result : map $[* 2,] [0 ~+ 2 ~ 10]
`,
  lists: `\` Atom vs Function Coproduct Resolution
a : 1
b : 2
c : 3

list1 : [a b c]
list2 : a b c
list3 : a b c , a b c
list4 : [a b c] [a b c]
list5 : [a b c] , [a b c]

list6 : [a , b , c] [a , b , c]
list7 : [a , b , c] , [a , b , c]
`,
  higher_order: `\` Recursive Map using Coproduct and Partial Application
f : x ? x * 2
map : g x ~y ? @g x , map g y~

result_map1 : map $f 1 2 3 4 5
result_map2 : map $[x ? x * 2] 1 2 3 4 5

result : result_map1
`,
  factorial: `\` Recursive Factorial (Packrat Parsing Test)
fact : x ?
	x = 0 : 1
	x = 1 : 1
	x * [fact [x - 1]]

result : fact 5
`,
  fold: `\` 1. Eager Fold (Trampoline Extraction)
add : x y ? x + y
fold_eager : f a x ~y ? fold_eager f [@f a x] y~

result_eager : fold_eager $add 0 1 2 3 4 5

\` 2. Lazy Fold (Thunk / Double Algebra)
fold_lazy : f a x ~y ? $fold_lazy f [@f a x] y~

step0 : fold_lazy $add 0 1 2 3
step1 : @step0 __
step2 : @step1 __
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
  jsOutput.textContent = '// Ready to transpile...';
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

    // Resolve Coproducts and Transpile Statements
    const jsStatements = [];
    const definedVars = [];

    astLines.forEach(astLine => {
      const resolved = resolveCoproducts(astLine, globalEnv);
      
      // Update the environment with the resolved AST to accurately track arity of partial applications
      buildEnvironment(resolved, globalEnv);

      // Collect defined variables for execution inspection
      if (resolved && resolved.type === 'operation' && resolved.operator === ':') {
        const identName = typeof resolved.left === 'string' ? resolved.left : (resolved.left.name || String(resolved.left));
        if (identName.startsWith('<') && identName.endsWith('>')) {
          definedVars.push(identName.slice(1, -1));
        }
      }

      const jsCode = transpile(resolved);
      if (jsCode) {
        jsStatements.push(jsCode);
      }
    });

    // Collect used identifiers to find undefined ones
    const usedIdents = new Set();
    astLines.forEach(line => collectIdentifiers(line, usedIdents));

    const undefinedIdents = [];
    usedIdents.forEach(id => {
      if (!globalEnv.has(`<${id}>`) && id !== '_' && id !== 'print') {
        undefinedIdents.push(id);
      }
    });

    const undefinedDeclarations = undefinedIdents.map(id => `const ${id} = Symbol.for('${id}');`).join('\n');

    // Build the AST JSON Output
    astOutput.textContent = JSON.stringify(astLines.length === 1 ? astLines[0] : astLines, null, 2);

    // 3. Assemble full JS script
    const runtimeHelpers = RUNTIME_HELPERS_CODE;

    const generatedCodeOnly = `${undefinedDeclarations}\n${jsStatements.map(s => s + ';').join('\n')}`;
    jsOutput.textContent = generatedCodeOnly;

    logToConsole('Compilation successful!', 'success-msg');

    // 4. Run transpiled code in browser
    logToConsole('Executing code...', 'system-msg');

    // Intercept standard console.log inside run block
    window.console.log = (msg) => {
      logToConsole(msg, 'log-msg');
      originalConsoleLog(msg);
    };

    const executionCode = `
(() => {
  const _ = window._;
  const util = { inspect: window.inspect };
  
  ${runtimeHelpers}
  
  ${generatedCodeOnly}
  
  // Custom Logging Block
  console.log("=== Transpiled Execution Results ===");
  ${definedVars.map(v => `try { console.log("${v} = " + util.inspect(${v})); } catch(e) {}`).join('\n')}
})()
    `;

    try {
      // Direct eval in IIFE scope
      eval(executionCode);
      logToConsole('Execution completed successfully.', 'success-msg');
    } catch (err) {
      logToConsole(`Runtime Error: ${err.message}`, 'error-msg');
      originalConsoleError(err);
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
