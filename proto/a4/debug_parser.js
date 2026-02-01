
import { tokenize, structurize, parseBlock } from './parser.js';

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const file = path.join(__dirname, 'test_pointfree.sn');
const code = fs.readFileSync(file, 'utf8');
console.log("Reading:", file);
// console.log("Code:", code);

const tokens = tokenize(code);
const blocks = structurize(tokens);
const parsed = parseBlock(blocks);

console.log("Parsed:", JSON.stringify(parsed, null, 2));
