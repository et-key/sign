#lang racket/base

(require racket/port
         racket/string
         racket/list
         racket/match
         racket/set)

(provide sign-read
         sign-read-syntax
         ;; For testing
         sign-tokenize
         group-blocks
         sign-parse-block
         parse-expression)

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
  (define block-tree (group-blocks lines))
  (define sexp (sign-parse-block block-tree))
  sexp)

;; ソース位置情報付きで読み取り
(define (sign-read-syntax src in)
  (define sexp (sign-read in))
  (datum->syntax #f sexp))

;; ========================================
;; ブロック構造化（インデント処理）
;; ========================================

;; フラットな行リストをインデントに基づいて木構造に変換
;; 入力: list of (indent tokens)
;; 出力: list of (tokens children...)
(define (group-blocks lines)
  (if (null? lines)
      '()
      (let loop ([remaining lines]
                 [current-indent (car (car lines))]
                 [acc '()])
        (if (null? remaining)
            (reverse acc)
            (let* ([line (car remaining)]
                   [indent (car line)]
                   [tokens (cadr line)])
              (cond
                ;; インデントが深い場合（子ブロック）
                [(> indent current-indent)
                 (let-values ([(children rest) (collect-children remaining indent)])
                   (define parent (car acc))
                   (define new-parent (append parent (list (group-blocks children))))
                   (loop rest current-indent (cons new-parent (cdr acc))))]
                ;; インデントが同じ場合（兄弟）
                [(= indent current-indent)
                 (loop (cdr remaining) current-indent (cons (list tokens) acc))]
                ;; インデントが浅い場合（親ブロックへ戻る）
                [else
                 (reverse acc)]))))))

;; 子ブロックを収集
(define (collect-children lines base-indent)
  (let loop ([remaining lines]
             [acc '()])
    (cond
      [(null? remaining)
       (values (reverse acc) '())]
      [(< (car (car remaining)) base-indent)
       (values (reverse acc) remaining)]
      [else
       (loop (cdr remaining) (cons (car remaining) acc))])))

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
  ;; コメント除去（行頭のバッククォートで始まる行）
  (define s3 (regexp-replace* #px"^`[^\n\r]*" s2 ""))
  ;; 行分割とトークン化
  (define lines (string-split s3 #px"[\r\n]+"))
  (for/list ([line lines]
             #:when (not (string=? (string-trim line) "")))
    (tokenize-line line strings chars)))

(define (tokenize-line line strings chars)
  (define trimmed (string-trim line))
  ;; インデント検出
  (define indent (string-length (car (regexp-match #px"^[\t ]*" line))))
  ;; トークン分割（演算子と識別子を分離）
  (define tokens (tokenize-expression trimmed))
  (list indent (restore-literals tokens strings chars)))

;; 式のトークン化（演算子認識）
(define (tokenize-expression expr)
  (define pattern
    #px"(<=|>=|!=|<<|>>|\\||&&|;;|[+\\-*/^%<>=|&;:?~'@#!,(){}\\[\\]]|[a-zA-Z_][a-zA-Z0-9_]*|[0-9]+\\.?[0-9]*|0x[0-9A-Fa-f]+|0o[0-7]+|0b[01]+|__STRING_[0-9]+__|__CHAR_[0-9]+__|_)")
  (regexp-match* pattern expr))

;; リテラル復元
(define (restore-literals tokens strings chars)
  (for/list ([token tokens])
    (cond
      [(regexp-match #px"__STRING_([0-9]+)__" token)
       => (λ (m) (list-ref strings (string->number (cadr m))))] ; バッククォート付きのまま返す
      [(regexp-match #px"__CHAR_([0-9]+)__" token)
       => (λ (m) (list-ref chars (string->number (cadr m))))]
      [else token])))

;; ========================================
;; パース（中置→前置変換）
;; ========================================

;; ブロックツリーのパース
(define (sign-parse-block block-tree)
  (define result '())
  (for ([node block-tree])
    (match-define (list tokens children ...) node)
    
    ;; 1. 現在の行をパース
    (define parsed-line (parse-line tokens))
    
    ;; 2. 子ブロックがある場合の処理
    (if (null? children)
        (set! result (append result (list parsed-line)))
        (let ([child-sexps (sign-parse-block (car children))]) ; childrenはリストのリストになっている
          ;; 親式と子ブロックを結合
          (set! result (append result (list (combine-with-block parsed-line child-sexps)))))))
          
  (cond
    [(= (length result) 0) '()]
    [(= (length result) 1) (car result)]
    [else (cons 'begin result)]))

;; 行単位のパース
(define (parse-line tokens)
  ;; 1. 括弧 [...] (...) {...} の処理
  (define tokens-with-brackets (process-all-brackets tokens))
  ;; 2. ~演算子の分類
  (define tokens-with-tilde (classify-tilde-operators tokens-with-brackets))
  ;; 3. 暗黙の関数適用（%app）を挿入
  (define tokens-with-app (insert-implicit-app tokens-with-tilde))
  ;; 4. `?` で終わる場合はプレースホルダを挿入
  (define tokens-final
    (if (and (not (null? tokens-with-app))
             (equal? (last tokens-with-app) "?"))
        (append (drop-right tokens-with-app 1) (list "?" "__BLOCK__"))
        tokens-with-app))
  ;; 5. 式のパース
  (parse-expression tokens-final))

;; 式とブロックの結合
(define (combine-with-block parent-sexp child-block)
  (define unwrapped-block
    (match child-block
      [(list 'begin exprs ...) exprs]
      [_ (list child-block)]))
  
  (match parent-sexp
    [(list 'define name (list 'sign:? params body))
     (list 'define name (cons 'sign:? (cons params unwrapped-block)))]
      
    [(list 'sign:? params body)
     (cons 'sign:? (cons params unwrapped-block))]
      
    [else
     (list 'begin parent-sexp child-block)]))

;; 全ての括弧 [...] (...) {...} の処理
(define (process-all-brackets tokens)
  (let loop ([rest tokens]
             [acc '()])
    (cond
      [(null? rest) (reverse acc)]
      
      ;; 角括弧 [ ... ]
      [(equal? (car rest) "[")
       (define-values (inner remaining) (split-at-matching-bracket (cdr rest) 0 "[" "]"))
       (define processed-inner (process-all-brackets inner))
       (define converted (convert-bracket-content processed-inner))
       (loop remaining (cons converted acc))]
       
      ;; 丸括弧 ( ... )
      [(equal? (car rest) "(")
       (define-values (inner remaining) (split-at-matching-bracket (cdr rest) 0 "(" ")"))
       (define processed-inner (process-all-brackets inner))
       (define converted (convert-bracket-content processed-inner))
       (loop remaining (cons converted acc))]
       
      ;; 波括弧 { ... }
      [(equal? (car rest) "{")
       (define-values (inner remaining) (split-at-matching-bracket (cdr rest) 0 "{" "}"))
       (define processed-inner (process-all-brackets inner))
       (define converted (convert-bracket-content processed-inner))
       (loop remaining (cons converted acc))]
       
      [else
       (loop (cdr rest) (cons (car rest) acc))])))

;; 括弧の対応をとって分割（汎用版）
;; open-paren: 期待する開き括弧
;; close-paren: 期待する閉じ括弧
(define (split-at-matching-bracket tokens depth open-paren close-paren)
  (cond
    [(null? tokens) (error 'parse "Unmatched ~a" open-paren)]
    [(equal? (car tokens) open-paren)
     (define-values (inner remaining) (split-at-matching-bracket (cdr tokens) (+ depth 1) open-paren close-paren))
     (values (cons open-paren inner) remaining)]
    [(equal? (car tokens) close-paren)
     (if (= depth 0)
         (values '() (cdr tokens))
         (let-values ([(inner remaining) (split-at-matching-bracket (cdr tokens) (- depth 1) open-paren close-paren)])
           (values (cons close-paren inner) remaining)))]
    [else
     (define-values (inner remaining) (split-at-matching-bracket (cdr tokens) depth open-paren close-paren))
     (values (cons (car tokens) inner) remaining)]))

;; 角括弧内の変換ロジック
(define (convert-bracket-content tokens)
  (cond
    ;; 空の括弧
    [(null? tokens) '()]
    
    ;; MAP操作: [... ,] → (lambda (lst) (stream-map f lst))
    [(equal? (last tokens) ",")
     (let* ([inner (take tokens (sub1 (length tokens)))]
            [f (convert-bracket-content inner)])
       (list 'lambda '(lst) (list 'stream-map f 'lst)))]
    
    ;; 範囲リスト: [start ~ end]
    [(and (= (length tokens) 3) (equal? (cadr tokens) "~"))
     (list 'sign:range (parse-token (car tokens)) (parse-token (caddr tokens)))]
    
    ;; 無限範囲リスト: [start ~]
    [(and (= (length tokens) 2) (equal? (cadr tokens) "~"))
     (list 'sign:range-infinite (parse-token (car tokens)))]
    
    ;; FOLD操作: [op] → (lambda (lst) (stream-fold op 0 lst))
    [(and (= (length tokens) 1) (is-operator? (car tokens)))
     (let ([op (string->symbol (car tokens))])
       (list 'lambda '(lst) (list 'stream-fold op 0 'lst)))]
    
    ;; 部分適用（右）: [op arg] → (lambda (x) (op x val))
    [(and (= (length tokens) 2) (is-operator? (car tokens)))
     (let ([op (string->symbol (car tokens))]
           [val (parse-token (cadr tokens))])
       (list 'lambda '(x) (list op 'x val)))]
    
    ;; 部分適用（左）: [arg op] → (lambda (x) (op val x))
    [(and (= (length tokens) 2) (is-operator? (cadr tokens)))
     (let ([val (parse-token (car tokens))]
           [op (string->symbol (cadr tokens))])
       (list 'lambda '(x) (list op val 'x)))]
    
    ;; それ以外は通常のリストとして処理（カンマ区切りなどを想定）
    [else
     ;; 内部を infix->prefix でパースする
     (parse-expression tokens)]))

(define (is-operator? token)
  (and (string? token)
       (hash-has-key? operator-precedence token)))

(define (parse-token token)
  (if (string? token)
      (cond
        [(regexp-match? #px"^-?[0-9]" token) (string->number token)]
        [(regexp-match? #px"^`.*`$" token) (substring token 1 (sub1 (string-length token)))]
        [else (string->symbol token)])
      token))

;; ~演算子の分類処理
;; Sign言語リファレンスに基づき、~演算子を3種類に分類：
;; - 中置: `1 ~ 5` (両側にオペランド)
;; - 前置: `~rest` (直後に識別子) - 現在未実装
;; - 後置: `list~` (直前にオペランド、直後が非オペランド)
(define (classify-tilde-operators tokens)
  (if (null? tokens)
      '()
      (let loop ([rest (cdr tokens)]
                 [prev (car tokens)]
                 [acc '()])
        (cond
          ;; ~ が後置演算子として使われている場合（直前がオペランド、直後がオペランドでない）
          [(and (equal? prev "~")
                (not (null? acc)) ; 直前に何かある
                (is-operand? (car acc)) ; 直前がオペランド
                (or (null? rest) ; 文末
                    (not (is-operand? (car rest))))) ; 次がオペランドでない（演算子など）
           ;; 直前のオペランドを取り出し、(sign:expand operand) に変換
           (let ([operand (car acc)]
                 [new-acc (cdr acc)])
             (if (null? rest)
                 (reverse (cons (list 'sign:expand (parse-token operand)) new-acc))
                 (loop (cdr rest) (car rest) (cons (list 'sign:expand (parse-token operand)) new-acc))))]
          
          [(null? rest)
           (reverse (cons prev acc))]
          
          [else
           (loop (cdr rest) (car rest) (cons prev acc))]))))

(define (is-operand? t)
  (or (list? t)
      (regexp-match? #px"^[a-zA-Z0-9_`]" t)
      (member t '(")" "]" "}" "_"))))

;; 識別子判定
(define (is-identifier? t)
  (and (string? t)
       (regexp-match? #px"^[a-zA-Z_][a-zA-Z0-9_]*$" t)))

;; 式のパース
(define (parse-expression tokens)
  (if (null? tokens)
      '()
      (infix->prefix tokens)))

;; 暗黙の関数適用演算子を挿入
(define (insert-implicit-app tokens)
  (if (null? tokens)
      '()
      (let loop ([rest (cdr tokens)]
                 [prev (car tokens)]
                 [acc (list (car tokens))])
        (if (null? rest)
            (reverse acc)
            (let ([curr (car rest)])
              (if (should-insert-app? prev curr)
                  (loop rest prev (cons "%app" acc)) ; %appを挿入して再試行せず、prevはそのまま
                  (loop (cdr rest) curr (cons curr acc))))))))

(define (should-insert-app? prev curr)
  (define (is-operand? t)
    (or (list? t) ; S式（変換済み[...]など）もオペランド
        (regexp-match? #px"^[a-zA-Z0-9_`]" t) ; 識別子、数値、文字列
        (member t '(")" "]" "}" "_"))))
  (define (is-start-operand? t)
    (or (list? t)
        (regexp-match? #px"^[a-zA-Z0-9_`]" t)
        (member t '("(" "[" "{"))))
  
  ;; オペランドの後にオペランドが続く場合（間に演算子がない）
  (and (is-operand? prev)
       (is-start-operand? curr)
       (not (hash-has-key? operator-precedence prev)) ; prevが演算子でない
       (not (hash-has-key? operator-precedence curr)))) ; currが演算子でない

;; 中置記法から前置記法への変換
(define (infix->prefix tokens)
  (define output '())
  (define operators '())
  
  (define (precedence op)
    (if (equal? op "%app") 20 ; 関数適用は最高優先順位
        (hash-ref operator-precedence op 0)))
  
  (define (right-assoc? op)
    (set-member? right-associative op))
  
  (define (operator? token)
    (or (equal? token "%app")
        (hash-has-key? operator-precedence token)))
  
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
      ;; ? 演算子（ラムダ構築子）
      [(equal? op "?")
       (if (< (length output) 2)
           (error 'parse "Lambda operator ? requires both parameters and body")
           (let ([body (car output)]
                 [params-part (cadr output)])
             (set! output (cddr output))
             (define params (flatten-params params-part))
             (push-output! (list 'sign:? params body))))]
      ;; %app 演算子（関数適用・リスト結合）
      ;; 型判定により動作を切り替え（runtime.rktのsign:app参照）
      [(equal? op "%app")
       (if (< (length output) 2)
           (error 'parse "Application operator requires two arguments")
           (let ([arg (car output)]
                 [func (cadr output)])
             (set! output (cddr output))
             (push-output! (list 'sign:app func arg))))]
      ;; : 演算子（変数定義）
      ;; x : 42 → (define x 42)
      [(equal? op ":")
       (if (< (length output) 2)
           (error 'parse "Define operator : requires both name and value")
           (let ([value (car output)]
                 [name (cadr output)])
             (set! output (cddr output))
             (push-output! (list 'define name value))))]
      ;; , 演算子（リスト構築）
      [(equal? op ",")
       (if (< (length output) 2)
           (error 'parse "Comma operator requires two arguments")
           (let ([right (car output)]
                 [left (cadr output)])
             (set! output (cddr output))
             (push-output! (list 'sign:cons left right))))]
      ;; 比較演算子（sign: プレフィックスに変換）
      [(member op '("<" "<=" "=" ">=" ">" "!="))
       (if (< (length output) 2)
           (error 'parse (format "Comparison operator ~a requires two arguments" op))
           (let ([right (car output)]
                 [left (cadr output)])
             (set! output (cddr output))
             (push-output! (list (string->symbol (string-append "sign:" op)) left right))))]
      ;; 通常の演算子処理
      [(< (length output) 2)
       (if (null? output)
           (push-output! (string->symbol op))
           (let ([arg (car output)])
             (set! output (cdr output))
             (push-output! (list (string->symbol op) arg))))]
      [else
       (define right (car output))
       (define left (cadr output))
       (set! output (cddr output))
       (push-output! (list (string->symbol op) left right))]))

  (define (flatten-params expr)
    (cond
      [(and (list? expr) (= (length expr) 2) (not (eq? (car expr) 'sign:?)))
       (append (flatten-params (car expr)) (flatten-params (cadr expr)))]
      [(symbol? expr) (list expr)]
      [else (list expr)]))
  
  (for ([token tokens])
    (cond
      ;; 既にパース済みのS式（[...]の中身など）
      [(list? token)
       (push-output! token)]
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
         (pop-operator!))]
      ;; Unit
      [(equal? token "_")
       (push-output! ''())]
      ;; 数値
      [(regexp-match? #px"^-?[0-9]" token)
       (push-output! (string->number token))]
      ;; 16進数
      [(regexp-match? #px"^0x" token)
       (push-output! (string->number (substring token 2) 16))]
      ;; 8進数
      [(regexp-match? #px"^0o" token)
       (push-output! (string->number (substring token 2) 8))]
      ;; 2進数
      [(regexp-match? #px"^0b" token)
       (push-output! (string->number (substring token 2) 2))]
      ;; 文字列リテラル
      [(regexp-match? #px"^`.*`$" token)
       (push-output! (substring token 1 (sub1 (string-length token))))]
      ;; __BLOCK__ placeholder (for empty lambda body)
      [(equal? token "__BLOCK__")
       (push-output! ''())]
      ;; 識別子
      [else
       (push-output! (string->symbol token))]))
  
  (for ([op (in-list operators)])
    (unless (member op '("(" "[" "{"))
      (apply-operator! op)))
  
  (if (= (length output) 1)
      (car output)
      (if (null? output) '() output)))
