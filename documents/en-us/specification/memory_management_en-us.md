# Sign — Memory Management Standard Library Specification

This document defines the **recommended memory model provided by the standard library** (Project-Arena / Shared-Heap / Pinned-Area) for the Sign language.
The core language specification (AArch64 implementation spec, etc.) defines only the physical memory access primitives (`$`, `@`, `#`).
The features in this specification (`#` prefix allocation, etc.) are implemented as **libraries or macros** combining those primitives.

---

## 1. Memory Model Design Patterns

- **Project-Arena**
  Per-project (build unit) memory pool. Bulk-freed upon `Unload`.
  Implementation: Simple bump allocator.

- **Shared-Heap**
  Region shared across the entire process. Managed by reference counting (RC).
  Implementation: Thread-safe allocator (mimalloc etc.) or simple free list.

## 2. Language Primitive Mapping (Syntactic Sugar)

The Sign language compiler expands the following notation into standard library function calls (or the standard library defines these operators).

- **Prefix `#` (Project Allocation)**
  - Notation: `# expr`
  - Expansion: `project_arena.alloc expr`
  - Meaning: Copy value to Project-Arena and return a mutable reference (Ref).

- **Prefix `##` (Shared Allocation / Promote)**
  - Notation: `## expr`
  - Expansion: `shared_heap.alloc expr`
  - Meaning: Copy value to Shared-Heap and return an RC-managed reference.

- **Infix `#` (Store)**
  - Notation: `ptr # val`
  - Meaning: Write to specified address (Core primitive).
  - Note: To write to a variable, you must explicitly obtain the address with `$var # val`.

- **Prefix `@` (Load)**
  - Notation: `@ ptr`
  - Meaning: Read from specified address (Core primitive).

---

## 3. Top-Level Definition Procedure (Load-Time Semantics)

Top-level definitions are sequentially evaluated per file scope, constructing global environment G. Definition form in S-expression:

```
[":", name, rhs]
```

Load-time processing (concise):

1. `rhs` is a normal expression (head is not `#` / `##` / `###`)
   - Evaluate to get value `v`.
   - Bind name to point to immutable value/structure in project-arena: `G[name] := v_projectArena` (in implementation, simply store G[name] ↦ v)

2. `rhs` is `["#", e]` (top-level)
   - Evaluate `e` to get value `v`.
   - Allocate new loc `l` in project-arena, `σ[l] := v` (mutable cell).
   - `G[name] := ref(l)`

3. `rhs` is `["##", e]` (top-level)
   - Evaluate `e` to get value `v`.
   - Allocate `v` to shared-heap (or generate directly in shared-heap). Generate loc `l`, `shared[l] := v`, `rc[l] := initial` (usually 1).
   - Execute `register_global_symbol(module, name, l, mode="promote")`.
   - `G[name] := ref(l)` (shared-ref)

4. `rhs` is `["###", e]` (reserved/pin)
   - Follow pin implementation policy (allocate to static data segment or pinned-area). `G[name] := ref(l_pin)`. Normally cannot be unloaded.

Note: For recursion support, use the prebind (placeholder) procedure (described later).

---

## 4. Small-Step Style Rules (Simplified)

The following are intuitive small-step style rules (simplified notation for implementation specification).

- (Allocation: top-level project ref)
  - G, ρ ⊢ e ⇓ v
  - l fresh in project-arena
  - σ' = σ[l ↦ v]
  - ------------------------------------
  - load_top([":", name, ["#", e]], G, σ) ⇒ G[name ↦ ref(l)], σ'

- (Promote: top-level shared)
  - G, ρ ⊢ e ⇓ v
  - l fresh in shared-heap
  - shared[l] = v; rc[l] := 1
  - register_global(name, l, mode="promote")
  - ------------------------------------
  - load_top([":", name, ["##", e]], G, σ) ⇒ G[name ↦ ref(l)], updated shared

- (Deref)
  - G ⊢ r ⇓ ref(l)   and store(l) = v
  - --------------------------------
  - ⟨['@', r], G, σ⟩ → ⟨v, G, σ⟩

- (Assignment)
  - G ⊢ lhs ⇓ ref(l)   and G ⊢ rhs ⇓ v
  - σ' = σ with σ[l] := v (and adjust rc if needed)
  - ----------------------------------------------
  - ⟨['#', lhs, rhs], G, σ⟩ → ⟨v, G, σ'⟩

- (Top-level loading order & prebind for recursion)
  - For mutual recursion support:
    1. Prebind placeholders: for each top-level name create placeholder ref or loc in target arena and bind to G (so names are visible during evaluation).
    2. Evaluate RHS expressions with G (placeholders visible).
    3. Initialize the placeholders with actual values (and adjust rc as needed).

Note: The above is simplified for explanation. Implementation must handle rc/increment/decrement and reachability rigorously.

---

## 5. Module-Arena / Promote / Pin Unload Rules

- project-arena (module/project)
  - Principle: On module (or project) termination, the module-arena can be bulk-freed. However, if objects within it have been promoted externally or are referenced externally, they cannot be freed.
  - Implementation: Tag allocation sites with module-id. On unload, suppress release if external references remain (refcount > 0 or entry in global table).

