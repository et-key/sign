# Sign Language: List Model, Type Conversion, and Multidimensional Arrays

## 1. Core Principle: All List Operations Expressed with Just Two Operators

All list operations in Sign are expressed through the combination of just two operators.

| Operator | Name | Category-Theoretic Meaning | Intuitive Meaning |
|----------|------|---------------------------|-------------------|
| ` ` (space) | Coproduct | Juxtaposition / concatenation | "place side by side" |
| `,` (comma) | Product | Structural composition | "combine together" |

These two operators stand in the relationship of **adjoint functors** in category theory. Coproduct and product are designed as mathematical duals of each other — once one is determined, the other follows naturally.

---

## 2. Coproduct (Space): Building and Concatenating 1-Dimensional Lists

### 2.1 Juxtaposition of Scalar Values

```sign
` Comma-separated (comma may be omitted for scalar types)
1, 2, 3, 4, 5

` Space-separated also forms a 1-dimensional list
1 2 3 4 5

` The following three are all equivalent
myPairs  : 1 2 3 4 5
myPairs0 : [,] 1 2 3 4 5
myPairs1 : 1, 2, 3, 4, 5

myPairs = myPairs0 = myPairs1
```

### 2.2 List Concatenation

```sign
` List concatenation via space (coproduct) = flat concatenation
[1 2] [3 4] = 1 2 3 4

` Results in a flat list
1 , 2 3 , 4 = 1 2 3 4
```

---

## 3. Product (Comma): Constructing Dimensions

### 3.1 Comma as a "Dimension-Raising" Operator

Where space "places elements in the same dimension," comma "combines them as a new dimension."

```sign
` This is a 1-dimensional list (coproduct: just placing side by side)
1 2 3 4

` This is a 2-dimensional array (product: raises the dimension)
1 2 , 3 4

` The same structure written in block notation
s :
	1 2 ,
	3 4
```

### 3.2 Natural Extension to n-Dimensional Arrays

Nesting commas naturally corresponds to n-dimensional arrays.

```sign
` 2-dimensional (2×3)
1 2 3 , 4 5 6

` 3-dimensional (2×2×2)
[1 2 , 3 4] , [5 6 , 7 8]

` 3-dimensional (2×2×2) in block notation
v3 :
	1 2 , 3 4 ,
	5 6 , 7 8

` List copy (corresponds to multiplication) = flat copy
[1 2 3 4] * 2 = 1 2 3 4 1 2 3 4

` List lift (corresponds to exponentiation) = copy with dimension raised
[1 2 3 4] ^ 2 = 1 2 3 4 , 1 2 3 4

` List split (corresponds to division)
[1 2 3 4] / 2 = 1 2 , 3 4

` Expand operator: expands the inner structure one level, then coproduct is auto-evaluated
` Inner structure expanded one level → product is dissolved into coproduct
[1 2 , 3 4]~   = [1 2 3 4] = 1 2 3 4

` Since prefix ~ is the "lift" operator, the following identity holds
` between the comma function and the unit element
[,] = [~_]

` This gives rise to the following algebra for scalar types
[,] 1 2 3 4 5 = [~_] 1 2 3 4 5 = ~[1 2 3 4 5] = 1, 2, 3, 4, 5 = 1 2 3 4 5
```

This algebra, in which `[,]` (product) and coproduct (space) converge to the same thing for scalar types, is the natural manifestation of the adjoint functor theorem in the language's behavior. Prefix `~` (lift) and postfix `~` (expand) are adjoint pairs — mutually inverse operations — and applying both returns the original structure. This is also the moment where the rule "comma may be omitted for scalar types" is proven algebraically.

Postfix `~` is an operator that **expands the inner structure by exactly one level**. Prefix `~` lifts, postfix `~` expands — the same symbol carries mutually inverse operations depending on its position.

### 3.3 Symmetry of Coproduct and Product

```sign
` Coproduct: flat concatenation (brackets cause inner coproduct to evaluate first)
[1 2] [3 4]   = 1 2 3 4

` Product: preserved as-is as a 2-dimensional structure
` (writing [[1 2] [3 4]] is different — the inner parts evaluate as coproduct first)
1 2 , 3 4     = 1 2 , 3 4

` Only the expand operator turns it into a coproduct
[1 2 , 3 4]~  = [1 2 3 4] = 1 2 3 4

` Since prefix ~ (lift) and postfix ~ (expand) are mutually inverse, the following holds
~[1 2 , 3 4]~
= [[1 2 , 3 4]]~    ` prefix ~ lifts (coproduct evaluation is suspended one level)
= 1 2 , 3 4         ` postfix ~ expands → original structure restored
```

