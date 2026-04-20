// compiler_aarch64.js

export class AArch64Generator {
	constructor() {
		this.textSection = [];
		this.dataSection = [];

		// x1〜x7 を一時計算用（スクラッチ）レジスタとして使用する簡易アロケータ
		this.freeRegs = [1, 2, 3, 4, 5, 6, 7];
		this.unitReg = 28; // Unit専用グローバルレジスタ
	}

	// レジスタの確保
	allocReg() {
		if (this.freeRegs.length === 0) throw new Error("コンパイルエラー: レジスタが枯渇しました");
		return this.freeRegs.shift();
	}

	// レジスタの解放（使い終わったら空きリストに戻す）
	freeReg(regNum) {
		// x0 と x28(Unit) は解放しないように保護
		if (regNum !== 0 && regNum !== this.unitReg && !this.freeRegs.includes(regNum)) {
			this.freeRegs.unshift(regNum);
		}
	}

	generate(ast) {
		// ★追加: データセクションに Unit の物理実体を定義
		this.dataSection.push(".section .rodata");
		this.dataSection.push(".align 3");
		this.dataSection.push("Sign_Unit_Sentinel:");
		this.dataSection.push("    .quad 0x0000000000000000   // Unit (空リスト) の実体");

		this.textSection.push(".text"); // ★追加
		this.textSection.push(".global _start");
		this.textSection.push(".align 2");
		this.textSection.push("_start:");

		// プログラム起動時に Unit のポインタを x28 にロード
		this.textSection.push("    // --- Init Unit Sentinel (x28) ---");
		this.textSection.push("    ADRP x28, Sign_Unit_Sentinel");
		this.textSection.push("    ADD  x28, x28, :lo12:Sign_Unit_Sentinel");
		this.textSection.push("");

		// 最終結果がどのレジスタに入っているかを受け取る
		const resultReg = this.visit(ast);

		// 最終結果が x0 以外に入っていれば、システムコールのために x0 に移す
		if (resultReg !== undefined && resultReg !== 0) {
			this.textSection.push(`    MOV x0, x${resultReg}`);      // 最終結果を x0 にセット
		}

		// デバッグ用フック (最終結果が Unit なら終了コードを 255 にする)
		this.textSection.push("");
		this.textSection.push("    // --- Check if Result is Unit ---");
		this.textSection.push("    CMP x0, x28");
		this.textSection.push("    B.NE .L_exit_normal");
		this.textSection.push("    MOV x0, #255");               // Unitの場合は終了コード 255 (Debug)
		this.textSection.push(".L_exit_normal:");

		this.textSection.push("");
		this.textSection.push("    // --- Exit Syscall ---");
		this.textSection.push("    MOV x8, #93");
		this.textSection.push("    SVC #0");

		const dataOutput = this.dataSection.length > 0 ? this.dataSection.join("\n") + "\n\n" : "";
		const textOutput = this.textSection.join("\n") + "\n";
		return dataOutput + textOutput;
	}

	visit(node) {
		if (!node) return this.unitReg; // undefinedではなくUnitを返す

		// Blockなどは最後の文の結果を返す
		if (Array.isArray(node)) {
			let lastReg = this.unitReg; // ★修正
			for (let n of node) lastReg = this.visit(n);
			return lastReg;
		}

		// Unitノードの処理
		if (node.type === "Unit") {
			return this.unitReg;
		}

		if (node.type === "Block") { // `|| node.type === "Unit"` を上に分離
			let lastReg = this.unitReg;
			const body = node.body || [];
			for (let n of body) lastReg = this.visit(n);
			return lastReg;
		}

		switch (node.type) {
			case "AddressLiteral":
			case "IntegerLiteral":
				return this.visitLiteral(node);

			case "RegisterLiteral":
				return this.visitRegisterLiteral(node);

			case "FunctionCall":
			case "ListConstruct":
				return this.visitApplication(node);

			case "PointFreeCore":
				this.textSection.push(`    // TODO: Closures for PointFreeCore -> ${node.operator}`);
				return this.allocReg();

			case "BinaryExpression":
				return this.visitBinaryExpression(node);

			default:
				this.textSection.push(`    // TODO: Unhandled node -> ${node.type}`);
				return this.unitReg;
		}
	}

	// --- ノード別ハンドラ ---

	visitLiteral(node) {
		const val = node.type === "AddressLiteral" ? parseInt(node.value, 16) : parseInt(node.value, 10);
		const reg = this.allocReg(); // 空いているレジスタを1つもらう

		this.textSection.push(`    MOV x${reg}, #${val}`);
		return reg; // 「このレジスタに値を入れたよ」と親ノードに教える
	}

	visitRegisterLiteral(node) {
		const regNum = parseInt(node.value.substring(2), 16);
		this.textSection.push(`    // Fetch Sign Register 0r${regNum.toString(16)} (Mapped to x${regNum})`);

		// 物理レジスタ x(regNum) から 一時計算用レジスタに値をコピーして返す
		const destReg = this.allocReg();
		this.textSection.push(`    MOV x${destReg}, x${regNum}`);
		return destReg;
	}

