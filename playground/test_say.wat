(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 2 funcref)
  (elem (i32.const 0) $f $g)
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 100)

  (global $hp (mut i64) (i64.const 2048))



  (func $f (param $x i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $x
    i64.eqz
    (if (then i64.const 0 return))
  local.get $x
  f64.reinterpret_i64
  i64.const 4611686018427387904 ;; f64: 2
  f64.reinterpret_i64
  f64.mul
  i64.reinterpret_f64
  )

  (func $g (param $x i64) (result i64)
  (local $tmp_l i64) (local $tmp_r i64)
    local.get $x
    i64.eqz
    (if (then i64.const 0 return))
  local.get $x
  f64.reinterpret_i64
  i64.const 4607182418800017408 ;; f64: 1
  f64.reinterpret_i64
  f64.add
  i64.reinterpret_f64
  )

  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
    (local $say i64)
    i64.const 0 ;; unsupported inline code: console.log
      local.set $say
    local.get $say
    local.set $tmp_l
    local.get $tmp_l
    i64.eqz
    (if (result i64)
      (then i64.const 0)
      (else
    i64.const 4613937818241073152 ;; f64: 3
    call $f
    call $g
        local.get $tmp_l
        i32.wrap_i64
        call_indirect (type $t_arity_1)
      )
    )
      drop
  )
)