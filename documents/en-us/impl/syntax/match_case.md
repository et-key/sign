# match_case Expression Specification

## Overview

> [!IMPORTANT]
> **Meaningful Difference by Block Type Immediately Following `?`**
>
> | Immediately Following `?` | Interpretation | Purpose |
> |---|---|---|
> | **Indented Block** (Tab indented) | `match_case` Expression | Conditional Branching |
> | **`[...]` Block** | Struct/List Literal | Constructors returning multiple fields |
>
> ```sign
> ` match_case (Indented block)
> f : x ?
> 	x < 0 : `negative`
> 	`non-negative`
>
> ` Struct Constructor ([...] block)
> Point : x y ? [
> 	x : x
> 	y : y
> ]
> ```
>
> The compiler unambiguously determines the syntax depending on whether the token immediately following `?` is `\x02` (virtual Indent token) or `[`.

---

## 1. Syntax

```
function_def ?
TAB   condition1 : result1
TAB   condition2 : result2
TAB   ...
TAB   default_result
```

- The block indented (using **TAB only; spaces are prohibited**) immediately following `?` is a `match_case` expression.
- Each arm is formatted as `condition : result` (`: ` serves as the arm separator).
- **The default case line contains only `result` without a condition**, and must be placed on the final line.

---

## 2. Comparison Operators in Conditions

Condition expressions in arms use comparison operators from the Operator Table:

| Operator | Precedence | Classification | Meaning |
|---|---|---|---|
| `=` | 12 | Arithmetic Comparison | Arithmetic Equality |
| `!=` | 12 | Arithmetic Comparison | Arithmetic Inequality |
| `<` | 12 | Arithmetic Comparison | Less Than |
| `<=` | 12 | Arithmetic Comparison | Less Than or Equal To |
| `>` | 12 | Arithmetic Comparison | Greater Than |
| `>=` | 12 | Arithmetic Comparison | Greater Than or Equal To |
| `==` | 8 | Structural Comparison | Structural Equality (Isomorphism) |
| `!==` | 8 | Structural Comparison | Structural Inequality |

Although `:` (precedence 2) serves as the arm separator, `=` (precedence 12) is evaluated first, eliminating syntactic ambiguity.

---

## 3. Examples

### Basic Numeric Comparison

```sign
compare : x y ?
	x = y : `equal`
	x < y : `less`
	`greater`           ` Default (when x > y)
```

### With Structural Comparison

```sign
check : a b ?
	a == b : `same structure`
	`different`
```

### Recursion + match_case (Automatic TCO Application)

```sign
collatz : n steps ?
	n = 1       : steps
	n % 2 = 0   : collatz (n / 2)      (steps + 1)
	              collatz (n * 3 + 1) (steps + 1)
```

Internally, tail-call recursive invocations within arms are automatically optimized via TCO into `JMP` instructions.

### Mutual Recursion + match_case

```sign
is_even : n ?
	n = 0 : 1
	is_odd (n - 1)

is_odd : n ?
	n = 0 : __
	is_even (n - 1)
```

---

## 4. Syntactic Constraints

- **Final default line is mandatory**: An empty block is a syntax error.
- **Do not write `:` in the default_case line** (no condition).
- **default_case line must be the final line**.
- **Indentation must use TABs only**: As a general rule in Sign, space indentation is invalid.
- **Struct literals inside condition expressions result in type errors**: Writing `[key : val]` directly inside an arm condition collides with the arm separator `:`. Bind to a variable prior to comparison.

```sign
` Error example
f : x ?
	`default`   ` ← Placing default first makes subsequent arms unreachable
	x = 0 : `zero`
```

---

## 5. Tail Call Optimization (TCO)

According to the TCO specification, recursive function calls at the tail position of any `match_case` arm are **automatically optimized via TCO**.

No special annotations or syntax are required.
