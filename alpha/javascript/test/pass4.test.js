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


// ---- 単相化（compiler_pipeline.md §3 の IMPORTANT） ----
//
// `@p x` は「どこへ跳ぶか」が実行時にしか分からない形だが、Sign はそこへ実行時
// ディスパッチを置かない——**呼び出しサイト単位で具体化する**。Rust の単相化と同じで、
// `dyn` の側は採らない。
//
// 具体化すると**関数ポインタの引数は消える**。アドレスが命令へ焼き込まれるので、
// レジスタで運ぶ必要が無くなる——`stack_abi.md` の比較表が Sign の欄に
// 「コンパイル時特殊化（コストゼロ）」と書いているのはこのことである。
{
	const src =
		"is_digit : c ? c + 0\nis_alpha : c ? c + 1\ntake_while : p s ? @p s\n" +
		"f : s ? take_while $is_digit s\ng : s ? take_while $is_alpha s\nf 1\ng 2";
	const r = asm(src);
	checkTrue("呼ばれた組み合わせのぶんだけ実体が出る", r.text.includes("take_while$is_digit:") && r.text.includes("take_while$is_alpha:"));
	checkTrue("多相なままの実体は出ない", !r.text.includes("\ntake_while:"));
	// 実体の中では `@p` が直接の `bl` になる。
	checkTrue("`@p` は直接 bl になる", (body(src, "take_while$is_digit") || []).includes("bl is_digit"));
	checkTrue("別の実体は別の呼び先", (body(src, "take_while$is_alpha") || []).includes("bl is_alpha"));
	// 呼び出し側では関数ポインタを渡さない。引数は s だけ。
	const ls = body(src, "f");
	const call = ls.findIndex((l) => l === "bl take_while$is_digit");
	const loads = [];
	for (let k = call - 1; k >= 0 && /^ldr x[0-7],/.test(ls[k]); k--) loads.unshift(ls[k].split(",")[0]);
	check("関数ポインタは引数として渡らない", loads, ["ldr x0"]);
	check("診断は出ない", r.diagnostics.length, 0);
}
// `$名前` 以外では具体化できない。式で作ったアドレスは静的に決まらない。
checkTrue(
	"式で作ったアドレスは名指しする",
	asm("g : x ? x\ntake_while : p s ? @p s\nf : s ? take_while (g 1) s\nf 1").diagnostics.length > 0
);


