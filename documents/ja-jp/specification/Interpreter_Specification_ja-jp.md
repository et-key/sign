# Sign言語インタープリタ仕様：Racket `#lang` による実装

## 1. 概要

Sign言語のインタープリタは、Racketの`#lang`機能を基盤として実装される。これにより、Sign言語の構文をそのまま記述でき、Racketの強力なエコシステムを活用した実用的な実装が実現できる。

### 1.1 設計方針

```
#lang sign
    ↓
[Reader] Sign構文 → S式変換（中置→前置）
    ↓
[Expander] マクロ展開・構文変換
    ↓
[Racket評価器] 実行
    ↓
結果
```

### 1.2 `#lang`機能を採用する理由

| 課題 | `#lang`による解決 |
|------|------------------|
| 中置記法の読み取り | Reader段階で前置記法に変換 |
| Sign独自構文 | 完全にカスタム構文を定義可能 |
| エラーメッセージ | Sign言語の文脈でエラー表示 |
| IDE連携 | DrRacketとの統合 |
| 段階的開発 | Racketへのフォールバック可能 |

### 1.3 Racket/SchemeがSign言語に最適な理由

| Sign言語の特徴 | Racketでの対応 |
|---------------|---------------|
| リストベースの統一データモデル | リストが第一級オブジェクト |
| 予約語なし（全て演算子） | Reader + マクロで完全対応 |
| 末尾再帰の保証 | 仕様で保証 |
| Pull-based evaluation | Stream/SRFI-41 |
| 純粋関数志向 | 自然にサポート |
| 中置記法 | `#lang`のReader拡張で対応 |

## 2. プロジェクト構造

### 2.1 ディレクトリ構成

```
sign-lang/
├── info.rkt                 ;; パッケージ情報
├── main.rkt                 ;; #lang sign のエントリポイント
├── reader.rkt               ;; Sign構文 → S式変換（中置→前置）
├── parser.rkt               ;; 詳細なパース処理
├── expander.rkt             ;; Sign構文のマクロ展開
├── runtime.rkt              ;; ランタイムライブラリ
├── operators.rkt            ;; 演算子定義と優先順位
├── stream.rkt               ;; Stream/Generator実装
└── tests/
    ├── test-basic.rkt
    ├── test-operators.rkt
    ├── test-functions.rkt
    └── test-streams.rkt
```

### 2.2 使用イメージ

```scheme
#lang sign

` これがSign言語のコード
add : x y ? x + y
result : add 3 5

numbers : [1 ~ 10]
doubled : [* 2,] numbers
sum : [+] doubled
```

## 3. `#lang` 実装の詳細

### 3.1 info.rkt（パッケージ定義）

```scheme
#lang info

(define collection "sign")
(define deps '("base" "srfi-lite-lib"))
(define build-deps '("rackunit-lib"))
```

### 3.2 main.rkt（言語エントリポイント）

```scheme
#lang racket/base

(require "reader.rkt"
         "expander.rkt"
         "runtime.rkt")

;; #lang sign で使用される
(provide (rename-out [sign-read read]
                     [sign-read-syntax read-syntax])
         (except-out (all-from-out "runtime.rkt")))
```

### 3.3 reader.rkt（Sign構文リーダー）

```scheme
#lang racket/base

(require racket/port
         racket/string
         racket/list)

(provide sign-read
         sign-read-syntax)

;; 演算子優先順位テーブル
(define operator-precedence
  (hash
   ":"  2   ; define
   "#"  3   ; output
   ","  4   ; product
   "?"  7   ; lambda
   "~"  8   ; range
   "|"  10  ; or
   ";"  10  ; xor
   "&"  11  ; and
   "<"  13  "<=" 13  "="  13  ">=" 13  ">"  13  "!=" 13
   "+"  14  "-"  14
   "*"  15  "/"  15  "%"  15
   "^"  16
   "'"  21  "@"  21))

;; 右結合演算子
(define right-associative
  (set ":" "?" "^" ","))

;; Sign構文を読み取りS式に変換
(define (sign-read in)
  (define source (port->string in))
  (define lines (sign-tokenize source))
  (define sexp (sign-parse lines))
  sexp)

;; ソース位置情報付きで読み取り
(define (sign-read-syntax src in)
  (define sexp (sign-read in))
  (datum->syntax #f sexp (list src 1 0 1 0)))

;; ========================================
;; トークン化
;; ========================================

;; 第一段階：文字列保護
(define (protect-strings source)
  (define strings '())
  (define result
    (regexp-replace* #px"`[^`\n\r]*`"
                     source
                     (λ (match)
                       (set! strings (append strings (list match)))
                       (format "__STRING_~a__" (sub1 (length strings))))))
  (values result strings))

