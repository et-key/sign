import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';
import { buildAST } from './pre_alpha/semanticize/shunting_yard.js';
import { annotateContextualOperators, buildTypeEnvironment, resolveCoproducts, inferType, liftLambdas } from './pre_alpha/semanticize/analyzer/index.js';
import util from 'util';

const code = `map_func: $f
list_bound: ~[a]
eval_res: @map_func [a]~
list1: ~a
list2: ~a
concat_res: list1 list2`;

console.log("=== Source Code ===");
console.log(code);

try {
  const pre = preprocess(code);
  const astProg = parser.parse(pre);
  const typeEnv = new Map();
  const lambdaState = { lambdas: [], counter: 0 };
  
  const astLines = astProg.filter(line => line !== null && line !== undefined);
  
  astLines.forEach(astLine => {
    let astTree = buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);
    astTree = annotateContextualOperators(astTree);
    buildTypeEnvironment(astTree, typeEnv);
    const resolved = resolveCoproducts(astTree, typeEnv);
    const inferred = inferType(resolved, typeEnv);
    
    console.log("--- AST Node ---");
    console.log(util.inspect(resolved, { depth: null, colors: true }));
    console.log("--- Inferred Type ---");
    console.log(util.inspect(inferred, { depth: null, colors: true }));
  });
  
  console.log("--- Type Environment ---");
  for (const [k, v] of typeEnv.entries()) {
    console.log(`${k} = ${util.inspect(v, { depth: null, colors: true })}`);
  }
} catch (e) {
  console.error("Error:", e);
}
