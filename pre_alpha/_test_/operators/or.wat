(module
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 1)





  (func $f64_mod (param $x i64) (param $y i64) (result i64)
    (local $fx f64)
    (local $fy f64)
    (local $div f64)
    local.get $x
    f64.reinterpret_i64
    local.set $fx
    local.get $y
    f64.reinterpret_i64
    local.set $fy
    local.get $fx
    local.get $fy
    f64.div
    local.set $div
    local.get $fx
    local.get $div
    f64.trunc
    local.get $fy
    f64.mul
    f64.sub
    i64.reinterpret_f64
  )

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
    i64.const 0 ;; fallback for a
    local.set $tmp_l
    local.get $tmp_l
    i64.const 0
    i64.ne
    (if (result i64)
      (then
        local.get $tmp_l
      )
      (else
    i64.const 0 ;; fallback for b
    f64.reinterpret_i64
    f64.neg
    i64.reinterpret_f64
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
    i64.const 0 ;; fallback for c
      )
    )
      drop
    i64.const 0 ;; fallback for a
    local.set $tmp_l
    local.get $tmp_l
    i64.const 0
    i64.ne
    (if (result i64)
      (then
        local.get $tmp_l
      )
      (else
    i64.const 0 ;; fallback for b
    f64.reinterpret_i64
    f64.neg
    i64.reinterpret_f64
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
    i64.const 0 ;; fallback for c
      )
    )
      drop
  )
)