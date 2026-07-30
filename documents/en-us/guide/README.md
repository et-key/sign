# Sign Language User Guide

A documentation set tailored for developers **writing** Sign code.

---

## Essential 3 Reading Material

| Document | Description |
|---|---|
| **[operator_table.md](operator_table.md)** | Full operator symbol table (precedence, semantics, Unit behaviors). **Language Backbone** |
| **[list_cheat_sheet.md](list_cheat_sheet.md)** | Quick reference cheat sheet for common list operations |
| **[example.sn](example.sn)** | Executable sample Sign code |

---

## Core Understanding: 6 Fundamental Symbols

| Symbol | Meaning | Example |
|:---:|---|---|
| `__` | Unit (Identity element in Coproduct) | `__ 5 = 5` |
| `_` | Hole (Placeholder for partial application) | `f _ 3 = $p0 ? f $p0 3` |
| Space | Coproduct (Function composition/apply/list construct) | `f g x = g(f(x))` |
| `,` | Product (Structural list assembly) | `1, 2, 3` |
| `?` | Lambda (Function definition) | `x ? x + 1` |
| `:` | Define (Binding) | `add : x y ? x + y` |

---

## Data Flow: filter $\rightarrow$ map $\rightarrow$ fold

```sign
[> 0,] [* 2,] [+] data
 ↓      ↓      ↓
filter  map   fold
```

Function composition flows **left to right**.
