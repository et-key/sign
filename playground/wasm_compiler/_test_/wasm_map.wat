(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))

  (type $func_sig (func (param i32) (result i32)))
  (table 1 funcref)
  (elem (i32.const 0) $add10)

  (func $add10 (param $x i32) (result i32)
    (local $__list_ptr i32)
    local.get $x
    i32.const 10
    i32.add
  )
  (func $main (export "main") (result i32)
    (local $__reduce_ptr_0 i32)
    (local $__reduce_end_0 i32)
    (local $__reduce_acc_0 i32)
    (local $__map_start_0 i32)
    ;; Map without Sink is not supported yet in zero-cost stream mode
    i32.const 0
    i32.const 1
    i32.const 2
    i32.shl
    i32.add
    i32.load
  )
)
