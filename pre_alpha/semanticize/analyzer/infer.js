/**
 * Sign Type Inference Engine — Algorithm W スタイル
 * 
 * 設計:
 * - AST を走査しながら即時単一化 (eager unification) を行う
 * - coproduct ブロックの解決は型推論後に行う (ユーザー要件)
 * - 抽象解釈はフォールバックとして TVar が未解決の場合のみ発動
 * - 部分適用 / holeはカリー化モデルで自然に表現
 */

import {
  TVar, TPrim, TFun, TProd, TSum, TUnit, TList, TArray, TAddr,
  freshTVar, tUnit, buildFun, uncurry, showType
} from './types.js';
import { Substitution, unify } from './unifier.js';

// ─── 抽象解釈の再帰ガード ───
const _reInferring = new Set();

// ─── 環境管理 ───

export function createChildEnv(parent) {
  return new Map(parent);
}

// ─── メインの推論関数 ───

/**
 * AST ノードの型を推論する
 * @param {object} node - AST ノード
 * @param {Map<string, object>} env - 型環境 (name → Type)
 * @param {Substitution} subst - 現在の代入
 * @returns {object} 推論された型 (Type IR)
 */
export function infer(node, env, subst) {
  if (!node) return freshTVar();

  // ─── 文字列リテラル / 識別子 ───
  if (typeof node === 'string') {
    return inferString(node, env, subst);
  }

  // ─── 演算ノード ───
  if (node.type === 'operation') {
    const result = inferOperation(node, env, subst);
    node.type_detail = result;
    return result;
  }

  // ─── ブロック ───
  if (node.type === 'block') {
    return inferBlock(node, env, subst);
  }

  // ─── Coproduct ブロック (型推論後に解決) ───
  if (node.type === 'coproduct_block' && node.statements) {
    return inferCoproductBlock(node, env, subst);
  }

  return freshTVar();
}

// ─── 文字列の型推論 ───

function inferString(node, env, subst) {
  if (node === '_') return tUnit;
  if (node === '..') return tUnit; // default signal は呼び出し側で処理
  if (node === '__') return tUnit; // explicit hole marker

  // <name> 形式の識別子
  if (node.startsWith('<') && node.endsWith('>')) {
    const name = node.slice(1, -1);
    if (name === '_') return tUnit;
    if (name === '..') return tUnit;
    if (env.has(name)) return subst.apply(env.get(name));
    // 未束縛の名前 → 新しい型変数を割り当て
    const tv = freshTVar();
    env.set(name, tv);
    return tv;
  }

  // 文字列リテラル
  if (node.startsWith('`') && node.endsWith('`')) return new TPrim('string');

  // 数値リテラル (整数系)
  if (node.startsWith('0x') || node.startsWith('0r') || node.startsWith('0b') || node.startsWith('0u')) {
    return new TPrim('i64');
  }

  // 数値リテラル (浮動小数点)
  if (/^-?[0-9]+(\.[0-9]*)?$/.test(node)) return new TPrim('f64');

  // ラムダリフティングで生成された名前 ("__Lambda__[N]")
  if (node.startsWith('"') && node.endsWith('"')) {
    const name = node.slice(1, -1);
    if (env.has(name)) return subst.apply(env.get(name));
    const tv = freshTVar();
    env.set(name, tv);
    return tv;
  }

  return freshTVar();
}

// ─── 演算ノードの型推論 ───

