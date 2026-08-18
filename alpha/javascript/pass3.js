/**
 * Pass3（型伝播、type_system.md §2〜§3.2の実装）
 *
 * Pass2（coproduct_resolver.md）が構築した二分木ASTを歩いて、各ノードの
 * Layer 2型（Atom内部型: Address/Float/String/Vector/List/Struct/Implicit/Iterator/Unit）を推論する。
 *
 * 左辺優先ルール（§3.2）:
 *   typeof(L op R) = typeof(L)
 * 例外（§3.2 NOTE）:
 *   String型の左辺に算術演算子（+ - * / % ^）が来ると、リストに対して算術は効かないため
 *   型エラーとして __（Unit）に収束する（例: `123` + 0 = __）。
 *
 * 【既知の制限】
 * - 識別子のatom_typeは、Pass1a（pass1.js の buildEnvScope）が
 *   「`<id> : <リテラル1個>` という最も単純な定義行」から静的に読み取れた場合のみ解決できる。
 *   ラムダの仮引数（本体の使用箇所から逆算する必要がある、type_system.md §7.1 の x/y の例、
 *   Pass 1b の `@ref` ジェネリック具体化）は未対応。
 * - 比較演算子（< <= = >= > !=）等、算術演算子以外は一律で左辺優先ルールにフォールバック
 *   しており、§4の個別の型シグネチャとの細かい整合は未検証。
 * - 構造体判定は「複数行、全行がdefine(key:val)」という形（list_model.md §5.3、
 *   pattern_guide.mdの`dict`例が示す改行区切りの形）のみを見る。カンマと`:`を1行に
 *   混在させる形（例: `foo:1, bar:2`、ドキュメントに例が無い）は非対応・未定義動作。
 * - `Implicit(T)`（場所）と `Iterator(T)`（ストリーム）は type_system.md §2 に型として
 *   定義されたが、ここではまだ推論しない。仮引数の形による割り当て
 *   （`f : [x ~xs]` → `Implicit(List(T))` / `f : x ~xs` → `Iterator(T)`、list_model.md §2.4）も、
 *   `'`・前置`~`・前置`#` が `Implicit` を返すことも未実装。
 *   これが入ると原理4の静的拒否ルール「`[...]`内でのstream型識別子の使用」が
 *   初めて強制可能になる（stream型が型として存在するため）。
 */

import { envLookup } from './pass1.js';

const ARITHMETIC_OPS = new Set(["add", "sub", "mul", "div", "mod", "pow"]);
// coproduct_resolver.md §3-4: Atom-Atom間の余積（スペース）が縮約される演算。
// これらの結果はList（1次元配列）そのものであり、左辺の個別の型を素通しすべきではない。
const LIST_BUILDING_OPS = new Set(["construct", "concat", "push", "unshift"]);

function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}

function isIdentifierNode(n) {
  return !!n && n.type === "atom" && n.kind === "identifier";
}

// 【2026-08-09】以前ここには productShape() があり、カンマ結合の要素列を
// 「全要素が define(key:val) なら Dict、そうでなければ Struct」と振り分けていた。
// type_system.md §2 で `Dict` を `Struct` へ統合したため、この振り分けは不要になった
// ——名前付きスロット（`[key : val]`）と連番スロット（`1, 2, 3`）は同じ構造であり、
// 名前がコンパイル時にオフセットへ解決されて Pass 4 に残らない点も同じだからである。

// type_system.md §3.2「数値の昇格格子」と算術族の型変換テーブルの実装。
// 左辺は「どの規則を使うか」を選ぶだけで、数値同士の結果型は昇格格子が決める
// （＝左辺の型がそのまま結果型になるとは限らない）。
const NUMERIC_TYPES = new Set(["Address", "Float", "Vector"]);
// 「場所」と「ストリーム」。値ではないので算術・比較の対象にならない（§4 は Scalar を要求）。
// `Implicit` は前置 `~`（持ち上げ）・`'`・前置 `#` が生み、`Iterator` は範囲族が生む。
const NON_SCALAR_PLACES = new Set(["Implicit", "Iterator"]);
// List左辺で固有の意味を持つのは `*`(repeat)・`^`(lift)・`/`(split) だけ。
// `+`・`-`・`%` はList/Stringと同様に型エラーで __ へ収束する。
const LIST_ARITHMETIC_OPS = new Set(["mul", "pow", "div"]);

// 範囲族（list_model.md §2.3）。`~` は単純形式 `[start ~ end]` と、3項形式
// `[start ~op step ~ end]` の外側を担う。`~+`〜`~^` は step を伴う派生演算子。
const RANGE_STEP_OPS = new Set([
  "range_arithmetic",
  "range_arithmetic_rev",
  "range_geometric",
  "range_geometric_rev",
  "range_power",
]);

// type_system.md §4: `~` 中置は `(Scalar -> Scalar) -> Iterator -> List`。
// 端点になれるのは「点」——数値と文字である。文字は Layer 2 では String だが、
// 範囲の端点としては符号位置で数えるため点として扱える（`\a ~ \e`）。
// List / Struct は点ではないので端点にできない。原理4により静的に弾く。
const RANGE_ENDPOINT_TYPES = new Set(["Address", "Float", "Vector", "String"]);

