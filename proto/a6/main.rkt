#lang racket/base

(require "reader.rkt"
         "runtime.rkt")

;; #lang sign で使用される
(provide (rename-out [sign-read read]
                     [sign-read-syntax read-syntax])
         ;; ランタイム関数をすべてエクスポート
         (all-from-out "runtime.rkt"))

;; モジュールリーダー
(module reader syntax/module-reader
  sign
  #:read sign-read
  #:read-syntax sign-read-syntax
  #:whole-body-readers? #t
  
  (require "reader.rkt"))
