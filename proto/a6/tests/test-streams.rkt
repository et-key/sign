#lang racket/base

(require rackunit
         srfi/41
         "../reader.rkt"
         "../runtime.rkt")

;; ========================================
;; Phase 3: リスト操作とStreamのテスト
;; ========================================

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

;; 1. リスト構築（カンマ演算子）
(check-equal? (sign-read (open-input-string "1, 2, 3"))
              '(sign:cons 1 (sign:cons 2 3))
              "カンマ演算子によるリスト構築")

(check-equal? (sign:expand (eval (sign-read (open-input-string "1, 2, 3")) ns))
              '(1 2 3)
              "カンマ演算子の評価")

;; 2. 範囲リスト
(check-equal? (sign:expand (sign:range 1 5))
              '(1 2 3 4 5)
              "範囲リスト (sign:range)")

(check-equal? (sign-read (open-input-string "[1 ~ 5]"))
              '(sign:range 1 5)
              "範囲リスト構文")

(check-equal? (sign:expand (eval (sign-read (open-input-string "[1 ~ 5]")) ns))
              '(1 2 3 4 5)
              "範囲リスト構文の評価")

;; 3. 無限リストとtake
(check-equal? (sign:expand (stream-take 5 (sign:range-infinite 1)))
              '(1 2 3 4 5)
              "無限リスト (sign:range-infinite)")

(check-equal? (sign-read (open-input-string "[1 ~]"))
              '(sign:range-infinite 1)
              "無限リスト構文")

;; 4. ポイントフリー記法
(check-equal? (sign-read (open-input-string "[+ 1]"))
              '(sign:partial-right + 1)
              "部分適用（右）構文")

(check-equal? ((eval (sign-read (open-input-string "[+ 1]")) ns) 5)
              6
              "部分適用（右）の評価")

(check-equal? (sign-read (open-input-string "[1 -]"))
              '(sign:partial-left 1 -)
              "部分適用（左）構文")

(check-equal? ((eval (sign-read (open-input-string "[10 -]")) ns) 3)
              7
              "部分適用（左）の評価")

(check-equal? (sign-read (open-input-string "[+]"))
              '(sign:fold +)
              "FOLD構文")

;; 5. MAP操作
(check-equal? (sign-read (open-input-string "[* 2,]"))
              '(sign:map (sign:partial-right * 2))
              "MAP構文")

(check-equal? (sign:expand ((eval (sign-read (open-input-string "[* 2,]")) ns) (sign:range 1 3)))
              '(2 4 6)
              "MAPの評価")

;; 6. 展開演算子 (~)
(check-equal? (sign-read (open-input-string "list~"))
              '(sign:expand list)
              "展開演算子構文")

(let ([s (sign:range 1 3)])
  (check-equal? (sign:expand s)
                '(1 2 3)
                "展開演算子の評価"))

;; 7. リスト結合（並置による余積）
(check-equal? (sign:expand (eval (sign-read (open-input-string "[1 ~ 3] [4 ~ 6]")) ns))
              '(1 2 3 4 5 6)
              "リスト結合（並置）")

(check-equal? (sign:expand (sign:app (sign:range 1 3) (sign:range 4 ~ 6)))
              '(1 2 3 4 5 6)
              "リスト結合（sign:app直接呼び出し）")

;; 8. 複合テスト
(check-equal? (sign:expand ((sign:map (sign:partial-right + 1)) (sign:range 1 3)))
              '(2 3 4)
              "Range + Map")

(printf "すべてのテストが成功しました！\n")
