# System Semantics (Sign Language System-Level Operations)

## Overview
The Sign language supports both high-level functional programming (Application Layer) and low-level primitive operations (System Layer) within the same unified syntax.
This document defines **explicit memory operations** used primarily when implementing the System Layer (compilers, allocators, hardware drivers, etc.).

---

## Differences Between Application and System Layers

### Application Layer (User Code)
- **Memory Management**: Automatic (abstracted away by compiler/GC). Direct calls like `alloc` are not performed.
- **Value Handling**: Pass-by-reference and pass-by-value are automatically optimized depending on context (function application).
- **Direct Address Manipulation**: Direct memory access expressions such as `0x00 # 1` or `@0x00` are available.
- **Prohibitions**: Manual pointer increment or decrement operations are not allowed.

### System Layer (Inside Function Blocks)
- **Memory Management**: Explicit. Logics equivalent to `alloc` can be constructed.
- **Explicit Reference Operations**: `$` (Address Of), `@` (Deref), and `#` (Store) are used to precisely control physical memory layout and pointer passing.

---

## Explicit Reference Operations

To distinguish between Value and Reference (Address) in system programming, the following operators are used:

### 1. `$` Reference (Address Of)
Obtains the location (address) of a variable rather than its value. Primarily used for pass-by-reference or manipulating variable slots directly.

```sign
map $[* 2] ...  ` Pass function object as a reference without copying by value
$heap_ptr # ... ` Write directly into the heap_ptr variable slot itself
```

### 2. `@` Dereference (Load)
Fetches the underlying entity (value) from a reference (address). Used when consuming arguments passed by reference.

```sign
map : f ... ?
    @f ...      ` Extract and apply function entity from reference f
```

### 3. `#` Store (Update)
Writes a value to a target address. Used for variable mutation (re-assignment) or writing to heap memory. The left-hand side must evaluate to an Address (L-Value).

```sign
$heap_ptr # next ` Get address ($) of heap_ptr variable and store next into it
```

---

## Compiler Behavior (Proto A5)

- **Identifier**: Always evaluated as an **R-Value (Value)**.
  - `x` -> `ldr x0, [x_addr]`
- **Assignment Context (LHS of `#`)**: No magic special treatment. The LHS must be an expression that evaluates to an address.
  - `$x # y` -> `adr x0, x_addr; ... str y, [x0]` (Obtains address of `x` and writes `y` to it, equivalent to `*x = y`).
- **Explicit Operations**: `$` and `@` are used thoroughly to eliminate implicit magic type conversions.

---

## Behavior of Literals (`0x00`, `0u00`, `__`) under Reference Operations

Based on the Type System and Value Representation specifications, reference operations on these literals are strictly differentiated:

### 1. `$` (Address Of) Behavior

`$` can be applied to constant literals, returning addresses in statically allocated `.rodata` sections (Read-Only).

- **`$0x00`**: Returns the rodata slot address corresponding to **Address-typed value `0x00`**.
- **`$0u00`**: Returns the address of a **Char-typed niche slot** (bit pattern for U+0000). U+0000 is excluded from valid Char domain and treated as `__` (Unit). Physical MUTF-8 bytes are not used.
- **`$__`**: Evaluates to `__` (Unit).

Attempting to write to these with `#` results in a fatal error.

### 2. `@` (Dereference) Behavior

`@` interprets its RHS as an address (L-Value) and reads memory.

- **`@0x00`**: Interprets Int `0` as an address and **reads value from physical/virtual address 0x00**.
- **`@0u00`**: Attempting to interpret a Char value as an address results in a **TypeError** or instantly collapses into `__` via Unit propagation.
- **`@__`**: Since LHS is Unit, the entire expression instantly collapses into **`__` (Absorber)**.

---

## Physical Address Reference Differences by Execution Layer

Direct memory access using Int values like `@0x00` or `0x00 # expr` depends on the target's `layer`:

### Layer 0 (Baremetal / MCU / Kernel)
- **`@0x00`**: Directly reads physical memory address `0x0000` (e.g., ARM reset vectors, interrupt vector tables).
- **`0x00 # expr`**: Executes direct write to physical address 0.

### Layer 1–4 (OS User Space / VM / JS)
- **`@0x00`**: Accesses virtual address `0x00`, causing a **Segmentation Fault** (Null Pointer Dereference) on most operating systems.
- Trapped as a system-layer exception or immediately terminates the process (fail-fast).
