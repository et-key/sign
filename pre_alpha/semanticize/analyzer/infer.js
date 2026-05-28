import { unify, newTVar, prune, instantiate } from './unify.js';
import { evaluate } from '../evaluator.js'; // To evaluate constants or imports if needed

export function infer(ast, env = new Map()) {
  if (ast === undefined || ast === null) return { type: 'Unit' };
  if (Array.isArray(ast)) {
    const types = ast.map(a => infer(a, env));
    return types.length === 1 ? types[0] : { type: 'coproduct_block', statements: types };
  }

  if (ast.type === 'file') {
    if (Array.isArray(ast.statements)) {
      const types = ast.statements.map(s => infer(s, env));
      return { type: 'coproduct_block', statements: types };
    }
    return ast;
  }

  if (typeof ast === 'string') {
    // Number literal
    if (!isNaN(ast) || ast.startsWith('0x')) return 'Number';
    // String literal
    if (ast.startsWith('`') && ast.endsWith('`')) return 'String';
    
    // Variable lookup
    if (env.has(ast)) {
      const binding = env.get(ast);
      if (binding.typeValue) {
        // Return a fresh instantiation of the type scheme
        return instantiate(binding.typeValue);
      }
    }
    
    // Unbound variable, assume it's a generic type variable
    const tvar = newTVar();
    env.set(ast, { typeValue: tvar });
    return tvar;
  }

  if (ast.type === 'Unit') return ast;

  if (ast.type === 'block') {
    if (ast.kind === 'paren' || ast.kind === 'group' || ast.kind === 'indent' || ast.kind === 'abs') {
      return infer(ast.content, env);
    }
    // Bracket or Brace
    if (ast.kind === 'bracket') {
      const innerType = infer(ast.content, env);
      return { ...ast, content: innerType };
    }
    return ast; // Brace or others
  }

  if (ast.type === 'coproduct_block') {
    if (Array.isArray(ast.statements)) {
      const types = ast.statements.map(s => infer(s, env));
      return types.length === 1 ? types[0] : { type: 'coproduct_block', statements: types };
    }
    return ast;
  }

  if (ast.type === 'Lambda') {
    const paramEnv = new Map(env);
    function bindParam(pNode) {
      if (!pNode) return newTVar();
      if (typeof pNode === 'string') {
        const t = newTVar();
        paramEnv.set(pNode, { typeValue: t });
        return t;
      }
      if (pNode.position === 'prefix' && pNode.operator === '~') {
        const t = newTVar();
        if (typeof pNode.operand === 'string') paramEnv.set(pNode.operand, { typeValue: t });
        return { type: 'block', kind: 'bracket', content: t };
      }
      return newTVar();
    }
    
    const paramTypes = ast.params.map(p => bindParam(p));
    const bodyType = infer(ast.body, paramEnv);
    
    let currentType = bodyType;
    for (let i = paramTypes.length - 1; i >= 0; i--) {
      currentType = { type: 'Func', from: paramTypes[i], to: currentType };
    }
    return currentType;
  }

  if (ast.type === 'operation') {
    // Address Operator ($)
    if (ast.operator === '$' && ast.position === 'prefix') {
      const innerType = infer(ast.operand, env);
      return { type: 'operation', operator: '$', operand: innerType, position: 'prefix' };
    }

    // Lambda / Apply shouldn't be handled here if they are 'Lambda' objects, but wait!
    // ast.type === 'operation' && ast.operator === '?' is the OLD representation.
    // If we still see it (e.g. unevaluated), we can handle it.
    if (ast.operator === '?') {
      const paramEnv = new Map(env);
      const tParam = newTVar();
      if (typeof ast.left === 'string') paramEnv.set(ast.left, { typeValue: tParam });
      const tBody = infer(ast.right, paramEnv);
      return { type: 'Func', from: tParam, to: tBody };
    }

    // Apply (<= or space)
    if (ast.operator === ' ' && ast.name === 'apply') {
      const fType = infer(ast.left, env);
      const argType = infer(ast.right, env);
      
      const retType = newTVar();
      const expectedFuncType = { type: 'Func', from: argType, to: retType };

      try {
        unify(fType, expectedFuncType);
      } catch (e) {
        console.error(`Type Error during application:`, e.stack || e.message);
      }
      return retType;
    }

    // Concat (<>)
    if (ast.operator === ' ' && ast.name === 'concat') {
      const lType = infer(ast.left, env);
      const rType = infer(ast.right, env);
      return { type: 'operation', operator: ' ', name: 'concat', left: lType, right: rType };
    }

    // Arithmetic, Product (,), Coproduct (|)
    if (['+', '-', '*', '/', ',', '|'].includes(ast.operator)) {
      if (ast.left === undefined && ast.right === undefined) {
        return { type: 'Func', from: 'Number', to: { type: 'Func', from: 'Number', to: 'Number' } };
      }
      if (ast.left === undefined) {
        const tArg = newTVar();
        const rType = infer(ast.right, env);
        return { type: 'Func', from: tArg, to: { type: 'operation', operator: ast.operator, left: tArg, right: rType } };
      }
      if (ast.right === undefined) {
        const tArg = newTVar();
        const lType = infer(ast.left, env);
        return { type: 'Func', from: tArg, to: { type: 'operation', operator: ast.operator, left: lType, right: tArg } };
      }
      const lType = infer(ast.left, env);
      const rType = infer(ast.right, env);
      
      if (['+', '-', '*', '/'].includes(ast.operator)) {
        try { unify(lType, 'Number'); unify(rType, 'Number'); } catch (e) { console.error('Type Error in arithmetic:', e.stack || e.message); }
        return 'Number';
      }
      
      return { type: 'operation', operator: ast.operator, left: lType, right: rType };
    }

    // Comparison
    if (['=', '!=', '>', '<', '>=', '<='].includes(ast.operator)) {
      if (ast.left === undefined && ast.right === undefined) {
        const t1 = newTVar();
        return { type: 'Func', from: t1, to: { type: 'Func', from: t1, to: { type: 'operation', operator: '|', left: t1, right: { type: 'Unit' } } } };
      }
      const lType = ast.left !== undefined ? infer(ast.left, env) : newTVar();
      const rType = ast.right !== undefined ? infer(ast.right, env) : newTVar();
      try { unify(lType, rType); } catch (e) { console.error('Type Error in comparison:', e.stack || e.message); }
      return { type: 'operation', operator: '|', left: lType, right: { type: 'Unit' } };
    }

    // Define (:)
    if (ast.operator === ':') {
      const dummy = newTVar();
      if (typeof ast.left === 'string') {
        env.set(ast.left, { typeValue: dummy });
      }
      const rType = infer(ast.right, env);
      try { unify(dummy, rType); } catch (e) { console.error('Type Error in define:', e.stack || e.message); }
      console.log(`[DEBUG infer] Defined ${ast.left}:`, JSON.stringify(applySubst(dummy)));
      return dummy;
    }

    // Prefix/Postfix modifiers (e.g. @)
    if (ast.position === 'prefix' || ast.position === 'postfix') {
      if (ast.operator === '@') {
        const opType = infer(ast.operand, env);
        if (opType && opType.type === 'operation' && opType.operator === '$' && opType.position === 'prefix') {
          return opType.operand;
        }
        // If not explicitly $, assume it's a TVar and we need it to be an address
        const inner = newTVar();
        try { unify(opType, { type: 'operation', operator: '$', position: 'prefix', operand: inner }); } catch (e) {}
        return inner;
      }
      if (ast.operator === '~') {
        const opType = infer(ast.operand, env);
        return { ...ast, operand: opType };
      }
    }
  }

  return ast;
}

