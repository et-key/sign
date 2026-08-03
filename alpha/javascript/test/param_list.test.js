/**
 * Lambda定義行（トップレベルに `?` を持つ行）の仮引数部専用処理の動作確認。
 *
 * 背景: `:`(define, precedence=1)と`?`(lambda, precedence=2)は演算子テーブル上もっとも
 * 低い優先度で処理されるため、仮引数部を総当たり縮約に素通しすると、`?`が処理される前に
 * 仮引数部の中身が既存の汎用ルールで誤って確定してしまう（`g x` → construct[g,x]、
 * `y : x + 1` → define[y, add[x,1]]）。pass2.js の reduceAll に追加した専用分岐
 * （resolveLambdaLine / buildParameterList）が、これを正しく「パラメータの宣言」として
 * 扱えることを確認する。
 *
 * 実行: node test/param_list.test.js
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
	if (node.type === "block") return `${node.kind}{${node.lines.map(show).join("; ")}}`;
	if (node.type === "params") {
		return `params[${node.entries.map((e) => (e.rest ? `~${e.name}` : e.default ? `${e.name}:${show(e.default)}` : e.name)).join(", ")}]`;
	}
	if (node.type === "unresolved") return `UNRESOLVED[${node.items.map((x) => (typeof x === "string" ? x : show(x))).join(", ")}]`;
	return JSON.stringify(node);
}

function resolveSource(source) {
	const pre = preprocess(source);
	const lines = parser.parse(pre);
	const env = buildEnv(lines);
	return lines.map((line) => show(reduceAll(line, env)));
}

const cases = [
	{
		// 関数名を「apply」にしなかったのは意図的: `g` は `@` を付けない限り Atom 扱いのため、
		// 本体 `g x` は関数適用ではなく construct[g,x]（ただのタプル作成）にしかならない
		// （type_system.md §3.5）。実際に g を x に適用する正しい書き方は次のケース（@g x）。
		source: "pair : g x ? g x",
		want: ["define[identifier(<pair>), lambda[params[<g>, <x>], construct[identifier(<g>), identifier(<x>)]]]"],
		note: "裸の複数仮引数 (g x) が params[] として構造化される（以前は construct[g,x] に誤って縮約されていた）",
	},
	{
		source: "apply : g x ? @g x",
		want: ["define[identifier(<apply>), lambda[params[<g>, <x>], apply[input(identifier(<g>)), identifier(<x>)]]]"],
		note: "@g x（前置@で明示的に呼び出す）は正しく apply[g, x] に解決される。g x（@無し）とは違う挙動になることの確認",
	},
	{
		source: "f : x ~xs ? x",
		want: ["define[identifier(<f>), lambda[params[<x>, ~<xs>], identifier(<x>)]]"],
		note: "裸のrestパラメータ (x ~xs) も params[] 内で正しく分割される",
	},
	{
		source: "get_age : [x ~xs] ? x",
		want: ["define[identifier(<get_age>), lambda[params[<x>, ~<xs>], identifier(<x>)]]"],
		note: "ブラケット形式 [x ~xs]（1行に複数の裸パラメータが同居）でも正しく分割される",
	},
	{
		source: "f :\n\tx\n\ty : x + 1\n\tz : y + 1\n\t~rest\n ? x y z rest~",
		want: [
			"define[identifier(<f>), lambda[params[<x>, <y>:add[identifier(<x>), number(1)], <z>:add[identifier(<y>), number(1)], ~<rest>], construct[construct[construct[identifier(<x>), identifier(<y>)], identifier(<z>)], expand(identifier(<rest>))]]]",
		],
		note: "インデントブロック形のデフォルト引数: y:x+1 は add[x,1] として（define扱いされずに）解決され、z:y+1 は let* 的にひとつ前の y を正しく参照する",
	},
	{
		source: "f :\n\t[\n\t\tx\n\t\t~y\n\t]\n ? x",
		want: ["define[identifier(<f>), lambda[params[<x>, ~<y>], identifier(<x>)]]"],
		note: "ブラケットを定義行より深くインデントして複数行で書いても（lexer.jsのbracketDepth対応）正しくパースされる",
	},
	{
		source: "func_mixed :\n\t[\n\t\tx\n\t\ty : x + 1\n\t\t~z\n\t]\n ? x",
		want: [
			"define[identifier(<func_mixed>), lambda[params[<x>, <y>:add[identifier(<x>), number(1)], ~<z>], identifier(<x>)]]",
		],
		note: "function_guide.mdのfunc_mixed例: ブラケット形式（複数行）とデフォルト引数の組み合わせが正しく解決される",
	},
];

let passed = 0;
let total = 0;

for (const c of cases) {
	total++;
	const got = resolveSource(c.source);
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

// let*的な逐次スコープの強制: 前方参照・自己参照はReferenceErrorになる
const throwCases = [
	{
		source: "f :\n\tx\n\ty : z + 1\n\tz : 1\n ? x y z",
		note: "前方参照: y のデフォルト式が、まだ束縛されていない後ろの z を参照 → ReferenceError",
	},
	{
		source: "f :\n\tx\n\ty : y + 1\n ? x y",
		note: "自己参照: y のデフォルト式が自分自身の y を参照 → ReferenceError",
	},
];

for (const c of throwCases) {
	total++;
	let threw = false;
	try {
		resolveSource(c.source);
	} catch (e) {
		threw = e instanceof ReferenceError;
	}
	if (threw) {
		console.log(`OK   ${c.note}`);
		passed++;
	} else {
		console.log(`FAIL ${c.note}`);
		console.log(`     source: ${JSON.stringify(c.source)}`);
		console.log(`     expected ReferenceError, got threw=${threw}`);
	}
}

// requiredArity: デフォルト・rest以外の仮引数の数が正しく計算されること
{
	total++;
	const pre = preprocess("f :\n\tx\n\ty : x + 1\n\tz : y + 1\n\t~rest\n ? x y z rest~");
	const lines = parser.parse(pre);
	const env = buildEnv(lines);
	const defineNode = reduceAll(lines[0], env);
	const requiredArity = defineNode.right.left.requiredArity;
	const note = "requiredArity: x のみデフォルト・rest無しなので 1 になる（y,z はデフォルト、rest は rest）";
	if (requiredArity === 1) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got requiredArity: ${requiredArity}, want: 1`);
	}
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
