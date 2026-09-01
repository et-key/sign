/**
 * 形の解決（Pass 3.5）の結果——大きさとバイトオフセット——を標準出力へ書き出す。
 *
 *   node emit_layout.mjs <file.sn> [option.ms]
 *
 * `option.ms` を渡すと target と charset をそこから取る。省略時は既定（target: rust）だが、
 * 既定のターゲットにはまだ幅が無いので何も出ない——**幅の根拠はターゲットである**
 * （type_system.md §2: `Address` は GPR 幅、`Float` は FPU の最高精度）。
 *
 * `.st` が型の**名前**を見せるのに対し、こちらは**どこに在るか**を見せる。名前は
 * ターゲットに依らないが、オフセットは依る——だから別の出力になっている。
 */
import fs from "fs";
import { compile } from "./compile.js";
import { readOptionMs } from "./option_ms.js";
import { measure, layoutOfStruct } from "./layout.js";
import { widthsOf } from "./target_info.js";

const file = process.argv[2];
const msFile = process.argv[3];
if (!file) {
	console.error("使い方: node emit_layout.mjs <file.sn> [option.ms]");
	process.exit(1);
}

const conf = readOptionMs(msFile ? fs.readFileSync(msFile, "utf8") : "");
const { nodes } = compile(fs.readFileSync(file, "utf8"), { layer: conf.layer, sourcePath: file, readImport: (f) => fs.readFileSync(f, "utf8") });

const w = widthsOf(conf.target);
console.log(`\` layout — target: ${conf.target} / charset: ${conf.charset} / layer: ${conf.layer}`);
console.log(`\` source: ${file}`);
if (!w) {
	console.log(`\` target '${conf.target}' の幅はまだ決まっていない（AArch64 のみ対応）`);
	process.exit(0);
}
console.log(`\` GPR ${w.gpr} / FPU ${w.float} / SIMD ${w.vector} / ${w.endian} endian`);
console.log("");

function bareName(v) {
	return typeof v === "string" && v.startsWith("<") && v.endsWith(">") ? v.slice(1, -1) : v;
}

let shown = 0;
for (const node of nodes) {
	if (!node || node.type !== "operation" || node.name !== "define") continue;
	if (!node.left || node.left.type !== "atom") continue;
	const name = bareName(node.left.value);
	const m = measure(node.right, conf);
	if (!m) continue;
	shown++;
	const struct = layoutOfStruct(node.right, conf);
	const stride = m.stride !== undefined ? `  stride ${m.stride} × ${m.count}` : "";
	console.log(`${name} : ${node.right.atomType}  —  size ${m.size} / align ${m.align}${stride}`);
	// 規則裏打ち（レンジ）は要素を持たない。置かれているのは規則そのものなので、
	// 添字がロードではなく算術になることまで見せる（type_system.md §2 のアクセス表）。
	if (m.repr === "rule") {
		for (const f of m.fields) {
			console.log(`  +${String(f.offset).padStart(4)}  ${f.name.padEnd(10)} ${String(f.type).padEnd(8)} ${f.size} byte`);
		}
		console.log("  ` 添字は " + m.access + "（ロードではなく算術）");
	}
	if (struct) {
		for (const s of struct.slots) {
			const label = s.name !== undefined ? s.name : `[${s.ordinal}]`;
			console.log(`  +${String(s.offset).padStart(4)}  ${label.padEnd(10)} ${String(s.type).padEnd(8)} ${s.size} byte   \` 宣言順 ${s.ordinal}`);
		}
	}
}
console.error(`${shown} 件のレイアウトを出力`);
