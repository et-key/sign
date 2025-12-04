#lang racket/base

(require srfi/41
         "../runtime.rkt")

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

(display "Creating streams...\n")
(define s1 (eval '(sign:range 1 3) ns))
(define s2 (eval '(sign:range 4 6) ns))

(display "Stream 1: ")
(display (stream->list s1))
(newline)

(display "Stream 2: ")
(display (stream->list s2))
(newline)

(display "Appending streams (direct)...\n")
(define s3 (stream-append s1 s2))
(display "Result: ")
(display (stream->list s3))
(newline)

(display "Appending streams (eval)...\n")
(define s4 (eval `(stream-append ,s1 ,s2) ns)) ; s1, s2 are values, not expressions
(display "Result: ")
(display (stream->list s4))
(newline)
