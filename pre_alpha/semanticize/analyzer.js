/**
 * Sign Language Semantic Analyzer
 * ASTをトップダウンでトラバースし、文脈に応じて演算子に意味タグを付与します。
 */

export function annotateContextualOperators(ast, context = null) {
  if (!ast || typeof ast !== 'object') return ast;

  if (ast.type === 'operation') {
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

export function buildTypeEnvironment(ast, env = {}) {
  if (!ast || typeof ast !== 'object') return env;

  if (ast.type === 'operation') {
    if (ast.operator === ':') {
      const isFunc = containsLambda(ast.right);
      if (typeof ast.left === 'string' && ast.left.startsWith('<')) {
        const name = ast.left.slice(1, -1);
        env[name] = isFunc ? 'function' : 'value';
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

function containsLambda(node) {
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

function isFunction(node, env) {
  if (!node) return false;
  if (node.inferred_type) return node.inferred_type === 'function';
  
  if (typeof node === 'string' && node.startsWith('<')) {
    const name = node.slice(1, -1);
    return env[name] === 'function';
  }
  
  if (typeof node === 'object') {
    if (node.type === 'operation' && node.operator === '?') return true;
    if (node.semantic_tag === 'match_case') return true;
    // compose() returns a function
    if (node.semantic_tag === 'composition') return true;
  }
  return false;
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
      while(changed) {
        changed = false;
        for (let i = 0; i < stmts.length - 1; i++) {
          if (!isFunction(stmts[i], env) && !isFunction(stmts[i+1], env)) {
            stmts.splice(i, 2, { 
              type: 'operation', operator: 'concat', 
              left: stmts[i], right: stmts[i+1], 
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
      while(changed) {
        changed = false;
        for (let i = 0; i < stmts.length - 1; i++) {
          if (isFunction(stmts[i], env) && isFunction(stmts[i+1], env)) {
            stmts.splice(i, 2, { 
              type: 'operation', operator: '.', 
              left: stmts[i], right: stmts[i+1], 
              semantic_tag: 'composition',
              inferred_type: 'function'
            });
            changed = true;
            break;
          }
        }
      }

      // Pass 3: Apply (Left to Right)
      while(stmts.length > 1) {
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
