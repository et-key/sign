const { parse } = require('./pre_alpha/parse/minimal.js');
const { preprocess } = require('./pre_alpha/lexisize/lexer.js');
const { transpile } = require('./pre_alpha/backend/js_codegen.js');
const { buildEnvironment, desugarHoles } = require('./pre_alpha/semanticize/ast_helpers.js');
const { resolveCoproducts } = require('./pre_alpha/semanticize/coproduct_resolver.js');

const source = `
list : 0 ~+ 2 ~ 10
obj : {}
importTest : javascript@
test1 : obj # prop 100
`;
const ast = parse(preprocess(source)).filter(Boolean).map(desugarHoles);
let env = new Map();
ast.forEach(n => {
  buildEnvironment(n, env);
  const r = resolveCoproducts(n, env);
  buildEnvironment(r, env);
  console.log(transpile(r));
});
