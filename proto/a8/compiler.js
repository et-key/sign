
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Compiler Options
const defaultOptions = {
	target: "aarch64",
	output: "output.s",
	entry: "main.sn",
	debug: false,
	optimize: false,
	mode: "compile",
	ExceptionLevel: 0,
	link: "static"
};

let options = { ...defaultOptions };

// Parse Args (Pass 1: Get Input File)
const args = process.argv.slice(2);
let INPUT_FILE = null;
for (let arg of args) {
	if (!arg.startsWith('-')) {
		INPUT_FILE = arg;
		break;
	}
}

// Load config
try {
	let configDirs = [process.cwd()];
	if (INPUT_FILE) {
		configDirs.unshift(path.dirname(path.resolve(INPUT_FILE)));
	}
	configDirs.push(__dirname); // Fallback to compiler dir

	let loaded = false;
	for (let dir of configDirs) {
		const configPath = path.join(dir, 'option.json');
		if (fs.existsSync(configPath)) {
			const data = fs.readFileSync(configPath, 'utf8');
			const json = JSON.parse(data);
			options = { ...options, ...json };
			if (options.debug) console.log(`Loaded option.json from ${dir}`);
			loaded = true;
			break; // Stop at first find? Or merge? User said "folder specific", usually implies nearest wins.
		}
	}
} catch (e) {
	console.warn("Failed to load option.json:", e.message);
}

// Parse Args (Pass 2: Overrides)
for (let i = 0; i < args.length; i++) {
	const arg = args[i];
	if (arg === '-o') {
		options.output = args[++i];
	} else if (arg === '-O') {
		options.optimize = true;
	} else if (arg === '-g') {
		options.debug = true;
	}
}

const OUTPUT_FILE = path.isAbsolute(options.output) ? options.output : path.resolve(process.cwd(), options.output);

if (!INPUT_FILE) {
	console.error("Usage: node compiler.js <ast_json_file> [-o output] [-O] [-g]");
	process.exit(1);
}

const AST = JSON.parse(fs.readFileSync(INPUT_FILE, 'utf8'));

