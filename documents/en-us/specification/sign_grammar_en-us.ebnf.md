# Sign Language EBNF Grammar (proto/a7)

> [!NOTE]
> This grammar describes the Sign language as implemented in `proto/a7`.
> It covers lexical structure, expression grammar, and operator precedence.

---

## 1. Lexical Grammar

```ebnf
(* === Character Classes === *)
letter        = "a" | ... | "z" | "A" | ... | "Z" ;
digit         = "0" | "1" | ... | "9" ;
word_char     = letter | digit | "_" ;
symbol_char   = "!" | "#" | "$" | "%" | "&" | "'" | "*" | "+" | ","
              | "-" | "." | "/" | ":" | ";" | "<" | "=" | ">" | "?"
              | "@" | "^" | "|" | "~" | "\" ;

(* === Tokens === *)
integer       = [ "-" ] digit { digit } ;
float         = [ "-" ] digit { digit } "." digit { digit } ;
number        = float | integer ;

identifier    = ( letter | "_" ) { word_char } ;
              (* Note: lone "_" is parsed as Unit, not a variable *)

string        = "`" { any_char - newline } "`" ;

char_literal  = "\" any_char ;              (* e.g. \M \n \t *)

comment       = "`" { any_char - newline } newline ;
              (* A line starting with ` is a comment *)

unit          = "_" ;

(* === Whitespace & Structure === *)
newline       = "\n" | "\r\n" | "\r" ;
indent        = "\t" ;
separator     = newline ;
```

---

## 2. Operator Table

Operators sorted by **precedence** (lowest binds loosest → highest binds tightest).

| Prec | Symbol | Position | Function | Semantics |
|------|--------|----------|----------|-----------|
| 1 | `#` `##` `###` | prefix | export | Make name discoverable (scope level) |
| 2 | `:` | infixR | define | Bind name/condition to value |
| 3 | `#` | infix | output | Associate data with address |
| 4 | ` ` | infix | **apply** | Coproduct: function application |
| 5 | `?` | infixR | lambda | Function definition |
| 6 | `,` | infixR | product | Right-associative list construction |
| 7 | ` ` | infix | **compose** | Coproduct: function composition |
| 8 | ` ` | infix | **push/concat** | Coproduct: list push / concatenation |
| 9 | `~` `~+` `~-` `~*` `~/` `~^` | infix | range | Range / progression construction |
| 10 | `~` | prefix | continuous | Continuous list construction |
| 11 | `;` | infix | xor | Exclusive logical OR |
| 11 | `\|` | infix | or | Logical OR (short-circuit) |
| 12 | `&` | infix | and | Logical AND (short-circuit) |
| 13 | `!` | prefix | not | Logical negation |
| 14 | `<` `<=` `=` `==` `>=` `>` `!=` | infix | compare | Comparison (chainable) |
| 15 | `+` `-` | infix | add/sub | Arithmetic addition/subtraction |
| 16 | `*` `/` `%` | infix | mul/div/mod | Arithmetic multiply/divide/modulo |
| 17 | `^` | infixR | pow | Exponentiation |
| 18 | `!` | postfix | factorial | Factorial |
| 19 | `\|…\|` | enclosure | abs | Absolute value |
| 20 | `~` | postfix | expand | Expansion / evaluation |
| 21 | `$` | prefix | address | Address acquisition |
| 22 | `'` | infix | get | Get value from structure (left) |
| 22 | `@` | infixR | get | Get value from structure (right) |
| 23 | `@` | prefix | input | Read data from address |
| 24 | `<<` `>>` | infix | shift | Bit shift |
| 25 | `\|\|` | infix | bit_or | Bitwise OR |
| 26 | `;;` | infix | bit_xor | Bitwise XOR |
| 27 | `&&` | infix | bit_and | Bitwise AND |
| 28 | `!!` | prefix | bit_not | Bitwise NOT |
| 29 | `@` | postfix | import | Get from file |
| 30 | `(…)` `{…}` `[…]` | enclosure | block | Inline block |
| 30 | `\t` | prefix | indent | Indented block |
| 31 | `\` | prefix | escape | Treat next char as character literal |

---

## 3. Coproduct Boundary (Whitespace Multiplexing)

In Sign, **whitespace (space) is itself an operator** — the **coproduct operator**.
All spaces between tokens function as the coproduct boundary, and the meaning
is **multiplexed** (determined at semantic analysis time based on operand types):

```
Four meanings of the coproduct operator (SPACE):

  1. Function Application   func arg       add 5 3
  2. Function Composition    [f] [g] x      [+1] [*2] 5
  3. List Push / Concat      list1 list2    [1,2] [3,4]
  4. General Coproduct       expr1 expr2    x y z

Syntactically, these are all parsed identically as juxtaposition.
The distinction is made during semantic analysis, based on the
types of the operands (function, list, or value).
```

---

## 4. Operator Whitespace Rules

```
Whitespace determines operator notation (prefix / infix / postfix):

  Infix:    SPACE op SPACE     x + y     a | b     n ~ m
  Prefix:   SPACE op·operand   !x        ~expr     $var
  Postfix:  operand·op SPACE   n!        expr~     file@

  (· = no space, attached directly to operand)

This is how the parser disambiguates operators that appear in
multiple notations:
  !   → prefix (NOT)  vs  postfix (factorial)
  ~   → prefix (cont) vs  infix (range)  vs  postfix (expand)
  @   → prefix (deref) vs infix (access) vs  postfix (import)

Note: SPACE itself is the coproduct operator (§3), so spaces
serve double duty — both delimiting tokens AND acting as the
coproduct infix operator.
```

---

## 5. Expression Grammar (EBNF)

```ebnf
(* === Top-Level === *)
program        = block ;

(* === Block (indentation-based) === *)
block          = { line separator } ;
line           = expr ;

(* === Expressions (Pratt Parser — precedence climbing) === *)
(*
   expr(minPrec) parses an atom, then repeatedly:
   1. Checks for a postfix operator (op·SPACE) with prec >= minPrec
   2. Checks for an infix operator (SPACE·op·SPACE) with prec >= minPrec
   3. Otherwise, checks for juxtaposition (SPACE·atom) at prec 4
   Stops when no valid continuation is found.
*)

expr           = atom { postfix_tail | infix_tail | apply_tail } ;

postfix_tail   = postfix_op ;
infix_tail     = infix_op expr ;
apply_tail     = atom ;                        (* juxtaposition, prec 4 *)

(* === Operator Token Sets === *)

prefix_op      = "#" | "##" | "###"            (* IO channel *)
               | "!" | "!!"                    (* logical NOT / bitwise NOT *)
               | "$"                           (* address-of *)
               | "@"                           (* dereference / read *)
               | "~"                           (* continuous *)
               | "\"                           (* escape / char literal *)
               ;

infix_op       = ":"                           (* definition / conditional *)
               | "#"                           (* IO write / store *)
               | "?"                           (* lambda *)
               | ","                           (* pair / cons *)
               | "~"                           (* range *)
               | "~+" | "~-" | "~*" | "~/" | "~^"
               | ";"                           (* choice / XOR *)
               | "|"                           (* logical OR *)
               | "&"                           (* logical AND *)
               | "<" | "<=" | "=" | "==" | ">=" | ">" | "!="
               | "+" | "-"                     (* additive *)
               | "*" | "/" | "%"               (* multiplicative *)
               | "^"                           (* power *)
               | "'"                           (* access / nth *)
               | "@"                           (* reverse access *)
               | "<<" | ">>"                   (* bit shift *)
               | "||"                          (* bitwise OR *)
               | ";;"                          (* bitwise XOR *)
               | "&&"                          (* bitwise AND *)
               ;

postfix_op     = "!"                           (* factorial *)
               | "~"                           (* expand / run *)
               | "@"                           (* import *)
               ;

(* === Atoms === *)
atom           = number
               | string
               | char_literal
               | identifier
               | unit
               | abs_expr
               | bracket_expr
               | prefix_expr
               ;

prefix_expr    = prefix_op expr ;

(* === Absolute Value === *)
abs_expr       = "|" expr "|" ;

(* === Bracket Expression === *)
bracket_expr   = "[" block_content "]"
               | "(" block_content ")"         (* lexer normalizes to [ ] *)
               ;

block_content  = section | block ;

(* === Operator Sections === *)
section        = full_section
               | right_section
               | left_section
               ;

full_section   = infix_op ;                    (* [+]   → λx.λy. x + y *)
right_section  = infix_op expr ;               (* [+ 1] → λx. x + 1    *)
left_section   = expr infix_op ;               (* [1 +] → λx. 1 + x    *)
```

---

## 6. Syntactic Forms via Infix Operators

These are not separate grammar rules but particular uses of infix operators
handled by the Pratt parser. They are listed here for clarity.

```
Definition:     name : value              (:  prec 2, right)
Function Def:   name : params ? body      (: + ? combined)
Conditional:    guard : consequent        (:  prec 2, right)
Lambda:         params ? body             (?  prec 5, right)
Pair:           head , tail               (,  prec 6, right)
Application:    func arg                  (juxtaposition, prec 4, left)

Parameters:     x                         single parameter
                x , y , z                 multiple parameters via ","

Body:           single expr               on same line
                indented block            on next line(s) with deeper indent
```

---

## 7. Block Semantics (Multi-Expression)

```
When a block contains multiple expressions separated by newlines,
it acts as short-circuit OR (first non-Unit wins):

  expr1          -- if expr1 ≠ Unit → return expr1
  expr2          -- else evaluate expr2
  ...            -- else evaluate last expr
```

---

## 8. Indentation Rules

```
1. TAB characters at the start of a line determine indent level.
2. Increase in indent → open new nested block.
3. Decrease in indent → close current block(s).
4. Lines ending with an open operator (? : =) suppress the
   newline separator, allowing the indented block that follows
   to be parsed as the right-hand side of that operator.
5. Brackets [ ], parentheses ( ), braces { } create
   inline nested blocks. ( ) and { } are normalized to [ ].
```

---

## 9. Composition Rules

```
Application (f x) has two runtime behaviors:
  - If x is data  → call f(x)
  - If x is func  → compose: h(y) = x(f(y))

Operator sections also support composition:
  [+] f     → compose(section, f)
  [+] 3     → apply section to 3  (i.e. λy. 3 + y)
```

---

## 10. Truthiness Model

```
False  =  _ (Unit)       sentinel value
True   =  any ≠ Unit     (including 0, -1, etc.)

guard : body       evaluate body only if guard ≠ Unit
!x                 → Unit if truthy, 0 if falsy
a & b              → if a truthy then b, else Unit
a | b              → if a truthy then a, else b
a ; b              → if exactly one truthy → that one, else Unit
a < b              → if true → value, else Unit
```

---

## 11. Example Programs

```sign
` Factorial (recursive)
fact : n ?
	n < 2 : 1
	n * [fact n - 1]

1 # fact 5
```

```sign
` Composition with sections
1 # [+ 1] [* 2] 3      ` → 8  (3 → +1 → 4 → *2 → 8)
```

```sign
` Lambda and direct call
inc : n ? n + 1
1 # inc 20
```

```sign
` Absolute value
1 # |-5|
1 # |1 - 2| * 3
```

```sign
` Logical operators
1 # _ | 1               ` → 1
1 # 0 & 1               ` → 1  (0 is truthy)
```
