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
		want: "Struct",
		note: "改行区切りのkey:valの並び → Struct（list_model.md §5.3 / pattern_guide.mdのdict例）",
	},
	{
		source: "[foo : 1]",
		pick: (nodes) => nodes[0],
		want: "Struct",
		note: "単一のkey:valペアもStructとして扱う",
	},
	{
		source: "f : y ?\x02x : 1\n2\x03",
		pick: (nodes) => nodes[0].right.right,
		want: "Address",
		note: "関数本体（複数行だが全行がdefineではない: define→numberの並び）は構造体化せず、最後の文(2)の型に委譲する",
	},
	// ---- §3.2 族別テーブル（「左辺優先」＝結果型ではなく規則の選択） ----
	{
		source: "`ab` 1",
		pick: (nodes) => nodes[0],
		want: "String",
		note: "余積族: 左辺がStringならテキスト連結でString（interpreter.jsの`ab` 1 → \"ab1\"と一致）",
	},
	{
		source: "1 2",
		pick: (nodes) => nodes[0],
		want: "List",
		note: "余積族: 左辺がString以外ならList構築（Stringが勝つのは左辺のときだけ）",
	},
	{
		source: "1 2.5",
		pick: (nodes) => nodes[0],
		want: "List",
		note: "§2 要素型のjoin: Address ⊕ Float は Float へ昇格するので List のまま（エラーにならない）",
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

// ---- §2「Listは同一型」: join が存在しない要素の混在はコンパイルエラー ----
// 混在させたい場合はカンマ区切りの Struct（tuple）にする、という設計（原理3）。
let extra = 0;
let extraPassed = 0;
function checkThrows(note, source) {
	extra++;
	try {
		const { nodes, env } = resolveLines(source);
		const got = inferAtomType(nodes[0], env);
		console.log(`FAIL ${note}`);
		console.log(`     例外が投げられず ${JSON.stringify(got)} が返った`);
	} catch (e) {
		console.log(`OK   ${note}`);
		extraPassed++;
	}
}
function checkNoThrow(note, source, want) {
	extra++;
	const { nodes, env } = resolveLines(source);
	const got = inferAtomType(nodes[0], env);
	if (got === want) {
		console.log(`OK   ${note}`);
		extraPassed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got: ${JSON.stringify(got)}, want: ${JSON.stringify(want)}`);
	}
}

// Stringは余積の吸収元（あらゆる値がテキスト表現を持つのでjoinが常に存在する）。
// 左右どちらに来てもテキスト連結になり、要素型のjoin判定には入らない。
checkNoThrow("`ab` 1 → String（String左辺）", "`ab` 1", "String");
checkNoThrow("1 `ab` → String（String右辺でも同じ。引数の順序で挙動を変えない）", "1 `ab`", "String");
checkNoThrow("[1 `abc`] → String（ブラケットでも同じ）", "[1 `abc`]", "String");
// joinが本当に存在しない組み合わせ（数値とStruct/List）だけがコンパイルエラーになる。
checkThrows("1 [x : 1] → コンパイルエラー（Address と Struct に join が無い）", "1 [x : 1]");
checkNoThrow("1 , `abc` → Struct（カンマなら混在は正当）", "1 , `abc`", "Struct");

// 範囲族（type_system.md §4: `~` は `(Scalar -> Scalar) -> Iterator -> List`）。
// 結果は端点の型ではなく「列」なので、左辺優先ルール（§3.2）の対象外である
// ——以前は `1 ~ 5` の型が値（[1,2,3,4,5]）と食い違って Address になっていた。
checkNoThrow("1 ~ 5 → List（結果は列であり端点の型ではない）", "1 ~ 5", "List");
checkNoThrow("\\a ~ \\e → String（文字の範囲は文字の並び、String ≅ List(0u)）", "\\a ~ \\e", "String");
checkNoThrow("2 ~+ 2 ~ 10 → List（3項形式。端点は内側の左辺と外側の右辺）", "2 ~+ 2 ~ 10", "List");
checkNoThrow("1 ~+ 2 → Iterator（終端の無い2項形式はPull型ストリームそのもの）", "1 ~+ 2", "Iterator");
// 端点になれるのは「点」だけ。List / Struct は型で分かるので静的に弾く（原理4）。
checkThrows("[1 2] ~ [3 4] → コンパイルエラー（List は範囲の端点になれない）", "[1 2] ~ [3 4]");
checkThrows("[x : 1] ~ [y : 2] → コンパイルエラー（Struct も同様）", "[x : 1] ~ [y : 2]");
checkThrows("1 ~+ 2 ~ [3 4] → コンパイルエラー（3項形式の終端も端点）", "1 ~+ 2 ~ [3 4]");

console.log(`\n${passed + extraPassed}/${cases.length + extra} passed`);
process.exit(passed === cases.length && extraPassed === extra ? 0 : 1);
