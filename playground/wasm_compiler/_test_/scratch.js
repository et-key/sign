import { preprocess } from '../lexisize/lexer.js';
import * as parser from '../parse/minimal.js';
import { buildAST } from '../semanticize/shunting_yard.js';
import { buildEnvironment } from '../semanticize/builder.js';
import { resolveCoproducts } from '../semanticize/coproduct_resolver.js';
import { evaluate } from '../semanticize/evaluator.js';
// import { annotateContextualOperators, inferType, liftLambdas } from '../semanticize/analyzer.js';
const code = `math@~`;
const preprocessed = preprocess(code);
console.log("Lexer output:", preprocessed);
const astProgram = parser.parse(preprocessed);
console.log("PEG parser output:", JSON.stringify(astProgram, null, 2));

let globalEnv = new Map();

astProgram.forEach((stmt, index) => {
  console.log(`\n--- Statement ${index + 1} ---`);
  const astTree = buildAST(Array.isArray(stmt) && stmt.length === 1 && Array.isArray(stmt[0]) ? stmt[0] : stmt);
  console.log("Shunting Yard output:", JSON.stringify(astTree, null, 2));

  globalEnv = buildEnvironment(astTree, globalEnv);
  console.log("Environment:", globalEnv);

  const resolved = resolveCoproducts(astTree, globalEnv);
  console.log("After resolveCoproducts:", JSON.stringify(resolved, null, 2));

  const evaluated = evaluate(resolved, globalEnv);
  console.log("After evaluate:", JSON.stringify(evaluated, null, 2));
});
