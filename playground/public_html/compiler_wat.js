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
		const argName = '$compose_arg_' + Math.random().toString(36).substr(2, 5);
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
			const argName = '$compose_arg_' + Math.random().toString(36).substr(2, 5);
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

			if (expandedFunc.type === 'block') {
				return { type: 'block', body: [...expandedFunc.body, expandedArg], _expanded: true };
			}
			return { type: 'block', body: [expandedFunc, expandedArg], _expanded: true };
		}

		// 3. 引数のスプレッド展開 (Func -> Block(タプル))
		if (isFuncL && expandedArg && expandedArg.type === 'block' && !node.pipeline) {
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
	if (node.type === 'prefix' || node.type === 'postfix') {
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

let currentEnvDepth = 0;
let maxEnvDepth = -1;

// WASMスタック命令の生成
function compileNode(node, envMap = {}) {
	if (!node) return `    f64.const nan\n`;
	if (node.type === 'apply' && node.func && node.func.type === 'unit') {
	}

	if (node.type === 'block') {
		let defineNodes = node.body.filter(child => child.type === 'infix' && child.op === ':' && child.left && child.left.type === 'identifier');
		let isEnvBlock = defineNodes.length > 0;
		// If ALL statements are definitions, treat this block as returning its Environment (Dictionary literal)
		let isDictReturn = node.body.length > 0 && node.body.every(child => child.type === 'infix' && child.op === ':' && child.left && child.left.type === 'identifier');

		let myDepth = -1;
		let envLocalName = '';
		let newEnvMap = { ...envMap };
		let code = '';

		if (isEnvBlock) {
			myDepth = currentEnvDepth++;
			if (myDepth > maxEnvDepth) maxEnvDepth = myDepth;
			envLocalName = `$env_blk_${myDepth}`;

			code += `    i32.const ${defineNodes.length * 8}\n`;
			code += `    call $alloc\n`;
			code += `    local.set ${envLocalName}\n`;

			let offset = 0;
			let layoutMeta = {};
			for (let def of defineNodes) {
				let name = '';
				if (def.left && def.left.type === 'identifier') name = def.left.value.trim();
				if (name) {
					newEnvMap[name] = { type: 'local_env', localName: envLocalName, offset: offset };
					layoutMeta[name] = offset;
					offset += 8;
				}
			}
			node._layout = layoutMeta;
			node._envLocalName = envLocalName;
		}

		if (!node.body || node.body.length === 0) return `    f64.const nan\n`;

		let blockId = Math.random().toString(36).substr(2, 5);
		let blkName = `$blk_exit_${blockId}`;
		code += `    (block ${blkName} (result f64)\n`;

		for (let i = 0; i < node.body.length; i++) {
			let child = node.body[i];

			if (child.type === 'infix' && child.op === ':' && child.left && child.left.type === 'identifier') {
				let name = child.left.value.trim();
				let targetOffset = (newEnvMap[name] && newEnvMap[name].localName === envLocalName) ? newEnvMap[name].offset : -1;

				let rhsCode = compileNode(child.right, newEnvMap);
				if (name && child.right && child.right._layout && newEnvMap[name]) {
					newEnvMap[name].layout = child.right._layout;
				} else if (name) {
				}

				code += rhsCode;

				if (targetOffset >= 0) {
					code += `    local.set $tmp_R\n`;
					code += `    local.get ${envLocalName}\n`;
					code += `    local.get $tmp_R\n`;
					code += `    f64.store offset=${targetOffset}\n`;
					code += `    f64.const nan\n`;
				}
			} else {
				code += compileNode(child, newEnvMap);
				// 子ノードがレイアウトを持つ（つまり辞書を返す式である）場合、ブロック全体の返り値のレイアウトとして採用する
				if (child._layout && !node._layout) {
					node._layout = child._layout;
				}
			}

			if (i < node.body.length - 1) {
				code += `    local.tee $tmp_bool\n`; // Leave f64 on stack for br_if
				code += `    local.get $tmp_bool\n`; // Push f64 for is_truthy arguments
				code += `    call $is_truthy\n`; // Pops one f64, returns i32
				code += `    br_if ${blkName}\n`;
				code += `    drop\n`; // discard Falsy value before compiling next node
			}
		}

		code += `    )\n`; // end of (block $blk_exit...)

		if (isEnvBlock) {
			if (isDictReturn) {
				// Return Dictionary / Environment Pointer tagged as 0x7FFB
				code += `    drop\n`;
				code += `    i64.const 0x7FFB000000000000\n`;
				code += `    local.get ${envLocalName}\n`;
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
		if (!valStr.includes('.')) valStr += '.0';
		return `    f64.const ${valStr}\n`;
	}

	if (node.type === 'identifier') {
		const name = node.value.trim();
		if (TEMPLATES[name]) {
			// ネイティブ演算子が単体で評価された場合（引数0個での出現）
			// 単純なNaNを返すのではなく、必要な引数分のダミーを受け取るクロージャを生成して返す
			let expectedArgs = ['!', '!!', '@'].includes(name) ? 1 : 2;
			let dummyParamNames = [];
			for (let i = 0; i < expectedArgs; i++) {
				dummyParamNames.push(`$curried_${i}`);
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
				return `    local.get $env\n    i32.trunc_sat_f64_u\n    f64.load offset=${loc.offset}\n`;
			} else if (loc.type === 'local_env') {
				return `    local.get ${loc.localName}\n    f64.load offset=${loc.offset}\n`;
			}
		}
		return `    ;; IGNORED: identifier (${name})\n    f64.const nan\n`;
	}

	if (node.type === 'string') {
		let content = node.value.slice(1, -1);
		if (content.startsWith('\`') && content.endsWith('\`')) {
			content = content.slice(1, -1);
		}

		if (stringTable[content] === undefined) {
			stringTable[content] = stringAllocOffset;
			let watStr = encodeWatString(content);
			dataSection += `  (data (i32.const ${stringAllocOffset}) "${watStr}")\n`;

			// Compute byte length to bump allocator
			let byteLen = unescape(encodeURIComponent(content)).length + 1;
			stringAllocOffset += byteLen;
			stringAllocOffset = (stringAllocOffset + 7) & ~7; // 8-byte align
		}

		let offset = stringTable[content];
		// NaN-box the pointer into String Tag: 0x7FFD000000000000 | offset
		return `    i64.const 0x7FFD000000000000\n    i64.const ${offset}\n    i64.or\n    f64.reinterpret_i64\n`;
	}

	if (node.type === 'infix') {
		const op = node.op;

		if (op === '#') {
			let code = compileNode(node.left, envMap);
			code += compileNode(node.right, envMap);
			code += `    local.set $tmp_R\n`;
			code += `    local.set $tmp_L\n`;

			// MMIO アドレスデコーダ (アドレス 1.0 = stdout)
			code += `    local.get $tmp_L\n`;
			code += `    f64.const 1.0\n`;
			code += `    f64.eq\n`;
			code += `    if\n`;
			code += `      local.get $tmp_R\n`;
			code += `      call $print_float\n`;
			code += `    else\n`;
			code += `      local.get $tmp_L\n`;
			code += `      i32.trunc_sat_f64_u\n`;
			code += `      i32.const 3\n`;
			code += `      i32.shl\n`;
			code += `      local.get $tmp_R\n`;
			code += `      f64.store\n`;
			code += `    end\n`;

			code += `    f64.const nan\n`; // 副作用式はUnitを返す
			return code;
		}

		if (op === ':') {
			if (node.left && node.left.type === 'identifier') {
				// Standalone `:` without `?` usually means assignment/binding in Sign
				// We handle this via expandMacros normally, but if it reaches here:
				return `    ;; UNIMPLEMENTED: Standalone binding (:)\n    f64.const nan\n`;
			} else {
				// Condition : TrueBranch
				let code = compileNode(node.left, envMap);
				code += `    call $is_truthy\n`;
				code += `    if (result f64)\n`;
				code += compileNode(node.right, envMap);
				code += `    else\n`;
				code += `      f64.const nan\n`;
				code += `    end\n`;

				if (node.right && node.right._layout) {
					node._layout = node.right._layout;
				}

				return code;
			}
		}

		if (op === '?') {
			// Find free variables
			const paramName = (node.left && node.left.type === 'identifier') ? node.left.value.trim() : '';
			const freeVars = Array.from(getFreeVariables(node.right, new Set([paramName])));

			const funcIndex = closureCount++;
			const lambdaName = `$lambda_${funcIndex}`;

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

			let funcCode = `  (func ${lambdaName} (param $env f64) (param $arg f64) (result f64)\n`;
			funcCode += `    (local $tmp_bool f64)\n    (local $tmp_L f64)\n    (local $tmp_R f64)\n    (local $tmp_ptr i32)\n`;
			for (let i = 0; i <= maxEnvDepth; i++) funcCode += `    (local $env_blk_${i} i32)\n`;
			funcCode += funcBody;
			funcCode += `  )\n`;
			closureFunctions.push({ name: lambdaName, code: funcCode, index: funcIndex });

			currentEnvDepth = savedDepth;
			maxEnvDepth = savedMax;

			// 2. Emit code to create the closure object at runtime
			let code = ``;

			// Alloc Environment
			if (freeVars.length > 0) {
				code += `    i32.const ${freeVars.length * 8}\n`;
				code += `    call $alloc\n`;
				code += `    local.set $tmp_ptr\n`;
				freeVars.forEach((v, i) => {
					code += `    local.get $tmp_ptr\n`;
					if (envMap[v]) {
						if (envMap[v].type === 'arg') {
							code += `    local.get $arg\n`;
						} else if (envMap[v].type === 'env') {
							code += `    local.get $env\n    i32.trunc_sat_f64_u\n    f64.load offset=${envMap[v].offset}\n`;
						} else if (envMap[v].type === 'local_env') {
							code += `    local.get ${envMap[v].localName}\n    f64.load offset=${envMap[v].offset}\n`;
						} else {
							code += `    f64.const nan\n`;
						}
					} else {
						code += `    f64.const nan\n`;
					}
					code += `    f64.store offset=${i * 8}\n`;
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
			code += `    f64.const ${funcIndex}\n`;
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
				code += `    f64.load offset=${offset}\n`;
				return code;
			} else {
				// 動的メモリ参照（リスト要素などのアクセス）: list ' index
				let code = compileNode(node.left, envMap);
				code += `    local.set $tmp_L\n`; // base pointer
				code += compileNode(node.right, envMap);
				code += `    local.set $tmp_R\n`; // index offset

				// NaNガード (NaN == NaN は false になるWASMの性質を利用)
				code += `    local.get $tmp_R\n`;
				code += `    local.get $tmp_R\n`;
				code += `    f64.eq\n`;
				code += `    if (result f64)\n`;

				code += `      local.get $tmp_L\n`;
				code += `      i64.reinterpret_f64\n`;
				code += `      i32.wrap_i64\n`;
				code += `      local.get $tmp_R\n`;
				code += `      i32.trunc_sat_f64_u\n`;
				code += `      i32.const 3\n`;
				code += `      i32.shl\n`;
				code += `      i32.add\n`;
				code += `      f64.load\n`;

				code += `    else\n`;
				code += `      f64.const nan\n`; // indexがNaNならNaNを返す
				code += `    end\n`;
				return code;
			}
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
			code += `    if (result f64)\n`;

			code += `      local.get $tmp_L\n`;
			code += `      i64.reinterpret_f64\n`;
			code += `      i32.wrap_i64\n`;
			code += `      local.get $tmp_R\n`;
			code += `      i32.trunc_sat_f64_u\n`;
			code += `      i32.const 3\n`;
			code += `      i32.shl\n`;
			code += `      i32.add\n`;
			code += `      f64.load\n`;

			code += `    else\n`;
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
			code += `    if (result f64)\n`;

			if (['number', 'string'].includes(node.left.type)) {
				code += `      local.get $tmp_R\n`;
			} else {
				code += `      local.get $tmp_L\n`;
			}

			code += `    else\n`;
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
			code += `    ${TEMPLATES[op]}\n`;

			// Convert i32 Wasm boolean to the actual value
			code += `    if (result f64)\n`;

			if (['number', 'string'].includes(node.left.type)) {
				code += `      local.get $tmp_R\n`;
			} else {
				code += `      local.get $tmp_L\n`;
			}

			code += `    else\n`;
			code += `      f64.const nan\n`;
			code += `    end\n`;
			return code;
		}

		// --- LOGICAL OPERATORS (Short-Circuit) ---
		if (op === '&') {
			let code = compileNode(node.left, envMap);
			code += `    local.set $tmp_bool\n`;
			code += `    local.get $tmp_bool\n`;
			code += `    call $is_truthy\n`;
			code += `    if (result f64)\n`;
			code += compileNode(node.right, envMap);
			code += `    else\n`;
			code += `      local.get $tmp_bool\n`; // Return Falsy (NaN)
			code += `    end\n`;
			return code;
		}

		if (op === '|') {
			let code = compileNode(node.left, envMap);
			code += `    local.set $tmp_bool\n`;
			code += `    local.get $tmp_bool\n`;
			code += `    call $is_truthy\n`;
			code += `    if (result f64)\n`;
			code += `      local.get $tmp_bool\n`; // Return Truthy
			code += `    else\n`;
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
			code += `    call $is_truthy\n`;
			code += `    if (result f64)\n`;

			// L is Truthy
			code += `      local.get $tmp_R\n`;
			code += `      call $is_truthy\n`;
			code += `      if (result f64)\n`;
			code += `        f64.const nan\n`; // Both Truthy -> NaN
			code += `      else\n`;
			code += `        local.get $tmp_L\n`; // L is alone Truthy
			code += `      end\n`;

			code += `    else\n`;

			// L is Falsy
			code += `      local.get $tmp_R\n`;
			code += `      call $is_truthy\n`;
			code += `      if (result f64)\n`;
			code += `        local.get $tmp_R\n`; // R is alone Truthy
			code += `      else\n`;
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
			code += `    ${wasmOp}\n`;

			// i32 to f64 back
			code += `    f64.convert_i32_s\n`;
			return code;
		}

		const isMissingLeft = !node.left;
		const isMissingRight = !node.right;

		if (isMissingLeft || isMissingRight) {
			const uuid = Math.random().toString(36).substr(2, 5);
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
			code += `    ${TEMPLATES[op]}\n`;
			return code;
		}
		return `    ;; UNIMPLEMENTED: infix (${op})\n`;
	}

	if (node.type === 'prefix') {
		if (!node.expr) {
			const uuid = Math.random().toString(36).substr(2, 5);
			const L = `0_curry_L_` + uuid;
			const lambdaAst = {
				type: 'infix', op: '?',
				left: { type: 'identifier', value: L },
				right: { type: 'prefix', op: node.op, expr: { type: 'identifier', value: L } }
			};
			return compileNode(lambdaAst, envMap);
		}

		if (node.op === '@') {
			let code = compileNode(node.expr, envMap);
			code += `    local.set $tmp_L\n`;

			// MMIO アドレスデコーダ (アドレス 0.0 = stdin)
			code += `    local.get $tmp_L\n`;
			code += `    f64.const 0.0\n`;
			code += `    f64.eq\n`;
			code += `    if (result f64)\n`;
			code += `      call $input_float\n`;
			code += `    else\n`;
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
			code += `    if (result f64)\n`;
			code += `      f64.const nan\n`;
			code += `    else\n`;
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
		let code = compileNode(node.expr, envMap);
		if (TEMPLATES[node.op]) {
			code += `    ${TEMPLATES[node.op]}\n`;
			return code;
		}

		// TEMPLATESに存在しない不正な前置演算子 (パーサが誤認した ':' や '?' など) の場合はパススルーを防ぐ
		return code + `    drop\n    ;; INVALID PREFIX OP (${node.op})\n    f64.const nan\n`;
	}

	if (node.type === 'native_op') {
		let code = '';
		for (let i = node.args.length - 1; i >= 0; i--) {
			code += compileNode(node.args[i], envMap);
		}
		code += `    ${TEMPLATES[node.value]}\n`; // カリー化内で引数が積まれた後に直接呼ばれる前提
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
				let uuid = Math.random().toString(36).substr(2, 5);

				// 引数がある場合、再評価を防ぐために一旦ブロック（Environment）に退避して eager-eval を行う
				let blockBody = [];
				let collectedArgs = [];

				for (let i = 0; i < info.args.length; i++) {
					let capName = `0_cap_${i}_${uuid}`;
					blockBody.push({ type: 'infix', op: ':', left: { type: 'identifier', value: capName }, right: info.args[i] });
					collectedArgs.push({ type: 'identifier', value: capName });
				}

				let dummyParamNames = [];
				for (let i = 0; i < missingCount; i++) {
					let curryName = `0_curry_${i}_${uuid}`;
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
				code += `    ${TEMPLATES[info.op]}\n`;
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

			// パイプライン適用の際、func側が「未評価の関数（unitで包まれたブロックなど）」のままになるのを防ぐ
			// スタックには arg(値) -> func(関数) が積まれている
			// この状態で closureを呼ぶ
			code += `    call $apply_closure\n`;
			return code;
		}

		code += funcNodeCode;
		code += argNodeCode;
		code += `    call $apply_closure_reversed\n`;
		return code;
	}

	return `    ;; IGNORED: ${node.type}\n    f64.const nan\n`;
}

export function expandMacrosPublic(ast) { return expandMacros(ast, {}); }
export function compileToWat(ast) {
	stringTable = {};
	stringAllocOffset = 1024;
	dataSection = '';
	closureFunctions = [];
	closureCount = 0;

	const expandedAst = expandMacros(ast, {});
	currentEnvDepth = 0;
	maxEnvDepth = -1;
	const bodyCode = compileNode(expandedAst, {});

	let closureCode = '';
	let elemSection = '';

	if (closureFunctions.length > 0) {
		closureFunctions.sort((a, b) => a.index - b.index);
	}
	let tableSize = closureFunctions.length > 0 ? closureFunctions.length : 1;
	elemSection = `  (table ${tableSize} funcref)\n`;
	if (closureFunctions.length > 0) {
		elemSection += `  (elem (i32.const 0)`;
		closureFunctions.forEach(f => {
			elemSection += ` ${f.name}`;
			closureCode += f.code + '\n';
		});
		elemSection += `)\n`;
	}
	elemSection += `  (type $closure_sig (func (param f64 f64) (result f64)))\n`;

	return `(module
  (import "env" "print_string" (func $print_string (param i32 i32)))
  (import "env" "print_float" (func $print_float (param f64)))
  (import "env" "input_float" (func $input_float (result f64)))
  (import "env" "math_fmod" (func $math_fmod (param f64 f64) (result f64)))
  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))

  (memory (export "memory") 1)
${elemSection}
  (global $heap_alloc_ptr (mut i32) (i32.const ${stringAllocOffset}))
${dataSection}
  (func $alloc (param $size i32) (result i32)
    (local $ptr i32)
    global.get $heap_alloc_ptr
    local.set $ptr

    global.get $heap_alloc_ptr
    local.get $size
    i32.add
    global.set $heap_alloc_ptr

    local.get $ptr
  )

  (func $strlen (param $ptr i32) (result i32)
    (local $len i32)
    (local $current i32)
    local.get $ptr
    local.set $current
    i32.const 0
    local.set $len

    (loop $count_loop
      local.get $current
      i32.load8_u
      i32.const 0
      i32.eq
      (if
        (then
          local.get $len
          return
        )
      )
      
      local.get $len
      i32.const 1
      i32.add
      local.set $len
      
      local.get $current
      i32.const 1
      i32.add
      local.set $current
      
      br $count_loop
    )
    
    local.get $len
  )

  (func $cons (param $car f64) (param $cdr f64) (result f64)
    (local $ptr i32)
    i32.const 16
    call $alloc
    local.tee $ptr
    
    local.get $car
    f64.store offset=0
    
    local.get $ptr
    local.get $cdr
    f64.store offset=8
    
    ;; リストのポインタを NaN-boxing する (Tag: 0x7FFC000000000000)
    i64.const 0x7FFC000000000000
    local.get $ptr
    i64.extend_i32_u
    i64.or
    f64.reinterpret_i64
  )

  (func $is_truthy (param $val f64) (result i32)
    local.get $val
    i64.reinterpret_f64
    i64.const 0x7FF8000000000000
    i64.ne
  )

  (func $apply_closure (param $arg_val f64) (param $func_val f64) (result f64)
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
    call_indirect (type $closure_sig)
  )

  (func $apply_closure_reversed (param $func_val f64) (param $arg_val f64) (result f64)
    local.get $arg_val
    local.get $func_val
    call $apply_closure
  )

  (func $spread_concat (param $left f64) (param $right f64) (result f64)
    ;; Dictionary / List / String concatenation fallback helper (Unimplemented logic placeholder)
    f64.const nan
  )

${closureCode}
  (func $main (export "main") (result f64)
    (local $tmp_bool f64)
    (local $tmp_L f64)
    (local $tmp_R f64)
    (local $tmp_ptr i32)
${Array.from({ length: maxEnvDepth + 1 }, (_, i) => `    (local $env_blk_${i} i32)\n`).join('')}
${bodyCode ? bodyCode : '    f64.const 0.0\n'}  )
)`;
}