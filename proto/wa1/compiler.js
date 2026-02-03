import fs from 'fs';
import path from 'path';

// --- Wasm Constants ---
const SECTION = {
    TYPE: 1,
    FUNCTION: 3,
    EXPORT: 7,
    CODE: 10
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
    }

    getTypeIdx(params, results) {
        const sig = `${params.join(',')}:${results.join(',')}`;
        if (this.typeMap.has(sig)) return this.typeMap.get(sig);

        const idx = this.types.length;
        this.types.push({ params, results });
        this.typeMap.set(sig, idx);
        return idx;
    }

    compile(sexpr) {
        // 1. Pass: Collect Function Names (for forward references)
        let items = Array.isArray(sexpr[0]) ? sexpr : [sexpr];
        if (sexpr[0] === ':') items = [sexpr];

        let funcCounter = 0;
        for (const item of items) {
            if (Array.isArray(item) && item[0] === ':') {
                const name = item[1];
                // Assign index
                this.funcNameMap.set(name, funcCounter++);
            }
        }

        // 2. Pass: Compile Definitions
        for (const item of items) {
            if (Array.isArray(item) && item[0] === ':') {
                this.compileDefinition(item);
            }
        }
    }

    compileDefinition(node) {
        const name = node[1];
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
        // 1. Literal Numbers
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
            if (['+', '-', '*', '/'].includes(op)) {
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

        // 4. Export Section
        const exportPayload = emitter.encodeVector(this.exports.map(e => {
            return [...emitter.encodeString(e.name), e.kind, ...emitter.encodeULEB128(e.idx)];
        }));

        // 5. Code Section
        const codePayload = emitter.encodeVector(this.functions.map(f => {
            const body = [...emitter.encodeVector(f.locals), ...f.body]; // Locals decl (empty for now) then body
            // Locals format: u32 count, valtype. We skip proper locals for now.
            return [...emitter.encodeULEB128(body.length), 0x00, ...f.body];
        }));

        return new Uint8Array([
            ...magic, ...version,
            ...emitter.encodeSection(SECTION.TYPE, typePayload),
            ...emitter.encodeSection(SECTION.FUNCTION, funcPayload),
            ...emitter.encodeSection(SECTION.EXPORT, exportPayload),
            ...emitter.encodeSection(SECTION.CODE, codePayload)
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
