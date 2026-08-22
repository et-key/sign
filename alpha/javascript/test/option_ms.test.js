/**
 * `option.ms` の読み取り（option_ms_schema.md）と、layer による門番（§4）の動作確認。
 *
 * この2つは**幅の根拠**である。`compiler_pipeline.md` §3 は Pass 1〜3 が Pass 4 へ渡すのは
 * 「何バイト幅・符号あり/なし」に還元した情報だと定めるが、`Address` は「GPR 幅」、`Float` は
 * 「ターゲットの FPU が持つ最高精度」なので（type_system.md §2）、**ターゲットが決まらないと
 * 幅が決まらない**。その唯一の入口が `option.ms` である。
 *
 * 実行: node test/option_ms.test.js（`npm test` からも呼ばれる）
 */
import { readOptionMs } from "../option_ms.js";
import { compile } from "../compile.js";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

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

// `layer` を渡してコンパイルし、通れば "OK"、弾かれれば例外の名前を返す。
function gate(source, layer) {
	try {
		compile(source, { layer });
		return "OK";
	} catch (e) {
		return e.name;
	}
}

// ---- ms は Sign の積型記法そのものである（§1） ----
//
// だから専用のパーサを持たない。`key : value` は Sign の `define`、入れ子はタブ
// インデントのブロックであり、既存の Pass 1〜2 がそのまま読む。メタ定義もまた Sign の式である。
check("`key : value` がそのまま読める", readOptionMs("target : cortex_m").target, "cortex_m");
check("行頭バッククォートはコメント（§1 の表）", readOptionMs("` これはコメント\ntarget : riscv64").target, "riscv64");
check("入れ子は link のモードとして読める", readOptionMs("link :\n\tstatic :\n\t\tmemory :\n\t\t\trom : 0x0").link, "static");
check("単一値の link も読める", readOptionMs("link : dynamic").link, "dynamic");

// ---- デフォルト（§2） ----
check("省略時の target は rust（ホストビルド）", readOptionMs("").target, "rust");
check("省略時の layer は 4（std）", readOptionMs("").layer, 4);
check("省略時の optimize は 0", readOptionMs("").optimize, 0);
check("空でなくても未記載のフィールドは既定値", readOptionMs("target : wasm").layer, 4);

// ---- target 別の entry/stack 既定値（§3 の表） ----
//
// `entry`/`stack` を省略したら target が決める。ここを取り違えると、CPU が最初に
// ジャンプする先が変わる——既定値の表は仕様の一部であって利便性ではない。
check("x86_bios の既定 entry は 0x7C00（MBR ロード先）", readOptionMs("target : x86_bios").entry, 0x7c00);
check("x86_bios の既定 stack は 0x7BFF", readOptionMs("target : x86_bios").stack, 0x7bff);
check("aarch64_qemu の既定 entry は 0x40080000", readOptionMs("target : aarch64_qemu").entry, 0x40080000);
check("riscv64 の既定 entry は 0x80000000", readOptionMs("target : riscv64").entry, 0x80000000);
check("明示した entry は既定値より優先する", readOptionMs("target : x86_bios\nentry : 0x1000").entry, 0x1000);
// UEFI/WASM/ホストビルドは実行環境が決めるので、コンパイラ側では確定しない。
check("x86_uefi_app の entry は確定しない（UEFI が決める）", readOptionMs("target : x86_uefi_app").entry, null);
check("rust（ホストビルド）も確定しない", readOptionMs("target : rust").entry, null);

// ---- layer は数値でも別名でも書ける（§4 の表） ----
check("layer : 0 は bare", readOptionMs("layer : 0").layer, 0);
check("layer : bare は 0", readOptionMs("layer : bare").layer, 0);
check("layer : fpu は 2", readOptionMs("layer : fpu").layer, 2);
check("layer : simd は 3", readOptionMs("layer : simd").layer, 3);
check("layer : std は 4", readOptionMs("layer : std").layer, 4);

