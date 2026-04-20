import fs from 'fs';
import * as parser from './sign.js';
import { SemanticAnalyzer } from './semantic_analyzer.js';
import { preprocess } from './preprocessor.js';

const content = fs.readFileSync('../test/test_all.sn', 'utf8');
const lines = content.split('\n');

const outputPath = 'ast_output.md';
fs.writeFileSync(outputPath, '# Exported ASTs\n\n');

let currentTest = [];
let testNo = 0;

function runTest(srcLines) {
  const originalSrc = srcLines.join('\n');
  const src = preprocess(srcLines);
  if (!src) return;
  testNo++;
  
  const flatSrc = src.replace(/\n/g, ' ↵ ');

  let mdOut = `## Test ${testNo}\n### Source\n\`\`\`\n${originalSrc}\n\`\`\`\n### Preprocessed\n\`\`\`\n${src}\n\`\`\`\n`;

  try {
    const rawAst = parser.parse(src);
    const analyzer = new SemanticAnalyzer();
    const ast = analyzer.analyze(rawAst);

    mdOut += '### AST\n```json\n' + JSON.stringify(ast, null, 2) + '\n```\n\n';
    console.log(`[PASS] Test ${testNo} AST generated.`);
  } catch (e) {
    mdOut += '### AST Generation Error\n```\n' + e.message + '\n```\n\n';
    console.log(`[FAIL] Test ${testNo} failed to generate AST.`);
  }
  fs.appendFileSync(outputPath, mdOut);
}

for (let i = 0; i < lines.length; i++) {
  const line = lines[i];
  const trimmed = line.trim();

  if (trimmed.startsWith('` ') || trimmed === '`' || trimmed.startsWith('`>')) {
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
