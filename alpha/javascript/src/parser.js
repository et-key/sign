'use strict';
/**
 * Sign parser — minimal implementation.
 *
 * スコープ（今日の設計議論で固まった範囲に絞っている。完全な演算子テーブル26段は未実装）:
 *  - トップレベル定義: `name : expr`  /  `name : <param-list> ? <body>`
 *  - 仮引数リスト（インデントブロック、各行は `ident` または `ident : default-expr`）
 *    順序依存の逐次評価スコープであること（1_definition.md 構文定義 6.）を前提にパースする
 *  - rest引数: 裸形 `~xs`（識別子直前に `~`） / ブラケット形 `[x ~xs]`
 *  - 式: 算術（+ - * / %）、比較（< <= > >= =）、空白による関数適用（簡易版）
 *
 * 未実装: ChainCompare、余積（スペース）演算子の型ベース多重分岐（apply/compose/concat等）、
 *         `#`/`@`/`$`のIO意味論そのもの（構文としては読めるが、意味解決は行わない）
 */

const { lex } = require('./lexer');

// 優先順位（テーブルの一部。数値が大きいほど強く結合）
const BIN_PRECEDENCE = {
  '=': 3, '==': 3, '!==': 3,
  '<': 3, '<=': 3, '>=': 3, '>': 3,
  '+': 5, '-': 5,
  '*': 6, '/': 6, '%': 6,
  '#': 1, // Output（低優先度＝右辺をできるだけ広く取る）
};

class ParseError extends Error {
  constructor(msg, tok) {
    super(`${msg} @ line ${tok ? tok.line : '?'}`);
  }
}

class Parser {
  constructor(tokens) {
    this.toks = tokens;
    this.pos = 0;
  }
  peek(o = 0) { return this.toks[this.pos + o]; }
  next() { return this.toks[this.pos++]; }
  expect(type, value) {
    const t = this.next();
    if (t.type !== type || (value !== undefined && t.value !== value)) {
      throw new ParseError(`expected ${type} ${value ?? ''}, got ${t.type} ${JSON.stringify(t.value)}`, t);
    }
    return t;
  }
  at(type, value) {
    const t = this.peek();
    return t.type === type && (value === undefined || t.value === value);
  }
  skipNewlines() {
    while (this.at('NEWLINE')) this.next();
  }

  parseProgram() {
    const defs = [];
    this.skipNewlines();
    while (!this.at('EOF')) {
      if (this.at('DEDENT') || this.at('INDENT')) { this.next(); continue; }
      defs.push(this.parseDefinition());
      this.skipNewlines();
    }
    return { type: 'Program', defs };
  }

  // name : ... [ ? body ]
  parseDefinition() {
    const name = this.expect('IDENT');
    this.expect('OP', ':');
    this.skipNewlines();

    if (this.at('INDENT')) {
      // 仮引数リスト or 複数行の値
      const params = this.parseParamList();
      this.expect('OP', '?');
      const body = this.parseBody();
      return { type: 'FnDef', name: name.value, params, body, line: name.line };
    }

    // 単一行の値定義 or 単一行仮引数 `x ? body`
    // まず先読みして、`?`が現れるまでのトークン列を仮引数候補として読む
    const startPos = this.pos;
    const maybeParams = this.tryParseInlineParamsThenQuestion();
    if (maybeParams) {
      const body = this.parseBody();
      return { type: 'FnDef', name: name.value, params: maybeParams, body, line: name.line };
    }
    this.pos = startPos;
    const value = this.parseExpr(0);
    return { type: 'ValueDef', name: name.value, value, line: name.line };
  }

  // 単一行 `x y:1 ? ...` 形式の仮引数リストを試しにパースする。
  // `?` に到達できなければ null を返し、呼び出し側でロールバックする。
  tryParseInlineParamsThenQuestion() {
    const params = [];
    try {
      while (!this.at('OP', '?')) {
        if (this.at('EOF') || this.at('DEDENT')) return null;
        params.push(this.parseParamLine());
      }
      this.expect('OP', '?');
      return params;
    } catch (e) {
      return null;
    }
  }

  parseParamList() {
    this.expect('INDENT');
    this.skipNewlines();
    const params = [];
    while (!this.at('DEDENT')) {
      params.push(this.parseParamLine());
      this.skipNewlines();
    }
    this.expect('DEDENT');
    return params;
  }

