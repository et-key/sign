# Sign言語インタープリタ仕様：Schemeによる実装

## 1. 概要

Sign言語のインタープリタは、Schemeを基盤として実装される。Sign言語とSchemeは設計哲学において深い親和性を持ち、Schemeの既存機構を活用することで、理論的に美しく実用的な実装が実現できる。

### 1.1 設計方針

```
Sign ソースコード
    ↓
[Lexer] トークン化・ブロック構造解析
    ↓
[Parser] S式への変換
    ↓
[Scheme評価器] 実行
    ↓
結果
```

### 1.2 SchemeがSign言語に最適な理由

| Sign言語の特徴 | Schemeでの対応 |
|---------------|---------------|
| リストベースの統一データモデル | リストが第一級オブジェクト |
| 予約語なし（全て演算子） | マクロで演算子を関数として定義 |
| 末尾再帰の保証 | 仕様で保証 |
| Pull-based evaluation | Stream/SRFI-41 |
| 純粋関数志向 | 自然にサポート |
| 衛生的なマクロ | syntax-rules/syntax-case |

## 2. 評価モデル：Pull-based Evaluation

### 2.1 基本原則

Sign言語は、完全な遅延評価を必要とせず**Pull-based evaluation**である：

- 全てのリストは潜在的に無限
- 値は必要になった時点で生成される
- Generator/Iteratorパターンが基本

### 2.2 評価戦略の静的決定

評価の遅延が必要な位置は**構文から静的に決定可能**：

| 構文位置 | 評価戦略 | 理由 |
|---------|---------|------|
| `&` の右辺 | 遅延 | 短絡評価（左辺がfalseなら不要） |
| `\|` の右辺 | 遅延 | 短絡評価（左辺がtrueなら不要） |
| `:` の右辺（条件分岐内） | 遅延 | 条件成立時のみ必要 |
| `?` の右辺（ラムダ本体） | 遅延 | 適用時まで不要 |
| 相互再帰関数 | 遅延 | 無限ループ回避 |
| 末尾未決定リスト | Stream | Iterator生成 |
| それ以外 | 正格 | 常に必要 |

### 2.3 Schemeでの実装

```scheme
;; Sign言語のリストはScheme Streamとして実装
(require srfi/41)  ; Stream library

;; 無限リストの例
;; Sign: naturals : [1 ~ ]
(define naturals
  (stream-cons 1 (stream-map add1 naturals)))

;; MAP操作
;; Sign: [* 2,] naturals
(define evens
  (stream-map (lambda (x) (* x 2)) naturals))

;; FOLD操作（必要分だけ消費）
;; Sign: [+] [1 ~ 10]
(stream-fold + 0 (stream-take 10 naturals))
```

## 3. Sign構文からS式への変換規則

### 3.1 リテラル変換

| Sign | S式 | 備考 |
|------|-----|------|
| `42` | `42` | 数値はそのまま |
| `-3.14` | `-3.14` | 浮動小数点 |
| `0xAF` | `#xAF` | 16進数 |
| `0o77` | `#o77` | 8進数 |
| `0b1010` | `#b1010` | 2進数 |
| `` `文字列` `` | `"文字列"` | 文字列 |
| `\n` | `#\n` | 文字 |
| `_` | `'()` | Unit（空リスト） |

### 3.2 算術演算子

| Sign | S式 |
|------|-----|
| `x + y` | `(+ x y)` |
| `x - y` | `(- x y)` |
| `x * y` | `(* x y)` |
| `x / y` | `(/ x y)` |
| `x % y` | `(modulo x y)` |
| `x ^ y` | `(expt x y)` |
| `x!` | `(factorial x)` |
| `\|x\|` | `(abs x)` |

### 3.3 比較演算子（値返却型）

Sign言語の比較演算は、trueの場合に変数値を返す：

