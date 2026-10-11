/**
 * **輪の形の見本を機械で走らせる——名指しで断るか、解釈器と同じ値か。**（qemu の段）
 *
 * 生成器は `ring_shapes.js`（gen2 700 本・gen3 360 本・手で書いた 9 本）で、ここが回すのはその固定の見本
 * `ringSample()` の 103 本（作る関数 × 輪の形の組ごとに gen2・gen3 から1本ずつ、手で書いた 9 本、HEAD 1fbceb64 で
 * 全部の組を回して食い違った 15 本のうち残りの 14 本）。どの本も、次のどちらかでなければならない:
 *
 *   断り   pass4 が阻む診断で名指しして出さない（前段が名指しの例外で断るのも断りに数える）
 *   一致   機械の値が解釈器の値と同じ
 *
 * **値の比べ方は静的な型で決める。** 機械が返す x0 の意味は型で決まる——器なら x0 は番地なので、解釈器の
 * 綴り（`abcd`）と比べても必ず食い違う。最後の式の型（pass3）が器（`String`・`List`・`Struct`・`Container`、
 * それを含む和）なら、qemu.test.js の `agreeText` と同じく長さ `||e||` と要素 `(e) ' i` を両側で引いて比べる
 * （2段まで。要素も器なら同じ規則で辿る）。器でない型（`Int`・`Char`・`Unit` …）は x0 をそのまま比べる——
 * 数を辿ると `' 0` で機械が断り、本当の誤答が断りに化けるからである。辿った式のどれかが食い違えば誤答、
 * どれも一致なら一致、食い違いが無く断りがあれば断り。
 *
 * ## 前からある誤答（golden）
 *
 * HEAD 1fbceb64（返値の事実のラッチの後）で、gen2・gen3・PROGS の 1069 本のうち 15 本が解釈器と食い違う。どれも
 * lit3（`` `ab` , `cde` , s ``）を作る関数・輪 two／three／cond・裸の受け方 `ts`・入力 `` `xy` `` の組で、pass4 は
 * 阻む診断を出さず、「返す器の上界は見積もり（輪の相手が食っていることを根拠にした）」の information だけを出す。
 * 短い入力で見積もりを外れ、機械は `__`（短い器）を返す——ラッチの片が「踏み抜き → 見積もりの `__`」と数えた
 * 15 本で、値は食い違ったまま残っている。15 本とも見本に入れ、`KNOWN_WRONG` に解釈器と機械の値ごと書き置いて、
 * **その値のままである限り緑**にする（直す片が来るまでの印で、仕様ではない）。落ちるのは:
 *
 *   新しい誤答      KNOWN_WRONG に無い本が誤答になった（断りが誤答に化けた・一致が誤答に化けた・新しく出た）
 *   誤答が変わった  KNOWN_WRONG の本の値が書き置きと違う（別の誤答・例外）
 *   誤答が直った    KNOWN_WRONG の本が断りか一致になった——直した片と同じ commit で KNOWN_WRONG から外す
 *                  （書き置いた証人は直ったら腐る。外さずに放っておくと、次に同じ本が誤答に戻っても緑になる）
 *   例外            機械の側だけが例外（pass4 の例外・qemu が返って来ない）、解釈器だけが例外で機械が値を出した
 *
 * 断り → 一致・一致 → 断りは落とさない（どちらも「断るか一致」の内側）。数は最後に出す。
 *
 * 見本の字面も釘で留める（本数と字面の指紋）——生成器を書き換えると KNOWN_WRONG の名前が別の本を指すので、
 * そのときは見本と golden を一緒に直す。機械で走った本が1本も無い（全部断り）なら、比較が1度も走っていない
 * ので落とす。
 *
 * ツールチェーンが無ければ静かに飛ばす（qemu.test.js と同じ）。速い段（`SIGN_NO_QEMU=1 npm test`）では飛び、
 * qemu の段で1本ずつ回す。
 *
 * 実行: node test/ring_shapes.test.js（`--list` で本ごとの判定を出す）
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import { generateAsm } from "../pass4.js";
import { blockingOf } from "../errors.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "../interpreter.js";
import { runAsm, asInt, available, toolReport } from "../qemu_run.js";
import { ringSample } from "./ring_shapes.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const readImport = (p) => fs.readFileSync(path.join(__dirname, "..", "..", "sign", p), "utf8").replace(/\r\n/g, "\n");
const LIST = process.argv.includes("--list");

/**
 * 前からある誤答（HEAD 1fbceb64。阻む診断は無く、見積もりの information だけが出る）。値は qemu.test.js と同じ
 * 見せ方（`Char` は符号位置、`__` は `__`）。器の本は辿った式ごとの食い違いを1つの綴りにまとめる（`式 解釈=… 機械=…`
 * を ` ; ` でつなぐ）。
 */