// 範囲式の端点になっているノードの型を、単純形式・3項形式のどちらでも取り出す。
// 3項形式は `range(range_arithmetic(start, step), end)` という入れ子であり、
// 実際の端点は内側の左辺（start）と外側の右辺（end）である。
function rangeEndpoints(node, env) {
  if (RANGE_STEP_OPS.has(node.name)) return [node.left, node.right];
  const inner = node.left;
  if (inner && inner.type === "operation" && RANGE_STEP_OPS.has(inner.name)) {
    return [inner.left, node.right];
  }
  return [node.left, node.right];
}

// 端点として不正な型を見つけたら、その型を返す（見つからなければ null）。
// 「不正」は例外にしない——点でないものを端点に置くことは「射が無い」ということであり、
// 零対象を経由する射（零射）が常に存在する以上、結果は `__` である。なぜ潰れたかは
// Pass 3b（collectUnitReason）が診断として記録する。
function badRangeEndpoint(node, env) {
  const [startNode, endNode] = rangeEndpoints(node, env);
  for (const [label, operand] of [["左辺", startNode], ["右辺", endNode]]) {
    const t = operand ? inferAtomType(operand, env) : null;
    // 未解決（null）は静的に判定できないので何も言わない。
    // Unit は零射として振る舞うので、そもそも型の不一致ではない。
    if (t && t !== "Unit" && !RANGE_ENDPOINT_TYPES.has(t)) return { label, type: t };
  }
  return null;
}

function rangeResultType(node, env) {
  if (badRangeEndpoint(node, env)) return "Unit";
  const [startNode, endNode] = rangeEndpoints(node, env);
  const startType = startNode ? inferAtomType(startNode, env) : null;
  const endType = endNode ? inferAtomType(endNode, env) : null;
  // 終端を持たない2項形式（`1 ~+ 2`）は Pull 型のストリームそのもの。
  if (RANGE_STEP_OPS.has(node.name)) return "Iterator";
  // 文字の範囲は文字の並び＝String（String ≅ List(0u)）。それ以外は List。
  if (startType === "String" && endType === "String") return "String";
  return "List";
}

// type_system.md §3.2「要素型の join」: 余積で構築される List の要素型を求める。
// join は数値の昇格格子そのもの。戻り値の意味を3値で区別する：
//   型名   … join が求まった
//   null   … どちらかが未解決（静的に判定できないのでエラーにしない、原理4）
//   NO_JOIN … join が存在しない（コンパイルエラー）
const NO_JOIN = Symbol("no-join");

function joinElementTypes(a, b) {
  if (a === null || a === undefined || b === null || b === undefined) return null;
  if (a === b) return a;
  // `Scalar` は「String を含まない Atom」という**族**であり（§4 の記法定義）、
  // Address / Float / Vector はその要素である。族と要素の上限は族——どの要素かは
  // まだ分かっていないので、分かっている以上のことを名乗らない。仮引数の型が
  // 呼び出しサイトで具体化されるまでの暫定形がここを通る（§7.1）。
  // `Atom` は「どの Atom か分かっていない」という下限であり、join は判定できない。
  // NO_JOIN（コンパイルエラー）ではなく null を返す——分からないことを「不正」と
  // 断じないのが原理4 の線引きである。
  if (a === "Atom" || b === "Atom") return null;
  if (a === "Scalar" || b === "Scalar") {
    const other = a === "Scalar" ? b : a;
    return NUMERIC_TYPES.has(other) || other === "Scalar" ? "Scalar" : NO_JOIN;
  }
  if (NUMERIC_TYPES.has(a) && NUMERIC_TYPES.has(b)) {
    if (a === "Vector" || b === "Vector") return "Vector";
    if (a === "Float" || b === "Float") return "Float";
    return "Address";
  }
  return NO_JOIN;
}

// ノードが表す「値の要素型」を返す。List なら要素型、それ以外はその値自身の型
// （スカラーは1要素リストと同型なので、自分自身が要素になる）。
function elementTypeOf(node, env) {
  const type = inferAtomType(node, env);
  if (type === "List") return node.elementType ?? null;
  return type;
}

function arithmeticResultType(node, leftType, env) {
  const rightType = inferAtomType(node.right, env);
  // §3.2: Stringは左右どちらに来ても算術の型エラー（両方向とも __ 消去）
  if (leftType === "String" || rightType === "String") return "Unit";
  if (leftType === "List" || leftType === "Struct") {
    return LIST_ARITHMETIC_OPS.has(node.name) ? leftType : "Unit";
  }
  // 場所（`Implicit`）とストリーム（`Iterator`）は Scalar ではないので算術の対象にならない
  // （§4: `(L(Scalar) -> R(Scalar)) -> L`）。射が無い＝零射なので `__` へ収束する。
  // 持ち上げた結果に算術を書いてしまう形（`~xs + 1`）がここに来る——要素型を決める演算は
  // 持ち上げの**内側**に置くこと（`~(xs + 1)`）。
  if (NON_SCALAR_PLACES.has(leftType) || NON_SCALAR_PLACES.has(rightType)) return "Unit";
  // 数値の昇格格子: 精度の高い側へ昇格する（降格しない）
  if (NUMERIC_TYPES.has(leftType) && NUMERIC_TYPES.has(rightType)) {
    if (leftType === "Vector" || rightType === "Vector") return "Vector";
    if (leftType === "Float" || rightType === "Float") return "Float";
    return "Address";
  }
  // どちらかの型が未解決（識別子のatom_typeが読めない等）なら、従来通り左辺を通す
  return leftType;
}

