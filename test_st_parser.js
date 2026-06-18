// test_st_parser.js
import fs from 'fs';
import { parse } from './pre_alpha/parse/st_grammar.js';

const source = `
\` A function definition
add : T U -> Atom
fold_eager : (T U -> SignValue) U List -> SignValue
map : (T U -> List) U ~V -> List
id : T -> T
constant : Number
`;

try {
  console.log("=== Parsing .st Source ===");
  console.log(source);
  const ast = parse(source);
  console.log("\n=== AST Output ===");
  console.log(JSON.stringify(ast, null, 2));
} catch (err) {
  if (err.location) {
    console.error(`Parse Error: Expected ${err.expected.map(e => e.text ? `"${e.text}"` : `[${e.parts.join('')}]`).join(', ')} but "${err.found}" found at line ${err.location.start.line}, column ${err.location.start.column}.`);
  } else {
    console.error(err);
  }
}
