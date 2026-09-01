/**
 * **返す器の大きさの上界を、引数から求める**（pass4.js の `returnSizeBound`）。
 *
 * 正確な個数は実行時に決まるが、**上界は静的に書ける**ことが多い——`d st~` は
 * `1 + ||st||` である。スロットは上界で足りるので、これが分かれば呼び出し側が場所を
 * 用意できる（sret）。「実行時にしか決まらない」で止まらず**上界を疑う**のが要で、
 * 個数と上界は別の問いである。
 *
 * **ただしまだ sret には使えない。** 下の最後の節がその理由で、仮引数の型が値より狭く
 * 出ることがあり、そのまま信じるとスロットが小さすぎる。
 *
 * 実行: node test/size_bound.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import { returnSizeBound } from "../pass4.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "../interpreter.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const parser = peggy.generate(fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8"));

let passed = 0;
let total = 0;
function check(note, got, want) {
	total++;
	const ok = JSON.stringify(got) === JSON.stringify(want);
	if (ok) passed++;
	console.log(`${ok ? "OK  " : "FAIL"} ${note}`);
	if (!ok) console.log(`     got:  ${JSON.stringify(got)}\n     want: ${JSON.stringify(want)}`);
}
function checkTrue(note, cond, extra) {
	check(note, !!cond, true);
	if (!cond && extra) console.log(`     ${extra}`);
}
// `f` の返値の上界を `k` か `k + ||p||` の形で返す。
function bound(src) {
	const { nodes } = compile(src, { charset: "ascii" });
	const d = nodes.find((n) => n.name === "define" && String(n.left.value).replace(/[<>]/g, "") === "f");
	const b = returnSizeBound(d.right, "f");
	if (!b) return null;
	// **上界は器ごとの項の和である**（`konst + Σ coef_i × ||器_i||`）。1項なら今まで通りの
	// 見た目になる——`walk` のように2つの器を同時に食う形が書けるようになっただけである。
	if (!b.terms || b.terms.length === 0) return String(b.konst);
	const parts = b.terms.map((t) => `${t.coef === 1 ? "" : `${t.coef} × `}||${String(t.sizeOf).replace(/[<>]/g, "")}||`);
	return `${b.konst} + ${parts.join(" + ")}`;
}
function value(src) {
	const { nodes } = compile(src, { parse: parser.parse });
	const env = newRuntimeEnv(null);
	let r = UNIT;
	for (const n of nodes) r = evaluate(n, env);
	return isUnit(r) ? "__" : JSON.stringify(observe(r));
}

// ---- スカラーだけを並べるなら定数 ----
check("2つ並べる", bound("f : a b ? a b\nf 1 2"), "2");
check("3つ並べる", bound("f : a b c ? a b c\nf 1 2 3"), "3");
// `__` を返す枝は 0 要素なので、上界には効かない。
check("__ の枝は数えない", bound("f : a b ?\n\ta > 1 : __\n\ta b\nf 1 2"), "2");

// ---- 器を撒くなら、その器の要素数ぶん ----
//
// `d st~` は `1 + ||st||` である。**個数は実行時、上界は静的**——この区別が sret を
// 可能にする（スロットは上界で足りる）。
check("器の前にスカラー", bound("f : d st ? d st~\nf 1 `abc`"), "1 + ||st||");
check("器の後ろにスカラー", bound("f : d st ? st~ d\nf 1 `abc`"), "1 + ||st||");
// **器が2つ混ざるなら、和で書く。** 上界は器ごとの項の和（`konst + Σ coef×||器||`）で
// あり、1変数しか持てなかった頃はここで諦めていた。呼ぶ側も呼ばれた側も同じ式を計算する
// ——項が増えるだけで、性質は変わらない。
//
// これが要るのは preprocess.sn の `walk` である：各段で「続きを歩く」（入力に比例）か
// 「残りの段を閉じる」（スタックに比例）かを選ぶので、2つの器を同時に食っている。
check("器が2つなら和で書く", bound("f : a b ? a~ b~\nf `ab` `cd`"), "0 + ||a|| + ||b||");
// 呼び出しを含む形も、まだ扱わない（再帰の深さが要る）。
check("呼び出しを含む形は求めない", bound("g : x ? x\nf : a b ? a (g b)\nf 1 `ab`"), null);

// ---- まだ sret には使えない ----
//
// **仮引数の型が値より狭く出ることがある。** `push : st d ? d st~` は `bottom : 0` から
// 始まるスタックを受けるので `st` に `Int` と `List` の両方が来るが、型は片方へ落ちる
// （`collectParamTypes` が具体型を別の具体型で上書きするため、最後に書いた方が残る）。
// すると上界が `2` になり、実行時に 3 要素・4 要素と伸びる値に対して**スロットが
// 小さすぎる**——そのまま信じると記憶を壊す。
{
	const S = "bottom : 0\npush : st d ? d st~\nf : st d ? d st~\n";
	check("実行時は伸びる", value(S + "push (push bottom 2) 5"), JSON.stringify([5, 2, 0]));
	const { nodes } = compile(S + "push (push bottom 2) 5", { charset: "ascii" });
	const look = (s, nm) => { while (s) { const b = s.bindings instanceof Map ? s.bindings.get(nm) : s.bindings[nm]; if (b) return b; s = s.parent; } return null; };
	const d = nodes.find((n) => n.name === "define" && String(n.left.value).includes("push"));
	const st = look(d.right.scope, "<st>");
	// **スカラーと器が混ざったら器へ持ち上げる。** `[5] ≅ 5` なのでスカラーは1要素の器で
	// あり、`Int` と `List` は「どちらか分からない」のではなく**同じものの別の段**である
	// （`C` と `C×C`）。実引数を観測する側で合流させると、`st` は `List` になり上界も
	// 正しくなる——以前は片方へ落ちて `2` になり、実行時に伸びる値に対してスロットが
	// 小さすぎた。
	checkTrue("器へ持ち上がる", st && st.atomType === "List", `st = ${st && st.atomType}`);
	check("上界も正しくなる", bound(S + "f (f bottom 2) 5"), "1 + ||st||");
	// **持ち上げるのは「値がどちらにもなる」ときだけ**である。使われ方（`c (rest ' 0)` の
	// `c` は String を要求する演算に渡される）は値の型ではないので、そこでは持ち上げない
	// ——混同すると `[c ~rest]` の頭まで器になり、要素の幅が決まらなくなる。
	{
		const { nodes: ns } = compile("f : [c ~rest] ? c (rest ' 0)\nf `abc`", { charset: "ascii" });
		const fd = ns.find((n) => n.name === "define" && String(n.left.value).includes("f>"));
		const cb = look(fd.right.scope, "<c>");
		checkTrue("使われ方では持ち上げない", cb && cb.atomType === "Char", `c = ${cb && cb.atomType}`);
	}
}

// ---- 引数を食う自己呼び出しは、その器の要素数ぶん ----
//
// 器を返す関数のほとんどは再帰である。ここで諦めていると、返し方（sret）を決めても
// スロットの大きさが出ないので何も出せない——実際 lexer と preprocess の sret が
// 全部ここで止まっていた。
//
// 止まる理由が器の側にあること（毎段短くなること）が上界の根拠であり、それは原理5の
// 完全性公理が言う「器を尽くして止まる」形そのものである。
{
	// `take_while` の形。毎段1つ取って残りへ進むので `||s||` で頭打ちになる。
	const TW = "f : p s ?\n\ts = `` : ``\n\t(@p (s ' 0)) : (s ' 0) (f p (s ' 1~))\n\t``\nf $g `abc`\ng : c ? c = `a`\n";
	check("食う再帰は器の要素数", bound(TW), "0 + ||s||");
	// 段ごとに2つ並べるなら係数が2になる（`T(n) = 2 + T(n-1)`）。
	const DUP = "f : s ?\n\ts = `` : ``\n\t(s ' 0) (s ' 0) (f (s ' 1~))\nf `abc`\n";
	check("段ごとに2つなら係数2", bound(DUP), "0 + 2 × ||s||");
	// 底の枝が定数を返すなら、それが `konst` になる。
	const BASE = "f : s ?\n\ts = `` : `xy`\n\t(s ' 0) (f (s ' 1~))\nf `abc`\n";
	check("底の定数が konst", bound(BASE), "2 + ||s||");
	// **同じものを渡す自己呼び出しは、上界に何も足さない。** 器の引数を素通しするので
	// 返るものの大きさは自分の上界そのものである（`T = T`）——上界は他の枝で決まる。
	// ここで枝の形だけを見て諦めていたため、定数の底を持つ形まで sret に乗らなかった。
	check("素通しの自己呼び出しは足さない", bound("f : n a b ?\n\tn > 3 : a b\n\tf (n + 1) a b\nf 0 1 2"), "2");
	// スカラーの位置は入れ替えても器の大きさは動かない。
	check("スカラーは入れ替えてもよい", bound("f : n a b ?\n\tn > 3 : a b\n\tf (n + 1) b a\nf 0 1 2"), "2");
	// **そのまま渡す再帰は器では止まらない。** `try_col … board` は `board` が毎段
	// 同じで、止めているのは別の条件である——器から上界は出ないので求めない。
	// ここを緩めると、止まらない再帰に有限のスロットを割り当ててしまう。
	const SAME = "f : n s ?\n\tn > 3 : __\n\t(s ' 0) (f (n + 1) s)\nf 0 `abc`\n";
	check("そのまま渡す再帰は求めない", bound(SAME), null);
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
