# Sign Language Preprocessor Design: Syntax Candidates

## 1. Standardization of Argument Names and Position-Based Translation

The Sign language preprocessor automatically converts user-written argument names to position-based standard identifiers (`_0`, `_1`, `_2`...). This unifies processing inside the compiler and simplifies optimization.

```sign
` Original Syntax
increment : n ? n + 1
add : x y ? x + y

L : x ? x
R : _ ~x ? x

map : f x ~y ? @f x , map y~
map $[* 2] 1 2 3 4 5

` After Translation
increment : _0 ? _0 + 1
add : _0 _1 ? _0 + _1

L : _0 ? _0
R : _0 ~_1 ? _1

map : _0 _1 ~_2 ? @_0 _1 , map _2~
map $[* 2] 1 2 3 4 5
```

This translation prevents argument name conflicts and unifies the internal processing of the compiler.

## 2. Partial Application and Argument Order Reordering

```
` Original Syntax
twice : f ? f f
flip : f x y ? f y x
f : x y z ? x * y + z
g : f 2 _ 3

` After Translation
twice : _0 ? _0 _0
flip : _0 ? _1 _2 ? _0 _2 _1
f : _0 _1 _2 ? _0 * _1 + _2
g : _0 ? f 2 _0 3
```

## 3. Preprocessing Optimization Strategy Based on Memory Size and Usage Count (Deferred for Minimum Implementation!)

The Sign language preprocessor applies an optimal translation strategy based on the memory size and usage count of defined literals:

| Classification | Usage Count = 1 | Usage Count > 1 |
|-----------------|---------------------|----------------------|
| Small Literal (<32B) | Complete Inline Expansion | Complete Inline Expansion |
| Medium/Large Literal (≥32B) | Complete Inline Expansion | Sharing via Table Reference |
| Recursive Function (All Sizes) | Table Reference | Table Reference |
| Export Definition | Table Reference | Table Reference |

As shown in the table, a table indicating identifiers and their locations is necessary.

What is inline expansion...

```
` Original Syntax
add : [+]
add 2 3

` After Translation
[+] 2 3
```

## 4. Optimal Translation of Comparison Polynomials (Required in early stages, but unnecessary in optimization phase?)

Comparison polynomials in the Sign language have a special structure where each comparison result is used as the input for the subsequent comparison, rather than being a simple chain of comparisons:

### Basic Translation Rules

```sign
` Original Syntax
3 < x = y < 20

` After Translation
[[[3 < x & x] = y & y] < 20] & y
```

```sign
` Original Syntax
1 <= x <= 100

` After Translation
[[1 <= x & x] <= 100] & x
```

## 5. Conditional Branching by Block Syntax (match case support)

Conditional branching using the block syntax of the Sign language is translated into a short-circuit evaluation chain without using temporary variables.

### 5.1 Basic Translation Patterns

```
` Original Syntax
func : x ?
	condition1 : result1
	condition2 : result2
	condition3 : result3
	default_result

` After Translation
func : _0 ?
	condition1 & result1 |
	condition2 & result2 |
	condition3 & result3 |
	default_result
```

### 5.2 Leveraging Short-Circuit Evaluation Characteristics of the Sign Language

- Comparison operations: Return the variable value when true, and Unit (`_`) when false.
- `condition & result`: If the condition is true, it evaluates to `result`; if false, it evaluates to `_`.
- `_ | next_condition`: If the LHS evaluates to `_`, evaluate the RHS.

### 5.3 Translation Examples

#### Numeric Classification
```
` Original Syntax
classify : n ?
	n = 0 : `zero`
	n > 0 : `positive`
	n < 0 : `negative`

` After Translation
classify : _0 ?
	_0 = 0 & `zero` |
	_0 > 0 & `positive` |
	_0 < 0 & `negative`
```

#### Range Checks
```
` Original Syntax
grade : score ?
	score >= 90 : `A`
	score >= 80 : `B`
	score >= 70 : `C`
	score >= 60 : `D`
	`F`

` After Translation
grade : _0 ?
	_0 >= 90 & `A` |
	_0 >= 80 & `B` |
	_0 >= 70 & `C` |
	_0 >= 60 & `D` |
	`F`
```

#### Conditional Branching with Multiple Arguments
```
` Original Syntax
compare : x y ?
	x > y : `greater`
	x = y : `equal`
	x < y : `less`

` After Translation
compare : _0 _1 ?
	_0 > _1 & `greater` |
	_0 = _1 & `equal` |
	_0 < _1 & `less`
```

#### Complex Conditions
```
` Original Syntax
access_check : user role ?
	user = `admin` : `full_access`
	role = `moderator` & user != `guest` : `moderate_access`
	user != _ : `basic_access`
	`no_access`

` After Translation
access_check : _0 _1 ?
	_0 = `admin` & `full_access` |
	_1 = `moderator` & _0 != `guest` & `moderate_access` |
	_0 != _ & `basic_access` |
	`no_access`
```

## 6. Translation of General Block Syntax to Lists (Automatic insertion of `,` at the end of block lines)

When constructing pure lists using block syntax, the `,` product operator is automatically inserted at the end of each line.

### 6.1 Basic Translation Rules

In a pure list construction block that does not contain conditional expressions (using the `:` operator), `,` is automatically inserted at the end of each line.

```sign
` Original Syntax
buildData :
	readFile `data1.txt`
	processRaw input
	validateData processed
	saveResult final

` After Translation
buildData :
	(readFile `data1.txt`),
	(processRaw input),
	(validateData processed),
	(saveResult final)
```

### 6.2 Handling the Final Line

No `,` is inserted after the last element of the list.

```sign
` Original Syntax
simpleList :
	1 + 2
	3 * 4
	5 - 1

` After Translation
simpleList :
	[1 + 2],
	[3 * 4],
	[5 - 1]
```

### 6.3 Automatic Insertion of Brackets

Complex expressions are automatically enclosed in brackets to guarantee the evaluation order.

```sign
` Original Syntax
calculations :
	x + y * z
	func a b c
	simpleValue

` After Translation
calculations :
	[x + y * z],
	[func a b c],
	simpleValue
```

## 7. Clarification of Problematic and Allowed Patterns

### 7.1 Allowed Patterns

#### Pattern A: Pure Conditional Branching
```sign
` ✅ Normal: Block consisting only of conditional branches
classify : x ?
	x < 0 : `negative`
	x = 0 : `zero`
	x > 0 : `positive`
```

#### Pattern B: Pure List Construction
```sign
` ✅ Normal: Block consisting only of general processing
processSteps :
	step1 data
	step2 result
	step3 final
```

#### Pattern C: Evaluation of a Single Expression
```sign
` ✅ Normal: A single complex expression
complexCalc : x ?
	calculateSomethingComplex x y z w
```

### 7.2 Problematic Patterns (Anti-Patterns)

#### Problematic Mixed Pattern
```sign
` ❌ Problem: Conditional expressions and general processing are mixed at the same level of hierarchy
processData : x ?
	preProcess x
	x < 0 : `negative`
	transform x
	x > 100 : `large`
	finalize x
```

### 7.3 Decision Criteria

- **Allowed**: The block contains either only conditional expressions, or only general processing.
- **Problematic**: The block contains both conditional expressions (using the `:` operator) and general processing mixed at the same level of hierarchy.
- **Translation**: If the block contains only general processing, it is automatically converted to a list by inserting `,`.

This specification preserves the "invisible power" and design purity of the Sign language.
