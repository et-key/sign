import { resolveCoproducts } from './pre_alpha/semanticize/coproduct_resolver.js';
import { buildEnvironment, desugarHoles } from './pre_alpha/semanticize/ast_helpers.js';
import { transpile } from './pre_alpha/backend/js_codegen.js';
import { RUNTIME_HELPERS_CODE } from './pre_alpha/backend/runtime_helpers.js';
import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';

const source = `
f : x ? x * 2
map : g x ~y ? @g x , map g y~
result_map1 : map $f 1 2 3 4 5
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

const fullCode = RUNTIME_HELPERS_CODE + '\n' + transpiledCode + '\nconsole.log("result_map1:", result_map1);';

console.log("--- EXECUTION ---");
eval(fullCode);
