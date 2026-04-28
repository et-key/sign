{
  let context = {
    indentStack : [],
    indent : ""
  };
}

Start = Program

//空白必須
__ = sp:" "+ { return }

//空白可
_ = " "* { return }

//行頭
SOL = &{ return location().start.column === 1; }

//行末
EOL = "\r\n" / "\r" / "\n"

EOF = !.

comment = ("`" [^\r\n]*) {return ""}

Program = (SOL (Expression / comment) (EOL / EOF))*

Expression = Export

Export = ("###" / "##" / "#")? Define

Define
  = identifier _ ":" _ Define
  / Lambda

Lambda
  = Arguments _ "?" _ (Lambda / Match_Case+)
  / Output
  / PointFree

Output
  = (address / identifier) (__ "#" __ Lambda)+
  / Consideration

Consideration = Logical_Xor
Logical_Xor = Logical_Or (_ ";" _ Logical_Or)*
Logical_Or = Logical_And (__ "|" __ Logical_And)*
Logical_And = Judgement (_ "&" _ Judgement)*
Judgement =  Construct (_ ("==" / "!==") _ Construct)*

Construct
  = Dictionary
  / Product

Dictionary = Indent ((identifier "~"? / string) _ ":" _ (Lambda / Atom / Construct))+ Dedent

Arguments = Inline / Defaultive

Defaultive
  = "[" EOL Indent ("~"? identifier (_ ":" _ Lambda EOL)?)+ Dedent "]"
  / "{" EOL Indent ("~"? identifier (_ ":" _ Lambda EOL)?)+ Dedent "}"
  / "(" EOL Indent ("~"? identifier (_ ":" _ Lambda EOL)?)+ Dedent ")"

Inline
  = identifier (__ "~"? identifier)*

Match_Case = EOL Indent ((Consideration / Comparison) _ ":" _ (Arithmetic / Dictionary / Lambda / Match_Case) EOL)+ Dedent
 
PointFree
  = DirectMap
  / Normal
  / DirectFold

DirectMap
  =  prefix unit _ ","
  / unit postfix _ ","
  / (number / address / register) __ infix _ ","
  / infix __ (number / address / register) _ ","

Normal
  =  prefix unit
  / unit postfix
  / (number / address / register) __ infix
  / infix __ (number / address / register)
  
DirectFold = infix

Product
  = Sequence
  / Coproduct (_ "," _ Coproduct)*

Sequence
  = Block _ ("~+" / "~-" / "~*" / "~/" / "~^") _ Block __ "~" __ Block
  / Block _ ("~+" / "~-" / "~*" / "~/" / "~^") _ Block
  / Block __ "~" __ Block
  / Block __ "~"
  / "~" __ Block

Coproduct = Comparison (__ Comparison)*

Comparison = Arithmetic (_ ("<=" / ">=" / "!=" / "<" / ">" / "=") _ Arithmetic)*

Arithmetic = Additive

Additive = Multiply (_ ("+" / "-" ) _ Multiply)*
Multiply = Exponential (_ ("*" / "/" / "%") _ Exponential)*

Exponential
  = Get _ "^" _ Exponential
  / Get

Get
  = Compute (_ "'" _ ((identifier "~"?) / string))*
  / Compute ( _ "'" _ (Product / Sequence / number / (identifier "~"?)))*
  / (identifier "~"? / string) __ "@" __ Get
  / Compute

Compute = BitShift

BitShift = BitOr (_ ("<<" / ">>") _ BitOr)*
BitOr = BitXor (_ "||" _ BitXor)*
BitXor = BitAnd (_ ";;" _ BitAnd)*
BitAnd = Postfix (_ "&&" _ Postfix)*

Postfix
  = Prefix postfix*

Prefix
  = prefix+ Prefix
  / Block

Block
  = "|" Arithmetic+ "|"
  / "[" _ Expression* _ "]"
  / "{" _ Expression* _ "}"
  / "(" _ Expression* _ ")"
  / Indent Expression+ Dedent
  / Atom

Atom
  = charactor
  / string
  / address
  / register
  / unicode
  / number
  / identifier
  / unit

// 1. 文字列型
// インデントされている、あるいは式の途中に現れるバッククォート囲みは文字列として確定します。

string = $("`" [^`\r\n]* "`")

charactor = $("\\".)

// 2. 浮動小数点
// （整数部 . 小数部）
number = $("-"? int_part:[0-9]+ "."? frac_part:[0-9]*)

// 3. アドレス型 ("0x" Hex*)
// ※ AArch64のメモリオペランド等に直接写像される
address = $("0x" Hex+)

// 4. レジスタ即値型 ("0r" Hex*)
// ※ AArch64の物理レジスタ（x0, v0など）や直値バインディングに写像される
register 
  = $("0r" Hex+)
  / $("0b" ("0" / "1")+)

// 5. UniCode型 ("0u" Hex*)
unicode = $("0u" Hex+)

// 6. 識別子（変数名など）
identifier
  = $([a-zA-Z][a-zA-Z0-9_]*)
  / $("_" [a-zA-Z0-9_]+)

Hex = [0-9a-fA-F]

prefix
  = "~" / "!!" / "!" / "$" / "@"

postfix
  = "!" / "~" / "@"

infix
  = "~+" / "~-" / "~*" / "~/" / "~^"
  / "<<" / ">>" / "||" / ";;" / "&&"
  / "!==" / "<=" / "==" / ">=" / "!="
  / ":" / "#" / "?" / "," / "~" / ";" / "|" / "&"
  / "<" / "=" / ">" / "+" / "-" / "*" / "/" / "%" / "^" / "@" / "'"

unit = "_"

Indent = i:[\t]+ &{
        i.length > ctx.indent.length
      }
      {
        ctx.indentStack.push(ctx.indent)
        ctx.indent = i.join("")
      }

Dedent = &{
    ctx.indent = ctx.indentStack.pop()
  }
