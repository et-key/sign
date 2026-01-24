
.global _start
.align 2
_start:
    // Entry point
    mov x8, #214
    mov x0, #0
    svc #0
    adrp x1, heap_ptr
    add x1, x1, :lo12:heap_ptr
    str x0, [x1]
    mov x2, #67108864
    add x0, x0, x2
    mov x8, #214
    svc #0
    mov x0, #10
    str x0, [sp, #-16]!
    mov x0, #20
    str x0, [sp, #-16]!
    adrp x1, heap_ptr
    add x1, x1, :lo12:heap_ptr
    ldr x0, [x1]
    add x2, x0, #16
    str x2, [x1]
    ldr x2, [sp], #16
    str x2, [x0, #8]
    ldr x2, [sp], #16
    str x2, [x0]
    mov x0, #10
    str x0, [sp, #-16]!
    mov x0, #20
    str x0, [sp, #-16]!
    adrp x1, heap_ptr
    add x1, x1, :lo12:heap_ptr
    ldr x0, [x1]
    add x2, x0, #16
    str x2, [x1]
    ldr x2, [sp], #16
    str x2, [x0, #8]
    ldr x2, [sp], #16
    str x2, [x0]
    ldr x0, [x0]
    mov x0, #10
    str x0, [sp, #-16]!
    mov x0, #20
    str x0, [sp, #-16]!
    adrp x1, heap_ptr
    add x1, x1, :lo12:heap_ptr
    ldr x0, [x1]
    add x2, x0, #16
    str x2, [x1]
    ldr x2, [sp], #16
    str x2, [x0, #8]
    ldr x2, [sp], #16
    str x2, [x0]
    ldr x0, [x0, #8]
    mov x8, #93
    svc #0
.data
.align 3
heap_ptr: .quad 0
