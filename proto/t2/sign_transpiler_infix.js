/**
 * Sign言語 → JavaScript トランスパイラ (match_case対応版)
 * 
 * 入力: tokens.json (演算子優先順位で階層化済みの中置記法)
 * 出力: JavaScript コード
 */

'use strict';

// ==========================================
// 1. リテラル変換
// ==========================================

/**
 * 文字列リテラルを変換
 * `Hello World` → "Hello World"
 */
function convertStringLiteral(token) {
  if (typeof token === 'string' && token.startsWith('`') && token.endsWith('`')) {
    const content = token.slice(1, -1);
    // バックスラッシュとダブルクォートをエスケープ
    const escaped = content.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
    return `"${escaped}"`;
  }
  return null;
}

/**
 * 文字リテラルを変換
 * \n → "\\n"
 * \M → "M"
 */
function convertCharLiteral(token) {
  if (typeof token === 'string' && token.startsWith('\\') && token.length === 2) {
    const char = token[1];
    const escapeMap = {
      'n': '\\n',
      't': '\\t',
      'r': '\\r',
      '\\': '\\\\',
      '0': '\\0',
      'b': '\\b',
      'f': '\\f',
      'v': '\\v'
    };
    
    if (escapeMap[char]) {
      return `"${escapeMap[char]}"`;
    }
    return `"${char}"`;
  }
  return null;
}

/**
 * 数値リテラルを変換（そのまま）
 */
function convertNumberLiteral(token) {
  if (typeof token === 'string' && /^-?\d+(\.\d+)?$/.test(token)) {
    return token;
  }
  if (typeof token === 'string' && /^0x[0-9A-Fa-f]+$/.test(token)) {
    return token; // 16進数
  }
  if (typeof token === 'string' && /^0o[0-7]+$/.test(token)) {
    return token; // 8進数
  }
  if (typeof token === 'string' && /^0b[01]+$/.test(token)) {
    return token; // 2進数
  }
  return null;
}

/**
 * Unitを変換
 * _ → undefined
 */
function convertUnit(token) {
  if (token === '_') {
    return 'undefined';
  }
  return null;
}

/**
 * 識別子をそのまま返す
 */
function convertIdentifier(token) {
  if (typeof token === 'string' && /^[a-zA-Z_][a-zA-Z0-9_]*$/.test(token)) {
    return token;
  }
  return null;
}

/**
 * リテラルまたは識別子を変換
 */
function convertAtom(token) {
  return convertStringLiteral(token) ||
         convertCharLiteral(token) ||
         convertNumberLiteral(token) ||
         convertUnit(token) ||
         convertIdentifier(token) ||
         token; // それ以外はそのまま
}

// ==========================================
// 2. 中置記法の二項演算変換
// ==========================================

/**
 * 二項演算を判定
 * [left, operator, right] の形式かどうか
 */
function isBinaryOperation(expr) {
  return Array.isArray(expr) && 
         expr.length === 3 && 
         typeof expr[1] === 'string' &&
         expr[1] !== '?';  // ? はmatch_caseのマーカー
}

/**
 * 加算: [x, +, y] → x + y
 */
function convertAddition(left, right) {
  return `${left} + ${right}`;
}

/**
 * 減算: [x, -, y] → x - y
 */
function convertSubtraction(left, right) {
  return `${left} - ${right}`;
}

/**
 * 乗算: [x, *, y] → x * y
 */
function convertMultiplication(left, right) {
  return `${left} * ${right}`;
}

/**
 * 除算: [x, /, y] → x / y
 */
function convertDivision(left, right) {
  return `${left} / ${right}`;
}

/**
 * 剰余: [x, %, y] → x % y
 */
function convertModulo(left, right) {
  return `${left} % ${right}`;
}

/**
 * 累乗: [x, ^, y] → Math.pow(x, y)
 */
function convertPower(left, right) {
  return `Math.pow(${left}, ${right})`;
}

/**
 * 比較演算子: [x, <, y] → (x < y ? x : NaN)
 */
function convertComparison(left, operator, right) {
  return `(${left} ${operator} ${right} ? ${left} : NaN)`;
}

/**
 * 等価比較: [x, =, y] → (x === y ? x : NaN)
 */
function convertEqual(left, right) {
  return `(${left} === ${right} ? ${left} : NaN)`;
}

/**
 * 論理AND: [x, &, y] → (x && y)
 */
function convertAnd(left, right) {
  return `(${left} && ${right})`;
}

/**
 * 論理OR: [x, |, y] → (x || y)
 */
function convertOr(left, right) {
  return `(${left} || ${right})`;
}

/**
 * 論理XOR: [x, ;, y] → ((x || y) && !(x && y))
 */
function convertXor(left, right) {
  return `((${left} || ${right}) && !(${left} && ${right}))`;
}

// ==========================================
// 3. 演算子テーブル（中置記法用）
// ==========================================

