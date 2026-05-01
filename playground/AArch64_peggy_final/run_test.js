const fs = require('fs');
const { execSync } = require('child_process');
const peggy = require('peggy');
const { lex } = require('./lexer');
const { SemanticAnalyzer } = require('./semantic_analyzer');
const { AArch64Generator } = require('./compiler_aarch64');

const GRAMMAR_FILE = 'sign.pegjs';
const TEST_FILE = 'test_compile.sn';

function main() {
    try {
        const args = process.argv.slice(2);
        const inputFile = args.length > 0 ? args[0] : TEST_FILE;

        if (!fs.existsSync(inputFile)) {
            console.log(`Creating dummy test file '${inputFile}'...`);
            fs.writeFileSync(inputFile, '10 + 20\n');
        }

        console.log(`Loading grammar: ${GRAMMAR_FILE}...`);
        const grammar = fs.readFileSync(GRAMMAR_FILE, 'utf8');
        const parser = peggy.generate(grammar);

        console.log(`📖 Reading source file: ${inputFile}...`);
        const content = fs.readFileSync(inputFile, 'utf8');
        console.log(`\n${content.trim()}\n`);

        console.log(`[1] Lexing...`);
        const lexedSource = lex(content);
        if (!lexedSource) {
            console.error("Lexing failed.");
            process.exit(1);
        }

        console.log(`[2] Parsing...`);
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

        console.log(`[3] Semantic Analysis...`);
        const analyzer = new SemanticAnalyzer();
        const optimizedAst = analyzer.analyze(ast);

        console.log(`[4] Generating AArch64 Assembly...`);
        const compiler = new AArch64Generator();
        const assembly = compiler.generate(optimizedAst);

        const outputFile = 'output.s';
        fs.writeFileSync(outputFile, assembly);
        console.log(`=== Generated AArch64 Assembly ===`);
        console.log(assembly);

        console.log(`[5] Auto Build & Run...`);
        try {
            execSync(`as -o output.o ${outputFile}`);
            execSync(`ld -o a.out output.o`);
        } catch (buildErr) {
            console.error("Build Failed:", buildErr.message);
            process.exit(1);
        }

        try {
            execSync('./a.out');
            console.log("✨ Exit Code: 0");
        } catch (runErr) {
            console.log(`✨ Exit Code: ${runErr.status}`);
        }

    } catch (e) {
        console.error("❌ Error:", e.message);
        process.exit(1);
    }
}

main();
