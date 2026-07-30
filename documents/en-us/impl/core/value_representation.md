# Sign Value Representation Specification: Character Boxing and Physical Representation of Unit

## 1. Overview

The Sign language adopts **standard UTF-8 (RFC 3629 compliant)** as its encoding for `Char`. Custom extensions or overlong encodings like MUTF-8 are prohibited.

> [!IMPORTANT]
> **"Boxing" of characters in Sign refers to the self-describing bit pattern of standard UTF-8 leading bytes (`0xxxxxxx` / `110xxxxx` / `1110xxxx` / `11110xxx`).**
> Type information is derived at zero cost directly from UTF-8 self-describing properties.

---

## 2. Niche Optimization: Relationship Between `__` (Unit) and U+0000

The scalar value U+0000 is excluded from the valid domain of `Char` (**niche optimization**):

$$\text{Char Domain} := \{ \text{U+0001}, \dots, \text{U+D7FF} \} \cup \{ \text{U+E000}, \dots, \text{U+10FFFF} \}$$

The excluded bit pattern U+0000 represents `__` (Unit) in `Char` contexts.

---

## 3. Strict Separation from `Byte` Type

| Feature | `Char` Type | `Byte` Type |
|---|---|---|
| Domain | Unicode Scalar Values (excl. U+0000 & Surrogates) | `0x00` – `0xFF` full byte range |
| Niche | Yes (U+0000 maps to `__`) | None |
| Primary Use | Strings and text | Binary data, images, FFI boundaries |

`Byte` types hold no niche optimizations; raw binary data containing `0x00` is preserved intact.
