// ===================================================================
// Sign Language Pure PEG Grammar (Context-Aware & Full Operator Table)
// ===================================================================

__ = " "+
_  = " "*

Program = (Expression / Comment / _)*

Expression = Definition / Verification

Definition = Export

// --- 優先順位 1-2: 定義系 ---

Export = ("###" / "##" / "#") _ Define

// ここで右辺の「構文のカタチ」を分離し、将来的な識別子の型確定を容易にする

Define
  = Identifier _ ":" _ Dictionary
  / Identifier _ ":" _ List
  / Identifier _ ":" _ Lambda
  / Identifier _ ":" _ Define
  / Verification

Verification = Output

// --- 優先順位 3: 出力 (右結合) ---
Output
  = (Address / Identifier) __ "#" __ Output
  / Apply

// --- 優先順位 4: 関数適用 (余積1) ---
// 左項が Closure(Lambda等) 右項がListかDictionaryかAtomである場合は明確に適用
Apply
  = Closure (__ DirectProduct)*
  / Identifier (__ DirectProduct)*
  / DirectProduct

// --- 優先順位 5: ラムダ (右結合) ---
Closure
  = PointFree
  / Lambda

// --- 優先順位 6: 積 (右結合) ---
DirectProduct
  = Concat _ "," _ DirectProduct
  / Concat

// --- 優先順位 7: リスト構築・結合 (余積2) ---
Concat
  = (List / Atom) (__ Compose)*
  / Compose

// --- 優先順位 8: 関数合成 (余積3) ---
Compose
  = Closure __ Closure
  / Range

// --- 優先順位 9: 範囲 ---
Range
  = Continuous (_ ("~+" / "~-" / "~*" / "~/" / "~^" / "~") _ Continuous)*

Continuous
  = "~" _ Continuous
  / LogicalXor

// --- 優先順位 11: 論理演算 (分離) ---

LogicalXor
  = Or (_ ";" _ Or)*

LogicalOr
  = LogicalAnd (_ "|" _ LogicalAnd)*

// --- 優先順位 12: 論理積 ---
LogicalAnd
  = LogicalNot (_ "&" _ LogicalNot)*

// --- 優先順位 13: 否定 (前置) ---
Not
  = "!"? Comparison

// --- 優先順位 14: 比較 ---
Comparison
  = Additive (_ ("<=" / "==" / ">=" / "!=" / "<" / "=" / ">") _ Additive)*

// --- 優先順位 15: 加減算 ---
Additive
  = Multiplicative (_ ("+" / "-") _ Multiplicative)*

// --- 優先順位 16: 乗除余 ---
Multiplicative
  = Power (_ ("*" / "/" / "%") _ Multiplicative)*

// --- 優先順位 17: 累乗 (右結合) ---
Power
  = Factorial _ "^" _ Power
  / Factorial

// --- 優先順位 18: 階乗 (後置) ---
Factorial
  = Absolute "!"*

// --- 優先順位 19: 絶対値 (囲み) ---
Absolute
  = "|" _ Expression _ "|"
  / Expand

// --- 優先順位 20: 展開 (後置) ---
Expand
  = GetAddress "~"*

// --- 優先順位 21: アドレス取得 (前置) ---
GetAddress
  = "$" _ GetAddress
  / GetSingleQuote

// --- 優先順位 22: 取得 (') ---
GetSingleQuote
  = GetAt (_ "'" _ GetAt)*

// --- 優先順位 23: 取得 (@, 右結合) ---
GetAt
  = Input _ "@" _ GetAt
  / Input

// --- 優先順位 24: 入力 (@, 前置) ---
Input
  = "@" _ Input
  / BitShift

// --- 優先順位 25: ビットシフト ---
BitShift
  = BitOr (_ ("<<" / ">>") _ BitOr)*

// --- 優先順位 26: ビット和 ---
BitOr
  = BitXor (_ "||" _ BitXor)*

// --- 優先順位 27: ビット排他 ---
BitXor
  = BitAnd (_ ";;" _ BitAnd)*

// --- 優先順位 28: ビット積 ---
BitAnd
  = BitNot (_ "&&" _ BitNot)*

// --- 優先順位 29: ビット否定 (前置) ---
BitNot
  = "!!" _ BitNot
  / Import

// --- 優先順位 30: インポート (後置) ---
Import
  = Primary "@"*

// --- 優先順位 31: ブロック・ポイントレス・基礎構造 ---
Primary
  = PointFree
  / List
  / Dictionary
  / Block
  / Atom

Block
  = "[" _ Expression _ "]"
  / "{" _ Expression _ "}"
  / "(" _ Expression _ ")"
  / IndentBlock

IndentBlock = BlockStart Expression (EOL Expression)*

// --- ポイントレス記法 ---
PointFree = DirectMap / DirectFold

DirectMap
  = "[" _ PrefixOp _ "_" _ "," _ "]"
  / "[" _ "_" _ PostfixOp _ "," _ "]"
  / "[" _ Number _ InfixOp _ "," _ "]"
  / "[" _ InfixOp _ Number _ "," _ "]"
  // ({}や()も同様のパターン)

DirectFold = "[" _ InfixOp _ "]" / "{" _ InfixOp _ "}" / "(" _ InfixOp _ ")"

Lambda =
  "[" Arguments "?" Expression "]"
  / "{" _ Arguments "?" Expression _ "}"
  / "(" _ Arguments "?" Expression _ ")"


// --- 優先順位 32: アトム・リテラル ---
Atom = Unit / Number / String / Character / Identifier

List = "[" _ (Expression (_ "," _ Expression)*)? _ "]"

Dictionary = "{" _ (KeyValuePair (_ "," _ KeyValuePair)*)? _ "}"

KeyValuePair = (Identifier / String) _ ":" _ Expression

// --- 字句規則 ---
Arguments  = Identifier (_ Identifier)*
Identifier = [a-zA-Z_][a-zA-Z0-9_]*
Address    = "0x" [0-9a-fA-F]+
Number     = "-"? [0-9]+ ("." [0-9]+)?
String     = "`" [^`\r\n]* "`"
Character  = "\\" . / "0u" [0-9a-fA-F]+

PrefixOp   = "###" / "##" / "#" / "~" / "!!" / "!" / "$" / "@" / "\\"
PostfixOp  = "!" / "~" / "@"
InfixOp    = "~+" / "~-" / "~*" / "~/" / "~^" / "<<" / ">>" / "||" / ";;" / "&&" / "<=" / "==" / ">=" / "!=" / ":" / "#" / "?" / "," / "~" / ";" / "|" / "&" / "<" / "=" / ">" / "+" / "-" / "*" / "/" / "%" / "^" / "@" / "'"

EOL = "\n" / "\r\n" / "\r"
BlockStart = $(EOL [ \t]+)
Comment = "`" [^\r\n]*
