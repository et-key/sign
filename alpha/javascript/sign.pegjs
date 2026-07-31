// Sign言語 PEG.js構文解析仕様（alpha/javascript版）
// LanguageServer/src/sign.pegjs から派生。lexer.js による前処理（\x02/\x03マーカー）を前提とする。
// 演算子記号表の優先順位1-16を実装。ポイントレス記法と余積表現の4つの意味を実装。

Start = Program

// ==================== プログラム構造 ====================

Program = (Statement _?)*

Statement = 
    ExportLevel 
    / Comment
    / EOL

Comment = "`" [^\n\r`]* "`"?

// ==================== 優先順位階層（1-16） ====================

// 優先順位1: Export（最低優先度）
ExportLevel = 
    ExportSymbol DefineLevel
    / DefineLevel

// 優先順位2: Define + Output
` 実測確認済み: "f :" とブロック開始\x02の間には空白が入らない（"f :\x02x"）ため、
` 右辺の区切りは `_`（0個以上）にしておく。通常の "f : x" 形式（1個以上の空白）も `_` で引き続きマッチするので後方互換。
DefineLevel = 
    Identifier __ DefineSymbol _ OutputLevel
    / OutputLevel

OutputLevel = 
    (HexNumber / AddressSymbol? Identifier) __ OutputSymbol __ FunctionApplyLevel
    / FunctionApplyLevel

// 優先順位3: 構築域（Coproduct, Lambda, Product, Range）

ListConstructLevel = 
    (Number / Character / Identifier) (__ ConcatListLevel)*
    / ConcatListLevel

ConcatListLevel = 
    (ProductLevel / Number / String / Character / Unit / Identifier) (__ FunctionApplyLevel)*
    / FunctionApplyLevel

FunctionApplyLevel = 
    (LambdaLevel / PointlessExpression / Unit / Identifier) (__ FunctionComposeLevel)*
    / FunctionComposeLevel

FunctionComposeLevel = 
    (LambdaLevel / PointlessExpression / Unit / Identifier) (__ LambdaLevel)*
    / LambdaLevel

LambdaLevel = 
    ParameterList __ LambdaSymbol __ ProductLevel
    / ProductLevel

` ParameterList: bareとbracketを別非終端記号として分離。
` x ~xs（bare, streamを取る） と [x ~xs]（bracket, 構造的分解・自動name-bind）は
` 意味論が異なるため、文法レベルでも最初から分ける。
ParameterList =
    BracketParameterList
    / BareParameterList

` 括弧は全て同じ意味で使える（BlockExpression/PointlessExpressionと同じ方針）。
BracketParameterList =
    "[" _ ParameterSequence _ "]"
    / "(" _ ParameterSequence _ ")"
    / "{" _ ParameterSequence _ "}"

BareParameterList =
    ParameterSequence

` 実測確認済み（lexer.js markBlock()）: INDENT/DEDENTは\x02/\x03として直前行に連結される。
` ブロック内の各Parameterは実際には素のEOLで区切られたまま出力される
` （markBlockは同一インデント階層の行をマージしないため）。
ParameterSequence =
    BlockStart Parameter (EOL Parameter)* BlockEnd
    / Parameter (__ Parameter)*

Parameter = 
    ContinuousSymbol Identifier
    / Identifier __ DefineSymbol __ ParamDefaultExpr
    / Identifier

` ParamDefaultExpr: pure式とmonadic式（@/#含む）は構文としては同一（OutputLevelで両方到達可能）。
` pure/monadicの区別は意味論の話であり、Pass1側で式内にInputSymbol/OutputSymbolのASTノードが
` 含まれるかどうかを見て、静的特殊化フラグの可否を判定する方針とする（Pass1未実装）。
ParamDefaultExpr = OutputLevel

ProductLevel = 
    RangeLevel (__ ProductSymbol __ RangeLevel)*

RangeLevel = 
    LogicalXorLevel __ RangeSymbol __ LogicalXorLevel
    / LogicalXorLevel

// 優先順位4-6: 論理域
LogicalXorLevel = 
    LogicalOrLevel (__ XorSymbol __ LogicalOrLevel)*

LogicalOrLevel = 
    LogicalAndLevel (__ OrSymbol __ LogicalAndLevel)*

LogicalAndLevel = 
    LogicalNotLevel (__ AndSymbol __ LogicalNotLevel)*

LogicalNotLevel = 
    NotSymbol ComparisonLevel
    / ComparisonLevel

// 優先順位7: 比較演算域（連鎖比較対応）
` 疑問（未解決・要確認）: pre_alpha/semanticize/operator_table.js では等価比較が
` `==`/`!==`（優先順位8, name: equal/not_equal）として定義されている一方、
` こちらのComparisonOperatorは `=` を使っている。どちらが正なのか未確認のまま。
ComparisonLevel = 
    AbsoluteLevel ComparisonChain*

ComparisonChain = __ ComparisonOperator __ AbsoluteLevel 

// 優先順位8: 絶対値
AbsoluteLevel = 
    "|" ArithmeticAddLevel "|"
    / ArithmeticAddLevel

// 優先順位9: 加減算
ArithmeticAddLevel = 
    ArithmeticMulLevel (_ AdditiveOperator _ ArithmeticMulLevel)*

// 優先順位10: 乗除算
ArithmeticMulLevel = 
    PowerLevel (_ MultiplicativeOperator _ PowerLevel)*

// 優先順位11: 冪乗（右結合）
PowerLevel = 
    FactorialLevel (_ PowerSymbol _ PowerLevel)*
    / FactorialLevel

// 優先順位12: 階乗
FactorialLevel = 
    ResolveLevel FactorialSymbol
    / ResolveLevel

// 優先順位13: 解決評価域（Expand, Address, Get）
ResolveLevel = ExpandLevel

ExpandLevel = 
    AddressLevel ExpandSymbol
    / AddressLevel

AddressLevel = 
    AddressSymbol GetLevel
    / GetLevel

GetLevel = GetRightExpression / GetLeftExpression / ImportLevel

// 右単位元: key @ object（左結合）
GetRightExpression = 
    (Identifier / String / Integer) __ GetRightSymbol __ GetLeftExpression
    / (Identifier / String / Integer) __ GetRightSymbol __ ImportLevel

// 左単位元: object "'" key（左結合）
GetLeftExpression = 
    ImportLevel (__ GetLeftSymbol __ (Identifier / String / Integer))+

// 優先順位14: Import
ImportLevel = 
    InputLevel ImportSymbol
    / InputLevel

// 優先順位15: Input
InputLevel = 
    InputSymbol (HexNumber / Identifier)
    / PrimaryLevel

// 優先順位16: ブロック・基本要素
PrimaryLevel = 
    PointlessExpression
    / BlockExpression
    / Literal
    / Identifier

// ==================== ポイントレス記法 ====================

PointlessExpression = 
    ("[" _ PointlessContent _ "]")
    / ("{" _ PointlessContent _ "}")
    / ("(" _ PointlessContent _ ")")

PointlessContent = 
    PartialApplication
    / DirectFold

PartialApplication = 
    InfixOperator __ PrimaryLiteral _ ","?
    / PrimaryLiteral __ InfixOperator _ ","?
    / PrefixOperator
    / ("_" PostfixOperator)
DirectFold = 
    InfixOperator

PrimaryLiteral = Literal / Identifier

// ==================== ブロック構築 ====================

BlockExpression = 
    ("(" _ ExportLevel _ ")")
    / ("{" _ ExportLevel _ "}")
    / ("[" _ ExportLevel _ "]")
    / IndentBlock

IndentBlock = BlockStart ExportLevel BlockEnd?

` 実測確認済み（pre_alpha/lexisize/lexer.js の markBlock()）:
` INDENT/DEDENTは前処理段階で \x02 / \x03 の制御文字に変換済みでPEGに渡される。
` なお IndentBlock自体はBlockEndを必須では消費しない（ファイル末端などで\x03が付かないケースがあり得るため）。
BlockStart = "\x02"
BlockEnd = "\x03"

// ==================== リテラル ====================

Literal = 
    Unit
    / Number
    / String
    / Character

Unit = "_"

Number = Float / Integer / HexNumber / OctNumber / BinNumber

Integer = "-"? UnsignedInteger

UnsignedInteger = $([1-9] [0-9]*) / "0"

Float = "-"? [0-9]+ "." [0-9]+

HexNumber = $("0x" [0-9A-Fa-f]+)

OctNumber = $("0o" [0-7]+)

BinNumber = $("0b" [01]+)

String =
    "`" [^`\n\r]* "`"

Character = 
    "\\" .

Identifier = 
    $([A-Za-z_] [0-9A-Za-z_]*)

// ==================== 演算子の位置区別実装 ====================

// # 演算子（Export vs Output）
ExportSymbol = "#"
OutputSymbol = "#"

// ! 演算子（Not vs Factorial）
NotSymbol = "!"
FactorialSymbol = "!"

// ~ 演算子（Continuous vs Range vs Expand）
ContinuousSymbol = $"~"
RangeSymbol = $"~"
ExpandSymbol = $"~"

// @ 演算子（Input vs GetRight vs Import）
InputSymbol = "@"
GetLeftSymbol = "'"
GetRightSymbol = "@"
ImportSymbol = "@"

// その他の基本演算子
DefineSymbol = ":"
LambdaSymbol = "?"
ProductSymbol = ","
XorSymbol = ";"
OrSymbol = "|"
AndSymbol = "&"

ComparisonOperator = "<=" / ">=" / "!=" / "<" / ">" / "="
AdditiveOperator = "+" / "-"
MultiplicativeOperator = "*" / "/" / "%"
PowerSymbol = "^"

AddressSymbol = "$"

// ==================== ポイントレス記法用演算子分類 ====================

AnyOperator = 
    InfixOperator / PrefixOperator / PostfixOperator

InfixOperator = 
    DefineSymbol / ProductSymbol / RangeSymbol / XorSymbol / OrSymbol / AndSymbol
    / ComparisonOperator / AdditiveOperator / MultiplicativeOperator / PowerSymbol / GetLeftSymbol / GetRightSymbol

PrefixOperator = 
    ExportSymbol / NotSymbol / ContinuousSymbol / AddressSymbol / InputSymbol

PostfixOperator = 
    FactorialSymbol / ExpandSymbol / ImportSymbol

// ==================== 空白・制御文字 ====================

_ = $(" "*) // 任意個の空白（トークン区切り）
__ = $(" "+) // 1個以上の空白（優先順位3の余積演算子）

TAB = "\t"
EOL = "\n" / "\r\n" / "\r"
EOF = !.