const INFIX_OPERATOR_TABLE = {
  // 算術演算子
  '+': convertAddition,
  '-': convertSubtraction,
  '*': convertMultiplication,
  '/': convertDivision,
  '%': convertModulo,
  '^': convertPower,
  
  // 比較演算子（真なら左辺、偽ならNaN）
  '<': (l, r) => convertComparison(l, '<', r),
  '<=': (l, r) => convertComparison(l, '<=', r),
  '=': convertEqual,
  '==': convertEqual,
  '>': (l, r) => convertComparison(l, '>', r),
  '>=': (l, r) => convertComparison(l, '>=', r),
  '!=': (l, r) => convertComparison(l, '!==', r),
  
  // 論理演算子
  '&': convertAnd,
  '|': convertOr,
  ';': convertXor,
};

// ==========================================
// 4. match_case構文の処理
// ==========================================

/**
 * match_case用の条件式を変換（真偽値として評価）
 * 比較演算子は値返却型ではなく、真偽値として変換
 */
function transpileMatchCaseCondition(expr) {
  // 配列の場合：二項演算の可能性
  if (Array.isArray(expr)) {
    // 二項演算: [left, operator, right]
    if (isBinaryOperation(expr)) {
      const [left, operator, right] = expr;
      
      // 左辺と右辺を再帰的に処理
      const leftStr = transpileMatchCaseCondition(left);
      const rightStr = transpileMatchCaseCondition(right);
      
      // 比較演算子の場合は真偽値として変換
      if (['<', '<=', '=', '==', '>', '>=', '!='].includes(operator)) {
        const jsOp = operator === '=' || operator === '==' ? '===' : 
                     operator === '!=' ? '!==' : 
                     operator;
        return `${leftStr} ${jsOp} ${rightStr}`;
      }
      
      // その他の演算子は通常通り
      const converter = INFIX_OPERATOR_TABLE[operator];
      if (converter) {
        return converter(leftStr, rightStr);
      }
      
      return `/* Unknown operator: ${operator} */`;
    }
    
    // 関数適用などは通常通り
    if (isFunctionApplication(expr)) {
      return transpileFunctionApplication(expr);
    }
    
    return `/* Complex expression */`;
  }
  
  // アトムの場合：リテラルまたは識別子
  return convertAtom(expr);
}

/**
 * match_case構文かどうかを判定
 * ["?", params, cases] の形式
 */
function isMatchCase(expr) {
  return Array.isArray(expr) &&
         expr.length === 3 &&
         expr[0] === '?' &&
         Array.isArray(expr[2]);
}

/**
 * パラメータを配列に正規化
 * "x" → ["x"]
 * ["x", "y"] → ["x", "y"]
 */
function normalizeParams(params) {
  return Array.isArray(params) ? params : [params];
}

/**
 * カリー化された関数を構築
 * ["x"] + body → "x => body"
 * ["x", "y"] + body → "x => y => body"
 */
function buildCurriedArrow(params, body) {
  if (params.length === 1) {
    return `${params[0]} => ${body}`;
  }
  // 右から左へ畳み込み
  return params.reduceRight((acc, param) => {
    return `${param} => ${acc}`;
  }, body);
}

/**
 * match_case構文を変換
 * ["?", params, cases] → カリー化関数 + switch文
 */
function transpileMatchCase(params, cases) {
  // パラメータの正規化
  const paramList = normalizeParams(params);
  
  // ケースの分類
  const normalCases = [];
  let defaultCase = null;
  
  cases.forEach(caseBlock => {
    // caseBlock = [[condition, ":", value]] or [[value]]
    const caseExpr = caseBlock[0];
    
    if (Array.isArray(caseExpr) && caseExpr.length === 3 && caseExpr[1] === ':') {
      // 条件付きケース: [condition, ":", value]
      const condition = transpileMatchCaseCondition(caseExpr[0]);  // 真偽値として変換
      const value = transpileInfixExpression(caseExpr[2]);         // 通常の式として変換
      normalCases.push({ condition, value });
    } else if (Array.isArray(caseExpr) && caseExpr.length === 1) {
      // デフォルトケース: [value]
      defaultCase = transpileInfixExpression(caseExpr[0]);
    } else {
      // デフォルトケース: value（配列でない場合）
      defaultCase = transpileInfixExpression(caseExpr);
    }
  });
  
  // switch文の構築
  let switchBody = '{\n  switch (true) {\n';
  
  normalCases.forEach(c => {
    switchBody += `    case ${c.condition}: return ${c.value};\n`;
  });
  
  if (defaultCase !== null) {
    switchBody += `    default: return ${defaultCase};\n`;
  }
  
  switchBody += '  }\n}';
  
  // カリー化関数を構築
  return buildCurriedArrow(paramList, switchBody);
}

// ==========================================
// 5. 関数適用の処理（簡易版）
// ==========================================

