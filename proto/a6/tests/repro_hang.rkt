#lang racket/base
(require srfi/41)

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

(display "Testing stream-cons in eval...\n")

(define code
  '(letrec ((s (lambda (n)
                 (if (> n 5)
                     stream-null
                     (stream-cons n (s (+ n 1)))))))
     (stream->list (s 1))))

(with-handlers ([exn:fail? (lambda (e) (display (exn-message e)) (newline))])
  (display (eval code ns))
  (newline))

(display "Done.\n")
