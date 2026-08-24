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

/**
 * 出せないものが**名指しされている**ことを見る。黙って別の答えを出していないこと、
 * すなわち「まだ」と言えていることの確認である。
 */
function checkNamed(note, source) {
	total++;
	let msg = "（診断が出なかった）";
	try {
		const { nodes, env } = compile(source, { charset: "ascii" });
		const r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "ascii", layer: 1 });
		if (r.diagnostics.length > 0) {
			passed++;
			console.log(`ok   ${note.padEnd(34)} ${r.diagnostics[0].message.replace(/（.*/, "")}`);
			return;
		}
	} catch (e) {
		msg = "例外：" + e.message;
	}
	console.log(`FAIL ${note.padEnd(34)} ${msg}`);
}

/**
 * 機械の側だけを見る。**インタプリタと同じものをモデルしていない場所**で使う——
 * 番地の算術がそれで、インタプリタは参照セル（getter/setter）、機械は整数である。
 * 突き合わせられないので期待値を書くしかない。使うのはここだけに留める。
 */
function machineIs(note, source, want) {
	total++;
	let got;
	try {
		got = machine(source);
	} catch (e) {
		got = "機械で例外：" + e.message;
	}
	if (got === want) {
		passed++;
		console.log(`ok   ${note.padEnd(34)} ${got}`);
	} else {
		console.log(`FAIL ${note.padEnd(34)} 期待=${want} / 機械=${got}`);
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

// ---- アドレスは指す先を覚える（`Address(T)`） ----
//
// `Address` だけでは `@c` の型が決まらない——C の `int*` と `cell*` の区別が無い状態で
// ある。`$` は何を指したのかを知っているので、そこで書き留めて、束縛・返値・呼び出し
// サイトを通して運ぶ（`List(T)` の要素型とまったく同じ機構）。**型は帳簿なので、
// 指す先を1つ足しても命令は1つも増えない。**
{
	// **場所は下へしか流せない。** `$匿名式` は `sub sp` で自分のフレームに取るので、
	// 呼び出し側から渡すぶんには生きているが、返すと死ぬ（下の「返せない」を見よ）。
	const GET = "get : c ? @c\n";
	agree("渡して読む", GET + "f : n ? get ($(n + 4))\nf 1");
	agree("渡した先で計算", GET + "f : n ? (get ($(n + 4))) + 1\nf 1");
	agree("書いてから渡す", GET + "f : n ? get (($(n + 4)) # 99)\nf 1");
	agree("2つ渡す", GET + "f : n ? (get ($(n + 1))) + (get ($(n + 2)))\nf 10");
}

// ---- 指したまま引く（Struct のフィールド addressing） ----
//
// **1語より広い指す先は読むのではなく引く。** 器（`{ptr, len}`）を指すアドレスは、その
// アドレスが既に `ptr` である——要るのは `len` だけで、それは形が知っている。
// **ロードは1つも出ない**：アドレスを参照として読み替えるだけである。
{
	machineIs("組の1語目", "f : n ? (@($(n , 99))) ' 0\nf 7", "7");
	machineIs("組の2語目", "f : n ? (@($(n , 99))) ' 1\nf 7", "99");
	machineIs("3つ組の真ん中", "f : n ? (@($(n , 99 , 5))) ' 1\nf 7", "99");
	machineIs("3つ組の末尾", "f : n ? (@($(n , 99 , 5))) ' 2\nf 7", "5");
	machineIs("範囲外は __", "f : n ? (@($(n , 99))) ' 5\nf 7", "__");
	// 渡してから引く（下へ流すのは合法）。
	machineIs("渡して引く", "snd : c ? (@c) ' 1\nf : n ? snd ($(n , 99))\nf 7", "99");
}

// ---- 自分のフレームに置いたものは返せない ----
//
// `$匿名式` は `sub sp` で場所を取るが、エピローグの `mov sp, x29` がそれを捨てる——
// 返したアドレスは死んだ場所を指す（memory_management.md §2）。**黙って壊れたアドレスを
// 返さずに名指しする**。返す規約（sret）が決まればここが道になる。
{
	checkNamed("箱を返す", "box : v ? $(v + 0)\nf : n ? @(box n)\nf 7");
	checkNamed("組を返す", "cons : h t ? $(h , t)\nf : n ? (@(cons n 9)) ' 0\nf 7");
	checkNamed("枝の片方で返しても", "box : v n ?\n\tn > 3 : $(v + 0)\n\t$__\nf : n ? @(box n n)\nf 7");
	// 名前付き識別子と `__` は場所を取らないので返せる（既にある所を指すだけ）。
	agree("仮引数のアドレスは返せる", "adr : v ? $v\nf : n ? @(adr n)\nf 7");
	agree("$__ は返せる", "z : n ? $__\nf : n ? @(z n)\nf 7");
}

// ---- `$匿名式` はその場に置いてアドレスを返す ----
//
// 書くのは `#`（中置）、読むのは `@`。**順序は式の形が決める**——Sign には逐次実行が
// 無い（関数本体は match_case で枝を1つ選ぶ）ので、`#` が返すアドレスを `@` が受ける
// 形でしか「書いてから読む」を書けない。
{
	agree("置いて読む", "f : n ? @($(n + 4))\nf 1");
	agree("2つ置いて足す", "f : n ? (@($(n + 1))) + (@($(n + 2)))\nf 10");
	agree("置いた場所へ書き直す", "f : n ? @(($(n + 1)) # 99)\nf 10");
	agree("$__ は niche のまま", "f : n ? @($__)\nf 1");
	// 組を置けば cons セルになる。`{ptr, len}` の器ではなく、幅の決まった組である。
	//
	// **ここはインタプリタと突き合わせられない。** インタプリタはアドレスを参照セル
	// （getter/setter の組）としてモデルしており、数ではないので `c + 8` が書けない。
	// 機械の側では番地は整数そのものである。同じものの別のモデルであって、どちらかが
	// 間違っているのではない——だから期待値をここに書く。
	const CONS = "cons : h t ? $(h , t)\n";
	// **組を指すアドレスは `@` では読めない。** 指す先が2語なので、1語を読む `@` では
	// 足りない——以前は黙って先頭1語を読んでいて、cons セルでは**たまたま頭が出ていた**。
	// 正しくは指したまま引く（Struct のフィールド addressing）。
	checkNamed("組は @ では読めない", CONS + "f : n ? @(cons n 99)\nf 7");
	// 番地の算術を挟むと指す先が分からなくなるので、そこは1語として読む（従来通り）。
	// 場所は下へしか流せないので、組は同じ関数の中で置いて引く。
	machineIs("番地をずらして1語", "f : n ? @(($(n , 99)) + 8)\nf 7", "99");
	machineIs("ずらした先も1語", "f : n ? @(($(n , 99 , 5)) + 16)\nf 7", "5");
	// 2つ置けば別の場所になる（16 バイトずつ下がる）。
	machineIs("別の場所になる", "f : n ? ($(n + 1)) - ($(n + 2))\nf 10", "16");
}

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

// ---- 幅の違う枝の直和は広い方へ揃える ----
//
// `Char | String` は「1本の枝と2本の枝」で、型の側に1つの答えは無い。置き方の話なので
// `passingOf` が広い方（参照）を採る。**狭い枝を広げるのに確保は要らない**——リテラルの
// 1文字は `.rodata` に置き場所がある。1文字を「長さ1の文字列」として扱うのは
// `String ≅ List(0u)` の言い換えでしかない。
{
	const D = "f : c ?\n\tc = 0u61 : `yes`\n\t0u62\n";
	agree("直和：広い枝を引く", D + "g : c ? (f c) ' 0\ng 0u61");
	agree("直和：狭い枝を引く", D + "g : c ? (f c) ' 0\ng 0u63");
	agree("直和：広い枝の2番目", D + "g : c ? (f c) ' 1\ng 0u61");
	agree("直和：狭い枝の2番目は __", D + "g : c ? (f c) ' 1\ng 0u63");
	// 名前で書かれていても中身がリテラルなら同じ（`indent : \t` の形）。
	const N = "ind : `\t`\ngap : n s ?\n\tn > 2 : ind\n\ts\n";
	agree("名前ごしのリテラルも広がる", N + "f : n ? (gap n `xy`) ' 0\nf 5");
	agree("名前ごしでも器の枝は器", N + "f : n ? (gap n `xy`) ' 0\nf 1");
	agree("広げた枝の長さは1", N + "f : n ? (gap n `xy`) ' 1\nf 5");
	// `__` とも合流する（`__` は幅を持たないので、揃えるのは器の側だけ）。
	agree("直和と __ の三つ巴", "h : n s ?\n\tn > 2 : `z`\n\tn > 1 : __\n\ts\nf : n ? (h n `xy`) ' 0\nf 5");
}

// ---- 長さ1のリストは存在しない ----
//
// 1要素の器はスカラーと同型なので（`[5]` は `Int`）、その瞬間にスカラーへ落ちる。
// 値はもうそうなっていた（インタプリタ）——**型だけが器のまま取り残されていた**。
// 型が値より広いのは `is_digit` を壊したのと同じ形である。
//
// **決まらないものは触らない。** 終端の無い切り出しは器の長さが要る。
//
// なお**直和は両方とも静的である**。`Char | String` は「どちらか分からない」ではなく
// 「経路によって型が違う」ことで、実際 `gap` の枝はリテラルの `Char` と計算した
// `String` である——どちらもコンパイル時に決まっている。実行時に決まるのは**どの経路を
// 通るか**だけであり、だからこそ幅を揃える（広い方へ）のもコンパイル時にできる。
{
	agree("長さ1の切り出しは文字", "f : s ? s ' (1 ~+ 1 ~ 1)\nf `abc`");
	agree("長さ2なら器のまま", "f : s ? (s ' (1 ~+ 1 ~ 2)) ' 1\nf `abc`");
	agree("端点が同じレンジ", "f : n ? [3 ~ 3]\nf 1");
	agree("端点が同じレンジを引く", "f : n ? [3 ~ 3] ' 0\nf 1");
	agree("長さ1の切り出しで計算", "f : s ? (s ' (1 ~+ 1 ~ 1)) = `b`\nf `abc`");
	// **終端の無い形でも、器の長さが分かれば決まる。** リテラルの器なら静的に出る
	// ——決まるものは決める（原理4は「決まらないものを決めるな」であって、その逆ではない）。
	agree("末尾1文字（リテラル）", "s : `abc`\nf : n ? s ' 2~\nf 1");
	agree("末尾2文字は器のまま", "s : `abc`\nf : n ? (s ' 1~) ' 1\nf 1");
	// 仮引数の長さは器に依るので決まらない。そこは器のままである。
	agree("仮引数は器のまま", "f : s ? (s ' 1~) ' 0\nf `abc`");
}

// ---- 恒等射は命令を持たない ----
//
// **1要素リストとスカラーは同型である**ので、その 0 番目は自分自身である。`x ' 0~` も
// 丸ごとであり、器でも規則でも変わらない。添字がリテラルならコンパイル時に決まっている
// ——それでも実行時に比べていた。`$__ = __ = @__` と同じ形で、型の上では別のものでも
// 機械の上では同じでなければならない。**値が変わらないことを実機で確かめる。**
{
	agree("scalar ' 0", "f : n ? n ' 0\nf 5");
	agree("scalar ' 0~", "f : n ? (n ' 0~) + 1\nf 5");
	agree("1要素の外は __", "f : n ? n ' 1\nf 5");
	agree("1要素を越えて切る", "f : n ? (n ' 1~) ' 0\nf 5");
	agree("器 ' 0~", "f : s ? (s ' 0~) ' 1\nf `abc`");
	agree("規則 ' 0~", "f : n ? ([1 ~ 5] ' 0~) ' 2\nf 1");
	agree("式の中でも", "f : n ? (n ' 0) + 1\nf 5");
	// 実行時の添字は畳めない（そこは比べて選ぶ）。
	agree("実行時の添字 0", "f : n i ? n ' i\nf 5 0");
	agree("実行時の添字 1", "f : n i ? n ' i\nf 5 1");
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
