// compiler_wat.js

// --- WASM Instruction Templates (f64) ---
const TEMPLATES = {
	'+': 'f64.add',
	'-': 'f64.sub',
	'*': 'f64.mul',
	'/': 'f64.div',
	// % と ^ はWASMネイティブにないため、関数呼び出しに変換します
};

export function compileNode(node) {
	if (!node) return `    f64.const 0.0 ;; Unit\n`;

	// 1. Block
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

	// 2. Number Literal (すべてf64)
	if (node.type === 'number') {
		// WATフォーマットでは小数点がないとパースエラーになることがあるため付与
		let valStr = node.value.toString();
		if (!valStr.includes('.')) valStr += '.0';
		return `    f64.const ${valStr}\n`;
	}

	// 3. Prefix Operators (前置演算子)
	if (node.type === 'prefix') {
		// 📥 入力機能 (@ expr)
		if (node.op === '@') {
			// 対象となるアドレス/ポート評価（今回はダミーとして捨てます）
			let code = compileNode(node.expr);
			code += `    drop\n`;
			code += `    call $input_float\n`;
			return code;
		}
	}

	// 4. Infix Operators (中置演算子)
	if (node.type === 'infix') {
		const op = node.op;

		// 📤 出力機能 (1 # expr)
		if (op === '#' && node.left && node.left.value === 1) {
			let code = compileNode(node.right);
			code += `    call $print_float\n`;
			code += `    f64.const 0.0 ;; Print returns Unit\n`;
			return code;
		}

		let code = compileNode(node.left);
		code += compileNode(node.right);

		// 四則演算
		if (TEMPLATES[op]) {
			code += `    ${TEMPLATES[op]}\n`;
			return code;
		} else if (op === '%') {
			code += `    call $math_fmod\n`; // JSからインポートした剰余
			return code;
		} else if (op === '^') {
			code += `    call $math_pow\n`;  // JSからインポートしたべき乗
			return code;
		}
	}

	return `    ;; UNIMPLEMENTED: ${node.type}\n    f64.const 0.0\n`;
}

// エントリポイント
export function compileToWat(ast) {
	const bodyCode = compileNode(ast);

	return `(module
  ;; ホスト(JS)環境から関数をインポート
  (import "env" "print_float" (func $print_float (param f64)))
  (import "env" "input_float" (func $input_float (result f64)))
  (import "env" "math_fmod" (func $math_fmod (param f64 f64) (result f64)))
  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))

  ;; main関数
  (func $main (export "main") (result f64)
${bodyCode}
  )
)`;
}