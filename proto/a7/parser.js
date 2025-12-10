const { TokenType } = require('./lexer');
const { OperatorList, OperatorMap, isPrefixOperator, isPostfixOperator } = require('../../utility/operators.js');

// ----------------------------------------------------------------------------
// AST Node Types
// ----------------------------------------------------------------------------
const NodeType = {
    PROGRAM: 'PROGRAM',
    LITERAL: 'LITERAL',
    IDENTIFIER: 'IDENTIFIER',
    BINARY_EXPRESSION: 'BINARY_EXPRESSION',
    PREFIX_EXPRESSION: 'PREFIX_EXPRESSION',
    POSTFIX_EXPRESSION: 'POSTFIX_EXPRESSION',
    BLOCK: 'BLOCK',
    LIST: 'LIST', // For comma separated
    APPLY: 'APPLY', // For adjacency
    LAMBDA: 'LAMBDA',
    DEFINE: 'DEFINE'
};

// ----------------------------------------------------------------------------
// Parser
// ----------------------------------------------------------------------------
class Parser {
    constructor(tokens) {
        this.tokens = tokens;
        this.position = 0;
        this.operatorPrecedence = OperatorMap; // Use imported Map directly

        // Implicit Adjacency (Space) Precedence
        // Table: apply=4, compose=5, list=6.
        // We pick 4 to match Comma (4).
        this.ADJACENCY_PRECEDENCE = 4;

        // Debug
        // console.log("Parser initialized. + info:", this.operatorPrecedence.get('+'));
    }

    peek() {
        return this.tokens[this.position];
    }

    consume() {
        if (this.isAtEnd()) return this.tokens[this.tokens.length - 1];
        return this.tokens[this.position++];
    }

    isAtEnd() {
        return this.position >= this.tokens.length || this.tokens[this.position].type === TokenType.EOF;
    }

    parse() {
        const statements = [];
        while (!this.isAtEnd()) {
            // Skip pure newlines at top level
            if (this.peek().type === TokenType.NEWLINE) {
                this.consume();
                continue;
            }
            if (this.peek().type === TokenType.EOF) break;

            statements.push(this.parseExpression(0));

            // Should expect newline or EOF after expression?
            if (!this.isAtEnd() && this.peek().type === TokenType.NEWLINE) {
                this.consume();
            }
        }
        return { type: NodeType.PROGRAM, body: statements };
    }

    // Pratt Parser Core
    parseExpression(precedence) {
        // Skip leading newlines (allow expressions to start on next line after operator)
        while (!this.isAtEnd() && this.peek().type === TokenType.NEWLINE) {
            this.consume();
        }

        if (this.isAtEnd()) return null;

        let token = this.consume();
        // console.log(`Parsing prefix for: ${token.type}(${token.value})`);

        let left = this.getPrefixHandler(token);

        if (!left) {
            throw new Error(`Unexpected token at line ${token.line}: ${token.value} (${token.type})`);
        }

        while (!this.isAtEnd()) {
            const nextToken = this.peek();

            let isAdjacency = false;
            let currentPrecedence = 0;
            let nextOpPrecedence = 0;

            if (this.isAdjacencyCandidate(nextToken)) {
                // Adjacency
                currentPrecedence = this.ADJACENCY_PRECEDENCE;
                isAdjacency = true;
                nextOpPrecedence = this.ADJACENCY_PRECEDENCE;
            } else if (nextToken.type === TokenType.OPERATOR) {
                // Binary Operator?
                const opInfo = this.operatorPrecedence.get(nextToken.value);
                // console.log(`Peek OP: ${nextToken.value}, Info:`, opInfo);

                if (opInfo) {
                    nextOpPrecedence = opInfo.precedence;
                } else {
                    // If unknown, treats as very low or 0.
                    // IMPORTANT: If we encounter '?', it is an operator in the map (Precedence 7).
                    nextOpPrecedence = 0;
                }

                if (isPostfixOperator(nextToken.value)) {
                    // Postfix
                    // Treat as higher precedence usually?
                    // e.g. ! (factorial) is 17.
                    // OperatorPriority.postfix has values? 
                    // OperatorMap contains ALL ops including postfix if listed in OperatorList.
                    // Check logic.
                }

            } else {
                break;
            }

            // Loop termination:
            // Left Binding Power < Next Binding Power ? Continue : Break

            if (precedence >= nextOpPrecedence) {
                break;
            }

            if (isAdjacency) {
                // Parse Adjacency (Left Assoc)
                const right = this.parseExpression(this.ADJACENCY_PRECEDENCE);
                left = {
                    type: NodeType.APPLY,
                    left: left,
                    right: right
                };
            } else {
                // Explicit Operator
                const opToken = this.consume();

                if (isPostfixOperator(opToken.value)) {
                    left = {
                        type: NodeType.POSTFIX_EXPRESSION,
                        operator: opToken.value,
                        argument: left
                    };
                } else {
                    // Infix
                    const opInfo = this.operatorPrecedence.get(opToken.value);
                    const associativity = opInfo ? opInfo.associativity : 'left';

                    // Check if next token is a closer (Section / Trailing operator)
                    const nextType = this.peek().type;
                    if (nextType === TokenType.RPAREN || nextType === TokenType.RBRACKET || nextType === TokenType.RBRACE || nextType === TokenType.EOF || nextType === TokenType.COMMA) {
                        // Trailing operator found (e.g. [+,] or (+))
                        // Treat right as null or implicit
                        left = {
                            type: NodeType.BINARY_EXPRESSION,
                            operator: opToken.value,
                            left: left,
                            right: null // Section or Trailing
                        };
                    } else {
                        // Right associative: reduce precedence for recursive call to allow binding
                        const rightPrec = associativity === 'right' ? nextOpPrecedence - 1 : nextOpPrecedence;

                        const rightExpr = this.parseExpression(rightPrec);

                        left = {
                            type: NodeType.BINARY_EXPRESSION,
                            operator: opToken.value,
                            left: left,
                            right: rightExpr
                        };
                    }
                }
            }
        }
        return left;
    }

