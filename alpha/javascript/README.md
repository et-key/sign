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

- `lexer.js` — 前処理（`separateInfix` + `markBlock`）。`pre_alpha/lexisize/lexer.js`から移植。
  **ブラケット深さ追跡を追加**（`bracketDelta`）：`markBlock`はタブ深さの変化のみでINDENT/DEDENTを
  挿入するためブラケットの存在を考慮しておらず、`function_guide.md`の`func_mixed`例のように
  `[`を定義行より深くインデントして複数行で書くと、ブラケットの中に本来無いはずのインデント
  ブロックが二重に差し込まれてパースが壊れる問題があった。他の多くの言語のオフサイドルールと
  同様、ブラケットが未クローズの間はインデント/デデントの意味を一時的に無効化することで解消
  （`test/param_list.test.js`で確認）。
- `operator_table.js` — 演算子定義。`documents/ja-jp/impl/syntax/operator_table.js`から移植（正式仕様）。
- `sign.pegjs` — `documents/ja-jp/impl/syntax/grammar.pegjs`そのもの（正式仕様、**根本バグ修正済み**）。
  **peggy記法**（`@`ラベル等）を使用しているため、`pegjs`ではなく`peggy`パッケージでビルドする必要がある。
  **`identifier`規則のバグも修正済み**：`"_" [a-zA-Z0-9_]+`が`__`（Unit）にもマッチしてしまい
  `unit`規則へ一生到達しなかった問題を、`&{ id !== "__" }`述語で除外して解消
  （`documents/ja-jp/impl/syntax/grammar.pegjs`本体にも同時反映済み）。
- `pass1.js` — Pass1（最小実装）。ブロック階層に沿ってネストした識別子環境（env連鎖）を構築し、Pass2のgetCategoryに渡す。
  `<id> : <リテラル1個>`という単純な定義行からLayer 2 Atom内部型（`atomType`）も静的に読み取る。
- `pass2.js` — Pass2（`coproduct_resolver.md`）の実装。フラットなTerm列を二分木ASTへ縮約する。
- `pass3.js` — Pass3（`type_system.md`§2〜§3.2の型伝播）の実装。Pass2が返す二分木ASTを歩いて
  左辺優先ルール（`typeof(L op R) = typeof(L)`）でLayer 2型を推論する。
- `test/pass2.test.js` — Pass2単体（envなし）の動作確認。9/9 pass。
- `test/pass3.test.js` — Pass3の型伝播（左辺優先ルール、String+算術演算子→Unit、リテラルからの
  atomType解決）の動作確認。6/6 pass。
- `test/pass3_param_usage.test.js` — 仮引数のatomType自動導出（本体の算術演算子使用箇所からの
  Scalar逆算、`type_system.md`§7.1）の動作確認。4/4 pass。
- `test/nested_scope.test.js` — Pass1+Pass2を通した、ブロックスコープの連鎖の動作確認。
- `test/multiline_block.test.js` — 複数行ブロックが1つのブロック内の複数文として正しく解決されることの確認。
- `test/rest_param_typecheck.test.js` — 裸のrestパラメータ（`x ~xs ? ...`）への`~`なしList渡しが
  TypeErrorになること（`coproduct_resolver.md`§5.4）の確認。
- `test/param_list.test.js` — Lambda定義行の仮引数部（`params[]`）が総当たり縮約に誤って
  素通しされず、専用処理されることの確認（裸の複数仮引数・rest・ブラケット形式・
  インデントブロック形のデフォルト引数とlet*的な逐次スコープ）。

## セットアップ

```
npm install
node test/pass2.test.js          # Pass2単体の検証
node test/nested_scope.test.js   # ブロックスコープ連鎖の検証
node test/multiline_block.test.js  # 複数行ブロックの検証
npm run build:parser             # sign.pegjs から parser.js を生成（--format es、都度生成、コミット対象外）
```

## `grammar.pegjs`の根本修正（正式仕様ファイル自体を修正済み）

実装を進める中で、正式仕様`documents/ja-jp/impl/syntax/grammar.pegjs`自体に、**Blockが他の項と
同じExpression内に混在すると中身が漏れる**というバグを発見した。原因は`Term`/`Expression`/`Block`の
3箇所にまたがる「配列ラップの非対称性」で、以下の3点をセットで修正することで根本的に解消した
（`documents/ja-jp/impl/syntax/grammar.pegjs`本体・`alpha/javascript/sign.pegjs`の両方に反映済み）。

1. **`Term`**：`pre`/`post`が空でも、`core`が配列（Block）なら1階層ラップして返す
2. **`Expression`**：soloかどうかに関わらず常に`.flat()`する（以前はsolo時にスキップしていた）
3. **`Block`**：indent/abs系も`exprs`を`...`展開せず1要素として保持する（bracket系と対称に。
   以前はindent/abs系だけ`...exprs`と展開しており、bracket系より保護膜が1階層薄かった）

