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

  (func $f (param $x i32) (result i32)
    local.get $x
    i32.const 2
    i32.mul
  )
  (func $map (param $g i32) (param $x i32) (param $y_current i32) (param $y_step i32) (param $y_limit i32) (result i32)
    local.get $x
    ;; TODO: Dynamic function call / apply
    drop
    local.get $g
    drop
    ;; Unhandled node: operation ~
    i32.const 0
    call $map
  )
  (func $result_map1 (param $result_map1 i32) (result i32)
    ;; Unhandled node: operation $
    i32.const 0
    drop
    i32.const 1
    drop
    i32.const 2
    drop
    i32.const 3
    drop
    i32.const 4
    drop
    i32.const 5
    call $map
  )
  (func $result_map2 (param $result_map2 i32) (result i32)
    ;; Unhandled node: operation $
    i32.const 0
    drop
    i32.const 1
    drop
    i32.const 2
    drop
    i32.const 3
    drop
    i32.const 4
    drop
    i32.const 5
    call $map
  )
  (func $result_sum (param $result_sum i32) (result i32)
    i32.const 1
    drop
    i32.const 2
    drop
    i32.const 3
    drop
    i32.const 4
    drop
    i32.const 5
    ;; TODO: Dynamic function call / apply
  )
  (func $result_partial (param $result_partial i32) (result i32)
    i32.const 1
    drop
    i32.const 2
    drop
    i32.const 3
    drop
    i32.const 4
    drop
    i32.const 5
    ;; TODO: Dynamic function call / apply
  )
  (func $test_array (param $test_array i32) (result i32)
    i32.const 1
    drop
    i32.const 2
    drop
    i32.const 3
    drop
    i32.const 4
    drop
    i32.const 5
  )
  (func $test_tuple (param $test_tuple i32) (result i32)
    i32.const 1
    drop
    ;; Unknown identifier: a
    i32.const 0
    drop
    i32.const 3
  )
)
