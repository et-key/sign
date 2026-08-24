/**
 * Pass 4（バックエンド）——AArch64 の命令列を出す。
 *
 * `compiler_pipeline.md` §3 が定める責務は「Pass 1〜3で確定した型情報を**使い捨ての
 * 帳簿**として消費し尽くし、struct名・enum名等の意味論的な型情報は一切引き継がない。
 * 固定幅レジスタ操作とジャンプ命令テンプレートの選択のみを行う」である。
 *
 * したがってここは**型の名前で分岐しない**。見るのは還元済みの情報だけである。
 *
 *   幅と符号        `reduceToMachineType`（target_info.js）
 *   大きさとオフセット  `measure` / `layoutOfStruct`（layout.js）
 *   ロードか算術か     `node.repr`
 *   渡し方           `passingOf`（layout.js、stack_abi.md §4.6）
 *
 * ## 式の途中の値はフレームに置く
 *
 * **`bl` は `x0`〜`x7` も `x9`〜`x15` も壊す**（AAPCS64、stack_abi.md §4.2 の表）。
 * 途中の値をレジスタに置いたままにすると、次の呼び出しで消える——`add (sq n) (sq n)`
 * の1つ目の結果も、仮引数 `n` 自身も壊れる。実際にそういう命令列が出た。
 *
 * だから**式の途中の値は必ずフレームのスロットへ置く**。レジスタは「ロードして演算して
 * ストアする」間だけ使い、呼び出しを跨がない。素朴だが常に正しく、出した命令列を
 * 読んで確かめられる。呼び出しが挟まらない区間でレジスタに留める最適化は、正しさを
 * 確かめてからで足りる（原理1：ソースを読めば命令列が読めること）。
 *
 * ## いま出せる範囲
 *
 *   - 整数リテラル（16ビットまでの即値）
 *   - `+` `-` `*` `/`（GPR 幅の整数）
 *   - 裸の仮引数を持つ関数定義と、その飽和した呼び出し
 *   - トップレベルの式（`_sign_main` へ入る）
 *   - 2文字以上の文字列（`.rodata` へ置いて `{ptr, len}` を積む）
 *
 * 集約値・浮動小数・分岐・再帰はまだ出さない。出せないものは黙って落とさず診断として
 * 名指しする——落とすと「命令が無いのに動いたように見える」が起きる。
 */

import { reduceToMachineType, widthsOf, UNIT_NICHE_ASM, charSizeOf, DEFAULT_CHARSET, SIGNEDNESS } from "./target_info.js";
import { envLookup } from "./pass1.js";
import { isBareComment } from "./pass3.js";
import { passingOf, measure } from "./layout.js";
import { CURSOR_SUFFIXES } from "./stream_desugar.js";

// AAPCS64（stack_abi.md §4.2）。引数は x0〜x7、返値は x0、一時は x9〜x15。
const ARG_REGS = ["x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7"];
// 演算のあいだだけ使う。呼び出しを跨がないので caller-saved で足りる。
const SCRATCH = ["x9", "x10"];
// フレームに置ける式の深さ。超えたら診断（深い式は稀なので、まず名指しする）。
const MAX_SLOTS = 16;

// 器を作る余積の演算（記憶の確保を要求する）。
const COPRODUCT_BUILD_OPS = new Set(["construct", "concat", "push", "unshift", "product"]);

// 演算子名 → ニーモニック。除算が `sdiv` なのは `Int` が符号ありだから
// （target_info.js の SIGNEDNESS）。
const INT_OPS = { add: "add", sub: "sub", mul: "mul", div: "sdiv" };

// 比較。符号あり整数の条件コード（`Int` は符号あり——target_info.js の SIGNEDNESS）。
// `assign_equal` は `=`（等価比較）である——`:` が定義なので、`=` は比較に使える。
const CMP_COND = { less: "lt", less_equal: "le", assign_equal: "eq", more_equal: "ge", more: "gt", not_equal: "ne" };

/**
 * 末尾呼び出しを出したという印。**値を積まない**——制御がそこから戻らないからである。
 *
 * `genExpr` は普段「積んだスロットの本数」を返すが、末尾呼び出しだけは本数を持たない。
 * `0` にすると「幅ゼロの値を積んだ」と読めてしまうので、別のものにしてある。
 */
const TAIL = Symbol("tail");

// フレームの大きさは本体を出し切るまで決まらないので、相互末尾呼び出しの
// 「フレームを畳む」命令には印だけ置いて `wrapFrame` で埋める。
const FRAME_MARK = "@@FRAME@@";

// 比較が偽のときに返す値＝`__` の niche（value_representation.md §3.5）。
// **`0` ではない。** Sign では `0` は真であり、`0 = 0` は真で `0` を返す。
const UNIT = UNIT_NICHE_ASM;

function isIdentifierNode(n) {
	return !!n && n.type === "atom" && n.kind === "identifier";
}

function isDefineNode(n) {
	return !!n && n.type === "operation" && n.name === "define";
}

function bareName(v) {
	return typeof v === "string" && v.startsWith("<") && v.endsWith(">") ? v.slice(1, -1) : String(v);
}

// 1行だけのブロックは括りでしかない（`(a + b)` の外側）。
// 1行だけのブロックは括りでしかない（`(a + b)` の外側）。ただし**その1行が定義なら
// 剥がさない**——`x > 10 : 1` は括りではなく枝が1つの match_case である。
function unwrap(node) {
	let n = node;
	while (n && Array.isArray(n.lines) && n.lines.length === 1 && n.kind !== "abs" && !isDefineNode(n.lines[0])) {
		n = n.lines[0];
	}
	return n;
}

// 文字・文字列リテラルの符号位置の並び。読めなければ null。
// サロゲートペアを2文字と数えないため `[...s]` で回す。
// **1文字かどうかは型が言う。** `Char` は Layer 2 の型であり（type_system.md §2）、
// 1文字は `Char`、2文字以上が `String` である——`String ≅ List(Char)` と1要素の潰れ
// （`[5]` は `Int`）から出てくる。
//
// リテラルの形を見るのをやめたのは、**表現が実行時の長さで変わってはいけない**からで
// ある。`Char` はレジスタに乗る符号位置、`String` は `{ptr, len}` の参照なので、同じ型が
// 両方を指すと実行時に見分ける必要が出る——それは動的型付けである。
/**
 * 値がスロットを何本占めるか。**「渡し方」がそのまま「スタックマシンの幅」である**
 * （stack_abi.md §4.6）——スカラーは1本、要素の並びは `{ptr}` / `{ptr, len}` で1〜2本。
 *
 * ただし `__` だけは §4.6 の表と食い違う。あちらは「零対象は何も渡らない」（0本）と
 * 言うが、Pass 4 の `__` は**直和 `L | R | __` の一員としてレジスタに乗る niche**
 * であって「引数が無い」ことではない（value_representation.md §3.5）。比較が偽のとき
 * 返るのはこの値なので、幅を 0 にすると置き場所が消える。
 *
 * 直和や族（`Char | String` など）は渡し方が決まらないので `null` を返す。呼ぶ側は
 * 黙って1本と決めつけず、名指しで落とす。
 */
function slotsOf(type, conf) {
	// 型注釈が無いノードは今まで通り1本として扱う（整数リテラルなど）。
	if (!type || type === "Unit") return 1;
	const pass = passingOf({ atomType: type }, { target: conf.target, charset: conf.charset });
	return pass ? Math.max(pass.slots, 1) : null;
}

/**
 * ノードから幅を引く。**型だけでは場所か規則か決まらない。**
 *
 * `[1 ~ 5]` の型は `List` だが実体は規則であり（`repr: "rule"`）、運ぶのは `{ptr, len}` の
 * 2本ではなく `{start, step, end}` の3本である（stack_abi.md §4.6 の「規則」の行）。
 * 型だけを渡していたので、レンジが参照として数えられていた——`layout.js` は最初から
 * 正しく答えていて、こちらが訊き方を間違えていた。
 *
 * 「型は何ができるかしか語らない。どう置かれているかは `repr` に印として残す」という
 * pass3 の設計を、ここで使い切る。
 */
function slotsOfNode(node, conf, env) {
	if (!node) return null;
	if (!node.atomType || node.atomType === "Unit") return 1;
	// `env` を渡すと `deref` が束縛まで辿り、`repr` と要素型を引き継ぐ——`c : [0 ~+ 1]`
	// と束縛してから `c ' 3` と書いたとき、識別子ノード自身は実体の種類を知らないが
	// 束縛は知っている（pass3 が書き戻している）。
	const pass = passingOf(node, { target: conf.target, charset: conf.charset, env });
	return pass ? Math.max(pass.slots, 1) : null;
}

function isSingleChar(n) {
	return !!n && n.atomType === "Char";
}

function codePointsOf(n) {
	if (n.kind === "char") return [...n.value.slice(1)].map((c) => c.codePointAt(0));
	if (n.kind === "string") return [...n.value.slice(1, -1)].map((c) => c.codePointAt(0));
	if (n.kind === "unicode") {
		const cp = parseInt(n.value.slice(2), 16);
		// U+0000 は niche であって文字ではない（value_representation.md §3）。
		return Number.isNaN(cp) ? null : cp === 0 ? [] : [cp];
	}
	return null;
}

function applyChain(node) {
	const args = [];
	let n = node;
	while (n && n.type === "operation" && (n.name === "apply" || n.name === "partial_apply")) {
		args.unshift(n.right);
		n = n.left;
	}
	return { base: n, args };
}

/**
 * **単相化**（compiler_pipeline.md §3 の IMPORTANT）。
 *
 * `@p x` は「どこへ跳ぶか」が実行時にしか分からない形だが、Sign はそこへ実行時
 * ディスパッチを置かない——**呼び出しサイト単位で具体化する**（type_system.md §4 の
 * 前置 `@`）。Rust の単相化と同じで、`dyn` の側は採らない。
 *
 * 具体化すると**関数ポインタの引数は消える**。アドレスが命令へ焼き込まれるので、
 * レジスタで運ぶ必要が無くなる——`stack_abi.md` の比較表が Sign の欄に
 * 「コンパイル時特殊化（コストゼロ）」と書いているのはこのことである。
 *
 *   take_while : p s ? @p s
 *   take_while $is_digit s   →  bl take_while$is_digit   （引数は s だけ）
 *
 * @returns Map<関数名, { ptrParams: string[], instances: Map<鍵, {callees, label}> }>
 */
function collectMonomorphs(nodes) {
	const table = new Map();
	// まず「アドレス経由で呼ばれる仮引数」を持つ関数を見つける。
	for (const node of nodes) {
		if (!isDefineNode(node) || !isIdentifierNode(node.left)) continue;
		const rhs = node.right;
		if (!rhs || rhs.type !== "operation" || rhs.name !== "lambda") continue;
		// **名前を持たない仮引数があっても具体化はできる。** 関数ポインタになれるのは裸の
		// 仮引数だけだが、同じ仮引数リストに `[~s]` のような分解の形が混ざることはある
		// ——以前はそこで諦めていたので、器を宣言の形で受けた瞬間に単相化が効かなくなり、
		// `@p` が「呼び先が静的に決まりません」になっていた。位置は保つ（`indexOf` が
		// 実引数の位置と対応する必要があるため）。
		const params = paramShapesOf(rhs.left).map((sh) => (sh && sh.kind === "bare" ? sh.name : null));
		const ptrParams = [];
		const visit = (n) => {
			if (!n || typeof n !== "object") return;
			// `@p` が適用の根に来ている＝アドレス経由の呼び出しである。
			if (n.type === "operation" && (n.name === "apply" || n.name === "partial_apply")) {
				const { base } = applyChain(n);
				if (base && base.type === "operation" && base.position === "prefix" && base.name === "input" && isIdentifierNode(base.operand)) {
					const v = base.operand.value;
					if (params.includes(v) && !ptrParams.includes(v)) ptrParams.push(v);
				}
			}
			for (const k of ["left", "right", "operand"]) visit(n[k]);
			for (const l of n.lines || []) visit(l);
			for (const e of n.entries || []) visit(e.default);
		};
		visit(rhs.right);
		if (ptrParams.length > 0) table.set(bareName(node.left.value), { params, ptrParams, instances: new Map(), lambda: rhs });
	}
	if (table.size === 0) return table;
	// 次に呼び出しサイトを歩いて、どの関数が渡されているかを集める。
	const visitSites = (n) => {
		if (!n || typeof n !== "object") return;
		if (n.type === "operation" && (n.name === "apply" || n.name === "partial_apply")) {
			const { base, args } = applyChain(n);
			if (isIdentifierNode(base)) {
				const entry = table.get(bareName(base.value));
				if (entry) {
					const callees = {};
					let ok = true;
					for (const pn of entry.ptrParams) {
						const i = entry.params.indexOf(pn);
						const a = args[i];
						// `$名前` だけを具体化できる。式で作ったアドレスは静的に決まらない。
						if (a && a.type === "operation" && a.position === "prefix" && a.name === "address" && isIdentifierNode(a.operand)) {
							callees[pn] = bareName(a.operand.value);
						} else ok = false;
					}
					if (ok) {
						const key = entry.ptrParams.map((pn) => callees[pn]).join("$");
						if (!entry.instances.has(key)) {
							entry.instances.set(key, { callees, label: `${bareName(base.value)}$${key}` });
						}
						n.monoLabel = entry.instances.get(key).label;
						n.monoDrop = entry.ptrParams.map((pn) => entry.params.indexOf(pn));
					}
				}
			}
			args.forEach(visitSites);
			return;
		}
		for (const k of ["left", "right", "operand"]) visitSites(n[k]);
		for (const l of n.lines || []) visitSites(l);
		for (const e of n.entries || []) visitSites(e.default);
	};
	for (const n of nodes) visitSites(n);
	return table;
}

// 裸の仮引数の名前を宣言順で返す。分割代入・rest・デフォルトは null。
function paramNamesOf(paramNode) {
	if (isIdentifierNode(paramNode)) return [paramNode.value];
	if (!paramNode || paramNode.type !== "params") return [];
	return (paramNode.entries || []).map((e) => (e.pattern || e.rest || e.default ? null : e.name || null));
}

/**
 * 仮引数の形を宣言順で返す。
 *
 *   { kind: "bare", name }              裸の仮引数
 *   { kind: "destructure", head, rest } ブラケット分割代入 `[h ~t]`
 *   null                                まだ出せない形（rest・デフォルト）
 *
 * `paramNamesOf` と分けてあるのは、単相化（`collectMonomorphs`）が見るのは「名前で
 * 呼べる仮引数」だけであり、分割代入された仮引数は関数ポインタになりえないためである。
 */
