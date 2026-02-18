
import fs from 'fs';
import util from 'util';
import lexer from './prepare_lexer.js';

const file = process.argv[2];
const code = fs.readFileSync(file, 'utf8');

console.log("--- Raw S-Expr ---");
const sexpr = lexer.parseToSExpr(code);
console.log(util.inspect(sexpr, { showHidden: false, depth: null, colors: true }));
