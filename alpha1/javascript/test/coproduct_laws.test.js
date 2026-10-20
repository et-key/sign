/**
 * **余積の解決の法則**（resolve.js、仕様は alpha1/docs/coproduct_spec.md）。常設の一式。
 *
 * coproduct.test.js は §6.3 の表と答えの行を、期待値で確かめる。ここでは期待値を書かず、同じ射の2つの綴りを、決まった
 * 並びで作った多くの組み合わせで比べる。期待値との一致は、期待値と実装の同じ誤りに盲目である。比べる2つの綴りは、
 * 規則から導いた別々の綴りにする。乱数は使わない（毎回同じ入力）。
 *
 * 1. 合成は適用の繰り返し（R11）。根と、desc を読む文脈で比べる。未知の枝（未知になった後ろの括りの関数の実体は、未知に
 *    なった理由に依らない）は別に回す
 * 2. 並びで渡すのと括りで渡すのは同じ（R24）
 * 3. 行の順に依らない（P2・R25）
 * 4. 括りの関数は、括りを外した素の関数と同じ（括りの受け方を除いて、R24）
 *
 * 法則ごとに、比べる2つの綴り・何を同じと見るか・なぜ同じでなければならないか（出どころの規則と利用者の言葉）・
 * 比べの外に出した形とその理由を、その法則の頭に書く。主の Claude の提案「法則の試験を常設の一式として持つ」に、
 * 利用者 2026-10-19「質問が続いてたから気付いてたよ。その方向でお願い」。
 *
 * 落ちたら、法則か実装のどちらかの誤りである。試験を緩めて通さず、どちらの誤りかを調べる。
 *
 * 実行: node test/coproduct_laws.test.js（`npm test` からも呼ばれる）
 */
import { resolve, show, kindOf } from "../resolve.js";

let passed = 0;
let total = 0;
const ok = (name) => {
	console.log(`OK   ${name}`);
	passed++;
};
const fail = (name, ...lines) => console.log(`FAIL ${name}\n${lines.map((l) => `     ${l}`).join("\n")}`);

// 法則を1つ回す。test は { problems, note } を返す。落ちた組は先頭の 40 行だけ見せ、残りは数で言う。
const LIMIT = 40;
const law = (name, test) => {
	total++;
	const t0 = Date.now();
	let res;
	try {
		res = test();
	} catch (e) {
		fail(`法則 ${name}`, `内部の例外: ${e.stack || e.message}`);
		return;
	}
	const ms = Date.now() - t0;
	const { problems, note } = res;
	if (problems.length) {
		const shown = problems.slice(0, LIMIT);
		if (problems.length > LIMIT) shown.push(`…ほか ${problems.length - LIMIT} 行`);
		fail(`法則 ${name}（${note}、${ms}ms）`, ...shown);
	} else ok(`法則 ${name}（${note}、${ms}ms）`);
};

const src = (lines) => lines.join("\n");

// 1つのソースを解いた結果。同じソースは何度も比べるので覚えておく。門なら refused（reason・門の番号・名指し）、門でない
// 例外（実装の内部の誤り）は crash にして、法則の側で必ず落とす（断りに数えて黙って一致させない）。
const memo = new Map();
const outcome = (s) => {
	let o = memo.get(s);
	if (o) return o;
	try {
		const r = resolve(s);
		o = {
			trees: r.trees.map((t) => ({ text: show(t), kind: kindOf(t), excess: !!t.excess })),
			diag: r.diagnostics.map((d) => `${d.reason}/${d.name}`).sort(),
		};
	} catch (e) {
		if (!e.reason) o = { crash: `${e.name}: ${e.message}` };
		else o = { refused: { reason: e.reason, gate: e.gate || "", inst: (e.instances || []).map((i) => [i.fn, i.shape]) } };
	}
	memo.set(s, o);
	return o;
};
// 定義の行を文に分ける（字下げのブロックは、続く TAB の行と閉じの空の行まで1文）。文の名前は `:` の左。
const toUnits = (lines) => {
	const units = [];
	for (const l of lines) {
		if ((l.startsWith("\t") || l === "") && units.length) units[units.length - 1].lines.push(l);
		else units.push({ name: (/^(\S+) :/.exec(l) || [])[1], lines: [l] });
	}
	return units;
};
// 綴りが使う名前の定義だけを、表の順に並べる（定義の中で使う名前もたどる）。使わない定義は入れない：定義は順序に依らず
// （P2）、呼ばれない定義はほかの行の木を変えないので、比べる2つの綴りに同じ定義を並べれば同じ比べになる。1つのソースが
// 短くなるので速い（法則1 は組が多い。全部の定義を並べると1本が 5 秒を超えた）。
const IDENT = /[A-Za-z][A-Za-z0-9]*/g;
const usedDefs = (units, text) => {
	const byName = new Map(units.map((u) => [u.name, u]));
	const need = new Set();
	const visit = (s) => {
		for (const w of s.match(IDENT) || []) {
			if (!byName.has(w) || need.has(w)) continue;
			need.add(w);
			visit(byName.get(w).lines.join("\n"));
		}
	};
	visit(text);
	return units.filter((u) => need.has(u.name)).flatMap((u) => u.lines);
};

const lastOf = (o) => o.trees[o.trees.length - 1];
const isA = (o) => !!o.trees && lastOf(o).kind === "A";
const refusalText = (o) => `${o.refused.reason} ${o.refused.gate} ${JSON.stringify(o.refused.inst)}`;
const brief = (o) =>
	o.crash ? `例外 ${o.crash}` : o.refused ? `断り ${refusalText(o)}` : `${lastOf(o).text} : ${lastOf(o).kind}${lastOf(o).excess ? "（excess）" : ""}`;

const INC = "inc : x ? x + 1";
const M = ["m :", "\tsay : x ? x * 2", "\tother : 1", ""];

// ---------------------------------------------------------------------------
// 法則1：合成は適用の繰り返し（R11）
// ---------------------------------------------------------------------------
//
// 比べる2つの綴り：合成 `f1 f2 … fm x` と、括りで入れ子に書いた適用 `fm (… (f2 (f1 x)) …)`。
//
// なぜ同じか：合成は左から実行する（R11、U 08-31 07:49・U 09-09 07:11・U 10-07 15:54。「`(compose f g)` は、f の後に g を
// 実行する」）ので、(g∘f) x = g (f x)。合成の適用は適用を左から畳んだ物で、合成のための別の表を持たない（主の Claude の
// 提案「合成の適用を、適用を左から畳む形に作り直して合成用の表を消す」に、利用者 2026-10-19「その方向でお願い」）。
//
// 何を同じと見るか。途中の入れ子 N1 = `f1 x`、N2 = `f2 (f1 x)`、… N(m−1) を、それぞれ1行で解いて見る。
// - いつも：合成の根が A なら入れ子も A、入れ子が A なら合成も A。
// - 途中が全部 A：通るなら、定義の行の木（括りの関数の実体）と診断が同じ。断るなら、門と名指しが同じ。
// - 合成も入れ子も A なら、節の種類（最後の結果の desc。`[' k]` で引いた物なら形ごと、R26）も同じ。種類は根に置くと
//   「A」としか見えないので、desc を読む文脈 K（括りの関数 head・hx・tl・その部分適用 `(pb [1])`、点なしの引き `[' 0]`）に
//   置いて比べる：`K (f1 … fm x)` と `K (fm (… (f1 x)))`、`v : f1 … fm x ⏎ K v` と `v : fm (… (f1 x)) ⏎ K v`。綴りの
//   違う行（合成と入れ子を書いた行）は種類だけ、ほかの行（K の定義の行の実体など）は木ごと、診断、断るなら門と名指しを
//   比べる。根だけで比べていた時は、合成の節の desc を中身の見えない A に潰しても落ちなかった（合成の畳み込みの確かめの F1：
//   `head ([' 0] [' 0] [[1 2] [3 4]])` の head は `(inst N x)` のはずが `(inst A x)` になる）。
// - 途中で最初に A でなくなったのが断り：その適用は両方の綴りにあるので、合成も入れ子も同じ門と名指しで断る。
// - 途中で最初に A でなくなったのが未知：入れ子は未知の葉を2項の並びに置くので G7 で断る。合成は節ごと未知にして、根なら
//   通す（§6.4 の5「隣と結ぶ時だけ断り、根なら通す」）。この差は今の規則から出るので許す。合成が名指しの門（R25。後ろの
//   括りの関数が未知を受けて作った実体の本体の門）で断るときも、入れ子は断っている（G7）。
// - 途中で最初に A でなくなったのが L：入れ子の綴り `g (f x)` は L L の並びなので、適用ではなく合成と読む（§0.4 の1・
//   R5）。関数を値として並びで渡す綴りは無いので、右辺が書けない。比べるのは「いつも」の行だけにする。
// - 余りの印（excess）は比べない。印は最初の関数の実引数の話（R10）で、入れ子では括りの中の根に入って消える（括りの中の
//   根なら通る、§3.4）。
//
// 関数は、素の関数（アリティ1・2、本体の根が A・L・未知）・素の関数の部分適用（括り・名前、本体の根が A・L）・穴の書き換え
// とその部分適用・点なし（単項・前置の単項・貪欲な単項・`[+]`・段18 の `[' k]`）・括りの関数（`[x ~xs]`・`[~r]`・
// `[a] [b ~bs]`・最後が裸・本体が門に当たる物）・括りの関数の部分適用を混ぜる。実引数は数・数の並び・括り・括りの括り・
// 文字列・構造体の名前・構造体の List。m は 2 と 3。

