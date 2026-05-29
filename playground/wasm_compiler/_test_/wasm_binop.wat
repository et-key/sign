(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))

  (func $main (export "main") (result i32)
    i32.const 10
    i32.const 20
    i32.const 2
    i32.mul
    i32.add
  )
)
