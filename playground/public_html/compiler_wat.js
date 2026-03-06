// compiler_wat.js

const TEMPLATES = {
	'+': 'f64.add',
	'-': 'f64.sub',
	'*': 'f64.mul',
	'/': 'f64.div',
	'%': 'call $math_fmod',
	'^': 'call $math_pow',
	'==': 'f64.eq',
	'!=': 'f64.ne',
	'<': 'f64.lt',
	'>': 'f64.gt',
	'<=': 'f64.le',
	'>=': 'f64.ge',
	',': 'call $cons'
};

let stringTable = {};
let stringAllocOffset = 1024; // インデックス0〜127をI/Oやレジスタ用に予約
let dataSection = '';
let closureFunctions = [];
let closureCount = 0;
// ★ 追加：決定論的ビルドのためのカウンタ群
let unrollCounter = 0;
let blockCounter = 0;
let lambdaCounter = 0;
let curryCounter = 0;

function encodeWatString(str) {
	let utf8 = unescape(encodeURIComponent(str));
	let res = '';
	for (let i = 0; i < utf8.length; i++) {
		let code = utf8.charCodeAt(i);
		if (code >= 32 && code <= 126 && code !== 34 && code !== 92) {
			res += utf8.charAt(i);
		} else {
			res += '\\\\' + code.toString(16).padStart(2, '0');
		}
	}
	return res + '\\00';
}

function isFunction(node, env = {}) {
	if (!node) return false;

	// `_` は変数だが、プレースホルダ（空値）として扱われるため関数ではない
	if (node.type === 'identifier') {
		if (node.value.trim() === '_') return false;
		if (env[node.value.trim()] !== undefined) {
			return env[node.value.trim()].isFunc;
		}
		return !!TEMPLATES[node.value.trim()];
	}

	if (node.type === 'compose') return true;
	if (node.type === 'infix') {
		if (node.op === '?') return true;
		// A missing left or right operand in an infix operator implies partial application (closure)
		if (!node.left || !node.right) return true;
	}
	if (node.type === 'prefix' && !node.expr) return true;

	if (node.type === 'block') {
		if (!node.body) return false;
		// 関数定義 (?) を含むブロックはクロージャを返すので関数とみなす
		if (node.body.some(c => c.type === 'infix' && c.op === '?')) return true;
		// ブロックの最後の評価値が関数なら関数とみなす
		if (node.body.length > 0 && isFunction(node.body[node.body.length - 1], env)) return true;
		return false;
	}

	if (node.type === 'apply') {
		// パイプライン（関数の合成や部分適用の連鎖）はカリー化等の対象になるため
		// isNative として単純なWASM命令の出力を行わず、正しく関数としてクロージャ連鎖へ回す
		if (node.pipeline) return true;

		// ==========================================
		// ★ 修正: 左側が関数ではない(値である)場合、この適用はタプル結合なので関数ではない
		// ==========================================
		if (!isFunction(node.func, env)) return false;

		// ネイティブ演算子で引数が足りていない場合は関数（部分適用）として扱う
		const isNative = (fnNode) => {
			if (!fnNode) return false;
			if (fnNode.type === 'identifier' && TEMPLATES[fnNode.value]) return true;
			if (fnNode.type === 'native_op') return true;
			if (fnNode.type === 'apply') return isNative(fnNode.func);
			return false;
		};
		if (isNative(node.func)) {
			const flattenNativeApply = (n) => {
				if (!n) return { args: [], op: null };
				if (n.type === 'identifier' && TEMPLATES[n.value]) return { args: [], op: n.value };
				if (n.type === 'native_op') return { args: [], op: n.value, nativeArgsLen: n.args ? n.args.length : 0 };
				if (n.type === 'apply') {
					let inner = flattenNativeApply(n.func);
					inner.args.push(n.arg);
					return inner;
				}
				return { args: [], op: null };
			};
			let info = flattenNativeApply(node);
			let expectedArgs = ['!', '!!', '@'].includes(info.op) ? 1 : 2;
			let currentArgsCount = info.args.length + (info.nativeArgsLen || 0);
			if (currentArgsCount < expectedArgs) return true;
			return false;
		}
		return true;
	}

	return false;
}

function getFreeVariables(node, boundVars = new Set()) {
	if (!node) return new Set();

	if (node.type === 'number' || node.type === 'string') return new Set();

	if (node.type === 'identifier') {
		const name = node.value.trim();
		if (!boundVars.has(name) && !TEMPLATES[name]) {
			return new Set([name]);
		}
		return new Set();
	}

	if (node.type === 'block') {
		let free = new Set();
		let currentBound = new Set(boundVars);
		if (node.body) {
			for (const child of node.body) {
				if (child.type === 'infix' && child.op === ':') {
					const name = (child.left && child.left.type === 'identifier') ? child.left.value.trim() : '';
					getFreeVariables(child.right, currentBound).forEach(v => free.add(v));
					if (name) currentBound.add(name);
				} else {
					getFreeVariables(child, currentBound).forEach(v => free.add(v));
				}
			}
		}
		return free;
	}

	if (node.type === 'infix' && node.op === '?') {
		let newBound = new Set(boundVars);
		if (node.left && node.left.type === 'identifier') {
			newBound.add(node.left.value.trim());
		}
		return getFreeVariables(node.right, newBound);
	}

	let free = new Set();
	const children = ['body', 'left', 'right', 'expr', 'func', 'arg', 'first', 'second', 'args'];
	for (let child of children) {
		if (node[child]) {
			if (Array.isArray(node[child])) {
				for (let c of node[child]) {
					getFreeVariables(c, boundVars).forEach(v => free.add(v));
				}
			} else {
				getFreeVariables(node[child], boundVars).forEach(v => free.add(v));
			}
		}
	}
	return free;
}

function expandMacros(node, env = {}) {
	if (!node) return node;

	if (node.type === 'block') {
		let currentEnv = { ...env };
		const newBody = node.body.map(child => {
			if (child.type === 'infix' && child.op === ':') {
				if (child.left && child.left.type === 'identifier') {
					let expandedRight = expandMacros(child.right, currentEnv);
					currentEnv[child.left.value.trim()] = { isFunc: isFunction(expandedRight, currentEnv) };
					return { ...child, right: expandedRight, _expanded: true };
				}
			}
			return expandMacros(child, currentEnv);
		});
		return { type: 'block', body: newBody };
	}

	if (node.type === 'compose') {
		// A compose B -> x ? B(A(x))
		// We implement this as a lambda with a unique argument name to avoid collisions
		const argName = '$compose_arg_' + lambdaCounter++;
		const expandedFirst = expandMacros(node.first, env);
		const expandedSecond = expandMacros(node.second, env);

		const lambdaAst = {
			type: 'infix',
			op: '?',
			left: { type: 'identifier', value: argName },
			right: {
				type: 'apply',
				func: expandedSecond,
				arg: {
					type: 'apply',
					func: expandedFirst,
					arg: { type: 'identifier', value: argName },
					pipeline: false,
					_expanded: true
				},
				pipeline: false,
				_expanded: true
			}
		};
		const lambdaExpanded = expandMacros(lambdaAst, env);
		if (lambdaExpanded && lambdaExpanded.type === 'apply') lambdaExpanded._expanded = true;
		return lambdaExpanded;
	}

	// ★ 安全なボトムアップ局所組み替え
	if (node.type === 'apply') {
		if (node._expanded) return node;

		const expandedFunc = expandMacros(node.func, env);
		const expandedArg = expandMacros(node.arg, env);

		// ★追加: unit(括弧のグルーピング)の場合は、パイプライン判定をせずに中身をそのまま返す
		if (expandedFunc && expandedFunc.type === 'unit') {
			return expandedArg;
		}

		const isFuncL = isFunction(expandedFunc, env);
		const isFuncR = isFunction(expandedArg, env);

		// 1. パイプライン適用の推測 (Val -> Func)
		if (!isFuncL && isFuncR && !node.pipeline) {
			return {
				type: 'apply',
				func: expandedArg, // g
				arg: expandedFunc, // x
				pipeline: true,    // mark as pipeline
				_expanded: true
			};
		}

		// 1.5. 関数合成 (Func -> Func) 命令型順序 (左結合)
		if (isFuncL && isFuncR && !node.pipeline) {
			// A B -> x ? B(A(x))  (where A = expandedFunc, B = expandedArg)
			const argName = '$compose_arg_' + lambdaCounter++;
			const lambdaAst = {
				type: 'infix',
				op: '?',
				left: { type: 'identifier', value: argName },
				right: {
					type: 'apply',
					func: expandedArg, // B (右側・後から実行される)
					arg: {
						type: 'apply',
						func: expandedFunc, // A (左側・先に実行される)
						arg: { type: 'identifier', value: argName },
						pipeline: false,
						_expanded: true
					},
					pipeline: false,
					_expanded: true
				}
			};
			const lambdaExpanded = expandMacros(lambdaAst, env);
			if (lambdaExpanded && lambdaExpanded.type === 'apply') lambdaExpanded._expanded = true;
			return lambdaExpanded;
		}

		// 2. 値の並びのブロック化 (Val -> Val)
		if (!isFuncL && !isFuncR && !node.pipeline) {
			// 未知の演算子（isFuncLがfalseになる未定義のopなど）が先頭に来た場合は前置演算子として解釈し直す
			if (expandedFunc.isOp) {
				return { type: 'prefix', op: expandedFunc.value.trim(), expr: expandedArg, _expanded: true };
			}

			// ★ blockへの強制変換処理を削除し、下部のデフォルト処理にフォールバックさせる。
			// これにより「値と値の適用」が apply ノードのまま保たれ、WASMの $apply_space に委譲されます。
		}

		// 3. 引数のスプレッド展開 (Func -> Block または Tuple)
		if (isFuncL && expandedArg && !node.pipeline) {
			if (expandedArg.type === 'block') {
				let hasBinding = expandedArg.body.some(c => c.type === 'infix' && c.op === ':');
				if (!hasBinding && expandedArg.body.length > 0) {
					let newApply = expandedFunc;
					for (let i = 0; i < expandedArg.body.length; i++) {
						newApply = {
							type: 'apply',
							func: newApply,
							arg: expandedArg.body[i],
							pipeline: false,
							_expanded: true
						};
					}
					return newApply;
				}
			} else if (expandedArg.type === 'apply') {
				// 左側が関数ではない適用 (例: `10 20`) はタプルとみなして引数展開する
				const isTuple = (n) => {
					if (n.type === 'apply') return isTuple(n.func);
					return !isFunction(n, env);
				};
				if (isTuple(expandedArg)) {
					const flattenTuple = (n) => {
						if (n.type === 'apply') return [...flattenTuple(n.func), n.arg];
						return [n];
					};
					let args = flattenTuple(expandedArg);
					let newApply = expandedFunc;
					for (let i = 0; i < args.length; i++) {
						newApply = {
							type: 'apply',
							func: newApply,
							arg: args[i],
							pipeline: false,
							_expanded: true
						};
					}
					return newApply;
				}
			}
		}

		// 上記以外は通常の関数適用として保持
		return {
			...node,
			func: expandedFunc,
			arg: expandedArg,
			_expanded: true
		};
	}
	if (node.type === 'infix') {
		const expandedLeft = expandMacros(node.left, env);
		const expandedRight = expandMacros(node.right, env);
		return { ...node, left: expandedLeft, right: expandedRight };
	}
	if (node.type === 'prefix' || node.type === 'postfix' || node.type === 'abs') {
		return { ...node, expr: expandMacros(node.expr, env) };
	}

	if (node.type === 'identifier') {
		const name = node.value.trim();
		if (env[name] !== undefined) {
			// Don't replace the node with the environment tracking object (which just has {isFunc: true})
			// Just return the identifier, let compiler_wat.js compileNode look up the actual value
			let cloned = JSON.parse(JSON.stringify(node));
			cloned.isFunc = env[name].isFunc;
			return cloned;
		}
	}

	return node;
}

