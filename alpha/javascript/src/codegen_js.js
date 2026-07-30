/**
 * Sign Language JavaScript Code Generator (alpha/javascript)
 * 
 * 役割:
 * Pass 4 において、型情報・抽象構文木 (AST) を使い切り、
 * 実行可能でクリーンな JavaScript コードを生成します。
 */

import { inferType } from './ast_helpers.js';
import { RUNTIME_HELPERS_CODE } from './runtime_helpers.js';

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
    let val = node.value.trim();
    if (val.startsWith('js:')) {
      val = val.slice(3).trim();
    } else {
      const match = val.match(/^([a-zA-Z0-9_]+):/);
      if (match && match[1] !== 'js') return '';
    }
    
    const matches = val.match(/\\(\d+)/g);
    if (matches) {
      const nums = matches.map(m => parseInt(m.slice(1), 10));
      const maxParam = Math.max(...nums);
      const args = [];
      for (let i = 1; i <= maxParam; i++) {
        args.push(`_a${i}`);
      }
      const argsStr = args.join(', ');
      const body = val.replace(/\\(\d+)/g, (m, num) => `_a${num}`);
      return `((${argsStr}) => ${body})`;
    }
    return val;
  }

  if (typeof node === 'string') {
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
    if (node.startsWith('\\') && node.length === 2) {
      return JSON.stringify(node[1]);
    }
    if (node.startsWith('0u')) {
      return `0x${node.slice(2)}`;
    }
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

    const isStaticString = (s) => /^(['"`]).*\1$/.test(s);
    if (elems.length > 0 && elems.every(isStaticString)) {
      const combined = elems.map(s => s.slice(1, -1)).join('');
      const quote = elems[0][0];
      return `${quote}${combined}${quote}`;
    }

    const isStringLiteral = (s) => /^['"`]/.test(s) || s.startsWith('String(');
    if (isStringLiteral(elems[0])) {
      let joined = elems[0];
      for (let i = 1; i < elems.length; i++) {
        joined += ` + String(${elems[i]})`;
      }
      return `(${joined})`;
    }
    return `[${elems.join(', ')}]`;
  }

  if (node.type === 'operation') {
    if (node.operator === ':') {
      const lhs = _transpile(node.left);
      const rhs = _transpile(node.right);
      return `const ${lhs} = ${rhs}`;
    }

    if (node.operator === '?') {
      functionContextStack.push(true);
      const params = collectParams(node.left);
      const body = _transpile(node.right);
      functionContextStack.pop();

      const reqLen = params.filter(p => !p.isRest).length;

      let paramSetupStr = '';
      if (params.length > 0) {
        paramSetupStr = params.map((p, i) => {
          if (p.isRest) {
            return `const ${p.name} = _args.slice(${i});`;
          }
          return `const ${p.name} = _args[${i}] !== undefined ? _args[${i}] : __unit;`;
        }).join('\n  ');
      }

      let funcBody = body;
      if (node.right && node.right.type === 'block' && node.right.kind === 'indent') {
        funcBody = body;
      } else {
        funcBody = `return ${body};`;
      }

      const fnCode = `((..._args) => {\n  ${paramSetupStr}\n  ${funcBody}\n})`;
      return `Object.assign(${fnCode}, { expectedLength: ${params.length}, requiredLength: ${reqLen} })`;
    }

    if (node.operator === ' ') {
      if (node.name === 'apply') {
        const fn = _transpile(node.left);
        let argStr = '';
        if (node.right && node.right.type === 'coproduct_block') {
          argStr = (node.right.statements || []).map(s => _transpile(s)).join(', ');
        } else {
          argStr = _transpile(node.right);
        }
        return `_call(${fn}, ${argStr})`;
      }
      if (node.name === 'compose') {
        const f = _transpile(node.left);
        const g = _transpile(node.right);
        return `((..._args) => _call(${g}, _call(${f}, ..._args)))`;
      }
      if (node.name === 'concat') {
        const l = _transpile(node.left);
        const r = _transpile(node.right);
        return `[..._expand(${l}), ..._expand(${r})]`;
      }
    }

    if (node.operator === ',') {
      const l = _transpile(node.left);
      const r = _transpile(node.right);
      return `[..._expand(${l}), ..._expand(${r})]`;
    }

    if (['+', '-', '*', '/', '%', '^'].includes(node.operator)) {
      const l = _transpile(node.left);
      const r = _transpile(node.right);
      return `_arithmetic('${node.operator}', ${l}, ${r})`;
    }

    if (['<', '>', '<=', '>=', '=', '==', '!=', '!=='].includes(node.operator)) {
      const l = _transpile(node.left);
      const r = _transpile(node.right);
      return `_compare('${node.operator}', ${l}, ${r})`;
    }

    if (node.operator === '&') {
      const l = _transpile(node.left);
      const r = _transpile(node.right);
      return `_and(${l}, ${r})`;
    }

    if (node.operator === '|') {
      const l = _transpile(node.left);
      const r = _transpile(node.right);
      return `_or(${l}, ${r})`;
    }

    if (node.operator === ';') {
      const l = _transpile(node.left);
      const r = _transpile(node.right);
      return `_xor(${l}, ${r})`;
    }

    if (node.operator === "'") {
      const l = _transpile(node.left);
      const r = transpilePropertyKey(node.right);
      return `_get_prop(${l}, ${r})`;
    }

    if (node.position === 'prefix') {
      const op = node.operand ? _transpile(node.operand) : '';
      if (node.operator === '$') return `new Address(${op})`;
      if (node.operator === '@') return `_deref(${op})`;
      if (node.operator === '~') return `_expand(${op})`;
      if (node.operator === '!') return `_not(${op})`;
      if (node.operator === '-') return `_negate(${op})`;
    }

    if (node.position === 'postfix') {
      const op = node.operand ? _transpile(node.operand) : '';
      if (node.operator === '~') return `_expand(${op})`;
      if (node.operator === '!') return `_factorial(${op})`;
    }
  }

  return JSON.stringify(node);
}

function collectParams(paramNode) {
  const params = [];
  function rec(node) {
    if (!node) return;
    if (typeof node === 'string') {
      const name = _transpile(node);
      const isRest = node.startsWith('~') || node.startsWith('<~');
      params.push({ name, isRest });
      return;
    }
    if (node.type === 'coproduct_block') {
      (node.statements || []).forEach(rec);
      return;
    }
    if (node.type === 'block') {
      rec(node.content);
      return;
    }
    if (node.type === 'operation') {
      if (node.operator === ' ' || node.operator === ',') {
        rec(node.left);
        rec(node.right);
        return;
      }
      if (node.operator === '~' && node.position === 'prefix') {
        const name = _transpile(node.operand);
        params.push({ name: name.startsWith('~') ? name : '~' + name, isRest: true });
        return;
      }
    }
    params.push({ name: _transpile(node), isRest: false });
  }
  rec(paramNode);
  return params;
}

function flattenStatements(content) {
  if (!content) return [];
  if (Array.isArray(content)) return content.flatMap(flattenStatements);
  if (content.type === 'coproduct_block') return (content.statements || []).flatMap(flattenStatements);
  return [content];
}

function isMatchCase(node, isFuncBody) {
  if (!isFuncBody) return false;
  if (!node || node.type !== 'operation' || node.operator !== ':') return false;
  return true;
}

function tryTranspilePointFree(blockNode) {
  const content = blockNode.content;
  if (!content || content.type !== 'operation') return null;

  if (['+', '-', '*', '/', '%', '^'].includes(content.operator)) {
    if (content.left === undefined && content.right === undefined) {
      return `_makePointFreeBinary((a, b) => _arithmetic('${content.operator}', a, b))`;
    }
    if (content.left === undefined && content.right !== undefined) {
      const r = _transpile(content.right);
      return `_makePointFreeMapFilter((_x) => _arithmetic('${content.operator}', _x, ${r}), false)`;
    }
    if (content.left !== undefined && content.right === undefined) {
      const l = _transpile(content.left);
      return `_makePointFreeMapFilter((_x) => _arithmetic('${content.operator}', ${l}, _x), false)`;
    }
  }
  return null;
}

/**
 * プログラム全体を完全に実行可能な JS コード文字列に変換する
 */
export function transpileProgram(astLines, globalEnv) {
  const usedIdents = new Set();
  const { collectIdentifiers } = awaitImportAstHelpers();
  
  astLines.forEach(line => collectIdentifiers(line, usedIdents, globalEnv));

  const undefinedIdents = [];
  usedIdents.forEach(id => {
    if (!globalEnv.has(`<${id}>`) && !globalEnv.has(id) && id !== '_' && id !== 'print') {
      undefinedIdents.push(id);
    }
  });

  const builtins = ['print', 'free', 'reduce_add', 'reduce_sub', 'reduce_mul', 'reduce_div'];
  const undefinedDeclarations = undefinedIdents.map(id => {
    const name = builtins.includes(id) ? id : `_sig_${id}`;
    return `const ${name} = __unit;`;
  }).join('\n');

  const jsStatements = astLines.map(line => {
    const code = transpile(line, globalEnv);
    return code ? code + ';' : '';
  }).filter(Boolean);

  return `${RUNTIME_HELPERS_CODE}\n\n${undefinedDeclarations}\n\n${jsStatements.join('\n')}`;
}

function awaitImportAstHelpers() {
  // 同期呼び出し用のヘルパー
  return { collectIdentifiers: (node, set, env) => {
    if (!node) return;
    if (typeof node === 'string' && node.startsWith('<') && node.endsWith('>')) {
      const name = node.slice(1, -1);
      if (isNaN(name) && !env.has(node) && !env.has(`<${name}>`) && !env.has(name)) {
        set.add(name);
      }
    }
  }};
}
