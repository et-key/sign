{
  function buildBinaryTree(head, tail, opName, opSymbol = null) {
    return tail.reduce(function(result, element) {
      return {
        type: "operation",
        operator: opSymbol || element[1],
        left: result,
        right: element[3],
        name: opName
      };
    }, head);
  }

  const OP_NAMES = {
    ":": "define", "?": "lambda", "#": "output", ";": "xor", "|": "or", "&": "and",
    "==": "equal", "!==": "not_equal", ",": "product", " ": "coproduct",
    "~+": "range_arithmetic", "~-": "range_arithmetic_rev", "~*": "range_geometric",
    "~/": "range_geometric_rev", "~^": "range_power", "~": "range",
    "<": "less", "<=": "less_equal", "=": "assign_equal", ">=": "more_equal", ">": "more", "!=": "not_equal",
    "+": "add", "-": "sub", "*": "mul", "/": "div", "%": "mod", "^": "pow",
    "'": "get_prop", "@": "get_at", "<<": "bit_shift_left", ">>": "bit_shift_right",
    "||": "bit_or", ";;": "bit_xor", "&&": "bit_and", "!": "factorial"
  };

  function getOperatorNode(op) {
    return {
      type: "operation",
      operator: op,
      name: OP_NAMES[op] || "unknown"
    };
  }
}

Start = Program

// 空白・改行の定義
__ = " "+ { return null; }
_  = " "* { return null; }
SOL = &{ return location().start.column === 1; }
EOL = "\r\n" / "\r" / "\n"
EOF = !.

comment = "`" [^\r\n]* { return null; }

// --- プログラムと行 ---
Program
  = lines:(SOL @Line? EOL+)* last:(SOL @Line? EOF)? {
      const result = [...lines];
      if (last !== null && last !== undefined) {
        result.push(last);
      }
      return result;
    }

Line
  = _ comment { return null; }
  / _ expr:Expression _ { return expr; }

// --- 式の優先順位階層 (低い順から高い順) ---

Expression = Export

// Level 1: Export (###, ##, #)
Export
  = op:("###" / "##" / "#") _ expr:Export {
      let name = op === "###" ? "export_pin" : op === "##" ? "export_external" : "export_internal";
      return {
        type: "operation",
        operator: op,
        operand: expr,
        position: "prefix",
        name: name
      };
    }
  / Definition

// Level 2: Define (:)
Definition
  = left:Lambda _ ":" _ right:Definition {
      return { type: "operation", operator: ":", left: left, right: right, name: "define" };
    }
  / Lambda

// Level 3: Lambda (?)
Lambda
  = left:Output _ "?" _ right:Lambda {
      return { type: "operation", operator: "?", left: left, right: right, name: "lambda" };
    }
  / Output

// Level 4: Output (#)
Output
  = left:LogicalXor _ "#" _ right:Output {
      return { type: "operation", operator: "#", left: left, right: right, name: "output" };
    }
  / LogicalXor

// Level 5: Logical XOR (;)
LogicalXor
  = head:LogicalOr tail:(_ ";" _ LogicalOr)* {
      return buildBinaryTree(head, tail, "xor");
    }

// Level 6: Logical OR (|)
LogicalOr
  = head:LogicalAnd tail:(_ "|" _ LogicalAnd)* {
      return buildBinaryTree(head, tail, "or");
    }

// Level 7: Logical AND (&)
LogicalAnd
  = head:Equal tail:(_ "&" _ Equal)* {
      return buildBinaryTree(head, tail, "and");
    }

// Level 8: Structural Equality (==, !==)
Equal
  = head:Product tail:(_ op:("==" / "!==") _ Product)* {
      return tail.reduce((result, element) => {
        const op = element[1];
        const name = op === "==" ? "equal" : "not_equal";
        return {
          type: "operation",
          operator: op,
          left: result,
          right: element[3],
          name: name
        };
      }, head);
    }

// Level 9: Product (,)
Product
  = left:Coproduct _ "," _ right:Product {
      return { type: "operation", operator: ",", left: left, right: right, name: "product" };
    }
  / Coproduct

// Level 10: Space-separated Coproduct
Coproduct
  = head:Range tail:(__ @Range)+ {
      return { type: "coproduct_block", statements: [head, ...tail] };
    }
  / Range

