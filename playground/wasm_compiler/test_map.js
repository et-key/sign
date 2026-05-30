import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { getInitialCategory } from './semanticize/builder.js';
import { evaluate } from './semanticize/evaluator.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { generateWasm } from './backend/wasm.js';

const code = `[* 2,] 1 2 3 4 5`;
try {
    const p = preprocess(code);
    const ast = parser.parse(p);
    const built = buildAST(ast[0]);
    const env = new Map();
    const resolved = resolveCoproducts(built, env);
    const evaled = evaluate(resolved, env);
    console.log("Evaled:", JSON.stringify(evaled, null, 2));
    const wasm = generateWasm([evaled]);
    console.log("WASM:\n" + wasm);
} catch (e) {
    console.error("Error:", e);
}
