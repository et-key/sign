---
name: project-sign-type-system-build
description: "The type system went from spec-only to actually running (2026-08-09): compile.js driver wired pass1b+pass3 into the execution path, the evaluator now reads node.atomType, and Layer 2 gained List(T). Records the settled Layer-2 semantics decisions and the two times the user corrected a wrong call."
metadata: 
  node_type: memory
  type: project
  originSessionId: f564fb92-74d1-4c32-b304-b2fd363a270a
  modified: 2026-08-12T06:11:06.293Z
---

Follow-on to [[project-sign-pre-type-system-audit]]. The B-group items are now closed and the type system is **live** — `pass3` was previously imported only by its own tests.

## What got built

- **`alpha/javascript/compile.js`** — the single Pass 1〜3 driver: `preprocess → parse → buildEnv(1a) → reduceAll(2) → specializeGenericParams(1b) → annotateTypes(3)`, returning `{nodes, env, specializations, diagnostics}`. Every node carries `atomType`. `interpreter.test.js` and the playground now go through it. Parser is injectable (`options.parse`) because tests must keep building from `sign.pegjs` — the prebuilt `parser.js` had silently gone stale once.
- **Pass order deviates from the spec on purpose.** `type_system.md` §5 says 1a → 1b → 2 → 3, but Pass 1b runs *after* Pass 2 in the implementation: what counts as a callsite isn't determined until Pass 2 resolves the space operator into apply/compose/concat. Documented in `compile.js` and `README.md`; a spec-fix candidate of the same family as B-1/B-3.
- **The evaluator reads types.** `evalArith`/`evalCompare` take the operation node (not just children) so they can read `atomType`. This unlocked things that are *impossible* from values alone, since JS collapses `5` and `5.0`.

## Layer 2 semantics that got settled (all now in `type_system.md`)

- **Numeric promotion lattice**, not demotion: `Address ⊕ Float → Float`. Reason given: Sign aims to be a notation for mathematical expression, so `+` silently truncating would make the notation lie.
- **Division is the one place rounding happens** on `Address ⊕ Address` — 四捨五入, ties away from zero (`5/2`→3, `-5/2`→-3), matching AArch64 `fcvtas` in one instruction. Uniform across layers so cross-layer imports can't change results. Emits an `information` diagnostic when precision is actually lost.
- **`'` with a Float index rounds; it does not interpolate.** I first spec'd interpolation (texture sampling / audio resampling / histograms) and the user challenged it with "is it convenient? is it RISC as-is?" — both answers were no: `ldr` is 1 instruction vs ~10 for interpolation, so cost varies 10x behind one symbol; linear interp is just one member of a family real code wants to choose from; and it would re-introduce the silent-wrong-value class just removed from `evalArith`. Interpolation/scatter stay expressible as an adjoint *pair of ordinary functions*.
- **`List(T)`** — Layer 2's first parameterized type. `List` vs `Struct` is decided by *notation* (space vs comma), and `List`'s homogeneity is a **constraint** (violation = compile error), not a classifier. Mix types → use a comma (tuple). Element join reuses the promotion lattice, so `[1 2.5]` → `List(Float)` rather than an error.
- **`String` is the absorbing element of the coproduct**, on both sides. Every value has a text rendering, so a join with String always exists — String never enters the element-type join at all.

## Two corrections the user made (both were right)

1. **"実数に単位元は本当にないと思う？"** — `comparison.md` §2.1 excluded Float from the `{0,1}` arithmetic-identity rule. There was no basis: ℝ is a field, 0 and 1 are its identities exactly as in ℤ. Keeping the exclusion would have meant "Float comparisons always return the left operand", an asymmetry by width class. Fixed, and the same edit dropped the word `Int` from that doc (Sign has no `Int` type; `Address` subsumes uint — the old table treated `Int` and "アドレス型" as separate domains, which was never implementable).
2. **"1 `ab` は `1ab` になるだろう？"** — I had implemented §3.2's "String 左辺なら" literally, so `` `ab` 1 `` → `"ab1"` but `1 \`ab\`` → `[1, "ab"]`. Same operator, different behavior by argument order — exactly the asymmetry the previous commit had just removed elsewhere.

