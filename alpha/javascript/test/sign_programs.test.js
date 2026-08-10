/**
 * `alpha/sign/` に置いた「Sign 自身で書いたプログラム」の動作確認。
 *
 * 処理系の単体テストと違い、こちらは**まとまった量の実プログラム**が壊れていないかを見る。
 * 8-Queens（documents/ja-jp/guide/examples/n_queens.sn）と同じ役割で、
 * 個別機能のテストでは拾えない相互作用の回帰を検出することを狙っている。
 *
 * 実際、この2本を書く過程で pass2.js の余積解決のバグが1件見つかった
 * （`isListLike` が中身を見ずに括弧を全て List 扱いし、`` `x` (`y`) `` が
 * construct ではなく push へ落ちて String の連結が起きなかった）。
 *
 * 実行: node test/sign_programs.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import { evaluate, newRuntimeEnv, UNIT, isUnit } from "../interpreter.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammar = fs.readFileSync(path.join(__dirname, "..", "sign.pegjs"), "utf8");
const parser = peggy.generate(grammar);
const signDir = path.join(__dirname, "..", "..", "sign");

// .sn ファイルを読んで実行し、最後の行の評価結果を返す。
function runFile(name) {
	const source = fs.readFileSync(path.join(signDir, name), "utf8");
	const { nodes } = compile(source, { parse: parser.parse });
	const env = newRuntimeEnv(null);
	let result = UNIT;
	for (const node of nodes) result = evaluate(node, env);
	return result;
}

// ファイル本体（最終行の実行例）を差し替えて、別の入力で評価する。
function runWith(name, lastLine) {
	const source = fs.readFileSync(path.join(signDir, name), "utf8");
	const body = source.split("\n").filter((l) => l.trim() !== "");
	body[body.length - 1] = lastLine;
	const { nodes } = compile(body.join("\n"), { parse: parser.parse });
	const env = newRuntimeEnv(null);
	let result = UNIT;
	for (const node of nodes) result = evaluate(node, env);
	return result;
}

let passed = 0;
let total = 0;

function check(note, got, want) {
	total++;
	const ok = JSON.stringify(got) === JSON.stringify(want);
	if (ok) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got: ${JSON.stringify(got)}, want: ${JSON.stringify(want)}`);
	}
}

// ---- lexer.sn ----
// トークン列はカンマ（直積）で積むため、右結合の入れ子として返る。
check(
	"lexer.sn: `foo 123 + bar42` を5トークンへ分割する",
	runFile("lexer.sn"),
	["foo", ["123", ["+", ["bar", ["42", null]]]]]
);

check(
	"lexer.sn: 数字と識別子の境界を正しく切る（bar42 → bar , 42）",
	runWith("lexer.sn", "tokens `bar42`"),
	["bar", ["42", null]]
);

check("lexer.sn: 空文字列 → __", isUnit(runWith("lexer.sn", "tokens ``")), true);

check(
	"lexer.sn: 連続する空白を読み飛ばす",
	runWith("lexer.sn", "tokens `a   b`"),
	["a", ["b", null]]
);

// ---- parser.sn ----
// 優先順位（* が + より内側）と左結合を確認する。
check(
	"parser.sn: 1 + 2 * 3 → * が + より内側（優先順位）",
	runFile("parser.sn"),
	[["1", "+"], [["2", "*"], ["3"]]]
);

check(
	"parser.sn: 1 * 2 + 3 → (1*2)+3",
	runWith("parser.sn", "fst (expr [`1` , `*` , `2` , `+` , `3`])"),
	[[[["1", "*"], "2"], "+"], ["3"]]
);

check(
	"parser.sn: 1 - 2 - 3 → (1-2)-3（左結合）",
	runWith("parser.sn", "fst (expr [`1` , `-` , `2` , `-` , `3`])"),
	[[[["1", "-"], "2"], "-"], ["3"]]
);

check(
	"parser.sn: 1 + 2 * 3 - 4 → ((1+(2*3))-4)",
	runWith("parser.sn", "fst (expr [`1` , `+` , `2` , `*` , `3` , `-` , `4`])"),
	[[[["1", "+"], [["2", "*"], "3"]], "-"], ["4"]]
);

check("parser.sn: 単項（7 のみ）", runWith("parser.sn", "fst (expr [`7`])"), "7");

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
