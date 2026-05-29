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
  (func $partial (param $partial i32) (result i32)
    ;; Unknown identifier: _
    i32.const 0
    drop
    i32.const 3
    call $f
  )
  (func $curried (param $curried i32) (result i32)
    i32.const 2
    call $f
  )
  (func $result_curried (param $result_curried i32) (result i32)
    ;; Unknown identifier: curried
    i32.const 0
    drop
    i32.const 4
  )
  (func $check (param $check i32) (result i32)
    i32.const 10
    i32.const 5
    i32.lt_s
  )
  (func $check2 (param $check2 i32) (result i32)
    i32.const 5
    i32.const 5
    i32.eq
  )
)
