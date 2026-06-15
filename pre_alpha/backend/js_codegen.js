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
      if (name === '_') return '__unit';
      return name;
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
    if (node === '_') return '__unit';
    return node;
  }

  if (node.type === 'block') {
    const pfCode = tryTranspilePointFree(node);
    if (pfCode !== null) return pfCode;

    if (node.kind === 'paren' || node.kind === 'group' || node.kind === 'bracket' || node.kind === 'brace') {
      return `(${transpile(node.content)})`;
    }
    if (node.kind === 'abs') {
      return `Math.abs(${transpile(node.content)})`;
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
            name = transpile(rawLhs);
          } else if (rawLhs && rawLhs.type === 'Identifier') {
            name = transpile(rawLhs.name);
          }
          if (name && !name.startsWith('(') && !name.startsWith('[')) {
            defNames.push(name);
          }
        }

        if (isMatchCase(s)) {
          return `if (_isTrue(${transpile(s.left)})) return ${transpile(s.right)};`;
        }
        let code = transpile(s);
        if (idx === stmts.length - 1) {
          if (s.type === 'operation' && s.operator === ':') {
            const varName = transpile(s.left);
            if (allDefs && defNames.length > 0) {
              return `${code}\n  return { ${defNames.map(n => `${n}: ${n}, [Symbol.for('${n}')]: ${n}`).join(', ')} };`;
            }
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
        const specs = getParameterSpecs(node.left);
        const argsStr = specs.map(p => p.isRest ? `...${p.name}` : p.name).join(', ');
        
        // Build maybe checks and default replacements
        const bodyLines = [];
        specs.forEach(p => {
          if (p.isRest) return;
          if (p.defaultValue !== null) {
            bodyLines.push(`  if (${p.name} === undefined || ${p.name} === __hole) ${p.name} = ${p.defaultValue};`);
          }
        });
        
        // If any parameter is still __hole, return __hole (Maybe monad propagation)
        const checkHoles = specs.filter(p => !p.isRest).map(p => `${p.name} === __hole`).join(' || ');
        if (checkHoles) {
          bodyLines.push(`  if (${checkHoles}) return __hole;`);
        }
        
        const bodyCode = bodyLines.length > 0 ? bodyLines.join('\n') + '\n' : '';
        const hasRest = specs.some(p => p.isRest);
        const fnExpr = `(${argsStr}) => {\n${bodyCode}  return ${transpile(node.right)};\n}`;
        const reqLen = specs.filter(p => p.defaultValue === null && !p.isRest).length;
        return `(() => {\n  const _fn = ${fnExpr};\n  _fn.expectedLength = ${specs.length};\n  _fn.requiredLength = ${reqLen};\n  _fn.hasRest = ${hasRest};\n  _fn.paramSpecs = ${JSON.stringify(specs)};\n  return _fn;\n})()`;
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
        if (node.name === 'concat') {
          return `_concat(${transpile(node.left)}, ${transpile(node.right)})`;
        }
        if (node.name === 'compose') {
          return `_compose(${transpile(node.left)}, ${transpile(node.right)})`;
        }
        if (node.name === 'apply') {
          if (node.right && node.right.type === 'coproduct_block') {
            const args = node.right.statements.map(s => transpile(s)).join(', ');
            return `_call(${transpile(node.left)}, ${args})`;
          }
          return `_call(${transpile(node.left)}, ${transpile(node.right)})`;
        }
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
        return `_arithmetic('^', ${transpile(node.left)}, ${transpile(node.right)})`;
      }

      // Comparisons in Sign: <, >, <=, >=, ==, !==, =, !=
      if (['<', '>', '<=', '>=', '==', '!==', '=', '!='].includes(node.operator)) {
        return `_compare('${node.operator}', ${transpile(node.left)}, ${transpile(node.right)})`;
      }

      // Standard arithmetic binary ops: +, -, *, /, %
      if (['+', '-', '*', '/', '%'].includes(node.operator)) {
        return `_arithmetic('${node.operator}', ${transpile(node.left)}, ${transpile(node.right)})`;
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

function getParameterSpecs(node) {
  if (!node) return [];
  if (typeof node === 'string') {
    const name = transpile(node);
    return [{ name, defaultValue: null, isRest: false }];
  }
  if (node.type === 'block') {
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
      const name = transpile(node.left);
      const defaultValue = transpile(node.right);
      return [{ name, defaultValue, isRest: false }];
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
