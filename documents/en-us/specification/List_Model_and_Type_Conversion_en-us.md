# Sign Language List Model, Type Conversion, and Multidimensional Array Specification

## 1. Basic Principles: Representing All List Operations with Just Two Operators

List operations in the Sign language are completed using a combination of only two operators:

| Operator | Name | Category-Theoretic Meaning | Intuitive Meaning |
|---|---|---|---|
| ` ` (Space) | Coproduct | Juxtaposition / Concatenation | "Arrange" |
| `,` (Comma) | Product | Structural Assembly | "Combine" |

These two can be described as having an **adjoint functor** relationship in category theory. The coproduct and product are mathematically dual, and this symmetry is reflected in Sign's evaluation rules.

---

## 2. Coproduct (Space): 1D List Construction and Concatenation

### 2.1 Juxtaposition of Scalar Values

```sign
` Comma-separated (for scalar types, commas are optional)
1, 2, 3, 4, 5

` Arranging with spaces also forms a 1D list
1 2 3 4 5

` The following three are all equivalent:
myPairs  : 1 2 3 4 5
myPairs0 : [,] 1 2 3 4 5
myPairs1 : 1, 2, 3, 4, 5

myPairs = myPairs0 = myPairs1
```

### 2.2 List Concatenation

```sign
` List concatenation via spaces (Coproduct) = Flatly concatenated
[1 2] [3 4] = 1 2 3 4

` Results in a flat list
[1 , 2] [3 , 4] = 1 2 3 4
```

---

### 2.3 Range List Construction and Evaluation Strategy via Derived Operators

In the Sign language, by using derived operators (`~+`, `~-`, `~*`, `~/`, `~^`) that combine `~` with arithmetic operators, regular range lists such as arithmetic or geometric progressions can be constructed with natural syntax.
In this range list construction, the design paradigms of **strict evaluation** and **lazy evaluation** are clearly separated based on the number of terms.

* **Strict Evaluation (Instantiation) via 3-term Sets**
  When written as a 3-term set consisting of "Initial Value, Operator, Next Value, Operator, End Value", evaluation is forced (strict evaluation), and it is constructed in memory as a physical 1D list.
  (Example) `[2 ~+ 2 ~ 10]` $\rightarrow$ Instantiated as `2 4 6 8 10`.

* **Lazy Evaluation (Generator) via 2-term Specification**
  *Design specification in native compiler main implementation
  When written as a 2-term specification (e.g., an infinite list without an end value), it is treated as a "lazy evaluation generator (stream)" instead of a physical list. Values are generated only when needed (pulled), and are not instantiated until the postfix `~` (expansion/force evaluation) is applied.

This design enables programmers to intuitively control memory-consuming static list construction and memory-safe infinite stream processing simply by the number of terms written.

### 2.4 Explicit Distinction between List Passing (Eager) and Stream Passing (Lazy)

In function calls and recursion, whether to treat data as an "instantiated concrete list" or a "lazy-evaluated stream (thunk)" is explicitly controlled by both **how the argument list is received (pattern matching)** and **how the return value is passed**. This design is based on the adjoint relationship between List (Monad / Algebra) and Stream (Comonad / Coalgebra).

#### ① Distinction in Receiving Argument Lists (Consumer Side / Pattern Matching)

* **Receive as a List (Strict Evaluation / Instantiation)**: `f : [x ~xs] ?`
  When arguments are pattern-matched surrounded by brackets `[ ]`, it acts as an algebraic boundary. The passed data is forcibly evaluated (Pulled) as a concrete list and then destructured into the head `x` and the remaining concrete list `~xs`.

* **Receive as a Stream (Lazy Evaluation / Suspend)**: `f : x ~xs ?`
  When arguments are received without brackets, they are treated as a stream (generator). `~xs` is passed into the function suspended as a lazy stream containing all remaining elements, preventing unnecessary memory expansion.

#### ② Distinction in Return Values (Producer Side)

* **List Passing (Strict Evaluation / Instantiation)**: `x (append xs (y ys))`
  If an operation or recursive call is written directly, it is evaluated immediately (Eager Evaluation) to form an instantiated, concrete list in memory (a 1D coproduct).

* **Stream Passing (Lazy Evaluation / Suspend)**: `@x y ys`
  If the value is returned prefixed with the dereference operator `@` (the `extract` of a Comonad), it is passed as a suspended "stream (thunk)". The next value is generated only when the consumer demands (Pulls) it.

This clear distinction allows the programmer to fully control the boundary between lazy and strict evaluation using pure syntax alone (the presence or absence of brackets and `@`).

---

## 3. Product (Comma): Dimensional Construction

### 3.1 Comma is a "Dimension-Lifting" Operator

While space "arranges items in the same dimension", comma "combines items into a new dimension".

```sign
` This is a 1D list (Coproduct: simply arranging)
1 2 3 4

` This is a 2D array (Product: lifting dimension)
1 2 , 3 4

