#lang racket/base

(require "reader.rkt"
         "runtime.rkt"
         racket/port
         racket/string)

(provide sign-repl)

(define (sign-repl)
  (displayln "Sign Language REPL (Racket #lang implementation)")
  (displayln "Type :quit to exit, :help for help\n")
  (repl-loop (make-base-namespace)))

(define (repl-loop ns)
  (display "sign> ")
  (flush-output)
  (define raw-input (read-line))
  (define input (if (string? raw-input) (string-trim raw-input) raw-input))
  (cond
    [(eof-object? input)
     (displayln "\nGoodbye!")]
    [(equal? input ":quit")
     (displayln "Goodbye!")]
    [(equal? input ":help")
     (display-help)
     (repl-loop ns)]
    [(equal? input "")
     (repl-loop ns)]
    [else
     (with-handlers
       ([exn:fail? (λ (e)
                     (displayln (format "Error: ~a" (exn-message e))))])
       (define sexp (sign-read (open-input-string input)))
       (displayln (format "Parsed: ~a" sexp))
       (define result (eval sexp ns))
       (display "=> ")
       (sign-print result)
       (newline))
     (repl-loop ns)]))

(define (display-help)
  (displayln "
Sign Language REPL Commands:
  :quit    Exit the REPL
  :help    Show this help

Sign Language Examples:
  x : 42              Define x as 42
  add : x y ? x + y   Define a function
  add 3 5             Apply function (returns 8)
  [* 2,] [1 ~ 5]      Map: double each element
  [+] [1 ~ 10]        Fold: sum of 1 to 10
"))

;; Sign形式での結果表示
(define (sign-print value)
  (cond
    [(null? value) (display "_")]
    [(string? value) (printf "`~a`" value)]
    [(char? value) (printf "\\~a" value)]
    [(procedure? value) (display "[function]")]
    [else (display value)]))

;; REPLを起動
(module+ main
  (sign-repl))
