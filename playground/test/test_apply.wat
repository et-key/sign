(module
  (import "env" "print_float" (func $print_float (param f64)))
  (import "env" "input_float" (func $input_float (result f64)))
  (import "env" "math_fmod" (func $math_fmod (param f64 f64) (result f64)))
  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))

  (func $is_truthy (param $val f64) (result i32)
    local.get $val
    local.get $val
    f64.eq
  )

  (func $main (export "main") (result f64)
    (local $tmp_bool f64)
    (local $tmp_L f64)
    (local $tmp_R f64)
    f64.const 0.0
    drop
    call $input_float
    f64.const 5.0
    f64.add
    f64.const 10.0
    f64.mul
    call $print_float

    f64.const 0.0
  )
)