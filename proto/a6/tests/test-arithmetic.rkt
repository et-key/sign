#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt")

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

;; ========================================
;; 四則演算のテスト
;; ========================================

;; 加算
(check-equal? (+ 3 5) 8 "3 + 5 = 8")
(check-equal? (+ 0 10) 10 "0 + 10 = 10")
(check-equal? (+ -5 3) -2 "-5 + 3 = -2")

;; 減算
(check-equal? (- 10 3) 7 "10 - 3 = 7")
(check-equal? (- 5 5) 0 "5 - 5 = 0")
(check-equal? (- 3 10) -7 "3 - 10 = -7")

;; 乗算
(check-equal? (* 3 4) 12 "3 * 4 = 12")
(check-equal? (* 0 10) 0 "0 * 10 = 0")
(check-equal? (* -2 5) -10 "-2 * 5 = -10")

;; 除算
(check-equal? (/ 10 2) 5 "10 / 2 = 5")
(check-equal? (/ 15 3) 5 "15 / 3 = 5")
(check-equal? (/ 7 2) 7/2 "7 / 2 = 7/2 (有理数)")

;; ========================================
;; modulo (%) のテスト
;; ========================================

(check-equal? (modulo 10 3) 1 "10 % 3 = 1")
(check-equal? (modulo 15 5) 0 "15 % 5 = 0")
(check-equal? (modulo 7 2) 1 "7 % 2 = 1")

;; ========================================
;; expt (^) のテスト
;; ========================================

(check-equal? (expt 2 3) 8 "2 ^ 3 = 8")
(check-equal? (expt 5 2) 25 "5 ^ 2 = 25")
(check-equal? (expt 10 0) 1 "10 ^ 0 = 1")
(check-equal? (expt 2 10) 1024 "2 ^ 10 = 1024")

;; ========================================
;; factorial のテスト
;; ========================================

(check-equal? (factorial 0) 1 "0! = 1")
(check-equal? (factorial 1) 1 "1! = 1")
(check-equal? (factorial 5) 120 "5! = 120")
(check-equal? (factorial 6) 720 "6! = 720")

;; ========================================
;; abs のテスト
;; ========================================

(check-equal? (sign:abs 5) 5 "abs(5) = 5")
(check-equal? (sign:abs -5) 5 "abs(-5) = 5")
(check-equal? (sign:abs 0) 0 "abs(0) = 0")

;; ========================================
;; パースのテスト
;; ========================================

(check-equal? (sign-read (open-input-string "3 + 5"))
              '(+ 3 5)
              "3 + 5 のパース")

(check-equal? (sign-read (open-input-string "10 - 3 * 2"))
              '(- 10 (* 3 2))
              "10 - 3 * 2 のパース（優先順位）")

(check-equal? (sign-read (open-input-string "2 ^ 3"))
              '(^ 2 3)
              "2 ^ 3 のパース")

(displayln "すべての算術演算子テストが成功しました！")
