/**
 * 形の解決（Pass 3.5）——大きさとバイトオフセット。
 *
 * Pass 3 が型の**名前**を、`target_info.js` がスカラーの**幅**を出す。ここはその2つを
 * 合わせて「各スロットがどこに在るか」を確定させる。`compiler_pipeline.md` §3 が Pass 4 へ
 * 渡すと定めた情報の最後の一片である。
 *
 * 実行: node test/layout.test.js（`npm test` からも呼ばれる）
 */
import { compile } from "../compile.js";
import { measure, layoutOfStruct, alignUp } from "../layout.js";

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

const A64 = { target: "aarch64_qemu", charset: "utf32" };

function rhs(source) {
	return compile(source).nodes[0].right;
}
function sizeOf(source, conf = A64) {
	const m = measure(rhs(source), conf);
	return m && m.size;
}
// スロットを `名前@オフセット`（連番なら `[n]@オフセット`）の並びにする。
function slotsOf(source, conf = A64) {
	const l = layoutOfStruct(rhs(source), conf);
	return l && l.slots.map((s) => `${s.name !== undefined ? s.name : `[${s.ordinal}]`}@${s.offset}`);
}

// ---- スカラー ----
check("Int は 8 byte", sizeOf("x : 42"), 8);
check("Float も 8 byte", sizeOf("x : 3.14"), 8);
check("Address も 8 byte", sizeOf("p : 0x40011000"), 8);
check("Unit は場所を占めない", sizeOf("u : __"), 0);

// ---- String は `List(0u)`。要素幅は charset が決める ----
check("utf32 なら 1文字 4 byte", sizeOf("s : `abc`"), 12);
check("ascii なら 1文字 1 byte", sizeOf("s : `abc`", { target: "aarch64_qemu", charset: "ascii" }), 3);
check("コードポイント単位で数える（サロゲートペアも1文字）", sizeOf("s : `𝄞`"), 4);

// ---- List は要素幅 × 個数 ----
check("整数3個なら 24 byte", sizeOf("l : [1 2 3]"), 24);
check("実数2個なら 16 byte", sizeOf("l : [1.0 2.0]"), 16);

// ---- 名前付きスロットは名前ソート順に並ぶ（stack_abi.md §7.1） ----
//
// `==` で等しい構造体が同じ物理配置を持つための規則である。宣言順は型が (型, 連番) の形で
// 別に保存しているので情報は失われない。**詰め込み効率のための並べ替えはしない**
// ——並びを決めるのは名前であって、コンパイラの裁量ではない。
check("名前順に並ぶ", slotsOf("p : [\n\tx : 1\n\ty : 2\n]"), ["x@0", "y@8"]);
check("宣言順が逆でも物理配置は名前順で同じ", slotsOf("p : [\n\ty : 2\n\tx : 1\n]"), ["x@0", "y@8"]);
// 宣言順と物理配置がねじれる例。宣言は CR→SR→DR だが、名前順では CR→DR→SR になる。
// ねじれ自体は型の側（`Struct{CR : Address , 0  DR : String , 2  SR : Int , 1}`）に保存される。
check(
	"ねじれてもオフセットは名前順で決まる",
	slotsOf("uart : [\n\tCR : 0x40011000\n\tSR : 3\n\tDR : `d`\n]"),
	["CR@0", "DR@8", "SR@16"]
);

// ---- 連番スロットは宣言順がそのまま物理配置 ----
//
// ソートの鍵となる名前が無いためである。MMIO・FFI・シリアライズはこちらで書く
// ——「N番目は offset N×幅」の確約が得られるのは連番スロットだけである（§7.1 の CAUTION）。
check("宣言順に並ぶ", slotsOf("t : 1 , 2 , 3"), ["[0]@0", "[1]@8", "[2]@16"]);
check("型が混ざっても宣言順", slotsOf("t : 1 , `ab` , 2.5"), ["[0]@0", "[1]@8", "[2]@16"]);

// ---- アラインメントは自然境界 ----
//
// 各スロットは自分の幅の境界に置く。AArch64 の Device メモリ（MMIO）は境界を跨いだ
// アクセスでフォールトし、`ldp`/`stp` も境界を要求するため、詰めると動かない。
// 全体を境界へ切り上げるのは `List(Struct)` の各要素が同じ境界に載るためである
// ——ストライドが揃わないと `base + i × size` が壊れる。
const packed = { target: "aarch64_qemu", charset: "ascii" };
check("1 byte の次の 8 byte は境界まで送られる", slotsOf("m : [\n\ta : `x`\n\tb : 1\n]", packed), ["a@0", "b@8"]);
check("全体の大きさは最大境界へ切り上げる", measure(rhs("m : [\n\ta : `x`\n\tb : 1\n]"), packed).size, 16);
check("構造体の境界は最大スロットの境界", measure(rhs("m : [\n\ta : `x`\n\tb : 1\n]"), packed).align, 8);
check("alignUp の単体動作", [alignUp(0, 8), alignUp(1, 8), alignUp(8, 8), alignUp(9, 8)], [0, 8, 8, 16]);
// 要素のストライドも境界へ切り上がる（`List(Struct)` が壊れないため）。
check("List の stride は要素境界へ切り上げた大きさ", measure(rhs("l : [1 2 3]"), A64).stride, 8);

// ---- 決まらないものは null ----
//
// 幅が決まっていないターゲットではレイアウトも出せない。憶測で 0 や 8 を返すより、
// 「まだ決まっていない」と言う方が安全である（原理4 と同じ線引き）。
check("未対応ターゲットでは出せない", layoutOfStruct(rhs("p : [\n\tx : 1\n]"), { target: "cortex_m" }), null);
check("スカラーも同じ", measure(rhs("x : 42"), { target: "cortex_m" }), null);
check("Struct でないものに layoutOfStruct は null", layoutOfStruct(rhs("x : 42"), A64), null);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
