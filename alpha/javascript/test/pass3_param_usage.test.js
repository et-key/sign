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
		want: { "<x>": "Address" },
		note: "相手が整数リテラルなら族（Scalar）ではなく Address まで決まる",
	},
	{
		source: "f : x y ? 1 + y",
		want: { "<y>": "Address", "<x>": "Atom" },
		note: "右辺としての使用（1 + y の y）でも同じ。使われていない x は裸の仮引数の下限 Atom",
	},
	// 相手のリテラルが型を決める。Sign には型注釈の構文が無いので（§1「型はコードの影」）、
	// 初期化時に型を決めたいときは**値を変えない演算**を書く。リテラルは**左辺**に置く
	// ——域を選ぶのは左辺だからである（§3.2）。`0 +` は Address、`0.0 +` は Float。
	// 実行時コストは無い（コンパイル時に消える）が型は固定される。
	{
		source: "f : x ? 0.0 + x",
		want: { "<x>": "Float" },
		note: "`0.0 +` は恒等演算だが型を Float に固定する（域を選ぶのは左辺、§3.2）",
	},
	{
		source: "f : t ? t = `abc`",
		want: { "<t>": "String" },
		note: "比較は同種同士でしか成立しないので、相手の型がそのまま制約になる",
	},
	{
		source: "f : x y ? x + y",
		want: { "<x>": "Scalar", "<y>": "Scalar" },
		note: "相手もリテラルでなければ、演算子が要求する族までしか言えない",
	},
	{
		source: "f : x y ? x",
		want: { "<x>": "Atom", "<y>": "Atom" },
		note: "演算子から逆算できなくても、裸の仮引数は宣言の形から Atom まで決まる",
	},
	{
		source: "f : x y ? x < y",
		want: { "<x>": "Scalar", "<y>": "Scalar" },
		note: "比較演算子 (<) の左辺・右辺からもScalarと逆算される（type_system.md §4）",
	},
	{
		source: "f : x y ? x !== y",
		want: { "<x>": "Atom", "<y>": "Atom" },
		note: "!==（構造比較）からは逆算しない——Scalarに限定されないため。裸の仮引数の下限 Atom だけが残る",
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