// ---- 読めたが妥当でないものは警告して既定へ倒す ----
//
// 構文が壊れているなら compile() が SyntaxError を投げる。ここで警告に留めるのは
// 「読めたが値が仕様の集合に無い」場合であり、黙って通さないことが目的である。
check("未知の target は警告して rust へ倒す", readOptionMs("target : nosuch").target, "rust");
check("その警告は握り潰さない", readOptionMs("target : nosuch").warnings.length, 1);

// **`charset` に収まらない文字は名指しする。**
//
// `charset : ascii` は Char 1個を1バイトとすると決めることであり、そこへ U+0080 以上を
// 書けば収まらない。黙って下位バイトへ落とすと、書いた文字と出る文字が違うという
// 一番たちの悪い壊れ方をする。
{
	const fails = (src, charset) => {
		try {
			compile(src, { charset });
			return false;
		} catch (e) {
			return /charset/.test(e.message);
		}
	};
	check("ascii に ASCII は通る", fails("s : `hello`", "ascii"), false);
	check("ascii に非 ASCII は止める", fails("s : `あ`", "ascii"), true);
	check("`0u` でも同じ", fails("s : 0u3042", "ascii"), true);
	check("utf32 なら通る", fails("s : `あ`", "utf32"), false);
	// layer の門番と同じで、`option.ms` を読まない経路では検査しない。
	check("charset を渡さなければ検査しない", fails("s : `あ`", undefined), false);
}
check("範囲外の layer も警告する", readOptionMs("layer : 9").warnings.length, 1);
check("妥当な設定なら警告は出ない", readOptionMs("target : cortex_m\nlayer : 0").warnings.length, 0);

// ---- layer による門番（§4） ----
//
// layer は単なるビルド設定ではなく**使用可能機能セットの宣言**である（build_system.md）。
// `layer: 0` は FPU 未初期化の段階なので、そこに Float リテラルが書けてしまうと
// **FPU が初期化される前に浮動小数点命令を出す**ことになる。静的に決定可能な違反なので
// 原理4 に従って弾く。止める種別は OperationError——「この位置で許されない操作」である。
check("layer: 0 で Float リテラルは弾かれる", gate("x : 3.14", 0), "OperationError");
check("layer: 1 でもまだ弾かれる（FPU は 2 以上）", gate("x : 3.14", 1), "OperationError");
check("layer: 2 なら通る", gate("x : 3.14", 2), "OK");
check("整数は layer: 0 でも通る", gate("x : 42", 0), "OK");
check("アドレスも layer: 0 で通る（MMIO は bare の仕事）", gate("p : 0x40011000", 0), "OK");
check("文字列も layer: 0 で通る", gate("s : `hi`", 0), "OK");
// 違反の在り処はリテラルの位置で指す。識別子にも昇格で Float が付くが、それは
// リテラルが Float であることの帰結であって原因ではない。
check("本体の奥にある Float リテラルも見つける", gate("f : n ? n + 1.0", 0), "OperationError");
check("リストの要素の Float も見つける", gate("xs : [1.0 2.0]", 0), "OperationError");
// 門番はオプトインである。`option.ms` を読まない経路（素の評価・playground）まで
// std 相当を強制しない——layer を宣言していないコードに layer 違反は無い。
check("layer を渡さなければ検査しない", gate("x : 3.14", undefined), "OK");


