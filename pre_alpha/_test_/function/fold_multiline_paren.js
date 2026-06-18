
import _ from 'white_cats';
import util from 'util';


const __hole = Symbol.for('hole');
const __unit = Symbol.for('unit');

class Address {
  constructor(value) {
    this.value = value;
  }
}
const _deref = (x) => {
  if (x instanceof Address) return x.value;
  if (Array.isArray(x) && x.length > 0 && x[0] instanceof Address) {
    return [x[0].value, ...x.slice(1)];
  }
  return x;
};

const _isTrue = (val) => {
  if (val === __hole || val === __unit) return false;
  if (Array.isArray(val) && val.length === 0) return false;
  return true;
};

const _concat = (...args) => {
  const flats = args.map(a => Array.isArray(a) ? a.flat(1) : [a]).flat(1).filter(x => x !== __unit);
  if (flats.length === 0) return __unit;
  if (flats.some(x => typeof x === 'string')) {
    return flats.map(x => (x === __hole || x === __unit) ? '' : String(x)).join('');
  }
  return flats;
};

const _product = (left, right) => {
  if (left === __unit && right === __unit) return __unit;
  if (left === __unit) return right;
  if (right === __unit) return left;
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
    if (a.length === 0) return [__unit];
    return a.flat(1);
  }
  if (a && typeof a === 'object' && !(a instanceof Address) && !(a instanceof ExpandedObject)) {
    return [new ExpandedObject(a)];
  }
  if (a === undefined || a === null) {
    return [];
  }
  if (a === __hole || a === __unit) {
    return [__unit];
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
      if (args[0].length === 0) return __unit;
      return args[0].reduce(opFn);
    }
    return args.reduce(opFn);
  };
  fn.__isPointFreeBinary = true;
  fn.target = opFn;
  fn.expectedLength = 2;
  fn.hasRest = true;
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
  fn.expectedLength = 1;
  fn.hasRest = true;
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

const _compose = (left, right) => {
  if (left === __unit && right === __unit) return __unit;
  if (left === __unit) return right;
  if (right === __unit) return left;
  const composedFn = (...args) => {
    return _call(right, _call(left, ...args));
  };
  const rightLength = right.__isCurried ? right.length : (right.expectedLength !== undefined ? right.expectedLength : right.length);
  const hasRest = (left.hasRest || left.__isPointFreeBinary || left.__isPointFreeMapFilter) ||
                  (right.hasRest || right.__isPointFreeBinary || right.__isPointFreeMapFilter);
  Object.defineProperty(composedFn, 'length', { value: rightLength });
  composedFn.expectedLength = rightLength;
  composedFn.hasRest = hasRest;
  return composedFn;
}

function _call(left, ...args) {
  const resolvedArgs = _resolveNamedArgs(left, args);
  return _callInternal(left, ...resolvedArgs);
}

