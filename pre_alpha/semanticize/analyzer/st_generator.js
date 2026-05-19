/**
 * Sign .st (Type Signature) Generator
 * 新しい Type IR に対応した版
 */

import {
  TVar, TPrim, TFun, TProd, TSum, TUnit, TList, TArray, TAddr,
  uncurry
} from './types.js';

/**
 * 型をフォーマットする。ジェネリック型変数は T, U, V... に正規化する。
 * @param {object} t - Type IR オブジェクト
 * @param {Map<number, string>} genericMap - TVar.id → 表示名のマッピング
 * @param {{ val: number }} counter - ジェネリック名のカウンタ
 * @returns {string}
 */
export function formatTypeObj(t, genericMap = new Map(), counter = { val: 0 }) {
  if (!t) return 'unknown';

  if (t instanceof TVar || t.tag === 'TVar') {
    if (!genericMap.has(t.id)) {
      genericMap.set(t.id, String.fromCharCode(84 + counter.val++)); // T, U, V...
    }
    return genericMap.get(t.id);
  }

  if (t instanceof TPrim || t.tag === 'TPrim') return t.name;
  if (t instanceof TUnit || t.tag === 'TUnit') return 'unit';

  if (t instanceof TFun || t.tag === 'TFun') {
    const { params, ret } = uncurry(t);
    const paramsStr = params.map((p, i) => formatTypeObj(p, genericMap, counter)).join(', ');
    const retStr = formatTypeObj(ret, genericMap, counter);
    return `(${paramsStr}) -> ${retStr}`;
  }

  if (t instanceof TProd || t.tag === 'TProd') {
    return t.elements.map(e => formatTypeObj(e, genericMap, counter)).join(' * ');
  }

  if (t instanceof TSum || t.tag === 'TSum') {
    return t.variants.map(v => formatTypeObj(v, genericMap, counter)).join(' | ');
  }

  if (t instanceof TList || t.tag === 'TList') {
    return `List<${formatTypeObj(t.elem, genericMap, counter)}>`;
  }

  if (t instanceof TArray || t.tag === 'TArray') {
    return `[${formatTypeObj(t.elem, genericMap, counter)}; ${t.length}]`;
  }

  if (t instanceof TAddr || t.tag === 'TAddr') {
    return `Addr<${formatTypeObj(t.target, genericMap, counter)}>`;
  }

  return 'unknown';
}

/**
 * 関数型の場合はパラメータ名付きで表示する
 * パラメータ名は _paramInfos メタデータから取得
 */
function formatFuncWithNames(t, genericMap, counter) {
  const { params, ret } = uncurry(t);
  const paramInfos = t._paramInfos || [];

  const paramsStr = params.map((p, i) => {
    const info = paramInfos[i];
    const name = info?.name || `_${i}`;
    const typeStr = formatTypeObj(p, genericMap, counter);
    return `${name}: ${typeStr}`;
  }).join(', ');

  const retStr = formatTypeObj(ret, genericMap, counter);
  return `(${paramsStr}) -> ${retStr}`;
}

/**
 * トップレベル定義から .st シグネチャ行を生成する
 */
export function extractSignature(name, rightNode) {
  if (!rightNode) return `value ${name} : unknown\n`;

  const t = rightNode.type_detail;

  if (t && (t instanceof TFun || t.tag === 'TFun')) {
    const genericMap = new Map();
    const counter = { val: 0 };
    const typeStr = formatFuncWithNames(t, genericMap, counter);
    return `type ${name} : ${typeStr}\n`;
  } else {
    const genericMap = new Map();
    const counter = { val: 0 };
    const typeStr = formatTypeObj(t, genericMap, counter);
    return `value ${name} : ${typeStr}\n`;
  }
}

/**
 * AST 全体から .st ファイルの内容を生成する
 */
export function generateST(astTrees, lambdas) {
  let stOutput = "// Auto-generated type signature file\n\n";

  for (const tree of astTrees) {
    if (tree && tree.type === 'operation' && tree.operator === ':') {
      let name = tree.left;
      if (typeof name === 'string' && name.startsWith('<')) name = name.slice(1, -1);
      if (typeof name === 'string' && name.startsWith('"')) name = name.slice(1, -1);
      stOutput += extractSignature(name, tree.right);
    }
  }

  if (lambdas && lambdas.length > 0) {
    stOutput += "\n// Hoisted anonymous functions\n";
    for (const lambda of lambdas) {
      if (lambda.type === 'operation' && lambda.operator === ':') {
        let name = lambda.left;
        if (typeof name === 'string' && name.startsWith('"')) name = name.slice(1, -1);
        stOutput += extractSignature(name, lambda.right);
      }
    }
  }

  return stOutput;
}
