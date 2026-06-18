// st_grammar.pegjs
// .st (Type Signature) ファイル用のPEG.js文法定義 (Grothendieck Universe準拠)

Start = Program

__ = " "+ { return null; }
_  = " "* { return null; }
SOL = &{ return location().start.column === 1; }
EOL = "\r\n" / "\r" / "\n"
EOF = !.

comment = "`" [^\r\n]* { return null; }

Program = lines:(Line? EOL)* last:Line? EOF { return [...lines.map(l => l[0]), last].filter(l => l !== null); }

Line
  = _ expr:Definition _ comment? { return expr; }
  / _ comment { return null; }

Definition
  = left:Identifier _ ":" _ right:TypeExpr {
      return { type: 'operation', operator: ':', left: left, right: right };
  }
  / TypeExpr

TypeExpr
  = FunctionType
  / ApplyExpr

// T U -> Atom のような関数の表現
FunctionType
  = args:TermList _ "->" _ ret:TypeExpr {
      // args が複数ある場合、カリー化された関数のネストとして表現する
      return args.reduceRight((acc, arg) => {
          return { type: 'operation', operator: '->', left: arg, right: acc };
      }, ret);
  }

TermList
  = head:Term tail:(__ Term)* {
      return [head, ...tail.map(t => t[1])];
  }

// A B C のようなスペース区切りの型適用（Categorical Apply）または型リスト
ApplyExpr
  = head:Term tail:(__ Term)* {
      if (tail.length === 0) return head;
      return tail.reduce((result, element) => {
          return { type: 'operation', operator: ' ', left: result, right: element[1] };
      }, head);
  }

Term
  = ContinuousType
  / Block
  / UniverseType
  / TypeVariable

// --- 連続型 (Continuous Types / ストリーム・可変長引数) ---
// ~T は配列(List)のアンパックや残余引数を表す
ContinuousType
  = "~" _ expr:Term { return { type: 'operation', operator: '~', operand: expr, position: 'prefix' }; }
  / expr:(Block / UniverseType / TypeVariable) "~" { return { type: 'operation', operator: '~', operand: expr, position: 'postfix' }; }

// --- ブロックとグループ ---
Block
  = "(" _ expr:TypeExpr _ ")" { return { type: 'block', kind: 'paren', content: expr }; }
  / "[" _ expr:TypeExpr _ "]" { return { type: 'block', kind: 'bracket', content: expr }; }

// --- Universe Built-in Types ---
// Grothendieck Universe に準拠した基礎型
UniverseType
  = "Atom" { return { type: 'UniverseType', name: 'Atom' }; }
  / "List" { return { type: 'UniverseType', name: 'List' }; }
  / "Lambda" { return { type: 'UniverseType', name: 'Lambda' }; }
  / "SignValue" { return { type: 'UniverseType', name: 'SignValue' }; }
  / "Scalar" { return { type: 'UniverseType', name: 'Scalar' }; }
  / "Number" { return { type: 'UniverseType', name: 'Number' }; }
  / "String" { return { type: 'UniverseType', name: 'String' }; }
  / "Boolean" { return { type: 'UniverseType', name: 'Boolean' }; }
  / "Address" { return { type: 'UniverseType', name: 'Address' }; }
  / "Unit" { return { type: 'UniverseType', name: 'Unit' }; }
  / "_" { return { type: 'UniverseType', name: 'Unit' }; }
  / "Hole" { return { type: 'UniverseType', name: 'Hole' }; }

// --- 型変数 (大文字始まりのIdentifier) ---
TypeVariable
  = id:$([A-Z][a-zA-Z0-9_]*) { return { type: 'TypeVariable', name: id }; }

// --- 通常のIdentifier (関数名など) ---
Identifier
  = id:$([a-z_][a-zA-Z0-9_]*) { return id; }

// ベースとなる型（再帰の底）
BaseType = Term
