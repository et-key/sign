// playground.js
import { preprocess } from '../pre_alpha/lexisize/lexer.js';
import * as parser from '../pre_alpha/parse/minimal.js';
import { resolveCoproducts } from '../pre_alpha/semanticize/coproduct_resolver.js';
import { transpile } from '../pre_alpha/backend/js_codegen.js';

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
result : map $f [0 ~+ 2 ~ 10]
`,
  lists: `a : 1
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
  higher_order: `f : x ? x * 2
map : g x ~y ? [@g x] [map g y~]

result_map1 : map $f 1 2 3 4 5
result_map2 : map $[x ? x * 2] 1 2 3 4 5

result_sum : [+] 1 2 3 4 5
result_partial : [+ 2,] 1 2 3 4 5

test_array : 1 2 3 4 5
test_tuple : 1 a 3
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
    const runtimeHelpers = `
const __hole = Symbol.for('hole');

class Address {
  constructor(value) {
    this.value = value;
  }
}
const _deref = (x) => x instanceof Address ? x.value : x;

const _isTrue = (val) => {
  if (val === __hole) return false;
  if (Array.isArray(val) && val.length === 0) return false;
  return true;
};

const _concat = (a, b) => {
  if (a === __hole) return b;
  if (b === __hole) return a;
  const flatA = Array.isArray(a) ? a.flat(1) : [a];
  const flatB = Array.isArray(b) ? b.flat(1) : [b];
  const combined = flatA.concat(flatB);
  if (combined.some(x => typeof x === 'string')) {
    return combined.map(x => x === __hole ? '' : String(x)).join('');
  }
  return combined;
};

const _product = (left, right) => {
  const isArrayL = Array.isArray(left);
  const isArrayR = Array.isArray(right);
  if (!isArrayL && !isArrayR) {
    return [left, right];
  }
  if (!isArrayL && isArrayR) {
    const is1D = right.every(x => !Array.isArray(x));
    return is1D ? [left, ...right] : [[left], ...right];
  }
  if (isArrayL && !isArrayR) {
    const is1D = left.every(x => !Array.isArray(x));
    return is1D ? [...left, right] : [...left, [right]];
  }
  const is1DL = left.every(x => !Array.isArray(x));
  const is1DR = right.every(x => !Array.isArray(x));
  if (is1DL && is1DR) {
    return [left, right];
  }
  return [left, right];
};

class ExpandedObject {
  constructor(obj) {
    this.obj = obj;
  }
}
const _expand = (a) => {
  if (Array.isArray(a)) {
    if (a.length === 0) return [__hole];
    return a.flat(1);
  }
  if (a && typeof a === 'object' && !(a instanceof Address) && !(a instanceof ExpandedObject)) {
    return [new ExpandedObject(a)];
  }
  if (a === __hole || a === undefined || a === null) {
    return [__hole];
  }
  return [a];
};

function _resolveNamedArgs(fn, args) {
  const hasExpanded = args.some(arg => arg instanceof ExpandedObject);
  if (!hasExpanded) return args;

  const isCurried = fn.__isCurried;
  const target = isCurried ? fn.target : fn;
  const specs = target.paramSpecs || [];
  
  if (specs.length === 0) {
    return args.map(arg => arg instanceof ExpandedObject ? arg.obj : arg);
  }

  const resolvedArgs = [];
  const expandedArg = args.find(arg => arg instanceof ExpandedObject);
  const obj = expandedArg.obj || {};
  const consumedKeys = new Set();

  specs.forEach(spec => {
    const pName = spec.name;
    if (spec.isRest) {
      const restObj = {};
      for (const key of Object.keys(obj)) {
        if (!consumedKeys.has(key)) {
          restObj[key] = obj[key];
          restObj[Symbol.for(key)] = obj[key];
        }
      }
      resolvedArgs.push(restObj);
      consumedKeys.add(pName);
    } else {
      if (pName in obj) {
        resolvedArgs.push(obj[pName]);
        consumedKeys.add(pName);
      } else if (Symbol.for(pName) in obj) {
        resolvedArgs.push(obj[Symbol.for(pName)]);
        consumedKeys.add(pName);
      } else {
        resolvedArgs.push(__hole);
      }
    }
  });

  return resolvedArgs;
}