function inferOperation(node, env, subst) {
  // === 定義 (:) ===
  if (node.operator === ':') {
    return inferDefine(node, env, subst);
  }

  // === ラムダ (?) ===
  if (node.operator === '?') {
    return inferLambda(node, env, subst);
  }

  // === 適用 (apply) ===
  if (node.operator === 'apply') {
    return inferApply(node, env, subst);
  }

  // === 結合 (concat) ===
  if (node.operator === 'concat') {
    return inferConcat(node, env, subst);
  }

  // === 合成 (.) ===
  if (node.operator === '.') {
    return inferCompose(node, env, subst);
  }

  // === match_case ===
  if (node.semantic_tag === 'match_case') {
    return inferMatchCase(node, env, subst);
  }

  // === 前置演算子 ===
  if (node.position === 'prefix') {
    return inferPrefix(node, env, subst);
  }

  // === 後置演算子 ===
  if (node.position === 'postfix') {
    return inferPostfix(node, env, subst);
  }

  // === 算術演算 ===
  if (['+', '-', '*', '/', '%', '^'].includes(node.operator)) {
    if (node.left) infer(node.left, env, subst);
    if (node.right) infer(node.right, env, subst);
    return new TPrim('f64');
  }

  // === 比較演算 → Maybe (T | unit) ===
  if (['==', '<', '>', '<=', '>=', '!=', '!=='].includes(node.operator)) {
    const leftType = node.left ? infer(node.left, env, subst) : freshTVar();
    if (node.right) infer(node.right, env, subst);
    return new TSum([leftType, tUnit]);
  }

  // === 環境に登録された演算子 ===
  const opName = `[${node.operator}]`;
  if (env.has(opName)) {
    const opType = subst.apply(env.get(opName));
    if (node.left) infer(node.left, env, subst);
    if (node.right) infer(node.right, env, subst);
    if (node.operand) infer(node.operand, env, subst);
    if (opType instanceof TFun) {
      const { ret } = uncurry(opType);
      return ret;
    }
    return opType;
  }

  // === フォールバック ===
  const leftT = node.left ? infer(node.left, env, subst) : null;
  const rightT = node.right ? infer(node.right, env, subst) : null;
  const opT = node.operand ? infer(node.operand, env, subst) : null;
  return rightT || leftT || opT || freshTVar();
}

// ─── 定義 (:) ───

function inferDefine(node, env, subst) {
  let name = node.left;
  if (typeof name === 'string' && name.startsWith('<')) name = name.slice(1, -1);

  // 再帰関数の事前束縛: 右辺が ? を含む場合、仮の型変数を登録
  let placeholder = null;
  if (name && containsLambdaNode(node.right)) {
    placeholder = freshTVar();
    placeholder.isFuncPlaceholder = true;
    env.set(name, placeholder);
  }

  const rightType = infer(node.right, env, subst);

  if (name) {
    // 再帰関数の placeholder を実際の型に単一化
    // これにより _lexicalEnv 内の自己参照が subst 経由で解決可能になる
    if (placeholder) {
      unify(placeholder, rightType, subst);
    }
    env.set(name, rightType);
  }

  return rightType;
}

// ─── ラムダ (?) ───

function inferLambda(node, env, subst) {
  const childEnv = createChildEnv(env);
  const paramInfos = []; // { name, type, default_type?, isList? }

  // パラメータ収集
  collectParams(node.left, childEnv, subst, paramInfos);

  // 本体の型推論
  const bodyType = infer(node.right, childEnv, subst);

  // カリー化された関数型を構築
  const paramTypes = paramInfos.map(p => p.isList ? new TList(p.type) : p.type);
  const funcType = buildFun(paramTypes, bodyType);

  // メタデータをルートノードのみに保持 (抽象解釈フォールバック用)
  Object.defineProperty(funcType, '_paramInfos', { value: paramInfos, enumerable: false });
  Object.defineProperty(funcType, '_lexicalEnv', { value: new Map(env), enumerable: false });
  Object.defineProperty(funcType, '_astNode', { value: node.right, enumerable: false });

  return funcType;
}

/**
 * ラムダの左辺からパラメータを再帰的に収集する
 */
