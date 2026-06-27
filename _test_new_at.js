import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';
import { resolveCoproducts } from './pre_alpha/semanticize/coproduct_resolver.js';
import { buildEnvironment, desugarHoles } from './pre_alpha/semanticize/ast_helpers.js';
import { transpile } from './pre_alpha/backend/js_codegen.js';
import { RUNTIME_HELPERS_CODE } from './pre_alpha/backend/runtime_helpers.js';

// テスト: @ = Deref∘Apply、@@ = run-to-completion、# = Apply∘Store
const source = `
say : "console.log"
add : x y ? x + y

result_add : @(add 3) 7
say result_add

double : x ? x * 2
fn_ref : $double
called : @fn_ref 5
say called
`;

const preprocessed = preprocess(source);
const ast = parser.parse(preprocessed);
let globalEnv = new Map();
const rawLines = ast.filter(l => l !== null && l !== undefined);
const astLines = rawLines.map(desugarHoles);
astLines.forEach(l => buildEnvironment(l, globalEnv));
const resolvedAst = astLines.map(l => resolveCoproducts(l, globalEnv));
const code = resolvedAst.map(s => transpile(s)).join(';\n') + ';';

console.log('--- TRANSPILED ---');
console.log(code);
console.log('\n--- RUN ---');
eval(RUNTIME_HELPERS_CODE + '\n' + code);
