# Sign Language Operator Symbol Table (Priority Order)

## Basic Principles

- Prefix operators must be placed immediately before the target value (no space between operator and operand).
- Postfix operators must be placed immediately after the target value (no space between operand and operator).
- Infix operators must be placed between target values, separated by spaces on both sides.
- Expressed using only operators without reserved words.
- Natural meaning of symbols is aligned with operational meaning.
- Arranged from lowest priority (evaluated later) to highest priority (evaluated first).
- Coproduct operators can be considered as simple delimiters, and all spaces can be regarded as coproduct operators.
- The reason spaces can be regarded as delimiters is that the priority relationship with product operators can be appropriately determined in subsequent processing.
- Line breaks can also be considered as operators, in which case their function has the meaning of evaluation on a line-by-line basis.
- No space after opening absolute value bracket.
- No space before closing absolute value bracket.
- No space after opening parenthesis.
- No space before closing parenthesis.
- The relationship between lifting (generating and expanding) operators and lowering (folding) operators comprehensively determines types.
- Lowering (folding) operations cast to the left-hand side type.
- Since the corresponding typing can be done before code generation, this language is a statically typed language.

## Complete Operator Table

- Right unit element: right-associative operators are marked with ※ in the position column.
- Precedence must be strictly respected: prefix or postfix operators where precedence is critical are marked with ※ in the priority column.

When the position alone is insufficient, the combinations of types are also described.

| Priority | Symbol | Position (Type Combination) | Function | Natural Meaning | Operational Semantics |
| :---: | :---: | :---: | :---: | --- | --- |
| 1 | `#` | prefix※ | export | Hashtag (public/discoverable) | Make name discoverable from within the project |
| 1 | `##` | prefix※ | export | Hashtag (public/discoverable) | Make name discoverable from outside (corresponds to ARC) |
| 1 | `###` | prefix※ | export | Hashtag (public/discoverable) | Make name discoverable from outside (assuming no unload in Pin region) |
| 2 | `:` | infixR※ | define | That is (A then B) | Bind left-hand name or condition to right-hand expression |
| 3 | `?` | infixR※ | lambda | Inquiry (how to do?) | Function definition |
| 4 | `#` | infix※ | output | Hashtag (association) | Put data into address, return address if successful |
| 5 | `;` | infix | xor | Exclusive relationship | Exclusive logical OR |
| 6 | `|` | infix | or | Or (passage) | Logical OR (short-circuit evaluation) |
| 7 | `&` | infix | and | And (connection) | Logical AND (short-circuit evaluation) |
| 8 | `==` | infix | equal | Equal | Intra-structure comparison operation |
| 8 | `!==` | infix | xnot_equal | Not equal | Intra-structure comparison operation |
| 9 | `,` | infixR※ | product | Product (structural assembly) | Right-associative list construction |
| 10.0 | ` ` | `Atom \| List` infix `Lambda` | apply | Reverse apply | Function application |
| 10.1 | ` ` | `Lambda` infix `Atom \| List` | apply | Apply | Function application |
| 10.2 | ` ` | `Lambda` infix `Lambda` | compose | Left-associative function composition | Function composition |
| 10.3 | ` ` | `Atom \| List` infix `Atom \| List` | unshift <br> push <br> concat <br> construct | Arrange (concatenation) | Add to list or construct |
| 11 | `~` | infix | range | Around (vicinity of range) | Range list construction |
| 11 | `~+` | infix | range | Around (vicinity of range) | Arithmetic progression specification |
| 11 | `~-` | infix | range | Around (vicinity of range) | Descending arithmetic progression specification |
| 11 | `~*` | infix | range | Around (vicinity of range) | Geometric progression specification |
| 11 | `~/` | infix | range | Around (vicinity of range) | Descending geometric progression specification |
| 11 | `~^` | infix | range | Around (vicinity of range) | Exponential progression specification |
| 12 | `<` | infix | less | Less than | Comparison operation |
| 12 | `<=` | infix | less_equal | Less than or equal to | Comparison operation |
| 12 | `=` | infix | equal | Equal | Comparison operation |
| 12 | `>=` | infix | more_equal | Greater than or equal to | Comparison operation |
| 12 | `>` | infix | more | Greater than | Comparison operation |
| 12 | `!=` | infix | not_equal | Not equal | Comparison operation |
| 13 | `+` | infix | add | Addition | Arithmetic operation |
| 13 | `-` | infix | sub | Subtraction | Arithmetic operation |
| 14 | `*` | infix | mul | Multiplication | Arithmetic operation |
| 14 | `/` | infix | div | Division | Arithmetic operation |
| 14 | `%` | infix | mod | Modulo | Arithmetic operation |
| 15 | `^` | infix※ | pow | Power | Exponential operation |
| 16 | `|...|` | surrounding | abs | Absolute value | Absolute value operation |
| 17 | `'` | infix | possessive (s omitted from 's) | Get from structure | Get value from structure |
| 17 | `@` | infix※ | get | at (in/at) | Get value from structure |
| 18 | `<<` | infix | left bit shift | Left bit shift | Left bit shift |
| 18 | `>>` | infix | right bit shift | Right bit shift | Right bit shift |
| 19 | `||` | infix | bit or | Bitmask | Bitwise OR |
| 20 | `;;` | infix | bit xor | Bitmask | Bitwise XOR |
| 21 | `&&` | infix | bit and | Bitmask | Bitwise AND |
| 22 | `!` | postfix | factorial | Factorial | Factorial operation |
| 22※ | `~` | postfix | expand | beginning ~ | Expansion |
| 22 | `@` | postfix | import | at (from ~) | Get from file |
| 23※ | `~` | prefix※ | continuous | ~ end | Continuous list construction |
| 23 | `!` | prefix※ | not | Negation | Logical negation |
| 23 | `$` | prefix※ | address | Money (abstraction of value) | Address retrieval |
| 23 | `@` | prefix※ | input | at (in/at) | Get data from address |
| 23 | `!!` | prefix※ | bit not | Bitwise inversion | Bitwise negation |
| 24 | `(...)` | surrounding | block | Block | Inline block construction |
| 24 | `{...}` | surrounding | block | Block | Inline block construction |
| 24 | `[...]` | surrounding | block | Block | Inline block construction |
| 25 | `\t` | prefix | indent | Indent | Indent block construction |
| 26 | `\` | prefix | escape | Characterize | Treat the next single character as a character |

- Conditional branching is expressed using match_case expressions (represented by the function's block syntax) or short-circuit evaluation of logical operations.
- If you want to perform function composition with right-associativity, use parentheses to make it explicit.

## Special Symbols

| Symbol | Function | Natural Meaning | Operational Semantics |
| :---: | :---: | --- | --- |
| `__` | unit | Visible null value (explicit empty) | Empty list / identity morphism / unit element |
| `"..."` | meta description | Meta description | ASM_Volatile if immediately followed by block start, otherwise under verification |

## Design Philosophy

- **Symbols understandable by everyone**: Prioritize intuitive understanding over mathematical rigor.
- **Correspondence with natural language**: Programs can be read like text.
- **Elimination of reserved words**: Avoid ambiguity of word meanings and emphasize the clarity of symbols.
- **Functioning as a metalanguage**: Any language paradigm can be implemented as a function.
