(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))

  (type $func_sig (func (param i32) (result i32)))
  (table 1 funcref)
  (elem (i32.const 0) $fib)

  (func $fib (param $n i32) (result i32)
    (local $__list_ptr i32)
    local.get $n
    i32.const 2
    i32.lt_s
    if (result i32)
    local.get $n
    else
    local.get $n
    i32.const 1
    i32.sub
    call $fib
    local.get $n
    i32.const 2
    i32.sub
    call $fib
    i32.add
    end
  )
  (func $main (export "main") (result i32)
    i32.const 10
    call $fib
  )
)
