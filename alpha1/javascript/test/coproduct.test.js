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
// 最後の行の木。body なら `(: t (? […] 本体))` の本体。
const lastTree = (r, body) => {
	const t = r.trees[r.trees.length - 1];
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
	["map $[* 2] 1 2 3 4 5（未知の根）", std("map $[* 2] 1 2 3 4 5"), "(apply map (construct $[* 2] 1 2 3 4 5))", "未知"],
	["n 1 2 3（未知の根）", std("n 1 2 3"), "(apply n (construct 1 2 3))", "未知"],
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
	["f : [x ~xs] ? [f xs] x の本体", "f : [x ~xs] ? [f xs] x", "G7"],
	["hello : [say] ? say Hello World の本体", std("hello : [say] ? say Hello World"), "G7"],
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

// 通る行を確かめる。extra：body（本体の木を見る）・excess・diag（undefined-name が出る名前）・
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
	const t = lastTree(r, extra.body);
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
const checkRefused = (name, src, want) => {
	total++;
	try {
		const r = resolve(src);
		fail(name, `断るはずが通った: ${show(r.trees[r.trees.length - 1])}`);
	} catch (e) {
		const isName = !/^G/.test(want);
		const wantReason = isName ? want : GATE_REASON[want.replace(/\(.\)$/, "")];
		if (e.reason === wantReason && (isName || e.gate === want)) ok(`${name} → ${want}`);
		else fail(name, `got: ${e.reason} ${e.gate || ""}  want: ${wantReason} ${isName ? "" : want}`, e.message);
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
	// 段18 の点なしは、引いた物の種類が決まらない（§2 Q1）ので、適用は未知。
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

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
