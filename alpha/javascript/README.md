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
  **`buildLexerRegex()`のバグを修正済み**：ダブルクォート文字列内の`(\\.|[^"\r\n])*`が捕捉
  グループのままだったため、`lexer.js`の`separateInfix`が読むグループ番号が1つずれ、
  演算子（`,`・`+`・`<`等）の前後への自動スペース挿入が**事実上ずっと機能していなかった**
  （既存テストは全てソース側に手でスペースを入れていたため気づかれていなかった）。非捕捉
  グループ`(?:...)`に変更して解消。
  **`OPERATOR_DICT`構築ループのオフバイワンも修正済み**：`for (let prec = 1; ...)`が配列
  index 0（コメント上の優先順位"1"：改行・前置export`#`/`##`/`###`）を一生読み飛ばしていた
  ため、これらが`OPERATOR_DICT`に一切登録されず、かつ他の全演算子もコメント表記より
  1つ小さい優先順位で格納されていた（相対順序は一律ズレのため偶然壊れなかったが、
  `pass2.js`の`reduceOnce`がハードコードする`tier === 10`（余積/スペース）が、本来は
  コメント優先順位"11"のレンジ演算子`~+`等と衝突していた）。`prec = 0`から開始し
  `precedence: prec + 1`でコメント表記と一致させて解消（`documents/ja-jp/impl/syntax/
  operator_table.js`本体にも同時反映済み）。
- `sign.pegjs` — `documents/ja-jp/impl/syntax/grammar.pegjs`そのもの（正式仕様、**根本バグ修正済み**）。
  **peggy記法**（`@`ラベル等）を使用しているため、`pegjs`ではなく`peggy`パッケージでビルドする必要がある。
  **`identifier`規則のバグも修正済み**：`"_" [a-zA-Z0-9_]+`が`__`（Unit）にもマッチしてしまい
  `unit`規則へ一生到達しなかった問題を、`&{ id !== "__" }`述語で除外して解消
  （`documents/ja-jp/impl/syntax/grammar.pegjs`本体にも同時反映済み）。
- `pass1.js` — Pass1（最小実装）。ブロック階層に沿ってネストした識別子環境（env連鎖）を構築し、Pass2のgetCategoryに渡す。
  `<id> : <リテラル1個>`という単純な定義行からLayer 2 Atom内部型（`atomType`）も静的に読み取る。
  前置export記号（`#`/`##`/`###`）も検出し、Bindingの`exported`フィールドに記録する。単純な
  空白区切りの複数パラメータ（rest・ブラケット無し）の**アリティ**も`arity`フィールドに記録する。
- `pass2.js` — Pass2（`coproduct_resolver.md`）の実装。フラットなTerm列を二分木ASTへ縮約する。
  **多引数関数の呼び出しが正しく飽和するよう修正済み**：`getCategory`が`apply`ノードを
  問答無用でAtom扱いしていたため、`f : x y ? x + y`に対し`f 3 5`が
  `construct[apply[f,3], 5]`（fを3だけに適用した結果と5をタプル化）に誤って縮約されて
  いた（単一パラメータの関数では表面化しない、多引数特有のバグ）。`applyChainInfo`で
  左に伸びるapplyチェーンの深さを数え、`pass1.js`の`arity`に届くまでLambdaのまま扱う
  ことで、`apply[apply[f,3],5]`という正しく飽和したチェーンになるよう修正
  （`test/multi_arg_apply.test.js`で確認）。アリティを超える余分な引数は、飽和した
  呼び出し結果の後ろに`construct`でタプル化される（仕様として意図された挙動）。
  **tier=10（余積）の縮約を、仕様通りの段階的マルチパス（compose→apply→apply_reverse→
  concat/push/construct）に修正済み**：以前はcompose/apply/apply_reverse/concat/push/construct
  の区別なく、隣接ペアを左から見て最初にマッチしたものを即座に縮約する単一グリーディ
  スキャンになっており、`coproduct_resolver.md`§4が規定する優先順位（10.5→10.0）が
  守られていなかった（例: `inc:x?x+1`として`5 inc 3`が、本来tier10.4(apply)で先に
  `inc 3`が縮約され`construct[5, apply[inc,3]]`になるべきところ、実際は左端の`5 inc`が
  tier10.3(apply_reverse)として先に縮約されてしまっていた）。`COPRODUCT_PHASES`で
  4段階に明示的に分割し、各段階を使い尽くしてから次へ進むよう修正（`test/interpreter.test.js`
  で確認）。8/5の設計討論で、apply_reverse（`x f`記法）はSVOの中置呼び出し（主語=第1引数、
  Option A）ではなく、UFCS的なreceiver記法（`f : [foo bar ~this] ? ...`のようなオブジェクト
  指向的呼び出しを想定、Option B）と結論づけた——この修正により、apply_reverseは「そのLambda
  が右側に通常適用できるAtomを持たない場合のみ」発動するフォールバックになり、両隣にAtomが
  あるLambda（`5 inc 3`）ではapplyが先に確定してapply_reverseが途中のAtomを横取りしない。
