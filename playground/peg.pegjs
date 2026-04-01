// ============================================================================
// Sign Language Strict PEG Grammar
// Core Philosophy: Syntax = Type / Invisible Strong Typing
// ============================================================================

// ----------------------------------------------------
// プログラムのエントリポイント
// ----------------------------------------------------
program
  = expressions / comment*

// 全ての式は余積（リストまたは適用）として並び得る
expressions
  = expr (" " expr)*

// コメント: バッククォートから行末まで（ASTには現れないリテラル外の振る舞い）
comment
  = &{ return location().start.column === 1; } "`" [^\n]*

// 必須の空白（スペース、改行、およびコメントを包含して透過的に処理）

// 任意の空白（無くても良い）
_
  = " "*

// 一意な空白（必ず一つ以上ある）
__
  = " "+

// ----------------------------------------------------
// 式の優先順位階層 (Level 1 〜 31)
// ----------------------------------------------------
expr = expr_1

// Level 1: export (前置 / 空白不可)
expr_1
  = "###" expr_2
  / "##" expr_2
  / "#" expr_2
  / expr_2

// Level 2: define (中置 / 右結合)
expr_2
  = expr_3 _ ":" _ expr_2
  / expr_3

// Level 3: output (中置 / 左結合)
expr_3
  = expr_4 (__ "#" __ expr_4)*

// Level 4: 余積 (apply)
expr_4
  // 1. Map適用: カンマを伴うポイントフリーと後続引数（1つ以上）の厳密結合
  = head:pf_map_block tail:(apply_coproduct expr_6)+ {
      return { type: "MapApply", func: head, args: tail.map(t => t[1]) };
  }

  // 2. Fold適用: 単独演算子のポイントフリーと後続引数（1つ以上）の厳密結合
  / head:pf_fold_block tail:(apply_coproduct expr_6)+ {
      return { type: "FoldApply", func: head, args: tail.map(t => t[1]) };
  }

  // 3. 一般的な余積（関数適用やリスト化） / 引数なしの単独クロージャ
  / head:expr_5 tail:(apply_coproduct expr_6)* {
      return tail.length > 0 ? { type: "ApplyList", elements: [head, ...tail.map(t => t[1])] } : head;
  }
  /expr_5

// Level 5: lambda (中置 / 右結合)
expr_5
  = expr_6 _ "?" _ expr_5
  / expr_6

// Level 6: product (中置 / 右結合)
expr_6
  = expr_7 _ "," _ expr_6
  / expr_7

// Level 7: 余積 (push, concat, construct)
expr_7
  = expr_8 (list_coproduct expr_8)*

// Level 8: 余積 (compose)
expr_8
  = expr_9 (compose_coproduct expr_9)*

// Level 9: range (中置 / 左結合)
expr_9
  = expr_10 (("~+" / "~-" / "~*" / "~/" / "~^") expr_10)? " " "~" " " expr_10

// Level 10: continuous (前置 / 空白不可)
expr_10
  = "~" expr_11
  / expr_11

// Level 11: xor, or (中置 / 左結合)
expr_11
  = expr_12 (" " (";" / "|") " " expr_12)*

// Level 12: and (中置 / 左結合)
expr_12
  = expr_13 (" " "&" " " expr_13)*

// Level 13: not (前置 / 空白不可)
expr_13
  = "!" expr_14
  / expr_14

// Level 14: comparison (中置 / 左結合)
expr_14
  = expr_15 (("<=" / "==" / ">=" / "!=" / "<" / "=" / ">") expr_15)*

// Level 15: add, sub (中置 / 左結合)
expr_15
  = expr_16 (("+" / " " "-" " ") expr_16)*

// Level 16: mul, div, mod (中置 / 左結合)
expr_16
  = expr_17 (("*" / "/" / "%") expr_17)*

// Level 17: pow (中置 / 右結合)
expr_17
  = expr_18 "^" expr_17
  / expr_18

// Level 18: factorial (後置 / 空白不可)
expr_18
  = expr_19 "!"*

// Level 19: abs (囲み / 内側の境界に空白不可)
expr_19
  = "|" expr "|"
  / expr_20

// Level 20: expand (後置 / 空白不可)
expr_20
  = expr_21 "~"*

// Level 21: address (前置 / 空白不可)
expr_21
  = "$" expr_22
  / expr_22

// Level 22: get (中置 / ' は左結合, @ は右結合)
expr_22
  = expr_23 " " "@" " " expr_22
  / expr_23 ("'" expr_23)*

// Level 23: input (前置 / 空白不可)
expr_23
  = "@" expr_24
  / expr_24

// Level 24: bit shift (中置 / 左結合)
expr_24
  = expr_25 (("<<" / ">>") expr_25)*

