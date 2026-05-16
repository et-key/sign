export function annotateContextualOperators(ast, context = null) {
  if (!ast || typeof ast !== 'object') return ast;

  if (ast.type === 'operation') {
    // Detect point-free functions (missing operands for infix operators)
    if (ast.position !== 'prefix' && ast.position !== 'postfix') {
      const isMissingLeft = ast.left === null || ast.left === undefined;
      const isMissingRight = ast.right === null || ast.right === undefined;
      
      if (isMissingLeft || isMissingRight) {
        if (ast.operator === ',') {
          ast.semantic_tag = 'vectorized_function';
        } else {
          ast.semantic_tag = 'point_free_function';
        }
        ast.inferred_type = 'function';
      }
    }

    if (ast.operator === '?') {
      // ? の左辺にある `:` の右辺（インデントブロック等）に default_argument コンテキストを付与
      if (ast.left && ast.left.type === 'operation' && ast.left.operator === ':') {
        annotateContextualOperators(ast.left.left, null);
        annotateContextualOperators(ast.left.right, 'default_argument');
      } else {
        annotateContextualOperators(ast.left, null);
      }

      // ? の右辺（インデントブロック等）に match_case コンテキストを付与
      annotateContextualOperators(ast.right, 'match_case');

    } else if (ast.operator === ':') {
      // 親から伝播してきたコンテキストがあればタグ付け
      if (context) {
        ast.semantic_tag = context;
      }

      annotateContextualOperators(ast.left, null);
      // : の右辺に現れるブロックは、基本的に辞書扱い
      annotateContextualOperators(ast.right, 'dictionary');

    } else if (ast.operator === '=') {
      // = の左辺には `arg1: type1` のような構造が来る可能性があるため、コンテキストを維持して伝播
      annotateContextualOperators(ast.left, context);
      // = の右辺に現れるブロックも、基本的に辞書扱い
      annotateContextualOperators(ast.right, 'dictionary');

    } else {
      // その他の演算子はコンテキストを維持して伝播
      annotateContextualOperators(ast.left, context);
      annotateContextualOperators(ast.right, context);
    }
  } else if (ast.type === 'block') {
    if (Array.isArray(ast.content)) {
      ast.content.forEach(c => annotateContextualOperators(c, context));
    } else {
      annotateContextualOperators(ast.content, context);
    }
  } else if (ast.type === 'coproduct_block') {
    if (ast.statements) {
      ast.statements.forEach(s => annotateContextualOperators(s, context));
    }
  }

  return ast;
}

export function buildTypeEnvironment(ast, env) {
  if (!ast || typeof ast !== 'object') return env;

  if (ast.type === 'operation') {
    if (ast.operator === ':') {
      const isFunc = containsLambda(ast.right);
      if (typeof ast.left === 'string' && ast.left.startsWith('<')) {
        const name = ast.left.slice(1, -1);
        env.set(name, { kind: isFunc ? 'function' : 'value' });
      }
    }
    buildTypeEnvironment(ast.left, env);
    buildTypeEnvironment(ast.right, env);
  } else if (ast.type === 'block') {
    if (Array.isArray(ast.content)) {
      ast.content.forEach(c => buildTypeEnvironment(c, env));
    } else {
      buildTypeEnvironment(ast.content, env);
    }
  } else if (ast.type === 'coproduct_block') {
    if (ast.statements) {
      ast.statements.forEach(s => buildTypeEnvironment(s, env));
    }
  }

  return env;
}

export function containsLambda(node) {
  if (!node || typeof node !== 'object') return false;
  if (node.type === 'operation' && node.operator === '?') return true;
  if (node.type === 'block') {
    if (Array.isArray(node.content)) {
      return node.content.some(containsLambda);
    } else {
      return containsLambda(node.content);
    }
  }
  if (node.type === 'coproduct_block') {
    return node.statements.some(containsLambda);
  }
  if (node.left) return containsLambda(node.left) || containsLambda(node.right);
  return false;
}

export function isFunction(node, env) {
  if (!node) return false;
  if (node.inferred_type === 'function') return true;
  
  if (typeof node === 'string' && node.startsWith('<')) {
    const name = node.slice(1, -1);
    const typeInfo = env.get(name);
    return typeInfo && typeInfo.kind === 'function';
  }
  
  if (typeof node === 'object') {
    if (node.type === 'operation' && node.operator === '?') return true;
    if (node.semantic_tag === 'match_case') return true;
    if (node.semantic_tag === 'composition') return true;
    if (node.semantic_tag === 'point_free_function') return true;
    if (node.semantic_tag === 'vectorized_function') return true;
    
    // If it's a block, check if its content is a function
    if (node.type === 'block' && !Array.isArray(node.content)) {
      return isFunction(node.content, env);
    }
  }
  return false;
}

