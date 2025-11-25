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
// 2.5 単項演算子の変換
// ==========================================

/**
 * 前置演算子かどうかを判定
 * ["演算子", オペランド] の形式
 */
function isPrefixUnaryOperation(expr) {
  if (!Array.isArray(expr) || expr.length !== 2) {
    return false;
  }

  const operator = expr[0];
  // 前置演算子: ! (NOT) と - (符号反転)
  return operator === '!' || operator === '-';
}

/**
 * 後置演算子かどうかを判定
 * [オペランド, "演算子"] の形式
 */
function isPostfixUnaryOperation(expr) {
  if (!Array.isArray(expr) || expr.length !== 2) {
    return false;
  }

  const operator = expr[1];
  // 後置演算子: ! (階乗)
  return operator === '!';
}

/**
 * 絶対値演算子かどうかを判定
 * ["|", オペランド, "|"] の形式
 */
function isAbsoluteValue(expr) {
  return Array.isArray(expr) &&
    expr.length === 3 &&
    expr[0] === '|' &&
    expr[2] === '|';
}

/**
 * 単純な式かどうかを判定（括弧が不要な式）
 */
function isSimpleExpression(expr) {
  // 識別子
  if (/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(expr)) {
    return true;
  }
  // 数値リテラル
  if (/^-?\d+(\.\d+)?$/.test(expr)) {
    return true;
  }
  // 文字列リテラル
  if (/^".*"$/.test(expr)) {
    return true;
  }
  return false;
}

/**
 * 論理NOT: [!, x] → !x または (!(expr))
 */
function convertLogicalNot(operand) {
  // operandが単純な式の場合は括弧不要
  if (isSimpleExpression(operand)) {
    return `!${operand}`;
  }
  // 複雑な式の場合は括弧で囲む
  return `(!(${operand}))`;
}

/**
 * 符号反転: [-, x] → -x または (-(expr))
 */
function convertNegate(operand) {
  // operandが単純な式の場合は括弧不要
  if (isSimpleExpression(operand)) {
    return `-${operand}`;
  }
  // 複雑な式の場合は括弧で囲む
  return `(-(${operand}))`;
}

/**
 * 階乗: [x, !] → Sign_factorial(x)
 */
function convertFactorial(operand) {
  // operandが単純な式の場合は括弧不要
  if (isSimpleExpression(operand)) {
    return `Sign_factorial(${operand})`;
  }
  // 複雑な式の場合は括弧で囲む
  return `Sign_factorial((${operand}))`;
}

/**
 * 絶対値: [|, x, |] → Math.abs(x)
 */
function convertAbsoluteValue(operand) {
  // operandが単純な式の場合は括弧不要
  if (isSimpleExpression(operand)) {
    return `Math.abs(${operand})`;
  }
  // 複雑な式の場合は括弧で囲む
  return `Math.abs((${operand}))`;
}

// ==========================================
// 3. 演算子テーブル（中置記法用）
// ==========================================

/**
 * カンマ演算子: [x, y] → [x, y] (JavaScriptの配列)
 * 右結合で展開する
 */
function convertComma(left, right) {
  // 両辺が配列リテラルの場合、ネスト構造を保持
  // 例: [1, 2], [3, 4] → [[1, 2], [3, 4]]
  const leftIsArray = left.startsWith('[') && left.endsWith(']');
  const rightIsArray = right.startsWith('[') && right.endsWith(']');

  // 両辺が配列の場合は展開しない（ネスト構造を保持）
  if (leftIsArray && rightIsArray) {
    return `[${left}, ${right}]`;
  }

  // 右辺がカンマ式の配列の場合のみ展開する
  // ただし、右辺が完全な配列リテラル（ネスト構造）の場合は展開しない
  if (right.startsWith('[') && !right.startsWith('[...')) {
    // ネストした配列の場合は展開しない
    // 例: [[1, 2]] の形は保持
    if (right.match(/^\[\[.*\]\]$/)) {
      return `[${left}, ${right}]`;
    }
    // 単純な配列の場合は展開
    // 例: [2, 3] → 展開して [1, 2, 3]
    const rightContent = right.slice(1, -1);
    return `[${left}, ${rightContent}]`;
  }
  return `[${left}, ${right}]`;
}

