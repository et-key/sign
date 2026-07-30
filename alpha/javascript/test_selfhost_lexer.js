import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { compile } from './src/index.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const lexerSnPath = path.resolve(__dirname, '../sign/lexer.sn');
const sourceCode = fs.readFileSync(lexerSnPath, 'utf8');

console.log("=== Compiling Self-Hosted lexer.sn ===");
const compiled = compile(sourceCode);
console.log("Transpilation successful!");
console.log("Generated JS size:", compiled.jsCode.length, "bytes");

// モジュール実行テスト
const tmpPath = path.resolve(__dirname, '../sign/lexer.test_out.js');
fs.writeFileSync(tmpPath, compiled.jsCode, 'utf8');
console.log("Wrote compiled output to:", tmpPath);

console.log("\nSelf-hosting compilation test passed cleanly!");
