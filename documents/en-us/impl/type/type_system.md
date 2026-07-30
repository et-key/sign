# Sign Language Type System Specification

## 1. Design Principle: Types Derive Trivially from Operators and Syntax

The Sign type system is governed by a fundamental principle:

> **Types are not labels attached to data; they are uniquely determined by operators and AST structure.**

Because of this, constraint-solving algorithms like Hindley-Milner are unnecessary. Type inference completes in a linear scan ($O(n)$) over the AST.

> **Types are not subjects of declaration, but reflections of actual operations performed by code.**
>
> Sign lacks declaration syntax for traits/interfaces. This is not a missing feature.
> The capability set of an identifier is already fully declared by the consuming code. `.st` files simply statically reflect and copy this information rather than "declaring" it.

---

## 2. Type Hierarchy (2-Layer Structure)

The Sign type system consists of two independent layers:

### Layer 1: Structural Type

Determines space operator semantics. **Uniquely determined by syntax.**

| Structural Type | Definition |
|:---:|---|
| `Lambda` | Expressions containing `?` operator, or bracket expressions generating partial applications |
| `Atom` | All other values and expressions (numbers, strings, lists, Unit, etc.) |

**Layer 1 Determination Rules:**

```sign
x y ? body          → Lambda  (Determined by `?`)
[+ 2]               → Lambda  (Partial operation bracket)
[f]                 → Lambda  (Function address)
$expr               → Lambda  (Address retrieval)
@expr               → Lambda  (Deref / Input)

42                  → Atom    (Numeric literal)
`hello`             → Atom    (String literal)
x + y               → Atom    (Arithmetic result)
[1 2 3]             → Atom    (Value bracket)
__                  → Atom    (Unit value)
```

For identifiers: If the defining line contains `?`, the identifier is `Lambda`; otherwise, it is `Atom`.

### Layer 2: Atom Subtype

Determines operational behavior (type casting) inside `Atom`.

| Atom Subtype | Description | Example | Allowed Layer |
|:---:|---|---|:---:|
| `Int` | Signed / Unsigned integer | `42`, `-1` | Layer 0+ |
| `Float` | Floating-point number | `3.14`, `1.0` | Layer 2+ |
| `String` | Unicode string (Isomorphic to `List(0u)`) | `` `hello` `` | Layer 0+ |
| `Vector` | SIMD Vector | `[1.0 2.0 3.0 4.0]` | Layer 3+ |
| `List` | 1D array of identical types | `1 2 3`, `[1 2 3]` | Layer 0+ |
| `Struct` | Heterogeneous list / Product structure | `1, 2, 3` | Layer 0+ |
| `Dict` | Key-value dictionary | `[key : val]` | Layer 0+ |
| `Unit` | Unit element / Empty / Nothing | `__` | Layer 0+ |
| `Address` | Address pointer | `0x00`, `0xFF` | Layer 0+ |

---

## 3. Typing Rules

### 3.1 Space Operator Semantics (Layer 1 Dependent)

Once Layer 1 structural types are determined, space operators fall into one of 4 semantics:

| Priority | Left-Hand Side | Right-Hand Side | Semantics | Typing Rule |
|:---:|:---:|:---:|---|---|
| 10.3 | `Lambda` | `Lambda` | compose | `Lambda(A→B) → Lambda` |
| 10.2 | `Lambda` | `Atom` | apply | `Lambda(A→B) → B \| Lambda` |
| 10.1 | `Atom` | `Lambda` | apply_reverse | `Lambda(A→B) → B \| Lambda` |
| 10.0 | `Atom` | `Atom` | concat | `Atom → List` |

### 3.2 LHS-Priority Rule (Layer 2 Dependent)

**The result type of a binary operation is determined by the LHS Atom Subtype.** The RHS is converted to match the LHS type.

$$\text{typeof}(L \text{ op } R) = \text{typeof}(L)$$

| LHS Type | Operator | RHS Treatment | Result Type |
|:---:|:---:|---|:---:|
| `Int` | Arithmetic | Parsed as `Int` | `Int` |
| `Float` | Arithmetic | Parsed as `Float` | `Float` |
| `String` | Space | Stringified & concatenated | `String` |
| `String` | Arithmetic (`+`) | **TypeError (`__` collapse)** | `__` |
| `List` | `*` | Repeated RHS `Int` times | `List` |
| `List` | `/` | Split into RHS `Int` chunks | `List` |

### 3.3 Unit Typing Rules & Asymmetric Propagation

- **Logical Operations (`&`, `|`, `;`)**: `__` acts as absorber in Product (`&`), and identity element in Coproduct (`|`, `;`).
- **Arithmetic Operations (`+`, `-`, `*`, `/`, `%`, `^`)**:
  - `__ + X = __` (LHS Unit acts as error absorber / zero morphism).
  - `X + __ = X` (RHS Unit acts as missing value / identity morphism).
- **Comparison Operations (`<`, `<=`, `=`, `>=`, `>`)**:
  - Both sides act as absorbers (`__ < X = __`, `X < __ = __`).
  - Exception: `X != __ = X` (Evaluating whether a valid value is non-Unit is logically truthy, returning LHS `X`).

### 3.4 Completeness Axiom of Function Application

> [!IMPORTANT]
> **Completeness Axiom:** $\forall f, f \, \text{\_\_} = \text{\_\_}$
> A function application evaluates to a valid value **only if all required owned arguments are fulfilled with non-Unit valid values.**

Passing `__` as an unfulfilled argument causes the function call to evaluate to `__`.

#### Interaction with Default Arguments
Functions with default parameters fall back to default values when `__` is passed for those specific arguments:

```sign
g :
    x
    y : x + 1
  ? x + y

g 3      ` → 7  (y defaults to 3+1=4)
g 3 __   ` → 7  (y = __ falls back to default 4)
g __ 5   ` → __ (x = __ has no default -> Completeness Axiom triggers -> __)
```

### 3.5 Lambda ↔ Atom Conversion via `$` and `@`

Coproduct Resolver uses `$` to demote a `Lambda` into an `Address` (`Atom`) when passing functions as arguments to higher-order functions, preventing unintended `Lambda + Lambda` function composition.

---

## 4. Passes and Compiler Pipeline

1. **Pass 1 (Pre-pass)**: Linearly scans source code to collect identifier categories (`Lambda` or `Atom`) and arities into `.ist` (internal symbol table in memory).
2. **Pass 2 (Space Resolution)**: Resolves spaces deterministically into `compose`, `apply`, `apply_reverse`, or `concat`.
3. **Pass 3 (Layer 2 Propagation)**: Propagates Atom Subtypes according to LHS-Priority.
4. **Pass 4 (Code Generation)**: Consumes typed AST to emit machine target instructions.
