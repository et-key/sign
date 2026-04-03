{{
  const typeTable = {
    lambda : []
    dictionary : []
    list : []
  }
}}

//空白必須
__ = " "+

//空白可
_ = " "*

Comment = { /^`[^\r\n]\n/gm }

Program = Expression* / Comment*

Expression
  = Definition
  / Verification

Definition
  = Export
  / Define

Verification
  = Output
  / Applicate
  / Construct
  / Compose
  / Calculate
  / GetAddress
  / Get
  / Compute
  / input
  / Import
  / Block


Export = ("###" / "##" / "#") Define

Define
  = identifier _ ":" _ (
    right:Dictionary {
      typeTable.dictionary.push(symbol)
    }
    / right:Closure {
      typeTable.lambda.push(symbol)
    }

  )

Output
  = (address / identifier / Address) __ "#" __ (Applicate / Output)

Apply
  = (Closure / Get / identifier) __ DirectProduct

Closure
  = lambda
  / DirectProduct

Lambda
  = PointFree
  / "[" Arguments _ "?" _ output "]"
  / "{" Arguments _ "?" _ output "}"
  / "(" Arguments _ "?" _ output ")"

PointFree
  = DirectMap
  / DirectFold

DirectMap
  = "[" prefix "_" "," "]"
  / "{" prefix "_" "," "}"
  / "(" prefix "_" "," ")"
  / "[" "_" postfix "," "]"
  / "{" "_" postfix "," "}"
  / "(" "_" postfix "," ")"
  / "[" Number infix "," "]"
  / "{" Number infix "," "}"
  / "(" Number infix "," ")"
  / "[" infix Number "," "]"
  / "{" infix Number "," "}"
  / "(" infix Number "," ")"

DirectFold
  = "[" infix "]"
  / "{" infix "}"
  / "(" infix ")"

DirectProduct
  = DirectSum _ "," _ DirectProduct
  / DirectSum

DirectSum
  = Logical (__ Logical)*
  / Compose

prefix
  = "###" / "##" / "#" / "~" / "!!" / "!" / "$" / "@"

postfix
  = "!" / "~" / "@"

infix
  = "~+" / "~-" / "~*" / "~/" / "~^"
  / "<<" / ">>" / "||" / ";;" / "&&"
  / "<=" / "==" / ">=" / "!="
  / ":" / "#" / "?" / "," / "~" / ";" / "|" / "&"
  / "<" / "=" / ">" / "+" / "-" / "*" / "/" / "%" / "^" / "@" / "'"

inlineBlock
  = "[" expression "]"
  / "{" expression "}"
  / "(" expression ")"

IndentBlock = Indent expression+ Dedent

closure =
   "[" list _ "?" expression "]"
  / "{" list _ "?" expression "}"
  / "(" list _ "?" expression ")"


atom
  = string_literal
  / float_literal
  / address_literal
  / register_literal
  / unicode_literal
  / integer_literal
  / identifier

// 1. 文字列型
// インデントされている、あるいは式の途中に現れるバッククォート囲みは文字列として確定します。
string_literal
  = "`" chars:[^`\r\n]* "`" { 
    return { type: "String", value: chars.join("") }; 
  }

// 2. 浮動小数点
// （整数部 . 小数部）
float_literal
  = "-"? int_part:[0-9]+ "." frac_part:[0-9]+ { 
    return { type: "Float", value: int_part.join("") + "." + frac_part.join("") }; 
  }

// 3. アドレス型 ("0x" Hex*)
// ※ AArch64のメモリオペランド等に直接写像される
address_literal
  = "0x" hex:Hex+ { 
    return { type: "Address", value: hex.join("") }; 
  }

// 4. レジスタ即値型 ("0r" Hex*)
// ※ AArch64の物理レジスタ（x0, v0など）や直値バインディングに写像される
register_literal
  = "0r" hex:Hex+ { 
    return { type: "Register", value: hex.join("") }; 
  }

// 5. UniCode型 ("0u" Hex*)
unicode_literal
  = "0u" hex:Hex+ { 
    return { type: "Unicode", value: hex.join("") }; 
  }

// 6. 識別子（変数名など）
identifier
  = chars:[a-zA-Z_][a-zA-Z0-9_]* { 
    return { type: "Identifier", value: chars[0] + chars[1].join("") }; 
  }

// --- ヘルパー規則 ---
// 16進数の文字セット
Hex
  = [0-9a-fA-F]


prefix
  = "###" / "##" / "#" / "~" / "!!" / "!" / "$" / "@" / "\\"

postfix
  = "!" / "~" / "@"

infix
  = defineOp
  / outputOp
  / lambdaOp
  / productOp
  / iteratorOp
  / logicalOp
  / comparisonOp
  / additiveOp
  / multiplexOp
  / exponentialOp
  / bitOp
  / getOp

defineOp = ":"
outputOp = "#"
lambdaOp = "?"
productOp = ","
iteratorOp = "~+" / "~-" / "~*" / "~/" / "~^" / "~"
logicalOp = ";" / "|" / "&"
comparisonOp = "<" / "<=" / "=" / "==" / ">=" / ">" / "!="
additiveOp = "+" / "-"
multiplexOp = "*" / "/" / "%"
exponentialOp = "^"
bitOp = "<<" / ">>" / "||" / ";;" / "&&"
getOp =  "@" / "'"

