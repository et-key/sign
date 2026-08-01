# Sign String Literals and Comment Syntax

## Overview

Strings in Sign are always enclosed within backticks (`` ` ``).
The distinction between a comment and a string is determined by a **lookahead rule (presence of a closing backtick)**.

---

## 1. String Literals

### Definition

```
string = ` [^\n\r`]* `
```

Any sequence of characters delimited by backticks on both ends, excluding newlines (`\n`/`\r`) and backticks themselves.

```sign
greeting : `Hello, World!`   ` Bind string to greeting
message  : `Sign is elegant`
```

### Characteristics

- Strings are single-line (cannot span across newline boundaries directly).
- Empty strings are isomorphic to `__` (Unit).
- Backticks cannot be directly embedded inside strings (to prevent ambiguity with comment starts).

---

## 2. Comment Syntax

### Definition (Lookahead Rule)

```
comment = SOL ` [^\n\r`]* EOL        ← Start of line ` and NO closing ` → Comment
string  =     ` [^\n\r`]* `          ← Closing ` exists → String literal
```

> [!IMPORTANT]
> **Lookahead Rule**: Upon encountering a backtick, check whether a matching closing backtick exists on the same line.
> - **Closing backtick present** → String literal `` `[^\n\r`]*` ``
> - **No closing backtick** → Comment (extends until EOL)
>
> This enables zero reserved words and unambiguous distinction between strings and comments.

```sign
`This is a comment (no closing backtick → extends to EOL)
`main.sn`@~    ← Closing backtick present → `main.sn` is a string literal (import path)
x : `Hello`    ← Closing backtick present → String literal
```

### Why No Conflicts Occur

Under the syntactic invariant that "a bare string literal never starts at SOL without context", a backtick at the start of a line (SOL) unambiguously resolves to a comment or string based solely on the closing backtick:

```sign
`path/to/file`@~    ← Closing backtick present → String (import path)
` This is a comment  ← No closing backtick → Comment
```

---

## 3. Indented Backticks (Docstrings)

When a backtick follows an indent (tab/spaces), it does not start at SOL, so it is not parsed as a standard comment.
The lookahead rule applies:

```sign
calc_func : x ?
\t`Docstring (after tab, closing backtick present → evaluated as string but discarded)`
\tx * 2
```

Because this string is evaluated but not returned, it functions effectively as an inline comment.

---

## 4. Final Line Return Value

In Sign's execution model, **every file is a function** (see [impl/core/execution_model.md](../impl/core/execution_model.md)).

Therefore, **the final line (the last non-comment expression) of a file is the return value of that file**.

```sign
` greet.sn
name : `World`
`Hello, {name}!`    ← Final line: return value of this file
```

```sign
` calc.sn
add : x y ? x + y
mul : x y ? x * y

add 3 4    ← Final line: 7 is the return value of this file
```

---

## 5. Multiline Strings

Strings in Sign are **single-line** by default.

To work with multiline strings, use lists of strings or the coproduct concatenation operator (space):

```sign
` Constructing multiple strings
lines : `Line 1` `Line 2` `Line 3`   ` List construction

` Explicit newline character handling
text  : `Line 1` \
 `Line 2`
```

Note: In Sign, there is no need for traditional escape sequences. Any character immediately following `\` is treated literally as a character.

---

## 6. Relationship with Unicode

Strings can be treated as sequences of `0u` literals (Unicode Code Points):

```sign
` ASCII string
hello : `Hello`

` Accessing individual code points
h : `hello` ' 0   ` → \h (0u48)
```

---

## 7. Grammar Specification (Compiler Notes)

- Comments (unclosed backtick lines) may be stripped at the lexing stage.
- Syntax highlighters and Language Servers are recommended to color lines starting at SOL without a closing backtick as comments.
- PEG parsers evaluate the presence of a closing backtick via lookahead predicate.
- For detailed grammar specifications, see [impl/syntax/grammar.pegjs](../impl/syntax/grammar.pegjs).

---

## Design Rationale

- **Single backtick for both strings and comments** → Minimizes punctuation symbols without introducing reserved words or dedicated quote pairs.
- **Line scoping** → Enables static line-by-line token boundary parsing by the compiler.
- **Comment at SOL with unclosed backtick** → Visually explicit with zero reserved words.
- **Final line return** → Aligns directly with the "File = Function" execution model.