const DEFS1 = [
	INC,
	"double : x ? x * 2",
	"add : x y ? x + y",
	"pr : x y ? y",
	"pq : x y ? inc",
	"f3 : a b c ? c",
	"adder : q ? [+ q]",
	"uu : x ? [|] x",
	"uu2 : x y ? [|] x",
	"p1 : pr 1",
	"h1 : f3 _ _ 3",
	"h2 : h1 1",
	"head : [x ~xs] ? x",
	"tl : [y ~ys] ? ys",
	"hx : [x ~xs] ? x 1",
	"bad : [y ~ys] ? 1 _ 2",
	"rs : [~r] ? r",
	"pb : [a] [b ~bs] ? a + b",
	"pt : [a ~as] y ? y",
	"ms :",
	"\tsay : x ? x * 2",
	"\tother : 1",
	"",
	"sv :",
	"\tk : 1",
	"\tother : 2",
	"",
	// 下の「1 の未知の枝」で使う（撒く項・既定値のある関数・実体の根が L の括りの関数）。
	"vs : 1 , 2",
	"go :",
	"\t\tys",
	"\t\tzs : 3",
	"\t? ys",
	"",
	"hl : [x ~xs] ? inc",
];
const UNITS1 = toUnits(DEFS1);
// 最初の関数と、その実引数。足りた適用・余り・足りない適用・未知・L・断りが混ざる。
const FIRSTS1 = [
	["inc", "5"],
	["inc", "5 6"],
	["inc", "`ab`"],
	["inc", "ms"],
	["double", "[1 2 3]"],
	["add", "5 6"],
	["add", "5"],
	["adder", "5"],
	["uu", "5"],
	["uu2", "5 6"],
	["(pr 1)", "5"],
	["(pq 1)", "5"],
	["p1", "5"],
	["(add 1)", "5"],
	["[add _ 10]", "5"],
	["([f3 _ _ 3] 1)", "5"],
	["h2", "5"],
	["[+ 1]", "5"],
	["[+ 1]", "5 6"],
	["[-_]", "5"],
	["[* 2,]", "1 2 3"],
	["[+]", "5 6"],
	["[+]", "5"],
	["[' 0]", "[1 2 3]"],
	["[' 0]", "[[1 2] [3 4]]"],
	["[' 0]", "`ab`"],
	["[' 0]", "[ms ms]"],
	["[' 0]", "5"],
	["[' say]", "ms"],
	["[' other]", "ms"],
	["head", "[1 2 3]"],
	["head", "5 6 7"],
	["head", "[[1 2] [3 4]]"],
	["head", "`ab`"],
	["head", "5"],
	["head", "ms"],
	["tl", "[1 2 3]"],
	["tl", "5"],
	["hx", "[1 2 3]"],
	["hx", "ms"],
	["bad", "[1 2]"],
	["rs", "1 2 3"],
	["rs", "sv"],
	["pb", "[1] [2 3]"],
	["pb", "1 2 3"],
	["pb", "[1]"],
	["pt", "[1] 2"],
	["pt", "[1] 2 3"],
	["(pb [1])", "[2 3]"],
	["(pt [1])", "2"],
];
// 後ろに置く関数（前の結果を1つ受ける）。
const LATER1 = [
	"inc",
	"double",
	"add",
	"adder",
	"uu",
	"(pr 1)",
	"(pq 1)",
	"(uu2 1)",
	"p1",
	"(add 1)",
	"[add _ 10]",
	"([f3 _ _ 3] 1)",
	"h2",
	"[+ 1]",
	"[-_]",
	"[* 2,]",
	"[+]",
	"[' 0]",
	"[' say]",
	"head",
	"tl",
	"hx",
	"bad",
	"rs",
	"pb",
	"pt",
	"(pb [1])",
	"(pt [1])",
];
// m = 3：最初の関数の一部と、後ろの関数の一部の2つずつの組（全部の組だと1本が数秒を超えるので、途中が A・未知・L・
// 断り・形つきの A になる物を選んだ）。
const FIRSTS1_3 = [
	["inc", "5"],
	["adder", "5"],
	["[+]", "5"],
	["[' 0]", "[[1 2] [3 4]]"],
	["[' 0]", "[ms ms]"],
	["[' say]", "ms"],
	["head", "[1 2 3]"],
	["pb", "[1] [2 3]"],
];
const LATER1_3 = ["inc", "[+ 1]", "[add _ 10]", "h2", "[' 0]", "head", "tl", "hx", "bad", "adder"];

// 1つの綴り（行の並び）を、使う定義だけ前に並べて解く。
const at1 = (...lines) => outcome(src([...usedDefs(UNITS1, lines.join("\n")), ...lines]));
// desc を読む文脈（上の「何を同じと見るか」）。括りの関数の実体の綴りには受けた物の形が出る（`(inst N x)`）ので、head が
// 形を、`[' 0]` が引けるかを、hx が要素の種類（`x 1` が適用か構築か）を見る。値の名前を通す形は head だけにした（組が多く、
// 1本 5 秒を超えないように）。
const CTX1 = ["head", "[' 0]", "hx"];
const CTX1_NAME = ["head"];

law("1 合成は適用の繰り返し：f1 … fm x と fm (… (f1 x))", () => {
	const problems = [];
	const count = { 途中が全部A: 0, 途中で断り: 0, 途中で未知: 0, "途中で L（比べの外）": 0, 合成がA: 0, 合成が名指しで断る: 0, 文脈で比べた組: 0, 文脈で断る組: 0 };
	let n = 0;
	const at = (expr) => at1(expr);
	// 文脈 K に置いた綴りの見え方。綴りの違う行（後ろから back 番目）は種類だけにする。
	const ctxView = (o, back) => {
		if (o.crash) return `例外 ${o.crash}`;
		if (o.refused) return `断り ${refusalText(o)}`;
		const i0 = o.trees.length - back;
		return `${o.trees.map((t, i) => `${i === i0 ? "（合成か入れ子の行）" : t.text} : ${t.kind}${t.excess ? "（excess）" : ""}`).join(" | ")} || ${o.diag.join(" ")}`;
	};
	const checkContexts = (composed, nested) => {
		const forms = [
			...CTX1.map((k) => [[`${k} (${composed})`], [`${k} (${nested})`], 1]),
			...CTX1_NAME.map((k) => [[`v : ${composed}`, `${k} v`], [`v : ${nested}`, `${k} v`], 2]),
		];
		for (const [cl, nl, back] of forms) {
			count.文脈で比べた組++;
			const oc = at1(...cl);
			const on = at1(...nl);
			const vc = ctxView(oc, back);
			const vn = ctxView(on, back);
			if (oc.refused) count.文脈で断る組++;
			if (oc.crash || on.crash || vc !== vn) problems.push(`文脈 ${cl.join(" ⏎ ")}  ⇔  ${nl.join(" ⏎ ")}`, `  合成: ${vc}`, `  入れ子: ${vn}`);
		}
	};
	const check = (fs, x) => {
		n++;
		const composed = `${fs.join(" ")} ${x}`;
		const inner = [`${fs[0]} ${x}`];
		for (const g of fs.slice(1)) inner.push(`${g} (${inner[inner.length - 1]})`);
		const nested = inner[inner.length - 1];
		const c = at(composed);
		const d = at(nested);
		const bad = (...why) => problems.push(`${composed}  ⇔  ${nested}`, ...why.map((w) => `  ${w}`), `  合成: ${brief(c)}`, `  入れ子: ${brief(d)}`);
		if (c.crash || d.crash) return bad("内部の例外");
		if (isA(c) !== isA(d)) return bad("A かどうかが違う");
		if (isA(c)) count.合成がA++;
		if (c.refused && c.refused.inst.length) count.合成が名指しで断る++;
		// 途中で最初に「通って A」でなくなった物。
		const firstNonA = inner
			.slice(0, -1)
			.map(at)
			.find((o) => !isA(o));
		if (!firstNonA) {
			count.途中が全部A++;
			if (c.refused || d.refused) {
				if (!c.refused || !d.refused || refusalText(c) !== refusalText(d)) bad("途中が全部 A なのに、断るか・門・名指しが違う");
				return;
			}
			const defs = (o) => o.trees.slice(0, -1).map((t) => t.text).join(" | ");
			if (defs(c) !== defs(d)) bad("定義の行の木（括りの関数の実体）が違う", `合成の定義: ${defs(c)}`, `入れ子の定義: ${defs(d)}`);
			if (c.diag.join() !== d.diag.join()) bad(`診断が違う: ${c.diag} と ${d.diag}`);
			if (isA(c)) checkContexts(composed, nested);
			return;
		}
		if (firstNonA.crash) return bad(`途中の入れ子が内部の例外: ${firstNonA.crash}`);
		if (firstNonA.refused) {
			count.途中で断り++;
			if (!c.refused || !d.refused || refusalText(c) !== refusalText(d)) bad("途中の適用が断るのに、合成と入れ子の断りが違う");
			return;
		}
		if (lastOf(firstNonA).kind === "未知") {
			count.途中で未知++;
			if (!d.refused || d.refused.gate !== "G7") bad("途中が未知なのに、入れ子が G7 で断っていない");
			return;
		}
		count["途中で L（比べの外）"]++;
	};
	for (const [f, x] of FIRSTS1) for (const g of LATER1) check([f, g], x);
	for (const [f, x] of FIRSTS1_3) for (const g of LATER1_3) for (const h of LATER1_3) check([f, g, h], x);
	// どの枝も1つ以上通っていなければ、法則は何も見ていない。
	for (const [k, v] of Object.entries(count)) if (!v) problems.push(`「${k}」の組が無い（法則がその枝を見ていない）`);
	return { problems, note: `比べた組 ${n}：${Object.entries(count).map(([k, v]) => `${k} ${v}`).join("・")}` };
});

// ---------------------------------------------------------------------------
// 法則1 の未知の枝：未知になった後ろの括りの関数の実体は、未知になった理由に依らない（R11・R25）
// ---------------------------------------------------------------------------
//
// 比べる2つの綴り：`P S x`（P = f1 … fj を x に当てた所で未知になる）と `[+] S 5`（頭の `[+]` に1項で未知、§5 Q17）。
// S は後ろの関数の並びで、括りの関数（とその部分適用）を1つ以上含む。
//
// なぜ同じか：合成は適用の畳み込みで、前の結果が L か未知なら、そこから先は未知（関数を値として次へ渡す読みは決めて
// いない）。後ろの関数は前の結果を受けて呼ばれる（R11）ので、括りの関数（とその部分適用）は未知を1つ受けて実体を作り
// （R25「呼ばれたら本体を解く」、§5 Q24 の案1）、ほかの関数は根を引かない（§5 Q28）。どちらの綴りでも S が受けるのは同じ
// 「未知」なので、S の括りの関数の実体は同じでなければならない。未知になった理由が、頭の足りたか決まらない適用（`[+]` に
// 1項・`[|]`・既定値のある関数・撒く項）でも、足りた適用の根が A でない（L・未知）のでも、途中の足りない適用や L の引きでも
// 同じ（§5 Q27 の断る側。主の Claude の設計「頭が足りたか決まらなくても、後ろの括りの関数は未知を受けて実体を作る」に、
// 利用者 2026-10-19「その方向でお願い」）。法則1 は途中が未知の組で入れ子が G7 で断ることしか見ないので、ここで見る。
//
// 何を同じと見るか：S の括りの関数の定義の行の木、呼ぶ行の種類（どちらも未知）、診断。断るなら門と名指し。加えて、S の
// 括りの関数は呼ばれるので、定義の行が `defer` のままなら落とす（R25）。
//
// 見ないこと：未知を受けた実体の形が U であること。期待値なので coproduct.test.js（「Q27 で裏返した [+] tl 5」の行など）に
// 置いた。この法則は、その行の答えを未知の理由の全部へ運ぶ。
//
// 比べの外：S の括りの関数を P でも使う組（定義の行に P で作った実体も並ぶ）。
const PREFIX1U = [
	["adder", "5"], // 足りた適用で、本体の根が L（§5 Q21）
	["uu", "5"], // 本体の根が未知
	["(pq 1)", "5"], // 部分適用の根が L
	["hl", "[1 2]"], // 括りの関数の実体の根が L
	["head", "ms"], // 括りの関数の実体の根が未知（構造体に欄 x が無い）
	["[' say]", "ms"], // 引いた物が L
	["[' 0]", "5"], // 数から引く（R26：未知）
	["[|]", "5"], // アリティの分からない点なし（§5 Q27）
	["go", "vs"], // 既定値のある関数（§5 Q8・Q27）
	["inc", "vs~"], // 撒く項（k を数えない、§5 Q27）
	["inc [+]", "5"], // 途中の `[+]` に1項（Q17）
	["inc add", "5"], // 途中の足りない適用（L）
	["inc adder", "5"], // 途中の根が L
	["[' 0] [+]", "[1 2]"], // 形のある A の後の `[+]`
];
const SUFFIX1U = ["tl", "head", "hx", "bad", "rs", "(pb [1])", "(pt [1])", "tl head", "inc tl", "[+ 1] hx", "[' 0] bad", "tl inc rs", "hx bad", "adder tl"];
const PATTERNS1 = new Set(["head", "tl", "hx", "bad", "rs", "pb", "pt", "hl"]);

