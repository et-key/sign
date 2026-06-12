# Sign — Standard Library Memory Spec

This document defines the **recommended memory model** (Project-Arena / Shared-Heap / Pinned-Area) provided by the Sign standard library.
Only the physical memory access primitives (`$`, `@`, `#`) are defined in the Core language specification (such as the AArch64 implementation spec).
The features in this specification (such as allocation via the `#` prefix) are implemented as a **library or macro** combining these primitives.

---

## 1. Memory Model Design Patterns

- **Project-Arena**
  A memory pool per project (build unit). It is deallocated in bulk upon `Unload`.
  Implementation: A simple bump allocator.

- **Shared-Heap**
  An area shared across the entire process. It is managed by reference counting (RC).
  Implementation: A thread-safe allocator (e.g., mimalloc) or a simple free list.

## 2. Language Primitives Mapping (Syntactic Sugar)

The Sign compiler expands the following notations into standard library function calls (or the standard library defines these operators):

- **Prefix `#` (Project Allocation)**
  - Notation: `# expr`
  - Expansion: `project_arena.alloc expr`
  - Meaning: Copies the value to the Project-Arena and returns its mutable reference (`Ref`).

- **Prefix `##` (Shared Allocation / Promote)**
  - Notation: `## expr`
  - Expansion: `shared_heap.alloc expr`
  - Meaning: Copies the value to the Shared-Heap and returns an RC-managed reference.

- **Infix `#` (Store)**
  - Notation: `ptr # val`
  - Meaning: Writes to the specified address (Core primitive).
  - Note: When writing to a variable, you need to explicitly obtain the address, such as `$var # val`.

- **Prefix `@` (Load)**
  - Notation: `@ ptr`
  - Meaning: Reads from the specified address (Core primitive).

---

### Memory Management at Module Boundaries (Export Operator Derivations)

In Sign, when exporting data to the outside of a module or scope, the lifecycle and ownership handling of that memory can be explicitly controlled using operators.
In addition to the basic `#` operator, the following derivative operators are defined for advanced memory management:

* **`#` (Normal Export)**
  Standard export. An appropriate reference or pass-by-value is performed depending on the context.

* **`##` (ARC / Reference-Counted Export)**
  A boundary operator for safely sharing data across external scopes or threads.
  Data exported through this operator is placed under the control of Automatic Reference Counting (ARC), and the memory is automatically freed when all references are destroyed. Used for safe management of shared states.

* **`###` (Pinned Area Export)**
  A boundary operator that guarantees that the "address will not be moved" by garbage collection (GC) or memory reallocation processes.
  This is used for low-level integration where fixing the memory address (Pinning) is mandatory, such as WASM library integration, sharing memory with C/Rust via FFI (Foreign Function Interface), or directly specifying hardware IO buffers.

## 3. Procedure for Top-level Definition (Load-time Semantics)

Top-level definitions are sequentially evaluated file by file, building the global environment `G`. The definition structure is represented in S-expression as:

```
[":", name, rhs]
```

Load-time processing (simplified):

1. **When `rhs` is a normal expression (does not start with `#` / `##` / `###`)**
   - Evaluate to get value `v`.
   - Bind the name to point to the immutable value/structure in the project-arena: `G[name] := v_projectArena` (in practice, simply storing `G[name] ↦ v` is sufficient).

2. **When `rhs` is `["#", e]` (at the top level)**
   - Evaluate `e` to get value `v`.
   - Allocate a new location `l` in the project-arena and set `σ[l] := v` (mutable cell).
   - `G[name] := ref(l)`

3. **When `rhs` is `["##", e]` (at the top level)**
   - Evaluate `e` to get value `v`.
   - Allocate `v` in the shared-heap (or create it directly in the shared-heap). Create location `l` and set `shared[l] := v`, `rc[l] := initial` (usually 1).
   - Perform `register_global_symbol(module, name, l, mode="promote")`.
   - `G[name] := ref(l)` (shared-ref).

4. **When `rhs` is `["###", e]` (reserved/pin)**
   - Follow the pin implementation policy (allocate in static data segment or pinned-area). `G[name] := ref(l_pin)`. Usually cannot be unloaded.

