/**
 * **同型は機械語で無償でなければならない。**
 *
 * `$__ = __ = @__` が機械語の不動点であるように——型の上では別のものでも、機械の上では
 * 同じビットでなければならない——仕様が同型だと言っているものは、値も型も命令列も一致する
 * はずである。一致しないなら、**型が値より広い**か、**問いになっていない問いを実行時に
 * 訊いている**かのどちらかである。実際どちらも見つかった。
 *
 * ここは同型の表そのものである。成り立つものだけでなく、**わざと成り立たないもの**も
 * 理由つきで置く——「同型に見えるが違う」ことこそ、あとで踏みやすい。
 *
 * 実行: node test/isomorphism.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import { generateAsm } from "../pass4.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "../interpreter.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const parser = peggy.generate(fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8"));

let passed = 0;
let total = 0;
function checkTrue(note, cond, extra) {
	total++;
	if (cond) passed++;
	console.log(`${cond ? "OK  " : "FAIL"} ${note}`);
	if (!cond && extra) console.log(`     ${extra}`);
}

// 値（観測境界を通した姿）。`Char` は符号位置で見る——機械の側にあるのは数である。
function value(source) {
	const { nodes } = compile(source, { parse: parser.parse });
	const env = newRuntimeEnv(null);
	let r = UNIT;
	for (const node of nodes) r = evaluate(node, env);
	if (isUnit(r)) return "__";
	const o = observe(r);
	if (typeof o === "string" && [...o].length === 1) return String(o.codePointAt(0));
	if (o && typeof o === "object" && o.__identity__) return "0";
	return JSON.stringify(o);
}
function type(source) {
	const { nodes } = compile(source, { charset: "ascii" });
	return String(nodes[nodes.length - 1].atomType);
}
// `f` の本体の命令列（コメントは落とす）。出せなければ null。
function body(source) {
	const { nodes, env } = compile(source, { charset: "ascii" });
	const r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "ascii", layer: 1 });
	if (r.diagnostics.length) return null;
	const t = r.text.split("\n");
	const i = t.findIndex((l) => l.startsWith("f:"));
	if (i < 0) return null;
	const j = t.findIndex((l, k) => k > i && l.trim() === "ret");
	return t.slice(i, j + 1).map((l) => l.replace(/\/\/.*/, "").trim()).filter(Boolean);
}

/** 同型：値・型・命令列のすべてが一致する。命令列は関数の形で書かれたときだけ見る。 */
function iso(note, a, b) {
	const [va, vb] = [value(a), value(b)];
	const [ta, tb] = [type(a), type(b)];
	const [ba, bb] = [body(a), body(b)];
	const insSame = !ba || !bb ? true : JSON.stringify(ba) === JSON.stringify(bb);
	const why = [];
	if (va !== vb) why.push(`値 ${va} / ${vb}`);
	if (ta !== tb) why.push(`型 ${ta} / ${tb}`);
	if (!insSame) why.push(`命令 ${ba.length} / ${bb.length}`);
	checkTrue(note, why.length === 0, why.join(" · "));
}

// ---- 1要素の器は存在しない（`[x] ≅ x`） ----
iso("[x] ≅ x", "[5]", "5");
iso("[x ~ x] ≅ x", "[3 ~ 3]", "3");
iso("x ' 0 ≅ x", "f : n ? n ' 0\nf 5", "f : n ? n\nf 5");
iso("x ' 0 ' 0 ≅ x", "f : n ? (n ' 0) ' 0\nf 5", "f : n ? n\nf 5");
iso("式の中でも", "f : n ? (n ' 0) + 1\nf 5", "f : n ? n + 1\nf 5");

// ---- 0 番目から末尾まで、は丸ごと（器でも規則でも） ----
iso("x ' 0~ ≅ x", "f : n ? n ' 0~\nf 5", "f : n ? n\nf 5");
iso("s ' 0~ ≅ s", "f : s ? s ' 0~\nf `abc`", "f : s ? s\nf `abc`");
iso("s ' 0~ ' 0~ ≅ s", "f : s ? (s ' 0~) ' 0~\nf `abc`", "f : s ? s\nf `abc`");
iso("規則 ' 0~ ≅ 規則", "f : n ? [1 ~ 5] ' 0~\nf 1", "f : n ? [1 ~ 5]\nf 1");

// ---- 記憶（`$` / `@`） ----
//
// `$名前` は束縛の番地なので、そこから読めば束縛の値そのものである。番地を作って読み直す
// 意味は無く、フレームの中に在るものは niche にもなりえない（`@` の分岐も要らない）。
iso("@$x ≅ x", "f : n ? @($n)\nf 5", "f : n ? n\nf 5");
iso("@$x を使っても", "f : n ? (@($n)) + 1\nf 5", "f : n ? n + 1\nf 5");

// ---- 余積の単位元（`__` は落ちる） ----
iso("__ x ≅ x", "f : n ? __ n\nf 5", "f : n ? n\nf 5");
iso("x __ ≅ x", "f : n ? n __\nf 5", "f : n ? n\nf 5");

// ---- 撒いても1つは1つ ----
iso("scalar~ ≅ scalar", "f : n ? n~\nf 5", "f : n ? n\nf 5");

// ---- 同型に見えて、そうでないもの ----
//
// **`!` は対合ではない。** 「`__` かどうか」を見る述語であり、値を反転する演算ではない
// ——`!5` は `__`（偽）、`!__` は恒等射（真）なので、`!!5` は 5 ではなく真である。
checkTrue("!!x は x ではない（`!` は述語）", value("f : n ? !(!n)\nf 5") !== value("f : n ? n\nf 5"));
checkTrue("!!x は真である", value("f : n ? !(!n)\nf 5") === "0");

// **`|.|` は絶対値であって要素数ではない。** 数には絶対値、器には数え上げが効く
// （演算子表 tier 16 は `abs`、list_model.md が数え上げに触れている）。`[5] ≅ 5` なので
// `|[5]|` は 5 であり 1 ではない——**同型が保たれる方が優先する**。
checkTrue("|scalar| は絶対値", value("|5|") === "5");
checkTrue("|[x]| は |x| と同じ", value("|[5]|") === value("|5|"));
checkTrue("|器| は数え上げ", value("|`abc`|") === "3" && value("|[1 ~ 5]|") === "5");

// **空の器は値としては `__` だが、型は器のままである。** 型が `String` なのは「以降を
// テキストとして連結する」という宣言であり、落とすと型が String と言っているのに値が
// List になる（interpreter.js の `isTextSeed`）。値だけでは決まらないので型で決める。
checkTrue("空文字列の値は __", value("``") === "__");
checkTrue("空文字列の型は String", type("``") === "String");
checkTrue("空リストの値は __", value("[]") === "__");

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