| Sign | S式 |
|------|-----|
| `x < y` | `(sign:< x y)` |
| `x <= y` | `(sign:<= x y)` |
| `x = y` | `(sign:= x y)` |
| `x >= y` | `(sign:>= x y)` |
| `x > y` | `(sign:> x y)` |
| `x != y` | `(sign:!= x y)` |

```scheme
;; 値返却型比較演算の実装
(define (sign:< x y)
  (if (< x y) x '()))

(define (sign:<= x y)
  (if (<= x y) x '()))

(define (sign:= x y)
  (if (equal? x y) x '()))

(define (sign:>= x y)
  (if (>= x y) x '()))

(define (sign:> x y)
  (if (> x y) x '()))

(define (sign:!= x y)
  (if (not (equal? x y)) x '()))
```

### 3.4 論理演算子（短絡評価）

| Sign | S式 |
|------|-----|
| `x & y` | `(sign:and x (delay y))` |
| `x \| y` | `(sign:or x (delay y))` |
| `x ; y` | `(sign:xor x y)` |
| `!x` | `(sign:not x)` |

```scheme
;; Unit（空リスト）がfalse、それ以外がtrue
(define (sign:truthy? x)
  (not (null? x)))

(define (sign:and x y-delayed)
  (if (sign:truthy? x)
      (force y-delayed)
      '()))

(define (sign:or x y-delayed)
  (if (sign:truthy? x)
      x
      (force y-delayed)))

(define (sign:xor x y)
  (let ((tx (sign:truthy? x))
        (ty (sign:truthy? y)))
    (if (and (or tx ty) (not (and tx ty)))
        (if tx x y)
        '())))

(define (sign:not x)
  (if (sign:truthy? x) '() #t))
```

### 3.5 関数定義（ラムダ構築）

| Sign | S式 |
|------|-----|
| `x ? x + 1` | `(lambda (x) (+ x 1))` |
| `x y ? x + y` | `(lambda (x) (lambda (y) (+ x y)))` |
| `~rest ? ...` | `(lambda rest ...)` |

```scheme
;; カリー化された関数定義マクロ
(define-syntax sign:lambda
  (syntax-rules ()
    ;; 単一引数
    ((_ (x) body)
     (lambda (x) body))
    ;; 複数引数（カリー化）
    ((_ (x y ...) body)
     (lambda (x) (sign:lambda (y ...) body)))
    ;; 残余引数
    ((_ rest body)
     (lambda rest body))))
```

### 3.6 条件分岐（match_case）

```sign
classify : x ?
    x < 0 : `negative`
    x = 0 : `zero`
    x > 0 : `positive`
```

↓ 変換

```scheme
(define classify
  (lambda (x)
    (cond
      ((sign:truthy? (sign:< x 0)) "negative")
      ((sign:truthy? (sign:= x 0)) "zero")
      ((sign:truthy? (sign:> x 0)) "positive"))))
```

### 3.7 定義演算子

| Sign | S式 |
|------|-----|
| `x : 42` | `(define x 42)` |
| `f : x ? x + 1` | `(define f (lambda (x) (+ x 1)))` |
| `#x : 42` | `(sign:export x 42)` |

### 3.8 リスト操作

| Sign | S式 | 説明 |
|------|-----|------|
| `1, 2, 3` | `(stream 1 2 3)` | リスト構築 |
| `[1 ~ 5]` | `(sign:range 1 5)` | 範囲リスト |
| `[1 ~ ]` | `(sign:range-infinite 1)` | 無限リスト |
| `list1 list2` | `(stream-append list1 list2)` | リスト結合 |
| `[* 2,] list` | `(stream-map (lambda (x) (* x 2)) list)` | MAP |
| `[+] list` | `(stream-fold + 0 list)` | FOLD |
| `list ' 0` | `(stream-ref list 0)` | インデックスアクセス |
| `list~` | `(stream->list list)` | 展開 |

