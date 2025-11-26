const P = require("parsimmon");

// 基本的なトークン定義
const string = P.regexp(/`[^`\r\n]*`/).desc("string");
const comment = P.regexp(/^\t*`[^\r\n]*`?$/m).desc("comment");
const char = P.regexp(/\\[\s\S]/).desc("char");
const identifier = P.regexp(/[a-zA-Z_][a-zA-Z0-9_]*/).desc("identifier");
const number = P.regexp(/-?[0-9]+\.?[0-9]*/).desc("number");
