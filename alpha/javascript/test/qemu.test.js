/**
 * **出した命令列を実際に走らせて、インタプリタと同じ値になるかを見る。**
 *
 * Pass 4 のテストは長らく「その命令が出ているか」しか見ていなかった。それだと
 * **命令は正しいが値が違う**壊れ方をすり抜ける。実際すり抜けていたのが降順レンジで、
 * `[5 ~ 1]` の歩幅がいつも `+1` だったため `[5 ~ 1] ' 1` は 4 ではなく 6 を返して
 * いた。`madd` が出ていることは `start + n × step` が合っていることを意味しない。
 *
 * 走らせる先は OS の上ではなく `-M virt` の裸の AArch64 である。Sign が最終的に
 * 降りていく先がそこなので、確かめる場所もそこでよい。
 *
 * ツールチェーン（clang / ld.lld / qemu-system-aarch64）が無ければ静かに飛ばす——
 * **入っていないことと落ちることは別**である。
 *
 * 実行: node test/qemu.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import { generateAsm } from "../pass4.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "../interpreter.js";
import { runAsm, asInt, available, toolReport } from "../qemu_run.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const parser = peggy.generate(fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8"));

if (!available()) {
	console.log(`ツールチェーンが無いので飛ばす（${toolReport()}）`);
	console.log("\n0/0 passed");
	process.exit(0);
}

let passed = 0;
let total = 0;

// インタプリタ側の答え。観測境界を通した姿で見る。
function interp(source) {
	const { nodes } = compile(source, { parse: parser.parse });
	const env = newRuntimeEnv(null);
	let r = UNIT;
	for (const node of nodes) r = evaluate(node, env);
	if (isUnit(r)) return "__";
	const o = observe(r);
	if (o === undefined || o === null) return "__";
	// **`Char` は符号位置である**（`String ≅ List(0u)`）。インタプリタは読める姿で
	// 1文字を返すが、機械の側にあるのは数である。同じ値の別の見せ方なので揃える。
	if (typeof o === "string" && [...o].length === 1) return String(o.codePointAt(0));
	return String(o);
}

// 機械側の答え。`_sign_main` の x0 を符号付き64ビットで読む。
function machine(source) {
	const { nodes, env } = compile(source, { charset: "ascii" });
	const r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "ascii", layer: 1 });
	if (r.diagnostics.length) return "出せない：" + r.diagnostics[0].message;
	const v = asInt(runAsm(r.text)[0]);
	return v === null ? "__" : String(v);
}

// 同じソースを両方へ通し、答えが一致することだけを見る。**期待値は書かない**——
// 仕様の答えはインタプリタが持っているので、ここで二重に書くと片方だけ直る。
function agree(note, source) {
	total++;
	let a, b;
	try {
		a = interp(source);
	} catch (e) {
		a = "解釈で例外：" + e.message;
	}
	try {
		b = machine(source);
	} catch (e) {
		b = "機械で例外：" + e.message;
	}
	if (a === b) {
		passed++;
		console.log(`ok   ${note.padEnd(34)} ${a}`);
	} else {
		console.log(`FAIL ${note.padEnd(34)} 解釈=${a} / 機械=${b}`);
	}
}

// ---- 算術 ----
agree("足す", "f : n ? n + 1\nf 41");
agree("引く", "f : n ? n - 1\nf 43");
agree("掛ける", "f : n ? n * 3\nf 14");

// ---- 即値。16ビットを超える値は movz/movk の連なりになる ----
agree("16ビットちょうど", "f : n ? 65535 + n\nf 0");
agree("番地リテラル", "f : n ? 0x40000000 + n\nf 1");
agree("2桁ぶんの即値", "f : n ? 1000000 + n\nf 1");
agree("負の即値は movn", "f : n ? n - 1000000\nf 0");

// ---- 規則（レンジ）。要素はどこにも無く、添字は算術で出る ----
agree("無限を引く", "f : n ? [0 ~+ 1] ' n\nf 7");
agree("歩幅つきを引く", "f : n ? [0 ~+ 3] ' n\nf 4");
agree("有界を引く", "f : n ? [0 ~ 3] ' n\nf 2");
agree("有界の外は __", "f : n ? [0 ~ 3] ' n\nf 5");

// **降順**。歩幅が符号を持っていないと、ここが静かに壊れる。
agree("降順の頭", "f : n ? [5 ~ 1] ' n\nf 0");
agree("降順の途中", "f : n ? [5 ~ 1] ' n\nf 1");
agree("降順の末尾", "f : n ? [5 ~ 1] ' n\nf 4");
agree("降順の外は __", "f : n ? [5 ~ 1] ' n\nf 9");

// ---- 規則を切っても規則である ----
// 起点をずらす算術1つで、要素は現れない。切っても向きが動かないのは歩幅が符号を持つから。
agree("切った規則の頭", "f : n ? [0 ~ 3] ' 2~ ' n\nf 0");
agree("切った規則の続き", "f : n ? [0 ~ 3] ' 2~ ' n\nf 1");
agree("切った規則の外", "f : n ? [0 ~ 3] ' 2~ ' n\nf 2");
agree("降順を切る", "f : n ? [10 ~ 1] ' 3~ ' n\nf 0");
agree("降順を切った続き", "f : n ? [10 ~ 1] ' 3~ ' n\nf 2");
agree("歩幅つきを切る", "f : n ? [0 ~+ 2] ' 1~ ' n\nf 3");
agree("二度切る", "f : n ? [0 ~ 9] ' 2~ ' 3~ ' n\nf 1");

// ---- 場所（文字列）。こちらは本当にロードする ----
agree("文字を引く", "s : `abc`\nf : n ? s ' n\nf 1");
agree("文字列の外は __", "s : `abc`\nf : n ? s ' n\nf 9");

// ---- 完全性公理と再帰 ----
agree("__ を渡すと __", "f : n ? n + 1\nf __");
agree("末尾再帰で数える", "g : n a ?\n\tn = 0 : a\n\tg (n - 1) (a + 1)\ng 100 0");
agree("深い末尾再帰", "g : n a ?\n\tn = 0 : a\n\tg (n - 1) (a + n)\ng 1000 0");
// 括弧が要る。並置（適用・連接、tier 10）は算術（tier 13/14）**より優先順位が低い**ので、
// `n * f (n - 1)` は `(n * f) , (n - 1)` と読まれる（operator_table.md）。引数の側に
// 括弧が要らない代わりに、関数を演算子の右へ置くときは括る。
agree("階乗（末尾でない再帰）", "f : n ?\n\tn = 0 : 1\n\tn * (f (n - 1))\nf 10");
agree("引数側は括らなくてよい", "f : n ? n * 2\nf 3 + 4");

// ---- 余積（分岐）----
agree("条件が真", "f : x ?\n\tx = 1 : 10\n\t20\nf 1");
agree("条件が偽", "f : x ?\n\tx = 1 : 10\n\t20\nf 2");
agree("尽きたら __", "f : x ?\n\tx > 10 : 1\nf 7");

// ---- 規則を渡り歩く。カウンタが実際にループになっているかを見る ----
//
// 終わりは添字の側で見る。`c ' i = __` では止まらない——`x = __` は `__` であって
// 真ではないからで、完全性公理はそこまで面倒を見ない。
const SUM = "sum : c i a ?\n\ti > 9 : a\n\tsum c (i + 1) (a + (c ' i))\n";
agree("規則を数え上げる", SUM + "sum [1 ~ 10] 0 0");
agree("降順を数え上げる", SUM + "sum [10 ~ 1] 0 0");
agree("切った規則を数え上げる", SUM + "sum ([1 ~ 20] ' 4~) 0 0");
agree("歩幅つきを数え上げる", SUM + "sum [0 ~+ 3] 0 0");

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
