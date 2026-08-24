/**
 * ストリームを返す関数を、引ける規則へ均す糖衣（stream_desugar.js）。
 *
 * **見るのは「元の関数と同じ列になるか」だけ**である。生成したものが元と違う意味に
 * なっていても見た目では分からないので、期待値は書かず、元の関数をインタプリタで
 * 走らせた答えと突き合わせる。
 *
 * 実行: node test/stream_desugar.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "../interpreter.js";
import { findStreamFunctions, generatePullers, printNode, printParams } from "../stream_desugar.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const parser = peggy.generate(fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8"));

let passed = 0;
let total = 0;

function check(note, got, want) {
	total++;
	const ok = JSON.stringify(got) === JSON.stringify(want);
	if (ok) passed++;
	console.log(`${ok ? "OK  " : "FAIL"} ${note}`);
	if (!ok) {
		console.log(`     got:  ${JSON.stringify(got)}`);
		console.log(`     want: ${JSON.stringify(want)}`);
	}
}
function checkTrue(note, cond, extra) {
	check(note, !!cond, true);
	if (!cond && extra) console.log(`     ${extra}`);
}

function run(source) {
	const { nodes } = compile(source, { parse: parser.parse });
	const env = newRuntimeEnv(null);
	let r = UNIT;
	for (const node of nodes) r = evaluate(node, env);
	return isUnit(r) ? "__" : observe(r);
}
function streams(src) {
	return findStreamFunctions(compile(src, { charset: "ascii" }).nodes);
}

// ---- 何がストリームで、何がそうでないか ----
//
// 枝が「有限個の要素を並べて、最後に自分（か仲間）をもう一度呼ぶ」形をしているものだけ。
// 並べる要素が1つも無ければただの末尾呼び出しであって、状態機械の枝ではない。
check("1枝のストリーム", streams("dup : [c ~rest] ? c c (dup rest)").map((f) => [f.name, f.arms.length, f.arms[0].prefix.length]), [["dup", 1, 2]]);
check("多枝のストリーム", streams("sep : [c ~rest] ?\n\tc = 1 : c c (sep rest)\n\tc (sep rest)").map((f) => f.arms.map((a) => a.prefix.length)), [[2, 1]]);
check("相互再帰も群になる", streams("a : [c ~rest] ? c (b rest)\nb : [c ~rest] ? c c (a rest)").map((f) => f.name), ["a", "b"]);
check("ふつうの関数は違う", streams("f : n ? n + 1"), []);
check("末尾呼び出しだけは違う", streams("f : s ? g (s ' 1~)\ng : s ? f (s ' 1~)"), []);
check("畳み込みは違う", streams("fold : s a ? (fold (s ' 1~) (a + 1)) | a"), []);

// ---- 印字。糖衣だと言うからには目で読めなければならない ----
{
	const lam = compile("sep : [c ~rest] ?\n\tc = 1 : c (rest ' 0)\n\t!c & (c > 2) : c\n", { charset: "ascii" }).nodes[0].right;
	check("仮引数はブラケットごと", printParams(lam.left), "[c ~rest]");
	// ブラケットの有無で意味が変わる（1引数を分解する／先頭と可変長）ので、落としてはいけない。
	const bareLam = compile("f : c ~rest ? c", { charset: "ascii" }).nodes[0].right;
	check("裸の rest はブラケット無し", printParams(bareLam.left), "c ~rest");
	check("ガードも印字できる", printNode(lam.right.lines[1].left), "(!c & ((c > 2)))");
}

// ---- 生成物は元の列と一致する ----
//
// 消費側（`run`）は手で書く。カーソルは `(a, k, s)` の3つで、`a` が枝、`k` が枝の中の
// 位置、`s` が残りの入力である。要素はどこにも置かれない。
// 長さを数える消費側。
const RUN = (g) => `run : a k s acc ?\n\tk < (${g}_len a) : (run a (k + 1) s (acc + 1)) | acc\n\t(run (${g}_na a (${g}_nx a s)) 0 (${g}_nx a s) acc) | acc\n`;

// **中身も数える消費側。** `Char` に算術は無いので（仕様通り、算術は `__` へ落ちる）、
// 比較して `hit` で 1 を作る。`hit __` は完全性公理で `__` になり、`| 0` が受ける。
const RUN_CH = (g, ch) =>
	`hit : c ? 1\nrun : a k s acc ?\n\tk < (${g}_len a) : (run a (k + 1) s (acc + ((hit ((${g}_at a k s) = \`${ch}\`)) | 0))) | acc\n` +
	`\t(run (${g}_na a (${g}_nx a s)) 0 (${g}_nx a s) acc) | acc\n`;

/**
 * 元の関数が作る列と、生成した規則から引ける列が一致することを見る。
 *
 * 長さだけでは足りない——並べる要素を取り違えていても長さは合う。文字ごとの個数まで
 * 数えれば、どの枝がどの要素を出すかも見ていることになる。**期待値は書かない**：
 * 仕様の答えは元の関数が持っている。
 */
