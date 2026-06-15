/**
 * resolveCoproducts
 * 
 * shunting_yard.js でフラットな配列として仮組みされた `coproduct_block` を受け取り、
 * 左辺と右辺の「構文的種類（仮の型: Lambda か Atom か）」の組み合わせに基づく
 * 優先順位（10.3 〜 10.0）に従って、最も優先度の高いペアから順次結合（Reduction）を行います。
 */

export function resolveCoproducts(node, env = new Map(), depth = 0, pathTrace = []) {
  if (!node) return node;

  if (Array.isArray(node)) {
    return node.map((n, i) => resolveCoproducts(n, env, depth + 1, [...pathTrace, `[${i}]`]));
  }

  if (typeof node === 'object') {
    // 1. coproduct_block のフラットな配列を優先順位順に結合
    if (node.type === 'coproduct_block') {
      const resolvedStatements = node.statements.map((s, i) => resolveCoproducts(s, env, depth + 1, [...pathTrace, `statements[${i}]`]));
      return reduceCoproductBlock(resolvedStatements, env);
    }

    // 2. 既存の operation ノードの子要素を解決
    if (node.type === 'operation') {
      const left = resolveCoproducts(node.left, env, depth + 1, [...pathTrace, 'left']);
      const right = resolveCoproducts(node.right, env, depth + 1, [...pathTrace, 'right']);
      const operand = resolveCoproducts(node.operand, env, depth + 1, [...pathTrace, 'operand']);

      // 旧形式で operation の coproduct が残っていた場合のフォールバック（通常は通らない）
      if (node.name === 'coproduct') {
        return reduceCoproductBlock([left, right], env);
      }

      return { ...node, left, right, operand };
    }

    // 3. ブロックノードの子要素を解決
    if (node.type === 'block') {
      const currentEnv = node.env || env; // builder.js が作成したローカルスコープがあれば使用
      return { ...node, content: resolveCoproducts(node.content, currentEnv, depth + 1, [...pathTrace, 'content']) };
    }

    // その他のノードの深いコピー
    const newNode = { ...node };
    for (const key of Object.keys(newNode)) {
      if (key !== 'type' && key !== 'name' && key !== 'operator' && key !== 'kind') {
        newNode[key] = resolveCoproducts(newNode[key], env, depth + 1, [...pathTrace, key]);
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
    if (node.startsWith('`') && node.endsWith('`')) {
      return 'Atom';
    }

    if (env && env.has(node)) {
      const entry = env.get(node);
      return typeof entry === 'string' ? entry : (entry.category || 'Atom');
    }

    if (['print', '<print>', '_'].includes(node)) return 'Lambda';

    return 'Atom';
  }

  if (node.type === 'Identifier' || node.type === 'Variable') {
    const name = node.name;
    if (env && env.has(name)) {
      const entry = env.get(name);
      return typeof entry === 'string' ? entry : (entry.category || 'Atom');
    }
    if (['print', '<print>', '_'].includes(name)) return 'Lambda';
    return 'Atom';
  }

  if (node.type === 'operation') {
    if (node.position === 'prefix') {
      if (node.operator === '@') return 'Lambda';
      return 'Atom';
    }
    if (node.operator === '?') return 'Lambda';
    if (node.name === 'compose') return 'Lambda';
    if (node.name === 'apply') {
      let arity = Infinity;
      let targetNode = node.left;
      while (targetNode && targetNode.type === 'block') {
        targetNode = targetNode.content;
      }
      if (targetNode && targetNode.type === 'operation') {
        if (targetNode.operator === '?') {
          arity = getArity(targetNode.left);
        } else {
          arity = getArity(targetNode);
        }
      } else if (typeof targetNode === 'string') {
        let entry = null;
        if (env && env.has(targetNode)) {
          entry = env.get(targetNode);
        } else {
          const entryName = targetNode.startsWith('<') && targetNode.endsWith('>') ? targetNode.slice(1, -1) : targetNode;
          if (env && env.has(entryName)) {
            entry = env.get(entryName);
          }
        }
        if (entry && typeof entry === 'object' && entry.arity !== undefined) {
          arity = entry.arity;
        }
      } else if (targetNode && (targetNode.type === 'Identifier' || targetNode.type === 'Variable')) {
        const name = targetNode.name;
        if (env && env.has(name)) {
          const entry = env.get(name);
          if (entry && typeof entry === 'object' && entry.arity !== undefined) {
            arity = entry.arity;
          }
        }
      }
      let appliedCount = 1;
      if (node.right && node.right.type === 'coproduct_block') {
        appliedCount = node.right.statements.length;
      }
      if (appliedCount >= arity) {
        return 'Atom';
      }
      return getCategory(node.left, env);
    }
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
    { level: 10.5, leftCat: 'Lambda', rightCat: 'Lambda', name: 'compose' },
    { level: 10.4, leftCat: 'Lambda', rightCat: 'Atom', name: 'apply' },
    { level: 10.3, leftCat: 'Atom', rightCat: 'Atom', name: 'concat' },
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
            items.splice(i, 2, newNode);
          }
          else if (prec.name === 'compose') {
            newNode = { type: 'operation', operator: ' ', left, right, name: 'compose' };
            items.splice(i, 2, newNode);
          }
          else if (prec.name === 'apply') {
            const args = [right];
            let j = i + 2;
            while (j < items.length && getCategory(items[j], env) === 'Atom') {
              args.push(items[j]);
              j++;
            }
            const rightNode = args.length === 1 ? args[0] : { type: 'coproduct_block', statements: args };
            newNode = { type: 'operation', operator: ' ', left, right: rightNode, name: 'apply' };
            items.splice(i, 1 + args.length, newNode);
          }
          else if (prec.name === 'apply_reverse') {
            // 逆適用: 右辺(Lambda)に左辺(Atom)を適用する
            newNode = { type: 'operation', operator: ' ', left: right, right: left, name: 'apply' };
            items.splice(i, 2, newNode);
          }

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

export function getArity(node) {
  if (!node) return 0;
  if (typeof node === 'string') return 1;
  if (node.type === 'block') return getArity(node.content);
  if (node.type === 'coproduct_block') {
    return (node.statements || []).reduce((acc, s) => acc + getArity(s), 0);
  }
  if (node.type === 'operation') {
    // 0. Compose operation: f g (syntactic composition)
    if (node.name === 'compose') {
      return getArity(node.right);
    }
    // 1. Map/Filter point-free: [2 +,] or [* 2,]
    if (node.operator === ',') {
      if (node.left === undefined || node.right === undefined) {
        return 1;
      }
      return getArity(node.left) + getArity(node.right);
    }
    // 2. Lambda: parameters ? body
    if (node.operator === '?') {
      return getArity(node.left);
    }
    // 3. Binary point-free: [+]
    if (node.position !== 'prefix' && node.position !== 'postfix') {
      if (node.left === undefined && node.right === undefined) {
        return 2;
      }
      // 4. Partial binary point-free: [* 2] or [2 +]
      if (node.left === undefined || node.right === undefined) {
        return 1;
      }
    }
    // 5. Prefix/Postfix point-free: [!_] or [_!]
    if (node.position === 'prefix' || node.position === 'postfix') {
      if (node.operand === '_' || node.operand === undefined) {
        return 1;
      }
    }

    if (node.operator === '\\n' || node.operator === ' ' || node.operator === ',') {
      return getArity(node.left) + getArity(node.right);
    }
    if (node.operator === ':') {
      return getArity(node.left);
    }
    if (node.operator === '~') {
      return 0; // Rest parameter doesn't count towards required arity
    }
  }
  return 1;
}