```scheme
;; 範囲リスト生成
(define (sign:range start end)
  (stream-take (- end start -1)
               (sign:range-infinite start)))

(define (sign:range-infinite start)
  (stream-cons start (sign:range-infinite (+ start 1))))
```

### 3.9 Get演算子

| Sign | S式 |
|------|-----|
| `obj ' key` | `(sign:get obj 'key)` |
| `obj ' 0` | `(sign:get obj 0)` |
| `key @ obj` | `(sign:get obj 'key)` |

```scheme
;; 汎用Get演算子
(define (sign:get obj key)
  (cond
    ;; リスト/Streamの場合、インデックスアクセス
    ((and (integer? key) (stream? obj))
     (stream-ref obj key))
    ;; 連想リストの場合、キーアクセス
    ((and (symbol? key) (list? obj))
     (let ((pair (assoc key obj)))
       (if pair (cdr pair) '())))
    (else '())))
```

## 4. ランタイムライブラリ

### 4.1 基本関数

```scheme
;;; sign-runtime.scm - Sign言語ランタイムライブラリ

(require srfi/41)  ; Streams

;; Unit判定
(define (sign:unit? x)
  (null? x))

;; 真偽判定（Unitと未評価ラムダがfalse）
(define (sign:truthy? x)
  (and (not (null? x))
       (not (procedure? x))))  ; 未適用の関数はfalse

;; 階乗
(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

;; 関数合成
(define (sign:compose f g)
  (lambda (x) (f (g x))))
```

### 4.2 リスト操作ライブラリ

```scheme
;;; sign-list.scm - Sign言語リスト操作

;; MAP操作（部分適用対応）
(define (sign:map f)
  (lambda (stream)
    (stream-map f stream)))

;; FOLD操作（部分適用対応）
(define (sign:fold f)
  (lambda (stream)
    (stream-fold f (stream-car stream) (stream-cdr stream))))

;; FILTER操作
(define (sign:filter pred)
  (lambda (stream)
    (stream-filter pred stream)))

;; リスト反転
(define (sign:reverse stream)
  (stream-reverse stream))

;; 先頭要素取得
(define (sign:head stream)
  (if (stream-null? stream)
      '()
      (stream-car stream)))

;; 残り要素取得
(define (sign:tail stream)
  (if (stream-null? stream)
      '()
      (stream-cdr stream)))
```

### 4.3 ポイントフリー記法サポート

```scheme
;;; sign-pointfree.scm - ポイントフリー記法

;; 演算子の関数化
(define sign:+ +)
(define sign:- -)
(define sign:* *)
(define sign:/ /)

;; 部分適用（右オペランド固定）
(define (sign:partial-right op val)
  (lambda (x) (op x val)))

;; 部分適用（左オペランド固定）
(define (sign:partial-left op val)
  (lambda (x) (op val x)))

;; 例: [+ 1] → (sign:partial-right + 1)
;; 例: [1 -] → (sign:partial-left - 1)
```

## 5. 変換パイプライン

### 5.1 全体構造

```scheme
;;; sign-interpreter.scm - Sign言語インタープリタ

(define (sign:interpret source)
  (let* ((tokens (sign:lex source))           ; 字句解析
         (sexp (sign:parse tokens))           ; S式変換
         (expanded (sign:expand sexp)))       ; マクロ展開
    (eval expanded (sign:make-environment)))) ; 評価

;; Sign言語用環境構築
(define (sign:make-environment)
  (let ((env (make-base-namespace)))
    ;; ランタイムライブラリをロード
    (namespace-require 'sign-runtime env)
    (namespace-require 'sign-list env)
    (namespace-require 'sign-pointfree env)
    env))
```

### 5.2 字句解析器（Lexer）