export function liftLambdas(ast, state) {
  if (!ast || typeof ast !== 'object') return ast;

  if (ast.type === 'operation') {
    if (ast.operator === ':') {
      ast.left = liftLambdas(ast.left, state);
      if (ast.right && ast.right.type === 'operation' && ast.right.operator === '?') {
         // Named lambda, don't lift the root '?', but lift its children
         ast.right.left = liftLambdas(ast.right.left, state);
         ast.right.right = liftLambdas(ast.right.right, state);
      } else {
         ast.right = liftLambdas(ast.right, state);
      }
      return ast;
    }
    
    if (ast.operator === '$' && ast.operand) {
      const isPointFree = ast.operand.semantic_tag === 'point_free_function' || ast.operand.semantic_tag === 'vectorized_function';
      if (ast.operand.operator === '?' || isPointFree) {
        // Lift the operand!
        const lambdaName = `"__Lambda__[${state.counter++}]"`;
        
        const hoistedLambda = {
          type: 'operation',
          operator: ':',
          left: lambdaName,
          right: {
            ...ast.operand,
            left: liftLambdas(ast.operand.left, state),
            right: liftLambdas(ast.operand.right, state)
          },
          inferred_type: ast.operand.inferred_type,
          type_detail: ast.operand.type_detail
        };
        
        state.lambdas.push(hoistedLambda);
        // $ applied to a hoisted lambda name means the address of the hoisted lambda
        ast.operand = lambdaName;
        return ast;
      }
    }
    
    if (ast.operator === '?') {
      // Anonymous lambda! Lift it.
      const lambdaName = `"__Lambda__[${state.counter++}]"`;
      
      const hoistedLambda = {
        type: 'operation',
        operator: ':',
        left: lambdaName,
        right: {
          ...ast,
          left: liftLambdas(ast.left, state),
          right: liftLambdas(ast.right, state)
        },
        inferred_type: ast.inferred_type,
        type_detail: ast.type_detail
      };
      
      state.lambdas.push(hoistedLambda);
      return lambdaName; // Replace with identifier string directly
    }
    
    ast.left = liftLambdas(ast.left, state);
    ast.right = liftLambdas(ast.right, state);
    if (ast.operand) ast.operand = liftLambdas(ast.operand, state);
    
    return ast;
  }
  
  if (ast.type === 'block') {
    if (Array.isArray(ast.content)) {
      ast.content = ast.content.map(c => liftLambdas(c, state));
    } else {
      ast.content = liftLambdas(ast.content, state);
    }
    return ast;
  }
  
  if (ast.type === 'coproduct_block') {
    if (ast.statements) {
      ast.statements = ast.statements.map(s => liftLambdas(s, state));
    }
    return ast;
  }
  
  return ast;
}

export function resolveCoproducts(ast, env = {}) {
  if (!ast || typeof ast !== 'object') return ast;

  if (ast.type === 'operation') {
    ast.left = resolveCoproducts(ast.left, env);
    ast.right = resolveCoproducts(ast.right, env);
  } else if (ast.type === 'block') {
    if (Array.isArray(ast.content)) {
      ast.content = ast.content.map(c => resolveCoproducts(c, env));
    } else {
      ast.content = resolveCoproducts(ast.content, env);
    }
  } else if (ast.type === 'coproduct_block') {
    if (ast.statements) {
      ast.statements = ast.statements.map(s => resolveCoproducts(s, env));

      let stmts = [...ast.statements];

      // Pass 1: Concat (Value + Value -> concat)
      let changed = true;
      while (changed) {
        changed = false;
        for (let i = 0; i < stmts.length - 1; i++) {
          if (!isFunction(stmts[i], env) && !isFunction(stmts[i + 1], env)) {
            stmts.splice(i, 2, {
              type: 'operation', operator: 'concat',
              left: stmts[i], right: stmts[i + 1],
              semantic_tag: 'list_composition',
              inferred_type: 'value'
            });
            changed = true;
            break;
          }
        }
      }

      // Pass 2: Compose (Function + Function -> compose)
      changed = true;
      while (changed) {
        changed = false;
        for (let i = 0; i < stmts.length - 1; i++) {
          if (isFunction(stmts[i], env) && isFunction(stmts[i + 1], env)) {
            stmts.splice(i, 2, {
              type: 'operation', operator: '.',
              left: stmts[i], right: stmts[i + 1],
              semantic_tag: 'composition',
              inferred_type: 'function'
            });
            changed = true;
            break;
          }
        }
      }

      // Pass 3: Apply (Left to Right)
      while (stmts.length > 1) {
        const left = stmts[0];
        const right = stmts[1];
        stmts.splice(0, 2, {
          type: 'operation', operator: 'apply',
          left, right,
          semantic_tag: 'application',
          inferred_type: 'unknown'
        });
      }

      return stmts[0] || null;
    }
  }

  return ast;
}