// ---- 文字は符号位置というスカラー ----
//
// `String ≅ List(0u)`（§2）であり、1要素のリストはスカラーと同型（`[5]` は `Int`）。
// したがって**1文字の文字列は符号位置そのもの**であり、レジスタに乗る。
// `is_digit : c ? \0 <= c <= \9` が `cmp` で書けるのはこれが理由である。
checkTrue("文字リテラルは符号位置", (body("f : x ? x\nf \\a", "f") || []) && asm("c : \\a\nf : x ? x\nf c").diagnostics.length === 0);
check("文字の比較は診断なし", asm("f : c ? c = \\0\nf \\5").diagnostics.length, 0);
// **比較は同種同士でしか成立しない**ので、片側が1文字ならもう片側も文字である
// ——レンジの端点が「両端とも点」であるのと同じ形の推論。仮引数のように中身が
// 見えない側もここで決まる。
checkTrue("片側が文字なら相手も文字として比べる", (body("f : c ? c = \\0\nf \\5", "f") || []).some((l) => l.startsWith("cmp ")));
// 連鎖比較は範囲判定の書き方そのもの。真のとき返るのは**必ず中央**である
// （二項と違い 0/1 の規則は効かない）。
{
	const ls = body("is_digit : c ? \\0 <= c <= \\9\nis_digit \\5", "is_digit");
	check("連鎖比較は診断なし", asm("is_digit : c ? \\0 <= c <= \\9\nis_digit \\5").diagnostics.length, 0);
	checkTrue("両方の条件を取って and する", ls.some((l) => l === "and x11, x11, x13"), ls.join(" / "));
	checkTrue("真なら中央を返す", ls.some((l) => l === "csel x9, x10, x12, ne"));
}
// ---- 完全性公理（`f __ = __`） ----
//
// **これは最適化ではなく終端そのものである。** Sign にループは無く再帰しかないので
// （0_design_principles.md 原理5）、ここを出さないと「命令は出ているのに止まらない」
// ——診断も出ない一番たちの悪い形になる。
{
	const fb = body("f : x ? x + 1\nf 2", "f");
	// 検査は**仮引数をスロットへ写した後**。TCO でフレームを使い回すとき、飛び先が
	// この検査より後ろにあると初回しか通らず、ループが終わらない。
	const store = fb.findIndex((l) => l === "str x0, [x29, #16]");
	const test = fb.findIndex((l) => l.startsWith("b.eq .Lunit"));
	checkTrue("仮引数を写してから検査する", store >= 0 && test > store, fb.join(" / "));
	// 本体へ入る前に飛ぶ（`add` は検査より後ろ）。
	const work = fb.findIndex((l) => l.startsWith("add x9"));
	checkTrue("本体へ一歩も入らない", work > test, fb.join(" / "));
	checkTrue("崩壊したら __ を返す", fb.some((l) => l === "movz x0, #0x8000, lsl #48"), fb.join(" / "));
}
// **判定の仕方は幅で違う。** 1本なら niche、2本なら `len = 0`——`emitUnit` の裏返しで
// あって、新しい規則ではない。
{
	const gb = body("g : s ? s\ng `hello`", "g");
	checkTrue("2本なら len を見る", gb.some((l) => l === "cmp x9, #0"), gb.join(" / "));
	checkTrue("2本なら __ も2本で返す", gb.some((l) => l === "mov x1, #0"), gb.join(" / "));
}
// 引数が複数なら**どれか1つでも** `__` で崩壊する（unit.md「所有の引数に有効値が揃って
// 初めて呼び出しは真」）。
{
	const hb = body("h : a b ? a + b\nh 1 2", "h");
	check("引数の数だけ検査する", hb.filter((l) => l.startsWith("b.eq .Lunit")).length, 2);
	check("飛び先は1つ", new Set(hb.filter((l) => l.startsWith("b.eq .Lunit"))).size, 1);
}
// ---- 要素の並びは参照で運ぶ（stack_abi.md §4.6） ----
//
// 2文字以上は `String` であり、中身は `.rodata` に置いて `{ptr, len}` の2本で渡す。
// 1文字が `Char` としてレジスタ1本に乗るのと**同じ型が2通りの運ばれ方をしない**のは、
// 1文字と2文字以上が別の型だからである（type_system.md §2）。
{
	const src = "f : s ? s\nf `hello`";
	const r = asm(src);
	check("文字列は診断なしで出る", r.diagnostics.length, 0);
	checkTrue("中身は .rodata へ置く", r.text.includes(".section .rodata"), r.text);
	checkTrue("1 byte 幅なら .ascii で書ける", r.text.includes('.ascii "hello"'), r.text);
	// アドレスは `adrp` + `:lo12:` で作る。PC 相対なので位置独立のまま。
	const main = body(src, "_sign_main");
	checkTrue("adrp でラベルの頁を取る", main.some((l) => l === "adrp x9, .Lstr0"), main.join(" / "));
	checkTrue(":lo12: で下位12ビットを足す", main.some((l) => l === "add x9, x9, :lo12:.Lstr0"));
	// **`len` は文字数であってバイト数ではない。** `String ≅ List(Char)` の要素数なので、
	// charset を変えても同じ値でなければ添字がずれる。
	checkTrue("len は文字数", main.some((l) => l === "mov x10, #5"), main.join(" / "));
	// 引数は2本使う。器を1本に詰めない。
	const call = main.findIndex((l) => l === "bl f");
	check("ptr は x0、len は x1", main.slice(call - 2, call), ["ldr x0, [x29, #16]", "ldr x1, [x29, #24]"]);
	// 返値も2本。AAPCS64 が16バイトの複合型を x0/x1 で返すのと同じ置き方。
	const fb = body(src, "f");
	// 崩壊の出口へ飛ぶ直前が、本体を通ったときの返値の積み込みである。
	const ret = fb.findIndex((l) => l.startsWith("b .Ldone"));
	check("返値も x0/x1 の2本", fb.slice(ret - 2, ret), ["ldr x0, [x29, #32]", "ldr x1, [x29, #40]"]);
}
// 中身が同じ文字列は1つに畳む（キーは符号位置の並び）。
{
	const r = asm("f : s ? s\nf `ab`\nf `ab`\nf `cd`");
	check("同じ中身は1つに畳む", (r.text.match(/^\.Lstr\d+:$/gm) || []).length, 2);
}
// `charset` は**要素の幅だけ**を決める。文字数は変わらない。
{
	const { nodes, env } = compile("f : s ? s\nf `ab`", { charset: "utf32" });
	const r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "utf32" });
	checkTrue("utf32 では 4 byte 要素で置く", r.text.includes(".balign 4") && r.text.includes(".word 0x61, 0x62"), r.text);
	checkTrue("len は charset に依らず文字数", r.text.includes("mov x10, #2"), r.text);
}
// 器はレジスタ1本の演算に当たらない。**黙って先頭のスロットだけ見ない**。中身の比較には
// 長さの一致と要素の走査が要るので、そこは別の命令列になる。
{
	const ds = asm("f : s ? s = `ab`\nf `cd`").diagnostics.map((d) => d.message);
	checkTrue("器どうしの比較は理由を名指しする", ds.some((m) => m.includes("String と String")), JSON.stringify(ds));
}
// ---- 幅のある値を返す分岐 ----
//
// どの枝を通っても同じ場所に値がある、という一点は幅が2本でも変わらない。
{
	const src = "f : c ?\n\tc = 0u61 : `yes`\n\t`no`\nf 0u61";
	const r = asm(src);
	check("器を返す分岐は出る", r.diagnostics.length, 0);
	const fb = body(src, "f");
	// 枝の値は ptr と len の2本まとめて出力スロットへ写る。
	check("2本まとめて写す", fb.filter((l) => l === "str x9, [x29, #24]").length, 2);
	check("len も写す", fb.filter((l) => l === "str x9, [x29, #32]").length, 2);
}
// **どの枝も通らなかったときの `__` は、幅ごとに表し方が違う。**
//
//   1本  上位ビットの niche（value_representation.md §3.5）
//   2本  `len = 0`——空文字列・空リストが `__` そのものだから（`__ = []`、unit.md）
//
// 新しい表現を足したのではなく、元からある同一視をそのまま命令にしている。
{
	const one = body("f : c ?\n\tc = 0u61 : 1\nf 0u61", "f");
	checkTrue("1本なら niche", one.some((l) => l === "movz x12, #0x8000, lsl #48"), one.join(" / "));
	const two = body("f : c ?\n\tc = 0u61 : `yes`\nf 0u61", "f");
	checkTrue("2本なら len = 0", two.some((l) => l === "mov x12, #0"), two.join(" / "));
}
// 幅の違う枝の直和（`Char | String`）は、広い方へ持ち上げる規則が仕様にある
// （type_system.md §2）が、その持ち上げにはメモリの確保が要るのでまだ出さない。
{
	const ds = asm("f : c ?\n\tc = 0u61 : `yes`\n\t0u62\nf 0u61").diagnostics.map((d) => d.message);
	checkTrue("幅の違う枝は持ち上げとして名指しする", ds.some((m) => m.includes("持ち上げ")), JSON.stringify(ds));
}

