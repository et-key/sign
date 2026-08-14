---
name: project-sign-return-value-addressing-design
description: "Design: any function returning a variable-length value (String, List — anything list_model-isomorphic) is implicitly returning a reference, not a copied scalar. This breaks the named/exported/local lifetime trichotomy from project-sign-currying-design (a return value has no name yet at the point of return, but must outlive the callee's frame). Proposed resolution: sret-style calling convention — caller pre-allocates the return slot, callee writes into it via `#`. Not implementable/observable in alpha/javascript (JS's GC already makes this a non-issue) — design-only, for the eventual real compiler."
metadata:
  type: project
  originSessionId: e668bc95-51c6-4d6d-a258-40161e718088
  modified: 2026-08-08T01:19:29.403Z
---

Surfaced 2026-08-08, directly continuing the `$`/`@`/currying design conversation (see [[project-sign-currying-design]] for the full argument this builds on — read that first, this assumes its conclusions). Came up while working through `string_and_comment.md` discrepancies; explicitly scoped as "remember for later" by the user, same as the currying design was before it got implemented — no code involved this time.

## The problem

`f : x ? \`hello\`` — an ordinary function, no `$`/`@` anywhere in sight — still implicitly returns a **reference**, not a copied value. Why: per `list_model.md`, String is isomorphic to a list of characters (same conclusion reached empirically today for `alpha/javascript`'s `get_prop`, see [[project-sign-8queens-audit]]'s scalar-as-1-list work) — and any List-model-isomorphic value is variable-length. A variable-length value can't be returned "by copy" the way a fixed-size Scalar can; under the hood it has to be a pointer/address to wherever the data actually lives, exactly the same as anything explicitly `$`-addressed.

This breaks the clean three-way lifetime classification worked out in [[project-sign-currying-design]] (unnamed → frame-scoped; named-not-exported → lexically-scoped; named-and-exported → Pass1b callsite-enumerable). A **returned value doesn't fit any of the three**: it's not simply frame-scoped (it must by definition outlive the callee's own frame — that's the whole point of returning it), but it also has no name yet at the point of return (the *caller* might bind it to a name via `result : f x`, or might not bind it to anything, or might immediately pass it somewhere else — the callee can't know at compile time). This is structurally the same hazard as C's classic "returning a pointer to a local/stack variable" bug — except here it would be silent and pervasive, since it'd apply to *every* String- or List-returning function, not just ones written carelessly.

## Proposed resolution: sret-style return, built on `#`

Same shape as C++'s RVO or a C ABI's struct-return (`sret`) convention: the **caller** allocates the storage for the return value ahead of time (in the caller's own frame — or higher, if propagating further), and passes its address into the callee as an implicit extra parameter. The callee doesn't "return" a value in the naive sense at all — it writes the result through that provided address using `#` (output, already implemented — see [[project-sign-8queens-audit]]'s `$`/`@`/`#` commit 1651c84), the same primitive already built for exactly this kind of write-through-a-reference operation.

This resolves the lifetime problem entirely: the address being written through was never the callee's own (about-to-be-destroyed) storage — it always belonged to the caller (or further up the chain) from the start. Nothing escapes a frame that's going away; the "reference" implicitly returned always points into memory whose lifetime was already settled by whoever asked for the value in the first place. This keeps the whole design on the "compiler decides everything, nothing left to runtime" side of the line established in [[project-sign-currying-design]] — the caller's call site already knows, statically, where the result needs to end up.

## Generalizes beyond String — user's key addition

Not a String-specific mechanism. **Any** function returning a List-model-isomorphic value (String, ordinary List/array, presumably Struct/Dict too) uses the exact same convention — one unified return-value calling convention across every variable-length type, not per-type special-casing. This mirrors the isomorphism chain already established empirically today (Scalar ≅ 1-element List, String ≅ list of characters) — since they're all "the same kind of thing" under `list_model.md`, they naturally share one calling convention rather than needing bespoke rules per type.

## Why not implementable in alpha/javascript

Same reasoning as the shape/layout-pass gap noted in [[project-sign-currying-design]]: `alpha/javascript` is JS-hosted, and JS's own garbage collector already makes returning a string or array from a function completely safe regardless of scope or naming — there is no dangling-reference hazard to actually reproduce or fix in the JS interpreter, so implementing an sret-style calling convention there would change nothing observable. This is squarely a concern for the eventual real (non-JS-hosted, systems-level) compiler, not something with a concrete alpha/javascript angle today.

**How to apply:** if/when a real (non-GC-backed) compiler backend gets built, this is the design to reach for return values: no naive "callee allocates and hands back a pointer" — always sret-style, caller-provides-the-slot, callee writes via `#`. Combine with [[project-sign-currying-design]]'s naming/export-based lifetime analysis for the *slot itself* (the caller's provided storage still needs its own lifetime determined by the same `:`/`#`-export rules).
