
import fs from 'fs';
import lexer from './prepare_lexer.js';

const file = process.argv[2];
const code = fs.readFileSync(file, 'utf8');
const prepared = lexer.prepare(code);
const marked = lexer.markSeparator(prepared);

console.log("--- Marked Code ---");
console.log(JSON.stringify(marked));

console.log("--- Split Tokens ---");
const tokens = marked.split('\x1F').filter(t => t !== '');
console.log(tokens);
