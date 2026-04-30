/**
 * Sign Lexer: Indentation to ASCII Control Codes
 */
function lex(source) {
	const STX = "\x02";
	const ETX = "\x03";
	const lines = source.split(/\r?\n/);
	const indentStack = [0];
	const result = [];

	for (let i = 0; i < lines.length; i++) {
		const line = lines[i];

		// 空行や空白のみの行はそのまま保持し、インデント計算からは除外する
		if (line.trim().length === 0) {
			result.push(line);
			continue;
		}

		// コメント行（行頭が ` の場合）は空行として扱い、インデント計算からは除外する
		if (line.startsWith('`')) {
			result.push("");
			continue;
		}

		const match = line.match(/^[\t ]*/);
		const currentIndent = match ? match[0].length : 0;
		const lastIndent = indentStack[indentStack.length - 1];

		if (currentIndent > lastIndent) {
			// インデントが深くなった
			indentStack.push(currentIndent);
			result.push(STX + line.substring(currentIndent));
		} else if (currentIndent < lastIndent) {
			// インデントが浅くなった
			let dedents = "";
			while (indentStack.length > 1 && currentIndent < indentStack[indentStack.length - 1]) {
				indentStack.pop();
				dedents += ETX;
			}
			if (dedents.length > 0) {
				result.push(dedents);
			}
			result.push(line.substring(currentIndent));
		} else {
			// 同一インデント
			result.push(line.substring(currentIndent));
		}
	}

	// ファイル末尾で残っているインデントを全て閉じる
	let finalDedents = "";
	while (indentStack.length > 1) {
		indentStack.pop();
		finalDedents += ETX;
	}
	if (finalDedents) result.push(finalDedents);

	return result.join("\n");
}

module.exports = { lex };