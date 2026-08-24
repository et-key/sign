/**
 * **ストリームを返す関数を、引ける規則へ均す（糖衣）。**
 *
 * Sign にループは無く再帰しかないので、列を作る関数はどれもこの形になる：
 *
 *     sep : [c ~rest] ?
 *         c = escape : c (rest ' 0) (sep (rest ' 1~))
 *         infix1 c   : space c space (sep rest)
 *         c (sep rest)
 *
 * どの枝も「**有限個の要素**を並べて、最後に自分（か仲間）をもう一度呼ぶ」形である。
 * つまり枝は状態機械の1状態であり、列全体は
 *
 *     カーソル = (どの枝か, 枝の中で何番目か, 残りの入力)
 *
 * で表せる。要素はどこにも置かれない——`k` 番目を訊かれたときに計算するだけである。
 * これは規則（レンジ）が `start + i × step` で引けるのと同じことで、**器を作るのでは
 * なく引ける規則を作る**という一つの答えの、一般形にあたる。
 *
 * ここが返すのは **Sign のソース**である。糖衣だと言うからには、何へ均したのかを目で
 * 読めなければならない。生成されるのは4つ：
 *
 *     f_arm  : 入力 ?        どの枝か（元のガード列そのまま）
 *     f_len  : a ?           その枝が並べる要素の個数
 *     f_at   : a k 入力 ?    枝 a の k 番目の要素
 *     f_next : a 入力 ?      枝 a を終えたあとの入力
 *
 * **実行時ディスパッチは要らない。** 枝は番号であって関数ポインタではないので、
 * `f_at` の中身はただの分岐である（type_system.md §4 の単相化と衝突しない）。
 */


// 並置（連接）で列を伸ばす演算。どれも「左辺が器」で左結合である（list_model.md §2.2）。
const JOIN_OPS = new Set(["construct", "push", "unshift", "concat", "product"]);

function isIdent(n) {
	return !!n && n.type === "atom" && n.kind === "identifier";
}
function bare(name) {
	return typeof name === "string" ? name.replace(/^<|>$/g, "") : name;
}
// `(...)` の1枚皮を剥ぐ。連接の項は括弧に包まれて来ることが多い。
function unparen(n) {
	while (n && (n.type === "paren" || n.type === "block") && Array.isArray(n.lines) && n.lines.length === 1) n = n.lines[0];
	return n;
}
function isApply(n) {
	return !!n && n.type === "operation" && (n.name === "apply" || n.name === "partial_apply");
}
// 適用の根と引数列。`f a b` は `apply(apply(f, a), b)` として来る。
function applyChain(n) {
	const args = [];
	let cur = n;
	while (isApply(cur)) {
		args.unshift(cur.right);
		cur = cur.left;
	}
	return { base: cur, args };
}

/**
 * 連接の連なりを項の列へ均す。`a b (f x)` は `construct(construct(a, b), paren(...))`
 * として来るので、左へ降りながら右を集める。
 */
function joinItems(node) {
	const out = [];
	let cur = node;
	while (cur && cur.type === "operation" && JOIN_OPS.has(cur.name)) {
		out.unshift(cur.right);
		cur = cur.left;
	}
	out.unshift(cur);
	return out;
}

/**
 * 1つの枝を読む。**最後の項が仲間への呼び出しなら**、それはストリームの枝である。
 * @returns {{prefix: Node[], call: {name, args}}|null}
 */
function readArm(body, group) {
	const items = joinItems(body).map(unparen);
	if (items.length < 2) {
		// 項が1つでも、それが仲間への呼び出しなら「何も並べずに続く」枝である。
		const only = items[0];
		if (isApply(only)) {
			const { base, args } = applyChain(only);
			if (isIdent(base) && group.has(bare(base.value))) return { prefix: [], call: { name: bare(base.value), args } };
		}
		return null;
	}
	const last = items[items.length - 1];
	if (!isApply(last)) return null;
	const { base, args } = applyChain(last);
	if (!isIdent(base) || !group.has(bare(base.value))) return null;
	return { prefix: items.slice(0, -1), call: { name: bare(base.value), args } };
}

/**
 * 関数定義からストリームの枝を取り出す。読めない枝が1つでもあれば諦める——
 * **半分だけ均すと、どちらの規則で読むべきかが式ごとに変わる**ことになる。
 * @returns {{name, params, arms: [{guard, prefix, call}]}|null}
 */
