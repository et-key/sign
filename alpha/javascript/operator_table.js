/**
 * Sign言語 演算子テーブル (正引き・逆引き)
 * documents/ja-jp/impl/syntax/operator_table.js から移植（正式仕様、変更なし）
 */

export const OPERATOR_BY_PRECEDENCE = [
  { // 1
    '\\n': { position: 'infix', name: 'newline' },
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
    '===': { position: 'infix', name: 'same' },
    '==': { position: 'infix', name: 'equal' },
    '!==': { position: 'infix', name: 'not_equal' },
  },
  { // 9
    ',': { position: 'infix', name: 'product' },
  },
  { // 10: 空白演算子（適用、リスト構築等）
    ' ': { position: 'infix', name: 'coproduct' },
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
    '-': { position: 'prefix', name: 'negate' },
    '><': { position: 'prefix', name: 'reverse' },
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

export const OPERATOR_DICT = {};

for (let prec = 1; prec < OPERATOR_BY_PRECEDENCE.length; prec++) {
  const opsAtPrec = OPERATOR_BY_PRECEDENCE[prec];
  if (!opsAtPrec) continue;

  for (const symbol in opsAtPrec) {
    if (!OPERATOR_DICT[symbol]) {
      OPERATOR_DICT[symbol] = [];
    }
    OPERATOR_DICT[symbol].push({
      precedence: prec,
      symbol: symbol,
      ...opsAtPrec[symbol]
    });
  }
}

export function getPolysemousOperators() {
  const polysemous = new Set();
  for (const [symbol, defs] of Object.entries(OPERATOR_DICT)) {
    if (symbol === ' ' || symbol === '\t') continue;
    const positions = new Set(defs.map(d => d.position));
    if (positions.size > 1 || positions.has('enclosure')) {
      polysemous.add(symbol);
    }
  }
  polysemous.add('|');
  return Array.from(polysemous);
}

export function getStrictInfixOperators() {
  const strictInfix = [];
  for (const [symbol, defs] of Object.entries(OPERATOR_DICT)) {
    if (symbol === ' ' || symbol === '|') continue;
    const positions = new Set(defs.map(d => d.position));
    if (positions.size === 1 && positions.has('infix')) {
      strictInfix.push(symbol);
    }
  }
  return strictInfix;
}

export function buildLexerRegex() {
  const escapeRegExp = (str) => str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const strictInfix = getStrictInfixOperators();
  strictInfix.sort((a, b) => b.length - a.length);
  const infixPattern = strictInfix.map(escapeRegExp).join('|');
  const regexStr = `(\`[^\`\\r\\n]*\`|\`[^\\r\\n]*|"(\\\\.|[^"\\r\\n])*"|\\\\.|!!)|(${infixPattern})`;
  return new RegExp(regexStr, 'g');
}