**How to apply:** when writing Layer 2 rules, check the symmetric case and the "does this vary by width class / argument order" question *before* proposing — both corrections above were catchable that way. Also: prefer asking "is this RISC as-is?" of any rule whose cost isn't visible at the call site.

## `Implicit(T)` / `Iterator(T)` and why Sign has no `wait` (2026-08-09, later)

Both types were **already used in `type_system.md` §4's signature table but missing from §2's Layer 2 table**; added them (commit aee83d5, spec only — pass3 does not infer them yet).

- `Address` = an address **as a value** (GPR-width, same bit representation as uint) — produced by `$expr`
- `Implicit(T)` = a **place** you can write through — produced by `'`, prefix `~`, prefix `#`
- `Iterator(T)` = a **Pull-type stream** — produced by the range operators and by a bare rest param

`$` is the explicit promotion `Implicit(T) → Address`, which is why `$[array ' 0] # 99` reads as "take the place `'` produced, make it first-class, write through it".

**Why this matters, per the user's own framing:** `f : [x ~xs]` (bracket) vs `f : x ~xs` (bare) is not an eager/lazy performance choice — brackets create a *boundary*, which is why `f : [x ~xs] [y ~ys]` works and `f : x ~xs y ~ys` cannot (a bare rest swallows everything remaining). Verified: 3 bracket rests destructure independently; the bare double-rest form silently returns `__` instead of being rejected (原理4 violation, still unfixed). The bracket form is a *superset*, not an alternative — it can even hold a stream's address.

**Simultaneous IO settles the priority.** Playing audio while doing image processing is not parallel execution — it's DMA + interrupts, i.e. holding several live addresses at once. Sign already has the IO side (`@`/`#` auto-volatile at layer 0, `@0x00` physical access, the interrupt vector table named in `system_semantics.md`). The missing piece is exactly `Implicit(T)`. So it is **load-bearing for writing an OS, not an optimization** — this reprioritizes the "shape/layout pass" from [[project-sign-currying-design]].

**ISR design (agreed, unwritten, unimplementable in alpha — no `option.ms` handling exists):** don't add syntax. `option.ms` already declares memory regions (`memory : rom/ram : origin … length …`); add a `vector` region, and *derive* ISR-ness from "this function's address was written into the vector region". Same shape of analysis as Pass 1b's callsite enumeration. `0x08 # $handler` already composes from existing operators. Needs a §6.3 reconciliation (an ISR is the one legitimate "alive with zero callsites" function). Memory barriers and `WFI`/`WFE` stay in `asm_volatile` — they carry no algebraic meaning (原理1).

**Sign has no `wait` keyword because waiting is already four things in the existing algebra**, and the user called this the opening for the language's asynchrony story:
1. **prefix `~` = suspend** — `list_model.md` line 230 says "前置~ で持ち上げ（余積が一回待機に入る）"; postfix `~` resumes
2. **consuming an `Iterator` *is* waiting** — Pull-type means the value is produced only when the consumer asks (§2.3)
3. **polling = `|` + tail recursion** — MMIO reads are non-blocking and yield `__` when not ready; `__` + the completeness axiom + TCO together compile to the same machine code as C's `while(!ready);`
4. **`WFI`/`WFE` = `asm_volatile`**

