# Sign Preprocessor Architecture & Transformations

## 1. Parameter Standardization via Position-Based Alpha Renaming

The Sign preprocessor renames authored parameter names into positional identifiers (`_0`, `_1`, `_2`...) to unify internal compiler representations and simplify downstream optimizations.

```sign
` Authored Source
increment : n ? n + 1
add : x y ? x + y

L : x ? x
R : _ ~x ? x

map : f x ~y ? @f x , map y~
map $[* 2] 1 2 3 4 5

` Desugared Output
increment : _0 ? _0 + 1
add : _0 _1 ? _0 + _1

L : _0 ? _0
R : _0 ~_1 ? _1

map : _0 _1 ~_2 ? @_0 _1 , map _2~
map $[* 2] 1 2 3 4 5
```

---

## 2. Partial Application and Hole Desugaring

```sign
` Authored Source
twice : f ? f f
flip : f x y ? f y x
f : x y z ? x * y + z
g : f 2 _ 3

` Desugared Output
twice : _0 ? _0 _0
flip : _0 _1 _2 ? _0 _2 _1
f : _0 _1 _2 ? _0 * _1 + _2
g : _0 ? f 2 _0 3
```

---

## 3. General Block Normalization (Automatic Trailing Comma Insertion)

For pure structural block construction (blocks containing no `:` condition operators), the preprocessor automatically appends product `,` operators at the end of each line (except the final line).

```sign
` Authored Source
buildData :
	readFile `data1.txt`
	processRaw input
	validateData processed
	saveResult final

` Desugared Output
buildData :
	(readFile `data1.txt`),
	(processRaw input),
	(validateData processed),
	(saveResult final)
```
