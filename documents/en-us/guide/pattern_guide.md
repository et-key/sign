# Sign Idiomatic Patterns Guide

## 1. Option / Maybe Pattern using Unit (`__`)

Because undefined identifiers or unfulfilled conditions evaluate to `__`, Sign represents optional values naturally without requiring a wrapper enum:

```sign
safe_divide : x y ?
    y = 0 & __ | [x / y]

result1 : safe_divide 10 2  ` → [5]
result2 : safe_divide 10 0  ` → __
```

---

## 2. Short-Circuit Conditionals

Logical operators `&` (AND) and `|` (OR) perform short-circuit evaluation:

```sign
` Fallback default value when result is __
value : primary_expr | fallback_expr
```
