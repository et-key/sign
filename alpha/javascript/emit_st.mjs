/**
 * SignType（`.st` / `.ist`）をデバッグ目的で標準出力へ書き出す。
 *
 *   node emit_st.mjs <file.sn> [st|ist]
 *
 * 既定は `st`（export されたもののみ）。`ist` は全識別子を含む——
 * こちらは**メモリ上のみ**が規定であり（compiler_pipeline.md §4）、
 * リダイレクトしてビルド成果物として永続化してはならない。
 */
import fs from "fs";
import { compile } from "./compile.js";
import { generateSignType } from "./st.js";

const file = process.argv[2];
const scope = process.argv[3] === "ist" ? "ist" : "st";
if (!file) {
	console.error("使い方: node emit_st.mjs <file.sn> [st|ist]");
	process.exit(1);
}
const { nodes, env } = compile(fs.readFileSync(file, "utf8"));
const r = generateSignType(nodes, env, { scope, source: file });
process.stdout.write(r.text);
console.error(`${r.entries} エントリ / 未解決 ${r.unresolved}`);
