{
  // State management (Depth) is completely delegated to Lexer preprocessing.
  // Global state variables are not required.
}

Start = Program

// Definition of Whitespace and Line Endings
// Space is the Coproduct Operator itself in Sign!
// One or more spaces = Coproduct operator in Sign.
__ = " "+ { return null; } // coproduct operator
_  = " "* { return null; } // optional (used only at line edges)
SOL = &{ return location().start.column === 1; }
EOL = "\r\n" / "\r" / "\n"
EOF = !.

comment = SOL "`" [^\r\n]* (EOL / EOF) { return null; }

// --- Program and Line ---
Program = (SOL @Line EOL*)* / comment* EOF

Line
  = _ expr:Expression _ { return expr; }

// --- Flat List Construction via Coproduct (Space) ---
// Returns a sequence of space-separated Terms as a flat array.
// This array becomes input to Shunting Yard (Operator Table).
Expression
  = head:Term tail:(__ @Term)* {
      if (tail.length === 0) {
          return head;
      }
      return [head, ...tail].flat();
  }

// --- Tight Binding (Syntax = Type) ---
// No space = Same Term = Tight binding.
// Prefixes append "_", Postfixes prepend "_" to assist Shunting Yard.
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

// --- Spatial Arrangement (Nested Structure) ---
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

// --- Values (Atom) ---
Atom
  = string / charactor / address / register / unicode / number / identifier / unit / hole

string = $("`" [^`\r\n]* "`")
charactor = $("\\".)
number = $("-"? [0-9]+ "."? [0-9]*)
address = $("0x" Hex+)
register = $("0r" Hex+) / $("0b" ("0" / "1")+)
unicode = $("0u" Hex+)
identifier = id:( $([a-zA-Z][a-zA-Z0-9_]*) / $("_" [a-zA-Z0-9_]+) ) {return `<${id}>`}
Hex = [0-9a-fA-F]
unit = "__" / "\x00"
hole = "_"

// --- Operators ---
prefix
  = "###" / "##" / "#" / ("-" &(Block / identifier)) / "~" / "!!" / "!" / "$" / "@"

postfix
  = "!" / "~" / "@"

operator
  = $[!"#$%&'-=^~\|@;+:*,<>/?]+
