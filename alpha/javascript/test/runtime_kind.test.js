/**
 * 実行時の種類（`runtime_kind.js`、RTTI の裁定 2026-09-27）。
 *
 * **いま値の JS の姿から読めるだけ**を答えることを見る。`Num`（`Int` `Address` `Float`）と `Chr1`（`Char` と長さ1の
 * `String`）はまだ割れていない2組で、箱が入った日にこの検査の答えが変わる——変わるのが正しいので、そのとき
 * 書き換える。答えは直に書く（種類の名前は pass3 の型の名前と同じ）。
 *
 * 見るのは解釈器が返した値そのもので、観測の境界（`observe`）は通さない——種類は値の上に在る。
 *
 * 実行: node test/runtime_kind.test.js（`npm test` からも呼ばれる）
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import * as I from "../interpreter.js";
import { UNIT, isUnit, IDENTITY, isIdentityMorphism, kindOf } from "../runtime_kind.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const parser = peggy.generate(fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8"));

let passed = 0;
let total = 0;

function check(note, got, want) {
	total++;
	const ok = got === want;
	if (ok) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got:  ${String(got)}`);
		console.log(`     want: ${String(want)}`);
	}
}

function value(source) {
	const { nodes } = compile(source, { parse: parser.parse });
	const env = I.newRuntimeEnv(null);
	let r = I.UNIT;
	for (const n of nodes) r = I.evaluate(n, env);
	return r;
}
const kind = (source) => kindOf(value(source));
const BS = "\\";

// ---- 置き場は1つ（interpreter.js は出し直すだけ） ----
check("interpreter.js の UNIT は runtime_kind.js のもの", I.UNIT === UNIT, true);
check("interpreter.js の isUnit は runtime_kind.js のもの", I.isUnit === isUnit, true);
check("`!__` が返すのは runtime_kind.js の恒等射", value("!__") === IDENTITY && isIdentityMorphism(value("!__")), true);

// ---- 域の無い `__` ----
check("`__` は Unit", kind("__"), "Unit");
check("文字の niche（`0u0000`）も Unit", kind("0u0000"), "Unit");

// ---- まだ割れていない2組 ----
check("十進の整数は Num", kind("5"), "Num");
check("番地も Num（箱が入るまで整数と同じ値）", kind("0x10"), "Num");
check("実数も Num（箱が入るまで整数と同じ値）", kind("1.5"), "Num");
check("2^53 を越える整数（BigInt）も Num", kind("9007199254740993"), "Num");
check("文字は Chr1", kind(BS + "a"), "Chr1");
check("長さ1の文字列も Chr1（箱が入るまで文字と同じ値）", kind("s : `a`\ns"), "Chr1");
check("符号位置1つならサロゲート対でも Chr1", kind("0u1D11E"), "Chr1");
check("文字列から引いた1文字も Chr1", kind("`ab` ' 0"), "Chr1");

// ---- 域を答える（その域の `__` かどうかは `isUnit`） ----
check("2文字の文字列は String", kind("s : `ab`\ns"), "String");
check("切り出した文字列は String", kind("`abc` ' (1 ~ 2)"), "String");
check("回数 0 の繰り返しは String の __ ——域は String", kind("`ab` * 0"), "String");
check("回数 0 の繰り返しは __ でもある", isUnit(value("`ab` * 0")), true);
check("リストは List", kind("[1 2]"), "List");
check("空のリストは List の __ ——域は List", kind("[]"), "List");

// ---- 値の形のタグ ----
check("名前付きスロットは Struct", kind("[\na : 1\nb : 2\n]"), "Struct");
check("閉包は Lambda", kind("f : x ? x + 1\nf"), "Lambda");
check("点なしは Lambda", kind("[+ 1]"), "Lambda");
check("合成は Lambda", kind("[+ 1] [* 2]"), "Lambda");
check("恒等射 `!__` は Identity", kind("!__"), "Identity");
check("規則は Iterator", kind("[1 ~ 3]"), "Iterator");
check("撒いた並びも Iterator", kind("[1 2 3]~"), "Iterator");
check("`$` の参照セルは Address", kind("x : 1\n$x"), "Address");
check("組み込み関数（JS の関数）も Lambda", kindOf(() => 1), "Lambda");

// ---- Sign の値として出てこないもの ----
check("JS の null には答えない", kindOf(null), null);
check("JS の真偽値には答えない", kindOf(true), null);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
