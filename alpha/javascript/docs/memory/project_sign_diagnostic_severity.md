---
name: project-sign-diagnostic-severity
description: "Sign's design decision: undefined-identifier Unit-convergence is diagnosed as 'information', not warning/error — except in tail position."
metadata: 
  node_type: memory
  type: project
  modified: 2026-08-05T07:04:45.487Z
  originSessionId: e668bc95-51c6-4d6d-a258-40161e718088
---

Referencing an undefined identifier in Sign is not a language error — per the existing "未定義識別子のUnit収束" rule (`documents/ja-jp/impl/core/unit.md` §0.1), it safely evaluates to `__` (Unit), and this is a deliberate feature (lets any English word/Unicode symbol act as a free "virtual keyword", e.g. `@lazy tick`). On 2026-08-05 the user confirmed that this convergence should still be *asserted*/surfaced to the developer, but only at **"information"** severity — not warning or caution — specifically so the virtual-keyword idiom isn't discouraged by noisy diagnostics.

The one confirmed exception: `documents/ja-jp/impl/core/tco.md` §3 already specified (before this session) that calling an undefined identifier in **tail position** is a **warning**, because it silently breaks the TCO/mutual-recursion assumption — a much higher-stakes failure mode than the general case.

**Why:** Direct user correction — I initially proposed treating all undefined-identifier references as a blocking/warning-level scope-check error (a fairly standard "undefined variable" diagnostic in most languages). The user pushed back twice: first "assert wa suru tte koto ne" (the check itself is fine, but it must not block/downgrade to noise), landing on info-level as the general rule with tail-position warning as the sole carve-out already implied by `tco.md`.

**How to apply:** Don't propose making undefined-identifier references a hard error/warning in Sign — that's already a settled, confirmed-twice design decision. `unit.md` §0.1 now documents this explicitly. The implementation (`alpha/javascript/interpreter.js`) records these as `{level: "information", message, identifier}` entries in `env.diagnostics` (a shared array threaded through the runtime-env chain via `newRuntimeEnv`), verified in `alpha/javascript/test/interpreter.test.js`. Typo detection was explicitly named out-of-scope for the language itself ("それはAIなら自動でやれるし自明" — that's tooling/AI's job, not the language's).
