// compiler_wat.js

const TEMPLATES = {
	'+': 'f64.add',
	'-': 'f64.sub',
	'*': 'f64.mul',
	'/': 'f64.div',
	'%': 'call $math_fmod',
	'^': 'call $math_pow'
};

// 1. 変数やラムダの「インライン展開」だけを行う（複雑なβ簡約は不要）
function expandMacros(node, env = {}) {
	if (!node) return node;

	if (node.type === 'block') {
		const newBody = [];
		for (const child of node.body) {
			// 定義 ( : ) を見つけたら環境に登録し、実行コードからは完全に消去する
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

	if (node.type === 'infix') {
		return { ...node, left: expandMacros(node.left, env), right: expandMacros(node.right, env) };
	}
	if (node.type === 'prefix') {
		return { ...node, expr: expandMacros(node.expr, env) };
	}
	if (node.type === 'apply') {
		return { ...node, func: expandMacros(node.func, env), arg: expandMacros(node.arg, env) };
	}

	// ★ 識別子が見つかったら、環境からディープコピーしてそのまま置換
	if (node.type === 'identifier') {
		const name = node.value.trim();
		if (env[name] !== undefined) {
			return JSON.parse(JSON.stringify(env[name]));
		}
	}

	return node;
}

// 2. WASMスタックマシンへのコンパイル
function compileNode(node) {
	if (!node) return '';

	if (node.type === 'block') {
		let code = '';
		for (let child of node.body) {
			code += compileNode(child);
			// ★重要: Signのデータフローを維持するため、むやみに drop しない
			// 積まれた値は、後続の関数や演算子が自然に消費します
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
		// 識別子が + や * などの演算子だった場合、WASM命令を直接発行する
		if (TEMPLATES[name]) {
			return `    ${TEMPLATES[name]}\n`;
		}
		return `    ;; UNIMPLEMENTED: identifier (${name})\n`;
	}

	if (node.type === 'infix') {
		const op = node.op;

		// Print (1 # expr)
		if (op === '#' && node.left && node.left.value === 1) {
			let code = compileNode(node.right);
			code += `    call $print_float\n`;
			return code;
		}

		// 空白演算子（関数適用）は「右(引数) → 左(関数)」の順でスタックに積む
		if (op === ' ' || op === '') {
			let code = '';
			if (node.right) code += compileNode(node.right);
			if (node.left) code += compileNode(node.left);
			return code;
		}

		// 通常の中置演算子
		let code = '';
		if (node.left) code += compileNode(node.left);
		if (node.right) code += compileNode(node.right);

		if (TEMPLATES[op]) {
			code += `    ${TEMPLATES[op]}\n`;
			return code;
		}
		return `    ;; UNIMPLEMENTED: infix (${op})\n`;
	}

	if (node.type === 'apply') {
		let code = '';
		// applyノードも「引数 → 関数」の順で評価
		if (node.arg) code += compileNode(node.arg);
		if (node.func) code += compileNode(node.func);
		return code;
	}

	if (node.type === 'prefix') {
		if (node.op === '@') {
			let code = '';
			if (node.expr) code += compileNode(node.expr);
			code += `    drop\n`;
			code += `    call $input_float\n`;
			return code;
		}

		// [+ 4] のような前置演算子の評価 (4 を積んでから + を実行)
		let code = '';
		if (node.expr) code += compileNode(node.expr);
		if (TEMPLATES[node.op]) {
			code += `    ${TEMPLATES[node.op]}\n`;
		} else {
			code += `    ;; UNIMPLEMENTED: prefix (${node.op})\n`;
		}
		return code;
	}

	return `    ;; UNIMPLEMENTED: ${node.type}\n`;
}

// エントリポイント
export function compileToWat(ast) {
	const expandedAst = expandMacros(ast, {});
	const bodyCode = compileNode(expandedAst);

	return `(module
  (import "env" "print_float" (func $print_float (param f64)))
  (import "env" "input_float" (func $input_float (result f64)))
  (import "env" "math_fmod" (func $math_fmod (param f64 f64) (result f64)))
  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))

  (func $main (export "main") (result f64)
${bodyCode}
    ;; WASMの関数の戻り値(f64)制約を満たすためのダミー値
    f64.const 0.0
  )
)`;
}