/**
 * **余積（空白）の解決**（resolve.js、仕様は alpha1/docs/coproduct_spec.md）。
 *
 * §6.3 の「通る」表の全部の行を、木の文字列と（決まっている行は）根の種類で、「断られる」表の全部の行を、門の
 * reason と枝（`gate`）で確かめる。値の列は確かめない——値の段はまだ無い（§6.4 の7）。断られる行は「今は断る」
 * 試験で、§5 の問いの答えが出たら通る側へ移す（§6.4 の8）。
 *
 * 定義は §6.3 の「定義」をそのまま使う。ただし次の3か所は、仕様のほかの規則（P2：隠し）と両立しないので直した。
 * - `adder : n ? [+ n]` の仮引数 `n` は、同じ表の `n : [~x] ? x`（ファイルの定義）を隠すので `m` にした（2026-10-22 から §6.3 も
 *   `adder : m ? $[+ m]` と書く）。
 * - 「`x : add 1` の後で `x 5`」は、ファイルの定義 `x` が `inc` や `add` の仮引数 `x` を隠すので、名前を `add1` にした。
 * - `map : f [x ~y] ? …` の本体は書かれていないので、門に当たらない `x` を置いた（`@f x , map y~` は G3）。
 * 定義を足すと別の門に当たる行（隠し・同名）は、その行に要る定義だけで書いた。
 *
 * 木の書き方は resolve.js の頭の注のとおり。括りは前段が種類を残さないので、いつも `[…]` で書く（§6.3 の
 * `(f3 1)` は `[f3 1]`）。
 *
 * §6.3 の表の後ろに、表の外の規則の見本（「追加」）、実装を確かめた2つの workflow（仕様どおりか・反証）の指摘を
 * 当てた所（「確かめ」）、変異試験で壊しても落ちなかった所を見分ける入力（「穴」）を置く。「確かめ」の行は、直す
 * 前の実装では黙って通るか、別の読みになっていた。
 *
 * 最後に §5 Q1 の答え（2026-10-19、R24・R25・R26）の行（「答え」）と、期待値ではなく同じ射の綴りどうしを比べる
 * 試験（「法則」）を置く。§6.3 の「断られる」表の2行（`f : [x ~xs] ? [f xs] x` の本体・`hello : [say] ? say Hello World`
 * の本体）は、R25 で通る側（「答え」の R25 の行）へ移した。標準の定義の `map : f [x ~y] ? x` と `n : [~x] ? x` は
 * 括りの関数なので、R25 で定義の行の木が `(defer {x})` になる（試験は最後の行の木だけを見るので、期待値は変わらない）。
 * その後ろに、R24〜R26 の実装を確かめた2つの workflow の指摘を当てた行（「確かめ」の直した・穴・守り）を置く。
 * 最後に、反証の続きで直した2つ（分け合った実体の描き方・合成の鍵）の行と法則、合成の中の括りの関数（§5 Q24）の確かめ、
 * 合成を適用の畳み込みにした所（2026-10-19。(g∘f) x = g (f x) で答えが変わった行と、その法則）を置く。
 * その後ろに、値を含む輪（§5 Q30、2026-10-20。どこから入っても name-cycle で、言い分に輪の道筋）の行を置く。
 * いちばん後ろに、裸の関数を返す形（§5 Q21 の答え、2026-10-21、R33。本体の根が L か区間の綴りの `?` は G16。`$` で包んだ
 * 入れ子の `?` は、G17 で断っていたが、2026-10-21 22:46 の答えで通る（§5 Q35））の行を置く。標準の定義の adder は、この答えで
 * `$[+ m]` を返すように直した（前は `[+ m]` で本体の根が L）。
 * その後ろに左からの畳み込み（2026-10-23、R40〜R43）とその確かめの直しの行を、口の外の恒等射と `,` の単位（同じ日、R44〜R46）の
 * 行を置き、最後に逆適用の廃止（2026-10-24、R47・R48）の行を置く。逆適用の廃止で答えの変わった上の節の行は、行の注と名前に規則の番号と
 * 前の答えを書き、門が無くなった行は最後の節の norevPasses へ移した。いちばん後ろに、その片の確かめの指摘を当てた行（値の後ろに積まれた
 * 関数の並びの穴の規則・恒等射で消えた `,` の後の G3・括りの関数の末尾の `_`・診断も門も無く未知の根で通る所）を置く。
 * その後ろに、同じ日の試し（R49〜R51）の行を置き、いちばん後ろに、評価する所の外で余ったラムダ（2026-10-24、R52）の行を置く。R52 で答えの
 * 変わった上の節の行は、行の注と名前に規則の番号と前の答えを書き、門が無くなった行（恒等射の直しの `(5 !_ f2) 3` の G7 の6行）は
 * いちばん後ろの節の r52Passes へ移した。
 *
 * 実行: node test/coproduct.test.js（`npm test` からも呼ばれる）
 */
import { resolve, show, kindOf } from "../resolve.js";

const STD = [
	"inc : x ? x + 1",
	"double : x ? x * 2",
	"d : x ? x * 10",
	"g : x ? x * 10",
	"add : x y ? x + y",
	"f2 : x y ? x - y",
	"k1 : x y ? x",
	"mul : a b ? a * b",
	"use : f x ? @f x",
	"f3 : a b c ? a + b + c",
	"f4 : a b c e ? a + b + c + e",
	"adder : m ? $[+ m]",
	"map : f [x ~y] ? x",
	"n : [~x] ? x",
	"fs : inc , double , 3",
	"vs : 1 , 2 , 3",
];

// 標準の定義の後ろに行を足す。omit は外す定義の名前（その行の仮引数が定義を隠すとき）。
const std = (lines, { omit = [] } = {}) =>
	[...STD.filter((d) => !omit.includes(d.split(" ")[0])), ...[].concat(lines)].join("\n");
// 最後の行の木。body なら `(: t (? […] 本体))` の本体。at なら、その番号の行の木（0 から、負なら後ろから）。
const lastTree = (r, body, at) => {
	const t = at === undefined ? r.trees[r.trees.length - 1] : r.trees[at < 0 ? r.trees.length + at : at];
	return body ? t.right.body : t;
};

// 通る：[名前, ソース, 木, 種類（null は見ない）, 追加の確かめ]
const passes = [
	// 逆適用の廃止（2026-10-24、R47）：値の後ろの inc は積まれて、後ろの 3 を受ける（`5 (inc 3)`。U〔答え〕[2026-10-23 15:32 ebf18260]
	// 「合ってる。 それでOK！」）。2026-10-23 は左からの畳み込みの逆適用で `(inc 5) 3`（`(construct (apply inc 5 ·rev) 3)`。U〔答え〕10-22 11:24
	// 「そう、合ってる。」は逆適用がある前提の答えで、R47 で上書きされた）。その前は強さの順（R6）で、今と同じ `(construct 5 (apply inc 3))`。
	["5 inc 3（R47。前は `(inc 5) 3`）", std("5 inc 3"), "(construct 5 (apply inc 3))", "A"],
	// `1 2 [+] 3 4` は、R47 で `1 2 ([+] 3 4)`（2026-10-23 は逆適用で `1 ([+] 2 3 4)`）。下の「左からの畳み込み」の pfReversePasses にある。
	["double inc 5", std("double inc 5"), "(apply (compose double inc) 5)", "A"],
	["[+] inc 5 6", std("[+] inc 5 6"), "(apply (compose [+] inc) (construct 5 6))", "A"],
	["[< 3,] [* 2,] 1 5 2", std("[< 3,] [* 2,] 1 5 2"), "(apply (compose [< 3,] [* 2,]) (construct 1 5 2))", "A"],
	// R31（2026-10-21）で `[+]` に数1つは値になった（`[+] 5` は 5、§5 Q17 は閉じた）。ここの後ろの `[+]` が受けるのは `[* 2,]` の結果
	// （中身の見えない A）で、器なら要素に関数が見えるかもしれないので、今までどおり未知（R31 の1項、2026-10-21 の確かめで直した。
	// R31 の最初の版は A にしていた）。
	["[* 2,] [+] 1 2 3 4 5（未知の根）", std("[* 2,] [+] 1 2 3 4 5"), "(apply (compose [* 2,] [+]) (construct 1 2 3 4 5))", "未知"],
	["k1 1 2", std("k1 1 2"), "(apply k1 (construct 1 2))", "A", { leftover: false }],
	// §5 Q11 の答え（U〔答え〕2026-10-21 23:10「余った引数は後ろに積んでいい。」、R35）：実引数がアリティより多い適用は、前から n 個を
	// 当てた適用の後ろに余りを並べた構築。前は `(apply d (construct 1 2))` に印 excess（根でだけ通る）だった。
	["d 1 2（余りは後ろに積む、R35）", std("d 1 2"), "(construct (apply d 1) 2)", "A", { leftover: true }],
	["[+ 1] 1 2 3（余りは後ろに積む、R35。値は U〔答え〕09-28 00:58 の [2 2 3]）", std("[+ 1] 1 2 3"), "(construct (apply [+ 1] 1) 2 3)", "A", { leftover: true }],
	// 2026-10-24 の試し（R51）：撒いた並びは流れの1項で、口が1つの `[+ 1]` は写像（値は [2 3 4]）。前は撒く項で k を数えないので未知の根。
	["[+ 1] [1 2 3]~（R51 の写像、試し。前は未知の根）", std("[+ 1] [1 2 3]~"), "(apply [+ 1] [1 2 3]~)", "A"],
	// 畳む点なしは最後の口が可変長なので、流れを丸ごと受ける（R51）。種類は今までどおり未知（§5 Q46）。
	["[+] [1 2 3]~（未知の根。R51 でも丸ごと受けて今のまま）", std("[+] [1 2 3]~"), "(apply [+] [1 2 3]~)", "未知"],
	// 畳む2項の点なしに List 1つは、要素を並びとして畳む（R31。U〔答え〕10-07 05:10 は `[+] ([< 3,] 1 5 2)` を 3）。ここの括りの中は
	// `[< 3,]` の結果（中身の見えない A）なので、要素が全部 A とは見えず、今までどおり未知（R31 の1項。R31 の最初の版は A にしていた）。
	["[|] ([< 3,] 5 1 2)（未知の根）", std("[|] ([< 3,] 5 1 2)"), "(apply [|] [[< 3,] 5 1 2])", "未知"],
	["[+] ([< 3,] 1 5 2)（未知の根）", std("[+] ([< 3,] 1 5 2)"), "(apply [+] [[< 3,] 1 5 2])", "未知"],
	["use $inc 5（未知の根）", std("use $inc 5"), "(apply use (construct $inc 5))", "未知"],
	// 根に残った関数は `_`（R42。木は `(unit …)` で包む）。前は L の根。値は U 09-12 00:15 の「行末で `_`」と同じ。
	["use inc 5（根に残った関数は `_`、R42）", std("use inc 5"), "(unit (apply (compose use inc) 5))", "A"],
	["use 5 inc（同じ、R42）", std("use 5 inc"), "(unit (compose (apply use 5) inc))", "A"],
	["@a b c（b, c は値、未知の根）", std("@a b c"), "(apply @a (construct b c))", "未知"],
	["本体 g x（g, x は裸の仮引数）", std("t : g x ? g x", { omit: ["g"] }), "(construct g x)", "A", { body: true }],
	["本体 @g x（未知の根）", std("t : g x ? @g x", { omit: ["g"] }), "(apply @g x)", "未知", { body: true }],
	["@(procs ' 0) 5（未知の根）", std("@(procs ' 0) 5"), "(apply @[procs ' 0] 5)", "未知"],
	["本体 mul x + 1 y", std("t : x y ? mul x + 1 y"), "(apply mul (construct (+ x 1) y))", "A", { body: true }],
	["inc 1 + 2", std("inc 1 + 2"), "(apply inc (+ 1 2))", "A"],
	["[* 2,] `ab` == `aabb`", std("[* 2,] `ab` == `aabb`"), "(== (apply [* 2,] `ab`) `aabb`)", null],
	["1 2 , 3 4", std("1 2 , 3 4"), "(, (construct 1 2) (construct 3 4))", null],
	["vs~ 4", std("vs~ 4"), "(construct vs~ 4)", "A"],
	// R47：値の後ろの関数は積まれて 5 を取らない。根に余って `_` になり、構築の中で消える（R42・R15）。余ったことは leftover-lambda で
	// 知らせる（R48）。前（2026-10-23 まで）は逆適用で `(apply inc 5 ·rev)`・`(apply (compose inc inc) 5 ·rev)`。
	["5 inc（R47・R48。前は逆適用）", std("5 inc"), "(construct 5 (unit inc))", "A"],
	["5 inc inc（R47・R48）", std("5 inc inc"), "(construct 5 (unit (compose inc inc)))", "A"],
	// `5 inc [* 2]`（§5 Q23 の答えで通っていた）は、強さの順（R6）が無くなり、`[* 2]` が `5 inc` の値を逆適用で取る（R40）。答えは
	// Q23 の答えと同じ `[* 2] (inc 5)`。下の「左からの畳み込み」の pfReversePasses へ移した（R13 は廃止、§5 Q36）。
	["add1 : add 1 の後で add1 5", std(["add1 : add 1", "add1 5"]), "(apply add1 5)", "A"],
	["g3 : f3 1 の後で g3 2 3", std(["g3 : f3 1", "g3 2 3"]), "(apply g3 (construct 2 3))", "A"],
	["(f3 1) 2 3", std("(f3 1) 2 3"), "(apply [f3 1] (construct 2 3))", "A"],
	["(f2 10) g 3", std("(f2 10) g 3"), "(apply (compose [f2 10] g) 3)", "A"],
	["add _ 10（穴。根に残った穴の関数は `_`、R42）", std("add _ 10"), "(unit (? [$p0] (apply add (construct $p0 10))))", "A"],
	// §5 Q31 の答え（R34）：余った xs が穴に入る。前は G13（下の refused にあった）。
	["go !_ xs（前は G13）", std(["go : ys ? ys", "xs : 1 , 2", "go !_ xs"]), "(apply go xs)", "A"],
	["f4 _ 2 _ 3（穴2つ。根なので `_`、R42）", std("f4 _ 2 _ 3"), "(unit (? [$p0 $p1] (apply f4 (construct $p0 2 $p1 3))))", "A"],
	["[add _ 10] 5", std("[add _ 10] 5"), "(apply [add _ 10] 5)", "A"],
	["_ \\a", std("_ \\a"), "\\a", "A"],
	["_ 1 2", std("_ 1 2"), "(construct 1 2)", "A"],
	["_ _", std("_ _"), "_", "A"],
	// 書いた `_` はいつも印（利用者 2026-10-21。穴の綴りは `!_`）。前は §3.5 の3つの形の外で G5 だった行（下の「印と穴」も）。
	["inc _（終わり：足りなければ印）", std("inc _"), "(apply inc _)", "A"],
	["([+ 1] _) 5（括りの中で終わる）", std("([+ 1] _) 5"), "(construct [[+ 1] _] 5)", "A"],
	["[!_] _（否定の点なしに終わり）", std("[!_] _"), "(apply [!_] _)", "A"],
	["1 _ 2（値だけの並びの印は消える）", std("1 _ 2"), "(construct 1 2)", "A"],
	["\\a _", std("\\a _"), "\\a", "A"],
	["_ inc 5（適用の実引数でない構築の印は消える）", std("_ inc 5"), "(apply inc 5)", "A"],
	["add 1 _（終わり：足りない適用にしない）", std("add 1 _"), "(apply add (construct 1 _))", "A"],
	// 左からの畳み込み（R40・R43）：`inc 1` は口が埋まって値になり、その後ろの `_` は値の隣の並びの単位として消える（R15）。前は
	// `(apply inc (construct 1 _))`（R28 の k' ≥ n で `_` を木に残した）。値は同じ 2。
	["inc 1 _（飽和の後ろの `_` は消える、R43）", std("inc 1 _"), "(apply inc 1)", "A", { leftover: false }],
	["f _ _（f は未定義の名前＝値）", std("f _ _"), "f", "A", { diag: "f" }],
	["_ + 1 f（中置の被演算子の印は A、f は未定義の名前）", std("_ + 1 f"), "(construct (+ _ 1) f)", "A", { diag: "f" }],
	["say 5（say は未定義）", std("say 5"), "(construct say 5)", "A", { diag: "say" }],
	["[x ? x + 1] 5", std("[x ? x + 1] 5"), "(apply [x ? x + 1] 5)", "A"],
	["map $[* 2] 1 2 3 4 5（最後の括りが残りの並びを受ける。R24、2026-10-19）", std("map $[* 2] 1 2 3 4 5"), "(apply map (construct $[* 2] 1 2 3 4 5))", "A"],
	["n 1 2 3（括り1つの関数は並び全体を受ける。R24、2026-10-19）", std("n 1 2 3"), "(apply n (construct 1 2 3))", "A"],
	// §5 Q21 の答え（2026-10-21、R33）：関数を返すなら `$` を明示する（利用者 2026-10-21「adder が返すべきは [+ m] じゃなくて $[+ m]」）。前の
	// `adder : m ? [+ m]` は G16（下の「裸の関数を返す」）で、`$[+ m]` の adder の本体の根は A。前は未知の根。
	["adder 5（前は未知の根）", std("adder 5"), "(apply adder 5)", "A"],
	["adder 5 3（余りは後ろに積む、R35。前は G12(b)、その後は excess）", std("adder 5 3"), "(construct (apply adder 5) 3)", "A", { leftover: true }],
	// §6.3 の「断られる」表から移した行（2026-10-22）。`f2 1 g 2` は §5 Q4 の答え（R36：合成は流れとして左から畳む）で `g (f2 1 2)`、
	// `5 inc 3 4` は Q11 の答え（R35）で `5 (inc 3) 4`、`1 2 inc` は Q6 の答え（R37：一番近い1項だけを取る）で `1 (2 inc)`。
	["f2 1 g 2（前は G2(b)、R36）", std("f2 1 g 2"), "(apply (compose (apply f2 1) g) 2)", "A"],
	// R47 で `5 (inc 3) 4`（2026-10-22 の強さの順と同じ木。2026-10-23 は逆適用で `(inc 5) 3 4`）。
	["5 inc 3 4（R47。前は G12(a)、その後 `5 (inc 3) 4`・`(inc 5) 3 4`）", std("5 inc 3 4"), "(construct 5 (apply inc 3) 4)", "A", { leftover: false }],
	// R47：inc は 2 を取らず積まれて、根に余って `_`（R42・R48）。Q6 の答え（U〔答え〕10-21 23:23 の `1 (2 inc)`）は逆適用がある前提の答えで、
	// R47 で上書きされた。
	["1 2 inc（R47。前は G1、その後 R37 で `1 (inc 2)`）", std("1 2 inc"), "(construct 1 2 (unit inc))", "A"],
	["inc adder 5（前は未知の根、§5 Q13）", std("inc adder 5"), "(apply (compose inc adder) 5)", "A"],
	["f : x y ? x + y（解くのは x + y だけ）", "f : x y ? x + y", "(: f (? [x y] (+ x y)))", null],
];

// 断られる：[名前, ソース, 門]
const GO_DEFAULT = ["go :", "\t\tys", "\t\tzs : 3", "\t? ys", "", "xs : 1 , 2"];
const refused = [
	// §6.3 の `f2 1 g 2`（G2(b)）・`5 inc 3 4`（G12(a)）・`1 2 inc`（G1）は、2026-10-22 に通る側（上の表）へ移した（R35〜R37）。
	// §6.3 の `[+] 5 g 3`（G2(a)）は、R31 で `[+] 5` が値になって通る側（下の「畳む2項の点なし」）へ移した。G2(a) の見本は、
	// アリティの分からない点なし `[,]` に1項の `[,] 5 g 3` にした（畳まない `[<<] 5 g 3` は R32 で足りない適用になり、R36 で流れとして通る）。
	["[,] 5 g 3（前は [+] 5 g 3）", std("[,] 5 g 3"), "G2(a)"],
	// `inc 1 2 inc`（G12(a)）は、左からの畳み込み（R40）で `(inc 1) (inc 2)` に決まった（G12(a) は廃止）。下の「左からの畳み込み」へ移した。
	// §6.3 の `adder 5 3`（G12(b)）は、adder が `$[+ m]` を返すようになって通る側へ移した（R33）。G12(b) の見本は、本体の根が
	// 未知の use にした。2026-10-23 から、種類の未知な `use $inc 5` の後ろに項が来る形として G2(a)（R40 の読み6。G12 は廃止）。
	["use $inc 5 3（前は adder 5 3。G12(b) → G2(a)、R40）", std("use $inc 5 3"), "G2(a)"],
	// §6.3 の `5 f2 1`（G8）と `xs~ inc`（G9）は、逆適用の廃止（2026-10-24、R47。G8・G9 も廃止）で通る側へ移した（いちばん後ろの
	// 「逆適用の廃止」の norevPasses）。`5 f2`・`5 (f2 1)` は下の「左からの畳み込み」の通る行にある。
	// §6.3 の `5 [+ 1]`・`5 [* 2] inc`（G10）は、2026-10-23 に R13 を廃止して通る。下の「左からの畳み込み」の pfReversePasses へ移した。
	["~1 2 3", std("~1 2 3"), "G4"],
	["y @x", std("y @x"), "G6"],
	["@f g 5", std("@f g 5"), "G6"],
	["add _ _（f _ _ の f が関数）", std("add _ _"), "G5"],
	// §6.3 の `[+] 1 _ 3`（G5）は、R31 で `_` が被演算子の印になって通る側（下の「畳む2項の点なし」）へ移した。
	["go _ xs（既定値あり）", std([...GO_DEFAULT, "go _ xs"]), "G15"],
	// §6.3 の `go !_ xs`（G13）は、§5 Q31 の答え（R34）で通る側（下の「穴と実引数の数」）へ移した。
	["inc 1 , inc 2", std("inc 1 , inc 2"), "G3"],
	["本体 @f x , map y", std("t : f x y ? @f x , map y"), "G3"],
	// §6.3 の「`f : [x ~xs] ? [f xs] x` の本体」と「`hello : [say] ? say Hello World` の本体」（G7）は、§5 Q1 の答え
	// （R24・R25）で通る側へ移した。呼ばれない括りの関数は本体を読まず、断らない（下の「答え」の R25 の行）。
	["fs~", std("fs~"), "G7"],
	["fs~ 5", std("fs~ 5"), "G7"],
	["[:] x 20", std("[:] x 20"), "G7"],
	["(m ' k) 5", std("(m ' k) 5"), "G7"],
	["@procs ' 0 5", std("@procs ' 0 5"), "G7"],
	["-inc 5", std("-inc 5"), "G7"],
	["inc + 1 5", std("inc + 1 5"), "G7"],
	// §6.3 の `5 !_ 3`（G7）は、口の外の `!_` が恒等射になって（R44、2026-10-23）通る側（下の「口の外の恒等射」の idPasses）へ移した。
	["a : b 1 と b : a 2", "a : b 1\nb : a 2", "name-cycle"],
	["inc : x ? x + 1 と h : inc ? inc 5", "inc : x ? x + 1\nh : inc ? inc 5", "name-shadow"],
];

const GATE_REASON = {
	// G1（coproduct-reverse-of-many）は 2026-10-22 に廃止（答えは U〔答え〕10-21 23:23、UTC。resolve.js の写しと同じ）。
	G2: "coproduct-partial-neighbor",
	G3: "coproduct-beside-product",
	G4: "coproduct-prefix-tilde",
	G5: "coproduct-unit-position",
	G6: "coproduct-input-position",
	G7: "coproduct-unknown-kind",
	G8: "coproduct-reverse-arity",
	G9: "coproduct-reverse-spread",
	// G10（coproduct-reverse-pointfree）は 2026-10-23 に廃止（R13 の廃止、§5 Q36。resolve.js の写しと同じ）。
	G11: "coproduct-no-reading",
	// G12（coproduct-excess-neighbor）は 2026-10-23 に廃止（左からの畳み込み、R40。resolve.js の写しと同じ）。
	G13: "coproduct-hole-arity",
	// G14（coproduct-pointfree-unit）は 2026-10-21 に廃止（resolve.js の写しと同じ）。
	G15: "coproduct-default-unit",
	G16: "coproduct-bare-function-return",
	// G17（coproduct-manual-curry）は 2026-10-22 に廃止（答えは U〔答え〕10-21 22:46、UTC。resolve.js の写しと同じ）。
	G18: "coproduct-identity-row",
	// G19 は 2026-10-24 の試し（R51。撒いた流れを受ける口の数が決まらない。resolve.js の写しと同じ）。
	G19: "coproduct-stream-arity",
};


let passed = 0;
let total = 0;
const ok = (name) => {
	console.log(`OK   ${name}`);
	passed++;
};
const fail = (name, ...lines) => console.log(`FAIL ${name}\n${lines.map((l) => `     ${l}`).join("\n")}`);

// 通る行を確かめる。extra：body（本体の木を見る）・at（見る行の番号）・leftover（根が、余りを後ろに積んだ構築か。R35。前の印
// excess の行は、2026-10-22 にこの印へ移した。2026-10-23 の左からの畳み込み（R40）で節の印 leftover は無くなったので、木の形で見る：
// 根が構築で、最初の子が適用の節（前から n 個を当てた適用の後ろに余りが並ぶ形）・diag（undefined-name が出る名前）・
// diagText（その名前の undefined-name のどれかの文面に含まれる文字列）・diagCount（出る診断の数）・pfInfo（pointfree-not-folded
// の information が出る点なしの綴り。R32）・leftoverDiag（leftover-lambda の warning が出る、余ったラムダの木の綴りの並び。出ない
// ことを見るなら []。R48、2026-10-24。重さは同じ日の §5 Q44 の答えで information から warning に上げた）・severities（出る診断の
// 「重さ/reason」を並べ替えた並び。重さの1か所 DIAG_SEVERITY を見る）。
const checkPass = (name, src, want, kind, extra = {}) => {
	total++;
	let r;
	try {
		r = resolve(src);
	} catch (e) {
		fail(name, `断られた: ${e.reason || e.name} ${e.gate || ""} ${e.message}`);
		return;
	}
	const t = lastTree(r, extra.body, extra.at);
	const got = show(t);
	const problems = [];
	if (got !== want) problems.push(`木   got:  ${got}`, `     want: ${want}`);
	if (kind !== null && kindOf(t) !== kind) problems.push(`種類 got: ${kindOf(t)}  want: ${kind}`);
	const leftover = !!t && t.t === "construct" && t.items[0].t === "apply";
	if ("leftover" in extra && leftover !== extra.leftover) problems.push(`leftover got: ${leftover}  want: ${extra.leftover}`);
	if (extra.diag && !r.diagnostics.some((d) => d.reason === "undefined-name" && d.severity === "information" && d.name === extra.diag)) {
		problems.push(`undefined-name（${extra.diag}）が出ていない: ${JSON.stringify(r.diagnostics)}`);
	}
	if (extra.diagText && !r.diagnostics.some((d) => d.reason === "undefined-name" && d.name === extra.diag && d.message.includes(extra.diagText))) {
		problems.push(`undefined-name（${extra.diag}）の文面に「${extra.diagText}」が無い: ${JSON.stringify(r.diagnostics)}`);
	}
	if (extra.pfInfo && !r.diagnostics.some((d) => d.reason === "pointfree-not-folded" && d.severity === "information" && d.name === extra.pfInfo && d.message.includes("おすすめはしません"))) {
		problems.push(`pointfree-not-folded（${extra.pfInfo}）が出ていない: ${JSON.stringify(r.diagnostics)}`);
	}
	if ("diagCount" in extra && r.diagnostics.length !== extra.diagCount) {
		problems.push(`診断の数 got: ${r.diagnostics.length}  want: ${extra.diagCount}  ${JSON.stringify(r.diagnostics)}`);
	}
	if ("leftoverDiag" in extra) {
		const left = r.diagnostics.filter((d) => d.reason === "leftover-lambda");
		const names = left.map((d) => d.name);
		if (JSON.stringify(names) !== JSON.stringify(extra.leftoverDiag)) problems.push(`leftover-lambda got: ${JSON.stringify(names)}  want: ${JSON.stringify(extra.leftoverDiag)}`);
		for (const d of left) {
			if (d.severity !== "warning" || !d.message.includes(`\`${d.name}\``) || !d.message.includes("R48")) problems.push(`leftover-lambda の重さか文面が違う: ${JSON.stringify(d)}`);
		}
	}
	if ("severities" in extra) {
		const got = r.diagnostics.map((d) => `${d.severity}/${d.reason}`).sort();
		if (JSON.stringify(got) !== JSON.stringify(extra.severities)) problems.push(`診断の重さ got: ${JSON.stringify(got)}  want: ${JSON.stringify(extra.severities)}`);
	}
	if (problems.length) fail(name, ...problems);
	else ok(name);
};

// 断られる行を確かめる。want が `G…` なら門の reason と枝（`gate`）を、それ以外なら reason だけを比べる。
// inst があれば、括りの関数の実体で当たった門（R25）で、呼んだ行が名指しした関数と形の並び（[[関数, 形], …]）も比べる。
const checkRefused = (name, src, want, inst) => {
	total++;
	try {
		const r = resolve(src);
		fail(name, `断るはずが通った: ${show(r.trees[r.trees.length - 1])}`);
	} catch (e) {
		const isName = !/^G/.test(want);
		const wantReason = isName ? want : GATE_REASON[want.replace(/\(.\)$/, "")];
		const gotInst = e.instances ? JSON.stringify(e.instances.map((i) => [i.fn, i.shape])) : "なし";
		const instOk = !inst || gotInst === JSON.stringify(inst);
		if (e.reason === wantReason && (isName || e.gate === want) && instOk) ok(`${name} → ${want}`);
		else {
			fail(
				name,
				`got: ${e.reason} ${e.gate || ""}  want: ${wantReason} ${isName ? "" : want}`,
				...(inst ? [`実体 got: ${gotInst}  want: ${JSON.stringify(inst)}`] : []),
				e.message
			);
		}
	}
};

for (const [name, src, want, kind, extra] of passes) checkPass(name, src, want, kind, extra);
for (const [name, src, want] of refused) checkRefused(name, src, want);

// §6.3 の外：仕様の規則（§4・§3.4・P2）の見本で、上の表に無いもの。
const extraPasses = [
	// R12 の見本は `|x| f`。`f` は標準の定義に無い（`use` の仮引数を隠す）ので、アリティ1の `inc` で書く。R12 は 2026-10-24 に廃止
	// （R47）：inc は `|x|` の後ろに積まれて余り、根で `_`（R42・R48）。前は `(apply inc |x| ·rev)`。
	["R12 |x| inc（R47。前は逆適用）", std("|x| inc"), "(construct |x| (unit inc))", "A"],
	// R47 で `1 (d 2)`（2026-10-22 の強さの順と同じ木）。2026-10-23 は逆適用で `(d 1) 2`。
	["R7 1 d 2（R47。前は `(d 1) 2`）", std("1 d 2"), "(construct 1 (apply d 2))", "A"],
	// `5 [+ 1] 3` は、左からの畳み込みでは `[+ 1]` が 5 を逆適用で取って `([+ 1] 5) 3`（R40。R13 は廃止）。下の「左からの畳み込み」の
	// pfReversePasses へ移した。
	["R19 (inc 1) , (inc 2)", std("(inc 1) , (inc 2)"), "(, [inc 1] [inc 2])", null],
	["R1 x * 2 y * 2", std("t : x y ? x * 2 y * 2"), "(construct (* x 2) (* y 2))", "A", { body: true }],
	// 再帰は A と仮置きして一巡する（§3.4）。仮置きと合えば A のまま。
	["再帰：仮置きが合う", std(["fact : k ? k * [fact k - 1]", "fact 5"]), "(apply fact 5)", "A"],
	// 仮置きと食い違えば未知（本体の根は、仮置き A から引いた物で未知）。根の k = n は未知で通り、k > n は G12(b)。
	// この行は、根が仮置きのままでも未知になるので、仮置きを取り消す仕組みは見ていない（寄生したオラクル）。
	// 取り消しは下の「相互再帰」の2行で見る。前の本体は `[+ [r k]]`（仮置き A の上で区間 L）だったが、区間の綴りの本体は
	// G16（R33、2026-10-22）なので、`(r k) ' 0` にした。
	["再帰：仮置きが外れる", std(["r : k ? (r k) ' 0", "r 1"]), "(apply r 1)", "未知"],
	// 字下げのブロックの本体：全部の行（枝なら値の側）の根が A のときだけ A。
	["字下げの本体", std(["sgn : v ?", "\tv < 0 : 0 - v", "\tv", "", "sgn 5"]), "(apply sgn 5)", "A"],
];
const extraRefused = [
	// 種類の未知な `r 1` の後ろに 2 が来る（R40 の読み6。前は G12(b)、G12 は廃止）。
	["再帰：仮置きが外れて k > n（G2(a)、R40）", std(["r : k ? (r k) ' 0", "r 1 2"]), "G2(a)"],
	["同じ名前の定義が2つ", "p : 1\np : 2", "name-duplicate"],
	["入れ子の関数の仮引数が外の仮引数を隠す", "f : x ? [x ? x] x", "name-shadow"],
	["取り込みのある範囲の未定義の名前は未知", "io@\nsay 5", "G7"],
];
for (const [name, src, want, kind, extra] of extraPasses) checkPass(`追加 ${name}`, src, want, kind, extra);
for (const [name, src, want] of extraRefused) checkRefused(`追加 ${name}`, src, want);

// 2つの確かめ（仕様どおりか・反証）の指摘を当てた所。それぞれ、直す前は黙って通っていたか、別の読みになっていた。
const GO = ["go : ys ? ys", "xs : 1 , 2"];
const fixPasses = [
	// 前の R18（括らない `!_` を取り除く）の行 `go !_ vs~` は、R18 を廃止して G13（下の fixRefused）へ移した。
	// 前は貪欲な2項が `[+]` だけで、`[*]` などは種類が未知だった。R31（2026-10-21）で算術・ビット・論理・比較の両側の欠けた点なしは
	// 畳む（`[op] x1 … xn` は `x1 op … op xn`）ので A。畳まない点なし（`[<<]` など）は R32 で素の2引数の関数になった（下の「畳まない
	// 2項の点なし」）。アリティの分からない点なしで残るのは `[,]` だけで、今までどおり種類が未知で、根なら通る。
	// `[+]` が並びを受けている間に来た inc は合成の後ろ（R41）。木は入れ子の適用（2026-10-24、R47 で `·rev` の綴りが無くなった。
	// 前は `(apply inc (apply [+] (construct 5 6)) ·rev)`）。
	["[+] 5 6 inc（畳む2項）", std("[+] 5 6 inc"), "(apply inc (apply [+] (construct 5 6)))", "A"],
	["R31 で変わった [-] 5 3 1（前は未知の根）", std("[-] 5 3 1"), "(apply [-] (construct 5 3 1))", "A"],
	["R31 で変わった [*] inc 2 3（前は未知の根）", std("[*] inc 2 3"), "(apply (compose [*] inc) (construct 2 3))", "A"],
	["[,] 5 3 1（アリティの分からない点なしは未知の根）", std("[,] 5 3 1"), "(apply [,] (construct 5 3 1))", "未知"],
	["[,] inc 2 3（未知の根）", std("[,] inc 2 3"), "(apply (compose [,] inc) (construct 2 3))", "未知"],
	// 段18 の点なしの適用は、k = 1 なら `fs ' 0` と同じ desc（R26。2026-10-19 に §2 Q1 の答えで決まった）。ここは
	// k = 2 なので未知のまま。k = 1 の `[' 0] fs` も、fs の要素に関数が見えるので未知（下の「法則」で比べる）。
	["[' 0] fs 5（未知の根）", std("[' 0] fs 5"), "(apply [' 0] (construct fs 5))", "未知", { leftover: false }],
	// 中置の右のブロックは前段が置く場所なので通る。
	["中置の右のブロック", std(["v : 1 +", "\t2"]), "(: v (+ 1 (block 2)))", null],
	// 合成の最初の関数の本体の根が値でなければ、k = n でも未知。前は本体の根が L の adder（§5 Q21）で見ていたが、根が L の関数は
	// G16 になった（R33）ので、根が未知の uu で見る。adder は `$[+ m]` を返すので A。
	["uu inc 5（未知の根。前は adder inc 5）", std(["uu : x ? [,] x", "uu inc 5"]), "(apply (compose uu inc) 5)", "未知"],
	["adder inc 5（前は未知の根）", std("adder inc 5"), "(apply (compose adder inc) 5)", "A"],
	["use inc 5 6（未知の根）", std("use inc 5 6"), "(apply (compose use inc) (construct 5 6))", "未知"],
	// 器の中の器まで見て、関数が無ければ撒ける。
	["[vs 1]~ 5", std("[vs 1]~ 5"), "(construct [vs 1]~ 5)", "A"],
	// 別名の適用の種類は生まれた関数で決める。値の後ろの pq は、2026-10-23 までは逆適用の右に置けた（`(apply pq 5 ·rev)`）。R47 で
	// 積まれて余り、根で `_`（R42・R48）。
	["pq : [x ? x + 1] の後で 5 pq（R47。前は逆適用）", std(["pq : [x ? x + 1]", "5 pq"]), "(construct 5 (unit pq))", "A"],
	["p : inc の後で p 5", std(["p : inc", "p 5"]), "(apply p 5)", "A"],
	// `||_||` は値の単位のまま A。
	["||_|| 5", std("||_|| 5"), "(construct ||_|| 5)", "A"],
	// 括りの仮引数の `:` の右は既定値で、仮引数ではない（隠しに数えない）。
	["ff : [z : inc] ? z（inc を仮引数に数えない）", std("ff : [z : inc] ? z"), "(: ff (? [[z : inc]] z))", null],
	// 括りの中の `:` の左の名前は、その括りの外では局所の名前にしない。
	["[qq : 1] は information を出さない", std("[qq : 1]"), "[qq : 1]", "A", { diagCount: 0 }],
	// P2 の文面どおり：本体の `:` の左が仮引数なら、その名前は仮引数のまま（局所の定義か枝かは §5 Q10）。
	["本体 a : inc ⏎ a 5（a は仮引数）", std(["hh : a ?", "\ta : inc", "\ta 5"]), "(block (: a inc) (construct a 5))", null, { body: true }],
];
const fixRefused = [
	// 括らない `!_` は穴（§3.5）。読めるのは、素の関数の実引数の並び（k = n は R16、k ≠ n は R34）・`!_` 1つ・`||!_||` だけで、
	// ほかは G7 か G13。前の R18（すぐ左が L・すぐ右が A なら取り除く）は廃止した（2026-10-21）。`!_` 1つの行（`x2 : !_` など）は
	// 下の「印と穴」で通る。R34（§5 Q31 の答え）でも、撒く項があれば k が数えられないので G13 のまま（下の「穴と実引数の数」）。
	["R18 を廃止した go !_ vs~（k ≠ n、撒く項）", std([...GO, "go !_ vs~"]), "G13"],
	["!_ + 1", std("!_ + 1"), "G7"],
	["[+ !_] 1", std("[+ !_] 1"), "G7"],
	["[+ !_]（1項でも）", std("[+ !_]"), "G7"],
	// `inc !_ inc`（G7）は、口が1つだけ残った inc の口の `!_` で、穴と読んでも恒等射と読んでも同じ関数（R46、2026-10-23）なので、
	// 通る側（下の「口の外の恒等射」の idPasses）へ移した。
	// アリティの分からない点なし `[,]` は、種類が未知の適用になる。前の `[*] 2 3 inc`・`1 [*] 2 3 4`（G2(a)）は、R31 で畳んで通る側
	// （下の「畳む2項の点なし」）へ移した。
	["[,] 2 3 inc（前は [*] 2 3 inc）", std("[,] 2 3 inc"), "G2(a)"],
	// `1 [,] 2 3 4`（2026-10-23 は G8：`[,]` が 1 を逆適用で取り、主語の口が決まらないまま 2 が来る）は、逆適用の廃止（R47）で
	// `1 ([,] 2 3 4)` に決まり、通る側（いちばん後ろの「逆適用の廃止」の norevPasses）へ移した。
	// `5 [*]`・`5 [' 0]`（G10）は、R13 を廃止して通る（R40）。下の「左からの畳み込み」の pfReversePasses へ移した。
	// 段18 の点なし。`[@] fs 0` は R32 で素の2引数の関数の足りた適用になり、get なので種類は未知（対に入れば G2(a)）。
	["[' 0] fs inc", std("[' 0] fs inc"), "G2(a)"],
	["[@ 0] fs inc", std("[@ 0] fs inc"), "G2(a)"],
	["[@] fs 0 inc", std("[@] fs 0 inc"), "G2(a)"],
	// §3.3 の「他の読みと割れる所」の `5 inc 3 inc` は、前は G1（左が構築の節）だった。2026-10-22 から R37 で一番近い1項（`inc 3`）を
	// 取って通る（下の「余りと流れ」の行）。2026-10-24 の R47 からは `5 (inc 3)` の後ろに inc が余る。
	// 撒く項を中置・点なしにどう渡すかは仕様に無いので未知（2項以上の並びで G7）。
	["vs~ + 1 5", std("vs~ + 1 5"), "G7"],
	["[+ vs~] 1", std("[+ vs~] 1"), "G7"],
	// 種類の未知な名前を撒く項は未知の葉。中身の見える名前は位置に依らず G7。
	["q : use $inc 5 の後で q~ 5", std(["q : use $inc 5", "q~ 5"]), "G7"],
	["q : [use $inc 5] の後で q~", std(["q : [use $inc 5]", "q~"]), "G7"],
	// 穴の頭は、`?` の定義を直に指す名前か `?` の括りだけ（別名は断る側に揃えた）。逆適用の右の `5 [inc]`・`5 q`・`5 p` は、口が1つだけ
	// 残った関数なので、2026-10-23 からその口を埋めた（R40 の読み3。2026-10-24 の R47 からは値の後ろに積まれて余る）。下の「左からの畳み込み」の
	// 通る行へ移した。
	["p2 : add の後で p2 _ 3", std(["p2 : add", "p2 _ 3"]), "G5"],
	// 字下げのブロックは並びの項にならない（§2）。中置の右でない所のブロックは断る。
	["ブロックが並びの項", std(["v :", "\tinc", " 5"]), "indent-block-position"],
	["ブロックが中置の左", std(["v :", "\t1", " + 1"]), "indent-block-position"],
	["ブロックが , の左", std(["v :", "\t1", " , 2"]), "indent-block-position"],
	["ブロックが == の左", std(["v :", "\t1", " == 2"]), "indent-block-position"],
	["本体のブロックが並びの項", std(["t : a ?", "\ta", "\tinc", " 5", "", "t 1 inc"]), "indent-block-position"],
	// 合成の最初の関数の本体の根が値でない。前は adder（§5 Q21）で見ていた。根が L の関数は G16 になった（R33）ので、根が未知の uu で見る。
	// `1 uu inc 5`（G2(a)：逆適用で uu が 1 を取って未知になり、後ろに 5 が来た）は、R47 で `1 (uu inc 5)` に決まり、通る側（norevPasses）へ移した。
	["uu inc 5 double（前は adder inc 5 double）", std(["uu : x ? [,] x", "uu inc 5 double"]), "G2(a)"],
	["uu inc 5 6（前は adder inc 5 6。G12(b) → G2(a)、R40）", std(["uu : x ? [,] x", "uu inc 5 6"]), "G2(a)"],
	// 器の中の器に関数が見える（構築を平らにするかは §5 Q12 で未決）。
	["[fs 1]~ 5", std("[fs 1]~ 5"), "G7"],
	["gs : fs 1 の後で gs~ 5", std(["gs : fs 1", "gs~ 5"]), "G7"],
	["[vs , fs]~ 5", std("[vs , fs]~ 5"), "G7"],
	["[k : inc]~ 5", std("[k : inc]~ 5"), "G7"],
	["構造体の欄に関数", std(["st :", "\tk : inc", "\tj : 2", "", "st~ 5"]), "G7"],
	// 関数の本体の外の括りでも、`:` の左の名前は局所の定義か欄か決まらない（§5 Q10）。
	["[sq : z ? z * z ⏎ sq 5]", std(["[sq : z ? z * z", "sq 5]"]), "G7"],
	["ブロックの中の sq : … ⏎ sq 5", std(["pp :", "\tsq : z ? z * z", "\tsq 5"]), "G7"],
	// 片側の欠けた `?` は `[?]` の点なし（§2 Q19）。名前を通しても関数にしない。
	["ff : [z ?] の後で ff 5", std(["ff : [z ?]", "ff 5"]), "G7"],
	["ff : [z ?] の後で 5 ff", std(["ff : [z ?]", "5 ff"]), "G7"],
	["ff : [? z] の後で ff 5", std(["ff : [? z]", "ff 5"]), "G7"],
	// 囲みの中が関数（§5 Q22）。
	["|inc| 5", std("|inc| 5"), "G7"],
	["-|inc| 5", std("-|inc| 5"), "G7"],
	["|vs~| 5（撒く項だけの囲み）", std("|vs~| 5"), "G7"],
	// 前の R15 の「`_` を含まない A の項」の行 `_ [_ 1]` は、値だけの並びの印が消える（2026-10-21）ので通る側（「印と穴」）へ移した。
];
for (const [name, src, want, kind, extra] of fixPasses) checkPass(`確かめ ${name}`, src, want, kind, extra);
for (const [name, src, want] of fixRefused) checkRefused(`確かめ ${name}`, src, want);

// 試験の穴：変異試験で壊しても落ちなかった所と、それを見分ける入力。
const gapPasses = [
	// R47：値の後ろの `?` の括りも積まれて余る（R42・R48）。前は逆適用で `(apply [x ? x + 1] 5 ·rev)`。
	["5 [x ? x + 1]（R47。前は逆適用）", std("5 [x ? x + 1]"), "(construct 5 (unit [x ? x + 1]))", "A"],
	// 貪欲な単項は excess にしない（§3.4）。並びを受けている間に来た inc は合成の後ろ（R41）。木は入れ子の適用（R47 で `·rev` の綴りが
	// 無くなった。前は `(apply inc (apply [* 2,] (construct 1 2 3)) ·rev)`）。
	["[* 2,] 1 2 3 inc", std("[* 2,] 1 2 3 inc"), "(apply inc (apply [* 2,] (construct 1 2 3)))", "A"],
	// 前は `double adder 5`（adder の根が L、§5 Q21）。根が L の関数は G16（R33）なので、根が未知の uu で見る。
	["double uu 5（未知の根）", std(["uu : x ? [,] x", "double uu 5"]), "(apply (compose double uu) 5)", "未知"],
	// 前は未知（§5 Q13）。R36 の流れで `add (inc 5)` の足りない適用（L）。
	["inc add 5（根に残った関数は `_`、R42。前は L の根、その前は未知）", std("inc add 5"), "(unit (apply (compose inc add) 5))", "A"],
	// §5 Q4 の答え（R36）で、足りない適用を含む合成も流れとして読む。前は G2(b)（下の gapRefused にあった）。
	["add inc 1 double 5（前は G2(b)）", std("add inc 1 double 5"), "(apply (compose (apply (compose add inc) 1) double) 5)", "A"],
	["pc : use 5 inc の後で pc double 3（前は G2(b)。use の本体の根が未知なので未知）", std(["pc : use 5 inc", "pc double 3"]), "(apply (compose pc double) 3)", "未知"],
	// 既定値の無い素の関数の内側の `_` は、k ≠ n でも `!_` と同じ（R38）。前は G5（下の gapRefused にあった）。
	["add _ 10 5（前は G5、R38）", std("add _ 10 5"), "(apply add (construct 5 10))", "A"],
	["R31 で変わった [+] inc 5（`[+] 5` は 5、前は未知の根）", std("[+] inc 5"), "(apply (compose [+] inc) 5)", "A"],
	["[,] inc 5（未知の根）", std("[,] inc 5"), "(apply (compose [,] inc) 5)", "未知"],
	["use 5 inc double（R8 で開く。根なので `_`、R42）", std("use 5 inc double"), "(unit (compose (apply use 5) inc double))", "A"],
	// `[f3 _ _ 3]` は口が2つの穴の関数で、1 2 で閉じて値になる。後ろの inc は積まれて余る（R47・R42・R48）。前は逆適用で
	// `(apply inc (apply [f3 _ _ 3] (construct 1 2)) ·rev)`。
	["[f3 _ _ 3] 1 2 inc（R47）", std("[f3 _ _ 3] 1 2 inc"), "(construct (apply [f3 _ _ 3] (construct 1 2)) (unit inc))", "A"],
	// 穴の生成名はソースの名前と衝突しない綴りにする。
	["p0 : 1 の後で add _ p0（根なので `_`、R42）", std(["p0 : 1", "add _ p0"]), "(unit (? [$p_0] (apply add (construct $p_0 p0))))", "A"],
	["[] 5", std("[] 5"), "(construct [] 5)", "A"],
	// R47：括りの値の後ろの inc は積まれて余る。前は逆適用で `(apply inc [1 ⏎ 2] ·rev)`。
	["[1 ⏎ 2] inc（R47）", std(["[1", "2] inc"]), "(construct [1 ⏎ 2] (unit inc))", "A"],
	["#ff : y ? y の後で ff 5", std(["#ff : y ? y", "ff 5"]), "(apply ff 5)", "A"],
	["ff : [y ? ff y]（輪にしない）", std(["ff : [y ? ff y]", "ff 5"]), "(apply ff 5)", "A"],
	["$!_ 5", std("$!_ 5"), "(construct $!_ 5)", "A"],
	// undefined-name は名前ごとに1回だけ出す。
	["say say", std("say say"), "(construct say say)", "A", { diag: "say", diagCount: 1 }],
];
const gapRefused = [
	// 足りない適用を含む合成が逆適用の右（`5 use 5 inc`）：前は G2(b)、2026-10-23 は G8（`5 use` の主語の口が決まらないまま 5 が来る）。
	// 逆適用の廃止（R47）で `5 (use 5 inc)` に決まり、通る側（norevPasses）へ移した。
	// `5 add1`・`5 add inc`・`double inc 5 6 inc` は、2026-10-23 から通る（R40・R42。2026-10-24 から R47 の答え）。下の「左からの畳み込み」の
	// 通る行へ移した。
	["g3 : f3 1 の後で g3 _ 3", std(["g3 : f3 1", "g3 _ 3"]), "G5"],
	["add _ inc", std("add _ inc"), "G5"],
	["add _ vs~", std("add _ vs~"), "G5"],
	["inc~", std("inc~"), "G7"],
	["[inc double]~", std("[inc double]~"), "G7"],
	["[+ inc] 5", std("[+ inc] 5"), "G7"],
	["[~_] 5", std("[~_] 5"), "G7"],
	["[inc == 2] 5", std("[inc == 2] 5"), "G7"],
	["本体の局所の定義 yy : inc ⏎ yy a", std(["t : a ?", "\tyy : inc", "\tyy a"]), "G7"],
	["本体の括りの局所の定義", std("h : a ? [yy : a] yy"), "G7"],
	["仮引数の重複", std("ff : x x ? x"), "name-duplicate"],
	["括りの中の取り込み", std(["[io@]", "say 5"]), "G7"],
	// 仮置きを取り消す仕組み：gq の根は fq の仮置き A の上で A と出るが、fq の根は gq から引いた物で未知なので、仮置きが外れて
	// gq も未知。外れた仮置きに頼った答え（A）が残ると `gq 1 inc` が通る。前の fq は `[+ [gq k]]`（仮置き A の上で区間 L）だったが、
	// 区間の綴りの本体は G16（R33、2026-10-22）なので、`(gq k) ' 0` にした（古いと印を付けないように変えると、どちらの行も通る）。
	["相互再帰：仮置きの取り消し", std(["fq : k ? (gq k) ' 0", "gq : k ? fq k", "gq 1 inc"]), "G2(a)"],
	["相互再帰：依っている答えを戻す", std(["fq : k ? ([gq k] * [hq k]) ' 0", "gq : k ? fq k", "hq : k ? gq k", "hq 1 inc"]), "G2(a)"],
	// 字下げの本体が A にならない形。
	["字下げの本体の最後が関数", std(["t : a ?", "\ta", "\tinc", "", "t 1 inc"]), "G2(a)"],
	["字下げの本体の局所の定義", std(["t : a ?", "\tyy : 5", "\ta", "", "t 1 inc"]), "G2(a)"],
	["-_ 5", std("-_ 5"), "G7"],
	["#z 5", std("#z 5"), "G7"],
	["say@ 5", std("say@ 5"), "G7"],
	["本体 [@h] 5", std("t : h ? [@h] 5"), "G7"],
	["a ' b @ c", std("a ' b @ c"), "infix-mixed-assoc"],
	["5 +", std("5 +"), "infix-missing-operand"],
	["1 === 1", std("1 === 1"), "operator-removed"],
	// 本体の根を先に解くとき（§6.4 の1）は門で止めず、行を解くときに行の順に断る。本体は段4〜8 の中置の被演算子の `!_`（G7、§5 Q15）。
	// 前の本体 `!_` だけは、2026-10-21 に恒等射で通るようになった。前の1行目 `1 2 inc`（G1）は R37 で通るようになったので、G12(a) の
	// `inc 1 2 inc` にした。その `inc 1 2 inc` も 2026-10-23 に通るようになった（R40）ので、G8 の `5 f2 1` にした。前の本体の頭の `!_`
	// （`!_ 5`、G7）は、同じ日に恒等射で通るようになった（R44）ので、`!_ == 5` にした。`5 f2 1` も 2026-10-24 に通るようになった（R47、
	// G8 の廃止）ので、1行目を G2(a) の `use $inc 5 3` にした。
	["門は行の順に断る", std(["use $inc 5 3", "tt : a ? !_ == 5"]), "G2(a)"],
];
for (const [name, src, want, kind, extra] of gapPasses) checkPass(`穴 ${name}`, src, want, kind, extra);
for (const [name, src, want] of gapRefused) checkRefused(`穴 ${name}`, src, want);

// ---------------------------------------------------------------------------
// 穴は `!_`、書いた `_` はいつも印（利用者 2026-10-21、§3.5・R16・R27、G13〜G15）
// ---------------------------------------------------------------------------
//
// 利用者 2026-10-21 03:19「この表で仕様と実装を書き直して。未決の3つ（go !_ xs、点なしの前置・後置の綴り、既定値のある関数の
// 種類）は名指しで断っておいて。」の表の行と、その3つの門（G13 `go !_ xs`・G14 点なしの前置・後置・G15 既定値のある関数の `_`）。
// G14 は同じ日に廃止した（下の「前置・後置の点なし」）。`go !_ xs` は §5 Q31 の答え（2026-10-21 22:51・22:55、R34）で通り、G13 は
// 撒く項と前から n 個の外の `!_` だけに狭まった（下の「穴と実引数の数」）。
// 書いた `_` は穴にならない（U 10-21 03:06、U〔答え〕03:11）。既定値の無い素の関数の `f _ 3` は今までどおりカリー化（U 10-21 03:14）。
// 並びの最後の `_` は「ここで終わる」：足りなければ印、飽和なら評価（U〔答え〕10-14 03:14）。括りの関数の実引数の `_` は消える
// （U〔答え〕10-14 22:23）。`||f||` は合成（U〔答え〕10-21 03:01）。

const S3 = "s3 : [p] [q] [r] ? p"; // 括りの仮引数が3つ（`(s 1 _ 3) 2` は `(s 1 3) 2`）
const IO1 = "io1 : [say] ? say 21";
const PB = "pb : [a] [b] ? a";
const unitPasses = [
	// 書いた形（既定値の無い素の関数）：カリー化 `a ? f a 3`（R16 の木のまま）。行の根に残った穴の関数は `_`（R42。木は `(unit …)` で包む。
	// 下の穴の行も同じ）。
	["f3 _ 2 3（カリー化。根なので `_`、R42）", std("f3 _ 2 3"), "(unit (? [$p0] (apply f3 (construct $p0 2 3))))", "A"],
	// 穴 `!_`：位置どおりに仮引数。最後の項でもよい（η）
	["f3 !_ 2 3（穴。R42）", std("f3 !_ 2 3"), "(unit (? [$p0] (apply f3 (construct $p0 2 3))))", "A"],
	["add 1 !_（穴、η で add 1。R42）", std("add 1 !_"), "(unit (? [$p0] (apply add (construct 1 $p0))))", "A"],
	["inc !_（穴、η で inc。R42）", std("inc !_"), "(unit (? [$p0] (apply inc $p0)))", "A"],
	["f4 _ 2 !_ 3（印の穴と !_ が混ざる。R42）", std("f4 _ 2 !_ 3"), "(unit (? [$p0 $p1] (apply f4 (construct $p0 2 $p1 3))))", "A"],
	["[add 1 !_] 5", std("[add 1 !_] 5"), "(apply [add 1 !_] 5)", "A"],
	["go !_ 3（既定値があっても穴。R42）", std([...GO_DEFAULT, "go !_ 3"]), "(unit (? [$p0] (apply go (construct $p0 3))))", "A"],
	// 末尾の `_`：ここで終わり。足りなければ印（足りない適用にしない）、飽和なら評価
	["add 3 _（足りなければ印）", std("add 3 _"), "(apply add (construct 3 _))", "A", { leftover: false }],
	// 括りは印で、関数ではない（値）。後ろの inc は積まれて余る（R47・R42・R48）。前は逆適用で `(apply inc [add 3 _] ·rev)`。
	["(add 3 _) inc（括りは印で、関数ではない。R47）", std("(add 3 _) inc"), "(construct [add 3 _] (unit inc))", "A"],
	// 飽和なら評価：左からの畳み込み（R40・R43）では `add 2 3` で口が埋まって値になり、後ろの `_` は値の隣の並びの単位として消える（R15）。
	// 前は R28 の k' = n で `_` を木に残した（`(apply add (construct 2 3 _))`）。値は同じ 5。
	["add 2 3 _（飽和なら評価。`_` は消える、R43）", std("add 2 3 _"), "(apply add (construct 2 3))", "A", { leftover: false }],
	// k' > n は、最後の `_` を除いた `d 1 2` と同じ（R28）で、余りを後ろに積む（R35）。構築の中の `_` は手順8で消えるので、木に書かない。
	["d 1 2 _（k' > n は余りを後ろに積む）", std("d 1 2 _"), "(construct (apply d 1) 2)", "A", { leftover: true }],
	["[+ 1] _", std("[+ 1] _"), "(apply [+ 1] _)", "A"],
	["(add 3 _) 5（括りの中で終わる）", std("(add 3 _) 5"), "(construct [add 3 _] 5)", "A"],
	// `5 add 3 _` は、2026-10-23 は add が 5 を逆適用で取り、口が決まらない（§5 Q5）まま 3 が来るので G8（R40）だった。逆適用の廃止（R47）で
	// `5 (add 3 _)` に決まり、通る側（norevPasses）へ移した。
	// 印が単位として消える
	["[1 _ 3]", std("[1 _ 3]"), "[1 _ 3]", "A"],
	["_ + 1", std("_ + 1"), "(+ _ 1)", "A"],
	["1 * _", std("1 * _"), "(* 1 _)", "A"],
	["_ [_ 1]（前は G5）", std("_ [_ 1]"), "[_ 1]", "A"],
	["_ $!_（前は G5）", std("_ $!_"), "$!_", "A"],
	["[_ +] 5（点なしの被演算子の印も A、前は G5）", std("[_ +] 5"), "(apply [_ +] 5)", "A"],
	["_（印は値）", std("_"), "_", "A"],
	["xu : _ の後で inc xu", std(["xu : _", "inc xu"]), "(apply inc xu)", "A"],
	// ノルムの囲み（R27）
	["||_||", std("||_||"), "||_||", "A"],
	["||$_||", std("||$_||"), "||$_||", "A"],
	["||$!_||", std("||$!_||"), "||$!_||", "A"],
	["||!_||（ノルムの口の穴。根なので `_`、R42）", std("||!_||"), "(unit ||!_||)", "A"],
	["||!_|| 1 2 3（並び全体を受けて数える）", std("||!_|| 1 2 3"), "(apply ||!_|| (construct 1 2 3))", "A"],
	["||inc||（合成。根なので `_`、R42）", std("||inc||"), "(unit ||inc||)", "A"],
	["||inc|| 3", std("||inc|| 3"), "(apply ||inc|| 3)", "A"],
	["||add 1|| 2（足りない適用の残りを待つ）", std("||add 1|| 2"), "(apply ||add 1|| 2)", "A"],
	["double ||inc|| 3（合成の中の合成）", std("double ||inc|| 3"), "(apply (compose double ||inc||) 3)", "A"],
	// `$!_`・`$_` は値
	["$_ 5", std("$_ 5"), "(construct $_ 5)", "A"],
	// `!_` 1つ：穴だけ＝恒等射（並び全体を受ける）。恒等射は括らずに書く（U 10-21 08:24「恒等射なら括らなくていい。」）。括った
	// `[!_]` は否定の点なし（下の「前置・後置の点なし」）。前は `[!_]` を恒等射と読み、`[!_] 5`・`[!_] 1 2 3` をここで試していた。
	["!_ 1つ（恒等射。行の根なので `_`、R42）", std("!_"), "(unit !_)", "A"],
	["x2 : !_（前は G7）", std("x2 : !_"), "(: x2 !_)", null],
	["x2 : !_ の後で x2 5", std(["x2 : !_", "x2 5"]), "(apply x2 5)", "A"],
	["i : !_ の後で i 5", std(["i : !_", "i 5"]), "(apply i 5)", "A"],
	["i : !_ の後で i 1 2 3（並び全体を受ける。excess にしない）", std(["i : !_", "i 1 2 3"]), "(apply i (construct 1 2 3))", "A", { leftover: false }],
	["i : !_ の後で i _（終わり、R28）", std(["i : !_", "i _"]), "(apply i _)", "A"],
	// 並び全体を受けた結果（A）の後ろの逆適用 `i 1 2 inc` は、2026-10-22 の確かめから G12(a)（下の unitRefused）。前はここで
	// `(apply inc (apply i (construct 1 2)) ·rev)` と通していた。
	// 本体が `!_` だけの関数（`tt : a ? !_`）も行は恒等射（L）と読むが、本体の根が裸の関数なので G16（R33、下の unitRefused）。前は
	// ここで通っていた（その前は G7）。
	// 行が `!_` だけなら、2行以上の括りの中の行・構造体の欄でも恒等射（R29 の R の所）。中置の被演算子の `!_` は下の G7。
	["[!_ ⏎ 1]（前は G7）", std(["[!_", "1]"]), "[!_ ⏎ 1]", "A"],
	["構造体の欄 a : !_ を引く（引いた恒等射は L。行の根なので `_`、R42）", std(["st :", "\ta : !_", "", "st ' a"]), "(unit (' st a))", "A"],
	// 括りの関数の実引数の `_` は、括りが受ける並びの中の印で、消える。最後の `_` は、`_` を除いた実引数がアリティ以上の
	// ときだけ消す（足りなければ終わりの読みと割れて G5、下の unitRefused）
	["(s3 1 _ 3) 2", std([S3, "(s3 1 _ 3) 2"]), "(apply [s3 1 _ 3] 2)", "A"],
	["s3 1 2 3 _（_ を除いてアリティどおりなら消える）", std([S3, "s3 1 2 3 _"]), "(apply s3 (construct 1 2 3))", "A"],
	["(s3 1 _ 3) 2 の実体は (s3 1 3) 2 と同じ", std([S3, "(s3 1 _ 3) 2"]), "(: s3 (? [[p] [q] [r]] (inst N N N p)))", null, { at: -2 }],
	["(s3 1 3) 2 の実体", std([S3, "(s3 1 3) 2"]), "(: s3 (? [[p] [q] [r]] (inst N N N p)))", null, { at: -2 }],
	// 既定値のある口（go の zs）に書いた `_` は、既定値という値（R39、U〔答え〕10-21 23:42）。木では実引数のまま残し、種類は `go 1 3` と
	// 同じ（既定値のある関数の適用は未知）。前は G15（下の unitRefused にあった）。
	["go 1 _（既定値のある口の _、前は G15）", std([...GO_DEFAULT, "go 1 _"]), "(apply go (construct 1 _))", "未知"],
	// 足りない適用を含む合成を囲んだノルムも、括りの `[use 5 inc] 3` と同じく流れで読む（R36）。use の本体の根が未知なので未知。前は G2(b)。
	["||use 5 inc|| 3（前は G2(b)）", std("||use 5 inc|| 3"), "(apply ||use 5 inc|| 3)", "未知"],
];
const unitRefused = [
	// 本体が `!_` だけ：行は恒等射（L、R29）なので、本体の根が裸の関数（G16、R33）。前は `!_` の L で通っていた。
	["本体が !_ だけ（前は通る）", std("tt : a ? !_"), "G16"],
	// G15：既定値のある関数の実引数に書いた `_` が、既定値の無い口（go の ys）に当たる（R39 の残り、§5 Q8）。既定値のある口に当たる
	// `go 1 _` は、2026-10-22 から通る（上の unitPasses）。
	["G15 go _ 3", std([...GO_DEFAULT, "go _ 3"]), "G15"],
	// 逆適用の廃止（R47）で、5 の後ろの go は積まれて口が全部開いている。`_` は go の最初の口（ys、既定値の無い口）に当たるので、`go _ 3` と
	// 同じ G15。2026-10-23 は、go が 5 を逆適用で取り、口が決まらない（§5 Q5）まま `_` が来て G8、その前は G15。
	["G15 頭でない go の _（5 go _ 3。G8 → G15、R47）", std([...GO_DEFAULT, "5 go _ 3"]), "G15"],
	// 合成は左から実行する（R11）。積まれた go に inc を合成し、`_` は go の最初の口（ys）に当たるので G15（2026-10-23 は G8、その前は G15）。
	["G15 5 go inc _（G8 → G15、R47）", std([...GO_DEFAULT, "5 go inc _"]), "G15"],
	// 前の G13 の行（`inc !_ 5`・`add !_ 1 2`・既定値のある go の `go !_ 3 4`・`go !_`）は、§5 Q31 の答え（R34）で通る側（下の
	// 「穴と実引数の数」）へ移した。
	// 字下げの仮引数のブロックの1行に名前が2つあると、仮引数の数が数えられないので穴にしない（前は行の数 2 を n にして、
	// 仮引数3つの関数の `gz !_ 3` を黙って穴にした）。
	["G7 gz !_ 3（仮引数のブロックの行 a b）", std(["gz :", "\t\ta b", "\t\tc : 3", "\t? a", "", "gz !_ 3"]), "G7"],
	// G14（`[-_] 5`・`[_!] 5`・`[!!_] 5`・`[-_]`）は廃止して、下の「前置・後置の点なし」で通る。
	// G5：書いた `_` の読みが決まらない位置
	["G5 f3 _ 2 _（内側の _ と終わりの _）", std("f3 _ 2 _"), "G5"],
	["G5 add _ inc（終わりの後ろに関数）", std("add _ inc"), "G5"],
	// `inc 5 _ inc`・`_ inc`・`5 _ inc`・`1 2 _ inc` は、2026-10-23 から通る：畳み込みは並びの単位から始まり、値の隣と空の並びの `_` は
	// その場で消える（R15・R43）ので、逆適用の主語にならない（決定から外れた所。§7.18）。下の「左からの畳み込み」の通る行へ移した。
	// 2026-10-24 の R47 からは、後ろの inc は値の後ろに積まれて余る。
	// 恒等射が2項以上の並び全体を受けて、後ろに関数が続く（左からの畳み込みでは、開いた恒等射の後ろに inc が合成される）。結果全体を
	// 1つの値で渡す読み（R29）と、単位律で `i 1 2` を `1 2` と同じに見る読み（2026-10-23 は逆適用で `1 (inc 2)`、2026-10-24 の R47 からは
	// inc が積まれて `1 2` の後ろに余る）で割れる（G18。前は G12(a)）。
	["G18 i 1 2 inc（恒等射の並びの後ろに関数。G12(a) → G18）", std(["i : !_", "i 1 2 inc"]), "G18"],
	// 前の `G5 [+] 1 _（貪欲な頭の終わり）` は、R31 で `_` が被演算子の印（`1 + _`）になって通る側（下の「畳む2項の点なし」）へ移した。
	["G5 [* 2,] 1 _（貪欲な単項の頭の終わり）", std("[* 2,] 1 _"), "G5"],
	["G5 inc inc _（合成の頭の終わり）", std("inc inc _"), "G5"],
	["G5 io1 !_（括りの関数に穴）", std([IO1, "io1 !_"]), "G5"],
	// 括りの関数の実引数の最後の `_` で、`_` を除いた実引数がアリティに足りない：終わり（R28）と消える印（U〔答え〕10-14 22:23）で
	// 種類が割れる（前は消えて、`io1 _` は io1、`(io1 _) 5` は io1 を 5 で呼び、`io1 _ inc` は黙って合成になった）。
	["G5 io1 _（括りの関数の末尾の _）", std([IO1, "io1 _"]), "G5"],
	["G5 (io1 _) 5", std([IO1, "(io1 _) 5"]), "G5"],
	["G5 io1 _ inc（消えた後に合成）", std([IO1, "io1 _ inc"]), "G5"],
	["G5 pb 1 _ inc", std([PB, "pb 1 _ inc"]), "G5"],
	["G5 pb 1 _", std([PB, "pb 1 _"]), "G5"],
	// 残りの仮引数に裸の物がある括りの関数：`_` を消して詰めると、後ろの実引数が裸の口へずれる（3 が a に入る）。カリー化
	// （U 10-21 03:14）とも読めるので断る。前（2026-10-21 の直しの途中）は消して `mx 3` と読んでいた。
	["G5 mx _ 3（裸と括りの混ざった関数）", std(["mx : a [b] ? a", "mx _ 3"]), "G5"],
	// `mx 1 _ 3` は、`_` が残りの括りの口 [b] に当たる（裸の口は 1 で埋まった）ので消える（R15・R43）。下の「左からの畳み込み」へ移した。
	["G5 (mx 1) _ 3（部分適用でも、残りの口だけを見る）", std(["mx3 : [a] b [c] ? a", "(mx3 1) _ 3"]), "G5"],
	// G7：`!_` の位置の外。口の外の `!_ 5`・`5 !_`（G7）は恒等射（R44）、`,` の被演算子の `!_ , 1`（G7）は積の単位（R45）、
	// `inc !_ inc`（G7）は口が1つだけ残った inc の口（R46）で、2026-10-23 に通る側（下の「口の外の恒等射」の idPasses）へ移した。
	// 段4〜8 の中置の被演算子の `!_` 1つ（§3.5 の決定の「中置の被演算子」。行が `!_` だけではない）は G7 のまま（§5 Q15）。
	["G7 !_ == 1", std("!_ == 1"), "G7"],
	["G7 1 & !_", std("1 & !_"), "G7"],
	["G7 |!_| 5（絶対値の囲みに関数）", std("|!_| 5"), "G7"],
	["G7 |inc| 5", std("|inc| 5"), "G7"],
	// 既定値のある関数と、ほかのアリティの分からない関数は、実体の鍵を分ける（fnKey）。前は鍵が `other` 1つで、括りの関数に
	// 欄で渡すと実体を分け合い、先に解いた方の門が言い分になった：gx の行（G5 のはず）が、後ろの go の行の G15 で断られた。
	["鍵 ap [f : gx] の行は、後ろの ap [f : go] に依らず G5", std(["gx : a ~y ? a", ...GO_DEFAULT, "ap : [f] ? f _ 3", "w : y ? ap [f : gx]", "w2 : ap [f : go]"]), "G5"],
	["鍵 ap [f : go] の行は G15", std(["gx : a ~y ? a", ...GO_DEFAULT, "ap : [f] ? f _ 3", "w2 : ap [f : go]", "w : y ? ap [f : gx]"]), "G15"],
];
for (const [name, src, want, kind, extra] of unitPasses) checkPass(`印と穴 ${name}`, src, want, kind, extra);
for (const [name, src, want] of unitRefused) checkRefused(`印と穴 ${name}`, src, want);

// ---------------------------------------------------------------------------
// 穴と実引数の数が合わないとき（§5 Q31 の答え、2026-10-21 22:51・22:55、R34）
// ---------------------------------------------------------------------------
//
// k > n：余った実引数が前から穴に入る（主の Claude の問いの (B)「`go !_` は穴で `a ? go a`、後ろの xs がその穴を埋めて `go xs`。
// `f !_ 3 4`（f は2引数）は `(a ? f a 3) 4` で `f 4 3`。括った `[f !_ 3] 4` と同じ答え」に、利用者 2026-10-21 22:51「合ってる。Bだね」）。
// 穴より残りが多ければ、埋めた適用の余り（素の関数の余り）。穴が残れば、残った穴を待つ関数。木は埋めた所を値に替えた形。
// k < n：書いていない後ろの口を、最後の括りの仮引数で受けて撒く関数（利用者 2026-10-21 22:55「`a [~c] ? f3 a 2 c~` / という、
// 足りない分は全部後ろへっていう変換がかかる。」）。最後の括りが残りの並び全体を受ける（R24）。
// 前は k ≠ n の全部を G13 で断っていた。G13 に残るのは、撒く項がある並びと、前から n 個の外に `!_` がある並びと、k < n で作った
// 関数の最後の括りに、数と分からない実引数がちょうど1つで入る適用（R24 では括りがその List を受けて撒き、位置どおりに数えれば
// 口を1つ埋める。直す人の読み、断る側）。書いた `_` の混ざった k ≠ n は今のまま G7。同じ射の綴りどうしの比べは
// coproduct_laws.test.js の法則6。
const holeCountPasses = [
	// k > n
	["inc !_ 5（前は G13）", std("inc !_ 5"), "(apply inc 5)", "A"],
	["add !_ 1 2（`add 2 1`、前は G13）", std("add !_ 1 2"), "(apply add (construct 2 1))", "A"],
	["f2 !_ 3 4（`f2 4 3`）", std("f2 !_ 3 4"), "(apply f2 (construct 4 3))", "A"],
	["[f2 !_ 3] 4（括っても同じ答え）", std("[f2 !_ 3] 4"), "(apply [f2 !_ 3] 4)", "A"],
	["f3 !_ 2 3 4 5（埋めた後の余りは f3 の余りで、後ろに積む、R35）", std("f3 !_ 2 3 4 5"), "(construct (apply f3 (construct 4 2 3)) 5)", "A", { leftover: true }],
	// 行の根に残った穴の関数は `_`（R42。木は `(unit …)` で包む。下の L の行も同じ）。
	["f3 !_ !_ 5 6（穴が残る。R42）", std("f3 !_ !_ 5 6"), "(unit (? [$p0] (apply f3 (construct 6 $p0 5))))", "A"],
	["f4 !_ 2 !_ 3 9（前の穴から埋める。R42）", std("f4 !_ 2 !_ 3 9"), "(unit (? [$p0] (apply f4 (construct 9 2 $p0 3))))", "A"],
	["f3 !_ !_ 5 6 7（穴を全部埋める）", std("f3 !_ !_ 5 6 7"), "(apply f3 (construct 6 7 5))", "A", { leftover: false }],
	["use !_ 5 3（埋めた適用は本体の根が未知）", std("use !_ 5 3"), "(apply use (construct 3 5))", "未知"],
	["go !_ 3 4（既定値のある go、n = 2。前は G13）", std([...GO_DEFAULT, "go !_ 3 4"]), "(apply go (construct 4 3))", "未知"],
	["本体 t : y ? inc !_ y", std("t : y ? inc !_ y"), "(apply inc y)", "A", { body: true }],
	// 値の括りの後ろの inc は積まれて余る（R47・R42・R48）。前は逆適用で `(apply inc [add !_ 1 2] ·rev)`。
	["(add !_ 1 2) inc（値の括り。R47）", std("(add !_ 1 2) inc"), "(construct [add !_ 1 2] (unit inc))", "A"],
	// k < n
	["f3 !_ 2（`a [~c] ? f3 a 2 c~`。R42）", std("f3 !_ 2"), "(unit (? [$p0 [~$p1]] (apply f3 (construct $p0 2 $p1~))))", "A"],
	["add !_（η で add。前は G13。R42）", std("add !_"), "(unit (? [$p0 [~$p1]] (apply add (construct $p0 $p1~))))", "A"],
	["f4 !_ !_（穴2つと残りの括り。R42）", std("f4 !_ !_"), "(unit (? [$p0 $p1 [~$p2]] (apply f4 (construct $p0 $p1 $p2~))))", "A"],
	["f4 2 !_（穴が後ろでも、残りの口は最後の括り。R42）", std("f4 2 !_"), "(unit (? [$p0 [~$p1]] (apply f4 (construct 2 $p0 $p1~))))", "A"],
	["(f3 !_ 2) 1 3（`f3 1 2 3`）", std("(f3 !_ 2) 1 3"), "(apply [f3 !_ 2] (construct 1 3))", "A", { leftover: false }],
	// 最後の括りは1つも受けていないので閉じず、L のまま（R41）。行の根なので `_`（R42）。
	["(f3 !_ 2) 1（足りない適用。R41・R42）", std("(f3 !_ 2) 1"), "(unit (apply [f3 !_ 2] 1))", "A"],
	["((f3 !_ 2) 1) 3", std("((f3 !_ 2) 1) 3"), "(apply [[f3 !_ 2] 1] 3)", "A"],
	// 最後の括りの仮引数 `[~c]` が残りの並び全体を受ける（R24。可変長の口、R41）ので、この関数の所では木を切らない（f3 の余りとして、
	// 関数の本体の中で f3 の後ろに積まれる。restCloseKind）。2026-10-23 から節の印 leftover は無く、根は1つの適用（leftover の形でない）。
	["(f3 !_ 2) 1 3 4（f3 の余り。最後の括りが受けるので、木は切らない。R41）", std("(f3 !_ 2) 1 3 4"), "(apply [f3 !_ 2] (construct 1 3 4))", "A", { leftover: false }],
	["(add !_) 1 2（add 1 2）", std("(add !_) 1 2"), "(apply [add !_] (construct 1 2))", "A"],
	// 最後の括り `[~c]` が受けている間に来た inc は合成の後ろ（R41）。木は入れ子の適用（R47 で `·rev` の綴りが無くなった。前は
	// `(apply inc (apply [f3 !_ 2] (construct 1 3)) ·rev)` で、名前は「逆適用の左」）。
	["(f3 !_ 2) 1 3 inc（最後の括りが受けている間の合成）", std("(f3 !_ 2) 1 3 inc"), "(apply inc (apply [f3 !_ 2] (construct 1 3)))", "A"],
	// `(f3 !_ 2) vs~`（前は「撒く項は数えない」で未知の根）は、2026-10-24 の試し（R51）で、固定の口の後ろに可変長の口 `[~c]` があって流れを
	// 受ける口の数が決まらない G19。下の holeCountRefused へ移した。
	// 最後の括りに入る物が数1つ（`[x]≅x`、R24）か2つ以上なら、括りが受けて撒いても、位置どおりに数えても同じ答え。最後の括りに
	// 入り始めた後（`(f3 !_) 1 5` の後）は、位置どおりに f3 の口へ並ぶ。
	["(f3 !_ 2) 1 [3]（数を括った物は数）", std("(f3 !_ 2) 1 [3]"), "(apply [f3 !_ 2] (construct 1 [3]))", "A"],
	["(f3 !_) 1 vs 3（最後の括りに2つ）", std("(f3 !_) 1 vs 3"), "(apply [f3 !_] (construct 1 vs 3))", "A"],
	["((f3 !_) 1 5) vs（最後の括りに入り始めた後）", std("((f3 !_) 1 5) vs"), "(apply [[f3 !_] 1 5] vs)", "A"],
	["鍵 h [f : [f4 !_ 2]]（f 1 2 vs は最後の括りに2つ）", std(["h : [f] ? f 1 2 vs", "h [f : [f4 !_ 2]]"]), "(apply h [f : [f4 !_ 2]])", "A"],
	["go !_（既定値のある go、n = 2。前は G13。R42）", std([...GO_DEFAULT, "go !_"]), "(unit (? [$p0 [~$p1]] (apply go (construct $p0 $p1~))))", "A"],
	["(go !_) 1（既定値のある関数の適用は未知）", std([...GO_DEFAULT, "(go !_) 1"]), "(apply [go !_] 1)", "未知"],
	// 書いた `_` を当てない関数なら、実体の鍵は同じアリティの穴の関数と分けても答えは同じ。
	["鍵 h [f : [f3 !_ !_ 3]]（k = n の穴の関数に終わりの `_`）", std(["h : [f] ? f 1 _", "h [f : [f3 !_ !_ 3]]"]), "(apply h [f : [f3 !_ !_ 3]])", "A"],
	// 既定値の無い素の関数の内側の `_` は、k ≠ n でも `!_` と同じ（R38）なので、`_` と `!_` を混ぜてよい。前は G7（下の holeCountRefused にあった）。
	["add !_ _ 3（`_` と `!_` を混ぜた k > n、R38。前は G7。R42）", std("add !_ _ 3"), "(unit (? [$p0] (apply add (construct 3 $p0))))", "A"],
	// R34 の k < n の G13（最後の括りに1つで入る数でない値）は 2026-10-23 に無くなった：1つで入った物は [x] ≅ x で中身の並び（規則の文面、
	// `(f3 !_) 1 [1 2]` は `f3 1 1 2`）。数えられる器なら元の関数の口を埋め、数えられない物（中身の見えない A・番地）なら未知（R41、restCloseKind）。
	["(f3 !_) 1 vs（vs を撒いて `f3 1 1 2 3`、R41。前は G13）", std("(f3 !_) 1 vs"), "(apply [f3 !_] (construct 1 vs))", "A"],
	["(f3 !_) 1 [1 2]（`f3 1 1 2`、規則の文面。前は G13）", std("(f3 !_) 1 [1 2]"), "(apply [f3 !_] (construct 1 [1 2]))", "A"],
	["(f3 !_ 2) 1 vs（f3 の余り、R41。前は G13）", std("(f3 !_ 2) 1 vs"), "(apply [f3 !_ 2] (construct 1 vs))", "A"],
	["(add !_) 1 vs（R41。前は G13）", std("(add !_) 1 vs"), "(apply [add !_] (construct 1 vs))", "A"],
	["((f3 !_ 2) 1) vs（部分適用の後でも、R41。前は G13）", std("((f3 !_ 2) 1) vs"), "(apply [[f3 !_ 2] 1] vs)", "A"],
	["本体 k : y ? (f3 !_ 2) 1 y（中身の見えない A は数えられないので未知、R41。前は G13）", std("k : y ? (f3 !_ 2) 1 y"), "(apply [f3 !_ 2] (construct 1 y))", "未知", { body: true }],
	["(f3 !_ 2) 1 $inc（番地は数えられないので未知、R41。前は G13）", std("(f3 !_ 2) 1 $inc"), "(apply [f3 !_ 2] (construct 1 $inc))", "未知"],
	["p : (f3 !_ 2) 1 の後の inc p 5（流れてきた値は中身が見えないので未知、R41。前は G13）", std(["p : (f3 !_ 2) 1", "inc p 5"]), "(apply (compose inc p) 5)", "未知"],
	// 実体の鍵は、最後の括りの前に残る裸の口の数（fnKey の restAt）でも分ける。分けないと、先に解いた `[f4 !_ 2]` の実体（A：最後の括りに
	// 2 と y の2つ）を、`[f4 !_ !_ 2]` の行（最後の括りに中身の見えない y が1つで入るので未知）が黙って使う。2026-10-23 に G13 の行から
	// この形へ替えた（G13 が無くなったので、未知と A の違いで見る）。
	["鍵 w : h [f : [f4 !_ 2]] $inc の後の h [f : [f4 !_ !_ 2]] $inc（R41）", std(["h : [f] y ? f 1 2 y", "w : h [f : [f4 !_ 2]] $inc", "h [f : [f4 !_ !_ 2]] $inc"]), "(apply h (construct [f : [f4 !_ !_ 2]] $inc))", "未知"],
];
const holeCountRefused = [
	// 種類の未知な、埋めた適用の後ろに項が来る（R40 の読み6。G12(b) → G2(a)、G12 は廃止）。
	["use !_ 5 3 4（埋めた後の余りで、本体の根が未知。G2(a)）", std("use !_ 5 3 4"), "G2(a)"],
	["[use !_] $inc 5 3（同じ。G2(a)）", std("[use !_] $inc 5 3"), "G2(a)"],
	["本体の根が穴の関数 q : x ? add !_", std("q : x ? add !_"), "G16"],
	// R34 の k < n で作った関数に書いた `_`：括りが受ける並びの中の消える印か、最後の括りに入る値かで割れる（G5、markApply）。
	["(f3 !_ 2) 1 _", std("(f3 !_ 2) 1 _"), "G5"],
	["(f3 !_ 2) _", std("(f3 !_ 2) _"), "G5"],
	["((f3 !_ 2) 1) _（部分適用も同じ）", std("((f3 !_ 2) 1) _"), "G5"],
	// 2026-10-24 の試し（R51）：撒いた流れを受ける口が、固定の口1つの後ろに可変長の口 `[~c]`（流れを口 a に入れるか、`[~c]` が丸ごと受けるか
	// 決まらない）。前は撒く項で k を数えないので未知の根で通っていた。
	["(f3 !_ 2) vs~（R51 の G19、試し。前は未知の根）", std("(f3 !_ 2) vs~"), "G19"],
	// 実体の鍵は、同じアリティの穴の関数と分ける（fnKey の "+rest"）。分けないと、先に解いた `[f3 !_ !_ 3]` の実体（A）を
	// `[f3 !_ 2]` の行が黙って使う。
	["鍵 w : h [f : [f3 !_ !_ 3]] の後の h [f : [f3 !_ 2]]", std(["h : [f] ? f 1 _", "w : h [f : [f3 !_ !_ 3]]", "h [f : [f3 !_ 2]]"]), "G5"],
	// G13 に残る形：撒く項（k が数えられない）と、前から n 個の外の `!_`
	["G13 f3 !_ vs~（撒く項、k < n）", std("f3 !_ vs~"), "G13"],
	["G13 inc 5 !_（前から 1 個の外の !_）", std("inc 5 !_"), "G13"],
	["G13 add !_ 1 !_（前から 2 個の外の !_）", std("add !_ 1 !_"), "G13"],
	// R34 の k < n の G13（最後の括りに1つで入る数でない値）は 2026-10-23 に無くなり、上の holeCountPasses へ移した（R41）。
	// `(f4 !_) 7 xs` は、xs（`1 , 2`）を撒いて `f4 7 1 2` の足りない適用（L）なので、本体の根が裸の関数で G16（R33。前は G13）。
	["G16 q : x ? (f4 !_) 7 xs（撒いて足りない適用、R41。G13 → G16）", std(["xs : 1 , 2", "q : x ? (f4 !_) 7 xs"]), "G16"],
	// 実体の鍵の行（`[f4 !_ 2]` と `[f4 !_ !_ 2]`）は、G13 が無くなったので上の holeCountPasses へ移した。
	// 今のまま：最後の項が `_` の k ≠ n（最後の `_` は終わり、R28）・k = n の撒く項・括りの関数の頭・n の数えられない頭は G7 か G5。
	// 内側の `_` の混ざった `add !_ _ 3` は、R38 で通る側（上の holeCountPasses）へ移した。
	["G7 f3 !_ _（最後の項が _ の k < n）", std("f3 !_ _"), "G7"],
	["G7 add !_ vs~（k = n の撒く項）", std("add !_ vs~"), "G7"],
	["G5 io1 !_ 5（括りの関数の頭）", std([IO1, "io1 !_ 5"]), "G5"],
	["G7 gz !_（n の数えられない既定値のある関数）", std(["gz :", "\t\ta b", "\t\tc : 3", "\t? a", "", "gz !_"]), "G7"],
];
for (const [name, src, want, kind, extra] of holeCountPasses) checkPass(`穴と実引数の数 ${name}`, src, want, kind, extra);
for (const [name, src, want] of holeCountRefused) checkRefused(`穴と実引数の数 ${name}`, src, want);

// ---------------------------------------------------------------------------
// 前置・後置の点なしは `_` の綴り（2026-10-21 08:20、R30 と G14 を廃止）
// ---------------------------------------------------------------------------
//
// 前置・後置の点なしは、括りの中が1行で、その行が項1つで、項が値の前置の印1つ（`-`・`!`・`!!`）か後置の `!` 1つと、書いた `_`
// だけの物（`[-_]`・`[!_]`・`[!!_]`・`[_!]`）。種類は単項の点なし（L）。同じ日に、`_` を被演算子の印に使う綴りを G14 で断り、
// 未定義の名前を被演算子に書く R30（`[-a]`）にしたが、主の Claude の3つの道の2つ目（前の `_` の綴りに戻して R30 を外す）への
// U〔答え〕2026-10-21 08:20「これがよさそうだね。 / その方が統一的に扱えると思う。」で戻した。括った `[!_]` は恒等射ではなく
// 否定の点なし（U 08:24「[!_] は否定の点無しにしないの？ 恒等射なら括らなくていい。」、残す理由は U 08:26）。恒等射は括らない
// `!_`（上の「印と穴」）。`[-a]` は R30 の前と同じく、値の印を当てた項の括り（a が未定義なら A で、information は R21 の文面）。
const VALUE_TEXT = "値として読み";
const unaryPasses = [
	// 通る：前置・後置の点なしの単項（前は G14）
	["[-_] 5", std("[-_] 5"), "(apply [-_] 5)", "A", { diagCount: 0 }],
	["[_!] 5", std("[_!] 5"), "(apply [_!] 5)", "A"],
	["[!!_] 5", std("[!!_] 5"), "(apply [!!_] 5)", "A"],
	["[!_] (2 < 3)（否定の点なし）", std("[!_] (2 < 3)"), "(apply [!_] [2 < 3])", "A"],
	["[!_] 2 < 3（`2 < 3` は項の中）", std("[!_] 2 < 3"), "(apply [!_] (< 2 3))", "A"],
	["[-_]（1項は関数。行の根なので `_`、R42）", std("[-_]"), "(unit [-_])", "A"],
	["[!_]（1項は関数。行の根なので `_`、R42）", std("[!_]"), "(unit [!_])", "A"],
	["[!_] 5", std("[!_] 5"), "(apply [!_] 5)", "A"],
	// 否定の点なしは単項なので、2項以上は余り（恒等射 `i : !_` の `i 1 2 3` は並び全体を受けて excess にしない、上の「印と穴」）
	["[!_] 1 2 3（余りは後ろに積む、R35）", std("[!_] 1 2 3"), "(construct (apply [!_] 1) 2 3)", "A", { leftover: true }],
	["(!_) 5（丸い括りも同じ括り）", std("(!_) 5"), "(apply [!_] 5)", "A"],
	["inc [-_] 5（合成の後ろ）", std("inc [-_] 5"), "(apply (compose inc [-_]) 5)", "A"],
	["inc [!_] 5（合成の後ろ）", std("inc [!_] 5"), "(apply (compose inc [!_]) 5)", "A"],
	["[-_] inc 5（合成の頭）", std("[-_] inc 5"), "(apply (compose [-_] inc) 5)", "A"],
	["[-_] [!_] 5（点なしどうしの合成）", std("[-_] [!_] 5"), "(apply (compose [-_] [!_]) 5)", "A"],
	["[* 2,] [-_] 1 2 3", std("[* 2,] [-_] 1 2 3"), "(apply (compose [* 2,] [-_]) (construct 1 2 3))", "A"],
	["[-_] 5 6（余りは後ろに積む、R35）", std("[-_] 5 6"), "(construct (apply [-_] 5) 6)", "A", { leftover: true }],
	// `[-_] 5` は口が埋まって値になり、後ろの inc は積まれて余る（R47・R42・R48）。前は逆適用で `(apply inc (apply [-_] 5) ·rev)`。
	["[-_] 5 inc（R47。前は逆適用の左）", std("[-_] 5 inc"), "(construct (apply [-_] 5) (unit inc))", "A"],
	// `5 inc [-_]`（§5 Q23 の答えで通っていた）は、2026-10-23 は `[-_]` が `5 inc` の値を逆適用で取った（R40）。R47 では inc と `[-_]` が
	// 5 の後ろに積まれた合成で余る。下の「左からの畳み込み」の pfReversePasses にある。
	["[-_] _（終わり、n = 1）", std("[-_] _"), "(apply [-_] _)", "A"],
	["本体 t : y ? [-_] y", std("t : y ? [-_] y"), "(apply [-_] y)", "A", { body: true }],
	["括りの関数の実体の本体 t : [y] ? [-_] y", std(["t : [y] ? [-_] y", "t 1"]), "(: t (? [[y]] (inst N (apply [-_] y))))", null, { at: -2 }],
	["p : [-_] の後で p 5", std(["p : [-_]", "p 5"]), "(apply p 5)", "A"],
	// 名前を書かないので、取り込みのある範囲でも同じ（R30 では名前が未定義か分からず、使えなかった）
	["io@ の後で [-_] 5", std(["io@", "[-_] 5"]), "(apply [-_] 5)", "A"],
	// R30 を廃止した：`[-a]` は値の印を当てた項の括り（R30 の前と同じ）。information は値の読みの文面
	["[-a] 5（値の括りと 5 の構築）", std("[-a] 5"), "(construct [-a] 5)", "A", { diag: "a", diagText: VALUE_TEXT, diagCount: 1 }],
	["(-a) 5（丸い括りも同じ）", std("(-a) 5"), "(construct [-a] 5)", "A", { diag: "a", diagText: VALUE_TEXT, diagCount: 1 }],
	["[-a]（値）", std("[-a]"), "[-a]", "A", { diag: "a", diagText: VALUE_TEXT, diagCount: 1 }],
	["[a!] 5", std("[a!] 5"), "(construct [a!] 5)", "A", { diag: "a", diagText: VALUE_TEXT, diagCount: 1 }],
	["[!a] (2 < 3)", std("[!a] (2 < 3)"), "(construct [!a] [2 < 3])", "A", { diag: "a", diagText: VALUE_TEXT, diagCount: 1 }],
	// 今のまま：定義した値に印・中置の区間・値 `$_` の括り
	["今のまま v : 3 の後で [-v] 5（値に印）", std(["v : 3", "[-v] 5"]), "(construct [-v] 5)", "A", { diagCount: 0 }],
	["今のまま [- a] 5（中置の区間、a は値）", std("[- a] 5"), "(apply [- a] 5)", "A", { diag: "a", diagText: VALUE_TEXT, diagCount: 1 }],
	["今のまま [$_] 5（値 `$_` の括り）", std("[$_] 5"), "(construct [$_] 5)", "A"],
];
const unaryRefused = [
	// 前は点なしなので、逆適用の右で主語を直に受ける所では G10 だった（`5 [-_]`・`5 [!_]`・`5 [-_] inc`）。2026-10-23 に R13 を廃止して
	// 通る（R40）。下の「左からの畳み込み」の pfReversePasses へ移した。
	// 否定の点なしは単項なので、`[!_] 1` の後ろに 2 が積まれる。inc は 2026-10-23 はいちばん上の 2 を取った（R40。前は G12(a)）が、R47 では
	// 積まれて余る。下の「左からの畳み込み」へ移した。
	// 今のまま：関数に印（Q22）・取り込みのある範囲の名前に印（Q10）
	["今のまま [-inc] 5（関数に印）", std("[-inc] 5"), "G7"],
	["今のまま io@ の後で [-a] 5（取り込みのある範囲の名前）", std(["io@", "[-a] 5"]), "G7"],
	// §5 Q33 の答え（U〔答え〕2026-10-21 09:21「良いと思う。」）：`$`・`@`・`#`・`~` の印には点なしを作らない。`[@_]`・`[#_]`・`[_@]`・
	// `[_~]`・`[~_]` は点なしではなく、ふつうの括りの項で、その印の項の読み（前置 `@` は Q9、前置 `~` は Q14、後置 `@`・前置 `#` は
	// Q10）に従う。今の解決器ではどれも未知（G7）。`[$_]` は値 `$_` の括りで A（上の「今のまま」）、`[$_,]` は作らない（未知）。
	["Q33 の答え [~_] 5（前置 `~` の項の括り、Q14）", std("[~_] 5"), "G7"],
	["Q33 の答え [@_] 5（前置 `@` の項の括り、Q9）", std("[@_] 5"), "G7"],
	["Q33 の答え [#_] 5（前置 `#` の項の括り、Q10）", std("[#_] 5"), "G7"],
	["Q33 の答え [_@] 5（後置 `@` の項の括り、Q10）", std("[_@] 5"), "G7"],
	["Q33 の答え [_~] 5（撒く `_~` の項の括り）", std("[_~] 5"), "G7"],
	["Q33 の答え [$_,] 1 2 3（作らない）", std("[$_,] 1 2 3"), "G7"],
	["Q33 の答え [@_,] 1 2 3（作らない）", std("[@_,] 1 2 3"), "G7"],
	// 前置・後置の点なしの写像は `[* 2,]` と同じ（下の mapPasses）。末尾の `_` は `[* 2,] 1 _` と同じくアリティの数えられない頭の終わりで
	// G5。逆適用の右の `5 [-_,]`（前は G10）は、R13 を廃止して通る（下の「左からの畳み込み」の pfReversePasses）。
	["G5 [-_,] 1 _（[* 2,] 1 _ と同じ）", std("[-_,] 1 _"), "G5"],
];
// 前置・後置の点なしの写像（U〔答え〕2026-10-21 10:09「前置・後置の点なしにも , を付けて、[* 2,] と同じ要素ごとの写像と読む。」）。
// 前は §5 Q33 で未知（G7）だった。種類は貪欲な単項（`[* 2,]` の行）：k ≥ 1 で A、`excess` にしない。
const mapPasses = [
	["[-_,] 1 2 3（前は G7）", std("[-_,] 1 2 3"), "(apply [-_,] (construct 1 2 3))", "A", { leftover: false }],
	["[!_,] 1 2 3", std("[!_,] 1 2 3"), "(apply [!_,] (construct 1 2 3))", "A"],
	["[!!_,] 1 2 3", std("[!!_,] 1 2 3"), "(apply [!!_,] (construct 1 2 3))", "A"],
	["[_!,] 1 2 3", std("[_!,] 1 2 3"), "(apply [_!,] (construct 1 2 3))", "A"],
	["[-_,]（1項は関数。行の根なので `_`、R42）", std("[-_,]"), "(unit [-_,])", "A"],
	["[-_,] 5", std("[-_,] 5"), "(apply [-_,] 5)", "A"],
	["[-_,] [1 2 3]", std("[-_,] [1 2 3]"), "(apply [-_,] [1 2 3])", "A"],
	// excess にしない。並びを受けている間に来た inc は合成の後ろ（R41、`[* 2,] 1 2 3 inc` と同じ）。木は入れ子の適用（R47 で `·rev` の
	// 綴りが無くなった。前は `(apply inc (apply [-_,] (construct 1 2)) ·rev)` で、名前は「逆適用の左」）。
	["[-_,] 1 2 inc（受けている間の合成）", std("[-_,] 1 2 inc"), "(apply inc (apply [-_,] (construct 1 2)))", "A"],
	["inc [-_,] 5（合成の後ろ）", std("inc [-_,] 5"), "(apply (compose inc [-_,]) 5)", "A"],
	["[!_,] [* 2,] 1 2 3（合成の頭）", std("[!_,] [* 2,] 1 2 3"), "(apply (compose [!_,] [* 2,]) (construct 1 2 3))", "A"],
	// 2026-10-24 の試し（R51）：貪欲な単項は流れを丸ごと受け、写した結果は List（流れはいくつでも1項）。前は撒く項で k を数えないので未知の根。
	["[-_,] vs~（R51、試し。前は未知の根）", std("[-_,] vs~"), "(apply [-_,] vs~)", "A"],
];
for (const [name, s, want, kind, extra] of unaryPasses) checkPass(`点なし ${name}`, s, want, kind, extra);
for (const [name, s, want] of unaryRefused) checkRefused(`点なし ${name}`, s, want);
for (const [name, s, want, kind, extra] of mapPasses) checkPass(`点なし 写像 ${name}`, s, want, kind, extra);

// ---------------------------------------------------------------------------
// 畳む2項の点なし（R31、2026-10-21）
// ---------------------------------------------------------------------------
//
// 括りの中が1行で、項1つが両側の被演算子の欠けた中置で、記号が算術（`+`・`-`・`*`・`/`・`%`・`^`）・ビット（`||`・`;;`・`&&`）・
// 論理（`|`・`&`・`;`）・比較（`<`・`<=`・`=`・`>=`・`>`・`==`）なら、`[op] x1 … xn` は `x1 op … op xn` を演算子表の結合の向き
// どおりに並べた物と同じ（U〔答え〕2026-10-21 09:15「[^] は中置と同じく右から畳む。[op] x1 … xn は演算子表の結合の向きどおりに
// 並べた物と同じ。」）。U 08:47「2項演算は左から畳んでいい、この時、畳んじゃいけないものは、モノイドの域になってない。」、
// U 08:50「[&] a b c / で c が返る。」、U 08:55「比較点無しは一番右を返すか _」。種類は、実引数が2項以上なら A（中置の値の演算子の
// 被演算子が全部 A のときと同じ）。1項なら、数（`[+] 5` は 5 で §5 Q17 は閉じた）か、要素が全部 A と見える List（要素を畳む）の
// ときだけ A で、要素に関数か未知が見える器・中身の見えない A・構造体は未知（2026-10-21 の確かめで見つかった黙った誤答を直した。
// R31 の最初の版は1項ならいつも A で、`z : [&] gs`（gs は `1 , inc`）の `z 5` を構築と読んでいた）。撒く項があれば未知。書いた `_` は
// 中置の被演算子と同じく印で A（R15）、末尾の `_` も「終わり」（R28）にしない（`[+] 1 _` は `1 + _`）。値は値の段（演算子表の Unit の
// 欄）が読むので、ここでは木と種類だけを見る。値の列（`[^] 2 3 2` は 512 など）は確かめない。
// 畳まない2項の点なし（`<<`・`>>`・get・set・範囲・`!=`・`!==`・中置の `#`）は、下の「畳まない2項の点なし」（R32）。
const foldPfPasses = [
	["[+] 5（1項はその項そのもの、前は未知）", std("[+] 5"), "(apply [+] 5)", "A", { leftover: false }],
	["[+] 1 2 3", std("[+] 1 2 3"), "(apply [+] (construct 1 2 3))", "A", { leftover: false }],
	["[-] 5 3 1", std("[-] 5 3 1"), "(apply [-] (construct 5 3 1))", "A"],
	["[-] 10 3 2（§6.3 の行）", std("[-] 10 3 2"), "(apply [-] (construct 10 3 2))", "A"],
	["[*] 2 3（前は未知）", std("[*] 2 3"), "(apply [*] (construct 2 3))", "A"],
	["[/] 12 3 2", std("[/] 12 3 2"), "(apply [/] (construct 12 3 2))", "A"],
	["[%] 7 3", std("[%] 7 3"), "(apply [%] (construct 7 3))", "A"],
	["[^] 2 3 2（右から畳む）", std("[^] 2 3 2"), "(apply [^] (construct 2 3 2))", "A"],
	["[||] 1 2 4", std("[||] 1 2 4"), "(apply [||] (construct 1 2 4))", "A"],
	["[;;] 1 3", std("[;;] 1 3"), "(apply [;;] (construct 1 3))", "A"],
	["[&&] 3 1", std("[&&] 3 1"), "(apply [&&] (construct 3 1))", "A"],
	["[|] 0 5（前は未知）", std("[|] 0 5"), "(apply [|] (construct 0 5))", "A"],
	["[&] 1 2 3（c が返る）", std("[&] 1 2 3"), "(apply [&] (construct 1 2 3))", "A"],
	["[;] 1 0（前は G7、Q19）", std("[;] 1 0"), "(apply [;] (construct 1 0))", "A"],
	["[<] 1 2 3", std("[<] 1 2 3"), "(apply [<] (construct 1 2 3))", "A"],
	["[<] 1 3 2（外れれば値は _、種類は A）", std("[<] 1 3 2"), "(apply [<] (construct 1 3 2))", "A"],
	["[<=] 1 1 2", std("[<=] 1 1 2"), "(apply [<=] (construct 1 1 2))", "A"],
	["[=] 1 1", std("[=] 1 1"), "(apply [=] (construct 1 1))", "A"],
	["[>=] 3 3 1", std("[>=] 3 3 1"), "(apply [>=] (construct 3 3 1))", "A"],
	["[>] 3 2 1", std("[>] 3 2 1"), "(apply [>] (construct 3 2 1))", "A"],
	["[==] 1 1（前は G7、Q19）", std("[==] 1 1"), "(apply [==] (construct 1 1))", "A"],
	["[&] a b c（a b c は未定義の名前＝値）", std("[&] a b c"), "(apply [&] (construct a b c))", "A", { diag: "a" }],
	// List 1つは要素を並びとして畳む（`[+] [1 2 3]` は 6、案内の `[+] [1 __ 3]` は 4）。前は未知。
	["[+] [1 2 3]（前は未知）", std("[+] [1 2 3]"), "(apply [+] [1 2 3])", "A"],
	["[+] [1 _ 3]（前は未知）", std("[+] [1 _ 3]"), "(apply [+] [1 _ 3])", "A"],
	["[+] vs（List の名前）", std("[+] vs"), "(apply [+] vs)", "A"],
	["[+] (vs)（括り1つでも中の行の形が見える）", std("[+] (vs)"), "(apply [+] [vs])", "A"],
	["[+] [[1 2] [3 4]]（要素の List も中身が全部 A）", std("[+] [[1 2] [3 4]]"), "(apply [+] [[1 2] [3 4]])", "A"],
	["[+] -5（値の印を当てた数）", std("[+] -5"), "(apply [+] -5)", "A"],
	["[' 0] [+] [[1 2] [3 4]]（引いた List の形を受ける、R26）", std("[' 0] [+] [[1 2] [3 4]]"), "(apply (compose [' 0] [+]) [[1 2] [3 4]])", "A"],
	["[+] [1 2 3] は information を出さない", std("[+] [1 2 3]"), "(apply [+] [1 2 3])", "A", { diagCount: 0 }],
	// 1項で、要素が全部 A とは見えない物は未知（R31 の1項。R31 の最初の版はどれも A）。根なら通る。
	["[|] fs（要素に関数が見える、未知の根）", std("[|] fs"), "(apply [|] fs)", "未知"],
	["[==] (inc , inc)（未知の根）", std("[==] (inc , inc)"), "(apply [==] [inc , inc])", "未知"],
	["[+] (inc 5)（括りの中が適用の結果で中身が見えない、未知の根）", std("[+] (inc 5)"), "(apply [+] [inc 5])", "未知"],
	["sv（構造体）の後で [+] sv（欄を畳む読みは無い、未知の根）", std(["sv :", "\tk : 1", "\tother : 2", "", "[+] sv"]), "(apply [+] sv)", "未知"],
	["本体 t : y ? [&] y（裸の仮引数は中身が見えない、未知の根）", std("t : y ? [&] y"), "(apply [&] y)", "未知", { body: true }],
	["本体 t : y ? [&] (y)（`[x]≅x` なので y と同じ）", std("t : y ? [&] (y)"), "(apply [&] [y])", "未知", { body: true }],
	// 書いた `_` は中置の被演算子と同じく印で A。木は `_` を残す（前は G5）。
	["[+] 1 _（1 + _、前は G5）", std("[+] 1 _"), "(apply [+] (construct 1 _))", "A"],
	["[+] 1 _ 3（前は G5）", std("[+] 1 _ 3"), "(apply [+] (construct 1 _ 3))", "A"],
	["[+] _（前は G5）", std("[+] _"), "(apply [+] _)", "A"],
	["[|] _ 5（前は G5）", std("[|] _ 5"), "(apply [|] (construct _ 5))", "A"],
	["[&] 1 _ 3（前は G5）", std("[&] 1 _ 3"), "(apply [&] (construct 1 _ 3))", "A"],
	// 終わりではないので、`[+] 5 6 inc` と同じく `[+]` が受けている間に来た inc は合成の後ろ（R41）。木は入れ子の適用（R47 で `·rev` の
	// 綴りが無くなった。前は `(apply inc (apply [+] (construct 1 _)) ·rev)`）。
	["[+] 1 _ inc（終わりではないので、`[+] 5 6 inc` と同じ合成）", std("[+] 1 _ inc"), "(apply inc (apply [+] (construct 1 _)))", "A"],
	// `5 [+] _` は、2026-10-23 は `[+]` が 5 を逆適用で取った（R31・R40）。R47 では `5 ([+] _)`。下の「左からの畳み込み」の pfReversePasses にある。
	["[+] inc 1 _（合成の最初が畳む頭なら、`_` はその実引数、前は G5）", std("[+] inc 1 _"), "(apply (compose [+] inc) (construct 1 _))", "A"],
	// 合成・畳み込みの中は、今までの `[+]` と同じ。
	["[+] inc 5 6（12 の木のまま）", std("[+] inc 5 6"), "(apply (compose [+] inc) (construct 5 6))", "A"],
	// 後ろの `[+]` が受けるのは前の結果（中身の見えない A）なので、今までどおり未知（R31 の1項。R31 の最初の版は A）。
	["inc [+] 5（後ろの [+] に中身の見えない A、未知の根）", std("inc [+] 5"), "(apply (compose inc [+]) 5)", "未知"],
	// `5 inc [+]`（§5 Q23 の答えで通っていた）と `1 [*] 2 3 4` は、2026-10-23 は点なしが前の値を逆適用で取った（R40）。R47 では積まれて
	// 後ろの項を受ける。下の「左からの畳み込み」の pfReversePasses にある。
	// `[*]` が受けている間に来た inc は合成の後ろ（R41）。木は入れ子の適用（前は `·rev` の綴り、R47 で無くなった）。
	["[*] 2 3 inc（前は G2(a)）", std("[*] 2 3 inc"), "(apply inc (apply [*] (construct 2 3)))", "A"],
	// `[+]` の口は並びの終わりまで受ける（R41）ので、g は開いた `[+]` の後ろに合成され、3 も `[+]` が受ける：`g ([+] 5 3)`（規則の文面の
	// `[+] 1 2 inc 3` は `inc ([+] 1 2 3)` と同じ形）。前は強さの順で `([+] 5) (g 3)`。
	["[+] 5 g 3（`g ([+] 5 3)`、R41。前は G2(a)、その後 `([+] 5) (g 3)`）", std("[+] 5 g 3"), "(apply g (apply [+] (construct 5 3)))", "A"],
	["[<] [* 2,] 1 2 3（合成の頭）", std("[<] [* 2,] 1 2 3"), "(apply (compose [<] [* 2,]) (construct 1 2 3))", "A"],
	["本体 t : y ? [&] y 1", std("t : y ? [&] y 1"), "(apply [&] (construct y 1))", "A", { body: true }],
	["p : [+] の後で p 1 2", std(["p : [+]", "p 1 2"]), "(apply p (construct 1 2))", "A"],
	// 撒く項があれば今までどおり未知。
	["[&] [1 2 3]~（撒く項は未知の根）", std("[&] [1 2 3]~"), "(apply [&] [1 2 3]~)", "未知"],
	// `[,]` は今のまま：アリティの分からない点なしで、適用は未知（根なら通る）。
	["今のまま [,] 1 2", std("[,] 1 2"), "(apply [,] (construct 1 2))", "未知"],
];
const foldPfRefused = [
	// 前は点なしなので、逆適用の右で主語を直に受ける所では G10 だった（`5 [&]`・`5 [<]`・`5 [+]`・`5 [+] inc`）。2026-10-23 に R13 を
	// 廃止して通る（R40。2026-10-24 から R47 で積まれる）。下の「左からの畳み込み」の pfReversePasses へ移した。
	// 穴 `!_` は畳む頭の実引数でも穴の位置の外（G7）。
	["G7 [+] 1 !_", std("[+] 1 !_"), "G7"],
	["G7 [+] !_ 5（§6.3 の行）", std("[+] !_ 5"), "G7"],
	// 畳む2項の点なしでない頭の `_` は今までどおり G5（§6.3 の行。前の見本の `[+] 1 _ 3`・`[+] 1 _` は R31 で通る）。
	["G5 [* 2,] 1 _ 3（貪欲な単項の点なしの内側の `_`）", std("[* 2,] 1 _ 3"), "G5"],
	["G5 [,] 1 _（アリティの数えられない頭の末尾の `_`）", std("[,] 1 _"), "G5"],
	// 1項で要素に関数が見える器を畳んだ結果は未知（R31 の1項）。R31 の最初の版は、どれも A にして黙って構築や逆適用の左に
	// 読んでいた（確かめ 2026-10-21。z は inc なので `z 5` は inc を 5 に当てる形）。HEAD（R31 の前）も G7 か未知で断っていた。
	["G7 gs : 1 , inc の後で z : [&] gs ⏎ z 5", std(["gs : 1 , inc", "z : [&] gs", "z 5"]), "G7"],
	["G7 gs : 1 , inc の後で z : [&] gs ⏎ 5 z", std(["gs : 1 , inc", "z : [&] gs", "5 z"]), "G7"],
	["G7 ([|] (inc , 1)) 5", std("([|] (inc , 1)) 5"), "G7"],
	// `[|] fs inc` は、`[|]` の口が並びの終わりまで受ける（R41）ので、inc は合成されて閉じた値（未知）を受ける。下の「左からの畳み込み」へ移した。
	// 裸の仮引数（中身の見えない A）を1項で畳む本体の根は未知。器を受ければ要素に関数が見えるかもしれない。
	["G7 t : y ? [&] y の後で w : t gs ⏎ w 5", std(["gs : 1 , inc", "t : y ? [&] y", "w : t gs", "w 5"]), "G7"],
	// `[:]`・`[?]` は今のまま外す（Q19）。
	["今のまま [?] 1 2（Q19）", std("[?] 1 2"), "G7"],
	// 片側の欠けた段1〜9 の点なしは R31 の外（Q19）。
	["今のまま [| 5] 1（Q19）", std("[| 5] 1"), "G7"],
	["今のまま [== 3] 1（Q19）", std("[== 3] 1"), "G7"],
];
for (const [name, s, want, kind, extra] of foldPfPasses) checkPass(`畳む ${name}`, s, want, kind, extra);
for (const [name, s, want] of foldPfRefused) checkRefused(`畳む ${name}`, s, want);

// ---------------------------------------------------------------------------
// 畳まない2項の点なし（R32、§5 Q34 の答え、2026-10-21）
// ---------------------------------------------------------------------------
//
// 括りの中が1行で、項1つが両側の被演算子の欠けた中置で、記号が畳まない物（段12〜22 の `<<`・`>>`・`'`・`@`・範囲の `~`・`~+`・
// `~-`・`~*`・`~/`・`~^`・`!=` と、段1〜9 の `!==`・中置の `#`）なら、素の2引数の関数と同じに読む（主の Claude の問い「素の2引数の
// 関数と同じに読む、でいい？」に、U〔答え〕2026-10-21 10:52「同じに読んでいいけど、おすすめは出来ないという方向で良いと思う。」）。
// 口は左から埋まる：k = 2 は適用、k = 1 は右の口を待つ足りない適用（L）、k > 2 は余り、末尾の `_` は R28 の n = 2。足りた適用の
// 種類は、値を返す演算（`<<`・`>>`・`!=`・`!==`・範囲）は A、get・set（`'`・`@`・中置の `#`）は何を引いたか・何をしたかが決まらない
// ので未知（決定の規則、主の Claude の案）。「おすすめは出来ない」は断らずに information `pointfree-not-folded` で見せる（書いた
// 点なし1つにつき1回）。前は段12〜22 の物がアリティの分からない点なし（適用は未知）、段1〜9 の物が未知の葉（G7）だった。
const binPfPasses = [
	["[<<] 1 2（前は未知の根）", std("[<<] 1 2"), "(apply [<<] (construct 1 2))", "A", { leftover: false, pfInfo: "[<<]", diagCount: 1 }],
	["[>>] 4 1", std("[>>] 4 1"), "(apply [>>] (construct 4 1))", "A", { pfInfo: "[>>]" }],
	["[~] 1 5（範囲）", std("[~] 1 5"), "(apply [~] (construct 1 5))", "A", { pfInfo: "[~]" }],
	["[~+] 1 5", std("[~+] 1 5"), "(apply [~+] (construct 1 5))", "A", { pfInfo: "[~+]" }],
	["[!=] 1 2", std("[!=] 1 2"), "(apply [!=] (construct 1 2))", "A", { pfInfo: "[!=]" }],
	["[!==] 1 2（段1〜9、前は G7）", std("[!==] 1 2"), "(apply [!==] (construct 1 2))", "A", { pfInfo: "[!==]" }],
	// get・set の足りた適用は未知（根なら通る）。
	["['] fs 0（get は未知の根）", std("['] fs 0"), "(apply ['] (construct fs 0))", "未知", { pfInfo: "[']" }],
	["[@] fs 0（未知の根）", std("[@] fs 0"), "(apply [@] (construct fs 0))", "未知", { pfInfo: "[@]" }],
	["[#] 1 2（中置の # は set、未知の根。前は G7）", std("[#] 1 2"), "(apply [#] (construct 1 2))", "未知", { pfInfo: "[#]" }],
	// 口は左から埋まる。
	// 足りない適用は L。行の根に残ったので `_`（R42。木は `(unit …)` で包む。下の L の根の行も同じ）。
	["[<<] 1（右の口を待つ足りない適用。R42）", std("[<<] 1"), "(unit (apply [<<] 1))", "A"],
	["['] fs（get も同じく L。R42）", std("['] fs"), "(unit (apply ['] fs))", "A"],
	["[<<] 1 4 2（余りは後ろに積む、R35）", std("[<<] 1 4 2"), "(construct (apply [<<] (construct 1 4)) 2)", "A", { leftover: true }],
	["[<<] 1 _（末尾の `_` は R28 の n = 2）", std("[<<] 1 _"), "(apply [<<] (construct 1 _))", "A"],
	// k' = n：`[<<] 1 2` で口が埋まって値になり、後ろの `_` は並びの単位として消える（R43。前は `_` を木に残した）。
	["[<<] 1 2 _（k' = n。`_` は消える、R43）", std("[<<] 1 2 _"), "(apply [<<] (construct 1 2))", "A", { leftover: false }],
	// 口が2つとも埋まって値になり、後ろの inc は積まれて余る（R47・R42・R48）。前（2026-10-23 まで）は逆適用で
	// `(apply inc (apply [<<] (construct 1 2)) ·rev)` など、その前は G2(a)。
	["[<<] 1 2 inc（R47。前は G2(a)、その後 逆適用）", std("[<<] 1 2 inc"), "(construct (apply [<<] (construct 1 2)) (unit inc))", "A"],
	["[!=] 1 2 inc（R47。前は G2(a)、その後 逆適用）", std("[!=] 1 2 inc"), "(construct (apply [!=] (construct 1 2)) (unit inc))", "A"],
	["[~] 1 5 inc（R47。前は G2(a)、その後 逆適用）", std("[~] 1 5 inc"), "(construct (apply [~] (construct 1 5)) (unit inc))", "A"],
	// 部分適用と合成は、素の2引数の関数（`add`）と同じ。
	["q : [<<] 1 の後で q 2", std(["q : [<<] 1", "q 2"]), "(apply q 2)", "A"],
	["([<<] 1) 2", std("([<<] 1) 2"), "(apply [[<<] 1] 2)", "A"],
	["([<<] 1) _", std("([<<] 1) _"), "(apply [[<<] 1] _)", "A"],
	["p : [<<] の後で p 1 2", std(["p : [<<]", "p 1 2"]), "(apply p (construct 1 2))", "A"],
	["[<<] inc 2 3（前は未知の根）", std("[<<] inc 2 3"), "(apply (compose [<<] inc) (construct 2 3))", "A"],
	["[<<] inc 5（`add inc 5` と同じく足りない。根なので `_`、R42）", std("[<<] inc 5"), "(unit (apply (compose [<<] inc) 5))", "A"],
	// 後ろの足りない適用は、`[<<] (inc 5)` の足りない適用（L）。`inc add 5` と同じ。前は未知。根なので `_`（R42）。
	["inc [<<] 5（後ろの足りない適用、`inc add 5` と同じ。R42）", std("inc [<<] 5"), "(unit (apply (compose inc [<<]) 5))", "A"],
	// `[<<] (inc 5) 6`。後ろの関数が並びの 6 を受けたので、木は各関数が受けた物の見える入れ子の適用（R40、§1.3）。
	["inc [<<] 5 6（`[<<] (inc 5) 6`。木は入れ子、R40）", std("inc [<<] 5 6"), "(apply [<<] (construct (apply inc 5) 6))", "A"],
	// 足りない適用を含む合成が適用の頭（`f2 1 g 2` と同じ）：流れで `g ([<<] 5 3)`（R36）。前は G2(b)（下の binPfRefused にあった）。
	["[<<] 5 g 3（前は G2(b)）", std("[<<] 5 g 3"), "(apply (compose (apply [<<] 5) g) 3)", "A", { pfInfo: "[<<]" }],
	// `1 [<<] 2 3 4`・`5 inc ([<<] 1)`・`q : [<<] 1 ⏎ 5 inc q`・`5 inc [<<]` は、2026-10-23 は点なしが前の値を逆適用で取った（R40）。R47 では
	// 素の2引数の関数と同じく値の後ろに積まれる。下の「左からの畳み込み」へ移した。
	// 素の2引数の関数の部分適用の同じ形（下の「比べ」）。R47 で、5 の後ろに積まれた合成が余り、根で `_`（R42・R48）。前は逆適用で
	// `(apply (compose inc [add 1]) 5 ·rev)`・`(apply (compose inc q2) 5 ·rev)`。
	["比べ 5 inc (add 1)（R47）", std("5 inc (add 1)"), "(construct 5 (unit (compose inc [add 1])))", "A"],
	["比べ q2 : add 1 ⏎ 5 inc q2（R47）", std(["q2 : add 1", "5 inc q2"]), "(construct 5 (unit (compose inc q2)))", "A"],
	// information は書いた点なし1つにつき1回。本体を何度読んでも、同じ書いた所なら1回。
	["[<<] 1 2 ⏎ [<<] 3 4（書いた所が2つ）", std(["[<<] 1 2", "[<<] 3 4"]), "(apply [<<] (construct 3 4))", "A", { diagCount: 2 }],
	["t : y ? [<<] y 1 ⏎ t 2 ⏎ t 3（書いた所が1つ）", std(["t : y ? [<<] y 1", "t 2", "t 3"]), "(apply t 3)", "A", { pfInfo: "[<<]", diagCount: 1 }],
	["h : [f] ? f 1 2 ⏎ h [f : [<<]]（括りの関数の欄）", std(["h : [f] ? f 1 2", "h [f : [<<]]"]), "(apply h [f : [<<]])", "A", { pfInfo: "[<<]", diagCount: 1 }],
	// 種類は記号に依らず root で決まるので、欄で渡した `[<<]`（A）と `[']`（未知）は実体を分け合わない。
	["h [f : [<<]] ⏎ h [f : [']]（get の欄は未知）", std(["h : [f] ? f 1 2", "h [f : [<<]]", "h [f : [']]"]), "(apply h [f : [']])", "未知"],
	// 読まない本体（R25）では出さない。
	["t : [y] ? [<<] y だけ（呼ばれない本体は information を出さない）", std("t : [y] ? [<<] y"), "(: t (? [[y]] (defer {[<<] y})))", null, { diagCount: 0 }],
];
const binPfRefused = [
	// 前の `G2(b) [<<] 5 g 3` と `G12(a) 1 [<<] 2 3 4` は、R36・R35 で通る側（上の binPfPasses）へ移した。2026-10-23 からは、`[<<]` が 1 を
	// 逆適用で取り、口が2つなので主語の口が決まらないまま 2 が来て G8 だった（§5 Q5。前は余りを積んだ構築の後ろの逆適用で G12(a)、
	// 作り直しの最初の版は R13 の G10）。`1 [<<] 2 3 4 inc` は、逆適用の廃止（R47、G8 も廃止）で `1 ([<<] 2 3) 4` の後ろに inc が余る形に
	// 決まり、通る側（norevPasses）へ移した。
	// get・set の足りた適用は未知なので、後ろに項が来れば G2(a)（R40 の読み6。前は余りなら G12(b)）。
	["G2(a) ['] fs 0 1（G12(b) → G2(a)、R40）", std("['] fs 0 1"), "G2(a)"],
	["G2(a) ['] fs 0 inc", std("['] fs 0 inc"), "G2(a)"],
	["G2(a) [#] 1 2 inc", std("[#] 1 2 inc"), "G2(a)"],
	// 内側の `_`（カリー化）と穴 `!_`（R16）は、名前の定義と `?` の括りの頭だけ。点なしの括りは別名の頭（`p : add` の `p _ 2`）と同じ。
	["G5 [<<] _ 2", std("[<<] _ 2"), "G5"],
	["G7 [<<] !_ 2", std("[<<] !_ 2"), "G7"],
	// 前は点なしなので、逆適用の右で主語を直に受ける所では G10 だった（`5 [<<]`・`5 ([<<] 1)`・`q : [<<] 1 ⏎ 5 q` と、その後ろに inc の
	// ある形）。1つ当てた部分適用も同じで、そこが素の2引数の関数と違っていた。2026-10-23 に R13 を廃止して、素の2引数の関数と同じに
	// 読む（`5 (add 1)` と同じく `5 ([<<] 1)` は口が1つの関数の逆適用で通り、`5 [<<]` は `5 add` と同じく行の終わりで `_`、R40・R42）。
	// 2026-10-24 の R47 からは、どれも素の2引数の関数と同じく値の後ろに積まれて余る。下の「左からの畳み込み」の pfReversePasses へ移した。
];
for (const [name, s, want, kind, extra] of binPfPasses) checkPass(`畳まない ${name}`, s, want, kind, extra);
for (const [name, s, want] of binPfRefused) checkRefused(`畳まない ${name}`, s, want);
// G12(b) の言い分は、欄で渡した記号と行の順に依らない。実体の鍵（fnKey）は記号を分けないので、前は言い分に書いた記号が、
// 先に解いた方（値の定義が先）の物になった（`h [f : [@]]` ⏎ `bv : h [f : [']]` が `[']` と名指しした。2回目の確かめ）。
// 2026-10-23 から、種類の未知な適用の後ろに項が来る形は G2(a)（R40 の読み6、G12 は廃止）。言い分が記号と行の順に依らないことは同じ。
{
	total++;
	const msgOf = (lines) => {
		try {
			resolve(std(lines));
			return "通った";
		} catch (e) {
			return `${e.gate || e.reason} ${e.message}`;
		}
	};
	const H3 = "h : [f] ? f 1 2 3";
	const got = [
		msgOf([H3, "h [f : [@]]", "bv : h [f : [']]"]),
		msgOf([H3, "h [f : [']]", "bv : h [f : [@]]"]),
		msgOf([H3, "bv : h [f : [@]]", "h [f : [']]"]),
	];
	const name = "畳まない G2(a)（前は G12(b)、R40）の言い分は、欄の記号と行の順に依らない";
	if (got.every((m) => m === got[0]) && got[0].startsWith("G2(a) ")) ok(name);
	else fail(name, ...got);
}

// ---------------------------------------------------------------------------
// 逆適用の右の合成の後ろの点なし（R13、§5 Q23 の答え、2026-10-21）
// ---------------------------------------------------------------------------
//
// 主の Claude の「逆適用の右の合成の後ろに点なしがある `5 inc [* 2]` は、`[* 2] (inc 5)` と読んでいい？」に、U〔答え〕2026-10-21
// 11:46「関数合成の方が優先では？」。並びの読みは合成 > 適用 > 逆適用（R6）なので、`inc [* 2]` がまず合成になり、その合成に 5 を
// 逆適用する。主語を受けるのは合成の最初の inc。G10（R13、U 2026-08-06 05:06「ポイントフリーであれば、apply-reverceから除外する
// のがいいと思う。」）は、主語を直に受ける関数が点なしのときだけ断る：右が合成なら最初の関数、ほかは右そのもの（点なしの部分
// 適用も点なし）。この形は決定の規則（主の Claude の案）。前は合成のどこかに点なしがあれば断っていた。§6.3 の行と、点なしの
// 種類ごとの行は、上の各節に置いた。
// 逆適用と前から書いた適用が同じ読みであることは、2026-10-23 まで coproduct_laws.test.js の法則5 が見ていた。2026-10-24 からの法則5 は
// 「値の後ろの関数は、値を取らない」（R47）。
//
// 2026-10-23 の左からの畳み込み（R40）で、この答えの前提の強さの順（R6）が無くなった。`5 inc [* 2]` は `(5 inc) [* 2]` で、`[* 2]` が
// `5 inc` の値を逆適用で主語に取った。答えは Q23 の答えと同じ `[* 2] (inc 5)`。R13（点なしは逆適用しない）は、決定の文面の
// `1 2 [+] 3 4`（`1 ([+] 2 3 4)`）と割れるので同じ日に廃止した（§4 R13・§5 Q36、§7.19）。
//
// 2026-10-24 に逆適用そのものを廃止した（R47。U [2026-10-23 13:12 ebf18260]「…逆適用は廃止しよう」）。Q23 の答えも逆適用がある前提の
// 答えで、R47 で上書きされた：値の後ろの関数は積まれて値を取らない（関数は右からだけ受ける）。`5 inc [* 2]` は 5 の後ろに合成
// `inc [* 2]` が積まれて余り、根で `_`（R42。余ったことは leftover-lambda で知らせる、R48）。下の行は、前の答え（括弧の中）からの変わり方。
const q23Passes = [
	["5 (inc [* 2])（R47。前は逆適用、その前は G8）", std("5 (inc [* 2])"), "(construct 5 (unit [inc [* 2]]))", "A"],
	["5 (inc inc)（R47。前は逆適用、その前は G8）", std("5 (inc inc)"), "(construct 5 (unit [inc inc]))", "A"],
	["h : inc [* 2] ⏎ 5 h（R47。前は逆適用、その前は G8）", std(["h : inc [* 2]", "5 h"]), "(construct 5 (unit h))", "A"],
	["5 add [* 2]（R47。前は主語の口が決まらない逆適用で `_`、その前は G8）", std("5 add [* 2]"), "(construct 5 (unit (compose add [* 2])))", "A"],
	["5 ([* 2] inc)（R47。前は逆適用、その前は G10）", std("5 ([* 2] inc)"), "(construct 5 (unit [[* 2] inc]))", "A"],
	["h : [* 2] inc ⏎ 5 h（R47。前は逆適用、その前は G10）", std(["h : [* 2] inc", "5 h"]), "(construct 5 (unit h))", "A"],
	// Q23 の答え（R6 で合成が先）で通っていた形。2026-10-23 は、点なしが前の値（前の逆適用の結果）を主語に取った（`inc ([* 2] (inc 5))`）。
	["5 inc [* 2] inc（R47。前は `inc ([* 2] (inc 5))`）", std("5 inc [* 2] inc"), "(construct 5 (unit (compose inc [* 2] inc)))", "A"],
	["5 inc [* 2] [+ 1]（R47）", std("5 inc [* 2] [+ 1]"), "(construct 5 (unit (compose inc [* 2] [+ 1])))", "A"],
	["5 double [+ 1]（R47）", std("5 double [+ 1]"), "(construct 5 (unit (compose double [+ 1])))", "A"],
	["5 inc [* 2,]（R47）", std("5 inc [* 2,]"), "(construct 5 (unit (compose inc [* 2,])))", "A"],
	["5 inc [-_,]（R47）", std("5 inc [-_,]"), "(construct 5 (unit (compose inc [-_,])))", "A"],
	// 前は `[' 0]` が `inc 5` の値（中身の見えない A）を受けて、引いた物は未知（R26）。R47 では何も受けずに余る（根で `_`）ので A。
	["5 inc [' 0]（R47。前は未知の根）", std("5 inc [' 0]"), "(construct 5 (unit (compose inc [' 0])))", "A"],
	// 本体は評価する所でない（R42 の読み1）が、2026-10-24 の R52 から、本体の中でも、値の上に積まれて何も受けずに閉じた合成は余ったラムダで
	// `_` になり、知らせる。R47 の最初の版は、ラムダのまま残って値と関数の並んだ構築が種類を決めなかった（未知、§5 Q38 の断る側）。その前は
	// 逆適用で `(apply (compose inc [* 2]) y ·rev)`、A。
	["本体 t : y ? y inc [* 2]（R52。R47 では未知（Q38）、その前は A）", std("t : y ? y inc [* 2]"), "(construct y (unit (compose inc [* 2])))", "A", { body: true, leftoverDiag: ["(compose inc [* 2])"] }],
	// R47：5 の後ろに積まれた合成 `inc [+]` が 3 を受ける（`[+] (inc 3)`）。`[+]` の1項は中身の見えない A なので未知（R31 の1項）。前は
	// `[+]` が `5 inc` の値を逆適用で取って 3 も受けた `[+] (inc 5) 3`（A）、その前は G2(a)。
	["5 inc [+] 3（R47。前は `[+] (inc 5) 3`）", std("5 inc [+] 3"), "(construct 5 (apply (compose inc [+]) 3))", "未知"],
];
for (const [name, s, want, kind, extra] of q23Passes) checkPass(`Q23 ${name}`, s, want, kind, extra);

// ---------------------------------------------------------------------------
// §5 Q1 の答え（2026-10-19）：R24・R25・R26
// ---------------------------------------------------------------------------
//
// R24：括りで受けた名前の種類は、呼ぶ側が渡した物の生まれで決まる（形ごとの実体）。
// R25：括りの関数の本体は、実体を作るときにだけ読む。呼ばれない関数は `(defer …)` で、断らない。門に当たった実体は
//      呼んだ行で断る。
// R26：`x ' k`（と `[' k] x`）で引いた物の種類は、引かれた物の生まれで決まる。
// 実体の形の綴りは resolve.js の頭の注（`{say:L other:N}`・`[N…]`・`A`、仮引数ごとに空白で並べる）。

const src = (lines) => lines.join("\n");
// pattern_guide.md「IO Reader Writer」の m と a・b・c（3つとも 42 を返す、同じ射の3つの綴り）。
const M = ["m :", "\tsay : x ? x * 2", "\tother : 1", ""];
const IO = [...M, "a : [say] ? say 21", "b : [say ~rest] ? say 21", "c : [~rest] ? (rest ' say) 21"];
// example.sn の myGreet。欄 greet は構造体。FN は欄 welcome を関数にしたもの、STR は example.sn のまま（文字列）。
const GREETING = "greeting : [greet world] ? (greet ' welcome) world";
const MY_GREET_FN = ["myGreet :", "\tgreet :", "\t\thello : x ? x", "\t\twelcome : x ? x", "\tworld : ` world`", ""];
const MY_GREET_STR = ["myGreet :", "\tgreet :", "\t\thello : `hello,`", "\t\twelcome : `welcome,`", "\tworld : ` world`", ""];
const REC = "f : [x ~xs] ? [f xs] x";
// 受けた名前 x を並びの頭に置く。x が数なら構築、中身の見えない A を受けて未知なら呼んだ行で G7（名指しは f と形）。
const X1 = "f : [x ~xs] ? x 1";
const X1_INST = "(: f (? [[x ~xs]] (inst N (construct x 1))))";
// 構築の行を並べた字下げのブロック（括りなら `w : [1 2 ⏎ 3 4]`）と、欄の値が2行のブロックの構造体（括りなら
// `w : [k : [1 ⏎ 2] ⏎ other : 3]`）。
const BLOCK_ROWS = ["f : [x ~xs] ? (x ' 0) 1", "w :", "\t1 2", "\t3 4", "", "f w"];
const BLOCK_NESTED = ["g : [k] ? h k", "h : [x ~xs] ? x 1", "w :", "\tk :", "\t\t1", "\t\t2", "\tother : 3", "", "g w"];
// 当てた物の違う括りの関数の部分適用を、欄に入れて同じ括りの関数に渡す（R24。部分適用の確かめ 2026-10-19 の TG1）。
const PAIR_FIELDS = ["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a b", "call : [f ~r] ? f [2]", "s :", "\ta : inc", "", "m1 :", "\tf : pair [1]", "", "m2 :", "\tf : pair s", ""];
const PAIR_FIELDS_INST = "(: pair (? [[a ~as] [b ~bs]] (inst N N (construct a b)) (inst {a:L} N (apply a b))))";
const PAIR_GATE = ["pair : [a ~as] [b ~bs] ? a 1", "call : [f ~r] ? f [2]", "s2 :", "\tz : 1", "", "m1 :", "\tf : pair [1]", "", "m2 :", "\tf : pair s2", ""];
// 実体の深さの守り（resolve.js の INSTANCE_DEPTH_MARGIN の注の1、2026-10-20 の自己点検の SC-1・SC-2）。深さは作る実体の鍵（渡した
// 形）の入れ子の深さで、上限は（32 × 書いた括りの関数の数 + 1）× 書いたいちばん深い形。HB_CHAIN(n) は、素の関数 f0 … f(n−1) が、括りの関数 hb に次の関数を欄で渡す鎖（f(n−1) は
// 値を返す）。hb の形はどれも {s:L}（深さ 2）。NEST(d) は `[a : …]` を d 重にした字面（形の深さ d + 1）、NEST_SHAPE(d) はその
// 形の綴り。`p : [a] ? p a` に渡すと、入れ子を1段ずつ剥がす（減っていく形の再帰）ので、実体は d + 1 個が入れ子になる（いちばん
// 内は数 N で、同じ形で自分を呼ぶ）。断るかは、初めの形の深さで決まる。
const HB_CHAIN = (n) => ["hb : [s] ? s 1", ...[...Array(n - 1).keys()].map((i) => `f${i} : x ? hb [s : f${i + 1}]`), `f${n - 1} : x ? x + 1`];
const NEST = (d) => `${"[a : ".repeat(d)}1${"]".repeat(d)}`;
const NEST_SHAPE = (d) => `${"{a:".repeat(d)}N${"}".repeat(d)}`;
// 輪と入れ子の鎖：r は a と b を入れ替えて自分を呼び（形の違う2つの実体の輪）、a を剥がしても自分を呼ぶ。ROT_NEST(d) は
// 欄 a に d − 1 段を入れ、欄 b を数にした構造体の字面（行に分けた括り）。形の深さは d + 1（入れ替えても同じ）。前の守りは
// 実体の入れ子を数えたので、いちばん長い道（剥がす鎖の d − 1 個と、下の入れ替えの実体・数の実体2つで d + 2 個）で数えた。
const ROT = ["r : [a b] ? (r [a : b", "\tb : a]) , (r a)"];
const ROT_NEST = (d) => (d === 0 ? ["1"] : ((inner) => [`[a : ${inner[0]}`, ...inner.slice(1), "\tb : 1]"])(ROT_NEST(d - 1)));
const ROT_SHAPE = (d) => (d === 0 ? "N" : `{a:${ROT_SHAPE(d - 1)} b:N}`);
const ROT_DEF = (name, d) => ((s) => [`${name} : r ${s[0]}`, ...s.slice(1)])(ROT_NEST(d));
// 欄の並べ替え：r は n 個の欄を1つずつずらし、前の2つを入れ替えて自分を呼ぶ。欄の値はどれも形が違うので、形は n! 通りで、
// どれも深さは同じ（深くならない）。実体はどれも n 個の欄の構造体で、入れ子は深さ優先で長くなる。
const PERM_VALS = ["1", "[1 2]", "[z : 1]", "[y : 1]", "[x : 1]", "[[1 2] [3 4]]", "[w : 1]"];
// PERM_RING(n, m) は、同じ並べ替えを m 個の関数 r0 … r(m−1) が順に呼び合う物（r(m−1) は r0 を呼ぶ）。
const PERM_RING = (n, m) => {
	const ns = "abcdefg".slice(0, n).split("");
	const rows = (f) => ns.map((x, i) => `${x} : ${f(x, i)}`);
	const block = (rs) => [`[${rs[0]}`, ...rs.slice(1, -1).map((r) => `\t${r}`), `\t${rs[rs.length - 1]}]`];
	const cyc = block(rows((x, i) => ns[(i + 1) % n]));
	const swp = block(rows((x, i) => (i === 0 ? ns[1] : i === 1 ? ns[0] : x)));
	const name = (k) => (m === 1 ? "r" : `r${k % m}`);
	const defs = [...Array(m).keys()].flatMap((k) => {
		const nx = name(k + 1);
		return [`${name(k)} : [${ns.join(" ")}] ? (${nx} ${cyc[0]}`, ...cyc.slice(1, -1), `${cyc[cyc.length - 1]}) , (${nx} ${swp[0]}`, ...swp.slice(1, -1), `${swp[swp.length - 1]})`];
	});
	const call = block(rows((x, i) => PERM_VALS[i]));
	return [...defs, `${name(0)} ${call[0]}`, ...call.slice(1)];
};
const PERM = (n) => PERM_RING(n, 1);
// 括りの関数 f の実体を n 個（欄の名前 k0 … の違う構造体）作る積と、それだけの行。
const PS_CALLS = (f, k, n) => [...Array(n).keys()].map((i) => `(${f} [${k}${i} : 1])`).join(" , ");
const PS_LINE = (n) => PS_CALLS("p", "k", n);
// 値だけを渡す別々の関数 p1 … pn の鎖（`pi : [a ~r] ? p(i+1) r`、pn は値を返す）。
const VALUE_CHAIN = (n) => [...Array(n).keys()].map((i) => `p${i + 1} : [a ~r] ? ${i + 1 < n ? `p${i + 2} r` : "a"}`);
// hb の本体が門に当たる実体（欄 s が無い）を n 個作る積と、通る実体（欄 s が関数）を n 個作る行。
const HB_GATED = (n) => [...Array(n).keys()].map((i) => `(hb [k${i} : 1] [z : 1])`).join(" , ");
const HB_PASS = (n) => [...Array(n).keys()].map((i) => `(hb [s : inc] [k${i} : 1])`).join(" , ");
// 同じ形で自分を引いてから枝ごとに形が増える再帰（作った実体の数の守りに当たる）。
const GROW_SELF = "g : [x ~xs] ? (g xs) , (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])";
// 閉包を欄に入れて次の関数へ渡す、別々の関数 p0 … p(n−1) の鎖（p(n−1) は欄の関数を呼ぶ）。
const CLOSURE_CHAIN = (n) => [...[...Array(n - 1).keys()].map((i) => `p${i} : [s] ? p${i + 1} [s : [y ? s y]]`), `p${n - 1} : [s] ? s 1`, "inc : x ? x + 1", "p0 [s : inc]"];
// 外れた仮置きの世界：f は q に (g x) と (h x) を欄で渡し、q は p の実体を n 個作る。g は f を呼んで最後の行 `[+ 1]`（L）で仮置きが
// 外れ、h は f と g を呼ぶ。g → h → f の順に解くと、f は g の仮置きの上・h の仮置きの上・確定した値の上の3回解かれる。
const WORLDS = (n) => [
	"g : x ?",
	"\tf x",
	"\t[+ 1]",
	"",
	"h : x ?",
	"\tf x",
	"\tg x",
	"",
	"f : x ? q [s : (g x)",
	"\tt : (h x)]",
	`q : [s t] ? ${[...Array(n).keys()].map((i) => `(p [w : s] [v : t] [k${i} : 1])`).join(" , ")}`,
	"p : [w] [v] [k] ? 1",
	"f 5",
];

// この表の `g 5 inc`・`f0 5 inc` の形（「隣と結べる」）は、閉じた適用の節が値（A）かを、後ろに関数を置いて見る行。2026-10-23 までは
// 後ろの inc が逆適用でその節を取り（`(apply inc (apply g 5) ·rev)`）、2026-10-24 の逆適用の廃止（R47）からは、inc は節の後ろに積まれて
// 余る（`(construct (apply g 5) (unit inc))`、根で `_`、R42・R48）。節が未知なら、どちらでも後ろの関数で G2(a)（R40 の読み6）なので、
// 見ている物は変わらない。最後の括りが受けている間に来た関数（`h 1 2 3 inc`）は合成の後ろで、木は入れ子の適用（`·rev` の綴りは無くなった）。
const answerPasses = [
	// R24 の例1（pattern_guide.md「IO Reader Writer」）。木の行は m・a・b・c・呼ぶ行の順。
	["R24 a m", src([...IO, "a m"]), "(apply a m)", "A"],
	["R24 a m の実体（本体は (apply say 21)）", src([...IO, "a m"]), "(: a (? [[say]] (inst {say:L other:N} (apply say 21))))", null, { at: 1 }],
	["R24 b m", src([...IO, "b m"]), "(apply b m)", "A"],
	["R24 b m の実体", src([...IO, "b m"]), "(: b (? [[say ~rest]] (inst {say:L other:N} (apply say 21))))", null, { at: 2 }],
	["R26 c m（rest ' say は欄 say の生まれ）", src([...IO, "c m"]), "(apply c m)", "A"],
	["R26 c m の実体", src([...IO, "c m"]), "(: c (? [[~rest]] (inst {say:L other:N} (apply [rest ' say] 21))))", null, { at: 3 }],
	// R24 の例2：利用者の基本の再帰。§6.3 では本体が G7 だった。xs は同じ要素の List なので、自分を同じ形で呼ぶ。
	["R24 f [1 2 3]", src([REC, "f [1 2 3]"]), "(apply f [1 2 3])", "A"],
	["R24 f [1 2 3] の実体（本体は (construct [f xs] x)）", src([REC, "f [1 2 3]"]), "(: f (? [[x ~xs]] (inst [N…] (construct [f xs] x))))", null, { at: 0 }],
	// 文字列の字面は List（String ≅ List(Char)）なので、同じ再帰で分解できる。形は [1 2 3] と同じ。
	["R24 f `abc`（文字列を List として分解する再帰）", src([REC, "f `abc`"]), "(apply f `abc`)", "A"],
	["R24 f `abc` の実体は [1 2 3] と同じ形", src([REC, "f `abc`"]), "(: f (? [[x ~xs]] (inst [N…] (construct [f xs] x))))", null, { at: 0 }],
	// R24 の例3：括りは1つで1と数える（function_guide.md「参照の取り方」）。
	["R24 pair [1 2 3] [10 20]", src(["pair : [a ~as] [b ~bs] ? a + b", "pair [1 2 3] [10 20]"]), "(apply pair (construct [1 2 3] [10 20]))", "A"],
	["R24 pair の実体（形は仮引数ごとに並べる）", src(["pair : [a ~as] [b ~bs] ? a + b", "pair [1 2 3] [10 20]"]), "(: pair (? [[a ~as] [b ~bs]] (inst [N…] [N…] (+ a b))))", null, { at: 0 }],
	// 最後の仮引数が括りの関数は、k > n なら前の仮引数に1つずつ当てて、残りの並び全体を最後の括りが受ける（R24、利用者
	// 2026-10-19「最後の仮引数が括りの関数は、前の仮引数に1つずつ当てて、残りの並び全体を最後の括りが受ける。」）。
	["R24 pair [1] [2] [3]（a は [1]、[b ~bs] は [2] [3]）", src(["pair : [a ~as] [b ~bs] ? a + b", "pair [1] [2] [3]"]), "(: pair (? [[a ~as] [b ~bs]] (inst N [N…] (+ a b))))", null, { at: 0 }],
	["R24 h 1 2 3（v は 1、[x ~xs] は 2 3）", src(["h : v [x ~xs] ? v 1", "h 1 2 3"]), "(: h (? [v [x ~xs]] (inst A [N…] (construct v 1))))", null, { at: 0 }],
	// 2026-10-24 の試し（R49）：裸の仮引数 f に渡った `$[* 2]` は関数を指す番地で、印ごと実体の鍵に入り、形は `$L`（前は `A`）。
	["R24 map $[* 2] 1 2 3 4 5 は map $[* 2] [1 2 3 4 5] と同じ実体", src(["map : f [x ~y] ? x", "map $[* 2] 1 2 3 4 5", "map $[* 2] [1 2 3 4 5]"]), "(: map (? [f [x ~y]] (inst $L [N…] x)))", null, { at: 0 }],
	// 最後の括りが受けている間に来た inc は合成の後ろ（R41）。木は入れ子の適用（2026-10-24 の R47 で `·rev` の綴りが無くなった。前は
	// `(apply inc (apply h (construct 1 2 3)) ·rev)`。下の `pair [1] [2] inc`・`f 1 2 3 inc` も同じ）。
	["R24 h 1 2 3 inc（残りを受けた節は隣と結べる）", src(["inc : x ? x + 1", "h : v [x ~xs] ? v 1", "h 1 2 3 inc"]), "(apply inc (apply h (construct 1 2 3)))", "A"],
	// 前の仮引数が2つ以上でも、左から1つずつ当てる（[a] は 1、[b ~bs] は [2 3]、[c ~cs] は 4 5）。残りを括った
	// `p3 1 [2 3] [4 5]` と同じ実体で、実体は1つ。前の当て方を逆にしたり、前に1つしか当てないと形が変わる。
	["R24 p3 1 [2 3] 4 5 は p3 1 [2 3] [4 5] と同じ実体（前の仮引数に左から1つずつ）", src(["p3 : [a] [b ~bs] [c ~cs] ? a + c", "p3 1 [2 3] 4 5", "p3 1 [2 3] [4 5]"]), "(: p3 (? [[a] [b ~bs] [c ~cs]] (inst N [N…] [N…] (+ a c))))", null, { at: 0 }],
	["R24 p3 1 [2 3] 4 5", src(["p3 : [a] [b ~bs] [c ~cs] ? a + c", "p3 1 [2 3] 4 5"]), "(apply p3 (construct 1 [2 3] 4 5))", "A"],
	// k < n は、素の関数と同じく部分適用（残り n − k の L）。残りが来た所で、当てた物と合わせて実体を作る（R24、利用者
	// 2026-10-19「括りの関数に実引数が足りないときも、素の関数と同じく部分適用（残りの仮引数を待つ関数）にする。」）。
	["R24 pair [1]（k < n は部分適用の L。行の根なので `_`、R42）", src(["pair : [a ~as] [b ~bs] ? a + b", "pair [1]"]), "(unit (apply pair [1]))", "A"],
	["R24 pair [1] だけでは実体を作らない", src(["pair : [a ~as] [b ~bs] ? a + b", "pair [1]"]), "(: pair (? [[a ~as] [b ~bs]] (defer {a + b})))", null, { at: 0 }],
	["R24 (pair [1]) [2] は pair [1] [2] と同じ実体", src(["pair : [a ~as] [b ~bs] ? a + b", "(pair [1]) [2]", "pair [1] [2]"]), "(: pair (? [[a ~as] [b ~bs]] (inst N N (+ a b))))", null, { at: 0 }],
	["R24 (pair [1]) [2]", src(["pair : [a ~as] [b ~bs] ? a + b", "(pair [1]) [2]"]), "(apply [pair [1]] [2])", "A"],
	["R24 名前を付けた部分適用 p1 : pair [1] の p1 [2]", src(["pair : [a ~as] [b ~bs] ? a + b", "p1 : pair [1]", "p1 [2]"]), "(apply p1 [2])", "A"],
	["R24 t3 1 2（n = 3 の k < n は部分適用の L。R42）", src(["t3 : u v [~r] ? u", "t3 1 2"]), "(unit (apply t3 (construct 1 2)))", "A"],
	["R24 t3 1 2 だけでは実体を作らない", src(["t3 : u v [~r] ? u", "t3 1 2"]), "(: t3 (? [u v [~r]] (defer {u})))", null, { at: 0 }],
	["R24 (t3 1 2) 3 4 は t3 1 2 3 4 と同じ実体（部分適用の残りも最後の括りが受ける）", src(["t3 : u v [~r] ? u", "(t3 1 2) 3 4", "t3 1 2 3 4"]), "(: t3 (? [u v [~r]] (inst A A [N…] u)))", null, { at: 0 }],
	["R24 ((t3 1) 2) [3]（部分適用の部分適用）", src(["t3 : u v [~r] ? u", "((t3 1) 2) [3]"]), "(apply [[t3 1] 2] [3])", "A"],
	["R24 pair [1] inc（部分適用の節は素の関数と同じく合成に入る。R42）", src(["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a + b", "pair [1] inc"]), "(unit (compose (apply pair [1]) inc))", "A"],
	// 部分適用の行だけで、残りが来た所に実体を作る（直の行を並べると、その行が実体を作るので、部分適用の側が何もしなくても
	// 上の「同じ実体」の行は合ってしまう。部分適用の確かめ 2026-10-19 の TG2・TG3）。
	["R24 (pair [1]) [2] だけで実体を作る", src(["pair : [a ~as] [b ~bs] ? a + b", "(pair [1]) [2]"]), "(: pair (? [[a ~as] [b ~bs]] (inst N N (+ a b))))", null, { at: 0 }],
	["R24 p1 [2] だけで実体を作る（名前を付けた部分適用）", src(["pair : [a ~as] [b ~bs] ? a + b", "p1 : pair [1]", "p1 [2]"]), "(: pair (? [[a ~as] [b ~bs]] (inst N N (+ a b))))", null, { at: 0 }],
	["R24 (t3 1 2) 3 4 だけで、残りを最後の括りが受ける実体を作る", src(["t3 : u v [~r] ? u", "(t3 1 2) 3 4"]), "(: t3 (? [u v [~r]] (inst A A [N…] u)))", null, { at: 0 }],
	["R24 (t3 1 2) 3 4", src(["t3 : u v [~r] ? u", "(t3 1 2) 3 4"]), "(apply [t3 1 2] (construct 3 4))", "A"],
	["R24 (pair [1]) [2] [3] だけで、残りを最後の括りが受ける実体を作る", src(["pair : [a ~as] [b ~bs] ? a + b", "(pair [1]) [2] [3]"]), "(: pair (? [[a ~as] [b ~bs]] (inst N [N…] (+ a b))))", null, { at: 0 }],
	// 部分適用の部分適用は、元の関数に当てた物を前から足していく（[~r] は [3 4] を受ける）。
	["R24 ((t3 1) 2) [3 4] の実体", src(["t3 : u v [~r] ? u", "((t3 1) 2) [3 4]"]), "(: t3 (? [u v [~r]] (inst A A [N…] u)))", null, { at: 0 }],
	// 当てた物の違う部分適用（`pair [1]` と `pair s`）を欄に入れて同じ括りの関数に渡したら、別の関数なので call の実体も
	// 別で、pair の実体は2つ。行の順に依らない（鍵に当てた物を入れないと、先に呼んだ方の実体を後の行が黙って使い回し、
	// pair の実体は1つになる。部分適用の確かめ 2026-10-19 の TG1）。
	["R24 当てた物の違う部分適用を欄で渡す（m1 が先）", src([...PAIR_FIELDS, "call m1", "call m2"]), PAIR_FIELDS_INST, null, { at: 1 }],
	["R24 当てた物の違う部分適用を欄で渡す（m2 が先）", src([...PAIR_FIELDS, "call m2", "call m1"]), PAIR_FIELDS_INST, null, { at: 1 }],
	// 裸の仮引数に当てた物は形に数えない（R24「裸の仮引数の位置は、形に数えない」）。`t2 1` と `t2 [1 2]` は同じ関数なので、
	// h の実体は1つ。括りの仮引数に当てた物は数えるので、`[u]` なら別の関数で2つ（部分適用の確かめ 2026-10-19 の F2）。
	["R24 裸の仮引数に当てた物の違う部分適用は同じ関数", src(["t2 : u [v] ? v", "h : [f] ? f [2]", "h [f : t2 1]", "h [f : t2 [1 2]]"]), "(: h (? [[f]] (inst {f:L} (apply f [2]))))", null, { at: 1 }],
	["R24 括りの仮引数に当てた物の違う部分適用は別の関数", src(["t2 : [u] [v] ? v", "h : [f] ? f [2]", "h [f : t2 1]", "h [f : t2 [1 2]]"]), "(: h (? [[f]] (inst {f:L} (apply f [2])) (inst {f:L} (apply f [2]))))", null, { at: 1 }],
	// 裸の仮引数に自分の欄を当て直す再帰は、同じ形で自分を呼ぶので有限（部分適用の鍵で裸の位置を A にしないと、鍵が1段ずつ
	// 深くなって G7）。
	["R24 裸の仮引数に部分適用を当て直す再帰", src(["inc : x ? x + 1", "t2 : u [v] ? v", "g : [f] ? g [f : t2 [f : f]]", "g [f : inc]"]), "(apply g [f : inc])", "A"],
	// 最後の仮引数が裸の k > n は、素の関数と同じく前から n 個を当てて余り（excess）。本体の根が A でなければ G12(b)（R24、
	// 利用者 2026-10-19「最後の仮引数が裸の括りの関数に多く渡したときは、素の関数と同じく前から n 個を当てて、余り（excess）にする。」）。
	["R24 tl 1 2 3（最後の仮引数が裸の k > n は余りを後ろに積む、R35）", src(["tl : [x ~xs] y ? x + y", "tl 1 2 3"]), "(construct (apply tl (construct 1 2)) 3)", "A", { leftover: true }],
	["R24 tl 1 2 3 の実体（前から n 個を当てる）", src(["tl : [x ~xs] y ? x + y", "tl 1 2 3"]), "(: tl (? [[x ~xs] y] (inst N A (+ x y))))", null, { at: 0 }],
	["R24 (tl 1) 2 3（部分適用の残りが多い）", src(["tl : [x ~xs] y ? x + y", "(tl 1) 2 3"]), "(construct (apply [tl 1] 2) 3)", "A", { leftover: true }],
	["R24 (tl 1) 2 3 の実体", src(["tl : [x ~xs] y ? x + y", "(tl 1) 2 3"]), "(: tl (? [[x ~xs] y] (inst N A (+ x y))))", null, { at: 0 }],
	["R24 [tl 1 2 3]（余りの節も括りの中の根なら通る）", src(["tl : [x ~xs] y ? x + y", "[tl 1 2 3]"]), "[tl 1 2 3]", "A"],
	// 当てるのは前から n 個（余りの確かめ 2026-10-19 の TG1・TG2・TG4）。実引数が全部数だと、どこから当てても鍵が `N A` に
	// 揃うので、形の違う実引数で見る。後ろから当てても1つずらしても、`tl [1 2] 3 4` の実体は `N A`、`h 1 [2 3] 4 5` の
	// 実体は `A N A` になる。部分適用は、当てた物（bound）を前に置いて元の関数の実体を作る。
	["R24 tl [1 2] 3 4 の実体（前から n 個）", src(["tl : [x ~xs] y ? x + y", "tl [1 2] 3 4"]), "(: tl (? [[x ~xs] y] (inst [N…] A (+ x y))))", null, { at: 0 }],
	["R24 h 1 [2 3] 4 5 の実体（前から n 個）", src(["h : u [x] v ? u + x + v", "h 1 [2 3] 4 5"]), "(: h (? [u [x] v] (inst A [N…] A (+ (+ u x) v))))", null, { at: 0 }],
	["R24 (tl [1 2]) 3 4 の実体（当てた物が前）", src(["tl : [x ~xs] y ? x + y", "(tl [1 2]) 3 4"]), "(: tl (? [[x ~xs] y] (inst [N…] A (+ x y))))", null, { at: 0 }],
	// k > n なら k の大きさに依らず同じ読み（素の関数の d 1 2 と同じ）。
	["R24 tl 1 2 3 4（k = n + 2 も余り）", src(["tl : [x ~xs] y ? x + y", "tl 1 2 3 4"]), "(construct (apply tl (construct 1 2)) 3 4)", "A", { leftover: true }],
	// k = n の括りの関数の節は余りではない（TG5。excess は k > n だけ）。最後の括りが受けている間に来た inc は合成の後ろ（R41）。
	// 前（2026-10-23 まで）は「逆適用の左に置ける」と見ていて、木は `·rev` の綴り。
	["R24 pair [1] [2] inc（k = n の節は余りでない）", src(["inc : z ? z + 1", "pair : [a ~as] [b ~bs] ? a + b", "pair [1] [2] inc"]), "(apply inc (apply pair (construct [1] [2])))", "A", { leftover: false }],
	// 括りが1つの関数は、並び全体を1つの List として受ける（R24、利用者 2026-10-19「それでいいよ」）。
	["R24 n 1 2 3 は n [1 2 3] と同じ実体", src(["n : [~x] ? x", "n 1 2 3", "n [1 2 3]"]), "(: n (? [[~x]] (inst [N…] x)))", null, { at: 0 }],
	["R24 f 1 2 3（x は頭の数）", src(["f : [x ~xs] ? x 1", "f 1 2 3"]), "(: f (? [[x ~xs]] (inst [N…] (construct x 1))))", null, { at: 0 }],
	["R24 Zipper の f 1 2 3（pattern_guide）", src(["f : [~a] ? a ' 0 + a ' 2 + a ' 3", "f 1 2 3"]), "(apply f (construct 1 2 3))", "A"],
	["R24 f 1 2 3 inc（並び全体を受けた節は隣と結べる）", src(["inc : x ? x + 1", "f : [x ~xs] ? x 1", "f 1 2 3 inc"]), "(apply inc (apply f (construct 1 2 3)))", "A"],
	// 並び全体を受けても、実体の本体の根が A でなければ適用の節は未知（R24。k = n と同じ読みで、G12(b) にしない）。前は本体の根が
	// L の `gi : [x ~xs] ? inc` で見ていたが、根が L の実体は G16（R33）になったので、根が未知の `[,] x` で見る。
	["R24 gi 1 2（実体の本体の根が A でなければ未知の根）", src(["gi : [x ~xs] ? [,] x", "gi 1 2"]), "(apply gi (construct 1 2))", "未知"],
	["R24 gi 1 2 の実体（本体の根は未知）", src(["gi : [x ~xs] ? [,] x", "gi 1 2"]), "(: gi (? [[x ~xs]] (inst [N…] (apply [,] x))))", null, { at: 0 }],
	// 撒く項を含む並びは k を数えない（R24）ので、括り1つの関数でも並び全体を受けず、未知の根で実体を作らない。括った
	// `n [vs~ 1]` は撒く項を含む器を1つ渡す形で、別の読み（R24 の「構造体とも List とも読めないが中身の見える器」）。
	["R24 n vs~ 1（撒く項を含む並びは未知の根）", src(["n : [~x] ? x", "vs : 1 , 2", "n vs~ 1"]), "(apply n (construct vs~ 1))", "未知"],
	["R24 n 4 vs~ 5 では実体を作らない", src(["n : [~x] ? x", "vs : 1 , 2", "n 4 vs~ 5"]), "(: n (? [[~x]] (defer {x})))", null, { at: 0 }],
	// R25：呼ばれない括りの関数は、本体を書いたまま残して断らない。読まないので、本体の未定義の名前も information を出さない。
	// §6.3 の「hello : [say] ? say Hello World の本体」「f : [x ~xs] ? [f xs] x の本体」（G7）をここへ移した。
	["R25 hello : [say] ? say Hello World だけ", "hello : [say] ? say Hello World", "(: hello (? [[say]] (defer {say Hello World})))", null, { diagCount: 0 }],
	["R25 #hello（公開しても同じ）", "#hello : [say] ? say Hello World", "(: #hello (? [[say]] (defer {say Hello World})))", null, { diagCount: 0 }],
	["R25 f : [x ~xs] ? [f xs] x だけ", REC, "(: f (? [[x ~xs]] (defer {[f xs] x})))", null],
	["R25 標準の定義と hello（§6.3 の行）", std("hello : [say] ? say Hello World"), "(: hello (? [[say]] (defer {say Hello World})))", null, { diagCount: 0 }],
	["R25 字下げの本体の defer", src(["t : [a] ?", "\ta", "\t5", ""]), "(: t (? [[a]] (defer {a ⏎ 5})))", null],
	// 実体の本体の中の未定義の名前は、今までどおり1回だけ information を出す。
	["R25 実体の本体の未定義の名前", src(["k : [x ~xs] ? zz x", "k [1 2]", "k `ab`"]), "(apply k `ab`)", "A", { diag: "zz", diagCount: 1 }],
	// Zipper の map（pattern_guide.md）。f は裸の仮引数なので A、[x ~y] は List。map f y は同じ形で自分を呼ぶ。
	["R24 map $[* 2] [1 2 3 4 5]", src(["map : f [x ~y] ? (@f x) , (map f y)", "map $[* 2] [1 2 3 4 5]"]), "(apply map (construct $[* 2] [1 2 3 4 5]))", "A"],
	// 2026-10-24 の試し（R49）：f は `$[* 2]` を指す番地の印を持つ（形 `$L`。前は `A`）。`@f x` は `[* 2] x` で A、`map f y` は同じ印の f で
	// 同じ実体（前は `@f x` が前置 `@` の項で未知）。
	["R24 map の実体", src(["map : f [x ~y] ? (@f x) , (map f y)", "map $[* 2] [1 2 3 4 5]"]), "(: map (? [f [x ~y]] (inst $L [N…] (, [@f x] [map f y]))))", null, { at: 0 }],
	// D 97749496 の greeting。欄 greet は構造体で、その欄 welcome が関数なら (greet ' welcome) world は適用、文字列なら構築。
	["R24・R26 greeting myGreet（welcome が関数）", src([...MY_GREET_FN, GREETING, "greeting myGreet"]), "(apply greeting myGreet)", "A"],
	[
		"R24・R26 greeting の実体（welcome が関数）",
		src([...MY_GREET_FN, GREETING, "greeting myGreet"]),
		"(: greeting (? [[greet world]] (inst {greet:{hello:L welcome:L} world:[N…]} (apply [greet ' welcome] world))))",
		null,
		{ at: 1 },
	],
	[
		"R24・R26 greeting の実体（example.sn のまま、welcome が文字列）",
		src([...MY_GREET_STR, GREETING, "greeting myGreet"]),
		"(: greeting (? [[greet world]] (inst {greet:{hello:[N…] welcome:[N…]} world:[N…]} (construct [greet ' welcome] world))))",
		null,
		{ at: 1 },
	],
	// R26：裸の名前の鍵の鎖（example.sn）。引いた物は文字列なので、`==` の両辺が A。
	["R26 myGreet ' greet ' hello == `hello,`", src([...MY_GREET_STR, "myGreet ' greet ' hello == `hello,`"]), "(== (' (' myGreet greet) hello) `hello,`)", "A"],
	// 括った `?` も括りの関数。
	["R24 [[say] ? say 21] m", src([...M, "[[say] ? say 21] m"]), "(apply [[say] ? say 21] m)", "A"],
	// 入れ子の関数の本体の中の括りの関数。外の仮引数 v は、実体の範囲の外側から引く。
	["R24 素の関数の本体の中の括りの関数", src([...M, "outer : v ? [[say] ? say v] m", "outer 21"]), "(apply outer 21)", "A"],
	[
		"R24 実体の本体の中の括りの関数",
		src([...M, "a : [say] ? [[other] ? say other] m", "a m"]),
		"(: a (? [[say]] (inst {say:L other:N} (apply [[other] ? say other] m))))",
		null,
		{ at: 1 },
	],
	// 標準の定義の n（`n : [~x] ? x`）は、k = n なら実体を作る（§6.3 の n 1 2 3 も、括りが1つなので並び全体を受けて A）。
	["R24 n vs（標準の定義の n、k = n）", std("n vs"), "(apply n vs)", "A"],
	// 構造体の ~rest は受けなかった欄の構造体。そこから欄を引ける（R26）。
	["R24・R26 [say ~r] ? r ' other", src([...M, "h2 : [say ~r] ? r ' other", "h2 m"]), "(: h2 (? [[say ~r]] (inst {say:L other:N} (' r other))))", null, { at: 1 }],
	// List の要素の形は長さに依らない。
	["R24 要素の List の長さは形に入らない", src(["f : [x ~xs] ? x", "f [[1 2] [3 4 5]]"]), "(: f (? [[x ~xs]] (inst [[N…]…] x)))", null, { at: 0 }],
	// R26：引いた物が関数なら L。点なしの [' k] も同じ（下の法則で両方の綴りを比べる）。
	// 裸の名前の鍵は欄の名前で、名前として引かない（say はファイルの定義に無いが、information を出さない）。
	// 引いた関数は L。行の根に残ったので `_`（R42。木は `(unit …)` で包む）。
	// 診断は、根に余った引いた関数の leftover-lambda（R48、2026-10-24）の1つだけ。鍵の say の undefined-name は出さない（前は diagCount 0 で見ていた）。
	["R26 m ' say は L（R42）", src([...M, "m ' say"]), "(unit (' m say))", "A", { diagCount: 1, leftoverDiag: ["(' m say)"] }],
	["R26 [' say] m は L（R42）", src([...M, "[' say] m"]), "(unit (apply [' say] m))", "A", { diagCount: 1, leftoverDiag: ["(apply [' say] m)"] }],
	["R26 (m ' say) 21", src([...M, "(m ' say) 21"]), "(apply [m ' say] 21)", "A"],
	["R26 vs ' 0", std("vs ' 0"), "(' vs 0)", "A"],
	// R26 の外の鍵は今までどおり未知（根なら通る）。
	["R26 m ' 0（構造体に整数の鍵）は未知", src([...M, "m ' 0"]), "(' m 0)", "未知"],
	["R26 vs ' say（List に名前の鍵）は未知", std("vs ' say"), "(' vs say)", "未知"],
	["R26 m @ say は未知", src([...M, "m @ say"]), "(@ m say)", "未知"],
	// 数と、数だけを括った `[3]` は、長さ1の List として受ける（R24、利用者 2026-10-19「それでいいはずだよ」）。
	// 名前はその数、`~rest` は同じ要素の List。数でない中身の見えない A（裸の仮引数・`$` の番地・範囲）は持ち上げない。
	["R24 f [3]（長さ1の括りは長さ1の List）", src(["f : [x ~xs] ? x 1", "f [3]"]), "(apply f [3])", "A"],
	["R24 f [3] の実体", src(["f : [x ~xs] ? x 1", "f [3]"]), "(: f (? [[x ~xs]] (inst N (construct x 1))))", null, { at: 0 }],
	["R24 f 3（数は長さ1の List）", src(["f : [x ~xs] ? x 1", "f 3"]), "(apply f 3)", "A"],
	["R24 f -3（負の数の字面）", src(["f : [x ~xs] ? x 1", "f -3"]), "(apply f -3)", "A"],
	["R24 f 1 + 2（数どうしの値の演算子は数）", src(["f : [x ~xs] ? x 1", "f 1 + 2"]), "(apply f (+ 1 2))", "A"],
	// 値の印を当てた数（数の確かめ 2026-10-19 の F5）。前置 `-` は括り・名前・`_` の前でだけ印になる（`-3` は数の字面）。
	["R24 f -y（名前の数に値の印）", src(["y : 3", X1, "f -y"]), X1_INST, null, { at: 1 }],
	["R24 f -[3]（数だけの括りに値の印）", src([X1, "f -[3]"]), X1_INST, null, { at: 0 }],
	["R24 f !!1（ビット反転）", src([X1, "f !!1"]), X1_INST, null, { at: 0 }],
	["R24 f 3!（後置 !）", src([X1, "f 3!"]), X1_INST, null, { at: 0 }],
	// 値の演算子の段ごとの代表（数の確かめ 2026-10-19 の F6）。段14 は上の `f 1 + 2`。
	["R24 f 1 < 2（段13）", src([X1, "f 1 < 2"]), X1_INST, null, { at: 0 }],
	["R24 f 2 * 3（段15）", src([X1, "f 2 * 3"]), X1_INST, null, { at: 0 }],
	["R24 f 2 ^ 3（段16）", src([X1, "f 2 ^ 3"]), X1_INST, null, { at: 0 }],
	["R24 f 1 << 2（段19）", src([X1, "f 1 << 2"]), X1_INST, null, { at: 0 }],
	["R24 f 1 && 2（段22）", src([X1, "f 1 && 2"]), X1_INST, null, { at: 0 }],
	// 文字は Int と同じ扱いの数（README の法則 B）、`0r`・`0b` は符号なしの数（UInt）。名前の定義の右辺が数なら、名前を
	// 通して数（§2「名前を通して中身を見る」。数の確かめ 2026-10-19 の F8）。
	["R24 f \\a（文字の字面）", src([X1, "f \\a"]), X1_INST, null, { at: 0 }],
	["R24 f 0u0041（文字の字面）", src([X1, "f 0u0041"]), X1_INST, null, { at: 0 }],
	["R24 f 0r18（符号なしの数の字面）", src([X1, "f 0r18"]), X1_INST, null, { at: 0 }],
	["R24 f x0（x0 : 3）", src(["x0 : 3", X1, "f x0"]), X1_INST, null, { at: 1 }],
	["R24 f x0（x0 : [3]）", src(["x0 : [3]", X1, "f x0"]), X1_INST, null, { at: 1 }],
	["R24 f x0（x0 : -y）", src(["y : 3", "x0 : -y", X1, "f x0"]), X1_INST, null, { at: 2 }],
	["R24 g 3 の再帰（数と、残りの List の2つの実体）", src(["g : [x ~xs] ? [g xs] x", "g 3"]), "(: g (? [[x ~xs]] (inst N (construct [g xs] x)) (inst [N…] (construct [g xs] x))))", null, { at: 0 }],
	["R24 数の要素をもう一度括りで受ける", src(["p : [x ~xs] ? q x", "q : [y] ? y 5", "p [1 2]"]), "(apply p [1 2])", "A"],
	// 数を `~rest` で受けた物は R24 の List なので、R26 で要素を引ける（数そのものから引く形は断る側、下の「答え」の断る行）。
	["R26 数の ~rest から引く", src(["h : [~r] ? (r ' 0) 1", "h 5"]), "(apply h 5)", "A"],
	// 2行以上の値の字下げのブロックは、括りと同じ List（1行が1要素。利用者 2026-10-19「それでいいよ」）。
	["R24 2行の値の字下げのブロックは List", src(["sh : [x ~xs] ? x 1", "w :", "\t1", "\t2", "", "sh w"]), "(apply sh w)", "A"],
	["R24 2行の値の字下げのブロックの実体", src(["sh : [x ~xs] ? x 1", "w :", "\t1", "\t2", "", "sh w"]), "(: sh (? [[x ~xs]] (inst [N…] (construct x 1))))", null, { at: 0 }],
	// 1行が1要素：構築の行は平らにせず、その行が要素（要素は数の List）。下の「法則」で括りの綴りと比べる。
	["R24 構築の行の字下げのブロック", src(BLOCK_ROWS), "(apply f w)", "A"],
	["R24 構築の行の字下げのブロックの実体（1行が1要素）", src(BLOCK_ROWS), "(: f (? [[x ~xs]] (inst [[N…]…] (construct [x ' 0] 1))))", null, { at: 0 }],
	// 欄の値の2行のブロックも List（構造体の欄 k は、その生まれの数の List）。
	["R24 欄の値の2行の字下げのブロック", src(BLOCK_NESTED), "(apply g w)", "A"],
	["R24 欄の値の2行の字下げのブロックの実体", src(BLOCK_NESTED), "(: g (? [[k]] (inst {k:[N…] other:N} (apply h k))))", null, { at: 0 }],
	// 合成の中の括りの関数も実体を作る（§5 Q24 の案1、利用者 2026-10-19「とりあえず案1を採用して、強化したり追跡できるなら、
	// また考えてみよう。」）。合成は左から実行する（R11）ので、最初の関数が並びを受け、後ろの関数は前の結果（中身の見えない A）を受ける。
	["Q24 head inc [5 6 7]（合成の頭の括りの関数）", src(["inc : x ? x + 1", "head : [x ~xs] ? x", "head inc [5 6 7]"]), "(apply (compose head inc) [5 6 7])", "A"],
	["Q24 head inc [5 6 7] の実体", src(["inc : x ? x + 1", "head : [x ~xs] ? x", "head inc [5 6 7]"]), "(: head (? [[x ~xs]] (inst [N…] x)))", null, { at: 1 }],
	["Q24 head inc [5 6 7] と head [5 6 7] は同じ実体", src(["inc : x ? x + 1", "head : [x ~xs] ? x", "head inc [5 6 7]", "head [5 6 7]"]), "(: head (? [[x ~xs]] (inst [N…] x)))", null, { at: 1 }],
	["Q24 head inc [5 6 7] double（合成の適用の節は隣と結べる）", src(["inc : x ? x + 1", "double : x ? x * 2", "head : [x ~xs] ? x", "head inc [5 6 7] double"]), "(apply double (apply inc (apply head [5 6 7])))", "A"],
	["Q24 [pair [1]] inc [2]（合成の頭の部分適用）", src(["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a + b", "(pair [1]) inc [2]"]), "(: pair (? [[a ~as] [b ~bs]] (inst N N (+ a b))))", null, { at: 1 }],
	["Q24 inc head [5 6 7]（後ろの括りの関数は前の結果を受ける）", src(["inc : x ? x + 1", "head : [x ~xs] ? x", "inc head [5 6 7]"]), "(: head (? [[x ~xs]] (inst A x)))", null, { at: 1 }],
	["Q24 inc head [5 6 7] の根は未知（head の本体の根が未知）", src(["inc : x ? x + 1", "head : [x ~xs] ? x", "inc head [5 6 7]"]), "(apply (compose inc head) [5 6 7])", "未知"],
	// 合成の後ろの部分適用（§5 Q26 の案1、利用者 2026-10-19「合成の後ろの素の関数の部分適用も、残り1つで本体の根が A なら
	// A に数える。」）。括りの関数の部分適用と同じ読みにする。
	["Q26 inc (pr 1) 5（素の部分適用が合成の後ろ）", src(["inc : x ? x + 1", "pr : x y ? y", "inc (pr 1) 5"]), "(apply (compose inc [pr 1]) 5)", "A"],
	["Q26 inc (pr 1) 5 inc", src(["inc : x ? x + 1", "pr : x y ? y", "inc (pr 1) 5 inc"]), "(construct (apply (compose inc [pr 1]) 5) (unit inc))", "A"],
	["Q26 名前を付けた部分適用 p1 : pr 1 の inc p1 5 inc", src(["inc : x ? x + 1", "pr : x y ? y", "p1 : pr 1", "inc p1 5 inc"]), "(construct (apply (compose inc p1) 5) (unit inc))", "A"],
	["Q26 inc (pr [1]) 5（括りの部分適用が合成の後ろ）", src(["inc : x ? x + 1", "pr : [x ~xs] y ? y", "inc (pr [1]) 5"]), "(apply (compose inc [pr [1]]) 5)", "A"],
	["Q26 inc (pr [1]) 5 の実体", src(["inc : x ? x + 1", "pr : [x ~xs] y ? y", "inc (pr [1]) 5"]), "(: pr (? [[x ~xs] y] (inst N A y)))", null, { at: 1 }],
	// 残りが2つ以上の部分適用は、前は合成の後ろで未知（§5 Q13）。流れ（R36）では、残りの口が流れに足りれば A、足りなければ L。
	["Q26 inc (f3 1) 5（残り2つで足りない、L。前は未知。根なので `_`、R42）", src(["inc : x ? x + 1", "f3 : a b c ? c", "inc (f3 1) 5"]), "(unit (apply (compose inc [f3 1]) 5))", "A"],
	// 後ろの `(f3 1)` が並びの 6 を受けたので、木は各関数が受けた物の見える入れ子の適用（R40、§1.3）。
	["Q26 inc (f3 1) 5 6（`f3 1 (inc 5) 6`。木は入れ子、R40）", src(["inc : x ? x + 1", "f3 : a b c ? c", "inc (f3 1) 5 6"]), "(apply [f3 1] (construct (apply inc 5) 6))", "A"],
	// 穴の書き換えとその部分適用を後ろに置く形は、Q26 の答えの時は決めずに未知にしていた（利用者の言葉ではなく、表を作った
	// 側の慎重さ）。合成を適用の畳み込みにした（(g∘f) x = g (f x)、R11。2026-10-19「その方向でお願い」）ので、直接書いた
	// `[add _ 10] (inc 5)` と同じく A。穴の部分適用も、同じ関数を穴で直接書いた `[f3 1 _ 3] (inc 5)` と同じ読みで A。
	["法則で変わった inc [add _ 10] 5（穴、前は未知）", src(["inc : x ? x + 1", "add : x y ? x + y", "inc [add _ 10] 5"]), "(apply (compose inc [add _ 10]) 5)", "A"],
	["法則で変わった inc ([f3 _ _ 3] 1) 5（穴の部分適用、前は未知）", src(["inc : x ? x + 1", "f3 : a b c ? c", "inc ([f3 _ _ 3] 1) 5"]), "(apply (compose inc [[f3 _ _ 3] 1]) 5)", "A"],
	["法則で変わった h2 : h1 1（h1 : f3 _ _ 3）の inc h2 5（前は未知）", src(["inc : x ? x + 1", "f3 : a b c ? c", "h1 : f3 _ _ 3", "h2 : h1 1", "inc h2 5"]), "(apply (compose inc h2) 5)", "A"],
	// 前は未知の節で、隣と結べば G2(a) だった。後ろの inc は、2026-10-23 までは逆適用で節を取り、R47 から積まれて余る（表の頭の注）。
	["法則で変わった inc [add _ 10] 5 inc（前は G2(a)）", src(["inc : x ? x + 1", "add : x y ? x + y", "inc [add _ 10] 5 inc"]), "(construct (apply (compose inc [add _ 10]) 5) (unit inc))", "A"],
	["法則で変わった inc ([f3 _ _ 3] 1) 5 inc（前は G2(a)）", src(["inc : x ? x + 1", "f3 : a b c ? c", "inc ([f3 _ _ 3] 1) 5 inc"]), "(construct (apply (compose inc [[f3 _ _ 3] 1]) 5) (unit inc))", "A"],
	["法則で変わった h2 : h1 1 の inc h2 5 inc（前は G2(a)）", src(["inc : x ? x + 1", "f3 : a b c ? c", "h1 : f3 _ _ 3", "h2 : h1 1", "inc h2 5 inc"]), "(construct (apply (compose inc h2) 5) (unit inc))", "A"],
	// 穴の本体の根は元の関数のもの。根が A でなければ、直接書いた `[pq _ 1] (inc 5)` と同じく未知のまま。
	// 前は根が L の `pq : x y ? inc` で見ていたが、根が L の関数は G16（R33）なので、根が未知の `[,] y` で見る。
	["守り inc [pq _ 1] 5（穴の元の関数の根が未知なら未知）", src(["inc : x ? x + 1", "pq : x y ? [,] y", "inc [pq _ 1] 5"]), "(apply (compose inc [pq _ 1]) 5)", "未知"],
	// 最初の関数が余れば印 `excess`（後ろに素の部分適用があっても落とさない）。確かめ 2026-10-19 の T2。
	["Q26 inc (pr 1) 5 6（流れの余りは後ろに積む、R36）", src(["inc : x ? x + 1", "pr : x y ? y", "inc (pr 1) 5 6"]), "(construct (apply (compose inc [pr 1]) 5) 6)", "A", { leftover: true }],
	// 後ろの関数が2つ以上でも、全部を見る（位置に依らない）。確かめ 2026-10-19 の T3。
	["Q26 inc double (pr 1) 5 inc（後ろの2つ目）", src(["inc : x ? x + 1", "double : x ? x * 2", "pr : x y ? y", "inc double (pr 1) 5 inc"]), "(construct (apply (compose inc double [pr 1]) 5) (unit inc))", "A"],
	["Q26 inc (pr 1) double 5 inc（後ろの1つ目）", src(["inc : x ? x + 1", "double : x ? x * 2", "pr : x y ? y", "inc (pr 1) double 5 inc"]), "(construct (apply (compose inc [pr 1] double) 5) (unit inc))", "A"],
	// 元の関数の根が仮置きで決まる再帰の部分適用（§3.4 の再帰の仮置き）。確かめ 2026-10-19 の F3。
	["Q26 自己再帰 r1 : x y ? inc (r1 1) y の r1 1 2", src(["inc : x ? x + 1", "r1 : x y ? inc (r1 1) y", "r1 1 2"]), "(apply r1 (construct 1 2))", "A"],
	["Q26 相互再帰 a1・b1 の a1 1 2", src(["inc : x ? x + 1", "a1 : x y ? inc (b1 1) y", "b1 : x y ? inc (a1 1) y", "a1 1 2"]), "(apply a1 (construct 1 2))", "A"],
	["Q26 名前を通す再帰 p1 : rp 1 の rp 1 2", src(["inc : x ? x + 1", "p1 : rp 1", "rp : x y ? inc p1 y", "rp 1 2"]), "(apply rp (construct 1 2))", "A"],
	["Q26 仮置きが外れる再帰 r2 1 2 は未知", src(["inc : x ? x + 1", "r2 : x y ?", "\tinc (r2 1) y", "\tinc", "", "r2 1 2"]), "(apply r2 (construct 1 2))", "未知"],
	// 合成の後ろの根は、ここまでが A のときだけ引く。使わない根を引くと、仮置き（解いている途中の f）が外れたとき、それに
	// 依らない g の根まで未知に替わり、定義の順で答えが割れていた。どちらの順でも A。確かめ 2026-10-19 の F1（反証）。
	// 前は根が L の `adder : m ? [+ m]`（§5 Q21）で見ていたが、根が L の関数は G16（R33）なので、根が未知の uu で見る。
	["Q26 g : y ? (uu (f 1) y) , 1（f が先）の g 5 inc", src(["inc : x ? x + 1", "uu : m ? [,] m", "f : x y ?", "\tg y", "\tinc", "", "g : y ? (uu (f 1) y) , 1", "g 5 inc"]), "(construct (apply g 5) (unit inc))", "A"],
	["Q26 g : y ? (uu (f 1) y) , 1（g が先）の g 5 inc", src(["inc : x ? x + 1", "uu : m ? [,] m", "g : y ? (uu (f 1) y) , 1", "f : x y ?", "\tg y", "\tinc", "", "g 5 inc"]), "(construct (apply g 5) (unit inc))", "A"],
	// `inc y` は中身の見えない A なので、後ろの `[+]` に1項で未知になり、f1 の根を引かない（R31 の1項。R31 の前は `[+]` に1項が
	// いつも未知、Q17）。
	["Q26 g : y ? (inc [+] f1 y) , 1（f1 が先、素の関数）の g 5 inc", src(["inc : x ? x + 1", "f1 : y ?", "\tg y", "\tinc", "", "g : y ? (inc [+] f1 y) , 1", "g 5 inc"]), "(construct (apply g 5) (unit inc))", "A"],
	// 畳まない `[<<]` に1項は足りない適用（R32）で、同じく f1 の根を引かない。
	["R32 g : y ? (inc [<<] f1 y) , 1（f1 が先）の g 5 inc", src(["inc : x ? x + 1", "f1 : y ?", "\tg y", "\tinc", "", "g : y ? (inc [<<] f1 y) , 1", "g 5 inc"]), "(construct (apply g 5) (unit inc))", "A"],
	// §5 Q28（2026-10-20、外れた仮置きに頼った答えは未知に替えず、確定した値で解き直す）。並べ方で割れた形は法則の試験
	// （coproduct_laws.test.js の Q28_FORMS）が見る。ここに置くのは、並べ方では割れないのに、前は同じ割れの悪い側に倒れていた
	// 形（どれも前は断るか未知。確かめ 2026-10-20 の並べ替えの確かめで見つかった）。g の根は積なので f の根に依らず A。
	// 値の定義（§6.4 の1 の2：値の名前を先に解く）が f を先に解かせるので、行の順に依らず前は G2(a)。
	["Q28 v : f 1 が f を先に解かせても g の根は積で A", src(["inc : x ? x + 1", "v : f 1", "f : x ?", "\tg x", "\tinc", "", "g : x ? (f x) , 1", "g 5 inc"]), "(construct (apply g 5) (unit inc))", "A"],
	// 呼ばれない素の関数 f の本体の根を先に解く（§6.4 の1 の3）と、h の実体が輪（h → k → g → h）の頭になって仮置きが外れ、
	// それに頼った g の実体（形 N）の根が未知に替わっていた（f を消すと前も A。呼ばれない定義が、ほかの行の答えを変えていた）。
	// k の本体は前は `[+ [g x]]`（g の仮置きの上で根が L）だったが、根が L の実体は G16（R33）なので、g を引いて根が未知の
	// `[,] [g x]` にした（h の実体の根が A でないのは同じ）。
	["Q28 呼ばれない f : x ? (g x) , 1 があっても g [5] inc は A", src(["inc : x ? x + 1", "f : x ? (g x) , 1", "g : [x ~xs] ? (h [s : k]) , 1", "h : [s] ? s 1", "k : [x ~xs] ? [,] [g x]", "g [5] inc"]), "(apply inc (apply g [5]))", "A"],
	// 合成と、直接書いた入れ子（`inc (f [1 2])`、前も A）が同じ読み（R11）。前は合成の側だけ未知だった。
	// g の本体は前は `[+ [f x]]`（根が L）だったが、根が L の関数は G16（R33）なので、f を引いて根が未知の `[,] [f x]` にした。
	["Q28 inc f [1 2] は inc (f [1 2]) と同じく A", src(["inc : x ? x + 1", "h : [s] ? s 1", "f : [x ~xs] ? (h [s : g]) , 1", "g : x ? [,] [f x]", "inc f [1 2]"]), "(apply (compose inc f) [1 2])", "A"],
	// 実体の深さの守り（SC-1）：素の関数を挟む鎖。hb の形はどれも {s:L}（f1 … はファイルの定義なので深さ 1 の葉）で、深く
	// ならない。前は f0 を先に置くと、f0 → hb の実体 → f1 → … と積んだ枠の hb の実体を全部数え、34 個の関数で 32 段に達して
	// f0 の根が黙って未知になり、`f0 5 inc` が G2(a) だった（逆順なら A。逆順と並べ替えは法則の試験が見る）。
	["深さ 素の関数を挟む hb の 34 個の鎖（f0 が先）", src(["inc : x ? x + 1", ...HB_CHAIN(34), "f0 5 inc"]), "(construct (apply f0 5) (unit inc))", "A"],
	// 入れ子の数の守りも、素の関数の本体を解く間は数え直す（INSTANCE_DEPTH_MARGIN の注の4。df43d0d7 の stretchOf と同じ所で切る）。
	// 前（2026-10-20 のまとめ直しから dde5ec8d まで）は、hb の実体が 257 個入れ子になる所で instance-nest-limit だった（確かめ
	// 2026-10-20 の6回目）。df43d0d7 も通す（hb の確定した実体が 512 個を超えると総数の G7）。
	["深さ 素の関数を挟む hb の 300 個の鎖", src(["inc : x ? x + 1", ...HB_CHAIN(300), "f0 5 inc"]), "(construct (apply f0 5) (unit inc))", "A"],
	// 守り：31 段の入れ子の字面（形の深さ 32）は、浅い呼び出しが先でも通る（上限を固定の 32 にしていた間の、上限ちょうど）。
	["深さ 31 段の入れ子の字面（形の深さ 32）は浅い呼び出しが先でも通る", src(["p : [a] ? p a", "a2 : p [a : 1]", `b : p ${NEST(31)}`, "b"]), "b", "A"],
	// 守り：輪と入れ子の鎖（ROT）の 30 段・31 段（形の深さ 31・32）は通る。31 段は、前の守り（実体の入れ子のいちばん長い道
	// 33 個）では G7 だった。形は深くならず、実体は有限に収まる（入れ替えの輪は2つの形を行き来し、剥がす鎖は1段ずつ浅くなる）
	// ので、通るのが鍵の深さの守りの答え（2026-10-20）。
	["深さ 輪と入れ子の鎖の 30 段は通る", src([...ROT, ...ROT_DEF("bb", 30), ...ROT_DEF("cc", 15), "bb"]), "bb", "A"],
	["深さ 輪と入れ子の鎖の 31 段（形の深さ 32）は通る", src([...ROT, ...ROT_DEF("bb", 31), ...ROT_DEF("cc", 15), "bb"]), "bb", "A"],
	["深さ 輪と入れ子の鎖の 31 段（形の深さ 32、浅い呼び出しが先）は通る", src([...ROT, ...ROT_DEF("cc", 15), ...ROT_DEF("bb", 31), "bb"]), "bb", "A"],
	// 欄 5 つの並べ替え（形 120 通り、深さは同じ）は、実体が有限に収まるので通る。前の守り（同じ `?` の実体の入れ子 32）では、
	// 深さ優先の入れ子が 32 段を超えて G7 だった。
	["深さ 欄 5 つの並べ替えの再帰は通る", src(PERM(5)), "(apply r [a : 1 ⏎ b : [1 2] ⏎ c : [z : 1] ⏎ d : [y : 1] ⏎ e : [x : 1]])", "A"],
	// 門で見る深さは括りに当てた物だけ（関数を書いた所の深さは入れない）。31 段の字面（深さ 32）を受けた実体の中で書いた括りの
	// 関数に数を渡すのは、深さ 1（確かめ 2026-10-20。書いた所の深さを入れると 33 段で断っていた）。
	["深さ 深い実体の中で書いた括りの関数に数を渡す", src(["p : [a] ? [[b] ? b] [1]", `p ${NEST(31)}`]), `(apply p ${NEST(31)})`, "A"],
	// 閉包を欄に入れて次の関数へ渡す別々の関数の鎖：閉包は書いた所の実体と同じ段なので、関数1つごとに欄の1段だけ深くなる。
	// 上限は括りの関数の数で上がるので何個でも通る（上限を固定の 32 にしていた間は、32 個で G7。下の「答え」の 40 個の行）。
	["深さ 閉包を欄で渡す別々の関数の 31 個の鎖", src(CLOSURE_CHAIN(31)), "(apply p0 [s : inc])", "A"],
	// 作った実体の数の守り（INSTANCE_DEPTH_MARGIN の注の3）は、外れた仮置きの上で作った実体を、外れたときに数から外す。f が g の
	// 仮置き・h の仮置き・確定した値の3つの世界で p の実体を 342 個ずつ作る形は、g → h → f の順に解くと 1026 個を作るが、外れた
	// 2つの世界の分は外すので通る（前はこの並べ方だけ断った。確かめ 2026-10-20。全部の並べ方は確かめで見た）。
	["Q25 外れた仮置きの世界ごとの実体は積み増さない（g → h → f）", src(WORLDS(342)), "(apply f 5)", "A"],
	// 同じ綴りの2つの関数は実体を分け合うが、総数は呼んだ `?` ごとに数える（300 個ずつで通る。確かめ 2026-10-20 の反証。綴りで
	// 数えると 600 個で断った）。
	// 書いた形は、どの深さでも断らない（書いた深さまでしか届かない。上限は（32 × 書いた括りの関数の数 + 1）× 書いたいちばん深い形、確かめ 2026-10-20 の後、
	// 利用者の承認で直した）。前（2026-10-20 の守りのまとめ直し）は、書いた 32 段の入れ子の字面や、書いた部分適用・合成の鎖を
	// G7 で断った。減っていく形の再帰（入れ子の字面を1段ずつ剥がす）も、浅い呼び出しの置き場所に依らず通る。
	["深さ 33 段の入れ子の字面（浅い呼び出しが先）", src(["p : [a] ? p a", "a2 : p [a : 1]", `b : p ${NEST(33)}`, "a2", "b"]), "b", "A"],
	["深さ 33 段の入れ子の字面（浅い呼び出しが後）", src(["p : [a] ? p a", `b : p ${NEST(33)}`, "a2 : p [a : 1]", "a2", "b"]), "b", "A"],
	["深さ 33 段の入れ子の字面（先に b inc）", src(["inc : x ? x + 1", "p : [a] ? p a", "b inc", `b : p ${NEST(33)}`, "a2 : p [a : 1]"]), "(construct b (unit inc))", "A", { at: 2 }],
	["深さ 輪と入れ子の鎖の 32 段（浅い呼び出しが後）", src([...ROT, ...ROT_DEF("bb", 32), ...ROT_DEF("cc", 15), "bb"]), "bb", "A"],
	["深さ 輪と入れ子の鎖の 32 段（浅い呼び出しが先）", src([...ROT, ...ROT_DEF("cc", 15), ...ROT_DEF("bb", 32), "bb"]), "bb", "A"],
	["深さ 再帰でない関数に 60 段の入れ子の字面", src(["k : [a] ? 1", `k ${NEST(60)}`]), `(apply k ${NEST(60)})`, "A"],
	// `x @ k` の右と、鍵でない `x ' k` の右（裸の名前・字面の整数でない物）は解くので、そこに書いた形も書いた形に数える（確かめ
	// 2026-10-20 の6回目。前は右を数えず、上限がほかの所に書いた形だけで決まって G7 で断った。df43d0d7 は通す）。
	["深さ `@` の右に書いた 70 段の字面", src(["f : [a] ? 1", `1 @ [f ${NEST(70)}]`]), `(@ 1 [f ${NEST(70)}])`, "未知"],
	["深さ 鍵でない `'` の右に書いた 200 段の字面", src(["f : [a] ? 1", "w : [z : 1]", `g : x ? w ' [f ${NEST(200)}]`, "g 1"]), "(apply g 1)", "未知"],
	// 閉包を欄で渡す別々の関数の鎖は、関数1つごとに1段深くなるが、関数の数で上限も上がる（再帰しない計算は、括りの関数を1つ通る
	// たびに、書いたいちばん深い形の分までしか深くならない）ので、何個でも通る。前（まとめ直しの後）は 32 個で G7 だった。
	["深さ 閉包を欄で渡す別々の関数の 40 個の鎖", src(CLOSURE_CHAIN(40)), "(apply p0 [s : inc])", "A"],
	// 値だけを渡す別々の関数の鎖は、入れ子の数の守りに数えない（数えるのは同じ `?` の入れ子だけ。注の4）。前（まとめ直しの後）は
	// 257 個で instance-nest-limit だった。
	["深さ 値だけを渡す別々の関数の 300 個の鎖", src([...VALUE_CHAIN(300), "p1 [1 2 3]"]), "(apply p1 [1 2 3])", "A"],
	["Q25 同じ綴りの関数の総数は呼んだ ? ごと", src(["p : [s] ? 1", "p2 : [s] ? 1", `a : ${PS_CALLS("p", "k", 300)}`, `b : ${PS_CALLS("p2", "j", 300)}`, "a"]), "a", "A"],
];
const answerRefused = [
	// R24 の例4：List の要素に L が見えるので名前は未知。呼んだ行で G7、関数と形を名指しする（R25）。
	["R24 g fs（h は未知）", src(["inc : x ? x + 1", "double : x ? x * 2", "fs : inc , double", "g : [h ~hs] ? h 5", "g fs"]), "G7", [["g", "[U…]"]]],
	// 構造体に同じ名前の欄が無い。
	["R24 構造体に無い名前", src([...M, "a2 : [nope] ? nope 21", "a2 m"]), "G7", [["a2", "{say:L other:N}"]]],
	// 呼ぶ行が素の関数の本体なら、その定義の行で断る。
	["R25 素の関数の本体から呼んで門", src([...M, "a2 : [nope] ? nope 21", "p : v ? a2 m"]), "G7", [["a2", "{say:L other:N}"]]],
	// 実体の本体の中で別の括りの関数を呼んで門に当たったら、通った実体を呼んだ順に名指しする。
	// 要素が中身の見えない A（未定義の名前）なので、q の y は未知。要素が数なら通る（「数の要素をもう一度括りで受ける」）。
	["R25 実体の中の実体で門", src(["p : [x ~xs] ? q x", "q : [y] ? y 5", "p [zz zz]"]), "G7", [["p", "[A…]"], ["q", "A"]]],
	// 括り1つの関数は並び全体を List として受ける（R24）。要素に L が見えるので say は未知で、呼んだ行で G7。
	["R24 a m m（関数の見える構造体の List を並びで渡す）", src([...IO, "a m m"]), "G7", [["a", "[U…]"]]],
	// 形の混ざった並びの要素は中身の見えない A（`p [1 $inc]` と同じ。R24 の断る側）なので、q の y は未知。
	["R24 p 1 $inc（形の混ざった並び）", src(["inc : x ? x + 1", "p : [x ~xs] ? q x", "q : [y] ? y 5", "p 1 $inc"]), "G7", [["p", "[A…]"], ["q", "A"]]],
	// 括りの関数の部分適用の節は、素の関数の部分適用と同じ門に当たる。合成に入って頭になる形（`pair [1] inc 5`）は、前は G2(b) だったが、
	// `f2 1 g 2` と同じく流れで読む（R36、下の「余りと流れ」の行）。値の後ろの `5 t3 1 2`（2026-10-23 は逆適用の右で G8、`5 f2 1` と同じ、
	// §5 Q5）は、逆適用の廃止（R47）で `5 (t3 1 2)` に決まり、通る側（norevPasses）へ移した。
	// 部分適用で作った実体が門に当たれば、残りを渡して呼んだ行で断る（R25。部分適用の確かめ 2026-10-19 の TG2）。
	["R24 (pair $inc) [2]（部分適用で作った実体の門）", src(["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a 1", "(pair $inc) [2]"]), "G7", [["pair", "A N"]]],
	// 当てた物の違う部分適用を欄で渡すと call の実体は別なので、m1 の実体を先に作っても、m2 の行は m2 の形で門に当たる
	// （部分適用の確かめ 2026-10-19 の TG1）。
	["R24 当てた物の違う部分適用を欄で渡す（m2 の実体が門）", src([...PAIR_GATE, "call m1", "call m2"]), "G7", [["call", "{f:L}"], ["pair", "{z:N} N"]]],
	// 1項の `:` の左と既定値は解かない（R25・P3）ので、名前を付けた部分適用を既定値の中で呼ぶ形も、別名（`p : t`）と同じく
	// 実体が作れず G7（部分適用の確かめ 2026-10-19 の TG5）。
	["R25 既定値の中で、名前を付けた部分適用を呼ぶ", src(["pair : [a ~as] [b ~bs] ? a + b", "p1 : pair [1]", "o : [x : p1 [2]] ? 5"]), "G7"],
	// 余りの節の後ろの逆適用（前は G12(a)）は、左からの畳み込み（R40）でいちばん上の余りを取って通った（2026-10-24 の R47 からは、後ろの関数が
	// 積まれて通る。下の「左からの畳み込み」）。
	// 本体の根が A でない k > n は、種類の未知な適用の後ろに項が来る形で G2(a)（R40 の読み6。前は G12(b)、§5 Q11）。前は本体の根が L の
	// `tg : [x ~xs] y ? inc` で見ていたが、根が L の実体は G16（R33）なので、根が未知の `[,] y` で見る。
	["R24 tg 1 2 3（本体の根が未知で k > n。G12(b) → G2(a)、R40）", src(["tg : [x ~xs] y ? [,] y", "tg 1 2 3"]), "G2(a)"],
	// 部分適用の残りが多いときも同じ（余りの確かめ 2026-10-19 の TG3）。
	["R24 (tg 1) 2 3（部分適用で本体の根が未知、k > n。G12(b) → G2(a)、R40）", src(["tg : [x ~xs] y ? [,] y", "(tg 1) 2 3"]), "G2(a)"],
	// 並び全体を受けた未知の節の後ろの関数（前は G2(a)）は、最後の括りが並びの終わりまで受ける（R41）ので合成になり、未知を受けて通る
	// （根なので）。下の「左からの畳み込み」へ移した。
	// 逆適用は、口が1つだけ残った関数ならその口を埋めた（R40 の読み3）。括りの関数 `a : [say] ? say 21`（口は括り1つ）・分解した名前（欄の
	// 関数）の逆適用も、2026-10-23 から通った（前は R12 の形でないので G8。2026-10-24 の R47 からは、値の後ろに積まれる）。下の「左からの
	// 畳み込み」へ移した。穴は今までどおり素の関数だけ。
	["R16 a !_（括りの関数に穴）", src([...IO, "a !_"]), "G5"],
	// 数でない物は持ち上げない（R24 の「数」は字面と、それに値の印・値の演算子を当てた物だけ）。
	["R26 数から名前の鍵で引く", src(["(5 ' say) 1"]), "G7"],
	// 前置 `!` は数を保たない：`!_` は恒等射（穴、§3.5）なので、`!(1 < 0)` は関数になりうる。数と読むと `h 5` を黙って構築と読む。
	["R24 前置 ! を当てた物は数でない", src(["f : [h ~hs] ? h 5", "f !(1 < 0)"]), "G7", [["f", "A"]]],
	["R24 前置 ! を当てた数の字面も数でない", src(["f : [h ~hs] ? h 5", "f !3"]), "G7", [["f", "A"]]],
	["R24 裸の仮引数は数と決まらない", src(["f : [x ~xs] ? x 1", "k : v ? f v", "k 3"]), "G7", [["f", "A"]]],
	["R24 $ の番地は数と決まらない", src(["inc : x ? x + 1", "f : [x ~xs] ? x 1", "f $inc"]), "G7", [["f", "A"]]],
	["R24 範囲は数でない", src(["f : [x ~xs] ? x 1", "f 1 ~ 3"]), "G7", [["f", "A"]]],
	// 番地の字面（`0x…`・`NxHHHH`）は数でない（数の確かめ 2026-10-19 の F1）。§2 の字面の行は番地を数と別に挙げ、型は `$` の
	// 番地と同じ Address なので、`$` の番地と同じく中身の見えない A。
	["R24 番地の字面は数でない", src([X1, "f 0x10"]), "G7", [["f", "A"]]],
	["R24 幅つきの番地の字面", src([X1, "f 8x00FF"]), "G7", [["f", "A"]]],
	["R24 番地だけの括り", src([X1, "f [0x10]"]), "G7", [["f", "A"]]],
	["R24 番地の名前", src(["uart : 0x09000000", "g : [h ~hs] ? h 5", "g uart"]), "G7", [["g", "A"]]],
	["R24 番地のずらし", src([X1, "f 0x10 + 1"]), "G7", [["f", "A"]]],
	["R24 番地に値の印", src([X1, "f !!0x10"]), "G7", [["f", "A"]]],
	["R26 番地から引く", src(["(0x10 ' 0) 1"]), "G7"],
	// R26 は x の形を「R24 の構造体か List」と書くので、数そのものからは引かない（数の確かめ 2026-10-19 の F2。`[x]≅x` から
	// 引けると読むかは決めていない）。
	["R26 数から整数の鍵で引く", src(["(5 ' 0) 1"]), "G7"],
	["R26 [' 0] で数から引く", src(["([' 0] 3) 1"]), "G7"],
	["R26 数の名前から引く", src(["y : 3", "(y ' 0) 1"]), "G7"],
	// 中身の見えない A に値の印・値の演算子を当てても数にならない。値の演算子は両辺が数のときだけ数（数の確かめ 2026-10-19
	// の F5・F6）。
	["R24 裸の仮引数に値の印", src([X1, "k : v ? f -v", "k 3"]), "G7", [["f", "A"]]],
	["R24 器に値の印", src([X1, "f -[1 2]"]), "G7", [["f", "A"]]],
	["R24 数と裸の仮引数の値の演算子", src([X1, "k : v ? f 1 + v", "k 3"]), "G7", [["f", "A"]]],
	["R24 裸の仮引数と数の値の演算子", src([X1, "k : v ? f v + 1", "k 3"]), "G7", [["f", "A"]]],
	["R24 $ の番地と数の値の演算子", src(["inc : x ? x + 1", X1, "f $inc + 1"]), "G7", [["f", "A"]]],
	// 数と中身の見えない A は別の実体（鍵が N と A。数の確かめ 2026-10-19 の F7）。数の実体を先に作っても、適用の結果を渡した
	// 行は数の答えに化けない。行の順を入れ替えても同じ所で断る。
	["R24 f 3 の後の f (inc 3)", src(["inc : x ? x + 1", X1, "f 3", "f (inc 3)"]), "G7", [["f", "A"]]],
	["R24 f (inc 3) の後の f 3", src(["inc : x ? x + 1", X1, "f (inc 3)", "f 3"]), "G7", [["f", "A"]]],
	// 形を変えながら自分を呼び続ける再帰は、実体が有限に収まらないので断る。
	["R24 形が深くなり続ける再帰", src(["f : [x ~xs] ? f [xs xs]", "f [1 2]"]), "G7"],
	// R26 の外の鍵で引いた物は未知なので、並びでは G7。
	["R26 (m ' 0) 21", src([...M, "(m ' 0) 21"]), "G7"],
	["R26 (m ' say~) 21", src([...M, "(m ' say~) 21"]), "G7"],
	["R26 ([' 0] fs) 5（L の見える List から引いた物は未知）", std("([' 0] fs) 5"), "G7"],
	// 行に関数が見えるブロックは、括りと同じく要素に L が見えるので名前は未知。
	["R24 関数の行のある字下げのブロック", src(["inc : x ? x + 1", "sh : [h ~hs] ? h 1", "w :", "\tinc", "\t2", "", "sh w"]), "G7", [["sh", "[U…]"]]],
	// 合成の頭に置いても、括りの関数の本体の門と G12(b) はすり抜けない（Q24 の案1）。
	["Q24 bad inc [1 2]（本体の門は呼んだ行で）", src(["inc : x ? x + 1", "bad : [x ~xs] ? [+ 1] _ _", "bad inc [1 2]"]), "G5", [["bad", "[N…]"]]],
	["Q24 tg inc 1 2 3（本体の根が未知で k > n。G12(b) → G2(a)、R40）", src(["inc : x ? x + 1", "tg : [x ~xs] y ? [,] y", "tg inc 1 2 3"]), "G2(a)"],
	["Q24 inc h2 [5 6 7]（後ろの括りの関数の名前は未知）", src(["inc : x ? x + 1", "h2 : [x ~xs] ? x 1", "inc h2 [5 6 7]"]), "G7", [["h2", "A"]]],
	// 合成の後ろの部分適用でも、本体の根が A でなければ A に数えない（Q26 は根が A のときだけ）。
	// 前は根が L の `pq : x y ? inc` で見ていたが、根が L の関数は G16（R33）なので、根が未知の `[,] y` で見る。
	["Q26 inc (pq 1) 5 inc（本体の根が未知の部分適用）", src(["inc : x ? x + 1", "pq : x y ? [,] y", "inc (pq 1) 5 inc"]), "G2(a)"],
	// 後ろの部分適用の後ろに根が A でない部分適用があれば未知（後ろの全部を見る）。確かめ 2026-10-19 の T3。
	["Q26 inc (pr 1) (pq 1) 5 inc", src(["inc : x ? x + 1", "pr : x y ? y", "pq : x y ? [,] y", "inc (pr 1) (pq 1) 5 inc"]), "G2(a)"],
	// 余りの印は後ろに素の部分適用があっても残る（G12(a)）。確かめ 2026-10-19 の T2。2026-10-23 から、余りの後ろの逆適用はいちばん上の
	// 余りを取って通る（R40）ので、`inc (pr 1) 5 6 inc` は下の「左からの畳み込み」へ移した。
	// 穴と穴の部分適用の `… 5 inc` は、合成を適用の畳み込みにして通る側（上の「法則で変わった」の行）へ移した。
	// 仮置きが外れる再帰の部分適用は未知、隣と結べば G2(a)。確かめ 2026-10-19 の F3。
	["Q26 仮置きが外れる再帰 r2 1 2 inc", src(["inc : x ? x + 1", "r2 : x y ?", "\tinc (r2 1) y", "\tinc", "", "r2 1 2 inc"]), "G2(a)"],
	// 形が枝ごとに増える再帰は、深さの上限の内でも実体が 2^深さ になる（上限が無いと解決が止まらなかった。確かめ 2026-10-20）。
	// 最初の枝を深さ優先で降りると、形が1回に2段ずつ深くなって深さの門に当たるので、最後の木はそこで呼んだ行ごと断る形で、その
	// 手前の残りの枝の実体は最後の木に無い（確定した実体に数えない。resolve.js の INSTANCE_DEPTH_MARGIN の注の2）。根の種類を解く所の
	// 増え方は資源の守り（作った実体の数か入れ子の数、注の3・4）で止まる。最後の木の門（深さの G7）は、守りに当たった答えを読んだ所（汚れた
	// 計算、注の5）で出るので作り物と見分けられず、資源の守りを言う（refusalOf）。前は作った実体の全部を数えた総数の G7 だった。
	["Q25 枝ごとに形が増える再帰（合成の頭の引き）", src(["g : [x ~xs] ? ([' 0] g [[a : xs] [a : xs]]) , ([' 0] g [[b : xs] [b : xs]])", "g [1 2]"]), "instance-work-limit"],
	["Q25 枝ごとに形が増える再帰（直接）", src(["g : [x ~xs] ? (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])", "g [1 2]"]), "instance-work-limit"],
	// 門に当たる実体を呼んだ後ろで作った実体は、最後の木に無いので確定した実体に数えない（確かめ 2026-10-20 の反証）。t の本体は
	// bad の実体の門（G5）の後ろで p の実体を作る。数えると、p の呼び出し 512 個の行が t の行より先なら総数の G7、後なら G5 に
	// 割れた（前の版も割れた）。今はどの並べ方でも G5。
	["Q25 門に当たる実体の後ろの実体は数えない（行が先）", src(["p : [s] ? 1", "bad : [y] ? [+ 1] _ _", PS_LINE(512), "t : x ? (bad [y : 1]) , (p [m : 1])"]), "G5", [["bad", "{y:N}"]]],
	["Q25 門に当たる実体の後ろの実体は数えない（t が先）", src(["p : [s] ? 1", "bad : [y] ? [+ 1] _ _", "t : x ? (bad [y : 1]) , (p [m : 1])", PS_LINE(512)]), "G5", [["bad", "{y:N}"]]],
	// 総数と作った実体の数の両方に当たるファイルは、どちらから先に当たっても総数を言う（守りに当たった `?` だけを止めるので、
	// 両方とも見つかる。全部を止めると、先に当たった方を言った。確かめ 2026-10-20）。
	["Q25 総数と作った実体の数の両方（総数が先の行）", src(["p : [s] ? 1", `a : ${PS_LINE(513)}`, GROW_SELF, "v : g [1 2]"]), "G7", [["p", ""]]],
	["Q25 総数と作った実体の数の両方（作った実体の数が先の行）", src(["p : [s] ? 1", GROW_SELF, "v : g [1 2]", `a : ${PS_LINE(513)}`]), "G7", [["p", ""]]],
	// 本体が門に当たる実体だけで作った実体の数の守りに当たる形は、最後の木の門（最初の hb の本体の G7）を言う。資源の守りより
	// 行の門を先に言い（refusalOf）、守りに当たって実体を作らせなかった行の断りより、ほかの行の断りを先に覚える（確かめ
	// 2026-10-20 の反証。前は資源の守りの名前を言うか、行の順で割れた）。
	["Q25 門に当たる実体だけで作った実体の数の守りに当たる", src(["hb : [s] [t] ? s 1", `v : ${HB_GATED(1025)}`]), "G7", [["hb", "{k0:N} {z:N}"]]],
	["Q25 門に当たる実体と通る実体で作った実体の数の守りに当たる（通る行が先）", src(["hb : [s] [t] ? s 1", HB_PASS(500), `v : ${HB_GATED(600)}`, "inc : x ? x + 1"]), "G7", [["hb", "{k0:N} {z:N}"]]],
	// 資源の守りで未知になった根から出た門は作り物かもしれないので、資源の守りを言う（汚れ、resolve.js の INSTANCE_DEPTH_MARGIN の
	// 注の5）。fz の根は入れ子の数の守り（欄 7 つの並べ替え）に当たって未知で、`fz 5 inc` の G2(a) はそこから出る（確かめ 2026-10-20 の3回目）。
	["Q25 資源の守りで未知になった根から出た門より資源の守りを言う", src([...PERM(7).map((l) => (l.startsWith("r [") ? `fz : x ? ${l}` : l)), "inc : x ? x + 1", "fz 5 inc"]), "instance-nest-limit", [["r", ""]]],
	// 前段の門でない断り（素の関数の本体の字下げのブロックの置き場所）でも止めないので、総数を超えるかは定義の順に依らない
	// （確かめ 2026-10-20 の3回目。前は t が g より先なら indent-block-position）。
	["Q25 前段の門でない断りと総数（t が先）", src(["p : [s] ? 1", "inc : x ? x + 1", "t : a ?", "\ta", "\tinc", " 5", "", `g : x ? ${PS_LINE(513)}`]), "G7", [["p", ""]]],
	["Q25 前段の門でない断りと総数（g が先）", src(["p : [s] ? 1", "inc : x ? x + 1", `g : x ? ${PS_LINE(513)}`, "t : a ?", "\ta", "\tinc", " 5", ""]), "G7", [["p", ""]]],
	// 書いた深さ（writtenDepth）を数える所でスタックが溢れても、内部の例外にしない（確かめ 2026-10-20 の6回目。前は値の定義の
	// 鎖を逆順に書くと、名前を辿る再帰が RangeError を投げた。正順なら記録を引くので溢れない）。
	["Q25 値の定義の 10000 個の鎖を逆順に書く", src([...[...Array(10001).keys()].reverse().map((i) => (i ? `v${i} : [a : v${i - 1}]` : "v0 : 1")), "v10000"]), "resolve-stack-limit"],
	// 同じ形で自分を引いてから枝ごとに形が増える再帰：後ろの実体はどれも g の仮置きに頼って作るので、根の種類を解く所では確定した
	// 実体に数えず、作った実体の数の守り（資源の守り、注の3）で止まる。上と同じく、資源の守りを言う。
	["Q25 同じ形で自分を引いてから枝ごとに形が増える再帰", src(["g : [x ~xs] ? (g xs) , (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])", "g [1 2]"]), "instance-work-limit"],
	// 欄の並べ替え（輪と入れ替え）で形が深くならないまま、同じ関数の実体が長く入れ子になる再帰（欄 7 つで 5040 通り）。前の深さの
	// 守り（同じ `?` の実体の入れ子 32）を外した後、守りが無いと内部の例外（スタックの溢れ）だった（2026-10-20）。解いている途中の
	// 再帰の入れ子が 256 を超えるので、入れ子の数の守り（資源の守り、INSTANCE_DEPTH_MARGIN の注の4）で断る。
	["Q25 欄 7 つの並べ替えの再帰", src(PERM(7)), "instance-nest-limit"],
	// 関数を跨いで同じ並べ替えを呼び合う再帰（r0 → r1 → r2 → r3 → r0）は、関数ごとの数では止まらず、解いている途中の実体の
	// 入れ子が JS のスタックを溢れさせた（確かめ 2026-10-20）。入れ子の数の守り（資源の守り、注の4）で断る。
	["Q25 欄 7 つの並べ替えを4つの関数で呼び合う再帰", src(PERM_RING(7, 4)), "instance-nest-limit"],
	// §5 Q28 の解き直し（2026-10-20）で、外れた仮置きに頼った答えに古いと印を付ける所（resolve.js の「仮置きの記録」の注）。
	// どれも、印が欠けると、この並べ方で呼ぶ行が黙って A になる（確かめ 2026-10-20）。ほかの並べ方でも同じ答えなのは、法則の
	// 試験（coproduct_laws.test.js の Q28_REFUSE_FORMS）が見る。値の定義の記録の行は、値を含む輪なので、§5 Q30（2026-10-20）
	// から name-cycle で断る。
	// 注の2（F1）：当たった枠の名簿の答えは、その枠が頼った仮置きを引き継ぐ。h のブロックの最後の行 `inc` は L なので h は
	// 未知、f の行 `h x` も未知なので f も未知、g = f x も未知。
	["Q28 外れた仮置きの上で閉じた枠に頼る（h → f → g）", src(["inc : x ? x + 1", "h : x ?", "\tf x", "\tinc", "", "f : x ?", "\tg x", "\th x", "", "g : x ? f x", "g 5 inc"]), "G2(a)"],
	// 括りの関数の実体の根が未知に解き直されることを、前は隣の inc と結ぶ G2(a) で見ていた。2026-10-23 から hb の最後の括りは並びの終わり
	// まで受ける（R41）ので inc は合成され、未知を受けて通る。根の種類（未知）で見る行を、下の「左からの畳み込み」へ移した。
	// 注の3（Q28V-3）：例外で抜けた枠の仮置き。w の既定値の `v 2` から v → h と解き、h の行 `w` が名前の輪で抜ける（namesPattern
	// が握りつぶす）。k の根は h の根で未知。この輪は既定値を覗いた所（w → v）を通るので、種類の輪ではなく（既定値は解かない、
	// P3）、§5 Q30 でも断らない（resolve.js の namesPattern の注）。
	["Q28 例外で抜けた枠の仮置きに頼る", src(["inc : x ? x + 1", "w : 1 , [[x : v 2] ? 5]", "v : h 1", "h : x ?", "\tk x", "\tw", "\tinc", "", "k : x ? h x", "k 5 inc"]), "G2(a)"],
	// 無名の関数の解き直し（collectedRoot、Q28V-5）：外の枠（f1）がまだ解いている途中なら、その仮置きにも頼る。g の根＝hh の
	// 実体の根＝無名の関数の根＝f1 の根で、未知。
	["Q28 無名の関数の解き直しが外の枠の仮置きに頼る", src(["inc : x ? x + 1", "hh : [s] ? s 1", "f1 : x ?", "\tf2 x", "\tg x", "\tinc", "", "f2 : x ?", "\tg x", "\tinc", "", "g : y ? hh [s : [w ? f1 ((f2 w) , 1)]]", "g 5 inc"]), "G2(a)"],
	// 値の定義の記録も解き直す（freshMemo、Q28V-4）形。v の値は f 1 で、f の本体の行 `v` が v を引く。前は、v を a より先に
	// 置くと名前の輪（name-cycle）、a を先に置くと f の仮置きで輪が閉じ、v は f の未知を受けて G7 に割れた（§5 Q30）。この輪は
	// 値を含む（v → f の本体 → v）ので、2026-10-20 から、どの並べ方でも name-cycle で断る（下の「§5 Q30」の行）。
	["Q28 値の定義が外れた仮置きに頼る（a が v より先）", src(["inc : x ? x + 1", "a : f 1", "v : f 1", "f : x ?", "\tv", "\tinc", "", "v inc"]), "name-cycle"],
	// 実体の深さの守り：上限は（32 × 書いた括りの関数の数 + 1）× 書いたいちばん深い形で、解く前にソースから
	// 決める（resolve.js の INSTANCE_DEPTH_MARGIN の注の1、writtenDepth）。形が深くなり続ける再帰は、書いた形が浅ければ深さの門で、上限が大きければ入れ子の数の守りで断る。
	// 鍵の深さは、閉包が書いた所の実体の鍵まで見る（fnDepth）。形の綴りはどれも {s:L} だが、欄に入れた関数は書いた所（前の実体の
	// 中）の鍵を持つので、鍵は1段ずつ深くなる。数えないと、どれも止まらなかった（綴りが同じでも鍵は違う）。
	["深さ 閉包が前の実体の中で書かれる再帰（素の関数）", src(["inc : x ? x + 1", "f : [s] ? f [s : [y ? s y]]", "f [s : inc]"]), "G7"],
	["深さ 閉包が前の実体の中で書かれる再帰（括りの関数）", src(["inc : x ? x + 1", "f : [s] ? f [s : [[x] ? s x]]", "f [s : inc]"]), "instance-nest-limit"],
	["深さ 部分適用に前の欄を当てる再帰", src(["inc : x ? x + 1", "pp : [a] [b] ? 1", "f : [s] ? f [s : pp [s : s]]", "f [s : inc]"]), "G7"],
	// 形が1段ずつ深くなる再帰は、別の所に深い形を書いても（上限が上がっても）断る。
	["深さ 形が1段ずつ深くなる再帰", src(["f : [x ~xs] ? f [xs xs]", "f [1 2]"]), "G7"],
	["深さ 形が1段ずつ深くなる再帰（別の所に 40 段の字面）", src(["f : [x ~xs] ? f [xs xs]", `w : ${NEST(40)}`, "f [1 2]"]), "instance-nest-limit", [["f", ""]]],
	// 上限が大きい（書いた形が深いか、括りの関数が多い）と、1段ずつ深くなる再帰は、深さの門より先に入れ子の数の守り（再帰の
	// 入れ子 256）に当たる。断るのは変わらない（確かめ 2026-10-20 の4回目）。
	["深さ 形が1段ずつ深くなる再帰（別の所に 200 段の字面）", src(["f : [x ~xs] ? f [xs xs]", `w : ${NEST(200)}`, "f [1 2]"]), "instance-nest-limit", [["f", ""]]],
];
for (const [name, s, want, kind, extra] of answerPasses) checkPass(`答え ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of answerRefused) checkRefused(`答え ${name}`, s, want, inst);

// ---- 法則（期待値ではなく、同じ射の綴りどうしを比べる） ----

const law = (name, test) => {
	total++;
	try {
		const problems = test();
		if (problems.length) fail(`法則 ${name}`, ...problems);
		else ok(`法則 ${name}`);
	} catch (e) {
		fail(`法則 ${name}`, `断られた: ${e.reason || e.name} ${e.gate || ""} ${e.message}`);
	}
};
const lastKind = (s) => {
	const r = resolve(s);
	return kindOf(r.trees[r.trees.length - 1]);
};
const instCount = (s, at) => (show(resolve(s).trees[at]).match(/\(inst /g) || []).length;

// R24・R26：IO Reader Writer の a・b・c は同じ射（3つとも 42）なので、m に当てた種類は同じで、どれも A。
law("a m・b m・c m は同じ種類（A）", () => {
	const ks = ["a m", "b m", "c m"].map((line) => lastKind(src([...IO, line])));
	return ks.every((k) => k === "A") ? [] : [`種類 got: ${ks.join(" ")}  want: A A A`];
});
// R26：点なしの [' k] は x ' k と同じ射なので、[' k] x と x ' k は同じ種類（A・L・未知のどれでも）。
// 2026-10-23 から、根に残った未評価のラムダは `_`（R42、木では `(unit …)` で包む）なので、根で包んだ物は包みの中の種類で比べ、
// 包んだことも比べる（どちらか一方だけが包まれたら食い違い）。
law("[' k] x と x ' k は同じ種類", () => {
	const lastKind = (s) => {
		const r = resolve(s);
		const t = r.trees[r.trees.length - 1];
		return t.t === "unit" ? `${kindOf(t.inner)}（根で _）` : kindOf(t);
	};
	const pairs = [
		[std("[' 0] vs"), std("vs ' 0"), "A"],
		[std("[' 0] fs"), std("fs ' 0"), "未知"],
		[src([...M, "[' say] m"]), src([...M, "m ' say"]), "L（根で _）"],
		[src([...M, "[' other] m"]), src([...M, "m ' other"]), "A"],
		[src([...M, "([' say] m) 21"]), src([...M, "(m ' say) 21"]), "A"],
		[src([...MY_GREET_STR, "[' greet] myGreet"]), src([...MY_GREET_STR, "myGreet ' greet"]), "A"],
		[src([...MY_GREET_FN, "([' welcome] ([' greet] myGreet)) 5"]), src([...MY_GREET_FN, "(myGreet ' greet ' welcome) 5"]), "A"],
	];
	const out = [];
	for (const [p, q, want] of pairs) {
		const kp = lastKind(p);
		const kq = lastKind(q);
		if (kp !== kq || kp !== want) out.push(`${p.split("\n").pop()}: ${kp}  ${q.split("\n").pop()}: ${kq}  want: ${want}`);
	}
	return out;
});
// R24：同じ形なら同じ実体。2か所から（並びの行と、素の関数の本体から）呼んでも、長さの違う List や文字列で呼んでも1つ。
law("同じ形で2か所から呼んでも実体は1つ", () => {
	const out = [];
	const n1 = instCount(src([...IO, "a m", "p : v ? a m", "a m"]), 1);
	if (n1 !== 1) out.push(`a の実体の数 got: ${n1}  want: 1`);
	const n2 = instCount(src([REC, "f [1 2 3]", "f [4 5]", "f `abc`"]), 0);
	if (n2 !== 1) out.push(`f の実体の数 got: ${n2}  want: 1`);
	// 形が違えば別の実体（List と構造体）。
	const n3 = instCount(src([...M, "k : [x ~xs] ? 1", "k m", "k [1 2]"]), 1);
	if (n3 !== 2) out.push(`k の実体の数 got: ${n3}  want: 2`);
	return out;
});
// R24：同じ綴り {say:L other:N} でも、本体の根が違う関数を渡したら別の実体（鍵に関数の出どころが入る）。m3 の say は
// 本体の根が未知（`[,] x`）なので、`say 21` は未知になる。m の実体を先に作っても、m3 の答えが m の答えに化けない。前は本体の
// 根が点なし（L）の `say : x ? [+ x]` で見ていたが、根が L の関数は G16（R33）になった。
law("本体の根が違う関数は別の実体", () => {
	const M3 = ["m3 :", "\tsay : x ? [,] x", "\tother : 1", ""];
	const out = [];
	const s = src([...M, ...M3, "a : [say] ? say 21", "a m", "a m3"]);
	const k3 = lastKind(s);
	if (k3 !== "未知") out.push(`a m3 の種類 got: ${k3}  want: 未知`);
	const n = instCount(s, 2);
	if (n !== 2) out.push(`a の実体の数 got: ${n}  want: 2`);
	const alone = lastKind(src([...M3, "a : [say] ? say 21", "a m3"]));
	if (alone !== k3) out.push(`m3 だけのファイルと種類が違う: ${alone} と ${k3}`);
	return out;
});
// R25：呼ぶ行を定義の前に置いても後に置いても、全部の木と診断が同じ（行の順は違うので、並べ替えて比べる）。
law("呼ぶ行を定義の前に置いても後に置いても、全部の木が同じ", () => {
	const defs = [...M, "a : [say] ? say zz", REC, "c : [~rest] ? (rest ' say) 21"];
	const calls = ["a m", "f [1 2 3]", "f `ab`", "c m", "outer : v ? [[say] ? say v] m"];
	const look = (s) => {
		const r = resolve(s);
		return {
			trees: r.trees.map((t) => `${show(t)} : ${kindOf(t)}`).sort(),
			diag: r.diagnostics.map((d) => `${d.reason}/${d.name}`).sort(),
		};
	};
	const after = look(src([...defs, ...calls]));
	const before = look(src([...calls, ...defs]));
	const out = [];
	if (JSON.stringify(after.trees) !== JSON.stringify(before.trees)) out.push(`後: ${after.trees.join(" | ")}`, `前: ${before.trees.join(" | ")}`);
	if (JSON.stringify(after.diag) !== JSON.stringify(before.diag)) out.push(`診断 後: ${after.diag}  前: ${before.diag}`);
	if (!after.trees.some((t) => t.includes("(inst {say:L other:N} (apply say zz))"))) out.push(`a の実体が無い: ${after.trees.join(" | ")}`);
	return out;
});
// R25：呼ばれるまでは defer、呼ぶ行を足すと同じ定義の行が inst になる（定義の行そのものは断らない）。
law("呼ぶ行を足すと defer が inst になる", () => {
	const alone = show(resolve(src([...M, "a : [say] ? say 21"])).trees[1]);
	const called = show(resolve(src([...M, "a : [say] ? say 21", "a m"])).trees[1]);
	const out = [];
	if (alone !== "(: a (? [[say]] (defer {say 21})))") out.push(`呼ばない got: ${alone}`);
	if (called !== "(: a (? [[say]] (inst {say:L other:N} (apply say 21))))") out.push(`呼ぶ got: ${called}`);
	return out;
});
// R24：値の行を並べた字下げのブロックは、同じ行を並べた括りと同じ List（1行が1要素）。同じ関数に渡したら、w の行の
// ほかは木と種類が同じで、断るなら門と名指しも同じ。行は数・構築の並び・文字列・括り・関数、入れ子のブロック（欄の値）。
law("値の行の字下げのブロックと括りは同じ読み", () => {
	const look = (s) => {
		try {
			const r = resolve(s);
			return r.trees.map((t) => `${show(t)} : ${kindOf(t)}`).filter((t) => !t.startsWith("(: w ")).join(" | ");
		} catch (e) {
			return `断り ${e.reason} ${e.gate || ""} ${JSON.stringify((e.instances || []).map((i) => [i.fn, i.shape]))}`;
		}
	};
	// [定義, ブロックの行（`w :` の下）, 括りの綴り, 呼ぶ行, 括りの最後の行の種類か門]
	const pairs = [
		[["f : [x ~xs] ? x 1"], ["\t1", "\t2"], ["w : [1", "\t2]"], "f w", "A"],
		[["f : [x ~xs] ? (x ' 0) 1"], ["\t1 2", "\t3 4"], ["w : [1 2", "\t3 4]"], "f w", "A"],
		[["f : [x ~xs] ? x 1"], ["\t`ab`", "\t`cd`"], ["w : [`ab`", "\t`cd`]"], "f w", "A"],
		[["f : [x ~xs] ? (x ' 0) 1"], ["\t[1 2]", "\t[3 4]"], ["w : [[1 2]", "\t[3 4]]"], "f w", "A"],
		[["inc : x ? x + 1", "sh : [h ~hs] ? h 1"], ["\tinc", "\t2"], ["w : [inc", "\t2]"], "sh w", "G7"],
		[["g : [k] ? h k", "h : [x ~xs] ? x 1"], ["\tk :", "\t\t1", "\t\t2", "\tother : 3"], ["w : [k : [1", "\t2]", "\tother : 3]"], "g w", "A"],
	];
	const out = [];
	for (const [defs, rows, bracket, call, want] of pairs) {
		const b = look(src([...defs, "w :", ...rows, "", call]));
		const k = look(src([...defs, ...bracket, call]));
		if (b !== k) out.push(`${bracket.join(" ⏎ ")}`, `  ブロック: ${b}`, `  括り: ${k}`);
		const got = k.startsWith("断り") ? k.split(" ")[2] : k.split(" : ").pop();
		if (got !== want) out.push(`${bracket.join(" ⏎ ")} の括り got: ${got}  want: ${want}`);
	}
	return out;
});
// R24：最後の仮引数が括りの関数は、k > n なら前の仮引数に1つずつ当てて、残りの並び全体を最後の括りが1つの List
// として受ける（`f 1 2 3` は `f [1 2 3]`、`map $[* 2] 1 2 3 4 5` は `map $[* 2] [1 2 3 4 5]` と同じ。利用者 2026-10-19
// 「それでいいよ」、続けて「最後の仮引数が括りの関数は、前の仮引数に1つずつ当てて、残りの並び全体を最後の括りが受ける。」）。
// 前の実引数を同じにして、残りの値の並び（項が全部 A）を並びで渡しても括って渡しても、呼ぶ行の木のほかは全部の木と
// 種類と診断が同じで、呼ぶ行の種類も同じ。断るなら門と名指しも同じ。関数は括り1つ（n = 1）、前の仮引数が裸か括りの
// n = 2、前の括りが2つで受ける形の違う n = 3（左から1つずつ当てないと実体の形が変わる）。並びには形の混ざった物
// （`1 [2 3]`・`1 $inc` の要素は中身の見えない A）と、4項以上の物も入れる。撒く項（k を数えない）と `_` は R24 の文で
// 読みが違うので入れない（上の「答え」の `n vs~ 1` の行）。関数で始まる並び（`f inc 1`）は合成になるので、この法則の外。
law("最後の仮引数が括りの関数に、残りを並びで渡しても括って渡しても同じ読み", () => {
	const DEFS = ["inc : x ? x + 1", ...M, "pt :", "\tk : 1", "\tother : 2", ""];
	// [定義, 前の仮引数に当てる実引数]
	const FNS = [
		[["f : [x ~xs] ? x 1"], ""],
		[["n : [~x] ? x"], ""],
		[["p : [x ~xs] ? q x", "q : [y] ? y 5"], ""],
		[[REC], ""],
		[["s : [h ~hs] ? (h ' 0) 1"], ""],
		[["map : f [x ~y] ? x"], "$inc"],
		[["h : v [x ~xs] ? v 1"], "1"],
		[["pair : [a ~as] [b ~bs] ? a + b"], "[1 2]"],
		[["pf : [say] [x ~xs] ? say x"], "m"],
		[["p3 : [a] [b ~bs] [c ~cs] ? a + c"], "1 [2 3]"],
		[["pm : [say] [b ~bs] [c ~cs] ? say b"], "m [2 3]"],
	];
	const ARGS = ["1 2", "1 2 3 4", "`ab` `cd`", "\\a \\b", "[1 2] [3 4]", "1 [2 3]", "1 $inc", "$inc $inc", "m m", "pt pt", "zz zz", "(inc 1) 2"];
	const look = (s) => {
		try {
			const r = resolve(s);
			const ts = r.trees.map((t) => `${show(t)} : ${kindOf(t)}`);
			ts[ts.length - 1] = `呼ぶ行 : ${kindOf(r.trees[r.trees.length - 1])}`;
			return `${ts.join(" | ")} || ${r.diagnostics.map((d) => `${d.reason}/${d.name}`).sort().join(" ")}`;
		} catch (e) {
			return `断り ${e.reason} ${e.gate || ""} ${JSON.stringify((e.instances || []).map((i) => [i.fn, i.shape]))}`;
		}
	};
	const out = [];
	let nPass = 0;
	let nRefused = 0;
	for (const [fn, front] of FNS) {
		const head = [fn[0].split(" ")[0], front].filter(Boolean).join(" ");
		for (const a of ARGS) {
			const seq = look(src([...DEFS, ...fn, `${head} ${a}`]));
			const br = look(src([...DEFS, ...fn, `${head} [${a}]`]));
			if (seq !== br) out.push(`${head} ${a}`, `  並び: ${seq}`, `  括り: ${br}`);
			if (br.startsWith("断り")) nRefused++;
			else nPass++;
		}
	}
	// 比べる組が全部同じ理由で断られていたら、法則は何も見ていない。
	if (!nPass || !nRefused) out.push(`通る組 ${nPass}・断る組 ${nRefused}（どちらも1つ以上のはず）`);
	return out;
});

// ---------------------------------------------------------------------------
// R24〜R26 の実装の確かめ（2026-10-19、仕様どおりか・反証の2つ）
// ---------------------------------------------------------------------------
//
// 「直した」行は、直す前の実装では黙って通るか、断りすぎるか、行の順で答えが割れていた。「穴」の行は、実装は
// 合っていたが、壊しても落ちる試験が無かった所（変異で確かめた）。「守り」の行は、直す前も通っていて、直しが
// 断りすぎていないこと（中身が全部値の器・1行のブロック・2項の条件）を見る。

// 別々の括りの関数の鎖 p1 → p2 → … → pN（再帰しない）。
const chain = (N) => {
	const ls = [];
	for (let i = 1; i < N; i++) ls.push(`p${i} : [a ~r] ? p${i + 1} r`);
	ls.push(`p${N} : [a ~r] ? a`);
	return ls;
};
const MIX = ["inc : x ? x + 1", "q :", "\tk : inc", "\t5", ""]; // 欄と値の混ざったブロック。中身に関数が見える
const SPREAD_REST = "f : [~r] ? r~";
// f の本体は字下げのブロック（下の「直した 仮置きの上の無名の関数」の注）。
const AF1 = ["g : [say] ? say 1", "f : [x ~xs] ?", "\t[z ? hh1 z]", ""];
const AF1_HH1 = "hh1 : y ? (g [say : [w ? f [1 2]]]) y";
const AF1_KK = "kk : y ? f [1 2]";

const checkPasses = [
	// 直した（F1・F5）：別々の関数の 33 段・40 段の鎖は有限で通る（その頃の深さの門は、同じ `?` の実体の入れ子だけを数える
	// 形に直した。2026-10-20 からは鍵の深さで、値だけを渡す鎖は深くならない）。
	["直した 括りの関数の 33 段の鎖", src([...chain(33), "p1 [1 2 3]"]), "(apply p1 [1 2 3])", "A"],
	["直した 括りの関数の 40 段の鎖", src([...chain(40), "p1 [1 2 3]"]), "(apply p1 [1 2 3])", "A"],
	// 直した（F2・F3）：構造体とも List とも読めない器でも、中身が全部値なら `~rest` で撒ける（A）。
	["守り 中身が全部値の混ざったブロックの ~rest を撒く", src(["q0 :", "\tk : 1", "\t5", "", SPREAD_REST, "f q0"]), "(: f (? [[~r]] (inst A r~)))", null, { at: 1 }],
	// 直した（反証 F2）：同じ綴りの括りの関数は答えを共有するが、呼ばれていない方の行は defer のまま（R25）。
	[
		"直した 同じ綴りの呼ばれない関数は defer",
		src([...M, "a : [say] ? say 21", "b : [say] ? say 21", "a m"]),
		"(: b (? [[say]] (defer {say 21})))",
		null,
		{ at: 2 },
	],
	["守り 同じ綴りの関数を呼んだ方は inst", src([...M, "a : [say] ? say 21", "b : [say] ? say 21", "a m"]), "(: a (? [[say]] (inst {say:L other:N} (apply say 21))))", null, { at: 1 }],
	["直した 括った ? を呼んでも、同じ綴りの名前の定義は defer", src([...M, "a : [say] ? say 21", "v : [[say] ? say 21] m"]), "(: a (? [[say]] (defer {say 21})))", null, { at: 1 }],
	// 穴（F4 (a)）：中身の見えない A の `~rest` は A。数の字面は 2026-10-19 から R24 の数（`~rest` は数の List）になった
	// ので、中身の見えない A は `$` の番地で見る（数の確かめ 2026-10-19 の F3。`ro 5` だけでは、この枝を壊しても落ちない）。
	["穴 ro $inc の ~rest は A", src(["inc : x ? x + 1", "ro : [~r] ? r 1", "ro $inc"]), "(: ro (? [[~r]] (inst A (construct r 1))))", null, { at: 1 }],
	["穴 ro $inc", src(["inc : x ? x + 1", "ro : [~r] ? r 1", "ro $inc"]), "(apply ro $inc)", "A"],
	["穴 ro 5 の ~rest は数の List",src(["ro : [~r] ? r 1", "ro 5"]), "(: ro (? [[~r]] (inst N (construct r 1))))", null, { at: 0 }],
	["穴 ro 5", src(["ro : [~r] ? r 1", "ro 5"]), "(apply ro 5)", "A"],
	// 穴（F5 (e)）：`[' 0]` に2項は、`x ' k` の形でないので未知の根。
	["穴 [' 0] vs 5（k = 2 は未知）", src(["vs : 1 , 2", "[' 0] vs 5"]), "(apply [' 0] (construct vs 5))", "未知"],
	// 読まない所（1項の `:` の左・既定値）に括りの関数を1項で書いただけ（値として書いた）なら、呼んでいないので断らない。
	["守り 既定値に括りの関数を値として書く", src(["inc : [x] ? x + 1", "ff : [z : inc] ? z"]), "(: ff (? [[z : inc]] z))", null],
	["守り 1項の条件に括りの関数を値として書く", src(["t : [a ~r] ? 5 a", "u : x ?", "\t(t) : 1", "\t2", ""]), "(: u (? [x] (block (: [t] 1) 2)))", null],
	// 字下げのブロックでも、1行なら中の行の形（構築の並びは List）。
	["守り 1行の字下げのブロックは中の行の形", src(["sh : [x ~xs] ? x 1", "w :", "\t1 2", "", "sh w"]), "(apply sh w)", "A"],
];
const checkRefusedRows = [
	// 直した（F2・反証 F3）：行の混ざったブロック・同じ名前の欄・欄の混ざった括り・撒く項を含む並びは、形は中身の見えない
	// A だが中身に関数が見える。`~rest` は中身を持ち越すので、撒けば呼んだ行で G7（直に撒く `q~` と同じ）。
	["直した 混ざったブロックの ~rest を撒く", src([...MIX, SPREAD_REST, "f q"]), "G7", [["f", "A(U)"]]],
	["直した 同じ名前の欄の ~rest を撒く", src(["inc : x ? x + 1", "q3 :", "\tk : inc", "\tk : 5", "", SPREAD_REST, "f q3"]), "G7", [["f", "A(U)"]]],
	["直した 欄の混ざった括りの ~rest を撒く", src(["inc : x ? x + 1", "g : [~r] ? 5 r~", "g [a : inc", "5]"]), "G7", [["g", "A(U)"]]],
	["直した 撒く項を含む並びの ~rest を撒く", src(["inc : x ? x + 1", "vs : 1 2", "fs2 : inc , vs~", "g : [x ~xs] ? 5 xs~", "g fs2"]), "G7", [["g", "A(U)"]]],
	// 中身の見えない A（`$inc`）の実体を先に作っても、中身に関数の見える器は別の実体（鍵が A(U)）。数の字面は 2026-10-19
	// から数（鍵が N）なので、`f 5` ではこの鍵の分け方を踏まない（数の確かめ 2026-10-19 の F4）。
	["直した f $inc の後の f q", src([...MIX, SPREAD_REST, "f $inc", "f q"]), "G7", [["f", "A(U)"]]],
	// 直した（F3）：1項の `:` の左は解かない（P3）ので、そこで括りの関数を呼ぶと実体が作れない。defer にせず断る。
	["直した 1項の条件の中で括りの関数を呼ぶ", src(["inc : x ? x + 1", "t : [a ~r] ? 5 inc 3 inc", "u : x ?", "\t(t [1 2]) : 1", "\t2", ""]), "G7"],
	["直した 1項の条件の中で括りの関数の別名を呼ぶ", src(["inc : x ? x + 1", "t : [a ~r] ? 5 inc 3 inc", "p : t", "u : x ?", "\t(p [1 2]) : 1", "\t2", ""]), "G7"],
	["直した 1項の条件の中の括った ?", src([...M, "u : x ?", "\t([[a] ? a 1] m) : 1", "\t2", ""]), "G7"],
	["直した 1項の条件の中の関数の本体で括りの関数を呼ぶ", src(["inc : x ? x + 1", "t : [a ~r] ? 5 inc 3 inc", "u : x ?", "\t([q ? t [q q]]) : 1", "\t2", ""]), "G7"],
	// 既定値（`?` の左）も解かない（P3）ので、同じ理由で断る（F3 と同じ穴）。
	["直した 括りの既定値の中で括りの関数を呼ぶ", src(["inc : x ? x + 1", "t : [a ~r] ? 5 inc 3 inc", "o : [x : t [1 2]] ? 5"]), "G7"],
	["直した 仮引数のブロックの既定値の中で括りの関数を呼ぶ", src(["inc : x ? x + 1", "t : [a ~r] ? 5 inc 3 inc", "o :", "\t\tx : t [1 2]", "\t? 5"]), "G7"],
	// 2項以上の条件は今までどおり解くので、実体の本体の門で名指しする。前の本体 `5 inc 3 inc`（G1）は R37 で通るようになった
	// （2026-10-22）ので、門に当たる本体を `inc 1 2 inc`（G12(a)）にした。
	// 実体の本体の門は、前は G12(a) の `inc 1 2 inc` で見ていた。2026-10-23 からそれは通る（R40）ので、G13 の `inc 1 !_` にした。
	["守り 2項の条件は実体を作る", src(["inc : x ? x + 1", "t : [a ~r] ? inc 1 !_", "u : x ?", "\tt [1 2] : 1", "\t2", ""]), "G13", [["t", "[N…]"]]],
	// 直した（反証 F1）：無名の素の関数の本体の根が、外の関数の仮置きの上で決まり、欄として別の実体へ渡っても、仮置きが
	// 外れたら直る。行の順（kk と hh1）に依らず hh1 の行で G7。前の f は `f : [x ~xs] ? [z ? hh1 z]` だったが、実体の本体の根が
	// 裸の関数なので G16（R33）に当たり、F1 の直しを戻しても G16 で断られて、この2行は空振りしていた（確かめ 2026-10-22。
	// `[,] [z ? hh1 z]` も合成で L なので G16）。だから f の本体を字下げのブロックにした：ブロックの本体の根は L にならない（今は、
	// R33 の R の所・§5 Q35）ので G16 に当たらず、前と同じ道（f の実体が仮置きを読まれて外れる）を通る。F1 の直しを戻すと、kk が
	// 先の行が通る（確かめた）。ブロックの本体の根の読みが決まって G16 に当たるようになったら、この2行は別の形に替える。
	["直した 仮置きの上の無名の関数（kk が先）", src([...AF1, AF1_KK, AF1_HH1]), "G7"],
	["守り 仮置きの上の無名の関数（hh1 が先。直す前も G7）", src([...AF1, AF1_HH1, AF1_KK]), "G7"],
	["直した 仮置きの上の無名の関数（f の中）", src(["g : [say] ? say 1", "f : [x ~xs] ? [z ? (g [say : [y ? f [1 2]]]) z]", "f [1 2]"]), "G7", [["f", "[N…]"]]],
	// 直した（反証 F2）：断る行で使った関数を名指しする（同じ綴りの別の関数が先に実体を作っていても）。
	["直した 同じ綴りの関数の名指し", src([...M, "a2 : [nope] ? nope 21", "b2 : [nope] ? nope 21", "b2 m", "v : a2 m"]), "G7", [["b2", "{say:L other:N}"]]],
	// 穴（F4 (b)〜(d)）：構造体の `~rest` に受けた欄は残らない／裸の仮引数は A／行の混ざったブロックは構造体でない。
	["穴 [say ~r] ? r ' say", src([...M, "b : [say ~r] ? (r ' say) 21", "b m"]), "G7", [["b", "{say:L other:N}"]]],
	["穴 裸の仮引数から引く", src([...M, "mp : f [x ~y] ? (f ' say) 1", "mp m [1 2]"]), "G7", [["mp", "A [N…]"]]],
	["穴 行の混ざったブロックは構造体でない", src(["inc : x ? x + 1", "sa : [say] ? say 21", "w :", "\tsay : inc", "\t5", "", "sa w"]), "G7", [["sa", "A(U)"]]],
	// 穴（F5 (f)〜(h)）：引いた欄の中身の関数を撒く／入れ子の分解の名前は未知／形の違う要素の List の要素は中身の見えない A。
	["穴 引いた欄の中身の関数を撒く", src(["inc : x ? x + 1", "w :", "\tfs : inc , inc", "", "[w ' fs]~ 1"]), "G7"],
	["穴 入れ子の分解の名前は未知", src(["nd : [[a b] c] ? a 1", "nd [[1 2] 3]"]), "G7", [["nd", "[A…]"]]],
	["穴 形の違う要素の List から引く", src(["f : [x ~xs] ? (x ' 0) 1", "f [[1 2] 3]"]), "G7", [["f", "[A…]"]]],
];
for (const [name, s, want, kind, extra] of checkPasses) checkPass(`確かめ ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of checkRefusedRows) checkRefused(`確かめ ${name}`, s, want, inst);

// 直した（F1・F5）：鎖の途中の実体を先に作る行があってもなくても、同じ答え（行の順に依らない）。
law("括りの関数の鎖は、途中を先に呼んでも後に呼んでも同じ", () => {
	const look = (s) => {
		try {
			return resolve(s).trees.map((t) => `${show(t)} : ${kindOf(t)}`).sort().join(" | ");
		} catch (e) {
			return `断る ${e.reason} ${e.gate}`;
		}
	};
	const first = look(src([...chain(33), "p20 [1 2 3]", "p1 [1 2 3]"]));
	const last = look(src([...chain(33), "p1 [1 2 3]", "p20 [1 2 3]"]));
	return first === last && !first.startsWith("断る") ? [] : [`途中が先: ${first.slice(0, 200)}`, `途中が後: ${last.slice(0, 200)}`];
});
// 直した（反証 F4）：同じ物を2つの欄に置く構造体（DAG）の鍵は、深さに比例する手間で作る。木として辿ると深さ 24 で
// 10 秒、形が倍々に深くなる再帰は 61 秒の後に内部の例外（文字列の長さの上限）だった。1本 5 秒の上限で見る。
law("欄どうしで同じ物を指す形の鍵は速い", () => {
	const out = [];
	const dag = ["m0 : [z : 1]"];
	for (let i = 1; i <= 24; i++) dag.push(`m${i} : [p : m${i - 1}`, `q : m${i - 1}]`);
	dag.push("g : [p] ? 1", "g m24");
	let t0 = Date.now();
	const r = resolve(src(dag));
	const ms1 = Date.now() - t0;
	if (ms1 > 5000) out.push(`DAG の深さ 24：${ms1}ms`);
	const gLine = show(r.trees[r.trees.length - 2]);
	if (gLine.length > 1000 || !gLine.includes("⋯")) out.push(`形の綴りを切っていない（${gLine.length} 字）`);
	t0 = Date.now();
	let got = "通った";
	try {
		resolve(src(["f : [x ~r] ? f [p : r", "q : r]", "f [z : 1]"]));
	} catch (e) {
		got = `${e.reason} ${e.gate || ""}`;
	}
	const ms2 = Date.now() - t0;
	if (ms2 > 5000) out.push(`倍々の再帰：${ms2}ms`);
	if (got !== "coproduct-unknown-kind G7") out.push(`倍々の再帰 got: ${got}  want: G7`);
	return out;
});
// 直した（部分適用の確かめ 2026-10-19 の F1）：前の部分適用を2つの欄に当てた部分適用の鎖（`q1 : pp [f : q0] [f : q0]`）
// の鍵も、深さに比例する手間で作る。当てた物を葉の文字列に綴ると段ごとに倍になり、22 段で内部の例外（文字列の長さの
// 上限）、呼ぶ行を足すとヒープの上限でプロセスごと落ちた。形が倍々に深くなる再帰は、内部の例外ではなく深さの門（G7）
// で断る。1本 5 秒の上限で見る。
// 書いた 24 段の鎖は、h に渡す鍵の深さが 52 段（q の1段ごとに部分適用と欄で2段）になるが、書いた分なので断らない（深さの上限は
// （32 × 書いた括りの関数の数 + 1）× 書いたいちばん深い形。resolve.js の INSTANCE_DEPTH_MARGIN の注の1。前（深さを固定の 32 にしていた間）は G7）。
const ppChain = (n) => {
	const ls = ["inc : x ? x + 1", "pp : [a] [b] [c] ? a", "q0 : pp [f : inc] [f : inc]"];
	for (let i = 1; i <= n; i++) ls.push(`q${i} : pp [f : q${i - 1}] [f : q${i - 1}]`);
	ls.push("h : [f] ? f [1]", `h [f : q${n}]`);
	return src(ls);
};
law("部分適用を当てた部分適用の鎖の鍵は速い", () => {
	const out = [];
	let t0 = Date.now();
	const r = resolve(ppChain(24));
	const ms1 = Date.now() - t0;
	if (ms1 > 5000) out.push(`部分適用の鎖の深さ 24：${ms1}ms`);
	const hLine = show(r.trees[r.trees.length - 2]);
	if (hLine !== "(: h (? [[f]] (inst {f:L} (apply f [1]))))") out.push(`h の行 got: ${hLine}`);
	t0 = Date.now();
	let got = "通った";
	try {
		resolve(src(["inc : x ? x + 1", "pp : [a] [b] [c] ? a", "g : [f] ? g [f : pp [f : f] [f : f]]", "g [f : inc]"]));
	} catch (e) {
		got = `${e.reason} ${e.gate || ""}`;
	}
	const ms2 = Date.now() - t0;
	if (ms2 > 5000) out.push(`倍々の部分適用の再帰：${ms2}ms`);
	if (got !== "coproduct-unknown-kind G7") out.push(`倍々の部分適用の再帰 got: ${got}  want: G7`);
	return out;
});

// ---------------------------------------------------------------------------
// 分け合った実体の描き方（2026-10-19、反証の続き）
// ---------------------------------------------------------------------------
//
// 同じ綴りの括りの関数（pair と pair2）は実体の答えを分け合う（R25）。直す前は、分け合った実体を使い回すと、その本体の
// 中の呼び出しを、実体を最初に作った側の物（欄の関数）で一度だけ記録していた。だから欄で pair2 を渡した行の分が記録
// されず、どちらの定義の行に inst が出るかが行の順で入れ替わった。値の定義が先に作った実体を別の行が木にすると、門の
// 名指しも作った側の名前になった。直した後は、呼んだ側の物ごとに本体を歩き、呼んだ `?` に inst を描く。

const SAME_PAIRS = ["pair : [a ~as] [b ~bs] ? a + b", "pair2 : [a ~as] [b ~bs] ? a + b"];
const H_PAIR = "h : [f] ? f [1] [2]";
const H_NESTED = "h : [f] ? [[x] ? f x [2]] [1]"; // 実体の本体の中の括った `?` から、欄の関数を呼ぶ
const PAIR_INST = (name, shape) => `(: ${name} (? [[a ~as] [b ~bs]] (inst ${shape} (+ a b))))`;
const NAMING = [...M, "a2 : [nope] ? nope 21", "b2 : [nope] ? nope 21", "hh : [f] ? f m"];
const PP2 = ["pp2 : [g] [x] ? g [1] [2]", "k : [f] ? f [9]"];

const sharePasses = [
	["直した 欄で pair・pair2 の順に渡すと pair2 の行も inst", src([...SAME_PAIRS, H_PAIR, "h [f : pair]", "h [f : pair2]"]), PAIR_INST("pair2", "N N"), null, { at: 1 }],
	["直した 欄で pair2・pair の順に渡すと pair の行も inst", src([...SAME_PAIRS, H_PAIR, "h [f : pair2]", "h [f : pair]"]), PAIR_INST("pair", "N N"), null, { at: 0 }],
	["直した 部分適用を欄で渡す（pair が先）", src([...SAME_PAIRS, H_PAIR, "h [f : pair [1]]", "h [f : pair2 [1]]"]), PAIR_INST("pair2", "N [N…]"), null, { at: 1 }],
	["直した 部分適用を欄で渡す（pair2 が先）", src([...SAME_PAIRS, H_PAIR, "h [f : pair2 [1]]", "h [f : pair [1]]"]), PAIR_INST("pair", "N [N…]"), null, { at: 0 }],
	["直した 実体の中の括った ? から呼ぶ（pair が先）", src([...SAME_PAIRS, H_NESTED, "h [f : pair]", "h [f : pair2]"]), PAIR_INST("pair2", "N N"), null, { at: 1 }],
	["直した 実体の中の括った ? から呼ぶ（pair2 が先）", src([...SAME_PAIRS, H_NESTED, "h [f : pair2]", "h [f : pair]"]), PAIR_INST("pair", "N N"), null, { at: 0 }],
	// 部分適用に当てた物の中の関数も、呼んだ物に数える（pp2 の実体を通って pair か pair2 を呼ぶ）。
	["直した 部分適用に当てた欄の関数", src([...SAME_PAIRS, ...PP2, "k [f : pp2 [g : pair]]", "k [f : pp2 [g : pair2]]"]), PAIR_INST("pair2", "N N"), null, { at: 1 }],
	// 値の定義の種類は、行を解く前に出す（実体はそこで作る）。素の関数の本体から pair2 を渡す行が、その実体を使い回す。
	["直した 値の定義が先に作った実体を素の関数の本体が使う", src([...SAME_PAIRS, H_PAIR, "v : h [f : pair]", "p : y ? h [f : pair2]"]), PAIR_INST("pair2", "N N"), null, { at: 1 }],
	["守り 分け合った実体は h の行に1つ", src([...SAME_PAIRS, H_PAIR, "h [f : pair]", "h [f : pair2]"]), "(: h (? [[f]] (inst {f:L} (apply f (construct [1] [2])))))", null, { at: 2 }],
	["守り 呼ばれない pair2 は defer のまま", src([...SAME_PAIRS, H_PAIR, "h [f : pair]"]), "(: pair2 (? [[a ~as] [b ~bs]] (defer {a + b})))", null, { at: 1 }],
];
const shareRefused = [
	// 断る行で書いた関数を名指しする。直す前は、値の定義 v が先に作った実体（欄は a2）で木にしたので、b2 の行で a2 と言った。
	["直した 値の定義が先に作った実体を、別の綴りの関数で呼んで門", src([...NAMING, "hh [f : b2]", "v : hh [f : a2]"]), "G7", [["hh", "{f:L}"], ["b2", "{say:L other:N}"]]],
	["守り 値の定義の行が先なら、その行で名指し", src([...NAMING, "v : hh [f : a2]", "hh [f : b2]"]), "G7", [["hh", "{f:L}"], ["a2", "{say:L other:N}"]]],
];
for (const [name, s, want, kind, extra] of sharePasses) checkPass(`確かめ ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of shareRefused) checkRefused(`確かめ ${name}`, s, want, inst);

// 単位（1つの定義か1つの呼ぶ行。字下げのブロックは1単位）の並べ方。5単位までは全部、それより多ければ回転と、その逆順。
const orders = (units) => {
	const out = [];
	if (units.length <= 5) {
		const go = (rest, acc) => {
			if (!rest.length) out.push(acc);
			rest.forEach((u, i) => go([...rest.slice(0, i), ...rest.slice(i + 1)], [...acc, u]));
		};
		go(units, []);
		return out;
	}
	for (let i = 0; i < units.length; i++) out.push([...units.slice(i), ...units.slice(0, i)]);
	return [...out, ...out.map((o) => [...o].reverse())];
};
// R25：行の順を入れ替えても、全部の木・種類・診断が同じ。断るなら門と名指しも同じ。called の関数は、どの並べ方でも
// 定義の行が inst（defer のまま揃っているだけなら、法則は何も見ていない）。
law("分け合った実体があっても、行の順を入れ替えて全部の木・種類・診断・門が同じ", () => {
	const look = (s) => {
		try {
			const r = resolve(s);
			const trees = r.trees.map((t) => `${show(t)} : ${kindOf(t)}`).sort();
			return { text: `${trees.join(" | ")} || ${r.diagnostics.map((d) => `${d.reason}/${d.name}`).sort().join(" ")}`, trees };
		} catch (e) {
			return { text: `断り ${e.reason} ${e.gate || ""} ${JSON.stringify((e.instances || []).map((i) => [i.fn, i.shape]))}`, trees: [] };
		}
	};
	const P = SAME_PAIRS.map((d) => [d]);
	// [名前, 単位, 定義の行が inst になるはずの関数, 断る門（通るなら null）]
	const groups = [
		["欄で渡す", [...P, [H_PAIR], ["h [f : pair]"], ["h [f : pair2]"]], ["pair", "pair2", "h"], null],
		["部分適用を欄で渡す", [...P, [H_PAIR], ["h [f : pair [1]]"], ["h [f : pair2 [1]]"]], ["pair", "pair2", "h"], null],
		["実体の中の括った ? から呼ぶ", [...P, [H_NESTED], ["h [f : pair]"], ["h [f : pair2]"]], ["pair", "pair2", "h"], null],
		["値の定義と素の関数の本体から呼ぶ", [...P, [H_PAIR], ["v : h [f : pair]"], ["p : y ? h [f : pair2]"]], ["pair", "pair2", "h"], null],
		["部分適用に当てた欄の関数", [...P, PP2, ["k [f : pp2 [g : pair]]"], ["k [f : pp2 [g : pair2]]"]], ["pair", "pair2", "pp2", "k"], null],
		["当て方の違う部分適用（括りと数）", [["t3 : [a] [b] [c] ? a + c"], ["t4 : [a] [b] [c] ? a + c"], ["k : [f] ? f [2] [3]"], ["k [f : t3 [1]]"], ["k [f : (t4 1)]"]], ["t3", "t4", "k"], null],
		[
			"門（断る行は1つ）",
			[...P, [H_PAIR], ["h [f : pair]"], ["h [f : pair2]"], M, ["a2 : [nope] ? nope 21"], ["hh : [f] ? f m"], ["v : hh [f : a2]"]],
			[],
			"G7",
		],
	];
	const out = [];
	for (const [name, units, called, gate] of groups) {
		const all = orders(units);
		const first = look(src(all[0].flat()));
		for (const o of all.slice(1)) {
			const got = look(src(o.flat()));
			if (got.text !== first.text) {
				out.push(`${name}：並べ方で割れた`, `  ${all[0].map((u) => u[0]).join(" ⏎ ")}`, `    ${first.text}`, `  ${o.map((u) => u[0]).join(" ⏎ ")}`, `    ${got.text}`);
				break;
			}
		}
		if (gate && !first.text.startsWith(`断り ${GATE_REASON[gate]} ${gate} `)) out.push(`${name}：got ${first.text}  want: ${gate}`);
		for (const c of called) {
			const line = first.trees.find((t) => t.startsWith(`(: ${c} (? `));
			if (!line || !line.includes("(inst ") || line.includes("(defer ")) out.push(`${name}：${c} の定義の行が inst でない: ${line}`);
		}
	}
	return out;
});

// ---------------------------------------------------------------------------
// 合成の鍵（2026-10-19、反証の続き）
// ---------------------------------------------------------------------------

// 直した（反証の続き）：合成の鍵も、形と部分適用の鍵と同じく番号に寄せて綴る（canonKey）。同じ部分適用を2つ並べた
// 合成（`c1 : q1 q1`）を当てた部分適用の鎖は、合成の鍵を子の鍵の文字列でつなぐと段ごとに倍になり、24 段で内部の例外
// （文字列の長さの上限）だった。形が倍々に深くなる再帰は、内部の例外ではなく深さの門（G7）で断る。1本 5 秒の上限で見る。
// 部分適用の鎖と同じく、書いた 24 段の鎖は h に渡す鍵の深さが 75 段（1段ごとに合成・部分適用・欄で3段）になるが、書いた分なので
// 断らない（前、深さを固定の 32 にしていた間は G7）。
const ccChain = (n) => {
	const ls = ["inc : x ? x + 1", "pp : [a] [b] [c] ? a", "c0 : inc inc"];
	for (let i = 1; i <= n; i++) ls.push(`q${i} : pp [f : c${i - 1}] [f : c${i - 1}]`, `c${i} : q${i} q${i}`);
	ls.push("h : [f] ? f [1]", `h [f : c${n}]`);
	return src(ls);
};
law("合成を当てた部分適用の鎖の鍵は速い", () => {
	const out = [];
	let t0 = Date.now();
	const r = resolve(ccChain(24));
	const ms1 = Date.now() - t0;
	if (ms1 > 5000) out.push(`合成を当てた部分適用の鎖の深さ 24：${ms1}ms`);
	const hLine = show(r.trees[r.trees.length - 2]);
	if (hLine !== "(: h (? [[f]] (inst {f:L} (apply f [1]))))") out.push(`h の行 got: ${hLine}`);
	t0 = Date.now();
	let got = "通った";
	try {
		resolve(src(["inc : x ? x + 1", "pp : [a] [b] [c] ? a", "g : [f] ? g [f : pp [f : f f] [f : f f]]", "g [f : inc]"]));
	} catch (e) {
		got = `${e.reason} ${e.gate || ""}`;
	}
	const ms2 = Date.now() - t0;
	if (ms2 > 5000) out.push(`倍々の合成の再帰：${ms2}ms`);
	if (got !== "coproduct-unknown-kind G7") out.push(`倍々の合成の再帰 got: ${got}  want: G7`);
	return out;
});
// 合成の鍵を番号に寄せても、鍵は合成の中身で分かれる：並びの違う合成は別の実体、同じ綴りの合成は同じ実体。
law("合成の鍵は中身で分かれる", () => {
	const defs = ["inc : x ? x + 1", "double : x ? x * 2", "ca : inc double", "cb : double inc", "ca2 : inc double", "k : [f] ? f 1"];
	const n = instCount(src([...defs, "k [f : ca]", "k [f : cb]", "k [f : ca2]"]), 5);
	return n === 2 ? [] : [`k の実体の数 got: ${n}  want: 2`];
});
// 合成の鍵は、足りない適用の節を含むか（partial）でも分かれる。前は、partial の合成が適用の頭になると G2(b) で断っていたので、
// 分けないと、括りの部分適用 `[add 1]` で始まる合成の実体を先に作った行の後で、`add 1 inc`（足りない適用の節を含む）を渡した行が
// 黙って通った。2026-10-22 から、合成は流れとして読む（R36）ので、`[add 1] inc` と `add 1 inc` は同じ流れ（`inc (add 1 1)`）で、
// どちらの行も A。鍵は今も印で分けている（分け合っても答えは同じ）。
checkPass(
	"確かめ 守り 合成の足りない適用の印は、流れの答えを変えない（前は G2(b)）",
	src(["inc : x ? x + 1", "add : x y ? x + y", "k : [f] ? f 1", "k [f : [add 1] inc]", "k [f : add 1 inc]"]),
	"(apply k [f : add 1 inc])",
	"A"
);

// ---------------------------------------------------------------------------
// 合成の中の括りの関数（§5 Q24 の案1、2026-10-19、確かめ）
// ---------------------------------------------------------------------------
//
// 直した：合成の最初の関数が足りた適用で、結果が A でないとき（括りの関数の実体の根が A でない・素の関数の本体の根が
// A でない k = n・`[' 0]` に1項）、直す前は後ろの関数を見ずに未知で返していた。だから後ろの括りの関数の実体を作らず、
// 本体の門をすり抜け、定義の行は defer のままだった。前に `inc` を1つ足した `inc pa bad [1 2]` は断るのに、
// `pa bad [1 2]` は通っていた。最初の関数は足りた適用なので、後ろの関数はその結果を受けて呼ばれる（R11）。だから後ろの
// 括りの関数は未知を受けて実体を作り（§3.4 の合成の行「前に未知があれば未知」）、門に当たれば呼んだ行で断る（R25）。
// 最初の関数に足りたか決まらない形（`[+]` に1項 Q17・既定値のある関数 Q8）は、Q24 の直しの時は「後ろが呼ばれるかも
// 決まらない」として実体を作らなかった。合成を適用の畳み込みにした（2026-10-19）ので、最初の関数の適用が未知なだけで、
// 後ろの括りの関数は同じく未知を受けて実体を作る（§5 Q27 の断る側。`[+] bad 5` と `inc [+] bad 5` が割れていた）。
// 2026-10-21 に R31 で `[+]` に数1つは値になった（Q17 は閉じた）ので、足りたか決まらない頭の見本は、アリティの分からない点なし
// `[,]` に替えた。`[+] tl 5` の tl は A を受ける（下の「R31 で変わった」の行）。同じ日に、畳まない点なし（`[<<]` など）は素の2引数の
// 関数になった（R32）ので、`[<<] tl 5` は `add tl 5` と同じく足りない適用で、tl は呼ばれない（defer）。中身の見えない A を1項で
// 畳む頭（`[&] tl (inc 5)`、R31 の1項）は未知で、後ろは未知を受ける。
//
// 穴：変異で壊しても落ちなかった所（途中で未知になった後の括りの関数・合成の頭の括りの関数の根が A でない k = n・
// k > n・足りない・後ろの括りの関数のアリティが2以上）。

// 頭の根が A でない関数は、前は本体の根が L の物（`pa : [x ~xs] ? [+ x]`・`hl : [x ~xs] ? inc`・`adder : m ? [+ m]`・
// `pu : [x ~xs] ? [+ x]`）で見ていた。根が L の関数と実体は G16（R33）になったので、根が未知の `[,] …` で見る。pa と hl は
// 未知を受けても（`inc pa bad [1 2]`）根が未知のままで門に当たらないよう、仮引数を並びに置かない（`[,] x` は x が未知なら G7）。
const PA = "pa : [x ~xs] ? [,] 1"; // 実体の根が未知
const HL = "hl : [x ~xs] ? [,] 2"; // 実体の根が未知
const BAD = "bad : [y ~ys] ? [+ 1] _ _";
const TL = "tl : [y ~ys] ? ys";
const TR = "tr : [x ~xs] ? xs 1";
const INC = "inc : x ? x + 1";
const DOUBLE = "double : x ? x * 2";
const UU = "uu : m ? [,] m"; // 本体の根が未知（前は adder : m ? [+ m]、§5 Q21）

const composePasses = [
	["直した pa tl [1 2] の根は未知", src([PA, TL, "pa tl [1 2]"]), "(apply (compose pa tl) [1 2])", "未知"],
	["直した pa tl [1 2] の tl は未知を受けて実体を作る", src([PA, TL, "pa tl [1 2]"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 1 }],
	["直した uu tl 1 の tl は未知を受けて実体を作る（前は adder tl 1）", src([UU, TL, "uu tl 1"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 1 }],
	["穴 inc uu tl 1（途中で未知になった後の括りの関数は未知を受ける）", src([INC, UU, TL, "inc uu tl 1"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 2 }],
	["穴 inc uu tl 1 の根は未知", src([INC, UU, TL, "inc uu tl 1"]), "(apply (compose inc uu tl) 1)", "未知"],
	["穴 pu inc [1]（合成の頭の括りの関数の実体の根が A でない k = n）", src([INC, "pu : [x ~xs] ? [,] x", "pu inc [1]"]), "(apply (compose pu inc) [1])", "未知"],
	["穴 pr inc [1] 2 3（合成の頭の最後の仮引数が裸の k > n は、流れの余りを後ろに積む）", src([INC, "pr : [x ~xs] y ? y", "pr inc [1] 2 3"]), "(construct (apply (compose pr inc) (construct [1] 2)) 3)", "A", { leftover: true }],
	// 並びの項を全部書いた後に合成した double は、並びから何も受けていない。木は入れ子の適用（2026-10-24 の R47 で `·rev` の綴りが無くなった。
	// 前は `(apply double (apply (compose head inc) (construct 5 6 7)) ·rev)`）。
	["穴 head inc 5 6 7 double（合成の頭の最後の括りが残りを受ける）", src([INC, DOUBLE, "head : [x ~xs] ? x", "head inc 5 6 7 double"]), "(apply double (apply inc (apply head (construct 5 6 7))))", "A"],
	["穴 pair inc [1]（合成の頭の括りの関数に足りない。根なので `_`、R42）", src([INC, "pair : [a ~as] [b ~bs] ? a + b", "pair inc [1]"]), "(unit (apply (compose pair inc) [1]))", "A"],
	// 後ろの pb は前の結果を最初の口に受け、もう1つの口を待つ L（左からの畳み込み、R40。前は後ろの関数が前の結果だけを受けて未知）。根なので `_`（R42）。
	["穴 inc pb [1]（後ろの括りの関数のアリティが2）の根は `_`（R40・R42。前は未知）", src([INC, "pb : [a] [b] ? [+ 1] _ _", "inc pb [1]"]), "(unit (apply (compose inc pb) [1]))", "A"],
	["穴 inc pb [1] の pb は呼ばれないので defer", src([INC, "pb : [a] [b] ? [+ 1] _ _", "inc pb [1]"]), "(: pb (? [[a] [b]] (defer {[+ 1] _ _})))", null, { at: 1 }],
	["穴 inc pair [1]（後ろの括りの関数のアリティが2、Q13。もう1つの口を待つ L で、根なので `_`、R40・R42。前は未知）", src([INC, "pair : [a ~as] [b ~bs] ? a + b", "inc pair [1]"]), "(unit (apply (compose inc pair) [1]))", "A"],
	// 最初の関数に足りたか決まらない（前は `[+]` に1項、§5 Q17。今はアリティの分からない点なし `[,]` に1項）。前は「後ろが呼ばれる
	// かも決まらない」として実体を作らず、この行を「今は defer」として置いていた（§5 Q27）。合成を適用の畳み込みにして裏返した：
	// 後ろの括りの関数は未知を受ける。
	["Q27 で裏返した [,] tl 5 の tl は未知を受けて実体を作る（前は [+] tl 5 で defer）", src([TL, "[,] tl 5"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 0 }],
	["Q27 [,] tl 5 の根は未知のまま", src([TL, "[,] tl 5"]), "(apply (compose [,] tl) 5)", "未知"],
	// R31 で `[+]` に数1つは値（`[+] 5` は 5）になったので、`[+] tl 5` の tl は、`inc tl 5` と同じく中身の見えない A を受ける（前は U）。
	["R31 で変わった [+] tl 5 の tl は A を受ける（前は U）", src([TL, "[+] tl 5"]), "(: tl (? [[y ~ys]] (inst A ys)))", null, { at: 0 }],
	["R31 で変わった [|] tl 5 の tl は A を受ける（前は U）", src([TL, "[|] tl 5"]), "(: tl (? [[y ~ys]] (inst A ys)))", null, { at: 0 }],
	// 中身の見えない A を1項で畳む頭は未知（R31 の1項）で、後ろの括りの関数は未知を受ける。
	["R31 の1項 [&] tl (inc 5) の tl は未知を受けて実体を作る", src([INC, TL, "[&] tl (inc 5)"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 1 }],
	// 畳まない `[<<]` に1項は、素の2引数の関数（`add tl 5`）と同じく足りない適用で L（R32）。後ろは呼ばれないので defer。
	["R32 [<<] tl 5 は足りない適用（L）で、tl は呼ばれない", src([TL, "[<<] tl 5"]), "(: tl (? [[y ~ys]] (defer {ys})))", null, { at: 0 }],
	["R32 [<<] tl 5 の根は L（根なので `_`、R42）", src([TL, "[<<] tl 5"]), "(unit (apply (compose [<<] tl) 5))", "A"],
	// ほかの足りたか決まらない頭も同じ：アリティの分からない点なし（`[,]`。前の見本の `[|]`・`[*]` は R31 で畳むようになった）・
	// 既定値のある関数（Q8）・撒く項を含む並び（k を数えない）。撒く項は、合成も最初の関数への適用から畳む（applyKind の頭）ので、
	// 前は合成ごと未知で返していた。2026-10-24 の試し（R51）から、撒く項は流れの1項で、口が1つの最初の関数（inc）は写像で値を返すので、
	// 撒く項は「足りたか決まらない頭」ではなくなった（下の2行）。
	["Q27 [,] tl 2 3 の tl は未知を受けて実体を作る（前は [*] tl 2 3）", src([TL, "[,] tl 2 3"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 0 }],
	["Q27 go tl xs（既定値のある関数）の tl は未知を受けて実体を作る", src([...GO_DEFAULT, TL, "go tl xs"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 2 }],
	// 2026-10-24 の試し（R51）：撒いた流れは inc の口（1つ）に入って写像になり、写した List（中身の見えない A）が tl へ流れる（R11。
	// `tl (inc vs~)` と同じ）。前は撒く項で k を数えないので inc の適用が未知で、tl は未知を受けて実体を作り、根は未知だった。
	["Q27 inc tl vs~（R51 の写像の後、試し）の tl は A を受けて実体を作る（前は U）", src([INC, "vs : 1 , 2", TL, "inc tl vs~"]), "(: tl (? [[y ~ys]] (inst A ys)))", null, { at: 2 }],
	["Q27 inc tl vs~ の根は A（R51、試し。前は未知）", src([INC, "vs : 1 , 2", TL, "inc tl vs~"]), "(apply (compose inc tl) vs~)", "A"],
	// 今は：撒く項を受ける最初の関数そのものが括りの関数なら、実体を作らない（R24「撒く項があれば k は数えない（未知）」。
	// 合成でない頭の「R24 n 4 vs~ 5 では実体を作らない」と同じ）。だから `bad inc vs~` は bad の本体を読まずに通り、後ろに
	// 置いた `inc bad vs~` は未知を受けた bad の実体で G5（下の composeRefused の Q27 の行）。Q27 が問題にした非対称（頭に
	// 置くだけで本体の門をすり抜ける）が、撒く項を受ける括りの関数に残っている。撒く項を受けた括りの関数の当て方（どの
	// 仮引数に何が入るか）は k が数えられないので決まらず、未知を受けて作るか・名指しの門で断るかは決めていない（§5 の未決、
	// 合成の畳み込みの確かめの F3）。決まったら、この2行を裏返す。
	["今は bad inc vs~（撒く項を受ける最初の括りの関数）は実体を作らない", src([INC, "vs : 1 , 2", BAD, "bad inc vs~"]), "(: bad (? [[y ~ys]] (defer {[+ 1] _ _})))", null, { at: 2 }],
	["今は bad 1 vs~（合成でない頭）も実体を作らない", src(["vs : 1 , 2", BAD, "bad 1 vs~"]), "(: bad (? [[y ~ys]] (defer {[+ 1] _ _})))", null, { at: 1 }],
	// 後ろに素の関数だけなら、根を引かずに未知のまま（Q28）。前は `[+] inc 5` で見ていた（R31 で A になった）。
	["守り [,] inc 5（後ろが素の関数なら未知のまま）", src([INC, "[,] inc 5"]), "(apply (compose [,] inc) 5)", "未知"],
];
const composeRefused = [
	["直した pa bad [1 2]（頭の括りの関数の実体の根が未知）", src([PA, BAD, "pa bad [1 2]"]), "G5", [["bad", "U"]]],
	["直した hl bad [1 2]（頭の括りの関数の実体の根が未知）", src([INC, HL, BAD, "hl bad [1 2]"]), "G5", [["bad", "U"]]],
	["直した uu bad 1（頭の素の関数の本体の根が未知、k = n。前は adder bad 1）", src([UU, BAD, "uu bad 1"]), "G5", [["bad", "U"]]],
	// 2026-10-23 の左からの畳み込みでは `(5 uu) bad`：種類の未知な `5 uu` の後ろに bad が来る G2(a)（R40 の読み6）だった。前は強さの順で
	// `uu bad` の合成が先にでき、bad が未知を受けた実体で G5。逆適用の廃止（R47）で、uu は 5 を取らず、合成 `uu bad` が 5 の後ろに積まれて
	// 余る（bad は呼ばれない）。通る側（norevPasses）へ移した。
	["直した t : y ? uu bad y（素の関数の本体の中）", src([UU, BAD, "t : y ? uu bad y"]), "G5", [["bad", "U"]]],
	["直した [' 0] bad fs（頭が段18 の点なしに1項）", src([INC, DOUBLE, "fs : inc , double", BAD, "[' 0] bad fs"]), "G5", [["bad", "U"]]],
	["穴 inc uu tr 1（途中で未知になった後の括りの関数は未知を受ける）", src([INC, UU, TR, "inc uu tr 1"]), "G7", [["tr", "U"]]],
	// `pu inc [1] double`（最後の括りの後ろに合成が続き、未知を受けて通る、R41）と `pr inc [1] 2 3 double`（いちばん上の余り 3 を取る、
	// R40）は、2026-10-23 から通る。下の「左からの畳み込み」へ移した。
	// 前の `穴 pair inc [1] double 5`（足りない合成が適用の頭、G2(b)）は、R36 で流れとして通る（下の「余りと流れ」の行）。
	// 足りたか決まらない頭でも、後ろの括りの関数は未知を受けて実体を作る（§5 Q27。前は実体を作らずに通していた）。
	["Q27 で裏返した [,] bad 5（前は [+] bad 5 で通っていた）", src([BAD, "[,] bad 5"]), "G5", [["bad", "U"]]],
	// R31 で `[+] 5` は値になったので、bad は A を受ける（前は U）。本体の門は受けた物に依らず G5。
	["R31 で変わった [+] bad 5 は bad を形 A で名指し（前は U）", src([BAD, "[+] bad 5"]), "G5", [["bad", "A"]]],
	["Q27 go bad xs（既定値のある関数、前は通っていた）", src([...GO_DEFAULT, BAD, "go bad xs"]), "G5", [["bad", "U"]]],
	// 2026-10-24 の試し（R51）：inc の写像の結果（中身の見えない A）を bad が受ける（前は未知の U）。本体の門は受けた物に依らず G5。
	["Q27 inc bad vs~（撒く項、前は通っていた。R51 で bad は A を受ける、試し）", src([INC, "vs : 1 , 2", BAD, "inc bad vs~"]), "G5", [["bad", "A"]]],
];
for (const [name, s, want, kind, extra] of composePasses) checkPass(`確かめ ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of composeRefused) checkRefused(`確かめ ${name}`, s, want, inst);

// 最初の関数の結果が未知なら、その前に関数を足しても、後ろの括りの関数が受ける物は同じ（未知）。だから `h g a` と
// `inc h g a` で、後ろの括りの関数 g の答え（定義の行の木、断るなら門と名指し）は同じ。直す前は、h が頭のときだけ g の
// 実体を作らなかった。
law("頭の結果が未知なら、h g a と inc h g a で後ろの括りの関数の答えが同じ", () => {
	const gs = [["bad", BAD], ["tl", TL], ["tr", TR]];
	const heads = [
		["pa", [PA], "[1 2]"],
		["hl", [HL], "[1 2]"],
		["uu", [UU], "1"],
		["[' 0]", [DOUBLE, "fs : inc , double"], "fs"],
		// 足りたか決まらない頭（§5 Q27。合成を適用の畳み込みにして、ほかの頭と同じになった）。前は `[+]`・`[|]` に1項で見ていたが、
		// R31 で数1つは値になったので、アリティの分からない `[,]` と、中身の見えない A を1項で畳む `[&]`（R31 の1項で未知）に替えた。
		["[,]", [], "5"],
		["[&]", [], "(inc 5)"],
		["inc", ["vs : 1 , 2"], "vs~"],
	];
	const look = (s, g) => {
		try {
			const r = resolve(s);
			return show(r.trees.find((t) => show(t).startsWith(`(: ${g} (? `)));
		} catch (e) {
			return `断り ${e.gate || e.reason} ${JSON.stringify((e.instances || []).map((i) => [i.fn, i.shape]))}`;
		}
	};
	const out = [];
	for (const [g, gDef] of gs) {
		for (const [h, hDefs, a] of heads) {
			const defs = [INC, ...hDefs, gDef];
			const x = look(src([...defs, `${h} ${g} ${a}`]), g);
			const y = look(src([...defs, `inc ${h} ${g} ${a}`]), g);
			if (x !== y) out.push(`${h} ${g} ${a}：${x}`, `inc ${h} ${g} ${a}：${y}`);
			else if (x.includes("(defer ")) out.push(`${h} ${g} ${a}：どちらも実体を作っていない ${x}`);
		}
	}
	return out;
});

// ---------------------------------------------------------------------------
// 合成は適用の畳み込み（2026-10-19）
// ---------------------------------------------------------------------------
//
// 合成の適用は適用の繰り返しである：(g∘f) x = g (f x)。合成は左から実行する（R11）ので、`f1 f2 … fm x` は
// fm (… (f2 (f1 x)) …)。前は合成の行（§3.4）を適用とは別の表として育て、後ろの関数を名簿（本体の根が A のアリティ1の
// 素の関数・その部分適用・貪欲な単項・アリティ1の括りの関数）で数えていたので、直接書いた g (f x) と答えが割れていた
// （§5 Q13・Q24・Q26・Q27 は、その割れが表に出た物）。主の Claude の提案「合成の適用を、適用を左から畳む形に作り直して
// 合成用の表を消す」に、利用者 2026-10-19「質問が続いてたから気付いてたよ。その方向でお願い」。
// 法則から決まり直した所（前の答えから変わった所）：
// - 後ろの非貪欲の点なしの単項（`inc [+ 1] 5`）：前は未知（§5 Q13 の行。Q13 の出どころ U 09-28 22:07「inc [+]」は `[+]` と
//   アリティ2以上の話で、非貪欲の単項は表を作った側の慎重さだった）→ A。
// - 後ろの穴の書き換えとその部分適用：前は未知（Q26 の注）→ A（上の「答え」の Q26 の行）。
// - 最初が段18 の点なし（`[' 0] inc [1 2 3]`）：前は未知 → 引いた物の生まれ（R26）で A になりうる。
// - 最初が足りたか決まらない頭（Q27）：後ろの括りの関数も未知を受けて実体を作る（上の「確かめ」の Q27 の行）。
// - 後ろの関数は、前の結果の形を受ける（前が括りの関数の実体や素の関数なら中身の見えない A なので今までと同じ。前が
//   点なしの引きなら形が付く）。
// 前の結果が L か未知なら、そこから先は未知（関数を値として次へ渡す読みは決めていない）。直接書いた g (f x) は、f x が
// 未知なら未知の項を並びに置くので G7 だが、合成は節ごと未知にして根なら通す。だから下の法則は、f x が A の所で比べる。

const FOLD_DEFS = [
	INC,
	DOUBLE,
	"add : x y ? x + y",
	"pr : x y ? y",
	"pq : x y ? [,] y", // 本体の根が未知（前は `? inc` で根が L。根が L の関数は G16、R33）
	"f3 : a b c ? c",
	UU, // 前は ADDER（本体の根が L）
	"head : [x ~xs] ? x",
	TL,
	BAD,
	"pb : [a] [b] ? a + b",
	"pt : [a ~as] y ? y",
	"i : !_",
];
const foldPasses = [
	["Q13 で変わった inc [+ 1] 5（後ろの非貪欲の単項、前は未知）", src([INC, "inc [+ 1] 5"]), "(apply (compose inc [+ 1]) 5)", "A"],
	// 後ろの inc は、2026-10-23 までは逆適用で節を取り（`(apply inc (apply (compose inc [+ 1]) 5) ·rev)`）、R47 から積まれて余る（R42・R48）。
	["Q13 で変わった inc [+ 1] 5 inc（前は G2(a)、その後 逆適用）", src([INC, "inc [+ 1] 5 inc"]), "(construct (apply (compose inc [+ 1]) 5) (unit inc))", "A"],
	// 前置の点なしの単項 `[-_]`（2026-10-21 に一度 G14・R30 の `[-a]` にして、同じ日に戻した）。
	["Q13 で変わった inc [-_] 5（前置の点なしの単項）", src([INC, "inc [-_] 5"]), "(apply (compose inc [-_]) 5)", "A"],
	// 後ろの恒等射（括らない `!_` の名前 `i : !_`）は前の結果を desc ごと通す。前は括った `[!_]` で試していたが、`[!_]` は
	// 否定の点なしになった（U 2026-10-21 08:24）。否定の点なしは単項の点なしと同じく中身の見えない A を返すので、形を運ばない。
	["後ろの恒等射 inc i 5（i : !_）", src([INC, "i : !_", "inc i 5"]), "(apply (compose inc i) 5)", "A"],
	["後ろの恒等射は形を運ぶ [' 0] i head [[1 2] [3 4]]（i : !_）", src(["head : [x ~xs] ? x", "i : !_", "[' 0] i head [[1 2] [3 4]]"]), "(: head (? [[x ~xs]] (inst [N…] x)))", null, { at: 0 }],
	["否定の点なしは形を運ばない [' 0] [!_] head [[1 2] [3 4]]", src(["head : [x ~xs] ? x", "[' 0] [!_] head [[1 2] [3 4]]"]), "(: head (? [[x ~xs]] (inst A x)))", null, { at: 0 }],
	["Q13 で変わった inc [+ 1] 5 6（流れの余りは後ろに積む、R36。前は余りの印 excess）", src([INC, "inc [+ 1] 5 6"]), "(construct (apply (compose inc [+ 1]) 5) 6)", "A", { leftover: true }],
	// R31 で `[+]` に数1つは値（§5 Q17 は閉じた）が、`inc 5` は中身の見えない A なので、後ろの `[+]` は今までどおり未知（R31 の1項）。
	["守り inc [+] 5（後ろの [+] に中身の見えない A は未知のまま、R31）", src([INC, "inc [+] 5"]), "(apply (compose inc [+]) 5)", "未知"],
	["守り [' 0] [+] [[1 2] [3 4]]（引いた List は要素が全部 A と見えるので A）", src(["[' 0] [+] [[1 2] [3 4]]"]), "(apply (compose [' 0] [+]) [[1 2] [3 4]])", "A"],
	["守り inc [<<] 5（後ろの畳まない点なしに1項は足りない適用で L、R32。前は未知。根なので `_`、R42）", src([INC, "inc [<<] 5"]), "(unit (apply (compose inc [<<]) 5))", "A"],
	["R26 で変わった [' 0] inc [1 2 3]（最初が段18 の点なし、前は未知）", src([INC, "[' 0] inc [1 2 3]"]), "(apply (compose [' 0] inc) [1 2 3])", "A"],
	// `[' 0] inc [1 2 3] double`（前は G2(a)、2026-10-23 は通る）は、2026-10-24 から G2(a)（下の foldRefused）。
	["守り [' 0] inc fs（引いた物が見えなければ未知のまま）", std("[' 0] inc fs"), "(apply (compose [' 0] inc) fs)", "未知"],
	["守り [' say] inc m（引いた物が関数なら未知のまま）", src([...M, INC, "[' say] inc m"]), "(apply (compose [' say] inc) m)", "未知"],
	["形を受ける [' 0] head [[1 2] [3 4]]（head は引いた物の形を受ける）", src(["head : [x ~xs] ? x", "[' 0] head [[1 2] [3 4]]"]), "(: head (? [[x ~xs]] (inst [N…] x)))", null, { at: 0 }],
	["形を受ける [' 0] head [[1 2] [3 4]] は A（前は未知）", src(["head : [x ~xs] ? x", "[' 0] head [[1 2] [3 4]]"]), "(apply (compose [' 0] head) [[1 2] [3 4]])", "A"],
	["形を受ける [' 0] [' 0] [[1 2] [3 4]]（前は未知）", src(["[' 0] [' 0] [[1 2] [3 4]]"]), "(apply (compose [' 0] [' 0]) [[1 2] [3 4]])", "A"],
	// 合成の節の種類は、最後の結果の desc を形ごと持つ（直接書いた `head ([' 0] ([' 0] …))` の head が受ける物と同じ、R11・
	// R26）。根に置くと「A」としか見えないので、desc を読む head に渡して見る。合成の畳み込みの確かめの F1：最後の desc を中身の
	// 見えない A に潰しても、前の試験は全部通っていた（head が `(inst A x)` で、根が未知になる）。
	["形を運ぶ head ([' 0] [' 0] [[1 2] [3 4]]) の head は数を受ける", src(["head : [x ~xs] ? x", "head ([' 0] [' 0] [[1 2] [3 4]])"]), "(: head (? [[x ~xs]] (inst N x)))", null, { at: 0 }],
	["形を運ぶ head ([' 0] [' 0] [[1 2] [3 4]]) は A", src(["head : [x ~xs] ? x", "head ([' 0] [' 0] [[1 2] [3 4]])"]), "(apply head [[' 0] [' 0] [[1 2] [3 4]]])", "A"],
	["形を運ぶ v : [' 0] [' 0] [[1 2] [3 4]] を名前で渡す head v の head は数を受ける", src(["head : [x ~xs] ? x", "v : [' 0] [' 0] [[1 2] [3 4]]", "head v"]), "(: head (? [[x ~xs]] (inst N x)))", null, { at: 0 }],
	["形を運ぶ v : [' 0] [' 0] [[1 2] [3 4]] の後の head v は A", src(["head : [x ~xs] ? x", "v : [' 0] [' 0] [[1 2] [3 4]]", "head v"]), "(apply head v)", "A"],
	["守り inc head [5 6 7]（前が素の関数なら中身の見えない A を受ける）", src([INC, "head : [x ~xs] ? x", "inc head [5 6 7]"]), "(: head (? [[x ~xs]] (inst A x)))", null, { at: 1 }],
];
const foldRefused = [
	["形を受ける [' 0] bad [[1 2] [3 4]] は形 [N…] で名指し（前は U）", src([BAD, "[' 0] bad [[1 2] [3 4]]"]), "G5", [["bad", "[N…]"]]],
	// 段18 の点なしが [1 2 3] を受けた後に関数（double・head）が来る。点なしの口の数は決まっていない（§5 Q39、R41 の読み8）。2026-10-23
	// までは、引いた物が値なら、閉じた読み（閉じて値になり、後ろの関数が逆適用でそれを取る）と開いた読み（まだ受けていて、後ろの関数は
	// 合成）が同じ答えなので通していた（`[' 0] inc [1 2 3] double` は `double (inc 1)`、`… head` は未知）。逆適用の廃止（R47）で、閉じた読みの
	// 後ろの関数は値の後ろに積まれて値を取らない（`(inc 1) double` で double が余る）ので、2つの読みが割れる。`[,] 5 g 3` と同じく G2(a)。
	["R47 [' 0] inc [1 2 3] double（前は G2(a)、その後 通る。R47 で G2(a)）", src([INC, DOUBLE, "[' 0] inc [1 2 3] double"]), "G2(a)"],
	["R47 [' 0] inc [1 2 3] head（前は G2(a)、その後 G8・通る。R47 で G2(a)）", src([INC, "head : [x ~xs] ? x", "[' 0] inc [1 2 3] head"]), "G2(a)"],
];
for (const [name, s, want, kind, extra] of foldPasses) checkPass(`合成 ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of foldRefused) checkRefused(`合成 ${name}`, s, want, inst);

// 合成は適用の繰り返し：f x が A なら、`f g x` と直接書いた `g (f x)` は、根が A かどうかと、定義の行の木（括りの関数の
// 実体）と、断るなら門と名指しが同じ。後ろが2つの `f g h x` と `h (g (f x))` も、g (f x) が A なら同じ。前の実装では、後ろの
// 非貪欲の単項・穴・最初の `[' k]` で割れていた。g (f x) が足りない適用（L）のとき、比べるのは A かどうかだけにする。
// 2026-10-22 から、合成は流れとして左から畳む（R36、§5 Q4 の答え U〔答え〕10-21 23:18）。直接書く側も流れの読みで書く：f は x の
// 前から自分のアリティ分 x1 … xn だけを取り、g は `g (f x1 … xn)` の後ろに流れの次の物を（g のアリティ − 1 個）取る。最後に残った
// 物は後ろに積む（`(… ) xm`、R35）。アリティは下の表で、試験の側が自分で数える（実装の flowArity を使わない）。並び全体を受ける
// 関数（アリティ null）に流れの余りが残ったまま届く形は、合成が G12(c) で断ることだけを見る（§5 Q13 の残り）。最後の結果が値でない
// のに余りが残る形は、合成が G12(b) で断ることを見る（直接書いた側は、未知の括りの葉を並びに置くので G7）。
// 段18 の点なし `[' 0]` は "pick"：前にある流れが1項のときだけ 1 と数え、2項以上なら null（直に当てた `[' 0] x y` の k ≠ 1 が未知
// なのと同じ。確かめ 2026-10-22。前は 1 で、流れの中でだけ口を1つと数えていた）。最初の恒等射 i が2項以上を受けて、後ろに恒等射・
// 貪欲な単項でない関数が続く形も、合成が G12(c) で断ることだけを見る（R29 の「並び全体を受ける」と単位律が割れる。確かめ 2026-10-22）。
// 2026-10-23 の左からの畳み込み（R40・R41）で、流れは畳み込みの1歩そのもの（後から来る物は最初の関数から順に流れ込む）になった。
// 変わったのは2つ：並び全体を受ける関数（アリティ null）は、流れの余りが残っていても並びの終わりまで受ける（R41。前の G12(c) の
// 枝は、直接書いた `g (f x1 … xn) xn+1 …` と比べる枝になる）。最後の結果が値でないのに余りが残る形は G2(a)（R40 の読み6、前は
// G12(b)）。恒等射の割れは G18（前は G12(c)）で、恒等射が続くならその先の最初の恒等射でない関数で見る（試験の側も同じに数える）。
const FLOW_ARITY = new Map([
	["inc", 1], ["double", 1], ["[+ 1]", 1], ["[-_]", 1], ["i", null], ["[* 2,]", null], ["[+]", null], ["add", 2], ["uu", 1], ["pq", 2],
	["(pr 1)", 1], ["(pq 1)", 1], ["[add _ 10]", 1], ["([f3 _ _ 3] 1)", 1], ["head", null], ["tl", null], ["bad", null], ["pb", null],
	["(pt [1])", 1], ["[' 0]", "pick"], ["pt", 2],
]);
// 前に n 項の流れがあるときの、関数 f が流れから取る数。
const flowArityAt = (f, n) => {
	const a = FLOW_ARITY.get(f);
	return a === "pick" ? (n === 1 ? 1 : null) : a;
};
law("合成は左から畳む（R40。前は R36 の流れ）：f g x と、流れを括りで書いた g (f x1 … xn) xn+1 …", () => {
	const look = (s) => {
		try {
			const r = resolve(s);
			const ts = r.trees.map((t) => show(t));
			const last = r.trees[r.trees.length - 1];
			return { a: kindOf(last) === "A", defs: ts.slice(0, -1).join(" | ") };
		} catch (e) {
			return { refused: `${e.reason} ${e.gate || ""} ${JSON.stringify((e.instances || []).map((i) => [i.fn, i.shape]))}` };
		}
	};
	const same = (p, q) => JSON.stringify(p) === JSON.stringify(q);
	const isA = (expr) => {
		const r = look(src([...FOLD_DEFS, expr]));
		return !r.refused && r.a;
	};
	// [最初の関数, 実引数の項の並び]。余りの残る物（`inc 5 6`・`pt [1] 2 3`）を混ぜる。
	const FIRSTS = [
		["inc", ["5"]],
		["inc", ["5", "6"]],
		["inc", ["5", "6", "7"]],
		["[+ 1]", ["5"]],
		["[* 2,]", ["1", "2", "3"]],
		["[+]", ["5", "6"]],
		["(pr 1)", ["5"]],
		["[add _ 10]", ["5"]],
		["head", ["[5 6 7]"]],
		["head", ["5", "6", "7"]],
		["[' 0]", ["[1 2 3]"]],
		["[' 0]", ["[[1 2] [3 4]]"]],
		["pt", ["[1]", "2"]],
		["pt", ["[1]", "2", "3"]],
		// 恒等射（確かめ 2026-10-22）。2項を受けた i の後ろに、恒等射・貪欲な単項でない関数が続けば G12(c)（2026-10-23 から G18）。
		["i", ["5"]],
		["i", ["5", "6"]],
	];
	const LATER = ["inc", "double", "[+ 1]", "[-_]", "i", "[* 2,]", "[+]", "add", "uu", "pq", "(pr 1)", "(pq 1)", "[add _ 10]", "([f3 _ _ 3] 1)", "head", "tl", "bad", "pb", "(pt [1])", "[' 0]"];
	const LATER2 = ["inc", "[+ 1]", "(pr 1)", "[add _ 10]", "head", "tl", "bad", "[' 0]", "add"];
	const out = [];
	const count = {
		A: 0,
		"A でない": 0,
		断る: 0,
		"余りを積んで比べた": 0,
		"並び全体を受ける関数が流れの余りまで受けた（R41、前は G12(c)）": 0,
		"G18（恒等射が2項以上を受けて後ろに関数）": 0,
		"G2(a)（余りの前の結果が値でない、前は G12(b)）": 0,
	};
	// 流れ（R40）を括りで書く。steps は途中の括りの綴り（最後が g の適用）、left は最後に残って後ろに積む項。並び全体を受ける関数は、
	// 流れの余りも並びの終わりまで受ける（R41。wide はその数）。恒等射が2項以上を受けて、その先の最初の恒等射でない関数が貪欲な単項で
	// なければ cut（G18）。
	const flow = (fs, xs) => {
		const a0 = flowArityAt(fs[0], xs.length);
		let cur = a0 === null || xs.length <= a0 ? `${fs[0]} ${xs.join(" ")}` : `${fs[0]} ${xs.slice(0, a0).join(" ")}`;
		let rest = a0 === null || xs.length <= a0 ? [] : xs.slice(a0);
		const steps = [cur];
		let wide = 0;
		const idCut = (j, got) => {
			if (fs[j] !== "i" || got < 2) return false;
			const next = fs.slice(j + 1).find((g) => g !== "i");
			return next !== undefined && next !== "[* 2,]";
		};
		if (idCut(0, a0 === null ? xs.length : Math.min(xs.length, a0))) return { steps, cut: true };
		for (let j = 1; j < fs.length; j++) {
			const g = fs[j];
			const b = flowArityAt(g, 1 + rest.length);
			if (b === undefined) throw new Error(`FLOW_ARITY に ${g} が無い`);
			const take = b === null ? rest : rest.slice(0, b - 1);
			if (b === null && rest.length) wide++;
			if (idCut(j, 1 + take.length)) return { steps, cut: true };
			rest = rest.slice(take.length);
			cur = `${g} (${cur})${take.length ? ` ${take.join(" ")}` : ""}`;
			steps.push(cur);
		}
		return { steps, direct: rest.length ? `(${cur}) ${rest.join(" ")}` : cur, left: rest.length, wide };
	};
	const check = (fs, xs) => {
		const composed = `${fs.join(" ")} ${xs.join(" ")}`;
		const c = look(src([...FOLD_DEFS, composed]));
		const fl = flow(fs, xs);
		if (fl.cut) {
			count["G18（恒等射が2項以上を受けて後ろに関数）"]++;
			if (!(c.refused && c.refused.startsWith("coproduct-identity-row G18"))) out.push(composed, `  恒等射が2項以上を受けて後ろに関数が続くのに G18 で断っていない: ${JSON.stringify(c)}`);
			return;
		}
		const lastStep = look(src([...FOLD_DEFS, fl.steps[fl.steps.length - 1]]));
		if (fl.left && !lastStep.refused && !lastStep.a) {
			count["G2(a)（余りの前の結果が値でない、前は G12(b)）"]++;
			if (!(c.refused && c.refused.startsWith("coproduct-partial-neighbor G2(a)"))) out.push(composed, `  余りの前の結果が値でないのに G2(a) で断っていない: ${JSON.stringify(c)}`);
			return;
		}
		if (fl.wide) count["並び全体を受ける関数が流れの余りまで受けた（R41、前は G12(c)）"]++;
		const d = look(src([...FOLD_DEFS, fl.direct]));
		if (!same(c, d)) out.push(`${composed}  ⇔  ${fl.direct}`, `  合成: ${JSON.stringify(c)}`, `  直接: ${JSON.stringify(d)}`);
		if (fl.left) count["余りを積んで比べた"]++;
		if (c.refused) count.断る++;
		else if (c.a) count.A++;
		else count["A でない"]++;
	};
	for (const [f, xs] of FIRSTS) {
		const n1 = flow([f], xs).steps[0];
		if (!isA(n1)) {
			out.push(`前提が崩れた：${n1} が A でない`);
			continue;
		}
		for (const g of LATER) {
			check([f, g], xs);
			const fl = flow([f, g], xs);
			if (!LATER2.includes(g) || fl.cut || !isA(fl.steps[1])) continue;
			for (const h of LATER2) check([f, g, h], xs);
		}
	}
	// 比べる組が全部同じ読みなら、法則は何も見ていない。
	for (const [k, v] of Object.entries(count)) if (!v) out.push(`「${k}」の組が無い（法則がその枝を見ていない）`);
	return out;
});

// ---------------------------------------------------------------------------
// §5 Q30：値を含む輪（2026-10-20）
// ---------------------------------------------------------------------------
//
// 値の定義を含む輪は、どこから入っても名前の輪（name-cycle）で断り、言い分に輪の道筋を書く（resolve.js の「値を含む輪」）。
// 前は、値の定義から入れば断り、関数から入れば仮置きで閉じて黙って通った（`a : f 1`・`v : f 1`・`f : x ? v` は、v が先なら
// name-cycle、a が先なら A）。v = f 1 = v で、値はいつまでもできない（主の Claude「本当の欠陥は a が先だと通ってしまうほう」、
// 利用者 2026-10-20「明らかにそうだと思う」）。解決器の役目は、意味を決めることではなく、書いた人が見落とした輪（長い輪）を、
// 入口に依らずに必ず見つけて、輪の道筋を名指しすることである。
// 輪に値の定義が無い物（関数どうしの再帰・括りの関数の実体の輪）は、今までどおり仮置きで閉じて通る。`$` で遅らせた名前は
// 種類を引かない（touchName）ので輪に数えない（今のまま。利用者「$で書くことになればそれはそれで何か起こりそうだけど…」、
// この片では扱わない）。既定値を覗いた所（namesPattern）を通る輪も、既定値は解かない（P3）ので輪に数えない（HEAD のまま）。
// どの形も、文の並べ方を全部回す。断る形は、どの並べ方でも name-cycle で、道筋（e.cycle と言い分）が同じ輪であること。道筋の
// 書き始めは、輪の中の値の定義のうち先に書いた物（resolve.js の cycleError）なので、値の定義が2つ以上の輪は、輪を回した物
// の中で、その並べ方で先に書いた値の定義から始まる物と比べる。通る形は、どの並べ方でも同じ木と種類であること。

const Q30_PERMS = (n) => {
	const out = [];
	const go = (rest, acc) => {
		if (!rest.length) out.push(acc);
		rest.forEach((u, i) => go([...rest.slice(0, i), ...rest.slice(i + 1)], [...acc, u]));
	};
	go([...Array(n).keys()], []);
	return out;
};
// [名前, 文（1文は行の配列）, 輪の道筋（書き始めは問わない。値の定義は `名前` だけ）]
const Q30_CYCLES = [
	["a・v・f（§5 Q30 の例）", [["a : f 1"], ["v : f 1"], ["f : x ? v"]], ["`v`", "`f` の本体"]],
	["a・v・f と f を呼ぶ行", [["a : f 1"], ["v : f 1"], ["f : x ? v"], ["f 2"]], ["`v`", "`f` の本体"]],
	["3つ以上の輪（v → g → h → v）", [["v : g 1"], ["g : x ? h x"], ["h : y ? v"]], ["`v`", "`g` の本体", "`h` の本体"]],
	["3つ以上の輪に外から入る（a が g を呼ぶ）", [["a : g 1"], ["v : g 1"], ["g : x ? h x"], ["h : y ? v"]], ["`v`", "`g` の本体", "`h` の本体"]],
	["括りの関数の実体を通る輪", [["a : p [1]"], ["v : p [1]"], ["p : [x] ? v"], ["p [2]"]], ["`v`", "`p` を形 N で呼んだ実体の本体"]],
	["欄で渡した関数を通る輪", [["a : hb [s : f]"], ["hb : [s] ? s 1"], ["v : hb [s : f]"], ["f : x ? v"]], ["`v`", "`hb` を形 {s:L} で呼んだ実体の本体", "`f` の本体"]],
	["無名の関数の本体を通る輪", [["a : f 1"], ["v : [w ? f w] 1"], ["f : x ? v"], ["f 2"]], ["`v`", "無名の関数 `[w ? f w]` の本体", "`f` の本体"]],
	["根に使わない所で引く輪（積の中）", [["inc : x ? x + 1"], ["a : inc f 1"], ["v : (f 1) , 1"], ["f : x ? v"]], ["`v`", "`f` の本体"]],
	["値の定義が2つの輪（関数を挟む）", [["a : f 2"], ["v : f 1"], ["w : v"], ["f : x ? w"]], ["`v`", "`f` の本体", "`w`"]],
	["値の定義だけの輪", [["v : w"], ["w : v"]], ["`v`", "`w`"]],
	// 輪を値の定義の無い所（g → k → g）で先に閉じ、閉じた k の答えが未知の形。未知の記録は仮置きの依りを持たないので、輪の
	// 依り（resolve.js の「値を含む輪」の注）が無いと、a が先なら vk が k の記録を読んでも g を通ったことが見えず、黙って通った
	// （1つ目、HEAD からある）か、k の本体の門で断った（2つ目）。vk が先なら name-cycle。
	["未知で閉じた関数の記録を通る輪（仮置きが外れて未知）", [["inc : x ? x + 1"], ["a : g 1"], ["g : x ?", "\tk x", "\tvk", ""], ["k : x ?", "\tg x", "\tk x", "\tinc", ""], ["vk : k 1"]], ["`vk`", "`k` の本体", "`g` の本体"]],
	["未知で閉じた関数の記録を通る輪（門で未知）", [["a : g 1"], ["g : x ?", "\tk x", "\tvk", ""], ["k : x ?", "\tg x", "\t[+ 1] _ _", ""], ["vk : k 1"]], ["`vk`", "`k` の本体", "`g` の本体"]],
	// 記録を通して見つけた輪の道筋に、記録の中の段を書く（確かめ 2026-10-20 の Q30-V2）。前は記録の持ち主の1歩しか書かず、a が
	// 先なら「`vk` → `m` の本体 → `g` の本体」（m の本体は g を引かない）、vk が先なら k まで書いて、並べ方の半分ずつに割れた。
	["記録の中の段を道筋に書く（m → k → g）", [["a : g 1"], ["g : x ?", "\tm x", "\tvk", ""], ["m : x ? k x"], ["k : x ? g x"], ["vk : m 1"]], ["`vk`", "`m` の本体", "`k` の本体", "`g` の本体"]],
	// 未知の記録が、閉じた枠（m）の輪の依り（g）を引き継ぐ形（確かめ 2026-10-20 の Q30-V3）。引き継ぎ（finishFrame）が無いと、
	// a が先なら黙って通った。
	["未知の記録が閉じた枠の輪の依りを引き継ぐ", [["inc : x ? x + 1"], ["a : g 1"], ["g : x ?", "\tm x", "\tvk", ""], ["m : x ?", "\tr x", "\tg x", ""], ["r : x ?", "\tm x", "\tinc", ""], ["vk : r 1"]], ["`vk`", "`r` の本体", "`m` の本体", "`g` の本体"]],
	// 未知の記録（r）を読んだ関数（y）がまた未知で閉じ、それを値が読む2段の形（確かめ 2026-10-20 の Q30-V4）。記録を通るときに
	// 上の枠へ依りを足す所（passThrough）が無いと、a が先なら黙って通った。
	["未知の記録を読んだ関数がまた未知で閉じる（2段）", [["inc : x ? x + 1"], ["a : g 1"], ["g : x ?", "\tr x", "\ty x", "\tvk", ""], ["r : x ?", "\tg x", "\tinc", ""], ["y : x ? r x"], ["vk : y 1"]], ["`vk`", "`y` の本体", "`r` の本体", "`g` の本体"]],
	// 既定値を覗いた v の計算の中だけで閉じる輪（vk → k → h → vk）。覗いた所を通らない本物の輪なので、namesPattern は投げ直す。
	// 例外で抜けた枠の印（下の行）が無い作りで、覗きの名前の輪を全部握りつぶすと、a が先なら黙って通った（resolve.js の
	// namesPattern の注。今は全部を握りつぶしても印が同じ輪を見つけ直すので、この行は、どの並べ方でも断ることだけを見る）。
	["既定値を覗いた定義の中だけで閉じる輪", [["a : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["v : h 1"], ["h : x ?", "\tk x", "\tvk", ""], ["k : x ?", "\th x", "\t[+ 1] _ _", ""], ["vk : k 1"]], ["`vk`", "`k` の本体", "`h` の本体"]],
	// 覗いた v の中で、h の行 `g x` が覗いた所を通る輪（h → g → 覗き → v）で抜ける。k は h を読んで未知で閉じた記録として残るので、
	// 例外で抜けた h の枠を輪の依りに持つ記録に古いと印を付けないと、a が先なら、vk が k の記録を読んでも h を通ったことが
	// 見えず、黙って通った（resolve.js の「値を含む輪」の注の、例外で抜けた枠）。
	["既定値の覗きが抜けた後の記録を通る輪", [["a : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["v : h 1"], ["h : x ?", "\tk x", "\tg x", "\tvk", ""], ["k : x ?", "\th x", "\t[+ 1] _ _", ""], ["vk : k 1"]], ["`vk`", "`k` の本体", "`h` の本体"]],
	// 1項の `:` の左（枝の条件）を覗いた所を通る輪。枝の条件は解かない（P3）が、本体を実行すれば評価するので、値は本当に
	// できない。断る側に置いている（§5 Q30 の未決。関数を1つ挟むと覗かないので通る。resolve.js の namesPattern の注）。
	["1項の `:` の左を覗いた所を通る輪（未決、断る側）", [["v : (g 1) , 1"], ["g : x ?", "\t(v 2) : 1", ""]], ["`v`", "`g` の本体"]],
];
// [名前, 文]。輪はあるが値の定義を挟まない（または `$` で遅らせた）ので、どの並べ方でも通る。
const Q30_PASSES = [
	["関数どうしの再帰に値の定義から入る", [["a : f 1"], ["f : x ? g x"], ["g : y ? f y"], ["f 2"]]],
	["関数どうしの再帰の仮置きが外れる（値の定義は輪の外）", [["inc : x ? x + 1"], ["a : f 1"], ["f : x ?", "\tg x", "\tinc", ""], ["g : y ? (f y) , 1"]]],
	["括りの関数の実体どうしの輪に値の定義から入る", [["a : ev [1 2 3]"], ["ev : [x ~xs] ? od xs"], ["od : [x ~xs] ? ev xs"], ["od 5"]]],
	["`$` で遅らせた自分の名前（今のまま）", [["v : f 1"], ["f : x ? x , $v"]]],
	["`$` で遅らせた自分の名前に外から入る（今のまま）", [["a : f 1"], ["v : f 1"], ["f : x ? x , $v"], ["v"]]],
	// 既定値を覗いた所を通る輪は、種類の輪ではない（既定値は解かず、値の無で呼ばれたときにだけ評価する。P3・§3.7）ので、HEAD の
	// まま通る（resolve.js の namesPattern の注）。前（2026-10-20 の作り直し）は、どれも全部の並べ方で name-cycle だった（確かめ
	// 2026-10-20 の Q30-V1・ADV-1）。v = g 1 = 5 で、値はできる。
	["既定値を覗いた所を通る輪（値はできる）", [["v : g 1"], ["g : x ? [[y : v 2] ? 5] x"]]],
	["既定値を覗いた所を通る輪（1文）", [["v : 1 , [[x : v 2] ? 5]"]]],
	["既定値が関数で、値の定義を呼ぶ", [["w : 1 , [[z : [u ? v u]] ? z]"], ["v : w"]]],
	// Q28V-3 の5文（`k 5 inc` の無い形）。HEAD 8fba397e でも、どの並べ方でも通った（確かめ 2026-10-20 の Q30-ADV-2）。
	["既定値を覗いた所を通る輪（Q28V-3 の5文）", [["inc : x ? x + 1"], ["w : 1 , [[x : v 2] ? 5]"], ["v : h 1"], ["h : x ?", "\tk x", "\tw", "\tinc", ""], ["k : x ? h x"]]],
	// 覗いた v の中の枠（h・v）が、覗いた所を通る輪で抜ける。抜けた後で、どの並べ方でも同じ木と種類になる。
	["既定値を覗いた所を通る輪に外から入る（覗いた中の枠が抜ける）", [["inc : x ? x + 1"], ["a : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["v : h 1"], ["h : x ?", "\tk x", "\tg x", "\tinc", ""], ["k : x ?", "\th x", "\tinc", ""]]],
];
// 書いた並べ方で、言い分の道筋の書き始め（輪の中の値の定義のうち先に書いた物）。
const q30Head = (units, order, ring) => {
	for (const u of order) {
		const name = units[u][0].split(" ")[0];
		const at = ring.indexOf(`\`${name}\``);
		if (at >= 0) return at;
	}
	return 0;
};
for (const [name, units, ring] of Q30_CYCLES) {
	total++;
	const problems = [];
	const orders = Q30_PERMS(units.length);
	for (const order of orders) {
		const s = src(order.flatMap((i) => units[i]));
		let e = null;
		try {
			resolve(s);
		} catch (err) {
			e = err;
		}
		const at = q30Head(units, order, ring);
		const want = [...ring.slice(at), ...ring.slice(0, at)];
		const path = [...want, want[0]].join(" → ");
		if (!e) problems.push(`通った: ${JSON.stringify(s)}`);
		else if (e.reason !== "name-cycle") problems.push(`${e.reason} ${e.gate || ""}: ${JSON.stringify(s)}`, e.message);
		else if (JSON.stringify(e.cycle) !== JSON.stringify(want) || !e.message.includes(`輪：${path}`)) {
			problems.push(`道筋 got: ${JSON.stringify(e.cycle)}  want: ${JSON.stringify(want)}: ${JSON.stringify(s)}`, e.message);
		}
		if (problems.length) break;
	}
	if (problems.length) fail(`Q30 値を含む輪 ${name}`, ...problems);
	else ok(`Q30 値を含む輪 ${name} → name-cycle（並べ方 ${orders.length}）`);
}
for (const [name, units] of Q30_PASSES) {
	total++;
	const problems = [];
	const orders = Q30_PERMS(units.length);
	let first = null;
	for (const order of orders) {
		const s = src(order.flatMap((i) => units[i]));
		let got;
		try {
			const r = resolve(s);
			const byUnit = [];
			order.forEach((u, j) => (byUnit[u] = `${show(r.trees[j])} : ${kindOf(r.trees[j])}`));
			got = byUnit.join(" | ");
		} catch (e) {
			got = `断り ${e.reason} ${e.gate || ""} ${e.message}`;
		}
		if (got.startsWith("断り")) problems.push(`${got}: ${JSON.stringify(s)}`);
		else if (first === null) first = got;
		else if (got !== first) problems.push(`並べ方で割れた: ${JSON.stringify(s)}`, `  ${first}`, `  ${got}`);
		if (problems.length) break;
	}
	if (problems.length) fail(`Q30 値を挟まない輪 ${name}`, ...problems);
	else ok(`Q30 値を挟まない輪 ${name} は通る（並べ方 ${orders.length}）`);
}
// 前からある直接の輪（`a : b 1`・`b : a 2`、§6.3 の「断られる」表）の言い分にも道筋が入る。
checkRefused("Q30 直接の輪の言い分", "a : b 1\nb : a 2", "name-cycle");
total++;
try {
	resolve("a : b 1\nb : a 2");
	fail("Q30 直接の輪の道筋", "通った");
} catch (e) {
	if (e.message.includes("輪：`a` → `b` → `a`")) ok("Q30 直接の輪の道筋（`a` → `b` → `a`）");
	else fail("Q30 直接の輪の道筋", e.message);
}

// ---------------------------------------------------------------------------
// §5 Q21：裸の関数を返す（2026-10-21、R33・G16）
// ---------------------------------------------------------------------------
//
// `?` で作る関数（名前の定義の右辺・括った `[x ? …]`・本体の中の局所の定義や欄の `?`）の本体の根が裸の関数（L）なら、その
// `?` の所で G16 で断る。呼ばれない定義でも断る（本体そのものがコードにできない）。関数を返すなら `$` を明示する（利用者
// 2026-10-21「adder が返すべきは [+ m] じゃなくて $[+ m]」、`$` は書く人が書く）。カリー化はシステムの側が持つので、入れ子の
// `?` も断る（主の Claude の「入れ子の `?`（`add : x ? y ? x + y`）も、裸の関数を返す形として断る？」に、利用者 2026-10-21
// 「実際には断る形なんだよ。 / 理由は、カリー化はシステムの側で持つべき。」）。
// 括りの関数は、実体の本体の根が L なら、呼んだ行で関数と形を名指しする（R25 と同じ）。呼ばれない括りの関数は本体を読まない。
// 根は解き終えた所で見る（resolve.js の bareReturnGate の注）：仮置きの上でだけ根が L になる関数は断らず、どの定義から解いても
// 同じ答えになる。根の綴りが区間なら、被演算子の種類が未知で根の種類が未知でも断る（綴りは仮置きに依らない。2026-10-22）。
// `$` で包んだ入れ子の `?`（`add : x ? $[y ? x + y]`）は、`$[+ m]` と同じく `$` で値にした関数を返す形で、本体の根は A で通る
// （主の Claude の「断ったままでいい？」に、利用者 2026-10-21 22:46「通して不都合がないなら通していいよ。」。前は G17 で断っていた。
// 下の「Q35 答え」の行）。
const BARE = [
	// 当たる形
	["区間の点なし adder : m ? [+ m]", ["adder : m ? [+ m]"]],
	["区間の点なしを呼ぶ行が先", ["adder 5", "adder : m ? [+ m]"]],
	["貪欲な点なし f : x ? [* 2,]", ["f : x ? [* 2,]"]],
	["前置の点なし f : x ? [-_]", ["f : x ? [-_]"]],
	["畳む点なし f : x ? [+]", ["f : x ? [+]"]],
	["関数の名前 f : x ? inc", [INC, "f : x ? inc"]],
	["自分の名前 f : x ? f", ["f : x ? f"]],
	["足りない適用 f : x ? add x", ["add : a b ? a + b", "f : x ? add x"]],
	["合成 f : x ? inc double", [INC, DOUBLE, "f : x ? inc double"]],
	["恒等射 f : x ? !_", ["f : x ? !_"]],
	["恒等射の名前 f : x ? i（i : !_）", ["i : !_", "f : x ? i"]],
	["穴 f : x ? add !_ x（穴の書き換えは関数）", ["add : a b ? a + b", "f : x ? add !_ x"]],
	["入れ子の ? add : x ? y ? x + y", ["add : x ? y ? x + y"]],
	["入れ子の ? を呼ぶ add 1 2", ["add : x ? y ? x + y", "add 1 2"]],
	["括りで包んだ定義 f : [x ? inc]", [INC, "f : [x ? inc]"]],
	["括った ? を行で呼ぶ [x ? inc] 5", [INC, "[x ? inc] 5"]],
	["本体の中の局所の定義の ?", [INC, "f : x ?", "\tg : y ? inc", "\tx", ""]],
	["構造体の欄の ?", [INC, "m :", "\tsay : x ? inc", "\tother : 1", ""]],
	["既定値のある関数 go : … ? inc", [INC, "go :", "\t\tys", "\t\tzs : 3", "\t? inc"]],
	["相互再帰 f : x ? g（g : y ? f y）", ["f : x ? g", "g : y ? f y", "g 1"]],
	["相互再帰（g が先）", ["g : y ? f y", "f : x ? g", "g 1"]],
	// 自分を呼ぶ再帰で仮置きが外れた関数（§3.4 の根は未知）でも、解き終えた木の根が裸の関数なら断る（実装する人の読み、断る側）。
	["仮置きが外れても木の根が L f : x ? [y ? f y]", ["f : x ? [y ? f y]"]],
	// 区間の綴り（2026-10-22、確かめで見つかった）：被演算子が A でない区間は種類が未知（pointfreeOf。当てた結果は §5 Q22）だが、
	// §2 の表では区間は被演算子に依らず L で、綴りは関数。前は根の種類が未知で黙って通っていた。
	["区間の被演算子の種類が未知 ww : x ? [+ [uu x]]", ["uu : x ? [,] x", "ww : x ? [+ [uu x]]"]],
	["区間の被演算子が関数 q : x ? [+ inc]", [INC, "q : x ? [+ inc]"]],
	["左の被演算子の区間 q : x ? [inc *]", [INC, "q : x ? [inc *]"]],
	["貪欲な区間 q : x ? [+ inc ,]", [INC, "q : x ? [+ inc ,]"]],
	["1行の括りに包んだ区間 q : x ? [[+ inc]]", [INC, "q : x ? [[+ inc]]"]],
	// 前は「仮置きの上でだけ根が L」で通していた形（h は k の仮置き A の上で `[+ A]` の L、確定した値の上では未知）。綴りで断るので、
	// どの定義から解いても G16。
	["区間の相互再帰（h が先）", ["h : x ? [+ [k x]]", "k : x ? h x", "k 1"]],
	["区間の相互再帰（k が先）", ["k : x ? h x", "h : x ? [+ [k x]]", "k 1"]],
	["区間の自己再帰 r : k ? [+ [r k]]（前は通っていた）", ["r : k ? [+ [r k]]"]],
	// 素の関数の本体で、名前の欄の関数を引いて返す（R26 で引いた物は L）。括りの関数の実体の `c : [~r] ? r ' say`（BARE_INST）と同じく、
	// 構造体に入った関数を返す形は利用者に確かめていない（U 2026-10-18 は構造体に入った関数を「完全な裸」と分ける。R33 の R の所）。
	// 断る側に置いた。番号で引いた物・List の要素で受けた物は、形の見え方で未知になって通る（下の「今は」）。
	["名前の欄の関数を引いて返す q : x ? m ' say", [...M, "q : x ? m ' say"]],
	["値の定義の欄の関数を引いて返す q : x ? st ' g", [INC, "st : [g : inc]", "q : x ? st ' g"]],
];
const BARE_INST = [
	// 括りの関数の実体（呼んだ行で、関数と形を名指しする）
	["括りの関数の実体 gi 1 2", [INC, "gi : [x ~xs] ? inc", "gi 1 2"], [["gi", "[N…]"]]],
	["括りの関数の実体を呼ぶ行が定義より先", ["gi 1 2", INC, "gi : [x ~xs] ? inc"], [["gi", "[N…]"]]],
	["括りの関数の部分適用 (tg 1) 2 3", [INC, "tg : [x ~xs] y ? inc", "(tg 1) 2 3"], [["tg", "N A"]]],
	["欄の関数を返す h [g : inc]", [INC, "h : [g] ? g", "h [g : inc]"], [["h", "{g:L}"]]],
	["素の関数の本体から呼ぶ t : y ? gi [y]", [INC, "gi : [x ~xs] ? inc", "t : y ? gi [y]"], [["gi", "A"]]],
	["実体の中の実体 p : [x] ? [y ? p [y]]", ["p : [x] ? [y ? p [y]]", "p [1]"], [["p", "N"], ["p", "A"]]],
	["' で欄の関数を引いて返す c : [~r] ? r ' say", [...M, "c : [~r] ? r ' say", "c m"], [["c", "{say:L other:N}"]]],
];
for (const [name, lines] of BARE) checkRefused(`Q21 ${name}`, src(lines), "G16");
for (const [name, lines, inst] of BARE_INST) checkRefused(`Q21 ${name}`, src(lines), "G16", inst);
// §5 Q35 の答え（2026-10-21 22:46、G17 は廃止）：`$` で包んだ入れ子の `?` は、`$[+ m]` と同じく本体の根が A で通る。括りの関数の
// 実体でも、呼ぶ行が先でも同じ。呼ぶ行は adder と同じく、足りた適用は A、k > n は A（根、`excess`）、合成の後ろでも A。
const CURRY_PASSES = [
	["$ で包んだ入れ子の ? add : x ? $[y ? x + y]", src(["add : x ? $[y ? x + y]"]), "(: add (? [x] $[y ? x + y]))", null],
	["$ で包んだ入れ子の ? の add 1", src(["add : x ? $[y ? x + y]", "add 1"]), "(apply add 1)", "A"],
	["$ で包んだ入れ子の ? の inc add 1", src([INC, "add : x ? $[y ? x + y]", "inc add 1"]), "(apply (compose inc add) 1)", "A"],
	["$ で包んだ入れ子の ? を呼ぶ行が先", src(["add 1 2", "add : x ? $[y ? x + y]"]), "(construct (apply add 1) 2)", "A", { at: 0, leftover: true }],
	["$ で包んだ括りの関数の ? q : x ? $[[y] ? y]", src(["q : x ? $[[y] ? y]", "q 1"]), "(apply q 1)", "A"],
	["括った ? の本体の $ で包んだ入れ子の ?", src(["[x ? $[y ? x + y]] 5"]), "(apply [x ? $[y ? x + y]] 5)", "A"],
	["括りの関数の実体の根が $ で包んだ入れ子の ?", src(["gi : [x ~xs] ? $[y ? y]", "gi 1 2"]), "(apply gi (construct 1 2))", "A"],
	["括りの関数の実体の木", src(["gi : [x ~xs] ? $[y ? y]", "gi 1 2"]), "(: gi (? [[x ~xs]] (inst [N…] $[y ? y])))", null, { at: 0 }],
];
for (const [name, s, want, kind, extra] of CURRY_PASSES) checkPass(`Q35 答え ${name}`, s, want, kind, extra);
// 入れ子の `?` で断ったときの言い分は、`$` を勧めず、仮引数を並べる書き方だけを勧める（U〔答え〕10-21 16:02「理由は、カリー化は
// システムの側で持つべき。 / ユーザーが明示はね…」）。ほかの裸の関数は `$` を先に勧める（U 10-21 12:50）。
{
	const msgOf = (lines) => {
		try {
			resolve(src(lines));
			return "通った";
		} catch (e) {
			return `${e.gate || e.reason} ${e.message}`;
		}
	};
	const rows = [
		["入れ子の ? の言い分は仮引数を並べる書き方だけ", msgOf(["add : x ? y ? x + y"]), (m) => m.startsWith("G16 ") && m.includes("仮引数を並べて書きます") && !m.includes("`$` を明示")],
		["区間の言い分は $ を先に勧める", msgOf(["adder : m ? [+ m]"]), (m) => m.startsWith("G16 ") && m.includes("`$` を明示して値にします（`$[+ m]`）")],
		// 定義より前の行の G12(b)（下の「今は」）は、根が L なら定義の行の G16 を指す（確かめ 2026-10-22）。
		// 2026-10-23 から G12(b) は G2(a)（R40 の読み6、G12 は廃止）。定義の行の G16 を指すことは同じ。
		["定義より前の adder 5 3 の G2(a)（前は G12(b)）は、定義の行の G16 を指す", msgOf(["adder 5 3", "adder : m ? [+ m]"]), (m) => m.startsWith("G2(a) ") && m.includes("G16") && m.includes("R33")],
	];
	for (const [name, m, good] of rows) {
		total++;
		if (good(m)) ok(`Q21 言い分 ${name}`);
		else fail(`Q21 言い分 ${name}`, m);
	}
}
// 数え方（INSTANCE_DEPTH_MARGIN の注の2）：G16 に当たる入れ子の `?` の後ろで呼んだ括りの関数の実体は、最後の木に無いので、確定した
// 実体の総数に数えない。前は前段（根の種類を解く所）で G16 を見ないので数えてしまい、p の実体がちょうど上限（512）のとき、G16 の
// 代わりに総数の G7 を言った（確かめ 2026-10-22。どちらの行の順でも）。素の関数の本体・値の定義・実体の本体のどこでも同じ。
{
	const P512 = `a : ${[...Array(512).keys()].map((i) => `(p [k${i} : 1])`).join(" , ")}`;
	const P = "p : [s] ? 1";
	const rows = [
		["素の関数の本体（t が先）", [P, INC, "t : x ? ([z ? inc] 1) , (p [m : 1])", P512], "G16", null],
		["素の関数の本体（a が先）", [P, INC, P512, "t : x ? ([z ? inc] 1) , (p [m : 1])"], "G16", null],
		["値の定義", [P, INC, "v : ([z ? inc] 1) , (p [m : 1])", P512], "G16", null],
		["局所の定義", [P, INC, "t : x ?", "\tk : y ? inc", "\t(p [m : 1]) , 1", "", P512], "G16", null],
		["実体の本体の入れ子の ?", [P, INC, "bad : [y] ? ([z ? inc] 1) , 1", "t : x ? (bad [y : 1]) , (p [m : 1])", P512], "G16", [["bad", "{y:N}"]]],
		["入れ子の ? の本体が区間の綴り", [P, INC, "t : x ? ([z ? [+ inc]] 1) , (p [m : 1])", P512], "G16", null],
		// 綴りで断る実体の根（区間）は、根の種類が未知でも門に当たる実体に数える（instRootOf）。
		["実体の本体が区間の綴り", [P, INC, "bad : [y] ? [+ inc]", "t : x ? (bad [y : 1]) , (p [m : 1])", P512], "G16", [["bad", "{y:N}"]]],
		// `$` で包んだ入れ子の `?` の実体は通る（§5 Q35 の答え、G17 は廃止）ので、後ろの `p [m : 1]` も最後の木にあり、数える（512 と
		// 合わせて 513 で総数の G7）。
		["実体の本体が $ で包んだ入れ子の ?（通るので後ろも数える）", [P, "bad : [y] ? $[z ? z]", "t : x ? (bad [y : 1]) , (p [m : 1])", P512], "G7", [["p", ""]]],
	];
	for (const [name, lines, want, inst] of rows) checkRefused(`Q21 数え方 ${name}`, src(lines), want, inst || undefined);
	// 同じ形で、k の数を 1 つ減らせば、p の実体はちょうど 512 で通る（どちらの行の順でも）。
	const P511 = `a : ${[...Array(511).keys()].map((i) => `(p [k${i} : 1])`).join(" , ")}`;
	const passes = [
		["t が先", [P, "bad : [y] ? $[z ? z]", "t : x ? (bad [y : 1]) , (p [m : 1])", P511]],
		["a が先", [P, "bad : [y] ? $[z ? z]", P511, "t : x ? (bad [y : 1]) , (p [m : 1])"]],
	];
	for (const [name, lines] of passes) {
		checkPass(`Q35 答え 数え方 実体の本体が $ で包んだ入れ子の ?、ちょうど 512（${name}）`, src(lines), "(: bad (? [[y]] (inst {y:N} $[z ? z])))", null, { at: 1 });
	}
}
// 今は：断る行が2つ以上なら行の順に言う（今までどおり）ので、G16 の定義より前の行で根が L の関数を k > n で呼ぶと、その行の
// G12(b) を言う。定義が先なら G16。呼ぶ行を根に置く（`adder 5`）なら、断るのは定義の行だけで、行の順に依らず G16（上の行）。
// 2026-10-23 から、その行の門は G2(a)（種類の未知な適用の後ろに項が来る、R40 の読み6。G12 は廃止）。
checkRefused("Q21 今は 定義より前の adder 5 3 は G2(a)（前は G12(b)、R40）", src(["adder 5 3", "adder : m ? [+ m]"]), "G2(a)");
checkRefused("Q21 定義が先なら adder 5 3 の前に G16", src(["adder : m ? [+ m]", "adder 5 3"]), "G16");
// 当たらない形
const BARE_PASSES = [
	["$ で値にした関数 adder : m ? $[+ m]", src(["adder : m ? $[+ m]", "adder 5"]), "(apply adder 5)", "A"],
	["$ で値にした関数の定義の行", src(["adder : m ? $[+ m]"]), "(: adder (? [m] $[+ m]))", null],
	["$inc を返す f : x ? $inc", src([INC, "f : x ? $inc", "f 5"]), "(apply f 5)", "A"],
	// 本体の根が未知の関数は G16 に当たらない（足りた適用は未知、k > n は G12(b)。2026-10-23 から G2(a)、R40）。
	["本体の根が未知 use : f x ? @f x", src(["use : f x ? @f x"]), "(: use (? [f x] (apply @f x)))", null],
	["本体の根が未知の use $inc 5", src(["use : f x ? @f x", "use $inc 5"]), "(apply use (construct $inc 5))", "未知"],
	// 値の定義は関数を返す本体ではない。
	["値の定義 p : inc", src([INC, "p : inc"]), "(: p inc)", null],
	["値の定義 x2 : !_", src(["x2 : !_"]), "(: x2 !_)", null],
	["値の定義の欄 st : [g : inc]", src([INC, "st : [g : inc]"]), "(: st [g : inc])", null],
	// 呼ばれない括りの関数は本体を読まない（R25）。
	["呼ばれない括りの関数 gi : [x ~xs] ? inc", src([INC, "gi : [x ~xs] ? inc"]), "(: gi (? [[x ~xs]] (defer {inc})))", null],
	// 括りの関数は渡された物で根が決まる：数を渡せば根は値。
	["数を受けた h [g : 1]", src(["h : [g] ? g", "h [g : 1]"]), "(: h (? [[g]] (inst {g:N} g)))", null, { at: 0 }],
	// 関数を本体の中で呼んだ結果は関数でない。
	["本体で関数を呼ぶ f : x ? inc x", src([INC, "f : x ? inc x"]), "(: f (? [x] (apply inc x)))", null],
	// 今は：字下げのブロックの本体は、全部の行（枝なら値の側）の根が A のときだけ A で、ほかは未知（§3.4）。根が L になることは
	// 無いので、最後の行や枝の値が裸の関数でも G16 に当たらない。ブロックの本体の根を行からどう決めるか（手続きの最後の行・枝の
	// 値）は §3.4 の外で、決まっていない（R33 の R の所）。決まったら、この行を見直す。
	["今は 字下げのブロックの本体の行が関数", src([INC, "f : x ?", "\tinc", ""]), "(: f (? [x] (block inc)))", null],
	// `$` で値にした部分適用（D type_system.md の `g : x ? $(add3 x + 1)` と同じ形）は G16 に当たらない。
	["$ で値にした部分適用 q : x ? $[add x]", src(["add : a b ? a + b", "q : x ? $[add x]", "q 1"]), "(apply q 1)", "A"],
	// 今は（§5 Q35）：次の形は、裸の関数を返すのに根が L にならないので G16 に当たらない。どれも通すか決まっていない。決まったら、
	// この行を見直す。
	// - 仮置きの上でだけ根が L になる関数（h は k の仮置き A の上では引いた区間で L、確定した値の上では未知。区間を欄に入れて引くと、
	//   引いた物は被演算子が未知の区間で、種類が未知になる）。どの定義から解いても断らない（仮置きの途中で断ると、解く順で割れる）。
	["今は 区間を欄に入れて引いて返す（h が先）", src(["h : x ? [s : [+ [k x]]] ' s", "k : x ? h x", "k 1"]), "(apply k 1)", "未知"],
	["今は 区間を欄に入れて引いて返す（k が先）", src(["k : x ? h x", "h : x ? [s : [+ [k x]]] ' s", "k 1"]), "(apply k 1)", "未知"],
	["今は 区間を欄に入れて引いて返す h の行（k が先）", src(["k : x ? h x", "h : x ? [s : [+ [k x]]] ' s", "k 1"]), "(: h (? [x] (' [s : [+ [k x]]] s)))", null, { at: 1 }],
	// - 1行の条件の値が関数（段4〜8 の中置は、被演算子が全部 A でなければ未知。§2）。
	["今は 1行の条件の値が関数 q : x ? x = 0 & inc | double", src([INC, DOUBLE, "q : x ? x = 0 & inc | double"]), "(: q (? [x] (| (& (= x 0) inc) double)))", null],
	// - 関数を並べた器を返す（`,` は A。D type_system.md は止める側、U 2026-10-18 は構造体に入った関数を「完全な裸」と分ける）。
	["今は 関数を並べた器を返す q : x ? inc , double", src([INC, DOUBLE, "q : x ? inc , double"]), "(: q (? [x] (, inc double)))", null],
	// - 番号で引いた関数を返す（要素が混ざった器から番号で引くと、R26 で未知。名前の欄を引くと L で G16）。
	["今は 番号で引いた関数を返す q : x ? fs ' 0", src([INC, DOUBLE, "fs : inc , double , 3", "q : x ? fs ' 0"]), "(: q (? [x] (' fs 0)))", null],
	// - 解かない位置（P3：既定値・1項の `:` の左）に書いた `?`。
	["今は 既定値の中の ? o : [x : [y ? inc]] ? 5", src([INC, "o : [x : [y ? inc]] ? 5"]), "(: o (? [[x : [y ? inc]]] 5))", null],
];
for (const [name, s, want, kind, extra] of BARE_PASSES) checkPass(`Q21 ${name}`, s, want, kind, extra);

// ---------------------------------------------------------------------------
// 余りと流れ（2026-10-22、R35〜R39。§5 Q11・Q4・Q6・Q8 の答え）
// ---------------------------------------------------------------------------
//
// - R35（Q11 の答え、U〔答え〕10-21 23:10「余った引数は後ろに積んでいい。」）：実引数がアリティより多い適用は、前から n 個を当てた
//   適用の後ろに、余りを値として並べる（構築）。`f1 3 4` は `(construct (apply f1 3) 4)`。印 excess と、余りの節が対に入る G12(a) は
//   無くなった。頭の本体の根が A でない k > n（G12(b)、`use $inc 5 3`）と get・set の k > 2 は今のまま断る。
// - R36（Q4 の答え、U〔答え〕10-21 23:18「合ってる。」）：括らない余積の並びの合成は、実引数の並びを流れとして左から畳む。
//   `f2 3 f2 5 6` は `f2 (f2 3 5) 6`、`inc f2 5 6` は `f2 (inc 5) 6`、`inc inc 5 6` は `(inc (inc 5)) 6`。G2(b) は要らなくなった。
// - R37（Q6 の答え、U〔答え〕10-21 23:23「合ってる。」）：逆適用の左が2項以上なら、一番近い1項だけを取り、残りは前に積む。
//   `1 2 inc` は `1 (2 inc)`。G1 は廃止した。余りを積んだ構築の後ろの逆適用（`inc 1 2 inc`）は、R37 の `(inc 1) (inc 2)` と、R36 の
//   流れ（`inc 1` の結果を流れの頭に戻して次の関数が取る）の `inc (inc 1)` の後ろに 2 で割れるので、G12(a) で断る（主の Claude の読み、R）。
// - R38（主の Claude が法則から書いた物、R）：既定値の無い素の関数の内側の `_` は、k ≠ n でも `!_` と同じ（`f _ 3 4` は `f 4 3`）。
// - R39（Q8 の一部の答え、U〔答え〕10-21 23:42「そうなるね。」）：既定値のある口に書いた `_` は既定値という値（木では実引数のまま残す）。
// 2026-10-23 の左からの畳み込み（R40〜R43）で、R36 の流れと R37 の「一番近い1項」は、畳み込みの1歩（後から来る物は最初の関数から順に
// 流れ込む・逆適用はいちばん上の値を取る）そのものになり、一度まとめた並びをほどき直す仕組み（take・leftover・流れの組み立て直し）と
// G12 は要らなくなった。答えの変わった行は、行の注に規則の番号を書いた。後ろの関数が並びの項を受けた合成は、各関数が受けた物の
// 見える入れ子の適用で書く（R40 の読み9、§1.3）。
// 2026-10-24 の逆適用の廃止（R47）で、R37（一番近い1項）も廃止した：値の後ろの関数は積まれて、値を取らない（関数は右からだけ受ける）。
// 根に余った関数は `_`（R42）で、構築の中で消え、余ったことは leftover-lambda で知らせる（R48）。行の名前の「前は」に、2026-10-23 の逆適用の
// 答えを足した。
const ADEF =["sub : x y ? x - y", "pt : [a ~as] y ? y", "kf : [f] ? f 1"];
const GF = "gf : [x : 1] y ? y"; // 既定値のある口が前（位置 0）
const GB = "gb : [x : 1] [y : 2] ? x"; // 口が2つとも既定値
const GZ = ["gz :", "\t\ta b", "\t\tc : 3", "\t? a", ""]; // 仮引数の数が数えられない既定値のある関数
const flowPasses = [
	// R35
	["R35 inc 3 4", std("inc 3 4"), "(construct (apply inc 3) 4)", "A", { leftover: true }],
	["R35 f2 5 6 7", std("f2 5 6 7"), "(construct (apply f2 (construct 5 6)) 7)", "A", { leftover: true }],
	// U〔答え〕10-21 23:10 の前の問いの例（主の Claude の言葉）：`f1 3 4 f2 5 6 f1 6` は `(f1 3) 4 (f2 5 6) (f1 6)`。前は G12(a)。2026-10-23
	// は、f2 が 4 を逆適用で取り、口が決まらない（§5 Q5）まま 5 が来るので G8（R40）。R47 で、問いの例の答えの `(inc 3) 4 (f2 5 6) (inc 6)`
	// に戻った（norevPasses）。
	// `5 d 1 2 _` は、R47 で `5 (d 1) 2`（2026-10-22 の強さの順と同じ木。2026-10-23 は逆適用で `(d 5) 1 2`）。後ろの `_` は値の隣で消える（R43）。
	// 根は最初の項が 5 の構築なので、leftover の形（最初の子が適用）でない。
	["R35 5 d 1 2 _（`5 (d 1) 2`、R47。前は G12(a)、その後 `5 (d 1) 2`・`(d 5) 1 2`）", std("5 d 1 2 _"), "(construct 5 (apply d 1) 2)", "A", { leftover: false }],
	["R35 [add !_ 10] 5 6（穴の関数）", std("[add !_ 10] 5 6"), "(construct (apply [add !_ 10] 5) 6)", "A", { leftover: true }],
	["R35 pt [1] 2 3（最後の仮引数が裸の括りの関数）", std([...ADEF, "pt [1] 2 3"]), "(construct (apply pt (construct [1] 2)) 3)", "A", { leftover: true }],
	// R34 の k < n で作った関数は、最後の括りが残りの並び全体を受ける（R24。可変長の口、R41）ので、その関数の所では木を切らない（f3・add
	// の余りは、関数の本体の中で後ろに積まれる）。2026-10-23 から節の印 leftover は無く、根は1つの適用（leftover の形でない）。
	["R35 (add !_) 1 2 3（最後の括りが受ける。R41）", std("(add !_) 1 2 3"), "(apply [add !_] (construct 1 2 3))", "A", { leftover: false }],
	["R35 (f3 !_ 2) 1 vs 4（最後の括りに2つ入るので G13 にならない）", std("(f3 !_ 2) 1 vs 4"), "(apply [f3 !_ 2] (construct 1 vs 4))", "A"],
	// 積んだ構築は値（名前や括りで包めば1つの項）。2026-10-23 までは後ろの逆適用がそれを受けた（`(apply inc v ·rev)`）。R47 で、後ろの inc は
	// 積まれて余る（R42・R48）。
	["R35 v : inc 3 4 ⏎ v inc（R47）", std(["v : inc 3 4", "v inc"]), "(construct v (unit inc))", "A"],
	["R35 (inc 3 4) inc（R47）", std("(inc 3 4) inc"), "(construct [inc 3 4] (unit inc))", "A"],
	// R36
	// 後ろの f2 が並びの 6 を受けたので、木は各関数が受けた物の見える入れ子の適用（R40 の読み9。前は `(apply (compose (apply f2 3) f2)
	// (construct 5 6))` で、流れが木に出なかった）。
	["R36 f2 3 f2 5 6（`f2 (f2 3 5) 6`。木は入れ子、R40）", std("f2 3 f2 5 6"), "(apply f2 (construct (apply f2 (construct 3 5)) 6))", "A"],
	["R36 sub 3 sub 5 6（`sub (sub 3 5) 6`、ポーランドの `sub 3 (sub 5 6)` ではない。木は入れ子、R40）", std([...ADEF, "sub 3 sub 5 6"]), "(apply sub (construct (apply sub (construct 3 5)) 6))", "A"],
	["R36 inc f2 5 6（`f2 (inc 5) 6`。前は未知。木は入れ子、R40）", std("inc f2 5 6"), "(apply f2 (construct (apply inc 5) 6))", "A"],
	["R36 inc inc 5 6（`(inc (inc 5)) 6`。前は excess）", std("inc inc 5 6"), "(construct (apply (compose inc inc) 5) 6)", "A", { leftover: true }],
	["R36 [f2 3 f2] 5 6（括っても同じ）", std("[f2 3 f2] 5 6"), "(apply [f2 3 f2] (construct 5 6))", "A"],
	["R36 f2 3 f2 5（流れが足りない、L。根なので `_`、R42）", std("f2 3 f2 5"), "(unit (apply (compose (apply f2 3) f2) 5))", "A"],
	["R36 (f2 3 f2 5) 6（足りない合成に後から当てる）", std("(f2 3 f2 5) 6"), "(apply [f2 3 f2 5] 6)", "A"],
	["R36 f2 3 f2 5 6 7（流れの余りは後ろに積む。木は入れ子、R40）", std("f2 3 f2 5 6 7"), "(construct (apply f2 (construct (apply f2 (construct 3 5)) 6)) 7)", "A", { leftover: true }],
	["R36 (inc add 5) 3（前は G7）", std("(inc add 5) 3"), "(apply [inc add 5] 3)", "A"],
	["R36 q : inc add 5 ⏎ q 3 4", std(["q : inc add 5", "q 3 4"]), "(construct (apply q 3) 4)", "A", { leftover: true }],
	["R36 inc add 5 g 3（`g (add (inc 5) 3)`。前は G2(a)。木は入れ子、R40）", std("inc add 5 g 3"), "(apply g (apply add (construct (apply inc 5) 3)))", "A"],
	["R36 inc add add 5 3 4（木は入れ子、R40）", std("inc add add 5 3 4"), "(apply add (construct (apply add (construct (apply inc 5) 3)) 4))", "A"],
	["R36 inc add add 5 3（流れが足りない、L。根なので `_`、R42。木は入れ子、R40）", std("inc add add 5 3"), "(unit (apply add (apply add (construct (apply inc 5) 3))))", "A"],
	["R36 inc pt [5] 6（後ろの括りの関数も流れから取る。木は入れ子、R40）", std([...ADEF, "inc pt [5] 6"]), "(apply pt (construct (apply inc [5]) 6))", "A"],
	// 段18 の点なしは、流れの前が1項のときだけ口を1つと数える（直に当てた `[' 0] [1 2] 3` の k ≠ 1 は未知のまま、R35 の R の所）。
	// 前（2026-10-22 の確かめの前）は流れの中でだけ 1 と数え、`[' 0] add [1 2] 3` を A にしていた（同じ関数の口の数が2か所で割れる）。
	["R36 [' 0] add [1 2] 3（流れが2項なので未知。直に当てた `[' 0] [1 2] 3` と同じ）", std("[' 0] add [1 2] 3"), "(apply (compose [' 0] add) (construct [1 2] 3))", "未知"],
	["R36 [' 0] add [1 2]（流れが1項なら口を1つと数える、L。根なので `_`、R42）", std("[' 0] add [1 2]"), "(unit (apply (compose [' 0] add) [1 2]))", "A"],
	["R36 ([' 0] add [1 2]) 3（流れの足りない合成に後から当てる）", std("([' 0] add [1 2]) 3"), "(apply [[' 0] add [1 2]] 3)", "A"],
	["R36 [' 0] inc [1 2] 5（流れが2項なので未知）", std("[' 0] inc [1 2] 5"), "(apply (compose [' 0] inc) (construct [1 2] 5))", "未知"],
	// 後ろの段18 の点なしも、流れの余りが無ければ口を1つと数える。流れの足りない合成を畳み直すときは、作った時に1項を取った段18 の
	// 点なし（括りの中で、前の結果1項を前にした物）を、後から来た実引数に依らず 1 と数える（変異で確かめた）。
	["R36 [' 0] [' 0] add [[1 2] [3 4]]（後ろの段18 も、余りが無ければ口を1つ、L。根なので `_`、R42）", std("[' 0] [' 0] add [[1 2] [3 4]]"), "(unit (apply (compose [' 0] [' 0] add) [[1 2] [3 4]]))", "A"],
	["R36 ([' 0] [' 0] add [[1 2] [3 4]]) 5（括りの中で取った数は変わらない）", std("([' 0] [' 0] add [[1 2] [3 4]]) 5"), "(apply [[' 0] [' 0] add [[1 2] [3 4]]] 5)", "A"],
	["R36 [' 0] [' 0] add [[1 2] [3 4]] 5（括らなければ最初の段18 の前に2項、未知）", std("[' 0] [' 0] add [[1 2] [3 4]] 5"), "(apply (compose [' 0] [' 0] add) (construct [[1 2] [3 4]] 5))", "未知"],
	["R36 ||inc add 5|| 3（ノルムの合成に包んだ足りない合成）", std("||inc add 5|| 3"), "(apply ||inc add 5|| 3)", "A"],
	["R36 kf [f : inc add 5]（欄で渡した足りない合成）", std([...ADEF, "kf [f : inc add 5]"]), "(apply kf [f : inc add 5])", "A"],
	["R36 kf [f : pt2 inc [5]]（先に当てた物の形で実体を作る）", src(["inc : x ? x + 1", "pt2 : [a ~as] y ? a 1", "kf : [f] ? f 1", "kf [f : pt2 inc [5]]"]), "(: pt2 (? [[a ~as] y] (inst N A (construct a 1))))", null, { at: 1 }],
	["R36 pair [1] inc 5（前は G2(b)）", src(["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a + b", "pair [1] inc 5"]), "(apply (compose (apply pair [1]) inc) 5)", "A"],
	["R36 pair inc [1] double 5（前は G2(b)）", src([INC, DOUBLE, "pair : [a ~as] [b ~bs] ? a + b", "pair inc [1] double 5"]), "(apply (compose (apply (compose pair inc) [1]) double) 5)", "A"],
	// R47：5 の後ろに inc が積まれ、add はその合成の後ろに入る。根に余って `_`（R42・R48）。2026-10-23 は `5 inc` が逆適用で値になり、
	// add がそれを逆適用で取って主語の口が決まらないまま行の終わりで `_`（`(unit (apply add (apply inc 5 ·rev) ·rev))`）、その前は合成
	// `inc add` に 5 を逆適用した L。
	["R36 5 inc add（R47。前は L、その後 逆適用の `_`）", std("5 inc add"), "(construct 5 (unit (compose inc add)))", "A"],
	// 並び全体を受ける関数は、並びの終わりまで受ける（R41）。
	["R36 add [+] 5 6（`[+]` は前の結果だけを受ける）", std("add [+] 5 6"), "(apply (compose add [+]) (construct 5 6))", "未知"],
	// 最初の `[+]` が 5 6 を受けて閉じ、結果が add の最初の口に入る。add はもう1つの口を待つ L で、根なので `_`（R41・R42。前は、`[+]` の後ろの
	// 関数は前の結果だけを受けて未知）。
	["R36 [+] add 5 6（最初の `[+]` は並び全体を受ける。add は残りの口を待つ、R41・R42。前は未知）", std("[+] add 5 6"), "(unit (apply (compose [+] add) (construct 5 6)))", "A"],
	// R37（2026-10-24 に廃止、R47）。前は一番近い1項を逆適用で取って、残りを前に積んだ（`1 2 3 inc` は `1 2 (inc 3)`）。R47 では、値の後ろの
	// 関数は値を取らずに積まれ、根に余れば `_`（R42・R48）。行の名前の頭の R37 は、前の規則の見本だった印として残す。
	["R37 1 2 3 inc（R47。前は `1 2 (inc 3)`）", std("1 2 3 inc"), "(construct 1 2 3 (unit inc))", "A"],
	// R47 で `5 (inc 3)` の後ろに inc が余る。2026-10-23 は逆適用で `(inc 5) (inc 3)`、その前は強さの順で `5 (inc (inc 3))`、その前は G1。
	["R37 5 inc 3 inc（R47。前は G1、その後 `5 (inc (inc 3))`・`(inc 5) (inc 3)`）", std("5 inc 3 inc"), "(construct 5 (apply inc 3) (unit inc))", "A"],
	["R37 vs~ 1 inc（R47。前は `vs~ (inc 1)`）", std("vs~ 1 inc"), "(construct vs~ 1 (unit inc))", "A"],
	["R37 1 2 inc inc（R47。前は `1 (inc (inc 2))`）", std("1 2 inc inc"), "(construct 1 2 (unit (compose inc inc)))", "A"],
	["R37 1 2 inc 3 double（R47。前は `1 2 (double (inc 3))`・`1 (inc 2) (double 3)`）", std("1 2 inc 3 double"), "(construct 1 2 (apply inc 3) (unit double))", "A"],
	// 本体は評価する所でない（R42 の読み1）が、2026-10-24 の R52 から、値の上に積まれて何も受けずに閉じた inc は余ったラムダで `_`。R47 の最初の
	// 版は、ラムダのまま残って値と関数の並んだ構築が種類を決めなかった（未知、§5 Q38）。その前は逆適用で `(construct 1 (apply inc y ·rev))`、A。
	["R37 本体 1 y inc（R52。R47 では未知（Q38）、その前は A）", std("t : y ? 1 y inc"), "(construct 1 y (unit inc))", "A", { body: true, leftoverDiag: ["inc"] }],
	// R38
	["R38 f3 _ 2（`a [~c] ? f3 a 2 c~`。根なので `_`、R42）", std("f3 _ 2"), "(unit (? [$p0 [~$p1]] (apply f3 (construct $p0 2 $p1~))))", "A"],
	["R38 f2 _ 3 4（`f2 4 3`）", std("f2 _ 3 4"), "(apply f2 (construct 4 3))", "A"],
	["R38 add _ 3 4 5（埋めた後の余りは後ろに積む）", std("add _ 3 4 5"), "(construct (apply add (construct 4 3)) 5)", "A", { leftover: true }],
	["R38 inc _ 5", std("inc _ 5"), "(apply inc 5)", "A"],
	["R38 add 1 _ 5", std("add 1 _ 5"), "(apply add (construct 1 5))", "A"],
	["R38 f3 _ 2 _ 9（穴が残る。根なので `_`、R42）", std("f3 _ 2 _ 9"), "(unit (? [$p0] (apply f3 (construct 9 2 $p0))))", "A"],
	["R38 (f3 _ 2) 1 3", std("(f3 _ 2) 1 3"), "(apply [f3 _ 2] (construct 1 3))", "A"],
	// R39
	["R39 gf _ 3（既定値のある口の _）", std([GF, "gf _ 3"]), "(apply gf (construct _ 3))", "未知"],
	["R39 gb _ _（口が2つとも既定値）", std([GB, "gb _ _"]), "(apply gb (construct _ _))", "未知"],
	["R39 g2 : gf ⏎ g2 _ 3（別名の頭でも同じ関数）", std([GF, "g2 : gf", "g2 _ 3"]), "(apply g2 (construct _ 3))", "未知"],
	["R39 go !_ _（既定値のある口の _ と穴。根なので `_`、R42）", std([...GO_DEFAULT, "go !_ _"]), "(unit (? [$p0] (apply go (construct $p0 _))))", "A"],
	["R39 go !_ _ 5（`!_` も口を1つ占めて数える）", std([...GO_DEFAULT, "go !_ _ 5"]), "(apply go (construct 5 _))", "未知"],
	// 2026-10-23 の左からの畳み込み（R40）で、前は G12(a)・G12(c)・G13・G8 で断っていた形が通る。
	// 余りの後ろの関数は、2026-10-23 はいちばん上の余りを逆適用で取った（R40。前は R37 と R36 で割れる G12(a)）。R47 で、積まれて余る
	// （R42・R48）。`inc 1 2 inc` は `(inc 1) 2`（U〔答え〕[2026-10-23 15:32 ebf18260] の前に主の Claude が示した表の形）。
	["R40 inc 1 2 inc（`(inc 1) 2`、R47。前は G12(a)、その後 `(inc 1) (inc 2)`）", std("inc 1 2 inc"), "(construct (apply inc 1) 2 (unit inc))", "A"],
	["R40 5 inc 3 4 inc（R47。前は G12(a)、その後 `(inc 5) 3 (inc 4)`）", std("5 inc 3 4 inc"), "(construct 5 (apply inc 3) 4 (unit inc))", "A"],
	["R40 inc 1 2 3 inc（R47。前は G12(a)、その後 `(inc 1) 2 (inc 3)`）", std("inc 1 2 3 inc"), "(construct (apply inc 1) 2 3 (unit inc))", "A"],
	["R40 inc inc 5 6 inc（R47。前は G12(a)、その後 `… (inc 6)`）", std("inc inc 5 6 inc"), "(construct (apply (compose inc inc) 5) 6 (unit inc))", "A"],
	// 最後の括りは並びの終わりまで受ける（R41）ので、後ろの inc は合成の後ろに入り、閉じた値を受ける（前は、中で積んだ余りの後ろの逆適用・
	// 合成の次の関数で G12(a)・G12(c)）。並びを全部受けてから後ろに関数が来る形の木は入れ子の適用（2026-10-23 までは値の後ろの逆適用と
	// 同じ `·rev` の綴り、renderEntry の trailingFrom。R47 で無くなった）。
	["R41 [f3 !_ 3] 7 8 9 inc（`inc (f3 7 3 8 9)`。前は G12(a)）", std("[f3 !_ 3] 7 8 9 inc"), "(apply inc (apply [f3 !_ 3] (construct 7 8 9)))", "A"],
	["R41 [f3 !_ 3] inc 7 8 9（前は G12(c)）", std("[f3 !_ 3] inc 7 8 9"), "(apply (compose [f3 !_ 3] inc) (construct 7 8 9))", "A"],
	// 値の後ろの f2 は積まれて、根に余って `_`（R47・R42・R48）。構築の中に残ったラムダは R15 で消える（`1 2 f2` の値は `1 2`。2026-10-23 は
	// f2 が 2 を逆適用で取って主語の口が決まらないまま `_` で、値は 1）。前は G8。
	["R42 1 2 f2（R47。前は G8、その後 `1 (2 f2)`）", std("1 2 f2"), "(construct 1 2 (unit f2))", "A"],
	["R42 1 5 inc add（R47。前は G8、その後 `1 (add (inc 5))`）", std("1 5 inc add"), "(construct 1 5 (unit (compose inc add)))", "A"],
	// 流れの余りが並び全体を受ける関数に届く：その関数は並びの終わりまで受ける（R41。前は G12(c)、§5 Q13 の残り）。
	["R41 inc [+] 5 6（`[+] (inc 5) 6`。前は G12(c)）", std("inc [+] 5 6"), "(apply [+] (construct (apply inc 5) 6))", "A"],
	["R41 inc [* 2,] 5 6（前は G12(c)）", std("inc [* 2,] 5 6"), "(apply [* 2,] (construct (apply inc 5) 6))", "A"],
	// 恒等射が2項以上を受けても、後ろに関数が続かなければ割れない（R29 でも単位律でも `(inc 5) 6` の並び）。前は G12(c)。
	["R41 inc i 5 6（恒等射。前は G12(c)）", std(["i : !_", "inc i 5 6"]), "(apply i (construct (apply inc 5) 6))", "A"],
	["R41 add [+] 5 6 7（`[+] (add 5 6) 7`。前は G12(c)）", std("add [+] 5 6 7"), "(apply [+] (construct (apply add (construct 5 6)) 7))", "A"],
	// R34 の k < n で作った関数の最後の括りに1つで入った物は、[x] ≅ x で中身の並び（規則の文面。前は G13）。
	["R41 (f3 _ 2) 1 vs（vs を撒いて f3 の余り。前は G13）", std("(f3 _ 2) 1 vs"), "(apply [f3 _ 2] (construct 1 vs))", "A"],
	["Q31 (f3 !_) 1 [1 2]（`f3 1 1 2`、規則の文面。前は G13）", std("(f3 !_) 1 [1 2]"), "(apply [f3 !_] (construct 1 [1 2]))", "A"],
];
const flowRefused = [
	// R35 の残り：種類の未知な適用の後ろに項が来る（R40 の読み6。G12(b) → G2(a)、G12 は廃止）。
	["R35 use $inc 5 3（本体の根が未知。G12(b) → G2(a)、R40）", std("use $inc 5 3"), "G2(a)"],
	["R35 ['] fs 0 1（get の k > 2。G12(b) → G2(a)、R40）", std("['] fs 0 1"), "G2(a)"],
	// 前の R37 と R36 の割れ（G12(a)）・R36 の残り（G12(c)）は、左からの畳み込みで答えが1つに決まり、上の flowPasses の R40・R41 の行へ移した。
	// `inc 3 4 f2 5 6 inc 6`（2026-10-23 は G8：f2 が 4 を逆適用で取り、5 が来る）と、逆適用の主語の門の `1 vs~ inc`（G9、R14）は、
	// 逆適用の廃止（R47。G8・G9 も廃止）で通る側（norevPasses）へ移した。
	// `1 2 [+ 1]`（右が点なし。前は G10）は、R13 を廃止して `1 ([+ 1] 2)`（R40）、R47 から `1 2` の後ろに余る。下の「左からの畳み込み」の
	// pfReversePasses へ移した。
	// 結果が値でない関数の後ろに項が来る（R40 の読み6。G12(b) → G2(a)）。
	["R36 inc uu 5 6（余りの前の結果が値でない。G12(b) → G2(a)、R40）", std(["uu : x ? [,] x", "inc uu 5 6"]), "G2(a)"],
	// `5 use 5 inc`（逆適用の右の足りない合成は R12 の形でない、G8）は、R47 で通る側（norevPasses。上の「穴」の同じ行と1つにした）へ移した。
	// 流れの足りない合成の鍵には、先に当てた物の形を入れる（括りの関数の部分適用の鍵と同じ）。入れないと、先に解いた `[5]` の実体
	// （A）を、`[$inc]`（中身の見えない A。pt2 の a が未知で G7）の行が黙って使う（変異で確かめた）。
	[
		"R36 鍵 w : kf [f : pt2 inc [5]] の後の kf [f : pt2 inc [$inc]]",
		src(["inc : x ? x + 1", "pt2 : [a ~as] y ? a 1", "kf : [f] ? f 1", "w : kf [f : pt2 inc [5]]", "kf [f : pt2 inc [$inc]]"]),
		"G7",
		[["kf", "{f:L}"], ["pt2", "A A"]],
	],
	// 流れで足りない適用になる本体の根は裸の関数（R33）。前は未知の根で通っていた。
	["R36 ff : x ? inc add x（本体の根が L）", std("ff : x ? inc add x"), "G16"],
	// R38 の残り（R34 の G13 と同じ）
	["R38 inc 1 _ 2（前から n 個の外の `_`。前は G5）", std("inc 1 _ 2"), "G13"],
	["R38 f3 _ vs~（撒く項。前は G5）", std("f3 _ vs~"), "G13"],
	["R38 go _ vs~（撒く項）", std(["go : ys ? ys", "go _ vs~"]), "G13"],
	// `(f3 _ 2) 1 vs`（前は G13）は、R34 の k < n の G13 が無くなって通る（上の flowPasses の R41 の行）。
	["R38 (f3 _ 2) 1 _（R34 の関数に書いた `_`）", std("(f3 _ 2) 1 _"), "G5"],
	// 今のまま：最後の項が `_`（終わり、R28）・k = n の撒く項
	["R38 f4 _ 2 _（最後の項が `_`、今のまま）", std("f4 _ 2 _"), "G5"],
	["R38 add _ vs~（k = n の撒く項、今のまま）", std("add _ vs~"), "G5"],
	// R39 の残り（G15）
	["R39 go _ 3（既定値の無い口）", std([...GO_DEFAULT, "go _ 3"]), "G15"],
	["R39 go 1 2 _（仮引数の外）", std([...GO_DEFAULT, "go 1 2 _"]), "G15"],
	// 2026-10-24 の試し（R51）：既定値のある go は口の数が分からないので、撒いた流れ xs~ が来た所で G19（前は `_` の所で G15。どちらも断る）。
	["R39 go xs~ _（前に撒く項。R51 の G19、試し。前は G15）", std([...GO_DEFAULT, "go xs~ _"]), "G19"],
	["R39 gz _ 3（仮引数の数が数えられない）", std([...GZ, "gz _ 3"]), "G15"],
	["R39 go _ !_（既定値の無い口の `_` と穴）", std([...GO_DEFAULT, "go _ !_"]), "G15"],
	// `5 gf inc _`（2026-10-23 は G8：gf が 5 を逆適用で取り、口が決まらない（§5 Q5）まま、合成の後に `_` が来る。その前は G2(a)）は、R47 で
	// `5 (gf inc _)` に決まり（`_` は gf の最初の口で、既定値のある口、R39）、通る側（norevPasses）へ移した。
	// 口の外の `!_` は G7 のまま断っていた（§5 Q15。U〔答え〕10-21 23:47「合ってる」、仕様 §7.16 の決定の D6。D は決定の番号で、証拠の
	// 印 D（文書）ではない）。2026-10-22 23:48 の答え（U〔答え〕「5 !_ / 5 , !_ も追加で、 全部5になるはず…」）で、`!_ 5`・`5 !_`・`5 !_ 3` は
	// 恒等射（R44）、`inc !_ inc` は口が1つだけ残った inc の口で穴と恒等射が同じ関数（R46）になり、下の「口の外の恒等射」の idPasses へ移した。
	// R34 の k < n の割れ（§7.16 の決定の D7、G13）は、2026-10-23 の規則の文面（`(f3 !_) 1 [1 2]` は `f3 1 1 2`）で無くなった。上の flowPasses へ移した。
];
for (const [name, s, want, kind, extra] of flowPasses) checkPass(`余りと流れ ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of flowRefused) checkRefused(`余りと流れ ${name}`, s, want, inst);

// 確かめ 2026-10-22（R35〜R39 を確かめた2人の指摘を当てた行。§7.17）。
const recheckPasses = [
	// 2026-10-23 までは、逆適用の主語は一番近い1項（R37）で、前に積む項の `_` は根の構築の中で消えた（手順8・R15。その前は左の構築の
	// どこかに `_` があれば G5）。R47 で、inc は値の後ろに積まれて余る（R42・R48）。`_` は値の隣と空の所で消える（R43）。
	["R37 _ 1 inc（R47。前は G5、その後 `inc 1`）", std("_ 1 inc"), "(construct 1 (unit inc))", "A"],
	["R37 1 _ 2 inc（R47。前は G5、その後 `1 (inc 2)`）", std("1 _ 2 inc"), "(construct 1 2 (unit inc))", "A"],
	// 恒等射が並びを受けた後ろが恒等射・貪欲な単項・ノルムなら、R29 と単位律のどちらで読んでも同じなので通す。
	["R29 i i 1 2（後ろも恒等射）", std(["i : !_", "i i 1 2"]), "(apply (compose i i) (construct 1 2))", "A"],
	["R29 i [* 2,] 1 2（後ろが貪欲な単項）", std(["i : !_", "i [* 2,] 1 2"]), "(apply (compose i [* 2,]) (construct 1 2))", "A"],
	["R29 i 1 2 3（根なら通す）", std(["i : !_", "i 1 2 3"]), "(apply i (construct 1 2 3))", "A"],
	// 括れば1つの項（値）。後ろの inc は、2026-10-23 までは逆適用でそれを取り、R47 から積まれて余る（R42・R48）。
	["R29 [i 1 2] inc（括れば1つの項。R47）", std(["i : !_", "[i 1 2] inc"]), "(construct [i 1 2] (unit inc))", "A"],
	// ノルムは R27 で「1つ受けて A を返す関数」なので、流れでも口を1つと数え、余りは後ろに積む。R27 の等式 `||f|| x` ＝ `||f x||` は、
	// x が f のアリティ分のときの言い換え（確かめ 2026-10-22 に文面を狭めた）。
	["R27 ||add|| 1 2", std("||add|| 1 2"), "(apply ||add|| (construct 1 2))", "A"],
	// 後ろの組 `||add||` が並びの 2 を受けたので、木は各組が受けた物の見える入れ子の適用（R40 の読み9。意味は前と同じ `||add (inc 1) 2||`）。
	["R27 inc ||add|| 1 2（余りはノルムに届く前に add が取る。木は入れ子、R40）", std("inc ||add|| 1 2"), "(apply ||add|| (construct (apply inc 1) 2))", "A"],
	["R27 ||inc|| 1 2（`||inc 1||` の後ろに 2 を積む）", std("||inc|| 1 2"), "(construct (apply ||inc|| 1) 2)", "A", { leftover: true }],
	["R27 ||inc|| add 1 2（ノルムの後ろの add が余りを取る。木は入れ子、R40）", std("||inc|| add 1 2"), "(apply add (construct (apply ||inc|| 1) 2))", "A", { leftover: false }],
	// 2026-10-23 の左からの畳み込み（R40・R41）で、前は G12(a)・G12(c)・G8 で断っていた形が通る。
	// 余りの後ろの関数は、2026-10-23 はいちばん上の余りを逆適用で取った（R40）。R47 では積まれて、根に余って `_`（R42・R48）、構築の中の
	// `_` は消える（R15）。
	["R40 inc 1 2 f2（`(inc 1) 2`、R47。前は G12(a)、その後 G8・`(inc 1) _`）", std("inc 1 2 f2"), "(construct (apply inc 1) 2 (unit f2))", "A"],
	["R40 ||inc|| 1 2 inc（`||inc 1|| 2`、R47。前は G12(a)、その後 `||inc 1|| (inc 2)`）", std("||inc|| 1 2 inc"), "(construct (apply ||inc|| 1) 2 (unit inc))", "A"],
	// 段18 の点なしは並びの終わりまで受ける（R41、R41 の読み8）。2項以上を受けた `[' 0]` は、直に当てた `[' 0] [1 2] 5` と同じく未知
	// （前は G12(c)。流れの中だけで k ≠ 1 を断る理由が無くなった）。
	["R41 inc [' 0] [1 2] 5（`[' 0] (inc [1 2]) 5`。前は G12(b)、その後 G12(c)）", std("inc [' 0] [1 2] 5"), "(apply [' 0] (construct (apply inc [1 2]) 5))", "未知"],
	["R41 add [' 0] 1 2 3（前は G12(c)）", std("add [' 0] 1 2 3"), "(apply [' 0] (construct (apply add (construct 1 2)) 3))", "未知"],
];
const recheckRefused = [
	// 余りを積んだ値の後ろの逆適用でも、右だけで決まる門（G8）が先だった（左をどう読んでも当たるので、R37 と R36 の割れではない）。
	// `inc 1 2 f2`（前は G12(a)、その後 G8）は、後ろに実引数が来ないので行の終わりで `_`（R40・R42。上の recheckPasses）。
	// `inc 1 2 [+ 1]`（前は G12(a)、その後 G10）は、R13 を廃止して `(inc 1) ([+ 1] 2)`（R40。下の pfReversePasses）。
	// `inc 1 2 f2 3`（前は G12(a)、その後 G8）は、逆適用の廃止（R47、G8 も廃止）で `(inc 1) 2 (f2 3)` に決まり、通る側（norevPasses）へ移した。
	// 恒等射が2項以上を受けた後ろの関数・逆適用（R29 の「並び全体を受ける」と単位律が割れる）。2026-10-23 から G18（G12 は廃止）：逆適用の
	// `i 1 2 inc` も、畳み込みでは恒等射が並びの終わりまで受ける口に inc が合成で入るので、同じ1つの門になる。恒等射が続くなら、その先の
	// 最初の恒等射でない関数で見る（`i i 1 2 inc`）。2026-10-24 の R47 からも同じ門（単位律の読みの `1 2 inc` は、inc が積まれて余る）。
	["G18 i inc 1 2（前は inc が並び全体を受けて A、その後 G12(c)）", std(["i : !_", "i inc 1 2"]), "G18"],
	["G18 i f2 1 2（前は未知、その後 G12(c)）", std(["i : !_", "i f2 1 2"]), "G18"],
	["G18 i ||inc|| 1 2（前は G12(c)）", std(["i : !_", "i ||inc|| 1 2"]), "G18"],
	["G18 i i 1 2 inc（恒等射だけの合成も並びを持ち越す。前は G12(a)）", std(["i : !_", "i i 1 2 inc"]), "G18"],
	["G18 5 i 1 2 inc（主語が恒等射の並び。前は G12(a)）", std(["i : !_", "5 i 1 2 inc"]), "G18"],
	// 段18 の点なしに前の結果と余りの2項以上が届く形（前は G12(c)）・ノルムの合成の余りを積んだ値の後ろの逆適用（前は G12(a)）は、
	// 2026-10-23 から通る（上の recheckPasses の R40・R41 の行）。
];
for (const [name, s, want, kind, extra] of recheckPasses) checkPass(`確かめ ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of recheckRefused) checkRefused(`確かめ ${name}`, s, want, inst);
{
	const msgOf = (s) => {
		try {
			resolve(s);
			return "通った";
		} catch (e) {
			return `${e.gate || e.reason} ${e.message}`;
		}
	};
	const rows = [
		["G13 の穴の綴りの後ろに空白（inc 1 !_）", msgOf(std("inc 1 !_")), (m) => m.startsWith("G13 ") && m.includes("並びに穴 `!_` があり")],
		["合成の頭の終わりの `_` は G5 で、理由は合成の頭（inc inc _）", msgOf(std("inc inc _")), (m) => m.startsWith("G5 ") && m.includes("合成の頭に「ここで終わる」（R28）を当てるか")],
		// 2026-10-23：段18 の点なしに余りが届く形は通る（前は G12(c) で k ≠ 1 を名指し。上の recheckPasses）。恒等射の2つの行は G18 で、
		// 言い分は R29 と単位律を名指しし、後ろの関数を名指しする（前は G12(c) と G12(a)）。
		["恒等射の G18（前は G12(c)）は R29 と単位律を名指し", msgOf(std(["i : !_", "i inc 1 2"])), (m) => m.startsWith("G18 ") && m.includes("恒等射") && m.includes("R29") && m.includes("単位律") && m.includes("`inc`")],
		["恒等射の並びの後ろの関数の G18（前は G12(a)）も R29 と単位律を名指し", msgOf(std(["i : !_", "i 1 2 inc"])), (m) => m.startsWith("G18 ") && m.includes("R29") && m.includes("単位律") && m.includes("（2 項）")],
	];
	for (const [name, m, good] of rows) {
		total++;
		if (good(m)) ok(`確かめ 言い分 ${name}`);
		else fail(`確かめ 言い分 ${name}`, m);
	}
}

// ---------------------------------------------------------------------------
// 左からの畳み込み（2026-10-23、R40〜R43）
// ---------------------------------------------------------------------------
//
// 余積は1つの演算子で、左結合（R40）。並びは左から1項ずつ畳み、次の項はいちばん上の項とだけ結ぶ。可変長の口は並びの終わりまで
// 受けて閉じる（R41）。評価する所（定義でない行の根）の終わりに残った未評価のラムダは `_`（R42。木は `(unit …)`）。書いた `_` と `!_` は
// 口を1つ埋める所で読む（R43）。根拠：規則の文面に答えのボタン「作り直す」（U〔答え〕10-22 22:15）。
// 畳み込みの1歩は、2026-10-23 は4行（A A は積む、L A は口を1つ埋める、L L は合成、A L は逆適用で L がいちばん上の A を取る）で、
// 2026-10-24 の逆適用の廃止（R47）から3行：L A は口を1つ埋める、L L は合成、いちばん上が A か空なら次の項を積む（L も積み、積まれた L は
// 後ろの項を右から受ける）。根拠：U [2026-10-23 13:12 ebf18260]「…逆適用は廃止しよう」と、主の Claude の問い「A の後の L は積む（関数は
// 右からだけ受ける）。根でラムダが余って `_` になったら診断で知らせる。これでいい？」への U〔答え〕[2026-10-23 15:32 ebf18260]「合ってる。
// それでOK！」。2026-10-23 の根拠だった主の Claude の問い「左結合なら、`5 inc 3` は `(inc 5) 3`（値は [6 3]）でいい？」への U〔答え〕
// 10-22 11:24「そう、合ってる。」は、逆適用がある前提の答えで、R47 で上書きされた（`5 inc 3` は `5 (inc 3)`）。
// ここには、上の節で断る・通るが入れ替わった行を移した（行の注に、どの規則で変わったかを書く）。行の名前の「前は」は、2026-10-23 の
// 左からの畳み込みより前の答え、「その後」は 2026-10-23 の答え。
const leftFoldPasses = [
	// 値の後ろの関数は積まれて、根に余って `_`（R47・R42。余ったことは leftover-lambda で知らせる、R48）。2026-10-23 は逆適用で、口が2つ以上
	// 残った関数は主語の口が決まらないまま行の終わりで `_`、口が1つだけ残った関数はその口を埋めた（`5 (f2 1)` は `f2 1 5`）。前は G8。
	["5 f2（R47。前は G8、その後 主語の口が決まらない逆適用で `_`）", std("5 f2"), "(construct 5 (unit f2))", "A"],
	["5 (f2 1)（R47。前は G8、その後 `f2 1 5`）", std("5 (f2 1)"), "(construct 5 (unit [f2 1]))", "A"],
	// 余りを積んだ値の後ろの関数も積まれて余る（R47）。2026-10-23 はいちばん上の値（余り）を逆適用で取った。前は R37 と R36 で割れるので G12(a)。
	["inc 1 2 inc（`(inc 1) 2`、R47。前は G12(a)、その後 `(inc 1) (inc 2)`）", std("inc 1 2 inc"), "(construct (apply inc 1) 2 (unit inc))", "A"],
	// 口が1つだけ残った関数（括り・別名・部分適用の名前）も、値の後ろでは積まれて余る（R47）。2026-10-23 は逆適用でその口を埋めた（R40 の
	// 読み3）。前は R12 の形（`?` の定義を直に指すアリティ1の素の関数か `?` の括り）でないので G8。
	["5 [inc]（R47。前は G8、その後 逆適用）", std("5 [inc]"), "(construct 5 (unit [inc]))", "A"],
	["q : [inc] の後で 5 q（R47。前は G8、その後 逆適用）", std(["q : [inc]", "5 q"]), "(construct 5 (unit q))", "A"],
	["p : inc の後で 5 p（R47。前は G8、その後 逆適用）", std(["p : inc", "5 p"]), "(construct 5 (unit p))", "A"],
	["add1 : add 1 の後で 5 add1（R47。前は G8、その後 逆適用）", std(["add1 : add 1", "5 add1"]), "(construct 5 (unit add1))", "A"],
	["5 add inc（R47。前は G8、その後 主語の口が決まらない逆適用で `_`）", std("5 add inc"), "(construct 5 (unit (compose add inc)))", "A"],
	["double inc 5 6 inc（R47。前は G12(a)、その後 6 を逆適用で取る）", std("double inc 5 6 inc"), "(construct (apply (compose double inc) 5) 6 (unit inc))", "A"],
	// 書いた `_` は、値の隣と空の並びでは並びの単位としてその場で消える（R15・R43。畳み込みは単位から始まる）。U〔答え〕10-21 03:19 の表の
	// `_ inc 5`（印が単位として消える）を、左からの畳み込みで `_ inc` にも当てた（決定から外れた所：読み4 は G5 のままとしていた。§7.18）。
	// 前は G5（`_ f` の読み、§5 Q7）。2026-10-23 は、`_` が消えた後の inc が値を逆適用で取った（`5 _ inc` は `inc 5`）。R47 で inc は積まれて余る。
	["_ inc（`_` は消える。根なので `_`、R42・R43。前は G5）", std("_ inc"), "(unit inc)", "A"],
	["5 _ inc（R43・R47。前は G5、その後 `inc 5`）", std("5 _ inc"), "(construct 5 (unit inc))", "A"],
	["1 2 _ inc（R43・R47。前は G5、その後 `1 (inc 2)`）", std("1 2 _ inc"), "(construct 1 2 (unit inc))", "A"],
	["inc 5 _ inc（`inc 5` の後ろの `_` は消える、R43・R47。前は G5、その後 `inc (inc 5)`）", std("inc 5 _ inc"), "(construct (apply inc 5) (unit inc))", "A"],
	// 括りの関数の `_` は、残りの口が全部括りなら消える（R15）。裸の口 a は 1 で埋まった後なので、`_` は [b] に当たる（R43）。前は G5。
	["mx 1 _ 3（R43。前は G5）", std(["mx : a [b] ? a", "mx 1 _ 3"]), "(apply mx (construct 1 3))", "A"],
	["[!_] 1 2 inc（`([!_] 1) 2`、R47。前は G12(a)、その後 `([!_] 1) (inc 2)`）", std("[!_] 1 2 inc"), "(construct (apply [!_] 1) 2 (unit inc))", "A"],
	// 余りの後ろの関数は積まれて余る（R47）。2026-10-23 はいちばん上の余りを逆適用で取った。前は R37 と R36 で割れる G12(a)。
	["R24 tl 1 2 3 inc（R47。前は G12(a)、その後 `… (inc 3)`）", src(["inc : x ? x + 1", "tl : [x ~xs] y ? x + y", "tl 1 2 3 inc"]), "(construct (apply tl (construct 1 2)) 3 (unit inc))", "A"],
	["R24 (tl 1) 2 3 inc（R47。前は G12(a)、その後 `… (inc 3)`）", src(["inc : z ? z + 1", "tl : [x ~xs] y ? x + y", "(tl 1) 2 3 inc"]), "(construct (apply [tl 1] 2) 3 (unit inc))", "A"],
	["Q26 inc (pr 1) 5 6 inc（R47。前は G12(a)、その後 `… (inc 6)`）", src(["inc : x ? x + 1", "pr : x y ? y", "inc (pr 1) 5 6 inc"]), "(construct (apply (compose inc [pr 1]) 5) 6 (unit inc))", "A"],
	["pr inc [1] 2 3 double（R47。前は G12(a)、その後 `… (double 3)`）", src([INC, DOUBLE, "pr : [x ~xs] y ? y", "pr inc [1] 2 3 double"]), "(construct (apply (compose pr inc) (construct [1] 2)) 3 (unit double))", "A"],
	// 最後の括りは並びの終わりまで受ける（R41）ので、後ろの関数は合成になり、閉じた値（未知）を受けて未知（根なので通る）。前は、未知の
	// 節が隣の関数と結ぶ G2(a)。後ろの関数が並びから何も受けていない木は入れ子の適用（2026-10-23 までは書いた向きのまま逆適用と同じ
	// `·rev` の綴り、renderEntry の trailingFrom。R47 で無くなった）。
	["R24 gi 1 2 inc（R41。前は G2(a)）", src(["gi : [x ~xs] ? [,] x", "inc : y ? y + 1", "gi 1 2 inc"]), "(apply inc (apply gi (construct 1 2)))", "未知"],
	["R24 n vs~ 1 inc（R41。前は G2(a)）", src(["inc : y ? y + 1", "n : [~x] ? x", "vs : 1 , 2", "n vs~ 1 inc"]), "(apply inc (apply n (construct vs~ 1)))", "未知"],
	["pu inc [1] double（R41。前は G2(a)）", src([INC, DOUBLE, "pu : [x ~xs] ? [,] x", "pu inc [1] double"]), "(apply double (apply inc (apply pu [1])))", "未知"],
	// 実体の根が、外れた仮置きの上で閉じた枠に頼って未知に解き直される（§5 Q28）。前は隣の inc と結ぶ G2(a) で見ていた。根の種類で見る。
	["Q28 外れた仮置きの上で閉じた枠に頼る（括りの関数の実体。根が未知、R41）", src(["inc : x ? x + 1", "hb : [s] ? s 1", "f : x ?", "	inc", "	k x", "", "k : x ?", "	f x", "	hb [s : k]", "", "hb [s : k] inc"]), "(apply inc (apply hb [s : k]))", "未知"],
	// `[|]` の口は並びの終わりまで受ける（R41）ので、inc は合成されて閉じた値を受ける。`[|] fs` は fs の要素に関数が見えるので未知（R31）
	// で、inc は未知を受けて未知（根なので通る）。前は強さの順で `[|] fs` が先に未知の節になり、inc と結ぶ G2(a)。
	["[|] fs inc（R41。前は G2(a)）", std("[|] fs inc"), "(apply inc (apply [|] fs))", "未知"],
	// 可変長の口の後ろの点なしは、合成の後ろに入る（R40・R41）ので R13 に当たらない（前は `n 1 2` を先に縮めた値への逆適用で G10）。
	["n 1 2 [+ 1]（R41。前は G10）", std("n 1 2 [+ 1]"), "(apply [+ 1] (apply n (construct 1 2)))", "A"],
	["[* 2,] 1 2 3 [+ 1]（R41。前は G10）", std("[* 2,] 1 2 3 [+ 1]"), "(apply [+ 1] (apply [* 2,] (construct 1 2 3)))", "A"],
	// 2026-10-23 は、口が1つだけ残った関数の逆適用がその口を埋めた（R40 の読み3。括りの関数 a・実体の中の欄の関数 say。前は G8）。R47 で、
	// 値の後ろの関数は積まれて余る：根の `m a` は `_`（a は呼ばれず、R42・R48）。a3 の本体 `21 say` は評価する所でない（R42 の読み1）が、
	// 2026-10-24 の R52 から、値の上に積まれて何も受けずに閉じた say は余ったラムダで `_` になり、実体の本体の根は A。だから `a3 m` は A。
	// R47 の最初の版は、say がラムダのまま残って値と関数の並んだ構築が種類を決めず（未知、§5 Q38）、`a3 m` は未知だった。
	["R12 m a（R47。前は G8、その後 括りの関数の逆適用）", src([...IO, "m a"]), "(construct m (unit a))", "A"],
	["R12 実体の中の 21 say（R52。R47 では未知（Q38）、その前は G8、その後 欄の関数の逆適用で A）", src([...M, "a3 : [say] ? 21 say", "a3 m"]), "(apply a3 m)", "A", { leftoverDiag: ["say"] }],
];
const leftFoldRefused = [
	// 2026-10-23 は、add が 5 を逆適用で取り、口が決まらない（§5 Q5）まま 3 が来る G8 だった（`5 add 3 _`）。`[<<]` も素の2引数の関数と同じ
	// （R32）で、`1 [<<] 2 3 4` は G8 だった。逆適用の廃止（R47、G8 も廃止）で `5 (add 3 _)`・`1 ([<<] 2 3) 4` に決まり（前の強さの順の答えと
	// 同じ）、通る側（norevPasses）へ移した。断る行は無くなった。
];
for (const [name, s, want, kind, extra] of leftFoldPasses) checkPass(`畳み込み ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of leftFoldRefused) checkRefused(`畳み込み ${name}`, s, want, inst);

// ---------------------------------------------------------------------------
// 値の後ろの点なし（2026-10-23、R13 の廃止・§5 Q36）
// ---------------------------------------------------------------------------
//
// 決定の文面（U〔答え〕2026-10-22 22:15 で承認された、主の Claude の文面）は「今と答えが変わる形」に「`1 2 [+] 3 4` は `1 ([+] 2 3 4)`」を
// 挙げ、A·L を「逆適用。L が、いちばん上の A を取る」とだけ書く。点なしは、ほかの関数と同じに主語を取る。R13（U 2026-08-06 05:06
// 「ポイントフリーであれば、apply-reverceから除外するのがいいと思う。」）は、強さの順で縮めていた頃に `1 2 [+] 3 4` の読みの崩れを
// 直すために入れた物で、左からの畳み込みでは、文面の例そのものと割れるので廃止した（§4 R13、§7.19）。作り直しの最初の版は R13 を
// 残して、ここの行を G10 で断っていた。
// 2026-10-23 は、主語の口がほかの関数と同じ形で決まった（R40 の読み3）：口が1つ（単項の点なし・前置・後置の点なし・1つ当てた部分適用）か
// 可変長の口だけ（畳む点なし・貪欲な単項）なら主語はその口に入り、段18 の点なし（`[' 0]`）は書いていない左の被演算子の口に入り（R26）、
// 口が2つ（畳まない2項の点なし `[<<]`、R32）か数が分からない（`[,]`）なら、主語の口が決まらなかった（§5 Q5）。
//
// 2026-10-24 の逆適用の廃止（R47）で、点なしもほかの関数と同じく、値の後ろに積まれて値を取らない。後ろの項を右から受け、根に余れば `_`
// （R42、構築の中で消える。余ったことは leftover-lambda で知らせる、R48）。決定の文面の `1 2 [+] 3 4` は `1 2 ([+] 3 4)`（主の Claude が示した
// 表の形。U〔答え〕[2026-10-23 15:32 ebf18260]「合ってる。 それでOK！」）。行の名前の「前は」は 2026-10-23 より前、「その後」は 2026-10-23 の答え。
const pfReversePasses = [
	// 決定の文面の例。R47 で `[+]` は 2 を取らず、後ろの 3 4 を可変長の口で受ける（R41）。
	["1 2 [+] 3 4（`1 2 ([+] 3 4)`、R47。前は `1 2 ([+] 3 4)`、その後 G10・`1 ([+] 2 3 4)`）", std("1 2 [+] 3 4"), "(construct 1 2 (apply [+] (construct 3 4)))", "A"],
	// §5 Q23 の答え（`[* 2] (inc 5)`）は逆適用がある前提の答えで、R47 で上書きされた：合成 `inc [* 2]` が 5 の後ろに積まれて余る。
	["5 inc [* 2]（R47。前は Q23 の答えの `[* 2] (inc 5)`、作り直しの最初の版は G10）", std("5 inc [* 2]"), "(construct 5 (unit (compose inc [* 2])))", "A"],
	["5 inc [-_]（R47。前は Q23 の答え、作り直しの最初の版は G10）", std("5 inc [-_]"), "(construct 5 (unit (compose inc [-_])))", "A"],
	// 前は `[+]` が `inc 5` の値（中身の見えない A）を受けて未知（R31）。R47 では何も受けずに余るので、根は A。
	["5 inc [+]（R47。前は未知の根）", std("5 inc [+]"), "(construct 5 (unit (compose inc [+])))", "A"],
	// R13 の前の見本。前は G10、2026-10-23 は逆適用。
	["5 [+ 1]（R47。前は G10、その後 逆適用）", std("5 [+ 1]"), "(construct 5 (unit [+ 1]))", "A"],
	["5 [* 2] inc（R47。前は G10、その後 `inc ([* 2] 5)`）", std("5 [* 2] inc"), "(construct 5 (unit (compose [* 2] inc)))", "A"],
	// R47：`[+ 1]` は 5 を取らず、後ろの 3 を受ける（2026-10-22 の強さの順と同じ木）。2026-10-23 は `([+ 1] 5) 3`。
	["5 [+ 1] 3（`5 ([+ 1] 3)`、R47。前は `5 ([+ 1] 3)`、その後 `([+ 1] 5) 3`）", std("5 [+ 1] 3"), "(construct 5 (apply [+ 1] 3))", "A"],
	["1 2 [+ 1]（R47。前は G10、その後 `1 ([+ 1] 2)`）", std("1 2 [+ 1]"), "(construct 1 2 (unit [+ 1]))", "A"],
	["inc 1 2 [+ 1]（R47。前は G12(a)・G10、その後 `(inc 1) ([+ 1] 2)`）", std("inc 1 2 [+ 1]"), "(construct (apply inc 1) 2 (unit [+ 1]))", "A"],
	["5 [-_]（R47。前は G10、その後 逆適用）", std("5 [-_]"), "(construct 5 (unit [-_]))", "A"],
	["5 [!_]（R47。前は G10、その後 逆適用）", std("5 [!_]"), "(construct 5 (unit [!_]))", "A"],
	["5 [-_] inc（R47。前は G10、その後 逆適用）", std("5 [-_] inc"), "(construct 5 (unit (compose [-_] inc)))", "A"],
	["5 [-_,]（R47。前は G10、その後 逆適用）", std("5 [-_,]"), "(construct 5 (unit [-_,]))", "A"],
	// 畳む2項の点なしも、5 を取らずに余る。
	["5 [+]（R47。前は G10（§6.3 の行）、その後 逆適用）", std("5 [+]"), "(construct 5 (unit [+]))", "A"],
	["5 [*]（R47。前は G10、その後 逆適用）", std("5 [*]"), "(construct 5 (unit [*]))", "A"],
	["5 [&]（R47。前は G10、その後 逆適用）", std("5 [&]"), "(construct 5 (unit [&]))", "A"],
	["5 [<]（R47。前は G10、その後 逆適用）", std("5 [<]"), "(construct 5 (unit [<]))", "A"],
	// `[+]` に合成した inc も一緒に余る（2026-10-23 は `[+]` が 5 を取って `inc ([+] 5)`）。
	["5 [+] inc（R47。前は G10、その後 `inc ([+] 5)`）", std("5 [+] inc"), "(construct 5 (unit (compose [+] inc)))", "A"],
	// `_` は積まれた `[+]` の実引数の印（R31）。2026-10-23 は `[+] 5 _`。
	["5 [+] _（`5 ([+] _)`、R47・R31。前は G10、その後 `[+] 5 _`）", std("5 [+] _"), "(construct 5 (apply [+] _))", "A"],
	["1 [*] 2 3 4（`1 ([*] 2 3 4)`、R47。前は G10、その後 `[*] 1 2 3 4`）", std("1 [*] 2 3 4"), "(construct 1 (apply [*] (construct 2 3 4)))", "A"],
	// 段18 の点なしも積まれる。2026-10-23 は書いていない左の被演算子の口に主語が入り（`vs [' 0]` は `[' 0] vs`）、`5 [' 0]` は数から引かないので
	// 未知だった。R47 では何も受けずに余るので A。
	["5 [' 0]（R47。前は G10、その後 未知の根）", std("5 [' 0]"), "(construct 5 (unit [' 0]))", "A"],
	["vs [' 0]（R47。前は `[' 0] vs`）", std("vs [' 0]"), "(construct vs (unit [' 0]))", "A"],
	["vs [' 0] inc（R47。前は `inc ([' 0] vs)`）", std("vs [' 0] inc"), "(construct vs (unit (compose [' 0] inc)))", "A"],
	// 1つ当てた畳まない2項の点なし（口が1つ）も、素の2引数の関数の部分適用（`5 (add 1)`）と同じく積まれて余る。
	["5 ([<<] 1)（R47。前は G10、その後 `[<<] 1 5`）", std("5 ([<<] 1)"), "(construct 5 (unit [[<<] 1]))", "A", { pfInfo: "[<<]" }],
	["q : [<<] 1 ⏎ 5 q（R47。前は G10、その後 逆適用）", std(["q : [<<] 1", "5 q"]), "(construct 5 (unit q))", "A", { pfInfo: "[<<]" }],
	["5 ([<<] 1) inc（R47。前は G10、その後 逆適用）", std("5 ([<<] 1) inc"), "(construct 5 (unit (compose [[<<] 1] inc)))", "A", { pfInfo: "[<<]" }],
	["q : [<<] 1 ⏎ 5 q inc（R47。前は G10、その後 逆適用）", std(["q : [<<] 1", "5 q inc"]), "(construct 5 (unit (compose q inc)))", "A", { pfInfo: "[<<]" }],
	["5 inc ([<<] 1)（R47。前は Q23 の答えの `[<<] 1 (inc 5)`）", std("5 inc ([<<] 1)"), "(construct 5 (unit (compose inc [[<<] 1])))", "A", { pfInfo: "[<<]" }],
	["q : [<<] 1 ⏎ 5 inc q（R47。前は Q23 の答え）", std(["q : [<<] 1", "5 inc q"]), "(construct 5 (unit (compose inc q)))", "A", { pfInfo: "[<<]" }],
	// 口が2つの `[<<]` も積まれて余る（2026-10-23 は主語の口が決まらない逆適用で、行の終わりで `_`）。
	["5 [<<]（R47。前は G10、その後 主語の口が決まらない `_`）", std("5 [<<]"), "(construct 5 (unit [<<]))", "A", { pfInfo: "[<<]" }],
	["5 inc [<<]（R47。前は 作り直しの最初の版の G10、その後 `_`）", std("5 inc [<<]"), "(construct 5 (unit (compose inc [<<])))", "A", { pfInfo: "[<<]" }],
];
const pfReverseRefused = [
	// 2026-10-23 の G8（`1 [<<] 2 3 4 inc`・`1 [,] 2 3 4`：主語の口が決まらないまま実引数が来る）と G2(a)（`vs [' 0] inc 4`：段18 の点なしが
	// 主語を取った後に関数が合成され、さらに値が同じ点なしの口に入る）は、逆適用の廃止（R47）で `1 ([<<] 2 3) 4` の後ろに inc が余る形・
	// `1 ([,] 2 3 4)`・`vs ([' 0] inc 4)` に決まり、通る側（norevPasses）へ移した。断る行は無くなった。
];
for (const [name, s, want, kind, extra] of pfReversePasses) checkPass(`値の後ろの点なし ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of pfReverseRefused) checkRefused(`値の後ろの点なし ${name}`, s, want, inst);

// ---------------------------------------------------------------------------
// §7.18 の確かめの指摘を当てた直し（2026-10-23、§7.19）
// ---------------------------------------------------------------------------
const GQ = "gq : x [y : 1] ? x + y"; // 既定値のある関数（口は2つ、後ろが既定値のある口）
const fixFoldPasses = [
	// 2026-10-23 は、主語の口が決まらない逆適用の後の、並びの最後の `_` を、頭が素の関数なら R28 の「ここで終わる」で A にした（主語が
	// どの口に入っても、`_` を除いた実引数（主語1つ）は足りない。前は G8）。R47 では値の後ろの関数は積まれて口が全部開いているので、`_` は
	// その関数の最初の口に当たる R28 の終わり（`5 (f2 _)`、値は 5）。
	["5 f2 _（`5 (f2 _)`、R47・R28。前は G8、その後 `(apply f2 (construct 5 _) ·rev)`）", std("5 f2 _"), "(construct 5 (apply f2 _))", "A"],
	["5 add _（同じ）", std("5 add _"), "(construct 5 (apply add _))", "A"],
	["1 2 f2 _（同じ）", std("1 2 f2 _"), "(construct 1 2 (apply f2 _))", "A"],
	["5 [<<] _（畳まない2項の点なしも n = 2、R28・R32・R47）", std("5 [<<] _"), "(construct 5 (apply [<<] _))", "A", { pfInfo: "[<<]" }],
	// 2026-10-23 は、主語の口が決まらない逆適用で、頭が口の数の分からない関数（既定値のある関数・`[,]`）なら、主語がどの口に入ったかで
	// 足りたかが変わる（§5 Q8）ので未知にした（その前は `_`）。R47 では何も受けずに積まれて余り、根で `_`（R42・R48）なので A。
	["gq : x [y : 1] ? x + y ⏎ 5 gq（R47。前は `_`、その後 未知の根）", src([GQ, "5 gq"]), "(construct 5 (unit gq))", "A"],
	["5 gq inc（R47。前は `_`、その後 未知の根）", src([GQ, INC, "5 gq inc"]), "(construct 5 (unit (compose gq inc)))", "A"],
	["5 [,]（R47。前は 未知の根）", std("5 [,]"), "(construct 5 (unit [,]))", "A"],
	// 口の数が数えられる関数も、余ったラムダは今までどおり `_`（R42）。2026-10-23 は逆適用の `(unit (apply f2 5 ·rev))` で行の値が `_`、
	// R47 では f2 が 5 の後ろに積まれて余り、`_` になるのは f2 だけで、行の値は 5。
	["5 f2（R47：f2 が積まれて余り、値は 5。前は行の値が `_`）", std("5 f2"), "(construct 5 (unit f2))", "A"],
	["5 map（R47：map が積まれて余り、値は 5。前は行の値が `_`）", std("5 map"), "(construct 5 (unit map))", "A"],
	// 名前の右辺の器の数は、ファイルの値の定義を直に指す名前の葉にだけ付ける（valueCountOf）。括りの関数の実体の中の仮引数（`[~r]`）は
	// 数えないので未知（実体は長さを書かない形で共有される、R24）。前は、器の数が desc に乗って仮引数に入り、行の順で答えが変わった。
	["ap : [~r] ? (f4 !_) 1 r ⏎ ap vs（未知。前は A で、ap ws と並べる順で割れた）", std(["ws : 1 , 2", "ap : [~r] ? (f4 !_) 1 r", "ap vs"]), "(apply ap vs)", "未知"],
	["ap ws（未知。前は単独なら G16）", std(["ws : 1 , 2", "ap : [~r] ? (f4 !_) 1 r", "ap ws"]), "(apply ap ws)", "未知"],
	["ap2 : [x ~xs] ? (f4 !_) 1 xs ⏎ ap2 vs（尾の数は数えない。前は器全体の数 3 で A）", std(["ap2 : [x ~xs] ? (f4 !_) 1 xs", "ap2 vs"]), "(apply ap2 vs)", "未知"],
	// ファイルの値の定義を直に指す名前は、今までどおり数える（[x] ≅ x、R41 の読み5）。
	["(f4 !_) 1 vs（`f4 1 1 2 3`）", std("(f4 !_) 1 vs"), "(apply [f4 !_] (construct 1 vs))", "A"],
	["ws : 1 , 2 ⏎ (f4 !_) 1 ws（足りない、根で `_`）", std(["ws : 1 , 2", "(f4 !_) 1 ws"]), "(unit (apply [f4 !_] (construct 1 ws)))", "A"],
	["zs : ws ⏎ (f4 !_) 1 zs（名前の名前も数える）", std(["ws : 1 , 2 , 3", "zs : ws", "(f4 !_) 1 zs"]), "(apply [f4 !_] (construct 1 zs))", "A"],
	// 段18 の点なしが1つ受けて引いた物が値なら、後ろに関数だけが続く形は通していた（`[' 0] [1 2 3] inc`・`[' 0] [1 2 3] inc inc`）。R47 で
	// 断る側（下の fixFoldRefused）へ移した。
	// 部分適用の名前の末尾の `_` は今までどおり R28（素の関数の部分適用、名前と括り）。
	["a1 : add 5 ⏎ a1 _（今までどおり R28）", std(["a1 : add 5", "a1 _"]), "(apply a1 _)", "A"],
	["(add 5) _（今までどおり R28）", std("(add 5) _"), "(apply [add 5] _)", "A"],
];
const fixFoldRefused = [
	// 段18 の点なしが1つ受けた後に関数が来る（§5 Q39）。2026-10-23 は、引いた物が値なら、閉じた読み（閉じて値になり、後ろの関数が逆適用で
	// それを取る）と開いた読み（まだ受けていて、後ろの関数は合成）が同じ答えなので通し、後ろから値が同じ点なしの口に入った所で G2(a) に
	// した（`[' 0] [1 2 3] inc 4`。前は開いた読みを黙って選んでいた）。逆適用の廃止（R47）で、閉じた読みの後ろの関数は値の後ろに積まれて
	// 値を取らない（`([' 0] [1 2 3]) inc` は 1 の後ろに inc が余る）ので、関数が来た所で2つの読みが割れる。`[,] 5 g 3` と同じく G2(a)
	// （resolve.js の foldStep）。下の5行は、門は同じで、当たる所が後ろの関数に移った。
	["[' 0] [1 2 3] inc（R47 で G2(a)。前は `inc ([' 0] [1 2 3])` で通る）", std("[' 0] [1 2 3] inc"), "G2(a)"],
	["[' 0] [1 2 3] inc inc（R47 で G2(a)。前は通る）", std("[' 0] [1 2 3] inc inc"), "G2(a)"],
	["[' 0] [1 2 3] inc 4（G2(a)。前は `inc ([' 0] [1 2 3] 4)` の未知）", std("[' 0] [1 2 3] inc 4"), "G2(a)"],
	["[' 0] [1 2 3] f2 5（G2(a)。前は未知）", std("[' 0] [1 2 3] f2 5"), "G2(a)"],
	["[' 0] [1 2 3] add 5 6（G2(a)。前は未知）", std("[' 0] [1 2 3] add 5 6"), "G2(a)"],
	// 合成を名前や括りで包んだ物の末尾の `_` は、書いたままの合成と同じ G5（§5 Q18 の残り。`:` はメタで、名前は式を指す）。前は名前と
	// 括りだけが R28 で通っていた。
	["q : inc add 5 ⏎ q _（`inc add 5 _` と同じ G5。前は A）", std(["q : inc add 5", "q _"]), "G5"],
	["(inc add 5) _（同じ G5。前は A）", std("(inc add 5) _"), "G5"],
	["inc add 5 _（今までどおり G5）", std("inc add 5 _"), "G5"],
	["r : inc f3 5 ⏎ r 1 _（`inc f3 5 1 _` と同じ G5。前は A）", std(["r : inc f3 5", "r 1 _"]), "G5"],
	["r : inc f3 5 ⏎ (r 1) _（同じ G5。前は A）", std(["r : inc f3 5", "(r 1) _"]), "G5"],
	// 2026-10-23 は、主語の口が決まらない逆適用の後で、並びの最後でない `_`・既定値のある関数・括りの関数は G8 だった。逆適用の廃止（R47、
	// G8 も廃止）で、値の後ろの関数は積まれて口が全部開いているので、`_` はほかの関数の口と同じ規則で読む：`5 (gq _)` の `_` は gq の最初の口
	// （x、既定値の無い口）で G15、`1 (hh _)` は括りの関数の末尾の `_` で、`_` を除いた実引数がアリティに足りないので G5（`io1 _` と同じ）。
	// `5 f2 _ 3` は、R47 の最初の版では並びの頭でない素の関数の内側の `_` として G5 だったが、同じ日の確かめで、積まれた f2 の後ろの並びにも
	// 穴の規則を当てるよう直した（`5 (f2 _ 3)` と同じ。いちばん後ろの「逆適用の廃止の確かめ」の norevFixPasses）。
	["5 gq _（R47 で G15。前は G8）", src([GQ, "5 gq _"]), "G15"],
	["1 hh _（R47 で G5。前は G8、hh : [a] [b] ? a）", src(["hh : [a] [b] ? a", "1 hh _"]), "G5"],
];
for (const [name, s, want, kind, extra] of fixFoldPasses) checkPass(`確かめの直し ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of fixFoldRefused) checkRefused(`確かめの直し ${name}`, s, want, inst);

// ---------------------------------------------------------------------------
// 口の外の恒等射・恒等射は `,` の単位（2026-10-23、R44〜R46、§7.20）
// ---------------------------------------------------------------------------
//
// U [2026-10-22 23:42 ebf18260]「!_ 5 とか !_ , 5 とかも確かめておいた方が良いね。」、U〔答え〕[2026-10-22 23:48 ebf18260]「5 !_ / 5 , !_
// も追加で、 全部5になるはず…」（主の Claude の問い「`!_ 5` は `i 5` に合わせて 5、でいい？」への答え。`!_ , 5` を 5 にしたのは利用者で、
// 主の Claude の案1は `(, !_ 5)` だった）。
// - R44：括らない `!_` が口の外（並びの頭・値の後ろ）にあれば、`i : !_` の i（R29 の恒等射）と同じ。`:` はメタなので、並びの頭と `5` の
//   後ろの `!_ X` と `i X` は同じ答え（法則11）。同じにならない所は名指しで断る：頭の関数の口を値で埋めた後ろ（`inc 5 !_` の G13、§5 Q40）と
//   中置の被演算子（`!_ == 1` の G7、§5 Q15）。前は G7（U〔答え〕10-21 23:47）。
// - R45：恒等射は `,` の単位。`,` の被演算子にあれば消え、もう片方の被演算子が答え（木も、もう片方の木そのもの）。片方が恒等射なら G3 の
//   割れも消える。根の `,` が消えて並びだけが残れば、その並びは評価する所（R42）。
// - R46：口の中で穴の規則（R16・R34）が読まない `!_` は、穴と読んでも恒等射と読んでも同じ関数になる所（口の数の決まった関数に口が
//   1つだけ残った所）だけ通し、ほかは G7（括りの関数の口は G5）。
const idPasses = [
	// R44：口の外
	["!_ 5（前は G7）", std("!_ 5"), "(apply !_ 5)", "A"],
	// 値の後ろの恒等射は、2026-10-23 は逆適用で 5 を取った（`(apply !_ 5 ·rev)`・`(apply !_ (construct 5 3) ·rev)`）。2026-10-24 の R47 から
	// 積まれて、何も受けなければ余って `_`（R42）。余ったのが恒等射なので知らせない（R48）。値は今までどおり 5 と `5 3`（U〔答え〕10-22 23:48
	// 「…全部5になるはず…」）。
	["5 !_（R47。前は G7、その後 逆適用）", std("5 !_"), "(construct 5 (unit !_))", "A", { diagCount: 0 }],
	["5 !_ 3（`5 (!_ 3)`、`5 i 3` と同じ。R47。前は G7、その後 逆適用）", std("5 !_ 3"), "(construct 5 (apply !_ 3))", "A"],
	["!_ 5 6（`i 5 6` と同じ、並び全体を受ける。前は G7）", std("!_ 5 6"), "(apply !_ (construct 5 6))", "A"],
	["!_ inc（`i inc` と同じ合成が余る。根なので `_`、R42。前は G7）", std("!_ inc"), "(unit (compose !_ inc))", "A"],
	["!_ _（`i _` と同じ終わり、R28。前は G7）", std("!_ _"), "(apply !_ _)", "A"],
	["5 !_ _（`5 (!_ _)`、`5 i _` と同じ。R47。前は G7、その後 逆適用）", std("5 !_ _"), "(construct 5 (apply !_ _))", "A"],
	// inc 5 が閉じた後ろの口の外の恒等射に inc を合成して余る（R47・R42・R48）。2026-10-23 は `inc (!_ (inc 5))`。
	["inc 5 !_ inc（inc 5 が閉じた後ろの口の外。R47。前は G7、その後 逆適用）", std("inc 5 !_ inc"), "(construct (apply inc 5) (unit (compose !_ inc)))", "A"],
	["本体 t : y ? !_ y（前は G7）", std("t : y ? !_ y"), "(apply !_ y)", "A", { body: true }],
	// 本体は評価する所でない（R42 の読み1）が、2026-10-24 の R52 から、y の上に積まれて何も受けずに閉じた恒等射は余って `_` で消える（恒等射
	// なので知らせない、R48）。R47 の最初の版は、ラムダのまま残って値と関数の並んだ構築が種類を決めなかった（未知、§5 Q38）。2026-10-23 は
	// 逆適用で `(apply !_ y ·rev)`、A。
	["本体 t : y ? y !_（R52。R47 では未知（Q38）、その前は G7、その後 A）", std("t : y ? y !_"), "(construct y (unit !_))", "A", { body: true, leftoverDiag: [] }],
	// R46：口の中で、口の数の決まった関数に口が1つだけ残った所（穴の λ は η でその部分適用そのもの）
	["inc !_ inc（`inc inc` と同じ関数。前は G7）", std("inc !_ inc"), "(unit (compose inc !_ inc))", "A"],
	["inc !_ inc 5（前は G7）", std("inc !_ inc 5"), "(apply (compose inc !_ inc) 5)", "A"],
	["[+ 1] !_（`[+ 1]` と同じ関数。前は G7）", std("[+ 1] !_"), "(unit (compose [+ 1] !_))", "A"],
	["[+ 1] !_ 5（前は G7）", std("[+ 1] !_ 5"), "(apply (compose [+ 1] !_) 5)", "A"],
	["[<<] 1 !_（`[<<] 1` と同じ関数。前は G7）", std("[<<] 1 !_"), "(unit (compose (apply [<<] 1) !_))", "A", { pfInfo: "[<<]" }],
	["go2 : go ⏎ go2 !_ 3（別名の頭。穴なら `go 3`、恒等射でも `go 3`。前は G7）", std([...GO, "go2 : go", "go2 !_ 3"]), "(apply (compose go2 !_) 3)", "A"],
	// R45：`,` の単位
	["!_ , 5（前は G7）", std("!_ , 5"), "5", "A"],
	["5 , !_（前は G7）", std("5 , !_"), "5", "A"],
	["i , 5（前は (, i 5)）", std(["i : !_", "i , 5"]), "5", "A"],
	["5 , i（前は (, 5 i)）", std(["i : !_", "5 , i"]), "5", "A"],
	["(i) , 5（括った恒等射も）", std(["i : !_", "(i) , 5"]), "5", "A"],
	["1 , !_ , 2（`,` は右結合なので `1 , 2`。前は G7）", std("1 , !_ , 2"), "(, 1 2)", "A"],
	["!_ , !_（1 × 1 ≅ 1。根なので `_`、R42。前は G7）", std("!_ , !_"), "(unit !_)", "A"],
	["!_ , !_ , 5（前は G7）", std("!_ , !_ , 5"), "5", "A"],
	["(!_ , !_) , 5（括りの中で消えた恒等射も単位）", std("(!_ , !_) , 5"), "5", "A"],
	["!_ , _（`_` が残る。前は G7）", std("!_ , _"), "_", "A"],
	["!_ , 1 2（前は G7）", std("!_ , 1 2"), "(construct 1 2)", "A"],
	["inc , !_（根なので `_`、R42。前は G7）", std("inc , !_"), "(unit inc)", "A"],
	["inc , !_ , double（器の長さが変わる。前は G7）", std("inc , !_ , double"), "(, inc double)", "A"],
	["inc , $!_ , double（器に残すなら `$!_`）", std("inc , $!_ , double"), "(, inc (, $!_ double))", "A"],
	["x2 : !_ , !_ ⏎ x2 5（定義の右辺の `,` も消える）", std(["x2 : !_ , !_", "x2 5"]), "(apply x2 5)", "A"],
	["cc : !_ , inc ⏎ cc 5", std(["cc : !_ , inc", "cc 5"]), "(apply cc 5)", "A"],
	["[!_ , 5] 3（括りの中の `!_ , 5` は 5）", std("[!_ , 5] 3"), "(construct [!_ , 5] 3)", "A"],
	// R45：片方が恒等射なら G3 の割れも消える（`(f x) , !_` と `f (x , !_)` はどちらも `f x`）。残った並びは、根なら評価する所（R42）。
	["inc 1 , !_（前は G3）", std("inc 1 , !_"), "(apply inc 1)", "A"],
	["!_ , inc 1（前は G3）", std("!_ , inc 1"), "(apply inc 1)", "A"],
	["!_ 5 , !_（前は G3）", std("!_ 5 , !_"), "(apply !_ 5)", "A"],
	["inc add 5 , !_（根の並びと同じ `_`。前は G3）", std("inc add 5 , !_"), "(unit (apply (compose inc add) 5))", "A"],
	// 行 `1 2 f2` と同じ（R47 で f2 は積まれて余り、根で `_`。2026-10-23 は `1 (2 f2)`）。
	["1 2 f2 , !_（根の並びと同じ。前は G3）", std("1 2 f2 , !_"), "(construct 1 2 (unit f2))", "A"],
	// 決めないこと（§5 Q41）：`_ , 5` は今の答えのまま。
	["_ , 5（今のまま、§5 Q41）", std("_ , 5"), "(, _ 5)", "A"],
];
const idRefused = [
	// R44 の帰結：`!_ X` は `i X` と同じ門
	["!_ 1 2 inc（`i 1 2 inc` と同じ G18。前は G7）", std("!_ 1 2 inc"), "G18"],
	["!_ inc 1 2（`i inc 1 2` と同じ G18。前は G7）", std("!_ inc 1 2"), "G18"],
	["5 !_ 3 inc（`5 i 3 inc` と同じ G18。前は G7）", std("5 !_ 3 inc"), "G18"],
	["!_ inc _（`i inc _` と同じ G5、§5 Q18。前は G7）", std("!_ inc _"), "G5"],
	// `vs~ !_`（`vs~ i` と同じ G9、R14）と `5 uu !_`（uu が 5 を逆適用で取って未知になり、その後ろの恒等射で G2(a)）は、逆適用の廃止（R47、
	// G9 も廃止）で、値の後ろに恒等射・合成 `uu !_` が積まれて余る形に決まり、通る側（norevPasses）へ移した。
	// R46：口の中で、穴と恒等射が同じ関数と言えない所は G7 のまま
	["[<<] !_ 2（口が2つ残る）", std("[<<] !_ 2"), "G7"],
	["add !_ _（口が2つ残る）", std("add !_ _"), "G7"],
	["[+ 1,] !_（可変長の口）", std("[+ 1,] !_"), "G7"],
	["i !_（恒等射の口は可変長）", std(["i : !_", "i !_"]), "G7"],
	["!_ !_（同じ）", std("!_ !_"), "G7"],
	// 値の後ろに積まれた点なしの口が2つ残る（R47。2026-10-23 は主語の口が決まらない逆適用の口で G7）。素の関数の `5 f2 !_` は、R47 の最初の
	// 版ではここで G7 だったが、同じ日の確かめで、積まれた f2 の後ろの並びにも穴の規則（R34 の k < n）を当てるよう直した（`5 (f2 !_)` と
	// 同じ。norevFixPasses）。穴の規則の頭は名前の定義か `?` の括りだけなので、点なしの `[<<]` は今のまま。
	["5 [<<] !_ 2（積まれた点なしの口が2つ残る。前は 主語の口が決まらない逆適用）", std("5 [<<] !_ 2"), "G7"],
	["inc !_ _（R46 で通った `inc !_` は合成で、`inc i _` と同じ G5、§5 Q18。前は G7）", std("inc !_ _"), "G5"],
	["io1 inc !_（口に入る段が括りの関数。前は G7）", std([IO1, "io1 inc !_"]), "G5"],
	// 口の中の `!_` で、穴の規則が並び全体で断る形は今のまま（G5・G13、§5 Q40）
	["io1 !_ 5（今のまま G5）", std([IO1, "io1 !_ 5"]), "G5"],
	["inc 5 !_（今のまま G13、§5 Q40）", std("inc 5 !_"), "G13"],
	// 中置の被演算子の `!_` は今のまま（§5 Q15、U 10-14 03:28）
	["!_ + 1（今のまま G7）", std("!_ + 1"), "G7"],
	["!_ == 1（今のまま G7）", std("!_ == 1"), "G7"],
	["[+ !_]（今のまま G7）", std("[+ !_]"), "G7"],
	// R45：G3 が消えるのは片方が恒等射のときだけ
	["inc 1 , !_ , 2（右結合で `inc 1 , 2`、G3）", std("inc 1 , !_ , 2"), "G3"],
	["!_ 5 , 6（`!_ 5` は恒等射ではない、G3）", std("!_ 5 , 6"), "G3"],
];
for (const [name, s, want, kind, extra] of idPasses) checkPass(`恒等射 ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of idRefused) checkRefused(`恒等射 ${name}`, s, want, inst);

// ---------------------------------------------------------------------------
// 恒等射の確かめの直し（2026-10-23、R44〜R46 の確かめ、§7.20 の「確かめの直し」）
// ---------------------------------------------------------------------------
//
// - 括りの関数の G5 は、`!_` が入る段で見る（holeStep）。`!_` のすぐ前の関数が括りの関数でも、`!_` が入るのが前の関数の口なら、その口で
//   見る（`inc io1 !_` は inc の口で R46。`(inc io1) !_` と同じ）。並び全体で断るのは、括りの関数の頭の口を値で埋めた後ろの `!_` だけ
//   （`pq 1 2 !_`。素の関数の頭の `inc 5 !_`（G13）と同じ問い、§5 Q40）。
// - 単位律（恒等射を消した並び）と、R29 の流れ（恒等射が受けた物を流れとして後ろへ渡す）が割れる所は G18：恒等射が1つ受けた後に合成した、
//   主語の口が1つに決まらない関数（`(5 !_ f2) 3`。単位律では `(5 f2) 3` の G8。根だけなら、どちらも行の終わりで `_`）、2つ以上受けた後に
//   合成した貪欲な単項・ノルム（`!_ 1 2 [* 2,]`。単位律では `1 ([* 2,] 2)`）、単位律では逆適用が断られる所（撒く項の主語・種類の決まらない
//   値の後ろの関数・主語を取った段18 の点なしの後ろの関数）。法則13 が、恒等射を消した並びと比べる。
// - 2026-10-24 の逆適用の廃止（R47）で、単位律の読みの後ろの関数は値の後ろに積まれて値を取らない。だから恒等射が受けた後に合成された関数は、
//   どれも流れの読み（その関数が受ける）と割れて G18（`i 5 inc`・`!_ 5 f2`・`i 1 [* 2,] 2`。前は主語の口が1つに決まる関数なら通していた）。
//   恒等射が何も受けていない形（`5 !_ f2`・`(5 !_ f2) 3`・`5 !_ uu inc`）は、`5 f2` と同じく関数が積まれて余るだけで割れない：根なら通り、
//   括りの中なら値と関数の並んだ構築（未知、§5 Q38）で、後ろに当てれば G7。恒等射が受けた物を、口の数の分からない関数が受けて、その後に
//   関数が合成された形（`i [,] 5 inc`）も G18（単位律では G2(a)。HEAD では通っていた）。
// - 両方とも恒等射の `,` は `!_` を残す（`!_ , i == 1` と `i , !_ == 1` が同じ G7、§5 Q15）。
const PQ = "pq : [a] y ? y"; // UU（本体の根が未知の uu）は上の定義を使う
const idFixPasses = [
	["inc io1 !_（`!_` は inc の口、R46。`(inc io1) !_` と同じ。前は G5）", std([IO1, "inc io1 !_"]), "(unit (compose inc io1 !_))", "A"],
	["inc n !_（同じ。前は G5）", std("inc n !_"), "(unit (compose inc n !_))", "A"],
	// 閉じた値の後ろの口の外の恒等射は積まれて余る（R47・R42。恒等射なので知らせない、R48）。2026-10-23 は逆適用で `!_ (pq 1 2)` など。
	["(pq 1) 2 !_（括りの頭でない。`(add 1) 2 !_` と同じ口の外。R47。前は G5、その後 逆適用）", std([PQ, "(pq 1) 2 !_"]), "(construct (apply [pq 1] 2) (unit !_))", "A"],
	["(add 1) 2 !_（口の外。R47）", std("(add 1) 2 !_"), "(construct (apply [add 1] 2) (unit !_))", "A"],
	["(pq 1 2) !_（括りで閉じた値の後ろ。R47）", std([PQ, "(pq 1 2) !_"]), "(construct [pq 1 2] (unit !_))", "A"],
	// 恒等射は何も受けず、合成 `!_ f2` が 5 の後ろに積まれて余る（R47。`5 f2` と同じ）。2026-10-23 は恒等射が 5 を取り、印 idSplit で残した。
	["5 !_ f2（根だけなら、`5 f2` と同じく余って `_`。R47）", std("5 !_ f2"), "(construct 5 (unit (compose !_ f2)))", "A"],
	["(i f2 5) 3（f2 は恒等射が受ける前に合成。単位律でも `(f2 5) 3`）", std(["i : !_", "(i f2 5) 3"]), "(apply [i f2 5] 3)", "A"],
	// `i 1 [* 2,] 2`（1つ受けた後の貪欲な単項。2026-10-23 は単位律でも `1 [* 2,] 2` が逆適用で全部を受けたので通していた）は、R47 で G18（下の
	// idFixRefused）。
	["!_ [* 2,] 1 2（受ける前に合成した貪欲な単項）", std("!_ [* 2,] 1 2"), "(apply (compose !_ [* 2,]) (construct 1 2))", "A"],
	// `||!_||` の中の恒等射は消さない。`||!_||` は 5 を取らずに積まれて、後ろの 6 を受ける（R47。2026-10-23 は `||!_|| 5 6`）。
	["5 ||!_|| 6（`5 (||!_|| 6)`、R47。前は `||!_|| 5 6`）", std("5 ||!_|| 6"), "(construct 5 (apply ||!_|| 6))", "A"],
	// 恒等射は何も受けず、合成 `!_ [' 0] inc` が積まれて余る（R47）。2026-10-23 は恒等射が [1 2 3] を逆適用で取り、`[' 0]` が引いた物を inc が受けた。
	["[1 2 3] !_ [' 0] inc（R47。前は `inc ([1 2 3] ' 0)`）", std("[1 2 3] !_ [' 0] inc"), "(construct [1 2 3] (unit (compose !_ [' 0] inc)))", "A"],
	["!_ , i（両方とも恒等射なら `!_` を残す）", std(["i : !_", "!_ , i"]), "(unit !_)", "A"],
];
const idFixRefused = [
	// 括りの関数の頭の口を値で埋めた後ろの `!_`（§5 Q40、素の関数の頭の `inc 5 !_` と同じ問い）
	["pq 1 2 !_（§5 Q40）", std([PQ, "pq 1 2 !_"]), "G5"],
	["pq 1 2 !_ 5（§5 Q40）", std([PQ, "pq 1 2 !_ 5"]), "G5"],
	// 括りの関数の口に入る `!_` は、畳み込みの1歩で G5
	["5 io1 !_（`!_` は io1 の口）", std([IO1, "5 io1 !_"]), "G5"],
	["inc io1 5 !_（inc が閉じて、`!_` は io1 の口）", std([IO1, "inc io1 5 !_"]), "G5"],
	["pq 1 !_（pq の口）", std([PQ, "pq 1 !_"]), "G5"],
	// `!_` が入るのが前の関数の口なら、その口で見る（R46）
	["add io1 !_（add の口が2つ残る。前は G5）", std([IO1, "add io1 !_"]), "G7"],
	["!_ io1 !_（恒等射の口は可変長。前は G5）", std([IO1, "!_ io1 !_"]), "G7"],
	// 恒等射が受けた後に合成した関数（2026-10-23 は、主語の口が1つに決まらない関数だけを断っていた。単位律では `5 f2`、§5 Q5）。
	// R47 で、恒等射が 5 を受けるのは並びの頭の `!_ 5 f2` の形だけで、そこは後ろの関数が何でも G18（単位律では f2 は 5 を取らない）。
	["tq : !_ 5 f2 ⏎ tq 3（同じ）", std(["tq : !_ 5 f2", "tq 3"]), "G18"],
	["(inc !_ 5 f2) 3（R46 で通した恒等射でも。単位律・穴の読みでは `(inc 5 f2) 3` の G8）", std("(inc !_ 5 f2) 3"), "G18"],
	["i 5 inc（R47 で G18。単位律では `5 inc` で inc は 5 を取らない。前は `inc 5` で通る）", std(["i : !_", "i 5 inc"]), "G18"],
	["!_ 5 f2（R47 で G18。前は行の終わりで `_`）", std("!_ 5 f2"), "G18"],
	["i 1 [* 2,] 2（R47 で G18。単位律では `1 ([* 2,] 2)`。前は通る）", std(["i : !_", "i 1 [* 2,] 2"]), "G18"],
	["inc !_ 5 inc（R47 で G18。流れの読みは `inc (inc 5)`、単位律の `inc 5 inc` は inc が余る）", std("inc !_ 5 inc"), "G18"],
	// 恒等射が受けた物を口の数の分からない関数が受け、その後に関数が合成された形（R47 の確かめで足した。HEAD では通っていた）。単位律の
	// 読みでは、その関数が受けた後に関数が来て G2(a)（`[,] 5 inc`・`f2 vs~ inc`）。
	["i [,] 5 inc（R47 の確かめで足した。単位律では `[,] 5 inc` の G2(a)）", std(["i : !_", "i [,] 5 inc"]), "G18"],
	// 2026-10-24 の試し（R51）から、f2 は恒等射が渡した撒いた流れを畳み込みで受けて閉じ、単位律の `f2 vs~ inc` では inc が畳み込みの値の
	// 後ろに積まれて値を取らない（流れの読みでは受ける）ので、「受けた後に合成された関数」の G18。前は、撒く項を受けた f2 は口の数が
	// 数えられず、単位律では `f2 vs~ inc` の G2(a) で、口の数の分からない関数の G18 だった（答えは同じ G18）。
	["i f2 vs~ inc（R51 の試しから、畳み込みの値の後ろの inc。前は撒く項を受けた f2 の口の数が数えられない形）", std(["i : !_", "i f2 vs~ inc"]), "G18"],
	// 2026-10-23 は G18 だった `(5 !_ f2) 3` の形（`(5 !_ f2) 3`・`(5 i f2) 3`・`(5 !_ inc f2) 3`・`(5 !_ add f2) 3`・`(5 c9) 3`・`3 (5 !_ f2)`）は、
	// R47 で恒等射が 5 を受けず（合成 `!_ f2` が 5 の後ろに積まれる）、括りの中が値と関数の並んだ構築（未知、§5 Q38）で G7 だった。2026-10-24 の
	// R52 から、何も受けない合成は括りの中でも余って消えるので通り、いちばん後ろの「評価する所の外で余ったラムダ」の節（r52Passes）へ移した。
	// 単位律の `(5 f2) 3` も同じく通り、割れない。
	// 恒等射が受けた後に合成した貪欲な単項・ノルム（2026-10-23 は、単位律では一番近い1項だけを逆適用で取るので割れた。R47 では、単位律の
	// 読みの後ろの関数は値を取らずに積まれるので、やはり割れる）
	["!_ 1 2 [* 2,]（単位律では `1 2 [* 2,]` で `[* 2,]` が余る。前は通っていた）", std("!_ 1 2 [* 2,]"), "G18"],
	["i 1 2 [* 2,]（同じ。前は通っていた）", std(["i : !_", "i 1 2 [* 2,]"]), "G18"],
	["5 !_ 6 [* 2,]（同じ）", std("5 !_ 6 [* 2,]"), "G18"],
	["!_ 1 2 ||!_||（ノルムも）", std("!_ 1 2 ||!_||"), "G18"],
	["add 1 !_ 5 6 [* 2,]（R46 で通した恒等射でも）", std("add 1 !_ 5 6 [* 2,]"), "G18"],
	["inc !_ 5 6 ||!_||（同じ）", std("inc !_ 5 6 ||!_||"), "G18"],
	// 2026-10-23 に、単位律では逆適用が断られる所として断っていた形。R47 では、恒等射が受けた後に合成した関数は全部 G18 なので、`!_ vs~ inc`・
	// `i vs~ [* 2,] 5` は今までどおり G18（理由は「受けた後に合成」に移った）。恒等射が何も受けていない `5 !_ uu inc`・`5 !_ [' 0] inc` は、
	// 合成が 5 の後ろに積まれて余るだけで割れず（単位律の `5 uu inc`・`5 [' 0] inc` も同じく余る）、通る側（norevPasses）へ移した。
	["!_ vs~ inc（恒等射が撒く項を受けた後に inc を合成）", std("!_ vs~ inc"), "G18"],
	["i vs~ [* 2,] 5（同じ）", std(["i : !_", "i vs~ [* 2,] 5"]), "G18"],
	// 両方とも恒等射の `,` は、並べた順に依らない
	["!_ , i == 1（`!_` を残して G7。前は通っていた）", std(["i : !_", "!_ , i == 1"]), "G7"],
	["i , !_ == 1（同じ G7）", std(["i : !_", "i , !_ == 1"]), "G7"],
	// R45 が G3 の前に名前を解くので、値の定義を含む輪は name-cycle（§5 Q30。前は G3 が先で輪に届かなかった）
	["aa : inc 1 , bb ⏎ bb : aa（輪）", std(["aa : inc 1 , bb", "bb : aa"]), "name-cycle"],
	["bb : aa ⏎ aa : inc 1 , bb（行の順に依らない）", std(["bb : aa", "aa : inc 1 , bb"]), "name-cycle"],
];
for (const [name, s, want, kind, extra] of idFixPasses) checkPass(`恒等射の直し ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of idFixRefused) checkRefused(`恒等射の直し ${name}`, s, want, inst);

// ---------------------------------------------------------------------------
// 逆適用の廃止（2026-10-24、R47・R48、§7.21）
// ---------------------------------------------------------------------------
//
// 経緯：逆適用の狙いは UFCS だった（U 08-05 07:25「apply reverse はUFCSのように書けたらと思った狙い」、§5 Q5）。U [2026-10-23 12:23 ebf18260]
// 「…構造体もリストも参照渡しで、仮引数で括りを作った中で渡し方を指定するようになった。 という事を考えると、実は逆適用の必要性がなくなった
// のではないか？…」。主の Claude が残る形・断る形の表を出して「`5 f2` のように、口が2つ以上の関数への逆適用は、根で `_` になる形も含めて
// 断る、でいい？」と訊き、U [2026-10-23 13:12 ebf18260]「いやこれ、むしろ2引数を断るなら逆適用の意味が余計に薄い上に構文が乱れる元だから、
// 廃止だね。 逆適用は廃止しよう」。続く主の Claude の問い「A の後の L は積む（関数は右からだけ受ける）。根でラムダが余って `_` になったら
// 診断で知らせる。これでいい？」に、U〔答え〕[2026-10-23 15:32 ebf18260]「合ってる。 それでOK！」。
// - R47：畳み込みの1歩は3行。L·A は適用、L·L は合成、いちばん上が A か空なら次の項を積む（L も積み、積まれた L は後ろの項を右から受ける）。
// - R48：評価する所で余ったラムダは今までどおり `_`（R42、並びの中では消える、R15）で、leftover-lambda で知らせる（重さは 2026-10-24 の
//   §5 Q44 の答えで information から warning に上げた）。余ったのが恒等射（`!_`・`i : !_` の i・恒等射どうしの合成）なら知らせない。括りの中・
//   `:` の右辺・本体は評価する所でないので知らせない（同じ日の R52 と §5 Q50 の答えから、値の上に積まれて閉じた関数はそこでも知らせる）。
// 上の節の行のうち、門が無くなって通る側へ移った行と、主の Claude が示した表の行をここに置く。法則は coproduct_laws.test.js の法則5
// （値の後ろの関数は、値を取らない）。
const UU_DEF = "uu : x ? [,] x";
const norevPasses = [
	// 主の Claude が示した、答えが変わる形の表（U〔答え〕10-23 15:32 の前）。行の名前の「前は」は 2026-10-23 の答え。
	["表 5 inc 3（`5 (inc 3)`。前は `(inc 5) 3`）", std("5 inc 3"), "(construct 5 (apply inc 3))", "A", { leftoverDiag: [] }],
	["表 1 2 inc（`1 2`、inc は余って `_`。前は `1 (inc 2)`）", std("1 2 inc"), "(construct 1 2 (unit inc))", "A", { leftoverDiag: ["inc"] }],
	["表 1 2 [+] 3 4（`1 2 ([+] 3 4)`。前は `1 ([+] 2 3 4)`）", std("1 2 [+] 3 4"), "(construct 1 2 (apply [+] (construct 3 4)))", "A", { leftoverDiag: [] }],
	["表 inc 1 2 inc（`(inc 1) 2`。前は `(inc 1) (inc 2)`）", std("inc 1 2 inc"), "(construct (apply inc 1) 2 (unit inc))", "A", { leftoverDiag: ["inc"] }],
	["表 5 f2 1（`5 (f2 1)`、足りないので根で `_`。前は G8）", std("5 f2 1"), "(construct 5 (unit (apply f2 1)))", "A", { leftoverDiag: ["(apply f2 1)"] }],
	["表 vs (map $inc)（`vs`、map の部分適用が余る）", std("vs (map $inc)"), "(construct vs (unit [map $inc]))", "A", { leftoverDiag: ["[map $inc]"] }],
	["表 5 !_（5 のまま。余った恒等射は知らせない。前は逆適用）", std("5 !_"), "(construct 5 (unit !_))", "A", { leftoverDiag: [] }],
	["表 5 !_ 3（`5 3` のまま。前は逆適用）", std("5 !_ 3"), "(construct 5 (apply !_ 3))", "A", { leftoverDiag: [] }],
	// 門が無くなって通る側へ移った行（元の節と、前の門）。G8（主語の口が決まらない逆適用の後に実引数か `_` が来る）・G9（撒く項の後ろの関数、
	// R14）は廃止した。ほかの門から移った行は、その門の前提だった逆適用が無くなった物。
	["G9 xs~ inc（§6.3 の表。前は G9）", std("xs~ inc"), "(construct xs~ (unit inc))", "A", { leftoverDiag: ["inc"] }],
	["G9 1 vs~ inc（余りと流れ。前は G9）", std("1 vs~ inc"), "(construct 1 vs~ (unit inc))", "A"],
	["G9 vs~ !_（恒等射。前は `vs~ i` と同じ G9）", std("vs~ !_"), "(construct vs~ (unit !_))", "A", { leftoverDiag: [] }],
	["G8 1 [,] 2 3 4（確かめ・値の後ろの点なし。前は G8、その前は G2(a)）", std("1 [,] 2 3 4"), "(construct 1 (apply [,] (construct 2 3 4)))", "未知"],
	["G8 5 use 5 inc（穴・余りと流れ。前は G2(b)、その後 G8）", std("5 use 5 inc"), "(construct 5 (unit (compose (apply use 5) inc)))", "A"],
	["G8 5 add 3 _（畳み込み。前は `5 (add 3 _)`、その後 G8）", std("5 add 3 _"), "(construct 5 (apply add (construct 3 _)))", "A"],
	["G8 1 [<<] 2 3 4（畳み込み。前は `1 ([<<] 2 3) 4`、その後 G8）", std("1 [<<] 2 3 4"), "(construct 1 (apply [<<] (construct 2 3)) 4)", "A", { pfInfo: "[<<]" }],
	["G8 1 [<<] 2 3 4 inc（畳まない・値の後ろの点なし。前は G12(a)、その後 G8）", std("1 [<<] 2 3 4 inc"), "(construct 1 (apply [<<] (construct 2 3)) 4 (unit inc))", "A"],
	["G8 5 t3 1 2（答え。部分適用の節が逆適用の右だった）", src(["t3 : u v [~r] ? u", "5 t3 1 2"]), "(construct 5 (unit (apply t3 (construct 1 2))))", "A"],
	["G8 inc 3 4 f2 5 6 inc 6（余りと流れ。問いの例の答え `(inc 3) 4 (f2 5 6) (inc 6)` に戻った。前は G12(a)、その後 G8）", std("inc 3 4 f2 5 6 inc 6"), "(construct (apply inc 3) 4 (apply f2 (construct 5 6)) (apply inc 6))", "A"],
	["G8 5 gf inc _（余りと流れ。`_` は gf の既定値のある口、R39。前は G2(a)、その後 G8）", std([GF, "5 gf inc _"]), "(construct 5 (apply (compose gf inc) _))", "未知"],
	["G8 inc 1 2 f2 3（確かめ。前は G12(a)、その後 G8）", std("inc 1 2 f2 3"), "(construct (apply inc 1) 2 (unit (apply f2 3)))", "A"],
	["G2(a) 1 uu inc 5（確かめ。uu が 1 を逆適用で取って未知になっていた）", std([UU_DEF, "1 uu inc 5"]), "(construct 1 (apply (compose uu inc) 5))", "未知"],
	["G2(a) vs [' 0] inc 4（値の後ろの点なし。`[' 0]` が vs を逆適用で取っていた）", std("vs [' 0] inc 4"), "(construct vs (apply (compose [' 0] inc) 4))", "未知"],
	// `5 uu !_` は、R47 の最初の版では合成 `uu !_`（R46）が余る `(construct 5 (unit (compose uu !_)))` だった。同じ日の確かめで、積まれた uu の
	// 後ろの並びにも穴の規則を当てるよう直し、`uu !_` は穴の関数（R16。`5 (uu !_)` と同じ。η で同じ関数）。
	["G2(a) 5 uu !_（穴の関数が余る。前は uu が 5 を逆適用で取って未知になっていた）", std([UU_DEF, "5 uu !_"]), "(construct 5 (unit (? [$p0] (apply uu $p0))))", "A"],
	["G2(a) 5 uu bad（確かめ。前は G5、その後 G2(a)。bad は呼ばれない）", src([UU, BAD, "5 uu bad"]), "(construct 5 (unit (compose uu bad)))", "A"],
	["G18 5 !_ uu inc（恒等射の直し。恒等射は何も受けず、単位律の `5 uu inc` と同じく余る）", std([UU_DEF, "5 !_ uu inc"]), "(construct 5 (unit (compose !_ uu inc)))", "A"],
	["G18 5 !_ [' 0] inc（恒等射の直し。同じ）", std("5 !_ [' 0] inc"), "(construct 5 (unit (compose !_ [' 0] inc)))", "A"],
	// R48 の診断：出る形（評価する所の終わりに、恒等射でないラムダが余る）。
	["R48 5 inc", std("5 inc"), "(construct 5 (unit inc))", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["R48 5 (inc)（括った関数も）", std("5 (inc)"), "(construct 5 (unit [inc]))", "A", { leftoverDiag: ["[inc]"] }],
	["R48 5 !_ inc（恒等射に合成した関数は恒等射でない）", std("5 !_ inc"), "(construct 5 (unit (compose !_ inc)))", "A", { leftoverDiag: ["(compose !_ inc)"] }],
	["R48 inc add 5（流れの足りない合成。R42 の前からの形）", std("inc add 5"), "(unit (apply (compose inc add) 5))", "A", { leftoverDiag: ["(apply (compose inc add) 5)"] }],
	["R48 add _ 10（根に余った穴の関数）", std("add _ 10"), "(unit (? [$p0] (apply add (construct $p0 10))))", "A", { leftoverDiag: ["(? [$p0] (apply add (construct $p0 10)))"] }],
	["R48 inc add 5 , !_（根の `,` が恒等射で消えた行も評価する所、R45）", std("inc add 5 , !_"), "(unit (apply (compose inc add) 5))", "A", { leftoverDiag: ["(apply (compose inc add) 5)"] }],
	["R48 inc 1 _（足りた適用は余らない）", std("inc 1 _"), "(apply inc 1)", "A", { diagCount: 0 }],
	// 出ない形：余ったのが恒等射（落としても当てても値が同じ）。
	["R48 !_（根に1つの恒等射。U 10-22 23:41「…!_ だけを評価したら _ に戻るのは都合がいいね」）", std("!_"), "(unit !_)", "A", { diagCount: 0, leftoverDiag: [] }],
	["R48 i : !_ ⏎ 5 i（名前の恒等射）", std(["i : !_", "5 i"]), "(construct 5 (unit i))", "A", { diagCount: 0, leftoverDiag: [] }],
	["R48 i : !_ ⏎ 5 i i（恒等射どうしの合成も恒等射）", std(["i : !_", "5 i i"]), "(construct 5 (unit (compose i i)))", "A", { diagCount: 0, leftoverDiag: [] }],
	["R48 !_ , !_（`,` の単位で消えて残った恒等射）", std("!_ , !_"), "(unit !_)", "A", { diagCount: 0, leftoverDiag: [] }],
	// R48 の片では出ない形だった：`:` の右辺は式を指すだけ（R52 の外）で、v は未知。2026-10-24 の §5 Q50 の答えから、右辺は閉じた1つの項で
	// R52 を当てるので、定義の行で知らせ、v は 5（closedRhsPasses）。
	["R48 v : 5 inc（Q50 の答えから定義の行で知らせる。前は `(construct 5 inc)` で知らせなかった）", std("v : 5 inc"), "(: v (construct 5 (unit inc)))", null, { diagCount: 1, leftoverDiag: ["inc"] }],
	["R48 v : 5 inc ⏎ v（v は 5 で、根でも余らない。知らせるのは定義の行の1回。前は v が未知）", std(["v : 5 inc", "v"]), "v", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	// 2026-10-24 の R52 から出る形：評価する所の外（括りの中・本体）でも、値の上に積まれて何も受けずに閉じた関数は余ったラムダで `_` になり、
	// 知らせる。R47 の最初の版（R48）は、評価する所でないので知らせず、値と関数の並んだ構築は種類を決めなかった（未知、§5 Q38）。
	["R52 (5 inc)（括りの中。R48 では未知で知らせなかった）", std("(5 inc)"), "[5 inc]", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["R52 t : y ? y inc（本体。R48 では未知で知らせなかった）", std("t : y ? y inc"), "(construct y (unit inc))", "A", { body: true, diagCount: 1, leftoverDiag: ["inc"] }],
];
const norevRefused = [
	// R47 から断る側へ移った行は、元の節に置いた（`[' 0] [1 2 3] inc` の G2(a)・`i 5 inc` の G18 など）。ここには、逆適用が無くなっても
	// 残る門の見本を置く。
	["G18 は残る：!_ 5 inc（流れでは `inc 5`、単位律では `5 inc` で inc が余る）", std("!_ 5 inc"), "G18"],
	["G18 は残る：i inc 1 2（流れでは `inc [1 2]`、単位律では `(inc 1) 2`）", std(["i : !_", "i inc 1 2"]), "G18"],
	["G2(a) は残る：5 uu 5 inc（種類の未知な `uu 5` の後ろに関数）", std([UU_DEF, "5 uu 5 inc"]), "G2(a)"],
	["G7 は残る：5 [<<] !_ 2（積まれた点なしの口が2つ残る、R46。素の関数の `5 f2 !_` は穴の規則が読む、norevFixPasses）", std("5 [<<] !_ 2"), "G7"],
	["G15 は残る：5 go _ 3（積まれた go の最初の口は既定値が無い）", std([...GO_DEFAULT, "5 go _ 3"]), "G15"],
];
for (const [name, s, want, kind, extra] of norevPasses) checkPass(`逆適用の廃止 ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of norevRefused) checkRefused(`逆適用の廃止 ${name}`, s, want, inst);

// ---- 逆適用の廃止の確かめ（2026-10-24、R47 の片の確かめの指摘を当てた行） ----
//
// (1) 値の後ろに積まれた関数の並び（§3.3 の手順2・4、R47）：積まれた関数 F は後ろの並び Y を右から受け、前の値は取らないので、`X F Y` の
//     F Y は括った `(F Y)` と同じ1つの並び（法則5）。穴の規則（R16・R34・R38）と、その断り（G13、括りの関数の頭の G5）も、F を頭にした並びで
//     見る。R47 の最初の版は並び全体の頭だけを見ていて、`5 inc _ 7` が G5・`5 (inc _ 7)` が `5 (inc 7)`、`5 add 1 2 !_` が通り・
//     `5 (add 1 2 !_)` が G13 と割れていた（反証の指摘。断りすぎの側と、§5 Q40 の片方を黙って選ぶ側の両方）。
// (2) 恒等射で消えた `,` の後の並びにも、外の `,` の G3 が当たる（R45 の単位律で `2 , !_ , inc 1` は `2 , inc 1`）。HEAD fc638712 から前からの
//     穴で、R47 の値と関数の並び（`1 , !_ , 5 inc`）もこの抜け道に乗っていた（確かめの指摘）。
// (3) 括りの関数の末尾の `_` で、`_` を除いた実引数が足りない形は、値の後ろでも G5（`io1 _` と同じ）。2026-10-23 は逆適用で通っていた
//     （`5 io1 _` は `(apply io1 5 ·rev)`）。仕様の記録は「前は G8」と書いていて、通る→断るの変化が読めなかった（確かめの指摘）。
// (4) 黒い芽のうち、評価する所の外で、診断も門も無いまま未知の根で通っていた所（§5 Q35・Q38・Q44 に名指しした）。2026-10-24 の R52 から、
//     値の上に積まれて何も受けずに閉じた関数は、どこでも（`:` の右辺を除く）余ったラムダで `_` になり、知らせる（後ろの R52 の節）。同じ日の
//     §5 Q50 の答えから、`:` の右辺も除かない（除くのは `$[…]` の中身の並びだけ、いちばん後ろの節）。
const IO1_FIX = "io1 : [say] ? say 21";
const norevFixPasses = [
	// (1) 穴の規則が F の並びで読む（`5 (F Y)` と同じ）
	["5 inc _ 7（`inc _ 7` は R38 で `inc 7`。R47 の最初の版は G5、2026-10-23 は `(inc 5) 7`）", std("5 inc _ 7"), "(construct 5 (apply inc 7))", "A", { leftoverDiag: [] }],
	["5 f2 _ 3（`f2 _ 3` は R16 のカリー化で、余って `_`。R47 の最初の版は G5、2026-10-23 は G8）", std("5 f2 _ 3"), "(construct 5 (unit (? [$p0] (apply f2 (construct $p0 3)))))", "A", { leftoverDiag: ["(? [$p0] (apply f2 (construct $p0 3)))"] }],
	["5 f2 !_（`f2 !_` は R34 の k < n。R47 の最初の版は G7）", std("5 f2 !_"), "(construct 5 (unit (? [$p0 [~$p1]] (apply f2 (construct $p0 $p1~)))))", "A", { leftoverDiag: ["(? [$p0 [~$p1]] (apply f2 (construct $p0 $p1~)))"] }],
	["5 add !_ 3 4（`add !_ 3 4` は R34 の k > n で `add 4 3`。R47 の最初の版は G7）", std("5 add !_ 3 4"), "(construct 5 (apply add (construct 4 3)))", "A"],
	["5 add 3 _ 4（`add 3 _ 4` は R38 で `add 3 4`。R47 の最初の版は G5）", std("5 add 3 _ 4"), "(construct 5 (apply add (construct 3 4)))", "A"],
	["5 inc !_ 3（`inc !_ 3` は R34 で `inc 3`。R47 の最初の版は合成 `(apply (compose inc !_) 3)`、値は同じ）", std("5 inc !_ 3"), "(construct 5 (apply inc 3))", "A"],
	["5 inc !_（`inc !_` は R16 の穴。R47 の最初の版は合成 `inc !_`（R46）で、η で同じ関数）", std("5 inc !_"), "(construct 5 (unit (? [$p0] (apply inc $p0))))", "A", { leftoverDiag: ["(? [$p0] (apply inc $p0))"] }],
	["5 inc 3 add _ 10（閉じた `inc 3` の後ろに積まれた add も同じ）", std("5 inc 3 add _ 10"), "(construct 5 (apply inc 3) (unit (? [$p0] (apply add (construct $p0 10)))))", "A"],
	["_ add _ 10（頭の `_` は消え（R43）、`add _ 10` と同じ。前は G5）", std("_ add _ 10"), "(unit (? [$p0] (apply add (construct $p0 10))))", "A"],
	// 後ろに関数があれば穴の規則は読まない（穴でない項が全部 A ではない）ので、畳み込みの1歩のまま（`inc 5 !_ inc` と同じ）。
	["5 inc 5 !_ inc（今までどおり口の外の恒等射、R44）", std("5 inc 5 !_ inc"), "(construct 5 (apply inc 5) (unit (compose !_ inc)))", "A"],
	["5 inc _（末尾の `_` は今までどおり R28）", std("5 inc _"), "(construct 5 (apply inc _))", "A"],
	// (2) 恒等射どうしなら、残るのはもう片方の並び（`!_ , inc 1` と同じ）
	["!_ , !_ , inc 1（今までどおり）", std("!_ , !_ , inc 1"), "(apply inc 1)", "A"],
	// (4) 黒い芽。R47 の片では、段4〜8 の辺は評価する所でないので値と関数の並びが未知で、R48 は知らせなかった（未知の根で通る、診断なし。
	// §5 Q38・Q44）。2026-10-24 の R52 から、辺でも、値の上に積まれて何も受けずに閉じた関数は余ったラムダで `_` になり、知らせる。
	// 主の Claude が 06:01（UTC）の返事で「`5 inc == 6` は、`inc 5 == 6` のつもりで書いても黙って通る（Q38・Q44）」と書き（03:03 の逆適用の
	// 廃止の報告にも同じ趣旨の行）、利用者がその文を引いて U [2026-10-24 06:29 ebf18260]「困ったね…逆適用はすべて廃止だと言ってるのに～」（§7.24）。
	["5 inc == 5（R52 で `5 == 5`、知らせる。R47 では未知の根で診断なし、2026-10-23 は `(inc 5) == 5` で A）", std("5 inc == 5"), "(== (construct 5 (unit inc)) 5)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["inc 1 == 2 inc（R52 で `inc 1 == 2`、知らせる。R47 では未知の根で診断なし）", std("inc 1 == 2 inc"), "(== (apply inc 1) (construct 2 (unit inc)))", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	// (4) 本体の根が値と関数の並び。R47 の片では未知（G16 は根が L の本体だけ、§5 Q35）で、診断なし。2026-10-23 は `y add` が逆適用で口の
	// 決まらない L になり G16、`y inc` は `inc y` で A だった。R52 から、本体の根の add・inc は余って消え、根は A（知らせるのは定義の行の本体）。
	["t2 : y ? y add ⏎ t2 5（R52 で A、知らせる。R47 では未知の根で診断なし、2026-10-23 は G16）", std(["t2 : y ? y add", "t2 5"]), "(apply t2 5)", "A", { diagCount: 1, leftoverDiag: ["add"] }],
	["t : y ? y inc ⏎ t 3（R52 で A、知らせる。R47 では未知の根で診断なし、2026-10-23 は A）", std(["t : y ? y inc", "t 3"]), "(apply t 3)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
];
const norevFixRefused = [
	// (1) 穴の断りも F の並びで見る（`5 (F Y)` と同じ。§5 Q40・Q31 の問いのまま断る側）
	["5 add 1 2 !_（`add 1 2 !_` は G13、§5 Q40。R47 の最初の版は口の外の恒等射で通り、2026-10-23 は G8）", std("5 add 1 2 !_"), "G13"],
	["5 inc 7 !_（`inc 7 !_` は G13、§5 Q40。R47 の最初の版は通っていた）", std("5 inc 7 !_"), "G13"],
	["5 inc 7 _ 3（`inc 7 _ 3` は R38 の G13。R47 の最初の版は `_` が値の隣で消えて通っていた）", std("5 inc 7 _ 3"), "G13"],
	["inc 3 add 1 2 !_（閉じた `inc 3` の後ろの add も同じ。R47 の最初の版は通っていた）", std("inc 3 add 1 2 !_"), "G13"],
	["5 inc !_ vs~（`inc !_ vs~` は撒く項で k が数えられない G13。R47 の最初の版は通っていた）", std("5 inc !_ vs~"), "G13"],
	["pq : [a] y ? y ⏎ 5 pq 1 2 !_（`pq 1 2 !_` は G5、§5 Q40。R47 の最初の版は通っていた）", std(["pq : [a] y ? y", "5 pq 1 2 !_"]), "G5"],
	// (2) 恒等射で消えた `,` の後の並びの G3
	["2 , !_ , inc 1（`2 , inc 1` と同じ G3。前は `(, 2 (apply inc 1))` で通っていた）", std("2 , !_ , inc 1"), "G3"],
	["2 , inc 1 , !_（同じ。前は通っていた）", std("2 , inc 1 , !_"), "G3"],
	["1 , !_ , 5 inc（`1 , 5 inc` と同じ G3。前は通っていた）", std("1 , !_ , 5 inc"), "G3"],
	["i : !_ ⏎ 2 , i , inc 1（名前の恒等射も同じ。前は通っていた）", std(["i : !_", "2 , i , inc 1"]), "G3"],
	// (3) 括りの関数の末尾の `_` で足りない形は、値の後ろでも G5。2026-10-23 は逆適用で通っていた（G8 ではない）。
	["5 io1 _（`io1 _` と同じ G5。2026-10-23 は `(apply io1 5 ·rev)` で通っていた）", std([IO1_FIX, "5 io1 _"]), "G5"],
	["5 n _（`n _` と同じ G5。2026-10-23 は `(apply n 5 ·rev)` で通っていた）", std("5 n _"), "G5"],
];
for (const [name, s, want, kind, extra] of norevFixPasses) checkPass(`逆適用の廃止の確かめ ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of norevFixRefused) checkRefused(`逆適用の廃止の確かめ ${name}`, s, want, inst);
// (2) の直しの守り：中の `,` が恒等射で消えたかを見るとき、`,` の辺を丸ごと解くと、名前の `,` の鎖で1段ごとに残りの鎖を解き直して
// 倍々になる（直しの最初の版は、名前 32 個の鎖で 5 秒、40 個で 4 分）。辺は両辺が恒等射のときだけ恒等射なので、辺ごとに見る。
// 1本 5 秒の上限で見る（今は数十 ms）。答えも見る：名前の鎖はそのままの `,`、恒等射の鎖の後ろの `inc 1` は G3、恒等射だけの鎖は消える。
law("恒等射で消えた , の後の G3 の確かめは、名前の , の鎖でも速い", () => {
	const out = [];
	const names = Array.from({ length: 40 }, (_, k) => `a${k}`);
	const defs = names.map((x, k) => `${x} : ${k}`);
	let t0 = Date.now();
	const r = resolve(src([...defs, `r : ${names.join(" , ")}`]));
	const ms1 = Date.now() - t0;
	if (ms1 > 5000) out.push(`名前 40 個の鎖：${ms1}ms`);
	const rLine = show(r.trees[r.trees.length - 1]);
	if (!rLine.startsWith("(: r (, a0 (, a1 ") || !rLine.includes("(, a38 a39)")) out.push(`鎖の行 got: ${rLine.slice(0, 120)}`);
	const ids = Array(40).fill("i").join(" , ");
	t0 = Date.now();
	let got = "通った";
	try {
		resolve(src(["i : !_", "inc : x ? x + 1", `2 , ${ids} , inc 1`]));
	} catch (e) {
		got = `${e.reason} ${e.gate || ""}`;
	}
	const ms2 = Date.now() - t0;
	if (ms2 > 5000) out.push(`恒等射 40 個の鎖の後ろの並び：${ms2}ms`);
	if (got !== "coproduct-beside-product G3") out.push(`恒等射の鎖の後ろの inc 1 got: ${got}  want: G3`);
	const only = show(resolve(src(["i : !_", `${ids} , 5`])).trees.at(-1));
	if (only !== "5") out.push(`恒等射だけの鎖の後ろの 5 got: ${only}  want: 5`);
	return out;
});

// ---------------------------------------------------------------------------
// 試し（2026-10-24、R49〜R51）：番地は指す関数を運ぶ・`[F,]` の写像・撒いた並びは流れの1項
// ---------------------------------------------------------------------------
//
// 利用者「試しにやってみよう！ ちょっと別のセッションとも議論してくるけど、おそらくやれることは何でもやってみて、悪ければロールバックしよう。」
// （U〔答え〕[2026-10-24 04:30 ebf18260]）。戻すときは、この節と、上の節で「試し」と書いた行の注の「前は」の答えに戻す（仕様 §7.23）。
// - R49：`$名前`（名前が関数）・`$[…]`（括りが関数）は、指す関数を印に持つ番地（A）。`@x` の x に印があれば、`@x` はその関数（L、口の数が
//   分かる）。括りの関数の実体で裸の仮引数に渡れば、印を持ち越し、実体の鍵に入る（形は `$L`）。素の関数の仮引数には届かない（§5 Q45）。
// - R50：`[F,]` の F が口の1つ残った関数の項なら、F の写像（`[* 2,]` と同じ貪欲な単項）。口が2つ以上か分からなければ今のまま未知（G7）。
// - R51：いちばん上が L で次が撒く項なら、撒いた並びは流れの1項で、いちばん最初の閉じていない段の残りの口の数で受ける：1つなら写像、2つなら
//   左からの畳み込み、最後の口が可変長なら丸ごと、ほか（3つ以上・分からない・固定の口の後ろに可変長の口）は G19。段の結果は次の段へ流れる（R11）。
//   書き並べた実引数は今までどおり（R35 で余りを積む）：`add vs~` は畳み込み、`add 1 2 3` は `(add 1 2) 3`。
const MAPS = ["vs : 1 , 2 , 3", "uu : x ? [,] x", "map : f [~t] ? [@f,] t~", "map2 : f [~t] ? @f t~", "fold : f [~h] ? @f h~"];
const trial = (lines) => src([INC, DOUBLE, "add : x y ? x + y", "f3 : a b c ? a + b + c", ...MAPS, ...[].concat(lines)]);
const trialPasses = [
	// 仕様 §4 R51 の例の `map`・`map2`・`fold`（値は [2 3 4]・6。種類は A）
	["map $inc vs（R49・R50・R51）", trial("map $inc vs"), "(apply map (construct $inc vs))", "A"],
	["map $inc vs の map の実体（f は `$L`、本体は `[@f,]` の写像）", trial("map $inc vs"), "(: map (? [f [~t]] (inst $L [N…] (apply [@f,] t~))))", null, { at: 6 }],
	["map2 $inc vs（`@f t~` は口が1つの写像）", trial("map2 $inc vs"), "(apply map2 (construct $inc vs))", "A"],
	["fold $add vs（`@f h~` は口が2つの畳み込み）", trial("fold $add vs"), "(apply fold (construct $add vs))", "A"],
	["fold $add vs の fold の実体", trial("fold $add vs"), "(: fold (? [f [~h]] (inst $L [N…] (apply @f h~))))", null, { at: 8 }],
	["inc (fold $add vs)（G7 にならずに A）", trial("inc (fold $add vs)"), "(apply inc [fold $add vs])", "A"],
	// 撒いた流れと書き並べは別の物
	["inc vs~（写像）", trial("inc vs~"), "(apply inc vs~)", "A"],
	["add vs~（畳み込み）", trial("add vs~"), "(apply add vs~)", "A"],
	["add 1 2 3（書き並べは今までどおり R35。`(add 1 2) 3`）", trial("add 1 2 3"), "(construct (apply add (construct 1 2)) 3)", "A", { leftover: true }],
	["add 1 vs~（口が1つ残った add 1 の写像）", trial("add 1 vs~"), "(apply add (construct 1 vs~))", "A"],
	["(add 1) vs~（同じ）", trial("(add 1) vs~"), "(apply [add 1] vs~)", "A"],
	["f3 1 vs~（口が2つ残った f3 1 の畳み込み）", trial("f3 1 vs~"), "(apply f3 (construct 1 vs~))", "A"],
	["[inc,] vs（R50。1つで入った器の要素を写す）", trial("[inc,] vs"), "(apply [inc,] vs)", "A"],
	["[inc,] 1 2 3（R50）", trial("[inc,] 1 2 3"), "(apply [inc,] (construct 1 2 3))", "A"],
	["[inc,] vs~（貪欲な単項は流れを丸ごと受ける）", trial("[inc,] vs~"), "(apply [inc,] vs~)", "A"],
	["[(add 1),] vs（部分適用の写像）", trial("[(add 1),] vs"), "(apply [[add 1],] vs)", "A"],
	["[add 1,] vs（括らない部分適用も同じ）", trial("[add 1,] vs"), "(apply [add 1,] vs)", "A"],
	["[x ? x + 1,] vs（括りの関数の写像）", trial("[[x ? x + 1],] vs"), "(apply [[x ? x + 1],] vs)", "A"],
	["add []~（空の流れの畳み込みは `_`、A）", trial("add []~"), "(apply add []~)", "A"],
	["inc []~（空の流れの写像は空の List、A）", trial("inc []~"), "(apply inc []~)", "A"],
	["inc vs~ 5（写像の値の後ろに積む）", trial("inc vs~ 5"), "(construct (apply inc vs~) 5)", "A"],
	["5 inc vs~（値の後ろに積まれた inc も同じ、R47）", trial("5 inc vs~"), "(construct 5 (apply inc vs~))", "A"],
	["vs~ inc（いちばん上が値なら今までどおり積む）", trial("vs~ inc"), "(construct vs~ (unit inc))", "A", { leftoverDiag: ["inc"] }],
	// 合成：流れはいちばん最初の閉じていない段に入り（R40）、結果は次の段へ値として流れる（R11。`double (inc vs~)`）
	["inc double vs~（`double (inc vs~)`）", trial("inc double vs~"), "(apply (compose inc double) vs~)", "A"],
	["inc add vs~ 5（`add (inc vs~) 5`）", trial("inc add vs~ 5"), "(apply add (construct (apply inc vs~) 5))", "A"],
	["i : !_ ⏎ i inc vs~（恒等射が受けた流れは、そのまま次の段へ。`inc vs~` と同じ）", trial(["i : !_", "i inc vs~"]), "(apply (compose i inc) vs~)", "A"],
	// 根が A でない関数の写像・畳み込みは未知
	["uu vs~（根が未知の関数の写像は未知）", trial("uu vs~"), "(apply uu vs~)", "未知"],
	["map $uu vs（同じ）", trial("map $uu vs"), "(apply map (construct $uu vs))", "未知"],
	["[uu,] vs（同じ）", trial("[uu,] vs"), "(apply [uu,] vs)", "未知"],
	// 番地の印の持ち越し（R49）
	["p : $inc ⏎ map p vs（`:` はメタで、名前は印を持ち越す）", trial(["p : $inc", "map p vs"]), "(apply map (construct p vs))", "A"],
	["(map $inc) vs（括りの関数の部分適用も印を持つ）", trial("(map $inc) vs"), "(apply [map $inc] vs)", "A"],
	["map [$inc] vs（[x] ≅ x）", trial("map [$inc] vs"), "(apply map (construct [$inc] vs))", "A"],
	["map $[x ? x + 1] vs（括りの関数の番地）", trial("map $[x ? x + 1] vs"), "(apply map (construct $[x ? x + 1] vs))", "A"],
	["hh : [f] ? [@f,] vs ⏎ hh [f : $inc]（欄の番地）", trial(["hh : [f] ? [@f,] vs", "hh [f : $inc]"]), "(apply hh [f : $inc])", "A"],
	// 実体の鍵：番地の印が違えば実体を分け合わない（分け合うと、先に解いた方の答えを後の方が黙って使う）
	["鍵 map $inc vs ⏎ map $uu vs の2行目は未知", trial(["map $inc vs", "map $uu vs"]), "(apply map (construct $uu vs))", "未知"],
	["鍵 map $uu vs ⏎ map $inc vs の2行目は A", trial(["map $uu vs", "map $inc vs"]), "(apply map (construct $inc vs))", "A"],
	["鍵 map $inc vs ⏎ map $double vs の map の実体は2つ（同じ綴りの `$L [N…]`）", trial(["map $inc vs", "map $double vs"]), "(: map (? [f [~t]] (inst $L [N…] (apply [@f,] t~)) (inst $L [N…] (apply [@f,] t~))))", null, { at: 6 }],
	["鍵 hh [f : $inc] ⏎ hh [f : $uu] の2行目は未知（欄の番地も鍵に入る）", trial(["hh : [f] ? [@f,] vs", "hh [f : $inc]", "hh [f : $uu]"]), "(apply hh [f : $uu])", "未知"],
	["鍵 hh [f : $uu] ⏎ hh [f : $inc] の2行目は A", trial(["hh : [f] ? [@f,] vs", "hh [f : $uu]", "hh [f : $inc]"]), "(apply hh [f : $inc])", "A"],
	// `[F,]` の写像は、写す関数ごとに鍵を分ける（fnKey。type だけだと `[inc,]` と `[uu,]` を欄で渡したときに実体を分け合う）
	["鍵 kk [f : [inc,]] ⏎ kk [f : [uu,]] の2行目は未知", trial(["kk : [f] ? f [1 2]", "kk [f : [inc,]]", "kk [f : [uu,]]"]), "(apply kk [f : [uu,]])", "未知"],
	["鍵 kk [f : [uu,]] ⏎ kk [f : [inc,]] の2行目は A", trial(["kk : [f] ? f [1 2]", "kk [f : [uu,]]", "kk [f : [inc,]]"]), "(apply kk [f : [inc,]])", "A"],
	// 畳み込みの2歩目の左は前の結果（中身の見えない A）。括りの関数はそれで答えが変わりうるので、2歩目まで見る（foldOver）：pp の実体の
	// [a] に数が入れば A、中身の見えない A なら a は未知で未知。
	["pp : [a] y ? a + y ⏎ pp vs~（2歩目の [a] は中身の見えない A なので未知）", trial(["pp : [a] y ? a + y", "pp vs~"]), "(apply pp vs~)", "未知"],
	["pp : [a] y ? a + y ⏎ pp vs~ の実体（1歩目 N N と2歩目 A N）", trial(["pp : [a] y ? a + y", "pp vs~"]), "(: pp (? [[a] y] (inst A A (+ a y)) (inst N A (+ a y))))", null, { at: 9 }],
	// 括りの仮引数に直に渡った番地は、中身の見えない A と同じに受ける（印は本体から見えない）ので、鍵と綴りは今までどおり `A`
	["ro : [~r] ? r 1 ⏎ ro $inc の実体の形は今までどおり A", trial(["ro : [~r] ? r 1", "ro $inc"]), "(: ro (? [[~r]] (inst A (construct r 1))))", null, { at: 9 }],
	// 試しの確かめ（2026-10-24）で直した所。
	// - 可変長の口だけの関数も `[F,]` で写す（R50。`[F,] a b` は `F a , F b` で、`F a` は1つの行なので可変長の口は a 1つを受けて閉じる。最初の版は
	//   口の数の分からない物と一緒に G7 にしていた）。
	["hd : [y ~ys] ? y ⏎ [hd,] ws（最後の仮引数が括りの関数の写像。前は G7）", trial(["hd : [y ~ys] ? y", "ws : [1 2] , [3 4]", "[hd,] ws"]), "(apply [hd,] ws)", "A"],
	["h1 : [a] ? a + 1 ⏎ [h1,] vs（同じ）", trial(["h1 : [a] ? a + 1", "[h1,] vs"]), "(apply [h1,] vs)", "A"],
	["pq : x [b] ? x + b ⏎ [(pq 1),] vs（その部分適用）", trial(["pq : x [b] ? x + b", "[(pq 1),] vs"]), "(apply [[pq 1],] vs)", "A"],
	["[[+],] ws（畳む点なしの写像。要素ごとに R31 の1項）", trial(["ws : [1 2] , [3 4]", "[[+],] ws"]), "(apply [[+],] ws)", "A"],
	["[[' 0],] ws（段18 の点なしの写像。要素ごとに `w ' 0`）", trial(["ws : [1 2] , [3 4]", "[[' 0],] ws"]), "(apply [[' 0],] ws)", "A"],
	["i : !_ ⏎ [i,] vs（恒等射の写像）", trial(["i : !_", "[i,] vs"]), "(apply [i,] vs)", "A"],
	["hd : [y ~ys] ? y ⏎ map $hd ws（`[@f,]` の f も同じ）", trial(["hd : [y ~ys] ? y", "ws : [1 2] , [3 4]", "map $hd ws"]), "(apply map (construct $hd ws))", "A"],
	["map $[* 2,] vs（貪欲な単項の写像。前は G7）", trial("map $[* 2,] vs"), "(apply map (construct $[* 2,] vs))", "A"],
	// - 畳み込みは、撒いた器が数か中身の見える List（深く見て要素が全部 A）か空の括りのときだけ値と言える（R31 の1項の読みと同じ線）。
	//   中身の見えない器は、要素に関数があるかもしれず、要素が1つなら関数を当てずにその要素を返すので未知（前は A で、`first (tl fs)~ 5` を黙って
	//   構築と読んだ）。写像は結果がいつも List なので A のまま。
	["tl ⏎ fs2 ⏎ fold $add (tl fs2)（中身の見えない器の畳み込みは未知）", trial(["tl : [y ~ys] ? ys", "fs2 : inc , double", "fold $add (tl fs2)"]), "(apply fold (construct $add [tl fs2]))", "未知"],
	["tl ⏎ add (tl vs)~（同じ。`[|] (tl vs)` と同じ未知）", trial(["tl : [y ~ys] ? ys", "add (tl vs)~"]), "(apply add [tl vs]~)", "未知"],
	["tl ⏎ inc (tl vs)~（写像は A のまま）", trial(["tl : [y ~ys] ? ys", "inc (tl vs)~"]), "(apply inc [tl vs]~)", "A"],
	["z : xs ? add xs~ ⏎ z vs（素の関数の裸の仮引数を畳む本体の根は未知）", trial(["z : xs ? add xs~", "z vs"]), "(apply z vs)", "未知"],
	// - 畳まない2項の点なしの部分適用は口が1つの写像で、畳まないので通す（口が2つの `[<<] vs~` は下で G19）。
	["([<<] 1) vs~（口が1つの写像）", trial("([<<] 1) vs~"), "(apply [[<<] 1] vs~)", "A", { pfInfo: "[<<]" }],
];
const trialRefused = [
	["f3 vs~（口が3つ。G19）", trial("f3 vs~"), "G19"],
	["fold $f3 vs（実体の中の `@f h~` で口が3つ。G19）", trial("fold $f3 vs"), "G19", [["fold", "$L [N…]"]]],
	["map $f3 vs（`[@f,]` の f の口が3つなので未知、G7）", trial("map $f3 vs"), "G7", [["map", "$L [N…]"]]],
	["[add,] vs（口が2つの関数は写像にしない、今のまま G7）", trial("[add,] vs"), "G7"],
	// 前は `map $[* 2,] vs`（可変長の口の関数も写像にしない、G7）をここに置いていた。試しの確かめで、可変長の口だけの関数は要素1つで閉じるので
	// 写す側へ移した（上）。固定の口の後ろに可変長の口がある関数は今のまま G7。
	["nn : a [~c] ? a ⏎ [nn,] vs（固定の口の後ろに可変長の口。今のまま G7）", trial(["nn : a [~c] ? a", "[nn,] vs"]), "G7"],
	["[' 0] vs~（口の数が分からない点なし。G19）", trial("[' 0] vs~"), "G19"],
	["go vs~（既定値のある関数は口の数が分からない。G19）", trial([...GO_DEFAULT, "go vs~"]), "G19"],
	["pb2 : [a] [b] ? a + b ⏎ pb2 vs~（固定の口の後ろに最後の括り。G19）", trial(["pb2 : [a] [b] ? a + b", "pb2 vs~"]), "G19"],
	// 素の関数の仮引数には印が届かない（呼ぶたびに実体を作らない。§5 Q45）：`@g` は今までどおり前置 `@` の項で、口の数が分からない
	["tg : g ? @g vs~（素の関数の本体。G19）", trial("tg : g ? @g vs~"), "G19"],
	["tg : g ? [@g,] vs（素の関数の本体の `[@g,]` は未知、G7）", trial("tg : g ? [@g,] vs"), "G7"],
	["uu vs~ 5（未知の写像の後ろに項。G2(a)）", trial("uu vs~ 5"), "G2(a)"],
	["[inc,] fs（写す器の中身に関数。G7）", trial(["fs : inc , double", "[inc,] fs"]), "G7"],
	["inc fs~（撒く器の中身に関数。今のまま G7）", trial(["fs : inc , double", "inc fs~"]), "G7"],
	["map $inc fs（同じ。実体の中で G7）", trial(["fs : inc , double", "map $inc fs"]), "G7", [["map", "$L [U…]"]]],
	// 試しの確かめ（2026-10-24）で直した所。
	// - 写す関数の無い貪欲な単項も、写す器の中身に関数が見えれば G7（`[[* 2],] fs` と同じ写像。前は `[* 2,] fs` だけ A）。
	["[[* 2],] fs（G7）", trial(["fs : inc , double", "[[* 2],] fs"]), "G7"],
	["[* 2,] fs（同じ写像なので G7。前は A）", trial(["fs : inc , double", "[* 2,] fs"]), "G7"],
	["[-_,] fs（同じ。前は A）", trial(["fs : inc , double", "[-_,] fs"]), "G7"],
	// - 中身の見えない器の畳み込みは未知（上の通る側）。後ろに項が来れば G2(a)（前は構築の A：`tl fs` は `[double inc]` なので first の値は
	//   double で、5 はそれに当たる。黙った誤答だった）。
	["first ⏎ tl ⏎ fs3 ⏎ first (tl fs3)~ 5（G2(a)。前は構築の A）", trial(["first : x y ? x", "tl : [y ~ys] ? ys", "fs3 : inc , double , inc", "first (tl fs3)~ 5"]), "G2(a)"],
	["tl ⏎ fs2 ⏎ add (tl fs2)~ 5（要素1つなら add は当たらず要素の double を返す。G2(a)）", trial(["tl : [y ~ys] ? ys", "fs2 : inc , double", "add (tl fs2)~ 5"]), "G2(a)"],
	["first ⏎ z : xs ? first xs~ ⏎ z fs2 5（素の関数の本体で畳む。G2(a)）", trial(["first : x y ? x", "z : xs ? first xs~", "fs2 : inc , double", "z fs2 5"]), "G2(a)"],
	["tl ⏎ fs2 ⏎ inc (fold $add (tl fs2)) 5（未知の括りが並びの中。G7）", trial(["tl : [y ~ys] ? ys", "fs2 : inc , double", "inc (fold $add (tl fs2)) 5"]), "G7"],
	// - 畳まない2項の点なし（R32。利用者「ビットシフトとget set は 畳めないね。」）は、撒いた流れを畳まない（G19、§5 Q49。前は畳んで A）。
	["[<<] vs~（G19）", trial("[<<] vs~"), "G19"],
	["[!=] vs~（G19）", trial("[!=] vs~"), "G19"],
	["[~] vs~（範囲。G19）", trial("[~] vs~"), "G19"],
	["fold $[<<] vs（実体の中の `@f h~`。G19）", trial("fold $[<<] vs"), "G19", [["fold", "$L [N…]"]]],
	["g : xs ? [<<] xs~（素の関数の本体。G19）", trial("g : xs ? [<<] xs~"), "G19"],
	// - 値の定義の名前の番地（`$cc`）には印が届かない（§5 Q45）。G19 の言い分は Q45 を名指しする（言い分は下の法則で見る）。
	["cc : add inc ⏎ fold $cc vs（G19。`cc vs~`・`fold $[add inc] vs` は通る）", trial(["cc : add inc", "fold $cc vs"]), "G19", [["fold", "A [N…]"]]],
];
for (const [name, s, want, kind, extra] of trialPasses) checkPass(`試し ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of trialRefused) checkRefused(`試し ${name}`, s, want, inst);

// 試しの確かめ（2026-10-24）で直した所の言い分と資源の守り。
const refusalOfSrc = (s) => {
	try {
		resolve(s);
		return null;
	} catch (e) {
		return e;
	}
};
law("試し：G19 の言い分は、印の届かない `@x` で §5 Q45 を名指しする", () => {
	const out = [];
	for (const s of [trial(["cc : add inc", "fold $cc vs"]), trial("tg : g ? @g vs~")]) {
		const e = refusalOfSrc(s);
		if (!e || e.gate !== "G19" || !e.message.includes("§5 Q45")) out.push(`got: ${e ? `${e.gate} ${e.message}` : "通った"}`);
	}
	// 口の数が分からない関数（印の問題でない）の言い分は Q45 を言わない。
	const g = refusalOfSrc(trial([...GO_DEFAULT, "go vs~"]));
	if (!g || g.gate !== "G19" || g.message.includes("Q45")) out.push(`go vs~ got: ${g ? `${g.gate} ${g.message}` : "通った"}`);
	return out;
});
law("試し：恒等射が渡した流れを写像・畳み込みで受けた後の関数は、「受けた後に合成された関数」の G18（R51）", () => {
	const out = [];
	for (const line of ["i inc vs~ double", "i add vs~ double", "i f2 vs~ inc"]) {
		const e = refusalOfSrc(trial(["i : !_", "f2 : x y ? x - y", line]));
		if (!e || e.gate !== "G18" || !e.message.includes("を受けた後に、関数") || e.message.includes("口の数の分からない")) out.push(`${line} got: ${e ? `${e.gate} ${e.message}` : "通った"}`);
	}
	// 恒等射を消した並び（単位律の側）は、写像・畳み込みの値の後ろに関数が積まれて余る。
	for (const line of ["inc vs~ double", "f2 vs~ inc"]) {
		const r = resolve(trial(["f2 : x y ? x - y", line]));
		const t = r.trees[r.trees.length - 1];
		if (!(t.t === "construct" && kindOf(t) === "A")) out.push(`${line} got: ${show(t)} : ${kindOf(t)}`);
	}
	return out;
});
// 合成の幅の資源の守り（COMPOSE_WIDTH_LIMIT。§5 Q25 の前からの穴）：同じ合成を並べて渡す再帰は、合成の中の関数が倍々になっても鍵の深さが
// 増えないので、前はヒープが尽きてプロセスごと落ちた（欄の道は HEAD d78ce73c でも、番地の道は試しの R49 から。前の番地の道は `@f` が頭以外で
// G6）。1本 5 秒の上限で見る。
law("試し：合成を倍々にする再帰は、合成の幅の資源の守りで断る", () => {
	const out = [];
	const cases = [
		trial(["deep7 : f [~t] ? deep7 $[@f @f] t", "deep7 $inc vs"]),
		trial(["deep : f [x ~t] ? (deep $[@f @f] t) , x", "deep $inc vs"]),
		trial(["dg : [f] [~t] ? dg [f : f f] t", "dg [f : inc] vs"]),
		trial(["fq : [g] ? fq [g : g g]", "fq [g : inc]"]),
	];
	for (const s of cases) {
		const t0 = Date.now();
		const e = refusalOfSrc(s);
		const ms = Date.now() - t0;
		if (ms > 5000) out.push(`${s.split("\n").slice(-2).join(" ⏎ ")}：${ms}ms`);
		if (!e || e.reason !== "compose-width-limit") out.push(`${s.split("\n").slice(-2).join(" ⏎ ")} got: ${e ? `${e.reason} ${e.gate || ""}` : "通った"}  want: compose-width-limit`);
	}
	// 幅が1ずつ増えるだけの再帰は、今までどおり入れ子の数の守りで止まる。
	const e = refusalOfSrc(trial(["deep8 : f [~t] ? deep8 $[@f inc] t", "deep8 $inc vs"]));
	if (!e || e.reason !== "instance-nest-limit") out.push(`deep8 got: ${e ? e.reason : "通った"}  want: instance-nest-limit`);
	return out;
});

// ---------------------------------------------------------------------------
// 評価する所の外で余ったラムダ（2026-10-24、R52、§7.24）
// ---------------------------------------------------------------------------
//
// 経緯：主の Claude が 2026-10-24 06:01（UTC）の返事で「`5 inc == 6` は、`inc 5 == 6` のつもりで書いても黙って通る（Q38・Q44）」と書き
// （03:03 の逆適用の廃止の報告にも同じ趣旨の行）、利用者がその文を引いて U [2026-10-24 06:29 ebf18260]「困ったね…逆適用はすべて廃止だと
// 言ってるのに～」。主の Claude の問い「値の後ろで何も受けずに閉じた関数は、`:` の右辺を除くどこでも、余ったラムダとして `_` にして知らせる、
// でいい？」に U〔答え〕[2026-10-24 06:32 ebf18260]「もちろん！」。
// - R52：左が名前1つの `:`（定義・欄・局所の定義）の右辺の並びを除く、どの並びでも（行の根・括りの中・段4〜8 と `,` の辺・字下げの本体の
//   各行・`?` の本体の根・枝の条件と値・囲み）、値の上に積まれた関数が、並びが閉じるまでに何も受けなければ、余ったラムダとして `_` になり、
//   構築の中では消える（R15）。leftover-lambda で知らせる（R48 と同じ。重さは同じ日の §5 Q44 の答えで information から warning に上げた。
//   恒等射なら知らせない）。合成は受けたことに数えない。§5 Q50 の答えから、`:` の右辺の並びも除かない（下の注、closedRhsPasses）。
// - 並び全体が1つの関数（`(inc add 5)`・`(f3 !_ 2)`・辺の `inc`）は今のまま（括りの中は後から当てられる、§5 Q37）。
// - 確かめの直し（§7.25）：値の上に積まれた後に受けた関数（`(5 add 1)`）と穴の関数（`(5 f2 !_)`）にも当てる。値の上に積まれたのは `(F Y)` の
//   1項で、括った `(5 (add 1))`・名前の `5 p1` と同じ（法則5）。最初の版は外に置いていて（未知）、括った綴りと割れていた。`:` の右辺の `,` が
//   恒等射で消えて残った並び（`v : 5 inc , !_`）は、右辺の並びとして R52 の外（R45。最初の版は v を 5 と読んでいた）。
// - 主の Claude の訂正：同じ答えの中で主の Claude は「`v : 5 inc` ⏎ `v 3` は `5 (inc 3)` で、inc がちゃんと受ける」と書いたが、名前は右辺を1つの
//   項として指し（R42 の読み7）、字面への置き換えではないので、v は未知で `v 3` は G7。字面どおりに読むかは §5 Q50。
// - 2026-10-24 の §5 Q50 の答え（下の closedRhsPasses）：右辺は閉じた1つの項で、`:` の右辺にも R52 を当てる（v は 5、`v 3` は `5 3`）。この節の
//   `:` の右辺の行は、答えを今の物に直した。
// 法則は coproduct_laws.test.js の法則16（`C[(X F)]` と `C[X]`）。
const r52Passes = [
	// 規則の例（上の問いの答えの後に主の Claude が挙げた物）
	["例 5 inc == 6（`5 == 6`。R47 では未知の辺で診断なし）", std("5 inc == 6"), "(== (construct 5 (unit inc)) 6)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["例 (5 inc) 3（`5 3`。括りの中の inc は二度と受けない。R47 では G7）", std("(5 inc) 3"), "(construct [5 inc] 3)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["例 t : y ? y inc の本体（`y`。R47 では未知）", std("t : y ? y inc"), "(construct y (unit inc))", "A", { body: true, diagCount: 1, leftoverDiag: ["inc"] }],
	["例 [1 2 inc]（`[1 2]`。R47 では未知）", std("[1 2 inc]"), "[1 2 inc]", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	// 例の `5 inc , 1` は G3 のまま（r52Refused）。括った `(5 inc) , 1` は `,` の辺の括りの中で R52（R47 では、`,` の値は A なので、未知の括りを
	// 器に入れたまま診断なしで通っていた）。
	["(5 inc) , 1（`5 , 1`。R47 では未知の括りを器に入れて診断なし）", std("(5 inc) , 1"), "(, [5 inc] 1)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	// 当てる所：段4〜8 の右の辺・`,` の辺の恒等射で残った並び・囲み・撒く項の括り・本体の括り・括りの関数の実引数
	["6 == 5 inc（右の辺も）", std("6 == 5 inc"), "(== 6 (construct 5 (unit inc)))", "A", { leftoverDiag: ["inc"] }],
	["(5 inc , !_) 3（括りの中の `,` が恒等射で消えて残った並び）", std("(5 inc , !_) 3"), "(construct [5 inc , !_] 3)", "A", { leftoverDiag: ["inc"] }],
	["||5 inc||（囲みの中）", std("||5 inc||"), "||5 inc||", "A", { leftoverDiag: ["inc"] }],
	["[5 inc]~（撒く括りの中。R47 では中身の未知な器を撒く G7）", std("[5 inc]~"), "[5 inc]~", "A", { leftoverDiag: ["inc"] }],
	["inc (5 inc)（`inc 5`。R47 では G7）", std("inc (5 inc)"), "(apply inc [5 inc])", "A", { leftoverDiag: ["inc"] }],
	["n (1 2 inc)（`n [1 2]`。R47 では G7）", std("n (1 2 inc)"), "(apply n [1 2 inc])", "A", { leftoverDiag: ["inc"] }],
	["(5 inc) inc（括りの中の inc と、根に余った inc。書いた所ごとに1つずつ）", std("(5 inc) inc"), "(construct [5 inc] (unit inc))", "A", { leftoverDiag: ["inc", "inc"] }],
	["t : y ? (5 inc)（本体の根の括り）", std("t : y ? (5 inc)"), "(: t (? [y] [5 inc]))", "A", { leftoverDiag: ["inc"] }],
	["t : y ? (y inc) 3（本体の中の括り）", std("t : y ? (y inc) 3"), "(construct [y inc] 3)", "A", { body: true, leftoverDiag: ["inc"] }],
	["t : y ? y inc ⏎ t 3 4（本体の根が A なので、余りを積む。R47 では未知の後ろに 4 で G2(a)）", std(["t : y ? y inc", "t 3 4"]), "(construct (apply t 3) 4)", "A", { leftoverDiag: ["inc"] }],
	// 字下げの本体の各行・枝の値と条件
	["字下げの本体の行 x inc", std(["w : x ?", "\tx inc", "\tx", ""]), "(block (construct x (unit inc)) x)", "A", { body: true, leftoverDiag: ["inc"] }],
	// 左が名前でない1項の `:`（`x > 1`）は、P3 では左を解かない1項だが、定義ではなく枝なので、右辺は枝の値（R52 の R の所）。
	["枝の値 x > 1 : x inc（左が名前でない1項の `:` は枝）", std(["q : x ?", "\tx > 1 : x inc", "\tx", ""]), "(block (: (> x 1) (construct x (unit inc))) x)", "A", { body: true, leftoverDiag: ["inc"] }],
	["枝の値 inc x : x inc（左が2項以上）", std(["q : x ?", "\tinc x : x inc", "\tx", ""]), "(block (: (apply inc x) (construct x (unit inc))) x)", "A", { body: true, leftoverDiag: ["inc"] }],
	["枝の条件 x inc == x : 1", std(["q : x ?", "\tx inc == x : 1", "\tx", ""]), "(block (: (== (construct x (unit inc)) x) 1) x)", "A", { body: true, leftoverDiag: ["inc"] }],
	// `:` の右辺の並びの中の括り（右辺の並びそのものではない）
	["v : (5 inc) ⏎ v 3（右辺の括りの中は R52。v は値）", std(["v : (5 inc)", "v 3"]), "(construct v 3)", "A", { leftoverDiag: ["inc"] }],
	["st : ⏎ k : (5 inc)（欄の右辺の括りの中も）", src([INC, "st :", "\tk : (5 inc)", "\tj : 2", ""]), "(: st (block (: k [5 inc]) (: j 2)))", "A", { at: 1, leftoverDiag: ["inc"] }],
	// 合成・名前の合成・恒等射に合成した関数（受けたことに数えない）
	["(5 inc double) 1（合成も何も受けていない）", std("(5 inc double) 1"), "(construct [5 inc double] 1)", "A", { leftoverDiag: ["(compose inc double)"] }],
	["5 !_ inc == 1（恒等射に合成した関数は恒等射でない）", std("5 !_ inc == 1"), "(== (construct 5 (unit (compose !_ inc))) 1)", "A", { leftoverDiag: ["(compose !_ inc)"] }],
	// 恒等射の直しの節から移した行（R47 では、括りの中が値と関数の並びで G7。単位律の `(5 f2) 3` も同じく通る）
	["(5 !_ f2) 3（R47 では G7、その前は G18、f2 5 3）", std("(5 !_ f2) 3"), "(construct [5 !_ f2] 3)", "A", { leftoverDiag: ["(compose !_ f2)"] }],
	["(5 i f2) 3（同じ）", std(["i : !_", "(5 i f2) 3"]), "(construct [5 i f2] 3)", "A", { leftoverDiag: ["(compose i f2)"] }],
	["(5 !_ inc f2) 3（同じ）", std("(5 !_ inc f2) 3"), "(construct [5 !_ inc f2] 3)", "A", { leftoverDiag: ["(compose !_ inc f2)"] }],
	["(5 !_ add f2) 3（同じ）", std("(5 !_ add f2) 3"), "(construct [5 !_ add f2] 3)", "A", { leftoverDiag: ["(compose !_ add f2)"] }],
	["c9 : !_ f2 ⏎ (5 c9) 3（同じ）", std(["c9 : !_ f2", "(5 c9) 3"]), "(construct [5 c9] 3)", "A", { leftoverDiag: ["c9"] }],
	["3 (5 !_ f2)（同じ）", std("3 (5 !_ f2)"), "(construct 3 [5 !_ f2])", "A", { leftoverDiag: ["(compose !_ f2)"] }],
	// 消えた後の形：構築の中の `(unit …)` は値の形・数に入らない（`[1 2 inc]` は `[1 2]` と同じ形で、括りの関数は同じ実体を使う）
	["tl [1 2 inc] ⏎ tl [1 2]（実体は1つ。形は `[1 2]` と同じ）", std(["tl : [a ~r] ? r", "tl [1 2 inc]", "tl [1 2]"]), "(: tl (? [[a ~r]] (inst [N…] r)))", "A", { at: -3, leftoverDiag: ["inc"] }],
	// 本体を実体ごとに読み直しても、書いた所ごとに1回だけ知らせる
	["kk : [y] ? y inc ⏎ kk 1 ⏎ kk [1 2]（実体は2つ、知らせるのは1回）", std(["kk : [y] ? y inc", "kk 1", "kk [1 2]"]), "(apply kk [1 2])", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	// 出ない所：恒等射（消えるが知らせない）
	["(5 !_)（恒等射は知らせない）", std("(5 !_)"), "[5 !_]", "A", { diagCount: 0, leftoverDiag: [] }],
	["(5 i i)（恒等射どうしの合成も）", std(["i : !_", "(5 i i)"]), "[5 i i]", "A", { diagCount: 0, leftoverDiag: [] }],
	// 出ない所：並び全体が1つの関数（今のまま。§5 Q37）
	["(inc add 5) 3（括りの中身が丸ごと関数は、後から当てられる）", std("(inc add 5) 3"), "(apply [inc add 5] 3)", "A", { diagCount: 0 }],
	["(f3 !_ 2) 1 3（同じ）", std("(f3 !_ 2) 1 3"), "(apply [f3 !_ 2] (construct 1 3))", "A", { diagCount: 0 }],
	["inc == 5（辺が関数だけは今のまま未知）", std("inc == 5"), "(== inc 5)", "未知", { diagCount: 0 }],
	// 左が名前1つの `:` の右辺の並び：R52 の片では出ない所（式を指すだけ）だった。2026-10-24 の §5 Q50 の答えから、右辺は閉じた1つの項で
	// R52 を当てる（closedRhsPasses）。下の行は答えを今の物に直した（名前の「前は」が R52 の片の答え）。
	["v : 5 inc（Q50 の答えから知らせる。前は `(construct 5 inc)` で知らせなかった）", std("v : 5 inc"), "(: v (construct 5 (unit inc)))", null, { diagCount: 1, leftoverDiag: ["inc"] }],
	["st : ⏎ k : 5 inc（欄の右辺も。前は知らせなかった）", src([INC, "st :", "\tk : 5 inc", "\tj : 2", ""]), "(: st (block (: k (construct 5 (unit inc))) (: j 2)))", "A", { at: 1, diagCount: 1, leftoverDiag: ["inc"] }],
	["q : x ? ⏎ y : x inc ⏎ y（局所の定義の右辺も。前は知らせなかった。局所の名前は今のまま未知なので、本体は未知）", std(["q : x ?", "\ty : x inc", "\ty", "", "q 3"]), "(apply q 3)", "未知", { diagCount: 1, leftoverDiag: ["inc"] }],
	// `:` の右辺の `,` が恒等射で消えて残った並びも、右辺の並び（R45）なので、`v : 5 inc` と同じく R52（前は、`v : 5 inc` と同じく R52 の外）
	["v : 5 inc , !_（`v : 5 inc` と同じ右辺の並び。前は知らせなかった）", std("v : 5 inc , !_"), "(: v (construct 5 (unit inc)))", null, { diagCount: 1, leftoverDiag: ["inc"] }],
	["st : ⏎ k : 5 inc , !_（欄の右辺も。前は知らせなかった）", src([INC, "st :", "\tk : 5 inc , !_", "\tj : 2", ""]), "(: st (block (: k (construct 5 (unit inc))) (: j 2)))", "A", { at: 1, diagCount: 1, leftoverDiag: ["inc"] }],
	["v : (5 inc) , !_ ⏎ v 3（`,` の辺の括りの中は R52。v は値）", std(["v : (5 inc) , !_", "v 3"]), "(construct v 3)", "A", { leftoverDiag: ["inc"] }],
	["v : 5 inc == 6 , !_（`,` で残ったのは `==` で、その辺は R52）", std("v : 5 inc == 6 , !_"), "(: v (== (construct 5 (unit inc)) 6))", null, { leftoverDiag: ["inc"] }],
	// 値の上に積まれた後に受けた関数と、穴の関数（確かめの直し、§7.25。法則5 で括った `(5 (add 1))`・名前の `5 p1` と同じ。最初の版は未知・G7）
	["(5 add 1)（受けた後の部分適用も消える。最初の版は未知）", std("(5 add 1)"), "[5 add 1]", "A", { diagCount: 1, leftoverDiag: ["(apply add 1)"] }],
	["(5 add 1) 3（最初の版は G7）", std("(5 add 1) 3"), "(construct [5 add 1] 3)", "A", { leftoverDiag: ["(apply add 1)"] }],
	["(5 (add 1)) 3（括った綴りも同じ、法則5）", std("(5 (add 1)) 3"), "(construct [5 [add 1]] 3)", "A", { leftoverDiag: ["[add 1]"] }],
	["5 add 1 == 6（辺でも。最初の版は未知で診断なし）", std("5 add 1 == 6"), "(== (construct 5 (unit (apply add 1))) 6)", "A", { diagCount: 1, leftoverDiag: ["(apply add 1)"] }],
	["p1 : add 1 ⏎ 5 p1 == 6（名前の部分適用も同じ）", std(["p1 : add 1", "5 p1 == 6"]), "(== (construct 5 (unit p1)) 6)", "A", { leftoverDiag: ["p1"] }],
	["5 add 1 inc == 6（受けた後に合成した関数も）", std("5 add 1 inc == 6"), "(== (construct 5 (unit (compose (apply add 1) inc))) 6)", "A", { leftoverDiag: ["(compose (apply add 1) inc)"] }],
	["t : y ? y add 1 ⏎ t 5（本体の根の受けた後の関数も。最初の版は未知）", std(["t : y ? y add 1", "t 5"]), "(apply t 5)", "A", { diagCount: 1, leftoverDiag: ["(apply add 1)"] }],
	["[1 2 add 3]（器の中も）", std("[1 2 add 3]"), "[1 2 add 3]", "A", { leftoverDiag: ["(apply add 3)"] }],
	["(5 f2 !_)（穴の関数も消える。最初の版は未知）", std("(5 f2 !_)"), "[5 f2 !_]", "A", { diagCount: 1, leftoverDiag: ["(? [$p0 [~$p1]] (apply f2 (construct $p0 $p1~)))"] }],
	["(5 f2 !_) 3（最初の版は G7）", std("(5 f2 !_) 3"), "(construct [5 f2 !_] 3)", "A", { leftoverDiag: ["(? [$p0 [~$p1]] (apply f2 (construct $p0 $p1~)))"] }],
	["(5 inc !_) 3（`inc !_` は η で inc。`(5 inc i) 3` と同じく A。最初の版は G7）", std("(5 inc !_) 3"), "(construct [5 inc !_] 3)", "A", { leftoverDiag: ["(? [$p0] (apply inc $p0))"] }],
	["i : !_ ⏎ (5 inc i) 3（同じ）", std(["i : !_", "(5 inc i) 3"]), "(construct [5 inc i] 3)", "A", { leftoverDiag: ["(compose inc i)"] }],
	["5 f2 _ 3 == 1（カリー化した穴の関数も）", std("5 f2 _ 3 == 1"), "(== (construct 5 (unit (? [$p0] (apply f2 (construct $p0 3))))) 1)", "A", { leftoverDiag: ["(? [$p0] (apply f2 (construct $p0 3)))"] }],
];
const r52Refused = [
	// 例の `5 inc , 1` は G3 のまま：`(5 inc) , 1` と `5 (inc , 1)` のどちらで読むか（§5 Q3）は R52 では決まらない（前者は `5 , 1`、後者は
	// 関数を器に入れた `5 [inc 1]` で、値が割れる）。
	["5 inc , 1（G3 のまま、§5 Q3）", std("5 inc , 1"), "G3"],
	// 主の Claude の訂正の行（名前は右辺を1つの項として指すので、v は未知で `v 3` は G7）と、`,` が恒等射で消えて残った右辺の並び・受けた後の
	// 関数の右辺の並びの G7 の行（R52 の片と §7.25）は、2026-10-24 の §5 Q50 の答え（v は閉じた1つの項で 5）で通る側へ移した（closedRhsPasses）。
];
for (const [name, s, want, kind, extra] of r52Passes) checkPass(`余ったラムダ ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of r52Refused) checkRefused(`余ったラムダ ${name}`, s, want, inst);

// ---------------------------------------------------------------------------
// `:` の右辺は閉じた1つの項・`$[…]` の中身は遅延・余ったラムダの知らせは warning（2026-10-24、§5 Q50〜Q52・Q44 の答え、§7.26）
// ---------------------------------------------------------------------------
//
// 経緯：R52 の片で残した §5 Q50〜Q52・Q44 に、利用者 U [2026-10-24 09:46 ebf18260]「Q50は迷うので、そう読むことで生じるデメリットを先に
// 教えて / Q51は具体例がある方が良いね… / Q52は最初からそのつもりだったしその方が良いと考えてたけど…違うなら違うと言って / Q44は知らせが
// 届かないってだけかい？」。主の Claude は 09:48（UTC）に材料と見立てを出した（Q50：閉じた1つの項として読むに傾いてる。Q51：今のまま当てる
// のがいい。Q52：`$` は物にする＝遅延なので、書いた所では判定せず、`@p` で開いた所で。Q44：本題は重さで、warning に上げるのが筋）。
// U〔答え〕[2026-10-24 09:49 ebf18260]「全てその方向で良いと思う。」。
// - Q50：左が名前1つの `:`（定義・欄・局所の定義）の右辺にも R52 を当てる。名前は右辺を閉じた1つの項として指す：`v : 5 inc` の右辺は
//   `(construct 5 (unit inc))` で、定義の行で知らせ、v は 5（`v 3` は `5 3`）。右辺が丸ごと関数（`c1 : inc inc`・`a1 : add 1`）は今のまま L。
// - Q51：枝の値にも当てる（今のまま。r52Passes の枝の行）。
// - Q52：`$[…]` の中身は遅延した式で、R52 の判定をしない（`_` にせず、知らせない）。中身の項の中（入れ子の括り・`?` の本体・段4〜8 の辺）は
//   今のまま当てる（遅延が中まで及ぶかは §5 Q53）。中身の行が段2 の `:`（欄・枝）なら、右辺はほかの `:` の右辺と同じく当てる（これも
//   §5 Q53。欄は Q50 の答えから新しく知らせる）。`@p` で中身を開けない形（中身が関数でない `$[5 inc]`）は今のまま未知（§5 Q9）で、知らせは
//   どこにも出ない（§5 Q44 の残り）。
// - Q44：leftover-lambda の重さは warning（断らない）。ほかの診断（undefined-name・pointfree-not-folded）は information のまま。
// 法則は coproduct_laws.test.js の法則10・12・13・16（名前と、括った右辺 `(P)` が同じ答え）。
const closedRhsPasses = [
	// Q50：右辺は閉じた1つの項
	["Q50 v : 5 inc（定義の行で知らせる）", std("v : 5 inc"), "(: v (construct 5 (unit inc)))", null, { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q50 v : 5 inc ⏎ v 3（`5 3`。前は v が未知で G7）", std(["v : 5 inc", "v 3"]), "(construct v 3)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q50 v : 5 inc ⏎ (v) 3（括っても同じ）", std(["v : 5 inc", "(v) 3"]), "(construct [v] 3)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q50 v : 5 inc ⏎ inc v（v は 5。前は G7）", std(["v : 5 inc", "inc v"]), "(apply inc v)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q50 v : 5 inc ⏎ v == 5（前は未知）", std(["v : 5 inc", "v == 5"]), "(== v 5)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q50 v : 5 inc ⏎ v inc（v の後ろの inc は根で余る。知らせるのは書いた所ごとに1つ）", std(["v : 5 inc", "v inc"]), "(construct v (unit inc))", "A", { diagCount: 2, leftoverDiag: ["inc", "inc"] }],
	["Q50 v : 5 add 1 ⏎ v 3（受けた後の関数も。前は G7）", std(["v : 5 add 1", "v 3"]), "(construct v 3)", "A", { leftoverDiag: ["(apply add 1)"] }],
	["Q50 v : 5 inc double ⏎ v 3（合成も）", std(["v : 5 inc double", "v 3"]), "(construct v 3)", "A", { leftoverDiag: ["(compose inc double)"] }],
	["Q50 v : 5 f2 !_ ⏎ v 3（穴の関数も）", std(["v : 5 f2 !_", "v 3"]), "(construct v 3)", "A", { leftoverDiag: ["(? [$p0 [~$p1]] (apply f2 (construct $p0 $p1~)))"] }],
	["Q50 i : !_ ⏎ v : 5 i ⏎ v 3（恒等射は知らせない）", std(["i : !_", "v : 5 i", "v 3"]), "(construct v 3)", "A", { diagCount: 0, leftoverDiag: [] }],
	// `,` が恒等射で消えて残った右辺の並びも、右辺の並びそのもの（R45）なので同じ
	["Q50 v : 5 inc , !_ ⏎ v 3（前は G7）", std(["v : 5 inc , !_", "v 3"]), "(construct v 3)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q50 v : !_ , 5 inc ⏎ v 3（前は G7）", std(["v : !_ , 5 inc", "v 3"]), "(construct v 3)", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q50 i : !_ ⏎ v : 5 inc , i ⏎ v 3（前は G7）", std(["i : !_", "v : 5 inc , i", "v 3"]), "(construct v 3)", "A", { leftoverDiag: ["inc"] }],
	["Q50 v : 5 inc , !_ , !_ ⏎ v 3（前は G7）", std(["v : 5 inc , !_ , !_", "v 3"]), "(construct v 3)", "A", { leftoverDiag: ["inc"] }],
	// 消えた後の形：名前を通しても `[1 2]` と同じ形で、括りの関数は同じ実体を使う
	["Q50 v : 1 2 inc ⏎ tl v ⏎ tl [1 2]（実体は1つ）", std(["tl : [a ~r] ? r", "v : 1 2 inc", "tl v", "tl [1 2]"]), "(: tl (? [[a ~r]] (inst [N…] r)))", "A", { at: -4, leftoverDiag: ["inc"] }],
	// 欄・局所の定義（R52 の片では外だった）
	["Q50 st : ⏎ k : 5 inc（欄）", src([INC, "st :", "\tk : 5 inc", "\tj : 2", ""]), "(: st (block (: k (construct 5 (unit inc))) (: j 2)))", "A", { at: 1, diagCount: 1, leftoverDiag: ["inc"] }],
	["Q50 q : x ? ⏎ y : x inc ⏎ y（局所の定義。局所の名前は今のまま未知）", std(["q : x ?", "\ty : x inc", "\ty", "", "q 3"]), "(apply q 3)", "未知", { diagCount: 1, leftoverDiag: ["inc"] }],
	// 括りの欄も（主の Claude が 09:48 の Q51 の表で「対象外、知らせない」と挙げた形。2026-10-24 の確かめの指摘で足した）
	["Q50 [a : 5 inc]（括りの欄。R52 の片では知らせなかった）", std("[a : 5 inc]"), "[a : 5 inc]", "A", { diagCount: 1, leftoverDiag: ["inc"] }],
	// 右辺が丸ごと関数は今のまま L で、後から当てられる（10-22 22:14 のボタンの文の形）
	["Q50 c1 : inc inc ⏎ c1 5（丸ごと関数は L のまま）", std(["c1 : inc inc", "c1 5"]), "(apply c1 5)", "A", { diagCount: 0 }],
	["Q50 a1 : add 1 ⏎ a1 5（同じ）", std(["a1 : add 1", "a1 5"]), "(apply a1 5)", "A", { diagCount: 0 }],
	["Q50 c1 : inc inc（定義の行も知らせない）", std("c1 : inc inc"), "(: c1 (compose inc inc))", null, { diagCount: 0 }],
	["Q50 q : inc add 5 ⏎ q 3（流れの足りない合成も丸ごと関数）", std(["q : inc add 5", "q 3"]), "(apply q 3)", "A", { diagCount: 0 }],
	["Q50 s : [+] 1 ⏎ s 2（並びの終わりで閉じる可変長の口は今のまま、R41 の読み5）", std(["s : [+] 1", "s 2"]), "(construct s 2)", "A", { diagCount: 0 }],
	// Q52：`$[…]` の中身は遅延した式
	["Q52 p : $[5 inc]（知らせない。前は中身の inc を知らせた）", std("p : $[5 inc]"), "(: p $[5 inc])", null, { diagCount: 0, leftoverDiag: [] }],
	// 中身が値の `$[…]` は開けないので、知らせはどこにも出ない（書いた所の判定は外し、開く所の道は無い。開けない `@p` の所で知らせるかは
	// §5 Q44 の残り。2026-10-24 の確かめの指摘で名前に書いた）
	["Q52 p : $[5 inc] ⏎ @p 3（開けないので今のまま未知、§5 Q9。知らせはどこにも出ない、§5 Q44 の残り）", std(["p : $[5 inc]", "@p 3"]), "(apply @p 3)", "未知", { diagCount: 0 }],
	["Q52 p : $[5 inc , !_]（`,` の恒等射で残った中身の並びも）", std("p : $[5 inc , !_]"), "(: p $[5 inc , !_])", null, { diagCount: 0 }],
	["Q52 adder2 : m ? $[m inc]（本体の根の `$[…]` も）", std("adder2 : m ? $[m inc]"), "(: adder2 (? [m] $[m inc]))", null, { diagCount: 0 }],
	["Q52 use $[5 inc] 3（実引数の `$[…]` も）", std("use $[5 inc] 3"), "(apply use (construct $[5 inc] 3))", "未知", { diagCount: 0 }],
	["Q52 [$[5 inc]]（括りの中の `$[…]` も）", std("[$[5 inc]]"), "[$[5 inc]]", "A", { diagCount: 0 }],
	["Q52 p : $[inc add 5]（丸ごと関数の中身は今までどおり L で、番地が運ぶ）", std(["p : $[inc add 5]", "use p 3"]), "(apply use (construct p 3))", "未知", { diagCount: 0 }],
	// 中身の項の中は今のまま R52（遅延が中まで及ぶかは §5 Q53）。`@` で開く括りの中身も R52（開く所）
	["Q52 p : $[(5 inc) 3]（入れ子の括りの中は今のまま当てる、§5 Q53）", std("p : $[(5 inc) 3]"), "(: p $[[5 inc] 3])", null, { leftoverDiag: ["inc"] }],
	["Q52 p : $[5 inc == 6]（段4〜8 の辺は今のまま当てる、§5 Q53）", std("p : $[5 inc == 6]"), "(: p $[5 inc == 6])", null, { leftoverDiag: ["inc"] }],
	["Q52 p : $[x ? x inc]（`?` の本体は今のまま当てる、§5 Q53）", std("p : $[x ? x inc]"), "(: p $[x ? x inc])", null, { leftoverDiag: ["inc"] }],
	// 確かめの指摘で足した §5 Q53 の形（2026-10-24）：1項を括っただけの中身は、`$[5 inc]` と [x] ≅ x で同じ物なのに、今は括りの中として当てて
	// 知らせが割れる。中身の行が段2 の `:` なら、右辺はほかの `:` の右辺と同じく当てる：欄の右辺は R52 の片では印 pointsTo で黙っていて、
	// §5 Q50 の答えから新しく知らせる（今のままではない）。枝の値は前も今も当てる。木と種類はどれも前と同じ。
	["Q53 p : $[(5 inc)]（1項の括りを重ねた中身は今は当てる。`$[5 inc]` とは知らせが割れる）", std("p : $[(5 inc)]"), "(: p $[[5 inc]])", null, { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q53 p : $[k : 5 inc]（中身の欄の右辺は今は当てる。R52 の片では黙っていた）", std("p : $[k : 5 inc]"), "(: p $[k : 5 inc])", null, { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q53 p : $[5 > 1 : 5 inc]（中身の枝の値は前も今も当てる）", std("p : $[5 > 1 : 5 inc]"), "(: p $[5 > 1 : 5 inc])", null, { diagCount: 1, leftoverDiag: ["inc"] }],
	["Q52 @[5 inc] 3（`@` は開く所なので当てる）", std("@[5 inc] 3"), "(apply @[5 inc] 3)", "未知", { leftoverDiag: ["inc"] }],
	// Q44：重さ（DIAG_SEVERITY の1か所）。warning でも断らない
	["Q44 5 inc（leftover-lambda は warning）", std("5 inc"), "(construct 5 (unit inc))", "A", { severities: ["warning/leftover-lambda"] }],
	["Q44 (5 inc) 3（R52 の知らせも warning）", std("(5 inc) 3"), "(construct [5 inc] 3)", "A", { severities: ["warning/leftover-lambda"] }],
	["Q44 zz 5 inc（undefined-name は information のまま）", std("zz 5 inc"), "(construct zz 5 (unit inc))", "A", { severities: ["information/undefined-name", "warning/leftover-lambda"] }],
	["Q44 [<<] 3 4 inc（pointfree-not-folded は information のまま）", std("[<<] 3 4 inc"), "(construct (apply [<<] (construct 3 4)) (unit inc))", "A", { severities: ["information/pointfree-not-folded", "warning/leftover-lambda"] }],
];
const closedRhsRefused = [
	// 名前が 5 になったので、5 を置いた並びと同じ門に当たる（`gd 5 i`・`!_ 5 inc` と同じ）
	["Q50 既定値のある go で v : 5 inc ⏎ go v i（`go 5 i` と同じ G2(a)。前は G7）", std([...GO_DEFAULT, "i : !_", "v : 5 inc", "go v i"]), "G2(a)"],
	["Q50 v : 5 inc ⏎ !_ v inc（`!_ 5 inc` と同じ G18。前は G7）", std(["v : 5 inc", "!_ v inc"]), "G18"],
	// Q52：中身を開けない `@p` の後ろに項（今のまま、§5 Q9）
	["Q52 p : $[5 inc] ⏎ inc @p 3（`@p` が頭以外、§5 Q9）", std(["p : $[5 inc]", "inc @p 3"]), "G6"],
];
for (const [name, s, want, kind, extra] of closedRhsPasses) checkPass(`閉じた右辺 ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of closedRhsRefused) checkRefused(`閉じた右辺 ${name}`, s, want, inst);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
