
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const INPUT_FILE = path.join(__dirname, 'test_output.json');
const OUTPUT_FILE = path.join(__dirname, 'output.s');

const AST = JSON.parse(fs.readFileSync(INPUT_FILE, 'utf8'));

// --- Instruction Dictionary ---
const TEMPLATES = {
	'+': 'add x0, x1, x0',
	'-': 'sub x0, x1, x0',
	'*': 'mul x0, x1, x0',
	'/': 'sdiv x0, x1, x0',
	'%': 'sdiv x2, x1, x0\n    msub x0, x2, x0, x1', // x1 % x0 -> x1 - (x1/x0)*x0

	// Memory (Infix # is Store)
	'#': 'str x0, [x1]', // x1 # x0 -> str val(x0), [ptr(x1)]

	// Comparison (Simple Boolean 0/1 for Phase 1)
	'=': 'cmp x1, x0\n    cset x0, eq',
	'<': 'cmp x1, x0\n    cset x0, lt',
	'>': 'cmp x1, x0\n    cset x0, gt',

	// Logic
	'&': 'and x0, x1, x0',
	'|': 'orr x0, x1, x0'
};

// --- Code Generator ---
let labelCount = 0;
function generateLabel(prefix) {
	return `${prefix}_${labelCount++}`;
}


// --- Environment ---
// Map identifier -> Stack Offset (from FP) or 'arg:N'
let env = {};
let stringTable = {}; // content -> label
let stringCounter = 0;
let globals = {}; // name -> initialValue (number/label)

function resolveVar(name) {
	if (env[name] !== undefined) {
		let val = env[name];
		// if "local:-16", return "[x29, #-16]"
		if (val.startsWith && val.startsWith('local:')) {
			return `[x29, #${val.split(':')[1]}]`;
		}
		if (val.startsWith && val.startsWith('reg:')) {
			return val.split(':')[1];
		}
		return val;
	}
	// Global/External?
	return `global:${name}`;
}

