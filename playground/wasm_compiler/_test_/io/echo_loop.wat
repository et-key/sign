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

  (func $echo_loop (param $stdin i32) (param $stdout i32) (result i32)
    ;; Unhandled node: operation ~
    i32.const 0
    drop
    local.get $stdout
    local.get $stdin
    i32.load
    i32.store
    i32.const 0 ;; store returns unit
    call $echo_loop
  )
)
