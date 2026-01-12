
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import prepareLexer from '../../utility/prepare_lexer.js';
import operators from '../../utility/operators.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const INPUT_FILE = path.join(__dirname, 'test_input.sn');
const OUTPUT_FILE = path.join(__dirname, 'test_output.json');

// --- Helpers ---
// Sort symbols longest first
// Add missing symbols from parseTable if any (user reported ~_)
let opSymbols = Object.keys(operators.parseTable);
if (!opSymbols.includes('~_')) opSymbols.push('~_');
opSymbols.sort((a, b) => b.length - a.length);

const escapeRegExp = (string) => string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

// --- Tokenizer ---

function tokenize(code) {
    let text = prepareLexer.prepare(code);
    text = prepareLexer.markSeparator(text);

    // Normalize Bracket, Newline, Tab to wrapped tokens.
    // Normalize Bracket, Newline, Tab to wrapped tokens.
    // Moved to prepareLexer.markSeparator

    let rawParts = text.split('\x1F');
    let finalTokens = [];

    // Updated Regexes
    // Hex: 0x..., Oct: 0o..., Bin: 0b...
    const numRegex = /^(-?(0x[0-9a-fA-F]+|0o[0-7]+|0b[0-1]+|\d+(\.\d+)?))/;
    // Identifier: Allow \S (escaped char) or standard chars
    const idRegex = /^([^\s\[\]\(\)\{\}#:,?~|&!=+\-*/%^$@<>\.'`\\]+|\\.)/;
    // String Literal Regex (Single Line strict)
    const strRegex = /^`[^`\r\n]*`/;

    for (let i = 0; i < rawParts.length; i++) {
        let chunk = rawParts[i];
        if (!chunk) continue;

        // --- FIX: Insert Space Marker BEFORE processing chunk ---
        if (i > 0 && finalTokens.length > 0) finalTokens.push({ type: 'space_marker' });

        // Check for Markers (Brackets/Newlines from split)
        if (['[', ']', '\n', '\t'].includes(chunk)) {
            finalTokens.push({ type: chunk === '\n' || chunk === '\t' ? 'marker' : 'marker', value: chunk });
        } else {
            // Manual Scan of Chunk
            let pos = 0;
            let subTokens = [];

            while (pos < chunk.length) {
                let remain = chunk.slice(pos);

                // 1. String Literal (Backticks)
                if (remain.startsWith('`')) {
                    let mStr = remain.match(strRegex);
                    if (mStr) {
                        subTokens.push({ type: 'string', value: mStr[0] });
                        pos += mStr[0].length;
                        continue;
                    } else {
                        // Unclosed or Multiline or Invalid -> Treat as "Line Comment"
                        // Consume until newline (or end of chunk)
                        let eol = remain.indexOf('\n');
                        if (eol === -1) pos = chunk.length;
                        else pos += eol;
                        continue;
                    }
                }

                let isNegLiteral = false;

                // 2. Negative Number Check (Context Aware)
                if (remain.startsWith('-')) {
                    // Check if looks like number (Hex/Dec/etc)
                    if (numRegex.test(remain)) { // matches -...
                        // Context check
                        let lastReal = null;
                        if (subTokens.length > 0) lastReal = subTokens[subTokens.length - 1];
                        else if (finalTokens.length > 0) {
                            let t = finalTokens[finalTokens.length - 1];
                            if (t.type === 'space_marker' && finalTokens.length > 1) t = finalTokens[finalTokens.length - 2];
                            else if (t.type === 'space_marker') t = null;
                            lastReal = t;
                        }

                        let isValLike = false;
                        if (lastReal) {
                            if (['number', 'string', 'identifier'].includes(lastReal.type)) isValLike = true;
                            if (lastReal.type === 'marker' && lastReal.value === ']') isValLike = true;
                            if (lastReal.type === 'operator') {
                                if (operators.parseTable[lastReal.value]?.notation === 'postfix') isValLike = true;
                                if (lastReal.value === '~_') isValLike = true;
                                if (lastReal.value === '_') isValLike = true;
                                if (lastReal.value === '!') isValLike = true;
                            }
                        }
                        if (!isValLike) isNegLiteral = true;
                    }
                }

                if (isNegLiteral) {
                    let m = remain.match(numRegex);
                    if (m) {
                        subTokens.push({ type: 'number', value: m[0] });
                        pos += m[0].length;
                        continue;
                    }
                }

                // 3. Operator
                let bestOp = null;
                for (let sym of opSymbols) {
                    if (remain.startsWith(sym)) {
                        if (!bestOp || sym.length > bestOp.length) bestOp = sym;
                    }
                }

                if (bestOp) {
                    subTokens.push({ type: 'operator', value: bestOp });
                    pos += bestOp.length;
                    continue;
                }

                // 4. Number (Positive)
                let mNum = remain.match(numRegex);
                if (mNum) {
                    subTokens.push({ type: 'number', value: mNum[0] });
                    pos += mNum[0].length;
                    continue;
                }

                // 5. Identifier (including Escapes)
                let mId = remain.match(idRegex);
                if (mId) {
                    subTokens.push({ type: 'identifier', value: mId[0] });
                    pos += mId[0].length;
                    continue;
                }

                pos++;
            }
            finalTokens.push(...subTokens);
        }
    }
    return finalTokens;
}

