/**
 * Sign AST Transformer
 * 
 * 型システムから独立した AST 変換:
 * - annotateContextualOperators: 意味タグの付与
 * - liftLambdas: 無名関数の平坦化
 * 
 * 注: resolveCoproducts は型推論後に実行する必要があるため、
 * infer.js の inferCoproductBlock に統合されました。
 */

export function annotateContextualOperators(ast, context = null) {
  if (!ast || typeof ast !== 'object') return ast;

  if (ast.type === 'operation') {
    // 欠損オペランドの検出 (point-free / vectorized)
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
      // ? の左辺にある `:` の右辺に default_argument コンテキストを付与
      if (ast.left && ast.left.type === 'operation' && ast.left.operator === ':') {
        annotateContextualOperators(ast.left.left, null);
        annotateContextualOperators(ast.left.right, 'default_argument');
      } else {
        annotateContextualOperators(ast.left, null);
      }
      // ? の右辺に match_case コンテキストを付与
      annotateContextualOperators(ast.right, 'match_case');

    } else if (ast.operator === ':') {
      if (context) {
        ast.semantic_tag = context;
      }
      annotateContextualOperators(ast.left, null);
      annotateContextualOperators(ast.right, 'dictionary');

    } else if (ast.operator === '=') {
      annotateContextualOperators(ast.left, context);
      annotateContextualOperators(ast.right, 'dictionary');

    } else if (ast.operator === '~' && ast.position === 'prefix') {
      ast.semantic_tag = 'inductive_boundary';
      if (ast.operand) annotateContextualOperators(ast.operand, context);
    } else if (ast.operator === '~' && ast.position === 'postfix') {
      ast.semantic_tag = 'inductive_expansion';
      if (ast.operand) annotateContextualOperators(ast.operand, context);
    } else if (ast.operator === '$' && ast.position === 'prefix') {
      ast.semantic_tag = 'smart_pointer';
      if (ast.operand) annotateContextualOperators(ast.operand, context);
    } else {
      if (ast.left) annotateContextualOperators(ast.left, context);
      if (ast.right) annotateContextualOperators(ast.right, context);
      if (ast.operand) annotateContextualOperators(ast.operand, context);
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
        ast.operand = lambdaName;
        return ast;
      }
    }

    if (ast.operator === '?') {
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
      return lambdaName;
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
