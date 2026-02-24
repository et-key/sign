// compiler_wat.js

// --- WASM Instruction Templates (f64) ---
const TEMPLATES = {
	'+': 'f64.add',
	'-': 'f64.sub',
	'*': 'f64.mul',
	'/': 'f64.div',
};

// ★ 新規追加：構文解析後のASTを走査し `:` をマクロ展開する関数
function expandMacros(node, env = {}) {
	if (!node) return node;

	// 1. Block: 中にある `:` (定義) を走査して環境に登録
	if (node.type === 'block') {
		const newBody = [];
		for (const child of node.body) {
			// `:` による定義を発見
			if (child.type === 'infix' && child.op === ':') {
				const name = child.left.value; // 左辺の識別子
				const valueAst = expandMacros(child.right, env); // 右辺も展開

				// 環境(辞書)にASTを登録
				env[name] = valueAst;

				// 定義式自体はWASMの実行コードとしては不要なため Unit (0.0) を残す
				newBody.push({ type: 'number', value: 0.0 });
			} else {
				newBody.push(expandMacros(child, env));
			}
		}
		return { type: 'block', body: newBody };
	}

	// 2. 再帰的な走査
	if (node.type === 'infix') {
		return { ...node, left: expandMacros(node.left, env), right: expandMacros(node.right, env) };
	}
	if (node.type === 'prefix') {
		return { ...node, expr: expandMacros(node.expr, env) };
	}
	if (node.type === 'postfix') {
		return { ...node, expr: expandMacros(node.expr, env) };
	}
	if (node.type === 'apply') {
		return { ...node, func: expandMacros(node.func, env), arg: expandMacros(node.arg, env) };
	}

	// 3. ★ 核心：識別子が見つかったら [ 定義内容 ] に置換
	if (node.type === 'identifier') {
		const name = node.value;
		if (env[name]) {
			// ASTをディープコピーし、指示通り Block [ ] でラップして返す
			const clonedAst = JSON.parse(JSON.stringify(env[name]));
			return {
				type: 'block',
				body: [clonedAst]
			};
		}
	}

	return node;
}

// --- WASMコンパイラ本体 ---
function compileNode(node) {
	if (!node) return `    f64.const 0.0 ;; Unit\n`;

	if (node.type === 'block') {
		let code = '';
		for (let i = 0; i < node.body.length; i++) {
			code += compileNode(node.body[i]);
			if (i < node.body.length - 1) {
				code += `    drop\n`;
			}
		}
		return code;
	}

	if (node.type === 'number') {
		let valStr = node.value.toString();
		if (!valStr.includes('.')) valStr += '.0';
		return `    f64.const ${valStr}\n`;
	}

	if (node.type === 'prefix') {
		if (node.op === '@') {
			let code = compileNode(node.expr);
			code += `    drop\n`;
			code += `    call $input_float\n`;
			return code;
		}
	}

	if (node.type === 'infix') {
		const op = node.op;

		if (op === '#' && node.left && node.left.value === 1) {
			let code = compileNode(node.right);
			code += `    call $print_float\n`;
			code += `    f64.const 0.0 ;; Print returns Unit\n`;
			return code;
		}

		// `:` は expandMacros で Unit 化済みなので、そのまま子ノードを処理
		if (op === ':') {
			// 展開済みの残骸（Unit 0.0）を返す
			return compileNode(node.right);
		}

		let code = compileNode(node.left);
		code += compileNode(node.right);

		if (TEMPLATES[op]) {
			code += `    ${TEMPLATES[op]}\n`;
			return code;
		} else if (op === '%') {
			code += `    call $math_fmod\n`;
			return code;
		} else if (op === '^') {
			code += `    call $math_pow\n`;
			return code;
		}
	}

	// Applyなどの未実装ノード
	return `    ;; UNIMPLEMENTED: ${node.type}\n    f64.const 0.0\n`;
}

// エントリポイント
export function compileToWat(ast) {
	// ★ WASM生成の直前に、定数・関数をインライン展開(マクロ展開)する
	const expandedAst = expandMacros(ast, {});

	const bodyCode = compileNode(expandedAst);

	return `(module
  (import "env" "print_float" (func $print_float (param f64)))
  (import "env" "input_float" (func $input_float (result f64)))
  (import "env" "math_fmod" (func $math_fmod (param f64 f64) (result f64)))
  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))

  (func $main (export "main") (result f64)
${bodyCode}
  )
)`;
}