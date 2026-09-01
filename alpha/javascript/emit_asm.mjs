/**
 * Pass 4 の出力（AArch64 アセンブリ）を標準出力へ書き出す。
 *
 *   node emit_asm.mjs <file.sn> [option.ms]
 *
 * 出せなかった場所は標準エラーへ名指しで出る。**黙って落とさない**——命令の無い
 * 関数ができあがって「動いたように見える」のを避けるためである。
 *
 * `.ist` と違い、これはビルド成果物である（アセンブラへ渡す `.s` そのもの）。
 */
import fs from "fs";
import { compile } from "./compile.js";
import { readOptionMs } from "./option_ms.js";
import { generateAsm } from "./pass4.js";

const file = process.argv[2];
const msFile = process.argv[3];
if (!file) {
	console.error("使い方: node emit_asm.mjs <file.sn> [option.ms]");
	process.exit(1);
}

const conf = readOptionMs(msFile ? fs.readFileSync(msFile, "utf8") : "");
const { nodes, env } = compile(fs.readFileSync(file, "utf8"), { layer: conf.layer, charset: conf.charset, sourcePath: file, readImport: (f) => fs.readFileSync(f, "utf8") });
const r = generateAsm(nodes, env, { target: conf.target, charset: conf.charset, layer: conf.layer, source: file });

process.stdout.write(r.text);
for (const d of r.diagnostics) console.error(`${d.severity}: ${d.message}`);
console.error(`${r.diagnostics.length} 件が出せませんでした`);
process.exit(r.diagnostics.length === 0 ? 0 : 1);
