
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const INPUT_FILE = path.join(__dirname, 'main.json');
const OUTPUT_FILE = path.join(__dirname, 'output.s');

const AST = JSON.parse(fs.readFileSync(INPUT_FILE, 'utf8'));

// --- Instruction Dictionary ---
const UNIT_VAL = '0xDEAD000000000000'; // Placeholder for Unit (False)

// --- Instruction Dictionary ---
const TEMPLATES = {
	'+': 'add x0, x1, x0',
	'*': 'mul x0, x1, x0',
	'/': 'sdiv x0, x1, x0',
	'%': 'sdiv x2, x1, x0\n    msub x0, x2, x0, x1',

	// Memory (Infix # is Store)
	'#': 'str x0, [x1]',

	// Bitwise
	'<<': 'lsl x0, x1, x0',
	'>>': 'asr x0, x1, x0', // Arithmetic Shift Right
	'||': 'orr x0, x1, x0',
	';;': 'eor x0, x1, x0',
	'&&': 'and x0, x1, x0',
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
			// SCAN for Match Syntax ([:] with non-string name)
			let isMatchBlock = false;
			for (let subNode of node) {
				if (Array.isArray(subNode) && subNode[0] === ':') {
					if (typeof subNode[1] !== 'string') isMatchBlock = true;
				}
			}

			if (isMatchBlock) {
				// OR Chain Logic (|)
				let code = '';
				let useLabels = (node.length > 0);
				let lblEnd = generateLabel("match_end");

				for (let i = 0; i < node.length; i++) {
					code += compileNode(node[i]);
					if (i < node.length - 1) { // Don't check last one (it returns whatever)
						code += `    adr x9, sign_id\n`;
						code += '    cmp x0, x9\n';
						code += `    b.ne ${lblEnd}\n`; // Found Valid Result -> End
					}
				}
				code += `${lblEnd}:\n`;
				return code;
			} else {
				// Sequential Block
				let code = '';
				for (let subNode of node) {
					code += compileNode(subNode);
				}
				return code;
			}
		}

		// --- SPECIAL FORMS ---


		// Define ": name value"
		if (op === ':') {
			const [name, val] = args;
			// Top-level function definition
			if (Array.isArray(val) && val[0] === '?') {
				// If name is expression? Invalid for function def?
				if (typeof name !== 'string') return `    ; Error: Invalid Function Name\n`;
				return compileFunction(val, name);
			}

			// Match Case Condition: [":", cond, res]
			// Implement as AND (&) Logic: cond & res
			if (typeof name !== 'string') {
				// args[0] is Condition. args[1] is Result.
				// Logic: If Cond is Truthy (Not Unit), Eval/Return Res. Else Return Unit.
				let lblFalse = generateLabel("case_fail");
				let lblEnd = generateLabel("case_end");

				let code = '';
				code += compileNode(name); // Condition -> x0
				code += `    adr x9, sign_id\n`;
				code += '    cmp x0, x9\n';
				code += `    b.eq ${lblFalse}\n`; // Fail -> Unit

				code += compileNode(val); // Result -> x0
				code += `    b ${lblEnd}\n`;

				code += `${lblFalse}:\n`;
				code += `    adr x0, sign_id\n`;
				code += `${lblEnd}:\n`;
				return code;
			}

			// Global Variable Definition
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
					// Runtime Initialization
					globals[name] = 0;
					let code = compileNode(val);
					code += `    adr x1, ${name}\n`;
					code += `    str x0, [x1]\n`;
					return code;
				}

				globals[name] = initVal;
				// No code emitted for definition itself (it's data)
				return `    ; Global Define ${name} = ${initVal}\n`;
			}

			// Local Variable Definition (inside function)
			let code = compileNode(val);
			code += '    str x0, [sp, #-16]!\n';
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

			// Bitwise NOT (!!)
			if (op === '!!' || op === '!!_') {
				code += compileNode(args[0]);
				code += '    mvn x0, x0\n';
				return code;
			}

			// Logic NOT ( ! )
			if (op === '!' || op === '!_') {
				let lblTrue = generateLabel("not_true");
				let lblEnd = generateLabel("not_end");
				code += compileNode(args[0]);
				code += '    adr x9, sign_id\n';
				code += '    cmp x0, x9\n';
				code += `    b.eq ${lblTrue}\n`; // Is Unit (False) -> Return 0 (True?)
				// Is True -> Return Unit
				code += '    adr x0, sign_id\n';
				code += `    b ${lblEnd}\n`;
				code += `${lblTrue}:\n`;
				code += '    mov x0, #0\n'; // 0 as True
				code += `${lblEnd}:\n`;
				return code;
			}

			// Factorial (Postfix !)
			if (op === '!' || op === '_!') {
				code += compileNode(args[0]);
				code += '    bl _factorial\n';
				return code;
			}

			// Abs ( |...| )
			if (op === '!-') {
				code += compileNode(args[0]);
				code += '    cmp x0, #0\n';
				code += '    cneg x0, x0, mi\n';
				return code;
			}
		}


		// Binary Operators (Expanded Check)
		if (args.length === 2) {
			let code = '';

			// Comparisons with Unit Logic
			if (['=', '<', '>', '<=', '>=', '!='].includes(op)) {
				let lblTrue = generateLabel("true");
				let lblEnd = generateLabel("end");

				code += compileNode(args[0]); // LHS -> x0
				code += '    str x0, [sp, #-16]!\n';
				code += compileNode(args[1]); // RHS -> x0
				code += '    mov x1, x0\n'; // RHS -> x1
				code += '    ldr x0, [sp], #16\n'; // LHS -> x0
				code += '    cmp x0, x1\n';

				let cond = '';
				if (op === '=') cond = 'eq';
				if (op === '!=') cond = 'ne';
				if (op === '<') cond = 'lt';
				if (op === '>') cond = 'gt';
				if (op === '<=') cond = 'le';
				if (op === '>=') cond = 'ge';

				code += `    b.${cond} ${lblTrue}\n`;
				code += `    adr x0, sign_id ; Unit (False)\n`;
				code += `    b ${lblEnd}\n`;
				code += `${lblTrue}:\n`;
				code += `    mov x0, x1 ; Return RHS\n`;
				code += `${lblEnd}:\n`;
				return code;
			}

			// Manual Logic Operators
			if (op === '&') {
				let lblFail = generateLabel("and_fail");
				let lblEnd = generateLabel("and_end");
				code += compileNode(args[0]);
				code += `    adr x9, sign_id\n`;
				code += '    cmp x0, x9\n';
				code += `    b.eq ${lblFail}\n`;
				code += compileNode(args[1]);
				code += `    b ${lblEnd}\n`;
				code += `${lblFail}:\n`;
				code += `    adr x0, sign_id\n`;
				code += `${lblEnd}:\n`;
				return code;
			}
			if (op === '|') {
				let lblSucc = generateLabel("or_succ");
				let lblEnd = generateLabel("or_end");
				code += compileNode(args[0]);
				code += `    adr x9, sign_id\n`;
				code += '    cmp x0, x9\n';
				code += `    b.ne ${lblSucc}\n`;
				code += compileNode(args[1]);
				code += `    b ${lblEnd}\n`;
				code += `${lblSucc}:\n`;
				code += `${lblEnd}:\n`;
				return code;
			}

			if (TEMPLATES[op]) {
				code += compileNode(args[0]);
				code += '    str x0, [sp, #-16]!\n';
				code += compileNode(args[1]);
				code += '    ldr x1, [sp], #16\n';
				code += `    ${TEMPLATES[op]}\n`;
				return code;
			}

			// Power (^)
			if (op === '^') {
				code += compileNode(args[0]); // Base
				code += '    str x0, [sp, #-16]!\n';
				code += compileNode(args[1]); // Exp
				code += '    ldr x1, [sp], #16\n'; // Base -> x1, Exp -> x0
				code += '    bl _pow\n';
				return code;
			}

			// XOR (;) - Choice
			if (op === ';') {
				let lblTrue = generateLabel("xor_true_check");
				let lblFalse = generateLabel("xor_false_check");
				let lblEnd = generateLabel("xor_end");

				// Logic:
				// Eval A -> x0. Push.
				// Eval B -> x0.
				// Pop A -> x1.
				// x1 (A), x0 (B)

				code += compileNode(args[0]);
				code += '    str x0, [sp, #-16]!\n';
				code += compileNode(args[1]);
				code += '    ldr x1, [sp], #16\n';

				// A in x1, B in x0
				code += '    str x0, [sp, #-16]!\n'; // Push B
				code += '    str x1, [sp, #-16]!\n'; // Push A

				// Check A (x1)
				code += '    adr x9, sign_id\n';
				code += '    cmp x1, x9\n';
				code += `    b.ne ${lblTrue}\n`; // A is True

				// A is False (Unit). Check B.
				// If B is True -> Return B. Else Unit.
				code += '    ldr x0, [sp], #16\n'; // Pop A (discard)
				code += '    ldr x0, [sp], #16\n'; // Pop B -> x0
				code += `    b ${lblEnd}\n`; // Return B (True or False)

				code += `${lblTrue}:\n`;
				// A is True. Check B.
				// If B is False -> Return A.
				// If B is True -> Return Unit.
				code += '    ldr x1, [sp], #16\n'; // Pop A -> x1
				code += '    ldr x0, [sp], #16\n'; // Pop B -> x0

				code += '    adr x9, sign_id\n';
				code += '    cmp x0, x9\n';
				code += `    b.eq ${lblFalse}\n`; // B is False -> Return A

				// Both True -> Return Unit
				code += '    adr x0, sign_id\n';
				code += `    b ${lblEnd}\n`;

				code += `${lblFalse}:\n`;
				code += '    mov x0, x1\n'; // Return A

				code += `${lblEnd}:\n`;
				return code;
			}

			// Cons (,)
			if (op === ',') {
				code += compileNode(args[0]);
				code += '    str x0, [sp, #-16]!\n';
				code += compileNode(args[1]);
				code += '    ldr x1, [sp], #16\n';
				code += '    bl _cons\n';
				return code;
			}

			// Range (~)
			if (op === '~') {
				code += compileNode(args[0]);
				code += '    str x0, [sp, #-16]!\n';
				code += compileNode(args[1]);
				code += '    ldr x1, [sp], #16\n';
				code += '    bl _range\n';
				return code;
			}

			// Get (') and At (@)
			if (op === "'" || op === '@') {
				code += compileNode(args[0]);
				code += '    str x0, [sp, #-16]!\n';
				code += compileNode(args[1]);
				code += '    ldr x1, [sp], #16\n';

				if (op === "'") {
					// LHS ' RHS -> nth(LHS, RHS)
					code += '    bl _nth\n';
				} else {
					// LHS @ RHS -> at(LHS, RHS). User: 2 @ list.
					// LHS=Index(x1), RHS=List(x0).
					// nth(List, Index) -> nth(x0, x1).
					// Swap regs: x0 <-> x1
					code += '    mov x9, x0\n';
					code += '    mov x0, x1\n';
					code += '    mov x1, x9\n';
					code += '    bl _nth\n';
				}
				return code;
			}
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
			let label = loc.split(':')[1];
			if (globals[label] !== undefined) {
				// Global Variable: Load Value
				return `    adr x0, ${label}\n    ldr x0, [x0]\n`;
			} else {
				// Function Label: Load Address
				return `    adr x0, ${label}\n`;
			}
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
// NO: User must explicitly call main in main.sn (e.g. `main _`)
// The top-level expressions are executed sequentially.

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

// Runtime Functions
// _pow(base:x1, exp:x0) -> x0
asm += `
_pow:
    ; Simple loop implementation for integer pow
    ; x1 = base, x0 = exp
    ; Result in x0
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    cbz x0, .Lpow_one
    mov x2, x0 ; Counter
    mov x0, #1 ; Result
.Lpow_loop:
    cbz x2, .Lpow_end
    mul x0, x0, x1
    sub x2, x2, #1
    b .Lpow_loop
.Lpow_one:
    mov x0, #1
.Lpow_end:
    ldp x29, x30, [sp], #16
    ret

_factorial:
    ; x0 = n
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x1, x0
    mov x0, #1
    cmp x1, #1
    b.le .Lfact_end
.Lfact_loop:
    mul x0, x0, x1
    sub x1, x1, #1
    cmp x1, #1
    b.gt .Lfact_loop
.Lfact_end:
    ldp x29, x30, [sp], #16
    ret

_cons:
    ; x1 = head, x0 = tail
    ; Alloc 16 bytes: [head, tail]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    ; Load heap_ptr
    adr x9, heap_ptr
    ldr x2, [x9] ; x2 = current heap ptr
    
    str x1, [x2]      ; Store head
    str x0, [x2, #8]  ; Store tail
    
    mov x0, x2        ; Return ptr
    add x2, x2, #16   ; Bump ptr
    str x2, [x9]      ; Update heap_ptr
    
    ldp x29, x30, [sp], #16
    ret

_range:
    ; x1 = start, x0 = end
    ; Return list [start, start+1, ..., end]
    ; Recursive or Loop? Loop building from end?
    ; range(1, 3) -> [1, [2, [3, _]]]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    ; Save start(x1), end(x0)
    ; We build strictly from end down to start
    ; if start > end return Unit
    
    cmp x1, x0
    b.gt .Lrange_empty
    
    mov x9, x0 ; current = end
    adr x10, sign_id ; acc = Unit
    
.Lrange_loop:
    ; Cons(current, acc)
    ; Need to preserve regs? _cons uses x9, x2.
    ; Safe to use x19-x28 if saved.
    ; For prototype, just use stack.
    
    ; Optimized:
    ; cons(x9, x10) -> x10
    
    ; Call _cons? Inlines logic for speed/simplicity
    stp x9, x10, [sp, #-16]! ; PUSH current, acc
    
    ; Call cons(current, acc) -> result
    mov x1, x9
    mov x0, x10
    bl _cons
    mov x10, x0 ; acc = result
    
    ldp x9, x2, [sp], #16 ; POP current, old_acc (discard)
    
    sub x9, x9, #1
    cmp x9, x1 ; Compare current vs start
    b.ge .Lrange_loop ; if current >= start, continue
    
    mov x0, x10
    b .Lrange_end

.Lrange_empty:
    adr x0, sign_id
.Lrange_end:
    ldp x29, x30, [sp], #16
    ret

_nth:
    ; x1 = list, x0 = index
    ; Return list[index] or Unit
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    ; Check if list is unit
    adr x9, sign_id
    cmp x1, x9
    b.eq .Lnth_fail
    
.Lnth_loop:
    cbz x0, .Lnth_found
    
    ; List structure: [head, tail] at x1
    ; tail is at [x1, #8]
    ldr x1, [x1, #8]
    
    ; Check if tail is unit (end of list)
    cmp x1, x9
    b.eq .Lnth_fail
    
    sub x0, x0, #1
    b .Lnth_loop
    
.Lnth_found:
    ; Return head -> [x1]
    ldr x0, [x1]
    b .Lnth_end

.Lnth_fail:
    adr x0, sign_id

.Lnth_end:
    ldp x29, x30, [sp], #16
    ret
`;

// Globals
for (let [name, val] of Object.entries(globals)) {
	asm += `${name}: .quad ${val}\n`;
}

// Heap Buffer (Simple Static Area 64KB)
asm += `\n.bss\n`;
asm += `heap_buffer: .skip 65536\n`; // 64KB Heap

fs.writeFileSync(OUTPUT_FILE, asm);
console.log(`Generated ${OUTPUT_FILE}`);
