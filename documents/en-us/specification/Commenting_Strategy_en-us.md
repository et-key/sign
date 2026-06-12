# Sign Comment Rules (Revised Edition)

## Basic Principles

Comments in the Sign language are synonymous with string literals starting at the beginning of a line.
Therefore, if a backtick (`` ` ``) exists at the beginning of a line, it becomes a comment, and a closing backtick (`` ` ``) is not required.

## Rule Definitions

A backtick ` must be specified at the beginning of the line.

```sign
calc_func : x ?
`	This functions as the function documentation (comment)`
	`↓ If you place a string on the last line of the return value block, that string becomes the return value`
	x * 2
```
-> The above string is evaluated but discarded, so it functions as a comment.

### B. Top Level
The top level can also be regarded as a single large block (or module definition).

```sign
`Module description`
x : 1
```
-> This string also does not affect the definition of `x`, so it functions as documentation.
(However, in a REPL environment, etc., the evaluation result might be displayed.)

### C. Concrete Examples

```sign
	`This is not treated as a comment`
	 `This is not a comment`
`	This is a comment`
	`The last line becomes the return value`
```

## Grammar Specification (refer to PEG)

- In the current PEG, all comments are parsed as `Comment`.
- Removing comments at the lexical analysis level is perfectly acceptable.
- Syntax highlighting and Language Server are recommended to display the text in comment colors **"when a backtick ` is specified at the very beginning of the line"**.