function _makePointFreeBinary(opFn) {
  const fn = (...args) => {
    if (args.length === 1 && Array.isArray(args[0])) {
      if (args[0].length === 0) return __hole;
      return args[0].reduce(opFn);
    }
    return args.reduce(opFn);
  };
  fn.__isPointFreeBinary = true;
  fn.target = opFn;
  return fn;
}

function _makePointFreeMapFilter(innerFn, isComparison) {
  const fn = (...args) => {
    const applyToArr = (arr) => {
      if (isComparison) {
        return arr.filter(x => _isTrue(innerFn(x)));
      } else {
        return arr.map(x => innerFn(x));
      }
    };
    if (args.length === 1 && Array.isArray(args[0])) {
      return applyToArr(args[0]);
    }
    return applyToArr(args);
  };
  fn.__isPointFreeMapFilter = true;
  fn.target = innerFn;
  fn.isComparison = isComparison;
  return fn;
}

function _makeCurried(fn, expectedLength, argsSoFar) {
  const wrapper = (...nextArgs) => {
    return _call(wrapper, ...nextArgs);
  };
  Object.defineProperties(wrapper, {
    __isCurried: { value: true },
    target: { value: fn },
    expectedLength: { value: expectedLength },
    args: { value: argsSoFar },
    length: { value: Math.max(0, expectedLength - argsSoFar.length) }
  });
  return wrapper;
}

function _applyArgs(fn, args) {
  return fn(...args);
}

function _call(left, ...args) {
  const resolvedArgs = _resolveNamedArgs(left, args);
  return _callInternal(left, ...resolvedArgs);
}

function _callInternal(left, ...args) {
  if (args.length === 0) return left;
  


  if (typeof left === 'function') {
    if (left.__isPointFreeBinary) {
      if (args.length === 1 && Array.isArray(args[0])) {
        if (args[0].length === 0) return __hole;
        return args[0].reduce(left.target);
      }
      return args.reduce(left.target);
    }
    if (left.__isPointFreeMapFilter) {
      return left(...args);
    }
  }

  if (Array.isArray(left)) {
    const hasFuncOrHole = left.some(x => typeof x === 'function' || x === __hole);
    if (hasFuncOrHole) {
      const flatArgs = args.flatMap(x => Array.isArray(x) ? x : [x]);
      let argIdx = 0;
      const result = [];
      for (const e of left) {
        if (typeof e === 'function') {
          const expectedLength = e.__isCurried ? e.length : (e.expectedLength !== undefined ? e.expectedLength : e.length);
          const k = expectedLength || 1;
          const subArgs = flatArgs.slice(argIdx, argIdx + k);
          while (subArgs.length < k) {
            subArgs.push(__hole);
          }
          result.push(_call(e, ...subArgs));
          argIdx += k;
        } else if (e === __hole) {
          if (argIdx < flatArgs.length) {
            result.push(flatArgs[argIdx]);
            argIdx++;
          } else {
            result.push(__hole);
          }
        } else {
          result.push(e);
        }
      }
      if (argIdx < flatArgs.length) {
        result.push(...flatArgs.slice(argIdx));
      }
      return result;
    }
  }
  
  const typeL = typeof left;
  
  if (typeL === 'function') {
    if (args.length === 1 && typeof args[0] === 'function') {
      const expectedL = left.__isCurried ? left.length : (left.expectedLength !== undefined ? left.expectedLength : left.length);
      if (expectedL === 1) {
        const right = args[0];
        const composedFn = (x) => {
          return _call(right, _call(left, x));
        };
        Object.defineProperty(composedFn, 'length', { value: right.length });
        return composedFn;
      }
    }
    
    const isCurried = left.__isCurried;
    const target = isCurried ? left.target : left;
    const argsSoFar = isCurried ? left.args : [];
    const expectedLength = isCurried ? left.expectedLength : (left.expectedLength !== undefined ? left.expectedLength : left.length);
    const hasRest = isCurried ? left.target.hasRest : left.hasRest;
    
    let totalArgs = [...argsSoFar, ...args];
    
    if (totalArgs.length > 0 && Array.isArray(totalArgs[totalArgs.length - 1])) {
      const lastIdx = totalArgs.length - 1;
      const argsBeforeLast = totalArgs.slice(0, lastIdx);
      if (argsBeforeLast.length < expectedLength) {
        totalArgs = [...argsBeforeLast, ...totalArgs[lastIdx]];
      }
    }
    
    if (hasRest) {
      if (totalArgs.length >= expectedLength - 1) {
        return _applyArgs(target, totalArgs);
      }
      return _makeCurried(target, expectedLength, totalArgs);
    } else {
      if (totalArgs.length >= expectedLength) {
        const invokeArgs = totalArgs.slice(0, expectedLength);
        const remainingArgs = totalArgs.slice(expectedLength);
        const res = _applyArgs(target, invokeArgs);
        if (remainingArgs.length > 0) {
          return _call(res, ...remainingArgs);
        }
        return res;
      }
      return _makeCurried(target, expectedLength, totalArgs);
    }
  }
  
  if (typeof args[0] === 'function') {
    const res = _call(args[0], left);
    return _call(res, ...args.slice(1));
  }
  const res = _concat(left, args[0]);
  return _call(res, ...args.slice(1));
}

