export function preprocess(code) {
  // 配列で渡された場合は結合して1つの文字列にする
  let srcString = Array.isArray(code) ? code.join('\n') : code;

  // CRLF対策: Windows環境などの改行コードを LF(\n) に統一する
  srcString = srcString.replace(/\r\n/g, '\n').replace(/\r/g, '\n');

  // コピペ等で混入する特殊な空白(NBSP)を通常のスペースに統一
  srcString = srcString.replace(/\xA0/g, ' ');

  // 【フェーズ1: エスケープ文字の完全保護（マスキング）】
  let escapedChars = [];
  let maskedCode = srcString.replace(/\\([\s\S])/g, (match, p1) => {
    escapedChars.push(p1);
    return `__SIGN_ESC_${escapedChars.length - 1}__`;
  });

  // マスクされた状態で改行分割
  let srcLines = maskedCode.split('\n');
  let output = [];
  let indentStack = [0];

  for (let line of srcLines) {
    let trimmedLine = line.replace(/^\s+/, '').replace(/\s+$/, '');

    if (trimmedLine === '') continue;

    // 【修正箇所】インデントされた文字列リテラルを消さないように、
    // 「生の line」が直接 ` で始まる場合のみトップレベルコメントとしてスキップする
    if (line.startsWith('`')) continue;

    // インデントレベルの計算
    let indent = line.search(/\S/);
    if (indent === -1) indent = 0;

    let currentIndent = indentStack[indentStack.length - 1];

    if (indent > currentIndent) {
      indentStack.push(indent);
      if (output.length > 0) {
        output[output.length - 1] += ' {';
      } else {
        output.push("{");
      }
    } else if (indent < currentIndent) {
      while (indentStack.length > 1 && indent < indentStack[indentStack.length - 1]) {
        indentStack.pop();
        output.push("}");
      }
    }

    output.push(trimmedLine);
  }

  // 残ったインデントを閉じる
  while (indentStack.length > 1) {
    indentStack.pop();
    output.push("}");
  }

  let finalCode = output.join('\n');

  // 【フェーズ2: マスクの復元】
  finalCode = finalCode.replace(/__SIGN_ESC_(\d+)__/g, (match, p1) => {
    return '\\' + escapedChars[p1];
  });

  return finalCode;
}