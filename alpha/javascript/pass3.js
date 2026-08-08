/**
 * Pass3（型伝播、type_system.md §2〜§3.2の実装）
 *
 * Pass2（coproduct_resolver.md）が構築した二分木ASTを歩いて、各ノードの
 * Layer 2型（Atom内部型: Address/Float/String/Vector/List/Struct/Dict/Unit）を推論する。
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
 * - Dict判定は「複数行、全行がdefine(key:val)」という形（list_model.md §5.3、
 *   pattern_guide.mdの`dict`例が示す改行区切りの形）のみを見る。カンマと`:`を1行に
 *   混在させる形（例: `foo:1, bar:2`、ドキュメントに例が無い）は非対応・未定義動作。
 */

import { envLookup } from './pass1.js';

const ARITHMETIC_OPS = new Set(["add", "sub", "mul", "div", "mod", "pow"]);
// coproduct_resolver.md §3-4: Atom-Atom間の余積（スペース）が縮約される演算。
// これらの結果はList（1次元配列）そのものであり、左辺の個別の型を素通しすべきではない。
const LIST_BUILDING_OPS = new Set(["construct", "concat", "push", "unshift"]);

function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}

// カンマ（product, 直積）で左結合に連なったチェーンを、末端の要素配列へ展開する。
function flattenProduct(node) {
  if (node && node.type === "operation" && node.name === "product") {
    return [...flattenProduct(node.left), ...flattenProduct(node.right)];
  }
  return [node];
}

// カンマ（,）で結合された要素列のLayer 2型を判定する（type_system.md §2）。
// 全要素が define（key:val）なら Dict、そうでなければ Struct（多相リスト/直積構造）。
function productShape(node) {
  const elems = flattenProduct(node);
  return elems.length > 0 && elems.every(isDefineNode) ? "Dict" : "Struct";
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
function inferAtomType(node, env) {
  if (!node || typeof node !== "object") return null;

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
    // 複数行、かつ全行がdefine(key:val) → Dict（list_model.md §5.3、pattern_guide.mdの
    // 改行区切り辞書リテラルの形）。それ以外の複数行（関数本体等）は「ブロックの値＝
    // 最後の文の値」という通常のブロック式のセマンティクスにフォールバックする。
    if (node.lines.length > 1 && node.lines.every(isDefineNode)) return "Dict";
    return inferAtomType(node.lines[node.lines.length - 1], env);
  }

  if (node.type === "operation") {
    if (node.name === "product") {
      // カンマ（直積）: 全要素がdefineならDict、そうでなければStruct（type_system.md §2）
      return productShape(node);
    }
    if (node.name === "define") {
      // 単一のkey:valペア（例: [foo:1]）自体を値として問われた場合、単一エントリのDictとする。
      return "Dict";
    }
    if (LIST_BUILDING_OPS.has(node.name)) {
      // 余積族（§3.2の族別テーブル）: 左辺がStringならテキスト連結でString、
      // それ以外はList構築。以前は無条件に"List"を返していたが、interpreter.jsの
      // concatは左辺がstringならテキスト連結する（`ab` 1 → "ab1"）ため食い違っていた。
      return inferAtomType(node.left, env) === "String" ? "String" : "List";
    }
    if (node.position === "infix" && node.left) {
      // 論理・圏論族の`&`（§4: `(L -> R) -> (R | __)`）だけは右辺の型を返す。
      // 左辺は短絡（Unitなら全体がUnit）を決めるだけで、値として返るのは右辺。
      if (node.name === "and") return inferAtomType(node.right, env);
      const leftType = inferAtomType(node.left, env);
      // §3.2 算術族: String型の左辺に算術演算子が来ると型エラーで__に収束する
      if (leftType === "String" && ARITHMETIC_OPS.has(node.name)) return "Unit";
      return leftType; // 左辺が規則を選ぶ（§3.2）。算術・比較・構造比較族は左辺の型が結果型
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

export { inferAtomType, inferLambdaParamTypes, inferParamTypesFromUsage };
