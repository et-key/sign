/**
 * **観測をつなぐ**（`observed_facts.js`、`compile(src, { observed })`）。
 *
 * 小さなプログラムを記録器を付けて解釈器で走らせ、その観測を渡して compile し直す。見るのは5つ：
 *
 *   事実     観測と pass3 が両立する位置は事実になり、pass3 が曖昧だった所（輪の素通しの返値の `Container`）は観測の
 *            型で埋まる。不動点の周回は事実を書き換えようとする（数える）が、どれも通らない——仮引数の束縛にも、pass3 が
 *            呼び出しサイトの型を置く欄（`callsiteParamTypes`、`paramTypeOf` が先に読む）にも
 *   断り     観測が無い・種類が2つ以上・観測と推論が食い違う（整数の値と pass3 の Address、器と連番の構造体、
 *            `[x] ≅ x` の持ち上げ、呼び出しが観測と違う型を渡す——直に・別名越しに）・公開した関数（`#`）は、pass4 が
 *            名指しで断り（`observed-type-refused`）、`.ist` は署名を書かない（注記の行だけ）——後段の lower.sn も
 *            `! type 名前` で断る。既定値の入った位置は既定値の種類も数える
 *   規則     突き合わせの表（observed_facts.js の頭）のうち、小さなプログラムでは出しにくい行（名前付きスロットの鍵の
 *            食い違い、空の器しか来なかった位置）は `decide` を直に引いて見る
 *   反響     1文字の値は pass3 の Char・String の言い分を採る（R6 の箱まで）
 *   素通り   観測を渡さない compile は印も数えも持たない（ここは呼ばれない）
 *
 * 種類と型の綴りを書き出すのは、ここに直に書いた小さなプログラムの答えだけである（観測はディスクに置かない）。
 *
 * 実行: node test/observed_facts.test.js（`npm test` からも呼ばれる）
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import { generateSignType } from "../st.js";
import { generateAsm } from "../pass4.js";
import { blockingOf } from "../errors.js";
import { envLookup, paramTypeOf } from "../pass1.js";
import * as I from "../interpreter.js";
import { makeRecorder, listKind, structKind, K_INT } from "../observe.js";
import { planObservedFacts, installObservedFacts, decide, parseType, spell } from "../observed_facts.js";
import { PROGS } from "./ring_shapes.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const parser = peggy.generate(fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8"));
const OPT = { target: "aarch64_qemu", charset: "ascii", layer: 1 };

let passed = 0;
let total = 0;
function check(note, got, want) {
	total++;
	const ok = JSON.stringify(got) === JSON.stringify(want);
	if (ok) passed++;
	console.log(`${ok ? "OK  " : "FAIL"} ${note}`);
	if (!ok) console.log(`     got:  ${JSON.stringify(got)}\n     want: ${JSON.stringify(want)}`);
}

/** 観測を持たない compile・解釈器で走らせた観測・観測を渡した compile。 */
function connect(src) {
	const plain = compile(src, { parse: parser.parse, charset: "ascii" });
	const rec = makeRecorder(plain.nodes);
	const env = I.newRuntimeEnv(null, "ascii");
	let last = I.UNIT;
	I.observeCalls(rec.hooks);
	try {
		for (const n of plain.nodes) last = I.evaluate(n, env);
	} finally {
		I.observeCalls(null);
	}
	const observed = rec.observations();
	const c = compile(src, { parse: parser.parse, charset: "ascii", observed });
	return { plain, c, observed, value: I.isUnit(last) ? null : I.observe(last) };
}
/** トップレベルの `名前 : ラムダ` のラムダ。 */
const lambdaOf = (c, name) => c.nodes.find((n) => n && n.type === "operation" && n.name === "define" && String(n.left.value).replace(/^<|>$/g, "") === name).right;
/** `.ist` の行（頭の注記は除き、観測で断った注記は残す）。 */
const istLines = (c) =>
	generateSignType(c.nodes, c.env, { scope: "ist" })
		.text.split("\n")
		.filter((l) => l && (!l.startsWith("`") || l.startsWith("` 観測で断る")));
