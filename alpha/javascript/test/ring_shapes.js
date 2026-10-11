/**
 * **輪の形の生成器——仮引数をそのまま返す輪（`returnsParamAt`）と、返値の欄のラッチを突く組み合わせ。**
 *
 * 1fbceb64（返値の事実のラッチ）の検証で使った3つの組を、ここへ常設する（利用者 2026-10-09）。どれも
 * `row`（入口）→ `rt`（器を返す）の輪に、器を作る関数 `mk` と、返った器を読む `top` を組み合わせる:
 *
 *   gen2   作る関数 7 × 輪の形 5 × 受け方 2（括り `[~ts]`・裸 `ts`）× 読み方 5 × 入力 2 = 700 本
 *   gen3   作る関数 9 × 輪の形 5 × 読み方 8（直に読む・括りの関数へ渡して読む）= 360 本
 *   PROGS  手で書いた 9 本（gen2・gen3 の前に書いた見本。`norings_rec` は輪の無い対照）
 *
 * 名前は `<作る関数>_<輪>_<受け方>_<読み方>_<入力>`（gen2）・`<作る関数>_<輪>_<読み方>`（gen3）で、
 * 並びは下の表の並びのまま（決定的）。期待値は書かない——答えは解釈器が持つ。
 *
 * `ringSample()` は qemu の段の試験（`ring_shapes.test.js`）が回す固定の見本で、103 本:
 *   gen2 から作る関数 × 輪の形の組ごとに1本（35）、受け方・読み方・入力は組ごとにずらして全部の値が出るように
 *   gen3 から作る関数 × 輪の形の組ごとに1本（45）、読み方は組ごとにずらして 8 つが全部出るように
 *   PROGS の 9 本
 *   HEAD 1fbceb64 で全部の組を回して食い違った 15 本（`HEAD_ESTIMATE_MISSES`）のうち、上にまだ無い 14 本
 */
const T = String.fromCharCode(9);
const N = String.fromCharCode(10);
const lines = (...ls) => ls.join(N);

// ---- gen2：仮引数をそのまま返す括りの輪 ----
const G2_MAKERS = {
	lit3: "mk : [~s] ? `ab` , `cde` , s",
	rec: lines("mk : [~s] ?", T + "!s : __", T + "(s ' 0) , (mk (s ' 1~))~"),
	ints: "mk : [~s] ? [5 6 7]",
	strs1: "mk : [~s] ? s",
	nested: "mk : [~s] ? [[1 2] , [3 4 5]]",
	pair: "mk : [~s] ? s , s",
	chars: "mk : [~s] ? [\\a \\b \\c]",
};
const G2_RINGS = {
	two: (form) => lines("row : [~s] n ? rt (mk s) s n", `rt : ${form} [~s] n ?`, T + "n = 0 : ts", T + "row s (n - 1)"),
	self: (form) => lines("row : [~s] n ? rt (mk s) n", `rt : ${form} n ?`, T + "n = 0 : ts", T + "rt ts (n - 1)"),
	three: (form) => lines("row : [~s] n ? mid s n", "mid : [~s] n ? rt (mk s) s n", `rt : ${form} [~s] n ?`, T + "n = 0 : ts", T + "row s (n - 1)"),
	cond: (form) => lines("row : [~s] n ? rt (mk s) s n", `rt : ${form} [~s] n ?`, T + "||ts|| > n : ts", T + "row s (n - 1)"),
	none: (form) => lines("row : [~s] n ? rt (mk s) s n", `rt : ${form} [~s] n ? ts`),
};
const G2_FORMS = { br: "[~ts]", bare: "ts" };
const G2_USES = {
	len: "||row s 1||",
	i1len: "||(row s 1) ' 1||",
	i2: "(row s 1) ' 2",
	i0c1: "((row s 1) ' 0) ' 1",
	i1c0: "((row s 1) ' 1) ' 0",
};
const G2_INPUTS = ["`abcd`", "`xy`"];

