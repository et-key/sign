
import helper from './prepare_lexer.js';
const { parseToSExpr } = helper;

const code = '1 # "Hello World"';
const result = parseToSExpr(code);
console.log(JSON.stringify(result, null, 2));