function collectParams(argNode, env, subst, out) {
  if (!argNode) return;

  // 単一の識別子
  if (typeof argNode === 'string' && argNode.startsWith('<')) {
    const name = argNode.slice(1, -1);
    const tv = freshTVar();
    env.set(name, tv);
    out.push({ name, type: tv, isList: false });
    return;
  }

  if (typeof argNode !== 'object') return;

  // デフォルト引数: name : defaultExpr
  if (argNode.type === 'operation' && argNode.operator === ':') {
    const defaultType = infer(argNode.right, env, subst);
    let name = argNode.left;
    if (typeof name === 'string' && name.startsWith('<')) {
      name = name.slice(1, -1);
      env.set(name, defaultType);
      out.push({ name, type: defaultType, default_type: defaultType, isList: false });
    }
    return;
  }

  // 連結 (concat / apply): 複数パラメータ
  if (argNode.type === 'operation' && (argNode.operator === 'concat' || argNode.operator === 'apply')) {
    collectParams(argNode.left, env, subst, out);
    collectParams(argNode.right, env, subst, out);
    return;
  }

  // 前置 ~: リスト境界パラメータ
  if (argNode.type === 'operation' && argNode.position === 'prefix' && argNode.operator === '~') {
    let name = argNode.operand;
    if (typeof name === 'string' && name.startsWith('<')) name = name.slice(1, -1);
    const elemType = freshTVar();
    const listType = new TList(elemType);
    if (typeof name === 'string') {
      env.set(name, listType);
    }
    out.push({ name, type: elemType, isList: true });
    return;
  }

  // その他の前置/後置 → 再帰
  if (argNode.type === 'operation' && (argNode.position === 'prefix' || argNode.position === 'postfix')) {
    collectParams(argNode.operand, env, subst, out);
    return;
  }

  // ブロック
  if (argNode.type === 'block') {
    const content = Array.isArray(argNode.content) ? argNode.content : [argNode.content];
    content.forEach(c => collectParams(c, env, subst, out));
    return;
  }

  // Coproduct block (パラメータリスト)
  if (argNode.type === 'coproduct_block' && argNode.statements) {
    argNode.statements.forEach(s => collectParams(s, env, subst, out));
    return;
  }
}

// ─── 適用 (apply) ───

/**
 * 引数ノードが hole (_) か default (..) かを判定する
 */
function isHoleNode(node) {
  if (node === '_' || node === '__') return true;
  if (typeof node === 'string' && node.startsWith('<') && node.endsWith('>')) {
    return node.slice(1, -1) === '_';
  }
  return false;
}

function isDefaultNode(node) {
  if (node === '..') return true;
  if (typeof node === 'string' && node.startsWith('<') && node.endsWith('>')) {
    return node.slice(1, -1) === '..';
  }
  return false;
}

function inferApply(node, env, subst) {
  const funcType = subst.apply(infer(node.left, env, subst));
  const argType = infer(node.right, env, subst);
  const isHole = isHoleNode(node.right);
  const isDefault = isDefaultNode(node.right);

  // Unit を引数として渡した場合 — Maybe の吸収則
  if (funcType instanceof TUnit) return tUnit;
  if (!isHole && !isDefault && argType instanceof TUnit && !(funcType instanceof TFun)) return tUnit;

  // Coproduct の分配 (Functor mapping)
  if (funcType instanceof TSum) {
    const results = funcType.variants.map(v => {
      return applyFuncToArg(v, argType, isHole, isDefault, subst, node);
    });
    return normalizeSumResult(results);
  }
  if (argType instanceof TSum && !isHole) {
    const results = argType.variants.map(v => {
      return applyFuncToArg(funcType, v, isHole, isDefault, subst, node);
    });
    return normalizeSumResult(results);
  }

  return applyFuncToArg(funcType, argType, isHole, isDefault, subst, node);
}

/**
 * 関数型に引数型を適用する
 */
