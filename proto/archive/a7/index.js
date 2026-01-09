const { Lexer, TokenType } = require('./lexer');
const { Parser, NodeType } = require('./parser');

module.exports = {
    Lexer,
    Parser,
    TokenType,
    NodeType,
    parse: (input) => {
        const lexer = new Lexer(input);
        const tokens = lexer.tokenize();
        const parser = new Parser(tokens);
        return parser.parse();
    }
};