  // 1個の仮引数: `ident` / `ident : default-expr` / `~ident`（rest, 裸形）
  // ブラケット形 `[x ~xs]` は1個の複合パラメータとして扱う
  parseParamLine() {
    if (this.at('LPAREN', '[')) {
      return this.parseBracketParam();
    }
    let rest = false;
    if (this.at('OP', '~')) {
      this.next();
      rest = true;
    }
    const name = this.expect('IDENT');
    let def = null;
    if (this.at('OP', ':')) {
      this.next();
      def = this.parseExpr(0);
    }
    return { type: 'Param', name: name.value, rest, bracket: false, default: def, line: name.line };
  }

  parseBracketParam() {
    this.expect('LPAREN', '[');
    const fields = [];
    let restName = null;
    while (!this.at('RPAREN')) {
      if (this.at('OP', '~')) {
        this.next();
        const id = this.expect('IDENT');
        restName = id.value;
      } else {
        const id = this.expect('IDENT');
        fields.push(id.value);
      }
    }
    this.expect('RPAREN');
    return { type: 'Param', name: fields[0] || null, fields, rest: !!restName, restName, bracket: true, default: null };
  }

  // body: 単一行の式 か、インデントブロック（複数式、最後の値が返り値）
  parseBody() {
    if (this.at('INDENT')) {
      this.expect('INDENT');
      this.skipNewlines();
      const exprs = [];
      while (!this.at('DEDENT')) {
        exprs.push(this.parseExpr(0));
        this.skipNewlines();
      }
      this.expect('DEDENT');
      return { type: 'Block', exprs };
    }
    return this.parseExpr(0);
  }

  // 優先順位クライミングによる式パーサ（サブセット）
  parseExpr(minPrec) {
    let left = this.parseUnary();
    for (;;) {
      const t = this.peek();
      if (t.type !== 'OP' || !(t.value in BIN_PRECEDENCE)) break;
      const prec = BIN_PRECEDENCE[t.value];
      if (prec < minPrec) break;
      this.next();
      const right = this.parseExpr(prec + 1);
      left = { type: 'BinOp', op: t.value, left, right };
    }
    // 空白による関数適用（簡易版：識別子/リテラルが連続したら apply とみなす）
    return this.maybeApply(left);
  }

  maybeApply(left) {
    while (this.canStartAtom()) {
      const arg = this.parseUnary();
      left = { type: 'Apply', fn: left, arg };
    }
    return left;
  }

  canStartAtom() {
    const t = this.peek();
    if (t.type === 'IDENT') {
      // 「ident :」は新しいトップレベル定義の開始とみなし、空白適用の引数としては扱わない
      const n = this.peek(1);
      if (n && n.type === 'OP' && n.value === ':') return false;
      return true;
    }
    if (t.type === 'NUMBER' || t.type === 'STRING') return true;
    if (t.type === 'LPAREN') return true;
    return false;
  }

  parseUnary() {
    const t = this.peek();
    if (t.type === 'OP' && (t.value === '$' || t.value === '@' || t.value === '~')) {
      this.next();
      const operand = this.parseUnary();
      return { type: 'UnaryOp', op: t.value, operand };
    }
    return this.parsePostfix();
  }

  parsePostfix() {
    let node = this.parseAtom();
    while (this.at('OP', '~')) {
      this.next();
      node = { type: 'UnaryOp', op: '~post', operand: node };
    }
    return node;
  }

  parseAtom() {
    const t = this.peek();
    if (t.type === 'NUMBER') { this.next(); return { type: 'Number', value: t.value }; }
    if (t.type === 'STRING') { this.next(); return { type: 'String', value: t.value }; }
    if (t.type === 'IDENT') { this.next(); return { type: 'Ident', name: t.value, line: t.line }; }
    if (t.type === 'LPAREN') {
      this.next();
      const e = this.parseExpr(0);
      this.expect('RPAREN');
      return e;
    }
    throw new ParseError(`unexpected token ${t.type} ${JSON.stringify(t.value)}`, t);
  }
}

function parse(src) {
  const tokens = lex(src);
  const p = new Parser(tokens);
  return p.parseProgram();
}

module.exports = { parse, ParseError };
