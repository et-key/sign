{
  // 状態管理（Depth）はLexerの前処理に完全に委譲したため、
  // グローバルな変数は一切不要になりました。
}

Start = Program

// 空白・改行の定義
// !! スペースは「見た目の区切り」ではなく「コプロダクト演算子そのもの」である !!
// 1つ以上の半角スペース = Sign言語におけるコプロダクト（余積）演算子
// この「演算子としてのスペース」が Expression 層でフラットリストを生成し、
// Shunting Yard（演算子テーブル）に渡される入力となる。
__ = " "+ { return null; } // coproduct operator
_  = " "* { return null; } // optional (used only at line edges)
SOL = &{ return location().start.column === 1; }
EOL = "\r\n" / "\r" / "\n"
EOF = !.

comment = SOL "`" [^\r\n]* (EOL / EOF) { return null; }

// --- プログラムと行 ---
Program = (SOL @Line EOL*)* / comment* EOF

Line
  = _ expr:Expression _ { return expr; }

// --- コプロダクト（空白）によるフラットリスト化の核心 ---
// スペース区切りの Term 列を「フラットな配列」として返す。
// この配列が Shunting Yard（演算子テーブル）への入力となる。
// 意味解決（apply/compose/concat の区別）はこの後の意味論フェーズで行う。
Expression
  = head:Term tail:(__ @Term)* {
      if (tail.length === 0) {
          // 単一の要素のみの場合（すでに配列化されている密着演算子なども含む）
          return head;
      }
      // flat() によって、密着結合で生成された小さな配列（例: ["@_", "x"]）を
      // 親のリストに同じ次元で展開（フラット化）します。
      return [head, ...tail].flat();
  }

// --- 密着結合（Syntax = Type）の要 ---
// スペースなし = 同一 Term 内 = 「密着」
// これにより、同じ記号でもスペースの有無だけで役割が変わる：
//   @x   → 前置（@_ として記号化）: スペースなしで core の左に密着
//   x @ y → 中置: スペースありで Expression 層のコプロダクト列に入る
//   x@   → 後置（_@ として記号化）: スペースなしで core の右に密着
// 前置記号は末尾に "_" を付与、後置記号は先頭に "_" を付与することで
// Shunting Yard がフラットリスト内での役割を一意に識別できる。
Term
  = pre:Prefixes core:Core post:Postfixes {
      // プレフィックスもポストフィックスもない場合は、単一の要素を返す
      if (pre.length === 0 && post.length === 0) return core;
      
      // 密着している場合はフラットな配列として返す
      // Expression層の flat() によって全体のリストに溶け込みます
      return [...pre, core, ...post];
  }
  / operator

// 前置演算子には後ろに "_" を付与（例: "@" → "@_"）
// → Shunting Yard が「この @ は前置」と識別できる
Prefixes
  = pre:prefix* { return pre.map(p => p + "_"); }

// 後置演算子には前に "_" を付与（例: "@" → "_@"）
// → Shunting Yard が「この @ は後置」と識別できる
Postfixes
  = post:postfix* { return post.map(p => "_" + p); }

Core
  = Block
  / Atom

// --- 空間的配置（ネスト構造） ---
Block
  = "[" _ exprs:Expressions _ "]" { return exprs; }
  / "{" _ exprs:Expressions _ "}" { return exprs; }
  / "(" _ exprs:Expressions _ ")" { return exprs; }
  / "|" exprs:Expressions "|" &(__ / EOL / EOF / "]" / "}" / ")" / "\x03") { return [`"ABS_"`, ...exprs]; }
  // Lexerが挿入した制御用ASCIIコードによるインデントブロックの切り出し
  // ※実際のLexerの実装に合わせて "\x02", "\x03" は変更してください
  / "\x02" _ exprs:Expressions _ "\x03" { return [`"INDENT_"`, ...exprs, `"_DEDENT"`]; }

// ブロック内で使われる複数行の式
Expressions
  = head:Expression tail:(EOL _ @Expression)* {
      return [head, ...tail].filter(e => e !== null);
  }

// --- 値（Atom）の定義（既存の正規表現ルールを踏襲） ---
Atom
  = string / charactor / address / register / unicode / number / identifier / unit / hole

string = $("`" [^`\r\n]* "`")
charactor = $("\\".)
number = $("-"? [0-9]+ "."? [0-9]*)
address = $("0x" Hex+)
register = $("0r" Hex+) / $("0b" ("0" / "1")+)
unicode = $("0u" Hex+)
identifier = id:( $([a-zA-Z][a-zA-Z0-9_]*) / $("_" [a-zA-Z0-9_]+) ) {return `<${id}>`}
Hex = [0-9a-fA-F]
unit = "__" / "\x00"
hole = "_"

// --- 演算子・記号（前置・後置・中置の振る舞い解決はShunting Yardへ） ---
prefix
  = "###" / "##" / "#" / ("-" &(Block / identifier)) / "~" / "!!" / "!" / "$" / "@"

postfix
  = "!" / "~" / "@"

operator
  = $[!"#$%&'-=^~\|@;+:*,<>/?]+
