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

  (table 6 funcref)
  (elem (i32.const 0) $x $y $z $point $update_x $new_point)

  (func $x (param $__dummy f64) (result f64)
    (local $__list_ptr f64)
    f64.const 10
  )
  (func $y (param $__dummy f64) (result f64)
    (local $__list_ptr f64)
    f64.const 20
  )
  (func $z (param $__dummy f64) (result f64)
    (local $__list_ptr f64)
    f64.const 30
  )
  (func $point (param $__dummy f64) (result f64)
    (local $__struct_ptr_0 i64)
    (local $__current_ptr_0 i64)
    (local $__struct_len_0 i64)
    (local $__tmp_ptr_0 i64)
    (local $__tmp_len_0 i64)
    (local $__fallback_tmp_1 f64)
    (local $__fallback_tmp_2 f64)
    (local $__list_ptr f64)
    i64.const 0
    local.set $__struct_len_0
    global.get $arena_ptr
    local.set $__struct_ptr_0
    local.get $__struct_ptr_0
    i64.const 8
    i64.add
    local.set $__current_ptr_0
    local.get $__current_ptr_0
    f64.const 0 ;; Function pointer to x
    f64.store
    local.get $__current_ptr_0
    i64.const 8
    i64.add
    local.set $__current_ptr_0
    local.get $__struct_len_0
    i64.const 1
    i64.add
    local.set $__struct_len_0
    local.get $__current_ptr_0
    f64.const 1 ;; Function pointer to y
    f64.store
    local.get $__current_ptr_0
    i64.const 8
    i64.add
    local.set $__current_ptr_0
    local.get $__struct_len_0
    i64.const 1
    i64.add
    local.set $__struct_len_0
    local.get $__current_ptr_0
    f64.const 2 ;; Function pointer to z
    f64.store
    local.get $__current_ptr_0
    i64.const 8
    i64.add
    local.set $__current_ptr_0
    local.get $__struct_len_0
    i64.const 1
    i64.add
    local.set $__struct_len_0
    local.get $__struct_ptr_0
    local.get $__struct_len_0
    f64.convert_i64_u
    f64.store
    local.get $__current_ptr_0
    global.set $arena_ptr
    local.get $__struct_ptr_0
    f64.convert_i64_u
  )
  (func $update_x (param $y f64) (param $rest f64) (result f64)
    (local $__struct_ptr_3 i64)
    (local $__current_ptr_3 i64)
    (local $__struct_len_3 i64)
    (local $__tmp_ptr_3 i64)
    (local $__tmp_len_3 i64)
    (local $__fallback_tmp_4 f64)
    (local $__loop_val_5 f64)
    (local $__loop_step_5 f64)
    (local $__loop_limit_5 f64)
    (local $__list_ptr f64)
    local.get $y
    local.get $y
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
    local.get $rest
    local.get $rest
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
    i64.const 0
    local.set $__struct_len_3
    global.get $arena_ptr
    local.set $__struct_ptr_3
    local.get $__struct_ptr_3
    i64.const 8
    i64.add
    local.set $__current_ptr_3
    local.get $__current_ptr_3
    f64.const 100
    local.set $y
    local.get $y
    f64.store
    local.get $__current_ptr_3
    i64.const 8
    i64.add
    local.set $__current_ptr_3
    local.get $__struct_len_3
    i64.const 1
    i64.add
    local.set $__struct_len_3
    local.get $rest
    i64.trunc_f64_u
    local.set $__tmp_ptr_3
    local.get $__tmp_ptr_3
    f64.load
    i64.trunc_f64_u
    local.set $__tmp_len_3
    local.get $__struct_len_3
    local.get $__tmp_len_3
    i64.add
    local.set $__struct_len_3
    local.get $__tmp_ptr_3
    i64.const 8
    i64.add
    local.set $__tmp_ptr_3
    block $copy_end_6
    loop $copy_loop_6
      local.get $__tmp_len_3
      i64.eqz
      br_if $copy_end_6
      local.get $__current_ptr_3
      local.get $__tmp_ptr_3
      f64.load
      f64.store
      local.get $__current_ptr_3
      i64.const 8
      i64.add
      local.set $__current_ptr_3
      local.get $__tmp_ptr_3
      i64.const 8
      i64.add
      local.set $__tmp_ptr_3
      local.get $__tmp_len_3
      i64.const 1
      i64.sub
      local.set $__tmp_len_3
      br $copy_loop_6
    end
    end
    local.get $__struct_ptr_3
    local.get $__struct_len_3
    f64.convert_i64_u
    f64.store
    local.get $__current_ptr_3
    global.set $arena_ptr
    local.get $__struct_ptr_3
    f64.convert_i64_u
  )
  (func $new_point (param $__dummy f64) (result f64)
    (local $__loop_val_7 f64)
    (local $__loop_step_7 f64)
    (local $__loop_limit_7 f64)
    (local $__list_ptr f64)
    ;; Spread named element 0 (mapped to struct index 1)
    f64.const 0
    call $point
    i64.trunc_f64_u
    i64.const 8
    i64.add
    i64.const 8
    i64.add
    f64.load
    ;; Spread Rest pack (2 fields)
    global.get $arena_ptr
    i64.const 2
    f64.convert_i64_u
    f64.store
    global.get $arena_ptr
    i64.const 8
    i64.add
    f64.const 0
    call $point
    i64.trunc_f64_u
    i64.const 8
    i64.add
    i64.const 0
    i64.add
    f64.load
    f64.store
    global.get $arena_ptr
    i64.const 16
    i64.add
    f64.const 0
    call $point
    i64.trunc_f64_u
    i64.const 8
    i64.add
    i64.const 16
    i64.add
    f64.load
    f64.store
    global.get $arena_ptr
    f64.convert_i64_u
    global.get $arena_ptr
    i64.const 24
    i64.add
    global.set $arena_ptr
    call $update_x
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
