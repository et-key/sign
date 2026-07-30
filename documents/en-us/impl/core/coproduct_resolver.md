# Coproduct Resolver Specification

This document specifies the greedy reduction algorithm that transforms space-separated flat term sequences (`coproduct_block`) immediately after parsing into a binary AST based on type-category precedence.

---

## 1. Overview & Deadlock Avoidance

In Sign, juxtaposition using spaces represents a **Coproduct**, which reduces to one of `reverse_apply`, `apply`, `compose`, or `concat` based on structural type categories.

To avoid circular dependency between AST construction and type inference (Algorithm W), the Coproduct Resolver deterministically resolves binding precedence immediately after parsing using coarse-grained structural type tags (`Lambda` or `Atom`).

---

## 2. Term Category Determination (`getCategory`)

For each AST node prior to type inference, its coarse category (`Lambda` or `Atom`) is determined:

- **Condition for `Lambda` (Functions / Morphisms)**:
  - Node has explicit `isLambda` flag set.
  - Formed by `?` (Lambda definition), `compose` node, or partially applied operation.
  - Built-in function identifiers (`print`, `<print>`, `_`).
  - Prefix `@` applied to a term.
- **Condition for `Atom` (Values / Objects)**:
  - Numeric or String literals.
  - Identifiers registered in environment map with `Atom` category.
  - Arithmetic or `concat` operation nodes.

---

## 3. Precedence Definition

The binding precedence for adjacent pairs `(LHS, RHS)` is defined from highest to lowest priority:

| Priority | LHS Category | RHS Category | Target AST Node | Meaning |
|:---:|:---:|:---:|---|---|
| **10.5** | `Lambda` | `Lambda` | `compose` | Morphism composition (Function composition) |
| **10.4** | `Lambda` | `Atom` | `apply` | Morphism application (Function application) |
| **10.3** | `Atom` | `Lambda` | `apply_reverse` | Reverse application (Applying value to function) |
| **10.2** | `List~ \| Struct~` | `List~ \| Struct~` | `concat` | List concatenation |
| **10.1** | `Atom \| List~` | `Atom \| List~` | `unshift \| push` | List element insertion |
| **10.0** | `Atom` | `Atom` | `construct` | Product / Coproduct (List concatenation) |

---

## 4. Reduction Algorithm

For a sequence of terms `items`:

1. **Iterate Precedence Table**: Process precedence levels from 10.5 down to 10.0 (`compose` $\rightarrow$ `apply` $\rightarrow$ `apply_reverse` $\rightarrow$ `concat`).
2. **Left-Associative Scan**: Scan adjacent pairs `(items[i], items[i+1])` left-to-right.
3. **Match & Reduce**: If `(catL, catR)` matches current precedence level, reduce pair into a new `operation` AST node and restart scan from the beginning to ensure left-associativity.
4. **Convergence**: Continues until the list reduces into a single root node.

---

## 5. Preventing Implicit Merges via Postfix Tilde (`~`)

To maintain static typing and avoid dynamic typing overhead:

- Concatenation between `List` / `Struct` objects requires explicit postfix tildes (`~`) on **both operands** (`list~ list~`).
- Without postfix tildes (`list list`), operands are treated as distinct `Atom` values (represented as a list of two pointers/references at low level).
