/**
 * **余積（空白）の解決**（resolve.js、仕様は alpha1/docs/coproduct_spec.md）。
 *
 * §6.3 の「通る」表の全部の行を、木の文字列と（決まっている行は）根の種類で、「断られる」表の全部の行を、門の
 * reason と枝（`gate`）で確かめる。値の列は確かめない——値の段はまだ無い（§6.4 の7）。断られる行は「今は断る」
 * 試験で、§5 の問いの答えが出たら通る側へ移す（§6.4 の8）。
 *
 * 定義は §6.3 の「定義」をそのまま使う。ただし次の3か所は、仕様のほかの規則（P2：隠し）と両立しないので直した。
 * - `adder : n ? [+ n]` の仮引数 `n` は、同じ表の `n : [~x] ? x`（ファイルの定義）を隠すので `m` にした。
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
 * いちばん後ろに、値を含む輪（§5 Q30、2026-10-20。どこから入っても name-cycle で、言い分に輪の道筋）の行を置く。
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
	"adder : m ? [+ m]",
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
	["5 inc 3", std("5 inc 3"), "(construct 5 (apply inc 3))", "A"],
	["1 2 [+] 3 4", std("1 2 [+] 3 4"), "(construct 1 2 (apply [+] (construct 3 4)))", "A"],
	["double inc 5", std("double inc 5"), "(apply (compose double inc) 5)", "A"],
	["[+] inc 5 6", std("[+] inc 5 6"), "(apply (compose [+] inc) (construct 5 6))", "A"],
	["[< 3,] [* 2,] 1 5 2", std("[< 3,] [* 2,] 1 5 2"), "(apply (compose [< 3,] [* 2,]) (construct 1 5 2))", "A"],
	["[* 2,] [+] 1 2 3 4 5（未知の根）", std("[* 2,] [+] 1 2 3 4 5"), "(apply (compose [* 2,] [+]) (construct 1 2 3 4 5))", "未知"],
	["k1 1 2", std("k1 1 2"), "(apply k1 (construct 1 2))", "A", { excess: false }],
	["d 1 2（根、excess）", std("d 1 2"), "(apply d (construct 1 2))", "A", { excess: true }],
	["[+ 1] 1 2 3（根、excess）", std("[+ 1] 1 2 3"), "(apply [+ 1] (construct 1 2 3))", "A", { excess: true }],
	["[+ 1] [1 2 3]~（未知の根）", std("[+ 1] [1 2 3]~"), "(apply [+ 1] [1 2 3]~)", "未知"],
	["[+] [1 2 3]~（未知の根）", std("[+] [1 2 3]~"), "(apply [+] [1 2 3]~)", "未知"],
	["[|] ([< 3,] 5 1 2)（未知の根）", std("[|] ([< 3,] 5 1 2)"), "(apply [|] [[< 3,] 5 1 2])", "未知"],
	["[+] ([< 3,] 1 5 2)（未知の根）", std("[+] ([< 3,] 1 5 2)"), "(apply [+] [[< 3,] 1 5 2])", "未知"],
	["use $inc 5（未知の根）", std("use $inc 5"), "(apply use (construct $inc 5))", "未知"],
	["use inc 5（L の根）", std("use inc 5"), "(apply (compose use inc) 5)", "L"],
	["use 5 inc（L の根）", std("use 5 inc"), "(compose (apply use 5) inc)", "L"],
	["@a b c（b, c は値、未知の根）", std("@a b c"), "(apply @a (construct b c))", "未知"],
	["本体 g x（g, x は裸の仮引数）", std("t : g x ? g x", { omit: ["g"] }), "(construct g x)", "A", { body: true }],
	["本体 @g x（未知の根）", std("t : g x ? @g x", { omit: ["g"] }), "(apply @g x)", "未知", { body: true }],
	["@(procs ' 0) 5（未知の根）", std("@(procs ' 0) 5"), "(apply @[procs ' 0] 5)", "未知"],
	["本体 mul x + 1 y", std("t : x y ? mul x + 1 y"), "(apply mul (construct (+ x 1) y))", "A", { body: true }],
	["inc 1 + 2", std("inc 1 + 2"), "(apply inc (+ 1 2))", "A"],
	["[* 2,] `ab` == `aabb`", std("[* 2,] `ab` == `aabb`"), "(== (apply [* 2,] `ab`) `aabb`)", null],
	["1 2 , 3 4", std("1 2 , 3 4"), "(, (construct 1 2) (construct 3 4))", null],
	["vs~ 4", std("vs~ 4"), "(construct vs~ 4)", "A"],
	["5 inc（逆適用）", std("5 inc"), "(apply inc 5 ·rev)", "A"],
	["5 inc inc", std("5 inc inc"), "(apply (compose inc inc) 5 ·rev)", "A"],
	["add1 : add 1 の後で add1 5", std(["add1 : add 1", "add1 5"]), "(apply add1 5)", "A"],
	["g3 : f3 1 の後で g3 2 3", std(["g3 : f3 1", "g3 2 3"]), "(apply g3 (construct 2 3))", "A"],
	["(f3 1) 2 3", std("(f3 1) 2 3"), "(apply [f3 1] (construct 2 3))", "A"],
	["(f2 10) g 3", std("(f2 10) g 3"), "(apply (compose [f2 10] g) 3)", "A"],
	["add _ 10（穴）", std("add _ 10"), "(? [$p0] (apply add (construct $p0 10)))", "L"],
	["f4 _ 2 _ 3（穴2つ）", std("f4 _ 2 _ 3"), "(? [$p0 $p1] (apply f4 (construct $p0 2 $p1 3)))", "L"],
	["[add _ 10] 5", std("[add _ 10] 5"), "(apply [add _ 10] 5)", "A"],
	["_ \\a", std("_ \\a"), "\\a", "A"],
	["_ 1 2", std("_ 1 2"), "(construct 1 2)", "A"],
	["_ _", std("_ _"), "_", null],
	["go !_ xs（go は関数、xs は値）", std(["go : ys ? ys", "xs : 1 , 2", "go !_ xs"]), "(apply go xs)", "A"],
	["say 5（say は未定義）", std("say 5"), "(construct say 5)", "A", { diag: "say" }],
	["[x ? x + 1] 5", std("[x ? x + 1] 5"), "(apply [x ? x + 1] 5)", "A"],
	["map $[* 2] 1 2 3 4 5（最後の括りが残りの並びを受ける。R24、2026-10-19）", std("map $[* 2] 1 2 3 4 5"), "(apply map (construct $[* 2] 1 2 3 4 5))", "A"],
	["n 1 2 3（括り1つの関数は並び全体を受ける。R24、2026-10-19）", std("n 1 2 3"), "(apply n (construct 1 2 3))", "A"],
	["adder 5（未知の根）", std("adder 5"), "(apply adder 5)", "未知"],
	["f : x y ? x + y（解くのは x + y だけ）", "f : x y ? x + y", "(: f (? [x y] (+ x y)))", null],
];

// 断られる：[名前, ソース, 門]
const GO_DEFAULT = ["go :", "\t\tys", "\t\tzs : 3", "\t? ys", "", "xs : 1 , 2"];
const refused = [
	["f2 1 g 2", std("f2 1 g 2"), "G2(b)"],
	["[+] 5 g 3", std("[+] 5 g 3"), "G2(a)"],
	["5 inc 3 4", std("5 inc 3 4"), "G12(a)"],
	["inc 1 2 inc", std("inc 1 2 inc"), "G12(a)"],
	["adder 5 3", std("adder 5 3"), "G12(b)"],
	["5 f2 1", std("5 f2 1"), "G8"],
	["5 f2", std("5 f2"), "G8"],
	["5 (f2 1)", std("5 (f2 1)"), "G8"],
	["1 2 inc", std("1 2 inc"), "G1"],
	["5 [+ 1]", std("5 [+ 1]"), "G10"],
	["5 inc [* 2]", std("5 inc [* 2]"), "G10"],
	["xs~ inc", std("xs~ inc"), "G9"],
	["~1 2 3", std("~1 2 3"), "G4"],
	["y @x", std("y @x"), "G6"],
	["@f g 5", std("@f g 5"), "G6"],
	["inc _", std("inc _"), "G5"],
	["([+ 1] _) 5", std("([+ 1] _) 5"), "G5"],
	["[!_] _", std("[!_] _"), "G5"],
	["1 _ 2", std("1 _ 2"), "G5"],
	["\\a _", std("\\a _"), "G5"],
	["_ inc 5", std("_ inc 5"), "G5"],
	["add 1 _", std("add 1 _"), "G5"],
	["inc 1 _", std("inc 1 _"), "G5"],
	["f _ _", std("f _ _"), "G5"],
	["[+] 1 _ 3", std("[+] 1 _ 3"), "G5"],
	["go _ xs（既定値あり）", std([...GO_DEFAULT, "go _ xs"]), "G5"],
	["_ + 1 f", std("_ + 1 f"), "G5"],
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
	["5 !_ 3", std("5 !_ 3"), "G7"],
	["a : b 1 と b : a 2", "a : b 1\nb : a 2", "name-cycle"],
	["inc : x ? x + 1 と h : inc ? inc 5", "inc : x ? x + 1\nh : inc ? inc 5", "name-shadow"],
];

const GATE_REASON = {
	G1: "coproduct-reverse-of-many",
	G2: "coproduct-partial-neighbor",
	G3: "coproduct-beside-product",
	G4: "coproduct-prefix-tilde",
	G5: "coproduct-unit-position",
	G6: "coproduct-input-position",
	G7: "coproduct-unknown-kind",
	G8: "coproduct-reverse-arity",
	G9: "coproduct-reverse-spread",
	G10: "coproduct-reverse-pointfree",
	G11: "coproduct-no-reading",
	G12: "coproduct-excess-neighbor",
};


let passed = 0;
let total = 0;
const ok = (name) => {
	console.log(`OK   ${name}`);
	passed++;
};
const fail = (name, ...lines) => console.log(`FAIL ${name}\n${lines.map((l) => `     ${l}`).join("\n")}`);

// 通る行を確かめる。extra：body（本体の木を見る）・at（見る行の番号）・excess・diag（undefined-name が出る名前）・
// diagCount（出る診断の数）。
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
	if ("excess" in extra && !!t.excess !== extra.excess) problems.push(`excess got: ${!!t.excess}  want: ${extra.excess}`);
	if (extra.diag && !r.diagnostics.some((d) => d.reason === "undefined-name" && d.severity === "information" && d.name === extra.diag)) {
		problems.push(`undefined-name（${extra.diag}）が出ていない: ${JSON.stringify(r.diagnostics)}`);
	}
	if ("diagCount" in extra && r.diagnostics.length !== extra.diagCount) {
		problems.push(`診断の数 got: ${r.diagnostics.length}  want: ${extra.diagCount}  ${JSON.stringify(r.diagnostics)}`);
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
	// R12 の見本は `|x| f`。`f` は標準の定義に無い（`use` の仮引数を隠す）ので、アリティ1の `inc` で書く。
	["R12 |x| inc", std("|x| inc"), "(apply inc |x| ·rev)", "A"],
	["R7 1 d 2", std("1 d 2"), "(construct 1 (apply d 2))", "A"],
	["R13 5 [+ 1] 3", std("5 [+ 1] 3"), "(construct 5 (apply [+ 1] 3))", "A"],
	["R19 (inc 1) , (inc 2)", std("(inc 1) , (inc 2)"), "(, [inc 1] [inc 2])", null],
	["R1 x * 2 y * 2", std("t : x y ? x * 2 y * 2"), "(construct (* x 2) (* y 2))", "A", { body: true }],
	// 再帰は A と仮置きして一巡する（§3.4）。仮置きと合えば A のまま。
	["再帰：仮置きが合う", std(["fact : k ? k * [fact k - 1]", "fact 5"]), "(apply fact 5)", "A"],
	// 仮置きと食い違えば未知（本体の根は点なし＝L）。根の k = n は未知で通り、k > n は G12(b)。
	// この行は、根が L のままでも未知になるので、仮置きを取り消す仕組みは見ていない（寄生したオラクル）。
	// 取り消しは下の「相互再帰」の2行で見る。
	["再帰：仮置きが外れる", std(["r : k ? [+ [r k]]", "r 1"]), "(apply r 1)", "未知"],
	// 字下げのブロックの本体：全部の行（枝なら値の側）の根が A のときだけ A。
	["字下げの本体", std(["sgn : v ?", "\tv < 0 : 0 - v", "\tv", "", "sgn 5"]), "(apply sgn 5)", "A"],
];
const extraRefused = [
	["再帰：仮置きが外れて k > n", std(["r : k ? [+ [r k]]", "r 1 2"]), "G12(b)"],
	["同じ名前の定義が2つ", "p : 1\np : 2", "name-duplicate"],
	["入れ子の関数の仮引数が外の仮引数を隠す", "f : x ? [x ? x] x", "name-shadow"],
	["取り込みのある範囲の未定義の名前は未知", "io@\nsay 5", "G7"],
];
for (const [name, src, want, kind, extra] of extraPasses) checkPass(`追加 ${name}`, src, want, kind, extra);
for (const [name, src, want] of extraRefused) checkRefused(`追加 ${name}`, src, want);

// 2つの確かめ（仕様どおりか・反証）の指摘を当てた所。それぞれ、直す前は黙って通っていたか、別の読みになっていた。
const GO = ["go : ys ? ys", "xs : 1 , 2"];
const fixPasses = [
	// R18：すぐ右の撒く項も A（§2「A（撒く印つき）」）。恒等射を取り除くのは右が何でも同じ。
	["R18 go !_ vs~", std([...GO, "go !_ vs~"]), "(apply go vs~)", "未知"],
	// 貪欲な2項は `[+]` だけ（§3.4）。`[*]` などは種類が未知で、根なら通る。
	["[+] 5 6 inc（貪欲な2項のまま）", std("[+] 5 6 inc"), "(apply inc (apply [+] (construct 5 6)) ·rev)", "A"],
	["[-] 5 3 1（未知の根）", std("[-] 5 3 1"), "(apply [-] (construct 5 3 1))", "未知"],
	["[*] inc 2 3（未知の根）", std("[*] inc 2 3"), "(apply (compose [*] inc) (construct 2 3))", "未知"],
	// 段18 の点なしの適用は、k = 1 なら `fs ' 0` と同じ desc（R26。2026-10-19 に §2 Q1 の答えで決まった）。ここは
	// k = 2 なので未知のまま。k = 1 の `[' 0] fs` も、fs の要素に関数が見えるので未知（下の「法則」で比べる）。
	["[' 0] fs 5（未知の根）", std("[' 0] fs 5"), "(apply [' 0] (construct fs 5))", "未知", { excess: false }],
	// 中置の右のブロックは前段が置く場所なので通る。
	["中置の右のブロック", std(["v : 1 +", "\t2"]), "(: v (+ 1 (block 2)))", null],
	// 合成の最初の関数の本体の根が値でなければ、k = n でも未知（§5 Q21）。
	["adder inc 5（未知の根）", std("adder inc 5"), "(apply (compose adder inc) 5)", "未知"],
	["use inc 5 6（未知の根）", std("use inc 5 6"), "(apply (compose use inc) (construct 5 6))", "未知"],
	// 器の中の器まで見て、関数が無ければ撒ける。
	["[vs 1]~ 5", std("[vs 1]~ 5"), "(construct [vs 1]~ 5)", "A"],
	// 名前が `?` の定義を直に指すなら、括りで包んでも逆適用の右に置ける。別名の適用の種類は生まれた関数で決める。
	["pq : [x ? x + 1] の後で 5 pq", std(["pq : [x ? x + 1]", "5 pq"]), "(apply pq 5 ·rev)", "A"],
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
	// 括らない `!_` は、並びの中ですぐ左が L・すぐ右が A のときだけ取り除く。それ以外は1項でも G7（手順1、R18）。
	["x2 : !_", std("x2 : !_"), "G7"],
	["本体が !_ だけ", std("tt : a ? !_"), "G7"],
	["!_ , 1", std("!_ , 1"), "G7"],
	["!_ == 1", std("!_ == 1"), "G7"],
	["[!_ ⏎ 1]", std(["[!_", "1]"]), "G7"],
	["!_ + 1", std("!_ + 1"), "G7"],
	["[+ !_] 1", std("[+ !_] 1"), "G7"],
	["[+ !_]（1項でも）", std("[+ !_]"), "G7"],
	["inc !_ inc", std("inc !_ inc"), "G7"],
	// `[+]` 以外の両側の欠けた点なしは、種類が未知の適用になる。
	["[*] 2 3 inc", std("[*] 2 3 inc"), "G2(a)"],
	["1 [*] 2 3 4", std("1 [*] 2 3 4"), "G2(a)"],
	["5 [*]", std("5 [*]"), "G10"],
	// 段18 の点なし。
	["[' 0] fs inc", std("[' 0] fs inc"), "G2(a)"],
	["[@ 0] fs inc", std("[@ 0] fs inc"), "G2(a)"],
	["[@] fs 0 inc", std("[@] fs 0 inc"), "G2(a)"],
	["5 [' 0]", std("5 [' 0]"), "G10"],
	// §3.3 の「他の読みと割れる所」は G12 と書くが、手順と R12 で縮めると G1（左が構築の節）。
	["5 inc 3 inc", std("5 inc 3 inc"), "G1"],
	// 撒く項を中置・点なしにどう渡すかは仕様に無いので未知（2項以上の並びで G7）。
	["vs~ + 1 5", std("vs~ + 1 5"), "G7"],
	["[+ vs~] 1", std("[+ vs~] 1"), "G7"],
	// 種類の未知な名前を撒く項は未知の葉。中身の見える名前は位置に依らず G7。
	["q : use $inc 5 の後で q~ 5", std(["q : use $inc 5", "q~ 5"]), "G7"],
	["q : [use $inc 5] の後で q~", std(["q : [use $inc 5]", "q~"]), "G7"],
	// 逆適用の右と穴の頭は、`?` の定義を直に指す名前か `?` の括りだけ（別名は断る側に揃えた）。
	["5 [inc]", std("5 [inc]"), "G8"],
	["q : [inc] の後で 5 q", std(["q : [inc]", "5 q"]), "G8"],
	["p : inc の後で 5 p", std(["p : inc", "5 p"]), "G8"],
	["p2 : add の後で p2 _ 3", std(["p2 : add", "p2 _ 3"]), "G5"],
	// 字下げのブロックは並びの項にならない（§2）。中置の右でない所のブロックは断る。
	["ブロックが並びの項", std(["v :", "\tinc", " 5"]), "indent-block-position"],
	["ブロックが中置の左", std(["v :", "\t1", " + 1"]), "indent-block-position"],
	["ブロックが , の左", std(["v :", "\t1", " , 2"]), "indent-block-position"],
	["ブロックが == の左", std(["v :", "\t1", " == 2"]), "indent-block-position"],
	["本体のブロックが並びの項", std(["t : a ?", "\ta", "\tinc", " 5", "", "t 1 inc"]), "indent-block-position"],
	// 合成の最初の関数の本体の根が値でない（§5 Q21）。
	["1 adder inc 5", std("1 adder inc 5"), "G2(a)"],
	["adder inc 5 double", std("adder inc 5 double"), "G2(a)"],
	["adder inc 5 6", std("adder inc 5 6"), "G12(b)"],
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
	// R15 の「`_` を含まない A の項」は括りの中も見る。
	["_ [_ 1]", std("_ [_ 1]"), "G5"],
];
for (const [name, src, want, kind, extra] of fixPasses) checkPass(`確かめ ${name}`, src, want, kind, extra);
for (const [name, src, want] of fixRefused) checkRefused(`確かめ ${name}`, src, want);

// 試験の穴：変異試験で壊しても落ちなかった所と、それを見分ける入力。
const gapPasses = [
	["5 [x ? x + 1]", std("5 [x ? x + 1]"), "(apply [x ? x + 1] 5 ·rev)", "A"],
	// 貪欲な単項は excess にしない（§3.4）ので、逆適用の左に置ける。
	["[* 2,] 1 2 3 inc", std("[* 2,] 1 2 3 inc"), "(apply inc (apply [* 2,] (construct 1 2 3)) ·rev)", "A"],
	["double adder 5（未知の根）", std("double adder 5"), "(apply (compose double adder) 5)", "未知"],
	["inc add 5（未知の根）", std("inc add 5"), "(apply (compose inc add) 5)", "未知"],
	["[+] inc 5（未知の根）", std("[+] inc 5"), "(apply (compose [+] inc) 5)", "未知"],
	["use 5 inc double（R8 で開く）", std("use 5 inc double"), "(compose (apply use 5) inc double)", "L"],
	["[f3 _ _ 3] 1 2 inc", std("[f3 _ _ 3] 1 2 inc"), "(apply inc (apply [f3 _ _ 3] (construct 1 2)) ·rev)", "A"],
	// 穴の生成名はソースの名前と衝突しない綴りにする。
	["p0 : 1 の後で add _ p0", std(["p0 : 1", "add _ p0"]), "(? [$p_0] (apply add (construct $p_0 p0)))", "L"],
	["[] 5", std("[] 5"), "(construct [] 5)", "A"],
	["[1 ⏎ 2] inc", std(["[1", "2] inc"]), "(apply inc [1 ⏎ 2] ·rev)", "A"],
	["#ff : y ? y の後で ff 5", std(["#ff : y ? y", "ff 5"]), "(apply ff 5)", "A"],
	["ff : [y ? ff y]（輪にしない）", std(["ff : [y ? ff y]", "ff 5"]), "(apply ff 5)", "A"],
	["$!_ 5", std("$!_ 5"), "(construct $!_ 5)", "A"],
	// undefined-name は名前ごとに1回だけ出す。
	["say say", std("say say"), "(construct say say)", "A", { diag: "say", diagCount: 1 }],
];
const gapRefused = [
	["5 use 5 inc", std("5 use 5 inc"), "G2(b)"],
	["add1 : add 1 の後で 5 add1", std(["add1 : add 1", "5 add1"]), "G8"],
	["5 add inc", std("5 add inc"), "G8"],
	["add inc 1 double 5", std("add inc 1 double 5"), "G2(b)"],
	["double inc 5 6 inc", std("double inc 5 6 inc"), "G12(a)"],
	["pc : use 5 inc の後で pc double 3", std(["pc : use 5 inc", "pc double 3"]), "G2(b)"],
	["add _ 10 5", std("add _ 10 5"), "G5"],
	["g3 : f3 1 の後で g3 _ 3", std(["g3 : f3 1", "g3 _ 3"]), "G5"],
	["add _ inc", std("add _ inc"), "G5"],
	["add _ vs~", std("add _ vs~"), "G5"],
	["_ $!_", std("_ $!_"), "G5"],
	["inc~", std("inc~"), "G7"],
	["[inc double]~", std("[inc double]~"), "G7"],
	["[+ inc] 5", std("[+ inc] 5"), "G7"],
	["[_ +] 5", std("[_ +] 5"), "G5"],
	["[~_] 5", std("[~_] 5"), "G7"],
	["[inc == 2] 5", std("[inc == 2] 5"), "G7"],
	["本体の局所の定義 yy : inc ⏎ yy a", std(["t : a ?", "\tyy : inc", "\tyy a"]), "G7"],
	["本体の括りの局所の定義", std("h : a ? [yy : a] yy"), "G7"],
	["仮引数の重複", std("ff : x x ? x"), "name-duplicate"],
	["括りの中の取り込み", std(["[io@]", "say 5"]), "G7"],
	// 仮置きを取り消す仕組み：gq の本体の根は fq の点なし（L）なので未知。仮置き（A）が残ると `gq 1 inc` が通る。
	["相互再帰：仮置きの取り消し", std(["fq : k ? [+ [gq k]]", "gq : k ? fq k", "gq 1 inc"]), "G2(a)"],
	["相互再帰：依っている答えを戻す", std(["fq : k ? [+ [gq k] * [hq k]]", "gq : k ? fq k", "hq : k ? gq k", "hq 1 inc"]), "G2(a)"],
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
	// 本体の根を先に解くとき（§6.4 の1）は門で止めず、行を解くときに行の順に断る。
	["門は行の順に断る", std(["1 2 inc", "tt : a ? !_"]), "G1"],
];
for (const [name, src, want, kind, extra] of gapPasses) checkPass(`穴 ${name}`, src, want, kind, extra);
for (const [name, src, want] of gapRefused) checkRefused(`穴 ${name}`, src, want);

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
// 実体の深さの守り（resolve.js の INSTANCE_DEPTH_LIMIT の注の1、2026-10-20 の自己点検の SC-1・SC-2）。深さは作る実体の鍵（渡した
// 形）の入れ子の深さで、上限は 32。HB_CHAIN(n) は、素の関数 f0 … f(n−1) が、括りの関数 hb に次の関数を欄で渡す鎖（f(n−1) は
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
const PERM = (n) => {
	const ns = "abcdefg".slice(0, n).split("");
	const rows = (f) => ns.map((x, i) => `${x} : ${f(x, i)}`);
	const block = (rs) => [`[${rs[0]}`, ...rs.slice(1, -1).map((r) => `\t${r}`), `\t${rs[rs.length - 1]}]`];
	const cyc = block(rows((x, i) => ns[(i + 1) % n]));
	const swp = block(rows((x, i) => (i === 0 ? ns[1] : i === 1 ? ns[0] : x)));
	const def = [`r : [${ns.join(" ")}] ? (r ${cyc[0]}`, ...cyc.slice(1, -1), `${cyc[cyc.length - 1]}) , (r ${swp[0]}`, ...swp.slice(1, -1), `${swp[swp.length - 1]})`];
	const call = block(rows((x, i) => PERM_VALS[i]));
	return [...def, `r ${call[0]}`, ...call.slice(1)];
};

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
	["R24 map $[* 2] 1 2 3 4 5 は map $[* 2] [1 2 3 4 5] と同じ実体", src(["map : f [x ~y] ? x", "map $[* 2] 1 2 3 4 5", "map $[* 2] [1 2 3 4 5]"]), "(: map (? [f [x ~y]] (inst A [N…] x)))", null, { at: 0 }],
	["R24 h 1 2 3 inc（残りを受けた節は隣と結べる）", src(["inc : x ? x + 1", "h : v [x ~xs] ? v 1", "h 1 2 3 inc"]), "(apply inc (apply h (construct 1 2 3)) ·rev)", "A"],
	// 前の仮引数が2つ以上でも、左から1つずつ当てる（[a] は 1、[b ~bs] は [2 3]、[c ~cs] は 4 5）。残りを括った
	// `p3 1 [2 3] [4 5]` と同じ実体で、実体は1つ。前の当て方を逆にしたり、前に1つしか当てないと形が変わる。
	["R24 p3 1 [2 3] 4 5 は p3 1 [2 3] [4 5] と同じ実体（前の仮引数に左から1つずつ）", src(["p3 : [a] [b ~bs] [c ~cs] ? a + c", "p3 1 [2 3] 4 5", "p3 1 [2 3] [4 5]"]), "(: p3 (? [[a] [b ~bs] [c ~cs]] (inst N [N…] [N…] (+ a c))))", null, { at: 0 }],
	["R24 p3 1 [2 3] 4 5", src(["p3 : [a] [b ~bs] [c ~cs] ? a + c", "p3 1 [2 3] 4 5"]), "(apply p3 (construct 1 [2 3] 4 5))", "A"],
	// k < n は、素の関数と同じく部分適用（残り n − k の L）。残りが来た所で、当てた物と合わせて実体を作る（R24、利用者
	// 2026-10-19「括りの関数に実引数が足りないときも、素の関数と同じく部分適用（残りの仮引数を待つ関数）にする。」）。
	["R24 pair [1]（k < n は部分適用の L）", src(["pair : [a ~as] [b ~bs] ? a + b", "pair [1]"]), "(apply pair [1])", "L"],
	["R24 pair [1] だけでは実体を作らない", src(["pair : [a ~as] [b ~bs] ? a + b", "pair [1]"]), "(: pair (? [[a ~as] [b ~bs]] (defer {a + b})))", null, { at: 0 }],
	["R24 (pair [1]) [2] は pair [1] [2] と同じ実体", src(["pair : [a ~as] [b ~bs] ? a + b", "(pair [1]) [2]", "pair [1] [2]"]), "(: pair (? [[a ~as] [b ~bs]] (inst N N (+ a b))))", null, { at: 0 }],
	["R24 (pair [1]) [2]", src(["pair : [a ~as] [b ~bs] ? a + b", "(pair [1]) [2]"]), "(apply [pair [1]] [2])", "A"],
	["R24 名前を付けた部分適用 p1 : pair [1] の p1 [2]", src(["pair : [a ~as] [b ~bs] ? a + b", "p1 : pair [1]", "p1 [2]"]), "(apply p1 [2])", "A"],
	["R24 t3 1 2（n = 3 の k < n は部分適用の L）", src(["t3 : u v [~r] ? u", "t3 1 2"]), "(apply t3 (construct 1 2))", "L"],
	["R24 t3 1 2 だけでは実体を作らない", src(["t3 : u v [~r] ? u", "t3 1 2"]), "(: t3 (? [u v [~r]] (defer {u})))", null, { at: 0 }],
	["R24 (t3 1 2) 3 4 は t3 1 2 3 4 と同じ実体（部分適用の残りも最後の括りが受ける）", src(["t3 : u v [~r] ? u", "(t3 1 2) 3 4", "t3 1 2 3 4"]), "(: t3 (? [u v [~r]] (inst A A [N…] u)))", null, { at: 0 }],
	["R24 ((t3 1) 2) [3]（部分適用の部分適用）", src(["t3 : u v [~r] ? u", "((t3 1) 2) [3]"]), "(apply [[t3 1] 2] [3])", "A"],
	["R24 pair [1] inc（部分適用の節は素の関数と同じく合成に入る）", src(["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a + b", "pair [1] inc"]), "(compose (apply pair [1]) inc)", "L"],
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
	// 裸の仮引数に自分の欄を当て直す再帰は、同じ形で自分を呼ぶので有限（数えると、同じ形の実体が 32 段入れ子になって G7）。
	["R24 裸の仮引数に部分適用を当て直す再帰", src(["inc : x ? x + 1", "t2 : u [v] ? v", "g : [f] ? g [f : t2 [f : f]]", "g [f : inc]"]), "(apply g [f : inc])", "A"],
	// 最後の仮引数が裸の k > n は、素の関数と同じく前から n 個を当てて余り（excess）。本体の根が A でなければ G12(b)（R24、
	// 利用者 2026-10-19「最後の仮引数が裸の括りの関数に多く渡したときは、素の関数と同じく前から n 個を当てて、余り（excess）にする。」）。
	["R24 tl 1 2 3（最後の仮引数が裸の k > n は余り）", src(["tl : [x ~xs] y ? x + y", "tl 1 2 3"]), "(apply tl (construct 1 2 3))", "A", { excess: true }],
	["R24 tl 1 2 3 の実体（前から n 個を当てる）", src(["tl : [x ~xs] y ? x + y", "tl 1 2 3"]), "(: tl (? [[x ~xs] y] (inst N A (+ x y))))", null, { at: 0 }],
	["R24 (tl 1) 2 3（部分適用の残りが多い）", src(["tl : [x ~xs] y ? x + y", "(tl 1) 2 3"]), "(apply [tl 1] (construct 2 3))", "A", { excess: true }],
	["R24 (tl 1) 2 3 の実体", src(["tl : [x ~xs] y ? x + y", "(tl 1) 2 3"]), "(: tl (? [[x ~xs] y] (inst N A (+ x y))))", null, { at: 0 }],
	["R24 [tl 1 2 3]（余りの節も括りの中の根なら通る）", src(["tl : [x ~xs] y ? x + y", "[tl 1 2 3]"]), "[tl 1 2 3]", "A"],
	// 当てるのは前から n 個（余りの確かめ 2026-10-19 の TG1・TG2・TG4）。実引数が全部数だと、どこから当てても鍵が `N A` に
	// 揃うので、形の違う実引数で見る。後ろから当てても1つずらしても、`tl [1 2] 3 4` の実体は `N A`、`h 1 [2 3] 4 5` の
	// 実体は `A N A` になる。部分適用は、当てた物（bound）を前に置いて元の関数の実体を作る。
	["R24 tl [1 2] 3 4 の実体（前から n 個）", src(["tl : [x ~xs] y ? x + y", "tl [1 2] 3 4"]), "(: tl (? [[x ~xs] y] (inst [N…] A (+ x y))))", null, { at: 0 }],
	["R24 h 1 [2 3] 4 5 の実体（前から n 個）", src(["h : u [x] v ? u + x + v", "h 1 [2 3] 4 5"]), "(: h (? [u [x] v] (inst A [N…] A (+ (+ u x) v))))", null, { at: 0 }],
	["R24 (tl [1 2]) 3 4 の実体（当てた物が前）", src(["tl : [x ~xs] y ? x + y", "(tl [1 2]) 3 4"]), "(: tl (? [[x ~xs] y] (inst [N…] A (+ x y))))", null, { at: 0 }],
	// k > n なら k の大きさに依らず同じ読み（素の関数の d 1 2 と同じ）。
	["R24 tl 1 2 3 4（k = n + 2 も余り）", src(["tl : [x ~xs] y ? x + y", "tl 1 2 3 4"]), "(apply tl (construct 1 2 3 4))", "A", { excess: true }],
	// k = n の括りの関数の節は余りではないので、逆適用の左に置ける（TG5。excess は k > n だけ）。
	["R24 pair [1] [2] inc（k = n の節は余りでない）", src(["inc : z ? z + 1", "pair : [a ~as] [b ~bs] ? a + b", "pair [1] [2] inc"]), "(apply inc (apply pair (construct [1] [2])) ·rev)", "A", { excess: false }],
	// 括りが1つの関数は、並び全体を1つの List として受ける（R24、利用者 2026-10-19「それでいいよ」）。
	["R24 n 1 2 3 は n [1 2 3] と同じ実体", src(["n : [~x] ? x", "n 1 2 3", "n [1 2 3]"]), "(: n (? [[~x]] (inst [N…] x)))", null, { at: 0 }],
	["R24 f 1 2 3（x は頭の数）", src(["f : [x ~xs] ? x 1", "f 1 2 3"]), "(: f (? [[x ~xs]] (inst [N…] (construct x 1))))", null, { at: 0 }],
	["R24 Zipper の f 1 2 3（pattern_guide）", src(["f : [~a] ? a ' 0 + a ' 2 + a ' 3", "f 1 2 3"]), "(apply f (construct 1 2 3))", "A"],
	["R24 f 1 2 3 inc（並び全体を受けた節は隣と結べる）", src(["inc : x ? x + 1", "f : [x ~xs] ? x 1", "f 1 2 3 inc"]), "(apply inc (apply f (construct 1 2 3)) ·rev)", "A"],
	// 並び全体を受けても、実体の本体の根が A でなければ適用の節は未知（R24。k = n と同じ読みで、G12(b) にしない）。
	["R24 gi 1 2（実体の本体の根が A でなければ未知の根）", src(["gi : [x ~xs] ? inc", "inc : y ? y + 1", "gi 1 2"]), "(apply gi (construct 1 2))", "未知"],
	["R24 gi 1 2 の実体（本体の根は L）", src(["gi : [x ~xs] ? inc", "inc : y ? y + 1", "gi 1 2"]), "(: gi (? [[x ~xs]] (inst [N…] inc)))", null, { at: 0 }],
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
	["R24 map の実体", src(["map : f [x ~y] ? (@f x) , (map f y)", "map $[* 2] [1 2 3 4 5]"]), "(: map (? [f [x ~y]] (inst A [N…] (, [@f x] [map f y]))))", null, { at: 0 }],
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
	["R26 m ' say は L", src([...M, "m ' say"]), "(' m say)", "L", { diagCount: 0 }],
	["R26 [' say] m は L", src([...M, "[' say] m"]), "(apply [' say] m)", "L", { diagCount: 0 }],
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
	["Q24 head inc [5 6 7] double（合成の適用の節は隣と結べる）", src(["inc : x ? x + 1", "double : x ? x * 2", "head : [x ~xs] ? x", "head inc [5 6 7] double"]), "(apply double (apply (compose head inc) [5 6 7]) ·rev)", "A"],
	["Q24 [pair [1]] inc [2]（合成の頭の部分適用）", src(["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a + b", "(pair [1]) inc [2]"]), "(: pair (? [[a ~as] [b ~bs]] (inst N N (+ a b))))", null, { at: 1 }],
	["Q24 inc head [5 6 7]（後ろの括りの関数は前の結果を受ける）", src(["inc : x ? x + 1", "head : [x ~xs] ? x", "inc head [5 6 7]"]), "(: head (? [[x ~xs]] (inst A x)))", null, { at: 1 }],
	["Q24 inc head [5 6 7] の根は未知（head の本体の根が未知）", src(["inc : x ? x + 1", "head : [x ~xs] ? x", "inc head [5 6 7]"]), "(apply (compose inc head) [5 6 7])", "未知"],
	// 合成の後ろの部分適用（§5 Q26 の案1、利用者 2026-10-19「合成の後ろの素の関数の部分適用も、残り1つで本体の根が A なら
	// A に数える。」）。括りの関数の部分適用と同じ読みにする。
	["Q26 inc (pr 1) 5（素の部分適用が合成の後ろ）", src(["inc : x ? x + 1", "pr : x y ? y", "inc (pr 1) 5"]), "(apply (compose inc [pr 1]) 5)", "A"],
	["Q26 inc (pr 1) 5 inc", src(["inc : x ? x + 1", "pr : x y ? y", "inc (pr 1) 5 inc"]), "(apply inc (apply (compose inc [pr 1]) 5) ·rev)", "A"],
	["Q26 名前を付けた部分適用 p1 : pr 1 の inc p1 5 inc", src(["inc : x ? x + 1", "pr : x y ? y", "p1 : pr 1", "inc p1 5 inc"]), "(apply inc (apply (compose inc p1) 5) ·rev)", "A"],
	["Q26 inc (pr [1]) 5（括りの部分適用が合成の後ろ）", src(["inc : x ? x + 1", "pr : [x ~xs] y ? y", "inc (pr [1]) 5"]), "(apply (compose inc [pr [1]]) 5)", "A"],
	["Q26 inc (pr [1]) 5 の実体", src(["inc : x ? x + 1", "pr : [x ~xs] y ? y", "inc (pr [1]) 5"]), "(: pr (? [[x ~xs] y] (inst N A y)))", null, { at: 1 }],
	// 残りが2つ以上の部分適用は、合成の後ろでは今までどおり未知（§5 Q13）。
	["Q26 inc (f3 1) 5（残り2つは未知）", src(["inc : x ? x + 1", "f3 : a b c ? c", "inc (f3 1) 5"]), "(apply (compose inc [f3 1]) 5)", "未知"],
	// 穴の書き換えとその部分適用を後ろに置く形は、Q26 の答えの時は決めずに未知にしていた（利用者の言葉ではなく、表を作った
	// 側の慎重さ）。合成を適用の畳み込みにした（(g∘f) x = g (f x)、R11。2026-10-19「その方向でお願い」）ので、直接書いた
	// `[add _ 10] (inc 5)` と同じく A。穴の部分適用も、同じ関数を穴で直接書いた `[f3 1 _ 3] (inc 5)` と同じ読みで A。
	["法則で変わった inc [add _ 10] 5（穴、前は未知）", src(["inc : x ? x + 1", "add : x y ? x + y", "inc [add _ 10] 5"]), "(apply (compose inc [add _ 10]) 5)", "A"],
	["法則で変わった inc ([f3 _ _ 3] 1) 5（穴の部分適用、前は未知）", src(["inc : x ? x + 1", "f3 : a b c ? c", "inc ([f3 _ _ 3] 1) 5"]), "(apply (compose inc [[f3 _ _ 3] 1]) 5)", "A"],
	["法則で変わった h2 : h1 1（h1 : f3 _ _ 3）の inc h2 5（前は未知）", src(["inc : x ? x + 1", "f3 : a b c ? c", "h1 : f3 _ _ 3", "h2 : h1 1", "inc h2 5"]), "(apply (compose inc h2) 5)", "A"],
	// 前は未知の節で、隣と結べば G2(a) だった。
	["法則で変わった inc [add _ 10] 5 inc（前は G2(a)）", src(["inc : x ? x + 1", "add : x y ? x + y", "inc [add _ 10] 5 inc"]), "(apply inc (apply (compose inc [add _ 10]) 5) ·rev)", "A"],
	["法則で変わった inc ([f3 _ _ 3] 1) 5 inc（前は G2(a)）", src(["inc : x ? x + 1", "f3 : a b c ? c", "inc ([f3 _ _ 3] 1) 5 inc"]), "(apply inc (apply (compose inc [[f3 _ _ 3] 1]) 5) ·rev)", "A"],
	["法則で変わった h2 : h1 1 の inc h2 5 inc（前は G2(a)）", src(["inc : x ? x + 1", "f3 : a b c ? c", "h1 : f3 _ _ 3", "h2 : h1 1", "inc h2 5 inc"]), "(apply inc (apply (compose inc h2) 5) ·rev)", "A"],
	// 穴の本体の根は元の関数のもの。根が A でなければ、直接書いた `[pq _ 1] (inc 5)` と同じく未知のまま。
	["守り inc [pq _ 1] 5（穴の元の関数の根が関数なら未知）", src(["inc : x ? x + 1", "pq : x y ? inc", "inc [pq _ 1] 5"]), "(apply (compose inc [pq _ 1]) 5)", "未知"],
	// 最初の関数が余れば印 `excess`（後ろに素の部分適用があっても落とさない）。確かめ 2026-10-19 の T2。
	["Q26 inc (pr 1) 5 6（excess）", src(["inc : x ? x + 1", "pr : x y ? y", "inc (pr 1) 5 6"]), "(apply (compose inc [pr 1]) (construct 5 6))", "A", { excess: true }],
	// 後ろの関数が2つ以上でも、全部を見る（位置に依らない）。確かめ 2026-10-19 の T3。
	["Q26 inc double (pr 1) 5 inc（後ろの2つ目）", src(["inc : x ? x + 1", "double : x ? x * 2", "pr : x y ? y", "inc double (pr 1) 5 inc"]), "(apply inc (apply (compose inc double [pr 1]) 5) ·rev)", "A"],
	["Q26 inc (pr 1) double 5 inc（後ろの1つ目）", src(["inc : x ? x + 1", "double : x ? x * 2", "pr : x y ? y", "inc (pr 1) double 5 inc"]), "(apply inc (apply (compose inc [pr 1] double) 5) ·rev)", "A"],
	// 元の関数の根が仮置きで決まる再帰の部分適用（§3.4 の再帰の仮置き）。確かめ 2026-10-19 の F3。
	["Q26 自己再帰 r1 : x y ? inc (r1 1) y の r1 1 2", src(["inc : x ? x + 1", "r1 : x y ? inc (r1 1) y", "r1 1 2"]), "(apply r1 (construct 1 2))", "A"],
	["Q26 相互再帰 a1・b1 の a1 1 2", src(["inc : x ? x + 1", "a1 : x y ? inc (b1 1) y", "b1 : x y ? inc (a1 1) y", "a1 1 2"]), "(apply a1 (construct 1 2))", "A"],
	["Q26 名前を通す再帰 p1 : rp 1 の rp 1 2", src(["inc : x ? x + 1", "p1 : rp 1", "rp : x y ? inc p1 y", "rp 1 2"]), "(apply rp (construct 1 2))", "A"],
	["Q26 仮置きが外れる再帰 r2 1 2 は未知", src(["inc : x ? x + 1", "r2 : x y ?", "\tinc (r2 1) y", "\tinc", "", "r2 1 2"]), "(apply r2 (construct 1 2))", "未知"],
	// 合成の後ろの根は、ここまでが A のときだけ引く。使わない根を引くと、仮置き（解いている途中の f）が外れたとき、それに
	// 依らない g の根まで未知に替わり、定義の順で答えが割れていた。どちらの順でも A。確かめ 2026-10-19 の F1（反証）。
	["Q26 g : y ? (adder (f 1) y) , 1（f が先）の g 5 inc", src(["inc : x ? x + 1", "adder : m ? [+ m]", "f : x y ?", "\tg y", "\tinc", "", "g : y ? (adder (f 1) y) , 1", "g 5 inc"]), "(apply inc (apply g 5) ·rev)", "A"],
	["Q26 g : y ? (adder (f 1) y) , 1（g が先）の g 5 inc", src(["inc : x ? x + 1", "adder : m ? [+ m]", "g : y ? (adder (f 1) y) , 1", "f : x y ?", "\tg y", "\tinc", "", "g 5 inc"]), "(apply inc (apply g 5) ·rev)", "A"],
	["Q26 g : y ? (inc [+] f1 y) , 1（f1 が先、素の関数）の g 5 inc", src(["inc : x ? x + 1", "f1 : y ?", "\tg y", "\tinc", "", "g : y ? (inc [+] f1 y) , 1", "g 5 inc"]), "(apply inc (apply g 5) ·rev)", "A"],
	// §5 Q28（2026-10-20、外れた仮置きに頼った答えは未知に替えず、確定した値で解き直す）。並べ方で割れた形は法則の試験
	// （coproduct_laws.test.js の Q28_FORMS）が見る。ここに置くのは、並べ方では割れないのに、前は同じ割れの悪い側に倒れていた
	// 形（どれも前は断るか未知。確かめ 2026-10-20 の並べ替えの確かめで見つかった）。g の根は積なので f の根に依らず A。
	// 値の定義（§6.4 の1 の2：値の名前を先に解く）が f を先に解かせるので、行の順に依らず前は G2(a)。
	["Q28 v : f 1 が f を先に解かせても g の根は積で A", src(["inc : x ? x + 1", "v : f 1", "f : x ?", "\tg x", "\tinc", "", "g : x ? (f x) , 1", "g 5 inc"]), "(apply inc (apply g 5) ·rev)", "A"],
	// 呼ばれない素の関数 f の本体の根を先に解く（§6.4 の1 の3）と、h の実体が輪（h → k → g → h）の頭になって仮置きが外れ、
	// それに頼った g の実体（形 N）の根が未知に替わっていた（f を消すと前も A。呼ばれない定義が、ほかの行の答えを変えていた）。
	["Q28 呼ばれない f : x ? (g x) , 1 があっても g [5] inc は A", src(["inc : x ? x + 1", "f : x ? (g x) , 1", "g : [x ~xs] ? (h [s : k]) , 1", "h : [s] ? s 1", "k : [x ~xs] ? [+ [g x]]", "g [5] inc"]), "(apply inc (apply g [5]) ·rev)", "A"],
	// 合成と、直接書いた入れ子（`inc (f [1 2])`、前も A）が同じ読み（R11）。前は合成の側だけ未知だった。
	["Q28 inc f [1 2] は inc (f [1 2]) と同じく A", src(["inc : x ? x + 1", "h : [s] ? s 1", "f : [x ~xs] ? (h [s : g]) , 1", "g : x ? [+ [f x]]", "inc f [1 2]"]), "(apply (compose inc f) [1 2])", "A"],
	// 実体の深さの守り（SC-1）：素の関数を挟む鎖。hb の形はどれも {s:L}（f1 … はファイルの定義なので深さ 1 の葉）で、深く
	// ならない。前は f0 を先に置くと、f0 → hb の実体 → f1 → … と積んだ枠の hb の実体を全部数え、34 個の関数で 32 段に達して
	// f0 の根が黙って未知になり、`f0 5 inc` が G2(a) だった（逆順なら A。逆順と並べ替えは法則の試験が見る）。
	["深さ 素の関数を挟む hb の 34 個の鎖（f0 が先）", src(["inc : x ? x + 1", ...HB_CHAIN(34), "f0 5 inc"]), "(apply inc (apply f0 5) ·rev)", "A"],
	// 守り：31 段の入れ子の字面（形の深さ 32）は、浅い呼び出しが先でも通る（上限ちょうど）。
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
	// 括りの関数の部分適用の節は、素の関数の部分適用と同じ門に当たる：合成に入って頭になれば G2(b)（`f2 1 g 2` と同じ、
	// §5 Q4）、逆適用の右なら G8（`5 f2 1` と同じ、§5 Q5）。
	["R24 pair [1] inc 5（部分適用を含む合成が頭）", src(["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a + b", "pair [1] inc 5"]), "G2(b)"],
	["R24 5 t3 1 2（部分適用の節が逆適用の右）", src(["t3 : u v [~r] ? u", "5 t3 1 2"]), "G8"],
	// 部分適用で作った実体が門に当たれば、残りを渡して呼んだ行で断る（R25。部分適用の確かめ 2026-10-19 の TG2）。
	["R24 (pair $inc) [2]（部分適用で作った実体の門）", src(["inc : x ? x + 1", "pair : [a ~as] [b ~bs] ? a 1", "(pair $inc) [2]"]), "G7", [["pair", "A N"]]],
	// 当てた物の違う部分適用を欄で渡すと call の実体は別なので、m1 の実体を先に作っても、m2 の行は m2 の形で門に当たる
	// （部分適用の確かめ 2026-10-19 の TG1）。
	["R24 当てた物の違う部分適用を欄で渡す（m2 の実体が門）", src([...PAIR_GATE, "call m1", "call m2"]), "G7", [["call", "{f:L}"], ["pair", "{z:N} N"]]],
	// 1項の `:` の左と既定値は解かない（R25・P3）ので、名前を付けた部分適用を既定値の中で呼ぶ形も、別名（`p : t`）と同じく
	// 実体が作れず G7（部分適用の確かめ 2026-10-19 の TG5）。
	["R25 既定値の中で、名前を付けた部分適用を呼ぶ", src(["pair : [a ~as] [b ~bs] ? a + b", "p1 : pair [1]", "o : [x : p1 [2]] ? 5"]), "G7"],
	// 余りの節は、素の関数と同じく対に入れば G12(a)。本体の根が A でなければ G12(b)（§5 Q11・Q21）。
	["R24 tl 1 2 3 inc（余りの節は対に入れない）", src(["inc : x ? x + 1", "tl : [x ~xs] y ? x + y", "tl 1 2 3 inc"]), "G12(a)"],
	["R24 (tl 1) 2 3 inc（部分適用の余り）", src(["inc : z ? z + 1", "tl : [x ~xs] y ? x + y", "(tl 1) 2 3 inc"]), "G12(a)"],
	["R24 tg 1 2 3（本体の根が関数で k > n）", src(["inc : z ? z + 1", "tg : [x ~xs] y ? inc", "tg 1 2 3"]), "G12(b)"],
	// 部分適用の残りが多いときも同じ（余りの確かめ 2026-10-19 の TG3）。
	["R24 (tg 1) 2 3（部分適用で本体の根が関数、k > n）", src(["inc : z ? z + 1", "tg : [x ~xs] y ? inc", "(tg 1) 2 3"]), "G12(b)"],
	// 並び全体を受けた未知の節も、対に入れば G2(a)（並び全体が実引数1つなので k > n にならず、G12 ではない）。撒く項を
	// 含む並びの未知の節も同じ。
	["R24 gi 1 2 inc（並び全体を受けた未知の節）", src(["gi : [x ~xs] ? inc", "inc : y ? y + 1", "gi 1 2 inc"]), "G2(a)"],
	["R24 n vs~ 1 inc（撒く項を含む並びの未知の節）", src(["inc : y ? y + 1", "n : [~x] ? x", "vs : 1 , 2", "n vs~ 1 inc"]), "G2(a)"],
	// 逆適用と穴は素の関数だけ（括りの関数・分解した名前は通さない）。
	["R12 m a（括りの関数の逆適用）", src([...IO, "m a"]), "G8"],
	["R12 実体の中の 21 say（分解した名前の逆適用）", src([...M, "a3 : [say] ? 21 say", "a3 m"]), "G8", [["a3", "{say:L other:N}"]]],
	["R16 a _（括りの関数の穴）", src([...IO, "a _"]), "G5"],
	// 数でない物は持ち上げない（R24 の「数」は字面と、それに値の印・値の演算子を当てた物だけ）。
	["R26 数から名前の鍵で引く", src(["(5 ' say) 1"]), "G7"],
	// 前置 `!` は数を保たない：`!_` は恒等射（R18）なので、`!(1 < 0)` は関数になりうる。数と読むと `h 5` を黙って構築と読む。
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
	["Q24 bad inc [1 2]（本体の門は呼んだ行で）", src(["inc : x ? x + 1", "bad : [x ~xs] ? 1 _ 2", "bad inc [1 2]"]), "G5", [["bad", "[N…]"]]],
	["Q24 tg inc 1 2 3（本体の根が関数で k > n）", src(["inc : x ? x + 1", "tg : [x ~xs] y ? inc", "tg inc 1 2 3"]), "G12(b)"],
	["Q24 inc h2 [5 6 7]（後ろの括りの関数の名前は未知）", src(["inc : x ? x + 1", "h2 : [x ~xs] ? x 1", "inc h2 [5 6 7]"]), "G7", [["h2", "A"]]],
	// 合成の後ろの部分適用でも、本体の根が A でなければ A に数えない（Q26 は根が A のときだけ）。
	["Q26 inc (pq 1) 5 inc（本体の根が関数の部分適用）", src(["inc : x ? x + 1", "pq : x y ? inc", "inc (pq 1) 5 inc"]), "G2(a)"],
	// 後ろの部分適用の後ろに根が A でない部分適用があれば未知（後ろの全部を見る）。確かめ 2026-10-19 の T3。
	["Q26 inc (pr 1) (pq 1) 5 inc", src(["inc : x ? x + 1", "pr : x y ? y", "pq : x y ? inc", "inc (pr 1) (pq 1) 5 inc"]), "G2(a)"],
	// 余りの印は後ろに素の部分適用があっても残る（G12(a)）。確かめ 2026-10-19 の T2。
	["Q26 inc (pr 1) 5 6 inc（excess の隣）", src(["inc : x ? x + 1", "pr : x y ? y", "inc (pr 1) 5 6 inc"]), "G12(a)"],
	// 穴と穴の部分適用の `… 5 inc` は、合成を適用の畳み込みにして通る側（上の「法則で変わった」の行）へ移した。
	// 仮置きが外れる再帰の部分適用は未知、隣と結べば G2(a)。確かめ 2026-10-19 の F3。
	["Q26 仮置きが外れる再帰 r2 1 2 inc", src(["inc : x ? x + 1", "r2 : x y ?", "\tinc (r2 1) y", "\tinc", "", "r2 1 2 inc"]), "G2(a)"],
	// 形が枝ごとに増える再帰は、深さ 32 以内でも実体が 2^深さ になる。同じ関数の実体の総数の上限（§5 Q25 の実装の守り）で、
	// 止まらずに G7 で断る（上限が無いと解決が止まらなかった。確かめ 2026-10-20）。どの実体も仮置きに頼らずに作るので、確定した
	// 実体の数（resolve.js の INSTANCE_DEPTH_LIMIT の注の2）が上限を超える。
	["Q25 枝ごとに形が増える再帰（合成の頭の引き）", src(["g : [x ~xs] ? ([' 0] g [[a : xs] [a : xs]]) , ([' 0] g [[b : xs] [b : xs]])", "g [1 2]"]), "G7"],
	["Q25 枝ごとに形が増える再帰（直接）", src(["g : [x ~xs] ? (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])", "g [1 2]"]), "G7"],
	// 同じ形で自分を引いてから枝ごとに形が増える再帰：後ろの実体はどれも g の仮置きに頼って作るので、確定した実体には数え
	// ない。止まるための上限（作った実体の全部、INSTANCE_DEPTH_LIMIT の注の3）で G7。
	["Q25 同じ形で自分を引いてから枝ごとに形が増える再帰", src(["g : [x ~xs] ? (g xs) , (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])", "g [1 2]"]), "G7"],
	// 欄の並べ替え（輪と入れ替え）で形が深くならないまま、同じ関数の実体が長く入れ子になる再帰（欄 7 つで 5040 通り）。
	// 止まるための上限は、同じ関数の入れ子の数も抑える（JS のスタックが溢れない。INSTANCE_DEPTH_LIMIT の注の3）。前の深さの
	// 守り（同じ `?` の実体の入れ子 32）を外した後、この上限が無いと内部の例外（スタックの溢れ）だった（2026-10-20）。
	["Q25 欄 7 つの並べ替えの再帰（止まるための上限）", src(PERM(7)), "G7"],
	// §5 Q28 の解き直し（2026-10-20）で、外れた仮置きに頼った答えに古いと印を付ける所（resolve.js の「仮置きの記録」の注）。
	// どれも、印が欠けると、この並べ方で呼ぶ行が黙って A になる（確かめ 2026-10-20）。ほかの並べ方でも同じ答えなのは、法則の
	// 試験（coproduct_laws.test.js の Q28_REFUSE_FORMS）が見る。値の定義の記録の行は、値を含む輪なので、§5 Q30（2026-10-20）
	// から name-cycle で断る。
	// 注の2（F1）：当たった枠の名簿の答えは、その枠が頼った仮置きを引き継ぐ。h のブロックの最後の行 `inc` は L なので h は
	// 未知、f の行 `h x` も未知なので f も未知、g = f x も未知。
	["Q28 外れた仮置きの上で閉じた枠に頼る（h → f → g）", src(["inc : x ? x + 1", "h : x ?", "\tf x", "\tinc", "", "f : x ?", "\tg x", "\th x", "", "g : x ? f x", "g 5 inc"]), "G2(a)"],
	["Q28 外れた仮置きの上で閉じた枠に頼る（括りの関数の実体）", src(["inc : x ? x + 1", "hb : [s] ? s 1", "f : x ?", "\tinc", "\tk x", "", "k : x ?", "\tf x", "\thb [s : k]", "", "hb [s : k] inc"]), "G2(a)"],
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
	// 実体の深さの守り（SC-2）：33 段の入れ子の字面（形の深さ 34）は、浅い呼び出し a2 を先に置いても後に置いても、b の右辺の
	// 最初の呼び出しで G7 になり、その p の実体（を作ろうとした形）を名指しする。前は実体の入れ子を数えたので、a2 が先なら、下の
	// 実体の記録を引いて段を少なく数えて A、後なら b の種類の計算で守りに当たった実体が未知のまま記録に残り、木を残す段は記録を
	// 辿るだけで当たり直さず、b が黙って未知だった。32 段（形の深さ 33）は、前は b が先なら G7、a2 が先なら A に割れた。
	["深さ 33 段の入れ子の字面（浅い呼び出しが先）", src(["p : [a] ? p a", "a2 : p [a : 1]", `b : p ${NEST(33)}`, "a2", "b"]), "G7", [["p", NEST_SHAPE(33)]]],
	["深さ 33 段の入れ子の字面（浅い呼び出しが後）", src(["p : [a] ? p a", `b : p ${NEST(33)}`, "a2 : p [a : 1]", "a2", "b"]), "G7", [["p", NEST_SHAPE(33)]]],
	["深さ 32 段の入れ子の字面（浅い呼び出しが先）", src(["p : [a] ? p a", "a2 : p [a : 1]", `b : p ${NEST(32)}`, "b"]), "G7", [["p", NEST_SHAPE(32)]]],
	// 守りに当たった b を隣と結ぶ行が先にあっても、別の言い分（前は `b inc` の「種類の決まらない項 `b`」の G7 で、名指し
	// 無し）に化けない。値の定義 b の種類を引くと、b の右辺の呼び出しが同じ鍵の門に当たる（値の定義は門を捕まえない）。
	["深さ 33 段の入れ子の字面（先に b inc）", src(["inc : x ? x + 1", "p : [a] ? p a", "b inc", `b : p ${NEST(33)}`, "a2 : p [a : 1]"]), "G7", [["p", NEST_SHAPE(33)]]],
	// 輪と入れ子の鎖の 32 段（形の深さ 33）は、cc を先に置いても後に置いても、bb の右辺の最初の呼び出しで G7。前の守りでは
	// 31 段で、いちばん長い道（33 個）で数えていた。
	["深さ 輪と入れ子の鎖の 32 段（浅い呼び出しが後）", src([...ROT, ...ROT_DEF("bb", 32), ...ROT_DEF("cc", 15), "bb"]), "G7", [["r", ROT_SHAPE(32)]]],
	["深さ 輪と入れ子の鎖の 32 段（浅い呼び出しが先）", src([...ROT, ...ROT_DEF("cc", 15), ...ROT_DEF("bb", 32), "bb"]), "G7", [["r", ROT_SHAPE(32)]]],
	// 鍵の深さは、閉包が書いた所の実体の鍵まで見る（resolve.js の fnDepth）。形の綴りはどれも {s:L} だが、欄に入れた関数は
	// 書いた所（前の実体の中）の鍵を持つので、鍵は1段ずつ深くなる。数えないと、どれも止まらなかった（綴りが同じでも鍵は違う）。
	["深さ 閉包が前の実体の中で書かれる再帰（素の関数）", src(["inc : x ? x + 1", "f : [s] ? f [s : [y ? s y]]", "f [s : inc]"]), "G7"],
	["深さ 閉包が前の実体の中で書かれる再帰（括りの関数）", src(["inc : x ? x + 1", "f : [s] ? f [s : [[x] ? s x]]", "f [s : inc]"]), "G7"],
	["深さ 部分適用に前の欄を当てる再帰", src(["inc : x ? x + 1", "pp : [a] [b] ? 1", "f : [s] ? f [s : pp [s : s]]", "f [s : inc]"]), "G7"],
	// 再帰でなくても、渡した形が 32 段を超えれば断る（守りは鍵の深さだけで決まる。書いた入れ子の深い形を受ける関数は、通る形と
	// 区別しない）。
	["深さ 再帰でない関数に 32 段の入れ子の字面", src(["k : [a] ? 1", `k ${NEST(32)}`]), "G7", [["k", NEST_SHAPE(32)]]],
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
law("[' k] x と x ' k は同じ種類", () => {
	const pairs = [
		[std("[' 0] vs"), std("vs ' 0"), "A"],
		[std("[' 0] fs"), std("fs ' 0"), "未知"],
		[src([...M, "[' say] m"]), src([...M, "m ' say"]), "L"],
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
// 本体の根が点なし（L）なので、`say 21` は未知になる。m の実体を先に作っても、m3 の答えが m の答えに化けない。
law("本体の根が違う関数は別の実体", () => {
	const M3 = ["m3 :", "\tsay : x ? [+ x]", "\tother : 1", ""];
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
const AF1 = ["g : [say] ? say 1", "f : [x ~xs] ? [z ? hh1 z]"];
const AF1_HH1 = "hh1 : y ? (g [say : [w ? f [1 2]]]) y";
const AF1_KK = "kk : y ? f [1 2]";

const checkPasses = [
	// 直した（F1・F5）：実体の深さの門は、同じ `?` の実体の入れ子だけを数える。別々の関数の 33 段・40 段の鎖は有限で通る。
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
	// 2項以上の条件は今までどおり解くので、実体の本体の門（G1）で名指しする。
	["守り 2項の条件は実体を作る", src(["inc : x ? x + 1", "t : [a ~r] ? 5 inc 3 inc", "u : x ?", "\tt [1 2] : 1", "\t2", ""]), "G1", [["t", "[N…]"]]],
	// 直した（反証 F1）：無名の素の関数の本体の根が、外の関数の仮置きの上で決まり、欄として別の実体へ渡っても、仮置きが
	// 外れたら直る。行の順（kk と hh1）に依らず hh1 の行で G7。
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
// 実体の深さの守りを鍵の深さにした（2026-10-20、resolve.js の INSTANCE_DEPTH_LIMIT の注の1）後は、書いた 24 段の鎖も、h に
// 渡す鍵の深さが 52 段（q の1段ごとに部分適用と欄で2段）なので、最初の呼び出しで G7 になる。鍵を作る手間は、その深さを
// 数える所まで（鍵を番号に寄せる所）で見る。h の実体が1つになることは、上限の内の 14 段（鍵の深さ 32）で見る。
const ppChain = (n) => {
	const ls = ["inc : x ? x + 1", "pp : [a] [b] [c] ? a", "q0 : pp [f : inc] [f : inc]"];
	for (let i = 1; i <= n; i++) ls.push(`q${i} : pp [f : q${i - 1}] [f : q${i - 1}]`);
	ls.push("h : [f] ? f [1]", `h [f : q${n}]`);
	return src(ls);
};
law("部分適用を当てた部分適用の鎖の鍵は速い", () => {
	const out = [];
	let t0 = Date.now();
	let deep = "通った";
	try {
		resolve(ppChain(24));
	} catch (e) {
		deep = `${e.reason} ${e.gate || ""}`;
	}
	const ms1 = Date.now() - t0;
	if (ms1 > 5000) out.push(`部分適用の鎖の深さ 24：${ms1}ms`);
	if (deep !== "coproduct-unknown-kind G7") out.push(`部分適用の鎖の深さ 24 got: ${deep}  want: G7`);
	const r = resolve(ppChain(14));
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
// 部分適用の鎖と同じく、書いた 24 段の鎖は h に渡す鍵の深さが 75 段（1段ごとに合成・部分適用・欄で3段）なので G7。h の実体が
// 1つになることは、上限の内の 9 段（鍵の深さ 30）で見る。
const ccChain = (n) => {
	const ls = ["inc : x ? x + 1", "pp : [a] [b] [c] ? a", "c0 : inc inc"];
	for (let i = 1; i <= n; i++) ls.push(`q${i} : pp [f : c${i - 1}] [f : c${i - 1}]`, `c${i} : q${i} q${i}`);
	ls.push("h : [f] ? f [1]", `h [f : c${n}]`);
	return src(ls);
};
law("合成を当てた部分適用の鎖の鍵は速い", () => {
	const out = [];
	let t0 = Date.now();
	let deep = "通った";
	try {
		resolve(ccChain(24));
	} catch (e) {
		deep = `${e.reason} ${e.gate || ""}`;
	}
	const ms1 = Date.now() - t0;
	if (ms1 > 5000) out.push(`合成を当てた部分適用の鎖の深さ 24：${ms1}ms`);
	if (deep !== "coproduct-unknown-kind G7") out.push(`合成を当てた部分適用の鎖の深さ 24 got: ${deep}  want: G7`);
	const r = resolve(ccChain(9));
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
// 合成の鍵は、足りない適用の節を含むか（partial）でも分かれる。分けないと、括りの部分適用 `[add 1]` で始まる合成の実体を
// 先に作った行の後で、`add 1 inc`（足りない適用の節を含む）を渡した行が黙って通る（直す前の鍵も分けていたが、落ちる試験が
// 無かった。変異で確かめた）。
checkRefused(
	"確かめ 守り 合成の鍵は足りない適用の印で分かれる",
	src(["inc : x ? x + 1", "add : x y ? x + y", "k : [f] ? f 1", "k [f : [add 1] inc]", "k [f : add 1 inc]"]),
	"G2(b)",
	[["k", "{f:L}"]]
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
//
// 穴：変異で壊しても落ちなかった所（途中で未知になった後の括りの関数・合成の頭の括りの関数の根が A でない k = n・
// k > n・足りない・後ろの括りの関数のアリティが2以上）。

const PA = "pa : [x ~xs] ? [+ x]"; // 実体の根が L（未知）
const HL = "hl : [x ~xs] ? inc"; // 実体の根が L（未知）
const BAD = "bad : [y ~ys] ? 1 _ 2";
const TL = "tl : [y ~ys] ? ys";
const TR = "tr : [x ~xs] ? xs 1";
const INC = "inc : x ? x + 1";
const DOUBLE = "double : x ? x * 2";
const ADDER = "adder : m ? [+ m]"; // 本体の根が L（§5 Q21）

const composePasses = [
	["直した pa tl [1 2] の根は未知", src([PA, TL, "pa tl [1 2]"]), "(apply (compose pa tl) [1 2])", "未知"],
	["直した pa tl [1 2] の tl は未知を受けて実体を作る", src([PA, TL, "pa tl [1 2]"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 1 }],
	["直した adder tl 1 の tl は未知を受けて実体を作る", src([ADDER, TL, "adder tl 1"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 1 }],
	["穴 inc adder tl 1（途中で未知になった後の括りの関数は未知を受ける）", src([INC, ADDER, TL, "inc adder tl 1"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 2 }],
	["穴 inc adder tl 1 の根は未知", src([INC, ADDER, TL, "inc adder tl 1"]), "(apply (compose inc adder tl) 1)", "未知"],
	["穴 pu inc [1]（合成の頭の括りの関数の実体の根が A でない k = n）", src([INC, "pu : [x ~xs] ? [+ x]", "pu inc [1]"]), "(apply (compose pu inc) [1])", "未知"],
	["穴 pr inc [1] 2 3（合成の頭の最後の仮引数が裸の k > n は余り）", src([INC, "pr : [x ~xs] y ? y", "pr inc [1] 2 3"]), "(apply (compose pr inc) (construct [1] 2 3))", "A", { excess: true }],
	["穴 head inc 5 6 7 double（合成の頭の最後の括りが残りを受ける）", src([INC, DOUBLE, "head : [x ~xs] ? x", "head inc 5 6 7 double"]), "(apply double (apply (compose head inc) (construct 5 6 7)) ·rev)", "A"],
	["穴 pair inc [1]（合成の頭の括りの関数に足りない）", src([INC, "pair : [a ~as] [b ~bs] ? a + b", "pair inc [1]"]), "(apply (compose pair inc) [1])", "L"],
	["穴 inc pb [1]（後ろの括りの関数のアリティが2）の根は未知", src([INC, "pb : [a] [b] ? 1 _ 2", "inc pb [1]"]), "(apply (compose inc pb) [1])", "未知"],
	["穴 inc pb [1] の pb は呼ばれないので defer", src([INC, "pb : [a] [b] ? 1 _ 2", "inc pb [1]"]), "(: pb (? [[a] [b]] (defer {1 _ 2})))", null, { at: 1 }],
	["穴 inc pair [1]（後ろの括りの関数のアリティが2、Q13）", src([INC, "pair : [a ~as] [b ~bs] ? a + b", "inc pair [1]"]), "(apply (compose inc pair) [1])", "未知"],
	// 最初の関数に足りたか決まらない（`[+]` に1項、§5 Q17）。前は「後ろが呼ばれるかも決まらない」として実体を作らず、
	// この行を「今は defer」として置いていた（§5 Q27）。合成を適用の畳み込みにして裏返した：後ろの括りの関数は未知を受ける。
	["Q27 で裏返した [+] tl 5 の tl は未知を受けて実体を作る（前は defer）", src([TL, "[+] tl 5"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 0 }],
	["Q27 [+] tl 5 の根は未知のまま", src([TL, "[+] tl 5"]), "(apply (compose [+] tl) 5)", "未知"],
	// ほかの足りたか決まらない頭も同じ：アリティの分からない点なし（`[|]`・`[*]`）・既定値のある関数（Q8）・撒く項を含む並び
	// （k を数えない）。撒く項は、合成も最初の関数への適用から畳む（applyKind の頭）ので、前は合成ごと未知で返していた。
	["Q27 [|] tl 5 の tl は未知を受けて実体を作る", src([TL, "[|] tl 5"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 0 }],
	["Q27 [*] tl 2 3 の tl は未知を受けて実体を作る", src([TL, "[*] tl 2 3"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 0 }],
	["Q27 go tl xs（既定値のある関数）の tl は未知を受けて実体を作る", src([...GO_DEFAULT, TL, "go tl xs"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 2 }],
	["Q27 inc tl vs~（撒く項）の tl は未知を受けて実体を作る", src([INC, "vs : 1 , 2", TL, "inc tl vs~"]), "(: tl (? [[y ~ys]] (inst U ys)))", null, { at: 2 }],
	["Q27 inc tl vs~ の根は未知のまま", src([INC, "vs : 1 , 2", TL, "inc tl vs~"]), "(apply (compose inc tl) vs~)", "未知"],
	// 今は：撒く項を受ける最初の関数そのものが括りの関数なら、実体を作らない（R24「撒く項があれば k は数えない（未知）」。
	// 合成でない頭の「R24 n 4 vs~ 5 では実体を作らない」と同じ）。だから `bad inc vs~` は bad の本体を読まずに通り、後ろに
	// 置いた `inc bad vs~` は未知を受けた bad の実体で G5（下の composeRefused の Q27 の行）。Q27 が問題にした非対称（頭に
	// 置くだけで本体の門をすり抜ける）が、撒く項を受ける括りの関数に残っている。撒く項を受けた括りの関数の当て方（どの
	// 仮引数に何が入るか）は k が数えられないので決まらず、未知を受けて作るか・名指しの門で断るかは決めていない（§5 の未決、
	// 合成の畳み込みの確かめの F3）。決まったら、この2行を裏返す。
	["今は bad inc vs~（撒く項を受ける最初の括りの関数）は実体を作らない", src([INC, "vs : 1 , 2", BAD, "bad inc vs~"]), "(: bad (? [[y ~ys]] (defer {1 _ 2})))", null, { at: 2 }],
	["今は bad 1 vs~（合成でない頭）も実体を作らない", src(["vs : 1 , 2", BAD, "bad 1 vs~"]), "(: bad (? [[y ~ys]] (defer {1 _ 2})))", null, { at: 1 }],
	// 後ろに素の関数だけなら、根を引かずに未知のまま（Q28）。
	["守り [+] inc 5（後ろが素の関数なら未知のまま）", src([INC, "[+] inc 5"]), "(apply (compose [+] inc) 5)", "未知"],
];
const composeRefused = [
	["直した pa bad [1 2]（頭の括りの関数の実体の根が L）", src([PA, BAD, "pa bad [1 2]"]), "G5", [["bad", "U"]]],
	["直した hl bad [1 2]（頭の括りの関数の実体の根が L）", src([INC, HL, BAD, "hl bad [1 2]"]), "G5", [["bad", "U"]]],
	["直した adder bad 1（頭の素の関数の本体の根が L、k = n）", src([ADDER, BAD, "adder bad 1"]), "G5", [["bad", "U"]]],
	["直した 5 adder bad（逆適用の右の合成）", src([ADDER, BAD, "5 adder bad"]), "G5", [["bad", "U"]]],
	["直した t : y ? adder bad y（素の関数の本体の中）", src([ADDER, BAD, "t : y ? adder bad y"]), "G5", [["bad", "U"]]],
	["直した [' 0] bad fs（頭が段18 の点なしに1項）", src([INC, DOUBLE, "fs : inc , double", BAD, "[' 0] bad fs"]), "G5", [["bad", "U"]]],
	["穴 inc adder tr 1（途中で未知になった後の括りの関数は未知を受ける）", src([INC, ADDER, TR, "inc adder tr 1"]), "G7", [["tr", "U"]]],
	["穴 pu inc [1] double（合成の頭の括りの関数の実体の根が A でない節が対に入る）", src([INC, DOUBLE, "pu : [x ~xs] ? [+ x]", "pu inc [1] double"]), "G2(a)"],
	["穴 pr inc [1] 2 3 double（合成の頭の余りが対に入る）", src([INC, DOUBLE, "pr : [x ~xs] y ? y", "pr inc [1] 2 3 double"]), "G12(a)"],
	["穴 pair inc [1] double 5（足りない合成が適用の頭）", src([INC, DOUBLE, "pair : [a ~as] [b ~bs] ? a + b", "pair inc [1] double 5"]), "G2(b)"],
	// 足りたか決まらない頭でも、後ろの括りの関数は未知を受けて実体を作る（§5 Q27。前は実体を作らずに通していた）。
	["Q27 で裏返した [+] bad 5（前は通っていた）", src([BAD, "[+] bad 5"]), "G5", [["bad", "U"]]],
	["Q27 go bad xs（既定値のある関数、前は通っていた）", src([...GO_DEFAULT, BAD, "go bad xs"]), "G5", [["bad", "U"]]],
	["Q27 inc bad vs~（撒く項、前は通っていた）", src([INC, "vs : 1 , 2", BAD, "inc bad vs~"]), "G5", [["bad", "U"]]],
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
		["adder", [ADDER], "1"],
		["[' 0]", [DOUBLE, "fs : inc , double"], "fs"],
		// 足りたか決まらない頭（§5 Q27。合成を適用の畳み込みにして、ほかの頭と同じになった）。
		["[+]", [], "5"],
		["[|]", [], "5"],
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
	"pq : x y ? inc",
	"f3 : a b c ? c",
	ADDER,
	"head : [x ~xs] ? x",
	TL,
	BAD,
	"pb : [a] [b] ? a + b",
	"pt : [a ~as] y ? y",
];
const foldPasses = [
	["Q13 で変わった inc [+ 1] 5（後ろの非貪欲の単項、前は未知）", src([INC, "inc [+ 1] 5"]), "(apply (compose inc [+ 1]) 5)", "A"],
	["Q13 で変わった inc [+ 1] 5 inc（前は G2(a)）", src([INC, "inc [+ 1] 5 inc"]), "(apply inc (apply (compose inc [+ 1]) 5) ·rev)", "A"],
	["Q13 で変わった inc [-_] 5（前置の点なしの単項）", src([INC, "inc [-_] 5"]), "(apply (compose inc [-_]) 5)", "A"],
	["Q13 で変わった inc [+ 1] 5 6（余りの印は最初の関数から）", src([INC, "inc [+ 1] 5 6"]), "(apply (compose inc [+ 1]) (construct 5 6))", "A", { excess: true }],
	["守り inc [+] 5（後ろの [+] に1項は未知のまま、Q17）", src([INC, "inc [+] 5"]), "(apply (compose inc [+]) 5)", "未知"],
	["R26 で変わった [' 0] inc [1 2 3]（最初が段18 の点なし、前は未知）", src([INC, "[' 0] inc [1 2 3]"]), "(apply (compose [' 0] inc) [1 2 3])", "A"],
	["R26 で変わった [' 0] inc [1 2 3] double（前は G2(a)）", src([INC, DOUBLE, "[' 0] inc [1 2 3] double"]), "(apply double (apply (compose [' 0] inc) [1 2 3]) ·rev)", "A"],
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
	["R26 で変わった [' 0] inc [1 2 3] head（前は G2(a)、今は逆適用の右の括りの関数で G8）", src([INC, "head : [x ~xs] ? x", "[' 0] inc [1 2 3] head"]), "G8"],
];
for (const [name, s, want, kind, extra] of foldPasses) checkPass(`合成 ${name}`, s, want, kind, extra);
for (const [name, s, want, inst] of foldRefused) checkRefused(`合成 ${name}`, s, want, inst);

// 合成は適用の繰り返し：f x が A なら、`f g x` と直接書いた `g (f x)` は、根が A かどうかと、定義の行の木（括りの関数の
// 実体）と、断るなら門と名指しが同じ。後ろが2つの `f g h x` と `h (g (f x))` も、g (f x) が A なら同じ。前の実装では、後ろの
// 非貪欲の単項・穴・最初の `[' k]` で割れていた。g (f x) が足りない適用（L）のとき、合成は未知にする（関数を値として次へ
// 渡す読みは決めていない）ので、比べるのは A かどうかだけにする。
law("合成は適用の繰り返し：f g x と g (f x) は同じ読み", () => {
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
	const FIRSTS = [
		["inc", "5"],
		["inc", "5 6"],
		["[+ 1]", "5"],
		["[* 2,]", "1 2 3"],
		["[+]", "5 6"],
		["(pr 1)", "5"],
		["[add _ 10]", "5"],
		["head", "[5 6 7]"],
		["head", "5 6 7"],
		["[' 0]", "[1 2 3]"],
		["[' 0]", "[[1 2] [3 4]]"],
		["pt", "[1] 2"],
	];
	const LATER = ["inc", "double", "[+ 1]", "[-_]", "[* 2,]", "[+]", "add", "adder", "pq", "(pr 1)", "(pq 1)", "[add _ 10]", "([f3 _ _ 3] 1)", "head", "tl", "bad", "pb", "(pt [1])", "[' 0]"];
	const LATER2 = ["inc", "[+ 1]", "(pr 1)", "[add _ 10]", "head", "tl", "bad", "[' 0]"];
	const out = [];
	let nA = 0;
	let nNotA = 0;
	let nRefused = 0;
	const check = (composed, direct) => {
		const c = look(src([...FOLD_DEFS, composed]));
		const d = look(src([...FOLD_DEFS, direct]));
		if (!same(c, d)) out.push(composed, `  合成: ${JSON.stringify(c)}`, `  直接: ${JSON.stringify(d)}`);
		if (c.refused) nRefused++;
		else if (c.a) nA++;
		else nNotA++;
	};
	for (const [f, x] of FIRSTS) {
		if (!isA(`${f} ${x}`)) {
			out.push(`前提が崩れた：${f} ${x} が A でない`);
			continue;
		}
		for (const g of LATER) {
			check(`${f} ${g} ${x}`, `${g} (${f} ${x})`);
			if (!LATER2.includes(g) || !isA(`${g} (${f} ${x})`)) continue;
			for (const h of LATER2) check(`${f} ${g} ${h} ${x}`, `${h} (${g} (${f} ${x}))`);
		}
	}
	// 比べる組が全部同じ読みなら、法則は何も見ていない。
	if (!nA || !nNotA || !nRefused) out.push(`A ${nA}・A でない ${nNotA}・断る ${nRefused}（どれも1つ以上のはず）`);
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
	["未知で閉じた関数の記録を通る輪（門で未知）", [["a : g 1"], ["g : x ?", "\tk x", "\tvk", ""], ["k : x ?", "\tg x", "\t1 _ 2", ""], ["vk : k 1"]], ["`vk`", "`k` の本体", "`g` の本体"]],
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
	["既定値を覗いた定義の中だけで閉じる輪", [["a : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["v : h 1"], ["h : x ?", "\tk x", "\tvk", ""], ["k : x ?", "\th x", "\t1 _ 2", ""], ["vk : k 1"]], ["`vk`", "`k` の本体", "`h` の本体"]],
	// 覗いた v の中で、h の行 `g x` が覗いた所を通る輪（h → g → 覗き → v）で抜ける。k は h を読んで未知で閉じた記録として残るので、
	// 例外で抜けた h の枠を輪の依りに持つ記録に古いと印を付けないと、a が先なら、vk が k の記録を読んでも h を通ったことが
	// 見えず、黙って通った（resolve.js の「値を含む輪」の注の、例外で抜けた枠）。
	["既定値の覗きが抜けた後の記録を通る輪", [["a : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["v : h 1"], ["h : x ?", "\tk x", "\tg x", "\tvk", ""], ["k : x ?", "\th x", "\t1 _ 2", ""], ["vk : k 1"]], ["`vk`", "`k` の本体", "`h` の本体"]],
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

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
