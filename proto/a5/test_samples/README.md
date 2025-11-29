# Sign言語構文解析器 テストサンプル

このディレクトリには、Sign言語の構文解析器をテストするためのサンプルファイルが含まれています。

## ファイル一覧

### 入力ファイル（.sn）

| ファイル名 | 説明 | 主な構文 |
|-----------|------|---------|
| `01_basic_assignment.sn` | 基本的な代入式 | 代入演算子`:` |
| `02_lambda.sn` | ラムダ式の定義 | ラムダ演算子`?` |
| `03_lists.sn` | リストの例 | 積演算子`,` |
| `04_arithmetic.sn` | 算術演算の例 | `+`, `-`, `*`, `/`, `^` |
| `05_pointfree.sn` | ポイントフリー記法 | `[+]`, `[+ 1]`, `[5 -]`, `[* 2,]` |
| `06_complex.sn` | 複合的な例 | ラムダ + ポイントフリー |

### 出力ファイル（.json）

各.snファイルに対応する.jsonファイルが、構文解析の結果（AST）として生成されます。

## 使い方

### 1. サンプルファイルの一括変換

```bash
# proto/a5 ディレクトリから実行
cd proto\a5
python convert_samples.py
```

このコマンドで、すべての.snファイルが構文解析され、対応する.jsonファイルが生成されます。

### 2. 個別ファイルの変換

```bash
# 特定のファイルを変換
python main.py test_samples\01_basic_assignment.sn

# 結果をファイルに保存
python main.py test_samples\01_basic_assignment.sn > test_samples\01_basic_assignment.json
```

### 3. 入力と出力の比較

`.sn`ファイル（入力）と対応する`.json`ファイル（出力）を比較することで、構文解析が正しく行われているか確認できます。

**例:**

**入力** (`05_pointfree.sn`):
```
fold_add : [+]
add_one : [+ 1]
```

**出力** (`05_pointfree.json`):
```json
{
  "type": "program",
  "statements": [
    {
      "type": "binary_op",
      "operator": ":",
      "left": {"type": "identifier", "name": "fold_add"},
      "right": {"type": "pointless_fn", "operator": "+"}
    },
    {
      "type": "binary_op",
      "operator": ":",
      "left": {"type": "identifier", "name": "add_one"},
      "right": {
        "type": "pointless_fn",
        "operator": "+",
        "operand": {"type": "literal", "literal_type": "integer", "value": "1"},
        "is_left_partial": false
      }
    }
  ]
}
```

## カスタムサンプルの追加

新しいサンプルファイルを追加するには：

1. `test_samples/` ディレクトリに新しい`.sn`ファイルを作成
2. Sign言語のコードを記述
3. `python convert_samples.py` を実行
4. 生成された`.json`ファイルで結果を確認

## ポイントフリー記法の例

`05_pointfree.sn` には以下のパターンが含まれています：

- **DirectFold**: `[+]` - 畳み込み用
- **右部分適用**: `[+ 1]` - 右側を固定
- **左部分適用**: `[5 -]` - 左側を固定
- **map用**: `[* 2,]` - リストのmap関数
- **前置演算子**: `[!]` - NOT演算子

これらはすべて `pointless_fn` ASTノードとして正しく解析されます。