function readStreamFunction(node, group) {
	if (!node || node.type !== "operation" || node.name !== "define" || !isIdent(node.left)) return null;
	const lam = node.right;
	if (!lam || lam.type !== "operation" || lam.name !== "lambda") return null;
	const name = bare(node.left.value);
	const body = lam.right;
	// 分岐の無い1枝ものと、インデントブロックの多枝ものの両方を扱う。
	const lines = Array.isArray(body && body.lines) ? body.lines : [body];
	const arms = [];
	for (const line of lines) {
		const guarded = line && line.type === "operation" && line.name === "define";
		const value = guarded ? line.right : line;
		const arm = readArm(value, group);
		if (!arm) return null;
		arms.push({ guard: guarded ? line.left : null, ...arm });
	}
	if (arms.length === 0) return null;
	// ガードの無い枝は最後の1つだけ（それより後ろは届かない）。
	for (let i = 0; i < arms.length - 1; i++) if (!arms[i].guard) return null;
	// **並べる要素が1つも無ければ、それは列ではない。** `preprocess : s ? sep (mark s)` は
	// ただの末尾呼び出しであり、状態機械の枝ではない——ここを混ぜると、ふつうの関数まで
	// カーソルへ均そうとしてしまう。
	if (!arms.some((a) => a.prefix.length > 0)) return null;
	// **要素そのものが構築なら均せない。**
	//
	// `space (c (rest ' 0) (rest ' 1)) space` の真ん中は**1つの要素**であって3つでは
	// ない——括弧が意味を変えており、`a (b c) d` は `["a","bc","d"]` になる（余積は
	// 「右辺を1要素として足す」）。平らにすると答えが変わるので、勝手に平らにはできない。
	// かといってそのまま `_at` の返値にすると、複数文字の器をその場で作ることになる。
	// **どちらも黙ってやってはいけない**ので、この形は均さない。
	if (arms.some((a) => a.prefix.some((p) => p && p.type === "operation" && JOIN_OPS.has(p.name)))) return null;
	// **次の状態の形は枝によらず同じでなければならない。** 引数の本数が枝ごとに違うなら
	// カーソルの形が決まらない。
	const arity = arms[0].call.args.length;
	if (arms.some((a) => a.call.args.length !== arity)) return null;
	return { name, paramNode: lam.left, arms, arity };
}

/** 定義の名前を集める。相互再帰の群を判定するのに使う。 */
function definedNames(nodes) {
	const out = new Set();
	for (const n of nodes) {
		if (n && n.type === "operation" && n.name === "define" && isIdent(n.left)) out.add(bare(n.left.value));
	}
	return out;
}

/**
 * ストリームを返す関数を全部見つける。
 *
 * 群は「互いを呼び合う定義の集まり」だが、まずは**定義されている名前すべて**を候補に
 * して読んでみて、読めたものだけを採る——読めることそのものが「枝の形をしている」
 * という証拠なので、群の判定を先にやる必要が無い。
 */
function findStreamFunctions(nodes) {
	const group = definedNames(nodes);
	const found = [];
	for (const n of nodes) {
		const f = readStreamFunction(n, group);
		if (f) found.push(f);
	}
	return found;
}

/**
 * **AST を Sign のソースへ戻す。**
 *
 * 糖衣だと言うからには、何へ均したのかを目で読めなければならない。生成した規則を
 * 文字列で吐いて、それを**もう一度同じパイプラインへ通す**——手で書いたコードと
 * 同じ道を通るので、生成側だけが通る抜け道が生まれない。
 *
 * 読めない形に当たったら `null` を返す。**半分だけ印字するくらいなら諦める**方がよい
 * ——生成したものが元と違う意味になっていても、見た目では分からないからである。
 */

// 並置（連接・適用）は記号が空白なので、項の間に空白1つだけを置く。
function printNode(n) {
	if (!n || typeof n !== "object") return null;
	if (n.type === "atom") {
		if (n.kind === "identifier") return bare(n.value);
		return String(n.value);
	}
	if (n.type === "operation") {
		if (n.position === "prefix") {
			const o = printNode(n.operand);
			return o === null ? null : `${n.op}${o}`;
		}
		if (n.position === "postfix") {
			const o = printNode(n.operand);
			return o === null ? null : `(${o})${n.op}`;
		}
		const l = printNode(n.left);
		const r = printNode(n.right);
		if (l === null || r === null) return null;
		// 並置は記号が空白1つ。それ以外は記号の両側に空白を置く（中置は空白で区切る）。
		return n.op === " " ? `(${l} ${r})` : `(${l} ${n.op} ${r})`;
	}
	// ブロックは1行ものだけ扱う。複数行のブロックが式の位置に来る形は、ここでは諦める。
	if (Array.isArray(n.lines)) {
		if (n.lines.length !== 1) return null;
		const inner = printNode(n.lines[0]);
		return inner === null ? null : `(${inner})`;
	}
	return null;
}

