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

  (func $main (export "main") (result f64)
    (local $__cmp_tmp_L_0 f64)
    (local $__cmp_tmp_R_0 f64)
    (local $__cmp_tmp_L_1 f64)
    (local $__cmp_tmp_R_1 f64)
    (local $__cmp_tmp_L_2 f64)
    (local $__cmp_tmp_R_2 f64)
    (local $__cmp_tmp_L_3 f64)
    (local $__cmp_tmp_R_3 f64)
    (local $__cmp_tmp_L_4 f64)
    (local $__cmp_tmp_R_4 f64)
    (local $__cmp_tmp_L_5 f64)
    (local $__cmp_tmp_R_5 f64)
    f64.const 0 ;; dummy env_ptr
    f64.const 1
    local.set $__cmp_tmp_L_0
    f64.const 5
    local.set $__cmp_tmp_R_0
    local.get $__cmp_tmp_R_0
    f64.const nan
    local.get $__cmp_tmp_L_0
    local.get $__cmp_tmp_R_0
    f64.lt
    select
    call $print
    drop
    f64.const 0 ;; dummy env_ptr
    f64.const 5
    local.set $__cmp_tmp_L_1
    f64.const 10
    local.set $__cmp_tmp_R_1
    local.get $__cmp_tmp_L_1
    f64.const nan
    local.get $__cmp_tmp_L_1
    local.get $__cmp_tmp_R_1
    f64.lt
    select
    call $print
    drop
    f64.const 0 ;; dummy env_ptr
    f64.const 1
    local.set $__cmp_tmp_L_3
    f64.const 5
    local.set $__cmp_tmp_R_3
    local.get $__cmp_tmp_R_3
    f64.const nan
    local.get $__cmp_tmp_L_3
    local.get $__cmp_tmp_R_3
    f64.lt
    select
    local.set $__cmp_tmp_L_2
    f64.const 10
    local.set $__cmp_tmp_R_2
    local.get $__cmp_tmp_L_2
    f64.const nan
    local.get $__cmp_tmp_L_2
    local.get $__cmp_tmp_R_2
    f64.lt
    select
    call $print
    drop
    f64.const 0 ;; dummy env_ptr
    f64.const 10
    local.set $__cmp_tmp_L_5
    f64.const 5
    local.set $__cmp_tmp_R_5
    local.get $__cmp_tmp_R_5
    f64.const nan
    local.get $__cmp_tmp_L_5
    local.get $__cmp_tmp_R_5
    f64.lt
    select
    local.set $__cmp_tmp_L_4
    f64.const 100
    local.set $__cmp_tmp_R_4
    local.get $__cmp_tmp_L_4
    f64.const nan
    local.get $__cmp_tmp_L_4
    local.get $__cmp_tmp_R_4
    f64.lt
    select
    call $print
  )
)
