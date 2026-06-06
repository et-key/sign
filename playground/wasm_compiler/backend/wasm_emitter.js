import { emitNode } from './wasm_nodes.js';
import { getRuntimeFunctions } from './wasm_runtime.js';

export function generateWasm(ir) {
    const out = [];
    out.push(`(module`);
    out.push(`  (import "env" "print" (func $print (param f64)))`);
    out.push(`  (memory i64 20)`);
    out.push(`  (export "memory" (memory 0))`);
    out.push(`  (global $arena_ptr (mut i64) (i64.const 1000000))`);
    out.push(`  (type $func_sig (func (param i64) (param f64) (result f64)))`);

    const deps = new Set();

    function emit(node) {
        return emitNode(node, emit, deps);
    }

    // Rename top-level project definitions to their actual names
    ir.main.forEach(m => {
        if (m.type === 'ProjectDef' && m.value.type === 'PureFuncPtr') {
            const targetFunc = ir.functions.find(f => f.funcIndex === m.value.funcIndex);
            if (targetFunc) targetFunc.id = m.name;
        }
    });

    // 1. Emit User Functions
    for (const f of ir.functions) {
        const params = f.params.map(p => `(param $${p} f64)`).join(' ');
        out.push(`  (func $${f.id} (param $ctx i64) ${params} (result f64)`);

        const locals = new Set(f.locals || []);
        f.freeVars.forEach(v => locals.add(`__free_${v.name}`));
        for (const l of locals) {
            out.push(`    (local $${l} f64)`);
        }
        out.push(`    (local $__tmp_ptr i64)`);
        out.push(`    (local $__tmp_ptr_expand i64)`);
        out.push(`    (local $__tmp_f64 f64)`);
        
        for (let i = 0; i < f.freeVars.length; i++) {
            // Captured variables start at offset 24 (Tag: 0, FuncIndex: 8, NumVars: 16)
            const loadSExpr = `(f64.load (i64.add (i64.const ${24 + i * 8}) (local.get $ctx)))`;
            out.push(`    (local.set $__free_${f.freeVars[i].name} ${loadSExpr})`);
        }

        if (f.paramPropertyIndex >= 0 && f.params.length > 0) {
            const pName = f.params[0];
            const idx = f.paramPropertyIndex;
            out.push(`    (if (f64.gt (local.get $${pName}) (f64.const 1000000))`);
            out.push(`      (then`);
            out.push(`        (local.set $__tmp_ptr (i64.trunc_f64_u (local.get $${pName})))`);
            out.push(`        (if (f64.eq (f64.load offset=0 (local.get $__tmp_ptr)) (f64.const 4))`);
            out.push(`          (then`);
            out.push(`            (if (f64.lt (f64.const ${idx}) (f64.load offset=8 (local.get $__tmp_ptr)))`);
            out.push(`              (then`);
            out.push(`                (local.set $__tmp_f64 (f64.load offset=${16 + idx * 8} (local.get $__tmp_ptr)))`);
            out.push(`                (if (f64.eq (local.get $__tmp_f64) (local.get $__tmp_f64))`);
            out.push(`                  (then (local.set $${pName} (local.get $__tmp_f64)))`);
            out.push(`                )`);
            out.push(`              )`);
            out.push(`            )`);
            out.push(`          )`);
            out.push(`        )`);
            out.push(`      )`);
            out.push(`    )`);
        }

        out.push(`    ${emit(f.body)}`);
        out.push(`  )`);
    }

    // 2. Emit Main Function
    out.push(`  (func $main (export "main") (result f64)`);
    out.push(`    (local $__tmp_ptr i64)`);
    out.push(`    (local $__tmp_ptr_expand i64)`);
    out.push(`    (local $__tmp_f64 f64)`);
    
    const mainLocals = new Set();
    ir.main.forEach(m => {
        if (m.type === 'ProjectDef') mainLocals.add(m.name);
    });
    for (const m of mainLocals) out.push(`    (local $${m} f64)`);

    for (const m of ir.main) {
        if (m.type === 'ProjectDef') {
            out.push(`    (local.set $${m.name} ${emit(m.value)})`);
        } else {
            out.push(`    (call $print ${emit(m)})`);
        }
    }
    out.push(`    (f64.const 0)`);
    out.push(`  )`);

    // 3. Emit Table
    // Find the max funcIndex to size the table correctly
    const maxFuncIndex = ir.functions.reduce((max, f) => Math.max(max, f.funcIndex), -1);
    out.push(`  (table ${maxFuncIndex + 2} funcref)`); // +2 for safety, we need at least maxFuncIndex + 1
    for (const f of ir.functions) {
        out.push(`  (elem (i32.const ${f.funcIndex}) $${f.id})`);
    }

    // 4. Append Runtime Built-ins
    const runtimeFuncs = getRuntimeFunctions(deps);
    out.push(...runtimeFuncs);

    out.push(`)`);
    return out.join('\n');
}
