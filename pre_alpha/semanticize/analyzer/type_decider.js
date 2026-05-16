export function createChildEnv(parent) {
  return new Map(parent);
}

export function substituteType(typeObj, bound_env) {
  if (!typeObj) return typeObj;
  
  if (typeObj.type === 'type_ref') {
    if (bound_env.has(typeObj.name)) {
      return bound_env.get(typeObj.name);
    }
    return typeObj;
  }
  
  if (typeObj.type === 'type_tuple') {
    return {
      ...typeObj,
      elements: typeObj.elements.map(e => substituteType(e, bound_env))
    };
  }
  
  if (typeObj.type === 'type_function') {
    return {
      ...typeObj,
      returnType: substituteType(typeObj.returnType, bound_env)
    };
  }
  
  if (typeObj.type === 'type_coproduct') {
    return {
      ...typeObj,
      variants: typeObj.variants.map(v => substituteType(v, bound_env))
    };
  }
  
  return typeObj;
}

export function applyTypes(fType, aType, isExplicitHole) {
  if (!fType) return { type: 'type_unknown' };

  // 1. Absorbing Element (Short-circuit on Evaluated Unit)
  if (fType.type === 'type_unit') return { type: 'type_unit' };
  if (!isExplicitHole && aType && aType.type === 'type_unit') return { type: 'type_unit' };

  // 2. Coproduct Distribution (Functor / Monad Mapping)
  if (fType.type === 'type_coproduct') {
    return {
      type: 'type_coproduct',
      variants: fType.variants.map(v => applyTypes(v, aType, isExplicitHole))
    };
  }
  if (aType && aType.type === 'type_coproduct') {
    return {
      type: 'type_coproduct',
      variants: aType.variants.map(v => applyTypes(fType, v, isExplicitHole))
    };
  }

  // 3. Normal Application (Currying / Destructuring / Execution)
  if (fType.type === 'type_function') {
    let newRemaining = [...(fType.remaining_args || fType.args || [])];
    let newHoles = [...(fType.holes || [])];
    let newBoundEnv = new Map(fType.bound_env || []);

    // Destructure Tuples / Arrays into multiple arguments
    let argsToApply = [];
    if (aType && aType.type === 'type_tuple') {
      argsToApply = [...aType.elements];
    } else if (aType && aType.type === 'type_array') {
      for (let i = 0; i < aType.length; i++) {
        argsToApply.push(aType.elementType);
      }
    } else if (aType) {
      argsToApply = [aType];
    }

    if (isExplicitHole) {
      if (newRemaining.length > 0) {
        const nextArg = newRemaining.shift();
        newHoles.push(nextArg);
      }
    } else if (newHoles.length > 0) {
      const holeArg = newHoles.shift();
      newBoundEnv.set(holeArg.name, argsToApply.length > 0 ? argsToApply[0] : { type: 'type_unknown' });
    } else {
      while (newRemaining.length > 0) {
        if (argsToApply.length === 0) {
           const nextArg = newRemaining[0];
           if (nextArg.type === 'type_list') {
              newRemaining.shift();
              newBoundEnv.set(nextArg.name, { type: 'type_array', elementType: null, length: 0 });
              continue;
           }
           break;
        }

        const nextArg = newRemaining.shift();
        if (nextArg.type === 'type_list') {
           // Rest parameter absorbs remaining args
           let restType;
           if (aType && aType.type === 'type_array') {
              restType = { type: 'type_array', elementType: aType.elementType, length: argsToApply.length };
           } else {
              restType = { type: 'type_tuple', elements: [...argsToApply] };
           }
           newBoundEnv.set(nextArg.name, restType);
           argsToApply = []; // consumed
        } else {
           const val = argsToApply.shift();
           if (val.type === 'type_unit') {
              newHoles.push(nextArg);
           } else if (val.type === 'type_default_signal') {
              if (nextArg.default_type) {
                 newBoundEnv.set(nextArg.name, nextArg.default_type);
              } else {
                 return { type: 'type_default_signal' }; // Short-circuit termination
              }
           } else if (val.type === 'type_variadic_end') {
              return { type: 'type_default_signal' }; // Terminate recursive list application
           } else {
              newBoundEnv.set(nextArg.name, val);
           }
        }
      }
    }

    if (newRemaining.length > 0 || newHoles.length > 0) {
      const newFunc = {
        type: 'type_function',
        args: fType.args,
        remaining_args: newRemaining,
        holes: newHoles,
        bound_env: newBoundEnv,
        lexical_env: fType.lexical_env,
        astNode: fType.astNode,
        returnType: fType.returnType
      };
      if (fType.lexical_env) Object.defineProperty(newFunc, 'lexical_env', { value: fType.lexical_env, enumerable: false });
      if (fType.astNode) Object.defineProperty(newFunc, 'astNode', { value: fType.astNode, enumerable: false });
      return newFunc;
    } else {
      // Abstract Interpretation Execution!
      if (fType.astNode && fType.lexical_env) {
         const execEnv = new Map(fType.lexical_env);
         for (const [k, v] of newBoundEnv.entries()) {
            execEnv.set(k, v);
         }
         console.log(`[Abstract Interpreter] Executing function. Bound keys:`, [...newBoundEnv.entries()].map(([k,v]) => `${k} = ${v.type || v.name}`));
         const execResult = substituteType(inferType(fType.astNode, execEnv), newBoundEnv);
         console.log(`[Abstract Interpreter] Result of execution:`, typeof formatTypeObj !== 'undefined' ? formatTypeObj(execResult) : execResult);
         return execResult;
      }
      return substituteType(fType.returnType, newBoundEnv);
    }
  }

  if (fType.type === 'type_deref' || fType.type === 'type_unknown') {
     // Abstract function application
     return { type: 'type_unknown' };
  }

  return null; // fallback
}

