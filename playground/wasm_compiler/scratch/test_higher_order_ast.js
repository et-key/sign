import fs from 'fs';
import { preprocess } from '../lexisize/lexer.js';
import * as parser from '../parse/minimal.js';
import { buildAST } from '../semanticize/shunting_yard.js';
import { buildEnvironment } from '../semanticize/builder.js';
import { resolveCoproducts } from '../semanticize/coproduct_resolver.js';

const source = fs.readFileSync('_test_/function/higher_order.sn', 'utf8');
const tokens = preprocess(source);
const parsed = parser.parse(tokens);
const ast = buildAST(parsed);
const env = buildEnvironment(ast);
resolveCoproducts(ast, env);
console.log(JSON.stringify(ast, null, 2));
