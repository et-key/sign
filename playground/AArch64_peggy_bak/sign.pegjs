// Sign Language Parser (v0 Strict Base)

Start = Program

// --- Whitespace & EOL ---
__ = " "+ { return null; }
_ = " "* { return null; }
SOL = &{ return location().start.column === 1; }
EOL = "\r\n" / "\r" / "\n"
EOF = !.

// --- Root ---
Program = lines:(SOL _ Expression _ (EOL / EOF))* {
  return lines.map(l => l[2]).filter(e => e !== "");
}

Expression
  = Comment
  / Export

Comment = "`" [^\r\n]* { return ""; }

Export = exportMod:("###" / "##" / "#")? _ def:Define {
  if (exportMod && def) {
    def.exportModifier = exportMod;
  }
  return def;
}

// --- Priority 1: Define (:) ---
Define
  = id:identifier _ ":" _ body:Define {
      return { type: "Define", identifier: id, body: body };
  }
  / Lambda

// --- Priority 2: Lambda (?) ---
Lambda
  = args:Arguments _ "?" _ body:(Lambda / Match_Case+) {
      return { type: "Lambda", arguments: args, body: body };
  }
  / Output
  / Construct

// --- Priority 3: Output (#) ---
Output
  = target:(address / identifier) calls:(__ "#" __ Lambda)+ {
      return { type: "Output", target: target, calls: calls.map(c => c[3]) };
  }
  / Construct

// --- Priority 4: Constructs ---
Construct
  = Dictionary
  / Product
  / Sequence
  / Coproduct

// --- v0 Explicit Structures ---
Dictionary
  = "{" _ EOL* _ pairs:((identifier "~"? / string) _ ":" _ (Lambda / Atom / Construct) _ EOL* _)+ "}" {
      return { 
          type: "Dictionary", 
          // pairs: [[key, _1, ":", _2, value, _3], ...]
          pairs: pairs.map(p => ({ key: p[0], value: p[4] }))
      };
  }

Match_Case
  = "{" _ EOL* _ cases:(Calculate _ ":" _ (Calculate / Dictionary / Lambda) _ EOL* _)+ "}" {
      return {
          type: "MatchCase",
          // cases: [[condition, _1, ":", _2, body, _3], ...]
          cases: cases.map(c => ({ condition: c[0], body: c[4] }))
      };
  }

Arguments = Inline / Defaultive

Defaultive
  = "[" _ EOL* _ args:DefaultiveArg* "]" { return { type: "ArgumentsDefaultive", args: args, bracket: "[]" }; }
  / "{" _ EOL* _ args:DefaultiveArg* "}" { return { type: "ArgumentsDefaultive", args: args, bracket: "{}" }; }
  / "(" _ EOL* _ args:DefaultiveArg* ")" { return { type: "ArgumentsDefaultive", args: args, bracket: "()" }; }

DefaultiveArg
  = arg:("~"? identifier (_ ":" _ Lambda)?) _ EOL* _ {
      return arg;
  }

Inline
  = id:identifier rest:(__ "~"? identifier)* {
      return { type: "ArgumentsInline", args: [id, ...rest.map(r => r[2])] };
  }

// --- Priority 5: PointFree ---
PointFree
  = DirectMap
  / Normal
  / DirectFold

DirectMap
  = pre:prefix "_" "," { return { type: "PointFreeMap", position: "prefix", operator: pre }; }
  / "_" post:postfix "," { return { type: "PointFreeMap", position: "postfix", operator: post }; }
  / arg:(number / address / register) _ inf:infix "," { return { type: "PointFreeMap", position: "infix_right", argument: arg, operator: inf }; }
  / inf:infix _ arg:(number / address / register) "," { return { type: "PointFreeMap", position: "infix_left", argument: arg, operator: inf }; }

Normal
  = arg:(number / address / register) _ inf:infix { return { type: "PointFreeNormal", position: "infix_right", argument: arg, operator: inf }; }
  / inf:infix _ arg:(number / address / register) { return { type: "PointFreeNormal", position: "infix_left", argument: arg, operator: inf }; }

DirectFold = inf:infix { return { type: "PointFreeFold", operator: inf }; }

// --- Priority 6: Lists (Product / Coproduct) ---
Product = head:Coproduct tail:(_ "," _ Coproduct)* {
    if (tail.length === 0) return head;
    return { type: "Product", elements: [head, ...tail.map(t => t[3])] };
}

Coproduct = head:(Sequence / Calculate) tail:(__ (Sequence / Calculate))* {
    if (tail.length === 0) return head;
    return { type: "Coproduct", elements: [head, ...tail.map(t => t[1])] };
}

Sequence
  = "[" _ EOL* _ inner:SequenceInner _ EOL* _ "]" { return { type: "Sequence", inner: inner, bracket: "[]" }; }
  / "{" _ EOL* _ inner:SequenceInner _ EOL* _ "}" { return { type: "Sequence", inner: inner, bracket: "{}" }; }
  / "(" _ EOL* _ inner:SequenceInner _ EOL* _ ")" { return { type: "Sequence", inner: inner, bracket: "()" }; }

