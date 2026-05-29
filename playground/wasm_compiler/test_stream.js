import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { getInitialCategory } from './semanticize/builder.js';
import { evaluate } from './semanticize/evaluator.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { generateWasm } from './backend/wasm.js';

// Test 1: Pure literals (should be eliminated)
// Test 2: Pure Map (should be eliminated)
// Test 3: Store unrolled list directly to memory (No arrays, No Map)
// Test 4: Map over unrolled list and store to memory (Zero-cost Stream Fusion)
// Test 5: Final pure expression (should be retained as implicit return)
const code = `10
[* 2,] 10 20 30
0x4000 # 10 20 30
0x5000 # [* 2,] 10 20 30
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
