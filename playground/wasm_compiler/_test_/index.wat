(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (func $main (export "main") (result f64)
    f64.const 10
    drop
    f64.const 20
    drop
    f64.const 30
    i32.trunc_f64_s
    f64.const 1
    i32.trunc_f64_s
    i32.const 3
    i32.shl
    i32.add
    f64.load
  )
)