function _callInternal(left, ...args) {
  if (args.length === 0) return left;
  
  if (Array.isArray(left)) {
    if (left.length > 0 && typeof left[0] === 'function') {
      return _callInternal(left[0], ...left.slice(1), ...args);
    }
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

  if (args.includes(__unit)) {
    const fnObj = left.__isCurried ? left.target : left;
    if (fnObj && fnObj.paramSpecs) {
      const restIdx = fnObj.paramSpecs.findIndex(p => p.isRest);
      const itemIdx = restIdx > 0 ? restIdx - 1 : -1;
      if (itemIdx >= 0 && args[itemIdx] !== __unit) {
        // Defer extraction: the current item being processed is not __unit yet.
      } else {
        if (fnObj._extractIndex !== undefined && fnObj._extractIndex >= 0) {
          return args[fnObj._extractIndex];
        }
        return __unit;
      }
    } else {
      if (fnObj && fnObj._extractIndex !== undefined && fnObj._extractIndex >= 0) {
        return args[fnObj._extractIndex];
      }
      return __unit;
    }
  }

  const typeL = typeof left;
  
  if (typeL === 'function') {
    // 1. Check composition first
    if (args.length === 1 && typeof args[0] === 'function') {
      const expectedL = left.__isCurried ? left.length : (left.expectedLength !== undefined ? left.expectedLength : left.length);
      if (expectedL === 1) {
        const right = args[0];
        const composedFn = (...nextArgs) => {
          return _call(right, _call(left, ...nextArgs));
        };
        const rightLength = right.__isCurried ? right.length : (right.expectedLength !== undefined ? right.expectedLength : right.length);
        const hasRest = (left.hasRest || left.__isPointFreeBinary || left.__isPointFreeMapFilter) ||
                        (right.hasRest || right.__isPointFreeBinary || right.__isPointFreeMapFilter);
        Object.defineProperty(composedFn, 'length', { value: rightLength });
        composedFn.expectedLength = rightLength;
        composedFn.hasRest = hasRest;
        return composedFn;
      }
    }
  }

  if (typeL === 'function') {
    if (left.__isPointFreeBinary) {
      if (args.length === 1 && Array.isArray(args[0])) {
        if (args[0].length === 0) return __unit;
        return args[0].reduce(left.target);
      }
      return args.reduce(left.target);
    }
    if (left.__isPointFreeMapFilter) {
      return left(...args);
    }
  }


  if (typeL === 'function') {
    // 2. Standard Application / Currying
    const isCurried = left.__isCurried;
    const target = isCurried ? left.target : left;
    const argsSoFar = isCurried ? left.args : [];
    const expectedLength = isCurried ? left.expectedLength : (left.expectedLength !== undefined ? left.expectedLength : left.length);
    const requiredLength = isCurried ?
      (left.target.requiredLength !== undefined ? left.target.requiredLength : expectedLength) :
      (left.requiredLength !== undefined ? left.requiredLength : expectedLength);
    const hasRest = isCurried ? left.target.hasRest : left.hasRest;
    
    let totalArgs = [...argsSoFar, ...args];
    
    if (totalArgs.length > 0 && Array.isArray(totalArgs[totalArgs.length - 1])) {
      const lastIdx = totalArgs.length - 1;
      const argsBeforeLast = totalArgs.slice(0, lastIdx);
      
      const specs = target.paramSpecs || [];
      const isDestruct = specs[lastIdx] && specs[lastIdx].isDestructured;
      
      if (!isDestruct && argsBeforeLast.length < expectedLength) {
        totalArgs = [...argsBeforeLast, ...totalArgs[lastIdx]];
      }
    }
    
    totalArgs = totalArgs.filter(x => x !== __hole);
    
    while (totalArgs.length < requiredLength) {
      totalArgs.push(__hole);
    }
    
    if (totalArgs.includes(__hole)) {
      return [left, ...totalArgs];
    }
    
    if (hasRest) {
      return _applyArgs(target, totalArgs);
    }
    const invokeArgs = totalArgs.slice(0, expectedLength);
    const remainingArgs = totalArgs.slice(expectedLength);
    const res = _applyArgs(target, invokeArgs);
    if (remainingArgs.length > 0) {
      return _call(res, ...remainingArgs);
    }
    return res;
  }
  
  if (typeof args[0] === 'function') {
    const res = _call(args[0], left);
    return _call(res, ...args.slice(1));
  }
  const res = _concat(left, args[0]);
  return _call(res, ...args.slice(1));
}

const _arithmetic = (op, left, right) => {
  if (left === __unit || right === __unit) {
    return left === __unit ? right : left;
  }
  if (left === __hole || right === __hole) {
    return [Symbol.for(op), left, right];
  }

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
    if (left === 0 || left === 1 || left === __hole || left === __unit) {
      if (right === 0 || right === 1 || right === __hole || right === __unit) {
        return 1;
      }
      return right;
    }
    return left;
  }
  return __unit;
};

