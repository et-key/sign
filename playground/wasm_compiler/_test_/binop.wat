(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (func $main (export "main") (result f64)
    f64.const 10
    f64.const 20
    f64.const 2
    f64.mul
    f64.add
  )
)
