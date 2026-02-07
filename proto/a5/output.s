.global _start
.text
_start:
    adr x0, heap_buffer
    adr x1, heap_ptr
    str x0, [x1]
    ; Global Define heap = 0
    b after_alloc_0
alloc:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, current ; $ address
    str x0, [sp, #-16]!
    adr x0, heap
    ldr x0, [x0]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x0, heap ; $ address
    str x0, [sp, #-16]!
    adr x0, current
    str x0, [sp, #-16]!
    mov x0, x0
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x0, current
    ldr x0, [x0]         ; @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_alloc_0:
    adr x0, alloc
    b after_cons_1
cons:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, cell ; $ address
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #16
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    str x0, [x1]
    adr x0, cell ; $ address
    str x0, [sp, #-16]!
    mov x0, x0
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_0
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    str x0, [x1]
    adr x0, next_ptr ; $ address
    str x0, [sp, #-16]!
    adr x0, cell
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x0, next_ptr ; $ address
    str x0, [sp, #-16]!
    mov x0, x1
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_1
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    str x0, [x1]
    adr x0, cell
    ldr x0, [x0]         ; @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_cons_1:
    adr x0, cons
    b after_head_2
head:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x0, x0
    ldr x0, [x0]         ; @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_head_2:
    adr x0, head
    b after_tail_3
tail:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, next_ptr ; $ address
    str x0, [sp, #-16]!
    mov x0, x0
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x0, next_ptr
    ldr x0, [x0]         ; @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_tail_3:
    adr x0, tail
    b after_main_4
main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, cons
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #10
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #20
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!  ; Push Func
    ldr x0, [x29, #-16]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!  ; Push Func
    ldr x0, [x29, #-16]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_main_4:
    adr x0, main
    b after_match_test_5
match_test:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x0, x0
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_9
    adr x0, sign_id ; Unit (False)
    b end_10
true_9:
    mov x0, x1 ; Return RHS
end_10:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_7
    mov x0, #100
    b case_end_8
case_fail_7:
    adr x0, sign_id
case_end_8:
    adr x9, sign_id
    cmp x0, x9
    b.ne match_end_6
    mov x0, x0
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_13
    adr x0, sign_id ; Unit (False)
    b end_14
true_13:
    mov x0, x1 ; Return RHS
end_14:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_11
    mov x0, #200
    b case_end_12
case_fail_11:
    adr x0, sign_id
case_end_12:
    adr x9, sign_id
    cmp x0, x9
    b.ne match_end_6
    mov x0, #300
match_end_6:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_match_test_5:
    adr x0, match_test
    adr x0, main
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    mov x8, #93       ; svc exit
    svc #0

sign_id:
    ret

.data
str_0: .asciz "Store head at +0"
str_1: .asciz "Store tail at +8"
heap: .quad 0

.bss
heap_buffer: .skip 65536
