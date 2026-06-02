// 演算子の型定義（Type_System_ja-jp.md に基づく）

function isVariable(t) {
  return typeof t === 'object' && t !== null && t.type === 'Variable';
}

function resolveArithmetic(L, R) {
  // Lが未推論の変数の場合は、算術演算子であることを考慮し Number を仮定する
  if (isVariable(L)) return 'Number';
  return L;
}

function getTypeName(t) {
  if (typeof t === 'string') return t;
  if (t && typeof t === 'object') {
    if (t.type === 'Implicit' || t.type === 'Deref') return getTypeName(t.target);
    return t.type;
  }
  return null;
}

export const OPERATOR_TYPES = {
  // --- 前置演算子 ---
  'prefix_#': (R) => ({ type: 'Implicit', target: R }),
  'prefix_##': (R) => ({ type: 'Implicit', target: R }),
  'prefix_###': (R) => ({ type: 'Implicit', target: R }),
  'prefix_~': (R) => {
    return getTypeName(R) === 'List' ? { type: 'Implicit', target: 'List' } : { type: 'Unit' };
  },
  'prefix_!': (R) => R,
  'prefix_$': (R) => {
    return getTypeName(R) === 'Lambda' ? { type: 'Implicit', target: 'Lambda' } : { type: 'Unit' };
  },
  'prefix_@': (R) => {
    if (typeof R === 'object' && R?.type === 'Implicit' && getTypeName(R) === 'Lambda') {
      return { type: 'Deref', target: R };
    }
    return { type: 'Unit' };
  },
  'prefix_!!': (R) => 'Scalar',
  'prefix_-': (R) => R,

  // --- 後置演算子 ---
  'postfix_!': (L) => getTypeName(L) === 'Number' || isVariable(L) ? 'Number' : { type: 'Unit' },
  'postfix_~': (L) => {
    if (typeof L === 'object' && L?.type === 'Implicit') {
      const tName = getTypeName(L);
      if (tName === 'List' || tName === 'Dictionary' || tName === 'Atom' || tName === 'String' || tName === 'Number') {
        return { type: 'Deref', target: L.target };
      }
    }
    return { type: 'Unit' };
  },
  'postfix_@': (L) => {
    if (typeof L === 'object' && L?.type === 'Implicit' && getTypeName(L) === 'Dictionary') {
      return { type: 'Deref', target: L };
    }
    return { type: 'Unit' };
  },

  // --- 中置演算子 ---
  ':': (L, R) => R,
  '?': (L, R) => getTypeName(L) === 'List' ? { type: 'Lambda', returns: R } : { type: 'Unit' },
  '#': (L, R) => getTypeName(L) === 'Address' ? 'Address' : { type: 'Unit' },
  ';': (L, R) => L,
  '|': (L, R) => L,
  '&': (L, R) => L,
  '==': (L, R) => L,
  '!==': (L, R) => L,
  ',': (L, R) => ({ type: 'List', elements: [L, R] }),
  // 空白演算子（coproduct_resolver で解決された後の名前を使用）
  'concat': (L, R) => ({ type: 'List', elements: [L, R] }),
  'compose': (L, R) => ({ type: 'Lambda', returns: L?.returns || { type: 'Compose', left: L, right: R } }),
  'apply': (L, R) => L?.returns || { type: 'Apply', left: L, right: R },
  'apply_reverse': (L, R) => R?.returns || { type: 'Apply', left: R, right: L },
  '~': (L, R) => 'Scalar',
  '~-': (L, R) => 'Scalar',
  '~+': (L, R) => 'Scalar',
  '~*': (L, R) => 'Scalar',
  '~/': (L, R) => 'Scalar',
  '~^': (L, R) => 'Scalar',
  '<': (L, R) => L,
  '<=': (L, R) => L,
  '=': (L, R) => L,
  '>=': (L, R) => L,
  '>': (L, R) => L,
  '!=': (L, R) => L,
  '+': resolveArithmetic,
  '-': resolveArithmetic,
  '*': resolveArithmetic,
  '/': resolveArithmetic,
  '%': resolveArithmetic,
  '^': resolveArithmetic,
  '|...|': (L, R) => L,
  "'": (L, R) => ({ type: 'Deref', target: R }),
  '@': (L, R) => ({ type: 'Deref', target: L }),
  '<<': (L, R) => (getTypeName(L) === 'Address' || getTypeName(L) === 'Register') ? L : { type: 'Unit' },
  '>>': (L, R) => (getTypeName(L) === 'Address' || getTypeName(L) === 'Register') ? L : { type: 'Unit' },
  '||': (L, R) => (getTypeName(L) === 'Address' || getTypeName(L) === 'Register') ? L : { type: 'Unit' },
  ';;': (L, R) => (getTypeName(L) === 'Address' || getTypeName(L) === 'Register') ? L : { type: 'Unit' },
  '&&': (L, R) => (getTypeName(L) === 'Address' || getTypeName(L) === 'Register') ? L : { type: 'Unit' },
};
