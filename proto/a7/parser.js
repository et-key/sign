
import fs from 'fs';
import path from 'path';
import util from 'util';
import operators from './operators.js';
import lexer from './prepare_lexer.js';

const { parseTable, semantics } = operators;

// --- AST Nodes ---
const createNode = (type, value, children = []) => ({ type, value, children });

// --- Operators ---

const ops = [
	{ symbol: "#", precedence: Infinity, notation: "prefix" },
	{ symbol: "##", precedence: Infinity, notation: "prefix" },
	{ symbol: "###", precedence: Infinity, notation: "prefix" },
	{ symbol: ":", precedence: 2, notation: "infix", associativity: "right" },
	{ symbol: "#", precedence: 3, notation: "infix", associativity: "left" },
	{ symbol: ",", precedence: 6, notation: "infix", associativity: "right" },
	{ symbol: "?", precedence: 5, notation: "infix", associativity: "right" },
	{ symbol: "~", precedence: 9, notation: "infix" }, // Range
	{ symbol: "~+", precedence: 9, notation: "infix" },
	{ symbol: "~-", precedence: 9, notation: "infix" },
	{ symbol: "~*", precedence: 9, notation: "infix" },
	{ symbol: "~/", precedence: 9, notation: "infix" },
	{ symbol: "~^", precedence: 9, notation: "infix" },
	{ symbol: "~", precedence: 10, notation: "prefix", associativity: "right" }, // Continuous
	{ symbol: ";", precedence: 11, notation: "infix", associativity: "left" },
	{ symbol: "|", precedence: 12, notation: "infix", associativity: "left" },
	{ symbol: "&", precedence: 13, notation: "infix", associativity: "left" },
	{ symbol: "!", precedence: Infinity, notation: "prefix", associativity: "right" }, // Not
	{ symbol: "<", precedence: 14, notation: "infix", associativity: "left" },
	{ symbol: "<=", precedence: 14, notation: "infix", associativity: "left" },
	{ symbol: "=", precedence: 14, notation: "infix", associativity: "left" },
	{ symbol: "==", precedence: 14, notation: "infix", associativity: "left" },
	{ symbol: ">=", precedence: 14, notation: "infix", associativity: "left" },
	{ symbol: ">", precedence: 14, notation: "infix", associativity: "left" },
	{ symbol: "!=", precedence: 14, notation: "infix", associativity: "left" },
	{ symbol: "+", precedence: 15, notation: "infix", associativity: "left" },
	{ symbol: "-", precedence: 15, notation: "infix", associativity: "left" },
	{ symbol: "*", precedence: 16, notation: "infix", associativity: "left" },
	{ symbol: "/", precedence: 16, notation: "infix", associativity: "left" },
	{ symbol: "%", precedence: 16, notation: "infix", associativity: "left" },
	{ symbol: "^", precedence: 17, notation: "infix", associativity: "right" },
	{ symbol: "!", precedence: Infinity, notation: "postfix", associativity: "left" }, // Factorial
	{ symbol: "~", precedence: 23, notation: "postfix", associativity: "left" }, // Expand/Run
	{ symbol: "$", precedence: Infinity, notation: "prefix", associativity: "right" },
	{ symbol: "'", precedence: 22, notation: "infix", associativity: "left" },
	{ symbol: "@", precedence: 22, notation: "infix", associativity: "right" },
	{ symbol: "@", precedence: Infinity, notation: "prefix", associativity: "right" }, // Input?
	{ symbol: "<<", precedence: 24, notation: "infix", associativity: "left" },
	{ symbol: ">>", precedence: 24, notation: "infix", associativity: "left" },
	{ symbol: "||", precedence: 25, notation: "infix", associativity: "left" },
	{ symbol: ";;", precedence: 26, notation: "infix", associativity: "left" },
	{ symbol: "&&", precedence: 27, notation: "infix", associativity: "left" },
	{ symbol: "!!", precedence: Infinity, notation: "prefix", associativity: "right" },
	{ symbol: "@", precedence: Infinity, notation: "postfix" }, // Import
	{ symbol: "\\", precedence: 31, notation: "prefix" } // Escape/Char
];

const findOp = (symbol, notation) => {
	return ops.find(op => op.symbol === symbol && op.notation === notation);
};

// Check if a string is a known operator symbol
const isOpSymbol = (str) => ops.some(op => op.symbol === str);

// --- Token Processing ---

