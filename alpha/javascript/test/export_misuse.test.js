/**
 * 前置 `#` / `##` / `###` は**名前に付く印**である（operator_table.md tier 1）。
 *
 * `#name : value` は Pass 2 が `define.exported` へ畳むので、演算子ノードとして残って
 * いるなら**名前が無い**——名前の無いものを「発見可能に」はできない。黙って通していた。
 *
 * 実行: node test/export_misuse.test.js
 */
import { compile } from "../compile.js";

let passed = 0;
let total = 0;
function check(note, got, want) {
	total++;
	const ok = JSON.stringify(got) === JSON.stringify(want);
	if (ok) passed++;
	console.log(`${ok ? "OK  " : "FAIL"} ${note}`);
	if (!ok) console.log(`     got: ${JSON.stringify(got)}\n     want: ${JSON.stringify(want)}`);
}
const reasons = (src) => compile(src, { charset: "ascii" }).diagnostics.map((d) => d.reason);

// 名前に付いた形は Pass 2 が畳むので、演算子ノードは残らない。
check("#名前 : 値", reasons("#total : 0"), []);
check("#名前 : 関数", reasons("#push : st d ? d st~"), []);
check("##名前", reasons("##shared : 1"), []);
// 式に付いた形は名前が無い。
check("#(式)", reasons("f : n ? #(n + 1)"), ["export-without-name"]);
check("##(式)", reasons("f : n ? ##(n + 1)"), ["export-without-name"]);
check("###(式)", reasons("f : n ? ###(n + 1)"), ["export-without-name"]);
// 確保のつもりで書く形は `$` である（その場に置いてアドレスを返す）。
check("$(式) は診断されない", reasons("f : n ? @($(n + 1))"), []);
// ふつうの式には出ない。
check("ふつうの式", reasons("f : n ? n + 1"), []);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
