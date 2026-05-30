(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 1 funcref)
  (elem (i32.const 0) $all_func)

  (func $all_func (param $x f64) (param $y f64) (param $z_current f64) (param $z_step f64) (param $z_limit f64) (result f64)
    (local $<all_func> f64)
    (local $__fallback_tmp_0 f64)
    (local $__fallback_tmp_1 f64)
    (local $<y> f64)
    (local $__loop_val_2 f64)
    (local $__loop_step_2 f64)
    (local $__loop_limit_2 f64)
    (local $__fallback_tmp_3 f64)
    (local $__fallback_tmp_4 f64)
    (local $__fallback_tmp_5 f64)
    (local $__loop_val_6 f64)
    (local $__loop_step_6 f64)
    (local $__loop_limit_6 f64)
    (local $__list_ptr f64)
    local.get $x
    f64.const 0
    f64.eq
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result f64)
    f64.const 2
    local.get $z_current
    local.get $z_step
    f64.add
    local.get $z_current
    local.get $z_step
    f64.add
    local.get $z_step
    local.get $z_limit
    call $all_func
    else
      f64.const nan ;; Unit
    end
    local.set $__fallback_tmp_5
    local.get $__fallback_tmp_5
    local.get $__fallback_tmp_5
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    local.get $x
    f64.const 1
    f64.eq
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result f64)
    local.get $x
    else
      f64.const nan ;; Unit
    end
    else
      local.get $__fallback_tmp_5
    end
    local.set $__fallback_tmp_4
    local.get $__fallback_tmp_4
    local.get $__fallback_tmp_4
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    local.get $y
    f64.const 0
    f64.eq
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result local)
    local.get $y
    else
      i64.const 0 ;; Unit for i64
    end
    else
      local.get $__fallback_tmp_4
    end
    local.set $__fallback_tmp_3
    local.get $__fallback_tmp_3
    local.get $__fallback_tmp_3
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    local.get $x
    local.get $y
    f64.mul
    else
      local.get $__fallback_tmp_3
    end
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
