import { isUnitNode } from './util.js';

export class ASTNormalizer {
  extractFoldOp(funcNode) {
    if (funcNode && funcNode.type === 'infix' && funcNode.op === '?') {
      if (funcNode.right && funcNode.right.type === 'infix' && funcNode.right.op === '?') {
        if (funcNode.right.right && funcNode.right.right.type === 'infix') {
          return funcNode.right.right.op;
        }
      }
    }
    return null;
  }

  extractMapLambda(funcNode) {
    if (funcNode && funcNode.type === 'infix' && funcNode.op === '?') {
      if (!(funcNode.right && funcNode.right.type === 'infix' && funcNode.right.op === '?')) {
        let cleanFunc = JSON.parse(JSON.stringify(funcNode));
        let innerBody = cleanFunc.right;
        if (innerBody && innerBody.type === 'infix') {
          let innerRight = innerBody.right;
          if (innerRight && innerRight.type === 'infix' && innerRight.op === ',') {
            if (isUnitNode(innerRight.right) || (innerRight.right && innerRight.right.value === 'nan')) {
              innerBody.right = innerRight.left;
            }
          }
        }
        return cleanFunc;
      }
    }
    return null;
  }

  flattenApply(node) {
    let args = [];
    let current = node;
    while (current && (current.type === 'apply' || current.type === 'call')) {
      args.unshift(current.arg || current.args || current.right);
      current = current.func || current.fn || current.callee || current.left;
    }
    return { func: current, args: args };
  }

  // ⚡ 追加: isDictContext フラグにより、自分が辞書の中にいるかを判定する
  normalize(ast, isDictContext = false) {
    if (!ast) return ast;
    if (Array.isArray(ast)) return ast.map(node => this.normalize(node, isDictContext));

    let node = { ...ast };

    // ==========================================
    // ⚡ 中置 ' (get) の正規化: 右辺の識別子を文字列にキャスト
    // ==========================================
    if (node.type === 'infix' && node.op === "'") {
      // ❌ 右辺の強制文字列キャストを廃止！
      // これにより、変数(動的キー)やリスト構造をキーとしてWASMに渡せるようになります。
      return {
        type: 'infix',
        op: "'",
        left: this.normalize(node.left, false),
        right: this.normalize(node.right, false)
      };
    }

    // ==========================================
    // ⚡ 辞書型の平坦化 (賢いコンテキストスイッチ)
    // ==========================================
    if (node.type === 'infix' && node.op === ':') {
      let rightNode;

      // 右辺がブロックの場合、そのブロック内は「辞書コンテキスト」として処理する！
      if (node.right && node.right.type === 'block') {
        let body = node.right.body || [];
        if (body.length === 0) {
          rightNode = { type: 'number', value: 'nan' };
        } else {
          let listNode = { type: 'number', value: 'nan' };
          for (let i = body.length - 1; i >= 0; i--) {
            // ブロック内の要素は isDictContext = true として再帰
            let elem = this.normalize(body[i], true);
            listNode = { type: 'infix', op: ',', left: elem, right: listNode };
          }
          rightNode = listNode;
        }
      } else {
        rightNode = this.normalize(node.right, false);
      }

      // 自分が辞書の中にいる場合だけ、: をペア(,)に変換する
      if (isDictContext) {
        let keyNode = node.left;
        if (keyNode && (keyNode.type === 'identifier' || keyNode.type === 'variable')) {
          let keyStr = keyNode.name || keyNode.value || keyNode.text;
          keyNode = { type: 'string', value: '`' + keyStr + '`' };
        }
        return {
          type: 'infix',
          op: ',',
          left: this.normalize(keyNode, false),
          right: rightNode
        };
      } else {
        // トップレベルの代入は : のまま残す！(WASMで local.set される)
        return {
          type: 'infix',
          op: ':',
          left: this.normalize(node.left, false),
          right: rightNode
        };
      }
    }

    // ==========================================
    // Fold / Map の正規化
    // ==========================================
    if (node.type === 'apply' || node.type === 'call') {
      let f = node.func || node.fn || node.callee || node.left;
      let a = node.arg || node.args || node.right;

      // ⚡ [修正] パーサーが [ ] を Unit + Block として出力したものを検知
      if (f && (f.type === 'unit' || (f.type === 'identifier' && f.value === 'Unit') || f.value === 'nan') && a && a.type === 'block') {
        let body = a.body || [];
        if (body.length === 0) return { type: 'number', value: 'nan' };

        let listNode = { type: 'number', value: 'nan' };
        for (let i = body.length - 1; i >= 0; i--) {
          // ブロック内を辞書コンテキスト(true)としてコンスセルの連鎖に変換
          let elem = this.normalize(body[i], true);
          listNode = { type: 'infix', op: ',', left: elem, right: listNode };
        }
        return listNode;
      }

      let flattened = this.flattenApply(node);
      let func = flattened.func;
      let args = flattened.args;

      let foldOp = this.extractFoldOp(func);
      if (foldOp && args.length >= 2) {
        let result = this.normalize(args[0], false);
        for (let i = 1; i < args.length; i++) {
          result = { type: 'infix', op: foldOp, left: result, right: this.normalize(args[i], false) };
        }
        return result;
      }

      let mapLambda = this.extractMapLambda(func);
      if (mapLambda && args.length >= 2) {
        let result = { type: 'number', value: 'nan' };
        for (let i = args.length - 1; i >= 0; i--) {
          let applyNode = {
            type: 'infix',
            op: ' ',
            left: this.normalize(mapLambda, false),
            right: this.normalize(args[i], false)
          };
          result = { type: 'infix', op: ',', left: applyNode, right: result };
        }
        return result;
      }

      return {
        type: 'infix',
        op: ' ',
        left: this.normalize(node.func || node.fn || node.callee || node.left, false),
        right: this.normalize(node.arg || node.args || node.right, false)
      };
    }

    // ==========================================
    // その他のノードの正規化
    // ==========================================
    if (node.type === 'block' && node.body) {
      node.body = node.body.map(n => this.normalize(n, false));
      return node;
    }

    if (isUnitNode(node)) {
      return { type: 'number', value: 'nan' };
    }

    if (node.type === 'char' || node.type === 'char_literal' || node.type === 'character') {
      if (typeof node.value === 'string') {
        let val = node.value;
        if (val.startsWith('0u')) {
          return { type: 'char', value: parseInt(val.slice(2), 16) };
        } else if (val.startsWith('\\')) {
          return { type: 'char', value: val.charCodeAt(1) };
        } else {
          return { type: 'char', value: val.charCodeAt(0) };
        }
      }
      return node;
    }

    if (node.type === 'prefix' && node.op === '\\') {
      let charStr = node.right.name || node.right.value || node.right.text || '';
      return { type: 'char', value: String(charStr).charCodeAt(0) };
    }

    if (node.type === 'identifier' || node.type === 'variable') {
      let name = node.name || node.value || node.text;
      if (typeof name === 'string' && name.startsWith('0u')) {
        return { type: 'char', value: parseInt(name.slice(2), 16) };
      }
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
      } else if (node.value.startsWith('0u')) {
        return { type: 'char', value: parseInt(node.value.slice(2), 16) };
      }
    }

