(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 1)

  (global $val_pow i64 (i64.const 0))
  (global $val_shl i64 (i64.const 8))
  (global $val_shr i64 (i64.const 16))
  (global $val_or i64 (i64.const 24))
  (global $val_xor i64 (i64.const 32))
  (global $val_and i64 (i64.const 40))
  (global $val_not i64 (i64.const 48))
  (global $val_fact i64 (i64.const 56))
  (global $val_abs i64 (i64.const 64))
  (global $option i64 (i64.const 72))
  (global $val_prop_1 i64 (i64.const 88))
  (global $val_prop_2 i64 (i64.const 96))



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

  (func $f64_factorial (param $n i64) (result i64)
    (local $i f64)
    (local $res f64)
    (local $limit f64)
    f64.const 1.0
    local.set $res
    f64.const 2.0
    local.set $i
    local.get $n
    f64.reinterpret_i64
    local.set $limit
    (block $break
      (loop $top
        local.get $i
        local.get $limit
        f64.gt
        br_if $break
        
        local.get $res
        local.get $i
        f64.mul
        local.set $res
        
        local.get $i
        f64.const 1.0
        f64.add
        local.set $i
        br $top
      )
    )
    local.get $res
    i64.reinterpret_f64
  )

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
      global.get $val_pow
    i64.const 4611686018427387904 ;; f64: 2
    f64.reinterpret_i64
    i64.const 4613937818241073152 ;; f64: 3
    f64.reinterpret_i64
    call $f64_pow
    i64.reinterpret_f64
      i64.store
      global.get $val_shl
    i64.const 4611686018427387904 ;; f64: 2
    i64.const 4611686018427387904 ;; f64: 2
    i64.shl
      i64.store
      global.get $val_shr
    i64.const 4620693217682128896 ;; f64: 8
    i64.const 4607182418800017408 ;; f64: 1
    i64.shr_s
      i64.store
      global.get $val_or
    i64.const 4611686018427387904 ;; f64: 2
    i64.const 4607182418800017408 ;; f64: 1
    i64.or
      i64.store
      global.get $val_xor
    i64.const 4613937818241073152 ;; f64: 3
    i64.const 4607182418800017408 ;; f64: 1
    i64.xor
      i64.store
      global.get $val_and
    i64.const 4613937818241073152 ;; f64: 3
    i64.const 4611686018427387904 ;; f64: 2
    i64.and
      i64.store
      global.get $val_not
    i64.const 0 ;; f64: 0
    i64.const -1
    i64.xor
      i64.store
      global.get $val_fact
    i64.const 4617315517961601024 ;; f64: 5
    call $f64_factorial
      i64.store
      global.get $val_abs
    i64.const -4592264245034352640 ;; f64: -42
    f64.reinterpret_i64
    f64.abs
    i64.reinterpret_f64
      i64.store
      global.get $option
      i64.const 0
      i64.add
    i64.const 4638355772470722560 ;; f64: 123
      i64.store
      global.get $option
      i64.const 8
      i64.add
    i64.const 4646729653027864576 ;; f64: 456
      i64.store
      global.get $val_prop_1
    global.get $option
    i64.const 0
    i64.add
    i64.load
      i64.store
      global.get $val_prop_2
    global.get $option
    i64.const 8
    i64.add
    i64.load
      i64.store
  )
)