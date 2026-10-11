/**
 * **観測の記録器**（`observe.js`、RTTI の計画 R2）。
 *
 * 小さなプログラムを記録器を付けて解釈器で走らせ、関数ごと・位置ごとに来た値の種類が、書いた答えと同じことを見る。
 * 答えは直に書く（種類の綴りは observe.js の頭の表）。見るのは3つ：
 *
 *   位置      仮引数の並びの位置ごとに1つ、括りだけの並び（`[h ~t]`・`[~s]`）は器1つの位置、混在形の括りも1位置。
 *             括りが器でない値を受けたら、解釈器と同じく1要素の器へ持ち上げて数える（文字は文字のまま）。既定値の入った位置は既定値の種類
 *             （部分適用で既定値の位置に `__` を渡しても）
 *   返値      末尾呼び出しで渡り歩いた関数のどれにも、その関数の返値が付く——前置き（`構築 ＋ 再帰`）を溜めて
 *             回す鎖でも、段ごとの返値を取り違えない（`w` の見本：一番内側だけが文字、外の2段は文字列）。
 *             内側の関数が返した器を外の関数がその場で書き換えて返しても、外の返値は書き換えた後の種類（`g` の見本）
 *   値        記録器を付けても外しても、コーパス（`test/codegen_corpus` の全部）の値と
 *             実行時の診断が同じ（記録器は読むだけ）
 *
 * 種類の綴りを書き出すのは、ここに直に書いた小さなプログラムの答えだけである（観測はディスクに置かない）。
 *
 * 実行: node test/observe.test.js（`npm test` からも呼ばれる）
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import * as I from "../interpreter.js";
import { makeRecorder, kindOfValue, joinKinds, K_INT, K_STRING, K_CHAR } from "../observe.js";
import { chr } from "../runtime_kind.js";

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

/** 走らせて、最後の値と観測を返す。`observing` が偽なら記録器を付けない。 */
function run(source, observing = true) {
	const { nodes } = compile(source, { parse: parser.parse, charset: "ascii" });
	const rec = observing ? makeRecorder(nodes) : null;
	const env = I.newRuntimeEnv(null, "ascii");
	let last = I.UNIT;
	if (rec) I.observeCalls(rec.hooks);
	try {
		for (const n of nodes) last = I.evaluate(n, env);
	} finally {
		I.observeCalls(null);
	}
	return { value: I.isUnit(last) ? null : I.observe(last), diagnostics: env.diagnostics.map((d) => d.message), observed: rec ? rec.observations() : null };
}
/** 関数1つの観測を、比べやすい形に（位置ごとの種類の綴り）。 */
function shape(observed, name) {
	const f = observed.get(name);
	if (!f) return null;
	return { calls: f.calls, collapsed: f.collapsed, partial: f.partial, params: f.params.map((p) => p.kind.key), ret: f.ret.kind.key, retCollapsed: f.ret.collapsed };
}
const valueOf = (source) => {
	const { nodes } = compile(source, { parse: parser.parse, charset: "ascii" });
	const env = I.newRuntimeEnv(null, "ascii");
	let r = I.UNIT;
	for (const n of nodes) r = I.evaluate(n, env);
	return r;
};

// ---- 値の種類 ----
{
	const k = (src) => kindOfValue(valueOf(src)).key;
	check("整数は Int", k("5"), "Int");
	check("2^53 を越える整数（BigInt）も Int", k("9007199254740993"), "Int");
	check("整数でない数は Float", k("2.5"), "Float");
	check("文字は Char、長さ1の文字列は String（文字は箱で、値で割れる——R6）", [k("\\a"), k("s : `a`\ns"), k("`ab` ' 0")], ["Char", "String", "Char"]);
	check("長い文字列は String、空の文字列も String（String の __）", [k("s : `ab`\ns"), kindOfValue("").key], ["String", "String"]);
	check("器は要素ぜんぶの合流、空の器は要素の証拠を持たない", [k("[1 2 3]"), kindOfValue([]).key], ["List(Int)", "List(_)"]);
	check("器の中の長さ1の文字列と長い文字列は String、文字と文字列は並び", [kindOfValue(["a", "bc"]).key, kindOfValue([chr(97), "bc"]).key], ["List(String)", "List(Char | String)"]);
	check("合流しない要素は種類の並び", kindOfValue([1, "bc"]).key, "List(Int | String)");
	check("名前付きスロットは鍵ごとの種類", k("pt :\n\ta : 1\n\tb : `xy`\npt"), "Struct{`a` : Int  `b` : String}");
	check("閉包・点なしは Lambda", [k("f : x ? x + 1\nf"), k("[+ 1]")], ["Lambda", "Lambda"]);
	check("`$` の参照セルは Address", k("v : 5\n$v"), "Address");
	check("規則は Iterator", k("1 ~ 5"), "Iterator");
	check("`__` は種類の無い __", kindOfValue(I.UNIT).key, "__");
	check("合流：__ は証拠ではない・文字と文字列は並び（もう1つにまとめない）・違う種類は並び", [joinKinds(kindOfValue(I.UNIT), K_INT).key, joinKinds(K_CHAR, K_STRING).key, joinKinds(K_INT, K_STRING).key], ["Int", "Char | String", "Int | String"]);
}

