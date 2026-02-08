
const parser = require('./src/sign-parser.js'); // Uses generated parser

const valid = `
x : 1
y :
	2
`;

const invalid = `
x : : 1
`;

try {
	parser.parse(valid);
	console.log("Valid input passed.");
} catch (e) {
	console.error("Valid input failed:", e.message);
}

try {
	parser.parse(invalid);
	console.log("Invalid input unexpectedly passed.");
} catch (e) {
	console.log("Invalid input failed as expected:", e.message);
	if (e.location) console.log("Location:", e.location.start);
}
