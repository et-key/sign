# Sign Compiler Pipeline: Design Motivation & Multi-Pass Architecture

> [!NOTE]
> **The canonical source is the Japanese document [compiler_pipeline.md](../../../ja-jp/impl/core/compiler_pipeline.md).**
> This English copy is a *derived translation* and is **behind** the canonical text
> (user ruling, 2026-09-21: "en-us is the older one"). Where the two disagree, the
> Japanese side wins — including against this file. Do not cite this file as the
> specification; read it as a reading aid, and fix the Japanese side when you find a gap.

## 1. Design Motivation: As-Is Compiler for RISC Processors

The symbol selections in Sign's operator table ([operator_table.md](../../guide/operator_table.md)) are chosen to map **as-is** to target RISC processors (AArch64, RISC-V, AVR, SPARC) without intermediate representation normalization layers.

The language permits `"..."` (direct backend assembly injection), assuming that "all behavior can ultimately be directly specified by the user at the instruction level." Whether an individual operator maps directly to a single instruction does not impede language design. Because `"..."` is always available, distinguishing core operators from syntactic sugar depends on Principles 2 and 3 rather than strict 1-to-1 ISA mapping.

---

## 2. Type System Positioning: Types as Ledger, RISC Fixed-Width as Truth

> Principles like heapless allocation and static monomorphic typing are analytical descriptions, not ultimate ends. The physical truth is that RISC hardware only possesses fixed-width registers and fixed-width memory; heapless guarantees and type safety are simply high-level linguistic reframings of these physical constraints.

From this perspective, the type system is positioned as follows:

- Types are a **zero-cost compile-time ledger** (transient accounting records existing exclusively during compilation). They do not exist at runtime and carry zero execution overhead.
- Absolute static type safety guarantees are intentionally eschewed at structural boundaries (e.g., distinguishing between `Point` and `Vector2D` sharing identical field layouts is the caller's explicit responsibility, treated similarly to C unions).

---

## 3. Pass Configuration: Frontend (Passes 1–3) and Backend (Pass 4)

Passes 1–3 (Accounting) reduce user-defined types into "how many bytes wide is this word, and is it signed/unsigned?" before passing data to Pass 4. Pass 4 consumes this ledger, selecting fixed-width register operations and jump instruction templates without inheriting high-level semantic type names.

| Pass | Layer | Responsibility | Output |
|:---:|---|---|---|
| **Pass 1** | Frontend | Identifier Table Collection (Prep pass). Determines structural type (Lambda/Atom) and arity for all identifiers in linear scan. | `.ist` (In-memory table) |
| **Pass 2** | Frontend | Coproduct Resolution. Resolves whitespace semantics using Pass 1 table and converts AST to binary tree. | Typed AST |
| **Pass 3** | Frontend | Layer 2 Type Propagation. Propagates Atom internal types via Left-Hand Priority rules. | Fully Typed AST |
| **Pass 4** | Backend | Code Generation. Consumes compile-time type ledger, discarding semantic names. Selects ISA register ops and jump templates. | Target Machine Binary |

---

## 4. In-Memory `.ist` and Disk `.st` Separation

- **`.ist` (Internal Symbol Table)**: Holds all type information managed during Passes 1–3. Exists **exclusively in compiler process memory** (never written to disk) for security and simplicity.
- **`.st` (Public Symbol Type File)**: Stores type signatures for symbols exported via `#`/`##`/`###`. Written to disk upon build completion.

> [!IMPORTANT]
> **An export mark only applies to lines the `.sn` wrote itself.**
>
> Imports are merged by expanding the source at compile time, but **marks on the
> definitions that came in are dropped** — they appear neither in the importer's `.st`
> nor as `.global` in its `.s`. This mirrors C's `.h` / `.o` split: **including a header
> must not add definitions**. Before this rule, linking two units that read the same
> table produced duplicate symbols (13 measured).
>
> Expansion itself is unchanged, so the **image (data) still lands in the importer**, under
> a local label. Only the symbol duplication disappears; the data duplication remains.

> [!IMPORTANT]
> **When the same name is defined twice, the one written first wins — but the same name across files is refused.**
>
> If two definitions of the same name end up side by side within one file, the
> **second one is not used**. Nothing stops — one `information` is emitted, naming the
> originating file and statement index for both the winner and the refused one. (Line
> numbers are not available: the parser drops comments and tokens carry no position.)
>
> **Defining the same name in two files is a compile error that names both** (user ruling 2026-10-12).
> Dropping one of them by first-wins silently turns the calls inside the dropped file into calls to the other
> file's definition: an importer that wrote the same name before the import line could take over a private name
> of the imported file. The diamond (A imports B and C, and both define the same name) is the same shape.
> Rename one of them. The proper way to avoid the clash is to hide the imported file's private names (not landed).
>
> > [!NOTE]
> > Before (2026-09-19 to 10-11), first-wins applied across files too, with an `information` only — motivated by
> > the diamond, where last-wins changes the answer when the import order changes. First-wins remains within a file.
>
> **Within one file, ordering still matters.** Writing your own definition first makes yours win. The export
> mark (`#`) belongs to the winner too.
>
> This does not conflict with §1's "top-level declarations are order-independent"
> ([`1_definition.md`](../1_definition.md)): order-independence is about **when a reference
> resolves**, first-wins is about **which of two definitions of one name applies**.
>
> What is dropped is **the line itself**. Making only the binding table first-wins leaves
> the two engines split, because Pass 3 writes values back from the node list into the
> bindings (measured: interpreter 12 / machine 14). Dropping the line makes the
> interpreter and Pass 4 read the same list.
