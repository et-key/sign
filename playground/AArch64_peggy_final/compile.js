const fs = require('fs');
const peggy = require('peggy');
const { lex } = require('./lexer');
const { SemanticAnalyzer } = require('./semantic_analyzer');
const { AArch64Generator } = require('./compiler_aarch64');

const GRAMMAR_FILE = 'sign.pegjs';

function main() {
    try {
        const args = process.argv.slice(2);
        const inputFile = args.length > 0 ? args[0] : '../test/test_all.sn';

        if (!fs.existsSync(inputFile)) {
            console.error(`Error: Input file '${inputFile}' not found.`);
            process.exit(1);
        }

        console.log(`Loading grammar: ${GRAMMAR_FILE}...`);
        const grammar = fs.readFileSync(GRAMMAR_FILE, 'utf8');
        const parser = peggy.generate(grammar);

        console.log(`Reading source file: ${inputFile}...`);
        const content = fs.readFileSync(inputFile, 'utf8');

        // Step 1: Lexing
        console.log(`Lexing...`);
        const lexedSource = lex(content);
        if (!lexedSource) {
            console.error("Lexing failed.");
            process.exit(1);
        }

        // Step 2: Parsing
        console.log(`Parsing...`);
        let ast;
        try {
            ast = parser.parse(lexedSource);
        } catch (e) {
            if (e.location) {
                console.error(`Parse Error at line ${e.location.start.line}, col ${e.location.start.column}: ${e.message}`);
            } else {
                console.error("Parse Error:", e.message);
            }
            process.exit(1);
        }

        // Step 3: Semantic Analysis
        console.log(`Semantic Analysis...`);
        const analyzer = new SemanticAnalyzer();
        const optimizedAst = analyzer.analyze(ast);

        // Step 4: Code Generation
        console.log(`Generating AArch64 Assembly...`);
        const compiler = new AArch64Generator();
        const asm = compiler.generate(optimizedAst);

        const outputFile = inputFile.replace(/\.sn$/, '.s');
        fs.writeFileSync(outputFile, asm);
        
        const outputTypeFile = inputFile.replace(/\.sn$/, '.st');
        const typeSignature = analyzer.generateTypeSignature();
        if (typeSignature.trim().length > 0) {
            fs.writeFileSync(outputTypeFile, typeSignature);
            console.log(`Compilation successful. Outputs written to ${outputFile} and ${outputTypeFile}`);
        } else {
            console.log(`Compilation successful. Output written to ${outputFile}`);
        }

    } catch (e) {
        console.error("Compilation Error:", e);
        process.exit(1);
    }
}

main();
