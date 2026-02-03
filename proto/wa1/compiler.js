import fs from 'fs';
import path from 'path';

// --- Wasm Constants ---
const SECTION = {
    TYPE: 1,
    IMPORT: 2,
    FUNCTION: 3,
    TABLE: 4,
    MEMORY: 5,
    GLOBAL: 6,
    EXPORT: 7,
    CODE: 10,
    DATA: 11,
    DATA: 11
};

const VALTYPE = {
    I32: 0x7F,
    F64: 0x7C
};

const OP = {
    END: 0x0B,
    CALL: 0x10,
    DROP: 0x1A,
    GET_LOCAL: 0x20,
    SET_LOCAL: 0x21,
    TEE_LOCAL: 0x22,
    GET_GLOBAL: 0x23,
    SET_GLOBAL: 0x24,

    I32_LOAD: 0x28,
    I32_STORE: 0x36,
    F64_LOAD: 0x2B,
    F64_STORE: 0x39,

    I32_CONST: 0x41,
    F64_CONST: 0x44,
    I32_EQZ: 0x45,
    I32_ADD: 0x6A,
    I32_SUB: 0x6B,
    I32_MUL: 0x6C,
    I32_DIV_S: 0x6D,

    F64_ADD: 0xA0,
    F64_SUB: 0xA1,
    F64_MUL: 0xA2,
    F64_DIV: 0xA3,
    F64_ABS: 0x99,
    F64_EQ: 0x61, // f64.eq -> i32
    F64_NE: 0x62,
    F64_LT: 0x63,
    F64_GT: 0x64,
    F64_LE: 0x65,
    F64_GE: 0x66,
    F64_CONVERT_I32_S: 0xB7, // i32 -> f64
    F64_TRUNC: 0x9D, // f64.trunc
    I32_TRUNC_F64_S: 0xAA, // f64 -> i32 (0xAA signed)

    IF: 0x04,
    ELSE: 0x05,
    BLOCK: 0x02,
    BR: 0x0C,
    BR_IF: 0x0D
};

// --- Wasm Emitter ---
class WasmEmitter {
    constructor() {
        this.buffer = [];
    }

    // LEB128 Encoding
    encodeULEB128(value) {
        const bytes = [];
        value |= 0;
        do {
            let byte = value & 0x7F;
            value >>>= 7;
            if (value !== 0) byte |= 0x80;
            bytes.push(byte);
        } while (value !== 0);
        return bytes;
    }

    encodeSLEB128(value) {
        const bytes = [];
        value |= 0;
        let more = true;
        while (more) {
            let byte = value & 0x7F;
            value >>= 7;
            if ((value === 0 && (byte & 0x40) === 0) || (value === -1 && (byte & 0x40) !== 0)) {
                more = false;
            } else {
                byte |= 0x80;
            }
            bytes.push(byte);
        }
        return bytes;
    }

    encodeF64(value) {
        const buffer = new ArrayBuffer(8);
        new DataView(buffer).setFloat64(0, value, true); // Little endian
        return Array.from(new Uint8Array(buffer));
    }

    encodeString(str) {
        const bytes = [];
        for (let i = 0; i < str.length; i++) {
            bytes.push(str.charCodeAt(i)); // Simple ASCII for now
        }
        return [...this.encodeULEB128(bytes.length), ...bytes];
    }

    encodeVector(elements) {
        let bytes = [...this.encodeULEB128(elements.length)];
        for (const el of elements) {
            bytes = bytes.concat(el);
        }
        return bytes;
    }

    encodeSection(id, payload) {
        return [id, ...this.encodeULEB128(payload.length), ...payload];
    }
}

// --- Compiler ---
class Compiler {
    constructor() {
        this.imports = []; // List of {module, name, desc}
        this.exports = []; // List of {name, idx, kind}
        this.functions = []; // List of {typeIdx, locals, body}
        this.types = []; // List of {params, results} signature string for dedup
        this.typeMap = new Map(); // Sig -> Idx

        this.funcNameMap = new Map(); // Name -> FuncIdx
        this.currentLocals = new Map(); // Name -> LocalIdx

        // Memory & Globals
        this.globals = []; // {type, mutable, initExpr}
        this.data = []; // {offset, bytes}
        this.memoryPages = 1;

        // String Literals Support
        this.stringTable = new Map(); // "`Hello`" -> offset
        this.dataBytes = [];
        this.dataStartOffset = 0; // Strings start at 0
        this.heapStartOffset = 1024;

        // Reserve Global 0 for Heap Pointer
        this.heapPtrIdx = 0;
        // Start heap at 1024 to avoid 0 (NULL) confusion and overlap
        this.globals.push({ type: VALTYPE.I32, mutable: true, init: [OP.I32_CONST, ...new WasmEmitter().encodeSLEB128(this.heapStartOffset), OP.END] });

        // Export Memory
        this.exports.push({ name: "memory", idx: 0, kind: 0x02 }); // Kind 0x02 = Memory

        // Inject Imports First
        this.injectImports();
        // Inject Runtime Functions
        this.injectRuntime();
    }

