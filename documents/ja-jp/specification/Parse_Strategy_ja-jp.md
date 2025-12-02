# Sign言語構文解析戦略 v2

## 1. 基本原則

### 1.1 三段階処理モデル

```
Sign ソースコード
    ↓
[字句解析] 空白で区切り → トークン列
    ↓
[構文解析] 演算子の優先順位で構造化 → AST
    ↓
[意味解析] 型推論 → 空白の意味決定 → 意味付きAST
    ↓
[コード生成/評価]
```

### 1.2 核心的な洞察

| 段階 | 空白の扱い |
|------|-----------|
| 字句解析 | トークンの区切り |
| 構文解析 | 隣接関係として保持 |
| 意味解析 | 型の組み合わせから意味を決定 |

**これが「構文＝型」「見えない強い型付け」の正体である。**

## 2. 字句解析（Lexer）

### 2.1 三段階判定

Sign言語のトークン判定は以下の順序で行われる：

| 段階 | 判定 | 処理 |
|------|------|------|
| 第一 | 文字列か？ | `` ` `` で囲まれた部分を保護 |
| 第二 | 文字か？ | `\` の直後1文字を保護 |
| 第三 | 記号かリテラルか？ | 残りを演算子またはリテラルに分類 |

### 2.2 演算子の位置判定

空白の位置により、同じ記号でも異なるトークン種別となる：

```
!x      → [NOT, x]           ` 記号の右にリテラル → 前置
x!      → [x, FACTORIAL]     ` 記号の左にリテラル → 後置
x ! y   → [x, NOT, y]        ` 両側に空白 → 前置として次に適用

@data   → [INPUT, data]      ` 前置
key @ obj → [key, GET, obj]  ` 中置
file@   → [file, IMPORT]     ` 後置
```

### 2.3 トークン種別

```
TOKEN_TYPE:
  ;; リテラル
  INTEGER       : /[0-9]+/
  FLOAT         : /[0-9]+\.[0-9]+/
  HEX           : /0x[0-9A-Fa-f]+/
  OCT           : /0o[0-7]+/
  BIN           : /0b[01]+/
  STRING        : /`[^`\n\r]*`/
  CHAR          : /\\./
  IDENTIFIER    : /[A-Za-z_][A-Za-z0-9_]*/
  UNIT          : /_/
  
  ;; 演算子（位置確定済み）
  EXPORT        : /^#/           ` 行頭の#
  DEFINE        : /:/
  OUTPUT        : /#/            ` 中置位置の#
  PRODUCT       : /,/
  LAMBDA        : /\?/
  RANGE         : /~/            ` 中置位置
  CONTINUOUS    : /^~/           ` 前置位置
  EXPAND        : /~$/           ` 後置位置
  XOR           : /;/
  OR            : /\|/
  AND           : /&/
  NOT           : /^!/           ` 前置位置
  FACTORIAL     : /!$/           ` 後置位置
  LT, LE, EQ, GE, GT, NE : 比較演算子
  ADD, SUB      : /[+-]/
  MUL, DIV, MOD : /[*/%]/
  POW           : /\^/
  ADDRESS       : /\$/
  GET_LEFT      : /'/
  GET_RIGHT     : /@/            ` 中置位置
  INPUT         : /^@/           ` 前置位置
  IMPORT        : /@$/           ` 後置位置
  
  ;; ブロック
  LPAREN, RPAREN : /[([{]/, /[)\]}]/
  NEWLINE       : 改行
  INDENT        : タブによるインデント
```

### 2.4 Racket実装

```scheme
#lang racket/base

(require brag/support)

(provide sign-lexer)

(define-lex-abbrev digit (:/ "0" "9"))
(define-lex-abbrev alpha (:or (:/ "a" "z") (:/ "A" "Z") "_"))
(define-lex-abbrev alnum (:or alpha digit))

