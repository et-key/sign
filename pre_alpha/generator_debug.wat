(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 4 funcref)
  (elem (i32.const 0) $f $fold $lambda_0 $reduce_add)
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 100)

  (global $hp (mut i64) (i64.const 2048))
  (global $a i64 (i64.const 0))



  (func $f (param $x i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $x
    i64.eqz
    (if (then i64.const 0 return))
  local.get $x
  f64.reinterpret_i64
  i64.const 4611686018427387904 ;; f64: 2
  f64.reinterpret_i64
  f64.mul
  i64.reinterpret_f64
  )

  (func $fold (param $unknown i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $unknown
    i64.eqz
    (if (then i64.const 0 return))
  i64.const 1 ;; func_idx
  i64.const 1 ;; arity
  call $make_closure
  i64.const 0 ;; func_idx
  i64.const 1 ;; arity
  call $make_closure
  call $make_compose_closure
  i64.const 0 ;; func_idx
  i64.const 1 ;; arity
  call $make_closure
  global.get $a
  i64.load
  i64.const 0 ;; fallback for x
  call $concat
  call $apply_and_eval_closure
  i64.const 0 ;; fallback for xs
  call $concat
  call $apply_and_eval_closure
  )

  (func $lambda_0 (param $_x i64) (param $_xs i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $_x
    i64.eqz
    (if (then i64.const 0 return))
  i64.const 3 ;; func_idx
  i64.const 2 ;; arity
  call $make_closure
  local.get $_x
  call $apply_and_eval_closure
  local.get $_xs
  call $apply_and_eval_closure
  )

  (func $make_compose_closure (param $left i64) (param $right i64) (result i64)
    (local $cl_ptr i64)
    (local $args_ptr i64)
    i64.const 32
    call $alloc_mem
    local.set $cl_ptr
    local.get $cl_ptr
    i64.const -1
    i64.store offset=0
    local.get $cl_ptr
    i64.const 1
    i64.store offset=8
    local.get $cl_ptr
    i64.const 0
    i64.store offset=16
    i64.const 16
    call $alloc_mem
    local.set $args_ptr
    local.get $args_ptr
    local.get $left
    i64.store offset=0
    local.get $args_ptr
    local.get $right
    i64.store offset=8
    local.get $cl_ptr
    local.get $args_ptr
    i64.store offset=24
    local.get $cl_ptr
  )

  (func $alloc_mem (param $size i64) (result i64)
    (local $addr i64)
    global.get $hp
    local.set $addr
    global.get $hp
    local.get $size
    i64.add
    global.set $hp
    local.get $addr
  )

  (func $make_closure (param $func_idx i64) (param $arity i64) (result i64)
    (local $cl_ptr i64)
    (local $args_ptr i64)
    i64.const 32
    call $alloc_mem
    local.set $cl_ptr
    local.get $cl_ptr
    local.get $func_idx
    i64.store offset=0
    local.get $cl_ptr
    local.get $arity
    i64.store offset=8
    local.get $cl_ptr
    i64.const 0
    i64.store offset=16
    i64.const 32
    call $alloc_mem
    local.set $args_ptr
    local.get $cl_ptr
    local.get $args_ptr
    i64.store offset=24
    local.get $cl_ptr
  )

  (func $concat (param $left i64) (param $right i64) (result i64)
    (local $l_is_list i32)
    (local $r_is_list i32)
    (local $l_len i64)
    (local $r_len i64)
    (local $total_len i64)
    (local $new_list i64)
    (local $i i64)
    (local $dst_offset i64)

    local.get $left
    call $is_list
    local.set $l_is_list

    local.get $l_is_list
    (if
      (then
        local.get $left
        i64.load offset=8
        local.set $l_len
      )
      (else
        i64.const 1
        local.set $l_len
      )
    )

    local.get $right
    call $is_list
    local.set $r_is_list

    local.get $r_is_list
    (if
      (then
        local.get $right
        i64.load offset=8
        local.set $r_len
      )
      (else
        i64.const 1
        local.set $r_len
      )
    )

    local.get $l_len
    local.get $r_len
    i64.add
    local.set $total_len

    local.get $total_len
    call $make_list
    local.set $new_list

    i64.const 0
    local.set $i
    i64.const 16
    local.set $dst_offset

    local.get $l_is_list
    (if
      (then
        (block $break_l
          (loop $top_l
            local.get $i
            local.get $l_len
            i64.ge_s
            br_if $break_l

            local.get $new_list
            local.get $dst_offset
            i64.add
            
            local.get $left
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=16
            
            i64.store

            local.get $dst_offset
            i64.const 8
            i64.add
            local.set $dst_offset

            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top_l
          )
        )
      )
      (else
        local.get $new_list
        local.get $dst_offset
        i64.add
        local.get $left
        i64.store
        
        local.get $dst_offset
        i64.const 8
        i64.add
        local.set $dst_offset
      )
    )

    i64.const 0
    local.set $i

    local.get $r_is_list
    (if
      (then
        (block $break_r
          (loop $top_r
            local.get $i
            local.get $r_len
            i64.ge_s
            br_if $break_r

            local.get $new_list
            local.get $dst_offset
            i64.add
            
            local.get $right
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=16
            
            i64.store

            local.get $dst_offset
            i64.const 8
            i64.add
            local.set $dst_offset

            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top_r
          )
        )
      )
      (else
        local.get $new_list
        local.get $dst_offset
        i64.add
        local.get $right
        i64.store
      )
    )

    local.get $new_list
  )

  (func $is_list (param $val i64) (result i32)
    (local $is_ptr i32)
    local.get $val
    i64.const 2048
    i64.ge_u
    (if (result i32)
      (then
        local.get $val
        global.get $hp
        i64.lt_u
        (if (result i32)
          (then
            local.get $val
            i64.const 7
            i64.and
            i64.eqz
            (if (result i32)
              (then i32.const 1)
              (else i32.const 0)
            )
          )
          (else i32.const 0)
        )
      )
      (else i32.const 0)
    )
    local.set $is_ptr

    local.get $is_ptr
    (if (result i32)
      (then
        local.get $val
        i64.load offset=0
        i64.const 101
        i64.eq
        (if (result i32)
          (then i32.const 1)
          (else i32.const 0)
        )
      )
      (else i32.const 0)
    )
  )

  (func $make_list (param $len i64) (result i64)
    (local $addr i64)
    local.get $len
    i64.const 8
    i64.mul
    i64.const 16
    i64.add
    call $alloc_mem
    local.set $addr
    local.get $addr
    i64.const 101 ;; List type tag
    i64.store offset=0
    local.get $addr
    local.get $len
    i64.store offset=8
    local.get $addr
  )

  (func $apply_and_eval_closure (param $cl_ptr i64) (param $arg i64) (result i64)
    (local $new_cl i64)
    (local $left i64)
    (local $right i64)
    (local $mid_res i64)
    (local $args_ptr i64)
    local.get $cl_ptr
    i64.load offset=0
    i64.const -1
    i64.eq
    (if (result i64)
      (then
        local.get $cl_ptr
        i64.load offset=24
        local.set $args_ptr
        
        local.get $args_ptr
        i64.load offset=0
        local.set $left
        
        local.get $args_ptr
        i64.load offset=8
        local.set $right
        
        local.get $left
        local.get $arg
        call $apply_and_eval_closure
        local.set $mid_res
        
        local.get $right
        local.get $mid_res
        call $apply_and_eval_closure
      )
      (else
        local.get $cl_ptr
        local.get $arg
        call $apply_closure
        local.set $new_cl
        local.get $new_cl
        i64.load offset=16
        local.get $new_cl
        i64.load offset=8
        i64.eq
        (if (result i64)
          (then
            local.get $new_cl
            call $invoke_closure
          )
          (else
            local.get $new_cl
          )
        )
      )
    )
  )

  (func $apply_closure (param $cl_ptr i64) (param $arg i64) (result i64)
    (local $new_cl i64)
    (local $new_args i64)
    (local $old_args i64)
    (local $count i64)
    (local $i i64)
    i64.const 32
    call $alloc_mem
    local.set $new_cl
    local.get $new_cl
    local.get $cl_ptr
    i64.load offset=0
    i64.store offset=0
    local.get $new_cl
    local.get $cl_ptr
    i64.load offset=8
    i64.store offset=8
    local.get $cl_ptr
    i64.load offset=16
    local.set $count
    local.get $new_cl
    local.get $count
    i64.const 1
    i64.add
    i64.store offset=16
    i64.const 32
    call $alloc_mem
    local.set $new_args
    local.get $new_cl
    local.get $new_args
    i64.store offset=24
    local.get $cl_ptr
    i64.load offset=24
    local.set $old_args
    i64.const 0
    local.set $i
    (block $break
      (loop $top
        local.get $i
        local.get $count
        i64.ge_s
        br_if $break
        local.get $new_args
        local.get $i
        i64.const 8
        i64.mul
        i64.add
        local.get $old_args
        local.get $i
        i64.const 8
        i64.mul
        i64.add
        i64.load
        i64.store
        local.get $i
        i64.const 1
        i64.add
        local.set $i
        br $top
      )
    )
    local.get $new_args
    local.get $count
    i64.const 8
    i64.mul
    i64.add
    local.get $arg
    i64.store
    local.get $new_cl
  )

  (func $invoke_closure (param $cl_ptr i64) (result i64)
    (local $func_idx i64)
    (local $arity i64)
    (local $args i64)
    local.get $cl_ptr
    i64.load offset=0
    local.set $func_idx
    local.get $cl_ptr
    i64.load offset=8
    local.set $arity
    local.get $cl_ptr
    i64.load offset=24
    local.set $args
    local.get $arity
    i64.const 1
    i64.eq
    (if (result i64)
      (then
        local.get $args
        i64.load offset=0
        local.get $func_idx
        i32.wrap_i64
        call_indirect (type $t_arity_1)
      )
      (else
        local.get $arity
        i64.const 2
        i64.eq
        (if (result i64)
          (then
            local.get $args
            i64.load offset=0
            local.get $args
            i64.load offset=8
            local.get $func_idx
            i32.wrap_i64
            call_indirect (type $t_arity_2)
          )
          (else
            local.get $arity
            i64.const 3
            i64.eq
            (if (result i64)
              (then
                local.get $args
                i64.load offset=0
                local.get $args
                i64.load offset=8
                local.get $args
                i64.load offset=16
                local.get $func_idx
                i32.wrap_i64
                call_indirect (type $t_arity_3)
              )
              (else
                local.get $args
                i64.load offset=0
                local.get $args
                i64.load offset=8
                local.get $args
                i64.load offset=16
                local.get $args
                i64.load offset=24
                local.get $func_idx
                i32.wrap_i64
                call_indirect (type $t_arity_4)
              )
            )
          )
        )
      )
    )
  )

  (func $reduce_add (param $init i64) (param $list_ptr i64) (result i64)
    (local $is_l i32)
    (local $len i64)
    (local $i i64)
    (local $acc f64)
    local.get $list_ptr
    call $is_list
    local.set $is_l
    local.get $init
    f64.reinterpret_i64
    local.set $acc
    local.get $is_l
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=8
        local.set $len
        i64.const 0
        local.set $i
        (block $break
          (loop $top
            local.get $i
            local.get $len
            i64.ge_s
            br_if $break
            local.get $acc
            local.get $list_ptr
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=16
            f64.reinterpret_i64
            f64.add
            local.set $acc
            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top
          )
        )
        local.get $acc
        i64.reinterpret_f64
      )
      (else
        local.get $list_ptr
        i64.eqz
        (if (result i64)
          (then
            local.get $init
          )
          (else
            local.get $acc
            local.get $list_ptr
            f64.reinterpret_i64
            f64.add
            i64.reinterpret_f64
          )
        )
      )
    )
  )

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
      global.get $a
    i64.const 1
    i64.const 1
    call $make_closure
    i64.const 2 ;; lambda func_idx
    i64.const 2 ;; arity
    call $make_closure
    i64.const 0 ;; f64: 0
    call $concat
    call $apply_and_eval_closure
    i64.const 4607182418800017408 ;; f64: 1
    i64.const 4611686018427387904 ;; f64: 2
    call $concat
    i64.const 4613937818241073152 ;; f64: 3
    call $concat
    i64.const 4616189618054758400 ;; f64: 4
    call $concat
    i64.const 4617315517961601024 ;; f64: 5
    call $concat
    call $apply_and_eval_closure
      i64.store
  )
)