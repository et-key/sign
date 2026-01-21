import fs from 'fs';
import path from 'path';
import { parse } from './parser.js';

const workDir = process.cwd();

// --- Helpers ---
const isAtom = (s) => !Array.isArray(s);
const isString = (s) => typeof s === 'string' && s.startsWith('`') && s.endsWith('`');
const unquote = (s) => s.slice(1, -1);

// --- Expander State ---
// We need a context to hold definitions.
// Global context for the expansion process.

function evaluate(node, context, baseDir) {
    if (isAtom(node)) {
        // Variable lookup (Constant folding / Macro Substitution)
        if (context[node]) return context[node];
        return node;
    }

    if (node.length === 0) return node;

    // Special Forms
    // 1. Definition: [":", name, value]
    //    In Sign, define is an expression that returns the value, but also binds name in current scope.
    //    For macro substitution, we update the context and return the value (or unit?).
    //    Actually, if it's a top-level define, we want to register it.
    if (node[0] === ':') {
        const name = node[1];
        const val = evaluate(node[2], context, baseDir);
        context[name] = val;
        return ["_"]; // Definitions return Unit in runtime, but here we just want side effect?
        // Wait, user example: add : ... -> then [add 2 3]
        // The definition line itself might disappear or become Unit in the final S-expr?
        // User's example `main.sxpr.sn` showed `[[+] 2 3]`.
        // The `add : ...` line was gone or substituted.
        // Let's assume we return `val` or `_`, but subsequent usages use `val`.
        return val;
    }

    // 2. Import (Postfix @): ["_@", "filename"] (Based on parser.js:224 postfix @ -> _@)
    //    Wait, parser mapping says: postfix { p: 29, sym: '_@' }
    //    So ` `filename`@ ` -> `["_@", "`filename`"]`
    if (node[0] === '_@') {
        const fileRaw = node[1];
        if (isString(fileRaw)) {
            const relPath = unquote(fileRaw);
            const absPath = path.resolve(baseDir, relPath);
            const fileDir = path.dirname(absPath);

            const content = fs.readFileSync(absPath, 'utf8');
            const parsed = parse(content); // Returns list of expressions

            // Process the imported file to extract EXPORTS via #
            const exports = {};
            // We need to evaluate the file content to resolve exports
            // But imported file might have its own definitions.
            // We create a scope for that file.
            const fileContext = {};

            for (let expr of parsed) {
                // Check if export expression: ["#_", [":", name, val]] or similar
                // Operators: # -> prefix #_
                // # name : val -> ["#_", [":", name, val]]

                // We need to handle recursive evaluation of the file imports
                const result = evaluate(expr, fileContext, fileDir);

                // If it was an export, add to exports
                if (Array.isArray(expr) && (expr[0] === '#_' || expr[0] === '##_' || expr[0] === '###_')) {
                    // Extract name from inside definition
                    // definition is expr[1] -> [":", name, val]
                    if (Array.isArray(expr[1]) && expr[1][0] === ':') {
                        const name = expr[1][1];
                        // The value in fileContext[name] should be the resolved value
                        if (fileContext[name]) {
                            exports[name] = fileContext[name];
                        }
                    }
                }
            }
            return { __type: 'module', exports };
        }
    }

    // 3. Lookup (Infix @): ["@", "name", module] (or ["@", module, "name"]?)
    //    Parser: infix { p: 22, sym: '@' }, associativity: right
    //    User said: "Right unit, right associative get"
    //    `add @ `add.sn`@`
    //    Right assoc means `a @ b @ c` -> `a @ (b @ c)`
    //    But here `name @ module`.
    //    If mapped to `["@", name, module]`.
    if (node[0] === '@') {
        const key = node[1];
        const obj = evaluate(node[2], context, baseDir);

        if (obj && obj.__type === 'module') {
            if (obj.exports[key]) return obj.exports[key];
            throw new Error(`Export '${key}' not found in module.`);
        }
        // Fallback for runtime @? Or expand if possible.
    }

    // Normal Expression: recursively expand
    const newVal = node.map(child => evaluate(child, context, baseDir));

    // Check if HEAD is a macro/function that we can inline?
    // User only asked for `define` substitution.

    return newVal;
}

// Main execution
const inputFile = process.argv[2];
if (!inputFile) process.exit(1);

const fullPath = path.resolve(process.cwd(), inputFile);
const baseDir = path.dirname(fullPath);
const code = fs.readFileSync(fullPath, 'utf8');
const ast = parse(code);

const globalContext = {};
let finalExprs = [];

for (let expr of ast) {
    const res = evaluate(expr, globalContext, baseDir);
    // Filter out definitions from final output if we want pure replacement?
    // User example: `[add 2 3]` -> `[[+] 2 3]`
    // The `add : ...` part didn't appear in the output.
    // So if expr was a definition or import, maybe we don't emit it?
    // We only emit "top level execution" expressions.

    // Heuristic: If it returns undefined or it was a definition, skip.
    // But evaluate returns the value.

    // Let's filter: Only emit if it's NOT a definition expression in the source AST.
    // Or better, logic:
    // If the AST node was `define` or `import` or `export`, it is "Statement".
    // If it is `[...]` or call, it is "Expression".

    const isStatement = (item) => {
        if (!Array.isArray(item)) return false;
        if (item[0] === ':') return true;
        if (item[0] === '#_') return true;
        if (item[0] === '##_') return true;
        if (item[0] === '###_') return true;
        return false;
    };

    if (!isStatement(expr)) {
        finalExprs.push(res);
    }
}

console.log(JSON.stringify(finalExprs, null, 2));