この修正により、単一行ブロックだけでなく複数行ブロックも正しく「1つのブロック内の複数文」として
解決されるようになった（`test/multiline_block.test.js`で確認—以前は単一行ブロックがたまたま
正しく見えていただけで、複数行ブロックは誤解釈されていた可能性がある、未検証のまま埋もれていた懸念だった）。

以前このファイルにあった`repairLeakedBlocks()`という対症療法的な回避策（漏れたマーカーを
検出して復元する）は、この根本修正により不要になり撤去済み。`resolveBlock`も新しい一貫した
構造（bracket系: `term`がそのまま`exprs`、indent/abs系: `term[1]`が`exprs`）に合わせて書き直した。

## 現状（動作確認済み）

**Pass2（`coproduct_resolver.md`実装）**：9/9 pass。フラットなTerm列を二分木ASTへ縮約する。

- Shunting Yard（`operator_table.js`の優先順位1〜26に基づく演算子の結合。tier26=escapeから
  tier1=exportまで高い方から処理）
- Lambda/Atomカテゴリの判定（`getCategory`）とcompose/apply/apply_reverse/concatの優先度
  10.5〜10.0での総当たり縮約（`coproduct_resolver.md`§3-4）
- List/Structの`~`必須マージルール（`coproduct_resolver.md`§5）
- 裸のrestパラメータ（`x ~xs ? ...`）への`~`なしList渡しをTypeErrorで拒否（`coproduct_resolver.md`§5.4、
  `test/rest_param_typecheck.test.js`で確認）。ブラケット形式（`[x ~xs] ? ...`、Eager）は対象外
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
- **ストレージ/寿命の面はTCOによってほぼスタックポインタの挙動整理だけで説明できる**：末尾再帰は`JMP`に変換され深さO(1)に収束し、レンジ式は`LOOP`/`JNZ`に直接変換されスタックを使わない。部分適用クロージャの`alloca`も「静的サイズの単一mainアリーナ」（`tco.md`§8.2、実験的提案）に収まる。例外は**末尾位置でない再帰**だけで、ここは本物の`CALL`/`RET`で動的にスタックが伸びる（言語仕様上エラーにはしていない、warningで議論中）
- この上で残っているのは**名前解決（シャドーイングルール、可視性）**の面で、こちらはスタックポインタとは独立なコンパイル時シンボルテーブルの話であり、今回実装した`pass1.js`の連鎖envはまさにこの面を担う

### Pass1の既知の制限

- スコープ検査（未定義識別子の参照エラー等）は一切行っていない。
- 同一スコープ内での再定義は後勝ちで単純に上書きする。
- 本来のPass1（`compiler_pipeline.md`）が持つべき`.ist`（`type_system.md`§5 Pass1a）は
  `{ category, restParam }`という一部分のみを先取り実装済み（`restParam`は仮引数列の
  `~xs`が裸かブラケット内かを見て`'bare'|'bracket'|null`を判定、`coproduct_resolver.md`§5.4で使用）。
  `arity`・`atom_type`・`callsites`（Pass1b、`@ref`のジェネリック具体化）・export印（`#`/`##`/`###`）は未実装。

## Lambda仮引数部の専用処理（`params[]`ノード、デフォルト引数対応）

`:`(define, precedence=1)と`?`(lambda, precedence=2)は演算子テーブル上もっとも低い優先度で
処理されるため、仮引数部をそのまま総当たり縮約に素通しすると、`?`が実際に処理される**前**に
仮引数部の中身が既存の汎用ルールで誤って確定してしまう問題があった
（`g x` → `construct[g,x]`、`y : x + 1` → `define[y, add[x,1]]`——どちらも「仮引数の宣言」を
「値の式」と誤解決していた）。

`reduceAll`（pass2.js）に、行の中にトップレベルの`?`があれば仮引数部を先に切り出す分岐
（`resolveLambdaLine` / `buildParameterList`）を追加し、以下を実装した。

- 裸の複数仮引数（`g x`）・裸のrestパラメータ（`x ~xs`）・ブラケット形式（`[x ~xs]`、1行に
  複数の裸パラメータが同居するケース含む）が、`params[]`という専用ノードとして正しく構造化される
- インデントブロック形のデフォルト引数（`function_guide.md`の`y : x + 1`構文）が、`define`文と
  誤解釈されずに「デフォルト式」として解決される
- デフォルト式はlet*的な逐次スコープ（自分より前に束縛済みのパラメータ + 外側スコープのみ参照可能、
  `test/param_list.test.js`で確認）に従う（例: `z : y + 1`が直前の`y`を正しく参照する）
- 単一の裸パラメータ（デフォルト・rest無し、例: `f : x ? x + 1`）は既存の出力形状
  （`identifier(<x>)`単体）を保つよう後方互換を維持している
- ブラケットを仮引数リストの定義行より深くインデントして複数行で書く形式（`func_mixed`例）は、
  grammarのTerm規則（単独のブロックcoreは1階層ラップされる）により仮引数部が余分に入れ子に
  なるため、`flattenParamStatements`で再帰的にラップを剥がして実際のパラメータ行の並びに
  正規化している

