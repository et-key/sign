# Coproduct Resolver Specification

This document defines the deterministic algorithm that reduces flat space-separated token sequences (`coproduct_block`) into binary AST trees immediately after parsing, based on type category precedence.

---

## 1. Overview

In Sign, space juxtaposition represents a **Coproduct**, which reduces to `reverse_apply`, `apply`, `compose`, or `concat` based on operand type categories.

Constructing ASTs prior to Hindley-Milner type inference avoids circular dependency deadlocks by using **pre-inference type categories (`Lambda` vs `Atom`)** attached to nodes during parsing.

---

## 2. Term Category Classification (`getCategory`)

Nodes are classified into pre-inference categories (`Lambda` or `Atom`):

- **`Lambda` Category**:
  - Node has explicit `isLambda` flag.
  - `?` (lambda definition), `compose` nodes, or partially-applied operator nodes.
  - Built-in function identifiers (`print`, `_`).
  - Terms prefixed with `@`.
- **`Atom` Category**:
  - Numeric literals, string literals.
  - Identifiers registered in environment map as `Atom`.
  - Arithmetic and structural list `concat` nodes.

---

## 3. Precedence Definitions

Juxtaposed pairs `(LHS, RHS)` reduce according to precedence:

| Precedence | Left Category (`leftCat`) | Right Category (`rightCat`) | Reduced AST Node | Semantics |
| :--- | :--- | :--- | :--- | :--- |
| **10.5** | `Lambda` | `Lambda` | `compose` | Function composition |
| **10.4** | `Lambda` | `Atom` | `apply` | Function application |
| **10.3** | `Atom` | `Lambda` | `apply_reverse` | Reverse application |
| **10.2** | `List~ \| Struct~` | `List~ \| Struct~` | `concat` | Concatenate lists / structs |
| **10.1** | `Atom \| List~` | `Atom \| List~` | `push / unshift` | Prepend / append |
| **10.0** | `Atom` | `Atom` | `construct` | Construct tuple / product |

---

## 4. Reduction Scan Algorithm

For a flat token list `items`:

1. **Scan Precedence Table**: Iterate through precedence levels (10.5 down to 10.0).
2. **Left-Associative Scan**: Scan adjacent pairs `(items[i], items[i+1])` from left to right.
3. **Match & Reduce**: On matching category pairs, collapse into a single binary AST node and re-scan from the beginning to preserve left-associativity.
4. **Convergence**: Scan terminates when `items` reduces to a single root AST node.
