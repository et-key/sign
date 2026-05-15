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
  if (token.startsWith('"') || token.startsWith('<')) {
    // 制御タグや識別子、値など
    return { type: 'operand', value: token };
  }

  // 演算子の判定
  // 1. 後置演算子 (先頭が _ で、_ 以外に文字がある場合)
  if (token.startsWith('_') && token.length > 1) {
    const symbol = token.slice(1);
    if (getOperatorInfo(symbol, 'postfix')) {
      return { type: 'postfix', symbol: symbol };
    }
  }

  // 2. 前置演算子 (末尾が _ で、_ 以外に文字がある場合)
  if (token.endsWith('_') && token.length > 1) {
    const symbol = token.slice(0, -1);
    // 制御タグ(INDENT_など)は上で処理済み
    if (getOperatorInfo(symbol, 'prefix')) {
      return { type: 'prefix', symbol: symbol };
    }
  }

  // 3. 中置演算子
  if (getOperatorInfo(token, 'infix')) {
    // マイナス(-)などは前置と中置両方ある。
    // previousIsOperand が true なら中置、false なら前置(PEGで _ が付くはずだが念のため)
    return { type: 'infix', symbol: token };
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
      if (token === '"ABS_"' || token === '"INDENT_"') {
        const newGroup = [token];
        stack[stack.length - 1].push(newGroup);
        stack.push(newGroup);
      } else if (token === '"_ABS"' || token === '"_DEDENT"') {
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
      // 制御タグ（ABS_ や INDENT_）の確認
      if (token[0] === '"ABS_"') {
        // 絶対値ブロック（先頭のタグを除いて再帰）
        return { type: 'block', kind: 'abs', content: buildAST(token.slice(1)) };
      }
      if (token[0] === '"INDENT_"') {
        // インデントブロック（先頭のタグを除いて再帰）
        return { type: 'block', kind: 'indent', content: buildAST(token.slice(1)) };
      }
      // 通常の丸括弧・角括弧などのグループ
      return { type: 'block', kind: 'group', content: buildAST(token) };
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
      outputStack.push({ type: 'operation', operator: op.symbol, left, right });
    } else if (op.type === 'prefix' || op.type === 'postfix') {
      const operand = outputStack.pop();
      outputStack.push({ type: 'operation', operator: op.symbol, operand, position: op.type });
    }
  };

  let previousIsOperand = false;

  for (let i = 0; i < resolvedTokens.length; i++) {
    const token = resolvedTokens[i];

    // 既にASTノード（オブジェクト）になっているものはオペランド
    if (typeof token === 'object' && token !== null) {
      outputStack.push(token);
      previousIsOperand = true;
      continue;
    }

    const info = identifyToken(token, previousIsOperand);

    if (info.type === 'operand') {
      // 暗黙の中置演算子（隣接する値）に対する処理を追加可能
      if (previousIsOperand) {
        // 例えば関数の適用(apply)として ' ' をスタックに積むなどの処理
      }
      outputStack.push(info.value);
      previousIsOperand = true;
    }
    else if (info.type === 'prefix') {
      const opDef = getOperatorInfo(info.symbol, 'prefix');
      info.precedence = opDef.precedence;
      operatorStack.push(info);
      previousIsOperand = false;
    }
    else if (info.type === 'postfix') {
      const opDef = getOperatorInfo(info.symbol, 'postfix');
      info.precedence = opDef.precedence;
      // 後置演算子は左結合としてすぐ処理するか、スタックに積む
      while (operatorStack.length > 0) {
        const top = operatorStack[operatorStack.length - 1];
        if (top.precedence < info.precedence) { // 優先順位の数値が小さいほど優先度が高い
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
        // 優先順位の数値が小さいほど優先度が高い（例: 13(+) は 14(*) より優先度低いので pop しない）
        if (top.precedence <= info.precedence) {
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