function applyFuncToArg(funcType, argType, isHole, isDefault, subst, node) {
  funcType = subst.apply(funcType);

  // If we have a TVar and it's a hole/default, we need to convert it to a TFun first
  if (funcType instanceof TVar && (isHole || isDefault)) {
    const retVar = freshTVar();
    unify(funcType, new TFun(freshTVar(), retVar), subst);
    funcType = subst.apply(funcType);
  }

  if (isHole) {
    // Hole (_): このパラメータをスキップし、末尾に移動する
    // TFun(x, TFun(y, ret)) → TFun(y, TFun(x, ret))
    // これにより次の apply は y に適用され、x は最後に残る
    if (funcType.ret instanceof TFun) {
      const holedParam = funcType.param;
      const { params: restParams, ret: finalRet } = uncurry(funcType.ret);
      const newFun = buildFun([...restParams, holedParam], finalRet);
      // メタデータ転写
      if (funcType._paramInfos) {
        const newInfos = [...funcType._paramInfos];
        const holedInfo = newInfos.shift();
        newInfos.push(holedInfo);
        Object.defineProperty(newFun, '_paramInfos', { value: newInfos, enumerable: false });
      }
      if (funcType._lexicalEnv) Object.defineProperty(newFun, '_lexicalEnv', { value: funcType._lexicalEnv, enumerable: false });
      if (funcType._astNode) Object.defineProperty(newFun, '_astNode', { value: funcType._astNode, enumerable: false });
      return newFun;
    }
    // 最後のパラメータに対する hole → そのまま返す
    return funcType;
  }

  if (isDefault) {
    // Default signal (..): パラメータのデフォルト値を使用して消費する
    return subst.apply(funcType.ret);
  }

  // 通常の適用: 引数をタプル/配列展開してカリー化された関数に順次適用
  let argsToApply = [];
  if (argType instanceof TProd) {
    argsToApply = [...argType.elements];
  } else if (argType instanceof TArray) {
    for (let i = 0; i < argType.length; i++) {
      argsToApply.push(argType.elem);
    }
  } else {
    argsToApply = [argType];
  }

  let currentType = funcType;
  let variadicElemType = null;
  let i = 0;
  while (i < argsToApply.length) {
    const arg = argsToApply[i];
    if (variadicElemType) {
      if (arg instanceof TList) {
        unify(variadicElemType, arg.elem, subst);
      } else {
        unify(variadicElemType, arg, subst);
      }
      i++;
      continue;
    }

    currentType = subst.apply(currentType);
    if (currentType instanceof TFun) {
      // パラメータがリスト型の場合、残り引数を全て吸収
      if (currentType.param instanceof TList) {
        variadicElemType = currentType.param.elem;
        // TList 引数 → 要素型を単一化
        if (arg instanceof TList) {
          unify(variadicElemType, arg.elem, subst);
        } else {
          unify(variadicElemType, arg, subst);
        }
        currentType = currentType.ret;
        i++;
        continue;
      }

      // Unit 引数 → デフォルト値トリガー (型は ret 側に伝播)
      if (arg instanceof TUnit) {
        currentType = currentType.ret;
        i++;
        continue;
      }

      // TList のスプレッド引数 → スカラーパラメータには要素型を適用
      if (arg instanceof TList) {
        unify(currentType.param, arg.elem, subst);
        currentType = currentType.ret;
        // i をインクリメントしない (TList は後続のパラメータにも展開される)
        continue;
      }

      unify(currentType.param, arg, subst);
      currentType = currentType.ret;
      i++;
    } else if (currentType instanceof TVar) {
      const retVar = freshTVar();
      unify(currentType, new TFun(arg instanceof TList ? arg.elem : arg, retVar), subst);
      currentType = retVar;
      i++;
    } else {
      break;
    }
  }

  currentType = subst.apply(currentType);

  // ─── 抽象解釈フォールバック ───
  // 全引数が消費され、かつ関数本体のAST情報が残っている場合、
  // 具象型で本体を再推論する。再帰関数はガードで無限ループを防ぐ。
  if (!(currentType instanceof TFun) && funcType._astNode && funcType._lexicalEnv && funcType._paramInfos) {
    const astKey = funcType._astNode;
    if (!_reInferring.has(astKey)) {
      _reInferring.add(astKey);
      try {
        const execEnv = new Map(funcType._lexicalEnv);
        for (const info of funcType._paramInfos) {
          const resolvedType = subst.apply(info.type);
          execEnv.set(info.name, info.isList ? new TList(resolvedType) : resolvedType);
        }
        for (const [k, v] of execEnv.entries()) {
          execEnv.set(k, subst.apply(v));
        }
        const reInferred = infer(astKey, execEnv, subst);
        const resolved = subst.apply(reInferred);
        if (!(resolved instanceof TVar)) {
          return resolved;
        }
      } finally {
        _reInferring.delete(astKey);
      }
    }
  }

  return currentType;
}

/**
 * 再帰型の固定点解決: TProd([β, recursiveVar]) → TList(β)
 * map の再帰パターン: T = (β, T) の固定点 → T = List<β>
 */
function tryResolveRecursiveList(resolved, recursiveRetVar, subst) {
  // TProd([β, recursiveVar]) パターンを検出
  if (resolved instanceof TProd && resolved.elements.length === 2) {
    const [e0, e1] = resolved.elements.map(e => subst.apply(e));
    // どちらかが recursiveRetVar で、もう一方が具象型 β なら TList(β)
    if (e1 instanceof TVar && e1.id === recursiveRetVar.id && !(e0 instanceof TVar)) {
      return new TList(e0);
    }
    if (e0 instanceof TVar && e0.id === recursiveRetVar.id && !(e1 instanceof TVar)) {
      return new TList(e1);
    }
  }
  // TList(recursiveVar) パターン（既にリスト化されている場合）
  if (resolved instanceof TList) {
    const elem = subst.apply(resolved.elem);
    if (!(elem instanceof TVar)) return resolved;
  }
  return null;
}

