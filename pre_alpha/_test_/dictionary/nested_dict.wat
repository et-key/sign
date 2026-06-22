(module
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 1)

  (global $option i64 (i64.const 0))
  (global $data i64 (i64.const 32))

  (data (i64.const 1024) "Sign\00")
  (data (i64.const 1032) "Structural\00")
  (data (i64.const 1048) "AArch64\00")
  (data (i64.const 1056) "javascript\00")

  (func $update (param $option i64) (param $_d0 i64)
  (local $type i64)
  (local $backend i64)
    ;; Destructure type from $_d0
    local.get $_d0
    i64.const 0
    i64.add
    i64.load
    local.set $type
    ;; Destructure backend from $_d0
    local.get $_d0
    i64.const 8
    i64.add
    i64.load
    local.set $backend
  local.get $option
  i64.const 16
  i64.add
  local.get $type
  i64.store
  local.get $option
  i64.const 24
  i64.add
  local.get $backend
  i64.store
  )

  ;; Main entry function
  (func (export "main")
      global.get $option
      i64.const 0
      i64.add
    i64.const 1024
      i64.store
      global.get $option
      i64.const 8
      i64.add
    f64.const 0.1
      f64.store
      global.get $option
      i64.const 16
      i64.add
    i64.const 1032
      i64.store
      global.get $option
      i64.const 24
      i64.add
    i64.const 1048
      i64.store
      global.get $data
      i64.const 0
      i64.add
    i64.const 1032
      i64.store
      global.get $data
      i64.const 8
      i64.add
    i64.const 1056
      i64.store
    global.get $option
    global.get $data
    call $update
  )
)