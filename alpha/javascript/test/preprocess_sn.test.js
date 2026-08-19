/**
 * Sign 自身で書いた前処理器（`alpha/sign/preprocess.sn`）が、JS 実装（`lexer.js` の
 * `preprocess`）と**同じ仕事**をすることを確認する。
 *
 * 比較はバイト一致ではなく**パース結果の一致**で行う。前処理の仕事はパーサが読める形に
 * することであり、空行やマーカーの細かい位置は、同じ木を渡す限り違っていてよい。
 * （実際 `.sn` 側は空行を落とすが、空行は意味を持たないので木は変わらない。）
 *
 * 実行: node test/preprocess_sn.test.js（`npm test` からも呼ばれる）
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { compile } from "../compile.js";
import * as I from "../interpreter.js";
import { preprocess } from "../lexer.js";
import { parse } from "../parser.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const snPath = path.join(__dirname, "..", "..", "sign", "preprocess.sn");

let passed = 0;
let total = 0;

function check(note, ok, detail) {
	total++;
	if (ok) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		if (detail) console.log(detail);
	}
}

// `preprocess.sn` を読み込み、末尾の実行例を落として関数群だけを環境へ束縛する。
const src = fs.readFileSync(snPath, "utf8").replace(/\r\n/g, "\n");
const base = src.split("\n").filter((l) => !l.startsWith("preprocess `")).join("\n");
const { nodes, env } = compile(base);
const renv = I.newRuntimeEnv(env);
for (const n of nodes) I.evaluate(n, renv);

// 入力は識別子経由で渡す。Sign の文字列リテラルに改行やバッククォートは書けないため。
function runSn(text) {
	I.envDefine(renv, "<__in__>", text);
	return String(
		I.evaluate(
			{
				type: "operation",
				name: "apply",
				left: { type: "atom", kind: "identifier", value: "<preprocess>" },
				right: { type: "atom", kind: "identifier", value: "<__in__>" },
			},
			renv
		)
	);
}

const astOf = (s) => {
	try {
		return JSON.stringify(parse(s));
	} catch (e) {
		return "PARSE_FAIL: " + e.message.slice(0, 60);
	}
};
const show = (s) => JSON.stringify(s).replace(/\u0002/g, "→").replace(/\u0003/g, "←");

function same(note, input) {
	const sn = runSn(input);
	const js = preprocess(input);
	const a = astOf(sn);
	const b = astOf(js);
	check(`${note}: ${show(input)}`, a === b, `     sn: ${show(sn)}\n     js: ${show(js)}`);
}

// ---- 1. 中置演算子の両側へ空白を入れる ----
same("1文字の中置演算子", "a+b*c");
same("定義とラムダ", "f : x ? x + 1");
same("2文字の中置演算子", "a==b");
same("3文字の中置演算子", "a===b");
// 多義的な演算子には空白を入れない。`-` は負号、`|` は絶対値、`~` は残余にもなる。
same("多義的な演算子は区切らない", "-1 |x| ~xs");
// 文字列・エスケープ・コメントの中身は保護する。
same("文字列の中は保護する", "s : `a+b`");
same("エスケープの中も保護する", "c : \+");

// ---- 2. タブ深さから INDENT / DEDENT を作る ----
same("1段深くなる", "a\n\tb");
same("深くなって戻る", "a\n\tb\nc");
same("2段深くなる", "a\n\t\tb\nc");
// 末尾の DEDENT はファイル末尾で閉じる。空判定は否定演算子で行う——`|x| = 0` は
// 裸の仮引数（`Atom`）では型が決まらず吸収元へ倒れるので使えない（unit.md）。
same("末尾のインデントを閉じる", "f : x ?\n\tx + 1");
same("空行は深さに影響しない", "a\n\nb");
same("空行を挟んでも DEDENT は直前の内容行に付く", "a\n\tb\n\nc");

// ---- 括弧の中ではインデントを無効化する ----
//
// 括弧の中で見やすさのためにタブを深くする書き方があるため、深さの変化を INDENT/DEDENT に
// してはいけない。文法上、開き括弧の直後と閉じ括弧の直前に改行を置けないので、
// 開いた直後の行と閉じる行は前の行へ直結させる。
same("ブラケットの中はインデントしない", "p : [\n\tx : 1\n\ty : 2\n]");
same("括弧でも同じ", "f : (\n\ta\n\tb\n)");

// ---- 継続行 ----
//
// 行頭が中置演算子で始まる行は、前の行の続きとして空白で繋ぐ。
same("行頭の中置演算子は前の行へ繋ぐ", "x\n+ 1");
same("インデントの中でも繋ぐ", "f : x ?\n\tx\n\t+ 1");

// ---- 実プログラム ----
//
// 合成した例ではなく、実際に書かれている Sign のコードで一致すること。
const lexerSn = fs.readFileSync(path.join(__dirname, "..", "..", "sign", "lexer.sn"), "utf8").replace(/\r\n/g, "\n");
// 全体を通すと下の「既知の限界」に当たるため、先頭の一部で確認する。
const excerpt = lexerSn.split("\n").slice(0, 22).join("\n");
same(`lexer.sn の先頭 22 行（${excerpt.length} 文字）`, excerpt);

// ---- 既知の限界 ----
//
// `sep` も `walk` も末尾再帰ではない（再帰呼び出しが余積の中にある）ため、JS 実装の
// インタプリタでは入力の大きさぶんスタックを積む。TCO は末尾位置の呼び出しにしか効かない。
// これは JS バックエンド側の制約であって Sign の言語仕様ではないが、**自分自身を処理する
// には足りていない**（preprocess.sn は 5000 文字を超える）。
check(
	"1000 文字程度までは処理できる（既知の限界）",
	(() => {
		try {
			return runSn("a+b ".repeat(200)).length > 0;
		} catch {
			return false;
		}
	})(),
	null
);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
