# Sign Execution Model: Everything is an Internal Function of Main

## Core Principle

> **Every function in Sign is statically inlined and defined as an internal nested function of a single top-level `main.sn`.**

This is the most fundamental property of Sign, underpinning all architectural decisions.

---

## 1. Filename = Entry Point = Function Name

In Sign, `.sn` files are function definitions where the filename equals the function name:

```
add.sn       → Definition of function add
multiply.sn  → Definition of function multiply
main.sn      → Program entry point (equivalent to C's main())
```

`main.sn` serves as the outermost global scope. All imported `.sn` files are incorporated as nested internal functions within `main`.

---

## 2. Imports are Internal Function Definitions

```sign
`add.sn`@~   ` "Imports" add.sn
```

Importing is not reading a file at runtime; it statically defines the nested internal function `add` within the current scope.

---

## 3. Partial Applications as Compile-Time Specialization

```sign
add3 : add 3
add3 5   ` → 8
```

`add3` does not create a dynamic closure struct on the heap at runtime. Instead, the compiler statically specializes `add` with argument `3`, generating a specialized nested function `add3` inside `main`.

No heap allocation, closure objects, or runtime environments exist.

---

## 4. Absence of Closure Escaping Issues

Dangling pointer issues caused by closures outliving stack frames do not exist in Sign:

- All closures are compile-time specialized nested functions.
- The lifetime of nested functions equals `main`'s lifetime (the entire program duration).
- Stack frame escaping is architecturally impossible.

---

## 5. Consequence: Complete Heaplessness

This execution model allows Sign to operate without a heap (in Layer 1 and above):

| Feature | Allocation Method | Rationale |
|---|---|---|
| Saturated Function Call | Register passing | Statically determined |
| Partial Application | Compile-time specialization | No runtime closure needed |
| Arrays / Structs (Layer 1+) | `alloca` contiguous block | Automatically reclaimed at scope end |
| Module Variables | `main` stack frame | Lifetime equals entire program |

No Garbage Collector (GC), `free`, or ownership annotations are required.

> [!IMPORTANT]
> **In Layer 0, `alloca` is unavailable** because RAM and stack are not yet initialized. Layer 0 code relies strictly on register passing and volatile `#`/`@` raw memory operations to bootstrap RAM/stack.

---

## 6. Interaction with Execution Layers

```
layer: 0  → Register passing and #/@ only. RAM/Stack requires manual initialization (alloca prohibited).
layer: 1  → RAM available (alloca contiguous block available).
layer: 2+ → FPU, SIMD, and advanced execution capabilities enabled.
```
