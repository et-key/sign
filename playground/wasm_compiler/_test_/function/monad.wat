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

  (func $f (param $x i32) (param $y i32) (result i32)
    local.get $x
    local.get $y
    i32.add
  )
  (func $maybe_val (param $maybe_val i32) (result i32)
    i32.const 10
    i32.const 5
    i32.lt_s
  )
  (func $mapped (param $mapped i32) (result i32)
    ;; Unknown identifier: maybe_val
    i32.const 0
    drop
    i32.const 3
    call $f
  )
  (func $g (param $x i32) (result i32)
    local.get $x
    i32.const 2
    i32.mul
  )
  (func $mapped_twice (param $mapped_twice i32) (result i32)
    ;; Unknown identifier: mapped
    i32.const 0
    call $g
  )
)
