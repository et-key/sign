(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 6 funcref)
  (elem (i32.const 0) $reduce_add $reduce_sub $reduce_mul $reduce_div $f $partial)
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 100)

  (global $hp (mut i64) (i64.const 2048))
  (global $curried i64 (i64.const 0))
  (global $result_curried i64 (i64.const 8))
  (global $check i64 (i64.const 16))
  (global $check2 i64 (i64.const 24))



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

  (func $list_head (param $list_ptr i64) (result i64)
    local.get $list_ptr
    call $is_list
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=8
        i64.const 0
        i64.gt_s
        (if (result i64)
          (then
            local.get $list_ptr
            i64.load offset=16
          )
          (else
            i64.const 0 ;; __unit
          )
        )
      )
      (else
        local.get $list_ptr
      )
    )
  )

  (func $list_tail (param $list_ptr i64) (result i64)
    (local $len i64)
    (local $new_list i64)
    (local $i i64)
    local.get $list_ptr
    call $is_list
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=8
        local.set $len
        local.get $len
        i64.const 1
        i64.le_s
        (if (result i64)
          (then
            i64.const 0
          )
          (else
            local.get $len
            i64.const 1
            i64.sub
            call $make_list
            local.set $new_list
            
            i64.const 0
            local.set $i
            (block $break
              (loop $top
                local.get $i
                local.get $len
                i64.const 1
                i64.sub
                i64.ge_s
                br_if $break
                
                local.get $new_list
                local.get $i
                i64.const 8
                i64.mul
                i64.add
                
                local.get $list_ptr
                local.get $i
                i64.const 1
                i64.add
                i64.const 8
                i64.mul
                i64.add
                i64.load offset=16
                
                i64.store offset=16
                
                local.get $i
                i64.const 1
                i64.add
                local.set $i
                br $top
              )
            )
            local.get $new_list
          )
        )
      )
      (else
        i64.const 0
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

  (func $reduce_sub (param $init i64) (param $list_ptr i64) (result i64)
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
            f64.sub
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
            f64.sub
            i64.reinterpret_f64
          )
        )
      )
    )
  )

  (func $reduce_mul (param $init i64) (param $list_ptr i64) (result i64)
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
            f64.mul
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
            f64.mul
            i64.reinterpret_f64
          )
        )
      )
    )
  )

  (func $reduce_div (param $init i64) (param $list_ptr i64) (result i64)
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
            f64.div
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
            f64.div
            i64.reinterpret_f64
          )
        )
      )
    )
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

  (func $apply_expanded_list (param $cl_ptr i64) (param $list_ptr i64) (result i64)
    (local $is_l i32)
    (local $len i64)
    (local $i i64)
    (local $curr_cl i64)

    local.get $list_ptr
    i64.eqz
    (if (result i64)
      (then
        local.get $cl_ptr
      )
      (else
        local.get $cl_ptr
        local.set $curr_cl

        local.get $list_ptr
        call $is_list
        local.set $is_l

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

                local.get $curr_cl
                local.get $list_ptr
                local.get $i
                i64.const 8
                i64.mul
                i64.add
                i64.load offset=16
                call $apply_and_eval_closure
                local.set $curr_cl

                local.get $i
                i64.const 1
                i64.add
                local.set $i
                br $top
              )
            )
            local.get $curr_cl
          )
          (else
            local.get $curr_cl
            local.get $list_ptr
            call $apply_and_eval_closure
          )
        )
      )
    )
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

  (func $apply_and_eval_closure (param $cl_ptr i64) (param $arg i64) (result i64)
    (local $new_cl i64)
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

  (func $f64_mod (param $x i64) (param $y i64) (result i64)
    (local $fx f64)
    (local $fy f64)
    (local $div f64)
    local.get $x
    f64.reinterpret_i64
    local.set $fx
    local.get $y
    f64.reinterpret_i64
    local.set $fy
    local.get $fx
    local.get $fy
    f64.div
    local.set $div
    local.get $fx
    local.get $div
    f64.trunc
    local.get $fy
    f64.mul
    f64.sub
    i64.reinterpret_f64
  )

  (func $f64_factorial (param $n i64) (result i64)
    (local $i f64)
    (local $res f64)
    (local $limit f64)
    f64.const 1.0
    local.set $res
    f64.const 2.0
    local.set $i
    local.get $n
    f64.reinterpret_i64
    local.set $limit
    (block $break
      (loop $top
        local.get $i
        local.get $limit
        f64.gt
        br_if $break
        
        local.get $res
        local.get $i
        f64.mul
        local.set $res
        
        local.get $i
        f64.const 1.0
        f64.add
        local.set $i
        br $top
      )
    )
    local.get $res
    i64.reinterpret_f64
  )

  (func $f (param $x i64) (param $y i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $x
    i64.eqz
    (if (then i64.const 0 return))
    local.get $y
    i64.eqz
    (if (then i64.const 0 return))
  local.get $x
  f64.reinterpret_i64
  local.get $y
  f64.reinterpret_i64
  f64.add
  i64.reinterpret_f64
  )

  (func $partial (param $$p0 i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $$p0
    i64.eqz
    (if (then i64.const 0 return))
  local.get $$p0
  i64.const 4613937818241073152 ;; f64: 3
  call $f
  )

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
      global.get $curried
    i64.const 4
    i64.const 2
    call $make_closure
    i64.const 4611686018427387904 ;; f64: 2
    call $apply_and_eval_closure
      i64.store
      global.get $result_curried
    global.get $curried
    i64.load
    i64.const 4616189618054758400 ;; f64: 4
    call $apply_and_eval_closure
      i64.store
      global.get $check
    i64.const 4621819117588971520 ;; f64: 10
    local.set $tmp_l
    i64.const 4617315517961601024 ;; f64: 5
    local.set $tmp_r
    local.get $tmp_l
    f64.reinterpret_i64
    local.get $tmp_r
    f64.reinterpret_i64
    f64.lt
    (if (result i64)
      (then
        local.get $tmp_l
      )
      (else
        i64.const 0
      )
    )
      i64.store
      global.get $check2
    i64.const 4617315517961601024 ;; f64: 5
    local.set $tmp_l
    i64.const 4617315517961601024 ;; f64: 5
    local.set $tmp_r
    local.get $tmp_l
    local.get $tmp_r
    i64.eq
    (if (result i64)
      (then
        local.get $tmp_l
      )
      (else
        i64.const 0
      )
    )
      i64.store
  )
)