C needs `wait()` as a *verb* because issuing an operation and awaiting completion are separate. Sign is Pull-based, so waiting is a *type* (`Iterator(T)`), not a verb — which is "functions are verbs" (the user's second founding realization) taken to its conclusion.

**Gap noted, not yet written:** the "prefix `~` suspends / consuming an Iterator waits" story exists only as a one-line comment in a `list_model.md` example. It is absent from §2, §4, and `system_semantics.md`. Offered to write it; the user had not answered yet as of this note.

## The operator table IS the type system, and it should be scoped (2026-08-09, late)

The single biggest reframing of the session. `guide/operator_table.md`'s 基本原則 already says:

- 「定義演算子による識別子の宣言は、**同時に型を生成する**」
- 「持ち上げる／持ち下げる演算子の関係性が、**包括的に型を決定する**」
- 「余積はコード生成前に対応する型付けが可能であるため、**この言語は静的型付け言語である**」

So "the type system" and "the operator table" are not two things — types are *generated by* operators, so the table is the type rules. I had been treating them as separate all day.

**Self-hosting mechanism (user, verbatim shape):**

```
[+] : "
	...raw target assembly...
"
```

`"..."` is the Volatile block (already in `operator_table.md`'s 特殊記号 table: バックエンドコードの直接挿入). So operator *meanings* are written in a Sign library, not hardcoded in the compiler. That is what makes 原理1's "as-is" literal rather than metaphorical. Override/restore works because **files have scope** — leaving the file restores the outer definition.

**Measured gap:** none of this works yet. `[+] : x y ? x - y` then `5 + 3` still gives 8 — the define binds but nothing reads it, because `pass2.js` imports `OPERATOR_DICT` as a module-level constant and never consults `env`. Operators are global; the design requires them to be scoped bindings. `"..."` evaluates to `__`.

**Staging discovered (dependencies, not preference):**
1. *Now, interpreter-verifiable*: bit operators (`<< >> && || ;; !!`, all unimplemented), `Implicit(T)`/`Iterator(T)` inference, 原理4's three static rejections.
2. *Before Pass 4*: scope the operator bindings. Testable **without** codegen by overriding with a Sign lambda (`[+] : x y ? x - y`) instead of ASM — build the mechanism first, swap in ASM later. `childEnv`/`envLookup` already provide the file-scope restore behavior.
3. *Needs Pass 4*: `"..."` Volatile, `[+] : "asm"` proper, exact-width access.

## Casts are deliberately absent — and MMIO is written as a library

Sign has no `(UART_Type *)0x40001000` equivalent, and the user confirmed **this is intentional**: a cast is a type *annotation*, and §1 states there is no annotation syntax because 型はコードの影 — there is nothing to annotate. So a type may come only from **provenance**, never from assertion:

- MMIO → from the library that describes the device (NOT from `option.ms`; my `option.ms` proposal was importing C's habit of escaping to the build system when the language lacks expressiveness — unnecessary here because `:` generates a type)
- parsing → read and *construct* via constructor functions (§6.2); never reinterpret
- provenance check → `' !__` returns `$Constructor`, and returns `__` when it cannot be traced statically — an inquiry, never an assertion

**Verified gap:** `$[UART ' DR]` → `__`, `@(base + offset)` doesn't dereference. So the MMIO path is not usable end-to-end; only the struct literal itself types correctly. Same hole as `Implicit(T)`.

## `Dict` renamed to `Struct` (commit 875f4ba)

Everything named `Dict`/`Dictionary`/辞書 became `Struct`/構造体 across 11 spec files and 6 implementation files. The two Layer 2 entries merged into one, and pass3's `productShape()` was deleted (the distinction it drew no longer exists).

Reason: the实体 is a fixed-offset contiguous block whose field names resolve to offsets at compile time and vanish before Pass 4 — no runtime key lookup, no hashing, no dynamic insertion. "Dictionary" never described it. `stack_abi.md` had always written `構造体（Struct / Dict）` as one thing; the Layer 2 table was the sole outlier.

**The real List/Struct criterion** (derived from hardware, added to §2): not "are the elements homogeneous" but **"does one instruction template suffice for Pass 4"**. `List(T)` is same-width cells with a runtime-computable index; `Struct` has per-slot types at compile-time-fixed offsets, so each slot needs its own instruction (GPR vs FPU are different register files). Corollary now in the spec: **a runtime index into a polymorphic Struct is not code-generatable** — `struct ' i` with variable `i` can't select an instruction.

**Open conflict, unresolved:** `stack_abi.md` §7.1 requires fields be laid out in **name-sorted canonical order** (so that `==`-equal structs share a physical layout). MMIO requires **hardware-dictated offsets**. Both cannot hold for the same `Struct`. Not yet decided.

## "Hardware has no types" is false (commit 7225a68, added to 原理1)

Evidence assembled during the session: GPR and FPU are physically separate register files (`add` vs `fadd`); `fcvtas`/`scvtf` are dedicated conversion instructions; a 32-bit device register cannot be written with a 64-bit store; Device-nGnRnE vs Normal memory attributes change reordering/caching legality; Cortex-M vector tables hold addresses while AArch64's hold instructions; ARM function pointers carry the Thumb bit.

What hardware lacks is **runtime tags on values**, not types. Hardware is a static type system without runtime tags — structurally identical to 原理2. So Sign is not imposing types on untyped hardware; it is **transcribing types hardware already has**, and `Address`/`Float`/`Vector` as width classes are the direct consequence.

**Coproduct corollary (also written into 原理1):** the objection "sum types aren't statically determined" assumes the discriminant must live *in the value*. Hardware doesn't — meaning is decided by which instruction touches the bits. Sign puts the discriminant in the ledger the same way.

**But I overstated it once and the user caught it.** I claimed address-as-type makes general sum types free. Two holes: (a) it's circular — it only helps when the address is statically known, which is exactly when there was no dynamism to pay for; (b) it forces indirection where a tagged union is inline, which is strictly worse for cache locality (Rust's enums are fast *because* they're inline). What is genuinely free is the **niche** trick, and Sign's advantage is that `__` is a *single niche shared language-wide*, where Rust must find one per `Option<T>`. Rust's actual costs are mostly monomorphization bloat, not sum types — a direct warning for Sign, since Pass 1b's per-callsite specialization **is** monomorphization.

**Methodological correction from the user, worth keeping:** I had been validating Layer 2 decisions against JS interpreter behavior (`JSON.stringify` equality, `==` returning true). JS erases exactly the distinctions that matter — arrays and objects are both heap references, all numbers are f64, there are no fixed-width cells or offsets. **Judge Layer 2 by "what does Pass 4 emit", not "what does the JS interpreter return"**, and read `stack_abi.md` (the memory-layout spec, which I had never opened) before reasoning about layout.

## "型を作っても消費先が無い" is wrong — I said it repeatedly (2026-08-12)

I framed the type system as producing types with nothing to consume them, on the grounds that Pass 4 doesn't exist yet. The user corrected this: **the consumer is literal sizing at compile time**, and the spec always said so.

`type_system.md` §2 already states it directly:

- `Address` = GPR-width; `Float` = FPU, "幅はターゲットのFPUが持つ**最高精度が自動選択**される" — the type *is* the register-file and width decision
- The `List` vs `Struct` criterion is literally "**Pass 4 が1つの命令テンプレートで済むか**", and §2 has a column headed 「Pass 4 が出すもの」
- Literal layer constraints: a decimal-point literal under `layer < 2` is a **compile error** (prevents FP work before the FPU is initialized)

The error was conflating **"Pass 4 isn't implemented"** (progress) with **"the design has no consumer"** (design). Types already decide which register file, what immediate width, which instruction — that decision is made at compile time regardless of whether the backend that reads it exists yet.

**How to apply:** never describe the type system as speculative or consumer-less. When tempted, name the concrete consumer instead (register class / immediate width / instruction template / layer gate). The same-day work is the evidence: `5 / 2`→3 vs `5.0 / 2`→2.5, and `|...|` deciding 0-vs-零射 by operand type, are both "values can't decide this, the type does".

## What's still open

- Pass 3b (static recording of why an expression converges to `__`) is **spec'd but unimplemented** — `compile()` returns an empty `diagnostics` array. This is the bridge to the formal-methods goal in [[project-sign-origin-and-direction]].
- Comparison-family TypeError for genuinely non-Scalar operands (§4 NOTE) is still unimplemented.
- `type_system.md` §2's List/Struct description vs the Pass-order divergence in §5 both remain spec-fix candidates.