- promote (shared-heap)
  - Principle: Shared-heap objects are managed by RC/ARC (reference counting). Deallocated when external references are completely gone (cycles handled separately).
  - Cycle handling: Consider adopting weak references or manual collector in initial phase. As operational policy, either avoid cycles in shared object design or introduce a cycle-collector.

- pin (pinned-area / `###`)
  - Principle: Resident (unload-prohibited). The loader can unload only with special handling when necessary (requires complex dependency resolution).

- SCC (Strongly Connected Components) unit unloading
  - When there are mutual references between modules, consider unloading by SCC units of the dependency graph. If unloading a single module is impossible, provide a mechanism to unload the entire SCC.

---

## 6. Reference Counting (RC/ARC) Policy & Implementation Guidelines

- Each loc `l` on shared-heap maintains `rc[l]` (initial value 1).
- RC updates:
  - Copy/export a reference: `rc[l]++`
  - Last local reference to ref disappears (scope end, overwrite by assignment, module unload, etc.): `rc[l]--`
  - `rc[l] == 0` ⇒ dealloc l; if the value contains references, decrement rc of contained locs (recursively)
- Concurrent usage:
  - Single-threaded: Non-atomic rc operations are sufficient.
  - Multithreaded/parallel loading: ARC (atomic increments/decrements) required.
- Cycles:
  - RC alone cannot free cycles. Countermeasures:
    - Introduce weak references (weak refs) to weaken back-links in reference graphs.
    - Perform cycle-detection at module termination (optional).
    - Introduce cycle collector (trace-based).

---

## 7. Handle Approach (Optional Safety Strategy)

- Instead of passing exports as raw object pointers, return handles (integer IDs) and external code operates via runtime API. Advantageous for safety and ABI stabilization.
- `create_handle(v)` → returns handle `h`. `lookup_handle(h)` retrieves the entity (rc managed internally). Handles can be safely passed across process/link boundaries.

---

## 8. Parser & Language Implementation Notes (Practical Memo)

- Tokenizer
  - `##`, `###` are identified by longest match (no issue with current opSymbols length sorting).

- Parser
  - Allow `["#", e]` / `["##", e]` / `["###", e]` only during top-level analysis.
  - If appearing in expressions, currently "ignore" them (they have no meaning during evaluation). Leave flags for future syntax error conversion.
  - Typical behavior (pseudo):
    ```js
    if (isTopLevel && rhs[0] === '##') handlePromote(name, rhs[1]);
    else if (isTopLevel && rhs[0] === '#') handleProjectRef(name, rhs[1]);
    else handleNormalTopLevel(name, rhs);
    ```

- Runtime / loader
  - `handlePromote` allocates to shared-heap (or promotes) and registers in global symbol table.
  - `handleProjectRef` allocates to project-arena and puts ref in G[name].
  - On module unload, perform dependency resolution (SCC) and external reference check, then free or refuse unload.

---

## 9. API (Standard Library Recommended Functions)

Explicit mutable operations are provided by primitives/library. The policy is not to introduce implicit ++/-- at the language level.

- Non-atomic:
  - `inc(ref)` → returns new value (after increment). `ref` is ref(l).
  - `dec(ref)` → returns new value (after decrement).

- Atomic (parallel environments):
  - `atomic_inc(ref)` / `atomic_dec(ref)`
  - `fetch_add(ref, n)` / `fetch_sub(ref, n)` — returns old value

- Other:
  - `deref(ref)` ≡ `['@', ref]` (also provided as language primitive)
  - `assign(ref, value)` ≡ `['#', ref, value]` (call name for infix operator)

---

## 10. Test Case Examples (S-expressions)

- project-arena top-level mutable ref:
  ```
  [":", "cache", ["#", ["map", ...]]]  ;; cache is a project-arena ref
  ```

- shared export (promote):
  ```
  [":", "logger", ["##", ["?", ["msg"], ["call", "log_backend", "msg"]]]]
  ```

- pin (reserved):
  ```
  [":", "kernel_io", ["###", ["?", ["buf"], ["call", "direct_io", "buf"]]]]
  ```

- Read/update:
  ```
  ['@', 'cache']          ;; deref
  ['#', 'cache_ref', 42]  ;; assignment
  ```

---

## 11. Additional Implementation Notes / Operational Guidelines

- Prebind for recursion/mutual references: Prepare name placeholders before evaluating top-level definitions, then evaluate RHS. Initializing values after using placeholders enables recursion.

- Export visibility: Registration via `##` creates an entry in the loader's global symbol table. Register in `module:name` format for version management/ABI management to prevent name collisions.

- Security: APIs involving kernel or hardware access should be provided via `###` (pin) or a combination of `##` and handle API. Raw pointers should not be passed externally. Provide permission checking mechanisms.

- Future extensions:
  - Make `#` / `##` in expressions a syntax error (breaking change on language version upgrade). Currently adopts "ignore" behavior for compatibility.
  - Add options to `##` to switch pin/protect (e.g., `##!`).
  - Introduce cycle-collector, weak-ref.

---

## 12. Summary (Design Advantages)

- Explicit memory placement (project-arena / shared / pin) makes it clear at a glance where user code produces side effects and persistence. Security and inspection are easy.
- Making project-arena the default allows userland to use simple bulk-free, reducing runtime cost.
- Top-level promote via `##` clearly manages externally published APIs and facilitates consistency during linking/loading.
