(module
  ;; Import pow from JS host
  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))

  (type $t_arity_0 (func (result i64)))
  (type $t_arity_1 (func (param i64) (result i64)))
  (type $t_arity_2 (func (param i64 i64) (result i64)))
  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))
  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))

  (table (export "table") 1 funcref)
  (elem (i32.const 0) $double)
  ;; Export 64-bit linear memory
  (memory (export "memory") i64 100)

  (global $hp (mut i64) (i64.const 2048))





  ;; Main entry function
  (func (export "main")
    (local $tmp_l i64) (local $tmp_r i64)
    i64.const 0
      drop
  )
)