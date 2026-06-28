/**
 * js_codegen.js
 * 
 * Translates resolved Sign AST to clean, executable JavaScript utilizing white_cats.
 */
import { inferType } from '../semanticize/ast_helpers.js';

const operatorVarNames = {
  '+': 'op_add',
  '-': 'op_sub',
  '*': 'op_mul',
  '/': 'op_div',
  '|': 'op_or',
  '|/': 'op_or_div',
};
function getOperatorVarName(op) {
  if (operatorVarNames[op]) return operatorVarNames[op];
  const charMap = {
    '+': 'add', '-': 'sub', '*': 'mul', '/': 'div', '%': 'mod', '^': 'pow',
    '=': 'eq', '<': 'lt', '>': 'gt', '|': 'or', '&': 'and', ';': 'xor',
    '!': 'not', '~': 'range', '@': 'at', '#': 'hash', '?': 'question',
    ':': 'colon', "'": 'quote'
  };
  let name = 'op';
  for (const char of op) {
    name += '_' + (charMap[char] || char.charCodeAt(0).toString(16));
  }
  return name;
}

const functionContextStack = [false];
const inArgumentListStack = [false];

let currentEnv = null;

export function transpile(node, env = null) {
  if (node === undefined || node === null) return '';

  const savedEnv = currentEnv;
  if (env !== null) {
    currentEnv = env;
  }
  if (node && node.env) {
    currentEnv = node.env;
  }

  try {
    return _transpile(node);
  } finally {
    currentEnv = savedEnv;
  }
}

function transpilePropertyKey(propNode) {
  if (typeof propNode === 'string') {
    if (propNode.startsWith('<') && propNode.endsWith('>')) {
      const name = propNode.slice(1, -1);
      const hasDef = currentEnv && (currentEnv.has(propNode) || currentEnv.has(`<${name}>`) || currentEnv.has(name));
      if (!hasDef) {
        return JSON.stringify(name);
      }
    }
  }
  return transpile(propNode);
}