const splitAlphaSymbol = (str) => {
	const parts = [];
	let remaining = str;

	while (remaining.length > 0) {
		// 1. Try Number
		const numMatch = remaining.match(/^(-?\d+(\.\d+)?)/);
		if (numMatch) {
			const numStr = numMatch[0];
			if (numStr === '-' && remaining.length > 1 && !/\d/.test(remaining[1])) {
				// Just minus symbol
			} else {
				parts.push(numStr);
				remaining = remaining.slice(numStr.length);
				continue;
			}
		}

		// 2. If starts with WordChar (Alpha + _)
		const wordMatch = remaining.match(/^([a-zA-Z_][a-zA-Z0-9_]*)/);
		if (wordMatch) {
			parts.push(wordMatch[0]);
			remaining = remaining.slice(wordMatch[0].length);
			continue;
		}

		// 3. If starts with Symbol
		// Includes `\` as symbol
		const symMatch = remaining.match(/^([!#$%&'*+,\-./:;<=>?@^|~\\]+)/);
		if (symMatch) {
			const sym = symMatch[0];
			let symRem = sym;
			while (symRem.length > 0) {
				// Find longest prefix that is an op
				let found = false;
				for (let len = symRem.length; len > 0; len--) {
					const sub = symRem.slice(0, len);
					if (isOpSymbol(sub)) {
						parts.push(sub);
						symRem = symRem.slice(len);
						found = true;
						break;
					}
				}
				if (!found) {
					// If no op matches, consume one char as unknown op/symbol
					parts.push(symRem[0]);
					symRem = symRem.slice(1);
				}
			}

			remaining = remaining.slice(sym.length);
			continue;
		}

		// 4. Catch all
		parts.push(remaining[0]);
		remaining = remaining.slice(1);
	}

	return parts;
};

const refineTokens = (rawTokens) => {
	const refined = [];
	for (const token of rawTokens) {
		if (Array.isArray(token)) {
			refined.push(refineTokens(token));
		} else if (typeof token === 'object') {
			refined.push(token); // Separators
		} else if (typeof token === 'string') {
			if (token.startsWith('`')) {
				refined.push(token);
			} else if (token.startsWith('\\')) {
				// Special handling for `\` token from lexer
				// Lexer returns `\` + char (2 chars) usually.
				// But `splitAlphaSymbol` handles `\` as symbol.
				// If it is `\c` (2 chars), it might be `\` op applied to `c`?
				// Or literal?
				// `example.ja-jp.sn`: `M: \M` -> Char literal?
				// If we treat it as literal here, `parser` is simpler.
				// If length > 1, treating as Char Literal seems safer for `\M`.
				// But `\` `\n` ?
				// If `\` is alone token?
				if (token.length > 1) {
					refined.push(token); // Treat as unit (Char literal likely)
				} else {
					refined.push(token); // Just `\` op
				}
			} else {
				const parts = splitAlphaSymbol(token);
				refined.push(...parts);
			}
		} else {
			refined.push(token);
		}
	}
	return refined;
};

// --- Parser ---

const isSeparator = (token) => token && typeof token === 'object' && token.type === 'separator';

const APPLY_PREC = 4;

const parseExpr = (tokens, minPrec = 0) => {
	if (tokens.length === 0) return null;
	let peak = tokens[0];

	if (isSeparator(peak)) {
		return null;
	}

	let lhs = parseAtom(tokens);
	if (!lhs) return null;

	while (tokens.length > 0) {
		let lookahead = tokens[0];

		if (typeof lookahead === 'string' && isOpSymbol(lookahead)) {
			const opSymbol = lookahead;

			let op = findOp(opSymbol, 'infix') || findOp(opSymbol, 'postfix');

			if (!op) {
				// Not infix/postfix -> Apply?
			} else {
				if (op.precedence < minPrec) break;

				tokens.shift();

				if (op.notation === 'postfix') {
					lhs = { type: 'postfix', op: opSymbol, expr: lhs };
					continue;
				}

				// Infix
				const nextMinPrec = op.associativity === 'right' ? op.precedence : op.precedence + 1;
				const rhs = parseExpr(tokens, nextMinPrec);
				lhs = { type: 'infix', op: opSymbol, left: lhs, right: rhs };
				continue;
			}
		}

		if (isSeparator(lookahead)) break;

		// Apply
		if (APPLY_PREC < minPrec) break;

		if (isSeparator(lookahead)) break;

		const rhsAtom = parseExpr(tokens, APPLY_PREC + 1);
		if (rhsAtom) {
			lhs = { type: 'apply', func: lhs, arg: rhsAtom };
		} else {
			break;
		}
	}

	return lhs;
};

const parseAtom = (tokens) => {
	const token = tokens.shift();
	if (!token) return null;

	if (Array.isArray(token)) {
		return parseBlock(token);
	}

	if (typeof token === 'string') {
		const value = token;

		// Prefix Op
		if (isOpSymbol(value)) {
			const op = findOp(value, 'prefix');
			if (op) {
				const splitPrec = op.precedence;
				// Special case escaping
				// If we had `\` alone, next token is char?
				// But `refineTokens` keeps `\c` together.
				const rhs = parseExpr(tokens, splitPrec);
				return { type: 'prefix', op: value, expr: rhs };
			}
			return { type: 'identifier', value: value, isOp: true };
		}

		if (value.startsWith('`')) {
			return { type: 'string', value: value };
		}

		if (value.startsWith('\\')) {
			return { type: 'char', value: value.slice(1) };
		}

		if (!isNaN(parseFloat(value))) {
			return { type: 'number', value: parseFloat(value) };
		}

		return { type: 'identifier', value: value };
	}

	return { type: 'unknown', token };
};

const parseBlock = (tokens) => {
	const exprs = [];
	const blockTokens = [...tokens];

	while (blockTokens.length > 0) {
		if (isSeparator(blockTokens[0])) {
			blockTokens.shift();
			continue;
		}

		const expr = parseExpr(blockTokens);
		if (expr) {
			exprs.push(expr);
		} else {
			if (blockTokens.length > 0) blockTokens.shift();
		}
	}

	if (exprs.length === 0) return { type: 'unit' };
	if (exprs.length === 1) return exprs[0];

	return { type: 'block', body: exprs };
};


// --- Main ---

const file = process.argv[2];
if (file) {
	const code = fs.readFileSync(file, 'utf8');
	const rawRoot = lexer.parseToSExpr(code);
	const refinedRoot = refineTokens(rawRoot);
	const ast = parseBlock(refinedRoot);
	console.log(JSON.stringify(ast, null, 2));
}
