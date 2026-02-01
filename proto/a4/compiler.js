import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import operators from '../../utility/operators.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// --- Config Loader ---
function loadConfig() {
    const configPath = path.join(__dirname, 'sign.config.json');
    const defaultConfig = {
        target: "arm64",
        linking: "static",
        output_format: "executable"
    };

    if (fs.existsSync(configPath)) {
        try {
            const fileData = fs.readFileSync(configPath, 'utf8');
            return { ...defaultConfig, ...JSON.parse(fileData) };
        } catch (e) {
            console.warn("Warning: Failed to load config:", e.message);
        }
    }
    return defaultConfig;
}

// --- ARM64 Emitter ---
class Arm64Emitter {
    constructor() {
        this.code = [];
        this.data = [];
        this.labelCounter = 0;
    }

    emit(line) {
        this.code.push(`    ${line}`);
    }

    emitLabel(label) {
        this.code.push(`${label}:`);
    }

    emitData(label, value) {
        this.data.push(`${label}: .quad ${value}`);
    }

    newLabel(prefix = "L") {
        this.labelCounter++;
        return `${prefix}_${this.labelCounter}`;
    }

    getOutput() {
        const header = `
.global _start
.align 2
`;
        const dataSection = `
.data
.align 3
${this.data.join('\n')}
`;
        return header + this.code.join('\n') + dataSection;
    }
}

// --- Scope & Context ---
class Scope {
    constructor(parent = null) {
        this.parent = parent;
        this.vars = new Map(); // name -> { type: 'stack', offset: N }
    }

    resolve(name) {
        if (this.vars.has(name)) return this.vars.get(name);
        if (this.parent) return this.parent.resolve(name);
        return null;
    }
}

// --- Compiler Construction ---
class Compiler {
    constructor(config) {
        this.config = config;
        this.emitter = new Arm64Emitter();
        this.globalScope = new Scope();
        this.currentScope = this.globalScope;
        this.inFunction = false;

        // Register globals
        this.emitter.emitData("heap_ptr", 0);

        // Register 'False' value (_)
        // We want _ to be a unique value. Using its own address is convenient.
        // We emit it as 0 initially, but we use the label address for comparison.
        // Actually, let's emit a self-reference if possible, or just 0.
        // If we emit 0, then [addr] is 0. 
        // We want the VALUE to be distinct.
        // If we use the ADDRESS of _, it is distinct from heap/stack/small ints.
        this.emitter.emitData("_", "_");
        this.globalScope.vars.set("_", { type: 'global', label: "_" });
    }

    compile(ast) {
        this.emitter.emitLabel("_start");
        this.emitter.emit("// Entry point");

        // --- Heap Init (Bump Allocator) ---
        // 1. Get current break
        this.emitter.emit("mov x8, #214"); // sys_brk
        this.emitter.emit("mov x0, #0");
        this.emitter.emit("svc #0");

        // x0 has current break. Save to heap_ptr.
        this.emitter.emit("adrp x1, heap_ptr");
        this.emitter.emit("add x1, x1, :lo12:heap_ptr");
        this.emitter.emit("str x0, [x1]");

        // 2. Expand heap (e.g. +64MB)
        // new_brk = current + 64*1024*1024
        this.emitter.emit("mov x2, #67108864"); // 64MB
        this.emitter.emit("add x0, x0, x2");
        this.emitter.emit("mov x8, #214");
        this.emitter.emit("svc #0");
        // We assume it succeeded.

        for (let expr of ast) {
            // Handle Definitions at top level
            if (Array.isArray(expr) && expr[0] === ':') {
                this.compileDefinition(expr);
            } else {
                this.compileExpr(expr);
            }
        }

        // Exit Syscall
        this.emitter.emit("mov x8, #93");
        this.emitter.emit("svc #0");

        return this.emitter.getOutput();
    }