law("1 の未知の枝 未知になった後ろの括りの関数の実体は、未知になった理由に依らない：P S x と [+] S 5", () => {
	const problems = [];
	const count = { 通る: 0, 断る: 0 };
	const names = (s) => [...new Set(s.match(IDENT) || [])];
	for (const [p, x] of PREFIX1U) {
		// P x は通って A でない（未知か、足りた適用の L。`[' say] ms` は引いた関数で L）。足りない適用の L は合成ごと L に
		// なるので PREFIX1U に入れない（呼ぶ行の種類を比べるので、入れれば落ちる）。
		const alone = at1(`${p} ${x}`);
		if (alone.crash || alone.refused || lastOf(alone).kind === "A") {
			problems.push(`前提が崩れた：${p} ${x} が通って A でない物にならない（${brief(alone)}）`);
			continue;
		}
		for (const s of SUFFIX1U) {
			const pats = names(s).filter((w) => PATTERNS1.has(w));
			if (names(`${p} ${x}`).some((w) => pats.includes(w))) continue;
			const c = at1(`${p} ${s} ${x}`);
			const r = at1(`[+] ${s} 5`);
			const label = `${p} ${s} ${x}  ⇔  [+] ${s} 5`;
			if (c.crash || r.crash) {
				problems.push(label, `  P S x: ${brief(c)}`, `  [+] S 5: ${brief(r)}`);
				continue;
			}
			const view = (o) => {
				if (o.refused) return `断り ${refusalText(o)}`;
				const defs = pats.map((g) => o.trees.find((t) => t.text.startsWith(`(: ${g} (? `)).text);
				return `${defs.join(" | ")} || 呼ぶ行 : ${lastOf(o).kind} || ${o.diag.join(" ")}`;
			};
			const vc = view(c);
			const vr = view(r);
			if (vc !== vr) problems.push(label, `  P S x: ${vc}`, `  [+] S 5: ${vr}`);
			if (!r.refused && vr.includes("(defer ")) problems.push(`[+] ${s} 5：呼ばれた括りの関数の定義の行が defer のまま（R25）`, `  ${vr}`);
			if (r.refused) count.断る++;
			else count.通る++;
		}
	}
	for (const [k, v] of Object.entries(count)) if (!v) problems.push(`「${k}」の組が無い（法則がその枝を見ていない）`);
	return { problems, note: `未知の理由 ${PREFIX1U.length}・後ろの並び ${SUFFIX1U.length}：${Object.entries(count).map(([k, v]) => `${k} ${v}`).join("・")}` };
});

// ---------------------------------------------------------------------------
// 法則2：並びで渡すのと括りで渡すのは同じ（R24）
// ---------------------------------------------------------------------------
//
// 比べる2つの綴り：最後の仮引数が括りの関数 g に、`g a1 … a(n−1) b1 … bm` と `g a1 … a(n−1) [b1 … bm]`（m ≥ 2）。
//
// なぜ同じか：R24「最後の仮引数が括りの関数は、k > n なら前の仮引数に1つずつ当てて、残りの並び全体を最後の括りが1つの
// List として受ける（`f 1 2 3` は `f [1 2 3]`、`map $[* 2] 1 2 3 4 5` は `map $[* 2] [1 2 3 4 5]` と同じ。`excess` は
// 付けない）」。U〔答え〕2026-10-19「括りの仮引数が1つの関数に `f 1 2 3` を渡したら、`f [1 2 3]` と同じでいい？」に
// 「それでいいよ」、続けて「最後の仮引数が括りの関数は、前の仮引数に1つずつ当てて、残りの並び全体を最後の括りが受ける。」。
// 部分適用も「残りのアリティでこの行を読み、残りが来たら当てた物と合わせて元の関数の実体を作る」（§3.4 の括りの関数の行）
// ので、残りの最後の仮引数が括りなら同じ。合成の頭も同じ：R24「合成は左から実行する（R11）ので、最初の関数は並びを受け
// （上の当て方のどれか）」。
//
// 何を同じと見るか：呼ぶ行のほかの全部の行の木（括りの関数の定義の行の inst の綴り）と種類、呼ぶ行の種類と余りの印、
// 診断。断るなら門と名指し。
//
// g は、括り1つ・前に裸の仮引数・前に括りの仮引数（1つ・2つ）・本体で別の括りの関数を呼ぶ・再帰・括りの関数の部分適用
// （括り・名前・部分適用の部分適用）・括った `?`。呼ぶ形は、根・逆適用の左・値の定義・素の関数の本体・合成の頭。残りの並び
// には、数・文字列・文字・括り・形の混ざった物・`$` の番地・構造体の名前・未定義の名前・適用の括り・値の演算子を入れる。
//
// 比べの外：撒く項を含む並び（k を数えない、R24）と `_`（R15・R16・G5）は、R24 の文で読みが違う。残りの並びが関数で
// 始まる形（`g inc 1`）は合成になる（R6）。

const DEFS2 = [INC, ...M, "pt :", "\tk : 1", "\tother : 2", "", "yn : 3"];
const UNITS2 = toUnits(DEFS2);
// [定義, 呼ぶ頭の名前, 前の仮引数に当てる実引数]
const HEADS2 = [
	[["f : [x ~xs] ? x 1"], "f", ""],
	[["n : [~x] ? x"], "n", ""],
	[["hd : [x ~xs] ? x"], "hd", ""],
	[["p : [x ~xs] ? q x", "q : [y] ? y 5"], "p", ""],
	[["f : [x ~xs] ? [f xs] x"], "f", ""],
	[["s : [h ~hs] ? (h ' 0) 1"], "s", ""],
	[["map : f [x ~y] ? x"], "map", "$inc"],
	[["h : v [x ~xs] ? v 1"], "h", "1"],
	[["pair : [a ~as] [b ~bs] ? a + b"], "pair", "[1 2]"],
	[["pf : [say] [x ~xs] ? say x"], "pf", "m"],
	[["p3 : [a] [b ~bs] [c ~cs] ? a + c"], "p3", "1 [2 3]"],
	[["pm : [say] [b ~bs] [c ~cs] ? say b"], "pm", "m [2 3]"],
	[["pair : [a ~as] [b ~bs] ? a + b"], "(pair [1 2])", ""],
	[["pair : [a ~as] [b ~bs] ? a + b", "pp : pair [1 2]"], "pp", ""],
	[["p3 : [a] [b ~bs] [c ~cs] ? a + c"], "(p3 1)", "[2 3]"],
	[["p3 : [a] [b ~bs] [c ~cs] ? a + c"], "((p3 1) [2 3])", ""],
	[[], "[[x ~xs] ? x 1]", ""],
];
const RESTS2 = ["1 2", "1 2 3 4", "`ab` `cd`", "\\a \\b", "[1 2] [3 4]", "1 [2 3]", "1 $inc", "$inc $inc", "m m", "pt pt", "zz zz", "(inc 1) 2", "-1 2", "yn yn", "1 + 2 3"];
// [名前, 呼ぶ行を作る関数（頭と実引数の綴りから、行の並びと、呼ぶ綴りを含む行の番号を返す）]
const FORMS2 = [
	["根", (h, a) => [[a ? `${h} ${a}` : h], [0]]],
	["逆適用の左", (h, a) => [[`${a ? `${h} ${a}` : h} inc`], [0]]],
	["値の定義", (h, a) => [[`v : ${a ? `${h} ${a}` : h}`, "v inc"], [0]]],
	["素の関数の本体", (h, a) => [[`t : u ? ${a ? `${h} ${a}` : h}`, "t 1 inc"], [0]]],
	["合成の頭", (h, a) => [[a ? `${h} inc ${a}` : `${h} inc`], [0]]],
];

law("2 最後の仮引数が括りの関数に、残りを並びで渡しても括って渡しても同じ", () => {
	const problems = [];
	let nPass = 0;
	let nRefused = 0;
	for (const [defs, h, front] of HEADS2) {
		for (const rest of RESTS2) {
			for (const [formName, form] of FORMS2) {
				const [seqLines, callAt] = form(h, [front, rest].filter(Boolean).join(" "));
				const [brLines] = form(h, [front, `[${rest}]`].filter(Boolean).join(" "));
				// 使う定義だけを並べる（法則1 の usedDefs。並びと括りの綴りは同じ名前を使うので、同じ定義が並ぶ）。
				const seq = outcome(src([...usedDefs(UNITS2, [...defs, ...seqLines].join("\n")), ...defs, ...seqLines]));
				const br = outcome(src([...usedDefs(UNITS2, [...defs, ...brLines].join("\n")), ...defs, ...brLines]));
				const view = (o) => {
					if (o.crash) return `例外 ${o.crash}`;
					if (o.refused) return `断り ${refusalText(o)}`;
					// 呼ぶ形の行は1行ずつ（木も1つずつ）なので、後ろから数えて呼ぶ綴りを含む行を見分ける。
					const base = o.trees.length - seqLines.length;
					const ts = o.trees.map((t, i) => (callAt.includes(i - base) ? `呼ぶ行 : ${t.kind}${t.excess ? "（excess）" : ""}` : `${t.text} : ${t.kind}${t.excess ? "（excess）" : ""}`));
					return `${ts.join(" | ")} || ${o.diag.join(" ")}`;
				};
				const vs = view(seq);
				const vb = view(br);
				if (seq.crash || br.crash || vs !== vb) problems.push(`${formName}：${seqLines[0]}  ⇔  ${brLines[0]}`, `  並び: ${vs}`, `  括り: ${vb}`);
				if (br.refused) nRefused++;
				else nPass++;
			}
		}
	}
	if (!nPass || !nRefused) problems.push(`通る組 ${nPass}・断る組 ${nRefused}（どちらも1つ以上のはず）`);
	return { problems, note: `比べた組 ${nPass + nRefused}：通る ${nPass}・断る ${nRefused}` };
});

