/**
 * js_codegen.js
 * 
 * Translates resolved Sign AST to clean, executable JavaScript utilizing white_cats.
 */

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
    return '';
  }

  if (typeof node === 'string') {
    // Unwrap identifier brackets like <map_func> to map_func
    if (node.startsWith('<') && node.endsWith('>')) {
      const name = node.slice(1, -1);
      if (name === '_') return '__hole';
      if (name === '__') return '__unit';
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
    // If we encounter an unresolved coproduct block (which shouldn't happen after resolution),
    // we default to array representation
    const elems = (node.statements || []).map(s => _transpile(s));
    return `[${elems.join(', ')}]`;
  }

  if (node.type === 'operation') {
    // Infix Operators
    if (node.position !== 'prefix' && node.position !== 'postfix') {
      if (node.operator === ':') {
        const lhs = getDefineLHS(node.left);
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
                bodyLines.push(`  else if (${ip.name}.length === 1) ${ip.name} = ${ip.name}[0];`);
              } else if (ip.defaultValue !== null) {
                bodyLines.push(`  if (${ip.name} === undefined || ${ip.name} === __hole) ${ip.name} = ${ip.defaultValue};`);
              }
            });
            return;
          }
          if (p.isRest) {
            bodyLines.push(`  if (${p.name}.length === 0) ${p.name} = __unit;`);
            bodyLines.push(`  else if (${p.name}.length === 1) ${p.name} = ${p.name}[0];`);
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
          return `_concat(${_transpile(node.left)}, ${_transpile(node.right)})`;
        }
        if (node.name === 'compose') {
          return `_compose(${_transpile(node.left)}, ${_transpile(node.right)})`;
        }
        if (node.name === 'apply') {
          inArgumentListStack.push(true);
          let argsCode;
          if (node.right && node.right.type === 'coproduct_block') {
            argsCode = (node.right.statements || []).map(s => {
              const code = _transpile(s);
              if (s.type === 'operation' && s.operator === '~' && s.position === 'postfix') {
                return `...${code}`;
              }
              return code;
            }).join(', ');
          } else {
            const code = _transpile(node.right);
            if (node.right && node.right.type === 'operation' && node.right.operator === '~' && node.right.position === 'postfix') {
              argsCode = `...${code}`;
            } else {
              argsCode = code;
            }
          }
          inArgumentListStack.pop();
          return `_call(${_transpile(node.left)}, ${argsCode})`;
        }
        
        // Unresolved space operator (should be resolved by semanticize, but handle safely)
        inArgumentListStack.push(true);
        const rightEval = _transpile(node.right);
        inArgumentListStack.pop();
        return `_call(${_transpile(node.left)}, ${rightEval})`;
      }

      if (node.operator === ',') {
        const lhs = node.left !== undefined && node.left !== null ? _transpile(node.left) : '__hole';
        const rhs = node.right !== undefined && node.right !== null ? _transpile(node.right) : '__hole';
        return `_product(${lhs}, ${rhs})`;
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
        return `_and(${_transpile(node.left)}, ${_transpile(node.right)})`;
      }
      if (node.operator === '|') {
        return `_or(${_transpile(node.left)}, ${_transpile(node.right)})`;
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
      if (['<', '>', '<=', '>=', '==', '!==', '=', '!='].includes(node.operator)) {
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
        return `_compare('${node.operator}', ${_transpile(node.left)}, ${_transpile(node.right)})`;
      }

      // Standard arithmetic binary ops: +, -, *, /, %
      if (['+', '-', '*', '/', '%'].includes(node.operator)) {
        return `_arithmetic('${node.operator}', ${_transpile(node.left)}, ${_transpile(node.right)})`;
      }

      // Object / Property / Module access
      if (node.operator === "'") {
        const propCode = transpilePropertyKey(node.right);
        return `_get_prop(${_transpile(node.left)}, ${propCode})`;
      }
      if (node.operator === '@') {
        const propCode = transpilePropertyKey(node.left);
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
        const moduleCode = transpilePropertyKey(node.operand);
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
      if (content.operator === '+') return 'op_add';
      if (content.operator === '-') return 'op_sub';
      if (content.operator === '*') return 'op_mul';
      if (content.operator === '/') return 'op_div';
      if (content.operator === '|') return 'op_or';
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
