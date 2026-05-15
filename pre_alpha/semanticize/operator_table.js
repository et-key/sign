/**
 * Sign言語 演算子テーブル (正引き・逆引き)
 * `A_Operator_Table.md` に基づく定義
 */

// 逆引き用: 優先順位順の配列 (precedens順)
// 配列のインデックスがそのまま優先順位 (precedence) を表します。インデックス0は未使用。
export const OPERATOR_BY_PRECEDENCE = [
  null, // 0: 未使用
  { // 1
    '#': { position: 'prefix', name: 'export_internal' },
    '##': { position: 'prefix', name: 'export_external' },
    '###': { position: 'prefix', name: 'export_pin' },
  },
  { // 2
    ':': { position: 'infix', name: 'define' },
  },
  { // 3
    '?': { position: 'infix', name: 'lambda' },
  },
  { // 4
    '#': { position: 'infix', name: 'output' },
  },
  { // 5
    ';': { position: 'infix', name: 'xor' },
  },
  { // 6
    '|': { position: 'infix', name: 'or' },
  },
  { // 7
    '&': { position: 'infix', name: 'and' },
  },
  { // 8
    '==': { position: 'infix', name: 'equal' },
    '!==': { position: 'infix', name: 'not_equal' },
  },
  { // 9
    ',': { position: 'infix', name: 'product' },
  },
  { // 10: 空白演算子（適用、リスト構築等）
    ' ': { position: 'infix', name: 'apply_or_concat' },
  },
  { // 11
    '~': { position: 'infix', name: 'range' },
    '~+': { position: 'infix', name: 'range_arithmetic' },
    '~-': { position: 'infix', name: 'range_arithmetic_rev' },
    '~*': { position: 'infix', name: 'range_geometric' },
    '~/': { position: 'infix', name: 'range_geometric_rev' },
    '~^': { position: 'infix', name: 'range_power' },
  },
  { // 12
    '<': { position: 'infix', name: 'less' },
    '<=': { position: 'infix', name: 'less_equal' },
    '=': { position: 'infix', name: 'assign_equal' },
    '>=': { position: 'infix', name: 'more_equal' },
    '>': { position: 'infix', name: 'more' },
    '!=': { position: 'infix', name: 'not_equal' },
  },
  { // 13
    '+': { position: 'infix', name: 'add' },
    '-': { position: 'infix', name: 'sub' },
  },
  { // 14
    '*': { position: 'infix', name: 'mul' },
    '/': { position: 'infix', name: 'div' },
    '%': { position: 'infix', name: 'mod' },
  },
  { // 15
    '^': { position: 'infix', name: 'pow' },
  },
  { // 16
    '|...|': { position: 'enclosure', name: 'abs' },
  },
  { // 17
    "'": { position: 'infix', name: 'get_prop' },
    '@': { position: 'infix', name: 'get_at' },
  },
  { // 18
    '<<': { position: 'infix', name: 'bit_shift_left' },
    '>>': { position: 'infix', name: 'bit_shift_right' },
  },
  { // 19
    '||': { position: 'infix', name: 'bit_or' },
  },
  { // 20
    ';;': { position: 'infix', name: 'bit_xor' },
  },
  { // 21
    '&&': { position: 'infix', name: 'bit_and' },
  },
  { // 22
    '!': { position: 'postfix', name: 'factorial' },
    '~': { position: 'postfix', name: 'expand' },
    '@': { position: 'postfix', name: 'import' },
  },
  { // 23
    '~': { position: 'prefix', name: 'continuous' },
    '!': { position: 'prefix', name: 'not' },
    '$': { position: 'prefix', name: 'address' },
    '@': { position: 'prefix', name: 'input' },
    '!!': { position: 'prefix', name: 'bit_not' },
    '-': { position: 'prefix', name: 'negate' }, // 仕様書に明記は無いが事実上の前置演算子
  },
  { // 24
    '(...)': { position: 'enclosure', name: 'block_paren' },
    '{...}': { position: 'enclosure', name: 'block_brace' },
    '[...]': { position: 'enclosure', name: 'block_bracket' },
  },
  { // 25
    '\t': { position: 'prefix', name: 'indent' },
  },
  { // 26
    '\\': { position: 'prefix', name: 'escape' },
  }
];

// 正引き用: 記号をキーとした辞書型 (symbol -> definitions array)
// 逆引きの配列から動的に生成する
export const OPERATOR_DICT = {};

for (let prec = 1; prec < OPERATOR_BY_PRECEDENCE.length; prec++) {
  const opsAtPrec = OPERATOR_BY_PRECEDENCE[prec];
  if (!opsAtPrec) continue;

  for (const symbol in opsAtPrec) {
    if (!OPERATOR_DICT[symbol]) {
      OPERATOR_DICT[symbol] = [];
    }
    // 元の構造と同等のオブジェクトを再構築して正引き辞書に追加
    OPERATOR_DICT[symbol].push({
      precedence: prec,
      symbol: symbol,
      ...opsAtPrec[symbol]
    });
  }
}

/**
 * ユーティリティ: 多義的演算子（複数の position を持つか、enclosure として機能するもの）を取得する
 */
export function getPolysemousOperators() {
  const polysemous = new Set();
  for (const [symbol, defs] of Object.entries(OPERATOR_DICT)) {
    if (symbol === ' ' || symbol === '\t') continue; // 空白系は除外
    const positions = new Set(defs.map(d => d.position));
    if (positions.size > 1 || positions.has('enclosure')) {
      polysemous.add(symbol);
    }
  }
  // 絶対値ブロック |...| の存在により、中置演算子の | も実質的に多義的な振る舞いをするため追加
  polysemous.add('|');
  return Array.from(polysemous);
}

/**
 * ユーティリティ: 純粋な中置演算子（中置機能しか持たないもの）を取得する
 */
export function getStrictInfixOperators() {
  const strictInfix = [];
  for (const [symbol, defs] of Object.entries(OPERATOR_DICT)) {
    // 空白は除外。また、| は絶対値ブロックと記号が被るため、自動空白挿入の対象外とする
    if (symbol === ' ' || symbol === '|') continue;
    
    const positions = new Set(defs.map(d => d.position));
    if (positions.size === 1 && positions.has('infix')) {
      strictInfix.push(symbol);
    }
  }
  return strictInfix;
}

/**
 * ユーティリティ: Lexer用の正規表現生成器
 * strict infix のみを長い順にマッチさせる正規表現などを生成できる
 */
export function buildLexerRegex() {
  const escapeRegExp = (str) => str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

  // 多義的演算子などを除いた、確実に前後に空白を挿入してよい演算子のリスト
  const strictInfix = getStrictInfixOperators();
  // 長い順にソート (例: !== が != や = より先にマッチするように)
  strictInfix.sort((a, b) => b.length - a.length);

  // 例: (!==|!=|==|<=|>=|<<|>>|\|\||;;|&&|~\+|~-|~\*|~\/|~\^|...)
  const infixPattern = strictInfix.map(escapeRegExp).join('|');

  // 前置専用だが、記号列の中に含まれると誤爆しやすいもの (例: !!) も保護対象に入れる
  // 今回はユーザーの `separateInfix` に合わせて、 `!!` などを保護対象に含める
  // （ユーザーの元の正規表現を踏襲しつつ、動的に生成する）
  const regexStr = `(\`[^\`\\r\\n]*\`|\`[^\\r\\n]*|\\\\.|!!)|(${infixPattern})`;

  return new RegExp(regexStr, 'g');
}
