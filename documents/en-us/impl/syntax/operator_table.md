# Sign Language Operator Symbol Table (Priority Order)

## Basic Principles

- Prefix operators must be placed immediately before the target value (no space between operator and operand).
- Postfix operators must be placed immediately after the target value (no space between operand and operator).
- Infix operators must be placed between target values, separated by spaces on both sides.
- Expressed using only operators without reserved words.
- Declarations of identifiers by definition operators simultaneously construct types.
- Alignment of natural intuitive meanings with operational semantics of symbols.
- Arranged from lowest priority (evaluated later) to highest priority (evaluated first).
- Coproduct operators can be considered as simple delimiters, and all spaces are regarded as coproduct operators.
- Space can be regarded as delimiters because priority relationships with product operators can be determined in subsequent processing.
- Line breaks can also be considered as operators, in which case their function represents line-by-line evaluation.
- No space after opening absolute value bracket, and no space before closing bracket.
- No space after opening parenthesis, and no space before closing parenthesis.
- The relationship between lifting (generating and expanding) operators and lowering (folding) operators comprehensively determines types.
- Lowering (folding) operations cast to the left-hand side type.
- Since coproducts can be typed prior to code generation, Sign is a statically typed language.
- **Convergence of Undefined Identifiers to Unit (`__`)**: Any undefined identifier evaluates to `__` (empty coproduct / Unit). This foundational design allows virtual keywords and DSL writing without reserved words.
- **Unit Absorption & Asymmetry**: Detailed in the operator table.
- **Clear Distinction between `__` (Immediate Collapse) and `$__` (Deref/Unit behavior)**:
  - `__` is the absorbing element for function application, instantly collapsing expressions into `__`.
  - `$__` evaluates to `__` because `$` applied to Unit returns Unit (`$__ = __`).
- **Identifier Naming for Type Constructors**:
  - Type constructor function names MUST start with a capital letter (e.g., `Point`, `Red`).
  - Structs, enums, and constructors are declared with capital-starting identifiers.

---

## Complete Operator Table

- Right unit element: right-associative operators are marked with ※ in the position column.
- Precedence must be strictly respected: prefix or postfix operators where precedence is critical are marked with ※ in the priority column.

