# Function Definition and Its Type

In Sign, there are various ways to define functions.  
Therefore, this document describes these function definition methods with concrete examples.

## Point-free Style Description

When treating any operator as a function, you can enclose the operator in brackets (`[]`).  
In this case, a prefix operator is written as `[<op>_]`, and a postfix operator is written as `[_<op>]`.  
A binary operator in point-free style greedily operates on multiple arguments.  
A point-free description with a `,` appended to a monomial is applied to all of them (like `map`).

```Sign

` Equivalent to Sum
[+] 1 2 3 4 5

` Equivalent to map
[* 2,] 1 2 3 4 5

` Function that negates
[!_] 2 < 3

` Function that factoriales
[_!] 5
```

## Definition Method Using the ? Operator

The `?` operator can be interpreted as an operator with a parameter list on the LHS and a body on the RHS.

```Sign

f : x y ? x + y
```

### Writing match_cases

By inserting a line break and an indented block on the RHS of `?`, the `:` operators inside the body act as pattern matching/match cases (`match_case`).

```Sign

f : x y ?
	x > 3 : x - y
	y < 3 : x + y
	x y
```

### Writing Default Arguments

In an indented block on the LHS of `?`, the `:` operator acts as a default argument description.

```Sign

f :
		x
		y : x + 1
		z : y + 1
	? x y z
```

### Default Arguments and match_cases Can Coexist

```Sign

f :
		x
		y : x + 1
		z : y + 1
	? x y z
		x > 3 : x - y
		y < 3 : x + y
		z
```

It is better to assign types to each of these functions.

## Upon Function Application

Only the application of a function with default arguments exhibits a different behavior.

```Sign

` Normally behaves as partial application
f : [+] _ _ 3 4 5
f 1 2

g :
		x
		y : x + 1
		z : y + 1
	? x y z

` Default arguments of g can be invoked under the following conditions:

` Use .. to explicitly trigger default arguments
g 3 .. ..

` Implicit invocation behaves similarly to if-then-else.
` For example, if _ is calculated due to an unexpected operation, subsequent functions can short-circuit to _

f 3 < 2 1

` In the case of having default arguments,

g 1 3 < 2

` even if an application like this occurs, evaluation will implicitly proceed using the default arguments.
```
