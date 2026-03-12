import { isUnitNode } from './util.js';

export class ASTNormalizer {
  // ⚡ ヘルパー1: [OP] マクロによって生成された「2引数のラムダ」から演算子を抽出する
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

  // ⚡ ヘルパー2: Map用の「1引数ラムダ」を抽出し、余分な末尾カンマがあれば除去する
  extractMapLambda(funcNode) {
    if (funcNode && funcNode.type === 'infix' && funcNode.op === '?') {
      // 内部がさらにラムダでないこと（カリー化された2引数関数ではないこと）
      if (!(funcNode.right && funcNode.right.type === 'infix' && funcNode.right.op === '?')) {

        let cleanFunc = JSON.parse(JSON.stringify(funcNode)); // 安全に変更するためのコピー
        let innerBody = cleanFunc.right;

        // [* 2,] のように、右オペランドが `,(値, unit)` になっている場合、カンマを剥がす
        if (innerBody && innerBody.type === 'infix') {
          let innerRight = innerBody.right;
          if (innerRight && innerRight.type === 'infix' && innerRight.op === ',') {
            if (isUnitNode(innerRight.right) || (innerRight.right && innerRight.right.value === 'nan')) {
              innerBody.right = innerRight.left; // カンマを剥がして純粋な値(2)だけにする
            }
          }
        }
        return cleanFunc;
      }
    }
    return null;
  }

  // ⚡ ヘルパー3: 左結合の apply の連鎖をフラットな配列に分解する
  flattenApply(node) {
    let args = [];
    let current = node;
    while (current && (current.type === 'apply' || current.type === 'call')) {
      args.unshift(current.arg || current.args || current.right);
      current = current.func || current.fn || current.callee || current.left;
    }
    return { func: current, args: args };
  }

  normalize(ast) {
    if (!ast) return ast;
    if (Array.isArray(ast)) return ast.map(node => this.normalize(node));

    let node = { ...ast };

    // ==========================================
    // ⚡ 辞書型の平坦化 (a : b) -> ( "a" , b )
    // ==========================================
    if (node.type === 'infix' && node.op === ':') {
      let keyNode = node.left;
      if (keyNode && (keyNode.type === 'identifier' || keyNode.type === 'variable')) {
        let keyStr = keyNode.name || keyNode.value || keyNode.text;
        keyNode = { type: 'string', value: '`' + keyStr + '`' };
      }

      let rightNode = this.normalize(node.right);

      if (rightNode && rightNode.type === 'block') {
        let body = rightNode.body || [];
        if (body.length === 0) {
          rightNode = { type: 'number', value: 'nan' };
        } else {
          let listNode = { type: 'number', value: 'nan' };
          for (let i = body.length - 1; i >= 0; i--) {
            listNode = { type: 'infix', op: ',', left: body[i], right: listNode };
          }
          rightNode = listNode;
        }
      }

      return {
        type: 'infix',
        op: ',',
        left: this.normalize(keyNode),
        right: rightNode
      };
    }

    // ==========================================
    // ⚡ 空白区切り（apply）のFold/Map検知と正規化
    // ==========================================
    if (node.type === 'apply' || node.type === 'call') {
      let flattened = this.flattenApply(node);
      let func = flattened.func;
      let args = flattened.args;

      // 1. Fold (畳み込み) の検知
      let foldOp = this.extractFoldOp(func);
      if (foldOp && args.length >= 2) {
        let result = this.normalize(args[0]);
        for (let i = 1; i < args.length; i++) {
          result = { type: 'infix', op: foldOp, left: result, right: this.normalize(args[i]) };
        }
        return result;
      }

      // 2. Map (写像) の検知 (⚡ ここを修正)
      let mapLambda = this.extractMapLambda(func);
      if (mapLambda && args.length >= 2) {
        let result = { type: 'number', value: 'nan' }; // 終端
        for (let i = args.length - 1; i >= 0; i--) {
          let applyNode = {
            type: 'infix',
            op: ' ',
            left: this.normalize(mapLambda), // クリーンになった関数を適用
            right: this.normalize(args[i])
          };
          result = { type: 'infix', op: ',', left: applyNode, right: result };
        }
        return result;
      }

      // 3. 通常の適用 (余積 ' ') へのフォールバック
      return {
        type: 'infix',
        op: ' ',
        left: this.normalize(node.func || node.fn || node.callee || node.left),
        right: this.normalize(node.arg || node.args || node.right)
      };
    }

    // ==========================================
    // 以降は元のままの正規化処理
    // ==========================================
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

    // ==========================================
    // ⚡ 文字型 (\a または 0u00f0) の完全な正規化
    // ==========================================

    // ケース1: 既に "char" ノードとしてパースされている場合 (値が文字列 "a" など)
    if (node.type === 'char' || node.type === 'char_literal' || node.type === 'character') {
      if (typeof node.value === 'string') {
        let val = node.value;
        if (val.startsWith('0u')) {
          return { type: 'char', value: parseInt(val.slice(2), 16) };
        } else if (val.startsWith('\\')) {
          return { type: 'char', value: val.charCodeAt(1) };
        } else {
          return { type: 'char', value: val.charCodeAt(0) }; // "a" を文字コード 97 に変換
        }
      }
      return node; // 既に数値化されていればそのまま
    }

    // ケース2: "\" が前置演算子としてパースされた場合 (\a)
    if (node.type === 'prefix' && node.op === '\\') {
      let charStr = node.right.name || node.right.value || node.right.text || '';
      return { type: 'char', value: String(charStr).charCodeAt(0) };
    }

    // ケース3: identifier (識別子) としてパースされてしまった "0u00f0" の救出
    if (node.type === 'identifier' || node.type === 'variable') {
      let name = node.name || node.value || node.text;

      // 先頭が "0u" なら文字型コードポイントとしてパース！
      if (typeof name === 'string' && name.startsWith('0u')) {
        return { type: 'char', value: parseInt(name.slice(2), 16) }; // "00f0" -> 240
      }

      if (!isNaN(parseFloat(name)) && isFinite(name)) {
        node.type = 'number';
        node.value = parseFloat(name);
        delete node.name;
      }
    }

    // 既存の number の進数処理
    if (node.type === 'number' && typeof node.value === 'string') {
      if (node.value.startsWith('0b') || node.value.startsWith('0r')) {
        const base = node.value.startsWith('0b') ? 2 : 16;
        node.value = parseInt(node.value.slice(2), base);
      } else if (node.value.startsWith('0u')) {
        return { type: 'char', value: parseInt(node.value.slice(2), 16) };
      }
    }

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