function sameStream(note, def, input) {
	const name = /^(\w+)/.exec(def)[1];
	const want = run(`${def}\n${name} ${input}\n`);
	const g = generatePullers(findStreamFunctions(compile(def, { charset: "ascii" }).nodes));
	if (!g) return checkTrue(note, false, "生成できなかった");
	if (typeof want !== "string") return checkTrue(note, false, `元が列にならない：${JSON.stringify(want)}`);
	// 糖衣なら元の定義は消える。生成した規則だけで同じ列が引けなければならない。
	const head = `run (${name}_arm ${input}) 0 ${input} 0\n`;
	const len = run(g.source + RUN(g.group) + head);
	const bad = [];
	if (len !== want.length) bad.push(`長さ ${want.length} → ${len}`);
	for (const ch of new Set([...want])) {
		const n = [...want].filter((x) => x === ch).length;
		const got = run(g.source + RUN_CH(g.group, ch) + head);
		if (got !== n) bad.push(`${ch} が ${n} → ${got}`);
	}
	checkTrue(note, bad.length === 0, `元=${JSON.stringify(want)}  ${bad.join(" / ")}`);
}
const sameLength = sameStream;
sameLength("そのまま流す", "id : [c ~rest] ? c (id rest)", "`abcde`");
sameLength("1つを2つにする", "dup : [c ~rest] ? c c (dup rest)", "`abc`");
sameLength("1つを3つにする", "tri : [c ~rest] ? c c c (tri rest)", "`ab`");
sameLength("入力を飛ばす", "sk : [c ~rest] ? c (sk (rest ' 1~))", "`abcdef`");
sameLength("枝で本数が変わる", "v : [c ~rest] ?\n\tc = `a` : c c (v rest)\n\tc (v rest)", "`abaca`");
sameLength("仲間へ移る", "p : [c ~rest] ?\n\tc = `\"` : c (q rest)\n\tc (p rest)\nq : [c ~rest] ?\n\tc = `\"` : c (p rest)\n\tc c (q rest)", '`ab"cd"ef`');

// ---- 実物を読めること ----
//
// `preprocess.sn` の `sep` / `in_quote` が本当に列を作っている2つで、`walk`（状態を
// 5つ持ち回る）や `preprocess`（ただの末尾呼び出し）はそうではない。
// ---- 均せない形は均さない ----
//
// **要素そのものが構築なら均せない。** `space (c (rest ' 0) (rest ' 1)) space` の真ん中は
// 1つの要素であって3つではない（`a (b c) d` は `["a","bc","d"]`——余積は「右辺を1要素として
// 足す」）。平らにすると答えが変わり、そのまま返すと複数文字の器をその場で作ることになる。
// どちらも黙ってやってはいけない。
check("入れ子の構築は均さない", streams("f : [c ~rest] ? c (c (rest ' 0)) c (f rest)"), []);
// **群は閉じていなければならない。** 枝が移る先が均されていなければ `_na` は存在しない
// 名前へ跳ぶ。片方だけ均すのは跳び先を失うことである。
{
	const half = "p : [c ~rest] ? c (q rest)\nq : [c ~rest] ? c (q (rest ' 1~)) (r rest)\nr : n ? n";
	checkTrue("閉じない群は生成しない", generatePullers(streams(half)) === null);
	const closed = "p : [c ~rest] ? c (q rest)\nq : [c ~rest] ? c c (p rest)";
	checkTrue("閉じた群は生成する", generatePullers(streams(closed)) !== null);
}

// ---- 実物を読めること ----
{
	const src = fs.readFileSync(path.join(__dirname, "..", "..", "sign", "preprocess.sn"), "utf8");
	const found = streams(src);
	// `sep` は枝の真ん中に構築があるので均せない（上の規則）。`in_quote` は均せるが、
	// 枝が `sep` へ移るので群が閉じない——だから preprocess.sn はまだ均せない。
	check("preprocess.sn のストリーム", found.map((f) => f.name).sort(), ["in_quote"]);
	check("in_quote の枝の本数", found.find((f) => f.name === "in_quote").arms.map((a) => a.prefix.length), [1, 1, 1]);
	checkTrue("群が閉じないので生成しない", generatePullers(found) === null);
	// 状態が1つの器で表せない形（`walk`）はまだ均さない——カーソルが太る。
	checkTrue("walk は含まれない", !found.some((f) => f.name === "walk"));
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
