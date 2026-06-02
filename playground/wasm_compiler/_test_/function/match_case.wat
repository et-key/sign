(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 1 funcref)
  (elem (i32.const 0) $func_match)

  (func $func_match (param $x f64) (param $y f64) (result f64)
    (local $func_match f64)
    (local $__fallback_tmp_0 f64)
    (local $__fallback_tmp_1 f64)
    (local $__list_ptr f64)
    local.get $x
    local.get $x
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
    local.get $y
    local.get $y
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
    local.get $x
    f64.const 1
    f64.lt
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result f64)
    f64.const 1024
    else
      f64.const nan ;; Unit
    end
    local.set $__fallback_tmp_1
    local.get $__fallback_tmp_1
    local.get $__fallback_tmp_1
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    local.get $y
    f64.const 3
    f64.lt
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result f64)
    f64.const 1080
    else
      f64.const nan ;; Unit
    end
    else
      local.get $__fallback_tmp_1
    end
    local.set $__fallback_tmp_0
    local.get $__fallback_tmp_0
    local.get $__fallback_tmp_0
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    local.get $x
    local.get $y
    f64.mul
    else
      local.get $__fallback_tmp_0
    end
  )
  (func $main (export "main") (result f64)
    (local $__reduce_ptr_2 f64)
    (local $__reduce_end_2 f64)
    (local $__reduce_acc_2 f64)
    (local $__map_start_2 f64)
    (local $__fallback_tmp_3 f64)
    (local $__fallback_tmp_4 f64)
    ;; Unhandled node: operation ?
    f64.const 0
  )
  (data (i32.const 1024) "\00\00\00\00\00\80\5c\40\00\00\00\00\00\40\59\40\00\00\00\00\00\c0\5c\40\00\00\00\00\00\40\5d\40\00\00\00\00\00\00\5b\40\00\00\00\00\00\00\5d\40\00\00\00\00\00\80\48\40")
  (data (i32.const 1080) "\00\00\00\00\00\80\5c\40\00\00\00\00\00\40\59\40\00\00\00\00\00\c0\5c\40\00\00\00\00\00\40\5d\40\00\00\00\00\00\00\5b\40\00\00\00\00\00\00\5d\40\00\00\00\00\00\00\49\40")

)
