---
name: project-sign-8queens-audit
description: "2026-08-07/08: wrote a real 8-Queens backtracking program in Sign as a stress test; found and fixed 8 real bugs across interpreter.js/pass1.js/pass2.js (Unit-filter, scalar-as-1-list get_prop, mixed bracket-destructured params, negative indices, postfix ~ flatten, isUnit([]), get-rest). The original clean recursive design now runs correctly end to end for N=1..8."
metadata:
  type: project
  originSessionId: e668bc95-51c6-4d6d-a258-40161e718088
  modified: 2026-08-08T22:01:56.354Z
---

Idea (from a prompt-injection-tainted message that was correctly ignored, per [[project-sign-diagnostic-severity]]-style caution): write N-Queens in Sign and run it through `alpha/javascript`'s interpreter to surface spec-vs-implementation drift that small guide-example audits (see [[project-sign-bracket-destructuring]], [[project-sign-operator-table-audit]]) hadn't hit. Ended up finding and fixing eight real implementation bugs across three follow-up sessions, all committed — culminating in the original, natural recursive design (no workarounds) running correctly for N=1 through N=8.

## Fixed & committed (a724b1c): `asList` didn't filter Unit as the coproduct identity

`unit.md` §91-92 states `__` is the identity element for coproduct ops (space/comma/`|`/`;`: `__ op x = x`), and §103 states `__ = []`. But `interpreter.js`'s `asList(v) = Array.isArray(v) ? v : [v]` wrapped Unit as `[Unit]` like any other scalar — so `3 __` produced `[3, __]` instead of `[3]`. `push`/`unshift` had an *additional* copy of the bug on their non-`asList` bare side. Fixed all three call sites to special-case `isUnit()`. This was the actual root cause of the queens algorithm silently building `[val, __]`-polluted accumulator lists instead of clean ones.

## Fixed & committed (ef14803): `get_prop` didn't treat scalars as 1-element lists

User's key correction this session: **Scalar and 1-element List are the same object** under Sign's List/Scalar isomorphism — not "an inconsistency to work around" (my initial framing) but the actual intended design, already visible in how `[5]` (bracket literal) evaluates to bare `5`. Given that, `5 ' 0` should return `5` (indexing the trivial 1-list at its only position) and `5 ' 1` should return `__` (out of bounds) — but the old `get_prop` required `Array.isArray(l)` and fell straight to `UNIT` for any bare scalar, regardless of index. Fixed by normalizing the left side to a 1-element array before indexing (`const asIndexable = Array.isArray(l) ? l : [l]`), same pattern `asList` already uses for list construction. This is the same categorical point (see [[project-sign-type-philosophy]] for the broader thesis) applied to indexing rather than construction — **when a "found a bug" writeup includes "this is inconsistent," that's a prompt to ask whether it's actually a bug or a spec you haven't understood yet.**

## Fixed & committed (8808c14): bracket-destructured params mixed with bare params

`f : a [h ~t] ? ...` (bracket-destructuring for *one* param position, alongside other plain positional params) was completely unsupported — the previous architecture only handled "the *entire* param list is one bracket, destructuring one List/Dict argument" (`f : [x ~xs] ? ...`). Two independent parse-level bugs stacked on top of each other:
- Single-line form: the bracket token leaked into an entry's `name` field as raw unparsed tokens (`{name: [["<h>","~_","<t>"]], ...}`), never recognized as a sub-pattern at all.
- Multi-line form (`f :\n\ta\n\t[h ~t]\n ? ...`): the existing `flattenParamStatements` helper (built for a different case — `func_mixed`, where the *whole* param list is one deeply-indented bracket) aggressively flattened *any* nested array all the way to individual identifiers, so `h`/`t` became two separate *top-level* positional slots instead of one destructured argument — `walk 100 [1 5]` bound `h=[1,5]` (whole array) and left `t` empty.

