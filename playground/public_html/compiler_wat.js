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
	if (node.type === 'identifier' && TEMPLATES[node.value]) return true;
	if (node.type === 'compose') return true;
	if (node.type === 'apply' && node.func && node.func.type === 'identifier' && TEMPLATES[node.func.value]) return true;
	return false;
}

function expandMacros(node, env = {}) {
	if (!node) return node;

	if (node.type === 'block') {
		const newBody = [];
		for (const child of node.body) {
			if (child.type === 'infix' && child.op === ':') {
				let name = '';
				if (child.left && child.left.type === 'identifier') {
					name = child.left.value.trim();
				} else if (child.left && child.left.type === 'block' && child.left.body.length > 0) {
					name = child.left.body[0].value.trim();
				}
				if (name) {
					env[name] = expandMacros(child.right, env);
				}
			} else {
				newBody.push(expandMacros(child, env));
			}
		}
		return { type: 'block', body: newBody };
	}

	// ★ 矛盾の解消：ボトムアップ（スタック）ではなく、トップダウンで一気にフラットなキューを作る
	if (node.type === 'apply' || (node.type === 'infix' && (node.op === ' ' || node.op === ''))) {

		// 1. ASTをキューに展開する
		function flatten(n) {
			if (!n) return [];
			if (n.type === 'apply') {
				// applyが演算子の部分適用（[+ 4] のような部分）である場合、
				// それ以上ばらさずに1つの関数（クロージャ相当）として扱う。
				// そうしないと [+ 4] [* 3] などのチェインが全部バラバラになってしまう。
				if (n.func && n.func.type === 'identifier' && TEMPLATES[n.func.value]) {
					return [n];
				}
				// 通常の関数適用（チェイン）の場合はフラットに展開する
				return [...flatten(n.func), ...flatten(n.arg)];
			}
			if (n.type === 'infix' && (n.op === ' ' || n.op === '')) {
				return [...flatten(n.left), ...flatten(n.right)];
			}
			return [n];
		}

		const rawQueue = flatten(node);

		// もし展開結果が元のノード自身１つだけなら、それ以上パイプライン処理する必要なし（無限ループ防止）
		if (rawQueue.length === 1 && rawQueue[0] === node) {
			// ただし、ブロックや中身にマクロが含まれる場合は展開しておく
			if (node.type === 'apply') {
				return { ...node, func: expandMacros(node.func, env), arg: expandMacros(node.arg, env) };
			}
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

// WASMスタック命令の生成
function compileNode(node) {
	if (!node) return '';

	if (node.type === 'block') {
		if (!node.body || node.body.length === 0) return `    f64.const nan\n`;
		let code = '';
		for (let i = 0; i < node.body.length - 1; i++) {
			code += compileNode(node.body[i]);
			code += `    local.set $tmp_bool\n`;
			code += `    local.get $tmp_bool\n`;
			code += `    call $is_truthy\n`;
			code += `    if (result f64)\n`;
			code += `      local.get $tmp_bool\n`;
			code += `    else\n`;
		}
		code += compileNode(node.body[node.body.length - 1]);
		for (let i = 0; i < node.body.length - 1; i++) {
			code += `    end\n`;
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
			return `    ${TEMPLATES[name]}\n`;
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
			let code = compileNode(node.right);
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
				let code = compileNode(node.left);
				code += `    call $is_truthy\n`;
				code += `    if (result f64)\n`;
				code += compileNode(node.right);
				code += `    else\n`;
				code += `      f64.const nan\n`;
				code += `    end\n`;
				return code;
			}
		}

		if (op === '?') {
			let code = `    ;; UNIMPLEMENTED: lambda (?)\n`;
			code += `    f64.const nan\n`;
			return code;
		}

		if (['==', '!='].includes(op)) {
			let code = compileNode(node.left);
			code += `    local.set $tmp_L\n`;
			code += compileNode(node.right);
			code += `    local.set $tmp_R\n`;

			code += `    local.get $tmp_L\n`;
			code += `    i64.reinterpret_f64\n`;
			code += `    local.get $tmp_R\n`;
			code += `    i64.reinterpret_f64\n`;

			if (op === '==') {
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
			let code = compileNode(node.left);
			code += `    local.set $tmp_L\n`;
			code += compileNode(node.right);
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
			let code = compileNode(node.left);
			code += `    local.set $tmp_bool\n`;
			code += `    local.get $tmp_bool\n`;
			code += `    call $is_truthy\n`;
			code += `    if (result f64)\n`;
			code += compileNode(node.right);
			code += `    else\n`;
			code += `      local.get $tmp_bool\n`; // Return Falsy (NaN)
			code += `    end\n`;
			return code;
		}

		if (op === '|') {
			let code = compileNode(node.left);
			code += `    local.set $tmp_bool\n`;
			code += `    local.get $tmp_bool\n`;
			code += `    call $is_truthy\n`;
			code += `    if (result f64)\n`;
			code += `      local.get $tmp_bool\n`; // Return Truthy
			code += `    else\n`;
			code += compileNode(node.right);
			code += `    end\n`;
			return code;
		}

		if (op === ';') {
			// Logical XOR: Only one truthy. 
			// If both truthy -> NaN
			// If none truthy -> NaN
			// If one truthy -> return it.
			let code = compileNode(node.left);
			code += `    local.set $tmp_L\n`;
			code += compileNode(node.right);
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

			let code = compileNode(node.left);
			// f64 to i32
			code += `    i32.trunc_sat_f64_s\n`;

			code += compileNode(node.right);
			// f64 to i32
			code += `    i32.trunc_sat_f64_s\n`;

			// Bitwise op
			code += `    ${wasmOp}\n`;

			// i32 to f64 back
			code += `    f64.convert_i32_s\n`;
			return code;
		}





		let code = '';
		if (node.left) code += compileNode(node.left);
		if (node.right) code += compileNode(node.right);
		if (TEMPLATES[op]) {
			code += `    ${TEMPLATES[op]}\n`;
			return code;
		}
		return `    ;; UNIMPLEMENTED: infix (${op})\n`;
	}

	if (node.type === 'prefix') {
		if (node.op === '@') {
			let code = '';
			if (node.expr) code += compileNode(node.expr);
			code += `    drop\n`;
			code += `    call $input_float\n`;
			return code;
		}
		if (node.op === '!') {
			let code = '';
			if (node.expr) code += compileNode(node.expr);
			code += `    call $is_truthy\n`;
			code += `    if (result f64)\n`;
			code += `      f64.const nan\n`;
			code += `    else\n`;
			code += `      f64.const 1.0\n`;
			code += `    end\n`;
			return code;
		}

		if (node.op === '!!') {
			let code = '';
			if (node.expr) code += compileNode(node.expr);
			code += `    i32.trunc_sat_f64_s\n`;
			code += `    i32.const -1\n`;
			code += `    i32.xor\n`;
			code += `    f64.convert_i32_s\n`;
			return code;
		}

		let code = '';
		if (node.expr) code += compileNode(node.expr);
		if (TEMPLATES[node.op]) {
			code += `    ${TEMPLATES[node.op]}\n`;
		}
		return code;
	}

	if (node.type === 'apply') {
		const isNative = (fnNode) => {
			if (!fnNode) return false;
			if (fnNode.type === 'identifier' && TEMPLATES[fnNode.value]) return true;
			if (fnNode.type === 'apply') return isNative(fnNode.func);
			return false;
		};

		let code = '';

		// 関数が中置演算等を含んだブロックの場合（例: [+ 4]）の特殊展開
		// ※ [2, +, 4] のようにスタックに積む順序を調整する必要がある
		if (node.pipeline) {
			// val |> func の順の場合、WASMのスタックにおいては
			// 1. まず値を積む: code(node.arg)
			// 2. 次に関数の中身を展開するが、関数の持っている内部引数より「手前」に積まれている扱いなので、
			//    WASMの順序上は自然と結合する。
			// ただし、単純な func と arg の呼び出し順序を制御する
			code += compileNode(node.arg);

			// もし func 側がさらに apply（[+ 4] のような部分適用）なら、
			// すでにスタックの一番下に第一引数がある状態なので、
			// 追加の引数だけを積み、最後に関数を呼ぶ
			if (node.func && node.func.type === 'apply') {
				code += compileNode(node.func.arg);
				code += compileNode(node.func.func);
			} else {
				code += compileNode(node.func);
				if (!isNative(node.func)) {
					code += `    drop\n`; // drop func
					code += `    drop\n`; // drop arg
					code += `    f64.const nan\n`;
				}
			}
			return code;
		}

		// 通常の apply（func arg）
		if (isNative(node.func)) {
			if (node.arg) code += compileNode(node.arg);
			if (node.func) code += compileNode(node.func);
			return code;
		} else {
			if (node.arg) {
				code += compileNode(node.arg);
				code += `    drop\n`;
			}
			if (node.func) {
				code += compileNode(node.func);
				code += `    drop\n`;
			}
			code += `    f64.const nan\n`;
			return code;
		}
	}

	if (node.type === 'compose') {
		let code = '';
		if (node.first) code += compileNode(node.first);
		if (node.second) code += compileNode(node.second);
		return code;
	}

	return `    ;; IGNORED: ${node.type}\n    f64.const nan\n`;
}

export function compileToWat(ast) {
	stringTable = {};
	stringAllocOffset = 8;
	dataSection = '';

	const expandedAst = expandMacros(ast, {});
	const bodyCode = compileNode(expandedAst);

	return `(module
  (import "env" "print_string" (func $print_string (param i32 i32)))
  (import "env" "print_float" (func $print_float (param f64)))
  (import "env" "input_float" (func $input_float (result f64)))
  (import "env" "math_fmod" (func $math_fmod (param f64 f64) (result f64)))
  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))

  (memory (export "memory") 1)
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

  (func $main (export "main") (result f64)
    (local $tmp_bool f64)
    (local $tmp_L f64)
    (local $tmp_R f64)
    (local $tmp_ptr i32)
${bodyCode ? bodyCode : '    f64.const 0.0\\n'}  )
)`;
}