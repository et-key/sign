/**
 * st_generator.js
 * 
 * 評価済みの抽象構文木（AST）から、静的に解決できる型シグネチャを抽出して
 * 型記述ファイル (*.st) 向けの文字列を生成します。
 * 
 * フォーマット規則:
 * typedef: Left : Right
 * 関数: Left -> Right
 * compose: Left => Right
 * Apply: Left <= Right
 * Concat: Left <> Right
 * 逆適用: Left ~> Right
 */

/**
 * 演算子の優先順位と結合性を定義
 */
function getPrecedenceInfo(node) {
  if (node === undefined || node === null) return { prec: 1000, assoc: 'none' };
  if (typeof node === 'string') return { prec: 1000, assoc: 'none' };
  if (node.type === 'Unit') return { prec: 1000, assoc: 'none' };
  if (node.type === 'block' || node.type === 'coproduct_block' || node.type === 'expanded_dict') return { prec: 1000, assoc: 'none' };

  if (node.type === 'operation') {
    if (node.operator === ':') return { prec: 10, assoc: 'right' };
    if (node.operator === '?') return { prec: 20, assoc: 'right' };
    if (node.operator === ' ' || node.operator === '') {
      if (node.name === 'apply_reverse') return { prec: 30, assoc: 'left' };
      if (node.name === 'apply') return { prec: 40, assoc: 'left' };
      if (node.name === 'compose') return { prec: 50, assoc: 'left' };
      if (node.name === 'concat') return { prec: 60, assoc: 'left' };
    }
    if (node.operator === '|') return { prec: 70, assoc: 'left' };
    if (node.operator === ',') return { prec: 80, assoc: 'left' };
    
    // SNファイル固有の演算子は還元先の優先度を引き継ぐ
    if (node.position === 'prefix' || node.position === 'postfix') {
      return getPrecedenceInfo(node.operand);
    } else {
      return getPrecedenceInfo(node.left);
    }
  }
  return { prec: 1000, assoc: 'none' };
}

let tvarNameCounter = 0;
const tvarNameMap = new Map();

function getTVarName(id) {
  if (tvarNameMap.has(id)) return tvarNameMap.get(id);
  const name = String.fromCharCode(97 + (tvarNameCounter % 26)) + (tvarNameCounter >= 26 ? Math.floor(tvarNameCounter / 26) : '');
  tvarNameCounter++;
  tvarNameMap.set(id, `'${name}`);
  return tvarNameMap.get(id);
}

export function resetTVarFormatter() {
  tvarNameCounter = 0;
  tvarNameMap.clear();
}

export function formatTypeObj(node) {
  if (node === undefined || node === null) return 'Unknown';

  if (typeof node === 'string') {
    // <name> のようなタグが付いている場合は外す
    if (node.startsWith('<') && node.endsWith('>')) {
      return node.slice(1, -1);
    }
    return node;
  }

  if (node.type === 'cyclic_flag') {
    return `<?cyclic_${node.id}?>`;
  }

  if (node.type === 'tvar') {
    return getTVarName(node.id);
  }

  if (node.type === 'Unit') return '_';

  if (node.type === 'Func') {
    let fromStr = formatTypeObj(node.from);
    let toStr = formatTypeObj(node.to);
    
    // Parenthesize the from side if it is also a Func
    if (node.from && node.from.type === 'Func') {
      fromStr = `(${fromStr})`;
    }
    
    return `${fromStr} -> ${toStr}`;
  }

  if (node.type === 'operation') {
    let currentInfo = getPrecedenceInfo(node);
    
    let leftNeedsParen = false;
    let rightNeedsParen = false;

    if (node.left !== undefined) {
      let leftInfo = getPrecedenceInfo(node.left);
      if (leftInfo.prec < currentInfo.prec) leftNeedsParen = true;
      else if (leftInfo.prec === currentInfo.prec && currentInfo.assoc === 'right') leftNeedsParen = true;
    }
    if (node.right !== undefined) {
      let rightInfo = getPrecedenceInfo(node.right);
      if (rightInfo.prec < currentInfo.prec) rightNeedsParen = true;
      else if (rightInfo.prec === currentInfo.prec && currentInfo.assoc === 'left') rightNeedsParen = true;
    }

    let leftStr = node.left !== undefined ? formatTypeObj(node.left) : '';
    let rightStr = node.right !== undefined ? formatTypeObj(node.right) : '';
    let operandStr = node.operand !== undefined ? formatTypeObj(node.operand) : '';

    if (leftNeedsParen) leftStr = `(${leftStr})`;
    if (rightNeedsParen) rightStr = `(${rightStr})`;

    let res = '';

    if (node.operator === ':') {
      res = `${leftStr} : ${rightStr}`;
    } else if (node.operator === '?') {
      res = `${leftStr} -> ${rightStr}`;
    } else if (node.operator === ' ' || node.operator === '') {
      if (node.name === 'compose') {
        res = `${leftStr} => ${rightStr}`;
      } else if (node.name === 'apply') {
        res = `${leftStr} <= ${rightStr}`;
      } else if (node.name === 'apply_reverse') {
        res = `${leftStr} ~> ${rightStr}`;
      } else if (node.name === 'concat') {
        res = `${leftStr} <> ${rightStr}`;
      } else {
        // 未知の空白演算子のフォールバック
        res = `${leftStr} ${rightStr}`;
      }
    } else {
      // 構造的ではない生の演算子（+や*、接頭辞/接尾辞など）は型へ還元する
      if (node.operator === '|') {
        res = `${leftStr} | ${rightStr}`;
      } else if (node.operator === ',') {
        res = `${leftStr} , ${rightStr}`;
      } else if (node.position === 'prefix') {
        res = `${node.operator}${operandStr}`;
      } else if (node.position === 'postfix') {
        res = `${operandStr}${node.operator}`;
      } else {
        res = leftStr;    // 中置演算子は左辺の型へ還元
      }
    }
    return res;
  }

  if (node.type === 'block') {
    let contentStr = '';
    if (Array.isArray(node.content)) {
      contentStr = node.content.map(c => formatTypeObj(c)).join(' ');
    } else {
      contentStr = formatTypeObj(node.content);
    }

    if (node.kind === 'paren' || node.kind === 'group') return `(${contentStr})`;
    if (node.kind === 'bracket') return `[${contentStr}]`;
    if (node.kind === 'brace') return `{${contentStr}}`;
    if (node.kind === 'indent' || node.kind === 'abs') {
      return `\n  ${contentStr.split('\n').join('\n  ')}`;
    }
    return contentStr;
  }

  if (node.type === 'coproduct_block' && Array.isArray(node.statements)) {
    // Statements are usually separated by newlines in the original source,
    // but represented as coproduct_block.
    return node.statements.map(s => formatTypeObj(s)).join(' ; ');
  }

  if (node.type === 'expanded_dict') {
    return `${formatTypeObj(node.dict)}~`;
  }

  return JSON.stringify(node);
}

export function generateST(astTrees) {
  if (!Array.isArray(astTrees)) {
    astTrees = [astTrees];
  }
  
  resetTVarFormatter();

  return astTrees
    .filter(ast => ast !== null && ast !== undefined)
    .map(ast => formatTypeObj(ast))
    .join('\n');
}
