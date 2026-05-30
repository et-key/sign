(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (func $main (export "main") (result f64)
    (local $__reduce_ptr_0 f64)
    (local $__reduce_end_0 f64)
    (local $__reduce_acc_0 f64)
    (local $__map_start_0 f64)
    ;; Unhandled node: operation ,
    f64.const 0
  )
)
