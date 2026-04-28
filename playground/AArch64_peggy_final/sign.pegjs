{
  // 左結合の二項演算子を木構造（AST）に変換するためのヘルパー関数
  function buildBinaryTree(head, tail, opIndex = 1, rightIndex = 3) {
    return tail.reduce(function(result, element) {
      return {
        type: "BinaryOperation",
        operator: element[opIndex],
        left: result,
        right: element[rightIndex]
      };
    }, head);
  }
}

Start = Program

//空白必須
__ = sp:" "+ { return null; }

//空白可
_ = " "* { return null; }

//行頭
SOL = &{ return location().start.column === 1; }

//行末
EOL = "\r\n" / "\r" / "\n"

EOF = !.

comment = ("`" [^\r\n]*) { return null; }

// ファイルの終端で無限ループしないように、行末が EOL である行の繰り返しと、
// 最後の行 (EOF で終わる行) に分割して定義します。
Program = lines:Line* last:LastLine? {
  return {
    type: "Program",
    body: [...lines, last].filter(l => l !== null && l !== undefined)
  };
}

Line = SOL exp:(Expression / comment)? EOL { return exp; }
LastLine = SOL exp:(Expression / comment)? EOF { return exp; }

Expression = Export

Export = exportType:("###" / "##" / "#")? def:Define {
  if (exportType) {
    return { type: "Export", exportLevel: exportType, declaration: def };
  }
  return def;
}

Define
  = id:identifier _ ":" _ def:Define {
      return { type: "Define", identifier: id, definition: def };
    }
  / Lambda

Lambda
  = args:Arguments _ "?" _ body:(Lambda / Match_Case+) {
      return { type: "Lambda", arguments: args, body: body };
    }
  / Output
  / PointFree

Output
  = target:(address / identifier) tail:(__ "#" __ Lambda)+ {
      return { type: "Output", target: target, calls: tail.map(t => t[3]) };
    }
  / Consideration

Consideration = Logical_Xor

Logical_Xor = head:Logical_Or tail:(_ ";" _ Logical_Or)* { return buildBinaryTree(head, tail); }
Logical_Or = head:Logical_And tail:(__ "|" __ Logical_And)* { return buildBinaryTree(head, tail); }
Logical_And = head:Judgement tail:(_ "&" _ Judgement)* { return buildBinaryTree(head, tail); }
Judgement = head:Construct tail:(_ ("==" / "!==") _ Construct)* { return buildBinaryTree(head, tail); }

Construct
  = Dictionary
  / Product

Dictionary = Indent entries:((identifier "~"? / string) _ ":" _ (Lambda / Atom / Construct))+ Dedent {
    return {
      type: "Dictionary",
      entries: entries.map(e => ({
        key: Array.isArray(e[0]) ? e[0].join("") : e[0],
        value: e[4]
      }))
    };
}

Arguments = Inline / Defaultive

Defaultive
  = "[" EOL Indent entries:("~"? identifier (_ ":" _ Lambda EOL)?)+ Dedent "]" {
      return { type: "Arguments", style: "bracket", items: entries.map(e => ({
        lazy: e[0] === "~", identifier: e[1], defaultValue: e[2] ? e[2][3] : null
      }))};
    }
  / "{" EOL Indent entries:("~"? identifier (_ ":" _ Lambda EOL)?)+ Dedent "}" {
      return { type: "Arguments", style: "brace", items: entries.map(e => ({
        lazy: e[0] === "~", identifier: e[1], defaultValue: e[2] ? e[2][3] : null
      }))};
    }
  / "(" EOL Indent entries:("~"? identifier (_ ":" _ Lambda EOL)?)+ Dedent ")" {
      return { type: "Arguments", style: "paren", items: entries.map(e => ({
        lazy: e[0] === "~", identifier: e[1], defaultValue: e[2] ? e[2][3] : null
      }))};
    }

Inline
  = head:identifier tail:(__ "~"? identifier)* {
      return {
        type: "Arguments", style: "inline", items: [{ lazy: false, identifier: head }].concat(
          tail.map(t => ({ lazy: t[1] === "~", identifier: t[2] }))
        )
      };
    }

Match_Case = EOL Indent cases:((Consideration / Comparison) _ ":" _ (Arithmetic / Dictionary / Lambda / Match_Case) EOL)+ Dedent {
    return {
      type: "MatchCase",
      cases: cases.map(c => ({ condition: c[0], body: c[4] }))
    };
}
 
PointFree
  = DirectMap
  / Normal
  / DirectFold

DirectMap
  = pre:prefix u:unit _ "," { return { type: "DirectMap", prefix: pre, unit: u }; }
  / u:unit post:postfix _ "," { return { type: "DirectMap", unit: u, postfix: post }; }
  / target:(number / address / register) __ op:infix _ "," { return { type: "DirectMap", target: target, infix: op, position: "left" }; }
  / op:infix __ target:(number / address / register) _ "," { return { type: "DirectMap", target: target, infix: op, position: "right" }; }

Normal
  = pre:prefix u:unit { return { type: "PointFreeNormal", prefix: pre, unit: u }; }
  / u:unit post:postfix { return { type: "PointFreeNormal", unit: u, postfix: post }; }
  / target:(number / address / register) __ op:infix { return { type: "PointFreeNormal", target: target, infix: op, position: "left" }; }
  / op:infix __ target:(number / address / register) { return { type: "PointFreeNormal", target: target, infix: op, position: "right" }; }
  
DirectFold = op:infix { return { type: "DirectFold", infix: op }; }

Product
  = Sequence
  / head:Coproduct tail:(_ "," _ Coproduct)* { 
      if (tail.length === 0) return head;
      return { type: "Coproduct", elements: [head].concat(tail.map(t => t[3])) };
    }

