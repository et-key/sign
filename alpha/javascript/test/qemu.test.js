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
import { findStreamFunctions, generatePullers } from "../stream_desugar.js";

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
	// **恒等射（`!__`）は機械の上では `0`（真）である。** インタプリタは射そのものを
	// 返すが、値として運ばれるぶんには「`__` でない」ことしか意味を持たない。
	if (o && typeof o === "object" && o.__identity__) return "0";
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

// ---- 前置 `!` は「`__` かどうか」を反転する ----
//
// `!__` は恒等射（真）、`!x` は `x` が値なら `__`（偽）である。見ているのは中身ではなく
// **不在かどうか**で、それは幅ごとに決まっている。Sign では `0` が真なので、真は `0`・
// 偽は niche を置けばよい。`!__` はこの規則の定数畳み込みにすぎない。
{
	agree("!__ は真（0）", "f : n ? !__\nf 1");
	agree("!値 は偽（__）", "f : n ? !n\nf 5");
	agree("!0 も偽", "f : n ? !n\nf 0");
	agree("!器 は偽", "f : s ? !s\nf `ab`");
	agree("二重否定", "f : n ? !(!n)\nf 5");
	agree("!__ を条件に", "f : n ?\n\t!__ : 1\n\t2\nf 5");
	agree("!値 を条件に", "f : n ?\n\t!n : 1\n\t2\nf 5");
	// 枝が真を返す形（`conflict : … : !__`）。呼び出し側は条件として使う。
	const T = "f : n ?\n\tn > 3 : !__\n\t__\ng : n ?\n\t(f n) : 1\n\t2\n";
	agree("枝で真を返す", T + "g 5");
	agree("枝で偽を返す", T + "g 1");
}

// ---- `__` は幅を持たない ----
//
// 零対象なので、置く場所の広さに合わせて空を書けばよい——1本なら niche、参照なら
// `len = 0` である。ここを「1本の値」として出していたので、`__` を返す枝と器を返す枝の
// 合流がすべて「1本と2本」で落ちていた。型は既に `Unit` だと言っているのだから、幅の話は
// 合流の側で決まる。
{
	const SKIP = "skip : [c ~rest] ?\n\tc = ` ` : skip rest\n\tc rest~\n";
	agree("器と合流する __", "f : s ?\n\t(s ' 0) = ` ` : __\n\ts ' 1~\ng : s ? (f s) ' 0\ng ` ab`");
	agree("器と合流する __（偽）", "f : s ?\n\t(s ' 0) = ` ` : __\n\ts ' 1~\ng : s ? (f s) ' 0\ng `xab`");
	agree("空白を落として引く", SKIP + "f : s ? (skip s) ' 0\nf `   xyz`");
	agree("空白を落として2番目", SKIP + "f : s ? (skip s) ' 1\nf `   xyz`");
	agree("全部空白なら __", SKIP + "f : s ? (skip s) ' 0\nf `   `");
}

// ---- 規則を渡り歩く。カウンタが実際にループになっているかを見る ----
//
// 終わりは添字の側で見る。`c ' i = __` では止まらない——`x = __` は `__` であって
// 真ではないからで、完全性公理はそこまで面倒を見ない。
const SUM = "sum : c i a ?\n\ti > 9 : a\n\tsum c (i + 1) (a + (c ' i))\n";
agree("規則を数え上げる", SUM + "sum [1 ~ 10] 0 0");
agree("降順を数え上げる", SUM + "sum [10 ~ 1] 0 0");
agree("切った規則を数え上げる", SUM + "sum ([1 ~ 20] ' 4~) 0 0");
agree("歩幅つきを数え上げる", SUM + "sum [0 ~+ 3] 0 0");

// ---- カーソル：規則も器も、同じ形で渡り歩ける ----
//
// **これがストリームの原型である。** 状態は「残りへの参照」そのものなので、持ち回るのに
// 記憶は要らない。終わりは `x = __` では見えない（それは常に `__` で偽になる）——
// 完全性公理が入口で止め、`|` がそれを受けて溜めた値を返す。
{
	// 切りながら畳む。切った先は器なら `{ptr+1, len-1}`、規則なら起点をずらしただけ。
	const FOLD = (f) => `${f}\nfold : s a ? (fold (s ' 1~) (step (s ' 0) a)) | a\n`;
	const CNT = FOLD("step : c a ? a + 1");
	const SUM = FOLD("step : c a ? a + c");
	agree("器を渡り歩く", CNT + "fold `abcde` 0");
	agree("規則を渡り歩く", CNT + "fold [1 ~ 10] 0");
	agree("規則を足しながら", SUM + "fold [1 ~ 10] 0");
	agree("降順を渡り歩く", SUM + "fold [10 ~ 1] 0");
	agree("歩幅つきを渡り歩く", SUM + "fold [0 ~+ 3 ~ 20] 0");
	// 枝の中の位置（`k`）を持つ形。1つの入力から2つ出す枝がこれになる。
	agree("枝の中の位置を持つ", "step : c a ? a + 1\ndup : s k a ?\n\tk < 1 : (dup s (k + 1) (step (s ' 0) a)) | a\n\t(dup (s ' 1~) 0 (step (s ' 0) a)) | a\ndup `abc` 0 0");
	// 添字で歩く形。切る形と同じ答えにならなければおかしい。
	agree("添字で歩く", "step : c a ? a + 1\nfold : s i a ? (fold s (i + 1) (step (s ' i) a)) | a\nfold `abcde` 0 0");
}

