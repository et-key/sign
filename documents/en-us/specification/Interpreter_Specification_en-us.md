# Sign Language Interpreter Specification: Implementation via Racket `#lang`

## 1. Overview

The Sign language interpreter is implemented based on Racket's `#lang` facility. This allows Sign language syntax to be written directly, enabling a practical implementation that leverages Racket's powerful ecosystem.

### 1.1 Design Policy

```
#lang sign
    ↓
[Reader] Sign syntax → S-expression conversion (infix → prefix)
    ↓
[Expander] Macro expansion / syntax transformation
    ↓
[Racket Evaluator] Execution
    ↓
Result
```

### 1.2 Reasons for Adopting `#lang`

| Challenge | Solution via `#lang` |
|-----------|---------------------|
| Reading infix notation | Convert to prefix notation at Reader stage |
| Sign-unique syntax | Fully custom syntax definable |
| Error messages | Display errors in Sign language context |
| IDE integration | Integration with DrRacket |
| Staged development | Fallback to Racket possible |

### 1.3 Why Racket/Scheme is Optimal for Sign Language

| Sign Language Feature | Racket Equivalent |
|----------------------|-------------------|
| List-based unified data model | Lists are first-class objects |
| No reserved words (all operators) | Complete support via Reader + macros |
| Tail recursion guarantee | Guaranteed by specification |
| Pull-based evaluation | Stream/SRFI-41 |
| Pure functional orientation | Naturally supported |
| Infix notation | Supported via `#lang` Reader extension |

## 2. Project Structure

### 2.1 Directory Layout

```
sign-lang/
├── info.rkt                 ;; Package information
├── main.rkt                 ;; #lang sign entry point
├── reader.rkt               ;; Sign syntax → S-expression conversion (infix → prefix)
├── parser.rkt               ;; Detailed parsing
├── expander.rkt             ;; Sign syntax macro expansion
├── runtime.rkt              ;; Runtime library
├── operators.rkt            ;; Operator definitions and precedence
├── stream.rkt               ;; Stream/Generator implementation
└── tests/
    ├── test-basic.rkt
    ├── test-operators.rkt
    ├── test-functions.rkt
    └── test-streams.rkt
```

### 2.2 Usage Image

```scheme
#lang sign

` This is Sign language code
add : x y ? x + y
result : add 3 5

numbers : [1 ~ 10]
doubled : [* 2,] numbers
sum : [+] doubled
```

## 3. `#lang` Implementation Details

### 3.1 info.rkt (Package Definition)

```scheme
#lang info

(define collection "sign")
(define deps '("base" "srfi-lite-lib"))
(define build-deps '("rackunit-lib"))
```

### 3.2 main.rkt (Language Entry Point)

```scheme
#lang racket/base

(require "reader.rkt"
         "expander.rkt"
         "runtime.rkt")

;; Used for #lang sign
(provide (rename-out [sign-read read]
                     [sign-read-syntax read-syntax])
         (except-out (all-from-out "runtime.rkt")))
```

### 3.3 reader.rkt (Sign Syntax Reader)

```scheme
#lang racket/base

(require racket/port
         racket/string
         racket/list)

(provide sign-read
         sign-read-syntax)

;; Operator precedence table
(define operator-precedence
  (hash
   ":"  2   ; define
   "#"  3   ; output
   ","  6   ; product
   "?"  5   ; lambda
   "~"  9   ; range
   "|"  11  ; or
   ";"  11  ; xor
   "&"  12  ; and
   "<"  14  "<=" 14  "="  14  ">=" 14  ">"  14  "!=" 14
   "+"  15  "-"  15
   "*"  16  "/"  16  "%"  16
   "^"  17
   "'"  22  "@"  22))

;; Right-associative operators
(define right-associative
  (set ":" "?" "^" ","))

;; Read Sign syntax and convert to S-expression
(define (sign-read in)
  (define source (port->string in))
  (define lines (sign-tokenize source))
  (define sexp (sign-parse lines))
  sexp)

;; Read with source position information
(define (sign-read-syntax src in)
  (define sexp (sign-read in))
  (datum->syntax #f sexp (list src 1 0 1 0)))
```

### 3.4 Tokenization

```scheme
;; Stage 1: String protection
(define (protect-strings source)
  (define strings '())
  (define result
    (regexp-replace* #px"`[^`\n\r]*`"
                     source
                     (λ (match)
                       (set! strings (append strings (list match)))
                       (format "__STRING_~a__" (sub1 (length strings))))))
  (values result strings))