function compileNode(node) {
	// console.log("Compiling:", JSON.stringify(node));
	// 1. Array (Expression) [Op, Arg1, Arg2...]
	if (Array.isArray(node)) {
		if (node.length === 0) return compileUnit();

		const [op, ...args] = node;

		// CHECK FOR BLOCK (List of Expressions)
		// If 'op' is NOT a string, assume it's a list [expr1, expr2...] to be executed sequentially.
		// Also if 'op' IS a string but starts with '`', it's a literal, so this is a list of values/exprs (Block).
		if (typeof op !== 'string' || op.startsWith('`')) {
			let code = '';
			for (let subNode of node) {
				code += compileNode(subNode);
			}
			return code;
		}

		// --- SPECIAL FORMS ---


		// Define ": name value"
		if (op === ':') {
			const [name, val] = args;
			// Top-level function definition
			if (Array.isArray(val) && val[0] === '?') {
				return compileFunction(val, name);
			}

			// Check if we are at Top-Level (env is emptyish?)
			// Or just check if `env._stackOffset` is missing?
			// "Function" scope always sets `_stackOffset`.
			// Top-Level (main scope compilation) might not.
			// But we wrap everything in loop.

			// Actually, we need to know if we are inside a function.
			// Let's check `env._stackOffset`.
			if (env._stackOffset === undefined) {
				// GLOBAL VARIABLE DEFINITION
				// Only support immediate numbers
				let initVal = 0;
				if (typeof val === 'number') {
					initVal = val;
				} else if (typeof val === 'string' && val === '_') {
					initVal = 0; // Unit/0
				} else if (typeof val === 'string' && /^(-?0x|-?0o|-?0b)/.test(val)) {
					initVal = Number(val);
				} else {
					// If it's not a number, we can't emit .quad directly in this Phase.
					// But for verification, let's complain if we try to put complex expr in global.
					// However, "current : @heap_ptr" became global because of scope bug.
					// With scope fix, this branch won't be taken for 'current'.
					// So we can keep it strict or simple.
					// Let's mark it clearly.
					return `    ; ERROR: Global Init must be constant: ${name}\n`;
				}

				globals[name] = initVal;
				// No code emitted for definition itself (it's data)
				return `    ; Global Define ${name} = ${initVal}\n`;
			}

			// Local Variable Definition (inside function)
			// 1. Compile Value -> x0
			let code = compileNode(val);
			// 2. Push to Stack
			code += '    str x0, [sp, #-16]!\n';
			// 3. Update Env (Offset from FP?)
			// FP is currently SP at entry.
			// Stack grows down. Arg1 at [fp, #...]?
			// Let's rely on simple stack tracking relative to FP.
			// We need a 'context' object passed to compileNode to track stack depth?
			// Or just use global 'stackDepth'?
			// 'env' is global for now (reset per function).

			// HACK: We assume simplistic linear stack growth.
			// Only works if we don't pop?
			// Sign is immutable-ish. definitions imply new vars.
			// We define `env[name]` = current_stack_offset.

			// How to get current stack offset? 
			// We need to track it manually.
			if (!env._stackOffset) env._stackOffset = 0;
			env._stackOffset -= 16;
			env[name] = `local:${env._stackOffset}`;

			return code;
		}

		// Function Definition "?" (Anonymous)
		if (op === '?') {
			return compileFunction(node, null);
		}

		// Function Application " " (Space) 
		// [" ", func, arg] (Left associative)
		if (op === ' ') {
			// Flatten application? f x y -> [" ", [" ", f, x], y]
			// Standard ABI:
			// 1. Evaluate Function -> x9 (temp)
			// 2. Evaluate Arg -> x0
			// 3. Move Arg to next available register?
			//    Sign is curried. "f x" returns a closure or value.
			//    Simplification for Phase 1: Direct calls with fixed args (cheat)

			// Actually, let's treat " " as: Evaluate LHS (Func), Evaluate RHS (Arg), Call.
			// But if LHS is a symbol "add", we might want to inline the call preparation.

			// For this prototype, let's assume fully saturated calls like (add 1 2)
			// But the parser gives [" ", [" ", "add", 1], 2]

			// Let's implement a recursive generic apply for now.
			// LHS result in x0. RHS in x1? No, we need to save LHS.

			let code = '';
			code += compileNode(args[0]); // LHS (Function ptr)
			code += '    str x0, [sp, #-16]!  ; Push Func\n';
			code += compileNode(args[1]); // RHS (Arg)

			// Now x0 = Arg. Stack = Func.
			// Prepare for 'blr'.
			// Sign ABI (Phase 1 Simplified): 
			//   If calling "add" (takes 2 args), we need 2 args in x0, x1?
			//   This implies we know "add" takes 2 args.
			//   Standard Sign: strictly 1 arg. "add 1" -> Returns closure.
			//   "closure 2" -> Returns 3.

			//   Let's implement the "Curried Call" via a helper if possible.
			//   Or just rely on the fact that for "main", we can cheat?

			//   Cheat Reuse: If the function is a direct global label known to take 2 args,
			//   we can try to optimize. But general case:

			//   LHS is a closure/function. Call it with RHS (x0).
			code += '    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)\n';
			code += '    ldr x9, [sp], #16    ; Pop Func -> x9\n';
			code += '    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)\n';
			code += '    blr x9               ; Call Function\n';

			return code;
		}

		// Prefix Operators (1 Arg)
		if (args.length === 1) {
			let code = '';

			// Memory Load: @ ptr
			if (op === '@' || op === '@_') {
				code += compileNode(args[0]); // Eval Ptr -> x0
				code += '    ldr x0, [x0]         ; @ load\n';
				return code;
			}

			// Marker: # (Prefix) - e.g. #heap_ptr : ...
			// Just pass through for definitions.
			if (op === '#_') {
				return compileNode(args[0]);
			}

			// Address Of: $ name (Prefix uses symbol $_ ? No, overrides says # => #_)
			// Parser overrides: $ is NOT in overrides list in parser.js!
			// Line 220-231 of parser.js. $ is missing.
			// So $ uses default table.
			// Check operators.js? I can't check operators.js easily (it's in utility).
			// Assuming $ is prefix in operators.js.
			// If it behaves like @, it might need to be $_?
			// Let's assume $ works as $ for now unless verified otherwise.
			// Address Of: $ name
			if (op === '$') {
				if (typeof args[0] === 'string') {
					let name = args[0];
					let loc = resolveVar(name);
					if (loc.startsWith('global:')) {
						return `    adr x0, ${loc.split(':')[1]} ; $ address\n`;
					}
					return `    ; TODO: Address of local ${name}\n`;
				}
			}
		}


		// Binary Operators (Strict Templates)
		if (TEMPLATES[op] && args.length === 2) {
			let code = '';
			code += compileNode(args[0]);
			code += '    str x0, [sp, #-16]!\n';
			code += compileNode(args[1]);
			code += '    ldr x1, [sp], #16\n';
			code += `    ${TEMPLATES[op]}\n`;
			return code;
		}

		// Fallback or Unknown
		return `    ; UNKNOWN OP: ${op}\n`;
	}

	// 2. Number
	if (typeof node === 'number') {
		return `    mov x0, #${node}\n`;
	}

	// 3. Identifier / String
	if (typeof node === 'string') {
		if (node === '_') return compileUnit();

		// Literal Numbers (Hex, Oct, Bin) preserved as strings by parser
		if (/^(-?0x|-?0o|-?0b)/.test(node)) {
			let val = Number(node);
			return `    mov x0, #${val}\n`;
		}

		// String Literal logic
		if (node.startsWith('`')) {
			// console.log("Found String Literal:", node);
			let content = node.slice(1, -1);
			let lbl = stringTable[content];
			if (!lbl) {
				lbl = `str_${stringCounter++}`;
				stringTable[content] = lbl;
			}
			return `    adr x0, ${lbl}\n`;
		}

		let loc = resolveVar(node);
		if (loc.startsWith('global:')) {
			// Identifier resolves to VALUE.
			// Global: Load value from label.
			let label = loc.split(':')[1];
			// adr x0, label; ldr x0, [x0]
			return `    adr x0, ${label}\n    ldr x0, [x0]\n`;
		}

		// Register or Memory
		// If it starts with '[', it's memory -> ldr
		if (loc.startsWith('[')) {
			return `    ldr x0, ${loc}\n`;
		}
		// If register -> mov
		return `    mov x0, ${loc}\n`;
	}

	return `    ; UNKNOWN NODE TYPE ${JSON.stringify(node)}\n`;
}