function normalizeSumResult(results) {
  const flat = [];
  for (const r of results) {
    if (r instanceof TSum) flat.push(...r.variants);
    else flat.push(r);
  }
  const unique = [];
  for (const v of flat) {
    if (!unique.some(u => u === v || (u.tag === v.tag && u.name === v.name && u.id === v.id))) {
      unique.push(v);
    }
  }
  if (unique.length === 1) return unique[0];
  return new TSum(unique);
}

// ─── 結合 (concat) ───

function inferConcat(node, env, subst) {
  const leftType = infer(node.left, env, subst);
  const rightType = infer(node.right, env, subst);

  // タプル要素を平坦化
  let elements = [];
  const extract = (t) => {
    t = subst.apply(t);
    if (t instanceof TProd) {
      t.elements.forEach(extract);
    } else {
      elements.push(t);
    }
  };
  extract(leftType);
  extract(rightType);

  // リスト吸収則: [~T, T] → [~T], [T, ~T] → [~T], [~T, ~T] → [~T]
  let collapsed = [];
  for (const curr of elements) {
    if (collapsed.length > 0) {
      const prev = collapsed[collapsed.length - 1];
      if (prev instanceof TList && curr instanceof TList) {
        unify(prev.elem, curr.elem, subst);
        continue; // absorb
      }
      if (prev instanceof TList) {
        unify(prev.elem, curr, subst);
        continue; // absorb into list
      }
      if (curr instanceof TList) {
        unify(curr.elem, prev, subst);
        collapsed.pop();
        // fall through to push curr
      }
    }
    collapsed.push(curr);
  }
  elements = collapsed;

  if (elements.length === 0) return tUnit;
  if (elements.length === 1) return elements[0];

  // 全要素が同じ型か判定 → 配列型に昇格
  // まず TArray を個別要素に展開する
  let expanded = [];
  for (const e of elements) {
    const re = subst.apply(e);
    if (re instanceof TArray) {
      for (let i = 0; i < re.length; i++) expanded.push(re.elem);
    } else {
      expanded.push(re);
    }
  }

  const first = expanded[0];
  const isHomogeneous = expanded.length > 0 && expanded.every(e =>
    e.tag === first.tag && (
      (e instanceof TPrim && first instanceof TPrim && e.name === first.name) ||
      (e instanceof TVar && first instanceof TVar && e.id === first.id) ||
      (e instanceof TUnit && first instanceof TUnit)
    )
  );

  if (isHomogeneous && !(first instanceof TVar)) {
    return new TArray(first, expanded.length);
  }

  return new TProd(elements);
}

// ─── 合成 (.) ───

function inferCompose(node, env, subst) {
  const fType = subst.apply(infer(node.left, env, subst));
  const gType = subst.apply(infer(node.right, env, subst));

  if (fType instanceof TFun && gType instanceof TFun) {
    // f . g = \x -> f(g(x))
    // g の返り値を f の入力に単一化
    const gRet = extractReturn(gType);
    const composed = applyFuncToArg(fType, gRet, false, false, subst, node);
    
    // g のパラメータを保持した関数型を構築
    const { params: gParams } = uncurry(gType);
    return buildFun(gParams, composed);
  }

  return freshTVar();
}

function extractReturn(t) {
  while (t instanceof TFun) t = t.ret;
  return t;
}

// ─── Match case ───

function inferMatchCase(node, env, subst) {
  const resultType = infer(node.right, env, subst);
  const fallbackVar = freshTVar();
  const retType = new TSum([resultType, fallbackVar]);
  return new TFun(fallbackVar, retType);
}

// ─── 前置演算子 ───

