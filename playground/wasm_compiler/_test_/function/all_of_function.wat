(module
  (import "env" "print" (func $print (param i32)))
  (memory i64 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (global $arena_ptr (mut i64) (i64.const 2048))
  (type $func_sig (func (param f64) (result f64)))

  (func $__slice (param $ptr i64) (param $offset i64) (result f64)
    (local $new_len i64) (local $new_ptr i64) (local $src_ptr i64) (local $dst_ptr i64)
    local.get $ptr
    f64.load
    i64.trunc_f64_u
    local.get $offset
    i64.sub
    local.set $new_len
    local.get $new_len
    i64.const 0
    i64.lt_s
    if
      i64.const 0
      local.set $new_len
    end
    global.get $arena_ptr
    local.set $new_ptr
    local.get $new_ptr
    local.get $new_len
    f64.convert_i64_u
    f64.store
    local.get $new_ptr
    i64.const 8
    i64.add
    local.set $dst_ptr
    local.get $ptr
    i64.const 8
    i64.add
    local.get $offset
    i64.const 8
    i64.mul
    i64.add
    local.set $src_ptr
    block $end
    loop $loop
      local.get $new_len
      i64.eqz
      br_if $end
      local.get $dst_ptr
      local.get $src_ptr
      f64.load
      f64.store
      local.get $dst_ptr
      i64.const 8
      i64.add
      local.set $dst_ptr
      local.get $src_ptr
      i64.const 8
      i64.add
      local.set $src_ptr
      local.get $new_len
      i64.const 1
      i64.sub
      local.set $new_len
      br $loop
    end
    end
    local.get $dst_ptr
    global.set $arena_ptr
    local.get $new_ptr
    f64.convert_i64_u
  )

  (table 1 funcref)
  (elem (i32.const 0) $all_func)

  (func $all_func (param $x f64) (param $y f64) (param $z f64) (result f64)
    (local $__fallback_tmp_0 f64)
    (local $__fallback_tmp_1 f64)
    (local $__fallback_tmp_2 f64)
    (local $__loop_val_3 f64)
    (local $__loop_step_3 f64)
    (local $__loop_limit_3 f64)
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
    local.get $x
    f64.const 1
    f64.add
      local.set $y
    end
    local.get $z
    local.get $z
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
    local.get $x
    f64.const 0
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result f64)
    f64.const 2
    ;; Spread element 0
    local.get $z
    i64.trunc_f64_u
    i64.const 8
    i64.add
    i64.const 0
    i64.add
    f64.load
    ;; Spread Rest slice
    local.get $z
    i64.trunc_f64_u
    i64.const 1
    call $__slice
    call $all_func
    else
      f64.const nan ;; Unit
    end
    local.set $__fallback_tmp_2
    local.get $__fallback_tmp_2
    local.get $__fallback_tmp_2
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    local.get $x
    f64.const 1
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result f64)
    local.get $x
    else
      f64.const nan ;; Unit
    end
    else
      local.get $__fallback_tmp_2
    end
    local.set $__fallback_tmp_1
    local.get $__fallback_tmp_1
    local.get $__fallback_tmp_1
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    local.get $y
    f64.const 0
    f64.convert_i32_s
    i32.trunc_f64_s
    if (result f64)
    local.get $y
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
    f64.const 0
  )
)
