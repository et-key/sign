import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';
import { buildEnvironment } from './pre_alpha/semanticize/builder.js';
import { resolveCoproducts } from './pre_alpha/semanticize/coproduct_resolver.js';
import { evaluateType } from './pre_alpha/semanticize/type_evaluator.js';
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
  let globalEnv = new Map();
  const typeEnv = new Map();
  
  const astLines = astProg.filter(line => line !== null && line !== undefined);
  
  astLines.forEach(astLine => {
    let astTree = astLine;
    console.log("Parsed AST Line:", util.inspect(astTree, { depth: null, colors: true }));
    
    try {
      globalEnv = buildEnvironment(astTree, globalEnv);
    } catch (err) {
      console.error("buildEnvironment failed for node:", util.inspect(astTree, { depth: null, colors: true }));
      throw err;
    }
    
    // Resolve coproducts (10.0 - 10.3) at compile-time/parse-time
    const resolved = resolveCoproducts(astTree, globalEnv);
    
    // Infer/Evaluate type
    const inferred = evaluateType(resolved, typeEnv);
    
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
