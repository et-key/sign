#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt"
         srfi/41)

;; ========================================
;; 制御構造 統合テスト
;; ========================================

(displayln "Running Control Structure Integration Tests...")

;; ----------------------------------------
;; 1. 階乗 (Factorial)
;; 再帰と条件分岐の組み合わせ
;; ----------------------------------------
(define fact-code "fact : n ?
    n <= 1 : 1
    n * (fact (n - 1))")

(define fact-sexp (sign-read (open-input-string fact-code)))
(displayln "Factorial parsed:")
(displayln fact-sexp)

;; Check structure
;; (define fact (sign:? (n) (cond ...)))
(check-equal? (car fact-sexp) 'define)
(check-equal? (cadr fact-sexp) 'fact)
(define fact-body (caddr (caddr fact-sexp))) ; (cond ...)
(check-equal? (car fact-body) 'cond)

;; ----------------------------------------
;; 2. フィボナッチ (Fibonacci)
;; 複数の条件節
;; ----------------------------------------
(define fib-code "fib : n ?
    n <= 1 : n
    (fib (n - 1)) + (fib (n - 2))")

(define fib-sexp (sign-read (open-input-string fib-code)))
(displayln "Fibonacci parsed:")
(displayln fib-sexp)

;; ----------------------------------------
;; 3. 複雑なネスト (Complex Nesting)
;; ブロック内のローカル定義と計算
;; ----------------------------------------
(define complex-code "calc : x ?
    a : x * 2
    b : a + 1
    b > 10 : `large`
    b <= 10 : `small`")

(define complex-sexp (sign-read (open-input-string complex-code)))
(displayln "Complex parsed:")
(displayln complex-sexp)

;; Structure should be:
;; (define calc (sign:? (x)
;;   (define a (* x 2))
;;   (define b (+ a 1))
;;   (cond ...)))

(check-equal? (car complex-sexp) 'define)
(define complex-body (caddr (caddr complex-sexp))) ; (sign:? (x) BODY...)
;; BODY is (define a ...) (define b ...) (cond ...)
;; So it's a list of 3 elements?
;; Wait, combine-with-block splices them into the lambda body.
;; So (sign:? (x) def1 def2 cond)
;; The body of sign:? is (def1 def2 cond)

(define lambda-body (cddr (caddr complex-sexp))) ; (def1 def2 cond)
(check-equal? (length lambda-body) 3 "Should have 3 expressions in lambda body")
(check-equal? (caar lambda-body) 'define "First is define a")
(check-equal? (caadr lambda-body) 'define "Second is define b")
(check-equal? (car (caddr lambda-body)) 'cond "Third is cond")

(displayln "Integration tests passed!")
