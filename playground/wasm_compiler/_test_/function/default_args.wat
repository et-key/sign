(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 4 funcref)
  (elem (i32.const 0) $func_with_defaults $result1_is_partial_applyed $result2_is_applied $result3_is_partial_applyed)

  (func $func_with_defaults (param $x f64) (param $y f64) (result f64)
    (local $<func_with_defaults> f64)
    (local $__fallback_tmp_0 f64)
    (local $<x> f64)
    (local $<y> f64)
    (local $__list_ptr f64)
    local.get $x
    local.get $y
    f64.add
  )
  (func $result1_is_partial_applyed (param $result1_is_partial_applyed f64) (result f64)
    (local $<result1_is_partial_applyed> f64)
    (local $__list_ptr f64)
    f64.const nan ;; Unit (default argument or omitted)
    f64.const nan ;; Unit (default argument or omitted)
    call $func_with_defaults
  )
  (func $result2_is_applied (param $result2_is_applied f64) (result f64)
    (local $<result2_is_applied> f64)
    (local $__list_ptr f64)
    f64.const 3
    f64.const nan ;; Unit (default argument or omitted)
    call $func_with_defaults
  )
  (func $result3_is_partial_applyed (param $result3_is_partial_applyed f64) (result f64)
    (local $<result3_is_partial_applyed> f64)
    (local $__list_ptr f64)
    ;; Unhandled node: operation ,
    f64.const 0
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
