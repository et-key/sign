import { preprocess } from '../lexisize/lexer.js';
import * as parser from '../parse/minimal.js';
import { buildAST } from '../semanticize/shunting_yard.js';
import { annotateContextualOperators, buildTypeEnvironment, resolveCoproducts, inferType, liftLambdas } from '../semanticize/analyzer.js';

const code = `[+ 2,] 1 2 3 4 5`;
const preprocessed = preprocess(code);
console.log("Lexer output:", preprocessed);
const astProgram = parser.parse(preprocessed);
console.log("PEG parser output:", JSON.stringify(astProgram, null, 2));

const astTree = buildAST(astProgram[0]);
console.log("Shunting Yard output:", JSON.stringify(astTree, null, 2));

annotateContextualOperators(astTree);
console.log("After annotateContextualOperators:", JSON.stringify(astTree, null, 2));

const resolved = resolveCoproducts(astTree, new Map());
console.log("After resolveCoproducts:", JSON.stringify(resolved, null, 2));
