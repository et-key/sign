
const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

const compilerPath = path.join('proto', 'a6', 'compiler.js');
const inputPath = path.join('proto', 'a6', 'test_closure.sn');
const outputPath = 'debug.s';

const compiler = spawn('node', [compilerPath], {
	stdio: ['pipe', 'pipe', 'inherit'] // Pipe stdin/stdout, inherit stderr
});

const inputStream = fs.createReadStream(inputPath);
const outputStream = fs.createWriteStream(outputPath);

inputStream.pipe(compiler.stdin);
compiler.stdout.pipe(outputStream);

compiler.on('close', (code) => {
	console.log(`Compiler exited with code ${code}`);
});
