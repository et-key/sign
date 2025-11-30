# Output演算子 (#) の実装変更

## 変更内容

`ast_nodes.py` の `BinaryOp.to_clisp()` メソッドを修正し、Sign言語の `#` (output) 演算子をアドレスに応じて適切に変換するようにしました。

## 変換ルール

### 1. 標準出力への変換

以下のパターンは標準出力として `(format t "~a" ...)` に変換されます：

| Signコード | Common Lisp変換 | 説明 |
|-----------|----------------|------|
| `0x1 # str` | `(format t "~a" str)` | 0x1は標準出力アドレス |
| `_ # expr` | `(format t "~a" expr)` | 左辺がUnit |
| `expr # _` | `(format t "~a" expr)` | 右辺がUnit（従来の用法） |

**Sign言語でのprint関数の定義例：**
```sign
print : str ? 0x1 # str
```

### 2. その他のアドレスへの出力

標準出力以外のアドレスの場合は、TODOコメント付きで以下のように変換されます：

```sign
0x2000 # data
```
↓
```lisp
; TODO: Output data to address 0x2000
(setf (mem-ref 0x2000) data)
```

これは実際のメモリ操作やIOポート操作がCommon Lisp標準では直接サポートされていないため、プレースホルダーとして残しています。

## テストケース

`test_output_operator.sn` に以下のテストケースを追加しました：

1. **標準出力**: `0x1 # "Hello, World!"`
2. **print関数の定義**: `print : str ? 0x1 # str`
3. **print関数の使用**: `print "hello"`
4. **他のアドレス**: `0x2000 # "data"`（メモリ/IOポート）
5. **Unitへの出力**: `x + y # _`
6. **条件付き出力**: `(x > 40) & (0x1 # "x is large")`

## 動作確認

```powershell
# テストコードを変換
python main.py test_output_operator.sn --format clisp

# 既存のサンプルも確認
python main.py mysample.sn --format clisp
```

## 注意点

- `format t "~a"` は改行なしで出力します
- 改行が必要な場合は `format t "~a~%"` を使用するか、Sign側で `\n` を追加してください
- メモリアドレスへの実際の書き込みはCommon Lisp FFI (CFFI) などを使用する必要があります

## 今後の拡張可能性

- よく使われるアドレスパターン（例：`0x2` = stderr）の追加
- 変数名による出力先の判定（例：`stdout # expr`）
- CFFI を使った実際のメモリ操作の実装
