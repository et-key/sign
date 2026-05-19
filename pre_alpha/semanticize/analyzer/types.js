/**
 * Sign Type IR — 型の内部表現
 * 
 * 設計原則:
 * 1. 型は不変 (immutable) — 新しい型を作って返す
 * 2. 評価状態 (holes, bound_env, lexical_env) を型に混入させない
 * 3. 各クラスが持つフィールドは最小限
 * 4. カリー化表現: (x, y) -> z は TFun(x, TFun(y, z))
 */

// ─── 型変数のID生成 ───

let _nextId = 0;
export function freshTVar() { return new TVar(_nextId++); }
export function resetTVarCounter() { _nextId = 0; }

// ─── Type IR Classes ───

/** 型変数（推論中の未知の型） */
export class TVar {
  constructor(id) { this.tag = 'TVar'; this.id = id; }
}

/** プリミティブ型 (f64, i64, string) */
export class TPrim {
  constructor(name) { this.tag = 'TPrim'; this.name = name; }
}

/** 関数型（カリー化: 1引数 → 返り値） */
export class TFun {
  constructor(param, ret) { this.tag = 'TFun'; this.param = param; this.ret = ret; }
}

/** 直積型（タプル） */
export class TProd {
  constructor(elements) { this.tag = 'TProd'; this.elements = elements; }
}

/** 直和型（coproduct / Maybe） */
export class TSum {
  constructor(variants) { this.tag = 'TSum'; this.variants = variants; }
}

/** 単位型 */
export class TUnit {
  constructor() { this.tag = 'TUnit'; }
}
export const tUnit = new TUnit();

/** リスト型（均質な無限リスト / イテレータ） */
export class TList {
  constructor(elem) { this.tag = 'TList'; this.elem = elem; }
}

/** 固定長配列型 */
export class TArray {
  constructor(elem, length) { this.tag = 'TArray'; this.elem = elem; this.length = length; }
}

/** アドレス型 ($x) */
export class TAddr {
  constructor(target) { this.tag = 'TAddr'; this.target = target; }
}

// ─── ユーティリティ ───

/**
 * カリー化された関数型を構築する
 * buildFun([a, b, c], ret) → TFun(a, TFun(b, TFun(c, ret)))
 */
export function buildFun(params, ret) {
  let t = ret;
  for (let i = params.length - 1; i >= 0; i--) {
    t = new TFun(params[i], t);
  }
  return t;
}

/**
 * カリー化された関数型からパラメータリストを抽出する
 * uncurry(TFun(a, TFun(b, ret))) → { params: [a, b], ret }
 */
export function uncurry(t) {
  const params = [];
  while (t instanceof TFun) {
    params.push(t.param);
    t = t.ret;
  }
  return { params, ret: t };
}

/**
 * 型の構造的等価性チェック
 */
export function typeEq(a, b) {
  if (a === b) return true;
  if (!a || !b) return false;
  if (a.tag !== b.tag) return false;
  
  switch (a.tag) {
    case 'TVar': return a.id === b.id;
    case 'TPrim': return a.name === b.name;
    case 'TUnit': return true;
    case 'TFun': return typeEq(a.param, b.param) && typeEq(a.ret, b.ret);
    case 'TProd': return a.elements.length === b.elements.length && a.elements.every((e, i) => typeEq(e, b.elements[i]));
    case 'TSum': return a.variants.length === b.variants.length && a.variants.every((v, i) => typeEq(v, b.variants[i]));
    case 'TList': return typeEq(a.elem, b.elem);
    case 'TArray': return a.length === b.length && typeEq(a.elem, b.elem);
    case 'TAddr': return typeEq(a.target, b.target);
    default: return false;
  }
}

/**
 * 型のデバッグ用文字列表現
 */
export function showType(t) {
  if (!t) return '?';
  switch (t.tag) {
    case 'TVar': return `?${t.id}`;
    case 'TPrim': return t.name;
    case 'TUnit': return 'unit';
    case 'TFun': {
      const { params, ret } = uncurry(t);
      return `(${params.map(showType).join(', ')}) -> ${showType(ret)}`;
    }
    case 'TProd': return t.elements.map(showType).join(' × ');
    case 'TSum': return t.variants.map(showType).join(' | ');
    case 'TList': return `List<${showType(t.elem)}>`;
    case 'TArray': return `[${showType(t.elem)}; ${t.length}]`;
    case 'TAddr': return `Addr<${showType(t.target)}>`;
    default: return '?unknown';
  }
}