function literalAtomTypeFromKind(node) {
  switch (node.kind) {
    case "number": return node.value.includes(".") ? "Float" : "Address";
    case "string": return "String";
    case "char": return "String"; // 文字リテラルはStringと同型（type_system.md: Stringは文字のリスト）
    case "address": return "Address";
    case "register": return "Address";
    // `0u` は Char（String の要素型）。`String ≅ List(0u)`（§2）である以上、
    // `\a` と同じく String である。U+0000 は Char の値域から除外された niche なので Unit。
    case "unicode": return parseInt(node.value.slice(2), 16) === 0 ? "Unit" : "String";
    case "unit": return "Unit";
    default: return null; // identifier/hole/unknown はここでは扱わない
  }
}

// node（Pass2が返す二分木ASTのノード）のLayer 2 Atom内部型を推論する。
// env は識別子のatom_type解決のため（pass1.jsのBinding.atomTypeを参照）。
//
// 結果はノード自身の `atomType` フィールドへ載せる（メモ化＋注釈を兼ねる）。
// type_system.md §5 の Pass 3 は出力を「完全型付きAST」と定めており、原理2の
// 「型は実行時ゼロコストの帳簿」に照らせば、**ASTそのものが帳簿の担体**である
// （汚染ではない）。Pass 4 も同じノードから型を読んで命令を選ぶことになる。
function inferAtomType(node, env) {
  if (!node || typeof node !== "object") return null;
  if (node.atomType !== undefined) return node.atomType;
  const inferred = computeAtomType(node, env);
  node.atomType = inferred;
  return inferred;
}

