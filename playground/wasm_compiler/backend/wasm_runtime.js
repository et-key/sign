export function getRuntimeFunctions(deps) {
    const out = [];

    // Factorial built-in
    if (deps.has('factorial')) {
        out.push(`  (func $factorial (param $n f64) (result f64)`);
        out.push(`    (local $res f64)`);
        out.push(`    (local.set $res (f64.const 1))`);
        out.push(`    (loop $l`);
        out.push(`      (if (f64.le (local.get $n) (f64.const 1)) (then (return (local.get $res))))`);
        out.push(`      (local.set $res (f64.mul (local.get $res) (local.get $n)))`);
        out.push(`      (local.set $n (f64.sub (local.get $n) (f64.const 1)))`);
        out.push(`      (br $l)`);
        out.push(`    )`);
        out.push(`    (f64.const 1)`);
        out.push(`  )`);
    }

    // Stub: alloc_partial_1
    // Structure: [tag=1 (4 bytes), func_index (4 bytes), missing (4 bytes), padding (4 bytes), arg0 (8 bytes)] -> 24 bytes total
    if (deps.has('alloc_partial_1')) {
        out.push(`  (func $alloc_partial_1 (param $func_idx f64) (param $arg0 f64) (result f64)`);
        out.push(`    (local $ptr i64)`);
        out.push(`    (local.set $ptr (global.get $arena_ptr))`);
        out.push(`    (i32.store (local.get $ptr) (i32.const 1)) ;; tag=1`);
        out.push(`    (i32.store offset=4 (local.get $ptr) (i32.trunc_f64_u (local.get $func_idx))) ;; func_index`);
        out.push(`    (i32.store offset=8 (local.get $ptr) (i32.const 1)) ;; missing_args=1`);
        out.push(`    (f64.store offset=16 (local.get $ptr) (local.get $arg0)) ;; arg0`);
        out.push(`    (global.set $arena_ptr (i64.add (global.get $arena_ptr) (i64.const 24)))`);
        out.push(`    (f64.convert_i64_u (local.get $ptr))`);
        out.push(`  )`);
    }

    const needsListAlloc = deps.has('__list_alloc_2') || deps.has('__coproduct') || deps.has('__expand');

    if (needsListAlloc) {
        out.push(`  (func $__list_alloc_2 (param $elem0 f64) (param $elem1 f64) (result f64)`);
        out.push(`    (local $ptr i64)`);
        out.push(`    (local.set $ptr (global.get $arena_ptr))`);
        out.push(`    (i32.store (local.get $ptr) (i32.const 3)) ;; Tag=3 (List)`);
        out.push(`    (f64.store offset=8 (local.get $ptr) (f64.const 2)) ;; Length=2`);
        out.push(`    (f64.store offset=16 (local.get $ptr) (local.get $elem0))`);
        out.push(`    (f64.store offset=24 (local.get $ptr) (local.get $elem1))`);
        out.push(`    (global.set $arena_ptr (i64.add (global.get $arena_ptr) (i64.const 32)))`);
        out.push(`    (f64.convert_i64_u (local.get $ptr))`);
        out.push(`  )`);
    }



    return out;
}
