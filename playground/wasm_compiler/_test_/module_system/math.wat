(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 1 funcref)
  (elem (i32.const 0) $sub)

  (func $sub (param $sub f64) (result f64)
    (local $<sub> f64)
    (local $__reduce_ptr_0 f64)
    (local $__reduce_end_0 f64)
    (local $__reduce_acc_0 f64)
    (local $__map_start_0 f64)
    (local $__list_ptr f64)
    f64.sub
  )
  (func $main (export "main") (result f64)
    (local $__sink_ptr_1 f64)
    (local $<add> f64)
    (local $__reduce_ptr_2 f64)
    (local $__reduce_end_2 f64)
    (local $__reduce_acc_2 f64)
    (local $__map_start_2 f64)
    ;; Unhandled node: operation #
    f64.const 0
  )
)