/**
 * 仮引数リストを印字する。**ブラケットの有無で意味が変わる**——`[c ~rest]` は
 * 「1つの器を受けて分解する」、`c ~rest` は「先頭と可変長」であり、同じ entries でも
 * 別物である（`bracket`）。デフォルト値と入れ子のパターンはまだ印字しない。
 */
function printParams(p) {
	if (!p) return null;
	if (p.type === "atom") return bare(p.value);
	if (p.type !== "params") return null;
	const parts = [];
	for (const e of p.entries || []) {
		if (e.pattern || e.default) return null;
		if (!e.name) return null;
		parts.push((e.rest ? "~" : "") + bare(e.name));
	}
	if (parts.length === 0) return null;
	return p.bracket ? `[${parts.join(" ")}]` : parts.join(" ");
}

/**
 * **群をまたいで枝に通し番号を振る。**
 *
 * 枝は「どの関数のどの枝か」で決まるが、カーソルが持つのは番号1つで足りる——`sep` の
 * 枝から `in_quote` の枝へ移ることがあるので、関数ごとに振り直すと移った先が言えない。
 * 群の名前は最初の関数の名前を借りる（相互再帰では順序だけが根拠なので、決め方を
 * 一つにしておく）。
 */
function numberArms(funcs) {
	const armIndex = new Map(); // "関数名#枝番" → 通し番号
	const flat = [];
	for (const f of funcs) {
		f.arms.forEach((a, i) => {
			armIndex.set(`${f.name}#${i}`, flat.length);
			flat.push({ owner: f, local: i, ...a });
		});
	}
	return { armIndex, flat };
}

/**
 * ストリームを返す関数の群を、**引ける規則**へ均した Sign のソースへ変換する。
 *
 * 出るのは5種類。どれもただの分岐であって、実行時ディスパッチはどこにも無い。
 *
 *     <f>_arm : 入力 ?        どの枝か（元のガード列そのまま）
 *     <g>_len : a ?           枝 a が並べる要素の個数
 *     <g>_at  : a k 入力 ?    枝 a の k 番目の要素
 *     <g>_nx  : a 入力 ?      枝 a を終えたあとの入力
 *     <g>_na  : a 入力 ?      枝 a を終えたあとの枝番号
 *
 * `_at` と `_nx` は枝ごとの小さな関数へ振り分ける。入力を**丸ごと**受けて、分解は
 * 振り分けられた先でやる——`[c ~rest]` で受けてから器を組み直すのは、参照を分解した
 * ものを足し合わせることであり、確保が要る。丸ごと渡せば要らない。
 *
 * @returns {{source: string, group: string, names: object}|null} 印字できなければ null
 */