(define sign-lexer
  (lexer-srcloc
   ;; 空白（スキップするが位置情報は保持）
   [(:+ " ") (token 'SPACE lexeme)]
   
   ;; 改行
   [(:or "\n" "\r\n" "\r") (token 'NEWLINE lexeme)]
   
   ;; タブ（インデント）
   ["\t" (token 'INDENT lexeme)]
   
   ;; コメント（行頭バッククォート）
   [(:: "`" (:* (:~ "\n" "\r" "`")) (:? "`"))
    (token 'COMMENT lexeme #:skip? #t)]
   
   ;; 文字列
   [(:: "`" (:* (:~ "`" "\n" "\r")) "`")
    (token 'STRING lexeme)]
   
   ;; 文字
   [(:: "\\" any-char)
    (token 'CHAR lexeme)]
   
   ;; 数値リテラル
   [(:: "0x" (:+ (:or digit (:/ "a" "f") (:/ "A" "F"))))
    (token 'HEX lexeme)]
   [(:: "0o" (:+ (:/ "0" "7")))
    (token 'OCT lexeme)]
   [(:: "0b" (:+ (:or "0" "1")))
    (token 'BIN lexeme)]
   [(:: (:? "-") (:+ digit) "." (:+ digit))
    (token 'FLOAT lexeme)]
   [(:: (:? "-") (:+ digit))
    (token 'INTEGER lexeme)]
   
   ;; Unit
   ["_" (token 'UNIT lexeme)]
   
   ;; 複合演算子（先にマッチ）
   ["<=" (token 'LE lexeme)]
   [">=" (token 'GE lexeme)]
   ["!=" (token 'NE lexeme)]
   ["==" (token 'EQ lexeme)]
   ["<<" (token 'LSHIFT lexeme)]
   [">>" (token 'RSHIFT lexeme)]
   ["||" (token 'BIT_OR lexeme)]
   [";;" (token 'BIT_XOR lexeme)]
   ["&&" (token 'BIT_AND lexeme)]
   ["!!" (token 'BIT_NOT lexeme)]
   
   ;; 単一文字演算子
   ["#" (token 'HASH lexeme)]
   [":" (token 'COLON lexeme)]
   ["," (token 'COMMA lexeme)]
   ["?" (token 'QUESTION lexeme)]
   ["~" (token 'TILDE lexeme)]
   ["|" (token 'PIPE lexeme)]
   [";" (token 'SEMI lexeme)]
   ["&" (token 'AMP lexeme)]
   ["!" (token 'BANG lexeme)]
   ["<" (token 'LT lexeme)]
   ["=" (token 'EQ_SINGLE lexeme)]
   [">" (token 'GT lexeme)]
   ["+" (token 'PLUS lexeme)]
   ["-" (token 'MINUS lexeme)]
   ["*" (token 'STAR lexeme)]
   ["/" (token 'SLASH lexeme)]
   ["%" (token 'PERCENT lexeme)]
   ["^" (token 'CARET lexeme)]
   ["$" (token 'DOLLAR lexeme)]
   ["'" (token 'QUOTE lexeme)]
   ["@" (token 'AT lexeme)]
   
   ;; カッコ
   [(:or "(" "[" "{") (token 'LPAREN lexeme)]
   [(:or ")" "]" "}") (token 'RPAREN lexeme)]
   
   ;; 識別子
   [(:: alpha (:* alnum))
    (token 'IDENTIFIER lexeme)]
   ))

;; 位置判定を行う後処理
(define (classify-operators tokens)
  (for/list ([i (in-range (length tokens))])
    (define tok (list-ref tokens i))
    (define prev (and (> i 0) (list-ref tokens (- i 1))))
    (define next (and (< i (- (length tokens) 1)) 
                      (list-ref tokens (+ i 1))))
    (classify-by-position tok prev next)))

(define (classify-by-position tok prev next)
  (define type (token-struct-type tok))
  (define has-space-before (and prev (eq? (token-struct-type prev) 'SPACE)))
  (define has-space-after (and next (eq? (token-struct-type next) 'SPACE)))
  
  (match type
    ['BANG
     (cond
       [(not has-space-before) (struct-copy token-struct tok [type 'FACTORIAL])]
       [else (struct-copy token-struct tok [type 'NOT])])]
    ['TILDE
     (cond
       [(and (not has-space-before) has-space-after) 
        (struct-copy token-struct tok [type 'CONTINUOUS])]
       [(and has-space-before (not has-space-after))
        (struct-copy token-struct tok [type 'EXPAND])]
       [else (struct-copy token-struct tok [type 'RANGE])])]
    ['AT
     (cond
       [(and (not has-space-before) has-space-after)
        (struct-copy token-struct tok [type 'INPUT])]
       [(and has-space-before (not has-space-after))
        (struct-copy token-struct tok [type 'IMPORT])]
       [else (struct-copy token-struct tok [type 'GET_RIGHT])])]
    ['HASH
     (cond
       [(not prev) (struct-copy token-struct tok [type 'EXPORT])]
       [else (struct-copy token-struct tok [type 'OUTPUT])])]
    [_ tok]))
```

## 3. 構文解析（Parser）

### 3.1 brag文法定義

優先順位の低い順から高い順に定義：

```scheme
#lang brag

;; ============================================
;; Sign言語文法（brag版）
;; 優先順位：低い順から定義
;; ============================================

program : statement*

statement : NEWLINE
          | line NEWLINE

line : export-stmt
     | define-stmt  
     | expression

;; --------------------------------------------
;; 優先順位 1: Export（最低）
;; --------------------------------------------
export-stmt : EXPORT define-stmt

;; --------------------------------------------
;; 優先順位 2: Define（右結合）
;; --------------------------------------------
define-stmt : IDENTIFIER COLON expression

;; --------------------------------------------
;; 優先順位 3: Output
;; --------------------------------------------
output-expr : expression OUTPUT expression
            | lambda-expr

;; --------------------------------------------
;; 優先順位 4-6: 構築域
;; 空白による隣接は adjacency として保持
;; 意味は意味解析時に決定
;; --------------------------------------------
expression : adjacency

adjacency : product-expr+

product-expr : lambda-expr (COMMA lambda-expr)*

;; --------------------------------------------
;; 優先順位 7: Lambda（右結合）
;; --------------------------------------------
lambda-expr : param-list QUESTION lambda-expr
            | range-expr

param-list : IDENTIFIER+
           | CONTINUOUS IDENTIFIER

;; --------------------------------------------
;; 優先順位 8-9: Range / Continuous
;; --------------------------------------------
range-expr : xor-expr (RANGE xor-expr)*
           | xor-expr

;; --------------------------------------------
;; 優先順位 10: XOR / OR
;; --------------------------------------------
xor-expr : and-expr ((XOR | OR) and-expr)*

;; --------------------------------------------
;; 優先順位 11: AND
;; --------------------------------------------
and-expr : not-expr (AND not-expr)*

;; --------------------------------------------
;; 優先順位 12: NOT（前置）
;; --------------------------------------------
not-expr : NOT not-expr
         | compare-expr

;; --------------------------------------------
;; 優先順位 13: 比較演算（連鎖可能）
;; --------------------------------------------
compare-expr : add-expr (compare-op add-expr)*

compare-op : LT | LE | EQ | EQ_SINGLE | GE | GT | NE

;; --------------------------------------------
;; 優先順位 14: 加減算
;; --------------------------------------------
add-expr : mul-expr ((PLUS | MINUS) mul-expr)*

;; --------------------------------------------
;; 優先順位 15: 乗除算
;; --------------------------------------------
mul-expr : pow-expr ((STAR | SLASH | PERCENT) pow-expr)*

;; --------------------------------------------
;; 優先順位 16: 冪乗（右結合）
;; --------------------------------------------
pow-expr : factorial-expr (CARET pow-expr)?

;; --------------------------------------------
;; 優先順位 17: 階乗（後置）
;; --------------------------------------------
factorial-expr : resolve-expr FACTORIAL
               | resolve-expr

;; --------------------------------------------
;; 優先順位 18-22: 解決評価域
;; --------------------------------------------
resolve-expr : expand-expr

expand-expr : address-expr EXPAND
            | address-expr

address-expr : ADDRESS get-expr
             | get-expr

get-expr : get-expr GET_LEFT primary
         | primary GET_RIGHT get-expr
         | import-expr

import-expr : input-expr IMPORT
            | input-expr

input-expr : INPUT primary
           | primary

;; --------------------------------------------
;; 優先順位 29: 基本要素・ブロック
;; --------------------------------------------
primary : literal
        | IDENTIFIER
        | block

literal : INTEGER | FLOAT | HEX | OCT | BIN
        | STRING | CHAR | UNIT

block : LPAREN expression RPAREN
      | indent-block

indent-block : INDENT statement+
```

### 3.2 構文解析の出力

構文解析の結果は、隣接関係を保持したAST：

```scheme
;; 入力: add 3 5
;; 出力:
(adjacency
  (primary (IDENTIFIER "add"))
  (primary (INTEGER "3"))
  (primary (INTEGER "5")))

;; 入力: [* 2,] [1 ~ 5]
;; 出力:
(adjacency
  (block
    (product-expr
      (adjacency (primary (STAR)) (primary (INTEGER "2")))
      (product-expr)))
  (block
    (range-expr
      (primary (INTEGER "1"))
      (primary (INTEGER "5")))))
```

## 4. 意味解析（Semantic Analysis）

### 4.1 空白の意味決定

adjacency ノードを処理する際、型情報から意味を決定：

```scheme
(define (analyze-adjacency nodes env)
  (match nodes
    ;; 単一要素
    [(list single) (analyze single env)]
    
    ;; 2要素以上
    [(list first second rest ...)
     (define t1 (infer-type first env))
     (define t2 (infer-type second env))
     
     (define operation
       (match (cons t1 t2)
         [(cons 'function 'value)    'apply]
         [(cons 'function 'function) 'compose]  
         [(cons 'list 'list)         'concat]
         [(cons 'value 'list)        'push-left]
         [(cons 'list 'value)        'push-right]
         [(cons 'value 'value)       'construct]))
     
     ;; 再帰的に残りを処理
     (if (null? rest)
         `(,operation ,(analyze first env) ,(analyze second env))
         (analyze-adjacency 
           (cons `(,operation ,first ,second) rest)
           env))]))
```

### 4.2 型推論ルール

```scheme
(define (infer-type expr env)
  (match expr
    ;; リテラル
    [(? number?) 'value]
    [(? string?) 'value]
    ['UNIT 'unit]
    
    ;; 識別子は環境から参照
    [(? symbol?) (hash-ref env expr 'value)]
    
    ;; ラムダは関数
    [`(lambda ,_ ,_) 'function]
    
    ;; ポイントフリー記法
    [`(block (product-expr ,op ,arg))
     (if (operator? op) 'function 'list)]
    
    ;; 範囲式はリスト
    [`(range-expr ,_ ,_) 'list]
    
    ;; ブロックは中身の型
    [`(block ,inner) (infer-type inner env)]
    
    ;; adjacencyは結果の型
    [`(adjacency ,first ,_ ...)
     (define t1 (infer-type first env))
     (if (eq? t1 'function) 'value 'list)]
    
    [_ 'value]))
```

### 4.3 意味解析の出力

```scheme
;; 入力AST: (adjacency add 3 5)
;; 環境: {add: function}
;; 出力:
(apply (apply add 3) 5)

;; 入力AST: (adjacency [* 2] [1 ~ 5])  
;; 型推論: [* 2] → function, [1 ~ 5] → list
;; 出力:
(apply (partial * 2) (range 1 5))
;; = (map (λ (x) (* x 2)) (range 1 5))
```

## 5. 完全な処理パイプライン

### 5.1 例：`add : x y ? x + y`

```
[字句解析]
→ [IDENTIFIER:"add", COLON, IDENTIFIER:"x", IDENTIFIER:"y", 
   QUESTION, IDENTIFIER:"x", PLUS, IDENTIFIER:"y"]

[構文解析]
→ (define-stmt
    (IDENTIFIER "add")
    (lambda-expr
      (param-list (IDENTIFIER "x") (IDENTIFIER "y"))
      (add-expr
        (primary (IDENTIFIER "x"))
        (primary (IDENTIFIER "y")))))

[意味解析]
→ (define add
    (lambda (x)
      (lambda (y)
        (+ x y))))
```

### 5.2 例：`[* 2,] [1 ~ 5]`

```
[字句解析]
→ [LPAREN, STAR, INTEGER:"2", COMMA, RPAREN,
   LPAREN, INTEGER:"1", RANGE, INTEGER:"5", RPAREN]

[構文解析]
→ (adjacency
    (block
      (product-expr
        (adjacency (STAR) (INTEGER "2"))
        empty))
    (block
      (range-expr (INTEGER "1") (INTEGER "5"))))

[意味解析]
型推論: 
  - block1: (partial * 2) → function
  - block2: (range 1 5) → list
  - function list → apply

→ (map (λ (x) (* x 2)) (range 1 5))
```

### 5.3 例：`1 2 3 4 5`

```
[字句解析]
→ [INTEGER:"1", INTEGER:"2", INTEGER:"3", INTEGER:"4", INTEGER:"5"]

[構文解析]
→ (adjacency
    (primary (INTEGER "1"))
    (primary (INTEGER "2"))
    (primary (INTEGER "3"))
    (primary (INTEGER "4"))
    (primary (INTEGER "5")))

[意味解析]
型推論: 全てvalue → construct

→ (list 1 2 3 4 5)
```

## 6. Racket #lang 統合

### 6.1 ファイル構成

```
sign-lang/
├── info.rkt
├── main.rkt
├── lang/
│   └── reader.rkt
├── lexer.rkt
├── parser.rkt          ;; brag文法
├── semantics.rkt       ;; 意味解析
├── expander.rkt
└── runtime.rkt
```

### 6.2 reader.rkt

```scheme
#lang racket/base

(require syntax/module-reader
         "lexer.rkt"
         "parser.rkt"
         "semantics.rkt")

(provide (rename-out [sign-read read]
                     [sign-read-syntax read-syntax]))

(define (sign-read in)
  (define tokens (tokenize in))
  (define ast (parse tokens))
  (define semantic-ast (analyze ast))
  semantic-ast)

(define (sign-read-syntax src in)
  (datum->syntax #f (sign-read in) (list src 1 0 1 0)))
```

## 7. まとめ

### 7.1 設計の要点

| 段階 | 責務 | 空白の扱い |
|------|------|-----------|
| 字句解析 | トークン化、演算子位置判定 | 区切り文字 |
| 構文解析 | 優先順位による構造化 | adjacencyとして保持 |
| 意味解析 | 型推論、空白の意味決定 | 型から演算を決定 |

### 7.2 「構文＝型」の実現

- 構文解析は型を知らなくて良い
- 意味解析で型を推論（与えられたトークンの型は宣言的かつ定義的であるため全てについてを網羅的に推論可能）
- 型の組み合わせが空白の意味を決定
- **プログラマは型を書かない、でも型安全**

### 7.3 brag採用の利点

- 宣言的な文法定義
- 優先順位が文法構造で自明
- Racketツールチェインとの統合
- 保守・拡張が容易
