# Tail Call Optimization (TCO) Specification

## Overview

Sign lacks loop keywords (`for`/`while`). Iteration is expressed exclusively via **recursion** and **range expressions**.

Preventing stack overflows in recursion is a language specification guarantee. The compiler converts tail-position function calls into `JMP` instead of `CALL` (**Tail Call Elimination / TCE**).

---

## 1. Tail Position Definition

In function `f`, any expression whose evaluation result becomes the direct return value of `f` is in **tail position**.

In Sign, the right-hand side of `?` (the function body) is evaluated, and the last expression evaluated in each `&`/`|` clause resides in tail position.

```sign
loop : n acc ?
    n = 0 & acc |         ` acc is tail position (value -> no TCO needed)
    loop (n - 1) (acc + n) ` loop is in tail position -> TCO target
```

---

## 2. `&`/`|` Clauses and Tail Positions

Both `then` and `else` clauses in `cond & then | else` reside in tail positions. Therefore, recursive calls in either clause are TCO targets.

```sign
collatz : n steps ?
    n = 1     & steps                           | ` Base case
    n % 2 = 0 & collatz (n / 2)      (steps + 1) | ` Even -> TCO
                collatz (n * 3 + 1) (steps + 1)   ` Odd  -> TCO
```

---

## 3. Mutual Recursion TCO

Mutual recursion between multiple functions is also subject to TCO if in tail position:

```sign
is_even : n ? n = 0 & 1  | is_odd  (n - 1)
is_odd  : n ? n = 0 & __ | is_even (n - 1)
```

Stack depth remains constant at $O(1)$ regardless of iteration count.

---

## 4. Range Expressions vs Recursion

Range expressions (`[1 ~ n]`) are directly compiled into target hardware loop instructions (`LOOP`/`JNZ`), serving as the preferred representation for sequence processing.

---

## 5. Specification Guarantee

TCO application for tail-position recursion is a **language specification guarantee**, not an optional optimization pass. No `@tailrec` annotations are required.
