/**
 * Pass 4 へ渡す形まで**実際に還元してみる**（デバッグ／監査用）。
 *
 *   node emit_backend.mjs <file.sn> [option.ms]
 *
 * `compiler_pipeline.md` §3 は Pass 1〜3 の責務を「ユーザー定義の型がどれだけ意味論的に
 * 豊かであっても、最終的には**このビット列を何バイト幅・符号あり/なしとして扱うか**という
 * 情報に還元してから Pass 4 に渡す」と定めている。還元できない場所が残っていれば、そこは
 * Pass 4 が命令を選べない場所である。
 *
 * このツールは還元を全ノードに対して走らせ、**通らなかった場所を数えて名指しする**。
 * 型が付いていること（`.ist` の未解決 0）と、命令が選べることは別の主張である
 * ——`Scalar` は型としては付いているが、GPR か FPU かも幅も決まっていない。
 *
 * `.ist` と同じく**メモリ上のみ**の観測手段である（compiler_pipeline.md §4）。
 */
import fs from "fs";
import { compile } from "./compile.js";
import { readOptionMs } from "./option_ms.js";
import { measure, passingOf } from "./layout.js";
import { widthsOf, reduceToMachineType } from "./target_info.js";

const file = process.argv[2];
const msFile = process.argv[3];
if (!file) {
	console.error("使い方: node emit_backend.mjs <file.sn> [option.ms]");
	process.exit(1);
}

const conf = readOptionMs(msFile ? fs.readFileSync(msFile, "utf8") : "");
const { nodes, env } = compile(fs.readFileSync(file, "utf8"), { layer: conf.layer, sourcePath: file, readImport: (f) => fs.readFileSync(f, "utf8") });
const w = widthsOf(conf.target);

console.log(`\` backend reduction — target: ${conf.target} / charset: ${conf.charset} / layer: ${conf.layer}`);
console.log(`\` source: ${file}`);
if (!w) {
	console.log(`\` target '${conf.target}' の幅はまだ決まっていない（AArch64 のみ対応）`);
	process.exit(0);
}
console.log("");

const measureConf = { target: conf.target, charset: conf.charset, env };

// 還元の結果を分ける。**「型が付いている」ことと「命令が選べる」ことは別の主張である。**
//
//   scalar   幅と符号まで落ちた。レジスタ1本で渡る（stack_abi.md §4.2）
//   sized    大きさが静的に決まる集約。何バイト置けばよいかは分かっている
//   ref      集約だが大きさが実行時に決まる。参照（`{ptr}` / `{ptr, len}`）でしか渡せない
//   morphism 射（恒等射など）。値ではないので幅を持たない——命令ではなく制御が対応する
//   sum      直和（`A | B`）。表現を決めるには**両方が入る形**を選ぶ必要がある
//   open     族（`Atom` / `Scalar`）のまま。GPR か FPU かも幅も決まっていない
const buckets = { scalar: 0, ref: 0, morphism: 0, sum: 0, open: 0 };
const notes = { ref: [], sum: [], open: [] };

const AGGREGATES = new Set(["String", "List", "Struct", "Iterator", "Implicit"]);
const FAMILIES = new Set(["Atom", "Scalar"]);

// 型を持つノードを全て歩く。ラムダ本体・ブロック・演算子の各項まで入る。
function walk(node, where) {
	if (!node || typeof node !== "object") return;
	classify(node, where);
	if (node.left) walk(node.left, where);
	if (node.right) walk(node.right, where);
	if (node.operand) walk(node.operand, where);
	if (Array.isArray(node.lines)) node.lines.forEach((l) => walk(l, where));
}

function classify(node, where) {
	const t = node.atomType;
	if (!t) return;
	const record = (bucket, note) => {
		buckets[bucket]++;
		if (notes[bucket]) notes[bucket].push({ where, ...note });
	};
	const kind = node.type === "atom" ? `atom/${node.kind}` : `${node.name || node.type}`;
	// 射は値ではない。恒等射に幅を訊くこと自体が問い方の間違いである。
	if (t === "Identity") return record("morphism", null);
	// **渡し方が決まれば命令は選べる**（stack_abi.md §4.6）。値渡しか参照渡しか、
	// レジスタ何本かまで出るなら、そこは Pass 4 が扱える。
	const pass = passingOf(node, measureConf);
	if (pass) return record(pass.mode === "reference" ? "ref" : "scalar", null);
	// 直和は**両方が入る形**を決めなければ表現が決まらない。
	if (t.includes("|")) return record("sum", { type: t, kind });
	record("open", { type: t, kind });
}

for (const node of nodes) {
	const name =
		node.type === "operation" && node.name === "define" && node.left && node.left.value
			? String(node.left.value).replace(/^<|>$/g, "")
			: "(式)";
	walk(node, name);
}

const total = Object.values(buckets).reduce((a, b) => a + b, 0);
console.log(`値渡し（レジスタに乗る）     ${buckets.scalar}`);
console.log(`参照渡し（{ptr} / {ptr,len}） ${buckets.ref}`);
console.log(`射（値ではない）             ${buckets.morphism}`);
console.log(`直和（表現の決定が要る）      ${buckets.sum}`);
console.log(`族のまま（渡し方が決まらない） ${buckets.open}`);
console.log("");

// 理由ごとに畳んで見せる。同じ理由が何箇所で出ているかが分かる方が手を付けやすい。
for (const [bucket, label] of [["open", "族のまま"], ["sum", "直和"]]) {
	if (notes[bucket].length === 0) continue;
	console.log("` " + label);
	const byReason = new Map();
	for (const it of notes[bucket]) {
		const key = `${it.type}  (${it.kind})`;
		if (!byReason.has(key)) byReason.set(key, new Set());
		byReason.get(key).add(it.where);
	}
	for (const [key, wheres] of [...byReason].sort((a, b) => b[1].size - a[1].size).slice(0, 8)) {
		console.log(`  ${key.padEnd(30)} ${[...wheres].slice(0, 6).join(", ")}`);
	}
	console.log("");
}

console.error(`${total} ノード / 渡し方が決まらない ${buckets.open + buckets.sum}`);
