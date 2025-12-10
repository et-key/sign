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
    }
}

// Case 1: Arithmetic Precedence
test('1 + 2 * 3');

// Case 2: Definition
test('x : 10');

// Case 3: List (Right Associative Comma)
test('1, 2, 3');

// Case 4: Function Apply (Adjacency)
test('print "Hello"');

// Case 5: Complex
test('filter [> 0], [1, 2, 3]');

// Case 6: Lambda
test('x ? x + 1');

// Case 7: Block (Match case style with newlines)
test(`
[x ?
    x = 0 : 0
    x > 0 : 1
]
`);
