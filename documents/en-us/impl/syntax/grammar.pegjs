{
  // State management (Depth) is completely delegated to Lexer preprocessing.
}

Start = Program

// Whitespace & Newline Definitions
// Spaces are NOT cosmetic delimiters; space IS the coproduct operator.
__ = " "+ { return null; } // coproduct operator
_  = " "* { return null; } // optional (used only at line edges)
SOL = &{ return location().start.column === 1; }
EOL = "\r\n" / "\r" / "\n"
EOF = !.

comment = SOL "`" [^\r\n]* (EOL / EOF) { return null; }

// --- Program & Lines ---
Program = (SOL @Line EOL*)* / comment* EOF

Line
  = _ expr:Expression _ { return expr; }

// --- Expression Layer ---
Expression
  = head:Term tail:(__ @Term)* {
      if (tail.length === 0) {
          return head;
      }
      return [head, ...tail].flat();
  }

Term
  = pre:Prefixes core:Core post:Postfixes {
      if (pre.length === 0 && post.length === 0) return core;
      return [...pre, core, ...post];
  }
  / operator

Prefixes
  = pre:prefix* { return pre.map(p => p + "_"); }

Postfixes
  = post:postfix* { return post.map(p => "_" + p); }

Core
  = Block
  / Atom

Block
  = "[" _ exprs:Expressions _ "]" { return exprs; }
  / "{" _ exprs:Expressions _ "}" { return exprs; }
  / "(" _ exprs:Expressions _ ")" { return exprs; }
  / "|" exprs:Expressions "|" &(__ / EOL / EOF / "]" / "}" / ")" / "\x03") { return [`"ABS_"`, ...exprs]; }
  / "\x02" _ exprs:Expressions _ "\x03" { return [`"INDENT_"`, ...exprs, `"_DEDENT"`]; }

Expressions
  = head:Expression tail:(EOL _ @Expression)* {
      return [head, ...tail].filter(e => e !== null);
  }

Atom
  = string / charactor / address / register / unicode / number / identifier / unit / hole

string = $("`" [^`\r\n]* "`")
charactor = $("\\".)
number = $("-"? [0-9]+ "."? [0-9]*)
address = $("0x" Hex+)
register = $("0r" Hex+) / $("0b" ("0" / "1")+)
unicode = $("0u" Hex+)
Hex = [0-9a-fA-F]
identifier = $([a-zA-Z_][a-zA-Z0-9_]*)
unit = "__"
hole = "_"
prefix = "@" / "#" / "!" / "$" / "!!" / "~"
postfix = "~" / "@" / "!"
operator = ":" / "?" / "#" / ";" / "|" / "&" / "===" / "==" / "!==" / "," / "~" / "<=" / "<" / ">=" / ">" / "=" / "!=" / "+" / "-" / "*" / "/" / "%" / "^" / "'" / "@" / "<<" / ">>" / "||" / ";;" / "&&"