// ---- 位置 ----
{
	const o = run("f : x y ? x + y\nf 1 2\n").observed;
	check("裸の仮引数は位置ごと、返値も数える", shape(o, "f"), { calls: 1, collapsed: 0, partial: 0, params: ["Int", "Int"], ret: "Int", retCollapsed: 0 });
}
{
	const o = run("g : [h ~t] ? h\ng [1 2 3]\ns : [~s] ? ||s||\ns `abc`\nc : [c ~r] ? c\nc 5\n").observed;
	check("括りだけの並びは器1つの位置（分解した名前ごとに割らない）", [shape(o, "g").params, shape(o, "s").params], [["List(Int)"], ["String"]]);
	check("括りが器でない値を受けたら、1要素の器へ持ち上げて数える（解釈器の分解と同じ）", shape(o, "c"), { calls: 1, collapsed: 0, partial: 0, params: ["List(Int)"], ret: "Int", retCollapsed: 0 });
}
{
	// 文字は持ち上げずに文字のまま数える——全部を受ける残りは文字そのもの（interpreter.js の `bindBracketParams`）で、
	// String と数えると本体を文字列の型で読ませる（`s + 1` が `__`、解釈器は 'b'）
	const o = run("hd : [c ~r] ? c\nhd \\q\nwh : [~s] ? s + 1\nwh \\a\n").observed;
	check("括りが文字を受けたら Char として数える（頭も、全部を受けた残りも文字）", [shape(o, "hd").params, shape(o, "hd").ret, shape(o, "wh").params, shape(o, "wh").ret], [["Char"], "Char", ["Char"], "Char"]);
}
{
	const o = run("m : a [h ~t] ? h\nm 1 [2 3]\n").observed;
	check("混在形の括りも1位置", shape(o, "m").params, ["Int", "List(Int)"]);
}
{
	const o = run("add : a b ? a + b\ninc : add 1\ninc 5\n").observed;
	check("部分適用は呼び出しではない——渡した実引数はその位置の証拠、残りは当てたときに数える", shape(o, "add"), { calls: 1, collapsed: 0, partial: 1, params: ["Int", "Int"], ret: "Int", retCollapsed: 0 });
}
{
	const o = run("k : x ? x + 1\nk __\nes : s ? 1\nes ``\ne : [~s] ? 1\ne []\n").observed;
	check("潰れた呼び出し（f __）は数える。__ は証拠にならず、返値も証拠にしない", shape(o, "k"), { calls: 1, collapsed: 1, partial: 0, params: ["__"], ret: "__", retCollapsed: 1 });
	check("空の文字列・空の器で潰れても、来た値の域は証拠（String の __・List の __）", [shape(o, "es").params, shape(o, "e").params, shape(o, "e").collapsed], [["String"], ["List(_)"], 1]);
}
{
	const o = run("id : x ? x\nid 1\nid `abc`\n").observed;
	check("1つの位置に合流しない種類が来たら並び（型ごとの実体の候補）", shape(o, "id").params, ["Int | String"]);
}
{
	// 既定値の入った仮引数は、束縛した値（既定値）の種類を数える——渡した `__` は証拠ではないが、既定値は証拠である
	const src = "f :\n\t\tx\n\t\ty : `abc`\n\t? ||y||\ng : n ?\n\tn = 0 : f 1 __\n\tf 1 5\nh :\n\t\tx\n\t\ty : `abc`\n\t? ||y||\n(g 0) + (g 1) + (h 1 __)\n";
	const r = run(src);
	check("既定値の見本の値は 7（記録器を付けても同じ）", r.value, 7);
	check(
		"既定値の入った位置は既定値の種類：f の2番目は渡した 5 と既定値の String の並び、既定値だけの h は String（潰れない）",
		[shape(r.observed, "f").params, shape(r.observed, "h").params, shape(r.observed, "h").collapsed],
		[["Int", "Int | String"], ["Int", "String"], 0]
	);
}
{
	// 部分適用で既定値の位置に `__` を渡しても同じ——束縛した既定値の種類を数える（渡した `__` だけを数えると、その位置は
	// 証拠を持たないまま「観測が無い」に落ちる）。`pa 2 3` を当てたときは残りの2位置だけを数える
	const r = run("f :\n\t\tx\n\t\ty : `abc`\n\t\tz\n\t\tw\n\t? (||y||) + z + w\npa : f 1 __\npa 2 3\n");
	check(
		"部分適用の既定値：値は 8、f の位置は Int・既定値の String・Int・Int（部分適用1回、当てた呼び出し1回）",
		[r.value, shape(r.observed, "f")],
		[8, { calls: 1, collapsed: 0, partial: 1, params: ["Int", "String", "Int", "Int"], ret: "Int", retCollapsed: 0 }]
	);
	// 既定値の無い位置に `__` を渡した部分適用は潰れる（完全性公理）——それでも部分適用1回で、渡した 1 はその位置の証拠
	const z = run("g : a b c ? a + b + c\npz : g 1 __\n");
	check("潰れた部分適用も数える：g は部分適用1回、位置 1 は Int、`__` を渡した位置と残りは証拠なし", shape(z.observed, "g"), { calls: 0, collapsed: 0, partial: 1, params: ["Int", "__", "__"], ret: "__", retCollapsed: 0 });
}

