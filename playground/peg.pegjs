{
  // 左結合の木を構築するヘルパー
  function buildLeft(head, tails) {
    return tails.reduce((result, element) => ({
      type: "BinaryOperation",
      operator: element[1],
      left: result,
      right: element[3]
    }), head);
  }

  // 右結合の木を構築するヘルパー
  function buildRight(head, tails) {
    if (tails.length === 0) return head;
    const last = tails[tails.length - 1];
    const rest = tails.slice(0, -1);
    return {
      type: "BinaryOperation",
      operator: last[1],
      left: buildRight(head, rest),
      right: last[3]
    };
  }
}

Start = Program

Program = (Statement _?)*

// ==================== 優先順位階層（1-31） ====================

// 1. Export (前置)
ExportLevel = op:ExportSymbol _ inner:DefineLevel { return {type:"Export", level:op.length, body:inner}; } / DefineLevel

// 2. Define (中置・右結合※)
DefineLevel = name:Identifier __ ":" __ body:DefineLevel { return {type:"Define", name, body}; } / OutputLevel

// 3. Output (中置)
OutputLevel = target:AddressOrId __ "#" __ value:ApplyLevel { return {type:"Output", target, value}; } / ApplyLevel

// 4. Apply (余積1 - 関数適用 / 左結合)
ApplyLevel = head:LambdaLevel tails:(__ LambdaLevel)* { return buildLeft(head, tails.map(t => [""," ",t[1]])); }

// 5. Lambda (中置・右結合※)
LambdaLevel = params:ParameterList __ "?" __ body:LambdaLevel { return {type:"Lambda", params, body}; } / ProductLevel

// 6. Product (中置・右結合※ - 積 / 持ち上げ)
ProductLevel = head:PushLevel tails:(__ "," __ PushLevel)* { return buildRight(head, tails); } / PushLevel

// 7. Push/Concat/Construct (余積2 - リスト構築 / 左結合)
PushLevel = head:ComposeLevel tails:(__ ComposeLevel)* { return buildLeft(head, tails.map(t => [""," ",t[1]])); }

// 8. Compose (余積3 - 関数合成 / 左結合)
ComposeLevel = head:RangeLevel tails:(__ RangeLevel)* { return buildLeft(head, tails.map(t => [""," ",t[1]])); }

// 9. Range (中置 - 範囲構築)
RangeLevel = head:ContinuousLevel tails:(__ RangeOperator __ ContinuousLevel)* { return buildLeft(head, tails); } / ContinuousLevel

// 10. Continuous (前置※)
ContinuousLevel = "~" inner:LogicalXorLevel { return {type:"Continuous", body:inner}; } / LogicalXorLevel

// 11. XOR / OR (中置)
LogicalXorLevel = head:LogicalAndLevel tails:(__ (";" / "|") __ LogicalAndLevel)* { return buildLeft(head, tails); } / LogicalAndLevel

// 12. AND (中置)
LogicalAndLevel = head:LogicalNotLevel tails:(__ "&" __ LogicalNotLevel)* { return buildLeft(head, tails); } / LogicalNotLevel

// 13. NOT (前置)
LogicalNotLevel = "!" inner:ComparisonLevel { return {type:"Unary", op:"!", body:inner}; } / ComparisonLevel

// 14. Comparison (中置 - 連鎖比較)
ComparisonLevel = head:ArithmeticAddLevel tails:(__ ComparisonOperator __ ArithmeticAddLevel)* { return buildLeft(head, tails); } / ArithmeticAddLevel

// 15. Add/Sub (中置)
ArithmeticAddLevel = head:ArithmeticMulLevel tails:(_ ("+" / "-") _ ArithmeticMulLevel)* { return buildLeft(head, tails); } / ArithmeticMulLevel

// 16. Mul/Div/Mod (中置)
ArithmeticMulLevel = head:PowerLevel tails:(_ ("*" / "/" / "%") _ PowerLevel)* { return buildLeft(head, tails); } / PowerLevel

// 17. Pow (中置・右結合※)
PowerLevel = head:FactorialLevel tails:(_ "^" _ PowerLevel)* { return buildRight(head, tails); } / FactorialLevel

// 18. Factorial (後置)
FactorialLevel = inner:AbsLevel "!" { return {type:"Postfix", op:"!", body:inner}; } / AbsLevel

// 19. Absolute (囲み)
AbsLevel = "|" inner:ArithmeticAddLevel "|" { return {type:"Absolute", body:inner}; } / ExpandLevel

// 20. Expand (後置※)
ExpandLevel = inner:AddressLevel "~" { return {type:"Expand", body:inner}; } / AddressLevel

// 21. Address (前置)
AddressLevel = "$" inner:GetLevel { return {type:"Address", body:inner}; } / GetLevel

// 22. Get (中置※ - 右結合/左結合混在を一旦整理)
GetLevel = head:InputLevel tails:(_ ("'" / "@") _ InputLevel)* { return buildLeft(head, tails); } / InputLevel

// 23. Input (前置)
InputLevel = "@" inner:BitShiftLevel { return {type:"Input", body:inner}; } / BitShiftLevel

// 24. BitShift (中置)
BitShiftLevel = head:BitOrLevel tails:(_ ("<<" / ">>") _ BitOrLevel)* { return buildLeft(head, tails); } / BitOrLevel

// 25-27. Bitwise Ops (中置)
BitOrLevel = head:BitXorLevel tails:(_ ("||" / ";;" / "&&") _ BitXorLevel)* { return buildLeft(head, tails); } / BitNotLevel

BitXOrLevel = head:BitAndLevel tails:(_ ("||" / ";;" / "&&") _ BitAndLevel)* { return buildLeft(head, tails); } / BitNotLevel

// 28. BitNot (前置)
BitNotLevel = "!!" inner:ImportLevel { return {type:"Unary", op:"!!", body:inner}; } / ImportLevel

// 29. Import (後置)
ImportLevel = inner:PrimaryLevel "@" { return {type:"Import", body:inner}; } / PrimaryLevel

// 30. Block / Indent (囲み・インデント)
PrimaryLevel = 
    "(" _ inner:ExportLevel _ ")" { return inner; }
    / "{" _ inner:ExportLevel _ "}" { return inner; }
    / "[" _ inner:ExportLevel _ "]" { return inner; }
    / IndentBlock
    / Literal
    / name:Identifier &{ return true; /* ここで型テーブルを参照してバックトラックを制御 */ }

// 31. Escape (前置) - 字句レベルで処理

// ==================== 字句定義 ====================

Identifier = $([A-Za-z_][0-9A-Za-z_]*)
AddressOrId = HexNumber / ("$" ? Identifier)
ParameterList = head:Identifier tails:(__ Identifier)* { return [head].concat(tails.map(t => t[1])); }
RangeOperator = "~" [+\-*/^]?
ComparisonOperator = "<=" / ">=" / "!=" / "==" / "=" / "<" / ">"
ExportSymbol = "###" / "##" / "#"
Literal = Number / String / Character / "_"

_ = [ ]*
__ = [ ]+
EOL = "\n" / "\r\n" / "\r"