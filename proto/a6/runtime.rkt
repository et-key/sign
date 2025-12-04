#lang racket/base

(require srfi/41)  ; Streams

(provide (all-defined-out))

;; ========================================
;; 基本関数
;; ========================================

;; Unit判定
(define (sign:unit? x)
  (null? x))

;; 真偽判定（Unitがfalse、それ以外がtrue）
(define (sign:truthy? x)
  (not (null? x)))

;; ========================================
;; 比較演算子（値返却型）
;; ========================================

(define (sign:< x y)
  (if (< x y) x '()))

(define (sign:<= x y)
  (if (<= x y) x '()))

(define (sign:= x y)
  (if (equal? x y) x '()))

(define (sign:>= x y)
  (if (>= x y) x '()))

(define (sign:> x y)
  (if (> x y) x '()))

(define (sign:!= x y)
  (if (not (equal? x y)) x '()))

;; ========================================
;; 論理演算子（短絡評価）
;; ========================================

(define-syntax sign:and
  (syntax-rules ()
    [(_ x y)
     (let ([val x])
       (if (sign:truthy? val)
           y
           '()))]))

(define-syntax sign:or
  (syntax-rules ()
    [(_ x y)
     (let ([val x])
       (if (sign:truthy? val)
           val
           y))]))

(define (sign:xor x y)
  (let ([tx (sign:truthy? x)]
        [ty (sign:truthy? y)])
    (if (and (or tx ty) (not (and tx ty)))
        (if tx x y)
        '())))

(define (sign:not x)
  (if (sign:truthy? x) '() 1))

;; ========================================
;; 算術演算子
;; ========================================

;; 階乗
(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

;; 絶対値（既存のabsを使用）
(define sign:abs abs)

;; ========================================
;; リスト/Stream操作
;; ========================================


;; リスト構築（カンマ演算子用）
;; (sign:cons 1 2) -> (stream 1 2)
;; (sign:cons 1 (stream 2 3)) -> (stream 1 2 3)
(define (sign:cons x y)
  (if (stream? y)
      (stream-cons x y)
      (stream-cons x (stream-cons y stream-null))))

;; 範囲リスト生成（有限）
(define (sign:range start end)
  (if (<= start end)
      (stream-cons start (sign:range (+ start 1) end))
      stream-null))

;; 無限リスト生成
(define (sign:range-infinite start)
  (stream-cons start (sign:range-infinite (+ start 1))))



;; Get演算子
(define (sign:get obj key)
  (cond
    ;; リスト/Streamの場合、インデックスアクセス
    [(and (integer? key) (stream? obj))
     (if (and (>= key 0) (< key (stream-length obj)))
         (stream-ref obj key)
         '())]
    ;; 連想リストの場合、キーアクセス
    [(and (symbol? key) (list? obj))
     (let ([pair (assoc key obj)])
       (if pair (cdr pair) '()))]
    [else '()]))

;; MAP操作（カリー化対応）
(define (sign:map f)
  (lambda (lst)
    (stream-map f lst)))

;; FOLD操作（カリー化対応）
;; 仕様書 3.8: `[+] list` -> `(stream-fold + 0 list)`
(define (sign:fold op init)
  (lambda (lst)
    (stream-fold op init lst)))

;; リスト展開（Stream → List変換）
;; 仕様書 3.8: `list~` -> `(stream->list list)`
(define (sign:expand stream)
  (if (stream? stream)
      (stream->list stream)
      stream))

;; ========================================
;; ラムダ構築子（Phase 2）
;; ========================================

;; ラムダ構築マクロ（カリー化対応）
;; 使用例:
;;   (sign:? (x) (+ x 1))           → (lambda (x) (+ x 1))
;;   (sign:? (x y) (+ x y))         → (lambda (x) (lambda (y) (+ x y)))
;;   (sign:? () 42)                 → (lambda () 42)
(define-syntax sign:?
  (syntax-rules ()
    ;; 引数なし（定数関数）
    [(_ () body)
     (lambda () body)]
    ;; 単一引数
    [(_ (arg) body)
     (lambda (arg) body)]
    ;; 複数引数（カリー化）
    [(_ (arg args ...) body)
     (lambda (arg) (sign:? (args ...) body))]))

;; ========================================
;; ポイントフリー記法サポート（Phase 2）
;; ========================================

;; 部分適用（右オペランド固定）
;; 例: (sign:partial-right + 1) → (lambda (x) (+ x 1))
;; Sign記法: [+ 1]
(define (sign:partial-right op val)
  (lambda (x) (op x val)))

;; 部分適用（左オペランド固定）
;; 例: (sign:partial-left 1 -) → (lambda (x) (- 1 x))
;; Sign記法: [1 -]
(define (sign:partial-left val op)
  (lambda (x) (op val x)))

;; 関数合成
;; 例: (sign:compose f g) → (lambda (x) (f (g x)))
(define (sign:compose f g)
  (lambda (x) (f (g x))))
