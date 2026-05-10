const fs = require('fs');
const peggy = require('peggy');
const { SemanticAnalyzer } = require('./semantic_analyzer');

const grammar = fs.readFileSync('sign.pegjs', 'utf8');
const parser = peggy.generate(grammar);

const code = fs.readFileSync('test_coproduct_resolve.sn', 'utf8');

const ast = parser.parse(code);
const analyzer = new SemanticAnalyzer();

// Manually register globals so they don't resolve to something weird
// Actually, SemanticAnalyzer pass1 registers them.
analyzer.pass1(ast);

ast.body.forEach(def => {
    let type = analyzer.inferCurriedType(def.definition);
    console.log(`${def.identifier} type: ${type}`);
});
