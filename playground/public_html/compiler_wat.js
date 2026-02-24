// compiler_wat.js

const TEMPLATES = {
	'+': 'f64.add',
	'-': 'f64.sub',
	'*': 'f64.mul',
	'/': 'f64.div',
	'%': 'call $math_fmod',
	'^': 'call $math_pow'
};

// ★ 核心：ASTの「左側の穴」を探して引数を注入するβ簡約アルゴリズム
function betaReduce(funcAst, argAst) {
	let applied = false;

	function inject(node) {
		if (!node || applied) return node;

		// 元のASTテンプレートを汚染しないようディープコピー
		const cloned = Array.isArray(node) ? [...node] : { ...node };

		// 1. 前置演算子 (例: + 4) を発見 -> 左側に穴がある！
		if (cloned.type === 'prefix' && ['+', '-', '*', '/', '%', '^'].includes(cloned.op)) {
			applied = true;
			return {
				type: 'infix',
				op: cloned.op,
				left: argAst,    // ★ 引数を穴に注入
				right: cloned.expr
			};
		}

		// 2. 左側が欠落している中置演算子を発見 -> 穴に注入
		if (cloned.type === 'infix' && !cloned.left) {
			applied = true;
			cloned.left = argAst;
			return cloned;
		}

		// 3. ブロックや関数の中へ深く潜り、パイプラインの最も上流（左側）の穴を探す
		if (cloned.type === 'block') {
			cloned.body = cloned.body.map(child => inject(child));
			return cloned;
		}

		if (cloned.type === 'infix') {
			if (cloned.left) cloned.left = inject(cloned.left);
			// 関数合成の場合、左が埋まっていれば右側も探す
			if (!applied && cloned.right) cloned.right = inject(cloned.right);
			return cloned;
		}

		if (cloned.type === 'apply') {
			if (cloned.func) cloned.func = inject(cloned.func);
			if (!applied && cloned.arg) cloned.arg = inject(cloned.arg);
			return cloned;
		}

		if (cloned.type === 'prefix') {
			if (cloned.expr) cloned.expr = inject(cloned.expr);
			return cloned;
		}

		return cloned;
	}

	const reduced = inject(funcAst);

	// 万が一穴が見つからなかった場合は、未適用の関数として並べる（WASMスタックに順に積む）
	if (!applied) {
		return { type: 'apply', func: funcAst, arg: argAst };
	}

	return reduced;
}

// 構文木を走査して定義の展開とβ簡約を行うマクロエンジン
function expandMacros(node, env = {}) {
	if (!node) return node;

	if (node.type === 'block') {
		const newBody = [];
		for (const child of node.body) {
			// 定義 ( : ) は環境に保存してASTから消去
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

	// ★ 関数合成・関数適用 (apply または 空白) を見つけたらβ簡約を実行
	if (node.type === 'apply' || (node.type === 'infix' && (node.op === ' ' || node.op === ''))) {
		// 左結合の順序に従って、左(func)と右(arg)をそれぞれ展開
		const funcAst = expandMacros(node.type === 'apply' ? node.func : node.left, env);
		const argAst = expandMacros(node.type === 'apply' ? node.arg : node.right, env);

		// β簡約（関数合成 または 引数注入）
		return betaReduce(funcAst, argAst);
	}

	if (node.type === 'infix') {
		return { ...node, left: expandMacros(node.left, env), right: expandMacros(node.right, env) };
	}
	if (node.type === 'prefix') {
		return { ...node, expr: expandMacros(node.expr, env) };
	}

	// 識別子を環境から展開
	if (node.type === 'identifier') {
		const name = node.value.trim();
		if (env[name] !== undefined) {
			return JSON.parse(JSON.stringify(env[name]));
		}
	}

	return node;
}

// WASMスタックマシンコードの生成
function compileNode(node) {
	if (!node) return '';

	if (node.type === 'block') {
		let code = '';
		for (let child of node.body) {
			code += compileNode(child);
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
		return `    ;; UNIMPLEMENTED: identifier (${name})\n`;
	}

	if (node.type === 'infix') {
		const op = node.op;

		// 1 # expr (Print)
		if (op === '#' && node.left && node.left.value === 1) {
			let code = compileNode(node.right);
			code += `    call $print_float\n`;
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

	if (node.type === 'apply') {
		let code = '';
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

		// 展開されずに残った単独の前置演算子の評価
		let code = '';
		if (node.expr) code += compileNode(node.expr);
		if (TEMPLATES[node.op]) {
			code += `    ${TEMPLATES[node.op]}\n`;
		}
		return code;
	}

	return `    ;; UNIMPLEMENTED: ${node.type}\n`;
}

// エントリポイント
export function compileToWat(ast) {
	// コンパイル前にマクロ展開とβ簡約(関数合成)をすべて完了させる
	const expandedAst = expandMacros(ast, {});
	const bodyCode = compileNode(expandedAst);

	return `(module
  (import "env" "print_float" (func $print_float (param f64)))
  (import "env" "input_float" (func $input_float (result f64)))
  (import "env" "math_fmod" (func $math_fmod (param f64 f64) (result f64)))
  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))

  (func $main (export "main") (result f64)
${bodyCode}
    f64.const 0.0
  )
)`;
}