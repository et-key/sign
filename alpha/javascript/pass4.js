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
 *
 * 集約値・浮動小数・分岐・再帰はまだ出さない。出せないものは黙って落とさず診断として
 * 名指しする——落とすと「命令が無いのに動いたように見える」が起きる。
 */

import { reduceToMachineType, widthsOf } from "./target_info.js";

// AAPCS64（stack_abi.md §4.2）。引数は x0〜x7、返値は x0、一時は x9〜x15。
const ARG_REGS = ["x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7"];
// 演算のあいだだけ使う。呼び出しを跨がないので caller-saved で足りる。
const SCRATCH = ["x9", "x10"];
// フレームに置ける式の深さ。超えたら診断（深い式は稀なので、まず名指しする）。
const MAX_SLOTS = 16;

// 演算子名 → ニーモニック。除算が `sdiv` なのは `Int` が符号ありだから
// （target_info.js の SIGNEDNESS）。
const INT_OPS = { add: "add", sub: "sub", mul: "mul", div: "sdiv" };

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
function unwrap(node) {
	let n = node;
	while (n && Array.isArray(n.lines) && n.lines.length === 1 && n.kind !== "abs") n = n.lines[0];
	return n;
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
	}

	emit(text, comment) {
		this.lines.push(comment ? `\t${text.padEnd(26)}// ${comment}` : `\t${text}`);
	}

	label(name) {
		this.lines.push(`${name}:`);
	}

	blank() {
		this.lines.push("");
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
 * 式を評価して、結果をフレームのスロットへ積む。成功したら true。
 *
 * 呼ぶ側は使い終わったら `pop()` する。式の入れ子はそのままスロットの深さになる。
 */
function genExpr(node, env, em, scope) {
	const n = unwrap(node);
	if (!n) return false;

	// 整数リテラル。`mov` の即値は16ビットまで。それを超える値は `movz`/`movk` の
	// 連なりが要るので、桁を落として黙って通さず名指しする。
	if (n.type === "atom" && n.kind === "number") {
		const v = Number(n.value);
		if (!Number.isInteger(v)) return em.fail(n, `浮動小数はまだ出せません（${n.value}）`);
		if (v < 0 || v > 0xffff) return em.fail(n, `16ビットを超える即値はまだ出せません（${n.value}）`);
		const off = em.push();
		if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		em.emit(`mov ${SCRATCH[0]}, #${v}`, `リテラル ${n.value}`);
		em.store(SCRATCH[0], off);
		return true;
	}

	// 仮引数。入口でスロットへ写してあるので、そこから読む。
	if (isIdentifierNode(n)) {
		const slot = scope && scope.params ? scope.params.indexOf(n.value) : -1;
		if (slot >= 0) {
			const off = em.push();
			if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
			em.load(SCRATCH[0], scope.paramOffsets[slot], `仮引数 ${bareName(n.value)}`);
			em.store(SCRATCH[0], off);
			return true;
		}
		return em.fail(n, `まだ出せない識別子です（${bareName(n.value)}）`);
	}

	if (n.type === "operation" && INT_OPS[n.name] && n.position === "infix") {
		const machine = reduceToMachineType(n.atomType, em.conf.target);
		if (!machine || machine.class !== "gpr") {
			return em.fail(n, `GPR 幅の整数演算だけを出せます（${n.atomType}）`);
		}
		if (!genExpr(n.left, env, em, scope)) return false;
		const lo = (em.slot - 1) * 8;
		if (!genExpr(n.right, env, em, scope)) return false;
		const ro = (em.slot - 1) * 8;
		em.load(SCRATCH[0], lo);
		em.load(SCRATCH[1], ro);
		em.emit(`${INT_OPS[n.name]} ${SCRATCH[0]}, ${SCRATCH[0]}, ${SCRATCH[1]}`, `${n.op}`);
		em.pop(1); // 右辺のスロットを返す。結果は左辺のスロットへ書く。
		em.store(SCRATCH[0], lo);
		return true;
	}

	// 飽和した呼び出し。引数をスロットで作ってから x0〜x7 へ積んで `bl`。
	if (n.type === "operation" && n.name === "apply") {
		const { base, args } = applyChain(n);
		if (!isIdentifierNode(base)) return em.fail(n, "呼び先が静的に決まりません");
		if (args.length > ARG_REGS.length) return em.fail(n, `引数が ${ARG_REGS.length} 本を超えます`);
		const offs = [];
		for (const a of args) {
			if (!genExpr(a, env, em, scope)) return false;
			offs.push((em.slot - 1) * 8);
		}
		// 引数レジスタへ積むのは**全部作り終えてから**。先に x0 へ書くと、2つ目の
		// 引数を作る途中で潰れる（式の中に呼び出しがあれば必ず潰れる）。
		offs.forEach((o, i) => em.load(ARG_REGS[i], o, `第${i + 1}引数`));
		em.pop(offs.length);
		em.emit(`bl ${bareName(base.value)}`, "呼び出し");
		const off = em.push();
		if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		em.store("x0", off, "返値");
		return true;
	}

	return em.fail(n, `まだ出せない式です（${n.name || n.type}）`);
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
	return [
		`${name}:`,
		`\tstp x29, x30, [sp, #-${frame}]!`.padEnd(30) + `// フレーム ${frame} バイト`,
		"\tmov x29, sp",
		...bodyLines,
		`\tldp x29, x30, [sp], #${frame}`.padEnd(30) + "// フレームを戻す",
		"\tret",
	];
}

function genFunction(name, lambdaNode, env, em) {
	const paramNode = lambdaNode.left;
	const params = isIdentifierNode(paramNode)
		? [paramNode.value]
		: paramNode && paramNode.type === "params"
			? (paramNode.entries || []).map((e) => (e.pattern || e.rest || e.default ? null : e.name || null))
			: [];
	if (params.some((p) => p === null)) {
		em.diagnostics.push({
			severity: "error",
			message: `${name}: 裸の仮引数だけを出せます（ブラケット分割代入・rest・デフォルトはまだ）`,
			node: lambdaNode,
		});
		return;
	}
	if (params.length > ARG_REGS.length) {
		em.diagnostics.push({ severity: "error", message: `${name}: 引数が ${ARG_REGS.length} 本を超えます`, node: lambdaNode });
		return;
	}

	// 本体は別の行配列へ出してから包む（フレームの大きさが後で決まるため）。
	const outer = em.lines;
	em.lines = [];
	em.slot = 0;
	em.maxSlot = 0;

	// **仮引数を入口でスロットへ写す。** 引数レジスタは最初の `bl` で壊れるので、
	// 本体のどこからでも読める場所へ移しておく必要がある。
	const paramOffsets = params.map(() => em.push());
	params.forEach((p, i) => em.store(ARG_REGS[i], paramOffsets[i], `仮引数 ${bareName(p)} を退避`));

	const before = em.diagnostics.length;
	const ok = genExpr(lambdaNode.right, env, em, { params, paramOffsets });
	if (ok) {
		em.load("x0", (em.slot - 1) * 8, "返値を x0 へ");
		em.pop(1);
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
	const conf = { target: options.target || "aarch64_qemu" };
	const em = new Emitter(conf);
	if (!widthsOf(conf.target)) {
		return {
			text: `// target '${conf.target}' の幅はまだ決まっていない（AArch64 のみ対応）\n`,
			diagnostics: [{ severity: "error", message: `未対応のターゲット: ${conf.target}` }],
		};
	}

	em.lines.push("// Sign — AArch64 (AAPCS64)");
	if (options.source) em.lines.push(`// source: ${options.source}`);
	em.lines.push("\t.text");
	em.blank();

	// 関数定義を先に出す。トップレベルの式は `_sign_main` に入る
	// （entry_point.md の生成スタブが `bl _sign_main` で呼ぶ）。
	const exprs = [];
	for (const node of nodes) {
		if (isDefineNode(node) && isIdentifierNode(node.left)) {
			const rhs = node.right;
			if (rhs && rhs.type === "operation" && rhs.name === "lambda") {
				em.lines.push(`\t.global ${bareName(node.left.value)}`);
				genFunction(bareName(node.left.value), rhs, env, em);
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
		const target = isDefineNode(node) ? node.right : node;
		if (genExpr(target, env, em, null)) em.pop(1);
	}
	const body = em.lines;
	em.lines = outer;
	em.lines.push("\t.global _sign_main");
	em.lines.push(...wrapFrame(body, em.maxSlot, "_sign_main"));

	return { text: em.lines.join("\n") + "\n", diagnostics: em.diagnostics };
}

export { generateAsm, ARG_REGS, SCRATCH, MAX_SLOTS };