` The same meaning written in block notation
s :
	1 2 ,
	3 4
```

### 3.2 Natural Extension to n-Dimensional Arrays

Nesting commas naturally corresponds to n-dimensional arrays.

```sign
` 2-dimensional (2x3)
1 2 3 , 4 5 6

` 3-dimensional (2x2x2)
[1 2 , 3 4] , [5 6 , 7 8]

` 3-dimensional (2x2x2) in block notation
v3 :
	1 2 , 3 4 ,
	5 6 , 7 8

` List copying (corresponding to multiplication) = flatly copied
[1 2 3 4] * 2 = 1 2 3 4 1 2 3 4

` List lifting (corresponding to exponentiation) = copied by lifting dimensions
[1 2 3 4] ^ 2 = 1 2 3 4 , 1 2 3 4

` List splitting (corresponding to division)
[1 2 3 4] / 2 = 1 2 , 3 4

` Expansion operator: expands the inner layer by 1 level, then the coproduct (space) is automatically evaluated.
` The inner layer is expanded by 1 level -> product is resolved into coproduct.
[1 2 , 3 4]~   = [1 2 3 4] = 1 2 3 4

` Since the prefix ~ is the "lifting" operator, the following equation holds with the comma function and the unit element:
[,] = [~_]

` Thus, the following algebra holds for scalar types:
[,] 1 2 3 4 5 = [~_] 1 2 3 4 5 = ~[1 2 3 4 5] = 1, 2, 3, 4, 5 = 1 2 3 4 5
```

This algebra, where `[,]` (product) and coproduct (space) converge to the same result for scalar types, is a natural consequence of the adjoint functor theorem manifesting as language behavior. The prefix `~` (lifting) and postfix `~` (expansion) are an adjoint pair of inverse operations; applying both returns to the original structure. This is also the moment where the specification "commas are optional for scalar types" is algebraically proven.

`~` (postfix) is an operator that **expands the inner layer by exactly one level**. Prefix `~` is lifting, postfix `~` is expansion—the same symbol handles inverse operations depending on its position.

### 3.3 Symmetry of Coproduct and Product

```sign
` Coproduct: flat concatenation (surrounding with brackets evaluates the coproduct inside first)
[1 2] [3 4]   = 1 2 3 4

` Product: preserved as a 2D structure
` (Writing [[1 2] [3 4]] would evaluate the coproduct inside first, resulting in something else)
1 2 , 3 4     = 1 2 , 3 4

` Becomes coproduct only after the expansion operator is applied
[1 2 , 3 4]~  = [1 2 3 4] = 1 2 3 4

` Since prefix ~ (lifting) and postfix ~ (expansion) are inverse operations, the following holds:
~[1 2 , 3 4]~
= [[1 2 , 3 4]]~    ` Lifted by prefix ~ (coproduct waits in suspension once)
= 1 2 , 3 4         ` Expanded by postfix ~ -> returns to original
```

`1 2 , 3 4` is different from `[[1 2] [3 4]]`. The latter is a two-step expression where `1 2` and `3 4` inside the brackets are evaluated as coproducts first, and then the product is taken via commas. The former directly describes a 2D structure.

---

## 4. Left-Priority Rules of Type Conversion

### 4.1 Basic Principle

In binary operations of the Sign language, **the type of the left-hand side (LHS) determines the type of the entire operation**. The right-hand side (RHS) is automatically converted to the LHS type. If it cannot be converted, a compile-time error occurs.

The basis for this design is the concept that "the RHS of a binary operation acts on the LHS as the object of the verb (operation)".

```sign
` LHS is number -> RHS string is interpreted as number
0 + `123` = 123

` LHS is string -> RHS number is interpreted as characters
`123` + 0 = 0u31 0u32 0u33
```

### 4.2 Behavior Varies by Operator: Coproduct vs. Arithmetic Operators

The type of conversion is determined by the combination of the "LHS type" and the "operator type (coproduct or arithmetic)".

**Space (Coproduct): Concatenation of Structures**

```sign
` LHS is string -> numbers are stringified and concatenated
`123` 0 = `1230`

` LHS is number -> simply becomes a tuple
1 2 `34` = 1 2 `34`
```

**Arithmetic Operators (`+`, `-`, `*`, `/`, etc.): If LHS is a string, operates on each character as a code point**

```sign
` Exposes code points with the additive identity (+0)
`123` + 0 = 0u31 0u32 0u33

` Same result with the multiplicative identity (*1) <- +0 and *1 are equivalent
`123` * 1 = 0u31 0u32 0u33

