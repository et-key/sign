#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt")

;; ========================================
;; 基本的なパーステスト
;; ========================================

(check-equal? (sign-read (open-input-string "42"))
              42
              "数値リテラル")

(check-equal? (sign-read (open-input-string "_"))
              ''()
              "Unit（空リスト）")

(check-equal? (sign-read (open-input-string "1 + 2"))
              '(+ 1 2)
              "加算")

(check-equal? (sign-read (open-input-string "3 * 4 + 2"))
              '(+ (* 3 4) 2)
              "演算子優先順位")

(check-equal? (sign-read (open-input-string "2 ^ 10"))
              '(^ 2 10)
              "べき乗")

;; ========================================
;; 比較演算テスト
;; ========================================

(check-equal? (sign:< 3 5)
              3
              "3 < 5 は 3 を返す")

(check-equal? (sign:< 5 3)
              '()
              "5 < 3 は Unit を返す")

(check-equal? (sign:= 5 5)
              5
              "5 = 5 は 5 を返す")

;; ========================================
;; 論理演算テスト
;; ========================================

(check-equal? (sign:and '() 1)
              '()
              "Unit & 1 は Unit")

(check-equal? (sign:and 1 2)
              2
              "1 & 2 は 2")

(check-equal? (sign:or '() 1)
              1
              "Unit | 1 は 1")

(check-equal? (sign:or 1 2)
              1
              "1 | 2 は 1")

(check-equal? (sign:not '())
              1
              "!Unit は 1")

(check-equal? (sign:not 1)
              '()
              "!1 は Unit")

;; ========================================
;; Stream/リスト操作テスト
;; ========================================

(require srfi/41)

(check-equal? (stream->list (sign:range 1 5))
              '(1 2 3 4 5)
              "範囲リスト [1 ~ 5]")

(check-equal? (stream-ref (sign:range-infinite 1) 9)
              10
              "無限リスト [1 ~ ] の10番目は10")

;; ========================================
;; 算術演算テスト
;; ========================================

(check-equal? (factorial 5)
              120
              "5! = 120")

(displayln "すべてのテストが成功しました！")
