import { OPERATOR_DICT } from './operator_table.js';

/**
 * 演算子の情報を取得する
 */
function getOperatorInfo(symbol, expectedPosition) {
  const defs = OPERATOR_DICT[symbol];
  if (!defs) return null;
  // 期待されるポジション（prefix, infix, postfix）に一致する定義を探す
  return defs.find(d => d.position === expectedPosition) || null;
}

/**
 * トークンの種類を判別する
 */
function identifyToken(token, previousIsOperand) {
  if (Array.isArray(token)) {
    return { type: 'operand', value: token }; // ネストされた配列はオペランド（ASTノード）として扱う
  }

  // 文字列の場合
  if (token === '"\\n"') {
    const def = getOperatorInfo('\\n', 'infix');
    if (def) return { type: 'infix', symbol: '\\n', name: def.name };
  }
  
  if (token.startsWith('"') || (token.startsWith('<') && token.endsWith('>'))) {
    // 制御タグや識別子、値など
    return { type: 'operand', value: token };
  }

  // 1. 後置演算子 (先頭が _ で、_ 以外に文字がある場合)
  if (token.startsWith('_') && token.length > 1) {
    const symbol = token.slice(1);
    const def = getOperatorInfo(symbol, 'postfix');
    if (def) {
      return { type: 'postfix', symbol: symbol, name: def.name };
    }
  }

  // 2. 前置演算子 (末尾が _ で、_ 以外に文字がある場合)
  if (token.endsWith('_') && token.length > 1) {
    const symbol = token.slice(0, -1);
    // 制御タグ(INDENT_など)は上で処理済み
    const def = getOperatorInfo(symbol, 'prefix');
    if (def) {
      return { type: 'prefix', symbol: symbol, name: def.name };
    }
  }

  // 3. 中置演算子
  const infixDef = getOperatorInfo(token, 'infix');
  if (infixDef) {
    // マイナス(-)などは前置と中置両方ある。
    // previousIsOperand が true なら中置、false なら前置(PEGで _ が付くはずだが念のため)
    return { type: 'infix', symbol: token, name: infixDef.name };
  }

  // 該当しないものは値として扱う
  return { type: 'operand', value: token };
}

/**
 * Shunting Yard アルゴリズム (AST構築)
 * @param {Array} tokens PEGから出力されたフラット(一部ネスト)なトークン配列
 */
