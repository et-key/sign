'use strict';
/**
 * Sign lexer — minimal implementation.
 * 準拠: documents/ja-jp/impl/1_definition.md 「字句の定義」
 *
 * 実装している規則:
 *  1. 字句素は識別子・リテラル・演算子
 *  2. 予約語は無い（すべて演算子テーブル・構文で意味が決まる）
 *  3. カッコ6種（()[]{}）は全て同義の字句素として1文字トークンで返す
 *     （どれも「開き括弧」「閉じ括弧」という区別のみ持ち、種類は解析側で無視できる）
 *  4. タブによるインデントのみを認める。スペースはタブの代用にしない
 *  5. 字句素は空白で区切られる
 *  6. 文字列リテラルは `...` で囲む
 *  9. 文字列リテラル内部ではエスケープシーケンス不要（バックスラッシュは文字通り1文字）
 *
 * 未実装（今後の拡張ポイント）:
 *  - 文字リテラル（\の特殊記号運用）
 *  - 文字列と文字の結合によるバックスラッシュ/引用符/改行の埋め込み
 */

const OPERATOR_CHARS = new Set('~!@#$%^&*-+=|;:,.<>/?\'"`'.split(''));
const BRACKETS_OPEN = new Set(['(', '[', '{']);
const BRACKETS_CLOSE = new Set([')', ']', '}']);

function isIdentStart(ch) {
  return /[A-Za-z_\u00A0-\uFFFF]/.test(ch) && !OPERATOR_CHARS.has(ch);
}
function isIdentPart(ch) {
  return isIdentStart(ch) || /[0-9]/.test(ch);
}
function isDigit(ch) {
  return /[0-9]/.test(ch);
}

class LexError extends Error {
  constructor(msg, line, col) {
    super(`${msg} (line ${line}, col ${col})`);
    this.line = line;
    this.col = col;
  }
}

/**
 * @param {string} src
 * @returns {Array<{type:string, value:any, line:number, col:number}>}
 */
function lex(src) {
  // タブ以外のインデントを弾く（スペースはタブの代用にしない、というルール4の検査）
  const lines = src.split('\n');
  const tokens = [];
  const indentStack = [0];

  for (let lineNo = 0; lineNo < lines.length; lineNo++) {
    const raw = lines[lineNo];
    if (raw.trim() === '') continue; // 空行は無視

    // 行頭インデント計測（タブのみ許可）
    let i = 0;
    while (i < raw.length && raw[i] === '\t') i++;
    if (raw[i] === ' ') {
      throw new LexError('スペースによるインデントは禁止（タブのみ許可）', lineNo + 1, i + 1);
    }
    const indent = i;

    if (indent > indentStack[indentStack.length - 1]) {
      indentStack.push(indent);
      tokens.push({ type: 'INDENT', value: null, line: lineNo + 1, col: 1 });
    }
    while (indent < indentStack[indentStack.length - 1]) {
      indentStack.pop();
      tokens.push({ type: 'DEDENT', value: null, line: lineNo + 1, col: 1 });
    }

    let col = i;
    while (col < raw.length) {
      const ch = raw[col];

      if (ch === ' ' || ch === '\t') { col++; continue; }

      // 文字列リテラル `...`
      if (ch === '`') {
        let j = col + 1;
        let buf = '';
        while (j < raw.length && raw[j] !== '`') { buf += raw[j]; j++; }
        if (raw[j] !== '`') throw new LexError('閉じられていない文字列リテラル', lineNo + 1, col + 1);
        tokens.push({ type: 'STRING', value: buf, line: lineNo + 1, col: col + 1 });
        col = j + 1;
        continue;
      }

      // 数値リテラル
      if (isDigit(ch)) {
        let j = col;
        let buf = '';
        while (j < raw.length && (isDigit(raw[j]) || raw[j] === '.')) { buf += raw[j]; j++; }
        tokens.push({ type: 'NUMBER', value: Number(buf), line: lineNo + 1, col: col + 1 });
        col = j;
        continue;
      }

      // 括弧（6種同義）
      if (BRACKETS_OPEN.has(ch)) {
        tokens.push({ type: 'LPAREN', value: ch, line: lineNo + 1, col: col + 1 });
        col++; continue;
      }
      if (BRACKETS_CLOSE.has(ch)) {
        tokens.push({ type: 'RPAREN', value: ch, line: lineNo + 1, col: col + 1 });
        col++; continue;
      }

      // 識別子
      if (isIdentStart(ch)) {
        let j = col;
        let buf = '';
        while (j < raw.length && isIdentPart(raw[j])) { buf += raw[j]; j++; }
        tokens.push({ type: 'IDENT', value: buf, line: lineNo + 1, col: col + 1 });
        col = j;
        continue;
      }

      // 演算子（連続する記号を貪欲にまとめて1トークン。個別分割は構文解析側で行う）
      if (OPERATOR_CHARS.has(ch)) {
        let j = col;
        let buf = '';
        while (j < raw.length && OPERATOR_CHARS.has(raw[j])) { buf += raw[j]; j++; }
        tokens.push({ type: 'OP', value: buf, line: lineNo + 1, col: col + 1 });
        col = j;
        continue;
      }

      throw new LexError(`未知の文字: ${JSON.stringify(ch)}`, lineNo + 1, col + 1);
    }
    tokens.push({ type: 'NEWLINE', value: null, line: lineNo + 1, col: raw.length + 1 });
  }

  while (indentStack.length > 1) {
    indentStack.pop();
    tokens.push({ type: 'DEDENT', value: null, line: lines.length + 1, col: 1 });
  }
  tokens.push({ type: 'EOF', value: null, line: lines.length + 1, col: 1 });
  return tokens;
}

module.exports = { lex, LexError };