Fixed with a matched pair of "stop flattening here, this is a self-contained bracket entry" recognizers: `peelBracketEntryToken`/`parseParamStatements` in `pass2.js` (builds a `{name:null, pattern:[...]}` entry instead of flattening through it), plus the identical recognition duplicated in `pass1.js`'s arity counter (`isBracketEntryToken`) — needed because the *old* counter had the same flattening bug and let the bracket's internal `~` leak out as if it were the *outer* function's own rest marker, making the outer arity `Infinity` instead of `1`. `interpreter.js`'s `bindParams` now calls `bindBracketParams` per-pattern-entry when it hits one; `bindBracketParams` itself also got the scalar-as-1-list normalization (same fix as `get_prop`, needed because a destructured slot can legitimately receive a bare scalar that's really a 1-element list).

**User's framing, confirmed correct and worth remembering:** bare `x ~xs` (no brackets, top-level or as one of several bare params) is genuinely variadic — `pass1.js`'s `countBareArity` correctly returns `Infinity` for it, because it spreads directly across the flat incoming-argument stream. But `[h ~t]` *wrapped in a bracket* — whether alone or as one entry among several — takes on a single reference/argument slot (arity contribution of exactly 1); the destructuring happens *after* that one value is received, not by spreading across the caller's argument list. The bracket is what turns "variadic access to the argument stream" into "one bound value, pattern-matched afterward." This distinction is what made both the parse-level bug (flattening the bracket away) and the arity-counting bug (Infinity leaking out) the same underlying category of mistake: failing to recognize the bracket as a variadic→scalar boundary.

## Superseded finding: currying `(f x) y` turned out to be a non-problem once the above landed

My original attempted workaround for `conflict`'s tail-walk was a curried helper (`walk : dist ? [h ~t] ? ...`, called as `(walk dist) placed_list`) — this failed because pass2's apply-vs-construct disambiguation only recognizes a bare identifier statically known to be a Lambda; a parenthesized partial-application result can't be proven callable statically, so `(f x) y` falls back to `construct`/`push`. I started implementing a pass1/pass2 fix for this (arity-chain tracking through curried bodies) before the user redirected: **the real fix wasn't "make currying work," it was "make `f : dist [h ~t] ? ...` work as one flat call"** — which is exactly the mixed-bracket-params feature above. Once that landed, there was no remaining need for currying in this use case at all. The curry-detection pass1/pass2 changes were written, then reverted (`git checkout -- pass1.js pass2.js`) before the real fix. **Still true and unfixed if it comes up again:** genuine curried calls `(f x) y` where the intermediate closure isn't just "one destructurable param away from flat" still don't apply-chain — pass2's static arity model has no visibility into a lambda body that itself returns another lambda.

**How to apply:** the "found a discrepancy, worked around it in the algorithm" instinct from the first pass of this audit was too quick to file things as "language limitations" rather than digging for the actual fix. The user's push-back both times ("圏論的に見ることはとても重要", "混在を先に見た方が良い") was about not stopping at the first plausible-looking workaround — the get_prop and mixed-params fixes were both real, committable bugs, not permanent language gaps.

## Fixed & committed (ef053ef): negative indices in get_prop

`5 ' -1` / `[10 20 30] ' -1` now count from the end (`length+i` mapping, `-1`=last), same convention as Python — composes with the existing realized-index-array fetch to give list reversal for free (`list ' [-1 -2 -3]`). User's aside, worth remembering as a running bit: noted the "positive starts at 0, negative starts at -1" asymmetry, then resolved their own joke by pointing out `-0 === 0` so there's no missing/duplicate index at the boundary either way.

## Fixed & committed (b4df873): postfix `~` (expand) was a pure passthrough, now really flattens one level

`list_cheat_sheet.md`'s flatten example (`[1 2,3 4]~ → [1 2 3 4]`) stayed nested before this. Fixed via `v.flatMap(x => Array.isArray(x) ? x : [x])` in `evalUnaryOp`'s "expand" case — kept fully separate from `evalArgValues`'s own expand handling (spreading a list into multiple call arguments), which is a different code path entirely and stayed untouched.

## Fixed & committed (34a069e, and its prerequisite 0902dc2): get-rest (`list ' N~`) is now a real tail-slice, and `isUnit([])` is now true

These two landed together and are the ones that finally closed the loop on the *original* `conflict` design (rest-slice-based tail walk, not the index-based workaround used earlier in this same audit).

- **get-rest (34a069e):** `get_prop` now special-cases its right side being a postfix-`~`-wrapped number (`node.right.position==="postfix" && node.right.name==="expand"`) and returns `asIndexable.slice(N)` instead of routing through the same no-op "expand" that scalars get. Deliberately *not* implemented by reusing the range/`buildRange` machinery — a rest-slice is a suffix of an existing finite list, a range is an open-ended arithmetic sequence; conflating them to share one code path was rejected as a bad conceptual fit even though it was tempting (get_prop already accepts a realized range as a multi-index array). Negative `N` falls out of JS's native `.slice()` semantics for free, consistent with the ef053ef convention.
- **`isUnit([]) → true` (0902dc2):** this is the fix for the deep gap flagged as early as this session's very first probes but never actually confirmed as a live bug until get-rest made it observable. `unit.md` §103 states `__ = []`, but `isUnit` only checked identity with the `UNIT` symbol — so a list fully consumed down to a genuine empty array (the correct terminal state of `[h ~t]`-style recursive rest-walking) was never recognized as falsy by `&`/`|`/`!`/comparison checks. Concrete symptom: `conflict 8 1 [1 5]` (should be `__`, safe — no column or diagonal conflict) returned `true`. Root cause: once `placed` became `[]`, `!placed` failed to fire, so `placed ' 0` kept returning `UNIT` (out-of-bounds) forever while `dist` incremented without limit — the recursion didn't error or hang, it "terminated" by *accident* once `dist` grew large enough to numerically coincide with `col` in the `col - (placed ' 0) = dist` line (right-Unit-passthrough turns `col - UNIT` into `col`, and eventually `dist` catches up to equal it) — a plausible-looking wrong answer, not a crash. User's call after I flagged the blast radius (touches every `&`/`|`/`!`/comparison Unit-check in the interpreter): "一先ずそれで対応してみて。問題が出るようなら教えて（想定では全く問題が出ないはず…）" (go ahead, tell me if problems come up — expecting none). None came up: 133/133 existing tests unchanged both before and after.

**Verified end to end:** with both of these landed, the *original* `conflict` design (`conflict col (dist+1) (placed ' 1~)`, no index-counter workaround) now runs correctly — `solve 1 N __` for N=1,2,3,4,5,8 all match known-correct N-Queens answers (N=2,3 correctly report no solution; N=4→`[3 1 4 2]`, N=8→`[4 2 7 3 6 8 5 1]`, etc.).

**Nothing left open from this audit.** If a future session hits another "Sign can't do X" wall, the lesson from this whole audit is the same one repeated three times: spend a beat checking whether X is actually missing, or a smaller/more foundational thing X was quietly built on top of.

## Bonus, same day (187a970): range-family gap from [[project-sign-operator-table-audit]] also closed

Not discovered via the queens program itself, but fixed in the same session while riding this momentum. `~-`/`~*`/`~/`/`~^` (the 4 derived range operators besides `~+`) had been flagged as "not yet fixed, should be easy" back in the operator-table audit. Turned out the fix really was that easy — `rangeStepFn` already dispatched all 5 correctly, the bug was just that the 3-term `"range"` eval case's guard checked for the single literal name `"range_arithmetic"` (what `~+` specifically produces) instead of recognizing all 5 distinct per-operator AST node names. Full detail in [[project-sign-operator-table-audit]].

## Cleanup pass on the queens program itself (2026-08-08, later): what the day's fixes bought

User asked why `placed` ever had to receive Unit. Two findings:

**Self-inflicted part:** the top-level call `solve 1 8 __` never needed the explicit `__` — `solve 1 8` works, because an absent argument already *is* Unit. Writing it was a habit from languages that require every argument. (Note the automatic-currying work, [[project-sign-currying-design]], later split these two: an *absent* argument below requiredArity now produces a partial closure, while an *explicit* `__` still triggers the completeness axiom — they used to be identical.)

**Genuine part, and the answer to "does solve want to eat Unit?": yes, and that's correct.** Verified empirically that dropping the `placed : __` default from *either* `solve` or `try_col` breaks the program (drop try_col's → `__`; drop solve's → a partial closure). Both are needed because the empty board propagates down the whole call chain, and "empty" *is* Unit (`__ = []`). The `: __` declaration isn't a workaround — it's the honest signature for "this parameter is optional; absent means empty."

**Real simplification the day's fixes enabled** — rewriting `conflict` with the now-working mixed bracket destructuring took it from 9 lines to 5:
```
conflict : col dist [h ~t] ?
	h = col : !__
	h - col = dist : !__
	col - h = dist : !__
	conflict col (dist + 1) t
```
Signature fits on one line again (no multi-line param block); `placed ' 0` ×3 and `placed ' 1~` become `h` ×3 and `t`; and **the explicit base case `!placed : __` disappears entirely** — when the board is empty, `[h ~t]` can't bind `h`, so the completeness axiom collapses the call to `__`, which already means "no conflict." Verified N=1..8 still correct.

**Spec correction I got wrong, worth remembering:** I briefly "fixed" `pass2.js`'s `splitBareParamTokens` to accept inline defaults in a bare param list (`f : x y : __ ? ...`), on the theory that pass1's `countBareArity` already anticipated them (it does have a `:` branch) and pass2 disagreeing was a bug. **The user corrected this: bare-form inline defaults are a spec violation, not an unimplemented feature.** Defaults require the indent-block form:
```
f :
	x
	y : __
 ? ...
```
Change was reverted; the original code comment ("裸形式では現行仕様に例が無いため未対応") was right all along, and is now stated more firmly. Lesson: pass1 having speculative handling for a form is not evidence the form is legal — check the spec/user before "reconciling" a pass1/pass2 disagreement in the permissive direction.

**Real bug found along the way (commit 643633e):** while trying a rest-param version of the accumulator, `try_col (col + 1) row n placed~` was rejected by the §5.4 check ("List passed to a bare-rest function without postfix `~`"). Root cause: `isListLike` classifies *any* paren/bracket/brace block as a List without inspecting contents, so an ordinary grouping paren around a scalar (`(col + 1)`) tripped it. Added `isRealListValue` (multi-line block, or single line whose content is a list-producing op: construct/concat/push/unshift/product/range-family) and pointed `listShape` — used only by the §5.4 check — at it. The Atom-Atom push/concat branch still uses `isListLike` directly, since "how do two juxtaposed values combine" is a genuinely different question from "is this operand a List value."