SequenceInner
  = left:(CalculateBlock / Atom) _ op:("~+" / "~-" / "~*" / "~/" / "~^") _ right:(CalculateBlock / Atom) __ "~" __ step:(CalculateBlock / Atom) {
      return { type: "SequenceGenerator", left: left, operator: op, right: right, step: step };
  }
  / left:(CalculateBlock / Atom) _ op:("~+" / "~-" / "~*" / "~/" / "~^") _ right:(CalculateBlock / Atom) {
      return { type: "SequenceGenerator", left: left, operator: op, right: right };
  }
  / left:(CalculateBlock / Atom) __ "~" __ right:(CalculateBlock / Atom) {
      return { type: "SequenceRange", left: left, right: right };
  }
  / left:(CalculateBlock / Atom) __ "~" { return { type: "SequenceRange", left: left, right: null }; }
  / "~" __ right:(CalculateBlock / Atom) { return { type: "SequenceRange", left: null, right: right }; }

// --- Priority 7: Calculations ---
Calculate = Logical_Xor

Logical_Xor = head:Logical_Or tail:(_ ";" _ Logical_Or)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}
Logical_Or = head:Logical_And tail:(__ "|" __ Logical_And)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}
Logical_And = head:Compare tail:(_ "&" _ Compare)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}

Compare = head:Arithmetic tail:(_ ("==" / "!=" / "<=" / ">=" / "<" / ">" / "=") _ Arithmetic)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}

Arithmetic = Additive

Additive = head:Multiply tail:(_ ("+" / (__ "-" __ {return "-"})) _ Multiply)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}
Multiply = head:Exponential tail:(_ ("*" / "/" / "%") _ Exponential)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}

Exponential = left:Absolute _ "^" _ right:Exponential {
  return { type: "BinaryExpression", operator: "^", left: left, right: right };
} / Absolute

Absolute
  = "|" expr:(Additive / CalculateBlock) "|" { return { type: "AbsoluteExpression", expression: expr }; }
  / CalculateBlock

CalculateBlock
  = "[" _ EOL* _ expr:(PointFree / Coproduct) _ EOL* _ "]" { return expr; }
  / "{" _ EOL* _ expr:(PointFree / Coproduct) _ EOL* _ "}" { return expr; }
  / "(" _ EOL* _ expr:(PointFree / Coproduct) _ EOL* _ ")" { return expr; }
  / Get

Get
  = target:(identifier / Dictionary) steps:(_ "'" _ (identifier "~"? / string))* {
      if (steps.length === 0) return target;
      return { type: "GetExpression", target: target, steps: steps.map(s => s[3]) };
  }
  / target:(identifier "~"? / string) __ "@" __ source:Get {
      return { type: "AddressGet", target: target, source: source };
  }
  / Compute

Compute = BitShift

BitShift = head:BitOr tail:(_ ("<<" / ">>") _ BitOr)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}
BitOr = head:BitXor tail:(_ "||" _ BitXor)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}
BitXor = head:BitAnd tail:(_ ";;" _ BitAnd)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}
BitAnd = head:Postfix tail:(_ "&&" _ Postfix)* {
  return tail.reduce((res, el) => ({ type: "BinaryExpression", operator: el[1], left: res, right: el[3] }), head);
}

Postfix
  = expr:Prefix ops:postfix* {
      if (ops.length === 0) return expr;
      return ops.reduce((res, op) => ({ type: "PostfixExpression", operator: op, expression: res }), expr);
  }

Prefix
  = op:prefix expr:Prefix { return { type: "PrefixExpression", operator: op, expression: expr }; }
  / Atom

// --- Atoms & Literals ---
Atom
  = charactor / string / address / register / unicode / number / identifier / unit

string = $("`" [^`\r\n]* "`") { return { type: "StringLiteral", value: text() }; }
charactor = $("\\" .) { return { type: "CharLiteral", value: text() }; }
number = $("-"? [0-9]+ "."? [0-9]*) { return { type: "NumberLiteral", value: parseFloat(text()) }; }
address = $("0x" Hex+) { return { type: "AddressLiteral", value: text() }; }
register = $("0r" Hex+ / "0b" ("0" / "1")+) { return { type: "RegisterLiteral", value: text() }; }
unicode = $("0u" Hex+) { return { type: "UnicodeLiteral", value: text() }; }
identifier = $([a-zA-Z_][a-zA-Z0-9_]*) { return { type: "Identifier", name: text() }; }
unit = "_" { return { type: "Unit" }; }

Hex = [0-9a-fA-F]

// --- Operators ---

prefix
  = "~" / "!!" / "!" / "$" / "@"

postfix
  = "!" / "~" / "@"

infix
  = "~+" / "~-" / "~*" / "~/" / "~^"
  / "<<" / ">>" / "||" / ";;" / "&&"
  / "<=" / "==" / ">=" / "!="
  / ":" / "#" / "?" / "," / "~" / ";" / "|" / "&"
  / "<" / "=" / ">" / "+" / "-" / "*" / "/" / "%" / "^" / "@" / "'"
