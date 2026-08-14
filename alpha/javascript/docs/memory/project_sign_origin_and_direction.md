---
name: project-sign-origin-and-direction
description: "Why Sign exists and where it's headed, told by the user directly (2026-08-09): LLVM/CUDA-era concern about structure being destroyed by leveling IRs, category theory as the turning point, AArch64→CUDA target path, OS/kernel ambition, and the current pivot toward natural-language-like mathematical/formal-method notation. motivation.md is explicitly a 建前 pitch, NOT the real reasoning."
metadata: 
  node_type: memory
  type: project
  originSessionId: f564fb92-74d1-4c32-b304-b2fd363a270a
  modified: 2026-08-08T21:21:29.338Z
---

Told directly by the user in conversation, not written down anywhere in the repo. **Important caveat the user gave: `documents/ja-jp/impl/appendix/motivation.md` is 建前 ("AIにとって分かりやすい言語だろうというプレゼン") — do not cite it as the basis for design decisions.** `0_design_principles.md` is the real distillation; this note is the story behind it.

## The origin

**The grievance (LLVM/CUDA era).** The user watched LLVM and CUDA proliferate and became persistently uneasy about the 歪み there. The shape of the complaint (confirmed): structured source gets flattened into a structure-less IR, and then the compiler tries to *guess back* the structure it just destroyed — auto-vectorization is re-deriving what the programmer already knew, alias analysis is rediscovering what was obvious at the source. LLVM IR claims universality but is effectively C's semantics generalized; CUDA bolts parallelism on as annotations rather than semantics.

**The turn (category theory).** The user describes themselves as a mediocre mathematician who was struggling; encountering category theory was a shock that reorganized their whole view of mathematics — it explained *why* they had always disliked analysis and loved algebra. Three specific realizations became the seed of the language:

1. **積と余積の間に一意な随伴が見られること** — product/coproduct adjunction
2. **関数が動詞と同じだということ** — functions are verbs (morphism-first: the arrows carry meaning, objects are recoverable from them)
3. **そこに代数的構造を持ち込めること**

→ "圏論を使って新しい言語を作るべき時代だ"

These map one-to-one onto the actual artifacts: the adjunction is `list_model.md` §3.2 (`[,] = [~_]`, prefix-`~`/postfix-`~` as an adjoint pair, `1,2,3` ≡ `1 2 3` for scalars) plus `__` as the **zero object** (`type_system.md` §6.1: initial object in function position, terminal object in argument position). "Functions are verbs" is why there are no reserved words, no type-annotation syntax, and why 原理6 says 挙動が型 — verbs determine nouns, not the reverse.

## Why AArch64 (user confirmed my hypothesis)

原理1 (RISC as-is) and category theory *pull against each other* — CT says structure is everything and representation is incidental; RISC as-is says the instruction sequence must mirror the source. **The only way to hold both is to pick an ISA where the algebra you want is already standing as instructions**, so "preserve structure" and "lower directly" become the same act. That's the answer to the LLVM grievance: don't flatten, choose a target you don't *need* to flatten for.

Concrete evidence found while working: `fcvtas` (round-to-nearest, ties away from zero) is a single AArch64 instruction and exactly matches the 四捨五入 rule the user chose for Float→Address; `csel` lets `&`/`|` short-circuit without branches; `madd`/`msub` are fused; SIMD is in the ARMv8 base spec rather than an optional extension (contrast RISC-V's V extension). RISC-V is the more doctrinaire RISC, but AArch64 is the better *algebra-carrier*.

## Where it's going

- **AArch64 → CUDA.** Expansion to CUDA is planned, on the AArch64 base.
- **OS/kernel.** The user believes Sign can write kernels more beautiful, robust, and fast than C, and thinks OS *philosophy* itself may need renewing. Getting an OS up will be conventional coding at first ("お作法通り").
- **Shell = a restricted Sign.** CUI-level commands should be expressible in a feature-restricted Sign used as a scripting language (user noted PowerShell's obvious VBScript lineage as precedent for a systems-adjacent shell language).
- **The driving sentiment**: refusing to be permanently confined to userland — "ユーザーランドに踏みとどまったままその牢獄で一生ユーザーの側に居ろだなんて地獄は正直ごめんだ". This is why `layer 0 (bare)` is the *point* of the layer model, not a special constrained mode bolted on the way `no_std`/freestanding are in other languages.
- **The current pivot (most important for ongoing work):** Sign has steered toward *using category theory to be linguistically close to natural language, as a way to handle mathematical expression and formal methods* (「言語学的に自然言語に近いことを目標に数学表現や形式手法を扱えるんじゃないか」).

**How to apply:** this reframes what the type system is *for*. Under 原理2 alone, types are a throwaway ledger for Pass 4 and safety is abandoned — which leaves Pass 3 with no obvious consumer (see [[project-sign-pre-type-system-audit]] B-5). But under the formal-methods pivot, `.st` generation is not documentation, it's the surface formal reasoning would attach to. When deciding "who consumes Pass 3", weigh that. It also retroactively backs the Address×Float **promotion** decision over demotion: a notation aimed at mathematical expression cannot have `+` silently truncate. Sign is holding three things in tension — 圏論的代数構造 / RISC as-is 固定長 / 自然言語に近い数学表現 — and the `layer` system is the device that reconciles them, since it *declares* what is available rather than letting the notation lie.
