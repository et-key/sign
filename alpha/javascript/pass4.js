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

import { reduceToMachineType, widthsOf, UNIT_NICHE_ASM } from "./target_info.js";

// AAPCS64（stack_abi.md §4.2）。引数は x0〜x7、返値は x0、一時は x9〜x15。
const ARG_REGS = ["x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7"];
// 演算のあいだだけ使う。呼び出しを跨がないので caller-saved で足りる。
const SCRATCH = ["x9", "x10"];
// フレームに置ける式の深さ。超えたら診断（深い式は稀なので、まず名指しする）。
const MAX_SLOTS = 16;

// 演算子名 → ニーモニック。除算が `sdiv` なのは `Int` が符号ありだから
// （target_info.js の SIGNEDNESS）。
const INT_OPS = { add: "add", sub: "sub", mul: "mul", div: "sdiv" };

// 比較。符号あり整数の条件コード（`Int` は符号あり——target_info.js の SIGNEDNESS）。
// `assign_equal` は `=`（等価比較）である——`:` が定義なので、`=` は比較に使える。
const CMP_COND = { less: "lt", less_equal: "le", assign_equal: "eq", more_equal: "ge", more: "gt", not_equal: "ne" };

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
		const params = paramNamesOf(rhs.left);
		if (params.some((x) => x === null)) continue;
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
 * 式を評価して、結果をフレームのスロットへ積む。成功したら true。
 *
 * 呼ぶ側は使い終わったら `pop()` する。式の入れ子はそのままスロットの深さになる。
 */
function genExpr(node, env, em, scope) {
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
		return genMatch(n, env, em, scope);
	}

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

	// `__`（Unit）。niche を積む（value_representation.md §3.5）。
	if (n.type === "atom" && n.kind === "unit") {
		const off = em.push();
		if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		em.emit("movz x9, #0x8000, lsl #48", "__ の niche");
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
		if (!lt || lt.class !== "gpr" || !rt || rt.class !== "gpr") {
			return em.fail(n, `GPR 幅の整数の比較だけを出せます（${n.left && n.left.atomType} と ${n.right && n.right.atomType}）`);
		}
		if (!genExpr(n.left, env, em, scope)) return false;
		const lo = (em.slot - 1) * 8;
		if (!genExpr(n.right, env, em, scope)) return false;
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
		return true;
	}

	// 飽和した呼び出し。引数をスロットで作ってから x0〜x7 へ積んで `bl`。
	if (n.type === "operation" && n.name === "apply") {
		const { base, args } = applyChain(n);
		// **アドレス経由の呼び出しは具体化されている。** 本体を出しているのは特定の実体
		// なので、`@p` の `p` が何を指すかはこの実体の中では決まっている
		// （compiler_pipeline.md §3 の IMPORTANT）。
		let callee = null;
		if (isIdentifierNode(base)) {
			callee = bareName(base.value);
		} else if (
			base && base.type === "operation" && base.position === "prefix" && base.name === "input" &&
			isIdentifierNode(base.operand) && scope && scope.callees && scope.callees[base.operand.value]
		) {
			callee = scope.callees[base.operand.value];
		}
		if (!callee) {
			return em.fail(n, "呼び先が静的に決まりません（`$名前` で渡されたものだけ具体化できます）");
		}
		// 単相化された呼び出しでは、関数ポインタの引数は**命令へ焼き込まれている**ので
		// レジスタで渡さない。ここが「コンパイル時特殊化（コストゼロ）」の実体である。
		const drop = n.monoDrop || [];
		if (n.monoLabel) callee = n.monoLabel;
		const passed = args.filter((_, i) => !drop.includes(i));
		if (passed.length > ARG_REGS.length) return em.fail(n, `引数が ${ARG_REGS.length} 本を超えます`);
		const offs = [];
		for (const a of passed) {
			if (!genExpr(a, env, em, scope)) return false;
			offs.push((em.slot - 1) * 8);
		}
		// 引数レジスタへ積むのは**全部作り終えてから**。先に x0 へ書くと、2つ目の
		// 引数を作る途中で潰れる（式の中に呼び出しがあれば必ず潰れる）。
		offs.forEach((o, i) => em.load(ARG_REGS[i], o, `第${i + 1}引数`));
		em.pop(offs.length);
		em.emit(`bl ${callee}`, n.monoLabel ? "呼び出し（具体化済み）" : "呼び出し");
		const off = em.push();
		if (off === null) return em.fail(n, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
		em.store("x0", off, "返値");
		return true;
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
	return em.fail(n, `まだ出せない式です（${n.name || n.type}）`);
}

/**
 * match_case の並びを分岐へ落とす。結果は呼び出し元が使うスロット1つに揃える
 * ——どの枝を通っても同じ場所に値がある、という一点を守る。
 */
function genMatch(node, env, em, scope) {
	const out = em.push();
	if (out === null) return em.fail(node, `式が深すぎます（スロットは ${MAX_SLOTS} まで）`);
	const end = em.newLabel("end");
	const lines = node.lines;
	for (let i = 0; i < lines.length; i++) {
		const line = lines[i];
		const isArm = isDefineNode(line);
		if (!isArm) {
			// フォールバック。条件を見ずにここへ来たら必ず値になる。
			if (!genExpr(line, env, em, scope)) return false;
			em.load(SCRATCH[0], (em.slot - 1) * 8);
			em.pop(1);
			em.store(SCRATCH[0], out, "枝の値");
			break;
		}
		const next = em.newLabel("arm");
		if (!genExpr(line.left, env, em, scope)) return false;
		em.load(SCRATCH[0], (em.slot - 1) * 8, "条件");
		em.pop(1);
		em.emit("movz x12, #0x8000, lsl #48", "__ の niche");
		em.emit(`cmp ${SCRATCH[0]}, x12`);
		em.emit(`b.eq ${next}`, "__ なら次の枝へ");
		if (!genExpr(line.right, env, em, scope)) return false;
		em.load(SCRATCH[0], (em.slot - 1) * 8);
		em.pop(1);
		em.store(SCRATCH[0], out, "枝の値");
		em.emit(`b ${end}`);
		em.label(next);
		// 最後の行が条件付きなら、どの枝も通らない場合がある。そのときの値は `__`。
		if (i === lines.length - 1) {
			em.emit("movz x12, #0x8000, lsl #48", "どの枝も通らなければ __");
			em.store("x12", out);
		}
	}
	em.label(end);
	return true;
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

function genFunction(name, lambdaNode, env, em, mono) {
	const paramNode = lambdaNode.left;
	const allParams = paramNamesOf(paramNode);
	// 具体化された関数ポインタの仮引数は**引数として渡ってこない**（命令へ焼き込み済み）。
	const callees = (mono && mono.callees) || {};
	const params = allParams.filter((x) => x === null || !(x in callees));
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
	for (const [pn, cn] of Object.entries(callees)) em.emit(`// ${bareName(pn)} = ${cn}`, "具体化された呼び先");

	const before = em.diagnostics.length;
	const ok = genExpr(lambdaNode.right, env, em, { params, paramOffsets, callees });
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

	// 具体化はコード生成の前に済ませる（どの実体を出すかが決まらないと本体を出せない）。
	const monos = collectMonomorphs(nodes);

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
		if (node.type === "atom" && node.kind === "string") continue;
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
