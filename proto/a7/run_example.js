const fs = require('fs');
const path = require('path');
const { parse } = require('./index');
const { Interpreter } = require('./interpreter');
const util = require('util');

const examplePath = path.resolve(__dirname, '../../documents/ja-jp/example.ja-jp.sn');
const outputPath = path.resolve(__dirname, 'example_ast.txt');

try {
    console.log(`Reading file: ${examplePath}`);
    const input = fs.readFileSync(examplePath, 'utf8');

    console.log('Parsing...');
    const ast = parse(input);

    console.log('Writing AST to:', outputPath);
    // Use util.inspect to get a readable full depth string
    const outputContent = util.inspect(ast, { showHidden: false, depth: null, colors: false });
    fs.writeFileSync(outputPath, outputContent);

    console.log('Interpreting...');
    const interpreter = new Interpreter();
    const result = interpreter.evaluate(ast);
    console.log('Execution Result:', result);

    // Check specific variables to verify
    const x = interpreter.globalEnv.get('x');
    console.log('x:', x);
    const y = interpreter.globalEnv.get('y');
    console.log('y:', y);

    console.log('Done.');
} catch (e) {
    console.log('!!! ERROR !!!');
    console.log('Message:', e.message);
    // console.log('Stack:', e.stack);
}
