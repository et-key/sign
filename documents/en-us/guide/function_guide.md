# Function Definition Guide in Sign

## 1. Function Definition Syntax

Functions in Sign are defined using the `?` operator and `:` binding operator:

```sign
add : x y ? x + y
add 3 5   ` → 8
```

- **Arguments**: Space-separated identifiers preceding `?`.
- **Variadic Arguments**: Indicated with a `~` prefix (e.g. `~xs`).

---

## 2. Conditional Branching (`match_case`)

Conditional branches in functions use tab-indented blocks (`match_case`):

```sign
classify : x ?
	x < 0 : `negative`
	x = 0 : `zero`
	`positive`
```

- Arms are specified as `condition : result`.
- The final line is the default result (without a condition).
- Indentation **must use TABs**.

---

## 3. Default Arguments

Default parameter values can be specified within parameter definitions:

```sign
g :
    x
    y : x + 1
  ? x + y
```

If `__` is passed for `y`, it automatically falls back to `x + 1`.
