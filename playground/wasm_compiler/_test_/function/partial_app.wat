(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 4 funcref)
  (elem (i32.const 0) $f $curried $check $check2)

  (func $f (param $x f64) (param $y f64) (result f64)
    (local $<f> f64)
    (local $__list_ptr f64)
    local.get $x
    local.get $y
    f64.add
  )
  (func $curried (param $curried f64) (result f64)
    (local $<curried> f64)
    (local $__list_ptr f64)
    f64.const 4 ;; Partial application thunk
  )
  (func $check (param $check f64) (result f64)
    (local $<check> f64)
    (local $__list_ptr f64)
    f64.const 10
    f64.const 5
    f64.lt
    f64.convert_i32_s
  )
  (func $check2 (param $check2 f64) (result f64)
    (local $<check2> f64)
    (local $__list_ptr f64)
    f64.const 5
    f64.const 5
    f64.eq
    f64.convert_i32_s
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )

  (func $__partial_f_0 (param $p1 f64) (result f64)
    f64.const 2
    local.get $p1
    call $f
  )
)
