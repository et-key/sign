import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { getInitialCategory } from './semanticize/builder.js';
import { evaluate } from './semanticize/evaluator.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { generateWasm } from './backend/wasm.js';

// Test 1: Compile-time stream aliasing and zero-cost expansion
const code = `list : 10 20 30
0x4000 # list
mapped : [* 2,] list
0x5000 # mapped
0x6000 # \`\` 65 66 67
0x7000 # [0 ~+ 1 ~ 5]
999`;

try {
    const p = preprocess(code);
    const ast = parser.parse(p);
    const env = new Map();
    
    let evaledStmts = [];
    for (const stmt of ast) {
      const built = buildAST(stmt);
      const resolved = resolveCoproducts(built, env);
      const evaled = evaluate(resolved, env);
      evaledStmts.push(evaled);
    }
    
    console.log("Evaled:", JSON.stringify(evaledStmts, null, 2));
    const wasm = generateWasm(evaledStmts);
    console.log("WASM:\n" + wasm);
} catch (e) {
    console.error(e);
}
