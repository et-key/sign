const { parse } = require('./pre_alpha/parse/minimal.js');
const { preprocess } = require('./pre_alpha/lexisize/lexer.js');
const { transpile } = require('./pre_alpha/backend/js_codegen.js');
const { buildEnvironment, desugarHoles } = require('./pre_alpha/semanticize/ast_helpers.js');
const { resolveCoproducts, getArity } = require('./pre_alpha/semanticize/coproduct_resolver.js');

const source = `
f : x y ? x * y
curried : f 2
result_curried : curried 4
`;
const ast = parse(preprocess(source)).filter(Boolean).map(desugarHoles);
let env = new Map();
ast.forEach(n => {
  buildEnvironment(n, env);
  const r = resolveCoproducts(n, env);
  buildEnvironment(r, env);
});
const code = ast.map(a => transpile(resolveCoproducts(a, env))).join(';\n');
console.log(code);
