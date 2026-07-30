# Sign Language Complete Reference Manual

## 1. Syntax & Core Elements

- **Zero Reserved Words**: All undefined identifiers evaluate to `__` (Unit).
- **Function Definition (`?`)**: Preceded by space-separated parameters.
- **Match Case**: Indented block under function definition.
- **Explicit References**:
  - `$` Address-Of
  - `@` Dereference / Load
  - `#` Store / Allocation

---

## 2. Memory & Build Layers (`layer`)

- `layer 0`: Baremetal / MCU, `alloca` prohibited, `@`/`#` are volatile.
- `layer 1`: RAM enabled, `alloca` contiguous blocks enabled.
- `layer 2`: FPU enabled (`Float`).
- `layer 3`: SIMD enabled (`Vector`).
- `layer 4`: Full OS stdlib & dynamic linking.
