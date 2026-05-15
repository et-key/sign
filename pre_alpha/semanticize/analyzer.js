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
