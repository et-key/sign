// Sign Compiler Output
// Target: aarch64
// Mode: compile
// Exception Level: 0
// Link: static
// Options: debug=false, optimize=false

.global __sign_init
.text
__sign_init:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    adr x0, sys_brk
    adr x1, heap_start
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3
    tst x0, #1
    b.ne do_compose_1
do_apply_2:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4
do_compose_1:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4
do_concat_3:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_4:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sys_brk
    adr x1, heap_end
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, heap_start
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, =0x4130000000000000
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_7
    tst x0, #1
    b.ne do_compose_5
do_apply_6:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8
do_compose_5:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8
do_concat_7:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_8:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, heap_start
    ldr x0, [x0]
    adr x1, heap_addr
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_alloc_impl_9
alloc_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, curr
    str x0, [sp, #-16]!
    adr x0, heap_addr
    ldr x0, [x0]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_10
    adr x0, heap_addr
    str x0, [sp, #-16]!
    adr x0, curr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_10
    adr x0, curr
blk_end_10:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_alloc_impl_9:
    // Closure for alloc_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, alloc_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_11_12
func_11:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_14
    b or_end_15
or_right_14:
    adr x0, head
or_end_15:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_13
    b after_func_16_17
func_16:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, addr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_19
    adr x0, alloc
    ldr x0, [x0]
    b cond_end_20
cond_false_19:
    adr x0, sign_id
cond_end_20:
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_23
    tst x0, #1
    b.ne do_compose_21
do_apply_22:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_24
do_compose_21:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_24
do_concat_23:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_24:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_18
    adr x0, addr
    str x0, [sp, #-16]!
    adr x0, head
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_18
    adr x0, addr
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_18
    adr x0, addr
blk_end_18:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_16_17:
    // Closure for func_16
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_16
    ldr x0, [sp], #16
    bl _cons
blk_end_13:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_11_12:
    // Closure for func_11
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_11
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_head_impl_25
head_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_26_27
func_26:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_31_32
func_31:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_33_34
func_33:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_33_34:
    // Closure for func_33
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_33
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_37
    tst x0, #1
    b.ne do_compose_35
do_apply_36:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_38
do_compose_35:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_38
do_concat_37:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_38:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_41
    tst x0, #1
    b.ne do_compose_39
do_apply_40:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_42
do_compose_39:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_42
do_concat_41:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_42:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_31_32:
    // Closure for func_31
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_31
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_28
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_30
xor_true_28:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_29
    adr x0, sign_id
    b xor_end_30
xor_false_29:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_26_27:
    // Closure for func_26
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_26
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_head_impl_25:
    // Closure for head_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, head_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_tail_impl_43
tail_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_44_45
func_44:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_49_50
func_49:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_51_52
func_51:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_51_52:
    // Closure for func_51
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_51
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_55
    tst x0, #1
    b.ne do_compose_53
do_apply_54:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_56
do_compose_53:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_56
do_concat_55:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_56:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_59
    tst x0, #1
    b.ne do_compose_57
do_apply_58:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_60
do_compose_57:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_60
do_concat_59:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_60:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_49_50:
    // Closure for func_49
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_49
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_46
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_48
xor_true_46:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_47
    adr x0, sign_id
    b xor_end_48
xor_false_47:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_44_45:
    // Closure for func_44
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_44
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_tail_impl_43:
    // Closure for tail_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, tail_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_61_62
func_61:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_64
    b or_end_65
or_right_64:
    adr x0, list
or_end_65:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_63
    b after_func_66_67
func_66:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_71
    adr x0, sign_id
    b cmp_end_72
cmp_true_71:
cmp_end_72:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_69
    adr x0, head
    ldr x0, [x0]
    b cond_end_70
cond_false_69:
    adr x0, sign_id
cond_end_70:
    str x0, [sp, #-16]!
    adr x0, list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_75
    tst x0, #1
    b.ne do_compose_73
do_apply_74:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_76
do_compose_73:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_76
do_concat_75:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_76:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_68
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tail
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_79
    tst x0, #1
    b.ne do_compose_77
do_apply_78:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_80
do_compose_77:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_80
do_concat_79:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_80:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_83
    tst x0, #1
    b.ne do_compose_81
do_apply_82:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_84
do_compose_81:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_84
do_concat_83:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_84:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_87
    tst x0, #1
    b.ne do_compose_85
do_apply_86:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_88
do_compose_85:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_88
do_concat_87:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_88:
blk_end_68:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_66_67:
    // Closure for func_66
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_66
    ldr x0, [sp], #16
    bl _cons
blk_end_63:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_61_62:
    // Closure for func_61
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_61
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_factorial_impl_89
factorial_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_93
    adr x0, sign_id
    b cmp_end_94
cmp_true_93:
cmp_end_94:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_91
    mov x0, #1
    b cond_end_92
cond_false_91:
    adr x0, sign_id
cond_end_92:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_90
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, factorial
    ldr x0, [x0]
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_97
    tst x0, #1
    b.ne do_compose_95
do_apply_96:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_98
do_compose_95:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_98
do_concat_97:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_98:
blk_end_90:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_factorial_impl_89:
    // Closure for factorial_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, factorial_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_99_100
func_99:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_102
    b or_end_103
or_right_102:
    adr x0, start
or_end_103:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_101
    b after_func_104_105
func_104:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, start
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_109
    adr x0, sign_id
    b cmp_end_110
cmp_true_109:
cmp_end_110:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_107
    mov x0, #0
    b cond_end_108
cond_false_107:
    adr x0, sign_id
cond_end_108:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_106
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, start
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_113
    tst x0, #1
    b.ne do_compose_111
do_apply_112:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_114
do_compose_111:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_114
do_concat_113:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_114:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, start
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_117
    tst x0, #1
    b.ne do_compose_115
do_apply_116:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_118
do_compose_115:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_118
do_concat_117:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_118:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_121
    tst x0, #1
    b.ne do_compose_119
do_apply_120:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_122
do_compose_119:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_122
do_concat_121:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_122:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_125
    tst x0, #1
    b.ne do_compose_123
do_apply_124:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_126
do_compose_123:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_126
do_concat_125:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_126:
blk_end_106:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_104_105:
    // Closure for func_104
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_104
    ldr x0, [sp], #16
    bl _cons
blk_end_101:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_99_100:
    // Closure for func_99
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_99
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_print_char_impl_127
print_char_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_131
    tst x0, #1
    b.ne do_compose_129
do_apply_130:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_132
do_compose_129:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_132
do_concat_131:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_132:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_135
    tst x0, #1
    b.ne do_compose_133
do_apply_134:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_136
do_compose_133:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_136
do_concat_135:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_136:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_128
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_139
    tst x0, #1
    b.ne do_compose_137
do_apply_138:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_140
do_compose_137:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_140
do_concat_139:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_140:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_143
    tst x0, #1
    b.ne do_compose_141
do_apply_142:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_144
do_compose_141:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_144
do_concat_143:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_144:
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_147
    tst x0, #1
    b.ne do_compose_145
do_apply_146:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_148
do_compose_145:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_148
do_concat_147:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_148:
blk_end_128:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_print_char_impl_127:
    // Closure for print_char_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, print_char_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_print_str_impl_149
print_str_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_len_impl_151
len_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_155_156
func_155:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_157_158
func_157:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_159_160
func_159:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_159_160:
    // Closure for func_159
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_159
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_157_158:
    // Closure for func_157
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_157
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_163
    tst x0, #1
    b.ne do_compose_161
do_apply_162:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_164
do_compose_161:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_164
do_concat_163:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_164:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_167
    tst x0, #1
    b.ne do_compose_165
do_apply_166:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_168
do_compose_165:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_168
do_concat_167:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_168:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_155_156:
    // Closure for func_155
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_155
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_169_170
func_169:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_169_170:
    // Closure for func_169
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_169
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_152
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_154
xor_true_152:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_153
    adr x0, sign_id
    b xor_end_154
xor_false_153:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_len_impl_151:
    // Closure for len_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, len_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_171
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_171
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_171
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_174
    adr x0, sign_id
    b cmp_end_175
cmp_true_174:
cmp_end_175:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_172
    ldr x0, [x29, #-64]
    b cond_end_173
cond_false_172:
    adr x0, sign_id
cond_end_173:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_171
    adr x0, len_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_178
    tst x0, #1
    b.ne do_compose_176
do_apply_177:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_179
do_compose_176:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_179
do_concat_178:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_179:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_182
    tst x0, #1
    b.ne do_compose_180
do_apply_181:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_183
do_compose_180:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_183
do_concat_182:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_183:
blk_end_171:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_186
    tst x0, #1
    b.ne do_compose_184
do_apply_185:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_187
do_compose_184:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_187
do_concat_186:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_187:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_150
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_190
    tst x0, #1
    b.ne do_compose_188
do_apply_189:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_191
do_compose_188:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_191
do_concat_190:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_191:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_150
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_194
    tst x0, #1
    b.ne do_compose_192
do_apply_193:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_195
do_compose_192:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_195
do_concat_194:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_195:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_198
    tst x0, #1
    b.ne do_compose_196
do_apply_197:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_199
do_compose_196:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_199
do_concat_198:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_199:
    str x0, [sp, #-16]!
    adr x0, len
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_202
    tst x0, #1
    b.ne do_compose_200
do_apply_201:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_203
do_compose_200:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_203
do_concat_202:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_203:
blk_end_150:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_print_str_impl_149:
    // Closure for print_str_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, print_str_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_print_num_impl_204
print_num_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_208
    adr x0, sign_id
    b cmp_end_209
cmp_true_208:
cmp_end_209:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_206
    adr x0, sign_id
    b cond_end_207
cond_false_206:
    adr x0, sign_id
cond_end_207:
    str x0, [sp, #-16]!
    adr x0, print_char
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_213
    tst x0, #1
    b.ne do_compose_211
do_apply_212:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_214
do_compose_211:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_214
do_concat_213:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_214:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_210
    mov x0, #0
blk_end_210:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_217
    tst x0, #1
    b.ne do_compose_215
do_apply_216:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_218
do_compose_215:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_218
do_concat_217:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_218:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_205
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_221
    adr x0, sign_id
    b cmp_end_222
cmp_true_221:
cmp_end_222:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_219
    adr x0, sign_id
    b cond_end_220
cond_false_219:
    adr x0, sign_id
cond_end_220:
    str x0, [sp, #-16]!
    adr x0, print_char
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_226
    tst x0, #1
    b.ne do_compose_224
do_apply_225:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_227
do_compose_224:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_227
do_concat_226:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_227:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_223
    adr x0, print_num
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_230
    tst x0, #1
    b.ne do_compose_228
do_apply_229:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_231
do_compose_228:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_231
do_concat_230:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_231:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_223
    mov x0, #0
blk_end_223:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_234
    tst x0, #1
    b.ne do_compose_232
do_apply_233:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_235
do_compose_232:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_235
do_concat_234:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_235:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_205
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_238
    tst x0, #1
    b.ne do_compose_236
do_apply_237:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_239
do_compose_236:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_239
do_concat_238:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_239:
blk_end_205:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_print_num_impl_204:
    // Closure for print_num_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, print_num_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after__print_num_rec_impl_240
_print_num_rec_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_244
    adr x0, sign_id
    b cmp_end_245
cmp_true_244:
cmp_end_245:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_242
    mov x0, #0
    b cond_end_243
cond_false_242:
    adr x0, sign_id
cond_end_243:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_241
    adr x0, _print_num_rec
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_248
    tst x0, #1
    b.ne do_compose_246
do_apply_247:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_249
do_compose_246:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_249
do_concat_248:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_249:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_241
    adr x0, print_char
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #48
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_252
    tst x0, #1
    b.ne do_compose_250
do_apply_251:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_253
do_compose_250:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_253
do_concat_252:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_253:
blk_end_241:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after__print_num_rec_impl_240:
    // Closure for _print_num_rec_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, _print_num_rec_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_254_255
func_254:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_257
    b or_end_258
or_right_257:
    adr x0, x
or_end_258:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_256
    b after_func_259_260
func_259:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_259_260:
    // Closure for func_259
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_259
    ldr x0, [sp], #16
    bl _cons
blk_end_256:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_254_255:
    // Closure for func_254
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_254
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_261_262
func_261:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_264
    b or_end_265
or_right_264:
    adr x0, x
or_end_265:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_263
    b after_func_266_267
func_266:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_266_267:
    // Closure for func_266
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_266
    ldr x0, [sp], #16
    bl _cons
blk_end_263:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_261_262:
    // Closure for func_261
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_261
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_268_269
func_268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_271
    b or_end_272
or_right_271:
    adr x0, x
or_end_272:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_270
    b after_func_273_274
func_273:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_273_274:
    // Closure for func_273
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_273
    ldr x0, [sp], #16
    bl _cons
blk_end_270:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_268_269:
    // Closure for func_268
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_268
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_275_276
func_275:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_278
    b or_end_279
or_right_278:
    adr x0, x
or_end_279:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_277
    b after_func_280_281
func_280:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_280_281:
    // Closure for func_280
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_280
    ldr x0, [sp], #16
    bl _cons
blk_end_277:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_275_276:
    // Closure for func_275
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_275
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_282_283
func_282:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_285
    b or_end_286
or_right_285:
    adr x0, x
or_end_286:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_284
    b after_func_287_288
func_287:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    str x0, [sp, #-16]!
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Language
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_292
    tst x0, #1
    b.ne do_compose_290
do_apply_291:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_293
do_compose_290:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_293
do_concat_292:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_293:
    str x0, [sp, #-16]!
    adr x0, Operator
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_296
    tst x0, #1
    b.ne do_compose_294
do_apply_295:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_297
do_compose_294:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_297
do_concat_296:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_297:
    str x0, [sp, #-16]!
    adr x0, Table
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_300
    tst x0, #1
    b.ne do_compose_298
do_apply_299:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_301
do_compose_298:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_301
do_concat_300:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_301:
    str x0, [sp, #-16]!
    adr x0, operator
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_304
    tst x0, #1
    b.ne do_compose_302
do_apply_303:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_305
do_compose_302:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_305
do_concat_304:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_305:
    str x0, [sp, #-16]!
    adr x0, sn
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_308
    tst x0, #1
    b.ne do_compose_306
do_apply_307:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_309
do_compose_306:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_309
do_concat_308:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_309:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_312
    tst x0, #1
    b.ne do_compose_310
do_apply_311:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_313
do_compose_310:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_313
do_concat_312:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_313:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_289
    adr x0, Wraps
    str x0, [sp, #-16]!
    adr x0, standard
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_316
    tst x0, #1
    b.ne do_compose_314
do_apply_315:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_317
do_compose_314:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_317
do_concat_316:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_317:
    str x0, [sp, #-16]!
    adr x0, operators
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_320
    tst x0, #1
    b.ne do_compose_318
do_apply_319:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_321
do_compose_318:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_321
do_concat_320:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_321:
    str x0, [sp, #-16]!
    adr x0, as
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_324
    tst x0, #1
    b.ne do_compose_322
do_apply_323:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_325
do_compose_322:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_325
do_concat_324:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_325:
    str x0, [sp, #-16]!
    adr x0, first
    str x0, [sp, #-16]!
    adr x0, class
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_328
    tst x0, #1
    b.ne do_compose_326
do_apply_327:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_329
do_compose_326:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_329
do_concat_328:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_329:
    str x0, [sp, #-16]!
    adr x0, functions
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_332
    tst x0, #1
    b.ne do_compose_330
do_apply_331:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_333
do_compose_330:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_333
do_concat_332:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_333:
    str x0, [sp, #-16]!
    adr x0, using
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_336
    tst x0, #1
    b.ne do_compose_334
do_apply_335:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_337
do_compose_334:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_337
do_concat_336:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_337:
    str x0, [sp, #-16]!
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, syntax
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_340
    tst x0, #1
    b.ne do_compose_338
do_apply_339:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_341
do_compose_338:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_341
do_concat_340:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_341:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_344
    tst x0, #1
    b.ne do_compose_342
do_apply_343:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_345
do_compose_342:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_345
do_concat_344:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_345:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_289
    adr x0, A_Operator_Table
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_348
    tst x0, #1
    b.ne do_compose_346
do_apply_347:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_349
do_compose_346:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_349
do_concat_348:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_349:
    str x0, [sp, #-16]!
    adr x0, md
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_352
    tst x0, #1
    b.ne do_compose_350
do_apply_351:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_353
do_compose_350:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_353
do_concat_352:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_353:
blk_end_289:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_356
    tst x0, #1
    b.ne do_compose_354
do_apply_355:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_357
do_compose_354:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_357
do_concat_356:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_357:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_287_288:
    // Closure for func_287
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_287
    ldr x0, [sp], #16
    bl _cons
blk_end_284:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_282_283:
    // Closure for func_282
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_282
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_360_361
func_360:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_365_366
func_365:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_367_368
func_367:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_369_370
func_369:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_369_370:
    // Closure for func_369
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_369
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_367_368:
    // Closure for func_367
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_367
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_373
    tst x0, #1
    b.ne do_compose_371
do_apply_372:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_374
do_compose_371:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_374
do_concat_373:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_374:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_377
    tst x0, #1
    b.ne do_compose_375
do_apply_376:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_378
do_compose_375:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_378
do_concat_377:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_378:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_365_366:
    // Closure for func_365
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_365
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_379_380
func_379:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_379_380:
    // Closure for func_379
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_379
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_362
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_364
xor_true_362:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_363
    adr x0, sign_id
    b xor_end_364
xor_false_363:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_360_361:
    // Closure for func_360
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_360
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_358
    b after_func_381_382
func_381:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_383_384
func_383:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_388_389
func_388:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_390_391
func_390:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_392_393
func_392:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_392_393:
    // Closure for func_392
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_392
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_390_391:
    // Closure for func_390
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_390
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_396
    tst x0, #1
    b.ne do_compose_394
do_apply_395:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_397
do_compose_394:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_397
do_concat_396:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_397:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_400
    tst x0, #1
    b.ne do_compose_398
do_apply_399:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_401
do_compose_398:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_401
do_concat_400:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_401:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_388_389:
    // Closure for func_388
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_388
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_402_403
func_402:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_402_403:
    // Closure for func_402
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_402
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_385
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_387
xor_true_385:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_386
    adr x0, sign_id
    b xor_end_387
xor_false_386:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_383_384:
    // Closure for func_383
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_383
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_406
    tst x0, #1
    b.ne do_compose_404
do_apply_405:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_407
do_compose_404:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_407
do_concat_406:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_407:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_381_382:
    // Closure for func_381
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_381
    ldr x0, [sp], #16
    bl _cons
    b cond_end_359
cond_false_358:
    adr x0, sign_id
cond_end_359:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_410_411
func_410:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_415_416
func_415:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_417_418
func_417:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_419_420
func_419:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_419_420:
    // Closure for func_419
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_419
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_417_418:
    // Closure for func_417
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_417
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_423
    tst x0, #1
    b.ne do_compose_421
do_apply_422:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_424
do_compose_421:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_424
do_concat_423:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_424:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_427
    tst x0, #1
    b.ne do_compose_425
do_apply_426:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_428
do_compose_425:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_428
do_concat_427:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_428:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_415_416:
    // Closure for func_415
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_415
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_429_430
func_429:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_429_430:
    // Closure for func_429
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_429
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_412
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_414
xor_true_412:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_413
    adr x0, sign_id
    b xor_end_414
xor_false_413:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_410_411:
    // Closure for func_410
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_410
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_408
    b after_func_431_432
func_431:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_433_434
func_433:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_438_439
func_438:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_440_441
func_440:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_442_443
func_442:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_442_443:
    // Closure for func_442
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_442
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_440_441:
    // Closure for func_440
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_440
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_446
    tst x0, #1
    b.ne do_compose_444
do_apply_445:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_447
do_compose_444:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_447
do_concat_446:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_447:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_450
    tst x0, #1
    b.ne do_compose_448
do_apply_449:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_451
do_compose_448:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_451
do_concat_450:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_451:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_438_439:
    // Closure for func_438
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_438
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_452_453
func_452:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_452_453:
    // Closure for func_452
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_452
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_435
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_437
xor_true_435:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_436
    adr x0, sign_id
    b xor_end_437
xor_false_436:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_433_434:
    // Closure for func_433
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_433
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_456
    tst x0, #1
    b.ne do_compose_454
do_apply_455:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_457
do_compose_454:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_457
do_concat_456:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_457:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_431_432:
    // Closure for func_431
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_431
    ldr x0, [sp], #16
    bl _cons
    b cond_end_409
cond_false_408:
    adr x0, sign_id
cond_end_409:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_460_461
func_460:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_465_466
func_465:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_467_468
func_467:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_469_470
func_469:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_469_470:
    // Closure for func_469
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_469
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_467_468:
    // Closure for func_467
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_467
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_473
    tst x0, #1
    b.ne do_compose_471
do_apply_472:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_474
do_compose_471:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_474
do_concat_473:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_474:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_477
    tst x0, #1
    b.ne do_compose_475
do_apply_476:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_478
do_compose_475:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_478
do_concat_477:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_478:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_465_466:
    // Closure for func_465
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_465
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_479_480
func_479:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_479_480:
    // Closure for func_479
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_479
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_462
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_464
xor_true_462:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_463
    adr x0, sign_id
    b xor_end_464
xor_false_463:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_460_461:
    // Closure for func_460
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_460
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_458
    b after_func_481_482
func_481:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_483_484
func_483:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_488_489
func_488:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_490_491
func_490:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_492_493
func_492:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_492_493:
    // Closure for func_492
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_492
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_490_491:
    // Closure for func_490
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_490
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_496
    tst x0, #1
    b.ne do_compose_494
do_apply_495:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_497
do_compose_494:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_497
do_concat_496:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_497:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_500
    tst x0, #1
    b.ne do_compose_498
do_apply_499:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_501
do_compose_498:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_501
do_concat_500:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_501:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_488_489:
    // Closure for func_488
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_488
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_502_503
func_502:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_502_503:
    // Closure for func_502
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_502
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_485
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_487
xor_true_485:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_486
    adr x0, sign_id
    b xor_end_487
xor_false_486:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_483_484:
    // Closure for func_483
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_483
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_506
    tst x0, #1
    b.ne do_compose_504
do_apply_505:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_507
do_compose_504:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_507
do_concat_506:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_507:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_481_482:
    // Closure for func_481
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_481
    ldr x0, [sp], #16
    bl _cons
    b cond_end_459
cond_false_458:
    adr x0, sign_id
cond_end_459:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_510_511
func_510:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_515_516
func_515:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_517_518
func_517:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_519_520
func_519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_519_520:
    // Closure for func_519
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_519
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_517_518:
    // Closure for func_517
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_517
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_523
    tst x0, #1
    b.ne do_compose_521
do_apply_522:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_524
do_compose_521:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_524
do_concat_523:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_524:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_527
    tst x0, #1
    b.ne do_compose_525
do_apply_526:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_528
do_compose_525:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_528
do_concat_527:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_528:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_515_516:
    // Closure for func_515
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_515
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_529_530
func_529:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_529_530:
    // Closure for func_529
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_529
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_512
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_514
xor_true_512:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_513
    adr x0, sign_id
    b xor_end_514
xor_false_513:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_510_511:
    // Closure for func_510
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_510
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_508
    b after_func_531_532
func_531:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_533_534
func_533:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_538_539
func_538:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_540_541
func_540:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_542_543
func_542:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_542_543:
    // Closure for func_542
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_542
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_540_541:
    // Closure for func_540
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_540
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_546
    tst x0, #1
    b.ne do_compose_544
do_apply_545:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_547
do_compose_544:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_547
do_concat_546:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_547:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_550
    tst x0, #1
    b.ne do_compose_548
do_apply_549:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_551
do_compose_548:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_551
do_concat_550:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_551:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_538_539:
    // Closure for func_538
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_538
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_552_553
func_552:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_552_553:
    // Closure for func_552
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_552
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_535
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_537
xor_true_535:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_536
    adr x0, sign_id
    b xor_end_537
xor_false_536:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_533_534:
    // Closure for func_533
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_533
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_556
    tst x0, #1
    b.ne do_compose_554
do_apply_555:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_557
do_compose_554:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_557
do_concat_556:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_557:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_531_532:
    // Closure for func_531
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_531
    ldr x0, [sp], #16
    bl _cons
    b cond_end_509
cond_false_508:
    adr x0, sign_id
cond_end_509:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_560_561
func_560:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_565_566
func_565:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_567_568
func_567:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_569_570
func_569:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_569_570:
    // Closure for func_569
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_569
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_567_568:
    // Closure for func_567
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_567
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_573
    tst x0, #1
    b.ne do_compose_571
do_apply_572:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_574
do_compose_571:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_574
do_concat_573:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_574:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_577
    tst x0, #1
    b.ne do_compose_575
do_apply_576:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_578
do_compose_575:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_578
do_concat_577:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_578:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_565_566:
    // Closure for func_565
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_565
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_579_580
func_579:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_579_580:
    // Closure for func_579
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_579
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_562
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_564
xor_true_562:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_563
    adr x0, sign_id
    b xor_end_564
xor_false_563:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_560_561:
    // Closure for func_560
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_560
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_558
    b after_func_581_582
func_581:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_583_584
func_583:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_588_589
func_588:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_590_591
func_590:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_592_593
func_592:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_592_593:
    // Closure for func_592
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_592
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_590_591:
    // Closure for func_590
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_590
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_596
    tst x0, #1
    b.ne do_compose_594
do_apply_595:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_597
do_compose_594:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_597
do_concat_596:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_597:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_600
    tst x0, #1
    b.ne do_compose_598
do_apply_599:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_601
do_compose_598:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_601
do_concat_600:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_601:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_588_589:
    // Closure for func_588
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_588
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_602_603
func_602:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_602_603:
    // Closure for func_602
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_602
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_585
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_587
xor_true_585:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_586
    adr x0, sign_id
    b xor_end_587
xor_false_586:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_583_584:
    // Closure for func_583
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_583
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_606
    tst x0, #1
    b.ne do_compose_604
do_apply_605:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_607
do_compose_604:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_607
do_concat_606:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_607:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_581_582:
    // Closure for func_581
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_581
    ldr x0, [sp], #16
    bl _cons
    b cond_end_559
cond_false_558:
    adr x0, sign_id
cond_end_559:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_610_611
func_610:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_615_616
func_615:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_617_618
func_617:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_619_620
func_619:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_619_620:
    // Closure for func_619
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_619
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_617_618:
    // Closure for func_617
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_617
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_623
    tst x0, #1
    b.ne do_compose_621
do_apply_622:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_624
do_compose_621:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_624
do_concat_623:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_624:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_627
    tst x0, #1
    b.ne do_compose_625
do_apply_626:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_628
do_compose_625:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_628
do_concat_627:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_628:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_615_616:
    // Closure for func_615
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_615
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_629_630
func_629:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_629_630:
    // Closure for func_629
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_629
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_612
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_614
xor_true_612:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_613
    adr x0, sign_id
    b xor_end_614
xor_false_613:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_610_611:
    // Closure for func_610
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_610
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_608
    b after_func_631_632
func_631:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_633_634
func_633:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_638_639
func_638:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_640_641
func_640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_642_643
func_642:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_642_643:
    // Closure for func_642
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_642
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_640_641:
    // Closure for func_640
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_640
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_646
    tst x0, #1
    b.ne do_compose_644
do_apply_645:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_647
do_compose_644:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_647
do_concat_646:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_647:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_650
    tst x0, #1
    b.ne do_compose_648
do_apply_649:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_651
do_compose_648:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_651
do_concat_650:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_651:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_638_639:
    // Closure for func_638
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_638
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_652_653
func_652:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_652_653:
    // Closure for func_652
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_652
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_635
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_637
xor_true_635:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_636
    adr x0, sign_id
    b xor_end_637
xor_false_636:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_633_634:
    // Closure for func_633
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_633
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_656
    tst x0, #1
    b.ne do_compose_654
do_apply_655:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_657
do_compose_654:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_657
do_concat_656:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_657:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_631_632:
    // Closure for func_631
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_631
    ldr x0, [sp], #16
    bl _cons
    b cond_end_609
cond_false_608:
    adr x0, sign_id
cond_end_609:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_660_661
func_660:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_665_666
func_665:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_667_668
func_667:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_669_670
func_669:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_671
    adr x0, sign_id
    b cmp_end_672
cmp_true_671:
cmp_end_672:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_669_670:
    // Closure for func_669
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_669
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_667_668:
    // Closure for func_667
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_667
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_675
    tst x0, #1
    b.ne do_compose_673
do_apply_674:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_676
do_compose_673:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_676
do_concat_675:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_676:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_679
    tst x0, #1
    b.ne do_compose_677
do_apply_678:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_680
do_compose_677:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_680
do_concat_679:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_680:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_665_666:
    // Closure for func_665
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_665
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_681_682
func_681:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_683
    adr x0, sign_id
    b cmp_end_684
cmp_true_683:
cmp_end_684:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_681_682:
    // Closure for func_681
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_681
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_662
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_664
xor_true_662:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_663
    adr x0, sign_id
    b xor_end_664
xor_false_663:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_660_661:
    // Closure for func_660
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_660
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_658
    b after_func_685_686
func_685:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_687_688
func_687:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_692_693
func_692:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_694_695
func_694:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_696_697
func_696:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_698
    adr x0, sign_id
    b cmp_end_699
cmp_true_698:
cmp_end_699:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_696_697:
    // Closure for func_696
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_696
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_694_695:
    // Closure for func_694
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_694
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_702
    tst x0, #1
    b.ne do_compose_700
do_apply_701:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_703
do_compose_700:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_703
do_concat_702:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_703:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_706
    tst x0, #1
    b.ne do_compose_704
do_apply_705:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_707
do_compose_704:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_707
do_concat_706:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_707:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_692_693:
    // Closure for func_692
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_692
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_708_709
func_708:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_710
    adr x0, sign_id
    b cmp_end_711
cmp_true_710:
cmp_end_711:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_708_709:
    // Closure for func_708
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_708
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_689
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_691
xor_true_689:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_690
    adr x0, sign_id
    b xor_end_691
xor_false_690:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_687_688:
    // Closure for func_687
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_687
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_714
    tst x0, #1
    b.ne do_compose_712
do_apply_713:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_715
do_compose_712:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_715
do_concat_714:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_715:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_685_686:
    // Closure for func_685
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_685
    ldr x0, [sp], #16
    bl _cons
    b cond_end_659
cond_false_658:
    adr x0, sign_id
cond_end_659:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_718_719
func_718:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_723_724
func_723:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_725_726
func_725:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_727_728
func_727:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_729
    adr x0, sign_id
    b cmp_end_730
cmp_true_729:
cmp_end_730:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_727_728:
    // Closure for func_727
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_727
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_725_726:
    // Closure for func_725
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_725
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_733
    tst x0, #1
    b.ne do_compose_731
do_apply_732:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_734
do_compose_731:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_734
do_concat_733:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_734:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_737
    tst x0, #1
    b.ne do_compose_735
do_apply_736:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_738
do_compose_735:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_738
do_concat_737:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_738:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_723_724:
    // Closure for func_723
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_723
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_739_740
func_739:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_741
    adr x0, sign_id
    b cmp_end_742
cmp_true_741:
cmp_end_742:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_739_740:
    // Closure for func_739
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_739
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_720
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_722
xor_true_720:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_721
    adr x0, sign_id
    b xor_end_722
xor_false_721:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_718_719:
    // Closure for func_718
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_718
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_716
    b after_func_743_744
func_743:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_745_746
func_745:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_750_751
func_750:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_752_753
func_752:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_754_755
func_754:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_756
    adr x0, sign_id
    b cmp_end_757
cmp_true_756:
cmp_end_757:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_754_755:
    // Closure for func_754
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_754
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_752_753:
    // Closure for func_752
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_752
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_760
    tst x0, #1
    b.ne do_compose_758
do_apply_759:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_761
do_compose_758:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_761
do_concat_760:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_761:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_764
    tst x0, #1
    b.ne do_compose_762
do_apply_763:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_765
do_compose_762:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_765
do_concat_764:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_765:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_750_751:
    // Closure for func_750
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_750
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_766_767
func_766:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_768
    adr x0, sign_id
    b cmp_end_769
cmp_true_768:
cmp_end_769:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_766_767:
    // Closure for func_766
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_766
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_747
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_749
xor_true_747:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_748
    adr x0, sign_id
    b xor_end_749
xor_false_748:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_745_746:
    // Closure for func_745
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_745
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_772
    tst x0, #1
    b.ne do_compose_770
do_apply_771:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_773
do_compose_770:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_773
do_concat_772:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_773:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_743_744:
    // Closure for func_743
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_743
    ldr x0, [sp], #16
    bl _cons
    b cond_end_717
cond_false_716:
    adr x0, sign_id
cond_end_717:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_776_777
func_776:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_781_782
func_781:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_783_784
func_783:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_785_786
func_785:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_787
    adr x0, sign_id
    b cmp_end_788
cmp_true_787:
cmp_end_788:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_785_786:
    // Closure for func_785
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_785
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_783_784:
    // Closure for func_783
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_783
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_791
    tst x0, #1
    b.ne do_compose_789
do_apply_790:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_792
do_compose_789:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_792
do_concat_791:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_792:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_795
    tst x0, #1
    b.ne do_compose_793
do_apply_794:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_796
do_compose_793:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_796
do_concat_795:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_796:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_781_782:
    // Closure for func_781
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_781
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_797_798
func_797:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_799
    adr x0, sign_id
    b cmp_end_800
cmp_true_799:
cmp_end_800:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_797_798:
    // Closure for func_797
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_797
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_778
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_780
xor_true_778:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_779
    adr x0, sign_id
    b xor_end_780
xor_false_779:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_776_777:
    // Closure for func_776
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_776
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_774
    b after_func_801_802
func_801:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_803_804
func_803:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_808_809
func_808:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_810_811
func_810:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_812_813
func_812:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_814
    adr x0, sign_id
    b cmp_end_815
cmp_true_814:
cmp_end_815:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_812_813:
    // Closure for func_812
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_812
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_810_811:
    // Closure for func_810
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_810
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_818
    tst x0, #1
    b.ne do_compose_816
do_apply_817:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_819
do_compose_816:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_819
do_concat_818:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_819:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_822
    tst x0, #1
    b.ne do_compose_820
do_apply_821:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_823
do_compose_820:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_823
do_concat_822:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_823:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_808_809:
    // Closure for func_808
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_808
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_824_825
func_824:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_826
    adr x0, sign_id
    b cmp_end_827
cmp_true_826:
cmp_end_827:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_824_825:
    // Closure for func_824
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_824
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_805
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_807
xor_true_805:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_806
    adr x0, sign_id
    b xor_end_807
xor_false_806:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_803_804:
    // Closure for func_803
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_803
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_830
    tst x0, #1
    b.ne do_compose_828
do_apply_829:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_831
do_compose_828:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_831
do_concat_830:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_831:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_801_802:
    // Closure for func_801
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_801
    ldr x0, [sp], #16
    bl _cons
    b cond_end_775
cond_false_774:
    adr x0, sign_id
cond_end_775:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_834_835
func_834:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_839_840
func_839:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_841_842
func_841:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_843_844
func_843:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_845
    adr x0, sign_id
    b cmp_end_846
cmp_true_845:
cmp_end_846:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_843_844:
    // Closure for func_843
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_843
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_841_842:
    // Closure for func_841
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_841
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_849
    tst x0, #1
    b.ne do_compose_847
do_apply_848:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_850
do_compose_847:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_850
do_concat_849:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_850:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_853
    tst x0, #1
    b.ne do_compose_851
do_apply_852:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_854
do_compose_851:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_854
do_concat_853:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_854:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_839_840:
    // Closure for func_839
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_839
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_855_856
func_855:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_857
    adr x0, sign_id
    b cmp_end_858
cmp_true_857:
cmp_end_858:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_855_856:
    // Closure for func_855
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_855
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_836
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_838
xor_true_836:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_837
    adr x0, sign_id
    b xor_end_838
xor_false_837:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_834_835:
    // Closure for func_834
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_834
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_832
    b after_func_859_860
func_859:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_861_862
func_861:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_866_867
func_866:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_868_869
func_868:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_870_871
func_870:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_872
    adr x0, sign_id
    b cmp_end_873
cmp_true_872:
cmp_end_873:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_870_871:
    // Closure for func_870
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_870
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_868_869:
    // Closure for func_868
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_868
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_876
    tst x0, #1
    b.ne do_compose_874
do_apply_875:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_877
do_compose_874:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_877
do_concat_876:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_877:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_880
    tst x0, #1
    b.ne do_compose_878
do_apply_879:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_881
do_compose_878:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_881
do_concat_880:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_881:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_866_867:
    // Closure for func_866
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_866
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_882_883
func_882:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_884
    adr x0, sign_id
    b cmp_end_885
cmp_true_884:
cmp_end_885:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_882_883:
    // Closure for func_882
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_882
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_863
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_865
xor_true_863:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_864
    adr x0, sign_id
    b xor_end_865
xor_false_864:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_861_862:
    // Closure for func_861
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_861
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_888
    tst x0, #1
    b.ne do_compose_886
do_apply_887:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_889
do_compose_886:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_889
do_concat_888:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_889:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_859_860:
    // Closure for func_859
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_859
    ldr x0, [sp], #16
    bl _cons
    b cond_end_833
cond_false_832:
    adr x0, sign_id
cond_end_833:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_892_893
func_892:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_897_898
func_897:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_899_900
func_899:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_901_902
func_901:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_903
    adr x0, sign_id
    b cmp_end_904
cmp_true_903:
cmp_end_904:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_901_902:
    // Closure for func_901
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_901
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_899_900:
    // Closure for func_899
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_899
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_907
    tst x0, #1
    b.ne do_compose_905
do_apply_906:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_908
do_compose_905:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_908
do_concat_907:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_908:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_911
    tst x0, #1
    b.ne do_compose_909
do_apply_910:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_912
do_compose_909:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_912
do_concat_911:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_912:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_897_898:
    // Closure for func_897
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_897
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_913_914
func_913:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_915
    adr x0, sign_id
    b cmp_end_916
cmp_true_915:
cmp_end_916:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_913_914:
    // Closure for func_913
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_913
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_894
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_896
xor_true_894:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_895
    adr x0, sign_id
    b xor_end_896
xor_false_895:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_892_893:
    // Closure for func_892
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_892
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_890
    b after_func_917_918
func_917:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_919_920
func_919:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_924_925
func_924:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_926_927
func_926:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_928_929
func_928:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_930
    adr x0, sign_id
    b cmp_end_931
cmp_true_930:
cmp_end_931:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_928_929:
    // Closure for func_928
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_928
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_926_927:
    // Closure for func_926
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_926
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_934
    tst x0, #1
    b.ne do_compose_932
do_apply_933:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_935
do_compose_932:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_935
do_concat_934:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_935:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_938
    tst x0, #1
    b.ne do_compose_936
do_apply_937:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_939
do_compose_936:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_939
do_concat_938:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_939:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_924_925:
    // Closure for func_924
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_924
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_940_941
func_940:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_942
    adr x0, sign_id
    b cmp_end_943
cmp_true_942:
cmp_end_943:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_940_941:
    // Closure for func_940
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_940
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_921
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_923
xor_true_921:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_922
    adr x0, sign_id
    b xor_end_923
xor_false_922:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_919_920:
    // Closure for func_919
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_919
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_946
    tst x0, #1
    b.ne do_compose_944
do_apply_945:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_947
do_compose_944:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_947
do_concat_946:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_947:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_917_918:
    // Closure for func_917
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_917
    ldr x0, [sp], #16
    bl _cons
    b cond_end_891
cond_false_890:
    adr x0, sign_id
cond_end_891:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_950_951
func_950:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_955_956
func_955:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_957_958
func_957:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_959_960
func_959:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_959_960:
    // Closure for func_959
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_959
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_957_958:
    // Closure for func_957
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_957
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_963
    tst x0, #1
    b.ne do_compose_961
do_apply_962:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_964
do_compose_961:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_964
do_concat_963:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_964:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_967
    tst x0, #1
    b.ne do_compose_965
do_apply_966:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_968
do_compose_965:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_968
do_concat_967:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_968:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_955_956:
    // Closure for func_955
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_955
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_969_970
func_969:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_969_970:
    // Closure for func_969
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_969
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_952
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_954
xor_true_952:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_953
    adr x0, sign_id
    b xor_end_954
xor_false_953:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_950_951:
    // Closure for func_950
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_950
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_948
    b after_func_971_972
func_971:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_973_974
func_973:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_978_979
func_978:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_980_981
func_980:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_982_983
func_982:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_982_983:
    // Closure for func_982
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_982
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_980_981:
    // Closure for func_980
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_980
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_986
    tst x0, #1
    b.ne do_compose_984
do_apply_985:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_987
do_compose_984:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_987
do_concat_986:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_987:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_990
    tst x0, #1
    b.ne do_compose_988
do_apply_989:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_991
do_compose_988:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_991
do_concat_990:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_991:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_978_979:
    // Closure for func_978
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_978
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_992_993
func_992:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_992_993:
    // Closure for func_992
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_992
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_975
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_977
xor_true_975:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_976
    adr x0, sign_id
    b xor_end_977
xor_false_976:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_973_974:
    // Closure for func_973
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_973
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_996
    tst x0, #1
    b.ne do_compose_994
do_apply_995:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_997
do_compose_994:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_997
do_concat_996:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_997:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_971_972:
    // Closure for func_971
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_971
    ldr x0, [sp], #16
    bl _cons
    b cond_end_949
cond_false_948:
    adr x0, sign_id
cond_end_949:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1000_1001
func_1000:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1005_1006
func_1005:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1007_1008
func_1007:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1009_1010
func_1009:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1011
    adr x0, sign_id
    b cmp_end_1012
cmp_true_1011:
cmp_end_1012:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1009_1010:
    // Closure for func_1009
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1009
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1007_1008:
    // Closure for func_1007
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1007
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1015
    tst x0, #1
    b.ne do_compose_1013
do_apply_1014:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1016
do_compose_1013:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1016
do_concat_1015:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1016:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1019
    tst x0, #1
    b.ne do_compose_1017
do_apply_1018:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1020
do_compose_1017:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1020
do_concat_1019:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1020:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1005_1006:
    // Closure for func_1005
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1005
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1021_1022
func_1021:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1023
    adr x0, sign_id
    b cmp_end_1024
cmp_true_1023:
cmp_end_1024:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1021_1022:
    // Closure for func_1021
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1021
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1002
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1004
xor_true_1002:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1003
    adr x0, sign_id
    b xor_end_1004
xor_false_1003:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1000_1001:
    // Closure for func_1000
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1000
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_998
    b after_func_1025_1026
func_1025:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_1027_1028
func_1027:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1032_1033
func_1032:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1034_1035
func_1034:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1036_1037
func_1036:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1038
    adr x0, sign_id
    b cmp_end_1039
cmp_true_1038:
cmp_end_1039:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1036_1037:
    // Closure for func_1036
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1036
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1034_1035:
    // Closure for func_1034
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1034
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1042
    tst x0, #1
    b.ne do_compose_1040
do_apply_1041:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1043
do_compose_1040:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1043
do_concat_1042:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1043:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1046
    tst x0, #1
    b.ne do_compose_1044
do_apply_1045:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1047
do_compose_1044:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1047
do_concat_1046:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1047:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1032_1033:
    // Closure for func_1032
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1032
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1048_1049
func_1048:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1050
    adr x0, sign_id
    b cmp_end_1051
cmp_true_1050:
cmp_end_1051:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1048_1049:
    // Closure for func_1048
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1048
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1029
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1031
xor_true_1029:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1030
    adr x0, sign_id
    b xor_end_1031
xor_false_1030:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1027_1028:
    // Closure for func_1027
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1027
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1054
    tst x0, #1
    b.ne do_compose_1052
do_apply_1053:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1055
do_compose_1052:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1055
do_concat_1054:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1055:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1025_1026:
    // Closure for func_1025
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1025
    ldr x0, [sp], #16
    bl _cons
    b cond_end_999
cond_false_998:
    adr x0, sign_id
cond_end_999:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.eq not_true_1058
    adr x0, sign_id
    b not_end_1059
not_true_1058:
    mov x0, #0
not_end_1059:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1056
    b after_func_1060_1061
func_1060:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq not_true_1062
    adr x0, sign_id
    b not_end_1063
not_true_1062:
    mov x0, #0
not_end_1063:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1060_1061:
    // Closure for func_1060
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1060
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1057
cond_false_1056:
    adr x0, sign_id
cond_end_1057:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mvn x0, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1064
    b after_func_1066_1067
func_1066:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mvn x0, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1066_1067:
    // Closure for func_1066
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1066
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1065
cond_false_1064:
    adr x0, sign_id
cond_end_1065:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1068_1069
func_1068:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1073_1074
func_1073:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1078_1079
func_1078:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1080_1081
func_1080:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1082_1083
func_1082:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    orr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1082_1083:
    // Closure for func_1082
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1082
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1080_1081:
    // Closure for func_1080
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1080
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1086
    tst x0, #1
    b.ne do_compose_1084
do_apply_1085:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1087
do_compose_1084:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1087
do_concat_1086:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1087:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1090
    tst x0, #1
    b.ne do_compose_1088
do_apply_1089:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1091
do_compose_1088:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1091
do_concat_1090:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1091:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1078_1079:
    // Closure for func_1078
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1078
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1092_1093
func_1092:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    orr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1092_1093:
    // Closure for func_1092
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1092
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1075
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1077
xor_true_1075:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1076
    adr x0, sign_id
    b xor_end_1077
xor_false_1076:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1073_1074:
    // Closure for func_1073
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1073
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1071
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1094
    b or_end_1095
or_right_1094:
    adr x0, x
or_end_1095:
    b cond_end_1072
cond_false_1071:
    adr x0, sign_id
cond_end_1072:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1070
    b after_func_1096_1097
func_1096:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    orr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1096_1097:
    // Closure for func_1096
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1096
    ldr x0, [sp], #16
    bl _cons
blk_end_1070:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1068_1069:
    // Closure for func_1068
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1068
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1098_1099
func_1098:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1103_1104
func_1103:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1108_1109
func_1108:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1110_1111
func_1110:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1112_1113
func_1112:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    and x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1112_1113:
    // Closure for func_1112
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1112
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1110_1111:
    // Closure for func_1110
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1110
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1116
    tst x0, #1
    b.ne do_compose_1114
do_apply_1115:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1117
do_compose_1114:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1117
do_concat_1116:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1117:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1120
    tst x0, #1
    b.ne do_compose_1118
do_apply_1119:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1121
do_compose_1118:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1121
do_concat_1120:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1121:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1108_1109:
    // Closure for func_1108
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1108
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1122_1123
func_1122:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    and x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1122_1123:
    // Closure for func_1122
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1122
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1105
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1107
xor_true_1105:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1106
    adr x0, sign_id
    b xor_end_1107
xor_false_1106:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1103_1104:
    // Closure for func_1103
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1103
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1101
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1124
    b or_end_1125
or_right_1124:
    adr x0, x
or_end_1125:
    b cond_end_1102
cond_false_1101:
    adr x0, sign_id
cond_end_1102:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1100
    b after_func_1126_1127
func_1126:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    and x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1126_1127:
    // Closure for func_1126
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1126
    ldr x0, [sp], #16
    bl _cons
blk_end_1100:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1098_1099:
    // Closure for func_1098
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1098
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1128_1129
func_1128:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1133_1134
func_1133:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1138_1139
func_1138:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1140_1141
func_1140:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ;
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1142
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1144
xor_true_1142:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1143
    adr x0, sign_id
    b xor_end_1144
xor_false_1143:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1140_1141:
    // Closure for func_1140
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1140
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1147
    tst x0, #1
    b.ne do_compose_1145
do_apply_1146:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1148
do_compose_1145:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1148
do_concat_1147:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1148:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1151
    tst x0, #1
    b.ne do_compose_1149
do_apply_1150:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1152
do_compose_1149:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1152
do_concat_1151:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1152:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1138_1139:
    // Closure for func_1138
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1138
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ;
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1153
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1155
xor_true_1153:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1154
    adr x0, sign_id
    b xor_end_1155
xor_false_1154:
    mov x0, x1
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1135
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1137
xor_true_1135:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1136
    adr x0, sign_id
    b xor_end_1137
xor_false_1136:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1133_1134:
    // Closure for func_1133
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1133
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1131
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1156
    b or_end_1157
or_right_1156:
    adr x0, x
or_end_1157:
    b cond_end_1132
cond_false_1131:
    adr x0, sign_id
cond_end_1132:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1130
    b after_func_1158_1159
func_1158:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, ;
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1160
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1162
xor_true_1160:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1161
    adr x0, sign_id
    b xor_end_1162
xor_false_1161:
    mov x0, x1
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1165
    tst x0, #1
    b.ne do_compose_1163
do_apply_1164:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1166
do_compose_1163:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1166
do_concat_1165:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1166:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1158_1159:
    // Closure for func_1158
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1158
    ldr x0, [sp], #16
    bl _cons
blk_end_1130:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1128_1129:
    // Closure for func_1128
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1128
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1167_1168
func_1167:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1172_1173
func_1172:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1177_1178
func_1177:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1179_1180
func_1179:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1181_1182
func_1181:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    lsl x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1181_1182:
    // Closure for func_1181
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1181
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1179_1180:
    // Closure for func_1179
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1179
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1185
    tst x0, #1
    b.ne do_compose_1183
do_apply_1184:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1186
do_compose_1183:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1186
do_concat_1185:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1186:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1189
    tst x0, #1
    b.ne do_compose_1187
do_apply_1188:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1190
do_compose_1187:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1190
do_concat_1189:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1190:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1177_1178:
    // Closure for func_1177
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1177
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1191_1192
func_1191:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    lsl x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1191_1192:
    // Closure for func_1191
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1191
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1174
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1176
xor_true_1174:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1175
    adr x0, sign_id
    b xor_end_1176
xor_false_1175:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1172_1173:
    // Closure for func_1172
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1172
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1170
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1193
    b or_end_1194
or_right_1193:
    adr x0, x
or_end_1194:
    b cond_end_1171
cond_false_1170:
    adr x0, sign_id
cond_end_1171:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1169
    b after_func_1195_1196
func_1195:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    lsl x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1195_1196:
    // Closure for func_1195
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1195
    ldr x0, [sp], #16
    bl _cons
blk_end_1169:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1167_1168:
    // Closure for func_1167
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1167
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1197_1198
func_1197:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1202_1203
func_1202:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1207_1208
func_1207:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1209_1210
func_1209:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1211_1212
func_1211:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    asr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1211_1212:
    // Closure for func_1211
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1211
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1209_1210:
    // Closure for func_1209
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1209
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1215
    tst x0, #1
    b.ne do_compose_1213
do_apply_1214:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1216
do_compose_1213:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1216
do_concat_1215:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1216:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1219
    tst x0, #1
    b.ne do_compose_1217
do_apply_1218:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1220
do_compose_1217:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1220
do_concat_1219:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1220:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1207_1208:
    // Closure for func_1207
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1207
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1221_1222
func_1221:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    asr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1221_1222:
    // Closure for func_1221
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1221
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1204
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1206
xor_true_1204:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1205
    adr x0, sign_id
    b xor_end_1206
xor_false_1205:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1202_1203:
    // Closure for func_1202
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1202
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1200
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1223
    b or_end_1224
or_right_1223:
    adr x0, x
or_end_1224:
    b cond_end_1201
cond_false_1200:
    adr x0, sign_id
cond_end_1201:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    b after_func_1225_1226
func_1225:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    asr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1225_1226:
    // Closure for func_1225
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1225
    ldr x0, [sp], #16
    bl _cons
blk_end_1199:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1197_1198:
    // Closure for func_1197
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1197
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1227_1228
func_1227:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1232_1233
func_1232:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1237_1238
func_1237:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1239_1240
func_1239:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1241_1242
func_1241:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1241_1242:
    // Closure for func_1241
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1241
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1239_1240:
    // Closure for func_1239
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1239
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1245
    tst x0, #1
    b.ne do_compose_1243
do_apply_1244:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1246
do_compose_1243:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1246
do_concat_1245:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1246:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1249
    tst x0, #1
    b.ne do_compose_1247
do_apply_1248:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1250
do_compose_1247:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1250
do_concat_1249:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1250:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1237_1238:
    // Closure for func_1237
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1237
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1251_1252
func_1251:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1251_1252:
    // Closure for func_1251
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1251
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1234
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1236
xor_true_1234:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1235
    adr x0, sign_id
    b xor_end_1236
xor_false_1235:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1232_1233:
    // Closure for func_1232
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1232
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1230
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1253
    b or_end_1254
or_right_1253:
    adr x0, s
or_end_1254:
    b cond_end_1231
cond_false_1230:
    adr x0, sign_id
cond_end_1231:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1229
    b after_func_1255_1256
func_1255:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1255_1256:
    // Closure for func_1255
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1255
    ldr x0, [sp], #16
    bl _cons
blk_end_1229:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1227_1228:
    // Closure for func_1227
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1227
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1259_1260
func_1259:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1264_1265
func_1264:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1266_1267
func_1266:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1266_1267:
    // Closure for func_1266
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1266
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1270
    tst x0, #1
    b.ne do_compose_1268
do_apply_1269:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1271
do_compose_1268:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1271
do_concat_1270:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1271:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1274
    tst x0, #1
    b.ne do_compose_1272
do_apply_1273:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1275
do_compose_1272:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1275
do_concat_1274:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1275:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1264_1265:
    // Closure for func_1264
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1264
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1261
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1263
xor_true_1261:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1262
    adr x0, sign_id
    b xor_end_1263
xor_false_1262:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1259_1260:
    // Closure for func_1259
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1259
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1257
    b after_func_1276_1277
func_1276:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1276_1277:
    // Closure for func_1276
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1276
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1258
cond_false_1257:
    adr x0, sign_id
cond_end_1258:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1280_1281
func_1280:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1285_1286
func_1285:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1287_1288
func_1287:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1287_1288:
    // Closure for func_1287
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1287
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1291
    tst x0, #1
    b.ne do_compose_1289
do_apply_1290:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1292
do_compose_1289:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1292
do_concat_1291:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1292:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1295
    tst x0, #1
    b.ne do_compose_1293
do_apply_1294:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1296
do_compose_1293:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1296
do_concat_1295:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1296:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1285_1286:
    // Closure for func_1285
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1285
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _range
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1282
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1284
xor_true_1282:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1283
    adr x0, sign_id
    b xor_end_1284
xor_false_1283:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1280_1281:
    // Closure for func_1280
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1280
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1278
    b after_func_1297_1298
func_1297:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1297_1298:
    // Closure for func_1297
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1297
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1279
cond_false_1278:
    adr x0, sign_id
cond_end_1279:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1299_1300
func_1299:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1304_1305
func_1304:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1309_1310
func_1309:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1311_1312
func_1311:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1313_1314
func_1313:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1313_1314:
    // Closure for func_1313
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1313
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1311_1312:
    // Closure for func_1311
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1311
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1317
    tst x0, #1
    b.ne do_compose_1315
do_apply_1316:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1318
do_compose_1315:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1318
do_concat_1317:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1318:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1321
    tst x0, #1
    b.ne do_compose_1319
do_apply_1320:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1322
do_compose_1319:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1322
do_concat_1321:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1322:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1309_1310:
    // Closure for func_1309
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1309
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1323_1324
func_1323:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1323_1324:
    // Closure for func_1323
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1323
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1306
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1308
xor_true_1306:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1307
    adr x0, sign_id
    b xor_end_1308
xor_false_1307:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1304_1305:
    // Closure for func_1304
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1304
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1302
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1325
    b or_end_1326
or_right_1325:
    adr x0, s
or_end_1326:
    b cond_end_1303
cond_false_1302:
    adr x0, sign_id
cond_end_1303:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1301
    b after_func_1327_1328
func_1327:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1327_1328:
    // Closure for func_1327
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1327
    ldr x0, [sp], #16
    bl _cons
blk_end_1301:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1299_1300:
    // Closure for func_1299
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1299
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1329_1330
func_1329:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1334_1335
func_1334:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1339_1340
func_1339:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1341_1342
func_1341:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1343_1344
func_1343:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1343_1344:
    // Closure for func_1343
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1343
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1341_1342:
    // Closure for func_1341
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1341
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1347
    tst x0, #1
    b.ne do_compose_1345
do_apply_1346:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1348
do_compose_1345:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1348
do_concat_1347:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1348:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1351
    tst x0, #1
    b.ne do_compose_1349
do_apply_1350:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1352
do_compose_1349:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1352
do_concat_1351:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1352:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1339_1340:
    // Closure for func_1339
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1339
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1353_1354
func_1353:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1353_1354:
    // Closure for func_1353
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1353
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1336
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1338
xor_true_1336:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1337
    adr x0, sign_id
    b xor_end_1338
xor_false_1337:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1334_1335:
    // Closure for func_1334
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1334
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1332
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1355
    b or_end_1356
or_right_1355:
    adr x0, s
or_end_1356:
    b cond_end_1333
cond_false_1332:
    adr x0, sign_id
cond_end_1333:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1331
    b after_func_1357_1358
func_1357:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1357_1358:
    // Closure for func_1357
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1357
    ldr x0, [sp], #16
    bl _cons
blk_end_1331:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1329_1330:
    // Closure for func_1329
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1329
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1359_1360
func_1359:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1364_1365
func_1364:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1369_1370
func_1369:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1371_1372
func_1371:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1373_1374
func_1373:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1373_1374:
    // Closure for func_1373
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1373
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1371_1372:
    // Closure for func_1371
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1371
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1377
    tst x0, #1
    b.ne do_compose_1375
do_apply_1376:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1378
do_compose_1375:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1378
do_concat_1377:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1378:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1381
    tst x0, #1
    b.ne do_compose_1379
do_apply_1380:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1382
do_compose_1379:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1382
do_concat_1381:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1382:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1369_1370:
    // Closure for func_1369
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1369
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1383_1384
func_1383:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1383_1384:
    // Closure for func_1383
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1383
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1366
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1368
xor_true_1366:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1367
    adr x0, sign_id
    b xor_end_1368
xor_false_1367:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1364_1365:
    // Closure for func_1364
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1364
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1362
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1385
    b or_end_1386
or_right_1385:
    adr x0, s
or_end_1386:
    b cond_end_1363
cond_false_1362:
    adr x0, sign_id
cond_end_1363:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1361
    b after_func_1387_1388
func_1387:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1387_1388:
    // Closure for func_1387
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1387
    ldr x0, [sp], #16
    bl _cons
blk_end_1361:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1359_1360:
    // Closure for func_1359
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1359
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1389_1390
func_1389:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1394_1395
func_1394:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1399_1400
func_1399:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1401_1402
func_1401:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1403_1404
func_1403:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1403_1404:
    // Closure for func_1403
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1403
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1401_1402:
    // Closure for func_1401
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1401
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1407
    tst x0, #1
    b.ne do_compose_1405
do_apply_1406:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1408
do_compose_1405:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1408
do_concat_1407:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1408:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1411
    tst x0, #1
    b.ne do_compose_1409
do_apply_1410:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1412
do_compose_1409:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1412
do_concat_1411:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1412:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1399_1400:
    // Closure for func_1399
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1399
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1413_1414
func_1413:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1413_1414:
    // Closure for func_1413
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1413
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1396
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1398
xor_true_1396:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1397
    adr x0, sign_id
    b xor_end_1398
xor_false_1397:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1394_1395:
    // Closure for func_1394
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1394
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1392
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1415
    b or_end_1416
or_right_1415:
    adr x0, s
or_end_1416:
    b cond_end_1393
cond_false_1392:
    adr x0, sign_id
cond_end_1393:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1391
    b after_func_1417_1418
func_1417:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1417_1418:
    // Closure for func_1417
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1417
    ldr x0, [sp], #16
    bl _cons
blk_end_1391:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1389_1390:
    // Closure for func_1389
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1389
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1419_1420
func_1419:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1424_1425
func_1424:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1429_1430
func_1429:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1431_1432
func_1431:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1433_1434
func_1433:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1433_1434:
    // Closure for func_1433
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1433
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1431_1432:
    // Closure for func_1431
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1431
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1437
    tst x0, #1
    b.ne do_compose_1435
do_apply_1436:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1438
do_compose_1435:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1438
do_concat_1437:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1438:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1441
    tst x0, #1
    b.ne do_compose_1439
do_apply_1440:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1442
do_compose_1439:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1442
do_concat_1441:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1442:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1429_1430:
    // Closure for func_1429
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1429
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1443_1444
func_1443:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1443_1444:
    // Closure for func_1443
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1443
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1426
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1428
xor_true_1426:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1427
    adr x0, sign_id
    b xor_end_1428
xor_false_1427:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1424_1425:
    // Closure for func_1424
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1424
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1422
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1445
    b or_end_1446
or_right_1445:
    adr x0, s
or_end_1446:
    b cond_end_1423
cond_false_1422:
    adr x0, sign_id
cond_end_1423:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1421
    b after_func_1447_1448
func_1447:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1447_1448:
    // Closure for func_1447
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1447
    ldr x0, [sp], #16
    bl _cons
blk_end_1421:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1419_1420:
    // Closure for func_1419
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1419
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1449_1450
func_1449:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1454_1455
func_1454:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1459_1460
func_1459:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1461_1462
func_1461:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1463_1464
func_1463:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1463_1464:
    // Closure for func_1463
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1463
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1461_1462:
    // Closure for func_1461
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1461
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1467
    tst x0, #1
    b.ne do_compose_1465
do_apply_1466:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1468
do_compose_1465:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1468
do_concat_1467:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1468:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1471
    tst x0, #1
    b.ne do_compose_1469
do_apply_1470:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1472
do_compose_1469:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1472
do_concat_1471:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1472:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1459_1460:
    // Closure for func_1459
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1459
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1473_1474
func_1473:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1473_1474:
    // Closure for func_1473
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1473
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1456
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1458
xor_true_1456:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1457
    adr x0, sign_id
    b xor_end_1458
xor_false_1457:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1454_1455:
    // Closure for func_1454
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1454
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1452
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1475
    b or_end_1476
or_right_1475:
    adr x0, x
or_end_1476:
    b cond_end_1453
cond_false_1452:
    adr x0, sign_id
cond_end_1453:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1451
    b after_func_1477_1478
func_1477:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1477_1478:
    // Closure for func_1477
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1477
    ldr x0, [sp], #16
    bl _cons
blk_end_1451:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1449_1450:
    // Closure for func_1449
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1449
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1479_1480
func_1479:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1484_1485
func_1484:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1489_1490
func_1489:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1491_1492
func_1491:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1493_1494
func_1493:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1493_1494:
    // Closure for func_1493
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1493
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1491_1492:
    // Closure for func_1491
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1491
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1497
    tst x0, #1
    b.ne do_compose_1495
do_apply_1496:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1498
do_compose_1495:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1498
do_concat_1497:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1498:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1501
    tst x0, #1
    b.ne do_compose_1499
do_apply_1500:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1502
do_compose_1499:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1502
do_concat_1501:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1502:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1489_1490:
    // Closure for func_1489
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1489
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1503_1504
func_1503:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1503_1504:
    // Closure for func_1503
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1503
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1486
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1488
xor_true_1486:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1487
    adr x0, sign_id
    b xor_end_1488
xor_false_1487:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1484_1485:
    // Closure for func_1484
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1484
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1482
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1505
    b or_end_1506
or_right_1505:
    adr x0, obj
or_end_1506:
    b cond_end_1483
cond_false_1482:
    adr x0, sign_id
cond_end_1483:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1481
    b after_func_1507_1508
func_1507:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, obj
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1507_1508:
    // Closure for func_1507
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1507
    ldr x0, [sp], #16
    bl _cons
blk_end_1481:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1479_1480:
    // Closure for func_1479
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1479
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1509_1510
func_1509:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1514_1515
func_1514:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1519_1520
func_1519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1521_1522
func_1521:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1523_1524
func_1523:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1523_1524:
    // Closure for func_1523
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1523
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1521_1522:
    // Closure for func_1521
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1521
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1527
    tst x0, #1
    b.ne do_compose_1525
do_apply_1526:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1528
do_compose_1525:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1528
do_concat_1527:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1528:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1531
    tst x0, #1
    b.ne do_compose_1529
do_apply_1530:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1532
do_compose_1529:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1532
do_concat_1531:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1532:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1519_1520:
    // Closure for func_1519
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1519
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1533_1534
func_1533:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1533_1534:
    // Closure for func_1533
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1533
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1516
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1518
xor_true_1516:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1517
    adr x0, sign_id
    b xor_end_1518
xor_false_1517:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1514_1515:
    // Closure for func_1514
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1514
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1512
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1535
    b or_end_1536
or_right_1535:
    adr x0, obj
or_end_1536:
    b cond_end_1513
cond_false_1512:
    adr x0, sign_id
cond_end_1513:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1511
    b after_func_1537_1538
func_1537:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, obj
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1537_1538:
    // Closure for func_1537
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1537
    ldr x0, [sp], #16
    bl _cons
blk_end_1511:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1509_1510:
    // Closure for func_1509
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1509
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1541_1542
func_1541:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1546_1547
func_1546:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1548_1549
func_1548:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1548_1549:
    // Closure for func_1548
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1548
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1552
    tst x0, #1
    b.ne do_compose_1550
do_apply_1551:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1553
do_compose_1550:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1553
do_concat_1552:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1553:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1556
    tst x0, #1
    b.ne do_compose_1554
do_apply_1555:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1557
do_compose_1554:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1557
do_concat_1556:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1557:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1546_1547:
    // Closure for func_1546
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1546
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1543
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1545
xor_true_1543:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1544
    adr x0, sign_id
    b xor_end_1545
xor_false_1544:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1541_1542:
    // Closure for func_1541
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1541
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1539
    b after_func_1558_1559
func_1558:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1558_1559:
    // Closure for func_1558
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1558
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1540
cond_false_1539:
    adr x0, sign_id
cond_end_1540:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1562_1563
func_1562:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1567_1568
func_1567:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1569_1570
func_1569:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1569_1570:
    // Closure for func_1569
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1569
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1573
    tst x0, #1
    b.ne do_compose_1571
do_apply_1572:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1574
do_compose_1571:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1574
do_concat_1573:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1574:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1577
    tst x0, #1
    b.ne do_compose_1575
do_apply_1576:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1578
do_compose_1575:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1578
do_concat_1577:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1578:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1567_1568:
    // Closure for func_1567
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1567
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1564
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1566
xor_true_1564:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1565
    adr x0, sign_id
    b xor_end_1566
xor_false_1565:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1562_1563:
    // Closure for func_1562
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1562
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1560
    b after_func_1579_1580
func_1579:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1579_1580:
    // Closure for func_1579
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1579
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1561
cond_false_1560:
    adr x0, sign_id
cond_end_1561:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    adr x0, _
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1581
    b after_func_1583_1584
func_1583:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    add x0, x29, #-32
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1583_1584:
    // Closure for func_1583
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1583
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1582
cond_false_1581:
    adr x0, sign_id
cond_end_1582:
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_1585_1586
func_1585:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1590_1591
func_1590:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1595_1596
func_1595:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1597_1598
func_1597:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1599_1600
func_1599:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1599_1600:
    // Closure for func_1599
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1599
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1597_1598:
    // Closure for func_1597
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1597
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1603
    tst x0, #1
    b.ne do_compose_1601
do_apply_1602:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1604
do_compose_1601:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1604
do_concat_1603:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1604:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1607
    tst x0, #1
    b.ne do_compose_1605
do_apply_1606:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1608
do_compose_1605:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1608
do_concat_1607:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1608:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1595_1596:
    // Closure for func_1595
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1595
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1609_1610
func_1609:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1609_1610:
    // Closure for func_1609
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1609
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1592
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1594
xor_true_1592:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1593
    adr x0, sign_id
    b xor_end_1594
xor_false_1593:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1590_1591:
    // Closure for func_1590
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1590
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1588
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1611
    b or_end_1612
or_right_1611:
    adr x0, addr
or_end_1612:
    b cond_end_1589
cond_false_1588:
    adr x0, sign_id
cond_end_1589:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1587
    b after_func_1613_1614
func_1613:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, addr
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1613_1614:
    // Closure for func_1613
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1613
    ldr x0, [sp], #16
    bl _cons
blk_end_1587:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1585_1586:
    // Closure for func_1585
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1585
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    adr x0, val
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Array
    str x0, [sp, #-16]!
    adr x0, test
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1617
    tst x0, #1
    b.ne do_compose_1615
do_apply_1616:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1618
do_compose_1615:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1618
do_concat_1617:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1618:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, a
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, a
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1621
    tst x0, #1
    b.ne do_compose_1619
do_apply_1620:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1622
do_compose_1619:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1622
do_concat_1621:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1622:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, b
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1625
    tst x0, #1
    b.ne do_compose_1623
do_apply_1624:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1626
do_compose_1623:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1626
do_concat_1625:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1626:
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1629
    tst x0, #1
    b.ne do_compose_1627
do_apply_1628:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1630
do_compose_1627:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1630
do_concat_1629:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1630:
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, b
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1633
    tst x0, #1
    b.ne do_compose_1631
do_apply_1632:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1634
do_compose_1631:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1634
do_concat_1633:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1634:
    ldr x1, [sp], #16
    str x0, [x1]
blk_end_0:



    ldp x29, x30, [sp], #16
    ret

// --- Runtime Helpers for Composition ---

// _is_func: x0 -> x0 (1 if func, 0 if not)
// Simple heuristic: If > 4096, it's a pointer (Func). Else Number.
// (Very naive, needs tagging later)
_is_func:
    cmp x0, #4096
    b.hi .L_is_func_true
    mov x0, #0
    ret
.L_is_func_true:
    mov x0, #1
    ret

// _compose: x0=f, x1=g -> Returns Closure h(x) = g(f(x))
// Creates a closure that captures f and g.
// The code for h is _composed_impl.
_compose:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Save f(x0) and g(x1) to stack to build closure
    str x0, [sp, #-16]! // f
    str x1, [sp, #-16]! // g
    
    // Create Env list: [g, f] (cons g (cons f sign_id)) ?
    // Environment for _composed_impl needs f and g.
    // Env: [g, [f, sign_id]]
    
    adr x0, sign_id
    str x0, [sp, #-16]! // nil
    
    ldr x0, [x29, #-16] // Load f
    ldr x1, [sp], #16   // Pop nil
    bl _cons            // x0 = [f, nil]
    str x0, [sp, #-16]! // Push env
    
    ldr x0, [x29, #-32] // Load g
    ldr x1, [sp], #16   // Pop env
    bl _cons            // x0 = [g, [f, nil]]
    
    // Create Closure: [_composed_impl, Env]
    str x0, [sp, #-16]! // Env
    adr x0, _composed_impl
    ldr x1, [sp], #16   // Env
    bl _cons            // Closure
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _composed_impl: x0=Arg. Env=[g, [f, nil]]
// Logic: g( f(Arg) )
_composed_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Save Arg
    str x0, [sp, #-16]!
    
    str x9, [sp, #-16]! // Save Env to Stack (local var 1)
    
    // 1. Call f(Arg)
    // We need f.
    // Env -> [g, rest]. rest -> [f, nil].
    ldr x10, [x9, #8] // rest = [f, nil]
    ldr x10, [x10]    // f (Closure)
    str x10, [sp, #-16]! // Save f
    
    // Prepare Call to f
    // x0 is Arg (already in x0)
    // closure in x10
    // Unpack f
    mov x9, x10
    ldr x10, [x9]     // Code
    ldr x9, [x9, #8]  // f's Env
    blr x10           // Call f(Arg) -> returns result in x0
    
    // 2. Call g(Result)
    // Result is in x0.
    // Load g from saved Env (at [sp, #16])
    ldr x9, [sp, #16] // Reload 'Env' (which was saved at start)
    
    // Reload Env
    ldr x11, [sp, #16] // Env
    ldr x10, [x11]     // g (Closure)
    
    // Unpack g
    mov x9, x10
    ldr x10, [x9]     // Code
    ldr x9, [x9, #8]  // g's Env
    blr x10           // Call g(f(Arg)) -> returns result
    
    // Clean up stack
    add sp, sp, #32 // Pop f, Env.
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _pow: x0 (base), x1 (exp) -> x0 (result)
_pow:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    // Check if exp < 0 (Return 0 for integer pow?)
    cmp x1, #0
    b.lt .L_pow_zero 
    mov x2, #1        // result = 1
    mov x3, x0        // base
    mov x4, x1        // exp

.L_pow_loop:
    cbz x4, .L_pow_done
    tst x4, #1
    b.eq .L_pow_square
    mul x2, x2, x3
.L_pow_square:
    lsr x4, x4, #1
    mul x3, x3, x3
    b .L_pow_loop

.L_pow_zero:
    mov x2, #0
.L_pow_done:
    mov x0, x2
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _print_int: x0 = integer
// Prints integer to stdout
_print_int:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Handle 0 explicitly
    cmp x0, #0
    b.ne .L_print_int_not_zero
    
    // Print "0"
    mov x0, #1 // stdout
    adr x1, .L_str_zero
    mov x2, #1 // len
    mov x8, #64 // write
    svc #0
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
    
.L_print_int_not_zero:
    // We need a buffer. Use stack.
    // Max 64-bit int is ~20 digits.
    sub sp, sp, #64         // Alloc 64 bytes
    mov x9, sp              // buffer start
    add x9, x9, #63         // buffer end
    strb wzr, [x9]          // null terminate? Not needed for write syscall if we know len.
    sub x9, x9, #1          // Move back
    
    mov x10, #10            // divisor
    mov x11, x0             // number
    
    // Loop
.L_print_int_loop:
    udiv x12, x11, x10      // q = n / 10
    msub x13, x12, x10, x11 // r = n - q * 10
    
    add w13, w13, #48       // '0'
    strb w13, [x9]
    sub x9, x9, #1
    
    mov x11, x12
    cbnz x11, .L_print_int_loop
    
    // Print
    add x1, x9, #1          // Start address
    
    // Length = (sp + 63) - (x9 + 1) + 1?
    // End is sp+63.
    // Start is x1.
    // Len = (sp+63) - x1.
    mov x2, sp
    add x2, x2, #63
    sub x2, x2, x1
    add x2, x2, #1          // Fix length? No.
    // If end=100, start=100. Len = 100-100+1 = 1.
    // Wait. sp+63 is the last written byte.
    // x1 is the first written byte.
    // Length is (last - first) + 1. Correct.
    
    mov x0, #1 // stdout
    mov x8, #64 // write
    svc #0
    
    add sp, sp, #64
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
    
.L_str_zero:
    .ascii "0"

.bss
heap_start: .quad 0
heap_end: .quad 0
heap_addr: .quad 0
alloc: .quad 0
head: .quad 0
tail: .quad 0
factorial: .quad 0
print_char: .quad 0
print_str: .quad 0
print_num: .quad 0
_print_num_rec: .quad 0
a: .quad 0
b: .quad 0


_sys_write:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    // fd is in x0
    // Create Closure [_sys_write_2, [fd, nil]]
    
    // 1. Env = [fd, nil]
    stp x0, x1, [sp, #-16]! // Save regs
    mov x1, x0 // Car = fd
    adr x0, sign_id // Cdr = nil
    // Swap for _cons(car=x0, cdr=x1)? No _cons(x0, x1) usually.
    // Let's assume _cons(head=x0, tail=x1)
    mov x2, x0 // nil
    mov x0, x1 // fd
    mov x1, x2 // nil
    bl _cons
    // x0 is Env
    
    // 2. Closure = [_sys_write_2, Env]
    mov x1, x0 // Env
    adr x0, _sys_write_2 // Code
    bl _cons
    
    ldp x0, x1, [sp], #16 // Restore (garbage)
    ldp x29, x30, [sp], #16
    ret

_sys_write_2:
    // x0 = buf
    // Env = [fd, nil]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // New Env needs to capture buf AND fd.
    // Current Env (in x9 usually? No, apply passes Code in x10, Env in x9)
    // We need to fetch fd from Old Env.
    // Old Env = [fd, nil]
    // Car(OldEnv) = fd.
    
    stp x0, x9, [sp, #-16]! // Save buf, OldEnv
    
    ldr x1, [x9] // Load fd from OldEnv (Car)
    // We want NewEnv = [len?, [buf, [fd, nil]]] ? 
    // No, we are building up.
    // Result of this function is Closure [_sys_write_3, [buf, fd]]
    
    // Let's make Env = [buf, fd] (simplified list)
    // x0 combined with fd.
    
    // x0 = buf (saved)
    // x1 = fd (loaded)
    
    // Create [buf, fd]
    // Step 1: Create [fd, nil] (Recreate? Or reuse OldEnv?)
    // OldEnv IS [fd, nil]. So we can reuse it as Tail!
    // So NewEnv = Cons(buf, OldEnv)
    
    ldr x0, [sp] // Restore buf
    ldr x1, [sp, #8] // Restore OldEnv
    bl _cons
    // x0 is NewEnv [buf, [fd, nil]]
    
    // Closure
    mov x1, x0 // Env
    adr x0, _sys_write_3 // Code
    bl _cons
    
    ldp x0, x9, [sp], #16
    ldp x29, x30, [sp], #16
    ret

_sys_write_3:
    // x0 = len
    // Env = [buf, [fd, nil]]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x2, x0 // arg3: len
    
    // Extract buf, fd from Env (x9)
    ldr x1, [x9] // buf (Car)
    ldr x9, [x9, #8] // Tail [fd, nil]
    ldr x0, [x9] // fd (Car)
    
    // Now x0=fd, x1=buf, x2=len
    
    mov x8, #64 // sys_write
    svc #0
    
    // Return result (usually 0 or written bytes)
    // x0 has result.
    
    ldp x29, x30, [sp], #16
    ret
    


// Intrinsic: __sys_brk(addr) -> addr
// Usage: __sys_brk 0 (get current), __sys_brk new_addr (alloc)
// Returns CLOSURE
_sys_brk:
    // Create Closure [_sys_brk_impl, nil]
    stp x29, x30, [sp, # - 16]!
    mov x29, sp
    
    adr x0, sign_id // nil
    str x0, [sp, # - 16]!
    adr x1, _sys_brk_impl
    ldr x0, [sp], #16
    bl _cons
    
    mov sp, x29
    ldp x29, x30, [sp], #16
ret

_sys_brk_impl:
    // x0 is Arg (addr). Env is nil (ignored).
    stp x29, x30, [sp, # - 16]!
    mov x29, sp
    
    mov x8, #214 // brk
    svc #0
    
    mov sp, x29
    ldp x29, x30, [sp], #16
ret

