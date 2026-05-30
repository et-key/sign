(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 1 funcref)
  (elem (i32.const 0) $fib)

  (func $fib (param $n f64) (result f64)
    (local $<fib> f64)
    (local $__fallback_tmp_0 f64)
    (local $__list_ptr f64)
    local.get $n
    f64.const 2
    f64.lt
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result f64)
    local.get $n
    else
      f64.const nan ;; Unit
    end
    local.set $__fallback_tmp_0
    local.get $__fallback_tmp_0
    local.get $__fallback_tmp_0
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    local.get $n
    f64.const 1
    f64.sub
    call $fib
    local.get $n
    f64.const 2
    f64.sub
    call $fib
    f64.add
    else
      local.get $__fallback_tmp_0
    end
  )
  (func $main (export "main") (result f64)
    f64.const 10
    call $fib
  )
)
