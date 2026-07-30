# Categorical Truth Values Specification in Sign

## 1. Overview

In Sign, truth values are grounded in category-theoretic principles:

- **`__` (Unit / Empty List / Unevaluated Lambda)** : Represents **False**.
- **All other values (including numeric `0`)** : Represent **True**.

---

## 2. Theoretical Foundation & SKI Combinators

In the SKI combinator framework:
- **False (`__`)**: Equivalent to $K^*$ combinator ($\lambda x. \lambda y. y$, absorbs arguments).
- **True (Non-Unit Value / Id Morphism)**: Equivalent to $K$ combinator ($\lambda x. \lambda y. x$, passes LHS value).

Because numeric `0` is the initial object in category theory and an active numeric value in arithmetic, it is not "nothing" and thus evaluates to **True**.

---

## 3. Semantics of Negation (`!`)

Prefix `!` (Logical NOT) is defined as:

```sign
!__    ` → Id morphism (statically fixed evaluation, non-Unit, True)
!expr  ` → __  (when expr is non-Unit)
```

- `!__` does NOT return a arbitrary integer like `1`, as that would reintroduce Booleans. It returns a pure identity morphism (Id), which acts as True in `&`/`|` short-circuit chains.

---

## 4. Structural Equality (`==`) vs Arithmetic Equality (`=`)

| Operator | Allowed Operands | List/Struct Support | Behavior on Truth |
|:---:|---|:---:|---|
| `=` | Int, Float, Char, Address | ❌ (Compile Error) | Returns LHS |
| `==` | Any structure (Atom, List, Struct, Dict) | ✅ | Returns LHS |

Applying `=` to non-scalar structures like lists triggers a **Compile Error**. Structural equality (`==`) must be used instead.
