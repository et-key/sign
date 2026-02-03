import fs from 'fs';

const wasmFile = process.argv[2] || 'test_output.wasm';

async function run() {
    try {
        const buffer = fs.readFileSync(wasmFile);
        const module = await WebAssembly.compile(buffer);
        const instance = await WebAssembly.instantiate(module);

        console.log(`--- Running Wasm: ${wasmFile} ---`);

        const exports = instance.exports;
        for (const name in exports) {
            const func = exports[name];
            // Helper: check if it's a function
            if (typeof func === 'function') {
                try {
                    // Check arity
                    if (func.length === 0) {
                        const value = func();
                        console.log(`${name} : ${value}`);
                    } else {
                        console.log(`${name} : [Function (arity: ${func.length})]`);
                    }
                } catch (err) {
                    console.error(`Error calling ${name}:`, err);
                }
            }
        }

    } catch (e) {
        console.error("Wasm Execution Error:", e);
    }
}

run();
