/**
 * 余積（空白）の解決（alpha1 の意味解析の最初の段）。
 *
 * 仕様は alpha1/docs/coproduct_spec.md（設計 workflow の最終版）。ここに書くのは、確信度 91% 以上の規則
 * （§4 の R1〜R48（R18 と R30 は 2026-10-21 に廃止。R6 の強さの順と R35〜R37 の組み立て直しの部分は 2026-10-23 に、左からの畳み込み
 * R40〜R43 に替えて廃止。R44〜R46 は同じ日の、口の外の `!_` は恒等射・恒等射は `,` の単位。R12・R14・R37 は 2026-10-24 に、逆適用の
 * 廃止（R47）で廃止。R48 は同じ日の、余ったラムダの診断。R49〜R51 は同じ日に試しで入れ（番地は指す関数を運ぶ・`[F,]` の写像・撒いた並びは
 * 流れの1項。利用者「試しにやってみよう！…悪ければロールバックしよう。」）、2026-10-25 に決定にした（口が1つの関数への流れは写像から書き下しに
 * 直した。§7.31）。R52 は同じ日の、評価する所の外でも、値の上に
 * 積まれて何も受けずに閉じた関数は余ったラムダ。同じ日の §5 Q50〜Q52・Q44 の答えで、`:` の右辺にも当て、`$[…]` の中身は遅延した式で
 * 判定せず、知らせの重さは warning。R53 は同じ日の、`$` は関数だけを運ぶ（G20）。R54〜R57 は 2026-10-25 の、`$` の先は
 * 書いた所で1つの関数と言い切れること（局所の定義・別名の印・`$_` は零射 `$[x ? _]`・後置の印は断り、前置の印の組み合わせは先で決める。classifyDollar）。
 * 同じ日の §5 Q56 の答えで、`$!_` と恒等射の別名の `$i` は1引数の恒等射 `[x ? x]` を指す印を持つ。R58〜R61 は同じ日の §5 Q58・Q53・Q54・Q41 の
 * 答え：合成に来た流れは合成全体の口の数で受ける（streamInto）・`$[…]` の中身に余る関数があれば G20・`$` は Reader と Writer を作る接頭辞で値の先も
 * 値を読む参照として通す（classifyDollar）・`,` の被演算子の書いた `_` は積の単位（resolveProduct）。同じ日の確かめの直しで、Reader を値の演算子に
 * 置く形を綴りに依らず断り（valueOperand・readerAtPlain・paramTag）、`$[…]` の中身を単位律で縮めて見て（unitReduced）、括りの関数の本体の仮引数を
 * 含まない行を読み（deadInPatternBody）、名前の先の本体を覗くのは木を残す段だけにした（deadOfDef）。R62・R63 は 2026-10-26 の §5 Q59・Q64 の
 * 答え：番地の点と差（`$` の値の参照と点として置いた `0x…` は点、点どうしの差と点に足し引きする `0x…` は差。どちらも Address 型で Int・UInt と混ぜない。
 * 点 ± 差は点・点 − 点は差・差 ± 差は差・点 + 点は断る。addressOp・G21）と、書いた `_` と分かる値を括りの関数の実体へ渡しても `$` は零射の番地
 * （印 zero、dollarNameTarget）。同じ日の確かめの直しで、番地の算術で作った点・差が印を落とす所（関数の答え・素の関数の口・論理と `#`・要素の
 * 形の揃わない器・括りの仮引数に直に）に入れば G21（hasAddr・refuseAddressDrop）、本体の行に隠された名前の番地の顔は使わない（shadowFace）、
 * 消えた余りのラムダの残り1項の印は持ち越す（vanishedOne））、
 * §1.2 の P1〜P3、§2 の表の「する」の行）だけである。90% 以下の所は §6.2 の
 * 門（G1〜G21（G14 は 2026-10-21、G17 と G1 は 2026-10-22、G12 は 2026-10-23、G8 と G9 は 2026-10-24 に廃止。G19 は 2026-10-24 の R51（2026-10-25 に決定）、G20 は同じ日の R53。2026-10-25 に R54〜R57 で G20 の当たる形を直し、同じ日の R58〜R61 で G19・G20 の当たる形を直した。G21 は 2026-10-26 の R62）、P2 の門）で名指しで断る。決まっていない形を黙ってどれかの読みに倒すと、後で利用者の
 * 答えが出たときに、その形が黙った誤答として残るからである。断った形は、答えが出たら試験の「断られる」側から「通る」側へ移す。
 *
 * 入り口は `resolve(source)` の1つで、`{ trees, diagnostics }` を返す。trees は1行に1つの木、diagnostics は
 * 止めない診断（information の undefined-name・pointfree-not-folded と、warning の leftover-lambda。重さは DIAG_SEVERITY の1か所）。門に当たったら OperationError を投げる（reason は §6.2 の名前、
 * spec は `…§6.2 G2(a)` のように門の番号まで、`gate` に門の番号）。
 *
 * **木の書き方（`show`）**。§1.3・§6.3 の S 式に合わせ、無い所はここで決めた。
 * - 節：`(construct a b …)`・`(compose f g …)`・`(apply h x)`・`(? [$p0 …] (apply h …))`。穴の口の足りない
 *   並び（R34）は、最後の仮引数を括りで書いて `(? [$p0 [~$p1]] (apply h (construct $p0 … $p1~)))`。実引数がアリティより多い適用は、
 *   前から n 個を当てた適用の後ろに余りを並べた構築 `(construct (apply h x1 … xn) xn+1 …)`（R35）。
 * - 左からの畳み込み（R40）で、後ろの関数が並びの項を受けた合成は、各関数が受けた物の見える入れ子の適用で書く（`f2 3 f2 5 6` は
 *   `(apply f2 (construct (apply f2 (construct 3 5)) 6))`）。後ろの関数が前の結果だけを受けた合成は前と同じ `(apply (compose f g) x)`。
 *   並びの項を全部書いた後に合成した後ろの関数も、入れ子の適用で書く（`n 1 2 inc` は `(apply inc (apply n (construct 1 2)))`。
 *   2026-10-23 までは逆適用の綴り `(apply inc (apply n (construct 1 2)) ·rev)` だった。逆適用の廃止（R47、2026-10-24）で `·rev` の綴りは
 *   無くなった。renderEntry の注）。
 * - 評価する所（定義でない行の根の並び、R42）の終わりに残った未評価のラムダは `_` になり、木では元の木を `(unit …)` で包む
 *   （`inc add 5` は `(unit (apply (compose inc add) 5))`、種類は A。`5 inc` は `(construct 5 (unit inc))`）。恒等射でなければ、
 *   warning の leftover-lambda で知らせる（R48。重さは 2026-10-24 の §5 Q44 の答えで information から上げた）。評価する所の外でも、値の上に
 *   積まれて口の開いたまま閉じた関数（何も受けない物も、受けた後の物も、穴の関数も）は同じく `(unit …)` で包み、知らせる（R52、2026-10-24。
 *   `(5 inc)` の中身は `(construct 5 (unit inc))`、`(5 add 1)` は `(construct 5 (unit (apply add 1)))`、種類は A）。左が名前1つの `:` の右辺の
 *   並びも同じ（`v : 5 inc` の右辺は `(construct 5 (unit inc))` で、v は 5。§5 Q50 の答え）。除くのは `$[…]` の中身の並びだけで、遅延した式
 *   なので書いたとおり（§5 Q52 の答え）。同じ日の R53 で中身が関数でない `$[5 inc]` は G20 になり、中身が関数なら中身の並びに余るラムダは
 *   無い。中身の項の中（`$[add (5 inc)]`・`$[x ? x inc]`）の余るラムダは、2026-10-25 の R59（§5 Q53 の答え）から G20（classifyDollar）。構築の中の
 *   `(unit …)` は値の形・要素・数に入れない（vanishedOne）。
 * - 葉は項そのもの。名前は `<>` を外した綴り、字面は書いたまま、印は核に付けて書く（`$inc`・`xs~`・`-x!`・`!_`）。
 * - 中置の項は綴りを頭にした `(+ 1 2)`。欠けた被演算子は `·`。
 * - 括りは書いたとおりに、いつも `[…]` で書く。前段は `[…]`・`(…)`・`{…}` を1つの印にまとめて種類を残さない
 *   （利用者 2026-08-05「カッコの意味って統一されているから種類を問うていない」）ので、綴りを1つにするしかない。
 *   それに S 式の `(…)` は節の印なので、括りを `(…)` で書くと節と見分けが付かない。§6.3 の `(f3 1)` は `[f3 1]` になる。
 *   括りの中の行は ` ⏎ ` でつなぎ、行末の `,`（貪欲の印）は前の語に付ける（`[* 2,]`）。括りの中は書いたとおりで、
 *   解いた木は葉の `view.inner` に持つ。絶対値は `|…|`、ノルムは `||…||`。
 * - 字下げのブロックは、解いた行を並べて `(block 行 行 …)`。書いたとおりに書く所（括りの中・`?` の左）では `{行 ⏎ 行}`。
 * - 段1〜9 の中置は `(== 左 右)`・`(, 左 右)`（`,` は右結合のまま入れ子にする）。
 * - `:` は `(: 左 右)`。左が1項なら解かない（P3）ので、その項をそのまま書く。
 * - `?` は `(? [仮引数を書いたとおり] 本体)`。`?` の左は解かない（P3）。
 * - 括りの関数（R24）は、その `?` を通って呼ばれた実体を形の綴りの順に並べて `(? [仮引数] (inst 形 本体) …)`。
 *   一度も呼ばれなければ、本体を書いたまま `(? [仮引数] (defer {本体}))`（R25。字下げの本体は行を ` ⏎ ` でつなぐ）。
 *   どの `?` を通って呼ばれたかは書いた `?` ごとに数える。同じ綴りの別の関数（`a : [say] ? say 21` と
 *   `b : [say] ? say 21`）は本体の答えを共有するが、呼ばれていない方は defer のまま（R25「一度も呼ばれない」）。
 *
 * **形の綴り**（`inst` の形。R24 の「渡された物の生まれ」を書く）。
 * - 中身の見えない A は `A`、関数は `L`、未知は `U`。
 * - 書いた空の括り `[]`（R24 では List に数えない中身の見えない A。R51 の撒いた流れでは空の流れ）は `A[]`。空と読む所があるので、`A` とは別の
 *   実体にする（2026-10-25、internDesc の注）。
 * - 関数を指す番地（`$inc`・`$[* 2]`。指す関数を印に持つ A、R49）は `$L`。裸の仮引数に渡っても `$L` と書く（印は
 *   実体の鍵に入る。`map $inc vs` と `map $double vs` は、同じ綴りの `$L [N…]` の実体が2つ並ぶ）。
 * - 数（数・文字の字面と、それに値の印や値の演算子を当てた物。長さ1の List と同型）は `N`。数の List は `[N…]`。
 *   番地の字面（`0x…`・`NxHHHH`）は数に入れず、中身の見えない A（SCALAR の注）。
 * - 構造体とも List とも読めないが中身の見える器（行の混ざった括り・同じ名前の欄が2つある構造体など）で、中身に
 *   関数か未知が見える物は `A(U)`。名前で受ければ未知、`~rest` で受ければ中身の見えたまま（撒けば §3.3 の手順1 の
 *   G7）なので、`A` とは別の実体にする。
 * - 構造体は欄を書いた順に `{say:L other:A}`。List は要素の形に `…` を付けて `[A…]`（長さは書かない。形は長さに
 *   依らないので、長さの違う同じ要素の List は同じ実体になる）。入れ子は `{greet:{hello:L} world:[A…]}`・`[[A…]…]`。
 * - 仮引数が2つ以上なら、仮引数ごとの形を空白で並べる（`A [A…]`）。裸の仮引数はいつも A なので `A`。
 * - 関数の欄は、どの関数でも `L` と書く。実体の鍵には関数の出どころ（書いた本体と、定義した所の範囲）まで入れて
 *   いるので、本体の根の違う関数が同じ実体になることはない。同じ綴りの実体が2つ並んだら、関数が違う。
 * - 綴りが SHAPE_TEXT_MAX 字を超えたら、そこで切って `⋯` を付ける（同じ物を欄どうしで共有する形は、木として書くと
 *   深さごとに倍になる）。切っても実体の鍵は切らない（鍵は canonKey の注）。
 *
 * **種類**は A（値）・L（関数）・U（未知）の3つ。畳み込みの1歩は、いちばん上の項と次の項の種類で決まる（R47）：
 * いちばん上が L で次が A なら適用（評価射）、次も L なら合成、いちばん上が A か空なら次の項を積む（次が A なら構築、零対象の
 * ある圏での標準の射 A ⊔ B → A × B。次が L でも積み、積んだ L はその後に来る項を右から受ける）。2026-10-23 までは A·L が逆適用
 * （評価射の前に対称の同型を置いたもの）だった。U はどの対にもならないので、2項以上の並びでは門で断る（根なら通す）。
 * 積んだ L から並びの終わりまでは、括った `(L …)` と同じ1つの並びなので、穴と `_` の規則（§3.3 の手順2）もそこで頭の並びとして見る
 * （subHole、2026-10-24 の確かめの直し）。
 * R51（2026-10-24 の試し、2026-10-25 に決定）：いちばん上が L で次が撒く項（`xs~`）なら、撒いた並びは流れの1項で、L のいちばん最初の閉じていない
 * 段の残りの口の数で受ける：口が2つなら左からの畳み込み（段は閉じ、結果は次の段へ）、口が1つなら書き下し（流れの頭を当てて段を閉じ、残りは
 * 後ろに積む。`[+ 1] [1 2 3]~` は `([+ 1] 1) 2 3`。試しの版は写像だった）、最後の口が可変長なら丸ごと、ほか（3つ以上・分からない・固定の口の
 * 後ろに可変長の口）は G19（streamStep・writeOut）。写像は `[f,]` だけ（R50）。木は今までどおり、撒く項を実引数に書いた `(apply L xs~)`。
 * 同じ日の確かめの直しでは、流れを受けた段の後ろに合成の段があり、合成全体の口の数がその段の口の数と違えば G19（§5 Q58）にしていた。§5 Q58 の
 * 答え（R58）から、合成は1つの関数なので、流れは合成全体の残りの口の数で受ける（2つなら合成全体の畳み込み、1つなら書き下し、3つ以上か分からなければ
 * G19。streamInto）。
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "./lexer.js";
import { OPERATOR_DICT } from "./operator_table.js";
import { OperationError } from "./errors.js";

const SPEC = "alpha1/docs/coproduct_spec.md";

// ---------------------------------------------------------------------------
// 前段
// ---------------------------------------------------------------------------

// 文法は1回だけ組み立てる。試験は何十も resolve を呼ぶので、呼ぶたびに peggy.generate すると遅い。
let parser = null;
function frontEnd(source) {
  if (!parser) {
    const dir = path.dirname(fileURLToPath(import.meta.url));
    parser = peggy.generate(fs.readFileSync(path.join(dir, "sign.pegjs"), "utf8"));
  }
  return parser.parse(preprocess(source));
}

// ---------------------------------------------------------------------------
// 門と名前の断り
// ---------------------------------------------------------------------------

const GATE_REASON = {
  // G1（coproduct-reverse-of-many）は 2026-10-22 に廃止した（§5 Q6 の答え、U〔答え〕10-21 23:23。U の時刻は UTC）。断っていた
  // 逆適用の左の構築（`1 2 inc`）は、一番近い1項だけを取って残りを前に積む（R37。2026-10-23 からは左からの畳み込みで、逆適用は
  // いちばん上の値だけを取る、R40）。2026-10-24 に逆適用そのものを廃止した（R47）：`1 2 inc` の inc は積まれて、根なら `_`。
  G2: "coproduct-partial-neighbor",
  G3: "coproduct-beside-product",
  G4: "coproduct-prefix-tilde",
  G5: "coproduct-unit-position",
  G6: "coproduct-input-position",
  G7: "coproduct-unknown-kind",
  // G8（coproduct-reverse-arity）と G9（coproduct-reverse-spread）は 2026-10-24 に廃止した（逆適用の廃止、R47。U [2026-10-23 13:12 ebf18260]
  // 「逆適用は廃止しよう」）。主語の口が決まらない逆適用（`5 f2 1`、§5 Q5）は `5 (f2 1)`、撒く項の後ろの関数（`vs~ inc`、R14）は
  // 積まれる。
  // G10（coproduct-reverse-pointfree）は 2026-10-23 に廃止した（R13 の廃止。決定の文面の `1 2 [+] 3 4` は `1 ([+] 2 3 4)`、§5 Q36）。
  G11: "coproduct-no-reading",
  // G12（coproduct-excess-neighbor）は 2026-10-23 に廃止した（左からの畳み込み、R40〜R43）。(a)（余りを積んだ値の後ろの逆適用）と
  // (c)（合成の流れの余りが並び全体を受ける関数に届く）は、畳み込みで答えが1つに決まる（`inc [+] 5 6` は `[+] (inc 5) 6`。`inc 1 2 inc`
  // は 2026-10-23 は `(inc 1) (inc 2)`、2026-10-24 の R47 から `(inc 1) 2` で inc は積まれる）。(b)（本体の根が値でない関数に実引数が
  // 多い）は、種類の未知な物がいちばん上にあるときに次の項が来る形で、G2(a) が断る。(a)・(c) の恒等射の枝（`i 1 2 inc`・`i inc 1 2`）は G18。
  G13: "coproduct-hole-arity",
  // G14（coproduct-pointfree-unit）は 2026-10-21 に廃止した。断っていた `[-_]`・`[!!_]`・`[_!]` は単項の点なし（pointfreeOf）。
  G15: "coproduct-default-unit",
  G16: "coproduct-bare-function-return",
  G18: "coproduct-identity-row",
  // G19 は 2026-10-24 の R51（試しで入れ、2026-10-25 に決定）：撒いた流れ（`xs~`）を受ける関数の残りの口が、1つ（書き下し。2026-10-24 の試しは
  // 写像）・2つ（左からの畳み込み）・最後の可変長の口（丸ごと）のどれでもない（口が3つ以上か、口の数が分からない）。口が2つでも、畳まない2項の
  // 点なし（R32）は畳まない（試しの確かめ、§5 Q49）。2026-10-25 から、口が1つの書き下しで答えが割れる所（空の流れ、§5 Q57）も。同じ日の確かめの
  // 直しから、合成に来た流れで、合成全体の口の数が流れを受けた段の口の数と違う所（§5 Q58。前は頭で閉じた段の後ろの合成の段が口2つ以上で余りを
  // 受ける所だけを §5 Q57 で断っていた）も。口が3つ以上か分からない所の言い分は §5 Q46 を名指しする。§5 Q58 の答え（R58）から、合成に来た流れは
  // 合成全体の口で受け、断るのは合成全体の口が3つ以上か分からない所と、合成全体を畳むと畳まない2項の点なしで畳む所（§5 Q49）だけ。
  G19: "coproduct-stream-arity",
  // G20 は 2026-10-24（R53）：`$` の先（名前か括りの中身。同じ日の確かめの直しから、字面・ほかの印と組んだ `$5`・`$$inc`・`$vs~` の先も）が
  // 関数でない（値か未知）。`$` は関数だけを運ぶ（U〔答え〕10-24 12:34
  // 「…だから全部の$で良いはずだ。」）。値の束縛の番地の綴りは §5 Q54。
  // 2026-10-25（R54〜R57）から、`$` の先を書いた所で1つの関数と言い切れない（U [2026-10-24 16:52 8dfc006e] の条件、classifyDollar の注）：書いた `_` は
  // 零射 `$[x ? _]` で通り（R56）、局所の定義は右辺で決め（R54）、後置の印の付いた形（`$inc~`・`$fs~`・`$inc!`）は断る（R57）。
  // 同じ日の R59・R60（§5 Q53・Q54 の答え）から、`$` の先は1つの Reader（関数か、値を読む参照）と言い切れること：値の先は通り（R60）、中身に余る関数の
  // ある `$[…]` は断る（R59）。名前の reason（coproduct-dollar-value）は試験と法則が読むので変えない。
  G20: "coproduct-dollar-value",
  // G21 は 2026-10-26（R62、§5 Q59 の答え）：番地の点と差の算術・比べで、決まっていない組か、決まって断る組。点（`$` が作った値を読む参照と、
  // それをずらした物）と差（点どうしの差）はどちらも Address 型で、点 ± 差は点・点 − 点は差・差 ± 差は差・点どうしと差どうしの比べは通る。点 + 点と、
  // Address と数（Int・UInt・文字）を混ぜた算術・比べは断る（決まって断る組）。ほかの組（差に `0x…`・点の左の `0x…`・差 + 点・点と差の比べ・顔の
  // 分からない値・書いた `_`・`*` などの演算）と、中置の外の綴り（区間・点なし・絶対値・値の印・素の関数の口）で番地を受けた形は §5 Q66。
  // 関数を指す番地（`$inc`）を動かす・比べる形は、今までどおり G7（R53 の外）。同じ日の確かめの直しから、番地の算術で作った点・差が印を落とす所に入る
  // 形（refuseAddressDrop）・点・差を中に持つ器に値の演算子を当てる形・本体の行に隠された名前の点・差（shadowFace）も G21（§5 Q66）。
  G21: "coproduct-address-arith",
  // G17（coproduct-manual-curry）は 2026-10-22 に廃止した（§5 Q35 の答え、U〔答え〕10-21 22:46。U の時刻は UTC）。断っていた `$` で包んだ入れ子の `?`（`add : x ? $[y ? x + y]`）は、
  // `$[+ m]` と同じく `$` で値にした関数を返す形で、本体の根は A で通る（R33）。
};

// 門の番号（`G2(a)` のように枝まで）から断りを作る。reason は門ごとの名前で、枝は spec と gate で見分ける。
function gate(id, message) {
  const base = id.replace(/\(.\)$/, "");
  const e = new OperationError(message, { spec: `${SPEC} §6.2 ${id}`, reason: GATE_REASON[base] });
  e.gate = id;
  return e;
}

// 余積の門か。本体の根の種類を仮に解くとき（下の bodyRootOf）は、門に当たっても止めずに「未知」にする。
// 名前の門（P2）は仮に解いても答えが変わらないので止める。
// 実体の守りの断り（guardRefusal）も門に数える。根の種類を解く所では未知にし、覚えた断りを resolve の最後に投げる。
function isGate(e) {
  return e instanceof OperationError && typeof e.reason === "string" && (e.reason.startsWith("coproduct-") || !!e.guard);
}

function nameError(reason, message) {
  const e = new OperationError(message, { spec: `${SPEC} §1.2 P2`, reason });
  e.gate = "P2";
  return e;
}

// 前段は通るが、木にできない形。余積の規則ではないので門には数えない。
function shapeError(reason, message, where = "§1.2 P1") {
  return new OperationError(message, { spec: `${SPEC} ${where}`, reason });
}

// 字下げのブロックは並びの項にならない（§2、92）。仕様は「前段が中置の右にだけ置く」ことを前提にしているが、
// 前段はブロックを閉じた後の行頭の空白の行（前の行の続き）をつなぐので、ブロックが並びの項や中置の左に来る形も
// 通す（`v :` ⏎ `→inc` ⏎ ` 5`）。前提が崩れた所でブロックを項として読むと、本体の種類（全部の行が A のときだけ A）を
// 素通りして構造体の A になり、黙って木が変わる。だから中置の右でない所のブロックは断る。
function isBareIndent(term) {
  return !!term && term.type === "atom" && term.pre.length === 0 && term.post.length === 0 && term.core.c === "indent";
}
function refuseIndentBlock(where) {
  return shapeError(
    "indent-block-position",
    `字下げのブロックが${where}にあります。ブロックは中置の右にだけ置けます（前の行の続きを書くなら、ブロックの中に書きます）。`,
    "§2"
  );
}

// ---------------------------------------------------------------------------
// P1：語を項に寄せ、中置を畳む
// ---------------------------------------------------------------------------

// 前段の語の見分け方（§1.1）。前置の印は記号の並び＋末尾 `_`、後置の印は `_`＋記号1つ。
const PREFIX_MARK = /^(###|##|#|-|~|!!|!|\$|@)_$/;
const POSTFIX_MARK = /^_[!~@]$/;
const OPERATOR_WORD = /^[!"#$%&'\-=^~|@;+:*,<>/?]+$/;
const isNameWord = (w) => typeof w === "string" && w.length > 2 && w[0] === "<" && w[w.length - 1] === ">";
const isInfixWord = (w) => typeof w === "string" && OPERATOR_WORD.test(w);

const BLOCK_TAG = { '"BRACKET_"': "bracket", '"ABS_"': "abs", '"NORM_"': "norm", '"INDENT_"': "indent" };

// 値の演算子の印（§2「A の核に前置 `-` `!` `!!`・後置 `!`」）。
const VALUE_PREFIX = new Set(["-", "!", "!!"]);

// 畳む2項の点なしの記号（R31、pointfreeOf）。算術（`^` だけ右から）・ビット・論理・比較。`<<`・`>>`・get・set・範囲・`!=`・
// `!==`・中置の `#` は畳まず、素の2引数の関数として読む（R32、§5 Q34 の答え）。
const FOLD_SYMS = new Set(["+", "-", "*", "/", "%", "^", "||", ";;", "&&", "|", "&", ";", "<", "<=", "=", ">=", ">", "=="]);
// そのうち論理（段5〜7）の物。値の演算子ではないので、Reader を受けても断らない（中置の `;`・`|`・`&` と同じ。R60 の細かい所。番地の点と差の規則 R62 も
// 当てない）。
const LOGIC_FOLD_SYMS = new Set(["|", "&", ";"]);

function makeCore(w) {
  if (Array.isArray(w)) {
    const c = BLOCK_TAG[w[0]];
    if (!c) throw shapeError("front-end-shape", `前段の囲みの印を読めません: ${JSON.stringify(w[0])}`);
    // 欠けた被演算子を許すのは括りの行だけ（P1「括りの1行が中置で始まるか終わる形」）。
    const rows = w[1].map((row) => parseRow(row, { inBracket: c === "bracket" }));
    return { c, rows, raw: w };
  }
  if (w === "_") return { c: "unit" };
  if (isNameWord(w)) return { c: "name", name: w.slice(1, -1) };
  return { c: "lit", text: w };
}

// 1行の語を、項（前置の印・核・後置の印をまとめた物）と中置の演算子の並びにする（R2：印は隣の核1つに付く）。
function tokenize(words) {
  const toks = [];
  let i = 0;
  while (i < words.length) {
    const w = words[i];
    if (isInfixWord(w)) {
      const def = (OPERATOR_DICT[w] || []).find((d) => d.position === "infix");
      if (!def) throw shapeError("operator-unknown", `\`${w}\` は中置の演算子として表にありません。`);
      if (def.removed) throw shapeError("operator-removed", `\`${w}\` は廃止されました（${def.removed}）。`);
      toks.push({ t: "op", sym: w, stage: def.precedence, assoc: def.assoc || "left" });
      i++;
      continue;
    }
    const pre = [];
    while (typeof words[i] === "string" && PREFIX_MARK.test(words[i])) pre.push(words[i++].slice(0, -1));
    if (i >= words.length) throw shapeError("front-end-shape", "前置の印の後ろに核がありません。");
    const core = makeCore(words[i++]);
    const post = [];
    while (typeof words[i] === "string" && POSTFIX_MARK.test(words[i])) post.push(words[i++].slice(1));
    toks.push({ t: "atom", term: { type: "atom", pre, core, post } });
  }
  return toks;
}

// 1行を木にする。段1〜9 は並びを切り（R1・R20）、段12〜22 は項の中へ先に畳む（P1）。段10 の前置 `~` と
// 段23〜25 の印は、前段が核に密着させて返すので、項の印として tokenize が持つ。
//
// 木：{type:'op', sym, stage, left, right}（段1〜9）か {type:'seq', terms}（余積の並び）。
// 項：{type:'atom', pre, core, post} か {type:'infix', sym, stage, left, right}。
function parseRow(words, { inBracket = false } = {}) {
  const toks = tokenize(words);
  let pos = 0;
  const peek = () => toks[pos];
  const isLow = (t) => t && t.t === "op" && t.stage <= 9;
  const isHigh = (t) => t && t.t === "op" && t.stage >= 12;

  function parseLow(minStage) {
    let left = parseSegment();
    while (isLow(peek()) && peek().stage >= minStage) {
      const op = toks[pos++];
      const right = parseLow(op.assoc === "right" ? op.stage : op.stage + 1);
      left = { type: "op", sym: op.sym, stage: op.stage, left, right };
    }
    return left;
  }
  function parseSegment() {
    const terms = [];
    while (pos < toks.length && !isLow(peek())) terms.push(parseHigh(12));
    return terms.length ? { type: "seq", terms } : null;
  }
  function parseHigh(minStage) {
    let left = null;
    if (peek() && peek().t === "atom") left = toks[pos++].term;
    while (isHigh(peek()) && peek().stage >= minStage) {
      const op = toks[pos++];
      const next = op.assoc === "right" ? op.stage : op.stage + 1;
      const right = peek() && (peek().t === "atom" || isHigh(peek())) ? parseHigh(next) : null;
      left = { type: "infix", sym: op.sym, stage: op.stage, left, right };
    }
    return left;
  }

  const tree = parseLow(1);
  const allowMissing = inBracket && words.length > 0 && (isInfixWord(words[0]) || isInfixWord(words[words.length - 1]));
  if (!allowMissing && hasMissing(tree)) {
    throw shapeError("infix-missing-operand", `中置の演算子の被演算子が欠けています（点なしは括りの中でだけ書けます）: \`${writeRow(words)}\``);
  }
  refuseMixedAssoc(tree);
  return tree;
}

function hasMissing(tree) {
  if (tree === null) return true;
  if (tree.type === "seq") return tree.terms.some(hasMissingTerm);
  return hasMissing(tree.left) || hasMissing(tree.right);
}
function hasMissingTerm(term) {
  if (term === null) return true;
  if (term.type === "infix") return hasMissingTerm(term.left) || hasMissingTerm(term.right);
  return false;
}

// 同じ段に結合の向きの違う中置が続く形（段18 の `'` は左、`@` は右）は、表の段と向きだけでは畳み方が決まらない
// （P1 は「表の段と結合の向きのとおり」としか言わない）。どちらかに倒すと黙って割れるので断る。
function refuseMixedAssoc(tree) {
  const visitTerm = (term) => {
    if (!term || term.type !== "infix") return;
    for (const child of [term.left, term.right]) {
      if (child && child.type === "infix" && child.stage === term.stage && assocOf(child.sym) !== assocOf(term.sym)) {
        throw shapeError("infix-mixed-assoc", `同じ段で結合の向きが違う中置（\`${child.sym}\` と \`${term.sym}\`）が続いています。括りで分けて書きます。`);
      }
      visitTerm(child);
    }
  };
  const visit = (t) => {
    if (!t) return;
    if (t.type === "seq") t.terms.forEach(visitTerm);
    else {
      visit(t.left);
      visit(t.right);
    }
  };
  visit(tree);
}
function assocOf(sym) {
  const def = (OPERATOR_DICT[sym] || []).find((d) => d.position === "infix");
  return (def && def.assoc) || "left";
}

// ---------------------------------------------------------------------------
// 書いたとおりの綴り（括りの葉・`?` の左）
// ---------------------------------------------------------------------------

function writeRow(words) {
  const parts = [];
  let pending = "";
  for (const w of words) {
    if (Array.isArray(w)) {
      parts.push(pending + writeBlock(w));
      pending = "";
    } else if (PREFIX_MARK.test(w)) {
      pending += w.slice(0, -1);
    } else if (POSTFIX_MARK.test(w) && parts.length) {
      parts[parts.length - 1] += w.slice(1);
    } else {
      parts.push(pending + (isNameWord(w) ? w.slice(1, -1) : w));
      pending = "";
    }
  }
  // 行末の `,` は貪欲の印なので前の語に付ける（§6.3 の `[* 2,]`・`[< 3,]`）。
  if (parts.length >= 2 && parts[parts.length - 1] === ",") {
    parts.pop();
    parts[parts.length - 1] += ",";
  }
  return parts.join(" ");
}

function writeBlock(b) {
  const inner = b[1].map(writeRow).join(" ⏎ ");
  switch (BLOCK_TAG[b[0]]) {
    case "bracket":
      return `[${inner}]`;
    case "abs":
      return `|${inner}|`;
    case "norm":
      return `||${inner}||`;
    default:
      return `{${inner}}`;
  }
}

function writeCore(core) {
  if (core.c === "name") return core.name;
  if (core.c === "lit") return core.text;
  if (core.c === "unit") return "_";
  return writeBlock(core.raw);
}

function writeTerm(term) {
  if (!term) return "";
  if (term.type === "infix") return [writeTerm(term.left), term.sym, writeTerm(term.right)].filter((s) => s !== "").join(" ");
  return term.pre.join("") + writeCore(term.core) + term.post.join("");
}

function writeTree(tree) {
  if (!tree) return "";
  if (tree.type === "seq") return tree.terms.map(writeTerm).join(" ");
  return [writeTree(tree.left), tree.sym, writeTree(tree.right)].filter((s) => s !== "").join(" ");
}

// 解かない項（`:` の左の1項）の S 式。中置は畳んであるので S 式で書く（P1 は解かない所にも当たる）。
function rawView(term) {
  if (!term) return null;
  if (term.type === "infix") return { v: "infix", sym: term.sym, left: rawView(term.left), right: rawView(term.right) };
  return { v: "atom", text: writeTerm(term) };
}

// ---------------------------------------------------------------------------
// 木の歩き方（P2 の名前集め・局所の定義・取り込みの範囲）
// ---------------------------------------------------------------------------

function bareName(term) {
  return term && term.type === "atom" && term.pre.length === 0 && term.post.length === 0 && term.core.c === "name" ? term.core.name : null;
}
function singleBareName(tree) {
  return tree && tree.type === "seq" && tree.terms.length === 1 ? bareName(tree.terms[0]) : null;
}
function isBareBlock(term, c) {
  return term && term.type === "atom" && term.pre.length === 0 && term.post.length === 0 && term.core.c === c;
}

// 仮引数の並びの中の名前（P2）。括りの仮引数の中で `:` の右に書いた物は既定値で、仮引数ではないので数えない。
// 既定値の右の名前まで数えると、`[z : inc]` の `inc` を仮引数と読み、ファイルの定義を隠すと誤って断る。
function forEachParamNameInTree(tree, cb) {
  if (!tree) return;
  if (tree.type === "seq") return tree.terms.forEach((t) => forEachParamNameInTerm(t, cb));
  forEachParamNameInTree(tree.left, cb);
  if (tree.sym !== ":") forEachParamNameInTree(tree.right, cb);
}
function forEachParamNameInTerm(term, cb) {
  if (!term) return;
  if (term.type === "infix") {
    forEachParamNameInTerm(term.left, cb);
    forEachParamNameInTerm(term.right, cb);
  } else if (term.core.c === "name") cb(term.core.name);
  else if (term.core.rows) term.core.rows.forEach((r) => forEachParamNameInTree(r, cb));
}

function forEachNameInTree(tree, cb) {
  if (!tree) return;
  if (tree.type === "seq") tree.terms.forEach((t) => forEachNameInTerm(t, cb));
  else {
    forEachNameInTree(tree.left, cb);
    forEachNameInTree(tree.right, cb);
  }
}
function forEachNameInTerm(term, cb) {
  if (!term) return;
  if (term.type === "infix") {
    forEachNameInTerm(term.left, cb);
    forEachNameInTerm(term.right, cb);
  } else if (term.core.c === "name") cb(term.core.name);
  else if (term.core.rows) term.core.rows.forEach((r) => forEachNameInTree(r, cb));
}

// 木の中の項を全部訪ねる。`?` の右（入れ子の関数の本体）は、skipLambda なら入らない。
function forEachTerm(tree, cb, { skipLambda = false } = {}) {
  const visitTree = (t) => {
    if (!t) return;
    if (t.type === "seq") t.terms.forEach(visitTerm);
    else if (t.sym === "?" && skipLambda) return;
    else {
      visitTree(t.left);
      visitTree(t.right);
    }
  };
  const visitTerm = (term) => {
    if (!term) return;
    cb(term);
    if (term.type === "infix") {
      visitTerm(term.left);
      visitTerm(term.right);
    } else if (term.core.rows) term.core.rows.forEach(visitTree);
  };
  visitTree(tree);
}

// 取り込み（後置 `@`）のある範囲か（P2）。範囲は関数の本体か、ファイルのいちばん外。
function hasImportIn(tree) {
  let found = false;
  forEachTerm(tree, (term) => {
    if (term.type === "atom" && term.post.includes("@")) found = true;
  }, { skipLambda: true });
  return found;
}

// 仮引数の並び（`?` の左）を読む。素の関数（§3.4）は、仮引数が全部裸の名前（既定値なし・前置 `~` なし・
// 括りなし）の関数である。字下げの仮引数のブロック（前段は `?` の左に1つのブロックとして返す）は1行に1つ。
function parseParams(left) {
  const names = [];
  let plain = true;
  const other = (n) => names.push({ name: n, cls: "other" });
  if (!left) return { plain: false, names };
  if (left.type !== "seq") {
    forEachParamNameInTree(left, other);
    return { plain: false, names };
  }
  if (left.terms.length === 1 && isBareBlock(left.terms[0], "indent")) {
    for (const row of left.terms[0].core.rows) {
      const n = singleBareName(row);
      if (n) names.push({ name: n, cls: "bare" });
      else if (row && row.type === "op" && row.sym === ":" && singleBareName(row.left)) {
        other(singleBareName(row.left)); // 既定値のある仮引数。既定値の右は `?` の左なので解かない（P3）
        plain = false;
      } else {
        forEachParamNameInTree(row, other);
        plain = false;
      }
    }
    return { plain: plain && names.length > 0, names };
  }
  for (const t of left.terms) {
    const n = bareName(t);
    if (n) names.push({ name: n, cls: "bare" });
    else {
      // 括りの中の名前・前置 `~` の名前は、ここでは未知。括りの関数（R24：仮引数が裸の名前と括りだけで既定値が無い）
      // なら、実体の範囲では lookup が先に仮引数の desc（渡された物の生まれ）を見て、実体の外では本体を読まない（R25）。
      // 既定値のある関数（`[x : 1] ? …`）・括りの外の前置 `~` の関数（`a ~y ? …`）は括りの関数ではないので、今までどおり
      // 定義の行で本体を読み、ここで未知にした名前は並びで G7 になる。
      forEachParamNameInTerm(t, other);
      plain = false;
    }
  }
  return { plain: plain && names.length > 0, names };
}

// 括りの関数（R24 の言葉）の仮引数の並び。括りの関数でなければ null。
// 括りの関数は、仮引数が裸の名前と括りだけで（括りが1つ以上）、既定値が無い（括りの中にも `:` が無い）関数である。
// 括りの外の前置 `~`（2026-10-04 に廃止した裸の `~xs`）や印の付いた仮引数は、R24 の言葉に入らないので今までどおり
// アリティの分からない関数（other）にする。字下げの仮引数のブロックも、行が裸の名前か既定値なので今までどおり。
//
// 返す物：[{kind:'bare', name} | {kind:'bracket', simple, names, rest, all}]。アリティは並びの長さ（括りは1つで1）。
// simple は R24 の表で読める括り（1行で、裸の名前が並び、末尾にだけ `~rest` が1つ）。それ以外の括り（入れ子の括り
// `[[a b] c]`・2行の括り・`~rest` が途中にある括り）の中の名前は、どの言葉も読み方を決めていないので、決めずに
// 未知にする（all がその名前）。未知にした名前は、並びで使えば G7 で断られるので、黙ってどれかの読みにはならない。
function patternParamsOf(left) {
  if (!left || left.type !== "seq") return null;
  if (left.terms.length === 1 && isBareBlock(left.terms[0], "indent")) return null;
  const params = [];
  let hasBracket = false;
  for (const t of left.terms) {
    const n = bareName(t);
    if (n) {
      params.push({ kind: "bare", name: n });
      continue;
    }
    if (!isBareBlock(t, "bracket") || t.core.rows.some(treeHasColon)) return null;
    hasBracket = true;
    params.push(bracketParamOf(t));
  }
  return hasBracket ? params : null;
}
function treeHasColon(tree) {
  if (!tree) return false;
  if (tree.type === "seq") return tree.terms.some(termHasColon);
  return tree.sym === ":" || treeHasColon(tree.left) || treeHasColon(tree.right);
}
function termHasColon(term) {
  if (!term) return false;
  if (term.type === "infix") return termHasColon(term.left) || termHasColon(term.right);
  return !!term.core.rows && term.core.rows.some(treeHasColon);
}
function bracketParamOf(term) {
  const all = [];
  forEachParamNameInTerm(term, (n) => all.push(n));
  const rows = term.core.rows;
  const notSimple = { kind: "bracket", simple: false, all };
  if (rows.length === 0) return { kind: "bracket", simple: true, names: [], rest: null, all };
  if (rows.length !== 1 || !rows[0] || rows[0].type !== "seq") return notSimple;
  const names = [];
  let rest = null;
  const terms = rows[0].terms;
  for (let i = 0; i < terms.length; i++) {
    const t = terms[i];
    const n = bareName(t);
    if (n) names.push(n);
    else if (i === terms.length - 1 && t.type === "atom" && t.pre.length === 1 && t.pre[0] === "~" && !t.post.length && t.core.c === "name") rest = t.core.name;
    else return notSimple;
  }
  return { kind: "bracket", simple: true, names, rest, all };
}

// 定義の右辺から `?` を取り出す。1行の括りや字下げのブロックで包んだ `?`（`f : [x ? x]`、字下げの仮引数の
// ブロックの `f :` ⏎ … ⏎ `? …`）も関数の定義に数える。包みを開かないと、名前の種類を決めるのに本体を解く
// ことになり、本体が自分の名前を呼ぶだけで輪（name-cycle）に見えてしまう。
// 片側の欠けた `?`（`[z ?]`・`[? z]`）は関数の定義ではなく `[?]` の点なしで、種類は未知（§2、Q19）。括りの外では
// 前段の後の畳み込み（P1）が欠けた被演算子を断るので、ここに来るのは括りの中の形だけである。名前を通したときだけ
// 関数と読むと、`[z ?] 5` は断るのに `ff : [z ?]` の `ff 5` は通る、という食い違いになる。
function isSection(op) {
  return !op.left || !op.right;
}
function unwrapLambda(rhs) {
  let t = rhs;
  while (t && t.type === "seq" && t.terms.length === 1) {
    const term = t.terms[0];
    if (!(isBareBlock(term, "bracket") || isBareBlock(term, "indent")) || term.core.rows.length !== 1) break;
    t = term.core.rows[0];
  }
  return t && t.type === "op" && t.sym === "?" && !isSection(t) ? t : null;
}

function asDefinition(line) {
  if (!line || line.type !== "op" || line.sym !== ":" || !line.left || line.left.type !== "seq" || line.left.terms.length !== 1) return null;
  const t = line.left.terms[0];
  // `#` は公開の印で、名前空間の話（余積の外）。定義する名前は核の名前である。
  if (t.type !== "atom" || t.core.c !== "name" || t.post.length || t.pre.length > 1 || (t.pre.length === 1 && !/^#+$/.test(t.pre[0]))) return null;
  const lambda = unwrapLambda(line.right);
  const def = { name: t.core.name, rhs: line.right, lambda };
  if (lambda) {
    const p = parseParams(lambda.left);
    def.plain = p.plain;
    def.n = p.names.length;
    def.pattern = patternParamsOf(lambda.left);
  }
  return def;
}

// P2：同じ範囲の同じ名前と、隠し（仮引数と、ファイルの定義や外の仮引数が同じ名前）を、解く前に全部見る。
function checkParamNames(lines, F) {
  const visitTree = (t, outer) => {
    if (!t) return;
    if (t.type === "seq") return t.terms.forEach((term) => visitTerm(term, outer));
    if (t.sym === "?") {
      const { names } = parseParams(t.left);
      const seen = new Set();
      for (const { name } of names) {
        if (seen.has(name)) throw nameError("name-duplicate", `仮引数 \`${name}\` が同じ関数に2つあります。`);
        seen.add(name);
        if (F.defs.has(name)) throw nameError("name-shadow", `仮引数 \`${name}\` がファイルの定義 \`${name}\` を隠します。`);
        if (outer.has(name)) throw nameError("name-shadow", `仮引数 \`${name}\` が外の関数の仮引数 \`${name}\` を隠します。`);
      }
      return visitTree(t.right, new Set([...outer, ...seen]));
    }
    visitTree(t.left, outer);
    visitTree(t.right, outer);
  };
  const visitTerm = (term, outer) => {
    if (!term) return;
    if (term.type === "infix") {
      visitTerm(term.left, outer);
      visitTerm(term.right, outer);
    } else if (term.core.rows) term.core.rows.forEach((r) => visitTree(r, outer));
  };
  for (const line of lines) visitTree(line, new Set());
}

// 関数の本体の中で `:` の左に1語で置かれた名前は、局所の定義か枝の条件か決まっていない（P2）。仮引数でも
// ファイルの定義でもなければ「種類が未知」にする。入れ子の関数の本体は、その関数の範囲で数える。
function scanLocals(tree, scope, F) {
  if (!tree) return;
  if (tree.type === "seq") return tree.terms.forEach((t) => scanLocalsTerm(t, scope, F));
  if (tree.sym === "?") return;
  if (tree.sym === ":") {
    const n = singleBareName(tree.left);
    if (n) {
      if (!paramInChain(scope, n) && !F.defs.has(n)) scope.locals.add(n);
    } else scanLocals(tree.left, scope, F);
    return scanLocals(tree.right, scope, F);
  }
  scanLocals(tree.left, scope, F);
  scanLocals(tree.right, scope, F);
}
function scanLocalsTerm(term, scope, F) {
  if (!term) return;
  if (term.type === "infix") {
    scanLocalsTerm(term.left, scope, F);
    scanLocalsTerm(term.right, scope, F);
  } else if (term.core.rows) term.core.rows.forEach((r) => scanLocals(r, scope, F));
}
function paramInChain(scope, name) {
  for (let s = scope; s; s = s.parent) if (s.params && s.params.has(name)) return true;
  return false;
}

// ---------------------------------------------------------------------------
// 種類
// ---------------------------------------------------------------------------
//
// desc：{k:'A'|'L'|'U', fn?, spread?, elements?, shape?}
//   fn（L のとき）：
//     {type:'plain', origin:'plain'|'partial'|'hole', n, getBodyRoot, idKey, rest?, restAt?}  素の関数・部分適用・穴（§3.4）。穴の
//       部分適用は 'hole' のまま（partialFn）。rest は R34 の k < n で作った穴の関数とその部分適用（holeMismatch）で、restAt は最後の
//       括り `[~c]` の前に残る裸の口の数
//     {type:'pattern', n, idKey, label, op, scopeKey, lastBracket, bareAt, instantiate}  括りの関数（R24）。n は仮引数の数
//       （括りは1つで1）。lastBracket は最後の仮引数が括りの関数（最後の括りは可変長の口で、残りの並び全体を1つの List として
//       受ける、fnShape・closeKind）。bareAt は仮引数ごとに裸か。op と scopeKey は書いた `?` と、それを解いた範囲（定義の行の木に、
//       その `?` を通って呼ばれた実体だけを描くため）
//     {type:'pattern', n, label, lastBracket, base, bound, instantiate}  括りの関数の部分適用（patternPartial）。n は残りの
//       仮引数の数、base は元の括りの関数、bound は当てた物の desc（前から）。instantiate は bound を前に足して base の
//       実体を作る。鍵は idKey ではなく base の出どころと当てた物の形（internPartial）
//     {type:'pfUnary'|'pfGreedyUnary'|'pfUnknownArity', pointfree:true}  点なし（§2、pointfreeOf の注）
//     {type:'pfFold', pointfree:true, sym}  畳む2項の点なし（`[+]`・`[&]`・`[<]` など、R31）。sym は書いた記号
//     {type:'pfBinary', pointfree:true, sym, n, root}  畳まない2項の点なし（`[<<]`・`[']`・`[!=]` など、R32）。素の2引数の
//       関数と同じに読む。n は残りの口の数（書いたままなら 2、1つ当てた足りない適用なら 1）、root は足りた適用の種類（値を
//       返す演算は 'A'、get・set は 'U'）
//     {type:'pfPick', pointfree:true, sym, key}  段18 の点なし。key は `[' 0]`・`[' say]` の鍵（R26）、ほかは null
//     {type:'compose', fns, partial}  合成（`||f||` は f の後に norm を並べた合成、R27）
//     {type:'id'}  穴 `!_` 1つ（恒等射、§3.5）。並び全体を受ける
//     {type:'norm'}  ノルム（`||f||` の合成の最後の関数。1つ受けて A、R27）
//     {type:'input'}  頭の前置 `@`
//     {type:'other', defaults?, n?}  アリティの分からない関数。既定値のある関数は defaults と仮引数の数 n を持つ（otherFn）
//   idKey：関数の出どころ（書いた `?` の綴りと、定義した所の範囲の鍵）。実体の鍵（fnKey）に使う。
//   envDepth：定義した所の範囲の、いちばん内の実体の深さ（無ければ 0）。鍵の深さ（fnDepth、実体の深さの守り）に使う。
//     pfGreedyUnary は map を持つことがある：`[F,]` の写像（R50）。map は `,` の左の、口が1つ残った関数の fn
//   ref（A のとき）：関数を指す番地の印（R49）。`$名前`（名前が関数）・`$[…]`（括りが関数）の desc は A のまま、
//     指す関数の fn を ref に持つ。`@x` の x の desc に ref があれば、`@x` は L でその fn（refOf・classify）。括りの関数の実体で裸の
//     仮引数に渡れば、仮引数の desc に持ち越し、実体の鍵に入る（bindParams・internDesc）。
//   spread：後置 `~` で撒く項。of は撒いた器の desc（R51 の書き下しと畳み込み・`[f,]` の写像が要素の desc を読む、elemsOfContainer）。elements：中身の
//     見える器の要素の種類（§2「中身が見える器」）。
//   shape（A のとき）：中身の形（R24）。{s:'struct', fields:[{name, desc}]}・{s:'list', elem}・{s:'scalar'}（数）。無ければ
//     中身の見えない A。
//     shape のある desc は、いつも elements も持つ。elements は撒く項の門（§3.3 の手順1）が見る「中身に L か未知が
//     見えるか」で、shape から読める答えと食い違わないようにする（elementsOfShape・deepKind）。

const A = () => ({ k: "A" });
const U = () => ({ k: "U" });
// 関数を指す番地の desc（R49）なら、その desc。ほかは null。
const refOf = (d) => (!!d && d.k === "A" && !d.spread && !d.shape && !!d.ref ? d : null);
// 値を読む参照（R60、2026-10-25。`$名前` の名前が値・`$[…]` の中身が値・`$5` の字面）の desc なら、その desc。ほかは null。
// 参照は値（A）で、指す値の desc を vref に持つ（`@x` の x に vref があれば、`@x` はその値。番地は読む環境の実装の1つで、意味には出ない）。
const vrefOf = (d) => (!!d && d.k === "A" && !d.spread && !d.shape && !!d.vref ? d : null);
// 番地の点と差（R62、2026-10-26。§5 Q59 の答え）のうち、算術で作った物の desc なら、その desc。ほかは null。印 addr は 'pt'（点をずらした点：
// `$x + 0x10`）か 'diff'（点どうしの差：`$foo - $bar`）。どちらも Address 型の値（A）で、Int・UInt と混ぜない。ずらした点が指す物は解決器の段では
// 分からない（差が指す物の要素の幅の倍数かと一緒に型の段で決まる）ので、指す値の印 vref は持たない（`@` で開けば G21、§5 Q66）。
const addrOf = (d) => (!!d && d.k === "A" && !d.spread && !d.shape && (d.addr === "pt" || d.addr === "diff") ? d : null);
// 番地の顔（R62）：値を読む参照（R60 の vref）とずらした点は 'pt'（点）、点どうしの差は 'diff'（差）。ほかは null。関数を指す番地（ref）は顔に数えない
// （1つの関数と言い切れる番地で、動かす・比べるのは R53 の外。G7）。
const addrFace = (d) => (vrefOf(d) ? "pt" : addrOf(d) ? d.addr : null);
// `$` が作った物（関数を指す番地か、値を読む参照）と、R62 の番地の算術で作った物（ずらした点・差）。`$` が作った物は1つの Reader（R60）で、数では
// ない。実体の鍵に入れ（裸の仮引数でも、bindParams・internPartial）、素の関数の口に渡せば札で見て（readerAtPlain）、写像では1つの要素（elemsOfContainer）。
const readerOf = (d) => refOf(d) || vrefOf(d) || addrOf(d);
// 書いた `_` を指すと分かっている値（R63、2026-10-26。§5 Q64 の答え）：欄の右辺の `_`（`[s : _]`）・`_` だけの括り（`[_]`）・書いた `_` を右辺に持つ
// ファイルの値の定義の名前（`un : _`）の desc に印 zero を付け、括りの関数の実体へ欄・要素・裸の仮引数で渡しても持ち越す（実体の鍵 `_`）。実体の中の
// `$s` は、`$_` と同じ零射 `$[x ? _]` の番地（dollarNameTarget）。印の無い形の見えない値は、今のまま `_` か言い切れない（G20）。
const zeroOf = (d) => (!!d && d.k === "A" && !d.spread && !d.shape && !!d.zero && !d.ref && !d.vref && !d.addr ? d : null);
const zeroDesc = () => ({ k: "A", zero: true });
// 番地の算術で作った点・差（R62）が、desc の中のどこか（それ自身・揃った器の要素・欄）にあるか（2026-10-26 の確かめの直し）。点・差の印を落とさずに
// 運べるのは、名前（`:` はメタ）・括り1つ（[x] ≅ x。消えた余りのラムダの残り1項も、vanishedOne）・括りの関数の実体の裸の仮引数と欄・揃った器の要素と、
// 中置の値の演算子（addressOp）だけである。印を落とす所に入ると、答えは中身の見えない値になり、数と黙って混ざる（`gi : y ? y` ⏎ `(gi ($x + 0x10)) + 1`。
// HEAD は中の算術を G7 で断っていた）。だから印を落とす所に入る所で断る（§5 Q66）：関数の答え（resolveBody。字下げの本体の局所の定義の右辺と枝の値も）・
// 素の関数の口（readerAtPlain）・論理の `;` `|` `&` と書き込み `#` の被演算子（resolveTree）・要素の形の揃わない器（mergeElems）・括りの仮引数に直に渡した物
// （bindParams）。値を読む参照（`$vs`、vref）は R60 の届かない所のまま（§5 Q66 の届かない所）。
function hasAddr(d, depth = 0) {
  if (!d || depth > 32) return false;
  if (addrOf(d)) return true;
  const sh = d.k === "A" && !d.spread ? d.shape : null;
  if (!sh) return false;
  if (sh.s === "list") return hasAddr(sh.elem, depth + 1);
  if (sh.s === "struct") return sh.fields.some((f) => hasAddr(f.desc, depth + 1));
  return false;
}
// 解いた木の値に番地の算術で作った点・差があるか（hasAddr。構築の中の消えた余りのラムダは消してから見る、descOfTree）。
const treeHasAddr = (t) => !!t && hasAddr(descOfTree(t));

// 素の関数の裸の仮引数の印（R60 の細かい所。2026-10-25 の確かめの直し。2026-10-26 の R62 から、番地の点と差を口に渡した物は G21、関数を指す番地は G7、
// §5 Q66）。素の関数は実体を作らず、本体を1回だけ、裸の仮引数を A として
// 解く（§3.4）ので、`inc $5` の本体の `x + 1` は Reader を見ない。β で `inc $5` は `$5 + 1` と同じ形なので、本体を解く所で、裸の仮引数の desc に
// 印 pv（その関数の書いた `?` と仮引数の位置の札）を付け、札に「値の演算子の被演算子に置かれた（numeric）」と「別の素の関数の口へそのまま渡された
// （edges）」を覚える。Reader を素の関数の口に渡した呼び出しは、札から値の演算子に届くなら G7（readerAtPlain）。
// - 札は関数の出どころ（書いた `?` と定義した範囲の鍵、fn.idKey）ごと・位置ごとに1つ（paramTag）。括りの関数の実体の本体に書いた無名の `?` は、実体ごとに
//   範囲の鍵が違うので別の札になる（実体ごとに本体の読みが違いうるので、札を分け合うと、先に解いた実体の答えを後の実体が使い、答えが定義の順で割れる）。
//   同じ出どころの本体を何度解いても同じ札に足す（覚えるのは「どこかで置かれた」だけ）。
// - 札は実体に持ち込まない（bindParams が外す）：実体は鍵で分け合われ、本体は1回しか解かないので、持ち込むと先に呼んだ側の札だけに覚え、
//   答えが定義の順で割れる。
// - 届かない所（決めずに残した。2026-10-26 から §5 Q66）：素の関数が返した値（`id2 : x ? x` の `id2 $5` の結果）・本体の中で器に入れた物・括りの関数や既定値のある
//   関数や前置 `@` の項の口へ渡した物・穴の関数（`f3 !_ 2`）の口。どれも、器の中身に値の演算子を当てる形（`(inc , 1) + 1` は今も A）と同じく、
//   値の演算子が直に見ない所である。2026-10-26 の確かめの直しから、番地の算術で作った点・差については、印を落とす所に入る所で断る（hasAddr の注）。
//   値を読む参照は今のまま届かない。
const PARAM_TAGS = new WeakMap();
function paramTag(op, key, i) {
  let m = PARAM_TAGS.get(op);
  if (!m) PARAM_TAGS.set(op, (m = new Map()));
  const k = `${key}#${i}`;
  let t = m.get(k);
  if (!t) m.set(k, (t = { op, i, numeric: false, edges: new Set(), fn: null }));
  return t;
}
// 値の演算子 sym の被演算子の desc d（R60 の細かい所、R62）：関数を指す番地なら G7、番地の点・差（値を読む参照・ずらした点・差）なら G21 で断り
// （中置の `+`・`-`・比べは、ここより前に addressOp が点と差の規則で読む。ここに来るのは中置の外の綴り：区間・点なし・絶対値・値の印と、R62 で
// 決めていない中置の記号は addressOp が先に断る）、素の関数の裸の仮引数（印 pv）なら札に覚える。text は断るときの被演算子の綴り（作るのは断るときだけ）。
function valueOperand(d, sym, text) {
  if (!d) return;
  if (refOf(d)) throw refuseReaderOperand(sym, text());
  // 番地の点・差と、算術で作った点・差を中に持つ器（hasAddr、2026-10-26 の確かめの直し。operandFace の box と同じ）。
  if (addrFace(d) || hasAddr(d)) throw refuseAddressSpelling(sym, text());
  if (d.pv) d.pv.numeric = true;
}
// 札 tag の仮引数が、本体から（別の素の関数の口を通っても）値の演算子の被演算子に届くか。届く先の本体がまだ解かれていなければ解く（解けなければ
// 届かないと見る。門は、その定義の行で出る）。
function numericParam(tag) {
  const seen = new Set();
  const walk = (t) => {
    if (seen.has(t)) return false;
    seen.add(t);
    if (t.fn && t.fn.getBodyRoot) {
      try {
        t.fn.getBodyRoot();
      } catch (e) {
        if (!(e instanceof OperationError)) throw e;
      }
    }
    if (t.numeric) return true;
    for (const u of t.edges) if (walk(u)) return true;
    return false;
  };
  return walk(tag);
}
// 実体に持ち込む desc から、素の関数の裸の仮引数の印を外す（paramTag の注）。器の形の要素・欄（shape）の中の印も外す（`hb [s : x]` の欄 s）。
const STRIP_MEMO = new WeakMap(); // 同じ desc を指す欄は、外した後も同じ desc を指す（hasTag の注）
function stripTag(d) {
  if (!d || typeof d !== "object" || !hasTag(d)) return d;
  const memo = STRIP_MEMO.get(d);
  if (memo) return memo;
  const { pv, ...rest } = d;
  STRIP_MEMO.set(d, rest);
  if (rest.shape) rest.shape = stripShapeTag(rest.shape);
  if (rest.vref) rest.vref = stripTag(rest.vref);
  if (rest.of) rest.of = stripTag(rest.of);
  return rest;
}
function stripShapeTag(sh) {
  if (sh.s === "struct") return { ...sh, fields: sh.fields.map((f) => ({ ...f, desc: stripTag(f.desc) })) };
  if (sh.s === "list" && sh.elem) return { ...sh, elem: stripTag(sh.elem) };
  return sh;
}
// 形は欄どうしで同じ desc を指す（`m1 : [p : m0 ⏎ q : m0]`、internDesc の注）ので、desc ごとに答えを覚える（覚えないと入れ子の深さで指数になり、
// 再帰の `f [p : r ⏎ q : r]` が止まらなかった。作る途中に見つけた）。desc は作った後に書き換えないので、覚えた答えは古くならない。
const TAG_MEMO = new WeakMap();
function hasTag(d) {
  if (!d || typeof d !== "object") return false;
  if (d.pv) return true;
  const memo = TAG_MEMO.get(d);
  if (memo !== undefined) return memo;
  TAG_MEMO.set(d, false); // 輪の守り
  const sh = d.shape;
  const out =
    (!!d.vref && hasTag(d.vref)) ||
    (!!d.of && hasTag(d.of)) ||
    (!!sh && (sh.s === "struct" ? sh.fields.some((f) => hasTag(f.desc)) : sh.s === "list" && !!sh.elem && hasTag(sh.elem)));
  TAG_MEMO.set(d, out);
  return out;
}

// ---- 形（R24・R26） ----
//
// 形は「渡された物の生まれ」を書く。構造体は、全部の行が `名前 : 値` の括りか字下げのブロック（rowsShape）。List は、
// 構築の並び・`,` の並び・2行以上の値の括りか字下げのブロック（1行が1要素、rowsShape）・文字列の字面。数（SCALAR）は
// 長さ1の List と同型。それ以外は中身の見えない A（shape なし）。
// List の要素の desc は長さに依らない（mergeElems）。長さを形に入れると、再帰で長さごとに実体ができ、`f [1 2 3]` と
// `f [1 2]` が別の実体になる（R24「同じ形なら同じ実体」に反する）。

// 器の1つの要素の、深く見た種類（elementKind と同じ答え）。A でも、中身に L か未知が見えれば U。
function deepKind(d) {
  if (!d || d.k !== "A") return d ? d.k : "U";
  if (d.elements) return d.elements.some((k) => k !== "A") ? "U" : "A";
  if (d.shape) return elementsOfShape(d.shape).some((k) => k !== "A") ? "U" : "A";
  return "A";
}
function elementsOfShape(shape) {
  if (shape.s === "scalar") return ["A"];
  if (shape.s === "struct") return shape.fields.map((f) => deepKind(f.desc));
  return shape.elem ? [deepKind(shape.elem)] : [];
}
function withShape(shape) {
  return { k: "A", shape, elements: elementsOfShape(shape) };
}

// 数（R24）：数・文字の字面と、それに値の印（`-`・`!!`・後置 `!`）や値の演算子（段13〜16・19〜22）を当てた物。前置 `!` は
// 入れない（`!_` は恒等射なので、`!x` は `_` か関数で、数にならない。classify の値の印の枝）。
// `[x]≅x` なので長さ1の List と同型で、括りで受ければ名前はその数、`~rest` は同じ要素の List（利用者 2026-10-19
// 「数や `[3]` を `[x ~xs]` に渡したら、長さ1の List（x は 3、xs は空）として分解していい？」に「それでいいはずだよ」）。
// 中身の見えない A（裸の仮引数・適用の結果・`$` の番地）は数と決まっていないので、ここに入れない：器かもしれず、
// 器なら要素に関数が見えるかもしれない。段12（`~` の範囲）は List を作るので数にしない。
// 番地の字面（`0x…`・`NxHHHH`）も入れない。R24 の数は「数・文字の字面」で、§2 の字面の行は番地を数と別に挙げ、
// 型でも番地の字面は `$` が返す値と同じ Address（type_system.md §2 の Atom 内部型）なので、指す先が器かもしれない
// のは `$` の番地と同じである。数と決めると、番地を受けた名前を黙って値と読む（数の確かめ 2026-10-19 の F1）。
// `0r`・`0b` は符号なしの数（UInt）、`0u` は文字（Char）なので数に入れる。
const SCALAR = { s: "scalar" };
const scalarDesc = () => ({ k: "A", shape: SCALAR, elements: ["A"] });
const isScalar = (d) => !!d && d.k === "A" && !d.spread && !!d.shape && d.shape.s === "scalar";
const SCALAR_INFIX_STAGES = new Set([13, 14, 15, 16, 19, 20, 21, 22]);
// 番地の字面（sign.pegjs の address と同じ形）。
const ADDRESS_LIT = /^[0-9]+x[0-9a-fA-F]+$/;

// List の要素の desc。要素の形が全部同じならそれ、全部 A だが形が違えば中身の見えない A、中身に L か未知が見え
// れば U（R24「要素に L が見えたら、名前は未知」。既存の elements が深く見て U にするので、それと揃える）。
function mergeElems(descs) {
  if (!descs.length) return null;
  if (descs.some((d) => deepKind(d) !== "A")) return U();
  const k0 = internDesc(descs[0]);
  if (descs.every((d) => internDesc(d) === k0)) return descs[0];
  // 番地の算術で作った点・差（R62）を、形の揃わない要素と並べた（2026-10-26 の確かめの直し）：要素は中身の見えない A にまとまり、`[x ~xs]` の x や
  // `' 0` で引いた物から点・差の印が落ちる（hasAddr の注）。断る側に倒した（§5 Q66）。
  if (descs.some((d) => hasAddr(d))) throw refuseAddressDrop("mixed", descs.map((d) => descText(d)).join(" "));
  return A();
}

function isSpreadNode(t) {
  return !!t && t.t === "leaf" && !!t.desc.spread;
}
function listShapeOf(items) {
  // 撒く項を含む並び（`[vs~ 4]`）の要素は、撒いた器の要素と並べた項が混ざり、要素の位置が数えられない。決めずに
  // 中身の見えない A にする（名前は未知、`~rest` は A）。
  if (items.some(isSpreadNode)) return null;
  return { s: "list", elem: mergeElems(items.map(descOfTree)) };
}
function commaItems(tree) {
  const out = [];
  let t = tree;
  while (t && t.t === "op" && t.sym === ",") {
    out.push(t.left);
    t = t.right;
  }
  out.push(t);
  return out;
}

// 構築の中の余ったラムダ `(unit …)`（R42・R48・R52）は、R15 のとおり並びの中で消える（`1 2 f2` の値は `1 2`）ので、構築の値の形・要素・
// 数には入れない。消えた後に1項だけ残れば、構築の値はその項そのもの（`(5 inc)` は `(5 _)` と同じく 5。[x] ≅ x）。構築の中に `(unit …)` が
// 入るのは、2026-10-24 の R52 までは行の根だけで、根の木の形はどこからも読まれなかった。R52 で括りの中・本体の根にも入るので、ここで消す。
// 消えた項が無ければ null（構築のまま見る）。
function vanishedOne(tree) {
  if (!tree || tree.t !== "construct" || !tree.items.some(isUnitTree)) return null;
  const live = tree.items.filter((x) => !isUnitTree(x));
  return live.length === 1 ? live[0] : null;
}
const isUnitTree = (x) => !!x && x.t === "unit";
const liveItems = (items) => items.filter((x) => !isUnitTree(x));

// 解いた木の中身の形。見えなければ null。
function shapeOfTree(tree) {
  if (!tree || tree.kind.k !== "A") return null;
  const one = vanishedOne(tree);
  if (one) return shapeOfTree(one);
  if (tree.t === "construct") return listShapeOf(liveItems(tree.items));
  if (tree.t === "op" && tree.sym === ",") return listShapeOf(commaItems(tree));
  if ((tree.t === "leaf" && tree.cat === "plain" && !tree.desc.spread) || tree.t === "apply") return tree.kind.shape || null;
  return null;
}

// 解いた木を、値として渡したときの desc（構築と `,` の並びは、ここで形と要素を付ける）。
function descOfTree(tree) {
  if (!tree) return U();
  const one = vanishedOne(tree);
  if (one) return descOfTree(one);
  if (tree.t === "construct" || (tree.t === "op" && tree.sym === ",")) {
    const d = { k: "A" };
    const sh = shapeOfTree(tree);
    if (sh) d.shape = sh;
    const el = visibleElements(tree);
    if (el) d.elements = el;
    return d;
  }
  return tree.kind;
}

// 括りか字下げのブロックを解いた行から、中身の形。構造体は、全部の行が「1語の名前 : 値」で、名前が重ならないもの
// （重なれば、どの行の欄か決まらないので中身の見えない A）。欄の desc は右辺の生まれ（R24）。欄と値の混ざった行や
// 枝の行は、構造体とも List とも言えないので中身の見えない A にする。欄の右辺が撒く項（`k : vs~`）なら、欄で受けた
// 名前が撒く項として並びに入ることになり、それはどの言葉にも無いので、構造体ごと中身の見えない A にする（listShapeOf
// の撒く項と同じ）。
// 字下げのブロックも括りと同じに読む：2行以上の値の行は List で、1行が1要素（利用者 2026-10-19「値の行を並べた字下げの
// ブロックを、括りと同じ List（1行が1要素）として受けていい？」に「それでいいよ」）。
function rowsShape(trees) {
  const isField = (t) => !!t && t.t === "op" && t.sym === ":" && !!t.fieldName;
  if (trees.every(isField)) {
    const names = trees.map((t) => t.fieldName);
    if (new Set(names).size !== names.length || trees.some((t) => isSpreadNode(t.right))) return null;
    // 欄の右辺が書いた `_`（`[s : _]`）なら、`_` を指す印 zero を付ける（R63。実体の中の `$s` が零射の番地と分かる）。
    return { s: "struct", fields: trees.map((t) => ({ name: t.fieldName, desc: isMark(t.right) ? zeroDesc() : descOfTree(t.right) })) };
  }
  if (trees.length === 1) return shapeOfTree(trees[0]);
  if (trees.some((t) => !t || (t.t === "op" && t.sym === ":"))) return null;
  return listShapeOf(trees);
}

// R26：`x ' k` の鍵。字面の整数か裸の名前だけ。裸の名前の鍵は、いつも欄の名前（R26「裸の名前の鍵は、いつも欄の名前
// である」）なので、名前として引かない（引くと、欄の名前に「定義されていません」と出る）。
function pickKeyOf(term) {
  if (!term || term.type !== "atom" || term.pre.length || term.post.length) return null;
  if (term.core.c === "name") return { name: term.core.name };
  if (term.core.c === "lit" && /^[0-9]+$/.test(term.core.text)) return { int: Number(term.core.text) };
  return null;
}
// 引いた物の desc（R26）。構造体＋裸の名前は同じ名前の欄（無ければ未知）、List＋字面の整数は要素。ほかは未知。
function pickDesc(desc, key) {
  if (!desc || desc.k !== "A" || desc.spread || !desc.shape || !key) return U();
  const sh = desc.shape;
  if (sh.s === "struct" && key.name !== undefined) {
    const f = sh.fields.find((x) => x.name === key.name);
    return f ? f.desc : U();
  }
  if (sh.s === "list" && key.int !== undefined) return sh.elem && sh.elem.k === "A" ? sh.elem : U();
  // 数（`5 ' 0`・`[' 0] 3`）からは引かない。R26 の文面は x の形を「R24 の構造体か List」と書き、R24 は数をそのどちらとも
  // 別の行に置く（数を長さ1の List として読むのは、括りで受けるときの文面）。`[x]≅x` から引けると読むかは決めていない
  // ので、未知にする（断る側、数の確かめ 2026-10-19 の F2）。数を `~rest` で受けた物は R24 の List なので、そこからは引ける。
  return U();
}

// ---- 実体の鍵と形の綴り（R24） ----
//
// 実体の鍵は「関数の出どころ・渡された物の desc」の正規の文字列。L の desc は関数の出どころ（書いた `?` の綴りと、
// 定義した所の範囲の鍵）まで入れる——本体の根が違う関数を同じ実体にすると、片方の本体の読みでもう片方を読むことに
// なる。出どころを物の同一性（何番目に見たか）ではなく綴りで持つのは、呼ぶ行と定義の行の順を入れ替えても鍵と
// 並び順が変わらないようにするため（R25：順序に依らない）。同じ綴りで同じ範囲の関数は、本体を解いた答えも同じである。

const writtenCache = new WeakMap();
function lambdaKey(op, scopeKey) {
  let s = writtenCache.get(op);
  if (s === undefined) {
    s = writeTree(op);
    writtenCache.set(op, s);
  }
  return `λ{${s}}@${scopeKey}`;
}

function fnKey(fn) {
  if (!fn) return "?";
  // 2026-10-23 までは、逆適用で主語がどの口に入ったかが決まっていない関数（印 pending、§5 Q5）と、恒等射の流れで印を付けた段
  // （idSplit）を、同じ関数と分けていた。逆適用の廃止（R47）で、どちらの印も無くなった。
  switch (fn.type) {
    case "plain":
      // R34 の k < n で作った穴の関数（rest）は、書いた `_` で G5 になり、同じアリティの穴の関数と振る舞いが分かれる（"other" の
      // 注と同じ割れ）ので、鍵に印を入れる。最後の括りの前に残る裸の口の数（restAt）でも、後から当てた物がどの口に入るかが
      // 分かれる（restCloseKind）ので、それも入れる。
      const rest = fn.rest ? (fn.restAt === undefined ? "+rest" : `+rest@${fn.restAt}`) : "";
      return `plain:${fn.origin}${rest}:${fn.n}:${fn.idKey || ""}`;
    case "pattern":
      return fn.bound ? canonKey(internPartial(fn)) : `pattern:${fn.idKey}`;
    case "compose":
      return canonKey(internCompose(fn));
    case "pfPick":
      return `pfPick:${fn.sym}:${fn.key ? JSON.stringify(fn.key) : ""}`;
    case "pfBinary":
      // 種類は残りの口の数と足りた適用の種類だけで決まる（記号に依らない）。type だけを鍵にすると、`[<<]`（A）と `[']`（未知）を
      // 括りの関数に欄で渡したときに実体を分け合い、先に解いた方の答えをもう片方が黙って使う。記号は鍵に入れないので、実体の
      // 本体から出る言い分にも記号を書かない。
      return `pfBinary:${fn.n}:${fn.root}`;
    case "pfGreedyUnary":
      // `[F,]` の写像（R50）は、写す関数の鍵を持つ。type だけを鍵にすると、`[inc,]` と `[uu,]`（根が A と未知）を括りの関数に欄で
      // 渡したときに実体を分け合う。写す関数の無い `[* 2,]` などは今までどおり type だけ（どれも同じ種類になる）。
      // 2026-10-25（R60 の細かい所、§5 Q59）から、値の演算子の印（vop）のある物とない物（`[-_,]` と `[!_,]`）は、Reader を受けたときの答え（G7 か
      // 通るか）が分かれるので、鍵に印の有無を入れる（記号は入れない。上の pfBinary と同じく、言い分にも記号を書かない）。
      return fn.map ? `pfGreedyUnary:map(${canonKey(internFn(fn.map))})` : `pfGreedyUnary${fn.vop ? ":v" : ""}`;
    case "pfUnary":
    case "pfFold":
      // 値の演算子の印の有無（上の pfGreedyUnary と同じ。`[-_]` と `[!_]`、`[+]` と `[|]`）。
      return `${fn.type}${fn.vop ? ":v" : ""}`;
    case "other":
      // 既定値のある関数は、書いた `_` で G15、`!_` で仮引数の数 n の穴（tryHole）になり、ほかのアリティの分からない関数
      // （`gx : a ~y ? a`）と振る舞いが分かれる。鍵を `other` 1つにすると、括りの関数に欄で渡したときに実体を分け合い、
      // 先に解いた方の門（G5 か G15）が、もう片方の行の言い分になった（行の順で名指しが入れ替わる）。だから印と n を入れる。
      // 既定値のある口の位置（defaultAt）でも、書いた `_` を当てたときの答え（既定値か G15、R39）が分かれるので入れる。
      return fn.defaults ? `other:d${fn.n === null ? "?" : fn.n}${fn.defaultAt ? `:${fn.defaultAt.map((b) => (b ? 1 : 0)).join("")}` : ""}` : "other";
    default:
      return fn.idKey ? `${fn.type}:${fn.idKey}` : fn.type;
  }
}

// 形は欄どうしで同じ物を指すことがある（`m1 : [p : m0 ⏎ q : m0]`、再帰の `f [p : r ⏎ q : r]`）。鍵を木として綴ると、
// 入れ子の深さ d で 2^d 個の葉を辿り、文字列も 2^d の長さになる（深さ 20 で秒、25 で文字列の長さの上限を超える）。
// だから形は2段で鍵にする。
// 1. internDesc：中身で番号に寄せる（子は番号で書くので、1つの形につき1回だけ見る）。番号が同じ ⇔ 中身が同じ。
//    ハッシュは使わない（違う形が同じ鍵になると、黙って別の実体の答えを返す）。
// 2. canonKey：番号の DAG を深さ優先で綴り、2回目に出た形は `^n`（n 番目に綴った形）で指す。綴りは中身だけで決まる
//    （番号の振り方＝形を見た順に依らない）ので、行の順を入れ替えても鍵と、鍵で決める並び順は変わらない。長さは形の
//    中の違う物の数に比例する。
// 括りの関数の部分適用の L も同じ2段で鍵にする（internPartial）。当てた物に前の部分適用が入ると（`q1 : pp [f : q0]
// [f : q0]`）、当てた物を葉の文字列に綴れば段ごとに倍になり、22 段で文字列の長さの上限を超えた（部分適用の確かめ
// 2026-10-19 の F1）。
// 合成の L も同じ（internCompose）。子の鍵を文字列でつなぐと、同じ部分適用を2つ並べた合成（`c1 : q1 q1`）を当てた
// 部分適用の鎖で段ごとに倍になり、24 段で文字列の長さの上限を超えた（反証 2026-10-19 の続き）。
// 表は resolve を呼ぶたびに作り直す（resetIntern）。
// 番号には、鍵の入れ子の深さ（depth）も持たせる（実体の深さの守り、INSTANCE_DEPTH_MARGIN の注の1）。深さは綴りだけで決まる。
let internTable = new Map(); // 中身の綴り（子は番号）→ 番号
// 番号 → {leaf} | {s:'struct', fields:[[名前, 番号]]} | {s:'list', elem:番号|null} | {s:'partial', base, bound:[番号]}
//   | {s:'compose', fns:[番号], partial}。どれも depth を持つ。
let internNodes = [];
let internByDesc = new WeakMap();
let internByShape = new WeakMap();
let internByFn = new WeakMap();
let canonMemo = new Map();
function resetIntern() {
  internTable = new Map();
  internNodes = [];
  internByDesc = new WeakMap();
  internByShape = new WeakMap();
  internByFn = new WeakMap();
  canonMemo = new Map();
  identTable = new Map([["·", NO_IDENT]]);
  identByDesc = new WeakMap();
  identByShape = new WeakMap();
  identByFn = new WeakMap();
  opSerial = new WeakMap();
  opCount = 0;
}
function internText(text, node) {
  let id = internTable.get(text);
  if (id === undefined) {
    id = internNodes.length;
    internNodes.push(node);
    internTable.set(text, id);
  }
  return id;
}
// 葉の深さは 1。関数の葉は、書いた所の範囲が実体の中なら、その実体の深さに 1 を足す（fnDepth）。綴りに範囲の鍵（＝実体の
// 鍵）が入っているので、同じ綴りの葉は同じ深さになる。
const internLeaf = (text, depth = 1) => internText(text, { leaf: text, depth });
const depthOf = (id) => internNodes[id].depth;
const maxDepth = (ids) => ids.reduce((m, c) => Math.max(m, depthOf(c)), 0);
function internDesc(d) {
  if (!d) return internLeaf("U");
  const memo = internByDesc.get(d);
  if (memo !== undefined) return memo;
  let id;
  if (d.k === "L") id = internFn(d.fn);
  else if (d.k !== "A") id = internLeaf("U");
  else if (d.spread) id = internLeaf("A~");
  // 関数を指す番地（R49）：指す関数の鍵を持つ。持たないと、`h [f : $inc]` と `h [f : $uu]`（欄の `@f` の口の数・根が違う）が
  // 実体を分け合い、先に解いた方の答えを後の方が黙って使う。深さは指す関数の深さに 1 を足す（閉包を番地で渡し続ける再帰が深さの門に届く）。
  else if (d.ref && !d.shape) {
    const f = internFn(d.ref);
    id = internText(`$#${f}`, { s: "ref", fn: f, depth: 1 + depthOf(f) });
  }
  // 値を読む参照（R60）：指す値の鍵を持つ（関数の番地と同じ理由。`h $vs 0` と `h $five 0` の実体の `@f` は、指す値の形が違う）。深さは指す値の深さに
  // 1 を足す（参照の参照を渡し続ける再帰が深さの門に届く）。
  else if (d.vref && !d.shape) {
    const v = internDesc(d.vref);
    id = internText(`$=#${v}`, { s: "vref", val: v, depth: 1 + depthOf(v) });
  }
  // 番地の算術で作った点・差（R62）：ずらした点 `$+`・差 `$-$`。中身の見えない A と別の鍵にする（同じ鍵だと、`hc [1] ($v + 0x10)` と `hc [1] 5` が実体を
  // 分け合い、本体の `f == $v` の答え（点どうしの比べか、顔の分からない値との G21 か）を先に解いた方が決める。hc は `[k] f ? f == $vs`）。
  else if (addrOf(d)) id = internLeaf(d.addr === "pt" ? "$+" : "$-$");
  // 書いた `_` を指すと分かっている値（R63）：`_`。中身の見えない A と別の鍵にする（同じ鍵だと、`h [s : _]` と `h [s : (inc 5)]` が実体を分け合い、
  // 本体の `$s` が零射の番地か G20 かを、先に解いた方が決める。§5 Q64 の影響）。
  else if (zeroOf(d)) id = internLeaf("_");
  // 書いた空の括り `[]`（`A[]`、頭の注）は、R51 の撒いた流れが空と読む（elemsOfContainer・foldableContainer）ので、中身の見えない A と別の鍵にする。
  // 同じ鍵だと、`k2 : [~t] ? inc t~` の `k2 []`（空の流れの書き下しで G19）と `k2 (tl vs)`（数の見えない流れで未知）が1つの実体を分け合い、
  // 先に作った方の答えを後の方が黙って使った（2026-10-25 の確かめの指摘。`fold $first []` ⏎ `(fold $first (tl fs)) 5` も、中身の見えない器の
  // 畳み込みを空の流れの `_` と読んで A にしていた。HEAD 41f144af から）。
  else if (isEmptyBracket(d)) id = internLeaf("A[]");
  // 中身の見えない A。中身に関数か未知が見える器（`A(U)`、頭の注）は、`~rest` の読みが違うので別の鍵にする。
  else if (!d.shape) id = internLeaf(deepKind(d) === "A" ? "A" : "A(U)");
  else id = internShape(d.shape);
  internByDesc.set(d, id);
  return id;
}
function internShape(sh) {
  const memo = internByShape.get(sh);
  if (memo !== undefined) return memo;
  let id;
  if (sh.s === "scalar") id = internLeaf("N");
  else if (sh.s === "struct") {
    const fields = sh.fields.map((f) => [f.name, internDesc(f.desc)]);
    const depth = 1 + maxDepth(fields.map(([, c]) => c));
    id = internText(`{${fields.map(([n, c]) => `${n}:#${c}`).join(" ")}}`, { s: "struct", fields, depth });
  } else {
    const elem = sh.elem ? internDesc(sh.elem) : null;
    id = internText(elem === null ? "[]" : `[#${elem}…]`, { s: "list", elem, depth: elem === null ? 1 : 1 + depthOf(elem) });
  }
  internByShape.set(sh, id);
  return id;
}
// 括りの関数の部分適用の鍵：元の関数の出どころと、当てた物の形。裸の仮引数の位置は A にする——実体の鍵（bindParams）が
// 裸の位置の形を見ないので、そこに何を当てても同じ関数である（R24「裸の仮引数の位置は、形に数えない」。素の関数の部分
// 適用の鍵が当てた物を見ないのと同じ）。数えると、同じ実体が2つ描かれ、再帰では同じ形の実体が入れ子になって G7 に
// なった（部分適用の確かめ 2026-10-19 の F2）。綴りは番号で書く（子と同じ。`(` の中は番号だけなので、後ろの出どころと
// 混ざらない）。
function internPartial(fn) {
  const memo = internByFn.get(fn);
  if (memo !== undefined) return memo;
  // 裸の位置でも、関数を指す番地（R49）は印ごと鍵に入れる（実体の鍵 bindParams と同じ）。値を読む参照・番地の点と差（R60・R62）と、書いた `_` を
  // 指す値（R63）も同じ。
  const bound = fn.bound.map((d, i) => (fn.base.bareAt[i] && !readerOf(d) && !zeroOf(d) ? internLeaf("A") : internDesc(d)));
  const depth = 1 + Math.max(fnDepth(fn.base), maxDepth(bound));
  const id = internText(`P(${bound.map((c) => `#${c}`).join(" ")})${fn.base.idKey}`, { s: "partial", base: fn.base.idKey, bound, depth });
  internByFn.set(fn, id);
  return id;
}
// 合成の鍵：中の関数の鍵を、書いた順に番号で並べる（部分適用と同じく、子は番号）。口の開いたまま残った合成（左からの畳み込みで
// 最初の関数が実引数を受けた物、R40）は、最初の関数を受けた分だけ当てた部分適用にしてあるので、当てた物はその鍵に入る（括りの
// 関数の部分適用の bound と同じ）。前の流れの足りない合成の pre（当てた物）は、2026-10-23 に無くなった。
function internCompose(fn) {
  const memo = internByFn.get(fn);
  if (memo !== undefined) return memo;
  const fns = fn.fns.map(internFn);
  const id = internText(`C(${fns.map((c) => `#${c}`).join(" ")})`, {
    s: "compose",
    fns,
    depth: 1 + maxDepth(fns),
  });
  internByFn.set(fn, id);
  return id;
}
// L の desc の関数の番号。部分適用と合成は中身で番号に寄せ、ほかは fnKey の綴りの葉（短い綴りで決まる）。
function internFn(fn) {
  if (fn && fn.type === "pattern" && fn.bound) return internPartial(fn);
  if (fn && fn.type === "compose") return internCompose(fn);
  return internLeaf(`L<${fnKey(fn)}>`, fnDepth(fn));
}
// 関数の葉の深さ：書いた所の範囲の深さ（envDepth。閉包の鍵は書いた所の範囲の鍵を持つので、その段と同じ）。ファイルの範囲の
// 関数と、範囲を鍵に持たない関数（点なし・頭の前置 `@`・アリティの分からない関数・素の関数の部分適用と穴は元の関数のまま）は 1。
function fnDepth(fn) {
  return Math.max(1, (fn && fn.envDepth) || 0);
}
// 範囲の中の、いちばん内の実体の範囲の深さ（実体の範囲は depth を持つ、instScope）。実体の中でなければ 0。
function envDepth(scope) {
  for (let s = scope; s; s = s.parent) if (s.depth !== undefined) return s.depth;
  return 0;
}
function canonKey(id) {
  const memo = canonMemo.get(id);
  if (memo !== undefined) return memo;
  const seen = new Map();
  const walk = (i) => {
    const node = internNodes[i];
    if (node.leaf !== undefined) return node.leaf;
    if (seen.has(i)) return `^${seen.get(i)}`;
    seen.set(i, seen.size);
    if (node.s === "struct") return `{${node.fields.map(([n, c]) => `${n}:${walk(c)}`).join(" ")}}`;
    if (node.s === "ref") return `$${walk(node.fn)}`;
    if (node.s === "vref") return `$=${walk(node.val)}`;
    if (node.s === "partial") return `L<pattern:${node.base}<${node.bound.map(walk).join(" ")}>>`;
    if (node.s === "compose") return `L<compose(${node.fns.map(walk).join(" ")})>`;
    return node.elem === null ? "[]" : `[${walk(node.elem)}…]`; // `[]` は要素の無い List（空の文字列の字面）
  };
  const s = walk(id);
  canonMemo.set(id, s);
  return s;
}
function descKey(d) {
  return canonKey(internDesc(d));
}

// 形の綴り（頭の注）。人が読む物なので、max 字を超えたら切って `⋯` を付ける。切った所から先は辿らないので、共有の
// 多い形でも max に比例する手間で済む。
const SHAPE_TEXT_MAX = 400;
function descText(d, max = SHAPE_TEXT_MAX) {
  let out = "";
  let cut = false;
  const put = (s) => {
    if (cut) return;
    if (out.length + s.length > max) {
      out += `${s.slice(0, Math.max(0, max - out.length))}⋯`;
      cut = true;
    } else out += s;
  };
  const walk = (x) => {
    if (cut) return;
    if (!x || x.k === "U") return put("U");
    if (x.k === "L") return put("L");
    if (x.spread) return put("A~");
    if (x.ref && !x.shape) return put("$L"); // 関数を指す番地（R49）
    if (x.vref && !x.shape) {
      put("$"); // 値を読む参照（R60）：`$` の後ろに指す値の形（`$N`・`$[N…]`・`$$L`）
      return walk(x.vref);
    }
    if (addrOf(x)) return put(x.addr === "pt" ? "$+" : "$-$"); // 番地の算術で作った点・差（R62。internDesc の注）
    if (zeroOf(x)) return put("_"); // 書いた `_` を指すと分かっている値（R63）
    if (isEmptyBracket(x)) return put("A[]"); // 書いた空の括り（internDesc の注）
    if (!x.shape) return put(deepKind(x) === "A" ? "A" : "A(U)");
    const sh = x.shape;
    if (sh.s === "scalar") return put("N");
    if (sh.s === "struct") {
      put("{");
      sh.fields.forEach((f, i) => {
        if (i) put(" ");
        put(`${f.name}:`);
        walk(f.desc);
      });
      put("}");
    } else if (!sh.elem) put("[]");
    else {
      put("[");
      walk(sh.elem);
      put("…]");
    }
  };
  walk(d);
  return out;
}

// 名前を引く（P2・R21）。仮引数・局所の定義・ファイルの定義の順に探し、無ければ未定義。実体の範囲では、仮引数の
// desc（R24 で当てた物）をそのまま返す。
function lookup(name, ctx) {
  let imported = false;
  for (let s = ctx.scope; s; s = s.parent) {
    if (s.descs && s.descs.has(name)) return s.descs.get(name);
    // 素の関数の裸の仮引数は A で、札の印 pv を付ける（paramTag の注。R60 の細かい所、§5 Q59）。
    if (s.params && s.params.has(name)) return s.params.get(name) === "bare" ? (s.plainOp ? { k: "A", pv: paramTag(s.plainOp, s.plainKey, s.paramIdx.get(name)) } : A()) : U();
    if (s.locals && s.locals.has(name)) return U();
    if (s.hasImport) imported = true;
  }
  const def = ctx.F.defs.get(name);
  if (def) return nameKindOf(ctx.F, def);
  if (imported) return U();
  reportUndefined(name, ctx);
  return A();
}

// `@名前` の名前の desc を、値の定義を解かずに覗く（R49）。仮引数・局所の名前・実体の中で渡された物
// （s.descs）・関数の定義（`?`）だけを見て、値の定義（`p : $inc` も）と取り込みの範囲の名前は null（印を読まない、今までどおり）。
// 値の定義を解かないのは、前置 `@` の名前は種類を引かない（輪に数えない、「値を含む輪」の注）という今の作りを変えないため。
// 2026-10-24 までは `$名前` もここで覗いていた。同じ日の R53 から `$名前` は値の定義の右辺も解いて種類を引き、2026-10-25 の R55 から指す関数の印も
// その種類から付ける（dollarNameTarget。別名 `p : inc` の `$p` も印を持つ）。`p : $inc` の `@p` は今のまま印を読まない（§5 Q45 の残り）。
function peekDesc(name, ctx) {
  for (let s = ctx.scope; s; s = s.parent) {
    if (s.descs && s.descs.has(name)) return s.descs.get(name);
    if (s.params && s.params.has(name)) return s.params.get(name) === "bare" ? A() : U();
    if (s.locals && s.locals.has(name)) return U();
  }
  const def = ctx.F.defs.get(name);
  return def && def.lambda ? nameKindOf(ctx.F, def) : null;
}

// 名前が `?` の定義（`f : x ? …`・`f : [x ? …]`）を直に指すか。穴の頭（R16）に置けるのは、§3.4 の素の関数（「名前の定義と
// `?` の括りがあたる」）だけである（2026-10-23 までは逆適用の右（R12「名前か `?` の括り」）も。R12 は 2026-10-24 に廃止、R47）。
// 別名（`p : inc`・`q : [inc]`）を素の関数に数えるかは仕様に書かれていないので、断る側に揃えた。別名の適用の種類（§3.4 の表）は
// 今のまま、生まれた関数で決める。
function isLambdaName(name, ctx) {
  for (let s = ctx.scope; s; s = s.parent) {
    if ((s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return false;
  }
  const def = ctx.F.defs.get(name);
  return !!(def && def.lambda);
}

// 名前がファイルの値の定義を直に指すなら、その右辺の器の数（nameKindOf が F.valueCounts に置く）。仮引数・局所の名前・実体の中で
// 渡された物（s.descs）は数えない（null）：実体は長さを書かない形で共有される（R24）。
function valueCountOf(name, ctx) {
  for (let s = ctx.scope; s; s = s.parent) {
    if ((s.descs && s.descs.has(name)) || (s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return null;
  }
  const def = ctx.F.defs.get(name);
  if (!def || def.lambda || !ctx.F.valueCounts.has(def)) return null;
  return ctx.F.valueCounts.get(def);
}
// 名前がファイルの値の定義を直に指し、その右辺が文字列（バックスラッシュの無い字面・それを括った物・その名前）なら、文字の数（nameKindOf が
// F.stringCounts に置く）。撒いた流れの数（R51 の書き下し、flowLength）だけが読む：`:` はメタなので、`st : \`abc\`` の `st~` は
// `` `abc`~ `` と同じ数（2026-10-25 の確かめの指摘。前は字面だけを数え、`uu st~` は未知・`uu \`abc\`~` は G2(a) と割れていた）。R34 の
// 最後の括りの数（valueCounts、writtenLength）には入れない：そこでは字面の文字列も数えない（入れると、名前と字面で R34 の答えが割れる）。
function stringCountOf(name, ctx) {
  for (let s = ctx.scope; s; s = s.parent) {
    if ((s.descs && s.descs.has(name)) || (s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return null;
  }
  const def = ctx.F.defs.get(name);
  if (!def || def.lambda || !ctx.F.stringCounts.has(def)) return null;
  return ctx.F.stringCounts.get(def);
}

// 種類は要らないが、名前を書いた所（`$x`・`@x` など）。未定義なら information だけ出す。
function touchName(name, ctx) {
  let imported = false;
  for (let s = ctx.scope; s; s = s.parent) {
    if ((s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return;
    if (s.hasImport) imported = true;
  }
  if (!ctx.F.defs.has(name) && !imported) reportUndefined(name, ctx);
}

// 止めない診断の重さ（§6.2 の門の表の「（情報）」「（警告）」の行）。重さはここの1か所で決め、出す所（pushDiag）は名前で引く。
// 2026-10-24 までは、どの診断も information で、出す所ごとに重さを書いていた。leftover-lambda は同じ日の §5 Q44 の答えで warning にした：
// 主の Claude「逆適用を廃止した後は、値の後ろに積まれて余る関数は、まず書き間違い（昔の逆適用の書き癖）だと思う。…warning に上げるのが
// 筋だと僕は思う。」に、U〔答え〕[2026-10-24 09:49 ebf18260]「全てその方向で良いと思う。」。warning でも断らない（止めない）のは今までどおり。
const DIAG_SEVERITY = {
  "undefined-name": "information",
  "pointfree-not-folded": "information",
  "leftover-lambda": "warning",
};
function pushDiag(ctx, reason, name, message) {
  ctx.diag.push({ severity: DIAG_SEVERITY[reason], reason, name, message });
}

function reportUndefined(name, ctx) {
  if (!ctx.diag || ctx.F.reported.has(name)) return;
  ctx.F.reported.add(name);
  pushDiag(ctx, "undefined-name", name, `\`${name}\` は定義されていません。値として読み、値は値の段で決めます（§4 R21）。`);
}

// 畳まない2項の点なし（R32）を読んだ所。「おすすめは出来ない」（U〔答え〕2026-10-21 10:52「同じに読んでいいけど、おすすめは
// 出来ないという方向で良いと思う。」）を、断らずに information で見せる（この形と文面は決定の規則、主の Claude の案。§4 R32 の
// R の所）。書いた点なし1つにつき1回（row は括りの中の行で、書いた所ごとに1つ）。
// 実体ごとに本体を読み直しても、同じ書いた所なら出し直さない。読まない本体（R25）では出さない（undefined-name と同じ）。
function reportNotFolded(row, sym, ctx) {
  if (!ctx.diag || ctx.F.reportedPf.has(row)) return;
  ctx.F.reportedPf.add(row);
  pushDiag(ctx, "pointfree-not-folded", `[${sym}]`, `\`[${sym}]\` は畳めない2項の点なしなので、素の2引数の関数として読みました。おすすめはしません（§4 R32、§5 Q34）。`);
}

// ---- 仮置きの記録（§3.4「再帰は、A と仮置きして一巡し、食い違えばその関数を未知にし、外れた仮置きに頼った答えは確定した値で解き直す」） ----
//
// 種類（素の関数の本体の根・値の定義の種類・括りの関数の実体の本体の根・無名の素の関数の本体の根）は、定義どうしの依りの
// 上の不動点である。本体の根を解いている途中の関数をもう一度引いたら、A と仮置きして返す。その関数の本体の根が A でなければ、
// 仮置きが外れたので、その関数は未知（§3.4）。仮置きを使って出した答え（途中の関数より上で解いた本体の根や、値の定義の
// 種類）は、仮置きが当たったと分かるまで「仮の答え」として覚える。外れたら、その答えに古い（stale）と印を付け、次に読まれた
// ときに、確定した値で解き直す（freshMemo・collectedRoot）。そうしないと、外れた仮置きの上に立った答えが黙って残る。
//
// 前は、外れた仮置きに頼った答えを全部未知に替えていた。依り（deps）は、解いている途中の関数を引いた所より上の枠の全部に
// 付く（根に使ったかは見ない）ので、根に使っていない本体（`g : y ? (f 1 y) , 1`。根は積）まで未知になり、f と g のどちらを
// 先に解くかで g の根が割れた（§5 Q28。f が先なら `g 5 inc` は G2(a)、g が先なら A）。解き直すなら、依りが広くても、
// 増えるのは解き直しの手間だけで、答えは変わらない（利用者 2026-10-20「コンパイルの時間を早めたければ、定義の順序を
// 見直せとも言えるね！」）。依りを根に使った物だけに狭める（Q28 の案(1)）必要は無い。
//
// 印を付けるのは3つの所である。どれが欠けても、外れた仮置きの上に立った答えが残り、定義の順で答えが割れる。
// 1. 外れた枠の名簿（tentatives）にある答え（finishFrame）。
// 2. 当たった枠の名簿にある答えは、その枠が頼った仮置き（枠の deps）を引き継ぐ（finishFrame）。枠が当たったと言えるのは、
//    その枠が頼った下の仮置きも当たったときだけだからである。前は引き継がず、O・M・N の順に枠が積まれ、N が M の仮置きを、
//    M が O の仮置きを使い、M が A で閉じた後で O が外れると、N の答えが古いまま残った（確かめ 2026-10-20 の F1：
//    `h : x ? ⏎ ⇥f x ⏎ ⇥inc`・`f : x ? ⏎ ⇥g x ⏎ ⇥h x`・`g : x ? f x` は、h を f・g より先に置くと `g 5 inc` が A、ほかの並べ方は
//    G2(a)。A の側は黙った誤答。HEAD からある）。
// 3. 例外（門ではない例外。名前の輪など）で抜けた枠の名簿にある答え（abortFrame）。仮置きが当たったか確かめられないから
//    である。前は付けず、namesPattern が輪を握りつぶす道で、仮置きの上で A と出した関数の答えが残った（確かめ 2026-10-20 の
//    Q28V-3：`k : x ? h x` の h が未知なのに、w を v より先に置くと `k 5 inc` が A。HEAD からある）。輪の依りを持つ記録は、
//    根の答えが未知でも印を付ける（「値を含む輪」の注の、例外で抜けた枠）。
//
// 根の答えが未知なら、印を付けず、依りも持たせない（entryOf）。未知はいちばん下で、下の「単調」により、確定した値で解き
// 直しても未知のままだからである。前は未知の答えにも印を付けていたので、解き直しの中で外の枠がまた仮置きされて外れ直し、
// 同じ記録の解き直しが関数の数の指数で増えた（確かめ 2026-10-20 の Q28V-1・F3：f1〜f5 が後ろの f と g を呼び、g が積で
// f1〜f5 を呼ぶ形で、g の解き直しが 31 回。関数 16 個で 65535 回）。値の定義の種類は A・L・U と中身の形を持つので、根と
// 同じ「いちばん下」は言わず、いつも解き直す（値の定義は仮置きされないので、解き直しても外れは増えない）。値を含む輪を
// 断るようにした（§5 Q30、「値を含む輪」の注）後は、値の定義が仮置きを読めば断るので、値の定義の記録は仮置きに頼らず、
// 古くならない（この道は守りとして残す）。
//
// 答えが定義の順に依らない理由（P2「順序には依らない」）：根の種類で答えに効くのは「A か、A でないか」だけ（doneKind・
// instantiate）で、§3.4 の表の行は、引いた根が A のときだけ A を返し、A でなければ未知か門（門に当たった本体の根は未知）に
// する。だから引いた根が A から A でないへ下がっても、どの本体の根も上がらない（単調）。仮置きは A（上）から始め、外れたら
// 確定した値（A でない）で解き直すので、各関数の値は A から一度だけ下がる。下げるのは、上の仮置き（どれも本当の値より
// 下がっていない）のもとでも A にならないと分かった時だけなので、確定した値は、いちばん大きい不動点の値より下がらない。
// 外れた仮置きに頼った答えは、上の3つの印で全部解き直すので、着いた所は不動点である。だから、どの順に解いても、いちばん
// 大きい不動点に着く。解き直しの手間だけが順に依る。
// この理屈は、門が本体と前提の値だけで決まることを使っている。実体の深さの守りは、作る実体の鍵（渡された形）だけで決まる
// 普通の門なので、この理屈の中にある。実体の総数の守りは、確定した実体（最後の木の実体）だけを数えるので、断るかは
// 最後の木だけで決まる。理屈の外に残るのは、止まるための上限（作った実体の全部）だけである（INSTANCE_DEPTH_MARGIN の注、
// §5 Q25）。
//
// 解き直しの手間：外れた記録は未知に下がり、二度と枠を積まないので、各記録の仮置きが外れるのは一度だけである。印は外れか
// 例外のたびにしか付かないので、同じ記録の解き直しは、それまでの外れと例外の数を超えない（外れは記録の数まで）。上の
// Q28V-1 の形は、g の解き直しが関数の数（5 回）で済む。単調でない所（未知を受けると A になる所）があっても、未知の根は
// 解き直さないので、根が上がって振動することは無い（確かめ 2026-10-20 では、単調でない所は見つかっていない）。

// 同じ記録の解き直しの守り（実装の守り。値は言語の規則ではない）。上の「解き直しの手間」により、同じ記録の解き直しは、
// 外れの数（枠を積んだ鍵の数 F.frameKeys まで）と例外の数の和を超えない。例外は名前の輪のような止まる誤りで、続くのは
// namesPattern が握りつぶす所だけなので、鍵の数を超えて解き直すのは、例外が繰り返したか、上の理屈が破れたときである。
// そのときは読みを決めずに、名指しして断る（未知に固定して黙って進めると、断る側でも言い分が別の門になり、理由が見えない）。
// 前は 16 回で未知に固定していたが、未知の答えにも印を付けて解き直しが指数で増えたので、関数5つの普通のプログラムが上限を
// 踏み、定義の順で割れた（確かめ 2026-10-20 の Q28V-1・F2）。
function guardAgain(F, count, label) {
  if (count <= F.frameKeys.size) return;
  const e = new OperationError(
    `${label} の種類を、仮置きが外れたので ${count} 回解き直しました（枠を積んだ記録の数 ${F.frameKeys.size} を超えました）。解き直しが終わるかを決めないので、読みを決めません（§3.4）。`,
    { spec: `${SPEC} §3.4`, reason: "resolve-again-limit" }
  );
  F.againRefused = F.againRefused || e; // namesPattern が握りつぶしても、resolve の最後に断る
  throw e;
}
function recordLabel(F, key) {
  if (key.isInst) return `括りの関数 \`${key.label}\` の実体（形 ${key.shapeText}）`;
  const fn = F.namedLambdas.get(key);
  if (fn) return `関数 \`${fn.name}\``;
  return F.defs.get(key.name) === key ? `定義 \`${key.name}\`` : "名前の無い関数";
}

// 枠：deps は仮置きの依り、cyc は輪の依り（「値を含む輪」の注。読んだ途中の枠から、そこまでの道筋への表）、tentatives・
// cycEntries はそれぞれを持つ記録の名簿。
function pushFrame(F, key) {
  const frame = { key, deps: new Set(), cyc: new Map(), cycEntries: [], consulted: false, failed: false, tentatives: [] };
  F.stack.push(frame);
  F.inProgress.set(key, frame);
  F.frameKeys.add(key);
  return frame;
}
function popFrame(F, frame) {
  const i = F.stack.lastIndexOf(frame);
  if (i >= 0) F.stack.splice(i, 1);
  F.inProgress.delete(frame.key);
}
// 例外で抜けた枠（「仮置きの記録」の注の3）。この枠を輪の依りに持つ記録は、未知でも古いと印を付ける（「値を含む輪」の注の、
// 例外で抜けた枠）。
function abortFrame(F, frame) {
  popFrame(F, frame);
  for (const t of frame.cycEntries) {
    if (!t.cyc.has(frame)) continue;
    t.cyc.delete(frame);
    t.stale = true;
  }
  for (const t of frame.tentatives) {
    t.deps.delete(frame);
    if (t.value !== "U") t.stale = true;
  }
  // この枠に頼って作った実体は、外れたのと同じに扱う（INSTANCE_DEPTH_MARGIN の注の3）。
  if (frame.pendingCalls) settlePending(F, frame, true, []);
  if (frame.tainted) taint(F); // 汚れは、抜けた先の計算に移る（refusalOf）
}
// 守りの断りの汚れ（INSTANCE_DEPTH_MARGIN の注の5、refusalOf）。守りに当たった所は門として未知になり、当たった `?` の新しい実体は
// 作らないので、それを捕まえた枠の答えと、その答えを読んだ計算は、守りが無いときの答えと違いうる。汚れた計算で出た門と値を
// 含む輪は、作り物かもしれないので、守りの断りより後に言う。汚れた計算の呼び出しは、確定した実体に数えない（noteCall）。
// いまの計算に汚れを付ける：解いている途中の枠か、枠が空なら、いま解いている行。
function taint(F) {
  if (F.stack.length) F.stack[F.stack.length - 1].tainted = true;
  else F.lineTainted = true;
}
const taintedNow = (F) => F.lineTainted || F.stack.some((f) => f.tainted);
// 解いている途中の枠 target の仮置きを読む。via は、記録を通して読んだときの、その記録から target までの道筋（一歩の
// 綴りの配列を返す関数。言い分を作るときだけ呼ぶ）。
// target より上に値の定義の枠があれば、仮置きで閉じずに断る（「値を含む輪」の注）。
function consult(F, target, via) {
  const i = F.stack.indexOf(target);
  if (i >= 0) for (let j = i + 1; j < F.stack.length; j++) if (F.stack[j].isValue) throw cycleError(F, i, via);
  target.consulted = true;
  if (i < 0) return;
  addCycle(F, i, target, via, true);
}
// 記録の輪の依りにある、解いている途中の枠 target を通る（「値を含む輪」の注の輪の依り）。consult と同じく、target より上に
// 値の定義の枠があれば断るが、仮置きの依りには入れない（解き直しは今までどおり）。
function passThrough(F, target, via) {
  const i = F.stack.indexOf(target);
  if (i < 0) return;
  for (let j = i + 1; j < F.stack.length; j++) if (F.stack[j].isValue) throw cycleError(F, i, via);
  addCycle(F, i, target, via, false);
}
// target（枠の並びの i）より上の枠と無名の関数の本体に、target への依りを足す。輪の依りには、そこから target までの道筋
// （上の一歩と via）も覚える（言い分の道筋。記録を通して見つけた輪でも、記録の中の段を抜かさない）。
function addCycle(F, i, target, via, tentative) {
  const chain = chainFrom(F, i);
  for (let at = 1; at < chain.length; at++) {
    const s = chain[at];
    if (tentative) s.deps.add(target);
    if (!s.cyc.has(target)) s.cyc.set(target, () => [...chain.slice(at + 1).map((u) => stepText(F, u)), ...(via ? via() : [])]);
  }
}
// 枠の並びの i から上の一歩：枠と、その間で解いている無名の素の関数の本体（beginCollect。枠を積まない）を、呼んだ順に。
function chainFrom(F, i) {
  const inner = F.collectors.filter((c) => c.start > i);
  const chain = [];
  for (let j = i; j < F.stack.length; j++) {
    chain.push(F.stack[j]);
    for (const c of inner) if (c.start === j + 1) chain.push(c);
  }
  return chain;
}

// ---- 値を含む輪（§5 Q30） ----
//
// 値の定義の種類を解いている途中に、その外側（枠の並びで下）で解いている途中の枠を仮置きで読んだら（consult）、輪に値の
// 定義が入っている。外側の枠の計算から値の定義へ入ったのだから外側はこの値に頼り、この値は外側を読んだのだから外側に
// 頼るからである。だから仮置きで閉じずに、名前の輪（name-cycle）で断る。値の定義から入った輪（nameKindOf の「解いている
// 途中」）と同じ断りで、どこから入っても同じ答えになる。
// 前は、値の定義から入れば断り、関数から入れば仮置きで閉じていた。`a : f 1`・`v : f 1`・`f : x ? v` は、v が先なら
// name-cycle、a が先なら f の仮置きで輪が閉じて、v が自分に頼っているのが見えず、黙って通った（§5 Q30）。v = f 1 = v で、
// 値はいつまでもできない（主の Claude「本当の欠陥は a が先だと通ってしまうほう」、利用者 2026-10-20「明らかにそうだと思う」）。
// 解決器の役目は、意味を決めることではなく、書いた人が見落とした輪（長い輪）を、入口に依らずに必ず見つけて、輪の道筋を
// 名指しすることである（利用者 2026-10-20「エンジニアかAIなら、書いていて気付くと思うし、それに気づきやすい言語だと
// 思ってるんだ」）。だから言い分に、輪に入っている枠を並べて書く（cycleError）。
// 輪に値の定義が無い物（関数どうしの再帰・括りの関数の実体の輪）は、今までどおり A と仮置きして閉じる（§3.4）。`$` で
// 遅らせた名前（`f : x ? x , $v`）は種類を引かない（touchName。前置 `@`・前置 `~` の名前も同じ）ので、輪に数えなかった。
// 2026-10-24 の R53（`$` は関数だけを運ぶ）から、`$v` は v が関数かを見るために v の種類を引く（classify の lookup）ので、輪に数える：
// `v : f 1`・`f : x ? x , $v` は、どの並べ方でも name-cycle（前は通った。v は積の A）。解いている途中の v を G20 で切ると、v から解き
// 始めれば G20、v を呼ぶ別の値（`a : f 1`）から解き始めれば輪になって、入口で門が割れる。前置 `@`・前置 `~` の名前は今のまま引かない。
// 名前が括りの関数かを覗く所（namesPattern。既定値と1項の `:` の左は解かない（P3）ので、G7 を探すためだけに名前の種類を
// 引く）のうち、既定値を覗いた所を通る輪は輪に数えない（値はできる。namesPattern の注）。
// 値の定義の記録は、これで仮置きに頼らない（仮置きを読めば断るので、記録の依りは空のまま）。だから値の定義の記録が古く
// なることも無い（freshMemo の値の定義の道は、守りとして残す）。
//
// 輪の依り（cyc）。仮置きの依り（deps）は解き直しのための物で、根の答えが未知の記録には持たせない（entryOf。未知は解き
// 直さない）。だが輪を見つけるには、未知の記録も、計算の途中で読んだ解いている途中の枠を覚えていなければならない。覚えないと、
// 輪を値の定義の無い所で先に閉じ、閉じた関数の答えが未知だったとき、後で値の定義がその記録を読んでも、解いている途中の外の
// 枠を通ったことが見えない（`a : g 1`・`g : x ? ⏎ ⇥k x ⏎ ⇥vk`・`k : x ? ⏎ ⇥g x ⏎ ⇥k x ⏎ ⇥inc`・`vk : k 1` は、vk が先なら
// name-cycle、a が先なら k が未知で閉じて黙って通った。上の規則だけでは直らず、HEAD からある。2026-10-20 の確かめで、生成器の
// 4 万本のうち 9 本が、上の規則だけでは入口で割れた。1本は通る並べ方があった）。
// だから記録は、仮置きの依りとは別に、輪の依り（計算の途中で読んだ、解いている途中の枠。仮置きの依りを含む）を持ち、読む
// ときに通る（passThrough）。輪の依りは、値の定義の枠より下の枠を通れば断るためだけに使い、仮置きの依りには入れない。古い
// という印（stale）に使うのは、下の「例外で抜けた枠」だけで、そこでも未知を未知に解き直すだけである。だから断らないプログラム
// の答えは、輪の依りを足す前と同じである。閉じた枠の輪の依りは、その枠を
// 読んだ記録が引き継ぐ（finishFrame。「仮置きの記録」の注の2と同じ理由：記録 → 閉じた枠 → その枠が読んだ途中の枠）。
// 輪の依りは、途中の枠までの道筋も覚える（addCycle・finishFrame）。記録を通して見つけた輪の言い分に、記録の中の段（記録が
// 閉じる前に通った枠と、引き継いだ枠）を書くためである。前は記録の持ち主の1歩しか書かず、入口で言い分が替わり、無い辺を
// 名指しした（確かめ 2026-10-20 の Q30-V2：`a : g 1`・`g : x ? ⏎ ⇥m x ⏎ ⇥vk`・`m : x ? k x`・`k : x ? g x`・`vk : m 1` は、
// a が先なら「`vk` → `m` の本体 → `g` の本体」で、m の本体は g を引かない）。
//
// 例外で抜けた枠（abortFrame）。例外で抜けた枠は閉じないので、その枠を輪の依りに持つ記録へ、その枠が読んだ途中の枠を
// 引き継がない。未知の記録は古いと印を付けない（「仮置きの記録」の注）ので、そのままだと、輪の依りの欠けた記録が残る。
// 今それが起きるのは、namesPattern が例外（既定値を覗いた所を通る名前の輪と、名前の輪でない止まる誤り）を握りつぶすとき
// だけである（覗いた定義から上の枠が抜ける）。
// `a : g 1`・`g : x ? [[y : v 2] ? 5] x`・`v : h 1`・`h : x ? ⏎ ⇥k x ⏎ ⇥g x ⏎ ⇥vk ⏎ ⇥inc`・`k : x ? ⏎ ⇥h x ⏎ ⇥inc`・`vk : k 1` は、
// a が先なら、覗いた v の中で k が h を読んで未知で閉じ、h の行 `g x` が覗いた所を通る輪で抜ける。後で vk が k の記録を読んでも
// h を通ったことが見えず、vk → k → h → vk の輪が黙って抜けた（7 文の並べ方 5040 のうち 1680）。だから、例外で抜けた枠を
// 輪の依りに持つ記録には、未知でも古いと印を付け、次に読まれたときに解き直す。未知の記録を解き直しても、「仮置きの記録」の
// 注の「単調」により未知のままなので、答えは変わらない（変わるのは、輪を見つけるかだけ）。
//
// 残る割れ（§5 Q30 の未決、HEAD から）：輪を閉じる道が、仮置きの上でだけ通る形。`pb : [y ~ys] ? y + 1`・`g : x ? ⏎ ⇥pb [k x]
// ⏎ ⇥ek`・`k : x ? pb [g x]`・`ek : k 1`・`pf : g 1` は、ek が先なら k の仮置き（A）の上で g の本体が行 `ek` まで進んで
// name-cycle、pf が先なら確定した k（未知）で g の本体が1行目の G7 に当たり、行 `ek` を読まないので輪が無い。どちらも断る
// （黙った誤答ではない）が、言い分が入口で割れる。確定した値の上では輪が無いので、輪を見つけた道が仮置きに頼ったかまで見て
// 断りを遅らせるか、書いた名前だけで輪を見るか（`$` の無い名前。呼ばれない関数の値を欄に入れた `v : [s : p]` まで断る）は、
// 決めていない。

// 輪の言い分。輪は枠の並びの i から上の全部（i の計算が上の枠を順に呼び、いちばん上が i を読んだ）で、via があれば
// その記録（記録の持ち主と、記録が覚えた道筋）を通して i へ戻る。無名の素の関数の本体（枠を積まずに解く、collectedRoot）も、その間に挟む。書き始めは、輪の
// 中の値の定義のうち、ファイルに先に書いた物にする（同じ輪なら、どこから入っても言い分が替わらない）。
// 言い分を作ったら覚え（F.cycleRefused）、握りつぶされても resolve の最後に断る（guardAgain の againRefused と同じ作り）。
function cycleError(F, i, via) {
  const steps = chainFrom(F, i).map((s) => ({ text: stepText(F, s), def: s.isValue ? s.key : null }));
  if (via) for (const text of via()) steps.push({ text, def: null });
  let at = steps.findIndex((s) => s.def);
  for (const d of F.defs.values()) {
    const k = steps.findIndex((s) => s.def === d);
    if (k >= 0) {
      at = k;
      break;
    }
  }
  const ring = [...steps.slice(at), ...steps.slice(0, at)];
  const path = [...ring, ring[0]].map((s) => s.text).join(" → ");
  const e = nameError(
    "name-cycle",
    `定義 \`${ring[0].def.name}\` の種類が、並びを通して自分の種類に依っています（輪：${path}）。輪に値の定義があるので、その値はいつまでもできません（§5 Q30）。`
  );
  e.cycle = ring.map((s) => s.text);
  e.cycleFrom = i; // 輪のいちばん下の枠（namesPattern が、覗いた所を通る輪かを見る）
  // 汚れた計算（守りの断りを捕まえた答えを読んだ所）で見つけた輪は、作り物かもしれない（taint、refusalOf）。汚れていない輪を先に覚える。
  e.suspect = taintedNow(F);
  if (!F.cycleRefused || (F.cycleRefused.suspect && !e.suspect)) F.cycleRefused = e;
  return e;
}
// 輪の道筋の一歩（枠の持ち主か、枠を積まない無名の素の関数の本体）。
function stepText(F, frame) {
  if (!frame.key) return frame.label || "名前の無い関数の本体";
  const k = frame.key;
  if (frame.isValue) return `\`${k.name}\``;
  if (k.isInst) return `\`${frame.label || k.label}\` を形 ${cutShape(k.shapeText)} で呼んだ実体の本体`;
  const fn = F.namedLambdas.get(k);
  if (fn) return `\`${fn.name}\` の本体`;
  return k.label || "名前の無い関数の本体";
}
function cutShape(text) {
  return text.length > 60 ? `${text.slice(0, 60)}…` : text;
}

// 無名の素の関数（`[w ? f [1 2]]`）の本体の根。名前の無い関数は自分を引けないので枠（pushFrame）は積まないが、本体を
// 解いている間に引いた仮置き（解いている途中の外の関数）は覚える（collector）。根は閉包で関数の desc に乗り、欄として
// 別の括りの関数の実体へ渡る。仮置きを覚えずに `() => root` で持つと、仮置きが外れても根が古いまま残り、それを読んだ
// 実体の答え（instMemo）も古いまま残る。行の順で、同じ関数が通ったり G7 になったりした（確かめ 2026-10-19 の A-F1）。
// 覚えた仮置きは名前つきの関数の根（bodyRootOf）と同じく記録に載せ、読むたびに consult する（readMemo）。
// 名前が無いので記録の地図（bodyMemo）には載らない。だから記録は閉包が持ち、本体を同じ範囲で解き直す手段（again）も持つ。
// 仮置きが外れて古くなったら、読まれたときに枠を積んで解き直す（bodyRootOf と同じく根だけ。枠を積むので F.stack は空に
// ならず、実体の木（materialize）も呼んだ記録（recordCall）も作らない。門に当たれば未知）。解き直している途中に、ほかの
// 関数の本体（欄で受けた実体など）を通ってまた読まれたら、bodyRootOf と同じく A と仮置きする（§3.4。枠を積み直すと、
// 同じ鍵の枠が2つ積まれ、内の枠を閉じたときに外の枠が解いている途中の印から消える）。
// label は輪の道筋に書く一歩（cycleError。無名の関数は書いた所で名指しする）。
function beginCollect(F, label) {
  const c = { start: F.stack.length, deps: new Set(), cyc: new Map(), label };
  F.collectors.push(c);
  return c;
}
function endCollect(F, c) {
  const i = F.collectors.lastIndexOf(c);
  if (i >= 0) F.collectors.splice(i, 1);
}
function collectedRoot(F, c, value, again) {
  const live = (d) => F.stack.includes(d);
  const cell = { entry: entryOf(value, [...c.deps].filter(live), [...c.cyc].filter(([d]) => live(d))), count: 0, label: c.label };
  for (const d of cell.entry.deps) d.tentatives.push(cell.entry);
  for (const d of cell.entry.cyc.keys()) d.cycEntries.push(cell.entry);
  const memo = { set: (_, entry) => (cell.entry = entry) };
  // 解き直しで本体が門に当たったら、読んだ側の枠の後ろは最後の木の道に無い（木では、書いた所で本体が門に当たる。
  // INSTANCE_DEPTH_MARGIN の注の2。instantiate の、門に当たる実体を呼んだ所と同じ）。
  const gate = (root) => {
    if (cell.gated && F.stack.length) F.stack[F.stack.length - 1].gated = true;
    return root;
  };
  return () => {
    const running = F.inProgress.get(cell);
    if (running) {
      consult(F, running);
      return "A";
    }
    if (!cell.entry.stale) return gate(readMemo(F, cell.entry, () => cell.label));
    guardAgain(F, ++cell.count, "名前の無い関数");
    const frame = pushFrame(F, cell);
    let root;
    let gated = false;
    try {
      root = again();
    } catch (e) {
      if (!isGate(e)) {
        abortFrame(F, frame);
        throw e;
      }
      root = "U";
      gated = true;
      if (e.guard) frame.tainted = true; // 守りの断りを捕まえた（汚れ、refusalOf）
    }
    cell.gated = gated || !!frame.gated;
    finishFrame(F, frame, memo, root);
    return gate(root);
  };
}
// owner は記録の持ち主（輪の道筋に書く一歩を返す関数）。記録から途中の枠までの道筋は、持ち主の一歩と、記録が覚えた道筋。
function readMemo(F, entry, owner) {
  const via = (d) => () => [owner(), ...(entry.cyc.has(d) ? entry.cyc.get(d)() : [])];
  for (const d of entry.deps) consult(F, d, via(d));
  for (const d of entry.cyc.keys()) if (!entry.deps.has(d)) passThrough(F, d, via(d));
  if (entry.tainted) taint(F); // 汚れた記録を読んだ（taint）
  return entry.value;
}
// 記録を引く。古ければ記録を消して null を返し、呼んだ側が解き直す（そのときには、外れた仮置きの関数の記録は確定して
// いる）。解き直しの回数は guardAgain が見る。
function freshMemo(F, memo, key) {
  const entry = memo.get(key);
  if (!entry || !entry.stale) return entry || null;
  memo.delete(key);
  const n = (F.againCounts.get(key) || 0) + 1;
  F.againCounts.set(key, n);
  guardAgain(F, n, recordLabel(F, key));
  return null;
}
// 記録。根の答えが未知なら依りを持たせない（「仮置きの記録」の注：未知は解き直さない。読んだ側にも依りを渡さない）。
// 輪の依り（cyc、「値を含む輪」の注）は、未知でも持たせる。
// cyc は [途中の枠, そこまでの道筋] の並び。
function entryOf(value, deps, cyc) {
  return { value, deps: new Set(value === "U" ? [] : deps), cyc: new Map(cyc) };
}
// 枠を閉じて記録に載せる（「仮置きの記録」の注の1・2）。この枠の仮置きが外れたら（failed）、それに頼った答えに古いと印を
// 付ける（解き直しは読まれた時）。当たったら、それに頼った答えは、この枠が頼った仮置きを引き継ぐ。
function finishFrame(F, frame, memo, value) {
  popFrame(F, frame);
  const entry = entryOf(
    value,
    [...frame.deps].filter((d) => d !== frame),
    [...frame.cyc].filter(([d]) => d !== frame)
  );
  if (frame.tainted) entry.tainted = true; // 汚れた答え（taint）
  memo.set(frame.key, entry);
  for (const d of entry.deps) d.tentatives.push(entry);
  for (const d of entry.cyc.keys()) d.cycEntries.push(entry);
  // 輪の依りは、当たっても外れても引き継ぐ（記録はこの枠の答えを読んだので、この枠が読んだ途中の枠も通っている）。道筋は、
  // 記録からこの枠まで、この枠の一歩、この枠からその途中の枠まで。
  for (const t of frame.cycEntries) {
    const toFrame = t.cyc.get(frame);
    if (!toFrame) continue;
    t.cyc.delete(frame);
    for (const [d, toD] of entry.cyc) {
      if (t.cyc.has(d)) continue;
      t.cyc.set(d, () => [...toFrame(), stepText(F, frame), ...toD()]);
      d.cycEntries.push(t);
    }
  }
  for (const t of frame.tentatives) {
    t.deps.delete(frame);
    if (t.stale || t.value === "U") continue;
    if (frame.failed) {
      t.stale = true;
      continue;
    }
    for (const d of entry.deps) {
      if (t.deps.has(d)) continue;
      t.deps.add(d);
      d.tentatives.push(t);
    }
  }
  // この枠に頼って作った実体（INSTANCE_DEPTH_MARGIN の注の2・3）。外れたら作った実体の数から外し、当たったら、この枠が頼った
  // 仮置きに頼り直す。外れたかは仮置きの記録と同じ（読まれて A でない）。最後に置く（総数の門に当たっても、記録は済んでいる）。
  // 汚れた答えは、それを読んだ呼んだ側の計算と、仮置きを読んで頼った答えにも移る（taint）。
  if (frame.tainted) {
    taint(F);
    for (const t of frame.tentatives) t.tainted = true;
    for (const c of frame.pendingCalls || []) c.onPath = false; // 汚れた答えに頼った呼び出しは数えない
  }
  if (frame.pendingCalls) settlePending(F, frame, frame.failed || (frame.consulted && value !== "A"), entry.deps);
}

// 素の関数でも括りの関数でもない関数（アリティの分からない関数）の fn。既定値のある関数（`?` の左に `:` がある）には印と
// 仮引数の数を付ける：書いた `_` を実引数に当てた形は G15 で断り（値は既定値だが種類は §5 Q8 で未決、U〔答え〕10-21 03:11）、
// 穴 `!_` は既定値があっても穴にする（tryHole）。仮引数の数は defaultsArity。数え方で振る舞い（G15・穴の k = n と k ≠ n）が分かれるので、
// 実体の鍵（fnKey）にも印と数を入れる。
// 既定値のある口の位置（defaultAt、R39）：前から数えた仮引数ごとに、既定値のある仮引数か。n が数えられなければ null。書いた `_` が
// 既定値のある口に当たれば既定値という値（defaultUnit・tryHole）、既定値の無い口なら G15 なので、実体の鍵にも入れる。
function otherFn(left) {
  if (!left || !treeHasColon(left)) return { type: "other" };
  const n = defaultsArity(left);
  return { type: "other", defaults: true, n, defaultAt: n === null ? null : defaultsSlots(left) };
}

// 既定値のある関数の、仮引数ごとの「既定値のある口か」（R39）。数え方は defaultsArity と同じで、既定値のある口は、仮引数の
// ブロックの `名前 : 既定値` の行と、中に `:` のある括り（`[x : 1]`）。
function defaultsSlots(left) {
  const withDefault = (t) => isBareBlock(t, "bracket") && t.core.rows.some(treeHasColon);
  if (left.terms.length === 1 && isBareBlock(left.terms[0], "indent")) {
    return left.terms[0].core.rows.map((row) => row.type === "op" || withDefault(row.terms[0]));
  }
  return left.terms.map(withDefault);
}

// 既定値のある関数の仮引数の数（§3.4 の言葉。既定値のある仮引数も1つ）。1つと数えるのは、裸の名前・括り（R24 と同じく
// 中身に依らず1つ）・字下げの仮引数のブロックの、裸の名前か括り1つの行と `名前 : 既定値` の行だけ。ほかの形（ブロックの
// 1行に名前が2つある行 `a b`・前置 `~` の仮引数など）は、parseParams が名前を別に数えるので数が割れる。割れたまま n を決めると、
// 穴がどの口を占めるかを外れた n で決める（`gz :` ⏎ `⇥⇥a b` ⏎ `⇥⇥c : 3` ⏎ `⇥? a` の `gz !_ 3` が、仮引数3つの関数を
// k = 2 の穴にした）ので、決めない（null。`!_` は G7 で断る）。
function defaultsArity(left) {
  if (!left || left.type !== "seq") return null;
  const isParamTerm = (t) => !!bareName(t) || isBareBlock(t, "bracket");
  if (left.terms.length === 1 && isBareBlock(left.terms[0], "indent")) {
    const one = (row) =>
      !!row && ((row.type === "seq" && row.terms.length === 1 && isParamTerm(row.terms[0])) || (row.type === "op" && row.sym === ":" && !!singleBareName(row.left)));
    const rows = left.terms[0].core.rows;
    return rows.every(one) ? rows.length : null;
  }
  return left.terms.every(isParamTerm) ? left.terms.length : null;
}

// 名前の種類（§2「ファイルの定義の名前」）。`?` なら L、それ以外は右辺を解いた根の種類。値なら中身の形も持つ（R24：
// 名前を通して渡しても、生まれは右辺のもの）。
function nameKindOf(F, def) {
  if (def.lambda) {
    if (def.pattern) return { k: "L", fn: patternFn(F, def.lambda, def.pattern, F.fileScope, def.name) };
    if (!def.plain) return { k: "L", fn: otherFn(def.lambda.left) };
    return {
      k: "L",
      // op・label は、裸の仮引数の札（paramTag）と、Reader を口に渡した呼び出しの言い分のため（readerAtPlain）。
      fn: { type: "plain", origin: "plain", n: def.n, getBodyRoot: () => bodyRootOf(F, def.lambda), idKey: lambdaKey(def.lambda, F.fileScope.key), op: def.lambda, label: def.name },
    };
  }
  const memo = freshMemo(F, F.valueMemo, def);
  if (memo) return readMemo(F, memo, () => `\`${def.name}\``);
  // 解いている途中の値の定義をもう一度引いた：値を含む輪（「値を含む輪」の注）。輪はその枠から上の全部。
  const running = F.inProgress.get(def);
  if (running) throw cycleError(F, F.stack.indexOf(running));
  const frame = pushFrame(F, def);
  frame.isValue = true; // 値の定義の枠（consult が、この枠より下の仮置きを読ませない）
  const restoreNest = freshNest(F);
  let value;
  try {
    // 定義の行（resolveDefine）と同じ道で右辺を解く。右辺は閉じた1つの項で、ほかの並びと同じく R52 を当てる（`v : 5 inc` の v は 5。§5 Q50 の
    // 答え、resolveDefine の注）。片方だけ当てると、定義の行と名前の種類が割れる（R52 の最初の版で作る途中に見つけた）。
    // 受け皿 dead：右辺に値の上に積まれて口が開いたまま閉じた関数があるか（R59、`$名前` の先。deadOfDef）。
    const dead = [];
    const root = resolveTree(def.rhs, { F, scope: F.fileScope, diag: null, dead });
    // 右辺そのものの余る関数と、右辺の木（別名の引き継ぎは、引く所で木から見る。deadOfDef・aliasDeadOfTree）。
    F.deadDefs.set(def, dead[0] || null);
    F.defRoots.set(def, root);
    value = { k: root.kind.k, fn: root.kind.fn };
    // `:` はメタなので、名前は右辺の式の印を持ち越す（R42 の読み7）：`w : vs~` の w は撒く項のまま（`inc w` は `inc vs~` と同じく
    // 未知、`w inc` は `vs~ inc` と同じく inc を積む。2026-10-23 までは G9）。前は撒く印が落ちて、`inc w` が A、`inc vs~` が未知で割れていた。
    // 2026-10-24 の R51 からは、撒いた器の desc（of）も持ち越す（`inc w` は `inc vs~` と同じ書き下しで、要素の desc を読む）。
    if (root.kind.spread) {
      value.spread = true;
      if (root.kind.of) value.of = root.kind.of;
    }
    // 関数を指す番地の印（R49）も持ち越す（`p : $inc` の `map p vs` は `map $inc vs` と同じ）。値を読む参照の印（R60）も同じ（`q : $vs` の q は `$vs`）。
    if (refOf(root.kind)) value.ref = root.kind.ref;
    if (vrefOf(root.kind)) value.vref = root.kind.vref;
    // 番地の算術で作った点・差の印（R62）も同じ（`p : $vs + 0x10` の `p - $vs` は `($vs + 0x10) - $vs` と同じ差）。構築の中の余ったラムダが消えて1項だけ
    // 残った右辺（`w : ($vs + 0x10) !_`、vanishedOne）からも持ち越す（括り1つの rowsInfo と同じ。2026-10-26 の確かめの直し）。
    const addrRoot = addrOf(root.kind) || addrOf(vanishedOne(root) ? descOfTree(root) : null);
    if (addrRoot) value.addr = addrRoot.addr;
    // 右辺が中身の見える器なら、撒いたときの数（R34 の最後の括り `[~c]` に1つで入ったとき、[x] ≅ x で数える。restCloseKind）。
    // 数は desc に入れず、名前の葉にだけ付ける（valueCountOf）。desc に入れると、括りの関数に渡した desc に乗って、括りの仮引数
    // （`[~r]`・`[x ~xs]` の尾）に器全体の数が入り、しかも実体の鍵（descKey）は数を見ないので、長さの違う器が1つの実体を分け合って
    // 先に作った方の答えを後の方が黙って使った（確かめで見つかった、2026-10-23。`ap : [~r] ? (f4 !_) 1 r` の `ap vs`・`ap ws` の
    // 答えが行の順で変わった）。実体の中では長さを書かない（R24）ので、仮引数の名前は数えない（未知）。
    // 右辺が撒く項（`w : vs~`）なら、撒いた器の数（R51 の書き下しが `inc w` で `inc vs~` と同じ数を見る。flowCount）。
    const count = root.kind.spread ? flowCount(root) : writtenLength(root);
    if (count !== null) F.valueCounts.set(def, count);
    else F.valueCounts.delete(def);
    // 右辺が文字列なら、文字の数（撒いた流れの数だけが読む。stringCountOf）。
    const chars = root.kind.spread ? null : stringLength(root);
    if (chars !== null) F.stringCounts.set(def, chars);
    else F.stringCounts.delete(def);
    const el = visibleElements(root);
    if (el) value.elements = el;
    const sh = shapeOfTree(root);
    if (sh) value.shape = sh;
    // 右辺が書いた `_` を指すか（R56、2026-10-25）。`q : _` の `$q` は `$_` と同じ零射の番地。2026-10-26 の R63（§5 Q64 の答え）から、desc にも印 zero を
    // 付け、実体の鍵に入れる（括りの関数に欄・要素・裸の仮引数で渡しても、実体の中の `$s` が零射の番地と分かる。internDesc の `_`）。R56 の片では desc に
    // 入れなかった（入れると実体の鍵が見ない印が実体を跨いで分け合われうる、pointsToMark の注。R63 で鍵に入れたので、その心配は無い）。
    const unit = pointsToMark(root, { F, scope: F.fileScope });
    F.unitDefs.set(def, unit);
    if (unit && value.k === "A" && !value.shape && !value.spread && !value.ref && !value.vref && !value.addr) value.zero = true;
    // 右辺が番地の字面か（R62）：`n : 0x10` の `$x + n` は `$x + 0x10` と同じく、点に足す差（hexOperand）。desc には入れない（番地の字面は中身の見えない
    // A のまま、解決器は今の扱い。顔は位置で決まり、点に足し引きする所でだけ差と読む）。
    F.hexDefs.set(def, hexTree(root, { F, scope: F.fileScope }));
  } catch (e) {
    abortFrame(F, frame);
    throw e;
  } finally {
    restoreNest();
  }
  finishFrame(F, frame, F.valueMemo, value);
  return value;
}

// 素の名前つき関数の、本体の根の種類（§3.4）。
function bodyRootOf(F, lambdaOp) {
  const memo = freshMemo(F, F.bodyMemo, lambdaOp);
  if (memo) return readMemo(F, memo, () => `\`${F.namedLambdas.get(lambdaOp).name}\` の本体`);
  const running = F.inProgress.get(lambdaOp);
  if (running) {
    consult(F, running);
    return "A";
  }
  const frame = pushFrame(F, lambdaOp);
  const restoreNest = freshNest(F);
  let value;
  try {
    // 受け皿 dead：本体に値の上に積まれて口が開いたまま閉じた関数があるか（R59、`$名前` の先。deadOfDef）。
    const dead = [];
    const ctx = { F, scope: F.fileScope, diag: null, dead };
    const lam = makeLambda(lambdaOp, ctx);
    value = resolveBody(lambdaOp.right, { ...ctx, scope: lam.scope }).rootKind;
    F.deadBodies.set(lambdaOp, dead[0] || null);
  } catch (e) {
    if (!isGate(e)) {
      abortFrame(F, frame);
      throw e;
    }
    value = "U"; // 本体が門に当たる。根は決まらない（行を解くときに同じ門で断る）
    if (e.guard) frame.tainted = true; // 守りの断りを捕まえた（汚れ、refusalOf）
  } finally {
    restoreNest();
  }
  if (frame.consulted && value !== "A") {
    value = "U";
    frame.failed = true;
  }
  finishFrame(F, frame, F.bodyMemo, value);
  return value;
}

// ---------------------------------------------------------------------------
// 括りの関数の実体（R24・R25）
// ---------------------------------------------------------------------------
//
// 括りの関数の本体の読み（適用か構築か）は、渡された物の生まれで決まる（R24）。だから本体は、呼ばれて形が決まった
// ときにだけ、形ごとに解く（実体）。定義の所では解かない（R25）。呼ばれる前に読みを1つに決めるのは、関係より先に
// 対象を定めることで、`__` の短絡と同じ誤りになる。一度も呼ばれない関数は `_` と同型で、矛盾ではないので断らない。
//
// 実体は2段で解く。素の関数の本体（bodyRootOf と、定義の行を解くとき）と同じ分け方である。
// 1. 根の種類（instRootOf）：再帰は A と仮置きして一巡し、食い違えば未知（§3.4・R24）。門に当たれば未知にして
//    止めない。仮置きの上で解いた木は、仮置きが外れると黙って違う木になるので、ここでは木を残さない。
// 2. 木（materialize）：解いている途中の種類が無い（F.stack が空）ときに、仮置きの済んだ答えで本体をもう一度解き、
//    木か門を残す。門に当たった実体は、呼んだ行で断る（R25）。呼んだ所が別の実体の本体の中なら、その実体も同じ門で
//    失敗し、いちばん外の呼んだ行で1回だけ、関数の名前と形を足して投げ直す。
//    分け合った実体を、まだ歩いていない物（callIdent）で呼んだら、本体をその物で歩き直して記録だけを足す（walkCalls）。
//
// 定義の行の木（`(inst 形 本体)` の並び）は、ファイルの全部の行を解き終えてから埋める（resolve の最後）。だから
// 呼ぶ行が定義の前でも後でも、定義の行の木は同じになる。行を前もって全部解いて実体を集める段は要らない。
//
// 実体（の答え）は鍵（書いた `?` の綴り・範囲・渡された物の形）で共有するが、定義の行に描くのは、その `?` を
// 通って呼ばれた実体だけにする（F.calls、recordCall）。同じ綴りの別の関数の呼び出しで描くと、呼ばれていない関数の
// 行に inst が出て、R25 の「一度も呼ばれない括りの関数は defer」が破れる。逆に、分け合った実体の本体の中の呼び出しを
// 作った側の物でしか記録しないと、呼ばれた方の行が defer のまま残る（呼んだ物の同一性、callIdent の注）。門の名指しも、
// 呼んだ行で使った関数の名前にする（instanceError）。実体を最初に作った関数の名前にすると、ほかの行の有無で名指しが変わる。

// 形を変えながら自分（か、自分を呼ぶ関数の輪）を呼び続ける再帰（`f : [x ~xs] ? f [xs xs]`）は、実体が有限に収まら
// ない。名指しせずに未知や仮置きのまま止めると黙って違う木になるので、守りに当たったら読みを決めずに断る。守りは4つある。
// 1と2は実体の鍵（渡された形）と確定した答えだけで決め、枠の積み方や作った実体の履歴では決めない。だから当たるかは、
// ほかの門と同じく本体と前提の値だけで決まり、「仮置きの記録」の理屈（どの順に解いても同じ不動点に着く）の中にある。
// 3と4は止まるための資源の守りで、計算の道で決まる（理屈の外。別の reason で断る）。
// どの守りも、当たったら門として投げる（根の種類を解く所では未知になり、そこから先は浅く止まる）。1 は普通の門で、呼んだ行
// で名指しする。2〜4 は覚えて（guardRefusal）、resolve の最後に言う。当たった `?` では、それから新しい実体を作らない（ほかの
// `?` は解き続ける）。前段（名前の種類と素の関数の本体の根）でも行でも、断ってもその先を解き続け（解き直しの守りと値を含む輪
// だけは、そこで止める）、言うのは、解き直しの守り → 値を含む輪 → 2（ファイル全体の最後の木で決まる）→ 最初に断った行の門 →
// 3・4 → 汚れた所の輪と門の順（refusalOf、注の5）。3・4 は計算の道で決まり、当たった後は実体を作らせないので、汚れていない最後の
// 木の門を先に言う。断る行が2つ以上なら行の順に言うのは今までどおりで、資源の守りの前後では、断るかが解く順に依りうる（§5 Q25 の
// 未決）。
//
// 1. 深さ（INSTANCE_DEPTH_MARGIN）：作る実体の鍵の入れ子の深さ（instanceDepth）が上限（F.depthLimit）を超えたら、その実体を
//    作らずに G7 で断る。根の種類を解く所（instRootOf）では未知になり、木を残す段（materialize）が同じ鍵にまた当たって、呼んだ行で
//    名指しする（R25）。深さは鍵の綴りだけで決まり（番号に持たせる、depthOf）、上限は解く前にソースだけから決める（writtenDepth）
//    ので、どの定義・行から先に解いても、記録を引いても同じになる。
//    数え方：中身の見えない A・未知・数の葉は 1、構造体と List は中身のいちばん深い物に 1 を足す。関数の葉は、書いた所の
//    範囲の深さ（実体の中で書いた閉包の鍵は、書いた所の範囲の鍵＝実体の鍵を持つ。fnDepth）で、ファイルの範囲なら 1。括りの
//    関数の部分適用と合成は、元の関数と当てた物（裸の仮引数の位置は A）・中の関数のいちばん深い物に 1 を足す。素の関数の
//    部分適用と穴は、元の関数と同じ（鍵に当てた物が入らない）。門で見る実体の深さは、括りの仮引数に当てた物のいちばん深い物
//    （裸の仮引数は A なので 1）。関数を書いた所の深さは入れない（書いた所の実体は、その実体の門で見てある）。実体の範囲の
//    深さ（中で書く閉包の深さ）は、当てた物の深さと、書いた所の範囲の深さの大きい方。
//    上限：（この数 × 書いた括りの関数の数 + 1）× 書いたいちばん深い形（writtenDepth。名前を通した深さ、前の定義を指して深く
//    なる鎖も書いた分）。呼んだ行に書いた形はいちばん深い形まで（ここで + 1）で、入れ子の道（実体の本体が実体を作る道）で括りの
//    関数を1つ通るたびに、呼んだ所に書いた形の分（いちばん深い形まで）しか深くならない（受けた物を、書いた形の中に入れて渡す
//    だけ）。だから、どの括りの関数もこの数の回までしか通り直さない道（括りの関数を この数 × 書いた括りの関数の数 回まで通る道）
//    は、上限までしか届かない。前の版の深さの守り（同じ `?` の実体の入れ子 32）を通った形は、どれも上限を越えない。
//    越えるのは、同じ `?` を何十回も通り直して形が深くなり続ける再帰だけである（前の「この数 ×（括りの関数の数 + 1）× いちばん深い形」
//    は、この道の届く深さより 31 × いちばん深い形だけ大きく、深くなり続ける再帰をその分遅く断った）。書いた字面・書いた部分適用と合成の鎖
//    （`q1 : pp [f : q0] [f : q0]`…）・値や閉包を欄で渡す別々の関数の鎖・減っていく形の再帰・輪の中で深くなってから戻る有限の
//    再帰は断らない。形が深くなり続ける再帰（`f : [x ~xs] ? f [xs xs]`、閉包が前の実体の中で書かれる `f : [s] ? f [s : [y ? s y]]`
//    など）は、書いた形が浅ければ深さの門で、上限が大きければ先に入れ子の数の守り（注の4）で断る。前（同じ日のまとめ直しの
//    後）は上限を固定の 32 にしていたので、32 段より深い字面や書いた鎖を、有限で値の決まる形でも断った（主の Claude の指摘、
//    利用者の承認で直した。2026-10-20）。
//    その前は同じ `?` の実体の入れ子を数え、どの順に解いても同じ段になるよう数え直していた（枠の並びの数え方・記録の下の
//    入れ子・輪の頭の段・当たった記録を resolve の最後に断る作り。2026-10-20 の自己点検の SC-1・SC-2）。それでも輪の中は
//    近似で、上限のちょうど上では入口で割れえたうえ、当たるかが枠の積み方で決まるので、理屈の外に置いていた。
//    穴（前から、§5 Q25 の未決）：合成の子の合成は開く（R8）ので、同じ合成を2つ並べて渡す再帰（`f : [g] ? f [g : g g]`）は、
//    合成の中の関数の数が倍々になっても深さが増えない。総数の上限に届く前に鍵の長さが溢れ、内部の例外になる（ヒープが尽きてプロセス
//    ごと落ちることもある）。2026-10-24 から、合成の幅の資源の守り（注の6、COMPOSE_WIDTH_LIMIT）で断る。深さに数えるかは未決のまま。
// 2. 総数（INSTANCE_TOTAL_LIMIT）：深さに上限があっても、形が枝ごとに増えると実体は 2^深さ になり、解決が止まらない。同じ
//    `?`（書いた所。どの範囲で書いた物も1つ）を通って呼んだ、確定した実体の数がこの数を超えたら G7 で断る。同じ綴りの関数は
//    実体を分け合うが、呼んだ `?` のそれぞれで数える（綴りで数えると、別々に書いた2つの関数が上限を分け合った。確かめ
//    2026-10-20）。確定した実体とは、最後の木の道にあると言える呼び出しの実体である（noteCall）：呼んだときに、解いている途中の
//    どの枠も仮置きに頼っておらず（pendingNow）、門に当たる実体を呼んだ後でもない（gated）物、頼っていた枠が全部当たって閉じた
//    物（settlePending）、枠が空のとき（木を残す段）に呼んだ物。確定した値だけを読んで辿った道は木を残す段がもう一度辿るので、
//    どれも最後の木の実体である。門に当たる実体を呼んだ後ろは、木を残す段がそこで呼んだ行ごと断るので、最後の木に無い（根の
//    種類を解く所は、門を未知にして先へ進む）。外れた仮置きの上でだけ作った実体も、確定した値の上では作られないので数えない。
//    だから断るのは「最後の木の実体の数が上限を超える」ときで、どの順に解いても同じになる。前は作った実体の全部を数えたので、
//    上限の前後で断るかが定義の順で割れた（`g : x ? ⏎ ⇥f x ⏎ ⇥inc` と `f : x ? p [s : (g x)]` に、p の実体を 511 個作る行を
//    足すと、g が先なら仮置きの上の p|{s:A} も数えて G7、f が先なら通る。§5 Q25 の SC-3）。門に当たる実体の後ろの実体も数えて
//    いたので、`t : x ? (bad [y : 1]) , (p [m : 1])` と p の実体を 512 個作る行は、行の順で G5 と総数の G7 に割れた（前の版も）。
//    枝ごとに形が増える再帰（`g : [x ~xs] ? (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])`）は、最初の枝を深さ優先で降りて
//    深さの門に当たるので、最後の木はそこで断る形で、残りの枝は最後の木に無い。根の種類を解く所の増え方は 3 で止まる。最後の木の
//    深さの門は、3 に当たった答えを読んだ所（汚れた計算、注の5）で出るので作り物と見分けられず、3 を言う（refusalOf）。
// 3. 作った実体の数（INSTANCE_WORK_LIMIT）：2 で数えない実体（仮置きに頼った物と、門に当たる実体の後ろの物）は、増え続けても
//    2 では止まらない（`g : [x ~xs] ? (g xs) , (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])` は、同じ形で自分を引いた後なので、
//    後ろの実体はどれも g の仮置きに頼る）。だから同じ `?` で作って外れていない実体（確定した物と、まだ仮置きに頼っている物と、
//    門の後ろの物）にも 2 の 2 倍の上限を置く（instance-work-limit）。頼っていた枠の仮置きが外れたら、その実体は数から外す
//    （discard）。外さないと、外れた仮置きの世界ごとに実体が積み増し、上限の前後で定義の順で割れた（f が g と h の仮置きの上で
//    同じ p の実体を 342 個ずつ作り、g → h → f の順に解く並べ方だけ 1026 個で断る。確かめ 2026-10-20）。外した後に残る割れは、
//    まだ外れると分かっていない仮置きの上の実体と門の後ろの実体が、同時に 2 との差（512 個）を埋めるときである（§5 Q25 の未決）。
// 4. 入れ子の数（INSTANCE_NEST_LIMIT）：形が深くならないまま、解いている途中の実体が長く入れ子になる再帰（欄 7 つの並べ替え。
//    形は 5040 通り）や、それを関数を跨いで呼び合う再帰は、JS のスタックを溢れさせ、解き直しと輪の記録（仮置きの依り・輪の依り）
//    の手間も入れ子の長さの2乗ほどで増えた（前の深さの守り「同じ `?` の実体の入れ子 32」を外した後。確かめ 2026-10-20）。だから、
//    再帰の入れ子（根の種類を解いている実体と木を解いている実体のうち、同じ `?` の2つ目から先の数の和）に上限を置く
//    （instance-nest-limit、enterNest）。値だけを渡す別々の関数の鎖（それぞれの `?` は1つずつ）は数えない：重いのは再帰で、
//    鎖は前の版と同じく何段でも通す。数えるのは、素の名前つき関数の本体と値の定義を解く枠の間だけで、その枠に入ると数え直す
//    （freshNest。前の版の深さの守り stretchOf は、括りの関数の実体でない枠（名前の無い関数の解き直しの枠も）で数えるのを止めて
//    いた。ここで数え直すのは、1つずつしか積まれない枠だけ）。どちらの枠も枠の並びに1つずつしか積まれないので、再帰の入れ子の
//    和は（その数 + 1）× 上限までに収まる（実体の入れ子の長さそのものは、別々の `?` の鎖で何段でも伸びる）。前は枠を跨いで数えたので、素の関数を挟む hb の
//    鎖（`fi : x ? hb [s : f(i+1)]`）を 257 個で断った（前の版は通す。確かめ 2026-10-20 の6回目）。数え直す所が多いと遅くなる
//    （素の関数で区切った欄 6 つの並べ替えの再帰を 64 個つなぐと、`--stack-size=8000` で 16 秒。前の版は 3 秒。既定のスタック
//    では溢れて 0.1 秒で resolve-stack-limit。§5 Q25 の未決）。前の版を通った物は、素の関数の枠の間で同じ `?` を 32 段より深く
//    入れ子にしないので、その間で 9 つ以上の `?` が同時に深く再帰しない限り、ここも通る（9 つの `?` が 30 段ずつ再帰する有限の
//    形は、前の版は通し、ここで断る。和を 512 にするか、
//    `?` ごとに 32 段を超えるまで断らないと、関数を跨ぐ並べ替えの再帰が、関数 16 個で 37 秒、32 個で 5 分を超えた。重いのは
//    解き直しと輪の記録で、入れ子の長さの2乗ほどで増える。確かめ 2026-10-20、§5 Q25 の未決）。入れ子の長さは、先に作った
//    実体の記録を引くかで変わるので、上限の前後では定義の順で割れうる（§5 Q25 の未決）。全部の入れ子でも数えると、関数を跨ぐ
//    並べ替えの再帰が 1024 段で 3.8GB を使い、`?` ごとに数えると、関数 8 つで 2048 段になりヒープが尽きた（2026-10-20）。
//    スタックが溢れたら（鎖が長いか、実体1段の本体が重い）、内部の例外にせず、資源の守りとして断る（resolve-stack-limit、
//    stackRefusal。どこで溢れるかは、同じプロセスで前に何を解いたかでも変わる）。
// 5. 汚れ（taint）：守りに当たった所は門として未知になり、当たった `?` の新しい実体は作らないので、守りの断りを捕まえた枠の答え
//    と、その答えを読んだ計算は、守りが無いときと違いうる。だから、守りの断りを捕まえた枠と、汚れた答えを読んだ計算に印を付け
//    （frame.tainted・記録の tainted・行の F.lineTainted）、汚れた計算の呼び出しは 2 に数えず、汚れた計算で出た門と値を含む輪は
//    作り物かもしれないので、3・4 の後に言う（refusalOf）。前は、入れ子の数の守りで未知になった根から出た G2(a) を、最後の木の
//    門として先に言った（入れ子の数の守りに当たる再帰を本体で呼ぶ `fz : x ? r …` と `fz 5 inc`。確かめ 2026-10-20）。
// どの値も言語の規則ではなく実装の守りで、値は決めていない。
const INSTANCE_DEPTH_MARGIN = 32;
const INSTANCE_TOTAL_LIMIT = 512;
const INSTANCE_WORK_LIMIT = 2 * INSTANCE_TOTAL_LIMIT;
const INSTANCE_NEST_LIMIT = 256;
// 6. 合成の幅（COMPOSE_WIDTH_LIMIT、2026-10-24）：合成の子の合成は開く（R8）ので、同じ合成を2つ並べて渡す再帰は、合成の中の関数の数が
//    段ごとに倍になっても鍵の深さが増えず、深さの門にも入れ子の数の守りにも届く前にヒープが尽きて、プロセスごと落ちた（注の1の「穴」、
//    §5 Q25 の前からの穴。欄の `dg : [f] [~t] ? dg [f : f f] t` の `dg [f : inc] vs` は HEAD d78ce73c でも落ちる）。2026-10-24 の試し（R49）で、
//    実体の中の `@f` が指す関数そのものになったので、番地の道（`deep7 : f [~t] ? deep7 $[@f @f] t` の `deep7 $inc vs`。前は `@f` が頭以外で
//    G6）からも入れるようになった（試しの確かめで見つかった）。だから、関数の項の段（開いた合成の中の関数）の数に上限を置き、超えたら資源の
//    守りとして断る（compose-width-limit、widthRefusal。スタックの溢れと同じく、解いている途中のどこで当たっても行の外まで投げ上げる）。
//    合成の長さを深さに数えるか（R8 の、左からの畳み込みの深さ）は決めていない（§5 Q25）ので、門ではなく資源の守りにした。値は決めていない。
const COMPOSE_WIDTH_LIMIT = 1024;

// 書いた形の深さ（注の1）。解く前に、ソースだけから決める（解いている途中に分かる深さで決めると、また定義の順に依る）。
// deepest は、ファイルに書いたどの形（括り・字下げのブロック・並び・`,` の並び、関数の本体の中も）よりも深い数：書いた形の
// 深さを、実体の鍵の深さと同じく数える（括りと並びと `,` は中身に 1 を足す。名前は、ファイルの値の定義なら右辺の書いた
// 深さを通す。定義が前の定義を指して深くなる鎖（`q1 : pp [f : q0] [f : q0]`…）も書いた分に数える。輪は 0 で切る）。
// 数え方は鍵の深さより浅くならない側に倒す（1行の括りにも 1 を足す、関数の本体の枝の条件（`:` の左）に書いた形も数える、
// 文字列の字面は文字の List なので 2、など）。`x ' k` の右が裸の名前か字面の整数なら鍵（欄の名前か位置、R26）なので名前として
// 辿らず、ほかの右（`x @ k` の右も）は解くので数える。brackets は、書いた括りの関数（括りの
// 仮引数を持つ `?`）の数。
function writtenDepth(lines, F) {
  let deepest = 1;
  const lambdas = new Set();
  // 値の定義の書いた深さ。右辺の値の形だけを数える：関数の本体（`?` の右）と `:` の左は値の形に入らず、印の付いた名前（`$w`・
  // `@w`・前置 `~`・後置 `@` は種類を引かない。値の印・後置 `~` を付けた物も、鍵では形の無い値か撒く項で深さ 1）は辿らない。
  // だから、ここで辿る名前の輪は種類の輪（値を含む輪で、どの並べ方でも name-cycle で断る。§5 Q30）だけで、そこを 0 で切っても、
  // 断らないプログラムの答えは並べ方に依らない。
  const memo = new Map(); // 値の定義 → 書いた深さ（解いている途中は 0）
  const nameDepth = (name) => {
    const def = F.defs.get(name);
    if (!def || def.lambda) return 1;
    if (memo.has(def)) return memo.get(def);
    memo.set(def, 0);
    const d = treeDepth(def.rhs, true);
    memo.set(def, d);
    return d;
  };
  // inValue：値の定義の右辺の形を数えている（関数の本体には入らず、deepest も動かさない）。
  const termDepth = (t, inValue) => {
    if (!t) return 1;
    // 2026-10-25 の R60 から、`$` は値の先も通し、値を読む参照は指す値の深さに 1 を足した鍵を持つ（internDesc の vref）。括りでない先（名前・字面・
    // ほかの前置の印の組み合わせ）は、`$` を外した先の深さに 1 を足す（関数の名前 `$inc`・`$_`・`$@f` は今までどおり 2）。括りの先は下の行の数え方のまま。
    if (t.type === "atom" && t.pre.length && t.pre[0] === "$" && !t.post.length && !t.core.rows) return 1 + termDepth({ ...t, pre: t.pre.slice(1) }, inValue);
    // `x ' k` の右が裸の名前か字面の整数なら鍵（欄の名前か位置）で、名前として引かない（R26、pickKeyOf。classifyInfix と同じ）。
    // ほかの右（`x @ k` の右も）は解くので、書いた形を数える。
    if (t.type === "infix") return 1 + Math.max(termDepth(t.left, inValue), t.sym === "'" && pickKeyOf(t.right) ? 1 : termDepth(t.right, inValue));
    // `$名前` は、名前が関数なら指す関数の印を持つ番地で、鍵の深さは 2（R49。internDesc の ref）。浅くならない側に倒して 2 と数える。
    // 2026-10-25 の R55〜R57 から、印を持つ番地は `$名前` のほかにも、`$_`（零射、R56）と、前置の印の組み合わせ `$@f`（R57）がある。どれも 2 と数える。
    if (t.core.c === "name") return t.pre.length || t.post.length ? (t.pre[0] === "$" && !t.post.length ? 2 : 1) : nameDepth(t.core.name);
    if (t.core.c === "unit" && t.pre.length === 1 && t.pre[0] === "$" && !t.post.length) return 2;
    if (t.core.rows) return 1 + t.core.rows.reduce((m, r) => Math.max(m, treeDepth(r, inValue)), 0);
    if (t.core.c === "lit" && t.core.text.startsWith("`")) return 2; // 文字列は文字の List（鍵では 2 段）
    return 1;
  };
  const treeDepth = (t, inValue) => {
    if (!t) return 1;
    let d;
    if (t.type === "seq") d = t.terms.length === 1 ? termDepth(t.terms[0], inValue) : 1 + Math.max(...t.terms.map((x) => termDepth(x, inValue)));
    else if (t.sym === "?") {
      if (!inValue && !lambdas.has(t)) {
        lambdas.add(t);
        const body = treeDepth(t.right, false); // 本体に書いた形（先に数える：中の括り・枝の条件・`?` でも deepest が上がる）
        deepest = Math.max(deepest, body);
      }
      d = 1;
    } else if (t.sym === ":") {
      // 左は値の形に入らない（定義・欄の名前、枝の条件）。ただ2項以上の枝の条件は解くので、そこに書いた形も数える。
      if (!inValue) treeDepth(t.left, false);
      d = treeDepth(t.right, inValue);
    }
    else if (t.sym === ",") d = 1 + Math.max(treeDepth(t.left, inValue), treeDepth(t.right, inValue));
    else d = Math.max(treeDepth(t.left, inValue), treeDepth(t.right, inValue));
    if (!inValue) deepest = Math.max(deepest, d);
    return d;
  };
  for (const line of lines) treeDepth(line, false);
  const brackets = [...lambdas].filter((op) => op.left && patternParamsOf(op.left)).length;
  return { deepest, brackets };
}

// 作る実体の門で見る鍵の深さ（注の1）：括りの仮引数に当てた物のいちばん深い物（裸の仮引数は A なので数えない）。関数を
// 書いた所の深さは入れない（書いた所の実体は、その実体の門で見てある。入れると、深い実体の中で書いた `[[b] ? b] [1]` まで
// 断る）。params と argDescs は bindParams と同じ。
function instanceDepth(params, argDescs) {
  let depth = 1;
  params.forEach((p, i) => {
    // 裸の仮引数に渡った、関数を指す番地（R49）も鍵に入るので数える。括りの仮引数に直に渡った番地は、鍵では A（bindParams）。
    const d = argDescs[i];
    if (p.kind === "bare") {
      if (readerOf(d) || zeroOf(d)) depth = Math.max(depth, depthOf(internDesc(d))); // 値を読む参照（R60）・番地の点と差（R62）・`_` を指す値（R63）も鍵に入る
    } else depth = Math.max(depth, depthOf(internDesc(readerOf(d) ? A() : d)));
  });
  return depth;
}
function depthGate(label, shapeText, depth, limit) {
  const e = gate(
    "G7",
    `括りの関数 \`${label}\` を形 ${cutShape(shapeText)} で呼ぶと、渡した物の鍵の入れ子（形と、欄の関数を書いた所の実体の鍵）が ${limit} 段を超えます（${depth} 段。上限は、括りの関数をそれぞれ ${INSTANCE_DEPTH_MARGIN} 回まで通り直したときに、書いた形から届く深さ）。形を変えながら自分か、自分を呼ぶ関数の輪を呼び続けると、実体が有限に収まるかを決めないので、本体の読みを決めません（R24）。`
  );
  e.instance = { fn: label, shape: shapeText };
  e.instances = [e.instance];
  return e;
}

// いまの呼び出しが最後の木の道にあると言えるか（注の2）。言えないのは、解いている途中の枠が仮置きに頼っているとき
// （pendingNow。仮置きを読まれた枠 consulted と、枠と無名の関数の本体が頼っている枠 deps）と、枠の計算が門に当たった実体を
// 呼んだ後のとき（gated）。根の種類を解く所は、実体の本体が門に当たっても未知にして先へ進むが、木を残す段はそこで呼んだ行
// ごと断るので、その後ろで作る実体は最後の木に入らない（門に当たる `bad [y : 1]` の後ろの `p [m : 1]`。確かめ 2026-10-20）。
function pendingNow(F) {
  const s = new Set();
  for (const f of F.stack) {
    if (f.consulted) s.add(f);
    for (const d of f.deps) s.add(d);
  }
  for (const c of F.collectors) for (const d of c.deps) s.add(d);
  return s;
}
const gatedNow = (F) => F.stack.some((f) => f.gated);
// 括りの関数 fn（書いた `?` は op）を通って実体 inst を呼んだ（注の2・3）。made なら、この呼び出しが実体を作った（か、外した
// 実体を作り直した）。最後の木の道にあると言えれば、op の確定した実体に数える。仮置きに頼っていれば、頼っている枠に覚えさせ、
// 枠が閉じたときに決める（settlePending）。門に当たった実体を呼んだ後なら数えない（木を残す段で、呼んだ所が数える）。
function noteCall(F, inst, op, label, made) {
  const set = F.instanceTotals.get(op);
  if (set && set.has(inst)) return;
  // 同じ `?` からの控えが残っていれば、足さない（控えは `?` ごとに1つ。頼っている枠の全部へ呼ぶたびに足すと、輪で何度も
  // 呼び直す再帰で控えが入れ子の長さの2乗ほどに増えた。足さずに数え漏れても、木を残す段の呼び出しが数える）。
  if (!made && inst.pendingOps && inst.pendingOps.has(op)) return;
  const pend = pendingNow(F);
  const onPath = !gatedNow(F) && !taintedNow(F);
  if (!pend.size) {
    if (onPath) countSettled(F, inst, op, label);
    return;
  }
  const entry = { inst, op, label, made, onPath, pendingOn: pend };
  for (const f of pend) (f.pendingCalls || (f.pendingCalls = [])).push(entry);
  (inst.pendingOps || (inst.pendingOps = new Set())).add(op);
}
// 作って外れていない実体の数（注の3）。作った `?`（か、外した実体を作り直した `?`）で数える。
function makeLive(F, inst, op, label) {
  const made = (F.instancesMade.get(op) || 0) + 1;
  if (made > INSTANCE_WORK_LIMIT) throw guardRefusal(F, "work", label, op);
  F.instancesMade.set(op, made);
  inst.liveOp = op;
}
// 外れた仮置きの上でだけ作った実体を、作った実体の数から外す（注の3）。鍵の記録（F.instances）には残し、また呼ばれたら
// 作り直したと数える（instantiate）。確定した実体は外さない。
function discard(F, inst) {
  if (!inst.liveOp || inst.final) return;
  F.instancesMade.set(inst.liveOp, F.instancesMade.get(inst.liveOp) - 1);
  inst.liveOp = null;
}
// 解いている途中の枠 frame が閉じた（failed なら仮置きが外れた）ときの、frame に頼った呼び出し。外れたら、その呼び出しが作った
// 実体を作った実体の数から外し、当たったら frame が頼っていた枠（deps）に頼り直す。どの枠にも頼らなくなったら確定した実体
// （総数に数える）。数えるのは最後にまとめて（総数の門に当たっても、frame の後片付けを終えてから投げる）。
function settlePending(F, frame, failed, deps) {
  const now = [];
  for (const entry of frame.pendingCalls || []) {
    if (!entry.pendingOn || !entry.pendingOn.has(frame)) continue;
    entry.pendingOn.delete(frame);
    if (failed) {
      entry.pendingOn = null;
      entry.inst.pendingOps.delete(entry.op);
      if (entry.made) discard(F, entry.inst);
      continue;
    }
    for (const d of deps) {
      if (entry.pendingOn.has(d)) continue;
      entry.pendingOn.add(d);
      (d.pendingCalls || (d.pendingCalls = [])).push(entry);
    }
    if (entry.pendingOn.size) continue;
    entry.pendingOn = null;
    entry.inst.pendingOps.delete(entry.op);
    if (entry.onPath) now.push(entry);
  }
  frame.pendingCalls = null;
  for (const e of now) countSettled(F, e.inst, e.op, e.label);
}
// 確定した実体を、呼んだ `?` ごとに数える（注の2）。同じ綴りの関数が分け合う実体は、呼んだ `?` のそれぞれで1つ。上限を
// 超えたら断る。確定した実体は、作った実体の数でも外さない。
function countSettled(F, inst, op, label) {
  let set = F.instanceTotals.get(op);
  if (!set) F.instanceTotals.set(op, (set = new Set()));
  if (set.has(inst)) return;
  if (set.size + 1 > INSTANCE_TOTAL_LIMIT) throw guardRefusal(F, "total", label, op);
  set.add(inst);
  if (!inst.liveOp) makeLive(F, inst, op, label);
  inst.final = true;
}
// 守りの断り（注の2〜4）。当たった実体と行は解く順に依るので、書いた `?` の名前（名前の定義なら名前、括りなら綴り）だけを
// 言う。ほかの門と同じく投げ（根の種類を解く所では未知になり、そこから先は浅く止まる）、覚えて resolve の最後に断る。覚えた物が
// 2つ以上なら、名前のいちばん小さい物。総数は G7（断るかは最後の木だけで決まる）、作った実体の数と入れ子の数は資源の守り
// なので、別の reason にする。
const GUARD = {
  total: { reason: GATE_REASON.G7, gate: "G7", what: () => `確定した実体が ${INSTANCE_TOTAL_LIMIT} 個を超えました` },
  work: { reason: "instance-work-limit", gate: "", what: () => `作った実体（仮置きの上で作った物も数える）が ${INSTANCE_WORK_LIMIT} 個を超えました` },
  nest: { reason: "instance-nest-limit", gate: "", what: () => `実体を解いている途中に、再帰の入れ子（同じ \`?\` の2つ目から先の実体の数の和）が ${INSTANCE_NEST_LIMIT} を超えました` },
};
function guardRefusal(F, kind, label, op) {
  const g = GUARD[kind];
  const e = new OperationError(
    `括りの関数 \`${label}\` の${g.what()}（形を変えながら増え続けています）。実体が有限に収まるかを決めないので、本体の読みを決めません（§5 Q25）。`,
    { spec: `${SPEC} §4 R24`, reason: g.reason }
  );
  e.gate = g.gate;
  e.guard = kind; // isGate に数える（ほかの門と同じく、根の種類を解く所では未知）
  e.label = label;
  e.instance = { fn: label, shape: "" }; // 名指しは `?` の名前だけ（形は言わない）
  e.instances = [e.instance];
  const old = F.guards[kind];
  if (!old || label < old.label) F.guards[kind] = e;
  if (!F.guardStops.has(op)) F.guardStops.set(op, e); // この `?` では新しい実体を作らない（instantiate）
  return e;
}
// 覚えた守りの断り（resolve の最後）。総数・作った実体の数・入れ子の数の順。
function guardRefused(F) {
  return F.guards.total || F.guards.work || F.guards.nest || null;
}
// 解いている途中の実体（根の種類を解いている物と、木を解いている物）の入れ子に入る（注の4）。出るのは呼んだ側（instRootOf・
// materialize）。
function enterNest(F, inst) {
  const n = F.instNest.get(inst.lambda) || 0;
  if (n >= 1 && F.instRecur >= INSTANCE_NEST_LIMIT) throw guardRefusal(F, "nest", inst.label, inst.lambda);
  F.instNest.set(inst.lambda, n + 1);
  if (n >= 1) F.instRecur++;
}
function leaveNest(F, inst) {
  const n = F.instNest.get(inst.lambda) - 1;
  F.instNest.set(inst.lambda, n);
  if (n >= 1) F.instRecur--;
}
// 素の名前つき関数の本体と値の定義を解く間は、入れ子を数え直す（注の4）。どちらも枠に1つしか積まれない（解いている途中に
// また引けば、仮置きか値を含む輪）ので、数え直しても再帰の入れ子の和は「（その数 + 1）× 上限」までに収まる。前の版の深さの
// 守り（stretchOf）は、括りの関数の実体でない枠（名前の無い関数の解き直しの枠も）で数えるのを止めていた。返すのは、元の数に戻す関数。
function freshNest(F) {
  const { instNest, instRecur } = F;
  F.instNest = new Map();
  F.instRecur = 0;
  return () => {
    F.instNest = instNest;
    F.instRecur = instRecur;
  };
}
// JS のスタックが溢れた（注の4）：入れ子の数の守りの内でも、実体1段の本体が重い（括弧の深い入れ子）と溢れる。内部の例外の
// まま出さず、資源の守りとして断る（どこで溢れるかは、同じプロセスで前に何を解いたかでも変わる）。
function stackRefusal(e) {
  if (!(e instanceof RangeError) || !/call stack/i.test(e.message)) return null;
  const s = new OperationError("解決の途中で JS のスタックが溢れました（実体の入れ子か、本体の入れ子が深すぎます）。読みを決めません（§5 Q25）。", {
    spec: `${SPEC} §4 R24`,
    reason: "resolve-stack-limit",
  });
  s.guard = "stack"; // 資源の守り（refusalOf）
  return s;
}
// 合成の幅の守り（注の6）。関数の項の段の数が上限を超えたら、OperationError でない印の例外を投げる：門ではないので、根の種類を解く所や
// 門を握りつぶす所（isGate）で未知に化けずに、スタックの溢れと同じく resolve の行の外まで投げ上がり、そこで資源の守りの断りにする。
class ComposeWidthOverflow extends Error {}
function widthRefusal(e) {
  if (!(e instanceof ComposeWidthOverflow)) return null;
  const s = new OperationError(
    `合成の中の関数が ${COMPOSE_WIDTH_LIMIT} 個を超えました（同じ合成を並べて渡す再帰で、合成の幅が増え続けています）。合成の長さを深さに数えるかを決めていないので、実体が有限に収まるかを決めず、読みを決めません（§5 Q25）。`,
    { spec: `${SPEC} §4 R24`, reason: "compose-width-limit" }
  );
  s.guard = "width"; // 資源の守り（refusalOf）
  return s;
}
// 断る理由を1つ選ぶ（resolve の最後）。e は覚えた行の断り（資源の守りから来ていない、汚れていない物を先に覚えた物）。
// 解き直しの守り → 値を含む輪（汚れていない物）→ 実体の総数（G7、ファイル全体の最後の木で決まる）→ 行の門（汚れていない、
// 最初に断った行）→ 資源の守り（作った実体の数・入れ子の数・スタック）→ 汚れた輪・汚れた行の断りの順。資源の守りに当たった後の
// 計算は、当たった `?` の新しい実体を作らず、それを捕まえた答えは守りが無いときと違いうる（taint）ので、汚れた所で出た門は
// 資源の守りの後に置く。汚れていない門は最後の木の門なので、資源の守りより先に言う。
function refusalOf(F, e) {
  if (F.againRefused) return F.againRefused;
  const cycle = F.cycleRefused;
  if (cycle && !cycle.suspect) return cycle;
  if (F.guards.total) return F.guards.total;
  if (e && !e.guard && !e.suspect) return e;
  return F.guards.work || F.guards.nest || F.stackRefused || cycle || e;
}

function patternFn(F, op, params, defScope, label) {
  const fn = { type: "pattern", n: params.length, idKey: lambdaKey(op, defScope.key), label, op, scopeKey: defScope.key };
  fn.lastBracket = params[params.length - 1].kind !== "bare"; // 残りの並びを最後の括りが受ける形（fnShape・closeKind）
  fn.bareAt = params.map((p) => p.kind === "bare"); // 裸の仮引数の位置（部分適用の鍵で A にする、internPartial）
  fn.env = scopeIdent(defScope); // 書いた範囲の同一性（callIdent）
  fn.envDepth = envDepth(defScope); // 鍵の深さ（fnDepth）
  fn.instantiate = (argDescs) => instantiate(F, fn, op, params, defScope, argDescs);
  return fn;
}

// 括りの関数の部分適用（口の開いたまま残った段、partialFn）。残りの仮引数は後ろの n − k 個なので、最後の仮引数が括りかは元の関数の
// まま。当てた物（bound）は元の関数（base）の前から並べて覚え、残りが来たら合わせて元の関数の実体を作る。部分適用の
// 部分適用（`(t3 1) 2`）も、元の関数に当てた物を足していく。
// 鍵は当てた物の形を入れ、木のまま持つ（internPartial）——当てた物の違う部分適用を同じ関数として扱わない（欄に入れて
// 括りの関数に渡したときの実体の鍵）。
function patternPartial(fn, args) {
  const base = fn.base || fn;
  const bound = [...(fn.bound || []), ...args];
  return {
    type: "pattern",
    n: base.n - bound.length,
    label: base.label,
    lastBracket: base.lastBracket,
    base,
    bound,
    instantiate: (argDescs) => base.instantiate([...bound, ...argDescs]),
  };
}

// その `?` を通って、木まで解く実体を呼んだ（定義の行の木に描く物。resolve の最後）。
function recordCall(F, fn, inst) {
  let byScope = F.calls.get(fn.op);
  if (!byScope) F.calls.set(fn.op, (byScope = new Map()));
  let set = byScope.get(fn.scopeKey);
  if (!set) byScope.set(fn.scopeKey, (set = new Set()));
  set.add(inst);
}

// ---- 呼んだ物の同一性（R25 の描き方） ----
//
// 実体の答えは綴りの鍵で分け合うが、記録（recordCall）は「その `?` を通って呼ばれたか」なので、どの `?` かという物の
// 同一性で取る。分け合った実体の本体の中で呼ぶ関数（欄に入れて渡した関数・実体の中の括った `?`）は、実体を作った側の
// 物ではなく、いま呼んだ側の物である。直す前は、使い回したときに本体の中の呼び出しを記録しなかったので、
// `h [f : pair]` と `h [f : pair2]`（pair と pair2 は同じ綴り）で、どちらの定義の行に inst が出るかが行の順で入れ替わった。
// 値の定義が先に作った実体を別の行が木にすると、門の名指しも作った側の名前になった（反証 2026-10-19 の続き）。
// だから呼び出しごとに、呼んだ物の同一性を番号に寄せ（callIdent）、実体ごとに、まだ歩いていない番号で呼ばれたら、本体を
// その物で歩いて記録を足す（materialize・walkCalls）。答えは綴りで決まるので、歩き直しても木・種類・門は変わらない。
// 同一性は、実引数の中と、関数を書いた範囲（実体の範囲なら、その実体を呼んだ物）の中の括りの関数の `?` で決まる。
// 素の関数と点なしは数えない（NO_IDENT）：素の関数の本体は定義の行で解き、呼んでも本体を歩かない。合成は中の関数を数える。
// 番号は歩きを重ねないためだけに使い、鍵にも並び順にも入れない。番号の振り方は見た順に依るが、記録される `?` と実体の
// 組は依らない。比べるのは同じ実体（同じ鍵）を呼んだ物どうしだけで、鍵が各位置の関数の綴りと範囲の鍵を決めているので、
// 番号には書いた `?` と、書いた範囲の同一性だけを入れる。
const NO_IDENT = 0; // 括りの関数が見えない物
let identTable = new Map([["·", NO_IDENT]]); // 綴り（子は番号）→ 番号
let identByDesc = new WeakMap();
let identByShape = new WeakMap();
let identByFn = new WeakMap();
let opSerial = new WeakMap(); // 書いた `?` → 番号（物の同一性）
let opCount = 0;
function identText(text) {
  let id = identTable.get(text);
  if (id === undefined) identTable.set(text, (id = identTable.size));
  return id;
}
function identDesc(d) {
  if (!d) return NO_IDENT;
  const memo = identByDesc.get(d);
  if (memo !== undefined) return memo;
  const id = d.k === "L" ? identFn(d.fn) : refOf(d) ? identFn(d.ref) : vrefOf(d) ? identDesc(d.vref) : d.k === "A" && d.shape ? identShape(d.shape) : NO_IDENT;
  identByDesc.set(d, id);
  return id;
}
function identShape(sh) {
  const memo = identByShape.get(sh);
  if (memo !== undefined) return memo;
  let id = NO_IDENT;
  if (sh.s === "struct") {
    const fields = sh.fields.map((f) => [f.name, identDesc(f.desc)]);
    if (fields.some(([, c]) => c !== NO_IDENT)) id = identText(`{${fields.map(([n, c]) => `${n}:#${c}`).join(" ")}}`);
  } else if (sh.s === "list" && sh.elem) {
    const c = identDesc(sh.elem);
    if (c !== NO_IDENT) id = identText(`[#${c}…]`);
  }
  identByShape.set(sh, id);
  return id;
}
function identFn(fn) {
  if (!fn) return NO_IDENT;
  const memo = identByFn.get(fn);
  if (memo !== undefined) return memo;
  let id = NO_IDENT;
  if (fn.type === "pattern" && fn.bound) {
    // 部分適用：元の関数と当てた物。裸の仮引数の位置は、実体の中で A なので呼べない（internPartial と同じ）。
    const bound = fn.bound.map((d, i) => (fn.base.bareAt[i] && !readerOf(d) ? NO_IDENT : identDesc(d)));
    id = identText(`P#${identFn(fn.base)}(${bound.map((c) => `#${c}`).join(" ")})`);
  } else if (fn.type === "pattern") {
    let n = opSerial.get(fn.op);
    if (n === undefined) opSerial.set(fn.op, (n = opCount++));
    id = identText(`F${n}#${fn.env}`);
  } else if (fn.type === "compose") {
    const fns = fn.fns.map(identFn);
    if (fns.some((c) => c !== NO_IDENT)) id = identText(`C(${fns.map((c) => `#${c}`).join(" ")})`);
  } else if (fn.type === "pfGreedyUnary" && fn.map) {
    id = identFn(fn.map); // `[F,]` の写像（R50）は、写す関数を呼ぶ
  }
  identByFn.set(fn, id);
  return id;
}
// 呼んだ物の同一性：関数を書いた範囲の同一性と、括りの仮引数に当てた物の同一性（裸の仮引数の位置は A なので数えない）。
function callIdent(fn, params, argDescs) {
  // 裸の仮引数でも、関数を指す番地（R49）は本体の `@x` で呼べるので数える。
  const args = params.map((p, i) => (p.kind === "bare" && !readerOf(argDescs[i]) ? NO_IDENT : identDesc(argDescs[i])));
  return identText(`${fn.env}(${args.map((c) => `#${c}`).join(" ")})`);
}
// 範囲の同一性。実体の範囲は、その実体を呼んだ物の同一性を持つ（instScope）。ほかの範囲は外の範囲のもの。
function scopeIdent(scope) {
  for (let s = scope; s; s = s.parent) if (s.ident !== undefined) return s.ident;
  return NO_IDENT;
}
// 実体の範囲：仮引数に当てた desc（R24）と、呼んだ物の同一性と、鍵の深さ（中で書いた関数の深さ、fnDepth）を持つ。
function instScope(F, op, defScope, b, key, ident) {
  const lam = makeLambda(op, { F, scope: defScope });
  lam.scope.descs = b.descs;
  lam.scope.key = key;
  lam.scope.ident = ident;
  lam.scope.depth = b.depth;
  return lam.scope;
}

// 仮引数に渡された物を当てる（R24 の表）。返す物は {descs（名前 → desc）, key, text}。
function bindParams(params, argDescs) {
  const descs = new Map();
  const keys = [];
  const texts = [];
  params.forEach((p, i) => {
    const d = stripTag(argDescs[i]); // 素の関数の裸の仮引数の札は、実体に持ち込まない（paramTag の注）
    if (p.kind === "bare") {
      // 裸の仮引数は、今までどおり A（R24）。渡された物の形を見ないので、鍵も A にする。
      // ただし関数を指す番地（`$inc`、R49）は、印を仮引数の desc に持ち越し（本体の `@f` が指す関数の口の数を知る）、
      // 印ごと鍵に入れる：`map $inc vs` と `map $uu vs` が実体を分け合うと、先に解いた方の答えを後の方が黙って使う。
      if (refOf(d)) {
        descs.set(p.name, { k: "A", ref: d.ref });
        keys.push(descKey(d));
        texts.push(descText(d));
        return;
      }
      // 値を読む参照（R60）も同じ（本体の `@f` が指す値を読む。`h $vs 0` と `h $five 0` が実体を分け合うと、先に解いた方の答えを後の方が使う）。
      if (vrefOf(d)) {
        descs.set(p.name, { k: "A", vref: d.vref });
        keys.push(descKey(d));
        texts.push(descText(d));
        return;
      }
      // 番地の算術で作った点・差（R62）と、書いた `_` を指す値（R63）も、印を持ち越して鍵に入れる（本体の `f - $v` が差か、`$f` が零射の番地か）。
      if (addrOf(d) || zeroOf(d)) {
        descs.set(p.name, addrOf(d) ? { k: "A", addr: d.addr } : zeroDesc());
        keys.push(descKey(d));
        texts.push(descText(d));
        return;
      }
      // 番地の算術で作った点・差を要素・欄に持つ器（hasAddr）は、裸の仮引数では形を見ずに A で受ける（R24）ので、中の印が落ちる。断る側に倒した
      // （2026-10-26 の確かめの直し、§5 Q66。括りの仮引数で受ければ要素・欄の印は見える）。
      if (hasAddr(d)) throw refuseAddressDrop("bare", descText(d));
      descs.set(p.name, A());
      keys.push("A");
      texts.push("A");
      return;
    }
    // 括りの仮引数に直に渡った、関数を指す番地（R49）は、中身の見えない A と同じに受ける（名前は未知、`~rest` は A。bindBracket）ので、
    // 印は本体から見えない。鍵と綴りも今までどおり `A` にする（同じ実体を分け合ってよい）。器の要素や欄の番地は、名前で受けると見えるので
    // 鍵に入れたまま（`[$L…]`・`{f:$L}`）。
    // 値を読む参照（R60）・番地の点と差（R62）・`_` を指す値（R63）も、括りの仮引数に直に渡れば同じ（中身の見えない A。名前は未知で、印は本体から見えない）
    // 2026-10-26 の確かめの直し：番地の算術で作った点・差（R62）が直に渡ったら、名前が未知になって印が落ちる（hasAddr の注）ので断る（§5 Q66）。器の要素・
    // 欄の点・差は名前で受けると見える（bindBracket）ので今のまま。
    if (addrOf(d)) throw refuseAddressDrop("bracket", descText(d));
    const dk = readerOf(d) || zeroOf(d) ? A() : d;
    keys.push(descKey(dk));
    texts.push(descText(dk));
    if (!p.simple) {
      for (const n of p.all) descs.set(n, U()); // 入れ子の分解など、読み方が決まっていない括り（patternParamsOf の注）
      return;
    }
    bindBracket(p, d, descs);
  });
  return { descs, key: keys.join(" "), text: texts.join(" ") };
}
function bindBracket(p, d, descs) {
  const setNames = (f) => p.names.forEach((n) => descs.set(n, f(n)));
  if (!d || d.k !== "A" || d.spread) {
    // L か未知：どの名前も未知。
    setNames(() => U());
    if (p.rest) descs.set(p.rest, U());
    return;
  }
  const sh = d.shape;
  if (!sh) {
    // 中身の見えない A：裸の名前は未知、`~rest` は A。
    // 形では構造体とも List とも読めないが §2 では中身の見える器（行の混ざった括り・同じ名前の欄が2つある構造体・欄の
    // 右辺が撒く項の構造体・撒く項を含む並び）は、`~rest` に中身（elements）を持ち
    // 越す。R24 の表の「中身の見えない A」は裸の仮引数・`$` の番地と番地の字面・範囲・適用の結果のように中身が本当に
    // 見えない物の行で（数の字面は 2026-10-19 に R24 の数の行へ移した）、ここで A() にすると、関数の見える中身を
    // `r~` で撒いても門（§3.3 の手順1）を素通りした（確かめ 2026-10-19 の F2）。
    // 何が残りに入るかは決まらないので、元の器の中身を全部持ち越す（断る側）。
    setNames(() => U());
    if (p.rest) descs.set(p.rest, d.elements ? { k: "A", elements: d.elements } : A());
    return;
  }
  if (sh.s === "scalar") {
    // 数：長さ1の List として受ける（SCALAR の注）。名前はその数、`~rest` は同じ要素の List（形は長さに依らない）。
    setNames(() => scalarDesc());
    if (p.rest) descs.set(p.rest, withShape({ s: "list", elem: scalarDesc() }));
    return;
  }
  if (sh.s === "struct") {
    // 構造体：裸の名前は同じ名前の欄の生まれ。無ければ未知（名前で当たらなかった名前を前から当てるかは、どの言葉にも
    // 無い）。`~rest` は受けなかった欄の構造体。
    setNames((n) => {
      const f = sh.fields.find((x) => x.name === n);
      return f ? f.desc : U();
    });
    if (p.rest) descs.set(p.rest, withShape({ s: "struct", fields: sh.fields.filter((f) => !p.names.includes(f.name)) }));
    return;
  }
  // List：裸の名前は要素の生まれ（要素に L か未知が見えれば未知。mergeElems）、`~rest` は同じ要素の List。
  setNames(() => (sh.elem && sh.elem.k === "A" ? sh.elem : U()));
  if (p.rest) descs.set(p.rest, d);
}

// 括りの関数の適用（§3.4 の括りの関数の行）。k = n のとき（前から順に当てる）と、最後の仮引数が括りで k > n の
// とき（残りの並び全体を最後の括りが1つの List として受ける、R24）と、最後の仮引数が裸で k > n のとき（前から n 個
// だけを当てる。余りは鍵に入れない）に実体を作る（呼ぶのは doneKind・closeKind）。部分適用は、残りが来たときに当てた物と
// 合わせて、元の関数のこの3つのどれかで作る（patternPartial）。
function instantiate(F, fn, op, params, defScope, argDescs) {
  const b = bindParams(params, argDescs);
  const key = `${fnKey(fn)}|${b.key}`;
  const ident = callIdent(fn, params, argDescs);
  let inst = F.instances.get(key);
  if (!inst) {
    // 実体の守り（INSTANCE_DEPTH_MARGIN の注）。深さは鍵だけで決まる普通の門で、超える実体は作らない。守りに当たった `?` では、
    // 新しい実体を作らない（作り続けると、当たった後の枝を全部解いて遅かった）。止めるのは当たった `?` だけにする：全部を
    // 止めると、ほかの `?` の守りや、新しい実体を通る値を含む輪が見つからず、言うことが定義の順で割れた（確かめ 2026-10-20）。
    // 深さの門は止める所より先に見る（鍵だけで決まる門なので、木を残す段が守りに当たった後でも同じ所で断り、最後の木の門を
    // 言える。refusalOf）。
    const depth = instanceDepth(params, argDescs);
    if (depth > F.depthLimit) throw depthGate(fn.label, b.text, depth, F.depthLimit);
    const stopped = F.guardStops.get(op);
    if (stopped) throw stopped;
    // 範囲の深さ（中で書いた閉包の深さ、fnDepth）は、当てた物の深さと書いた所の範囲の深さの大きい方。
    b.depth = Math.max(depth, envDepth(defScope));
    // scope は作った側の物の範囲（根の種類を出す、instRootOf）。walked は本体を歩いて記録した物の同一性（callIdent の注）。
    const scope = instScope(F, op, defScope, b, key, ident);
    inst = { isInst: true, key, label: fn.label, shapeText: b.text, depth: b.depth, lambda: op, scope, walked: new Set(), cycleDeps: new Set(), liveOp: null };
    makeLive(F, inst, op, fn.label);
    F.instances.set(key, inst);
    noteCall(F, inst, op, fn.label, true);
  } else if (!inst.liveOp) {
    // 外れた仮置きの上でだけ作った実体を、また呼んだ：作り直したと数える（注の3）。
    makeLive(F, inst, op, fn.label);
    noteCall(F, inst, op, fn.label, true);
  } else noteCall(F, inst, op, fn.label, false);
  b.depth = inst.depth; // 呼んだ側の物の範囲も、同じ深さを持つ（scopeOf）
  const root = instRootOf(F, inst, fn.label);
  // 本体が門に当たる実体を呼んだ：木を残す段はここで呼んだ行ごと断るので、この枠の計算の後ろは最後の木の道に無い（注の2）。
  if (inst.gated && F.stack.length) F.stack[F.stack.length - 1].gated = true;
  if (F.stack.length === 0) {
    recordCall(F, fn, inst);
    // 木と、本体の中の呼び出しの記録は、いま呼んだ側の物の範囲で歩く。実体を作ったのが木を残さない所（値の定義の種類を
    // 出す所など）でも、門は呼んだ行で渡した物の名前で名指しする。
    const scopeOf = () => (ident === inst.scope.ident ? inst.scope : instScope(F, op, defScope, b, key, ident));
    materialize(F, inst, scopeOf);
    if (inst.error) {
      if (!F.matStack.length) throw instanceError(inst, fn.label);
      // 別の実体の本体の中から呼んだ：その実体も同じ門で失敗する。どの実体を、どの名前で呼んで門に当たったかを
      // 覚えておき、いちばん外の呼んだ行で、呼んだ順に名指しする（instanceError）。
      F.matStack[F.matStack.length - 1].via = { inst, label: fn.label };
      throw inst.error;
    }
    // 分け合った実体を、まだ歩いていない物で呼んだ：その物で本体を歩き、呼んだ `?` を記録する（R25）。
    if (!inst.walked.has(ident)) walkCalls(F, inst, scopeOf());
  }
  // 実体の本体の根が A なら A、ほかは未知（§3.4 の素の関数の k = n と同じ）。結果は中身の見えない A。
  return { kind: root === "A" ? A() : U() };
}

// 実体の本体の根の種類（bodyRootOf と同じ仕組み）。label は呼んだ名前（輪の道筋の一歩、stepText）。
function instRootOf(F, inst, label) {
  const memo = freshMemo(F, F.instMemo, inst);
  if (memo) return readMemo(F, memo, () => `\`${label || inst.label}\` を形 ${cutShape(inst.shapeText)} で呼んだ実体の本体`);
  const running = F.inProgress.get(inst);
  if (running) {
    consult(F, running); // 同じ形で自分を呼んだ：同じ実体の仮置き（R24）
    return "A";
  }
  enterNest(F, inst);
  const frame = pushFrame(F, inst);
  frame.label = label;
  let value;
  let gated = false;
  let spelled = false;
  try {
    const body = resolveBody(inst.lambda.right, { F, scope: inst.scope, diag: null });
    value = body.rootKind;
    spelled = sectionSpelled(body.tree);
  } catch (e) {
    if (!isGate(e)) {
      leaveNest(F, inst);
      abortFrame(F, frame);
      throw e;
    }
    // 本体が門に当たる。木を残す段（materialize）で同じ門に当たり、呼んだ行で断る（深さの守りも、鍵だけで決まる門なので
    // 同じ。INSTANCE_DEPTH_MARGIN の注の1）。
    value = "U";
    gated = true;
    if (e.guard) frame.tainted = true; // 守りの断りを捕まえた（汚れ、refusalOf）
  }
  leaveNest(F, inst);
  // 本体が門に当たるか、門に当たる実体を呼んだ実体は、木を残す段で断る（呼んだ側の枠の後ろは最後の木に無い、instantiate）。
  // 本体の根が L の実体も、木を残す段で G16 に当たる（materialize）。自分の仮置きを読んでいなければ、根は確定した値の上の木の根と
  // 同じ（外の仮置きが外れれば、記録は古くなって解き直す）なので、門に当たる実体に数える。読んでいれば根は未知になり（§3.4）、
  // 木の根が L かはここでは分からないので数えない。綴りで断る根（区間、returnGate）は仮置きに依らないので、読んでいても門に当たる
  // 実体に数える。
  inst.gated = gated || !!frame.gated || spelled || (value === "L" && !frame.consulted);
  if (frame.consulted && value !== "A") {
    value = "U";
    frame.failed = true;
  }
  finishFrame(F, frame, F.instMemo, value);
  return value;
}

// 実体の木（R25）。解いている途中の種類が無いときにだけ呼ぶ。本体の中の未定義の名前は、ここで1回だけ information を
// 出す（F.reported）。定義の所では本体を解かないので、呼ばれない本体の中の名前は出さない（読まないので）。
// 範囲（scopeOf）は、はじめて木にした呼び出しの物のもの。その物の分の記録も、この歩きで取る（walked）。
// 木まで解く実体は最後の木の実体で、呼んだ所（instantiate の noteCall。枠が空なので確定した呼び出し）で確定した実体に数えて
// ある（INSTANCE_DEPTH_MARGIN の注の2）。
function materialize(F, inst, scopeOf) {
  if (inst.materializing) {
    // 木を解いている途中の実体を、本体の中からもう一度呼んだ（再帰）。根の種類は仮置きの済んだ答えを使い、木は
    // 外側の1回で作る。外側が門に当たったら、間にある実体（どれも外側を呼んでいる）も同じ門で失敗にする。
    const i = F.matStack.indexOf(inst);
    for (let j = i + 1; j < F.matStack.length; j++) inst.cycleDeps.add(F.matStack[j]);
    return;
  }
  if (inst.done) return;
  enterNest(F, inst);
  const scope = scopeOf();
  inst.walked.add(scope.ident);
  inst.materializing = true;
  F.matStack.push(inst);
  try {
    const body = resolveBody(inst.lambda.right, { F, scope, diag: F.diag });
    // 実体の本体の根が裸の関数なら G16（R33、returnGate）。ほかの門と同じく、呼んだ行で関数と形を名指しする（R25）。
    const refused = returnGate(() => "", body);
    if (refused) throw refused;
    inst.tree = body.tree;
  } catch (e) {
    if (!isGate(e)) throw e;
    inst.error = e;
  } finally {
    leaveNest(F, inst);
    F.matStack.pop();
    inst.materializing = false;
    inst.done = true;
  }
  if (inst.error) failDependents(inst);
}
// 分け合った実体の本体を、いま呼んだ側の物（scope）で歩き直し、本体の中の呼び出しだけを記録する（callIdent の注）。
// 木と information は残さない：答えは綴りで決まるので、木は materialize の1回と同じになり、未定義の名前も同じである。
// 歩く前に印を付けるので、同じ物で自分を呼ぶ再帰は1回で止まる。本体の中の実体は、同じ綴りの鍵で materialize の
// 歩きがもう作っている。
function walkCalls(F, inst, scope) {
  inst.walked.add(scope.ident);
  resolveBody(inst.lambda.right, { F, scope, diag: null });
}
// 守り：実体が門に当たると、その門は呼んだ行まで投げ上がり、resolve 全体が断る（materialize は F.stack が空のときにだけ
// 走り、そこから上で門を捕まえる所は無い）。だから輪の途中の実体に付けた失敗は、今は誰にも読まれない（確かめ
// 2026-10-19 で観測できなかった）。門を捕まえて続ける所を足したとき、輪の途中の実体を成功のまま残さないために置く。
// 名指しの名前は、実体を最初に作った関数のもの（その実体を呼んだ名前は、ここでは分からない）。
function failDependents(inst) {
  for (const d of inst.cycleDeps) {
    if (d.error) continue;
    d.error = inst.error;
    d.via = { inst, label: inst.label };
    failDependents(d);
  }
}

// 呼んだ行で断る（R25）。門の番号と reason は本体で当たった門のまま、言い分に関数の名前と形を足す。label は呼んだ行で
// 使った関数の名前（実体は同じ綴りの関数で共有するので、実体を作った関数の名前ではない）。実体の本体の中で別の括りの
// 関数を呼んで門に当たったなら、通った実体を呼んだ順に並べる（e.instance はいちばん外、e.instances は全部）。
function instanceError(inst, label) {
  const e0 = inst.error;
  const chain = [{ fn: label, shape: inst.shapeText }];
  const seen = new Set([inst]);
  for (let v = inst.via; v && !seen.has(v.inst); v = v.inst.via) {
    seen.add(v.inst);
    chain.push({ fn: v.label, shape: v.inst.shapeText });
  }
  const cut = (s) => (s.length > 60 ? `${s.slice(0, 60)}…` : s);
  const seg = (c) => `\`${c.fn}\` を形 ${cut(c.shape)} で`;
  const J = "呼んだ実体の本体で、";
  const named =
    chain.length > 4
      ? `${chain.slice(0, 3).map(seg).join(J)}${J}…（ほか ${chain.length - 4} 段）…、${seg(chain[chain.length - 1])}`
      : chain.map(seg).join(J);
  const e = new OperationError(`括りの関数 ${named}呼んだ実体の本体が、門に当たりました（R25：呼んだ行で断る）。${e0.message}`, {
    spec: e0.spec,
    reason: e0.reason,
  });
  e.gate = e0.gate;
  e.guard = e0.guard; // 守りの断りから来た物か（refusalOf）
  e.instance = chain[0];
  e.instances = chain;
  return e;
}

// 中身の見える器（字面の括り・`,` の並び・構築の並び）の要素の種類。見えなければ null。
function visibleElements(tree) {
  if (!tree) return null;
  const one = vanishedOne(tree); // 余ったラムダは消える（vanishedOne の注）
  if (one) return visibleElements(one);
  if (tree.t === "construct") return liveItems(tree.items).map(elementKind);
  if (tree.t === "op" && tree.sym === ",") {
    const out = [];
    let t = tree;
    while (t && t.t === "op" && t.sym === ",") {
      out.push(elementKind(t.left));
      t = t.right;
    }
    out.push(elementKind(t));
    return out;
  }
  if (tree.t === "leaf" && tree.cat === "plain" && tree.desc.elements && tree.term && tree.term.type === "atom" && !tree.term.pre.length && !tree.term.post.length) {
    return tree.desc.elements;
  }
  // `'` で引いた物（R26）と `[' 0] xs` の適用は、形が見えれば要素も持つ。ここで見ないと、中身に関数の見える欄を
  // 引いて撒く形（`[m ' greet]~`）が、形では関数が見えるのに撒く項の門を素通りする。
  if ((tree.t === "leaf" && tree.cat === "plain" && tree.term && tree.term.type === "infix") || tree.t === "apply") {
    return tree.kind.k === "A" && tree.kind.elements ? tree.kind.elements : null;
  }
  return null;
}

// 器の1つの要素の種類。要素が A でも、それ自体が中身の見える器なら中身まで見て、L か未知があれば未知に数える。
// 構築の値を平らにするか（§5 Q12）が決まっていないので、`[fs 1]~` は平らにすれば `fs` の中の関数を撒く。
// 1段だけ見ると、ここを素通しする（§3.3 の手順1「中身に L か未知が見えるもの → G7」）。欄（`k : inc`）は、
// 行の種類は A でも中身は右辺なので、右辺を見る。
function elementKind(node) {
  if (!node) return "U";
  if (node.t === "op" && node.sym === ":") return elementKind(node.right);
  if (node.kind.k !== "A") return node.kind.k;
  const inner = visibleElements(node);
  return inner && inner.some((k) => k !== "A") ? "U" : "A";
}

// ---------------------------------------------------------------------------
// 項の種類（§2、手順の 0）
// ---------------------------------------------------------------------------
//
// 返す物：{cat, desc, view, isLambdaName?, isQBracket?}
//   cat：'plain'（ふつうの葉）・'unit'（書いた `_`＝印）・'hole'（括らない `!_`＝穴）・'input'（前置 `@`）・'ptilde'（前置 `~`）
//   印と穴は位置で読みが決まる（§3.5、markStep・tryHole）ので、葉の desc は未知にしておく。決まった所でだけ A（印）か L（恒等射）にする。

function classify(term, ctx) {
  if (term.type === "infix") return classifyInfix(term, ctx);
  const { pre, core, post } = term;
  const view = { v: "atom", text: writeTerm(term) };
  const plain = (desc, extra = {}) => ({ cat: "plain", desc, view, ...extra });

  if (pre.length === 0 && post.length === 0) {
    switch (core.c) {
      case "lit":
        // 文字列の字面は List（R24。String ≅ List(Char)）。要素は文字で、文字は Int と同じ扱いの数（README の法則 B）。
        // 番地の字面は数でない（SCALAR の注）ので中身の見えない A。ほかは数・文字の字面（litDesc）。
        return plain(litDesc(core));
      case "unit":
        return { cat: "unit", desc: U(), view };
      case "name": {
        const desc = lookup(core.name, ctx);
        return plain(desc, { isLambdaName: isLambdaName(core.name, ctx), count: valueCountOf(core.name, ctx), strCount: stringCountOf(core.name, ctx) });
      }
      case "bracket": {
        const b = bracketInfo(core, ctx);
        return { cat: "plain", desc: b.desc, view: { ...view, inner: b.trees }, isQBracket: b.isQ };
      }
      case "abs":
      case "norm": {
        const a = enclosureInfo(core, ctx);
        return { cat: "plain", desc: a.desc, view: { ...view, inner: a.trees } };
      }
      case "indent": {
        const b = blockInfo(core, ctx);
        return { cat: "plain", desc: b.desc, view: { v: "block", rows: b.trees } };
      }
    }
  }
  // `$` が前に付いた項は、`$` の先を1つの関数と言い切れるときだけ値（関数を物にした番地。§2、96）。言い切れなければ G20（classifyDollar）。
  if (pre[0] === "$" && core.c !== "indent") return classifyDollar(term, ctx, plain);
  // 前置 `@`：種類は並びの位置で決まる（§2、G6）。
  // R49（2026-10-24）：x の desc が関数を指す番地の印（ref）を持てば、`@x` はその関数そのもの（L、口の数が分かる。前置 `@` の
  // 項ではないので G6 にも当たらない）。印が無ければ今までどおり（入力の項）。
  // R60（2026-10-25）：x の desc が値を読む参照の印（vref）を持てば、`@x` は指す値を読む（`@p` は p が指す値。開いた後の並びは今の規則のまま）。
  if (post.length === 0 && pre.length === 1 && pre[0] === "@" && (core.c === "name" || core.c === "bracket")) {
    const pd = pointedDesc(core, ctx);
    const d = refOf(pd);
    if (d) return plain({ k: "L", fn: d.ref });
    const v = vrefOf(pd);
    if (v) return plain(v.vref);
    // 番地の算術で作った点・差（R62）を開く：ずらした点が指す物は、差が指す物の要素の幅の倍数かと一緒に型の段で決まるので、解決器の段では分からない。
    // 差は位置ではないので読めない。印の無い前置 `@`（入力の項）に倒さずに断る（§5 Q66）。
    if (addrOf(pd)) throw refuseOpenAddress(writeTerm(term), pd);
    return { cat: "input", desc: { k: "L", fn: { type: "input" } }, view };
  }
  // 後置 `~`（撒く項）。
  if (pre.length === 0 && post.length === 1 && post[0] === "~") return classifySpread(term, view, ctx);
  // 前置 `~`：1項の並びなら項として残し、2項以上なら G4。
  if (post.length === 0 && pre.length === 1 && pre[0] === "~") {
    touchCore(core, ctx);
    return { cat: "ptilde", desc: U(), view };
  }
  // 括らない `!_`：穴（その口の恒等射、§3.5）。読みは位置で決まる（口の中は穴：tryHole・holeRefusal、口の外は恒等射：holeStep、R44・R46）。
  if (post.length === 0 && pre.length === 1 && pre[0] === "!" && core.c === "unit") return { cat: "hole", desc: U(), view };
  // 値の演算子の印：A の核なら A、L・未知・`_` の核なら未知（§2、Q22）。
  if (pre.every((p) => VALUE_PREFIX.has(p)) && post.every((p) => p === "!")) {
    if (core.c === "unit") return plain(U());
    const inner = classify({ type: "atom", pre: [], core, post: [] }, ctx);
    // 値の印（前置 `-`・`!!`・後置 `!`）は値の演算子：核が関数を指す番地なら G7、番地の点・差なら G21（R62、§5 Q66）、素の関数の裸の仮引数なら札に覚える（R60 の細かい所。
    // valueOperand）。前置 `!` だけの項（`!p`）は否定で、値の演算子ではないので今のまま。
    const mark = pre.find((p) => p !== "!") || (post.length ? "!" : null);
    if (mark && inner.cat === "plain") valueOperand(inner.desc, mark, () => inner.view.text);
    if (!(inner.cat === "plain" && inner.desc.k === "A" && !inner.desc.spread)) return plain(U());
    // 数に値の印を当てても数（SCALAR の注）。ただし前置 `!` は外す：`!_` は恒等射（穴、§3.5）で、`_` でない物に当てると
    // `_` になる。だから `!x` は数にならず、x が `_` になる物（`1 < 0`・`/ 0`）なら関数になる。数と読むと、
    // `f !(1 < 0)` の実体で `h 5` を黙って構築と読む。
    return plain(isScalar(inner.desc) && !pre.includes("!") ? scalarDesc() : A());
  }
  // 後置 `@`（取り込み）・前置 `#`・表に無い印の組み合わせ（`@f~` など。`$` が前に付いた項は、印の組み合わせに依らず上の `$` の枝
  // classifyDollar で決める）は未知（§2、G7）。
  touchCore(core, ctx);
  return plain(U());
}

// ---- `$` の先は1つの関数（R53・R54〜R57、G20） ----
//
// `$X` は、X を書いた所で1つの関数と言い切れるときだけ値（関数を物にした番地、A）。言い切れなければ G20（refuseDollar）。
// 根拠：U [2026-10-24 16:52 8dfc006e]「そもそも、$が指定できるのは、一つの関数だと言い切れることが条件。」。主の Claude はこの条件で通す物と断る物を
// 分け、「この条件（`$` の先は1つの関数と言い切れること）で入れていい？」と訊いた（16:53 UTC）。続く U [2026-10-25 00:08 8dfc006e]「_は、実は、
// [x ? _] と同じだから / $_ は $[x ? _]」。主の Claude は、並びの中の `_` は余積の単位の顔で、`$` で物にする所で関数の顔（零射）が出る、と読み、
// 「この読みで、`$` の条件（1つの関数と言い切れること）と一緒に入れていい？」と訊いた（00:09 UTC）。U〔答え〕[2026-10-25 00:25 8dfc006e]
// 「正確にはそうなるね。 / 圏論は準同型しか見てないから、すごく大雑把なところがあるのは認める。 / $!_ も同じ理屈で、$に渡せる。 / 後はすべて君の言う通り。」。
// 2026-10-24 の R53（`$` は関数だけを運ぶ）は種類が L かだけを見ていた。この片（2026-10-25）で、言い切れる物を足し（R54 局所の定義、R55 別名の印、
// R56 `$_` は零射、R57 `$` とほかの前置の印の組み合わせで先が関数の物）、言い切れない形（後置の印の付いた物）を断る側に決めた（R57）。
// - 後置の印（`~`・`!`・`@`）が付いた項（`$vs~`・`$inc~`・`$fs~`・`$inc!`・`$5!`・`$x@`・`$!_~`）：`$` と後置の印のどちらが先に結ぶ読みでも、
//   1つの関数と言い切れない（撒いた形は並びで、`!` は値の印、`@` は取り込み）。前（R53）は、核が関数か読みの先が門に当たる物（`$inc~`・`$fs~`・
//   `$inc!`）を表に無い組み合わせの未知にして、根・`,` の辺・`:` の右辺では通していた（§5 Q55）。
// - 書いた `_` の `$_`：`$[x ? _]`（零射。何を受けても `_` を返す1引数の関数）を物にした番地（R56）。指す関数の印（R49）は ZERO_FN。
//   名前・括りを通して書いた `_` を指す物（`$[_]`・`$[[_]]`・`q : _` ⏎ `$q`・`q : _` ⏎ `$[q]`）も同じ（[x] ≅ x、`:` はメタで名前は右辺を指す。
//   pointsToMark）。並びの中の `_` は今までどおり余積の単位（R15）で、`_` を `[x ? _]` と読むのは `$` で物にする所だけ。`_` を指すかは desc に
//   入れず（入れると実体の鍵が見ない印が実体を跨いで分け合われる）、書いた所の木と名前の定義で見る。括りの関数の実体で仮引数に `_` が
//   渡った名前（`h : [s] ? $s` ⏎ `h [s : _]`）は、渡された物の desc だけを見るので今のまま G20（断る側）。
// - `$!_` は恒等射を物にした番地（今までどおり A）。U〔答え〕[2026-10-25 00:25 8dfc006e]「$!_ も同じ理屈で、$に渡せる。」。指す関数の印（R49）は
//   1引数の恒等射 `[x ? x]`（ID1_FN。`$_` が `[x ? _]` の ZERO_FN なのと対）。恒等射の別名（`i : !_` の `$i`、局所の `h : !_` の `$h`、`$[i]`・
//   `$[i , !_]`）も同じ印（下の isRowIdentity。i 自身の種類は、R29 の並び全体を受ける恒等射のまま）。2026-10-25 の §5 Q56 の答え：主の Claude の問い
//   「…Q56 は `$!_` が `[x ? x]` を指す、でいい？」（07:29 UTC）に U〔答え〕[2026-10-25 07:34 2772473e]「そうか分かった！ map : f [~l] ? [@f,] l~ に
//   対して、 map $!_ .. と map $[!_] .. で分かれる。 安心した。」。`map $!_ vs` は恒等射の写像で vs、`map $[!_] vs` は否定の写像（`[!_]` は否定の
//   点なし）。その前（R54〜R57 の片）は、並び全体を受ける恒等射か1引数かが決まっていないので印を付けず、開いた所の `@f` は口の数の分からない
//   前置 `@` の項だった（`map $!_ vs` は実体の `[@f,]` で G7、`map2 $!_ vs` は G19）。作る途中の版は並び全体を受ける恒等射の印を付けていて、
//   `tw : f [~r] ? @f 1 2` ⏎ `tw $!_ vs` の実体が `(apply @f (construct 1 2))` と決まり、`tw $[x ? x] vs` の `(construct (apply @f 1) 2)` と黙って
//   割れていた（同じ日の確かめの指摘）。今は `$[x ? x]` と同じ答え（法則18）。
// - 名前：dollarNameTarget。括り：中身を解いた種類（遅延した式、§5 Q52 の答え）。前置の印がほかにもある（`$$inc`・`$@f`・`$-inc`）か、核が字面・
//   囲み（`$5`・`$||inc||`）：`$` の先は残り全部（前置の印は核に近い物から結ぶ）で、それが L なら通す（R57。指す関数の印も付ける）。
// - R59（2026-10-25、§5 Q53 の答え）：`$[…]` の中身のどこか（入れ子の括り・囲み・欄・`?` の本体を含む）で、値の上に積まれて口が開いたまま閉じた関数
//   （R52 の余ったラムダ。恒等射を除く）があれば、中身は2つの関数を括った形で1つの関数と言い切れないので G20（`$[add (5 inc)]`・`$[x ? x inc]`）。中身を
//   解く所に受け皿（ctx.dead）を置き、余ったラムダを `_` にした所（leftoverUnit）で拾う。名前の先（`p : add (5 inc)` ⏎ `$p`）も、名前は右辺を指す
//   （`:` はメタ）ので、右辺・本体で同じに拾う（dollarNameTarget、deadOfDef。断る側に倒した細かい所、§5 Q62）。中身から名前で指した別の定義の中は
//   見ない（その定義の行で知らせる）。同じ日の確かめの直しから、中身が単位律と [x] ≅ x で名前1つに縮むなら、その名前の物を引き継ぎ（aliasDeadOfTree）、
//   括りの関数の本体（R25：呼ばれるまで読まない）は仮引数を含まない行だけを読み（deadInPatternBody、§5 Q65）、名前の先の本体を覗くのは木を残す段だけ
//   （deadOfDef の注）。
//   根拠：主の Claude「`$[add (5 inc)]` の中身には add と inc の2つの関数がある。…`$[…]` の中のどこかで値の上に積まれて余る関数があれば、中身は
//   1つの関数と言い切れないので G20 で断る。…これで Q53 を閉じる、でいい？」（2026-10-25 07:43 UTC）。その前に U [2026-10-25 07:42 533071da]
//   「Q53は、逆適用が無くなったから危険な形式になったと思う。多分2つの関数を$で括ってるよね？」、答えは U〔答え〕[2026-10-25 07:48 533071da]
//   「Q53はそれで閉じれる。大丈夫！」。前（R52 の片の読み (1)）は、中身の項の中に今のまま R52 を当てて書いた所で知らせ、通していた。
// - R60（2026-10-25、§5 Q54 の答え）：`$` は Reader と Writer を作る接頭辞で、`$名前`（名前が値）・`$[…]`（中身が値）・`$5`（字面）は、その値を読み書きする
//   参照（1つの Reader）として通す（A。指す値の desc を印 vref に持つ。`@x` は指す値を読む）。`$` の先は「1つの Reader（関数か、値を読む参照）と言い
//   切れること」で、言い切れない物（取り込みの名前・枝で選ぶ物・種類が未知・撒いた形・後置の印）は今のまま G20。番地は読む環境の実装の1つで、
//   番地の計算は意味に出ない。Reader は数ではないので、値の演算子の被演算子にする形（`$vs - $vs`・`$x + 1`・`$x == $y`）は名指しで断る（G7、
//   refuseReaderOperand、§5 Q59。同じ日の確かめの直しから、区間・点なし・絶対値・値の印・素の関数の口の綴りでも、valueOperand・readerAtPlain）。
//   → 2026-10-26 の R62（§5 Q59 の答え）から、値を読む参照は番地の点で、中置の `+`・`-`・比べは点と差の規則で読む（addressOp）。断るのは G21。関数を
//   指す番地は今のまま G7。
//   同じ日の確かめの直しから、形の見えない値で中身に関数か未知が見える物（枝で選ぶ括り `$[5 > 1 : inc]`、形の綴り `A(U)`）と、括りの関数の実体で
//   渡された形の見えない値の名前（`h [s : _]` の `$s`、§5 Q64。dollarNameTarget）は G20。→ 2026-10-26 の R63（§5 Q64 の答え）から、書いた `_` と
//   分かる値（印 zero）は零射の番地で通る。印の無い形の見えない値は今のまま G20。
//   根拠：U [2026-10-25 07:51 533071da]「よく考えるんだ。 / $ は Reader と Writer のための単なる接頭辞として、それが偶々アドレスを渡すと読むと同じ読みが
//   出来るだけと読み替えるとおもしろいはずだ。」。主の Claude の問い「`$` を Reader と Writer を作る接頭辞と読み替えて、`$値` も参照として通す（Q54 は
//   これで閉じる）、でいい？」（07:57 UTC）に、U〔答え〕[2026-10-25 08:37 533071da]「それで不都合が起きなければ。 / 細かい問題が起きるなら、もう一度
//   圏論的な視点を。」。Reader は環境 S から読む S ⇒ A、番地は環境をメモリ・番地を鍵にした実装の1つ、`@` は読む（ask）・`#` は書く（Writer の tell・
//   State の put）、という読みは主の Claude の物。前（R53〜R57）は「`$` の先は1つの関数と言い切れること」で、値の先は G20 だった。
function classifyDollar(term, ctx, plain) {
  const { pre, core, post } = term;
  if (post.length) throw refuseDollar(term, null, ctx, { where: "post" });
  if (pre.length === 1 && core.c === "unit") return plain({ k: "A", ref: ZERO_FN });
  if (pre.length === 2 && pre[1] === "!" && core.c === "unit") return plain({ k: "A", ref: ID1_FN });
  let target;
  const named = pre.length === 1 ? bracketedName(core) : null;
  if (named) target = { ...dollarNameTarget(named, ctx), name: named };
  else if (pre.length === 1 && core.c === "bracket") {
    // 中身が1項だけで、その項に後置の印が付いている（`$[vs~]`・`$[5!]`・`$[[x@]]`）：[x] ≅ x で、括らない `$vs~`・`$5!` と同じ先（R57 の G20）。R60 で
    // 値の先が通るので、ここで見ないと、括った綴りだけが値の参照で通り、括らない綴りの G20 と割れる（法則17 の (a')）。
    const marked = postMarkedInside(core);
    if (marked) throw refuseDollar(term, null, ctx, { where: "post", inner: marked });
    const dead = [];
    const b = bracketInfo(core, { ...ctx, dead }, true);
    // 中身が単位律（R44・R45・R61）と [x] ≅ x で項1つに縮むなら、その項で見る（2026-10-25 の確かめの直し）：後置の印の付いた項・撒いた形の名前に
    // 縮む中身（`$[vs~ , _]`・`$[5! , !_]`・`w : vs~` ⏎ `$[w , !_]`）は、`$[vs~]`・`$[5!]`・`$w` と同じ G20（R57）。名前1つに縮む中身（`$[p , !_]`・
    // `$[_ , p]`・`$[!_ p]`・`i : !_` ⏎ `$[i p]`）は、`$p` と同じく名前の先の余る関数を引き継ぐ（R59、§5 Q62）。前は書いた字面の1項（postMarkedInside）と
    // 名前1つの字面（deadOfAlias）だけを見て、縮む綴りが値の参照で通った（確かめの指摘）。
    const one = b.trees.length === 1 ? unitReduced(b.trees[0]) : null;
    const leafTerm = one && one.t === "leaf" && one.term && one.term.type === "atom" ? one.term : null;
    if (leafTerm && leafTerm.post.length) throw refuseDollar(term, null, ctx, { where: "post", inner: leafTerm });
    if (one && one.kind && one.kind.k === "A" && one.kind.spread) throw refuseDollar(term, one.kind, ctx, { where: "spread" });
    // 中身が名前1つに縮み、その名前が括りの関数の実体で渡された形の見えない値なら、`$名前` と同じ G20（`$[s , !_]`・`$[_ , s]` は `$s`。2026-10-26 の R63 の片で
    // 見つけた：R60 の確かめの片は名前1つの綴り `$s`・`$[s]` だけを断り、縮む綴りは値を読む参照で通っていた。書いた `_` と分かる値は下の zero で零射）。
    const oneName = one && one.t === "leaf" && one.term && one.term.type === "atom" && !one.term.pre.length && !one.term.post.length && one.term.core.c === "name" ? one.term.core.name : null;
    if (oneName && instOpaqueName(oneName, ctx)) throw refuseDollar(term, U(), ctx, { where: "inst-opaque", name: oneName });
    // 書いた `_` を指すか（R56）は、木で見る（pointsToMark）か、中身の desc の印 zero で見る（R63。括りの関数の実体の中の `$[s , !_]` の s は、名前の木では
    // 見えない）。
    target = {
      kind: b.desc,
      unit: (b.trees.length === 1 && pointsToMark(b.trees[0], ctx)) || !!zeroOf(b.desc),
      dead: dead[0] || (one ? aliasDeadOfTree(ctx.F, one, ctx.scope) : null),
    };
  } else {
    const inner = classify({ type: "atom", pre: pre.slice(1), core, post: [] }, ctx);
    target = { kind: inner.cat === "plain" ? inner.desc : U() };
  }
  if (target.dead) throw refuseDollar(term, target.kind, ctx, { ...target, where: "dead" });
  if (target.unit) return plain({ k: "A", ref: ZERO_FN });
  const kind = target.kind;
  // 撒いた形を指す名前（`w : vs~` の `$w`）は、R57 の撒いた形と同じく1つの Reader と言い切れない（G20）。
  if (kind && kind.k === "A" && kind.spread) throw refuseDollar(term, kind, ctx, { ...target, where: target.where || "spread" });
  // 形の見えない値で、中身に関数か未知が見える物（形の綴り `A(U)`。枝で選ぶ括り `$[5 > 1 : inc]`・欄と値の混ざった行）は、種類が未知の物と同じく1つの
  // Reader と言い切れない（G20。2026-10-25 の確かめの直し：枝の行の括りは前段で A(U) に分けられ、値なら通す R60 に乗って抜けていた。同じ枝の
  // `$[1 > 0 & inc | double]` は種類が未知で G20）。形の見える器（`$fs`・`$(inc , 1)` の `$[U…]`）は値を読む参照で通す。
  if (kind && kind.k === "A" && !kind.shape && !readerOf(kind) && deepKind(kind) !== "A") throw refuseDollar(term, kind, ctx, { ...target, where: target.where || "mixed" });
  // R60：先が値なら、その値を読む参照（1つの Reader）。
  if (kind && kind.k === "A") return plain({ k: "A", vref: kind });
  if (!kind || kind.k !== "L") throw refuseDollar(term, kind, ctx, target);
  // 指す関数の印（R49）。2026-10-25 の R55 から、値の定義の名前（別名 `p : inc` の `$p`）にも付ける（前は覗いた物だけで、別名には付けなかった。§5 Q45）。
  // 恒等射（`i : !_` の i）の印は、`$!_` と同じ1引数の恒等射（上の `$!_` の注、§5 Q56 の答え）。
  return plain(kind.fn ? { k: "A", ref: isRowIdentity(kind.fn) ? ID1_FN : kind.fn } : A());
}

// 並び全体を受ける恒等射の fn（R29。穴 `!_` 1つ・`i : !_`・局所の `h : !_`・`[i , !_]` の中身）。`$` で物にした所では、指す関数を1引数の恒等射
// `[x ? x]`（ID1_FN）にする（§5 Q56 の答え、2026-10-25）。2026-10-25 の R54〜R57 の片では、ここで印を付けなかった（isHeldIdentity）。
function isRowIdentity(fn) {
  return !!fn && fn.type === "id";
}

// `$` の先が名前1つか、名前1つを1行で括った物（`[sq]`・`[[sq]]`・`(sq)`）なら、その名前。[x] ≅ x なので `$[N]` は `$N` と同じ先を見る
// （2026-10-25 の R54 から。括りの中を解いて引くと、局所の名前は lookup で未知になり、`$sq` は通るのに `$[sq]` は G20 と割れる。この片の作る途中に
// 見つけた）。1行が名前1つの括りには局所の名前が無い（`:` の行が無い）ので、括りの範囲も外と同じ。
function bracketedName(core) {
  if (core.c === "name") return core.name;
  if (core.c !== "bracket" || core.rows.length !== 1) return null;
  const row = core.rows[0];
  if (!row || row.type !== "seq" || row.terms.length !== 1) return null;
  const t = row.terms[0];
  return t.type === "atom" && !t.pre.length && !t.post.length && (t.core.c === "name" || t.core.c === "bracket") ? bracketedName(t.core) : null;
}
// 括りの中身が1行で、その行が項1つで、その項（1行の括りを開いた先も）に後置の印（`~`・`!`・`@`）が付いていれば、その項（R57・R60）。ほかは null。
function postMarkedInside(core) {
  if (core.c !== "bracket" || core.rows.length !== 1) return null;
  const row = core.rows[0];
  if (!row || row.type !== "seq" || row.terms.length !== 1) return null;
  const t = row.terms[0];
  if (t.type !== "atom") return null;
  if (t.post.length) return t;
  return !t.pre.length && t.core.c === "bracket" ? postMarkedInside(t.core) : null;
}

// `$_` が指す関数（R56）：`[x ? _]` の零射。口は1つで、何を受けても本体は書いた `_`（印＝値、本体の根は A。`[x ? _] 5` は A）。
// 出どころ（idKey）は綴りの無い定数で、書いた `$[x ? _]` とは実体の鍵が別になる（答えの木は同じ。法則18）。
const ZERO_FN = { type: "plain", origin: "plain", n: 1, getBodyRoot: () => "A", idKey: "零射[x ? _]" };
// `$!_`（と恒等射の別名の `$i`）が指す関数（§5 Q56 の答え、2026-10-25）：1引数の恒等射 `[x ? x]`。口は1つで、本体は受けた裸の仮引数（素の関数の
// 裸の仮引数は A、本体の根は A。書いた `[x ? x]` と同じ）。出どころ（idKey）は綴りの無い定数で、書いた `$[x ? x]` とは実体の鍵が別になる（答えの
// 木は同じ。法則18）。
const ID1_FN = { type: "plain", origin: "plain", n: 1, getBodyRoot: () => "A", idKey: "恒等射[x ? x]" };

// 解いた木が、書いた `_` を指すか（R56）：書いた `_` の葉（印）、それを1行で括った物（`[_]`・`[[_]]`。中の行が `_` に縮む `[_ _]`・`[_ , !_]` も）、
// 書いた `_` を右辺に持つファイルの値の定義（F.unitDefs、nameKindOf が置く）。局所の定義の名前そのものの `$w`（`w : _`）は localTarget が右辺で見る。
// 木の中に裸で書いた局所の名前（局所の別名 `v : w` の右辺の w、`v : [w]` の中の w）は、ここでも辿らない：裸で書いた局所の名前は lookup で
// 種類を決めない（§5 Q10）ので、`w : inc` ⏎ `v : w` の `$v` は未知で G20。辿ると `w : _` ⏎ `v : w` の `$v` だけが零射で通り、同じ形が右辺で割れる。
// 2026-10-25 の作る途中の版は辿っていて、局所の別名どうしの輪（`w : v` ⏎ `v : w` ⏎ `$v`・`[w : w ⏎ $w]`）では localTarget と互いに呼び合って
// JS のスタックが溢れていた（同じ日の確かめの指摘）。
function pointsToMark(t, ctx) {
  if (isMark(t)) return true;
  if (!t || t.t !== "leaf" || !t.term || t.term.type !== "atom" || t.term.pre.length || t.term.post.length) return false;
  const c = t.term.core;
  if (c.c === "bracket") return !!t.view && Array.isArray(t.view.inner) && t.view.inner.length === 1 && pointsToMark(t.view.inner[0], ctx);
  if (c.c !== "name") return false;
  for (let s = ctx.scope; s; s = s.parent) {
    if ((s.descs && s.descs.has(c.name)) || (s.params && s.params.has(c.name))) return false;
    if (s.locals && s.locals.has(c.name)) return false;
  }
  const def = ctx.F.defs.get(c.name);
  return !!def && !def.lambda && !!ctx.F.unitDefs.get(def);
}

// `$名前` の先（R53・R54・R55）。返す物は {kind, where, unit}。kind は名前の種類（lookup と同じ順に探す）、where は G20 の言い分のための出どころ、
// unit は書いた `_` を指す名前か（R56）。
// - 仮引数・実体の中で渡された物：今の desc（素の関数の裸の仮引数は A、括りの関数の実体では渡された物の生まれ、R24）。
// - 局所の名前（括り・本体の中の `:` の左の名前）：localTarget（R54）。
// - ファイルの定義：nameKindOf（`?` なら L、ほかは右辺を解いた種類。値を含む輪は name-cycle、R53）。
// - 取り込みのある範囲の未定義の名前は未知（このファイルから中身が見えない）、未定義の名前は値（R21、information を出す）。
// - 関数の本体の範囲で、その範囲の行に左がその名前1つの `:` があるのに、名前が仮引数かファイルの定義で局所の名前に数えない（scanLocals）なら、未知で
//   G20（"local-shadow"。括りの範囲には defRows が無いので見ない、blockScope の注）。R54 の読みではその行は局所の定義で外の名前を隠すが、隠しを通すかは決まっていない（§5 Q10 の「名前の隠し」、P2 の
//   name-shadow は仮引数だけを見る）。前（HEAD b08feb4f から）は、`tt : x ?` ⏎ `\tinc : z ? z * z` ⏎ `\tmap $inc x` の `$inc` が黙ってファイルの inc
//   を指し、本体の行は何にも使われなかった（2026-10-25 の確かめの指摘）。
function dollarNameTarget(name, ctx) {
  let imported = false;
  for (let s = ctx.scope; s; s = s.parent) {
    if (s.defRows && localDefsOf(s).shadow.has(name)) return { kind: U(), where: "local-shadow" };
    if (s.descs && s.descs.has(name)) {
      // 括りの関数の実体で渡された、形の見えない値（`h : [s] ? $s` ⏎ `h [s : _]` の s・`[x ~xs]` で受けた `[un 5]` の要素・値を受けた裸の仮引数）：渡された
      // 物が書いた `_` なら R56 の零射の番地、ほかの値なら値を読む参照で、desc からはどちらか言い切れない（R56 の R の所が「断る側への割れ」として G20 に
      // 残していた形。R60 の片で値を読む参照として通り、`rd1 $s 0` の実体が `(construct @f 1)` で、同じ `_` の `rd1 $_ 0` の `(apply @f 1)` と割れていた。
      // 2026-10-25 の確かめの指摘、§5 Q64）。形の見える値（`{s:N}`・`[N…]`）と番地・参照は今のまま通す。
      // 2026-10-26 の R63（§5 Q64 の答え）：渡された物が書いた `_` と分かっていれば（印 zero：欄の `[s : _]`・`[s : un]`・`[s : [_]]`、要素が全部 `_` の
      // List、`_` を指す名前を受けた裸の仮引数）、`$_` と同じ零射 `$[x ? _]` の番地（`@f 1` は零射を当てた `_` で、`_ 1` の並びではない）。印の無い形の
      // 見えない値は、今のまま `_` か言い切れない（G20）。番地の算術で作った点・差（R62）は `_` でないので、値を読む参照で通る。
      const d = s.descs.get(name);
      if (zeroOf(d)) return { kind: d, unit: true };
      if (isInstOpaque(d)) return { kind: U(), where: "inst-opaque" };
      return { kind: d };
    }
    if (s.params && s.params.has(name)) return { kind: s.params.get(name) === "bare" ? A() : U() };
    if (s.locals && s.locals.has(name)) return localTarget(name, s, ctx);
    if (s.hasImport) imported = true;
  }
  const def = ctx.F.defs.get(name);
  if (def) {
    const kind = nameKindOf(ctx.F, def);
    return { kind, unit: !def.lambda && !!ctx.F.unitDefs.get(def), dead: deadOfDef(ctx.F, def) };
  }
  if (imported) return { kind: U(), where: "imported" };
  reportUndefined(name, ctx);
  return { kind: A(), where: "undefined" };
}

// 括りの関数の実体で渡された、形の見えない値の desc（§5 Q64。`$` の先にすると G20）：形も番地・参照・点と差の印も、書いた `_` を指す印（R63）も無い A。
const isInstOpaque = (d) => !!d && d.k === "A" && !d.shape && !d.ref && !d.vref && !d.addr && !d.spread && !zeroOf(d) && !isEmptyBracket(d);
// 名前 name が、いちばん近い範囲で括りの関数の実体に渡された形の見えない値か（dollarNameTarget と同じ順に探す。仮引数・局所の名前が先に見つかれば違う）。
function instOpaqueName(name, ctx) {
  for (let s = ctx.scope; s; s = s.parent) {
    if (s.defRows && localDefsOf(s).shadow.has(name)) return false;
    if (s.descs && s.descs.has(name)) return isInstOpaque(s.descs.get(name));
    if ((s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return false;
  }
  return false;
}

// ファイルの定義の右辺（値の定義）か本体（素の `?` の定義と、既定値のある `?` の定義）に、値の上に積まれて口が開いたまま閉じた関数（R52 の余った
// ラムダ。恒等射を除く）があれば、その木（R59、`$名前` が `$[右辺]` と同じ先を見るため。§5 Q62）。無ければ null。
// - 値の定義：nameKindOf が右辺を解くときに受け皿で拾い、F.deadDefs に置く。右辺が名前1つ（`p : q`・`p : [q]`）なら、その名前の物を引き継ぐ（[x] ≅ x、
//   `:` はメタ。右辺の名前は lookup で別の定義として解くので、受け皿には入らない）。
// - 素の `?` の定義：bodyRootOf が本体を解くときに拾い、F.deadBodies に置く（記録が古くなれば解き直すので、同じ答えになる）。
// - 既定値のある `?` の定義：本体の根を解く所が無いので、ここで本体を解いて拾う（門に当たれば、その定義の行が同じ門で断るので null）。
// - 括りの関数（R24）：本体は呼ばれるまで読まない（R25）。仮引数の名前を1つも含まない行だけは、どの実体でも同じに読むので読んで拾う
//   （deadInPatternBody。2026-10-25 の確かめの直し、§5 Q65）。
// 関数の定義の本体を覗くのは、解いている途中の種類が無い所（F.stack が空）だけ（2026-10-25 の確かめの直し）：`$` は名前の先を評価しないので、値の
// 定義の右辺を解いている途中に本体を覗くと、`p : $sq` ⏎ `sq : x ? use p x`（`$` で自分を指す表を持つ再帰）が、覗いた所を通る輪で name-cycle になった
// （R59 の片の書く人の版。HEAD は通す）。途中の所で覗かなくても、`$名前` の書かれた所は、どれも木を残す段（定義の行・行の根・実体の木、F.stack が空）で
// もう一度解かれるので、そこで同じ G20 に当たる（R33 の G16 を木を残す段で断るのと同じ作り）。
// 値の定義は、名前の種類を引くときに右辺を解く（R53 から、輪に数える）ので、右辺の余る関数はいつも拾う。右辺が単位律と [x] ≅ x で名前1つに縮むなら
// （`q : p`・`q : [p]`・`q : p , !_`・`q : _ , p`）、その名前の物を引き継ぐ（aliasDeadOfTree）。
function deadOfDef(F, def) {
  if (!def.lambda) {
    nameKindOf(F, def);
    const own = F.deadDefs.get(def);
    if (own) return own;
    if (F.deadBusy.has(def)) return null; // 別名の輪（`p : q` ⏎ `q : p` は name-cycle で、ここには来ない。守りだけ）
    F.deadBusy.add(def);
    try {
      return aliasDeadOfTree(F, F.defRoots.get(def), F.fileScope);
    } finally {
      F.deadBusy.delete(def);
    }
  }
  if (F.stack.length) return null;
  const op = def.lambda;
  if (def.pattern) {
    if (!F.deadBodies.has(op)) F.deadBodies.set(op, deadInPatternBody(F, op, F.fileScope));
    return F.deadBodies.get(op) || null;
  }
  if (def.plain) {
    bodyRootOf(F, op);
    return F.deadBodies.get(op) || null;
  }
  if (F.deadBusy.has(op)) return null; // 本体の中から自分を `$` で指した（本体を解き終えた外側が拾う）
  F.deadBusy.add(op);
  // 本体を解く間は枠を積む（実体を作っても、木の記録に入れない。deadInPatternBody と同じ）。
  const frame = pushFrame(F, { probe: op });
  try {
    const dead = [];
    const lam = makeLambda(op, { F, scope: F.fileScope });
    resolveBody(op.right, { F, scope: lam.scope, diag: null, dead });
    return dead[0] || null;
  } catch (e) {
    if (!isGate(e)) throw e;
    return null;
  } finally {
    abortFrame(F, frame);
    F.deadBusy.delete(op);
  }
}
// 解いた木 t が単位律（R44・R45・R61）と [x] ≅ x で縮んだ項（`p !_`・`!_ p`・`i p`・`[p]`・`(p)` は p。`,` の単位は resolveProduct が先に消す）。
function unitReduced(t) {
  for (;;) {
    if (!t) return t;
    const one = vanishedOne(t);
    if (one) {
      t = one;
      continue;
    }
    if (t.t === "apply" && isIdentity(t.head) && t.arg && t.arg.t !== "construct") {
      t = t.arg;
      continue;
    }
    // 恒等射との合成（`p !_`・`!_ p`・`i p` で p が関数）：恒等射を消して1つだけ残れば、それ（単位律、R44）。
    if (t.t === "compose" && Array.isArray(t.items)) {
      const live = t.items.filter((x) => !isIdentity(x));
      if (live.length === 1 && live.length < t.items.length) {
        t = live[0];
        continue;
      }
    }
    if (t.t === "leaf" && t.term && t.term.type === "atom" && !t.term.pre.length && !t.term.post.length && t.term.core.c === "bracket" && t.view && Array.isArray(t.view.inner) && t.view.inner.length === 1) {
      t = t.view.inner[0];
      continue;
    }
    return t;
  }
}
// 解いた木 t が単位律と [x] ≅ x で名前1つ（`q`・`[q]`・`q , !_`・`_ , q`・`!_ q`）に縮み、その名前がファイルの定義を指すなら、その定義の deadOfDef
// （引き継ぎ、R59・§5 Q62）。範囲 s で仮引数・実体で渡された物・局所の名前に当たれば null（仮引数は書いた物を持たない。局所の名前を裸で書いた別名は
// R54 の G20）。前（R59 の片）は右辺の字面が名前1つのときだけ引き継ぎ、単位律で縮む綴りが通った（2026-10-25 の確かめの指摘）。
function aliasDeadOfTree(F, t, s) {
  const one = unitReduced(t);
  if (!one || one.t !== "leaf" || !one.term || one.term.type !== "atom" || one.term.pre.length || one.term.post.length || one.term.core.c !== "name") return null;
  const n = one.term.core.name;
  for (let q = s; q; q = q.parent) {
    if ((q.descs && q.descs.has(n)) || (q.params && q.params.has(n)) || (q.locals && q.locals.has(n))) return null;
  }
  const def = F.defs.get(n);
  return def ? deadOfDef(F, def) : null;
}
// 括りの関数の本体のうち、仮引数の名前を1つも含まない行（本体そのもの・括り・囲み・字下げのブロックの中の行・中置の辺）の余る関数（R59、2026-10-25 の
// 確かめの直し）。括りの関数の本体は呼ばれるまで読まない（R25）が、それは本体の読み（適用か構築か）が渡された物の生まれで決まる（R24）からで、
// 仮引数を含まない行の読みは渡された物に依らず、どの実体でも同じなので、`$` の先を見る所で読んでよい（`$[[x] ? f2 (5 inc) 1]` の `(5 inc)` は、どの x でも
// inc が 5 の上で余る）。仮引数を含む行（`$[[x] ? x inc]`）は今のまま読まない（x が関数なら合成、値なら余る。§5 Q65）。
// 読む間は枠を積んで、作った実体を木の記録に入れない（呼ばれない括りの関数の本体が呼ぶ物を、定義の行の木に描かない。外れた枠と同じに扱う）。
// 門と輪は握りつぶして（輪の言い分も戻す）、読めなかった行は拾わない。
function deadInPatternBody(F, op, scope) {
  const names = new Set();
  forEachParamNameInTree(op.left, (n) => names.add(n));
  const mentions = (t) => !!t && (t.type === "seq" ? t.terms.some(termMentions) : mentions(t.left) || mentions(t.right));
  const termMentions = (term) => {
    if (!term) return false;
    if (term.type === "infix") return termMentions(term.left) || termMentions(term.right);
    if (term.core.c === "name") return names.has(term.core.name);
    return !!term.core.rows && term.core.rows.some(mentions);
  };
  const rows = [];
  const visit = (t) => {
    if (!t) return;
    if (!mentions(t)) return void rows.push(t);
    if (t.type === "seq") t.terms.forEach(visitTerm);
    else if (t.sym !== "?") {
      visit(t.left);
      visit(t.right);
    }
  };
  const visitTerm = (term) => {
    if (!term) return;
    if (term.type === "infix") {
      visitTerm(term.left);
      visitTerm(term.right);
    } else if (term.core.rows) term.core.rows.forEach(visit);
  };
  visit(op.right);
  if (!rows.length) return null;
  const lam = makeLambda(op, { F, scope });
  const before = F.cycleRefused;
  for (const row of rows) {
    const dead = [];
    const frame = pushFrame(F, { probe: row });
    try {
      resolveTree(row, { F, scope: lam.scope, diag: null, dead });
    } catch (e) {
      if (!(e instanceof OperationError)) {
        abortFrame(F, frame);
        throw e;
      }
      F.cycleRefused = before;
    }
    abortFrame(F, frame);
    if (dead.length) return dead[0];
  }
  return null;
}

// 局所の名前の先（R54、2026-10-25）：関数の本体の範囲 s の行（入れ子の括りの中の行は入れない）に、左がその名前1つの `:` がちょうど1つ
// あれば、その右辺を、その `:` の行と同じ範囲で解いた種類（`sq : z ? z * z` は L、`q : inc`・`c : inc double`・`a : add 1`・外の仮引数を掴む
// `k : z ? z + x` も L、`v : 5` は A）。行の `:` は定義の行と同じく解く（resolveDefine の右辺。知らせは定義の行で出すので、ここは出さない）。
// 言い切れない所は未知にして G20 で断る（where に理由）：
// - 範囲が括りか、関数の本体でない字下げのブロック（"local-field"。blockScope。括りは器（構造体か2次元配列、利用者 2026-09-28）で、その行の
//   `sq : …` は欄かもしれず、局所の定義と読むかは決まっていない（§5 Q10、blockScope の注）。主の Claude が利用者に出した例は関数の本体の局所の
//   定義だけだった。2026-10-25 の作る途中の版は括りにも当てていた（同じ日の確かめの指摘）。
// - その名前の `:` が入れ子の括りの中にしか無い（"local-nested"。scanLocals は入れ子の括りの `:` の名前も外の範囲に数えるが、そこから見えるかは
//   決まっていない、§5 Q10）。
// - 範囲の行に、局所の定義と読めない `:` の行がある（"local-branch"。左が名前1つでない `x > 0 : …`・`_ : 0`、左が仮引数かファイルの定義の名前1つ
//   `x : 1`）。本体のブロックは枝が有れば match_case で（利用者 2026-09-28）、そのときの `sq : inc` は条件 sq の枝とも読める（§5 Q10「本体の中の
//   `:` が、局所の定義か枝か」）。主の Claude が利用者に出した例は、枝の無い本体（`sq : z ? z * z` ⏎ `map $sq x`）だけだった。2026-10-25 の
//   作る途中の版は、枝の行と混ざった1つの行も通していた（同じ日の確かめの指摘）。
// - 同じ範囲に2つ以上ある（"local-twice"。どれを指すか1つに決まらない。枝の条件の並びかもしれない）。
// - 右辺を解いている途中で、また同じ範囲の同じ名前を `$` で指した（"local-cycle"。自分を `$` で指す局所の関数・局所の定義どうしの輪）。ファイルの
//   `?` の定義は本体を解かずに L と分かる（nameKindOf）が、局所の `?` の定義は右辺を解いて関数の印を作るので、輪は解き終えられない。断る側に
//   倒した（実装する人の読み、§5 Q10 に残す）。範囲は書いた範囲の物そのもの（実体ごとに別の物）で数えるので、実体を跨いだ同じ綴りは輪に数えない。
// - 右辺が局所の名前を裸で書いた別名（"local-alias"。`w : inc` ⏎ `v : w`・`v : [w]` の `$v`）：裸で書いた局所の名前は lookup で種類を決めない
//   （§5 Q10）ので、右辺の種類は未知。言い分でそれを言う。
// 根拠：主の Claude「局所の `?` 定義：`sq : z ? z * z` ⏎ `map $sq x`。今は局所の名前を未知にしていて断っているので、ここが変わる。」（2026-10-24
// 16:53 UTC）に U〔答え〕[2026-10-25 00:25 8dfc006e]「…後はすべて君の言う通り。」。裸で呼ぶ `sq x` は今のまま未知（lookup。この答えは `$` の先の話で、
// 本体の中の `:` が局所の定義か枝かは §5 Q10 に残る）。
// 右辺の種類は覚えない（`$名前` のたびに右辺を解き直す）。局所の `$` が2つずつ前の局所を指す鎖では指数で遅くなる（n=16 で 13 秒、同じ日の確かめ）
// が、範囲ごとに覚えると、不動点を回している途中の過渡値が覚えた種類に固まりうる（関数の根は門を捕まえて未知にして回す、bodyRootOf）ので入れていない。
function localTarget(name, s, ctx) {
  if (s.field) return { kind: U(), where: "local-field" };
  const d = localDefsOf(s);
  const rhss = d.defs.get(name) || [];
  if (!rhss.length) return { kind: U(), where: "local-nested" };
  if (d.branch) return { kind: U(), where: "local-branch" };
  if (rhss.length > 1) return { kind: U(), where: "local-twice" };
  const busy = s.dollarBusy || (s.dollarBusy = new Set());
  if (busy.has(name)) return { kind: U(), where: "local-cycle" };
  busy.add(name);
  let root;
  // 受け皿 dead：右辺に値の上に積まれて口が開いたまま閉じた関数があるか（R59。ファイルの定義の deadOfDef と同じ）。
  const dead = [];
  try {
    root = resolveTree(rhss[0], { F: ctx.F, scope: s, diag: null, dead });
  } finally {
    busy.delete(name);
  }
  if (!root || !root.kind) return { kind: U(), where: "local-value" };
  const alias = root.kind.k === "U" ? localAliasOf(rhss[0], s) : null;
  if (alias) return { kind: root.kind, where: "local-alias", alias };
  // 値なら、ファイルの値の定義（nameKindOf）と同じく、右辺の中身の形と要素も持つ（R60 の値を読む参照が指す値の形。descOfTree。`\tlf : 1 , 2` の `$lf` は
  // ファイルの `lf : 1 , 2` の `$lf`・`$[1 , 2]` と同じ `$[N…]`。持たないと、局所の側だけ形の見えない `$A` になり、法則18 で割れた）。
  const kind = root.kind.k === "A" ? descOfTree(root) : root.kind;
  return { kind, where: "local-value", unit: pointsToMark(root, { F: ctx.F, scope: s }), dead: dead[0] || aliasDeadOfTree(ctx.F, root, s) };
}

// 局所の定義の右辺が名前1つ（`v : w`・`v : [w]`・`v : (w)`）で、その名前が局所の名前なら、その名前（R54 の言い分のため）。
function localAliasOf(rhs, s) {
  if (!rhs || rhs.type !== "seq" || rhs.terms.length !== 1) return null;
  const t = rhs.terms[0];
  if (t.type !== "atom" || t.pre.length || t.post.length) return null;
  const n = bracketedName(t.core);
  if (!n) return null;
  for (let q = s; q; q = q.parent) {
    if ((q.descs && q.descs.has(n)) || (q.params && q.params.has(n))) return null;
    if (q.locals && q.locals.has(n)) return n;
  }
  return null;
}

// 範囲 s の行の `:` の分け方（R54）：defs は左が局所の名前1つの `:` の行の右辺（名前 → 右辺の並び）、shadow は左が名前1つでも局所の名前に
// 数えない名前（仮引数・ファイルの定義、scanLocals）、branch は局所の定義と読めない `:` の行があるか（左が名前1つでない行か、shadow の行）。
// 行は関数の範囲の本体の行（字下げのブロックならその行、ほかは本体そのもの1つ。makeLambda が defRows に置く。括り・ブロックの範囲には無い）。
function localDefsOf(s) {
  if (s.localDefs) return s.localDefs;
  const defs = new Map();
  const shadow = new Set();
  let branch = false;
  for (const row of s.defRows || []) {
    if (!row || row.type !== "op" || row.sym !== ":") continue;
    const n = singleBareName(row.left);
    if (!n) branch = true;
    else if (!s.locals.has(n)) shadow.add(n);
    else {
      if (!defs.has(n)) defs.set(n, []);
      defs.get(n).push(row.right);
    }
  }
  s.localDefs = { defs, shadow, branch: branch || shadow.size > 0 };
  return s.localDefs;
}

// `$x` の x が1つの Reader（関数か、値を読む参照）と言い切れない（R53・R54〜R57・R59・R60、G20）。kind は x の種類（後置の印の付いた項は null）、
// target.where は出どころ。先が名前1つなら、名前がなぜその種類かを添える（取り込みのある範囲の名前は未知、局所の名前は R54 の言い切れない理由。
// 2026-10-24 の確かめの指摘：局所の名前を別の問いへ向けると開ける問いが違う）。2026-10-25 の R60 から、先が値なら通る（値を読む参照）ので、
// 値の先の言い分（「値です」・データの番地の綴りは §5 Q54）は無くなった。
function refuseDollar(term, kind, ctx, target = {}) {
  const text = writeTerm(term);
  const name = target.name || null;
  const where = target.where || null;
  const tail = "`$` の先は、書いた所で1つの Reader（関数か、値を読む参照）と言い切れる物だけです";
  if (where === "post") {
    const marked = target.inner ? writeTerm(target.inner) : null;
    const post = target.inner ? target.inner.post.join("") : term.post.join("");
    return gate(
      "G20",
      `\`${text}\` の \`$\` の先は後置の印 \`${post}\` の付いた形${marked ? `（括りの中の \`${marked}\`。[x] ≅ x で、括らずに \`$${marked}\` と書いたのと同じ先）` : ""}で、\`$\` と後置の印のどちらが先に結ぶ読みでも、1つの Reader と言い切れません（撒いた形は並び、\`!\` は値の印（先に \`$\` が結べば、数でない Reader に値の印を当てることになる）、\`@\` は取り込み）。${tail}（§4 R53・R57・R60）。`
    );
  }
  if (where === "dead") {
    return gate(
      "G20",
      `\`${text}\` の \`$\` の先${name ? `（名前 \`${name}\` の右辺か本体）` : "の中身"}に、値の上に積まれて口が開いたまま閉じた関数 \`${cutShape(show(target.dead))}\` があります（§4 R52）。中身は2つの関数を括った形で、余った方は黙って落ちるので、1つの関数と言い切れません（逆適用の廃止の後の書き癖、§4 R47）。${tail}（§4 R59、§5 Q53 の答え${name ? "・Q62" : ""}）。`
    );
  }
  if (where === "spread") {
    return gate("G20", `\`${text}\` の \`$\` の先${name ? ` \`${name}\` ` : ""}は撒いた形（並び）で、1つの Reader と言い切れません。${tail}（§4 R57・R60）。`);
  }
  if (where === "mixed") {
    return gate(
      "G20",
      `\`${text}\` の \`$\` の先${name ? ` \`${name}\` ` : ""}は形の見えない値で、中身に関数か種類の未知な物が見えます（枝で選ぶ括り \`[c : inc]\`・欄と値の混ざった行など。枝で選ぶ物は \`&\`・\`|\` で書いても種類が未知です）。値を読む参照とも関数とも、1つの Reader と言い切れません。${tail}（§4 R60）。`
    );
  }
  if (where === "inst-opaque") {
    return gate(
      "G20",
      `\`${text}\` の \`$\` の先 \`${name}\` は、括りの関数の実体で渡された形の見えない値です。渡された物が書いた \`_\` と分かれば \`$_\` と同じ零射の番地（R63。欄の \`[s : _]\`・\`_\` を右辺に持つ名前など）、\`_\` でないと分かれば値を読む参照（R60）ですが、形の見えない値は、どちらか言い切れません（要素の混ざった List の要素・適用の結果など。§5 Q64 は閉じた）。${tail}（§4 R56・R60・R63）。`
    );
  }
  const why =
    where === "undefined"
      ? `（\`${name}\` は定義されていない名前で、値として読みます。R21）`
      : where === "imported"
        ? `（\`${name}\` は取り込みのある範囲の定義されていない名前で、中身がこのファイルから見えないので、種類が未知です。§5 Q10）`
        : where === "local-field"
          ? `（\`${name}\` は括りか、関数の本体でない字下げのブロックの中の \`:\` の左の名前です。括りは器で、その行は欄かもしれず、局所の定義と読むかが決まっていません。局所の定義を \`$\` で渡すのは関数の本体の行だけです。§4 R54、§5 Q10）`
          : where === "local-nested"
            ? `（\`${name}\` を左に置いた \`:\` が、この範囲の行ではなく入れ子の括りの中にあり、ここから見えるかが決まっていません。§4 R54、§5 Q10）`
            : where === "local-branch"
              ? `（\`${name}\` を左に置いた \`:\` のある本体に、局所の定義と読めない \`:\` の行（枝の条件か、仮引数・ファイルの定義と同じ名前の行）があります。枝のある本体は match_case で、\`${name} : …\` も枝の条件と読めるので、局所の定義か決まっていません。§4 R54、§5 Q10）`
              : where === "local-shadow"
                ? `（\`${name}\` を左に置いた \`:\` の行が本体にありますが、\`${name}\` は仮引数かファイルの定義の名前です。その行を局所の定義と読むと外の \`${name}\` を隠しますが、隠しを通すかは決まっていないので、どちらを指すか1つに言い切れません。§4 R54、§5 Q10）`
                : where === "local-twice"
                  ? `（\`${name}\` を左に置いた \`:\` が同じ範囲に2つ以上あり、どれを指すか1つに決まりません。§4 R54）`
                  : where === "local-cycle"
                    ? `（局所の定義 \`${name}\` の右辺を解いている途中で、また \`$${name}\` を指しました。自分か、ほかの局所の定義を通して自分を \`$\` で指す局所の関数は、右辺を解き終えられないので通しません。§4 R54、§5 Q10）`
                    : where === "local-alias"
                      ? `（\`${name}\` は局所の定義の名前で、右辺は局所の名前 \`${target.alias}\` を裸で書いた物です。裸で書いた局所の名前は、今のまま種類を決めません。§4 R54、§5 Q10）`
                      : where === "local-value"
                        ? `（\`${name}\` は局所の定義の名前で、右辺を解いた種類で見ました。§4 R54）`
                        : "";
  return gate("G20", `\`${text}\` の \`$\` の先は種類が決まらないので、1つの Reader（関数か、値を読む参照）と言い切れません${why}。${tail}（§4 R53・R60）。`);
}

// R60 の細かい所（§5 Q59）：`$` が作った物（関数を指す番地・値を読む参照。どちらも1つの Reader）が、値の演算子（算術・ビット・範囲の段12〜16・19〜22、
// 比較の段13 と段8 の `==`・`!==`）の被演算子にある。Reader は数ではないので、数として当てる読み（場所どうしの距離 `$foo - $bar` など、2026-09-30 の
// 番地の裁定）は決めずに断る。根拠：U [2026-10-25 07:48 533071da]「…AddressはAddress同士でしか計算は出来ないが、なるべくそういう処理が要らないように
// するために、参照渡しをspreadする仮引数の書き方を提供している。 / つまり、fooのアドレスやbarのアドレスが取れないと困る場面が具体化していないと、
// このQ54は本当に必要かどうか測れない。」。Reader を値の演算子に渡す形は、関数を値の演算子に渡す形（§5 Q22）と同じ門（G7）で断る。
// 前（R53〜R57）は、`$vs` が G20 で先に断り、関数の番地 `$inc + 1` は値（A）の演算として通っていた。
// 同じ日の確かめの直しから、中置の項のほかの綴りでも同じに断る（valueOperand）：区間の被演算子（`[+ $5]`）・値の演算子の点なしが受けた実引数
// （`[+ 1] $vs`・`[+] $vs 1`・`[-_] $vs`・`[* 2,] $vs`。argOperand）・絶対値の囲み（`|$vs|`。enclosureInfo）・値の印（`-p`・`!!p`・`p!`、p : $vs）・
// 素の関数の口（`inc $5`。readerAtPlain）。前は中置の項の所だけで、ほかの綴りは通った（確かめの指摘）。sym が null なら点なしが受けた所で、記号は書かない。
// 2026-10-26 の R62（§5 Q59 の答え）から、ここで断るのは関数を指す番地（`$inc`・`p : $inc` の p・`$inc` を受けた仮引数）だけ：1つの関数と言い切れる
// 番地を動かす・比べるのは R53 の外（R の印）。値を読む参照（`$vs`）は番地の点で、点と差の規則（addressOp）で読む。
function refuseReaderOperand(sym, operand) {
  return gate(
    "G7",
    `\`$\` が作った \`${operand}\` は関数を指す番地で、${sym === null ? "値の演算子の点なし" : `値の演算子 \`${sym}\` `}の被演算子にあります。関数を指す番地は1つの関数と言い切れる番地で（§4 R53）、値の演算子で動かす・比べる形は、その外なので断ります（§4 R62。番地の点と差の規則は、値を読む参照とそれをずらした点・点どうしの差に当てます）。`
  );
}

// ---- 番地の点と差（R62、2026-10-26。§5 Q59 の答え） ----
//
// `$` の値の参照（R60）と、点として置かれた `0x…` の字面は「番地の点」、点どうしの差と、点に足し引きする `0x…` は「番地の差」。どちらも Address 型の値で、
// Int・UInt と混ぜない。決まった組（主の Claude の表に U〔答え〕[2026-10-25 21:15 c8ccdd69]「その表のとおりで良い。」）：
// - 点 ± 差 → 点（`$x + 0x10`・`$x - ($b - $a)`）、点 − 点 → 差（`$foo - $bar`）、差 ± 差 → 差。点 + 点 → 断る。
// - Address と数（Int・UInt・文字。数の desc、SCALAR の注）を混ぜた算術と比べ（`$x + 1`・`$x - 8`・`$x == 0`）→ 断る（言い分「ずらしは `0x…` で書く」。
//   U [2026-10-25 07:48 533071da]「Q54は、Address型とint UIntを混ぜるなって話になるのだと見てる。AddressはAddress同士でしか計算は出来ない…」）。
// - 番地どうしの比べ（点どうし・点と `0x…`・差どうし。段13 の `<` `<=` `=` `>=` `>` `!=` と段8 の `==` `!==`）→ 通す（A。R の印：Address どうしなので）。
// `0x…` の字面は位置で顔が決まる：点の右に足し引きするなら差、比べの相手なら点。解決器は字面を今のまま中身の見えない A で持ち（SCALAR の注）、
// 点の相手の所でだけ書いた綴り（字面・括り1つ・右辺がそれの名前）から見る（hexOperand）。
// 決まっていない組は断る（§5 Q66）：差 ± `0x…`（差か点か）・点の左の `0x…`（`0x10 + $x`・`0x1000 - $x`）・差 ± 点・点と差の比べ・顔の分からない値（裸の
// 仮引数・適用の結果・器・書いた `_`）・`*` `/` `%` `^`・ビット・範囲（差を要素の幅で割って数にする道は §5 Q67）。中置の外の綴り（区間・点なし・
// 絶対値・値の印・素の関数の口）で番地を受けた形は、答えに点・差の印を持たせられないので断る（refuseAddressSpelling・readerAtPlain、§5 Q66）。
// 差が指す物の要素の幅の倍数か（U [2026-10-25 21:12 c8ccdd69]「…メモリアドレスの倍数の加法だと確定できるなら何とかなると思う。」）は、解決器が幅を
// 持たないので型の段で確かめる（仕様 §4 R62。決められる所は見つからなかった）。
// 圏論の読み（主の Claude、R）：位置は差の群が働く torsor（アフィン空間）。`$x` はメモリの1点に焦点を合わせたストアの位置で、`@` は extract、`#` は put、
// `$x + 0x10` は seek。Reader を関手で持ち上げる読み（読んでから当てる）は採らない。
// 2026-09-30 の「番地−番地は Int（距離）」「ずらしは Int で書く」は、差を Address 型にする形で上書きした。
const ADDR_ADD = new Map([
  ["pt+diff", "pt"],
  ["pt+hex", "pt"],
  ["diff+diff", "diff"],
]);
const ADDR_SUB = new Map([
  ["pt-diff", "pt"],
  ["pt-hex", "pt"],
  ["pt-pt", "diff"],
  ["diff-diff", "diff"],
]);
const ADDR_CMP_SYMS = new Set(["<", "<=", "=", ">=", ">", "!=", "==", "!=="]);
const ADDR_CMP_OK = new Set(["pt|pt", "pt|hex", "hex|pt", "diff|diff"]);
const FACE_TEXT = {
  pt: "番地の点",
  diff: "番地の差",
  hex: "`0x…` の字面",
  num: "数（Int・UInt・文字）",
  unit: "書いた `_`",
  fnv: "関数（番地でも数でもない）",
  box: "番地の算術で作った点・差を中に持つ器",
  other: "点か差か数か分からない値",
  none: "書いていない被演算子",
};
// 被演算子の顔：書いた `_`（unit）・関数を指す番地（fn）・関数（fnv）・番地の点（pt）・差（diff）・番地の字面（hex）・数（num）・ほか（other）。被演算子が
// 無ければ none。関数（L）は言い分で名指しするためだけに分ける（2026-10-26 の確かめの指摘：前は「点か差か数か分からない値」と言っていた）。答えは「ほか」と同じ。
function operandFace(isUnit, desc, hex) {
  if (isUnit) return "unit";
  if (!desc) return "none";
  if (refOf(desc)) return "fn";
  if (desc.k === "L") return "fnv";
  const f = addrFace(desc);
  if (f) return f;
  // 番地の算術で作った点・差を要素・欄に持つ器（hasAddr。2026-10-26 の確かめの直し）：器の中身に値の演算子を当てる形は、器の中の番地の顔が答えに残らない
  // （`([($x + 0x10) ($x + 0x10)] ' 0)` を包んで `[…] + 1`）ので断る（addressOp、§5 Q66）。
  if (hasAddr(desc)) return "box";
  if (hex) return "hex";
  if (isScalar(desc)) return "num";
  return "other";
}
// 値の演算子 sym の被演算子の顔 lf・rf（R62）。どちらにも番地の点か差が無ければ null（今までの読み）。読めれば答えの desc（点・差、比べは A）。
// 関数を指す番地は G7、決まって断る組と決まっていない組は G21。text は項の綴り、operand[i] は i 番目の被演算子の綴り（作るのは断るときだけ）。
function addressOp(sym, lf, rf, text, operand) {
  if (lf === "fn" || rf === "fn") throw refuseReaderOperand(sym, operand[lf === "fn" ? 0 : 1]());
  if (lf === "box" || rf === "box") {
    throw gate(
      "G21",
      `\`${text()}\` の \`${sym}\` の被演算子（左は${FACE_TEXT[lf]}、右は${FACE_TEXT[rf]}）に、番地の算術で作った点・差を中に持つ器があります。器の中身に値の演算子を当てる形は、答えに中の番地の点・差の印を持たせられないので、断る側に倒しました（器の中の番地は \`' 0\` で引いてから中置で書けば、§4 R62 で読みます。§5 Q66）。`
    );
  }
  const isAddr = (f) => f === "pt" || f === "diff";
  if (!isAddr(lf) && !isAddr(rf)) return null;
  const out = sym === "+" ? ADDR_ADD.get(`${lf}+${rf}`) : sym === "-" ? ADDR_SUB.get(`${lf}-${rf}`) : null;
  if (out) return { k: "A", addr: out };
  if (ADDR_CMP_SYMS.has(sym) && ADDR_CMP_OK.has(`${lf}|${rf}`)) return A();
  const t = text();
  const pair = `左は${FACE_TEXT[lf]}、右は${FACE_TEXT[rf]}`;
  if (lf === "num" || rf === "num") {
    const cmp = ADDR_CMP_SYMS.has(sym);
    throw gate(
      "G21",
      `\`${t}\` は番地（Address）と数を混ぜた${cmp ? "比べ" : "算術"}です（${pair}）。Address と Int は混ぜません。${cmp ? "番地と比べるのは番地（`0x…` の字面・点・差）です" : "ずらしは `0x…` で書きます（`$x + 0x10`）"}（§4 R62）。${sym === "/" || sym === "%" ? "番地の差を要素の幅で割って数にする道は決まっていません（§5 Q67）。" : ""}`
    );
  }
  if (sym === "+" && lf === "pt" && rf === "pt") {
    throw gate("G21", `\`${t}\` は番地の点どうしを足す形です。点に足せるのは差（\`0x…\` の字面か、点どうしの差）だけで、点 + 点は意味がないので断ります（§4 R62）。`);
  }
  throw gate(
    "G21",
    `\`${t}\` の \`${sym}\` の組（${pair}）は、番地の点と差の規則（点 ± 差は点、点 − 点は差、差 ± 差は差、点どうし・差どうし・点と \`0x…\` の比べ。§4 R62）で決まっていません（§5 Q66）。`
  );
}
// 中置の外の綴り（区間の被演算子・値の演算子の点なしが受けた実引数・絶対値・値の印）で、番地の点か差を値の演算子の被演算子にした（R62）。中置の項と違って
// 答えに点・差の印を持たせられない（区間・点なしの適用の答えは中身の見えない A で、実体の鍵も記号と被演算子を見ない）ので、中置で書けば通る組も断る
// （断る側に倒した、§5 Q66）。sym が null なら点なしが受けた所で、記号は書かない（refuseReaderOperand の注）。
function refuseAddressSpelling(sym, operand) {
  return gate(
    "G21",
    `\`${operand}\` は番地（\`$\` が作った値を読む参照か、それをずらした点か、点どうしの差）か、番地の算術で作った点・差を中に持つ器で、${sym === null ? "値の演算子の点なしが受けた所" : `値の演算子 \`${sym}\` の被演算子（区間・点なし・絶対値・値の印の綴り）`}にあります。番地の点と差の規則（§4 R62）を当てるのは中置で書いた \`+\`・\`-\` と比べだけで、この綴りは決まっていません（中置で書けば R62 で読みます。§5 Q66）。`
  );
}
// `@x` で、番地の算術で作った点・差を開いた（R62。classify の前置 `@` の枝）。
function refuseOpenAddress(text, d) {
  return gate(
    "G21",
    `\`${text}\` は、番地の算術で作った${d.addr === "pt" ? "点（ずらした番地）" : "差"}を \`@\` で開いています。${d.addr === "pt" ? "ずらした点が指す物は、差が指す物の要素の幅の倍数かと一緒に型の段で決まるので、解決器の段では分かりません" : "差は位置ではないので、読む物がありません"}（§4 R62、§5 Q66）。`
  );
}
// 番地の算術で作った点・差（R62）が、印を落とす所に入った（hasAddr の注。2026-10-26 の確かめの直し）。where は入った所、text は綴り（器なら要素の形）。
// どれも、印を持ち越すかは決まっていない（§5 Q66）ので、断る側に倒した。HEAD は中の算術を G7 で断っていた。
function refuseAddressDrop(where, text, extra = {}) {
  const tail = "印を持ち越すか（答えに点・差を持たせるか）は決まっていないので、断る側に倒しました（§4 R62、§5 Q66）。";
  const why = {
    return: `\`${text}\` は関数の本体が返す値（字下げの本体なら、局所の定義の右辺・枝の値・行の値も）で、番地の算術で作った点か差を含みます。関数の答えは本体の根の種類だけで持ち（素の関数と括りの関数の実体の答えは中身の見えない A。字下げの本体の局所の名前は種類が未知、P2）、点・差の印を答えに持たせられないので、返した番地が数と黙って混ざります（\`gw : y ? $x + 0x10\` ⏎ \`(gw 1) + 1\`）。`,
    plain: `番地の算術で作った点か差 ${text} を、素の関数 \`${extra.label}\` の前から ${extra.at} 番目の口に渡しました。素の関数の本体は裸の仮引数を番地と見ずに1回だけ解き、答えは本体の根の種類だけなので、本体がその口を返しても値の演算子に置いても、点・差の印を持たせられません（\`gi : y ? y\` ⏎ \`(gi ($x + 0x10)) + 1\` が黙って通る）。`,
    logic: `\`${text}\` の論理の \`${extra.sym}\` の被演算子 \`${extra.operand}\` は、番地の算術で作った点か差を含みます。論理の答えは通った側の値で、点・差の印を持たせられないので、番地が数と黙って混ざります（\`(c & ($x + 0x10) | $y) + 1\`）。`,
    writeTo: `\`${text}\` は、番地の算術で作った${extra.pt ? "点（ずらした番地）" : "差"}に \`#\` で書いています。${extra.pt ? "ずらした点が指す物（書く所の型）は、差が指す物の要素の幅の倍数かと一緒に型の段で決まるので、解決器の段では分かりません" : "差は位置ではないので、書く所がありません"}（\`@\` で開く形と同じ）。`,
    writeOf: `\`${text}\` は、番地の算術で作った点か差を \`#\` で書いています。書いた物は置き場の中身になり、解決器は置き場の中身と \`#\` の答えに点・差の印を持たせられません。`,
    mixed: `番地の算術で作った点か差を、要素の形の揃わない器（List・積。要素の形 ${cutShape(text)}）に入れました。形の揃わない要素は中身の見えない値にまとまり（\`[x ~xs]\` の x・\`' 0\` で引いた物）、点・差の印を持たせられないので、番地が数と黙って混ざります（\`([($x + 0x10) 5] ' 0) + 1\`）。`,
    bracket: `番地の算術で作った点か差（形 ${text}）を、括りの関数の括りの仮引数に直に渡しました。括りの仮引数に直に渡った番地は中身の見えない値として受ける（名前は未知）ので、点・差の印を本体に持ち越せません（裸の仮引数か欄で渡せば持ち越します）。`,
    other: `番地の算術で作った点か差 ${text} を、既定値のある関数（か、口の読みの決まっていない関数）の口に渡しました。その関数の答えは未知で（§3.4）、点・差の印を持たせられません。`,
    bare: `番地の算術で作った点・差を中に持つ器（形 ${cutShape(text)}）を、括りの関数の裸の仮引数に渡しました。裸の仮引数は形を見ずに中身の見えない A で受ける（R24）ので、中の点・差の印が本体で落ちます（括りの仮引数で受ければ、要素・欄の印は見えます）。`,
  }[where];
  return gate("G21", `${why}${tail}`);
}
// 名前 name が、いちばん近い範囲で、関数の本体の `:` の行に隠されたファイルの定義の名前か（§5 Q10。dollarNameTarget・instOpaqueName の隠しと同じ順に探す）。
function shadowedName(name, ctx) {
  for (let s = ctx.scope; s; s = s.parent) {
    if (s.defRows && localDefsOf(s).shadow.has(name)) return true;
    if ((s.descs && s.descs.has(name)) || (s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return false;
  }
  return false;
}
// 中置の被演算子の項が、隠された名前（それを1行で括った物も、[x] ≅ x）なら、その名前。ほかは null（R62 の顔、2026-10-26 の確かめの直し）。
function shadowedOperand(term, view, ctx) {
  if (!term || term.type !== "atom" || term.pre.length || term.post.length) return null;
  const c = term.core;
  if (c.c === "name") return shadowedName(c.name, ctx) ? c.name : null;
  if (c.c === "bracket" && view && Array.isArray(view.inner) && view.inner.length === 1) return shadowedTree(view.inner[0], ctx);
  return null;
}
function shadowedTree(t, ctx) {
  return t && t.t === "leaf" && t.term ? shadowedOperand(t.term, t.view, ctx) : null;
}
// 隠された名前の被演算子の顔（R62）：ファイルの定義の読みで番地の点か差なら断り（本体の行の読みとどちらで当てるか言い切れない。`$名前` の隠しの G20 と
// 同じ線、§5 Q10・Q66）、ほかは今の顔（番地の字面の顔は hexName が隠しを見て落とすので「ほか」）。
function shadowFace(f, name) {
  if (f !== "pt" && f !== "diff") return f;
  throw gate(
    "G21",
    `\`${name}\` は、関数の本体の \`:\` の行が隠すファイルの定義の名前で、ファイルの定義の読みでは番地の${f === "pt" ? "点" : "差"}です。隠しを通すかは決まっていない（§5 Q10。\`$${name}\` の G20 と同じ）ので、ファイルの定義と本体の行のどちらの読みで番地の点と差の規則（§4 R62）を当てるか言い切れません（§5 Q66）。`
  );
}
// 番地の字面の項（R62）：書いた `0x…`・`NxHHHH`（ADDRESS_LIT）、それを1行で括った物（[x] ≅ x。中身の `,` の単位は解いた木で消えている）、右辺がそれの
// ファイルの値の定義の名前（`:` はメタ。F.hexDefs、nameKindOf が置く）。仮引数・実体で渡された物・局所の名前は見ない（顔が分からない、§5 Q66）。
function hexOperand(term, view, ctx) {
  if (!term || term.type !== "atom" || term.pre.length || term.post.length) return false;
  const c = term.core;
  if (c.c === "lit") return ADDRESS_LIT.test(c.text);
  if (c.c === "bracket") return !!view && Array.isArray(view.inner) && view.inner.length === 1 && hexTree(view.inner[0], ctx);
  if (c.c === "name") return hexName(c.name, ctx);
  return false;
}
function hexTree(t, ctx) {
  return !!t && t.t === "leaf" && !!t.term && hexOperand(t.term, t.view, ctx);
}
function hexName(name, ctx) {
  for (let s = ctx.scope; s; s = s.parent) {
    // 関数の本体の `:` の行がファイルの定義の名前を隠す所（§5 Q10）では、ファイルの定義の字面の顔を使わない（本体の行の読みなら別の物。2026-10-26 の
    // 確かめの指摘：`nx : 0x10` を本体の `nx : 5` が隠しても、`$vs + nx` を点 + 差で通していた。同じ本体の `$nx` は隠しの G20）。顔は「ほか」になる。
    if (s.defRows && localDefsOf(s).shadow.has(name)) return false;
    if ((s.descs && s.descs.has(name)) || (s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return false;
  }
  const def = ctx.F.defs.get(name);
  if (!def || def.lambda) return false;
  nameKindOf(ctx.F, def);
  return !!ctx.F.hexDefs.get(def);
}

// `@x` の x の desc（R49）。名前は値の定義を解かずに覗き（peekDesc。未定義なら information だけ出す、touchName）、
// 括りは解く（前の touchCore と同じ）。`@x` の x は開く所なので、括りの中身は遅延した式にしない。`$x` の x は classifyDollar が見る
// （2026-10-24 までは、ここで delayed の印を付けて `$x` の x も見ていた）。
function pointedDesc(core, ctx) {
  if (core.c === "name") {
    touchName(core.name, ctx);
    return peekDesc(core.name, ctx);
  }
  return bracketInfo(core, ctx).desc;
}

function touchCore(core, ctx) {
  if (core.c === "name") touchName(core.name, ctx);
  else if (core.c === "bracket") bracketInfo(core, ctx);
  else if (core.c === "abs" || core.c === "norm") enclosureInfo(core, ctx);
  else if (core.rows) core.rows.forEach((r) => resolveTree(r, ctx));
}

// `|…|`・`||…||`（§2、R27）。囲みは値の演算子（絶対値・ノルム）なので、中の行の根が全部値なら A にする。書いた `_` だけの
// 行は印（値）なので A のまま（`||_||` は 0、`||$_||`・`||$!_||` は 1。U 10-21 02:54・U〔答え〕03:01）。
// ノルムの中が1行で根が関数 f なら、f の後にノルムを当てる合成（L）にする（R27、U〔答え〕10-21 03:01「多分筋が良いのは合成」）：
// `||f|| x` は `||f x||`（x が f のアリティ分のとき。k > n は左からの畳み込み（R40）で、ノルムは口を1つと数えて余りを後ろに積む。
// `||inc|| 1 2` は `||inc 1||` の後ろに 2、fnShape）。合成は適用の繰り返し（R11）なので、fns に f と「1つ受けて A」のノルム
// （NORM_FN）を並べる。f が合成なら開いて並べる（口の開いたまま残った合成も、最初の関数を部分適用にした合成なので開いてよい。
// entryFn）。`||!_||` は恒等射の後にノルムで、並び全体を受けて数える（`[~x] ? ||x||`、U 10-21 02:54）。
// ほか（中に未知・2行以上で L・絶対値の囲み `|f|`・`|!_|`）は、値の演算子に関数が来た項（§5 Q22）と同じく読みが決まらないので
// 未知にする。中が関数のときまで A と読むと、`|inc| 5` が黙って構築になる。撒く項だけの行（`|vs~|`）は、中置の被演算子の
// 撒く項（classifyInfix の注）と同じ理由で未知にする。
const NORM_FN = { type: "norm" };
function enclosureInfo(core, ctx) {
  const trees = core.rows.map((r) => resolveTree(r, ctx));
  // 絶対値は値の演算子：中に関数を指す番地があれば G7、番地の点・差があれば G21（R62、§5 Q66）、素の関数の裸の仮引数なら札に覚える（R60 の細かい所。valueOperand）。
  // ノルム（数える）は今のまま（`||$_||` は 1、R56）。
  if (core.c === "abs") for (const t of trees) if (t && t.kind) valueOperand(t.kind, "|…|", () => show(t));
  const isValue = (t) => !!t && t.kind.k === "A" && !(t.t === "leaf" && t.desc.spread);
  if (trees.length && trees.every(isValue)) return { desc: A(), trees };
  const root = trees.length === 1 ? trees[0] : null;
  if (core.c === "norm" && root && root.kind.k === "L" && root.kind.fn) {
    const f = root.kind.fn;
    const fns = f.type === "compose" ? [...f.fns, NORM_FN] : [f, NORM_FN];
    return { desc: { k: "L", fn: { type: "compose", fns } }, trees };
  }
  return { desc: U(), trees };
}

// 括らない `!_` を、読みの決まる位置の外で見つけたとき（§3.5、Q15）。読みの決まる位置は、口を埋める穴（素の関数か既定値のある関数の
// 実引数の並び、R16・R34）・口の外の恒等射（並びの頭・値の後ろ・`!_` だけの行・`,` の被演算子。R29・R44・R45）・口の中で穴と読んでも
// 恒等射と読んでも同じ関数になる所（口の数の決まった関数に口が1つだけ残った所、R46）・`||!_||`。`!_` だけの行は括らない行（`x : !_`・
// 本体・2行以上の括りの中の行）で、1行の括り `[!_]`・`(!_)` は否定の点なし（R29、§2）。言い分にもそう書く（`!_ + 1` を `(!_) + 1` に
// 書き直すと、恒等射ではなく否定になるので）。
function refuseHole(where) {
  return gate(
    "G7",
    `括らない \`!_\` が${where}にあります。\`!_\` の読みが決まるのは、口を埋める穴（素の関数か既定値のある関数（名前の定義か \`?\` の括り）の実引数の並びで、撒く項が無く、ほかの項が全部 A のとき。k = n なら最後の項が書いた \`_\` でないとき（R16）、k ≠ n なら書いた \`_\` が無く、k > n なら \`!_\` が前から n 個の中にあるとき（R34））と、口の外の恒等射（並びの頭・値の後ろ・括らない \`!_\` だけの行・\`,\` の被演算子。\`i : !_\` の i と同じ。R29・R44・R45）と、口の中で、穴と読んでも恒等射と読んでも同じ関数になる所（口の数の決まった関数に、口が1つだけ残っている所。R46）と、\`||!_||\` だけです。1行の括り \`[!_]\`・\`(!_)\` は恒等射ではなく否定の点なしです。それ以外の位置の読みは決まっていません（§3.5、§5 Q15）。`
  );
}

// 段4〜8 の中置の被演算子が、括らない `!_` 1つの並び（`!_ == 1`・`1 & !_`）。中置の被演算子は §3.5 の決定で G7 のまま（`!_ + 1` と
// 同じ。段12〜22 の項の中は classifyInfix が見る）。被演算子の `!_` を恒等射と読むかは決めていない（§5 Q15）。`,`（段9）の被演算子の
// 恒等射は、積の単位で消える（R45、resolveProduct）。
function refuseOperandHole(tree, sym) {
  if (tree && tree.t === "leaf" && tree.cat === "hole") throw refuseHole(`中置 \`${sym}\` の被演算子`);
}

// 段12〜22 の中置の項（§2）。値の演算子（段12〜16・19〜22）は被演算子が全部 A のときだけ A。書いた `_` の被演算子は
// 印（値）なので A に数える（`_ + 1`・`1 * _`。値は値の段で演算子表の Unit の欄が読む。§3.5、U〔答え〕10-14 03:32）。
// 穴 `!_` の被演算子は G7（穴の位置の外）、関数や未知があれば未知。段18 の `x ' k` は、x の形が見えて k が字面の整数か裸の名前なら、
// 引いた物の生まれ（R26、pickDesc）。引いた物が関数なら L で、名前の欄と同じく呼べる。ほかの鍵（`k~`・範囲・式）と
// `x @ k` は、何を引いたか決まらないので未知（§2）。`x ' a ' b` の鎖は、左の `x ' a` の desc からもう一度引く。
// 撒く項（`vs~ + 1`）も未知にする。§2 は撒く項を「A（撒く印つき）」とするが、撒いた中身を2項の演算子にどう渡すか
// （要素ごとか、並びとして渡すか）は仕様に無い。結果が撒かれた並びのままなら、適用の実引数の数 k が数えられない
// （2026-10-23 までは逆適用の左にも置けなかった、R12・G9）が、1つの値なら数えられる。読みで木が変わるので、値の段には回せない。
function classifyInfix(term, ctx) {
  if (isBareIndent(term.left)) throw refuseIndentBlock(`中置 \`${term.sym}\` の左`);
  const l = term.left ? classify(term.left, ctx) : null;
  const key = term.sym === "'" && term.left ? pickKeyOf(term.right) : null;
  if (key) {
    // 鍵は名前として引かない（pickKeyOf の注）。書いたとおりの葉にする。
    if (l.cat === "hole") throw refuseHole(`中置 \`${term.sym}\` の被演算子`);
    const desc = l.cat === "plain" ? pickDesc(l.desc, key) : U();
    return { cat: "plain", desc, view: { v: "infix", sym: term.sym, left: l.view, right: rawView(term.right) } };
  }
  const r = term.right ? classify(term.right, ctx) : null;
  if ((l && l.cat === "hole") || (r && r.cat === "hole")) throw refuseHole(`中置 \`${term.sym}\` の被演算子`);
  const view = { v: "infix", sym: term.sym, left: l ? l.view : null, right: r ? r.view : null };
  if (term.stage === 18) return { cat: "plain", desc: U(), view };
  // 番地の点と差（R62、2026-10-26。§5 Q59 の答え）：被演算子に番地の点か差があれば、点と差の規則で読む（addressOp。答えは点・差か、比べの A）。
  // 関数を指す番地は G7（R53 の外）。被演算子に番地の顔が無ければ今までの読み。
  // 関数の本体の `:` の行に隠された名前（§5 Q10）は、ファイルの定義の読みの顔が点・差なら断る（shadowFace、2026-10-26 の確かめの直し）。
  const face = (x, side) => {
    const f = operandFace(x && x.cat === "unit", x && x.cat === "plain" ? x.desc : null, !!x && x.cat === "plain" && hexOperand(side, x.view, ctx));
    const sh = x && x.cat === "plain" ? shadowedOperand(side, x.view, ctx) : null;
    return sh ? shadowFace(f, sh) : f;
  };
  const addr = addressOp(term.sym, face(l, term.left), face(r, term.right), () => writeTerm(term), [l, r].map((x) => () => showView(x.view)));
  if (addr) return { cat: "plain", desc: addr, view };
  // 値の演算子（段12〜16・19〜22）の被演算子の素の関数の裸の仮引数は、その札に覚える（valueOperand・paramTag）。`$` が作った Reader・番地の点と差は、
  // 上の addressOp が先に読むか断る。
  for (const x of [l, r]) if (x && x.cat === "plain") valueOperand(x.desc, term.sym, () => showView(x.view));
  const isA = (x) => x && (x.cat === "unit" || (x.cat === "plain" && x.desc.k === "A" && !x.desc.spread));
  if (!(isA(l) && isA(r))) return { cat: "plain", desc: U(), view };
  // 数どうしの値の演算子の結果は数（SCALAR の注）。段12（範囲）は List を作るので入れない。
  const scalar = SCALAR_INFIX_STAGES.has(term.stage) && isScalar(l.desc) && isScalar(r.desc);
  return { cat: "plain", desc: scalar ? scalarDesc() : A(), view };
}

// 後置 `~` の項（§2）。核が「中身が見えて要素が全部 A の器」か「裸の仮引数」か「中身の見えない物」なら撒く印つき
// の A。中身に関数か未知が見えれば、項の数に依らず G7（§5 Q20：中身の関数をその場で解くか値の段で解くか未決）。
//
// 名前の種類が未知のとき（`q : use $inc 5` の `q~`）は、撒く印つきの A にせず未知の葉にする（2項以上の並びで G7）。
// §2 は適用の結果を「中身の見えない物」に数えるが、種類が未知の物は L かもしれず、L の核を撒く形は G7（Q20）で
// ある。どちらの行に当たるか決まらないので、断る側に倒した。中身が見える名前は、種類を見る前に中身を見る
// （`q : [use $inc 5]` の `q~` は、括りの `[use $inc 5]~` と同じく位置に依らず G7）。
function classifySpread(term, view, ctx) {
  const { core } = term;
  // of：撒いた器の desc（R51 の畳み込みと書き下しが要素の desc を読む）。鍵（internDesc）と形の綴りは今までどおり `A~`。
  // count：撒いた器の中身の数（書いた器の数、writtenLength。数えられなければ null）。口が1つの関数の書き下し（R51、2026-10-25）が、流れの頭が
  // あるか・余りがあるかを見る。数は desc に入れず、葉にだけ付ける（valueCountOf の注と同じ理由：desc に入れると実体の鍵が見ない数が実体を
  // 跨いで分け合われる）。
  // 2026-10-25 の確かめの直しから、文字列を右辺に持つ名前（`st : \`abc\`` の `st~`）と、括った文字列（`[\`abc\`]~`、[x] ≅ x）も文字の数で数える
  // （flowLength。前は字面の `` `abc`~ `` だけを数え、名前と括りは数えられない流れで、字面と答えが割れていた）。
  const spread = (of, count = null) => ({ cat: "plain", desc: { k: "A", spread: true, of }, view, count });
  const countOf = (desc, extra = {}) =>
    flowLength({ t: "leaf", term: { type: "atom", pre: [], core, post: [] }, cat: "plain", desc, kind: desc, view: extra.view || view, count: extra.count ?? null, strCount: extra.strCount ?? null });
  const refuse = () => gate("G7", `\`${writeTerm(term)}\` は中身に関数か種類の未知な物が見える器を撒いています。撒いた中身をどの段で解くかは決まっていません（§5 Q20）。`);
  // 撒く物が `$` の作った Reader（`[$vs]~`・`[$inc]~`・`p : $vs` ⏎ `p~`）：[x] ≅ x と `:` はメタで、`$vs~`・`$inc~` と同じ形なので、R57 と同じく G20
  // （2026-10-25 の確かめの直し。前は `$vs~` が G20 で、括りと名前を通した綴りは撒く項で通った。関数の番地の `[$inc]~` は HEAD から）。
  const refuseReader = () =>
    gate(
      "G20",
      `\`${writeTerm(term)}\` が撒く物は \`$\` が作った Reader（か、それをずらした番地・番地の差。§4 R62）です。[x] ≅ x と \`:\` はメタなので、\`$\` の項に後置の \`~\` を付けた形（\`$vs~\`・\`$inc~\`）と同じで、撒いた形（並び）は1つの Reader と言い切れません（§4 R57・R60）。`
    );
  if (core.c === "lit") return spread(litDesc(core), countOf(litDesc(core)));
  if (core.c === "abs" || core.c === "norm") {
    const a = enclosureInfo(core, ctx);
    return a.desc.k === "A" ? spread(a.desc, countOf(a.desc)) : { cat: "plain", desc: U(), view };
  }
  if (core.c === "name") {
    const d = lookup(core.name, ctx);
    if (d.k === "L") throw refuse();
    if (readerOf(d)) throw refuseReader();
    if (d.elements && d.elements.some((k) => k !== "A")) throw refuse();
    if (d.k === "U") return { cat: "plain", desc: U(), view };
    // 撒く項の名前をもう一度撒く（`w : vs~` の `w~`）は、どの言葉にも無いので未知（2項以上の並びで G7）。
    if (d.spread) return { cat: "plain", desc: U(), view };
    return spread(d, countOf(d, { count: valueCountOf(core.name, ctx), strCount: stringCountOf(core.name, ctx) }));
  }
  if (core.c === "bracket") {
    const b = bracketInfo(core, ctx);
    if (readerOf(b.desc)) throw refuseReader();
    if (b.desc.k !== "A" || (b.desc.elements && b.desc.elements.some((k) => k !== "A"))) throw refuse();
    const inner = { ...view, inner: b.trees };
    const s = spread(b.desc, countOf(b.desc, { view: inner }));
    return { ...s, view: inner };
  }
  return { cat: "plain", desc: U(), view };
}
// 撒いた流れの数（R51 の書き下し、classifySpread）：書いた器の数（writtenLength）か、文字列の文字の数（stringLength）。数えられなければ null。
function flowLength(t) {
  const n = writtenLength(t);
  return n !== null ? n : stringLength(t);
}
// 書いた文字列の文字の数：バックスラッシュの無い字面・それを1行で括った物（[x] ≅ x）・文字列を右辺に持つファイルの値の定義の名前（strCount、
// stringCountOf）。ほかは null。
function stringLength(t) {
  if (!t || t.t !== "leaf" || t.cat !== "plain" || !t.term || t.term.type !== "atom" || t.term.pre.length || t.term.post.length) return null;
  const c = t.term.core;
  if (c.c === "lit") return stringCount(c);
  if (c.c === "name") return t.strCount === undefined ? null : t.strCount;
  if (c.c === "bracket" || c.c === "indent") {
    const rows = c.c === "bracket" ? t.view.inner : t.view.rows;
    return rows && rows.length === 1 ? stringLength(rows[0]) : null;
  }
  return null;
}
// 文字列の字面の文字の数（撒いた流れの数、classifySpread）。バックスラッシュのある字面は、エスケープで数が変わりうるので数えない（null）。
// 文字列でなければ null。
function stringCount(core) {
  const t = core.text;
  if (!(t.length >= 2 && t[0] === "`" && t[t.length - 1] === "`")) return null;
  const inner = t.slice(1, -1);
  return /[\\`]/.test(inner) ? null : [...inner].length;
}
// 字面の desc（classify の字面の枝と同じ）。文字列の字面は List（R24）、番地の字面は中身の見えない A、ほかは数。
function litDesc(core) {
  if (core.text.length >= 2 && core.text[0] === "`" && core.text[core.text.length - 1] === "`") {
    return withShape({ s: "list", elem: core.text.length > 2 ? scalarDesc() : null });
  }
  return ADDRESS_LIT.test(core.text) ? A() : scalarDesc();
}

// 括りの種類（§2）。点なしを先に見る（点なしの行は被演算子が欠けているので、並びとしては解けない）。
// delayed は `$[…]` の中身（遅延した式で、行の並びに R52 の判定をしない。resolveDelayed）。
function bracketInfo(core, ctx, delayed = false) {
  if (core.rows.length === 0) return { desc: { k: "A", elements: [] }, trees: [], isQ: false };
  if (core.rows.length === 1) {
    const pf = pointfreeOf(core.rows[0], ctx);
    if (pf) return { desc: pf, trees: [], isQ: false };
  }
  return rowsInfo(core.rows, ctx, delayed);
}

// 字下げのブロック（`?` の本体でない所。構造体や中置の右）。点なしは括りでだけ書けるので見ない。
function blockInfo(core, ctx) {
  return rowsInfo(core.rows, ctx);
}

function rowsInfo(rows, ctx, delayed = false) {
  const scope = blockScope(rows, ctx);
  const inner = scope ? { ...ctx, scope } : ctx;
  const trees = rows.map((r) => (delayed ? resolveDelayed(r, inner) : resolveTree(r, inner)));
  if (trees.length >= 2) {
    const desc = { k: "A", elements: trees.map(elementKind) };
    const sh = rowsShape(trees);
    if (sh) desc.shape = sh;
    return { desc, trees, isQ: false };
  }
  const root = trees[0];
  // 1行なら、中の行を解いた根の種類（頂が `?` なら L、`:`・`,` なら A、段4〜8 なら被演算子が全部 A のとき A）。
  // 括りは1つの項（`[inc 1 2] inc` の後ろの inc は、括りの値の後ろに積まれる。R47）。形は、1行の `名前 : 値` なら欄1つの構造体、ほかは
  // 中の行の形（長さ1のリストはスカラと同型なので、`[m]` は m の形、`[1 2 3]` は構築の並びの形）。
  const desc = { k: root.kind.k };
  if (root.kind.fn) desc.fn = root.kind.fn;
  // 関数を指す番地の印（R49）は、括り1つでも持ち越す（[x] ≅ x。`[$inc]` は `$inc`）。値を読む参照の印（R60）も同じ（`[$vs]` は `$vs`）。
  if (refOf(root.kind)) desc.ref = root.kind.ref;
  if (vrefOf(root.kind)) desc.vref = root.kind.vref;
  // 番地の算術で作った点・差の印（R62）と、書いた `_` を指す印（R63。`[_]`・`[un]`）も、括り1つなら持ち越す（[x] ≅ x）。
  // 点・差の印は、構築の中の余ったラムダが消えて1項だけ残った物（`(($x + 0x10) !_)`、vanishedOne）からも持ち越す（descOfTree と同じ読み。2026-10-26 の確かめの
  // 指摘：前は落ちて、`(($x + 0x10) !_) + 1` が黙って通った）。
  const addrRoot = addrOf(root.kind) || addrOf(vanishedOne(root) ? descOfTree(root) : null);
  if (addrRoot) desc.addr = addrRoot.addr;
  if (isMark(root) || zeroOf(root.kind)) desc.zero = true;
  desc.elements = visibleElements(root) || [elementKind(root)];
  if (desc.k === "A") {
    const sh = rowsShape(trees);
    if (sh) desc.shape = sh;
  }
  return { desc, trees, isQ: root.t === "lambda" && root.kind.k === "L" };
}

// 括りと字下げのブロックの中で `:` の左に1語で置いた名前（P2）。関数の本体の中では局所の定義か枝の条件か決まって
// いないので未知にする（scanLocals）。関数の本体の外の括り（`[sq : z ? z * z ⏎ sq 5]`）でも、局所の定義か欄か
// 決まっていない（§5 Q10）のは同じである。ここを未定義の名前（A）と読むと、同じ字面が置き場所で別の木になり、
// 定義した行の隣で「定義されていません」と出る。だから仮引数でもファイルの定義でもなければ、その括りの中で未知に
// する。範囲を括りの中に限るのは、括りの外では欄の名前を裸で読まない（欄は分解して受ける関数で読む）からである。
function blockScope(rows, ctx) {
  // field は、この範囲の局所の名前を `$` の先で局所の定義と読まない印（R54。括りは器で、行は欄かもしれない。localTarget の "local-field"、§5 Q10）。
  // 局所の定義を探す行（defRows、localDefsOf）は関数の範囲（makeLambda）にだけ置く。括りの行が外の名前と同じ名前の欄（`[inc : 5 ⏎ $inc]`）は、
  // R54 が括りの行を局所の定義と読まないので、今までどおり外の名前（ファイルの inc）を指す（裸で書いた `[inc : 5 ⏎ inc 3]` と同じ、§5 Q10）。
  const scope = { parent: ctx.scope, params: null, locals: new Set(), hasImport: false, field: true };
  for (const r of rows) scanLocals(r, scope, ctx.F);
  if (!scope.locals.size) return null;
  // 範囲の鍵（実体の鍵に入る関数の出どころ。lambdaKey の注）。中身は書いた行と外の範囲で決まる。
  scope.key = `${ctx.scope.key}/b{${rows.map(writeTree).join(" ⏎ ")}}`;
  return scope;
}

// 点なしの括り（§2）。返す物は desc、点なしでなければ null。
//
// 種類（§3.4 の行）：
// - pfUnary（`[+ 1]` と前置・後置の点なし `[-_]`・`[!_]` など）・pfGreedyUnary（`[* 2,]` など、と前置・後置の点なしの写像
//   `[-_,]`・`[!_,]`・`[!!_,]`・`[_!,]`。U〔答え〕2026-10-21 10:09「前置・後置の点なしにも , を付けて、[* 2,] と同じ要素ごとの
//   写像と読む。」）。
// - pfFold：畳む2項の点なし（R31）。両側の欠けた中置で、記号が FOLD_SYMS のどれか（`[+]`・`[-]`・`[*]`・`[/]`・`[%]`・`[^]`・
//   `[||]`・`[;;]`・`[&&]`・`[|]`・`[&]`・`[;]`・`[<]`・`[<=]`・`[=]`・`[>=]`・`[>]`・`[==]`）。`[op] x1 … xn` は、`x1 op … op xn`
//   を演算子表の結合の向きどおりに並べた物と同じ（U〔答え〕2026-10-21 09:15）。前は `[+]` だけが貪欲な2項（pfGreedyBinary）で、
//   ほかはアリティの分からない点なしだった。可変長の口で、並びの終わりで閉じる（fnShape・closeKind）。書いた `_` は markStep。
//   値の後ろでは、ほかの関数と同じく積まれ、後ろの項を受ける（R47。`1 2 [+] 3 4` は `1 2 ([+] 3 4)`。2026-10-23 は逆適用で
//   `1 ([+] 2 3 4)`、その前は R13 の G10）。
// - pfBinary：畳まない2項の点なし（R32）。両側の欠けた中置で、記号が畳まない物（段12〜22 の `[<<]`・`[>>]`・`[']`・`[@]`・範囲の
//   `[~]`・`[~+]` など・`[!=]` と、段1〜9 の `[!==]`・中置の `[#]`）。素の2引数の関数と同じに読む（U〔答え〕2026-10-21 10:52
//   「同じに読んでいいけど、おすすめは出来ないという方向で良いと思う。」）。足りた適用の種類は、値を返す演算なら A、get・set
//   （`'`・`@`・中置の `#`）は何を引いたか・何をしたかが決まらないので未知（root）。「おすすめは出来ない」は断らずに information
//   で見せる（reportNotFolded）。足りた適用の種類と information の形は決定の規則（主の Claude の案）。値の後ろでは、ほかの関数と
//   同じく積まれる（R47）。2026-10-23 は逆適用で主語を取り、口が2つなので主語の口が決まらなかった（§5 Q5、G8）。その前は、点なしなので
//   逆適用の右では G10 だった（R13）。前は段12〜22 の物がアリティの分からない点なし、段1〜9 の物が未知の葉（どちらも Q34）だった。
// - pfUnknownArity：アリティの分からない点なし。`[,]`（U 10-11「[,] ... は、[!__,] と同じ」）だけ。適用の種類は未知。段1〜9 のほかの
//   点なし（`[:]`・`[?]`・片側の欠けた `[| 5]` など）は、今までどおり葉ごと未知（Q19）。
// - pfPick：段18（`'`・`@`）の片側の欠けた点なし（`[' 0]`・`[@ 0]`）。`[' k]` で k が字面の整数か裸の名前なら、`x ' k` と
//   同じ射なので、`[' k] x` の適用は `x ' k` と同じ desc にする（R26、§3.4 の段18 の行）。そのために鍵を fn に持たせる。
//   ほかの形（`[@ 0]`・`[x ']`・鍵が式）は、§2 の `x @ k` と同じく何を引いたか決まらないので未知。A と読むと、
//   `[' 0] fs` が `inc`（L）を引くのに `[' 0] fs inc` が黙って `inc` に関数を渡す。値の後ろでは、ほかの関数と同じく積まれる
//   （`vs [' 0]` は vs の後ろに `[' 0]` が余り、根なら `_`。R47。2026-10-23 は、書いていない左の被演算子の口に主語が入る逆適用で
//   `[' 0] vs` と同じだった）。
function pointfreeOf(row, ctx) {
  const L = (type) => ({ k: "L", fn: { type, pointfree: true } });
  const unaryInfix = (t) => {
    if (!t || t.type !== "seq" || t.terms.length !== 1) return null;
    const term = t.terms[0];
    return term.type === "infix" && term.stage >= 12 && term.stage <= 22 && (term.left === null) !== (term.right === null) ? term : null;
  };
  // 点なしの被演算子は1項に限り、A でなければ（関数や未知なら）点なしとしても未知にする。書いた `_` の被演算子は、中置の
  // 被演算子と同じく印（値）なので A に数える（`[_ +]`、classifyInfix の注）。未知にしても綴りは区間なので、関数の本体の根に
  // 置けば G16 で断る（sectionSpelled。根の未知を通すと、区間を返す本体が黙って通る）。
  // 値の演算子の点なし（段18 の get を除く区間・前置 `!` を除く前置・後置の点なし・値の記号で畳む点なし・値を返す畳まない点なし）は、印 vop に
  // 記号を持つ：受けた実引数と書いた被演算子が関数を指す番地なら、中置の `$inc + 1` と同じく G7、番地の点・差なら G21（答えに点・差の印を持たせられない
  // ので、中置なら通る `[+ 0x10] $5` も断る。R62、§5 Q66）（R60 の細かい所。argOperand・
  // valueOperand。区間は位置で被演算子を取るので `[+ $5] 1` は `1 + $5`、`[+ 1] $5` は `$5 + 1`）。
  const withOperand = (term, type) => {
    const c = classify(term.left || term.right, ctx);
    if (c.cat === "hole") throw refuseHole(`点なし \`[${writeTerm(term)}]\` の被演算子`);
    if (!(c.cat === "unit" || (c.cat === "plain" && c.desc.k === "A" && !c.desc.spread))) return U();
    if (term.stage === 18) return { k: "L", fn: { type: "pfPick", pointfree: true, sym: term.sym, key: null } };
    if (c.cat === "plain") valueOperand(c.desc, term.sym, () => showView(c.view));
    return { k: "L", fn: { type, pointfree: true, vop: term.sym } };
  };
  // 前置・後置の点なしの印の記号（前置 `!` は否定で、値の演算子ではないので印を付けない。`$` の項の前置 `!` と同じく今のまま）。
  const markVop = (t) => (t.pre.length === 1 && t.pre[0] === "!" ? null : t.pre.length ? t.pre[0] : t.post[0]);
  // 畳む2項の点なし（R31）。記号は値の段（どの演算で畳むか・比較の畳み込みか）のために持つだけで、種類（closeKind）と実体の
  // 鍵（fnKey は型の名前だけ）は記号に依らない（どの記号でも同じ種類になる）。論理の `[|]`・`[&]`・`[;]` は値の演算子ではない（vop なし）。
  const fold = (sym) => ({ k: "L", fn: { type: "pfFold", pointfree: true, sym, vop: LOGIC_FOLD_SYMS.has(sym) ? null : sym } });
  // 畳まない2項の点なし（R32）。root は足りた適用の種類：get・set（段18 の `'`・`@` と、段4 の中置の `#`）は未知、ほかは A。値を返す物（root A）だけが
  // 値の演算子（vop）。
  const binary = (sym, root) => {
    reportNotFolded(row, sym, ctx);
    return { k: "L", fn: { type: "pfBinary", pointfree: true, sym, n: 2, root, vop: root === "A" ? sym : null } };
  };
  // 値の演算子の前置・後置の点なしの項：値の前置の印1つ（`-`・`!`・`!!`）か後置の `!` 1つと、核の書いた `_` だけ（`-_`・`!_`・
  // `!!_`・`_!`）。
  const valueMarkUnit = (t) =>
    !!t && t.type === "atom" && t.core.c === "unit" && t.pre.length + t.post.length === 1 &&
    ((t.pre.length === 1 && VALUE_PREFIX.has(t.pre[0])) || (t.post.length === 1 && t.post[0] === "!"));
  if (row.type === "op") {
    if (row.sym === "," && row.right === null) {
      // 貪欲な単項：`[* 2,]`・`[< 3,]`
      const u = unaryInfix(row.left);
      if (u) return withOperand(u, "pfGreedyUnary");
      // 前置・後置の点なしの写像：`[-_,]`・`[!_,]`・`[!!_,]`・`[_!,]` は `[* 2,]` と同じ要素ごとの写像（U〔答え〕2026-10-21 10:09）。
      // `$`・`@`・`#`・`~` の印には点なしを作らない（U〔答え〕09:21）ので、`[$_,]`・`[@_,]` などは下で未知のまま。
      if (row.left && row.left.type === "seq" && row.left.terms.length === 1 && valueMarkUnit(row.left.terms[0])) {
        return { k: "L", fn: { type: "pfGreedyUnary", pointfree: true, vop: markVop(row.left.terms[0]) } };
      }
      // `[F,]` の写像（R50）：`,` の左が、口が1つ残った関数の項（名前・`@x`・括り・部分適用・合成）なら、`[* 2,]` と
      // 同じ要素ごとの写像。
      const m = mapPointfree(row.left, ctx);
      if (m) return m;
    }
    if (row.left === null || row.right === null) {
      if (row.left === null && row.right === null) {
        // `[|]`・`[&]`・`[;]`・`[==]` は畳む（R31。`[&] a b c` は c、U 2026-10-21 08:50）。`[,]` はアリティの分からない点なし
        // （L、91）。
        if (FOLD_SYMS.has(row.sym)) return fold(row.sym);
        if (row.sym === ",") return L("pfUnknownArity");
        // 畳まない `[!==]`（値を返す）と中置の `[#]`（set）は、素の2引数の関数（R32）。
        if (row.sym === "!==") return binary(row.sym, "A");
        if (row.sym === "#") return binary(row.sym, "U");
      }
      // 段1〜9 のほかの点なしは未知：`[:]`・`[?]`・片側の欠けた `[| 5]`・`[== 3]` など（Q19）。
      // 前置・後置の印に `,` を付けた、値の演算子でない写像（`[$_,]`・`[@_,]` など）も、ここで未知。
      return U();
    }
    return null;
  }
  if (row.terms.length !== 1) return null;
  const t = row.terms[0];
  if (t.type === "infix" && t.stage >= 12 && t.stage <= 22) {
    if (t.left === null && t.right === null) {
      // 畳む記号なら R31。ほか（`[<<]`・`[>>]`・`[']`・`[@]`・範囲・`[!=]`）は素の2引数の関数（R32）で、段18 の get は未知を返す。
      return FOLD_SYMS.has(t.sym) ? fold(t.sym) : binary(t.sym, t.stage === 18 ? "U" : "A");
    }
    if (t.left === null || t.right === null) {
      // `[' 0]`・`[' say]`：鍵は名前として引かない（pickKeyOf の注）ので、被演算子を解かない。
      const key = t.sym === "'" && t.left === null ? pickKeyOf(t.right) : null;
      if (key) return { k: "L", fn: { type: "pfPick", pointfree: true, sym: t.sym, key } };
      return withOperand(t, "pfUnary"); // `[+ 1]`・`[2 *]`・`[@ 0]`（pfPick、鍵なし）
    }
    return null;
  }
  // 前置・後置の点なし。値の演算子（`[-_]`・`[!_]`・`[!!_]`・`[_!]`）だけを L にする。書いた `_` は、
  // 被演算子を書いていない口の印である（前置・後置の印は隣接で位置が決まるので、隣に何かが要る。主の Claude の読み）。
  // 括った `[!_]` は否定の点なしで、恒等射は括らない `!_`（R29。U 2026-10-21 08:24「[!_] は否定の点無しにしないの？ 恒等射なら
  // 括らなくていい。」）。`( … )` も同じ括り（前段は同じ印で渡す）なので `(!_)` も否定の点なし。2行以上の括りの中の `!_` の行
  // （`[!_ ⏎ 1]`）は、ここに来ず、行として恒等射（R29、single）。
  // 同じ日の R30（未定義の名前を被演算子に書く `[-a]`）と、`_` の綴りを断った G14 は廃止した（U〔答え〕08:20）。`[-a]` は
  // R30 の前と同じく、値の印を当てた項の括り（a が未定義なら A で、information は R21 の文面）。
  if (valueMarkUnit(t)) return { k: "L", fn: { type: "pfUnary", pointfree: true, vop: markVop(t) } };
  // `$`・`@`・`#`・`~` の印には点なしを作らない（U〔答え〕2026-10-21 09:21「良いと思う。」。Q33 の答え）。`[$_]` は値 `$_` の括りで A、
  // `[@_]`・`[#_]`・`[_@]`・`[_~]`・`[~_]` は点なしではなく、ふつうの括りの項で、その印の項の読み（前置 `@` は Q9、前置 `~` は
  // Q14、後置 `@`・前置 `#` は Q10、撒く `_~` は classifySpread）に従う。どれも行として解き（rowsInfo）、`$_` のほかは今は未知。
  return null;
}

// R50（2026-10-24）：`[F,]` の F が、要素1つに当てて閉じる関数の項（口が1つ残った関数か、可変長の口だけの関数、takesOne）なら、F を
// 写す貪欲な単項（`[* 2,]` と同じ種類で、写す関数 map を持つ）。
// 根拠：U [2026-10-24 03:39 ebf18260]「…実はね、map は 裏技あるよね。」と `map : f [~t] ? [@f,] t~`。主の Claude の問い「`[F,]` の写像を、
// 区間だけでなく関数の項（`inc`・`@f`・括りの関数）全部に広げる、でいい？」に U〔答え〕[2026-10-24 03:43 ebf18260]「それでいいと思う。」。
// `[f,]` は List の関手を射 f に当てた物（fmap）で、区間だけに限るのは部分を見た制限（主の Claude の読み）。
// 口が2つ以上・口の数が分からない関数（`[add,]`・`[@g,]` で g が素の関数の仮引数・`[gd,]`）・固定の口の後ろに可変長の口がある関数・可変長の口の
// ある合成は今のまま未知（並びの中で G7）。`[@_,]`・`[$_,]`
// （§5 Q33、印の点なし）とは別物：ここの F は口の埋まった関数の項で、`@` の区間ではない。F を解いて門に当たったら、今までどおり未知（前は
// F を解かずに未知にしていた。門を握りつぶすのは、前と同じ答え（未知）を返すため）。ただし `$` の先が関数でない G20（R53）は握りつぶさない：
// 握りつぶすと `[$vs,]` が根で未知のまま通り、書いた `$vs` が黙って残る（`$` は書いた所のどこでも関数だけを運ぶ。2026-10-24）。
function mapPointfree(left, ctx) {
  if (!left || left.type !== "seq" || !left.terms.length) return null;
  let t;
  try {
    t = resolveTree(left, ctx);
  } catch (e) {
    if (isGate(e) && e.gate !== "G20") return null;
    throw e;
  }
  const fn = t && t.kind && t.kind.k === "L" ? t.kind.fn : null;
  if (!fn || !takesOne(fn)) return null;
  return { k: "L", fn: { type: "pfGreedyUnary", pointfree: true, map: fn, envDepth: depthOf(internFn(fn)) } };
}

// `[F,]` の F が、要素1つに当てて閉じるか（R50）：口が1つ残った関数（mouthsOf が 1）か、口が可変長の口だけの関数（前に固定の口が無い）。
// `[F,] a b` は `F a , F b` で、`,` の辺の `F a` は1つの行なので、可変長の口は a 1つを受けて閉じる（行 `F a` と同じ。R24 の最後の括りに1つ、
// R31 の k = 1、R26 の1つ受けた点なし、R29 の k = 1）。最後の仮引数が括りで仮引数が1つの括りの関数（`hd : [y ~ys] ? y` の `[hd,] ws`）とその
// 部分適用（`pq : x [b] ? x + b` の `[(pq 1),] vs`）・畳む2項の点なし（`[[+],] ws`）・段18 の点なし（`[[' 0],] ws`）・貪欲な単項・恒等射。
// 2026-10-24 の試しの確かめで見つかった断りすぎの直し（R50 の出どころの問いは「関数の項（`inc`・`@f`・括りの関数）全部」で、最初の版は
// 可変長の口の関数を口の数の分からない物と一緒に断っていた）。固定の口の後ろに可変長の口がある関数（`nn : a [~c] ? a`。`nn e` は足りない
// 適用）と、可変長の口のある合成は今のまま（未知、並びの中で G7）。
function takesOne(fn) {
  if (mouthsOf(fn) === 1) return true;
  if (!fn || fn.type === "compose") return false;
  if (fn.type === "pfPick") return true;
  const sh = fnShape(fn);
  return !sh.unknown && !!sh.varying && sh.fixed === 0;
}

// 関数の残りの口の数（R50・R51）。数えられるのは、口の数の決まった関数と、その合成（後ろの関数は前の結果で口を1つ埋める）だけ。
// 可変長の口（最後の括り・`[~c]`・畳む点なし・貪欲な単項・恒等射）と、口の数の分からない関数（前置 `@`・`[,]`・既定値のある関数・段18 の
// 点なし）は null。
function mouthsOf(fn) {
  switch (fn && fn.type) {
    case "plain":
      return fn.rest ? null : fn.n;
    case "pfUnary":
    case "norm":
      return 1;
    case "pfBinary":
      return fn.n;
    case "pattern":
      return fn.lastBracket ? null : fn.n;
    case "compose": {
      let total = null;
      for (const f of fn.fns) {
        const m = mouthsOf(f);
        if (m === null || m < 1) return null;
        total = total === null ? m : total + m - 1;
      }
      return total;
    }
    default:
      return null;
  }
}

// ---------------------------------------------------------------------------
// 行を解く（P3）
// ---------------------------------------------------------------------------

function resolveTree(tree, ctx) {
  if (tree === null) return null;
  if (tree.type === "seq") return resolveSeq(tree.terms, ctx);
  switch (tree.sym) {
    case "?":
      return resolveLambda(tree, ctx);
    case ":":
      return resolveDefine(tree, ctx);
    case ",":
      return resolveProduct(tree, ctx);
    default: {
      // 段4〜8：被演算子が全部 A なら A、そうでなければ未知（§2）。
      if (isBlockSeq(tree.left)) throw refuseIndentBlock(`\`${tree.sym}\` の左`);
      const l = resolveTree(tree.left, ctx);
      const r = resolveTree(tree.right, ctx);
      refuseOperandHole(l, tree.sym);
      refuseOperandHole(r, tree.sym);
      // 論理（段5〜7 の `;`・`|`・`&`）の被演算子と、書き込み（段4 の `#`）の被演算子に、番地の算術で作った点・差（R62）があれば断る（2026-10-26 の
      // 確かめの直し。hasAddr の注）：論理の答えは通った側の値で、`#` は置き場に書くので、どちらも点・差の印を持たせられない。`#` の左のずらした点・差は、
      // `@` で開く形（refuseOpenAddress）と同じ理由でも言い切れない（ストアの余モナドの読みでは `@` が extract、`#` が put。§5 Q66）。
      // 値を読む参照（`$vs # 5`・`$vs & 1`）は今のまま。
      if (tree.sym === ";" || tree.sym === "|" || tree.sym === "&") {
        for (const x of [l, r]) if (treeHasAddr(x)) throw refuseAddressDrop("logic", writeTree(tree), { sym: tree.sym, operand: show(x) });
      }
      if (tree.sym === "#") {
        const ld = l ? descOfTree(l) : null;
        if (addrOf(ld)) throw refuseAddressDrop("writeTo", writeTree(tree), { pt: ld.addr === "pt" });
        if (treeHasAddr(l) || treeHasAddr(r)) throw refuseAddressDrop("writeOf", writeTree(tree));
      }
      // 比較（段8 の `==`・`!==`）の被演算子に `$` が作った Reader があれば断っていた（R60 の細かい所、§5 Q59）。論理（`;`・`|`・`&`）と書き込み（`#`、Writer）は今のまま。
      // 素の関数の裸の仮引数なら、その札に覚える（valueOperand・paramTag）。
      // 2026-10-26 の R62 から、番地どうしの比べ（点どうし・差どうし・点と `0x…`）は通り、関数を指す番地は G7、点と差・番地と数は G21（addressOp）。
      if (tree.sym === "==" || tree.sym === "!==") {
        const face = (x) => {
          const f = operandFace(isMark(x), x ? x.kind : null, hexTree(x, ctx));
          const sh = shadowedTree(x, ctx);
          return sh ? shadowFace(f, sh) : f;
        };
        if (!addressOp(tree.sym, face(l), face(r), () => writeTree(tree), [l, r].map((x) => () => show(x)))) {
          for (const x of [l, r]) if (x && x.kind) valueOperand(x.kind, tree.sym, () => show(x));
        }
      }
      return { t: "op", sym: tree.sym, left: l, right: r, kind: l && r && l.kind.k === "A" && r.kind.k === "A" ? A() : U() };
    }
  }
}

// `:`（R3、P3）。左は、1項なら解かない（定義・欄・既定値の左はいつも1項）。2項以上なら枝の条件として解く。
// fieldName は左が1語の裸の名前のときの名前で、括りやブロックの行なら構造体の欄の名前になる（rowsShape、R24）。
// 右辺は、左が名前1つの `:`（定義・欄・局所の定義）でも枝でも、ほかの並びと同じく解き、R52 を当てる。名前は右辺を閉じた1つの項として
// 指す（R42 の読み7）：`v : 5 inc` の右辺は `(construct 5 (unit inc))` で v は 5、inc は定義の行で知らせ、`v 3` は `5 3`。右辺が丸ごと
// 関数（`c1 : inc inc`・`a1 : add 1`）は、値の上に積まれていないので今のまま L（`c1 5`・`a1 5` は当たる）。
// 根拠：§5 Q50 で主の Claude は、字面どおり（`v 3` を `5 (inc 3)`）に読むと名前が自分の値を持たない・括ると意味が変わる・使う所ごとに解き
// 直す・得る物が小さいと挙げ、「閉じた1つの項として読む（v は 5、定義の所で inc を知らせる）に傾いてる」と書いた（2026-10-24 09:48 UTC）。
// U〔答え〕[2026-10-24 09:49 ebf18260]「全てその方向で良いと思う。」。2026-10-24 の R52 の最初の版から同じ日のこの片までは、左が名前1つの
// `:` の右辺の並びを R52 の外にしていた（印 pointsTo。U〔答え〕10-22 22:14 のボタンの文「`:` はメタなので、右辺の余ったラムダは `_` に
// しない」から。その文は主の Claude の物で、右辺が丸ごと関数の形について今も残り、値の上に積まれた形は Q50 の答えで上書きされた）。
// 枝の値も同じく当てる（§5 Q51 は、今の答えのまま閉じた）。
function resolveDefine(tree, ctx) {
  let left = null;
  let isLocalDef = false;
  let fieldName = null;
  const oneLeft = !!(tree.left && tree.left.type === "seq" && tree.left.terms.length === 1);
  if (oneLeft) {
    const term = tree.left.terms[0];
    if (!isNameTarget(term)) {
      const label = patternCallIn(term, ctx);
      if (label) {
        throw gate(
          "G7",
          `\`:\` の左の1項 \`${writeTerm(term)}\` の中で括りの関数 \`${label}\` を呼んでいます。1項の \`:\` の左は解かない（P3）ので、ここで呼んでも実体が作れず、本体の読みが決まりません（R25）。条件を2項以上で書くか、条件の外で呼びます。`
        );
      }
    }
    left = { t: "raw", view: rawView(term) };
    const n = bareName(term);
    if (n && ctx.scope.locals && ctx.scope.locals.has(n)) isLocalDef = true;
    fieldName = n;
  } else left = resolveTree(tree.left, ctx);
  const right = resolveTree(tree.right, ctx);
  return { t: "op", sym: ":", left, right, kind: A(), isLocalDef, fieldName };
}

// `$[…]` の中身の行を解く（rowsInfo の delayed）。`$` は物にする＝遅延なので、中身は書いた所では評価しない遅延した式で、R52 の判定をしない：
// 値の上に積まれて口の開いたまま閉じた関数も、ラムダのまま書いたとおりに残し、知らせない（`p : $[5 inc]` の中身は `(construct 5 inc)`）。
// 判定は `@` で開いた所でする（開いた所の読みは §5 Q50 の閉じた1つの項。今の解決器では、中身が関数でない `$[5 inc]` の `@p` は開けず、
// 今のまま未知。§5 Q9）。だからその形では、書いた所の判定を外した上に開く所で判定する道も無く、知らせはどこにも出ない（HEAD a70fb89b では
// 定義の行で1つ出ていた。開けない `@p` の所で知らせるかは §5 Q44 の残り。2026-10-24 の確かめの指摘）。
// 根拠：U [2026-10-24 09:46 ebf18260]「Q52は最初からそのつもりだったしその方が良いと考えてたけど…違うなら違うと言って」（問いは
// 「`$[…]` の中身も、式を指すだけと読むか」）。主の Claude「`$` は「物にする＝遅延」なので、`$[…]` を書いた所では中身を評価しない。
// 評価しない所で「余った」と判定するのは筋違いだね。…判定は、`@p` で開いた所ですればいい。」（09:48 UTC）に、U〔答え〕[2026-10-24 09:49
// ebf18260]「全てその方向で良いと思う。」。
// 印 delayed（closeIdle を外す）を付けるのは、行が並びか `,` のときだけで、効くのは行の並びそのものと、`,` が恒等射で消えて残った並び
// （R45：`$[5 inc , !_]` は `$[5 inc]` と同じ。resolveProduct）だけ。中身の項の中（入れ子の括り `$[(5 inc) 3]`・1項を括っただけの
// `$[(5 inc)]`・囲み・`?` の本体 `$[x ? x inc]`・段4〜8 の辺 `$[5 inc == 6]`・消えない `,` の辺）は、ほかの所と同じく R52 を当てる（遅延が
// 中まで及ぶかは訊いていない、§5 Q53。今のまま）。中身の行が段2 の `:`（欄 `$[k : 5 inc]`・枝 `$[5 > 1 : 5 inc]`）なら、印は付けず、右辺は
// ほかの `:` の右辺と同じく当てる（resolveDefine。これも §5 Q53）。枝の値は今のままだが、欄の右辺は R52 の片では印 pointsTo で外だったので、
// §5 Q50 の答えから新しく知らせる（HEAD では黙っていた。2026-10-24 の確かめの指摘）。`$` に別の印の付いた括り（`$[…]~` など、表に無い
// 組み合わせで未知）も今のまま。
// 2026-10-24 の R52 の片では、同じ印を pointsTo の名前で左が名前1つの `:` の右辺に付けていた（§5 Q50 の答えで外した）。
// 同じ日の R53（`$` は関数だけを運ぶ）から、classify は中身の種類が L でなければ G20 で断る。中身が関数なら、中身の並びに値の上に積まれて
// 閉じた関数は残らない（残れば中身は値か未知）ので、この印は通る形の答えを変えない（変異で確かめた、仕様 §7.28 の M8。変わるのは G20 の
// 言い分の「値です」と「種類が決まらない」だけ）。上の「中身の項の中は今のまま当てる」のうち、中身が値の形（`$[(5 inc) 3]`・`$[(5 inc)]`・
// `$[5 inc == 6]`・`$[k : 5 inc]`）は書けなくなり、§5 Q44 の残り その2 は閉じた。中身が関数の `$[…]` の中の項（`$[add (5 inc)]` の `(5 inc)`・
// `$[add ||5 inc||]`・`$[add [k : 5 inc]]`）と `?` の本体（`$[x ? x inc]`）は、今のまま当てて書いた所で知らせる（`$` の無い `[add (5 inc)]` と
// 同じ）。R53 が保証するのは中身の根が関数であることだけなので、遅延が中まで及ぶかの §5 Q53 は狭まって残る（R53 の片では「閉じた」と書き、
// 確かめの指摘で直した。M8 で差が出ないのは、遅延の有無に依らず中身の項の中を当てているから）。`$` に別の印の付いた括りは、確かめの直しから、
// どの読みでも先が関数でない `$[5 inc]~` は G20（classify の `$` の組み合わせの枝）。2026-10-25 の R57 から、後置の印の付いた `$` の項は先に依らず
// G20（`$[inc]~` も。classifyDollar）。
// 同じ日の R59（§5 Q53 の答え）から、中身の項の中（入れ子の括り・囲み・欄・`?` の本体）で余るラムダがあれば、知らせて通すのではなく G20 で断る
// （classifyDollar の受け皿 dead）。中身の並びそのもの（この印が効く所）の値と関数の積み上げは、今までどおり判定せず種類を決めない構築（未知）で、
// R60（値の先も通す）の後も、種類が未知なので G20（`$[5 inc]`）。
function resolveDelayed(row, ctx) {
  if (row && row.type === "seq") return resolveSeq(row.terms, { ...ctx, delayed: true });
  if (row && row.sym === ",") return resolveTree(row, { ...ctx, delayed: true });
  return resolveTree(row, ctx);
}

// 1項の `:` の左が名前（定義・欄・局所の定義の左。公開の `#` 付きも）か。名前でない1項（`(t [1 2]) : 1`）は枝の
// 条件だが、P3 は2項以上のときだけ枝の条件として解くので、読まない。
function isNameTarget(term) {
  return term.type === "atom" && term.core.c === "name" && !term.post.length && (term.pre.length === 0 || (term.pre.length === 1 && /^#+$/.test(term.pre[0])));
}

// 読まない1項の `:` の左の中で、括りの関数（名前か、括った `?`）を呼んでいれば、その名前。
// R25 の「一度も呼ばれない括りの関数は defer で断らない」は、本体を読まないのが呼ばれていないからである。読まない所
// から呼ぶと、書いた呼び出しがあるのに実体が作れず、関数は defer になって本体の門が黙って消える（確かめ 2026-10-19 の
// F3。n_queens.sn の `(conflict col 1 board) : …` がそうだった）。1項の左を条件として解くかは P3 の話で、仕様が決めて
// いないので、ここでは読まずに名指しで断る（断る側）。
// 「呼んでいる」は、解かずに字面で見る：括りの関数が2項以上の並びの項にある（適用・合成のどれかになる。2026-10-24 の R47 からは、値の
// 後ろに積まれて何も受けない形（`5 h`）もあるが、字面では見分けないので、今までどおり断る側に数える）。
// 1項だけ（`[z : inc]` の inc、`(t)`）は関数を値として書いただけで、`$` で渡すのと同じく実体を作らない（R25 の公開と
// 同じ扱い）ので断らない。素の関数は定義の行で本体を読むので、ここには関わらない（前からの P3 のまま）。
function patternCallIn(term, ctx) {
  return patternCallWalk(ctx, (visitTree, visitTerm) => visitTerm(term), false);
}
// 既定値（`?` の左の `:` の右）も、`?` の左は解かない（P3）ので読まない。そこで括りの関数を呼ぶ形も、1項の `:` の
// 左と同じ理由（R25 の「一度も呼ばれない」に当たらないのに、実体が作れない）で断る。
function patternCallInDefaults(left, ctx) {
  let found = null;
  const visit = (t) => {
    if (found || !t) return;
    if (t.type === "seq") {
      for (const term of t.terms) visitParamTerm(term);
      return;
    }
    if (t.sym === ":") {
      found = patternCallWalk(ctx, (visitTree) => visitTree(t.right), true); // 既定値（右）は全部を見る
      return;
    }
    visit(t.left);
    visit(t.right);
  };
  const visitParamTerm = (term) => {
    if (found || !term) return;
    if (term.type === "infix") {
      visitParamTerm(term.left);
      visitParamTerm(term.right);
    } else if (term.core.rows) term.core.rows.forEach(visit);
  };
  visit(left);
  return found;
}
// inDefault は既定値の中を見ているか（namesPattern）。
function patternCallWalk(ctx, start, inDefault) {
  let found = null;
  // 2項以上の並びの項のうち、括りの関数を指す物（裸の名前か、括った `?`）。
  const calledIn = (terms) => {
    for (const x of terms) {
      const n = bareName(x);
      if (n && namesPattern(n, ctx, inDefault)) return n;
      const op = x && x.type === "atom" && !x.pre.length && !x.post.length ? unwrapLambda({ type: "seq", terms: [x] }) : null;
      if (op && patternParamsOf(op.left)) return `[${writeTree(op)}]`;
    }
    return null;
  };
  const visitTree = (t) => {
    if (found || !t) return;
    if (t.type === "seq") {
      if (t.terms.length >= 2) found = calledIn(t.terms);
      return t.terms.forEach(visitTerm);
    }
    if (t.sym === "?") return visitTree(t.right); // 入れ子の関数の本体も読まない所にある。左（仮引数）は名前だけ
    visitTree(t.left);
    visitTree(t.right);
  };
  const visitTerm = (x) => {
    if (found || !x) return;
    if (x.type === "infix") {
      visitTerm(x.left);
      visitTerm(x.right);
    } else if (x.core.rows) x.core.rows.forEach(visitTree);
  };
  start(visitTree, visitTerm);
  return found;
}
// 名前が括りの関数を指すか（lookup と同じ順に探す。未定義の information は出さない）。inDefault は、既定値の中を覗いて
// いるか（patternCallInDefaults）。
function namesPattern(name, ctx, inDefault) {
  const isPattern = (d) => !!d && d.k === "L" && !!d.fn && d.fn.type === "pattern";
  for (let s = ctx.scope; s; s = s.parent) {
    if (s.descs && s.descs.has(name)) return isPattern(s.descs.get(name));
    if ((s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return false;
  }
  const F = ctx.F;
  const def = F.defs.get(name);
  if (!def) return false;
  if (def.lambda) return !!def.pattern;
  const start = F.stack.length;
  const before = F.cycleRefused;
  try {
    return isPattern(nameKindOf(F, def)); // 別名（`p : t`）
  } catch (e) {
    if (!(e instanceof OperationError)) throw e;
    if (e.guard) taint(F); // 守りの断りを握りつぶす：この先の計算は汚れる（taint）
    if (e.reason !== "name-cycle") return false; // 門は、その定義の行を解くときに出る
    // 名前の輪（§5 Q30）。既定値の中を覗いた所を通る輪（輪のいちばん下の枠が、覗く前から解いている途中）は、種類の輪では
    // ない。既定値は解かず（P3）、値の無で呼ばれたときにだけ評価する（§3.7）ので、値はできる（`v : g 1`・`g : x ? [[y : v 2]
    // ? 5] x` は v = 5）。覗くのは G7（R25）を探すためだけで、行を解く段（枠が空）で、確定した種類でもう一度覗く。だから
    // 握りつぶして「括りの関数ではない」と読み、作った言い分（F.cycleRefused）も覗く前に戻す。前（2026-10-20 の作り直し）は
    // 投げ直していて、HEAD がどの並べ方でも通していた、値のできるプログラムを name-cycle で断った（確かめ 2026-10-20 の
    // Q30-V1・ADV-1）。
    // 覗いた定義の計算の中だけで閉じる輪（輪のいちばん下の枠が、覗いてから積んだ物）は、覗いた所を通らない本物の輪なので、
    // 投げ直す（`a : g 1`・`g : x ? [[y : v 2] ? 5] x`・`v : h 1`・`h : x ? ⏎ ⇥k x ⏎ ⇥vk ⏎ ⇥inc`・`k : x ? ⏎ ⇥h x ⏎ ⇥inc`・
    // `vk : k 1` の vk → k → h → vk）。前の作り（例外で抜けた枠を輪の依りに持つ記録に印を付けない）で全部を握りつぶすと、a が先
    // なら黙って通った（5040 のうち 1680）。今は、握りつぶしても後の計算が印から同じ輪をもう一度見つける（確かめ 2026-10-20、
    // 生成器 1 万本で、全部を握りつぶす写しと答え・輪の道筋が同じ）が、見つけた本物の輪を捨てる理由が無いので、断る側に置く。
    // 1項の `:` の左（枝の条件）を覗いた所を通る輪は、投げ直す（断る側。§5 Q30 の未決）。枝の条件も解かない（P3）が、本体を
    // 実行すれば評価するので、値は本当にできない（`v : (g 1) , 1`・`g : x ? ⏎ ⇥(v 2) : 1`）。ただ、覗くのは値の定義の名前だけ
    // なので、関数を1つ挟む（`(f 2) : 1`・`f : x ? v`）と HEAD のまま通る。
    if (inDefault && e.cycleFrom < start) {
      F.cycleRefused = before;
      return false;
    }
    throw e;
  }
}

// `,`（R19・G3）。値だけの並びはそのまま `,` の内に置く。関数か未知を含む2項以上の並びが括らずに直の被演算子に
// なると、`(f x) , …` と `f (x , …)` のどちらかが決まらない（§5 Q3）ので断る。
//
// 2項以上の辺は、項の種類を1回だけ付けて G3 を見、付けた項のまま縮める。種類を付けると括りの中まで解けるので、
// G3 を見るためだけに付けて捨て、縮めるときにもう一度付けると、各段に `,` のある括りの入れ子で1段ごとに倍の時間が
// かかる（深さ 20 で数秒）。前置 `@`（L）と括らない `!_`（未知）は、種類が A でないのでここで断られる。
//
// 恒等射（`!_` 1つ・`i : !_` の i。種類が恒等射の葉）は積の単位で、`,` の被演算子にあれば消え、もう片方の被演算子が答え（木も、もう片方の
// 木そのもの）：`!_ , 5`・`5 , !_`・`i , 5` は 5、`1 , !_ , 2` は `1 , 2`、`!_ , !_` は `!_`（R45。U〔答え〕2026-10-22 23:48「5 !_ / 5 , !_
// も追加で、 全部5になるはず…」。恒等射の型 0 ⇒ 0 ≅ 1 は終対象で、1 × A ≅ A・A × 1 ≅ A。書いた `_` が余積の並びから消える 0 ⊕ A ≅ A
// （R15）の双対）。片方が恒等射なら G3 の割れも消える：`inc 1 , !_` は `(inc 1) , !_` と読んでも `inc (1 , !_)` と読んでも `inc 1`
// なので、もう片方の並びをそのまま解く。恒等射かを見るために先に解く被演算子は、恒等射になりうる綴り（`!_`・名前・それだけを括った物・
// その `,`）だけで、解けなければ G3 で断る（前と同じ断り）。恒等射を器に残したいなら `$!_`（A）と書く。
//
// 辺が `,` で、その中の `,` が恒等射で消えて並びだけが残るなら（`2 , !_ , inc 1` の右の `!_ , inc 1` は `inc 1`）、G3 はその並びで見る
// （vanishedSeq。単位律で `2 , !_ , inc 1` は `2 , inc 1` で G3。2026-10-24 の確かめで直した。前は中の `,` が消えた後の並びを外の `,` が
// 見直さず、`(, 2 (apply inc 1))` で通していた）。
//
// 印 ctx.delayed（`$[…]` の中身の行の `,`、resolveDelayed）：`,` が恒等射で消えて並びだけが残れば、その並びは中身の行の並びそのもの（R45）
// なので、遅延した式として R52 の判定をしない（reduceItems の closeIdle を外す）。中の `,` の辺（右結合の `5 inc , !_ , !_` の右）にも印を
// 渡す。消えない `,` の辺と、辺の項の中（括り・中置の辺）は中身の行の並びそのものではないので、印を外して解く（R52 を当てる）。
// 2026-10-24 の R52 の片では、同じ印を pointsTo の名前で左が名前1つの `:` の右辺に付けていた（§5 Q50 の答えで外した、resolveDefine の注）。
//
// R61（2026-10-25、§5 Q41 の答え）：`,` の被演算子に書いた `_` も積の単位で、恒等射と同じく消え、もう片方の被演算子の木が答え（`_ , 5`・`5 , _` は 5、
// `1 , _ , 2` は `1 , 2`。片方が `_` なら G3 の割れも消える：`_ , inc 1` は `inc 1`）。根拠：U [2026-10-25 08:41 533071da]「Q41 / _ , 5 も 5 , _ も 5 に
// なるはずだ。」。主の Claude の読み：Sign は点付きの側（Par）にいて、`_` は零対象（始対象かつ終対象）で、終対象は積の単位なので `_ , 5` ≅ 5（前の
// 「0 × A ≅ 0 で `_`」は点の無い集合の圏の読みで、圏を取り違えていた）。消えるのは書いた `_`（印）だけで、名前や括りを通した `_`（`un : _` の un・
// `[_]`）は今までどおり閉じた1つの項（R56 の R の所と同じ、並びの中の `[_] 5` が `(construct [_] 5)` なのと揃える）。
// 両方とも単位なら（R の所）：両方とも書いた `_`（`_ , _`）は `_`（どちらを残しても同じ葉）。書いた `_` と恒等射（`_ , !_`・`!_ , _`・`_ , i`）は、
// `_` が消えれば恒等射が残り、恒等射が消えれば `_` が残り、残る物が値の `_`（零射の顔）か恒等射かで答えが割れる（R45 の「両方とも恒等射なら
// `!_` を残す」は、どちらを残しても同じ恒等射だから言えた）ので、名指しで断る（G7、§5 Q61。圏論の視点で見直す所）。前（R45 だけ）は恒等射が
// 消えて `_` が残った（`!_ , _` は `_`、`$[_ , !_]` は零射の番地、R56）。
function resolveProduct(tree, ctx) {
  if (isBlockSeq(tree.left)) throw refuseIndentBlock("`,` の左");
  const delayed = !!ctx.delayed;
  const cx = delayed ? { ...ctx, delayed: false } : ctx;
  const sideCtx = (side) => (delayed && side && side.type !== "seq" && side.sym === "," ? ctx : cx);
  const both = [tree.left, tree.right];
  const isMulti = (side) => !!side && side.type === "seq" && side.terms.length >= 2;
  const multi = both.map(isMulti);
  const eff = both.map((side, j) => (multi[j] ? side : vanishedSeq(side, cx)));
  const sides = eff.map((side) => (isMulti(side) ? classifyItems(side.terms, cx) : null));
  const g3 = sides.map((items) => !!items && items.some((c) => c.cat !== "unit" && c.desc.k !== "A"));
  const j = g3.indexOf(true);
  if (j >= 0) {
    const o = 1 - j;
    if (!g3[o] && !multi[o] && mayBeUnit(both[o])) {
      let other = null;
      try {
        other = resolveTree(both[o], cx);
      } catch (e) {
        if (!(e instanceof OperationError)) throw e;
      }
      if (isUnitOperand(other)) return reduceItems(sides[j], cx, false, !delayed);
    }
    throw gate("G3", `\`,\` の被演算子 \`${writeTree(both[j])}\` は関数か種類の未知な物を含む余積の並びです。括って書きます（§5 Q3）。`);
  }
  const left = multi[0] ? reduceItems(sides[0], cx) : resolveTree(tree.left, sideCtx(tree.left));
  const right = multi[1] ? reduceItems(sides[1], cx) : resolveTree(tree.right, sideCtx(tree.right));
  // 両方とも恒等射（1 × 1 ≅ 1）なら、`!_` の葉を残す（無ければ右）。どちらを残しても恒等射だが、段4〜8 の中置の被演算子では `!_` は
  // G7（§5 Q15）、名前の i は通るので、残す方を並べた順で選ぶと `!_ , i == 1` と `i , !_ == 1` が割れる（確かめで見つかった、2026-10-23）。
  // 断る側の `!_` に揃える。
  if (isIdentity(left) && isIdentity(right)) return left.cat === "hole" ? left : right;
  // 書いた `_` も積の単位（R61）。両方とも `_` なら `_`、片方が恒等射なら残る物が割れるので断る（上の注、§5 Q61）。
  const lu = isMark(left);
  const ru = isMark(right);
  if (lu && ru) return left;
  if ((lu && isIdentity(right)) || (ru && isIdentity(left))) {
    throw gate(
      "G7",
      `\`,\` の両方の被演算子 \`${writeTree(tree.left)}\` と \`${writeTree(tree.right)}\` が積の単位（書いた \`_\` と恒等射）です。書いた \`_\` が消えれば恒等射が残り、恒等射が消えれば \`_\` が残るので、残る物（値の \`_\` か恒等射か）が割れます。どちらを残すかは決まっていません（§4 R45・R61、§5 Q41・Q61）。`
    );
  }
  if (lu || isIdentity(left)) return right;
  if (ru || isIdentity(right)) return left;
  return { t: "op", sym: ",", left, right, kind: A() };
}

// `,` の辺 side の中の `,` が恒等射で消えて残る並び（R45）。side が `,` で、片方の辺が恒等射なら、もう片方の辺（それも `,` なら、さらに
// その中）。消えなければ side そのもの。恒等射かを見るのは resolveProduct と同じく、恒等射になりうる綴り（mayBeIdentity）だけ。
// `,` の辺は、両辺が恒等射のときだけ恒等射（1 × 1 ≅ 1。resolveProduct の答えと同じ）なので、`,` を丸ごと解かずに辺ごとに見る：
// 丸ごと解くと、名前の `,` の鎖で1段ごとに残りの鎖を解き直し、深さ 40 で数分かかった（2026-10-24 の確かめの直しの後に見つけた）。
function vanishedSeq(side, ctx) {
  if (!side || side.type === "seq" || side.sym !== ",") return side;
  const idOf = (t) => {
    if (!mayBeUnit(t)) return false;
    if (t.type !== "seq") return idOf(t.left) && idOf(t.right);
    try {
      return isUnitOperand(resolveTree(t, ctx));
    } catch (e) {
      if (!(e instanceof OperationError)) throw e;
      return false;
    }
  };
  if (idOf(side.left)) return vanishedSeq(side.right, ctx);
  if (idOf(side.right)) return vanishedSeq(side.left, ctx);
  return side;
}

// 恒等射の葉（`!_` 1つ・`i : !_` の i・それを括った物。R29・R44・R45）。
function isIdentity(t) {
  return !!t && t.t === "leaf" && !!t.kind && t.kind.k === "L" && !!t.kind.fn && t.kind.fn.type === "id";
}
// `,` の単位の葉（R45・R61）：恒等射か、書いた `_`（印）。
function isUnitOperand(t) {
  return isIdentity(t) || isMark(t);
}
// `,` の単位になりうる綴り（R45・R61）：恒等射になりうる綴り（mayBeIdentity）と、書いた `_` 1つ。それどうしの `,` も。
function mayBeUnit(tree) {
  if (!tree) return false;
  if (tree.type !== "seq") return tree.sym === "," && mayBeUnit(tree.left) && mayBeUnit(tree.right);
  if (tree.terms.length === 1) {
    const t = tree.terms[0];
    if (t.type === "atom" && !t.pre.length && !t.post.length && t.core.c === "unit") return true;
  }
  return mayBeIdentity(tree);
}
// 恒等射になりうる綴り（resolveProduct が、G3 の前に解いて見る物）：`!_`・裸の名前・それだけを1行で括った物・それどうしの `,`。
// 関数を呼ぶ形を含まないので、解いても実体を作らない。
function mayBeIdentity(tree) {
  if (!tree) return false;
  if (tree.type !== "seq") return tree.sym === "," && mayBeIdentity(tree.left) && mayBeIdentity(tree.right);
  if (tree.terms.length !== 1) return false;
  const t = tree.terms[0];
  if (t.type !== "atom" || t.post.length) return false;
  if (t.pre.length) return t.pre.length === 1 && t.pre[0] === "!" && t.core.c === "unit";
  if (t.core.c === "name") return true;
  return t.core.c === "bracket" && t.core.rows.length === 1 && mayBeIdentity(t.core.rows[0]);
}

// 根の `,` が恒等射で消えて片方の並びだけが残った行（R45）。その行の根は残った並びで、評価する所（R42）なので、並びを根に書いたときと
// 同じく、いちばん上に残った未評価のラムダを `_` にする（`!_ , !_` は `(unit !_)`、`inc add 5 , !_` は `inc add 5` と同じ `(unit …)`）。
// 被演算子は評価する所の外で解いてある（finishTrees の evaluate なし）ので、ここで包み直す：構築ならいちばん後ろの項、ほかは木そのもの。
// 余ったラムダを知らせるのも、行の根に書いたときと同じ（R48）。
function evaluated(tree, ctx) {
  if (!tree || !tree.kind) return tree;
  if (tree.t === "construct") {
    const last = tree.items[tree.items.length - 1];
    if (last.kind.k !== "L") return tree;
    const items = [...tree.items.slice(0, -1), leftoverUnit(last, ctx)];
    return { t: "construct", items, kind: items.some((x) => x.kind.k !== "A") ? U() : A() };
  }
  return tree.kind.k === "L" ? leftoverUnit(tree, ctx) : tree;
}

function isBlockSeq(tree) {
  return !!tree && tree.type === "seq" && tree.terms.length === 1 && isBareIndent(tree.terms[0]);
}

// 関数の範囲。鍵は外の範囲と書いた `?` で決まる（仮引数は書いた綴りで決まり、局所の名前も本体の綴りで決まる）。
// 実体の範囲は、この鍵を実体の鍵で置き換え、仮引数に当てた desc を持つ（instantiate）。
// defRows は局所の定義を探す行（R54、localDefsOf）：字下げのブロックの本体ならその行、ほかは本体そのもの1つ。
function makeLambda(op, ctx) {
  const params = parseParams(op.left);
  const body = op.right;
  const scope = {
    parent: ctx.scope,
    params: new Map(params.names.map((p) => [p.name, p.cls])),
    locals: new Set(),
    hasImport: hasImportIn(op.right),
    key: `${ctx.scope.key}/${lambdaKey(op, "")}`,
    defRows: body && body.type === "seq" && body.terms.length === 1 && isBareBlock(body.terms[0], "indent") ? body.terms[0].core.rows : [body],
  };
  // 素の関数なら、裸の仮引数の札（paramTag）のために書いた `?` と位置を持つ（lookup）。
  if (params.plain) {
    scope.plainOp = op;
    scope.plainKey = lambdaKey(op, ctx.scope.key); // 関数の出どころ（fn.idKey と同じ綴り）
    scope.paramIdx = new Map(params.names.map((p, i) => [p.name, i]));
  }
  scanLocals(op.right, scope, ctx.F);
  return { params, scope };
}

// G16（R33、§5 Q21 の答え）：`?` で作る関数の本体の根が裸の関数（L）。関数を返すなら `$` を明示する（U 09-11 23:58「関数を返す
// 関数なら、$は明示というルール」、U 10-21 12:50「adder が返すべきは [+ m] じゃなくて $[+ m]」。U〔答え〕10-21 15:58：書く人が `$` を
// 書く）。カリー化はシステムの側が持つ（U〔答え〕10-21 16:02「実際には断る形なんだよ。 / 理由は、カリー化はシステムの側で持つべき。」）
// ので、入れ子の `?` も断る。警告で通さないのは、裸の関数は書いた行の中でしか生きない（U 09-11 03:47）ので、返した時にはもう無く、
// 本体のコードが作れないから（主の Claude の読み。警告の案に U 10-21 15:59「それって、コンパイラの状態で可能なの？ / 普通に止まると
// 思うんだけど…」）。呼ばれない定義でも断る（本体そのものがコードにできない。公開 `#` すればコンパイルされる）。
// 根は、解き終えた所（解いている途中の種類が無い、F.stack が空）で解いた本体の木の根で見る：名前の定義と無名の `?` は行を解く
// 所（resolveLambda）、括りの関数の実体は木を残す段（materialize）。§3.4 の仮置きの上（根の種類を解く所）では断らない。仮置きの
// 上でだけ L になる根（`h : x ? [s : [+ [k x]]] ' s`・`k : x ? h x` の h は、k の仮置き A の上では引いた区間で L、確定した値の上では
// 未知）で断ると、どの定義から解くかで断るかが割れ、門で未知にした根が外の本体の答えまで変える（「仮置きの記録」の注の単調は、
// 根が A か A でないかだけを見る）。自分を呼ぶ再帰で仮置きが外れた関数は、§3.4 の根は未知だが、解き終えた木の根が L なら断る
// （`f : x ? [y ? f y]`。本体は裸の関数のままで、コードにできない。断る側。実装する人の読み）。
// 種類のほかに綴りも見る：根の綴りが区間（sectionSpelled）なら、種類が未知でも断る。§2 の表は区間を被演算子の種類に依らず L
// （94）にするが、pointfreeOf は被演算子が A でなければ区間の種類を未知にする（当てた結果の読みが §5 Q22 で決まっていないので、
// 並びの中では G7 にする側）。その未知が根では G16 をすり抜けて、区間を返す本体（`ww : x ? [+ [uu x]]`・`q : x ? [+ inc]`。前の
// `h : x ? [+ [k x]]` も）を黙って通していた（確かめ 2026-10-22。直す人の読み）。綴りは仮置きに依らないので、どの定義から解いても同じ。
// what は名指し（「関数 `adder` の」。実体は呼んだ行で instanceError が関数と形を足すので空）。
// 言い分：入れ子の `?`（`add : x ? y ? x + y`）は手で書いたカリー化なので、`$` を勧めず、仮引数を並べる書き方だけを勧める
// （U〔答え〕10-21 16:02「理由は、カリー化はシステムの側で持つべき。 / ユーザーが明示はね…」）。
// `$` で包んだ入れ子の `?`（`add : x ? $[y ? x + y]`）は当たらない：`$[+ m]` と同じく、外の仮引数を掴んだ関数を `$` で物にして返す
// 形で、本体の根は A（U〔答え〕10-21 22:46「通して不都合がないなら通していいよ。」。不都合が無いという見立ては主の Claude の物。
// 前は G17 で断っていた）。
function bareReturnGate(what, root) {
  const nested = root.t === "lambda" || !!root.isQBracket;
  const advice = nested
    ? "カリー化はシステムの側が持つので、入れ子の `?` で関数を返さずに、仮引数を並べて書きます（`x y ? x + y`。足りない適用は自動で部分適用になります）"
    : "関数を返すなら `$` を明示して値にします（`$[+ m]`）。カリー化はシステムの側が持つので、関数を返す代わりに仮引数を並べて書きます（`x y ? x + y`。足りない適用は自動で部分適用になります）";
  return gate(
    "G16",
    `${what}本体の根 \`${cutShape(show(root))}\` が裸の関数です。裸の関数は書いた行の中でしか生きないので、返した時にはもう無く、本体のコードが作れません。${advice}（§4 R33、§5 Q21）。`
  );
}
// 根の綴りが区間（段12〜22 の片側の欠けた点なし `[+ X]`・`[X +]`・`[@ X]` と、貪欲な `[* X,]`。1行の括りに包んだ `[[+ X]]`・
// `([+ X])` も）か。被演算子の種類は見ない（G16 の注）。
function sectionSpelled(tree) {
  return !!tree && tree.t === "leaf" && !!tree.term && sectionTerm(tree.term);
}
function sectionTerm(term) {
  if (!isBareBlock(term, "bracket") || term.core.rows.length !== 1) return false;
  const row = term.core.rows[0];
  const one = (t) => (t && t.type === "seq" && t.terms.length === 1 ? t.terms[0] : null);
  const unary = (x) => !!x && x.type === "infix" && x.stage >= 12 && x.stage <= 22 && (x.left === null) !== (x.right === null);
  if (row.type === "op") return row.sym === "," && row.right === null && unary(one(row.left));
  const x = one(row);
  return unary(x) || sectionTerm(x);
}

// 本体の根で断る門（G16）。断らないなら null。what は名指しを返す関数（断るときだけ作る）。
function returnGate(what, body) {
  if (body.rootKind === "L" || sectionSpelled(body.tree)) return bareReturnGate(what(), body.tree);
  return null;
}

// `?`（P3：左は解かず、右を関数の範囲で解く）。片側の欠けた `?` は点なし（unwrapLambda の注）なので、種類は未知。
// 括りの関数は、ここでは本体を解かない（R25）。木は resolve の最後に、集めた実体で埋める（patternNode）。
// 解き終えた所で本体の根が L か区間の綴りなら G16（returnGate）。
function resolveLambda(op, ctx) {
  if (isSection(op)) {
    return { t: "lambda", paramsText: op.left ? writeTree(op.left) : "", body: op.right ? resolveTree(op.right, ctx) : null, kind: U() };
  }
  const pattern = patternParamsOf(op.left);
  if (pattern) return patternNode(op, pattern, ctx);
  const inDefault = patternCallInDefaults(op.left, ctx);
  if (inDefault) {
    throw gate(
      "G7",
      `仮引数の既定値の中で括りの関数 \`${inDefault}\` を呼んでいます。\`?\` の左は解かない（P3）ので、ここで呼んでも実体が作れず、本体の読みが決まりません（R25）。`
    );
  }
  const lam = makeLambda(op, ctx);
  const named = ctx.F.namedLambdas.has(op);
  // 無名の素の関数は、本体を解く間に引いた仮置きを覚える（collectedRoot の注）。
  const col = lam.params.plain && !named ? beginCollect(ctx.F, `無名の関数 \`[${cutShape(writeTree(op))}]\` の本体`) : null;
  let body;
  try {
    body = resolveBody(op.right, { ...ctx, scope: lam.scope });
  } finally {
    if (col) endCollect(ctx.F, col);
  }
  const refused = returnGate(() => `関数 \`${named ? ctx.F.namedLambdas.get(op).name : `[${cutShape(writeTree(op))}]`}\` の`, body);
  if (refused) {
    // 根の種類を解く所（前段、F.stack が空でない）では断らない（bareReturnGate の注）。ただ、木を残す段はここで行ごと断るので、
    // いまの枠のこの後ろで作る実体は最後の木に無い（INSTANCE_DEPTH_MARGIN の注の2。門に当たる実体を呼んだ所と同じ gated）。前は
    // 数えていたので、その後ろの括りの関数の確定した実体が上限の境目にあると、G16 の代わりに総数の G7 を言った（確かめ 2026-10-22）。
    // 仮置きを読んで L になった根でも、仮置きが当たれば木の根も L、外れれば後ろの呼び出しは頼った枠と一緒に外す（settlePending）ので、
    // どちらでも数えないのが最後の木の数である。
    if (!ctx.F.stack.length) throw refused;
    ctx.F.stack[ctx.F.stack.length - 1].gated = true;
  }
  let fn = otherFn(op.left);
  if (lam.params.plain) {
    fn = {
      type: "plain",
      origin: "plain",
      n: lam.params.names.length,
      getBodyRoot: named
        ? () => bodyRootOf(ctx.F, op)
        : collectedRoot(ctx.F, col, body.rootKind, () => resolveBody(op.right, { ...ctx, scope: lam.scope, diag: null }).rootKind),
      idKey: lambdaKey(op, ctx.scope.key),
      envDepth: envDepth(ctx.scope), // 鍵の深さ（fnDepth）
      op, // 裸の仮引数の札（paramTag）と、Reader を口に渡した呼び出しの言い分（readerAtPlain）
      label: named ? ctx.F.namedLambdas.get(op).name : null, // 無名なら書いた綴り（断るときだけ作る、readerAtPlain）
    };
  }
  return { t: "lambda", paramsText: op.left ? writeTree(op.left) : "", body: body.tree, kind: { k: "L", fn } };
}

// 括りの関数の `?` の木。名前の定義なら名前で、`?` の括りなら書いた綴りで名指しする（呼んだ行で断るときの言い分）。
// 本体の中の名前は読まないので、未定義でも information を出さない（R25：読まない本体）。
function patternNode(op, pattern, ctx) {
  const def = ctx.F.namedLambdas.get(op);
  const label = def ? def.name : `[${writeTree(op)}]`;
  const fn = patternFn(ctx.F, op, pattern, ctx.scope, label);
  const body = op.right;
  const deferText =
    body && body.type === "seq" && body.terms.length === 1 && isBareBlock(body.terms[0], "indent")
      ? body.terms[0].core.rows.map(writeTree).join(" ⏎ ")
      : writeTree(body);
  const node = { t: "lambda", paramsText: writeTree(op.left), pattern: { op, scopeKey: ctx.scope.key, deferText, insts: null }, kind: { k: "L", fn } };
  ctx.F.patternNodes.push(node);
  // `$` の先を解いている所（受け皿 ctx.dead、R59）で書いた括りの関数（`$[[x] ? f2 (5 inc) 1]`）は、仮引数を含まない行の余る関数を拾う（deadInPatternBody。
  // 覗くのは木を残す段だけ、deadOfDef の注）。
  if (ctx.dead && !ctx.F.stack.length) {
    const dead = deadInPatternBody(ctx.F, op, ctx.scope);
    if (dead) ctx.dead.push(dead);
  }
  return node;
}

// 関数の本体を解く。返す物は {tree, rootKind}。字下げのブロックの本体は、全部の行（枝なら値の側）の根が A の
// ときだけ A（§3.4）。局所の定義の行は、定義か枝か決まらないので A に数えない。
function resolveBody(right, ctx) {
  if (right && right.type === "seq" && right.terms.length === 1 && isBareBlock(right.terms[0], "indent")) {
    const rows = right.terms[0].core.rows.map((r) => resolveTree(r, ctx));
    refuseReturnedAddress(rows);
    const k = blockBodyKind(rows);
    const term = right.terms[0];
    return { tree: { t: "leaf", term, cat: "plain", desc: { k }, kind: { k }, view: { v: "block", rows } }, rootKind: k };
  }
  const tree = resolveTree(right, ctx);
  refuseReturnedAddress([tree]);
  return { tree, rootKind: tree ? tree.kind.k : "U" };
}

// 関数の本体が返しうる値（根。字下げの本体なら全部の行の値の側：局所の定義の右辺・枝の値・行そのもの。入れ子のブロックはその行）に、番地の算術で作った
// 点・差（R62）があれば断る（2026-10-26 の確かめの直し、hasAddr の注）。関数の答えは本体の根の種類だけで持つ（素の関数の getBodyRoot・括りの関数の
// instRootOf は "A"/"U"）ので、印を答えに持たせられない。局所の定義の右辺は、名前が種類の未知な局所の名前（P2）になって印が落ちる（`ww : $x + 0x10` ⏎
// `ww + 1` は未知で通っていた）。HEAD は中の算術を G7 で断っていた。
function refuseReturnedAddress(rows) {
  const valueSide = (t) => (t && t.t === "op" && t.sym === ":" ? t.right : t);
  for (const row of rows) {
    const v = valueSide(row);
    if (v && v.t === "leaf" && v.view && v.view.v === "block") {
      refuseReturnedAddress(v.view.rows);
      continue;
    }
    if (treeHasAddr(v)) throw refuseAddressDrop("return", cutShape(show(v)));
  }
}

function blockBodyKind(rows) {
  const valueKind = (t) => {
    if (!t) return "U";
    if (t.t === "leaf" && t.view.v === "block") return blockBodyKind(t.view.rows);
    return t.kind.k;
  };
  const rowKind = (row) => {
    if (row && row.t === "op" && row.sym === ":") return row.isLocalDef ? "U" : valueKind(row.right);
    return valueKind(row);
  };
  return rows.every((r) => rowKind(r) === "A") ? "A" : "U";
}

// ---------------------------------------------------------------------------
// 余積の並びを解く（§3.3 の手順、R40〜R43・R47・R48）：並びを左から1項ずつ畳む
// ---------------------------------------------------------------------------
//
// 余積は1つの演算子で、左結合（R40）。並びは左から1項ずつ畳み、溜まった物は積み上げで、次の項はいちばん上の項とだけ結ぶ。
// 畳み込みの1歩は3行（R47、2026-10-24）：
// - いちばん上 L・次 A：適用。口を1つ埋める。全部埋まれば、本体の根の種類になる
// - いちばん上 L・次 L：合成。後から来る物は、最初の関数から順に流れ込む
// - いちばん上 A か空：次の項を積む（次が A なら構築。次が L も積み、積まれた L は、その後に来る項を右から受ける。関数は右からだけ受ける）
// 可変長の口（最後の括り `[~c]`、畳む点なし、`[* 2,]` など）は並びの終わりまで受け、1つ以上受けていれば終わりで閉じる（R41）。
// 評価する所（`:` の右辺でない行の根の並び）で、終わりに未評価のラムダが残れば `_` になり、並びの中では消える（R42・R15）。そのとき
// 恒等射でなければ warning で知らせる（R48、reportLeftover）。評価する所の外でも（`:` の右辺も。除くのは `$[…]` の中身の並びだけ）、終わりに
// 値の上に積まれて口の開いたまま閉じた関数が残れば、同じく `_` で、知らせる（R52、2026-10-24。受けた後の関数・穴の関数も、手順7）。
// 書いた `_` と `!_` は、口を1つ埋める所で読む（R43）。
// 根拠：U [2026-10-23 13:12 ebf18260]「いやこれ、むしろ2引数を断るなら逆適用の意味が余計に薄い上に構文が乱れる元だから、廃止だね。
// 逆適用は廃止しよう」。主の Claude の問い「A の後の L は積む（関数は右からだけ受ける）。根でラムダが余って `_` になったら診断で知らせる。
// これでいい？」に、U〔答え〕[2026-10-23 15:32 ebf18260]「合ってる。 それでOK！」。左結合そのものは U 2026-10-22 11:24 ebf18260「…余積は
// 左結合で解決できるはずだと睨んでた。」と、規則の文面へのボタン「作り直す」（U〔答え〕10-22 22:15）。
// 2026-10-23 までの4行目は「いちばん上 A・次 L：逆適用。L が、いちばん上の A を取る」で、主の Claude の問い「左結合なら、`5 inc 3` は
// `(inc 5) 3`（値は [6 3]）でいい？」への U〔答え〕10-22 11:24「そう、合ってる。」は、逆適用がある前提の答えだった。R47 で上書きされ、
// `5 inc 3` は `5 (inc 3)`。
// 前（2026-10-22 まで）は、強さの順（合成 > 適用 > 逆適用、R6）で対を探して縮め、一度まとめた並びを後でほどき直していた（take・
// leftover・流れの組み立て直し・restAt）。どれも、強さの順で先にまとめた物を、左からの読みに戻すための仕組みだった。

function leafOf(term, c) {
  return {
    t: "leaf",
    term,
    cat: c.cat,
    desc: c.desc,
    kind: c.desc,
    view: c.view,
    isLambdaName: !!c.isLambdaName,
    isQBracket: !!c.isQBracket,
    count: c.count === undefined ? null : c.count,
    strCount: c.strCount === undefined ? null : c.strCount,
  };
}

// 評価する所（R42）は、resolve が行の根の並びに付けた印 ctx.evaluate だけ。項の中（括り・囲み・中置）は評価する所でないので、
// 印を外してから項を作る。
// 印 ctx.delayed は、`$[…]` の中身の行の並び（resolveDelayed）。そこだけは遅延した式なので、値の上に積まれて口の開いたまま閉じた関数を
// ラムダのまま残す（R52 の判定をしない、§5 Q52 の答え）。項の中は中身の行の並びそのものではないので、これも外してから項を作る。
function resolveSeq(terms, ctx) {
  const evaluate = !!ctx.evaluate;
  const delayed = !!ctx.delayed;
  const inner = evaluate || delayed ? { ...ctx, evaluate: false, delayed: false } : ctx;
  return reduceItems(classifyItems(terms, inner), inner, evaluate, !delayed);
}

// 0. 項を作る。字下げのブロックは並びの項にならない（§2、refuseIndentBlock の注）。
function classifyItems(terms, ctx) {
  if (terms.length >= 2 && terms.some(isBareIndent)) throw refuseIndentBlock("余積の並びの項");
  return terms.map((t) => leafOf(t, classify(t, ctx)));
}

// closeIdle は、値の上に積まれて口の開いたまま閉じた関数を余ったラムダにする並びか（R52。`$[…]` の中身の行の並びと、その `,` が恒等射で
// 消えて残った並びだけ false。遅延した式、§5 Q52 の答え。resolveDelayed）。
function reduceItems(items, ctx, evaluate = false, closeIdle = true) {
  // 1項の並びは、その項そのもの（手順の3）。`!_` 1つは恒等射（L）、書いた `_` 1つは印（A）にする（single）。
  if (items.length === 1) return finishTrees([single(items[0])], evaluate, ctx);

  // 1. 前検査
  const unknown = items.find((i) => i.cat === "plain" && i.desc.k === "U");
  if (unknown) {
    throw gate("G7", `種類の決まらない項 \`${showView(unknown.view)}\` が余積の並びにあります。隣とどう結ぶかが決まりません（R24・R26・R31、§5 Q9・Q10・Q14・Q19・Q22）。`);
  }
  if (items.some((i) => i.cat === "ptilde")) {
    throw gate("G4", "前置 `~` の項が2項以上の並びにあります。前置 `~` の被演算子は決まっていません（§5 Q14）。");
  }
  items.forEach((it, i) => {
    if (it.cat !== "input") return;
    if (i !== 0) throw gate("G6", `前置 \`@\` の項 \`${showView(it.view)}\` が並びの頭以外にあります（§5 Q9）。`);
    const r = items[1];
    if (r && r.cat === "plain" && r.desc.k === "L") throw gate("G6", `前置 \`@\` の項 \`${showView(it.view)}\` のすぐ右が関数です（§5 Q9）。`);
  });

  // 2. 穴 `!_` と、穴として数える書いた `_`（§3.5、R16・R34・R38）。穴の規則の中身（頭の後ろの並びが全部その実引数の並びで、穴でない項が
  //    全部 A・撒く項が無い・最後の項が `_` でない）は、頭から並びの終わりまでの形の条件なので、畳む前に見る（R43。中身は今のまま）。
  //    読める並びなら穴の関数（か、穴を埋めた適用）がそのまま答え。括りの関数の実引数の `!_`（G5）と、穴と実引数の数が合わないのに
  //    R34 が読まない並び（G13）は断る（holeSeq）。値の後ろに積まれた関数の並びも同じに見る（手順3〜6 の subHole、R47）。
  //    残った `!_` は畳み込みの1歩で読む（holeStep）：口の外は恒等射（R44）、口の中は穴と恒等射が同じ関数になる所だけ通す（R46）。
  const hole = holeSeq(items, ctx);
  if (hole) return finishTrees([hole], evaluate, ctx);

  // 3〜6. 左から畳む（R40・R47）。いちばん上が値か空の所に関数 F が来たら、F と後ろの並び Y は、括った `(F Y)` と同じ1つの並び
  //    （R47：積まれた関数は後ろの項を右から受け、前の値は取らない）なので、手順2 の穴の規則も、その並びを頭 F の並びとして見る
  //    （subHole、2026-10-24 の確かめで直した。前は並び全体の頭だけを見ていて、`5 inc _ 7` が G5・`5 (inc _ 7)` が `5 (inc 7)`、
  //    `5 add 1 2 !_` が通り・`5 (add 1 2 !_)` が G13 と、括るかどうかで割れていた）。
  const st = { stack: [], mark: null, items, topAt: null };
  const marked = suffixMarked(items);
  for (let i = 0; i < items.length; i++) {
    const sub = i > 0 && marked[i] ? subHole(st, i, ctx) : null;
    if (sub) {
      st.stack.push(sub);
      st.topAt = items[i].term || items[i]; // 穴の関数を積んだ項の書いた所（R52 の知らせ、手順7）
      break;
    }
    foldStep(st, i);
  }
  // 7. 終わり：可変長の口を閉じ（R41）、残った関数は評価する所なら `_`（R42）で、知らせる（R48）。評価する所の外でも、値の上に積まれて
  //    口が開いたまま閉じた関数は `_` で、知らせる（R52）。
  //    積み上げが2項以上なら、いちばん上の関数は値の上に積まれた物（積み上げの中で関数がいられるのは、いちばん上だけ。finishTrees の注）。
  //    その関数が値の上で何かを受けた後（`5 add 1`）でも、穴の関数（`5 f2 !_`）でも同じ：値の上に積まれたのは `(F Y)` の1項（法則5：`X F Y`
  //    は括った `X (F Y)` と同じ）で、括った `(add 1)`・`(f2 !_)` は値の上で何も受けずに閉じた関数そのもの（R52 の文面）なので、括らない綴りも
  //    同じ答えでなければならない（2026-10-24 の確かめの指摘。前は「何も受けない」を積み上げの項の中の記録で見て、`(5 add 1) 3` が G7・
  //    `(5 (add 1)) 3` が A と割れていた）。知らせる所は、その関数を積んだ項の書いた所（st.topAt）。
  const at = closeIdle && st.stack.length >= 2 ? st.topAt : null;
  const trees = st.stack.map((e) => (e.t === "fn" ? closeEntry(e) : e));
  if (!trees.length) return single(st.mark); // 書いた `_` だけの並び（R15。`_ _` は `_`）
  return finishTrees(trees, evaluate, ctx, at);
}

// 手順2：穴 `!_` と、穴として数える書いた `_`（§3.5、R16・R34・R38）を、頭 items[0] の並びとして見る。読める並びなら、穴の関数（か、
// 穴を埋めた適用）の木を返す。括りの関数の頭の口を値で埋めた後ろの `!_`（G5）と、穴と実引数の数が合わないのに R34 が読まない並び（G13）
// は断る（holeRefusal・g13Of）。当たらなければ null（畳み込みの1歩が読む）。
function holeSeq(items, ctx) {
  if (!(items.some(isMark) || items.some(isHoleItem)) || items.every(isMark)) return null;
  const hole = tryHole(items, ctx);
  if (hole) return hole;
  const refusal = items.some(isHoleItem) ? holeRefusal(items) : g13Of(items);
  if (refusal) throw refusal;
  return null;
}

// i から後ろに、書いた `_` か `!_` があるか（subHole を呼ぶかの目安）。
function suffixMarked(items) {
  const out = new Array(items.length + 1).fill(false);
  for (let i = items.length - 1; i >= 0; i--) out[i] = out[i + 1] || isMark(items[i]) || isHoleItem(items[i]);
  return out;
}

// 畳み込みの i 番目に関数 F が来て、いちばん上が値か空（前の値は F に届かない、R47）なら、F と後ろの並びを1つの並びとして手順2 で見る
// （holeSeq。`X F Y` と `X (F Y)` は同じ、法則5）。いちばん上が関数（F は合成の後ろ）か、種類の未知な値（G2(a) は畳み込みが言う）なら見ない。
function subHole(st, i, ctx) {
  const x = st.items[i];
  if (x.cat !== "plain" || x.kind.k !== "L") return null;
  const top = st.stack[st.stack.length - 1];
  if (top && (top.t === "fn" || top.kind.k !== "A")) return null;
  return holeSeq(st.items.slice(i), ctx);
}

// 積み上げを木にする。評価する所（R42）で、いちばん上に未評価のラムダが残れば `_`：木では元の木を `(unit …)` で包む（§1.3）。
// そのとき、恒等射でなければ warning で知らせる（R48、reportLeftover）。
// 評価する所の外（`:` の右辺も。`$[…]` の中身の並びを除く）でも、いちばん上が値の上に積まれて口の開いたまま閉じた関数（at がある）なら、
// 同じく `_` にして知らせる（R52、2026-10-24）。逆適用は無い（R47）ので、値の後ろの関数は前の値を取らず、並びが閉じた後に実引数を受ける
// 道も無い（`(5 inc) 3` の 3 は括りの外の項で、括りの中の inc には届かない）。値の上で受けた後の関数（`(5 add 1)`）と穴の関数（`(5 f2 !_)`）も
// 同じ（法則5 で `(5 (add 1))`・`(5 (f2 !_))` と同じ、reduceItems の手順7）。並び全体が1つの関数（下に値が無い）なら、評価する所の外では
// 今までどおりラムダのまま残す（括りの中なら後から当てられる。辺・本体などに広げるかは §5 Q37）。
// 2項以上なら構築（R8：子の構築は開いて並べる）。いちばん上が関数で下に値がある構築が残るのは、`$[…]` の中身の並び（`$[5 inc]`。遅延した
// 式で R52 の判定をしない）だけで、種類を決めない（未知）：値の並びの後ろに、まだ口の開いた関数が残った物（§5 Q38・Q52）。2026-10-24 の
// §5 Q50 の答えまでは、左が名前1つの `:` の右辺の並び（`v : 5 inc`）もここだった。
// 積み上げの中で口の開いた関数が残るのは、いちばん上だけである：積んだ関数は次の項を受けるか合成し（R47）、口が全部埋まれば値になる。
function finishTrees(trees, evaluate, ctx, at = null) {
  const last = trees.length - 1;
  if (trees[last].kind.k === "L") {
    if (evaluate) trees[last] = leftoverUnit(trees[last], ctx);
    else if (at) trees[last] = leftoverUnit(trees[last], ctx, at);
  }
  if (trees.length === 1) return trees[0];
  const items = trees.flatMap((g) => (g.t === "construct" ? g.items : [g]));
  return { t: "construct", items, kind: trees.some((t) => t.kind.k !== "A") ? U() : A() };
}

// 評価する所の終わりに余った未評価のラムダ（R42）を `_` にした木 `(unit …)`。恒等射でなければ知らせる（R48）。
// at は R52 で包んだときの、積まれた関数の書いた所（知らせるのは書いた所ごとに1回、reportLeftover）。評価する所（根）では null。
function leftoverUnit(tree, ctx, at = null) {
  // `$` の先を解いている所（受け皿 ctx.dead がある、R59）なら、余ったラムダを拾う（恒等射は落としても当てても値が同じなので拾わない）。
  if (ctx && ctx.dead && !isIdentityKind(tree.kind)) ctx.dead.push(tree);
  reportLeftover(tree, ctx, at);
  return { t: "unit", inner: tree, kind: A() };
}

// R48：評価する所の終わりに余った未評価のラムダは、断らずに知らせる（`5 inc` を 6 のつもりで書いても、黙って 5 に
// なる所。主の Claude の問い「…根でラムダが余って `_` になったら診断で知らせる。これでいい？」に U〔答え〕[2026-10-23 15:32 ebf18260]
// 「合ってる。 それでOK！」）。重さは warning（DIAG_SEVERITY。2026-10-24 の §5 Q44 の答えで information から上げた。断らないのは今までどおり）。
// 名前と言い分は実装する人が決めた。
// 知らせないのは、余ったのが恒等射のとき（`!_`・`i : !_` の i・恒等射どうしの合成。落としても当てても値が同じなので、失う物が無い。
// `5 !_` は 5、根に1つの `!_` は `_` で、U [2026-10-22 23:41 ebf18260]「…!_ だけを評価したら _ に戻るのは都合がいいねって話。」）。
// 恒等射どうしの合成（`i i`）を恒等射に数えるのは、圏の単位律（id ; id = id）から（R）。
// R52（at がある）：評価する所の外で、値の上に積まれて口の開いたまま閉じた関数。名前と重さは R48 と同じで、言い分だけ置かれた所を言う。
// 本体は括りの関数の実体ごとに読み直す（materialize）ので、書いた所（at）ごとに1回だけ知らせる（reportNotFolded と同じ）。
function reportLeftover(tree, ctx, at = null) {
  if (!ctx || !ctx.diag || isIdentityKind(tree.kind)) return;
  if (at && ctx.F) {
    if (ctx.F.reportedLeft.has(at)) return;
    ctx.F.reportedLeft.add(at);
  }
  const name = show(tree);
  pushDiag(
    ctx,
    "leftover-lambda",
    name,
    at
      ? `未評価のラムダ \`${name}\` が値の上に積まれ、口が開いたまま並びが閉じたので、\`_\` になりました。並びの中では消えます（§4 R48・R52）。逆適用は廃止なので（R47）、値の後ろの関数は前の値を取らず、並びが閉じた後に実引数を受けることもありません。当てるつもりなら、実引数を関数の後ろに書きます。`
      : `未評価のラムダ \`${name}\` が評価する所の終わりに余ったので、\`_\` になりました。並びの中では消えます（§4 R42・R48）。当てるつもりなら、実引数を関数の後ろに書きます（逆適用は廃止、R47）。`
  );
}

// 種類が恒等射（`!_`・`i : !_` の i・恒等射だけの合成）か。
function isIdentityKind(kind) {
  const fn = kind && kind.k === "L" ? kind.fn : null;
  if (!fn) return false;
  if (fn.type === "id") return true;
  return fn.type === "compose" && fn.fns.length > 0 && fn.fns.every((f) => !!f && f.type === "id");
}

// 1項の並びは、その項そのもの。前置 `@`・前置 `~` が1つだけの根は、種類を決めない。書いた `_` 1つは印で値（A。`x : _`、R15）。
// `!_` 1つ（`x : !_`・本体が `!_`・2行以上の括りの中の行）は、頭の無い穴で恒等射（L、並び全体を受ける。R29）。
// 1行の括り `[!_]` は否定の点なしで、ここに来ない（pointfreeOf）。段1〜9 の中置の被演算子になった `!_` 1つは、ここでは恒等射の
// まま返し、`,` の被演算子なら積の単位として消え（R45、resolveProduct）、段4〜8 の被演算子なら中置の側（refuseOperandHole）が G7 で断る。
function single(item) {
  if (item.cat === "input" || item.cat === "ptilde") return { ...item, kind: U() };
  if (item.cat === "unit") return { ...item, desc: A(), kind: A() };
  if (item.cat === "hole") {
    const d = { k: "L", fn: { type: "id" } };
    return { ...item, desc: d, kind: d };
  }
  return item;
}

// 書いた `_`（印）の葉か・穴 `!_` の葉か。既定値のある口に書いた `_`（R39）は印ではなく、既定値という値の葉（cat "default"、A）。
const isMark = (x) => !!x && x.t === "leaf" && x.cat === "unit";
const isHoleItem = (x) => !!x && x.t === "leaf" && x.cat === "hole";
// 穴の並びで、値の項として数える葉（撒く項でない A。既定値という値の葉も含む）。
const isValueItem = (x) => !!x && (x.cat === "plain" || x.cat === "default") && x.desc.k === "A" && !x.desc.spread;
const asValueMark = (x) => ({ ...x, desc: A(), kind: A() });

// ---- 畳み込みの1歩（R40・R47） ----
//
// 積み上げの項は、値（A・未知の木）か、口の開いた関数（t "fn" の項。閉じた所で木にする）。関数の項は、書いた関数を段（stage）に
// 開いて持つ：合成は後ろに段を足すだけで、次の項は「いちばん最初の、まだ閉じていない段」に入る（後から来る物は、最初の関数から
// 順に流れ込む）。段が埋まれば、その結果が次の段の最初の口に入る。合成の名前や括り（`c1 : inc inc`・`[f2 3 f2]`）は、その綴りの
// まま1つの組（group）にし、中の関数を段に開く（木では組の綴りに当てた形で書く）。
// いちばん上が値か空なら、次の項は値でも関数でも積む（R47）。積んだ関数は、その後に来る項を右から受ける（関数は右からだけ受ける）。
// 2026-10-23 までは、値の後ろの関数はその値を逆適用で主語に取っていた（reverseEntry。主語の口が決まらなければ印 pending で G8、
// 主語が撒く項なら G9）。
function foldStep(st, i) {
  let x = st.items[i];
  const stack = st.stack;
  const top = stack[stack.length - 1];
  if (isMark(x)) return markStep(st, i, top);
  if (isHoleItem(x)) x = holeStep(st, i, top);
  if (x.kind.k === "A") {
    if (!top || (top.t !== "fn" && top.kind.k === "A")) return void stack.push(x);
    if (top.t !== "fn") throw unknownNeighbor(top, x);
    // 撒く項は流れの1項で、関数の残りの口の数で受ける（R51）。書き下しか畳み込みで段が閉じ、全部閉じれば値。
    if (isSpreadNode(x) && streamStep(top, x)) {
      if (entryDone(top)) stack[stack.length - 1] = renderEntry(top);
      return;
    }
    feed(top, x);
    if (entryDone(top)) stack[stack.length - 1] = renderEntry(top);
    return;
  }
  // x は関数（L）。いちばん上が空か値なら積む（R47）。種類の未知な値の後ろなら、その値が関数かもしれず、x を合成するか積むかが
  // 決まらない（G2(a)、R40 の読み6）。
  // 関数の項を積んだ所（st.topAt）は、並びの終わりに値の上で口が開いたまま閉じたときの知らせの書いた所（R52、reduceItems の手順7）。
  if (!top) {
    st.topAt = x.term || x;
    return void stack.push(newEntry(x));
  }
  if (top.t !== "fn") {
    if (top.kind.k !== "A") throw unknownNeighbor(top, x);
    st.topAt = x.term || x;
    stack.push(newEntry(x));
    return;
  }
  // 合成：いちばん上の関数の後ろに、x の段を足す。いちばん上の段が、アリティの分からない関数（前置 `@`・`[,]`・既定値のある関数・
  // 撒く項を受けた関数・段18 の点なし）で、もう実引数を受けていれば、その関数が終わったのか（閉じて値になり、x は積まれる）、まだ
  // 受けるのか（x は合成）が決まらないので断る（G2(a)。前は種類の未知な適用の節が隣と結ぶ形として同じ門だった）。
  // 2026-10-23 までは、段18 の点なし（`[' 0]`）が1つ受けて引いた物が値なら通していた（`[' 0] [1 2 3] inc`）：閉じてから逆適用しても、
  // 開いたまま合成しても答えは同じだったから。逆適用の廃止（R47）で、閉じた読みでは inc が値の後ろに積まれて引いた物を取らない
  // （`([' 0] [1 2 3]) inc` は 1 の後ろに inc が余る）ので、開いた読み（`inc ([' 0] [1 2 3])`）と割れる。だから `[,]` と同じく G2(a)。
  const s = curStage(top);
  if (s && stageShape(s).unknown && s.recv.length) throw unknownNeighbor(renderEntry(top), x);
  addGroup(top, x);
  top.log.push({ k: "compose", group: top.groups.length - 1 });
}

// 種類の未知な物（未知の適用・合成の結果）がいちばん上にあるときに、次の項が来た（G2(a)、R40 の読み6）。前の G12(b)（本体の根が
// 値でない関数に実引数が多い・合成の途中の結果が値でないのに余りがある）も、ここに当たる：結果が関数かもしれず、次の項を当てるか
// 積むかが決まらない。
// 頭が裸の関数を返す定義（本体の根が L、G16・R33）なら、言い分でその定義の行を指す。この言い分が出るのは、その定義の行がこの行より
// 後ろにあるときだけ（定義が先なら、行の順に先にその G16 を言う。前の G12(b) の言い分と同じ、確かめ 2026-10-22）。
function unknownNeighbor(top, x) {
  const head = top && top.t === "apply" ? top.head : null;
  const fn = head && head.kind && head.kind.k === "L" ? head.kind.fn : null;
  const bare = fn && fn.type === "plain" && fn.getBodyRoot && fn.getBodyRoot() === "L" ? "頭の本体の根は裸の関数なので、その定義の行は G16 で断ります（§4 R33）。" : "";
  return gate(
    "G2(a)",
    `種類の決まらない \`${show(top)}\` の後ろに \`${show(x)}\` が来ています。結果が値か関数か決まらないので、次の項を当てるか積むかが決まりません（§4 R40、§5 Q8・Q11・Q13）。${bare}`
  );
}

// 括らない `!_`（R44・R46）。穴の規則（R16・R34、tryHole）が読まなかった `!_` は、畳み込みの1歩で、入る所で読む（R43）。
// - 口の外（積み上げが空か、いちばん上が値）：恒等射。`i : !_` の i（R29、fn.type id）と同じ葉にする。`:` はメタなので、並びの頭と値の
//   後ろの `!_ X` と `i X`・`5 !_ X` と `5 i X` は同じ答え（法則11。U [2026-10-22 23:42 ebf18260]「!_ 5 とか !_ , 5 とかも確かめておいた方が
//   良いね。」、U〔答え〕[2026-10-22 23:48 ebf18260]「5 !_ / 5 , !_ も追加で、 全部5になるはず…」）：`!_ 5` は `(apply !_ 5)`、`5 !_` は
//   5 の後ろに恒等射が積まれて余り、根なら `_` で消える（`(construct 5 (unit !_))`、値は 5。R47・R48。2026-10-23 は逆適用の
//   `(apply !_ 5 ·rev)`）、`5 !_ 3` は `5 i 3` と同じ `5 (!_ 3)`、`!_ inc` は合成（根なら `_`）、`!_ 1 2 inc` は `i 1 2 inc` と同じ G18。前（U〔答え〕
//   2026-10-21 23:47）は G7 で断っていた。同じ答えにならない所は名指しで断る側：頭の関数の口を値で埋めた後ろの `!_`（`inc 5 !_` の G13・
//   `pq 1 2 !_` の G5。`inc 5 i`・`pq 1 2 i` は通る、§5 Q40）と、中置の被演算子（`!_ == 1` の G7。`i == 1` は通る、§5 Q15）。
// - 口の中（いちばん上が口の開いた関数、R46）：`!_` はその関数のいちばん最初の閉じていない段の口に入る。穴と読む（その口に置いた λ：
//   `x ? f … x`。λ はその段の適用だけを包む、R16・R34 の穴と同じ）と、恒等射と読む（f の後ろに合成）で同じ関数になる所だけ通す：
//   口の数の決まった段（素の関数・単項の点なし・畳まない2項の点なし・ノルム）に、口が1つだけ残っている所。λ がその段の口を埋め切る
//   ので、η で部分適用そのもの（`inc !_ inc` は `inc inc`、`[+ 1] !_` は `[+ 1]`、`[<<] 1 !_` は `[<<] 1`）。後ろに値が来ても、穴の λ
//   なら値がその穴を埋め（R34 の k > n と同じ）、恒等射なら同じ口に入るので同じ。
//   口が2つ以上残った段（`[<<] !_ 2`・`add !_ _`・`add !_ vs~`）は、後ろの値が穴の後ろの口に入るか（穴）、穴の口に入るか（恒等射）で
//   割れ、可変長の口（`[+] !_ 5`・`[+ 1,] !_`・`i !_`）・口の数の分からない関数（`gz !_ 3`）は λ の閉じ方で割れるので、G7 のまま。
//   値の後ろに積まれた関数の口も同じに見る（`5 f2 !_` は f2 の口が2つ残るので G7。2026-10-23 は主語の口が決まらない逆適用の口で
//   G7）。括りの関数の口は G5（穴は素の関数だけ、§3.5）：`io1 !_ 5`・`5 io1 !_`・`io1 inc !_`・`inc io1 5 !_`
//   （`!_` の入る段が括りの関数）。`!_` のすぐ前に括りの関数があっても、`!_` が入るのが前の段なら、その段で見る（`inc io1 !_` は inc の
//   口で、R46 で通る。`(inc io1) !_` と同じ）。
//   R46 で通した恒等射の後ろに値が2つ以上入る形（恒等射が並びを受ける、R29）と、恒等射が受けた後に合成された関数へ流れる形は、
//   並びの終わりで閉じる所（identityGate）が単位律と比べて見る。
function holeStep(st, i, top) {
  const x = st.items[i];
  const id = { k: "L", fn: { type: "id" } };
  const out = { ...x, desc: id, kind: id };
  if (!top || top.t !== "fn") return out;
  const s = curStage(top);
  const item = top.groups[s.group].item;
  if (s.fn && s.fn.type === "pattern") {
    throw gate("G5", `括りの関数 \`${show(item)}\` の実引数に穴 \`!_\` があります。穴は素の関数の実引数にだけ書けます（§3.5、U〔答え〕10-14 22:23）。`);
  }
  const sh = stageShape(s);
  const left = sh.fixed - s.recv.length;
  const why = sh.unknown
    ? "口の数の分からない関数の口です"
    : sh.varying
      ? "並びの終わりまで受ける可変長の口です"
      : left >= 2
        ? `口が ${left} つ残っていて、後ろの値が穴の後ろの口に入るか（穴の読み）、穴の口に入るか（恒等射の読み）が割れます`
        : null;
  if (why) {
    throw gate(
      "G7",
      `括らない \`!_\` が、関数 \`${show(item)}\` の口に入る位置にあります。穴と読む（その口に置いた λ）と恒等射と読む（後ろに合成）で同じ関数になるのは、口の数の決まった関数に口が1つだけ残っている所だけで、ここは${why}（§4 R46、§5 Q15）。`
    );
  }
  return out;
}

// 書いた `_`（R43）。いちばん上が値か空なら、並びの単位として消える（R15：0 ⊕ A ≅ A を両側に。畳み込みは単位から始まるので、
// 頭の `_` も消える。`_ inc 5` は `(apply inc 5)`、U〔答え〕10-21 03:19 の表）。いちばん上が関数なら、その口の印として、口を
// 埋める所の規則で読む：既定値のある口なら既定値（R39）、括りの関数なら消える（R15）、畳む2項の点なしなら被演算子の印（R31）、
// 並びの最後なら「ここで終わる」（R28）、ほかは G5。
function markStep(st, i, top) {
  const x = st.items[i];
  if (!top || top.t !== "fn") {
    if (!st.mark) st.mark = x;
    return;
  }
  const s = curStage(top);
  const fn = s.fn;
  const last = i === st.items.length - 1;
  // 2026-10-23 までは、主語の口が決まらない逆適用（§5 Q5）の後の `_` をここで先に見ていた（`5 f2 _` は R28 の終わりで A、ほかは G8）。
  // 逆適用の廃止（R47）で、値の後ろの関数は積まれて口が全部開いているので、`_` はほかの関数の口と同じ規則で読む（`5 f2 _` は
  // `5 (f2 _)`、`5 gd _ 3` は `5 (gd _ 3)` の G15）。
  if (fn && fn.type === "other" && fn.defaults) {
    feed(top, defaultUnit(top, s, x), false);
    return;
  }
  if (fn && fn.type === "plain" && fn.rest) {
    throw gate(
      "G5",
      `穴の口の足りない並びから作った関数 \`${show(s.headTree || renderEntry(top))}\`（書いていない後ろの口を最後の括りの仮引数で受ける、§4 R34）の実引数に、書いた \`_\` があります。括りが受ける並びの中の消える印（U〔答え〕10-14 22:23）か、最後の括りに入る値（終わりの \`_\`、R28）かで読みが割れます（§3.5、§5 Q7）。`
    );
  }
  if (fn && fn.type === "pattern") {
    // `_` を消して詰めるのは、残りの仮引数が全部括りのときだけ（U〔答え〕10-14 22:23 は「参照を取る関数」の話）。裸の仮引数が
    // 残っていれば、詰めると `_` の後ろの実引数が裸の口へずれる（`mx : a [b] ? a` の `mx _ 3` で 3 が a に入る）。既定値の無い
    // 関数の `_` はカリー化（U 10-21 03:14）とも読めるので、どちらとも決めずに断る（§3.5、§5 Q7）。
    const base = fn.base || fn;
    const used = (fn.bound ? fn.bound.length : 0) + s.recv.length;
    if (base.bareAt.slice(used).some(Boolean)) {
      throw gate(
        "G5",
        `裸の仮引数を持つ括りの関数 \`${show(renderEntry(top))}\` の実引数に、書いた \`_\` があります。\`_\` を消して詰める（U〔答え〕10-14 22:23、参照を取る関数）か、裸の口のカリー化（U 10-21 03:14）かで読みが割れます（§3.5、§5 Q7）。`
      );
    }
    // 値の並びの終わりの `_`（並びの最後か、次が関数）で、それまでの実引数がアリティに足りない（か撒く項で数えられない）：「終わり」
    // （R28）と消える印が割れる（`io1 _`・`pb 1 _ inc`）。
    const next = st.items[i + 1];
    const runEnd = !next || (!isMark(next) && next.kind.k === "L");
    const spread = s.recv.some(isSpreadNode);
    if (runEnd && (spread || s.recv.length < fn.n)) {
      throw gate(
        "G5",
        `括りの関数 \`${show(renderEntry(top))}\` の実引数の終わりに書いた \`_\` があり、\`_\` を除いた実引数${spread ? "が撒く項で数えられません" : `（${s.recv.length}）がアリティ（${fn.n}）に足りません`}。最後の \`_\` を「終わり」（足りなければ印、R28・U〔答え〕10-14 03:14）と読むか、括りが受ける並びの中の印として消す（U〔答え〕10-14 22:23）と読むかで種類が割れます（§3.5、§5 Q7）。`
      );
    }
    return; // 消える（R15）
  }
  if (fn && fn.type === "pfFold") {
    feed(top, asValueMark(x), false); // 中置の被演算子と同じ印（R31）。末尾でも終わりにしない
    return;
  }
  if (last) {
    // 「ここで終わる」（R28）。頭が合成なら、終わりを当てるかは決めていない（§5 Q18 の残り）。合成を名前や括りで包んだ物（`q : inc add 5`
    // の q・`(inc add 5)`）も、前の関数が閉じて段が1つに見えても合成の頭として数える（印 composed、entryFn）：`:` はメタで、名前は式を
    // 指す（U〔答え〕10-22 22:14）ので、`q _` は `inc add 5 _` と同じ G5。前は名前と括りだけが R28 で A に通っていた（確かめで見つかった、
    // 2026-10-23）。
    if (top.stages.length > 1 || (fn && fn.composed)) {
      throw gate(
        "G5",
        `合成 \`${show(renderEntry(top))}\` の実引数の最後に、終わりの \`_\` があります。合成の頭に「ここで終わる」（R28）を当てるかは決まっていません（§4 R28、§5 Q18）。`
      );
    }
    const n = endArity(fn);
    if (n !== null && !s.recv.some(isSpreadNode)) {
      top.endMark = asValueMark(x);
      const kind = s.recv.length < n ? A() : closeKind(s);
      s.done = true;
      s.result = kind;
      top.groups[s.group].result = kind;
      return void (st.stack[st.stack.length - 1] = renderEntry(top));
    }
  }
  throw gate(
    "G5",
    `書いた \`_\` の読みが決まらない位置にあります（\`${show(renderEntry(top))}\` の実引数）。読みが決まるのは、値の隣（並びの単位として消える）・素の関数の穴（\`f _ 3\`・\`f3 _ 2\`）・並びの最後の「終わり」（\`add 3 _\`）・括りの関数の実引数・既定値のある口（R39）・中置の被演算子・畳む2項の点なしの実引数（\`[+] 1 _\`、R31）です（§3.5、§5 Q7・Q18）。`
  );
}

// R39：既定値のある関数の段 s に書いた `_` x。前から数えた位置（s がもう受けた数）が既定値のある口（fn.defaultAt）なら、既定値という
// 値の葉（cat "default"、A）。既定値の無い口・仮引数の外・位置が数えられない形（撒く項か値でない項を受けた後・n が数えられない）は
// G15。合成の段でも同じ（合成は左から実行する、R11）。
function defaultUnit(e, s, x) {
  const fn = s.fn;
  const at = fn.defaultAt;
  const i = s.recv.length;
  const slot = (t) => !!t.kind && t.kind.k === "A" && !isSpreadNode(t);
  if (at && i < at.length && s.recv.every(slot) && at[i]) return { ...x, cat: "default", desc: A(), kind: A() };
  const what = e.stages.length > 1 ? "の段" : "";
  const why = !at
    ? "仮引数の数が数えられないので、どの口に当たるかが決まりません"
    : !s.recv.every(slot)
      ? "前に撒く項か値でない項があるので、どの口に当たるかが数えられません"
      : i >= at.length
        ? `前から ${i + 1} 番目で、仮引数（${at.length}）の外に当たります`
        : `前から ${i + 1} 番目の口は既定値の無い仮引数です`;
  throw gate(
    "G15",
    `既定値のある関数${what} \`${show(e.groups[s.group].item)}\` の実引数に書いた \`_\` が、既定値のある口に当たりません（${why}）。既定値の無い口に当たる \`_\` の読みは決まっていません（§4 R39、§5 Q8）。`
  );
}

// 「終わり」の `_` を当てられる頭のアリティ（R28）。決まっていなければ null。
function endArity(fn) {
  if (!fn) return null;
  if (fn.type === "plain" || fn.type === "pfBinary") return fn.n;
  if (fn.type === "id" || fn.type === "pfUnary" || fn.type === "pfPick" || fn.type === "norm") return 1;
  return null;
}

// ---- 関数の項・段・組 ----

function newEntry(item) {
  const e = { t: "fn", groups: [], stages: [], log: [], endMark: null };
  addGroup(e, item);
  return e;
}
function addGroup(e, item) {
  const g = e.groups.length;
  const fn = item.kind.fn;
  const fns = fn && fn.type === "compose" ? fn.fns : [fn];
  // 合成の幅の守り（COMPOSE_WIDTH_LIMIT の注の6）。
  if (e.stages.length + fns.length > COMPOSE_WIDTH_LIMIT) throw new ComposeWidthOverflow();
  e.groups.push({ item, args: [], flowIn: false, result: null, first: e.stages.length });
  for (const f of fns) e.stages.push({ fn: f, group: g, recv: [], done: false, result: null, tainted: false });
}
const curStage = (e) => e.stages.find((s) => !s.done) || null;
const entryDone = (e) => e.stages.every((s) => s.done);

// 段の口：fixed は数えられる口の数、varying は最後に可変長の口があるか、unknown はアリティが分からないか（並びの続く間は受け、
// 終わりで閉じる）。撒く項を受けた段（tainted）は、埋まったかが数えられないので unknown にする（R24「撒く項があれば k は数えない」）。
function stageShape(s) {
  if (s.tainted) return { fixed: 0, varying: false, unknown: true };
  return fnShape(s.fn);
}
function fnShape(fn) {
  switch (fn && fn.type) {
    case "plain":
      return fn.rest ? { fixed: fn.restAt || 0, varying: true } : { fixed: fn.n };
    case "pfUnary":
    case "norm":
      return { fixed: 1 };
    case "pfBinary":
      return { fixed: fn.n };
    case "pattern":
      return fn.lastBracket ? { fixed: fn.n - 1, varying: true } : { fixed: fn.n };
    case "pfGreedyUnary":
    case "pfFold":
    case "id":
      return { fixed: 0, varying: true };
    default:
      // 前置 `@`・`[,]`・既定値のある関数・アリティの分からない関数と、段18 の点なし（`[' 0]`、R26。1つ受けて閉じれば引いた物、
      // 2つ以上なら未知で、口の数を決めるのはここと closeKind の1か所。受けた後に関数が来たら、閉じて値になった後ろに積む読みか、
      // まだ受けていて合成する読みかが決まらない：G2(a)。R41 の読み8・R47）。
      return { fixed: 0, unknown: true };
  }
}

// 実引数を1つ、いちばん最初の閉じていない段に入れる（R40 の適用）。
function feed(e, tree) {
  const s = curStage(e);
  e.log.push({ k: "arg", tree, group: s.group });
  e.groups[s.group].args.push({ tree });
  putArg(e, s, tree);
}
// 恒等射の段は、受けた物ごとに、受けた時の書いた順の位置（log の長さ）を持つ（at）。並びの終わりで閉じるときに、後ろの関数が受けた
// 後に合成されたか（単位律の読みでは、その関数は値の後ろに積まれて受けた物を取らない、R47）を見る（identityGate）。
// 2026-10-23 までは、段18 の点なしが1つ受けた後に合成した関数の後ろから、値がその点なしの口に入る所（印 held）もここで G2(a) に
// していた。R47 で、点なしが受けた後に関数が来た所（foldStep）で G2(a) になったので、印は要らない。
function putArg(e, s, tree) {
  argOperand(s, tree);
  if (s.fn && s.fn.type === "id") (s.at || (s.at = [])).push({ at: e.log.length });
  s.recv.push(tree);
  const sh0 = fnShape(s.fn);
  // 撒く項が数えられる口に入った：その段がいくつの口を埋めたかが数えられない（可変長の口に入った撒く項は、閉じたときに未知）。
  if (isSpreadNode(tree) && !sh0.unknown && s.recv.length <= sh0.fixed) s.tainted = true;
  const sh = stageShape(s);
  if (!sh.varying && !sh.unknown && s.recv.length >= sh.fixed) settle(e, s, doneKind(s));
}

// 段 s が実引数 tree を受ける所の、Reader と札（R60 の細かい所。2026-10-25 の確かめの直し。2026-10-26 の R62 から、番地の点と差は G21、§5 Q66）。
// - 値の演算子の点なし（印 vop：`[+ 1]`・`[1 +]`・`[-_]`・`[!!_]`・`[_!]`・`[+]`・`[==]`・`[<<]`・`[~]`・`[!=]`・`[!==]`・`[* 2,]`・`[-_,]`）が Reader を受けたら、
//   中置で書いた `$x + 1` と同じく G7（区間は位置で被演算子を取る：`[+ 1] x` は `x + 1`、R31・R32）。前は中置の項の所だけで見ていて、
//   `[+ 1] $vs`・`[+] $vs 1` が通った（確かめの指摘）。素の関数の裸の仮引数を受けたら、その札に覚える（valueOperand）。
// - 素の関数の口（印 op）に、ほかの素の関数の裸の仮引数をそのまま渡したら、札から札へ辺を張る（numericParam が辿る）。
function argOperand(s, tree) {
  const fn = s.fn;
  if (!fn) return;
  // 既定値のある関数（とほかの「other」の関数）の答えは未知（doneKind）で、口に渡した番地の算術の点・差の印を持たせられない（2026-10-26 の確かめの直し、
  // hasAddr の注。素の関数の口の readerAtPlain と同じ線、§5 Q66）。
  if (fn.type === "other" && treeHasAddr(tree)) throw refuseAddressDrop("other", readerText(tree));
  // 言い分に点なしの記号は書かない（点なしは実体の鍵に記号を入れないので、分け合った実体の本体から出る言い分が記号で割れる。fnKey の注）。
  // 畳む点なしは、1項だけなら演算を当てない（`[+] 5` は 5、R31 の foldOneKind）ので、ここでは見ず、2項以上で閉じた所で見る（closeKind）。
  if (fn.vop && fn.type !== "pfFold") return void valueOperand(descOfTree(tree), null, () => readerText(tree, false));
  if (fn.type === "plain" && fn.op) {
    const d = descOfTree(tree);
    if (d && d.pv) {
      const to = paramTag(fn.op, fn.idKey, (fn.at || 0) + s.recv.length);
      if (!to.fn) to.fn = fn;
      d.pv.edges.add(to);
    }
  }
}
// Reader の葉の綴り（言い分のため）。写像・畳み込み・流れの中で当てた物は書いた綴りが無い（`·`）ので、形の綴りで言う。quote なら `…` で囲む。
function readerText(tree, quote = true) {
  const t = show(tree);
  if (t !== "·") return quote ? `\`${t}\`` : t;
  return `形 ${descText(descOfTree(tree))} の要素`;
}
// 素の関数の口で見る実引数（readerAtPlain・partialFn の readers）：`$` が作った Reader と、番地の算術で作った点・差を含む物（R62、hasAddr）。
const plainReaderArg = (d) => !!readerOf(d) || hasAddr(d);
// 素の関数 fn（印 op）の口が足りた：前に当てた Reader（部分適用の readers）と、いま当てた trees の Reader の口の札が、本体から値の演算子に届くなら
// G7（paramTag の注。β で `inc $5` は `$5 + 1` と同じ形）。届かない口（`use : f x ? @f x` の f）に渡した Reader は今までどおり通る。
function readerAtPlain(fn, trees) {
  if (!fn || fn.type !== "plain" || !fn.op) return;
  const here = trees.map((t, i) => (plainReaderArg(descOfTree(t)) ? { i: (fn.at || 0) + i, tree: t } : null)).filter(Boolean);
  for (const r of [...(fn.readers || []), ...here]) {
    const label = fn.label || `[${cutShape(writeTree(fn.op))}]`;
    // 番地の算術で作った点・差（R62。器の要素・欄にあっても）は、口が値の演算子に届かなくても断る（2026-10-26 の確かめの直し、hasAddr の注）：素の関数の
    // 答えは本体の根の種類だけなので、本体がその口を返せば（`gi : y ? y`）印が落ちる。値を読む参照は今のまま、届く口だけ断る（§5 Q66 の届かない所）。
    if (treeHasAddr(r.tree)) throw refuseAddressDrop("plain", readerText(r.tree), { label, at: r.i + 1 });
    const tag = paramTag(fn.op, fn.idKey, r.i);
    if (!tag.fn) tag.fn = fn;
    if (!numericParam(tag)) continue;
    const head = `${readerText(r.tree)} を、素の関数 \`${label}\` の前から ${r.i + 1} 番目の口に渡しました。\`${label}\` の本体はその口を（別の素の関数の口を通っても）値の演算子の被演算子に置くので、β で、`;
    // 関数を指す番地は G7（R53 の外）。番地の点と差（値を読む参照・ずらした点・差）は G21：素の関数の本体は裸の仮引数を A として1回だけ解くので、β の形
    // （`$5 + 1` は数と混ぜた G21、`$5 + 0x10` は点）を本体の中で読み分けられず、答えに点・差の印も持たせられない（断る側に倒した、§5 Q66）。
    if (refOf(descOfTree(r.tree))) {
      throw gate("G7", `\`$\` が作った ${head}関数を指す番地を値の演算子に当てる形（\`$inc + 1\` など）と同じです。関数を指す番地を動かす・比べる形は §4 R53 の外なので断ります（§4 R62）。`);
    }
    throw gate(
      "G21",
      `番地 ${head}番地を値の演算子に当てる形（\`$5 + 1\`・\`$5 + 0x10\` など）と同じです。素の関数の本体は裸の仮引数を番地と見ずに1回だけ解くので、番地の点と差の規則（§4 R62）を本体の中で当てられません（中置で書けば R62 で読みます。§5 Q66）。`
    );
  }
}

// 段 s が閉じて、結果 r になった。r が値なら、次の段の最初の口に入る（合成は適用の繰り返し、R11）。値でなければ（未知か、引いた
// 関数）、そこから先は未知で、後ろの括りの関数は未知を受けて実体を作る（R25、§5 Q24・Q27。ほかの関数の本体の根は引かない、Q28）。
function settle(e, s, r) {
  s.done = true;
  s.result = r;
  const idx = e.stages.indexOf(s);
  const next = e.stages[idx + 1];
  if (!next || next.group !== s.group) e.groups[s.group].result = r;
  if (!next) return;
  if (r.k !== "A") {
    for (let j = idx + 1; j < e.stages.length; j++) {
      const t = e.stages[j];
      if (t.fn && t.fn.type === "pattern" && t.fn.n === 1) t.fn.instantiate([U()]);
      t.done = true;
      t.result = U();
      const g = e.groups[t.group];
      if (g.first === j) g.flowIn = true;
      g.result = U();
    }
    return;
  }
  if (next.group !== s.group) e.groups[next.group].flowIn = true;
  putArg(e, next, composeLeaf(r));
}

// 2026-10-23 までは、ここに逆適用（reverseEntry：値の後ろの関数がその値を主語に取る。主語が撒く項なら G9、主語の口が1つに決まらなければ
// 印 pending を付けて後から実引数が来たら G8、pendingGate）があった。逆適用は 2026-10-24 に廃止した（R47。U [2026-10-23 13:12 ebf18260]
// 「…廃止だね。 逆適用は廃止しよう」）。値の後ろの関数は積まれて、後ろの項を右から受ける（foldStep）。

// 並びの終わり（R41）：可変長の口・アリティの分からない関数で、1つ以上受けた段を閉じる。閉じた結果は次の段に入り、次の段も可変長
// なら、それも閉じる。1つも受けていない段は L のまま残る（`(f3 !_ 2)` は L。根なら `_`、R42）。恒等射の段が閉じるときは、R29 の流れと
// 単位律が割れないかを見る（identityGate）。
// 2026-10-23 までは、主語の口が決まらない逆適用の段（pending）を閉じずに残し、口の数の分からない関数なら未知にしていた（`5 gd`）。
// R47 で、値の後ろの関数は何も受けていない（`5 gd` の gd は L のまま、根なら `_`）。
function closeEntry(e) {
  for (;;) {
    const s = curStage(e);
    if (!s) break;
    const sh = stageShape(s);
    if (!(sh.varying || sh.unknown) || s.recv.length <= sh.fixed) break;
    identityGate(e, s);
    if (passStream(e, s)) continue; // 恒等射が受けた撒いた流れは、そのまま次の段へ（R51）
    settle(e, s, closeKind(s));
  }
  // 可変長の口が並びを受けている間に来た関数は、合成の後ろに入っている（L·L、R40。規則の文面の `[+] 1 2 inc 3` は `inc ([+] 1 2 3)`）。
  // ここで閉じた値は、その合成の流れとして後ろの関数に入る：閉じた値が未知でも G2(a)（次の項を当てるか積むかが決まらない、R40 の
  // 読み6）には当たらず、合成の中の未知として節ごと未知（法則1）。後ろの関数が点なしでも通る（`n 1 2 [+ 1]`）。木は入れ子の適用
  // （renderEntry。2026-10-23 までは、後ろの関数が並びから何も受けていなければ逆適用と同じ綴り `·rev` にしていた）。
  return renderEntry(e);
}

// 関数の項の書いた順の形：合成の前に最初の組が受けたか（preG0）、合成の後に受けたか（postG0）、後ろの組が並びから受けたか（laterArgs）。
function logShape(e) {
  let composed = false;
  let preG0 = false;
  let postG0 = false;
  let laterArgs = false;
  for (const ev of e.log) {
    if (ev.k === "compose") composed = true;
    else if (ev.group > 0 && !ev.whole) laterArgs = true; // 合成全体が受けた流れ（R58、closeWhole）は、後ろの組が受けた物に数えない
    else if (composed) postG0 = true;
    else preG0 = true;
  }
  return { preG0, postG0, laterArgs };
}

// 恒等射の段 s が受けた物を持って閉じる所（R29・R41）。恒等射が受けた物を1つの値で後ろの関数へ流す読み（R29、主の Claude の読み）と、
// 単位律（恒等射を消した並びと同じ。`i inc 1 2` は `inc 1 2`、`i 5 inc` は `5 inc`）で答えが割れる所を、G18 で断る（§5 Q13 の恒等射の問い。
// 法則13 が `P i S` と `P S` を比べる）。恒等射が続くなら、その先の最初の恒等射でない段で見る（後ろの恒等射は単位律で消え、流れを
// そのまま通す）。割れるのは：
// - 恒等射が受けた後に合成された関数（`i 5 inc`・`!_ 5 f2`・`i 1 2 inc`・`i 1 [* 2,] 2`・`inc !_ 5 inc`・`!_ 1 2 ||!_||`）。流れの読みでは
//   その関数が恒等射の結果を受けるが、単位律の読みでは、受けた値の後ろにその関数が積まれて、値を取らない（R47。`5 inc` の inc は 5 を
//   取らない）。2026-10-23 までは、単位律の読みの関数は逆適用で値を主語に取ったので、主語の口が1つに決まる関数（`i 5 inc`・
//   `!_ 5 [* 2,]`）と、1つ受けた後の貪欲な単項（`i 1 [* 2,] 2`）は割れずに通していた。主語の口が決まらない関数（`5 !_ f2` の形）は
//   印 idSplit で残して後から実引数が来たら G18、撒く項の主語は G9 の代わりの G18 だった。R47 で、どれも同じ1つの割れになった。
// - 恒等射が2項以上を受け、その前に合成されていた関数が並び全体を受けない（`i inc 1 2`・`i f2 1 2`。単位律では inc が 1 2 を1つずつ
//   受ける）。並び全体を受ける貪欲な単項・ノルム（`i [* 2,] 1 2`・`i ||!_|| 1 2`。利用者の式 `||!_|| = [~x] ? ||x||`（U 10-21 02:54））は
//   通す。
// - 恒等射が1つ受け、その前に合成されていた関数が口の数の分からない関数（`[,]`・段18 の点なし・既定値のある関数。R51（2026-10-24）の
//   前は、撒く項を受けた固定の口の関数も、R24 で数えられなくなるのでここだった。R51 からは、撒いた流れを受けた口が1つか2つの関数は閉じて
//   値を渡すので、上の「受けた後に合成された関数」で見る）で、その後に関数が合成されている（`i [,] 5 inc`）。単位律の読みでは、その関数が受けた後に
//   関数が来て G2(a)（閉じたか、まだ受けるかが決まらない、R40 の読み6）だが、流れの読みでは恒等射が開いている間に合成されて通る。
//   ここは 2026-10-24 に足した（逆適用の廃止の確かめで、HEAD でも同じ割れが通っていたのが見つかった。断る側）。
// ほか（受けた物が無い・後ろに関数が無い・受ける前に合成された関数が流れでも単位律でも同じ物を受ける）は通す（`5 !_ inc` は恒等射が
// 何も受けず、`5 inc` と同じく inc が積まれて余る）。`||!_||` の中の恒等射は見ない（isNormIdentity）。
function identityGate(e, s) {
  if (!s.fn || s.fn.type !== "id" || !s.recv.length || !s.at || isNormIdentity(e, s)) return;
  const first = s.at[0].at;
  const k = s.recv.length;
  const item0 = s.recv[0];
  const name = (t) => show(e.groups[t.group].item);
  const idx = e.stages.indexOf(s);
  let prev = null; // 直前の、恒等射でない段（流れでも単位律でも、受けた1つで閉じた段）
  for (let j = idx + 1; j < e.stages.length; j++) {
    const t = e.stages[j];
    if (t.fn && t.fn.type === "id") continue;
    const boundary = !prev || t.group !== prev.group;
    const c = t.group === s.group ? -1 : composeAt(e, t.group);
    if (boundary && c >= first) {
      throw gate(
        "G18",
        `恒等射が \`${show(item0)}\`${k > 1 ? ` ほか（${k} 項）` : ""}を受けた後に、関数 \`${name(t)}\` が合成されています。恒等射の結果を流れとして渡す読み（R29）では \`${name(t)}\` がそれを受けますが、恒等射を消した並び（単位律）では \`${name(t)}\` は値の後ろに積まれて、前の値を取りません（R47）。読みが割れます（§4 R29、§5 Q13）。`
      );
    }
    const type = t.fn && t.fn.type;
    if (!prev && k >= 2) {
      if (type === "pfGreedyUnary" || type === "norm") return;
      throw gate(
        "G18",
        `恒等射が並び（${k} 項）を受けて、後ろに関数 \`${name(t)}\` が続きます。恒等射が並び全体を受けて1つの値で渡す読み（R29）と、単位律で恒等射の無い並びと同じに見る読み（\`${name(t)}\` が項を1つずつ受ける）で割れます（§4 R29、§5 Q13）。`
      );
    }
    // 単位律の読みでは、t は受けた1つ（!prev なら恒等射が受けた物、ほかは前の段の結果）をその場で受ける。
    // R51（2026-10-24）：受けた1つが撒いた流れなら、t は流れの1項として受ける（どちらの読みでも、passStream と streamInto が同じ段で
    // 受ける）。口が1つか2つなら書き下し（2026-10-25 から。試しの版は写像）か畳み込みで閉じて値を次へ渡すので、固定の口1つの段と同じく次の段で
    // 見る（`i inc vs~ double`・`i f2 vs~ inc` は、単位律では書き下し・畳み込みの値の後ろに関数が積まれて値を取らず、流れでは受けるので、上の
    // 「受けた後に合成された関数」の G18）。最後の口が可変長なら丸ごと受けて開いたままで、後ろの関数はどちらの読みでも合成。ほか（口が3つ以上・分からない・固定の口の後ろに
    // 可変長の口）は、どちらの読みでも G19 なので、ここでは断らない（passStream が G19）。前（R51 の前）は、撒く項を固定の口に受ければ埋まった
    // かが数えられない（R24、putArg の tainted）ので、口の数の分からない関数と同じに見て、後ろに関数があれば G18 にしていた。
    const sh0 = stageShape(t);
    if (!prev && isSpreadNode(item0)) {
      const m = streamMouths(t);
      if (m !== 1 && m !== 2) return;
      prev = t;
      continue;
    }
    if (sh0.unknown) {
      const later = e.stages.slice(j + 1).some((u) => !(u.fn && u.fn.type === "id") && u.group !== t.group && composeAt(e, u.group) >= first);
      if (later) {
        throw gate(
          "G18",
          `恒等射が受けた物を、口の数の分からない関数 \`${name(t)}\` が受け、その後に関数が合成されています。恒等射を消した並び（単位律）では、\`${name(t)}\` が受けた後に関数が来るので、閉じたか、まだ受けるかが決まらず G2(a) ですが（R40 の読み6・R47）、流れとして渡す読み（R29）では通ります。読みが割れます（§4 R29、§5 Q13）。`
        );
      }
      return;
    }
    // 単位律の読みで、この段が受けた1つで閉じて値を次へ渡すのは、固定の口1つの段だけ。可変長・口が2つ以上の段は開いたままで、
    // 後ろの関数はどちらの読みでも合成になる。
    if (sh0.varying || sh0.fixed !== 1) return;
    prev = t;
  }
}

// `||!_||` の中の恒等射（同じ組で、すぐ後ろがノルムの段。enclosureInfo）。`||!_||` は1つの関数で、並び全体を受けて数える（利用者の式
// `||!_|| = [~x] ? ||x||`、U 10-21 02:54）ので、中の恒等射は単位律で消す物ではない（`5 ||!_|| 6` は `n : [~x] ? x` の `5 n 6` と同じく
// 並び全体を受ける）。
function isNormIdentity(e, s) {
  const nx = e.stages[e.stages.indexOf(s) + 1];
  return !!nx && nx.group === s.group && nx.fn === NORM_FN;
}

// 合成で足した組 g の、書いた順の位置（log の compose の位置）。関数の項を作った時からある組（組 0）は -1。
function composeAt(e, g) {
  return e.log.findIndex((ev) => ev.k === "compose" && ev.group === g);
}

// 固定の口が全部埋まった段の種類（§3.4、R9）。
function doneKind(s) {
  const fn = s.fn;
  switch (fn.type) {
    case "plain": {
      const root = fn.getBodyRoot();
      readerAtPlain(fn, s.recv); // Reader・番地を口に渡した呼び出し（R60 の細かい所・R62）
      return root === "A" ? A() : U();
    }
    case "pfUnary":
    case "norm":
      return A();
    case "pfBinary":
      return fn.root === "A" ? A() : U();
    case "pattern":
      return fn.instantiate(s.recv.map(descOfTree)).kind;
    default:
      return U();
  }
}

// 並びの終わりで閉じた段の種類（R41）。撒く項を受けていれば、k を数えないので未知（R24。括りの関数は実体を作らない、§5 Q29）。
function closeKind(s) {
  const fn = s.fn;
  const args = s.recv;
  const k = args.length;
  // 貪欲な単項（`[* 2,]`・`[F,]`）は、撒いた流れを丸ごと受けても結果は List（R51。撒いた並びは流れの1項で、流れは
  // いくつでも1項。空の流れの写像は空の List。`[inc,] [1 2 3]~` は `[2 3 4]`、U [2026-10-25 07:37 2772473e]「[ink,] [1 2 3]~ が [2 3 4] になるのも
  // 大事だと思う。」）。前（2026-10-24 の R51 の前）は撒く項があれば k を数えないので未知だった（R24）。写す関数があれば、要素ごとに当てた
  // 種類が全部 A のときだけ A（mapOver）。
  // 写す関数の無い貪欲な単項も、写す器の中身に関数か未知が見えれば G7（`[[* 2],] fs` と揃える。mapOver の注）。
  if (fn && fn.type === "pfGreedyUnary" && !s.tainted) return mapOver(fn.map || null, args);
  if (s.tainted || args.some(isSpreadNode)) return U();
  switch (fn && fn.type) {
    case "pfGreedyUnary":
      return A();
    case "pfFold":
      // 畳む2項の点なし（R31）：k ≥ 2 は中置の値の演算子と同じく A。k = 1 は foldOneKind。
      // k ≥ 2 の値の記号の畳み込みは、実引数の関数を指す番地を G7、番地の点・差を G21 で断る（R60 の細かい所・R62、§5 Q66。argOperand の注）。
      if (k >= 2 && fn.vop) for (const t of args) valueOperand(descOfTree(t), null, () => readerText(t, false));
      // 2026-10-26 の確かめの直し（hasAddr の注）：1項の器を畳む形（`[+] [($x + 0x10) ($x + 0x10)]`）は、器の中の点・差に値の記号を当てるので、k ≥ 2 と同じく
      // G21。論理の記号の畳み込み（`[|]`・`[&]`・`[;]`）は、中置の論理と同じく、答えが通った側の値で点・差の印が落ちるので G21（§5 Q66）。
      // 1項の点・差そのもの（`[+] ($x + 0x10)`）は演算を当てない（R31 の foldOneKind）ので、今のまま未知。
      if (fn.vop && k === 1 && hasAddr(descOfTree(args[0])) && !addrOf(descOfTree(args[0]))) throw refuseAddressSpelling(null, readerText(args[0], false));
      if (!fn.vop) for (const t of args) if (treeHasAddr(t)) throw refuseAddressDrop("logic", readerText(t, false), { sym: `[${fn.sym}]`, operand: readerText(t, false) });
      return k === 1 ? foldOneKind(args[0]) : A();
    case "pfPick":
      // `[' k] x` は `x ' k` と同じ desc（R26）。2つ以上を受けた形は、何を引くかが決まらないので未知。
      return k === 1 && fn.key ? pickDesc(descOfTree(args[0]), fn.key) : U();
    case "id":
      // 恒等射（R29）：1項なら受けた物そのもの（desc ごと）、2項以上なら並び（中身の見えない A）。
      return k === 1 ? descOfTree(args[0]) : A();
    case "pattern": {
      // 最後の仮引数が括りの関数（R24）：前の仮引数に1つずつ当て、残りの並び全体を最後の括りが1つの List として受ける。
      if (k === fn.n) return fn.instantiate(args.map(descOfTree)).kind;
      const front = args.slice(0, fn.n - 1).map(descOfTree);
      const rest = descOfTree({ t: "construct", items: args.slice(fn.n - 1), kind: A() });
      return fn.instantiate([...front, rest]).kind;
    }
    case "plain":
      return restCloseKind(fn, args);
    default:
      return U(); // 前置 `@`・`[,]`・既定値のある関数（§5 Q8）・アリティの分からない関数
  }
}

// R34 の k < n で作った関数（`a [~c] ? f3 a 2 c~`）の最後の括り `[~c]` が閉じた。c に入った物の数だけ、元の関数の書いていない口を
// 埋める。1つだけ入った物は、[x] ≅ x でその中身の並び（R24。`(f3 !_) 1 [1 2]` は `f3 1 1 2`）。数が数えられなければ未知。足りなければ
// 元の関数の部分適用（L）、ちょうどなら本体の根、多ければ元の関数の余り（後ろに積む、R35）。元の関数の本体の根が値でないのに
// 余りがあれば G2(a)（結果に当てるか積むかが決まらない）。
function restCloseKind(fn, args) {
  const len = cLength(args.slice(fn.restAt || 0));
  if (len === null) return U();
  const m = fn.n - (fn.restAt || 0);
  if (len < m) return { k: "L", fn: { type: "plain", origin: "partial", n: m - len, getBodyRoot: fn.getBodyRoot, idKey: fn.idKey, envDepth: fn.envDepth } };
  const root = fn.getBodyRoot();
  if (len === m) return root === "A" ? A() : U();
  if (root !== "A") {
    throw gate("G2(a)", `穴の口の足りない並びから作った関数の最後の括りが、元の関数のアリティより多くを受けました。元の関数の本体の根が値でないので、余りを当てるか積むかが決まりません（§4 R34・R40、§5 Q11）。`);
  }
  return A();
}
// 最後の括りに入った物の、撒いたときの数。数えられなければ null。
function cLength(C) {
  if (!C.length || C.some(isSpreadNode)) return null;
  if (C.length >= 2) return C.length;
  return writtenLength(C[0]);
}
// 書いた器の中身の数（[x] ≅ x）。数は 1。中身が見えて、要素が全部値のときだけ数える。
function writtenLength(t) {
  const d = descOfTree(t);
  if (isScalar(d)) return 1;
  const allA = (xs) => xs.every((x) => !!x && !isSpreadNode(x) && elementKind(x) === "A");
  const one = vanishedOne(t); // 余ったラムダは消える（vanishedOne の注）
  if (one) return writtenLength(one);
  if (t.t === "construct") {
    const live = liveItems(t.items);
    return allA(live) ? live.length : null;
  }
  if (t.t === "op" && t.sym === ",") {
    const xs = commaItems(t);
    return allA(xs) ? xs.length : null;
  }
  if (t.t === "leaf" && t.cat === "plain" && !t.desc.spread && t.term && t.term.type === "atom" && !t.term.pre.length && !t.term.post.length) {
    const c = t.term.core.c;
    // 名前は、ファイルの値の定義を直に指すときだけ、右辺の器の数（nameKindOf・valueCountOf）。仮引数は数えない。
    if (c === "name") return t.count !== null && t.count !== undefined && deepKind(t.desc) === "A" ? t.count : null;
    if (c === "bracket" || c === "indent") {
      const rows = c === "bracket" ? t.view.inner : t.view.rows;
      if (!rows) return null;
      if (!rows.length) return t.desc.k === "A" ? 0 : null;
      if (rows.length >= 2) return rows.every((r) => !!r && !(r.t === "op" && r.sym === ":")) && allA(rows) ? rows.length : null;
      return writtenLength(rows[0]);
    }
  }
  return null;
}

// ---- 撒いた並びは流れの1項（R51）と `[F,]` の写像（R50） ----
//
// 根拠：U [2026-10-24 04:27 ebf18260]「2引数の関数に対して、list~ を渡したら畳み込みってのは？」。主の Claude の問い「撒いた並びは流れの1項で、
// 関数は残りの口が1つなら写像、2つなら畳み込み、で読んでいい？」に U〔答え〕[2026-10-24 04:30 ebf18260]「試しにやってみよう！…悪ければ
// ロールバックしよう。」（試し）。2026-10-25 に、口が1つの所を書き下しに直して決定にした：U [2026-10-25 07:24 2772473e]「…渡されたリストに後置~が
// 指定される場合、 アリティ2の関数は畳み込み演算と見做せる アリティ1の関数の後ろに , 演算子を置いた関数は、写像と見做せる。…」、
// U [2026-10-25 07:27 2772473e]「飽くまで、[+ 1,] [1 2 3]~ が [2 3 4] であるべきで、 [+ 1] [1 2 3]~ は [2 2 3] になるはずだと答えたつもりだった。…」。
// 主の Claude の問い「撒いた流れは、口2つなら畳み込み、口1つなら書き下し（写像は `[f,]` だけ）。R51 をこう直して試しの印を外し、Q56 は `$!_` が
// `[x ? x]` を指す、でいい？」（07:29 UTC）に U〔答え〕[2026-10-25 07:34 2772473e]「そうか分かった！ map : f [~l] ? [@f,] l~ に対して、 map $!_ .. と
// map $[!_] .. で分かれる。 安心した。」。試し（2026-10-24）の「口が1つなら写像」は主の Claude が足した物で、U〔答え〕[2026-09-28 00:58 023dec41]
// 「どちらも [2 2 3] じゃない？」（`,` の無い `[+ 1] [1 2 3]~` の答え）とぶつかっていた。
// 種類は、要素の desc で関数を当てた種類で決める（写像は要素ごとに1つ、畳み込みは2つ、書き下しは流れの頭に1つ）。結果は中身の見えない A（R24 の
// 適用の結果）。

// 器の要素の desc の代表（形は長さに依らないので、List は要素の desc 1つ）。空の器は []。中身に関数か未知が見える器は null。
// 中身の見えない器（裸の仮引数・適用の結果・`$` の番地）の要素は、中身の見えない A（裸の仮引数と同じ扱い）。
function elemsOfContainer(d) {
  if (!d) return [A()];
  if (d.k !== "A") return null;
  // `$` が作った Reader は、[x] ≅ x でそれ1つを要素にする（`[inc,] $5` は `inc $5` と同じく、写した関数が Reader を受ける）。Reader に関数を写す
  // 読み（fmap、読んでから当てる）は §5 Q59 の割れる読みの1つで、2026-10-26 の答え（R62）でも採らなかったので、Reader を受けた関数の所で断る側に揃える（R60 の細かい所。
  // 前は中身の見えない器と同じ A の要素で、写した関数が Reader を見ずに通った）。
  if (readerOf(d)) return [d];
  if (d.elements && d.elements.some((k) => k !== "A")) return null;
  if (isEmptyBracket(d)) return []; // 書いた空の括り `[]`（bracketInfo の desc は形が無く、要素が空）
  if (d.shape) {
    if (d.shape.s === "list") {
      if (!d.shape.elem) return [];
      return deepKind(d.shape.elem) === "A" ? [d.shape.elem] : null;
    }
    if (d.shape.s === "scalar") return [scalarDesc()]; // 数は長さ1の List（[x] ≅ x）
    if (d.shape.s === "struct") return d.shape.fields.every((f) => deepKind(f.desc) === "A") ? [A()] : null;
  }
  return [A()];
}
// 貪欲な単項が受けた物の要素の desc。1つだけ受けた器は、その要素（`[* 2,] \`ab\`` は文字ごと）。撒く項は、撒いた器の要素。ほかは受けた物
// そのもの。数えられなければ null。
function elemsOfItems(args) {
  if (args.length === 1 && !isSpreadNode(args[0])) return elemsOfContainer(descOfTree(args[0]));
  const out = [];
  for (const t of args) {
    if (!isSpreadNode(t)) {
      out.push(descOfTree(t));
      continue;
    }
    const es = elemsOfContainer(t.desc.of);
    if (es === null) return null;
    out.push(...es);
  }
  return out;
}
// 畳み込み（R51）の結果を、要素の側の値と言える器か（R31 の foldOneKind が A にする物と同じ線）：数と、中身の見える List で深く見て要素が
// 全部 A の物（空の List・文字列も）。中身の見えない器（裸の仮引数・適用の結果・`$` の番地）は、器なら要素に関数があるかもしれず、要素が
// 1つなら左からの畳み込みは関数を当てずにその要素を返す（foldl1）ので、結果が関数でありうる。構造体は欄を畳む読みがどの言葉にも無い。
// どちらも、畳んだ種類を未知にする（2026-10-24 の試しの反証で見つかった黙った誤答の直し：`first : x y ? x`・`tl : [y ~ys] ? ys`・
// `fs : inc , double , inc` の `first (tl fs)~ 5` を構築の A と読んでいた。`tl fs` は `[double inc]` なので畳んだ値は double（関数）で、5 は
// それに当たる。中身の見えない A の要素を A と読む elemsOfContainer は写像の読みで、写した結果はいつも List なので、写像には効かない）。
function foldableContainer(d) {
  if (!d) return false;
  if (isScalar(d) || isEmptyBracket(d)) return true; // 空の流れは `_`（R51）
  return d.k === "A" && !d.spread && !!d.shape && d.shape.s === "list" && deepKind(d) === "A";
}
const isEmptyBracket = (d) => !!d && d.k === "A" && !d.spread && !d.shape && !d.ref && !d.vref && !!d.elements && d.elements.length === 0;
// 関数 fn に desc の並びを前から当てた種類（足りた所で止める）。足りなければ未知。合成も括りの関数（実体を作る）も、並びに書いて当てたのと
// 同じ仕組み（feed）で解く。close なら、当て終えた所で並びの終わりとして閉じる（可変長の口だけの関数を要素1つに当てる `[F,]` の写像、R50。
// `[hd,] ws` の `hd w` は、行 `hd w` と同じく最後の括りが w 1つを受けて閉じる）。
function applyKind(fn, descs, close = false) {
  const e = newEntry({ t: "leaf", term: null, cat: "plain", desc: { k: "L", fn }, kind: { k: "L", fn }, view: { v: "atom", text: "·" } });
  for (const d of descs) {
    if (entryDone(e)) return U();
    feed(e, composeLeaf(d));
  }
  if (close && !entryDone(e)) closeEntry(e);
  return entryDone(e) ? e.stages[e.stages.length - 1].result : U();
}
// 同じ desc（鍵で見る）を1つにまとめる。
function distinctDescs(ds) {
  const seen = new Map();
  for (const d of ds) seen.set(descKey(d), d);
  return [...seen.values()];
}
function refuseMapped(what) {
  return gate("G7", `${what}の中身に、関数か種類の未知な物が見えます。写すか畳むか書き下すかを、中身の関数をどの段で解くかと一緒に決めていません（§5 Q20、§4 R50・R51）。`);
}
// 写像（R50。`[f,]` が撒いた流れを丸ごと受けた所も、R51）：要素ごとに fn を1つ当てた種類が全部 A なら A（List）、ほかは未知。空の器は A（空の List）。fn が無い（写す関数を持たない
// 貪欲な単項 `[* 2,]`・`[-_,]`）なら、要素を見て A。写す器の中身に関数か未知が見えれば、どちらも G7（`[[* 2],] fs` と `[* 2,] fs` は同じ
// 写像なので、同じ答えにする。2026-10-24 の試しの反証で見つかった綴りの割れの直し。前は `[* 2,] fs` だけ A で、要素の `inc * 2` は G7 の形）。
function mapOver(fn, args) {
  const elems = elemsOfItems(args);
  if (elems === null) throw refuseMapped("写す器");
  if (!fn) return A();
  for (const e of distinctDescs(elems)) if (applyKind(fn, [e], true).k !== "A") return U();
  return A();
}
// 左からの畳み込み（foldl1、R51）：要素の desc で fn を2つ当てた種類。括りの関数は渡した形で答えが変わりうるので、前の結果を左に当て直して
// 形の鍵が落ち着くまで見る（素の関数は1回で落ち着く）。落ち着かなければ未知。空の流れは `_`（単位）で A。撒いた器が、畳んだ結果を要素の側の
// 値と言える器でなければ未知（foldableContainer）。
const FOLD_SETTLE_LIMIT = 8;
function foldOver(fn, args) {
  const elems = elemsOfItems(args);
  if (elems === null) throw refuseMapped("畳む器");
  if (args.some((t) => isSpreadNode(t) && !foldableContainer(t.desc.of))) return U();
  if (!elems.length) return A();
  const reps = distinctDescs(elems);
  for (const e of reps) {
    let acc = applyKind(fn, [e, e]);
    for (let i = 0; ; i++) {
      if (acc.k !== "A") return U();
      const next = applyKind(fn, [acc, e]);
      if (next.k !== "A") return U();
      if (descKey(next) === descKey(acc)) break;
      if (i >= FOLD_SETTLE_LIMIT) return U();
      acc = next;
    }
  }
  return A();
}
// 段 s の、撒いた流れを受ける口（R51）：'whole'（可変長の口で、その前の固定の口が埋まっている＝丸ごと受ける）・残りの固定の口の数・
// null（口の数が分からない・固定の口の後ろに可変長の口がある）。
function streamMouths(s) {
  const sh = stageShape(s);
  if (sh.unknown) return null;
  if (sh.varying) return s.recv.length >= sh.fixed ? "whole" : null;
  return sh.fixed - s.recv.length;
}
// 畳み込みの1歩で、いちばん上の関数 top に撒く項 x が来た（R51）。x は、いちばん最初の閉じていない段から後ろの関数全体（合成ならカリー化された
// 1つの関数、R58）の残りの口の数で受ける：2つなら左からの畳み込みで関数の項は閉じ（`add inc vs~` は g(x, y) = inc (add x y) の畳み込み）、1つなら
// 書き下し（writeOut）。受けたら true。丸ごと受けるなら false（今までどおり、その段の可変長の口に入れる）。ほかは G19。
function streamStep(top, x) {
  const s = curStage(top);
  if (streamMouths(s) === "whole") return false;
  top.log.push({ k: "arg", tree: x, group: s.group });
  top.groups[s.group].args.push({ tree: x });
  streamInto(top, s, x);
  return true;
}
// 段 s に撒いた流れ x を入れる（R51・R58）：丸ごとなら可変長の口に入れ（putArg）、s から後ろの関数全体の口が2つなら、その関数全体の畳み込みで
// 関数の項を閉じ（closeWhole）、口が1つなら書き下す（writeOut）。ほかは G19。書いた実引数の記録（log）は呼ぶ側が付ける（恒等射から流れてきた
// 流れは、書いた実引数ではない）。
function streamInto(e, s, x) {
  const m = streamMouths(s);
  if (m === "whole") return void putArg(e, s, x);
  if (m !== 1 && m !== 2) {
    // 印の無い `@x`（素の関数の仮引数。R49 の印が届かない所）は、口の数が分からない前置 `@` の項のまま（§5 Q45）。言い分でそれを名指しする
    // （2026-10-24 の確かめ。そのときは別名の `cc : add inc` の `fold $cc vs` もここで断っていたが、2026-10-25 の R55 で通る。恒等射の `$!_`・`$i` も
    // 同じ日の Q56 の答えで1引数の恒等射の印を持ち、ここに来ない）。
    const input = !!s.fn && s.fn.type === "input";
    const why =
      m === null
        ? input
          ? "前置 `@` の項が指す名前に、関数を指す番地の印（R49）が届いていないので、口の数が分かりません。印は `$名前`（関数の定義・別名・局所の定義・恒等射）・`$[…]`・`$_`・`$!_` が持ち、括りの関数の実体の裸の仮引数・欄・器の要素に渡れば届きますが、素の関数の仮引数には届きません（§5 Q45）"
          : "口の数が分からないか、固定の口の後ろに可変長の口があります"
        : `口が ${m} つ残っています`;
    // 口が3つ以上・分からない・固定の口の後ろに可変長の口がある関数の読み（前から詰める・3つずつ畳む・断る）は、2026-10-25 の答えに無いので
    // §5 Q46 に残っている（同じ日の確かめの指摘で、言い分に名指しを足した）。
    throw gate(
      "G19",
      `撒いた流れ \`${show(x)}\` を受ける関数 \`${show(e.groups[s.group].item)}\` の、撒いた流れを受ける口の数が決まりません（${why}）。撒いた流れは、残りの口が1つなら書き下し、2つなら左からの畳み込み、最後の口が可変長なら丸ごと受けます。口が3つ以上か分からない関数がどう受けるかは決まっていないので断ります（§4 R51、§5 Q46）。`
    );
  }
  const fn = partialFn(s);
  // 畳まない2項の点なし（R32。`[<<]`・`[>>]`・`[!=]`・範囲・get・set）は口が2つでも畳まない：利用者が畳めないと言った記号を、撒いた流れで
  // 黙って畳まない（U [2026-10-21 08:55 cfb4de1d]「ビットシフトとget set は 畳めないね。」。2026-10-24 の試しの反証で見つかった。前は畳んで A、
  // しかも同じ行に「畳めない」の information が出ていた）。1つ当てた部分適用（`([<<] 1) vs~`）は口が1つの書き下しで、畳まないので通す。§5 Q49。
  if (m === 2 && fn && fn.type === "pfBinary") {
    throw gate(
      "G19",
      `撒いた流れ \`${show(x)}\` を、畳まない2項の点なし \`${show(e.groups[s.group].item)}\` が受けました。口は2つですが、\`[${fn.sym}]\` は畳めない点なし（§4 R32）なので、左からの畳み込み（R51）で読むかは決まっていません（§4 R51、§5 Q49）。`
    );
  }
  // 合成に来た流れ（R58、§5 Q58 の答え）：合成は1つの関数なので、撒いた流れは、流れを受ける段から後ろの合成全体（カリー化された1つの関数）の
  // 残りの口の数で受ける。2つなら合成全体を2引数の関数として左から畳み（`inc add vs~` は g(x, y) = add (inc x) y の畳み込みで値は 8、`add inc vs~` は
  // g(x, y) = inc (add x y) で 8）、1つなら書き下し（`inc double vs~` は `(inc double 1) 2 3`）、3つ以上か分からなければ G19（`inc f3 vs~`、§5 Q46）。
  // 名前や括りで包んだ合成（`g2 : inc add` ⏎ `g2 vs~`）も、組の中の関数を段に開いてあるので同じ答え。書き並べた実引数が合成を流れるのは今のまま
  // （R40・R11。`inc add 1 2 3` は `add (inc 1) 2` の後ろに 3）。
  // 根拠：主の Claude の問い「合成に入った流れは、合成全体を1つの関数として口の数で受ける、でいい？」（2026-10-25 10:06 UTC）に、利用者は主の Claude が
  // 用意したボタン「合成全体で受ける」を選んだ（U〔答え〕[2026-10-25 14:39 533071da]。ボタンの文は主の Claude の物：「合成は1つの関数なので、撒いた流れは
  // 合成全体の口の数で受ける（2つなら畳み込み、1つなら書き下し、3つ以上は G19）。」）。
  // 前（R51 の決定の片の確かめの直し、2026-10-25）は、読みが3つ（(a) 書き並べ・(b) 合成は適用の繰り返し・(c) 合成全体）に割れるので、合成全体の口が
  // 流れを受けた段の口と違えば G19 で断り（§5 Q58）、同じなら最初の段だけを畳むか書き下して結果を次の段へ流していた（`add inc vs~` は `inc (add vs~)` の 7。
  // 木と種類は (c) と同じ）。
  const later = e.stages.slice(e.stages.indexOf(s) + 1);
  const c = later.length ? composedMouths(m, later) : m;
  if (c !== 1 && c !== 2) throw refuseComposedStream(e, s, x, m, c);
  if (c === 1) return void writeOut(e, s, x, flowCount(x));
  // 合成全体の口が2つ：畳むのは口が2つの段の関数なので、その段が畳まない2項の点なし（R32）なら、上の段1つのときと同じく畳まない（§5 Q49）。
  const whole = later.length ? { type: "compose", fns: [fn, ...later.map((t) => t.fn)] } : fn;
  const pair = later.find((t) => mouthsOf(t.fn) === 2);
  if (pair && pair.fn.type === "pfBinary") {
    throw gate(
      "G19",
      `撒いた流れ \`${show(x)}\` を受ける合成の、口が2つの段 \`${show(e.groups[pair.group].item)}\` は畳まない2項の点なし（§4 R32）です。合成全体を2引数の関数として畳むと、その点なしで畳むことになりますが、畳めない記号を撒いた流れで畳むかは決まっていません（§4 R51・R58、§5 Q49）。`
    );
  }
  closeWhole(e, s, x, foldOver(whole, [x]));
}
// 流れを受けた段の口 m と、その後ろの段から、合成全体の口の数（mouthsOf の合成と同じ数え方：後ろの関数は前の結果で口を1つ埋める）。後ろの段に
// 口の数の分からない関数か可変長の口の関数があれば null。
function composedMouths(m, later) {
  let total = m;
  for (const t of later) {
    const k = mouthsOf(partialFn(t));
    if (k === null || k < 1) return null;
    total += k - 1;
  }
  return total;
}
// 合成全体の畳み込み（R58）で、流れを受けた段 s から後ろの段を全部閉じる。種類は合成全体を畳んだ種類 kind で、いちばん後ろの段の結果に置く。
// 間の段は合成全体の中で畳まれていて、段ごとの結果を持たない（未知にしておく。描くのは renderEntry で、根の種類はいちばん後ろの段の結果）。
// 後ろの組は前の組の結果を1つの値として受けたのではない（合成全体が流れを受けた）ので、流れの印（flowIn）は付けない。
// 木（renderEntry）は、流れを合成全体に当てた書いた順の綴りにする（`inc add 5 f2 vs~` は `(apply (compose (apply (compose inc add) 5) f2) vs~)`）：
// 流れを書いた実引数の記録（log）に印 whole を付け、後ろの組が並びから受けた（入れ子の綴りにする）とは数えない（logShape）。
function closeWhole(e, s, x, kind) {
  s.recv.push(x);
  const ev = e.log.findLast((v) => v.k === "arg" && v.tree === x);
  if (ev && e.stages.indexOf(s) < e.stages.length - 1) ev.whole = true;
  const idx = e.stages.indexOf(s);
  for (let j = idx; j < e.stages.length; j++) {
    const t = e.stages[j];
    const last = j === e.stages.length - 1;
    t.done = true;
    t.result = last ? kind : U();
    e.groups[t.group].result = last ? kind : U();
  }
}
// 撒いた流れを受ける合成全体の口が、1つ・2つのどちらでもない（R58。口が3つ以上か、口の数が分からない：§5 Q46）。
function refuseComposedStream(e, s, x, m, c) {
  const whole = e.groups.map((g) => show(g.item)).join(" ");
  return gate(
    "G19",
    `撒いた流れ \`${show(x)}\` が、合成 \`${whole}\` の閉じていない段 \`${show(e.groups[s.group].item)}\`（残りの口 ${m} つ）に入りました。合成は1つの関数なので、流れは合成全体の残りの口の数で受けます（1つなら書き下し、2つなら左からの畳み込み、§4 R58）が、合成全体の口は${c === null ? "数が分からない（口の数の分からない関数か、可変長の口の関数が後ろの段にある）" : ` ${c} つ`}です。口が3つ以上か分からない関数がどう受けるかは決まっていないので断ります（§4 R51・R58、§5 Q46）。`
  );
}
// 撒いた流れの書き下し（R51、2026-10-25 の決定。口が1つの段）：流れの頭を段の口に当て（段は閉じ、結果は次の段の最初の口に入る、settle）、残りは
// 後ろに積む（R47・R35）。書いた `[+ 1] 1 2 3` と同じく、`[+ 1] [1 2 3]~` は `([+ 1] 1) 2 3`（値は `[2 2 3]`、U〔答え〕09-28 00:58）、`inc vs~` は
// `(inc 1) 2 3`、`add 1 vs~` は `(add 1 1) 2 3`。写像は `[f,]` だけ（R50。`[f,] xs~` は可変長の口が丸ごと受けて写す）。
// n は流れの要素の数（flowCount。数えられなければ null）。木は今までどおり、撒く項を実引数に書いた `(apply L xs~)`。
// - 頭の種類は、要素の desc で関数を当てた種類（段の口に入れて閉じる。括りの関数なら要素の desc で実体を作る）。関数の項が閉じたら、余りの要素は
//   値（elemsOfContainer が A と言った物）なので、項は頭の結果と余りを積んだ構築と同じ形（書いた `inc 1 2 3` の `(construct (apply inc 1) 2 3)` と
//   同じく、頭の結果と余りの要素の desc を合わせた List の形 `[A…]`。2026-10-25 の確かめの指摘で直した。前は形の見えない A で、`io1 (inc vs~)` が
//   G7、書いた `io1 (inc 1 2 3)` が A と割れていた）。余りの要素は器の要素の代表（形は長さに依らない）なので、中身の形の混ざった器では、書き並べより
//   見える物が少ない（断る側・未知の側。§5 Q57）。頭の結果の種類が決まらないのに余りがあれば、書いた `uu 1 2 3` と同じ G2(a)。
// - 数えられない流れ（裸の仮引数・括りの仮引数・適用の結果を撒いた物）は、頭があるか（空の流れか）・余りがあるかが決まらないので、段から先を未知に
//   する（根なら通り、後ろに項が来れば G2(a)。試しの写像は数えずに A だった）。ただし頭の要素の desc で段の関数を当てて、括りの関数なら実体を作り
//   本体を読む（R25。2026-10-25 の確かめの指摘で直した。前は当てずに未知で閉じ、`bb : [a] y ? [+ 1] _ _` の `(bb [1]) (tl vs)~` が本体の G5 を
//   読まずに通った）。流れが空でなければ頭は必ず当たり、空なら下の空の流れの G19 の割れなので、どちらでも本体の門は当たってよい。
// - 空の流れ（`inc []~`）は G19：書き下すと何も書いていない `inc`（L のまま）とも、空の流れを単位 `_` と読む（口が2つの畳み込みの空の流れは `_`）
//   とも読め、答えが割れる（§5 Q57）。
// - 合成に入った流れを書き下すのは、合成全体の口が1つのとき（後ろの段が全部口1つ。R58、streamInto）。合成全体を1つの関数として書き下すので、
//   頭は合成全体に当たって後ろの段を閉じながら流れ、余りは関数の項の後ろに積まれる：`inc double vs~` は `(inc double 1) 2 3` で、形は合成で
//   ない書き下しと同じ `[A…]`（頭の結果、つまりいちばん後ろの段の結果と、余りの要素）。前（R51 の決定の片の確かめの直し）は、合成に来た流れの
//   読みが3つに割れて形も割れる（(b) の合成は適用の繰り返しの読みでは形の見えない A）ので、形の見えない A にしていた（§5 Q58 の答えで (c) に
//   決まった）。
function writeOut(e, s, x, n) {
  const elems = elemsOfContainer(x.desc.of);
  if (elems === null) throw refuseMapped("書き下す器");
  if (n === 0 || !elems.length) {
    throw gate(
      "G19",
      `空の流れ \`${show(x)}\` を、口が1つの関数 \`${show(e.groups[s.group].item)}\` が受けました。書き下すと何も当てない関数のまま（L）とも、空の流れを単位 \`_\` と読む（口が2つの畳み込みの空の流れは \`_\`）とも読め、答えが決まっていません（§4 R51、§5 Q57）。`
    );
  }
  if (n === null) {
    applyKind(partialFn(s), [elems[0]]); // 頭に当てて、括りの関数の本体を読む（上の注）。種類は使わない
    s.recv.push(x);
    settle(e, s, U());
    return;
  }
  putArg(e, s, composeLeaf(elems[0]));
  if (n >= 2 && entryDone(e)) {
    // 頭で関数の項が閉じた：余りは後ろに積む。項の種類は、頭の結果と余りを積んだ List の形（上の注）。頭を当てた結果の種類が決まらなければ、書いた
    // `uu 1 2 3` と同じく、余りを当てるか積むかが決まらない（G2(a)、R40 の読み6）。
    const last = e.stages[e.stages.length - 1];
    if (!last.result || last.result.k !== "A") {
      throw gate(
        "G2(a)",
        `撒いた流れ \`${show(x)}\` の頭を当てた \`${show(e.groups[last.group].item)}\` の結果の種類が決まらないので、流れの余り（${n - 1} 項）を当てるか積むかが決まりません（書いた実引数の並びと同じ。§4 R40・R51、§5 Q8・Q11・Q13）。`
      );
    }
    last.result = withShape({ s: "list", elem: mergeElems([last.result, elems[0]]) });
    e.groups[last.group].result = last.result;
    return;
  }
  if (n === 1 || entryDone(e)) return;
  // 上の注のとおり、ここには来ない（後ろの段が口1つでない合成は、streamInto が R58 の合成全体の口で読む）。来たら、口の数の分からない合成と同じ門で断る。
  throw refuseComposedStream(e, s, x, 1, null);
}
// 撒く項 t の流れの要素の数（classifySpread が葉に付けた数）。数えられなければ null。
function flowCount(t) {
  if (!isSpreadNode(t)) return null;
  return t.count === undefined ? null : t.count;
}
// 恒等射の段 s が、撒いた流れ1つだけを受けて閉じる（R51・R29）：恒等射は受けた1項そのものを渡す（R29 の k = 1）ので、流れはそのまま次の段に
// 流れの1項として入る（単位律：`i inc vs~` は `inc vs~`、`i gd vs~` は `gd vs~` と同じ G19。法則13）。次の段が無ければ今までどおり（未知）。
// 渡したら true。
function passStream(e, s) {
  if (!s.fn || s.fn.type !== "id" || s.recv.length !== 1 || !isSpreadNode(s.recv[0])) return false;
  // `||!_||` の中の恒等射は、`||!_||` が1つの関数で並び全体を受けて数える（`[~x] ? ||x||`、R27）ので渡さない（isNormIdentity）。
  if (isNormIdentity(e, s)) return false;
  const idx = e.stages.indexOf(s);
  const next = e.stages[idx + 1];
  if (!next) return false;
  s.done = true;
  s.result = U();
  if (next.group !== s.group) {
    e.groups[s.group].result = U();
    e.groups[next.group].flowIn = true;
  }
  streamInto(e, next, s.recv[0]);
  return true;
}

// 畳む2項の点なし（R31）に実引数が1項のときの種類。1項が数なら、その数そのもの（`[+] 5` は 5）。List 1つなら、要素を並びと
// して畳んだ物（`[+] [1 2 3]` は 6）で、値は一番右か一番左の要素か、要素どうしの演算の結果になる（`[&]` は一番右、`[|]` は一番
// 左、比較は一番右か `_`）。だから要素に関数が混ざれば、畳んだ結果は関数になりうる（`gs : 1 , inc` の `[&] gs` は inc）。
// - A：書いた `_`（印。中置の被演算子と同じ、R15）・数（R24）・中身の見える List で、深く見て要素が全部 A の物（`[1 2 3]`・
//   `vs`・`[' 0]` で引いた List）。
// - 未知：ほかの全部。要素に L か未知が見える器（`gs`・`(inc , 1)`。並びの中では G7）、中身の見えない A（裸の仮引数・適用の
//   結果・`$` の番地。器かもしれず、器なら要素に関数が見えるかもしれない）、構造体（欄を畳む読みは決まっていない）。
//   括り1つの `(y)`・`([< 3,] 1 5 2)` も、中の行の形が見えなければ未知（`[x]≅x` なので `(y)` は y と同じ）。
// 前（2026-10-21 の R31 の最初の版）は1項ならいつも A にしていて、`z : [&] gs` の `z 5` を黙って構築と読んだ（確かめで見つかった
// 黙った誤答。R31 の前の `[&]` はアリティの分からない点なしで、未知か G7 だった）。中置で書いた同じ物（`gs ' 0 & gs ' 1`）・
// 同じ器を撒く形（`gs~`、Q20）・`[' 0] fs` も未知か G7 なので、それと揃える。
// k ≥ 2 は中置と同じく A（`[&] 1 gs` は `1 & gs` と同じで、gs は器の値）。
function foldOneKind(arg) {
  if (isMark(arg)) return A();
  const d = descOfTree(arg);
  if (isScalar(d)) return A();
  if (d.k === "A" && !d.spread && d.shape && d.shape.s === "list" && deepKind(d) === "A") return A();
  return U();
}

// 段の今の関数（受けた実引数の分を当てた部分適用）。口の開いたまま残った関数の項の desc（括りや名前で包んだときの種類）に使う。
function partialFn(s) {
  const fn = s.fn;
  const k = s.recv.length;
  let out = fn;
  if (k && fn) {
    if (fn.type === "plain") {
      const origin = fn.origin === "hole" ? "hole" : "partial";
      out = { type: "plain", origin, n: fn.n - k, getBodyRoot: fn.getBodyRoot, idKey: fn.idKey, envDepth: fn.envDepth };
      if (fn.rest) {
        out.rest = true;
        out.restAt = (fn.restAt || 0) - k;
      }
      // 裸の仮引数の札（paramTag）：部分適用は、元の `?` と、当てた口の数（at）と、Reader を当てた口の位置（readers）を持ち越す。足りた所で
      // まとめて見る（readerAtPlain）。
      if (fn.op) {
        out.op = fn.op;
        out.label = fn.label;
        out.at = (fn.at || 0) + k;
        const rs = s.recv.map((t, i) => (plainReaderArg(descOfTree(t)) ? { i: (fn.at || 0) + i, tree: t } : null)).filter(Boolean);
        out.readers = [...(fn.readers || []), ...rs];
      }
    } else if (fn.type === "pfBinary") out = { ...fn, n: fn.n - k };
    else if (fn.type === "pattern") out = patternPartial(fn, s.recv.map(descOfTree));
    if (fn.composed && !out.composed) out = { ...out, composed: true };
  }
  return out;
}
// 口の開いたまま残った関数の項の fn：いまの段の部分適用と、後ろの段を並べた合成（1つならその関数）。前の段が閉じて、いまの段1つが
// 残った物（`q : inc add 5` の q）は、合成の頭だった印 composed を付ける（並びの最後の `_` を R28 で読まない、markStep。§5 Q18）。
function entryFn(e) {
  const i = e.stages.findIndex((s) => !s.done);
  const fns = [partialFn(e.stages[i]), ...e.stages.slice(i + 1).map((s) => s.fn)];
  if (fns.length > 1) return { type: "compose", fns };
  return i > 0 && !fns[0].composed ? { ...fns[0], composed: true } : fns[0];
}

// ---- 関数の項の木（§1.3） ----
//
// 各関数がどの項を受けたかが木から読めるように書く。意味の変わらない形は前の木の形のまま。
// - 実引数を書いた順に並べ、合成するたびに、それまでを `(apply …)` で閉じて `(compose … f)` にする（前の木と同じ：`f2 1 g 2` は
//   `(apply (compose (apply f2 1) g) 2)`、`[+] inc 5 6` は `(apply (compose [+] inc) (construct 5 6))`）。
// - 後ろの関数が並びの項を受けた（`f2 3 f2 5 6`・`inc [+] 5 6`）か、可変長の口が合成の前と後の両方で受けて、可変長の口に
//   2つ以上入った（`[+] 1 2 inc 3`）か、終わりで閉じた関数の後ろの関数が並びから何も受けていない（`[+] 1 inc 2`・`n 1 2 inc`・
//   `[* 2,] 1 2 3 inc double`・`head inc [5 6 7] double`）なら、合成の綴りでは誰が何を受けたかが隠れるので、入れ子の適用で書く：
//   `(apply f2 (construct (apply f2 (construct 3 5)) 6))`・`(apply inc (apply n (construct 1 2)))`。
// - 2026-10-23 までは、並びの項を全部書いた後に合成した後ろの組が並びから何も受けていない形（`n 1 2 inc`）と、値の後ろの逆適用が続く形
//   （`5 inc inc`）を、逆適用の綴り `(apply inc (apply n (construct 1 2)) ·rev)`・`(apply (compose inc inc) 5 ·rev)` で書いていた
//   （trailingFrom）。逆適用の廃止（R47）で `·rev` の綴りは無くなり、前の形は入れ子の適用で、後の形は `5` の後ろに積んだ `inc inc` になった。
function renderEntry(e) {
  const done = entryDone(e);
  const kind = done ? e.stages[e.stages.length - 1].result : { k: "L", fn: entryFn(e) };
  const tail = e.endMark ? [{ tree: e.endMark }] : [];
  const tuple = (xs) => (xs.length === 1 ? xs[0] : { t: "construct", items: xs, kind: A() });
  const app = (head, args, k) => ({ t: "apply", head, arg: tuple(args.map((a) => a.tree)), kind: k });
  const compose = (head, f) => ({ t: "compose", items: head.t === "compose" ? [...head.items, f] : [head, f], kind: { k: "L" } });
  const g0 = e.groups[0];
  const { preG0, postG0, laterArgs } = logShape(e);
  const sh0 = stageShape(e.stages[0]);
  const lastEv = e.log[e.log.length - 1];
  // 可変長の口が合成の前と後の両方で受けても、可変長の口に入ったのが1つだけなら、固定の口と同じく書いた順の綴りで誰が何を受けたかが
  // 読める（`pair [1] inc 5` は `(apply (compose (apply pair [1]) inc) 5)`、括りを外した素の関数と同じ木。法則4）。
  const spread0 = sh0.unknown || (sh0.varying && e.stages[0].recv.length > sh0.fixed + 1);
  const nested = laterArgs || (spread0 && preG0 && postG0) || (done && lastEv && lastEv.k === "compose" && !tail.length);
  if (!nested) {
    // 書いた順：合成するたびに、それまでを閉じる。
    let T = g0.item;
    let pend = [];
    for (const ev of e.log) {
      if (ev.k === "arg") pend.push(ev);
      else {
        T = compose(pend.length ? app(T, pend, { k: "L" }) : T, e.groups[ev.group].item);
        pend = [];
      }
    }
    const last = [...pend, ...tail];
    if (last.length) return app(T, last, kind);
    return T === g0.item ? T : { ...T, kind };
  }
  // 入れ子の適用：各組が、前の組の結果（流れ）と、自分が並びから受けた物を当てた適用。
  let node = null;
  for (let g = 0; g < e.groups.length; g++) {
    const grp = e.groups[g];
    if (g > 0 && !grp.flowIn && !grp.args.length) {
      node = compose(node, grp.item); // まだ流れの届いていない後ろの関数
      continue;
    }
    const args = [...(grp.flowIn && node ? [{ tree: node }] : []), ...grp.args, ...(g === e.groups.length - 1 ? tail : [])];
    node = args.length ? app(grp.item, args, grp.result || { k: "L" }) : grp.item;
  }
  return { ...node, kind };
}

// 合成の中で、前の関数の結果を次の関数へ渡す1項の実引数。descOfTree がそのまま読む葉にする。
function composeLeaf(desc) {
  return { t: "leaf", term: null, cat: "plain", desc, kind: desc, view: { v: "atom", text: "·" } };
}

// ---- 穴（R16・R34・R38） ----

// 素の関数の頭（R16：名前の定義か `?` の括りで、出どころが素の物。2026-10-23 までは R12 の逆適用の右も）。
function isPlainHead(h) {
  const fn = h && h.kind && h.kind.fn;
  return !!fn && h.cat === "plain" && h.kind.k === "L" && fn.type === "plain" && fn.origin === "plain" && (h.isLambdaName || h.isQBracket);
}

// 穴 `!_` を書ける頭のアリティ（R16・R34）。素の関数の頭は n。既定値のある関数の頭（名前の定義か `?` の括り）は仮引数の数
// （defaultsArity。数えられなければ null）。ほかの頭は null。
function holeHeadArity(h) {
  const fn = h && h.kind && h.kind.fn;
  if (isPlainHead(h)) return fn.n;
  if (fn && h.cat === "plain" && h.kind.k === "L" && fn.type === "other" && fn.defaults && (h.isLambdaName || h.isQBracket)) return fn.n;
  return null;
}

// 穴が tryHole で読めなかった並び（§3.5）を、畳む前に並び全体で見て断る所。穴を書ける頭（素の関数か既定値のある関数）の
// 実引数の並びで、穴でない項が全部書いた `_` でない A で k ≠ n なのに R34（holeMismatch）が読まなかった形は G13：撒く項がある（k が
// 数えられないので、穴に入れる実引数も余りも決まらない。`go !_ vs~`・`f3 !_ vs~`）か、k > n で前から n 個の外に `!_` がある（R34 は
// 残りの実引数を前から穴へ入れるが、入れる物が穴の読みは決まっていない。`inc 5 !_`・`add !_ 1 !_`）。前（Q31 の答えの前）は k ≠ n の
// 全部を G13 で断っていた（U〔答え〕10-15 23:16 は「go !_ xs は go xs と読む」に「そうなるね！」だったが、穴の読みでは go の口を穴が
// 埋めて xs が余る、と割れた）。R34 の k < n で作った関数に後から当てる所の G13（最後の括りに1つで入る数でない値）は、2026-10-23 に
// 無くなった（[x] ≅ x で、入った物の中身の並び。restCloseKind）。
// 既定値の無い素の関数の頭では、最後の項でない書いた `_` も穴と同じに数える（R38。最後の項が `_` の並びは終わり（R28）なので数えない）。
// 前から n 個の外の `!_` の `inc 5 !_` は、畳み込みでは `inc 5` が閉じた後ろの口の外（R44 なら `inc 5`）とも読めるが、R34 が並び全体で
// 頭の実引数に数える形で、内側の `_` の `inc 5 _ 6`（R38 の G13）と揃えて G13 のまま断る（§5 Q40）。
// 括りの関数の頭（名前の定義か `?` の括り）の同じ形（前から n 個が全部値で、その外に `!_` がある `pq 1 2 !_`・`pt [1] 2 !_ 5`。
// pq は `[a] y ? y`）も、同じ問いなので断る（G5、§5 Q40）。括りの関数の口に入る `!_`（`io1 !_ 5`・`5 io1 !_`・`io1 inc !_`）は、
// 畳み込みの1歩が G5 で断る（holeStep。穴は素の関数だけ、括りの仮引数の関数では `_` が括りの受ける並びの中の印になる、U〔答え〕10-14
// 22:23）。前（2026-10-23 の最初の版）は、`!_` のすぐ前の値の並びの頭が括りの関数なら、ここで並び全体を G5 で断っていて、`!_` が
// 括りの関数の口でなく前の関数の口に入る `inc io1 !_`（`(inc io1) !_` は R46 で通る）と、括りの頭でない `(pq 1) 2 !_`（`(add 1) 2 !_`
// は通る）まで断っていた（確かめで見つかった、2026-10-23）。
// ほかの位置の `!_` は断らず、畳み込みの1歩で読む（holeStep。口の外は恒等射（R44）、口の中は穴と恒等射が同じ関数になる所だけ通す
// （R46））。前は、ほかの位置を全部 G7 で断っていた（U〔答え〕2026-10-21 23:47）。
function holeRefusal(items) {
  const h = items[0];
  const fn = h.cat === "plain" && h.kind.k === "L" && (h.isLambdaName || h.isQBracket) ? h.kind.fn : null;
  if (fn && fn.type === "pattern" && !fn.lastBracket) {
    const ts = items.slice(1);
    const n = fn.n;
    const beyond = ts.slice(n);
    if (beyond.some(isHoleItem) && ts.slice(0, n).every(isValueItem) && beyond.every((t) => isHoleItem(t) || isMark(t) || isValueItem(t))) {
      return gate(
        "G5",
        `括りの関数 \`${showView(h.view)}\` の口（${n}）を値で埋めた後ろに、括らない \`!_\` があります。畳み込みでは閉じた値の後ろの口の外の恒等射（R44）とも、括りの関数の実引数の穴（穴は素の関数の実引数にだけ書けます、U〔答え〕10-14 22:23）とも読めます。素の関数の頭の同じ形（\`inc 5 !_\`、G13）と同じ問いで、決まっていません（§3.5、§5 Q40）。`
      );
    }
  }
  return g13Of(items);
}

// G13（R34・R38 が読まない、穴と実引数の数が合わない並び）か。当たらなければ null。穴は `!_` と、既定値の無い素の関数の頭なら
// 最後の項でない書いた `_`（R38）。
function g13Of(items) {
  const h = items[0];
  const ts = items.slice(1);
  const n = holeHeadArity(h);
  if (n === null || !ts.length) return null;
  const unitHoles = isPlainHead(h) && !isMark(ts[ts.length - 1]);
  const isHole = (t) => isHoleItem(t) || (unitHoles && isMark(t));
  if (!ts.some(isHole) || ts.length === n || !ts.every((t) => isHole(t) || (t.cat === "plain" && t.desc.k === "A"))) return null;
  const what = isPlainHead(h) ? "素の関数" : "既定値のある関数";
  const arity = isPlainHead(h) ? `${n}` : `${n}。既定値のある仮引数も1つと数える`;
  const spread = ts.some((t) => t.cat === "plain" && t.desc.spread);
  // 綴りの後ろに空白を置く（「穴 `!_` があり」。括弧で閉じる方は空白を置かない）。
  const hole = unitHoles && ts.some(isMark) ? "穴（`!_` か、内側の書いた `_`、R38）" : "穴 `!_` ";
  const why = spread
    ? "撒く項があるので実引数の数が数えられず、穴に入れる実引数と余りが決まりません"
    : `前から ${n} 個の外に穴があります。余った実引数は前から順に穴へ入れますが、入れる物が穴の読みは決まっていません`;
  return gate(
    "G13",
    `${what} \`${showView(h.view)}\` の実引数の並びに${hole}があり、書いた数（${ts.length}）がアリティ（${arity}）と違います。${why}（§4 R34・R38、§5 Q31）。`
  );
}

// R39：既定値のある関数 fn（合成の最初の関数でもよい）の実引数の並び ts の、書いた `_` を読む。前から数えた位置が既定値のある口
// （fn.defaultAt）なら、既定値という値の葉（cat "default"、A）に替える。既定値の無い口・位置が数えられない形（撒く項か、値でない項が
// 前にある・n が数えられない）は G15 で断る。穴 `!_` は1つの口に数える（tryHole、R16・R34）。
function defaultUnits(head, fn, ts, what = "") {
  const at = fn.defaultAt;
  const slot = (t) => isHoleItem(t) || isMark(t) || (!!t.kind && t.kind.k === "A" && !(t.t === "leaf" && t.desc && t.desc.spread));
  return ts.map((t, i) => {
    if (!isMark(t)) return t;
    if (at && i < at.length && ts.slice(0, i).every(slot) && at[i]) return { ...t, cat: "default", desc: A(), kind: A() };
    const why = !at
      ? "仮引数の数が数えられないので、どの口に当たるかが決まりません"
      : !ts.slice(0, i).every(slot)
        ? "前に撒く項か値でない項があるので、どの口に当たるかが数えられません"
        : i >= at.length
          ? `前から ${i + 1} 番目で、仮引数（${at.length}）の外に当たります`
          : `前から ${i + 1} 番目の口は既定値の無い仮引数です`;
    throw gate(
      "G15",
      `既定値のある関数${what} \`${show(head)}\` の実引数に書いた \`_\` が、既定値のある口に当たりません（${why}）。既定値の無い口に当たる \`_\` の読みは決まっていません（§4 R39、§5 Q8）。`
    );
  });
}

// R16：穴。並び全体が `h t1 … tn` で、h が素の関数（名前の定義か `?` の括り）・撒く項が無い・k = n（穴も数える）・穴でない
// ti が全部 A のとき、各穴を生成名に替えて `(? [$p0 …] (apply h …))` にする。種類は L、アリティは穴の数。
// 穴は `!_`（その口の恒等射）と、最後の項でない書いた `_`（U 10-14 03:10「f _ 10 は a ? f a 10」）。`!_` は最後の項でもよい
// （η：`add 1 !_` は `add 1`、`inc !_` は `inc`）。最後の `_` は「終わり」（R28、markStep）なので穴にしない。
// 既定値のある関数：書いた `_` は、既定値のある口に当たれば既定値という値（R39、defaultUnits。値の項として実引数に残す）、既定値の
// 無い口なら G15。穴 `!_` の無い並びの `_` は、畳む所（markStep・defaultUnit）が同じ規則で読む。
// `!_` は既定値があっても穴（仮引数の数 n で k = n を見る。n が数えられなければ穴にしない、defaultsArity）。その関数の適用の
// 種類は未知（§5 Q8）なので、穴の関数もアリティの分からない関数（other）にする。アリティは数えない（§3.4 の
// 穴の行。`(gd !_ 3) 5` は未知、`(gd !_ 3) _` は終わりの頭のアリティが数えられないので G5）。
// 穴の規則の条件（並び全体が頭の実引数の並び・穴でない項が全部 A・撒く項が無い・最後の項が `_` でない）は並び全体の形なので、
// 畳む前に並び全体で見る（R43。中身は今のまま）。読めた並びは、穴の関数か、穴を全部埋めた適用（の後ろに余り）がそのまま答え。
// items は並び全体か、値の後ろに積まれた関数から並びの終わりまで（subHole、R47。`X F Y` の `F Y` は括った `(F Y)` と同じ並び）。
// k ≠ n は R34（holeMismatch）。既定値の無い素の関数の頭の、最後の項でない書いた `_` は、k ≠ n でも `!_` と同じ穴（R38。U 10-21
// 03:14 のカリー化と、余りは口に入ってから後ろに積まれる R35 から出した読み）。最後の項が `_` の k ≠ n は読まない（最後の `_` は
// 終わり、R28。`!_` が残れば holeRefusal が G5・G13 を見て、残りは畳み込みの1歩が読む：holeStep、R44・R46）。
function tryHole(items, ctx) {
  const h = items[0];
  const fn = h.kind.fn;
  if (h.cat !== "plain" || h.kind.k !== "L" || !fn) return null;
  let ts = items.slice(1);
  let marks = ts.some(isMark);
  if (!marks && !ts.some(isHoleItem)) return null;
  const defaulted = fn.type === "other" && !!fn.defaults;
  if (defaulted && marks) {
    if (!ts.some(isHoleItem)) return null;
    ts = defaultUnits(h, fn, ts);
    marks = false;
  }
  const n = holeHeadArity(h);
  if (n === null) return null;
  if (ts.length !== n) return marks && isMark(ts[ts.length - 1]) ? null : holeMismatch(h, ts, n, ctx);
  if (isMark(ts[ts.length - 1])) return null;
  if (!ts.every((t) => isMark(t) || isHoleItem(t) || isValueItem(t))) return null;
  const params = [];
  const args = ts.map((t) => {
    if (!isMark(t) && !isHoleItem(t)) return t;
    const name = holeName(ctx, params.length);
    params.push(name);
    return holeParamLeaf(name);
  });
  return { t: "hole", params, body: holeApply(h, args), kind: { k: "L", fn: holeFnOf(fn, params.length) } };
}

// 穴の書き換えの本体と、穴を全部埋めた適用：頭に口の数だけ当てた適用（§3.4 の k = n）。既定値のある関数の適用は未知（§5 Q8）。
function holeApply(h, args) {
  const fn = h.kind.fn;
  const kind = fn.type === "plain" ? (fn.getBodyRoot() === "A" ? A() : U()) : U();
  readerAtPlain(fn, args); // 穴の関数の実引数に書いた Reader・番地も、口に渡した物（R60 の細かい所・R62。`f3 $5 !_ 2`）
  return { t: "apply", head: h, arg: args.length === 1 ? args[0] : { t: "construct", items: args, kind: A() }, kind };
}

// 穴の生成名と、それを実引数の位置に置いた葉（A）。
const holeName = (ctx, i) => `$${ctx.F.holePrefix}${i}`;
const holeParamLeaf = (name) => ({ t: "leaf", term: null, cat: "plain", desc: A(), kind: A(), view: { v: "atom", text: name } });
// 穴の関数の fn。頭が既定値のある関数なら、アリティの分からない関数（tryHole の注）。素の関数なら、出どころ "hole" のアリティ n の
// 素の関数（本体の根は頭のもの）。restAt は R34 の k < n で作った関数（最後の括りの仮引数で残りを受ける、holeMismatch）のときだけ
// 渡し、印 rest と、最後の括り `[~c]` の前に残る裸の口の数 restAt を付ける。
function holeFnOf(fn, n, restAt) {
  if (fn.type === "other") return { type: "other" };
  const out = { type: "plain", origin: "hole", n, getBodyRoot: fn.getBodyRoot, idKey: fn.idKey, envDepth: fn.envDepth };
  if (restAt !== undefined) {
    out.rest = true;
    out.restAt = restAt;
  }
  return out;
}


// R34：穴 `!_` があって、実引数の数 k が頭のアリティ n と違う（§5 Q31 の答え）。頭は R16 と同じ（素の関数か、n が数えられる
// 既定値のある関数。名前の定義か `?` の括り）。穴でない項は全部 A で撒く項が無いときだけ読む。既定値の無い素の関数の頭では、最後の
// 項でない書いた `_` も穴に数える（R38。`f2 _ 3 4` は `f2 4 3`、`f3 _ 2` は `a [~c] ? f3 a 2 c~`）。
// - k > n：前から n 個で穴の関数を作り（R16）、残りの実引数を前から順にその穴へ入れる（U〔答え〕10-21 22:51「合ってる。Bだね」。
//   主の Claude の問いの (B)「`go !_` は穴で `a ? go a`、後ろの xs がその穴を埋めて `go xs`。`f !_ 3 4`（f は2引数）は
//   `(a ? f a 3) 4` で `f 4 3`。括った `[f !_ 3] 4` と同じ答え」）。左からの畳み込みでは、穴の関数がいちばん上にあり、後ろの値が
//   1つずつ穴を埋める（R40 の適用）。穴より残りが多ければ、穴を全部埋めた適用の後ろに余りを積む（R35）。適用の種類が値でなければ、
//   その後ろに項が来るので G2(a)（R40 の読み6。前は G12(b)）。穴が残れば、残った穴を待つ穴の関数（L）。木は埋めた所を値に替えた形
//   （`go !_ xs` は `(apply go xs)`、`f !_ 3 4` は `(apply f (construct 4 3))`。決定の規則）。既定値のある関数は、アリティが分からない
//   （§5 Q8）ので、余りも実引数に入れる（前と同じ。`gd !_ 3 4 5` は `(apply gd (construct 4 3 5))`、未知）。
// - k < n：穴を前から順に裸の仮引数にし、書いていない後ろの n − k 個の口を、最後の括りの仮引数 `[~c]` 1つで受けて後ろへ撒く
//   関数にする（U〔答え〕10-21 22:55「`a [~c] ? f3 a 2 c~` / という、足りない分は全部後ろへっていう変換がかかる。」）。木は
//   `(? [$p0 [~$p1]] (apply f3 (construct $p0 2 $p1~)))`。印 rest と、最後の括りの前に残る裸の口の数 restAt を持つ（holeFnOf）。
//   最後の括りは可変長の口で、並びの終わりまで受けて閉じる（R41、restCloseKind）。1つだけ入った物は [x] ≅ x でその中身の並び
//   （`(f3 !_) 1 [1 2]` は `f3 1 1 2`）。前は、最後の括りにちょうど1つで入る数でない値を G13 で断っていた（R34 の k < n の G13）。
//   書いた `_` は G5（markStep。括りの受ける並びの中の消える印とも、c に入る値とも読める）。
// 読まない形（null を返し、holeRefusal か g13Of が G13 で断る）：撒く項がある（k が数えられない）・k > n で前から n 個の外に穴がある
// （残りの実引数を穴へ入れる、の「入れる物」が穴になる。前から n 個に穴の無い `inc 5 !_` も、内側の `_` の `inc 5 _ 6` と揃えて断る、§5 Q40）。
function holeMismatch(h, ts, n, ctx) {
  // 穴は `!_` と、既定値の無い素の関数の頭なら書いた `_`（R38。呼ぶ側の tryHole が、最後の項が `_` の並びを先に外す。既定値のある
  // 関数の頭の `_` は、既定値のある口なら値の葉に替えてあり、ほかは G15 で断ってある）。
  const isHole = (t) => isHoleItem(t) || isMark(t);
  if (!ts.every((t) => isHole(t) || isValueItem(t))) return null;
  const fn = h.kind.fn;
  const params = [];
  const param = () => {
    const name = holeName(ctx, params.length);
    params.push(name);
    return holeParamLeaf(name);
  };
  if (ts.length > n) {
    const rest = ts.slice(n);
    if (rest.some(isHole)) return null;
    let r = 0;
    const filled = ts.slice(0, n).map((t) => (!isHole(t) ? t : r < rest.length ? rest[r++] : param()));
    const extra = rest.slice(r);
    if (params.length) return { t: "hole", params, body: holeApply(h, filled), kind: { k: "L", fn: holeFnOf(fn, params.length) } };
    if (fn.type === "other") return holeApply(h, [...filled, ...extra]);
    const app = holeApply(h, filled);
    if (!extra.length) return app;
    if (app.kind.k !== "A") throw unknownNeighbor(app, extra[0]);
    return { t: "construct", items: [app, ...extra], kind: A() };
  }
  const args = ts.map((t) => (isHole(t) ? param() : t));
  const c = holeName(ctx, params.length);
  const spread = { k: "A", spread: true };
  const items = [...args, { t: "leaf", term: null, cat: "plain", desc: spread, kind: spread, view: { v: "atom", text: `${c}~` } }];
  const body = { t: "apply", head: h, arg: { t: "construct", items, kind: A() }, kind: U() };
  return { t: "hole", params: [...params, `[~${c}]`], body, kind: { k: "L", fn: holeFnOf(fn, params.length + n - ts.length, params.length) } };
}

// ---------------------------------------------------------------------------
// 入り口
// ---------------------------------------------------------------------------

/**
 * ソースを前段に通し、余積を解いた木を返す。
 * @param {string} source
 * @returns {{ trees: object[], diagnostics: object[] }}
 */
export function resolve(source) {
  let lines;
  try {
    lines = frontEnd(source).map((words) => parseRow(words));
  } catch (e) {
    throw stackRefusal(e) || e; // 前段の深い括弧の入れ子でも、スタックの溢れは内部の例外にしない（stackRefusal の注）
  }

  const diagnostics = [];
  const F = {
    defs: new Map(),
    namedLambdas: new Map(),
    valueMemo: new Map(),
    valueCounts: new Map(), // 値の定義 → 右辺の器の数（nameKindOf・valueCountOf）
    stringCounts: new Map(), // 値の定義 → 右辺の文字列の文字の数（nameKindOf・stringCountOf。撒いた流れの数だけが読む）
    bodyMemo: new Map(),
    stack: [],
    inProgress: new Map(),
    fileScope: null,
    holePrefix: "p",
    reported: new Set(),
    // 畳まない2項の点なしの information を出した、書いた所（reportNotFolded）。
    reportedPf: new Set(),
    // 評価する所の外で余ったラムダ（R52）の warning を出した、積まれた関数の書いた所（reportLeftover）。
    reportedLeft: new Set(),
    // 括りの関数の実体（R24・R25）：鍵 → 実体、書いた `?` → 範囲の鍵 → その `?` を通って呼んだ実体（recordCall）、
    // 根の種類の仮置きの記録、木を解いている途中の実体、定義の行の `?` の木（最後に実体で埋める）、実体の本体の
    // 診断の出し先。
    instances: new Map(),
    // 書いた `?` → それを通って呼んだ確定した実体の集まり（INSTANCE_TOTAL_LIMIT）、作って外れていない実体の数
    // （INSTANCE_WORK_LIMIT）。
    instanceTotals: new Map(),
    instancesMade: new Map(),
    calls: new Map(),
    instMemo: new Map(),
    matStack: [],
    patternNodes: [],
    // 値の定義 → 右辺が書いた `_` を指すか（R56、nameKindOf が置き、pointsToMark・dollarNameTarget が読む）。
    unitDefs: new Map(),
    // 値の定義 → 右辺が番地の字面（`0x…`・`NxHHHH`。括り1つ・別名を通しても）か（R62、nameKindOf が置き、hexName が読む）。
    hexDefs: new Map(),
    // 値の定義 → 右辺の余ったラムダ（R59、nameKindOf が置く）、素の `?` の定義 → 本体の余ったラムダ（bodyRootOf が置く）と括りの関数の定義 → 仮引数を
    // 含まない行の余ったラムダ（deadOfDef・deadInPatternBody）、既定値のある `?` の定義の本体を解いている途中の印と別名を辿っている途中の印（deadOfDef）。
    deadDefs: new Map(),
    deadBodies: new Map(),
    deadBusy: new Set(),
    // 値の定義 → 右辺を解いた木（R59 の別名の引き継ぎ、aliasDeadOfTree。nameKindOf が置く）。
    defRoots: new Map(),
    diag: diagnostics,
    // 無名の素の関数の本体を解いている間に引いた仮置き（collectedRoot）。
    collectors: [],
    // 記録の鍵 → 古くなって解き直した回数（freshMemo）、枠を積んだ鍵、解き直しの守りで断った誤り（guardAgain）。
    againCounts: new Map(),
    frameKeys: new Set(),
    againRefused: null,
    // 値を含む輪で断った誤り（cycleError）。
    cycleRefused: null,
    // 実体の守りで断った誤り（guardRefusal。total・work・nest）と、解いている途中の実体の入れ子の数（enterNest）。
    guards: {},
    guardStops: new Map(), // 守りに当たった `?` → その断り（新しい実体を作らない、instantiate）
    instNest: new Map(), // 書いた `?` → 解いている途中の実体の入れ子の数（enterNest）
    instRecur: 0, // 再帰の入れ子：同じ `?` の、解いている途中の2つ目から先の実体の数の和（enterNest）
    depthLimit: 0, // 実体の深さの上限（writtenDepth）
    // いま解いている行（か前段の定義）の計算が、守りの断りの汚れを読んだか（taint）。JS のスタックの溢れの断り（stackRefusal）。
    lineTainted: false,
    stackRefused: null,
  };
  resetIntern();

  // P2：ファイルのいちばん外の定義を、先に全部集める（順序に依らない）。
  for (const line of lines) {
    const def = asDefinition(line);
    if (!def) continue;
    if (F.defs.has(def.name)) throw nameError("name-duplicate", `\`${def.name}\` がファイルのいちばん外で2回定義されています。`);
    F.defs.set(def.name, def);
    if (def.lambda) F.namedLambdas.set(def.lambda, def);
  }
  checkParamNames(lines, F);
  F.fileScope = { parent: null, params: null, locals: null, hasImport: lines.some(hasImportIn), key: "file" };
  // 実体の深さの上限（INSTANCE_DEPTH_MARGIN の注の1）：入れ子の道で、括りの関数をそれぞれ余り（32）回まで通り直したときに届く
  // 深さ。呼んだ行に書いた形と、括りの関数を1つ通るたびに足される形は、書いたいちばん深い形までしか深くない。解く前にソースだけから決める。
  let written;
  try {
    written = writtenDepth(lines, F);
  } catch (e) {
    throw stackRefusal(e) || e; // 値の定義の長い鎖を辿って溢れても、内部の例外にしない（stackRefusal の注）
  }
  F.depthLimit = (INSTANCE_DEPTH_MARGIN * written.brackets + 1) * written.deepest;

  // 穴の生成名は、ソースの名前と衝突しない綴りにする（`$p0` が `p0` の番地と読めないように）。
  const names = new Set();
  for (const line of lines) forEachNameInTree(line, (n) => names.add(n));
  while ([...names].some((n) => new RegExp(`^${F.holePrefix}\\d+$`).test(n))) F.holePrefix += "_";

  // 種類を計算する順（§6.4 の1）：名前の種類、次に各「素の」関数の本体の根。ここで輪（name-cycle）を先に見つける。
  // 括りの関数の本体は、ここでは解かない（R25：実体を作るとき＝呼ばれたときにだけ解く）。§6.4 の1の3は「各関数の
  // 本体の根」と書いたままだが、R25 が後から決まったので、素の関数に読む。
  // 門はここでは止めない——その行を解くときに、行の順に同じ門で断る。
  // 解き直しの守り（guardAgain）で断ったら、ほかの誤りより先に、その言い分で断る（握りつぶされても、ほかの門に化けても）。
  // 値を含む輪（cycleError）で断ったら、その次に、その言い分で断る（輪は種類を計算する所で見つかるので、普通は行を解く
  // 前に、輪の言い分のまま投げ上がる）。
  // 実体の総数の守りに当たったら、その次に、行の門より先に断る。作った実体の数と入れ子の数の守り（資源の守り）は、行の門の
  // 後に言う（refusalOf。当たった所は門として未知になり、根の種類を解く所や namesPattern に握りつぶされても、覚えた断りは残る）。
  // 輪より後に置くのは、守りの断りが解く順に依らずに見つかる輪を覆わないため（前は総数の守りが先に投げ上がり、輪を見る前に
  // 止まる並べ方があった。確かめ 2026-10-20）。実体の深さの守りは、鍵だけで決まる普通の門なので、ほかの門と同じく行を解くとき
  // に断る（INSTANCE_DEPTH_MARGIN の注の1）。
  let trees;
  let lineError = null;
  // 断りの順（refusalOf）：資源の守りから来た断り（当たった `?` の実体を作らせなかった所）・汚れた計算で出た断りより、ほかの
  // 断りを先に覚える。資源の守りに当たる前に作った実体の門を、守りに当たった行が先に来る並べ方でも言う（確かめ 2026-10-20）。
  const rank = (e) => (e.guard ? 2 : e.suspect ? 1 : 0);
  const noteLineError = (e) => {
    if (!e.guard && F.lineTainted) e.suspect = true;
    if (!lineError || rank(e) < rank(lineError)) lineError = e;
  };
  // 前段（名前の種類と素の関数の本体の根）の断りでも止めず、残りの定義と行を解く。その断りは、定義の行を解くときにまた出る
  // （前は門でない断りで止めたので、総数を超えるかが定義の順で割れた。確かめ 2026-10-20）。解き直しの守りと値を含む輪に
  // 当たったら止める（それを言うので。解き続けると、抜けた枠の解き直しで解き直しの守りに当たった）。
  const ahead = (f) => {
    F.lineTainted = false;
    try {
      f();
    } catch (e) {
      if (!(e instanceof OperationError) || F.againRefused || F.cycleRefused) throw e;
    }
  };
  try {
    for (const def of F.defs.values()) if (!def.lambda) ahead(() => nameKindOf(F, def));
    for (const def of F.defs.values()) if (def.lambda && def.plain) ahead(() => bodyRootOf(F, def.lambda));

    // 各行を解く。括りの関数の実体は、呼んだ所で作って木まで解く（instantiate）。断る行があっても、残りの行を解き続ける：
    // 実体の総数はファイル全体の木の性質なので、断る行で止めると、総数を超えるかが行の順で割れた（門のある行と、合わせて
    // 総数を超える2つの行。確かめ 2026-10-20）。断る行は、最初の物を覚える（行の門が2つあれば、行の順に断る。今までどおり）。
    trees = [];
    for (const line of lines) {
      F.lineTainted = false;
      try {
        // 評価する所（R42）は、定義でない行の根の並びだけ（`:` の右辺・段1〜9 の辺・括りの中・本体の行は今のまま）。根の `,` が恒等射で
        // 消えて片方の並びだけが残れば、その並びが行の根なので評価する所（R45、evaluated）。
        const t = resolveTree(line, { F, scope: F.fileScope, diag: diagnostics, evaluate: !!line && line.type === "seq" });
        const collapsed = !!line && line.type !== "seq" && line.sym === "," && !!t && !(t.t === "op" && t.sym === ",");
        trees.push(collapsed ? evaluated(t, { diag: diagnostics }) : t);
      } catch (e) {
        if (!(e instanceof OperationError) || F.againRefused || F.cycleRefused) throw e;
        noteLineError(e);
        trees.push(null);
      }
    }
  } catch (e) {
    // 合成の幅の守り（widthRefusal）も、スタックの溢れと同じ資源の守りの席に置く。
    const stack = stackRefusal(e) || widthRefusal(e);
    if (!stack && !(e instanceof OperationError)) throw e; // 内部の誤りは、覚えた断りで覆わない
    if (stack) F.stackRefused = stack;
    else noteLineError(e);
    throw refusalOf(F, lineError);
  }
  if (lineError || F.againRefused || F.cycleRefused || guardRefused(F)) throw refusalOf(F, lineError);

  // 括りの関数の `?` の木を、ファイル全体で集めた実体で埋める（R25）。全部の行を解き終えてから埋めるので、呼ぶ行が
  // 定義の前でも後でも同じ木になる。並べるのは、その `?` を通って呼ばれ（recordCall）、木まで解けた実体だけ：門に
  // 当たった実体は呼んだ行で断る（定義の行では断らず、描かない）。根の種類を出すときだけ仮に作った実体（仮置きの上で
  // 作った形）も、木まで解かれないので描かない。並び順は形の綴り、同じ綴りなら鍵（どちらも書いた物だけで決まる。
  // 鍵は canonKey なので、形を見た順に依らない）。
  for (const node of F.patternNodes) {
    const byScope = F.calls.get(node.pattern.op);
    const called = byScope && byScope.get(node.pattern.scopeKey);
    const insts = [...(called || [])].filter((i) => i.done && !i.error && i.tree);
    insts.sort((a, b) => (a.shapeText < b.shapeText ? -1 : a.shapeText > b.shapeText ? 1 : a.key < b.key ? -1 : a.key > b.key ? 1 : 0));
    node.pattern.insts = insts;
  }
  return { trees, diagnostics };
}

// ---------------------------------------------------------------------------
// 木を文字列にする
// ---------------------------------------------------------------------------

function showView(v) {
  if (!v) return "·";
  if (v.v === "atom") return v.text;
  if (v.v === "block") return `(block ${v.rows.map(show).join(" ")})`;
  return `(${v.sym} ${showView(v.left)} ${showView(v.right)})`;
}

/** 解いた木を S 式の文字列にする（書き方はファイルの頭の注）。 */
export function show(tree) {
  if (tree === null || tree === undefined) return "·";
  switch (tree.t) {
    case "leaf":
      return showView(tree.view);
    case "raw":
      return showView(tree.view);
    case "construct":
      return `(construct ${tree.items.map(show).join(" ")})`;
    case "compose":
      return `(compose ${tree.items.map(show).join(" ")})`;
    case "apply":
      return `(apply ${show(tree.head)} ${show(tree.arg)})`;
    case "hole":
      return `(? [${tree.params.join(" ")}] ${show(tree.body)})`;
    case "unit":
      return `(unit ${show(tree.inner)})`;
    case "lambda":
      if (tree.pattern) {
        const insts = tree.pattern.insts || [];
        if (!insts.length) return `(? [${tree.paramsText}] (defer {${tree.pattern.deferText}}))`;
        return `(? [${tree.paramsText}] ${insts.map((i) => `(inst ${i.shapeText} ${show(i.tree)})`).join(" ")})`;
      }
      return `(? [${tree.paramsText}] ${show(tree.body)})`;
    case "op":
      return `(${tree.sym} ${show(tree.left)} ${show(tree.right)})`;
    default:
      throw new Error(`知らない節: ${tree.t}`);
  }
}

/** 木の根の種類：'A'・'L'・'未知'。 */
export function kindOf(tree) {
  const k = tree && tree.kind && tree.kind.k;
  return k === "A" ? "A" : k === "L" ? "L" : k === "U" ? "未知" : null;
}
