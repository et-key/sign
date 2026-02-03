import fs from 'fs';
import path from 'path';

// --- Wasm Constants ---
const SECTION = {
    TYPE: 1,
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
    ELSE: 0x05
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
        // 1. Alloc (i32 size -> i32 ptr)
        // returns old_heap_ptr, updates heap_ptr += size
        const allocName = "alloc";
        const allocIdx = this.functions.length; // 0
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
        const consIdx = this.functions.length;
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
        const headIdx = this.functions.length;
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
        const tailIdx = this.functions.length;
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
            // Index = current functions length (including runtime) + count of user functions processed
            // Wait, we can just track the next available index.
            // But we don't push to `this.functions` yet.
            // So we need to know how many we have scanned.
            // Better: use `this.funcNameMap.size`.
            const idx = this.funcNameMap.size;
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

        // We must push to `this.functions` in the same order as Pass 1 scanned them.
        // Pass 2 iterates in same order, so `this.functions.length` should match `funcIdx`.
        if (this.functions.length !== funcIdx) {
            throw new Error(`Sync error: Compiling func ${name} (idx ${funcIdx}) but functions array len is ${this.functions.length}`);
        }

        this.functions.push({ typeIdx, locals: [], body: code });

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
                // We assume 0-arity if used as a value without arguments?
                // Or we should verify arity. For now, just CALL it.
                return [OP.CALL, ...new WasmEmitter().encodeULEB128(funcIdx)];
            }
            throw new Error(`Undefined variable: ${node}`);
        }

        if (Array.isArray(node)) {
            if (node.length === 0) return [];

            // Handle Blocks (nested lists)
            if (typeof node[0] !== 'string') {
                let bytes = [];
                for (const expr of node) {
                    bytes = bytes.concat(this.compileExpr(expr, expectedType));
                }
                return bytes;
            }

            const op = node[0];

            // 3. Comparisons
            if (['<', '>', '<=', '>=', '=', '!='].includes(op)) {
                const args = node.slice(1);
                // Compare F64s, return I32
                let bytes = [];
                bytes = bytes.concat(this.compileExpr(args[0], VALTYPE.F64));
                bytes = bytes.concat(this.compileExpr(args[1], VALTYPE.F64));

                if (op === '=') bytes.push(OP.F64_EQ);
                if (op === '!=') bytes.push(OP.F64_NE);
                if (op === '<') bytes.push(OP.F64_LT);
                if (op === '>') bytes.push(OP.F64_GT);
                if (op === '<=') bytes.push(OP.F64_LE);
                if (op === '>=') bytes.push(OP.F64_GE);

                // Coerce to F64 if expected
                if (expectedType === VALTYPE.F64) {
                    bytes.push(OP.F64_CONVERT_I32_S);
                }
                return bytes;
            }

            // 4. Logic (Not)
            if (op === '!_') { // Parser outputs '!_' for prefix !
                const val = node[1];
                let bytes = [];
                bytes = bytes.concat(this.compileExpr(val, VALTYPE.F64));
                bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(0));
                bytes.push(OP.F64_EQ); // result i32 (1 if 0.0)

                if (expectedType === VALTYPE.F64) {
                    bytes.push(OP.F64_CONVERT_I32_S);
                }
                return bytes;
            }

            // 5. Conditionals (:)
            if (op === ':') {
                // [":", cond, then]
                const cond = node[1];
                const thenExpr = node[2];

                let bytes = [];
                // Compile Cond (Result should be i32)
                const isComp = Array.isArray(cond) && ['<', '>', '=', '!=', '<=', '>='].includes(cond[0]);

                if (isComp) {
                    bytes = bytes.concat(this.compileExpr(cond)); // returns i32
                } else {
                    // Evaluate as F64, check != 0
                    bytes = bytes.concat(this.compileExpr(cond, VALTYPE.F64));
                    bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(0));
                    bytes.push(OP.F64_NE); // 1 if != 0
                }

                // IF Block
                bytes.push(OP.IF);
                bytes.push(VALTYPE.F64); // Result type of block

                // THEN
                bytes = bytes.concat(this.compileExpr(thenExpr, VALTYPE.F64));

                // ELSE (Implicit else returns 0.0)
                bytes.push(OP.ELSE);
                bytes.push(OP.F64_CONST, ...new WasmEmitter().encodeF64(0));

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
            if (['+', '-', '*', '/', '%'].includes(op)) {
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
                return bytes;
            }

            return [];
        }
        return [];
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
