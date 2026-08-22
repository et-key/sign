/**
 * Pass 4（AArch64 コード生成）の動作確認。
 *
 * `compiler_pipeline.md` §3 が定める Pass 4 の責務は「固定幅レジスタ操作とジャンプ命令
 * テンプレートの選択のみ」である。したがってここで固定するのは**どの命令が選ばれるか**と
 * **値がどこに置かれるか**であって、最適化の質ではない。
 *
 * 手元にアセンブラが無いため、出力は組み立てずにテキストとして検証する。命令列を読んで
 * 確かめられることは原理1（ソースを読めば命令列が読める）がそもそも要求している性質なので、
 * これは妥協ではなく本来の観測手段でもある。
 *
 * 実行: node test/pass4.test.js（`npm test` からも呼ばれる）
 */
import { compile } from "../compile.js";
import { generateAsm } from "../pass4.js";

let passed = 0;
let total = 0;

function check(note, got, want) {
	total++;
	const ok = JSON.stringify(got) === JSON.stringify(want);
	if (ok) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got:  ${JSON.stringify(got)}`);
		console.log(`     want: ${JSON.stringify(want)}`);
	}
}

function checkTrue(note, cond, detail) {
	total++;
	if (cond) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		if (detail) console.log(`     ${detail}`);
	}
}

function asm(source, target = "aarch64_qemu") {
	const { nodes, env } = compile(source);
	return generateAsm(nodes, env, { target });
}

// ラベル1つ分の本文を、コメントを落とした命令の並びとして取り出す。
function body(source, label) {
	const r = asm(source);
	const lines = r.text.split("\n");
	const i = lines.findIndex((l) => l.startsWith(`${label}:`));
	if (i < 0) return null;
	const j = lines.findIndex((l, k) => k > i && l === "");
	return lines
		.slice(i + 1, j < 0 ? undefined : j)
		.map((l) => l.replace(/\/\/.*$/, "").trim())
		.filter(Boolean);
}

// ---- 命令の選択 ----
//
// 型は「使い捨ての帳簿」として消費される（§3）。`Int` は符号ありなので除算は `sdiv`
// である（target_info.js の SIGNEDNESS）。ここで型の名前が命令に化けて、以降どこにも
// 残らない。
check("加算は add", body("f : a ? a + 1\nf 1", "f").filter((l) => l.startsWith("add ")), ["add x9, x9, x10"]);
check("減算は sub", body("f : a ? a - 1\nf 1", "f").filter((l) => l.startsWith("sub ")), ["sub x9, x9, x10"]);
check("乗算は mul", body("f : a ? a * 2\nf 1", "f").filter((l) => l.startsWith("mul ")), ["mul x9, x9, x10"]);
check("除算は sdiv（Int は符号あり）", body("f : a ? a / 2\nf 1", "f").filter((l) => l.startsWith("sdiv ")), [
	"sdiv x9, x9, x10",
]);

// ---- AAPCS64 ----
//
// 引数は x0〜x7、返値は x0（stack_abi.md §4.2）。
{
	// 呼び出しの直前に並ぶロードが引数の積み込みである（末尾の「返値を x0 へ」と混ぜない）。
	const ls = body("g : a b c ? a\nadd3 : x ? g x x x\nadd3 1", "add3");
	const call = ls.findIndex((l) => l === "bl g");
	const loads = [];
	for (let k = call - 1; k >= 0 && /^ldr x[0-7],/.test(ls[k]); k--) loads.unshift(ls[k].split(",")[0]);
	check("引数は x0 から順に積む", loads, ["ldr x0", "ldr x1", "ldr x2"]);
}
checkTrue("呼び出しは bl", (body("g : a ? a\nf : x ? g x\nf 1", "f") || []).some((l) => l === "bl g"));
checkTrue("返値は x0 へ載せて ret", (body("f : a ? a + 1\nf 1", "f") || []).includes("ret"));

// ---- 式の途中の値はフレームに置く ----
//
// **`bl` は x0〜x7 も x9〜x15 も壊す。** 途中の値をレジスタに置いたままにすると、次の
// 呼び出しで消える——`add (sq n) (sq n)` は1つ目の結果も仮引数 `n` 自身も壊れていた。
//
// だから呼び出しを跨ぐ値は必ずフレームのスロットにある。ここで固定するのは
// 「レジスタに置きっぱなしにしない」という一点であって、命令数ではない。
{
	const src = "sq : x ? x * x\nadd : a b ? a + b\nf : n ? add (sq n) (sq n)\nf 3";
	const ls = body(src, "f");
	const firstCall = ls.findIndex((l) => l === "bl sq");
	const secondCall = ls.findIndex((l, k) => k > firstCall && l === "bl sq");
	const between = ls.slice(firstCall, secondCall);
	// 1つ目の結果は2つ目の呼び出しの前にストアされている。
	checkTrue("呼び出しの結果はスロットへ退避する", between.some((l) => l.startsWith("str x0,")), between.join(" / "));
	// 2つ目の引数は x0 からではなくスロットから読む（x0 は既に潰れている）。
	checkTrue(
		"仮引数は呼び出しの後もスロットから読む",
		between.some((l) => l.startsWith("ldr x9, [x29,")),
		between.join(" / ")
	);
}
// 仮引数は入口で退避される。引数レジスタは最初の呼び出しで壊れるからである。
checkTrue(
	"仮引数を入口でスロットへ写す",
	(body("f : a b ? a + b\nf 1 2", "f") || []).slice(0, 3).some((l) => l.startsWith("str x0, [x29,")),
);

// ---- フレーム ----
//
// AArch64 のスタックは16バイト境界を要求する。大きさは式の深さで決まるので、本体を
// 出してみるまで分からない——だから本文を先に作って後から包む。
{
	const ls = body("f : a ? a + 1\nf 1", "f");
	const open = ls.find((l) => l.startsWith("stp x29, x30"));
	const size = Number((open.match(/#-(\d+)/) || [])[1]);
	checkTrue("フレームは16の倍数", size % 16 === 0, `size=${size}`);
	checkTrue("閉じる大きさが開く大きさと一致する", ls.some((l) => l === `ldp x29, x30, [sp], #${size}`));
}


