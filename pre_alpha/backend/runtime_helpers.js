export const RUNTIME_HELPERS_CODE = `
const __hole = Symbol.for('hole');
const __unit = Symbol.for('unit');

class Address {
  constructor(value) {
    this.value = value;
  }
}
const _deref = (x) => {
  if (x instanceof Address) return x.value;
  if (Array.isArray(x)) {
    const flat = x.flat(Infinity);
    if (flat.length > 0 && flat[0] instanceof Address) {
      return [flat[0].value, ...flat.slice(1)];
    }
    return flat;
  }
  return x;
};

const _negate = (x) => {
  if (x === __unit || x === __hole) return x;
  if (Array.isArray(x)) return x.map(_negate);
  return -x;
};

const _isTrue = (val) => {
  if (val === __hole || val === __unit) return false;
  if (Array.isArray(val) && val.length === 0) return false;
  return true;
};



class ExpandedStream {
  constructor(stream) {
    this.stream = stream;
  }
}
class ExpandedObject {
  constructor(obj) {
    this.obj = obj;
  }
}
const _expand = (a) => {
  if (a && a.isStream) {
    return a;
  }
  if (Array.isArray(a)) {
    if (a.length === 1 && a[0] && a[0].isStream) {
      return a[0];
    }
    if (a.length === 0) return [__unit];
    return a.flat(1);
  }
  if (a === 0) {
    return {
      [Symbol.iterator]: function* () {
        const buffer = Buffer.alloc(1);
        while (true) {
          try {
            const bytesRead = fs.readSync(0, buffer, 0, 1, null);
            if (bytesRead === 0) break;
            yield buffer.toString('utf8', 0, bytesRead);
          } catch (e) {
            break;
          }
        }
      },
      isStream: true,
      start: a
    };
  }
  if (typeof a === 'number') {
    return {
      [Symbol.iterator]: function* () {
        let current = a;
        while (true) {
          yield current++;
        }
      },
      isStream: true,
      start: a
    };
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
    if (args.length === 1) {
      if (Array.isArray(args[0])) {
        return applyToArr(args[0]);
      }
      if (typeof args[0] === 'string') {
        return applyToArr([...args[0]]);
      }
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
    requiredLength: { value: fn.requiredLength !== undefined ? fn.requiredLength : expectedLength },
    args: { value: argsSoFar },
    hasRest: { value: !!fn.hasRest },
    length: { value: Math.max(0, expectedLength - argsSoFar.length) }
  });
  return wrapper;
}

function _call(fn, ...args) {
  if (Array.isArray(fn)) {
    if (fn.length > 0 && typeof fn[0] === 'function') {
      return _call(fn[0], ...fn.slice(1), ...args);
    }
  }
  if (typeof fn !== 'function') return __unit;

  const flattenedArgs = [];
  for (const arg of args) {
    if (arg instanceof ExpandedStream) {
      flattenedArgs.push(...arg.stream);
    } else {
      flattenedArgs.push(arg);
    }
  }

  const isCurried = fn.__isCurried;
  const target = isCurried ? fn.target : fn;
  const argsSoFar = isCurried ? fn.args : [];
  const expected = isCurried ? fn.expectedLength : (fn.expectedLength !== undefined ? fn.expectedLength : fn.length);
  const required = isCurried ? fn.requiredLength : (fn.requiredLength !== undefined ? fn.requiredLength : expected);
  const hasRest = !!target.hasRest;

  const totalArgs = [...argsSoFar, ...flattenedArgs];

  if (totalArgs.includes(__unit)) {
    const fnObj = fn.__isCurried ? fn.target : fn;
    if (fnObj && fnObj.paramSpecs) {
      const restIdx = fnObj.paramSpecs.findIndex(p => p.isRest);
      const itemIdx = restIdx > 0 ? restIdx - 1 : -1;
      if (itemIdx >= 0 && totalArgs[itemIdx] !== __unit) {
        // Defer extraction: the current item being processed is not __unit yet.
      } else {
        if (fnObj._extractIndex !== undefined && fnObj._extractIndex >= 0) {
          return totalArgs[fnObj._extractIndex];
        }
        return __unit;
      }
    } else {
      if (fnObj && fnObj._extractIndex !== undefined && fnObj._extractIndex >= 0) {
        return totalArgs[fnObj._extractIndex];
      }
      return __unit;
    }
  }

  if (totalArgs.length < required) {
    return _makeCurried(target, expected, totalArgs);
  }

  const invokeArgs = hasRest ? totalArgs : totalArgs.slice(0, expected);
  const remaining = hasRest ? [] : totalArgs.slice(expected);
  const res = target(...invokeArgs);
  if (remaining.length > 0) {
    return _call(res, ...remaining);
  }
  return res;
}

const _arithmetic = (op, left, right) => {
  if (left === __unit || right === __unit) {
    return __unit;
  }
  if (left === __hole || right === __hole) {
    return [Symbol.for(op), left, right];
  }

  if (typeof left === 'string' && left.length === 1) {
    const codePoint = left.codePointAt(0);
    return _arithmetic(op, codePoint, right);
  }

  if (typeof left === 'string') {
    throw new TypeError("Type Error: Arithmetic operation not supported on String");
  }

  if (Array.isArray(left) && typeof right === 'number') {
    if (op === '*') {
      const res = [];
      for (let i = 0; i < right; i++) {
        res.push(...left);
      }
      return res;
    }
    if (op === '^') {
      const res = [];
      for (let i = 0; i < right; i++) {
        res.push([...left]);
      }
      return res;
    }
    if (op === '/') {
      const res = [];
      const chunkSize = Math.ceil(left.length / right);
      for (let i = 0; i < left.length; i += chunkSize) {
        res.push(left.slice(i, i + chunkSize));
      }
      return res;
    }
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
  if (op !== '==' && op !== '=' && op !== '!==' && op !== '!=') {
    if (left === __unit || right === __unit) {
      return __unit;
    }
  }
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

const _compareChain = (ops, vals) => {
  for (let i = 0; i < ops.length; i++) {
    const res = _compare(ops[i], vals[i], vals[i+1]);
    if (res === __unit) return __unit;
  }
  return vals[1];
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

const _abs = (x) => {
  if (x === __unit) return __unit;
  if (x === __hole) return __hole;
  if (Array.isArray(x)) return x.length;
  if (typeof x === 'string') return x.length;
  if (typeof x === 'number') return Math.abs(x);
  return x;
};

const _reverse = (x) => {
  if (Array.isArray(x)) {
    return [...x].reverse();
  }
  if (typeof x === 'string') {
    return [...x].reverse().join('');
  }
  return x;
};

const _get_prop = (obj, prop) => {
  if (obj === undefined || obj === null) return __unit;
  
  if (Array.isArray(obj)) {
    if (typeof prop === 'number' && prop < 0) {
      const idx = obj.length + prop;
      return (idx >= 0 && idx < obj.length) ? obj[idx] : __unit;
    }
    if (Array.isArray(prop)) {
      const res = [];
      for (const p of prop) {
        if (p === __unit) continue;
        const val = _get_prop(obj, p);
        if (val !== __unit) {
          res.push(val);
        }
      }
      return res.length === 0 ? __unit : res;
    }
    if (prop && typeof prop === 'object' && prop.isStream) {
      const res = [];
      const iterator = prop[Symbol.iterator]();
      while (true) {
        const { value, done } = iterator.next();
        if (done) break;
        if (typeof value !== 'number' || value < 0 || value >= obj.length) {
          break;
        }
        res.push(obj[value]);
      }
      return res.length === 0 ? __unit : res;
    }
  }
  
  if (typeof obj === 'string') {
    if (typeof prop === 'number' && prop < 0) {
      const idx = obj.length + prop;
      return (idx >= 0 && idx < obj.length) ? obj[idx] : __unit;
    }
    if (Array.isArray(prop)) {
      let res = '';
      for (const p of prop) {
        if (p === __unit) continue;
        const val = _get_prop(obj, p);
        if (val !== __unit) {
          res += val;
        }
      }
      return res.length === 0 ? __unit : res;
    }
    if (prop && typeof prop === 'object' && prop.isStream) {
      const res = [];
      const iterator = prop[Symbol.iterator]();
      while (true) {
        const { value, done } = iterator.next();
        if (done) break;
        if (typeof value !== 'number' || value < 0 || value >= obj.length) {
          break;
        }
        res.push(obj[value]);
      }
      return res.length === 0 ? __unit : res.join('');
    }
  }

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
  if (end === null || end === undefined || end === __unit) {
    let nextFn;
    if (type === 'arithmetic') {
      const s = step === null || step === undefined ? 1 : step;
      nextFn = (curr) => curr + s;
    } else if (type === 'geometric') {
      const s = step === null || step === undefined ? 2 : step;
      nextFn = (curr) => curr * s;
    } else if (type === 'power') {
      const s = step === null || step === undefined ? 2 : step;
      nextFn = (curr) => Math.pow(curr, s);
    }
    
    return {
      [Symbol.iterator]: function* () {
        let current = start;
        while (true) {
          yield current;
          current = nextFn(current);
        }
      },
      isStream: true,
      start: start,
      step: step,
      type: type,
      nextFn: nextFn
    };
  }

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
`;
