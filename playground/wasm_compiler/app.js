import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { buildEnvironment } from './semanticize/builder.js';
import { resolveCoproducts } from './semanticize/coproduct_resolver.js';
import { evaluate } from './semanticize/evaluator.js';
import { evaluateType } from './semanticize/type_evaluator.js';
import { analyzeSemantics } from './backend/semantic_analyzer.js';
import { generateWasm } from './backend/wasm_emitter.js';

let wabtInstance = null;

async function initWabt() {
    if (!wabtInstance && window.WabtModule) {
        wabtInstance = await window.WabtModule();
    }
}

function appendToConsole(text) {
    const consoleOutput = document.getElementById('console-output');
    consoleOutput.textContent += text + '\n';
    consoleOutput.scrollTop = consoleOutput.scrollHeight;
}

function clearConsole() {
    document.getElementById('console-output').textContent = '';
}

async function compileAndRun() {
    clearConsole();
    const sourceCode = document.getElementById('editor').value.trim();
    const watOutput = document.getElementById('wat-output');
    watOutput.textContent = 'Compiling...';

    try {
        // 1. Lexer
        const preprocessed = preprocess(sourceCode);
        
        // 2. Parser
        const astProgram = parser.parse(preprocessed);
        const astLines = astProgram.filter(line => line !== null && line !== undefined);

        // 3. Semantic Pipeline
        let globalEnv = new Map();
        let typeEnv = new Map();

        const astTrees = astLines.map(astLine => {
            let astTree = buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);
            globalEnv = buildEnvironment(astTree, globalEnv);
            astTree = resolveCoproducts(astTree, globalEnv);
            const evalTree = evaluate(astTree, globalEnv);
            const resolvedType = evaluateType(evalTree, typeEnv);
            return { ...astTree, inferredType: resolvedType };
        });

        // 4. Generate IR
        const irProgram = analyzeSemantics(astTrees);

        // 5. Generate WebAssembly Text (WAT)
        const watContent = generateWasm(irProgram);
        watOutput.textContent = watContent;

        // 5. Assemble to WASM Binary
        await initWabt();
        if (!wabtInstance) {
            throw new Error("WABT module not loaded. Please check your internet connection or CDN.");
        }

        const wasmModule = wabtInstance.parseWat('playground.wat', watContent, { exceptions: true, mutable_globals: true, simd: true });
        wasmModule.resolveNames();
        wasmModule.validate();
        const binaryOutput = wasmModule.toBinary({ log: true, write_debug_names: true });

        // 6. Execute WASM
        const importObject = {
            env: {
                print: (val) => {
                    appendToConsole(`> [print] ${val}`);
                }
            }
        };

        const { instance } = await WebAssembly.instantiate(binaryOutput.buffer, importObject);
        
        if (instance.exports.main) {
            appendToConsole(`> [main()] = ${instance.exports.main()}`);
        } else if (instance.exports.result) {
            appendToConsole(`> [result()] = ${instance.exports.result()}`);
        } else {
            appendToConsole("> [Warning] No 'main' or 'result' function exported.");
        }

    } catch (err) {
        console.error(err);
        if (err.location) {
            const errMsg = `[Parse Error] Expected ${err.expected.map(e => e.text ? `"${e.text}"` : `[${e.parts.join('')}]`).join(', ')} but "${err.found}" found.`;
            appendToConsole(errMsg);
            watOutput.textContent = 'Error during parsing.';
        } else {
            appendToConsole(`[Error] ${err.message}`);
            if (err.message.includes('parseWat failed') || err.message.includes('validate failed')) {
                // Keep the WAT output visible if compilation failed, to help debugging
            } else {
                watOutput.textContent = 'Compilation failed.';
            }
        }
    }
}

// Bind event listener
document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('run-btn').addEventListener('click', compileAndRun);
    initWabt().catch(err => console.error("Failed to initialize WABT:", err));
});
