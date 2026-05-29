(module
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (global $hp (mut i32) (i32.const 0)) ;; Heap Pointer for bump allocation

  ;; Helper function for Bump Allocation
  (func $alloc (param $size i32) (result i32)
    (local $ptr i32)
    global.get $hp
    local.set $ptr
    global.get $hp
    local.get $size
    i32.add
    global.set $hp
    local.get $ptr
  )

  (func $func_with_defaults (param $x i32) (param $y i32) (result i32)
    local.get $x
    local.get $y
    i32.add
  )
  (func $result1_is_partial_applyed (param $result1_is_partial_applyed i32) (result i32)
    ;; Unknown identifier: _
    i32.const 0
    call $func_with_defaults
  )
  (func $result2_is_applied (param $result2_is_applied i32) (result i32)
    i32.const 3
    call $func_with_defaults
  )
  (func $result3_is_partial_applyed (param $result3_is_partial_applyed i32) (result i32)
    ;; Unhandled node: operation ,
    i32.const 0
  )
  (func $result4_is_applied (param $result4_is_applied i32) (result i32)
    i32.const 3
    drop
    i32.const 5
    call $func_with_defaults
  )
  (func $result5_is_applied (param $result5_is_applied i32) (result i32)
    i32.const 3
    i32.const 2
    i32.lt_s
    drop
    i32.const 5
    call $func_with_defaults
  )
  (func $result6_is_applied (param $result6_is_applied i32) (result i32)
    i32.const 3
    i32.const 2
    i32.lt_s
    drop
    i32.const 5
    i32.const 2
    i32.lt_s
    call $func_with_defaults
  )
)
