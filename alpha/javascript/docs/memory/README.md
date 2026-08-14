# alpha 実装メモリ

このフォルダには、alpha JavaScript 実装の開発中に記録された **原文の設計メモリ**を収めます。メモリは、実装判断の背景、実測で見つかった不整合、訂正の経緯、および将来の検討事項をたどるための補助資料です。

> **位置付け:** ここにあるメモリは、`documents/ja-jp/impl/` の規範的仕様を置き換えません。規範的な構文・意味・設計原則は引き続き `impl/` を参照してください。メモリ間には時点差があり、古い「未実装」「未解決」の記録は、後続メモリまたは現行テストによって更新済みの場合があります。

## 読み方

実装の現状は親ディレクトリの補助文書および `alpha/javascript/README.md` を入口にし、設計判断の由来を確認したいときだけ本フォルダの原文をたどります。特に挙動を断定するときは、メモリだけでなく現行のコードと probe を優先します。

## 索引

| 分類 | メモリ | 概要 |
|---|---|---|
| 作業規律 | [Implementation collaboration style](feedback_implementation_style.md) | 小さく実装し、probe で確かめ、正本への編集は承認を経るための協働規律。 |
| 方向性 | [Sign's origin and direction](project_sign_origin_and_direction.md) | 圏論、AArch64、OS、自然言語に近い形式手法というプロジェクトの背景と方向。 |
| 現状 | [Sign project status](project_sign_status.md) | alpha JavaScript の実装状況、直近のリファクタリング段階、および既知の残課題。 |
| 監査 | [Pre-type-system behavior audit](project_sign_pre_type_system_audit.md) | 型システム導入前の挙動監査と、修正済み・未解決項目の記録。 |
| 型システム | [Type system is live](project_sign_type_system_build.md) | `compile.js` 経路、Layer 2 の判断、型システムを実行経路に接続した経緯。 |
| 診断 | [Undefined-identifier diagnostic severity](project_sign_diagnostic_severity.md) | 未定義識別子の Unit 収束を information とする設計判断。 |
| Apply_Reverse | [apply_reverse design](project_sign_apply_reverse_design.md) | `x f` を UFCS receiver-piping とする選択、one-receiver 制限、pointfree 除外。 |
| パターン | [Guide-example audit findings](project_sign_bracket_destructuring.md) | bracket destructuring、pointfree、range、flatten などの実装・検証経緯。 |
| 演算子 | [Operator table audit](project_sign_operator_table_audit.md) | 演算子表と alpha 実装の照合、優先順位・等価性・range の修正履歴。 |
| 型の哲学 | [Sign's type philosophy](project_sign_type_philosophy.md) | 構造的等価性、由来情報、`挙動が型`、Pass 1b の設計的背景。 |
| 実プログラム | [8-Queens real-program audit](project_sign_8queens_audit.md) | 8-Queens を使った end-to-end 監査と、List/Unit/パラメータ処理の修正。 |
| Curry と参照 | [Currying/type-system design](project_sign_currying_design.md) | `$`/`@`/`#`、静的 automatic currying、shape/layout pass の段階的整理。 |
| 返り値 | [Return-value addressing design](project_sign_return_value_addressing_design.md) | List 同型の可変長返り値を sret 方式で扱う将来設計。 |
| 文字列 | [string_and_comment.md audit](project_sign_string_comment_audit.md) | Unit と空文字列、文字列インデックス、PEG comment rule の修正履歴。 |
| 再帰 | [Tail-call optimization](project_sign_tco.md) | trampoline による TCO の実装範囲と検証。 |

元の横断索引は [MEMORY.md](MEMORY.md) にも原文のまま残しています。
