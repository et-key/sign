const { Lexer } = require('./lexer');
const { Converter } = require('./converter');

const code = '[x y ? x ^ 2 + 2 * x * y + y ^ 2]';

console.log('Code:', code);
const lexer = new Lexer(code);
const tokens = lexer.tokenize();
console.log('Tokens:', tokens.map(t => `${t.type}(${t.value})`).join(' '));

const converter = new Converter(tokens);
const sexpr = converter.convert();
console.log('S-Expr WRITTEN TO debug_output.json');
const fs = require('fs');
fs.writeFileSync('proto/a8/debug_output.json', JSON.stringify(sexpr, null, 2));

// Debug depth check
const innerTokens = tokens.slice(1, tokens.length - 1);
console.log('Inner Tokens:', innerTokens.map(t => `${t.type}(${t.value})`).join(' '));
const opIdx = converter.findSplitOperatorIndex(innerTokens);
console.log('Split Op Index:', opIdx);
if (opIdx >= 0) {
    console.log('Split Op:', innerTokens[opIdx].value);
} else {
    console.log('No split operator found.');
}
