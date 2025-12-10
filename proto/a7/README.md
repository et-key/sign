# Sign言語 プロトタイプ A7

Sign言語のLexer、Parser、およびASTインタープリタのJavaScript実装です。

## 前提条件
- Node.js (v14以上)

## クイックスタート

### サンプルの実行
提供されているスクリプトを実行して、`documents/ja-jp/example.ja-jp.sn` をパースし実行することができます。

```bash
cd proto/a7
node run_example.js
```

このコマンドは以下の処理を行います:
1. ソースコードをパースします。
2. `example_ast.txt` にASTファイルを出力します。
3. ASTを実行し、結果を表示します。

## コード内での使用方法

ParserとInterpreterをご自身のスクリプトで使用することができます:

```javascript
const { parse } = require('./index');
const { Interpreter } = require('./interpreter');

// ソースコード
const code = `
x : 10
y : 20
result : x + y
`;

try {
    // 1. パース
    const ast = parse(code);
    
    // 2. 解釈・実行
    const interpreter = new Interpreter();
    const result = interpreter.evaluate(ast);
    
    console.log("Result:", result); // Output: 30
    console.log("x:", interpreter.globalEnv.get('x')); // 10
} catch (e) {
    console.error(e.message);
}
```

## プロジェクト構成

- `lexer.js`: ソースコードをトークン化し、インデントを処理します。
- `parser.js`: トークンを抽象構文木（AST）にパースします（Pratt Parser）。
- `interpreter.js`: ASTを評価・実行します。
- `runtime.js`: 言語のコアとなる値や演算子の振る舞いを定義します。
- `index.js`: パーサーをエクスポートするメインエントリポイントです。
- `test.js`: パーサー検証用のユニットテストです。