/**
 * チルダ演算子（範囲）: [x, ~, y] → range(x, y)
 */
function convertRange(left, right) {
  return `range(${left}, ${right})`;
}

/**
 * get演算子: [x, ', y] → x.y (辞書アクセス) または x[y] (配列アクセス)
 * yがrange()の場合はx.slice()に変換
 */
function convertGet(left, right) {
  // range(a, b)の場合、slice(a, b+1)に変換
  if (right.startsWith('range(')) {
    const match = right.match(/range\((-?\d+),\s*(-?\d+)\)/);
    if (match) {
      const start = parseInt(match[1]);
      const end = parseInt(match[2]) + 1; // rangeは両端含むので+1
      return `${left}.slice(${start}, ${end})`;
    }
  }
  // 数値リテラルの場合は配列アクセス
  if (/^-?\d+$/.test(right)) {
    return `${left}[${right}]`;
  }

  // 識別子の場合はドット記法
  if (/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(right)) {
    return `${left}.${right}`;
  }

  // 文字列リテラルの場合はブラケット記法
  if (right.startsWith('"') && right.endsWith('"')) {
    return `${left}[${right}]`;
  }

  // その他の場合はブラケット記法
  return `${left}[${right}]`;
}

// ==========================================
// 辞書型（オブジェクト）の処理
// ==========================================

/**
 * 辞書型リテラルかどうかを判定
 * 配列の全要素が ["key", ":", value] の形式
 */
function isDictionaryLiteral(expr) {
  if (!Array.isArray(expr) || expr.length === 0) {
    return false;
  }

  // 全ての要素が [key, ":", value] 形式かチェック
  return expr.every(item =>
    Array.isArray(item) &&
    item.length === 3 &&
    item[1] === ':'
  );
}

/**
 * 辞書型リテラルを変換
 * [["key1", ":", value1], ["key2", ":", value2]] → { key1: value1, key2: value2 }
 */
function transpileDictionaryLiteral(expr) {
  const entries = expr.map(item => {
    const [key, , value] = item;

    // keyの変換
    let jsKey;
    if (typeof key === 'string') {
      // 文字列リテラルの場合は変換
      const stringLiteral = convertStringLiteral(key);
      if (stringLiteral) {
        jsKey = `[${stringLiteral}]`; // 計算されたプロパティ名
      } else if (/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(key)) {
        // 識別子の場合はそのまま
        jsKey = key;
      } else {
        jsKey = `"${key}"`;
      }
    } else {
      jsKey = transpileInfixExpression(key);
    }

    // valueの変換（値が辞書型リテラルの可能性もある）
    const jsValue = transpileInfixExpression(value);

    // keyが識別子の場合は key: value、それ以外は [key]: value
    if (/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(jsKey)) {
      return `${jsKey}: ${jsValue}`;
    } else {
      return `${jsKey}: ${jsValue}`;
    }
  });

  // インデント付きで整形
  const indent = '  ';
  const formattedEntries = entries.map(e => `${indent}${e}`).join(',\n');

  return `{\n${formattedEntries}\n}`;
}

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

  // リスト演算子
  ',': convertComma,
  '~': convertRange,
  "'": convertGet,
};

// ==========================================
// 8. ブラケット構文の処理
// ==========================================

/**
 * ブラケット構文かどうかを判定
 * ["[", content, "]"] の形式
 * または ["[", "]"] の形式（空ブラケット）
 */
function isBracketExpression(expr) {
  // 通常のブラケット: ["[", content, "]"]
  if (Array.isArray(expr) &&
    expr.length === 3 &&
    expr[0] === '[' &&
    expr[2] === ']') {
    return true;
  }

  // 空ブラケット: ["[", "]"]
  if (Array.isArray(expr) &&
    expr.length === 2 &&
    expr[0] === '[' &&
    expr[1] === ']') {
    return true;
  }

  return false;
}

