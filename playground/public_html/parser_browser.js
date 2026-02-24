// parser_browser.js (先頭部分)
import operators from './operators.js';
import lexer from './prepare_lexer.js';

const { parseTable, semantics } = operators;

// --- AST Nodes ---
const createNode = (type, value, children = []) => ({ type, value, children });

// --- Operators ---

const ops = [
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
	{ symbol: "|", precedence: 12, notation: "infix", associativity: "left" }, // Logic OR (User def)
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
				if (token.length > 1) {
					refined.push(token);
				} else {
					refined.push({ type: 'operator', symbol: token, spacing: 'isolated' });
				}
			} else if (isOpSymbol(token)) {
				refined.push({ type: 'operator', symbol: token, spacing: 'isolated' });
			} else {
				const parts = splitAlphaSymbol(token);
				for (let i = 0; i < parts.length; i++) {
					const p = parts[i];
					if (isOpSymbol(p)) {
						let spacing = 'attached';
						if (i === 0) {
							spacing = 'prefix_attached';
						} else if (i === parts.length - 1) {
							spacing = 'postfix_attached';
						} else {
							spacing = 'both_attached';
						}
						refined.push({ type: 'operator', symbol: p, spacing: spacing });
					} else {
						refined.push(p);
					}
				}
			}
		} else {
			refined.push(token);
		}
	}
	return refined;
};

// --- Parser ---

const isSeparator = (token) => token && typeof token === 'object' && token.type === 'separator';

const APPLY_PREC = 6;

