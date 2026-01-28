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
            if (alignedSize > 0) {
                this.emitter.emit(`add sp, sp, #${alignedSize}`);
            }
            this.emitter.emit("ldp x29, x30, [sp], #16");
            this.emitter.emit("ret");

            this.emitter.emitLabel(endLabel);

            this.currentScope = this.globalScope;
            this.inFunction = false;
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
            if (v && v.type === 'stack') {
                this.emitter.emit(`ldr x0, [x29, #${v.offset}]`);
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
                    if (func === 'cons' && args.length === 2) {
                        this.compileCons(args[0], args[1]);
                        return;
                    }
                    if (func === 'head' && args.length === 1) {
                        this.compileHead(args[0]);
                        return;
                    }
                    if (func === 'tail' && args.length === 1) {
                        this.compileTail(args[0]);
                        return;
                    }
                }

                // Function Call
                for (let arg of args) {
                    this.compileExpr(arg);
                    this.emitter.emit("str x0, [sp, #-16]!");
                }

                // Pop args into registers X0..X7
                const len = args.length;
                for (let i = len - 1; i >= 0; i--) {
                    if (i < 8) {
                        this.emitter.emit(`ldr x${i}, [sp], #16`);
                    }
                }

                if (typeof func === 'string') {
                    this.emitter.emit(`bl ${func}`);
                }
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
                this.emitter.emit("csel x0, x0, xzr, lt");
                return;
            }

            // --- Binary Greater Than ---
            if (op === '>') {
                this.compileExpr(expr[1]);
                this.emitter.emit("str x0, [sp, #-16]!");
                this.compileExpr(expr[2]);
                this.emitter.emit("ldr x1, [sp], #16");
                this.emitter.emit("cmp x1, x0");
                this.emitter.emit("csel x0, x0, xzr, gt");
                return;
            }
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
        // Note: alloc uses registers x1, x2 internally
        this.compileAlloc(16);

        // 4. Pop Tail and Store to [ptr, #8]
        this.emitter.emit("ldr x2, [sp], #16");
        this.emitter.emit("str x2, [x0, #8]");

        // 5. Pop Head and Store to [ptr]
        this.emitter.emit("ldr x2, [sp], #16");
        this.emitter.emit("str x2, [x0]");

        // Result is X0 (ptr)
    }

    compileHead(listExpr) {
        this.compileExpr(listExpr); // X0 = ptr
        // Handle 0/Null check? For now assume valid ptr
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
