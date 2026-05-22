import fs from 'fs';
import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';

const rawCode = fs.readFileSync('_test_/io/memory_mapped.sn', 'utf8');
const processedCode = preprocess(rawCode);
const tokens = parser.tokenize(processedCode);
const ast = buildAST(tokens);

function walk(n) {
  if (!n) return;
  if (n.operator === ':') {
     console.log('DEFINE:', n);
  }
  if (n.left) walk(n.left);
  if (n.right) walk(n.right);
  if (n.content) walk(n.content);
  if (n.statements) n.statements.forEach(walk);
}

walk(ast);
