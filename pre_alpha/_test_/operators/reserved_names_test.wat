(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 0 funcref)
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 100)

  (global $hp (mut i64) (i64.const 2048))
  (global $let i64 (i64.const 0))
  (global $class i64 (i64.const 8))
  (global $result i64 (i64.const 16))





  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
      global.get $let
    i64.const 4631107791820423168 ;; f64: 42
      i64.store
      global.get $class
    i64.const 4636737291354636288 ;; f64: 100
      i64.store
      global.get $result
    global.get $let
    i64.load
    f64.reinterpret_i64
    global.get $class
    i64.load
    f64.reinterpret_i64
    f64.add
    i64.reinterpret_f64
      i64.store
  )
)