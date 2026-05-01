export class AArch64Generator {
	constructor() {
		this.textSection = [];
		this.dataSection = [];
		this.freeRegs = [1, 2, 3, 4, 5, 6, 7];
		this.unitReg = 28;
		this.env = {};
		this.nextOffset = 0;
        this.funcCount = 0;
        this.functions = []; // To store generated function assembly
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

        // Append generated functions
        if (this.functions.length > 0) {
            this.textSection.push("\n    // --- Functions ---");
            this.textSection.push(...this.functions);
        }

		const dataOutput = this.dataSection.length > 0 ? this.dataSection.join("\n") + "\n\n" : "";
		const textOutput = this.textSection.join("\n") + "\n";
		return dataOutput + textOutput;
	}

	visit(node) {
		if (!node) return this.unitReg;

		if (Array.isArray(node)) {
			let lastReg = this.unitReg;
			for (let n of node) {
                if (lastReg !== this.unitReg) this.freeReg(lastReg);
                lastReg = this.visit(n);
            }
			return lastReg;
		}

		switch (node.type) {
			case "Program":
				return this.visit(node.body);

			case "Block":
                let lastReg = this.unitReg;
                const expressions = node.expressions || [];
                for (let n of expressions) {
                    if (lastReg !== this.unitReg) this.freeReg(lastReg);
                    lastReg = this.visit(n);
                }
                return lastReg;

			case "Define":
				return this.visitDefine(node);

			case "Lambda":
				return this.visitLambda(node);

			case "Atom":
				return this.visitAtom(node);

			case "FunctionCall":
				return this.visitFunctionCall(node);

			case "ListConstruct":
                // 暫定的に最後の要素を返すか、未実装とする
				this.textSection.push(`    // TODO: ListConstruct`);
				return this.unitReg;

			case "BinaryOperation":
				return this.visitBinaryOperation(node);

			case "Prefix":
				return this.visitPrefix(node);

			case "Postfix":
				return this.visitPostfix(node);

			default:
				this.textSection.push(`    // TODO: Unhandled node -> ${node.type}`);
				return this.unitReg;
		}
	}

	// --- Handlers ---

    visitDefine(node) {
        if (node.definition.type === "Lambda") {
            // Compile Lambda and assign to identifier
            const funcLabel = this.compileLambda(node.definition, node.identifier);
            // We can optionally store the function address in environment if needed
            return this.unitReg;
        }

        // Constant / Variable definition
        const rightReg = this.visit(node.definition);
        const name = node.identifier;
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

    compileLambda(node, name = null) {
        this.funcCount++;
        const funcLabel = name ? `.L_func_${name}` : `.L_func_anon_${this.funcCount}`;
        
        // Push context to generate function assembly
        const oldTextSection = this.textSection;
        this.textSection = [];

        this.textSection.push(`${funcLabel}:`);
        this.textSection.push(`    // Prologue`);
        this.textSection.push(`    STP fp, lr, [sp, #-16]!`);
        this.textSection.push(`    MOV fp, sp`);
        
        // Save old env and setup new arg offsets
        const oldEnv = { ...this.env };
        let argCount = 0;
        if (node.arguments && node.arguments.items) {
            argCount = Math.min(8, node.arguments.items.length);
        }
        
        // Allocate 16-byte aligned stack space for arguments
        let stackSpace = Math.ceil(argCount * 8 / 16) * 16;
        if (stackSpace > 0) {
            this.textSection.push(`    SUB sp, sp, #${stackSpace}`);
        }

        if (node.arguments && node.arguments.items) {
            node.arguments.items.forEach((arg, index) => {
                const argName = arg.identifier;
                // Args are in x0, x1, ...
                if (index < 8) {
                    const offset = -8 * (index + 1);
                    this.textSection.push(`    STR x${index}, [fp, #${offset}] // Save arg '${argName}'`);
                    this.env[argName] = offset; // relative to fp
                }
            });
        }

        const bodyReg = this.visit(node.body);
        if (bodyReg !== 0) {
            this.textSection.push(`    MOV x0, x${bodyReg}`);
        }
        this.freeReg(bodyReg);

        this.textSection.push(`    // Epilogue`);
        this.textSection.push(`    MOV sp, fp`);
        this.textSection.push(`    LDP fp, lr, [sp], #16`);
        this.textSection.push(`    RET`);
        this.textSection.push(``);

        // Restore context
        this.env = oldEnv;
        this.functions.push(...this.textSection);
        this.textSection = oldTextSection;

        return funcLabel;
    }

	visitLambda(node) {
        // Anonymous lambda, return its address
        const funcLabel = this.compileLambda(node);
        const reg = this.allocReg();
        this.textSection.push(`    ADRP x${reg}, ${funcLabel}`);
        this.textSection.push(`    ADD  x${reg}, x${reg}, :lo12:${funcLabel}`);
        return reg;
	}

	visitAtom(node) {
        if (node.dataType === "number") {
            const val = parseInt(node.value, 10);
            const reg = this.allocReg();
            this.textSection.push(`    MOV x${reg}, #${val}`);
            return reg;
        } else if (node.dataType === "address") {
            const val = parseInt(node.value, 16);
            const reg = this.allocReg();
            this.textSection.push(`    MOV x${reg}, #${val}`);
            return reg;
        } else if (node.dataType === "unit") {
            return this.unitReg;
        } else if (node.dataType === "identifier") {
            const name = node.value;
            // First check if it's a function we know
            // In a real compiler we'd resolve scope properly.
            // Check memory environment
            if (this.env[name] !== undefined) {
                const offset = this.env[name];
                const resultReg = this.allocReg();
                if (offset < 0) {
                    // Local argument relative to fp
                    this.textSection.push(`    LDR x${resultReg}, [fp, #${offset}] // Load arg '${name}'`);
                } else {
                    // Top-level variable (Simplification: Assuming top-level sp didn't change much, 
                    // though for correct global access we should use a global static base pointer)
                    // Let's just output a warning for now and use sp.
                    this.textSection.push(`    // Note: Global access assumes top-level SP here`);
                    this.textSection.push(`    LDR x${resultReg}, [sp, #${offset}] // Load global '${name}'`);
                }
                return resultReg;
            } else {
                // It might be a global function.
                // Load address of function label.
                const resultReg = this.allocReg();
                this.textSection.push(`    ADRP x${resultReg}, .L_func_${name}`);
                this.textSection.push(`    ADD  x${resultReg}, x${resultReg}, :lo12:.L_func_${name} // Function Ref`);
                return resultReg;
            }
        } else {
            this.textSection.push(`    // TODO: Unhandled Atom -> ${node.dataType} (${node.value})`);
            return this.unitReg;
        }
	}

	visitFunctionCall(node) {
        // callee and arguments
        // Evaluate arguments
        const argRegs = [];
        for (let arg of node.arguments) {
            argRegs.push(this.visit(arg));
        }

        // Move args to x0..x7
        argRegs.forEach((r, i) => {
            if (i < 8) {
                this.textSection.push(`    MOV x${i}, x${r}`);
            }
            this.freeReg(r);
        });

        // Call the function
        if (node.callee.type === "Atom" && node.callee.dataType === "identifier") {
            this.textSection.push(`    BL .L_func_${node.callee.value}`);
        } else {
            const calleeReg = this.visit(node.callee);
            this.textSection.push(`    BLR x${calleeReg}`);
            this.freeReg(calleeReg);
        }

        const resultReg = this.allocReg();
        this.textSection.push(`    MOV x${resultReg}, x0`);
        return resultReg;
	}

	visitBinaryOperation(node) {
        // 短絡評価 (Short-circuit evaluation)
        if (node.operator === "|") {
            const leftReg = this.visit(node.left);
            const resultReg = this.allocReg();
            
            const skipLabel = `.L_skip_or_${Math.random().toString(36).substr(2, 5)}`;
            this.textSection.push(`    CMP x${leftReg}, x28 // Check if left is Unit`);
            this.textSection.push(`    MOV x${resultReg}, x${leftReg}`);
            this.textSection.push(`    B.NE ${skipLabel} // If true, skip evaluating right`);
            
            const rightReg = this.visit(node.right);
            this.textSection.push(`    MOV x${resultReg}, x${rightReg}`);
            this.textSection.push(`${skipLabel}:`);
            this.freeReg(leftReg);
            this.freeReg(rightReg);
            return resultReg;
        }

        if (node.operator === "&") {
            const leftReg = this.visit(node.left);
            const resultReg = this.allocReg();
            
            const skipLabel = `.L_skip_and_${Math.random().toString(36).substr(2, 5)}`;
            this.textSection.push(`    CMP x${leftReg}, x28 // Check if left is Unit`);
            this.textSection.push(`    MOV x${resultReg}, x28`); // Pre-load Unit as false
            this.textSection.push(`    B.EQ ${skipLabel} // If false, skip evaluating right`);
            
            const rightReg = this.visit(node.right);
            this.textSection.push(`    MOV x${resultReg}, x${rightReg}`);
            this.textSection.push(`${skipLabel}:`);
            this.freeReg(leftReg);
            this.freeReg(rightReg);
            return resultReg;
        }

        // Standard strict evaluation for others
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
			case "=":
			case "==":
				this.textSection.push(`    CMP x${leftReg}, x${rightReg}`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, EQ`);
				break;
			case "!=":
			case "!==":
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
			default:
				this.textSection.push(`    // TODO: Unhandled Binary -> ${node.operator}`);
		}
		this.freeReg(leftReg);
		this.freeReg(rightReg);
		return resultReg;
	}

	visitPrefix(node) {
        let currentReg = this.visit(node.expression);
        for (let i = node.operators.length - 1; i >= 0; i--) {
            const op = node.operators[i];
            const resultReg = this.allocReg();
            if (op === "!") {
                this.textSection.push(`    CMP x${currentReg}, x28`);
                this.textSection.push(`    MOV x${resultReg}, #1`);
                this.textSection.push(`    CSEL x${resultReg}, x${resultReg}, x28, EQ`);
            } else if (op === "$") {
                this.textSection.push(`    // TODO: $ Address operator`);
            } else if (op === "@") {
                this.textSection.push(`    LDR x${resultReg}, [x${currentReg}]`);
            } else {
                this.textSection.push(`    // TODO: Prefix ${op}`);
            }
            this.freeReg(currentReg);
            currentReg = resultReg;
        }
        return currentReg;
	}

    visitPostfix(node) {
        let currentReg = this.visit(node.expression);
        for (let i = 0; i < node.operators.length; i++) {
            const op = node.operators[i];
            if (op === "~") {
                this.textSection.push(`    // TODO: Flattening / Force Eval ~`);
            } else {
                this.textSection.push(`    // TODO: Postfix ${op}`);
            }
        }
        return currentReg;
    }
}
