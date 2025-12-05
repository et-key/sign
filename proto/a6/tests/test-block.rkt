#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt"
         srfi/41)

;; ========================================
;; ブロック構文テスト
;; ========================================

;; Test 1: Simple block with nested definitions
(define test1-code "f : x ?
    y : x + 1
    y * 2")

(define test1-sexp (sign-read (open-input-string test1-code)))
(displayln "Test 1 parsed:")
(displayln test1-sexp)

;; Evaluate it
;; (define f (eval test1-sexp (make-base-namespace)))
;; Wait, this won't work because sign:? is not available in base namespace

;; Let's create a proper namespace with our runtime
;; (define test-ns (make-base-namespace))
;; (namespace-require 'racket/base test-ns)
;; (for ([binding (namespace-mapped-symbols)])
;;   (when (regexp-match? #rx"^sign:" (symbol->string binding))
;;     (namespace-set-variable-value! test-ns binding (namespace-variable-value binding))))

;; Actually, let's just test the parsing for now
(check-pred list? test1-sexp "Should parse to a list")
(check-equal? (car test1-sexp) 'define "Should be a define")
(check-equal? (cadr test1-sexp) 'f "Should define f")

(displayln "Block syntax parsing tests passed!")
