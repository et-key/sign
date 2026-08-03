/**
 * Pass1b（`@ref`のジェネリック仮引数の具体化、type_system.md §5 Pass 1b）
 *
 * `f : ref ? @ref 1 2 3` のようなジェネリックな仮引数（参照先が Lambda か Atom かが
 * 定義サイト単体では決まらないもの）は、Pass1a の単一線形スキャンだけでは解決できない。
 * §5はこれを「呼び出しグラフに対する処理」として、実際の呼び出しサイトの実引数カテゴリを
 * 集めて具体化する、と定義している。
 *
 * 【現状の実装範囲】呼び出しサイトの収集は、compiler_pipeline.md §6 が定義する
 * 「debugビルドで`test`フォルダを実行して得るトレース」ではなく、**`src`（プログラム全体の
 * 解決済みAST）に対する静的走査**のみで行う（テストフォルダを実行するインタプリタ自体が
 * まだ存在しないため）。したがって「呼び出しサイトが無い場合はコンパイルエラー（exportされて
 * いれば）」という§5・compiler_pipeline.md §6.3の規則のうち、コンパイルエラーにする部分は
 * 未実装——呼び出しサイトが見つからなければ空の結果を返すのみ。
 *
 * 【既知の制限】
 * - export印（`#`/`##`/`###`）の判定は未実装のため、「exportされているのに呼び出しサイトが
 *   無い場合はコンパイルエラー」は実装していない。
 * - 引数が複数あるLambda（`params[]`）への呼び出しサイトのうち、ジェネリック仮引数以外の
 *   位置の対応付けは未対応（単一引数の関数、または最初の引数のみを想定）。
 * - 相互再帰するジェネリック関数同士の具体化（§5 Pass1bの「本節は将来の検討事項」）は未対応。
 */

import { getCategory } from './pass2.js';

function isIdentifierAtom(node, name) {
  return !!node && node.type === "atom" && node.kind === "identifier" && (name === undefined || node.value === name);
}

// lambdaのparamsノード（identifier単体 or params[]）から仮引数名の集合を取り出す。
// pass3.jsのparamNamesOfと同じロジック（循環import回避のためここで別途最小実装）。
function paramNamesOf(paramNode) {
  if (!paramNode) return [];
  if (paramNode.type === "atom" && paramNode.kind === "identifier") return [paramNode.value];
  if (paramNode.type === "params") return paramNode.entries.map((e) => e.name);
  return [];
}

// 本体（bodyNode）を走査し、`@`前置演算子が直接かかっている仮引数名の集合を返す。
// これらは「参照先がLambdaかAtomか定義サイト単体では決まらない」ジェネリックな仮引数
// （type_system.md §3.5, §5 Pass1b）とみなす。
function detectGenericParams(bodyNode, paramNames) {
  const generic = new Set();

  function visit(node) {
    if (!node || typeof node !== "object") return;
    if (node.type === "operation" && node.position === "prefix" && node.op === "@") {
      const operand = node.operand;
      if (operand && paramNames.has(operand.value) && isIdentifierAtom(operand)) {
        generic.add(operand.value);
      }
    }
    if (node.left) visit(node.left);
    if (node.right) visit(node.right);
    if (node.operand) visit(node.operand);
    if (node.type === "block" && Array.isArray(node.lines)) node.lines.forEach(visit);
  }

  visit(bodyNode);
  return generic;
}

// resolvedNodes（Pass2で解決済みのASTの並び、プログラム全体）を走査し、
// `fnName`という名前の関数への apply[fnName, arg] という呼び出しサイトを全て集めて、
// 実引数ノードの配列を返す（単一引数の関数を想定した簡易実装）。
function collectCallsites(resolvedNodes, fnName) {
  const sites = [];

  function visit(node) {
    if (!node || typeof node !== "object") return;
    if (
      node.type === "operation" &&
      node.name === "apply" &&
      isIdentifierAtom(node.left, fnName)
    ) {
      sites.push(node.right);
    }
    if (node.left) visit(node.left);
    if (node.right) visit(node.right);
    if (node.operand) visit(node.operand);
    if (node.type === "block" && Array.isArray(node.lines)) node.lines.forEach(visit);
  }

  for (const n of resolvedNodes) visit(n);
  return sites;
}

// defineNode（{type:"operation", name:"define", left: identifier(fnName), right: lambdaNode}）と、
// プログラム全体の解決済みノード列を受け取り、各ジェネリック仮引数について
// { paramName -> { callsiteCount, categories } } を返す。
// categories は呼び出しサイトで実際に観測された実引数のカテゴリ（Lambda/Atom）の集合。
function specializeGenericParams(defineNode, resolvedNodes, env) {
  const result = new Map();
  if (!defineNode || defineNode.name !== "define") return result;

  const fnName = defineNode.left && defineNode.left.value;
  const lambdaNode = defineNode.right;
  if (!fnName || !lambdaNode || lambdaNode.name !== "lambda") return result;

  const paramNames = new Set(paramNamesOf(lambdaNode.left));
  const genericParams = detectGenericParams(lambdaNode.right, paramNames);
  if (genericParams.size === 0) return result;

  const sites = collectCallsites(resolvedNodes, fnName);
  const categories = [...new Set(sites.map((argNode) => getCategory(argNode, env)))];

  for (const paramName of genericParams) {
    result.set(paramName, { callsiteCount: sites.length, categories });
  }
  return result;
}

export { detectGenericParams, collectCallsites, specializeGenericParams };
