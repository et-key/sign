# Type System and Type Inference

## Basic Handling of Types

All types are grounded in `Unit`.
The only value of the Unit type is `Unit`.
The size of Unit is 0.
Unit is represented as `_`.
The left identity of Unit is `Identity`.
The right identity of Unit is the empty list.
All types can have their relations clearly explained by delegation.
Unit is the identity of both the coproduct and the product.
Since Unit is the identity of the bialgebra, it is also the identity of all functions.
The definition of Unit is precisely the Identity of Sign.
Sign is `Self-referential` and represents an `Incomplete` expression.
A `Complete` expression is `Unit` and is represented as `_`.
A `Self-referential` expression can be reduced to a `Complete` expression.
Therefore, Sign is a philosophically valid "language" that can explain Sign using Sign itself.
This is the foundation of the type system.
SignType `*.st` is simply Sign with the addition of the `->` operator.
The `->` operator is not defined in standard Sign `*.sn`.
This allows `*.st` to extensionally guarantee the validity of Sign's self-reference.

### Operators and Types

In Sign, types do not exist on the data itself, but rather on functions.
Therefore, type casting is also performed based on operators.
The table below summarizes the types when operators are treated as functions.

Generics notation: **L represents the left-hand type, R represents the right-hand type.**
`Atom` represents types containing String; `Scalar` represents types not containing String.
`List` represents `(Array | Struct)`; polymorphic lists are `Struct`.
`Implicit` represents `Implicit Address`.

| Symbol | Position (Type Combination) | Type |
| :---: | :---: | --- |
| `#` | prefix※ | `R -> Implicit(R)` |
| `##` | prefix※ | `R -> Implicit(R)` |
| `###` | prefix※ | `R -> Implicit(R)` |
| `:` | infix※ | `(Identifier -> R) -> R` |
| `?` | infix※ | `(List -> R) -> Lambda(R)` |
| `#` | infix※ | `(Address -> R) -> (Address \| _)` |
| `;` | infix | `(L -> R) -> (L \| _)` |
| `\|` | infix | `(L -> R) -> (L \| _)` |
| `&` | infix | `(L -> R) -> (L \| _)` |
| `==` | infix | `(L -> R) -> (L \| _)` |
| `!==` | infix | `(L -> R) -> (L \| _)` |
| `,` | infix※ | `(L -> R) -> List` |
| ` ` | `Atom \| List` infix `Lambda` | `((Atom \| List \| _) -> Lambda) -> (List \| Lambda \| _)` |
| ` ` | `Lambda` infix `Atom \| List` | `(Lambda -> (Atom \| List \| _)) -> (List \| Lambda \| _)` |
| ` ` | `Lambda` infix `Lambda` | `(Lambda -> Lambda) -> Lambda` |
| ` ` | `Atom \| List` infix `Atom \| List` | `((Atom \| List \| _) -> (Atom \| List \| _)) -> (List \| _)` |
| `~` | infix | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~-` | infix | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~+` | infix | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~*` | infix | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~/` | infix | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~^` | infix | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `<` | infix | `(L -> R) -> (L \| _)` |
| `<=` | infix | `(L -> R) -> (L \| _)` |
| `=` | infix | `(L -> R) -> (L \| _)` |
| `>=` | infix | `(L -> R) -> (L \| _)` |
| `>` | infix | `(L -> R) -> (L \| _)` |
| `!=` | infix | `(L -> R) -> (L \| _)` |
| `+` | infix | `(L -> R) -> L` |
| `-` | infix | `(L -> R) -> L` |
| `*` | infix | `(L -> R) -> L` |
| `/` | infix | `(L -> R) -> L` |
| `%` | infix | `(L -> R) -> L` |
| `^` | infix※ | `(L -> R) -> L` |
| `\|...\|` | surrounding | `(L -> L) -> L` |
| `'` | infix | `(L -> R) -> Implicit(Atom \| List \| Lambda) -> Deref(Implicit -> (Atom \| List \| Lambda))` |
| `@` | infix※ | `(R -> L) -> Implicit(Atom \| List \| Lambda) -> Deref(Implicit -> (Atom \| List \| Lambda))` |
| `<<` | infix | `((Address | Register) -> Number) -> (Address | Register)` |
| `>>` | infix | `((Address | Register) -> Number) -> (Address | Register)` |
| `\|\|` | infix | `((Address | Register) -> Scalar) -> (Address | Register)` |
| `;;` | infix | `((Address | Register) -> Scalar) -> (Address | Register)` |
| `&&` | infix | `((Address | Register) -> Scalar) -> (Address | Register)` |
| `!` | postfix | `Number -> Number` |
| `~` | postfix | `Deref(Implicit -> (List \| Dictionary \| Atom))` |
| `@` | postfix | `Implicit(Dictionary) -> Deref(Implicit -> Dictionary)` |
| `~` | prefix※ | `List -> Implicit(List)` |
| `!` | prefix※ | `R -> R` |
| `$` | prefix※ | `Lambda -> Implicit(Lambda)` |
| `@` | prefix※ | `Implicit(Lambda) -> Deref(Implicit(Lambda))` |
| `!!` | prefix※ | `Scalar -> Scalar` |

## Lambda Types

### Why can the type of the lambda operator `?` be resolved on the right-hand side?

**Conclusion:** Because the right-hand side is fully determined as a chunk of expressions, and the type of a chunk of expressions is always proven by the transition of function (operator) types.
