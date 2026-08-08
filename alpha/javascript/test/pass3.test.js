/**
 * Pass3（型伝播、type_system.md §2〜§3.2）の動作確認。
 * Pass2が返す二分木ASTに対し、Layer 2 Atom内部型（Address/Float/String/List/Unit等）を
 * 左辺優先ルール（typeof(L op R) = typeof(L)）で推論できることを確認する。
 *
 * 実行: node test/pass3.test.js
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "../lexer.js";
import { reduceAll } from "../pass2.js";
import { buildEnv } from "../pass1.js";
import { inferAtomType } from "../pass3.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peggy.generate(grammar);

function resolveLines(source) {
	const pre = preprocess(source);
	const lines = parser.parse(pre);
	const env = buildEnv(lines);
	return { nodes: lines.map((line) => reduceAll(line, env)), env };
}

const cases = [
	{
		source: "5 + x",
		pick: (nodes) => nodes[0],
		want: "Address",
		note: "5 + x → Address（左辺の数値リテラル、小数点なし＝Address、右辺は無関係）",
	},
	{
		source: "3.14 + x",
		pick: (nodes) => nodes[0],
		want: "Float",
		note: "3.14 + x → Float（左辺のリテラルに小数点あり）",
	},
	{
		source: "`123` + 0",
		pick: (nodes) => nodes[0],
		want: "Unit",
		note: "`123` + 0 → Unit（§3.2 NOTE: String左辺への算術演算子は型エラーで__に収束）",
	},
	{
		source: "x : 5\nx + 3",
		pick: (nodes) => nodes[1],
		want: "Address",
		note: "x : 5 という定義から x の atomType(Address) が Pass1a で静的に解決され、x + 3 に伝播する",
	},
	{
		source: "[1 2] * 2",
		pick: (nodes) => nodes[0],
		want: "List",
		note: "[1 2] * 2 → List（左辺のブロックをListとして扱い、左辺優先ルールで結果もList）",
	},
	{
		source: "__",
		pick: (nodes) => nodes[0],
		want: "Unit",
		note: "__ 単体 → Unit",
	},
	{
		source: "[1, 2, 3]",
		pick: (nodes) => nodes[0],
		want: "Struct",
		note: "[1, 2, 3] → Struct（カンマ＝直積、type_system.md §2の`1, 2, 3`の例）",
	},
	{
		source: "[\n\tfoo : 1\n\tbar : 2\n]",
		pick: (nodes) => nodes[0],
		want: "Dict",
		note: "改行区切りのkey:valの並び → Dict（list_model.md §5.3 / pattern_guide.mdのdict例）",
	},
	{
		source: "[foo : 1]",
		pick: (nodes) => nodes[0],
		want: "Dict",
		note: "単一のkey:valペアもDictとして扱う",
	},
	{
		source: "f : y ?\x02x : 1\n2\x03",
		pick: (nodes) => nodes[0].right.right,
		want: "Address",
		note: "関数本体（複数行だが全行がdefineではない: define→numberの並び）はDict化せず、最後の文(2)の型に委譲する",
	},
	// ---- §3.2 族別テーブル（「左辺優先」＝結果型ではなく規則の選択） ----
	{
		source: "`ab` 1",
		pick: (nodes) => nodes[0],
		want: "String",
		note: "余積族: 左辺がStringならテキスト連結でString（interpreter.jsの`ab` 1 → \"ab1\"と一致）",
	},
	{
		source: "1 `ab`",
		pick: (nodes) => nodes[0],
		want: "List",
		note: "余積族: 左辺がString以外ならList構築（Stringが勝つのは左辺のときだけ）",
	},
	{
		source: "1 & `abc`",
		pick: (nodes) => nodes[0],
		want: "String",
		note: "論理・圏論族: `&`は§4のシグネチャ`(L -> R) -> (R | __)`通り右辺の型を返す（左辺優先の反例）",
	},
	{
		source: "1 | `abc`",
		pick: (nodes) => nodes[0],
		want: "Address",
		note: "論理・圏論族: `|`は左辺が非Unitなら左辺を返すため左辺の型",
	},
];

let passed = 0;
for (const c of cases) {
	const { nodes, env } = resolveLines(c.source);
	const target = c.pick(nodes);
	const got = inferAtomType(target, env);
	if (got === c.want) {
		console.log(`OK   ${c.note}`);
		passed++;
	} else {
		console.log(`FAIL ${c.note}`);
		console.log(`     source: ${JSON.stringify(c.source)}`);
		console.log(`     got: ${JSON.stringify(got)}, want: ${JSON.stringify(c.want)}`);
	}
}

console.log(`\n${passed}/${cases.length} passed`);
process.exit(passed === cases.length ? 0 : 1);
