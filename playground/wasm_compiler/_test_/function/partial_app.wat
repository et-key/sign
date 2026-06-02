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
  (elem (i32.const 0) $f $curried $check $check2)

  (func $f (param $x f64) (param $y f64) (result f64)
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
    local.get $y
    f64.add
  )
  (func $curried (param $__dummy f64) (result f64)
    (local $__list_ptr f64)
    f64.const 4 ;; Partial application thunk
  )
  (func $check (param $__dummy f64) (result f64)
    (local $__list_ptr f64)
    f64.const 10
    f64.const 5
    f64.lt
    f64.convert_i32_s
  )
  (func $check2 (param $__dummy f64) (result f64)
    (local $__list_ptr f64)
    f64.const 5
    f64.const 5
    f64.eq
    f64.convert_i32_s
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )

  (func $__partial_f_0 (param $p1 f64) (result f64)
    f64.const 2
    local.get $p1
    call $f
  )
)
