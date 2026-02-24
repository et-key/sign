// compiler_wat.js

// --- WASM Instruction Templates ---
const TEMPLATES = {
	'+': 'i64.add',
	'-': 'i64.sub',
	'*': 'i64.mul',
	'/': 'i64.div_s',
	'%': 'i64.rem_s',
};

function compileNode(node) {
	if (!node) return `    i64.const 0 ;; Unit\n`;

	// 1. Block
	if (node.type === 'block') {
		let code = '';
		for (let i = 0; i < node.body.length; i++) {
			code += compileNode(node.body[i]);
			// 最後の文以外はスタックの値を捨てる
			if (i < node.body.length - 1) {
				code += `    drop\n`;
			}
		}
		return code;
	}

	// 2. Number Literal (全てi64として扱う)
	if (node.type === 'number') {
		return `    i64.const ${Math.floor(node.value)}\n`;
	}

	// 3. Infix Operators
	if (node.type === 'infix') {
		const op = node.op;

		// Print出力機能 (例: 1 # expr)
		if (op === '#' && node.left && node.left.value === 1) {
			let code = compileNode(node.right);
			code += `    call $print_int\n`;
			code += `    i64.const 0 ;; Print returns Unit\n`;
			return code;
		}

		// 四則演算
		if (TEMPLATES[op]) {
			let code = compileNode(node.left);
			code += compileNode(node.right);
			code += `    ${TEMPLATES[op]}\n`;
			return code;
		}
	}

	// 未実装ノード
	return `    ;; UNIMPLEMENTED: ${node.type}\n    i64.const 0\n`;
}

// エントリポイント
export function compileToWat(ast) {
	const bodyCode = compileNode(ast);

	return `(module
  ;; JS側から print_int をインポート
  (import "env" "print_int" (func $print_int (param i64)))

  ;; main関数
  (func $main (export "main") (result i64)
${bodyCode}
  )
)`;
}
