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

  (export "result" (func $result))
  (func $f (param $x i32) (result i32)
    local.get $x
    i32.const 2
    i32.mul
  )
  (func $g (param $x i32) (result i32)
    local.get $x
    i32.const 1
    i32.add
  )
  (func $result (param $result i32) (result i32)
    i32.const 3
    ;; TODO: Dynamic function call / apply
  )
)
