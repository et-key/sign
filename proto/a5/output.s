.global _start
.text
_start:
    adr x0, heap_buffer
    adr x1, heap_ptr
    str x0, [x1]
    ; Global Define heap_ptr = 0
    b after_alloc_0
alloc:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, heap_ptr
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-16]
    str x0, [sp, #-16]!
    mov x0, x0
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, heap_ptr ; $ address
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    ldr x0, [x29, #-16]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_alloc_0:
    adr x0, alloc
    b after_main_1
main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, alloc
    ldr x0, [x0]
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #16
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_main_1:
    adr x0, main
    adr x0, main
    blr x0
    mov x8, #93       ; svc exit
    svc #0

sign_id:
    ret

.data
heap_ptr: .quad 0

.bss
heap_buffer: .skip 65536
