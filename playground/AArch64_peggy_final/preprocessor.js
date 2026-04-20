export function preprocess(code) {
  let srcLines = Array.isArray(code) ? code : code.split('\n');
  let output = [];
  let indentStack = [0];
  let skipIndent = false;

  for (let line of srcLines) {
    if (line.trim() === '') continue;

    // トップレベルコメントの完全除去
    // 行の先頭（インデント0）が ` で始まる場合は、行全体をコメントとしてスキップする
    // （閉じられていなくても無視されるため、PEGでのパースエラーが起きません）
    if (line.startsWith('`')) {
      continue;
    }

    let indent = line.search(/\S/);
    if (indent === -1) indent = 0;

    let currentIndent = indentStack[indentStack.length - 1];

    if (!skipIndent) {
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
    }

    if (skipIndent) {
      output[output.length - 1] = output[output.length - 1].replace(/\/$/, '') + line.trim();
    } else {
      output.push(line.trim());
    }

    skipIndent = line.trim().endsWith('\\');
  }

  while (indentStack.length > 1) {
    indentStack.pop();
    output.push("}");
  }

  return output.join('\n');
}
