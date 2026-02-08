
const parser = require('./src/sign-parser.js');

const tests = [
	{
		name: "Top-level String (Expression)",
		input: "`hello`",
		expectedType: "Literal"
	},
	{
		name: "Indented String (Block Content)",
		input: "x :\n\t`hello`",
		// If it's a block, it returns a list of expressions. 
		// If `hello` is just a string, it's an expression.
		// User said: \t`this is comment` ? 
		// Let's see what the parser produces.
	}
];

const inputs = [
	{
		desc: "Case 1: Top level backticks",
		code: "`not a comment`"
	},
	{
		desc: "Case 2: Indented backticks",
		code: "block :\n\t`is this a comment?`"
	},
	{
		desc: "Case 3: Comment defined in grammar?",
		code: "`closed string`"
	}
];

inputs.forEach(t => {
	console.log(`--- ${t.desc} ---`);
	try {
		const res = parser.parse(t.code);
		console.log("Parsed:", JSON.stringify(res, null, 2));
	} catch (e) {
		console.log("Error:", e.message);
	}
});
