# Sign Operator Table Quick Reference

Refer to the full specification document at [impl/syntax/operator_table.md](../impl/syntax/operator_table.md).

## Quick Summary of Core Precedence

1. `#` / `##` / `###` (Export)
2. `:` (Define)
3. `?` (Lambda)
4. `;` (XOR), `|` (OR), `&` (AND)
5. `==` / `!==` (Structural Equality)
6. `,` (Product)
7. Space ` ` (Coproduct: compose, apply, apply_reverse, concat)
8. Arithmetic & Comparison Operators (`+`, `-`, `*`, `/`, `<`, `>`, `=`)
