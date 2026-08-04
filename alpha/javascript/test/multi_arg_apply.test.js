/**
 * 多引数関数（`params[]`が複数エントリ）の呼び出しがapplyチェーンとして正しく飽和することの確認。
 *
 * 背景: `getCategory`が`apply`ノードを問答無用でAtom扱いしていたため、`f : x y ? x + y`に
 * 対して `f 3 5` が `construct[apply[f,3], 5]`（fを3だけに適用した結果と5をタプル化）に
 * 誤って縮約されていた。pass1.jsのarity（単純な空白区切り複数パラメータのみ対応）と、
 * pass2.jsのapplyChainInfo（左に伸びるapplyチェーンの深さを数える）により、
 * 消費済み引数の数がarityに届くまでLambdaのまま扱い、正しく `apply[apply[f,3],5]` という
 * 飽和したチェーンになるよう修正した。アリティを超える余分な引数は、飽和した呼び出し結果の
 * 後ろにconstructでタプル化される（仕様として意図された挙動）。
 *
 * 実行: node test/multi_arg_apply.test.js
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
	if (node === null) return "null";
	if (node.type === "atom") return `${node.kind}(${node.value})`;
	if (node.type === "operation") {
		if (node.position === "prefix" || node.position === "postfix") return `${node.name}(${show(node.operand)})`;
		return `${node.name}[${show(node.left)}, ${show(node.right)}]`;
	}
	if (node.type === "params") return `params[${node.entries.map((e) => e.name).join(", ")}]`;
	return JSON.stringify(node);
}

function resolveLines(source) {
	const pre = preprocess(source);
	const lines = parser.parse(pre);
	const env = buildEnv(lines);
	return lines.map((line) => show(reduceAll(line, env)));
}

const cases = [
	{
		source: "f : x y ? x + y\nf 3 5",
		want: [
			"define[identifier(<f>), lambda[params[<x>, <y>], add[identifier(<x>), identifier(<y>)]]]",
			"apply[apply[identifier(<f>), number(3)], number(5)]",
		],
		note: "arity=2の関数に2引数 → apply[apply[f,3],5]（飽和したチェーン、以前はconstruct[apply[f,3],5]に誤って縮約されていた）",
	},
	{
		source: "f : x y ? x + y\nf 3 5 7",
		want: [
			"define[identifier(<f>), lambda[params[<x>, <y>], add[identifier(<x>), identifier(<y>)]]]",
			"construct[apply[apply[identifier(<f>), number(3)], number(5)], number(7)]",
		],
		note: "arity=2の関数に3引数 → 飽和した呼び出し結果と余分な引数がconstructでタプル化される",
	},
	{
		source: "f : x y z ? x + y + z\nf 1 2 3",
		want: [
			"define[identifier(<f>), lambda[params[<x>, <y>, <z>], add[add[identifier(<x>), identifier(<y>)], identifier(<z>)]]]",
			"apply[apply[apply[identifier(<f>), number(1)], number(2)], number(3)]",
		],
		note: "arity=3の関数に3引数 → 3段のapplyチェーンとして正しく飽和する",
	},
];

let passed = 0;
for (const c of cases) {
	const got = resolveLines(c.source);
	const ok = JSON.stringify(got) === JSON.stringify(c.want);
	if (ok) {
		console.log(`OK   ${c.note}`);
		passed++;
	} else {
		console.log(`FAIL ${c.note}`);
		console.log(`     source: ${JSON.stringify(c.source)}`);
		console.log(`     got:  ${JSON.stringify(got)}`);
		console.log(`     want: ${JSON.stringify(c.want)}`);
	}
}

console.log(`\n${passed}/${cases.length} passed`);
process.exit(passed === cases.length ? 0 : 1);
