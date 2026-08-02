/**
 * ブロックスコープの階層（pass1.js の childEnv/envLookup）の動作確認。
 * 外側スコープで定義した識別子が、内側のインデントブロックから正しく参照できること、
 * grammar.pegjs のBlock展開バグ（pass2.js の repairLeakedBlocks 参照）が
 * 回避策込みで正しく吸収されることを確認する。
 *
 * 実行: node test/nested_scope.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "../lexer.js";
import { reduceAll } from "../pass2.js";
import { buildEnv } from "../pass1.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peggy.generate(grammar);

function show(node) {
	if (node.type === "atom") return `${node.kind}(${node.value})`;
	if (node.type === "operation") {
		if (node.position === "prefix" || node.position === "postfix") return `${node.name}(${show(node.operand)})`;
		return `${node.name}[${show(node.left)}, ${show(node.right)}]`;
	}
	if (node.type === "block") return `${node.kind}{${node.lines.map(show).join("; ")}}`;
	if (node.type === "unresolved") return `UNRESOLVED[${node.items.map((x) => (typeof x === "string" ? x : show(x))).join(", ")}]`;
	return JSON.stringify(node);
}

const cases = [
	{
		source: "g : x ? x + 1\nf : y ?\x02g y\x03",
		want: [
			"define[identifier(<g>), lambda[identifier(<x>), add[identifier(<x>), number(1)]]]",
			"define[identifier(<f>), lambda[identifier(<y>), indent{apply[identifier(<g>), identifier(<y>)]}]]",
		],
		note: "外側スコープのg（Lambda）が内側のインデントブロックから apply として正しく解決される",
	},
];

let passed = 0;
for (const c of cases) {
	const pre = preprocess(c.source);
	const lines = parser.parse(pre);
	const env = buildEnv(lines);
	const got = lines.map((line) => show(reduceAll(line, env)));
	const ok = JSON.stringify(got) === JSON.stringify(c.want);
	if (ok) {
		console.log(`OK   ${c.note}`);
		passed++;
	} else {
		console.log(`FAIL ${c.note}`);
		console.log(`     got:  ${JSON.stringify(got)}`);
		console.log(`     want: ${JSON.stringify(c.want)}`);
	}
}

console.log(`\n${passed}/${cases.length} passed`);
process.exit(passed === cases.length ? 0 : 1);