// Level 11: Range (~, ~+, ~-, ~*, ~/, ~^)
Range
  = head:Comparison tail:(_ op:("~+" / "~-" / "~*" / "~/" / "~^" / "~") _ Comparison)* {
      return tail.reduce((result, element) => {
        const op = element[1];
        let name = "range";
        if (op === "~+") name = "range_arithmetic";
        else if (op === "~-") name = "range_arithmetic_rev";
        else if (op === "~*") name = "range_geometric";
        else if (op === "~/") name = "range_geometric_rev";
        else if (op === "~^") name = "range_power";
        return {
          type: "operation",
          operator: op,
          left: result,
          right: element[3],
          name: name
        };
      }, head);
    }

// Level 12: Comparison (<, <=, =, >=, >, !=)
Comparison
  = head:Additive tail:(_ op:("<=" / ">=" / "==" / "!=" / "<" / "=" / ">") _ Additive)* {
      return tail.reduce((result, element) => {
        const op = element[1];
        let name;
        if (op === "<") name = "less";
        else if (op === "<=") name = "less_equal";
        else if (op === "=") name = "assign_equal";
        else if (op === ">=") name = "more_equal";
        else if (op === ">") name = "more";
        else if (op === "!=") name = "not_equal";
        else if (op === "==") name = "equal";
        return {
          type: "operation",
          operator: op,
          left: result,
          right: element[3],
          name: name
        };
      }, head);
    }

// Level 13: Additive (+, -)
Additive
  = head:Multiplicative tail:(_ op:("+" / "-") _ Multiplicative)* {
      return tail.reduce((result, element) => {
        const op = element[1];
        const name = op === "+" ? "add" : "sub";
        return {
          type: "operation",
          operator: op,
          left: result,
          right: element[3],
          name: name
        };
      }, head);
    }

// Level 14: Multiplicative (*, /, %)
Multiplicative
  = head:Exponential tail:(_ op:("*" / "/" / "%") _ Exponential)* {
      return tail.reduce((result, element) => {
        const op = element[1];
        const name = op === "*" ? "mul" : op === "/" ? "div" : "mod";
        return {
          type: "operation",
          operator: op,
          left: result,
          right: element[3],
          name: name
        };
      }, head);
    }

// Level 15: Exponential (^)
Exponential
  = head:GetProp _ "^" _ tail:Exponential {
      return { type: "operation", operator: "^", left: head, right: tail, name: "pow" };
    }
  / GetProp

// Level 17: Get Property / Get At (', @)
GetProp
  = head:BitwiseShift tail:(_ op:("'" / "@") _ BitwiseShift)* {
      return tail.reduce((result, element) => {
        const op = element[1];
        const name = op === "'" ? "get_prop" : "get_at";
        return {
          type: "operation",
          operator: op,
          left: result,
          right: element[3],
          name: name
        };
      }, head);
    }

// Level 18: Bitwise Shift (<<, >>)
BitwiseShift
  = head:BitwiseOr tail:(_ op:("<<" / ">>") _ BitwiseOr)* {
      return tail.reduce((result, element) => {
        const op = element[1];
        const name = op === "<<" ? "bit_shift_left" : "bit_shift_right";
        return {
          type: "operation",
          operator: op,
          left: result,
          right: element[3],
          name: name
        };
      }, head);
    }

// Level 19: Bitwise OR (||)
BitwiseOr
  = head:BitwiseXor tail:(_ "||" _ BitwiseXor)* {
      return buildBinaryTree(head, tail, "bit_or");
    }

// Level 20: Bitwise XOR (;;)
BitwiseXor
  = head:BitwiseAnd tail:(_ ";;" _ BitwiseAnd)* {
      return buildBinaryTree(head, tail, "bit_xor");
    }

// Level 21: Bitwise AND (&&)
BitwiseAnd
  = head:Postfix tail:(_ "&&" _ Postfix)* {
      return buildBinaryTree(head, tail, "bit_and");
    }

// Level 22: Postfix (!, ~, @)
Postfix
  = head:Prefix tail:postfix* {
      return tail.reduce((result, op) => {
        let name;
        if (op === "!") name = "factorial";
        else if (op === "~") name = "expand";
        else if (op === "@") name = "import";
        return {
          type: "operation",
          operator: op,
          operand: result,
          position: "postfix",
          name: name
        };
      }, head);
    }

// Level 23: Prefix (~, !, $, @, !!, -, ><)
Prefix
  = op:prefix expr:Prefix {
      let name;
      if (op === "~") name = "continuous";
      else if (op === "###") name = "export_pin";
      else if (op === "##") name = "export_external";
      else if (op === "#") name = "export_internal";
      else if (op === "!") name = "not";
      else if (op === "$") name = "address";
      else if (op === "@") name = "input";
      else if (op === "!!") name = "bit_not";
      else if (op === "-") name = "negate";
      else if (op === "><") name = "reverse";
      return {
        type: "operation",
        operator: op,
        operand: expr,
        position: "prefix",
        name: name
      };
    }
  / Primary

