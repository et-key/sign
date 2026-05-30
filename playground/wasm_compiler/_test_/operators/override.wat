(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 1 funcref)
  (elem (i32.const 0) $[object Object])

  (func $[object Object] (param $x f64) (param $y f64) (result f64)
    (local $__list_ptr f64)
    ;; Unknown identifier: _
    f64.const 0
  )
  (func $[object Object] (param $x f64) (param $y f64) (result f64)
    (local $__list_ptr f64)
    ;; Unknown identifier: String
    f64.const 0
  )
  (func $main (export "main") (result f64)
    ;; Unhandled node: operation |
    f64.const 0
  )
)
