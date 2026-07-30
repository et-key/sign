# Algebraic Specification of Comparison Operator Value Returns and Chaining

## 1. Overview

In Sign, comparison operations (`<`, `>`, `<=`, `>=`, `=`, `!=`) return a specific operand's value when the condition is true, and `__` (Unit/Nothing) when false.

This document defines the value-based algebraic rules governing operand selection and ternary comparison chaining (`1 < x < 10`).

---

## 2. Evaluation Rules and Algebraic Dispatch

For a comparison operator `op` applied to `LHS` and `RHS`:

$$ V = \text{eval}(LHS \text{ op } RHS) = \begin{cases} 
\text{select}(LHS, RHS) & (\text{if condition is true}) \\
\text{\_\_} & (\text{if condition is false})
\end{cases} $$

The operand selection function $\text{select}(LHS, RHS)$ is defined based on the **evaluated value of LHS**:

$$\text{select}(LHS, RHS) = \begin{cases} 
RHS & (\text{value}(LHS) \in \{0, 1\}) \\
LHS & (\text{otherwise})
\end{cases}$$

- **Identity Element Exception Rule**: If the **Int value** of LHS is `0` (additive identity) or `1` (multiplicative identity), **RHS value** is returned.
- **General Rule**: Otherwise, **LHS value** is returned.

> [!IMPORTANT]
> The $\{0, 1\}$ check applies **exclusively to the Int domain**.
> Float numbers (`0.0`, `1.0`), raw addresses (`0r00`), and lists (`[0]`) are NOT subject to this exception.
> Structural comparison operators (`==` and `!==`) always return LHS on truthy, as identity elements do not apply to structural comparison.

---

## 3. Ternary Comparison Chaining (`L < C < R`)

Chaining three or more comparisons (e.g. `5 < x < 10`) is NOT evaluated as left-associative binary operations `(L < C) < R`. Instead, it is parsed directly into a special AST node `ChainCompare`.

### Rules for Chained Comparison

1. **Syntactic Constraint**: Chaining requires **identical comparison operators** (e.g. `A < B < C` or `A <= B <= C`). Mixed operators (e.g. `A < B > C`) result in syntax errors.
2. **Evaluation Logic**:
   - Evaluates adjacent pairs.
   - If ALL comparison pairs evaluate to true, **unconditionally returns the value of the central term (`C`)**.
   - If any pair evaluates to false, immediately returns `__` (Unit).

---

## 4. Examples & Applications

### Conditional Pipeline

```sign
` Returns x + 5 if x > 0, otherwise returns __
result : [x > 0] + 5
```

- When $x = 10$: `10 > 0` returns `10` (LHS is non-identity). `10 + 5` evaluates to `15`.
- When $x = -3$: `-3 > 0` evaluates to false, returning `__`. `__ + 5` collapses to `__`.

### Range Checking via Ternary Chaining

```sign
` Returns x if 1 < x < 10, otherwise returns __
valid_x : 1 < x < 10
```
- Parsed as `ChainCompare(1, <, x, <, 10)`. Evaluates to `x` when valid, and `__` when invalid.
