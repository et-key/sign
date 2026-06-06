// st_grammar.pegjs
// .st (Type Signature) ファイル用のPEG.js文法定義
// 圏論的な矢印表現を予約語として扱い、.sn 由来のリテラル演算子は "..." で囲んで区別する。

Start = Program

__ = " "+ { return null; }
_  = " "* { return null; }
SOL = &{ return location().start.column === 1; }
EOL = "\r\n" / "\r" / "\n"
EOF = !.

comment = "`" [^\r\n]* { return null; }

Program = lines:(SOL @Line EOL*)* EOF { return lines; }

Line
  = _ expr:Expression _ comment? { return expr; }
  / comment { return null; }

Expression = CategoricalExpr

// --- 圏論的演算子（予約語）の定義 ---
// 結合度順に定義する（実際には一律のASTとして構築されるため、簡略化して左結合などで処理）
// ここでは単純にASTを復元できればよいため、演算子の階層を定義する。
// 優先度:
// 1. : (Definition)
// 2. -> (Exponential)
// 3. =>, <=, <>, ~> (Coproduct Operations)
// 4. "," (Product) や その他のリテラル演算子

CategoricalExpr = TypeDefinition

TypeDefinition
  = left:Lambda _ ":" _ right:CategoricalExpr {
      return { type: 'operation', operator: ':', left: left, right: right };
  }
  / Lambda

Lambda
  = left:ApplyReverse _ "->" _ right:Lambda {
      return { type: 'operation', operator: '?', left: left, right: right };
  }
  / ApplyReverse

ApplyReverse
  = head:Apply tail:(_ "~>" _ Apply)* {
      return tail.reduce((result, element) => {
          return { type: 'operation', operator: '~>', name: 'apply_reverse', left: result, right: element[3] };
      }, head);
  }

Apply
  = head:Compose tail:(_ "<=" _ Compose)* {
      return tail.reduce((result, element) => {
          return { type: 'operation', operator: '<=', name: 'apply', left: result, right: element[3] };
      }, head);
  }

Compose
  = head:Concat tail:(_ "=>" _ Concat)* {
      return tail.reduce((result, element) => {
          return { type: 'operation', operator: '=>', name: 'compose', left: result, right: element[3] };
      }, head);
  }

Concat
  = head:Term tail:(_ "<>" _ Term)* {
      return tail.reduce((result, element) => {
          return { type: 'operation', operator: '<>', name: 'concat', left: result, right: element[3] };
      }, head);
  }

Term
  = ContinuousType
  / Block
  / Atom

// --- 連続型 (Continuous Types) ---
ContinuousType
  = "~" _ expr:Term { return { type: 'operation', operator: '~', operand: expr, position: 'prefix' }; }
  / expr:(Block / Atom) _ "~" { return { type: 'operation', operator: '~', operand: expr, position: 'postfix' }; }

// --- ブロックとグループ ---
Block
  = "(" _ expr:Expression _ ")" { return { type: 'block', kind: 'paren', content: expr }; }
  / "[" _ expr:Expression _ "]" { return { type: 'block', kind: 'bracket', content: expr }; }
  / "{" _ EOL* _ exprs:Expressions? _ EOL* _ "}" { return { type: 'block', kind: 'brace', content: exprs }; }

Expressions
  = head:Expression tail:(EOL _ @Expression)* {
      return [head, ...tail].filter(e => e !== null);
  }

// --- Atom（.snの終端記号をそのまま利用） ---
Atom
  = tvar / string / charactor / address / register / unicode / number / identifier / unit

tvar = "'" id:$([a-zA-Z][a-zA-Z0-9_]*) { return { type: 'tvar', id: id }; }

string = str:$("`" [^`\r\n]* "`") { return str; }
charactor = ch:$("\\".) { return ch; }
number = num:$("-"? [0-9]+ "."? [0-9]*) { return num; }
address = addr:$("0x" Hex+) { return addr; }
register = reg:($("0r" Hex+) / $("0b" ("0" / "1")+)) { return reg; }
unicode = uni:$("0u" Hex+) { return uni; }
identifier = id:( $([a-zA-Z][a-zA-Z0-9_]*) / $("_" [a-zA-Z0-9_]+) ) { return { type: 'Identifier', name: id }; }
Hex = [0-9a-fA-F]
unit = "_" { return { type: 'Unit' }; }
