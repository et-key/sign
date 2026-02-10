
.global __sign_init
.text
__sign_init:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    b after_fact_impl_1
fact_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_5
    adr x0, sign_id
    b cmp_end_6
cmp_true_5:
    mov x0, x1
cmp_end_6:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3
    mov x0, #1
    b cond_end_4
cond_false_3:
    adr x0, sign_id
cond_end_4:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, fact
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    ldr x1, [sp], #16
    mul x0, x1, x0
blk_end_2:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_fact_impl_1:
    // Closure for fact_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, fact_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, fact
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #5
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_7:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_8
    add x2, x2, #1
    b strlen_7
strlen_done_8:
    mov x8, #64      // syscall write
    svc #0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
blk_end_0:


    ldp x29, x30, [sp], #16
    ret

.data

.bss
fact: .quad 0