// ---- サイズは文字列で書く（§5.2、`ms` 独自の表記） ----
//
// Sign の数値リテラルに `K`/`M`/`G` 接尾辞は無い。メモリマップにしか要らない表記のために
// 言語の字句解析を触らず、文字列として書いて `ms` の読み手が解釈する。
const mem = readOptionMs(
	"link :\n\tstatic :\n\t\tmemory :\n\t\t\trom : origin 0x08000000 length `1024k`\n\t\t\tram : origin 0x20000000 length `128K`\n\t\t\theap : max `64k`\n"
).memory;
check("1K は 1024（10進の 1000 ではない）", mem.rom.length, 1024 * 1024);
check("大文字小文字は問わない", mem.ram.length, 128 * 1024);
check("heap の max も同じ表記", mem.heap.max, 64 * 1024);
check("origin はアドレスなので数値のまま", mem.rom.origin, 0x08000000);
check("`4M` はメガバイト", readOptionMs("link :\n\tstatic :\n\t\tmemory :\n\t\t\trom : origin 0x0 length `4M`\n").memory.rom.length, 4 * 1024 * 1024);
check("接尾辞なしはバイト", readOptionMs("link :\n\tstatic :\n\t\tmemory :\n\t\t\trom : origin 0x0 length `4096`\n").memory.rom.length, 4096);
check("`ram : auto` は実行時決定（§5.3）", readOptionMs("link :\n\tstatic :\n\t\tmemory :\n\t\t\tram : auto\n").memory.ram, "auto");

// cortex_m の entry/stack だけはメモリマップから導出する（§3 の NOTE）。
// stack が RAM の**末端**なのは、Cortex-M のスタックが上位アドレスから下方へ伸びるため。
const cm = readOptionMs(
	"target : cortex_m\nlink :\n\tstatic :\n\t\tmemory :\n\t\t\trom : origin 0x08000000 length `1024k`\n\t\t\tram : origin 0x20000000 length `128k`\n"
);
check("cortex_m の entry は rom.origin", cm.entry, 0x08000000);
check("cortex_m の stack は ram の末端", cm.stack, 0x20000000 + 128 * 1024);

// ---- 仕様書のサンプルが実際に読めること ----
//
// `option_ms_schema.md` は「唯一の正規リファレンス」を名乗る。そこに載っている `ms` ブロックが
// パースできないなら、仕様が実装可能でないということである。実際この検査で2種類の齟齬が
// 見つかった——サイズ接尾辞（`1024K`）と、行末コメント（Sign にはインデント後のコメントは
// 無く、閉じありのドキュメント文字列で書く。string_and_comment.md §3）。
const doc = fs.readFileSync(path.join(__dirname, "..", "..", "..", "documents", "ja-jp", "impl", "build", "option_ms_schema.md"), "utf8").replace(/\r\n/g, "\n");
const msBlocks = [...doc.matchAll(/```ms\n([\s\S]*?)```/g)].map((m) => m[1]);
let blocksOk = 0;
const blockErrors = [];
for (const block of msBlocks) {
	// 仕様書はスペースでインデントしているが Sign のインデントはタブのみ（lexer.js）。
	const src = block.replace(/^( +)/gm, (m) => "\t".repeat(Math.round(m.length / 4)));
	try {
		readOptionMs(src);
		blocksOk++;
	} catch (e) {
		blockErrors.push(e.message.slice(0, 60));
	}
}
check(`仕様書の ms サンプル ${msBlocks.length} 個が全て読める${blockErrors.length ? " / " + blockErrors[0] : ""}`, blocksOk, msBlocks.length);
check("サンプルが1つ以上ある（正規表現が空振りしていない）", msBlocks.length > 0, true);


// ---- charset（§4.2） ----
// **既定は `ascii`。** Sign が最初に書くのは OS カーネルであり、そこは layer: 0 の
// 世界である——UART 出力やブートログに Unicode は要らない（§4.2）。
check("既定の charset は ascii", readOptionMs("").charset, "ascii");
check("utf32 を選べる", readOptionMs("charset : utf32").charset, "utf32");
// 可変長の UTF-8 は選択肢に無い（選ぶと `String ≅ List(0u)` が崩れる）。
check("utf8 は警告して既定へ倒す", readOptionMs("charset : utf8").charset, "ascii");
check("その警告は握り潰さない", readOptionMs("charset : utf8").warnings.length, 1);
console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
