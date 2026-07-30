/**
 * Sign Language Preprocessor & Lexer (alpha/javascript)
 * 
 * 役割:
 * 1. コメント (`) や文字列 (`` `str` ``), エスケープ (\\.) の保護
 * 2. タブ (\t) インデントの管理と AST 用制御文字 (\x02: INDENT, \x03: DEDENT) の挿入
 * 3. 継続行 (行頭が演算子で始まる行) の直前行との自動結合
 * 4. 多義的でない中置演算子の前後への自動空白挿入 (separateInfix)
 */

import { buildLexerRegex } from './operator_table.js';

/**
 * 単義的中置演算子の前後に自動で空白を挿入する
 */
export function separateInfix(input) {
  const lexerRegex = buildLexerRegex();

  return input.replace(lexerRegex, (match, protect, operator) => {
    if (protect) {
      // 文字列、コメント、エスケープ文字、保護対象(!!)はそのまま保持
      return protect;
    }
    if (operator) {
      // 単義的中置演算子の前後に空白を挿入（PEGパーサーの __ = " "+ が多重空白を吸収）
      return ` ${operator} `;
    }
    return match;
  });
}

/**
 * タブインデントに基づきブロックマーカー (\x02, \x03) を挿入
 * 
 * QUESTION: 仕様書 (preprocessor.md) ではインデントは厳密に `\t` のみと定められている。
 * 現在の実装でもスペースインデントは拒否/無視し、タブの個数 `\t*` でインデントレベルを計測している。
 */
export function markBlock(input) {
  const lines = input.split(/\r?\n/);
  const indentStack = [0];
  const result = [];
  let lastContentLineIdx = -1;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    // 空行または空白のみの行
    if (line.trim() === '') {
      result.push(line);
      continue;
    }

    // コメント行の判定
    // grammar.pegjs 仕様: SOL (Start of Line = column 1) の ` のみがコメント
    // ・インデント (\t) が先行する `\t`` はコメント扱いにならず構文エラー / 文字列となる
    // ・式の途中 (例: `x + y `ここはコメントにならずエラー`) も SOL ではないためコメントにならずエラーとなる
    if (line.startsWith('`')) {
      result.push(line);
      lastContentLineIdx = result.length - 1;
      continue;
    }

    const leadingWsMatch = line.match(/^\t*/);
    const leadingWs = leadingWsMatch ? leadingWsMatch[0] : '';
    const content = line.substring(leadingWs.length);

    const currentIndent = leadingWs.length;
    let prefix = '';

    // インデントが浅くなった場合、スタックをポップして DEDENT (\x03) を挿入
    while (indentStack.length > 1 && currentIndent < indentStack[indentStack.length - 1]) {
      indentStack.pop();
      if (lastContentLineIdx !== -1) {
        result[lastContentLineIdx] += '\x03';
      }
    }

    // 継続行の判定 (行頭が中置演算子等で始まる場合)
    const contentTrimmed = content.trim();
    const isContinuation = /^[?+*\/\.,=<>;%&^]/.test(contentTrimmed) || 
                           /^!=(?:=)?/.test(contentTrimmed) || 
                           /^\|(?:\s|\|)/.test(contentTrimmed) || 
                           /^~(?:\s|[+*\/\^-])/.test(contentTrimmed);

    if (isContinuation) {
      // 継続行の場合は直前の行末にスペース区切りで結合
      if (lastContentLineIdx !== -1) {
        result[lastContentLineIdx] += ' ' + content;
      } else {
        result.push(prefix + content);
        lastContentLineIdx = result.length - 1;
      }
    } else if (currentIndent > indentStack[indentStack.length - 1]) {
      // インデントが深くなった場合 INDENT (\x02)
      indentStack.push(currentIndent);
      if (lastContentLineIdx !== -1) {
        result[lastContentLineIdx] += '\x02' + content;
      } else {
        result.push('\x02' + content);
        lastContentLineIdx = result.length - 1;
      }
    } else {
      // インデントが同レベルの場合
      result.push(prefix + content);
      lastContentLineIdx = result.length - 1;
    }
  }

  // ファイル末尾で未完了のインデントを閉じる (DEDENT)
  while (indentStack.length > 1) {
    indentStack.pop();
    if (lastContentLineIdx !== -1) {
      result[lastContentLineIdx] += '\x03';
    }
  }

  return result.join('\n');
}

/**
 * プリプロセッサの一括実行
 */
export function preprocess(input) {
  return separateInfix(markBlock(input));
}
