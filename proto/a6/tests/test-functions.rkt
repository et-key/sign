#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt")

;; ========================================
;; ラムダ式のパーステスト
;; ========================================

(check-equal? (sign-read (open-input-string "x ? x + 1"))
              '(sign:? (x) (+ x 1))
              "単一引数ラムダのパース")

(check-equal? (sign-read (open-input-string "x y ? x + y"))
              '(sign:? (x y) (+ x y))
              "複数引数ラムダのパース")

;; ========================================
;; ラムダ式の評価テスト（直接呼び出し）
;; ========================================

;; 単一引数ラムダ
(define add1 (sign:? (x) (+ x 1)))
(check-equal? (add1 5) 6 "単一引数ラムダの適用")

;; 複数引数ラムダ（カリー化）
(define add (sign:? (x y) (+ x y)))
(check-equal? ((add 3) 5) 8 "カリー化されたラムダの適用")

;; 部分適用
(define add3 (add 3))
(check-equal? (add3 7) 10 "部分適用された関数")

;; ========================================
;; 定義演算子とラムダの統合テスト
;; ========================================

;; 定義演算子と組み合わせたテスト（パースのみ）
(check-equal? (sign-read (open-input-string "f : x ? x * 2"))
              '(define f (sign:? (x) (* x 2)))
              "定義演算子とラムダの組み合わせパース")

;; ========================================
;; ポイントフリー記法テスト
;; ========================================

;; 右オペランド固定: [+ 1]
(check-equal? (sign-read (open-input-string "[+ 1]"))
              '(lambda (x) (+ x 1))
              "ポイントフリー記法: [+ 1]")

;; 左オペランド固定: [10 -]
(check-equal? (sign-read (open-input-string "[10 -]"))
              '(lambda (x) (- 10 x))
              "ポイントフリー記法: [10 -]")

;; FOLD操作: [+]
(check-equal? (sign-read (open-input-string "[+]"))
              '(lambda (lst) (stream-fold + 0 lst))
              "ポイントフリー記法: [+]")

(displayln "すべてのラムダ関数テストが成功しました！")
