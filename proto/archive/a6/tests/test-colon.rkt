#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt")

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

;; 変数定義のテスト
(test-case "Variable definition with colon"
  (define test-code "x : 42")
  (with-handlers ([exn:fail? (lambda (e)
                               (fail (format "Parsing failed: ~a" (exn-message e))))])
    (define parsed (sign-read (open-input-string test-code)))
    (printf "Parsed: ~a\n" parsed)
    (check-equal? parsed '(define x 42) "x : 42 should parse to (define x 42)")
    (eval parsed ns)
    (define x-value (eval 'x ns))
    (check-equal? x-value 42 "x should be 42")
    (printf "Variable definition test passed!\n")))

;; 複数行の定義
(test-case "Multiple definitions"
  (define test-code "x : 42\ny : 10")
  (with-handlers ([exn:fail? (lambda (e)
                               (fail (format "Parsing failed: ~a" (exn-message e))))])
    (define parsed (sign-read (open-input-string test-code)))
    (printf "Parsed: ~a\n" parsed)
    (eval parsed ns)
    (check-equal? (eval 'x ns) 42 "x should be 42")
    (check-equal? (eval 'y ns) 10 "y should be 10")
    (printf "Multiple definitions test passed!\n")))

;; 式の定義
(test-case "Expression definition"
  (define test-code "sum : 3 + 5")
  (with-handlers ([exn:fail? (lambda (e)
                               (fail (format "Parsing failed: ~a" (exn-message e))))])
    (define parsed (sign-read (open-input-string test-code)))
    (printf "Parsed: ~a\n" parsed)
    (eval parsed ns)
    (check-equal? (eval 'sum ns) 8 "sum should be 8")
    (printf "Expression definition test passed!\n")))

(printf "\nAll colon operator tests passed!\n")
