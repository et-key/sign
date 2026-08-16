/**
 * SignType（`.st` / `.ist`）生成の動作確認（type_system.md §6）。
 *
 * 型は「宣言」されるものではなく「コードから読み取って書き写す」だけの存在であり（§1）、
 * `.st` はその書き写しである。同時にこれは**型システムに対する最初の観測手段**でもある
 * ——消費者が居ないうちは、間違った型も欠けた型も観測されないままになる。
 *
 * ここで固定するのは**仕様が要求する形**だけである。実装がまだ仕様へ届いていない部分は
 * 何も表明しない（下の「返値型について」を参照）。壊れている挙動を期待値に書くと、
 * それが正しい仕様であるかのように見えてしまうためである。
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

// ---- 返値型について、ここでは何も表明しない ----
//
// 仕様は返値型が静的に決まると言っている（§7.1「`?` の右辺の演算子連鎖から一意に決定」、
// §8「Lambda 返値型の静的決定 ✅」、§7.3「match_case の返値型は自然に enum になる」）。
// 実装はまだそこへ届いておらず、`npm run emit:st` は返値をほぼ全て `_` で出す
// （8-Queens は5エントリ中5つが `_`）。
//
// この「届いていない現状」をテストの期待値に書くことはしない。テストは仕様を語るもので
// あって実装を語るものではなく、壊れている挙動を期待値として固定すると、それが正しい
// 仕様であるかのように見えてしまう。埋まっていない事実は `emit_st.mjs` が出す
// 「未解決 N 箇所」がそのまま示すので、観測手段としてはそちらで足りる。
//
// 届いていない原因は3つ重なっており、いずれか1つでも欠けると `_` になる。
//
//   1. 仮引数に atomType が付かない。inferParamTypesFromUsage は実装済み・テスト済みだが
//      パイプライン（inferAtomType）から一度も呼ばれていない
//   2. apply に結果型が無い。呼び先の返値型を引く仕組みが無い（Layer 2 に Lambda が居ない
//      ため §2 と §7.1/§8 が矛盾しており、まず仕様側の決着が要る）
//   3. match_case が最終行の型だけを取る。分岐の join を取っていない（§7.3 の「和」）
//
// 実装が仕様へ届いたら、上の「書き写せている型」の側にテストを足すこと。

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