- `pass3.js` — Pass3（`type_system.md`§2〜§3.2の型伝播）の実装。Pass2が返す二分木ASTを歩いて
  左辺優先ルール（`typeof(L op R) = typeof(L)`）でLayer 2型を推論する。
- `pass1b.js` — Pass1b（`type_system.md`§5、`@ref`ジェネリック仮引数の具体化）の実装。
  `@`前置演算子で参照される仮引数を検出し、プログラム全体の呼び出しサイトから実引数の
  カテゴリ（Lambda/Atom）を静的に収集する。
- `interpreter.js` — 最小インタプリタ（初実装）。`evaluate(node, runtimeEnv)`でPass2/Pass1bの
  ASTを実際に評価する。完全性公理（`f __ = __`）、デフォルト引数・restパラメータへのUnit
  フォールバック、算術/比較演算子のUnit伝播則、`&`/`|`/`;`の短絡評価、多引数関数の一括適用
  （apply連鎖を遡って引数を集めてから1回だけ本体を評価）を実装。`$`/`@`/`#`（アドレス操作）は
  メモリモデルが未設計のため未対応。type_system.md §3.3/§3.4の具体例をそのまま実行して
  値が一致することを確認（`test/interpreter.test.js`、17/17 pass）。
  **副産物のバグ修正**：`pass1.js`の`arity`計算がインデントブロック形のデフォルト引数
  （`g :\n x\n y:x+1\n ? x+y`のような形）に対応してなかった（裸の`x y z`形のみ対応）ため、
  デフォルト引数を持つ多引数関数の呼び出しが多引数バグと同様に壊れていた。`countArity`が
  ネストした仮引数部も再帰的に数えるよう拡張して解消。
  **関数合成（compose）を追加、かつ合成順序のバグを修正**：`documents/ja-jp/guide/example.sn`
  の`[+ 1] [* 2] 5 = [* 2]([+ 1] 5) = 12`が示す通り、Signの`f g`は数学記法の`f∘g`
  （gが先）ではなく**左→右のパイプライン順**（`(f g)(x) = g(f(x))`、fが先）。実装時に
  一度逆に実装してしまい、指摘を受けて修正した。
  **文字列（String）の挙動を修正**：算術演算子の左辺がStringの場合、型エラーで`__`に
  収束する（`type_system.md`§3.2の表を正とした——`list_model.md`§4.4の文面「`+`で
  コードポイントが露出する」は自身の例で実証されておらず、既知の食い違いとして記録）。
  スペース（余積）で左辺がStringの場合は、右辺を文字列化してテキスト連結する
  （`` `123` 123 = `123123` ``、list_model.md）。
  **再帰を確認、後置~の引数展開が未実装だったのを修正**：`type_system.md`§3.3の
  `sum : x ~xs ? x + (sum xs~)` を実行したところ無限再帰でスタックオーバーフローした。
  原因は後置~（`xs~`）が「配列を複数の位置引数へ展開する」という意味（pattern_guide.md
  「関数にListを渡すときは必ず後置~を使う」）を実装してなかったこと——`xs`という1個の
  配列値がそのまま1個の引数として渡り続け、restが空にならず終端しなかった。`apply`の
  引数収集時に後置~を検出して展開するよう修正して解消（`sum 1 2 3 = 6`を確認）。
  なお、この式は括弧が必須（`+`の優先順位13はスペース適用10より高いため、括弧無しの
  `x + sum xs~`だと`x`と`sum`（関数値そのもの）が直接結合されてしまう——`type_system.md`
  §3.3の例自体にこの括弧が欠けていたため、そちらにも追記済み）。
  **辞書リテラルが独立したスコープを持つよう修正**：全行が`define`のブロック（`[foo:1,
  bar:2]`改行形）は、以前は「ブロックの値＝最後の文の値」として評価してしまい、辞書
  オブジェクトにならず`foo`/`bar`が呼び出し元のenvへ漏れていた（`pass3.js`のDict判定と
  同じ基準：全行defineなら独立した子envで評価しJSオブジェクトとして返す、キーは漏れない）。
  **未定義識別子のUnit収束をinformation診断として記録**：`unit.md`§0.1「未定義識別子は
  `__`として評価される」を実装済み（`envGet`が例外を投げず`UNIT`にフォールバック）。加えて
  この収束が起きた箇所を`env.diagnostics`（ルートenvから子envへ共有される配列、`{level:
  "information", message, identifier}`）に記録するようにした。仮想キーワードとしての意図的な
  利用（`@lazy tick`等）を妨げないよう、warning/cautionへは格上げしない（`test/interpreter.test.js`
  で確認）。末尾位置での未定義識別子呼び出しをwarningにする規則（`tco.md`§3）はTCO解析が
  無い本インタプリタでは対象外。
  **`apply_reverse`の評価を追加**：`pass2.js`のtier=10マルチパス化と対で、`x f`（UFCS的な
  receiver記法）の評価が今まで未対応（`未対応の演算 'apply_reverse'`）だったのを実装した。
  `applyClosure(evaluate(f), [x])`——通常の`apply`と全く同じ`bindParams`経路（完全性公理・
  デフォルト引数フォールバック込み）を通すだけで、receiver専用の特別なロジックは無い
  （`f : [foo bar ~this] ? ...`のような構造体destructuringも通常呼び出しと同じ仕組みで
  解決される、という8/5の設計合意通り）。
  **左側は常に1個の値に制限（複数引数化しない）**：`apply`は後置~（expand）で渡された
  引数をList内容へ展開して複数の位置引数に分配するが、`apply_reverse`は同じ展開を行わない
  ——`[1 2]~ pair`（`pair:a b?a`）は`pair`に`[1,2]`を**1個の値**として渡すだけで、
  `pair(1,2)`のように展開されない（bが埋まらず完全性公理で`__`に収束、
  `test/interpreter.test.js`で確認）。8/5の設計合意「apply_reverseは複数引数を取らない」
  を反映。
  **ブラケット仮引数リスト（`[x ~xs]`等、list_model.md §2.4のEagerパターン）への単一
  List/Dict実引数の分割代入を実装**：以前は`bindParams`がブラケット形式か裸形式かを
  区別せず、渡された実引数を単純に位置順で束縛していたため、`sum_list : [x ~xs] ? ...`に
  `sum_list [1 2 3 4 5]`を渡すと（本来 x=1, xs=[2,3,4,5] に分割されるべきところ）List
  **全体**が最初の仮引数`x`にまるごと束縛され、restが常に空になって再帰が終端せず
  スタックオーバーフローしていた。同根の原因で`calc_diff : [foo bar ~obj] ? ...`への
  辞書渡し（キー名一致の自動バインド、function_guide.md「構造体メンバーの一致による
  自動バインディング」）も`__`に崩壊していた。
  `pass2.js`側に`isBracketParamList()`を追加し、`params`ノードへ`bracket: true/false`
  フラグを持たせるようにした（func_mixedのようにブラケットが定義行より深くインデントされ、
  grammarのTerm規則で1階層余分にラップされるケースも正しく判定——README「Lambda仮引数部
  の専用処理」参照）。裸の複数行デフォルト引数形式（`g:\n x\n y:x+1\n?...`）は`bracket:
  false`のままで、既存のstream/pull型の位置引数束縛を維持する（8/5の設計合意：ブラケット
  無しは参照ではなくストリームとして処理する）。
  `interpreter.js`の`bindParams`は、`bracket:true`かつ実引数がちょうど1個でList/Dict
  （非Lambda）なら`bindBracketParams`へ分岐する。Listは先頭から非restエントリへ位置的に
  配り、restエントリが残り全部をスライスで受け取る。Dictはエントリ名とキー名の一致で
  （順序に関わらず）値を引き、restエントリがあれば名前が一致しなかった残りのキーを
  まとめた新しいオブジェクトを渡す。`test/interpreter.test.js`で`sum_list [1 2 3 4 5]
  → 15`・`calc_diff`のキー順不同渡し`→ 80`・`pattern_guide.md`のStore例（`get_age dict
  → 20`）を確認、既存のList destructuring（`get_age [1 2 3] → 1`）・裸の複数引数
  （`f 3 5 → 8`）にも回帰なし。
  【`.st`/`.ist`への含み、8/5の設計合意】`bindBracketParams`が参照する`entries`の名前列挙は、
  将来`.st`生成（`type_system.md`§6.2「関数仮引数のフィールド要求」、`{x, y}`のような
  構造的フィールド要求集合）を実装する際、そのまま再利用できる想定で実装した。
  **match_caseを実装**：`function_guide.md`「`?`の右辺を改行・インデントブロックを挟むことで、
  本体内の`:`演算子はmatch_caseとなる」を実装した。以前は本体ブロック内の`cond : result`行
  （例: `x > 3 : x - y`）が、左辺が識別子でない普通の`define`ノードとしてAST上は正しく
  構築されていたが、`envDefine(env, undefined, ...)`という無意味な副作用を起こすだけで
  評価結果は捨てられ、ブロック評価は常に「最後の行の値」を返すだけだった（`func_mixed [5]`が
  `-1`ではなく`6`になっていた）。ブロック評価で、defineノードのうち左辺が識別子でない
  （＝実質的には条件式の）行を「条件:結果」の短絡評価テストとして扱うよう修正：条件を評価し
  非Unit（真）なら即座にその行の右辺を返してブロック全体を打ち切り、Unit（偽）なら束縛を
  一切行わず次の行へ進む。左辺が識別子の行は今まで通り変数定義として扱う。
  **副産物のバグ修正**：Dict判定（`node.lines.every(isDefineNode)`）が左辺の識別子チェックを
  していなかったため、フォールバック行の無いmatch_case連鎖（全行が`cond:result`）を
  Dictと誤判定して`line.left.value`（存在しない）にアクセスしクラッシュしうる状態だった
  ——`isIdentifierNode(l.left)`も要求するよう修正。
  `test/interpreter.test.js`で`func_mixed`（3パターン）・`pattern_guide.md`のEither例
  （3パターン、条件の短絡確認込み）・辞書リテラルの回帰なしを確認。
  **`'`（get_prop）を追加**：`d ' foo`のように、右辺が識別子の場合は変数として評価せず
  「キー名そのもの」として辞書から引く（数値なら通常通り評価してListのインデックスに使う）。
  **`push`/`unshift`（list_cheat_sheet.md「先頭/末尾に要素追加」）を実装**：評価ケース自体が
  無く「未対応の演算」で例外になっていた。`pass2.js`側の命名はJS配列メソッドとは意味が
  逆（優先度10.1の方向性は仕様に明記が無く実装時の仮定、`pass2.js`冒頭コメント参照）
  ——`push(a,b)`はb側がList（`0 [1 2 3]`）で「aを先頭へ」、`unshift(a,b)`はa側がList
  （`[1 2 3] 4`）で「bを末尾へ」。
  **`|list|`（abs、list_cheat_sheet.md「要素数の取得」）を実装**：`abs`ブロックとしては
  以前から正しくパースされていたが、評価側で長さ/絶対値の計算をしておらず中身がそのまま
  返っていた。List/Stringなら`.length`、数値なら`Math.abs`（絶対値とリスト要素数を
  同じ記号で表す設計、list_cheat_sheet.mdの命名がそのまま実装のヒントになった）。
  **`,`（product、n次元配列構築）の左右非対称バグを修正**：ASTは元から正しかったが
  （`1 2 3 , 4 5 6`は`product[[1,2,3]の塊, [4,5,6]の塊]`という綺麗な形）、評価が
  `[...asList(l), r]`（左だけ展開し右を1要素として追加）になっており`[1,2,3,[4,5,6]]`
  という非対称な結果になっていた。単純に`[l, r]`にすると、list_model.md §2.1の
  「`1,2,3,4,5`はスペース区切りと等価なフラットリスト」（`,`は左結合の連鎖）が壊れる
  （`product[product[1,2],3]`のような連鎖が展開されず深くネストしてしまう）ため、
  「左辺自身が同じproductノード（＝連鎖の続き）なら展開して連結、そうでなければ
  （スペースで構築済みの塊やリテラル単体なら）互いに対等な要素として2要素リストにする」
  という判定に修正（`test/interpreter.test.js`で両ケースを確認）。
  **List左辺の算術演算子（`*`/`^`/`/`、list_cheat_sheet.md「重複した要素の作成/リフト/分割」）
  を実装**：以前はList値がそのままScalar用の`ARITH_OPS`（JSの`*`/`^`/`/`演算子）に渡り、
  JSの配列→文字列強制変換で静かに`NaN`を返していた（例外にもならず、一見それらしい値も
  返らない、気付きにくいバグだった）。`evalArith`に`Array.isArray(l)`の分岐を追加し、
  `*`=repeat（`l`を`r`回連結）、`^`=lift（`l`のコピーを`r`個持ち上げる）、`/`=split
  （`l`を`r`個のグループへ均等分割）を実装。list_cheat_sheetに例が無いList左辺の
  `+`/`-`/`%`は、Stringの場合（§3.2）と同様に型エラーとして`__`へ収束する。
  **range（`[start ~ end]`・派生演算子`~+`等、list_model.md §2.3）を実装**：以前は
  "range"/"range_arithmetic"ノードの評価ケースが無く「未対応の演算」で例外になっていた。
  仕様上レンジ式の実体は常にイテレータ（`{start,step,end}`の固定サイズ構造体）だが、
  本インタプリタは値を全て実体化する単純な評価器のため、**3項セット**
  `[start 演算子 step 演算子 end]`（「即座に全消費」、例: `[2 ~+ 2 ~ 10] → [2 4 6 8 10]`）
  ・**単純形式**`[start ~ end]`（step省略、`start<=end`なら+1・降順なら-1、例:
  `[1 ~ 5] → [1 2 3 4 5]`）は配列へ即座に展開する。**2項指定**`[start ~+ step]`
  （終端なし、仕様上は終端の無いPull型無限ストリーム）は実体化のしようが無いため、
  無限ループにする代わりに明示的に未対応のエラーを投げる（`test/interpreter.test.js`で
  例外になることを確認）。`get_prop`（`'`）もrange（配列）を右辺に取れるよう拡張し、
  `[1 2 3 4] ' [1 ~ 3] → [2 3 4]`（範囲インデックスでの一括取得、list_cheat_sheet.md）
  を実装。
  **既知の追加課題（未着手）**：後置`~`（expand）が単なる素通しの実装のため、`[1 2,3 4]~`
  のようなネストしたリストのフラット化（list_cheat_sheet.md「リストのフラット」）は
  1階層剥がれない（`[[1 2] [3 4]]`のまま）。`[1 2 3] ' -1`（負のインデックスで末尾要素を
  取得）も`get_prop`が負数を考慮しておらず未対応のまま（list_cheat_sheet.md「末尾要素の取得」）。
