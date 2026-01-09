# Sign言語 プロトタイプ A8

Sign言語のソースコードを、前置記法（S式）に変換するコンバーターの実装です。
Self-Hosted Compilerに向けた中間表現の生成を目的としています。

## 前提条件
- Node.js (v14以上)

## クイックスタート

### サンプルの実行
提供されているスクリプトを実行して、`documents/ja-jp/example.ja-jp.sn` をS式に変換できます。

```bash
cd proto/a8
node run.js
```

このコマンドは以下の処理を行います:
1. `example.ja-jp.sn` を読み込み、トークン化します（`Lexer`）。
2. S式（ネストされたJSON配列）に変換します（`Converter`）。
3. 結果を `example_sexpr.json` に出力します。

## コード内での使用方法

```javascript
const { Lexer } = require('./lexer');
const { Converter } = require('./converter');

const code = `x : a ? b`;

// 1. Lexing
const lexer = new Lexer(code);
const tokens = lexer.tokenize();

// 2. Converting
const converter = new Converter(tokens);
const sexpr = converter.convert();

console.log(JSON.stringify(sexpr, null, 2));
// Output: [['[?]', ['[:]', 'x', 'a'], 'b']]
```

## プロジェクト構成

- `lexer.js`: ソースコードをトークン化します。インデント管理や、演算子の空白による文脈（前置/中置/後置）の手がかりを提供します。
- `converter.js`: トークン列をS式に変換します。**「最低優先順位分割（Recursive Split by Lowest Precedence）」** アルゴリズムを採用しています。
- `run.js`: ファイル入出力を伴う実行スクリプトです。
- `debug_run.js`: 文字列リテラルによるテスト実行用スクリプトです。

## 主な機能
- **再帰的分割**: Pratt Parserではなく、演算子の優先順位に基づいて式を再帰的に分割するアプローチを採用しており、代数的構造（S式）への変換に適しています。
- **空白による曖昧性解消**:
  - `!x` (Tight Prefix) vs `! x` (Loose Prefix/Application)
  - `x~` (Tight Postfix)
  - `x ~ y` (Infix)
  - これらを厳密に区別し、構造的な優先順位（Tight > Infix > Loose）を提供します。
- **ポイントフリー記法**:
  - `[+]` (Operator as Function)
  - `[+ 2]` (Section / Partial Application)
  - これらを正しく識別し、特別なS式ノードとして出力します。
