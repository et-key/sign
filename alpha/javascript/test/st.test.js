/**
 * SignType（`.st` / `.ist`）生成の動作確認（type_system.md §6）。
 *
 * 型は「宣言」されるものではなく「コードから読み取って書き写す」だけの存在であり（§1）、
 * `.st` はその書き写しである。同時にこれは**型システムに対する最初の観測手段**でもある
 * ——消費者が居ないうちは、間違った型も欠けた型も観測されないままになる。
 * ここでは「書き写せている型」と「まだ書き写せていない型」の両方を明示的に固定する。
 *
 * 実行: node test/st.test.js（`npm test` からも呼ばれる）
 */
import { compile } from "../compile.js";
import { generateSignType } from "../st.js";

let passed = 0;
let total = 0;

// 生成結果からコメント行と空行を除いた本文だけを取り出す。
function entries(source, scope = "ist") {
	const { nodes, env } = compile(source);
	const r = generateSignType(nodes, env, { scope });
	return r.text
		.split("\n")
		.filter((l) => l && !l.startsWith("`"))
		.map((l) => l.trim());
}

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

// ---- 書き写せている型 ----
check("Atom はリテラルの Layer 2 型がそのまま出る", entries("pi : 3.14"), ["pi : Float"]);
check("String も同様", entries("greeting : `hello`"), ["greeting : String"]);
check("本体が式なら返値型が出る", entries("f : x ?\n\tx > 3 : 1\n\t2"), ["f : Scalar -> Address"]);
check(
	"仮引数の型は本体の演算子から逆算する（§7.1、Scalar）",
	entries("add : a b ? a + b").map((l) => l.split("->")[0].trim()),
	["add : Scalar Scalar"]
);
check(
	"`'` でアクセスしたフィールドを要求集合として集める（§6.2）",
	entries("distance : p1 p2 ? p1 ' x - p2 ' x").map((l) => l.split("->")[0].trim()),
	["distance : {x} {x}"]
);
check(
	"分岐で違うフィールドを見たら和集合になる（§6.2 の NOTE）",
	entries("f : p ?\n\tp ' x : p ' y\n\tp ' z").map((l) => l.split("->")[0].trim()),
	["f : {x, y, z}"]
);
check("ブラケット分割代入は形をそのまま書く", entries("f : [h ~t] ? h").map((l) => l.split("->")[0].trim()), [
	"f : [h t~]",
]);

// ---- 範囲: `.st` は export されたものだけ ----
check("`.st` は export されていない識別子を出さない", entries("a : 1\nb : 2", "st"), []);
check("`.st` は export 記号を保ったまま出す", entries("#a : 1\nb : 2", "st"), ["#a : Address"]);
check("`.ist` は全識別子を出す", entries("#a : 1\nb : 2", "ist"), ["#a : Address", "b : Address"]);

// ---- まだ書き写せていない型（`_`）----
//
// 以下は「現状こうである」ことの記録であって、これが正しい仕様だという主張ではない。
// 返値型が出ない原因は3つ重なっている。いずれか1つでも欠けると `_` になる。
//
//   1. 仮引数に atomType が付かない。inferParamTypesFromUsage は実装済み・テスト済みだが
//      パイプライン（inferAtomType）から一度も呼ばれていない
//   2. apply に結果型が無い。呼び先の返値型を引く仕組みが無い（Layer 2 に Lambda が居ない）
//   3. match_case が最終行の型だけを取る。分岐の join を取っていない（§7.3 の「和」になっていない）
//
// これらが埋まったら、下の期待値は `_` ではなくなる。そのときはこのテストを書き換えること。
check("仮引数を含む式は型が付かない（原因1）", entries("f : x ? x + 1"), ["f : Scalar -> _"]);
check("最終行が apply だと返値型が付かない（原因2）", entries("g : x ? x + 1\nf : x ?\n\tx > 3 : 1\n\tg x"), [
	"g : Scalar -> _",
	"f : Scalar -> _",
]);
check(
	"match_case は最終行しか見ないので String の枝が消える（原因3）",
	entries("f : x ?\n\tx > 3 : `abc`\n\t2"),
	["f : Scalar -> Address"]
);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