Note: If recursion is allowed, use the prebinding (placeholder) procedure (described below).

---

## 4. Small-step-like Style Rules (Simplified Representation)

The following are intuitive, small-step-like rules (simplified notation for implementation spec):

- **(Allocation: top-level project ref)**
  - G, ρ ⊢ e ⇓ v  
  - l fresh in project-arena  
  - σ' = σ[l ↦ v]  
  - ------------------------------------  
  - load_top([":", name, ["#", e]], G, σ) ⇒ G[name ↦ ref(l)], σ'

- **(Promote: top-level shared)**
  - G, ρ ⊢ e ⇓ v  
  - l fresh in shared-heap  
  - shared[l] = v; rc[l] := 1  
  - register_global(name, l, mode="promote")  
  - ------------------------------------  
  - load_top([":", name, ["##", e]], G, σ) ⇒ G[name ↦ ref(l)], updated shared

- **(Deref)**
  - G ⊢ r ⇓ ref(l)   and store(l) = v  
  - --------------------------------  
  - ⟨['@', r], G, σ⟩ → ⟨v, G, σ⟩

- **(Assignment)**
  - G ⊢ lhs ⇓ ref(l)   and G ⊢ rhs ⇓ v  
  - σ' = σ with σ[l] := v (and adjust rc if needed)  
  - ----------------------------------------------  
  - ⟨['#', lhs, rhs], G, σ⟩ → ⟨v, G, σ'⟩

- **(Top-level loading order & prebind for recursion)**
  - For mutual recursion support:
    1. Prebind placeholders: for each top-level name, create a placeholder ref or location `l` in the target arena and bind it to `G` (so names are visible during evaluation).
    2. Evaluate RHS expressions with `G` (placeholders visible).
    3. Initialize the placeholders with actual values (and adjust `rc` as needed).

Note: The above is simplified for explanation. In the implementation, handling of `rc`/increment/decrement and reachability must be done strictly.

---

## 5. Unload Rules for module-arena / promote / pin

- **project-arena (module/project)**  
  - Principle: When a module (or project) terminates, the module-arena can be freed in bulk. However, it cannot be freed if objects within it have been promoted externally or are referenced externally.  
  - Implementation: Attach a `module-id` tag to the allocation site. Upon unloading, if external references remain (`refcount > 0` or entry exists in the global table), prevent the release.

- **promote (shared-heap)**  
  - Principle: Objects in the shared-heap are managed by RC/ARC (Reference Counting). They are deallocated once external references are completely gone (though cycles are handled separately).  
  - Countermeasure for cycles: Consider weak references or a manual collector in the early stages. As an operational policy, either avoid cycles when designing shared objects or introduce a cycle-collector.

- **pin (pinned-area / `###`)**  
  - Principle: Permanent resident (unload-prohibited). The loader can unload it only under special circumstances if necessary (requires complex dependency resolution).

- **SCC (Strongly Connected Component) Unit Unloading**  
  - If there are mutual references between modules, consider unloading using the SCC of the dependency graph as the unit of release. If unloading a single module is impossible, provide a mechanism to unload the entire SCC.

---

## 6. Reference Counting (RC/ARC) Policy and Implementation Guidelines

- Each location `l` on the shared-heap holds `rc[l]` (initial value 1).  
- Updating `rc`:
  - Copy/export reference: `rc[l]++`  
  - The last local reference to the reference disappears (scope end, overwritten by assignment, module unload, etc.): `rc[l]--`  
  - `rc[l] == 0` ⇒ dealloc `l`; if its value contains other references, decrement the `rc` of the nested locations (recursive).  
- Concurrent usage:
  - Single-threaded: Non-atomic `rc` operations are acceptable.  
  - Multi-threaded / parallel load: ARC (atomic increments/decrements) is required.  
- Cycles:
  - RC alone cannot free cycles. Proposed countermeasures:
    - Introduce weak references to make back-links in the reference graph weak.  
    - Perform cycle-detection when a module ends (optional).  
    - Introduce a cycle-collector (trace-based).

---

## 7. Handle System (Optional Safety Strategy)

