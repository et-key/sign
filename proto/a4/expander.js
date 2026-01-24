import fs from 'fs';
import path from 'path';
import { parse } from './parser.js';

const workDir = process.cwd();

// --- Helpers ---
const isAtom = (s) => !Array.isArray(s);
const isString = (s) => typeof s === 'string' && s.startsWith('`') && s.endsWith('`');
const unquote = (s) => s.slice(1, -1);

function evaluate(node, context, baseDir) {
    if (isAtom(node)) {
        // Variable lookup (Constant folding / Macro Substitution)
        if (context[node]) {
            const val = context[node];
            // Don't inline complex objects (functions/lists) to avoid infinite recursion
            // and allow compiler to use named calls (BL label).
            // Also, if it's a module, we might want to return it? 
            // For now: only inline primitives or simple atoms.
            if (Array.isArray(val) || (typeof val === 'object' && val !== null)) {
                return node;
            }
            return val;
        }
        return node;
    }

    if (node.length === 0) return node;

    // 1. Definition: [":", name, value]
    if (node[0] === ':') {
        const name = node[1];
        const val = evaluate(node[2], context, baseDir);
        context[name] = val;
        // Return the definition node with evaluated body so compiler sees it
        return [":", name, val];
    }

    // 2. Import (Postfix @): ["_@", "filename"]
    if (node[0] === '_@') {
        const fileRaw = node[1];
        if (isString(fileRaw)) {
            const relPath = unquote(fileRaw);
            const absPath = path.resolve(baseDir, relPath);
            const fileDir = path.dirname(absPath);

            if (!fs.existsSync(absPath)) {
                throw new Error(`Import file not found: ${absPath}`);
            }

            const content = fs.readFileSync(absPath, 'utf8');
            const parsed = parse(content);

            const fileContext = {};
            const exports = {};

            for (let expr of parsed) {
                // recursively evaluate imports
                const result = evaluate(expr, fileContext, fileDir);

                // Export handling
                if (Array.isArray(result) && (result[0] === '#_' || result[0] === '##_' || result[0] === '###_')) {
                    // result is ["#_", [":", name, val]] usually.
                    // The inner definition returns [":", name, val]
                    const inner = result[1];
                    if (Array.isArray(inner) && inner[0] === ':') {
                        const name = inner[1];
                        if (fileContext[name]) {
                            exports[name] = fileContext[name];
                        }
                    }
                }
            }
            return { __type: 'module', exports };
        }
    }

    // 3. Lookup (Infix @): ["@", "name", module]
    if (node[0] === '@') {
        const key = node[1];
        const obj = evaluate(node[2], context, baseDir);

        if (obj && obj.__type === 'module') {
            if (obj.exports[key]) return obj.exports[key];
            throw new Error(`Export '${key}' not found in module.`);
        }
    }

    // Normal Expression: recursively expand
    const newVal = node.map(child => evaluate(child, context, baseDir));
    return newVal;
}

// --- Main ---
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
    finalExprs.push(res);
}

console.log(JSON.stringify(finalExprs, null, 2));