function paramShapesOf(paramNode) {
	if (isIdentifierNode(paramNode)) return [{ kind: "bare", name: paramNode.value }];
	if (!paramNode || paramNode.type !== "params") return [];
	// 仮引数が `[h ~t]` **だけ**のときは、括弧が仮引数リスト全体に付く（`bracket: true`）。
	// 入れ子の `pattern` にはならないので、ここで拾う——同じ形の別の書かれ方である。
	if (paramNode.bracket) {
		const es = paramNode.entries || [];
		if (es.length === 2 && !es[0].rest && es[1].rest && !es[0].default && !es[1].default) {
			return [{ kind: "destructure", head: es[0].name, rest: es[1].name }];
		}
		// `[~x]` は**切り出さず丸ごと受ける**形である（n_queens.sn の「分解の形には2つある」）。
		// 受け取り方は裸の仮引数と同じ1つの値であり、違うのは**型の宣言**の方——器である
		// ことを言っているので `__` がそこを通れない。それは Pass 3 の仕事であって、
		// 機械の上ですることは裸の仮引数と変わらない。
		if (es.length === 1 && es[0].rest && !es[0].default && es[0].name) {
			return [{ kind: "bare", name: es[0].name, defaultNode: null, whole: true }];
		}
		return [null];
	}
	return (paramNode.entries || []).map((e) => {
		if (e.pattern) {
			// いま出せるのは `[h ~t]`——先頭と残りの2つに割る形だけである。
			const p = e.pattern;
			// `[~x]`（混在形）。丸ごと受けるので裸の仮引数と同じ扱いになる。
			// **デフォルトは付きえない**——参照が指すのは呼び出し側が置いた記憶なので、
			// 既定値を作る場所が無い（pass2.js が構文エラーで弾く）。
			if (p.length === 1 && p[0].rest && !p[0].defaultTokens && p[0].name) {
				return { kind: "bare", name: p[0].name, defaultNode: null, whole: true };
			}
			if (p.length === 2 && !p[0].rest && p[1].rest && !p[0].defaultTokens && !p[1].defaultTokens) {
				return { kind: "destructure", head: p[0].name, rest: p[1].name };
			}
			return null;
		}
		if (e.rest) return null;
		// **デフォルトを持つ仮引数も裸である。** 違うのは「渡されなかったとき何を置くか」
		// だけであり、受け取り方は同じ1つの値である。デフォルト式はここでは持ち回るだけで、
		// 生成するのは `genFunction`——`let*` の順で、前の仮引数が既に置かれた後に評価する
		// 必要があるためである（1_definition.md §6.1）。
		return e.name ? { kind: "bare", name: e.name, defaultNode: e.default || null } : null;
	});
}

/**
 * ブラケット分割代入 `[h ~t]` を、渡ってきた `{ptr, len}` から作る。
 *
 * **コピーは起きない。** 要素の並びは参照で渡ってくる（stack_abi.md §4.6）ので、
 * 先頭は指す先の1要素、残りは**同じ領域を指したまま `ptr` を1要素進めて `len` を1
 * 減らしたもの**である。`t` のスロットは容器のスロットをそのまま使い回せる。
 *
 *   h = ptr[0]
 *   t = { ptr + sizeof(要素), len - 1 }
 *
 * **これが終端になる。** 残りが尽きると `len` が 0 になり、`len = 0` は `__` そのもの
 * （`__ = []`、unit.md）なので、次の呼び出しは完全性公理で崩壊する
 * ——`function_guide.md` が「ブラケット分解でなければ完全性公理が終端を与えられない」と
 * 書いているのは、この形のことである。
 */
function emitDestructure(em, containerOff, headOff, elemSize, signed, name) {
	em.load(SCRATCH[0], containerOff, `${name} の先頭を取り出す`);
	// 要素の幅ぶんだけ読む。符号ありで 8 byte 未満なら符号拡張が要る。
	const mnemonic =
		elemSize === 8 ? `ldr ${SCRATCH[1]}, [${SCRATCH[0]}]`
		: elemSize === 4 ? `ldr${signed ? "sw " + SCRATCH[1] : " w10"}, [${SCRATCH[0]}]`
		: elemSize === 2 ? `ldr${signed ? "sh " + SCRATCH[1] : "h w10"}, [${SCRATCH[0]}]`
		: `ldr${signed ? "sb " + SCRATCH[1] : "b w10"}, [${SCRATCH[0]}]`;
	em.emit(mnemonic, `${elemSize} byte の要素1つ`);
	em.store(SCRATCH[1], headOff, "先頭");
	// 残りは同じ領域を指したまま、頭を1つ分ずらす。
	em.emit(`add ${SCRATCH[0]}, ${SCRATCH[0]}, #${elemSize}`, "1要素ぶん進める");
	em.store(SCRATCH[0], containerOff, "残りの ptr");
	em.load(SCRATCH[1], containerOff + 8);
	em.emit(`sub ${SCRATCH[1]}, ${SCRATCH[1]}, #1`, "残りの長さ");
	em.store(SCRATCH[1], containerOff + 8, "残りの len（0 なら __）");
}
/**
 * 命令列を組み立てる器。
 *
 * 診断は**捨てない**。出せなかった場所を黙って飛ばすと、命令の無い関数ができあがって
 * 「動いたように見える」——型が値より狭いときと同じ種類の嘘である。
 */
class Emitter {
	constructor(conf) {
		this.conf = conf;
		this.lines = [];
		this.diagnostics = [];
		this.slot = 0; // 使用中のフレームスロット数
		this.maxSlot = 0;
		this.labelSeq = 0;
		// `.rodata` に置いた文字列。中身が同じなら1つに畳む（キーは符号位置の並び）。
		this.rodata = new Map();
	}

	/**
	 * 文字列の中身を `.rodata` へ置き、その先頭のラベルを返す。
	 *
	 * 幅は `charset` が決める（`ascii` = 1 byte / `utf32` = 4 byte、option_ms_schema.md
	 * §4.2）。どちらも固定幅なので `s ' i` は `base + i × sizeof(Char)` のままである。
	 */
	intern(cps) {
		const key = cps.join(",");
		const hit = this.rodata.get(key);
		if (hit) return hit.label;
		const label = `.Lstr${this.rodata.size}`;
		this.rodata.set(key, { label, cps });
		return label;
	}

	// `.rodata` セクションを組み立てる。1つも無ければ空を返す（節ごと出さない）。
	rodataLines() {
		if (this.rodata.size === 0) return [];
		const w = charSizeOf(this.conf.charset);
		// 幅ごとのディレクティブ。`String ≅ List(Char)` の要素幅そのものである。
		const dir = w === 1 ? ".byte" : w === 2 ? ".hword" : ".word";
		const out = ["", "	.section .rodata"];
		for (const { label, cps } of this.rodata.values()) {
			out.push(`	.balign ${w}`);
			out.push(`${label}:`);
			// 1 byte 幅で中身が素直な ASCII なら `.ascii` で書く——読めるほうが良い。
			// `"` と `\` を含むもの・印字できないものは `.byte` の並びへ落とす。
			const plain = w === 1 && cps.every((c) => c >= 0x20 && c <= 0x7e && c !== 0x22 && c !== 0x5c);
			if (plain) out.push(`	.ascii "${cps.map((c) => String.fromCharCode(c)).join("")}"`);
			else out.push(`	${dir} ${cps.map((c) => "0x" + c.toString(16)).join(", ")}`);
			out.push(`	// ${cps.length} 文字`);
		}
		return out;
	}

	emit(text, comment) {
		// 26桁を超える命令でもコメントの前に1つは空きが要る（詰まると読めない）。
		const pad = text.length >= 26 ? text + " " : text.padEnd(26);
		this.lines.push(comment ? `\t${pad}// ${comment}` : `\t${text}`);
	}

	label(name) {
		this.lines.push(`${name}:`);
	}

	blank() {
		this.lines.push("");
	}

	// ローカルラベル。アセンブラの慣習に合わせて `.L` 始まりにする。
	newLabel(tag) {
		return `.L${tag}${this.labelSeq++}`;
	}

	fail(node, message) {
		this.diagnostics.push({ severity: "error", message, node });
		this.emit(`// 出せない: ${message}`);
		return false;
	}

	// スロットを1つ借りる。フレーム先頭からのバイトオフセットを返す。
	push() {
		if (this.slot >= MAX_SLOTS) return null;
		const off = this.slot * 8;
		this.slot++;
		if (this.slot > this.maxSlot) this.maxSlot = this.slot;
		return off;
	}

	pop(n = 1) {
		this.slot -= n;
	}

	// スロットへ書く／から読む。フレームポインタ相対で、呼び出しを跨いでも残る。
	store(reg, off, comment) {
		this.emit(`str ${reg}, [x29, #${16 + off}]`, comment);
	}

	load(reg, off, comment) {
		this.emit(`ldr ${reg}, [x29, #${16 + off}]`, comment);
	}
}

/**
 * 式を評価して、結果をフレームのスロットへ積む。
 *
 * @returns 積んだ**スロットの本数**。出せなければ `false`。
 *
 * 本数が返るのは、値が1本とは限らないからである——スカラーは1本だが、要素の並びは
 * `{ptr, len}` の2本で運ぶ（stack_abi.md §4.6）。呼ぶ側は使い終わったらその本数だけ
 * `pop()` する。式の入れ子はそのままスロットの深さになる。
 */
/**
 * 式を出して、**スカラー1本**であることを要求する。
 *
 * `cmp` も `add` もレジスタ1本の値にしか当たらない。器（`{ptr, len}`）が来たら
 * 中身の比較・連結になるので、黙って先頭のスロットだけ見ずに名指しで落とす。
 */
function genScalar(node, env, em, scope, why) {
	const w = genExpr(node, env, em, scope);
	if (w === false) return false;
	if (w !== 1) {
		em.pop(w);
		return em.fail(node, `${why}（${node && node.atomType} は ${w} 本の参照で運ぶ値）`);
	}
	return 1;
}

