# Static Desugaring Specification for Hole (`_`) and Partial Application

## 1. Separation of Syntactic Hole (`_`) and Runtime Unit (`__`)

In Sign, the role of partial application placeholders and runtime unit values are cleanly separated:

- **Lexically Written Hole (`_`)**: A single underscore written directly in source code is statically desugared at compile time into a lambda expression (`?`) representing an explicit partial application placeholder.
- **Runtime Unit Value (`__`)**: Double underscores represent the runtime Unit value (empty list / Nothing / falsy), flowing purely as a value at execution time.

This separation guarantees that dynamic expressions evaluating to Unit (e.g. `3 < 2`) never accidentally trigger runtime closure creation.

---

## 2. Specification

### 2.1 Compile-Time: Static Desugaring Rules

During AST construction, the compiler inspects argument slots of function application nodes.

If an argument slot contains a **lexically written `_` (Hole)**, it is transformed into a lambda expression (`?`) as follows:

#### Transformation Algorithm
1. Count the number of `_` (Holes) in the application expression ($N$).
2. Generate $N$ unique compiler variables $P_0, \dots, P_{N-1}$ (e.g. `$p0`, `$p1`).
3. Replace the $i$-th `_` in the original expression with $P_i$.
4. Wrap the entire expression in a lambda taking $P_0, \dots, P_{N-1}$ as parameter list.

#### Transformation Examples

| Source Code | Desugared AST | Description |
|---|---|---|
| `f _ 3` | `$p0 ? f $p0 3` | Single hole transformation |
| `f _ _` | `$p0 $p1 ? f $p0 $p1` | Multiple holes transformation (currying) |
| `[+ 1,] _` | `$p0 ? [+ 1,] $p0` | Combination with point-free form |

---

### 2.2 Runtime: Value Semantics

Values evaluated as `__` at runtime are treated strictly as **pure values (Unit/Nothing)**.

When a dynamic expression (such as `3 < 2` or `dict ' missing_key`) evaluates to `__`, it is passed to the target function as a normal value argument, triggering default argument evaluation or Unit propagation instead of creating a partial application.

#### Execution Example 1 (Runtime Value Semantics):
```sign
g :
    x
    y : x + 1
  ? y

result : g 1 (3 < 2)
```
- `(3 < 2)` is evaluated at runtime to `__`.
- `g 1 __` is executed.
- `y = __` triggers default parameter fallback ($y = x + 1 = 2$).
- Returns `2`.

#### Execution Example 2 (Static Desugaring Partial Application):
```sign
g :
    x
    y : x + 1
  ? y

h : g _ 5
```
- Lexical `_` is statically desugared to `h : $p0 ? g $p0 5`.
- Calling `h 10` binds `$p0 = 10` and executes `g 10 5`.
- Returns `5`.

---

## 3. Design Benefits

1. **Semantic Consistency & Safety**: Eliminates bugs caused by dynamic values accidentally generating closures.
2. **Zero Runtime Overhead**: All partial applications are converted to standard lambda functions at compile-time.
3. **IDE & Static Tooling Alignment**: Arity and function types are statically determined during parsing.
