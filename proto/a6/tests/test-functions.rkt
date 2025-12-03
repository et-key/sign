#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt"
         srfi/41)

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
;; ラムダ式の評価テスト
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
;; ポイントフリー記法テスト
;; ========================================

;; 右オペランド固定
(define increment (sign:partial-right + 1))
(check-equal? (increment 5) 6 "部分適用（右オペランド固定）")

(define double (sign:partial-right * 2))
(check-equal? (double 7) 14 "部分適用（乗算）")

;; 左オペランド固定
(define subtract-from-10 (sign:partial-left 10 -))
(check-equal? (subtract-from-10 3) 7 "部分適用（左オペランド固定）")

;; ========================================
;; 関数合成テスト
;; ========================================

(define add1-then-double (sign:compose double add1))
(check-equal? (add1-then-double 5) 12 "関数合成: (5 + 1) * 2")

;; ========================================
;; 定義と適用の統合テスト
;; ========================================

;; 定義演算子と組み合わせたテスト
(define test-expr "f : x ? x * 2")
(define parsed (sign-read (open-input-string test-expr)))
(check-equal? parsed
              '(: f (sign:? (x) (* x 2)))
              "定義演算子とラムダの組み合わせパース")

(displayln "すべてのラムダ関数テストが成功しました！")
