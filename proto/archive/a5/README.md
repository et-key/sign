# Sign言語構文解析器 (proto/a5)

Sign言語のPython構文解析器実装。PEG文法と三段階判定の原則に基づいています。

## 概要

このパッケージはSign言語のソースコードを抽象構文木（AST）に変換する構文解析器を提供します。

### 主要コンポーネント

- **lexer.py**: 字句解析器（三段階判定の原則に基づく）
- **parser.py**: 構文解析器（PEG文法の優先順位1-16を実装）
- **ast_nodes.py**: AST ノード定義
- **main.py**: CLIインターフェース

## インストール

特別な依存関係はありません。Python 3.7以上が必要です。

## 使用方法

### コマンドライン

```bash
# ファイルを解析
python main.py path/to/file.sn

# コードを直接解析
python main.py --code "x : 5"
```

### サンプルファイルの一括変換

`test_samples/` フォルダ内のSign言語ファイル（.sn）を一括してJSON形式のASTに変換：

```bash
cd proto\a5
python convert_samples.py
```

これにより、各.snファイルに対応する以下のファイルが生成されます：

```
test_samples/
  ├── 01_basic_assignment.sn   → .json, .sexp, .lisp
  ├── 02_lambda.sn              → .json, .sexp, .lisp
  ...
```

**出力形式:**
- `.json`: 抽象構文木（AST）の詳細な構造
- `.sexp`: Sign言語の構造を反映したS式（前置記法）
- `.lisp`: Common Lispで実行可能なコード（ポイントフリー記法などを展開済み）

**サンプルファイルの内容:**
- `01_basic_assignment.sn` - 基本的な代入式
- `02_lambda.sn` - ラムダ式の定義
- `03_lists.sn` - リスト（積）の例
- `04_arithmetic.sn` - 算術演算の例
- `05_pointfree.sn` - ポイントフリー記法の各パターン
- `06_complex.sn` - 複合的な例

### Pythonコード内で使用

```python
from lexer import Lexer
from parser import Parser

# Sign言語コードを解析
code = "x : 42"
lexer = Lexer(code)
tokens = lexer.tokenize()

parser = Parser(tokens)
ast = parser.parse()

# ASTをJSON形式で取得
import json
print(json.dumps(ast.to_dict(), indent=2))
```

## 実装例

### 基本的な代入
```python
# 入力: x : 5
# 出力AST:
{
  "type": "program",
  "statements": [{
    "type": "binary_op",
    "operator": ":",
    "left": {"type": "identifier", "name": "x"},
    "right": {"type": "literal", "literal_type": "integer", "value": "5"}
  }]
}
```

### ラムダ式
```python
# 入力: x y ? x + y
# 出力AST:
{
  "type": "program",
  "statements": [{
    "type": "lambda",
    "params": [
      {"type": "identifier", "name": "x"},
      {"type": "identifier", "name": "y"}
    ],
    "body": {
      "type": "binary_op",
      "operator": "+",
      "left": {"type": "identifier", "name": "x"},
      "right": {"type": "identifier", "name": "y"}
    }
  }]
}
```

### リスト（積）
```python
# 入力: [1, 2, 3]
# ブロック内に積を含むASTが生成されます
```

## 言語仕様

Sign言語の詳細な仕様は `documents/ja-jp/specification/` を参照してください。

### 三段階判定の原則

1. **第一段階**: `` ` `` で囲まれた文字列リテラルを識別
2. **第二段階**: `\` の直後の文字リテラルを識別
3. **第三段階**: リテラル（数値・識別子）vs 演算子を判定

### 演算子優先順位

PEG文法に基づき、優先順位1（export）から優先順位16（ブロック・基本要素）まで実装しています。

詳細は `documents/ja-jp/specification/A_Operator_Table.md` を参照してください。

## テスト

### テストスクリプトの実行

2種類のテストスクリプトを用意しています：

#### 1. 簡易テスト（推奨）

```bash
cd proto\a5
python test_simple.py
```

18個の主要機能をテスト：
- 基本リテラル（整数、浮動小数、文字列、識別子）
- 代入式
- ラムダ式
- リスト（積）
- 算術演算
- **ポイントフリー記法**（DirectFold、部分適用、map用）

#### 2. 包括的テスト

```bash
cd proto\a5
python test_comprehensive.py
```

43個の詳細なテストケースを実行。

### 手動テスト

```bash
# 基本構文
python main.py --code "x : 5"
python main.py --code "x y ? x + y"
python main.py --code "[1, 2, 3]"

# ポイントフリー記法
python main.py --code "[+]"           # DirectFold（畳み込み）
python main.py --code "[+ 1]"         # 右部分適用
python main.py --code "[5 -]"         # 左部分適用
python main.py --code "[* 2,]"        # map用（カンマ付き）

# サンプルファイルで検証（実装例は documents/ja-jp/example.ja-jp.sn にあります）
```

## サポートされている構文

### 基本構文
- ✅ リテラル（整数、浮動小数、16進数、8進数、2進数、文字列、文字、Unit）
- ✅ 識別子
- ✅ 代入式（`:`）
- ✅ ラムダ式（`?`）
- ✅ リスト（積 `,`）
- ✅ 範囲（`~`）

### 演算子
- ✅ 算術演算（`+`, `-`, `*`, `/`, `%`, `^`）
- ✅ 比較演算（`<`, `<=`, `=`, `>=`, `>`, `!=`）
- ✅ 論理演算（`&`, `|`, `;`、`!`）
- ✅ Get演算（`'`, `@`）

### ポイントフリー記法（関数型プログラミング）

Sign言語の強力な機能の一つです：

- **DirectFold** `[+]` - 演算子のみ → リストの畳み込み
  ```
  [+] 1 2 3 4  # 1 + 2 + 3 + 4 = 10
  ```

- **右部分適用** `[+ 1]` - 演算子 + 値 → 右側固定の関数
  ```
  [+ 1] 5  # 5 + 1 = 6
  ```

- **左部分適用** `[5 -]` - 値 + 演算子 → 左側固定の関数
  ```
  [5 -] 3  # 5 - 3 = 2
  ```

- **map用** `[* 2,]` - カンマ付き → リストのmap関数
  ```
  [* 2,] 1 2 3 4  # 2, 4, 6, 8
  ```

## 制限事項

- インデントブロック（タブによるブロック構造）は現在部分的な実装
- エラーメッセージの改善が必要
- 一部の複雑な構文（ポイントレス記法の完全サポートなど）は今後の実装

## 開発者向け

### ASTノードの種類

- `Literal`: リテラル（数値、文字列、文字、Unit）
- `Identifier`: 識別子
- `BinaryOp`: 二項演算
- `UnaryOp`: 単項演算（前置・後置）
- `Lambda`: ラムダ式
- `Block`: ブロック
- `ListNode`: リスト
- `Product`: 積（`,` 演算子）
- `Range`: 範囲（`~` 演算子）
- `Program`: プログラム全体

## ライセンス

Sign言語プロジェクトのライセンスに従います。