// ---- 分解したものを組み直すのは恒等射である ----
//
// `lstrip : [c ~rest] ? … c rest` の `c rest` は渡された器そのもので、確保は要らない
// （`{rest.ptr − 幅, rest.len + 1}`）。器を作るのではなく参照を戻すだけである。
{
	const LS = "lstrip : [c ~rest] ?\n\tc = ` ` : lstrip rest\n\tc rest\n";
	agree("組み直して先頭を引く", LS + "f : s ? (lstrip s) ' 0\nf `  ab`\n");
	agree("組み直して2番目を引く", LS + "f : s ? (lstrip s) ' 1\nf `  ab`\n");
	agree("削るものが無い", LS + "f : s ? (lstrip s) ' 0\nf `ab`\n");
	agree("全部消えたら __", LS + "f : s ? (lstrip s) ' 0\nf `   `\n");
	agree("組み直してから切る", LS + "f : s ? ((lstrip s) ' 1~) ' 0\nf `  abc`\n");
	// **撒く形（`c rest~`）が仕様の書き方である**（分解の `[c ~rest]` と対称）。
	// 長い尾でも一致することを見る——尾が1文字だと撒く形と撒かない形が同じ答えになり、
	// 取り違えても気づけない。
	// 後置 `~` が要るのは**余積の側**（返す器を組むところ）であって、引数として渡す
	// ところではない——`lstrip rest` は器を1つ渡しているだけである。
	const LT = "lstrip : [c ~rest] ?\n\tc = ` ` : lstrip rest\n\tc rest~\n";
	agree("撒く形で組み直す", LT + "f : s ? (lstrip s) ' 0\nf `  abcd`\n");
	agree("撒く形の2番目", LT + "f : s ? (lstrip s) ' 1\nf `  abcd`\n");
	agree("撒く形の3番目", LT + "f : s ? (lstrip s) ' 2\nf `  abcd`\n");
	agree("撒く形の外", LT + "f : s ? (lstrip s) ' 9\nf `  abcd`\n");
	// 先頭を落として組み直さない形（残りだけ返す）とも突き合わせる。
	const SH = "strip_head : [c ~rest] ?\n\tc = `#` : rest\n\tc rest\n";
	agree("先頭を落とす", SH + "f : s ? (strip_head s) ' 0\nf `#ab`\n");
	agree("落とさない", SH + "f : s ? (strip_head s) ' 0\nf `ab`\n");
}

// ---- 糖衣が均した先が、元の関数と同じ列になる（実機で） ----
//
// **仕様の答えは元の形が持っている。** だからインタプリタには糖衣を通さない元のソースを
// 渡し、機械には均した先を渡して、同じ答えになることだけを見る。
//
// 均すと `dup s` は列ではなく**カーソル**（`{arm, k, 入力}`）を返す。要素はどこにも
// 置かれず、`cur ' 0` が引いて `cur ' 1~` が1つ進める——器を切るのとまったく同じ書き方で
// あり、消費側は書き換えなくてよい。尽きれば `arm` が niche になるので `__` が出る。
{
	const machineDesugared = (source) => {
		const { nodes, env } = compile(source, { charset: "ascii", desugarStreams: true });
		const r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "ascii", layer: 1 });
		if (r.diagnostics.length) return "出せない：" + r.diagnostics[0].message;
		const v = asInt(runAsm(r.text)[0]);
		return v === null ? "__" : String(v);
	};
	const agreeDesugared = (note, source) => {
		total++;
		let a, b;
		try {
			a = interp(source);
		} catch (e) {
			a = "解釈で例外：" + e.message;
		}
		try {
			b = machineDesugared(source);
		} catch (e) {
			b = "機械で例外：" + e.message;
		}
		if (a === b) {
			passed++;
			console.log(`ok   ${note.padEnd(34)} ${a}`);
		} else {
			console.log(`FAIL ${note.padEnd(34)} 解釈=${a} / 機械=${b}`);
		}
	};
	// `n` 回進めてから引く。器を切るのと同じ書き方である。
	const pull = (call, n) => "(".repeat(n) + call + " ' 1~)".repeat(n) + " ' 0";
	const DUP = "dup : [c ~rest] ? c c (dup rest)\n";
	for (let n = 0; n <= 4; n++) agreeDesugared(`糖衣：${n} 進めて引く`, DUP + `f : s ? ${pull("(dup s)", n)}\nf \`abc\`\n`);
	agreeDesugared("糖衣：尽きたら __", DUP + `f : s ? ${pull("(dup s)", 9)}\nf \`ab\`\n`);
	// 枝で並べる本数が変わる形。`a` は2つ、それ以外は1つ。
	const V = "v : [c ~rest] ?\n\tc = `a` : c c (v rest)\n\tc (v rest)\n";
	for (let n = 0; n <= 3; n++) agreeDesugared(`糖衣：枝で変わる ${n}`, V + `f : s ? ${pull("(v s)", n)}\nf \`ba\`\n`);
	// 仲間へ移る形（引用の中と外）。カーソルの `arm` が群をまたいで動く。
	const P = "p : [c ~rest] ?\n\tc = `-` : c (q rest)\n\tc (p rest)\nq : [c ~rest] ?\n\tc = `-` : c (p rest)\n\tc c (q rest)\n";
	for (let n = 0; n <= 4; n++) agreeDesugared(`糖衣：仲間へ移る ${n}`, P + `f : s ? ${pull("(p s)", n)}\nf \`a-bc\`\n`);
	// 入力を飛ばす形。
	const SK = "sk : [c ~rest] ? c (sk (rest ' 1~))\n";
	for (let n = 0; n <= 2; n++) agreeDesugared(`糖衣：入力を飛ばす ${n}`, SK + `f : s ? ${pull("(sk s)", n)}\nf \`abcdef\`\n`);
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
