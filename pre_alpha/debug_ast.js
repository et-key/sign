import fs from 'fs';
import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { desugarHoles } from './semanticize/ast_helpers.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';

const sourceCode = `[0 ~ 10]`;
const pre = preprocess(sourceCode);
const astProg = parser.parse(pre);
console.log("RAW AST:", JSON.stringify(astProg, null, 2));
