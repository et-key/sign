const { TokenType } = require('./lexer');
const { OperatorMap, OperatorPriority, isPrefixOperator, isPostfixOperator } = require('../../utility/operators.js');

class Converter {
    constructor(tokens) {
        this.tokens = tokens;
        this.opMap = OperatorMap;
    }

    convert() {
        return this.processBlock(this.tokens);
    }

    processBlock(tokens) {
        const statements = [];
        let currentStmt = [];
        let depth = 0;

        for (let i = 0; i < tokens.length; i++) {
            const t = tokens[i];
            if (t.type === TokenType.LPAREN || t.type === TokenType.LBRACKET || t.type === TokenType.LBRACE) depth++;
            if (t.type === TokenType.RPAREN || t.type === TokenType.RBRACKET || t.type === TokenType.RBRACE) depth--;

            if (depth === 0 && t.type === TokenType.NEWLINE) {
                if (currentStmt.length > 0) {
                    try {
                        statements.push(this.convertExpr(currentStmt));
                    } catch (e) {
                        console.error(`Error processing statement ending at line ${t.line}:`, currentStmt.map(tk => tk.value).join(' '));
                        throw e;
                    }
                    currentStmt = [];
                }
            } else if (depth === 0 && t.type === TokenType.INDENT) {
                currentStmt.push(t);
            } else if (depth === 0 && t.type === TokenType.DEDENT) {
                currentStmt.push(t);
            } else {
                currentStmt.push(t);
            }
        }
        if (currentStmt.length > 0) {
            try {
                statements.push(this.convertExpr(currentStmt));
            } catch (e) {
                console.error(`Error processing final statement:`, currentStmt.map(tk => tk.value).join(' '));
                throw e;
            }
        }
        return statements;
    }

    convertExpr(tokens) {
        if (tokens.length === 0) return [];

        if (this.isGrouped(tokens)) {
            return this.convertExpr(tokens.slice(1, tokens.length - 1));
        }

        if (tokens[0].type === TokenType.INDENT) {
            // Handle INDENT block
            const inner = tokens.slice(1, tokens.length - 1);
            return this.processBlock(inner);
        }

        const opIdx = this.findSplitOperatorIndex(tokens);

        if (opIdx === -1) {
            if (tokens.length === 1) {
                return this.getTokenValue(tokens[0]);
            }
            const parts = this.splitByAdjacency(tokens);
            return parts.map(p => this.convertExpr(p));
        }

        const opToken = tokens[opIdx];
        const leftTokens = tokens.slice(0, opIdx);
        const rightTokens = tokens.slice(opIdx + 1);

        const opVal = opToken.value;

        if (opIdx === 0) {
            // Prefix
            const opStr = `[${opVal}_]`;
            return [opStr, this.convertExpr(rightTokens)];
        } else if (opIdx === tokens.length - 1) {
            // Postfix
            const opStr = `[_${opVal}]`;
            return [opStr, this.convertExpr(leftTokens)];
        } else {
            // Infix
            const opStr = `[${opVal}]`;

            const leftRes = this.convertExpr(leftTokens);
            const rightRes = this.convertExpr(rightTokens);

            if (opStr === '[?]') {
                const args = (Array.isArray(leftRes) && !this.isBracketedOp(leftRes[0])) ? leftRes : [leftRes];
                return [opStr, args, rightRes];
            }

            return [opStr, leftRes, rightRes];
        }
    }

    findSplitOperatorIndex(tokens) {
        let lowestPrec = Infinity;
        let lowestIdx = -1;

        let depth = 0;

        for (let i = 0; i < tokens.length; i++) {
            const t = tokens[i];

            if (t.type === TokenType.LPAREN || t.type === TokenType.LBRACKET || t.type === TokenType.LBRACE) {
                depth++; continue;
            }
            if (t.type === TokenType.RPAREN || t.type === TokenType.RBRACKET || t.type === TokenType.RBRACE) {
                depth--; continue;
            }

            if (depth === 0 && t.type === TokenType.OPERATOR) {
                const val = t.value;
                let prec = 0;
                let assoc = 'left';

                if (i === 0) {
                    prec = OperatorPriority.prefix[val];
                    if (!prec && isPrefixOperator(val)) prec = 12;
                } else if (i === tokens.length - 1) {
                    prec = OperatorPriority.postfix[val];
                } else {
                    const info = this.opMap.get(val);
                    if (info) {
                        prec = info.precedence;
                        assoc = info.associativity;
                    }
                }

                if (!prec) prec = 0;

                if (prec < lowestPrec) {
                    lowestPrec = prec;
                    lowestIdx = i;
                } else if (prec === lowestPrec) {
                    if (assoc === 'left') {
                        lowestIdx = i;
                    }
                }
            }
        }
        return lowestIdx;
    }

    splitByAdjacency(tokens) {
        const chunks = [];
        let currentChunk = [];
        let depth = 0;

        for (let i = 0; i < tokens.length; i++) {
            const t = tokens[i];

            if (t.type === TokenType.LPAREN || t.type === TokenType.LBRACKET || t.type === TokenType.LBRACE) {
                if (depth === 0 && currentChunk.length > 0) {
                    chunks.push(currentChunk);
                    currentChunk = [];
                }
                depth++;
                currentChunk.push(t);
            } else if (t.type === TokenType.RPAREN || t.type === TokenType.RBRACKET || t.type === TokenType.RBRACE) {
                depth--;
                currentChunk.push(t);
                if (depth === 0) {
                    chunks.push(currentChunk);
                    currentChunk = [];
                }
            } else {
                if (depth > 0) {
                    currentChunk.push(t);
                } else {
                    if (currentChunk.length > 0) {
                        chunks.push(currentChunk);
                        currentChunk = [];
                    }
                    chunks.push([t]);
                }
            }
        }
        if (currentChunk.length > 0) chunks.push(currentChunk);
        return chunks;
    }

    isGrouped(tokens) {
        if (tokens.length < 2) return false;
        const first = tokens[0];
        const last = tokens[tokens.length - 1];

        if (first.type === TokenType.LPAREN && last.type === TokenType.RPAREN) return this.checkDepth(tokens);
        if (first.type === TokenType.LBRACKET && last.type === TokenType.RBRACKET) return this.checkDepth(tokens);
        return false;
    }

    checkDepth(tokens) {
        let depth = 0;
        for (let i = 0; i < tokens.length - 1; i++) {
            const t = tokens[i];
            if (t.type === TokenType.LPAREN || t.type === TokenType.LBRACKET) depth++;
            if (t.type === TokenType.RPAREN || t.type === TokenType.RBRACKET) depth--;
            if (depth === 0 && i > 0) return false;
        }
        return true;
    }

    getTokenValue(token) {
        if (token.type === TokenType.NUMBER) return parseFloat(token.value);
        if (token.type === TokenType.OPERATOR) return `[${token.value}]`;
        if (token.type === TokenType.LBRACKET) return [];
        return token.value;
    }

    isBracketedOp(str) {
        return typeof str === 'string' && str.startsWith('[') && (/[+\-*/%^&|!<>=?:#~,]/.test(str) || str.includes('_'));
    }
}

module.exports = { Converter };