;; Stage 2: Character protection
(define (protect-chars source)
  (define chars '())
  (define result
    (regexp-replace* #px"\\\\."
                     source
                     (λ (match)
                       (set! chars (append chars (list match)))
                       (format "__CHAR_~a__" (sub1 (length chars))))))
  (values result chars))

;; Stage 3: Tokenization
(define (sign-tokenize source)
  (define-values (s1 strings) (protect-strings source))
  (define-values (s2 chars) (protect-chars s1))
  (define s3 (regexp-replace* #px"^`[^\n\r]*" s2 ""))
  (define lines (string-split s3 #px"[\r\n]+"))
  (for/list ([line lines]
             #:when (not (string=? (string-trim line) "")))
    (tokenize-line line strings chars)))
```

### 3.5 Parsing (Infix → Prefix Conversion)

```scheme
;; Shunting-yard algorithm for infix → prefix conversion
(define (sign-parse tokenized-lines)
  (define result '())
  (for ([line tokenized-lines])
    (match-define (list indent tokens) line)
    (define parsed (parse-expression tokens))
    (set! result (append result (list parsed))))
  (if (= (length result) 1)
      (car result)
      (cons 'begin result)))

(define (infix->prefix tokens)
  (define output '())
  (define operators '())
  ;; ... Shunting-yard implementation ...
  ;; See Interpreter_Specification_ja-jp.md for full implementation
  )
```

### 3.6 expander.rkt (Macro Expansion)

```scheme
#lang racket/base

(require (for-syntax racket/base
                     syntax/parse))

(provide sign-define sign-lambda sign-if sign-and sign-or sign-compare)

;; Sign define → Racket define
(define-syntax (sign-define stx)
  (syntax-parse stx
    [(_ name:id value)
     #'(define name value)]))

;; Sign lambda → Racket lambda (curried)
(define-syntax (sign-lambda stx)
  (syntax-parse stx
    [(_ (param:id) body)
     #'(λ (param) body)]
    [(_ (param:id params:id ...) body)
     #'(λ (param) (sign-lambda (params ...) body))]))

;; Sign logical AND (lazy evaluation)
(define-syntax (sign-and stx)
  (syntax-parse stx
    [(_ left right)
     #'(let ([l left])
         (if (sign-truthy? l) right '()))]))

;; Sign logical OR (lazy evaluation)
(define-syntax (sign-or stx)
  (syntax-parse stx
    [(_ left right)
     #'(let ([l left])
         (if (sign-truthy? l) l right))]))

;; Sign comparison (value-returning)
(define-syntax (sign-compare stx)
  (syntax-parse stx
    [(_ op left right)
     #'(if (op left right) left '())]))
```

## 4. Evaluation Model: Pull-based Evaluation

### 4.1 Basic Principles

Sign language "lazy evaluation" is not full lazy evaluation but **Pull-based evaluation**:

- All lists are potentially infinite
- Values are generated at the point of need
- Generator/Iterator pattern is fundamental

### 4.2 Static Determination of Evaluation Strategy

Positions where evaluation delay is needed are **statically determinable from syntax**:

| Syntax Position | Evaluation Strategy | Reason |
|----------------|--------------------|----|
| Right-hand side of `&` | Lazy | Short-circuit (unnecessary if left is false) |
| Right-hand side of `\|` | Lazy | Short-circuit (unnecessary if left is true) |
| Right-hand side of `:` (in conditional) | Lazy | Needed only when condition holds |
| Right-hand side of `?` (lambda body) | Lazy | Not needed until application |
| Mutually recursive functions | Lazy | Avoid infinite loops |
| Open-ended lists | Stream | Iterator generation |
| Everything else | Strict | Always needed |

### 4.3 Implementation in Scheme

```scheme
;; Sign language lists implemented as Scheme Streams
(require srfi/41)  ; Stream library

;; Infinite list example
;; Sign: naturals : [1 ~ ]
(define naturals
  (stream-cons 1 (stream-map add1 naturals)))

;; MAP operation
;; Sign: [* 2,] naturals
(define evens
  (stream-map (lambda (x) (* x 2)) naturals))

;; FOLD operation (consume only what's needed)
;; Sign: [+] [1 ~ 10]
(stream-fold + 0 (stream-take 10 naturals))
```

## 5. Sign Syntax to S-expression Conversion Rules

### 5.1 Literal Conversion

| Sign | S-expression | Notes |
|------|-------------|-------|
| `42` | `42` | Numbers as-is |
| `-3.14` | `-3.14` | Floating point |
| `0xAF` | `#xAF` | Hexadecimal |
| `0o77` | `#o77` | Octal |
| `0b1010` | `#b1010` | Binary |
| `` `string` `` | `"string"` | String |
| `\n` | `#\n` | Character |
| `_` | `'()` | Unit (empty list) |

### 5.2 Arithmetic Operators

| Sign | S-expression |
|------|-------------|
| `x + y` | `(+ x y)` |
| `x - y` | `(- x y)` |
| `x * y` | `(* x y)` |
| `x / y` | `(/ x y)` |
| `x % y` | `(modulo x y)` |
| `x ^ y` | `(expt x y)` |
| `x!` | `(factorial x)` |
| `\|x\|` | `(abs x)` |

### 5.3 Comparison Operators (Value-Returning)

Sign language comparisons return the variable value when true:

```scheme
(define (sign:< x y)  (if (< x y) x '()))
(define (sign:<= x y) (if (<= x y) x '()))
(define (sign:= x y)  (if (equal? x y) x '()))
(define (sign:>= x y) (if (>= x y) x '()))
(define (sign:> x y)  (if (> x y) x '()))
(define (sign:!= x y) (if (not (equal? x y)) x '()))
```

### 5.4 Logical Operators (Short-Circuit)

```scheme
;; Unit (empty list) is false, everything else is true
(define (sign:truthy? x) (not (null? x)))

(define (sign:and x y-delayed)
  (if (sign:truthy? x) (force y-delayed) '()))

(define (sign:or x y-delayed)
  (if (sign:truthy? x) x (force y-delayed)))

(define (sign:xor x y)
  (let ((tx (sign:truthy? x))
        (ty (sign:truthy? y)))
    (if (and (or tx ty) (not (and tx ty)))
        (if tx x y) '())))

(define (sign:not x)
  (if (sign:truthy? x) '() #t))
```

### 5.5 Function Definitions

| Sign | S-expression |
|------|-------------|
| `x ? x + 1` | `(lambda (x) (+ x 1))` |
| `x y ? x + y` | `(lambda (x) (lambda (y) (+ x y)))` |
| `~rest ? ...` | `(lambda rest ...)` |

### 5.6 List Operations

| Sign | S-expression | Description |
|------|-------------|-------------|
| `1, 2, 3` | `(stream 1 2 3)` | List construction |
| `[1 ~ 5]` | `(sign:range 1 5)` | Range list |
| `[1 ~ ]` | `(sign:range-infinite 1)` | Infinite list |
| `list1 list2` | `(stream-append list1 list2)` | List concatenation |
| `[* 2,] list` | `(stream-map (lambda (x) (* x 2)) list)` | MAP |
| `[+] list` | `(stream-fold + 0 list)` | FOLD |
| `list ' 0` | `(stream-ref list 0)` | Index access |
| `list~` | `(stream->list list)` | Expand |

## 6. Runtime Library

### 6.1 Basic Functions

```scheme
(require srfi/41)  ; Streams

(define (sign:unit? x) (null? x))
(define (sign:truthy? x)
  (and (not (null? x))
       (not (procedure? x))))  ; Unapplied functions are false

(define (factorial n)
  (if (<= n 1) 1 (* n (factorial (- n 1)))))

(define (sign:compose f g)
  (lambda (x) (f (g x))))
```

### 6.2 List Operations Library

```scheme
(define (sign:map f) (lambda (stream) (stream-map f stream)))
(define (sign:fold f) (lambda (stream) (stream-fold f (stream-car stream) (stream-cdr stream))))
(define (sign:filter pred) (lambda (stream) (stream-filter pred stream)))

(define (sign:head stream) (if (stream-null? stream) '() (stream-car stream)))
(define (sign:tail stream) (if (stream-null? stream) '() (stream-cdr stream)))
```

### 6.3 Pointfree Notation Support

```scheme
(define sign:+ +)
(define sign:- -)
(define sign:* *)
(define sign:/ /)

;; Partial application (right operand fixed)
(define (sign:partial-right op val) (lambda (x) (op x val)))

;; Partial application (left operand fixed)
(define (sign:partial-left op val) (lambda (x) (op val x)))

;; Example: [+ 1] → (sign:partial-right + 1)
;; Example: [1 -] → (sign:partial-left - 1)
```

## 7. REPL Implementation

```scheme
#lang racket/base

(require "reader.rkt" "runtime.rkt" racket/port)
(provide sign-repl)

(define (sign-repl)
  (displayln "Sign Language REPL (Racket #lang implementation)")
  (displayln "Type :quit to exit, :help for help\n")
  (repl-loop (make-base-namespace)))

(define (repl-loop ns)
  (display "sign> ")
  (flush-output)
  (define input (read-line))
  (cond
    [(eof-object? input) (displayln "\nGoodbye!")]
    [(equal? input ":quit") (displayln "Goodbye!")]
    [(equal? input ":help") (display-help) (repl-loop ns)]
    [else
     (with-handlers
       ([exn:fail? (λ (e) (displayln (format "Error: ~a" (exn-message e))))])
       (define sexp (sign-read (open-input-string input)))
       (define result (eval sexp ns))
       (display "=> ")
       (sign-print result)
       (newline))
     (repl-loop ns)]))
```

## 8. Implementation Roadmap

### Phase 1: Minimal `#lang` Implementation
- [ ] Create project structure
- [ ] info.rkt / main.rkt setup
- [ ] Basic Reader (string/character protection, tokenization)
- [ ] Infix → prefix conversion (arithmetic operations only)
- [ ] Basic runtime (arithmetic, comparison)
- [ ] Simple REPL

### Phase 2: Function Definition and Application
- [ ] Lambda constructor (? operator)
- [ ] Currying support
- [ ] Define operator (:)
- [ ] Function application (coproduct)
- [ ] Pointfree notation

### Phase 3: List Operations and Streams
- [ ] Finite list construction
- [ ] Stream-based infinite lists
- [ ] Range list (~ operator)
- [ ] MAP/FOLD operations
- [ ] Expand operator (~postfix)

### Phase 4: Control Structures
- [ ] Logical operators (short-circuit evaluation)
- [ ] Conditional branching (match_case)
- [ ] Block syntax (indentation)
- [ ] Continuous arguments (~prefix)

### Phase 5: Module System
- [ ] Export operator
- [ ] Import operator
- [ ] File-level scope

### Phase 6: Development Environment Integration
- [ ] DrRacket syntax highlighting
- [ ] Sign language error messages
- [ ] Debug support
- [ ] Documentation generation

## 9. Test Specification

### 9.1 Basic Tests

```scheme
(check-equal? (sign:interpret "42") 42)
(check-equal? (sign:interpret "_") '())
(check-equal? (sign:interpret "1 + 2") 3)
(check-equal? (sign:interpret "3 * 4 + 2") 14)
(check-equal? (sign:interpret "2 ^ 10") 1024)
(check-equal? (sign:interpret "5!") 120)
(check-equal? (sign:interpret "|−5|") 5)
```

### 9.2 Comparison & Logic Tests

```scheme
(check-equal? (sign:interpret "3 < 5") 3)
(check-equal? (sign:interpret "5 < 3") '())
(check-equal? (sign:interpret "_ & 1") '())
(check-equal? (sign:interpret "1 & 2") 2)
(check-equal? (sign:interpret "_ | 1") 1)
(check-equal? (sign:interpret "1 | 2") 1)
(check-equal? (sign:interpret "!_") #t)
(check-equal? (sign:interpret "!1") '())
```

### 9.3 Function Tests

```scheme
(check-equal? (sign:interpret "f : x ? x + 1\nf 5") 6)
(check-equal? (sign:interpret "add : x y ? x + y\nadd 3 5") 8)
(check-equal? (sign:interpret "[+ 1] 5") 6)
(check-equal? (sign:interpret "[+] 1 2 3 4 5") 15)
```

### 9.4 List Tests

```scheme
(check-equal? (sign:interpret "[+] [1 ~ 10]") 55)
(check-equal?
  (stream->list (sign:interpret "[* 2,] [1 ~ 5]"))
  '(2 4 6 8 10))
(check-equal?
  (stream-ref (sign:interpret "[1 ~ ]") 99)
  100)
```

## 10. Summary

### 10.1 Design Key Points

1. **Implementation via Racket `#lang`**
   - Infix → prefix conversion at Reader stage
   - Sign language syntax can be written directly
   - Development environment via DrRacket integration

2. **Evaluation strategy determination from syntax**
   - Positions requiring delay are statically determinable
   - Macros automatically insert delays
   - Programmers need not be aware of evaluation strategy

3. **Generator/Iterator model**
   - All lists are potentially infinite
   - Values generated on demand (Pull-based)
   - Consistency with data flow model

### 10.2 References

- [Racket `#lang` Documentation](https://docs.racket-lang.org/guide/languages.html)
- [Beautiful Racket](https://beautifulracket.com/) - `#lang` implementation tutorial
- [Racket Reader Extension](https://docs.racket-lang.org/reference/reader.html)