Sequence
  = b1:Block _ op1:("~+" / "~-" / "~*" / "~/" / "~^") _ b2:Block __ "~" __ b3:Block {
      return { type: "Sequence", blocks: [b1, b2, b3], operators: [op1, "~"] };
    }
  / b1:Block _ op:("~+" / "~-" / "~*" / "~/" / "~^") _ b2:Block {
      return { type: "Sequence", blocks: [b1, b2], operators: [op] };
    }
  / b1:Block __ "~" __ b2:Block { return { type: "Sequence", blocks: [b1, b2], operators: ["~"] }; }
  / b:Block __ "~" { return { type: "Sequence", blocks: [b], operators: ["~_postfix"] }; }
  / "~" __ b:Block { return { type: "Sequence", blocks: [b], operators: ["~_prefix"] }; }

Coproduct = head:Comparison tail:(__ Comparison)* { 
    if (tail.length === 0) return head;
    return { type: "Coproduct", elements: [head].concat(tail.map(t => t[1])) };
  }

Comparison = head:Arithmetic tail:(_ ("<=" / ">=" / "!=" / "<" / ">" / "=") _ Arithmetic)* { return buildBinaryTree(head, tail); }

Arithmetic = Additive

Additive = head:Multiply tail:(_ ("+" / "-" ) _ Multiply)* { return buildBinaryTree(head, tail); }
Multiply = head:Exponential tail:(_ ("*" / "/" / "%") _ Exponential)* { return buildBinaryTree(head, tail); }

Exponential
  = head:Get _ "^" _ tail:Exponential { return { type: "BinaryOperation", operator: "^", left: head, right: tail }; }
  / Get

Get
  = head:Compute tail:(_ "'" _ ((identifier "~"?) / string))* {
      if (tail.length === 0) return head;
      return { type: "Get", target: head, properties: tail.map(t => Array.isArray(t[3]) ? t[3].join("") : t[3]) };
    }
  / head:Compute tail:( _ "'" _ (Product / Sequence / number / (identifier "~"?)))* {
      if (tail.length === 0) return head;
      return { type: "GetComplex", target: head, properties: tail.map(t => t[3]) };
    }
  / id:(identifier "~"? / string) __ "@" __ tail:Get {
      return { type: "GetAt", identifier: Array.isArray(id) ? id.join("") : id, target: tail };
    }
  / Compute

Compute = BitShift

BitShift = head:BitOr tail:(_ ("<<" / ">>") _ BitOr)* { return buildBinaryTree(head, tail); }
BitOr = head:BitXor tail:(_ "||" _ BitXor)* { return buildBinaryTree(head, tail); }
BitXor = head:BitAnd tail:(_ ";;" _ BitAnd)* { return buildBinaryTree(head, tail); }
BitAnd = head:Postfix tail:(_ "&&" _ Postfix)* { return buildBinaryTree(head, tail); }

Postfix
  = head:Prefix tail:postfix* {
      if (tail.length === 0) return head;
      return { type: "Postfix", expression: head, operators: tail };
    }

Prefix
  = ops:prefix+ exp:Prefix { return { type: "Prefix", operators: ops, expression: exp }; }
  / Block

Block
  = "|" exps:Arithmetic+ "|" { return { type: "Block", style: "Arithmetic", expressions: exps }; }
  / "[" _ exps:Expression* _ "]" { return { type: "Block", style: "Square", expressions: exps }; }
  / "{" _ exps:Expression* _ "}" { return { type: "Block", style: "Curly", expressions: exps }; }
  / "(" _ exps:Expression* _ ")" { return { type: "Block", style: "Paren", expressions: exps }; }
  / Indent exps:Expression+ Dedent { return { type: "Block", style: "Indent", expressions: exps }; }
  / Atom

Atom
  = val:charactor { return { type: "Atom", dataType: "charactor", value: val }; }
  / val:string { return { type: "Atom", dataType: "string", value: val }; }
  / val:address { return { type: "Atom", dataType: "address", value: val }; }
  / val:register { return { type: "Atom", dataType: "register", value: val }; }
  / val:unicode { return { type: "Atom", dataType: "unicode", value: val }; }
  / val:number { return { type: "Atom", dataType: "number", value: val }; }
  / val:identifier { return { type: "Atom", dataType: "identifier", value: val }; }
  / val:unit { return { type: "Atom", dataType: "unit", value: val }; }

string = val:$("`" [^`\r\n]* "`") { return val; }
charactor = val:$("\\".) { return val; }
number = val:$("-"? [0-9]+ "."? [0-9]*) { return val; }
address = val:$("0x" Hex+) { return val; }
register 
  = val:$("0r" Hex+) { return val; }
  / val:$("0b" ("0" / "1")+) { return val; }
unicode = val:$("0u" Hex+) { return val; }

identifier
  = val:$([a-zA-Z][a-zA-Z0-9_]*) { return val; }
  / val:$("_" [a-zA-Z0-9_]+) { return val; }

Hex = [0-9a-fA-F]

prefix = "~" / "!!" / "!" / "$" / "@"
postfix = "!" / "~" / "@"
infix
  = "~+" / "~-" / "~*" / "~/" / "~^"
  / "<<" / ">>" / "||" / ";;" / "&&"
  / "!==" / "<=" / "==" / ">=" / "!="
  / ":" / "#" / "?" / "," / "~" / ";" / "|" / "&"
  / "<" / "=" / ">" / "+" / "-" / "*" / "/" / "%" / "^" / "@" / "'"

unit = "_" { return "_"; }

// === Lexer連携：仮想カッコ ===
Indent = "\x02" { return null; }
Dedent = "\x03" { return null; }