    // Handlers

    getPrefixHandler(token) {
        switch (token.type) {
            case TokenType.NUMBER:
                return { type: NodeType.LITERAL, value: parseFloat(token.value), raw: token.value };
            case TokenType.STRING:
                return { type: NodeType.LITERAL, value: token.value, kind: 'string' };
            case TokenType.IDENTIFIER:
                return { type: NodeType.IDENTIFIER, name: token.value };
            case TokenType.LPAREN: // (
                const expr = this.parseExpression(0);
                if (this.peek().type === TokenType.RPAREN) {
                    this.consume();
                } else {
                    // console.error(`Expected ')' but got ${this.peek().type}`);
                    throw new Error(`Expected ')' at line ${token.line}`);
                }
                return expr;
            case TokenType.LBRACKET: // [
                const blockExpr = this.parseBlock();
                if (this.peek().type === TokenType.RBRACKET) {
                    this.consume();
                } else {
                    throw new Error(`Expected ']' at line ${token.line}`);
                }
                return blockExpr;
            case TokenType.OPERATOR:
                // Prefix Operator
                if (isPrefixOperator(token.value)) {
                    // Prefix precedence
                    const right = this.parseExpression(30);
                    return {
                        type: NodeType.PREFIX_EXPRESSION,
                        operator: token.value,
                        right: right
                    };
                }
                // Allow using operator as a value (for sections/high-order functions)
                // e.g. [+] or map + list
                return { type: NodeType.IDENTIFIER, name: token.value, isOperator: true };
            case TokenType.INDENT:
                const statements = [];
                while (!this.isAtEnd() && this.peek().type !== TokenType.DEDENT) {
                    if (this.peek().type === TokenType.NEWLINE) {
                        this.consume();
                        continue;
                    }
                    statements.push(this.parseExpression(0));
                }
                if (this.peek().type === TokenType.DEDENT) {
                    this.consume();
                }
                return { type: NodeType.BLOCK, body: statements };
            default:
                return null;
        }
    }

    parseBlock() {
        // [ content ]
        // If immediately ']', it's an empty list/block.
        if (this.peek().type === TokenType.RBRACKET) {
            return { type: NodeType.LIST, items: [] }; // Or BLOCK with empty body? Sign says [] is empty list.
        }
        // Just parse as expression. 
        // Note: [x ? x+1] -> x ? x+1 is an expression.
        return this.parseExpression(0);
    }

    isAdjacencyCandidate(token) {
        if (!token) return false;

        return [
            TokenType.IDENTIFIER,
            TokenType.NUMBER,
            TokenType.STRING,
            TokenType.LPAREN,
            TokenType.LBRACKET,
            TokenType.LBRACE
        ].includes(token.type) || (token.type === TokenType.OPERATOR && isPrefixOperator(token.value));
    }

}

module.exports = { Parser, NodeType };
