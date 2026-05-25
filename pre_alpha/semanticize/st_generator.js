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

function formatTypeObj(node, needsParen = false) {
  if (node === undefined || node === null) return '_';

  if (typeof node === 'string') {
    // <name> のようなタグが付いている場合は外す
    if (node.startsWith('<') && node.endsWith('>')) {
      return node.slice(1, -1);
    }
    return node;
  }

  if (node.type === 'Unit') return '_';

  if (node.type === 'operation') {
    let leftStr = formatTypeObj(node.left, true);
    let rightStr = formatTypeObj(node.right, true);
    let operandStr = formatTypeObj(node.operand, true);

    let res = '';

    if (node.operator === ':') {
      res = `${formatTypeObj(node.left)} : ${formatTypeObj(node.right)}`;
    } else if (node.operator === '?') {
      res = `${leftStr} -> ${rightStr}`;
    } else if (node.operator === ' ' || node.operator === '') {
      if (node.name === 'compose') {
        res = `${leftStr} => ${rightStr}`;
      } else if (node.name === 'apply') {
        res = `${leftStr} <~ ${rightStr}`;
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
      } else if (node.position === 'prefix' || node.position === 'postfix') {
        res = operandStr; // 単項演算子はそのオペランドの型へ還元
      } else {
        res = leftStr;    // 中置演算子は左辺の型へ還元
      }
    }
    return needsParen ? `(${res})` : res;
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

/**
 * 複数のASTルートから.stファイル用のテキストを生成する
 */
export function generateST(astTrees) {
  if (!Array.isArray(astTrees)) {
    astTrees = [astTrees];
  }
  
  return astTrees
    .filter(ast => ast !== null && ast !== undefined)
    .map(ast => formatTypeObj(ast, false))
    .join('\n');
}