const parseExpr = (tokens, minPrec = 0) => {
	if (tokens.length === 0) return null;
	let peak = tokens[0];

	if (isSeparator(peak)) {
		return null;
	}

	// Helper to check if a token can start an expression
	const canStartExpr = (token) => {
		if (!token) return false;
		if (Array.isArray(token)) return true; // Block

		let value = token;
		let is_op = false;
		let spacing = null;

		if (typeof token === 'object' && token.type === 'operator') {
			value = token.symbol;
			is_op = true;
			spacing = token.spacing;
		}

		if (typeof token === 'string' || is_op) {
			if (typeof value === 'string') {
				if (value.startsWith && value.startsWith('`')) return true; // String
				if (value.startsWith && value.startsWith('\\')) return true; // Char
				if (!isNaN(parseFloat(value))) return true; // Number
			}
			if (is_op || (typeof value === 'string' && isOpSymbol(value))) {
				if (spacing === 'postfix_attached') return false;
				return !!findOp(value, 'prefix');
			}
			return true; // Identifier
		}
		return false;
	};

	let lhs = parseAtom(tokens);
	if (!lhs) return null;

	while (tokens.length > 0) {
		let lookahead = tokens[0];

		// Special handling for ambiguous `|`
		// If | is followed by something that CANNOT start an expression, treat it as terminator (Abs closing).
		if (lookahead === '|') {
			// Check next
			if (tokens.length > 1 && !canStartExpr(tokens[1])) {
				break; // Terminator
			}
			// Be careful: | | x | | -> Abs(Abs(x)).
			// | (first) -> Prefix.
			// | (second) -> Prefix.
			// x
			// | (third) -> Closing. Followed by |.
			// But | IS a Prefix op. So canStartExpr('|') is true.
			// So third | is treated as Infix?
			// | x | y.
			// | x | | y |.
			// If | x OP | y.
			// If | x | ... | (Infix) | (Prefix).

			// Simplification: | is Infix ONLY if followed by valid expr starter.
			// If | is followed by |, it matches Prefix |.
			// So | x | | y | -> Abs(x) | Abs(y).
		}

		if (isSeparator(lookahead)) {
			let sepCount = 0;
			while (sepCount < tokens.length && isSeparator(tokens[sepCount])) sepCount++;
			if (sepCount < tokens.length) {
				const nextOpTok = tokens[sepCount];
				let nextOpVal = null;
				let nextOpIsMap = false;
				if (typeof nextOpTok === 'object' && nextOpTok.type === 'operator') {
					nextOpVal = nextOpTok.symbol;
					nextOpIsMap = true;
				} else if (typeof nextOpTok === 'string' && isOpSymbol(nextOpTok)) {
					nextOpVal = nextOpTok;
					nextOpIsMap = true;
				}

				if (nextOpIsMap) {
					const opInfo = findOp(nextOpVal, 'infix') || findOp(nextOpVal, 'postfix');
					if (opInfo && opInfo.precedence >= minPrec && !canStartExpr(nextOpTok)) {
						tokens.splice(0, sepCount);
						lookahead = tokens[0];
					} else {
						break;
					}
				} else {
					break;
				}
			} else {
				break;
			}
		}

		let is_op = false;
		let opValue = null;
		let spacing = null;

		if (typeof lookahead === 'object' && lookahead.type === 'operator') {
			is_op = true;
			opValue = lookahead.symbol;
			spacing = lookahead.spacing;
		} else if (typeof lookahead === 'string' && isOpSymbol(lookahead)) {
			is_op = true;
			opValue = lookahead;
			spacing = 'isolated';
		}

		if (is_op) {
			const opSymbol = opValue;

			if (spacing === 'prefix_attached') {
				break;
			}

			let op;
			if (spacing === 'postfix_attached') {
				op = findOp(opSymbol, 'postfix');
			} else if (spacing === 'isolated') {
				op = findOp(opSymbol, 'infix');
			} else {
				op = findOp(opSymbol, 'infix') || findOp(opSymbol, 'postfix');
			}

			if (!op) {
				// Not infix/postfix -> Apply?
			} else {
				if (op.precedence < minPrec) break;

				tokens.shift();

				if (op.notation === 'postfix') {
					lhs = { type: 'postfix', op: opSymbol, expr: lhs };
					continue;
				}


				// Automatic Currying Logic for '?'
				if (opSymbol === '?') {

					// Helper: Create a lambda, handling Default Arguments (infix :)
					const makeLambda = (arg, body) => {
						// Handle Default Argument: arg is { type: 'infix', op: ':', left: param, right: defaultVal }
						if (arg.type === 'infix' && arg.op === ':') {
							const param = arg.left;
							const defaultVal = arg.right;
							const tempParamName = '$temp_' + (param.value || 'arg');

							// wrapper block: [ param : tempParam | defaultVal; body... ]

							let newBodyStatements = [];

							// Definition expr: param : tempParam | defaultVal
							const defExpr = {
								type: 'infix', op: ':',
								left: param,
								right: {
									type: 'infix', op: '|', // Logical OR
									left: { type: 'identifier', value: tempParamName },
									right: defaultVal
								}
							};
							newBodyStatements.push(defExpr);

							// Add original body
							if (body.type === 'block') {
								newBodyStatements.push(...body.body);
							} else {
								newBodyStatements.push(body);
							}

							const wrappedBody = {
								type: 'block',
								body: newBodyStatements
							};

							// Return: tempParam ? wrappedBody
							return {
								type: 'infix',
								op: '?',
								left: { type: 'identifier', value: tempParamName },
								right: wrappedBody
							};
						}

						// Standard Lambda
						return {
							type: 'infix',
							op: '?',
							left: arg,
							right: body
						};
					};

					// Recursive helper to transform apply chains and blocks into curried functions
					const curry = (expr, body) => {
						if (expr.type === 'apply') {
							// With default args: f ? makeLambda(a, body)
							return curry(expr.func, makeLambda(expr.arg, body));
						}

						// Support [arg1 arg2] ? body -> arg1 ? (arg2 ? body)
						if (expr.type === 'block') {
							let result = body;
							const args = expr.body;
							// If block is empty? [ ] ? body -> body
							if (args.length === 0) return body;

							for (let i = args.length - 1; i >= 0; i--) {
								result = curry(args[i], result);
							}
							return result;
						}

						// Base case
						return makeLambda(expr, body);
					};


					const nextMinPrec = op.associativity === 'right' ? op.precedence : op.precedence + 1;
					const rhs = parseExpr(tokens, nextMinPrec);

					// Rewrite Rule for Definition: f : args ? body -> f : (args ? body)
					// Because ':' has higher precedence than '?', 'f : args' is parsed as LHS.
					if (lhs.type === 'infix' && lhs.op === ':') {
						const defName = lhs.left;
						const defArgs = lhs.right;
						const curried = curry(defArgs, rhs);
						lhs = { type: 'infix', op: ':', left: defName, right: curried };
					} else {
						lhs = curry(lhs, rhs);
					}

					continue;
				}

				const nextMinPrec = op.associativity === 'right' ? op.precedence : op.precedence + 1;
				const rhs = parseExpr(tokens, nextMinPrec);
				lhs = { type: 'infix', op: opSymbol, left: lhs, right: rhs };
				continue;
			}
		}

		if (isSeparator(lookahead) || lookahead === '|') break;

		// Apply
		if (APPLY_PREC < minPrec) break;

		if (isSeparator(lookahead) || lookahead === '|') break;

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

	let value = token;
	let is_op = false;
	let spacing = null;

	if (typeof token === 'object' && token.type === 'operator') {
		value = token.symbol;
		is_op = true;
		spacing = token.spacing;
	} else if (typeof token === 'string') {
		if (isOpSymbol(token)) {
			is_op = true;
			spacing = 'isolated';
		}
	} else {
		return { type: 'unknown', token };
	}

	if (typeof value === 'string' || is_op) {
		if (value === '|') {
			const expr = parseExpr(tokens, 0);
			const next = tokens.shift();
			// User sample implies strict pairing.
			if (typeof next === 'object' && next.type === 'operator' && next.symbol !== '|') { }
			else if (typeof next === 'string' && next !== '|') { }
			return { type: 'abs', expr };
		}

		// Prefix Op
		if (is_op) {
			if (spacing !== 'postfix_attached') {
				const op = findOp(value, 'prefix');
				if (op) {
					const splitPrec = op.precedence;
					const rhs = parseExpr(tokens, splitPrec);
					return { type: 'prefix', op: value, expr: rhs };
				}
			}
			return { type: 'identifier', value: value, isOp: true };
		}

		if (typeof value === 'string') {
			if (value.startsWith && value.startsWith('`')) {
				return { type: 'string', value: value };
			}

			if (value.startsWith && value.startsWith('\\')) {
				return { type: 'char', value: value.slice(1) };
			}

			if (!isNaN(parseFloat(value))) {
				return { type: 'number', value: parseFloat(value) };
			}

			return { type: 'identifier', value: value };
		}
	}

	return { type: 'unknown', token };
};

const parseBlock = (tokens) => {
	// Check for Operator Section pattern in a "Block" (Array)
	// [ + 1 ] -> (x ? x + 1)
	// [ 1 + ] -> (x ? 1 + x)
	// [ + ]   -> (x ? y ? x + y)

	// Filter separators for analysis
	const cleanTokens = tokens.filter(t => !isSeparator(t));

	if (cleanTokens.length > 0) {
		// Case 1: [ op expr ] -> Right Section
		if (cleanTokens.length === 2 && typeof cleanTokens[0] === 'string' && isOpSymbol(cleanTokens[0])) {
			const op = cleanTokens[0];
			// Ensure it's not a prefix op like '!' if followed by expr? 
			// But `[ ! x ]` -> `_ ? ! x` ? Or `_ ? _ ! x` (infix)?
			// Assumption: If it's in [], and starts with Op, it's a section.
			// Unless it's a known prefix-only op?

			// We need to parse the rest to see if it's an expression
			// But parseExpr consumes tokens.
			// Let's try to parse the block as usual first.
		}
	}

	const exprs = [];
	const blockTokens = [...tokens];

	// Special handling for Operator Sections
	// If the block contains exactly [ op expr ] or [ expr op ] or [ op ]
	// We need to detect this BEFORE regular parsing, or start parsing and see?

	// Issue: `parseExpr` might consume `+ 1` as `(+ 1)` (prefix +). 
	// If `+` is infix, `+ 1` is invalid expr normally?
	// `parser.js` `parseAtom` handles prefix ops. 
	// `+` can be prefix (unary plus)? Sign doesn't have unary plus usually?
	// If `+` is only infix, `parseExpr` fails or returns null?

	// Let's check `processLine` in lexer. `[ + 1 ]` -> `['+', '1']`.

	const isSectionOp = (t) => typeof t === 'string' && isOpSymbol(t);

	// Try to detect section
	// 1. [ op ]
	if (cleanTokens.length === 1 && isSectionOp(cleanTokens[0])) {
		const op = cleanTokens[0];

		// Normal Lambda: x ? y ? x op y
		const opLambda = {
			type: 'infix', op: '?',
			left: { type: 'identifier', value: '$2' },
			right: {
				type: 'infix', op: '?',
				left: { type: 'identifier', value: '$3' },
				right: {
					type: 'infix', op: op,
					left: { type: 'identifier', value: '$2' },
					right: { type: 'identifier', value: '$3' }
				}
			}
		};

		// Composition Logic: $1 ? (_is_func $1) ? _compose(opLambda, $1) : opLambda($1)
		// Default: opLambda($1) -> y ? $1 op y
		const defaultCase = {
			type: 'infix', op: '?',
			left: { type: 'identifier', value: '$2' },
			right: {
				type: 'infix', op: op,
				left: { type: 'identifier', value: '$1' },
				right: { type: 'identifier', value: '$2' }
			}
		};

		return {
			type: 'infix', op: '?',
			left: { type: 'identifier', value: '$1' },
			right: {
				type: 'infix', op: ';',
				left: {
					type: 'infix', op: '?',
					left: {
						type: 'apply',
						func: { type: 'identifier', value: '_is_func' },
						arg: { type: 'identifier', value: '$1' }
					},
					right: {
						type: 'apply',
						func: {
							type: 'apply',
							func: { type: 'identifier', value: '_compose' },
							arg: opLambda
						},
						arg: { type: 'identifier', value: '$1' }
					}
				},
				right: defaultCase
			}
		};
	}

	// 2. [ op expr ] (Right Section: [+ 1] -> x + 1)
	if (cleanTokens.length >= 2 && isSectionOp(cleanTokens[0])) {
		const opStr = cleanTokens[0];
		if (findOp(opStr, 'infix')) {
			// Parse the rest as expr
			const content = [...tokens];
			// remove leading separators until op
			while (content.length > 0 && isSeparator(content[0])) content.shift();
			content.shift(); // remove op

			const rhs = parseExpr(content);
			if (rhs && content.every(t => isSeparator(t))) {

				// opLambda: $2 ? $2 op rhs
				const opLambda = {
					type: 'infix', op: '?',
					left: { type: 'identifier', value: '$2' },
					right: {
						type: 'infix', op: opStr,
						left: { type: 'identifier', value: '$2' },
						right: rhs
					}
				};

				// Default: $1 op rhs
				const defaultCase = {
					type: 'infix', op: opStr,
					left: { type: 'identifier', value: '$1' },
					right: rhs
				};

				return {
					type: 'infix', op: '?',
					left: { type: 'identifier', value: '$1' },
					right: {
						type: 'infix', op: ';',
						left: {
							type: 'infix', op: '?',
							left: {
								type: 'apply',
								func: { type: 'identifier', value: '_is_func' },
								arg: { type: 'identifier', value: '$1' }
							},
							right: {
								type: 'apply',
								func: {
									type: 'apply',
									func: { type: 'identifier', value: '_compose' },
									arg: opLambda
								},
								arg: { type: 'identifier', value: '$1' }
							}
						},
						right: defaultCase
					}
				};
			}
		}
	}

	// 3. [ expr op ] (Left Section: [1 +] -> 1 + x)
	if (cleanTokens.length >= 2 && isSectionOp(cleanTokens[cleanTokens.length - 1])) {
		const opStr = cleanTokens[cleanTokens.length - 1];
		if (findOp(opStr, 'infix')) {
			const content = [...tokens];
			while (content.length > 0 && isSeparator(content[content.length - 1])) content.pop();
			const last = content.pop(); // Op
			if (last === opStr) {
				const lhs = parseExpr(content);
				if (lhs && content.every(t => isSeparator(t))) {

					// opLambda: $2 ? lhs op $2
					const opLambda = {
						type: 'infix', op: '?',
						left: { type: 'identifier', value: '$2' },
						right: {
							type: 'infix', op: opStr,
							left: lhs,
							right: { type: 'identifier', value: '$2' }
						}
					};

					// Default: lhs op $1
					const defaultCase = {
						type: 'infix', op: opStr,
						left: lhs,
						right: { type: 'identifier', value: '$1' }
					};

					return {
						type: 'infix', op: '?',
						left: { type: 'identifier', value: '$1' },
						right: {
							type: 'infix', op: ';',
							left: {
								type: 'infix', op: '?',
								left: {
									type: 'apply',
									func: { type: 'identifier', value: '_is_func' },
									arg: { type: 'identifier', value: '$1' }
								},
								right: {
									type: 'apply',
									func: {
										type: 'apply',
										func: { type: 'identifier', value: '_compose' },
										arg: opLambda
									},
									arg: { type: 'identifier', value: '$1' }
								}
							},
							right: defaultCase
						}
					};
				}
			}
		}
	}


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
// ↓ 既存の process.argv や fs.readFileSync の部分を丸ごと以下の関数に置き換えます

export function parseSign(code) {
	// ファイル操作は行わず、純粋に文字列からASTを生成して返します
	const rawRoot = lexer.parseToSExpr(code);
	const refinedRoot = refineTokens(rawRoot);
	const ast = parseBlock(refinedRoot);
	return ast;
}