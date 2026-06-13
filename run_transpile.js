import fs from 'fs';
import path from 'path';
import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';
import { resolveCoproducts } from './pre_alpha/semanticize/coproduct_resolver.js';
import { transpile } from './pre_alpha/backend/js_codegen.js';
import { execSync } from 'child_process';
import util from 'util';

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

let globalEnv = new Map();
const astLines = astProg.filter(line => line !== null && line !== undefined);

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

// 3. Assemble the full executable JS file content
const runtimeHelpers = `
import _ from 'white_cats';
import util from 'util';

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
  if (typeof a === 'string') {
    return a + String(b);
  }
  const flatA = Array.isArray(a) ? a.flat(1) : [a];
  const flatB = Array.isArray(b) ? b.flat(1) : [b];
  return flatA.concat(flatB);
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

const _expand = (a) => Array.isArray(a) ? a.flat(1) : a;

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
  const holeIndices = [];
  for (let i = 0; i < args.length; i++) {
    if (args[i] === __hole) {
      holeIndices.push(i);
    }
  }
  if (holeIndices.length === 0) {
    return fn(...args);
  }
  const fillHoles = (...fillValues) => {
    const newArgs = [...args];
    let fillIdx = 0;
    for (let i = 0; i < newArgs.length; i++) {
      if (newArgs[i] === __hole && fillIdx < fillValues.length) {
        newArgs[i] = fillValues[fillIdx++];
      }
    }
    const remainingHoles = newArgs.filter(x => x === __hole).length;
    if (remainingHoles === 0) {
      const extra = fillValues.slice(fillIdx);
      return fn(...newArgs, ...extra);
    } else {
      return _applyArgs(fn, newArgs);
    }
  };
  Object.defineProperty(fillHoles, 'length', { value: holeIndices.length });
  if (fn.hasRest) {
    fillHoles.hasRest = true;
    fillHoles.expectedLength = holeIndices.length;
  }
  return fillHoles;
}

function _call(left, ...args) {
  if (args.length === 0) return left;
  
  if (left === __hole) {
    return _call(args[0], ...args.slice(1));
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
    // 1. Check composition first
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
    
    // 2. Standard Application / Currying
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

const loggingBlock = `
console.log("=== Transpiled Execution Results ===");
${definedVars.map(v => `try { console.log("${v} = ", util.inspect(${v}, { depth: null, colors: true })); } catch(e) {}`).join('\n')}
`;

const fullJsCode = `${runtimeHelpers}\n${undefinedDeclarations}\n${jsStatements.map(s => s + ';').join('\n')}\n${loggingBlock}`;

console.log("=== Generated JavaScript Code ===");
console.log(fullJsCode);

// 4. Write to a temporary file and execute it
const tempFilePath = path.join(process.cwd(), 'temp_transpiled_run.js');
fs.writeFileSync(tempFilePath, fullJsCode, 'utf8');

try {
  const output = execSync(`node ${tempFilePath}`, { encoding: 'utf8' });
  console.log(output);
} catch (err) {
  console.error("Execution error:", err.stdout || err.stderr || err.message);
} finally {
  // Clean up
  if (fs.existsSync(tempFilePath)) {
    fs.unlinkSync(tempFilePath);
  }
}

// --- Helper Functions to Replace Deleted builder.js ---

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
      // Ignore numeric strings or anything like numbers
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
