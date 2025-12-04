#lang racket/base

(require rackunit
         srfi/41
         "../reader.rkt"
         "../runtime.rkt")

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

(define (run-test name thunk)
  (printf "Running test: ~a... " name)
  (flush-output)
  (with-handlers ([exn:fail? (lambda (e) (printf "FAILED: ~a\n" (exn-message e)))])
    (call-with-limits 2 #f
      thunk))
  (printf "OK\n"))

(require racket/sandbox)

;; 1. 角括弧（既存）
(run-test "Square Brackets [1 ~ 5]"
  (lambda ()
    (check-equal? (sign:expand (eval (sign-read (open-input-string "[1 ~ 5]")) ns))
                  '(1 2 3 4 5))))

;; 2. 丸括弧（新規）
(run-test "Round Brackets (1 ~ 5)"
  (lambda ()
    (check-equal? (sign:expand (eval (sign-read (open-input-string "(1 ~ 5)")) ns))
                  '(1 2 3 4 5))))

;; 3. 波括弧（新規）
(run-test "Curly Brackets {1 ~ 5}"
  (lambda ()
    (check-equal? (sign:expand (eval (sign-read (open-input-string "{1 ~ 5}")) ns))
                  '(1 2 3 4 5))))

;; 4. 通常のグループ化
(run-test "Grouping (1 + 2)"
  (lambda ()
    (check-equal? (eval (sign-read (open-input-string "(1 + 2)")) ns)
                  3)))

(run-test "Grouping {1 + 2}"
  (lambda ()
    (check-equal? (eval (sign-read (open-input-string "{1 + 2}")) ns)
                  3)))

;; 5. ネスト
(run-test "Nested Brackets [(1 ~ 3)]"
  (lambda ()
    (check-equal? (sign:expand (eval (sign-read (open-input-string "[(1 ~ 3)]")) ns))
                  '(1 2 3))))