const KNOWN_WRONG = {
	"g2:lit3_cond_bare_i1len_1": "top `xy` 解釈=3 機械=0（見積もりの information あり）",
	"g2:lit3_two_bare_len_1": "top `xy` 解釈=3 機械=0（見積もりの information あり）",
	"g2:lit3_two_bare_i1len_1": "top `xy` 解釈=3 機械=0（見積もりの information あり）",
	"g2:lit3_two_bare_i2_1": "||top `xy`|| 解釈=2 機械=0（見積もりの information あり）",
	"g2:lit3_two_bare_i0c1_1": "top `xy` 解釈=98 機械=__（見積もりの information あり）",
	"g2:lit3_two_bare_i1c0_1": "top `xy` 解釈=99 機械=__（見積もりの information あり）",
	"g2:lit3_three_bare_len_1": "top `xy` 解釈=3 機械=0（見積もりの information あり）",
	"g2:lit3_three_bare_i1len_1": "top `xy` 解釈=3 機械=0（見積もりの information あり）",
	"g2:lit3_three_bare_i2_1": "||top `xy`|| 解釈=2 機械=0（見積もりの information あり）",
	"g2:lit3_three_bare_i0c1_1": "top `xy` 解釈=98 機械=__（見積もりの information あり）",
	"g2:lit3_three_bare_i1c0_1": "top `xy` 解釈=99 機械=__（見積もりの information あり）",
	"g2:lit3_cond_bare_len_1": "top `xy` 解釈=3 機械=0（見積もりの information あり）",
	"g2:lit3_cond_bare_i2_1": "||top `xy`|| 解釈=2 機械=0（見積もりの information あり）",
	"g2:lit3_cond_bare_i0c1_1": "top `xy` 解釈=98 機械=__（見積もりの information あり）",
	"g2:lit3_cond_bare_i1c0_1": "top `xy` 解釈=99 機械=__（見積もりの information あり）",
};

// 見本の釘：本数と字面の指紋（FNV-1a 32bit を名前と字面の全部に当てる）
const SAMPLE_SIZE = 103;
const SAMPLE_FNV = "9cbd65f7";

let passed = 0;
let total = 0;
function check(note, ok, detail = "") {
	total++;
	if (ok) passed++;
	console.log(`${ok ? "OK  " : "FAIL"} ${note}${detail ? "：" + detail : ""}`);
}

if (!available()) {
	console.log(`ツールチェーンが無いので飛ばす（${toolReport()}）`);
	console.log("\n0/0 passed");
	process.exit(0);
}

const parser = peggy.generate(fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8"));

// 解釈器の答えと、最後の式の静的な型。
function interp(source) {
	const { nodes } = compile(source, { parse: parser.parse, charset: "ascii", readImport });
	const last = nodes[nodes.length - 1];
	const type = last && last.atomType !== undefined ? String(last.atomType) : "";
	const env = newRuntimeEnv(null, "ascii");
	let r = UNIT;
	for (const node of nodes) r = evaluate(node, env);
	let text;
	if (isUnit(r)) text = "__";
	else {
		const o = observe(r);
		if (o === undefined || o === null) text = "__";
		else if (typeof o === "string" && [...o].length === 1) text = String(o.codePointAt(0));
		else if (o && typeof o === "object" && o.__identity__) text = "0";
		else text = typeof o === "object" ? JSON.stringify(o) : String(o);
	}
	return { text, type };
}

// 機械の答え。止める診断があれば断り（`出せない：…`）。
function machine(source) {
	const { nodes, env } = compile(source, { charset: "ascii", readImport });
	const r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "ascii", layer: 1 });
	const bad = blockingOf(r.diagnostics);
	if (bad.length) return { refused: bad[0].message };
	// 上界が見積もりである（information）。誤答の書き置きに添えるだけで、判定には使わない。
	const estimate = r.diagnostics.some((d) => d.severity === "information" && /見積もり/.test(d.message));
	const v = asInt(runAsm(r.text)[0]);
	return { text: v === null ? "__" : String(v), estimate };
}

const CONTAINER = /\b(String|List|Struct|Container)\b/;
let ranOnMachine = 0;

