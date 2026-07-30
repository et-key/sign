#!/usr/bin/env node

import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import { compile } from '../src/index.js';

const fileArg = process.argv[2] || '../../pre_alpha/_test_/function/composition.sn';
const filePath = path.resolve(fileArg);

if (!fs.existsSync(filePath)) {
  console.error(`File not found: ${filePath}`);
  process.exit(1);
}

console.log(`=== Compiling (alpha.javascript): ${filePath} ===`);
const sourceCode = fs.readFileSync(filePath, 'utf8');

try {
  const result = compile(sourceCode);
  
  const outJsPath = filePath.replace(/\.(sign|sn)$/, '.alpha.js');
  fs.writeFileSync(outJsPath, result.jsCode, 'utf8');
  console.log(`Generated JS: ${outJsPath}`);

  console.log("\n=== Execution Result (Node.js) ===");
  const output = execSync(`node ${outJsPath}`, { encoding: 'utf8' });
  console.log(output);

} catch (err) {
  console.error("Compilation / Execution Error:", err.stack || err.message);
  process.exit(1);
}
