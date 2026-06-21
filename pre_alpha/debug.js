import fs from 'fs';
import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { transpile } from './backend/js_codegen.js';
import { buildEnvironment, desugarHoles } from './semanticize/ast_helpers.js';

const source = `a | -b | c`;
console.log('--- Source ---');
console.log(source);

const pre = preprocess(source);
console.log('--- Preprocessed ---');
console.log(JSON.stringify(pre));

const astProg = parser.parse(pre);
console.log('--- Parsed AST ---');
console.log(JSON.stringify(astProg, null, 2));

const rawLines = astProg.filter(line => line !== null && line !== undefined);
const astLines = rawLines.map(desugarHoles);

let globalEnv = new Map();
astLines.forEach(astLine => {
  buildEnvironment(astLine, globalEnv);
});

astLines.forEach(astLine => {
  const resolved = resolveCoproducts(astLine, globalEnv);
  console.log('--- Resolved AST ---');
  console.log(JSON.stringify(resolved, null, 2));
  
  const jsCode = transpile(resolved, globalEnv);
  console.log('--- Transpiled Code ---');
  console.log(jsCode);
});
