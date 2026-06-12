# Sign Language Specification & Design Notes: Features Similar to Monads and Comonads in Function Definition and Evaluation

## Maybe (Corresponds to `if~then~else` in general languages)
   - When `Unit` is implicitly passed to an argument, the function is not executed. (* Note that passing `Unit` explicitly behaves as a placeholder, which has a different meaning.)
   - Therefore, the counterpart to `else` is represented by default arguments (if a default is not specified, `Unit` is the default).
   - * If there are insufficient arguments, it returns the function partially applied with the provided arguments. Since an unexecuted function returns `Unit`, passing `Unit` yields `Unit`.
   - * In Sign, **an unexecuted function is isomorphic to Unit**.

```sign
f : x y ? x + y

` 3 < 2 is false, so Unit is returned
f 3 < 2 2

g :
		x : 0
   	y : 0
   ?
		x + y

` Since the default value is 0, even if Unit is returned by 3 < 2, it defaults to 0, resulting in 2.
g 3 < 2 2
```

## List (Corresponds to Iterator in general languages)
  - When passing a List to a function, the postfix `~` must be used.
  - When the postfix `~` is used, values are distributed and passed to the respective argument lists.

```sign
f : a b c ? a + b + c

list1 : 1 2 3
list2 : 1 , 2 , 3

` Has the same meaning as f 1 2 3
f list1~
f list2~
f [1,2,3]~
f [1 2 3]~
```

## Either (Corresponds to `try~catch~finally` in general languages)
   - Conditional branching within functions can be written using `Match_Case` (which prevents infinite loops in functions).
   - When an abnormal condition occurs within a `Match_Case`, it is sufficient to return `Unit` (assertion: displays an error and returns `Unit`).
   - This allows writing normal termination and normal loops.

```sign
f : x y ?
	x < 0 : `Error : x is negative`
	y < 0 : `Error : y is negative`
	x * y

` The following returns 6.
f 2 3

` The following returns `Error : x is negative`
f -1 -1
f -1 2

` The following returns `Error : y is negative`
f 2 -1
```

## State (Corresponds to "definition and mutation of variables" in general languages)
   - When defining default values in parameter lists, simple stateful calculations are allowed.

```sign
f :
		x : x + 1
		y : x + y
	?
		x > 10 : y
		f x y

` The following returns 60.
f 0 5
```

## IO Reader Writer
   - You may use expressions containing prefix `@` and infix `#` within the calculation of default values.
   - Similarly, you may use expressions containing prefix `@` and infix `#` in the function body.
   - Within a function definition, since the return value of infix `#` is an address, you can write prefix `@` at the caller side to pass the IO (composition of Reader/Writer functors).
   - If you simply want to pass the address itself, pass the expression with prefix `$`.

```sign
F : x y ? x # @y
G : f y ? @x y

` If it is not IO or a higher-order function, it redundantly requires addresses, which impacts performance.
` While it requires caution in description and handling, it expands the range of expression.

` Returns 5 after writing and reading
G @[F 0x10000 $[+ 2]] 3
```

## Zipper
   - You can use the prefix `~` rest argument list operator in the parameter list. (* Lifting: w a -> w(w a) operation)
   - Values passed to the rest argument list are lifted into a "list", allowing normal `get` operations internally.

```sign
f : ~a ? a ' 0 + a ' 2 + a ' 3

` 1 2 3 are passed to f as a list
f 1 2 3
```

   - During function application, using the postfix `~` results in a bialgebra, allowing higher-order operations on lists using prefix `~`.

```sign
map : f x ~y ? @f x , map f y~

map $[* 2] 1 2 3 4 5
```

## Store
   - If the parameter name matches a key name in the passed dictionary, that value is bound to the parameter.

```sign
get_age : age ~obj ? age

dict :
   name : `Johnny`
   age  : 20

` Triggers name ' key operation.
get_age dict~
```
