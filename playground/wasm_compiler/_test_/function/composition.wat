(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 3 funcref)
  (elem (i32.const 0) $f $g $result)

  (func $f (param $x f64) (result f64)
    (local $<f> f64)
    (local $__list_ptr f64)
    local.get $x
    f64.const 2
    f64.mul
  )
  (func $g (param $x f64) (result f64)
    (local $<g> f64)
    (local $__list_ptr f64)
    local.get $x
    f64.const 1
    f64.add
  )
  (func $result (param $result f64) (result f64)
    (local $<result> f64)
    (local $__list_ptr f64)
    f64.const 1 ;; Function pointer to g
    call $f
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