const refusedOf = (c) => Object.fromEntries([...c.observation.refused].map(([k, rs]) => [k, [...new Set(rs.map((r) => r.cls))]]).sort((a, b) => (a[0] < b[0] ? -1 : 1)));
const marked = (c) => c.nodes.filter((n) => n && n.type === "operation" && n.name === "define" && n.right && n.right.observedRefusal).map((n) => String(n.left.value).replace(/^<|>$/g, ""));

// ---- 素通り：観測を渡さない compile ----
{
	const c = compile("f : x ? x + 1\nf 2\n", { parse: parser.parse, charset: "ascii" });
	check("観測を渡さない compile は数え（observation）も断りの印も持たない", ["observation" in c, marked(c)], [false, []]);
}

// ---- 事実：両立する位置はそのまま、1文字は pass3 の言い分（反響） ----
{
	const src = "f : x y ? x + y\ng : [~s] ? ||s||\nh : [c ~r] ? c\nc : x ? x\nc2 : x ? x\nf 1 2\ng `abc`\nh `xy`\nc \\a\nc2 `a`\n";
	const { plain, c } = connect(src);
	check("観測と pass3 が両立する関数は .ist が観測を持たない compile と同じ", istLines(c), istLines(plain));
	const o = c.observation;
	check("位置はどれも事実になり、1文字の値の位置（h の返値・c・c2 の仮引数と返値）は反響として数える", [o.functions, o.positions, o.fixed, o.echo, o.refusedFunctions], [5, 11, 11, 5, 0]);
	check("1文字の値：pass3 が Char と言えば Char、String と言えば String のまま", istLines(c).filter((l) => /^c2? :/.test(l)), ["c : Char -> Char", "c2 : String -> String"]);
}

// ---- 事実：pass3 が曖昧だった所を観測の型で埋め、周回は事実を書き換えない ----
{
	const { plain, c, value } = connect(PROGS.ring_lit3_len);
	const rt = (x) => istLines(x).find((l) => l.startsWith("rt :"));
	check("輪の素通し（ring_lit3_len）：pass3 が Container と言っていた rt の返値を、観測の List(String) で埋める", [rt(plain), rt(c)], ["rt : List(String) String Int -> Container", "rt : List(String) String Int -> List(String)"]);
	const o = c.observation;
	check(`不動点の周回は事実を書き換えようとした（${o.attempts} 回）が、どれも通らなかった——事実の欄（${o.fixedFields}）は周回の後も置いたまま`, [o.attempts > 0, o.fixedFields > 0, o.moved, o.missing, o.refusedFunctions], [true, true, 0, 0, 0]);
	const est = (x) => generateAsm(x.nodes, x.env, OPT).diagnostics.filter((d) => d.reason === "sret-bound-is-an-estimate").map((d) => [d.severity, String(d.message).split(":")[0]]);
	const blockingObserved = blockingOf(generateAsm(c.nodes, c.env, OPT).diagnostics);
	check(
		"観測を持たない pass4 は置き場で断り、観測をつないだ pass4 を止めるのは返す器の上界の見積もりだけ（観測の道では見積もりで出さない——外れると短い器が黙って返る）",
		[blockingOf(generateAsm(plain.nodes, plain.env, OPT).diagnostics).length > 0, blockingObserved.map((d) => d.reason), est(c), value],
		[true, ["sret-bound-is-an-estimate"], [["error", "rt"]], 3]
	);
}

