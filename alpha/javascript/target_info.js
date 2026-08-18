/**
 * ターゲットごとの幅クラスと、Layer 2 型から「何バイト幅・符号あり/なし」への還元。
 *
 * `compiler_pipeline.md` §3 は、Pass 1〜3（帳簿係）が Pass 4 へ渡すのは
 * 「このビット列を**何バイト幅・符号あり/なし**として扱うか」に還元した情報だと定める。
 * Pass 3 が出すのは型の**名前**（`Int` / `Address` / `Float` / `Struct{…}`）なので、
 * その名前を幅へ落とすのがここである。型システムと Pass 4 の継ぎ目にあたる。
 *
 * ## 幅は方針ではなく事実である
 *
 * `type_system.md` §2 は `Address` を「GPR 幅」、`Float` を「ターゲットの FPU が持つ最高
 * 精度」と定める。どちらの語もレジスタファイルを名指ししており、幅はハードウェアが既に
 * 決めている——原理1 の言う通り、Sign は型を押し付けているのではなく**ハードウェアが
 * 既に持っている型を書き写している**。だからこの表は設計判断の置き場ではなく、ISA の
 * 転記である。
 *
 * ## `Int` の幅は GPR 幅である（C の `int` を引き継がない）
 *
 * C は 64bit 環境でも `int` を 32bit に留めたが、それは歴史的な互換の都合であって
 * ハードウェアの事実ではない。AArch64 の整数レジスタは X（64bit）であり、W（32bit）は
 * その部分ビューである。原理1 に従えば書き写すべきは X の方なので、`Int` は GPR 幅を採る。
 *
 * その結果、AArch64 では `Int` と `Address` が**同じ幅**になる。これは両者を統合する理由に
 * ならない——§3.6 が言う通り、分けた根拠はビット幅ではなく**溢れ方**（`Address` は `__` へ
 * 収束、`Int` はラップアラウンド）だからである。同じ幅の別の型であって構わない。
 *
 * ## AArch64 以外は未対応（意図的）
 *
 * Sign の初期構想は AArch64 を対象とする。他のターゲットは ISA としての幅こそ自明でも、
 * FPU の有無（Cortex-M は品種による）や `Int` を GPR 幅に揃えるかどうかが実機に触れて
 * みないと決められない。**憶測で表を埋めると、間違った幅で通ってしまう方が危ない**ので、
 * 未対応のターゲットは `null` を返して「まだ決まっていない」と言う（原理4 の線引きと同じ
 * 考え方——分からないことを分かった顔で通さない）。
 */

/**
 * 幅クラス（byte 数）。`endian` は Pass 4 が多バイト値を並べるのに要る。
 *
 * AArch64:
 *   gpr    8  X レジスタ（64bit）。`Address` と `Int` がここに乗る
 *   float  8  倍精度（D レジスタ）。AArch64 の FPU は倍精度を持つので「最高精度」は 8
 *   vector 16 NEON の Q レジスタ（128bit）
 *   endian little  AArch64 は原則リトルエンディアン（EE ビットで切替可能だが既定は LE）
 */
const TARGET_WIDTHS = {
  aarch64_rpi: { gpr: 8, float: 8, vector: 16, endian: "little" },
  aarch64_qemu: { gpr: 8, float: 8, vector: 16, endian: "little" },
  aarch64_firmware: { gpr: 8, float: 8, vector: 16, endian: "little" },
};

// 型ごとの符号の扱い（compiler_pipeline.md §3 の「符号あり/なし」）。
//
//   Address  符号なし。§2 の値域が「0以上」と定めている。アドレスに負は無い
//   Int      符号あり。十進は符号を書ける唯一の記法であり（§3.6）、`-1` はここに来る。
//            uint を含むのは値域の話であって、幅と符号の帳簿としては signed を採る
//   Float    符号あり（IEEE 754）
const SIGNEDNESS = { Address: "unsigned", Int: "signed", Float: "signed", Vector: "signed" };

// 幅クラスへの割り当て。`String` は `List(0u)` と同型なので要素は Char。
const WIDTH_CLASS = { Address: "gpr", Int: "gpr", Float: "float", Vector: "vector" };

// Char（`0u`）は Unicode コードポイント。UTF-32 として 4 byte 固定で数える
// ——`String ≅ List(0u)` である以上、要素幅が決まらないと `base + i × sizeof(T)` が出せない。
const CHAR_SIZE = 4;

/**
 * ターゲットの幅クラスを返す。未対応なら null。
 */
function widthsOf(target) {
  return TARGET_WIDTHS[target] || null;
}

function isSupported(target) {
  return Object.prototype.hasOwnProperty.call(TARGET_WIDTHS, target);
}

/**
 * Layer 2 型 1 つ分のサイズ（byte）を返す。
 *
 * 決まらないものは null を返す。`List`/`Struct` は要素や並びが分からないと決まらないので、
 * それらは形（shape）を持つノードから計算する Pass 3.5 の仕事であり、ここでは扱わない
 * ——スカラーの幅がこの関数の責務である。
 *
 * @param type Layer 2 型名（`Int` / `Address` / `Float` / `Vector` / `String` / `Unit`）
 * @param target ターゲット名
 */
function sizeOf(type, target) {
  const w = widthsOf(target);
  if (!w) return null;
  // `Unit` は零対象。値を持たないので 0 byte——場所を占めない（unit.md）。
  if (type === "Unit") return 0;
  // `String` は `List(0u)` と同型で長さが型に入っていないため、単体では決まらない。
  if (type === "String") return null;
  const cls = WIDTH_CLASS[type];
  return cls ? w[cls] : null;
}

/**
 * 型を Pass 4 が要る形（幅と符号）へ還元する。決まらなければ null。
 */
function reduceToMachineType(type, target) {
  const size = sizeOf(type, target);
  if (size === null) return null;
  return { size, signed: SIGNEDNESS[type] === "signed", class: WIDTH_CLASS[type] || null };
}

export { TARGET_WIDTHS, SIGNEDNESS, WIDTH_CLASS, CHAR_SIZE, widthsOf, isSupported, sizeOf, reduceToMachineType };
