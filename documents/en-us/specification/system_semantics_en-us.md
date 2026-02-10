# System Semantics (Sign Language System Description Specification)

## Overview
Sign language supports both "high-level functional description (application layer)" and "low-level primitive operations (system layer)" using the same syntax.
This document defines the **explicit memory operations** used particularly in system layer implementation (compilers, allocators, drivers, etc.).

## Differences Between Application and System Layers

### Application Layer (User Code)
*   **Memory management**: Automatic (hidden by compiler/GC). No direct calls to `alloc` etc.
*   **Value handling**: Pass-by-reference vs pass-by-value is automatically optimized by context (function application).
*   **Direct address operations**: Direct memory access like `0x00 # 1` `@0x00` is possible.
*   **Prohibited**: Pointer increment, decrement.

### System Layer (Inside Function Blocks)
*   **Memory management**: Explicit. Logic equivalent to `alloc` can be constructed.
*   **Explicit reference operations**: Use `$` (Address Of), `@` (Deref), `#` (Store) to control physical memory layout and pointer passing.

## Explicit Reference Operations

In system description (particularly allocator and high-efficiency library implementation), the following operators are used to distinguish between values and references (addresses).

### 1. `$` Reference (Address Of)
Obtains the "location (address)" of a variable rather than its "value."
Used primarily when passing by reference to a function, or when operating on the variable slot itself.

```sign
map $[* 2] ...  ` Pass function object as reference, not value copy
$heap_ptr # ... ` Write to the heap_ptr variable slot itself
```

### 2. `@` Dereference (Load)
Extracts the entity (value) from a reference (address).
Used when utilizing pass-by-reference arguments.

```sign
map : f ... ?
    @f ...      ` Extract function entity from reference f and apply
```

### 3. `#` Store (Update)
Writes a value to a reference target (address).
Used for variable updates (reassignment) or writing to heap memory.
The left-hand side must always be an address (L-Value).

```sign
$heap_ptr # next ` Get address ($) of heap_ptr variable, write next there
```

## Compiler Behavior (Proto A5)

*   **Identifier**: Always evaluated as **R-Value (Value)**.
    *   `x` -> `ldr x0, [x_addr]`
*   **Assignment context (left-hand side of #)**: No special treatment. The left-hand side must be an expression that evaluates to an address.
    *   `$x # y` -> `adr x0, x_addr; ... str y, [x0]`
        Gets the address of `x`, writes `y` to where it points (`*x = y`)
*   **Explicit operations**: Uses `$` and `@` throughout, eliminating magic (implicit type conversions).
