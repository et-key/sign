(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 4 funcref)
  (elem (i32.const 0) $f $map $lambda_0 $lambda_1)
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 100)

  (global $hp (mut i64) (i64.const 2048))



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

  (func $map (param $g i64) (param $x i64) (param $y i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $g
    i64.eqz
    (if (then i64.const 0 return))
    local.get $x
    i64.eqz
    (if (then i64.const 0 return))
  local.get $g
  local.set $tmp_l
  local.get $tmp_l
  i64.eqz
  (if (result i64)
    (then i64.const 0)
    (else
  local.get $x
      local.get $tmp_l
      i32.wrap_i64
      call_indirect (type $t_arity_1)
    )
  )
  drop
  local.get $g
  local.get $y
  local.set $tmp_l
  local.get $tmp_l
  call $list_head
  local.get $tmp_l
  call $list_tail
  call $map
  )

  (func $lambda_1 (param $_x i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $_x
    i64.eqz
    (if (then i64.const 0 return))
  local.get $_x
  f64.reinterpret_i64
  i64.const 4611686018427387904 ;; f64: 2
  f64.reinterpret_i64
  f64.mul
  i64.reinterpret_f64
  )

  (func $lambda_0 (param $_xs i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
  i64.const 3 ;; lambda func_idx (lambda_1)
  local.get $_xs
  local.set $tmp_l
  local.get $tmp_l
  call $list_head
  local.get $tmp_l
  call $list_tail
  call $map
  )

  (func $list_head (param $list_ptr i64) (result i64)
    local.get $list_ptr
    call $is_list
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=0
        i64.const 0
        i64.gt_s
        (if (result i64)
          (then
            local.get $list_ptr
            i64.load offset=8
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

  (func $is_list (param $val i64) (result i32)
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
        i64.load offset=0
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
                i64.load offset=8
                
                i64.store offset=8
                
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

  (func $make_list (param $len i64) (result i64)
    (local $addr i64)
    local.get $len
    i64.const 8
    i64.mul
    i64.const 8
    i64.add
    call $alloc_mem
    local.set $addr
    local.get $addr
    local.get $len
    i64.store offset=0
    local.get $addr
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

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
    (local $say i64)
    (local $range_start_0 i64)
    (local $range_step_0 i64)
    (local $range_end_0 i64)
    (local $range_curr_0 i64)
    (local $range_len_0 i64)
    (local $range_i_0 i64)
    (local $range_list_0 i64)
    i64.const 0 ;; unsupported inline code: console.log
      local.set $say
    local.get $say
    local.set $tmp_l
    local.get $tmp_l
    i64.eqz
    (if (result i64)
      (then i64.const 0)
      (else
    i64.const 2 ;; lambda func_idx (lambda_0)
    i64.const 0 ;; f64: 0
    local.set $range_start_0
    i64.const 4611686018427387904 ;; f64: 2
    local.set $range_step_0
    i64.const 4621819117588971520 ;; f64: 10
    local.set $range_end_0
    local.get $range_start_0
    local.set $range_curr_0
    i64.const 0
    local.set $range_len_0
    (block $break_cnt_0
      (loop $top_cnt_0
        local.get $range_len_0
        i64.const 10000
        i64.ge_s
        br_if $break_cnt_0
        local.get $range_curr_0
        f64.reinterpret_i64
        local.get $range_end_0
        f64.reinterpret_i64
        f64.le
        i32.eqz
        br_if $break_cnt_0
        local.get $range_len_0
        i64.const 1
        i64.add
        local.set $range_len_0
        local.get $range_curr_0
        f64.reinterpret_i64
        local.get $range_step_0
        f64.reinterpret_i64
        f64.add
        i64.reinterpret_f64
        local.set $range_curr_0
        br $top_cnt_0
      )
    )
    local.get $range_len_0
    call $make_list
    local.set $range_list_0
    local.get $range_start_0
    local.set $range_curr_0
    i64.const 0
    local.set $range_i_0
    (block $break_fill_0
      (loop $top_fill_0
        local.get $range_i_0
        local.get $range_len_0
        i64.lt_s
        i32.eqz
        br_if $break_fill_0
        local.get $range_list_0
        local.get $range_i_0
        i64.const 8
        i64.mul
        i64.add
        local.get $range_curr_0
        i64.store offset=16
        local.get $range_curr_0
        f64.reinterpret_i64
        local.get $range_step_0
        f64.reinterpret_i64
        f64.add
        i64.reinterpret_f64
        local.set $range_curr_0
        local.get $range_i_0
        i64.const 1
        i64.add
        local.set $range_i_0
        br $top_fill_0
      )
    )
    local.get $range_list_0
    i64.const 0 ;; empty rest parameter
    call $map
        local.get $tmp_l
        i32.wrap_i64
        call_indirect (type $t_arity_1)
      )
    )
      drop
  )
)