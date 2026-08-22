/**
 * ターゲットごとの幅クラスと、Layer 2 型から「何バイト幅・符号あり/なし」への還元
 * （compiler_pipeline.md §3、type_system.md §2）。
 *
 * Pass 3 が出すのは型の**名前**だが、Pass 4 が要るのは幅と符号である。その継ぎ目がここ。
 * 幅は設計判断ではなく ISA の転記である——`Address` は「GPR 幅」、`Float` は「ターゲットの
 * FPU が持つ最高精度」と型システムが定めており、どちらもレジスタファイルを名指ししている。
 *
 * 実行: node test/target_info.test.js（`npm test` からも呼ばれる）
 */
import { widthsOf, isSupported, sizeOf, reduceToMachineType, charSizeOf, CHARSETS, DEFAULT_CHARSET } from "../target_info.js";
import { readOptionMs } from "../option_ms.js";

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

// ---- AArch64 の幅（ISA の転記） ----
//
// X レジスタが 64bit、FPU は倍精度、NEON の Q レジスタが 128bit。
// この3つが Layer 2 の幅クラス（GPR / FPU / SIMD）にそのまま対応する。
check("GPR は 8 byte（X レジスタ）", widthsOf("aarch64_qemu").gpr, 8);
check("FPU の最高精度は 8 byte（倍精度）", widthsOf("aarch64_qemu").float, 8);
check("SIMD は 16 byte（NEON の Q レジスタ）", widthsOf("aarch64_qemu").vector, 16);
check("エンディアンはリトル", widthsOf("aarch64_rpi").endian, "little");
check("aarch64 の3ターゲットは同じ幅", widthsOf("aarch64_firmware"), widthsOf("aarch64_qemu"));

// ---- 型から幅と符号への還元 ----
check("Int は GPR 幅・符号あり", reduceToMachineType("Int", "aarch64_qemu"), { size: 8, signed: true, class: "gpr" });
check("Address は GPR 幅・符号なし", reduceToMachineType("Address", "aarch64_qemu"), { size: 8, signed: false, class: "gpr" });
check("Float は FPU 幅", reduceToMachineType("Float", "aarch64_qemu"), { size: 8, signed: true, class: "float" });
check("Vector は SIMD 幅", reduceToMachineType("Vector", "aarch64_qemu"), { size: 16, signed: true, class: "vector" });
// 零対象は値を持たないので場所を占めない（unit.md）。
check("Unit は 0 byte", sizeOf("Unit", "aarch64_qemu"), 0);

// **`Int` と `Address` は同じ幅で別の型である。**
//
// AArch64 では両方 X レジスタに乗るので幅が一致する。それは統合の理由にならない
// ——分けた根拠はビット幅ではなく**溢れ方**（`Address` は `__` へ収束、`Int` はラップ
// アラウンド）だからである（type_system.md §3.6）。帳簿の上では符号で分かれる。
check(
	"幅は同じだが符号が違う",
	[
		sizeOf("Int", "aarch64_rpi") === sizeOf("Address", "aarch64_rpi"),
		reduceToMachineType("Int", "aarch64_rpi").signed !== reduceToMachineType("Address", "aarch64_rpi").signed,
	],
	[true, true]
);
// C の `int` は 64bit 環境でも 32bit だが、それは歴史的互換であってハードウェアの事実では
// ない。AArch64 の整数レジスタは X（64bit）で W はその部分ビューなので、原理1 に従えば
// 書き写すべきは X の方である。
check("Int は 4 byte ではない（C の int を引き継がない）", sizeOf("Int", "aarch64_qemu"), 8);

// ---- 単体では決まらないもの ----
//
// 長さや並びが型名だけでは決まらないものは null を返す。これらは形（shape）を持つノードから
// 計算する仕事であり、スカラーの幅を答えるこのモジュールの責務ではない。
check("String は単体では決まらない（`List(0u)` と同型で長さが型に無い）", sizeOf("String", "aarch64_qemu"), null);
check("List も決まらない", sizeOf("List", "aarch64_qemu"), null);
check("Struct も決まらない", sizeOf("Struct", "aarch64_qemu"), null);

// ---- 未対応ターゲットは「まだ決まっていない」と言う ----
//
// Sign の初期構想は AArch64 が対象である。他のターゲットは ISA としての幅こそ自明でも、
// FPU の有無（Cortex-M は品種による）や `Int` を GPR 幅に揃えるかが実機に触れないと
// 決められない。**憶測で埋めると間違った幅で通ってしまう方が危ない**ので null を返す
// ——分からないことを分かった顔で通さないのは原理4 と同じ線引きである。
check("aarch64 は対応済み", isSupported("aarch64_qemu"), true);
check("cortex_m はまだ未対応", isSupported("cortex_m"), false);
check("未対応なら幅も null", widthsOf("cortex_m"), null);
check("未対応なら sizeOf も null", sizeOf("Int", "cortex_m"), null);
check("未知のターゲットも同じ", widthsOf("nosuch"), null);

// ---- option.ms との接続 ----
//
// 幅の根拠はターゲットであり、ターゲットの入口は `option.ms` である。この2つが繋がって
// はじめて「型名 → 何バイト幅・符号あり/なし」の還元が成立する。
const conf = readOptionMs("target : aarch64_qemu\nlayer : 2");
check("option.ms が読んだ target から幅が引ける", sizeOf("Float", conf.target), 8);
check("既定の target（rust）はまだ幅を持たない", sizeOf("Int", readOptionMs("").target), null);


// ---- Char の幅は `charset` が決める（option_ms_schema.md §4.2） ----
//
// **選択肢は固定幅に限る。** `type_system.md` は `List` を「固定幅要素の連続領域」と定め、
// `String ≅ List(0u)` の根拠を「要素幅が同じなら同一のビット表現」と書いている。可変長を
// 選ぶとこの同型が崩れ、`s ' i` を `base + i × sizeof(T)` の1命令で出せなくなる。
//
// UTF-8 が選択肢に無いのはそのためである。`value_representation.md` が UTF-8 を採る理由
// （先頭バイトの自己記述で boxing が無償）が効くのは、同文書 §4 が扱う**外部から届いた
// Byte 列を Char 列へ変換する境界**であって、メモリ上の表現ではない。
check("既定は utf32（全 Unicode・添字は O(1)）", charSizeOf("utf32"), 4);
check("ascii は 1 byte（layer 0 の組み込み向け）", charSizeOf("ascii"), 1);
check("どちらも固定幅なので `String ≅ List(0u)` が保たれる", Object.values(CHARSETS).every((n) => Number.isInteger(n) && n > 0), true);
check("可変長（utf8）は選択肢に無い", Object.prototype.hasOwnProperty.call(CHARSETS, "utf8"), false);
check("既定値は ascii（OS カーネルが初歩の対象なので）", DEFAULT_CHARSET, "ascii");

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
