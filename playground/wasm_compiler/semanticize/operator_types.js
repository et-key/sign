// 演算子の型定義（Type_System_ja-jp.md に基づく）

function isVariable(t) {
  return typeof t === 'object' && t !== null && t.type === 'Variable';
}

function resolveArithmetic(L, R) {
  // Lが未推論の変数の場合は、算術演算子であることを考慮し Number を仮定する
  if (isVariable(L)) return 'Number';
  return L;
}

export const OPERATOR_TYPES = {
  // --- 前置演算子 ---
  'prefix_#': (R) => R,
  'prefix_##': (R) => R,
  'prefix_###': (R) => R,
  'prefix_~': (R) => ({ type: 'Implicit', target: 'List' }),
  'prefix_!': (R) => R,
  'prefix_$': (R) => ({ type: 'Implicit', target: 'Lambda' }),
  'prefix_@': (R) => ({ type: 'Deref', target: R }),
  'prefix_!!': (R) => 'Scalar',
  'prefix_-': (R) => R,

  // --- 後置演算子 ---
  'postfix_!': (L) => 'Number',
  'postfix_~': (L) => ({ type: 'List' }),
  'postfix_@': (L) => ({ type: 'Lambda' }),

  // --- 中置演算子 ---
  ':': (L, R) => R,
  '?': (L, R) => ({ type: 'Lambda', returns: R }),
  '#': (L, R) => (L === 'Address' ? 'Address' : L),
  ';': (L, R) => L,
  '|': (L, R) => L,
  '&': (L, R) => L,
  '==': (L, R) => L,
  '!==': (L, R) => L,
  ',': (L, R) => ({ type: 'List', elements: [L, R] }),
  // 空白演算子（coproduct_resolver で解決された後の名前を使用）
  'concat': (L, R) => ({ type: 'List', elements: [L, R] }),
  'compose': (L, R) => ({ type: 'Lambda', returns: L?.returns || { type: 'Compose', left: L, right: R } }),
  'apply': (L, R) => {
    // LがLambdaであればその戻り値型、未知なら型の適用（関手の適用）そのものを型とする
    return L?.returns || { type: 'Apply', left: L, right: R };
  },
  'apply_reverse': (L, R) => {
    // RがLambdaであればその戻り値型、未知なら型の適用そのものを型とする
    return R?.returns || { type: 'Apply', left: R, right: L };
  },
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
  '<<': (L, R) => 'Scalar',
  '>>': (L, R) => 'Scalar',
  '||': (L, R) => 'Scalar',
  ';;': (L, R) => 'Scalar',
  '&&': (L, R) => 'Scalar',
};