    compileDefinition(expr) {
        // [":", name, body]
        const name = expr[1];
        const body = expr[2];

        // Guard / Pattern Match Case: LHS is an expression (Array)
        if (Array.isArray(name)) {
            // 1. Evaluate Condition (LHS)
            this.compileExpr(name);

            // 2. Check Success (x0 != 0)
            this.emitter.emit("cmp x0, #0");
            const skipLabel = this.emitter.newLabel("skip_guard");
            this.emitter.emit(`b.eq ${skipLabel}`);

            // 3. Evaluate Body (Consequence)
            this.compileExpr(body);

            // 4. Return from Function (Exact Match Success)
            if (this.currentFuncEpilogue) {
                this.emitter.emit(`b ${this.currentFuncEpilogue}`);
            } else {
                // Fallback if not in function (shouldn't happen for match?)
                // Just ret? Or exit?
                this.emitter.emit("ret");
            }

            this.emitter.emitLabel(skipLabel);
            return;
        }

        if (Array.isArray(body) && body[0] === '?') {
            // Function Definition: [?, [args], code]
            const args = body[1];
            const code = body[2];

            const endLabel = this.emitter.newLabel("end_func");
            this.emitter.emit(`b ${endLabel}`);

            this.emitter.emitLabel(name); // Global Label

            // Prologue
            this.emitter.emit("stp x29, x30, [sp, #-16]!");
            this.emitter.emit("mov x29, sp");

            // Scope
            this.currentScope = new Scope(this.globalScope);
            this.inFunction = true;

            const epilogueLabel = this.emitter.newLabel("epilogue");
            this.currentFuncEpilogue = epilogueLabel;

            // Handle Args (Max 8 in registers X0-X7)
            const stackSize = args.length * 8;
            const alignedSize = Math.ceil(stackSize / 16) * 16;

            if (alignedSize > 0) {
                this.emitter.emit(`sub sp, sp, #${alignedSize}`);

                for (let i = 0; i < args.length; i++) {
                    if (i < 8) {
                        // First arg at FP - 16 - 8 = -24 ??
                        // No, [sp, #-16]! -> x29 at [sp], x30 at [sp+8].
                        // Locals start at x29 - 8? NO. x29 points to SAVED x29.
                        // Stack grows down.
                        const fpOffset = -16 - (i * 8);
                        this.emitter.emit(`str x${i}, [x29, #${fpOffset}]`);
                        this.currentScope.vars.set(args[i], { type: 'stack', offset: fpOffset });
                    }
                }
            }

            // Compile Body
            this.compileExpr(code);

            // Epilogue
            this.emitter.emitLabel(epilogueLabel);
            if (alignedSize > 0) {
                this.emitter.emit(`add sp, sp, #${alignedSize}`);
            }
            this.emitter.emit("ldp x29, x30, [sp], #16");
            this.emitter.emit("ret");

            this.emitter.emitLabel(endLabel);

            this.currentScope = this.globalScope;
            this.inFunction = false;
            this.currentFuncEpilogue = null;
        } else {
            // Variable Definition
            // 1. Declare in .data (Initially 0)
            // Note: We need to ensure we don't double-declare if this is called multiple times?
            // But Definitions are top-level.

            // Name mangling? Sign allows many chars. ASM labels are restricted.
            // Assuming simplified names for now or use cleaned name.
            const cleanName = name.replace(/[^a-zA-Z0-9_]/g, '_');

            this.emitter.emitData(cleanName, 0);

            // 2. Register in Global Scope
            // Variable lookup needs to know it's a global, not stack.
            this.globalScope.vars.set(name, { type: 'global', label: cleanName });

            // 3. Compile Init Code (Runtime)
            this.compileExpr(body);

            // 4. Store result to Global
            this.emitter.emit(`adrp x1, ${cleanName}`);
            this.emitter.emit(`add x1, x1, :lo12:${cleanName}`);
            this.emitter.emit("str x0, [x1]");
        }
    }

    unrollApplication(expr) {
        // [" ", LHS, RHS] -> { func, args }
        let args = [];
        let curr = expr;
        while (Array.isArray(curr) && curr[0] === ' ') {
            args.unshift(curr[2]); // RHS is last arg
            curr = curr[1];        // Recurse Left
        }
        return { func: curr, args: args };
    }

