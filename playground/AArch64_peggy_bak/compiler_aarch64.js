// compiler_aarch64.js
export class AArch64Generator {
	constructor() {
		this.textSection = [];
		this.dataSection = [];
		this.freeRegs = [1, 2, 3, 4, 5, 6, 7];
		this.unitReg = 28;
		this.env = {};
		this.nextOffset = 0;
	}

	allocReg() {
		if (this.freeRegs.length === 0) throw new Error("コンパイルエラー: レジスタが枯渇しました");
		return this.freeRegs.shift();
	}

	freeReg(regNum) {
		if (regNum !== 0 && regNum !== this.unitReg && !this.freeRegs.includes(regNum)) {
			this.freeRegs.unshift(regNum);
		}
	}

	generate(ast) {
		this.dataSection.push(".section .rodata");
		this.dataSection.push(".align 3");
		this.dataSection.push("Sign_Unit_Sentinel:");
		this.dataSection.push("    .quad 0x0000000000000000   // Unit (空リスト) の実体");

		this.textSection.push(".text");
		this.textSection.push(".global _start");
		this.textSection.push(".align 2");
		this.textSection.push("_start:");

		this.textSection.push("    // --- Init Unit Sentinel (x28) ---");
		this.textSection.push("    ADRP x28, Sign_Unit_Sentinel");
		this.textSection.push("    ADD  x28, x28, :lo12:Sign_Unit_Sentinel");
		this.textSection.push("");

		this.textSection.push("    // --- Setup Place Space (Stack Memory) ---");
		this.textSection.push("    SUB sp, sp, #256           // 変数領域を確保");
		this.textSection.push("");

		const resultReg = this.visit(ast);

		if (resultReg !== undefined && resultReg !== 0) {
			this.textSection.push(`    MOV x0, x${resultReg}      // 最終結果を x0 にセット`);
		}

		this.textSection.push("");
		this.textSection.push("    // --- Check if Result is Unit ---");
		this.textSection.push("    CMP x0, x28");
		this.textSection.push("    B.NE .L_exit_normal");
		this.textSection.push("    MOV x0, #255               // Unitの場合は終了コード 255 (Debug)");
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
		if (!node) return this.unitReg;

		if (Array.isArray(node)) {
			let lastReg = this.unitReg;
			for (let n of node) lastReg = this.visit(n);
			return lastReg;
		}

		if (node.type === "Unit") return this.unitReg;
		if (node.type === "Block") {
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
			case "StringLiteral":
				return this.unitReg;
			case "Identifier":
				return this.visitIdentifier(node);
			case "FunctionCall":
			case "ListConstruct":
				return this.visitApplication(node);
			case "PointFreeCore":
				this.textSection.push(`    // TODO: Closures for PointFreeCore -> ${node.operator}`);
				return this.allocReg();
			case "BinaryExpression":
				return this.visitBinaryExpression(node);
			case "PrefixExpression":
				return this.visitPrefixExpression(node);
			case "OutputExpression":
				return this.visitOutputExpression(node);
			default:
				this.textSection.push(`    // TODO: Unhandled node -> ${node.type}`);
				return this.unitReg;
		}
	}

	// --- Handlers ---

	visitLiteral(node) {
		const val = node.type === "AddressLiteral" ? parseInt(node.value, 16) : parseInt(node.value, 10);
		const reg = this.allocReg();
		this.textSection.push(`    MOV x${reg}, #${val}`);
		return reg;
	}

	visitRegisterLiteral(node) {
		const regNum = parseInt(node.value.substring(2), 16);
		const destReg = this.allocReg();
		this.textSection.push(`    MOV x${destReg}, x${regNum}`);
		return destReg;
	}

	visitIdentifier(node) {
		const name = node.name;
		if (this.env[name] !== undefined) {
			const offset = this.env[name];
			const resultReg = this.allocReg();
			this.textSection.push(`    LDR x${resultReg}, [sp, #${offset}] // Load variable '${name}'`);
			return resultReg;
		} else {
			this.textSection.push(`    // ERROR: Unresolved Identifier -> ${name}`);
			return this.unitReg;
		}
	}