// ---- 断り：観測が無い・種類が2つ以上・食い違い ----
{
	const src = [
		"h : x ? x + 1",
		"k : n ?",
		"\tn = 0 : 0",
		"\th n",
		"p : q ? q + 1",
		"id : x ? x",
		"w : s ? s , __",
		"u : t ? ||t||",
		"f : x ? x",
		"g : n ?",
		"\tn = 0 : f 1",
		"\tf [1 2]",
		"k 0",
		"p 0x1000",
		"id 1",
		"id `abc`",
		"u (w `ab`)",
		"g 0",
		"",
	].join("\n");
	const { c } = connect(src);
	check(
		"断った関数と類：呼ばれない h は観測が無い、番地の p は整数の値と割れない、id は種類が2つ、w・u は器と連番の構造体、f・g は [x] ≅ x の持ち上げ",
		refusedOf(c),
		{ f: ["conflict"], g: ["conflict"], h: ["unobserved"], id: ["several"], p: ["conflict"], u: ["conflict"], w: ["conflict"] }
	);
	check("断りの印は観測で断った関数にだけ付く（k は事実のまま）", marked(c).sort(), ["f", "g", "h", "id", "p", "u", "w"]);
	const lines = istLines(c);
	check(".ist は断った関数の署名を書かず、注記の行だけ残す（後段は署名の無い関数を名指しで断る）", [lines.filter((l) => /^(f|g|h|id|p|u|w) :/.test(l)), lines.filter((l) => l.startsWith("` 観測で断る")).length, lines.filter((l) => l.startsWith("k :"))], [[], 7, ["k : Int -> Int"]]);
	const errs = generateAsm(c.nodes, c.env, OPT).diagnostics.filter((d) => d.reason === "observed-type-refused");
	check("pass4 は断った関数を名指しで断る（阻む診断、名前が頭）", errs.map((d) => [d.severity, String(d.message).split(":")[0]]).sort(), ["f", "g", "h", "id", "p", "u", "w"].map((n) => ["error", n]));
	check("断りの言い分：観測が無い・番地の箱（R3）・型ごとの実体", [/観測が無い/.test(c.observation.refused.get("h")[0].text), /R3/.test(c.observation.refused.get("p")[0].text), /種類が2つ以上/.test(c.observation.refused.get("id")[0].text)], [true, true, true]);
}

// ---- 断り：観測した走りに無かった呼び出しが、事実と違う型を渡す ----
{
	const src = ["f : x ? x + 1", "g : n ?", "\tn = 0 : f 1", "\tf `ab`", "ln : [~s] ? ||s||", "m : n ?", "\tn = 0 : ln `abc`", "\tln [1 2 3]", "g 0", "m 0", ""].join("\n");
	const { c } = connect(src);
	check("走らなかった枝の呼び出しが観測と違う型を渡す f・ln を断る（呼ぶ側の推論と観測が食い違う）", [refusedOf(c), c.observation.refused.get("f")[0].text, c.observation.refused.get("ln")[0].text], [{ f: ["conflict"], ln: ["conflict"] }, "仮引数 1：観測は Int、呼び出しが渡すのは String", "仮引数 1：観測は String、呼び出しが渡すのは List(Int)"]);
}

// ---- 断り：別名越しの呼び出しが、事実と違う型を渡す（pass3 の呼び出しサイトの型で見る） ----
{
	// `g : f` の後の g への呼び出しは f の呼び出しサイトである（pass3 の `callsitesOf` は別名を辿る）。呼び出しの木の注釈を歩く検査は
	// 頭が g なので f と見ず、pass4 が「幅が合いません」で止めるまで誰も f を名指ししていなかった
	const { c } = connect("f : x ? x\ng : f\nh : n ?\n\tn = 0 : f 1\n\tg `ab`\nh 0\n");
	check("走らなかった枝の別名越しの呼び出しが String を渡す f を断る（pass3 が呼び出しサイトで見た型）", [refusedOf(c), c.observation.refused.get("f").map((r) => r.text)], [{ f: ["conflict"] }, ["仮引数 1：観測は Int、pass3 が呼び出しサイトで見た型に String がある"]]);
}

// ---- 事実の口：周回が書こうとしても、仮引数の束縛と呼び出しサイトの型の欄は事実のまま ----
{
	// 周回の代わりに直に書く（観測を持たない compile の木へ事実を置き、書き換えを試みる）。`paramTypeOf` は呼び出しサイトの
	// 欄を束縛より先に読み、pass4 の渡し方と `.ist` の署名はそこから引くので、両方の欄を止めないと事実が素通りされる
	const src = "f : x y ? x + y\nf 1 2\n";
	const { plain, observed } = connect(src);
	const plan = planObservedFacts(plain, observed);
	const fresh = compile(src, { parse: parser.parse, charset: "ascii" });
	const guard = installObservedFacts(fresh.nodes, fresh.env, plan);
	const rhs = lambdaOf(fresh, "f");
	rhs.callsiteParamTypes = ["List", "String"];
	envLookup(rhs.scope, "<x>").atomType = "List";
	delete envLookup(rhs.scope, "<y>").atomType;
	check(
		"事実を置いた欄は書いても消しても事実のまま（呼び出しサイトの欄・束縛の両方）、試みは数える",
		[rhs.callsiteParamTypes, paramTypeOf(rhs, 0, "<x>").atomType, envLookup(rhs.scope, "<x>").atomType, envLookup(rhs.scope, "<y>").atomType, guard.attempts],
		[["Int", "Int"], "Int", "Int", "Int", 4]
	);
}