;; 第二段階：文字保護
(define (protect-chars source)
  (define chars '())
  (define result
    (regexp-replace* #px"\\\\."
                     source
                     (λ (match)
                       (set! chars (append chars (list match)))
                       (format "__CHAR_~a__" (sub1 (length chars))))))
  (values result chars))

;; 第三段階：トークン化
(define (sign-tokenize source)
  (define-values (s1 strings) (protect-strings source))
  (define-values (s2 chars) (protect-chars s1))
  ;; コメント除去
  (define s3 (regexp-replace* #px"^`[^\n\r]*" s2 ""))
  ;; 行分割とトークン化
  (define lines (string-split s3 #px"[\r\n]+"))
  (for/list ([line lines]
             #:when (not (string=? (string-trim line) "")))
    (tokenize-line line strings chars)))

(define (tokenize-line line strings chars)
  (define trimmed (string-trim line))
  ;; インデント検出
  (define indent (string-length (car (regexp-match #px"^[\t]*" line))))
  ;; トークン分割（演算子と識別子を分離）
  (define tokens (tokenize-expression trimmed))
  (list indent (restore-literals tokens strings chars)))

;; 式のトークン化（演算子認識）
(define (tokenize-expression expr)
  (define pattern
    #px"(<=|>=|!=|<<|>>|\\|\\||;;|&&|!!|[+\\-*/^%<>=|&;:?~'@#!,(){}\\[\\]]|[a-zA-Z_][a-zA-Z0-9_]*|[0-9]+\\.?[0-9]*|0x[0-9A-Fa-f]+|0o[0-7]+|0b[01]+|__STRING_[0-9]+__|__CHAR_[0-9]+__)")
  (regexp-match* pattern expr))

;; リテラル復元
(define (restore-literals tokens strings chars)
  (for/list ([token tokens])
    (cond
      [(regexp-match #px"__STRING_([0-9]+)__" token)
       => (λ (m) (list-ref strings (string->number (cadr m))))]
      [(regexp-match #px"__CHAR_([0-9]+)__" token)
       => (λ (m) (list-ref chars (string->number (cadr m))))]
      [else token])))

;; ========================================
;; パース（中置→前置変換）
;; ========================================

;; Shunting-yard algorithm による中置→前置変換
(define (sign-parse tokenized-lines)
  (define result '())
  (for ([line tokenized-lines])
    (match-define (list indent tokens) line)
    (define parsed (parse-expression tokens))
    (set! result (append result (list parsed))))
  (if (= (length result) 1)
      (car result)
      (cons 'begin result)))

;; 式のパース
(define (parse-expression tokens)
  (if (null? tokens)
      '()
      (infix->prefix tokens)))

;; 中置記法から前置記法への変換
(define (infix->prefix tokens)
  (define output '())
  (define operators '())
  
  (define (precedence op)
    (hash-ref operator-precedence op 0))
  
  (define (right-assoc? op)
    (set-member? right-associative op))
  
  (define (operator? token)
    (hash-has-key? operator-precedence token))
  
  (define (push-operator! op)
    (set! operators (cons op operators)))
  
  (define (pop-operator!)
    (define op (car operators))
    (set! operators (cdr operators))
    op)
  
  (define (push-output! val)
    (set! output (cons val output)))
  
  (define (apply-operator! op)
    (cond
      [(< (length output) 2)
       ;; 単項演算子として処理
       (define arg (car output))
       (set! output (cdr output))
       (push-output! (list (string->symbol op) arg))]
      [else
       ;; 二項演算子
       (define right (car output))
       (define left (cadr output))
       (set! output (cddr output))
       (push-output! (list (string->symbol op) left right))]))
  
  (for ([token tokens])
    (cond
      ;; 演算子
      [(operator? token)
       (let loop ()
         (when (and (pair? operators)
                    (operator? (car operators))
                    (or (> (precedence (car operators)) (precedence token))
                        (and (= (precedence (car operators)) (precedence token))
                             (not (right-assoc? token)))))
           (apply-operator! (pop-operator!))
           (loop)))
       (push-operator! token)]
      ;; 開きカッコ
      [(member token '("(" "[" "{"))
       (push-operator! token)]
      ;; 閉じカッコ
      [(member token '(")" "]" "}"))
       (let loop ()
         (when (and (pair? operators)
                    (not (member (car operators) '("(" "[" "{"))))
           (apply-operator! (pop-operator!))
           (loop)))
       (when (pair? operators)
         (pop-operator!))]  ; 開きカッコを捨てる
      ;; 数値
      [(regexp-match? #px"^-?[0-9]" token)
       (push-output! (string->number token))]
      ;; 16進数
      [(regexp-match? #px"^0x" token)
       (push-output! (string->number token 16))]
      ;; 識別子
      [else
       (push-output! (string->symbol token))]))
  
  ;; 残りの演算子を適用
  (for ([op (in-list operators)])
    (unless (member op '("(" "[" "{"))
      (apply-operator! op)))
  
  (if (= (length output) 1)
      (car output)
      output))
```

### 3.4 expander.rkt（マクロ展開）

```scheme
#lang racket/base

(require (for-syntax racket/base
                     syntax/parse))

(provide sign-define
         sign-lambda
         sign-if
         sign-and
         sign-or
         sign-compare)

;; Sign定義 → Racket定義
(define-syntax (sign-define stx)
  (syntax-parse stx
    [(_ name:id value)
     #'(define name value)]))

;; Signラムダ → Racketラムダ（カリー化）
(define-syntax (sign-lambda stx)
  (syntax-parse stx
    [(_ (param:id) body)
     #'(λ (param) body)]
    [(_ (param:id params:id ...) body)
     #'(λ (param) (sign-lambda (params ...) body))]))

;; Sign条件分岐
(define-syntax (sign-if stx)
  (syntax-parse stx
    [(_ condition then-expr else-expr)
     #'(if (sign-truthy? condition) then-expr else-expr)]))

;; Sign論理積（遅延評価）
(define-syntax (sign-and stx)
  (syntax-parse stx
    [(_ left right)
     #'(let ([l left])
         (if (sign-truthy? l)
             right
             '()))]))

;; Sign論理和（遅延評価）
(define-syntax (sign-or stx)
  (syntax-parse stx
    [(_ left right)
     #'(let ([l left])
         (if (sign-truthy? l)
             l
             right))]))

;; Sign比較演算（値返却型）
(define-syntax (sign-compare stx)
  (syntax-parse stx
    [(_ op left right)
     #'(if (op left right) left '())]))
```

## 4. 評価モデル：Pull-based Evaluation

### 2.1 基本原則

Sign言語の「遅延評価」は、完全な遅延評価ではなく**Pull-based evaluation**である：

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

## 7. 変換パイプライン

### 7.1 全体構造（#lang版）

```scheme
;;; sign-lang/main.rkt

#lang racket/base

(require "reader.rkt"
         "expander.rkt"
         "runtime.rkt")

;; #lang sign で使用されるエクスポート
(provide (rename-out [sign-read read]
                     [sign-read-syntax read-syntax])
         ;; ランタイム関数をすべてエクスポート
         (all-from-out "runtime.rkt"))

;; モジュール開始時の処理
(module reader syntax/module-reader
  #:language 'sign
  #:read sign-read
  #:read-syntax sign-read-syntax)
```

### 7.2 Reader処理フロー

```
Sign ソースコード
    ↓
[1] 文字列・文字保護（第一・第二段階）
    ↓
[2] コメント除去
    ↓
[3] 行分割・インデント検出
    ↓
[4] トークン化（第三段階：リテラル/演算子判定）
    ↓
[5] 中置→前置変換（Shunting-yard）
    ↓
[6] リテラル復元
    ↓
S式（Racket構文オブジェクト）
    ↓
[Racket Expander] マクロ展開
    ↓
[Racket評価器] 実行
```

### 7.3 インストールと使用方法

```bash
# パッケージインストール
cd sign-lang
raco pkg install

# 使用
#lang sign

add : x y ? x + y
result : add 3 5
```

### 7.4 DrRacket統合

`#lang sign`を使用することで、DrRacketで直接Sign言語コードを：
- シンタックスハイライト
- エラー表示（Sign言語のコンテキストで）
- デバッグ
- REPL実行

## 8. REPL実装

```scheme
;;; sign-lang/repl.rkt - Sign言語REPL

#lang racket/base

(require "reader.rkt"
         "runtime.rkt"
         racket/port)

(provide sign-repl)

(define (sign-repl)
  (displayln "Sign Language REPL (Racket #lang implementation)")
  (displayln "Type :quit to exit, :help for help\n")
  (repl-loop (make-base-namespace)))

(define (repl-loop ns)
  (display "sign> ")
  (flush-output)
  (define input (read-line))
  (cond
    [(eof-object? input)
     (displayln "\nGoodbye!")]
    [(equal? input ":quit")
     (displayln "Goodbye!")]
    [(equal? input ":help")
     (display-help)
     (repl-loop ns)]
    [else
     (with-handlers
       ([exn:fail? (λ (e)
                     (displayln (format "Error: ~a" (exn-message e))))])
       (define sexp (sign-read (open-input-string input)))
       (define result (eval sexp ns))
       (display "=> ")
       (sign-print result)
       (newline))
     (repl-loop ns)]))

(define (display-help)
  (displayln "
Sign Language REPL Commands:
  :quit    Exit the REPL
  :help    Show this help

Sign Language Examples:
  x : 42              Define x as 42
  add : x y ? x + y   Define a function
  add 3 5             Apply function (returns 8)
  [* 2,] [1 ~ 5]      Map: double each element
  [+] [1 ~ 10]        Fold: sum of 1 to 10
"))

;; Sign形式での結果表示
(define (sign-print value)
  (cond
    [(null? value) (display "_")]
    [(stream? value) (sign-print-stream value)]
    [(string? value) (printf "`~a`" value)]
    [(char? value) (printf "\\~a" value)]
    [(procedure? value) (display "[function]")]
    [else (display value)]))

(define (sign-print-stream s)
  (display "[")
  (let loop ([s s] [first #t] [count 0])
    (cond
      [(stream-null? s) (display "]")]
      [(> count 10)
       (display " ...]")]  ; 無限ストリーム対策
      [else
       (unless first (display " "))
       (sign-print (stream-first s))
       (loop (stream-rest s) #f (add1 count))])))

;; ストリーム判定（SRFI-41互換）
(define (stream? v)
  (or (stream-null? v)
      (stream-pair? v)))

(define stream-null? null?)
(define stream-pair? pair?)
(define stream-first car)
(define stream-rest cdr)
```

### 8.1 REPLの起動方法

```bash
# 方法1: racketコマンドから
racket -e "(require sign-lang/repl) (sign-repl)"

# 方法2: DrRacketのInteractionsペインで
> (require sign-lang/repl)
> (sign-repl)
```

## 9. 実装ロードマップ

### Phase 1: 最小限の`#lang`実装
- [ ] プロジェクト構造の作成
- [ ] info.rkt / main.rkt の設定
- [ ] 基本Reader（文字列・文字保護、トークン化）
- [ ] 中置→前置変換（算術演算のみ）
- [ ] 基本ランタイム（算術、比較）
- [ ] 簡易REPL

### Phase 2: 関数定義と適用
- [ ] ラムダ構築子（?演算子）
- [ ] カリー化対応
- [ ] 定義演算子（:）
- [ ] 関数適用（余積）
- [ ] ポイントフリー記法

### Phase 3: リスト操作とStream
- [ ] 有限リスト構築
- [ ] Stream基盤の無限リスト
- [ ] 範囲リスト（~演算子）
- [ ] MAP/FOLD操作
- [ ] 展開演算子（~後置）

### Phase 4: 制御構造
- [ ] 論理演算子（短絡評価）
- [ ] 条件分岐（match_case）
- [ ] ブロック構文（インデント）
- [ ] 連続引数（~前置）

### Phase 5: モジュールシステム
- [ ] Export演算子
- [ ] Import演算子
- [ ] ファイル単位スコープ

### Phase 6: 開発環境統合
- [ ] DrRacketシンタックスハイライト
- [ ] エラーメッセージのSign言語化
- [ ] デバッグサポート
- [ ] ドキュメント生成

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

## 11. まとめ

### 11.1 設計の要点

1. **Racket `#lang`機能による実装**
   - Reader段階で中置→前置変換
   - Sign言語の構文をそのまま記述可能
   - DrRacket統合による開発環境

2. **構文からの評価戦略決定**
   - 遅延が必要な位置は静的に決定可能
   - マクロが自動で遅延を挿入
   - プログラマは評価戦略を意識しない

3. **Generator/Iteratorモデル**
   - 全てのリストは潜在的に無限
   - 値は必要時に生成（Pull-based）
   - データフローモデルとの整合

### 11.2 `#lang`採用の効果

| 観点 | 効果 |
|------|------|
| 構文の自由度 | Sign言語の中置記法をそのまま記述 |
| 開発効率 | DrRacketとの完全統合 |
| エラー処理 | Sign言語コンテキストでのエラー表示 |
| 拡張性 | Racketエコシステムの活用 |
| 保守性 | 各コンポーネントの明確な分離 |

### 11.3 次のステップ

1. Phase 1の最小実装を開始
2. 基本的な算術演算と関数定義の動作確認
3. 段階的に機能を追加
4. テストスイートの整備

### 11.4 参考リソース

- [Racket `#lang` ドキュメント](https://docs.racket-lang.org/guide/languages.html)
- [Beautiful Racket](https://beautifulracket.com/) - `#lang`実装チュートリアル
- [Racket Reader拡張](https://docs.racket-lang.org/reference/reader.html)