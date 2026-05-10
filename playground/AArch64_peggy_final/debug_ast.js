const fs = require('fs');
const parser = require('./parser.js');
const lex = require('./lexer.js');
const { SemanticAnalyzer } = require('./semantic_analyzer.js');

const src = fs.readFileSync('test_pointer_deref.sn', 'utf8');
const lexed = lex(src);
const ast = parser.parse(lexed);
const analyzer = new SemanticAnalyzer();

analyzer.pass1(ast);
console.log("dictDefinitions keys:", Array.from(analyzer.dictDefinitions.keys()));
console.log("currentScope:", analyzer.currentScope);