function _transpile(node) {
  if (node === undefined || node === null) return '';

  if (node.type === 'inline_code') {
    const val = node.value.trim();
    if (val.startsWith('js:')) {
      return val.slice(3).trim();
    }
    const match = val.match(/^([a-zA-Z0-9_]+):/);
    if (match && match[1] !== 'js') {
      return '';
    }
    return val;
  }

  if (typeof node === 'string') {
    // Unwrap identifier brackets like <map_func> to map_func
    if (node.startsWith('<') && node.endsWith('>')) {
      const name = node.slice(1, -1);
      if (name === '_') return '__hole';
      if (name === '__') return '__unit';
      const builtins = ['print', 'free', 'reduce_add', 'reduce_sub', 'reduce_mul', 'reduce_div'];
      if (builtins.includes(name)) {
        return name;
      }
      return `_sig_${name}`;
    }
    // Character literals: \a -> "a"
    if (node.startsWith('\\') && node.length === 2) {
      return JSON.stringify(node[1]);
    }
    // Unicode literals: 0u31 -> 0x31
    if (node.startsWith('0u')) {
      return `0x${node.slice(2)}`;
    }
    // Number, String, or variables remain as is
    if (node === '_') return '__hole';
    if (node === '__') return '__unit';
    return node;
  }

  if (node.type === 'block') {
    const pfCode = tryTranspilePointFree(node);
    if (pfCode !== null) return pfCode;

    if (node.kind === 'paren' || node.kind === 'group' || node.kind === 'bracket' || node.kind === 'brace') {
      functionContextStack.push(false);
      const res = `(${_transpile(node.content)})`;
      functionContextStack.pop();
      return res;
    }
    if (node.kind === 'abs') {
      functionContextStack.push(false);
      const res = `_abs(${_transpile(node.content)})`;
      functionContextStack.pop();
      return res;
    }
    if (node.kind === 'indent') {
      const stmts = flattenStatements(node.content);
      const allDefs = stmts.length > 0 && stmts.every(s => s.type === 'operation' && s.operator === ':');
      const defNames = [];
      const parts = stmts.map((s, idx) => {
        if (s.type === 'operation' && s.operator === ':') {
          const rawLhs = s.left;
          let name = null;
          if (typeof rawLhs === 'string') {
            name = _transpile(rawLhs);
          } else if (rawLhs && rawLhs.type === 'Identifier') {
            name = _transpile(rawLhs.name);
          }
          if (name && !name.startsWith('(') && !name.startsWith('[')) {
            defNames.push(name);
          }
        }

        const isFuncBody = functionContextStack[functionContextStack.length - 1];
        if (isMatchCase(s, isFuncBody)) {
          return `if (_isTrue(${_transpile(s.left)})) return ${_transpile(s.right)};`;
        }
        let code = _transpile(s);
        if (idx === stmts.length - 1) {
          if (s.type === 'operation' && s.operator === ':') {
            const varName = _transpile(s.left);
            if (allDefs && defNames.length > 0) {
              return `${code}\n  return { ${defNames.map(n => `${n}: ${n}`).join(', ')} };`;
            }
            return `${code}\n  return ${varName};`;
          } else {
            return `return ${code};`;
          }
        }
        return code + (code.endsWith(';') ? '' : ';');
      });
      const isFuncBody = functionContextStack[functionContextStack.length - 1];
      if (stmts.length > 0 && isMatchCase(stmts[stmts.length - 1], isFuncBody)) {
        parts.push(`return __hole;`);
      }
      return `(() => {\n  ${parts.join('\n  ')}\n})()`;
    }
  }

  if (node.type === 'coproduct_block') {
    const elems = (node.statements || []).map(s => _transpile(s));
    if (elems.length === 0) return '[]';

    // 静的最適化: 先頭が文字列リテラル（バッククォート等）の場合は、直接JSの文字列結合式にする
    const isStringLiteral = (s) => /^['"`]/.test(s) || s.startsWith('String(');

    if (isStringLiteral(elems[0])) {
      let joined = elems[0];
      for (let i = 1; i < elems.length; i++) {
        joined += ` + String(${elems[i]})`;
      }
      return `(${joined})`;
    }

    // それ以外（変数など）の場合は、実行時に左辺優先規則をシミュレートするIIFEを出力
    return `((arr) => {
      if (arr.length === 1) return arr[0];
      return arr.reduce((l, r) => {
        if (typeof l === 'string' || l instanceof String) {
          return l + String(r);
        }
        const isPlainObj = (o) => typeof o === 'object' && o !== null && !Array.isArray(o) && !(o instanceof Address);
        const hasObj = isPlainObj(l) || isPlainObj(r) || (Array.isArray(l) && l[0] && l[0].constructor && l[0].constructor.name === 'ExpandedObject') || (Array.isArray(r) && r[0] && r[0].constructor && r[0].constructor.name === 'ExpandedObject');
        if (hasObj) {
          const getObj = (x) => {
            if (Array.isArray(x)) return x[0] && typeof x[0] === 'object' && x[0].constructor && x[0].constructor.name === 'ExpandedObject' ? x[0].obj : {};
            return isPlainObj(x) ? x : {};
          };
          return { ...getObj(l), ...getObj(r) };
        }
        const toArr = (x) => Array.isArray(x) ? x : [x];
        return [...toArr(l), ...toArr(r)];
      });
    })([${elems.join(', ')}])`;
  }

  if (node.type === 'operation') {
    // Infix Operators
    if (node.position !== 'prefix' && node.position !== 'postfix') {
      if (node.operator !== ':' && node.operator !== '?' && node.operator !== ',' && node.operator !== ' ') {
        const opKey = `[${node.operator}]`;
        if (currentEnv && (currentEnv.has(opKey) || currentEnv.has(`<${opKey}>`))) {
          const varName = getOperatorVarName(node.operator);
          return `_call(${varName}, ${_transpile(node.left)}, ${_transpile(node.right)})`;
        }
      }
      if (node.operator === ':') {
        const lhs = getDefineLHS(node.left);
        if (node.right && node.right.type === 'operation' && node.right.operator === '@' && node.right.position === 'postfix') {
          let moduleName = '';
          const operand = node.right.operand;
          if (typeof operand === 'string' && operand.startsWith('<') && operand.endsWith('>')) {
            moduleName = operand.slice(1, -1);
          } else {
            moduleName = _transpile(operand);
          }
          if (moduleName === 'javascript') {
            return `const ${lhs} = typeof globalThis !== 'undefined' ? globalThis : (typeof window !== 'undefined' ? window : global)`;
          }
          return `import * as ${lhs} from './${moduleName}.js'`;
        }
        const rhs = _transpile(node.right);
        return `const ${lhs} = ${rhs}`;
      }

      if (node.operator === '?') {
        const specs = getParameterSpecs(node.left);
        let destructCounter = 0;
        const argsStr = specs.map(p => {
          if (p.isDestructured) {
            return `_d${destructCounter++}`;
          }
          return p.isRest ? `...${p.name}` : p.name;
        }).join(', ');

        // Find _extractIndex from RHS
        function extractTerms(n) {
          if (!n) return [];
          if (n.type === 'operation' && n.operator === ' ') {
            return [...extractTerms(n.left), ...extractTerms(n.right)];
          }
          if (n.type === 'coproduct_block') {
            return (n.statements || []).flatMap(extractTerms);
          }
          // Support unwrapping prefix operators like $ or @ to find the bracket block inside
          if (n.type === 'operation' && n.position === 'prefix') {
            return extractTerms(n.operand);
          }
          return [n];
        }

        let extractIndexCode = 'undefined';
        const rhsElems = extractTerms(node.right);
        const blockIdx = rhsElems.findIndex(s => s && s.type === 'block' && s.kind === 'bracket');
        if (blockIdx !== -1) {
          extractIndexCode = `${blockIdx - 1}`;
        }

        // Build maybe checks, default replacements, and destructuring unpacks
        const bodyLines = [];
        let dIdx = 0;
        specs.forEach(p => {
          if (p.isDestructured) {
            const tempVar = `_d${dIdx++}`;
            const valVar = `${tempVar}_val`;
            bodyLines.push(`  const ${valVar} = _expand(${tempVar});`);
            const patternNames = p.innerSpecs.map(ip => ip.name);
            const restName = p.innerSpecs.find(ip => ip.isRest)?.name;
            bodyLines.push(`  let ${patternNames.join(', ')};`);
            bodyLines.push(`  if (Array.isArray(${valVar}) && ${valVar}.length === 1 && ${valVar}[0] && typeof ${valVar}[0] === 'object' && ${valVar}[0].constructor.name === 'ExpandedObject') {`);
            bodyLines.push(`    const _dict = ${valVar}[0].obj;`);
            p.innerSpecs.forEach(ip => {
              if (ip.isRest) {
                bodyLines.push(`    ${ip.name} = { ..._dict };`);
                p.innerSpecs.filter(other => !other.isRest).forEach(other => {
                  bodyLines.push(`    delete ${ip.name}['${other.name}'];`);
                });
              } else {
                bodyLines.push(`    ${ip.name} = ('${ip.name}' in _dict) ? _dict['${ip.name}'] : __hole;`);
              }
            });
            bodyLines.push(`  } else if (Array.isArray(${valVar})) {`);
            bodyLines.push(`    [${p.innerSpecs.map(ip => ip.isRest ? `...${ip.name}` : ip.name).join(', ')}] = ${valVar};`);
            bodyLines.push(`  } else {`);
            bodyLines.push(`    ${patternNames[0]} = ${valVar};`);
            if (restName) bodyLines.push(`    ${restName} = __unit;`);
            bodyLines.push(`  }`);

            // Add rest checks for inner specs
            p.innerSpecs.forEach(ip => {
              if (ip.isRest) {
                bodyLines.push(`  if (${ip.name}.length === 0) ${ip.name} = __unit;`);
              } else if (ip.defaultValue !== null) {
                bodyLines.push(`  if (${ip.name} === undefined || ${ip.name} === __hole) ${ip.name} = ${ip.defaultValue};`);
              }
            });
            return;
          }
          if (p.isRest) {
            bodyLines.push(`  if (${p.name}.length === 0) ${p.name} = __unit;`);
            return;
          }
          if (p.defaultValue !== null) {
            bodyLines.push(`  if (${p.name} === undefined || ${p.name} === __hole) ${p.name} = ${p.defaultValue};`);
          }
        });

        const bodyCode = bodyLines.length > 0 ? bodyLines.join('\n') + '\n' : '';
        const hasRest = specs.some(p => p.isRest);
        functionContextStack.push(true);
        const rightCode = _transpile(node.right);
        functionContextStack.pop();
        const fnExpr = `(${argsStr}) => {\n${bodyCode}  return ${rightCode};\n}`;
        const reqLen = specs.filter(p => !p.isDestructured && p.defaultValue === null && !p.isRest).length;
        return `(() => {\n  const _fn = ${fnExpr};\n  _fn.expectedLength = ${specs.length};\n  _fn.requiredLength = ${reqLen};\n  _fn.hasRest = ${hasRest};\n  _fn.paramSpecs = ${JSON.stringify(specs)};\n  _fn._extractIndex = ${extractIndexCode};\n  return _fn;\n})()`;
      }

      if (node.operator !== ',') {
        if (node.left === undefined || node.left === null) {
          const tempNode = { ...node, left: '<_x>' };
          return `((_x) => ${_transpile(tempNode)})`;
        }
        if (node.right === undefined || node.right === null) {
          const tempNode = { ...node, right: '<_x>' };
          return `((_x) => ${_transpile(tempNode)})`;
        }
      }

      // Space operator (resolved operations)
      if (node.operator === ' ') {
        if (node.name === 'concat') {
          const typeL = inferType(node.left, currentEnv);
          const typeR = inferType(node.right, currentEnv);

          const leftHasTilde = (node.left && node.left.type === 'operation' && node.left.operator === '~' && node.left.position === 'postfix');
          const rightHasTilde = (node.right && node.right.type === 'operation' && node.right.operator === '~' && node.right.position === 'postfix');

          const lVal = leftHasTilde ? _transpile(node.left.operand) : _transpile(node.left);
          const rVal = rightHasTilde ? _transpile(node.right.operand) : _transpile(node.right);

          if (typeL === 'List' && typeR === 'List' && leftHasTilde && rightHasTilde) {
            return `[..._expand(${lVal}), ..._expand(${rVal})]`;
          }
          if (typeL === 'Dict' && typeR === 'Dict' && leftHasTilde && rightHasTilde) {
            return `{ ...(_expand(${lVal})[0]?.obj || {}), ...(_expand(${rVal})[0]?.obj || {}) }`;
          }
          if ((typeL === 'Dict' || typeR === 'Dict') && leftHasTilde && rightHasTilde) {
            return `{ ...(_expand(${lVal})[0]?.obj || {}), ...(_expand(${rVal})[0]?.obj || {}) }`;
          }
          if (typeL === 'Scalar' && typeR === 'List' && rightHasTilde) {
            return `[${lVal}, ..._expand(${rVal})]`;
          }
          if (typeL === 'List' && typeR === 'Scalar' && leftHasTilde) {
            return `[..._expand(${lVal}), ${rVal}]`;
          }
          if (typeL === 'Scalar' && typeR === 'Scalar' && !leftHasTilde && !rightHasTilde) {
            return `[${lVal}, ${rVal}]`;
          }

          return `((l, r) => {
            const isPlainObj = (o) => typeof o === 'object' && o !== null && !Array.isArray(o) && !(o instanceof Address);
            const hasObj = isPlainObj(l) || isPlainObj(r) || (Array.isArray(l) && l[0] && l[0].constructor && l[0].constructor.name === 'ExpandedObject') || (Array.isArray(r) && r[0] && r[0].constructor && r[0].constructor.name === 'ExpandedObject');
            if (hasObj) {
              const getObj = (x) => {
                if (Array.isArray(x)) return x[0] && typeof x[0] === 'object' && x[0].constructor && x[0].constructor.name === 'ExpandedObject' ? x[0].obj : {};
                return isPlainObj(x) ? x : {};
              };
              return { ...getObj(l), ...getObj(r) };
            }
            const toArr = (x) => Array.isArray(x) ? x : [x];
            return [...toArr(l), ...toArr(r)];
          })(${_transpile(node.left)}, ${_transpile(node.right)})`;
        }
        if (node.name === 'compose') {
          return `((...args) => ${_transpile(node.right)}(${_transpile(node.left)}(...args)))`;
        }
        if (node.name === 'apply') {
          if (node.left && node.left.type === 'operation' && node.left.name === 'compose') {
            const desugaredApply = {
              type: 'operation',
              operator: ' ',
              left: node.left.right,
              right: {
                type: 'operation',
                operator: ' ',
                left: node.left.left,
                right: node.right,
                name: 'apply'
              },
              name: 'apply'
            };
            return _transpile(desugaredApply);
          }

          let leftNode = node.left;
          while (leftNode && leftNode.type === 'block') {
            leftNode = leftNode.content;
          }
          let fnName = typeof leftNode === 'string' ? leftNode : (leftNode.name || '');
          if (fnName.startsWith('<') && fnName.endsWith('>')) {
            fnName = fnName.slice(1, -1);
          }
          const entry = currentEnv && (currentEnv.get(fnName) || currentEnv.get(`<${fnName}>`));
          const staticArity = entry ? entry.arity : undefined;
          const staticRequired = entry ? (entry.requiredLength !== undefined ? entry.requiredLength : entry.arity) : undefined;
          const isRealFunction = entry ? entry.isRealFunction : false;

          const args = [];
          if (node.right && node.right.type === 'coproduct_block') {
            node.right.statements.forEach(s => {
              args.push(...flattenConcat(s));
            });
          } else if (node.right !== undefined && node.right !== null) {
            args.push(...flattenConcat(node.right));
          }

          const hasExpandArg = args.some(arg => arg && arg.type === 'operation' && arg.operator === '~' && arg.position === 'postfix');
          const hasHole = args.some(arg => arg === '_' || arg === '__hole' || (arg && arg.type === 'Identifier' && arg.name === '_'));

          if (staticArity !== undefined && staticArity > 0 && !hasExpandArg) {
            const isVariadic = staticArity === Infinity;
            // (1) 引数の数が staticRequired 以上（または可変引数）で、Holeがない場合は直接呼び出し
            if ((args.length >= staticRequired || isVariadic) && !hasHole) {
              inArgumentListStack.push(true);
              const transpiledArgs = args.map(arg => _transpile(arg));
              inArgumentListStack.pop();

              const params = args.map((_, idx) => `_a${idx}`);
              const checks = params.map(p => `${p} === __unit`).join(' || ');
              const fnCall = `${_transpile(node.left)}(${params.join(', ')})`;
              if (params.length === 0) {
                return fnCall;
              }
              return `((${params.join(', ')}) => (${checks}) ? __unit : ${fnCall})(${transpiledArgs.join(', ')})`;
            }

            // (2) 引数が不足しているか、Holeがある場合は部分適用アロー関数
            if (args.length < staticRequired || hasHole) {
              inArgumentListStack.push(true);
              const arrowParams = [];
              const callArgs = [];
              let pIdx = 0;

              args.forEach(arg => {
                const isHole = arg === '_' || arg === '__hole' || (arg && arg.type === 'Identifier' && arg.name === '_');
                if (isHole) {
                  const paramName = `_p${pIdx++}`;
                  arrowParams.push(paramName);
                  callArgs.push(paramName);
                } else {
                  callArgs.push(_transpile(arg));
                }
              });

              const missingCount = isVariadic ? 0 : staticRequired - args.length;
              for (let k = 0; k < missingCount; k++) {
                const paramName = `_p${pIdx++}`;
                arrowParams.push(paramName);
                callArgs.push(paramName);
              }
              inArgumentListStack.pop();

              const checks = callArgs.map(a => `${a} === __unit`).join(' || ');
              const fnCall = `${_transpile(node.left)}(${callArgs.join(', ')})`;
              return `((${arrowParams.join(', ')}) => (${checks}) ? __unit : ${fnCall})`;
            }
          }

          // (3) 過剰適用、または静的 arity 不明な場合は軽量 _call
          inArgumentListStack.push(true);
          let flatArgs = [];
          if (node.right && node.right.type === 'coproduct_block') {
            (node.right.statements || []).forEach(s => {
              flatArgs.push(...flattenConcat(s));
            });
          } else if (node.right !== undefined && node.right !== null) {
            flatArgs.push(...flattenConcat(node.right));
          }

          const argsCode = flatArgs.map(s => {
            const code = _transpile(s);
            if (s && s.type === 'operation' && s.operator === '~' && s.position === 'postfix') {
              return `new ExpandedStream(_expand(${_transpile(s.operand)}))`;
            }
            return code;
          }).join(', ');
          inArgumentListStack.pop();
          return `_call(${_transpile(node.left)}, ${argsCode})`;
        }

        // Unresolved space operator
        inArgumentListStack.push(true);
        const rightEval = _transpile(node.right);
        inArgumentListStack.pop();
        return `_call(${_transpile(node.left)}, ${rightEval})`;
      }

      if (node.operator === ',') {
        const leaves = flattenProduct(node);
        const transpiledLeaves = leaves.map(leaf => leaf !== undefined && leaf !== null ? _transpile(leaf) : '__hole');
        return `((...elems) => {
          const filtered = elems.filter(x => x !== __unit);
          if (filtered.length === 0) return __unit;
          if (filtered.length === 1) return filtered[0];
          const allArrays = filtered.every(x => Array.isArray(x));
          if (allArrays) return filtered;
          const flat = [];
          for (const x of filtered) {
            if (Array.isArray(x)) {
              flat.push(...x);
            } else {
              flat.push(x);
            }
          }
          return flat;
        })(${transpiledLeaves.join(', ')})`;
      }

      // Range operators
      if (['~+', '~-', '~*', '~/', '~^'].includes(node.operator)) {
        let type = 'arithmetic';
        let step = _transpile(node.right);
        if (node.operator === '~-') {
          step = `-(${step})`;
        } else if (node.operator === '~*') {
          type = 'geometric';
        } else if (node.operator === '~/') {
          type = 'geometric';
          step = `1/(${step})`;
        } else if (node.operator === '~^') {
          type = 'power';
        }
        return `_range(${_transpile(node.left)}, null, ${step}, '${type}')`;
      }

      if (node.operator === '~') {
        if (node.left && node.left.type === 'operation') {
          if (node.left.operator === '~+') {
            return `_range(${_transpile(node.left.left)}, ${_transpile(node.right)}, ${_transpile(node.left.right)}, 'arithmetic')`;
          }
          if (node.left.operator === '~-') {
            return `_range(${_transpile(node.left.left)}, ${_transpile(node.right)}, -(${_transpile(node.left.right)}), 'arithmetic')`;
          }
          if (node.left.operator === '~*') {
            return `_range(${_transpile(node.left.left)}, ${_transpile(node.right)}, ${_transpile(node.left.right)}, 'geometric')`;
          }
          if (node.left.operator === '~/') {
            return `_range(${_transpile(node.left.left)}, ${_transpile(node.right)}, 1/(${_transpile(node.left.right)}), 'geometric')`;
          }
          if (node.left.operator === '~^') {
            return `_range(${_transpile(node.left.left)}, ${_transpile(node.right)}, ${_transpile(node.left.right)}, 'power')`;
          }
        }
        return `_range(${_transpile(node.left)}, ${_transpile(node.right)}, null, 'arithmetic')`;
      }


      // Logical operators in Sign: & (and), | (or), ; (xor)
      if (node.operator === '&') {
        const left = _transpile(node.left);
        const right = _transpile(node.right);
        return `((_l) => _isTrue(_l) ? ${right} : __unit)(${left})`;
      }
      if (node.operator === '|') {
        const left = _transpile(node.left);
        const right = _transpile(node.right);
        return `((_l) => _isTrue(_l) ? _l : ${right})(${left})`;
      }
      if (node.operator === ';') {
        return `_xor(${_transpile(node.left)}, ${_transpile(node.right)})`;
      }

      // Bitwise operators in Sign: && (bitwise AND), || (bitwise OR), ;; (bitwise XOR), << (shift left), >> (shift right)
      if (node.operator === '&&') {
        return `(${_transpile(node.left)} & ${_transpile(node.right)})`;
      }
      if (node.operator === '||') {
        return `(${_transpile(node.left)} | ${_transpile(node.right)})`;
      }
      if (node.operator === ';;') {
        return `(${_transpile(node.left)} ^ ${_transpile(node.right)})`;
      }
      if (node.operator === '<<') {
        return `(${_transpile(node.left)} << ${_transpile(node.right)})`;
      }
      if (node.operator === '>>') {
        return `(${_transpile(node.left)} >> ${_transpile(node.right)})`;
      }

      // Exponentiation in Sign: ^
      if (node.operator === '^') {
        return `_arithmetic('^', ${_transpile(node.left)}, ${_transpile(node.right)})`;
      }

      // Comparisons in Sign: <, >, <=, >=, ==, !==, =, !=
      if (['<', '>', '<=', '>=', '==', '!=', '!==', '='].includes(node.operator)) {
        if (['<', '>', '<=', '>=', '=', '!='].includes(node.operator)) {
          const typeL = inferType(node.left, currentEnv);
          if (typeL === 'List') {
            throw new Error(`Compile Error: Operator '${node.operator}' cannot be applied to List types. Use structural comparison '==' or '!==' instead.`);
          }
        }
        const chain = destructureCompareChain(node);
        if (chain.ops.length > 1) {
          const firstOp = chain.ops[0];
          const allIdentical = chain.ops.every(op => op === firstOp);
          if (!allIdentical) {
            throw new Error(`Compile Error: Comparison operators in a chain must be identical. Got mixed operators: ${chain.ops.join(', ')}`);
          }

          const isEquality = (firstOp === '=' || firstOp === '==');
          if (!isEquality && chain.ops.length >= 3) {
            throw new Error(`Compile Error: Comparison chaining of 4 or more terms is not supported for operator '${firstOp}'.`);
          }

          const opsStr = chain.ops.map(op => `'${op}'`).join(', ');
          const exprsStr = chain.exprs.map(e => _transpile(e)).join(', ');
          return `_compareChain([${opsStr}], [${exprsStr}])`;
        }

        const typeL = inferType(node.left, currentEnv);
        const typeR = inferType(node.right, currentEnv);
        if (typeL === 'Scalar' && typeR === 'Scalar') {
          let jsOp = node.operator;
          if (jsOp === '=') jsOp = '===';
          if (jsOp === '!=') jsOp = '!==';
          return `((_l, _r) => (_l === __unit || _r === __unit) ? __unit : (_l ${jsOp} _r ? _l : __unit))(${_transpile(node.left)}, ${_transpile(node.right)})`;
        }
        return `_compare('${node.operator}', ${_transpile(node.left)}, ${_transpile(node.right)})`;
      }

      // Standard arithmetic binary ops: +, -, *, /, %
      if (['+', '-', '*', '/', '%'].includes(node.operator)) {
        const typeL = inferType(node.left, currentEnv);
        const typeR = inferType(node.right, currentEnv);
        if (['+', '-'].includes(node.operator) && typeL === 'List') {
          throw new Error(`Compile Error: Arithmetic operator '${node.operator}' cannot be applied to List types directly.`);
        }
        if (typeL === 'Scalar' && typeR === 'Scalar') {
          return `((_l, _r) => (_l === __unit || _r === __unit) ? __unit : _l ${node.operator} _r)(${_transpile(node.left)}, ${_transpile(node.right)})`;
        }
        return `_arithmetic('${node.operator}', ${_transpile(node.left)}, ${_transpile(node.right)})`;
      }

      // Object / Property / Module access
      if (node.operator === "'") {
        const typeL = inferType(node.left, currentEnv);
        const propCode = transpilePropertyKey(node.right);
        if (typeL === 'Dict' || (typeof node.left === 'string' && currentEnv && currentEnv.has(node.left) && currentEnv.get(node.left).category === 'Lambda')) {
          if (propCode.startsWith('"') && propCode.endsWith('"')) {
            const field = propCode.slice(1, -1);
            if (/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(field)) {
              return `${_transpile(node.left)}.${field}`;
            }
          }
          return `${_transpile(node.left)}[${propCode}]`;
        }
        return `_get_prop(${_transpile(node.left)}, ${propCode})`;
      }
      if (node.operator === '@') {
        const typeR = inferType(node.right, currentEnv);
        const propCode = transpilePropertyKey(node.left);
        if (typeR === 'Dict') {
          if (propCode.startsWith('"') && propCode.endsWith('"')) {
            const field = propCode.slice(1, -1);
            if (/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(field)) {
              return `${_transpile(node.right)}.${field}`;
            }
          }
          return `${_transpile(node.right)}[${propCode}]`;
        }
        return `_get_prop(${_transpile(node.right)}, ${propCode})`;
      }
      if (node.operator === '#') {
        return `_overwrite(${_transpile(node.left)}, ${_transpile(node.right)})`;
      }

      // Standard binary ops
      return `(${transpile(node.left)} ${node.operator} ${transpile(node.right)})`;
    }

    // Prefix Operators
    if (node.position === 'prefix') {
      if (['#', '##', '###'].includes(node.operator)) {
        const inner = _transpile(node.operand);
        return `export ${inner}`;
      }
      if (node.operator === '><') {
        return `_reverse(${transpile(node.operand)})`;
      }
      if (node.operator === '~') {
        return `[${transpile(node.operand)}]`;
      }
      if (node.operator === '$') {
        return `new Address(${transpile(node.operand)})`;
      }
      if (node.operator === '@') {
        return `_deref(${transpile(node.operand)})`;
      }
      if (node.operator === '!!') {
        return `~${transpile(node.operand)}`;
      }
      if (node.operator === '!') {
        return `_not(${transpile(node.operand)})`;
      }
      if (node.operator === '-') {
        return `_negate(${transpile(node.operand)})`;
      }
      return `${node.operator}${transpile(node.operand)}`;
    }

    // Postfix Operators
    if (node.position === 'postfix') {
      if (node.operator === '~') {
        return `_expand(${transpile(node.operand)})`;
      }
      if (node.operator === '!') {
        return `_factorial(${transpile(node.operand)})`;
      }
      if (node.operator === '@') {
        // Module import: convert file to import
        let moduleCode = '';
        const operand = node.operand;
        if (typeof operand === 'string' && operand.startsWith('<') && operand.endsWith('>')) {
          moduleCode = JSON.stringify(operand.slice(1, -1));
        } else {
          moduleCode = transpilePropertyKey(operand);
        }
        return `importModule(${moduleCode})`;
      }
      return `${transpile(node.operand)}${node.operator}`;
    }
  }

  return String(node);
}

function tryTranspilePointFree(node) {
  if (node.type !== 'block') return null;
  const content = node.content;
  if (!content || typeof content !== 'object') return null;

  // Only handle bracket, paren, brace blocks for point-free
  if (!['bracket', 'paren', 'brace'].includes(node.kind)) return null;

  // 1. Prefix point-free: [!_]
  if (content.type === 'operation' && content.position === 'prefix' && content.operand === '_') {
    const fnBody = transpile({ ...content, operand: 'x' });
    return `((x) => ${fnBody})`;
  }

  // 2. Postfix point-free: [_!]
  if (content.type === 'operation' && content.position === 'postfix' && content.operand === '_') {
    const fnBody = transpile({ ...content, operand: 'x' });
    return `((x) => ${fnBody})`;
  }

  // 3. Binary point-free: [+]
  if (content.type === 'operation' && content.position !== 'prefix' && content.position !== 'postfix' &&
    content.left === undefined && content.right === undefined) {
    const fnBody = transpile({ ...content, left: 'x', right: 'y' });
    return `_makePointFreeBinary((x, y) => ${fnBody})`;
  }

  // 4. Map/Filter point-free: [* 2,] or [2 +,]
  if (content.type === 'operation' && content.operator === ',') {
    // Case 4a: [2 +,] -> content.left is defined, content.right is undefined
    if (content.left !== undefined && content.right === undefined) {
      const innerOp = content.left;
      if (innerOp && innerOp.type === 'operation') {
        const isComp = ['<', '>', '<=', '>=', '==', '!=', '!==', '='].includes(innerOp.operator);
        const fnBody = transpile({ ...innerOp, right: 'x' });
        return `_makePointFreeMapFilter(((x) => ${fnBody}), ${isComp})`;
      }
    }
    // Case 4b: [* 2,] -> content.right is defined, content.left is undefined
    if (content.right !== undefined && content.left === undefined) {
      const innerOp = content.right;
      if (innerOp && innerOp.type === 'operation') {
        const isComp = ['<', '>', '<=', '>=', '==', '!=', '!==', '='].includes(innerOp.operator);
        const fnBody = transpile({ ...innerOp, left: 'x' });
        return `_makePointFreeMapFilter(((x) => ${fnBody}), ${isComp})`;
      }
    }
  }

  // 5. Comma-less partial binary point-free: [* 2] or [2 +]
  if (content.type === 'operation' && content.operator !== ',' &&
    content.position !== 'prefix' && content.position !== 'postfix') {
    if (content.left === undefined && content.right !== undefined) {
      const fnBody = transpile({ ...content, left: 'x' });
      return `((x) => ${fnBody})`;
    }
    if (content.right === undefined && content.left !== undefined) {
      const fnBody = transpile({ ...content, right: 'x' });
      return `((x) => ${fnBody})`;
    }
  }

  return null;
}

function flattenStatements(node) {
  if (!node) return [];
  if (node.type === 'operation' && node.operator === '\\n') {
    return [...flattenStatements(node.left), ...flattenStatements(node.right)];
  }
  return [node];
}

function getDefineLHS(left) {
  if (typeof left === 'string') {
    return transpile(left);
  }
  if (left.type === 'block' && left.kind === 'bracket') {
    const content = left.content;
    if (content && content.type === 'operation') {
      return getOperatorVarName(content.operator);
    }
  }
  return transpile(left);
}

function isMatchCase(node, isFuncBody = false) {
  if (!node) return false;
  if (node.type === 'operation' && node.operator === ':') {
    if (isFuncBody) return true;
    const left = node.left;
    if (left && typeof left === 'object' && left.type === 'operation') {
      return true;
    }
  }
  return false;
}

function getArgNames(node) {
  if (!node) return [];
  if (typeof node === 'string') {
    return [transpile(node)];
  }
  if (node.type === 'block') {
    return getArgNames(node.content);
  }
  if (node.type === 'operation') {
    if (node.operator === '\\n') {
      return [...getArgNames(node.left), ...getArgNames(node.right)];
    }
    if (node.operator === ' ' || node.operator === ',') {
      return [...getArgNames(node.left), ...getArgNames(node.right)];
    }
    if (node.operator === ':') {
      const param = transpile(node.left);
      const val = transpile(node.right);
      return [`${param} = ${val}`];
    }
    if (node.operator === '~' && node.left && node.right) {
      // In parameters, "x ~y" is parsed as range(x, y). Treat it as x and prefix ~y.
      return [
        ...getArgNames(node.left),
        ...getArgNames({ type: 'operation', operator: '~', operand: node.right, position: 'prefix' })
      ];
    }
    if (node.operator === '~' && node.position === 'prefix') {
      return getArgNames(node.operand).map(s => `...${s}`);
    }
    if (node.operator === '~' && node.position === 'postfix') {
      return getArgNames(node.operand).map(s => `...${s}`);
    }
  }
  return [transpile(node)];
}

function getParameterSpecs(node) {
  if (!node) return [];
  if (typeof node === 'string') {
    const name = transpile(node);
    return [{ name, defaultValue: null, isRest: false }];
  }
  if (node.type === 'block') {
    if (node.kind === 'bracket') {
      const innerSpecs = getParameterSpecs(node.content);
      const patternName = `_destruct_pattern`; // We'll just flag it and use innerSpecs to build it
      return [{ name: patternName, defaultValue: null, isRest: false, isDestructured: true, innerSpecs }];
    }
    return getParameterSpecs(node.content);
  }
  if (node.type === 'coproduct_block') {
    return (node.statements || []).flatMap(getParameterSpecs);
  }
  if (node.type === 'operation') {
    if (node.operator === '\\n') {
      return [...getParameterSpecs(node.left), ...getParameterSpecs(node.right)];
    }
    if (node.operator === ' ' || node.operator === ',') {
      return [...getParameterSpecs(node.left), ...getParameterSpecs(node.right)];
    }
    if (node.operator === ':') {
      const leftSpecs = getParameterSpecs(node.left);
      const name = leftSpecs.length > 0 ? leftSpecs[0].name : transpile(node.left);
      const isRest = leftSpecs.length > 0 ? leftSpecs[0].isRest : false;
      const defaultValue = transpile(node.right);
      return [{ name, defaultValue, isRest }];
    }
    if (node.operator === '~' && node.position === 'prefix') {
      return getParameterSpecs(node.operand).map(p => ({ ...p, isRest: true }));
    }
    if (node.operator === '~' && node.position === 'postfix') {
      return getParameterSpecs(node.operand).map(p => ({ ...p, isRest: true }));
    }
    if (node.operator === '~' && node.left && node.right) {
      // In parameters, "x ~y" is parsed as range(x, y). Treat it as x and prefix ~y.
      return [
        ...getParameterSpecs(node.left),
        ...getParameterSpecs({ type: 'operation', operator: '~', operand: node.right, position: 'prefix' })
      ];
    }
  }
  return [{ name: transpile(node), defaultValue: null, isRest: false }];
}

function destructureCompareChain(node) {
  const ops = [];
  const exprs = [];
  const compOps = ['<', '>', '<=', '>=', '==', '!==', '=', '!='];

  function traverse(n) {
    if (n && n.type === 'operation' && compOps.includes(n.operator)) {
      traverse(n.left);
      ops.push(n.operator);
      exprs.push(n.right);
    } else {
      exprs.push(n);
    }
  }

  traverse(node);
  return { ops, exprs };
}

function flattenConcat(node) {
  if (!node) return [];
  if (node.type === 'operation' && node.name === 'concat') {
    return [...flattenConcat(node.left), ...flattenConcat(node.right)];
  }
  return [node];
}

function flattenProduct(node) {
  if (!node) return [];
  if (node.type === 'operation' && node.operator === ',') {
    return [...flattenProduct(node.left), ...flattenProduct(node.right)];
  }
  return [node];
}
