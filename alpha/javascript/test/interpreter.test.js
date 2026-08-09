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
import { compile } from "../compile.js";
import { evaluate, newRuntimeEnv, envGet, UNIT, isUnit } from "../interpreter.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peggy.generate(grammar);

// プログラム全体（複数行）を静的解決＋実行時評価し、最後の行の評価結果を返す。
// 静的側は compile()（Pass 1〜3 の単一ドライバ）に一本化した。パーサーだけは
// sign.pegjs（正式仕様）から都度ビルドしたものを渡す——ビルド済みparser.jsの
// staleness をテストが見逃さないようにするため（compile.js の注記参照）。
function run(source) {
	const { nodes } = compile(source, { parse: parser.parse });
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

// §3.2「数値の昇格格子」: 算術族の型不一致は**両方向とも**__へ収束する。
// 以前は右辺だけ素通しでJSの型強制が漏れており、`1 + \`abc\`` が "1abc" という
// 「もっともらしく見える間違った値」を静かに返していた（ギャップ表で最優先とした件）。
check("1 + `abc` → __（右辺Stringも型エラー。以前は \"1abc\" を返していた）", run("1 + `abc`"), "__");
check("1 + [2 3] → __（右辺Listも型エラー。JSなら \"12,3\" に強制される）", run("1 + [2 3]"), "__");
check("x : !__ / x + 1 → __（Id射への算術も型エラー）", run("x : !__\nx + 1"), "__");
check("[1 2] * `ab` → __（List左辺の*は右辺がAddressでなければ型エラー）", run("[1 2] * `ab`"), "__");
// 昇格側（数値同士）は無傷であることの確認
check("5 + 1.5 → 6.5（Address⊕Floatは昇格、降格しない）", run("5 + 1.5"), 6.5);
check("1.5 + 5 → 6.5（Float⊕Addressも同じ）", run("1.5 + 5"), 6.5);

// §4.1: `'` は Address（位置）を構造的に要求するので、Floatが来たら四捨五入する。
// 位置は整数でしか存在しないため、分数添字は補間ではなく丸めになる（補間は通常の
// 関数として書く——`'`に焼き付けると補間の種類を選べず、意図しないFloat混入時に
// エラーも出ないまま遅く・違う値を返す最悪の失敗をするため）。
check("[10 20 30 40] ' 1.5 → 30（1.5→2、補間ではない）", run("[10 20 30 40] ' 1.5"), 30);
check("[10 20 30 40] ' 2.4 → 30（2.4→2）", run("[10 20 30 40] ' 2.4"), 30);
check("[10 20 30 40] ' 2.5 → 40（2.5→3、タイは0から遠ざける）", run("[10 20 30 40] ' 2.5"), 40);
check("[10 20 30 40] ' -1.5 → 30（-1.5→-2、負側も0から遠ざける）", run("[10 20 30 40] ' -1.5"), 30);
check("`abcd` ' 1.5 → `c`（StringはList(0u)と同型なので同じ規則、§2）", run("`abcd` ' 1.5"), "c");
check("[10 20 30 40] ' 1 → 20（整数添字は回帰なし）", run("[10 20 30 40] ' 1"), 20);
check("[1 2 3 4] ' [1 ~ 3] → [2 3 4]（範囲添字は回帰なし）", run("[1 2 3 4] ' [1 ~ 3]"), [2, 3, 4]);

// ---- pass3 が載せた Layer 2 型を評価器が読む（compile.js のパイプライン） ----
// §3.2「除算だけは Address 同士でも丸めが起きる」。丸めるべきかは**値**からは決まらない
// ——JSのNumberでは `5` と `5.0` が同一なので、ノードの atomType を見て初めて区別できる。
check("5 / 2 → 3（Address同士の除算は四捨五入）", run("5 / 2"), 3);
check("-5 / 2 → -3（タイは0から遠ざける）", run("-5 / 2"), -3);
check("7 / 2 → 4（3.5→4）", run("7 / 2"), 4);
check("4 / 2 → 2（割り切れるので丸めは起きない）", run("4 / 2"), 2);
check("5.0 / 2 → 2.5（Floatへ昇格するので丸めない）", run("5.0 / 2"), 2.5);
check("5 / 2.0 → 2.5（右辺Floatでも昇格）", run("5 / 2.0"), 2.5);
check("a : 5 / a / 2 → 3（識別子経由のAddress）", run("a : 5\na / 2"), 3);
check("a : 5.0 / a / 2 → 2.5（識別子経由のFloat）", run("a : 5.0\na / 2"), 2.5);

// comparison.md §2.1: 算術単位元(0/1)の判定は数値ドメイン全体が対象。
// Float も ℝ の体としての単位元を持つため対象に含む（2026-08-09にFloat除外を撤回）。
check("1.0 < 5.0 → 5（Floatの1.0も乗算単位元）", run("1.0 < 5.0"), 5);
check("0.0 < 5.0 → 5（Floatの0.0も加法単位元）", run("0.0 < 5.0"), 5);
check("2.5 < 5.0 → 2.5（単位元でなければ左辺）", run("2.5 < 5.0"), 2.5);
check("a : 1.0 / a < 5.0 → 5（識別子経由でも同じ）", run("a : 1.0\na < 5.0"), 5);
check("`abc` < `abd` → `abc`（Stringは算術ドメインでないので対象外）", run("`abc` < `abd`"), "abc");

// §3.2 余積族: String は吸収元。あらゆる値がテキスト表現を持つため String との join は
// 常に存在し、左右どちらに来てもテキスト連結になる。以前は左辺しか見ておらず、
// `` `ab` 1 `` → "ab1" なのに `1 `ab`` → [1, "ab"] という、引数の順序で挙動が変わる
// 非対称になっていた。
check("`ab` 1 → \"ab1\"（String左辺）", run("`ab` 1"), "ab1");
check("1 `ab` → \"1ab\"（String右辺でも同じ）", run("1 `ab`"), "1ab");
check("`123` 123 → \"123123\"（list_model.md §4.4）", run("`123` 123"), "123123");
check("1 2 3 → [1 2 3]（Stringが無ければ従来通りList構築）", run("1 2 3"), [1, 2, 3]);

// ---- ポイントフリーはストリームを食う（合成はストリームのパイプライン） ----
// `f g` は左→右のパイプライン（`(f g)(x) = g(f(x))`）なので実引数は**左の関数**へ渡る。
// 左が貪欲なポイントフリーなら合成全体も貪欲でなければならない（pass2側の判定）。
// さらに、合成の中間は「1個のList値」ではなく**流れていくストリーム**なので、
// 次段が貪欲なポイントフリーなら展開して渡す（interpreter側）。
// 以前は前者を見落として `[2 2 3 4 5]`、後者を見落として `[2 4 6 8 10]` になっていた。
check("[* 2,] [+] 1 2 3 4 5 → 30（写像→畳み込みがストリームで繋がる）", run("[* 2,] [+] 1 2 3 4 5"), 30);
check("[* 2,] [* 3,] 1 2 3 → [6 12 18]（写像→写像）", run("[* 2,] [* 3,] 1 2 3"), [6, 12, 18]);
// 括弧で括るとそこで値（List）に固まるため、畳み込むには後置~での展開が要る。
// この「ストリームか値か」の区別が括弧の有無にそのまま対応する。
check("[+] ([* 2,] 1 2 3 4 5) → [2 4 6 8 10]（括弧で値に固まり1引数として渡る）", run("[+] ([* 2,] 1 2 3 4 5)"), [2, 4, 6, 8, 10]);
check("[+] ([* 2,] 1 2 3 4 5)~ → 30（後置~で展開すれば畳み込める）", run("[+] ([* 2,] 1 2 3 4 5)~"), 30);
check("[* 2,] 1 2 3 4 5 → [2 4 6 8 10]（合成なしは回帰なし）", run("[* 2,] 1 2 3 4 5"), [2, 4, 6, 8, 10]);
check("[+] 1 2 3 4 5 → 15（同上）", run("[+] 1 2 3 4 5"), 15);
check("[+ 1] [* 2] 5 → 12（非貪欲なポイントフリーの合成は回帰なし）", run("[+ 1] [* 2] 5"), 12);

// ---- ポイントフリーも通常の中置と同じ算術の型規則を通る ----
// 以前は applyPointfree の combine が ARITH_OPS を直に叩いて型ガードを迂回しており、
// JSの型強制がそのまま漏れていた（silent-wrong-value）。
check("[+ 1] [1 2 3] → __（以前は \"1,2,31\" というJS配列→文字列強制が漏れていた）", run("[+ 1] [1 2 3]"), "__");
check("[* 2,] `abc` → __（以前は NaN）", run("[* 2,] `abc`"), "__");
check("[+] `abc` 1 → __（Stringへの算術は型エラー）", run("[+] `abc` 1"), "__");
check("[* 2,] [1 2 3] → [[1 2 3 1 2 3]]（List*AddressはList複製、§3.2）", run("[* 2,] [1 2 3]"), [[1, 2, 3, 1, 2, 3]]);

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
		const compiled = compile(source, { parse: parser.parse });
		const runtimeEnv = newRuntimeEnv(null);
		const results = compiled.nodes.map((node) => evaluate(node, runtimeEnv));
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
	const { nodes } = compile(source, { parse: parser.parse });
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

function checkThrows(note, fn) {
	total++;
	try {
		fn();
		console.log(`FAIL ${note}`);
		console.log(`     例外が投げられなかった`);
	} catch (e) {
		console.log(`OK   ${note}`);
		passed++;
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

// ブラケット仮引数リスト（`[x ~xs]`等）への単一List/Dict実引数の分割代入（8/5の設計合意、
// list_model.md §2.4のEagerパターン）。以前はbindParamsが位置引数と区別せず扱っていたため、
// Listの場合は先頭要素ではなくList全体が最初の仮引数に丸ごと束縛され、restパラメータが
// 常に空になって再帰が終端しなかった（function_guide.mdのsum_list例でスタックオーバーフロー）。
check(
	"sum_list [1 2 3 4 5] → 15（[x ~xs]がListを要素ごとに分割代入する、function_guide.md）",
	run("sum_list : [x ~xs] ? xs & x + (sum_list xs) | x\nsum_list [1 2 3 4 5]"),
	15
);

check(
	"calc_diff dict渡し → 80（[foo bar ~obj]がキー名一致で辞書を自動バインドする、順序に依らない）",
	run("calc_diff : [foo bar ~obj] ? foo - bar\ncalc_diff [\n\tbar : 20\n\tfoo : 100\n]"),
	80
);

check(
	"get_age dict渡し → 20（pattern_guide.mdのStore例、~objは未使用でも問題ない）",
	run("get_age : [age ~obj] ? age\ndict :\n\tname : `Johnny`\n\tage : 20\nget_age dict"),
	20
);

check(
	"get_age [1 2 3] → 1（既存のList destructuringは回帰なし）",
	run("get_age : [x ~xs] ? x\nget_age [1 2 3]"),
	1
);

// match_case（function_guide.md「?の右辺を改行・インデントブロックを挟むことで、本体内の
// :演算子はmatch_caseとなる」）。以前は本体内の`cond : result`行が普通のdefine（左辺が
// 識別子でないため envDefine(env, undefined, ...) という無意味な副作用のみ）として処理され、
// ブロック評価は常に最後の行の値を返すだけだった。左辺が識別子でないdefine行を「条件:結果」の
// 短絡評価テストとして扱うよう修正（左辺が識別子の行は今まで通りの変数定義のまま）。
{
	const func_mixed =
		"func_mixed :\n\t[\n\t\tx\n\t\ty : x + 1\n\t\t~z\n\t]\n ?\n\tx > 3 : x - y\n\ty\n";
	check("func_mixed [5] → -1（x=5,y=6、x>3が真なのでx-yで短絡）", run(func_mixed + "func_mixed [5]"), -1);
	check("func_mixed [2] → 3（x=2,y=3、x>3が偽なのでフォールバックのyへ）", run(func_mixed + "func_mixed [2]"), 3);
	check("func_mixed [2 10] → 10（x=2,y=10、x>3が偽なのでフォールバックのyへ）", run(func_mixed + "func_mixed [2 10]"), 10);
}

{
	const either =
		"f : x y ?\n\tx < 0 : `Error : x is negative`\n\ty < 0 : `Error : y is negative`\n\tx * y\n";
	check("Either例 f 2 3 → 6（どちらの条件も偽、フォールバックのx*y）", run(either + "f 2 3"), 6);
	check(
		"Either例 f -1 -1 → Error : x is negative（最初に真になった条件で短絡、2番目は評価されない）",
		run(either + "f -1 -1"),
		"Error : x is negative"
	);
	check("Either例 f 2 -1 → Error : y is negative（1番目は偽、2番目が真で短絡）", run(either + "f 2 -1"), "Error : y is negative");
}

check(
	"辞書リテラル（全行が識別子キーのdefine）は引き続きDictとして評価される（match_case誤判定の回帰なし）",
	run("d : [\n\tfoo : 1\n\tbar : 2\n]\nd ' foo"),
	1
);

// list_cheat_sheet.md: push/unshift（先頭/末尾への要素追加）は評価ケース自体が無く
// 「未対応の演算」で例外になっていた。
check("0 [1 2 3] → [0, 1, 2, 3]（push、先頭に要素追加）", run("0 [1 2 3]"), [0, 1, 2, 3]);
check("[1 2 3] 4 → [1, 2, 3, 4]（unshift、末尾に要素追加）", run("[1 2 3] 4"), [1, 2, 3, 4]);

// list_cheat_sheet.md: |list|（abs）は絶対値ブロックとして正しくパースされていたが、
// 評価側で長さ/絶対値の計算をしておらず中身がそのまま返っていた。
check("|1 2 3| → 3（List要素数）", run("|1 2 3|"), 3);
check("|`abc`| → 3（String長）", run("|`abc`|"), 3);
check("|0 - 5| → 5（数値の絶対値）", run("|0 - 5|"), 5);

// list_model.md §2.1/n次元配列構築: `,`(product)は左結合のスカラー連鎖
// （`1,2,3,4,5` = `1 2 3 4 5`と等価なフラットリスト）と、スペースで構築済みの塊同士の
// 直積（`1 2 3 , 4 5 6` → [[1,2,3],[4,5,6]]、ネスト）を区別する必要があるが、
// 以前は常に左辺だけ展開・右辺は1要素として追加する非対称な評価になっていた
// （[1,2,3,[4,5,6]]という誤った形）。左辺が同じproductノードの連鎖の場合だけ展開するよう修正。
check("1 2 3 , 4 5 6 → [[1,2,3],[4,5,6]]（n次元配列構築、ネスト）", run("1 2 3 , 4 5 6"), [
	[1, 2, 3],
	[4, 5, 6],
]);
check("1, 2, 3, 4, 5 → [1,2,3,4,5]（スカラーのカンマ連鎖はスペース区切りと等価、フラット）", run("1, 2, 3, 4, 5"), [1, 2, 3, 4, 5]);

// list_cheat_sheet.md: List左辺の算術演算子（*/^// ）は固有の意味（repeat/lift/split）を
// 持つが、以前はScalar用のARITH_OPSにそのまま渡され、JSの配列→文字列強制変換により
// 静かにNaNを返す（＝JSON化するとnullに見える、実質バグ）状態だった。
check("[0 1] * 3 → [0,1,0,1,0,1]（repeat、lをr回連結）", run("[0 1] * 3"), [0, 1, 0, 1, 0, 1]);
check("[0 1] ^ 3 → [[0,1],[0,1],[0,1]]（lift、lのコピーをr個持ち上げる）", run("[0 1] ^ 3"), [
	[0, 1],
	[0, 1],
	[0, 1],
]);
check("[1 2 3 4] / 2 → [[1,2],[3,4]]（split、lをr個のグループへ均等分割）", run("[1 2 3 4] / 2"), [
	[1, 2],
	[3, 4],
]);
check(
	"[1 2 3] + 1 → __（list_cheat_sheetに無い組み合わせはStringと同様に型エラーでUnit収束）",
	run("[1 2 3] + 1"),
	"__"
);

// list_model.md §2.3 / list_cheat_sheet.md「範囲リスト構築」。以前は"range"/"range_arithmetic"
// ノードの評価ケースが無く「未対応の演算」で例外になっていた。本インタプリタは値を全て
// 実体化する単純な評価器のため、3項セット（[start ~+ step ~ end]、即座に全消費）だけを
// 配列へ展開し、2項指定（[start ~+ step]、終端の無いPull型無限ストリーム）は明示的に
// 未対応としてエラーにする（無限ループにしない）。
check("[1 ~ 5] → [1,2,3,4,5]（単純形式、step省略で+1）", run("[1 ~ 5]"), [1, 2, 3, 4, 5]);
check("[5 ~ 1] → [5,4,3,2,1]（降順、start>endならstep=-1）", run("[5 ~ 1]"), [5, 4, 3, 2, 1]);
check("[2 ~+ 2 ~ 10] → [2,4,6,8,10]（派生演算子~+の3項形式、等差数列）", run("[2 ~+ 2 ~ 10]"), [2, 4, 6, 8, 10]);
check("[1 2 3 4] ' [1 ~ 3] → [2,3,4]（rangeを範囲インデックスとしてget_propに渡す）", run("[1 2 3 4] ' [1 ~ 3]"), [
	2, 3, 4,
]);
{
	let threw = false;
	try {
		run("[1 ~+ 1]");
	} catch (e) {
		threw = e instanceof Error;
	}
	checkTrue("[1 ~+ 1] → 例外（終端の無い2項指定は無限ストリームのため明示的に未対応、無限ループにしない）", threw);
}

// ポイントフリー記述（function_guide.md「任意のカッコで演算子を囲むことで関数として扱う」）。
// `[+]`（左右とも欠落）は複数の引数を貪欲に畳み込み、`[+ 1]`（右辺だけ束縛）は欠けている
// 左辺を呼び出し引数で埋める。以前は"+"という裸の演算子トークンがgetCategoryで一切
// 拾われずAtom扱いされ、`getCategory`のblock判定も中身を見ずに常にAtomを返していたため、
// `[+]`はLambdaとして機能せず、`1 2 [+] 3 4`のような式は`+`を一度も呼ばずに
// 静かに変な値を返していた（apply_reverse設計の議論で最初に見つかった問題）。
check("[+] 1 2 3 4 5 → 15（完全に裸な演算子、複数引数を貪欲に畳み込む）", run("[+] 1 2 3 4 5"), 15);
check("[+] [1 2 3 4]~ → 10（後置~の展開と組み合わせた畳み込み関数、list_cheat_sheet.md）", run("[+] [1 2 3 4]~"), 10);
check("[+ 1] 5 → 6（右辺だけ束縛、欠けている左辺を呼び出し引数で埋める）", run("[+ 1] 5"), 6);
check("[* 2] 6 → 12（同上）", run("[* 2] 6"), 12);
check(
	"[+ 1] [* 2] 5 → 12（documents/ja-jp/guide/example.snの合成連鎖の例）",
	run("[+ 1] [* 2] 5"),
	12
);
checkTrue(
	"[+] 単体 → クロージャのまま（値として評価しても即座に演算しようとしない）",
	(() => {
		const v = run("[+]");
		return !!(v && v.__lambda__);
	})()
);
check("[1 2 3] は引き続き普通のList（ポイントフリー判定に巻き込まれない）", run("[1 2 3]"), [1, 2, 3]);

// 8/5の設計合意: ポイントフリー由来のLambdaはapply_reverseの対象から除外する（演算子の
// 種類を問わず一律）。最初にこの問題が見つかったのは`1 2 [+] 3 4`——`+`が右の3,4を
// 貪欲に消費してAtom(7)に確定した後も、getCategoryの実装次第では消費済みのはずの
// apply連鎖がLambdaのままapply_reverseの対象になってしまい、左の2を誤ってreverse apply
// しようとして「Lambdaではない値を関数として適用しようとしました」というエラーになって
// いた（Phase2の貪欲消費とPhase3のapply_reverse除外を分離することで解消）。
check(
	"1 2 [+] 3 4 → [1, 2, 7]（[+]が3,4を貪欲に消費してAtom化、2はapply_reverseされず素通り）",
	run("1 2 [+] 3 4"),
	[1, 2, 7]
);
checkTrue(
	"5 [+] → 例外にならず穏やかに未解決（ポイントフリーはapply_reverse対象外、5をどちらの被演算子とみなすか曖昧なため）",
	(() => {
		try {
			run("5 [+]");
			return true; // 例外を投げずに何らかの値（__等）へ収束すればOK
		} catch (e) {
			return false;
		}
	})()
);

// ポイントフリー記述の前置/後置版（function_guide.md「前置演算子は`[<op>_]` 後置演算子は
// `[_<op>]`」）。`_`（hole）は既にresolveDensityで普通の前置/後置演算ノードのoperandとして
// 構造化されるため、operandが直接holeならその演算子ノードをpartial（Lambda）とマークする
// だけで済んだ——中置のような複雑な部分適用組み立ては不要。
check(
	"[!_] 2 < 3 → __（2<3全体を1引数として受け取り否定、真の値の否定はUnit）",
	run("[!_] 2 < 3"),
	"__"
);
// `!__`の返値はId射（categorical_truth.md §6）。`1`のような具体値を返すとBoolean型を
// 暗黙に再導入することになるため、「Unitでない何か（引数をそのまま返す恒等射）」である
// ことだけを確認する。
checkTrue("[!_] 5 < 3 → Id射（5<3が偽=Unitなので、その否定は真）", !isUnit(run("[!_] 5 < 3")));
// Id射は恒等射なので、呼べば引数を素通しする（`!__`はPass2でLambdaに分類されるため、
// スペースが concat ではなく apply に解決される）。
check("(!__) 42 → 42（Id射への適用）", run("(!__) 42"), 42);
check("!__ __ → __（Id射にUnitを渡すと完全性公理）", run("!__ __"), "__");
check("[_!] 5 → 120（後置演算子のポイントフリー版、階乗関数）", run("[_!] 5"), 120);
checkTrue(
	"[!_] 単体 → クロージャのまま（値として評価しても即座に演算しようとしない）",
	(() => {
		const v = run("[!_]");
		return !!(v && v.__lambda__);
	})()
);
check("通常の!5<3は引き続き回帰なし", run("!5 < 3"), "__");
check("通常の5!は引き続き回帰なし", run("5!"), 120);

// 末尾カンマによる写像糖衣構文（function_guide.md「単項式の後ろに`,`を付けたポイント
// フリー記述は、そのすべてに適用される」、list_cheat_sheet.md「写像関数/選択写像」）。
// 末尾の裸`,`（右にオペランドが無いため通常のproduct縮約が素通りしていた）を拾って
// pointfreeMapフラグを立て、Phase2の貪欲消費で複数の位置引数（または後置~で展開された
// List）を集めてから、各要素へ演算を適用しUnitを除去する。比較演算子はUnit除去だけで
// 「選択」（真だった要素だけが残る）になる。
check("[* 2,] [1 2 3]~ → [2,4,6]（写像、後置~で展開されたListへ適用）", run("[* 2,] [1 2 3]~"), [2, 4, 6]);
check("[* 2,] 1 2 3 4 5 → [2,4,6,8,10]（写像、複数の位置引数へ適用）", run("[* 2,] 1 2 3 4 5"), [2, 4, 6, 8, 10]);
check(
	"[< 3,] [1 2 3]~ → [1,2]（選択写像、list_cheat_sheet.md通り。ポイントフリーはList側の" +
		"fold/map/filterが前提のため、単位元の見方も算術側(0/1)ではなくList側に移り、真なら" +
		"常に要素そのもの(a)を残す——evalCompareの§4規則(左辺が0/1なら右辺)はここでは適用しない）",
	run("[< 3,] [1 2 3]~"),
	[1, 2]
);
check(
	"通常の中置比較 1 < 3 → 3（pointfree文脈の外では引き続きevalCompareの§4規則のまま、回帰なし）",
	run("1 < 3"),
	3
);

// coproduct_resolver.md §5.2-2（List同士、後置~無しでの並置は「独立したAtom（2つの参照の
// リスト）として保たれる」）。以前はcoproductReduceがnullを返して「そのまま未縮約で放置」
// する実装になっており、この2項だけで行全体が構成される場合にitems.length!==1のまま
// unresolvedへ落ち、評価側で静かにUnitへ収束していた。list_model.md §2.2が明言する
// 等価性「[1 2] [3 4] = 1 2 , 3 4」通り、product（カンマ）と同じノードとして扱うよう修正。
check(
	"[1 2 3] [1 2 3] → [[1,2,3],[1,2,3]]（後置~無しのList並置は2次元配列、以前はUnitに収束していた）",
	run("[1 2 3] [1 2 3]"),
	[
		[1, 2, 3],
		[1, 2, 3],
	]
);
check(
	"[1 2] [3 4] は 1 2 , 3 4 と完全に等価（list_model.md §2.2の明言通り）",
	run("[1 2] [3 4]"),
	[
		[1, 2],
		[3, 4],
	]
);
check("[1 2]~ [3 4]~ → [1,2,3,4]（双方~のconcatは引き続き回帰なし）", run("[1 2]~ [3 4]~"), [1, 2, 3, 4]);

// list_model.md §2.5「rest記法の位置一般化」：`~name`はブラケット内のどの位置にも置ける。
// `~`より前の非restエントリは先頭から、`~`より後の非restエントリは末尾から順に対応する。
// 専用の「リスト反転」演算子を新設せずとも、末尾からの分割代入（pop）だけで末尾から辿る
// 計算を表現できる、という設計（`><`のリスト反転演算子は`operator_table.js`から撤去した）。
check(
	"[~head tail] → head=[1,2,3,4]・tail=5（末尾からの分割代入、pop）",
	run("g : [~head tail] ? head tail\ng [1 2 3 4 5]"),
	[1, 2, 3, 4, 5]
);
check(
	"[first ~mid last] → first=1・mid=[2,3,4]・last=5（両端からの分割代入）",
	run("h : [first ~mid last] ? first mid last\nh [1 2 3 4 5]"),
	[1, 2, 3, 4, 5]
);
check(
	"[x ~xs]（従来通り先頭から）は引き続き回帰なし",
	run("f : [x ~xs] ? x xs\nf [1 2 3]"),
	[1, 2, 3]
);
check(
	"末尾からの再帰的な畳み込み（sum_rev）→ 15。反転演算子無しでリストを末尾から辿れることの実証",
	run("sum_rev : [~head tail] ? head & (sum_rev head) + tail | tail\nsum_rev [1 2 3 4 5]"),
	15
);

// `!=`（tier12）が一度もevalCompareへ到達せず「未対応の演算」になっていたバグを修正
// （8/6発見）。node.nameが"not_equal"で、tier8の`!==`と衝突するためCOMPARE_OPSに
// キーを持たせられず、COMPARE_OPS[node.name]だけの判定漏れていた。node.op==="!="の
// 場合だけ個別に通すよう修正——`!==`自体はまだ未対応のまま（別の構造比較の実装が必要）。
// 真の場合の返値選択はcomparison.md §2.1の規則（左辺が算術単位元0/1なら右辺、
// それ以外は左辺）。§1が`!=`を対象の比較演算子として列挙しており、§2.1の適用外と
// 明示されているのは構造比較の`==`/`!==`だけ。
check("1 != 2 → 2（左辺が乗算単位元1なので右辺、§2.1）", run("1 != 2"), 2);
check("0 != 5 → 5（左辺が加法単位元0なので右辺、§2.1）", run("0 != 5"), 5);
check("2 != 5 → 2（左辺が単位元でないので左辺、§2.1）", run("2 != 5"), 2);
check("1 != 1 → __（等しいので偽）", run("1 != 1"), "__");
check("__ != 5 → __（左辺Unitは吸収元）", run("__ != 5"), "__");
check("5 != __ → 5（右辺Unitは単位元、素通し）", run("5 != __"), 5);

// ---- Layer 1 識別子カテゴリ = 右辺式のカテゴリ（type_system.md §2） ----
// pass1.jsは以前「その行にトップレベルの `?` があるか」だけでLambda/Atomを決めていた。
// §2の表は `[+ 2]`（部分操作のブラケット）・§3.1のcompose も Lambda と定めているため、
// 名前に束縛した途端にそれらがAtom扱いになり、適用が concat に解決されていた。
check("inc : [+ 1] / inc 3 → 4（部分操作のブラケットはLambda）", run("inc : [+ 1]\ninc 3"), 4);
check("add : [+] / add 1 2 → 3（裸のポイントフリーも名前経由で貪欲消費）", run("add : [+]\nadd 1 2"), 3);
check("h : f g / h 3 → 8（composeはLambda、左→右パイプライン順）", run("f : x ? x + 1\ng : x ? x * 2\nh : f g\nh 3"), 8);
check("k : f / k 3 → 4（Lambdaのエイリアスも Lambda）", run("f : x ? x + 1\nk : f\nk 3"), 4);
check("g : f 1 / g 2 3 → 6（アリティ不足の部分適用、残りアリティも引き継ぐ）", run("f : x y z ? x + y + z\ng : f 1\ng 2 3"), 6);
check("d : 1 2 3 → concatのままAtom（Lambdaに誤判定しない）", run("d : 1 2 3\nd"), [1, 2, 3]);
// 前方参照: 後ろの行で定義される `u` のカテゴリ（Lambda）も、参照側の縮約時点で
// 解決される（Pass1aの「前方参照を含む全識別子の構造型が確定する」性質を保つ）。
// 遅延解決なので、行順ではなく「最初に参照されたとき」に決まる。
check("前方参照: 後の行で定義されるポイントフリーも apply に解決される", run("r : x ? u x\nu : [+ 1]\nr 3"), 4);

// ---- 前置export記号つきの非ラムダ定義（type_system.md §6.1） ----
check("#pi : 3 → pi は 3（exportしても束縛される）", run("#pi : 3\npi"), 3);
check("##pi / ###pi も同じ", run("###pi : 3\npi"), 3);
check("#add : [+] / add 1 2 → 3（§6.1のimport成功時の形）", run("#add : [+]\nadd 1 2"), 3);

// ---- 空リスト（unit.md「__ = []」） ----
check("[] は空リスト（Unitと同型）", run("[]"), "__");
check("|[]| → 0（空でもリストとしての長さは取れる）", run("|[]|"), 0);
check("none : [] と書ける（guide/example.sn 37行目）", run("none : []\nnone"), "__");

// ---- 三項連鎖比較（comparison.md §4） ----
check("5 < 7 < 10 → 7（中央の項。左結合なら5になってしまう）", run("5 < 7 < 10"), 7);
check("x:7 / 5 < x < 10 → 7", run("x : 7\n5 < x < 10"), 7);
check("5 < 3 < 10 → __（1つでも偽なら即Unit）", run("5 < 3 < 10"), "__");
check("5 < 7 < 6 → __", run("5 < 7 < 6"), "__");
checkThrows("1 < 2 > 0 → 構文エラー（§4.1: 同一演算子の連鎖のみ）", () => run("1 < 2 > 0"));
checkThrows("4項の連鎖は未定義（§4は三項まで）", () => run("1 < 2 < 3 < 4"));
check("x < 3 & y > 4 は連鎖と誤認しない（間に低優先の & がある）", run("x : 2\ny : 5\nx < 3 & y > 4"), 5);

// ---- `!__` = Id射（categorical_truth.md §6 / guide/operator_table.md 141行目） ----
checkTrue("!__ != __（__ と !__ は等しくない）", !isUnit(run("!__ != __")));
checkTrue("!__ !== __（構造比較しても等しくない）", !isUnit(run("!__ !== __")));
check("__ 5 == !__ 5（余積の左単位元とId射、双方5）", run("__ 5 == !__ 5"), 5);
check("5 __ == 5 !__（余積の右単位元とId射、双方5）", run("5 __ == 5 !__"), 5);
check("__ 1 2 → [1 2]（2項以上は従来通りList、§6.1の輸入失敗例）", run("__ 1 2"), [1, 2]);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
