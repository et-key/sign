
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

// Load config
try {
	const configPath = path.join(__dirname, 'option.json');
	if (fs.existsSync(configPath)) {
		const data = fs.readFileSync(configPath, 'utf8');
		const json = JSON.parse(data);
		options = { ...options, ...json };
		// console.log("Loaded option.json:", options);
	}
} catch (e) {
	console.warn("Failed to load option.json:", e.message);
}

// Parse Args
const args = process.argv.slice(2);
let INPUT_FILE = null;

for (let i = 0; i < args.length; i++) {
	const arg = args[i];
	if (arg === '-o') {
		options.output = args[++i];
	} else if (arg === '-O') {
		options.optimize = true;
	} else if (arg === '-g') {
		options.debug = true;
	} else if (!arg.startsWith('-')) {
		INPUT_FILE = arg;
	}
}

const OUTPUT_FILE = path.join(__dirname, options.output);

if (!INPUT_FILE) {
	console.error("Usage: node compiler.js <ast_json_file> [-o output] [-O] [-g]");
	process.exit(1);
}

const AST = JSON.parse(fs.readFileSync(INPUT_FILE, 'utf8'));

// --- Instruction Dictionary ---
const TEMPLATES = {
	'+': 'add x0, x1, x0',
	'-': 'sub x0, x1, x0',
	'*': 'mul x0, x1, x0',
	'/': 'sdiv x0, x1, x0',
	'%': 'sdiv x2, x1, x0\n    msub x0, x2, x0, x1',

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
	"_read_char": "sign_id"
};

function resolveVar(name) {
	if (runtimeClosures[name]) {
		return `    adr x0, ${runtimeClosures[name]}\n`;
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

	// 1. Block (Short-Circuit OR)
	if (node.type === 'block') {
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
		let codeVal = 0;
		if (val.length === 1) codeVal = val.charCodeAt(0);
		else if (val === '\\n') codeVal = 10;
		else if (val === '\\t') codeVal = 9;
		else if (val.startsWith('\\')) codeVal = val.charCodeAt(1);

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

	let code = compileNode(left);
	code += '    str x0, [sp, #-16]!\n';
	code += compileNode(right);
	code += '    ldr x1, [sp], #16\n';

	if (op === ',') {
		code += '    bl _cons\n';
		return code;
	}
	if (op === '~') {
		code += '    bl _range\n';
		return code;
	}
	if (op === "'") {
		code += '    bl _nth\n';
		return code;
	}
	if (op === '@') {
		code += '    mov x9, x0\n';
		code += '    mov x0, x1\n';
		code += '    mov x1, x9\n';
		code += '    bl _nth\n';
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

	// 1. Compile Func -> Stack
	code += compileNode(node.func);
	code += '    str x0, [sp, #-16]!\n';

	// 2. Compile Arg -> x0
	code += compileNode(node.arg);

	// 3. Dynamic Check: is Arg (x0) a function?
	let lblCompose = generateLabel("do_compose");
	let lblApply = generateLabel("do_apply");
	let lblEnd = generateLabel("apply_end");

	// Check if Arg is Func
	// We check x0 directly. If > 4096, it's a pointer (Func).

	code += '    cmp x0, #4096\n';
	code += `    b.hi ${lblCompose}\n`;

	// Case A: Apply (Arg is Data)
	code += `${lblApply}:\n`;
	code += '    ldr x9, [sp], #16\n'; // Pop Func
	code += '    ldr x10, [x9]\n';     // Code
	code += '    ldr x9, [x9, #8]\n';  // Env
	code += '    blr x10\n';
	code += `    b ${lblEnd}\n`;

	// Case B: Compose (Arg is Func)
	// Stack: [Func]
	// x0: Arg (Func)
	code += `${lblCompose}:\n`;
	code += '    mov x1, x0\n';        // x1 = Arg (g)
	code += '    ldr x0, [sp], #16\n'; // Pop Func -> x0 (f)
	code += '    bl _compose\n';       // Returns Closure h(x) = g(f(x))

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

fs.writeFileSync(OUTPUT_FILE, finalOutput);
console.log(`Compiled to ${OUTPUT_FILE}`);
