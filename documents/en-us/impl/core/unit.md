# Complete Specification of Unit (`__`) in the Sign Language

> [!IMPORTANT]
> This document integrates the following foundational specifications:
> - Unit_Specification (Mathematical Foundations & Complete Specification)
> - Undefined Identifiers and Unit (Crucial Implementation Properties)

---

## 0. Crucial Implementation Properties (Quick Reference)

### 0.1 Convergence of Undefined Identifiers to Unit (Elimination of Reserved Words)

The Sign language has no reserved words such as `null`, `nil`, or `false`.
It operates on the core specification: **"Any identifier not defined in the current scope evaluates to `__` (Unit/Nothing)."**

#### Utilization as Virtual Keywords
This property allows users to introduce zero-cost "virtual keywords" using arbitrary words or Unicode symbols:
```sign
@lazy tick
@iterator next
```
Because undefined identifiers (`tick`, `next`) safely evaluate to `__`, they serve as natural-language markers to enhance readability without incurring overhead.

### 0.2 Isomorphism of Unit and False & Short-Circuit Evaluation

Language-builtin logical AND (`&`) and logical OR (`|`) perform short-circuit evaluation.

```sign
` Exit condition and recursive step for append
append : [x ~xs] [y ~ys] ?
    xs & x (append xs (y ys)) | @x y ys
```
- If `xs` is not an empty list (truthy), the subsequent recursive step is evaluated.
- If `xs` is an empty list (`__` / falsy), the right-hand side of `|` (the base case) is evaluated.

### 0.3 Safe Invalidation of Operators

```sign
[+] : ~x ? __
```
By consuming all operands with a variadic argument `~x` and explicitly returning `__`, an entire expression using that operator collapses safely into `__`.

### 0.4 Behavior of `$__` and `@__`: Unit Absorbs All Operators

`$` (address-of) and `@` (dereference), like all other operators, **absorb Unit**.

```sign
$__  = __    ` Applying $ to Unit yields Unit (absorber)
@__  = __    ` Applying @ to Unit yields Unit (absorber)
@$__ = __    ` Self-evident as composition of the above two
```

**Consequence: There is no special distinct value `$__`.**

- There is no need to carry Unit around as an "address"; simply use `__`.
- Returning `__` is sufficient to signal the end of a lazy stream. Through `@__` = `__`, the consumer automatically receives `__`.
- `$__` is defined in the type system as a constant corresponding to code point zero (`0u00`), but its runtime value is identical to `__` and holds no independent entity.

```sign
` Before (Misconception):
stream : @lazy tick ... | $__   ← Misunderstanding that a "non-Unit value" is needed for stream end

` After (Correct Design):
stream : @lazy tick ... | __    ← Returning __ is equivalent since @ receives __
```

---

## 1. Introduction

> [!IMPORTANT]
> **`__` is the Zero Object required to define Sign as a category.**
> All subsequent behaviors derive directly from this single first principle.

A Zero Object is an object where the **Initial Object and Terminal Object coincide**:

$$\__ = \text{Initial Object} \cong \text{Terminal Object}$$

Due to this coincidence, `__` possesses dual behaviors across all operations:

| Role as Object | Operation | Behavior |
|:---:|:---:|---|
| **Terminal Object** (Absorber in Product) | `&`, `+`, `*`, ... | `__ op x = __` |
| **Initial Object** (Identity in Coproduct) | `|`, `;`, ` `, `,` | `__ op x = x` |

This is not a casual explanation of "acting logically as false," but a natural consequence when formulated category-theoretically.

---

## 2. Mathematical Foundation as a Bialgebra

### 2.1 Basic Properties (Derived from Zero Object)

- **Zero Object**: The coincidence of initial and terminal objects essential for defining Sign as a category (**First Principle**).
- **Bialgebra Identity**: The identity element for both list structures (coalgebra) and function composition (algebra).
- **Value Semantics**: `__ = []` (equivalent to the empty list).
- **Function Semantics**: Functions as the identity morphism of the coproduct, allowing evaluation flow to pass through transparently.
- **Crucial Distinction**: `__ ≠ 0` (Zero Object is distinct from numeric zero).

