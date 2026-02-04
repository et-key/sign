# High Priority Operators Implementation Walkthrough

## Accomplishments
Implemented the following High Priority operators in `proto\wa1\compiler.js` without modifying the parser:

1.  **Logical OR (`|`)**: Short-circuiting. Returns LHS if truthy (!NaN), else RHS.
2.  **Logical AND (`&`)**: Short-circuiting. Returns LHS if falsy (NaN), else RHS.
3.  **Logical XOR (`;`)**: "Choice" XOR. Returns the unique Truthy operand if distinct, else `NaN`.
4.  **Absolute Value (`|...|`)**: Implemented by intercepting the `!-` (parser specific unary) operator.
5.  **Power (`^`)**: Implemented via Wasm Import of `Math.pow`.

## Changes
- **`compiler.js`**:
    - Added `SECTION.IMPORT`.
    - Updated `constructor` to inject imports (`Math.pow`) BEFORE runtime functions to ensure correct function indexing.
    - Updated `emit` to include Import Section.
    - Updated `compileDefinition` to correctly sync function indices accounting for imports.
    - Updated `compileDefinition` to allocate 2 scratch locals (for XOR).
    - Updated `compileExpr` with logic for all 5 operators (updated XOR to use non-boolean return).
- **`run_wasm.js`**:
    - Updated to providing `env` import object with `pow: Math.pow`.

## Verification Results (`test_operators.sn`)

| Test Case | Expression | Expected | Result | Validation |
|-----------|------------|----------|--------|------------|
| `test_or_true_tt` | `2 \| 3` | `2` | `2` | ✅ |
| `test_or_true_tf` | `0 \| _` | `0` | `0` | ✅ |
| `test_or_true_ft` | `_ \| 1` | `1` | `1` | ✅ |
| `test_or_false_ff` | `_ \| _` | `NaN` | `NaN` | ✅ |
| `test_and_true_tt` | `0 & 1` | `1` | `1` | ✅ |
| `test_and_false_ft` | `_ & 1` | `NaN` | `NaN` | ✅ |
| `test_and_false_tf` | `0 & _` | `NaN` | `NaN` | ✅ |
| `test_and_false_ff` | `_ & _` | `NaN` | `NaN` | ✅ |
| `test_xor_true_tf` | `0 ; _` | `0` | `0` | ✅ |
| `test_xor_true_ft` | `_ ; 1` | `1` | `1` | ✅ |
| `test_xor_false_tt` | `2 ; 3` | `NaN` | `NaN` | ✅ |
| `test_xor_false_ff` | `_ ; _` | `NaN` | `NaN` | ✅ |
| `test_abs` | `\|-5\|` | `5` | `5` | ✅ |
| `test_pow` | `2 ^ 3` | `8` | `8` | ✅ |

> [!NOTE]
> `;` returns `NaN` (False) if operands have same truthiness. If one is Truthy and one Falsy, it returns the Truthy one.

## Next Steps
- Implement Medium Priority Operators (Range, Access, Factorial).
