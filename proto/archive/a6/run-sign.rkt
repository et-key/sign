#lang racket/base

(require "reader.rkt"
         "runtime.rkt")

;; Sign ファイルを読み込んで実行
(define (run-sign-file filename)
  (define content (call-with-input-file filename port->string))
  (define parsed (sign-read (open-input-string content)))
  (printf "Parsed:\n~a\n\n" parsed)
  
  ;; 直接 eval せずに、生成されたコードを表示
  (printf "Generated code can be evaluated in a proper module context.\n"))

(require racket/port)
(run-sign-file (build-path (current-directory) "proto" "a6" "simple.sn"))