// ---- 返値：前置きを溜めて回す鎖でも、段ごとの返値を取り違えない ----
{
	const r = run("w : n ?\n\tn = 0 : \\x\n\t`ab` (w n - 1)\nw 2\n");
	const f = r.observed.get("w");
	check("w 2 の値は ababx（記録器を付けても同じ）", r.value, "ababx");
	check(
		"返値は段ごと：一番内側の w 0 だけが文字、w 1・w 2 は文字列（鎖の後ろから前置きを繋いだ値）",
		{ calls: f.calls, ret: Object.fromEntries([...f.ret.kinds].map(([k, n]) => [k.key, n])), evidence: f.ret.evidence },
		{ calls: 3, ret: { Char: 1, String: 2 }, evidence: 3 }
	);
}
{
	// 末尾の自己再帰：同じ値を返す関数が続いても、呼び出しの数だけ返値を数える
	const f = run("cnt : n acc ?\n\tn = 0 : acc\n\tcnt n - 1 acc + 1\ncnt 4 0\n").observed.get("cnt");
	check("末尾の自己再帰も段ごとに返値を数える（5 回呼んで 5 回）", [f.calls, f.ret.evidence, f.ret.kind.key], [5, 5, "Int"]);
}
{
	// 名前付きスロットの連結（`(mk x)~ B~`）は左の器へ書き足す——mk が返した物と g が返す物は同じ物で、種類は違う。
	// 返値の種類の写しを finish の外へ持ち越すと、g の返値に mk の2スロットが付く
	const r = run("mk : x ? [\n\ta : x\n\tc : 0\n]\nB : [\n\tb : 2\n\td : 0\n]\ng : x ? (mk x)~ B~\n(g 1) ' b\n");
	check("連結の見本 (g 1) ' b は 2（記録器を付けても同じ）", r.value, 2);
	check(
		"返値の種類は呼び出しごとにその時の値から取る：mk は2スロット、mk の返した器へ書き足して返す g は4スロット",
		[shape(r.observed, "mk").ret, shape(r.observed, "g").ret],
		["Struct{`a` : Int  `c` : Int}", "Struct{`a` : Int  `b` : Int  `c` : Int  `d` : Int}"]
	);
}

// ---- 値：記録器を付けても外しても同じ（コーパス） ----
{
	const dir = path.join(__dirname, "codegen_corpus");
	const files = fs.readdirSync(dir).filter((f) => f.endsWith(".sn")).sort();
	const big = (k, v) => (typeof v === "bigint" ? `${v}n` : v);
	const sources = [...files.map((f) => [f, fs.readFileSync(path.join(dir, f), "utf8").replace(/\r\n/g, "\n")])];
	const differ = [];
	let calls = 0;
	let ran = 0;
	const attempt = (src, observing) => {
		try {
			return run(src, observing);
		} catch (e) {
			return { thrown: String(e && e.message) };
		}
	};
	for (const [name, src] of sources) {
		const off = attempt(src, false);
		const on = attempt(src, true);
		if (on.observed) for (const f of on.observed.values()) calls += f.calls;
		if (!off.thrown) ran++;
		const a = JSON.stringify([off.value, off.diagnostics, off.thrown], big);
		const b = JSON.stringify([on.value, on.diagnostics, on.thrown], big);
		if (a !== b) differ.push(name);
	}
	check(`記録器を付けても外しても、codegen_corpus の ${sources.length} 本の値と実行時の診断が同じ`, differ, []);
	check(`比べたプログラムの中で関数が呼ばれている（上の比べが空振りでない：走った ${ran} 本・呼び出し ${calls} 回）`, [ran > 100, calls > 500], [true, true]);
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
