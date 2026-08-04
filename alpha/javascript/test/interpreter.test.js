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
	const ok = want === "__" ? isUnit(got) : got === want;
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

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
