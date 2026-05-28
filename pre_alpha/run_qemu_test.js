import { execSync } from 'child_process';
import path from 'path';
import fs from 'fs';

const asmFile = process.argv[2];

if (!asmFile) {
  console.error('Usage: node run_qemu_test.js <path_to_.s_file>');
  process.exit(1);
}

if (!fs.existsSync(asmFile)) {
  console.error(`File not found: ${asmFile}`);
  process.exit(1);
}

// Windows path to WSL path conversion for convenience if needed,
// but wsl command usually handles paths if executed from the same directory,
// or we can just use relative paths.
const parsed = path.parse(asmFile);
const outBinary = path.join(parsed.dir, parsed.name + '.out');

// WSL needs paths in unix format if we pass absolute paths,
// but relative paths work fine. We'll use relative paths.
const relativeAsm = path.relative(process.cwd(), asmFile).replace(/\\/g, '/');
const relativeOut = path.relative(process.cwd(), outBinary).replace(/\\/g, '/');

try {
  console.log(`[Compile] wsl aarch64-linux-gnu-gcc -static -nostdlib -o ${relativeOut} ${relativeAsm}`);
  execSync(`wsl aarch64-linux-gnu-gcc -static -nostdlib -o ${relativeOut} ${relativeAsm}`, { stdio: 'inherit' });
} catch (e) {
  console.error(`[Error] Compilation failed`);
  process.exit(1);
}

try {
  console.log(`[Run] wsl qemu-aarch64 ${relativeOut}`);
  // execSync will throw if exit code is not 0
  execSync(`wsl qemu-aarch64 ${relativeOut}`, { stdio: 'inherit' });
  console.log(`[Success] Exit code: 0`);
} catch (e) {
  if (e.status !== undefined && e.status !== null) {
    console.log(`[Success] Exit code: ${e.status} (This is expected if the result of the program is ${e.status})`);
  } else {
    console.error(`[Error] Execution failed`, e);
    process.exit(1);
  }
}