` Operations can be performed with values other than identity elements
`123` + 1 = 0u32 0u33 0u34   ` +1 to each code point
`123` * 2 = 0u62 0u64 0u66   ` multiplies each code point by 2
```

**Arithmetic Operators: If LHS is a number**

```sign
` Parses RHS string as a number
0 + `123` = 123
```

Here, it is important to note that `"123" + 0` and `"123" * 1` are equivalent. `+0` is the additive identity, `*1` is the multiplicative identity—both are "numerically no-op operations", but **the act of applying an arithmetic operator to a string itself** exposes the code points. Space (coproduct) is the only exception, acting as an operator that "treats it as a string".

### 4.4 The Moment the Essence of Character Type Appears

When the `+` operator hits the LHS of a string, the layer of type abstraction is peeled off, exposing the **entity of each character at the hardware level (address type `0x`)**.

```sign
` A string is a list of characters
`abc` = \a \b \c

` Concatenated as strings via space (coproduct)
`123` 123 = `123123`
```

---

## 5. Dictionary (Struct) Pattern Matching and Destructuring

When receiving a dictionary (struct) in a function call, you can perform destructuring by key name using the same `[ ]` syntax as lists.

### 5.1 The Difference Between Expanding (Keyword Args) and Passing as a Chunk (Struct)

* **When Passing Expanded (Conventional)**: `f [ foo : 1, bar : 2 ]~`
  The postfix `~` expands the dictionary by one level, passing it as a sequence of keyword arguments `foo: 1, bar: 2`. The function receives them directly as `f : foo bar ? ...`.

* **When Passing as a Chunk (Struct)**: `f [ foo : 1, bar : 2 ]`
  Without `~`, the dictionary is passed as a single chunk (a single argument). This notation is essential when passing it alongside other arguments (e.g., `f x [foo: 1, bar: 2] y`).

### 5.2 Pattern Matching Syntax for Receiving as a Chunk

When you want to extract specific keys from an argument passed as a single dictionary and group the remaining elements (Rest extraction), you can use the exact same intuitive syntax as the list's `[x ~xs]`.

```sign
` Extract the value of the 'foo' key from the entire dictionary, and bind the rest to 'obj'
f : x [foo ~obj] y ?
    ...

` Call example
f 10 [ foo : 1, bar : 2, baz : 3 ] 20
```

In the example above, the bindings inside the function will be:
* `x` = 10
* `foo` = 1
* `obj` = `[ bar : 2, baz : 3 ]` (the remaining dictionary elements)
* `y` = 20

While lists are split into extracted values and the rest by "position (index)", dictionaries are split by "key name". Sharing this notation results in a highly consistent and beautiful design for both list and dictionary pattern matching.

---

## 6. Heterogeneous Lists

### 6.1 Design Inquiry

It is syntactically possible to combine elements of different types using products.

```sign
` Mixed tuple of numbers and strings
1, `a`, 2, `b`
```

However, it is important to raise the question: **how often are such tuples actually useful in practice?**

### 5.2 Design Guidelines

Sign's list model is fundamentally based on "collections of values of the same type". In situations where mixed types are necessary, using a dictionary type (key-value structure) provides much clearer semantics:

```sign
` Dictionary type makes intentions clearer than a heterogeneous list
person :
	name : `Alice`
	age  : 30
	score : 95.5
```

### 5.3 Relationship with Type Inference

When operations are performed on heterogeneous lists, the type of the first element serves as the baseline according to the left-priority rule. This naturally encourages "explicitly structuring with a dictionary type" rather than "dealing with heterogeneous lists directly".

---

## 7. Conclusion: Unity of the List Model

Sign's list model consists of the following consistent principles:

* Space (Coproduct) = Arrange = Concatenation in 1D
* Comma (Product) = Combine = Lifting dimensions
* Left-Priority Rule = Type is self-evidently determined by the context of the operation
* Character is Address Type = Peeling off type abstraction reveals the hardware form

All of these are expressions of the design philosophy to "abstract types and languages", providing a foundation where programmers can perform mathematically consistent operations without having to consciously worry about types.
