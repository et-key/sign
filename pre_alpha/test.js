import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { transpile } from './backend/js_codegen.js';
import { RUNTIME_HELPERS_CODE } from './backend/runtime_helpers.js';
import { buildEnvironment, desugarHoles, collectIdentifiers } from './semanticize/ast_helpers.js';
import { generateTypeScriptDef } from './backend/ts_codegen.js';

const testDir = './_test_';

function findTestFiles(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  for (const file of list) {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat && stat.isDirectory()) {
      results = results.concat(findTestFiles(filePath));
    } else if (filePath.endsWith('.sign') || filePath.endsWith('.sn')) {
      results.push(filePath);
    }
  }
  return results;
}

const files = fs.existsSync(testDir) ? findTestFiles(testDir) : [];

if (files.length === 0) {
  console.log(`No .sn test files found in ${testDir}`);
  process.exit(0);
}

console.log(`Found ${files.length} test files. Starting compilation phase...`);

const generatedFiles = [];
const compilationErrors = {};

// Phase 1: Compile all files first to allow cross-module imports
for (const filePath of files) {
  try {
    const sourceCode = fs.readFileSync(filePath, 'utf8');
    const pre = preprocess(sourceCode);
    const astProg = parser.parse(pre);

    let globalEnv = new Map();
    const rawLines = astProg.filter(line => line !== null && line !== undefined);
    const astLines = rawLines.map(desugarHoles);

    astLines.forEach(astLine => {
      buildEnvironment(astLine, globalEnv);
    });

    const jsStatements = [];
    const definedVars = [];

    astLines.forEach(astLine => {
      const resolved = resolveCoproducts(astLine, globalEnv);
      if (resolved && resolved.type === 'operation' && resolved.operator === ':') {
        const identName = typeof resolved.left === 'string' ? resolved.left : (resolved.left.name || String(resolved.left));
        if (identName.startsWith('<') && identName.endsWith('>')) {
          definedVars.push(identName.slice(1, -1));
        }
      }
      buildEnvironment(resolved, globalEnv);
      const jsCode = transpile(resolved, globalEnv);
      if (jsCode) {
        jsStatements.push(jsCode);
      }
    });

    const usedIdents = new Set();
    astLines.forEach(line => collectIdentifiers(line, usedIdents, globalEnv));

    const undefinedIdents = [];
    usedIdents.forEach(id => {
      if (!globalEnv.has(`<${id}>`) && id !== '_' && id !== 'print') {
        undefinedIdents.push(id);
      }
    });

    const undefinedDeclarations = undefinedIdents.map(id => `const ${id} = __unit;`).join('\n');

    const runtimeHelpers = `
import _ from 'white_cats';
import util from 'util';
import fs from 'fs';

${RUNTIME_HELPERS_CODE}
`;

    const loggingBlock = `
console.log("=== Execution Result ===");
${definedVars.map(v => `try { console.log("${v} = ", util.inspect(${v}, { depth: null, colors: true })); } catch(e) {}`).join('\n')}
`;

    const fullJsCode = `${runtimeHelpers}\n${undefinedDeclarations}\n${jsStatements.map(s => s + ';').join('\n')}\n${loggingBlock}`;

    // Output files
    const jsFilePath = filePath.replace(/\.(sign|sn)$/, '.js');
    const dtsFilePath = filePath.replace(/\.(sign|sn)$/, '.d.ts');

    fs.writeFileSync(jsFilePath, fullJsCode, 'utf8');
    generatedFiles.push(jsFilePath);
    generatedFiles.push(dtsFilePath);

    // Try to generate TS defs just to make sure it doesn't crash
    try {
      const resolvedLines = astLines.map(astLine => resolveCoproducts(astLine, globalEnv));
      const dtsCode = generateTypeScriptDef(resolvedLines, globalEnv);
      fs.writeFileSync(dtsFilePath, dtsCode, 'utf8');
    } catch (e) {
      // TS def generation is secondary, log but don't fail compile
      console.warn(`[Warning] TS definition generation failed for ${filePath}: ${e.message}`);
    }

  } catch (err) {
    compilationErrors[filePath] = err.stack || err.message;
  }
}

console.log(`\nCompilation phase complete. Starting execution phase...`);

const successList = [];
const failList = [];

// Phase 2: Execute all compiled tests
for (const filePath of files) {
  if (compilationErrors[filePath]) {
    failList.push({
      path: filePath,
      phase: 'Compile',
      error: compilationErrors[filePath]
    });
    continue;
  }

  const jsFilePath = filePath.replace(/\.(sign|sn)$/, '.js');

  try {
    execSync(`node ${jsFilePath}`, { encoding: 'utf8', stdio: 'pipe' });
    successList.push(filePath);
  } catch (err) {
    failList.push({
      path: filePath,
      phase: 'Execute',
      error: err.stdout || err.stderr || err.message
    });
  }
}

// Phase 3: Cleanup generated files
console.log(`\nCleaning up temporary generated files...`);
for (const gFile of generatedFiles) {
  if (fs.existsSync(gFile)) {
    fs.unlinkSync(gFile);
  }
}

// Output final results
console.log(`\n=== Test Suite Results ===`);
console.log(`Total tests run: ${files.length}`);
console.log(`Success: ${successList.length}`);
console.log(`Fail: ${failList.length}`);

if (failList.length > 0) {
  console.log(`\n--- Failed Tests Details ---`);
  failList.forEach(fail => {
    console.log(`\n[FAIL] [${fail.phase} Phase] ${fail.path}`);
    console.log(fail.error);
  });
  process.exit(1);
} else {
  console.log(`\nAll tests passed successfully!`);
  process.exit(0);
}
