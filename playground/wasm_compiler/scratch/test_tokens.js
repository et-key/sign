import fs from 'fs';
import { preprocess } from '../lexisize/lexer.js';

const source = fs.readFileSync('_test_/function/higher_order.sn', 'utf8');
const tokens = preprocess(source);
console.log(JSON.stringify(tokens, null, 2));
