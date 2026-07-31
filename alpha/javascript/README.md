# alpha/javascript

Sign言語の lexer/parser 再実装（JavaScript版）。`pre_alpha/`とは独立して、まずここで
きちんとした前処理→PEG構文解析の基盤を固める。`pre_alpha/`側は変更していない。

## 構成

- `lexer.js` — 前処理（`separateInfix` + `markBlock`）。`pre_alpha/lexisize/lexer.js`から移植、動作確認済み。
- `operator_table.js` — 演算子定義。`pre_alpha/semanticize/operator_table.js`から移植。
- `sign.pegjs` — PEG.js文法。`LanguageServer/src/sign.pegjs`をベースに、仮引数リストの
  デフォルト値・インデントブロック形・bracket形に対応させたもの。
- `test/run.js` — `sign.pegjs`をビルドし、`lexer.js`の`preprocess()`を通してからパースする検証。

## セットアップ

```
npm install
npm test              # test/run.js を実行
npm run build:parser  # sign.pegjs から parser.js を生成（コミット済みではない、都度生成）
```

## 現状（動作確認済み）

- 空白区切りインライン形（デフォルト無し）: `x y ? x + y`
- インデントブロック形（デフォルト引数）: `f :\n\t\tx\n\t\ty:x+1\n\t\tz:y+1\n\t\t~rest\n\t? ...`
- bracket形（構造的分解・自動name-bind）: `[x ~xs] ? x` / `(x ~xs) ? x` / `{x ~xs} ? x`（括弧は全て等価）

## 未解決・要確認の疑問点（`sign.pegjs`内にもコメントとして埋め込み済み）

1. 比較演算子の等価判定が `operator_table.js` では `==`/`!==`（優先順位8）だが、`sign.pegjs`の
   `ComparisonOperator`は`=`のみ。「純粋な構造比較」の記号として`=`と`==`のどちらが正か未確認。
2. `~rest`（rest記法）が末尾以外の位置（n番目、後ろからm番目等）を取れるパターンマッチは、
   今回のスコープ外として明示的に見送り。将来の別issue。
3. Pass1（意味解析）は未着手。以下がPass1側の責務として残っている：
   - デフォルト式のスコープチェック（let\*的な逐次束縛 + 外側レキシカルスコープ）
   - デフォルト式内の`@`/`#`の有無による静的特殊化フラグの判定（pure/monadic区別）
   - `~rest`が末尾固定であることの検証
4. `LanguageServer/`は現段階ではコンパイラパイプラインを実装しない方針のため、`server.js`への
   前処理・新文法の統合は行っていない（`sign.v0.pegjs`ベースのまま）。
