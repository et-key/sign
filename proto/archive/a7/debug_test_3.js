const { Lexer } = require('./lexer');
const { Parser } = require('./parser');
const util = require('util');

function test(input) {
    console.log(`\n--- Testing: Input ---`); // avoid newlines in log
    try {
        const lexer = new Lexer(input);
        const tokens = lexer.tokenize();
        console.log('Tokens:', tokens.length);

        const parser = new Parser(tokens);
        const ast = parser.parse();

        console.log(util.inspect(ast, { showHidden: false, depth: null, colors: false }));
    } catch (e) {
        console.error('Error:', e.message);
        console.error(e.stack);
    }
}

test(`
[x ?
    x = 0 : 0
    x > 0 : 1
]
`);