    getTypeIdx(params, results) {
        const sig = `${params.join(',')}:${results.join(',')}`;
        if (this.typeMap.has(sig)) return this.typeMap.get(sig);

        const idx = this.types.length;
        this.types.push({ params, results });
        this.typeMap.set(sig, idx);
        return idx;
    }

    injectRuntime() {
        // Base Index for internal functions overrides imports
        const baseIdx = this.imports.length;

        // 1. Alloc (i32 size -> i32 ptr)
        // returns old_heap_ptr, updates heap_ptr += size
        const allocName = "alloc";
        const allocIdx = baseIdx + this.functions.length; // 0 + N
        this.funcNameMap.set(allocName, allocIdx);

        const allocBody = [
            OP.GET_GLOBAL, ...new WasmEmitter().encodeULEB128(this.heapPtrIdx),
            OP.GET_GLOBAL, ...new WasmEmitter().encodeULEB128(this.heapPtrIdx),
            OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(0),
            OP.I32_ADD,
            OP.SET_GLOBAL, ...new WasmEmitter().encodeULEB128(this.heapPtrIdx),
            // We need to return the OLD ptr.
            // Stack above: [ptr, ptr, size] -> [ptr, new_ptr] -> [ptr].
            // But we consumed `ptr` in `SET_GLOBAL`? I32_ADD consumes 2, produces 1.
            // Stack: [ptr, ptr] --get_local--> [ptr, ptr, size] --add--> [ptr, new_ptr] --set--> [ptr].
            // YES. 
            // Note: I32 type for alloc.
        ];
        // Register Alloc
        const allocTypeIdx = this.getTypeIdx([VALTYPE.I32], [VALTYPE.I32]);
        this.functions.push({
            typeIdx: allocTypeIdx,
            locals: [],
            body: [...allocBody, OP.END]
        });
        // We don't export alloc for now, or maybe as 'malloc'?
        this.exports.push({ name: allocName, idx: allocIdx, kind: 0x00 });

        // 2. Cons (f64 head, f64 tail -> f64 ptr)
        // Alloc 16 bytes. Store head at +0, tail at +8. Return ptr.
        const consName = "cons";
        const consIdx = baseIdx + this.functions.length;
        this.funcNameMap.set(consName, consIdx);

        const consBody = [
            // 1. Get Heap Ptr -> Local 2
            OP.GET_GLOBAL, ...new WasmEmitter().encodeULEB128(this.heapPtrIdx),
            OP.SET_LOCAL, ...new WasmEmitter().encodeULEB128(2),

            // 2. Advance Heap +16
            OP.GET_GLOBAL, ...new WasmEmitter().encodeULEB128(this.heapPtrIdx),
            OP.I32_CONST, ...new WasmEmitter().encodeSLEB128(16),
            OP.I32_ADD,
            OP.SET_GLOBAL, ...new WasmEmitter().encodeULEB128(this.heapPtrIdx),

            // 3. Store Head (ptr=local2 + 0) = local 0
            OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(2), // ptr
            OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(0), // head
            OP.F64_STORE, 2, ...new WasmEmitter().encodeULEB128(0),

            // 4. Store Tail (ptr=local2 + 8) = local 1
            OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(2), // ptr
            OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(1), // tail
            OP.F64_STORE, 2, ...new WasmEmitter().encodeULEB128(8),

            // 5. Return Ptr (as F64)
            OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(2),
            OP.F64_CONVERT_I32_S
        ];

        const consTypeIdx = this.getTypeIdx([VALTYPE.F64, VALTYPE.F64], [VALTYPE.F64]);
        this.functions.push({
            typeIdx: consTypeIdx,
            locals: [{ count: 1, type: VALTYPE.I32 }], // idx 2
            body: [...consBody, OP.END]
        });
        this.exports.push({ name: consName, idx: consIdx, kind: 0x00 });

        // 3. Head (f64 ptr -> f64 val)
        const headName = "head";
        const headIdx = baseIdx + this.functions.length;
        this.funcNameMap.set(headName, headIdx);

        const headBody = [
            OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(0), // ptr (f64)
            OP.I32_TRUNC_F64_S, // f64 -> i32 (0x9C, wait, check OP)
            // Add OP.I32_TRUNC_F64_S = 0x9C
            OP.F64_LOAD, 2, ...new WasmEmitter().encodeULEB128(0) // load at +0
        ];
        const headTypeIdx = this.getTypeIdx([VALTYPE.F64], [VALTYPE.F64]);
        this.functions.push({
            typeIdx: headTypeIdx,
            locals: [],
            body: [...headBody, OP.END] // 0 locals
        });
        this.exports.push({ name: headName, idx: headIdx, kind: 0x00 });

        // 4. Tail (f64 ptr -> f64 val)
        const tailName = "tail";
        const tailIdx = baseIdx + this.functions.length;
        this.funcNameMap.set(tailName, tailIdx);
        const tailBody = [
            OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(0),
            OP.I32_TRUNC_F64_S,
            OP.F64_LOAD, 2, ...new WasmEmitter().encodeULEB128(8) // load at +8
        ];
        this.functions.push({
            typeIdx: headTypeIdx, // Same sig
            locals: [],
            body: [...tailBody, OP.END]
        });
        this.exports.push({ name: tailName, idx: tailIdx, kind: 0x00 });

        // 5. Range (start, end) -> list
        const rangeName = "range";
        const rangeIdx = baseIdx + this.functions.length;
        this.funcNameMap.set(rangeName, rangeIdx);
        // Recursive range implementation
        const rangeBody = [
            // if start > end : return NaN
            OP.GET_LOCAL, 0, // start
            OP.GET_LOCAL, 1, // end
            OP.F64_GT,
            OP.IF, VALTYPE.F64,
            OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN),
            OP.ELSE,
            // return cons(start, range(start + 1, end))
            OP.GET_LOCAL, 0, // cons param 1: start

            OP.GET_LOCAL, 0, // start for +1
            OP.F64_CONST, ...new WasmEmitter().encodeF64(1.0),
            OP.F64_ADD, // start + 1
            OP.GET_LOCAL, 1, // end
            OP.CALL, ...new WasmEmitter().encodeULEB128(rangeIdx), // recursive call

            OP.CALL, ...new WasmEmitter().encodeULEB128(consIdx), // call cons
            OP.END
        ];
        const rangeTypeIdx = this.getTypeIdx([VALTYPE.F64, VALTYPE.F64], [VALTYPE.F64]);
        this.functions.push({
            typeIdx: rangeTypeIdx,
            locals: [],
            body: [...rangeBody, OP.END]
        });
        // range is internal, but can be exported for testing/debugging
        this.exports.push({ name: rangeName, idx: rangeIdx, kind: 0x00 });