// ==========================================
// ★ 変数の置換関数 (β簡約用)
// ==========================================
function substitute(node, paramName, argNode) {
	if (!node) return node;

	if (node.type === 'identifier' && node.value.trim() === paramName) {
		// 変数が見つかったら、渡された引数のASTに丸ごと置き換える（ディープコピーして参照を切る）
		return JSON.parse(JSON.stringify(argNode));
	}

	if (node.type === 'block') {
		// ブロック内で同じ名前の変数が再定義(シャドウイング)されている場合は、そこから下の置換を止める
		let isShadowed = node.body.some(c => c.type === 'infix' && c.op === ':' && c.left && c.left.value.trim() === paramName);
		if (isShadowed) return node;
		return { ...node, body: node.body.map(c => substitute(c, paramName, argNode)) };
	}

	if (node.type === 'infix') {
		// 新しいラムダ式で同じ引数名が使われている場合もシャドウイングなので止める
		if (node.op === '?' && node.left && node.left.value.trim() === paramName) return node;
		return {
			...node,
			left: substitute(node.left, paramName, argNode),
			right: substitute(node.right, paramName, argNode)
		};
	}

	if (node.type === 'prefix' || node.type === 'postfix' || node.type === 'abs') {
		return { ...node, expr: substitute(node.expr, paramName, argNode) };
	}

	if (node.type === 'apply') {
		return {
			...node,
			func: substitute(node.func, paramName, argNode),
			arg: substitute(node.arg, paramName, argNode)
		};
	}

	return node;
}

// ==========================================
// ★ Phase 7: オプティマイザ (事前評価・定数畳み込み・β簡約・静的ディスパッチ)
// ==========================================
function optimizeAst(node) {
	if (!node) return node;

	if (node.type === 'block') {
		return { ...node, body: node.body.map(optimizeAst) };
	}

	// ==========================================
	// ★ 修正1: 絶対値ノードの中身も最適化（定数畳み込み）する
	// ==========================================
	if (node.type === 'abs') {
		const expr = optimizeAst(node.expr);
		if (expr && expr.type === 'number') {
			return { type: 'number', value: Math.abs(expr.value) };
		}
		return { ...node, expr };
	}

	if (node.type === 'prefix') {
		const expr = optimizeAst(node.expr);

		// --- 前置演算子の定数畳み込み ---
		if (expr && expr.type === 'number') {
			// Signの仕様: どんな数値(0.0含む)もTruthyなので、! (論理NOT) は必ず Falsy (NaN) になる
			if (node.op === '!') return { type: 'identifier', value: '_' };
			// !! はビット反転(NOT)なので、i32にキャストして反転する
			if (node.op === '!!') return { type: 'number', value: ~(expr.value | 0) };
			if (node.op === '-') return { type: 'number', value: -expr.value };
		} else if (expr && expr.type === 'identifier' && expr.value === '_') {
			// NaN(_) に対する処理
			if (node.op === '!') return { type: 'number', value: 1 }; // !NaN -> 1
			if (node.op === '!!') return { type: 'number', value: -1 }; // !!NaN -> ~0 -> -1
		}
		return { ...node, expr };
	}

	if (node.type === 'infix') {
		const left = optimizeAst(node.left);
		const right = optimizeAst(node.right);

		// --- 定数畳み込み (Constant Folding) ---
		if (left && right && left.type === 'number' && right.type === 'number') {
			const l = left.value;
			const r = right.value;
			let result = null;

			switch (node.op) {
				case '+': result = l + r; break;
				case '-': result = l - r; break;
				case '*': result = l * r; break;
				case '/': result = l / r; break;
				case '==': result = (l === r) ? r : NaN; break;
				case '!=': result = (l !== r) ? r : NaN; break;
				case '<': result = (l < r) ? r : NaN; break;
				case '>': result = (l > r) ? r : NaN; break;
				case '<=': result = (l <= r) ? r : NaN; break;
				case '>=': result = (l >= r) ? r : NaN; break;
			}

			if (result !== null) {
				if (Number.isNaN(result)) {
					return { type: 'identifier', value: '_' };
				} else {
					return { type: 'number', value: result };
				}
			}
		}
		return { ...node, left, right };
	}

	if (node.type === 'apply') {
		let optFunc = optimizeAst(node.func);
		let optArg = optimizeAst(node.arg);

		// ==========================================
		// ★ 追加: Range演算子 (1 ~ 5) のパース救済
		// パーサが `A ~ B` を `(A ~) B` (後置演算子 + 関数適用) 
		// としてパースしてしまうため、ここで中置演算子(infix)の `~` に変換する！
		// ==========================================
		if (optFunc && optFunc.type === 'postfix' && optFunc.op === '~') {
			return optimizeAst({
				type: 'infix',
				op: '~',
				left: optFunc.expr,
				right: optArg
			});
		}

		// --- β簡約 (Beta Reduction / インライン展開) ---
		if (optFunc && optFunc.type === 'infix' && optFunc.op === '?') {
			let paramName = (optFunc.left && optFunc.left.type === 'identifier') ? optFunc.left.value.trim() : '';
			if (paramName) {
				let substitutedBody = substitute(optFunc.right, paramName, optArg);
				return optimizeAst(substitutedBody);
			}
		}

		// --- 静的ディスパッチ (Static Dispatch) ---
		// 左辺が「関数ではない純粋な値（数値・文字列・リスト・Unit）」であると確定している場合、
		// 空白適用 (A B) は「コンスセルの構築 (A , B)」と完全に同義である。
		// これをコンパイル時に置換し、実行時の重い型判定($apply_space)を完全に消滅させる！
		const isPureValue = (n) => n && (n.type === 'number' || n.type === 'string' || (n.type === 'infix' && n.op === ',') || n.type === 'unit');
		if (isPureValue(optFunc)) {
			return optimizeAst({
				type: 'infix',
				op: ',',
				left: optFunc,
				right: optArg
			});
		}

		return {
			...node,
			func: optFunc,
			arg: optArg
		};
	}

	return node;
}

let currentEnvDepth = 0;
let maxEnvDepth = -1;

