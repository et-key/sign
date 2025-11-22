const P = require("parsimmon");

// 基本的なトークン定義
const whitespace = P.regexp(/\s*/m);
const identifier = P.regexp(/[a-zA-Z_][a-zA-Z0-9_]*/).desc("identifier");
const numberLiteral = P.regexp(/[0-9]+/).map(Number).desc("number");
const stringLiteral = P.regexp(/"([^"\\]|\\.)*"/).desc("string");