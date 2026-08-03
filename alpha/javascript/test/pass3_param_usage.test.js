/**
 * Pass3: 仮引数のatomType自動導出（type_system.md §7.1）の動作確認。
 * `f : x y ? x + y` の x/y のように、仮引数自身は定義行を持たないため、本体の
 * 演算子使用箇所（算術演算子の左辺・右辺）から atomType（Scalar）を逆算できることを確認する。
 *
 * 実行: node test/pass3_param_usage.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "../lexer.js";
import { reduceAll } from "../pass2.js";
import { buildEnv } from "../pass1.js";
import { inferLambdaParamTypes } from "../pass3.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peggy.generate(grammar);

function lambdaNodeOf(source) {
	const pre = preprocess(source);
	const lines = parser.parse(pre);
	const env = buildEnv(lines);
	const defineNode = reduceAll(lines[0], env);
	return defineNode.right; // define[name, lambda[...]] の lambda ノード
}

function mapToObj(m) {
	return Object.fromEntries(m.entries());
}

const cases = [
	{
		source: "f : x y ? x + y",
		want: { "<x>": "Scalar", "<y>": "Scalar" },
		note: "x y ? x + y: x(左辺)・y(右辺)ともに + のシグネチャからScalarと逆算される（§7.1）",
	},
	{
		source: "f : x ? x + 1",
		want: { "<x>": "Scalar" },
		note: "単一の裸パラメータ（既存の出力形状: identifier単体）でも逆算できる",
	},
	{
		source: "f : x y ? 1 + y",
		want: { "<y>": "Scalar" },
		note: "右辺としての使用（1 + y の y）でもScalarと逆算される。使われていない x は結果に含まれない",
	},
	{
		source: "f : x y ? x",
		want: {},
		note: "算術演算子で使われていないパラメータは推定されない（空のMap）",
	},
];

let passed = 0;
for (const c of cases) {
	const lambdaNode = lambdaNodeOf(c.source);
	const got = mapToObj(inferLambdaParamTypes(lambdaNode));
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
