# Coproduct Resolver Specification

This specification defines the algorithm that greedily reduces a flat sequence of space-separated terms (`coproduct_block`) into a binary AST based on type tag precedence immediately after the parsing stage.

---

## 1. Overview and Deadlock Avoidance

In the Sign language, juxtaposition by space represents a "coproduct" and resolves to either `reverse_apply` (reverse application), `apply` (function application), `compose` (function composition), or `concat` (list concatenation/biproduct), depending on the types.

Attempting to construct the AST after waiting for type inference (Algorithm W) to complete would create a circular dependency. Therefore, this resolver uses the **type tags (structural/syntactic category information) "softly" attached to each node immediately after parsing** to deterministically resolve the binding relationships.

---

## 2. Term Type Category Identification (getCategory)

For each node `node` to be analyzed, an approximate pre-type-inference category (`Lambda` or `Atom`) is determined according to the following rules:

- **Conditions under which a term is judged as `Lambda` (function/arrow)**:
  - The node itself has the `isLambda` flag set.
  - `?` (function definition), `compose` (composition node), or an `operation` in a partially applied state (e.g., an infix, prefix, or postfix operator missing some operands).
  - Predefined built-in function names such as `print`, `<print>`, and `_`.
  - Terms to which the prefix operator `@` is applied.
- **Conditions under which a term is judged as `Atom` (value/object)**:
  - Numeric literals and string literals.
  - Identifiers registered in the environment map `env` whose category is `Atom`.
  - Normal operation nodes such as arithmetic operations and list concatenation `concat`.
  - Anything else that does not fall under the above.

---

## 3. Precedence Definition

For the type category combination of an adjacent pair `(LHS, RHS)`, we define the following binding precedence (processed in descending order of priority):

| Precedence (Descending) | Left-Hand Side Category (`leftCat`) | Right-Hand Side Category (`rightCat`) | Reduction Target Node | Meaning |
| :--- | :--- | :--- | :--- | :--- |
| **10.3** | `Atom` | `Atom` | `concat` | Direct sum/biproduct (list concatenation) |
| **10.2** | `Lambda` | `Lambda` | `compose` | Arrow composition (function composition) |
| **10.1** | `Lambda` | `Atom` | `apply` | Arrow application (function application) |
| **10.0** | `Atom` | `Lambda` | `apply_reverse` | Reverse application (apply the LHS value to the RHS function) |

---

## 4. Brute-Force Precedence Resolution Algorithm (Reduction)

Given a flat sequence of terms `items` (e.g., type tags `Ta Ub Vc Wd` for `a b c d`), a binary tree is constructed using the following steps:

1. **Precedence Table Traversal**:
   Process the precedence definition list in order from highest to lowest (from 10.3 down to 10.0).
2. **Left-Associative Scan of the List**:
   For the precedence `prec` currently being applied, scan adjacent pairs `(items[i], items[i+1])` in `items` from left to right.
3. **Matching and Reduction**:
   - If the type category combination `(catL, catR)` of a pair matches the condition of `prec`, those two terms are removed and joined into a new `operation` node (`concat`, `compose`, `apply`, or `apply_reverse`).
   - Example: If the precedence of `Ta Ub` is the lowest (10.0) and the precedence of the adjacent `Ub Vc` is higher (e.g., 10.3), the joining of `Ub Vc` is executed first, reducing the sequence to `a (b c) d`.
   - When a reduction is executed, the list indices are updated and the scan restarts from the beginning of the list (to guarantee left-associative behavior).
4. **Convergence**:
   When processing for all precedence levels is complete, the list converges to a single root node.

Through this brute-force precedence dispatch, ambiguous space binding relationships are resolved uniquely and soundly based on type tags.