// 1つの式を比べる。{ st: "A"|"R"|"W"|"X", note } を返す。R は断り、X は例外。
function compare(defs, expr, depth) {
	const src = defs + "\n" + expr;
	let a;
	let b;
	try {
		a = interp(src);
	} catch (e) {
		a = { error: e.message };
	}
	try {
		b = machine(src);
	} catch (e) {
		b = { error: e.message };
	}
	if (a.error && b.error) return a.error === b.error ? { st: "R", note: `前段の断り：${a.error.slice(0, 60)}` } : { st: "X", note: `${expr} 解釈で例外=${a.error.slice(0, 60)} / 機械で例外=${b.error.slice(0, 60)}` };
	if (b.error) return { st: "X", note: `${expr} 機械で例外：${b.error.slice(0, 100)}` };
	if (b.refused) return { st: "R", note: b.refused.replace(/（.*/, "").slice(0, 60) };
	if (a.error) return { st: "X", note: `${expr} 解釈だけ例外（機械=${b.text}）：${a.error.slice(0, 80)}` };
	ranOnMachine++;
	if (a.text === b.text) return { st: "A", note: a.text };
	if (!CONTAINER.test(a.type) || depth >= 2) return { st: "W", note: `${expr} 解釈=${a.text} 機械=${b.text}${b.estimate ? "（見積もりの information あり）" : ""}` };
	// 器：長さと要素を両側で引く
	const len = compare(defs, `||${expr}||`, 2);
	if (len.st !== "A") return len;
	const n = Number(len.note);
	const parts = [];
	let worst = "A";
	const rank = { A: 0, R: 1, W: 2, X: 3 };
	for (let i = 0; i < n; i++) {
		const r = compare(defs, `(${expr}) ' ${i}`, depth + 1);
		if (r.st !== "A") parts.push(r.note);
		if (rank[r.st] > rank[worst]) worst = r.st;
	}
	return worst === "A" ? { st: "A", note: `器 ${n} 要素とも一致` } : { st: worst, note: parts.join(" ; ") };
}

const sample = ringSample();
{
	let h = 0x811c9dc5;
	for (const [name, src] of sample)
		for (const ch of name + "\u0000" + src + "\u0000") {
			h ^= ch.codePointAt(0);
			h = Math.imul(h, 0x01000193) >>> 0;
		}
	const fnv = h.toString(16).padStart(8, "0");
	check("見本の本数と字面が釘と同じ（生成器を変えたら KNOWN_WRONG と一緒に直す）", sample.length === SAMPLE_SIZE && fnv === SAMPLE_FNV, `${sample.length} 本・指紋 ${fnv}`);
}

const counts = { A: 0, R: 0, W: 0, X: 0 };
const seenKnown = new Set();
for (const [name, source] of sample) {
	const ls = source.replace(/\n+$/, "").split("\n");
	const expr = ls.pop();
	const defs = ls.join("\n");
	const r = compare(defs, expr, 0);
	counts[r.st]++;
	if (LIST) console.log(`LIST ${name} ${r.st} ${r.note}`);
	const known = KNOWN_WRONG[name];
	if (known !== undefined) {
		seenKnown.add(name);
		if (r.st === "W" && r.note === known) check(`既知の誤答のまま ${name}`, true);
		else if (r.st === "W") check(`誤答が変わった ${name}`, false, `書き置き「${known}」／今「${r.note}」`);
		else if (r.st === "X") check(`誤答が変わった（例外） ${name}`, false, r.note);
		else check(`誤答が直った ${name}——KNOWN_WRONG から外す`, false, `${r.st === "A" ? "一致" : "断り"}：${r.note}`);
		continue;
	}
	if (r.st === "W") check(`新しい誤答 ${name}（断りか一致だった本が誤答になった）`, false, r.note);
	else if (r.st === "X") check(`例外 ${name}`, false, r.note);
	else check(`${r.st === "A" ? "一致" : "断り"} ${name}`, true, r.st === "A" ? "" : r.note);
}
check("KNOWN_WRONG の名前がどれも見本にある", Object.keys(KNOWN_WRONG).every((n) => seenKnown.has(n)), Object.keys(KNOWN_WRONG).filter((n) => !seenKnown.has(n)).join(" "));
check("機械で走った式が1つ以上ある（比較が空振りでない）", ranOnMachine > 0, `${ranOnMachine} 式`);
console.log(`\n（一致 ${counts.A}・断り ${counts.R}・誤答 ${counts.W}（うち既知 ${seenKnown.size}）・例外 ${counts.X}、機械で走った式 ${ranOnMachine}）`);
console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