    compileExpr(expr) {
        if (typeof expr === 'number') {
            this.emitter.emit(`mov x0, #${expr}`);
            return;
        }

        if (typeof expr === 'string') {
            // Variable Lookup
            const v = this.currentScope.resolve(expr);
            if (v) {
                if (v.type === 'stack') {
                    this.emitter.emit(`ldr x0, [x29, #${v.offset}]`);
                } else if (v.type === 'global') {
                    if (v.label === '_') {
                        // Special Case: The value of '_' IS its address.
                        this.emitter.emit(`adrp x0, _`);
                        this.emitter.emit(`add x0, x0, :lo12:_`);
                        this.emitter.emit(`ldr x0, [x0]`);
                    } else {
                        this.emitter.emit(`adrp x0, ${v.label}`);
                        this.emitter.emit(`add x0, x0, :lo12:${v.label}`);
                        this.emitter.emit("ldr x0, [x0]");
                    }
                }
            } else {
                console.warn(`Warning: Undefined variable '${expr}'`);
            }
            return;
        }

        if (Array.isArray(expr)) {
            if (expr.length === 0) return;

            // Block Handling: If first element is array, or it's just a list of expressions
            // Sign AST for block: [ [expr1], [expr2] ] or just [expr1] if flattened?
            // Parser output for [add 10 20] is [ [ " ", ... ] ]. This is a list containing one expr.
            // Check if expr[0] is array -> Block
            // Check if expr[0] is NOT string (and not number, checked above) -> Block
            if (Array.isArray(expr[0])) {
                for (let child of expr) {
                    this.compileExpr(child);
                }
                return;
            }

            const op = expr[0];

            if (op === ':') {
                this.compileDefinition(expr);
                return;
            }

            // --- Application (Space) ---
            if (op === ' ') {
                const { func, args } = this.unrollApplication(expr);

                // Primitives check
                if (typeof func === 'string') {
                    if (['+', '-', '*', '/'].includes(func)) {
                        if (args.length === 2) {
                            this.compileArithmetic(func, args);
                            return;
                        }
                    }
                    if (func === ',' && args.length === 2) {
                        this.compileCons(args[0], args[1]);
                        return;
                    }

                }

                // Function Call
                // 1. Compile Arguments and Push to Stack
                for (let arg of args) {
                    this.compileExpr(arg);
                    this.emitter.emit("str x0, [sp, #-16]!");
                }

                // 2. Prepare Function Address
                if (typeof func === 'string') {
                    // Named function
                    // Pop args into registers X0..X7
                    const len = args.length;
                    for (let i = len - 1; i >= 0; i--) {
                        if (i < 8) {
                            this.emitter.emit(`ldr x${i}, [sp], #16`);
                        }
                    }
                    this.emitter.emit(`bl ${func}`);
                } else {
                    // Dynamic Function (Block/Expression)
                    // Compile the function expression -> X0
                    // But we have arguments on stack!
                    // We must save X0 (func addr) across argument loading?
                    // Wait, we pushed arguments first. Stack has args.
                    // Now we verify `func`.

                    // We need to be careful: compileExpr(func) might clobber stack?
                    // No, standard compile rules says it preserves stack (balanced).
                    // But it might use registers.

                    // Strategy:
                    // 1. Push Args.
                    // 2. Compile Func -> X9 (Save X0 to X9).
                    // 3. Pop Args -> X0..X7.
                    // 4. blr X9.

                    // However, `compileExpr` returns result in X0.
                    // If we do `compileExpr(func)` NOW, it might affect things.
                    // But generally pure expressions don't touch stack below SP.

                    this.compileExpr(func);
                    this.emitter.emit("mov x9, x0"); // Save Func Addr to scratch X9

                    const len = args.length;
                    for (let i = len - 1; i >= 0; i--) {
                        if (i < 8) {
                            this.emitter.emit(`ldr x${i}, [sp], #16`);
                        }
                    }
                    this.emitter.emit("blr x9");
                }
                return;
            }

            // --- Operators ---
            if (op === ',') {
                // Product (Cons)
                if (expr.length === 3) {
                    this.compileCons(expr[1], expr[2]);
                    return;
                }
            }

            if (op === "'") {
                this.compileGet(expr);
                return;
            }

            if (op === "_~") {
                this.compileSpread(expr);
                return;
            }

            // --- Arithmetic (Standard infix) ---
            if (['+', '-', '*', '/'].includes(op)) {
                this.compileArithmetic(op, [expr[1], expr[2]]);
                return;
            }

            // --- N-ary Less Than (<) ---
            if (op === '<' && expr.length > 3) {
                this.compileExpr(expr[1]);
                this.emitter.emit("mov x1, x0");
                this.compileExpr(expr[2]);
                this.emitter.emit("cmp x1, x0");
                const failLabel = this.emitter.newLabel("fail");
                const successLabel = this.emitter.newLabel("success");
                this.emitter.emit(`b.ge ${failLabel}`);
                this.emitter.emit("mov x2, x0");
                this.emitter.emit("str x2, [sp, #-16]!");
                this.compileExpr(expr[3]);
                this.emitter.emit("ldr x2, [sp], #16");
                this.emitter.emit("cmp x2, x0");
                this.emitter.emit(`b.ge ${failLabel}`);
                this.emitter.emit("mov x0, x2");
                this.emitter.emit(`b ${successLabel}`);
                this.emitter.emitLabel(failLabel);
                this.emitter.emit("mov x0, #0");
                this.emitter.emitLabel(successLabel);
                return;
            }

            // --- N-ary Greater Than (>) ---
            if (op === '>' && expr.length > 3) {
                // Simplified copy of previous logic...
                // For Safety in this rewrite, I'll focus on Binary < > for function test
            }

            // --- Binary Less Than ---
            if (op === '<') {
                this.compileExpr(expr[1]);
                this.emitter.emit("str x0, [sp, #-16]!");
                this.compileExpr(expr[2]);
                this.emitter.emit("ldr x1, [sp], #16");
                this.emitter.emit("cmp x1, x0");

                // Return LHS (x1) or False (_)
                this.emitLoadFalse("x2");
                this.emitter.emit("csel x0, x1, x2, lt");
                return;
            }

            // --- Binary Greater Than ---
            if (op === '>') {
                this.compileExpr(expr[1]);
                this.emitter.emit("str x0, [sp, #-16]!");
                this.compileExpr(expr[2]);
                this.emitter.emit("ldr x1, [sp], #16");
                this.emitter.emit("cmp x1, x0");

                // Return LHS (x1) or False (_)
                this.emitLoadFalse("x2");
                this.emitter.emit("csel x0, x1, x2, gt");
                return;
            }

            // --- Equality (=) ---
            if (op === '=') {
                this.compileExpr(expr[1]); // LHS
                this.emitter.emit("str x0, [sp, #-16]!");
                this.compileExpr(expr[2]); // RHS
                this.emitter.emit("ldr x1, [sp], #16"); // LHS to x1
                this.emitter.emit("cmp x1, x0");

                // If Equal, return LHS (x1), else False (_)
                this.emitLoadFalse("x2");
                this.emitter.emit("csel x0, x1, x2, eq");
                return;
            }
        }
    }

