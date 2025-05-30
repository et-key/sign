# Sign言語セルフコンパイラ ドキュメント

## プロジェクト概要

このプロジェクトは、Sign言語で書かれたSign言語のセルフコンパイラです。Sign言語は数学的記号と自然言語の記号を再定義した独自のプログラミング言語で、このコンパイラはSign言語のコードを解析し、実行可能な形式に変換します。

## モジュール構成

### 1. コア機能モジュール

#### compiler.sn
- 役割 コンパイル処理全体の制御と実行
- 主要機能 
  - ソースファイルの読み込み
  - 字句解析、構文解析、コード生成の呼び出し
  - エラー処理と出力ファイルの生成
- 呼び出し方 `sign compiler.sn source_file.sn`

#### lexer.sn
- 役割 ソースコードの字句解析を担当
- 主要機能
  - 文字列リテラル、識別子、演算子などのトークン化
  - 行と列の位置情報の追跡
  - 空白演算子の適切な処理
- 主な関数 `tokenize` - ソースコードをトークン列に変換

#### parser.sn
- 役割 トークン列の構文解析を担当
- 主要機能
  - 抽象構文木(AST)の構築
  - インデントによるブロック構造の解析
  - 演算子優先順位に基づく式の解析
- 主な関数 `parse` - トークン列からASTを構築

#### generator.sn
- 役割 抽象構文木からコード生成を担当
- 主要機能
  - ASTノードに基づいたコード生成
  - タブによるインデントの適切な処理
  - 演算子の適切な出力形式の決定
- 主な関数 `generate` - ASTからコードを生成

### 2. 補助モジュール

#### utils.sn
- 役割 共通ユーティリティ関数の提供
- 主要機能
  - 文字種判定（数字、文字、演算子など）
  - ファイル操作（読み込み、書き込み）
  - 文字列処理（フォーマット、部分文字列抽出など）
- 主な関数 `formatSource`, `readFile`, `writeFile`など

#### token.sn
- 役割 トークン定義と操作関数の提供
- 主要機能
  - トークン型の定義（STRING, IDENT, NUMBERなど）
  - トークン生成と操作
  - デバッグ用のトークン文字列変換
- 主な関数 `newToken`, `tokenToString`など

#### ast.sn
- 役割 抽象構文木の定義と操作関数の提供
- 主要機能
  - ASTノード型の定義（LITERAL, BLOCK, OPなど）
  - ノード生成と操作
  - ツリー走査関数
- 主な関数 `newNode`, `traverseNode`など

#### error.sn
- 役割 エラー処理と報告機能の提供
- 主要機能
  - エラー型の定義（字句エラー、構文エラーなど）
  - エラーメッセージ生成
  - エラー報告と処理
- 主な関数 `reportError`, `reportSyntaxError`など

## 実行フロー

1. 初期化 compiler.snがエントリポイントとして実行される
2. ファイル読み込み 指定されたソースファイルを読み込む
3. フォーマット処理 `,` および `` 演算子の前後にスペースを挿入
4. 字句解析 lexer.snの`tokenize`関数でトークン列を生成
5. 構文解析 parser.snの`parse`関数でASTを構築
6. コード生成 generator.snの`generate`関数でコードを生成
7. 出力 生成されたコードをファイルに書き込み

```
[入力] -- compiler.sn -- [ファイル読み込み] -- [フォーマット処理]
                                                    
                                                    v
[出力] -- [ファイル書き込み] -- generator.sn -- parser.sn -- lexer.sn
```

## モジュール間依存関係

```
compiler.sn
  ↓
  ├─ lexer.sn ─── token.sn
  │                ↓
  ├─ parser.sn ── ast.sn
  │                ↓
  ├─ generator.sn
  │
  └─ utils.sn ─── error.sn
```

## テスト方法

各モジュールは以下の順序でテストすることを推奨します：

1. 基本モジュール（utils.sn, token.sn, ast.sn, error.sn）のテスト
2. lexer.snのトークン化機能のテスト
3. parser.snの構文解析機能のテスト
4. generator.snのコード生成機能のテスト
5. compiler.snの統合テスト

## 実装上の注意点

1. 空白の処理 空白演算子と通常の区切りとしての空白を正確に区別
2. インデント処理 タブによるブロック構造を正確に解析
3. 演算子の優先順位 複雑な式の正確な解析のため演算子優先順位を適切に処理
4. 文脈依存演算子 同じ記号でも位置によって意味が変わる演算子（`~`, `@`, `#`, `!`）の適切な処理

## 実行環境

このコンパイラを実行するためには、Sign言語のインタープリタまたはランタイム環境が必要です。
JavaScriptやPythonなどの既存言語へのトランスパイラを使った実行環境の構築が最も実用的なアプローチです。
