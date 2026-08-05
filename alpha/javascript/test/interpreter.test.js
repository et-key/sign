/**
 * 最小インタプリタ（interpreter.js）の動作確認。
 * type_system.md §3.3/§3.4が挙げている具体例（完全性公理・デフォルト引数の
 * Unitフォールバック・算術演算子のUnit伝播）をそのまま実行して値が一致することを確認する。
 *
 * 実行: node test/interpreter.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "../lexer.js";
import { reduceAll } from "../pass2.js";
import { buildEnv } from "../pass1.js";
import { evaluate, newRuntimeEnv, envGet, UNIT, isUnit } from "../interpreter.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peggy.generate(grammar);

// プログラム全体（複数行）を静的解決＋実行時評価し、最後の行の評価結果を返す。
function run(source) {
	const pre = preprocess(source);
	const lines = parser.parse(pre);
	const staticEnv = buildEnv(lines);
	const nodes = lines.map((line) => reduceAll(line, staticEnv));
	const runtimeEnv = newRuntimeEnv(null);
	let result = UNIT;
	for (const node of nodes) result = evaluate(node, runtimeEnv);
	return result;
}

let passed = 0;
let total = 0;

function check(note, got, want) {
	total++;
	const gotDisplay = isUnit(got) ? "__" : got;
	const wantDisplay = want === "__" ? "__" : want;
	const ok = want === "__" ? isUnit(got) : Array.isArray(want) ? JSON.stringify(got) === JSON.stringify(want) : got === want;
	if (ok) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got: ${JSON.stringify(gotDisplay)}, want: ${JSON.stringify(wantDisplay)}`);
	}
}

check("f : x y ? x + y  /  f 3 5 → 8（多引数の一括適用）", run("f : x y ? x + y\nf 3 5"), 8);

check("f 3 __ → __（完全性公理: デフォルト無しのパラメータにUnit → 呼び出し全体が崩壊）", run("f : x y ? x + y\nf 3 __"), "__");

check(
	"g 3 → 7（デフォルト引数: y:x+1が評価され 3+4=7）",
	run("g :\n\tx\n\ty : x + 1\n ? x + y\ng 3"),
	7
);

check(
	"g 3 __ → 7（yにUnitが渡されてもデフォルト値にフォールバックし、崩壊しない）",
	run("g :\n\tx\n\ty : x + 1\n ? x + y\ng 3 __"),
	7
);

check(
	"g __ 5 → __（xにデフォルトが無いため、Unitで呼び出し全体が崩壊）",
	run("g :\n\tx\n\ty : x + 1\n ? x + y\ng __ 5"),
	"__"
);

check("__ + 5 → __（算術演算子の左辺Unitは吸収元）", run("__ + 5"), "__");

check("5 + __ → 5（算術演算子の右辺Unitは単位元、素通し）", run("5 + __"), 5);

check("x < y（比較演算子、両辺ともUnitで無ければ真の場合は右辺(0/1でなければ左辺)を返す）", run("3 < 5"), 3);

check("__ | 5 → 5（|は短絡評価、左辺Unitなら右辺を評価して返す）", run("__ | 5"), 5);

check("3 | 5 → 3（|は短絡評価、左辺が非Unitならそのまま返す）", run("3 | 5"), 3);

check(
	// documents/ja-jp/guide/example.sn: `[+ 1] [* 2] 5 = [* 2]([+ 1] 5) = 12`
	// （左が先に適用され、その結果に右が適用される＝左→右パイプライン順）。
	// ブラケット部分適用（[+1]の穴埋め展開）は別の未実装機能のため、名前付きLambdaで確認する。
	"double inc 5 → 11（double=x*2 が先に5へ適用され10、その結果にinc=x+1 が適用され11）",
	run("double : x ? x * 2\ninc : x ? x + 1\ndouble inc 5"),
	11
);

// 【重要】type_system.md §3.2の表を正とする：String+算術演算子は型エラーで__に収束する。
// list_model.md §4.4の文面（「+でコードポイントが露出する」）は自身の例で実証されておらず、
// interpreter.js側のコメントで既知の食い違いとして記録済み。
check("`abc` + 1 → __（String左辺への算術演算子は型エラー、type_system.md §3.2）", run("`abc` + 1"), "__");

check(
	// list_model.md: `123` 123 = `123123`（左辺が文字列→右辺を文字列化してテキスト連結）
	"`123` 123 → \"123123\"（文字列 スペース 数値 のテキスト連結、list_model.md）",
	run("`123` 123"),
	"123123"
);

check(
	// type_system.md §3.3の再帰例。括弧必須（+の優先順位13はスペース適用10より高いため、
	// 括弧無しだと x と sum（関数値）が直接結合されてしまう、既知の食い違いとして
	// §3.3コメントに追記済み）。
	// 後置~（xs~）は複数の位置引数へ展開される（pattern_guide.md）——これが無いと
	// xsが配列のまま1個の引数として渡り続け、再帰が終端しない。
	"sum : x ~xs ? x + (sum xs~)  /  sum 1 2 3 → 6（再帰、xs~の展開でrestが正しく終端する）",
	run("sum : x ~xs ? x + (sum xs~)\nsum 1 2 3"),
	6
);

{
	// 辞書リテラル：全行がdefineのブロックは独立したスコープで評価され、キーが
	// 呼び出し元のenvへ漏れないことを確認する（以前はブロックの値＝最後の文の値、として
	// 評価してしまい、辞書オブジェクトにならず foo/bar が外側スコープに漏れていた）。
	total++;
	const { nodes, env } = (() => {
		const source = "d : [\n\tfoo : 1\n\tbar : 2\n]\nfoo";
		const pre = preprocess(source);
		const lines = parser.parse(pre);
		const staticEnv = buildEnv(lines);
		const runtimeEnv = newRuntimeEnv(null);
		const results = [];
		for (const line of lines) results.push(evaluate(reduceAll(line, staticEnv), runtimeEnv));
		return { nodes: results, env: runtimeEnv };
	})();
	const dictValue = nodes[0];
	const fooLeaked = !isUnit(nodes[1]);
	const note = "辞書リテラル [foo:1, bar:2]（改行形）→ {foo:1,bar:2} になり、foo は外側スコープに漏れない";
	const ok = JSON.stringify(dictValue) === JSON.stringify({ foo: 1, bar: 2 }) && !fooLeaked;
	if (ok) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     dictValue: ${JSON.stringify(dictValue)}, fooLeaked: ${fooLeaked}`);
	}
}

check(
	// get_prop（'）: 右辺の識別子は変数として評価せず、キー名そのものとして辞書から引く。
	"d ' foo → 1（get_prop、右辺の識別子はキー名として扱う。変数参照ではない）",
	run("d : [\n\tfoo : 1\n\tbar : 2\n]\nd ' foo"),
	1
);

check("d ' bar → 2（同上、2件目のキー）", run("d : [\n\tfoo : 1\n\tbar : 2\n]\nd ' bar"), 2);

// 未定義識別子のUnit収束は診断上informationとして記録される（unit.md §0.1、非ブロッキング）。
function runDiag(source) {
	const pre = preprocess(source);
	const lines = parser.parse(pre);
	const staticEnv = buildEnv(lines);
	const nodes = lines.map((line) => reduceAll(line, staticEnv));
	const runtimeEnv = newRuntimeEnv(null);
	let result = UNIT;
	for (const node of nodes) result = evaluate(node, runtimeEnv);
	return { result, diagnostics: runtimeEnv.diagnostics };
}

function checkTrue(note, cond) {
	total++;
	if (cond) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
	}
}

{
	const { result, diagnostics } = runDiag("tick");
	checkTrue("未定義識別子 tick → __ に収束しつつ例外を投げない", isUnit(result));
	checkTrue(
		"未定義識別子 tick → diagnosticsに1件、level='information'（仮想キーワード利用を委縮させないためwarningへ格上げしない）",
		diagnostics.length === 1 && diagnostics[0].level === "information" && diagnostics[0].identifier === "<tick>"
	);
}

{
	const { diagnostics } = runDiag("x : 5\nx + 1");
	checkTrue("定義済み識別子 x の参照 → diagnosticsは空", diagnostics.length === 0);
}

// apply_reverse（UFCS的な `receiver method` 記法、coproduct_resolver.md §3の10.3）。
// pass2.jsのtier=10縮約をcompose→apply→apply_reverse→concat/push/constructの4段階マルチパスに
// 直したことで、apply_reverseは「そのLambdaが右側に通常適用できるAtomを持たない場合のみ」
// 発動するフォールバックになった（8/5の設計合意：主語は必ずしも第1引数ではなくUFCSのreceiver）。
check("5 inc → 6（レシーバをinc(x?x+1)へ1個だけ渡すUFCS的呼び出し）", run("inc : x ? x + 1\n5 inc"), 6);

check(
	"5 inc inc → 7（Lambda-Lambdaのcompose(inc,inc)が先に確定し、その合成へ5をreverse apply。UFCSメソッドチェーン）",
	run("inc : x ? x + 1\n5 inc inc"),
	7
);

check(
	"5 inc 3 → [5, 4]（apply(inc,3)がtier10.4で先に確定し、apply_reverseが5を横取りしない。arity1のincが両隣のAtomに挟まれても通常適用が優先される）",
	run("inc : x ? x + 1\n5 inc 3"),
	[5, 4]
);

check(
	"[1 2]~ pair → __（apply_reverseは後置~でも展開せず常に1個のreceiver値として渡す。pair(a b?a)のbが埋まらず完全性公理で崩壊）",
	run("pair : a b ? a\n[1 2]~ pair"),
	"__"
);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