// ---- 分岐（match_case） ----
//
// **`__` の判定は niche との比較であり、`cbz` ではない。** Sign では `0` は真であり、
// `0 = 0` は真で `0` を返す（comparison.md §2.1）ので、0 を偽と読むと評価器と食い違う。
// niche は `0x8000000000000000`（value_representation.md §3.5）——`Int` では `INT_MIN`、
// `Address` では AArch64 の非正準領域で、どちらも有効な値になりえない点である。
{
	const ls = body("f : x ?\n\tx > 3 : 1\n\t2\nf 5", "f");
	checkTrue("条件は niche と比べる（cbz ではない）", ls.some((l) => l === "movz x12, #0x8000, lsl #48"));
	checkTrue("__ なら次の枝へ飛ぶ", ls.some((l) => /^b\.eq \.Larm/.test(l)));
	checkTrue("枝を通ったら末尾へ飛ぶ", ls.some((l) => /^b \.Lend/.test(l)));
	checkTrue("どの枝も同じスロットへ書く", ls.filter((l) => /^str x9, \[x29, #24\]$/.test(l)).length >= 2, ls.join(" / "));
}
// 比較は値を返す。真ならオペランド、偽なら `__`。どちらのオペランドかは**左辺の値**が
// 決めるので（0 か 1 なら右辺）、実行時に見る必要がある——`csel` を2段重ねる。
{
	const ls = body("f : x ? x > 3\nf 5", "f");
	checkTrue("左辺が単位元かを見る", ls.some((l) => l === "cmp x9, #0") && ls.some((l) => /^ccmp x9, #1, #4, ne$/.test(l)));
	checkTrue("単位元なら右辺を候補にする", ls.some((l) => l === "csel x11, x10, x9, eq"));
	checkTrue("真なら候補、偽なら __", ls.some((l) => l === "csel x9, x11, x12, gt"));
}
check("比較の条件コード", body("f : a ? a < 3\nf 1", "f").filter((l) => /^csel x9, x11, x12,/.test(l)), [
	"csel x9, x11, x12, lt",
]);
// 再帰は分岐があって初めて書ける（Sign にはループが無い）。
check("再帰が出せる", asm("fact : n ?\n\tn > 1 : n * (fact (n - 1))\n\t1\nfact 5").diagnostics.length, 0);
check(
	"相互再帰も出せる",
	asm("even : n ?\n\tn = 0 : 1\n\todd (n - 1)\nodd : n ?\n\tn = 0 : 0\n\teven (n - 1)\neven 4").diagnostics.length,
	0
);
check("枝が1つでも分岐（尽きたら __）", asm("f : x ?\n\tx > 10 : 1\nf 7").diagnostics.length, 0);
// `__` そのものも積める。
checkTrue("__ は niche を積む", (body("f : x ?\n\tx > 3 : __\n\t1\nf 5", "f") || []).some((l) => l === "movz x9, #0x8000, lsl #48"));

// **裸の文字列リテラルはコメントである**（string_and_comment.md）。命令は出ないし、
// 診断にもしない——コメントの数だけ「出せない」が並ぶと本当の穴が埋もれる。
check("コメントは診断にならない", asm("`これはコメント`\nf : a ? a + 1\nf 1").diagnostics.length, 0);

// ---- 出せないものは名指しする ----
//
// 黙って落とすと、命令の無い関数ができあがって「動いたように見える」——型が値より
// 狭いときと同じ種類の嘘である。
checkTrue("族のままなら出せない（GPR か FPU か決まらない）", asm("f : a b ? a + b").diagnostics.length > 0);
checkTrue("浮動小数はまだ出せない", asm("f : a ? 0.0 + a\nf 1.0").diagnostics.length > 0);
checkTrue("16ビットを超える即値はまだ出せない", asm("f : a ? a + 70000\nf 1").diagnostics.length > 0);
checkTrue("未対応ターゲットは名指しする", asm("f : a ? a + 1\nf 1", "cortex_m").diagnostics.length > 0);
// 出せるものは診断が出ない。
check("通る形は診断ゼロ", asm("sq : x ? x * x\nadd : a b ? a + b\nf : n ? add (sq n) (sq n)\nf 3").diagnostics.length, 0);

// ---- 全体の形 ----
//
// トップレベルの式は `_sign_main` に入る（entry_point.md の生成スタブが `bl _sign_main`
// で呼ぶ）。関数は `.global` で外から見える。
{
	const r = asm("sq : x ? x * x\nsq 7");
	checkTrue("_sign_main が出る", r.text.includes("_sign_main:"));
	checkTrue("関数は .global", r.text.includes(".global sq"));
	checkTrue("トップレベルの式は _sign_main の中", r.text.split("_sign_main:")[1].includes("bl sq"));
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
