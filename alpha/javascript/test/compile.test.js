/**
 * compile.js（Pass 1〜3 の単一ドライバ）の動作確認。
 *
 * これまで pass3 は自身のテストからしか呼ばれておらず、実行経路に載っていなかった
 * （型を出しても消費者が存在しない状態）。ここでは compile() が全ノードへ
 * Layer 2 型を注釈できていること、および type_system.md §3.2 の族別規則・
 * 数値の昇格格子が識別子経由でも効くことを確認する。
 *
 * 実行: node test/compile.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammar = fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8");
const parser = peggy.generate(grammar);

const run = (source) => compile(source, { parse: parser.parse });

let passed = 0;
let total = 0;

function check(note, got, want) {
	total++;
	if (got === want) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got: ${JSON.stringify(got)}, want: ${JSON.stringify(want)}`);
	}
}

// 最終行のトップレベルノードの atomType を取る
function lastType(source) {
	const { nodes } = run(source);
	return nodes[nodes.length - 1].atomType;
}

// ---- 全ノードへの注釈（§5 Pass 3 の出力＝「完全型付きAST」） ----
{
	const { nodes } = run("5 + 2");
	const add = nodes[0];
	check("トップレベルノードに atomType が載る", add.atomType, "Address");
	check("左の子にも載る", add.left.atomType, "Address");
	check("右の子にも載る", add.right.atomType, "Address");
}

// ---- 数値の昇格格子（§3.2） ----
check("Address ⊕ Address → Address", lastType("5 + 2"), "Address");
check("Address ⊕ Float → Float（昇格、降格しない）", lastType("5 + 1.5"), "Float");
check("Float ⊕ Address → Float", lastType("1.5 + 5"), "Float");
check("Float ⊕ Float → Float", lastType("1.5 + 2.5"), "Float");
// 識別子を経由しても昇格が効くこと（pass1a が読んだ atomType が伝播する）
check("識別子経由でも昇格する（a:5 / b:1.5 / a + b → Float）", lastType("a : 5\nb : 1.5\na + b"), "Float");

// ---- 算術族の型不一致（§3.2、両方向とも __） ----
check("Address ⊕ String → Unit", lastType("1 + `abc`"), "Unit");
check("String ⊕ Address → Unit", lastType("`abc` + 1"), "Unit");

// ---- List 左辺の算術（§3.2 算術族テーブル） ----
check("List * Address → List（repeat）", lastType("[1 2] * 2"), "List");
check("List ^ Address → List（lift）", lastType("[1 2] ^ 2"), "List");
check("List / Address → List（split）", lastType("[1 2 3 4] / 2"), "List");
check("List + List → Unit（+ - % はList左辺で型エラー）", lastType("[1 2] + [3 4]"), "Unit");

// ---- 余積族（§3.2） ----
check("String 左辺の余積 → String（テキスト連結）", lastType("`ab` 1"), "String");
check("String 以外の余積 → List", lastType("1 2"), "List");

// ---- 論理・圏論族（§3.2、`&` だけ右辺の型） ----
check("`&` は右辺の型を返す（§4: (L -> R) -> (R | __)）", lastType("1 & `abc`"), "String");
check("`|` は左辺の型を返す", lastType("1 | `abc`"), "Address");

// ---- define / lambda / Dict の判定 ----
check("define の型は束縛される値の型", lastType("x : 5"), "Address");
check("Lambda は Layer 2 型を持たない（Layer 1 のカテゴリなので null）", lastType("f : x ? x + 1"), null);
check("改行区切りの辞書リテラル → Dict", lastType("d :\n\tfoo : 1\n\tbar : 2"), "Dict");
check("単一エントリの辞書も Dict", lastType("d : [foo : 1]"), "Dict");
check(
	"match_case（左辺が識別子でない define 行）は Dict ではない",
	lastType("f : x ?\n\tx < 0 : `neg`\n\t`pos`"),
	null // Lambda なので Layer 2 型なし
);

// ---- Pass 1b がパイプラインに載っていること ----
{
	// `@ref` を持つジェネリック関数と、その呼び出しサイト2つ。
	const { specializations } = run("apply5 : ref ? @ref 5\nadd : x y ? x + y\napply5 $add\napply5 3");
	total++;
	const entry = specializations.get("<apply5>");
	const ok = !!entry && entry.has("<ref>") && entry.get("<ref>").callsiteCount === 2;
	if (ok) {
		console.log("OK   Pass 1b が呼ばれ、ジェネリック仮引数の呼び出しサイトが収集される");
		passed++;
	} else {
		console.log("FAIL Pass 1b が呼ばれ、ジェネリック仮引数の呼び出しサイトが収集される");
		console.log(`     specializations: ${JSON.stringify([...specializations].map(([k, v]) => [k, [...v]]))}`);
	}
}

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
