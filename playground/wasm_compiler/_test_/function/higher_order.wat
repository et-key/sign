(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 2 funcref)
  (elem (i32.const 0) $f $map)

  (func $f (param $x f64) (result f64)
    (local $<f> f64)
    (local $__list_ptr f64)
    local.get $x
    f64.const 2
    f64.mul
  )
  (func $map (param $g f64) (param $x f64) (param $y_current f64) (param $y_step f64) (param $y_limit f64) (result f64)
    (local $<map> f64)
    (local $__loop_val_0 f64)
    (local $__loop_step_0 f64)
    (local $__loop_limit_0 f64)
    (local $__reduce_ptr_1 f64)
    (local $__reduce_end_1 f64)
    (local $__reduce_acc_1 f64)
    (local $__map_start_1 f64)
    (local $__reduce_ptr_2 f64)
    (local $__reduce_end_2 f64)
    (local $__reduce_acc_2 f64)
    (local $__map_start_2 f64)
    (local $__loop_val_3 f64)
    (local $__loop_step_3 f64)
    (local $__loop_limit_3 f64)
    (local $__list_ptr f64)
    local.get $x
    local.get $g
    i32.trunc_f64_s
    f64.load
    i32.trunc_f64_s
    call_indirect (type $func_sig)
    drop
    local.get $g
    local.get $y_current
    local.get $y_step
    f64.add
    local.get $y_current
    local.get $y_step
    f64.add
    local.get $y_step
    local.get $y_limit
    call $map
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