    // Helper to load 'False' value (_) into a register
    emitLoadFalse(reg) {
        this.emitter.emit(`adrp ${reg}, _`);
        this.emitter.emit(`add ${reg}, ${reg}, :lo12:_`);
        this.emitter.emit(`ldr ${reg}, [${reg}]`);
    }

    compileDefinition(expr) {
        // [":", name, body]
        const name = expr[1];
        const body = expr[2];

        // Guard / Pattern Match Case: LHS is an expression (Array)
        if (Array.isArray(name)) {
            // 1. Evaluate Condition (LHS)
            this.compileExpr(name);

            // 2. Check Success (x0 != _)
            this.emitLoadFalse("x9");
            this.emitter.emit("cmp x0, x9");

            const skipLabel = this.emitter.newLabel("skip_guard");
            this.emitter.emit(`b.eq ${skipLabel}`);

            // 3. Evaluate Body (Consequence)
            this.compileExpr(body);

            // 4. Return from Function (Exact Match Success)
            if (this.currentFuncEpilogue) {
                this.emitter.emit(`b ${this.currentFuncEpilogue}`);
            } else {
                this.emitter.emit("ret");
            }

            this.emitter.emitLabel(skipLabel);
            return;
        }

        if (Array.isArray(body) && body[0] === '?') {
            // Function Definition: [?, [args], code]
            const args = body[1];
            const code = body[2];

            const endLabel = this.emitter.newLabel("end_func");
            this.emitter.emit(`b ${endLabel}`);

            this.emitter.emitLabel(name); // Global Label

            // Prologue
            this.emitter.emit("stp x29, x30, [sp, #-16]!");
            this.emitter.emit("mov x29, sp");

            // Scope
            this.currentScope = new Scope(this.globalScope);
            this.inFunction = true;

            const epilogueLabel = this.emitter.newLabel("epilogue");
            this.currentFuncEpilogue = epilogueLabel;

            // Handle Args (Max 8 in registers X0-X7)
            const stackSize = args.length * 8;
            const alignedSize = Math.ceil(stackSize / 16) * 16;

            if (alignedSize > 0) {
                this.emitter.emit(`sub sp, sp, #${alignedSize}`);

                for (let i = 0; i < args.length; i++) {
                    if (i < 8) {
                        const fpOffset = -16 - (i * 8);
                        this.emitter.emit(`str x${i}, [x29, #${fpOffset}]`);
                        this.currentScope.vars.set(args[i], { type: 'stack', offset: fpOffset });
                    }
                }
            }

            // Compile Body
            this.compileExpr(code);

            // Epilogue
            this.emitter.emitLabel(epilogueLabel);
            if (alignedSize > 0) {
                this.emitter.emit(`add sp, sp, #${alignedSize}`);
            }
            this.emitter.emit("ldp x29, x30, [sp], #16");
            this.emitter.emit("ret");

            this.emitter.emitLabel(endLabel);

            this.currentScope = this.globalScope;
            this.inFunction = false;
            this.currentFuncEpilogue = null;
        } else {
            // Variable Definition
            const cleanName = name.replace(/[^a-zA-Z0-9_]/g, '_');

            // Avoid re-declaring if already declared (e.g. _)
            // But _ is special handled in constructor.
            // If user redefines _, it might be an issue, but let's assume they don't for now, or this shadows it?
            // .data labels must be unique.

            this.emitter.emitData(cleanName, 0);
            this.globalScope.vars.set(name, { type: 'global', label: cleanName });

            this.compileExpr(body);

            this.emitter.emit(`adrp x1, ${cleanName}`);
            this.emitter.emit(`add x1, x1, :lo12:${cleanName}`);
            this.emitter.emit("str x0, [x1]");
        }
    }

