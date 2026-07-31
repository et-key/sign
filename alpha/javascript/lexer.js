/**
 * Sign Language Lexer (前処理フェーズ)
 * pre_alpha/lexisize/lexer.js から移植（変更なし、動作確認済み）
 *
 * 主な役割:
 * - 多義的でない中置演算子の前後に自動で空白を挿入し、PEGパーサーが
 *   フラットな配列として要素を捉えやすくする。
 * - 多義的演算子（`|`, `-`, `#`, `@`, `!`, `~`, `$` 等）には空白を挿入せず、
 *   密着結合（前置・後置）としてPEGが処理できるようにする。
 * - 文字列、コメント、エスケープ文字の中身は保護する。
 * - インデント/デデントを \x02 / \x03 の制御文字としてマーキングする（markBlock）。
 */

import { buildLexerRegex } from './operator_table.js';

export function separateInfix(input) {
  const lexerRegex = buildLexerRegex();

  return input.replace(lexerRegex, (match, protect, operator) => {
    if (protect) {
      // 文字列、コメント、エスケープ文字、保護対象(!!)はそのまま返す
      return protect;
    }
    if (operator) {
      // 多義的でない中置演算子の前後に空白を挿入
      return ` ${operator} `;
    }
    return match;
  });
}

// Indent・Dedentのマーキング関数
function markBlock(input) {
  const lines = input.split(/\r?\n/);
  const indentStack = [0];
  let result = [];
  let lastContentLineIdx = -1;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    // 空行や空白のみの行はそのまま追加し、インデントの深さ計算から除外
    if (line.trim() === '') {
      result.push(line);
      continue;
    }

    // Sign言語の仕様により、インデントは厳密に \t のみを使用する
    const leadingWsMatch = line.match(/^\t*/);
    const leadingWs = leadingWsMatch ? leadingWsMatch[0] : '';
    const content = line.substring(leadingWs.length);

    const currentIndent = leadingWs.length; // タブの数をインデントレベルとする

    let prefix = '';

    // インデントが浅くなった場合、スタックをポップしてDEDENTマーカーを出力
    while (indentStack.length > 1 && currentIndent < indentStack[indentStack.length - 1]) {
      indentStack.pop();
      if (lastContentLineIdx !== -1) {
        result[lastContentLineIdx] += '\x03'; // DEDENTマーカー
      }
    }

    // 継続行の判定 (行頭が中置演算子などで始まる場合)
    const contentTrimmed = content.trim();
    const isContinuation = /^[?+*\/\.,=<>;%&^]/.test(contentTrimmed) || /^!=(?:=)?/.test(contentTrimmed) || /^\|(?:\s|\|)/.test(contentTrimmed) || /^~(?:\s|[+*\/\^-])/.test(contentTrimmed);

    if (isContinuation) {
      if (lastContentLineIdx !== -1) {
        result[lastContentLineIdx] += ' ' + content;
      } else {
        result.push(prefix + content);
        lastContentLineIdx = result.length - 1;
      }
    } else if (currentIndent > indentStack[indentStack.length - 1]) {
      // インデントが深くなった場合
      indentStack.push(currentIndent);
      if (lastContentLineIdx !== -1) {
        result[lastContentLineIdx] += '\x02' + content; // INDENTマーカー
      } else {
        result.push('\x02' + content);
        lastContentLineIdx = result.length - 1;
      }
    } else {
      // インデントが同じ場合
      result.push(prefix + content);
      lastContentLineIdx = result.length - 1;
    }
  }

  // ファイル末尾に達した場合、残っているインデントをすべて閉じる
  while (indentStack.length > 1) {
    indentStack.pop();
    if (lastContentLineIdx !== -1) {
      result[lastContentLineIdx] += '\x03';
    }
  }

  return result.join('\n');
}

export function preprocess(input) {
  return separateInfix(
    markBlock(input)
  );
}