// ---------------------------------------------------------------------------
// 法則3：行の順に依らない（P2・R25）
// ---------------------------------------------------------------------------
//
// 比べる2つの綴り：同じ文（ファイルのいちばん外の定義と呼ぶ行。字下げのブロックは1文）からなるプログラムの、文の並べ方を
// 変えた物。どのプログラムも5文まで（§5 Q28 まわりの形の3つだけ6文）にして、全部の並べ方（最大 120、6文は 720）を比べる。
//
// なぜ同じか：P2「ファイルのいちばん外の定義を、先に全部集める。順序には依らない。」。R25「行の順を入れ替えても、全部の木・
// 種類・診断・門は変わらない。」。括りの関数の `inst` は、全部の行を解き終えてから埋める（resolve.js の resolve）ので、呼ぶ
// 行が定義の前でも後でも同じ木になる。種類は定義どうしの依りの上の不動点で、再帰の仮置きが外れたら、頼った答えを確定した
// 値で解き直す（resolve.js の「仮置きの記録」）ので、どの順に解いても同じ答えに着く（§3.4）。
//
// 何を同じと見るか：文ごとの木と種類と余りの印、診断（名前ごと）。断るなら門と名指し。
//
// 比べの外：
// - 断る文が2つ以上のプログラム。門は行の順に断る（resolve.js：本体の根を先に解くとき（§6.4 の1）は門で止めず、行を解く
//   ときに行の順に断る）ので、どの門を言うかは並べ方で決まる。名指しも、呼んだ行で使った名前で言う（R25）ので、同じ実体を
//   別の名前で呼ぶ2行があれば、先の行の名前になる（coproduct.test.js の「守り 値の定義の行が先なら、その行で名指し」）。
//   だからどのプログラムも、断る文は多くて1つにした。
//
// §5 Q28 の形（Q28_FORMS）も比べる。再帰の関数 f の A の仮置きが外れ、f を解いている途中で引いた別の関数 g の本体が、f の根を
// 根に使っていない形である。仮置きの依りは g にも付く（根に使ったかは見ない）。前は、外れた仮置きに頼った答えを未知に替えた
// ので、f と g のどちらを先に解くかで g の根が替わり、f が先なら `g 5 inc` が G2(a)、g が先なら A に割れた（2026-10-20 に
// 解き直しへ作り直すまで「今は割れる」の名簿に置き、割れなくなったら落ちる守りにしていた）。隣の形（仮置きが外れても根に
// 使う・仮置きが合えば根に使わなくても）は、前から割れない。
//
// f : x y ? ⏎ ⇥g y ⏎ ⇥inc は、g を呼ぶ相互再帰で、本体の根は最後の行の `inc`（L）なので A の仮置きが外れる。g の根は積で f に
// 依らない。2つ目は、合成の後ろの根を引いた後で未知になる形（Q28 の文の `inc (f 1) [+] y`）。3つ目は、f が g を欄に入れて
// 括りの関数 h に渡す形で、仮置きの依りは括りの関数の実体を通っても付く。4つ目から下は、合成を適用の畳み込みにして
// （2026-10-19）増えた入口：前の結果が A の間は後ろの関数に当てて根を引く（直接書いた g (f x) と同じ）ので、後ろの非貪欲の
// 単項・穴・最初の `[' k]` の後ろでも f の根を引く。4つ目は、引いた根が後ろの `[+]` で未知になって答えに使われない形、5〜7つ目
// は、引いた根が g の根（積）に使われない形。未知の後ろの括りの関数は実体を作る（§5 Q27 の断る側）ので、その本体が引く根も
// 同じ（8・9つ目）。10個目は、無名の素の関数の根（積）が f の外れた仮置きに頼り、欄に入って hh の実体へ渡る形で、g の根は
// その実体の根である。無名の関数の記録は地図に載らないので、閉包が解き直す（resolve.js の collectedRoot。古い記録を未知に
// するだけの作りでは、前と同じく f が先なら G2(a) に割れる。確かめ 2026-10-20）。11個目は、f と e の2つの仮置きが外れ、
// 外れが入れ子になって同じ記録（g）の解き直しが重なる形（確かめ 2026-10-20 の Q28V-6。解き直しの回数を 1 回に抑えると
// 割れる）。
const Q28F = ["f : x y ?", "\tg y", "\tinc", ""];
const Q28_FORMS = [
	["Q28 f が g を呼び、g の積の中で f を呼ぶ", [[INC], Q28F, ["g : y ? (f 1 y) , 1"], ["g 5 inc"]]],
	["Q28 根を引いた後で未知になる（inc (f 1) [+] y）", [[INC], Q28F, ["g : y ? (inc (f 1) [+] y) , 1"], ["g 5 inc"]]],
	["Q28 括りの関数の実体を通して再帰に入る（欄の関数）", [[INC], ["f : x ?", "\th [s : g]", "\tinc", ""], ["g : y ? (f y) , 1"], ["h : [s] ? s 1"], ["g 5 inc"]]],
	["Q28 後ろの非貪欲の単項の後で根を引き、[+] で使われなくなる（inc [+ 1] f [+] y）", [[INC], ["f : x ?", "\tg x", "\tinc", ""], ["g : y ? (inc [+ 1] f [+] y) , 1"], ["g 5 inc"]]],
	["Q28 後ろの非貪欲の単項の後で根を引く（inc [+ 1] (f 1) y）", [[INC], Q28F, ["g : y ? (inc [+ 1] (f 1) y) , 1"], ["g 5 inc"]]],
	["Q28 後ろの穴の後で根を引く（inc [add _ 10] (f 1) y）", [[INC], ["add : a b ? a + b"], Q28F, ["g : y ? (inc [add _ 10] (f 1) y) , 1"], ["g 5 inc"]]],
	["Q28 最初の [' 0] の後で根を引く（[' 0] (f 1) [[1 2] [3 4]]）", [[INC], Q28F, ["g : y ? ([' 0] (f 1) [[1 2] [3 4]]) , 1"], ["g 5 inc"]]],
	["Q28 足りたか決まらない頭の後ろの括りの関数の実体が根を引く（[+] tl y、§5 Q27）", [[INC], Q28F, ["g : y ? ([+] tl y) , 1"], ["tl : [q ~qs] ? (f 1 5) , 1"], ["g 5 inc"]]],
	["Q28 撒く項の頭の後ろの括りの関数の実体が根を引く（inc tl ws~、§5 Q27）", [[INC], Q28F, ["g : y ? (inc tl ws~) , 1"], ["tl : [q ~qs] ? (f 1 5) , 1"], ["ws : 1 , 2"], ["g 5 inc"]]],
	["Q28 無名の関数の根が外れた仮置きに頼り、欄で括りの関数の実体へ渡る", [[INC], ["hh : [s] ? s 1"], ["f : x ?", "\tg x", "\tinc", ""], ["g : y ? hh [s : [w ? (f w) , 1]]"], ["g 5 inc"]]],
	["Q28 2つの仮置きが入れ子に外れ、g の解き直しが重なる", [[INC], ["f : x ?", "\te x", "\tg x", "\tinc", ""], ["e : x ?", "\tg x", "\tinc", ""], ["g : y ? (f y) , (e y) , 1"], ["g 5 inc"]]],
];

// 外れた仮置きに頼った答えに、古いと印を付ける所（resolve.js の「仮置きの記録」の注の1〜3）の形。どれも呼ぶ行は、どの並べ方
// でも断る（G2(a)）のが答えで、印が欠けると、特定の並べ方でだけ黙って A になる（その並べ方は coproduct.test.js の「Q28」の
// 断る行が見る。確かめ 2026-10-20）。
// - 1つ目・2つ目（注の2、F1）：O・M・N の順に枠が積まれ、N が M の仮置きを、M が O の仮置きを使い、M が A で閉じた後で O が
//   外れる形。h のブロックの最後の行 `inc` は L なので h は未知、f の行 `h x` も未知なので f も未知、g = f x も未知。2つ目は
//   括りの関数の実体を通る（k は行 `f x` で未知、実体 hb [s : k] の根 `s 1` も未知）。
// - 3つ目（注の3、Q28V-3）：例外で抜けた枠の仮置き。w の既定値の `v 2` を読むと v → h と解き、h の本体の行 `w` が名前の輪で
//   抜ける（namesPattern が握りつぶす）。k の根は h の根で未知。この輪は既定値を覗いた所（w → v）を通るので、種類の輪では
//   なく（既定値は解かない、P3）、§5 Q30 でも断らない（resolve.js の namesPattern の注。確かめ 2026-10-20 の Q30-ADV-1・2）。
// - 4つ目（collectedRoot、Q28V-5）：無名の関数を、外の枠（f1）がまだ解いている途中に解き直す形。解き直しで引いた仮置きにも
//   頼る。g の根＝hh の実体の根＝無名の関数の根＝f1 の根で、f1 は未知。
const Q28_REFUSE_FORMS = [
	["Q28 外れた仮置きの上で閉じた枠に頼る（h → f → g）", [[INC], ["h : x ?", "\tf x", "\tinc", ""], ["f : x ?", "\tg x", "\th x", ""], ["g : x ? f x"], ["g 5 inc"]]],
	["Q28 外れた仮置きの上で閉じた枠に頼る（括りの関数の実体）", [[INC], ["hb : [s] ? s 1"], ["f : x ?", "\tinc", "\tk x", ""], ["k : x ?", "\tf x", "\thb [s : k]", ""], ["hb [s : k] inc"]]],
	["Q28 例外で抜けた枠の仮置きに頼る（名前の輪を握りつぶす道）", [[INC], ["w : 1 , [[x : v 2] ? 5]"], ["v : h 1"], ["h : x ?", "\tk x", "\tw", "\tinc", ""], ["k : x ? h x"], ["k 5 inc"]]],
	["Q28 無名の関数の解き直しが外の枠の仮置きに頼る", [[INC], ["hh : [s] ? s 1"], ["f1 : x ?", "\tf2 x", "\tg x", "\tinc", ""], ["f2 : x ?", "\tg x", "\tinc", ""], ["g : y ? hh [s : [w ? f1 ((f2 w) , 1)]]"], ["g 5 inc"]]],
];

