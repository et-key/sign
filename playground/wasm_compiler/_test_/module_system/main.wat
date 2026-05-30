(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (func $main (export "main") (result f64)
    (local $__loop_val_0 f64)
    (local $__loop_step_0 f64)
    (local $__loop_limit_0 f64)
    ;; Unknown identifier: add
    f64.const 0
    drop
    f64.const 10
    drop
    f64.const 5
  )
)
