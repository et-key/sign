
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
    b end_func_1
match:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #16
    str x0, [x29, #-16]
    ldr x0, [x29, #-16]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    cmp x1, x0
    adrp x2, _
    add x2, x2, :lo12:_
    ldr x2, [x2]
    csel x0, x1, x2, eq
    adrp x9, _
    add x9, x9, :lo12:_
    ldr x9, [x9]
    cmp x0, x9
    b.eq skip_guard_3
    mov x0, #100
    b epilogue_2
skip_guard_3:
    ldr x0, [x29, #-16]
    str x0, [sp, #-16]!
    mov x0, #20
    ldr x1, [sp], #16
    cmp x1, x0
    adrp x2, _
    add x2, x2, :lo12:_
    ldr x2, [x2]
    csel x0, x1, x2, eq
    adrp x9, _
    add x9, x9, :lo12:_
    ldr x9, [x9]
    cmp x0, x9
    b.eq skip_guard_4
    mov x0, #200
    b epilogue_2
skip_guard_4:
    mov x0, #300
epilogue_2:
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret
end_func_1:
    b end_func_5
main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x0, #10
    str x0, [sp, #-16]!
    ldr x0, [sp], #16
    bl match
    mov x0, #20
    str x0, [sp, #-16]!
    ldr x0, [sp], #16
    bl match
    mov x0, #99
    str x0, [sp, #-16]!
    ldr x0, [sp], #16
    bl match
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [sp], #16
    bl match
epilogue_6:
    ldp x29, x30, [sp], #16
    ret
end_func_5:
    mov x8, #93
    svc #0
.data
.align 3
heap_ptr: .quad 0
_: .quad _
