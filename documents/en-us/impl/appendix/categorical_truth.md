# Mathematical Foundation of Categorical Truth in Sign

## 1. Overview

This specification details the mathematical foundation of truth values in Sign:

- **Unit (`__`)**: Empty lists and unevaluated lambdas are falsy (`false`).
- **All other values (including numeric `0`)**: Truthy (`true`).

---

## 2. Theoretical Foundation

### 2.1 Category Theory Perspective

In Category Theory, $0$ acts as an **Initial Object** ($\mathbf{0}$). An initial object holds a unique morphism to every other object in the category, representing a functional domain rather than "nothingness".

Conversely, Unit / Empty List ($\mathbf{1}$ / `[]`) represents the absence of data, serving as the identity element of coproducts and naturally corresponding to logical `false` (isomorphic to `Nothing` in Monad theory).

---

## 3. Truth Value Semantics via SKI Combinators

Truth values in Sign map directly to SKI combinator structures:

| SKI Combinator | Lambda Equivalent | Sign Construction | Boolean Meaning |
|:---:|:---:|:---:|:---:|
| **K** (Left Selector) | $\lambda x. \lambda y. x$ | **Identity Morphism** (`[__ ]` / `!__`) | **True** |
| **KI** (Right Selector) | $\lambda x. \lambda y. y$ | **Unit** (`__`) | **False** |

### Negation Operator (`!`) Semantics

Logical negation `!` transforms between Initial and Terminal object morphisms:

- `!__` $\implies$ Evaluates to Identity Morphism `K` (Evaluated Non-Unit True).
- `!(valid_value)` $\implies$ Collapses to Unit `__` (`KI` False).

---

## 4. Code Examples

```sign
` Numeric 0 is truthy; returns x
0 & x

` Empty list is falsy; returns __
[] & x

` Evaluation of invalid comparison collapses to Unit (__)
3 < 2   ` → __
```
