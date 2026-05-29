import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';

const code = `fib : n ?
	n < 2 : n
	\`\` (fib (n - 1)) + (fib (n - 2))

result : fib 10
print result
            `;

console.log('Preprocessed:', JSON.stringify(preprocess(code.trim())));
try {
    parser.parse(preprocess(code.trim()));
    console.log('OK');
} catch (e) {
    if (e.location) {
        console.error(`[Parse Error] Expected ${e.expected.map(ex => ex.text ? `"${ex.text}"` : `[${ex.parts.join('')}]`).join(', ')} but "${e.found}" found at line ${e.location.start.line}`);
    } else {
        console.error(e.message);
    }
}
