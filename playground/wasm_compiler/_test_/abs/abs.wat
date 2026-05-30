(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (func $main (export "main") (result f64)
    f64.const 3
    ;; Unknown identifier: x
    f64.const 0
    ;; Unknown identifier: y
    f64.const 0
    f64.add
    f64.abs
    f64.mul
  )
)