function compileFunction(node, name) {
	// node = ["?", [params...], body]
	const params = node[1];
	const body = node[2];

	// 1. Generate Label
	let label = name || generateLabel("func");
	let afterLabel = generateLabel("after_" + label);

	let funcCode = '';
	// Jump over the function body if it's inline (standard for lambdas)
	let setupCode = `    b ${afterLabel}\n`;

	// Function Body
	funcCode += `${label}:\n`;
	// Prologue
	funcCode += '    stp x29, x30, [sp, #-16]!\n';
	funcCode += '    mov x29, sp\n';

	// Bind Params to Registers (Simple Phase 1)
	let oldEnv = { ...env };
	env._stackOffset = 0; // Initialize stack offset for locals

	// Hack for "add x y": parser gives params ["x", "y"]
	// We bind x->x0, y->x1.
	// NOTE: This only works if we call it with 2 args properly constructed!
	// But our " " operator implementation above only passes X0.
	// WE NEED A COMPROMISE for Phase 1.
	// Let's say "add" is special (2-arg primitive) or we implement manual currying.

	// Let's Assume: "add" is defined as : x y ? ...
	// And called as ((add 1) 2).
	// This requires partial application support.

	// SIMPLIFICATION:
	// We will just bind x->x0, y->x1.
	// And in "main", we manual-call "add" with 2 args for the test?
	// No, "main" is generated by code.

	// OK, let's treat params as x0, x1... for now.
	params.forEach((p, i) => {
		if (typeof p === 'string') env[p] = `reg:x${i}`;
	});

	funcCode += compileNode(body);


	// Epilogue
	// Restore SP to FP (clean up locals)
	funcCode += '    mov sp, x29\n';
	funcCode += '    ldp x29, x30, [sp], #16\n';
	funcCode += '    ret\n';

	env = oldEnv; // Restore env

	// Output function code OUTSIDE the main flow? 
	// Usually yes. But here we can emit it inline with jump-over.

	// If it's a global definition (name != null), we don't need "load address" code in strict sense,
	// but the ":" operator usually returns the value.
	// Top-level ":" might differ.

	let result = '';
	result += setupCode;
	result += funcCode;
	result += `${afterLabel}:\n`;

	// The "value" of a function definition is its address
	result += `    adr x0, ${label}\n`;

	return result;
}

function compileUnit() {
	return `    adr x0, sign_id\n`;
}

// --- Main ---
let asm = '';

// Preamble
asm += `.global _start\n`;
asm += `.text\n`;

// Entry Point
asm += `_start:\n`;
// Setup Heap?
// In Phase 2, we need real memory.
// For now, let's point heap_ptr to a static buffer.
asm += `    adr x0, heap_buffer\n`;
asm += `    adr x1, heap_ptr\n`;
asm += `    str x0, [x1]\n`; // Initialize heap_ptr = &heap_buffer

// Compile all top-level expressions
for (let expr of AST) {
	asm += compileNode(expr);
}

// Call main?
// Parse result usually generates "main" label but doesn't call it.
// We should check if "main" exists in globals/labels and call it.
// Or we assume the user wrote a top-level expression to run it?
// In `test_input.sn`: `main : ? ...`. It defines "main". But doesn't call it.
// We need to explicitly call "main" if it exists.
asm += `    adr x0, main\n`; // Check if main exists? (Assembler will error if not... wait, simple adr won't error if forward declared?)
// Let's just assume we need to call it if it's defined.
// Better: The AST execution flow just DEFINES 'main'. It doesn't run it (since it's inside `?`).
// So we must manually add a call to main at the end of _start.
asm += `    blr x0\n`;

// Exit (using result in x0 as status code for now?)
asm += `    mov x8, #93       ; svc exit\n`;
asm += `    svc #0\n`;
asm += `\n`;

// Runtime (Builtin Functions)
asm += `sign_id:\n`;
asm += `    ret\n`;

// Data Section
asm += `\n.data\n`;
for (let [content, lbl] of Object.entries(stringTable)) {
	// Escape content? For now simple
	asm += `${lbl}: .asciz "${content}"\n`;
}

// Globals
for (let [name, val] of Object.entries(globals)) {
	asm += `${name}: .quad ${val}\n`;
}

// Heap Buffer (Simple Static Area 64KB)
asm += `\n.bss\n`;
asm += `heap_buffer: .skip 65536\n`; // 64KB Heap

fs.writeFileSync(OUTPUT_FILE, asm);
console.log(`Generated ${OUTPUT_FILE}`);
