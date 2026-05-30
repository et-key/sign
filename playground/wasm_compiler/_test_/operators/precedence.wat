(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (func $main (export "main") (result f64)
    ;; Unknown identifier: a
    f64.const 0
    ;; Unknown identifier: b
    f64.const 0
    ;; Unknown identifier: c
    f64.const 0
    f64.mul
    f64.add
    ;; Unknown identifier: a
    f64.const 0
    ;; Unknown identifier: b
    f64.const 0
    ;; Unknown identifier: c
    f64.const 0
    f64.mul
    f64.add
    f64.eq
    f64.convert_i32_s
  )
)