// Applies substitutions iteratively to fully resolve types
export function applySubst(t, visited = new Set()) {
  if (t === undefined || t === null) return t;
  if (typeof t === 'string') return t;
  if (typeof t === 'object') {
    if (visited.has(t)) {
      if (t.type === 'tvar') return { type: 'cyclic_flag', id: t.id };
      return { type: 'cyclic_flag', id: 'object' };
    }
    visited.add(t);
  }

  const originalT = t;
  t = prune(t);
  
  if (t === undefined || t === null) {
    if (typeof originalT === 'object') visited.delete(originalT);
    return t;
  }
  if (typeof t === 'string') {
    if (typeof originalT === 'object') visited.delete(originalT);
    return t;
  }
  
  if (t.type === 'tvar') {
    if (typeof originalT === 'object') visited.delete(originalT);
    return t;
  }
  
  let res;
  if (Array.isArray(t)) {
    res = t.map(c => applySubst(c, visited));
  } else if (t.type === 'operation') {
    res = {
      ...t,
      left: t.left !== undefined ? applySubst(t.left, visited) : undefined,
      right: t.right !== undefined ? applySubst(t.right, visited) : undefined,
      operand: t.operand !== undefined ? applySubst(t.operand, visited) : undefined
    };
  } else if (t.type === 'block') {
    if (Array.isArray(t.content)) {
      res = { ...t, content: t.content.map(c => applySubst(c, visited)) };
    } else {
      res = { ...t, content: applySubst(t.content, visited) };
    }
  } else if (t.type === 'coproduct_block') {
    if (Array.isArray(t.statements)) {
      res = { ...t, statements: t.statements.map(s => applySubst(s, visited)) };
    } else {
      res = { ...t, statements: applySubst(t.statements, visited) };
    }
  } else if (t.type === 'Func') {
    res = { ...t, from: applySubst(t.from, visited), to: applySubst(t.to, visited) };
  } else {
    res = t;
  }
  
  if (typeof originalT === 'object') {
    visited.delete(originalT);
  }
  return res;
}