/**
 * 関数適用かどうかを判定（簡易版）
 * [func, arg] or [func, arg1, arg2, ...]
 * ただし、演算子や特殊マーカーを除外
 */
function isFunctionApplication(expr) {
  if (!Array.isArray(expr) || expr.length < 2) {
    return false;
  }
  
  // 二項演算や特殊構文は除外
  if (expr.length === 3 && typeof expr[1] === 'string') {
    // 演算子テーブルにある場合は二項演算
    if (INFIX_OPERATOR_TABLE[expr[1]]) {
      return false;
    }
    // : や ? は特殊構文
    if (expr[1] === ':' || expr[1] === '?') {
      return false;
    }
  }
  
  // 残りは関数適用と判定
  return true;
}

/**
 * 関数適用を変換
 * [func, arg] → func(arg)
 * [func, arg1, arg2] → func(arg1)(arg2)
 */
function transpileFunctionApplication(expr) {
  const [func, ...args] = expr;
  
  const funcStr = transpileInfixExpression(func);
  const argsStr = args.map(arg => {
    const argStr = transpileInfixExpression(arg);
    return `(${argStr})`;
  }).join('');
  
  return `${funcStr}${argsStr}`;
}

// ==========================================
// 6. 式の変換（中置記法）
// ==========================================

/**
 * 式を再帰的にトランスパイル（中置記法）
 */
function transpileInfixExpression(expr) {
  // match_case構文の検出
  if (isMatchCase(expr)) {
    const [, params, cases] = expr;
    return transpileMatchCase(params, cases);
  }
  
  // 配列の場合：二項演算、関数適用などの可能性
  if (Array.isArray(expr)) {
    // 二項演算: [left, operator, right]
    if (isBinaryOperation(expr)) {
      const [left, operator, right] = expr;
      
      // 左辺と右辺を再帰的に処理
      const leftStr = transpileInfixExpression(left);
      const rightStr = transpileInfixExpression(right);
      
      // 演算子テーブルから変換関数を取得
      const converter = INFIX_OPERATOR_TABLE[operator];
      
      if (converter) {
        return converter(leftStr, rightStr);
      }
      
      // 未定義の演算子の場合
      return `/* Unknown operator: ${operator} */`;
    }
    
    // 関数適用
    if (isFunctionApplication(expr)) {
      return transpileFunctionApplication(expr);
    }
    
    // その他の配列形式（将来の拡張用）
    return `/* Complex expression */`;
  }
  
  // アトムの場合：リテラルまたは識別子
  return convertAtom(expr);
}

// ==========================================
// 7. 定義演算子の処理
// ==========================================

/**
 * 定義演算子を検出して変換
 * [name, :, value] → const name = value
 */
function transpileDefinition(tokens) {
  // : の位置を探す
  const colonIndex = tokens.indexOf(':');
  
  if (colonIndex === -1) {
    // 定義ではない場合は通常の式として処理
    return transpileInfixExpression(tokens);
  }
  
  // 名前部分（: より前）
  const namePart = tokens.slice(0, colonIndex);
  
  // 値部分（: より後）
  const valuePart = tokens.slice(colonIndex + 1);
  
  // 名前は単一のトークンであるべき
  if (namePart.length !== 1) {
    return `/* Invalid definition */`;
  }
  
  const name = convertAtom(namePart[0]);
  
  // 値が単一トークンか配列か
  let value;
  if (valuePart.length === 1) {
    value = transpileInfixExpression(valuePart[0]);
  } else {
    // 複数トークンの場合（通常はありえないが）
    value = valuePart.map(transpileInfixExpression).join(' ');
  }
  
  return `const ${name} = ${value}`;
}

// ==========================================
// 8. 文とプログラムの変換
// ==========================================

/**
 * 文をトランスパイル
 */
function transpileStatement(statement) {
  // statement = [block1, block2, ...] の形式
  // 通常は1ブロック
  
  if (statement.length === 1) {
    // 単一ブロック
    const tokens = statement[0];
    return transpileDefinition(tokens) + ';';
  }
  
  // 複数ブロック（将来の拡張用）
  return '/* Multi-block statement */;';
}

/**
 * プログラム全体をトランスパイル
 */
function transpile(tokensJson) {
  // tokensJson = [[statement1], [statement2], ...]
  
  const statements = tokensJson.map(transpileStatement);
  return statements.join('\n');
}

// ==========================================
// 9. エクスポート
// ==========================================

module.exports = {
  transpile,
  transpileInfixExpression,
  transpileStatement,
  transpileDefinition,
  convertAtom,
  INFIX_OPERATOR_TABLE,
  // match_case関連
  isMatchCase,
  transpileMatchCase,
  transpileMatchCaseCondition,
  normalizeParams,
  buildCurriedArrow,
  // 関数適用
  isFunctionApplication,
  transpileFunctionApplication
};