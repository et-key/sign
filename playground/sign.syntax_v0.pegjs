{{
  global.typeTable = {
    lambda : []
    dictionary : []
    list : []
  }

  global.context = {
    indentStack : []
    indent = ""
  }
}}

//空白必須
__ = " "+

//空白可
_ = " "*

Program = (Expression / Comment)*

Comment = &{ /^`[^\r\n]\n/gm }

Expression
  = SOL Definition EOL
  / SameDent Verification

Definition
  = Export            //エクスポート
  / Define            //定義（名前を付けてオブジェクトを束縛する）

Verification
  = Output
  / Applicate         //関数適用
  / Construct         //ラムダ、リスト、辞書型の構築
  / Compose           //関数合成
  / Calculate         //ALUで扱う演算の集合で、優先順位を定義する必要ある
  / GetAddress        //メモリアドレスの取得
  / Get               //辞書型やリストの中から値を取得
  / Compute           //Bit演算だけ行う
  / input             //アドレスから値を取得
  / Import            //別ファイルからのインポート
  / Block             //式のブロック


Export = ("###" / "##" / "#")? Define

Define
  = identifier _ ":" (
    _ defineOp          //右結合である
    / [\n] Dictionary   //DictionaryIdentifierになる
    / Functional        //Functional_Identifierになる
    / string_literal    //文字列型になる（内部的にはリスト） 
    / DirectProduct     //List_Identifierになる
    / atom              //型推論の必要はなく、演算子での振る舞いに任せる
  )

Dictionary
  = Indent identifier _ ":" (
    / [\n] Dictionary   //DictionaryIdentifierになる
    / Functional        //Functional_Identifierになる
    / string_literal    //文字列型になる（内部的にはリスト） 
    / DirectProduct     //List_Identifierになる
    / Atom              //型推論の必要はなく、演算子での振る舞いに任せる
  ) Dedent

Functional
  = Lambda
  / "[" PointFree "]"
  / "{" PointFree "}"
  / "(" PointFree ")"

Output
  = (address / identifier / Address) __ "#" __ (Applicate / Output)

Applicate
  = (Closure / Get / functional_Identifier) (__ DirectProduct)*
  / DirectProduct

Closure
  = "[" (Lambda / PointFree) "]"
  = "{" (Lambda / PointFree) "}"
  = "(" (Lambda / PointFree) ")"

Lambda
  = Arguments _ "?" _ (output / Lambda)
  / Arguments _ "?" "\n" Indent (Match_Case / Output) Dedent

PointFree
  = DirectMap
  / DirectFold

DirectMap
  =  prefix "_" ","
  / "_" postfix ","
  / Number infix ","
  / infix Number ","

DirectFold = infix

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

Block
  = "[" Expression+ "]"
  / "{" Expression+ "}"
  / "(" Expression+ ")"
  / Indent Expression Dedent

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
string_literal = "`" [^`\r\n]* "`"

// 2. 浮動小数点
// （整数部 . 小数部）
float_literal = "-"? int_part:[0-9]+ "." frac_part:[0-9]+

// 3. アドレス型 ("0x" Hex*)
// ※ AArch64のメモリオペランド等に直接写像される
address_literal = "0x" Hex+

// 4. レジスタ即値型 ("0r" Hex*)
// ※ AArch64の物理レジスタ（x0, v0など）や直値バインディングに写像される
register_literal = "0r" Hex+

// 5. UniCode型 ("0u" Hex*)
unicode_literal = "0u" Hex+

// 6. 識別子（変数名など）
identifier = [a-zA-Z_][a-zA-Z0-9_]*

// --- ヘルパー規則 ---
// 16進数の文字セット
Hex = [0-9a-fA-F]


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
getOp =  "'" / "@"

