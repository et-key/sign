#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt"
         srfi/41)

;; ========================================
;; 条件分岐（match_case）テスト
;; ========================================

;; Test 1: Simple conditional block
;; classify : x ?
;;     x < 0 : "negative"
;;     x = 0 : "zero"
;;     x > 0 : "positive"

(define test1-code "classify : x ?
    x < 0 : `negative`
    x = 0 : `zero`
    x > 0 : `positive`")

(define test1-sexp (sign-read (open-input-string test1-code)))
(displayln "Test 1 parsed:")
(displayln test1-sexp)

;; Check parsing structure
(check-pred list? test1-sexp)
(check-equal? (car test1-sexp) 'define)
(check-equal? (cadr test1-sexp) 'classify)

;; The body should contain a cond expression
(define body (caddr (caddr test1-sexp))) ; (define name (lambda (args) BODY))
(check-equal? (car body) 'cond "Body should be a cond expression")

;; Check clauses
(define clauses (cdr body))
(check-equal? (length clauses) 3 "Should have 3 clauses")

;; Clause 1: ((sign:truthy? (sign:< x 0)) "negative")
(check-equal? (caar clauses) '(sign:truthy? (sign:< x 0)))
(check-equal? (cadar clauses) "negative")

;; Test 2: Mixed content with implicit else (now supported)
;; mixed : x ?
;;     x < 0 : `negative`
;;     `default`

(define test2-code "mixed : x ?
    x < 0 : `negative`
    `default`")

(define test2-sexp (sign-read (open-input-string test2-code)))
(displayln "Test 2 (implicit else) parsed:")
(displayln test2-sexp)

;; Should parse to (define mixed (sign:? (x) (cond ((< x 0) "negative") (else "default"))))
(check-equal? (car test2-sexp) 'define)
(define test2-body (caddr (caddr test2-sexp)))
(check-equal? (car test2-body) 'cond)
(define test2-clauses (cdr test2-body))
(check-equal? (length test2-clauses) 2 "Should have 2 clauses (condition + else)")
(check-equal? (car (cadr test2-clauses)) 'else "Second clause should be else")

(displayln "Match case parsing tests passed!")