	visitApplication(node) {
		// 構造: `10 + 20` -> left: 10, right: [+ 20] (PointFreeCore)
		// まず左辺（入力値）を評価してレジスタに入れる
		const leftReg = this.visit(node.left);

		// 右辺が PointFreeCore（演算子の部分適用）であれば、関数呼び出しではなく「インライン命令」に最適化する
		if (node.right && node.right.type === "PointFreeCore") {
			const op = node.right.operator;
			const rightValReg = this.visit(node.right.right); // `[+ 20]` の `20` の部分を評価

			const resultReg = this.allocReg(); // 計算結果を入れる新しいレジスタ

			switch (op) {
				case "+": this.textSection.push(`    ADD x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "-": this.textSection.push(`    SUB x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "*": this.textSection.push(`    MUL x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "/": this.textSection.push(`    SDIV x${resultReg}, x${leftReg}, x${rightValReg}`); break;

				// --- ビット演算 (変数名を rightReg から rightValReg に統一) ---
				case "<<": this.textSection.push(`    LSL x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case ">>": this.textSection.push(`    ASR x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "||": this.textSection.push(`    ORR x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case ";;": this.textSection.push(`    EOR x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "&&": this.textSection.push(`    AND x${resultReg}, x${leftReg}, x${rightValReg}`); break;

				// --- ★修正: 比較演算 (CSET -> CSEL による透過的フィルター) ---
				case "=":
				case "==":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, EQ  // == (PointFree)`);
					break;
				case "!=":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, NE  // != `);
					break;
				case "<":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, LT  // < `);
					break;
				case ">":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, GT  // > `);
					break;

				// --- 剰余演算 (%) ---
				case "%":
					const tempReg = this.allocReg();
					this.textSection.push(`    SDIV x${tempReg}, x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    MSUB x${resultReg}, x${tempReg}, x${rightValReg}, x${leftReg}`);
					this.freeReg(tempReg);
					break;

				default:
					this.textSection.push(`    // TODO: PointFree Inline for -> ${op}`);
			}

			// 使い終わった入力レジスタを解放する（他の計算で再利用できるようにする）
			this.freeReg(leftReg);
			this.freeReg(rightValReg);

			return resultReg; // 計算結果のレジスタを返す
		}

		// もし右辺がPointFreeCoreでなければ、通常の関数呼び出し処理（後日フェーズ4で実装）
		this.textSection.push(`    // TODO: Standard Function Call`);
		return leftReg;
	}
	visitBinaryExpression(node) {
		const leftReg = this.visit(node.left);
		const rightReg = this.visit(node.right);
		const resultReg = this.allocReg();

		switch (node.operator) {
			// --- 算術演算 ---
			case "+": this.textSection.push(`    ADD x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "-": this.textSection.push(`    SUB x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "*": this.textSection.push(`    MUL x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "/": this.textSection.push(`    SDIV x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "%":
				const tempMod = this.allocReg();
				this.textSection.push(`    SDIV x${tempMod}, x${leftReg}, x${rightReg}`);
				this.textSection.push(`    MSUB x${resultReg}, x${tempMod}, x${rightReg}, x${leftReg} `);// result = L - (L/R)*R
				this.freeReg(tempMod);
				break;

			// --- ビット演算 ---
			case "<<": this.textSection.push(`    LSL x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case ">>": this.textSection.push(`    ASR x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "||": this.textSection.push(`    ORR x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case ";;": this.textSection.push(`    EOR x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "&&": this.textSection.push(`    AND x${resultReg}, x${leftReg}, x${rightReg}`); break;

			// --- 比較演算 (CSET -> CSEL による透過的フィルター) ---
			case "=":
			case "==":
				this.textSection.push(`    CMP x${leftReg}, x${rightReg}`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, EQ`);  // 一致で右辺透過、不一致でUnit崩壊
				break;
			case "!=":
				this.textSection.push(`    CMP x${leftReg}, x${rightReg}`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, NE`);
				break;
			case "<":
				this.textSection.push(`    CMP x${leftReg}, x${rightReg}`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, LT`);
				break;
			case ">":
				this.textSection.push(`    CMP x${leftReg}, x${rightReg}`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, GT`);
				break;
			case "<=":
				this.textSection.push(`    CMP x${leftReg}, x${rightReg}`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, LE`);
				break;
			case ">=":
				this.textSection.push(`    CMP x${leftReg}, x${rightReg}`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, GE`);
				break;

			// --- 論理演算 (フォールバックとガード) ---
			case "|":
				this.textSection.push(`    CMP x${leftReg}, x28`);               // 左辺がUnitか判定
				this.textSection.push(`    CSEL x${resultReg}, x${leftReg}, x${rightReg}, NE`); // Unit以外なら左辺、Unitなら右辺
				break;
			case "&":
				this.textSection.push(`    CMP x${leftReg}, x28`);               // 左辺がUnitか判定
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, NE`); // Unit以外なら右辺、UnitならUnit崩壊
				break;

			default:
				this.textSection.push(`    // TODO: Unhandled -> ${node.operator}`);
		}

		this.freeReg(leftReg);
		this.freeReg(rightReg);
		return resultReg;
	}
}