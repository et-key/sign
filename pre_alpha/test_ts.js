// pre_alpha/test_ts.js
import fs from 'fs';
import path from 'path';
import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { buildEnvironment, desugarHoles } from './semanticize/ast_helpers.js';
import { generateTypeScriptDef } from './backend/ts_codegen.js';

const sourceCode = `
\` 1. Eager Fold (Trampoline Extraction)
add : x y ? x + y
fold_eager : f a x ~y ? fold_eager f [@f a x] y~

\` 2. Generator map
map : g x ~y ? [@g x] [map g y~]

\` 3. Value
num : 42
`;

try {
  console.log('Compiling test source...');
  const preprocessed = preprocess(sourceCode);
  const astProg = parser.parse(preprocessed);

  let globalEnv = new Map();
  const rawLines = astProg.filter(line => line !== null && line !== undefined);
  const astLines = rawLines.map(desugarHoles);

  astLines.forEach(astLine => {
    buildEnvironment(astLine, globalEnv);
  });

  const resolvedLines = astLines.map(astLine => {
    const resolved = resolveCoproducts(astLine, globalEnv);
    buildEnvironment(resolved, globalEnv);
    return resolved;
  });

  const dtsOutput = generateTypeScriptDef(resolvedLines, globalEnv);

  const outPath = path.join(process.cwd(), 'pre_alpha', 'out.d.ts');
  fs.writeFileSync(outPath, dtsOutput, 'utf-8');

  console.log(`Successfully generated TS definition at ${outPath}`);
  console.log('--- out.d.ts ---\n' + dtsOutput);

} catch (err) {
  console.error('Compiler Error:', err.message);
}
