
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const INPUT_FILE = path.join(__dirname, 'main.json');
const OUTPUT_FILE = path.join(__dirname, 'output.s');

const AST = JSON.parse(fs.readFileSync(INPUT_FILE, 'utf8'));
console.error("DEBUG AST:", JSON.stringify(AST, null, 2));

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
let g_env = {};
let stringTable = {}; // content -> label
let stringCounter = 0;
let globals = {
	// Map Runtime IDs to Static Closures
	"_print_str": "closure_print_str",
	"_print_char": "closure_print_char"
}; // name -> label

const runtimeClosures = {
	"_print_str": "closure_print_str",
	"_print_char": "closure_print_char",
	// Add others if defined in runtime.s
};

function resolveVar(name) {
	if (name === 'chars') console.log(`Resolving chars. Env: ${JSON.stringify(g_env)}`);

	// Runtime Closure Redirection
	if (runtimeClosures[name]) {
		return `    adr x0, ${runtimeClosures[name]}\n`;
	}

	if (g_env[name] !== undefined) {
		if (g_env[name] !== undefined) {
			let val = g_env[name];
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
				// Treat as "name = closure".
				// We need to validatate name.
				if (typeof name !== 'string') return `    ; Error: Invalid Function Name\n`;

				// Global Variable Definition
				if (g_env._stackOffset === undefined) {
					// 1. Compile Function (Lambda) -> x0 = Closure, emits code with unique label
					let code = '';
					if (Array.isArray(val) && val[0] === '?') {
						// Pass explicit name for debugging, but unique suffix for label
						code += compileFunction(val, name + "_impl");
					} else {
						// Normal value
						code += compileNode(val);
					}

					// 2. Allocate Global and Store
					globals[name] = 0; // Reserve Data Slot
					code += `    adr x1, ${name}\n`;
					code += `    str x0, [x1]\n`;

					return code;
				}

				// NOTE: Local function definitions will fall through to "Local Variable Definition" logic below
				// if we just handle the "val" compilation correctly.
				// If val is "?", compileFunction returns SetupCode+FuncCode.
				// SetupCode puts Closure in x0. FuncCode is placed inline (with branch over).
				// So "compileNode(?)" returns code that produces x0 = Closure.
				// Then "str x0, ..." stores it.
				// This is handled by default "Local Variable" logic if we let it fall through!

				// BUT compileNode calls compileFunction for "?".
				// compileFunction(node, null) uses generated labels. OK.

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
				if (g_env._stackOffset === undefined) {
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
					return `    // Global Define ${name} = ${initVal}\n`;
				}

				// Local Variable Definition (inside function)
				let code = compileNode(val);
				code += '    str x0, [sp, #-16]!\n';
				if (!g_env._stackOffset) g_env._stackOffset = 0;
				g_env._stackOffset -= 16;
				g_env[name] = `local:${g_env._stackOffset}`;

				return code;
			}

			// Function Definition "?" (Anonymous)
			if (op === '?') {
				return compileFunction(node, null);
			}

			// Function Application " " (Space) 
			// [" ", func, arg] (Left associative)
			if (op === ' ') {
				// 1. Eval Func -> x0 (Closure Object: [Code, Env])
				let code = '';
				code += compileNode(args[0]);
				code += '    str x0, [sp, #-16]!  // Push Closure\n';

				// 2. Eval Arg -> x0
				code += compileNode(args[1]);

				// 3. Prepare Call
				// x0 = Arg. 
				// Stack = Closure.

				// Load Closure to x9 (Temp)
				code += '    ldr x9, [sp], #16\n';

				// Save Arg (x0) and Closure (x9) if we need to dereference
				// Closure struct: Head = CodePtr, Tail = Env

				// Load CodePtr -> x10
				code += '    ldr x10, [x9]\n';
				// Load Env -> x9 (Reuse x9)
				code += '    ldr x9, [x9, #8]\n';

				// Call
				code += '    blr x10\n';

				return code;
			}

			// Prefix Operators (1 Arg)
			if (args.length === 1) {
				let code = '';

				// Memory Load: @ ptr
				if (op === '@' || op === '@_') {
					code += compileNode(args[0]); // Eval Ptr -> x0
					code += '    ldr x0, [x0]         // @ load\n';
					return code;
				}

				// Marker: # (Prefix) - e.g. #heap_ptr : ...
				// Just pass through for definitions.
				if (op === '#_') {
					return compileNode(args[0]);
				}

				// Abs: [| val |] -> Parser emits ["!-", val] OR ["|", val] depending on implementation.
				// If parser emits "[|", handle it.
				if (op === '[|' || op === '!-') {
					let code = compileNode(args[0]);
					// abs(x0): cmp x0, #0; cneg x0, x0, mi
					code += '    cmp x0, #0\n';
					code += '    cneg x0, x0, mi\n';
					return code;
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
							return `    adr x0, ${loc.split(':')[1]} // $ address\n`;
						}
						return `    // TODO: Address of local ${name}\n`;
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
					code += `    adr x0, sign_id // Unit (False)\n`;
					code += `    b ${lblEnd}\n`;
					code += `${lblTrue}:\n`;
					code += `    mov x0, x1 // Return RHS\n`;
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
					code += `    mov x0, x1 // Return RHS\n`;
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
					code += '    str x0, [sp, #-16]! // Push B\n';
					code += '    str x1, [sp, #-16]! // Push A\n';

					// Check A (x1)
					code += '    adr x9, sign_id\n';
					code += '    cmp x1, x9\n';
					code += `    b.ne ${lblTrue}\n`; // A is True

					// A is False (Unit). Check B.
					// If B is True -> Return B. Else Unit.
					code += '    ldr x0, [sp], #16 // Pop A (discard)\n';
					code += '    ldr x0, [sp], #16 // Pop B -> x0\n';
					code += `    b ${lblEnd}\n`; // Return B (True or False)

					code += `${lblTrue}:\n`;
					// A is True. Check B.
					// If B is False -> Return A.
					// If B is True -> Return Unit.
					code += '    ldr x1, [sp], #16 // Pop A -> x1\n';
					code += '    ldr x0, [sp], #16 // Pop B -> x0\n';

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
			if (op === '_') return compileUnit();
			return `    // UNKNOWN OP: ${op}\n`;
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

		// Fallback: Code Block / Sequence
		// If the "op" is not a known operator/keyword, assume it is a list of expressions.
		// e.g. ["_", "_"] or ["expr1", "expr2"]
		// Verify "op" is not a recognized operator?
		// The supported operators are handled above.
		// So if we reach here, treat as block.

		let blockCode = '';
		for (let expr of node) {
			blockCode += compileNode(expr);
		}
		return blockCode;

		// return `    // UNKNOWN NODE TYPE ${JSON.stringify(node)}\n`;
	}

	function compileFunction(node, name) {
		// node = ["?", [params...], body]
		const params = node[1];
		const body = node[2];
		console.log(`Compiling Function ${name || 'lambda'}: Params=`, JSON.stringify(params));

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

		// Bind Params to Registers/Stack
		let oldEnv = { ...g_env };
		g_env._stackOffset = -16; // Initialize negative stack offset (Env is at [x29, -16])

		// Bind Arguments
		// Assume single argument for now (Param 0 is x0 via Apply ABI)
		// We spill it to stack to make it addressable as local variable
		if (params.length > 0) {
			let p = params[0];
			// x0 is the argument. 
			// Spill Arg to stack.
			funcCode += `    str x0, [sp, #-16]!\n`; // sp -> sp-16. Value at [sp].
			g_env._stackOffset -= 16; // Now -32
			// logic: val is at [x29, offset]
			// x29 = old_sp.
			// str x9 (Env) at [x29, -16].
			// str x0 (Arg) at [x29, -32].
			g_env[p] = `local:${g_env._stackOffset}`;
		}

		// Unpack Free Vars from Env
		// Env is at [x29, #-16].
		// freeVars need to be pushed to stack.
		let freeVars = Array.from(analyzeFreeVars(body, new Set(params)));
		if (freeVars.length > 0) {
			funcCode += `    ldr x9, [x29, #-16] // Reload Env\n`;
			for (let i = 0; i < freeVars.length; i++) {
				let v = freeVars[i];
				// Env Node: [Val, Next]
				funcCode += `    ldr x10, [x9] // Load Val\n`;
				funcCode += `    str x10, [sp, #-16]! // Push Val\n`;
				g_env._stackOffset -= 16;
				g_env[v] = `local:${g_env._stackOffset}`;

				funcCode += `    ldr x9, [x9, #8] // Next\n`;
			}
		}
		console.log(`Env after binding: ${JSON.stringify(g_env)}`);

		console.log(`[Before Body] Env keys: ${Object.keys(g_env)}`);
		funcCode += compileNode(body);
		console.log(`[After Body] Env keys: ${Object.keys(g_env)}`);


		// Epilogue
		// Restore SP to FP (clean up locals)
		funcCode += '    mov sp, x29\n';
		funcCode += '    ldp x29, x30, [sp], #16\n';
		funcCode += '    ret\n';

		g_env = oldEnv; // Restore env

		// Output function code OUTSIDE the main flow? 
		// Usually yes. But here we can emit it inline with jump-over.

		// If it's a global definition (name != null), we don't need "load address" code in strict sense,
		// but the ":" operator usually returns the value.
		// Top-level ":" might differ.

		let result = '';
		result += setupCode;
		result += funcCode;
		result += `${afterLabel}:\n`;

		// The "value" of a function definition is its address (Closure)
		// Construct Closure [CodePtr, EnvPtr]
		let closureSetup = `    // Closure Construction for ${label}\n`;

		if (freeVars.length > 0) {
			closureSetup += `    adr x0, sign_id // Unit (End of Env)\n`;
			for (let i = freeVars.length - 1; i >= 0; i--) {
				let v = freeVars[i];
				closureSetup += `    str x0, [sp, #-16]! // Save chain (Tail)\n`;

				let loc = resolveVar(v);
				if (loc.startsWith('global:')) {
					let glbl = loc.split(':')[1];
					closureSetup += `    adr x0, ${glbl}\n`;
					if (globals[glbl] !== undefined) closureSetup += `    ldr x0, [x0]\n`;
				} else if (loc.startsWith('[')) {
					// Resolve from OUTER scope (oldEnv is active)
					closureSetup += `    ldr x0, ${loc}\n`;
				} else {
					closureSetup += `    mov x0, ${loc}\n`;
				}
				// Now x0 = Val. Pop Tail -> x1.
				closureSetup += `    ldr x1, [sp], #16\n`;

				// _cons(x1=Head=Val, x0=Tail). 
				// We have x0=Val, x1=Tail. Swap.
				closureSetup += `    mov x9, x0\n`;
				closureSetup += `    mov x0, x1\n`;
				closureSetup += `    mov x1, x9\n`;
				closureSetup += `    bl _cons\n`; // x0 = [Val, Tail]
			}
		} else {
			closureSetup += `    adr x0, sign_id\n`;
		}

		// Final Cons: [CodePtr, Env]
		closureSetup += `    str x0, [sp, #-16]! // Save Env (Tail)\n`;
		closureSetup += `    adr x1, ${label}\n`; // CodePtr (Head)
		closureSetup += `    ldr x0, [sp], #16\n`; // Pop Env
		// _cons(Head=x1, Tail=x0). Correct order.
		closureSetup += `    bl _cons\n`; // x0 = Closure

		result += closureSetup;

		return result;
	}


	function analyzeFreeVars(node, boundParams) {
		// Determine which variables are used in 'node' but not in 'boundParams'.
		// node is an AST node (list, string, number).
		// boundParams is a Set of strings.
		let free = new Set();

		function visit(n) {
			if (typeof n === 'string') {
				if (/^(-?0x|-?0o|-?0b)/.test(n)) return; // Number literal
				if (n.startsWith('`')) return; // String literal
				if (!boundParams.has(n)) {
					// Check if it's a known global/operator?
					// For now, assume anything not bound is free if it's not an operator.
					// Operators like '+', 'if' etc are strings in AST?
					// The AST structure: ["op", arg1, ...]
					// The 'op' is usually a string.
					// We need to distinguish vars from ops.
					// ops are usually in the head of a list.
					free.add(n);
				}
				return;
			}
			if (typeof n === 'number') return;
			if (Array.isArray(n)) {
				if (n.length === 0) return;
				// List: [op, ...args]
				// Op is usually not a variable, except in higher-order cases?
				// For Sign, op is just a symbol.
				let op = n[0];
				let args = n.slice(1);

				// Special forms
				if (op === '?') {
					// Function: ["?", [params], body]
					// Inner params bound in body.
					let [_, params, body] = n;
					let newBound = new Set(boundParams);
					if (Array.isArray(params)) {
						params.forEach(p => newBound.add(p));
					} else {
						// Single param?
						newBound.add(params);
					}
					// Visit body with new scope
					let subFree = analyzeFreeVars(body, newBound);
					subFree.forEach(v => free.add(v));
					return;
				}

				if (op === ':') {
					// Def: [":", name, body]
					// name is binding?
					// In "let x = 1 in ...", x is bound.
					// In "x : 1", x is global or label.
					// In local scope? 
					// Current compiler doesn't support local ':' yet except as label?
					// Let's assume standard recursion validation for args.
				}

				// Visit args
				args.forEach(visit);
			}
		}

		visit(node);
		return free;
	}

	function compileUnit() {
		return `    adr x0, sign_id\n`;
	}

	// --- Main ---
	let asm = '';

	// Preamble
	asm += `.global __sign_init\n`;
	asm += `.text\n`;

	// Entry Point
	asm += `__sign_init:\n`;
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
	asm += `    mov x8, #93       // svc exit\n`;
	asm += `    svc #0\n`;
	asm += `\n`;

	// Runtime (Builtin Functions)
	// Runtime (Builtin Functions)
	// sign_id is defined in runtime.s

	// Data Section
	asm += `\n.data\n`;
	for (let [content, lbl] of Object.entries(stringTable)) {
		// Escape content? For now simple
		asm += `${lbl}: .asciz "${content}"\n`;
	}

	// Runtime Functions are defined in runtime.s

	// Globals
	for (let [name, val] of Object.entries(globals)) {
		asm += `${name}: .quad ${val}\n`;
	}

	// Heap Buffer is defined in runtime.s

	fs.writeFileSync(OUTPUT_FILE, asm);
	console.log(`Generated ${OUTPUT_FILE}`);
}
