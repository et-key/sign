/**
 * パーサー単体の動作確認。
 * sign.pegjs（peggy記法）を都度ビルドし、lexer.js の preprocess() を通してからパースする。
 * alpha1 の文法は単位を `_` だけで書く（`__` はただの識別子）。documents/ja-jp/impl/syntax/grammar.pegjs
 * はまだ `__` を単位に持っているので、そこはこの文法と食い違う。
 * このパーサーの出力は「フラットなTerm列」であり、演算子の優先順位解決（Shunting Yard、
 * apply/compose/concatの区別）は行わない。それは意味論フェーズ（Pass2, coproduct_resolver.md）
 * の責務であり、ここではフラット列の形だけを見る。
 *
 * 実行: node test/parser.test.js（`npm test` からも呼ばれる）
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "../lexer.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peggy.generate(grammar);
// 括りの印。`[...]`・`{...}`・`(...)` は意味が1つなので、どれも同じ印で返る（種類は残さない）。
const B = `"BRACKET_"`;

const cases = [
	{ name: "コプロダクト（空白）によるフラットリスト化", input: "x y ? x + y", expect: ["<x>", "<y>", "?", "<x>", "+", "<y>"] },
	{ name: "define", input: "f : x ? x + 1", expect: ["<f>", ":", "<x>", "?", "<x>", "+", "1"] },
	{ name: "前置（密着）: @x", input: "@x", expect: ["@_", "<x>"] },
	{ name: "後置（密着）: x@", input: "x@", expect: ["<x>", "_@"] },
	{ name: "GetLeft: x ' y", input: "x ' y", expect: ["<x>", "'", "<y>"] },
	{ name: "$/#の非対称性: $[array ' 0] # 3", input: "$[array ' 0] # 3", expect: ["$_", [B, [["<array>", "'", "0"]]], "#", "3"] },
	// 単位は `_` だけ。穴になるかどうかは書いた位置で決まり、それは意味解析が見るので、文法は1つの形で返す。
	{ name: "単位は `_` だけ", input: "_", expect: ["_"] },
	{ name: "書いた位置の `_`（穴かどうかは意味解析）", input: "f _ 10", expect: ["<f>", "_", "10"] },
	{ name: "`__` はただの識別子", input: "f __", expect: ["<f>", "<__>"] },
	{ name: "`_` で始まる識別子", input: "_x", expect: ["<_x>"] },
	{ name: "前置 `-` は `_` にも付く", input: "-_", expect: ["-_", "_"] },
	{ name: "前置 `!` と `_`", input: "!_", expect: ["!_", "_"] },
	{ name: "空の器", input: "go [] xs", expect: ["<go>", [B, []], "<xs>"] },
	{ name: "`\\_` は文字の字面", input: "\\_", expect: ["\\_"] },
	// 括りは印つきで1つの項になる。行（素の配列）と形で分かれる。
	{ name: "括り `[...]` は印つき", input: "[a b]", expect: [[B, [["<a>", "<b>"]]]] },
	{ name: "`(...)`・`{...}`・`[]` も同じ印", input: "(a) {b} []", expect: [[B, [["<a>"]]], [B, [["<b>"]]], [B, []]] },
	{ name: "括りの中の行は行の配列のまま", input: "f [1 2] 3", expect: ["<f>", [B, [["1", "2"]]], "3"] },
];

let passed = 0;
for (const c of cases) {
	const pre = preprocess(c.input);
	try {
		const ast = parser.parse(pre);
		const got = JSON.stringify(ast[0]);
		const want = JSON.stringify(c.expect);
		if (got === want) {
			console.log(`OK   ${c.name}`);
			passed++;
		} else {
			console.log(`FAIL ${c.name}`);
			console.log(`     got:  ${got}`);
			console.log(`     want: ${want}`);
		}
	} catch (e) {
		console.log(`FAIL ${c.name}`);
		console.log(`     preprocessed: ${JSON.stringify(pre)}`);
		console.log(`     error:        ${e.message}`);
	}
}

console.log(`\n${passed}/${cases.length} passed`);
process.exit(passed === cases.length ? 0 : 1);