// --- Structurizer ---
function structurize(tokens) {
    let root = [];
    let stack = [{ list: root, indent: 0 }];
    const current = () => stack[stack.length - 1];

    for (let i = 0; i < tokens.length; i++) {
        let t = tokens[i];
        if (t.type === 'marker') {
            if (t.value === '[') {
                let newList = [];
                current().list.push(newList);
                stack.push({ list: newList, indent: current().indent, bracket: true });
            }
            else if (t.value === ']') {
                if (stack.length > 1 && stack[stack.length - 1].bracket) stack.pop();
            }
            else if (t.value === '\n') {
                let indent = 0;
                let j = i + 1;
                while (j < tokens.length) {
                    if (tokens[j].value === '\t') { indent++; j++; }
                    else if (tokens[j].type === 'space_marker') { j++; }
                    else { break; }
                }
                if (stack[stack.length - 1].bracket) {
                    i = j - 1;
                } else {
                    let currIndent = current().indent;
                    if (indent > currIndent) {
                        let newList = [];
                        current().list.push(newList);
                        stack.push({ list: newList, indent: indent });
                        i = j - 1;
                    } else if (indent < currIndent) {
                        while (stack.length > 1 && stack[stack.length - 1].indent > indent) stack.pop();
                        current().list.push({ type: 'newline_marker' });
                        i = j - 1;
                    } else {
                        current().list.push({ type: 'newline_marker' });
                        i = j - 1;
                    }
                }
            }
        } else {
            current().list.push(t);
        }
    }
    return root;
}

// --- Parser ---

const SPACE_OP = { precedence: 5, notation: 'infix', associativity: 'left' };

const overrides = {
    '!': { prefix: { p: 13, sym: '!_' }, postfix: { p: 18, sym: '_!' } },
    '~': { prefix: { p: 10, sym: '~_' }, infix: { p: 9, sym: '~' }, postfix: { p: 20, sym: '_~' } },
    '#': { prefix: { p: 1, sym: '#_' }, infix: { p: 3, sym: '#' } },
    '@': { prefix: { p: 23, sym: '@_' }, infix: { p: 22, sym: '@' }, postfix: { p: 29, sym: '_@' } },
    '~_': { infix: { p: 9, sym: '~_' }, prefix: { p: 10, sym: '~_' } },
    '+': { prefix: { p: 11 }, infix: { p: 11 } },
    '-': { prefix: { p: 11 }, infix: { p: 11 } },
    '*': { prefix: { p: 12 }, infix: { p: 12 } },
    '/': { infix: { p: 12 } }
};

function resolveOpInfo(op, type) {
    if (op === ' ') return SPACE_OP;
    if (overrides[op]) {
        let data = overrides[op][type];
        if (data) return { precedence: data.p, notation: type, symbol: (data.sym || op) };
    }
    let info = operators.parseTable[op];
    if (info && info.notation === type) return info;
    if (info) return info;
    return null;
}

function parseBlock(block) {
    if (!Array.isArray(block)) return convertNode(block);
    let processed = block.map(item => Array.isArray(item) ? parseBlock(item) : item);
    let expressions = [];
    let currentChunk = [];
    for (let token of processed) {
        if (token.type === 'newline_marker') {
            if (currentChunk.length > 0) {
                expressions.push(parseExpr(currentChunk));
                currentChunk = [];
            }
        } else {
            currentChunk.push(token);
        }
    }
    if (currentChunk.length > 0) expressions.push(parseExpr(currentChunk));
    if (expressions.length === 0) return ["_"];
    return expressions;
}

