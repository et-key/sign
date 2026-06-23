(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 3 funcref)
  (elem (i32.const 0) $func_with_defaults $result1_is_partial_applyed $lambda_0)
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 100)

  (global $hp (mut i64) (i64.const 2048))
  (global $result2_is_applied i64 (i64.const 0))
  (global $result3_is_partial_applyed i64 (i64.const 8))
  (global $result4_is_applied i64 (i64.const 16))
  (global $result5_is_applied i64 (i64.const 24))
  (global $result6_is_applied i64 (i64.const 32))



  (func $func_with_defaults (param $unknown i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $unknown
    i64.eqz
    (if (then i64.const 0 return))
  i64.const 0 ;; fallback for x
  f64.reinterpret_i64
  i64.const 0 ;; fallback for y
  f64.reinterpret_i64
  f64.add
  i64.reinterpret_f64
  )

  (func $result1_is_partial_applyed (param $$p0 i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $$p0
    i64.eqz
    (if (then i64.const 0 return))
  local.get $$p0
  call $func_with_defaults
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

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
      global.get $result2_is_applied
    i64.const 4613937818241073152 ;; f64: 3
    call $func_with_defaults
      i64.store
      global.get $result3_is_partial_applyed
      i64.store
      global.get $result4_is_applied
    i64.const 0
    i64.const 1
    call $make_closure
    i64.const 4613937818241073152 ;; f64: 3
    call $apply_and_eval_closure
    i64.const 4617315517961601024 ;; f64: 5
    call $apply_and_eval_closure
      i64.store
      global.get $result5_is_applied
    i64.const 0
    i64.const 1
    call $make_closure
    i64.const 4613937818241073152 ;; f64: 3
    local.set $tmp_l
    i64.const 4611686018427387904 ;; f64: 2
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
    call $apply_and_eval_closure
    i64.const 4617315517961601024 ;; f64: 5
    call $apply_and_eval_closure
      i64.store
      global.get $result6_is_applied
    i64.const 0
    i64.const 1
    call $make_closure
    i64.const 4613937818241073152 ;; f64: 3
    local.set $tmp_l
    i64.const 4611686018427387904 ;; f64: 2
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
    call $apply_and_eval_closure
    i64.const 4617315517961601024 ;; f64: 5
    local.set $tmp_l
    i64.const 4611686018427387904 ;; f64: 2
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
    call $apply_and_eval_closure
      i64.store
  )
)