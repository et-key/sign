# Categorical Truth Values in Sign: Specification Based on a Category-Theoretic Approach

## 1. Overview

This document specifies the handling of logical truth values in the Sign language to enhance mathematical consistency and design coherence.

- Unit (`_`): Empty lists and unevaluated function literals are `false` (falsy).
- All other values (including `0`) are `true` (truthy).

## 2. Theoretical Background

### 2.1 Category-Theoretic Perspective

In category theory, `0` plays an important role as the "initial object". The initial object is a special entity that has a unique morphism to any other object, meaning it is treated as "something" (possessing functionality/structure) rather than "nothing".

On the other hand, Unit / empty list represents the state of "nothingness", so it is natural to treat it as a logical "false". This aligns with the concept of `Nothing` in monad theory.

### 2.2 Mathematical Consistency

In ZFC set theory, `0` has a special role as the additive identity element in a Ring. In category theory, however, `0` functions as the initial object. Since Sign's characteristics—such as "invisible strong typing" and "list-based unified data model"—are closer to category-theoretic thinking, treating `0` as `true` provides a more consistent mathematical foundation.

## 3. Practical Benefits

### 3.1 Clear Semantics

- The distinction between "whether a value exists" and "whether a value is 0" becomes clear.
- The concept of `0` as a calculation result is clearly separated from the logical concept of "false".
- Affinities with mathematical expressions are enhanced (since mathematics treats `0` as a valid number).

### 3.2 Consistency in Language Design

In Sign's "list-based unified data model", treating the "empty" state of a list as `false` establishes a clear relationship between the data model and logical truth values. Numbers should be treated as a separate concept.

## 4. Concrete Examples

### Logical Operations

```sign
` 0 is true, so returns x
0 & x

` Empty list is false, so returns Unit (`_`)
[] & x

` 1 is true, so returns x
1 & x
```

### Comparison Operations

```sign
` If comparison is true, return LHS.
` In this example, evaluates to 2
2 < 3

` Comparison operations allow up to three terms. If true, return the middle term.
` In this example, evaluates to 3
1 < 3 < 5

` If comparison fails, return Unit.
3 < 2
```

### Partial Application and Short-Circuit Evaluation

```sign
` Function definition
f : x y ? x + y

` Explicit Unit represents partial application
f _ 4 == [+ 4]

` If a value that evaluates to Unit is passed, it can short-circuit to Unit
f 3 > 2 4
```

## 5. Conclusion

Designing Unit (`_`) / empty lists as `false` and all other values including `0` as `true` enhances consistency with Sign's mathematical foundation (especially category theory) and provides a more intuitive and clear semantics. Through this specification, Sign functions as a more expressive and mathematically robust language.

Most importantly, clearly separating the numeric `0` from the logical "nothingness" provides an intuitive and consistent logical system for programmers to understand.