- `test/pass2.test.js` — Pass2単体（envなし）の動作確認。9/9 pass。
- `test/multi_arg_apply.test.js` — 多引数関数の呼び出しがapplyチェーンとして正しく飽和し、
  余分な引数がconstructでタプル化されることの確認。3/3 pass。
- `test/pass3.test.js` — Pass3の型伝播（左辺優先ルール、String+算術演算子→Unit、リテラルからの
  atomType解決、List/Struct/Dictの区別）の動作確認。10/10 pass。
- `test/pass3_param_usage.test.js` — 仮引数のatomType自動導出（本体の算術演算子・比較演算子
  使用箇所からのScalar逆算、`type_system.md`§7.1）の動作確認。6/6 pass。
- `test/pass1b.test.js` — Pass1b（`@ref`ジェネリック仮引数の検出、呼び出しサイト収集、
  exportされたジェネリック関数に呼び出しサイトが無い場合のコンパイルエラー）の動作確認。4/4 pass。
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
  `<id> : expr`という定義行を持たないため、本体の算術演算子（`+ - * / % ^`）・比較演算子
  （`< <= = >= > !=`、§4）使用箇所（左辺・右辺どちらも）から`Scalar`と逆算する。最初に
  見つかった制約を採用する単純な線形スキャンで、HM流の単一化は行わない
  （`test/pass3_param_usage.test.js`で確認）。
  - 比較演算子は`node.name`ではなく`node.op`（記号）で判定する：`!=`（§4対象、precedence 12）と
    `!==`（構造比較、precedence 8）は`name`が両方"not_equal"で衝突するため。`==`/`===`/`!==`は
    Scalarに限定されない構造比較（§4 NOTE）なので逆算の対象外。