function generatePullers(funcs, opts = {}) {
	if (!funcs || funcs.length === 0) return null;
	// 状態が1つの器で表せる形だけを扱う。複数の値を持ち回る枝（`walk`）はカーソルが
	// 太るので、まだここでは均さない。
	if (funcs.some((f) => f.arity !== 1)) return null;
	// **群は閉じていなければならない。** 枝が移る先の関数が均されていなければ、その枝の
	// `_na` は存在しない名前へ跳ぶ。片方だけ均すのは、跳び先を失うことである。
	const known = new Set(funcs.map((f) => f.name));
	for (const f of funcs) {
		for (const a of f.arms) if (!known.has(a.call.name)) return null;
	}
	const pre = opts.prefix || "";
	const group = pre + funcs[0].name;
	const { armIndex, flat } = numberArms(funcs);
	const out = [];
	const bad = (why) => {
		out.length = 0;
		out.push(why);
		return null;
	};

	// --- どの枝か。ガード列はそのまま写す ---
	for (const f of funcs) {
		const ps = printParams(f.paramNode);
		if (ps === null) return null;
		const lines = [`${pre}${f.name}_arm : ${ps} ?`];
		for (let i = 0; i < f.arms.length; i++) {
			const a = f.arms[i];
			const n = armIndex.get(`${f.name}#${i}`);
			if (!a.guard) {
				lines.push(`\t${n}`);
				continue;
			}
			const g = printNode(a.guard);
			if (g === null) return null;
			lines.push(`\t${g} : ${n}`);
		}
		out.push(lines.join("\n"));
	}

	// --- 枝ごとの「k 番目」と「次の入力」 ---
	for (let n = 0; n < flat.length; n++) {
		const a = flat[n];
		const ps = printParams(a.owner.paramNode);
		if (ps === null) return null;
		// k 番目。要素が1つなら分岐は要らない。
		const elems = a.prefix.map(printNode);
		if (elems.some((e) => e === null)) return null;
		if (elems.length === 0) {
			// 何も並べない枝。引かれることは無いが、形を揃えておく（`_len` が 0 を返す）。
			out.push(`${group}_at${n} : k ${ps} ? __`);
		} else if (elems.length === 1) {
			out.push(`${group}_at${n} : k ${ps} ? ${elems[0]}`);
		} else {
			const lines = [`${group}_at${n} : k ${ps} ?`];
			for (let i = 0; i < elems.length - 1; i++) lines.push(`\tk = ${i} : ${elems[i]}`);
			lines.push(`\t${elems[elems.length - 1]}`);
			out.push(lines.join("\n"));
		}
		// 次の入力。再帰呼び出しの実引数がそれである。
		const nx = printNode(a.call.args[0]);
		if (nx === null) return null;
		out.push(`${group}_nx${n} : ${ps} ? ${nx}`);
	}

	// --- 振り分け。ただの分岐であって、跳び先は静的に決まっている ---
	// **どの枝も番号で選ぶ。最後の枝も条件を書く。**
	//
	// 既定の枝（条件なし）にすると、枝が1つのときに `a` が本体に一度も現れず、型が
	// 決まらなくなる（「渡し方が決まりません」）。全部条件付きにすれば `a = N` が `a` を
	// `Int` だと言うし、範囲外の枝番号は `__` になる——それが正しい答えでもある。
	const dispatch = (name, params, body) => {
		const lines = [`${group}_${name} : ${params} ?`];
		for (let n = 0; n < flat.length; n++) lines.push(`\ta = ${n} : ${body(n)}`);
		return lines.join("\n");
	};
	out.push(dispatch("len", "a", (n) => String(flat[n].prefix.length)));
	out.push(dispatch("at", "a k s", (n) => `${group}_at${n} k s`));
	out.push(dispatch("nx", "a s", (n) => `${group}_nx${n} s`));
	// 移った先の枝番号は、移った先の関数のガード列が決める。
	out.push(dispatch("na", "a s", (n) => `${pre}${flat[n].call.name}_arm s`));

	// --- 進める。**カーソルを1つ進めたカーソル** ---
	//
	// 枝の中に続きがあれば `k` を進めるだけ、尽きたら入力を送って次の枝を選ぶ。どちらも
	// カーソルであって、要素はどこにも現れない——`[h ~t]` が参照の頭と長さをずらすのと
	// 同じ機械が、ここでは枝と位置をずらす算術になる。
	//
	// **これも Sign で書く。** Pass 4 が出すのは `bl <g>_adv` の1つで足りる。分岐や
	// 呼び出しの組み立てを命令の側へ持ち込まなければ、確かめる場所が1つで済む。
	out.push(
		[
			`${group}_adv : a k s ?`,
			`\t(k + 1) < (${group}_len a) : a , (k + 1) , s`,
			`\t(${group}_na a (${group}_nx a s)) , 0 , (${group}_nx a s)`,
		].join("\n"),
	);

	// --- 入口。**元の名前がカーソルを返すようになる** ---
	//
	// `sep s` は列を作るのではなく「列を引くための3つ組」を返す。並べるものは何も
	// 置かれないので、これが「器を作るのではなく引ける規則を作る」の実体である。
	// 定義は後から来た方が勝つので、元の定義はこれに置き換わる（Pass 4 は元を飛ばす）。
	const entries = funcs.map((f) => f.name);
	for (const f of funcs) out.push(`${pre}${f.name} : s ? (${pre}${f.name}_arm s) , 0 , s`);

	return { source: out.join("\n\n") + "\n", group, armCount: flat.length, entries };
}

/**
 * 生成される規則の名前。**pass3 と pass4 もこれを読む**——カーソルは「引き方」を持つ値
 * なので、どの関数を呼ぶかは型の側からも命令の側からも同じ規約で決まる。文字列を
 * 3か所に書くと、片方だけ変えたときに黙って食い違う。
 */
const CURSOR_SUFFIXES = { arm: "_arm", len: "_len", at: "_at", nx: "_nx", na: "_na", adv: "_adv" };

export { CURSOR_SUFFIXES, generatePullers, printNode, printParams, findStreamFunctions, readStreamFunction, joinItems, readArm, definedNames, bare, unparen, applyChain };