export function gen2() {
	const P = {};
	for (const [mk, mkd] of Object.entries(G2_MAKERS))
		for (const [rn, rf] of Object.entries(G2_RINGS))
			for (const [fn, f] of Object.entries(G2_FORMS))
				for (const [un, u] of Object.entries(G2_USES))
					for (const [ii, inp] of G2_INPUTS.entries()) P[`${mk}_${rn}_${fn}_${un}_${ii}`] = lines(mkd, rf(f), `top : [~s] ? ${u}`, `top ${inp}`);
	return P;
}

// ---- gen3：返値の欄（要素型・形・置かれ方）のラッチを、括りの輪と消費者の括りで突く ----
const G3_MAKERS = {
	range: "mk : [~s] ? (0 ~ 5)",
	rangeL: "mk : [~s] ? [0 ~ 5]",
	named: lines("mk : [~s] ?", T + "foo : 10", T + "bar : 20"),
	pos: "mk : [~s] ? 7 , 8 , 9",
	lit3: "mk : [~s] ? `ab` , `cde` , s",
	rec: lines("mk : [~s] ?", T + "!s : __", T + "(s ' 0) , (mk (s ' 1~))~"),
	nested: "mk : [~s] ? [[1 2] , [3 4 5]]",
	strpair: "mk : [~s] ? [s , s]",
	sl: "mk : [~s] ? s ' 1~",
};
const G3_RINGS = {
	two: lines("row : [~s] n ? rt (mk s) s n", "rt : [~ts] [~s] n ?", T + "n = 0 : ts", T + "row s (n - 1)"),
	mixedrt: lines("row : [~s] n ? rt n (mk s) s", "rt : n [~ts] [~s] ?", T + "n = 0 : ts", T + "row s (n - 1)"),
	bareRow: lines("row : s n ? rt (mk s) s n", "rt : [~ts] s n ?", T + "n = 0 : ts", T + "row s (n - 1)"),
	viaId: lines("id : [~t] ? t", "row : [~s] n ? rt (id (mk s)) s n", "rt : [~ts] [~s] n ?", T + "n = 0 : ts", T + "row s (n - 1)"),
	selfOnly: lines("row : [~s] n ? rt (mk s) n", "rt : [~ts] n ?", T + "n = 0 : ts", T + "rt ts (n - 1)"),
};
const G3_USES = {
	len: "top : [~s] ? ||row s 1||",
	i1: "top : [~s] ? (row s 1) ' 1",
	i1len: "top : [~s] ? ||(row s 1) ' 1||",
	i1c0: "top : [~s] ? ((row s 1) ' 1) ' 0",
	byname: "top : [~s] ? (row s 1) ' bar",
	consumer: lines("use : [~u] ? ||u ' 1||", "top : [~s] ? use (row s 1)"),
	consumer0: lines("use : [~u] ? (u ' 1) + 0", "top : [~s] ? use (row s 1)"),
	consumerBare: lines("use : u ? ||u ' 1||", "top : [~s] ? use (row s 1)"),
};

export function gen3() {
	const P = {};
	for (const [mk, mkd] of Object.entries(G3_MAKERS))
		for (const [rn, rf] of Object.entries(G3_RINGS))
			for (const [un, u] of Object.entries(G3_USES)) P[`${mk}_${rn}_${un}`] = lines(mkd, rf, u, "top `abcd`");
	return P;
}