function computeAtomType(node, env) {
  if (node.type === "atom") {
    if (node.kind === "identifier") {
      if (!env) return null;
      const binding = envLookup(env, node.value);
      return binding ? binding.atomType ?? null : null;
    }
    return literalAtomTypeFromKind(node);
  }

  if (node.type === "block") {
    // `|x|`（abs）は「数値の絶対値」と「リストの要素数」を兼ねる多重定義である。
    // オペランドがUnitのとき、`__ = []`（unit.md）の同一視によって「空リスト＝要素数0」
    // とも「値の不在」とも読めてしまい、**値だけでは決まらない**。これは `5 / 2` と
    // `5.0 / 2` を型で分けたのと同じ構図なので、型で決める（原理2：型はゼロコストの帳簿）。
    // ここではオペランドの型を記録するだけで、Unitの読み替えは評価器が行う。
    // 結果型は絶対値・要素数のいずれも非負の機械語1語に収まるため Address とする。
    if (node.kind === "abs") {
      node.operandType =
        Array.isArray(node.lines) && node.lines.length > 0
          ? inferAtomType(node.lines[node.lines.length - 1], node.scope || env)
          : "List";
      return "Address";
    }
    if (!Array.isArray(node.lines) || node.lines.length === 0) return "List";
    // 全行が define(key:val) かつ左辺が識別子 → Struct（list_model.md §5.3、
    // pattern_guide.mdの改行区切り構造体リテラルの形）。単一エントリの `[foo : 1]` も含む。
    // 左辺が識別子でない define 行（match_caseの `cond : result`）は構造体ではないので
    // 除外する——interpreter.jsの構造体判定と同じ基準に揃えてある。
    // それ以外（関数本体等）は「ブロックの値＝最後の文の値」にフォールバックする。
    // 関数本体（pass2 が isFunctionBody を立てたインデントブロック）は構造体にならない。
    // そこでの `識別子 : 値` は match_case であり、構造体を返すにはカッコで囲む。
    // フィールドは `a : x`（明示）と `x`（省略記法）の2通り。省略記法は2行以上のときだけ
    // 有効で、`[x]` が1要素リスト ≅ スカラーであることを壊さない（interpreter.jsと同基準）。
    //
    // 名前付きスロットには `slotKind: "named"` を立てる。物理オフセットは名前でソートした
    // 正規順で割り当てられるが（stack_abi.md §7.1）、**その順序は言語から観測できない**
    // ——`==` は Hom集合の一致で宣言順を問わず、位置アクセスも持たない。順序が意味を持つ
    // のは連番スロット（`slotKind: "positional"`）の側であり、両者は互いの順序を漏らさない。
    // 「名前が関心事か、順序が関心事か」がこの2つを分ける唯一の軸である（§2）。
    if (!node.isFunctionBody) {
      const explicit = (l) => isDefineNode(l) && isIdentifierNode(l.left);
      if (node.lines.every(explicit)) {
        node.slotKind = "named";
        return "Struct";
      }
      if (node.lines.length >= 2 && node.lines.every((l) => explicit(l) || isIdentifierNode(l))) {
        node.slotKind = "named";
        return "Struct";
      }
    }
    // 関数本体（match_case の並び）の型は、各 arm の型の**直和**である（§7.3）。
    // 最終行だけを見ると、途中の arm が返しうる型が消えてしまう。
    if (node.isFunctionBody) {
      const armTypes = node.lines.map((line) =>
        // `cond : result` の arm が返すのは result 側。フォールバック行は行そのもの。
        isDefineNode(line)
          ? inferAtomType(line.right, node.scope || env)
          : inferAtomType(line, node.scope || env)
      );
      return joinArmTypes(armTypes);
    }
    const last = node.lines[node.lines.length - 1];
    // pass2 が残した子スコープで最終行を解決する。外側のenvで先に評価すると、
    // ブロック内で定義された識別子が解決できないまま**メモ化されてしまう**
    // （後から annotateTypes が正しいスコープで歩いても、もう上書きされない）。
    const lastType = inferAtomType(last, node.scope || env);
    // `[1 2 3]` のようにブロックが List を包んでいる場合、要素型もブロックへ引き継ぐ
    // （そうしないと `[1 2] [3 4]` のように List 同士を余積で繋いだとき、外側から
    // 中身の要素型が見えなくなる）。
    if (lastType === "List") node.elementType = last.elementType ?? null;
    return lastType;
  }

  if (node.type === "operation") {
    if (node.name === "product") {
      // カンマ（直積）は常に Struct（type_system.md §2）。名前付きスロットも
      // 連番スロットも同じ「固定オフセットで並ぶ連続ブロック」である。
      // ただし**関心事が違う**ので slotKind で区別する——カンマは名前を持たないため
      // 順序が意味そのものであり、宣言順がそのまま物理配置になる。名前ソートの
      // 正規順（stack_abi.md §7.1）は名前付きスロットにのみ適用される規則である。
      node.slotKind = "positional";
      return "Struct";
    }
    if (node.name === "define") {
      // 定義の値は「束縛される値そのもの」（interpreter.jsのdefineも右辺の値を返す）。
      // 以前は無条件に "Struct"（旧 Dict）を返していたが、それは `[foo : 1]` のような
      // 構造体リテラルの単一エントリを想定した規則であり、トップレベルの定義行
      // （`f : x ? x + 1`）まで誤判定していた。リテラルの判定は上のblock分岐が担う。
      return inferAtomType(node.right, env);
    }
    if (node.name === "lambda") {
      // Layer 2 は「Atom の内部分類」（§2）であり、Lambda は Layer 1 のカテゴリ。
      // Atom内部型は持たないので null を返す（未解決ではなく「該当なし」）。
      return null;
    }
    if (LIST_BUILDING_OPS.has(node.name)) {
      // 余積族（§3.2の族別テーブル）: 左辺がStringならテキスト連結でString、
      // それ以外はList構築。以前は無条件に"List"を返していたが、interpreter.jsの
      // concatは左辺がstringならテキスト連結する（`ab` 1 → "ab1"）ため食い違っていた。
      const leftType = inferAtomType(node.left, env);
      const rightType = inferAtomType(node.right, env);
      // §3.2の余積族テーブル: どちらかがStringならテキスト連結でString。
      // Stringは余積の**吸収元**として振る舞う——あらゆる値がテキスト表現を持つため、
      // String との join は常に存在する（「レンダリングする」という全域の操作がある）。
      // 左辺だけを見ると `` `ab` 1 `` → "ab1" なのに `1 `ab`` はエラー、という
      // 引数の順序で挙動が変わる非対称が生じてしまう。
      if (leftType === "String" || rightType === "String") return "String";
      // §3.2の余積族テーブル / §6.1: 余積の単位元。片側がUnitなら他方を素通しする
      // （`__ x = x`、`x __ = x`）。Unitは要素型の join には参加しない——
      // 「無い」ものと型が合わないという判定は成立しないため。
      if (leftType === "Unit") {
        node.elementType = node.right.elementType ?? null;
        return rightType;
      }
      if (rightType === "Unit") {
        node.elementType = node.left.elementType ?? null;
        return leftType;
      }
      // §2「Listは同一型」: 要素型のjoinを取る。join が存在しない組み合わせ
      // （`[1 \`abc\`]` 等）は原理4に従いコンパイルエラーにする——混在させたい場合は
      // カンマで Struct（tuple）だと明示する必要がある。
      const joined = joinElementTypes(elementTypeOf(node.left, env), elementTypeOf(node.right, env));
      if (joined === NO_JOIN) {
        throw new TypeError(
          `type_system.md §2違反: List の要素型が揃っていません（${elementTypeOf(node.left, env)} と ${elementTypeOf(node.right, env)}）。` +
            `混在させたい場合はカンマ区切りの Struct（tuple）にしてください`
        );
      }
      node.elementType = joined;
      return "List";
    }
    // apply の結果型は**呼び先の返値型**である（§7.1・§8）。Lambda 自身は Layer 1 の
    // カテゴリであり Layer 2 型を持たない（§2）が、射の**適用結果**は場所を持つ値なので
    // 型を持つ。したがって返値型は Layer 2 の型表へ足すのではなく、識別子テーブル側
    // （binding.returns）に置く。
    if (node.name === "apply") {
      const callee = applyCalleeBinding(node, env);
      return callee ? callee.returns ?? null : null;
    }
    if (node.position === "infix" && node.left) {
      // 論理・圏論族の`&`（§4: `(L -> R) -> (R | __)`）だけは右辺の型を返す。
      // 左辺は短絡（Unitなら全体がUnit）を決めるだけで、値として返るのは右辺。
      if (node.name === "and") return inferAtomType(node.right, env);
      // 範囲族は左辺優先ルール（§3.2）の対象外——結果は端点の型ではなく列である。
      // 以前は `return leftType` へ落ちており、`1 ~ 5` の型が値（[1,2,3,4,5]）と
      // 食い違って Address になっていた。
      if (node.name === "range" || RANGE_STEP_OPS.has(node.name)) return rangeResultType(node, env);
      const leftType = inferAtomType(node.left, env);
      if (ARITHMETIC_OPS.has(node.name)) return arithmeticResultType(node, leftType, env);
      return leftType; // 左辺が規則を選ぶ（§3.2）。比較・構造比較族は左辺の型が結果型
    }
    if (node.operand) {
      // 前置 `~`（`continuous`、§4）は**持ち上げ**である。`$`/`@` が単体値に対する
      // 持ち上げ／持ち下げであるのと同じ段で、前置 `~`／後置 `~` が列に対するそれを担う。
      //
      //   単体値   $ が持ち上げ（値 → Address）      @ が持ち下げ
      //   列       前置 ~ が持ち上げ（→ Implicit）   後置 ~ が持ち下げ（展開）
      //
      // 行き先は `Implicit(T)`——「暗黙のアドレス（場所）」であり、`$` が返す
      // 「値としての Address」とは別物である（§2 の Layer 2 表）。§4 は
      // `List -> Implicit(List)` しか定めていないが、スカラーを持ち上げた場合も
      // 同じ段の操作なので `Implicit(T)` になる。要素型は elementType に載せる
      // （`List(T)` と同じ機構）。
      // 前置 `$`（アドレス取得）は §4 の通り常に `Atom(Address)` を返す。凍結対象が
      // 関数であろうとデータへのパスであろうと、`$` 自身は「その式が指す場所のアドレスを
      // 取る」だけで場合分けを必要としない（§2 の非対称性）。オペランドの型を素通しすると、
      // 関数を指したとき（Lambda は Layer 2 型を持たない）に `_` になってしまい、
      // 「アドレスという値を持っている」ことすら型に出なかった。
      if (node.position === "prefix" && node.name === "address") return "Address";
      if (node.position === "prefix" && node.name === "continuous") {
        node.elementType = inferAtomType(node.operand, env);
        return "Implicit";
      }
      // それ以外の前置/後置演算子は§4に個別の型シグネチャがあるが、今回は簡略化して
      // オペランドの型をそのまま通す（要精査、既知の制限）。
      return inferAtomType(node.operand, env);
    }
    return null;
  }

  return null;
}