- **List/Struct/Dictの区別**（type_system.md §2、list_model.md）：
  - スペース（余積）でAtom同士が結合された演算（`construct`/`concat`/`push`/`unshift`）は`List`。
  - カンマ（`product`、直積）で結合された要素列は、全要素が`define`（key:val）なら`Dict`、
    そうでなければ`Struct`（`1, 2, 3`のような多相リスト/直積構造、type_system.md §2の例）。
  - 単一の`key:val`（`define`）1個だけの場合も`Dict`とする（例: `[foo:1]`）。
  - 複数行のブロックで全行が`define`なら`Dict`（`list_model.md`§5.3・`pattern_guide.md`の
    改行区切り辞書リテラルの形）。それ以外の複数行（関数本体等）は、Dict化せず「ブロックの値＝
    最後の文の値」という通常のブロック式のセマンティクスにフォールバックする
    （`test/pass3.test.js`で確認）。
  - **カンマと`:`を1行に混在させる形（例: `[foo:1, bar:2]`）は意図的に非対応**。
    `list_model.md`/`pattern_guide.md`の辞書リテラル例はすべて改行区切りで、この形は
    ドキュメントのどこにも登場しない。「一つのことを表現する方法は一つ」の方針により、
    辞書は改行区切りの形だけをサポートする（一時的にトップレベルの`,`を先に分割して
    この形も動くようにする修正を入れたが、未定義入力への対症療法だったため撤去した）。

