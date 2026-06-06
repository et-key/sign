/**
 * builder.js
 * 
 * ASTを事前に走査し、各識別子（変数や関数）が `Lambda` なのか `Atom` なのかを
 * 判定してグローバルな環境マップ（Environment Map）に記憶するモジュールです。
 */

/**
 * 事前走査によって、定義された識別子のカテゴリを推論・登録します。
 * @param {Object|Array} node - ASTのルートまたはノード
 * @param {Map<string, string>} env - 識別子名からカテゴリ（'Lambda'|'Atom'）へのマップ
 * @returns {Map<string, string>}
 */
export function buildEnvironment(node, env = new Map(), isExported = false) {
  if (!node) return env;

  if (Array.isArray(node)) {
    for (const item of node) {
      buildEnvironment(item, env, isExported);
    }
    return env;
  }

  if (typeof node === 'object') {
    let currentEnv = env;
    
    // インデントブロック等で新しいローカルスコープを作成する
    if (node.type === 'block' && (node.kind === 'indent' || node.kind === 'abs')) {
      currentEnv = new Map(env); // 親の環境を引き継ぐ新しいマップ
      node.env = currentEnv;     // resolveCoproducts で参照できるようにノードに保存
    }

    // export演算子 (`#`) の場合、子ノードに isExported = true を伝搬
    if (node.type === 'operation' && node.operator === '#') {
      if (node.operand) buildEnvironment(node.operand, currentEnv, true);
      // `#` の他のプロパティも一応走査
      for (const key of Object.keys(node)) {
        if (key !== 'type' && key !== 'name' && key !== 'operator' && key !== 'kind' && key !== 'env' && key !== 'operand') {
          buildEnvironment(node[key], currentEnv, isExported);
        }
      }
      return env;
    }

    // 定義演算子 (`:`) の場合、左辺の識別子を登録する
    if (node.type === 'operation' && node.operator === ':') {
      if (!node.left) {
        console.log("builder error node:", JSON.stringify(node, null, 2));
      }
      const identName = typeof node.left === 'string' ? node.left : (node.left.name || String(node.left));
      
      // 右辺の構文から、仮のカテゴリを推測する
      const rightCat = getInitialCategory(node.right, currentEnv);
      currentEnv.set(identName, { category: rightCat, ast: node.right, exported: isExported });
    }

    // 再帰的にブロックの内部などを走査
    for (const key of Object.keys(node)) {
      if (key !== 'type' && key !== 'name' && key !== 'operator' && key !== 'kind' && key !== 'env') {
        buildEnvironment(node[key], currentEnv, isExported);
      }
    }
  }

  return env;
}

function isPartialOperation(node) {
  if (!node) return false;
  // group や paren などの単なるラッパーは中身を見る
  if (node.type === 'block' && (node.kind === 'group' || node.kind === 'paren')) {
    return isPartialOperation(node.content);
  }
  if (node.type !== 'operation') return false;
  if (node.operator === ',') return true;
  if (node.position === 'prefix' || node.position === 'postfix') {
    return node.operand === undefined;
  }
  return node.left === undefined || node.right === undefined;
}

/**
 * 右辺の初期構文から、その定義が最終的に `Lambda` になるか `Atom` になるかを推測します。
 * （※coproduct解決前に実行されるため、近似的な判定を行います）
 */
export function getInitialCategory(node, env) {
  if (!node) return 'Atom';
  if (node.isLambda) return 'Lambda';
  
  if (typeof node === 'string') {
    if (env && env.has(node)) return env.get(node).category;
    if (['print', '<print>'].includes(node)) return 'Lambda';
    return 'Atom';
  }

  if (node.type === 'operation') {
    if (node.operator === '?') return 'Lambda';
    if (node.name === 'compose') return 'Lambda';
    if (isPartialOperation(node)) return 'Lambda';
    return 'Atom';
  }

  if (node.type === 'block') {
    return getInitialCategory(node.content, env);
  }

  // coproduct_block の場合は、大まかに最後の要素のカテゴリを引き継ぐ（ヒューリスティック）
  if (node.type === 'coproduct_block' && Array.isArray(node.statements) && node.statements.length > 0) {
    const lastStmt = node.statements[node.statements.length - 1];
    return getInitialCategory(lastStmt, env);
  }

  // shunting_yard が作成した未解決の coproduct_block
  // コプロダクトブロックは、内部の全要素が Lambda であれば compose (Lambda) となり、
  // 1つでも Atom が混ざっていれば apply や concat によって最終的に Atom に収束する。
  if (node.type === 'coproduct_block' && Array.isArray(node.statements)) {
    for (const stmt of node.statements) {
      if (getInitialCategory(stmt, env) === 'Atom') {
        return 'Atom';
      }
    }
    return 'Lambda';
  }

  return 'Atom';
}
