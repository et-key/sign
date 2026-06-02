(module
  (func $test (result f64)
    (local $cond i32)
    i32.const 0
    local.set $cond

    f64.const 42.0

    local.get $cond
    if
      nop
    end
  )
)