// ---- 断り：公開した関数（`#`）は観測で型を決めない ----
{
	// pass3 は export された関数をジェネリックのまま置く（`.st` の契約は多相のまま）。観測の走りの1回の呼び出しで添字を Int に
	// 狭めると契約が黙って狭まるので、関数ごと名指しで断る（事実は置かない）
	const { plain, c } = connect("#h : [~s] i ? s ' i\nh `abc` 1\n");
	const st = (x, scope) => generateSignType(x.nodes, x.env, { scope }).text.split("\n").filter((l) => /^#?h :/.test(l) || l.startsWith("` 観測で断る: h"));
	check("観測を持たない compile の契約は多相のまま（添字は Atom）", st(plain, "st"), ["#h : String Atom -> Char"]);
	check(
		"公開した h は類 exported で断り、.st も .ist も狭めた署名を書かない（注記の行だけ）、pass4 も名指しで断る",
		[refusedOf(c), st(c, "st").map((l) => l.split(" —— ")[0]), st(c, "ist").map((l) => l.split(" —— ")[0]), generateAsm(c.nodes, c.env, OPT).diagnostics.filter((d) => d.reason === "observed-type-refused").map((d) => String(d.message).split(":")[0]), c.observation.refusedPositions.exported, c.observation.fixedFields],
		[{ h: ["exported"] }, ["` 観測で断る: h"], ["` 観測で断る: h"], ["h"], 3, 0]
	);
}

// ---- 断り：既定値の入った位置は、既定値の種類も数える ----
{
	// `f 1 __` の2番目は既定値の String、`f 1 5` の2番目は Int——渡した `__` だけを見ると Int の事実になる
	const { c, value } = connect("f :\n\t\tx\n\t\ty : `abc`\n\t? ||y||\ng : n ?\n\tn = 0 : f 1 __\n\tf 1 5\n(g 0) + (g 1)\n");
	check("既定値の見本の値は 4、f は2番目の位置に種類が2つ（既定値の String と渡した Int）で断る", [value, refusedOf(c), /仮引数 2：種類が2つ以上/.test(c.observation.refused.get("f")[0].text)], [4, { f: ["several"] }, true]);
}

// ---- 規則：小さなプログラムでは出しにくい行を、`decide` を直に引いて見る ----
{
	const d = (K, text) => {
		const r = decide(K, parseType(text));
		return r.fact ? ["fact", spell(r.fact), !!r.echo] : ["refuse", r.refuse.cls];
	};
	const ab = structKind([
		["a", K_INT],
		["b", K_INT],
	]);
	check(
		"名前付きスロット：鍵が pass3 と同じなら pass3 の言い分（反響）、鍵が違えば食い違いで断る",
		[d(ab, "Struct{`a` : Int , 0  `b` : Int , 1}"), d(ab, "Struct{`a` : Int , 0  `c` : Int , 1}"), d(ab, "Struct{`a` : Int , 0}")],
		[["fact", "Struct{a b}", true], ["refuse", "conflict"], ["refuse", "conflict"]]
	);
	const empty = listKind(null);
	check(
		"空の器しか来なかった位置：pass3 が要素まで言う List のときだけその言い分（反響）、族・形・要素の無い List なら観測が無い",
		[d(empty, "List(Int)"), d(empty, "Container"), d(empty, "[s~]"), d(empty, "_"), d(empty, "List")],
		[["fact", "List(Int)", true], ["refuse", "unobserved"], ["refuse", "unobserved"], ["refuse", "unobserved"], ["refuse", "unobserved"]]
	);
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
