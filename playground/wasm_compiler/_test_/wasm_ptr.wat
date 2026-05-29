(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))

  (type $func_sig (func (param i32) (result i32)))
  (table 2 funcref)
  (elem (i32.const 0) $add10 $apply_to_20)

  (func $add10 (param $x i32) (result i32)
    (local $__list_ptr i32)
    local.get $x
    i32.const 10
    i32.add
  )
  (func $apply_to_20 (param $f i32) (result i32)
    (local $__list_ptr i32)
    i32.const 20
    local.get $f
    call_indirect (type $func_sig)
  )
  (func $main (export "main") (result i32)
    i32.const 0 ;; Function pointer to add10
    call $apply_to_20
  )
)
