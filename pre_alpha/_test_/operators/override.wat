(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))
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

  (func $op_add (param $x i64) (param $y i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
  i64.const 0 ;; fallback for _
  )

  (func $op_or_div (param $x i64) (param $y i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
  i64.const 0 ;; fallback for String
  )

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
    i64.const 4607182418800017408 ;; f64: 1
    i64.const 4611686018427387904 ;; f64: 2
    call $op_add
      drop
    i64.const 4613937818241073152 ;; f64: 3
    i64.const 4620693217682128896 ;; f64: 8
    call $op_or_div
      drop
  )
)