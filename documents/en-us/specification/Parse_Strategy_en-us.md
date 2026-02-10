# Sign Language Parser Design Core Points

## Core Principles of Sign Language


### Preliminaries…

```javascript

comment = /^`[^\r\n]$/gm

string = /`[^`\r\n]`/g

character = /\\[\s\S]/g

```

### Four Steps in Order

1. **String or not**
   - Parts enclosed by `` ` `` are protected as **string literals**
   - At this point, all characters inside strings are treated as "content"
   - Operators and whitespace inside strings have no operational meaning

2. **Character or not**
   - The single character immediately after `\` is protected as a **character literal**
   - Any character can be represented, including newline (`\↵`)
   - Like strings, designated newlines, spaces, and operators have no operational meaning

3. **Inside or outside a block**
   - Indentation depth = Block depth
   - Same-depth blocks are equivalent to being inside one set of parentheses; newlines are equivalent to space delimiters
   - The end of each block is identified by dedent

4. **Literal or symbol**
   - Since Sign language has no reserved words, this determination is extremely simple
   - Remaining unprotected tokens are either **values (literals)** or **operators (symbols)**
   - Numbers, identifiers → Literals
   - Other symbols → Operators

### Why This Principle is Revolutionary

1. **Extreme simplification of lexical analysis**
   - No complex state machines needed
   - Except inside strings (`\↵`, `\ `, `\	`), all tokens are delimited by spaces or newlines
   - No reason to separate the lexer

2. **Correspondence between syntax and meaning**
   - Block ≡ Stack
   - The form of a token directly indicates its role
   - Almost no context-dependent ambiguity

3. **Everything becomes binary type operations**
   - Block-internal parsing can be done later
   - The operator precedence table can be directly implemented as conditional branching functions
   - Recursive functions easily decompose down to pairs of binary operations
   - Making parsing lazy-evaluated prevents stack overflow
   - Everything is expressed as pairs of binary operations
   - Expressible as S-expressions

## Basic Design Principles

**Staged Transformation Strategy**: Sign notation → S-expression → Target optimization

**Zero Cost Domain Abstraction**: Achieving both theoretical elegance and implementation efficiency
- Sign → Sign staged text replacement
- AST is unnecessary (syntax corresponds to types)

## Parsing Process Flow

1. **Block formation**: Convert indentation structure or parenthesized notation to parenthesized structure
2. **Precedence**: Staged parenthesization from highest precedence
3. **Normalization**: Unify all operators into S-expressions

## Important Design Decisions

### Symbol Context Determination

**Precondition**: After the third stage (literal vs symbol determination), determine symbol position

**Whitespace delimitation is the sole determining factor**
- **Prefix operator**: No space between operator and target value (`!x`, `@data`)
- **Infix operator**: Spaces required before and after (`x + y`, `a | b`)
- **Postfix operator**: No space between target value and operator (`5!`, `list~`)

**Why whitespace is decisive**: In Sign language, whitespace itself functions as the "coproduct operator," so the presence or absence of whitespace has syntactic meaning.

## Precedence Processing Simplification

**Important implementation principle**: Unary operator precedence is higher than binary operators (※with exceptions)
- **Binary operators only**: Managed by the precedence table (`+`, `-`, `*`, `/`, `=`, `<`, etc.)
- **Unary operators (prefix/postfix)**:
   - The unary `~` must respect precedence with other operators because of its product-like nature, in both prefix and postfix forms.
   - Other unary operator precedence can be simplified:
      - Prefix: right unit element, right-associative
      - Postfix: left unit element, left-associative

**Implementation benefits**:
- Precedence table is greatly simplified
- Parser logic is simplified
- Error rate is reduced (prefix and postfix precedence in the operator table is type-aware, which can also be used for type checking)

**Processing order**:
1. Process all unary operators first (only distinguishing prefix/postfix)
2. Process remaining binary operators in precedence order

### Block Parsing Fundamental Principle

**Ambiguity elimination through literal constraints**
- **String literal**: Constraint of not containing newlines or `` ` ``
- **Character literal**: `\` + newline is protected as a single character token

**Why this constraint is decisive**:
- Newlines reliably function as boundaries
- Tab characters reliably function as "block structure"
- `` ` `` symbol reliably functions as "string boundary or comment start"

**Effective condition for block start**: Newline + indent
- **After `:` (define)**: Block for the definition value
- **After `?` (lambda)**: Block for the function body
- **Parentheses**: Explicit block expression
- **Indentation**: Explicit block expression

This fundamental design ensures indentation processing is uniquely determined and string content is never confused with block structure.
