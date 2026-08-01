/**
 * Pass1（識別子環境の最小構築）→ Pass2 を通した動作確認。
 * `f : x ? x + 1` のような定義を先に見た上で、後続行の `f y` が
 * getCategory(f) === "Lambda" を根拠に apply として正しく解決されることを確認する。
 *
 * 実行: node test/pass1_pass2.test.js
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
		source: "f : x ? x + 1\nf y",
		want: [
			"define[identifier(<f>), lambda[identifier(<x>), add[identifier(<x>), number(1)]]]",
			"apply[identifier(<f>), identifier(<y>)]",
		],
		note: "Pass1がfをLambdaとしてenvに登録 → 後続行 `f y` が apply に解決される",
	},
	{
		source: "x : 5\nx y",
		want: ["define[identifier(<x>), number(5)]", "construct[identifier(<x>), identifier(<y>)]"],
		note: "Pass1がxをAtomとしてenvに登録 → `x y` は apply ではなく construct に解決される",
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
		console.log(`OK   ${JSON.stringify(c.source)}  (${c.note})`);
		passed++;
	} else {
		console.log(`FAIL ${JSON.stringify(c.source)}  (${c.note})`);
		console.log(`     got:  ${JSON.stringify(got)}`);
		console.log(`     want: ${JSON.stringify(c.want)}`);
	}
}

console.log(`\n${passed}/${cases.length} passed`);
process.exit(passed === cases.length ? 0 : 1);