`1 2 , 3 4` and `[[1 2] [3 4]]` are different. The latter is a two-step expression where `1 2` and `3 4` inside the brackets are each evaluated as coproduct first, and then combined with comma as product. The former directly describes a 2-dimensional structure.

---

## 4. Left-Side Priority Rule for Type Conversion

### 4.1 Core Principle

In binary operations in Sign, **the type of the left-hand side determines the type of the entire operation**. The right-hand side is automatically converted to match the left-hand side's type. If conversion is not possible, a compile error occurs.

The rationale for this design is that "the right-hand side of a binary operation acts as the object of the verb (operator), governed by the left-hand side."

```sign
` Left side is numeric → right-side string is interpreted as a number
0 + `123` = 123

` Left side is string → right-side number is interpreted as a character
`123` + 0 = 0u31 0u32 0u33
```

### 4.2 Behavior Determined by Operator Type: Coproduct vs Arithmetic

The kind of type conversion is determined by the combination of "the left-hand side's type" and "the kind of operator (coproduct or arithmetic)."

**Space (coproduct): structural concatenation**
```sign
` Left side is string → number is stringified and concatenated
`123` 0 = `1230`

` Left side is numeric → simply forms a tuple
1 2 `34` = 1 2 `34`
```

**Arithmetic operators (`+` `-` `*` `/` etc.): when left side is string, each character is operated on element-wise as a code point**
```sign
` Additive identity (+0) exposes code points
`123` + 0 = 0u31 0u32 0u33

` Multiplicative identity (*1) gives the same result ← +0 and *1 are equivalent
`123` * 1 = 0u31 0u32 0u33

` Non-identity values can also be applied
`123` + 1 = 0u32 0u33 0u34   ` each code point +1
`123` * 2 = 0u62 0u64 0u66   ` each code point ×2
```

**Arithmetic operators: when left side is numeric**
```sign
` Right-side string is parsed as a number
0 + `123` = 123
```

What is significant here is that `"123" + 0` and `"123" * 1` are equivalent. `+0` is the additive identity, `*1` is the multiplicative identity — both are "numerically do-nothing operations," yet **the very act of applying an arithmetic operator to a string** exposes the code points. Space (coproduct) is the sole exception that treats strings as strings.

### 4.3 Type Conversion on Lists

```sign
` Adding a string to an int list (coproduct) → the string is interpreted as a number
1 2 `34` = 1 2 34

` Adding a numeric list to a string (coproduct) → numbers are concatenated as string representations
`hello` [32 119 111 114 108 100] = `hello32 119 111 114 108 100`
```

### 4.4 The Moment the True Nature of Characters Is Revealed

When an arithmetic operator is applied to a string on the left-hand side, the layer of type abstraction peels away, exposing **the hardware-level reality of each character (code point type `0u`)**.

```sign
` A string is a list of characters
`abc` = \a \b \c

` Arithmetic operators reveal the true nature of strings (result is 0u type: character code point type)
`123` + 0 = 0u31 0u32 0u33
`123` - 0 = 0u31 0u32 0u33
`123` * 1 = 0u31 0u32 0u33
`123` / 1 = 0u31 0u32 0u33

` Space (coproduct) concatenates as a string
`123` 123 = `123123`
```

---

## 5. Heterogeneous Lists

### 5.1 A Design Question

It is syntactically possible to combine elements of different types using the product operator.

```sign
` A mixed-type tuple of numbers and strings
1, `a`, 2, `b`
```

However, it is important to ask: **how often does such a tuple actually arise in a meaningful context?**

### 5.2 Design Guidance

Sign's list model is fundamentally based on "a collection of values of the same type." When mixed types are needed, using a dictionary (key-value structure) as shown below provides clearer intent.

```sign
` A dictionary expresses intent more clearly than a mixed-type list
person :
	name : `Alice`
	age  : 30
	score : 95.5
```

### 5.3 Relationship with Type Inference

When operating on a heterogeneous list, the left-side priority rule applies with the type of the first element as the baseline. This naturally encourages "structuring explicitly with a dictionary" over "operating on a heterogeneous list as-is."

---

## 6. Summary: The Unified List Model

Sign's list model rests on the following consistent principles.

```
Space (coproduct)      =  place side by side  =  flat concatenation in 1 dimension
Comma (product)        =  combine together    =  raise the dimension
Left-side priority     =  type is determined naturally from the operation's context
Characters as 0u type  =  peeling back the abstraction reveals the hardware beneath
```

All of these are expressions of the design philosophy of "abstracting over types and the language itself," providing a foundation on which programmers can perform mathematically consistent operations without ever thinking about types.
