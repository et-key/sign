---
name: feedback-implementation-style
description: "How johnny-shaman likes to collaborate on the Sign language implementation — verify empirically, propose before writing to spec, stay minimal, self-correct."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 182da7d1-e397-4784-8c87-706cb09988d2
  modified: 2026-08-03T11:04:58.266Z
---

Work in small, bottom-up increments; fix only what's currently blocking, don't design ahead of need or start big new subsystems speculatively.

**Why:** Confirmed repeatedly across a long session (rest-param TypeError → lexer bracket-depth bug → Pass3 → Pass1b → multi-arg apply bug) — each small step surfaced the next real obstacle organically. The user explicitly named this philosophy "実装しながら障壁をあぶり出す" and confirmed it works better than trying to plan everything upfront (a mentor in an earlier shared conversation had argued for formal-proof-first; user and I decided against it in favor of this incremental approach).

**How to apply:** When picking "what's next," prefer the smallest concrete piece that's clearly blocking, not the most architecturally complete one. Don't build speculative infrastructure (e.g., don't add `.st` file generation or a full interpreter "just in case" — wait until something concretely needs it).

---

Before asserting how a piece of the grammar/lexer/AST actually behaves, verify with a throwaway probe script (write a small `.mjs` file, run it, read the actual output) rather than reasoning from memory of the code.

**Why:** Multiple real bugs were found this way that pure code-reading missed (e.g., `separateInfix`'s regex group-numbering bug, `OPERATOR_DICT`'s off-by-one loop, `identifier` swallowing `__`). Reasoning-only analysis on this codebase has produced wrong conclusions more than once (e.g., initially misdiagnosing `apply : g x ? g x` as buggy when `@g x` actually already worked correctly).

**How to apply:** For any claim about "how does X currently parse/resolve," write and run a quick probe before stating it as fact, especially before proposing a fix.

---

Before editing a canonical spec/doc file (documents/ja-jp/impl/**, operator_table.md, etc.), draft the exact text and get explicit confirmation, then write it in one pass.

**Why:** This pattern was used successfully many times (coproduct_resolver.md §5.4, 0_design_principles.md's `$$x` nesting note, compiler_pipeline.md §6). The user treats these docs as the authoritative source of truth (per AGENTS.md) and wants to sign off on wording before it becomes canonical, not after.

**How to apply:** Don't silently rewrite spec docs. Show the proposed paragraph, wait for "いいね" or an edit request, then commit it.

---

Prefer "one way to express one thing" — resist adding a second syntax/mechanism for something that already has a canonical form, even if the alternate form is technically fixable.

**Why:** Directly stated when reverting a fix that made `[foo:1, bar:2]` (comma-separated dict) parse correctly — the user rejected it specifically because dicts already have a canonical newline-separated form (`list_model.md`/`pattern_guide.md`), and supporting a second form was seen as unnecessary complexity/surface area, not a feature win. Same instinct applied earlier when explicitly choosing NOT to support comma-separated default-argument parameter lists (indent-block form only).

**How to apply:** When a "clever generalization" would let a second syntax work, pause and ask whether the language already has one documented way to do that thing before implementing the generalization. Default to reverting/not-shipping the second form.

---

It's fine (expected, even) to retract a claim once evidence contradicts it, and to say so plainly rather than rationalizing.

**Why:** The user responded well when I corrected myself (e.g., "apply : g x ? g x is buggy" → retracted after testing `@g x`). This matches the broader empirical-verification norm above — claims are provisional until checked.

**How to apply:** If a probe or test contradicts something said earlier in the same session, say "I was wrong, here's what actually happens" directly, don't quietly paper over it.

---

The user enjoys genuine technical pushback/counterarguments, not just agreement — treats this collaboration explicitly as playful research ("研究分野まで進むのは、本当に楽しいね", "一種の遊び").

**Why:** Multiple times the user asked "他に異論は？" or presented a claim and invited refutation ("反論があれば対応する"), and engaged substantively when I raised a real counterpoint (e.g., the C++ default-argument side-effect analogy, the `$$$x` nesting question, the `.ist`/cache coverage-gap question).

**How to apply:** When something seems off or under-justified, say so and give the concrete reasoning, rather than defaulting to validation. This is welcomed, not friction.
