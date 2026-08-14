# alpha JavaScript 設計前提ノート

このフォルダは、`alpha/javascript` を読む実装者・レビューアが、**alpha がどの設計前提を採用し、どの制限を意図的に置いているか**を確認するための補助文書群です。

> [!IMPORTANT]
> このフォルダは `documents/ja-jp/impl/` を置き換えません。言語の規範的な定義は、常に `impl/` にあります。ここには、alpha JavaScript が規範仕様をどう読んでいるか、alpha 固有の制限は何か、そして未決事項をどこに残すかを記録します。

## 読み方

| 順序 | 文書 | 目的 |
|---:|---|---|
| 0 | [`design_premises.md`](design_premises.md) | 規範仕様・alpha の設計判断・実装制限・未決事項を区別する。Unit の不動点と参照の安全性を定める。 |
| 1 | [`apply_reverse.md`](apply_reverse.md) | `x f` を、一般関数適用の鏡像ではなく余積に吸収された UFCS receiver 記法として定義し、alpha の制限を明示する。 |
| 2 | [`memory/`](memory/README.md) | alpha の実装判断、実測、訂正の経緯を残した原文メモリ。規範仕様ではなく、設計背景を遡るために参照する。 |

## 記述の状態

各文書は、読者が実装の事実と設計上の判断を混同しないよう、次の状態を明記します。

| 状態 | 意味 | 実装者が取るべき扱い |
|---|---|---|
| **規範参照** | `impl/` がすでに定めている規則 | `impl/` を正本として実装する。 |
| **alpha の設計判断** | alpha JavaScript が意図的に採った読み方・制限 | この実装の互換性を保つ。ただし言語仕様への昇格は別途行う。 |
| **実装制限** | alpha がまだ実装しない、または部分的にしか実装しない範囲 | 挙動を言語規範と取り違えない。support matrix とテストで追跡する。 |
| **未決事項** | `impl/` または alpha の意図から一意に決まらない点 | 推測で一般化せず、設計判断として裁定する。 |

## 正本との関係

alpha JavaScript の入口は `compile.js` であり、`preprocess → parse → buildEnv → reduceAll → specializeGenericParams → annotateTypes` を通ります。具体的な syntax、演算子、Unit、余積解決、型、TCO の規範は、次の文書を参照してください。

| 領域 | 規範参照 |
|---|---|
| 文法と演算子 | [`grammar.pegjs`](../../../documents/ja-jp/impl/syntax/grammar.pegjs)、[`operator_table.md`](../../../documents/ja-jp/impl/syntax/operator_table.md) |
| Unit と参照 | [`unit.md`](../../../documents/ja-jp/impl/core/unit.md)、[`system_semantics.md`](../../../documents/ja-jp/impl/core/system_semantics.md) |
| 余積の縮約 | [`coproduct_resolver.md`](../../../documents/ja-jp/impl/core/coproduct_resolver.md) |
| 型と Pass | [`type_system.md`](../../../documents/ja-jp/impl/type/type_system.md) |
| 末尾呼び出し | [`tco.md`](../../../documents/ja-jp/impl/core/tco.md) |

この文書群を追加するときは、既存の `impl/` の規則を二重定義するのではなく、**alpha に必要な前提・制限・未決事項だけを補足する**ことを原則とします。設計判断の背景や修正経緯は、同じ範囲の原文メモリを [`memory/`](memory/README.md) に残し、ここでは結論と現行の実装範囲だけを扱います。
