import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import util from 'util';

const tc = "func_args:\n\t\targ1: type1 = default1\n\t?\n\t\tbody_statement";
const pre = preprocess(tc);
const ast = parser.parse(pre);
console.log(util.inspect(ast, { depth: null, colors: true }));
