# alpha JavaScript の設計前提

**状態:** alpha の設計判断と実装制限を説明する補助文書

**規範正本:** [`documents/ja-jp/impl/`](../../../documents/ja-jp/impl/)

**対象実装:** `alpha/javascript/`

## 1. 目的

alpha JavaScript は、完成済みの仕様を逐語的に写すだけの実装ではありません。`impl/` の PEG、演算子表、Unit、余積、型、実行モデルを読み、相互の関係を実行可能な形にする先行実装です。そのため、コードから観測できる挙動には次の四種類が混在します。

| 種類 | 説明 | 例 |
|---|---|---|
| **規範参照** | `impl/` が明示的に定める言語規則 | PEG、Unit の演算規則、余積の category pair |
| **alpha の設計判断** | 規範参照を alpha が具体化する際に選んだ読み方 | `apply_reverse` を UFCS receiver として一値に制限すること |
| **実装制限** | alpha が未対応、または簡略化している範囲 | target memory、native ABI、無限 Pull iterator の実体化評価 |
| **未決事項** | 実装前に仕様側の裁定が必要な範囲 | target ごとの fault profile、Struct key 衝突、複数 phase にまたがる arity 規則 |

この分類は、実装の説明を言語仕様にすり替えないためのものです。alpha の制限を見つけたときは、まず「規範違反」か「意図的制限」か「未決事項」かを分けます。

## 2. Unit は null ではない

### 2.1 規範参照

`impl/core/unit.md` は、`__` を零対象とし、未定義 identifier、空、短絡、余積の単位元を同じ基底点に収束させます。`__` は数値の `0` でも、C 系の null pointer でもありません。

```sign
$__  = __
@__  = __
@$__ = __
```

この規則は、`$` と `@` が Unit に新しい独立した sentinel や危険な参照先を作らないことを意味します。

### 2.2 alpha の設計判断：`0u00` の不動点

alpha では、Unit の address 表現を `0u00` に対応付けます。ただし、これは `__` と区別可能な値を導入する意図ではありません。`0u00` の address 部分に `0u00` 自身を保存することで、Unit は address-of と dereference のいずれを通っても同じ値へ戻る固定点として扱います。

```text
repr(__) = 0u00 の自己参照表現
$__     ≡ __
@__     ≡ __
@$__    ≡ __
```

したがって、`@__` は「不正なポインタを例外処理で捕捉する」操作ではありません。言語意味論の内部で `__` に収束する、安全な終端・安全な未到達・安全な失敗伝播です。

### 2.3 区別すべき address 操作

| 形 | 意味 | alpha での扱い |
|---|---|---|
| `@__` | Unit 固定点の観測 | `__` に収束。target fault ではない。 |
| `$__` | Unit と同値な address 表現 | 独立した address value を新設しない。 |
| `$x` | place `Implicit(T)` を first-class な `Address` へ昇格する操作 | identifier と List 要素では読み書き可能な参照セルを返す。 |
| `$[expr]` | 格納先を持たない式の snapshot 参照 | 読取り専用の参照セルを返す。manual curry の継続値にも用いる。 |
| `@address` | Address の観測 | 参照セルを unwrap し、plain value はそのまま通す。 |
| `@0x00` など | 明示的な target address access | layer、target profile、memory / fault semantics の対象。 |

> [!IMPORTANT]
> `$x` のような通常 Address と `$__` を混同してはなりません。Unit の固定点が安全であることは、通常 Address を Struct と誤認してよいことを意味しません。**意図する pattern judgement では** Eager destructuring は `List` / `Struct` だけを分解し、`Implicit(T)` / `Address` を分解してはなりません。ところが現行 alpha の `isDestructurable` は reference cell も JavaScript object として受理するため、Address が Eager pattern に渡ると Struct と誤認しうる。この点は既知の alpha 実装制限であり、言語規範ではない。

## 3. alpha は「全演算子の一般実装」を目標にしない

alpha は、規範上の全機能を一度に実装するのではなく、実装可能な core を積み上げます。未対応の operation や target 依存の機能は、言語規範が否定されたことではなく、support matrix で区別すべき実装範囲です。

| 領域 | alpha の基本方針 |
|---|---|
| syntax / operator table | 正本 PEG と演算子表を入口として優先的に追従する。 |
| coproduct | `Lambda` / `Atom` category と tier による縮約を Pass 2 で行う。 |
| Unit | 値を JavaScript の `null` / `false` に置換せず、専用の Unit 規則として評価する。 |
| 型 | Layer 1 category と Layer 2 atom type を分ける。`compile.js` は Pass 1a → 2 → 1b → 3 を実行経路へ接続する。backend の shape/layout pass と Pass 4 は alpha の外側に残る。 |
| 参照 | `$` / `@` / `#` は identifier・List 要素・snapshot reference を実装済みとする。任意の Struct field を address 化する shape/layout pass は未実装である。 |
| target memory / ABI | target profile がない限り、host JavaScript の偶然の挙動を規範にしない。 |
| diagnostics | Unit への収束理由を diagnostics に残す。値が同じ `__` でも、崩壊理由は同一ではない。 |

## 4. 余積は構文糖ではなく、category による解決である

space は token separator ではなく coproduct です。Pass 2 は flat term sequence を、`Lambda × Lambda`、`Lambda × Atom`、`Atom × Lambda`、`Atom × Atom` の category と phase に従って `compose`、`apply`、`apply_reverse`、`concat` / `construct` 等へ縮約します。

この前提から、見かけ上の構文が似ていても、各 node を通常の関数呼び出しとして一般化してはなりません。特に `apply_reverse` は、次の文書で定めるように UFCS receiver を余積へ吸収した限定形です。

## 5. 文書化の原則

alpha の新しい挙動やレビュー指摘を記録するときは、次の順序で書きます。

1. `impl/` の規範参照を示す。
2. alpha の採用した設計判断と、その意図的な制限を示す。
3. 実装済みの例と、未対応の例を分ける。
4. どちらにも根拠がないときだけ「未決事項」として残す。
5. 未決事項を、JavaScript host の偶然の挙動で黙って決めない。

この手順により、レビューは実装を否定する外部基準ではなく、alpha が `impl/` の数学的な核を守れているかを確認する適合試験として扱えるようになります。

## References

- [`impl/core/unit.md`](../../../documents/ja-jp/impl/core/unit.md)
- [`impl/core/coproduct_resolver.md`](../../../documents/ja-jp/impl/core/coproduct_resolver.md)
- [`impl/core/system_semantics.md`](../../../documents/ja-jp/impl/core/system_semantics.md)
- [`impl/type/type_system.md`](../../../documents/ja-jp/impl/type/type_system.md)
- [`memory/project_sign_currying_design.md`](memory/project_sign_currying_design.md)
- [`memory/project_sign_type_system_build.md`](memory/project_sign_type_system_build.md)
