const fs = require('fs');
const path = require('path');
const { OperatorList, OperatorPriority } = require('../../utility/operators.js');

// ----------------------------------------------------------------------------
// Token Types
// ----------------------------------------------------------------------------
const TokenType = {
    IDENTIFIER: 'IDENTIFIER',
    NUMBER: 'NUMBER',
    STRING: 'STRING',
    OPERATOR: 'OPERATOR',
    KEYWORD: 'KEYWORD', // Not used much in Sign (no reserved words)
    INDENT: 'INDENT',
    DEDENT: 'DEDENT',
    NEWLINE: 'NEWLINE',
    LPAREN: 'LPAREN', // (
    RPAREN: 'RPAREN', // )
    LBRACKET: 'LBRACKET', // [
    RBRACKET: 'RBRACKET', // ]
    LBRACE: 'LBRACE', // {
    RBRACE: 'RBRACE', // }
    COMMA: 'COMMA',   // ,
    CHAR: 'CHAR',     // Character literal specified by \
    EOF: 'EOF'
};

// ----------------------------------------------------------------------------
// Helper: Sort operators by length descending to match longest first
// ----------------------------------------------------------------------------
// Flatten the OperatorList to get simple strings
// OperatorList is [{ op: { ... } }, ...]
const infixOps = OperatorList.map(obj => Object.keys(obj)[0]);
const prefixOps = Object.keys(OperatorPriority.prefix || {});
const postfixOps = Object.keys(OperatorPriority.postfix || {});
const surroundOps = Object.keys(OperatorPriority.surround || {});

const allOperators = [...infixOps, ...prefixOps, ...postfixOps, ...surroundOps];
// Unique and sorted
const uniqueOperators = [...new Set(allOperators)].sort((a, b) => b.length - a.length);

// Special handling for operators that might be surrounded by spaces (Infix)
// The user suggested treating " + " as a token.
// We will look for these first if they exist.
// However, the input string will be processed sequentially.
// We need to define regexes.

class Lexer {
    constructor(input) {
        this.input = input.replace(/\r\n/g, '\n');
        this.tokens = [];
        this.indentStack = [0]; // Initial indent level 0
        this.lines = this.input.split('\n');
        this.currentLine = 0;
    }

