# Static Desugaring Specification for Partial Application (Hole)

## 1. Background and Purpose

In the Sign language, `_` (Unit) serves a dual role:
1. **As a Value `_`**: Represents empty lists, "false" in conditional expressions, and Nothing (absence of value).
2. **As a Morphism `_`**: Represents a "Hole" in function application, generating a partially applied function.

If partial application is performed at runtime based solely on whether an argument is evaluated to `_`, a **semantic conflict** arises: a `_` passed as a result of dynamic computation (e.g., `3 < 2`) would erroneously trigger partial application. Instead of returning a value (such as falling back to a default value), it would return a function waiting for another argument.

To resolve this conflict, explicit partial applications (Holes) are **statically desugared at compile time**, ensuring that only pure value `_` flows at runtime.

---

## 2. Specification Definition

### 2.1 Compile-time: Static Desugaring Rules

During the construction and analysis of the AST (Abstract Syntax Tree), the compiler inspects the argument slots of function application (Apply) nodes.

* If `_` (Unit literal) is **lexically written directly in the argument slot**, that `_` is treated as a "Hole" for partial application.
* The compiler **statically transforms (desugars) the function application expression into a lambda expression (`?`)** using the following procedure.

#### Transformation Algorithm:
1. Let $N$ be the number of `_` (Holes) in the application expression.
2. For each $i \in \{0, \dots, N-1\}$, generate a unique, non-overlapping compiler-generated variable $P_i$ (e.g., `$p0`, `$p1`).
3. Replace the $i$-th `_` in the original application expression with the corresponding variable $P_i$.
4. Wrap the entire expression in a lambda expression with the generated variables $P_0, \dots, P_{N-1}$ as the parameter list.

#### Transformation Examples:

| Source Code | After Desugaring in AST | Description |
|---|---|---|
| `f _ 3` | `$p0 ? f $p0 3` | Single hole transformation |
| `f _ _` | `$p0 $p1 ? f $p0 $p1` | Multiple holes transformation (Currying) |
| `[+ 1,] _` | `$p0 ? [+ 1,] $p0` | Combination with point-free expression |

---

### 2.2 Runtime: Value Semantics

Any `_` passed to arguments that were not desugared at compile time and are resolved as runtime evaluation results are treated as **pure values (Unit/Nothing)**.

* If `_` is returned as an evaluation result of a dynamic expression (e.g., `3 < 2` or `my_dict ' non_existent_key`), it is passed to the function simply as an argument value.
* When the applied function (e.g., `g`) receives this `_`, instead of generating a partial application, it performs **normal evaluation (application with default arguments or propagation of Unit)**.

#### Runtime Example 1 (Evaluation under Value Semantics):

```sign
` 1. Source Code
g :
    x
    y : x + 1
  ? y

result : g 1 (3 < 2)

` 2. Compile-time
` Since (3 < 2) is not the literal "_", static desugaring does not occur. It compiles as is.

` 3. Runtime
` (3 < 2) is evaluated to value "_" (Unit).
` g 1 _ is executed.
` Because value "_" is passed to argument y, the default argument rule triggers, making y = x + 1 (1 + 1) = 2.
` Result: 2 (returns value)
```

#### Runtime Example 2 (Evaluation of Partial Application via Static Desugaring):

```sign
` 1. Source Code
g :
    x
    y : x + 1
  ? y

` Partial application via explicit "_"
h : g _ 5

` 2. Compile-time
` Since literal "_" is written in the argument slot, static desugaring (Hole -> Lambda) is executed.
` Converted and compiled as: h : $p0 ? g $p0 5

` 3. Runtime
` Call h 10.
` ($p0 ? g $p0 5) 10 is evaluated, and argument $p0 is bound to 10.
` g 10 5 is executed.
` x = 10, y = 5 (since 5 is explicitly passed to y, the default argument is not applied).
` Result: 5 (returns value)
```

---

## 3. Design Benefits

1. **Ensuring Consistency and Safety of Semantics**:
   The static intent of "I want to partially apply (want a function)" and the dynamic intent of "The conditional check failed (want a default value or Nothing)" are completely separated, eradicating the bug of returning unexpected functions.
2. **Simplifying Compiler and Runtime**:
   The runtime (WASM, AArch64, etc.) does not need to monitor whether execution arguments are `_` to dynamically generate closures. All partial applications are converted to normal function definitions (lambdas) at compile time, eliminating runtime overhead and improving performance.
3. **Better Integration with IDEs and Static Analysis Tools**:
   The type of partial application and the function's arity (number of arguments) are statically determined during syntax analysis, improving the accuracy of error checking and auto-completion by tools.
