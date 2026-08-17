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
// §7.1 の表がそのまま述べている: `f : x y ? x + y` の `x`/`y` は `+` のシグネチャが
// 要求する `Scalar` であり、`f` は `Lambda<returns: Scalar>` になる。ここで言う `Scalar` は
// 「String を含まない Atom」という**族**（§4 の記法定義）であって Layer 2 の具体型では
// なく、呼び出しサイトで具体化されるまでの暫定形である。
check("仮引数の型を本体の演算子から逆算し、返値まで通る（§7.1）", entries("add : a b ? a + b"), [
	"add : Scalar Scalar -> Scalar",
]);
check("単項でも同じ", entries("f : x ? x + 1"), ["f : Scalar -> Scalar"]);
check("比較演算子からも逆算される", entries("f : x ? x > 3"), ["f : Scalar -> Scalar"]);
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

// ---- 名前付きスロットと連番スロット（§2） ----
//
// 両者は同じ構造（固定オフセットで並ぶ連続ブロック）だが**関心事が違う**。
// 名前付きは「何が在るか」が関心事で、物理オフセットは名前でソートした正規順に
// 割り当てられる（stack_abi.md §7.1）——ただしその順序は言語から観測できない。
// `==` は Hom集合の一致で宣言順を問わず、位置アクセスも持たない。
// 連番は「どこに在るか」が関心事で、宣言順がそのまま物理配置になる。
// バイト並びを書くのはこちらであり、MMIO のようにハードウェアが配置を決める場面で使う。
// 名前付きスロットの型は、それ自体が名前付きスロットの形をしている（名前→連番の写像）。
// **並び＝物理配置**（名前ソートの正規順、stack_abi.md §7.1）、**各名前が持つ値＝宣言順**。
// 両方が明示され、どちらも導出に頼らない。
//
// 宣言順を型の側で保存することには実務上の必然がある——`point ' 0` のような連番アクセスは、
// 連番→名前→ソート済みオフセットと辿って初めてコンパイルできる。型が宣言順を捨てると
// この経路が失われ、位置アクセスが解決不能になる。
//
// `point` と `point2` は `==` では等しい（Hom集合の一致は宣言順を問わない）が、連番で
// 引けば違う値を返す。それは `==` が比較していない性質を測っているだけであり矛盾ではない。
// どちらのスロットも (型, 連番) を持つ。違いは連番の書き表し方だけである——連番スロットは
// 名前が無いので並べ替える鍵が無く、記法上の位置がそのまま連番になる（だから書かない）。
// 名前付きは名前でソートして並べるため、連番は明示するしかない（`型 , 連番` の直積）。
check("名前はソート順に並び、各名前が (型, 連番) を持つ", entries("p : [\n\tx : 1\n\ty : 2\n]"), [
	"p : Struct{x : Address , 0  y : Address , 1}",
]);
check("宣言順が違えば連番が入れ替わる（ねじれが型に保存される）", entries("p : [\n\ty : 2\n\tx : 1\n]"), [
	"p : Struct{x : Address , 1  y : Address , 0}",
]);
// 並びと連番が食い違う例。宣言は CR→SR→DR だが物理配置は CR→DR→SR になる
// ——名前付きスロットに位置の確約が無いこと（stack_abi.md §7.1）が型に現れている。
check("ねじれもスロット型も1行で読める", entries("uart : [\n\tCR : 0x40011000\n\tSR : 0\n\tDR : `d`\n]"), [
	"uart : Struct{CR : Address , 0  DR : String , 2  SR : Address , 1}",
]);
check("連番スロットは順序どおりにスロット型を並べる", entries("t : 1 , `abc` , 2.5"), [
	"t : Struct(Address String Float)",
]);
// List は要素型を伴って `List(T)` と書く。要素型を落とすと「整数のリスト」と「実数の
// リスト」が同じ `List` になり、単一の実数（`Float`）とも区別が付かなくなる。要素型は
// Pass 4 が `base + i × sizeof(T)` を出すのに要る情報であり、最も落としてはいけない。
check("List は要素型を伴う（整数のリスト）", entries("l : [1 2 3]"), ["l : List(Address)"]);
check("実数のリストは区別される", entries("l : [1.0 2.0]"), ["l : List(Float)"]);
check("単一の実数とも区別される", entries("r : 5.0"), ["r : Float"]);
// 1要素のリストはスカラーと同型なので `List(T)` にならない（`[5]` は `Address`）。
// 設計上の同一視であり欠落ではない——1要素の連続ブロックとレジスタ上のスカラーは
// 同じビット列を持つ。
check("1要素のリストはスカラーと同型", entries("one : [5]"), ["one : Address"]);
// 入れ子でも要素型が保たれる。
check("連番スロットの中でも要素型が残る", entries("t : 1 , [1 2] , [1.0 2.0]"), [
	"t : Struct(Address List(Address) List(Float))",
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
// 届いていない原因は2つ残っており、いずれか1つでも欠けると `_` になる。
//
//   （原因1 の「仮引数に atomType が付かない」は解消済み。inferParamTypesFromUsage を
//     annotateTypes から呼ぶようにした——上の §7.1 のテストがその結果を固定している）
//
//   2. apply に結果型が無い。呼び先の返値型を引く仕組みが無い。返値型は識別子テーブル側に
//      置く方針（射そのものは場所を持たないが、射の適用結果は場所を持つ）。再帰では
//      不動点計算になるが、`__` が零対象なので束の底として自然に取れる
//   3. match_case が最終行の型だけを取る。分岐の join を取っていない（§7.3 の「和」）
//
// 実装が仕様へ届いたら、上の「書き写せている型」の側にテストを足すこと。

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