// WASMスタック命令の生成
function compileNode(node, envMap = {}) {
	if (!node) return `    f64.const nan\n`;

	if (node.type === 'unit') {
		return `    f64.const nan\n`; // 万が一単体で来たとき用に追加
	}

	// ==========================================
	// ★ ここに追加！ Phase 8: 絶対値演算子 (|...|)
	// ==========================================
	if (node.type === 'abs') {
		let code = compileNode(node.expr, envMap);
		code += `    f64.abs\n`; // WASMネイティブの絶対値命令
		return code;
	}

	if (node.type === 'block') {
		let defineNodes = node.body.filter(child => child.type === 'infix' && child.op === ':' && child.left && child.left.type === 'identifier');
		let isEnvBlock = defineNodes.length > 0;
		let isDictReturn = node.body.length > 0 && node.body.every(child => child.type === 'infix' && child.op === ':' && child.left && child.left.type === 'identifier');

		let myDepth = -1;
		let envLocalName = '';
		let newEnvMap = { ...envMap };
		let code = '';
		let localVarsSize = defineNodes.length * 8;

		if (isEnvBlock) {
			myDepth = currentEnvDepth++;
			if (myDepth > maxEnvDepth) maxEnvDepth = myDepth;
			envLocalName = `$env_blk_${myDepth}`;

			// --- Prologue (Shadow Stack) ---
			code += `    ;; --- Prologue (Shadow Stack) ---\n`;
			code += `    global.get $SP\n`;
			code += `    local.set ${envLocalName}\n`;  // ブロック開始時のSPを保存(ベースポインタとして使用)
			code += `    global.get $SP\n    i32.const ${localVarsSize}\n    i32.sub\n    global.set $SP\n`; // SPを下げる(スタック領域確保)

			// ==========================================
			// ★ 変更1: スタック用オフセットとヒープ用オフセットを分ける
			// ==========================================
			let stackOffset = 8; // base -8, base -16 ... に配置
			let heapOffset = 8;  // 辞書のプロパティとしてのオフセットは8から (0はメタデータポインタ)
			let layoutMeta = {};
			for (let def of defineNodes) {
				let name = '';
				if (def.left && def.left.type === 'identifier') name = def.left.value.trim();
				if (name) {
					newEnvMap[name] = { type: 'stack_env', localName: envLocalName, offset: stackOffset };
					layoutMeta[name] = heapOffset;
					stackOffset += 8;
					heapOffset += 8;
				}
			}
			node._layout = layoutMeta;
			node._envLocalName = envLocalName;
		}

		if (!node.body || node.body.length === 0) return `    f64.const nan\n`;

		let blockId = blockCounter++;
		let blkName = `$blk_exit_${blockId}`;
		code += `    (block ${blkName} (result f64)\n`;

		// ★ 前回追加した childEnvMap は削除し、元の newEnvMap を使う

		for (let i = 0; i < node.body.length; i++) {
			let child = node.body[i];

			if (child.type === 'infix' && child.op === ':' && child.left && child.left.type === 'identifier') {
				// (既存の変数定義の処理。内部の childEnvMap を newEnvMap に戻す)
				let name = child.left.value.trim();

				if (name === '_') {
					code += compileNode(child.right, newEnvMap);
				} else {
					let targetOffset = (newEnvMap[name] && newEnvMap[name].type === 'stack_env') ? newEnvMap[name].offset : -1;
					let targetBase = (newEnvMap[name] && newEnvMap[name].type === 'stack_env') ? newEnvMap[name].localName : '';

					let rhsCode = compileNode(child.right, newEnvMap);
					if (name && child.right && child.right._layout && newEnvMap[name]) {
						newEnvMap[name].layout = child.right._layout;
					}
					code += rhsCode;
					if (targetOffset >= 0) {
						code += `    local.tee $tmp_R\n`;
						code += `    local.get ${targetBase}\n`;
						code += `    i32.const ${targetOffset}\n`;
						code += `    i32.sub\n`;
						code += `    local.get $tmp_R\n`;
						code += `    f64.store\n`;
					}
				}
			}
			// ==========================================
			// ★ 新規追加: ブロック直下の MatchCase Guard 専用処理
			else if (child.type === 'infix' && child.op === ':' && child.left && child.left.type !== 'identifier') {
				let codeGuard = compileNode(child.left, newEnvMap);
				codeGuard += `    call $is_not_unit\n`;
				codeGuard += `    if\n`;
				codeGuard += compileNode(child.right, newEnvMap);
				codeGuard += `      br ${blkName}\n`; // ここで現在のブロックから脱出！
				codeGuard += `    end\n`;
				codeGuard += `    f64.const nan\n`; // 条件不一致時はUnit。のちのdropで破棄される
				code += codeGuard;
			}
			// ==========================================
			else {
				code += compileNode(child, newEnvMap);
				if (child._layout && !node._layout) {
					node._layout = child._layout;
				}
			}

			if (i < node.body.length - 1) {
				code += `    drop\n`;
			}
		}

		code += `    )\n`; // end of (block $blk_exit...)

		if (isEnvBlock) {
			code += `    local.set $target_val\n`;

			// ★変更: ベースポインタを用いたエピローグ
			code += `    ;; --- Epilogue ---\n`;
			code += `    local.get ${envLocalName}\n    global.set $SP\n`; // SPをブロック開始時のベースポインタに戻す(解放)

			code += `    local.get $target_val\n`; // 評価結果を戻す

			if (isDictReturn) {
				// ==========================================
				// ★ 変更2: 辞書の実体をヒープに退避してポインタを返す
				// ==========================================
				code += `    drop\n`; // 最後の代入の戻り値を捨てる

				// 動的検索のためのメタデータ (Shape/VTable) をヒープに生成
				let metaSize = 8 + defineNodes.length * 16;
				code += `    i32.const ${metaSize}\n`;
				code += `    call $alloc\n`;
				code += `    local.set $tmp_meta_ptr\n`;

				code += `    local.get $tmp_meta_ptr\n`;
				code += `    f64.const ${defineNodes.length}\n`;
				code += `    f64.store offset=0\n`;

				let metaOff = 8;
				for (let def of defineNodes) {
					let name = def.left.value.trim();
					let hOff = node._layout[name];
					if (stringTable[name] === undefined) {
						stringTable[name] = stringAllocOffset;
						let watStr = encodeWatString(name);
						dataSection += `  (data (i32.const ${stringAllocOffset}) "${watStr}")\n`;
						let byteLen = unescape(encodeURIComponent(name)).length + 1;
						stringAllocOffset += byteLen;
						stringAllocOffset = (stringAllocOffset + 7) & ~7;
					}
					let strOffset = stringTable[name];
					code += `    local.get $tmp_meta_ptr\n`;
					code += `    i64.const 0x7FFD000000000000\n`;
					code += `    i64.const ${strOffset}\n`;
					code += `    i64.or\n`;
					code += `    f64.reinterpret_i64\n`;
					code += `    f64.store offset=${metaOff}\n`;
					metaOff += 8;
					code += `    local.get $tmp_meta_ptr\n`;
					code += `    f64.const ${hOff}\n`;
					code += `    f64.store offset=${metaOff}\n`;
					metaOff += 8;
				}

				let dictSize = defineNodes.length * 8 + 8;
				code += `    i32.const ${dictSize} \n`;
				code += `    call $alloc\n`;
				code += `    local.set $tmp_ptr\n`;

				code += `    local.get $tmp_ptr\n`;
				code += `    local.get $tmp_meta_ptr\n`;
				code += `    f64.convert_i32_u\n`;
				code += `    f64.store offset=0\n`;

				for (let def of defineNodes) {
					let name = def.left.value.trim();
					let sOff = newEnvMap[name].offset;
					let hOff = node._layout[name];

					// スタックから値を読み出してヒープにストア
					code += `    local.get $tmp_ptr\n`;
					code += `    local.get ${envLocalName} \n`;
					code += `    i32.const ${sOff} \n`;
					code += `    i32.sub\n`;
					code += `    f64.load\n`;
					code += `    f64.store offset=${hOff} \n`;
				}

				// 辞書ポインタをNaN-boxing (Dict Tag: 0x7FFB) して返す
				code += `    i64.const 0x7FFB000000000000\n`;
				code += `    local.get $tmp_ptr\n`;
				code += `    i64.extend_i32_u\n`;
				code += `    i64.or\n`;
				code += `    f64.reinterpret_i64\n`;
			}
			currentEnvDepth--;
		}

		return code;
	}

	if (node.type === 'number') {
		let valStr = node.value.toString();
		// JSの計算結果がNaNやInfinityになった場合の安全ガード
		if (valStr === 'NaN') return `    f64.const nan\n`;
		if (valStr === 'Infinity') return `    f64.const inf\n`;
		if (valStr === '-Infinity') return `    f64.const -inf\n`;

		if (!valStr.includes('.') && !valStr.includes('e')) valStr += '.0';
		return `    f64.const ${valStr} \n`;
	}

	if (node.type === 'identifier') {
		const name = node.value.trim();

		// ★ 追加: '_' の評価は常に Unit(NaN) 
		if (name === '_') {
			return `    f64.const nan\n`;
		}

		// ==========================================
		// ★ 追加: パーサが演算子を剥がした際に '5' などが識別子になってしまう問題の救済
		// ==========================================
		if (!isNaN(parseFloat(name)) && isFinite(name)) {
			let valStr = name;
			if (!valStr.includes('.') && !valStr.includes('e')) valStr += '.0';
			return `    f64.const ${valStr} \n`;
		}

		if (TEMPLATES[name]) {
			// ネイティブ演算子が単体で評価された場合（引数0個での出現）
			// 単純なNaNを返すのではなく、必要な引数分のダミーを受け取るクロージャを生成して返す
			let expectedArgs = ['!', '!!', '@'].includes(name) ? 1 : 2;
			let dummyParamNames = [];
			for (let i = 0; i < expectedArgs; i++) {
				dummyParamNames.push(`$curried_${i} `);
			}

			// 再カリー化を防ぐため、元の演算子は identifier ではなく直接ネイティブ命令を出力する特殊ノードにしておく
			let curriedAst = {
				type: 'native_op',
				value: name,
				args: dummyParamNames.map(n => ({ type: 'identifier', value: n }))
			};

			let finalLambdaAst = curriedAst;
			for (let i = expectedArgs - 1; i >= 0; i--) {
				finalLambdaAst = {
					type: 'infix',
					op: '?',
					left: { type: 'identifier', value: dummyParamNames[i] },
					right: JSON.parse(JSON.stringify(finalLambdaAst))
				};
			}
			return compileNode(finalLambdaAst, envMap);
		}
		if (envMap[name]) {
			const loc = envMap[name];
			if (loc.type === 'arg') {
				return `    local.get $arg\n`;
			} else if (loc.type === 'env') {
				return `    local.get $env\n    i32.trunc_sat_f64_u\n    f64.load offset=${loc.offset} \n`;
			} else if (loc.type === 'local_env') {
				return `    local.get ${loc.localName} \n    f64.load offset=${loc.offset} \n`;
			} else if (loc.type === 'stack_env') {
				// ★変更: その変数が属するブロックのベースポインタ ($env_blk_X) から相対ロード
				return `    local.get ${loc.localName} \n    i32.const ${loc.offset} \n    i32.sub\n    f64.load\n`;
			}
		}
		return `    ;; IGNORED: identifier(${name}) \n    f64.const nan\n`;
	}

	if (node.type === 'string') {
		let content = node.value.slice(1, -1);
		if (content.startsWith('\`') && content.endsWith('\`')) {
			content = content.slice(1, -1);
		}

		if (stringTable[content] === undefined) {
			stringTable[content] = stringAllocOffset;
			let watStr = encodeWatString(content);
			dataSection += `  (data(i32.const ${stringAllocOffset}) "${watStr}") \n`;

			// Compute byte length to bump allocator
			let byteLen = unescape(encodeURIComponent(content)).length + 1;
			stringAllocOffset += byteLen;
			stringAllocOffset = (stringAllocOffset + 7) & ~7; // 8-byte align
		}

		let offset = stringTable[content];
		// NaN-box the pointer into String Tag: 0x7FFD000000000000 | offset
		return `    i64.const 0x7FFD000000000000\n    i64.const ${offset} \n    i64.or\n    f64.reinterpret_i64\n`;
	}

	if (node.type === 'infix') {
		const op = node.op;

		if (op === '#') {
			let code = ``;
			code += compileNode(node.left, envMap);
			code += compileNode(node.right, envMap);
			code += `    call $apply_hash\n`;  // ★ランタイムのシステムコールに丸投げ
			return code;
		}

		if (op === ':') {
			if (node.left && node.left.type === 'identifier') {
				return `    ;; UNIMPLEMENTED: Standalone binding(: ) \n    f64.const nan\n`;
			} else {
				// ==========================================
				// ★ 修正: Condition : TrueBranch (Inline Guard / Ternary)
				let code = compileNode(node.left, envMap);
				code += `    call $is_not_unit\n`;
				code += `    if (result f64)\n`; // ジャンプせず値を返す
				code += compileNode(node.right, envMap);
				code += `    else\n`;
				code += `      f64.const nan\n`;
				code += `    end\n`;

				if (node.right && node.right._layout) {
					node._layout = node.right._layout;
				}

				return code;
				// ==========================================
			}
		}

		if (op === '?') {
			// Find free variables
			const paramName = (node.left && node.left.type === 'identifier') ? node.left.value.trim() : '';
			const freeVars = Array.from(getFreeVariables(node.right, new Set([paramName])));

			const funcIndex = closureCount++;
			const lambdaName = `$lambda_${funcIndex} `;

			// 1. Compile the body into a new WASM function
			let innerEnvMap = {};
			if (paramName) innerEnvMap[paramName] = { type: 'arg' };
			freeVars.forEach((v, i) => {
				let propagatedLayout = (envMap[v] && envMap[v].layout) ? envMap[v].layout : null;
				innerEnvMap[v] = { type: 'env', offset: i * 8, layout: propagatedLayout };
			});

			let savedDepth = currentEnvDepth;
			let savedMax = maxEnvDepth;
			currentEnvDepth = 0;
			maxEnvDepth = -1;

			let funcBody = compileNode(node.right, innerEnvMap);
			if (node.right && node.right._layout) {
				node._layout = node.right._layout;
			}

			let funcCode = `  (func ${lambdaName}(param $env f64)(param $arg f64)(result f64) \n`;
			funcCode += `    (local $tmp_bool f64) \n(local $tmp_L f64) \n(local $tmp_R f64) \n(local $tmp_ptr i32) \n`;
			funcCode += `    (local $target_val f64) \n(local $tag i32) \n(local $str_ptr i32) \n(local $list_val f64) \n(local $list_ptr i32) \n`;
			funcCode += `    (local $tmp_meta_ptr i32) \n`;
			for (let i = 0; i <= maxEnvDepth; i++) funcCode += `    (local $env_blk_${i} i32) \n`;
			funcCode += funcBody;
			funcCode += `  ) \n`;
			closureFunctions.push({ name: lambdaName, code: funcCode, index: funcIndex });

			currentEnvDepth = savedDepth;
			maxEnvDepth = savedMax;

			// 2. Emit code to create the closure object at runtime
			let code = ``;

			// Alloc Environment
			if (freeVars.length > 0) {
				code += `    i32.const ${freeVars.length * 8} \n`;
				code += `    call $alloc\n`;
				code += `    local.set $tmp_ptr\n`;
				freeVars.forEach((v, i) => {
					code += `    local.get $tmp_ptr\n`;
					if (envMap[v]) {
						if (envMap[v].type === 'arg') {
							code += `    local.get $arg\n`;
						} else if (envMap[v].type === 'env') {
							code += `    local.get $env\n    i32.trunc_sat_f64_u\n    f64.load offset=${envMap[v].offset} \n`;
						} else if (envMap[v].type === 'local_env') {
							code += `    local.get ${envMap[v].localName} \n    f64.load offset=${envMap[v].offset} \n`;
						} else if (envMap[v].type === 'stack_env') {
							// ★ここがクロージャ生成時のヒープ退避処理
							code += `    local.get ${envMap[v].localName} \n    i32.const ${envMap[v].offset} \n    i32.sub\n    f64.load\n`;
						} else {
							code += `    f64.const nan\n`;
						}
					} else {
						code += `    f64.const nan\n`;
					}
					code += `    f64.store offset=${i * 8} \n`;
				});
				code += `    local.get $tmp_ptr\n`;
				code += `    f64.convert_i32_u\n`;
				code += `    local.set $tmp_L\n`; // tmp_L holds env_ptr as f64
			} else {
				code += `    f64.const 0\n`;
				code += `    local.set $tmp_L\n`; // tmp_L holds 0 as f64
			}

			// Alloc Closure
			code += `    i32.const 16\n`;
			code += `    call $alloc\n`;
			code += `    local.set $tmp_ptr\n`;

			// Store Function Index
			code += `    local.get $tmp_ptr\n`;
			code += `    f64.const ${funcIndex} \n`;
			code += `    f64.store offset=0\n`;

			// Store Env Pointer
			code += `    local.get $tmp_ptr\n`;
			code += `    local.get $tmp_L\n`;
			code += `    f64.store offset=8\n`;

			// Create Tagged Pointer (f64)
			// Tag = 0x7FFE000000000000
			code += `    i64.const 0x7FFE000000000000\n`;
			code += `    local.get $tmp_ptr\n`;
			code += `    i64.extend_i32_u\n`;
			code += `    i64.or\n`;
			code += `    f64.reinterpret_i64\n`;
			return code;
		}

		if (op === "'") {
			let keyName = (node.right && node.right.type === 'identifier') ? node.right.value.trim() : '';
			let offset = -1;
			let lhsLayout = null;

			if (node.left && node.left.type === 'identifier') {
				let lhsName = node.left.value.trim();
				if (envMap[lhsName] && envMap[lhsName].layout) {
					lhsLayout = envMap[lhsName].layout;
				}
			} else if (node.left && node.left._layout) {
				lhsLayout = node.left._layout;
			}

			if (lhsLayout && keyName && lhsLayout[keyName] !== undefined) {
				offset = lhsLayout[keyName];
			}

			if (offset >= 0) {
				let code = compileNode(node.left, envMap);
				code += `    i64.reinterpret_f64\n`;
				code += `    i32.wrap_i64\n`;
				code += `    f64.load offset=${offset} \n`;
				return code;
			} else {
				// 動的辞書プロパティ参照: dict ' "key"
				let code = compileNode(node.left, envMap);
				code += compileNode(node.right, envMap);
				code += `    call $dynamic_dict_get\n`;
				return code;
			}
		}

		// ==========================================
		// ★ ここに追加！ Phase 9: 動的リスト構築 (Range演算子)
		// ==========================================
		if (op === '~') {
			let code = compileNode(node.left, envMap);
			code += compileNode(node.right, envMap);
			code += `    call $make_range\n`;
			return code;
		}

		if (op === "@") {
			// 動的メモリ参照（リスト要素などのアクセス）: index @ list
			let code = compileNode(node.right, envMap);
			code += `    local.set $tmp_L\n`; // base pointer
			code += compileNode(node.left, envMap);
			code += `    local.set $tmp_R\n`; // index offset

			// NaNガード
			code += `    local.get $tmp_R\n`;
			code += `    local.get $tmp_R\n`;
			code += `    f64.eq\n`;
			code += `    if (result f64) \n`;

			code += `      local.get $tmp_L\n`;
			code += `      i64.reinterpret_f64\n`;
			code += `      i32.wrap_i64\n`;
			code += `      local.get $tmp_R\n`;
			code += `      i32.trunc_sat_f64_u\n`;
			code += `      i32.const 3\n`;
			code += `      i32.shl\n`;
			code += `      i32.add\n`;
			code += `      f64.load\n`;

			code += `    else \n`;
			code += `      f64.const nan\n`;
			code += `    end\n`;
			return code;
		}

		if (['==', '=', '!='].includes(op)) {
			let code = compileNode(node.left, envMap);
			code += compileNode(node.right, envMap);
			code += `    local.set $tmp_R\n`;
			code += `    local.set $tmp_L\n`;

			code += `    local.get $tmp_L\n`;
			code += `    i64.reinterpret_f64\n`;
			code += `    local.get $tmp_R\n`;
			code += `    i64.reinterpret_f64\n`;

			if (op === '==' || op === '=') {
				code += `    i64.eq\n`;
			} else {
				code += `    i64.ne\n`;
			}

			// Convert i32 Wasm boolean to the actual value
			code += `    if (result f64) \n`;

			if (['number', 'string'].includes(node.left.type)) {
				code += `      local.get $tmp_R\n`;
			} else {
				code += `      local.get $tmp_L\n`;
			}

			code += `    else \n`;
			code += `      f64.const nan\n`;
			code += `    end\n`;
			return code;
		}

		if (['<', '>', '<=', '>='].includes(op)) {
			let code = compileNode(node.left, envMap);
			code += compileNode(node.right, envMap);
			code += `    local.set $tmp_R\n`;
			code += `    local.set $tmp_L\n`;

			code += `    local.get $tmp_L\n`;
			code += `    local.get $tmp_R\n`;
			code += `    ${TEMPLATES[op]} \n`;

			// Convert i32 Wasm boolean to the actual value
			code += `    if (result f64) \n`;

			if (['number', 'string'].includes(node.left.type)) {
				code += `      local.get $tmp_R\n`;
			} else {
				code += `      local.get $tmp_L\n`;
			}

			code += `    else \n`;
			code += `      f64.const nan\n`;
			code += `    end\n`;
			return code;
		}

		// --- LOGICAL OPERATORS (Short-Circuit) ---
		if (op === '&') {
			let code = compileNode(node.left, envMap);
			code += `    local.set $tmp_bool\n`;
			code += `    local.get $tmp_bool\n`;
			code += `    call $is_not_unit\n`;
			code += `    if (result f64) \n`;
			code += compileNode(node.right, envMap);
			code += `    else \n`;
			code += `      local.get $tmp_bool\n`; // Return Falsy (NaN)
			code += `    end\n`;
			return code;
		}

		if (op === '|') {
			let code = compileNode(node.left, envMap);
			code += `    local.set $tmp_bool\n`;
			code += `    local.get $tmp_bool\n`;
			code += `    call $is_not_unit\n`;
			code += `    if (result f64) \n`;
			code += `      local.get $tmp_bool\n`; // Return Truthy
			code += `    else \n`;
			code += compileNode(node.right, envMap);
			code += `    end\n`;
			return code;
		}

		if (op === ';') {
			// Logical XOR: Only one truthy. 
			// If both truthy -> NaN
			// If none truthy -> NaN
			// If one truthy -> return it.
			let code = compileNode(node.left, envMap);
			code += compileNode(node.right, envMap);
			code += `    local.set $tmp_R\n`;
			code += `    local.set $tmp_L\n`;

			code += `    local.get $tmp_L\n`;
			code += `    call $is_not_unit\n`;
			code += `    if (result f64) \n`;

			// L is Truthy
			code += `      local.get $tmp_R\n`;
			code += `      call $is_not_unit\n`;
			code += `      if (result f64) \n`;
			code += `        f64.const nan\n`; // Both Truthy -> NaN
			code += `      else \n`;
			code += `        local.get $tmp_L\n`; // L is alone Truthy
			code += `      end\n`;

			code += `    else \n`;

			// L is Falsy
			code += `      local.get $tmp_R\n`;
			code += `      call $is_not_unit\n`;
			code += `      if (result f64) \n`;
			code += `        local.get $tmp_R\n`; // R is alone Truthy
			code += `      else \n`;
			code += `        f64.const nan\n`; // Both Falsy -> NaN
			code += `      end\n`;

			code += `    end\n`;
			return code;
		}

		// --- BITWISE OPERATORS (i32 cast required) ---
		if (['&&', '||', ';;', '<<', '>>'].includes(op)) {
			let wasmOp = '';
			if (op === '&&') wasmOp = 'i32.and';
			if (op === '||') wasmOp = 'i32.or';
			if (op === ';;') wasmOp = 'i32.xor';
			if (op === '<<') wasmOp = 'i32.shl';
			if (op === '>>') wasmOp = 'i32.shr_s';

			let code = compileNode(node.left, envMap);
			// f64 to i32
			code += `    i32.trunc_sat_f64_s\n`;

			code += compileNode(node.right, envMap);
			// f64 to i32
			code += `    i32.trunc_sat_f64_s\n`;

			// Bitwise op
			code += `    ${wasmOp} \n`;

			// i32 to f64 back
			code += `    f64.convert_i32_s\n`;
			return code;
		}

		const isMissingLeft = !node.left;
		const isMissingRight = !node.right;

		if (isMissingLeft || isMissingRight) {
			const uuid = curryCounter++;
			if (isMissingLeft && isMissingRight) {
				const L = `0_curry_L_` + uuid;
				const R = `0_curry_R_` + uuid;
				const lambdaAst = {
					type: 'infix', op: '?',
					left: { type: 'identifier', value: L },
					right: {
						type: 'infix', op: '?',
						left: { type: 'identifier', value: R },
						right: { type: 'infix', op: node.op, left: { type: 'identifier', value: L }, right: { type: 'identifier', value: R } }
					}
				};
				return compileNode(lambdaAst, envMap);
			}

			if (isMissingLeft && !isMissingRight) {
				const C = `0_cap_R_` + uuid;
				const L = `0_curry_L_` + uuid;
				const blockAst = {
					type: 'block',
					body: [
						{ type: 'infix', op: ':', left: { type: 'identifier', value: C }, right: node.right },
						{
							type: 'infix', op: '?',
							left: { type: 'identifier', value: L },
							right: { type: 'infix', op: node.op, left: { type: 'identifier', value: L }, right: { type: 'identifier', value: C } }
						}
					]
				};
				return compileNode(blockAst, envMap);
			}

			if (!isMissingLeft && isMissingRight) {
				const C = `0_cap_L_` + uuid;
				const R = `0_curry_R_` + uuid;
				const blockAst = {
					type: 'block',
					body: [
						{ type: 'infix', op: ':', left: { type: 'identifier', value: C }, right: node.left },
						{
							type: 'infix', op: '?',
							left: { type: 'identifier', value: R },
							right: { type: 'infix', op: node.op, left: { type: 'identifier', value: C }, right: { type: 'identifier', value: R } }
						}
					]
				};
				return compileNode(blockAst, envMap);
			}
		} let code = compileNode(node.left, envMap);
		code += compileNode(node.right, envMap);
		if (TEMPLATES[op]) {
			code += `    ${TEMPLATES[op]} \n`;
			return code;
		}
		return `    ;; UNIMPLEMENTED: infix(${op}) \n`;
	}

	if (node.type === 'prefix') {
		if (!node.expr) {
			const uuid = curryCounter++;
			const L = `0_curry_L_` + uuid;
			const lambdaAst = {
				type: 'infix', op: '?',
				left: { type: 'identifier', value: L },
				right: { type: 'prefix', op: node.op, expr: { type: 'identifier', value: L } }
			};
			return compileNode(lambdaAst, envMap);
		}

		// アドレス取得演算子 $ の特別処理 (node.right ではなく node.expr を使用)
		if (node.op === '$' && node.expr && node.expr.type === 'identifier') {
			let name = node.expr.value.trim();
			if (envMap[name]) {
				let loc = envMap[name];
				if (loc.type === 'stack_env') {
					// 変数のポインタ (ベースポインタ -オフセット) を計算し、f64(数値)として返す
					let code = `    ;; --- Address of ${name} ---\n`;
					code += `    local.get ${loc.localName} \n`;
					code += `    i32.const ${loc.offset} \n`;
					code += `    i32.sub\n`;
					code += `    f64.convert_i32_u\n`; // WASMスタックにはf64として積む
					return code;
				} else {
					// スタック変数以外（未実装・またはグローバル）の場合はとりあえずNaN
					return `    f64.const nan\n`;
				}
			}
			return `    f64.const nan\n`;
		}

		if (node.op === '$') {
			let code = compileNode(node.expr, envMap);
			// 評価された値(タグ付きポインタ)から、下位32ビット(アドレスインデックス)のみを抽出し、
			// 再び通常の数値(f64)としてスタックに戻す
			code += `    i64.reinterpret_f64\n`;
			code += `    i32.wrap_i64\n`;
			code += `    f64.convert_i32_u\n`;
			return code;
		}

		if (node.op === '@') {
			let code = compileNode(node.expr, envMap);
			code += `    local.set $tmp_L\n`;

			// MMIO アドレスデコーダ (アドレス 0.0 = stdin)
			code += `    local.get $tmp_L\n`;
			code += `    f64.const 0.0\n`;
			code += `    f64.eq\n`;
			code += `    if (result f64) \n`;
			// ★変更: sys_read(63) を呼ぶ
			code += `      i32.const 63\n`;
			code += `      f64.const 0.0\n`; // sys_readにはダミー引数を渡す
			code += `      call $syscall\n`;
			code += `    else \n`;
			code += `      local.get $tmp_L\n`;
			code += `      i32.trunc_sat_f64_u\n`;
			code += `      i32.const 3\n`;
			code += `      i32.shl\n`;
			code += `      f64.load\n`;
			code += `    end\n`;
			return code;
		}
		if (node.op === '!') {
			let code = compileNode(node.expr, envMap);
			code += `    call $is_truthy\n`;
			code += `    if (result f64) \n`;
			code += `      f64.const nan\n`;
			code += `    else \n`;
			code += `      f64.const 1.0\n`;
			code += `    end\n`;
			return code;
		}

		if (node.op === '!!') {
			let code = compileNode(node.expr, envMap);
			code += `    i32.trunc_sat_f64_s\n`;
			code += `    i32.const -1\n`;
			code += `    i32.xor\n`;
			code += `    f64.convert_i32_s\n`;
			return code;
		}

		// ==========================================
		// ★ Phase 9: 持ち上げ演算子 (前置 ~ / Lift) のランタイム実行
		// ==========================================
		if (node.op === '~') {
			let code = compileNode(node.expr, envMap);
			code += `    call $lift\n`;
			return code;
		}

		let code = compileNode(node.expr, envMap);

		// ==========================================
		// ★ 修正2: 前置マイナスは引き算(sub)ではなく符号反転(neg)を使う
		// ==========================================
		if (node.op === '-') {
			code += `    f64.neg\n`;
			return code;
		}

		if (TEMPLATES[node.op]) {
			code += `    ${TEMPLATES[node.op]} \n`;
			return code;
		}

		// TEMPLATESに存在しない不正な前置演算子 (パーサが誤認した ':' や '?' など) の場合はパススルーを防ぐ
		return code + `    drop\n;; INVALID PREFIX OP(${node.op}) \n    f64.const nan\n`;
	}

	if (node.type === 'postfix') {
		if (node.op === '~') {
			let code = compileNode(node.expr, envMap);
			// 実行時に型をチェックし、List/String に応じたSPREADタグを安全に付与するシステムコール
			code += `    call $make_spread\n`;
			return code;
		}

		// ==========================================
		// ★ Phase 8: 階乗演算子 (後置 !)
		// ==========================================
		if (node.op === '!') {
			let code = compileNode(node.expr, envMap);
			let loopName = `$fact_loop_${blockCounter++} `;
			let endName = `$fact_end_${blockCounter++} `; // ★ ブロック脱出用のラベルを追加

			// --- 高速ネイティブ階乗ループ ---
			code += `    ;; --- Factorial Loop-- -\n`;
			code += `    local.set $tmp_L\n`; // tmp_L をカウンタ(N)として使う
			code += `    f64.const 1.0\n`;
			code += `    local.set $tmp_R\n`; // tmp_R を結果(Result)として使う

			code += `    (block ${endName}\n`;  // ★ ループ全体を囲む脱出用ブロック
			code += `      (loop ${loopName}\n`;

			// ★ 無限ループ防止: if !(N > 1.0) break; 
			// (NaNと比較した場合は gt が false になり、eqz で true に反転して即脱出する)
			code += `        local.get $tmp_L\n`;
			code += `        f64.const 1.0\n`;
			code += `        f64.gt\n`;
			code += `        i32.eqz\n`;
			code += `        br_if ${endName}\n`;

			// Result = Result * N
			code += `        local.get $tmp_R\n`;
			code += `        local.get $tmp_L\n`;
			code += `        f64.mul\n`;
			code += `        local.set $tmp_R\n`;

			// N = N -1
			code += `        local.get $tmp_L\n`;
			code += `        f64.const 1.0\n`;
			code += `        f64.sub\n`;
			code += `        local.set $tmp_L\n`;

			code += `        br ${loopName}\n`; // ループの先頭に戻る(continue)
			code += `      ) \n`;
			code += `    ) \n`;
			code += `    local.get $tmp_R\n`; // 結果をスタックに積む
			return code;
		}

		return `    ;; UNIMPLEMENTED: postfix(${node.op}) \n    f64.const nan\n`;
	}

	if (node.type === 'native_op') {
		let code = '';
		for (let i = node.args.length - 1; i >= 0; i--) {
			code += compileNode(node.args[i], envMap);
		}
		code += `    ${TEMPLATES[node.value]} \n`; // カリー化内で引数が積まれた後に直接呼ばれる前提
		return code;
	}

	if (node.type === 'apply') {
		if (node.func && node.func.type === 'unit') {
			let code = compileNode(node.arg, envMap);
			if (node.arg && node.arg._layout) node._layout = node.arg._layout;
			if (node.arg && node.arg._envLocalName) node._envLocalName = node.arg._envLocalName;
			return code;
		}

		const isNative = (fnNode) => {
			if (!fnNode) return false;
			if (fnNode.type === 'identifier' && TEMPLATES[fnNode.value]) return true;
			if (fnNode.type === 'native_op') return true;
			// func側にあるパイプラインノードは、すでにカリー化関数(ポインタ)等になっているためネイティブ展開しない
			if (fnNode.type === 'apply' && !fnNode.pipeline) return isNative(fnNode.func);
			return false;
		};

		if (isNative(node.func) && !node.pipeline) {
			const flattenNativeApply = (n) => {
				if (!n) return { args: [], op: null };
				if (n.type === 'identifier' && TEMPLATES[n.value]) return { args: [], op: n.value };
				if (n.type === 'native_op') return { args: [], op: n.value, isCurriedBody: true };
				if (n.type === 'apply' && !n.pipeline) {
					let inner = flattenNativeApply(n.func);
					inner.args.push(n.arg);
					return inner;
				}
				return { args: [], op: null };
			};

			let info = flattenNativeApply(node);
			let expectedArgs = ['!', '!!', '@'].includes(info.op) ? 1 : 2;

			if (info.args.length < expectedArgs && !info.isCurriedBody) {
				let missingCount = expectedArgs - info.args.length;
				let uuid = curryCounter++;

				// 引数がある場合、再評価を防ぐために一旦ブロック（Environment）に退避して eager-eval を行う
				let blockBody = [];
				let collectedArgs = [];

				for (let i = 0; i < info.args.length; i++) {
					let capName = `0_cap_${i}_${uuid} `;
					blockBody.push({ type: 'infix', op: ':', left: { type: 'identifier', value: capName }, right: info.args[i] });
					collectedArgs.push({ type: 'identifier', value: capName });
				}

				let dummyParamNames = [];
				for (let i = 0; i < missingCount; i++) {
					let curryName = `0_curry_${i}_${uuid} `;
					dummyParamNames.push(curryName);
					collectedArgs.push({ type: 'identifier', value: curryName });
				}

				let curriedAst = {
					type: 'native_op',
					value: info.op,
					args: collectedArgs,
					isCurriedBody: true
				};

				let finalLambdaAst = curriedAst;
				for (let i = missingCount - 1; i >= 0; i--) {
					finalLambdaAst = {
						type: 'infix',
						op: '?',
						left: { type: 'identifier', value: dummyParamNames[i] },
						right: JSON.parse(JSON.stringify(finalLambdaAst))
					};
				}

				if (info.args.length > 0) {
					blockBody.push(finalLambdaAst);
					let blockAst = { type: 'block', body: blockBody };
					return compileNode(blockAst, envMap);
				} else {
					return compileNode(finalLambdaAst, envMap);
				}
			}

			// 引数が揃っている（後から渡された）場合はそのままネイティブ命令を出力
			// ただし、引数群 args の中にさらに関数（カリー化されたものや関数ポインタ）が含まれており、
			// なおかつ自分が pipeline に巻き込まれている場合は直接出力せずクロージャ呼び出しにフォールバックさせる
			let hasFunctionArg = info.args.some(a => {
				if (!a) return false;
				if (a.type === 'native_op') return true;
				if (a.type === 'identifier' && !TEMPLATES[a.value]) return true; // ユーザー定義関数や変数の可能性
				if (a.type === 'apply') {
					// 適用結果が関数のままであるか（カリー化クロージャ等）
					const checkNative = (n) => {
						if (!n) return false;
						if (n.type === 'identifier' && TEMPLATES[n.value]) return true;
						if (n.type === 'native_op') return true;
						if (n.type === 'apply') return checkNative(n.func);
						return false;
					};
					if (checkNative(a.func)) {
						// 引数が足りているか？
						let innerInfo = flattenNativeApply(a);
						let expected = ['!', '!!', '@'].includes(innerInfo.op) ? 1 : 2;
						if (innerInfo.args.length < expected) return true; // 引数不足＝関数ポインタ
					}
					if (a.pipeline) return true;
				}
				return false;
			});

			if (hasFunctionArg) {
				// isNative で弾かれたものとして扱い、後続の apply_closure 呼び出し処理へ回す
			} else {
				let code = '';
				for (let i = info.args.length - 1; i >= 0; i--) {
					code += compileNode(info.args[i], envMap);
				}
				code += `    ${TEMPLATES[info.op]} \n`;
				return code;
			}
		}

		if (node.func && node.func.type === 'identifier') {
			let fnName = node.func.value.trim();
			if (envMap[fnName] && envMap[fnName].layout) {
				node._layout = envMap[fnName].layout;
			}
		} else if (node.func && node.func._layout) {
			node._layout = node.func._layout;
		}

		let code = '';

		let funcNodeCode = compileNode(node.func, envMap);
		let argNodeCode = compileNode(node.arg, envMap);

		if (node.pipeline) {
			code += argNodeCode;
			code += funcNodeCode;
			code += `    call $apply_space\n`; // ★変更：単純適用からSPREAD対応の適用へ
			return code;
		}

		code += funcNodeCode;
		code += argNodeCode;
		code += `    call $apply_space_reversed\n`; // ★変更
		return code;
	}

	return `    ;; IGNORED: ${node.type} \n    f64.const nan\n`;
}

