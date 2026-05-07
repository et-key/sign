export class AArch64Generator {
	constructor() {
		this.textSection = [];
		this.dataSection = [];
		this.freeRegs = [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15];
		this.unitReg = 28;
		this.scopes = [{}];
		this.nextOffset = -8;
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
        
		this.dataSection.push("Sign_Default_Trigger_Sentinel:");
		this.dataSection.push("    .quad 0xFFFFFFFFFFFFFFFF   // Default Trigger (!_) の実体");

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
		this.textSection.push("    MOV fp, sp");
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

			case "Dictionary":
				return this.visitDictionary(node);
                
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

    resolveVar(name) {
        for (let i = this.scopes.length - 1; i >= 0; i--) {
            if (this.scopes[i][name]) return this.scopes[i][name];
        }
        return null;
    }

    getFreeVariables(node, localVars = new Set()) {
        let freeVars = new Set();
        if (!node) return freeVars;
        
        if (Array.isArray(node)) {
            for (let n of node) {
                for (let v of this.getFreeVariables(n, localVars)) freeVars.add(v);
            }
            return freeVars;
        }

        switch (node.type) {
            case "Lambda":
                let newLocals = new Set(localVars);
                if (node.arguments && node.arguments.items) {
                    node.arguments.items.forEach(a => newLocals.add(a.identifier));
                }
                return this.getFreeVariables(node.body, newLocals);
            case "Atom":
                if (node.dataType === "identifier") {
                    if (!localVars.has(node.value)) freeVars.add(node.value);
                }
                return freeVars;
            case "Define":
                localVars.add(node.identifier);
                return this.getFreeVariables(node.definition, localVars);
            default:
                for (let key of Object.keys(node)) {
                    if (key === "type") continue;
                    if (typeof node[key] === "object") {
                        for (let v of this.getFreeVariables(node[key], localVars)) freeVars.add(v);
                    }
                }
                return freeVars;
        }
    }

    getLocalVariables(node, vars = []) {
        if (!node) return vars;
        if (Array.isArray(node)) {
            for (let n of node) this.getLocalVariables(n, vars);
            return vars;
        }
        if (node.type === "Define") {
            if (!vars.includes(node.identifier)) vars.push(node.identifier);
            this.getLocalVariables(node.definition, vars);
        } else if (node.type !== "Lambda") {
            for (let key of Object.keys(node)) {
                if (key === "type") continue;
                if (typeof node[key] === "object") this.getLocalVariables(node[key], vars);
            }
        }
        return vars;
    }

    visitDefine(node) {
        if (node.definition.type === "Lambda") {
            // Function definition
            const closureReg = this.visitLambda(node.definition, node.identifier);
            const name = node.identifier;
            if (!this.scopes[0][name]) {
                this.scopes[0][name] = { offset: this.nextOffset, base: "fp" };
                this.nextOffset -= 8;
            }
            const v = this.scopes[0][name];
            this.textSection.push(`    STR x${closureReg}, [${v.base}, #${v.offset}] // Bind function '${name}'`);
            return closureReg;
        }

        // Constant / Variable definition
        const rightReg = this.visit(node.definition);
        const name = node.identifier;
        if (!this.scopes[0][name]) {
            this.scopes[0][name] = { offset: this.nextOffset, base: "fp" };
            this.nextOffset -= 8;
        }
        const v = this.scopes[0][name];
        this.textSection.push(`    STR x${rightReg}, [${v.base}, #${v.offset}] // Bind '${name}'`);
        const resultReg = this.allocReg();
        this.textSection.push(`    MOV x${resultReg}, x${rightReg}`);
        this.freeReg(rightReg);
        return resultReg;
    }

    compileLambda(node, capturedVars, name = null) {
        this.funcCount++;
        const funcLabel = name ? `.L_func_${name}` : `.L_func_anon_${this.funcCount}`;
        
        const oldTextSection = this.textSection;
        this.textSection = [];

        this.textSection.push(`${funcLabel}:`);
        this.textSection.push(`    // Prologue`);
        this.textSection.push(`    STP fp, lr, [sp, #-16]!`);
        this.textSection.push(`    MOV fp, sp`);
        
        const oldScopes = this.scopes;
        const oldNextOffset = this.nextOffset;
        
        this.scopes = [{}]; 
        this.nextOffset = -8;

        capturedVars.forEach((v, idx) => {
            this.scopes[0][v.name] = { offset: idx * 8, base: "x8" };
        });

        const localVars = this.getLocalVariables(node.body);
        let argCount = 0;
        if (node.arguments && node.arguments.items) argCount = Math.min(8, node.arguments.items.length);
        
        const totalLocals = argCount + localVars.length;
        let stackSpace = Math.ceil(totalLocals * 8 / 16) * 16;
        if (stackSpace > 0) {
            this.textSection.push(`    SUB sp, sp, #${stackSpace}`);
        }

        if (node.arguments && node.arguments.items) {
            node.arguments.items.forEach((arg, index) => {
                const argName = arg.identifier;
                if (index < 8) {
                    const offset = this.nextOffset;
                    this.nextOffset -= 8;
                    this.textSection.push(`    STR x${index}, [fp, #${offset}] // Save arg '${argName}'`);
                    this.scopes[0][argName] = { offset: offset, base: "fp" };
                }
            });
            
            node.arguments.items.forEach((arg, index) => {
                const argName = arg.identifier;
                if (index < 8 && arg.defaultValue) {
                    const offset = this.scopes[0][argName].offset;
                    const skipDefLabel = `.L_skip_def_${Math.random().toString(36).substr(2, 5)}`;
                    
                    const tmpReg = this.allocReg();
                    const defSentReg = this.allocReg();
                    
                    this.textSection.push(`    // Check default for '${argName}'`);
                    this.textSection.push(`    LDR x${tmpReg}, [fp, #${offset}]`);
                    this.textSection.push(`    ADRP x${defSentReg}, Sign_Default_Trigger_Sentinel`);
                    this.textSection.push(`    ADD  x${defSentReg}, x${defSentReg}, :lo12:Sign_Default_Trigger_Sentinel`);
                    this.textSection.push(`    CMP x${tmpReg}, x${defSentReg}`);
                    
                    this.freeReg(tmpReg);
                    this.freeReg(defSentReg);
                    
                    this.textSection.push(`    B.NE ${skipDefLabel}`);
                    
                    const defReg = this.visit(arg.defaultValue);
                    this.textSection.push(`    STR x${defReg}, [fp, #${offset}] // Update '${argName}' with default`);
                    this.freeReg(defReg);
                    
                    this.textSection.push(`${skipDefLabel}:`);
                }
            });
        }

        const bodyReg = this.visit(node.body);
        if (bodyReg !== 0 && bodyReg !== this.unitReg) {
            this.textSection.push(`    MOV x0, x${bodyReg}`);
        } else if (bodyReg === this.unitReg) {
            this.textSection.push(`    MOV x0, x28 // Return Unit`);
        }
        this.freeReg(bodyReg);

        this.textSection.push(`    // Epilogue`);
        this.textSection.push(`    MOV sp, fp`);
        this.textSection.push(`    LDP fp, lr, [sp], #16`);
        this.textSection.push(`    RET`);
        this.textSection.push(``);

        this.scopes = oldScopes;
        this.nextOffset = oldNextOffset;
        this.functions.push(...this.textSection);
        this.textSection = oldTextSection;

        return funcLabel;
    }

	visitLambda(node, name = null) {
        const freeVars = Array.from(this.getFreeVariables(node));
        const capturedVars = [];
        for (let v of freeVars) {
            const loc = this.resolveVar(v);
            if (loc) {
                capturedVars.push({ name: v, loc: loc });
            }
        }

        const envReg = this.allocReg();
        this.textSection.push(`    MOV x${envReg}, x27 // Env Ptr`);
        const envSize = Math.ceil(capturedVars.length * 8 / 16) * 16;
        
        capturedVars.forEach((v, idx) => {
            const vReg = this.allocReg();
            this.textSection.push(`    LDR x${vReg}, [${v.loc.base}, #${v.loc.offset}] // capture '${v.name}'`);
            this.textSection.push(`    STR x${vReg}, [x${envReg}, #${idx * 8}]`);
            this.freeReg(vReg);
        });
        if (envSize > 0) {
            this.textSection.push(`    ADD x27, x27, #${envSize}`);
        }

        const funcLabel = this.compileLambda(node, capturedVars, name);
        
        // Allocate Closure Object
        const closureReg = this.allocReg();
        this.textSection.push(`    MOV x${closureReg}, x27 // Closure Ptr`);
        
        const tmp = this.allocReg();
        this.textSection.push(`    MOV x${tmp}, #0xFFFC`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #16`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #32`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #48`);
        this.textSection.push(`    STR x${tmp}, [x27, #0] // TypeTag_Closure`);
        
        this.textSection.push(`    ADRP x${tmp}, ${funcLabel}`);
        this.textSection.push(`    ADD  x${tmp}, x${tmp}, :lo12:${funcLabel}`);
        this.textSection.push(`    STR x${tmp}, [x27, #8] // Func Ptr`);
        
        this.textSection.push(`    STR x${envReg}, [x27, #16] // Env Ptr`);
        
        this.textSection.push(`    ADD x27, x27, #32 // Advance Arena`);
        
        this.freeReg(tmp);
        this.freeReg(envReg);
        
        return closureReg;
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
            this.dataSection.push(`.section .rodata`);
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
            const loc = this.resolveVar(name);
            if (loc) {
                const resultReg = this.allocReg();
                this.textSection.push(`    LDR x${resultReg}, [${loc.base}, #${loc.offset}] // Load '${name}'`);
                return resultReg;
            } else {
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
        const argRegs = [];
        for (let arg of node.arguments) {
            argRegs.push(this.visit(arg));
        }

        argRegs.forEach((r, i) => {
            if (i < 8) {
                this.textSection.push(`    MOV x${i}, x${r}`);
            }
            this.freeReg(r);
        });

        if (node.callee.type === "Atom" && node.callee.dataType === "identifier") {
            const loc = this.resolveVar(node.callee.value);
            if (loc) {
                // Variable that contains closure
                const calleeReg = this.allocReg();
                this.textSection.push(`    LDR x${calleeReg}, [${loc.base}, #${loc.offset}]`);
                this.textSection.push(`    LDR x8, [x${calleeReg}, #16] // Env Ptr`);
                this.textSection.push(`    LDR x${calleeReg}, [x${calleeReg}, #8] // Func Ptr`);
                this.textSection.push(`    BLR x${calleeReg}`);
                this.freeReg(calleeReg);
            } else {
                // Global direct call
                this.textSection.push(`    BL .L_func_${node.callee.value}`);
            }
        } else {
            // Evaluated expression that returns a closure
            const calleeReg = this.visit(node.callee);
            
            const isClosureLabel = `.L_is_closure_${Math.random().toString(36).substr(2, 5)}`;
            const callLabel = `.L_call_${Math.random().toString(36).substr(2, 5)}`;
            
            const typeReg = this.allocReg();
            this.textSection.push(`    LDR x${typeReg}, [x${calleeReg}, #0]`);
            
            const closureSentinel = this.allocReg();
            this.textSection.push(`    MOV x${closureSentinel}, #0xFFFC`);
            this.textSection.push(`    MOVK x${closureSentinel}, #0xFFFF, LSL #16`);
            this.textSection.push(`    MOVK x${closureSentinel}, #0xFFFF, LSL #32`);
            this.textSection.push(`    MOVK x${closureSentinel}, #0xFFFF, LSL #48`);
            
            this.textSection.push(`    CMP x${typeReg}, x${closureSentinel}`);
            this.textSection.push(`    B.EQ ${isClosureLabel}`);
            
            this.textSection.push(`    BLR x${calleeReg}`);
            this.textSection.push(`    B ${callLabel}`);
            
            this.textSection.push(`${isClosureLabel}:`);
            this.textSection.push(`    LDR x8, [x${calleeReg}, #16] // Env Ptr`);
            this.textSection.push(`    LDR x${calleeReg}, [x${calleeReg}, #8] // Func Ptr`);
            this.textSection.push(`    BLR x${calleeReg}`);
            
            this.textSection.push(`${callLabel}:`);
            
            this.freeReg(typeReg);
            this.freeReg(closureSentinel);
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

    visitDictionary(node) {
        const numEntries = node.entries.length;
        const totalSize = (2 + numEntries * 2) * 8; // TypeTag + Length + (Key + Value)*N
        const alignedSize = Math.ceil(totalSize / 16) * 16;
        
        // 1. Evaluate keys (strings) and values
        const entryRegs = []; // [{ keyReg, valReg }]
        for (let entry of node.entries) {
            const cleanStr = entry.key.replace(/^`|`$/g, "");
            const label = `Sign_Str_${Math.random().toString(36).substr(2, 5)}`;
            this.dataSection.push(`.section .rodata`);
            this.dataSection.push(`.align 3`);
            this.dataSection.push(`${label}:`);
            this.dataSection.push(`    .quad ${cleanStr.length} // Length`);
            for (let i = 0; i < cleanStr.length; i++) {
                this.dataSection.push(`    .quad ${cleanStr.charCodeAt(i)} // '${cleanStr[i]}'`);
            }
            
            const keyReg = this.allocReg();
            this.textSection.push(`    ADRP x${keyReg}, ${label}`);
            this.textSection.push(`    ADD  x${keyReg}, x${keyReg}, :lo12:${label}`);
            
            const valReg = this.visit(entry.value);
            entryRegs.push({ keyReg, valReg });
        }

        // 2. The pointer to the new dictionary is in x27
        const resultReg = this.allocReg();
        this.textSection.push(`    MOV x${resultReg}, x27 // Dict pointer`);

        const tmp = this.allocReg();
        // TypeTag 0xFFFD
        this.textSection.push(`    MOV x${tmp}, #0xFFFD`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #16`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #32`);
        this.textSection.push(`    MOVK x${tmp}, #0xFFFF, LSL #48`);
        this.textSection.push(`    STR x${tmp}, [x27, #0] // TypeTag_Dict`);
        
        // Length
        this.textSection.push(`    MOV x${tmp}, #${numEntries}`);
        this.textSection.push(`    STR x${tmp}, [x27, #8] // Length`);
        this.freeReg(tmp);

        // Store Key-Value pairs
        entryRegs.forEach((pair, i) => {
            const keyOffset = 16 + i * 16;
            const valOffset = 24 + i * 16;
            this.textSection.push(`    STR x${pair.keyReg}, [x27, #${keyOffset}] // Store Key ${i}`);
            this.textSection.push(`    STR x${pair.valReg}, [x27, #${valOffset}] // Store Value ${i}`);
            this.freeReg(pair.keyReg);
            this.freeReg(pair.valReg);
        });

        // Advance Arena pointer x27
        this.textSection.push(`    ADD x27, x27, #${alignedSize} // Advance Arena`);

        return resultReg;
    }

    visitGet(node) {
        let currentReg = this.visit(node.target);
        
        for (let prop of node.properties) {
            let propName = null;
            if (typeof prop === "string") {
                propName = prop;
            } else if (prop.type === "Atom" && (prop.dataType === "identifier" || prop.dataType === "string")) {
                propName = prop.value;
            }

            if (propName !== null) {
                const cleanStr = propName.replace(/^`|`$/g, "");
                const label = `Sign_Str_${Math.random().toString(36).substr(2, 5)}`;
                this.dataSection.push(`.section .rodata`);
                this.dataSection.push(`.align 3`);
                this.dataSection.push(`${label}:`);
                this.dataSection.push(`    .quad ${cleanStr.length} // Length`);
                for (let i = 0; i < cleanStr.length; i++) {
                    this.dataSection.push(`    .quad ${cleanStr.charCodeAt(i)} // '${cleanStr[i]}'`);
                }
                
                const propKeyReg = this.allocReg();
                this.textSection.push(`    ADRP x${propKeyReg}, ${label}`);
                this.textSection.push(`    ADD  x${propKeyReg}, x${propKeyReg}, :lo12:${label}`);

                const resultReg = this.allocReg();
                const tmpReg = this.allocReg();
                
                this.textSection.push(`    LDR x${tmpReg}, [x${currentReg}, #0] // TypeTag`);
                
                const isDictLabel = `.L_is_dict_${Math.random().toString(36).substr(2, 5)}`;
                const notFoundLabel = `.L_dict_not_found_${Math.random().toString(36).substr(2, 5)}`;
                const endStrLabel = `.L_get_str_end_${Math.random().toString(36).substr(2, 5)}`;
                const loopLabel = `.L_dict_loop_${Math.random().toString(36).substr(2, 5)}`;
                
                const sentinelReg = this.allocReg();
                this.textSection.push(`    MOV x${sentinelReg}, #0xFFFD`);
                this.textSection.push(`    MOVK x${sentinelReg}, #0xFFFF, LSL #16`);
                this.textSection.push(`    MOVK x${sentinelReg}, #0xFFFF, LSL #32`);
                this.textSection.push(`    MOVK x${sentinelReg}, #0xFFFF, LSL #48`);
                
                this.textSection.push(`    CMP x${tmpReg}, x${sentinelReg}`);
                this.textSection.push(`    B.EQ ${isDictLabel}`);
                
                this.textSection.push(`    MOV x${resultReg}, x28 // Not a dict -> Unit`);
                this.textSection.push(`    B ${endStrLabel}`);
                
                this.textSection.push(`${isDictLabel}:`);
                this.freeReg(sentinelReg); // Free early
                
                const lenReg = this.allocReg();
                const iReg = this.allocReg();
                const ptrReg = this.allocReg();
                
                this.textSection.push(`    LDR x${lenReg}, [x${currentReg}, #8]`);
                this.textSection.push(`    MOV x${iReg}, #0`);
                this.textSection.push(`    ADD x${ptrReg}, x${currentReg}, #16`);
                
                this.textSection.push(`${loopLabel}:`);
                this.textSection.push(`    CMP x${iReg}, x${lenReg}`);
                this.textSection.push(`    B.GE ${notFoundLabel}`);
                
                const cmpStr1 = this.allocReg();
                const cmpLen1 = this.allocReg();
                const cmpLen2 = this.allocReg();
                const cmpI = this.allocReg();
                const cmpRes = this.allocReg();
                const cmpLoopLabel = `.L_strcmp_loop_${Math.random().toString(36).substr(2, 5)}`;
                const cmpEndLabel = `.L_strcmp_end_${Math.random().toString(36).substr(2, 5)}`;
                
                this.textSection.push(`    LDR x${cmpStr1}, [x${ptrReg}] // dict key ptr`);
                
                this.textSection.push(`    LDR x${cmpLen1}, [x${cmpStr1}]`);
                this.textSection.push(`    LDR x${cmpLen2}, [x${propKeyReg}]`);
                this.textSection.push(`    MOV x${cmpRes}, #0`);
                this.textSection.push(`    CMP x${cmpLen1}, x${cmpLen2}`);
                this.freeReg(cmpLen2); // Free early
                
                this.textSection.push(`    B.NE ${cmpEndLabel}`);
                
                this.textSection.push(`    MOV x${cmpI}, #0`);
                this.textSection.push(`${cmpLoopLabel}:`);
                this.textSection.push(`    CMP x${cmpI}, x${cmpLen1}`);
                this.textSection.push(`    B.GE 1f // match!`);
                
                const char1 = this.allocReg();
                const char2 = this.allocReg();
                this.textSection.push(`    ADD x${tmpReg}, x${cmpI}, #1`);
                this.textSection.push(`    LSL x${tmpReg}, x${tmpReg}, #3`);
                this.textSection.push(`    LDR x${char1}, [x${cmpStr1}, x${tmpReg}]`);
                this.textSection.push(`    LDR x${char2}, [x${propKeyReg}, x${tmpReg}]`);
                this.textSection.push(`    CMP x${char1}, x${char2}`);
                this.freeReg(char1);
                this.freeReg(char2);
                
                this.textSection.push(`    B.NE ${cmpEndLabel} // char differs`);
                
                this.textSection.push(`    ADD x${cmpI}, x${cmpI}, #1`);
                this.textSection.push(`    B ${cmpLoopLabel}`);
                
                this.textSection.push(`1:`);
                this.textSection.push(`    MOV x${cmpRes}, #1 // match = true`);
                this.textSection.push(`${cmpEndLabel}:`);
                
                this.freeReg(cmpStr1);
                this.freeReg(cmpLen1);
                this.freeReg(cmpI);
                
                this.textSection.push(`    CMP x${cmpRes}, #1`);
                this.textSection.push(`    B.EQ 2f // matched!`);
                
                this.freeReg(cmpRes);
                
                this.textSection.push(`    ADD x${ptrReg}, x${ptrReg}, #16`);
                this.textSection.push(`    ADD x${iReg}, x${iReg}, #1`);
                this.textSection.push(`    B ${loopLabel}`);
                
                this.textSection.push(`${notFoundLabel}:`);
                this.textSection.push(`    MOV x${resultReg}, x28 // Unit`);
                this.textSection.push(`    B ${endStrLabel}`);
                
                this.textSection.push(`2: // Matched`);
                this.textSection.push(`    LDR x${resultReg}, [x${ptrReg}, #8] // Value ptr`);
                
                this.textSection.push(`${endStrLabel}:`);
                
                this.freeReg(tmpReg);
                this.freeReg(lenReg);
                this.freeReg(iReg);
                this.freeReg(ptrReg);
                this.freeReg(propKeyReg);
                
                this.freeReg(currentReg);
                currentReg = resultReg;
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
            case "<<":
                this.textSection.push(`    FMOV d0, x${leftReg}`);
                this.textSection.push(`    FMOV d1, x${rightReg}`);
                this.textSection.push(`    FCVTZS x2, d0`); // Double to Int
                this.textSection.push(`    FCVTZS x3, d1`); // Double to Int
                this.textSection.push(`    LSL x4, x2, x3`);
                this.textSection.push(`    SCVTF d2, x4`); // Int to Double
                this.textSection.push(`    FMOV x${resultReg}, d2`);
                break;
            case ">>":
                this.textSection.push(`    FMOV d0, x${leftReg}`);
                this.textSection.push(`    FMOV d1, x${rightReg}`);
                this.textSection.push(`    FCVTZS x2, d0`);
                this.textSection.push(`    FCVTZS x3, d1`);
                this.textSection.push(`    ASR x4, x2, x3`);
                this.textSection.push(`    SCVTF d2, x4`);
                this.textSection.push(`    FMOV x${resultReg}, d2`);
                break;
            case "||":
                this.textSection.push(`    FMOV d0, x${leftReg}`);
                this.textSection.push(`    FMOV d1, x${rightReg}`);
                this.textSection.push(`    FCVTZS x2, d0`);
                this.textSection.push(`    FCVTZS x3, d1`);
                this.textSection.push(`    ORR x4, x2, x3`);
                this.textSection.push(`    SCVTF d2, x4`);
                this.textSection.push(`    FMOV x${resultReg}, d2`);
                break;
            case ";;":
                this.textSection.push(`    FMOV d0, x${leftReg}`);
                this.textSection.push(`    FMOV d1, x${rightReg}`);
                this.textSection.push(`    FCVTZS x2, d0`);
                this.textSection.push(`    FCVTZS x3, d1`);
                this.textSection.push(`    EOR x4, x2, x3`);
                this.textSection.push(`    SCVTF d2, x4`);
                this.textSection.push(`    FMOV x${resultReg}, d2`);
                break;
            case "&&":
                this.textSection.push(`    FMOV d0, x${leftReg}`);
                this.textSection.push(`    FMOV d1, x${rightReg}`);
                this.textSection.push(`    FCVTZS x2, d0`);
                this.textSection.push(`    FCVTZS x3, d1`);
                this.textSection.push(`    AND x4, x2, x3`);
                this.textSection.push(`    SCVTF d2, x4`);
                this.textSection.push(`    FMOV x${resultReg}, d2`);
                break;
            case "^":
                const powLoop = `.L_pow_loop_${Math.random().toString(36).substr(2, 5)}`;
                const powEnd = `.L_pow_end_${Math.random().toString(36).substr(2, 5)}`;
                this.textSection.push(`    FMOV d0, x${leftReg}`);
                this.textSection.push(`    FMOV d1, x${rightReg}`);
                this.textSection.push(`    FCVTZS x3, d1`);
                const tmpReg1 = this.allocReg();
                this.doubleToMovs(tmpReg1, 1.0);
                this.textSection.push(`    FMOV d2, x${tmpReg1} // res = 1.0`);
                this.freeReg(tmpReg1);
                this.textSection.push(`    CBZ x3, ${powEnd}`);
                this.textSection.push(`${powLoop}:`);
                this.textSection.push(`    FMUL d2, d2, d0`);
                this.textSection.push(`    SUB x3, x3, #1`);
                this.textSection.push(`    CBNZ x3, ${powLoop}`);
                this.textSection.push(`${powEnd}:`);
                this.textSection.push(`    FMOV x${resultReg}, d2`);
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
                const reg1 = this.allocReg();
                this.doubleToMovs(reg1, 1.0);
                this.textSection.push(`    CMP x${currentReg}, x28`);
                this.textSection.push(`    CSEL x${resultReg}, x${reg1}, x28, EQ`);
                this.freeReg(reg1);
            } else if (op === "!!") {
                this.textSection.push(`    FMOV d0, x${currentReg}`);
                this.textSection.push(`    FCVTZS x2, d0`);
                this.textSection.push(`    MVN x3, x2`);
                this.textSection.push(`    SCVTF d2, x3`);
                this.textSection.push(`    FMOV x${resultReg}, d2`);
            } else if (op === "$") {
                this.textSection.push(`    SCVTF d0, x${currentReg}`);
                this.textSection.push(`    FMOV x${resultReg}, d0`);
            } else if (op === "~") {
                this.textSection.push(`    // Prefix ~`);
                this.textSection.push(`    MOV x${resultReg}, x${currentReg}`);
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
                this.textSection.push(`    // Postfix ~`);
            } else if (op === "!") {
                const factLoop = `.L_fact_loop_${Math.random().toString(36).substr(2, 5)}`;
                const factEnd = `.L_fact_end_${Math.random().toString(36).substr(2, 5)}`;
                this.textSection.push(`    FMOV d0, x${currentReg}`);
                this.textSection.push(`    FCVTZS x2, d0 // n`);
                this.textSection.push(`    MOV x3, #1 // result`);
                this.textSection.push(`    CMP x2, #1`);
                this.textSection.push(`    B.LE ${factEnd}`);
                this.textSection.push(`${factLoop}:`);
                this.textSection.push(`    MUL x3, x3, x2`);
                this.textSection.push(`    SUB x2, x2, #1`);
                this.textSection.push(`    CMP x2, #1`);
                this.textSection.push(`    B.GT ${factLoop}`);
                this.textSection.push(`${factEnd}:`);
                this.textSection.push(`    SCVTF d2, x3`);
                this.textSection.push(`    FMOV x${currentReg}, d2`);
            } else {
                this.textSection.push(`    // TODO: Postfix ${op}`);
            }
        }
        return currentReg;
    }

    visitPrefix(node) {
        if (node.operators.length === 1 && node.operators[0] === "!" && node.expression.type === "Atom" && node.expression.dataType === "unit") {
            const reg = this.allocReg();
            this.textSection.push(`    ADRP x${reg}, Sign_Default_Trigger_Sentinel`);
            this.textSection.push(`    ADD  x${reg}, x${reg}, :lo12:Sign_Default_Trigger_Sentinel`);
            return reg;
        }
        
        this.textSection.push(`    // TODO: Unhandled Prefix -> ${node.operators.join()}`);
        return this.unitReg;
    }
}
