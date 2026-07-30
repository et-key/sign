# Sign Standard Library Memory Model Specification

This document specifies the recommended memory model provided by the Sign standard library (Project-Arena / Shared-Heap / Pinned-Area).

---

## 1. Memory Model Patterns

- **Project-Arena**: Memory pool per build unit (project). Bulk-freed on project unload via a Bump Allocator.
- **Shared-Heap**: Process-wide shared area managed via Automatic Reference Counting (ARC).
- **Pinned-Area**: Area guaranteed not to be moved by memory relocators, used for FFI, WASM memory buffers, and hardware IO.

---

## 2. Operator Mappings by Layer

| Operator | Syntax | `layer: 0` | `layer: 1+` |
|:---:|:---:|:---:|:---:|
| Infix `#` (Store) | `ptr # val` | ✅ `write_volatile` | ✅ Standard Store |
| Prefix `@` (Load) | `@ptr` | ✅ `read_volatile` | ✅ Standard Load |
| Prefix `#` (Project alloc) | `#expr` | ❌ Compile Error | ✅ Project-Arena Allocation |
| Prefix `##` (Shared alloc / ARC) | `##expr` | ❌ Compile Error | ✅ Shared-Heap Allocation (ARC) |
| Prefix `###` (Pinned alloc) | `###expr` | ❌ Compile Error | ✅ Pinned-Area Allocation |

> [!IMPORTANT]
> `layer: 0` operates prior to RAM initialization. Dynamic allocation (`#`, `##`, `###`) is prohibited in `layer: 0`.
