(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 2 funcref)
  (elem (i32.const 0) $add10 $apply_to_20)

  (func $add10 (param $x f64) (result f64)
    (local $<add10> f64)
    (local $__list_ptr f64)
    local.get $x
    f64.const 10
    f64.add
  )
  (func $apply_to_20 (param $f f64) (result f64)
    (local $<apply_to_20> f64)
    (local $__list_ptr f64)
    f64.const 20
    local.get $f
    i32.trunc_f64_s
    call_indirect (type $func_sig)
  )
  (func $main (export "main") (result f64)
    f64.const 0 ;; Function pointer to add10
    call $apply_to_20
  )
)
