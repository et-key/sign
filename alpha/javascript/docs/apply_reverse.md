# 逆適用（`x f`）は糖衣構文であり、コアの構成要素ではない

**状態:** alpha の設計判断（2026-08-16 に方針転換。以前は「余積に吸収された UFCS receiver」という固有の縮約として扱っていた）

**規範参照:** [`impl/core/coproduct_resolver.md`](../../../documents/ja-jp/impl/core/coproduct_resolver.md) §3–4（特に §3.1）

**対象:** Pass 2 が `Atom × Lambda` を縮約する場合

## 1. 結論

`x f` は**記法だけの存在**です。Pass 2 は左右を入れ替えた通常の `apply` ノードを作り、それ以降のすべての段階は `f x` と区別しません。

```text
x f    →    apply(f, x)
```

したがって適用の意味論は言語にひとつしかありません。`apply_reverse` というノード型は存在せず、`interpreter.js` に専用の評価経路もありません。

> **逆適用は core に持たない。**
>
> 10.3（`Atom × Lambda`）という**解決規則は規範に残る**——空白がどの縮約へ落ちるかはカテゴリ対でしか決まらないため。糖衣にしたのは、ノードの型と、それに固有の評価規則である。

## 2. なぜ固有ノードをやめたか

固有のノードを持たせると、**`apply` に対して足した機能が逆適用へ届かない**という取りこぼしが構造的に生じます。alpha では実際に二度起きました。

### 2.1 TCO が届かなかった

トランポリンは `name === "apply"` だけを `TailCall` として検出していたため、同型の末尾再帰が形によって別の性質を持っていました。

```sign
` 通常 apply：トランポリンに乗る
down : n ?
	n = 0 : 0
	down (n - 1)

` 逆適用：host stack を消費する
down : n ?
	n = 0 : 0
	(n - 1) down
```

`down 100000` の実測は、前者が `0`、後者が `Maximum call stack size exceeded` でした。Sign にはループ構文が無く反復手段が再帰しかないため、これは表現力に直結します。

### 2.2 静的な部分適用の印付けが届かなかった

`markUndersaturatedApplies`（Pass 2 が引数不足の apply 連鎖を `partial_apply` へ印付ける静的機構）も `apply` 連鎖だけを見ていました。逆適用は実行時に `applyClosure(f, [x])` を直接呼ぶため、引数が足りなければ完全性公理で崩壊します。

```text
add : a b ? a + b

add 5        <closure>
5 add        __          ← 完全性公理で潰れていた
(add 5) 3    8
(5 add) 3    3           ← `__ 3` が余積の左単位元で 3 になる。8 のつもりで書くと黙って外れる
```

最後の行が silently-wrong です。糖衣にした現在はどちらも `8` になります。

### 2.3 一般化すると

逆適用が別ノードである限り、`apply` に何かを足すたびに「逆適用にも足したか」を人間が覚えている必要があります。覚えていられなかった実例が上の2件です。糖衣にすれば、この種の取りこぼしは構造的に発生しません。

## 3. receiver は1オブジェクトとして数えられるものに限る

糖衣にしても無制限に `f x` と同一視するわけではありません。**receiver に後置 `~` を書くことはできません（構文エラー）。**

```text
f x~     可。通常の前置適用であり、`~` は List を複数の位置引数へ展開する
x~ f     構文エラー
x f      可。`x` を1つの receiver として渡す
```

後置 `~` は「List を複数の位置引数へ展開せよ」という指示であって、数えられる1つの値ではありません。`x~ f` と書いた側が receiver を1個渡すつもりなのか複数引数へ展開するつもりなのかは静的に確定できないため、[原理4](../../../documents/ja-jp/impl/0_design_principles.md)により値を返さず弾きます。

以前はこれを実行時の制約（`apply_reverse` の評価が `evalArgValues` を経由せず常に一値を渡す）として実装していました。静的な拒否へ移したことで、コアから特例が消え、かつ書き手の取り違えが早く分かります。

### 3.1 Eager parameter とは無関係

この制約は、receiver が List / Struct として分割されないという意味ではありません。右側の関数が Eager bracket parameter を宣言していれば、一つの receiver value をその parameter pattern が分解できます。

```sign
sum_list : [x ~xs] ? ...
sum_list [1 2 3]
```

これは逆適用の展開ではなく、関数側の Eager destructuring です。通常の前置適用でも同じことが起きます。

## 4. ポイントフリーは 10.3 の対象外（変更なし）

ポイントフリー Lambda は、演算子の種類にかかわらず 10.3 の対象にしません。`[+]`、`[+ 1]`、`[!_]`、`[* 2,]` のような表現は、**前向きの prefix apply だけ**を calling convention とします。

これは Pass 2 の**解決**規則（どのカテゴリ対が発火するか）であり、評価の規則ではないため、糖衣化の影響を受けません。たとえば `1 2 [+] 3 4` では `[+]` が前向きに `3 4` を消費したあと、左側の `2` を receiver として再適用しません。

## 5. compose との区別（変更なし）

`compose` は `Lambda × Lambda` の余積縮約であり、関数をパイプラインとして結びます。10.3 は `Atom × Lambda` です。カテゴリ対が違うため、両者が競合することはありません。

```sign
inc : x ? x + 1
5 inc inc
```

これは `compose(inc, inc)` が 10.5 で先に確定し、その合成へ 5 が 10.3 で渡る形です（結果 7）。

## 6. 実装者・レビューアのチェックリスト

| 問い | 判定 |
|---|---|
| `x f` は `f x` と同じノードになるか | **はい。** Pass 2 が左右を入れ替えた `apply` を作る。 |
| `apply_reverse` というノード型はあるか | **無い。** `interpreter.js` に専用の評価経路も無い。 |
| receiver に `~` を書けるか | **いいえ、構文エラー。** 1オブジェクトとして数えられる値だけが receiver になれる。 |
| receiver が List / Struct のとき分解できるか | 関数側が Eager pattern を要求するときだけ（前置適用と同じ）。 |
| `x f` の不足引数は closure になるか | **なる。** `f x` と同じく静的に `partial_apply` へ印付けられる。 |
| `x f` が末尾位置なら TCO されるか | **される。** `apply` として届くため。 |
| ポイントフリーは receiver 記法を持つか | いいえ。前置適用だけ。 |

## 7. follow-up 項目

| 項目 | 現在の扱い | 次に必要なこと |
|---|---|---|
| Address を含む Eager pattern | reference cell が JavaScript object として Struct 分解されうる。 | `Implicit(T)` / `Address` を pattern judgement で非 destructurable にする最小修正を、reproduction test とともに検討する。糖衣化とは独立の課題であり、前置適用でも同じく起きる。 |
| compose 後の多引数射の arity | 外部へ公開する required arity は未整理である。 | compose を拡張する具体的な実装課題が現れた時点で probe する。 |

## References

- [`impl/core/coproduct_resolver.md`](../../../documents/ja-jp/impl/core/coproduct_resolver.md) §3.1
- [`impl/core/tco.md`](../../../documents/ja-jp/impl/core/tco.md)
- [`impl/type/list_model.md`](../../../documents/ja-jp/impl/type/list_model.md)
- [`alpha/javascript/pass2.js`](../pass2.js) — `coproductReduce` の 10.3 分岐
- [`alpha/javascript/interpreter.js`](../interpreter.js)
