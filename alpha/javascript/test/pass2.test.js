/**
 * Pass2（coproduct_resolver.md）の動作確認テスト。
 * 実行: npm test （test/run.js と合わせて実行される想定なら node test/pass2.test.js を追加）
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "../lexer.js";
import { reduceAll } from "../pass2.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const grammarPath = path.join(__dirname, "..", "sign.pegjs");
const grammar = fs.readFileSync(grammarPath, "utf8");
const parser = peggy.generate(grammar);

function show(node) {
	if (node.type === "atom") return `${node.kind}(${node.value})`;
	if (node.type === "operation") {
		if (node.position === "prefix" || node.position === "postfix") return `${node.name}(${show(node.operand)})`;
		return `${node.name}[${show(node.left)}, ${show(node.right)}]`;
	}
	if (node.type === "block") return `${node.kind}{${node.lines.map(show).join("; ")}}`;
	if (node.type === "unresolved") return `UNRESOLVED[${node.items.map((x) => (typeof x === "string" ? x : show(x))).join(", ")}]`;
	return JSON.stringify(node);
}

const cases = [
	{ input: "1 + 2 * 3", want: "add[number(1), mul[number(2), number(3)]]", note: "算術優先順位（*が+より先に縮約）" },
	{ input: "f : x ? x + 1", want: "define[identifier(<f>), lambda[identifier(<x>), add[identifier(<x>), number(1)]]]", note: "define/lambdaのネスト" },
	{ input: "@x", want: "input(identifier(<x>))", note: "前置密着演算子の解決" },
	{ input: "x@", want: "import(identifier(<x>))", note: "後置密着演算子の解決" },
	{ input: "x ' y", want: "get_prop[identifier(<x>), identifier(<y>)]", note: "GetLeft" },
	{
		input: "$[array ' 0] # 3",
		want: "output[address(paren{get_prop[identifier(<array>), number(0)]}), number(3)]",
		note: "$は常にAtom(Address)、#(output)の左辺として結合",
	},
	{ input: "print x", want: "apply[identifier(<print>), identifier(<x>)]", note: "組み込みLambda(<print>)によるapply" },
	{ input: "x < y", want: "less[identifier(<x>), identifier(<y>)]", note: "比較演算子" },
	{ input: "x == y", want: "equal[identifier(<x>), identifier(<y>)]", note: "構造比較演算子" },
];

let passed = 0;
for (const c of cases) {
	const pre = preprocess(c.input);
	const flat = parser.parse(pre)[0];
	const tree = reduceAll(flat);
	const got = show(tree);
	if (got === c.want) {
		console.log(`OK   ${c.input}  (${c.note})`);
		passed++;
	} else {
		console.log(`FAIL ${c.input}  (${c.note})`);
		console.log(`     got:  ${got}`);
		console.log(`     want: ${c.want}`);
	}
}

console.log(`\n${passed}/${cases.length} passed`);
process.exit(passed === cases.length ? 0 : 1);