// ---- 仮引数のatomType自動導出（type_system.md §7.1） ----
//
// `f : x y ? x + y` の x/y のように、仮引数自身は `<id> : expr` という定義行を持たないため
// pass1.js の buildEnvScope（リテラルからの静的読み取り）では atomType を解決できない。
// §7.1 はこれを「本体の演算子使用箇所から逆算する」——`x + y` の `x` は `+` の左辺、
// `y` は右辺なので、どちらも `+` のシグネチャ（§4: `(L(Scalar) -> R(Scalar)) -> L`）が
// 要求する `Scalar` だと仮定できる、としている。
//
// 【制限】算術演算子（+ - * / % ^）・比較演算子（< <= = >= > !=、§4）による使用箇所のみを
// 見る。HM流の単一化はせず、最初に見つかった制約を採用する（Pass 1a が前提とする
// 「線形スキャンで完結する」という設計方針に合わせた、早い者勝ちの単純な走査）。
// `'`（get_prop）等、他の演算子からの逆算は未対応（要拡張）。
//
// 比較演算子は symbol（node.op）で判定する。`!=`（§4の比較演算子、precedence 12、
// name="not_equal"）と`!==`（構造比較、precedence 8、name="xnot_equal"、8/6に
// operator_table.jsを改名して名前衝突は解消済み）は記号で区別する。`==`/`===`/`!==`は
// Scalarに限定されない構造比較（type_system.md §4 NOTE: 「リストや構造体の比較には
// ==を使用」）なので対象外。

const SCALAR_ARITHMETIC_OPS = ARITHMETIC_OPS;
const SCALAR_COMPARISON_OP_SYMBOLS = new Set(["<", "<=", "=", ">=", ">", "!="]);

// 演算の相手が「型の制約として意味を持つリテラル」なら、その型を返す。
// リテラルでなければ null（演算子が要求する族までしか言えない）。
//
// `Unit` は除く。`__` は零射であって型ではないので、`a + __` は `a` について何も語らない
// ——むしろ結果が `__` に収束することを意味する（§3.3 の吸収則）。
function constraintFromLiteral(node) {
  if (!node || node.type !== "atom") return null;
  const t = literalAtomTypeFromKind(node);
  return t === "Unit" ? null : t;
}

function inferParamTypesFromUsage(bodyNode, paramNames) {
  const inferred = new Map();

  function visit(node) {
    if (!node || typeof node !== "object") return;

    const isScalarOp =
      node.type === "operation" &&
      node.position === "infix" &&
      (SCALAR_ARITHMETIC_OPS.has(node.name) || SCALAR_COMPARISON_OP_SYMBOLS.has(node.op));

    if (isScalarOp) {
      for (const [side, other] of [
        [node.left, node.right],
        [node.right, node.left],
      ]) {
        if (
          side &&
          side.type === "atom" &&
          side.kind === "identifier" &&
          paramNames.has(side.value) &&
          !inferred.has(side.value)
        ) {
          // 相手がリテラルなら**その型がこの仮引数の型を決める**。相手が分からなければ
          // 演算子が要求する族（`Scalar`）までしか言えない。
          //
          // これは「恒等演算を型注釈として使う」書き方を成立させるための規則である。
          // Sign には型注釈の構文が無いので（§1「型はコードの影」）、初期化時に型を
          // 決めたいときは値を変えない演算を書く。
          //
          //   x : @p + 0      Address として読む
          //   x : @p + 0.0    Float として読む
          //   x : @p          型を決める情報が無い
          //
          // `+ 0` は値を変えないので実行時コストは無い（コンパイル時に消える）が、
          // 型は固定される。注釈構文を足さずに「キャスト情報がある場合と無い場合」を
          // 書き分けられる。比較でも同じで、`t = \`===\`` の `t` は String になる
          // ——比較は同種同士でしか成立しないため、相手の型がそのまま制約になる。
          inferred.set(side.value, constraintFromLiteral(other) || "Scalar");
        }
      }
    }

    if (node.left) visit(node.left);
    if (node.right) visit(node.right);
    if (node.operand) visit(node.operand);
    if (node.type === "block" && Array.isArray(node.lines)) node.lines.forEach(visit);
  }

  visit(bodyNode);
  return inferred;
}

