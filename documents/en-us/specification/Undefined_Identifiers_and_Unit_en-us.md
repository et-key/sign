# Specification on Undefined Identifiers and Unit Behavior in Sign

## 1. Unit Convergence of Undefined Identifiers (Total Elimination of Reserved Words)

The Sign language has no reserved words such as `null`, `nil`, or `false`.
There is a core specification that **"any identifier not defined in the current scope evaluates to `__unit` (Nothingness)"**.

### 1.1 Utilization as Virtual Keywords
This specification allows users to freely use any English word or Unicode symbol as a zero-cost "virtual keyword".
```sign
@lazy tick
@iterator next
```
As shown above, when undefined identifiers (`tick`, `next`) are passed to a function call, they are safely evaluated as `__unit`, thus functioning as natural language markers that improve readability.

## 2. Isomorphism between Unit and False, and Short-Circuit Evaluation

As stated in the design specification of Categorical Truth Values, in Sign, only "Nothingness (Unit) and the empty list" behave as false (False), and everything else (including 0) functions as true (True).

### 2.1 Natural Control Flow via Logical Operators
The language's built-in logical AND (`&`) and logical OR (`|`) perform short-circuit evaluation.
This allows conditional branches and recursion termination conditions to be defined as pure mathematical expressions without using traditional control structures like `if` statements or `match_case`.

```sign
` Example: Termination condition and recursive step for append
` Because the list (xs) itself functions as a truth value, comparison operators like == or != are unnecessary for empty checks.
append : [x ~xs] [y ~ys] ?
    xs & x (append xs (y ys)) | @x y ys
```
- If `xs` is not an empty list (True), the subsequent recursive step `x (append xs (y ys))` is evaluated.
- If `xs` is an empty list (`__unit` / False), the entire left-hand side becomes false, and the right-hand side of `|` (the termination condition `@x y ys`) is evaluated as a short-circuit fallback.

## 3. Disabled Operators and the Role of Unit

### 3.1 Safely Disabling Operators
If you want to prohibit the use of an operator (e.g., `+`) in a specific scope and block processing without causing a panic, override the operator as follows:

```sign
[+] : ~x ? __
```
By absorbing all operands using the variable-length argument `~x` and explicitly returning `__unit`, the entire expression using the operator safely collapses (short-circuits) into `__unit`.
* Note: If you define it as `[+] : __`, `__unit` acts as an identity morphism (id), which causes operands to unintentionally combine (function application). Therefore, you must absorb arguments using `~x`.

## 4. Difference in Behavior between `__` (Unit) and `$__` (Unit Address)

In evaluation interruption and lazy evaluation, these two have distinctly different roles.

### 4.1 `__` (Immediate Collapse / Tombstone)
- **Nature**: Represents the "death" (complete termination) of that computation path.
- **Behavior**: Instantly engulfs the entire expression through Unit propagation, causing a short-circuit that annihilates the computation.

### 4.2 `$__` (Lazy Suspend / Promise of End Signal)
- **Nature**: A Promise/Thunk representing the "hibernation (suspend)" of computation.
- **Behavior**: Safely waits until explicitly requested (dereferenced) by the consumer using `@`. Used as a signal to beautifully communicate "End of Stream" without throwing exceptions in lazy evaluation streams like `fold_lazy`.
