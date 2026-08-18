/**
 * `option.ms`（MetaObjectForSign）の読み取り（option_ms_schema.md）。
 *
 * ## 専用パーサを持たない
 *
 * `ms` は「Sign の積型（Product）記法をそのままデータ記述に使ったフォーマット」であり
 * （§1）、`key : value` は Sign の `define` そのもの、入れ子はタブインデントのブロック
 * そのものである。したがってここは**既存の Pass 1〜2 をそのまま通し、`define` の木を
 * 読むだけ**でよい。`ms` 用の字句解析も構文解析も書かない。
 *
 * これは横着ではなく、フォーマットが自分自身で説明できていることの確認でもある
 * ——`entry : 0x08000000` は Pass 3 が `Address` と型付け、`layer : 0` は `Int` と
 * 型付ける。メタ定義もまた Sign の式である。
 *
 * ## ここが決めるのは「幅の根拠」である
 *
 * `compiler_pipeline.md` §3 は、Pass 1〜3 が Pass 4 へ渡すのは「このビット列を何バイト
 * 幅・符号あり/なしとして扱うか」に還元した情報だと定める。`Address` は「GPR 幅」、
 * `Float` は「ターゲットの FPU が持つ最高精度」なので（type_system.md §2）、**幅は
 * ターゲットが決まらないと決まらない**。その唯一の入口がこのファイルである。
 *
 * ## 未対応（既知）
 *
 * `link : static :` の下のメモリマップは `length 1024K` のようにサイズ接尾辞を使うが、
 * Sign の数値リテラルに `K`/`M`/`G` は無いため現状パースできない。ここでは `link` の
 * モード（`dynamic`/`static`）までを読み、メモリマップは読まない。幅の決定には
 * ターゲットしか要らないので、この欠落は Pass 3.5 を止めない（配置は Pass 4 以降の話）。
 */

import { compile } from "./compile.js";

// §3 target 別デフォルト値。`entry`/`stack` を省略したときに適用する。
// `null` は「その target では外部（UEFI/WASM ランタイム/OS）が決める」の意。
const TARGET_DEFAULTS = {
  x86_bios: { entry: 0x7c00, stack: 0x7bff },
  x86_firmware: { entry: 0xfffffff0, stack: 0x00090000 },
  x86_uefi_app: { entry: null, stack: null },
  aarch64_rpi: { entry: 0x80000, stack: 0x80000 },
  aarch64_qemu: { entry: 0x40080000, stack: 0x40200000 },
  aarch64_firmware: { entry: 0x0, stack: 0x80000 },
  // cortex_m の既定は rom.origin / ram.origin + ram.length（RAM 末端）であり、
  // メモリマップを読めるようになるまで確定しない（§3 の NOTE）。
  cortex_m: { entry: null, stack: null },
  riscv64: { entry: 0x80000000, stack: 0x80200000 },
  wasm: { entry: null, stack: null },
  wasm32: { entry: null, stack: null },
  wasm64: { entry: null, stack: null },
  rust: { entry: null, stack: null },
};

// §2 のデフォルト: target は rust（ホストビルド）、layer は 4（std）。
const DEFAULTS = { target: "rust", layer: 4, optimize: 0, inherit: true, link: "dynamic", output: null };

const LAYER_ALIASES = { bare: 0, alloc: 1, fpu: 2, simd: 3, std: 4 };

function bareName(value) {
  return typeof value === "string" && value.startsWith("<") && value.endsWith(">") ? value.slice(1, -1) : value;
}

function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}

// `define` の木を `{ キー: 値ノード }` の入れ子オブジェクトへ均す。
function toTree(nodes) {
  const out = {};
  for (const node of nodes) {
    if (!isDefineNode(node) || !node.left || node.left.type !== "atom") continue;
    const key = bareName(node.left.value);
    const rhs = node.right;
    out[key] = rhs && rhs.type === "block" ? toTree(rhs.lines || []) : rhs;
  }
  return out;
}

// 値ノードから素の JS 値を取り出す。識別子は名前、数値は数、文字列はその中身。
function scalarOf(node) {
  if (!node || node.type !== "atom") return undefined;
  if (node.kind === "identifier") return bareName(node.value);
  if (node.kind === "number") return node.value.includes(".") ? parseFloat(node.value) : parseInt(node.value, 10);
  if (node.kind === "address") return parseInt(node.value, 16);
  if (node.kind === "string") return node.value;
  if (node.kind === "unit") return null;
  return node.value;
}

/**
 * `option.ms` のソースを読み、確定した設定を返す。
 *
 * @param source `option.ms` の中身（省略・空なら全てデフォルト）
 * @returns {{ target, layer, entry, stack, output, optimize, inherit, link, warnings }}
 *   warnings は「読めたが妥当でない」もの。読めない（構文が壊れている）場合は
 *   compile() が SyntaxError を投げるので、ここでは握り潰さない。
 */
function readOptionMs(source, options = {}) {
  const warnings = [];
  const conf = { ...DEFAULTS };

  if (source && source.trim()) {
    const { nodes } = compile(source, options);
    const tree = toTree(nodes);

    if (tree.target !== undefined) {
      const t = scalarOf(tree.target);
      if (Object.prototype.hasOwnProperty.call(TARGET_DEFAULTS, t)) conf.target = t;
      else warnings.push(`未知の target です: ${t}（${DEFAULTS.target} として扱います）`);
    }

    if (tree.layer !== undefined) {
      const raw = scalarOf(tree.layer);
      // 別名（bare/alloc/fpu/simd/std）でも数値でも書ける（§4 の表）。
      const n = typeof raw === "string" ? LAYER_ALIASES[raw] : raw;
      if (Number.isInteger(n) && n >= 0 && n <= 4) conf.layer = n;
      else warnings.push(`layer は 0〜4（または bare/alloc/fpu/simd/std）です: ${raw}`);
    }

    for (const key of ["entry", "stack", "output", "optimize"]) {
      if (tree[key] !== undefined) conf[key] = scalarOf(tree[key]);
    }
    if (tree.inherit !== undefined) conf.inherit = scalarOf(tree.inherit) !== "false";
    // `link : dynamic` は単一の値、`link : static : …` は入れ子のブロックで来る。
    if (tree.link !== undefined) {
      conf.link = tree.link && tree.link.type ? scalarOf(tree.link) : Object.keys(tree.link)[0] || "dynamic";
    }
  }

  // §3: 省略された entry/stack は target の既定値で埋める。
  const td = TARGET_DEFAULTS[conf.target] || { entry: null, stack: null };
  if (conf.entry === undefined || conf.entry === null) conf.entry = td.entry;
  if (conf.stack === undefined || conf.stack === null) conf.stack = td.stack;

  return { ...conf, warnings };
}

export { readOptionMs, TARGET_DEFAULTS, DEFAULTS, LAYER_ALIASES };