**既知の制限**：

- 仮引数のatomType逆算は算術演算子・比較演算子（`< <= = >= > !=`）のみ対応。`'`（get_prop）等、
  他の演算子からの逆算は未対応。
- 逆算結果は`Scalar`という抽象カテゴリまでで、具体的な`Address`/`Float`の区別までは決まらない
  （§4の`+`/`-`シグネチャ自体が`Scalar`までしか要求しないため）。
- 比較演算子・空間演算子（余積）等、算術演算子以外は一律で左辺優先ルールにフォールバックしており、
  §4の個別の型シグネチャとの細かい整合は未検証。
- `.st`生成・実際のコード生成（Pass4）は未実装のまま。

## Pass1b: `@ref`ジェネリック仮引数の具体化（`type_system.md`§5）

`pass1b.js`が`specializeGenericParams(defineNode, resolvedNodes, env)`を実装する。

- **ジェネリック仮引数の検出**（`detectGenericParams`）：本体で`@`前置演算子が直接かかっている
  仮引数（例: `apply_five : f ? @f 5`の`f`）は、参照先がLambdaかAtomか定義サイト単体では
  決まらないため、ジェネリックとみなす。
- **呼び出しサイトの収集**（`collectCallsites`）：プログラム全体の解決済みASTを走査し、
  `apply[fnName, arg]`という形の呼び出しを全て集める。