export function inferType(node, env) {
  if (!node) return { type: 'type_unknown' };

  if (typeof node === 'string') {
    if (node.startsWith('<')) {
      const name = node.slice(1, -1);
      if (name === '_') return { type: 'type_unit' };
      if (name === '..') return { type: 'type_default_signal' };
      if (env.has(name)) {
        return env.get(name);
      }
      return { type: 'type_ref', name }; // Generic / Unbound Name
    }
    if (node === '_') return { type: 'type_unit' };
    if (node === '..') return { type: 'type_default_signal' };
    if (node.startsWith('`') && node.endsWith('`')) return { type: 'type_primitive', name: 'string' };
    if (node.startsWith('0x') || node.startsWith('0r') || node.startsWith('0b') || node.startsWith('0u')) {
      return { type: 'type_primitive', name: 'i64' };
    }
    if (/^-?[0-9]+(\.[0-9]*)?$/.test(node)) return { type: 'type_primitive', name: 'f64' };
    return { type: 'type_unknown' };
  }

  if (node.type === 'operation') {
    if (node.semantic_tag === 'match_case') {
      const resultType = inferType(node.right, env);
      const fallbackGen = { type: 'type_ref', name: '__fallback__' };
      
      const funcType = {
        type: 'type_function',
        args: [fallbackGen],
        remaining_args: [fallbackGen],
        holes: [],
        bound_env: new Map(),
        returnType: { type: 'type_coproduct', variants: [resultType, fallbackGen] }
      };
      node.type_detail = funcType;
      return funcType;
    }

    if (node.position === 'prefix') {
      if (node.operator === '$') {
        const targetType = inferType(node.operand, env);
        const addrType = { type: 'type_address', target: targetType };
        node.type_detail = addrType;
        return addrType;
      }
      if (node.operator === '@') {
        const operandType = inferType(node.operand, env);
        if (operandType && operandType.type === 'type_address') {
          node.type_detail = operandType.target;
          return operandType.target;
        }
        const derefType = { type: 'type_deref', target: operandType };
        node.type_detail = derefType;
        return derefType;
      }

      if (node.operator === '~') {
        const listType = { type: 'type_list', name: 'unknown' };
        node.type_detail = listType;
        return listType;
      }
    }

    if (node.position === 'postfix') {
      if (node.operator === '~') {
         const targetType = inferType(node.operand, env);
         if ((targetType && targetType.type === 'type_array' && targetType.length === 0) || 
             (targetType && targetType.type === 'type_tuple' && targetType.elements.length === 0)) {
            node.type_detail = { type: 'type_variadic_end' };
            return node.type_detail;
         }
         node.type_detail = targetType;
         return targetType;
      }
    }

    if (node.operator === '.') {
      const fType = inferType(node.left, env);
      const gType = inferType(node.right, env);
      
      if (fType && fType.type === 'type_function' && gType && gType.type === 'type_function') {
        const composeReturn = applyTypes(fType, gType.returnType, false);
        const composeFunc = {
          type: 'type_function',
          args: gType.args,
          remaining_args: gType.remaining_args,
          holes: gType.holes,
          bound_env: gType.bound_env,
          returnType: composeReturn
        };
        node.type_detail = composeFunc;
        return composeFunc;
      }
      node.type_detail = { type: 'type_unknown' };
      return node.type_detail;
    }

    if (node.operator === ':') {
      let name = node.left;
      if (typeof name === 'string' && name.startsWith('<')) name = name.slice(1, -1);
      
      const rightType = inferType(node.right, env);
      if (name) {
        env.set(name, rightType);
        if (rightType && rightType.type === 'type_function' && rightType.lexical_env) {
           rightType.lexical_env.set(name, rightType); // Self-reference for recursion
        }
      }
      
      node.type_detail = rightType;
      return rightType;
    }

    if (node.operator === '?') {
      const childEnv = createChildEnv(env);
      
      // Collect arguments and bind them as generics in the child environment
      const args = [];
      function collectArgs(argNode) {
        if (!argNode) return;
        if (typeof argNode === 'string' && argNode.startsWith('<')) {
          const name = argNode.slice(1, -1);
          const genType = { type: 'type_ref', name };
          childEnv.set(name, genType);
          args.push(genType);
        } else if (argNode.type === 'operation' && argNode.operator === ':') {
          const t = inferType(argNode.right, childEnv);
          let name = argNode.left;
          if (typeof name === 'string' && name.startsWith('<')) {
            name = name.slice(1, -1);
            childEnv.set(name, t);
            args.push({ type: 'type_ref', name, default_type: t });
          }
        } else if (argNode.type === 'operation' && (argNode.operator === 'concat' || argNode.operator === 'apply')) {
          collectArgs(argNode.left);
          collectArgs(argNode.right);
        } else if (argNode.type === 'operation' && argNode.position === 'prefix') {
          if (argNode.operator === '~') {
            let name = argNode.operand;
            if (typeof name === 'string' && name.startsWith('<')) name = name.slice(1, -1);
            const listType = { type: 'type_list', name };
            childEnv.set(name, listType);
            args.push(listType);
          } else {
            collectArgs(argNode.operand);
          }
        } else if (argNode.type === 'operation' && argNode.position === 'postfix') {
          collectArgs(argNode.operand);
        } else if (argNode.type === 'coproduct_block' && argNode.statements) {
          argNode.statements.forEach(collectArgs);
        } else if (argNode.type === 'block') {
          if (Array.isArray(argNode.content)) {
            argNode.content.forEach(collectArgs);
          } else {
            collectArgs(argNode.content);
          }
        }
      }
      collectArgs(node.left);

      const returnType = inferType(node.right, childEnv);
      const funcType = { 
        type: 'type_function', 
        args, 
        remaining_args: [...args],
        holes: [],
        bound_env: new Map(),
        returnType 
      };
      Object.defineProperty(funcType, 'lexical_env', { value: new Map(env), enumerable: false });
      Object.defineProperty(funcType, 'astNode', { value: node.right, enumerable: false });
      node.type_detail = funcType;
      return funcType;
    }

    if (node.operator === 'apply') {
      const funcType = inferType(node.left, env);
      const argType = inferType(node.right, env);
      const isExplicitHole = (node.right === '__');
      
      const appliedType = applyTypes(funcType, argType, isExplicitHole);
      
      if (appliedType) {
        // Normalize nested coproducts
        let finalType = appliedType;
        if (finalType.type === 'type_coproduct') {
          const flat = [];
          for (const v of finalType.variants) {
            if (!v) continue;
            if (v.type === 'type_coproduct') flat.push(...v.variants);
            else flat.push(v);
          }
          const unique = [];
          for (const v of flat) {
            if (!unique.some(u => u.type === v.type && u.name === v.name)) {
               unique.push(v);
            }
          }
          if (unique.length === 1) finalType = unique[0];
          else finalType = { type: 'type_coproduct', variants: unique };
        }
        node.type_detail = finalType;
        return finalType;
      }
    }
    
    if (node.operator === 'concat') {
      const funcType = inferType(node.left, env);
      const argType = inferType(node.right, env);
      const concatType = { type: 'type_tuple', elements: [funcType, argType] };
        
        let elements = [];
        const extractElements = (t) => {
          if (t && t.type === 'type_tuple') {
            t.elements.forEach(extractElements);
          } else if (t && t.type === 'type_array') {
            for (let i = 0; i < t.length; i++) {
              elements.push(t.elementType);
            }
          } else if (t && t.type === 'type_default_signal') {
            // Id morphism (identity) for concatenation
          } else {
            elements.push(t);
          }
        };
        extractElements(concatType);

        let isArray = elements.length > 0;
        const firstType = elements[0];
        
        for (let i = 1; i < elements.length; i++) {
          const current = elements[i];
          if (!current || !firstType) {
             console.error(`[Fatal] current or firstType is null in concat. elements:`, elements);
             isArray = false;
             break;
          }
          if (current.type !== firstType.type || current.name !== firstType.name) {
            isArray = false;
            break;
          }
        }
        
        let finalConcatType;
        if (isArray) {
          finalConcatType = { type: 'type_array', elementType: firstType, length: elements.length };
        } else {
          // If the list contains a `type_list`, we simplify it abstractly as `type_list`
          const hasList = elements.some(e => e && e.type === 'type_list');
          if (hasList) {
             finalConcatType = { type: 'type_list', name: 'abstract_list' };
          } else {
             finalConcatType = { type: 'type_tuple', elements };
          }
        }
        
        node.type_detail = finalConcatType;
        console.log(`[Concat] LHS:`, funcType, `RHS:`, argType, `Result:`, finalConcatType);
        return finalConcatType;
      }
      


    // Lookup operator in environment as `[op]`
    const opName = `[${node.operator}]`;
    if (env.has(opName)) {
      const opType = env.get(opName);
      if (opType && opType.type === 'type_function') {
        if (node.left) inferType(node.left, env);
        if (node.right) inferType(node.right, env);
        if (node.operand) inferType(node.operand, env);
        node.type_detail = opType.returnType;
        return opType.returnType;
      }
    }

    if (['+', '-', '*', '/'].includes(node.operator)) {
      if (node.left) inferType(node.left, env);
      if (node.right) inferType(node.right, env);
      const primType = { type: 'type_primitive', name: 'f64' };
      node.type_detail = primType;
      return primType;
    }

    if (['==', '<', '>'].includes(node.operator)) {
      const leftType = node.left ? inferType(node.left, env) : { type: 'type_unknown' };
      if (node.right) inferType(node.right, env);
      
      const coproductType = { 
        type: 'type_coproduct', 
        variants: [leftType, { type: 'type_unit' }] 
      };
      node.type_detail = coproductType;
      return coproductType;
    }

    const leftType = inferType(node.left, env);
    const rightType = inferType(node.right, env);
    const opType = inferType(node.operand, env);
    const resultType = rightType || leftType || opType || { type: 'type_unknown' };
    node.type_detail = resultType;
    return resultType;
  }

  if (node.type === 'block') {
    const childEnv = createChildEnv(env);
    let lastType = { type: 'type_unknown' };
    if (Array.isArray(node.content)) {
      for (const c of node.content) {
        lastType = inferType(c, childEnv);
      }
    } else {
      lastType = inferType(node.content, childEnv);
    }
    node.type_detail = lastType;
    return lastType;
  }

  if (node.type === 'coproduct_block' && node.statements) {
    const childEnv = createChildEnv(env);
    let lastType = { type: 'type_unknown' };
    for (const s of node.statements) {
      lastType = inferType(s, childEnv);
    }
    node.type_detail = lastType;
    return lastType;
  }

  return { type: 'type_unknown' };
}
