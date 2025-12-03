#lang racket/base

(require racket/port
         racket/string
         racket/list
         racket/match
         racket/set)

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
  (datum->syntax #f sexp))

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

;; Shunting-yard algorithm による中置→前置変換
(define (sign-parse tokenized-lines)
  (define result '())
  (for ([line tokenized-lines])
    (match-define (list indent tokens) line)
    ;; 暗黙の関数適用（%app）を挿入
    (define tokens-with-app (insert-implicit-app tokens))
    (define parsed (parse-expression tokens-with-app))
    (when (not (null? parsed))
      (set! result (append result (list parsed)))))
  (cond
    [(= (length result) 0) '()]
    [(= (length result) 1) (car result)]
    [else (cons 'begin result)]))

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
    (or (regexp-match? #px"^[a-zA-Z0-9_`]" t) ; 識別子、数値、文字列
        (member t '(")" "]" "}" "_"))))
  (define (is-start-operand? t)
    (or (regexp-match? #px"^[a-zA-Z0-9_`]" t)
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
      ;; ? 演算子（ラムダ構築子）の特別処理
      [(equal? op "?")
       (if (< (length output) 2)
           (error 'parse "Lambda operator ? requires both parameters and body")
           (let ([body (car output)]
                 [params-part (cadr output)])
             (set! output (cddr output))
             ;; パラメータリストの構築
             (define params (flatten-params params-part))
             (push-output! (list 'sign:? params body))))]
      ;; %app 演算子（関数適用）
      [(equal? op "%app")
       (if (< (length output) 2)
           (error 'parse "Application operator requires two arguments")
           (let ([arg (car output)]
                 [func (cadr output)])
             (set! output (cddr output))
             (push-output! (list func arg))))]
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

  ;; パラメータのフラット化（カリー化された適用列をリストに変換）
  (define (flatten-params expr)
    (cond
      ;; (f arg) の形なら [f, arg] に分解して再帰
      [(and (list? expr) (= (length expr) 2) (not (eq? (car expr) 'sign:?)))
       (append (flatten-params (car expr)) (flatten-params (cadr expr)))]
      ;; シンボルならリスト化
      [(symbol? expr) (list expr)]
      ;; それ以外（エラーかもだが）
      [else (list expr)]))
  
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
      ;; 文字列リテラル（バッククォート付き）
      [(regexp-match? #px"^`.*`$" token)
       (push-output! (substring token 1 (sub1 (string-length token))))]
      ;; 識別子
      [else
       (push-output! (string->symbol token))]))
  
  (for ([op (in-list operators)])
    (unless (member op '("(" "[" "{"))
      (apply-operator! op)))
  
  (if (= (length output) 1)
      (car output)
      (if (null? output) '() output)))