### 2.2 Definition of Bialgebra Structure

The list structure in Sign forms a bialgebra `(List, unit, join, extract, duplicate)`:

#### Algebraic Structure (Monad)
- `unit : A → List A` where `unit(x) = [x]`
- `join : List(List A) → List A` where `join([[a₁, a₂], [b₁, b₂]]) = [a₁, a₂, b₁, b₂]`

#### Coalgebraic Structure (Comonad)
- `extract : List A → A` where `extract([x]) = x`, `extract([]) = __`
- `duplicate : List A → List(List A)` where `duplicate([a, b]) = [[a], [b]]`, `duplicate([]) = [[]]`

### 2.3 Category-Theoretic Proof: Bialgebra Identity of `__`

**Theorem**: `__` is the identity element of the bialgebra `(List, unit, join, extract, duplicate)`.

#### Monad Identity Proof
```haskell
__ >>= f = __                -- left unit law (empty list yields empty list __)
m >>= (\x → __) = __         -- right unit law
```

#### Comonad Identity Proof
```haskell
extract(__) = extract([]) = __             -- extraction law
duplicate(__) = duplicate([]) = [[]] = [__] -- duplication law
```

#### Bialgebra Compatibility
```haskell
extract ∘ unit = id:
extract(unit(__)) = extract([__]) = __ = id(__) ✓

duplicate ∘ unit = unit ∘ unit:
duplicate(unit(__)) = duplicate([__]) = [[__]]
unit(unit(__)) = unit([__]) = [[__]] ✓
```

---

## 3. Complete Specification of Unit Operations

### 3.1 Operations in Function Context

#### 3.1.1 Interaction with Arithmetic Operators

```sign
` [Comparison] Hole (_) generates a partial application (placeholder function identity)
_ + X → [+ X]     ` (e.g., (_x) => _x + X)
X + _ → [X +]     ` (e.g., (_x) => X + _x)

` [Asymmetric Unit Propagation in Arithmetic]
` Unit acts as an "absorber" on LHS, and an "identity element" on RHS for non-categorical operators
__ + X → __       X + __ → X
__ - X → __       X - __ → X
__ * X → __       X * __ → X
__ / X → __       X / __ → X
__ % X → __       X % __ → X
__ ^ X → __       X ^ __ → X
```

#### 3.1.2 Interaction with Comparison Operators

```sign
` Absorption in comparison operators (both sides act as absorbers)
__ < X → __       X < __ → __
__ <= X → __      X <= __ → __
__ = X → __       X = __ → __
__ != X → __      X != __ → X   ` Exception: If X is confirmed non-Unit, X is returned (truthy)
__ > X → __       X > __ → __
__ >= X → __      X >= __ → __
```

#### 3.1.3 Function Application and Behavioral Branching by Arity

Passing `__` as an explicit argument changes its bialgebraic role based on function arity (saturation):

```sign
` 0. Functioning as Identity Morphism (Application to values) --- Only when X is Atom | List ---
` Rationale: In Layer 1, "Atom coproduct Atom" → concat, where __ acts as the identity element (initial object) of concat.
__ X → X __ → X   ` X: Atom | List

` ⚠ Behavior differs when X is a Lambda:
` In Layer 1, "Atom coproduct Lambda" → apply_reverse, passing __ as an argument to f (__ f ≡ f __).
` By the Completeness Axiom (§3.4), f __ = __ holds:
__ f → f __ → __   ` f: Lambda (unsaturated)

` 1. For unsaturated functions (arity remaining)
` → Unit (__) acts as an absorber, triggering Unit propagation and instantly collapsing the expression
F_unsaturated __ → __

` 1.5. [Comparison] When Hole (_) is passed
` → Hole (_) acts as a placeholder identity morphism, generating a partial application closure
F_unsaturated _ → F_unsaturated

` 2. For saturated functions (all arguments fulfilled)
` → By the Completeness Axiom (Type System §3.4), __ acts as an absorber (returns __)
` Exception: Prefix @ (dereference) drives evaluation when RHS is saturated
@F_saturated  ` → 1-step evaluation returns result or saturated function
F_saturated~  ` → Evaluates continuously to Result
```

> [!IMPORTANT]
> **Completeness Axiom** (`type_system.md` §3.4): `∀f, f __ = __`
> A function call is considered valid/evaluated only when all owned parameters are satisfied with valid non-Unit values. Passing `__` means "unevaluated/invalid", collapsing the expression into `__`.

### 3.2 Operations in List Context

#### 3.2.1 List Concatenation
```sign
__ [X] → [X]
[X] __ → [X]

