# Sign Language Preprocessor Design Specification

## 1. Standardization of Argument Names and Position-Based Translation

The Sign preprocessor automatically converts user-written parameter names into position-based standard identifiers (`_0`, `_1`, `_2`...). This unifies processing inside the compiler.

```sign
` Original Syntax
increment : n ? n + 1
add : x y ? x + y

L : x ? x
R : _ ~x ? x

` After Translation
increment : _0 ? _0 + 1
add : _0 _1 ? _0 + _1

L : _0 ? _0
R : _0 ~_1 ? _1
```

---

## 2. Argument Order Transformation

```sign
` Original Syntax
twice : f ? f f
flip : f x y ? f y x
f : x y z ? x * y + z
g : f 2 _ 3

` After Translation
twice : _0 ? _0 _0
flip : _0 _1 _2 ? _0 _2 _1
f : _0 _1 _2 ? _0 * _1 + _2
g : _0 ? f 2 _0 3
```

---

## 3. Translation of General Block Syntax to Lists (Automatic `,` Insertion)

In pure list construction blocks (blocks containing no `:` condition arms), the `,` product operator is automatically appended at the end of each line (except the final element).

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