- let*的な逐次スコープは、後ろ（または自分自身）の未束縛パラメータへのデフォルト式からの
  参照を`ReferenceError`として拒否する（7月30日の設計スレッドが意図した「通常の未定義識別子
  エラーとしてPass1で弾ける」という設計の実装。`test/param_list.test.js`で確認）
- デフォルト・rest以外の仮引数の数（`requiredArity`）を`params[]`ノードに構造だけから機械的に
  計算して持たせている（値の評価は不要、`function_guide.md`「関数適用時」節のアリティ計算の
  静的な下ごしらえ）

**未実装（`.ist`/`.st`）関連の既知の限界**：

- **本物のインタプリタ・評価器が存在しない**。デフォルト引数を持つ関数のアリティ計算からの
  除外・`__`渡し時のデフォルト値フォールバックといった`function_guide.md`「関数適用時」節の
  意味論は、値を実際に評価しないと確認できないため未実装（`requiredArity`はその静的な
  下ごしらえのみ）
- 裸形式（ブラケット・インデントブロックで囲まれていない）でのデフォルト式は現行仕様に例が
  無いため未対応（`splitBareParamTokens`はrestのみ扱う）
- ブラケット形式とデフォルト引数を組み合わせた複数行の例（`function_guide.md`の`func_mixed`）は
  `flattenParamStatements`（Termの配列ラップを再帰的に剥がす）と`lexer.js`のブラケット深さ
  追跡により解決済み（`test/param_list.test.js`で確認）

## Pass3: 型伝播（`type_system.md`§2〜§3.2）

`pass3.js`が`inferAtomType(node, env)`を実装する。Pass2が返す二分木ASTのノードを受け取り、
Layer 2 Atom内部型（`Address`/`Float`/`String`/`List`/`Unit`等）を推論する。

- **左辺優先ルール**（§3.2）：`typeof(L op R) = typeof(L)`。中置演算ノードは左辺の型を
  再帰的に推論してそのまま結果とする。
- **`String`+算術演算子の例外**（§3.2 NOTE）：左辺が`String`のとき算術演算子（`+ - * / % ^`）が
  来ると、リストに対して算術は効かないため型エラーとして`Unit`に収束する
  （例: `` `123` + 0 → Unit``）。
- **リテラルからのatomType解決**：数値リテラルは小数点の有無で`Address`/`Float`を判定、文字列・
  文字リテラルは`String`、`__`は`Unit`とする。
- **識別子のatomType解決**：`pass1.js`の`buildEnvScope`が`<id> : <リテラル1個>`という最も単純な
  定義行から静的に読み取ったものだけを解決できる（`test/pass3.test.js`で確認）。
- **仮引数のatomType自動導出**（`inferLambdaParamTypes`、`type_system.md`§7.1）：仮引数自身は
  `<id> : expr`という定義行を持たないため、本体の算術演算子（`+ - * / % ^`）使用箇所（左辺・右辺
  どちらも）から`Scalar`と逆算する。最初に見つかった制約を採用する単純な線形スキャンで、HM流の
  単一化は行わない（`test/pass3_param_usage.test.js`で確認）。

**既知の制限**：

- 仮引数のatomType逆算は算術演算子のみ対応。比較演算子・`'`（get_prop）等、他の演算子からの
  逆算は未対応。
- 逆算結果は`Scalar`という抽象カテゴリまでで、具体的な`Address`/`Float`の区別までは決まらない
  （§4の`+`/`-`シグネチャ自体が`Scalar`までしか要求しないため）。
- 比較演算子・空間演算子（余積）等、算術演算子以外は一律で左辺優先ルールにフォールバックしており、
  §4の個別の型シグネチャとの細かい整合は未検証。
- block（List/Struct/Dictの区別、`coproduct_resolver.md`§5）は未対応。暫定的に一律`List`とする。
- Pass 1b（`@ref`のジェネリック具体化）・`.st`生成・実際のコード生成（Pass4）は未実装のまま。

## `pass2.js`実装時に置いた仮定（仕様に明記なし、要レビュー）

1. 複数の前置/後置演算子が連続する場合（例: `!$x`）の結合順序：coreに近い方から先に結合する
   （`!$x` = `!($x)`）という一般的な慣習を採用。
2. 優先度10.1（Unshift/push）の具体的な演算子名：仕様は「Atom|List~ の組み合わせ」としか
   書いておらず方向性の区別が明記されていない。List~側が右ならpush、左ならunshiftとした。
3. Block（`[...]` `{...}` `(...)`）の種別（paren/brace/bracket）：`grammar.pegjs`側で
   区別を保持しないため、AST上でも区別できていない（kindは"paren"固定、indent/absのみ判別）。

## 未解決・要確認の疑問点（過去分）

1. `~rest`末尾固定の検証、デフォルト式のスコープチェック（n番目・後ろからm番目等の拡張パターンマッチ含む）は将来の別issue。
2. `LanguageServer/`は現段階ではコンパイラパイプラインを実装しない方針のため、`server.js`への
   前処理・新文法の統合は行っていない（`sign.v0.pegjs`ベースのまま）。