// paramNode（resolveLambdaLineが返すlambdaノードのleft: 単一identifierノード or params[]ノード）
// から仮引数名の一覧を取り出す。
function paramNamesOf(paramNode) {
  if (!paramNode) return [];
  if (paramNode.type === "atom" && paramNode.kind === "identifier") return [paramNode.value];
  if (paramNode.type === "params") return paramNode.entries.map((e) => e.name);
  return [];
}

// lambdaNode（{type:"operation", name:"lambda", left: params, right: body}）から、
// 本体の使用箇所に基づく仮引数のatomType推定結果を Map<識別子, atomType> で返す。
function inferLambdaParamTypes(lambdaNode, env) {
  const names = new Set(paramNamesOf(lambdaNode.left));
  const inferred = inferParamTypesFromUsage(lambdaNode.right, names);
  // **デフォルト式があれば、その型がその仮引数の型である。**
  //
  // デフォルトは「引数が省略されたときに実際にそこへ入る値」なので、型の根拠として
  // 本体の使用箇所より強い。使用箇所は「その演算が要求する型」しか語らないが（`y + 0.0`
  // は y が Address でも昇格するので Float とは限らない）、デフォルトは中身そのものを
  // 語る。したがって使用箇所からの逆算より優先する。
  const paramNode = lambdaNode.left;
  if (paramNode && paramNode.type === "params") {
    const scope = lambdaNode.scope || env;
    for (const e of paramNode.entries || []) {
      if (!e.name || !e.default) continue;
      const t = inferAtomType(e.default, scope);
      if (t) inferred.set(e.name, t);
    }
  }
  // **裸の仮引数は、証拠が何も無くても `Atom` まで決まる。**
  //
  // 裸の仮引数（rest でもブラケット分割代入でもない）は1個の値を受ける。集合を受け取る
  // なら `[x ~xs]`（参照渡し）か `~xs`（stream）で宣言するので、宣言の形が既に「点で
  // ある」ことを語っている（原理3 の表）。さらにデフォルトが無ければ `__` を渡せない
  // ——完全性公理により呼び出しごと潰れるので、本体に入った時点で非Unitが保証される。
  //
  // `Atom` は §4 の記法定義で「String を**含む**スカラー」＝ `Scalar | String` である。
  // 多相に見えて下限が決まっている。具体的な型は呼び出しサイトで確定する（§5 Pass 1b）。
  if (paramNode && paramNode.type === "params") {
    for (const e of paramNode.entries || []) {
      if (!e.name || e.rest || e.pattern) continue;
      if (!inferred.has(e.name)) inferred.set(e.name, "Atom");
    }
  } else if (isIdentifierNode(paramNode) && !inferred.has(paramNode.value)) {
    inferred.set(paramNode.value, "Atom");
  }
  return inferred;
}

// AST全体を歩いて、全ノードに `atomType` を載せる（type_system.md §5 Pass 3 の
// 出力＝「完全型付きAST」）。inferAtomType自身がメモ化するため、各ノードの型は
// 一度しか計算されない。
//
// 【既知の制限】ブロックの中身も呼び出し元と同じenvで解決する。pass2.jsのresolveBlockは
// 縮約中に子スコープを作るが、それをノードへ残していないため、ここから辿れない
// （inferAtomTypeが元々持っていた制限と同じ。ブロック内で新たに定義された識別子の
// atomTypeは解決できず null になる）。
function annotateTypes(node, env, diagnostics) {
  if (!node || typeof node !== "object") return node;
  inferAtomType(node, env);
  if (diagnostics) collectUnitReason(node, env, diagnostics);
  // ブロック・ラムダは pass2 が残した子スコープで中身を歩く（無ければ現在のenv）。
  // これが無いと仮引数やブロック内の定義が「未定義識別子」になってしまう。
  const inner = node.scope || env;
  // 仮引数の atomType を、本体を歩く**前に**その子スコープへ書き込む（§7.1）。
  //
  // 仮引数には型注釈スロットが無いが、本体でどの演算子に渡されているかから型が逆算できる
  // ——§7.1 の表がそのまま「`x + y` の `x` は `+` のシグネチャが要求する `Scalar`」と
  // 述べている。inferParamTypesFromUsage はその実装として既に存在しテストもあったが、
  // 自身のテストからしか呼ばれておらずパイプラインに載っていなかった（pass3 自身が
  // compile.js 以前にそうだったのと同じ形）。ここで繋ぐ。
  //
  // 本体より先に書き込む必要がある。inferAtomType は結果をノードへメモ化するため、
  // 型の付いていない状態で本体を先に歩くと null が焼き付いて後から直らない。
  //
  // ここで入る `Scalar` は「String を含まない Atom」という**族**であり（§4 の記法定義）、
  // Layer 2 の具体型（Address / Float / Vector）ではない。呼び出しサイトで具体化される
  // までの暫定形であり、§7.1 が `Lambda<returns: Scalar>` と書いているのと同じ粒度である。
  if (node.name === "lambda" && node.scope) {
    for (const [name, atomType] of inferLambdaParamTypes(node, env)) {
      const binding = envLookup(node.scope, name);
      if (binding && !binding.atomType) binding.atomType = atomType;
    }
  }
  if (node.left) annotateTypes(node.left, node.name === "lambda" ? env : inner, diagnostics);
  if (node.middle) annotateTypes(node.middle, inner, diagnostics); // chain_compare（§4の三項連鎖比較）
  if (node.right) annotateTypes(node.right, inner, diagnostics);
  if (node.operand) annotateTypes(node.operand, inner, diagnostics);
  if (node.type === "block" && Array.isArray(node.lines)) {
    for (const line of node.lines) annotateTypes(line, inner, diagnostics);
  }
  if (node.type === "params" && Array.isArray(node.entries)) {
    for (const e of node.entries) if (e.default) annotateTypes(e.default, inner, diagnostics);
  }
  return node;
}

