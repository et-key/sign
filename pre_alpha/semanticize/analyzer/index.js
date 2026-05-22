/**
 * index.js
 * Sign Language Analyzer Entry Point
 */
import { TVar, TFunc, TTuple, TAtom, TUnion, THole, TVariadic, TGenerator, Substitution, unify, resetTVarCounter } from './types.js';

export { Substitution, resetTVarCounter };

export function createChildEnv(parentEnv) {
  return new Map(parentEnv);
}

export function annotateContextualOperators(ast) {
  // Pass-through for now, can be used for tagging context-specific operators
  return ast;
}

export function liftLambdas(ast, state) {
  if (!ast || typeof ast !== 'object') return ast;

  function traverseAndLift(node, isNamed) {
    if (!node || typeof node !== 'object') return node;

    if (node.type === 'operation') {
      if (node.operator === ':') {
        node.left = traverseAndLift(node.left, false);
        node.right = traverseAndLift(node.right, true);
        return node;
      }

      node.left = traverseAndLift(node.left, false);
      node.right = traverseAndLift(node.right, false);
      node.operand = traverseAndLift(node.operand, false);

      if (node.operator === '?' && !isNamed) {
        const name = `<lambda_${state.counter++}>`;
        const declaration = {
          type: 'operation',
          operator: ':',
          left: name,
          right: node,
          type_detail: node.type_detail
        };
        state.lambdas.push(declaration);
        return name;
      }
    } else if (node.type === 'block') {
      node.content = traverseAndLift(node.content, false);
      if (node.statements) {
        for (let i = 0; i < node.statements.length; i++) {
          node.statements[i] = traverseAndLift(node.statements[i], false);
        }
      }
    } else if (node.type === 'coproduct_block') {
      if (node.statements) {
        for (let i = 0; i < node.statements.length; i++) {
          node.statements[i] = traverseAndLift(node.statements[i], false);
        }
      }
    }

    return node;
  }

  return traverseAndLift(ast, false);
}

export function generateST(asts, lambdas) {
  let st = [];
  for (const node of asts) {
    if (!node || typeof node !== 'object') continue;
    if (node.type === 'operation' && node.operator === ':') {
      const name = getIdentName(node.left) || node.left;
      const typeStr = node.type_detail ? node.type_detail.toString() : 'Unknown';
      st.push(`${name} : ${typeStr}`);
    } else if (node.type_detail) {
      st.push(`<expression> : ${node.type_detail.toString()}`);
    }
  }
  return st.join('\n') + '\n';
}

// Extract string value from identifier nodes (e.g., "<f>")
function getIdentName(node) {
  if (typeof node === 'string' && node.startsWith('<') && node.endsWith('>')) {
    return node.slice(1, -1);
  }
  return null;
}

function curryApply(param, arg, subst) {
  let snapshot = subst.clone();
  // 1. Fully Applied
  if (unify(param, arg, subst)) {
    return null;
  }
  subst.rollback(snapshot);

  // 2. Partial Application (Currying)
  if (param instanceof TTuple && param.types.length > 0) {
    const first = param.types[0];
    if (first instanceof TVariadic) {
      if (unify(first.type, arg, subst)) {
        // Variadic arguments absorb elements indefinitely
        return param;
      }
    } else {
      if (unify(first, arg, subst)) {
        const remaining = param.types.slice(1);
        if (remaining.length === 1) return remaining[0];
        return new TTuple(remaining);
      }
    }
  }
  
  return undefined;
}

// Type inference for Patterns (left side of ? or :)
function inferPattern(node, env) {
  if (!node) return new TAtom('Unit');

  if (typeof node === 'string') {
    const name = getIdentName(node);
    if (name) {
      if (name === '_') return new THole();
      const tv = new TVar();
      env.set(name, tv);
      return tv;
    }
    // Literals in pattern (e.g. matching a specific number '1')
    if (!isNaN(node)) return new TAtom('Number');
    return new TAtom('String');
  }

  if (node.type === 'operation') {
    if (node.operator === ' ') {
      // In patterns, space constructs a tuple of parameters
      const t_left = inferPattern(node.left, env);
      const t_right = inferPattern(node.right, env);
      const leftTypes = t_left instanceof TTuple ? t_left.types : [t_left];
      const rightTypes = t_right instanceof TTuple ? t_right.types : [t_right];
      const tupleType = new TTuple([...leftTypes, ...rightTypes]);
      node.type_detail = tupleType;
      return tupleType;
    } else if (node.operator === '~' && (node.position === 'prefix' || node.position === 'postfix')) {
      const inner = inferPattern(node.operand, env);
      const tv = new TVariadic(inner);
      node.type_detail = tv;
      return tv;
    } else {
      // Recurse into other pattern operators (like ~y, or decorators)
      if (node.left) inferPattern(node.left, env);
      if (node.right) inferPattern(node.right, env);
      if (node.operand) inferPattern(node.operand, env);
      const tv = new TVar();
      node.type_detail = tv;
      return tv;
    }
  }

  if (node.type === 'block') {
    if (node.content) {
      return inferPattern(node.content, env);
    }
    if (node.statements && node.statements.length > 0) {
      return inferPattern(node.statements[0], env);
    }
    return new TAtom('Unit');
  }

  if (node.type === 'coproduct_block' && node.statements) {
    const types = node.statements.map(s => inferPattern(s, env));
    return new TTuple(types);
  }

  // Fallback: literal or unknown
  const tv = new TVar();
  node.type_detail = tv;
  return tv;
}

