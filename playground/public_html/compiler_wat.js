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
	',': 'call $cons',
	'head': 'call $head',
	'tail': 'call $tail'
};

let stringTable = {};
let stringAllocOffset = 8;
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

function isFunction(node) {
	if (!node) return false;
	if (node.type === 'identifier') return true;
	if (node.type === 'compose') return true;
	if (node.type === 'apply') return true;
	if (node.type === 'infix' && node.op === '?') return true;
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
	const children = ['body', 'left', 'right', 'expr', 'func', 'arg', 'first', 'second'];
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
		const newBody = node.body.map(child => expandMacros(child, env));
		return { type: 'block', body: newBody };
	}

	// ★ 矛盾の解消：ボトムアップ（スタック）ではなく、トップダウンで一気にフラットなキューを作る
	if (node.type === 'infix' && (node.op === ' ' || node.op === '')) {

		// 1. ASTをキューに展開する
		function flatten(n) {
			if (!n) return [];
			if (n.type === 'infix' && (n.op === ' ' || n.op === '')) {
				return [...flatten(n.left), ...flatten(n.right)];
			}
			return [n];
		}

		const rawQueue = flatten(node);

		// もし展開結果が元のノード自身１つだけなら、それ以上パイプライン処理する必要なし（無限ループ防止）
		if (rawQueue.length === 1 && rawQueue[0] === node) {
			return node;
		}

		// 2. マクロ展開
		const queue = rawQueue.map(n => expandMacros(n, env));

		if (queue.length === 0) return null;
		if (queue.length === 1) return queue[0];

		// 3. 左結合での Apply 木の再構築
		// foo bar baz -> [foo, bar, baz]
		// 左から順に処理していく

		let acc = queue[0];

		for (let i = 1; i < queue.length; i++) {
			const current = queue[i];
			const accIsFunc = isFunction(acc);
			const currentIsFunc = isFunction(current);

			if (accIsFunc && currentIsFunc) {
				// Func, Func の場合は合成 (compose) しておく
				acc = { type: 'compose', first: acc, second: current };
			} else if (accIsFunc && !currentIsFunc) {
				// Func, Val: 関数に値を適用する
				// 引数の評価が先、関数の評価が後になるように apply を組む
				acc = { type: 'apply', func: acc, arg: current };
			} else if (!accIsFunc && currentIsFunc) {
				// Val, Func: 値（計算結果）を次の関数の引数にする (Pipeline / left-associative apply)
				// これがポイントフリーの "1 # foo bar" における "foo" に "1" を渡す動き。
				// current が `[+ 4]` (つまり apply(+, 4)) なら、
				// さらにその全体に対して acc を適用する形になる。

				// applyノードとして、左側の値を右側の関数に適用する
				// 実際にはWASMのスタックマシンの順序としては
				// [accを積む] -> [currentの引数を積む] -> [currentの関数を呼ぶ] となる
				acc = { type: 'apply', func: current, arg: acc, pipeline: true };
			} else {
				// Val, Val の場合は通常あり得ないが、もし来たら単純に並べる
				acc = { type: 'block', body: [acc, current] };
			}
		}

		return acc;
	}

	if (node.type === 'apply') {
		return { ...node, func: expandMacros(node.func, env), arg: expandMacros(node.arg, env) };
	}
	if (node.type === 'infix') {
		return { ...node, left: expandMacros(node.left, env), right: expandMacros(node.right, env) };
	}
	if (node.type === 'prefix' || node.type === 'postfix') {
		return { ...node, expr: expandMacros(node.expr, env) };
	}

	if (node.type === 'identifier') {
		const name = node.value.trim();
		if (env[name] !== undefined) {
			return JSON.parse(JSON.stringify(env[name])); // 深いコピー
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
				code += `    local.set $tmp_bool\n`;
				code += `    local.get $tmp_bool\n`;
				code += `    call $is_truthy\n`;
				code += `    if (result f64)\n`;
				code += `      local.get $tmp_bool\n`;
				code += `    else\n`;
			}
		}

		for (let i = 0; i < node.body.length - 1; i++) {
			code += `    end\n`;
		}

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
			return `    ;; UNBOUND NATIVE OP (${name})\n    f64.const nan\n`;
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
			let code = compileNode(node.right, envMap);
			code += `    local.set $tmp_L\n`;
			code += `    local.get $tmp_L\n`;

			// Check if it's a string (tag: 0x7FFD0000)
			code += `    i64.reinterpret_f64\n`;
			code += `    i64.const 32\n`;
			code += `    i64.shr_u\n`;
			code += `    i32.wrap_i64\n`;
			code += `    i32.const 0x7FFD0000\n`;
			code += `    i32.eq\n`;
			code += `    if\n`;

			// If String:
			code += `      local.get $tmp_L\n`;
			code += `      i64.reinterpret_f64\n`;
			code += `      i32.wrap_i64\n`; // Lower 32 bits = Pointer

			// Compute length (strlen equivalent)
			code += `      local.tee $tmp_ptr\n`;
			code += `      local.get $tmp_ptr\n`;
			code += `      call $strlen\n`; // Call helper function

			// Print string
			code += `      call $print_string\n`;

			code += `    else\n`;

			// If Float:
			code += `      local.get $tmp_L\n`;
			code += `      call $print_float\n`;

			code += `    end\n`;
			code += `    f64.const nan\n`;
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
				console.warn(`[Compile Warning] Static offset resolution failed for property '${keyName}'`);
				return `    ;; UNABLE TO RESOLVE STATIC OFFSET FOR GET\n    f64.const nan\n`;
			}
		}

		if (['==', '=', '!='].includes(op)) {
			let code = compileNode(node.left, envMap);
			code += `    local.set $tmp_L\n`;
			code += compileNode(node.right, envMap);
			code += `    local.set $tmp_R\n`;

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
			code += `    local.set $tmp_L\n`;
			code += compileNode(node.right, envMap);
			code += `    local.set $tmp_R\n`;

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
			code += `    local.set $tmp_L\n`;
			code += compileNode(node.right, envMap);
			code += `    local.set $tmp_R\n`;

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





		let code = compileNode(node.left, envMap);
		code += compileNode(node.right, envMap);
		if (TEMPLATES[op]) {
			code += `    ${TEMPLATES[op]}\n`;
			return code;
		}
		return `    ;; UNIMPLEMENTED: infix (${op})\n`;
	}

	if (node.type === 'prefix') {
		if (node.op === '@') {
			let code = compileNode(node.expr, envMap);
			code += `    drop\n`;
			code += `    call $input_float\n`;
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
		}
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
			if (fnNode.type === 'apply') return isNative(fnNode.func);
			return false;
		};

		if (isNative(node.func)) {
			const flattenNativeApply = (n) => {
				if (!n) return { args: [], op: null };
				if (n.type === 'identifier' && TEMPLATES[n.value]) return { args: [], op: n.value };
				if (n.type === 'apply') {
					let inner = flattenNativeApply(n.func);
					inner.args.push(n.arg);
					return inner;
				}
				return { args: [], op: null };
			};

			let info = flattenNativeApply(node);
			let code = '';
			let expectedArgs = ['head', 'tail', '!', '!!', '@'].includes(info.op) ? 1 : 2;

			for (let i = info.args.length; i < expectedArgs; i++) {
				code += `    f64.const nan\n`;
			}

			for (let i = info.args.length - 1; i >= 0; i--) {
				code += compileNode(info.args[i], envMap);
			}
			code += `    ${TEMPLATES[info.op]}\n`;
			return code;
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

		if (node.pipeline) {
			code += compileNode(node.arg, envMap);
			code += compileNode(node.func, envMap);
			code += `    call $apply_closure\n`;
			return code;
		}

		code += compileNode(node.func, envMap);
		code += compileNode(node.arg, envMap);
		code += `    call $apply_closure_reversed\n`;
		return code;
	}

	if (node.type === 'compose') {
		let code = compileNode(node.first, envMap);
		code += compileNode(node.second, envMap);
		return code;
	}

	return `    ;; IGNORED: ${node.type}\n    f64.const nan\n`;
}

export function expandMacrosPublic(ast) { return expandMacros(ast, {}); }
export function compileToWat(ast) {
	stringTable = {};
	stringAllocOffset = 8;
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
  (global $heap_alloc_ptr (mut i32) (i32.const 8))
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
    
    i64.const 0x7FFC000000000000
    local.get $ptr
    i64.extend_i32_u
    i64.or
    f64.reinterpret_i64
  )

  (func $head (param $list_val f64) (result f64)
    (local $ptr i32)
    
    local.get $list_val
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    i32.const 0x7FFC0000
    i32.ne
    if
      f64.const nan
      return
    end
    
    local.get $list_val
    i64.reinterpret_f64
    i32.wrap_i64
    local.set $ptr
    
    local.get $ptr
    f64.load offset=0
  )

  (func $tail (param $list_val f64) (result f64)
    (local $ptr i32)
    
    local.get $list_val
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    i32.const 0x7FFC0000
    i32.ne
    if
      f64.const nan
      return
    end
    
    local.get $list_val
    i64.reinterpret_f64
    i32.wrap_i64
    local.set $ptr
    
    local.get $ptr
    f64.load offset=8
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