export function expandMacrosPublic(ast) { return expandMacros(ast, {}); }
export function compileToWat(ast) {
	stringTable = {};
	stringAllocOffset = 1024;
	dataSection = '';
	closureFunctions = [];
	closureCount = 0;
	unrollCounter = 0;
	blockCounter = 0;
	lambdaCounter = 0;
	curryCounter = 0;

	const expandedAst = expandMacros(ast, {});

	// ==========================================
	// ★ ここでAST最適化パス（事前評価）を通す！
	// ==========================================
	const optimizedAst = optimizeAst(expandedAst);

	currentEnvDepth = 0;
	maxEnvDepth = -1;

	// 最適化されたASTを元にWASMコードを生成
	const bodyCode = compileNode(optimizedAst, {});

	let closureCode = '';
	let elemSection = '';

	if (closureFunctions.length > 0) {
		closureFunctions.sort((a, b) => a.index - b.index);
	}
	let tableSize = closureFunctions.length > 0 ? closureFunctions.length : 1;
	elemSection = `  (table ${tableSize} funcref) \n`;
	if (closureFunctions.length > 0) {
		elemSection += `  (elem(i32.const 0)`;
		closureFunctions.forEach(f => {
			elemSection += ` ${f.name}`;
			closureCode += f.code + '\n';
		});
		elemSection += `) \n`;
	}
	elemSection += `  (type $closure_sig(func(param f64 f64)(result f64))) \n`;

	return `(module
  ;; ★変更: 個別のI / O関数を廃止し、AArch64風の単一syscallに統合
							(import "env" "syscall"(func $syscall(param i32 f64)(result f64)))
						(import "env" "math_fmod"(func $math_fmod(param f64 f64)(result f64)))
						(import "env" "math_pow"(func $math_pow(param f64 f64)(result f64)))

						(memory(export "memory") 1)

						;; ★追加: AArch64風 シャドウスタックポインタ(初期値 64KB = 65536)
							(global $SP(mut i32)(i32.const 65536))
							(global $FP(mut i32)(i32.const 65536))

${elemSection}
						(global $heap_alloc_ptr(mut i32)(i32.const ${stringAllocOffset}))
${dataSection}
						(func $alloc(param $size i32)(result i32)
							(local $ptr i32)
						global.get $heap_alloc_ptr
						local.set $ptr

						global.get $heap_alloc_ptr
						local.get $size
						i32.add
						global.set $heap_alloc_ptr

						local.get $ptr
  )

						(func $cons(param $car f64)(param $cdr f64)(result f64)
							(local $ptr i32)
						i32.const 16
    call $alloc
						local.tee $ptr

						local.get $car
						f64.store offset=0

						local.get $ptr
						local.get $cdr
						f64.store offset=8

							;; リストのポインタを NaN -boxing する(Tag: 0x7FFC000000000000)
						i64.const 0x7FFC000000000000
						local.get $ptr
						i64.extend_i32_u
						i64.or
						f64.reinterpret_i64
  )

						(func $make_range(param $start f64)(param $end f64)(result f64)
							(local $curr f64)
							(local $step f64)
							(local $count f64)
							(local $list f64)

							;; 1. 初期リストを Unit(NaN) に設定
						i64.const 0x7FF8000000000000
						f64.reinterpret_i64
						local.set $list

							;; 2. 生成する要素数を計算: count = floor(abs(start -end)) + 1.0
						local.get $start
						local.get $end
						f64.sub
						f64.abs
						f64.floor
						f64.const 1.0
						f64.add
						local.set $count

							;; 3. 進行方向(step)の決定(後ろから前に向かうための逆向きステップ)
						local.get $start
						local.get $end
						f64.le
						if
      f64.const -1.0  ;; start <= end なら、後ろから前へはマイナス方向
						local.set $step
    else
						f64.const 1.0;; start > end なら、後ろから前へはプラス方向
						local.set $step
						end

							;; 4. ループ開始地点(curr)の計算: curr = start -(count -1.0) * step
								;; （浮動小数点の誤差蓄積を防ぐため、正確な終点から逆算する）
						local.get $start
						local.get $count
						f64.const 1.0
						f64.sub
						local.get $step
						f64.mul
						f64.sub
						local.set $curr

							;; 5. 逆順リスト構築ループ
								(block $break
									(loop $loop
        ;; list = cons(curr, list)
						local.get $curr
						local.get $list
        call $cons
						local.set $list

							;; count -= 1.0
						local.get $count
						f64.const 1.0
						f64.sub
						local.tee $count

							;; if (count <= 0) break
						f64.const 0.0
						f64.le
        br_if $break

							;; curr += step
						local.get $curr
						local.get $step
						f64.add
						local.set $curr

        br $loop
      )
    )
						;; 完成したリストの先頭ポインタを返す
						local.get $list
  )

						(func $is_not_unit(param $val f64)(result i32)
							;; 完全に Unit(NaN) 0x7FF8000000000000 の場合のみ 0 (False) を返す
							local.get $val
							i64.reinterpret_f64
							i64.const 0x7FF8000000000000
							i64.eq
							if
								i32.const 0
								return
							end
							;; それ以外(クロージャや数値、リスト等)はすべて 1 (True) として通す
							i32.const 1
						)

						(func $is_truthy(param $val f64)(result i32)
							(local $tag i32)
						local.get $val
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $tag

							;; If it's pure Unit(NaN), falsy
						local.get $val
						i64.reinterpret_f64
						i64.const 0x7FF8000000000000
						i64.eq
						if
      i32.const 0
						return
						end

							;; If it's Closure(0x7FFE), falsy
						local.get $tag
						i32.const 0x7FFE0000
						i32.eq
						if
      i32.const 0
						return
						end

						i32.const 1
  )

						(func $dynamic_dict_get(param $dict f64)(param $key f64)(result f64)
							(local $dict_ptr i32)
							(local $meta_ptr i32)
							(local $count i32)
							(local $i i32)
							(local $curr_key f64)
							(local $curr_offset i32)
							(local $dict_tag i32)

							;; 辞書タグ(0x7FFB) かどうかチェック
						local.get $dict
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $dict_tag

						local.get $dict_tag
						i32.const 0x7FFB0000
						i32.ne
						if
      ;; Fallback to old array index logic if not a dictionary
						local.get $key
						local.get $key
						f64.eq
						if (result f64)
						local.get $dict
						i64.reinterpret_f64
						i32.wrap_i64
						local.get $key
						i32.trunc_sat_f64_u
						i32.const 3
						i32.shl
						i32.add
						f64.load
      else
						f64.const nan
						end
						return
						end

							;; dict_ptr = (i32) $dict
						local.get $dict
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $dict_ptr

							;; meta_ptr = (i32) memory[dict_ptr] // offset 0
						local.get $dict_ptr
						f64.load offset=0
						i32.trunc_sat_f64_u
						local.set $meta_ptr

							;; meta_ptr が 0 なら古いインデックスアクセスにフォールバック、あるいはNaN
						local.get $meta_ptr
						i32.eqz
						if
      f64.const nan
						return
						end

							;; count = memory[meta_ptr + 0]
						local.get $meta_ptr
						f64.load offset=0
						i32.trunc_sat_f64_u
						local.set $count

							;; i = 0
						i32.const 0
						local.set $i

							(block $loop_end
								(loop $loop
        local.get $i
        local.get $count
        i32.ge_u
        br_if $loop_end

        ;; curr_key = memory[meta_ptr + 8 + i * 16]
						local.get $meta_ptr
						i32.const 8
						i32.add
						local.get $i
						i32.const 4
						i32.shl;; i * 16
						i32.add
						f64.load
						local.set $curr_key

							;; if curr_key == $key
        local.get $curr_key
						i64.reinterpret_f64
						local.get $key
						i64.reinterpret_f64
						i64.eq
						if
          ;; curr_offset=(i32) memory[meta_ptr + 16 + i * 16]
						local.get $meta_ptr
						i32.const 16
						i32.add
						local.get $i
						i32.const 4
						i32.shl
						i32.add
						f64.load
						i32.trunc_sat_f64_u
						local.set $curr_offset

							;; return memory[dict_ptr + curr_offset]
						local.get $dict_ptr
						local.get $curr_offset
						i32.add
						f64.load
						return
						end

						local.get $i
						i32.const 1
						i32.add
						local.set $i
        br $loop
      )
    )

						;; 辞書に見つからなかった場合
						f64.const nan
  )

						(func $apply_closure(param $arg_val f64)(param $func_val f64)(result f64)
							(local $ptr i32)
							(local $env f64)
							(local $func_idx i32)

						local.get $func_val
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						i32.const 0x7FFE0000
						i32.ne
						if
      f64.const nan
						return
						end

						local.get $func_val
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $ptr

						local.get $ptr
						f64.load offset=8
						local.set $env

						local.get $ptr
						f64.load offset=0
						i32.trunc_sat_f64_u
						local.set $func_idx

						local.get $env
						local.get $arg_val
						local.get $func_idx
						call_indirect(type $closure_sig)
  )

						(func $apply_closure_reversed(param $func_val f64)(param $arg_val f64)(result f64)
						local.get $arg_val
						local.get $func_val
    call $apply_closure
  )

						(func $spread_concat(param $left f64)(param $right f64)(result f64)
							(local $src_ptr i32)
							(local $head_ptr i32)
							(local $tail_ptr i32)
							(local $new_node i32)
							(local $last_node i32)
							(local $tag i32)
							(local $cdr_val f64)
							(local $cdr_tag i32)

							;; Check if left is List(0x7FFC) or Spread List(0x7FF4)
						local.get $left
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $tag

						local.get $tag
						i32.const 0x7FFC0000
						i32.eq
						local.get $tag
						i32.const 0x7FF40000
						i32.eq
						i32.or
						if
      local.get $left
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $src_ptr

						i32.const 0
						local.set $head_ptr
						i32.const 0
						local.set $tail_ptr

							;; Deep copy loop for left side
								(block $copy_end
									(loop $copy_loop
          local.get $src_ptr
          i32.eqz
          br_if $copy_end

          i32.const 16
          call $alloc
          local.set $new_node

          local.get $new_node
          local.get $src_ptr
          f64.load offset=0
          f64.store offset=0

          local.get $tail_ptr
          i32.eqz
          if
            local.get $new_node
						local.set $head_ptr
          else
						local.get $tail_ptr
						i64.const 0x7FFC000000000000
						local.get $new_node
						i64.extend_i32_u
						i64.or
						f64.reinterpret_i64
						f64.store offset=8
						end

						local.get $new_node
						local.set $tail_ptr

						local.get $src_ptr
						f64.load offset=8
						local.set $cdr_val

						local.get $cdr_val
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $cdr_tag

						local.get $cdr_tag
						i32.const 0x7FFC0000
						i32.eq
						local.get $cdr_tag
						i32.const 0x7FF40000
						i32.eq
						i32.or
						if
            local.get $cdr_val
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $src_ptr
            br $copy_loop
          else
						;; -------------------------------------------
            ;; ★ 修正版: NaN(Unit) なら最後のノード追加をスキップして終了
						local.get $cdr_val
						i64.reinterpret_f64
						i64.const 0x7FF8000000000000
						i64.eq
						if
              br $copy_end
						end
							;; -------------------------------------------

            ;; End of dot -pair, add one more node
						i32.const 16
            call $alloc
						local.set $last_node

						local.get $last_node
						local.get $cdr_val
						f64.store offset=0

						local.get $tail_ptr
						i64.const 0x7FFC000000000000
						local.get $last_node
						i64.extend_i32_u
						i64.or
						f64.reinterpret_i64
						f64.store offset=8

						local.get $last_node
						local.set $tail_ptr
            br $copy_end
						end
        )
      )

						;; Attach right side
						local.get $tail_ptr
						i32.eqz
						if
        local.get $right
						return
      else
						local.get $tail_ptr
						local.get $right
						f64.store offset=8

						i64.const 0x7FFC000000000000
						local.get $head_ptr
						i64.extend_i32_u
						i64.or
						f64.reinterpret_i64
						return
						end
						end

							;; Fallback
						local.get $left
						local.get $right
    call $cons
  )

						;; ==========================================
  ;; 新アーキテクチャ: 動的ディスパッチと除法射
							;; ==========================================

  ;; $make_spread: ~演算子の実体。元の型を維持しつつ SPREAD フラグを立てる
							(func $make_spread(param $val f64)(result f64)
								(local $tag i32)
    local.get $val
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    local.set $tag

    ;; List(0x7FFC) -> Spread List(0x7FF4)
						local.get $tag
						i32.const 0x7FFC0000
						i32.eq
						if
      local.get $val
						i64.reinterpret_f64
						i64.const 0x0008000000000000;; タグビットを反転して 0x7FF4 にする
						i64.xor
						f64.reinterpret_i64
						return
						end

							;; String(0x7FFD) -> Spread String(0x7FF5)
						local.get $tag
						i32.const 0x7FFD0000
						i32.eq
						if
      local.get $val
						i64.reinterpret_f64
						i64.const 0x0008000000000000;; タグビットを反転して 0x7FF5 にする
						i64.xor
						f64.reinterpret_i64
						return
						end

							;; それ以外(未定義変数など)を展開しようとした場合は NaN のまま返す(安全装置)
						f64.const nan
  )

						;; ==========================================
  ;; ★ 追加: $lift(前置 ~演算子)。Spreadタグを解除するか、純粋な値をリストに包む
							;; ==========================================
								(func $lift(param $val f64)(result f64)
									(local $tag i32)
						local.get $val
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $tag

							;; Spread List(0x7FF4) -> Normal List(0x7FFC)
						local.get $tag
						i32.const 0x7FF40000
						i32.eq
						if
      local.get $val
						i64.reinterpret_f64
						i64.const 0x0008000000000000;; タグビットを反転
						i64.xor
						f64.reinterpret_i64
						return
						end

							;; Spread String(0x7FF5) -> Normal String(0x7FFD)
						local.get $tag
						i32.const 0x7FF50000
						i32.eq
						if
      local.get $val
						i64.reinterpret_f64
						i64.const 0x0008000000000000;; タグビットを反転
						i64.xor
						f64.reinterpret_i64
						return
						end

							;; その他: 値を単一要素のリストに包む cons(val, Unit)
						local.get $val
						i64.const 0x7FF8000000000000
						f64.reinterpret_i64
    call $cons
  )

						;; $apply_hash: # 演算子の実体(AArch64 SVC / システムコール仕様 & パススルー)
							(func $apply_hash(param $left f64)(param $right f64)(result f64)
								(local $tag i32)
								(local $ptr i32)
								(local $target_val f64)

    local.get $right
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    local.set $tag

    ;; ==========================================
    ;; ★ SVC(Supervisor Call) ルーティング(stdout)
							;; ==========================================
								local.get $left
						f64.const 1.0
						f64.eq
						if
      ;; ★ 修正: 展開リスト(Spread List: 0x7FF4) 以外は直接syscallで一括出力
						local.get $tag
						i32.const 0x7FF40000
						i32.ne
						if
        i32.const 64
						local.get $right
        call $syscall
						return
						end
						end

							;; --- Spread List(0x7FF4)-- -
								local.get $tag
						i32.const 0x7FF40000
						i32.eq
						if
      local.get $right
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $ptr

							(block $spread_loop_end
								(loop $spread_loop
          local.get $ptr
          i32.eqz  ;; ポインタが0(念のための安全装置)
          br_if $spread_loop_end

							;; --- car(左側) の処理-- -
								local.get $left
						local.get $ptr
						f64.load offset=0
          call $apply_hash_single
						drop

							;; --- cdr(右側) の処理-- -
								local.get $ptr
						f64.load offset=8
						local.set $target_val

							;; cdrが Unit(0x7FF8000000000000) なら展開ループを終了
						local.get $target_val
						i64.reinterpret_f64
						i64.const 0x7FF8000000000000
						i64.eq
						if
            br $spread_loop_end
						end

							;; cdrの型タグを確認
						local.get $target_val
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $tag

						local.get $tag
						i32.const 0x7FFC0000
						i32.eq
						if
            ;; cdrがリストなら、ポインタを更新して次へ進む
						local.get $target_val
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $ptr
            br $spread_loop
          else
						;; cdrがリスト以外(数値やNaNなど) なら、それが最後の要素
						local.get $left
						local.get $target_val
            call $apply_hash_single
						drop
            br $spread_loop_end
						end
        )
      )
						local.get $right;; 右辺をパススルー
						return
						end

							;; --- Spread String(0x7FF5)-- -(stdout以外のポートへの展開用)
						local.get $tag
						i32.const 0x7FF50000
						i32.eq
						if
      local.get $right
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $ptr

							(block $spread_loop_end
								(loop $spread_loop
          local.get $ptr
          i32.load8_u
          i32.eqz  ;; 文字列終端(\0) なら脱出
          br_if $spread_loop_end

						local.get $left
						local.get $ptr
						i32.load8_u
						f64.convert_i32_u
          call $apply_hash_single
						drop

						local.get $ptr
						i32.const 1
						i32.add
						local.set $ptr
          br $spread_loop
        )
      )
						local.get $right;; 右辺をパススルー
						return
						end

							;; === 単発実行 ===
								local.get $left
						local.get $right
    call $apply_hash_single
						drop

						local.get $right;; 最終的に右辺をパススルー
  )

						;; $apply_hash_single: 1要素に対する実際のMMIO処理(ポリモーフィズム対応版)
							(func $apply_hash_single(param $left f64)(param $right f64)(result f64)
    local.get $left
    f64.const 1.0
    f64.eq
    if
      ;; ★変更: stdoutなら、どんな型であろうと sys_write(64) に丸投げ
						i32.const 64
						local.get $right
      call $syscall
						drop
    else
						;; stdout以外のポートならWASMメモリに直接ストア(MMIO)
						local.get $left
						i32.trunc_sat_f64_u
						i32.const 3
						i32.shl
						local.get $right
						f64.store
						end
						f64.const nan
  )

						(func $apply_space(param $right f64)(param $left f64)(result f64)
							(local $tag i32)
							(local $left_tag i32)
							(local $ptr i32)
							(local $last_result f64)
							(local $target_val f64)

							;; Dispatch coproduct if left is a list
						local.get $left
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $left_tag

							;; If left is not closure(0x7FFE)
						local.get $left_tag
						i32.const 0x7FFE0000
						i32.ne
						if
      ;; If left is List or Spread List, do concat
      local.get $left_tag
						i32.const 0x7FFC0000
						i32.eq
						local.get $left_tag
						i32.const 0x7FF40000
						i32.eq
						i32.or
						if
        local.get $left
						local.get $right
        call $spread_concat
						return
						end
						end

							;; Function application
						local.get $right
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $tag

							;; --- Spread List(0x7FF4)-- -
								local.get $tag
						i32.const 0x7FF40000
						i32.eq
						if
      local.get $right
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $ptr

						f64.const nan
						local.set $last_result

							(block $spread_loop_end
								(loop $spread_loop
          local.get $ptr
          i32.eqz
          br_if $spread_loop_end

          local.get $ptr
          f64.load offset=0
          local.get $left
          call $apply_closure
          local.set $last_result

          local.get $ptr
          f64.load offset=8
          local.set $target_val

          ;; -------------------------------------------
          ;; ★ 修正版: cdrが Unit(0x7FF8000000000000) なら展開ループを終了
						local.get $target_val
						i64.reinterpret_f64
						i64.const 0x7FF8000000000000
						i64.eq
						if
            br $spread_loop_end
						end
							;; -------------------------------------------

								local.get $target_val
						i64.reinterpret_f64
						i64.const 32
						i64.shr_u
						i32.wrap_i64
						local.set $tag

						local.get $tag
						i32.const 0x7FFC0000
						i32.eq
						local.get $tag
						i32.const 0x7FF40000
						i32.eq
						i32.or
						if
            local.get $target_val
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $ptr
            br $spread_loop
          else
						local.get $target_val
						local.get $left
            call $apply_closure
						local.set $last_result
            br $spread_loop_end
						end
        )
      )
						local.get $last_result
						return
						end

							;; --- Spread String(0x7FF5)-- -
								local.get $tag
						i32.const 0x7FF50000
						i32.eq
						if
      local.get $right
						i64.reinterpret_f64
						i32.wrap_i64
						local.set $ptr

						f64.const nan
						local.set $last_result

							(block $spread_loop_end_str
								(loop $spread_loop_str
          local.get $ptr
          i32.load8_u
          i32.eqz
          br_if $spread_loop_end_str

          local.get $ptr
          i32.load8_u
          f64.convert_i32_u
          local.get $left
          call $apply_closure
          local.set $last_result

          local.get $ptr
          i32.const 1
          i32.add
          local.set $ptr
          br $spread_loop_str
								)
							)
						local.get $last_result
						return
						end

							;; === Single execution ===
								local.get $right
						local.get $left
    call $apply_closure
  )

						(func $apply_space_reversed(param $left f64)(param $right f64)(result f64)
						local.get $right
						local.get $left
    call $apply_space
  )
  
${closureCode}
						(func $main(export "main")(result f64)
							(local $tmp_bool f64)
							(local $tmp_L f64)
							(local $tmp_R f64)
							(local $tmp_ptr i32)
							(local $target_val f64)
							(local $tag i32)
							(local $str_ptr i32)
							(local $list_val f64)
							(local $list_ptr i32)
							(local $tmp_meta_ptr i32)
${Array.from({ length: maxEnvDepth + 1 }, (_, i) => `    (local $env_blk_${i} i32)\n`).join('')}
${bodyCode ? bodyCode : '    f64.const 0.0\n'}  )
)`;
}