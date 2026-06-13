/**
 * js_codegen.js
 * 
 * Translates resolved Sign AST to clean, executable JavaScript utilizing white_cats.
 */

export function transpile(node) {
  if (node === undefined || node === null) return '';

  if (typeof node === 'string') {
    // Unwrap identifier brackets like <map_func> to map_func
    if (node.startsWith('<') && node.endsWith('>')) {
      const name = node.slice(1, -1);
      if (name === '_') return '__hole';
      return name;
    }
    // Number, String, or variables remain as is
    if (node === '_') return '__hole';
    return node;
  }

  if (node.type === 'block') {
    // Check for point-free operators, e.g., [+]
    if (node.kind === 'bracket' && node.content && node.content.type === 'operation' && 
        node.content.left === undefined && node.content.right === undefined) {
      return transpilePointFree(node.content);
    }

    if (node.kind === 'paren' || node.kind === 'group') {
      return `(${transpile(node.content)})`;
    }
    if (node.kind === 'bracket') {
      return `[${transpile(node.content)}]`;
    }
    if (node.kind === 'brace') {
      return `{ ${transpile(node.content)} }`;
    }
    if (node.kind === 'abs') {
      return `Math.abs(${transpile(node.content)})`;
    }
    if (node.kind === 'indent') {
      const stmts = flattenStatements(node.content);
      const parts = stmts.map((s, idx) => {
        if (isMatchCase(s)) {
          return `if (_isTrue(${transpile(s.left)})) return ${transpile(s.right)};`;
        }
        let code = transpile(s);
        if (idx === stmts.length - 1) {
          if (s.type === 'operation' && s.operator === ':') {
            const varName = transpile(s.left);
            return `${code}\n  return ${varName};`;
          } else {
            return `return ${code};`;
          }
        }
        return code + (code.endsWith(';') ? '' : ';');
      });
      if (stmts.length > 0 && isMatchCase(stmts[stmts.length - 1])) {
        parts.push(`return __hole;`);
      }
      return `(() => {\n  ${parts.join('\n  ')}\n})()`;
    }
  }

  if (node.type === 'coproduct_block') {
    // If we encounter an unresolved coproduct block (which shouldn't happen after resolution),
    // we default to array representation
    const elems = (node.statements || []).map(s => transpile(s));
    return `[${elems.join(', ')}]`;
  }

  if (node.type === 'operation') {
    // Infix Operators
    if (node.position !== 'prefix' && node.position !== 'postfix') {
      if (node.operator === ':') {
        const lhs = getDefineLHS(node.left);
        return `const ${lhs} = ${transpile(node.right)}`;
      }

      if (node.operator === '?') {
        const args = getArgNames(node.left);
        const hasRest = args.some(arg => arg.startsWith('...'));
        const fnExpr = `(${args.join(', ')}) => {\n  return ${transpile(node.right)};\n}`;
        return `(() => {\n  const _fn = ${fnExpr};\n  _fn.expectedLength = ${args.length};\n  _fn.hasRest = ${hasRest};\n  return _fn;\n})()`;
      }

      if (node.operator !== ',') {
        if (node.left === undefined || node.left === null) {
          const tempNode = { ...node, left: '<_x>' };
          return `((_x) => ${transpile(tempNode)})`;
        }
        if (node.right === undefined || node.right === null) {
          const tempNode = { ...node, right: '<_x>' };
          return `((_x) => ${transpile(tempNode)})`;
        }
      }

      // Space operator (resolved operations)
      if (node.operator === ' ') {
        return `_call(${transpile(node.left)}, ${transpile(node.right)})`;
      }

      if (node.operator === ',') {
        const lhs = node.left !== undefined && node.left !== null ? transpile(node.left) : '__hole';
        const rhs = node.right !== undefined && node.right !== null ? transpile(node.right) : '__hole';
        return `_product(${lhs}, ${rhs})`;
      }

      // Range operators
      if (node.operator === '~') {
        if (node.left && node.left.type === 'operation') {
          if (node.left.operator === '~+') {
            return `[..._._(${transpile(node.left.left)}, ${transpile(node.right)}, ${transpile(node.left.right)})]`;
          }
          if (node.left.operator === '~-') {
            return `[..._._(${transpile(node.left.left)}, ${transpile(node.right)}, -${transpile(node.left.right)})]`;
          }
        }
        return `[..._._(${transpile(node.left)}, ${transpile(node.right)})]`;
      }


      // Logical operators in Sign: & (and), | (or), ; (xor)
      if (node.operator === '&') {
        return `_and(${transpile(node.left)}, ${transpile(node.right)})`;
      }
      if (node.operator === '|') {
        return `_or(${transpile(node.left)}, ${transpile(node.right)})`;
      }
      if (node.operator === ';') {
        return `_xor(${transpile(node.left)}, ${transpile(node.right)})`;
      }

      // Bitwise operators in Sign: && (bitwise AND), || (bitwise OR), ;; (bitwise XOR)
      if (node.operator === '&&') {
        return `(${transpile(node.left)} & ${transpile(node.right)})`;
      }
      if (node.operator === '||') {
        return `(${transpile(node.left)} | ${transpile(node.right)})`;
      }
      if (node.operator === ';;') {
        return `(${transpile(node.left)} ^ ${transpile(node.right)})`;
      }

      // Exponentiation in Sign: ^
      if (node.operator === '^') {
        return `Math.pow(${transpile(node.left)}, ${transpile(node.right)})`;
      }

      // Comparisons in Sign: <, >, <=, >=, ==, !==, =, !=
      if (['<', '>', '<=', '>=', '==', '!==', '=', '!='].includes(node.operator)) {
        return `_compare('${node.operator}', ${transpile(node.left)}, ${transpile(node.right)})`;
      }

      // Standard binary ops
      return `(${transpile(node.left)} ${node.operator} ${transpile(node.right)})`;
    }

    // Prefix Operators
    if (node.position === 'prefix') {
      if (node.operator === '~') {
        return `${transpile(node.operand)}`;
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
      return `${node.operator}${transpile(node.operand)}`;
    }

    // Postfix Operators
    if (node.position === 'postfix') {
      if (node.operator === '~') {
        return `..._expand(${transpile(node.operand)})`;
      }
      if (node.operator === '!') {
        return `_factorial(${transpile(node.operand)})`;
      }
      if (node.operator === '@') {
        // Module import: convert file to import
        return `importModule(${transpile(node.operand)})`;
      }
      return `${transpile(node.operand)}${node.operator}`;
    }
  }

  return String(node);
}

function transpilePointFree(opNode) {
  const op = opNode.operator;
  if (op === '+') return '((x, y) => x + y)';
  if (op === '-') return '((x, y) => x - y)';
  if (op === '*') return '((x, y) => x * y)';
  if (op === '/') return '((x, y) => x / y)';
  if (op === '==') return '((x, y) => Object.is(x, y))';
  if (op === '<') return '((x, y) => x < y)';
  if (op === '>') return '((x, y) => x > y)';
  if (op === '<=') return '((x, y) => x <= y)';
  if (op === '>=') return '((x, y) => x >= y)';
  return `((x, y) => x ${op} y)`;
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
      if (content.operator === '+') return 'op_add';
      if (content.operator === '-') return 'op_sub';
      if (content.operator === '*') return 'op_mul';
      if (content.operator === '/') return 'op_div';
      if (content.operator === '|') return 'op_or';
    }
  }
  return transpile(left);
}

function isMatchCase(node) {
  if (!node) return false;
  if (node.type === 'operation' && node.operator === ':') {
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
