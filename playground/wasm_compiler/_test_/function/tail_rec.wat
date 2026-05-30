(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 1 funcref)
  (elem (i32.const 0) $loop)

  (func $loop (param $x f64) (result f64)
    (local $<loop> f64)
    (local $__list_ptr f64)
    local.get $x
    call $loop
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