/**
 * 空ブラケット: [] → []
 */
function isEmptyBracket(expr) {
  // ["[", "]"] の2要素形式も空ブラケットとして扱う
  if (Array.isArray(expr) && expr.length === 2 && expr[0] === '[' && expr[1] === ']') {
    return true;
  }
  return isBracketExpression(expr) && expr[1] === ']';
}

/**
 * MAP演算かどうかを判定
 * ["[", [expr, ","], "]"] の形式
 */
function isMapExpression(expr) {
  if (!isBracketExpression(expr)) return false;
  const content = expr[1];
  return Array.isArray(content) &&
    content.length === 2 &&
    content[1] === ',';
}

/**
 * FOLD演算かどうかを判定
 * ["[", operator, "]"] の形式（演算子だけ）
 */
function isFoldExpression(expr) {
  if (!isBracketExpression(expr)) return false;
  const content = expr[1];
  return typeof content === 'string' &&
    INFIX_OPERATOR_TABLE[content] !== undefined;
}

/**
 * MAP演算を変換
 * ["[", [expr, ","], "]"] → x => expr
 */
function transpileMapExpression(expr) {
  const content = expr[1][0]; // [expr, ","] の expr部分

  // ラムダ式の場合
  if (isLambda(content)) {
    return transpileInfixExpression(content);
  }

  // 部分適用の場合（演算子 + 値）
  if (Array.isArray(content) && content.length === 2) {
    const [op, value] = content;
    if (typeof op === 'string' && INFIX_OPERATOR_TABLE[op]) {
      const valueStr = transpileInfixExpression(value);
      // 演算子に応じてラムダ式を生成
      if (op === '+') return `x => x + ${valueStr}`;
      if (op === '-') return `x => x - ${valueStr}`;
      if (op === '*') return `x => x * ${valueStr}`;
      if (op === '/') return `x => x / ${valueStr}`;
      if (op === '%') return `x => x % ${valueStr}`;
      if (op === '^') return `x => Math.pow(x, ${valueStr})`;
    }
  }

  // より複雑な式の場合（例: [[*, 2], +, 1]）
  if (Array.isArray(content) && content.length === 3) {
    const [left, op, right] = content;

    // 左辺が部分適用式 [演算子, 値] の場合
    if (Array.isArray(left) && left.length === 2) {
      const [leftOp, leftValue] = left;
      if (typeof leftOp === 'string' && INFIX_OPERATOR_TABLE[leftOp]) {
        const leftValueStr = transpileInfixExpression(leftValue);
        const rightStr = transpileInfixExpression(right);

        // 左側の部分適用を展開
        let leftExpr = '';
        if (leftOp === '+') leftExpr = `x + ${leftValueStr}`;
        else if (leftOp === '-') leftExpr = `x - ${leftValueStr}`;
        else if (leftOp === '*') leftExpr = `x * ${leftValueStr}`;
        else if (leftOp === '/') leftExpr = `x / ${leftValueStr}`;
        else if (leftOp === '%') leftExpr = `x % ${leftValueStr}`;
        else if (leftOp === '^') leftExpr = `Math.pow(x, ${leftValueStr})`;

        // 全体の式を構築
        if (op === '+') return `x => ${leftExpr} + ${rightStr}`;
        if (op === '-') return `x => ${leftExpr} - ${rightStr}`;
        if (op === '*') return `x => ${leftExpr} * ${rightStr}`;
        if (op === '/') return `x => ${leftExpr} / ${rightStr}`;
        if (op === '%') return `x => ${leftExpr} % ${rightStr}`;
        if (op === '^') return `x => Math.pow(${leftExpr}, ${rightStr})`;
      }
    }

    // 通常の三項演算の場合
    const exprStr = transpileInfixExpression(content);
    return `x => ${exprStr}`;
  }

  return `x => ${transpileInfixExpression(content)}`;
}

/**
 * FOLD演算を変換
 * ["[", operator, "]"] → (acc, x) => acc op x
 */
