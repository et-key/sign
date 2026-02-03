import fs from 'fs';

const wasmFile = process.argv[2] || 'proto/wa1/test_string.wasm';

async function run() {
	try {
		const buffer = fs.readFileSync(wasmFile);
		const module = await WebAssembly.compile(buffer);
		const instance = await WebAssembly.instantiate(module);

		console.log(`--- Verifying Strings in: ${wasmFile} ---`);

		const exports = instance.exports;
		const memory = exports.memory;

		if (!memory) {
			console.error("No memory export found!");
			return;
		}

		const memBytes = new Uint8Array(memory.buffer);

		for (const name in exports) {
			const func = exports[name];
			if (typeof func === 'function' && func.length === 0) {
				const ptr = func();
				console.log(`${name} returned PTR: ${ptr}`);

				// Decode String at ptr
				if (ptr >= 0 && ptr < memBytes.length) {
					let end = ptr;
					while (end < memBytes.length && memBytes[end] !== 0) {
						end++;
					}
					const strBytes = memBytes.slice(ptr, end);
					const decoder = new TextDecoder();
					const str = decoder.decode(strBytes);
					console.log(`  -> String: "${str}"`);
				}
			}
		}

	} catch (e) {
		console.error("Execution Error:", e);
	}
}

run();