// ---- Pass 3b: `__` へ収束する経路の静的記録（type_system.md §5 Pass 3b） ----
//
// `__` は零対象なのであらゆる崩壊が同じ `__` に潰れる。実行時にはこの一様性こそが
// 価値だが（オーバーヘッドゼロの収束）、「なぜ潰れたか」は互いに全く異なる。
// Sign の真理は Boolean ではなく値そのものを証拠として返す（原理6）ため、真の側は
// witness を運ぶのに偽の側は何も運ばない、という非対称がある。それを**値ではなく
// 帳簿の側で**埋めるのが本節の役割。
//
// 記録するのは静的に判定できた分だけで、実行時には一切残らない（原理2）。
// 実行時側の対応物は unit.md §7.3（デバッグ層の Unit Payload）。
//
// `reason` は機械可読なコード、`message` は人間向け。形式手法へ橋を架けるとき
// （Lean/Coq への変換など）に読むのは `reason` の方であり、日本語文ではない。
function collectUnitReason(node, env, diagnostics) {
  if (!node || node.type !== "operation" || node.position !== "infix") return;
  if (node.atomType !== "Unit") return;

  // 範囲族（§4）: 端点が「点」でない（List / Struct）ため零射へ落ちた場合。
  if (node.name === "range" || RANGE_STEP_OPS.has(node.name)) {
    const bad = badRangeEndpoint(node, env);
    if (bad) {
      diagnostics.push({
        level: "information",
        reason: "range-endpoint-not-a-point",
        spec: "type_system.md §4",
        message: `範囲演算子 '${node.op}' の${bad.label}が ${bad.type} であり、範囲の端点になれないため __ に収束します（端点になれるのは数値と1文字だけです）`,
      });
    }
    return;
  }

  if (!ARITHMETIC_OPS.has(node.name)) return;

  const leftType = inferAtomType(node.left, env);
  const rightType = inferAtomType(node.right, env);
  // 左辺Unitは§3.3の吸収則（`__ + x = __`）であり、型の不一致ではない——
  // 意図された伝播なので診断しない。
  if (leftType === "Unit" || rightType === "Unit") return;

  if (NON_SCALAR_PLACES.has(leftType) || NON_SCALAR_PLACES.has(rightType)) {
    diagnostics.push({
      level: "information",
      reason: "arithmetic-on-place",
      spec: "type_system.md §4",
      message:
        `算術演算 '${node.op}' の被演算子が場所またはストリーム（左辺=${leftType}, 右辺=${rightType}）であるため __ に収束します。` +
        `算術は Scalar を要求します——持ち上げた結果に演算を書いている場合は、演算を持ち上げの内側へ移してください（\`~(x + 1)\`）`,
    });
    return;
  }
  if (leftType === "String" || rightType === "String") {
    diagnostics.push({
      level: "information",
      reason: "arithmetic-type-mismatch",
      spec: "type_system.md §3.2",
      message: `算術演算 '${node.op}' の被演算子に String（左辺=${leftType}, 右辺=${rightType}）が含まれるため __ に収束します。文字列を数値として扱いたい場合は明示的な変換が必要です`,
    });
    return;
  }
  if (leftType === "List" || leftType === "Struct") {
    diagnostics.push({
      level: "information",
      reason: "list-arithmetic-undefined",
      spec: "type_system.md §3.2",
      message: `List 左辺に対する '${node.op}' は定義されていないため __ に収束します（List で意味を持つ算術は '*'（複製）・'^'（次元上げ）・'/'（分割）のみ）`,
    });
  }
}

// match_case の各 arm の型から返値型（直和）を作る（§7.3）。
//
// `__` は直和から落とす。完全性公理によりあらゆる関数が `__` を返しうるので `T | Unit` は
// 全ての関数に付き、識別情報をゼロしか持たない。零対象は余積の単位元でもあるので、
// 直和の単位元として落とすのは代数的にも一貫している。
//
// 未解決（null）が混ざる場合は直和全体が未解決——分かっていない枝がある以上、
// 分かっている枝だけで返値型を名乗ると嘘になる。
function joinArmTypes(types) {
  if (types.some((x) => x === null || x === undefined)) return null;
  const distinct = [...new Set(types.filter((x) => x !== "Unit"))].sort();
  if (distinct.length === 0) return "Unit";
  if (distinct.length === 1) return distinct[0];
  return distinct.join(" | ");
}

