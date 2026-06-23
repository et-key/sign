(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 2 funcref)
  (elem (i32.const 0) $loop_forever $test_and)
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 100)

  (global $hp (mut i64) (i64.const 2048))

  (data (i64.const 1024) "passed\00")

  (func $loop_forever (param $__ i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $__
    i64.eqz
    (if (then i64.const 0 return))
  local.get $__
  call $loop_forever
  )

  (func $test_and (param $cond i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $cond
    i64.eqz
    (if (then i64.const 0 return))
  local.get $cond
  local.set $tmp_l
  local.get $tmp_l
  i64.const 0
  i64.ne
  (if (result i64)
    (then
  i64.const 0 ;; fallback for __
  call $loop_forever
    )
    (else
      i64.const 0
    )
  )
  local.set $tmp_l
  local.get $tmp_l
  i64.const 0
  i64.ne
  (if (result i64)
    (then
      local.get $tmp_l
    )
    (else
  i64.const 1024
    )
  )
  )

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
    i64.const 0 ;; fallback for __
    call $test_and
      drop
  )
)