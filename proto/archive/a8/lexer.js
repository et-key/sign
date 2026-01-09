const fs = require('fs');
const path = require('path');
const { OperatorList, OperatorPriority } = require('../../utility/operators.js');

const TokenType = {
    IDENTIFIER: 'IDENTIFIER',
    NUMBER: 'NUMBER',
    STRING: 'STRING',
    OPERATOR: 'OPERATOR',
    KEYWORD: 'KEYWORD',
    INDENT: 'INDENT',
    DEDENT: 'DEDENT',
    NEWLINE: 'NEWLINE',
    LPAREN: 'LPAREN',
    RPAREN: 'RPAREN',
    LBRACKET: 'LBRACKET',
    RBRACKET: 'RBRACKET',
    LBRACE: 'LBRACE',
    RBRACE: 'RBRACE',
    COMMA: 'COMMA',
    CHAR: 'CHAR',
    EOF: 'EOF'
};

const infixOps = OperatorList.map(obj => Object.keys(obj)[0]);
const prefixOps = Object.keys(OperatorPriority.prefix || {});
const postfixOps = Object.keys(OperatorPriority.postfix || {});
const surroundOps = Object.keys(OperatorPriority.surround || {});

const allOperators = [...infixOps, ...prefixOps, ...postfixOps, ...surroundOps];
const uniqueOperators = [...new Set(allOperators)].sort((a, b) => b.length - a.length);

class Lexer {
    constructor(input) {
        this.input = input.replace(/\r\n/g, '\n');
        this.tokens = [];
        this.indentStack = [0];
        this.lines = this.input.split('\n');
        this.currentLine = 0;
    }

