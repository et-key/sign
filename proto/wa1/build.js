import { execSync } from 'child_process';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Paths
const parserScript = path.join(__dirname, 'parser.js');
const compilerScript = path.join(__dirname, 'compiler.js');
const runnerScript = path.join(__dirname, 'run_wasm.js');

// Input/Output
const inputFile = process.argv[2] || path.join(__dirname, 'test_minimal.sn');
const baseName = path.basename(inputFile, path.extname(inputFile));
const dirName = path.dirname(inputFile);
const jsonFile = path.join(dirName, `${baseName}.json`);
const wasmFile = path.join(dirName, `${baseName}.wasm`);

console.log(`\n--- 1. Parsing (${path.basename(inputFile)}) ---`);
try {
    execSync(`node "${parserScript}" --input "${inputFile}" --output "${jsonFile}"`, { stdio: 'inherit' });
} catch (e) { process.exit(1); }

console.log(`\n--- 2. Compiling (${path.basename(jsonFile)}) ---`);
try {
    execSync(`node "${compilerScript}" --input "${jsonFile}" --output "${wasmFile}"`, { stdio: 'inherit' });
} catch (e) { process.exit(1); }

console.log(`\n--- 3. Running (${path.basename(wasmFile)}) ---`);
try {
    execSync(`node "${runnerScript}" "${wasmFile}"`, { stdio: 'inherit' });
} catch (e) { process.exit(1); }
