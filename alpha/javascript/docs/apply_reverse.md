# Apply_Reverse は余積に吸収された UFCS receiver である

**状態:** alpha の設計判断

**規範参照:** [`impl/core/coproduct_resolver.md`](../../../documents/ja-jp/impl/core/coproduct_resolver.md) §3–4

**対象:** Pass 2 が `Atom × Lambda` を `apply_reverse` へ縮約する場合

## 1. 結論

`x f` は、通常の関数適用 `f x` を任意の文脈で左右反転した構文ではありません。alpha における `apply_reverse` は、**UFCS 的な receiver 記法を space（余積）へ吸収した限定的な縮約形**です。

```sign
receiver method
```

これは「`receiver` を一つの値として `method` へ渡す」ことを表します。receiver は method call の最初の位置引数のように振る舞いますが、複数引数の一般的な currying、List 展開、または compose の代替構文ではありません。

> **Apply_Reverse は one-receiver dispatch である。**
>
> `x f` が意味するのは `f` に `x` という一つの receiver value を渡すことであり、`f x` が持つ全ての partial-apply / expand 規則を左右対称に複製することではない。

## 2. 規範上の位置

余積リゾルバーは隣接する term の category pair により縮約先を選ぶ。

| 左 category | 右 category | 縮約 | alpha での読み |
|---|---|---|---|
| `Lambda` | `Lambda` | `compose` | 射をパイプラインとして接続する。 |
| `Lambda` | `Atom` | `apply` | 通常の前向き関数適用。 |
| `Atom` | `Lambda` | `apply_reverse` | receiver を右側の射へ渡す UFCS 的 dispatch。 |
| `Atom` | `Atom` | `concat` / `construct` 等 | 値の構築・連接。 |

この table から、`apply_reverse` は `apply` の実装上のショートカットではなく、**別の category pair が選んだ別の余積縮約**であることが分かります。`apply_reverse` に対して通常 apply のすべての性質を要求するには、別途その同一性を言語仕様として宣言しなければなりません。

## 3. one-receiver 制約

### 3.1 左側は常に一値

alpha は `apply_reverse` の左側を常に一つの receiver value として渡します。後置 `~` が付いていても、通常 apply のように List を複数の位置引数へ展開しません。

```sign
pair : a b ? a

` 通常 apply：後置 ~ が List を位置引数へ展開できる
pair [1 2]~

` Apply_Reverse：receiver は一値のまま
[1 2]~ pair
```

後者は `pair(1, 2)` の省略形ではありません。`[1 2]` という一つの receiver を `pair` に渡す形です。`pair` が二つの必須 bare parameter を持つなら、残りの parameter は通常の完全性・default・Unit 規則に従います。

### 3.2 Eager parameter とは整合する

one-receiver 制約は、receiver が List / Struct として分割されないことを意味しません。右側の関数が Eager bracket parameter を宣言していれば、**一つの receiver value をその parameter pattern が分解する**ことはできます。

```sign
sum_list : [x ~xs] ? ...
sum_list [1 2 3]
```

この分解は `apply_reverse` の展開ではなく、関数側の Eager destructuring です。実装は `List` / `Struct` と `Implicit(T)` / Address を tag で区別しなければなりません。通常 Address `$x` を Struct と誤認して分解することは、one-receiver 制約からは導かれない実装不備です。

### 3.3 `~` の役割を一般化しない

| 形 | alpha での前提 |
|---|---|
| `f xs~` | 通常 apply。`xs` の展開は複数の位置引数として扱われうる。 |
| `xs~ f` | Apply_Reverse。`xs` は一 receiver であり、複数引数への自動展開を要求しない。 |
| `f [x ~xs]` | 関数側 Eager destructuring。渡された一値を parameter pattern が分解する。 |

この区別により、UFCS receiver と List expansion の責務が混ざらない。

### 3.4 pointfree Lambda は Apply_Reverse から除外する

pointfree Lambda は、演算子の種類にかかわらず `apply_reverse` の対象にしません。`[+]`、`[+ 1]`、`[!_]`、`[* 2,]` のような pointfree 表現は、**前向きの prefix apply だけ**を calling convention とします。

この除外は、pointfree の貪欲な引数消費と receiver dispatch を混同しないための一般規則です。たとえば `1 2 [+] 3 4` では `[+]` が前向きに `3 4` を消費したあと、左側の `2` を receiver として再適用しません。`5 [+]` を `5` の method call として解釈することもありません。

## 4. Apply_Reverse は partial apply の左右反転ではない

alpha では、通常 apply の known finite arity に対する不足引数を Pass 2 が `partial_apply` として印付ける。これは前向きの `apply` chain に対する静的な機構である。

Apply_Reverse は receiver dispatch であり、receiver を渡した結果が不足引数を持つ場合に、自動的に「receiver を capture した通常 partial closure」へ変換することを前提にしない。

```sign
add : a b ? a + b

` 通常 apply の partial form
add 5

` Apply_Reverse の receiver form
5 add
```

この二つを同じ値として扱うには、receiver を ordinary positional argument へ昇格し、UFCS の one-receiver 制約を越える別規則が必要です。alpha の前提では、その昇格を暗黙に行わない。

