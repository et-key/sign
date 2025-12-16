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
            const inner = tokens.slice(1, tokens.length - 1);
            return this.processBlock(inner);
        }

        const opIdx = this.findSplitOperatorIndex(tokens);

        if (opIdx === -1) {
            if (tokens.length === 1) {
                return this.getTokenValue(tokens[0]);
            }

            // Adjacency
            const parts = this.splitByAdjacency(tokens);

            if (parts.length === 1 && parts[0].length === tokens.length) {
                // Force finding tight operator if present
                const fallbackIdx = this.findSplitOperatorIndex(tokens, true);
                if (fallbackIdx !== -1) {
                    return this.convertOpAt(tokens, fallbackIdx);
                }
            }

            return parts.map(p => this.convertExpr(p));
        }

        return this.convertOpAt(tokens, opIdx);
    }

    convertOpAt(tokens, opIdx) {
        const opToken = tokens[opIdx];
        const leftTokens = tokens.slice(0, opIdx);
        const rightTokens = tokens.slice(opIdx + 1);
        const opVal = opToken.value;

        if (opIdx === 0) {
            // Prefix
            if (isPrefixOperator(opVal)) {
                const opStr = `[${opVal}_]`;
                const right = this.convertExpr(rightTokens);
                if (Array.isArray(right) && right.length === 0) return opStr;
                return [opStr, right];
            } else {
                const opStr = `[${opVal}]`;
                if (rightTokens.length === 0) return opStr;
                const rightRes = this.convertExpr(rightTokens);
                return [opStr, rightRes];
            }
        } else if (opIdx === tokens.length - 1) {
            // Postfix
            if (isPostfixOperator(opVal)) {
                const opStr = `[_${opVal}]`;
                const left = this.convertExpr(leftTokens);
                return [opStr, left];
            } else {
                const opStr = `[${opVal}]`;
                if (leftTokens.length === 0) return opStr;
                const leftRes = this.convertExpr(leftTokens);
                return [opStr, leftRes];
            }
        } else {
            // Infix (unless we detected it as Postfix in findSplit, but convertOpAt just takes index)
            // If findSplit selected a Postfix op in middle, it would have high precedence, so unlikely to be selected.
            // But if it WAS selected, we must treat it as Postfix?
            // Wait, Infix Logic: `Left Op Right`. 
            // If it is Postfix, it should be `Left Op`.
            // But here we have `Right` tokens.
            // If `findSplit` selected it, it expects Infix.
            // UNLESS it's the only operator?
            // If `x!` and we selected `!`. `Right` is empty. `opIdx === length-1`. Handled above.
            // If `x!y` and we selected `!`.
            // Then `Left`=`x`. `Right`=`y`.
            // If we treat as Infix `[!]`. `x [!] y`.
            // If `!` is strictly Postfix?
            // It logic for Infix handles it.
            // BUT our "Tight Postfix Detection" logic in findSplit basically prevents selecting `!` if there's a looser Infix.
            // So if `!` is selected here, it implies it IS the split point.
            // If so, it must be Infix.

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

    findSplitOperatorIndex(tokens, allowTight = false) {
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

                    if (!allowTight && tokens[i + 1] && !tokens[i + 1].hasPrecedingSpace) {
                        prec = Infinity;
                    }

                } else if (i === tokens.length - 1) {
                    prec = OperatorPriority.postfix[val];

                    if (!allowTight && !t.hasPrecedingSpace) {
                        prec = Infinity;
                    }

                } else {
                    const isPrefixBinding = t.hasPrecedingSpace && (tokens[i + 1] && !tokens[i + 1].hasPrecedingSpace);
                    if (!allowTight && isPrefixBinding && isPrefixOperator(val)) {
                        prec = Infinity;
                    } else {
                        // Tight Postfix Detection: No Preceding Space, Has Following Space
                        const isPostfixBinding = !t.hasPrecedingSpace && tokens[i + 1].hasPrecedingSpace;
                        if (!allowTight && isPostfixBinding && isPostfixOperator(val)) {
                            // Use Postfix Precedence (High)
                            prec = OperatorPriority.postfix[val];
                            // Logic: If operator is Tight Left and Loose Right, it binds to Left.
                            // Its precedence becomes Postfix (High).
                            // Thus, it will NOT be selected as the split point if there is a lower Infix (e.g. =) around.
                        } else {
                            const info = this.opMap.get(val);
                            if (info) {
                                prec = info.precedence;
                                assoc = info.associativity;
                            }
                        }
                    }
                }

                if (!prec) prec = 0;
                if (prec === Infinity) continue;

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
        let i = 0;
        while (i < tokens.length) {
            const { chunk, nextIdx } = this.readNextExpression(tokens, i);
            chunks.push(chunk);
            i = nextIdx;
        }
        return chunks;
    }

    readNextExpression(tokens, startIdx) {
        if (startIdx >= tokens.length) return { chunk: [], nextIdx: startIdx };

        const t = tokens[startIdx];
        let currentExpr = null;
        let nextIdx = startIdx;

        if (t.type === TokenType.LPAREN || t.type === TokenType.LBRACKET || t.type === TokenType.LBRACE) {
            let depth = 0;
            let found = false;
            for (let i = startIdx; i < tokens.length; i++) {
                const tk = tokens[i];
                if (tk.type === TokenType.LPAREN || tk.type === TokenType.LBRACKET || tk.type === TokenType.LBRACE) depth++;
                else if (tk.type === TokenType.RPAREN || tk.type === TokenType.RBRACKET || tk.type === TokenType.RBRACE) depth--;

                if (depth === 0) {
                    currentExpr = tokens.slice(startIdx, i + 1);
                    nextIdx = i + 1;
                    found = true;
                    break;
                }
            }
            if (!found) {
                currentExpr = tokens.slice(startIdx);
                nextIdx = tokens.length;
            }
        } else if (t.type === TokenType.OPERATOR && isPrefixOperator(t.value)) {
            if (tokens[startIdx + 1] && !tokens[startIdx + 1].hasPrecedingSpace) {
                const arg = this.readNextExpression(tokens, startIdx + 1);
                currentExpr = [t, ...arg.chunk];
                nextIdx = arg.nextIdx;
            } else {
                currentExpr = [t];
                nextIdx = startIdx + 1;
            }
        } else {
            currentExpr = [t];
            nextIdx = startIdx + 1;
        }

        while (nextIdx < tokens.length) {
            const nextT = tokens[nextIdx];
            if (nextT.type === TokenType.OPERATOR && isPostfixOperator(nextT.value)) {
                if (!nextT.hasPrecedingSpace) {
                    const isTightPrefixRight = tokens[nextIdx + 1] && !tokens[nextIdx + 1].hasPrecedingSpace && isPrefixOperator(nextT.value);
                    if (!isTightPrefixRight) {
                        currentExpr = currentExpr.concat([nextT]);
                        nextIdx++;
                        continue;
                    }
                }
            }
            break;
        }

        return { chunk: currentExpr, nextIdx };
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