- Instead of passing exported objects directly as raw pointers, this pattern returns a handle (integer ID), and external code operates on them via runtime APIs. This is advantageous for safety and ABI stability.  
- `create_handle(v)` → returns handle `h`. Retrieve the entity using `lookup_handle(h)` (manages `rc` internally). Handles can be safely passed across process/link boundaries.  

---

## 8. Handling in Parser and Language Implementation (Practical Notes)

- **Tokenizer**  
  - `##` and `###` are identified by longest-match (no issues with current `opSymbols` length sorting).  

- **Parser**  
  - Allow `["#", e]` / `["##", e]` / `["###", e]` only during top-level analysis.  
  - If they appear in expressions, currently "ignore" them (they have no normal meaning in evaluation). Leave a flag to trigger syntax errors in future versions.  
  - Typical behavior (pseudo):
    ```js
    if (isTopLevel && rhs[0] === '##') handlePromote(name, rhs[1]);
    else if (isTopLevel && rhs[0] === '#') handleProjectRef(name, rhs[1]);
    else handleNormalTopLevel(name, rhs);
    ```

- **Runtime / Loader**  
  - `handlePromote` allocates (or promotes) on the shared-heap and registers it in the global symbol table.  
  - `handleProjectRef` allocates in the project-arena and inserts the ref into `G[name]`.  
  - During module unloading, resolve dependencies (SCC) and check external references to either release or reject the unload.

---

## 9. API (Recommended Standard Library Functions)

Explicit mutable operations are provided by primitives/libraries. Implicit `++`/`--` will not be introduced in the language.

- **Non-atomic**:
  - `inc(ref)` → returns the new value (after increment). `ref` is `ref(l)`.
  - `dec(ref)` → returns the new value (after decrement).

- **Atomic (parallel environments)**:
  - `atomic_inc(ref)` / `atomic_dec(ref)`  
  - `fetch_add(ref, n)` / `fetch_sub(ref, n)` — returns the old value

- **Others**:
  - `deref(ref)` ≡ `['@', ref]` (also provided as a language primitive)
  - `assign(ref, value)` ≡ `['#', ref, value]` (name of the infix operator)

---

## 10. Examples of Test Cases (S-expressions)

- **project-arena top-level mutable ref**:
  ```
  [":", "cache", ["#", ["map", ...]]]  ;; cache is a ref in the project-arena
  ```

- **shared export (promote)**:
  ```
  [":", "logger", ["##", ["?", ["msg"], ["call", "log_backend", "msg"]]]]
  ```

- **pin (reserved)**:
  ```
  [":", "kernel_io", ["###", ["?", ["buf"], ["call", "direct_io", "buf"]]]]
  ```

- **Read / Update**:
  ```
  ['@', 'cache']          ;; deref
  ['#', 'cache_ref', 42]  ;; assignment
  ```

---

## 11. Additional Implementation Notes and Operational Guidelines

- **Prebinding for Recursion / Mutual Reference**: Before evaluating top-level definitions, prepare placeholders for names and then evaluate the RHS. Recursion is possible by initializing the values after using the placeholders.

- **Export Visibility**: Registration with `##` creates an entry in the loader's global symbol table. To manage versions/ABIs, register in the format `module:name` to prevent name collisions.

- **Security**: APIs involving kernel or hardware access should be provided using `###` (pin) or a combination of `##` and handle APIs. Raw pointers should not be passed externally. Implement permission check mechanisms.

- **Future Extensions**:
  - Make `#` / `##` inside expressions a syntax error (a breaking change in future language version upgrades). Currently, they are "ignored" for compatibility.
  - Add options to `##` to switch between pin/protect (e.g., `##!`).
  - Introduce cycle-collector and weak-ref.

---

## 12. Summary (Design Advantages)

- With explicit memory placement (project-arena / shared / pin), it is immediately clear where user code generates side effects and persistence. This simplifies security and verification.  
- By making project-arena the default, userland can simply rely on bulk deallocation, reducing runtime costs.  
- Top-level promotion using `##` clearly manages externally exposed APIs, making it easier to maintain consistency during linking/loading.
