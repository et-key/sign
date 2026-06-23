(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 2 funcref)
  (elem (i32.const 0) $f $map)
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
  i64.const 2
  call $make_list
  local.set $tmp_l
  local.get $tmp_l
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
  i64.store offset=8
  local.get $tmp_l
  local.get $g
  local.get $y
  local.set $tmp_l
  local.get $tmp_l
  call $list_head
  local.get $tmp_l
  call $list_tail
  call $map
  i64.store offset=16
  local.get $tmp_l
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
    i64.eqz
    (if (then local.get $right return))

    local.get $right
    i64.eqz
    (if (then local.get $left return))

    local.get $left
    call $is_list
    local.set $l_is_list

    local.get $l_is_list
    (if
      (then
        local.get $left
        i64.load offset=0
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
        i64.load offset=0
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
    i64.const 8
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
            i64.load offset=8
            
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
            i64.load offset=8
            
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

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
    (local $say i64)
    i64.const 0 ;; unsupported inline code: console.log
      local.set $say
    local.get $say
    local.set $tmp_l
    local.get $tmp_l
    i64.eqz
    (if (result i64)
      (then i64.const 0)
      (else
    i64.const 0 ;; func_idx (f)
    i64.const 4607182418800017408 ;; f64: 1
    i64.const 4611686018427387904 ;; f64: 2
    i64.const 4613937818241073152 ;; f64: 3
    call $concat
    i64.const 4616189618054758400 ;; f64: 4
    call $concat
    i64.const 4617315517961601024 ;; f64: 5
    call $concat
    call $map
        local.get $tmp_l
        i32.wrap_i64
        call_indirect (type $t_arity_1)
      )
    )
      drop
  )
)