したがって、レビューで `5 add` が必ず `add 5` と同じ partial closure になるべきだと仮定するなら、その仮定は alpha の UFCS 前提を見落としている。もし将来この等価性を採用するなら、`apply_reverse` の意味を拡張する**明示的な仕様変更**として扱う。

## 5. compose との区別

`compose` は `Lambda × Lambda` の余積縮約であり、関数をパイプラインとして結ぶ。`apply_reverse` は `Atom × Lambda` の receiver dispatch である。

| 観点 | `compose` | `apply_reverse` |
|---|---|---|
| category pair | `Lambda × Lambda` | `Atom × Lambda` |
| 左側 | 射 | receiver value |
| 主な目的 | パイプラインの構成 | receiver へのメソッド的 dispatch |
| 引数規則 | 合成された射の規則 | 一 receiver の規則 |
| List `~` | compose 側の stream / apply 規則に従う | receiver を複数引数へ展開しない |

この二つを同じ arity propagation で扱うかは、将来の設計事項である。少なくとも alpha では、receiver dispatch を compose の多引数入口に読み替えない。

## 6. TCO との関係

末尾位置は、`impl/core/tco.md` では「呼び出しの結果がそのまま関数の返値になる位置」と定義されます。one-receiver 制約は、receiver を partial closure に一般化しない理由ですが、飽和した receiver dispatch が末尾位置にある場合まで最適化を禁じる意味ではありません。

ただし、**現行 alpha のトランポリンは `apply` node だけを `TailCall` として検出し、`apply_reverse` は検出しません。** そのため、次の同型な末尾再帰は現在異なる実装上の性質を持ちます。

```sign
` 通常 apply：深い末尾再帰をトランポリンする
down : n ?
\tn = 0 : 0
\tdown (n - 1)

` Apply_Reverse：小さい入力は正しく評価するが、深い再帰では host stack を消費する
down : n ?
\tn = 0 : 0
\t(n - 1) down
```

現行 worktree で `down 100000` を probe した結果、通常 apply は `0` まで収束し、Apply_Reverse 形は `Maximum call stack size exceeded` となりました。これは UFCS の意味論的制限ではなく、`evaluateTail` が `apply_reverse` をまだ `TailCall` に変換していない **alpha の実装制限**です。

## 7. 実装者・レビューアのチェックリスト

| 問い | 判定の順序 |
|---|---|
| `x f` は一般的な `f x` の代替か | いいえ。まず UFCS receiver と読む。 |
| receiver に `~` があると複数引数に展開するか | いいえ。receiver は一値。 |
| receiver が List / Struct のとき分解できるか | 関数側が Eager pattern を要求するときだけ。 |
| `x f` の不足引数は closure になるか | alpha の前提では自動的にはならない。仕様変更なしに通常 apply と同一視しない。 |
| `x f` が末尾位置なら必ず TCO か | **現行 alpha ではいいえ。** `apply_reverse` は `TailCall` 検出の対象外であり、深い再帰は host stack 上限に達する。 |
| Address を receiver として渡せるか | 値としては渡せる。Eager pattern との区別は意図どおりには未実装で、現行は Address を Struct と誤認しうる。 |

## 8. follow-up 項目

この文書は alpha の現在の制限を明らかにするものであり、以下を新たに規範化しません。

| 項目 | 現在の扱い | 次に必要なこと |
|---|---|---|
| receiver 以外に必須 parameter が残る UFCS call | `applyClosure(f, [x])` を通るため、default と完全性公理は通常 apply と共有する。 | 実装を変える前に、この共有経路を regression test で維持する。 |
| UFCS call の TCO | `apply_reverse` は `TailCall` 検出の対象外である。 | `evaluateTail` の対象へ飽和した `apply_reverse` を加え、深い末尾再帰の regression test を置く。言語規範との対応は `impl/core/tco.md` の編集案を先に提示してから扱う。 |
| compose 後の多引数射の arity | 外部へ公開する required arity は未整理である。 | compose を拡張する具体的な実装課題が現れた時点で probe する。 |
| Address を含む Eager pattern | reference cell が JavaScript object として Struct 分解されうる。 | `Implicit(T)` / `Address` を pattern judgement で非 destructurable にする最小修正を、reproduction test とともに検討する。 |

これらは、通常 apply との見かけ上の対称性から推測せず、UFCS・余積・Unit の設計意図を保つ形で扱う。

## References

- [`impl/core/coproduct_resolver.md`](../../../documents/ja-jp/impl/core/coproduct_resolver.md)
- [`impl/core/tco.md`](../../../documents/ja-jp/impl/core/tco.md)
- [`impl/type/list_model.md`](../../../documents/ja-jp/impl/type/list_model.md)
- [`alpha/javascript/pass2.js`](../pass2.js)
- [`alpha/javascript/interpreter.js`](../interpreter.js)
- [`memory/project_sign_apply_reverse_design.md`](memory/project_sign_apply_reverse_design.md)
- [`memory/project_sign_tco.md`](memory/project_sign_tco.md)
