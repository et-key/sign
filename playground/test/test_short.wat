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
    f64.const 1.0
    i32.trunc_sat_f64_s
    f64.const 1.0
    i32.trunc_sat_f64_s
    i32.xor
    f64.convert_i32_s
    call $print_float
    f64.const 1.0
    i32.trunc_sat_f64_s
    f64.const 0.0
    i32.trunc_sat_f64_s
    i32.xor
    f64.convert_i32_s
    call $print_float

    f64.const 0.0
  )
)