export function infer(node, env, subst) {
  if (!node) return new TAtom('Unit');

  if (typeof node === 'string') {
    const name = getIdentName(node);
    if (name) {
      if (name === '_') return new THole();
      // Atoms are self-evident. If they are in the environment, return the bound type.
      // Otherwise, the identifier is the type itself.
      // We deep clone the type so each retrieval gets fresh TVars (Polymorphism without forAll)
      return env.has(name) ? env.get(name).clone(new Map()) : new TAtom(name);
    }
    // Literals
    if (!isNaN(node)) return new TAtom('Number');
    return new TAtom('String');
  }

  if (node.type === 'block') {
    const resType = infer(node.content, env, subst);
    node.type_detail = resType;
    return resType;
  }

  if (node.type === 'coproduct_block') {
    let lastType = new TAtom('Unit');
    for (const stmt of node.statements) {
      lastType = infer(stmt, env, subst);
    }
    node.type_detail = lastType;
    return lastType;
  }

  if (node.type === 'operation') {
    const op = node.operator;

    if (op === ':') {
      // If left is an identifier, we bind it in the current scope as a generic TVar first to support recursion
      if (typeof node.left === 'string') {
        const name = getIdentName(node.left);
        if (name) {
          const t_var = new TVar(name);
          env.set(name, t_var);
          const t_right = infer(node.right, env, subst);
          // Unify the inferred right type with the forward-declared var
          unify(t_var, t_right, subst);
          env.set(name, t_right);
          node.type_detail = t_right;
          return t_right;
        }
      }

      // Destructuring define (fallback)
      const t_right = infer(node.right, env, subst);
      const childEnv = createChildEnv(env);
      const t_left = inferPattern(node.left, childEnv);
      if (!unify(t_left, t_right, subst)) {
        console.error(`Unify failed in define! node.left:`, node.left);
        console.error(`Unify failed in define! t_left: ${t_left}, t_right: ${t_right}`);
        throw new Error(`Type mismatch in define: cannot unify pattern with value`);
      }
      // Merge child env back
      for (const [k, v] of childEnv.entries()) {
        env.set(k, v);
      }
      node.type_detail = t_right;
      return t_right;
    }

    if (op === '?') {
      // Lambda
      const childEnv = createChildEnv(env);
      const t_param = inferPattern(node.left, childEnv);
      const t_body = infer(node.right, childEnv, subst);
      const t_func = new TFunc(t_param, t_body);
      node.type_detail = t_func;
      return t_func;
    }

    if (op === ' ') {
      // Coproduct (apply_or_concat) Resolution
      const t_left = infer(node.left, env, subst);
      const t_right = infer(node.right, env, subst);

      let distributed = false;

      function resolveApplyOrConcat(t_l, t_r, currentSubst) {
        if (t_l instanceof TUnion) {
          distributed = true;
          return new TUnion(t_l.types.map(t => resolveApplyOrConcat(t, t_r, currentSubst)));
        }
        if (t_r instanceof TUnion) {
          distributed = true;
          return new TUnion(t_r.types.map(t => resolveApplyOrConcat(t_l, t, currentSubst)));
        }

        // 10.0 Apply
        let snapshot = currentSubst.clone();
        let t_ret = new TVar();
        
        if (t_r instanceof THole) {
          let A = new TVar(), B = new TVar(), C = new TVar();
          if (unify(t_l, new TFunc(A, new TFunc(B, C)), currentSubst)) {
            if (!distributed) node.name = 'apply_hole';
            return new TFunc(B, new TFunc(A, C));
          }
          currentSubst.rollback(snapshot);
          snapshot = currentSubst.clone();
          
          let A_single = new TVar(), B_single = new TVar();
          if (unify(t_l, new TFunc(A_single, B_single), currentSubst)) {
            if (!distributed) node.name = 'apply_hole_single';
            return t_l;
          }
        } else {
          if (t_l instanceof TFunc) {
            const remainingParam = curryApply(t_l.paramType, t_r, currentSubst);
            if (remainingParam !== undefined) {
              if (!distributed) node.name = remainingParam === null ? 'apply' : 'apply_partial';
              return remainingParam === null ? t_l.returnType : new TFunc(remainingParam, t_l.returnType);
            }
          } else if (t_l instanceof TVar) {
            if (unify(t_l, new TFunc(t_r, t_ret), currentSubst)) {
              if (!distributed) node.name = 'apply';
              return t_ret;
            }
          }
        }
        currentSubst.rollback(snapshot);

        // 10.1 Reverse Apply
        snapshot = currentSubst.clone();
        t_ret = new TVar();
        if (t_l instanceof THole) {
          let A = new TVar(), B = new TVar(), C = new TVar();
          if (unify(t_r, new TFunc(A, new TFunc(B, C)), currentSubst)) {
            if (!distributed) node.name = 'reverse_apply_hole';
            return new TFunc(B, new TFunc(A, C));
          }
          currentSubst.rollback(snapshot);
          snapshot = currentSubst.clone();
          
          let A_single = new TVar(), B_single = new TVar();
          if (unify(t_r, new TFunc(A_single, B_single), currentSubst)) {
            if (!distributed) node.name = 'reverse_apply_hole_single';
            return t_r;
          }
        } else {
          if (t_r instanceof TFunc) {
            const remainingParam = curryApply(t_r.paramType, t_l, currentSubst);
            if (remainingParam !== undefined) {
              if (!distributed) node.name = remainingParam === null ? 'reverse_apply' : 'reverse_apply_partial';
              return remainingParam === null ? t_r.returnType : new TFunc(remainingParam, t_r.returnType);
            }
          } else if (t_r instanceof TVar) {
            if (unify(t_r, new TFunc(t_l, t_ret), currentSubst)) {
              if (!distributed) node.name = 'reverse_apply';
              return t_ret;
            }
          }
        }
        currentSubst.rollback(snapshot);

        // 10.2 Compose
        snapshot = currentSubst.clone();
        let A_comp = new TVar(), B_comp = new TVar(), C_comp = new TVar();
        if (unify(t_l, new TFunc(B_comp, C_comp), currentSubst) && unify(t_r, new TFunc(A_comp, B_comp), currentSubst)) {
          if (!distributed) node.name = 'compose';
          return new TFunc(A_comp, C_comp);
        }
        currentSubst.rollback(snapshot);

        // Unit Short-Circuit
        const isLUnit = t_l instanceof TAtom && t_l.name.toLowerCase() === 'unit';
        const isRUnit = t_r instanceof TAtom && t_r.name.toLowerCase() === 'unit';
        if (isLUnit || isRUnit) {
          if (!distributed) node.name = 'short_circuit';
          return new TAtom('Unit');
        }

        // 10.3 Concat (Tuple)
        if (!distributed) node.name = 'concat';
        return new TTuple([t_l, t_r]);
      }

      const t_res = resolveApplyOrConcat(t_left, t_right, subst);
      if (distributed) {
        node.name = 'distribute';
      }
      node.type_detail = t_res;
      return t_res;
    }

    if (op === ',') {
      const t_left = infer(node.left, env, subst);
      const t_right = infer(node.right, env, subst);
      const t_tuple = new TTuple([t_left, t_right]);
      node.type_detail = t_tuple;
      return t_tuple;
    }

    if (op === '|') {
      const t_left = infer(node.left, env, subst);
      const t_right = infer(node.right, env, subst);
      const t_union = new TUnion([t_left, t_right]);
      node.type_detail = t_union;
      return t_union;
    }

    // Default basic operations (e.g., +, -, *, etc.)
    const t_left = node.left ? infer(node.left, env, subst) : null;
    const t_right = node.right ? infer(node.right, env, subst) : null;
    const t_operand = node.operand ? infer(node.operand, env, subst) : null;

    let t_res = new TVar();

    // Very simplified generic types for built-ins for demonstration
    if (['+', '-', '*', '/', '%', '^'].includes(op)) {
      if (t_left) unify(t_left, new TAtom('Number'), subst);
      if (t_right) unify(t_right, new TAtom('Number'), subst);
      t_res = new TAtom('Number');
    } else if (['<', '<=', '>', '>=', '=', '!='].includes(op)) {
      // Comparison evaluates to Left (Number) | Unit to simulate boolean short-circuiting
      t_res = new TUnion([new TAtom('Number'), new TAtom('Unit')]);
    } else if (['==', '!=='].includes(op)) {
      // Structural comparison -> Unify left and right structures
      if (t_left && t_right) {
        unify(t_left, t_right, subst);
      }
      t_res = new TUnion([new TAtom('Number'), new TAtom('Unit')]);
    } else if (['~', '~+', '~-', '~*', '~/'].includes(op)) {
      t_res = new TGenerator(new TAtom('Number'), new TAtom('Number'), new TAtom('Number'));
    } else if (op === '#') {
      // output: addr # val
      t_res = new TAtom('Unit');
    }

    if (t_operand) {
      if (op === '$') {
        // Address of
        t_res = new TAtom('Number');
      } else if (op === '@') {
        // Input from Address
        t_res = new TAtom('Number');
      }
    }

    node.type_detail = t_res;
    return t_res;
  }

  return new TVar();
}
