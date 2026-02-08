.global __sign_init
.text
__sign_init:
    adr x0, heap_buffer
    adr x1, heap_ptr
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    cmp x0, #0
    cneg x0, x0, mi
    cmp x0, #0
    cneg x0, x0, mi
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    adr x0, sign_id
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    adr x0, sign_id
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    str x0, [sp, #-16]!  // Push Closure
    adr x0, sign_id
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    adr x0, sign_id
    mov x8, #93       // svc exit
    svc #0


.data
_print_str: .quad closure_print_str
_print_char: .quad closure_print_char