// ---- 手で書いた 9 本 ----
const REC = lines("mk : [~s] ?", T + "!s : __", T + "(s ' 0) , (mk (s ' 1~))~");
const RING = lines("row : [~s] n ? rt (mk s) s n", "rt : [~ts] [~s] n ?", T + "n = 0 : ts", T + "row s (n - 1)");
const LIT3 = "mk : [~s] ? `ab` , `cde` , s";
export const PROGS = {
	ring_rec_i1c0: lines(REC, RING, "top : [~s] ? ((row s 1) ' 1) ' 0", "top `abcd`", ""),
	ring_rec_i2: lines(REC, RING, "top : [~s] ? (row s 1) ' 2", "top `abcd`", ""),
	ring_rec_len: lines(REC, RING, "top : [~s] ? ||row s 1||", "top `abcd`", ""),
	ring_rec_n0_i3: lines(REC, RING, "top : [~s] ? (row s 0) ' 3", "top `abcd`", ""),
	ring_rec_bare: lines(REC, "row : s n ? rt (mk s) s n", "rt : [~ts] s n ?", T + "n = 0 : ts", T + "row s (n - 1)", "top : [~s] ? (row s 1) ' 2", "top `abcd`", ""),
	ring_lit3_i1c0: lines(LIT3, RING, "top : [~s] ? ((row s 1) ' 1) ' 0", "top `abcd`", ""),
	ring_lit3_len: lines(LIT3, RING, "top : [~s] ? ||row s 1||", "top `abcd`", ""),
	ring_range_i1: lines("mk : [~s] ? (0 ~ 5)", RING, "top : [~s] ? (row s 1) ' 1", "top `abcd`", ""),
	norings_rec: lines(REC, "top : [~s] ? ((mk s) ' 1)", "top `abcd`", ""),
};

/**
 * gen2・gen3・PROGS の 1069 本を HEAD 1fbceb64 で回して、解釈器と機械が食い違った本の全部（gen2 の 15 本）。
 * どれも作る関数が lit3（`` `ab` , `cde` , s ``）・輪が two／three／cond・受け方が裸の `ts`・入力が `` `xy` ``で、
 * pass4 は「返す器の上界は見積もり（輪の相手が食っていることを根拠にした）」の information を出す——入力が短いと
 * 見積もりを外れ、機械は `__`（短い器）を返す。見本はこの 15 本を全部含める（KNOWN_WRONG が全部を見張る）。
 */
export const HEAD_ESTIMATE_MISSES = ["two", "three", "cond"].flatMap((rn) => ["len", "i1len", "i2", "i0c1", "i1c0"].map((un) => `lit3_${rn}_bare_${un}_1`));

/**
 * 固定の見本（決定的）。[名前, ソース] の並び。名前の頭に組（`g2:`・`g3:`・`p:`）を付ける。
 * 層別の 89 本（gen2 35・gen3 45・PROGS 9）に、`HEAD_ESTIMATE_MISSES` のうちまだ入っていない 14 本を足して 103 本。
 */
export function ringSample() {
	const out = [];
	const g2 = gen2();
	const mks2 = Object.keys(G2_MAKERS);
	const rns2 = Object.keys(G2_RINGS);
	const fns2 = Object.keys(G2_FORMS);
	const uns2 = Object.keys(G2_USES);
	mks2.forEach((mk, m) =>
		rns2.forEach((rn, r) => {
			const name = `${mk}_${rn}_${fns2[(m + r) % 2]}_${uns2[(m + 2 * r) % 5]}_${((m + r) >> 1) % 2}`;
			out.push(["g2:" + name, g2[name]]);
		}),
	);
	const g3 = gen3();
	const uns3 = Object.keys(G3_USES);
	Object.keys(G3_MAKERS).forEach((mk, m) =>
		Object.keys(G3_RINGS).forEach((rn, r) => {
			const name = `${mk}_${rn}_${uns3[(m * 5 + r) % 8]}`;
			out.push(["g3:" + name, g3[name]]);
		}),
	);
	for (const [k, v] of Object.entries(PROGS)) out.push(["p:" + k, v]);
	const have = new Set(out.map(([n]) => n));
	for (const name of HEAD_ESTIMATE_MISSES) if (!have.has("g2:" + name)) out.push(["g2:" + name, g2[name]]);
	return out;
}