function transpileFoldExpression(expr) {
  const op = expr[1];

  if (op === '+') return `(acc, x) => acc + x`;
  if (op === '-') return `(acc, x) => acc - x`;
  if (op === '*') return `(acc, x) => acc * x`;
  if (op === '/') return `(acc, x) => acc / x`;
  if (op === '%') return `(acc, x) => acc % x`;

  return `(acc, x) => acc ${op} x`;
}

/**
 * ブラケット構文を変換
 */
function transpileBracketExpression(expr) {
  // 空ブラケット
  if (isEmptyBracket(expr)) {
    return '[]';
  }

  // MAP演算
  if (isMapExpression(expr)) {
    return transpileMapExpression(expr);
  }

  // FOLD演算
  if (isFoldExpression(expr)) {
    return transpileFoldExpression(expr);
  }

  // 通常のブラケット（配列リテラルまたは範囲リスト）
  const content = expr[1];

  // contentが "]" の場合は空ブラケット（念のため）
  if (content === ']') {
    return '[]';
  }

  const result = transpileInfixExpression(content);

  // 範囲リストの場合はそのまま返す（rangeは配列を返す）
  if (Array.isArray(content) && content.length === 3 && content[1] === '~') {
    return result;
  }

  // 配列リテラルの場合、結果が配列でなければ配列に入れる
  if (!result.startsWith('[')) {
    return `[${result}]`;
  }

  return result;
}

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
 * ラムダ式かどうかを判定
 * [params, "?", body] の形式で、bodyは単一の式
 * params は 文字列 または 文字列の配列
 */
function isLambda(expr) {
  // [params, "?", body] の形式かチェック
  if (!Array.isArray(expr) || expr.length !== 3 || expr[1] !== '?') {
    return false;
  }

  const body = expr[2];

  // bodyが配列でない場合は単純なラムダ式
  if (!Array.isArray(body)) {
    return true;
  }

  // bodyが配列の場合、match_caseかどうかを判定
  // match_caseの厳密な構造: [[case1], [case2], ...] の形式
  // 各caseは必ず配列で1重にラップされている

  // bodyが空配列の場合はラムダ式として扱う
  if (body.length === 0) {
    return true;
  }

  // match_caseの判定: 全ての要素が配列で1重ラップされているか
  // そして、その内部に":"を含む条件節、または単一要素のデフォルトケースがあるか
  const allElementsAreWrappedArrays = body.every(element => Array.isArray(element));

  if (!allElementsAreWrappedArrays) {
    // 全要素が配列でない場合は、通常の式（ラムダ式）
    return true;
  }

  // 全要素が配列の場合、さらに検証
  // match_caseかどうかを判定するために、内部構造を確認
  const hasMatchCaseStructure = body.some(element => {
    if (!Array.isArray(element) || element.length === 0) {
      return false;
    }

    const innerElement = element[0];

    // [[condition, ":", value]] の形式を検出
    if (Array.isArray(innerElement) && innerElement.length === 3 && innerElement[1] === ':') {
      return true;
    }

    // [[value]] の形式（デフォルトケース）を検出
    // ただし、これが単なる式の一部でないことを確認
    // デフォルトケースは通常、単一要素の配列
    if (Array.isArray(innerElement) && element.length === 1) {
      // これがmatch_caseのデフォルトケースかどうかは、
      // 他の要素も見て判断する必要がある
      return false; // とりあえず保留
    }

    return false;
  });

  if (hasMatchCaseStructure) {
    return false; // match_case
  }

  // ここまで来た場合、bodyは式の構造
  // 例: [[a, *, [x, ^, 2]], "+", [b, *, x]] のような二項演算
  // この場合はラムダ式として扱う
  return true;
}

/**
 * match_case構文かどうかを判定
 * [params, "?", cases] の形式
 */
