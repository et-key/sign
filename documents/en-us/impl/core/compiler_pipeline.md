# Sign Compiler Pipeline: Design Motivation and Pass Structure

## 1. Design Motivation: As-Is Compiler for RISC Processors

The symbol choices in Sign's operator table are designed to be **as-is** relative to target RISC architectures (ARM, AVR, SPARC, RISC-V, etc.) — meaning operator sequences map directly to target instruction streams without intermediate smoothing.

The language permits `asm_volatile` expressions (direct backend assembly insertion), based on the premise that all behavior can ultimately be explicitly written by the user.

---

## 2. Type System Positioning: Heapless Principle & RISC Constraints

> **Heapless principles and static monomorphic typing are linguistic expressions of the hardware constraint: "RISC processors have only fixed-width registers and fixed-length memory."**

- Types act as **zero-cost compilation ledgers** at runtime, disappearing completely after compilation.
- Type safety guarantees are not enforced for struct misinterpretations (e.g. `Point` vs `Vector2D` with identical field shapes), leaving responsibility to the caller (similar to C unions).

---

## 3. Pass Structure: Frontend (Pass 1–3) and Backend (Pass 4)

| Pass | Layer | Responsibility | Output |
|:---:|---|---|---|
| **Pass 1** | Frontend | Identifier Table Collection (Pre-pass). Linear scan determining structural types (`Lambda`/`Atom`) and arities | `.ist` (In-memory, all identifiers) |
| **Pass 2** | Frontend | Coproduct (Space) Resolution. Fixes space semantics into binary AST nodes using `.ist` | Typed AST |
| **Pass 3** | Frontend | Layer 2 Type Propagation. Propagates Atom Subtypes according to LHS-Priority rules | Fully Typed AST |
| **Pass 4** | Backend | Code Generation. Consumes type ledgers, emitting target register operations and jump instruction templates | Target Instruction Stream |

---

## 4. Separation of `.ist` (Internal) and `.st` (Public)

| Artifact | Content | Substance | Lifetime |
|---|---|---|---|
| **`.ist`** | All internal type information used by Passes 1–3 | **In-memory data structure only** (Never written to disk) | Compilation process duration only |
| **`.st`** | Exported identifiers via `#`/`##`/`###` | Physical file on disk | Persistent build artifact |

### 4.1 Generation Timing and Scope
- **Timing**: Constructed in bulk at the end of Pass 1. Enables unified cycle detection and clean target offset calculations.
- **Scope**: Reachable type universe from entry point. Unused code is never scanned, resulting in zero dead code type-checking or code emission.