    // ==========================================
    // 1. 配列(ブロック)の正規化処理
    // ==========================================
    if (node.type === 'array' || node.type === 'list') {
      let elements = node.elements || node.items || node.value || [];
      if (elements.length === 0) return { type: 'number', value: 'nan' };
      let result = this.normalize(elements[elements.length - 1], false);
      for (let i = elements.length - 2; i >= 0; i--) {
        // ⚡ 修正: 'infix', op: ',' ではなく専用の 'BlockSeq' にする！
        result = { type: 'BlockSeq', left: this.normalize(elements[i], false), right: result };
      }
      return result;
    }

    ['left', 'right', 'cond', 'expr', 'argument', 'operand', 'base', 'body', 'content', 'value'].forEach(key => {
      if (node[key] && typeof node[key] === 'object') {
        if (Array.isArray(node[key])) {
          node[key] = node[key].map(n => this.normalize(n, false));
        } else {
          node[key] = this.normalize(node[key], false);
        }
      }
    });

    // ==========================================
    // 静的ディスパッチ処理
    // ==========================================
    this.inferType(node);

    // ⚡ ブロック由来の ProductNode の副作用チェック
    if (node.type === 'ProductNode') {
      const leftType = node.left?.inferredType || { type: 'Unknown' };
      if (leftType.type === 'SideEffect' || node.left?.op === '#') {
        node.type = 'SequenceNode';
        node.inferredType = node.right?.inferredType || { type: 'Unknown' };
        // 末尾の不要なnanを剥がす
        if (node.right && node.right.type === 'ProductNode' && node.right.right &&
          (node.right.right.value === 'nan' || node.right.right.name === 'nan')) {
          node.right = node.right.left;
        }
      } else {
        node.inferredType = { type: 'List' };
      }
    }

    // ⚡ 空白とリテラルカンマのディスパッチ
    if (node.type === 'infix') {
      const leftType = node.left?.inferredType || { type: 'Unknown' };
      const rightType = node.right?.inferredType || { type: 'Unknown' };

      if (node.op === ' ') {
        if (leftType.type === 'SideEffect' || node.left?.op === '#') {
          node.type = 'SequenceNode';
          node.inferredType = rightType;
        } else if (leftType.type === 'Function') {
          if (rightType.type === 'Function') {
            node.type = 'ComposeNode';
            node.inferredType = { type: 'Function' };
          } else {
            node.type = 'ApplyNode';
            node.inferredType = { type: 'Unknown' };
          }
        } else {
          node.type = 'ProductNode';
          node.inferredType = { type: 'List' };
        }
      }
      else if (node.op === ',') {
        if (leftType.type === 'SideEffect' || node.left?.op === '#') {
          node.type = 'SequenceNode';
          node.inferredType = rightType;
        } else {
          // ⚡ リテラルのカンマは両方持ち上げ専用の 'CommaNode' にする！
          node.type = 'CommaNode';
          node.inferredType = { type: 'List' };
        }
      }
    }
    return node;
  }

  // ⚡ 追加: 簡易的な型推論ヘルパー
  inferType(node) {
    if (node.inferredType) return;

    switch (node.type) {
      case 'number': node.inferredType = { type: 'Float' }; break;
      case 'string': node.inferredType = { type: 'String' }; break;
      case 'char': node.inferredType = { type: 'Char' }; break;
      case 'infix':
        if (node.op === '?') node.inferredType = { type: 'Function' };
        else if (node.op === '#') node.inferredType = { type: 'SideEffect' }; // Prism更新は副作用！
        else if (node.op === ':') node.inferredType = { type: 'Pair' };
        else if (['+', '-', '*', '/'].includes(node.op)) node.inferredType = { type: 'Float' };
        break;
      case 'prefix':
        if (node.op === '$') node.inferredType = { type: 'Pointer' };
        else if (node.op === '~') node.inferredType = { type: 'List' };
        break;
      case 'ProductNode': node.inferredType = { type: 'List' }; break;
      case 'ApplyNode': node.inferredType = { type: 'Unknown' }; break;
      case 'SequenceNode': node.inferredType = node.right?.inferredType || { type: 'Unknown' }; break;
    }
    // 推論できない場合は Unknown を設定
    if (!node.inferredType) node.inferredType = { type: 'Unknown' };
  }
}