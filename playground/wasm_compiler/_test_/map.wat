(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 1 funcref)
  (elem (i32.const 0) $add10)

  (func $add10 (param $x f64) (result f64)
    (local $<add10> f64)
    (local $__list_ptr f64)
    local.get $x
    f64.const 10
    f64.add
  )
  (func $main (export "main") (result f64)
    (local $__reduce_ptr_0 f64)
    (local $__reduce_end_0 f64)
    (local $__reduce_acc_0 f64)
    (local $__map_start_0 f64)
    ;; Map without Sink is not supported yet in zero-cost stream mode
    f64.const 0
    i32.trunc_f64_s
    f64.const 1
    i32.trunc_f64_s
    i32.const 3
    i32.shl
    i32.add
    f64.load
  )
)
