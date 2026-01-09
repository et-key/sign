#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt")

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

;; 基本的なSign言語の構文をテストする
(test-case "Basic arithmetic"
  (define test-code "3 + 5")
  (with-handlers ([exn:fail? (lambda (e)
                               (fail (format "Parsing/execution failed: ~a" (exn-message e))))])
    (define parsed (sign-read (open-input-string test-code)))
    (define result (eval parsed ns))
    (check-equal? result 8 "3 + 5 should equal 8")))

(test-case "Bracket equivalence for grouping"
  (define test-cases
    '(("(3 + 5) * 2" . 16)
      ("{10 - 3} + 1" . 8)
      ("[2 * 3] + 4" . 10)))
  
  (for ([tc test-cases])
    (define code (car tc))
    (define expected (cdr tc))
    (with-handlers ([exn:fail? (lambda (e)
                                 (fail (format "~a failed: ~a" code (exn-message e))))])
      (define parsed (sign-read (open-input-string code)))
      (define result (eval parsed ns))
      (check-equal? result expected (format "~a should equal ~a" code expected)))))

(printf "All basic Sign language tests passed!\n")
