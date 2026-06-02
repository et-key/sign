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

  (func $map (param $__env_ptr f64) (param $f f64) (param $x f64) (param $y f64) (result f64)
    (local $__struct_ptr_0 i64)
    (local $__current_ptr_0 i64)
    (local $__struct_len_0 i64)
    (local $__tmp_ptr_0 i64)
    (local $__tmp_len_0 i64)
    (local $__fallback_tmp_1 f64)
    (local $__loop_val_1 f64)
    (local $__loop_step_1 f64)
    (local $__loop_limit_1 f64)
    (local $__list_ptr f64)
    local.get $f
    local.get $f
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
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
    i64.const 0
    local.set $__struct_len_0
    global.get $arena_ptr
    local.set $__struct_ptr_0
    local.get $__struct_ptr_0
    i64.const 8
    i64.add
    local.set $__current_ptr_0
    local.get $__current_ptr_0
    local.get $f
    local.set $__fallback_tmp_1 ;; save closure ptr
    local.get $__fallback_tmp_1 ;; push env_ptr arg
    local.get $x
    local.get $__fallback_tmp_1 ;; closure ptr
    i64.trunc_f64_s
    f64.load ;; get function index
    i32.trunc_f64_s
    call_indirect (type $func_sig)
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
    f64.const 0 ;; dummy env_ptr
    local.get $f
    ;; Spread element 0
    local.get $y
    local.set $__fallback_tmp_1
    local.get $__fallback_tmp_1
    i64.trunc_f64_u
    f64.load
    i64.trunc_f64_u
    i64.const 0
    i64.gt_s
    if (result f64)
      local.get $__fallback_tmp_1
      i64.trunc_f64_u
      i64.const 8
      i64.add
      i64.const 0
      i64.add
      f64.load
    else
      f64.const nan
    end
    ;; Spread Rest slice
    local.get $y
    i64.trunc_f64_u
    i64.const 1
    call $__slice
    call $map
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
  (func $main (export "main") (result f64)
    (local $__reduce_ptr_2 f64)
    (local $__reduce_end_2 f64)
    (local $__reduce_acc_2 f64)
    (local $__map_start_2 f64)
    (local $__reduce_ptr_3 f64)
    (local $__reduce_end_3 f64)
    (local $__reduce_acc_3 f64)
    (local $__map_start_3 f64)
    f64.const 0 ;; dummy env_ptr
    f64.const 0 ;; dummy env_ptr
    ;; Allocate Closure Struct for __closure_1
    global.get $arena_ptr
    global.get $arena_ptr
    f64.const 1
    f64.store
    global.get $arena_ptr
    i64.const 8
    i64.add
    global.set $arena_ptr
    f64.convert_i64_u
    f64.const 1
    f64.const 2
    call $map
    call $print
  )

  (func $__closure_1 (param $__env_ptr f64) (param $__p0 f64) (result f64)
    (local $__list_ptr f64)
    local.get $__p0
    local.get $__p0
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
    local.get $__p0
    f64.const 2
    f64.mul
  )
  (table 2 funcref)
  (elem (i32.const 0) $map $__closure_1)
)
