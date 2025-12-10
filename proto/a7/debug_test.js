const { Lexer } = require('./lexer');
const { Parser } = require('./parser');
const util = require('util');

function test(input) {
    console.log(`\n--- Testing: ${input} ---`);
    try {
        const lexer = new Lexer(input);
        const tokens = lexer.tokenize();
        console.log('Tokens:', tokens.map(t => `${t.type}(${t.value})`).join(', '));

        const parser = new Parser(tokens);
        const ast = parser.parse();

        console.log(util.inspect(ast, { showHidden: false, depth: null, colors: true }));
    } catch (e) {
        console.error('Error:', e.message);
        console.error(e.stack);
    }
}

// Case 1: Arithmetic Precedence
test('1 + 2 * 3');