// 実体の守り（resolve.js の INSTANCE_DEPTH_LIMIT の注、2026-10-20）。守りの値は言語の規則ではなく実装の守りだが、当たるかは
// 作る実体の鍵（渡した形）と確定した答えだけで決める（主の Claude の提案「守りを枠の積み方ではなく形そのものの性質で決まる
// 形にまとめ直す」）。だから境目の形は、どの並べ方でも同じ答え（通る・断る）になる。法則3 は割れないことを、下の守りは
// 答えそのものを見る。
//
// 深さ（注の1）：作る実体の鍵の入れ子の深さが 32 を超えたら G7。`p : [a] ? p a` に `[a : …]` を d 重にした字面（形の深さ
// d + 1）を渡すと、入れ子を1段ずつ剥がす（減っていく形の再帰）ので、断るかは初めの形の深さで決まる：30・31 段（深さ 31・32）
// は通り、32・33 段（深さ 33・34）は最初の呼び出しで G7。前は同じ `?` の実体の入れ子を数え、浅い呼び出し（a2）の実体を先に
// 作ると下の記録を引いて段を少なく数えた。33 段は a2 が先なら A、後なら b が黙って未知に割れ、32 段は G7 と A に割れた
// （2026-10-20 の自己点検の SC-2）。
const NEST = (d) => `${"[a : ".repeat(d)}1${"]".repeat(d)}`;
// 輪と入れ子の鎖（coproduct.test.js の ROT と同じ）：r は a と b を入れ替えて自分を呼び、a を剥がしても自分を呼ぶ。形の深さは
// d + 1（入れ替えても同じ）。30・31 段は通り、32 段は G7。前の守り（実体の入れ子のいちばん長い道 d + 2 個）では 31 段が G7 で、
// 輪の中の段は近似だった（輪の頭から輪の外へ別の道があると、入る所で1段少なく数えうる）。
const ROT = ["r : [a b] ? (r [a : b", "\tb : a]) , (r a)"];
const ROT_NEST = (d) => (d === 0 ? ["1"] : ((inner) => [`[a : ${inner[0]}`, ...inner.slice(1), "\tb : 1]"])(ROT_NEST(d - 1)));
const ROT_DEF = (name, d) => ((s) => [`${name} : r ${s[0]}`, ...s.slice(1)])(ROT_NEST(d));
// 閉包が前の実体の中で書かれる再帰：形の綴りは {s:L} のままでも、鍵は1段ずつ深くなる（閉包の鍵は書いた所の実体の鍵を
// 持つ）。どの並べ方でも G7。
const CLOSURE_REC = [[INC], ["f : [s] ? f [s : [y ? s y]]"], ["f [s : inc]"]];
// [名前, 文, 答え（"通る"・"G7"・断りの reason）]
const DEPTH_FORMS = [
	["輪と入れ子の鎖が上限の内（30 段、深さ 31）", [ROT, ROT_DEF("bb", 30), ROT_DEF("cc", 15), ["bb"], ["cc"]], "通る"],
	["輪と入れ子の鎖が上限ちょうど（31 段、深さ 32）", [ROT, ROT_DEF("bb", 31), ROT_DEF("cc", 15), ["bb"], ["cc"]], "通る"],
	["輪と入れ子の鎖が上限を超える（32 段、深さ 33）", [ROT, ROT_DEF("bb", 32), ROT_DEF("cc", 15), ["bb"], ["cc"]], "G7"],
	["減っていく形の再帰が上限を超える（33 段、深さ 34）", [["p : [a] ? p a"], [`b : p ${NEST(33)}`], ["a2 : p [a : 1]"], ["a2"], ["b"]], "G7"],
	["減っていく形の再帰が上限を超える（32 段、深さ 33、浅い呼び出しが2つ）", [["p : [a] ? p a"], [`b : p ${NEST(32)}`], [`a2 : p ${NEST(5)}`], [`c : p ${NEST(20)}`], ["b"]], "G7"],
	["減っていく形の再帰が上限ちょうど（31 段、深さ 32）", [["p : [a] ? p a"], [`b : p ${NEST(31)}`], [`a2 : p ${NEST(20)}`], ["a2"], ["b"]], "通る"],
	["減っていく形の再帰が上限の内（30 段、深さ 31、浅い呼び出しが2つ）", [["p : [a] ? p a"], [`b : p ${NEST(30)}`], [`a2 : p ${NEST(5)}`], [`c : p ${NEST(29)}`], ["b"]], "通る"],
	["減っていく形の再帰を素の関数の本体から（33 段）", [["p : [a] ? p a"], [`f : x ? p ${NEST(33)}`], ["g : x ? p [a : [a : 1]]"], ["f 1"], ["g 1"]], "G7"],
	["閉包が前の実体の中で書かれる再帰", CLOSURE_REC, "G7"],
];
// 総数（注の2）：同じ関数の確定した実体（最後の木の実体）が 512 を超えたら G7。外れた仮置きの上でだけ作った実体は数えない。
// PS(n) は、p の実体を n 個（欄の名前の違う構造体）作る値の定義。g は f を呼んで最後の行 `[+ 1]`（L）で仮置きが外れ、f は
// `p [s : (g x)]` を作る。g を f より先に解くと、f は g の仮置き（A）の上で p|{s:A} を作るが、確定した値（g は未知）の上では
// p|{s:U} だけを作る。だから p の確定した実体は n + 1 個で、511 なら通り、512 なら断る（どの並べ方でも）。前は作った実体の
// 全部を数えたので、511 で g が先なら 513 個で G7、f が先なら 512 個で通るに割れた（§5 Q25 の SC-3）。
// 枝ごとに形が増える再帰は確定した実体で、同じ形で自分を引いてから増える再帰は作った実体の数の守り（注の3、資源の守り）で
// 断る。総数を超える実体と値を含む輪が同じファイルにあれば、どの並べ方でも輪（name-cycle）を言う（守りの断りは覚えて、輪の
// 後に言う。前は総数の断りが先に投げ上がり、輪を見る前に止まる並べ方があった。確かめ 2026-10-20）。
const PS = (n) => [`ps : ${[...Array(n).keys()].map((i) => `(p [k${i} : 1])`).join(" , ")}`];
const SC3 = (n) => [["p : [s] ? 1"], ["g : x ?", "\tf x", "\t[+ 1]", ""], ["f : x ? p [s : (g x)]"], PS(n)];
const TOTAL_FORMS = [
	["総数：外れた仮置きの上の実体は数えない（確定した実体 512）", SC3(511), "通る"],
	["総数：確定した実体が上限を超える（513）", SC3(512), "G7"],
	["総数：枝ごとに形が増える再帰（最初の枝が深さの門で断るので、残りの枝は最後の木に無い）", [["g : [x ~xs] ? (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])"], ["g [1 2]"]], "instance-work-limit"],
	["総数：門に当たる実体の後ろの実体は数えない", [["p : [s] ? 1"], ["bad : [y] ? 1 _ 2"], ["t : x ? (bad [y : 1]) , (p [m : 1])"], [[...Array(512).keys()].map((i) => `(p [k${i} : 1])`).join(" , ")]], "coproduct-unit-position"],
	["総数を超える実体と値を含む輪", [["p : [s] ? 1"], PS(513), ["v : w"], ["w : v"]], "name-cycle"],
	// 守りに当たった `?` だけを止めるので、ほかの `?` の実体を通る値を含む輪も、ほかの `?` の溢れも見つかる（確かめ 2026-10-20。全部を
	// 止めると、ps が先の並べ方だけ総数を言い、名指しも先に溢れた方になった）。
	["総数を超える実体と、別の `?` の実体を通る値を含む輪", [["p : [s] ? 1"], PS(513), ["v : q [s : 1]"], ["q : [s] ? w"], ["w : v"]], "name-cycle"],
	// 門のある行と、合わせて総数を超える2つの行：断る行があっても残りの行を解くので、どの並べ方でも総数を言う（確かめ
	// 2026-10-20 の反証。前は門の行が先なら G5 だった）。
	["総数：門のある行と、合わせて総数を超える2つの行", [["p : [s] ? 1"], [[...Array(300).keys()].map((i) => `(p [k${i} : 1])`).join(" , ")], [[...Array(300).keys()].map((i) => `(p [j${i} : 1])`).join(" , ")], ["1 _ 2"]], "G7"],
	["総数を超える `?` が2つ（名指しは名前の小さい方）", [["p : [s] ? 1"], ["q : [s] ? 2"], [`a : ${[...Array(513).keys()].map((i) => `(p [k${i} : 1])`).join(" , ")}`], [`b : ${[...Array(513).keys()].map((i) => `(q [k${i} : 1])`).join(" , ")}`]], "G7"],
	["総数：同じ形で自分を引いてから枝ごとに形が増える再帰（作った実体の数の守り）", [["g : [x ~xs] ? (g xs) , (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])"], ["g [1 2]"]], "instance-work-limit"],
];

