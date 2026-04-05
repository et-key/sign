{{
  global.typeTable = {
  };

  global.context = {
    indentStack : []
    indent = ""
  };
}}

//空白必須
__ = " "+

//空白可
_ = " "*

//行頭にマッチ
SOL = o:"" &{ /^/gm.match(o); }
EOL = [\n]

Program = (Expression / Comment)

Comment = SOL "`" [^\r\n]* EOL

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
  / Address           //メモリアドレスの取得
  / Get               //辞書型やリストの中から値を取得
  / Compute           //Bit演算だけ行う
  / input             //アドレスから値を取得
  / Import            //別ファイルからのインポート
  / Block             //式のブロック

Export = ("###" / "##" / "#")? Define

Define
  = Function
  / Dictionary
  / List
  / StringType
  / Symbolic

Symbolic
  = identifier _ ":" _ (Atom / Define) //型推論の必要はなく、演算子での振る舞いに任せる

Function
  = name:identifier _ ":" _ (PointFree / Lambda) { typeTable[name] = "function" }

Dictionary
  = name:identifier _ ":" _ EOL DictionaryInner { typeTable[name] = {} }

List
  = name:identifier _ ":" _ (DirectProduct / DirectSum) { typeTable[name] = [] }

StringType
  = name:identifier _ ":" _ string { typeTable[name] = "string" }

DictionaryInner
  = Indent
  Dedent

Output
  = (address / identifier / Address) __ "#" __ (Applicate / Output)

Applicate
  = (Closure / Get / function) (__ DirectProduct)*
  / DirectProduct

Construct
  = Dictionary
  / Closure
  / DirectProduct
  / DirectSum

Closure
  = "[" (Lambda / PointFree) "]"
  / "{" (Lambda / PointFree) "}"
  / "(" (Lambda / PointFree) ")"

Lambda
  = Arguments _ "?" _ (Output / Lambda)
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
  = Calculate (__ Calculate)*
  / Compose

Compose = 
  (Closure / function) (__ (Closure / function))*

Block
  = "[" Expression "]"
  / "{" Expression "}"
  / "(" Expression ")"
  / Indent Expression Dedent

Atom
  = charactor
  / float
  / address
  / register
  / unicode
  / identifier

// 1. 文字列型
// インデントされている、あるいは式の途中に現れるバッククォート囲みは文字列として確定します。

string = "`" [^`\r\n]* "`"

charactor = "\\" [\s\S]

// 2. 浮動小数点
// （整数部 . 小数部）
float = "-"? int_part:[0-9]+ "." frac_part:[0-9]+

// 3. アドレス型 ("0x" Hex*)
// ※ AArch64のメモリオペランド等に直接写像される
address = "0x" Hex+

// 4. レジスタ即値型 ("0r" Hex*)
// ※ AArch64の物理レジスタ（x0, v0など）や直値バインディングに写像される
register = "0r" Hex+

// 5. UniCode型 ("0u" Hex*)
unicode = "0u" Hex+

// 6. 識別子（変数名など）
identifier = [a-zA-Z_][a-zA-Z0-9_]*


// --- ヘルパー規則 ---
// 16進数の文字セット
Hex = [0-9a-fA-F]


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

Indent = tab:[\t]+ {
    
}

SameDent = tab:[\t]* {

}

Dedent = &{

} //要、実装！
