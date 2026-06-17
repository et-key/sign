import { resolveCoproducts } from './pre_alpha/semanticize/coproduct_resolver.js';
import { buildEnvironment, desugarHoles } from './pre_alpha/semanticize/ast_helpers.js';
import { transpile } from './pre_alpha/backend/js_codegen.js';
import { RUNTIME_HELPERS_CODE } from './pre_alpha/backend/runtime_helpers.js';
import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';

const source = `
add : x y ? x + y
fold_lazy : f a x ~y ? $fold_lazy f [@f a x] y~
fold_eager : f a x ~y ? fold_eager f [@f a x] y~

step0 : fold_lazy $add 0 1 2 3
step1 : @step0 __
step2 : @step1 __

res_eager : fold_eager $add 0 1 2 3
res_curry : add 5
res_curry_eval : @res_curry 10
`;

const preprocessed = preprocess(source);
const ast = parser.parse(preprocessed);

let globalEnv = new Map();
const rawLines = ast.filter(line => line !== null && line !== undefined);
const astLines = rawLines.map(desugarHoles);

astLines.forEach(astLine => {
	buildEnvironment(astLine, globalEnv);
});

const resolvedAst = astLines.map(astLine => resolveCoproducts(astLine, globalEnv));
const transpiledCode = resolvedAst.map(s => transpile(s)).join(';\n') + ';';
console.log("--- TRANSPILED CODE ---");
console.log(transpiledCode);

const fullCode = RUNTIME_HELPERS_CODE + '\n' + transpiledCode + '\nconsole.log("step0:", step0); console.log("step1:", step1); console.log("step2:", step2); console.log("res_eager:", res_eager); console.log("res_curry:", res_curry); console.log("res_curry_eval:", res_curry_eval);';

console.log("--- EXECUTION ---");
eval(fullCode);