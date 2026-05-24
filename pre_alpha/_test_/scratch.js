import { preprocess } from '../lexisize/lexer.js';
import * as parser from '../parse/minimal.js';
import { buildAST } from '../semanticize/shunting_yard.js';
import { buildEnvironment } from '../semanticize/builder.js';
import { resolveCoproducts } from '../semanticize/coproduct_resolver.js';
// import { annotateContextualOperators, inferType, liftLambdas } from '../semanticize/analyzer.js';
const code = `[1 2] 3`;
const preprocessed = preprocess(code);
console.log("Lexer output:", preprocessed);
const astProgram = parser.parse(preprocessed);
console.log("PEG parser output:", JSON.stringify(astProgram, null, 2));

const astTree = buildAST(astProgram[0]);
console.log("Shunting Yard output:", JSON.stringify(astTree, null, 2));

// annotateContextualOperators(astTree);
// console.log("After annotateContextualOperators:", JSON.stringify(astTree, null, 2));

const env = buildEnvironment(astTree);
console.log("Environment:", env);

const resolved = resolveCoproducts(astTree, env);
console.log("After resolveCoproducts:", JSON.stringify(resolved, null, 2));
