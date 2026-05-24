/**
 * resolveCoproducts
 * 
 * shunting_yard.js でフラットな配列として仮組みされた `coproduct_block` を受け取り、
 * 左辺と右辺の「構文的種類（仮の型: Lambda か Atom か）」の組み合わせに基づく
 * 優先順位（10.3 〜 10.0）に従って、最も優先度の高いペアから順次結合（Reduction）を行います。
 */

export function resolveCoproducts(node, env = new Map()) {
  if (!node) return node;

  if (Array.isArray(node)) {
    return node.map(n => resolveCoproducts(n, env));
  }

  if (typeof node === 'object') {
    // 1. coproduct_block のフラットな配列を優先順位順に結合
    if (node.type === 'coproduct_block') {
      const resolvedStatements = node.statements.map(s => resolveCoproducts(s, env));
      return reduceCoproductBlock(resolvedStatements, env);
    }

    // 2. 既存の operation ノードの子要素を解決
    if (node.type === 'operation') {
      const left = resolveCoproducts(node.left, env);
      const right = resolveCoproducts(node.right, env);
      const operand = resolveCoproducts(node.operand, env);

      // 旧形式で operation の coproduct が残っていた場合のフォールバック（通常は通らない）
      if (node.name === 'coproduct') {
        return reduceCoproductBlock([left, right], env);
      }

      return { ...node, left, right, operand };
    } 
    
    // 3. ブロックノードの子要素を解決
    if (node.type === 'block') {
      const currentEnv = node.env || env; // builder.js が作成したローカルスコープがあれば使用
      return { ...node, content: resolveCoproducts(node.content, currentEnv) };
    } 
    
    // その他のノードの深いコピー
    const newNode = { ...node };
    for (const key of Object.keys(newNode)) {
      if (key !== 'type' && key !== 'name' && key !== 'operator' && key !== 'kind') {
        newNode[key] = resolveCoproducts(newNode[key], env);
      }
    }
    return newNode;
  }

  return node;
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
 * 構文的カテゴリを判定する（型推論前の仮の分類）
 * @returns {'Lambda' | 'Atom'}
 */
function getCategory(node, env) {
  if (!node) return 'Atom';
  if (node.isLambda) return 'Lambda';
  
  if (typeof node === 'string') {
    if (!isNaN(node) || node.startsWith('0x')) return 'Atom';
    
    // 文字列リテラルは Atom
    if ((node.startsWith('"') && node.endsWith('"')) || 
        (node.startsWith('`') && node.endsWith('`'))) {
      return 'Atom';
    }
    
    // 環境（env）に登録されていればそのカテゴリを優先
    if (env && env.has(node)) {
      return env.get(node);
    }
    
    // 未定義の未知の識別子は変数（値）として Atom 扱いとする
    return 'Atom';
  }

  if (node.type === 'operation') {
    if (node.operator === '?') return 'Lambda';
    if (node.name === 'compose') return 'Lambda';
    // プロパティ・配列アクセスは関数を返す可能性を考慮し Lambda 扱い
    if (node.name === 'get_prop' || node.name === 'get_at') return 'Lambda';
    if (isPartialOperation(node)) return 'Lambda';
    // apply, concat, 算術演算などは一旦 Atom（値）扱い
    return 'Atom';
  }

  if (node.type === 'block') {
    return getCategory(node.content, env);
  }

  // coproduct_block の場合は、大まかに最後の要素のカテゴリを引き継ぐ（ヒューリスティック）
  if (node.type === 'coproduct_block' && Array.isArray(node.statements) && node.statements.length > 0) {
    const lastStmt = node.statements[node.statements.length - 1];
    return getCategory(lastStmt, env);
  }

  return 'Atom';
}

/**
 * 優先順位に基づいて隣接ペアを Reduction する
 */
function reduceCoproductBlock(statements, env) {
  if (!statements || statements.length === 0) return null;
  if (statements.length === 1) return statements[0];

  let items = [...statements];

  // A_Operator_Table.md に基づく優先順位定義
  // 優先順位が高い（先に結合される）順に処理
  const PRECEDENCES = [
    { level: 10.3, leftCat: 'Atom', rightCat: 'Atom', name: 'concat' },
    { level: 10.2, leftCat: 'Lambda', rightCat: 'Lambda', name: 'compose' },
    { level: 10.1, leftCat: 'Lambda', rightCat: 'Atom', name: 'apply' },
    { level: 10.0, leftCat: 'Atom', rightCat: 'Lambda', name: 'apply_reverse' }
  ];

  // 各優先順位レベルについて、左結合で適用可能なペアを探して還元
  for (const prec of PRECEDENCES) {
    let changed = true;
    while (changed) {
      changed = false;
      for (let i = 0; i < items.length - 1; i++) {
        const left = items[i];
        const right = items[i + 1];
        
        const catL = getCategory(left, env);
        const catR = getCategory(right, env);

        if (catL === prec.leftCat && catR === prec.rightCat) {
          let newNode;
          
          if (prec.name === 'concat') {
            newNode = { type: 'operation', operator: ' ', left, right, name: 'concat' };
          } 
          else if (prec.name === 'compose') {
            newNode = { type: 'operation', operator: ' ', left, right, name: 'compose' };
          } 
          else if (prec.name === 'apply') {
            newNode = { type: 'operation', operator: ' ', left, right, name: 'apply' };
          } 
          else if (prec.name === 'apply_reverse') {
            // 逆適用: 右辺(Lambda)に左辺(Atom)を適用する
            newNode = { type: 'operation', operator: ' ', left: right, right: left, name: 'apply' };
          }

          items.splice(i, 2, newNode);
          changed = true;
          break; // 左結合を担保するため、リストの先頭から再度走査
        }
      }
    }
  }

  // 4つのルールで (Atom|Lambda) × (Atom|Lambda) を網羅しているため、
  // 必ず1つのノードに収束する。
  return items[0];
}