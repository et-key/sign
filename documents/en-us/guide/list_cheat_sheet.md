# Sign List Operations Cheat Sheet

## Common List Operations

| Operation | Syntax | Example | Result |
|---|---|---|---|
| **List Construction** | Space or `,` | `1 2 3` or `1, 2, 3` | `[1 2 3]` |
| **Range List** | `~` | `[1 ~ 5]` | `[1 2 3 4 5]` |
| **Map** | `[op,]` | `[* 2,] [1 2 3]~` | `[2 4 6]` |
| **Filter** | `[cond,]` | `[> 0,] [1 -2 3]~` | `[1 3]` |
| **Fold / Reduce** | `[op]` | `[+] [1 2 3]~` | `6` |
| **Expansion** | Postfix `~` | `[1 2 3]~` | Elements expanded in coproduct |
