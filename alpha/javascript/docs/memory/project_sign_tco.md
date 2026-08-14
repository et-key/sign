---
name: project-sign-tco
description: "2026-08-08 (commit 4f5cca6): implemented tail-call optimization via a trampoline in alpha/javascript's interpreter, since Sign has no loop keywords (iteration = recursion only) but the interpreter is a plain tree-walker on top of JS, which never implemented Proper Tail Calls. Deep mutual recursion (was crashing ~n=2000) now runs to 1M+ depth correctly and fast."
metadata:
  type: project
  originSessionId: e668bc95-51c6-4d6d-a258-40161e718088
  modified: 2026-08-08T04:45:16.493Z
---

Surfaced naturally: after the string_and_comment.md audit closed out, the user asked how mutual recursion currently fares. Basic correctness was fine (order-independent, works across nested scopes, unaffected by the day's automatic-currying work) but a deep-depth sanity check (`is_even`/`is_odd` mutual recursion) hit `Maximum call stack size exceeded` around n=2000. Asked the user what's the reasonable next step given everything still unimplemented — recommended TCO over the alternatives (shape/layout pass for `$`/`@`, `==`/`===`/`!==` design work, import) specifically because Sign's `0_design_principles.md` design has **no loop keywords at all** — recursion is the *only* iteration mechanism, so a low recursion-depth ceiling isn't a peripheral gap, it directly caps what the language can express. User agreed immediately ("いいタイミングだと思う").

## Implementation: standard trampoline

`applyClosure` was a plain recursive function; a call in tail position (the function's own final action) would recurse into `applyClosure` → `evaluate` → `applyClosure` → ... growing the JS stack one frame per Sign-level call, even for calls that are logically "the same as a loop iteration." Converted to a `while(true)` loop: a new `evaluateTail(node, env)` mirrors `evaluate()`, but for genuinely-tail-position node shapes (final line of an indent/match_case block; the right side of whichever match_case condition fired; the right side of `|`/`&` when short-circuiting reaches it) returns a `TailCall{closure, argValues}` marker instead of eagerly recursing when it finds a plain Lambda apply. `applyClosure`'s loop catches the marker and continues with the new closure/args *in the same frame*.

Non-tail shapes (compose, pointfree closures, JS builtin functions, or a call whose result still needs further work afterward — e.g. `(f (n-1)) + n`, where `+n` happens *after* the recursive call returns) fall through to ordinary evaluation unchanged, and are still correctly bounded by the JS stack — verified this explicitly (a non-tail-recursive sum to n=100000 still overflows) to confirm the optimization is selective, not an accidental blanket exemption.

The block-evaluation logic (previously living directly in `evaluate()`'s block case) was factored into `evalIndentBlock(node, env, tailEval)`, called from both `evaluate()` (passing plain `evaluate`, unchanged behavior) and `evaluateTail()` (passing itself) — avoids duplicating the match_case/last-line logic in two divergence-prone copies.

## Verified

- `is_even 2000` (the originally-failing case): ~7ms, was a stack overflow before.
- `is_even 100000`: ~65ms. A full million-deep mutual recursion: ~560ms, correct result.
- `sum_to : n acc ? n=0:acc | sum_to (n-1) (acc+n)` (tail-recursive accumulator pattern) to n=100000: ~96ms, correct value (5000050000).
- 8-Queens ([[project-sign-8queens-audit]]), automatic currying ([[project-sign-currying-design]], commit 10f0777), and manual `$`/`@` curry (commit 1651c84) all still produce correct results layered on top of this — the trampoline didn't disturb any of the day's earlier work.
- 133/133 existing tests unaffected.

**How to apply:** if a future recursive Sign program silently hits a stack overflow, first check whether the recursive call is genuinely in tail position (nothing happens to its result afterward) — if it's structured as `(recursive-call (n-1)) op something` rather than the recursive call itself being the branch's final value, no amount of trampolining will save it; the fix is restructuring the algorithm to be accumulator-based (tail-recursive) the way `sum_to` above is, not an interpreter change. The `(solve ...) | try_col ...` pattern from 8-Queens's `try_col` is a real example of a *left* side that's NOT tail-callable (its Unit-ness must be inspected before deciding whether to use it) sitting right next to a *right* side that is.
