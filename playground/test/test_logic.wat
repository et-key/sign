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
    f64.const 5.0
    local.set $tmp_L
    f64.const 5.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.eq
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_L
    f64.const 2.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.ne
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_L
    f64.const 2.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.lt
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $print_float
    f64.const 2.0
    local.set $tmp_L
    f64.const 1.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.gt
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_L
    f64.const 1.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.le
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $print_float
    f64.const 2.0
    local.set $tmp_L
    f64.const 2.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.ge
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $print_float
    f64.const 1.0
    call $is_truthy
    if (result f64)
      f64.const nan
    else
      f64.const 1.0
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_L
    f64.const 2.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.eq
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $is_truthy
    if (result f64)
      f64.const nan
    else
      f64.const 1.0
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_L
    f64.const 1.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.eq
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $is_truthy
    if (result f64)
    f64.const 100.0
    else
      f64.const nan
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_L
    f64.const 2.0
    local.set $tmp_R
    local.get $tmp_L
    local.get $tmp_R
    f64.eq
    if (result f64)
      local.get $tmp_R
    else
      f64.const nan
    end
    call $is_truthy
    if (result f64)
    f64.const 200.0
    else
      f64.const nan
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_bool
    local.get $tmp_bool
    call $is_truthy
    if (result f64)
    f64.const 42.0
    else
      local.get $tmp_bool
    end
    call $print_float
    f64.const 0.0
    local.set $tmp_bool
    local.get $tmp_bool
    call $is_truthy
    if (result f64)
      local.get $tmp_bool
    else
    f64.const 99.0
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_L
    f64.const 1.0
    local.set $tmp_R
    local.get $tmp_L
    call $is_truthy
    if (result f64)
      local.get $tmp_R
      call $is_truthy
      if (result f64)
        f64.const nan
      else
        local.get $tmp_L
      end
    else
      local.get $tmp_R
      call $is_truthy
      if (result f64)
        local.get $tmp_R
      else
        f64.const nan
      end
    end
    call $print_float
    f64.const 1.0
    local.set $tmp_L
    f64.const 0.0
    local.set $tmp_R
    local.get $tmp_L
    call $is_truthy
    if (result f64)
      local.get $tmp_R
      call $is_truthy
      if (result f64)
        f64.const nan
      else
        local.get $tmp_L
      end
    else
      local.get $tmp_R
      call $is_truthy
      if (result f64)
        local.get $tmp_R
      else
        f64.const nan
      end
    end
    call $print_float
    f64.const 1.0
    i32.trunc_sat_f64_s
    f64.const 42.0
    i32.trunc_sat_f64_s
    i32.and
    f64.convert_i32_s
    call $print_float
    f64.const 0.0
    i32.trunc_sat_f64_s
    f64.const 99.0
    i32.trunc_sat_f64_s
    i32.or
    f64.convert_i32_s
    call $print_float
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
    f64.const 1.0
    i32.trunc_sat_f64_s
    f64.const 2.0
    i32.trunc_sat_f64_s
    i32.shl
    f64.convert_i32_s
    call $print_float
    f64.const 4.0
    i32.trunc_sat_f64_s
    f64.const 1.0
    i32.trunc_sat_f64_s
    i32.shr_s
    f64.convert_i32_s
    call $print_float
    f64.const 0.0
    i32.trunc_sat_f64_s
    i32.const -1
    i32.xor
    f64.convert_i32_s
    call $print_float
    ;; UNIMPLEMENTED: lambda (?)
    f64.const nan
    call $print_float

    f64.const 0.0
  )
)