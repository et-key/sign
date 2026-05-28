import { OPERATOR_TYPES } from './operator_types.js';

/**
 * 圏論的アプローチに基づくボトムアップ型評価器
 * ASTを下から上（左から右）へ辿り、演算子の型シグネチャを適用するだけで型を決定する。
 */
export function evaluateType(node, env = new Map()) {
  if (!node) return { type: 'Unit' };

  if (Array.isArray(node)) {
    const types = node.map(n => evaluateType(n, env));
    return types.length > 0 ? types[types.length - 1] : { type: 'Unit' };
  }

  if (typeof node === 'string') {
    if (!isNaN(node) || node.startsWith('0x')) return 'Number';
    if (node.startsWith('`') || node.startsWith('"')) return 'String';
    
    // 環境に存在する場合はその型を返す
    if (env.has(node)) return env.get(node);
    
    // 未定義の変数は推論用の変数として扱う（TVarではなく、単なるプレースホルダー）
    return { type: 'Variable', name: node };
  }

  if (node.type === 'Lambda') {
    // 評価済みのLambdaノードの場合、bodyの型をreturnsとする
    const bodyType = evaluateType(node.body, env);
    return { type: 'Lambda', returns: bodyType };
  }

  if (node.type === 'coproduct_block') {
    if (Array.isArray(node.statements)) {
      const types = node.statements.map(s => evaluateType(s, env));
      return types.length > 0 ? types[types.length - 1] : { type: 'Unit' };
    }
    return evaluateType(node.statements, env);
  }

  if (node.type === 'block') {
    // 括弧類の中身を評価
    return evaluateType(node.content, env);
  }

  if (node.type === 'operation') {
    let typeFn;
    
    // 前置演算子の型解決
    if (node.position === 'prefix') {
      typeFn = OPERATOR_TYPES[`prefix_${node.operator}`];
      const operandType = evaluateType(node.operand, env);
      if (typeFn) return typeFn(operandType);
      return operandType; // 未定義の場合はそのまま伝搬
    } 
    // 後置演算子の型解決
    else if (node.position === 'postfix') {
      typeFn = OPERATOR_TYPES[`postfix_${node.operator}`];
      const operandType = evaluateType(node.operand, env);
      if (typeFn) return typeFn(operandType);
      return operandType;
    } 
    // 中置演算子の型解決
    else {
      // `:` 演算子の場合は特別な環境の更新を行う (L : R)
      if (node.operator === ':') {
        const rightType = evaluateType(node.right, env);
        if (typeof node.left === 'string') {
          // 左辺が識別子の場合は環境に型を登録
          env.set(node.left, rightType);
        }
        typeFn = OPERATOR_TYPES[':'];
        return typeFn ? typeFn(null, rightType) : rightType;
      }

      // その他の中置演算子は、左右の型を評価して型関数に適用するだけ
      const leftType = evaluateType(node.left, env);
      const rightType = evaluateType(node.right, env);
      
      const opKey = node.operator === ' ' ? node.name : node.operator;
      typeFn = OPERATOR_TYPES[opKey];
      if (typeFn) return typeFn(leftType, rightType);
      
      // 未定義演算子のフォールバックは左辺の型
      return leftType;
    }
  }

  return { type: 'Unknown' };
}
