const fs = require('fs');
const path = require('path');

const logFile = 'proto/a8/debug_log.txt';
fs.writeFileSync(logFile, '');

function log(msg) {
    fs.appendFileSync(logFile, msg + '\n');
    console.log(msg);
}

log('Running test_debug_run.js');

try {
    const { Lexer } = require('./lexer');
    const { Converter } = require('./converter');
    log('Imports successful');

    const filePath = path.resolve(__dirname, '../../documents/ja-jp/example.ja-jp.sn');
    log('Reading file: ' + filePath);
    const content = fs.readFileSync(filePath, 'utf8');

    log('Tokenizing...');
    const lexer = new Lexer(content);
    const tokens = lexer.tokenize();
    log('Tokenization complete. Total tokens: ' + tokens.length);

    log('Initializing Converter...');
    const converter = new Converter(tokens);

    // Manually run processBlock logic to debug
    const statements = [];
    let currentStmt = [];
    let depth = 0;

    log('Processing blocks...');
    for (let i = 0; i < tokens.length; i++) {
        const t = tokens[i];
        if (['LPAREN', 'LBRACKET', 'LBRACE'].includes(t.type)) depth++;
        if (['RPAREN', 'RBRACKET', 'RBRACE'].includes(t.type)) depth--;

        const isNewline = t.type === 'NEWLINE';
        const isIndent = t.type === 'INDENT';
        const isDedent = t.type === 'DEDENT';

        if (depth === 0 && isNewline) {
            if (currentStmt.length > 0) {
                // Log only occasionally or on error?
                // log(`Converting stmt line ${t.line}`);
                try {
                    const res = converter.convertExpr(currentStmt);
                    statements.push(res);
                } catch (e) {
                    log(`CRASH at line ${t.line}, stmt: ` + currentStmt.map(tk => tk.value).join(' '));
                    throw e;
                }
                currentStmt = [];
            }
        } else if (depth === 0 && (isIndent || isDedent)) {
            currentStmt.push(t);
        } else {
            currentStmt.push(t);
        }
    }
    log('Processing complete.');
    fs.writeFileSync('proto/a8/example_sexpr.json', JSON.stringify(statements, null, 2));
    log('Written to example_sexpr.json');

} catch (e) {
    log('Fatal Error: ' + e.toString());
    if (e.stack) log(e.stack);
}
