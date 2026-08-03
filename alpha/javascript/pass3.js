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
 * - 比較演算子（< <= = >= > !=）・空間演算子（余積）等、算術演算子以外は一律で
 *   左辺優先ルールにフォールバックしており、§4の個別の型シグネチャとの細かい整合は未検証。
 * - block（List/Struct/Dict）の区別（coproduct_resolver.md §5）は未対応。暫定的に
 *   一律 "List" として扱う。
 */

import { envLookup } from './pass1.js';

const ARITHMETIC_OPS = new Set(["add", "sub", "mul", "div", "mod", "pow"]);

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
    // 【簡略化】List/Struct/Dictの区別は未対応、暫定的にListとする。
    return "List";
  }

  if (node.type === "operation") {
    if (node.position === "infix" && node.left) {
      const leftType = inferAtomType(node.left, env);
      // §3.2 NOTE: String型の左辺に算術演算子が来ると型エラーで__に収束する
      if (leftType === "String" && ARITHMETIC_OPS.has(node.name)) return "Unit";
      return leftType; // 左辺優先ルール（§3.2）
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
// 【制限】算術演算子（+ - * / % ^）による使用箇所のみを見る。HM流の単一化はせず、
// 最初に見つかった制約を採用する（Pass 1a が前提とする「線形スキャンで完結する」という
// 設計方針に合わせた、早い者勝ちの単純な走査）。比較演算子・`'`（get_prop）等、
// 他の演算子からの逆算は未対応（要拡張）。

const SCALAR_ARITHMETIC_OPS = ARITHMETIC_OPS;

function inferParamTypesFromUsage(bodyNode, paramNames) {
  const inferred = new Map();

  function visit(node) {
    if (!node || typeof node !== "object") return;

    if (node.type === "operation" && node.position === "infix" && SCALAR_ARITHMETIC_OPS.has(node.name)) {
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