const _arithmetic = (op, left, right) => {
  if (left === __hole || right === __hole) return __hole;

  if (typeof left === 'string') {
    throw new TypeError("Type Error: Arithmetic operation not supported on String");
  }

  if (Array.isArray(left)) {
    return left.map(x => _arithmetic(op, x, right));
  }

  if (typeof right === 'string') {
    const parsed = parseFloat(right);
    const val = isNaN(parsed) ? 0 : parsed;
    return _arithmetic(op, left, val);
  }

  if (Array.isArray(right)) {
    return right.map(y => _arithmetic(op, left, y));
  }

  switch (op) {
    case '+': return left + right;
    case '-': return left - right;
    case '*': return left * right;
    case '/': return left / right;
    case '%': return left % right;
    case '^': return Math.pow(left, right);
    default: return left;
  }
};

const _compare = (op, left, right) => {
  let cond = false;
  switch (op) {
    case '==':
    case '=':
      cond = Object.is(left, right);
      break;
    case '!==':
    case '!=':
      cond = !Object.is(left, right);
      break;
    case '<':
      cond = left < right;
      break;
    case '>':
      cond = left > right;
      break;
    case '<=':
      cond = left <= right;
      break;
    case '>=':
      cond = left >= right;
      break;
    default:
      cond = false;
  }
  if (cond) {
    if (left === 0 || left === 1 || left === __hole) {
      return right;
    }
    return left;
  }
  return __hole;
};

const _and = (left, right) => {
  if (!_isTrue(left)) return __hole;
  return right;
};

const _or = (left, right) => {
  if (_isTrue(left)) return left;
  return right;
};

const _xor = (left, right) => {
  const trueL = _isTrue(left);
  const trueR = _isTrue(right);
  if (trueL && !trueR) return left;
  if (!trueL && trueR) return right;
  return __hole;
};

const _not = (x) => _isTrue(x) ? __hole : 1;

