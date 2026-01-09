#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt")

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

;; ========================================
;; 比較演算子のテスト（値返却型）
;; ========================================

;; <
(check-equal? (sign:< 3 5) 3 "3 < 5 は 3 を返す")
(check-equal? (sign:< 5 3) '() "5 < 3 は空リストを返す")
(check-equal? (sign:< 3 3) '() "3 < 3 は空リストを返す")

;; <=
(check-equal? (sign:<= 3 5) 3 "3 <= 5 は 3 を返す")
(check-equal? (sign:<= 3 3) 3 "3 <= 3 は 3 を返す")
(check-equal? (sign:<= 5 3) '() "5 <= 3 は空リストを返す")

;; =
(check-equal? (sign:= 3 3) 3 "3 = 3 は 3 を返す")
(check-equal? (sign:= 3 5) '() "3 = 5 は空リストを返す")

;; >=
(check-equal? (sign:>= 5 3) 5 "5 >= 3 は 5 を返す")
(check-equal? (sign:>= 3 3) 3 "3 >= 3 は 3 を返す")
(check-equal? (sign:>= 3 5) '() "3 >= 5 は空リストを返す")

;; >
(check-equal? (sign:> 5 3) 5 "5 > 3 は 5 を返す")
(check-equal? (sign:> 3 5) '() "3 > 5 は空リストを返す")
(check-equal? (sign:> 3 3) '() "3 > 3 は空リストを返す")

;; !=
(check-equal? (sign:!= 3 5) 3 "3 != 5 は 3 を返す")
(check-equal? (sign:!= 3 3) '() "3 != 3 は空リストを返す")

;; ========================================
;; パースのテスト
;; ========================================

(check-equal? (sign-read (open-input-string "3 < 5"))
              '(sign:< 3 5)
              "3 < 5 のパース")

(check-equal? (sign-read (open-input-string "x = 42"))
              '(sign:= x 42)
              "x = 42 のパース")

(displayln "すべての比較演算子テストが成功しました！")
