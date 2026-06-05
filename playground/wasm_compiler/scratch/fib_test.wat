(module
  (import "env" "print" (func $print (param f64)))
  (memory i64 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (global $arena_ptr (mut i64) (i64.const 2048))
  (type $func_sig (func (param f64) (param f64) (result f64)))

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

  (func $fib (param $__env_ptr f64) (param $n f64) (result f64)
    (local $__if_cond f64)
    (local $__fallback_tmp_0 f64)
    (local $__cmp_tmp_L_1 f64)
    (local $__cmp_tmp_R_1 f64)
    (local $__reduce_ptr_2 f64)
    (local $__reduce_end_2 f64)
    (local $__reduce_acc_2 f64)
    (local $__map_start_2 f64)
    (local $__reduce_ptr_3 f64)
    (local $__reduce_end_3 f64)
    (local $__reduce_acc_3 f64)
    (local $__map_start_3 f64)
    (local $__list_ptr f64)
    local.get $n
    local.get $n
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
    local.get $n
    local.set $__cmp_tmp_L_1
    f64.const 2
    local.set $__cmp_tmp_R_1
    local.get $__cmp_tmp_L_1
    f64.const nan
    local.get $__cmp_tmp_L_1
    local.get $__cmp_tmp_R_1
    f64.lt
    select
    local.tee $__if_cond
    local.get $__if_cond
    f64.eq
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
    f64.const 0 ;; dummy env_ptr
    local.get $n
    f64.const 1
    f64.sub
    call $fib
    f64.const 0 ;; dummy env_ptr
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
    f64.const 0 ;; dummy env_ptr
    f64.const 10
    call $fib
  )
  (table 1 funcref)
  (elem (i32.const 0) $fib)
)
