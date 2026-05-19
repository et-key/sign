/**
 * Sign Unifier — 単一化アルゴリズム
 * 
 * Algorithm W スタイルの即時単一化。
 * 制約を蓄積せず、推論中にその場で解決する。
 */

import { TVar, TPrim, TFun, TProd, TSum, TUnit, TList, TArray, TAddr, tUnit, typeEq } from './types.js';

export class Substitution {
  constructor() {
    /** @type {Map<number, object>} TVar.id → Type */
    this.map = new Map();
  }

  /**
   * 型に代入を適用し、全ての TVar を解決する
   */
  apply(t) {
    if (!t) return t;

    if (t instanceof TVar) {
      if (this.map.has(t.id)) {
        return this.apply(this.map.get(t.id)); // chain resolution
      }
      return t;
    }
    if (t instanceof TPrim || t instanceof TUnit) return t;
    if (t instanceof TFun) {
      const result = new TFun(this.apply(t.param), this.apply(t.ret));
      // 非列挙メタデータの転写 (パラメータ名、レキシカル環境、ASTノード)
      if (t._paramInfos) Object.defineProperty(result, '_paramInfos', { value: t._paramInfos, enumerable: false });
      if (t._lexicalEnv) Object.defineProperty(result, '_lexicalEnv', { value: t._lexicalEnv, enumerable: false });
      if (t._astNode) Object.defineProperty(result, '_astNode', { value: t._astNode, enumerable: false });
      return result;
    }
    if (t instanceof TProd) return new TProd(t.elements.map(e => this.apply(e)));
    if (t instanceof TSum) {
      const resolved = t.variants.map(v => this.apply(v));
      return normalizeTSum(resolved);
    }
    if (t instanceof TList) return new TList(this.apply(t.elem));
    if (t instanceof TArray) return new TArray(this.apply(t.elem), t.length);
    if (t instanceof TAddr) return new TAddr(this.apply(t.target));
    return t;
  }

  /**
   * TVar を型に束縛する
   */
  bind(tvarId, type) {
    this.map.set(tvarId, type);
  }
}

/**
 * TSum の正規化: 重複排除、ネスト平坦化、単一要素ならアンラップ
 */
function normalizeTSum(variants) {
  // 平坦化
  const flat = [];
  for (const v of variants) {
    if (v instanceof TSum) flat.push(...v.variants);
    else flat.push(v);
  }
  
  // 重複排除 (構造的等価性)
  const unique = [];
  for (const v of flat) {
    if (!unique.some(u => typeEq(u, v))) {
      unique.push(v);
    }
  }
  
  if (unique.length === 0) return tUnit;
  if (unique.length === 1) return unique[0];
  return new TSum(unique);
}

/**
 * Occurs check: tvarId が type の中に出現するかチェック
 */
function occursIn(tvarId, type, subst) {
  type = subst.apply(type);
  if (type instanceof TVar) return type.id === tvarId;
  if (type instanceof TFun) return occursIn(tvarId, type.param, subst) || occursIn(tvarId, type.ret, subst);
  if (type instanceof TProd) return type.elements.some(e => occursIn(tvarId, e, subst));
  if (type instanceof TSum) return type.variants.some(v => occursIn(tvarId, v, subst));
  if (type instanceof TList) return occursIn(tvarId, type.elem, subst);
  if (type instanceof TArray) return occursIn(tvarId, type.elem, subst);
  if (type instanceof TAddr) return occursIn(tvarId, type.target, subst);
  return false;
}

/**
 * 二つの型を単一化する。成功すれば subst が更新される。
 * Sign は構造的型付けなので、不一致は警告に留めエラーにしない。
 */
export function unify(t1, t2, subst) {
  t1 = subst.apply(t1);
  t2 = subst.apply(t2);

  // 同一オブジェクト
  if (t1 === t2) return;

  // TVar の束縛
  if (t1 instanceof TVar) {
    if (t2 instanceof TVar && t1.id === t2.id) return;
    if (occursIn(t1.id, t2, subst)) {
      // 再帰型 — Sign では許容する (recursive list types 等)
      return;
    }
    subst.bind(t1.id, t2);
    return;
  }
  if (t2 instanceof TVar) {
    return unify(t2, t1, subst);
  }

  // Unit
  if (t1 instanceof TUnit && t2 instanceof TUnit) return;

  // Primitives
  if (t1 instanceof TPrim && t2 instanceof TPrim) {
    if (t1.name !== t2.name) {
      // 異なるプリミティブ型 — 静的に検出 (今は警告のみ)
      // console.warn(`[Unify] Primitive mismatch: ${t1.name} vs ${t2.name}`);
    }
    return;
  }

  // Functions (curried)
  if (t1 instanceof TFun && t2 instanceof TFun) {
    unify(t1.param, t2.param, subst);
    unify(t1.ret, t2.ret, subst);
    return;
  }

  // Products
  if (t1 instanceof TProd && t2 instanceof TProd) {
    const len = Math.min(t1.elements.length, t2.elements.length);
    for (let i = 0; i < len; i++) {
      unify(t1.elements[i], t2.elements[i], subst);
    }
    return;
  }

  // Coproducts
  if (t1 instanceof TSum && t2 instanceof TSum) {
    const len = Math.min(t1.variants.length, t2.variants.length);
    for (let i = 0; i < len; i++) {
      unify(t1.variants[i], t2.variants[i], subst);
    }
    return;
  }

  // Lists
  if (t1 instanceof TList && t2 instanceof TList) {
    unify(t1.elem, t2.elem, subst);
    return;
  }

  // Arrays
  if (t1 instanceof TArray && t2 instanceof TArray) {
    unify(t1.elem, t2.elem, subst);
    return;
  }

  // List ↔ Array 互換性
  if ((t1 instanceof TList && t2 instanceof TArray) || (t1 instanceof TArray && t2 instanceof TList)) {
    unify(t1.elem || t1.elem, t2.elem || t2.elem, subst);
    return;
  }

  // Address
  if (t1 instanceof TAddr && t2 instanceof TAddr) {
    unify(t1.target, t2.target, subst);
    return;
  }

  // Soft failure — 型の不一致は警告に留める
  // console.warn(`[Unify] Cannot unify: ${showType(t1)} with ${showType(t2)}`);
}
