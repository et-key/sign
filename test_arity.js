const { parse } = require('./pre_alpha/parse/minimal.js');
const { preprocess } = require('./pre_alpha/lexisize/lexer.js');
const { resolveCoproducts } = require('./pre_alpha/semanticize/coproduct_resolver.js');
const { buildEnvironment, desugarHoles } = require('./pre_alpha/semanticize/ast_helpers.js');
const { transpile } = require('./pre_alpha/backend/js_codegen.js');

const source = `
a : 1
b : 2
c : 3
list2 : a b c
`;

const ast = parse(preprocess(source)).filter(Boolean).map(desugarHoles);
let env = new Map();
ast.forEach(n => buildEnvironment(n, env));
const list2Ast = resolveCoproducts(ast[3], env);
console.log(transpile(list2Ast));
