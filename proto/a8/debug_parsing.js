import lexer from './prepare_lexer.js';
import fs from 'fs';

const code = fs.readFileSync('test_control.sn', 'utf8');
const sexpr = lexer.parseToSExpr(code);
console.log(JSON.stringify(sexpr, null, 2));
