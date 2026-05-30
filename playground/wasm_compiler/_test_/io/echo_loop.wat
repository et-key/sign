(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 1 funcref)
  (elem (i32.const 0) $echo_loop)

  (func $echo_loop (param $stdin f64) (param $stdout f64) (result f64)
    (local $<echo_loop> f64)
    (local $__loop_val_0 f64)
    (local $__loop_step_0 f64)
    (local $__loop_limit_0 f64)
    (local $__sink_ptr_1 f64)
    (local $__list_ptr f64)
    local.get $stdin_current
    local.get $stdin_step
    f64.add
    local.get $stdin_current
    local.get $stdin_step
    f64.add
    local.get $stdin_step
    local.get $stdin_limit
    call $echo_loop
  )
  (func $main (export "main") (result f64)
    f64.const 0
    f64.const 1
    call $echo_loop
  )
)