function isMatchCase(expr) {
  // [params, "?", cases] の形式かチェック
  if (!Array.isArray(expr) || expr.length !== 3 || expr[1] !== '?') {
    return false;
  }

  // ラムダ式でない場合はmatch_case
  return !isLambda(expr);
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
 * ラムダ式を変換
 * ["?", params, body] → カリー化アロー関数
 */
function transpileLambda(params, body) {
  // パラメータの正規化
  const paramList = normalizeParams(params);

  // 本体を変換
  const bodyStr = transpileInfixExpression(body);

  // カリー化関数を構築
  return buildCurriedArrow(paramList, bodyStr);
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
      const valueExpr = caseExpr[2];

      // 返値がmatch_caseの場合、switch文本体のみを取り出す
      let value;
      if (isMatchCase(valueExpr)) {
        value = transpileNestedMatchCase(valueExpr);  // ネスト用の変換
      } else {
        value = transpileInfixExpression(valueExpr);  // 通常の式として変換
      }

      normalCases.push({ condition, value });
    } else if (Array.isArray(caseExpr) && caseExpr.length === 1) {
      // デフォルトケース: [value]
      const valueExpr = caseExpr[0];
      if (isMatchCase(valueExpr)) {
        defaultCase = transpileNestedMatchCase(valueExpr);
      } else {
        defaultCase = transpileInfixExpression(valueExpr);
      }
    } else {
      // デフォルトケース: value（配列でない場合）
      if (isMatchCase(caseExpr)) {
        defaultCase = transpileNestedMatchCase(caseExpr);
      } else {
        defaultCase = transpileInfixExpression(caseExpr);
      }
    }
  });

  // switch文の構築
  let switchBody = '{\n  switch (true) {\n';

  normalCases.forEach(c => {
    // 値がswitch文の場合は、ネストしたswitchとして展開
    if (c.value.startsWith('switch (true)')) {
      switchBody += `    case ${c.condition}:\n      ${c.value.replace(/\n/g, '\n      ')}\n`;
    } else {
      switchBody += `    case ${c.condition}: return ${c.value};\n`;
    }
  });

  if (defaultCase !== null) {
    // デフォルト値がswitch文の場合
    if (defaultCase.startsWith('switch (true)')) {
      switchBody += `    default:\n      ${defaultCase.replace(/\n/g, '\n      ')}\n`;
    } else {
      switchBody += `    default: return ${defaultCase};\n`;
    }
  }

  switchBody += '  }\n}';

  // カリー化関数を構築
  return buildCurriedArrow(paramList, switchBody);
}

/**
 * ネストしたmatch_caseを変換（返値として使用される場合）
 * 関数ラッパーなしでswitch文本体のみを返す
 */
function transpileNestedMatchCase(expr) {
  const [params, , cases] = expr; // params ? cases

  // パラメータは無視（既に外側で定義されている）
  // ケースの処理
  const normalCases = [];
  let defaultCase = null;

  cases.forEach(caseBlock => {
    const caseExpr = caseBlock[0];

    if (Array.isArray(caseExpr) && caseExpr.length === 3 && caseExpr[1] === ':') {
      const condition = transpileMatchCaseCondition(caseExpr[0]);
      const valueExpr = caseExpr[2];

      // さらにネストしている場合も対応
      let value;
      if (isMatchCase(valueExpr)) {
        value = transpileNestedMatchCase(valueExpr);
      } else {
        value = transpileInfixExpression(valueExpr);
      }

      normalCases.push({ condition, value });
    } else if (Array.isArray(caseExpr) && caseExpr.length === 1) {
      const valueExpr = caseExpr[0];
      if (isMatchCase(valueExpr)) {
        defaultCase = transpileNestedMatchCase(valueExpr);
      } else {
        defaultCase = transpileInfixExpression(valueExpr);
      }
    } else {
      if (isMatchCase(caseExpr)) {
        defaultCase = transpileNestedMatchCase(caseExpr);
      } else {
        defaultCase = transpileInfixExpression(caseExpr);
      }
    }
  });

  // switch文の構築（関数ラッパーなし）
  let switchBody = 'switch (true) {\n';

  normalCases.forEach(c => {
    if (c.value.startsWith('switch (true)')) {
      switchBody += `  case ${c.condition}:\n    ${c.value.replace(/\n/g, '\n    ')}\n`;
    } else {
      switchBody += `  case ${c.condition}: return ${c.value};\n`;
    }
  });

  if (defaultCase !== null) {
    if (defaultCase.startsWith('switch (true)')) {
      switchBody += `  default:\n    ${defaultCase.replace(/\n/g, '\n    ')}\n`;
    } else {
      switchBody += `  default: return ${defaultCase};\n`;
    }
  }

  switchBody += '}';

  return switchBody;
}