const _and = (left, right) => {
  if (!_isTrue(left)) return __unit;
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
  return __unit;
};

const _not = (x) => _isTrue(x) ? __unit : 1;

const _factorial = (n) => {
  let r = 1;
  for (let i = 2; i <= n; i++) r *= i;
  return r;
};

const _get_prop = (obj, prop) => {
  if (obj === undefined || obj === null) return __unit;
  const val = obj[prop];
  return val === undefined ? __unit : val;
};

const _overwrite = (obj, val) => {
  if (Array.isArray(val) && val.length >= 2) {
    const key = val[0];
    const value = val.length === 2 ? val[1] : val.slice(1);
    return { ...obj, [key]: value };
  }
  if (typeof val === 'object' && val !== null) {
    return { ...obj, ...val };
  }
  return obj;
};

const importModule = (name) => {
  if (name === 'javascript') {
    return typeof globalThis !== 'undefined' ? globalThis : (typeof window !== 'undefined' ? window : global);
  }
  // Dummy module implementation for playground
  return { __moduleName: name };
};

const _range = (start, end, step, type) => {
  const result = [];
  if (type === 'arithmetic') {
    const s = step || (start <= end ? 1 : -1);
    if (s > 0) {
      for (let i = start; i <= end; i += s) result.push(i);
    } else {
      for (let i = start; i >= end; i += s) result.push(i);
    }
  } else if (type === 'geometric') {
    const s = step || 2;
    if (start === 0) return [0];
    if (start <= end) {
      for (let i = start; i <= end; i *= s) result.push(i);
    } else {
      for (let i = start; i >= end; i /= s) result.push(i);
    }
  } else if (type === 'power') {
    const s = step || 2;
    if (start === 0) return [0];
    for (let i = start; i <= end; i = Math.pow(i, s)) {
      result.push(i);
      if (i === 1) break; // prevent infinite loop
    }
  }
  return result;
};


const x = __unit;
const xs = __unit;
const __ = __unit;
const f = (() => {
  const _fn = (x) => {
  return _arithmetic('*', x, 2);
};
  _fn.expectedLength = 1;
  _fn.requiredLength = 1;
  _fn.hasRest = false;
  _fn.paramSpecs = [{"name":"x","defaultValue":null,"isRest":false}];
  _fn._extractIndex = undefined;
  return _fn;
})();
const fold = (() => {
  const _fn = (f, a, _d0) => {
  const _d0_val = _expand(_d0);
  let [x, ...xs] = _d0_val;
  if (xs.length === 0) xs = __unit;
  else if (xs.length === 1) xs = xs[0];
  return (() => {
  if (_isTrue(_compare('==', xs, __unit))) return (_call(_deref(f), a, x));
  return _call(_compose(fold, f), (_call(_deref(f), a, x)), xs);
})();
};
  _fn.expectedLength = 3;
  _fn.requiredLength = 2;
  _fn.hasRest = false;
  _fn.paramSpecs = [{"name":"f","defaultValue":null,"isRest":false},{"name":"a","defaultValue":null,"isRest":false},{"name":"_destruct_pattern","defaultValue":null,"isRest":false,"isDestructured":true,"innerSpecs":[{"name":"x","defaultValue":null,"isRest":false},{"name":"xs","defaultValue":"__unit","isRest":true}]}];
  _fn._extractIndex = undefined;
  return _fn;
})();
const a = _call(fold, new Address(_makePointFreeBinary((x, y) => _arithmetic('+', x, y))), 0, (_concat(_concat(_concat(_concat(1, 2), 3), 4), 5)));

console.log("=== Transpiled Execution Results ===");
try { console.log("f = ", util.inspect(f, { depth: null, colors: true })); } catch(e) {}
try { console.log("fold = ", util.inspect(fold, { depth: null, colors: true })); } catch(e) {}
try { console.log("a = ", util.inspect(a, { depth: null, colors: true })); } catch(e) {}
