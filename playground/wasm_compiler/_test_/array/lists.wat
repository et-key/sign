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

  (func $a (param $a i32) (result i32)
    i32.const 1
  )
  (func $b (param $b i32) (result i32)
    i32.const 2
  )
  (func $c (param $c i32) (result i32)
    i32.const 3
  )
)
