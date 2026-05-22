/**
 * types.js
 * Sign Language Type System - Types, Unification, and Substitutions
 */

let tvarIdCounter = 0;
export function resetTVarCounter() {
  tvarIdCounter = 0;
}

export class TVar {
  constructor(name = null) {
    this.name = name || `T${tvarIdCounter++}`;
  }
  toString() {
    return this.name;
  }
  clone(tvarMap = new Map()) {
    if (tvarMap.has(this)) return tvarMap.get(this);
    const newTVar = new TVar(this.name); // keep the hint name, but new instance
    tvarMap.set(this, newTVar);
    return newTVar;
  }
}

export class TFunc {
  constructor(paramType, returnType) {
    this.paramType = paramType;
    this.returnType = returnType;
  }
  toString() {
    return `(${this.paramType.toString()} -> ${this.returnType.toString()})`;
  }
  clone(tvarMap = new Map()) {
    return new TFunc(this.paramType.clone(tvarMap), this.returnType.clone(tvarMap));
  }
}

export class TTuple {
  constructor(types) {
    this.types = types;
  }
  toString() {
    return `Tuple(${this.types.map(t => t.toString()).join(', ')})`;
  }
  clone(tvarMap = new Map()) {
    return new TTuple(this.types.map(t => t.clone(tvarMap)));
  }
}

export class TVariadic {
  constructor(type) {
    this.type = type;
  }
  toString() {
    return `~${this.type.toString()}`;
  }
  clone(tvarMap = new Map()) {
    return new TVariadic(this.type.clone(tvarMap));
  }
}


export class TAtom {
  constructor(name) {
    this.name = name;
  }
  toString() {
    return this.name;
  }
  clone(tvarMap = new Map()) {
    return this; // Atoms are constant, no need to clone
  }
}

export class THole {
  toString() {
    return '_';
  }
  clone(tvarMap = new Map()) {
    return new THole();
  }
}

export class TUnion {
  constructor(types) {
    const flatTypes = [];
    for (const t of types) {
      if (t instanceof TUnion) {
        flatTypes.push(...t.types);
      } else {
        flatTypes.push(t);
      }
    }
    // Deduplicate by string representation
    const seen = new Set();
    this.types = [];
    for (const t of flatTypes) {
      const s = t.toString();
      if (!seen.has(s)) {
        seen.add(s);
        this.types.push(t);
      }
    }
  }
  toString() {
    return this.types.map(t => t.toString()).join(' | ');
  }
  clone(tvarMap = new Map()) {
    return new TUnion(this.types.map(t => t.clone(tvarMap)));
  }
}

export class Substitution {
  constructor(map = new Map()) {
    this.map = map;
  }

  clone() {
    return new Substitution(new Map(this.map));
  }

  rollback(snapshot) {
    this.map = new Map(snapshot.map);
  }

  apply(type) {
    if (!type) return type;
    if (type instanceof TVar) {
      if (this.map.has(type.name)) {
        return this.apply(this.map.get(type.name));
      }
      return type;
    }
    if (type instanceof TFunc) {
      return new TFunc(this.apply(type.paramType), this.apply(type.returnType));
    }
    if (type instanceof TTuple) {
      return new TTuple(type.types.map(t => this.apply(t)));
    }
    if (type instanceof TUnion) {
      return new TUnion(type.types.map(t => this.apply(t)));
    }
    return type;
  }

  compose(otherSubst) {
    for (const [key, val] of this.map.entries()) {
      this.map.set(key, otherSubst.apply(val));
    }
    for (const [key, val] of otherSubst.map.entries()) {
      if (!this.map.has(key)) {
        this.map.set(key, val);
      }
    }
  }

  bind(tvar, type) {
    if (type instanceof TVar && tvar.name === type.name) {
      return true; // T = T
    }
    if (this.occursCheck(tvar, type)) {
      return false; // Occurs check failed
    }
    this.map.set(tvar.name, type);
    return true;
  }

  occursCheck(tvar, type) {
    const appliedType = this.apply(type);
    if (appliedType instanceof TVar) {
      return appliedType.name === tvar.name;
    }
    if (appliedType instanceof TFunc) {
      return this.occursCheck(tvar, appliedType.paramType) || this.occursCheck(tvar, appliedType.returnType);
    }
    if (appliedType instanceof TTuple || appliedType instanceof TUnion) {
      return appliedType.types.some(t => this.occursCheck(tvar, t));
    }
    if (appliedType instanceof TVariadic) {
      return this.occursCheck(tvar, appliedType.type);
    }
    return false;
  }
}

export function unify(t1, t2, subst) {
  t1 = subst.apply(t1);
  t2 = subst.apply(t2);

  if (t1 instanceof TVar) {
    return subst.bind(t1, t2);
  }
  if (t2 instanceof TVar) {
    return subst.bind(t2, t1);
  }
  
  if (t1 instanceof TFunc && t2 instanceof TFunc) {
    return unify(t1.paramType, t2.paramType, subst) && unify(t1.returnType, t2.returnType, subst);
  }

  if (t1 instanceof TTuple && t2 instanceof TTuple) {
    if (t1.types.length !== t2.types.length) return false;
    for (let i = 0; i < t1.types.length; i++) {
      if (!unify(t1.types[i], t2.types[i], subst)) return false;
    }
    return true;
  }

  if (t1 instanceof TUnion && t2 instanceof TUnion) {
    if (t1.types.length !== t2.types.length) return false;
    // Order-independent subset check using string representation
    const s1 = new Set(t1.types.map(t => t.toString()));
    const s2 = new Set(t2.types.map(t => t.toString()));
    for (const s of s1) {
      if (!s2.has(s)) return false;
    }
    return true;
  }

  if (t1 instanceof TVariadic && t2 instanceof TVariadic) {
    return unify(t1.type, t2.type, subst);
  }

  if (t1 instanceof TAtom && t2 instanceof TAtom) {
    return t1.name === t2.name;
  }

  return false;
}
