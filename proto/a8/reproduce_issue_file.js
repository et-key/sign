const fs = require('fs');
const path = require('path');
const { Lexer } = require('./lexer');
const { Converter } = require('./converter');

const filePath = path.resolve(__dirname, '../../documents/ja-jp/example.ja-jp.sn');
const content = fs.readFileSync(filePath, 'utf8');
const lines = content.split(/\r?\n/);
const targetLine = lines.find(l => l.includes('[x y ? x ^ 2'));

console.log('Target Line:', targetLine);
console.log('Hex dump:', Buffer.from(targetLine).toString('hex'));

const lexer = new Lexer(targetLine);
const tokens = lexer.tokenize();
console.log('Tokens:', tokens.map(t => `${t.type}(${t.value})`).join(' '));

const converter = new Converter(tokens);
const sexpr = converter.convert();
console.log('S-Expr:', JSON.stringify(sexpr, null, 2));

const inner = tokens.slice(1, tokens.length - 1);
const opIdx = converter.findSplitOperatorIndex(inner);
console.log('Split Op Index:', opIdx);
if (opIdx >= 0) console.log('Op:', inner[opIdx].value);
