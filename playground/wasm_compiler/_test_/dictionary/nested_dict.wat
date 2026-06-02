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
  (elem (i32.const 0) $my_dict)

  (func $my_dict (param $__dummy f64) (result f64)
    (local $__struct_ptr_0 i64)
    (local $__current_ptr_0 i64)
    (local $__struct_len_0 i64)
    (local $__tmp_ptr_0 i64)
    (local $__tmp_len_0 i64)
    (local $__fallback_tmp_1 f64)
    (local $__fallback_tmp_2 f64)
    (local $name f64)
    (local $version f64)
    (local $features f64)
    (local $__struct_ptr_3 i64)
    (local $__current_ptr_3 i64)
    (local $__struct_len_3 i64)
    (local $__tmp_ptr_3 i64)
    (local $__tmp_len_3 i64)
    (local $__fallback_tmp_4 f64)
    (local $type f64)
    (local $backend f64)
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
    f64.const 1024
    local.set $name
    local.get $name
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
    f64.const 0.1
    local.set $version
    local.get $version
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
    i64.const 0
    local.set $__struct_len_3
    global.get $arena_ptr
    local.set $__struct_ptr_3
    local.get $__struct_ptr_3
    i64.const 8
    i64.add
    local.set $__current_ptr_3
    local.get $__current_ptr_3
    f64.const 1056
    local.set $type
    local.get $type
    f64.store
    local.get $__current_ptr_3
    i64.const 8
    i64.add
    local.set $__current_ptr_3
    local.get $__struct_len_3
    i64.const 1
    i64.add
    local.set $__struct_len_3
    local.get $__current_ptr_3
    f64.const 1136
    local.set $backend
    local.get $backend
    f64.store
    local.get $__current_ptr_3
    i64.const 8
    i64.add
    local.set $__current_ptr_3
    local.get $__struct_len_3
    i64.const 1
    i64.add
    local.set $__struct_len_3
    local.get $__struct_ptr_3
    local.get $__struct_len_3
    f64.convert_i64_u
    f64.store
    local.get $__current_ptr_3
    global.set $arena_ptr
    local.get $__struct_ptr_3
    f64.convert_i64_u
    local.set $features
    local.get $features
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
    f64.const 0
  )
  (data (i64.const 1024) "\00\00\00\00\00\c0\54\40\00\00\00\00\00\40\5a\40\00\00\00\00\00\c0\59\40\00\00\00\00\00\80\5b\40")
  (data (i64.const 1056) "\00\00\00\00\00\c0\54\40\00\00\00\00\00\00\5d\40\00\00\00\00\00\80\5c\40\00\00\00\00\00\40\5d\40\00\00\00\00\00\c0\58\40\00\00\00\00\00\00\5d\40\00\00\00\00\00\40\5d\40\00\00\00\00\00\80\5c\40\00\00\00\00\00\40\58\40\00\00\00\00\00\00\5b\40")
  (data (i64.const 1136) "\00\00\00\00\00\40\50\40\00\00\00\00\00\40\50\40\00\00\00\00\00\80\5c\40\00\00\00\00\00\c0\58\40\00\00\00\00\00\00\5a\40\00\00\00\00\00\00\4b\40\00\00\00\00\00\00\4a\40")

)
