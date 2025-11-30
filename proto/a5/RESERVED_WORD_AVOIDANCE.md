# Common Lisp予約語の自動回避機能

## 概要

Sign言語からCommon Lispへの変換時に、識別子名がCommon Lispの予約語や組み込み関数と衝突する場合、自動的に `-sign` サフィックスを追加して回避します。

## 実装

### 対象ファイル
- `ast_nodes.py`

### 追加された機能

#### 1. 予約語リスト
```python
COMMON_LISP_RESERVED = {
    # 特殊演算子
    'quote', 'function', 'if', 'let', 'lambda', 'progn', ...
    
    # よく使われる関数
    'print', 'format', 'list', 'map', 'cons', ...
    
    # 算術関数
    'abs', 'mod', 'expt', 'sqrt', ...
    
    # 型述語
    'numberp', 'listp', 'stringp', ...
    
    # パッケージシステム
    'export', 'import', ...
}
```

#### 2. エスケープ関数
```python
def escape_identifier_for_clisp(name: str) -> str:
    """
    識別子名がCommon Lispの予約語と衝突する場合、-signサフィックスを追加
    """
    if name.lower() in COMMON_LISP_RESERVED:
        return f"{name}-sign"
    return name
```

#### 3. Identifier変換の修正
```python
class Identifier(ASTNode):
    def to_clisp(self) -> str:
        # Common Lisp予約語との衝突を回避
        return escape_identifier_for_clisp(self.name)
```

## 使用例

### Sign言語コード
```sign
` print関数の定義（予約語と衝突）
print : str ? 0x1 # str

` 使用例
print `Hello, World!`

` 他の予約語
list : 1, 2, 3
map : x ? x * 2
format : `example`

` 予約語でない名前（そのまま）
myFunc : x ? x + 1
```

### 変換後のCommon Lisp
```lisp
; print → print-sign (衝突回避)
(defun print-sign (str) (format t "~a" str))
(print-sign "Hello, World!")

; list → list-sign
(defparameter list-sign (list 1 2 3))

; map → map-sign
(defun map-sign (x) (* x 2))

; format → format-sign
(defparameter format-sign "example")

; myFunc → myFunc (衝突なし)
(defun myFunc (x) (+ x 1))
```

## 動作確認

### テストケース
`test_reserved_words.sn`:
```sign
print : str ? 0x1 # str
print `Hello, World!`
list : 1, 2, 3
map : x ? x * 2
```

### 実行結果
```bash
$ python main.py test_reserved_words.sn --format clisp | Out-File -Encoding ASCII test.lisp
$ sbcl --script test.lisp
Hello, World!
```

✓ エラーなく正常実行

## 利点

### 1. ユーザーフレンドリー
- Sign言語で自然な名前（`print`, `list` など）を使える
- 変換時に自動的に衝突を回避
- テストコード側で回避する必要がない

### 2. 一貫性
- すべての識別子で統一的なルール
- `-sign` サフィックスで明確に識別可能

### 3. 拡張性
- `COMMON_LISP_RESERVED` に追加するだけで新しい予約語に対応
- 他のLisp方言への変換時も同様の仕組みを適用可能

## 注意点

### 1. サフィックスの選択
- `-sign` を使用（ハイフンはCommon Lispの慣例）
- アンダースコア `_sign` も検討したが、Lisp文化に合わせてハイフン採用

### 2. 大文字小文字の扱い
- Common Lispは大文字小文字を区別しないため、`Print` も `print-sign` に変換

### 3. 予約語リストのカバレッジ
- 主要な特殊演算子、マクロ、関数をカバー
- 必要に応じて追加可能

## 今後の拡張

### 1. ユーザー定義の予約語回避
- 設定ファイルで追加の回避語を指定可能に

### 2. カスタマイズ可能なサフィックス
- `-sign` 以外のサフィックスを選択可能に
- プロジェクト名などを使用

### 3. より洗練された回避戦略
- 文脈に応じた回避（例：関数定義時のみ）
- 名前空間の活用

## まとめ

この機能により、Sign言語のユーザーは予約語を気にせず自然な名前を使用でき、Common Lispへの変換も自動的に安全に行われます。根本的な解決策として、テストコード側での手動回避が不要になりました。
