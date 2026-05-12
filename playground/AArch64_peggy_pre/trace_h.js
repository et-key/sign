const fs = require('fs');
const peg = require('peggy');
const { SemanticAnalyzer } = require('./semantic_analyzer.js');

const grammar = fs.readFileSync('sign.pegjs', 'utf-8');
const parser = peg.generate(grammar);
const src = `h : x ~y ? h y~`;
const ast = parser.parse(src);

const analyzer = new SemanticAnalyzer();
analyzer.analyze(ast);

console.log("typeRegistry:", analyzer.typeRegistry);
