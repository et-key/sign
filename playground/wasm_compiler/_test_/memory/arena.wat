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

  (table 4 funcref)
  (elem (i32.const 0) $f $g $a $b)

  (func $f (param $_ f64) (result f64)
    (local $__struct_ptr_0 i64)
    (local $__current_ptr_0 i64)
    (local $__struct_len_0 i64)
    (local $__tmp_ptr_0 i64)
    (local $__tmp_len_0 i64)
    (local $__fallback_tmp_1 f64)
    (local $s f64)
    (local $__reduce_ptr_2 f64)
    (local $__reduce_end_2 f64)
    (local $__reduce_acc_2 f64)
    (local $__map_start_2 f64)
    (local $__list_ptr f64)
    local.get $_
    local.get $_
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
    ;; Unhandled node: operation ~+
    f64.const 0
    local.set $s
    local.get $s
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
    f64.const 10
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
  (func $g (param $_ f64) (result f64)
    (local $__reduce_ptr_3 f64)
    (local $__reduce_end_3 f64)
    (local $__reduce_acc_3 f64)
    (local $__map_start_3 f64)
    (local $__fallback_tmp_4 f64)
    (local $s f64)
    (local $__reduce_ptr_5 f64)
    (local $__reduce_end_5 f64)
    (local $__reduce_acc_5 f64)
    (local $__map_start_5 f64)
    (local $__sink_ptr_6 f64)
    (local $__list_ptr f64)
    local.get $_
    local.get $_
    f64.ne
    if
      f64.const 0
      f64.const 0
      f64.div
      return
    end
    ;; Unhandled node: operation ~+
    f64.const 0
    local.set $s
    local.get $s
    local.set $__fallback_tmp_4
    local.get $__fallback_tmp_4
    local.get $__fallback_tmp_4
    f64.ne ;; Unit (NaN) check: x != x
    if (result f64)
    ;; Unhandled node: operation #
    f64.const 0
    else
      local.get $__fallback_tmp_4
    end
  )
  (func $a (param $__dummy f64) (result f64)
    (local $__list_ptr f64)
    f64.const 0 ;; Function pointer to f
  )
  (func $b (param $__dummy f64) (result f64)
    (local $__list_ptr f64)
    f64.const 1 ;; Function pointer to g
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
