const fs = require('fs');
const peggy = require('peggy');
const { lex } = require('./lexer');
const { SemanticAnalyzer } = require('./semantic_analyzer');

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
		const lines = content.split('\n');

		const outputPath = 'ast_output.md';
		fs.writeFileSync(outputPath, '# Exported ASTs\n\n');

		let currentTest = [];
		let testNo = 0;
        const analyzer = new SemanticAnalyzer();

		function runTest(srcLines) {
			const originalSrc = srcLines.join('\n');
			const lexedSource = lex(originalSrc);
			if (!lexedSource) return;
			testNo++;

			let mdOut = `## Test ${testNo}\n### Source\n\`\`\`\n${originalSrc}\n\`\`\`\n### Lexed\n\`\`\`\n${lexedSource.replace(/\x02/g, '<STX>').replace(/\x03/g, '<ETX>')}\n\`\`\`\n`;

			try {
				let ast = parser.parse(lexedSource);
                ast = analyzer.analyze(ast);
				mdOut += '### AST\n```json\n' + JSON.stringify(ast, null, 2) + '\n```\n\n';
				console.log(`[PASS] Test ${testNo} AST generated.`);
			} catch (e) {
				let errMsg = e.message;
				if (e.location) {
					errMsg = `Parse Error at line ${e.location.start.line}, col ${e.location.start.column}: ${e.message}`;
				}
				mdOut += '### AST Generation Error\n```\n' + errMsg + '\n```\n\n';
				console.log(`[FAIL] Test ${testNo} failed to generate AST.`);
			}
			fs.appendFileSync(outputPath, mdOut);
		}

		for (let i = 0; i < lines.length; i++) {
			const line = lines[i];
			const trimmed = line.trim();

			if (line.startsWith('`')) {
				if (currentTest.length > 0) {
					runTest(currentTest);
					currentTest = [];
				}
			} else {
				if (trimmed !== '') {
					currentTest.push(line);
				} else {
					if (currentTest.length > 0) {
						runTest(currentTest);
						currentTest = [];
					}
				}
			}
		}

		if (currentTest.length > 0) {
			runTest(currentTest);
		}

		console.log(`\nAST output successfully written to: ${outputPath}`);

	} catch (e) {
		console.error("Error:", e);
		process.exit(1);
	}
}

main();