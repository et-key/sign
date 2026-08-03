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

// 【修正済み】以前は `prec = 1` から始めていたため、配列index 0（コメント上の優先順位"1"：
// 改行・前置export `#`/`##`/`###`）が一生 OPERATOR_DICT に登録されなかった。しかも
// `precedence: prec` は配列indexをそのまま使っていたため、他の全演算子もコメントの
// 優先順位表記より1つ小さい値で格納されていた（例: `:`はコメント"2"だが precedence=1
// として格納）。tier間の相対順序（どれがどれより先に処理されるか）はズレが一律だった
// ため偶然壊れずに動いていたが、pass2.js の reduceOnce が余積（スペース）を判定する
// ハードコードされた `tier === 10`（コメント通りの優先順位10を前提にしている）が、
// このバグにより実際にはコメント優先順位"11"のレンジ演算子（`~+`等）の格納値と衝突していた。
// `prec`を配列indexそのまま(0始まり)にし、`precedence: prec + 1`でコメント表記と一致させて解消。
for (let prec = 0; prec < OPERATOR_BY_PRECEDENCE.length; prec++) {
  const opsAtPrec = OPERATOR_BY_PRECEDENCE[prec];
  if (!opsAtPrec) continue;

  for (const symbol in opsAtPrec) {
    if (!OPERATOR_DICT[symbol]) {
      OPERATOR_DICT[symbol] = [];
    }
    OPERATOR_DICT[symbol].push({
      precedence: prec + 1,
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
  // 【修正済み】ダブルクォート文字列の内側 `(\\.|[^"\r\n])*` が捕捉グループのままだと、
  // 呼び出し側（lexer.jsのseparateInfix）が想定する「1番目=protect、2番目=operator」という
  // グループ番号が1つずれてしまい、operator側が常にundefinedになる（strictInfixによる
  // 演算子前後への自動スペース挿入が事実上一切機能しなくなる）バグがあった。
  // 非捕捉グループ `(?:...)` に変更して解消。
  const regexStr = `(\`[^\`\\r\\n]*\`|\`[^\\r\\n]*|"(?:\\\\.|[^"\\r\\n])*"|\\\\.|!!)|(${infixPattern})`;
  return new RegExp(regexStr, 'g');
}
