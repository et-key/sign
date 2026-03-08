# Sign Language Commenting Rules (Revised Edition)

## Basic Principle

Comments in the Sign language are defined **not as "special syntactic markers" but as "literals whose evaluation results are not used"**.
This allows the structure of the code itself to function as documentation.

## Rule Definitions

### 1. String literals are always "values"
Strings enclosed in backquotes (`` ` ``), or strings from an unclosed backquote to the end of the line, are all parsed as "string literals".

### 2. "Unused" literals are considered comments
In the execution of a program, if a value is not bound to anything, has no side effects (such as output), and is not a return value, that literal essentially becomes a comment.

## Application Examples

### A. Inside a block (`\t` indent)
A block is a sequence of multiple expressions, and **only the last expression** becomes the return value of the block.
If any expression before it is an isolated literal without any effect, it is ignored.

```sign
calc_func : x ?
	`This functions as the documentation (comment) for the function`
	`↓This becomes the return value. Placing a string on the last line makes that string the return value`
	x * 2
```
-> The strings above are evaluated, but since they are discarded, they function as comments.

### B. Top level
The top level can also be considered as one large block (or module definition).

```sign
`Module description`
x : 1
```
-> This string also does not affect the definition of `x`, so it functions as documentation.
(However, in environments like REPL, the evaluation result may be displayed)

### C. Interpretation of user-presented examples

```sign
    `This is not treated as a comment`
	 `This is not a comment`
	`This is a comment`
	`This becomes the return value`
```

1. **No indent (or spaces)**: Depending on the context, it is evaluated as an expression. If it is on the right side of a definition, it becomes a value.
2. **`\t` Indent**: Indicates the start of a block. A string **at the beginning** of a block becomes a "discarded value" if there is a subsequent expression, making it a comment.

## Resolution of Contradictions
In the old version, we stated that "indented string literals are errors", but this has been abolished.
Currently, **"it is valid to write string literals within an indented block, and they are treated as comments as long as they are not the return value"**.

## Grammar Specification (See PEG)

Everything is parsed as an `Expression`.
- There is no independent syntax node called `Comment` (except for comments that disappear at the lexical analysis level).
- It is recommended that Syntax highlighting and Language Servers display **"string literals other than the last one in a block"** in comment colors.