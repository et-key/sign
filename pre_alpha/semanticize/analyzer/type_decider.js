export function createChildEnv(parent) {
  return new Map(parent);
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
      const funcType = { type: 'type_function', args, returnType };
      node.type_detail = funcType;
      return funcType;
    }

    if (node.operator === 'apply') {
      const funcType = inferType(node.left, env);
      const argType = inferType(node.right, env);
      
      if (funcType && funcType.type === 'type_function') {
        // Abstract application (substitution of generics) could go here
        // For now, return the returnType of the function
        node.type_detail = funcType.returnType;
        return funcType.returnType;
      }
      node.type_detail = { type: 'type_unknown' };
      return node.type_detail;
    }

    if (node.operator === 'concat') {
      const leftType = inferType(node.left, env);
      const rightType = inferType(node.right, env);
      const concatType = { type: 'type_tuple', elements: [leftType, rightType] };
      node.type_detail = concatType;
      return concatType;
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

    if (['+', '-', '*', '/', '==', '<', '>'].includes(node.operator)) {
      if (node.left) inferType(node.left, env);
      if (node.right) inferType(node.right, env);
      const primType = { type: 'type_primitive', name: 'f64' };
      node.type_detail = primType;
      return primType;
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
