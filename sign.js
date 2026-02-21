#!/usr/bin/env node
import { spawnSync } from 'child_process';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const args = process.argv.slice(2);

if (args.length === 0 || args.includes('--help') || args.includes('-h')) {
	console.log(`
Usage: sign [options] <input.sn>

Options:
  --help, -h      Show this matching help message
  --output, -o    Specify the output AArch64 internal assembly file name

Description:
  Compiles a Sign language source file through the parser pipeline 
  and generates an AArch64 assembly file (.s).
`);
	process.exit(0);
}

// Very basic argument parsing
let inputFile = null;
let outputFile = null;

for (let i = 0; i < args.length; i++) {
	const arg = args[i];
	if (arg === '--output' || arg === '-o') {
		if (i + 1 < args.length) {
			outputFile = args[++i];
		} else {
			console.error("Error: --output requires a file path argument.");
			process.exit(1);
		}
	} else if (!arg.startsWith('-')) {
		if (!inputFile) {
			inputFile = arg;
		} else {
			console.error(`Error: Multiple input files not supported (${inputFile} vs ${arg}).`);
			process.exit(1);
		}
	} else {
		console.error(`Error: Unknown option ${arg}.`);
		process.exit(1);
	}
}

if (!inputFile) {
	console.error("Error: No input file specified.");
	process.exit(1);
}

let parsedInputFile = path.resolve(inputFile);
let resolvedDir = path.dirname(parsedInputFile);
let baseName = path.basename(parsedInputFile, '.sn');
let jsonFile = path.join(resolvedDir, `${baseName}.json`);

if (!outputFile) {
	outputFile = path.join(resolvedDir, `${baseName}.s`);
}

const parserPath = path.join(__dirname, 'proto', 'a8', 'parser.js');
const compilerPath = path.join(__dirname, 'proto', 'a8', 'compiler.js');

console.log(`Parsing ${inputFile}...`);
const parseRes = spawnSync('node', [parserPath, parsedInputFile, jsonFile], { stdio: 'inherit' });
if (parseRes.status !== 0) {
	console.error("Parse failed.");
	process.exit(parseRes.status);
}

console.log(`Compiling AST to AArch64 assembly...`);
// Currently, compiler.js takes <inputFile> and <outputFile> as argv2 and argv3
// Wait, compiler.js process.argv:
// process.argv[2] -> input JSON file
// Does it take an output file?
// Let's pass the destination outputFile and modify compiler.js to respect process.argv[3].
const compileRes = spawnSync('node', [compilerPath, jsonFile, '-o', outputFile], { stdio: 'inherit' });

// We can safely delete the intermediate json if compile succeeds.
if (compileRes.status === 0 && fs.existsSync(jsonFile)) {
	fs.unlinkSync(jsonFile);
	console.log(`Successfully compiled to ${outputFile}`);
} else {
	process.exit(compileRes.status || 1);
}
