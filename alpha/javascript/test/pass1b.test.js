/**
 * Pass1b（`@ref`のジェネリック仮引数の具体化、type_system.md §5）の動作確認。
 * `apply_five : f ? @f 5` のような、参照先が定義サイト単体では決まらない仮引数 `f` を
 * 検出し、プログラム全体の呼び出しサイト（`apply_five $g`）から実引数のカテゴリ
 * （Lambda/Atom）を収集できることを確認する。
 *
 * 実行: node test/pass1b.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "../lexer.js";
import { reduceAll } from "../pass2.js";
import { buildEnv } from "../pass1.js";
import { specializeGenericParams, detectGenericParams, collectCallsites } from "../pass1b.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peggy.generate(grammar);

function resolveProgram(source) {
	const pre = preprocess(source);
	const lines = parser.parse(pre);
	const env = buildEnv(lines);
	return { nodes: lines.map((line) => reduceAll(line, env)), env };
}

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

{
	const source = "g : x ? x + 1\napply_five : f ?\n\t@f 5\napply_five $g";
	const { nodes, env } = resolveProgram(source);
	const applyFiveDefine = nodes[1];

	const result = specializeGenericParams(applyFiveDefine, nodes, env);
	check(
		"apply_five の仮引数 f（@f 5 として使われる）が呼び出しサイト apply_five $g から Atom と具体化される",
		Object.fromEntries([...result].map(([k, v]) => [k, v])),
		{ "<f>": { callsiteCount: 1, categories: ["Atom"] } }
	);
}

{
	// @で参照されない仮引数はそもそもジェネリック扱いされない
	const source = "f : x ? x + 1";
	const { nodes, env } = resolveProgram(source);
	const result = specializeGenericParams(nodes[0], nodes, env);
	check("@で使われない仮引数はジェネリック扱いされない（空のMap）", Object.fromEntries(result), {});
}

{
	// 呼び出しサイトが無く、exportもされていない場合はデッドコードとして空配列（エラーにしない）
	const source = "apply_five : f ?\n\t@f 5";
	const { nodes, env } = resolveProgram(source);
	const result = specializeGenericParams(nodes[0], nodes, env);
	check(
		"呼び出しサイトが無く非exportの場合、callsiteCount=0・categories=[]（デッドコードとして許容、エラーにしない）",
		Object.fromEntries([...result].map(([k, v]) => [k, v])),
		{ "<f>": { callsiteCount: 0, categories: [] } }
	);
}

{
	// exportされているのに呼び出しサイトが無い場合はコンパイルエラー（§5・compiler_pipeline.md §6.3）
	const source = "#apply_five : f ?\n\t@f 5";
	const { nodes, env } = resolveProgram(source);
	total++;
	let threw = false;
	try {
		specializeGenericParams(nodes[0], nodes, env);
	} catch (e) {
		threw = e instanceof TypeError;
	}
	if (threw) {
		console.log("OK   exportされているのに呼び出しサイトが無い場合はTypeError（§5・compiler_pipeline.md §6.3）");
		passed++;
	} else {
		console.log("FAIL exportされているのに呼び出しサイトが無い場合はTypeError（§5・compiler_pipeline.md §6.3）");
		console.log(`     expected TypeError, got threw=${threw}`);
	}
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