// Level 25: bit or (中置 / 左結合)
expr_25
  = expr_26 (" " "||" " " expr_26)*

// Level 26: bit xor (中置 / 左結合)
expr_26
  = expr_27 (" " ";;" " " expr_27)*

// Level 27: bit and (中置 / 左結合)
expr_27
  = expr_28 (" " "&&" " " expr_28)*

// Level 28: bit not (前置 / 空白不可)
expr_28
  = "!!" expr_29
  / expr_29

// Level 29: import (後置 / 空白不可)
expr_29
  = expr_30 "@"*

// Level 30: block (囲み, indent, point-free)
// ※ 通常のブロック評価より先に point_free をインターセプトし、型を確定させる
expr_30
  = pf_map_block
  / pf_fold_block
  / indent_block   // 括弧類より先に、不可視のインデントブロックを評価する
  / "(" expr ")"
  / "{" expr "}"
  / "[" expr "]"
  / "\t" expr_31
  / expr_31

// Level 31: escape (前置 / 空白不可)
expr_31
  = "\\" atom
  / atom

// ----------------------------------------------------
// Indent/Dedent Block (オフサイドルールの厳密な捕捉)
// ----------------------------------------------------
// pre-lexer (prepare_lexer.js) が物理的なインデントの増減を検知し、
// コードストリームに埋め込んだ不可視の境界トークンを捕捉します。
// これにより、パース時に一切の状態（State）を必要とせず、
// 完全に純粋で決定論的な木構造の構築（Syntax = Type）が保証されます。
indent_block
  = INDENT body:expressions DEDENT {
      return { type: "Block", kind: "indent", exprs: body };
  }

// --- Lexerが発行する不可視の境界トークン ---
// ※ 実際の制御文字は実装に依存します（ここでは例として STX / ETX を使用）
INDENT
  = &{
      i:[ \t ]+ &{
        i.length > ctx.indent.length
      }
      {
        ctx.indentStack.push(ctx.indent)
        ctx.indent = i.join("")
      }
  }

DEDENT
  = {
    ctx.indent = ctx.indentStack.pop()
  }

// ----------------------------------------------------
// Point-Free Notation (部分適用 / 関数化の厳密な分離)
// ※ Map（次元保持）と Fold（スカラー収束）を構文上で完全に区別する
// ----------------------------------------------------

pf_map_block
  = "(" _ m:pf_map_body _ ")" { return { type: "PointFree", kind: "map", ...m }; }
  / "{" _ m:pf_map_body _ "}" { return { type: "PointFree", kind: "map", ...m }; }
  / "[" _ m:pf_map_body _ "]" { return { type: "PointFree", kind: "map", ...m }; }

pf_fold_block
  = "(" _ f:pf_fold_body _ ")" { return { type: "PointFree", kind: "fold", ...f }; }
  / "{" _ f:pf_fold_body _ "}" { return { type: "PointFree", kind: "fold", ...f }; }
  / "[" _ f:pf_fold_body _ "]" { return { type: "PointFree", kind: "fold", ...f }; }

// Map: 左辺値または右辺値が固定され、必ずカンマ(直積)で終わる
pf_map_body
  = op:pf_infix _ right:atom _ "," { return { dir: "right", op, val: right }; }
  / left:atom _ op:pf_infix _ "," { return { dir: "left", op, val: left }; }

// Fold: 演算子単体、またはアンダースコア(無値)を伴う単項演算子
pf_fold_body
  = op:pf_prefix "_" { return { dir: "prefix", op }; }
  / "_" op:pf_postfix { return { dir: "postfix", op }; }
  / op:pf_infix { return { dir: "infix", op }; }

pf_prefix
  = "###" / "##" / "#" / "~" / "!!" / "!" / "$" / "@" / "\\"

pf_postfix
  = "!" / "~" / "@"

pf_infix
  = "~+" / "~-" / "~*" / "~/" / "~^"
  / "<<" / ">>" / "||" / ";;" / "&&"
  / "<=" / "==" / ">=" / "!="
  / ":" / "#" / "?" / "," / "~" / ";" / "|" / "&"
  / "<" / "=" / ">" / "+" / "-" / "*" / "/" / "%" / "^" / "@" / "'"


// ----------------------------------------------------
// Tokens, Atoms & Coproducts
// ----------------------------------------------------
atom
  = string_literal
  / float_literal
  / address_literal
  / register_literal
  / unicode_literal
  / integer_literal
  / identifier

// 1. 文字列型
// ※前のステップで定義した「行頭のコメント（column === 1）」と完璧に住み分けられます。
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

// 余積の実体はすべて空白（区切り）だが、構文の階層として分離
apply_coproduct    = " "
list_coproduct     = " "
compose_coproduct  = " "