function genExpr(node, env, em, scope, tail = false) {
	const n = unwrap(node);
	if (!n) return false;

	// **match_case の並び**（関数本体）。各行は `条件 : 結果`、最後の1行だけ条件無しの
	// フォールバックでありうる。条件が `__` でなければその結果を返す（function_guide.md）。
	//
	// 判定は niche との比較である——**`cbz` は使えない**。Sign では `0` は真であり、
	// `0 = 0` は真で `0` を返すので、0 を偽と読むと評価器と食い違う
	// （value_representation.md §3.5、unit.md §5.1 の CAUTION）。
	// 1行でも `条件 : 結果` なら分岐である（枝が尽きれば `__`）。ブロックの行数ではなく
	// **定義行かどうか**で決まる——`名前 : 値` の構造体と区別が要るのは複数行のときだけで、
	// 関数本体では `識別子 : 値` も match_case である（function_guide.md）。
	if (Array.isArray(n.lines) && (n.lines.length > 1 || (n.lines.length === 1 && isDefineNode(n.lines[0])))) {
		return genMatch(n, env, em, scope, tail);
	}

	// 整数リテラル・アドレスリテラル。16ビットを超える値は `movz`/`movk` の連なりになる。
	if (n.type === "atom" && (n.kind === "number" || n.kind === "address" || n.kind === "register")) {
		// `Number` を経由しない——`0x123456789abcdef` のような番地は倍精度に載らず、
		// 下の桁が黙って丸まる。文字列のまま `BigInt` へ渡せば桁は落ちない。
		let v;
		try { v = BigInt(n.value); } catch { return em.fail(n, `浮動小数はまだ出せません（${n.value}）`); }
		const off = em.push();
		if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		emitImm(em, SCRATCH[0], v, `リテラル ${n.value}`);
		em.store(SCRATCH[0], off);
		return 1;
	}

	// **1文字はスカラーである。**
	//
	// `String ≅ List(0u)`（type_system.md §2）であり、1要素のリストはスカラーと同型
	// （`[5]` は `Int`、list_model.md）。したがって1文字の文字列は符号位置そのもので
	// あり、レジスタに乗る——`is_digit : c ?   <= c <= 9` が `cmp` 1命令で書けるのは
	// これが理由である（§4 の NOTE「文字は符号位置で数える点」）。
	//
	// 2文字以上は要素の並びなので `.rodata` へ置いて `{ptr, len}` で渡す
	// （stack_abi.md §4.6）。
	if (n.type === "atom" && (n.kind === "char" || n.kind === "string" || n.kind === "unicode")) {
		const cps = codePointsOf(n);
		if (cps === null) return em.fail(n, "文字列の中身が読めません");
		const w = charSizeOf(em.conf.charset);
		// 型が `String` なら2文字以上である（1文字は `Char` へ潰れ、0文字は `Unit`）。
		if (n.atomType === "Char" && cps.length === 1) {
			if (cps[0] > 0xffff) return em.fail(n, `16ビットを超える符号位置はまだ出せません（U+${cps[0].toString(16)}）`);
			const off = em.push();
			if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
			em.emit(`mov ${SCRATCH[0]}, #${cps[0]}`, `文字 U+${cps[0].toString(16).toUpperCase().padStart(4, "0")}（${w} byte 幅）`);
			em.store(SCRATCH[0], off);
			return 1;
		}
		// **空文字列は `{ptr, len}` の `len = 0` である。** 値としては `__` そのものだが
		// （`__ = []`、unit.md）、型は `String` なので幅2本で置く——型が言う本数と実際に
		// 置く本数が食い違うと、呼び出し側が読む本数が決まらない。`.rodata` は要らない
		// （指す先が無いので `ptr` は 0 でよい）。
		if (cps.length === 0) {
			const po0 = em.push();
			const lo0 = po0 === null ? null : em.push();
			if (lo0 === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
			em.emit(`mov ${SCRATCH[0]}, #0`, "空文字列は __（len = 0）");
			em.store(SCRATCH[0], po0, "ptr");
			em.store(SCRATCH[0], lo0, "len = 0 が __");
			return 2;
		}
		if (cps.length > 0xffff) return em.fail(n, `16ビットを超える長さはまだ出せません（${cps.length} 文字）`);

		// **`len` は文字数であってバイト数ではない。** `String ≅ List(Char)` であり
		// （type_system.md §2）、添字は `base + i × sizeof(Char)` で引く。バイト数で持つと
		// charset を変えた瞬間に添字がずれる——`charset` が決めるのは要素の幅だけで、
		// **要素数は charset に依らない**という一点をここで守る。
		const label = em.intern(cps);
		const po = em.push();
		const lo = po === null ? null : em.push();
		if (lo === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		// AArch64 でラベルのアドレスを作る決まり文句。`adrp` が 4KB 単位の頁を取り、
		// `:lo12:` が下位12ビットを足す。PC 相対なので位置独立のまま。
		em.emit(`adrp ${SCRATCH[0]}, ${label}`, `${label} の頁（${w} byte 幅 × ${cps.length} 文字）`);
		em.emit(`add ${SCRATCH[0]}, ${SCRATCH[0]}, :lo12:${label}`);
		em.store(SCRATCH[0], po, "ptr");
		em.emit(`mov ${SCRATCH[1]}, #${cps.length}`, "len は文字数（バイト数ではない）");
		em.store(SCRATCH[1], lo, "len");
		return 2;
	}

	// `__`（Unit）。niche を積む（value_representation.md §3.5）。
	if (n.type === "atom" && n.kind === "unit") {
		const off = em.push();
		if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		em.emit("movz x9, #0x8000, lsl #48", "__ の niche");
		em.store(SCRATCH[0], off);
		return 1;
	}

	// 仮引数。入口でスロットへ写してあるので、そこから読む。
	if (isIdentifierNode(n)) {
		const slot = scope && scope.params ? scope.params.indexOf(n.value) : -1;
		if (slot >= 0) {
			// 仮引数も幅を持つ——`{ptr, len}` で受けた仮引数は2本まとめて写す。
			const w = scope.paramSlots ? scope.paramSlots[slot] : 1;
			const base = em.slot;
			for (let k = 0; k < w; k++) {
				if (em.push() === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
				em.load(SCRATCH[0], scope.paramOffsets[slot] + k * 8, k === 0 ? `仮引数 ${bareName(n.value)}` : undefined);
				em.store(SCRATCH[0], (base + k) * 8);
			}
			return w;
		}
		// **トップレベルの定数はその場で畳む。** `space :  ` のような `名前 : 値` は
		// 束縛であって場所ではない——値そのものを書けば済むので、ロードは要らない。
		// Pass 3 が値ノードを識別子テーブルへ書き戻しているので（`binding.valueNode`）、
		// そこを辿って生成し直す。
		if (env) {
			const b = envLookup(env, n.value);
			const v = b && b.valueNode;
			// 自分自身へ戻らないようにする（`a : a` のような形は解けない）。
			if (v && v !== n && !(scope && scope.folding && scope.folding.has(n.value))) {
				const folding = new Set(scope && scope.folding ? scope.folding : []);
				folding.add(n.value);
				return genExpr(v, env, em, { ...(scope || {}), folding }, tail);
			}
		}
		return em.fail(n, `まだ出せない識別子です（${bareName(n.value)}）`);
	}

	if (n.type === "operation" && INT_OPS[n.name] && n.position === "infix") {
		const machine = reduceToMachineType(n.atomType, em.conf.target);
		if (!machine || machine.class !== "gpr") {
			return em.fail(n, `GPR 幅の整数演算だけを出せます（${n.atomType}）`);
		}
		const why = "GPR 幅の整数演算だけを出せます";
		if (!genScalar(n.left, env, em, scope, why)) return false;
		const lo = (em.slot - 1) * 8;
		if (!genScalar(n.right, env, em, scope, why)) return false;
		const ro = (em.slot - 1) * 8;
		em.load(SCRATCH[0], lo);
		em.load(SCRATCH[1], ro);
		em.emit(`${INT_OPS[n.name]} ${SCRATCH[0]}, ${SCRATCH[0]}, ${SCRATCH[1]}`, `${n.op}`);
		em.pop(1); // 右辺のスロットを返す。結果は左辺のスロットへ書く。
		em.store(SCRATCH[0], lo);
		return 1;
	}

	// **比較は値を返す。**（comparison.md §2.1）真ならオペランド、偽なら `__`。
	// どちらのオペランドを返すかは**左辺の値**が決める——左辺が算術単位元（0 か 1）なら
	// 右辺、そうでなければ左辺。値で決まるので実行時に見る必要がある。
	//
	// `csel` を2段重ねる。1段目で「左辺が単位元か」を見て返す候補を選び、2段目で
	// 「比較が真か」を見て候補と `__` を選ぶ。分岐は出さない。
	if (n.type === "operation" && CMP_COND[n.name] && n.position === "infix") {
		const machine = reduceToMachineType(n.atomType, em.conf.target);
		// 比較の結果型は `L | R | __` なので、それ自体は還元できない。両辺が GPR 幅の
		// 整数であることを見る。
		const lt = reduceToMachineType(n.left && n.left.atomType, em.conf.target);
		const rt = reduceToMachineType(n.right && n.right.atomType, em.conf.target);
		// **1文字は符号位置というスカラーなので、整数と同じく `cmp` で比べられる**
		// （§4 の NOTE「文字は符号位置で数える点」）。器としての `String` は比べられない
		// ——中身の比較になるので、`.rodata` と長さが要る。
		// **`Char` は符号位置という整数なので GPR に乗る**（target_info.js の WIDTH_CLASS）。
		// 型がそう言っているので、リテラルの形を見る必要はない。
		const cmpOk = (side) => {
			const m = reduceToMachineType(side && side.atomType, em.conf.target);
			return !!m && m.class === "gpr";
		};
		// **器どうしの等価は中身の比較である。** `String` は `{ptr, len}` で来るので、
		// 長さを見てから要素を1つずつ見る。メモリは要らない——読むだけである。
		if (n.left && n.right && n.left.atomType === "String" && n.right.atomType === "String") {
			if (n.name !== "assign_equal" && n.name !== "not_equal") {
				return em.fail(n, `器どうしは等価だけを出せます（${n.op}）——順序を出すには辞書式の規則が要る`);
			}
			return genStringCompare(n, env, em, scope);
		}
		if (!cmpOk(n.left) || !cmpOk(n.right)) {
			return em.fail(n, `GPR 幅の値の比較だけを出せます（${n.left && n.left.atomType} と ${n.right && n.right.atomType}）`);
		}
		const whyCmp = "GPR 幅の値の比較だけを出せます";
		if (!genScalar(n.left, env, em, scope, whyCmp)) return false;
		const lo = (em.slot - 1) * 8;
		if (!genScalar(n.right, env, em, scope, whyCmp)) return false;
		const ro = (em.slot - 1) * 8;
		em.load(SCRATCH[0], lo);
		em.load(SCRATCH[1], ro);
		// 左辺が 0 か 1 か（算術単位元、comparison.md §2.1）。
		em.emit(`cmp ${SCRATCH[0]}, #0`, "左辺は加法単位元か");
		em.emit(`ccmp ${SCRATCH[0]}, #1, #4, ne`, "違えば乗算単位元か");
		em.emit(`csel x11, ${SCRATCH[1]}, ${SCRATCH[0]}, eq`, "単位元なら右辺、でなければ左辺");
		// 比較そのもの。真なら選んだ候補、偽なら `__`。
		// 64ビット即値は `mov` に載らない。niche は上位16ビットだけが立っているので
		// `movz` 1命令で作れる（0x8000 << 48）。
		em.emit("movz x12, #0x8000, lsl #48", "__ の niche");
		em.emit(`cmp ${SCRATCH[0]}, ${SCRATCH[1]}`, `${n.op}`);
		em.emit(`csel ${SCRATCH[0]}, x11, x12, ${CMP_COND[n.name]}`, "真なら値、偽なら __");
		em.pop(1);
		em.store(SCRATCH[0], lo);
		return 1;
	}

	// **連鎖比較**（`  <= c <= 9`）。二項と違い、真のとき返るのは**必ず中央**である
	// ——0/1 の規則（comparison.md §2.1）は効かない。範囲判定の書き方そのものなので、
	// これが出せないと文字の分類が1つも書けない。
	//
	// 2つの条件を `cset` で取って `and` する。`ccmp` で1命令に詰められるが、条件ごとに
	// 「偽のときのフラグ」を選ぶ必要があり読みにくい。まず読んで正しいと分かる形にする。
	if (n.type === "operation" && n.name === "chain_compare") {
		const cond = CMP_COND[n.compareName];
		if (!cond) return em.fail(n, `連鎖できない比較です（${n.compareName}）`);
		const sides = [n.left, n.middle, n.right];
		const ok = (side) => {
			const m = reduceToMachineType(side && side.atomType, em.conf.target);
			return !!m && m.class === "gpr";
		};
		if (!sides.every(ok)) {
			return em.fail(n, `GPR 幅の値の連鎖比較だけを出せます（${sides.map((x) => x && x.atomType).join(" ")}）`);
		}
		const offs = [];
		for (const side of sides) {
			if (!genScalar(side, env, em, scope, "GPR 幅の値の連鎖比較だけを出せます")) return false;
			offs.push((em.slot - 1) * 8);
		}
		em.load(SCRATCH[0], offs[0]);
		em.load(SCRATCH[1], offs[1]);
		em.emit(`cmp ${SCRATCH[0]}, ${SCRATCH[1]}`, `左 ${n.op} 中央`);
		em.emit(`cset x11, ${cond}`);
		em.load(SCRATCH[0], offs[2]);
		em.emit(`cmp ${SCRATCH[1]}, ${SCRATCH[0]}`, `中央 ${n.op} 右`);
		em.emit(`cset x13, ${cond}`);
		em.emit("and x11, x11, x13", "両方が真か");
		em.emit("movz x12, #0x8000, lsl #48", "__ の niche");
		em.emit("cmp x11, #0");
		em.emit(`csel ${SCRATCH[0]}, ${SCRATCH[1]}, x12, ne`, "真なら中央、偽なら __");
		em.pop(2);
		em.store(SCRATCH[0], offs[0]);
		return 1;
	}

	// **短絡**（`&` と `|`）。どちらも「左を見て、右を評価するかどうかを決める」形である。
	//
	//   &   左が `__` なら全体が `__`（右は評価しない）。そうでなければ右がそのまま結果
	//   |   左が `__` でなければ左がそのまま結果（右は評価しない）。`__` なら右
	//
	// 評価しないことは意味論の一部である。Sign は副作用と非停止を持つので、
	// `__ & ($UART # x)` で書き込みが起きるかどうかが変わる（operator_table.md
	// 「Unit 欄の読み方」）。命令の節約ではなく、**評価するかしないか**を出している。
	//
	// 結果は左のスロットに揃える——どちらの経路を通っても同じ場所に値がある。
	if (n.type === "operation" && (n.name === "and" || n.name === "or") && n.position === "infix") {
		const isAnd = n.name === "and";
		// **幅は問わない。** 見るのは「`__` かどうか」だけで、その判定は幅ごとに決まって
		// いる。左右の幅が揃っていることだけが要る——どちらの経路を通っても同じ場所に
		// 同じ本数の値がある、が結果の置き方だからである。
		const lw = genExpr(n.left, env, em, scope);
		if (lw === false) return false;
		if (lw === TAIL) return em.fail(n.left, "短絡の左辺に末尾呼び出しは置けません（結果を見て飛び先を決めるため）");
		const lo = (em.slot - lw) * 8;
		const end = em.newLabel("sc");
		emitIsUnit(em, lo, lw, "左辺");
		em.emit(
			`b.${isAnd ? "eq" : "ne"} ${end}`,
			isAnd ? "左が __ なら全体が __（右を評価しない）" : "左が __ でなければ左が結果（右を評価しない）"
		);
		// **右辺は末尾位置である**（tco.md §2「`then` と `else` の両方が末尾位置」）。
		// 左辺は違う——結果を見てから飛び先を決めるので、評価しきる必要がある。
		const rw = genExpr(n.right, env, em, scope, tail);
		if (rw === false) return false;
		if (rw === TAIL) {
			// 右辺は飛んで行った。ここへ落ちてくるのは左辺の経路だけである。
			em.label(end);
			return lw;
		}
		if (rw !== lw) {
			em.pop(rw);
			return em.fail(n.right, `短絡の両辺は同じ幅でなければ出せません（${lw} 本と ${rw} 本、${n.op}）`);
		}
		const rbase = em.slot - rw;
		for (let k = 0; k < rw; k++) {
			em.load(SCRATCH[0], (rbase + k) * 8);
			em.store(SCRATCH[0], lo + k * 8, k === 0 ? "右辺が結果" : undefined);
		}
		em.pop(rw);
		em.label(end);
		return lw;
	}

	// 飽和した呼び出し。引数をスロットで作ってから x0〜x7 へ積んで `bl`。
	if (n.type === "operation" && n.name === "apply") {
		const { base, args } = applyChain(n);
		// **アドレス経由の呼び出しは具体化されている。** 本体を出しているのは特定の実体
		// なので、`@p` の `p` が何を指すかはこの実体の中では決まっている
		// （compiler_pipeline.md §3 の IMPORTANT）。
		let callee = null;
		let baseName = null;
		if (isIdentifierNode(base)) {
			callee = bareName(base.value);
			baseName = callee;
		} else if (
			base && base.type === "operation" && base.position === "prefix" && base.name === "input" &&
			isIdentifierNode(base.operand) && scope && scope.callees && scope.callees[base.operand.value]
		) {
			callee = scope.callees[base.operand.value];
			baseName = callee;
		}
		if (!callee) {
			return em.fail(n, "呼び先が静的に決まりません（`$名前` で渡されたものだけ具体化できます）");
		}
		// 単相化された呼び出しでは、関数ポインタの引数は**命令へ焼き込まれている**ので
		// レジスタで渡さない。ここが「コンパイル時特殊化（コストゼロ）」の実体である。
		let drop = n.monoDrop || [];
		if (n.monoLabel) callee = n.monoLabel;
		else if (scope && scope.callees && Object.keys(scope.callees).length > 0) {
			// **具体化された実体の中では、仮引数の関数ポインタも既に決まっている。**
			// `take_while : p s ? … take_while p (s ' 1~)` の再帰は `$名前` ではなく `p` を
			// そのまま渡すので、呼び出しサイトの走査（`collectMonomorphs`）からは具体化
			// できない。だがこの実体の中では `p` が何を指すかは決まっているので、ここで
			// 同じ実体へ結び直す——そうしないと再帰だけが多相なまま取り残される。
			const passing = [];
			args.forEach((a, i) => {
				if (isIdentifierNode(a) && scope.callees[a.value]) passing.push({ i, to: scope.callees[a.value] });
			});
			if (passing.length > 0) {
				callee = `${callee}$${passing.map((x) => x.to).join("$")}`;
				drop = passing.map((x) => x.i);
			}
		}
		const passed = args.filter((_, i) => !drop.includes(i));
		// **数えるのは引数の個数ではなくレジスタの本数である。** 器を渡す引数は
		// `{ptr, len}` で2本使う（stack_abi.md §4.6）。
		const parts = [];
		for (const a of passed) {
			const w = genExpr(a, env, em, scope);
			if (w === false) return false;
			parts.push({ off: (em.slot - w) * 8, w });
		}
		const total = parts.reduce((acc, x) => acc + x.w, 0);
		if (total > ARG_REGS.length) {
			return em.fail(n, `引数がレジスタ ${ARG_REGS.length} 本を超えます（${passed.length} 個で ${total} 本）`);
		}
		// 引数レジスタへ積むのは**全部作り終えてから**。先に x0 へ書くと、2つ目の
		// 引数を作る途中で潰れる（式の中に呼び出しがあれば必ず潰れる）。
		let reg = 0;
		parts.forEach((part, i) => {
			for (let k = 0; k < part.w; k++) {
				em.load(ARG_REGS[reg], part.off + k * 8, k === 0 ? `第${i + 1}引数${part.w > 1 ? "の ptr" : ""}` : "その len");
				reg++;
			}
		});
		// **省略された引数には呼ぶ側が `__` を置く。**
		//
		// AAPCS64 は使われないレジスタを初期化しない。デフォルトを持つ仮引数は「渡されて
		// いなければ埋める」形で出しているので（`genFunction`）、渡されなかったことを
		// `__` で伝えないと**前の呼び出しの残骸をデフォルトの判定に使う**ことになる。
		// 評価器が `argIdx < argValues.length ? … : UNIT` と書いているのと同じことを、
		// 機械の上で明示する。
		const sig = em.signatures ? em.signatures.get(baseName) : null;
		if (sig) {
			const expect = sig.filter((_, i) => !drop.includes(i));
			let want = 0;
			let ok = true;
			for (const x of expect) {
				if (x.error || !x.regs) { ok = false; break; }
				want += x.regs;
			}
			if (ok && want > reg) {
				// 足りない位置の幅は署名が言う。幅ごとに `__` の表し方が違う。
				let at = reg;
				let seen = 0;
				for (const x of expect) {
					if (seen + x.regs > reg) {
						if (x.regs === 1) em.emit(`movz ${ARG_REGS[at]}, #0x8000, lsl #48`, "省略された引数は __");
						else {
							em.emit(`mov ${ARG_REGS[at]}, #0`, "省略された引数は __");
							em.emit(`mov ${ARG_REGS[at + 1]}, #0`, "（len = 0）");
						}
						at += x.regs;
					}
					seen += x.regs;
				}
			}
		}
		em.pop(total);

		// **末尾呼び出しは `bl` ではなく `b` である**（tco.md §6——最適化ではなく
		// 言語仕様としての保証）。Sign にループは無く再帰しかないので、ここを `bl` の
		// ままにすると再帰の深さがそのままスタックの深さになる。
		if (tail && scope) {
			if (callee === scope.selfLabel) {
				// 自己末尾再帰。フレームをそのまま使い回す。飛び先は**仮引数を写す前**
				// なので、完全性公理の検査も毎回通る——ここが終端である。
				em.emit(`b ${scope.loopLabel}`, "末尾自己再帰（フレーム再利用）");
				return TAIL;
			}
			// 相互末尾再帰。自分のフレームはもう死んでいるので畳んでから飛ぶ。
			// 大きさは本体を出し切るまで決まらないので印だけ置く。
			em.emit(`ldp x29, x30, [sp], #${FRAME_MARK}`, "自分のフレームを畳む");
			em.emit(`b ${callee}`, "末尾呼び出し");
			return TAIL;
		}

		em.emit(`bl ${callee}`, n.monoLabel ? "呼び出し（具体化済み）" : "呼び出し");
		// 返値の幅も型が決める。器を返す関数は x0/x1 で `{ptr, len}` を返す
		// （AAPCS64 が16バイトの複合型をそう返すのと同じ置き方）。
		// **返値の幅もノードが言う。** 規則（レンジ）は `{start, step, end}` で3本になる
		// ので、型だけを見ると参照（2本）と取り違える。
		const rw = slotsOfNode(n, em.conf, em.env);
		if (rw === null) return em.fail(n, `返値の渡し方が決まりません（${n.atomType}）`);
		// **返値も引数と同じくレジスタで運ぶ。** AAPCS64 は16バイトを超える複合型を sret へ
		// 送るが、Sign の関数は全て `main` の内部関数なので（execution_model）呼ぶ側と
		// 呼ばれる側の両方をこちらが決められる。規則は3本まで在るので x0〜x7 の範囲で運ぶ。
		if (rw > ARG_REGS.length) return em.fail(n, `返値が ${rw} 本の関数はまだ出せません（${n.atomType}）`);
		const rbase = em.slot;
		for (let k = 0; k < rw; k++) {
			if (em.push() === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
			em.store(ARG_REGS[k], (rbase + k) * 8, k === 0 ? (rw > 1 ? "返値の ptr" : "返値") : "返値の len");
		}
		return rw;
	}

	// **添字。** 器は `{ptr, len}` で来るので、引くのはアドレス計算1つである
	// （type_system.md §2 のアクセス表：`base + i × sizeof(T)`）。
	//
	//   s ' i    要素1つを読む     → 要素型（`Char` / `Int` …）
	//   s ' i~   そこから末尾まで   → 器と同じ型（`{ptr + i×幅, len - i}`）
	//
	// **どちらもメモリを要求しない。** 後者は同じ領域を指したまま頭と長さをずらすだけで、
	// `[h ~t]` の分解とまったく同じ機械である——`~` の意味が1つになったので、分解と
	// スライスが同じ規則の別の書き方であることが命令の上でも見えるようになった。
	// **レンジは規則である。** 置かれているのは `{start, step, end}` という固定サイズの
	// 3つ組だけで、要素列はどこにも無い（list_model.md §2.3）。だからレジスタに乗り、
	// 無限でも 24 バイトで済む。3つを連続したスロットへ積む——順に積めば連続する。
	if (n.type === "operation" && (n.name === "range" || n.name === "range_arithmetic")) {
		const parts = rangeParts(n);
		if (!parts) return em.fail(n, `等差のレンジだけを出せます（${n.op}——添字が start + i × step にならない）`);
		const want = slotsOfNode(n, em.conf, em.env);
		if (want === null) return em.fail(n, `レンジの渡し方が決まりません（${n.atomType}）`);
		const pieces = [parts.start, parts.step, ...(parts.end ? [parts.end] : [])];
		if (pieces.length !== want) return em.fail(n, `レンジの本数が合いません（${pieces.length} と ${want}）`);
		const base = em.slot;
		const names = ["start", "step", "end"];
		for (let i = 0; i < pieces.length; i++) {
			const w = genScalar(pieces[i], env, em, scope, "レンジの端点と歩幅はレジスタ1本の値です");
			if (w === false) return false;
			// 端点は積んだ順に並ぶ。連続しているので、そのまま `{start, step, end}` になる。
			if ((em.slot - 1) * 8 !== (base + i) * 8) {
				em.load(SCRATCH[0], (em.slot - 1) * 8);
				em.pop(1);
				em.push();
				em.store(SCRATCH[0], (base + i) * 8, names[i]);
			} else {
				em.emit(`// ${names[i]}`, i === 0 ? "規則（メモリ上に無い）" : undefined);
			}
		}
		// 歩幅を書かない形なら、置いた `1` を端点の並びで符号付きに直す。ここで畳んで
		// おけば、この先どれだけ切っても向きは動かない。
		if (parts.signedByEnds && pieces.length === 3) {
			em.load(SCRATCH[0], base * 8, "start");
			em.load(SCRATCH[1], (base + 2) * 8, "end");
			em.emit(`cmp ${SCRATCH[0]}, ${SCRATCH[1]}`);
			em.emit("mov x11, #1");
			em.emit("movn x12, #0", "−1");
			em.emit("csel x11, x11, x12, le", "昇順なら +1、降順なら −1");
			em.store("x11", (base + 1) * 8, "歩幅（向きを持つ）");
		}
		return want;
	}

	// **カーソルを組む。** `(arm s) , 0 , s` は積に見えるが、置かれるのは
	// `{arm, k, 入力}` の3つ組であってメモリ上の並びではない（stream_desugar.js）。
	// レンジと同じ機械で、順に積めば連続する。
	if (n.type === "operation" && n.name === "product" && n.repr === "cursor") {
		const want = slotsOfNode(n, em.conf, env);
		if (want === null) return em.fail(n, "カーソルの渡し方が決まりません");
		const parts = [];
		let cur = n;
		while (cur && cur.type === "operation" && cur.name === "product") {
			parts.unshift(cur.right);
			cur = cur.left;
		}
		parts.unshift(cur);
		if (parts.length !== 3) return em.fail(n, `カーソルは {arm, k, 入力} の3つです（${parts.length} つ来ました）`);
		const base = em.slot;
		const names = ["arm", "k", "入力"];
		for (let i = 0; i < parts.length; i++) {
			const w = genExpr(parts[i], env, em, scope);
			if (w === false) return false;
			if ((em.slot - w) * 8 !== (base + (i === 2 ? 2 : i)) * 8) {
				// 隙間ができたら詰める（前の項が複数本だった場合）。
				for (let k = 0; k < w; k++) {
					em.load(SCRATCH[0], (em.slot - w + k) * 8);
					em.store(SCRATCH[0], (base + (i === 2 ? 2 : i) + k) * 8, k === 0 ? names[i] : undefined);
				}
			} else {
				em.emit(`// ${names[i]}`, i === 0 ? "カーソル（メモリ上に無い）" : undefined);
			}
			if (i < 2 && w !== 1) return em.fail(parts[i], `カーソルの ${names[i]} はレジスタ1本の値です（${w} 本）`);
		}
		const got = em.slot - base;
		if (got !== want) return em.fail(n, `カーソルの本数が合いません（${got} と ${want}）`);
		return want;
	}

	// **`$` `@` `#` は niche を動かせない。**
	//
	// `$__ = __ = @__` は機械語の側の不動点である——記憶が無いものにアドレスは無く、
	// 無いアドレスから読めるものも無い。3つとも同じビット列（niche）であり、区別している
	// のは型だけである（`__` は `Unit`、`$__` は `Address`）。原理2「型はゼロコストの帳簿」
	// がそのまま出る場所で、`f $__` が完全性公理で崩壊しないのに1命令も余分に要らない。
	//
	// guide の演算子表が `$__ # expr` を「致命的なエラー（不正なアドレスへの書き込み）」と
	// 呼ぶのも同じことで、niche は書き込み先ではない。

	// 前置 `$`——アドレスを取る。
	if (n.type === "operation" && n.position === "prefix" && n.name === "address") {
		const t = unwrap(n.operand);
		const off = em.push();
		if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		// `$__` は niche そのもの。型は `Address` だがビットは `__` と同じ。
		if (t && t.type === "atom" && t.kind === "unit") {
			em.emit(`movz ${SCRATCH[0]}, #0x8000, lsl #48`, "$__ は niche（記憶が無いものにアドレスは無い）");
			em.store(SCRATCH[0], off);
			return 1;
		}
		// 仮引数はフレームに在るので、そのアドレスが取れる。
		if (isIdentifierNode(t) && scope && scope.params) {
			const i = scope.params.indexOf(t.value);
			if (i >= 0) {
				em.emit(`add ${SCRATCH[0]}, x29, #${16 + scope.paramOffsets[i]}`, `$${bareName(t.value)}（フレーム内）`);
				em.store(SCRATCH[0], off);
				return 1;
			}
		}
		em.pop(1);
		// 関数のアドレス（`$is_digit`）は単相化が扱うのでここへ来ない。
		return em.fail(n, `アドレスを取れるのはフレームに在るものだけです（${t && t.type === "atom" ? bareName(t.value) : t && t.name}）`);
	}

	// 前置 `@`——アドレスから読む。niche なら読まずに `__`。
	if (n.type === "operation" && n.position === "prefix" && n.name === "input") {
		if (!genScalar(n.operand, env, em, scope, "アドレスはレジスタ1本の値です")) return false;
		const po = (em.slot - 1) * 8;
		const w = widthOfType(n.atomType, em.conf);
		const none = em.newLabel("noaddr");
		const done = em.newLabel("loaded");
		em.load(SCRATCH[0], po, "アドレス");
		em.emit("movz x12, #0x8000, lsl #48", "niche なら記憶が無い");
		em.emit(`cmp ${SCRATCH[0]}, x12`);
		em.emit(`b.eq ${none}`, "@__ = __（読まない）");
		em.emit(loadAt(SCRATCH[0], SCRATCH[0], w), `${w} byte を読む`);
		em.emit(`b ${done}`);
		em.label(none);
		em.emit(`mov ${SCRATCH[0]}, x12`, "__");
		em.label(done);
		em.store(SCRATCH[0], po);
		return 1;
	}

	// 中置 `#`——アドレスへ書く。**守るのは左辺**（不正なアドレスへ書かない）。
	// 右辺の `__` は書ける——書けないと場所を空にできない。
	if (n.type === "operation" && n.name === "output" && n.position === "infix") {
		if (!genScalar(n.left, env, em, scope, "書き込み先はレジスタ1本のアドレスです")) return false;
		const po = (em.slot - 1) * 8;
		const vw = genExpr(n.right, env, em, scope);
		if (vw === false) return false;
		if (vw !== 1) { em.pop(vw); return em.fail(n.right, `書ける値はレジスタ1本ぶんです（${vw} 本の参照で運ぶ値）`); }
		const vo = (em.slot - 1) * 8;
		const w = widthOfType(n.right && n.right.atomType, em.conf);
		const skip = em.newLabel("nowrite");
		const done = em.newLabel("wrote");
		em.load(SCRATCH[0], po, "書き込み先");
		em.emit("movz x12, #0x8000, lsl #48", "niche は書き込み先ではない");
		em.emit(`cmp ${SCRATCH[0]}, x12`);
		em.emit(`b.eq ${skip}`, "不正なアドレスへは書かない");
		em.load(SCRATCH[1], vo, "書く値");
		em.emit(storeAt(SCRATCH[1], SCRATCH[0], w), `${w} byte を書く`);
		em.emit(`b ${done}`, "成功したらアドレスを返す");
		em.label(skip);
		em.emit(`mov ${SCRATCH[0]}, x12`, "書けなければ __");
		em.label(done);
		em.pop(1);
		em.store(SCRATCH[0], po);
		return 1;
	}

	if (n.type === "operation" && n.name === "get_prop" && !n.runtimeIndexProblem) {
		const out = genIndex(n, env, em, scope);
		if (out !== null) return out;
		// 出せない形（`Struct` のスロット・型が決まらない器）は下の診断へ落ちる。
	}

	// **多相な器を実行時の添字で引くのは、Sign が持たないと決めた唯一の場所である。**
	//
	// 他の言語が `dyn` や仮想テーブルで解くのがここであり、Sign は実行時ディスパッチを
	// 持たない（compiler_pipeline.md §3「コンパイル時のシミュレーション実行で解決
	// できなければ、それは単純にコンパイルエラーであり、実行時フォールバック経路を
	// 言語として持たない」）。「まだ実装していない」と読まれないよう言い分ける。
	if (n.type === "operation" && n.name === "get_prop" && n.runtimeIndexProblem) {
		return em.fail(
			n,
			n.runtimeIndexProblem === "named"
				? "名前付きスロットへ実行時の添字は引けません（物理配置は名前順、stack_abi.md §7.1）"
				: "多相な器へ実行時の添字は引けません——ここが動的型付けの要る唯一の場所であり、" +
					"Sign は実行時ディスパッチを持たない（compiler_pipeline.md §3）。スロットの型を揃えれば List になります"
		);
	}
	// **器を作る式は、記憶を確保できる layer でしか成立しない。**
	//
	// `layer: 0` には確保の手段が無い（前置 `#` はコンパイルエラー、memory_management.md
	// §2 の表）。あるのは `alloca` と `.rodata` だけで、`alloca` は自分のフレームなので
	// 返せない。切り出し（`s ' i~`）がコピー無しで作れるのとは別の話である——あちらは
	// 既にある記憶を指し直すだけで、新しい場所を要求しない。
	//
	// layer が上がっても今は出せないが、そのときの理由は「確保の規約が未定」であって
	// 「この layer では書けない」ではない。**同じ「出せない」でも中身が違う**ので分ける。
	// **分解したものを組み直すのは恒等射である。**
	//
	// `body_of : [c ~rest] ? … c rest` の `c rest` は、渡された器そのものである。
	// `[c ~rest]` は器をその場で分解する形（コピーはしない）なので、`rest` は同じ領域の
	// 頭を1つ進めた参照であり、`c` はその手前の1要素である。したがって組み直した結果は
	// `{rest.ptr − 幅, rest.len + 1}`——**確保は要らない**。切り出しの逆向きであり、
	// 「作られた器は規則である」という答えの、いちばん小さい形にあたる。
	//
	// 見るのは形だけである（同じ分解の頭と残りが、その順で並んでいるか）。`c` が本体で
	// 書き換えられていたら別の値なので、そこは束縛が動いていないことを確かめる。
	if (COPRODUCT_BUILD_OPS.has(n.name)) {
		const pair = rejoinPair(n, scope);
		if (pair) {
			const off = em.slot;
			if (em.push() === null || em.push() === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
			const w = pair.elemSize || 1;
			em.load(SCRATCH[0], pair.restOff, "残りの ptr");
			em.emit(`sub ${SCRATCH[0]}, ${SCRATCH[0]}, #${w}`, `頭を1要素ぶん戻す（${w} byte）`);
			em.store(SCRATCH[0], off * 8, "組み直した ptr（確保は要らない）");
			em.load(SCRATCH[0], pair.restOff + 8, "残りの len");
			em.emit(`add ${SCRATCH[0]}, ${SCRATCH[0]}, #1`, "長さを1つ戻す");
			em.store(SCRATCH[0], (off + 1) * 8, "組み直した len");
			return 2;
		}
	}
	if (COPRODUCT_BUILD_OPS.has(n.name) && slotsOf(n.atomType, em.conf) === 2) {
		if (em.conf.layer !== undefined && em.conf.layer < 1) {
			return em.fail(
				n,
				`layer: ${em.conf.layer} では器を作れません（${n.atomType} の記憶を確保する手段が無い）。` +
					`切り出し（\`s ' i~\`）は確保が要らないので使えます`
			);
		}
		return em.fail(n, `器の構築はまだ出せません（${n.atomType}——確保の規約が未定。返値は sret へ向かう）`);
	}
	return em.fail(n, `まだ出せない式です（${n.name || n.type}）`);
}

/**
 * `__` を幅ぶん置く。**表し方は幅ごとに違う。**
 *
 *   1本（レジスタ上の値）  上位ビットの niche（value_representation.md §3.5）
 *   2本（`{ptr, len}`）    `len = 0`
 *
 * 2本目が `len = 0` なのは、**空文字列・空リストが `__` そのものだから**である
 * （`__ = []`、unit.md §値としての性質 / type_system.md §空文字列）。零対象は一つしか
 * ないので、器の側にも既に `__` の置き場所がある——新しい表現を足したのではなく、
 * 元からある同一視をそのまま命令にしている。`String` は2文字以上、`Char` は1文字
 * なので、`len = 0` は他の値と衝突しない。
 */
function emitUnit(em, offs) {
	if (offs.length === 1) {
		em.emit("movz x12, #0x8000, lsl #48", "__ の niche");
		em.store("x12", offs[0]);
		return;
	}
	em.emit("mov x12, #0", "__ は空（`__ = []`）");
	em.store("x12", offs[0], "ptr");
	em.store("x12", offs[1], "len = 0 が __");
}

/**
 * 添字（`'`）を出す。出せない形なら `null` を返して呼び出し元の診断へ渡す。
 *
 * **1要素リストとスカラーは同型である**（`[5]` は `Int`、list_model.md）。だから器の幅が
 * 1本のときも同じ規則で引ける——`x ' 0` は `x` 自身、`x ' 1` は範囲外で `__` である。
 * 器が2本（`{ptr, len}`）のときだけアドレス計算になる。
 */
// 左辺が規則か（レンジ・イテレータ）。規則はレジスタに乗り、添字は算術で出る。
function isRuleNode(node, conf, env) {
	const p = node ? passingOf(node, { target: conf.target, charset: conf.charset, env }) : null;
	return !!p && p.mode === "register" && p.slots >= 2;
}
// カーソルかどうか。「どう置かれているか」の帳簿を見る（`repr`）。
function cursorGroupOf(node, env) {
	if (!node) return null;
	if (node.cursorGroup) return node.cursorGroup;
	if (isIdentifierNode(node) && env) {
		const b = envLookup(env, node.value);
		if (b && b.cursorGroup) return b.cursorGroup;
		if (b && b.returnsCursorGroup) return b.returnsCursorGroup;
	}
	return null;
}

/**
 * **カーソルを引く・進める。**
 *
 * `cur ' 0` が k 番目の要素、`cur ' 1~` が1つ進めたカーソルである。どちらも生成された
 * Sign の関数（`<g>_at` / `<g>_adv`）を呼ぶだけで済む——分岐や次の枝の選び方は Sign の
 * 側に書いてあるので、命令の側へ持ち込む必要が無い（stream_desugar.js）。
 *
 * `cur ' i`（i が 0 以外）は出せない。枝をいくつ跨ぐかは実行時にしか分からないので、
 * 走らせる命令列になる——それは `' 1~` を繰り返すことであって、添字の算術ではない。
 * 黙って別の答えを出さず名指しする。
 */
function genCursorIndex(node, env, em, scope, group, cbase) {
	const conf = em.conf;
	// 幅も命令も**剥いだ先**で測る。括弧のノードは「どう置かれているか」を持たない。
	const cw = slotsOfNode(cbase, conf, env);
	if (cw === null || cw < 3) return em.fail(node, `カーソルの本数が決まりません（${cw}）`);
	const idx = unwrap(node.right);
	const isSlice = !!idx && idx.type === "operation" && idx.name === "range_arithmetic";
	const start = isSlice ? unwrap(idx.left) : idx;
	const isLiteral = (n, v) => n && n.type === "atom" && n.kind === "number" && Number(n.value) === v;
	if (isSlice) {
		if (!isLiteral(start, 1) || !isLiteral(unwrap(idx.right), 1)) {
			return em.fail(node, "カーソルは1つずつしか進められません（`cur ' 1~` だけ出せます）");
		}
	} else if (!isLiteral(start, 0)) {
		return em.fail(node, "カーソルは先頭しか引けません（`cur ' 0` だけ出せます——途中を引くのは進めることの繰り返しです）");
	}
	// カーソルの3つ組（か4つ組）をそのまま引数へ載せる。`{arm, k, 入力…}` の並びが
	// `<g>_at` / `<g>_adv` の仮引数の並びと同じなので、詰め替えは要らない。
	const w = genExpr(cbase, env, em, scope);
	if (w === false) return false;
	if (w !== cw) { em.pop(w); return em.fail(node, `カーソルの本数が合いません（${w} と ${cw}）`); }
	const base = em.slot - cw;
	if (cw > ARG_REGS.length) return em.fail(node, `カーソルが ${cw} 本でレジスタに載りません`);
	for (let k = 0; k < cw; k++) em.load(ARG_REGS[k], (base + k) * 8, k === 0 ? "カーソルをそのまま渡す" : undefined);
	const callee = group + (isSlice ? CURSOR_SUFFIXES.adv : CURSOR_SUFFIXES.at);
	em.emit(`bl ${callee}`, isSlice ? "1つ進めたカーソル" : "先頭の要素");
	em.pop(cw);
	// 引いた結果は要素1つ、進めた結果はカーソルそのもの。
	const outw = isSlice ? cw : 1;
	const off = [];
	for (let k = 0; k < outw; k++) {
		const o = em.push();
		if (o === null) return em.fail(node, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		off.push(o);
	}
	for (let k = 0; k < outw; k++) em.store(ARG_REGS[k], off[k], k === 0 ? (isSlice ? "進めたカーソル" : "要素") : undefined);
	return outw;
}

function genIndex(node, env, em, scope) {
	const conf = em.conf;
	// **カーソルは器でも規則でもない。** 引き方が違うので、先に振り分ける。
	// 括弧は剥ぐ——`(dup s) ' 0` のように括った形が普通である。
	const cbase = unwrap(node.left);
	const cgroup = cbase && cbase.repr === "cursor" ? cursorGroupOf(cbase, env) : null;
	if (cgroup) return genCursorIndex(node, env, em, scope, cgroup, cbase);
	const cw = slotsOfNode(node.left, conf, env);
	const rw = slotsOfNode(node, conf, env);
	// 規則は3本（`{start, step, end}`）まで在る。場所は2本まで。
	if (cw === null || rw === null || cw > 3 || rw > 3) return null;
	// スライスかどうかは**添字の形**で決まる。`s ' i~` は Pass 2 が `s ' (i ~+ 1)` へ
	// 均しているので（`desugarIndexRest`）、ここで見るのは終端の無い等差レンジである。
	// **括弧は剥ぐ。** `s ' (1 ~+ 1)` のように優先順位のために括った形も同じスライスで
	// ある。pass3 の `sliceIndexNode` は剥いでいたので、型は「部分列」と言うのに命令は
	// 「要素1つ」を出そうとして幅が合わなくなっていた——同じ式について2つのパスが違う
	// ことを言う、いつもの壊れ方である。
	const idx = unwrap(node.right);
	const isSlice = !!idx && idx.type === "operation" && idx.name === "range_arithmetic";
	const ruleLeft = isRuleNode(node.left, conf, env);
	if (isSlice) {
		// 歩幅1の「そこから末尾まで」だけを出せる。飛ばし読みは別の命令列になる。
		// ここで見ているのは**添字の歩幅**であって器の歩幅ではない——`[0 ~+ 2] ' 1~` の
		// 添字は `1 ~+ 1`（1番目から全部）で、器の歩幅 2 とは別物である。
		const step = idx.right;
		if (!(step && step.type === "atom" && step.kind === "number" && Number(step.value) === 1)) return null;
		if (rw !== cw) return null; // 部分列は器と同じ型でなければおかしい
	}

	// **規則を切っても規則である。**
	//
	// `{start, step, end}` から i 番目以降を取るのは `{start + i × step, step, end}` で、
	// 要素はどこにも現れない——`[h ~t]` が参照の頭と長さをずらすのと同じ機械が、規則の
	// 側では起点をずらす算術1つになる。切っても向きが動かないのは step が符号を持つから
	// である（`rangeParts` の `signedByEnds`）。
	//
	// これはカーソルを進める操作の原型でもある。`cur ' 1~` が次の状態そのものなので、
	// 状態を持ち回るのに記憶は要らない。
	if (isSlice && ruleLeft && cw >= 2) {
		const cvw0 = genExpr(node.left, env, em, scope);
		if (cvw0 === false) return false;
		if (cvw0 !== cw) { em.pop(cvw0); return null; }
		const co0 = (em.slot - cw) * 8;
		const iw0 = genScalar(idx.left, env, em, scope, "規則の起点はレジスタ1本の値です");
		if (iw0 === false) return false;
		const io0 = (em.slot - 1) * 8;
		em.load(SCRATCH[0], co0, "start");
		em.load(SCRATCH[1], co0 + 8, "step");
		em.load("x11", io0, "起点");
		em.emit(`madd ${SCRATCH[0]}, ${SCRATCH[1]}, x11, ${SCRATCH[0]}`, "start + i × step（ずらすだけ）");
		em.pop(1);
		em.store(SCRATCH[0], co0, "切った先の start");
		return cw;
	}
	// 要素の幅。`String` なら charset 幅、`List(T)` なら T の大きさ。
	const elemType = isSlice ? node.elementType || elementTypeOfNode(node.left) : node.atomType;
	const elem = elemType ? measure({ atomType: elemType }, { target: conf.target, charset: conf.charset }) : null;
	// 要素の幅が要るのは**場所**を引くときだけである（`base + i × sizeof(T)`）。規則は
	// `start + i × step` なので、要素が何バイトかを知らなくても引ける——`step` が既に
	// 要素の単位で書かれているからである。
	if (cw === 2 && !ruleLeft && (!elem || !elem.size)) return null;

	const cvw = genExpr(node.left, env, em, scope);
	if (cvw === false) return false;
	if (cvw !== cw) { em.pop(cvw); return null; }
	const co = (em.slot - cw) * 8;

	// **規則の添字はロードではない。**
	//
	// 置かれているのは `{start, step, end}` だけで要素列はどこにも無いので、n 番目は
	// `start + n × step` という**算術**で出る（type_system.md §2 のアクセス表「添字は
	// 必ずしもロードではない」）。だから無限でも引ける——これがループカウンタを成立させて
	// いる。ここを場所と同じ経路へ流すと、`start` をポインタ・`step` を長さとして読む
	// 命令が出る（実際に出ていた）。
	if (ruleLeft && cw >= 2) {
		const iw2 = genScalar(node.right, env, em, scope, "規則の添字はレジスタ1本の値です");
		if (iw2 === false) return false;
		const io2 = (em.slot - 1) * 8;
		em.load(SCRATCH[0], co, "start");
		em.load(SCRATCH[1], co + 8, "step");
		em.load("x11", io2, "添字");
		em.emit(`madd ${SCRATCH[0]}, ${SCRATCH[1]}, x11, ${SCRATCH[0]}`, "start + n × step（ロードではない）");
		if (cw >= 3) {
			// 終端があるなら範囲を見る。**向きは歩幅の符号が持つ**——端点の並びを読み直す
			// のではない。切った規則（`[0 ~ 3] ' 5~`）は起点が終端を越えているので、
			// 並びから読むと降順に見えてしまう。
			em.load("x13", co + 16, "end");
			em.load("x14", co + 8, "step");
			em.emit(`cmp ${SCRATCH[0]}, x13`);
			em.emit("cset x15, gt", "昇順なら end を越えたら外");
			em.emit("cset x11, lt", "降順なら end を下回ったら外");
			em.emit("cmp x14, #0");
			em.emit("csel x15, x15, x11, ge", "歩幅の符号で選ぶ");
			em.emit("movz x12, #0x8000, lsl #48", "範囲外は __");
			em.emit("cmp x15, #0");
			em.emit(`csel ${SCRATCH[0]}, x12, ${SCRATCH[0]}, ne`);
		}
		em.pop(cw + 1);
		const off2 = em.push();
		if (off2 === null) return em.fail(node, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		em.store(SCRATCH[0], off2, "n 番目");
		return 1;
	}
	// 添字そのもの（スライスなら起点）を積む。
	const iw = genExpr(isSlice ? idx.left : idx, env, em, scope);
	if (iw === false) return false;
	if (iw !== 1) { em.pop(iw + cw); return null; }
	const io = (em.slot - 1) * 8;

	if (cw === 1) {
		// **スカラーは1要素の器である。** 0 番目は自分自身、それ以外は範囲外で `__`。
		em.load(SCRATCH[0], io, "添字");
		em.emit(`cmp ${SCRATCH[0]}, #0`);
		em.load(SCRATCH[0], co, "0 番目は器そのもの");
		em.emit("movz x12, #0x8000, lsl #48", "範囲外は __");
		em.emit(`csel ${SCRATCH[0]}, ${SCRATCH[0]}, x12, eq`);
		em.pop(1);
		em.store(SCRATCH[0], co);
		// スライス（`x ' 0~`）の結果も同じ——1要素の器を切っただけである。
		return 1;
	}

	const w = elem.size;
	if (isSlice) {
		// `{ptr + i×幅, len - i}`。**同じ領域を指したまま頭と長さをずらす**——コピー無し。
		em.load(SCRATCH[0], co, "ptr");
		em.load(SCRATCH[1], io, "起点");
		em.emit(`add ${SCRATCH[0]}, ${SCRATCH[0]}, ${SCRATCH[1]}${w === 1 ? "" : `, lsl #${Math.log2(w)}`}`, `${w} byte × 起点`);
		em.store(SCRATCH[0], co, "残りの ptr");
		em.load(SCRATCH[0], co + 8);
		em.emit(`subs ${SCRATCH[0]}, ${SCRATCH[0]}, ${SCRATCH[1]}`, "残りの長さ");
		// 負にはしない。**尽きたら `len = 0`** であり、それが `__` である。
		em.emit(`csel ${SCRATCH[0]}, ${SCRATCH[0]}, xzr, pl`);
		em.pop(1);
		em.store(SCRATCH[0], co + 8, "残りの len（0 なら __）");
		return 2;
	}

	// 要素1つ。範囲外は `__`（niche）。
	em.load(SCRATCH[1], io, "添字");
	em.load(SCRATCH[0], co + 8, "len");
	em.emit(`cmp ${SCRATCH[1]}, ${SCRATCH[0]}`, "範囲内か");
	em.load(SCRATCH[0], co, "ptr");
	em.emit(loadElem("w14", SCRATCH[0], SCRATCH[1], w), `${w} byte の要素`);
	em.emit("movz x12, #0x8000, lsl #48", "範囲外は __");
	em.emit(`csel ${SCRATCH[0]}, x14, x12, lo`);
	// 器（cw 本）と添字（1本）を返してから、要素1本を積む。
	em.pop(cw + 1);
	const off = em.push();
	if (off === null) return em.fail(node, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
	em.store(SCRATCH[0], off, "要素");
	return 1;
}

/**
 * `head rest` が**同じ分解の組み直し**かを見る。そうなら参照を戻すだけで済む。
 *
 * 順序も見る——`rest c` は「残りのうしろへ頭を足す」であって別の器である。
 */
function rejoinPair(node, scope) {
	if (!scope || !scope.bracketPairs || scope.bracketPairs.length === 0) return null;
	const l = unwrap(node.left);
	let r = unwrap(node.right);
	if (!isIdentifierNode(l)) return null;
	// **撒くかどうかで意味が違う。**
	//
	//   c rest~   撒いて繋ぐ  → 渡された器そのもの（組み直し）
	//   c rest    1要素として足す → `[c, rest]` という**別の器**
	//
	// 器の側に後置 `~` が要るのが仕様である（分解の `[c ~rest]` と対称）。ただし
	// `String` だけは撒かない形もテキスト連結になる（余積族の規則「左辺が String なら
	// テキスト連結」）ので、そこは同じ答えになる。**そこ以外で撒かない形に当てると、
	// 入れ子であるべきものを平らにしてしまう**——List で実際にそうなる。
	const spread = !!r && r.type === "operation" && r.position === "postfix" && r.name === "expand";
	if (spread) r = unwrap(r.operand);
	if (!isIdentifierNode(r)) return null;
	if (!spread && node.atomType !== "String") return null;
	for (const p of scope.bracketPairs) {
		if (l.value === p.head && r.value === p.rest) return p;
	}
	return null;
}

// 器の要素型。`elementType` はレンジ・List に付く（pass3.js）。
function elementTypeOfNode(n) {
	if (!n) return null;
	if (n.elementType) return n.elementType;
	return n.atomType === "String" ? "Char" : null;
}

/**
 * **器どうしの等価**（`s = t` / `s != t`）。`{ptr, len}` を2本ずつ受けて、真なら左辺、
 * 偽なら `__` を積む（comparison.md §2.1「比較は値を返す」）。
 *
 * 返すのが左辺なのは、0/1 の規則（左辺が算術単位元なら右辺）が `String` には効かない
 * からである——器は加法単位元でも乗法単位元でもない。
 *
 * **メモリは要らない。** 読むだけであり、新しい `{ptr, len}` も作らない。真のときに返す
 * のは左辺そのものであり、偽のときは `len = 0`（＝`__`、unit.md）である。
 *
 * 長さが違えば中身を見るまでもない。同じなら要素を1つずつ見る——要素の幅は `charset` が
 * 決める（`String ≅ List(Char)` の要素幅そのもの）。
 */
function genStringCompare(node, env, em, scope) {
	const w = charSizeOf(em.conf.charset);
	if (!genExpr(node.left, env, em, scope)) return false;
	const lo = (em.slot - 2) * 8;
	if (!genExpr(node.right, env, em, scope)) return false;
	const ro = (em.slot - 2) * 8;
	const wantEqual = node.name === "assign_equal";
	const same = em.newLabel("streq");
	const diff = em.newLabel("strne");
	const end = em.newLabel("strend");
	const loop = em.newLabel("strloop");

	em.load(SCRATCH[0], lo + 8, "左辺の len");
	em.load(SCRATCH[1], ro + 8, "右辺の len");
	em.emit(`cmp ${SCRATCH[0]}, ${SCRATCH[1]}`, "長さが違えば中身を見るまでもない");
	em.emit(`b.ne ${diff}`);
	// 位置を進めながら1要素ずつ比べる。x13 が位置、x14/x15 が読んだ要素。
	em.emit("mov x13, #0", "位置");
	em.label(loop);
	em.emit(`cmp x13, ${SCRATCH[0]}`);
	em.emit(`b.ge ${same}`, "末尾まで一致した");
	em.load(SCRATCH[1], lo, "左辺の ptr");
	em.emit(loadElem("w14", SCRATCH[1], "x13", w), `${w} byte の要素`);
	em.load(SCRATCH[1], ro, "右辺の ptr");
	em.emit(loadElem("w15", SCRATCH[1], "x13", w));
	em.emit("cmp w14, w15");
	em.emit(`b.ne ${diff}`);
	em.emit("add x13, x13, #1");
	em.emit(`b ${loop}`);

	// 真なら左辺、偽なら `__`（`len = 0`）。どちらの枝も左辺のスロットへ揃える。
	const put = (isTrue) => {
		if (isTrue) {
			em.load(SCRATCH[0], lo);
			em.load(SCRATCH[1], lo + 8);
		} else {
			em.emit(`mov ${SCRATCH[0]}, #0`, "__ は空（len = 0）");
			em.emit(`mov ${SCRATCH[1]}, #0`);
		}
		em.store(SCRATCH[0], lo, isTrue ? "真なら左辺" : "偽なら __");
		em.store(SCRATCH[1], lo + 8);
	};
	em.label(same);
	put(wantEqual);
	em.emit(`b ${end}`);
	em.label(diff);
	put(!wantEqual);
	em.label(end);
	em.pop(2); // 右辺の2本を返す。結果は左辺のスロットにある。
	return 2;
}

/**
 * match_case の並びを分岐へ落とす。結果は呼び出し元が使うスロットへ揃える
 * ——どの枝を通っても同じ場所に値がある、という一点を守る。
 */
function genMatch(node, env, em, scope, tail = false) {
	// **どの枝も同じ幅でなければ、置き場所が決まらない。** `Char | String` のような直和は
	// 「1本の枝と2本の枝」を1つの場所へ揃えろと言っていることになる。仕様は答えを持って
	// いる——「表現の違う枝の直和は広い方に揃え、`Char` の枝は境界で1要素の連続領域へ
	// 持ち上げる」（type_system.md §2）——が、その持ち上げにはメモリの確保が要るので
	// ここではまだ出さない。黙って先頭だけ置かず名指しする。
	const width = slotsOfNode(node, em.conf, em.env);
	if (width === null) {
		return em.fail(node, `枝の幅が揃いません（${node.atomType}）——広い方へ揃える持ち上げがまだ出せません（type_system.md §2）`);
	}
	// レジスタに載る幅なら合流できる。**カーソルは4本**（`{arm, k, ptr, len}`）なので、
	// 2本で打ち切っていると枝の合流ができない。載らない幅はメモリの確保が要るので、
	// そこは名指しする。
	if (width > ARG_REGS.length) return em.fail(node, `${width} 本で運ぶ値を返す分岐はまだ出せません（${node.atomType}）`);

	const outs = [];
	for (let k = 0; k < width; k++) {
		const o = em.push();
		if (o === null) return em.fail(node, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		outs.push(o);
	}
	// 枝の値を出力スロットへ写す。幅が合わない枝は上と同じ持ち上げの話なので落とす。
	//
	// **枝の値は末尾位置である。** 分岐の結果がそのまま関数の返値になるので、そこにある
	// 呼び出しは末尾呼び出しである（interpreter.js の `evaluateTail` も同じ規則で
	// ブロックの各行を辿る）。飛んで行った枝は値を置かないので `TAIL` を返す。
	const move = (line) => {
		const w = genExpr(line, env, em, scope, tail);
		if (w === false) return false;
		if (w === TAIL) return TAIL;
		if (w !== width) {
			em.pop(w);
			return em.fail(line, `枝の幅が揃いません（${w} 本と ${width} 本）——広い方へ揃える持ち上げがまだ出せません（type_system.md §2）`);
		}
		const base = em.slot - w;
		for (let k = 0; k < w; k++) {
			em.load(SCRATCH[0], (base + k) * 8);
			em.store(SCRATCH[0], outs[k], k === 0 ? "枝の値" : undefined);
		}
		em.pop(w);
		return true;
	};

	const end = em.newLabel("end");
	const lines = node.lines;
	for (let i = 0; i < lines.length; i++) {
		const line = lines[i];
		const isArm = isDefineNode(line);
		if (!isArm) {
			// フォールバック。条件を見ずにここへ来たら必ず値になる。
			if (!move(line)) return false;
			break;
		}
		const next = em.newLabel("arm");
		// **条件の幅は問わない。** 見るのは「`__` かどうか」だけであり、その判定は幅ごとに
		// 決まっている（1本なら niche、2本なら `len = 0`）。比較は値を返すので
		// （comparison.md §2.1）、`s = \`abc\`` のように条件が器になることがある。
		const cw = genExpr(line.left, env, em, scope);
		if (cw === false) return false;
		if (cw === TAIL) return em.fail(line.left, "条件の位置に末尾呼び出しは置けません");
		// 規則かどうかを見るのは**条件の式**である（`node` は分岐そのもので `left` を持たない）。
		emitIsUnit(em, (em.slot - cw) * 8, cw, "条件", isRuleNode(line.left, em.conf, em.env));
		em.pop(cw);
		em.emit(`b.eq ${next}`, "__ なら次の枝へ");
		const armResult = move(line.right);
		if (armResult === false) return false;
		// 飛んで行った枝は合流点へ戻ってこないので、`b` を出す意味が無い。
		if (armResult !== TAIL) em.emit(`b ${end}`);
		em.label(next);
		// 最後の行が条件付きなら、どの枝も通らない場合がある。そのときの値は `__`。
		if (i === lines.length - 1) emitUnit(em, outs);
	}
	em.label(end);
	return width;
}

/**
 * 値が `__` かどうかを見て、フラグを立てる（真なら `eq`）。
 *
 * **判定の仕方は幅で違う。** `emitUnit` の裏返しである——1本ならレジスタ上の niche と
 * 比べ、2本なら `len` が 0 かを見る（空文字列・空リストが `__` そのもの、unit.md）。
 */
// 要素1つを位置つきで読むニーモニック。幅は `charset` が決める（`String ≅ List(Char)`）。
// 符号なしなので `ldrb`/`ldrh` はゼロ拡張で足りる（Char は unsigned、target_info.js）。
function loadElem(dst, base, idx, size) {
	if (size === 1) return `ldrb ${dst}, [${base}, ${idx}]`;
	if (size === 2) return `ldrh ${dst}, [${base}, ${idx}, lsl #1]`;
	return `ldr ${dst}, [${base}, ${idx}, lsl #2]`;
}

// 幅ぶんのロード／ストア。`layer: 0` は volatile だが、Pass 4 は並べ替えも削除もしないので
// 素の `ldr`/`str` がそのまま volatile の意味を満たす（memory_management.md §2）。
/**
 * レンジ式から `{start, step, end}` を取り出す。書き方は3つあるが実体は1つである。
 *
 *   [0 ~+ 1]      range_arithmetic(0, 1)              終端なし → 無限
 *   [1 ~ 5]       range(1, 5)                         歩幅は暗黙の 1
 *   [2 ~+ 3 ~ 9]  range(range_arithmetic(2, 3), 9)    全部書いた形
 *
 * 出せるのは**等差**（`~` / `~+`）だけである。等比・冪（`~*` `~^`）は同じ3つ組で運べるが
 * 添字が `start + i × step` にならないので、命令が別になる（type_system.md §2 のアクセス表）。
 */
function rangeParts(node) {
	const ONE = { type: "atom", kind: "number", value: "1", atomType: "Int" };
	if (node.name === "range_arithmetic") {
		if (node.op !== "~+") return null;
		return { start: node.left, step: node.right, end: null };
	}
	if (node.name !== "range") return null;
	const l = node.left;
	if (l && l.type === "operation" && l.name === "range_arithmetic") {
		if (l.op !== "~+") return null;
		return { start: l.left, step: l.right, end: node.right };
	}
	// **歩幅を書かない形（`[a ~ b]`）の向きは、端点の並びが決める。**
	//
	// `[5 ~ 1]` は 5,4,3,2,1 なので歩幅は −1 である（interpreter.js の `delta`）。
	// ところが端点は実行時の値かもしれないので、符号はここでは決まらない——`signedByEnds`
	// を立てて、置くときに `start <= end` を見て ±1 を作らせる。
	//
	// 向きを step へ畳むのが要なのは、**規則を切ったあとも向きが残る**からである。
	// `[0 ~ 3] ' 5~` の起点は 5 で終端は 3 だから、並びから向きを読み直すと降順に見えて
	// しまう。step が符号を持っていれば、切っても向きは動かない。
	return { start: l, step: ONE, end: node.right, signedByEnds: true };
}
/**
 * 64ビットの即値をレジスタへ置く。
 *
 * AArch64 の `mov` に載る即値は16ビットまでなので、超える値は `movz` で最下位の非零な
 * 16ビットを置き、残りを `movk` で埋める。**桁を落として黙って通さない**——`0x40000000`
 * のような MMIO のアドレスは、下位16ビットだけ置くと別の番地を触ることになる。
 *
 * 負の値は2の補数のビット列をそのまま置く。`movn` を使えば命令が減る場合もあるが、
 * `movz`/`movk` は常に正しい——短くするのは、正しさを確かめてからで足りる。
 */
function emitImm(em, reg, value, comment) {
	const u = BigInt.asUintN(64, BigInt(value));
	const chunks = (fill) => {
		const out = [];
		for (let shift = 0; shift < 64; shift += 16) {
			const c = (u >> BigInt(shift)) & 0xffffn;
			if (c !== fill) out.push([shift, c]);
		}
		return out;
	};
	const zeros = chunks(0n); // 0 で埋まらない桁
	const ones = chunks(0xffffn); // 0xffff で埋まらない桁
	const lsl = (shift) => (shift === 0 ? "" : `, lsl #${shift}`);

	// 16ビットに収まる正の値は `mov` 1つ。これは `movz` の別名なので出る機械語は同じで、
	// 読むときに桁を数えなくて済む。
	if (u <= 0xffffn) {
		em.emit(`mov ${reg}, #${u}`, comment);
		return;
	}

	// 負の値は上の桁が 0xffff で埋まる。`movn` は反転を置くので、そちらが短い。
	// `-1` は `movn reg, #0` の1命令で済む。
	if (ones.length < zeros.length) {
		if (ones.length === 0) {
			em.emit(`movn ${reg}, #0`, comment);
			return;
		}
		const [s0, c0] = ones[0];
		em.emit(`movn ${reg}, #0x${(0xffffn ^ c0).toString(16)}${lsl(s0)}`, comment);
		for (const [s, c] of ones.slice(1)) em.emit(`movk ${reg}, #0x${c.toString(16)}${lsl(s)}`);
		return;
	}
	if (zeros.length === 0) {
		em.emit(`mov ${reg}, #0`, comment);
		return;
	}
	const [s0, c0] = zeros[0];
	em.emit(`movz ${reg}, #0x${c0.toString(16)}${lsl(s0)}`, comment);
	for (const [s, c] of zeros.slice(1)) em.emit(`movk ${reg}, #0x${c.toString(16)}${lsl(s)}`);
}
function loadAt(dst, base, size) {
	if (size === 1) return `ldrb ${dst.replace("x", "w")}, [${base}]`;
	if (size === 2) return `ldrh ${dst.replace("x", "w")}, [${base}]`;
	if (size === 4) return `ldr ${dst.replace("x", "w")}, [${base}]`;
	return `ldr ${dst}, [${base}]`;
}
function storeAt(src, base, size) {
	if (size === 1) return `strb ${src.replace("x", "w")}, [${base}]`;
	if (size === 2) return `strh ${src.replace("x", "w")}, [${base}]`;
	if (size === 4) return `str ${src.replace("x", "w")}, [${base}]`;
	return `str ${src}, [${base}]`;
}

// 型が言う幅（決まらなければ GPR 幅）。
function widthOfType(type, conf) {
	const m = type ? reduceToMachineType(type, conf.target) : null;
	return m && m.class === "gpr" ? m.size : 8;
}
function emitIsUnit(em, off, width, comment, isRule = false, isCursor = false) {
	// カーソルは先頭の `arm` だけ見る。空の入力から枝は選べないので、`_arm` が
	// 完全性公理で `__` を返し、それがそのまま先頭に立つ。
	if (isCursor) {
		em.load(SCRATCH[0], off, comment);
		em.emit("movz x12, #0x8000, lsl #48", "__ の niche（arm）");
		em.emit(`cmp ${SCRATCH[0]}, x12`);
		return;
	}
	if (width === 1) {
		em.load(SCRATCH[0], off, comment);
		em.emit("movz x12, #0x8000, lsl #48", "__ の niche");
		em.emit(`cmp ${SCRATCH[0]}, x12`);
		return;
	}
	// **規則が尽きているかは `len` では分からない。** 置かれているのは
	// `{start, step, end}` であって、2本目は長さではなく歩幅である。ここを場所と同じ
	// 経路へ流すと「歩幅が 0 か」を見ることになり、歩幅は 0 にならないので**規則は
	// 決して尽きない**ことになる。カーソルを1歩多く回していたのはこれである。
	if (isRule) {
		if (width < 3) {
			// 終端が無い＝無限。尽きない。呼ぶ側は直後に `b.eq` を置くので、`eq` が
			// 立たない形にしておく。2命令とも消せるが、消すのは正しさを確かめてからで足りる。
			em.emit("mov x12, #1", `${comment}（終端が無いので尽きない）`);
			em.emit("cmp x12, #0");
			return;
		}
		em.load(SCRATCH[0], off, comment);
		em.load("x10", off + 8, "step");
		em.load("x13", off + 16, "end");
		em.emit(`cmp ${SCRATCH[0]}, x13`);
		em.emit("cset x14, gt", "昇順なら end を越えていたら空");
		em.emit("cset x15, lt", "降順なら end を下回っていたら空");
		em.emit("cmp x10, #0");
		em.emit("csel x14, x14, x15, ge", "歩幅の符号で選ぶ");
		em.emit("cmp x14, #1", "空が __");
		return;
	}
	// 2本のときは `len` を見る。`ptr` は何を指していても関係ない。
	em.load(SCRATCH[0], off + 8, comment);
	em.emit(`cmp ${SCRATCH[0]}, #0`, "len = 0 が __");
}

// 返値レジスタへ `__` を置く。幅は返値と同じ（呼ぶ側が読む本数を変えない）。
function emitUnitRegs(em, width, kind = null) {
	if (width <= 1) {
		em.emit("movz x0, #0x8000, lsl #48", "__ を返す（完全性公理）");
		return;
	}
	// **カーソルが尽きているかは `arm` が niche かで分かる。** 入力が空になれば枝を
	// 選ぶ関数が完全性公理で `__` を返すので、そのまま先頭のフィールドに現れる——
	// 空を別に表す必要が無い。
	if (kind === "cursor") {
		em.emit("movz x0, #0x8000, lsl #48", "__ を返す（arm が niche）");
		for (let k = 1; k < width; k++) em.emit(`mov x${k}, #0`);
		return;
	}
	em.emit("mov x0, #0", "__ を返す（完全性公理）");
	em.emit("mov x1, #0", "len = 0 が __");
	for (let k = 2; k < width; k++) em.emit(`mov x${k}, #0`);
}

/**
 * 本体を組み立ててから、必要なフレームの大きさを決めて前後を付ける。
 *
 * フレームの大きさは**本体を出してみるまで分からない**（式の深さで決まる）ので、
 * 本文を先に作って後から包む。AArch64 のスタックは16バイト境界を要求するので
 * 切り上げる。
 */
function wrapFrame(bodyLines, slots, name) {
	const frame = 16 + Math.ceil((slots * 8) / 16) * 16; // x29/x30 の16バイト + スロット
	// 相互末尾呼び出しが置いた印を、決まったフレームの大きさで埋める。
	const filled = bodyLines.map((l) => (l.includes(FRAME_MARK) ? l.split(FRAME_MARK).join(String(frame)) : l));
	return [
		`${name}:`,
		`\tstp x29, x30, [sp, #-${frame}]!`.padEnd(30) + `// フレーム ${frame} バイト`,
		"\tmov x29, sp",
		...filled,
		`\tldp x29, x30, [sp], #${frame}`.padEnd(30) + "// フレームを戻す",
		"\tret",
	];
}

/**
 * 仮引数が引数レジスタを何本ずつ使うかを返す（診断は出さない）。
 *
 * **呼び出しサイトと関数の入口が同じ計算を使う必要がある。** 省略された引数には呼ぶ側が
 * `__` を置かなければならず（AAPCS64 は使われないレジスタを初期化しない）、その位置は
 * 仮引数の幅で決まるからである。2箇所で別々に数えると、片方だけが正しい命令列を出す。
 *
 * @returns 仮引数ごとの `{ shape, regs, elemSize, signed, error }`。決まらない位置は
 *   `error` に理由が入る（呼ぶ側は診断へ、呼び出しサイト側は「埋めない」判断へ使う）。
 */
function paramRegWidths(lambdaNode, em, callees = {}) {
	const allShapes = paramShapesOf(lambdaNode.left);
	const keep = allShapes.map((_, i) => i).filter((i) => {
		const sh = allShapes[i];
		return !sh || sh.kind !== "bare" || !(sh.name in callees);
	});
	const allTypes = lambdaNode.callsiteParamTypes || [];
	const typeOf = (raw) => {
		const b = lambdaNode.scope ? envLookup(lambdaNode.scope, raw) : null;
		return b ? b.atomType : null;
	};
	return keep.map((idx) => {
		const sh = allShapes[idx];
		if (!sh) return { shape: null, error: "裸の仮引数・デフォルト付き・`[h ~t]`・`[~x]` を出せます（裸の rest はまだ）" };
		if (sh.kind === "bare") {
			// **`[~x]` は宣言そのものが「器である」と言っている。** 型の解決を待たずに
			// 渡し方が決まる——要素の並びは `{ptr, len}` の2本である（stack_abi.md §4.6）。
			// n_queens.sn が「引数の書き方がそのまま型の宣言になっている」と書いているのは
			// このことで、`[~board]` は盤がリストであることを宣言している。
			// **どの器かは型が言う。** `Struct` は形が型にあるので `{ptr}` の1本、
			// `List`/`String` は要素数が型に無いので `{ptr, len}` の2本である
			// （stack_abi.md §4.6）。型が決まらないときだけ、宣言が言う「器である」に
			// 従って要素の並び（2本）として扱う——`[~x]` はそこまでは必ず言っている。
			if (sh.whole) {
				// 型が**決まっているとき**だけ型に従う。`slotsOf` は未注釈を 1 とみなすので、
				// そのまま渡すと器が1本になってしまう——宣言が「器である」と言っている
				// 以上、決まらないなら要素の並び（2本）として扱う方が宣言に忠実である。
				const t = allTypes[idx] ?? typeOf(sh.name);
				return { shape: sh, regs: t ? slotsOf(t, em.conf) ?? 2 : 2 };
			}
			// **束縛が実体の種類を知っている場合がある。** 規則を受ける仮引数（`f : c ? c ' 3`
			// を `f [0 ~+ 1]` と呼ぶ形）は、型が `Iterator` でも運ぶのは `{start, step}` の
			// 2本であって参照ではない。型だけを見ると渡し方が決まらない。
			const b = lambdaNode.scope ? envLookup(lambdaNode.scope, sh.name) : null;
			const view = { atomType: allTypes[idx] ?? (b && b.atomType), repr: b && b.repr, elementType: b && b.elementType };
			const w = slotsOfNode(view, em.conf, lambdaNode.scope);
			if (w === null) return { shape: sh, error: `仮引数 ${bareName(sh.name)} の渡し方が決まりません（直和か族）` };
			// **規則かどうかは入口の判定を変える。** 尽きているかを `len` で見るか
			// `start` と `end` の関係で見るかが違う（`emitIsUnit`）。
			return { shape: sh, regs: w, rule: isRuleNode(view, em.conf, lambdaNode.scope) };
		}
		const headType = typeOf(sh.head);
		const elem = headType ? measure({ atomType: headType }, { target: em.conf.target, charset: em.conf.charset }) : null;
		if (!elem || !elem.size) {
			return { shape: sh, error: `\`[${bareName(sh.head)} ~${bareName(sh.rest)}]\` の要素の幅が決まりません（${headType}）` };
		}
		if (slotsOf(headType, em.conf) !== 1) {
			return { shape: sh, error: `要素そのものが参照で運ぶ値の分割代入はまだ出せません（${headType}）` };
		}
		return { shape: sh, regs: 2, elemSize: elem.size, signed: SIGNEDNESS[headType] === "signed" };
	});
}
/**
 * 関数ごとの引数レジスタの並びを先に集める。呼び出しサイトが「省略された引数」の位置を
 * 知るために要る（`genFunction` と同じ `paramRegWidths` を使うので、必ず一致する）。
 */
function collectSignatures(nodes, em) {
	const sig = new Map();
	for (const node of nodes) {
		if (!isDefineNode(node) || !isIdentifierNode(node.left)) continue;
		const rhs = node.right;
		if (!rhs || rhs.type !== "operation" || rhs.name !== "lambda") continue;
		sig.set(bareName(node.left.value), paramRegWidths(rhs, em));
	}
	return sig;
}
function genFunction(name, lambdaNode, env, em, mono) {
	// **本体の中では、名前は関数のスコープで解決する。**
	//
	// 外側の識別子テーブルだけを見ていると、仮引数が「見つからない名前」になる。型は
	// `callsiteParamTypes` が別経路で運んでいたので気づきにくかったが、**渡し方**
	// （`repr`）は束縛にしか無い——規則を受けた仮引数が要素列への参照に見えていた。
	// スコープは親へ繋がっているので、これでグローバルも今まで通り引ける。
	env = lambdaNode.scope || env;
	const paramNode = lambdaNode.left;
	const allShapes = paramShapesOf(paramNode);
	// 具体化された関数ポインタの仮引数は**引数として渡ってこない**（命令へ焼き込み済み）。
	const callees = (mono && mono.callees) || {};
	const keep = allShapes.map((_, i) => i).filter((i) => {
		const sh = allShapes[i];
		return !sh || sh.kind !== "bare" || !(sh.name in callees);
	});
	// 出せない形の報告は `paramRegWidths` が返す `error` に一本化してある（下）。
	// ここで別文言を出すと、同じ理由が2通りの言い方で出ることになる。
	// 型は2つの経路から来る。裸の仮引数は呼び出しサイトからの逆算（`callsiteParamTypes`）、
	// 分割代入された名前はラムダのスコープに直接ある——`[h ~t]` の `h` と `t` は仮引数の
	// 位置に名前が無いので、束縛の側にしか書いていない。
	const allTypes = lambdaNode.callsiteParamTypes || [];
	// **束縛は直接の Map ではなく `envLookup` で引く。** `[c ~rest]` の `c` はラムダの
	// スコープの Map に直接は載らない（載るのは器を受ける `rest` だけ）が、束縛としては
	// 解決されている。Map を覗くと「型が無い」に見えて、要素の幅が決まらなくなる。
	const typeOf = (raw) => {
		const b = lambdaNode.scope ? envLookup(lambdaNode.scope, raw) : null;
		return b ? b.atomType : null;
	};

	// 入ってくるレジスタの本数と、本体から見える名前を作る。
	//   裸        1つの名前 : 型の幅ぶん
	//   `[h ~t]`  容器が `{ptr, len}` の2本で来て、そこから2つの名前が生える
	// 幅の計算は**呼び出しサイトと同じ関数**で行う（`paramRegWidths`）。省略された引数へ
	// `__` を置く位置がそこで決まるので、2箇所で別々に数えると片方だけが正しくなる。
	const incoming = paramRegWidths(lambdaNode, em, callees);
	const bad = incoming.find((x) => x.error);
	if (bad) {
		em.diagnostics.push({ severity: "error", message: `${name}: ${bad.error}`, node: lambdaNode });
		return;
	}
	const regs = incoming.reduce((a, x) => a + x.regs, 0);
	if (regs > ARG_REGS.length) {
		em.diagnostics.push({
			severity: "error",
			message: `${name}: 引数がレジスタ ${ARG_REGS.length} 本を超えます（${incoming.length} 個で ${regs} 本）`,
			node: lambdaNode,
		});
		return;
	}

	// 本体は別の行配列へ出してから包む（フレームの大きさが後で決まるため）。
	const outer = em.lines;
	em.lines = [];
	em.slot = 0;
	em.maxSlot = 0;

	// **末尾自己再帰の飛び先。** フレームの確保（`stp`）はこの外側にあり、ここから下だけを
	// 繰り返す——だから再帰の深さがスタックに積まれない（tco.md §7「同一スタック
	// フレームへの JMP」）。
	//
	// 飛び先を**仮引数の写しと完全性公理の検査より前**に置くのが要である。後ろに置くと
	// 検査が初回しか通らず、終端が消える。
	const loopLabel = em.newLabel("loop");
	em.label(loopLabel);
	const bracketPairs = [];

	// **仮引数を入口でスロットへ写す。** 引数レジスタは最初の `bl` で壊れるので、
	// 本体のどこからでも読める場所へ移しておく必要がある。
	// 幅は引数ごとに違う——器を受ける仮引数は `{ptr, len}` で2本来る（stack_abi.md §4.6）。
	let reg = 0;
	for (const inc of incoming) {
		inc.off = em.slot * 8;
		for (let k = 0; k < inc.regs; k++) {
			em.push();
			const what = inc.shape.kind === "bare" ? bareName(inc.shape.name) : `[${bareName(inc.shape.head)} ~${bareName(inc.shape.rest)}]`;
			em.store(ARG_REGS[reg], (em.slot - 1) * 8, k === 0 ? `仮引数 ${what} を退避${inc.regs > 1 ? "（ptr）" : ""}` : "（len）");
			reg++;
		}
	}
	for (const [pn, cn] of Object.entries(callees)) em.emit(`// ${bareName(pn)} = ${cn}`, "具体化された呼び先");

	// **完全性公理を出す。** `f __ = __`——所有の引数に有効値が揃って初めて呼び出しが
	// 真になるので、どれか1つでも `__` なら本体へ一歩も入らずに `__` を返す
	// （unit.md §完全性公理、0_design_principles.md 原理5）。
	//
	// Sign にループは無く再帰しかない以上、これは最適化ではなく**終端そのもの**である。
	// 出さないと「命令は出ているのに止まらない」——診断も出ない一番たちの悪い形になる。
	//
	// 検査は**仮引数をスロットへ写した後**に置く。TCO でフレームを使い回すとき、飛び先が
	// この検査より後ろにあると初回しか検査を通らず、ループが終わらなくなるためである。
	// **検査・デフォルトの充填・分解は、宣言順に混ぜて出す。**
	//
	// 評価器（`bindParams`）が仮引数を1つずつ順に見るのと同じ順序でなければならない。
	// デフォルト式は前の仮引数を参照でき（`let*`、1_definition.md §6.1）、かつ Input
	// （前置 `@`）を含みうる——MMIO は読むたびに値が変わりうるので、**どの順で何回読むかが
	// 観測できる**。まとめて先に出すと、崩壊するはずの呼び出しで余計な読み出しが起きる。
	//
	// デフォルトを持つ仮引数は完全性公理の対象外である。`__` を受けても崩壊させず、
	// デフォルト式の値で埋める（それが `__` でも埋めたことにする——`s : __` が定義域を
	// 持ち上げるのはこの一点である。Pass 3 が information で名指ししている）。
	const unitLabel = incoming.length > 0 ? em.newLabel("unit") : null;
	const params = [];
	const paramOffsets = [];
	const paramSlots = [];
	const scopeSoFar = () => ({ params, paramOffsets, paramSlots, callees });
	for (const inc of incoming) {
		const what = inc.shape.kind === "bare" ? bareName(inc.shape.name) : `[${bareName(inc.shape.head)} ~${bareName(inc.shape.rest)}]`;
		if (inc.shape.kind === "bare" && inc.shape.defaultNode) {
			// **デフォルトが `__` なら命令は要らない。** 埋めるのは値が `__` のときだけで
			// あり、そこへ `__` を置いても何も変わらない。つまりこの宣言の内容は
			// 「この引数について完全性公理を働かせない」の一点であって、検査を飛ばせば
			// それで足りる——定義域の持ち上げ（Pass 3 が information で名指しする）が
			// 機械の上では**命令ゼロ**であることが、ここで見える。
			if (inc.shape.defaultNode.type === "atom" && inc.shape.defaultNode.kind === "unit") {
				em.emit(`// ${what} は __ を受けても崩壊しない`, "定義域の持ち上げ");
				params.push(inc.shape.name);
				paramOffsets.push(inc.off);
				paramSlots.push(inc.regs);
				continue;
			}
			// 渡されていれば（`__` でなければ）そのまま。渡されていなければ埋める。
			const have = em.newLabel("have");
			emitIsUnit(em, inc.off, inc.regs, `仮引数 ${what} が渡されたか`, inc.rule);
			em.emit(`b.ne ${have}`, "渡されていればそのまま");
			const dw = genExpr(inc.shape.defaultNode, env, em, scopeSoFar());
			if (dw === false) {
				em.diagnostics.push({ severity: "error", message: `${name}: 仮引数 ${what} のデフォルト式を出せませんでした`, node: inc.shape.defaultNode });
				return;
			}
			if (dw === TAIL || dw !== inc.regs) {
				em.pop(dw === TAIL ? 0 : dw);
				em.diagnostics.push({
					severity: "error",
					message: `${name}: 仮引数 ${what} のデフォルトの幅が合いません（${dw} 本と ${inc.regs} 本）`,
					node: inc.shape.defaultNode,
				});
				return;
			}
			const base = em.slot - dw;
			for (let k = 0; k < dw; k++) {
				em.load(SCRATCH[0], (base + k) * 8);
				em.store(SCRATCH[0], inc.off + k * 8, k === 0 ? "デフォルトで埋める" : undefined);
			}
			em.pop(dw);
			em.label(have);
			params.push(inc.shape.name);
			paramOffsets.push(inc.off);
			paramSlots.push(inc.regs);
			continue;
		}
		// デフォルトが無いなら完全性公理が働く。
		emitIsUnit(em, inc.off, inc.regs, `仮引数 ${what} が __ か`, inc.rule);
		em.emit(`b.eq ${unitLabel}`, "__ なら本体へ入らない（完全性公理）");
		if (inc.shape.kind === "bare") {
			params.push(inc.shape.name);
			paramOffsets.push(inc.off);
			paramSlots.push(inc.regs);
			continue;
		}
		// **`[h ~t]` は検査の後で作る。** 空の容器から先頭を読むと指す先の外を触る
		// ——先に崩壊させておけば読まずに済む。先頭は新しいスロット、残りは容器の
		// スロットをそのまま使い回す（コピーしない）。
		const headOff = em.slot * 8;
		em.push();
		emitDestructure(em, inc.off, headOff, inc.elemSize, inc.signed, what);
		params.push(inc.shape.head, inc.shape.rest);
		paramOffsets.push(headOff, inc.off);
		// **分解した組を覚えておく。** 組み直す形（`c rest`）は恒等射なので、器を作る
		// のではなく参照を戻せばよい（`genRejoin`）。
		bracketPairs.push({ head: inc.shape.head, rest: inc.shape.rest, restOff: inc.off, elemSize: inc.elemSize });
		paramSlots.push(1, 2);
	}

	const before = em.diagnostics.length;
	// 本体そのものが末尾位置である。`selfLabel` / `loopLabel` を渡すことで、本体の中の
	// 自己呼び出しがフレームを使い回す `b` になる。
	const scope = { params, paramOffsets, paramSlots, callees, selfLabel: name, loopLabel, bracketPairs };
	const ok = genExpr(lambdaNode.right, env, em, scope, true);
	if (ok !== false) {
		// 返値の幅ぶん x0/x1 へ載せる。末尾呼び出しで出て行った経路は値を持たない。
		const width = ok === TAIL ? 1 : ok;
		if (width > ARG_REGS.length) {
			em.diagnostics.push({ severity: "error", message: `${name}: ${width} 本で返す関数はまだ出せません`, node: lambdaNode });
		}
		if (ok !== TAIL) {
			const base = em.slot - ok;
			// **返す本数は値の形が決める。** 2本で打ち切っていたので、カーソル
			// （`{arm, k, ptr, len}`）や3本の規則を返す関数が上2本だけ載せて帰っていた
			// ——呼ぶ側は4本読むので、残りは前の呼び出しの残骸を読むことになる。
			for (let k = 0; k < Math.min(ok, ARG_REGS.length); k++) {
				const what = ok === 1 ? "返値を x0 へ" : k === 0 ? "返値の1本目を x0 へ" : undefined;
				em.load(ARG_REGS[k], (base + k) * 8, what);
			}
			em.pop(ok);
		}
		// 崩壊したときの出口。返値と同じ幅で `__` を置く——枝によって幅が変わると
		// 呼び出し側が読む本数が決まらない。
		if (unitLabel) {
			// 本体が全て飛んで行ったなら、ここへ落ちてくるのは崩壊の経路だけである。
			const done = ok === TAIL ? null : em.newLabel("done");
			if (done) em.emit(`b ${done}`);
			em.label(unitLabel);
			emitUnitRegs(em, Math.min(width, 2));
			if (done) em.label(done);
		}
	} else if (em.diagnostics.length === before) {
		em.diagnostics.push({ severity: "error", message: `${name}: 本体を出せませんでした`, node: lambdaNode });
	}

	const body = em.lines;
	em.lines = outer;
	em.lines.push(...wrapFrame(body, em.maxSlot, name));
	em.blank();
}

/**
 * プログラム全体を AArch64 アセンブリへ落とす。
 *
 * @returns {{ text: string, diagnostics: Array }}
 */
function generateAsm(nodes, env, options = {}) {
	// `layer` は記憶を確保できるかどうかを決める（memory_management.md §2 の表）。
	// 渡されなければ検査しない——`option.ms` を読まない経路まで縛らない、他の門番と同じ方針。
	const conf = {
		target: options.target || "aarch64_qemu",
		charset: options.charset || DEFAULT_CHARSET,
		layer: options.layer,
	};
	const em = new Emitter(conf);
	if (!widthsOf(conf.target)) {
		return {
			text: `// target '${conf.target}' の幅はまだ決まっていない（AArch64 のみ対応）\n`,
			diagnostics: [{ severity: "error", message: `未対応のターゲット: ${conf.target}` }],
		};
	}

	// 具体化はコード生成の前に済ませる（どの実体を出すかが決まらないと本体を出せない）。
	em.env = env; // 束縛から実体の種類を辿るために持つ（`slotsOfNode`）
	const monos = collectMonomorphs(nodes);
	// 呼び出しサイトが省略された引数の位置を知るための署名表。本体を出す前に要る。
	em.signatures = collectSignatures(nodes, em);

	em.lines.push("// Sign — AArch64 (AAPCS64)");
	if (options.source) em.lines.push(`// source: ${options.source}`);
	em.lines.push("\t.text");
	em.blank();

	// 関数定義を先に出す。トップレベルの式は `_sign_main` に入る
	// （entry_point.md の生成スタブが `bl _sign_main` で呼ぶ）。
	const exprs = [];
	for (const node of nodes) {
		// 糖衣が置き換えた元の定義は出さない。同じ列を2通りに出すだけである
		// （compile.js の `markCursorEntries`）。AST には残っている——インタプリタは
		// 元の形をそのまま走らせるので、そちらが仕様の答えを持っている。
		if (node && node.supersededByDesugar) continue;
		if (isDefineNode(node) && isIdentifierNode(node.left)) {
			const rhs = node.right;
			if (rhs && rhs.type === "operation" && rhs.name === "lambda") {
				const fname = bareName(node.left.value);
				const entry = monos.get(fname);
				if (entry) {
					// **呼ばれている組み合わせのぶんだけ実体を出す。** 呼び出しサイトが1つも
					// 無ければ実体を持ちようがない——`dyn` を持たない以上、そこは §5 Pass 1b が
					// 「呼び出しサイトの無い export はコンパイルエラー」と言うのと同じ線である。
					if (entry.instances.size === 0) {
						em.diagnostics.push({
							severity: "error",
							message: `${fname}: アドレス経由で呼ぶ仮引数を持つが、具体化できる呼び出しサイトが無い`,
							node: rhs,
						});
					}
					for (const inst of entry.instances.values()) {
						em.lines.push(`	.global ${inst.label}`);
						genFunction(inst.label, rhs, env, em, inst);
					}
					continue;
				}
				em.lines.push(`	.global ${fname}`);
				genFunction(fname, rhs, env, em);
				continue;
			}
		}
		exprs.push(node);
	}

	const outer = em.lines;
	em.lines = [];
	em.slot = 0;
	em.maxSlot = 0;
	for (const node of exprs) {
		// **裸の文字列リテラルはコメントである**（string_and_comment.md）。Sign の
		// コメントはバッククォート文字列そのものなので AST に残るが、値として使われて
		// いない以上、命令は出ない。ここを診断にすると、コメントの数だけ「出せない」が
		// 並んで本当の穴が埋もれる。
		//
		// 判定は Pass 3 の charset の門番と**同じ関数**である。食い違うと「検査は通った
		// のに `.rodata` へ出る」（またはその逆）が起きる。
		if (isBareComment(node)) continue;
		const target = isDefineNode(node) ? node.right : node;
		const w = genExpr(target, env, em, null);
		if (w !== false) em.pop(w);
	}
	const body = em.lines;
	em.lines = outer;
	em.lines.push("\t.global _sign_main");
	em.lines.push(...wrapFrame(body, em.maxSlot, "_sign_main"));
	// 文字列の中身は最後に置く。`.text` と混ぜないのは、書き換えない領域だからである。
	em.lines.push(...em.rodataLines());

	return { text: em.lines.join("\n") + "\n", diagnostics: em.diagnostics };
}

export { generateAsm, ARG_REGS, SCRATCH, MAX_SLOTS };