export function buildAST(tokens) {
  if (!Array.isArray(tokens)) {
    return tokens;
  }

  // フラットな配列内の ABS_ / INDENT_ をネストされた配列に変換（復元）する
  function nestControlBlocks(flatTokens) {
    const root = [];
    const stack = [root];
    for (const token of flatTokens) {
      if (token === '"ABS_"' || token === '"INDENT_"' || token === '"["' || token === '"{"' || token === '"("') {
        const newGroup = [token];
        stack[stack.length - 1].push(newGroup);
        stack.push(newGroup);
      } else if (token === '"_ABS"' || token === '"_DEDENT"' || token === '"]"' || token === '"}"' || token === '")"') {
        if (stack.length > 1) {
          stack.pop();
        }
      } else {
        stack[stack.length - 1].push(token);
      }
    }
    return root;
  }

  const nestedTokens = nestControlBlocks(tokens);

  // 1. ネストされたブロックを再帰的にAST化する
  const resolvedTokens = nestedTokens.map(token => {
    if (Array.isArray(token)) {
      // 制御タグ (ABS_ や INDENT_) の確認
      if (token[0] === '"ABS_"') {
        // 絶対値ブロック。先頭のタグを除いて再帰。
        return { type: 'block', kind: 'abs', content: buildAST(token.slice(1)) };
      }
      if (token[0] === '"INDENT_"') {
        // インデントブロック。先頭のタグを除いて再帰。
        return { type: 'block', kind: 'indent', content: buildAST(token.slice(1)) };
      }
      if (token[0] === '"["') {
        return { type: 'block', kind: 'bracket', content: buildAST(token.slice(1)) };
      }
      if (token[0] === '"{"') {
        return { type: 'block', kind: 'brace', content: buildAST(token.slice(1)) };
      }
      if (token[0] === '"("') {
        return { type: 'block', kind: 'paren', content: buildAST(token.slice(1)) };
      }
      // 配列のまま渡されてきたものは単なる結合（concat）等としてそのまま処理
      return buildAST(token);
    }
    return token;
  });

  // 2. 暗黙のコプロダクト（余積）の解決
  // ここでは簡単な例として、オペランドが連続している場合は中置の「,」または適用として処理できるよう
  // 前処理を行います（詳細な結合は今後の要件に合わせて調整）
  // ※今回は標準的な操車場アルゴリズムの実装を優先します。

  const outputStack = [];
  const operatorStack = [];

  const popOperator = () => {
    const op = operatorStack.pop();
    if (op.type === 'infix') {
      const right = outputStack.pop();
      const left = outputStack.pop();
      outputStack.push({
        type: 'operation',
        operator: op.symbol,
        name: op.name,
        left: left,
        right: right
      });
    } else if (op.type === 'prefix' || op.type === 'postfix') {
      const operand = outputStack.pop();
      outputStack.push({ type: 'operation', operator: op.symbol, operand, position: op.type, name: op.name });
    }
  };

  let previousIsOperand = false;

  for (let i = 0; i < resolvedTokens.length; i++) {
    const token = resolvedTokens[i];

    // オブジェクト(すでに解決済みのASTノード)は operand として扱う
    let info;
    if (typeof token === 'object' && token !== null && !Array.isArray(token)) {
      info = { type: 'operand', value: token };
    } else {
      if (token === null || token === undefined) {
        console.error("Null token encountered! nestedTokens:", nestedTokens);
      }
      info = identifyToken(token, previousIsOperand);
    }

    if (info.type === 'operand') {
      // 暗黙の中置演算子（余積・適用）を挿入（プレセデンス10）
      if (previousIsOperand) {
        const coproductOp = { type: 'infix', symbol: ' ', precedence: 10, name: 'coproduct' };
        while (operatorStack.length > 0) {
          const top = operatorStack[operatorStack.length - 1];
          // プレセデンス値が大きいほど優先順位が高い。左結合なので >= 
          if (top.precedence >= coproductOp.precedence) {
            popOperator();
          } else {
            break;
          }
        }
        operatorStack.push(coproductOp);
      }
      outputStack.push(info.value);
      previousIsOperand = true;
    }
    else if (info.type === 'prefix') {
      const opDef = getOperatorInfo(info.symbol, 'prefix');
      info.precedence = opDef.precedence;

      // もしオペランドの直後に前置演算子が来た場合（例: `f ~y`）、
      // 間に暗黙の適用/余積があるものとして処理する
      if (previousIsOperand) {
        const coproductOp = { type: 'infix', symbol: ' ', precedence: 10, name: 'coproduct' };
        while (operatorStack.length > 0) {
          const top = operatorStack[operatorStack.length - 1];
          if (top.type !== 'prefix' && top.symbol !== '(' && top.symbol !== '[' && top.symbol !== '{' && top.symbol !== '\x02' && top.symbol !== '\x04') {
            if (top.precedence >= coproductOp.precedence) {
              popOperator();
              continue;
            }
          }
          break;
        }
        operatorStack.push(coproductOp);
      }

      operatorStack.push(info);
      previousIsOperand = false;
    }
    else if (info.type === 'postfix') {
      const opDef = getOperatorInfo(info.symbol, 'postfix');
      info.precedence = opDef.precedence;
      // 後置演算子は左結合としてすぐ処理するか、スタックに積む
      while (operatorStack.length > 0) {
        const top = operatorStack[operatorStack.length - 1];
        if (top.precedence >= info.precedence) {
          popOperator();
        } else {
          break;
        }
      }
      operatorStack.push(info);
      previousIsOperand = true;
    }
    else if (info.type === 'infix') {
      const opDef = getOperatorInfo(info.symbol, 'infix');
      info.precedence = opDef.precedence;

      while (operatorStack.length > 0) {
        const top = operatorStack[operatorStack.length - 1];
        if (top.precedence >= info.precedence) {
          popOperator();
        } else {
          break;
        }
      }
      operatorStack.push(info);
      previousIsOperand = false;
    }
  }

  while (operatorStack.length > 0) {
    popOperator();
  }

  // ブロック内に複数のステートメント（改行区切り等）がある場合は outputStack に複数残るため
  // それらをコプロダクトとして束ねる
  if (outputStack.length > 1) {
    return { type: 'coproduct_block', statements: outputStack };
  }

  return outputStack[0] || null;
}