// **トップレベルの定数はその場で畳む。** `名前 : 値` は束縛であって場所ではないので、
// 値そのものを書けば済む——ロードは要らない。
check("定数参照は畳まれる", asm("one : 1\nf : x ? x + one\nf 2").diagnostics.length, 0);
checkTrue("畳んだ結果はリテラルと同じ命令", (body("one : 1\nf : x ? x + one\nf 2", "f") || []).some((l) => l === "mov x9, #1"));


// ---- 短絡（`&` と `|`） ----
//
// どちらも「左を見て、右を評価するかどうかを決める」形である。
//
//   &   左が `__` なら全体が `__`（右は評価しない）
//   |   左が `__` でなければ左が結果（右は評価しない）
//
// **評価しないことは意味論の一部である。** Sign は副作用と非停止を持つので、
// `__ & ($UART # x)` で書き込みが起きるかどうかが変わる（operator_table.md
// 「Unit 欄の読み方」）。命令の節約ではなく、評価するかしないかを出している。
{
	const ls = body("f : a b ? a > 0 & b > 0\nf 1 2", "f");
	checkTrue("左が __ なら右へ行かず飛ぶ", ls.some((l) => /^b\.eq \.Lsc/.test(l)), ls.join(" / "));
	checkTrue("飛び先は右辺の後ろ", ls.some((l) => /^\.Lsc\d+:$/.test(l)));
}
{
	const ls = body("f : a b ? a > 0 | b > 0\nf 1 2", "f");
	checkTrue("`|` は左が __ でなければ飛ぶ", ls.some((l) => /^b\.ne \.Lsc/.test(l)), ls.join(" / "));
}
check("入れ子でも出る", asm("f : a b c ? (a > 0 & b > 0) | c > 0\nf 1 2 3").diagnostics.length, 0);
// `|` はバックトラックの書き方でもある（n_queens.sn の try_col がこの形）。
check("バックトラックの形", asm("g : x ? x\nf : a ? (g a) | (f (a - 1))\nf 3").diagnostics.length, 0);

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