// apply 連鎖（`apply(apply(f, a), b)`）の根にある識別子の binding を返す。
// 根が識別子でなければ（即値ラムダ・ポイントフリー等）null——呼び先が静的に決まらない
// ので返値型も決まらない。
// 識別子の binding から、それが**指している**関数の binding を辿る。
// `p : $f` のように「関数のアドレス」を束縛している場合、`@p` の呼び先は `f` である
// ——§2 の IMPORTANT が「多くの場合は静的に一意に決まる（`@handler` で handler の定義が
// 既知なら構文から読める）」と述べている分をここで解決する。
function resolveThroughAddress(binding, env) {
  let b = binding;
  const seen = new Set();
  while (b && b.addressOf && !seen.has(b.addressOf)) {
    seen.add(b.addressOf);
    const next = envLookup(env, b.addressOf);
    if (!next) break;
    b = next;
  }
  return b;
}

function applyCalleeBinding(node, env) {
  let base = node;
  while (base && base.type === "operation" && base.name === "apply") base = base.left;
  while (base && base.type === "block" && base.kind !== "indent" && base.kind !== "abs" && (base.lines || []).length === 1) {
    base = base.lines[0];
  }
  if (!env) return null;
  // 根が `@識別子`（前置 input）なら、その識別子が指す先まで辿る。`@f x` はもちろん、
  // `p : $f` を経由した `@p x` も呼び先が静的に決まる。
  if (base && base.type === "operation" && base.position === "prefix" && base.name === "input") {
    const inner = base.operand;
    if (!isIdentifierNode(inner)) return null;
    return resolveThroughAddress(envLookup(env, inner.value), env) || null;
  }
  if (!isIdentifierNode(base)) return null;
  return resolveThroughAddress(envLookup(env, base.value), env) || null;
}

// 不動点計算のために、前回付けた型注釈を消す。
function clearTypeAnnotations(node) {
  if (!node || typeof node !== "object") return;
  delete node.atomType;
  delete node.elementType;
  delete node.slotKind;
  delete node.operandType;
  for (const k of ["left", "right", "operand", "middle"]) clearTypeAnnotations(node[k]);
  for (const l of node.lines || []) clearTypeAnnotations(l);
  for (const e of node.entries || []) clearTypeAnnotations(e.default);
}

// トップレベルの `名前 : ラムダ` から返値型を集めて識別子テーブルへ書き戻す。
// 変化があったら true（不動点の判定に使う）。
function collectReturns(nodes, env) {
  let changed = false;
  for (const node of nodes) {
    if (!isDefineNode(node) || !isIdentifierNode(node.left)) continue;
    const rhs = node.right;
    if (!rhs || rhs.type !== "operation" || rhs.name !== "lambda") continue;
    const binding = envLookup(env, node.left.value);
    if (!binding) continue;
    const ret = inferAtomType(rhs.right, rhs.scope || env);
    if (binding.returns !== ret) {
      binding.returns = ret;
      changed = true;
    }
  }
  return changed;
}

/**
 * 型注釈を不動点まで回す（§5 Pass 3）。
 *
 * 再帰関数の返値型は自分自身に依存するため、一度の走査では決まらない。**`__` を束の底**
 * として始める——零対象は直和の単位元であり joinArmTypes が `Unit` を落とすので、初回は
 * 再帰呼び出しの枝が何も寄与せず、基底ケースだけが型を決める。次の周回でその型が再帰の枝
 * へ伝わり、変化が止まったところが返値型である。
 *
 * 型変数も制約ソルビングも使っていない（§1）——束を単調に上がるだけである。
 */
function annotateAll(nodes, env, diagnostics) {
  for (const node of nodes) {
    if (!isDefineNode(node) || !isIdentifierNode(node.left)) continue;
    const rhs = node.right;
    if (!rhs || rhs.type !== "operation" || rhs.name !== "lambda") continue;
    const binding = envLookup(env, node.left.value);
    if (binding && binding.returns === undefined) binding.returns = "Unit";
  }
  // `名前 : $対象` の由来を記録する。`@名前` の呼び先を静的に解くのに使う。
  for (const node of nodes) {
    if (!isDefineNode(node) || !isIdentifierNode(node.left)) continue;
    const rhs = node.right;
    if (!rhs || rhs.type !== "operation" || rhs.position !== "prefix" || rhs.name !== "address") continue;
    if (!isIdentifierNode(rhs.operand)) continue;
    const binding = envLookup(env, node.left.value);
    if (binding) binding.addressOf = rhs.operand.value;
  }
  // 上限は「定義の数 + 2」。各周回で少なくとも1つは束を上がるので、それ以上は回らない。
  const limit = nodes.length + 2;
  for (let i = 0; i < limit; i++) {
    for (const node of nodes) clearTypeAnnotations(node);
    for (const node of nodes) annotateTypes(node, env, null);
    if (!collectReturns(nodes, env)) break;
  }
  // 診断は確定後の1回だけ集める（周回ごとに集めると重複する）。
  for (const node of nodes) clearTypeAnnotations(node);
  for (const node of nodes) annotateTypes(node, env, diagnostics);
  return nodes;
}

export { inferAtomType, annotateTypes, annotateAll, inferLambdaParamTypes, inferParamTypesFromUsage };
