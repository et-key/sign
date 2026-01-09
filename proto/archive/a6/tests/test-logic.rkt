#lang racket/base

(require rackunit
         "../reader.rkt"
         "../runtime.rkt")

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

;; ========================================
;; 真偽判定のテスト
;; ========================================

;; Unit (空リスト) は false
(check-false (sign:truthy? '()) "Unit は false")

;; それ以外は true
(check-true (sign:truthy? 1) "1 は true")
(check-true (sign:truthy? 0) "0 は true")
(check-true (sign:truthy? "text") "文字列 は true")
(check-true (sign:truthy? #t) "#t は true")

;; ========================================
;; not (!) のテスト
;; ========================================

(check-equal? (sign:not '()) 1 "!_ は 1 (true)")
(check-equal? (sign:not 1) '() "!1 は空リスト")
(check-equal? (sign:not 42) '() "!42 は空リスト")

;; ========================================
;; and (&) のテスト - 短絡評価
;; ========================================

;; 左辺が false なら右辺を評価せず '() を返す
(check-equal? (sign:and '() 42) '() "_ & 42 は空リスト")
(check-equal? (sign:and '() (error "should not evaluate")) '() 
              "左辺が false なら右辺を評価しない")

;; 左辺が true なら右辺を評価して返す
(check-equal? (sign:and 1 42) 42 "1 & 42 は 42")
(check-equal? (sign:and 5 10) 10 "5 & 10 は 10")

;; 両方 false
(check-equal? (sign:and '() '()) '() "_ & _ は空リスト")

;; ========================================
;; or (|) のテスト - 短絡評価
;; ========================================

;; 左辺が true ならそれを返す（右辺を評価しない）
(check-equal? (sign:or 1 42) 1 "1 | 42 は 1")
(check-equal? (sign:or 5 (error "should not evaluate")) 5
              "左辺が true なら右辺を評価しない")

;; 左辺が false なら右辺を返す
(check-equal? (sign:or '() 42) 42 "_ | 42 は 42")
(check-equal? (sign:or '() '()) '() "_ | _ は空リスト")

;; ========================================
;; xor (;) のテスト
;; ========================================

;; 片方だけ true
(check-equal? (sign:xor 1 '()) 1 "1 ; _ は 1")
(check-equal? (sign:xor '() 42) 42 "_ ; 42 は 42")

;; 両方 true または両方 false
(check-equal? (sign:xor 1 42) '() "1 ; 42 は空リスト")
(check-equal? (sign:xor '() '()) '() "_ ; _ は空リスト")

(displayln "すべての論理演算子テストが成功しました！")
