const { Lexer } = require('./lexer');
const { Converter } = require('./converter');

function test(code) {
    console.log(`\nTesting: ${code.trim()}`);
    try {
        const lexer = new Lexer(code);
        const tokens = lexer.tokenize();
        const converter = new Converter(tokens);
        const sexpr = converter.convert();
        console.log('Result:', JSON.stringify(sexpr, null, 2));
    } catch (e) {
        console.error('Error:', e.message);
    }
}

test('x + y');
test('x y');
test('!x');
test('x!');
test('x y ? x');
test('f : x y ? x');
test('x, y, z');
test('x y ? x^2 + 2*x*y + y^2');
