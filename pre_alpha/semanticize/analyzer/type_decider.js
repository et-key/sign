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

  // 3. Normal Application (Currying / Holes)
  if (fType.type === 'type_function') {
    const remaining = [...(fType.remaining_args || fType.args || [])];
    const holes = [...(fType.holes || [])];
    const bound_env = new Map(fType.bound_env || []);

    if (remaining.length > 0) {
      const p = remaining.shift();
      if (isExplicitHole) {
        holes.push(p);
      } else {
        bound_env.set(p.name, aType);
      }
    }

    if (remaining.length > 0) {
      return {
        type: 'type_function',
        args: remaining,
        remaining_args: remaining,
        holes,
        bound_env,
        returnType: fType.returnType
      };
    } else {
      if (holes.length > 0) {
        return {
          type: 'type_function',
          args: holes,
          remaining_args: [...holes],
          holes: [],
          bound_env,
          returnType: fType.returnType
        };
      } else {
        return substituteType(fType.returnType, bound_env);
      }
    }
  }

  return null; // fallback
}

export function inferType(node, env) {
  if (!node) return { type: 'type_unknown' };

  if (typeof node === 'string') {
    if (node.startsWith('<')) {
      const name = node.slice(1, -1);
      if (env.has(name)) {
        return env.get(name);
      }
      return { type: 'type_ref', name }; // Generic / Unbound Name
    }
    if (node === '_') return { type: 'type_unit' };
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
      const rightType = inferType(node.right, env);
      if (typeof node.left === 'string' && node.left.startsWith('<')) {
        const name = node.left.slice(1, -1);
        env.set(name, rightType);
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
        } else if (argNode.type === 'operation' && (argNode.position === 'prefix' || argNode.position === 'postfix')) {
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
      node.type_detail = funcType;
      return funcType;
    }

    if (node.operator === 'apply' || node.operator === 'concat') {
      const funcType = inferType(node.left, env);
      const argType = inferType(node.right, env);
      const isExplicitHole = (node.right === '_');
      
      const appliedType = applyTypes(funcType, argType, isExplicitHole);
      
      if (appliedType) {
        // Normalize nested coproducts
        let finalType = appliedType;
        if (finalType.type === 'type_coproduct') {
          const flat = [];
          for (const v of finalType.variants) {
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
      
      if (node.operator === 'concat') {
        const concatType = { type: 'type_tuple', elements: [funcType, argType] };
        node.type_detail = concatType;
        return concatType;
      }
      
      node.type_detail = { type: 'type_unknown' };
      return node.type_detail;
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
