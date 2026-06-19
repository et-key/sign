import fs from 'fs';
import path from 'path';
import { preprocess } from './pre_alpha/lexisize/lexer.js';
import * as parser from './pre_alpha/parse/minimal.js';
import { resolveCoproducts, getArity } from './pre_alpha/semanticize/coproduct_resolver.js';
import { transpile } from './pre_alpha/backend/js_codegen.js';
import { execSync } from 'child_process';
import util from 'util';
import { RUNTIME_HELPERS_CODE } from './pre_alpha/backend/runtime_helpers.js';
import { buildEnvironment, desugarHoles, collectIdentifiers } from './pre_alpha/semanticize/ast_helpers.js';
import { generateTypeScriptDef } from './pre_alpha/backend/ts_codegen.js';

// 1. Get the source file argument
const fileArg = process.argv[2] || 'pre_alpha/_test_/function/composition.sn';
const filePath = path.resolve(fileArg);

if (!fs.existsSync(filePath)) {
  console.error(`File not found: ${filePath}`);
  process.exit(1);
}

console.log(`=== Compiling and Transpiling: ${fileArg} ===`);
const sourceCode = fs.readFileSync(filePath, 'utf8');

// 2. Preprocess, Parse, and Resolve Coproducts
const pre = preprocess(sourceCode);
const astProg = parser.parse(pre);
console.log("=== AST ===");
console.log(JSON.stringify(astProg, null, 2));

let globalEnv = new Map();
const rawLines = astProg.filter(line => line !== null && line !== undefined);
const astLines = rawLines.map(desugarHoles);

// Build Environment Map
astLines.forEach(astLine => {
  buildEnvironment(astLine, globalEnv);
});

// Resolve Coproducts and Transpile Statements
const jsStatements = [];
const definedVars = [];

astLines.forEach(astLine => {
  const resolved = resolveCoproducts(astLine, globalEnv);
  
  // Collect defined variables for execution inspection
  if (resolved && resolved.type === 'operation' && resolved.operator === ':') {
    const identName = typeof resolved.left === 'string' ? resolved.left : (resolved.left.name || String(resolved.left));
    if (identName.startsWith('<') && identName.endsWith('>')) {
      definedVars.push(identName.slice(1, -1));
    }
  }
  
  // Re-build env with resolved tree for accurate type inference later
  buildEnvironment(resolved, globalEnv);
  
  const jsCode = transpile(resolved);
  if (jsCode) {
    jsStatements.push(jsCode);
  }
});

// Collect used identifiers to find undefined ones
const usedIdents = new Set();
astLines.forEach(line => collectIdentifiers(line, usedIdents));

const undefinedIdents = [];
usedIdents.forEach(id => {
  if (!globalEnv.has(`<${id}>`) && id !== '_' && id !== 'print') {
    undefinedIdents.push(id);
  }
});

const undefinedDeclarations = undefinedIdents.map(id => `const ${id} = __unit;`).join('\n');

// 3. Assemble the full executable JS file content
const runtimeHelpers = `
import _ from 'white_cats';
import util from 'util';

${RUNTIME_HELPERS_CODE}
`;

const loggingBlock = `
console.log("=== Transpiled Execution Results ===");
${definedVars.map(v => `try { console.log("${v} = ", util.inspect(${v}, { depth: null, colors: true })); } catch(e) {}`).join('\n')}
`;

const fullJsCode = `${runtimeHelpers}\n${undefinedDeclarations}\n${jsStatements.map(s => s + ';').join('\n')}\n${loggingBlock}`;

console.log("=== Generated JavaScript Code ===");
console.log(fullJsCode);

// 4. Generate TypeScript Definitions
const resolvedLines = astLines.map(astLine => resolveCoproducts(astLine, globalEnv));
const dtsCode = generateTypeScriptDef(resolvedLines, globalEnv);

// 5. Write to files
const jsFilePath = filePath.replace(/\.(sign|sn)$/, '.js');
const dtsFilePath = filePath.replace(/\.(sign|sn)$/, '.d.ts');

fs.writeFileSync(jsFilePath, fullJsCode, 'utf8');
fs.writeFileSync(dtsFilePath, dtsCode, 'utf8');

console.log(`\nFiles generated:`);
console.log(`  JS: ${jsFilePath}`);
console.log(`  TS: ${dtsFilePath}`);

// 6. Execute the transpiled JS
try {
  console.log("\n=== Execution Output ===");
  const output = execSync(`node ${jsFilePath}`, { encoding: 'utf8' });
  console.log(output);
} catch (err) {
  console.error("Execution error:", err.stdout || err.stderr || err.message);
}