| Priority | Symbol | Position (Type Combination) | Function | Natural Meaning | Operational Semantics | LHS is Unit | RHS is Unit |
| :---: | :---: | :---: | :---: | --- | --- | --- | --- |
| 1 | `#` | prefix※ | export | Hashtag (discoverable) | Discoverable within project | / | Export Unit |
| 1 | `##` | prefix※ | export | Hashtag (discoverable) | Discoverable externally (ARC) | / | Export Unit |
| 1 | `###` | prefix※ | export | Hashtag (discoverable) | Discoverable externally (Pin region) | / | Export Unit |
| 2 | `:` | infixR※ | define | That is (A then B) | Bind left-hand identifier/condition to RHS | Absorber | `identifier : __` definable |
| 3 | `?` | infixR※ | lambda | Inquiry (how to do?) | Function definition | Nullary function | Can define function returning Unit |
| 4 | `#` | infix※ | output | Hashtag (association) | Store data at address, return address | Returns Unit | `0x00 # __` does nothing, returns address |
| 5 | `;` | infix | xor | Exclusive relationship | Exclusive Logical OR | RHS value X (Identity) | LHS value X (Identity) |
| 6 | `\|` | infix | or | Or (passage) | Logical OR (Short-circuit) | RHS value X (Identity) | LHS value X (Short-circuit) |
| 7 | `&` | infix | and | And (connection) | Logical AND (Short-circuit) | `__` (Short-circuit) | `__` (Absorber) |
| 8 | `===` | infix | same | Identity | Identity comparison operation | `__` (Absorber) | `__` (Absorber) |
| 8 | `==` | infix | equal | Equal | Structural comparison operation | `__` (Absorber) | `__` (Absorber) |
| 8 | `!==` | infix | xnot_equal | Not equal | Structural comparison operation | RHS value X (Identity) | LHS value X (Identity) |
| 9 | `,` | infixR※ | product | Product (structural assembly) | Right-associative list construction | Identity | Identity |
| 10.0 | ` ` | `Atom \| List \| Struct` infix `Atom \| List \| Struct` | construct | Arrange (concatenation) | Structure construction / concat | Identity | Identity |
| 10.1 | ` ` | `Atom \| List~` infix `Atom \| List~` | push<br>unshift | Arrange (concatenation) | Push to list | Identity | Identity |
| 10.2 | ` ` | `List~ \| Struct~` infix `List~ \| Struct~` | concat | Arrange (concatenation) | List/Struct concatenation | Identity | Identity |
| 10.3 | ` ` | `Atom \| List \| Struct` infix `Lambda` | apply | Reverse apply | Function application (apply_reverse) | Identity | Identity |
| 10.4 | ` ` | `Lambda` infix `Atom \| List \| Struct` | apply | Apply | Function application (apply) | Identity | Identity |
| 10.5 | ` ` | `Lambda` infix `Lambda` | compose | Left-associative function composition | Function composition | Identity | Identity |
| 11 | `~` | infix | range | Around (vicinity of range) | Range list construction | Absorber | Absorber |
| 11 | `~+` | infix | range | Around (vicinity of range) | Arithmetic progression specification | Absorber | Absorber |
| 11 | `~-` | infix | range | Around (vicinity of range) | Descending arithmetic progression specification | Absorber | Absorber |
| 11 | `~*` | infix | range | Around (vicinity of range) | Geometric progression specification | Absorber | Absorber |
| 11 | `~/` | infix | range | Around (vicinity of range) | Descending geometric progression specification | Absorber | Absorber |
| 11 | `~^` | infix | range | Around (vicinity of range) | Exponential progression specification | Absorber | Absorber |
| 12 | `<` | infix | less | Less than | Comparison operation | Absorber | Absorber |
| 12 | `<=` | infix | less_equal | Less than or equal to | Comparison operation | Absorber | Absorber |
| 12 | `=` | infix | equal | Equal | Comparison operation | Absorber | Absorber |
| 12 | `>=` | infix | more_equal | Greater than or equal to | Comparison operation | Absorber | Absorber |
| 12 | `>` | infix | more | Greater than | Comparison operation | Absorber | Absorber |
| 12 | `!=` | infix | not_equal | Not equal | Comparison operation | Identity | Identity |
| 13 | `+` | infix | add | Addition | Arithmetic operation | `__` (Absorber) | LHS value X (Identity) |
| 13 | `-` | infix | sub | Subtraction | Arithmetic operation | `__` (Absorber) | LHS value X (Identity) |
| 14 | `*` | infix | mul | Multiplication | Arithmetic operation | `__` (Absorber) | LHS value X (Identity) |
| 14 | `/` | infix | div | Division | Arithmetic operation | `__` (Absorber) | LHS value X (Identity) |
| 14 | `%` | infix | mod | Modulo | Arithmetic operation | `__` (Absorber) | LHS value X (Identity) |
| 15 | `^` | infix※ | pow | Power | Exponential operation | `__` (Absorber) | LHS value X (Identity) |
| 16 | `\|...\|` | surrounding | abs | Absolute value | Absolute value operation | / | Absorber |
| 17 | `'` | infix | possessive | Get from structure | Get value from structure | Absorber | Absorber |
| 17 | `@` | infix※ | get | at (in/at) | Get value from structure | Absorber | Absorber |
| 18 | `<<` | infix | left bit shift | Left bit shift | Left bit shift | `__` (Absorber) | LHS value X |
| 18 | `>>` | infix | right bit shift | Right bit shift | Right bit shift | `__` (Absorber) | LHS value X |
| 19 | `\|\|` | infix | bit or | Bitmask | Bitwise OR | `__` (Absorber) | LHS value X |
| 20 | `;;` | infix | bit xor | Bitmask | Bitwise XOR | `__` (Absorber) | LHS value X |
| 21 | `&&` | infix | bit and | Bitmask | Bitwise AND | `__` (Absorber) | LHS value X |
| 22 | `!` | postfix | factorial | Factorial | Factorial operation | Absorber | / |
| 22 ※ | `~` | postfix | expand | beginning ~ | Expansion | Absorber | / |
| 23 ※ | `~` | prefix※ | continuous | ~ end | Continuous list construction | / | Absorber |
| 23 | `!` | prefix※ | not | Negation | Logical negation | / | Id morphism (evaluated, non-Unit, truthy) |
| 23 | `$` | prefix※ | address | Money (value abstraction) | Address retrieval | / | `$__` returns `__` |
| 23 | `@` | prefix※ | input | at (in/at) | Get data from address | / | Absorber |
| 23 | `!!` | prefix※ | bit not | Bitwise inversion | Bitwise negation | / | Absorber |
| 24 | `@` | postfix | import | at (from ~) | Import from file | Absorber | / |
| 25 | `(...)` | surrounding | block | Block | Inline block construction | / | Absorber |
| 25 | `{...}` | surrounding | block | Block | Inline block construction | / | Absorber |
| 25 | `[...]` | surrounding | block | Block | Inline block construction | / | Absorber |
| 26 | `\t` | prefix | indent | Indent | Indent block construction | / | Absorber |

---

## Special Symbols

| Symbol | Function | Natural Meaning | Operational Semantics |
|:---:|:---:|---|---|
| `\` | Character specification | Character specification | Treats the next single character as a character literal |
| `` `...` `` | String | String | List of characters |
| `__` | Unit | Visible null value (explicit empty) | Empty list / identity morphism / unit element |
| `_` | Hole | Hole (missing part) | Placeholder used for partial application static desugaring |
| `"..."` | Volatile | Backend code direct insertion | Inline assembly insertion for specified target |

---

## Design Philosophy

- **Symbols Understandable by Everyone**: Prioritize intuitive understanding over mathematical rigor.
- **Correspondence with Natural Language**: Programs read like human-readable sentences.
- **Elimination of Reserved Words**: Avoid ambiguity of words and emphasize symbol clarity.
- **Metalanguage Functionality**: Any paradigm can be implemented as a function.
