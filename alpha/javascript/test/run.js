/**
 * 動作確認用テストランナー。
 * sign.pegjs を都度ビルドし、lexer.js の preprocess() を通してからパースする。
 * 実行: npm install && npm test
 */
import peg from "pegjs";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "../lexer.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peg.generate(grammar);

const cases = [
	{
		name: "空白区切りインライン形（デフォルト無し）",
		input: "x y ? x + y",
	},
	{
		name: "インデントブロック形（デフォルト引数、function_guide.mdの例）",
		input: "f :\n\t\tx\n\t\ty : x + 1\n\t\tz : y + 1\n\t\t~rest\n\t? x y z rest~",
	},
	{
		name: "bracket形（構造的分解・[]）",
		input: "[x ~xs] ? x",
	},
	{
		name: "bracket形（括弧の等価性・()版）",
		input: "(x ~xs) ? x",
	},
	{
		name: "bracket形（括弧の等価性・{}版）",
		input: "{x ~xs} ? x",
	},
];

let passed = 0;
for (const c of cases) {
	const pre = preprocess(c.input);
	try {
		parser.parse(pre);
		console.log(`OK   ${c.name}`);
		passed++;
	} catch (e) {
		console.log(`FAIL ${c.name}`);
		console.log(`     input:        ${JSON.stringify(c.input)}`);
		console.log(`     preprocessed: ${JSON.stringify(pre)}`);
		console.log(`     error:        ${e.message}`);
	}
}

console.log(`\n${passed}/${cases.length} passed`);
process.exit(passed === cases.length ? 0 : 1);
