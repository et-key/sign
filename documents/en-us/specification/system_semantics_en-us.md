# System Semantics (Sign Language System Specification)

## Overview
The Sign language supports "high-level functional description (application layer)" and "low-level primitive operation (system layer)" within the same syntax.
This document defines **explicit memory operations** used especially in the implementation of the system layer (compiler, allocator, drivers, etc.).

## Difference Between Application Layer and System Layer

### Application Layer (User Code)
*   **Memory management**: Automatic (hidden by the compiler/GC). No direct calls to functions like `alloc`.
*   **Value handling**: Pass-by-reference and pass-by-value are automatically optimized depending on the context (function application).
*   **Direct address manipulation**: Direct memory access like `0x00 # 1` or `@0x00` is possible.
*   **Prohibited actions**: Incrementing and decrementing pointers.

### System Layer (Inside Function Blocks)
*   **Memory management**: Explicit. Logic equivalent to `alloc` can be constructed.
*   **Explicit reference manipulation**: Uses `$`, `@`, and `#` to control physical memory layout and pointer passing.

## Explicit Reference Operations

In system description (especially in implementing allocators and high-efficiency library functions), the following operators are used to distinguish between a Value and a Reference/Address:

### 1. `$` Reference (Address Of)
Retrieves the "location (address)" of a variable, rather than its "value".
This is primarily used when passing a parameter by reference to a function, or when manipulating the variable slot itself.

```sign
map $[* 2] ...  ` Pass the function object as a reference without copying its value
$heap_ptr # ... ` Write to the heap_ptr variable itself (its slot)
```

### 2. `@` Dereference (Load)
Retrieves the entity (value) from a reference (address).
Used when consuming arguments passed by reference.

```sign
map : f ... ?
    @f ...      ` Retrieve the function entity from reference f and apply it
```

### 3. `#` Store (Update)
Writes a value to the reference target (address).
Used for updating variables (reassignment) or writing to heap memory.
The LHS must always be an address (L-Value).

```sign
$heap_ptr # next ` Retrieve the address of the heap_ptr variable ($) and write next to it
```

## Compiler Behavior (Proto A5)

*   **Identifier**: Always evaluated as an **R-Value (Value)**.
    *   `x` -> `ldr x0, [x_addr]`
*   **Assignment context (LHS of #)**: Not treated specially. The LHS must be an expression that evaluates to an address.
    *   `$x # y` -> `adr x0, x_addr; ... str y, [x0]`
        Obtain the address of `x` and write `y` to the target address it points to (`*x = y`).
*   **Explicit operations**: Use `$` and `@` comprehensively to eliminate magic (implicit type conversions).