// ==========================================
// 5. 関数適用の処理（簡易版）
// ==========================================

/**
 * 後置チルダ（展開演算子）を処理
 * "list~" → "...list"
 */
function hasPostfixTilde(token) {
  return typeof token === 'string' && token.endsWith('~');
}

function convertPostfixTilde(token) {
  return `...${token.slice(0, -1)}`;
}

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

  // ブラケット構文は除外
  if (isBracketExpression(expr)) {
    return false;
  }

  // 残りは関数適用と判定
  return true;
}

/**
 * 関数適用を変換
 * MAP/FOLDの場合は特別処理
 * リスト結合の場合はスプレッド演算子を使用
 */
function transpileFunctionApplication(expr) {
  const [func, ...args] = expr;

  const funcStr = transpileInfixExpression(func);

  // MAPの場合: [* 2,] list → list.map(x => x * 2)
  if (isBracketExpression(func) && isMapExpression(func)) {
    const mapper = transpileMapExpression(func);
    const target = transpileInfixExpression(args[0]);
    return `${target}.map(${mapper})`;
  }

  // FOLDの場合: [+] list → list.reduce((acc, x) => acc + x)
  if (isBracketExpression(func) && isFoldExpression(func)) {
    const reducer = transpileFoldExpression(func);
    const target = transpileInfixExpression(args[0]);
    return `${target}.reduce(${reducer})`;
  }

  // 後置チルダを含む場合は関数適用として処理
  const hasAnyTilde = args.some(arg => typeof arg === 'string' && arg.endsWith('~'));
  if (hasAnyTilde) {
    const argsStr = args.map(arg => {
      const argStr = transpileInfixExpression(arg);
      // スプレッド演算子の場合は括弧で囲む
      return `(${argStr})`;
    }).join('');
    return `${funcStr}${argsStr}`;
  }

  // ブラケット式同士のリスト結合を検出
  // 例: [1, 2] [3, 4] → [...[1, 2], ...[3, 4]]
  if (args.length === 1) {
    const isFuncBracket = isBracketExpression(func) && !isMapExpression(func) && !isFoldExpression(func);
    const isArgBracket = isBracketExpression(args[0]) && !isMapExpression(args[0]) && !isFoldExpression(args[0]);

    if (isFuncBracket && isArgBracket) {
      const arg = transpileInfixExpression(args[0]);
      return `[...${funcStr}, ...${arg}]`;
    }

    // 片方がブラケット、片方が識別子の場合もリスト結合
    if ((isFuncBracket && typeof args[0] === 'string') ||
      (typeof func === 'string' && isArgBracket)) {
      const arg = transpileInfixExpression(args[0]);
      return `[...${funcStr}, ...${arg}]`;
    }
  }

  // 複数のブラケット式の結合
  if (args.length > 1) {
    const allBrackets = [func, ...args].every(item =>
      isBracketExpression(item) && !isMapExpression(item) && !isFoldExpression(item)
    );

    if (allBrackets) {
      const spreads = [func, ...args].map(item => {
        const str = transpileInfixExpression(item);
        return `...${str}`;
      }).join(', ');
      return `[${spreads}]`;
    }
  }

  // リスト結合の検出: 型情報を使った判定
  // 例: list1 list2 → [...list1, ...list2] (list1とlist2が両方リスト型の場合)
  if (args.length === 1 &&
    typeof func === 'string' &&
    typeof args[0] === 'string' &&
    !isBracketExpression(func) &&
    !isBracketExpression(args[0])) {

    // 型情報を取得
    const funcType = inferType(func);
    const argType = inferType(args[0]);

    // 両方がリスト型の場合はリスト結合
    if (funcType === 'list' && argType === 'list') {
      const arg = transpileInfixExpression(args[0]);
      return `[...${funcStr}, ...${arg}]`;
    }

    // それ以外は関数適用として処理（後続の処理へ）
  }

  // 複数引数のリスト結合: list1 list2 list3 → [...list1, ...list2, ...list3]
  if (args.length > 1 && args.every(arg => typeof arg === 'string')) {
    const allArgs = [func, ...args];

    // すべての引数の型を確認
    const types = allArgs.map(arg => inferType(arg));

    // すべてがリスト型の場合のみリスト結合
    if (types.every(t => t === 'list')) {
      const spreads = allArgs.map(arg => `...${transpileInfixExpression(arg)}`).join(', ');
      return `[${spreads}]`;
    }

    // それ以外は関数適用として処理（後続の処理へ）
  }

  // 通常の関数適用
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
  // 後置チルダの処理
  if (hasPostfixTilde(expr)) {
    return convertPostfixTilde(expr);
  }

  // ブラケット構文の検出
  if (isBracketExpression(expr)) {
    return transpileBracketExpression(expr);
  }

  // 単項演算子の検出と処理
  // 絶対値（囲み演算子）
  if (isAbsoluteValue(expr)) {
    const operand = transpileInfixExpression(expr[1]);
    return convertAbsoluteValue(operand);
  }

  // 前置演算子
  if (isPrefixUnaryOperation(expr)) {
    const [operator, operand] = expr;
    const operandStr = transpileInfixExpression(operand);

    if (operator === '!') {
      return convertLogicalNot(operandStr);
    } else if (operator === '-') {
      return convertNegate(operandStr);
    }
  }

  // 後置演算子
  if (isPostfixUnaryOperation(expr)) {
    const [operand, operator] = expr;
    const operandStr = transpileInfixExpression(operand);

    if (operator === '!') {
      return convertFactorial(operandStr);
    }
  }

  // ラムダ式の検出（match_caseより優先）: [params, "?", body]
  if (isLambda(expr)) {
    const [params, , body] = expr; // params ? body
    return transpileLambda(params, body);
  }

  // match_case構文の検出: [params, "?", cases]
  if (isMatchCase(expr)) {
    const [params, , cases] = expr; // params ? cases
    return transpileMatchCase(params, cases);
  }

  // 辞書型リテラルの検出: [["key1", ":", value1], ["key2", ":", value2], ...]
  if (isDictionaryLiteral(expr)) {
    return transpileDictionaryLiteral(expr);
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
// 7. シンボルテーブルと型推論
// ==========================================

// グローバルなシンボルテーブル
const symbolTable = {};

/**
 * 式の型を推論
 */
function inferType(expr) {
  // ブラケット式はリスト型
  if (isBracketExpression(expr)) {
    return 'list';
  }

  // 配列の場合（構造を持つ式）
  if (Array.isArray(expr)) {
    // 辞書型リテラル
    if (isDictionaryLiteral(expr)) {
      return 'object';
    }

    if (isMatchCase(expr) || isLambda(expr)) {
      return 'function';
    }

    // 二項演算の結果型を推論
    if (isBinaryOperation(expr)) {
      const [left, operator, right] = expr;

      // カンマ演算子はリスト型を生成
      if (operator === ',') {
        return 'list';
      }

      // 範囲演算子はリスト型を生成
      if (operator === '~') {
        return 'list';
      }

      // その他の演算子は左右のオペランドの型に依存
      const leftType = inferType(left);
      const rightType = inferType(right);

      // 両方がリストの場合、リスト結合の可能性
      if (leftType === 'list' && rightType === 'list') {
        return 'list';
      }

      // 算術演算は数値型
      if (['+', '-', '*', '/', '%', '^'].includes(operator)) {
        return 'number';
      }

      // 比較・論理演算は真偽値型
      if (['<', '<=', '=', '==', '>', '>=', '!=', '&', '|', ';'].includes(operator)) {
        return 'boolean';
      }
    }

    // 関数適用の場合
    if (isFunctionApplication(expr)) {
      const [func, ...args] = expr;

      // MAP式はリスト型を返す
      if (isBracketExpression(func) && isMapExpression(func)) {
        return 'list';
      }

      // FOLD式は要素型を返す（簡易的には'number'とする）
      if (isBracketExpression(func) && isFoldExpression(func)) {
        return 'number';
      }

      // 関数の返り値型は関数定義に依存（簡易的には'unknown'）
      return 'unknown';
    }

    return 'unknown';
  }

  // 文字列トークンの場合
  if (typeof expr === 'string') {
    // 数値リテラル
    if (/^-?\d+(\.\d+)?$/.test(expr)) {
      return 'number';
    }

    // 文字列リテラル
    if (expr.startsWith('`') && expr.endsWith('`')) {
      return 'string';
    }

    // 識別子の場合、シンボルテーブルを参照
    if (/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(expr)) {
      return symbolTable[expr]?.type || 'unknown';
    }
  }

  return 'unknown';
}

/**
 * シンボルテーブルに型情報を登録
 */
function registerSymbol(name, expr) {
  const type = inferType(expr);
  symbolTable[name] = { type, expr };
}

/**
 * シンボルテーブルをリセット（テスト用）
 */
function resetSymbolTable() {
  Object.keys(symbolTable).forEach(key => delete symbolTable[key]);
}

// ==========================================
// 8. 定義演算子の処理
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
  let valueExpr;
  if (valuePart.length === 1) {
    valueExpr = valuePart[0];
  } else {
    // 複数トークンの場合（通常はありえないが）
    valueExpr = valuePart;
  }

  // シンボルテーブルに登録（型推論）
  registerSymbol(name, valueExpr);

  // トランスパイル
  const value = transpileInfixExpression(valueExpr);

  return `const ${name} = ${value}`;
}

// ==========================================
// 9. 文とプログラムの変換
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

  // シンボルテーブルをリセット
  resetSymbolTable();

  const statements = tokensJson.map(transpileStatement);

  // ヘルパー関数を先頭に追加
  const helperFunctions = `// Helper functions
function range(start, end, step) {
  const result = [];
  // stepが未指定の場合、自動判定
  if (step === undefined) {
    step = start <= end ? 1 : -1;
  }
  if (step > 0) {
    for (let i = start; i <= end; i += step) {
      result.push(i);
    }
  } else {
    for (let i = start; i >= end; i += step) {
      result.push(i);
    }
  }
  return result;
}

function Sign_factorial(n) {
  if (n < 0) return NaN;
  if (n === 0 || n === 1) return 1;
  let result = 1;
  for (let i = 2; i <= n; i++) {
    result *= i;
  }
  return result;
}

`;

  return helperFunctions + statements.join('\n');
}

// ==========================================
// 10. エクスポート
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
  transpileNestedMatchCase,
  transpileMatchCaseCondition,
  normalizeParams,
  buildCurriedArrow,
  // ラムダ式関連
  isLambda,
  transpileLambda,
  // 関数適用
  isFunctionApplication,
  transpileFunctionApplication,
  // リスト操作関連
  isBracketExpression,
  isMapExpression,
  isFoldExpression,
  transpileBracketExpression,
  transpileMapExpression,
  transpileFoldExpression,
  convertComma,
  convertRange,
  convertGet,
  hasPostfixTilde,
  convertPostfixTilde,
  // 単項演算子関連
  isPrefixUnaryOperation,
  isPostfixUnaryOperation,
  isAbsoluteValue,
  convertLogicalNot,
  convertNegate,
  convertFactorial,
  convertAbsoluteValue,
  isSimpleExpression,
  // 型推論関連
  inferType,
  registerSymbol,
  resetSymbolTable,
  symbolTable
};