// --- Instruction Dictionary ---
const TEMPLATES = {
	'+': 'bl _add',
	'-': 'sub x0, x1, x0',
	'*': 'mul x0, x1, x0',
	'/': 'sdiv x0, x1, x0',
	'%': 'sdiv x2, x1, x0\n    msub x0, x2, x0, x1',
	'^': 'bl _pow',

	// Bitwise
	'<<': 'lsl x0, x1, x0',
	'>>': 'asr x0, x1, x0',
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
let g_env = {};
let stringTable = {}; // content -> label
let stringCounter = 0;
let globals = {
	"_print_str": "closure_print_str",
	"_print_char": "closure_print_char"
};

const runtimeClosures = {
	"_print_str": "closure_print_str",
	"_print_char": "closure_print_char",
	"_print_str": "closure_print_str",
	"_print_char": "closure_print_char",
	"_read_char": "sign_id",
	"__sys_write": "_sys_write",
	"__sys_brk": "_sys_brk"
};

function resolveVar(name) {
	if (runtimeClosures[name]) {
		return `    adr x0, ${runtimeClosures[name]}\n    orr x0, x0, #1 // Tag closure\n`;
	}

	if (g_env[name] !== undefined) {
		let val = g_env[name];
		if (val.startsWith && val.startsWith('local:')) {
			return `[x29, #${val.split(':')[1]}]`;
		}
		return val;
	}
	return `global:${name}`;
}

function compileNode(node) {
	if (!node) return compileUnit();

	// 1. Block (Short-Circuit OR or Dictionary)
	if (node.type === 'block') {
		// Heuristic: If all statements in the block are `infix :` (definitions) OR `postfix ~` (spread), it acts as a Dictionary Environment
		let isDict = node.body.length > 0 && node.body.every(stmt =>
			(stmt.type === 'infix' && stmt.op === ':' && stmt.left && stmt.left.type === 'identifier') ||
			(stmt.type === 'postfix' && stmt.op === '~')
		);

		if (isDict) {
			let code = `    adr x0, sign_id\n    str x0, [sp, #-16]!\n`; // Nil tail

			// Build dictionary list in reverse order
			for (let i = node.body.length - 1; i >= 0; i--) {
				let stmt = node.body[i];

				if (stmt.type === 'postfix' && stmt.op === '~') {
					// Spread operator: Evaluate dict to spread and concat
					code += compileNode(stmt.expr); // Evaluate dict -> x0
					code += `    mov x1, x0\n`;      // x1 = spread_dict
					code += `    ldr x0, [sp], #16\n`; // x0 = current_built_tail
					// Spread logic: The rightmost items should be at the base of the list.
					// Actually, if we are building backwards:
					// current_built_tail currently has the items defined *after* this spread.
					// We want: spread_dict concatenated with current_built_tail.
					// _concat(x0=spread_dict, x1=current_built_tail) -> x0
					code += `    mov x2, x0\n`; // temp
					code += `    mov x0, x1\n`; // x0 = spread_dict
					code += `    mov x1, x2\n`; // x1 = current_built_tail
					code += `    bl _concat\n`;
					code += `    str x0, [sp, #-16]!\n`; // push new tail
					continue;
				}

				let key = stmt.left.value;
				let valNode = stmt.right;

				// Ensure string key is in string table
				let lblKey = stringTable[key];
				if (!lblKey) {
					lblKey = `str_${stringCounter++}`;
					stringTable[key] = lblKey;
				}

				// Compile Value
				code += compileNode(valNode);
				code += `    str x0, [sp, #-16]!\n`;

				// Load Key
				code += `    adr x0, ${lblKey}\n`;
				code += `    mov x1, x0\n`;
				// Pop Value
				code += `    ldr x0, [sp], #16\n`;

				// Make Pair [Key, Value] -> x1=Key, x0=Value
				code += `    bl _cons\n`;

				// Push Pair onto List
				code += `    mov x1, x0\n`;
				code += `    ldr x0, [sp], #16\n`; // Pop tail
				code += `    bl _cons\n`;

				// Push current list
				code += `    str x0, [sp, #-16]!\n`;
			}
			code += `    ldr x0, [sp], #16\n`;
			return code;
		}

		let code = '';
		let lblEnd = generateLabel("blk_end");
		for (let i = 0; i < node.body.length; i++) {
			code += compileNode(node.body[i]);
			// If not last expression, check if result != Unit
			if (i < node.body.length - 1) {
				code += `    adr x9, sign_id\n`;
				code += `    cmp x0, x9\n`;
				code += `    b.ne ${lblEnd}\n`;
			}
		}
		code += `${lblEnd}:\n`;
		return code;
	}

	// 2. Literals
	if (node.type === 'number') {
		// ... (omitted) ...

		const val = node.value;
		if (Number.isInteger(val) && val >= -65536 && val <= 65535) {
			return `    mov x0, #${val}\n`;
		}
		const buf = new ArrayBuffer(8);
		new DataView(buf).setFloat64(0, val, true); // Little endian
		const bigVal = new DataView(buf).getBigUint64(0, true);
		return `    ldr x0, =0x${bigVal.toString(16)}\n`;
	}

	if (node.type === 'string') {
		let content = node.value.slice(1, -1);
		if (content.startsWith('`') && content.endsWith('`')) {
			content = content.slice(1, -1);
		}

		let lbl = stringTable[content];
		if (!lbl) {
			lbl = `str_${stringCounter++}`;
			stringTable[content] = lbl;
		}
		return `    adr x0, ${lbl}\n`;
	}
	if (node.type === 'char') {
		let val = node.value;
		// No escapes: just take the character value.
		// Parser passed sliced value (e.g. "b" for "\b").
		let codeVal = val.charCodeAt(0);
		return `    mov x0, #${codeVal}\n`;
	}
	if (node.type === 'identifier') {
		let name = node.value;
		if (name === '_') return compileUnit();

		let loc = resolveVar(name);
		if (loc.startsWith('global:')) {
			let label = loc.split(':')[1];
			if (globals[label] !== undefined) {
				return `    adr x0, ${label}\n    ldr x0, [x0]\n`;
			} else {
				return `    adr x0, ${label}\n`;
			}
		}

		if (loc.startsWith('[')) {
			return `    ldr x0, ${loc}\n`;
		}
		return `    mov x0, ${loc}\n`;
	}

	if (node.type === 'unit') {
		return compileUnit();
	}

	// 3. Prefix
	if (node.type === 'prefix') {
		return compilePrefix(node);
	}

	// 4. Infix
	if (node.type === 'infix') {
		return compileInfix(node);
	}

	// 5. Postfix
	if (node.type === 'postfix') {
		return compilePostfix(node);
	}

	// 6. Apply
	if (node.type === 'apply') {
		return compileApply(node);
	}

	// 7. Abs
	if (node.type === 'abs') {
		let code = compileNode(node.expr);
		let lblPos = generateLabel("abs_pos");
		code += '    cmp x0, #0\n';
		code += `    b.ge ${lblPos}\n`;
		code += '    neg x0, x0\n';
		code += `${lblPos}:\n`;
		return code;
	}

	return `    // UNKNOWN NODE TYPE ${node.type}\n`;
}

function compileUnit() {
	return `    adr x0, sign_id\n`;
}

function compilePrefix(node) {
	const op = node.op;
	const expr = node.expr || { type: 'unit' };

	if (op === '@') {
		// Magic IO Read (stdin = 0)
		if (expr.type === 'number' && expr.value === 0) {
			return `    bl _read_char\n`;
		}

		let code = compileNode(expr);
		code += '    ldr x0, [x0] // @ load\n';
		return code;
	}

	if (op === '!') {
		let code = compileNode(expr);
		let lblTrue = generateLabel("not_true");
		let lblEnd = generateLabel("not_end");
		code += '    adr x9, sign_id\n';
		code += '    cmp x0, x9\n';
		code += `    b.eq ${lblTrue}\n`;
		code += '    adr x0, sign_id\n';
		code += `    b ${lblEnd}\n`;
		code += `${lblTrue}:\n`;
		code += '    mov x0, #0\n';
		code += `${lblEnd}:\n`;
		return code;
	}

	if (op === '$') {
		if (expr.type === 'identifier') {
			let name = expr.value;
			let loc = resolveVar(name);

			// Auto-allocation if not found
			if (!loc) {
				if (g_env._stackOffset === undefined) g_env._stackOffset = 0;
				g_env._stackOffset -= 16;
				g_env[name] = `local:${g_env._stackOffset}`;
				loc = resolveVar(name);
				return `    sub sp, sp, #16 // Alloc ${name}\n    mov x0, sp // Address of new var\n`;
			}

			if (loc.startsWith('global:')) {
				return `    adr x0, ${loc.split(':')[1]}\n`;
			}
			if (loc.startsWith('[')) {
				let offset = parseInt(loc.match(/#(-?\d+)/)[1]);
				return `    add x0, x29, #${offset}\n`;
			}
		}
	}

	if (op === '!!') {
		let code = compileNode(expr);
		code += '    mvn x0, x0\n';
		return code;
	}

	return compileNode(expr);
}

function compilePostfix(node) {
	const op = node.op;
	const expr = node.expr || { type: 'unit' };
	let code = compileNode(expr);

	if (op === '!') {
		code += '    bl _factorial\n';
	}
	return code;
}

function compileInfix(node) {
	const op = node.op;
	const left = node.left || { type: 'unit' };
	const right = node.right || { type: 'unit' };

	if (op === ':') {
		let name = null;
		if (left.type === 'identifier') {
			name = left.value;
		} else {
			// Conditional: expr : expr
			let lblFalse = generateLabel("cond_false");
			let lblEnd = generateLabel("cond_end");

			// Compile Left (Condition)
			let code = compileNode(left);
			code += `    adr x9, sign_id\n`;
			code += `    cmp x0, x9\n`;
			code += `    b.eq ${lblFalse}\n`;

			// True: Compile Right
			code += compileNode(right);
			code += `    b ${lblEnd}\n`;

			// False: Return Unit
			code += `${lblFalse}:\n`;
			code += `    adr x0, sign_id\n`;

			code += `${lblEnd}:\n`;
			return code;
		}

		if (right.type === 'infix' && right.op === '?') {
			if (name && g_env._stackOffset === undefined) globals[name] = 0;
			let code = compileFunction(right, name);
			code += `    adr x0, sign_id\n`; // Definition returns Unit
			return code;
		}

		if (g_env._stackOffset === undefined) {
			if (name) globals[name] = 0;
			let code = compileNode(right);
			if (name) {
				code += `    adr x1, ${name}\n`;
				code += `    str x0, [x1]\n`;
			}
			code += `    adr x0, sign_id\n`; // Definition returns Unit
			return code;
		} else {
			let code = compileNode(right);
			code += '    str x0, [sp, #-16]!\n';
			if (!g_env._stackOffset) g_env._stackOffset = 0;
			g_env._stackOffset -= 16;
			if (name) g_env[name] = `local:${g_env._stackOffset}`;
			code += `    adr x0, sign_id\n`; // Definition returns Unit
			return code;
		}
	}


	if (op === '?') {
		return compileFunction(node, null);
	}

	if (op === '#') {
		// Magic IO Write (1=stdout, 2=stderr)
		let isMagic = false;
		let fd = 1;
		if (left.type === 'number') {
			if (left.value === 1) { isMagic = true; fd = 1; }
			if (left.value === 2) { isMagic = true; fd = 2; }
		}


		if (isMagic) {
			let code = compileNode(right);

			let lblPrintNum = generateLabel("print_num");
			let lblPrintStr = generateLabel("print_str");
			let lblDone = generateLabel("print_done");

			// Check if x0 is a pointer (> 4096) or Number
			code += '    cmp x0, #4096\n';
			code += `    b.hi ${lblPrintStr}\n`;

			// Print Number
			code += `${lblPrintNum}:\n`;
			code += '    bl _print_int\n';
			code += `    b ${lblDone}\n`;

			// Print String
			code += `${lblPrintStr}:\n`;
			code += `    // Magic IO Write to FD ${fd}\n`;
			code += `    mov x1, x0       // buf = RHS\n`;
			code += `    mov x0, #${fd}   // fd\n`;

			// Calculate length (strlen logic)
			code += `    mov x2, #0       // len\n`;
			let lblLoop = generateLabel("strlen");
			let lblStrDone = generateLabel("strlen_done");
			code += `${lblLoop}:\n`;
			code += `    ldrb w3, [x1, x2]\n`;
			code += `    cbz w3, ${lblStrDone}\n`;
			code += `    add x2, x2, #1\n`;
			code += `    b ${lblLoop}\n`;
			code += `${lblStrDone}:\n`;

			code += `    mov x8, #64      // syscall write\n`;
			code += `    svc #0\n`;

			code += `${lblDone}:\n`;
			code += '    adr x0, sign_id\n';
			return code;
		}

		let code = compileNode(left);
		code += '    str x0, [sp, #-16]!\n';
		code += compileNode(right);
		code += '    ldr x1, [sp], #16\n';
		code += '    str x0, [x1]\n';
		return code;
	}

	if (op === '&') {
		let lblFail = generateLabel("and_fail");
		let lblEnd = generateLabel("and_end");
		let code = compileNode(left);
		code += '    adr x9, sign_id\n';
		code += '    cmp x0, x9\n';
		code += `    b.eq ${lblFail}\n`;
		code += compileNode(right);
		code += `    b ${lblEnd}\n`;
		code += `${lblFail}:\n`;
		code += '    adr x0, sign_id\n';
		code += `${lblEnd}:\n`;
		return code;
	}

	if (op === ';') {
		let lblTrue = generateLabel("xor_true");
		let lblFalse = generateLabel("xor_false");
		let lblEnd = generateLabel("xor_end");

		let code = compileNode(left);
		code += '    str x0, [sp, #-16]!\n';
		code += compileNode(right);
		code += '    ldr x1, [sp], #16\n';

		code += '    str x0, [sp, #-16]!\n';
		code += '    str x1, [sp, #-16]!\n';

		code += '    adr x9, sign_id\n';
		code += '    cmp x1, x9\n';
		code += `    b.ne ${lblTrue}\n`;

		code += '    ldr x0, [sp], #16\n';
		code += '    ldr x0, [sp], #16\n';
		code += `    b ${lblEnd}\n`;

		code += `${lblTrue}:\n`;
		code += '    ldr x1, [sp], #16\n';
		code += '    ldr x0, [sp], #16\n';
		code += '    adr x9, sign_id\n';
		code += '    cmp x0, x9\n';
		code += `    b.eq ${lblFalse}\n`;

		code += '    adr x0, sign_id\n';
		code += `    b ${lblEnd}\n`;

		code += `${lblFalse}:\n`;
		code += '    mov x0, x1\n';
		return code;
	}

	if (op === '||') {
		// Bitwise OR (User: bit_or)
		let code = compileNode(left);
		code += '    str x0, [sp, #-16]!\n';
		code += compileNode(right);
		code += '    mov x1, x0\n';
		code += '    ldr x0, [sp], #16\n';
		code += '    orr x0, x1, x0\n';
		return code;
	}

	if (op === '|') {
		// Logic OR (User: logic_or)
		// Short-circuit? "First Truthy".
		// Truthy = Not Unit AND Not 0?
		// User example: 0 | 1 -> 1. So 0 is "Falseish" for this op?

		let lblRight = generateLabel("or_right");
		let lblEnd = generateLabel("or_end");

		let code = compileNode(left);
		// Check if False (Unit)
		code += '    adr x9, sign_id\n';
		code += '    cmp x0, x9\n';
		code += `    b.eq ${lblRight}\n`;

		// If here, LHS is Truthy. Return LHS.
		code += `    b ${lblEnd}\n`;

		code += `${lblRight}:\n`;
		code += compileNode(right);

		code += `${lblEnd}:\n`;
		return code;
	}

	if (['=', '<', '>', '<=', '>=', '!='].includes(op)) {
		let lblTrue = generateLabel("cmp_true");
		let lblEnd = generateLabel("cmp_end");

		let code = compileNode(left);
		code += '    str x0, [sp, #-16]!\n';
		code += compileNode(right);
		code += '    mov x1, x0\n';
		code += '    ldr x0, [sp], #16\n';
		code += '    cmp x0, x1\n';

		let cond = 'eq';
		if (op === '!=') cond = 'ne';
		if (op === '<') cond = 'lt';
		if (op === '>') cond = 'gt';
		if (op === '<=') cond = 'le';
		if (op === '>=') cond = 'ge';

		code += `    b.${cond} ${lblTrue}\n`;
		code += '    adr x0, sign_id\n';
		code += `    b ${lblEnd}\n`;
		code += `${lblTrue}:\n`;
		// Mixed Return Strategy for Chaining:
		// If Left is Literal (Bound), return Right (Value).
		// If Left is Variable/Expr (Value), return Left (Value).
		if (['number', 'string'].includes(left.type)) {
			code += '    mov x0, x1\n'; // Return RHS
		} else {
			// Return LHS (already in x0)
		}
		code += `${lblEnd}:\n`;
		return code;
	}

	// Dictionary Access (left-associative)
	if (op === "'") {
		let code = compileNode(left);
		code += '    str x0, [sp, #-16]!\n';
		if (right.type === 'identifier') {
			let lbl = stringTable[right.value];
			if (!lbl) {
				lbl = `str_${stringCounter++}`;
				stringTable[right.value] = lbl;
			}
			code += `    adr x0, ${lbl}\n`;
		} else {
			code += compileNode(right);
		}
		code += '    mov x1, x0\n'; // Key -> x1
		code += '    ldr x0, [sp], #16\n'; // Dict -> x0
		code += '    bl _dict_get\n';
		return code;
	}

	// Dictionary Access (right-associative)
	if (op === "@") {
		let code = compileNode(right);
		code += '    str x0, [sp, #-16]!\n';
		if (left.type === 'identifier') {
			let lbl = stringTable[left.value];
			if (!lbl) {
				lbl = `str_${stringCounter++}`;
				stringTable[left.value] = lbl;
			}
			code += `    adr x0, ${lbl}\n`;
		} else {
			code += compileNode(left);
		}
		code += '    mov x1, x0\n'; // Key -> x1
		code += '    ldr x0, [sp], #16\n'; // Dict -> x0
		code += '    bl _dict_get\n';
		return code;
	}

	let code = compileNode(left);
	code += '    str x0, [sp, #-16]!\n';
	code += compileNode(right);
	code += '    ldr x1, [sp], #16\n';

	if (op === ',') {
		code += '    bl _cons\n';
		return code;
	}
	if (op === '~') {
		code += '    bl _concat\n'; // Array/Dictionary Spread
		return code;
	}

	if (TEMPLATES[op]) {
		code += `    ${TEMPLATES[op]}\n`;
		return code;
	}

	return code;
}

function compileApply(node) {
	let code = '';

	// Spread Concat via Whitespace Apply
	if (node.func && node.func.type === 'postfix' && node.func.op === '~') {
		let funcCode = compileNode(node.func.expr); // target list
		let argCode = compileNode(node.arg);        // items to concat

		code += funcCode;
		code += '    str x0, [sp, #-16]!\n';
		code += argCode;
		code += '    mov x1, x0\n';
		code += '    ldr x0, [sp], #16\n';
		code += '    bl _concat\n';
		return code;
	}

	// Optimization: Static Inline Composition
	// Check if both Func and Arg are static lambda definitions (infix '?')
	if (node.func.type === 'infix' && node.func.op === '?' &&
		node.arg.type === 'infix' && node.arg.op === '?') {

		// We have [Outer] [Inner].
		// Outer: node.func
		// Inner: node.arg
		// Goal: Create a new function H that does Inner then Outer.

		let label = generateLabel("inline_composed");
		let afterLabel = generateLabel("after_" + label);
		let setupCode = `    b ${afterLabel}\n`;
		let funcCode = `${label}:\n`;

		// Standard Prologue
		funcCode += '    stp x29, x30, [sp, #-16]!\n';
		funcCode += '    mov x29, sp\n';

		// Setup environment (simulate compileFunction partially)
		let oldEnv = { ...g_env };
		g_env._stackOffset = -16;

		// We assume both distinct functions use the same argument name (e.g. $1) or compatible checking
		// For this prototype, we assume single argument '$1' logic from the AST we saw.
		// We need to allocate space for the argument.
		// H(x) is called. x is in x0 or stack?
		// Logic:
		// 1. H(x) is called. x is passed (likely in x0, or if this is Apply, we are pushing to stack?)
		// Wait, compileFunction usually expects args.
		// Use compileFunction logic to setup ONE argument frame.

		let params = [];
		// Extract params from Inner (Arg) - it determines the input signature of H
		if (node.arg.left) {
			let collectParams = (n) => {
				if (n.type === 'identifier') params.push(n.value);
				else if (n.type === 'infix' && n.op === ',') {
					collectParams(n.left);
					collectParams(n.right);
				}
			};
			collectParams(node.arg.left);
		}

		if (params.length > 0) {
			let p = params[0]; // Primary arg (e.g. $1)
			funcCode += '    str x0, [sp, #-16]!\n'; // Push Arg
			g_env._stackOffset -= 16;
			g_env[p] = `local:${g_env._stackOffset}`;
		}

		// 2. Compile Left Body (Outer: node.func)
		funcCode += `    // Inline: Left Body\n`;
		funcCode += compileNode(node.func.right);
		// Result is in x0.

		// 3. Chain: Update the Argument slot with the result!
		// So Right reads this result as its '$1'.
		if (params.length > 0) {
			let p = params[0];
			let loc = g_env[p]; // local:-32
			let offset = parseInt(loc.split(':')[1]);
			funcCode += `    // Inline: Chaining (Update ${p})\n`;
			funcCode += `    str x0, [x29, #${offset}]\n`;
		}

		// 4. Compile Right Body (Inner: node.arg)
		funcCode += `    // Inline: Right Body\n`;
		funcCode += compileNode(node.arg.right);
		// Result is in x0.

		// Standard Eqpilegue
		funcCode += '    mov sp, x29\n';
		funcCode += '    ldp x29, x30, [sp], #16\n';
		funcCode += '    ret\n';

		g_env = oldEnv;

		// Emit the function definition
		code += setupCode + funcCode + `${afterLabel}:\n`;

		// Return the closure of this new function
		// For prototype, assume no free vars in these simple lambdas
		code += `    adr x0, sign_id\n`; // Nil Env
		code += `    str x0, [sp, #-16]!\n`;
		code += `    adr x1, ${label}\n`;
		code += `    ldr x0, [sp], #16\n`;
		code += `    bl _cons\n`; // Make Closure [Function, Env]
		code += `    orr x0, x0, #1 // Tag closure\n`;

		return code;
	}

	// 1. Compile Func -> Stack
	code += compileNode(node.func);
	code += '    str x0, [sp, #-16]!\n';

	// 2. Compile Arg -> x0
	code += compileNode(node.arg);

	let lblApply = generateLabel("do_apply");
	let lblConcat = generateLabel("do_concat");
	let lblEnd = generateLabel("apply_end");

	code += '    ldr x1, [sp], #16\n'; // Pop Func into x1

	// Check if LHS (x1) is >= heap_buffer
	code += `    adr x9, heap_buffer\n`;
	code += `    cmp x1, x9\n`;
	code += `    b.lo ${lblConcat}\n`;

	// Check if LHS (x1) is a function (tagged with #1)
	code += `    tst x1, #1\n`;
	code += `    b.eq ${lblConcat}\n`; // LHS=Data -> Concat

	// Case A: Apply (LHS=Func, RHS=Data)
	code += `${lblApply}:\n`;
	code += '    bic x1, x1, #1\n';   // Clear tag from Func
	code += '    ldr x2, [x1]\n';     // Code
	code += '    ldr x9, [x1, #8]\n';  // Env
	code += '    blr x2\n';
	code += `    b ${lblEnd}\n`;

	// Case B: Concat (LHS=Data, RHS=Any)
	code += `${lblConcat}:\n`;
	code += '    mov x2, x0\n';
	code += '    mov x0, x1\n';        // x0 = LHS
	code += '    mov x1, x2\n';        // x1 = RHS
	code += '    bl _concat\n';

	code += `${lblEnd}:\n`;

	return code;
}

function compileFunction(node, name) {
	let params = [];
	if (node.left) {
		let collectParams = (n) => {
			if (n.type === 'identifier') params.push(n.value);
			else if (n.type === 'infix' && n.op === ',') {
				collectParams(n.left);
				collectParams(n.right);
			}
			// Handle Apply as Parameter List (e.g. x y ?)
			// Apply(Apply(x, y), z) -> [x, y, z]
			else if (n.type === 'apply') {
				collectParams(n.func);
				collectParams(n.arg);
			}
		};
		collectParams(node.left);
	}

	let body = node.right || { type: 'unit' };

	let label = name ? name + "_impl" : generateLabel("func");
	let afterLabel = generateLabel("after_" + label);

	let setupCode = `    b ${afterLabel}\n`;
	let funcCode = `${label}:\n`;
	funcCode += '    stp x29, x30, [sp, #-16]!\n';
	funcCode += '    mov x29, sp\n';

	let oldEnv = { ...g_env };
	g_env._stackOffset = -16;

	if (params.length > 0) {
		let p = params[0];
		funcCode += '    str x0, [sp, #-16]!\n';
		g_env._stackOffset -= 16;
		g_env[p] = `local:${g_env._stackOffset}`;
	}

	let freeVars = analyzeFreeVars(body, new Set(params));
	// Filter out globals from freeVars
	freeVars = freeVars.filter(v => {
		let loc = resolveVar(v);
		return !loc.startsWith('global:') && !runtimeClosures[v];
	});

	if (freeVars.length > 0) {
		funcCode += `    ldr x9, [x29, #-16] // Reload Env\n`;
		for (let v of freeVars) {
			funcCode += `    ldr x10, [x9] // Load Val\n`;
			funcCode += `    str x10, [sp, #-16]! // Push Val\n`;
			g_env._stackOffset -= 16;
			g_env[v] = `local:${g_env._stackOffset}`;
			funcCode += `    ldr x9, [x9, #8] // Next\n`;
		}
	}

	funcCode += compileNode(body);

	funcCode += '    mov sp, x29\n';
	funcCode += '    ldp x29, x30, [sp], #16\n';
	funcCode += '    ret\n';

	g_env = oldEnv;

	let result = setupCode + funcCode + `${afterLabel}:\n`;

	let closureSetup = `    // Closure for ${label}\n`;
	if (freeVars.length > 0) {
		closureSetup += `    adr x0, sign_id\n`;
		for (let i = freeVars.length - 1; i >= 0; i--) {
			let v = freeVars[i];
			closureSetup += `    str x0, [sp, #-16]!\n`;
			let loc = resolveVar(v);
			if (loc.startsWith('global:')) {
				let glbl = loc.split(':')[1];
				closureSetup += `    adr x0, ${glbl}\n`;
				if (globals[glbl] !== undefined) closureSetup += `    ldr x0, [x0]\n`;
			} else if (loc.startsWith('[')) {
				closureSetup += `    ldr x0, ${loc}\n`;
			} else {
				closureSetup += `    mov x0, ${loc}\n`;
			}
			closureSetup += `    ldr x1, [sp], #16\n`;
			closureSetup += `    mov x9, x0\n    mov x0, x1\n    mov x1, x9\n    bl _cons\n`;
		}
	} else {
		closureSetup += `    adr x0, sign_id\n`;
	}

	closureSetup += `    str x0, [sp, #-16]!\n`;
	closureSetup += `    adr x1, ${label}\n`;
	closureSetup += `    ldr x0, [sp], #16\n`;
	closureSetup += `    bl _cons\n`;

	result += closureSetup;
	return result;
}

function analyzeFreeVars(node, bound) {
	let free = new Set();
	function visit(n) {
		if (!n) return;
		if (n.type === 'identifier') {
			if (!bound.has(n.value) && n.value !== '_') free.add(n.value);
			return;
		}
		if (n.type === 'block') {
			n.body.forEach(visit);
			return;
		}
		if (n.type === 'prefix') {
			visit(n.expr);
			return;
		}
		if (n.type === 'postfix') {
			visit(n.expr);
			return;
		}
		if (n.type === 'infix') {
			if (n.op === '?') {
				let subParams = new Set(bound);
				let collectP = (paramNode) => {
					if (!paramNode) return;
					if (paramNode.type === 'identifier') subParams.add(paramNode.value);
					else if (paramNode.type === 'infix' && paramNode.op === ',') {
						collectP(paramNode.left);
						collectP(paramNode.right);
					}
				};
				if (n.left) collectP(n.left);

				let innerFree = analyzeFreeVars(n.right, subParams);

				for (let v of innerFree) {
					if (!bound.has(v)) free.add(v);
					else { }
				}
				return;
			}
			visit(n.left);
			visit(n.right);
			return;
		}
		if (n.type === 'apply') {
			visit(n.func);
			visit(n.arg);
			return;
		}
	}
	visit(node);
	return Array.from(free);
}

// --- Main Execution ---
let mainCode = compileNode(AST);

let dataSection = '.data\n';
for (let [content, lbl] of Object.entries(stringTable)) {
	dataSection += `${lbl}: .asciz "${content}"\n`;
}

let bssSection = '.bss\n';
for (let name of Object.keys(globals)) {
	if (globals[name] === 0) {
		bssSection += `${name}: .quad 0\n`;
	}
}

let finalOutput = `// Sign Compiler Output
// Target: ${options.target}
// Mode: ${options.mode}
// Exception Level: ${options.ExceptionLevel}
// Link: ${options.link}
// Options: debug=${options.debug}, optimize=${options.optimize}

.global __sign_init
.text
__sign_init:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

${mainCode}


    ldp x29, x30, [sp], #16
    ret
`;

finalOutput += `
// --- Runtime Helpers for Composition ---

// _is_func: x0 -> x0 (1 if func, 0 if not)
// Simple heuristic: If > 4096, it's a pointer (Func). Else Number.
// (Very naive, needs tagging later)
_is_func:
    cmp x0, #4096
    b.hi .L_is_func_true
    mov x0, #0
    ret
.L_is_func_true:
    mov x0, #1
    ret

// _compose: x0=f, x1=g -> Returns Closure h(x) = g(f(x))
// Creates a closure that captures f and g.
// The code for h is _composed_impl.
_compose:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Save f(x0) and g(x1) to stack to build closure
    str x0, [sp, #-16]! // f
    str x1, [sp, #-16]! // g
    
    // Create Env list: [g, f] (cons g (cons f sign_id)) ?
    // Environment for _composed_impl needs f and g.
    // Env: [g, [f, sign_id]]
    
    adr x0, sign_id
    str x0, [sp, #-16]! // nil
    
    ldr x0, [x29, #-16] // Load f
    ldr x1, [sp], #16   // Pop nil
    bl _cons            // x0 = [f, nil]
    str x0, [sp, #-16]! // Push env
    
    ldr x0, [x29, #-32] // Load g
    ldr x1, [sp], #16   // Pop env
    bl _cons            // x0 = [g, [f, nil]]
    
    // Create Closure: [_composed_impl, Env]
    str x0, [sp, #-16]! // Env
    adr x0, _composed_impl
    ldr x1, [sp], #16   // Env
    bl _cons            // Closure
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _composed_impl: x0=Arg. Env=[g, [f, nil]]
// Logic: g( f(Arg) )
_composed_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Save Arg
    str x0, [sp, #-16]!
    
    str x9, [sp, #-16]! // Save Env to Stack (local var 1)
    
    // 1. Call f(Arg)
    // We need f.
    // Env -> [g, rest]. rest -> [f, nil].
    ldr x10, [x9, #8] // rest = [f, nil]
    ldr x10, [x10]    // f (Closure)
    str x10, [sp, #-16]! // Save f
    
    // Prepare Call to f
    // x0 is Arg (already in x0)
    // closure in x10
    // Unpack f
    mov x9, x10
    ldr x10, [x9]     // Code
    ldr x9, [x9, #8]  // f's Env
    blr x10           // Call f(Arg) -> returns result in x0
    
    // 2. Call g(Result)
    // Result is in x0.
    // Load g from saved Env (at [sp, #16])
    ldr x9, [sp, #16] // Reload 'Env' (which was saved at start)
    
    // Reload Env
    ldr x11, [sp, #16] // Env
    ldr x10, [x11]     // g (Closure)
    
    // Unpack g
    mov x9, x10
    ldr x10, [x9]     // Code
    ldr x9, [x9, #8]  // g's Env
    blr x10           // Call g(f(Arg)) -> returns result
    
    // Clean up stack
    add sp, sp, #32 // Pop f, Env.
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _pow: x0 (base), x1 (exp) -> x0 (result)
_pow:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    // Check if exp < 0 (Return 0 for integer pow?)
    cmp x1, #0
    b.lt .L_pow_zero 
    mov x2, #1        // result = 1
    mov x3, x0        // base
    mov x4, x1        // exp

.L_pow_loop:
    cbz x4, .L_pow_done
    tst x4, #1
    b.eq .L_pow_square
    mul x2, x2, x3
.L_pow_square:
    lsr x4, x4, #1
    mul x3, x3, x3
    b .L_pow_loop

.L_pow_zero:
    mov x2, #0
.L_pow_done:
    mov x0, x2
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _print_int: x0 = integer
// Prints integer to stdout
_print_int:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Handle 0 explicitly
    cmp x0, #0
    b.ne .L_print_int_not_zero
    
    // Print "0"
    mov x0, #1 // stdout
    adr x1, .L_str_zero
    mov x2, #1 // len
    mov x8, #64 // write
    svc #0
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
    
.L_print_int_not_zero:
    // We need a buffer. Use stack.
    // Max 64-bit int is ~20 digits.
    sub sp, sp, #64         // Alloc 64 bytes
    mov x9, sp              // buffer start
    add x9, x9, #63         // buffer end
    strb wzr, [x9]          // null terminate? Not needed for write syscall if we know len.
    sub x9, x9, #1          // Move back
    
    mov x10, #10            // divisor
    mov x11, x0             // number
    
    // Loop
.L_print_int_loop:
    udiv x12, x11, x10      // q = n / 10
    msub x13, x12, x10, x11 // r = n - q * 10
    
    add w13, w13, #48       // '0'
    strb w13, [x9]
    sub x9, x9, #1
    
    mov x11, x12
    cbnz x11, .L_print_int_loop
    
    // Print
    add x1, x9, #1          // Start address
    
    // Length = (sp + 63) - (x9 + 1) + 1?
    // End is sp+63.
    // Start is x1.
    // Len = (sp+63) - x1.
    mov x2, sp
    add x2, x2, #63
    sub x2, x2, x1
    add x2, x2, #1          // Fix length? No.
    // If end=100, start=100. Len = 100-100+1 = 1.
    // Wait. sp+63 is the last written byte.
    // x1 is the first written byte.
    // Length is (last - first) + 1. Correct.
    
    mov x0, #1 // stdout
    mov x8, #64 // write
    svc #0
    
    add sp, sp, #64
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
    
.L_str_zero:
    .ascii "0"
`;

finalOutput += `
${bssSection}
`;



// Intrinsic: __sys_write(fd)(buf)(len)
finalOutput += `
_sys_write:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    // fd is in x0
    // Create Closure [_sys_write_2, [fd, nil]]
    
    // 1. Env = [fd, nil]
    stp x0, x1, [sp, #-16]! // Save regs
    mov x1, x0 // Car = fd
    adr x0, sign_id // Cdr = nil
    // Swap for _cons(car=x0, cdr=x1)? No _cons(x0, x1) usually.
    // Let's assume _cons(head=x0, tail=x1)
    mov x2, x0 // nil
    mov x0, x1 // fd
    mov x1, x2 // nil
    bl _cons
    // x0 is Env
    
    // 2. Closure = [_sys_write_2, Env]
    mov x1, x0 // Env
    adr x0, _sys_write_2 // Code
    bl _cons
    
    ldp x0, x1, [sp], #16 // Restore (garbage)
    ldp x29, x30, [sp], #16
    ret

_sys_write_2:
    // x0 = buf
    // Env = [fd, nil]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // New Env needs to capture buf AND fd.
    // Current Env (in x9 usually? No, apply passes Code in x10, Env in x9)
    // We need to fetch fd from Old Env.
    // Old Env = [fd, nil]
    // Car(OldEnv) = fd.
    
    stp x0, x9, [sp, #-16]! // Save buf, OldEnv
    
    ldr x1, [x9] // Load fd from OldEnv (Car)
    // We want NewEnv = [len?, [buf, [fd, nil]]] ? 
    // No, we are building up.
    // Result of this function is Closure [_sys_write_3, [buf, fd]]
    
    // Let's make Env = [buf, fd] (simplified list)
    // x0 combined with fd.
    
    // x0 = buf (saved)
    // x1 = fd (loaded)
    
    // Create [buf, fd]
    // Step 1: Create [fd, nil] (Recreate? Or reuse OldEnv?)
    // OldEnv IS [fd, nil]. So we can reuse it as Tail!
    // So NewEnv = Cons(buf, OldEnv)
    
    ldr x0, [sp] // Restore buf
    ldr x1, [sp, #8] // Restore OldEnv
    bl _cons
    // x0 is NewEnv [buf, [fd, nil]]
    
    // Closure
    mov x1, x0 // Env
    adr x0, _sys_write_3 // Code
    bl _cons
    
    ldp x0, x9, [sp], #16
    ldp x29, x30, [sp], #16
    ret

_sys_write_3:
    // x0 = len
    // Env = [buf, [fd, nil]]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x2, x0 // arg3: len
    
    // Extract buf, fd from Env (x9)
    ldr x1, [x9] // buf (Car)
    ldr x9, [x9, #8] // Tail [fd, nil]
    ldr x0, [x9] // fd (Car)
    
    // Now x0=fd, x1=buf, x2=len
    
    mov x8, #64 // sys_write
    svc #0
    
    // Return result (usually 0 or written bytes)
    // x0 has result.
    
    ldp x29, x30, [sp], #16
    ret
    


// Intrinsic: __sys_brk(addr) -> addr
// Usage: __sys_brk 0 (get current), __sys_brk new_addr (alloc)
// Returns CLOSURE
_sys_brk:
    // Create Closure [_sys_brk_impl, nil]
    stp x29, x30, [sp, # - 16]!
    mov x29, sp
    
    adr x0, sign_id // nil
    str x0, [sp, # - 16]!
    adr x1, _sys_brk_impl
    ldr x0, [sp], #16
    bl _cons
    
    mov sp, x29
    ldp x29, x30, [sp], #16
ret

_sys_brk_impl:
    // x0 is Arg (addr). Env is nil (ignored).
    stp x29, x30, [sp, # - 16]!
    mov x29, sp
    
    mov x8, #214 // brk
    svc #0
    
    mov sp, x29
    ldp x29, x30, [sp], #16
ret

`;

finalOutput += `
.data
.balign 8
.global _str_start
_str_start:
`;

// Append String Table
for (let key in stringTable) {
	let lbl = stringTable[key];
	// AArch64 null-terminated string
	finalOutput += `${lbl}:\n    .asciz "${key.replace(/"/g, '\\"')}"\n`;
}

finalOutput += `
.global _str_end
_str_end:
`;

fs.writeFileSync(OUTPUT_FILE, finalOutput);
console.log(`Compiled to ${OUTPUT_FILE}`);
