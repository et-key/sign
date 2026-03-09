
import { isUnitNode } from './util.js';

export class ASTNormalizer {
  normalize(ast) {
    if (!ast) return ast;
    if (Array.isArray(ast)) return ast.map(node => this.normalize(node));

    let node = { ...ast };

    // 空白区切り（apply/call）を 余積(infix ' ') に変換
    if (node.type === 'apply' || node.type === 'call') {
      return {
        type: 'infix',
        op: ' ',
        left: this.normalize(node.left || node.fn || node.callee),
        right: this.normalize(node.right || node.arg || node.args)
      };
    }

    if (node.type === 'block' && node.body) {
      node.body = node.body.map(n => this.normalize(n));
      return node;
    }

    if (isUnitNode(node)) {
      return { type: 'number', value: 'nan' };
    }

    if (node.type === 'identifier' || node.type === 'variable') {
      let name = node.name || node.value || node.text;
      if (!isNaN(parseFloat(name)) && isFinite(name)) {
        node.type = 'number';
        node.value = parseFloat(name);
        delete node.name;
      }
    }

    if (node.type === 'number' && typeof node.value === 'string') {
      if (node.value.startsWith('0b') || node.value.startsWith('0r')) {
        const base = node.value.startsWith('0b') ? 2 : 16;
        node.value = parseInt(node.value.slice(2), base);
      }
    }

    // 配列 [1, 2, 3] を (1 , (2 , 3)) に展開
    if (node.type === 'array' || node.type === 'list') {
      let elements = node.elements || node.items || node.value || [];
      if (elements.length === 0) return { type: 'number', value: 'nan' };
      let result = this.normalize(elements[elements.length - 1]);
      for (let i = elements.length - 2; i >= 0; i--) {
        result = { type: 'infix', op: ',', left: this.normalize(elements[i]), right: result };
      }
      return result;
    }

    ['left', 'right', 'cond', 'expr', 'argument', 'operand', 'base', 'body', 'content', 'value'].forEach(key => {
      if (node[key] && typeof node[key] === 'object') {
        if (Array.isArray(node[key])) {
          node[key] = node[key].map(n => this.normalize(n));
        } else {
          node[key] = this.normalize(node[key]);
        }
      }
    });

    return node;
  }
}