// 値を含む輪（§5 Q30、resolve.js の「値を含む輪」の注）。値の定義を含む輪は、どこから入っても名前の輪（name-cycle）で断る。
// 前は、値の定義から入れば断り、関数から入れば仮置きで閉じて黙って通った（`a : f 1`・`v : f 1`・`f : x ? v` は、v が先なら
// name-cycle、a が先なら A）。v = f 1 = v で、値はいつまでもできない（利用者 2026-10-20「明らかにそうだと思う」）。法則3 は
// 割れないことを見るので、どの並べ方でも通る形に揃っても落ちない。だから下の守りで、どの並べ方でも name-cycle のことを見る。
// - 1つ目：§5 Q30 の例。2つ目：3つ以上の関数の輪に外から入る（v → g → h → v）。3つ目：括りの関数の実体を通る。4つ目：
//   無名の関数の本体を通る。5つ目：値の定義が2つで、関数を挟む。6つ目：根に使わない所（積の中）で引く。7・8つ目：輪を値の
//   定義の無い所（g → k → g）で先に閉じ、閉じた k の答えが未知（仮置きが外れて未知・門で未知）。未知の記録は仮置きの依りを
//   持たないので、輪の依り（resolve.js の「値を含む輪」の注）が無いと、a が先なら通るか k の門で断り、vk が先なら name-cycle
//   に割れた（HEAD からある）。
// - 9・10 つ目（確かめ 2026-10-20 の Q30-V3・V4）：未知の記録の輪の依りを、閉じた枠から引き継ぐ形（vk → r の記録 → 閉じた m
//   → g）と、未知の記録を読んだ関数がまた未知で閉じ、それを値が読む2段の形（vk → y の記録 → r の記録 → g）。引き継ぎ
//   （finishFrame）か、記録を通るときに上の枠へ依りを足す所（passThrough）が欠けると、a が先なら黙って通った。
// - 11・12 つ目：既定値を覗いた中で見つかる輪。覗いた v の計算の中だけで閉じる輪（vk → k → h → vk）は本物なので投げ直す
//   （11。全部を握りつぶしても、12 の印が見つけ直す）。12 は、覗いた所を通る輪（h → g → 覗き → v）で覗きが抜けた後に残った k の記録（未知）を、例外で抜けた h の枠の分まで
//   解き直す形（resolve.js の「値を含む輪」の注の、例外で抜けた枠）。この印が欠けると、a が先なら黙って通った。
// - 13 つ目：1項の `:` の左（枝の条件）を覗いた所を通る輪。断る側に置いている（§5 Q30 の未決、namesPattern の注）。
// 値を挟まない輪（Q30_PASS_FORMS）は、今までどおり仮置きで閉じ、どの並べ方でも通る。`$` で遅らせた名前は種類を引かない
// ので輪に数えない（今のまま。この片では扱わない）。既定値を覗いた所を通る輪も、種類の輪ではない（既定値は解かない、P3）
// ので通る（HEAD のまま。確かめ 2026-10-20 の Q30-V1・ADV-1）。
const Q30_FORMS = [
	["Q30 値を含む輪（a・v・f）", [["a : f 1"], ["v : f 1"], ["f : x ? v"], ["f 2"]]],
	["Q30 値を含む3つ以上の輪に外から入る", [["a : g 1"], ["v : g 1"], ["g : x ? h x"], ["h : y ? v"], ["g 5"]]],
	["Q30 値を含む輪が括りの関数の実体を通る", [["a : p [1]"], ["v : p [1]"], ["p : [x] ? v"], ["p [2]"]]],
	["Q30 値を含む輪が無名の関数の本体を通る", [["a : f 1"], ["v : [w ? f w] 1"], ["f : x ? v"], ["f 2"]]],
	["Q30 値の定義が2つの輪（関数を挟む）", [["a : f 2"], ["v : f 1"], ["w : v"], ["f : x ? w"], ["f 3"]]],
	["Q30 値を含む輪を根に使わない所で引く", [[INC], ["a : inc f 1"], ["v : (f 1) , 1"], ["f : x ? v"], ["f 2"]]],
	["Q30 未知で閉じた関数の記録を通る輪（仮置きが外れて未知）", [[INC], ["a : g 1"], ["g : x ?", "\tk x", "\tvk", ""], ["k : x ?", "\tg x", "\tk x", "\tinc", ""], ["vk : k 1"]]],
	["Q30 未知で閉じた関数の記録を通る輪（門で未知）", [["a : g 1"], ["g : x ?", "\tk x", "\tvk", ""], ["k : x ?", "\tg x", "\t1 _ 2", ""], ["vk : k 1"], ["g 5"]]],
	["Q30 未知の記録が閉じた枠の輪の依りを引き継ぐ", [[INC], ["a : g 1"], ["g : x ?", "\tm x", "\tvk", ""], ["m : x ?", "\tr x", "\tg x", ""], ["r : x ?", "\tm x", "\tinc", ""], ["vk : r 1"]]],
	["Q30 未知の記録を読んだ関数がまた未知で閉じる（2段）", [[INC], ["a : g 1"], ["g : x ?", "\tr x", "\ty x", "\tvk", ""], ["r : x ?", "\tg x", "\tinc", ""], ["y : x ? r x"], ["vk : y 1"]]],
	["Q30 既定値を覗いた定義の中だけで閉じる輪", [["a : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["v : h 1"], ["h : x ?", "\tk x", "\tvk", ""], ["k : x ?", "\th x", "\t1 _ 2", ""], ["vk : k 1"]]],
	["Q30 既定値の覗きが抜けた後の記録を通る輪", [["a : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["v : h 1"], ["h : x ?", "\tk x", "\tg x", "\tvk", ""], ["k : x ?", "\th x", "\t1 _ 2", ""], ["vk : k 1"]]],
	["Q30 1項の `:` の左を覗いた所を通る輪（未決、断る側）", [["v : (g 1) , 1"], ["g : x ?", "\t(v 2) : 1", ""], ["g 2"]]],
];
const Q30_PASS_FORMS = [
	["Q30 値を挟まない関数どうしの再帰に値の定義から入る", [["a : f 1"], ["f : x ? g x"], ["g : y ? f y"], ["f 2"]]],
	["Q30 `$` で遅らせた自分の名前に外から入る（今のまま）", [["a : f 1"], ["v : f 1"], ["f : x ? x , $v"], ["v"]]],
	["Q30 既定値を覗いた所を通る輪（値はできる）", [["v : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["a : g 2"]]],
	["Q30 既定値が関数で、値の定義を呼ぶ", [["w : 1 , [[z : [u ? v u]] ? z]"], ["v : w"], ["w"]]],
	["Q30 既定値を覗いた所を通る輪に外から入る（覗いた中の枠が抜ける）", [[INC], ["a : g 1"], ["g : x ? [[y : v 2] ? 5] x"], ["v : h 1"], ["h : x ?", "\tk x", "\tg x", "\tinc", ""], ["k : x ?", "\th x", "\tinc", ""]]],
];

const PROGRAMS3 = [
	["合成と括りの関数", [[INC], ["head : [x ~xs] ? x"], ["inc head [5 6 7]"], ["head inc [5 6 7] inc"], ["v : head [1 2]"]]],
	["IO Reader Writer（R24・R26）", [M, ["a : [say] ? say 21"], ["c : [~rest] ? (rest ' say) 21"], ["a m"], ["c m"]]],
	["括りの関数の再帰（形が3つ）", [["f : [x ~xs] ? [f xs] x"], ["f [1 2 3]"], ["f `abc`"], ["f 3"], ["g : y ? f [y y]"]]],
	["括りの関数の部分適用", [["pair : [a ~as] [b ~bs] ? a + b"], ["p1 : pair [1]"], ["p1 [2]"], ["(pair [1]) [2] [3]"], ["pair [1] [2]"]]],
	["素の関数の部分適用を合成の後ろに", [[INC], ["pr : x y ? y"], ["p1 : pr 1"], ["inc p1 5 inc"], ["c : inc p1"]]],
	["穴とその部分適用", [["f3 : a b c ? c"], ["h1 : f3 _ _ 3"], ["h2 : h1 1"], [INC], ["inc h2 5 inc"]]],
	["値の名前の鎖", [["a : b + 1"], ["b : c * 2"], ["c : 3"], ["f : [x ~xs] ? x 1"], ["f [a b c]"]]],
	["合成の値を欄で渡す", [[INC], ["double : x ? x * 2"], ["c2 : inc double"], ["k : [f] ? f 1"], ["k [f : c2]"]]],
	["相互再帰（仮置きが合う）", [["fact : k ? k * [fact k - 1]"], ["ev : k ? od k"], ["od : k ? ev k"], ["fact 5"], ["ev 4"]]],
	["自己再帰の仮置きが外れる（その根を使うのは再帰しない関数だけ）", [[INC], ["r : k ? [+ [r k]]"], ["r 1"], ["inc r 1"], ["g : y ? r y"]]],
	["分け合った実体（R25）", [["pair : [a ~as] [b ~bs] ? a + b"], ["pair2 : [a ~as] [b ~bs] ? a + b"], ["h : [f] ? f [1] [2]"], ["h [f : pair]"], ["h [f : pair2]"]]],
	["呼んだ行の名指し（断る文が1つ）", [M, ["a2 : [nope] ? nope 21"], ["hh : [f] ? f m"], ["v : hh [f : a2]"], [INC]]],
	["欄に入れた部分適用", [[INC], ["pair : [a ~as] [b ~bs] ? a b"], ["call : [f ~r] ? f [2]"], ["m1 :", "\tf : pair [1]", ""], ["call m1"]]],
	["足りたか決まらない頭（Q27）", [["tl : [y ~ys] ? ys"], ["[+] tl 5"], [INC], ["inc tl [1 2]"], ["tl inc [1 2]"]]],
	["引いた物の形を受ける（R26）", [["head : [x ~xs] ? x"], ["w : [[1 2] [3 4]]"], ["[' 0] head w"], ["w ' 0 ' 1"], ["v : head w"]]],
	["字下げのブロックの List", [["f : [x ~xs] ? (x ' 0) 1"], ["w :", "\t1 2", "\t3 4", ""], ["f w"], ["g : [k] ? f k"], ["g [k : w]"]]],
	["未定義の名前の information", [["k : [x ~xs] ? zz x"], ["k [1 2]"], ["say 5"], ["t : y ? zz y"], ["k `ab`"]]],
	["既定値のある関数（Q8）", [["go :", "\t\tys", "\t\tzs : 3", "\t? ys", ""], ["xs : 1 , 2"], ["go xs"], ["tl : [y ~ys] ? ys"], ["go tl xs"]]],
	["実体の中の実体の門（断る文が1つ）", [["p : [x ~xs] ? q x"], ["q : [y] ? y 5"], ["p [1 2]"], ["p [zz zz]"], [INC]]],
	["素の関数の本体の中の括った ?", [M, ["outer : v ? [[say] ? say v] m"], ["outer 21"], ["a : [say] ? say 21"], ["a m"]]],
	["括りの関数の相互再帰", [["ev : [x ~xs] ? od xs"], ["od : [x ~xs] ? ev xs"], ["ev [1 2 3]"], ["od 5"], [INC]]],
	["名前を通す再帰（Q26）", [[INC], ["p1 : rp 1"], ["rp : x y ? inc p1 y"], ["rp 1 2"], ["rp 1 2 inc"]]],
	["余りと残りを受ける括り", [["d : x ? x * 10"], ["d 1 2"], ["tl : [x ~xs] y ? x + y"], ["tl 1 2 3"], ["[tl 1 2 3]"]]],
	["欄の関数を名前で呼ぶ（構造体の構造体）", [["myGreet :", "\tgreet :", "\t\thello : x ? x", "\t\twelcome : x ? x", "\tworld : ` world`", ""], ["greeting : [greet world] ? (greet ' welcome) world"], ["greeting myGreet"], ["w2 : greeting myGreet"]]],
	["同じ綴りの関数（呼ばれない方は defer）", [M, ["a : [say] ? say 21"], ["b : [say] ? say 21"], ["a m"], ["v : [[say] ? say 21] m"]]],
	["別々の括りの関数の鎖", [["p1 : [a ~r] ? p2 r"], ["p2 : [a ~r] ? p3 r"], ["p3 : [a ~r] ? a"], ["p1 [1 2 3]"], ["p2 [4 5]"]]],
	["合成の後ろの括りの関数の門（断る文が1つ）", [["bad : [y ~ys] ? 1 _ 2"], ["tl : [y ~ys] ? ys"], ["[+] tl 5"], ["v : [+] bad 5"], ["tl [1 2]"]]],
	["素の関数の本体の門（断る文が1つ）", [["t : a ? 1 _ 2"], ["t 5"], [INC], ["inc t 5"], ["v : t 5"]]],
	// Q28 の隣：仮置きが外れても、その根を使う本体なら割れない。仮置きが合えば、根に使わない本体でも割れない。
	["相互再帰の仮置きが外れ、根に使う", [["fq : k ? [+ [gq k]]"], ["gq : k ? fq k"], ["gq 1"], [INC], ["inc gq 1"]]],
	["3つの相互再帰の仮置きが外れ、根に使う", [["fq : k ? [+ [gq k] * [hq k]]"], ["gq : k ? fq k"], ["hq : k ? gq k"], ["hq 1"], ["v : gq 1"]]],
	["自己再帰の仮置きが外れ、積の中で自分を引く", [[INC], ["r : k ?", "\t(r k) , 1", "\tinc", ""], ["r 1"], ["g : y ? r y"]]],
	["相互再帰の仮置きが合い、積の中で引く", [[INC], ["f : x y ? (g y) , 1"], ["g : y ? (f 1 y) , 1"], ["g 5 inc"]]],
	["括りの関数の再帰の仮置きが外れ、積の中で引く", [[INC], ["f : [x ~xs] ?", "\t(f xs) , 1", "\tinc", ""], ["f [1 2]"], ["g : y ? (f [y]) , 1"], ["g 5 inc"]]],
	...Q28_FORMS,
	...Q28_REFUSE_FORMS,
	...DEPTH_FORMS.map(([name, units]) => [name, units]),
	...TOTAL_FORMS.map(([name, units]) => [name, units]),
	...Q30_FORMS,
	...Q30_PASS_FORMS,
];

// 文の全部の並べ方（文の番号の並び）。
const permutations = (n) => {
	const out = [];
	const go = (rest, acc) => {
		if (!rest.length) out.push(acc);
		rest.forEach((u, i) => go([...rest.slice(0, i), ...rest.slice(i + 1)], [...acc, u]));
	};
	go([...Array(n).keys()], []);
	return out;
};
// 並べ方 order で解いて、文の番号ごとの木に戻した見え方。
const orderedView = (units, order) => {
	const o = outcome(src(order.flatMap((i) => units[i])));
	if (o.crash) return { text: `例外 ${o.crash}` };
	if (o.refused) return { text: `断り ${refusalText(o)}`, refused: true };
	if (o.trees.length !== units.length) return { text: `木の数 ${o.trees.length} が文の数 ${units.length} と違う` };
	const byUnit = [];
	order.forEach((u, j) => {
		const t = o.trees[j];
		byUnit[u] = `${t.text} : ${t.kind}${t.excess ? "（excess）" : ""}`;
	});
	return { text: `${byUnit.join(" | ")} || ${o.diag.join(" ")}`, inst: byUnit.some((t) => t.includes("(inst ")) };
};

law("3 文の並べ方を全部変えても、文ごとの木・種類・診断・門と名指しが同じ", () => {
	const problems = [];
	let nOrders = 0;
	let nRefused = 0;
	let nInst = 0;
	for (const [name, units] of PROGRAMS3) {
		const all = permutations(units.length);
		const first = orderedView(units, all[0]);
		if (first.text.startsWith("例外") || first.text.startsWith("木の数")) problems.push(`${name}：${first.text}`);
		if (first.refused) nRefused++;
		if (first.inst) nInst++;
		for (const order of all) {
			nOrders++;
			const got = orderedView(units, order);
			if (got.text !== first.text) {
				problems.push(`${name}：並べ方で割れた`, `  ${all[0].map((i) => units[i][0]).join(" ⏎ ")}`, `    ${first.text}`, `  ${order.map((i) => units[i][0]).join(" ⏎ ")}`, `    ${got.text}`);
				break;
			}
		}
	}
	// 断るプログラムと、括りの関数の実体を作るプログラムが無ければ、法則は門と inst の順を見ていない。
	if (!nRefused || !nInst) problems.push(`断るプログラム ${nRefused}・実体のあるプログラム ${nInst}（どちらも1つ以上のはず）`);
	return { problems, note: `プログラム ${PROGRAMS3.length}・並べ方 ${nOrders}（断る ${nRefused}・実体のある ${nInst}）` };
});

// §5 Q28 の守り。Q28 の形が割れないことは法則3 が見る（PROGRAMS3 に入れた）。だが割れないだけなら、どの並べ方でも断る形に
// 揃っても通ってしまう（前の実装で f を先に解いた答え。外れた仮置きに頼った答えを全部未知に替える作りに戻すと、こうなりうる）。
// どの形でも g の本体の根は積（`(…) , 1`）なので、f の根に依らず A。だから `g 5 inc` は、§3.4 の素の関数（本体の根が A）の
// k = n で A になり、`inc` の逆適用（R12）も A である。ここでは、どの並べ方でも呼ぶ行（最後の文）が通って A のことを見る。
// 前は「今は割れる」の名簿で、割れなくなったら落ちる守りだった（2026-10-20 に解き直しへ作り直して裏返した）。
law("3 の守り §5 Q28 の形は、どの並べ方でも呼ぶ行が A（外れた仮置きに頼った答えは解き直す）", () => {
	const problems = [];
	let nOrders = 0;
	for (const [name, units] of Q28_FORMS) {
		const call = units.length - 1;
		for (const order of permutations(units.length)) {
			nOrders++;
			const o = outcome(src(order.flatMap((i) => units[i])));
			const t = o.trees && o.trees[order.indexOf(call)];
			if (!t || t.kind !== "A") {
				problems.push(`${name}：${order.map((i) => units[i][0]).join(" ⏎ ")}`, `  ${t ? `${t.text} : ${t.kind}` : brief(o)}`);
				break;
			}
		}
	}
	return { problems, note: `形 ${Q28_FORMS.length}・並べ方 ${nOrders}` };
});

// §5 Q30 の守り。値を含む輪（Q30_FORMS）は、どの並べ方でも名前の輪（name-cycle）で断る。値を挟まない輪と、既定値を覗いた
// 所を通る輪（Q30_PASS_FORMS）は、どの並べ方でも通る。法則3 は割れないことだけを見るので、どちらかに揃っても落ちない。
law("3 の守り §5 Q30 値を含む輪は、どの並べ方でも name-cycle（値を挟まない輪は通る）", () => {
	const problems = [];
	let nOrders = 0;
	const cycles = Q30_FORMS;
	for (const [name, units] of cycles) {
		for (const order of permutations(units.length)) {
			nOrders++;
			const o = outcome(src(order.flatMap((i) => units[i])));
			if (!o.refused || o.refused.reason !== "name-cycle") {
				problems.push(`${name}：${order.map((i) => units[i][0]).join(" ⏎ ")}`, `  ${brief(o)}`);
				break;
			}
		}
	}
	for (const [name, units] of Q30_PASS_FORMS) {
		for (const order of permutations(units.length)) {
			nOrders++;
			const o = outcome(src(order.flatMap((i) => units[i])));
			if (o.refused || o.crash) {
				problems.push(`${name}：${order.map((i) => units[i][0]).join(" ⏎ ")}`, `  ${brief(o)}`);
				break;
			}
		}
	}
	return { problems, note: `断る形 ${cycles.length}・通る形 ${Q30_PASS_FORMS.length}・並べ方 ${nOrders}` };
});

// §5 Q28 の守り（関数の多い相互再帰）。f0 … f(n−1) は、どれもブロックの行でほかの f と g を呼び、最後の行 `inc`（L）で仮置きが
// 外れる。g の根は f を全部呼ぶ積なので A（上の守りと同じ理由で `g 5 inc` は A）。外れが入れ子になり、同じ記録（g）を何度も
// 解き直す。前は未知の答えにも古いと印を付けたので、解き直しが関数の数の指数で増え（関数5つで g が 31 回）、16 回の上限で
// 未知に固定して、f を先に置くと G2(a) に割れた（確かめ 2026-10-20 の Q28V-1・F2）。今は解き直しが関数の数で収まる（resolve.js
// の「仮置きの記録」の注）。関数が多いので並べ方は全部は回さず、f を全部 g より先に置く物と、g を先に置く物の2つを見る。
// 形：後ろの f を全部呼ぶ（full）、次の f だけ（chain。17 個は前の上限 16 を超える）、輪（cycle）、次と次の次と頭（two）、
// 全部（all）。
const deepQ28 = (shape, n, gFirst) => {
	const F = [...Array(n).keys()].map((i) => `f${i}`);
	const rows = (i) =>
		shape === "full" ? F.slice(i + 1)
		: shape === "chain" ? F.slice(i + 1, i + 2)
		: shape === "cycle" ? [F[(i + 1) % n]]
		: shape === "two" ? [...F.slice(i + 1, i + 3), F[0]]
		: F;
	const defs = F.map((f, i) => [`${f} : x ?`, ...rows(i).map((h) => `\t${h} x`), "\tg x", "\tinc", ""]);
	const g = [`g : y ? ${F.map((f) => `(${f} y)`).join(" , ")} , 1`];
	return [[INC], ...(gFirst ? [g, ...defs] : [...defs, g]), ["g 5 inc"]];
};
const DEEP_Q28 = [["full", 5], ["chain", 17], ["cycle", 9], ["two", 5], ["all", 5]];
law("3 の守り §5 Q28 の関数の多い相互再帰でも、f が先でも g が先でも呼ぶ行が A（解き直しは関数の数で収まる）", () => {
	const problems = [];
	for (const [shape, n] of DEEP_Q28) {
		for (const gFirst of [false, true]) {
			const o = outcome(src(deepQ28(shape, n, gFirst).flat()));
			const t = o.trees && o.trees[o.trees.length - 1];
			if (!t || t.kind !== "A") problems.push(`${shape} ${n}（${gFirst ? "g が先" : "f が先"}）`, `  ${t ? `${t.text} : ${t.kind}` : brief(o)}`);
		}
	}
	return { problems, note: `形 ${DEEP_Q28.length}・並べ方 ${DEEP_Q28.length * 2}` };
});

// 実体の守りの境目（DEPTH_FORMS・TOTAL_FORMS の頭の注）。法則3 は割れないことだけを見るので、どの並べ方でも通るか、どの
// 並べ方でも断るかに揃っても落ちない。ここでは、どの並べ方でも決めた答え（通る・G7 で断る）のことを見る。
law("3 の守り 実体の深さと総数の境目は、どの並べ方でも決めた答え（通る・G7）", () => {
	const problems = [];
	let nOrders = 0;
	for (const [name, units, want] of [...DEPTH_FORMS, ...TOTAL_FORMS]) {
		for (const order of permutations(units.length)) {
			nOrders++;
			const o = outcome(src(order.flatMap((i) => units[i])));
			const good = want === "通る" ? !!o.trees : !!o.refused && (want === "G7" ? o.refused.gate === "G7" : o.refused.reason === want);
			if (!good) {
				problems.push(`${name}：${order.map((i) => units[i][0].slice(0, 40)).join(" ⏎ ")}`, `  ${brief(o)}  want: ${want}`);
				break;
			}
		}
	}
	return { problems, note: `形 ${DEPTH_FORMS.length + TOTAL_FORMS.length}・並べ方 ${nOrders}` };
});

// 実体の深さの守り（resolve.js の INSTANCE_DEPTH_LIMIT の注の1、2026-10-20 の自己点検の SC-1）。素の関数 f0 … f(n−1) が、
// 括りの関数 hb に次の関数を欄で渡す鎖（f(n−1) は値を返す）。hb の形はどれも {s:L}（f1 … はファイルの定義なので深さ 1 の
// 葉）で、深くならない。f0 の根＝hb の実体の根＝f1 の根＝…＝f(n−1) の根＝A（§3.4）なので、`f0 5 inc` は A。前の守りは同じ
// `?` の実体の入れ子を数え、積んだ枠の hb の実体を全部数えたので、f0 を先に置くと 34 個の関数で 32 段に数えて f0 の根が
// 黙って未知になり（G2(a)）、逆順なら A だった。関数が多いので並べ方は全部は回さず、4つを見る。
const hbChain = (n, order) => {
	const F = [...Array(n).keys()].map((i) => [i < n - 1 ? `f${i} : x ? hb [s : f${i + 1}]` : `f${i} : x ? x + 1`]);
	const idx = [...Array(n).keys()];
	const ord =
		order === "fwd" ? idx
		: order === "rev" ? [...idx].reverse()
		: order === "evens" ? [...idx.filter((i) => i % 2 === 0), ...idx.filter((i) => i % 2 === 1)]
		: [...idx.slice(n >> 1), ...idx.slice(0, n >> 1)];
	return [[INC], ["hb : [s] ? s 1"], ...ord.map((i) => F[i]), ["f0 5 inc"]];
};
law("3 の守り 素の関数を挟む括りの関数の鎖は、どの並べ方でも呼ぶ行が A（実体の入れ子に数えない）", () => {
	const problems = [];
	let nOrders = 0;
	for (const n of [34, 40]) {
		for (const order of ["fwd", "rev", "evens", "half"]) {
			nOrders++;
			const o = outcome(src(hbChain(n, order).flat()));
			const t = o.trees && o.trees[o.trees.length - 1];
			if (!t || t.kind !== "A") problems.push(`${n} 個（${order}）`, `  ${t ? `${t.text} : ${t.kind}` : brief(o)}`);
		}
	}
	return { problems, note: `並べ方 ${nOrders}` };
});

// ---------------------------------------------------------------------------
// 法則4：括りの関数は、括りを外した素の関数と同じ（括りの受け方を除いて、R24）
// ---------------------------------------------------------------------------
//
// 比べる2つの綴り：本体が同じで、仮引数の括りを外して括りの最初の名前を裸の名前にした素の関数（`h : [x ~xs] ? x + 1` と
// `h : x ? x + 1`、`h : [a ~as] [b] ? a + b` と `h : a b ? a + b`）。同じ名前 h で定義し、同じ呼ぶ行で呼ぶ。実引数は数
// （数の字面・`[5]`・`-3`・`1 + 2`・数の名前・文字・`0r18`）。
//
// なぜ同じか：
// - アリティ：R24「括りは1つで1と数える」（U [2026-08-07 22:43 e668bc95]「ブラケットでくくる場合は、参照を取るから
//   アリティが1に変わるね。」）ので、括りを外しても仮引数の数は同じ。
// - 名前：R24「数…長さ1の List として受ける（`[x]≅x`）。裸の名前はその数」（U〔答え〕2026-10-19「それでいいはずだよ」）
//   なので、括りの名前は数で、裸の仮引数と同じ A。
// - 当て方：§3.4 の括りの関数の行が、素の関数と同じと言う。k = n は「実体の本体の根が A なら A、ほかは未知（§3.4 の素の
//   関数の k = n と同じ）」（R24）、k < n は「素の関数と同じく部分適用」、最後の仮引数が裸の k > n は「素の関数と同じく前から
//   n 個を当て、本体の根が A なら A で印 `excess`、A でなければ G12(b)」。
//
// 何を同じと見るか：h の定義の行のほかの全部の行の木と種類と余りの印、診断。断るなら門（reason と番号）。名指しは比べない：
// 素の関数の本体は定義の行で解いて断り（R25 の理由「素の関数は…実体は定義の所で1つに決まる」）、名指しは無い。括りの
// 関数は呼んだ行で名指しする（R25）。
//
// 比べの外（違ってよい所）：
// - 括りが残りの並びを受ける所：最後の仮引数が括りの k > n（R24。素の関数なら余り）。
// - 括りの名前が受ける形で決まる所：数でない実引数（構造体・List・関数・中身の見えない A）と、`~rest` の名前（数から受けても
//   同じ要素の List、R24）。合成の後ろ（`inc h 5`）も、前の結果が中身の見えない A なので、括りの名前は未知になる。数を引いて
//   渡す `[' 0] h [5 6]` は比べる。数の名前（N）と裸の仮引数（中身の見えない A）は、種類は同じ A だが、別の括りの関数に渡すと
//   受ける側の名前の生まれが違う（`[x x]` は [N…] と [A…]）。だから本体で名前を別の括りの関数に渡す形は入れない（自分を
//   呼ぶ再帰 `x * [h x - 1]` は入れる：括りの側は自分の括りに数を、素の側は自分の裸の仮引数に渡すので、どちらも A）。
// - 呼ばれない本体：足りない適用で止まった括りの関数は実体を作らず、本体を読まない（R25、R24「pair [1] だけでは実体を
//   作らない」）。素の関数は定義の所で本体を解く。だから足りない適用だけの行は、素の関数の本体が通るなら同じと見る。素の
//   関数の本体が断るなら、括りの関数は h を名指しして断らず、通るなら h の定義の行が defer のままであることを見る（足りない
//   適用の門 G2(b) は本体に依らないので、断ってよい）。
// - 逆適用の右（`5 h`）と穴の頭（`h _`）：R12 は逆適用の右を「アリティ1の素の関数」に限り、穴は素の関数だけ（R16、
//   U〔答え〕10-14 22:23「括りの仮引数の関数では `_` は穴ではない」）。括りの関数は G8・G5 で断るので入れない。

const DEFS4 = [INC, "add : x y ? x + y", "yn : 3"];
const ARGS4 = ["5", "[5]", "-3", "1 + 2", "yn", "\\a", "0r18"];
// 1引数の本体（名前 x）と2引数の本体（名前 a・b）。h は自分を呼ぶ再帰。配列は字下げのブロックの本体（`?` の後ろの行）。
const BODIES4_1 = [
	"x + 1",
	"x 1",
	"x",
	"inc x",
	"x inc",
	"[+ x]",
	"[|] x",
	"inc",
	"1 _ 2",
	"x , 1",
	"[x 1]",
	"(x ' 0) 1",
	"x * [h x - 1]",
	"-x",
	"x 1 inc",
	"@x 1",
	"x~ 1",
	"$x 1",
	"x == 1",
	"[y ? y + x] 1",
	"add _ x",
	"_ x",
	["\tx < 0 : 0 - x", "\tx"],
	["\tinc x", "\tinc"],
];
const BODIES4_2 = ["a + b", "a b", "b", "add a b", "a inc", "[+ a]", "[|] a", "inc", "1 _ 2", "a , b", "[a b]", "a * [h a b - 1]", "(a ' 0) b", "add a b inc", "[y ? a + y] b", ["\ta < b : a", "\tb"]];
// h の定義の行（字下げのブロックの本体は、空の行で閉じる）。どちらも木は1つ。
const hDef = (params, body) => (Array.isArray(body) ? [`h : ${params} ?`, ...body, ""] : [`h : ${params} ? ${body}`]);
// [括りの関数の仮引数, 素の関数の仮引数, アリティ, 最後の仮引数が裸か]
const SHAPES4 = [
	["[x]", "x", 1, false],
	["[x ~xs]", "x", 1, false],
	["[a] [b]", "a b", 2, false],
	["[a ~as] [b ~bs]", "a b", 2, false],
	["[a ~as] b", "a b", 2, true],
	["a [b]", "a b", 2, false],
];
// 呼ぶ形：[名前, 行を作る関数, 足りない適用だけか]。行の頭が h の定義の後ろに並ぶ。
const CALLS4_1 = [
	["根", (a) => [`h ${a}`]],
	["逆適用の左", (a) => [`h ${a} inc`]],
	["合成の頭", (a) => [`h inc ${a}`]],
	["数を引いて合成の後ろへ", (a) => [`[' 0] h [${a} 6]`]],
	["構築", (a) => [`1 h ${a}`]],
	["括りの中", (a) => [`[h ${a}] inc`]],
	["括りを実引数に", (a) => [`inc (h ${a})`]],
	["積", (a) => [`(h ${a}) , 1`]],
	["値の定義", (a) => [`v : h ${a}`, "v inc"]],
	["素の関数の本体", (a) => [`t : u ? h ${a}`, "t 1 inc"]],
];
const CALLS4_2 = [
	["根", (a) => [`h ${a} ${a}`]],
	["逆適用の左", (a) => [`h ${a} ${a} inc`]],
	["合成の頭", (a) => [`h inc ${a} ${a}`]],
	["括りの部分適用", (a) => [`(h ${a}) ${a}`]],
	["名前の部分適用", (a) => [`p : h ${a}`, `p ${a}`]],
	["構築", (a) => [`1 h ${a} ${a}`]],
	["括りの中", (a) => [`[h ${a} ${a}] inc`]],
	["素の関数の本体", (a) => [`t : u ? h ${a} ${a}`, "t 1 inc"]],
	["足りない適用だけ", (a) => [`h ${a}`], true],
	["足りない適用を合成に", (a) => [`h ${a} inc`], true],
	["足りない適用を含む合成が頭（G2(b)）", (a) => [`h ${a} inc ${a}`], true],
];
// 最後の仮引数が裸なら、k > n も比べる（どちらも前から n 個を当てて余り）。
const CALLS4_EXCESS = [
	["余り", (a) => [`h ${a} ${a} ${a}`]],
	["余りが対に入る", (a) => [`h ${a} ${a} ${a} inc`]],
];

law("4 括りの関数と、括りを外した素の関数は、数を渡せば同じ読み", () => {
	const problems = [];
	const count = { 通る: 0, 断る: 0, "呼ばれない本体（R25）": 0 };
	const hAt = DEFS4.length;
	let turn = 0;
	for (const [bp, pp, n, lastBare] of SHAPES4) {
		const bodies = n === 1 ? BODIES4_1 : BODIES4_2;
		const calls = n === 1 ? CALLS4_1 : [...CALLS4_2, ...(lastBare ? CALLS4_EXCESS : [])];
		for (const body of bodies) {
			for (const [callName, call, partialOnly] of calls) {
				// 実引数は決まった順に回す（全部の組を作ると多すぎるので、呼ぶ形ごとに1つ）。
				const a = ARGS4[turn++ % ARGS4.length];
				const lines = call(a);
				const bracket = outcome(src([...DEFS4, ...hDef(bp, body), ...lines]));
				const plain = outcome(src([...DEFS4, ...hDef(pp, body), ...lines]));
				const bodyText = Array.isArray(body) ? `⏎ ${body.map((l) => l.trim()).join(" ⏎ ")}` : body;
				const label = `${callName}：h : ${bp} ? ${bodyText}  ⇔  h : ${pp} ? ${bodyText}  で  ${lines.join(" ⏎ ")}`;
				if (bracket.crash || plain.crash) {
					problems.push(label, `  括り: ${brief(bracket)}`, `  素: ${brief(plain)}`);
					continue;
				}
				if (partialOnly && outcome(src([...DEFS4, ...hDef(pp, body)])).refused) {
					// 素の関数は本体を定義の所で解いて断る。括りの関数は呼ばれないので本体を読まない（R25）：h を名指しして断らず、
					// 通るなら h の定義の行は defer のまま（足りない適用の門 G2(b) などは、本体に依らないので断ってよい）。
					count["呼ばれない本体（R25）"]++;
					if (bracket.refused ? bracket.refused.inst.some(([fn]) => fn === "h") : !bracket.trees[hAt].text.includes("(defer ")) {
						problems.push(label, `  呼ばれない括りの関数の本体を読んだ: ${bracket.refused ? brief(bracket) : bracket.trees[hAt].text}`);
					}
					continue;
				}
				const view = (o) => {
					if (o.refused) return `断り ${o.refused.reason} ${o.refused.gate}`;
					return `${o.trees
						.map((t, i) => (i === hAt ? "（h の定義）" : `${t.text} : ${t.kind}${t.excess ? "（excess）" : ""}`))
						.join(" | ")} || ${o.diag.join(" ")}`;
				};
				const vb = view(bracket);
				const vp = view(plain);
				if (vb !== vp) problems.push(label, `  括り: ${vb}`, `  素: ${vp}`);
				if (bracket.refused) count.断る++;
				else count.通る++;
			}
		}
	}
	for (const [k, v] of Object.entries(count)) if (!v) problems.push(`「${k}」の組が無い（法則がその枝を見ていない）`);
	return { problems, note: `比べた組 ${Object.values(count).reduce((x, y) => x + y, 0)}：${Object.entries(count).map(([k, v]) => `${k} ${v}`).join("・")}` };
});

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