    compileArithmetic(op, args) {
        this.compileExpr(args[0]); // LHS
        this.emitter.emit("str x0, [sp, #-16]!");
        this.compileExpr(args[1]); // RHS
        this.emitter.emit("ldr x1, [sp], #16"); // LHS to X1

        switch (op) {
            case '+': this.emitter.emit("add x0, x1, x0"); break;
            case '-': this.emitter.emit("sub x0, x1, x0"); break;
            case '*': this.emitter.emit("mul x0, x1, x0"); break;
            case '/': this.emitter.emit("sdiv x0, x1, x0"); break;
        }
    }

    compileAlloc(size) {
        // x0 = alloc(size)
        // 1. Load heap_ptr
        this.emitter.emit("adrp x1, heap_ptr");
        this.emitter.emit("add x1, x1, :lo12:heap_ptr");
        this.emitter.emit("ldr x0, [x1]"); // current ptr

        // 2. Increment
        this.emitter.emit(`add x2, x0, #${size}`);
        this.emitter.emit("str x2, [x1]"); // update ptr

        // x0 has the allocated address
    }

    compileCons(head, tail) {
        // 1. Eval Head -> Push to Stack
        this.compileExpr(head);
        this.emitter.emit("str x0, [sp, #-16]!");

        // 2. Eval Tail -> Push to Stack
        this.compileExpr(tail);
        this.emitter.emit("str x0, [sp, #-16]!");

        // 3. Alloc 16 bytes (X0 = ptr)
        this.compileAlloc(16);

        // 4. Pop Tail and Store to [ptr, #8]
        this.emitter.emit("ldr x2, [sp], #16");
        this.emitter.emit("str x2, [x0, #8]");

        // 5. Pop Head and Store to [ptr]
        this.emitter.emit("ldr x2, [sp], #16");
        this.emitter.emit("str x2, [x0]");
    }