```scheme
;;; sign-lexer.scm - Sign言語字句解析

;; トークン型
(struct token (type value line column) #:transparent)

;; 字句解析メイン
(define (sign:lex source)
  (let ((protected (sign:protect-literals source)))
    (sign:tokenize protected)))

;; 第一・第二段階：文字列・文字の保護
(define (sign:protect-literals source)
  (let* ((s1 (sign:protect-strings source))
         (s2 (sign:protect-chars s1)))
    s2))

;; 文字列保護
(define (sign:protect-strings source)
  ;; `...` → プレースホルダー
  ...)

;; 文字保護
(define (sign:protect-chars source)
  ;; \x → プレースホルダー
  ...)

;; トークン化
(define (sign:tokenize source)
  ;; 空白で分割、演算子識別
  ...)
```

### 5.3 構文解析器（Parser）

```scheme
;;; sign-parser.scm - Sign言語構文解析

;; トークン列からS式へ変換
(define (sign:parse tokens)
  (let* ((blocked (sign:parse-blocks tokens))      ; ブロック構造解析
         (infixed (sign:parse-infix blocked)))     ; 中置記法変換
    infixed))

;; ブロック構造解析
(define (sign:parse-blocks tokens)
  ;; インデントブロック → リスト構造
  ...)

;; 中置記法からS式への変換
(define (sign:parse-infix tokens)
  ;; 優先順位に従ってS式構築
  ;; Shunting-yard algorithm適用
  ...)
```

### 5.4 マクロ展開

