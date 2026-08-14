---
name: project-sign-pre-type-system-audit
description: "Pre-type-system behavior audit (2026-08-08): 6 'silently wrong' bugs (group A) found and fixed; groups B (spec-vs-spec contradictions the type system must settle) and C (spec'd but unimplemented) catalogued and still open."
metadata: 
  node_type: memory
  type: project
  originSessionId: a4d43053-52bb-460f-bfdb-47eab10af61f
  modified: 2026-08-08T07:22:57.929Z
---

Before cutting into the type system, the user asked for a full sweep of "is the current behavior satisfying or not" (「現状の挙動で満足がいかないか否かを十分に検証する段階」). Ran ~120 probe snippets against `alpha/javascript` and cross-checked each against the canonical `documents/ja-jp/` specs. Findings were grouped A/B/C; the user said **"Aは直す。それは確実にやることだ"** and A was implemented in full the same session.

## Group A — fixed (all 6, full detail in `alpha/javascript/README.md`'s dated section)

1. **Layer 1 identifier category was `?`-only.** `inc : [+ 1]` / `h : f g` / `k : f` all registered as Atom, so `inc 3` resolved to concat instead of apply — direct forms (`[+ 1] 3`, `(f g) 3`) worked, only *named* ones broke. Fixed by **lazy category resolution**: `pass1.js` stores `binding.rhsTokens`, `pass2.js`'s new `resolveBindingCategory()` reduces it on first reference and memoizes `getCategory`'s answer (+ remaining arity via `resolveKnownArity`, + `derefBoundNode` so name-routed pointfree like `add : [+]` still greedily consumes). Lazy, not eager, because pass1 can't import pass2 (circular) and forward references must keep working.
2. **`#name : <non-lambda>` never bound at runtime** — only `resolveLambdaLine` stripped the export prefix; the generic path left `define(export_internal(<pi>), 3)` and the interpreter bound `undefined` as the key.
3. **`[]` didn't parse** (grammar's `Expressions` required ≥1) — so `__ = []` was unwritable and `guide/example.sn` was unparseable at line 37.
4. **Chain comparison (`comparison.md` §4) unimplemented** — `5 < 7 < 10` gave 5. Built as a `chain_compare` node detected at tier-12 reduction (the tier where higher-precedence ops are already folded and lower ones like `&` are still bare tokens, so `x < 3 & y > 4` can't be misread as a chain).
5. **`!__` returned JS `true`** — `categorical_truth.md` §6 explicitly forbids returning `1`/a boolean (it would reintroduce a Boolean type); it must be the **Id射**. Added an `IDENTITY` value + `getCategory` treating `!<Unit>` as Lambda. Verifying `operator_table.md`'s four identities also forced the **coproduct-identity law in concat** (`__ 5` → `5`, not `[5]`) and made applying a Unit callee pass through instead of throwing.
6. **`!=` alone ignored the §2.1 0/1-select rule** (`0 != 5` gave 0, should give 5).

Two existing tests encoded the old wrong behavior and were rewritten to the spec. Final state: all tests green (interpreter 110/110, ~168 total). Nothing committed — user hasn't asked.

## Group B — still open: the type system has to settle these

- **`type_system.md` is self-contradictory on Layer 1**: §2's table says `[+ 2]`/compose are Lambda, but §5 Pass 1a's pseudocode says "`?` at top level, else Atom". The implementation now follows §2; **the §5 pseudocode should be rewritten** to "category of the RHS expression". Proposed, not yet written — needs the user's OK.
- **Int/Float indistinguishable at runtime** (JS Number): `5 / 2` → 2.5 (left-priority says Address→integer op), `1.0 < 5.0` → 5 (comparison.md §2.1 excludes Float from the {0,1} rule, can't be honored).
- **`1 + \`abc\`` → `"1abc"`** — left-priority says typeof(L)=Address so it should be `__` (the reverse direction is already correct).
- **Struct/List/Dict collapse at runtime** — `(1,2,3) == [1 2 3]` is true.
- **`pass3.js` is not in the execution path at all** (only referenced by its own two tests); there is no single pass1→pass1b→pass2→pass3 driver. **This is effectively the entry point for the type-system work.**

## Group C — spec'd but unimplemented (unchanged)

`===` (throws `未対応の演算 'same'`), `' !__` constructor provenance, `[Point,]` constructor map, enum auto-numbering (`#RGB : Red | Green | Blue`), import (`` `f.sn`@~ ``), bit ops (`<< >> && || ;; !!`), one-line Dict `[x : 1, y : 2]` (silently yields the last value), multi-line Dict inside brackets (parse error). The first three form the `§6.2` cluster — the natural first proving ground for the type system.

Also noted, not fixed: `documents/ja-jp/guide/example.sn` line 95 (`以下は即時評価される`) is prose missing its backticks, so the file still won't parse past there even after fix 3 — a doc typo, flagged rather than silently edited.

**How to apply:** the recommended order given to the user was A → settle the §5-pseudocode spec edit → build the pass1..pass3 driver → use the §6.2 trio as the first real type-system feature. A is done; the next decision point is the spec edit.