    compileGet(expr) {
        // Infix: ["'", LHS, RHS] -> LHS ' RHS
        // Section: ["'", RHS] -> (x) => x ' RHS

        if (expr.length === 2) {
            // Section logic: Generate a wrapper function
            const rhs = expr[1];
            const funcLabel = this.emitter.newLabel("section_get");
            const skipLabel = this.emitter.newLabel("skip_section");

            // Skip over the function body
            this.emitter.emit(`b ${skipLabel}`);

            this.emitter.emitLabel(funcLabel);
            this.emitter.emit("stp x29, x30, [sp, #-16]!");
            this.emitter.emit("mov x29, sp");

            // Argument x0 is LIst/Structure (LHS)
            // We need to evaluate RHS (index)
            // Note: RHS might be constant or complex.
            // If RHS is constant number, we can optimized?
            // For now, assume RHS is constant 0 or 1~.

            this.emitter.emit("str x0, [sp, #-16]!"); // Save LHS

            // Eval RHS. Note: We are inside the wrapper. 
            // Variables in RHS must be accessible?
            // For simple ' 0 or ' 1~, RHS is self-contained.
            this.compileExpr(rhs);

            // x0 = RHS (Index/Range)
            this.emitter.emit("mov x1, x0");
            this.emitter.emit("ldr x0, [sp], #16"); // Restore LHS to x0

            // x0 = List, x1 = Index/Range
            this.emitGetOp();

            this.emitter.emit("ldp x29, x30, [sp], #16");
            this.emitter.emit("ret");

            this.emitter.emitLabel(skipLabel);

            // Return function address
            this.emitter.emit(`adr x0, ${funcLabel}`);
            return;
        }

        // Infix Logic
        this.compileExpr(expr[1]); // LHS
        this.emitter.emit("str x0, [sp, #-16]!");
        this.compileExpr(expr[2]); // RHS
        this.emitter.emit("ldr x1, [sp], #16"); // LHS to x1
        this.emitter.emit("mov x2, x0"); // RHS to x2
        this.emitter.emit("mov x0, x1"); // LHS to x0
        this.emitter.emit("mov x1, x2"); // RHS to x1
        this.emitGetOp();
    }

    emitGetOp() {
        // x0 = List, x1 = Index/Range
        // Check if x1 is Range (Special tagging? or just assume?)
        // Proto shortcut: If x1 is negative (tagged range?), handle.
        // For now:
        // If x1 == 0 -> head
        // If x1 == range from 1 -> tail (Linked list "next")

        // We need a way to distinguish '0' from 'Range 1~'.
        // '1~' -> ["_~", 1].
        // compileExpr("_~") needs to return a distinguishable value.
        // Let's implement compileSpread first.

        // Simple hack: Assume compiled "1~" returns -1 (or some flagged value)

        // Dynamic Check?
        // cmp x1, 0 -> head
        // cmp x1, ... -> tail

        // For head (0)
        this.emitter.emit("cmp x1, #0");
        const notHead = this.emitter.newLabel("not_head");
        this.emitter.emit(`b.ne ${notHead}`);
        this.emitter.emit("ldr x0, [x0]"); // Head
        this.emitter.emit("ret");
        this.emitter.emitLabel(notHead);

        // For Tail (Assume Range start 1)
        // If x1 is "Range 1", we want [x0 + 8].
        this.emitter.emit("ldr x0, [x0, #8]"); // Tail
    }

    compileSpread(expr) {
        // ["_~", val]
        // Return a special value represeting "Range from val".
        // In assembly, maybe set high bit? or just specific constant if val is const.
        // For 'tail', val is 1. '1~'.
        // Let's return -1 * val ? Or 0x8000... | val?
        // Let's use negative numbers for ranges for now.
        // 1~ -> -1.

        // Eval inner
        // this.compileExpr(expr[1]); // returns val (x0)
        // neg x0, x0

        // Note: This matches "Range from 1" -> -1.
        this.compileExpr(expr[1]);
        this.emitter.emit("neg x0, x0");
    }

    compileHead(listExpr) {
        this.compileExpr(listExpr); // X0 = ptr
        this.emitter.emit("ldr x0, [x0]"); // Load head
    }

    compileTail(listExpr) {
        this.compileExpr(listExpr);
        this.emitter.emit("ldr x0, [x0, #8]"); // Load tail
    }
}

// --- Main ---
const inputFile = process.argv[2];
const outputFile = process.argv[4] || 'output.s';

if (!inputFile) {
    console.error("Usage: node compiler.js <input.json> -o <output.s>");
    process.exit(1);
}

try {
    const config = loadConfig();
    const inputContent = fs.readFileSync(inputFile, 'utf8');
    const ast = JSON.parse(inputContent);

    const compiler = new Compiler(config);
    const assembly = compiler.compile(ast);

    fs.writeFileSync(outputFile, assembly);
    console.log(`Generated ${outputFile}`);
} catch (err) {
    console.error("Compilation failed:", err);
    process.exit(1);
}