```scheme
;;; sign-expander.scm - Sign言語マクロ展開

;; Sign構文をScheme構文に変換
(define (sign:expand sexp)
  (match sexp
    ;; 定義
    [`(sign:define ,name ,value)
     `(define ,name ,(sign:expand value))]
    
    ;; ラムダ
    [`(sign:lambda ,params ,body)
     (sign:expand-lambda params body)]
    
    ;; 条件分岐
    [`(sign:match ,expr ,@clauses)
     (sign:expand-match expr clauses)]
    
    ;; 論理演算（遅延挿入）
    [`(sign:and ,x ,y)
     `(sign:and ,(sign:expand x) (delay ,(sign:expand y)))]
    
    [`(sign:or ,x ,y)
     `(sign:or ,(sign:expand x) (delay ,(sign:expand y)))]
    
    ;; リスト（Stream変換）
    [`(sign:list ,@elements)
     `(stream ,@(map sign:expand elements))]
    
    ;; その他は再帰的に展開
    [(list op args ...)
     (cons op (map sign:expand args))]
    
    [else sexp]))
```

## 6. REPL実装

```scheme
;;; sign-repl.scm - Sign言語REPL

(define (sign:repl)
  (display "Sign Language Interpreter\n")
  (display "Type :quit to exit\n\n")
  (sign:repl-loop (sign:make-environment)))

(define (sign:repl-loop env)
  (display "sign> ")
  (flush-output)
  (let ((input (read-line)))
    (cond
      ((eof-object? input)
       (display "\nGoodbye!\n"))
      ((equal? input ":quit")
       (display "Goodbye!\n"))
      (else
       (with-handlers
         ([exn:fail? (lambda (e)
                       (display "Error: ")
                       (display (exn-message e))
                       (newline))])
         (let ((result (sign:interpret input)))
           (display "=> ")
           (sign:print result)
           (newline)))
       (sign:repl-loop env)))))

;; Sign形式での結果表示
(define (sign:print value)
  (cond
    ((null? value) (display "_"))
    ((stream? value) (sign:print-stream value))
    ((string? value) (printf "`~a`" value))
    ((char? value) (printf "\\~a" value))
    (else (display value))))

(define (sign:print-stream s)
  (display "(")
  (let loop ((s s) (first #t))
    (cond
      ((stream-null? s) (display ")"))
      (else
       (unless first (display " "))
       (sign:print (stream-car s))
       (loop (stream-cdr s) #f)))))
```

## 7. 実装ロードマップ

### Phase 1: 最小実装
- [ ] リテラル変換（数値、文字列、文字、Unit）
- [ ] 基本算術演算子
- [ ] 比較演算子（値返却型）
- [ ] 論理演算子（短絡評価）
- [ ] 単純なラムダ定義
- [ ] 定義演算子
- [ ] REPL

### Phase 2: リスト操作
- [ ] 有限リスト構築
- [ ] Stream基盤の無限リスト
- [ ] 範囲リスト
- [ ] MAP/FOLD操作
- [ ] ポイントフリー記法

### Phase 3: 高度な機能
- [ ] 条件分岐（match_case）
- [ ] 辞書型
- [ ] Get演算子
- [ ] 連続引数（~前置）
- [ ] 展開演算子（~後置）

### Phase 4: モジュールシステム
- [ ] Export演算子
- [ ] Import演算子
- [ ] ファイル単位スコープ

### Phase 5: 最適化
- [ ] 末尾再帰最適化の活用
- [ ] Stream融合（stream fusion）
- [ ] 定数畳み込み

## 8. テスト仕様

### 8.1 基本テスト

```scheme
;; test-basic.scm

(check-equal? (sign:interpret "42") 42)
(check-equal? (sign:interpret "_") '())
(check-equal? (sign:interpret "1 + 2") 3)
(check-equal? (sign:interpret "3 * 4 + 2") 14)
(check-equal? (sign:interpret "2 ^ 10") 1024)
(check-equal? (sign:interpret "5!") 120)
(check-equal? (sign:interpret "|−5|") 5)
```

### 8.2 比較・論理テスト

```scheme
;; test-logic.scm

(check-equal? (sign:interpret "3 < 5") 3)
(check-equal? (sign:interpret "5 < 3") '())
(check-equal? (sign:interpret "_ & 1") '())
(check-equal? (sign:interpret "1 & 2") 2)
(check-equal? (sign:interpret "_ | 1") 1)
(check-equal? (sign:interpret "1 | 2") 1)
(check-equal? (sign:interpret "!_") #t)
(check-equal? (sign:interpret "!1") '())
```

### 8.3 関数テスト

```scheme
;; test-function.scm

(check-equal? 
  (sign:interpret "f : x ? x + 1\nf 5") 
  6)

(check-equal? 
  (sign:interpret "add : x y ? x + y\nadd 3 5") 
  8)

(check-equal? 
  (sign:interpret "[+ 1] 5") 
  6)

(check-equal? 
  (sign:interpret "[+] 1 2 3 4 5") 
  15)
```

### 8.4 リストテスト

```scheme
;; test-list.scm

(check-equal? 
  (sign:interpret "[+] [1 ~ 10]") 
  55)

(check-equal? 
  (stream->list (sign:interpret "[* 2,] [1 ~ 5]"))
  '(2 4 6 8 10))

(check-equal?
  (stream-ref (sign:interpret "[1 ~ ]") 99)
  100)
```

## 9. まとめ

### 9.1 設計の要点

1. **Schemeを基盤とした実装**
   - Streamライブラリを活用したPull-based evaluation
   - 衛生的マクロによる安全な構文拡張
   - 末尾再帰最適化の恩恵

2. **構文からの評価戦略決定**
   - 遅延が必要な位置は静的に決定可能
   - コンパイラが自動で`delay`を挿入
   - プログラマは評価戦略を意識しない

3. **Generator/Iteratorモデル**
   - 全てのリストは潜在的に無限
   - 値は必要時に生成
   - データフローモデルとの整合

### 9.2 期待される効果

- **理論的美しさ**: Sign言語の設計思想がSchemeで自然に表現される
- **実装効率**: 既存のScheme処理系を活用
- **デバッグ容易性**: S式への変換結果を直接確認可能
- **拡張性**: マクロによる機能追加が容易

### 9.3 次のステップ

1. Racket/Guileなど具体的なScheme処理系の選定
2. Phase 1の最小実装
3. テストスイートの整備
4. REPLによる対話的検証
