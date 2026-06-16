import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';

const source = `fact : x ?
	x = 0 : 1
	x = 1 : 1
	x * [fact [x - 1]]

a : fact 5
`;

console.time('preprocess');
const preprocessed = preprocess(source);
console.timeEnd('preprocess');

console.time('parse');
const ast = parser.parse(preprocessed);
console.timeEnd('parse');

console.log("Parsed length:", ast.length);
