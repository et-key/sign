/**
 * Sign言語 → JavaScript トランスパイラ
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
         typeof expr[1] === 'string';
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
 * 比較演算子: [x, <, y] → (x < y ? x : undefined)
 */
function convertComparison(left, operator, right) {
  return `(${left} ${operator} ${right} ? ${left} : undefined)`;
}

/**
 * 等価比較: [x, =, y] → (x === y ? x : undefined)
 */
function convertEqual(left, right) {
  return `(${left} === ${right} ? ${left} : undefined)`;
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
  
  // 比較演算子
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
// 4. 式の変換（中置記法）
// ==========================================

/**
 * 式を再帰的にトランスパイル（中置記法）
 */
function transpileInfixExpression(expr) {
  // 配列の場合：二項演算の可能性
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
    
    // その他の配列形式（将来の拡張用）
    return `/* Complex expression */`;
  }
  
  // アトムの場合：リテラルまたは識別子
  return convertAtom(expr);
}

// ==========================================
// 5. 定義演算子の処理
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
// 6. 文とプログラムの変換
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
  
  // 複数ブロック（match_case等、将来の拡張用）
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
// 7. エクスポート
// ==========================================

module.exports = {
  transpile,
  transpileInfixExpression,
  transpileStatement,
  transpileDefinition,
  convertAtom,
  INFIX_OPERATOR_TABLE
};