` Explicit arithmetic on lists results in TypeError
[__] + [X] → TypeError
```

#### 3.2.2 List Operations
```sign
map f __ → __
fold f init __ → init
```

### 3.3 Behavior in Product and Coproduct

#### 3.3.1 Logical AND (`&`) ── Absorber in Product
`&` represents categorical Product. `__` acts as an **absorbing element (zero element)**:
```sign
__ & X → __
X & __ → __
```

#### 3.3.2 Logical OR (`|`) ── Identity in Coproduct
`|` represents categorical Coproduct. `__` acts as an **identity element**:
```sign
__ | X → X
X | __ → X    ` Short-circuits if LHS is non-Unit
```

#### 3.3.3 Exclusive OR (`;`) ── Symmetric Difference
```sign
__ ; X → X
X ; __ → X
```

#### 3.3.4 Negation (`!`)
```sign
!__    ` → Id morphism (statically fixed evaluation, non-Unit, truthy)
!expr  ` → __  (when expr is non-Unit)
```

### 3.4 Address and IO Operations

```sign
$__ = __
@__ → __
__ # X → __   ` Output to Unit is invalidated (/dev/null equivalent)
```

---

## 4. Distributive Law of Bialgebras

Functionalization of operators in Sign is expressed via the bialgebra distributive law:

```sign
` Distributive law: (f ⊗ g)(hole(x)) = hole(f(x)) ⊗ hole(g(x))
(+ ⊗ *)(hole(x)) = hole(+(x)) ⊗ hole(*(x))

Example:
_ + 3 → [+ 3]    ` Hole-based partial application generation
_ * 5 → [* 5]    ` Generates hole(*(5))
```

---

## 5. Optimal Implementation on ARM64

### 5.1 Representation of Unit Values
- **NULL pointer**: Unit is represented as NULL pointer (`0x00`).
- **Conditional instructions**: Leverages AArch64 conditional instructions for efficient Unit checks.
- **Register optimization**: Uses `xZR` zero register properties.

### 5.2 Binary Representation of Unit (`\x00`)

> [!IMPORTANT]
> **`\x00` (null byte) is the binary wire representation of Unit in Sign.**
> Do NOT confuse with `0x00` (Address value zero).

In the Sign parser/compiler, a raw `\x00` byte in the input stream is directly recognized as a Unit-typed token (`__`), not as character data or an address pointer.

| Source Notation | Interpretation | Purpose |
|---|---|---|
| `__` | Unit Value | Human-readable source code |
| `\x00` (raw byte) | Direct Unit type token | Machine-generated tokens / self-hosting wire format |
| `0x00` | Address value 0 | Normal Address literal (unrelated to Unit) |

---

## 6. Practical Applications

### 6.1 Function Composition via Bialgebra Properties
```sign
map_double : [* 2,]
result : map_double [1 2 3 4]  ` → [2 4 6 8]

add_then_multiply : [+] [* 2]
result : add_then_multiply 3 5  ` → (5 + 3) * 2 = 16
```

### 6.2 Conditional Branching using Unit
```sign
safe_divide : x y ?
    y = 0 & __ | [x / y]

result : safe_divide 10 0   ` → __ (Unit)
result : safe_divide 10 2   ` → [5]
```

---

## 7. Conclusion

Unit (`__`) in Sign is not merely a convenience symbol, but a fundamental element stemming from first principles. Category-theoretically isomorphic to the identity element of a bialgebra, it unifies functional programming, list processing, invisible strong typing, and zero-cost abstraction.