function inferPrefix(node, env, subst) {
  if (node.operator === '$') {
    // アドレス取得
    const target = infer(node.operand, env, subst);
    return new TAddr(target);
  }

  if (node.operator === '@') {
    // 間接参照
    const operandType = subst.apply(infer(node.operand, env, subst));
    if (operandType instanceof TAddr) {
      return operandType.target;
    }
    if (operandType instanceof TVar) {
      const targetType = freshTVar();
      unify(operandType, new TAddr(targetType), subst);
      return targetType;
    }
    return freshTVar();
  }

  if (node.operator === '~') {
    // リスト化 (continuous)
    const elemType = infer(node.operand, env, subst);
    return new TList(elemType);
  }

  if (node.operator === '!') {
    // 論理否定
    infer(node.operand, env, subst);
    return new TSum([new TPrim('f64'), tUnit]);
  }

  if (node.operator === '-') {
    // 数値否定
    infer(node.operand, env, subst);
    return new TPrim('f64');
  }

  if (node.operand) infer(node.operand, env, subst);
  return freshTVar();
}

// ─── 後置演算子 ───

function inferPostfix(node, env, subst) {
  if (node.operator === '~') {
    // 展開 (spread)
    const targetType = subst.apply(infer(node.operand, env, subst));
    // 空リスト/空タプルの場合は unit (variadic end marker)
    if (targetType instanceof TArray && targetType.length === 0) return tUnit;
    if (targetType instanceof TProd && targetType.elements.length === 0) return tUnit;
    return targetType;
  }

  if (node.operator === '!') {
    // 階乗
    infer(node.operand, env, subst);
    return new TPrim('f64');
  }

  if (node.operand) infer(node.operand, env, subst);
  return freshTVar();
}

// ─── ブロック ───

function inferBlock(node, env, subst) {
  const childEnv = createChildEnv(env);
  let lastType = freshTVar();
  if (Array.isArray(node.content)) {
    for (const c of node.content) {
      lastType = infer(c, childEnv, subst);
    }
  } else {
    lastType = infer(node.content, childEnv, subst);
  }
  node.type_detail = lastType;
  return lastType;
}

// ─── Coproduct ブロック (プレセデンス規則 10.0〜10.3 に準拠) ───

/**
 * ノードが hole (_) または default (..) マーカーかを判定する。
 * マーカーは concat 対象外 — 個別の apply 引数として保持する。
 */
function isMarkerNode(entry) {
  const n = entry.node;
  if (n === '_' || n === '__' || n === '..') return true;
  if (typeof n === 'string' && n.startsWith('<') && n.endsWith('>')) {
    const name = n.slice(1, -1);
    return name === '_' || name === '..';
  }
  return false;
}

