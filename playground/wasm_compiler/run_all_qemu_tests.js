import { execSync } from 'child_process';
import path from 'path';
import fs from 'fs';

const testDir = path.join(process.cwd(), '_test_');

// 再帰的に .s ファイルを検索
function findSFiles(dir, fileList = []) {
  if (!fs.existsSync(dir)) return fileList;
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const fullPath = path.join(dir, file);
    if (fs.statSync(fullPath).isDirectory()) {
      findSFiles(fullPath, fileList);
    } else if (file.endsWith('.s')) {
      fileList.push(fullPath);
    }
  }
  return fileList;
}

const sFiles = findSFiles(testDir);
console.log(`Found ${sFiles.length} assembly files to test.\n`);

const results = [];

for (const file of sFiles) {
  const parsed = path.parse(file);
  const outBinary = path.join(parsed.dir, parsed.name + '.out');
  
  const relativeAsm = path.relative(process.cwd(), file).replace(/\\/g, '/');
  const relativeOut = path.relative(process.cwd(), outBinary).replace(/\\/g, '/');

  let status = '';
  
  // 1. Compile
  try {
    execSync(`wsl aarch64-linux-gnu-gcc -static -nostdlib -o ${relativeOut} ${relativeAsm}`, { stdio: 'ignore', timeout: 5000 });
  } catch (e) {
    status = 'Compile Error';
    results.push({ file: relativeAsm, status });
    continue;
  }

  // 2. Run in QEMU
  try {
    execSync(`wsl qemu-aarch64 ${relativeOut}`, { stdio: 'ignore', timeout: 1000 });
    status = 'Success (Exit 0)';
  } catch (e) {
    if (e.code === 'ETIMEDOUT' || e.signal === 'SIGTERM') {
      status = 'Timeout (Infinite Loop?)';
    } else if (e.status !== undefined && e.status !== null) {
      if (e.status > 128) {
        // e.status = 139 (SIGSEGV), 132 (SIGILL) etc...
        status = `Runtime Panic (Code ${e.status})`;
      } else {
        status = `Success (Exit ${e.status})`;
      }
    } else {
      status = 'Execution Failed';
    }
  }
  
  results.push({ file: relativeAsm, status });
}

// Print results table
console.log('='.repeat(80));
console.log(`| ${'File'.padEnd(50)} | ${'Status'.padEnd(23)} |`);
console.log('='.repeat(80));

let compileErrors = 0;
let panics = 0;
let successes = 0;

for (const res of results) {
  console.log(`| ${res.file.padEnd(50)} | ${res.status.padEnd(23)} |`);
  if (res.status.startsWith('Compile Error')) compileErrors++;
  else if (res.status.startsWith('Runtime Panic')) panics++;
  else successes++;
}
console.log('='.repeat(80));
console.log(`Total: ${results.length} | Success: ${successes} | Compile Errors: ${compileErrors} | Panics: ${panics}`);
