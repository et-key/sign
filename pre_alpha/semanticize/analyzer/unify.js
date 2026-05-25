export let nextTVarId = 1;

export function newTVar() {
  return { type: 'tvar', id: `t${nextTVarId++}`, instance: null };
}

export function resetTVarCounter() {
  nextTVarId = 1;
}

export function prune(t) {
  if (t === undefined || t === null) return t;
  if (typeof t === 'string') return t;
  if (t.type === 'tvar') {
    if (t.instance !== null) {
      t.instance = prune(t.instance);
      return t.instance;
    }
    return t;
  }
  return t;
}

function occursInType(v, t2) {
  t2 = prune(t2);
  if (t2 === undefined || t2 === null) return false;
  if (t2 === v) return true;
  if (typeof t2 === 'string') return false;
  if (t2.type === 'operation') {
    return occursInType(v, t2.left) || occursInType(v, t2.right) || occursInType(v, t2.operand);
  }
  if (t2.type === 'block') {
    if (Array.isArray(t2.content)) {
      return t2.content.some(c => occursInType(v, c));
    }
    return occursInType(v, t2.content);
  }
  if (t2.type === 'Func') {
    return occursInType(v, t2.from) || occursInType(v, t2.to);
  }
  return false;
}

export function unify(t1, t2) {
  t1 = prune(t1);
  t2 = prune(t2);

  if (t1 === t2) return;

  if (t1 && t1.type === 'tvar') {
    t1.instance = t2;
    return;
  }
  
  if (t2 && t2.type === 'tvar') {
    t2.instance = t1;
    return;
  }

  // Primitive strings
  if (typeof t1 === 'string' && typeof t2 === 'string') {
    if (t1 !== t2) throw new Error(`Type mismatch: ${t1} != ${t2}`);
    return;
  }
  
  // Right-associate concat for easier unification
  if (t1 && t1.type === 'operation' && (t1.name === 'concat' || t1.operator === ' ')) {
    if (t1.left && t1.left.type === 'operation' && (t1.left.name === 'concat' || t1.left.operator === ' ')) {
      return unify(
        { ...t1, left: t1.left.left, right: { type: 'operation', operator: ' ', name: 'concat', left: t1.left.right, right: t1.right } },
        t2
      );
    }
  }
  if (t2 && t2.type === 'operation' && (t2.name === 'concat' || t2.operator === ' ')) {
    if (t2.left && t2.left.type === 'operation' && (t2.left.name === 'concat' || t2.left.operator === ' ')) {
      return unify(
        t1,
        { ...t2, left: t2.left.left, right: { type: 'operation', operator: ' ', name: 'concat', left: t2.left.right, right: t2.right } }
      );
    }
  }
  
  if (typeof t1 === 'string' || typeof t2 === 'string') {
    throw new Error(`Type mismatch: string vs object`);
  }

  // Bracket Block vs Concat (Auto-unpacking for Sign generators)
  // e.g. [A] unified with x <> ~y
  if (t1 && t1.type === 'block' && t1.kind === 'bracket' && t2 && t2.type === 'operation' && (t2.name === 'concat' || t2.operator === ' ')) {
    // Left of concat unifies with content of block (Head)
    unify(t1.content, t2.left);
    // Right of concat (~y) unifies with the entire block (Tail is same as full generator for infinite/homogeneous)
    unify(t1, t2.right);
    return;
  }
  // Symmetric case
  if (t2 && t2.type === 'block' && t2.kind === 'bracket' && t1 && t1.type === 'operation' && (t1.name === 'concat' || t1.operator === ' ')) {
    unify(t2.content, t1.left);
    unify(t2, t1.right);
    return;
  }

  // Continuous Prefix (~y) unified with a Block [A]
  if (t1 && t1.type === 'operation' && t1.operator === '~' && t1.position === 'prefix' && t2 && t2.type === 'block' && t2.kind === 'bracket') {
    // Unify the operand (e.g. 'y') with the Block
    unify(t1.operand, t2);
    return;
  }
  if (t2 && t2.type === 'operation' && t2.operator === '~' && t2.position === 'prefix' && t1 && t1.type === 'block' && t1.kind === 'bracket') {
    try { unify(t2.operand, t1); } catch(e) {}
    return;
  }

  // Continuous Postfix (A~) unified with a Block [A] or Continuous Type
  if (t1 && t1.type === 'operation' && t1.operator === '~' && t1.position === 'postfix' && t2 && t2.type === 'block' && t2.kind === 'bracket') {
    try { unify(t1.operand, t2); } catch(e) {}
    return;
  }
  if (t2 && t2.type === 'operation' && t2.operator === '~' && t2.position === 'postfix' && t1 && t1.type === 'block' && t1.kind === 'bracket') {
    try { unify(t2.operand, t1); } catch(e) {}
    return;
  }

  // Continuous Postfix (A~) unified with Concat (x <> ~y)
  // e.g. map g y~ -> y~ unifies with x <> ~y
  if (t1 && t1.type === 'operation' && t1.operator === '~' && t1.position === 'postfix' && t2 && t2.type === 'operation' && (t2.name === 'concat' || t2.operator === ' ')) {
    // Left of concat (x) is the element. So A's type must be [x]
    unify(t1.operand, { type: 'block', kind: 'bracket', content: t2.left });
    // Right of concat (~y) is the tail, which is A~ itself
    unify(t1, t2.right);
    return;
  }
  if (t2 && t2.type === 'operation' && t2.operator === '~' && t2.position === 'postfix' && t1 && t1.type === 'operation' && (t1.name === 'concat' || t1.operator === ' ')) {
    unify(t2.operand, { type: 'block', kind: 'bracket', content: t1.left });
    unify(t2, t1.right);
    return;
  }

  // Address ($f) matching
  if (t1 && t1.type === 'operation' && t1.operator === '$' && t1.position === 'prefix') {
    if (t2 && t2.type === 'operation' && t2.operator === '$' && t2.position === 'prefix') {
      try { unify(t1.operand, t2.operand); } catch(e) {}
      return;
    }
  }

  // Operations
  if (t1 && t1.type === 'operation' && t2 && t2.type === 'operation') {
    if (t1.operator !== t2.operator) {
      throw new Error(`Operator mismatch: ${t1.operator} != ${t2.operator}`);
    }
    if (t1.position !== t2.position) {
      if (t1.operator !== '~') {
        throw new Error(`Position mismatch: ${t1.position} != ${t2.position}`);
      }
    }
    if (t1.left !== undefined) unify(t1.left, t2.left);
    if (t1.right !== undefined) unify(t1.right, t2.right);
    if (t1.operand !== undefined) unify(t1.operand, t2.operand);
    return;
  }

  // Functions (Func)
  if (t1 && t1.type === 'Func' && t2 && t2.type === 'Func') {
    unify(t1.from, t2.from);
    unify(t1.to, t2.to);
    return;
  }

  // Bracket Block containing a function unified with a Func
  if (t1 && t1.type === 'block' && t1.kind === 'bracket' && t2 && t2.type === 'Func') {
    return unify(t1.content, t2);
  }
  if (t2 && t2.type === 'block' && t2.kind === 'bracket' && t1 && t1.type === 'Func') {
    return unify(t1, t2.content);
  }

  // Blocks
  if (t1 && t1.type === 'block' && t2 && t2.type === 'block') {
    if (t1.kind !== t2.kind) throw new Error(`Block kind mismatch: ${t1.kind} != ${t2.kind}`);
    unify(t1.content, t2.content);
    return;
  }

  // If we reach here, types are structurally different and cannot be unified
  throw new Error(`Cannot unify:\n${JSON.stringify(t1, null, 2)}\nAND\n${JSON.stringify(t2, null, 2)}`);
}

export function instantiate(t, env = new Map()) {
  t = prune(t);
  if (t === undefined || t === null) return t;
  if (typeof t === 'string') return t; // Constants or free variables
  if (Array.isArray(t)) return t.map(c => instantiate(c, env));

  if (t.type === 'tvar') {
    return t; // Should this be instantiated? If it's universally quantified, yes. 
    // For now, in standard HM, instantiate replaces bound variables. We will implement polytypes later.
  }

  if (t.type === 'operation') {
    return {
      ...t,
      left: instantiate(t.left, env),
      right: instantiate(t.right, env),
      operand: instantiate(t.operand, env)
    };
  }

  if (t.type === 'block') {
    if (Array.isArray(t.content)) {
      return { ...t, content: t.content.map(c => instantiate(c, env)) };
    }
    return { ...t, content: instantiate(t.content, env) };
  }

  if (t.type === 'Func') {
    return { ...t, from: instantiate(t.from, env), to: instantiate(t.to, env) };
  }

  return t;
}