    tokenize() {
        for (let i = 0; i < this.lines.length; i++) {
            this.currentLine = i + 1;
            const line = this.lines[i];

            // 1. Handle Indentation (only for non-empty lines)
            if (line.trim().length === 0) continue;

            const indentLevel = this.getIndentLevel(line);

            // Check indent change
            const currentIndent = this.indentStack[this.indentStack.length - 1];
            if (indentLevel > currentIndent) {
                this.indentStack.push(indentLevel);
                this.tokens.push(this.createToken(TokenType.INDENT, '\t'.repeat(indentLevel))); // Represent with tabs in value? Or just empty
            } else if (indentLevel < currentIndent) {
                while (this.indentStack.length > 1 && this.indentStack[this.indentStack.length - 1] > indentLevel) {
                    this.indentStack.pop();
                    this.tokens.push(this.createToken(TokenType.DEDENT, ''));
                }
                if (this.indentStack[this.indentStack.length - 1] !== indentLevel) {
                    throw new Error(`Line ${this.currentLine}: Invalid indentation level.`);
                }
            }

            // 2. Tokenize the content of the line
            // Remove leading whitespace for processing (indentation handled)
            let content = line.trimStart();
            // Note: If we trimStart, we lose the exact position for " + ".
            // Actually, if we want to detect " + ", we should check the original text relative to previous token?
            // " a + b " -> tokens: "a", " + ", "b"?
            // If I trimStart, I have "a + b".

            // User hint: "中置演算子に空白含めた「 + 」として処理すれば楽"
            // This means " + " (space plus space) should be detected.
            // If I split by space, I get ["a", "+", "b"].
            // If I search for " + ", I find it.

            // Let's iterate through the string.
            let cursor = 0;
            while (cursor < content.length) {
                const rest = content.slice(cursor);

                // Skip simple spaces (unless part of " + ")
                // Wait, if " + " is the token, I can't skip spaces blindly before checking operators.

                // Priority 1: Check whitespace-surrounded operators (Infix)
                // Pattern: Starts with space, Operator, Ends with space?
                // Actually, just checking if " + " is at cursor?
                // If cursor is at start of line "a + b", current is "a".
                // After "a", cursor is at space.
                // Rest is " + b".
                // Match " + " (space + space).

                let matched = false;

                // 1. Whitespace (Skip if it's not part of an operator sequence)
                // But wait, " + " starts with space. So we must check operators starting with space first?
                // No, standard operators in `allOperators` do NOT include spaces.
                // New strategy:
                // Construct a regex that matches:
                // - Strings: "..." or `...`
                // - " <op> ": Space + Operator + Space (Infix candidate)
                // - Operators: <op>
                // - Numbers
                // - Identifiers
                // - Brackets

                // 1. Strings (Backticks only, single line, no escapes)
                // User provided regex: /^`([^`\r\n]*)`/
                let match = rest.match(/^`([^`\r\n]*)`/);
                if (match) {
                    this.tokens.push(this.createToken(TokenType.STRING, match[1]));
                    cursor += match[0].length;
                    continue;
                }

                // 2. Character Literals (Specified by \)
                // Matches \ followed by ANY single character (including newline)
                match = rest.match(/^\\([\s\S])/);
                if (match) {
                    this.tokens.push(this.createToken(TokenType.CHAR, match[1]));
                    cursor += match[0].length;
                    continue;
                }

                // 2. Whitespace-surrounded Operators (Infix Optimization)
                // We verify strictly if we have " <op> ".
                // Note: This only applies if we are NOT at the very beginning of line (which we trimmed).
                // Actually we trimmed start, so first token won't have leading space.
                // Subsequent tokens might start with space.
                // e.g. "a + b" -> "a" matched. cursor at " + b".
                // MATCH: " + "

                // We need to match ANY operator from uniqueOperators surrounded by spaces.
                // BUT, regex for operators needs escaping.

                // Try matching space + op + space
                // Iterate operators. Slower but safer logic first.
                // Optimization: Regex for all ops:
                // const opPattern = uniqueOperators.map(escapeRegex).join('|');
                // const infixPattern = new Regex(`^\\s+(${opPattern})\\s+`);

                // Let's implement this dynamic regex construction in the class or outside.

                if (rest.startsWith(' ')) {
                    // Potential infix operator or just space
                    const infixMatch = this.matchInfixOperator(rest);
                    if (infixMatch) {
                        this.tokens.push(this.createToken(TokenType.OPERATOR, infixMatch.op));
                        cursor += infixMatch.length; // consumes " + "
                        continue;
                    }

                    // Just space, skip it
                    cursor++;
                    continue;
                }

                // 3. Brackets / Delimiters that are not in operator list?
                // (, ), [, ], {, }
                // Check these specifically.
                if (/^[()\[\]{},]/.test(rest.charAt(0))) {
                    // Check if it's part of a longer operator first? (e.g. `(>`) ? No such operator.
                    // But `,` is in OperatorList. `(` is not.
                    // If it's in OperatorList, it will be caught by Step 4.
                    // If NOT in OperatorList, catch here.
                    // Actually `(` is not in operator list.
                    const char = rest.charAt(0);
                    if (['(', ')', '[', ']', '{', '}'].includes(char)) {
                        let type = TokenType.LPAREN;
                        if (char === ')') type = TokenType.RPAREN;
                        if (char === '[') type = TokenType.LBRACKET;
                        if (char === ']') type = TokenType.RBRACKET;
                        if (char === '{') type = TokenType.LBRACE;
                        if (char === '}') type = TokenType.RBRACE;

                        this.tokens.push(this.createToken(type, char));
                        cursor++;
                        continue;
                    }
                }

                // 4. Numbers (Check before operators to handle negative numbers like -5 vs - 5)
                match = rest.match(/^-?\d+(\.\d+)?/);
                if (match) {
                    this.tokens.push(this.createToken(TokenType.NUMBER, match[0]));
                    cursor += match[0].length;
                    continue;
                }

                // 5. Regular Operators (prefix, postfix, or tight infix/block)
                const opMatch = this.matchOperator(rest);
                if (opMatch) {
                    this.tokens.push(this.createToken(TokenType.OPERATOR, opMatch));
                    cursor += opMatch.length;
                    continue;
                }

                // 6. Identifiers
                // Exclude all operator symbols: ! # $ % & * + - . / : < = > ? @ ^ | ~ ; , \ ( ) [ ] { } " `
                // Also whitespace.
                match = rest.match(/^[^\s()\[\]{},:?"`!@#$%^&*|+\-/\\~;<=>]+/);
                if (match) {
                    this.tokens.push(this.createToken(TokenType.IDENTIFIER, match[0]));
                    cursor += match[0].length;
                    continue;
                }

                // 7. Unknown
                console.warn(`Unknown token at line ${this.currentLine}: ${rest.charAt(0)}`);
                cursor++;
            }

            this.tokens.push(this.createToken(TokenType.NEWLINE, '\n'));
        }

        // Final Dedents
        while (this.indentStack.length > 1) {
            this.indentStack.pop();
            this.tokens.push(this.createToken(TokenType.DEDENT, ''));
        }

        this.tokens.push(this.createToken(TokenType.EOF, ''));
        return this.tokens;
    }

    matchInfixOperator(str) {
        // str starts with space.
        // We look for space + op + space
        // Sort operators by length
        for (const op of uniqueOperators) {
            if (str.startsWith(' ' + op + ' ')) {
                return { op: op, length: op.length + 2 };
            }
        }
        return null;
    }

    matchOperator(str) {
        for (const op of uniqueOperators) {
            if (str.startsWith(op)) {
                return op;
            }
        }
        return null;
    }

    getIndentLevel(line) {
        let count = 0;
        for (const char of line) {
            if (char === '\t') count += 4; // Tab is 4 spaces? Standardize.
            else if (char === ' ') count += 1;
            else break;
        }
        return count;
    }

    createToken(type, value) {
        return { type, value, line: this.currentLine };
    }
}

module.exports = { Lexer, TokenType };
