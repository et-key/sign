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
	return b.sizeOf ? `${b.konst} + ||${String(b.sizeOf).replace(/[<>]/g, "")}||` : String(b.konst);
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
// 器が2つ混ざると和になる。まだ扱わない（決まらないものは決めない）。
check("器が2つは求めない", bound("f : a b ? a~ b~\nf `ab` `cd`"), null);
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
	const { nodes } = compile(S + "push bottom 2", { charset: "ascii" });
	const look = (s, nm) => { while (s) { const b = s.bindings instanceof Map ? s.bindings.get(nm) : s.bindings[nm]; if (b) return b; s = s.parent; } return null; };
	const d = nodes.find((n) => n.name === "define" && String(n.left.value).includes("push"));
	const st = look(d.right.scope, "<st>");
	checkTrue("型が値より狭い（既知の穴）", st && st.atomType === "Int", `st = ${st && st.atomType}`);
	// 直和になっていれば器として数えられる。そうなるまで sret は組めない。
	checkTrue("直和なら器として数える", bound("g : x ?\n\tx > 1 : `ab`\n\t0\nf : d st ? d st~\nf 1 (g 2)") !== "2");
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
