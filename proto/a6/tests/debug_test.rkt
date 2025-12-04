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
    (call-with-limits 2 #f ; 2 seconds timeout
      thunk))
  (printf "OK\n"))

(require racket/sandbox) ; for call-with-limits

;; 1. リスト構築
(run-test "List Construction"
  (lambda ()
    (check-equal? (sign:expand (eval (sign-read (open-input-string "1, 2, 3")) ns))
                  '(1 2 3))))

;; 2. 範囲リスト
(run-test "Range List"
  (lambda ()
    (check-equal? (sign:expand (eval (sign-read (open-input-string "[1 ~ 5]")) ns))
                  '(1 2 3 4 5))))

;; 3. 無限リスト
(run-test "Infinite List"
  (lambda ()
    (check-equal? (sign:expand (stream-take 5 (eval (sign-read (open-input-string "[1 ~]")) ns)))
                  '(1 2 3 4 5))))

;; 4. ポイントフリー記法
(run-test "Point-free Right"
  (lambda ()
    (check-equal? ((eval (sign-read (open-input-string "[+ 1]")) ns) 5)
                  6)))

(run-test "Point-free Left"
  (lambda ()
    (check-equal? ((eval (sign-read (open-input-string "[10 -]")) ns) 3)
                  7)))

;; 5. MAP操作
(run-test "MAP Operation"
  (lambda ()
    (check-equal? (sign:expand ((eval (sign-read (open-input-string "[* 2,]")) ns) 
                                 (eval (sign-read (open-input-string "[1 ~ 3]")) ns)))
                  '(2 4 6))))

;; 6. 展開演算子
(run-test "Expand Operator"
  (lambda ()
    (let ([s (eval (sign-read (open-input-string "[1 ~ 3]")) ns)])
      (check-equal? (sign:expand s)
                    '(1 2 3)))))

;; 7. リスト結合
;; (run-test "List Concatenation"
;;   (lambda ()
;;     (check-equal? (sign:expand (eval (sign-read (open-input-string "[1 ~ 3] [4 ~ 6]")) ns))
;;                   '(1 2 3 4 5 6))))

;; 8. 複合テスト
(run-test "Complex Test"
  (lambda ()
    (check-equal? (sign:expand ((sign:map (sign:partial-right + 1)) (sign:range 1 3)))
                  '(2 3 4))))
