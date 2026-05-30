(module
  (import "env" "print" (func $print (param i32)))
  (memory 1) ;; 1 page = 64KB
  (export "memory" (memory 0))
  (type $func_sig (func (param f64) (result f64)))

  (table 2 funcref)
  (elem (i32.const 0) $io_handler $event_loop)

  (func $io_handler (param $f f64) (result f64)
    (local $<io_handler> f64)
    (local $__sink_ptr_0 i64)
    (local $__list_ptr f64)
    i64.const 1073741828
    local.set $__sink_ptr_0
    local.get $__sink_ptr_0
    i32.wrap_i64
    i64.const 1073741824
    i32.wrap_i64
    f64.load
    f64.store
    local.get $__sink_ptr_0
    i64.const 8
    i64.add
    local.set $__sink_ptr_0
    i64.const 0
  )
  (func $event_loop (param $event_loop f64) (result f64)
    (local $<event_loop> f64)
    (local $__reduce_ptr_1 f64)
    (local $__reduce_end_1 f64)
    (local $__reduce_acc_1 f64)
    (local $__map_start_1 f64)
    (local $__reduce_ptr_2 f64)
    (local $__reduce_end_2 f64)
    (local $__reduce_acc_2 f64)
    (local $__map_start_2 f64)
    (local $__list_ptr f64)
    ;; Unhandled node: operation ~+
    f64.const 0
  )
  (func $main (export "main") (result f64)
    f64.const 0
  )
)