    tokenize() {
        for (let i = 0; i < this.lines.length; i++) {
            this.currentLine = i + 1;
            const line = this.lines[i];

            if (line.trim().length === 0) continue;

            const indentLevel = this.getIndentLevel(line);
            const currentIndent = this.indentStack[this.indentStack.length - 1];

            if (indentLevel > currentIndent) {
                this.indentStack.push(indentLevel);
                this.tokens.push(this.createToken(TokenType.INDENT, '\t'.repeat(indentLevel)));
            } else if (indentLevel < currentIndent) {
                while (this.indentStack.length > 1 && this.indentStack[this.indentStack.length - 1] > indentLevel) {
                    this.indentStack.pop();
                    this.tokens.push(this.createToken(TokenType.DEDENT, ''));
                }
                if (this.indentStack[this.indentStack.length - 1] !== indentLevel) {
                    throw new Error(`Line ${this.currentLine}: Invalid indentation level.`);
                }
            }

            // Trim start but keep track of skipped whitespace?
            // "   a" -> indent level handled.
            // content = "a".
            // First token on line (after indent) usually doesn't have "preceding space" relevant to operators?
            // Actually, " a" vs "a".
            // But indentation captures leading space.
            // We can assume first token after indent has "hasPrecedingSpace = true" effectively?
            // Or "false" because it starts the line semantics?
            // Usually starts line.

            let content = line.trimStart();
            // The logic: if we trimmed, we consume whitespace.
            // But internal whitespace is what matters.

            let cursor = 0;
            // Track if we just skipped space.
            // At start of line (after trim), we basically are adjacent to "Indent".
            let skippedSpace = false;

            // However, we want to know if specific token matches.
            // If we match " + ", that is explicitly space-surrounded.

            while (cursor < content.length) {
                const rest = content.slice(cursor);

                // 1. Strings
                let match = rest.match(/^`([^`\r\n]*)`/);
                if (match) {
                    this.tokens.push(this.createToken(TokenType.STRING, match[1], skippedSpace));
                    cursor += match[0].length;
                    skippedSpace = false;
                    continue;
                }

                // 2. Char Literals
                match = rest.match(/^\\([\s\S])/);
                if (match) {
                    this.tokens.push(this.createToken(TokenType.CHAR, match[1], skippedSpace));
                    cursor += match[0].length;
                    skippedSpace = false;
                    continue;
                }

                // 3. Whitespace check (Explicit)
                if (rest.startsWith(' ') || rest.startsWith('\t')) {
                    skippedSpace = true;
                    cursor++;
                    while (cursor < content.length && (content[cursor] === ' ' || content[cursor] === '\t')) {
                        cursor++;
                    }
                    continue;
                }

                // 4. Brackets
                if (/^[()\[\]{},]/.test(rest.charAt(0))) {
                    const char = rest.charAt(0);
                    let type = TokenType.LPAREN;
                    if (char === ')') type = TokenType.RPAREN;
                    if (char === '[') type = TokenType.LBRACKET;
                    if (char === ']') type = TokenType.RBRACKET;
                    if (char === '{') type = TokenType.LBRACE;
                    if (char === '}') type = TokenType.RBRACE;
                    if (char === ',') type = TokenType.COMMA;
                    // Wait, comma is usually operator in Sign?
                    // But tokens.sn treats brackets/commas specially?
                    // Lexer.js defined COMMA type but operators also have comma in OperatorList.
                    // Check OperatorList ... yes, ',' is Precedence 4 Infix.
                    // So we should match it as Operator.
                    // But here we hijack it as COMMA type?
                    // Let's remove comma from here if it's in Operator list.
                    // Only brackets.
                    if (char !== ',') {
                        this.tokens.push(this.createToken(type, char, skippedSpace));
                        cursor++;
                        skippedSpace = false;
                        continue;
                    }
                }

                // 5. Numbers
                match = rest.match(/^-?\d+(\.\d+)?/);
                // Be careful with - as operator
                // If - is followed by digit, is it number or op?
                // `1 - 2` -> `1`, `-`, `2`?
                // `1 -2` -> `1`, `-2`? (Lexer greediness)
                // If we match `-2` here, `1-2` becomes `1`, `-2`. 
                // Then `1` adj `-2` -> `1 - 2`? Or `1 (-2)`?
                // Standard Sign might prefer `1` `-` `2`.
                // If I match negative number, I consume `-`.
                // Let's stick to positive numbers here? Or only if preceded by nothing/space?
                // If preceded by identifier `x-1`, `x`, `-1`? Adjacency.
                // If I separate `x`, `-`, `1`. `x - 1`.
                // Safe bet: Parse `-` as operator always?
                // Regex uses `^-?`.
                // If I have `x-1` (no space). `x` matches ID. `-` matches op. `1` matches num.
                // If I have ` -1` (space). `skippedSpace=true`.
                // `-` matches op. `1` matches num.
                // Unless I explicitly check.
                // Let's remove `-` from number regex to be safe and let unary operator handle negative.
                // Or user `tokens.sn` says:
                // #int : c ~s ? [once \- c s~] | [digit c] ...
                // So int CAN have minus.

                // Let's retry original regex logic:
                match = rest.match(/^-?\d+(\.\d+)?/);
                if (match) {
                    // Conflict with `x-1`?
                    // `-` matches at start of `rest` only if `rest` starts with `-`.
                    // If `rest` is `-1`.
                    // Should we treat as number `-1` or Op `-` Num `1`?
                    // If treated as Number `-1`, `x-1` -> `x` `1`? No `x`, `-1`.
                    // `x -1` -> `x`, `-1`.
                    // It is consistent.
                    // But `1-1`? `1`, `-1`. -> `1` adjacent `-1` -> `1 - 1`?
                    // Adjacency is `apply`. `1` applied to `-1`? No.
                    // We want `1` minus `1`.
                    // So `-` MUST be operator in `1-1`.
                    // If I parse `-1` as number, I miss the operator.
                    // So: Only parse negative number if it cannot be subtraction?
                    // e.g. at start of line, or after operator.
                    // This requires parser state. Lexer is stateless (mostly).
                    // Simple fix: Don't parse negative numbers in Lexer. Let `unit` or prefix `-` handle it.
                    // But tokens.sn defines int with minus.
                    // Let's check `isOperator` check priority.
                    // If I check operators *before* numbers? 
                    // `-` matches operator.
                    // So check operators first.
                }

                // 5. Numbers (Moved before Operators to handle negative numbers)
                match = rest.match(/^-?\d+(\.\d+)?/);
                if (match) {
                    this.tokens.push(this.createToken(TokenType.NUMBER, match[0], skippedSpace));
                    cursor += match[0].length;
                    skippedSpace = false;
                    continue;
                }

                // 6. Operators
                const opMatch = this.matchOperator(rest);
                if (opMatch) {
                    this.tokens.push(this.createToken(TokenType.OPERATOR, opMatch, skippedSpace));
                    cursor += opMatch.length;
                    skippedSpace = false;
                    continue;
                }

                // Identifiers
                match = rest.match(/^[^\s()\[\]{},:?"`!@#$%^&*|+\-/\\~;<=>]+/);
                if (match) {
                    this.tokens.push(this.createToken(TokenType.IDENTIFIER, match[0], skippedSpace));
                    cursor += match[0].length;
                    skippedSpace = false;
                    continue;
                }

                console.warn(`Unknown token at line ${this.currentLine}: ${rest.charAt(0)}`);
                cursor++;
            }

            this.tokens.push(this.createToken(TokenType.NEWLINE, '\n'));
        }

        while (this.indentStack.length > 1) {
            this.indentStack.pop();
            this.tokens.push(this.createToken(TokenType.DEDENT, ''));
        }

        this.tokens.push(this.createToken(TokenType.EOF, ''));
        return this.tokens;
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
            if (char === '\t') count += 4;
            else if (char === ' ') count += 1;
            else break;
        }
        return count;
    }

    createToken(type, value, hasPrecedingSpace = false) {
        return { type, value, line: this.currentLine, hasPrecedingSpace };
    }
}

module.exports = { Lexer, TokenType };
