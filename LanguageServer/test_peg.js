
const peggy = require('pegjs');
const fs = require('fs');

const grammarPath = './src/sign.v0.pegjs';
const input = `
x : 1
y :
	2
	3
`;

try {
	const grammar = fs.readFileSync(grammarPath, 'utf8');
	const parser = peggy.generate(grammar);
	const result = parser.parse(input);
	console.log("Parse Success:", JSON.stringify(result, null, 2));
} catch (e) {
	console.error("Parse Failed:", e.message);
	if (e.location) console.error("Location:", e.location);
}