// Level 24: Primary Terms (Blocks, Atoms)
Primary
  = Block
  / Atom

// --- Blocks (Parentheses, Square Brackets, Curly Brackets, Absolute Values, Indents) ---
BlockContents
  = head:Expression tail:(EOL _ (Expression / comment)?)* {
      let current = head;
      for (let element of tail) {
        let expr = element[2];
        if (expr !== null && expr !== undefined) {
          current = {
            type: "operation",
            operator: "\\n",
            left: current,
            right: expr,
            name: "newline"
          };
        }
      }
      return current;
    }

BlockContentsOpt
  = contents:BlockContents { return contents; }
  / _ { return { type: "Unit" }; }

Block
  = "(" _ EOL* _ contents:(PointFree / op:all_operators &(_ EOL* _ ")") { return getOperatorNode(op); } / BlockContentsOpt) _ EOL* _ ")" {
      return { type: "block", kind: "paren", content: contents };
    }
  / "[" _ EOL* _ contents:(PointFree / op:all_operators &(_ EOL* _ "]") { return getOperatorNode(op); } / BlockContentsOpt) _ EOL* _ "]" {
      return { type: "block", kind: "bracket", content: contents };
    }
  / "{" _ EOL* _ contents:(PointFree / op:all_operators &(_ EOL* _ "}") { return getOperatorNode(op); } / BlockContentsOpt) _ EOL* _ "}" {
      return { type: "block", kind: "brace", content: contents };
    }
  / "|" expr:Expression "|" {
      return { type: "block", kind: "abs", content: expr };
    }
  / "\x02" _ EOL* _ contents:BlockContents _ EOL* _ "\x03" {
      return { type: "block", kind: "indent", content: contents };
    }

PointFree
  = op:all_operators __ right:Comparison _ "," {
      return {
        type: "operation",
        operator: ",",
        right: {
          type: "operation",
          operator: op.operator || op,
          right: right,
          name: OP_NAMES[op.operator || op] || "unknown"
        },
        name: "product"
      };
    }
  / left:Comparison __ op:all_operators _ "," {
      return {
        type: "operation",
        operator: ",",
        left: {
          type: "operation",
          operator: op.operator || op,
          left: left,
          name: OP_NAMES[op.operator || op] || "unknown"
        },
        name: "product"
      };
    }
  / op:all_operators __ right:Comparison &(_ EOL* _ ("]" / ")" / "}" / "," / EOL / EOF)) {
      return {
        type: "operation",
        operator: op.operator || op,
        right: right,
        name: OP_NAMES[op.operator || op] || "unknown"
      };
    }
  / left:Comparison __ op:all_operators &(_ EOL* _ ("]" / ")" / "}" / "," / EOL / EOF)) {
      return {
        type: "operation",
        operator: op.operator || op,
        left: left,
        name: OP_NAMES[op.operator || op] || "unknown"
      };
    }

// --- Atoms ---
Atom
  = string / inline_code / charactor / address / register / unicode / number / identifier / unit / ub

string = $("`" [^`\r\n]* "`")

inline_code = "\"" chars:inline_char* "\"" { return { type: "inline_code", value: chars.join("") }; }

inline_char
  = "\\" escape:[^\r\n] { return escape; }
  / [^\"\r\n]
charactor = $("\\".)
number = $("-"? [0-9]+ "."? [0-9]*)
address = $("0x" Hex+)
register = $("0r" Hex+) / $("0b" ("0" / "1")+)
unicode = $("0u" Hex+)
identifier = id:( $([a-zA-Z][a-zA-Z0-9_]*) / $("_" [a-zA-Z0-9_]+) ) { return `<${id}>`; }
Hex = [0-9a-fA-F]
unit = "__"
ub = "_"

// --- Prefix/Postfix Operators ---
prefix
  = "###" / "##" / "#" / "><" / "~" / "!!" / "!" / "$" / "@" / ("-" &(Block / identifier))

postfix
  = "!" / "~" / "@"

all_operators
  = "###" / "##" / "#"
  / "!==" / "==" / "!=" / "<=" / ">=" / "<<" / ">>" / "||" / ";;" / "&&" / "!!" / "~+" / "~-" / "~*" / "~/" / "~^"
  / ":" / "?" / ";" / "|" / "&" / "," / "~" / "<" / "=" / ">" / "+" / "-" / "*" / "/" / "%" / "^" / "'" / "@" / "!" / "$" / "><"