function inferCoproductBlock(node, env, subst) {
  const childEnv = createChildEnv(env);

  // Phase 1: 各 statement の型を推論
  const stmtTypes = node.statements.map(s => {
    const t = infer(s, childEnv, subst);
    return { node: s, type: subst.apply(t) };
  });

  let stmts = [...stmtTypes];

  // ─── 型分類ヘルパー ───

  const isFuncType = (entry) => {
    const t = subst.apply(entry.type);
    if (t instanceof TFun) return true;
    if (t instanceof TAddr && t.target instanceof TFun) return true;
    if (t.isFuncPlaceholder) return true;
    if (entry.node?.semantic_tag === 'point_free_function') return true;
    if (entry.node?.semantic_tag === 'vectorized_function') return true;
    if (entry.node?.semantic_tag === 'composition') return true;
    if (entry.node?.type === 'operation' && entry.node?.operator === '?') return true;
    // @ prefix (deref) は常に関数の可能性がある
    if (entry.node?.type === 'operation' && entry.node?.operator === '@' &&
        entry.node?.position === 'prefix') return true;
    // 環境に登録された関数名
    if (typeof entry.node === 'string' && entry.node.startsWith('<') && entry.node.endsWith('>')) {
      const name = entry.node.slice(1, -1);
      if (childEnv.has(name)) {
        const envType = subst.apply(childEnv.get(name));
        if (envType instanceof TFun || envType.isFuncPlaceholder) return true;
      }
    }
    return false;
  };

  // TAddr は「関数かもしれない値」— Pass 10.3 の concat から除外する
  const isAddrType = (entry) => {
    const t = subst.apply(entry.type);
    return t instanceof TAddr;
  };

  const isValueOrList = (entry) =>
    !isFuncType(entry) && !isMarkerNode(entry);

  // ─── canApply: 関数合成 vs 関数適用 の判定 ───
  const canApply = (fType, argType) => {
    fType = subst.apply(fType);
    argType = subst.apply(argType);
    if (!(fType instanceof TFun)) return true;
    const param = subst.apply(fType.param);
    if (param instanceof TFun) return true;
    if (param instanceof TAddr) return true;
    if (param instanceof TVar) return true;
    const isArgFunc = argType instanceof TFun ||
      (argType instanceof TAddr && argType.target instanceof TFun);
    if (isArgFunc) return false;
    return true;
  };

  let changed;

  // ─── Pass 10.3（最高優先）: 値/リスト ∐ 値/リスト → リスト結合 ───
  // TAddr を持つエントリは concat しない（関数アドレスの可能性があるため）
  changed = true;
  while (changed) {
    changed = false;
    for (let i = 0; i < stmts.length - 1; i++) {
      if (isValueOrList(stmts[i]) && isValueOrList(stmts[i + 1]) &&
          !isAddrType(stmts[i]) && !isAddrType(stmts[i + 1]) &&
          !isMarkerNode(stmts[i]) && !isMarkerNode(stmts[i + 1])) {
        const concatNode = {
          type: 'operation', operator: 'concat',
          left: stmts[i].node, right: stmts[i + 1].node,
          semantic_tag: 'list_composition'
        };
        const concatType = inferConcat(concatNode, childEnv, subst);
        concatNode.type_detail = concatType;
        stmts.splice(i, 2, { node: concatNode, type: concatType });
        changed = true;
        break;
      }
    }
  }

  // ─── Pass 10.2: 関数 ∐ 関数 → 関数合成 ───
  // ただし関数適用が可能な場合（パラメータが関数型）は適用を優先
  changed = true;
  while (changed) {
    changed = false;
    for (let i = 0; i < stmts.length - 1; i++) {
      if (isFuncType(stmts[i]) && isFuncType(stmts[i + 1])) {
        if (!canApply(stmts[i].type, stmts[i + 1].type)) {
          const composeNode = {
            type: 'operation', operator: '.',
            left: stmts[i].node, right: stmts[i + 1].node,
            semantic_tag: 'composition'
          };
          const composeType = inferCompose(composeNode, childEnv, subst);
          composeNode.type_detail = composeType;
          stmts.splice(i, 2, { node: composeNode, type: composeType });
          changed = true;
          break;
        }
      }
    }
  }

  // ─── Pass 10.1: 値/リスト ∐ 関数 → 逆適用 ───
  // 左辺が値/リスト、右辺が関数の場合: 右辺の関数を左辺に適用
  changed = true;
  while (changed) {
    changed = false;
    for (let i = 0; i < stmts.length - 1; i++) {
      if (isValueOrList(stmts[i]) && isFuncType(stmts[i + 1]) &&
          !isMarkerNode(stmts[i]) && !isMarkerNode(stmts[i + 1])) {
        const revApplyNode = {
          type: 'operation', operator: 'apply',
          left: stmts[i + 1].node, right: stmts[i].node,
          semantic_tag: 'reverse_application'
        };
        const revApplyType = inferApply(revApplyNode, childEnv, subst);
        revApplyNode.type_detail = revApplyType;
        stmts.splice(i, 2, { node: revApplyNode, type: revApplyType });
        changed = true;
        break;
      }
    }
  }

  // ─── Pass 10.0（最低優先）: 関数 ∐ 値/リスト → 関数評価（左から右） ───
  while (stmts.length > 1) {
    const left = stmts[0];
    const right = stmts[1];
    const applyNode = {
      type: 'operation', operator: 'apply',
      left: left.node, right: right.node,
      semantic_tag: 'application'
    };
    const applyType = inferApply(applyNode, childEnv, subst);
    applyNode.type_detail = applyType;
    stmts.splice(0, 2, { node: applyNode, type: applyType });
  }

  // 解決済みの AST で元のノードを更新
  if (stmts.length > 0) {
    const resolved = stmts[0];
    Object.assign(node, resolved.node);
    node.type_detail = resolved.type;
    return resolved.type;
  }

  return freshTVar();
}

// ─── ヘルパー ───

function containsLambdaNode(node) {
  if (!node || typeof node !== 'object') return false;
  if (node.type === 'operation' && node.operator === '?') return true;
  if (node.type === 'block') {
    if (Array.isArray(node.content)) return node.content.some(containsLambdaNode);
    return containsLambdaNode(node.content);
  }
  if (node.type === 'coproduct_block') return node.statements?.some(containsLambdaNode);
  return containsLambdaNode(node.left) || containsLambdaNode(node.right);
}