- **具体化**：集めた呼び出しサイトの実引数を`pass2.js`の`getCategory`でカテゴリ分けし、
  観測されたカテゴリの集合を返す（`test/pass1b.test.js`で確認）。
- **exportされたジェネリック関数に呼び出しサイトが無い場合はコンパイルエラー**（§5、
  `compiler_pipeline.md`§6.3）：`defineNode.exported`（前置export記号、`pass1.js`/`pass2.js`
  が検出）が真かつ呼び出しサイトが0件なら`TypeError`を投げる。exportされていなければ
  デッドコードとして単純に discard（空の結果を返すのみ、エラーにしない）。

**現状の実装範囲・既知の制限**：

- 呼び出しサイトの収集は、`compiler_pipeline.md`§6が定義する「debugビルドで`test`フォルダを
  実行して得るトレース」ではなく、**`src`（プログラム全体の解決済みAST）に対する静的走査のみ**
  で行う（テストフォルダを実行するインタプリタ自体がまだ存在しないため）。
- 引数が複数あるLambdaへの呼び出しサイトのうち、ジェネリック仮引数以外の位置の対応付けは
  未対応（単一引数の関数を想定した簡易実装）。
- 相互再帰するジェネリック関数同士の具体化（§5「本節は将来の検討事項」）は未対応。
- 非Lambdaの単純なexport定義（例: `#add : [+]`）は、`?`が無いため汎用の縮約経路を通り、
  export記号が`define`ノードの`exported`フィールドではなく、`left`側の前置演算ノード
  （`export_internal(...)`等）として現れる（Lambda定義のexportとAST形状が異なる）。
  ただし`env`のBinding（`pass1.js`）は両ケースとも`exported`フィールドで統一的に引ける。

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
