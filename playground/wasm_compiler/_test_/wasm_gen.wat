(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))

  (func $main (export "main") (result i32)
    (local $__reduce_ptr_0 i32)
    (local $__reduce_end_0 i32)
    (local $__reduce_acc_0 i32)
    (local $__map_start_0 i32)
    i32.const 10
    i32.const 20
    i32.add
    i32.const 30
    i32.add
  )
)