	visitApplication(node) {
		const leftReg = this.visit(node.left);

		if (node.right && node.right.type === "PointFreeCore") {
			const op = node.right.operator;
			const rightValReg = this.visit(node.right.right);
			const resultReg = this.allocReg();

			switch (op) {
				case "+": this.textSection.push(`    ADD x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "-": this.textSection.push(`    SUB x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "*": this.textSection.push(`    MUL x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "/": this.textSection.push(`    SDIV x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "%":
					const tempReg = this.allocReg();
					this.textSection.push(`    SDIV x${tempReg}, x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    MSUB x${resultReg}, x${tempReg}, x${rightValReg}, x${leftReg}`);
					this.freeReg(tempReg);
					break;
				case "<<": this.textSection.push(`    LSL x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case ">>": this.textSection.push(`    ASR x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "||": this.textSection.push(`    ORR x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case ";;": this.textSection.push(`    EOR x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "&&": this.textSection.push(`    AND x${resultReg}, x${leftReg}, x${rightValReg}`); break;
				case "=":
				case "==":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, EQ`);
					break;
				case "!=":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, NE`);
					break;
				case "<":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, LT`);
					break;
				case ">":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, GT`);
					break;
				case "<=":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, LE`);
					break;
				case ">=":
					this.textSection.push(`    CMP x${leftReg}, x${rightValReg}`);
					this.textSection.push(`    CSEL x${resultReg}, x${rightValReg}, x28, GE`);
					break;
				default:
					this.textSection.push(`    // TODO: PointFree Inline for -> ${op}`);
			}
			this.freeReg(leftReg);
			this.freeReg(rightValReg);
			return resultReg;
		}

		this.textSection.push(`    // TODO: Standard Function Call`);
		return leftReg;
	}

	visitBinaryExpression(node) {
		if (node.operator === ":") {
			return this.visitBind(node);
		}

		const leftReg = this.visit(node.left);
		const rightReg = this.visit(node.right);
		const resultReg = this.allocReg();

		switch (node.operator) {
			case "+": this.textSection.push(`    ADD x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "-": this.textSection.push(`    SUB x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "*": this.textSection.push(`    MUL x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "/": this.textSection.push(`    SDIV x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "%":
				const tempMod = this.allocReg();
				this.textSection.push(`    SDIV x${tempMod}, x${leftReg}, x${rightReg}`);
				this.textSection.push(`    MSUB x${resultReg}, x${tempMod}, x${rightReg}, x${leftReg}`);
				this.freeReg(tempMod);
				break;
			case "<<": this.textSection.push(`    LSL x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case ">>": this.textSection.push(`    ASR x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "||": this.textSection.push(`    ORR x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case ";;": this.textSection.push(`    EOR x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "&&": this.textSection.push(`    AND x${resultReg}, x${leftReg}, x${rightReg}`); break;
			case "=":
			case "==":
				this.textSection.push(`    CMP x${leftReg}, x${rightReg}`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, EQ`);
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
			case "|":
				this.textSection.push(`    CMP x${leftReg}, x28`);
				this.textSection.push(`    CSEL x${resultReg}, x${leftReg}, x${rightReg}, NE`);
				break;
			case "&":
				this.textSection.push(`    CMP x${leftReg}, x28`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, NE`);
				break;
			default:
				this.textSection.push(`    // TODO: Unhandled Binary -> ${node.operator}`);
		}
		this.freeReg(leftReg);
		this.freeReg(rightReg);
		return resultReg;
	}

	visitBind(node) {
		const rightReg = this.visit(node.right);
		if (node.left.type === "Identifier") {
			const name = node.left.name;
			if (this.env[name] === undefined) {
				this.env[name] = this.nextOffset;
				this.nextOffset += 8;
			}
			const offset = this.env[name];
			this.textSection.push(`    STR x${rightReg}, [sp, #${offset}] // Bind '${name}' to Memory`);
			const resultReg = this.allocReg();
			this.textSection.push(`    MOV x${resultReg}, x${rightReg}`);
			this.freeReg(rightReg);
			return resultReg;
		}
		return rightReg;
	}

	// --- 境界演算子 ($, @, #) の統合ハンドラ ---

	visitPrefixExpression(node) {
		return this.handleBoundaryOperator(node.operator, node.argument || node.right || node.left);
	}

	visitOutputExpression(node) {
		const op = node.operator;

		// # (Store) の場合は中置演算子として処理
		if (op === "#") {
			// 左辺＝場所(アドレス)、右辺＝値
			const leftReg = this.visit(node.left);   // アドレスを評価
			const rightReg = this.visit(node.right); // 値を評価

			// 値(右辺)を、アドレス(左辺)の指すメモリに書き込む
			this.textSection.push(`    STR x${rightReg}, [x${leftReg}]      // # (Store Value to Address)`);

			// Input(@)との双対性のため、アドレス(左辺)を透過させて返す
			this.freeReg(rightReg); // 値レジスタは解放
			return leftReg;         // アドレスレジスタを親に返す
		}

		// もし $ や @ が OutputExpression としてパースされていた場合の救済
		return this.handleBoundaryOperator(op, node.argument || node.right || node.left);
	}

	handleBoundaryOperator(op, argumentNode) {
		if (op === "$") {
			if (argumentNode && argumentNode.type === "Identifier") {
				const name = argumentNode.name;
				if (this.env[name] !== undefined) {
					const offset = this.env[name];
					const resultReg = this.allocReg();
					this.textSection.push(`    ADD x${resultReg}, sp, #${offset}  // $${name} (Get Address)`);
					return resultReg;
				} else {
					this.textSection.push(`    // ERROR: Undefined variable -> ${name}`);
				}
			} else {
				this.textSection.push(`    // ERROR: Cannot get address of non-identifier`);
			}
			return this.unitReg;
		}

		if (op === "@") {
			const addrReg = this.visit(argumentNode);
			const resultReg = this.allocReg();
			this.textSection.push(`    LDR x${resultReg}, [x${addrReg}]      // @ (Load from pointer)`);
			this.freeReg(addrReg);
			return resultReg;
		}

		this.textSection.push(`    // TODO: Unhandled Boundary Operator -> ${op}`);
		return this.unitReg;
	}
}