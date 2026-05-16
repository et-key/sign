/**
 * Sign Language Lexer (前処理フェーズ)
 * 
 * 主な役割:
 * - 多義的でない中置演算子の前後に自動で空白を挿入し、PEGパーサーが
 *   フラットな配列として要素を捉えやすくする。
 * - 多義的演算子（`|`, `-`, `#`, `@`, `!`, `~`, `$` 等）には空白を挿入せず、
 *   密着結合（前置・後置）としてPEGが処理できるようにする。
 * - 文字列、コメント、エスケープ文字の中身は保護する。
 */

import { buildLexerRegex } from '../semanticize/operator_table.js';

export function separateInfix(input) {

  // 1. 保護グループ:
  //    - `[^`\r\n]*` : バッククォートで囲まれた文字列（同一行で閉じる場合）
  //    - `[^\r\n]*  : バッククォートで始まる行末までのコメント
  //    - \\.         : バックスラッシュによるエスケープ文字
  //    - !!            : ビット否定だけは中置演算子ではないので保護する
  //    - 予約語は無いので除外
  //    - 「前置記号・後置記号」は必要であれば追加する
  //
  // 2. 中置演算子グループ
  //    - semanticize/operator_table.js の定義から動的に生成された正規表現を使用する
  //    - 純粋な中置演算子のみを長い順にマッチさせる

  const lexerRegex = buildLexerRegex();

  return input.replace(lexerRegex, (match, protect, operator) => {
    if (protect) {
      // 文字列、コメント、エスケープ文字、保護対象(!!)はそのまま返す
      return protect;
    }
    if (operator) {
      // 多義的でない中置演算子の前後に空白を挿入
      // ※すでに空白がある場合は複数の空白が連続することになるが、
      //   PEGパーサー側の __ = " "+ がすべて吸収するため問題ない。
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

    // 構文解析器(PEG)が未定義の \t でクラッシュしないよう、物理的なタブは出力から削除する
    let prefix = '';

    if (currentIndent > indentStack[indentStack.length - 1]) {
      // インデントが深くなった場合
      indentStack.push(currentIndent);
      // 直前の有効な行末尾に INDENT マーカーと内容を結合する（改行を挟まない）
      if (lastContentLineIdx !== -1) {
        result[lastContentLineIdx] += '\x02' + content;
      } else {
        result.push('\x02' + content);
        lastContentLineIdx = result.length - 1;
      }
    } else {
      if (currentIndent < indentStack[indentStack.length - 1]) {
        // インデントが浅くなった場合
        while (indentStack.length > 1 && currentIndent < indentStack[indentStack.length - 1]) {
          indentStack.pop();
          if (lastContentLineIdx !== -1) {
            result[lastContentLineIdx] += '\x03'; // DEDENTマーカーを直前の有効行末尾に追加
          }
        }
      }
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

// 識別子としての絶対値囲み（|...|）と中置OR（|）を空白の有無で解決する関数
export function resolveAbsoluteValue(input) {
  return input.replace(/([^\s|])\|([^\s|])/g, '$1 | $2');
}

// 今後の拡張用（インデントに基づくブロック構築などの前処理）
export function preprocess(input) {
  return separateInfix(
    resolveAbsoluteValue(
      markBlock(input)
    )
  );
}