        // 6. Factorial (n) -> n!
        const factName = "factorial";
        const factIdx = baseIdx + this.functions.length;
        this.funcNameMap.set(factName, factIdx);
        const factBody = [
            // if n <= 1 return 1
            OP.GET_LOCAL, 0,
            OP.F64_CONST, ...new WasmEmitter().encodeF64(1.0),
            OP.F64_LE,
            OP.IF, VALTYPE.F64,
            OP.F64_CONST, ...new WasmEmitter().encodeF64(1.0),
            OP.ELSE,
            // return n * factorial(n - 1)
            OP.GET_LOCAL, 0,
            OP.GET_LOCAL, 0,
            OP.F64_CONST, ...new WasmEmitter().encodeF64(1.0),
            OP.F64_SUB,
            OP.CALL, ...new WasmEmitter().encodeULEB128(factIdx),
            OP.F64_MUL,
            OP.END
        ];
        const factTypeIdx = this.getTypeIdx([VALTYPE.F64], [VALTYPE.F64]);
        this.functions.push({
            typeIdx: factTypeIdx,
            locals: [],
            body: [...factBody, OP.END]
        });
        this.exports.push({ name: factName, idx: factIdx, kind: 0x00 });

        // 7. Nth (list, index) -> val
        const nthName = "nth";
        const nthIdx = baseIdx + this.functions.length;
        this.funcNameMap.set(nthName, nthIdx);
        const nthBody = [
            // if index <= 0 return head(list) (Allow rough index check for now)
            // Strict: index == 0
            OP.GET_LOCAL, 1,
            OP.F64_CONST, ...new WasmEmitter().encodeF64(0.0),
            OP.F64_LE, // index <= 0
            OP.IF, VALTYPE.F64,
            OP.GET_LOCAL, 0,
            OP.CALL, ...new WasmEmitter().encodeULEB128(headIdx),
            OP.ELSE,
            // return nth(tail(list), index - 1)
            OP.GET_LOCAL, 0,
            OP.CALL, ...new WasmEmitter().encodeULEB128(tailIdx),
            OP.GET_LOCAL, 1,
            OP.F64_CONST, ...new WasmEmitter().encodeF64(1.0),
            OP.F64_SUB, // index - 1
            OP.CALL, ...new WasmEmitter().encodeULEB128(nthIdx),
            OP.END
        ];
        // Note: Missing checks for empty list (tail on empty?)
        // For prototype, assuming valid bounds.
        this.functions.push({
            typeIdx: rangeTypeIdx, // Same sig as range (f64, f64 -> f64)
            locals: [],
            body: [...nthBody, OP.END]
        });
        this.exports.push({ name: nthName, idx: nthIdx, kind: 0x00 });

    }

    injectImports() {
        // Register Math.pow as env.pow
        // Type: (f64, f64) -> f64
        const typeIdx = this.getTypeIdx([VALTYPE.F64, VALTYPE.F64], [VALTYPE.F64]);
        this.imports.push({
            module: "env",
            name: "pow",
            desc: { kind: 0x00, typeIdx: typeIdx } // Kind 0 = Function
        });
        const funcIdx = this.functions.length + this.imports.length - 1; // Function Space = Imports + Internal
        // Note: Function Index Space includes imports first.
        // We need to adjust `functions.length` logic or `funcNameMap`.
        // Current compiler assumes `functions.length` is the index.
        // If we have 1 import, real internal function 0 is actually index 1.

        // Let's refactor index handling slightly.
        // But for now, let's just claim the index.
        // WAIT: Compiler.constructor sets up runtime functions BEFORE imports?
        // NO, we call injectImports AFTER injectRuntime.
        // So internal functions are 0, 1, 2, 3...
        // But Import functions are *prepended* in index space.

        // FIX: We should inject imports FIRST.
        // Reordering constructor logic.
    }

    collectStringLiterals(node) {
        if (typeof node === 'string') {
            if (node.startsWith('`')) {
                // String Literal
                if (!this.stringTable.has(node)) {
                    // Extract content (remove backticks)
                    const content = node.slice(1, -1);
                    const encoder = new TextEncoder();
                    const bytes = encoder.encode(content);

                    // Limit check
                    if (this.dataBytes.length + bytes.length + 1 > this.heapStartOffset) {
                        throw new Error("Static data exceeds 1024 bytes buffer");
                    }

                    const offset = this.dataStartOffset + this.dataBytes.length;
                    this.stringTable.set(node, offset);

                    // Append bytes + null terminator
                    bytes.forEach(b => this.dataBytes.push(b));
                    this.dataBytes.push(0); // \0
                }
            }
            return;
        }
        if (Array.isArray(node)) {
            for (const child of node) {
                this.collectStringLiterals(child);
            }
        }
    }

    compile(sexpr) {
        // 0. Pass: Collect String Literals
        this.collectStringLiterals(sexpr);

        // 1. Pass: Collect Function Names (for forward references)
        let items = Array.isArray(sexpr[0]) ? sexpr : [sexpr];
        if (sexpr[0] === ':') items = [sexpr];

        let funcCounter = 0;
        // Pass 1: Collect Function Names and Signatures
        for (const item of items) {
            const op = item[0];
            if (op === ':') {
                this.compileDefinition(item, true); // true = scan only
            }
        }

        console.log("--- Functions Table ---");
        this.funcNameMap.forEach((idx, name) => {
            const f = this.functions[idx];
            const type = f ? this.types[f.typeIdx] : "Not Compiled Yet";
            console.log(`Func #${idx}: ${name} -> Sig: ${JSON.stringify(type)}`);
        });
        console.log("-----------------------");

        // Pass 2: Compile Bodies
        for (const item of items) {
            const op = item[0];
            if (op === ':') {
                this.compileDefinition(item, false);
            } else {
                // Top-level expression? Treat as implicit 'main'?
                // Verify phase 1 logic doesn't skip top level exprs
            }
        }
    }

    compileDefinition(node, scanOnly = false) {
        const name = node[1];

        if (scanOnly) {
            // Pass 1: Register Name
            const idx = this.imports.length + this.funcNameMap.size; // Fix index calculation
            this.funcNameMap.set(name, idx);
            return;
        }

        let body = node[2];
        let params = [];

        // Handle Lambda Syntax: [?, [params], body]
        if (Array.isArray(body) && body[0] === '?') {
            const paramNode = body[1];
            if (Array.isArray(paramNode)) {
                params = paramNode;
            } else if (typeof paramNode === 'string') {
                params = [paramNode];
            }
            body = body[2];
        }

        // Setup Locals for this function
        this.currentLocals = new Map();
        params.forEach((p, i) => this.currentLocals.set(p, i));

        const paramTypes = params.map(_ => VALTYPE.F64);
        let resultType = VALTYPE.F64;

        // Compile Body
        const code = this.compileExpr(body, VALTYPE.F64);
        code.push(OP.END);

        const typeIdx = this.getTypeIdx(paramTypes, [resultType]);
        const funcIdx = this.funcNameMap.get(name);

        // Check Sync (Adjust for imports offset)
        const expectedIdx = this.functions.length + this.imports.length;
        if (expectedIdx !== funcIdx) {
            throw new Error(`Sync error: Compiling func ${name} (idx ${funcIdx}) but expected ${expectedIdx} (funcs: ${this.functions.length} + imports: ${this.imports.length})`);
        }

        // Add 1 scratch local (F64) for logic operations
        this.functions.push({ typeIdx, locals: [{ count: 1, type: VALTYPE.F64 }], body: code });

        this.exports.push({ name, idx: funcIdx, kind: 0x00 });
    }

    isFloatExpr(node) {
        if (typeof node === 'number' && !Number.isInteger(node)) return true;
        if (typeof node === 'string') return true;
        if (Array.isArray(node)) {
            for (let i = 1; i < node.length; i++) {
                if (this.isFloatExpr(node[i])) return true;
            }
        }
        return false;
    }

    flattenCall(node) {
        if (Array.isArray(node) && node[0] === ' ') {
            const left = this.flattenCall(node[1]);
            return {
                base: left.base,
                args: [...left.args, node[2]]
            };
        }
        return { base: node, args: [] };
    }

    compileExpr(node, expectedType = null) {
        // 0. Unit / False (_)
        if (node === '_') {
            return [OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN)];
        }

        // 1. String Literals
        if (typeof node === 'string' && node.startsWith('`')) {
            if (!this.stringTable.has(node)) {
                throw new Error("Compiler Error: String literal not collected");
            }
            const offset = this.stringTable.get(node);
            // Return ptr as f64
            return [OP.F64_CONST, ...new WasmEmitter().encodeF64(offset)];
        }

        // 2. Literal Numbers
        if (typeof node === 'number') {
            if (expectedType === VALTYPE.F64 || (!Number.isInteger(node))) {
                return [OP.F64_CONST, ...new WasmEmitter().encodeF64(node)];
            } else {
                return [OP.I32_CONST, ...new WasmEmitter().encodeSLEB128(node)];
            }
        }

        // 2. Variables
        if (typeof node === 'string') {
            if (this.currentLocals.has(node)) {
                // Variables are F64 in Phase 2/3
                return [OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(this.currentLocals.get(node))];
            }
            // Check if it's a global function (0-arity constant)
            if (this.funcNameMap.has(node)) {
                const funcIdx = this.funcNameMap.get(node);
                return [OP.CALL, ...new WasmEmitter().encodeULEB128(funcIdx)];
            }
            throw new Error(`Undefined variable: ${node}`);
        }

        if (Array.isArray(node)) {
            if (node.length === 0) return [OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN)];

            // Handle Blocks (nested lists)
            if (typeof node[0] !== 'string') {
                let bytes = [];
                for (const expr of node) {
                    bytes = bytes.concat(this.compileExpr(expr, expectedType));
                    // If block, we probably discard results of non-last exprs?
                    // For now, assume array of exprs is executed in sequence, leaving last value?
                    // But standard logic (parseBlock) might separate them.
                    // This logic concat them all, suggesting they all push to stack?
                    // If so, we'd need DROP for all but last.
                    // But `parseBlock` returns `expressions` array only if logic.
                    // Actually, let's assume `node` here is a single expression.
                    // If `node` is array of arrays, it's a block.
                    // Phase 1 compiler here is simplistic.
                    if (expr !== node[node.length - 1]) bytes.push(OP.DROP);
                    // Add DROP to minimal fix for sequence
                }
                return bytes;
            }

            const op = node[0];

            // 3. Comparisons
            if (['<', '>', '<=', '>=', '=', '!='].includes(op)) {
                const args = node.slice(1);
                const scratchIdx = this.currentLocals.size; // Params end at size-1. Scratch is at size.

                let bytes = [];
                // Compile LHS
                bytes = bytes.concat(this.compileExpr(args[0], VALTYPE.F64));
                // Compile RHS
                bytes = bytes.concat(this.compileExpr(args[1], VALTYPE.F64));

                // Stack: [LHS, RHS]
                // Save RHS for potential return
                bytes.push(OP.TEE_LOCAL, ...new WasmEmitter().encodeULEB128(scratchIdx));
                // Stack: [LHS, RHS]

                // Compare (Consumers LHS, RHS, pushes I32)
                if (op === '=') bytes.push(OP.F64_EQ);
                if (op === '!=') bytes.push(OP.F64_NE);
                if (op === '<') bytes.push(OP.F64_LT);
                if (op === '>') bytes.push(OP.F64_GT);
                if (op === '<=') bytes.push(OP.F64_LE);
                if (op === '>=') bytes.push(OP.F64_GE);

                // Stack: [I32 (Condition)]
                bytes.push(OP.IF);
                bytes.push(VALTYPE.F64); // Result F64

                // True Branch: Return RHS
                bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(scratchIdx));

                // False Branch: Return NaN
                bytes.push(OP.ELSE);
                bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN));

                bytes.push(OP.END);

                // If expected type is I32 (e.g. for low level), we might need convert
                // But generally we stay in F64 world.
                return bytes;
            }

            // 4. Logic (Not)
            if (op === '!_') {
                const val = node[1];
                const scratchIdx = this.currentLocals.size;

                let bytes = [];
                bytes = bytes.concat(this.compileExpr(val, VALTYPE.F64));

                // Check if Truthy (x == x)
                bytes.push(OP.TEE_LOCAL, ...new WasmEmitter().encodeULEB128(scratchIdx));
                bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(scratchIdx));
                bytes.push(OP.F64_EQ); // 1 if Num, 0 if NaN

                // If Truthy (1) -> Return NaN (False)
                // If Falsy (0) -> Return 0.0 (True)

                bytes.push(OP.IF);
                bytes.push(VALTYPE.F64);

                // Was Truthy -> Become False
                bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN)); // False

                bytes.push(OP.ELSE);
                // Was Falsy -> Become True
                bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(0)); // True (0 is True)

                bytes.push(OP.END);
                return bytes;
            }

            // 5. Conditionals (:)
            if (op === ':') {
                const cond = node[1];
                const thenExpr = node[2];
                const scratchIdx = this.currentLocals.size;

                let bytes = [];
                // Compile Cond
                bytes = bytes.concat(this.compileExpr(cond, VALTYPE.F64));

                // Check Truthy (x == x)
                bytes.push(OP.TEE_LOCAL, ...new WasmEmitter().encodeULEB128(scratchIdx));
                bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(scratchIdx));
                bytes.push(OP.F64_EQ); // 1 if Truthy, 0 if NaN

                // IF Block
                bytes.push(OP.IF);
                bytes.push(VALTYPE.F64);

                // THEN
                bytes = bytes.concat(this.compileExpr(thenExpr, VALTYPE.F64));

                // ELSE (Implicit else returns NaN)
                bytes.push(OP.ELSE);
                bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN));

                bytes.push(OP.END);
                return bytes;
            }

            // 6. Call
            if (op === ' ') {
                const { base, args } = this.flattenCall(node);
                if (typeof base === 'string' && this.funcNameMap.has(base)) {
                    const funcIdx = this.funcNameMap.get(base);
                    let bytes = [];
                    for (const arg of args) {
                        bytes = bytes.concat(this.compileExpr(arg, VALTYPE.F64));
                    }
                    bytes.push(OP.CALL);
                    bytes = bytes.concat(new WasmEmitter().encodeULEB128(funcIdx));
                    return bytes;
                }
                throw new Error(`Unknown function: ${base}`);
            }

            // 7. Arithmetic
            if (['+', '-', '*', '/', '%', '^'].includes(op)) {
                const type = VALTYPE.F64; // Force F64 for Phase 2/3
                let bytes = [];
                const args = node.slice(1);

                // Unary Minus
                if (op === '-' && args.length === 1) {
                    // 0 - val
                    bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(0));
                    bytes = bytes.concat(this.compileExpr(args[0], type));
                    bytes.push(OP.F64_SUB);
                    return bytes;
                }

                // Modulo (%)
                if (op === '%') {
                    const arg0 = args[0];
                    const arg1 = args[1];

                    // a
                    bytes = bytes.concat(this.compileExpr(arg0, type));

                    // b * trunc(a/b)
                    bytes = bytes.concat(this.compileExpr(arg1, type));
                    bytes = bytes.concat(this.compileExpr(arg0, type));
                    bytes = bytes.concat(this.compileExpr(arg1, type));
                    bytes.push(OP.F64_DIV);
                    bytes.push(OP.F64_TRUNC);
                    bytes.push(OP.F64_MUL);

                    bytes.push(OP.F64_SUB);
                    return bytes;
                }

                for (const arg of args) {
                    bytes = bytes.concat(this.compileExpr(arg, type));
                }
                if (op === '+') bytes.push(OP.F64_ADD);
                if (op === '*') bytes.push(OP.F64_MUL);
                if (op === '-') bytes.push(OP.F64_SUB);
                if (op === '/') bytes.push(OP.F64_DIV);

                if (op === '^') {
                    // Power: Call env.pow
                    // Find 'pow' import index
                    // We know we put it first. 
                    // To be safe, we could store it in a map or fixed var.
                    // For now, assume import 0 is pow.
                    const powImportIdx = 0;
                    bytes.push(OP.CALL, ...new WasmEmitter().encodeULEB128(powImportIdx));
                }

                return bytes;
            }

            // 8. Logical Operators (Short-circuiting)
            if (['&', '|', ';'].includes(op)) {
                // &, | are Binary Short-circuit
                // ; is XOR (Binary, strict boolean)

                const type = VALTYPE.F64;
                const args = node.slice(1);

                // OR (|)
                // Left ? Left : Right
                if (op === '|') {
                    let bytes = [];
                    // 1. Evaluate Left
                    bytes = bytes.concat(this.compileExpr(args[0], type)); // [L]

                    // 2. Tee Left to check (preserving it for return if True)
                    // But we can't TEE if stack is arbitrary.
                    // We need a scratch local.
                    const scratchIdx = this.currentLocals.size; // We need to reserve this scratch space? 
                    // Actually `compileDefinition` only allocates locals for params + 1 scratch.
                    // If we nest, we might overwrite scratch.
                    // ideally we should allocate a fresh local.
                    // For prototype, reusing scratch (local N) is risky if recursive.
                    // BUT `compileDefinition` does: `locals: [{ count: 1, type: VALTYPE.F64 }]`
                    // This gives us ONE local at `params.length`.
                    // Is it enough?
                    // If we do `(a | b) | c`
                    //  Calc `a|b` -> uses scratch.
                    //  Result is on stack.
                    //  Calc `c`.
                    //  OR them. Uses scratch.
                    // It seems ok as long as we don't need *multiple* scratches simultaneously active in stack frame.

                    const localScratch = this.currentLocals.size;

                    bytes.push(OP.TEE_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch)); // [L]
                    bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch)); // [L, L]

                    // Check Is Truthy (x == x) reduces NaN to 0
                    bytes.push(OP.F64_EQ); // [L, 0/1]

                    bytes.push(OP.IF);
                    bytes.push(VALTYPE.F64);
                    // True (L is Truthy) -> Return L
                    bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch));
                    bytes.push(OP.ELSE);
                    // False (L is Falsy/NaN) -> Return R
                    bytes.push(OP.DROP); // Drop L which is on stack from TEE? Wait.
                    // Stack entering IF: [L] (from initial eval).
                    // WAIT. 
                    // TEE puts value on stack AND local.
                    // GET puts value on stack.
                    // F64_EQ consumes 2.
                    // Initial: [L]
                    // TEE: [L] (Local=L)
                    // GET: [L, L]
                    // EQ: [L, 0/1] -> This won't work. EQ consumes 2 items.
                    // We need to consume the checked value, but keep the original if true.

                    // Correct Sequence:
                    // Eval L -> [L]
                    // Set Global/Local -> [ ]
                    // Get -> [L]
                    // Check -> [0/1]
                    // IF ...

                    // Let's use SET_LOCAL to save, GET_LOCAL to check.
                    bytes = [];
                    bytes = bytes.concat(this.compileExpr(args[0], type)); // [L]
                    bytes.push(OP.SET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch)); // []

                    bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch)); // [L]
                    bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch)); // [L, L]
                    bytes.push(OP.F64_EQ); // [0/1] (Truthy check)

                    bytes.push(OP.IF);
                    bytes.push(VALTYPE.F64);
                    // True: Return L
                    bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch));
                    bytes.push(OP.ELSE);
                    // False: Return R
                    bytes = bytes.concat(this.compileExpr(args[1], type));
                    bytes.push(OP.END);

                    return bytes;
                }

                // AND (&)
                // Left ? Right : Left
                if (op === '&') {
                    const localScratch = this.currentLocals.size;
                    let bytes = [];

                    bytes = bytes.concat(this.compileExpr(args[0], type)); // [L]
                    bytes.push(OP.SET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch)); // []

                    bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch)); // [L]
                    bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch)); // [L, L]
                    bytes.push(OP.F64_EQ); // [0/1] (Truthy check)

                    bytes.push(OP.IF);
                    bytes.push(VALTYPE.F64);
                    // True (L is Truthy): Return R
                    bytes = bytes.concat(this.compileExpr(args[1], type));
                    bytes.push(OP.ELSE);
                    // False (L is Falsy/NaN): Return L
                    bytes.push(OP.GET_LOCAL, ...new WasmEmitter().encodeULEB128(localScratch));
                    bytes.push(OP.END);

                    return bytes;
                }

                // XOR (;)
                // (!!L) ^ (!!R) -> 0 or 1 -> 0.0 or NaN
                if (op === ';') {
                    // This requires converting L and R to pure Booleans (0/1)
                    // Then Integer XOR
                    // Then Map 1->0.0 (True), 0->NaN (False)
                    // Wait, Standard: 0.0 is True, NaN is False.
                    // XOR logic:
                    // T ; T -> F (NaN)
                    // F ; F -> F (NaN)
                    // T ; F -> T (0.0)
                    // F ; T -> T (0.0)

                    let bytes = [];

                    // L -> Bool(0/1)
                    bytes = bytes.concat(this.compileExpr(args[0], type)); // [L]
                    bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN));
                    bytes.push(OP.F64_NE); // [1 if L!=NaN, 0 if L==NaN] -> Truthy is 1

                    // R -> Bool(0/1)
                    bytes = bytes.concat(this.compileExpr(args[1], type)); // [1, R]
                    bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN));
                    bytes.push(OP.F64_NE); // [1, 0/1]

                    // I32 XOR
                    const I32_XOR = 0x73;
                    bytes.push(I32_XOR); // [0/1 result]

                    // Map 1 -> 0.0 (True), 0 -> NaN (False)
                    bytes.push(OP.IF);
                    bytes.push(VALTYPE.F64);
                    // 1 (True Result) -> 0.0 in Sign
                    bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(0.0));
                    bytes.push(OP.ELSE);
                    // 0 (False Result) -> NaN in Sign
                    bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(NaN));
                    bytes.push(OP.END);

                    return bytes;
                }
            }

            // 9. Absolute Value (Parser emits `!-` for `|...|`)
            // We intercept `!-` here and check if we treat it as ABS?
            // Wait, implementation plan said `abs`.
            // User requested NO PARSER CHANGE.
            // Parser emits `["!-", val]` for `|val|`.
            // Standard `!-` (unary minus) is `["-", val]`?
            // Let's check Parser:
            // Parser overrides: `|`: { prefix: { p: 1, sym: '[|' }, ... }
            // Parser shuntingYard logic: 
            // `if (top.value === '[|')` -> `values.push(["!-", v])`
            // So `|x|` becomes `["!-", x]`.
            // But Unary Minus `-x`?
            // Parser: `'-': { prefix: { p: 11 }, infix: { p: 11 } }`.
            // shuntingYard: if prefix, `node.push(arg)`. Symbol is `-`.
            // So Unary Minus is `["-", x]`.
            // Absolute Value is `["!-", x]`.
            // Confusion: `!-` usually means "NOT MINUS"? 
            // In `operators.js`?
            // Actually `!` is NOT.
            // But Parser manually pushes `["!-", v]` for Absolute Value wrapper. (Line 531 in parser.js)
            // So we just need to handle `!-` operator here.

            if (op === '!-') {
                let bytes = [];
                bytes = bytes.concat(this.compileExpr(node[1], VALTYPE.F64));
                return bytes;
            }

            // 10. Range Operator (start ~ end)
            if (op === '~') {
                let bytes = [];
                // Push start, Push end, Call range
                bytes = bytes.concat(this.compileExpr(node[1], VALTYPE.F64));
                bytes = bytes.concat(this.compileExpr(node[2], VALTYPE.F64));
                const rangeIdx = this.funcNameMap.get("range");
                bytes.push(OP.CALL, ...new WasmEmitter().encodeULEB128(rangeIdx));
                return bytes;
            }

            // 11. Factorial Operator (n!)
            // Parser emits postfix `_!` for `n!`. 
            if (op === '_!') {
                let bytes = [];
                bytes = bytes.concat(this.compileExpr(node[1], VALTYPE.F64));
                const factIdx = this.funcNameMap.get("factorial");
                bytes.push(OP.CALL, ...new WasmEmitter().encodeULEB128(factIdx));
                return bytes;
            }

            // 12. Access Operator (' or @)
            if (op === "'" || op === "@") {
                // Infix @ or ' : list ' index
                let bytes = [];
                bytes = bytes.concat(this.compileExpr(node[1], VALTYPE.F64)); // List
                bytes = bytes.concat(this.compileExpr(node[2], VALTYPE.F64)); // Index
                const nthIdx = this.funcNameMap.get("nth");
                bytes.push(OP.CALL, ...new WasmEmitter().encodeULEB128(nthIdx));
                return bytes;
            }

            return [];
        }
        return [];
    }

    emitImports(emitter) {
        if (this.imports.length === 0) return [];
        // Vector of Imports
        return emitter.encodeVector(this.imports.map(imp => {
            return [
                ...emitter.encodeString(imp.module),
                ...emitter.encodeString(imp.name),
                imp.desc.kind,
                ...emitter.encodeULEB128(imp.desc.typeIdx)
            ];
        }));
    }

    emit() {
        const emitter = new WasmEmitter();

        // 1. Magic & Version
        const magic = [0x00, 0x61, 0x73, 0x6D];
        const version = [0x01, 0x00, 0x00, 0x00];

        // 2. Type Section
        const typePayload = emitter.encodeVector(this.types.map(t => {
            return [0x60, ...emitter.encodeVector(t.params), ...emitter.encodeVector(t.results)];
        }));

        // 3. Function Section (map indices to types)
        const funcPayload = emitter.encodeVector(this.functions.map(f => f.typeIdx));

        // 4. Memory Section
        // (memory 1)
        const memoryPayload = [1, 0, this.memoryPages]; // flags=0, initial=1

        // 5. Global Section
        const globalPayload = emitter.encodeVector(this.globals.map(g => {
            return [g.type, g.mutable ? 1 : 0, ...g.init];
        }));

        // 6. Export Section
        const exportPayload = emitter.encodeVector(this.exports.map(e => {
            return [...emitter.encodeString(e.name), e.kind, ...emitter.encodeULEB128(e.idx)];
        }));

        // 7. Code Section
        const codePayload = emitter.encodeVector(this.functions.map(f => {
            // Encode locals
            // f.locals is array of {count, type}
            const localsBytes = f.locals.map(l => [...emitter.encodeULEB128(l.count), l.type]).flat();
            const localsCount = f.locals.length;
            const localsPayload = [...emitter.encodeULEB128(localsCount), ...localsBytes];

            const body = [...localsPayload, ...f.body];
            return [...emitter.encodeULEB128(body.length), ...body];
        }));

        // 8. Data Section
        let dataSectionBytes = [];
        if (this.dataBytes.length > 0) {
            // mode=0 (active), memidx=0 (implicit), offset=expr, init=vec(byte)
            const offsetExpr = [OP.I32_CONST, ...emitter.encodeSLEB128(this.dataStartOffset), OP.END];
            const segment = [0, ...offsetExpr, ...emitter.encodeVector(this.dataBytes)];
            dataSectionBytes = emitter.encodeSection(SECTION.DATA, emitter.encodeVector([segment]));
        }

        return new Uint8Array([
            ...magic, ...version,
            ...emitter.encodeSection(SECTION.TYPE, typePayload),
            ...emitter.encodeSection(SECTION.IMPORT, this.emitImports(emitter)), // Emitting Imports
            ...emitter.encodeSection(SECTION.FUNCTION, funcPayload),
            ...emitter.encodeSection(SECTION.MEMORY, memoryPayload),
            ...emitter.encodeSection(SECTION.GLOBAL, globalPayload),
            ...emitter.encodeSection(SECTION.EXPORT, exportPayload),
            ...emitter.encodeSection(SECTION.CODE, codePayload),
            ...dataSectionBytes
        ]);
    }
}

// --- Main ---
const args = process.argv.slice(2);
let inputFile, outputFile;
for (let i = 0; i < args.length; i++) {
    if (args[i] === '--input') inputFile = args[i + 1];
    if (args[i] === '--output') outputFile = args[i + 1];
}

if (!inputFile || !outputFile) {
    console.error("Usage: node compiler.js --input <file> --output <file>");
    process.exit(1);
}

const inputJson = fs.readFileSync(inputFile, 'utf8');
const sexpr = JSON.parse(inputJson);

const compiler = new Compiler();
compiler.compile(sexpr);
const wasmBuffer = compiler.emit();

fs.writeFileSync(outputFile, wasmBuffer);
console.log(`Wasm generated: ${outputFile} (${wasmBuffer.length} bytes)`);
