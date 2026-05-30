# 型システムと型推論について

## 基本的な型の扱いについて

### 演算子と型

Signでは、データの型ではなく、関数に型が存在する。  
よって、型キャストも演算子をベースに行われる。  
以下、演算子を関数とみなした場合の型についてをまとめる。  

ジェネリクスは、**Lは左辺の型、Rは右辺の型とする**
String を含む場合は `Atom` 含まない場合は `Scalar`

`List` は、 `(Array | Struct)` であり、多相リストは `Struct` とする。
`Implicit` は `Implicit Address` とする。

| 記号 | 位置（型の組み合わせ） | 型 |
| :------: | :------: | ------ |
| `#` | 前置※ | / |
| `##` | 前置※ | / |
| `###` | 前置※ | / |
| `:` | 中置※ | `(Identifier -> R) -> R` |
| `?` | 中置※ | `(List -> R) -> Lambda(R)` |
| `#` | 中置※ | `(Address -> R) -> (Address \| _)` |
| `;` | 中置 | `(L -> R) -> (L \| _)` |
| `\|` | 中置 | `(L -> R) -> (L \| _)` |
| `&` | 中置 | `(L -> R) -> (L \| _)` |
| `==` | 中置 | `(L -> R) -> (L \| _)` |
| `!==` | 中置 | `(L -> R) -> (L \| _)` |
| `,` | 中置※ | `(L -> R) -> List` |
| ` ` | `Atom \| List` 中置 `Lambda` | `((Atom \| List \| _) -> Lambda) -> (List \| Lambda \| _)` |
| ` ` | `Lambda` 中置 `Atom \| List` | `(Lambda -> (Atom \| List \| _)) -> (List \| Lambda \| _)` |
| ` ` | `Lambda` 中置 `Lambda` | `(Lambda -> Lambda) -> Lambda` |
| ` ` | `Atom \| List` 中置 `Atom \| List` | `((Atom \| List \| _) -> (Atom \| List \| _)) -> (List \| _)` |
| `~` | 中置 | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~-` | 中置 | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~+` | 中置 | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~*` | 中置 | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~/` | 中置 | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `~^` | 中置 | `(Scalar -> Scalar) -> Iterator -> Scalar` |
| `<` | 中置 | `(L -> R) -> (L \| _)` |
| `<=` | 中置 | `(L -> R) -> (L \| _)` |
| `=` | 中置 | `(L -> R) -> (L \| _)` |
| `>=` | 中置 | `(L -> R) -> (L \| _)` |
| `>` | 中置 | `(L -> R) -> (L \| _)` |
| `!=` | 中置 | `(L -> R) -> (L \| _)` |
| `+` | 中置 | `(L -> R) -> (L \| _)` |
| `-` | 中置 | `(L -> R) -> (L \| _)` |
| `*` | 中置 | `(L -> R) -> (L \| _)` |
| `/` | 中置 | `(L -> R) -> (L \| _)` |
| `%` | 中置 | `(L -> R) -> (L \| _)` |
| `^` | 中置※ | `(L -> R) -> (L \| _)` |
| `\|...\|` | 囲み | `(L -> L) -> L` |
| `'` | 中置 | `(L -> R) -> Implicit(Atom \| List \| Lambda) -> Deref(Implicit -> (Atom \| List \| Lambda))` |
| `@` | 中置※ | `(R -> L) -> Implicit(Atom \| List \| Lambda) -> Deref(Implicit -> (Atom \| List \| Lambda))` |
| `<<` | 中置 | `((Address | Register) -> Number) -> (Address | Register)` |
| `>>` | 中置 | `((Address | Register) -> Number) -> (Address | Register)` |
| `\|\|` | 中置 | `((Address | Register) -> Scalar) -> (Address | Register)` |
| `;;` | 中置 | `((Address | Register) -> Scalar) -> (Address | Register)` |
| `&&` | 中置 | `((Address | Register) -> Scalar) -> (Address | Register)` |
| `!` | 後置 | `Number -> Number` |
| `~` | 後置 | `Deref(Implicit -> List)` |
| `@` | 後置 | `Implicit -> Deref(Implicit -> Lambda)` |
| `~` | 前置※ | `List -> Implicit(List)` |
| `!` | 前置※ | `L -> L` |
| `$` | 前置※ | `Lambda -> Implicit(Lambda)` |
| `@` | 前置※ | `Implicit(Lambda) -> deref(Implicit)` |
| `!!` | 前置※ | `Scalar -> Scalar` |

## ラムダの型

### ラムダ演算子、`?` の型は、なぜ右辺で解決可能なのか？

結論：**右辺が全て式の塊として定まり、式の塊の型は常に演算子の型の遷移で証明されるため。**
