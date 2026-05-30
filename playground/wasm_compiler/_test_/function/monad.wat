(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 3 funcref)
  (elem (i32.const 0) $f $maybe_val $g)

  (func $f (param $x f64) (param $y f64) (result f64)
    (local $<f> f64)
    (local $__list_ptr f64)
    local.get $x
    local.get $y
    f64.add
  )
  (func $maybe_val (param $maybe_val f64) (result f64)
    (local $<maybe_val> f64)
    (local $__list_ptr f64)
    f64.const 10
    f64.const 5
    f64.lt
    f64.convert_i32_s
  )
  (func $g (param $x f64) (result f64)
    (local $<g> f64)
    (local $__list_ptr f64)
    local.get $x
    f64.const 2
    f64.mul
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