function parseExpr(tokens) {
    if (tokens.length === 0) return ["_"];
    let values = [];
    let ops = [];

    const applyOp = (opToken) => {
        let opValue = (opToken.info && opToken.info.symbol) ? opToken.info.symbol : opToken.value;
        let info = opToken.info || {};
        if (opToken.type === 'newline_marker') opValue = ',';

        if (!opToken.info) {
            if (opValue === ' ') info = SPACE_OP;
            else if (opValue === ',') info = operators.parseTable[','];
            else info = operators.parseTable[opValue] || {};
        }

        let node = [opValue];
        let notation = info.notation || 'infix';

        if (notation === 'infix') {
            let right = values.pop();
            let left = values.pop();
            if (left === undefined) {
                if (right !== undefined) node.push(right);
                else node.push("_");
            } else {
                node.push(left);
                if (right !== undefined) node.push(right);
            }
        } else {
            let arg = values.pop();
            if (arg !== undefined) node.push(arg);
            else node.push("_");
        }
        values.push(node);
    };

    let stream = [];

    // Pass 1: Resolve Types + Strict Infix Logic
    for (let i = 0; i < tokens.length; i++) {
        let t = tokens[i];

        if (Array.isArray(t)) {
            stream.push(t);
            continue;
        }

        if (t.type === 'space_marker') {
            if (stream.length > 0) {
                let prev = stream[stream.length - 1];
                let next = tokens[i + 1];

                if (isVal(prev)) {
                    if (next && isVal(next)) {
                        stream.push({ type: 'operator', value: ' ', info: SPACE_OP });
                    } else if (next && next.type === 'operator') {
                        next.hasSpaceBefore = true;
                    }
                }
            }
        } else if (t.type === 'newline_marker') {
            let commaInfo = operators.parseTable[','];
            stream.push({ type: 'newline_marker', value: ',', info: commaInfo });
        } else {
            if (t.type === 'operator') {
                let info = operators.parseTable[t.value];
                let prev = stream[stream.length - 1];
                let isPrevVal = prev && isVal(prev);

                if (!isPrevVal) {
                    t.info = resolveOpInfo(t.value, 'prefix');
                } else {
                    let hasSpaceAfter = (i + 1 < tokens.length && tokens[i + 1].type === 'space_marker');

                    if (t.hasSpaceBefore && hasSpaceAfter) {
                        t.info = resolveOpInfo(t.value, 'infix');
                    } else {
                        if (t.hasSpaceBefore && !hasSpaceAfter) {
                            stream.push({ type: 'operator', value: ' ', info: SPACE_OP });
                            t.info = resolveOpInfo(t.value, 'prefix');
                        } else if (!t.hasSpaceBefore) {
                            const tightOps = ['+', '-', '*', '/', '%', '^', '=', '<', '>', '<=', '>=', '!=', ':'];
                            let isTight = tightOps.includes(t.value);

                            if (isTight) {
                                t.info = resolveOpInfo(t.value, 'infix');
                            } else {
                                t.info = resolveOpInfo(t.value, 'postfix');
                                if (!t.info) t.info = resolveOpInfo(t.value, 'infix');
                            }
                        } else {
                            t.info = resolveOpInfo(t.value, 'infix');
                        }
                    }
                }
            }
            stream.push(t);
        }
    }

    // Pass 2: Shunting Yard
    for (let t of stream) {
        if (isVal(t)) {
            values.push(Array.isArray(t) ? t : convertNode(t));
        } else if (t.type === 'operator' || t.type === 'newline_marker') {
            let op = t;
            let info = op.info || {};
            let prec = info.precedence || 0;
            let assoc = info.associativity || 'left';

            while (ops.length > 0) {
                let top = ops[ops.length - 1];
                let topInfo = top.info || {};
                let topPrec = topInfo.precedence || 0;

                if ((assoc === 'left' && prec <= topPrec) || (assoc === 'right' && prec < topPrec)) {
                    applyOp(ops.pop());
                } else {
                    break;
                }
            }
            ops.push(op);
        }
    }

    while (ops.length > 0) {
        applyOp(ops.pop());
    }

    return values[0] || ["_"];
}

// Helpers
function isVal(t) {
    if (!t) return false;
    if (t.type === 'operator' && (t.value === '~_' || t.value === '_')) return true;
    return t.type === 'identifier' || t.type === 'number' || t.type === 'string' || t.type === 'literal' || Array.isArray(t);
}

function convertNode(node) {
    if (node.type === 'identifier') return node.value;
    if (node.type === 'operator') return node.value;
    if (node.type === 'number') {
        if (/^(-?0x|-?0o|-?0b)/.test(node.value)) return node.value;
        let n = Number(node.value);
        return isNaN(n) ? node.value : n;
    }
    if (node.type === 'string') return node.value;
    if (node.type === 'literal') return node.value;
    return node;
}

// --- Main ---

try {
    const code = fs.readFileSync(INPUT_FILE, 'utf8');
    const tokens = tokenize(code);
    const blocks = structurize(tokens);
    const result = parseBlock(blocks);

    fs.writeFileSync(OUTPUT_FILE, JSON.stringify(result, null, 2));
    console.log("Parsed Successfully.");
} catch (err) {
    console.error(err);
}