const _factorial = (n) => {
  let r = 1;
  for (let i = 2; i <= n; i++) r *= i;
  return r;
};
`;

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

// Environment Map Helpers
function buildEnvironment(node, env = new Map()) {
  if (!node) return env;
  if (Array.isArray(node)) {
    node.forEach(n => buildEnvironment(n, env));
    return env;
  }
  if (typeof node === 'object') {
    let currentEnv = env;
    if (node.type === 'block' && (node.kind === 'indent' || node.kind === 'abs')) {
      currentEnv = new Map(env);
      node.env = currentEnv;
    }
    if (node.type === 'operation' && node.operator === ':') {
      const identName = typeof node.left === 'string' ? node.left : (node.left.name || String(node.left));
      const rightCat = getInitialCategory(node.right, currentEnv);
      currentEnv.set(identName, rightCat);
    }
    for (const key of Object.keys(node)) {
      if (key !== 'type' && key !== 'name' && key !== 'operator' && key !== 'kind' && key !== 'env') {
        buildEnvironment(node[key], currentEnv);
      }
    }
  }
  return env;
}

function getInitialCategory(node, env) {
  if (!node) return 'Atom';
  if (node.isLambda) return 'Lambda';
  if (typeof node === 'string') {
    if (env && env.has(node)) {
      const entry = env.get(node);
      return typeof entry === 'string' ? entry : (entry.category || 'Atom');
    }
    if (['print', '<print>', '_'].includes(node)) return 'Lambda';
    return 'Atom';
  }
  if (node.type === 'operation') {
    if (node.operator === '?') return 'Lambda';
    if (node.name === 'compose') return 'Lambda';
    if (node.name === 'apply') return getInitialCategory(node.left, env);
    if (node.name === 'get_prop' || node.name === 'get_at') return 'Lambda';
    return 'Atom';
  }
  if (node.type === 'block') {
    return getInitialCategory(node.content, env);
  }
  if (node.type === 'coproduct_block' && Array.isArray(node.statements) && node.statements.length > 0) {
    return getInitialCategory(node.statements[node.statements.length - 1], env);
  }
  return 'Atom';
}

function collectIdentifiers(node, set) {
  if (!node) return;
  if (typeof node === 'string') {
    if (node.startsWith('<') && node.endsWith('>')) {
      const name = node.slice(1, -1);
      if (isNaN(name)) {
        set.add(name);
      }
    }
    return;
  }
  if (Array.isArray(node)) {
    node.forEach(n => collectIdentifiers(n, set));
    return;
  }
  if (typeof node === 'object') {
    for (const key of Object.keys(node)) {
      if (key !== 'env') {
        collectIdentifiers(node[key], set);
      }
    }
  }
}

function desugarHoles(node) {
  if (!node) return node;
  if (typeof node !== 'object') return node;
  if (Array.isArray(node)) {
    return node.map(desugarHoles);
  }

  if (node.type === 'coproduct_block' && node.statements) {
    const holeIndices = [];
    node.statements.forEach((stmt, idx) => {
      if (stmt === '_') {
        holeIndices.push(idx);
      }
    });

    if (holeIndices.length > 0) {
      const paramNames = holeIndices.map((_, i) => `<$p${i}>`);
      const newStatements = [...node.statements];
      holeIndices.forEach((stmtIdx, i) => {
        newStatements[stmtIdx] = paramNames[i];
      });

      const lambdaLHS = paramNames.length === 1
        ? paramNames[0]
        : { type: 'coproduct_block', statements: paramNames };

      const lambdaRHS = {
        type: 'coproduct_block',
        statements: newStatements
      };

      const lambdaNode = {
        type: 'operation',
        operator: '?',
        left: lambdaLHS,
        right: lambdaRHS,
        name: 'lambda'
      };

      return desugarHoles(lambdaNode);
    }
  }

  const newNode = { ...node };
  for (const key of Object.keys(newNode)) {
    if (key !== 'env') {
      newNode[key] = desugarHoles(newNode[key]);
    }
  }
  return newNode;
}
