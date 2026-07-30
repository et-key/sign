# Sign Build System Specification: `option.ms` and Compilation Layers

## 1. Overview

> [!IMPORTANT]
> **Sign compiler configuration is managed via `option.ms` (MetaObjectForSign) files rather than command-line flags.**

Principles:
1. **Declared via files**: Command-line arguments are used only for emergency overrides.
2. **Directory-scoped**: Placed only in directories requiring custom settings.
3. **Lexical Inheritance**: Subdirectories implicitly inherit parent configurations.

---

## 2. Compilation Layers (`layer`) and Hardware Constraints

The `layer` field declares allowed language feature sets during compilation based on hardware initialization state:

| Layer | Alias | Description | `alloca` | `Int` | `Float` | `Vector` | Dynamic Modules | Supported Linking |
|:---:|:---:|---|:---:|:---:|:---:|:---:|:---:|:---:|
| `0` | bare | Lowest baremetal layer prior to RAM initialization. `@`/`#` are volatile. | ✗ | ✓ | ✗ | ✗ | ✗ | Static only |
| `1` | alloc | RAM initialized; `alloca` contiguous blocks available. | ✓ | ✓ | ✗ | ✗ | ✗ | Static only |
| `2` | fpu | FPU initialized. `Float` literals enabled. | ✓ | ✓ | ✓ | ✗ | ✗ | Static only |
| `3` | simd | SIMD initialized. `Vector` operations enabled. | ✓ | ✓ | ✓ | ✓ | ✗ | Static only |
| `4` | std | Full OS-dependent layer with dynamic modules. | ✓ | ✓ | ✓ | ✓ | ✓ | Dynamic / Static |

> [!IMPORTANT]
> Attempting to use `Float` literals in `layer < 2` or `Vector` types in `layer < 3` results in a **Compile Error**, structurally preventing access to uninitialized hardware.
