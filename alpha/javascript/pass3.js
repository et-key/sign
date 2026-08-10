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
// List左辺で固有の意味を持つのは `*`(repeat)・`^`(lift)・`/`(split) だけ。
// `+`・`-`・`%` はList/Stringと同様に型エラーで __ へ収束する。
const LIST_ARITHMETIC_OPS = new Set(["mul", "pow", "div"]);

// type_system.md §3.2「要素型の join」: 余積で構築される List の要素型を求める。
// join は数値の昇格格子そのもの。戻り値の意味を3値で区別する：
//   型名   … join が求まった
//   null   … どちらかが未解決（静的に判定できないのでエラーにしない、原理4）
//   NO_JOIN … join が存在しない（コンパイルエラー）
const NO_JOIN = Symbol("no-join");

function joinElementTypes(a, b) {
  if (a === null || a === undefined || b === null || b === undefined) return null;
  if (a === b) return a;
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
    case "unicode": return "Address";
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
    if (!Array.isArray(node.lines) || node.lines.length === 0) return "List";
    // 全行が define(key:val) かつ左辺が識別子 → Struct（list_model.md §5.3、
    // pattern_guide.mdの改行区切り構造体リテラルの形）。単一エントリの `[foo : 1]` も含む。
    // 左辺が識別子でない define 行（match_caseの `cond : result`）は構造体ではないので
    // 除外する——interpreter.jsの構造体判定と同じ基準に揃えてある。
    // それ以外（関数本体等）は「ブロックの値＝最後の文の値」にフォールバックする。
    if (node.lines.every((l) => isDefineNode(l) && isIdentifierNode(l.left))) return "Struct";
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
      // 連番スロットも同じ「固定オフセットで並ぶ連続ブロック」であり、区別しない。
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
    if (node.position === "infix" && node.left) {
      // 論理・圏論族の`&`（§4: `(L -> R) -> (R | __)`）だけは右辺の型を返す。
      // 左辺は短絡（Unitなら全体がUnit）を決めるだけで、値として返るのは右辺。
      if (node.name === "and") return inferAtomType(node.right, env);
      const leftType = inferAtomType(node.left, env);
      if (ARITHMETIC_OPS.has(node.name)) return arithmeticResultType(node, leftType, env);
      return leftType; // 左辺が規則を選ぶ（§3.2）。比較・構造比較族は左辺の型が結果型
    }
    if (node.operand) {
      // 前置/後置演算子は§4に個別の型シグネチャがあるが、今回は簡略化して
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

function inferParamTypesFromUsage(bodyNode, paramNames) {
  const inferred = new Map();

  function visit(node) {
    if (!node || typeof node !== "object") return;

    const isScalarOp =
      node.type === "operation" &&
      node.position === "infix" &&
      (SCALAR_ARITHMETIC_OPS.has(node.name) || SCALAR_COMPARISON_OP_SYMBOLS.has(node.op));

    if (isScalarOp) {
      for (const side of [node.left, node.right]) {
        if (
          side &&
          side.type === "atom" &&
          side.kind === "identifier" &&
          paramNames.has(side.value) &&
          !inferred.has(side.value)
        ) {
          inferred.set(side.value, "Scalar");
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
function inferLambdaParamTypes(lambdaNode) {
  const names = new Set(paramNamesOf(lambdaNode.left));
  return inferParamTypesFromUsage(lambdaNode.right, names);
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
  if (!ARITHMETIC_OPS.has(node.name)) return;

  const leftType = inferAtomType(node.left, env);
  const rightType = inferAtomType(node.right, env);
  // 左辺Unitは§3.3の吸収則（`__ + x = __`）であり、型の不一致ではない——
  // 意図された伝播なので診断しない。
  if (leftType === "Unit" || rightType === "Unit") return;

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

export { inferAtomType, annotateTypes, inferLambdaParamTypes, inferParamTypesFromUsage };
