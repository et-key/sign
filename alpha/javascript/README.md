# alpha/javascript

Sign言語の lexer/parser 再実装（JavaScript版）。**正式仕様は
`documents/ja-jp/impl/syntax/grammar.pegjs`**（peggy記法、優先順位をPEGに埋め込まず
フラットな空白区切りリストを構築する方式）＋`coproduct_resolver.md`（Pass2: フラットリスト→
二分木ASTへの縮約アルゴリズム）であり、ここではそれをそのまま実装する。
`pre_alpha/`は無改変のまま独立して残す。

以前このディレクトリに置いていた「16段階優先順位を手でエンコードする古典的PEG方式」の
`sign.pegjs`は不採用の遺物（`LanguageServer/src/sign.pegjs`と同じ立ち位置）と判明したため、
正式仕様に差し替え済み。

## 構成

- `lexer.js` — 前処理（`separateInfix` + `markBlock`）。`pre_alpha/lexisize/lexer.js`から移植、動作確認済み。
- `operator_table.js` — 演算子定義。`documents/ja-jp/impl/syntax/operator_table.js`から移植（正式仕様）。
- `sign.pegjs` — `documents/ja-jp/impl/syntax/grammar.pegjs`そのもの（正式仕様）。**peggy記法**（`@`ラベル等）
  を使用しているため、`pegjs`ではなく`peggy`パッケージでビルドする必要がある。
- `pass1.js` — Pass1（最小実装）。識別子環境（env）を構築し、Pass2のgetCategoryに渡す。
- `pass2.js` — Pass2（`coproduct_resolver.md`）の実装。フラットなTerm列を二分木ASTへ縮約する。
- `test/run.js` — Pass1相当（パーサー）単体の動作確認。フラットなTerm列の検証。
- `test/pass2.test.js` — Pass2単体（envなし）の動作確認。
- `test/pass1_pass2.test.js` — Pass1＋Pass2を通した動作確認。複数行のソースで、先行するdefineが後続行の解決に影響することを検証。

## セットアップ

```
npm install
npm test                         # test/run.js を実行
node test/pass2.test.js          # Pass2単体の検証
node test/pass1_pass2.test.js    # Pass1+Pass2の検証
npm run build:parser             # sign.pegjs から parser.js を生成（--format es、都度生成、コミット対象外）
```

## 現状（動作確認済み）

**Pass1相当（パーサー）**：6/6 pass。フラットなTerm列を返す（`x y ? x + y` →
`["<x>","<y>","?","<x>","+","<y>"]`）。密着結合の前置/後置は`@_`/`_@`のようにマーカー付きの
文字列として表現される。

**Pass2（`coproduct_resolver.md`実装）**：9/9 pass。フラットなTerm列を二分木ASTへ縮約する。

- Shunting Yard（`operator_table.js`の優先順位1〜26に基づく演算子の結合。tier26=escapeから
  tier1=exportまで高い方から処理）
- Lambda/Atomカテゴリの判定（`getCategory`）とcompose/apply/apply_reverse/concatの優先度
  10.5〜10.0での総当たり縮約（`coproduct_resolver.md`§3-4）
- List/Structの`~`必須マージルール（`coproduct_resolver.md`§5）
- `$expr → Atom(Address)` / `@expr → 参照先の圏を継承`（`type_system.md`§2）を踏まえた、
  `$`/`@`の意味論的な扱い
- 実例：`1+2*3`の優先順位、`f : x ? x + 1`のdefine/lambdaネスト、`$[array ' 0] # 3`の
  非対称性、GetLeft、比較演算子・構造比較（`==`）

**Pass1（ブロック階層に沿ったスコープ連鎖）**：実測確認済み。`getCategory`が必要とする識別子環境（env）を、
ブロック階層（`grammar.pegjs`が既にネストさせてくれる構造）に沿って`{ bindings: Map, parent: env|null }`という
連鎖で構築する。各ブロック（`[...]` `{...}` `(...)`やインデントブロック）に入るたびに
`pass2.js`の`resolveBlock`が子スコープ（親=呼び出し時のenv）を自動生成するため、外側スコープの
識別子は常に内側のブロックから参照できる（`test/nested_scope.test.js`で実測確認済み）。

`g : x ? x + 1` を外側で定義し、`f : y ? \x02g y\x03`（インデントブロック内で`g y`を呼ぶ）という
ソースで、内側ブロックから`g`が`apply[g, y]`として正しく解決されることを確認済み。

### ブロックスコープの設計根拠（`execution_model.md`/`tco.md`との整合）

- **ファイル単位スコープ vs main.sn統括**は、`execution_model.md`が既に「Signの全関数は`main.sn`の内部関数として静的展開される」と明言しているため、**main.sn統括で既に決着済み**（ファイルごとの独立した名前空間は存在しない、`` `add.sn`@~ `` はファイル読み込みではなく内部関数の静的定義）
- **ストレージ/寿命の面はTCOによってほぼスタックポインタの挙動整理だけで説明できる**：末尾再帰は`JMP`に変換され深さO(1)に収束し、レンジ式は`LOOP`/`JNZ`に直接変換されスタックを使わない。部分適用クロージャの`alloca`も「静的サイズの単一mainアリーナ」（`tco.md`§8.2、実験的提案）に収まる。例外は**末尾位置でない再帰**だけで、ここは本物の`CALL`/`RET`で動的にスタックが伸びる（言語仕様上エラーにするはしていない、warningで議論中）
- この上で残っているのは**名前解決（シャドーイングルール、可視性）**の面で、こちらはスタックポインタとは独立なコンパイル時シンボルテーブルの話であり、今回実装した`pass1.js`の連鎖envはまさにこの面を担う

### Pass1の既知の制限

- スコープ検査（未定義識別子の参照エラー等）は一切行っていない。
- 同一スコープ内での再定義は後勝ちで単純に上書きする。
- 本来のPass1（`compiler_pipeline.md`）が持つべきスコープ検査・`.ist`/`.st`生成等は一切実装していない。あくまでPass2を動かすための最小限。

## `pass2.js`実装時に置いた仮定（仕様に明記なし、要レビュー）

1. 複数の前置/後置演算子が連続する場合（例: `!$x`）の結合順序：coreに近い方から先に結合する
   （`!$x` = `!($x)`）という一般的な慣習を採用。
2. 優先度10.1（Unshift/push）の具体的な演算子名：仕様は「Atom|List~ の組み合わせ」としか
   書いておらず方向性の区別が明記されていない。List~側が右ならpush、左ならunshiftとした。
3. Block（`[...]` `{...}` `(...)`）の種別（paren/brace/bracket）：`grammar.pegjs`側で
   区別を保持しないため、AST上でも区別できていない（kindは"paren"固定、indent/absのみ判別）。

## 未解決・要確認の疑問点（過去分）

1. Pass1（意味解析）は未着手。デフォルト式のスコープチェック、`~rest`末尾固定の検証、識別子の
   Lambda/Atomカテゴリ環境（`env`）の構築等が残っている。上記の通りPass2完成の前提条件。
2. `LanguageServer/`は現段階ではコンパイラパイプラインを実装しない方針のため、`server.js`への
   前処理・新文法の統合は行っていない（`sign.v0.pegjs`ベースのまま）。
