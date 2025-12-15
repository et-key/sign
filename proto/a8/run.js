const fs = require('fs');
const path = require('path');
const { Lexer } = require('./lexer');
const { Converter } = require('./converter');

const examplePath = path.resolve(__dirname, '../../documents/ja-jp/example.ja-jp.sn');
const outputPath = path.resolve(__dirname, 'example_sexpr.json');

try {
    console.log(`Reading file: ${examplePath}`);
    const input = fs.readFileSync(examplePath, 'utf8');

    console.log('Tokenizing...');
    const lexer = new Lexer(input);
    const tokens = lexer.tokenize();

    console.log('Converting...');
    const converter = new Converter(tokens);
    const sexpr = converter.convert();

    console.log('Writing S-Expr to:', outputPath);
    fs.writeFileSync(outputPath, JSON.stringify(sexpr, null, 2));

    console.log('Done.');

} catch (e) {
    console.error('Error:', e.message);
    if (e.stack) console.error(e.stack);
}
