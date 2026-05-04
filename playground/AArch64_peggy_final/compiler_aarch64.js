export class AArch64Generator {
	constructor() {
		this.textSection = [];
		this.dataSection = [];
		this.freeRegs = [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15];
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

    doubleToMovs(reg, n) {
        const buf = new ArrayBuffer(8);
        const view = new DataView(buf);
        view.setFloat64(0, n, true);
        const w0 = view.getUint16(0, true);
        const w1 = view.getUint16(2, true);
        const w2 = view.getUint16(4, true);
        const w3 = view.getUint16(6, true);
        
        this.textSection.push(`    MOV x${reg}, #0x${w0.toString(16).padStart(4, '0')}`);
        if (w1) this.textSection.push(`    MOVK x${reg}, #0x${w1.toString(16).padStart(4, '0')}, LSL #16`);
        if (w2) this.textSection.push(`    MOVK x${reg}, #0x${w2.toString(16).padStart(4, '0')}, LSL #32`);
        if (w3) this.textSection.push(`    MOVK x${reg}, #0x${w3.toString(16).padStart(4, '0')}, LSL #48`);
    }

	generate(ast) {
		this.dataSection.push(".section .rodata");
		this.dataSection.push(".align 3");
		this.dataSection.push("Sign_Unit_Sentinel:");
		this.dataSection.push("    .quad 0x0000000000000000   // Unit (空リスト) の実体");

		this.dataSection.push(".section .bss");
		this.dataSection.push(".align 4");
		this.dataSection.push("Sign_Project_Arena:");
		this.dataSection.push("    .skip 1048576      // 1MB Arena");

		this.textSection.push(".text");
		this.textSection.push(".global _start");
		this.textSection.push(".align 2");
		this.textSection.push("_start:");

		this.textSection.push("    // --- Init Unit Sentinel (x28) ---");
		this.textSection.push("    ADRP x28, Sign_Unit_Sentinel");
		this.textSection.push("    ADD  x28, x28, :lo12:Sign_Unit_Sentinel");
		this.textSection.push("");

		this.textSection.push("    // --- Init Project Arena (x27) ---");
		this.textSection.push("    ADRP x27, Sign_Project_Arena");
		this.textSection.push("    ADD  x27, x27, :lo12:Sign_Project_Arena");
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
		this.textSection.push("    B.EQ .L_exit_unit");
		this.textSection.push("    // Convert double to int for OS exit code (0-255)");
		this.textSection.push("    FMOV d0, x0");
		this.textSection.push("    FCVTZS x0, d0");
		this.textSection.push("    B .L_exit_normal");
		this.textSection.push(".L_exit_unit:");
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
				return this.visitListConstruct(node);
                
            case "Get":
                return this.visitGet(node);

			case "BinaryOperation":
				return this.visitBinaryOperation(node);

			case "Prefix":
				return this.visitPrefix(node);

			case "Postfix":
				return this.visitPostfix(node);

			case "RangeObject":
				return this.visitRangeObject(node);

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
            const val = parseFloat(node.value);
            const reg = this.allocReg();
            this.doubleToMovs(reg, val);
            return reg;
        } else if (node.dataType === "address") {
            const val = parseInt(node.value, 16);
            const reg = this.allocReg();
            this.textSection.push(`    MOV x${reg}, #${val}`);
            return reg;
        } else if (node.dataType === "unit") {
            return this.unitReg;
        } else if (node.dataType === "string") {
            const cleanStr = node.value.replace(/^`|`$/g, "");
            const label = `Sign_Str_${Math.random().toString(36).substr(2, 5)}`;
            this.dataSection.push(`.align 3`);
            this.dataSection.push(`${label}:`);
            this.dataSection.push(`    .quad ${cleanStr.length} // Length`);
            for (let i = 0; i < cleanStr.length; i++) {
                this.dataSection.push(`    .quad ${cleanStr.charCodeAt(i)} // '${cleanStr[i]}'`);
            }
            
            const reg = this.allocReg();
            this.textSection.push(`    ADRP x${reg}, ${label}`);
            this.textSection.push(`    ADD  x${reg}, x${reg}, :lo12:${label}`);
            return reg;
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

    visitListConstruct(node) {
        // Check for Static Promotion (Constant Folding)
        const isStaticList = node.elements.every(e => 
            e.type === "Atom" && (e.dataType === "number" || e.dataType === "unit")
        );

        if (isStaticList) {
            const label = `Sign_ListStatic_${Math.random().toString(36).substr(2, 5)}`;
            this.dataSection.push(`.section .rodata`);
            this.dataSection.push(`.align 3`);
            this.dataSection.push(`${label}:`);
            this.dataSection.push(`    .quad ${node.elements.length} // Static List Length`);
            
            for (let e of node.elements) {
                if (e.dataType === "number") {
                    this.dataSection.push(`    .quad ${parseInt(e.value, 10)} // Element ${e.value}`);
                } else if (e.dataType === "unit") {
                    this.dataSection.push(`    .quad Sign_Unit_Sentinel // Element Unit`);
                }
            }
            
            const reg = this.allocReg();
            this.textSection.push(`    ADRP x${reg}, ${label}`);
            this.textSection.push(`    ADD  x${reg}, x${reg}, :lo12:${label}`);
            return reg;
        }

        // Dynamic Allocation Fallback
        // 1. Evaluate all elements
        const elemRegs = node.elements.map(e => this.visit(e));
        const len = elemRegs.length;

        // 2. The pointer to the new list is in x27
        const resultReg = this.allocReg();
        this.textSection.push(`    MOV x${resultReg}, x27 // List pointer`);

        // 3. Store length at offset 0
        const lenReg = this.allocReg();
        this.textSection.push(`    MOV x${lenReg}, #${len}`);
        this.textSection.push(`    STR x${lenReg}, [x27] // Store length`);
        this.freeReg(lenReg);

        // 4. Store elements
        elemRegs.forEach((r, i) => {
            const offset = (i + 1) * 8;
            this.textSection.push(`    STR x${r}, [x27, #${offset}] // Store element ${i}`);
            this.freeReg(r);
        });

        // 5. Advance Arena pointer x27
        const totalSize = (len + 1) * 8;
        const alignedSize = Math.ceil(totalSize / 16) * 16;
        this.textSection.push(`    ADD x27, x27, #${alignedSize} // Advance Arena`);

        return resultReg;
    }

    visitGet(node) {
        let currentReg = this.visit(node.target);
        
        for (let prop of node.properties) {
            if (typeof prop === "string") {
                this.textSection.push(`    // TODO: Get string literal property ${prop}`);
                continue;
            }
            
            const propReg = this.visit(prop);
            const resultReg = this.allocReg();
            const tmpReg = this.allocReg();
            
            // Load TypeTag (or Length header)
            this.textSection.push(`    LDR x${tmpReg}, [x${currentReg}, #0]`);
            
            // Range Sentinel is 0xFFFFFFFFFFFFFFFE
            const isRangeLabel = `.L_is_range_${Math.random().toString(36).substr(2, 5)}`;
            const isListLabel = `.L_is_list_${Math.random().toString(36).substr(2, 5)}`;
            const endLabel = `.L_get_end_${Math.random().toString(36).substr(2, 5)}`;
            
            const sentinelReg = this.allocReg();
            this.textSection.push(`    MOV x${sentinelReg}, #0xFFFE`);
            this.textSection.push(`    MOVK x${sentinelReg}, #0xFFFF, LSL #16`);
            this.textSection.push(`    MOVK x${sentinelReg}, #0xFFFF, LSL #32`);
            this.textSection.push(`    MOVK x${sentinelReg}, #0xFFFF, LSL #48`);
            
            this.textSection.push(`    CMP x${tmpReg}, x${sentinelReg}`);
            this.textSection.push(`    B.EQ ${isRangeLabel}`);
            
            // --- List Access (Not a range) ---
            this.textSection.push(`${isListLabel}:`);
            this.textSection.push(`    FMOV d0, x${propReg}`);
            this.textSection.push(`    FCVTZS x${propReg}, d0`); // propReg is now integer
            this.textSection.push(`    ADD x${propReg}, x${propReg}, #1 // Skip length header`);
            this.textSection.push(`    LSL x${propReg}, x${propReg}, #3 // Convert to byte offset (*8)`);
            this.textSection.push(`    LDR x${resultReg}, [x${currentReg}, x${propReg}] // Get list element`);
            this.textSection.push(`    B ${endLabel}`);
            
            // --- Range Access (O(1) Math) ---
            this.textSection.push(`${isRangeLabel}:`);
            const startR = this.allocReg();
            const stepR = this.allocReg();
            const opR = this.allocReg();
            
            this.textSection.push(`    LDR x${startR}, [x${currentReg}, #8]`);
            this.textSection.push(`    LDR x${stepR}, [x${currentReg}, #16]`);
            this.textSection.push(`    LDR x${opR}, [x${currentReg}, #32]`);
            
            // Move index to FPU
            this.textSection.push(`    FMOV d0, x${propReg} // Index`);
            this.textSection.push(`    FMOV d1, x${startR} // Start`);
            this.textSection.push(`    FMOV d2, x${stepR} // Step`);
            
            // Check if ~+ or ~- (0 or 1)
            this.textSection.push(`    CMP x${opR}, #2`);
            const powLabel = `.L_range_pow_${Math.random().toString(36).substr(2, 5)}`;
            this.textSection.push(`    B.GE ${powLabel} // If ~* or ~/ or ~^`);
            
            // --- Addition/Subtraction ---
            this.textSection.push(`    FMUL d0, d0, d2 // d0 = index * step`);
            this.textSection.push(`    CMP x${opR}, #1`);
            this.textSection.push(`    B.EQ 1f // If subtraction (~-)`);
            
            // Addition (~+)
            this.textSection.push(`    FADD d3, d1, d0 // start + (step * index)`);
            this.textSection.push(`    FMOV x${resultReg}, d3`);
            this.textSection.push(`    B ${endLabel}`);
            
            // Subtraction (~-)
            this.textSection.push(`1:`);
            this.textSection.push(`    FSUB d3, d1, d0 // start - (step * index)`);
            this.textSection.push(`    FMOV x${resultReg}, d3`);
            this.textSection.push(`    B ${endLabel}`);
            
            // --- Multiplication/Division/Power (Pow Loop) ---
            const powLoopLabel = `.L_pow_loop_${Math.random().toString(36).substr(2, 5)}`;
            const powEndLabel = `.L_pow_end_${Math.random().toString(36).substr(2, 5)}`;
            
            this.textSection.push(`${powLabel}:`);
            // We need integer loop counter. Convert Index (d0) to Integer!
            this.textSection.push(`    FCVTZS x${propReg}, d0`);
            
            const tmpReg2 = this.allocReg();
            this.doubleToMovs(tmpReg2, 1.0);
            this.textSection.push(`    FMOV d3, x${tmpReg2}`); // pow_res (d3) = 1.0
            this.freeReg(tmpReg2);
            
            this.textSection.push(`    CBZ x${propReg}, ${powEndLabel} // if index == 0, skip loop`);
            
            this.textSection.push(`${powLoopLabel}:`);
            this.textSection.push(`    FMUL d3, d3, d2 // pow_res *= step`);
            this.textSection.push(`    SUB x${propReg}, x${propReg}, #1`);
            this.textSection.push(`    CBNZ x${propReg}, ${powLoopLabel}`);
            
            this.textSection.push(`${powEndLabel}:`);
            
            this.textSection.push(`    CMP x${opR}, #3`);
            this.textSection.push(`    B.EQ 3f // If division (~/)`);
            this.textSection.push(`    B.GT 4f // If power (~^)`);
            
            // Multiplication (~*)
            this.textSection.push(`    FMUL d4, d1, d3 // start * (step ^ index)`);
            this.textSection.push(`    FMOV x${resultReg}, d4`);
            this.textSection.push(`    B ${endLabel}`);
            
            // Division (~/)
            this.textSection.push(`3:`);
            this.textSection.push(`    FDIV d4, d1, d3 // start / (step ^ index)`);
            this.textSection.push(`    FMOV x${resultReg}, d4`);
            this.textSection.push(`    B ${endLabel}`);
            
            // Power (~^)
            this.textSection.push(`4:`);
            this.textSection.push(`    FCVTZS x${propReg}, d3 // inner loop counter = int(step^index)`);
            
            const tmpReg3 = this.allocReg();
            this.doubleToMovs(tmpReg3, 1.0);
            this.textSection.push(`    FMOV d4, x${tmpReg3} // res2 = 1.0`);
            this.freeReg(tmpReg3);
            
            const powLoop2Label = `.L_pow2_loop_${Math.random().toString(36).substr(2, 5)}`;
            const powEnd2Label = `.L_pow2_end_${Math.random().toString(36).substr(2, 5)}`;
            
            this.textSection.push(`    CBZ x${propReg}, ${powEnd2Label}`);
            this.textSection.push(`${powLoop2Label}:`);
            this.textSection.push(`    FMUL d4, d4, d1 // res2 *= start`);
            this.textSection.push(`    SUB x${propReg}, x${propReg}, #1`);
            this.textSection.push(`    CBNZ x${propReg}, ${powLoop2Label}`);
            this.textSection.push(`${powEnd2Label}:`);
            this.textSection.push(`    FMOV x${resultReg}, d4`);
            
            // fallthrough to endLabel
            this.textSection.push(`${endLabel}:`);
            
            this.freeReg(startR);
            this.freeReg(stepR);
            this.freeReg(opR);
            this.freeReg(tmpReg);
            this.freeReg(sentinelReg);
            
            this.freeReg(currentReg);
            this.freeReg(propReg);
            currentReg = resultReg;
        }
        return currentReg;
    }

	visitRangeObject(node) {
        const startReg = this.visit(node.start);
        const stepReg = this.visit(node.step);
        const endReg = this.visit(node.end);
        
        let opCode = 0; // ~+
        if (node.operator === "~-") opCode = 1;
        else if (node.operator === "~*") opCode = 2;
        else if (node.operator === "~/") opCode = 3;
        else if (node.operator === "~^") opCode = 4;
        
        const reg = this.allocReg();
        const tmp = this.allocReg();
        const opTmp = this.allocReg();

        this.textSection.push(`    MOV x${tmp}, #0xFFFE`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #16`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #32`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #48`);
        
        this.textSection.push(`    MOV x${opTmp}, #${opCode}`);

        // Allocate 40 bytes in Arena
        this.textSection.push(`    MOV x${reg}, x27 // Save range pointer`);
        this.textSection.push(`    STR x${tmp}, [x27, #0] // TypeTag`);
        this.textSection.push(`    STR x${startReg}, [x27, #8] // start`);
        this.textSection.push(`    STR x${stepReg}, [x27, #16] // step`);
        this.textSection.push(`    STR x${endReg}, [x27, #24] // end`);
        this.textSection.push(`    STR x${opTmp}, [x27, #32] // operator`);
        this.textSection.push(`    ADD x27, x27, #40 // Advance arena`);

        this.freeReg(startReg);
        this.freeReg(stepReg);
        this.freeReg(endReg);
        this.freeReg(tmp);
        this.freeReg(opTmp);

        return reg;
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
			case "+":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FADD d2, d0, d1`);
				this.textSection.push(`    FMOV x${resultReg}, d2`);
				break;
			case "-":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FSUB d2, d0, d1`);
				this.textSection.push(`    FMOV x${resultReg}, d2`);
				break;
			case "*":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FMUL d2, d0, d1`);
				this.textSection.push(`    FMOV x${resultReg}, d2`);
				break;
			case "/":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FDIV d2, d0, d1`);
				this.textSection.push(`    FMOV x${resultReg}, d2`);
				break;
			case "%":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FCVTZS x2, d0`);
				this.textSection.push(`    FCVTZS x3, d1`);
				this.textSection.push(`    UDIV x4, x2, x3`);
				this.textSection.push(`    MSUB x5, x4, x3, x2`);
				this.textSection.push(`    SCVTF d2, x5`);
				this.textSection.push(`    FMOV x${resultReg}, d2`);
				break;
			case "=":
			case "==":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FCMP d0, d1`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, EQ`);
				break;
			case "!=":
			case "!==":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FCMP d0, d1`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, NE`);
				break;
			case "<":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FCMP d0, d1`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, MI`);
				break;
			case ">":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FCMP d0, d1`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, GT`);
				break;
			case "<=":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FCMP d0, d1`);
				this.textSection.push(`    CSEL x${resultReg}, x${rightReg}, x28, LS`);
				break;
			case ">=":
				this.textSection.push(`    FMOV d0, x${leftReg}`);
				this.textSection.push(`    FMOV d1, x${rightReg}`);
				this.textSection.push(`    FCMP d0, d1`);
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
        if (node.operators.includes("$")) {
            const exp = node.expression;
            if (exp.type === "Block" && exp.expressions.length === 1 && exp.expressions[0].type === "Lambda") {
                return this.visitLambda(exp.expressions[0]);
            }
            if (exp.type === "Atom" && exp.dataType === "identifier") {
                const reg = this.allocReg();
                this.textSection.push(`    ADRP x${reg}, .L_func_${exp.value}`);
                this.textSection.push(`    ADD  x${reg}, x${reg}, :lo12:.L_func_${exp.value}`);
                return reg;
            }
            return this.visit(exp);
        }
        
        if (node.operators.includes("@")) {
            // @ is a syntactic marker for function application on a pointer.
            // The pointer value is just the evaluated expression.
            return this.visit(node.expression);
        }

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
