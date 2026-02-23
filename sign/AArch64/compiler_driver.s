// Sign Compiler Output
// Target: aarch64
// Mode: compile
// Exception Level: 0
// Link: static
// Options: debug=true, optimize=false

.global __sign_init
.text
__sign_init:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    adr x0, sys_brk
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2
    tst x1, #1
    b.eq do_concat_2
do_apply_1:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3
do_concat_2:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3:
    adr x1, heap_start
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sys_brk
    str x0, [sp, #-16]!
    adr x0, heap_start
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, =0x4130000000000000
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5
    tst x1, #1
    b.eq do_concat_5
do_apply_4:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_6
do_concat_5:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_6:
    adr x1, heap_end
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, heap_start
    ldr x0, [x0]
    adr x1, heap_addr
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, alloc
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_10
    tst x1, #1
    b.eq do_concat_10
do_apply_9:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_11
do_concat_10:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_11:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7
    b after_func_12_13
func_12:
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
    b.ne blk_end_14
    adr x0, heap_addr
    str x0, [sp, #-16]!
    adr x0, curr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_14
    adr x0, curr
blk_end_14:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_12_13:
    // Closure for func_12
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_12
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8
cond_false_7:
    adr x0, sign_id
cond_end_8:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_18
    tst x1, #1
    b.eq do_concat_18
do_apply_17:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_19
do_concat_18:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_19:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_15
    b after_func_20_21
func_20:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_22_23
func_22:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, addr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_25
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_28
    tst x1, #1
    b.eq do_concat_28
do_apply_27:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_29
do_concat_28:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_29:
    b cond_end_26
cond_false_25:
    adr x0, sign_id
cond_end_26:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_24
    adr x0, addr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_24
    adr x0, addr
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_24
    adr x0, addr
blk_end_24:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_22_23:
    // Closure for func_22
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_22
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_20_21:
    // Closure for func_20
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_20
    ldr x0, [sp], #16
    bl _cons
    b cond_end_16
cond_false_15:
    adr x0, sign_id
cond_end_16:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, head
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_33
    tst x1, #1
    b.eq do_concat_33
do_apply_32:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_34
do_concat_33:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_34:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_30
    b after_func_35_36
func_35:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_35_36:
    // Closure for func_35
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_35
    ldr x0, [sp], #16
    bl _cons
    b cond_end_31
cond_false_30:
    adr x0, sign_id
cond_end_31:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tail
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_40
    tst x1, #1
    b.eq do_concat_40
do_apply_39:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_41
do_concat_40:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_41:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_37
    b after_func_42_43
func_42:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_42_43:
    // Closure for func_42
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_42
    ldr x0, [sp], #16
    bl _cons
    b cond_end_38
cond_false_37:
    adr x0, sign_id
cond_end_38:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, nth
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_47
    tst x1, #1
    b.eq do_concat_47
do_apply_46:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_48
do_concat_47:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_48:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_44
    b after_func_49_50
func_49:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_56
    adr x0, sign_id
    b cmp_end_57
cmp_true_56:
cmp_end_57:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_54
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_59
    tst x1, #1
    b.eq do_concat_59
do_apply_58:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_60
do_concat_59:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_60:
    b cond_end_55
cond_false_54:
    adr x0, sign_id
cond_end_55:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_53
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_62
    tst x1, #1
    b.eq do_concat_62
do_apply_61:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_63
do_concat_62:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_63:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_65
    tst x1, #1
    b.eq do_concat_65
do_apply_64:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_66
do_concat_65:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_66:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_68
    tst x1, #1
    b.eq do_concat_68
do_apply_67:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_69
do_concat_68:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_69:
blk_end_53:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_51_52:
    // Closure for func_51
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_51
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_49_50:
    // Closure for func_49
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_49
    ldr x0, [sp], #16
    bl _cons
    b cond_end_45
cond_false_44:
    adr x0, sign_id
cond_end_45:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, factorial
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_73
    tst x1, #1
    b.eq do_concat_73
do_apply_72:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_74
do_concat_73:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_74:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_70
    b after_func_75_76
func_75:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_80
    adr x0, sign_id
    b cmp_end_81
cmp_true_80:
cmp_end_81:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_78
    mov x0, #1
    b cond_end_79
cond_false_78:
    adr x0, sign_id
cond_end_79:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_77
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, factorial
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_83
    tst x1, #1
    b.eq do_concat_83
do_apply_82:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_84
do_concat_83:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_84:
blk_end_77:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_75_76:
    // Closure for func_75
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_75
    ldr x0, [sp], #16
    bl _cons
    b cond_end_71
cond_false_70:
    adr x0, sign_id
cond_end_71:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, range
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_88
    tst x1, #1
    b.eq do_concat_88
do_apply_87:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_89
do_concat_88:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_89:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_85
    b after_func_90_91
func_90:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_92_93
func_92:
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
    b.gt cmp_true_97
    adr x0, sign_id
    b cmp_end_98
cmp_true_97:
cmp_end_98:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_95
    mov x0, #0
    b cond_end_96
cond_false_95:
    adr x0, sign_id
cond_end_96:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_94
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_100
    tst x1, #1
    b.eq do_concat_100
do_apply_99:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_101
do_concat_100:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_101:
    str x0, [sp, #-16]!
    adr x0, range
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_103
    tst x1, #1
    b.eq do_concat_103
do_apply_102:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_104
do_concat_103:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_104:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_106
    tst x1, #1
    b.eq do_concat_106
do_apply_105:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_107
do_concat_106:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_107:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_109
    tst x1, #1
    b.eq do_concat_109
do_apply_108:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_110
do_concat_109:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_110:
blk_end_94:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_92_93:
    // Closure for func_92
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_92
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_90_91:
    // Closure for func_90
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_90
    ldr x0, [sp], #16
    bl _cons
    b cond_end_86
cond_false_85:
    adr x0, sign_id
cond_end_86:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_114
    tst x1, #1
    b.eq do_concat_114
do_apply_113:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_115
do_concat_114:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_115:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_111
    b after_func_116_117
func_116:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_120
    tst x1, #1
    b.eq do_concat_120
do_apply_119:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_121
do_concat_120:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_121:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_123
    tst x1, #1
    b.eq do_concat_123
do_apply_122:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_124
do_concat_123:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_124:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_118
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_126
    tst x1, #1
    b.eq do_concat_126
do_apply_125:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_127
do_concat_126:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_127:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_129
    tst x1, #1
    b.eq do_concat_129
do_apply_128:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_130
do_concat_129:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_130:
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_132
    tst x1, #1
    b.eq do_concat_132
do_apply_131:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_133
do_concat_132:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_133:
blk_end_118:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_116_117:
    // Closure for func_116
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_116
    ldr x0, [sp], #16
    bl _cons
    b cond_end_112
cond_false_111:
    adr x0, sign_id
cond_end_112:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_137
    tst x1, #1
    b.eq do_concat_137
do_apply_136:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_138
do_concat_137:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_138:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_134
    b after_func_139_140
func_139:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_142_143
func_142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_142_143:
    // Closure for func_142
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_142
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_144
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_144
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_144
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_147
    adr x0, sign_id
    b cmp_end_148
cmp_true_147:
cmp_end_148:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_145
    ldr x0, [x29, #-64]
    b cond_end_146
cond_false_145:
    adr x0, sign_id
cond_end_146:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_144
    adr x0, len_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_150
    tst x1, #1
    b.eq do_concat_150
do_apply_149:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_151
do_concat_150:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_151:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_153
    tst x1, #1
    b.eq do_concat_153
do_apply_152:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_154
do_concat_153:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_154:
blk_end_144:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_156
    tst x1, #1
    b.eq do_concat_156
do_apply_155:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_157
do_concat_156:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_157:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_141
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_159
    tst x1, #1
    b.eq do_concat_159
do_apply_158:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_160
do_concat_159:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_160:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_141
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_162
    tst x1, #1
    b.eq do_concat_162
do_apply_161:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_163
do_concat_162:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_163:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_165
    tst x1, #1
    b.eq do_concat_165
do_apply_164:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_166
do_concat_165:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_166:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_168
    tst x1, #1
    b.eq do_concat_168
do_apply_167:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_169
do_concat_168:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_169:
blk_end_141:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_139_140:
    // Closure for func_139
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_139
    ldr x0, [sp], #16
    bl _cons
    b cond_end_135
cond_false_134:
    adr x0, sign_id
cond_end_135:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_173
    tst x1, #1
    b.eq do_concat_173
do_apply_172:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_174
do_concat_173:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_174:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_170
    b after_func_175_176
func_175:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_180
    adr x0, sign_id
    b cmp_end_181
cmp_true_180:
cmp_end_181:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_178
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_184
    tst x1, #1
    b.eq do_concat_184
do_apply_183:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_185
do_concat_184:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_185:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_182
    mov x0, #0
blk_end_182:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_187
    tst x1, #1
    b.eq do_concat_187
do_apply_186:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_188
do_concat_187:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_188:
    b cond_end_179
cond_false_178:
    adr x0, sign_id
cond_end_179:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_177
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_191
    adr x0, sign_id
    b cmp_end_192
cmp_true_191:
cmp_end_192:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_189
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_195
    tst x1, #1
    b.eq do_concat_195
do_apply_194:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_196
do_concat_195:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_196:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_193
    adr x0, print_num
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_198
    tst x1, #1
    b.eq do_concat_198
do_apply_197:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_199
do_concat_198:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_199:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_193
    mov x0, #0
blk_end_193:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_201
    tst x1, #1
    b.eq do_concat_201
do_apply_200:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_202
do_concat_201:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_202:
    b cond_end_190
cond_false_189:
    adr x0, sign_id
cond_end_190:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_177
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_204
    tst x1, #1
    b.eq do_concat_204
do_apply_203:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_205
do_concat_204:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_205:
blk_end_177:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_175_176:
    // Closure for func_175
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_175
    ldr x0, [sp], #16
    bl _cons
    b cond_end_171
cond_false_170:
    adr x0, sign_id
cond_end_171:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _print_num_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_209
    tst x1, #1
    b.eq do_concat_209
do_apply_208:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_210
do_concat_209:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_210:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_206
    b after_func_211_212
func_211:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_216
    adr x0, sign_id
    b cmp_end_217
cmp_true_216:
cmp_end_217:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_214
    mov x0, #0
    b cond_end_215
cond_false_214:
    adr x0, sign_id
cond_end_215:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_213
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_219
    tst x1, #1
    b.eq do_concat_219
do_apply_218:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_220
do_concat_219:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_220:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_213
    adr x0, print_char
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
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_222
    tst x1, #1
    b.eq do_concat_222
do_apply_221:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_223
do_concat_222:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_223:
blk_end_213:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_211_212:
    // Closure for func_211
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_211
    ldr x0, [sp], #16
    bl _cons
    b cond_end_207
cond_false_206:
    adr x0, sign_id
cond_end_207:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_227
    tst x1, #1
    b.eq do_concat_227
do_apply_226:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_228
do_concat_227:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_228:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_224
    b after_func_229_230
func_229:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_231_232
func_231:
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
    bl _add
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_231_232:
    // Closure for func_231
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_231
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_229_230:
    // Closure for func_229
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_229
    ldr x0, [sp], #16
    bl _cons
    b cond_end_225
cond_false_224:
    adr x0, sign_id
cond_end_225:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sub
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_236
    tst x1, #1
    b.eq do_concat_236
do_apply_235:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_237
do_concat_236:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_237:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_233
    b after_func_238_239
func_238:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_240_241
func_240:
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
after_func_240_241:
    // Closure for func_240
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_240
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_238_239:
    // Closure for func_238
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_238
    ldr x0, [sp], #16
    bl _cons
    b cond_end_234
cond_false_233:
    adr x0, sign_id
cond_end_234:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, mul
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_245
    tst x1, #1
    b.eq do_concat_245
do_apply_244:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_246
do_concat_245:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_246:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_242
    b after_func_247_248
func_247:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_249_250
func_249:
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
after_func_249_250:
    // Closure for func_249
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_249
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_247_248:
    // Closure for func_247
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_247
    ldr x0, [sp], #16
    bl _cons
    b cond_end_243
cond_false_242:
    adr x0, sign_id
cond_end_243:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, div
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_254
    tst x1, #1
    b.eq do_concat_254
do_apply_253:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_255
do_concat_254:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_255:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_251
    b after_func_256_257
func_256:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_258_259
func_258:
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
after_func_258_259:
    // Closure for func_258
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_258
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_256_257:
    // Closure for func_256
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_256
    ldr x0, [sp], #16
    bl _cons
    b cond_end_252
cond_false_251:
    adr x0, sign_id
cond_end_252:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, mod
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_263
    tst x1, #1
    b.eq do_concat_263
do_apply_262:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_264
do_concat_263:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_264:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_260
    b after_func_265_266
func_265:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_267_268
func_267:
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
after_func_267_268:
    // Closure for func_267
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_267
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_265_266:
    // Closure for func_265
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_265
    ldr x0, [sp], #16
    bl _cons
    b cond_end_261
cond_false_260:
    adr x0, sign_id
cond_end_261:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Self
    str x0, [sp, #-16]!
    adr x0, Hosting
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_270
    tst x1, #1
    b.eq do_concat_270
do_apply_269:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_271
do_concat_270:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_271:
    str x0, [sp, #-16]!
    adr x0, Lexer
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_273
    tst x1, #1
    b.eq do_concat_273
do_apply_272:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_274
do_concat_273:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_274:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Ported
    str x0, [sp, #-16]!
    adr x0, from
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_276
    tst x1, #1
    b.eq do_concat_276
do_apply_275:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_277
do_concat_276:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_277:
    str x0, [sp, #-16]!
    adr x0, prepare_lexer
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_279
    tst x1, #1
    b.eq do_concat_279
do_apply_278:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_280
do_concat_279:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_280:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_282
    tst x1, #1
    b.eq do_concat_282
do_apply_281:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_283
do_concat_282:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_283:
    str x0, [sp, #-16]!
    adr x0, js
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_285
    tst x1, #1
    b.eq do_concat_285
do_apply_284:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_286
do_concat_285:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_286:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_288
    tst x1, #1
    b.eq do_concat_288
do_apply_287:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_289
do_concat_288:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_289:
    str x0, [sp, #-16]!
    adr x0, js
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_291
    tst x1, #1
    b.eq do_concat_291
do_apply_290:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_292
do_concat_291:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_292:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #-1
    adr x1, tok_eof
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, tok_id
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #2
    adr x1, tok_num
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #3
    adr x1, tok_str
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #4
    adr x1, tok_op
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #5
    adr x1, tok_punc
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #6
    adr x1, tok_sep
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #7
    adr x1, tok_lparen
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #8
    adr x1, tok_rparen
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, src
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, src_len
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ch
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, init_lexer
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_296
    tst x1, #1
    b.eq do_concat_296
do_apply_295:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_297
do_concat_296:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_297:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_293
    b after_func_298_299
func_298:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, src
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_300
    adr x0, src_len
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_302
    tst x1, #1
    b.eq do_concat_302
do_apply_301:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_303
do_concat_302:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_303:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_300
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_300
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_305
    tst x1, #1
    b.eq do_concat_305
do_apply_304:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_306
do_concat_305:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_306:
blk_end_300:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_298_299:
    // Closure for func_298
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_298
    ldr x0, [sp], #16
    bl _cons
    b cond_end_294
cond_false_293:
    adr x0, sign_id
cond_end_294:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, read_char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_310
    tst x1, #1
    b.eq do_concat_310
do_apply_309:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_311
do_concat_310:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_311:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_307
    b after_func_312_313
func_312:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p
    str x0, [sp, #-16]!
    adr x0, pos
    ldr x0, [x0] // @ load
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    adr x0, p
    str x0, [sp, #-16]!
    adr x0, src_len
    ldr x0, [x0] // @ load
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_317
    adr x0, sign_id
    b cmp_end_318
cmp_true_317:
cmp_end_318:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_315
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, ch
    str x0, [sp, #-16]!
    mov x0, #-1
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_319
    mov x0, #0
blk_end_319:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_321
    tst x1, #1
    b.eq do_concat_321
do_apply_320:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_322
do_concat_321:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_322:
    b cond_end_316
cond_false_315:
    adr x0, sign_id
cond_end_316:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    adr x0, c
    str x0, [sp, #-16]!
    adr x0, nth
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    adr x0, src
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, p
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_324
    tst x1, #1
    b.eq do_concat_324
do_apply_323:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_325
do_concat_324:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_325:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    adr x0, ch
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    adr x0, pos
    str x0, [sp, #-16]!
    adr x0, p
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    adr x0, c
blk_end_314:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_312_313:
    // Closure for func_312
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_312
    ldr x0, [sp], #16
    bl _cons
    b cond_end_308
cond_false_307:
    adr x0, sign_id
cond_end_308:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_space
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_329
    tst x1, #1
    b.eq do_concat_329
do_apply_328:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_330
do_concat_329:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_330:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_326
    b after_func_331_332
func_331:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_337
    adr x0, sign_id
    b cmp_end_338
cmp_true_337:
cmp_end_338:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_335
    b or_end_336
or_right_335:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_339
    adr x0, sign_id
    b cmp_end_340
cmp_true_339:
cmp_end_340:
or_end_336:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_333
    b or_end_334
or_right_333:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_341
    adr x0, sign_id
    b cmp_end_342
cmp_true_341:
cmp_end_342:
or_end_334:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_331_332:
    // Closure for func_331
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_331
    ldr x0, [sp], #16
    bl _cons
    b cond_end_327
cond_false_326:
    adr x0, sign_id
cond_end_327:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_digit
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_346
    tst x1, #1
    b.eq do_concat_346
do_apply_345:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_347
do_concat_346:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_347:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_343
    b after_func_348_349
func_348:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_352
    adr x0, sign_id
    b cmp_end_353
cmp_true_352:
cmp_end_353:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_350
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_354
    adr x0, sign_id
    b cmp_end_355
cmp_true_354:
cmp_end_355:
    b and_end_351
and_fail_350:
    adr x0, sign_id
and_end_351:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_348_349:
    // Closure for func_348
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_348
    ldr x0, [sp], #16
    bl _cons
    b cond_end_344
cond_false_343:
    adr x0, sign_id
cond_end_344:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_alpha
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_359
    tst x1, #1
    b.eq do_concat_359
do_apply_358:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_360
do_concat_359:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_360:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_356
    b after_func_361_362
func_361:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_369
    adr x0, sign_id
    b cmp_end_370
cmp_true_369:
cmp_end_370:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_367
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_371
    adr x0, sign_id
    b cmp_end_372
cmp_true_371:
cmp_end_372:
    b and_end_368
and_fail_367:
    adr x0, sign_id
and_end_368:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_365
    b or_end_366
or_right_365:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_375
    adr x0, sign_id
    b cmp_end_376
cmp_true_375:
cmp_end_376:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_373
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_377
    adr x0, sign_id
    b cmp_end_378
cmp_true_377:
cmp_end_378:
    b and_end_374
and_fail_373:
    adr x0, sign_id
and_end_374:
or_end_366:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_363
    b or_end_364
or_right_363:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_379
    adr x0, sign_id
    b cmp_end_380
cmp_true_379:
cmp_end_380:
or_end_364:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_361_362:
    // Closure for func_361
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_361
    ldr x0, [sp], #16
    bl _cons
    b cond_end_357
cond_false_356:
    adr x0, sign_id
cond_end_357:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_op_char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_384
    tst x1, #1
    b.eq do_concat_384
do_apply_383:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_385
do_concat_384:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_385:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_381
    b after_func_386_387
func_386:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_418
    adr x0, sign_id
    b cmp_end_419
cmp_true_418:
cmp_end_419:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_416
    b or_end_417
or_right_416:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_420
    adr x0, sign_id
    b cmp_end_421
cmp_true_420:
cmp_end_421:
or_end_417:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_414
    b or_end_415
or_right_414:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_422
    adr x0, sign_id
    b cmp_end_423
cmp_true_422:
cmp_end_423:
or_end_415:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_412
    b or_end_413
or_right_412:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_424
    adr x0, sign_id
    b cmp_end_425
cmp_true_424:
cmp_end_425:
or_end_413:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_410
    b or_end_411
or_right_410:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_426
    adr x0, sign_id
    b cmp_end_427
cmp_true_426:
cmp_end_427:
or_end_411:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_408
    b or_end_409
or_right_408:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_428
    adr x0, sign_id
    b cmp_end_429
cmp_true_428:
cmp_end_429:
or_end_409:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_406
    b or_end_407
or_right_406:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_430
    adr x0, sign_id
    b cmp_end_431
cmp_true_430:
cmp_end_431:
or_end_407:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_404
    b or_end_405
or_right_404:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_432
    adr x0, sign_id
    b cmp_end_433
cmp_true_432:
cmp_end_433:
or_end_405:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_402
    b or_end_403
or_right_402:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_434
    adr x0, sign_id
    b cmp_end_435
cmp_true_434:
cmp_end_435:
or_end_403:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_400
    b or_end_401
or_right_400:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_436
    adr x0, sign_id
    b cmp_end_437
cmp_true_436:
cmp_end_437:
or_end_401:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_398
    b or_end_399
or_right_398:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_438
    adr x0, sign_id
    b cmp_end_439
cmp_true_438:
cmp_end_439:
or_end_399:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_396
    b or_end_397
or_right_396:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_440
    adr x0, sign_id
    b cmp_end_441
cmp_true_440:
cmp_end_441:
or_end_397:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_394
    b or_end_395
or_right_394:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_442
    adr x0, sign_id
    b cmp_end_443
cmp_true_442:
cmp_end_443:
or_end_395:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_392
    b or_end_393
or_right_392:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_444
    adr x0, sign_id
    b cmp_end_445
cmp_true_444:
cmp_end_445:
or_end_393:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_390
    b or_end_391
or_right_390:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_446
    adr x0, sign_id
    b cmp_end_447
cmp_true_446:
cmp_end_447:
or_end_391:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_388
    b or_end_389
or_right_388:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_448
    adr x0, sign_id
    b cmp_end_449
cmp_true_448:
cmp_end_449:
or_end_389:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_386_387:
    // Closure for func_386
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_386
    ldr x0, [sp], #16
    bl _cons
    b cond_end_382
cond_false_381:
    adr x0, sign_id
cond_end_382:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, length
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_453
    tst x1, #1
    b.eq do_concat_453
do_apply_452:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_454
do_concat_453:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_454:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_450
    b after_func_455_456
func_455:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_460
    adr x0, sign_id
    b cmp_end_461
cmp_true_460:
cmp_end_461:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_458
    mov x0, #0
    b cond_end_459
cond_false_458:
    adr x0, sign_id
cond_end_459:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_457
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, length
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_463
    tst x1, #1
    b.eq do_concat_463
do_apply_462:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_464
do_concat_463:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_464:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_466
    tst x1, #1
    b.eq do_concat_466
do_apply_465:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_467
do_concat_466:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_467:
blk_end_457:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_455_456:
    // Closure for func_455
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_455
    ldr x0, [sp], #16
    bl _cons
    b cond_end_451
cond_false_450:
    adr x0, sign_id
cond_end_451:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, list_to_string
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_471
    tst x1, #1
    b.eq do_concat_471
do_apply_470:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_472
do_concat_471:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_472:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_468
    b after_func_473_474
func_473:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, length
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_477
    tst x1, #1
    b.eq do_concat_477
do_apply_476:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_478
do_concat_477:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_478:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_475
    adr x0, alloc
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_480
    tst x1, #1
    b.eq do_concat_480
do_apply_479:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_481
do_concat_480:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_481:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_475
    adr x0, _write_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_483
    tst x1, #1
    b.eq do_concat_483
do_apply_482:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_484
do_concat_483:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_484:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_486
    tst x1, #1
    b.eq do_concat_486
do_apply_485:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_487
do_concat_486:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_487:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_489
    tst x1, #1
    b.eq do_concat_489
do_apply_488:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_490
do_concat_489:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_490:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_475
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_475
    ldr x0, [x29, #-64]
blk_end_475:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_473_474:
    // Closure for func_473
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_473
    ldr x0, [sp], #16
    bl _cons
    b cond_end_469
cond_false_468:
    adr x0, sign_id
cond_end_469:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _write_list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_494
    tst x1, #1
    b.eq do_concat_494
do_apply_493:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_495
do_concat_494:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_495:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_491
    b after_func_496_497
func_496:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_498_499
func_498:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_500_501
func_500:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_505
    adr x0, sign_id
    b cmp_end_506
cmp_true_505:
cmp_end_506:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_503
    mov x0, #0
    b cond_end_504
cond_false_503:
    adr x0, sign_id
cond_end_504:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_502
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_508
    tst x1, #1
    b.eq do_concat_508
do_apply_507:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_509
do_concat_508:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_509:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_502
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_511
    tst x1, #1
    b.eq do_concat_511
do_apply_510:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_512
do_concat_511:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_512:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_514
    tst x1, #1
    b.eq do_concat_514
do_apply_513:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_515
do_concat_514:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_515:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_517
    tst x1, #1
    b.eq do_concat_517
do_apply_516:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_518
do_concat_517:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_518:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_520
    tst x1, #1
    b.eq do_concat_520
do_apply_519:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_521
do_concat_520:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_521:
blk_end_502:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_500_501:
    // Closure for func_500
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_500
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_498_499:
    // Closure for func_498
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_498
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_496_497:
    // Closure for func_496
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_496
    ldr x0, [sp], #16
    bl _cons
    b cond_end_492
cond_false_491:
    adr x0, sign_id
cond_end_492:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tokenize
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_525
    tst x1, #1
    b.eq do_concat_525
do_apply_524:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_526
do_concat_525:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_526:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_522
    b after_func_527_528
func_527:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, scan
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_531
    tst x1, #1
    b.eq do_concat_531
do_apply_530:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_532
do_concat_531:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_532:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_535
    adr x0, sign_id
    b cmp_end_536
cmp_true_535:
cmp_end_536:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_533
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_538
    tst x1, #1
    b.eq do_concat_538
do_apply_537:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_539
do_concat_538:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_539:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_541
    tst x1, #1
    b.eq do_concat_541
do_apply_540:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_542
do_concat_541:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_542:
    b cond_end_534
cond_false_533:
    adr x0, sign_id
cond_end_534:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_544
    tst x1, #1
    b.eq do_concat_544
do_apply_543:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_545
do_concat_544:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_545:
    str x0, [sp, #-16]!
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_547
    tst x1, #1
    b.eq do_concat_547
do_apply_546:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_548
do_concat_547:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_548:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_550
    tst x1, #1
    b.eq do_concat_550
do_apply_549:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_551
do_concat_550:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_551:
blk_end_529:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_527_528:
    // Closure for func_527
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_527
    ldr x0, [sp], #16
    bl _cons
    b cond_end_523
cond_false_522:
    adr x0, sign_id
cond_end_523:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_555
    tst x1, #1
    b.eq do_concat_555
do_apply_554:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_556
do_concat_555:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_556:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_552
    b after_func_557_558
func_557:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_561
    tst x1, #1
    b.eq do_concat_561
do_apply_560:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_562
do_concat_561:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_562:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    adr x0, ch
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_565
    adr x0, sign_id
    b cmp_end_566
cmp_true_565:
cmp_end_566:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_563
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_568
    tst x1, #1
    b.eq do_concat_568
do_apply_567:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_569
do_concat_568:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_569:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_571
    tst x1, #1
    b.eq do_concat_571
do_apply_570:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_572
do_concat_571:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_572:
    b cond_end_564
cond_false_563:
    adr x0, sign_id
cond_end_564:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    adr x0, is_digit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_576
    tst x1, #1
    b.eq do_concat_576
do_apply_575:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_577
do_concat_576:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_577:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_573
    adr x0, scan_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_579
    tst x1, #1
    b.eq do_concat_579
do_apply_578:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_580
do_concat_579:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_580:
    b cond_end_574
cond_false_573:
    adr x0, sign_id
cond_end_574:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_584
    tst x1, #1
    b.eq do_concat_584
do_apply_583:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_585
do_concat_584:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_585:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_581
    adr x0, scan_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_587
    tst x1, #1
    b.eq do_concat_587
do_apply_586:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_588
do_concat_587:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_588:
    b cond_end_582
cond_false_581:
    adr x0, sign_id
cond_end_582:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_592
    tst x1, #1
    b.eq do_concat_592
do_apply_591:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_593
do_concat_592:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_593:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_589
    adr x0, scan_op
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_595
    tst x1, #1
    b.eq do_concat_595
do_apply_594:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_596
do_concat_595:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_596:
    b cond_end_590
cond_false_589:
    adr x0, sign_id
cond_end_590:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_599
    adr x0, sign_id
    b cmp_end_600
cmp_true_599:
cmp_end_600:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_597
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_602
    tst x1, #1
    b.eq do_concat_602
do_apply_601:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_603
do_concat_602:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_603:
    b cond_end_598
cond_false_597:
    adr x0, sign_id
cond_end_598:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_606
    adr x0, sign_id
    b cmp_end_607
cmp_true_606:
cmp_end_607:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_604
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_609
    tst x1, #1
    b.eq do_concat_609
do_apply_608:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_610
do_concat_609:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_610:
    b cond_end_605
cond_false_604:
    adr x0, sign_id
cond_end_605:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_613
    adr x0, sign_id
    b cmp_end_614
cmp_true_613:
cmp_end_614:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_611
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_617
    tst x1, #1
    b.eq do_concat_617
do_apply_616:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_618
do_concat_617:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_618:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_615
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_620
    tst x1, #1
    b.eq do_concat_620
do_apply_619:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_621
do_concat_620:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_621:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_623
    tst x1, #1
    b.eq do_concat_623
do_apply_622:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_624
do_concat_623:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_624:
blk_end_615:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_626
    tst x1, #1
    b.eq do_concat_626
do_apply_625:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_627
do_concat_626:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_627:
    b cond_end_612
cond_false_611:
    adr x0, sign_id
cond_end_612:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #40
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_634
    adr x0, sign_id
    b cmp_end_635
cmp_true_634:
cmp_end_635:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_632
    b or_end_633
or_right_632:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_636
    adr x0, sign_id
    b cmp_end_637
cmp_true_636:
cmp_end_637:
or_end_633:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_630
    b or_end_631
or_right_630:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #123
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_638
    adr x0, sign_id
    b cmp_end_639
cmp_true_638:
cmp_end_639:
or_end_631:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_628
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_642
    tst x1, #1
    b.eq do_concat_642
do_apply_641:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_643
do_concat_642:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_643:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_640
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_645
    tst x1, #1
    b.eq do_concat_645
do_apply_644:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_646
do_concat_645:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_646:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_648
    tst x1, #1
    b.eq do_concat_648
do_apply_647:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_649
do_concat_648:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_649:
blk_end_640:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_651
    tst x1, #1
    b.eq do_concat_651
do_apply_650:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_652
do_concat_651:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_652:
    b cond_end_629
cond_false_628:
    adr x0, sign_id
cond_end_629:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #41
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_659
    adr x0, sign_id
    b cmp_end_660
cmp_true_659:
cmp_end_660:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_657
    b or_end_658
or_right_657:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #93
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_661
    adr x0, sign_id
    b cmp_end_662
cmp_true_661:
cmp_end_662:
or_end_658:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_655
    b or_end_656
or_right_655:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #125
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_663
    adr x0, sign_id
    b cmp_end_664
cmp_true_663:
cmp_end_664:
or_end_656:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_653
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_667
    tst x1, #1
    b.eq do_concat_667
do_apply_666:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_668
do_concat_667:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_668:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_665
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_670
    tst x1, #1
    b.eq do_concat_670
do_apply_669:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_671
do_concat_670:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_671:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_673
    tst x1, #1
    b.eq do_concat_673
do_apply_672:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_674
do_concat_673:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_674:
blk_end_665:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_676
    tst x1, #1
    b.eq do_concat_676
do_apply_675:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_677
do_concat_676:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_677:
    b cond_end_654
cond_false_653:
    adr x0, sign_id
cond_end_654:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_679
    tst x1, #1
    b.eq do_concat_679
do_apply_678:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_680
do_concat_679:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_680:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_559
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_682
    tst x1, #1
    b.eq do_concat_682
do_apply_681:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_683
do_concat_682:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_683:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_685
    tst x1, #1
    b.eq do_concat_685
do_apply_684:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_686
do_concat_685:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_686:
blk_end_559:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_557_558:
    // Closure for func_557
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_557
    ldr x0, [sp], #16
    bl _cons
    b cond_end_553
cond_false_552:
    adr x0, sign_id
cond_end_553:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, skip_space
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_690
    tst x1, #1
    b.eq do_concat_690
do_apply_689:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_691
do_concat_690:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_691:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_687
    b after_func_692_693
func_692:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x0, [x0] // @ load
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_698
    tst x1, #1
    b.eq do_concat_698
do_apply_697:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_699
do_concat_698:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_699:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_695
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_702
    tst x1, #1
    b.eq do_concat_702
do_apply_701:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_703
do_concat_702:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_703:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_705
    tst x1, #1
    b.eq do_concat_705
do_apply_704:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_706
do_concat_705:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_706:
blk_end_700:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_708
    tst x1, #1
    b.eq do_concat_708
do_apply_707:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_709
do_concat_708:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_709:
    b cond_end_696
cond_false_695:
    adr x0, sign_id
cond_end_696:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_694
    mov x0, #0
blk_end_694:
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
    b cond_end_688
cond_false_687:
    adr x0, sign_id
cond_end_688:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_id
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_713
    tst x1, #1
    b.eq do_concat_713
do_apply_712:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_714
do_concat_713:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_714:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_710
    b after_func_715_716
func_715:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_719
    tst x1, #1
    b.eq do_concat_719
do_apply_718:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_720
do_concat_719:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_720:
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_722
    tst x1, #1
    b.eq do_concat_722
do_apply_721:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_723
do_concat_722:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_723:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_725
    tst x1, #1
    b.eq do_concat_725
do_apply_724:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_726
do_concat_725:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_726:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_728
    tst x1, #1
    b.eq do_concat_728
do_apply_727:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_729
do_concat_728:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_729:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_717
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_731
    tst x1, #1
    b.eq do_concat_731
do_apply_730:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_732
do_concat_731:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_732:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_717
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_734
    tst x1, #1
    b.eq do_concat_734
do_apply_733:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_735
do_concat_734:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_735:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_737
    tst x1, #1
    b.eq do_concat_737
do_apply_736:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_738
do_concat_737:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_738:
blk_end_717:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_715_716:
    // Closure for func_715
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_715
    ldr x0, [sp], #16
    bl _cons
    b cond_end_711
cond_false_710:
    adr x0, sign_id
cond_end_711:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_742
    tst x1, #1
    b.eq do_concat_742
do_apply_741:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_743
do_concat_742:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_743:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_739
    b after_func_744_745
func_744:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_749
    b or_end_750
or_right_749:
    adr x0, is_digit
or_end_750:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_752
    tst x1, #1
    b.eq do_concat_752
do_apply_751:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_753
do_concat_752:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_753:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_755
    tst x1, #1
    b.eq do_concat_755
do_apply_754:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_756
do_concat_755:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_756:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_747
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_758
    tst x1, #1
    b.eq do_concat_758
do_apply_757:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_759
do_concat_758:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_759:
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_761
    tst x1, #1
    b.eq do_concat_761
do_apply_760:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_762
do_concat_761:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_762:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_764
    tst x1, #1
    b.eq do_concat_764
do_apply_763:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_765
do_concat_764:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_765:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_767
    tst x1, #1
    b.eq do_concat_767
do_apply_766:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_768
do_concat_767:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_768:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_770
    tst x1, #1
    b.eq do_concat_770
do_apply_769:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_771
do_concat_770:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_771:
    b cond_end_748
cond_false_747:
    adr x0, sign_id
cond_end_748:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_746
    mov x0, #0
blk_end_746:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_744_745:
    // Closure for func_744
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_744
    ldr x0, [sp], #16
    bl _cons
    b cond_end_740
cond_false_739:
    adr x0, sign_id
cond_end_740:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_775
    tst x1, #1
    b.eq do_concat_775
do_apply_774:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_776
do_concat_775:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_776:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_772
    b after_func_777_778
func_777:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_781
    tst x1, #1
    b.eq do_concat_781
do_apply_780:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_782
do_concat_781:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_782:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_784
    tst x1, #1
    b.eq do_concat_784
do_apply_783:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_785
do_concat_784:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_785:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_779
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_787
    tst x1, #1
    b.eq do_concat_787
do_apply_786:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_788
do_concat_787:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_788:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_790
    tst x1, #1
    b.eq do_concat_790
do_apply_789:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_791
do_concat_790:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_791:
blk_end_779:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_777_778:
    // Closure for func_777
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_777
    ldr x0, [sp], #16
    bl _cons
    b cond_end_773
cond_false_772:
    adr x0, sign_id
cond_end_773:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_795
    tst x1, #1
    b.eq do_concat_795
do_apply_794:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_796
do_concat_795:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_796:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_792
    b after_func_797_798
func_797:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_799_800
func_799:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, is_digit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_805
    tst x1, #1
    b.eq do_concat_805
do_apply_804:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_806
do_concat_805:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_806:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_802
    adr x0, val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_807
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_809
    tst x1, #1
    b.eq do_concat_809
do_apply_808:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_810
do_concat_809:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_810:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_812
    tst x1, #1
    b.eq do_concat_812
do_apply_811:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_813
do_concat_812:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_813:
    str x0, [sp, #-16]!
    adr x0, val
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_815
    tst x1, #1
    b.eq do_concat_815
do_apply_814:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_816
do_concat_815:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_816:
blk_end_807:
    b cond_end_803
cond_false_802:
    adr x0, sign_id
cond_end_803:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_801
    ldr x0, [x29, #-32]
blk_end_801:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_799_800:
    // Closure for func_799
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_799
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_797_798:
    // Closure for func_797
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_797
    ldr x0, [sp], #16
    bl _cons
    b cond_end_793
cond_false_792:
    adr x0, sign_id
cond_end_793:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_820
    tst x1, #1
    b.eq do_concat_820
do_apply_819:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_821
do_concat_820:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_821:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_817
    b after_func_822_823
func_822:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_826
    tst x1, #1
    b.eq do_concat_826
do_apply_825:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_827
do_concat_826:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_827:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_829
    tst x1, #1
    b.eq do_concat_829
do_apply_828:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_830
do_concat_829:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_830:
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_832
    tst x1, #1
    b.eq do_concat_832
do_apply_831:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_833
do_concat_832:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_833:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_835
    tst x1, #1
    b.eq do_concat_835
do_apply_834:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_836
do_concat_835:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_836:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_838
    tst x1, #1
    b.eq do_concat_838
do_apply_837:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_839
do_concat_838:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_839:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_824
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_841
    tst x1, #1
    b.eq do_concat_841
do_apply_840:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_842
do_concat_841:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_842:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_824
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_844
    tst x1, #1
    b.eq do_concat_844
do_apply_843:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_845
do_concat_844:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_845:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_847
    tst x1, #1
    b.eq do_concat_847
do_apply_846:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_848
do_concat_847:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_848:
blk_end_824:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_822_823:
    // Closure for func_822
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_822
    ldr x0, [sp], #16
    bl _cons
    b cond_end_818
cond_false_817:
    adr x0, sign_id
cond_end_818:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_852
    tst x1, #1
    b.eq do_concat_852
do_apply_851:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_853
do_concat_852:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_853:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_849
    b after_func_854_855
func_854:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_860
    tst x1, #1
    b.eq do_concat_860
do_apply_859:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_861
do_concat_860:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_861:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_857
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_863
    tst x1, #1
    b.eq do_concat_863
do_apply_862:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_864
do_concat_863:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_864:
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_866
    tst x1, #1
    b.eq do_concat_866
do_apply_865:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_867
do_concat_866:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_867:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_869
    tst x1, #1
    b.eq do_concat_869
do_apply_868:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_870
do_concat_869:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_870:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_872
    tst x1, #1
    b.eq do_concat_872
do_apply_871:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_873
do_concat_872:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_873:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_875
    tst x1, #1
    b.eq do_concat_875
do_apply_874:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_876
do_concat_875:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_876:
    b cond_end_858
cond_false_857:
    adr x0, sign_id
cond_end_858:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_856
    mov x0, #0
blk_end_856:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_854_855:
    // Closure for func_854
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_854
    ldr x0, [sp], #16
    bl _cons
    b cond_end_850
cond_false_849:
    adr x0, sign_id
cond_end_850:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_880
    tst x1, #1
    b.eq do_concat_880
do_apply_879:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_881
do_concat_880:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_881:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_877
    b after_func_882_883
func_882:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_886
    tst x1, #1
    b.eq do_concat_886
do_apply_885:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_887
do_concat_886:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_887:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_889
    tst x1, #1
    b.eq do_concat_889
do_apply_888:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_890
do_concat_889:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_890:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_892
    tst x1, #1
    b.eq do_concat_892
do_apply_891:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_893
do_concat_892:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_893:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_884
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_895
    tst x1, #1
    b.eq do_concat_895
do_apply_894:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_896
do_concat_895:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_896:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_898
    tst x1, #1
    b.eq do_concat_898
do_apply_897:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_899
do_concat_898:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_899:
blk_end_884:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_882_883:
    // Closure for func_882
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_882
    ldr x0, [sp], #16
    bl _cons
    b cond_end_878
cond_false_877:
    adr x0, sign_id
cond_end_878:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_903
    tst x1, #1
    b.eq do_concat_903
do_apply_902:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_904
do_concat_903:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_904:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_900
    b after_func_905_906
func_905:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_912
    adr x0, sign_id
    b cmp_end_913
cmp_true_912:
cmp_end_913:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_910
    b or_end_911
or_right_910:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_914
    adr x0, sign_id
    b cmp_end_915
cmp_true_914:
cmp_end_915:
or_end_911:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_908
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_918
    tst x1, #1
    b.eq do_concat_918
do_apply_917:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_919
do_concat_918:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_919:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_916
    mov x0, #0
blk_end_916:
    b cond_end_909
cond_false_908:
    adr x0, sign_id
cond_end_909:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_907
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_921
    tst x1, #1
    b.eq do_concat_921
do_apply_920:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_922
do_concat_921:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_922:
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_924
    tst x1, #1
    b.eq do_concat_924
do_apply_923:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_925
do_concat_924:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_925:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_927
    tst x1, #1
    b.eq do_concat_927
do_apply_926:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_928
do_concat_927:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_928:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_930
    tst x1, #1
    b.eq do_concat_930
do_apply_929:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_931
do_concat_930:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_931:
blk_end_907:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_905_906:
    // Closure for func_905
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_905
    ldr x0, [sp], #16
    bl _cons
    b cond_end_901
cond_false_900:
    adr x0, sign_id
cond_end_901:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Self
    str x0, [sp, #-16]!
    adr x0, Hosting
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_933
    tst x1, #1
    b.eq do_concat_933
do_apply_932:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_934
do_concat_933:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_934:
    str x0, [sp, #-16]!
    adr x0, Parser
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_936
    tst x1, #1
    b.eq do_concat_936
do_apply_935:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_937
do_concat_936:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_937:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Parses
    str x0, [sp, #-16]!
    adr x0, token
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_939
    tst x1, #1
    b.eq do_concat_939
do_apply_938:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_940
do_concat_939:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_940:
    str x0, [sp, #-16]!
    adr x0, list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_942
    tst x1, #1
    b.eq do_concat_942
do_apply_941:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_943
do_concat_942:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_943:
    str x0, [sp, #-16]!
    adr x0, into
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_945
    tst x1, #1
    b.eq do_concat_945
do_apply_944:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_946
do_concat_945:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_946:
    str x0, [sp, #-16]!
    adr x0, AST
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_948
    tst x1, #1
    b.eq do_concat_948
do_apply_947:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_949
do_concat_948:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_949:
    str x0, [sp, #-16]!
    adr x0, S
    str x0, [sp, #-16]!
    adr x0, expressions
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_951
    tst x1, #1
    b.eq do_concat_951
do_apply_950:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_952
do_concat_951:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_952:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, ast_num
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #2
    adr x1, ast_id
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #3
    adr x1, ast_str
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #4
    adr x1, ast_op
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #5
    adr x1, ast_def
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #6
    adr x1, ast_apply
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #7
    adr x1, ast_block
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #8
    adr x1, ast_infix
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #7
    adr x1, tok_lparen
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #8
    adr x1, tok_rparen
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #6
    adr x1, PREC_APPLY
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #11
    adr x1, PREC_XOR
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #12
    adr x1, PREC_OR
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #13
    adr x1, PREC_AND
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #14
    adr x1, PREC_CMP
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #15
    adr x1, PREC_ADD
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #16
    adr x1, PREC_MUL
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #20
    adr x1, PREC_PREFIX
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, streq
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_956
    tst x1, #1
    b.eq do_concat_956
do_apply_955:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_957
do_concat_956:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_957:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_953
    b after_func_958_959
func_958:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_960_961
func_960:
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
    b.eq cmp_true_965
    adr x0, sign_id
    b cmp_end_966
cmp_true_965:
cmp_end_966:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_963
    mov x0, #1
    b cond_end_964
cond_false_963:
    adr x0, sign_id
cond_end_964:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_962
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_962
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_962
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_969
    adr x0, sign_id
    b cmp_end_970
cmp_true_969:
cmp_end_970:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_967
    mov x0, #0
    b cond_end_968
cond_false_967:
    adr x0, sign_id
cond_end_968:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_962
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_973
    adr x0, sign_id
    b cmp_end_974
cmp_true_973:
cmp_end_974:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_971
    mov x0, #1
    b cond_end_972
cond_false_971:
    adr x0, sign_id
cond_end_972:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_962
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_976
    tst x1, #1
    b.eq do_concat_976
do_apply_975:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_977
do_concat_976:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_977:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_979
    tst x1, #1
    b.eq do_concat_979
do_apply_978:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_980
do_concat_979:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_980:
blk_end_962:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_960_961:
    // Closure for func_960
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_960
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_958_959:
    // Closure for func_958
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_958
    ldr x0, [sp], #16
    bl _cons
    b cond_end_954
cond_false_953:
    adr x0, sign_id
cond_end_954:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_semicolon_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_984
    tst x1, #1
    b.eq do_concat_984
do_apply_983:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_985
do_concat_984:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_985:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_981
    b after_func_986_987
func_986:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_990
    tst x1, #1
    b.eq do_concat_990
do_apply_989:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_991
do_concat_990:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_991:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #59
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    ldr x0, [x29, #-48]
blk_end_988:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_986_987:
    // Closure for func_986
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_986
    ldr x0, [sp], #16
    bl _cons
    b cond_end_982
cond_false_981:
    adr x0, sign_id
cond_end_982:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_bar_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_995
    tst x1, #1
    b.eq do_concat_995
do_apply_994:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_996
do_concat_995:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_996:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_992
    b after_func_997_998
func_997:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1001
    tst x1, #1
    b.eq do_concat_1001
do_apply_1000:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1002
do_concat_1001:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1002:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_999
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #124
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_999
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_999
    ldr x0, [x29, #-48]
blk_end_999:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_997_998:
    // Closure for func_997
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_997
    ldr x0, [sp], #16
    bl _cons
    b cond_end_993
cond_false_992:
    adr x0, sign_id
cond_end_993:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_lt_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1006
    tst x1, #1
    b.eq do_concat_1006
do_apply_1005:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1007
do_concat_1006:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1007:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1003
    b after_func_1008_1009
func_1008:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1012
    tst x1, #1
    b.eq do_concat_1012
do_apply_1011:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1013
do_concat_1012:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1013:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1010
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1010
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1010
    ldr x0, [x29, #-48]
blk_end_1010:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1008_1009:
    // Closure for func_1008
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1008
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1004
cond_false_1003:
    adr x0, sign_id
cond_end_1004:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_gt_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1017
    tst x1, #1
    b.eq do_concat_1017
do_apply_1016:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1018
do_concat_1017:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1018:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1014
    b after_func_1019_1020
func_1019:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1023
    tst x1, #1
    b.eq do_concat_1023
do_apply_1022:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1024
do_concat_1023:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1024:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1021
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1021
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1021
    ldr x0, [x29, #-48]
blk_end_1021:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1019_1020:
    // Closure for func_1019
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1019
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1015
cond_false_1014:
    adr x0, sign_id
cond_end_1015:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_prec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1028
    tst x1, #1
    b.eq do_concat_1028
do_apply_1027:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1029
do_concat_1028:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1029:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1025
    b after_func_1030_1031
func_1030:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1036
    tst x1, #1
    b.eq do_concat_1036
do_apply_1035:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1037
do_concat_1036:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1037:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1039
    tst x1, #1
    b.eq do_concat_1039
do_apply_1038:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1040
do_concat_1039:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1040:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1033
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_1034
cond_false_1033:
    adr x0, sign_id
cond_end_1034:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1044
    tst x1, #1
    b.eq do_concat_1044
do_apply_1043:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1045
do_concat_1044:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1045:
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1047
    tst x1, #1
    b.eq do_concat_1047
do_apply_1046:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1048
do_concat_1047:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1048:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1041
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_1042
cond_false_1041:
    adr x0, sign_id
cond_end_1042:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1052
    tst x1, #1
    b.eq do_concat_1052
do_apply_1051:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1053
do_concat_1052:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1053:
    str x0, [sp, #-16]!
    mov x0, #37
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1055
    tst x1, #1
    b.eq do_concat_1055
do_apply_1054:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1056
do_concat_1055:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1056:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1049
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_1050
cond_false_1049:
    adr x0, sign_id
cond_end_1050:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1060
    tst x1, #1
    b.eq do_concat_1060
do_apply_1059:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1061
do_concat_1060:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1061:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1063
    tst x1, #1
    b.eq do_concat_1063
do_apply_1062:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1064
do_concat_1063:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1064:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1057
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_1058
cond_false_1057:
    adr x0, sign_id
cond_end_1058:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1068
    tst x1, #1
    b.eq do_concat_1068
do_apply_1067:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1069
do_concat_1068:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1069:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1071
    tst x1, #1
    b.eq do_concat_1071
do_apply_1070:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1072
do_concat_1071:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1072:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1065
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_1066
cond_false_1065:
    adr x0, sign_id
cond_end_1066:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1076
    tst x1, #1
    b.eq do_concat_1076
do_apply_1075:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1077
do_concat_1076:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1077:
    str x0, [sp, #-16]!
    adr x0, get_lt_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1079
    tst x1, #1
    b.eq do_concat_1079
do_apply_1078:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1080
do_concat_1079:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1080:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1082
    tst x1, #1
    b.eq do_concat_1082
do_apply_1081:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1083
do_concat_1082:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1083:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1073
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_1074
cond_false_1073:
    adr x0, sign_id
cond_end_1074:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1087
    tst x1, #1
    b.eq do_concat_1087
do_apply_1086:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1088
do_concat_1087:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1088:
    str x0, [sp, #-16]!
    adr x0, get_gt_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1090
    tst x1, #1
    b.eq do_concat_1090
do_apply_1089:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1091
do_concat_1090:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1091:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1093
    tst x1, #1
    b.eq do_concat_1093
do_apply_1092:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1094
do_concat_1093:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1094:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1084
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_1085
cond_false_1084:
    adr x0, sign_id
cond_end_1085:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1098
    tst x1, #1
    b.eq do_concat_1098
do_apply_1097:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1099
do_concat_1098:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1099:
    str x0, [sp, #-16]!
    mov x0, #61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1101
    tst x1, #1
    b.eq do_concat_1101
do_apply_1100:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1102
do_concat_1101:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1102:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1095
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_1096
cond_false_1095:
    adr x0, sign_id
cond_end_1096:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1106
    tst x1, #1
    b.eq do_concat_1106
do_apply_1105:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1107
do_concat_1106:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1107:
    str x0, [sp, #-16]!
    adr x0, get_semicolon_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1109
    tst x1, #1
    b.eq do_concat_1109
do_apply_1108:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1110
do_concat_1109:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1110:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1112
    tst x1, #1
    b.eq do_concat_1112
do_apply_1111:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1113
do_concat_1112:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1113:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1103
    adr x0, PREC_XOR
    ldr x0, [x0]
    b cond_end_1104
cond_false_1103:
    adr x0, sign_id
cond_end_1104:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1117
    tst x1, #1
    b.eq do_concat_1117
do_apply_1116:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1118
do_concat_1117:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1118:
    str x0, [sp, #-16]!
    adr x0, get_bar_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1120
    tst x1, #1
    b.eq do_concat_1120
do_apply_1119:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1121
do_concat_1120:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1121:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1123
    tst x1, #1
    b.eq do_concat_1123
do_apply_1122:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1124
do_concat_1123:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1124:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1114
    adr x0, PREC_OR
    ldr x0, [x0]
    b cond_end_1115
cond_false_1114:
    adr x0, sign_id
cond_end_1115:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1128
    tst x1, #1
    b.eq do_concat_1128
do_apply_1127:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1129
do_concat_1128:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1129:
    str x0, [sp, #-16]!
    mov x0, #38
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1131
    tst x1, #1
    b.eq do_concat_1131
do_apply_1130:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1132
do_concat_1131:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1132:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1125
    adr x0, PREC_AND
    ldr x0, [x0]
    b cond_end_1126
cond_false_1125:
    adr x0, sign_id
cond_end_1126:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1136
    tst x1, #1
    b.eq do_concat_1136
do_apply_1135:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1137
do_concat_1136:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1137:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1139
    tst x1, #1
    b.eq do_concat_1139
do_apply_1138:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1140
do_concat_1139:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1140:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1133
    mov x0, #5
    b cond_end_1134
cond_false_1133:
    adr x0, sign_id
cond_end_1134:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1144
    tst x1, #1
    b.eq do_concat_1144
do_apply_1143:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1145
do_concat_1144:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1145:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1147
    tst x1, #1
    b.eq do_concat_1147
do_apply_1146:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1148
do_concat_1147:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1148:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1141
    mov x0, #6
    b cond_end_1142
cond_false_1141:
    adr x0, sign_id
cond_end_1142:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1152
    tst x1, #1
    b.eq do_concat_1152
do_apply_1151:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1153
do_concat_1152:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1153:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1155
    tst x1, #1
    b.eq do_concat_1155
do_apply_1154:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1156
do_concat_1155:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1156:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1149
    mov x0, #2
    b cond_end_1150
cond_false_1149:
    adr x0, sign_id
cond_end_1150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    mov x0, #0
blk_end_1032:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1030_1031:
    // Closure for func_1030
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1030
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1026
cond_false_1025:
    adr x0, sign_id
cond_end_1026:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_right_assoc
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1160
    tst x1, #1
    b.eq do_concat_1160
do_apply_1159:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1161
do_concat_1160:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1161:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1157
    b after_func_1162_1163
func_1162:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1168
    tst x1, #1
    b.eq do_concat_1168
do_apply_1167:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1169
do_concat_1168:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1169:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1171
    tst x1, #1
    b.eq do_concat_1171
do_apply_1170:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1172
do_concat_1171:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1172:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1165
    mov x0, #1
    b cond_end_1166
cond_false_1165:
    adr x0, sign_id
cond_end_1166:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1164
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1176
    tst x1, #1
    b.eq do_concat_1176
do_apply_1175:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1177
do_concat_1176:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1177:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1179
    tst x1, #1
    b.eq do_concat_1179
do_apply_1178:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1180
do_concat_1179:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1180:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1173
    mov x0, #1
    b cond_end_1174
cond_false_1173:
    adr x0, sign_id
cond_end_1174:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1164
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1184
    tst x1, #1
    b.eq do_concat_1184
do_apply_1183:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1185
do_concat_1184:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1185:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1187
    tst x1, #1
    b.eq do_concat_1187
do_apply_1186:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1188
do_concat_1187:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1188:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1181
    mov x0, #1
    b cond_end_1182
cond_false_1181:
    adr x0, sign_id
cond_end_1182:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1164
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1192
    tst x1, #1
    b.eq do_concat_1192
do_apply_1191:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1193
do_concat_1192:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1193:
    str x0, [sp, #-16]!
    mov x0, #94
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1195
    tst x1, #1
    b.eq do_concat_1195
do_apply_1194:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1196
do_concat_1195:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1196:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1189
    mov x0, #1
    b cond_end_1190
cond_false_1189:
    adr x0, sign_id
cond_end_1190:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1164
    mov x0, #0
blk_end_1164:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1162_1163:
    // Closure for func_1162
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1162
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1158
cond_false_1157:
    adr x0, sign_id
cond_end_1158:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_curr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, init_parser
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1200
    tst x1, #1
    b.eq do_concat_1200
do_apply_1199:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1201
do_concat_1200:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1201:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1197
    b after_func_1202_1203
func_1202:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p_tokens
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1204
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1206
    tst x1, #1
    b.eq do_concat_1206
do_apply_1205:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1207
do_concat_1206:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1207:
blk_end_1204:
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
    b cond_end_1198
cond_false_1197:
    adr x0, sign_id
cond_end_1198:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, advance
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1211
    tst x1, #1
    b.eq do_concat_1211
do_apply_1210:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1212
do_concat_1211:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1212:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1208
    b after_func_1213_1214
func_1213:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p_tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1218
    adr x0, sign_id
    b cmp_end_1219
cmp_true_1218:
cmp_end_1219:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1216
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, p_curr
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1222
    tst x1, #1
    b.eq do_concat_1222
do_apply_1221:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1223
do_concat_1222:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1223:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1225
    tst x1, #1
    b.eq do_concat_1225
do_apply_1224:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1226
do_concat_1225:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1226:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1220
    mov x0, #0
blk_end_1220:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1228
    tst x1, #1
    b.eq do_concat_1228
do_apply_1227:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1229
do_concat_1228:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1229:
    b cond_end_1217
cond_false_1216:
    adr x0, sign_id
cond_end_1217:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1215
    adr x0, p_curr
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, p_tokens
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1231
    tst x1, #1
    b.eq do_concat_1231
do_apply_1230:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1232
do_concat_1231:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1232:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1215
    adr x0, p_tokens
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, p_tokens
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1234
    tst x1, #1
    b.eq do_concat_1234
do_apply_1233:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1235
do_concat_1234:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1235:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1215
    adr x0, p_curr
blk_end_1215:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1213_1214:
    // Closure for func_1213
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1213
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1209
cond_false_1208:
    adr x0, sign_id
cond_end_1209:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, peek_type
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1239
    tst x1, #1
    b.eq do_concat_1239
do_apply_1238:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1240
do_concat_1239:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1240:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1236
    b after_func_1241_1242
func_1241:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1244
    tst x1, #1
    b.eq do_concat_1244
do_apply_1243:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1245
do_concat_1244:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1245:
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1241_1242:
    // Closure for func_1241
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1241
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1237
cond_false_1236:
    adr x0, sign_id
cond_end_1237:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, peek_val
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1249
    tst x1, #1
    b.eq do_concat_1249
do_apply_1248:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1250
do_concat_1249:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1250:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1246
    b after_func_1251_1252
func_1251:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1254
    tst x1, #1
    b.eq do_concat_1254
do_apply_1253:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1255
do_concat_1254:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1255:
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1251_1252:
    // Closure for func_1251
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1251
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1247
cond_false_1246:
    adr x0, sign_id
cond_end_1247:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expect_val
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1259
    tst x1, #1
    b.eq do_concat_1259
do_apply_1258:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1260
do_concat_1259:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1260:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1256
    b after_func_1261_1262
func_1261:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1265
    tst x1, #1
    b.eq do_concat_1265
do_apply_1264:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1266
do_concat_1265:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1266:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1263
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1269
    adr x0, sign_id
    b cmp_end_1270
cmp_true_1269:
cmp_end_1270:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1267
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1273
    tst x1, #1
    b.eq do_concat_1273
do_apply_1272:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1274
do_concat_1273:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1274:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1271
    mov x0, #1
blk_end_1271:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1276
    tst x1, #1
    b.eq do_concat_1276
do_apply_1275:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1277
do_concat_1276:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1277:
    b cond_end_1268
cond_false_1267:
    adr x0, sign_id
cond_end_1268:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1263
    mov x0, #0
blk_end_1263:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1261_1262:
    // Closure for func_1261
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1261
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1257
cond_false_1256:
    adr x0, sign_id
cond_end_1257:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expect_type
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1281
    tst x1, #1
    b.eq do_concat_1281
do_apply_1280:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1282
do_concat_1281:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1282:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1278
    b after_func_1283_1284
func_1283:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1287
    tst x1, #1
    b.eq do_concat_1287
do_apply_1286:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1288
do_concat_1287:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1288:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1285
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1291
    adr x0, sign_id
    b cmp_end_1292
cmp_true_1291:
cmp_end_1292:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1289
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1295
    tst x1, #1
    b.eq do_concat_1295
do_apply_1294:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1296
do_concat_1295:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1296:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1293
    mov x0, #1
blk_end_1293:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1298
    tst x1, #1
    b.eq do_concat_1298
do_apply_1297:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1299
do_concat_1298:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1299:
    b cond_end_1290
cond_false_1289:
    adr x0, sign_id
cond_end_1290:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1285
    mov x0, #0
blk_end_1285:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1283_1284:
    // Closure for func_1283
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1283
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1279
cond_false_1278:
    adr x0, sign_id
cond_end_1279:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, can_start_expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1303
    tst x1, #1
    b.eq do_concat_1303
do_apply_1302:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1304
do_concat_1303:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1304:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1300
    b after_func_1305_1306
func_1305:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1309
    tst x1, #1
    b.eq do_concat_1309
do_apply_1308:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1310
do_concat_1309:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1310:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1307
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1313
    adr x0, sign_id
    b cmp_end_1314
cmp_true_1313:
cmp_end_1314:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1311
    mov x0, #1
    b cond_end_1312
cond_false_1311:
    adr x0, sign_id
cond_end_1312:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1307
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1317
    adr x0, sign_id
    b cmp_end_1318
cmp_true_1317:
cmp_end_1318:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1315
    mov x0, #1
    b cond_end_1316
cond_false_1315:
    adr x0, sign_id
cond_end_1316:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1307
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1321
    adr x0, sign_id
    b cmp_end_1322
cmp_true_1321:
cmp_end_1322:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1319
    mov x0, #1
    b cond_end_1320
cond_false_1319:
    adr x0, sign_id
cond_end_1320:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1307
    mov x0, #0
blk_end_1307:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1305_1306:
    // Closure for func_1305
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1305
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1301
cond_false_1300:
    adr x0, sign_id
cond_end_1301:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_program
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1326
    tst x1, #1
    b.eq do_concat_1326
do_apply_1325:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1327
do_concat_1326:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1327:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1323
    b after_func_1328_1329
func_1328:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1332
    tst x1, #1
    b.eq do_concat_1332
do_apply_1331:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1333
do_concat_1332:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1333:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1330
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1336
    adr x0, sign_id
    b cmp_end_1337
cmp_true_1336:
cmp_end_1337:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1334
    mov x0, #0
    b cond_end_1335
cond_false_1334:
    adr x0, sign_id
cond_end_1335:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1330
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1340
    adr x0, sign_id
    b cmp_end_1341
cmp_true_1340:
cmp_end_1341:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1338
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1344
    tst x1, #1
    b.eq do_concat_1344
do_apply_1343:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1345
do_concat_1344:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1345:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1342
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1347
    tst x1, #1
    b.eq do_concat_1347
do_apply_1346:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1348
do_concat_1347:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1348:
blk_end_1342:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1350
    tst x1, #1
    b.eq do_concat_1350
do_apply_1349:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1351
do_concat_1350:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1351:
    b cond_end_1339
cond_false_1338:
    adr x0, sign_id
cond_end_1339:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1330
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1353
    tst x1, #1
    b.eq do_concat_1353
do_apply_1352:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1354
do_concat_1353:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1354:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1330
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1356
    tst x1, #1
    b.eq do_concat_1356
do_apply_1355:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1357
do_concat_1356:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1357:
    str x0, [sp, #-16]!
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1359
    tst x1, #1
    b.eq do_concat_1359
do_apply_1358:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1360
do_concat_1359:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1360:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1362
    tst x1, #1
    b.eq do_concat_1362
do_apply_1361:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1363
do_concat_1362:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1363:
blk_end_1330:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1328_1329:
    // Closure for func_1328
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1328
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1324
cond_false_1323:
    adr x0, sign_id
cond_end_1324:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1367
    tst x1, #1
    b.eq do_concat_1367
do_apply_1366:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1368
do_concat_1367:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1368:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1364
    b after_func_1369_1370
func_1369:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1373
    tst x1, #1
    b.eq do_concat_1373
do_apply_1372:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1374
do_concat_1373:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1374:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1371
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1377
    adr x0, sign_id
    b cmp_end_1378
cmp_true_1377:
cmp_end_1378:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1375
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1381
    tst x1, #1
    b.eq do_concat_1381
do_apply_1380:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1382
do_concat_1381:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1382:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1379
    adr x0, parse_block
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1384
    tst x1, #1
    b.eq do_concat_1384
do_apply_1383:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1385
do_concat_1384:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1385:
blk_end_1379:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1387
    tst x1, #1
    b.eq do_concat_1387
do_apply_1386:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1388
do_concat_1387:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1388:
    b cond_end_1376
cond_false_1375:
    adr x0, sign_id
cond_end_1376:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1371
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1390
    tst x1, #1
    b.eq do_concat_1390
do_apply_1389:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1391
do_concat_1390:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1391:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1371
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1393
    tst x1, #1
    b.eq do_concat_1393
do_apply_1392:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1394
do_concat_1393:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1394:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1371
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1397
    adr x0, sign_id
    b cmp_end_1398
cmp_true_1397:
cmp_end_1398:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1395
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1401
    tst x1, #1
    b.eq do_concat_1401
do_apply_1400:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1402
do_concat_1401:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1402:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1399
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1404
    tst x1, #1
    b.eq do_concat_1404
do_apply_1403:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1405
do_concat_1404:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1405:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1399
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1408
    adr x0, sign_id
    b cmp_end_1409
cmp_true_1408:
cmp_end_1409:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1406
    ldr x0, [x29, #-64]
    b cond_end_1407
cond_false_1406:
    adr x0, sign_id
cond_end_1407:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1399
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1411
    tst x1, #1
    b.eq do_concat_1411
do_apply_1410:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1412
do_concat_1411:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1412:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1414
    tst x1, #1
    b.eq do_concat_1414
do_apply_1413:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1415
do_concat_1414:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1415:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1417
    tst x1, #1
    b.eq do_concat_1417
do_apply_1416:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1418
do_concat_1417:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1418:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1420
    tst x1, #1
    b.eq do_concat_1420
do_apply_1419:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1421
do_concat_1420:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1421:
blk_end_1399:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1423
    tst x1, #1
    b.eq do_concat_1423
do_apply_1422:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1424
do_concat_1423:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1424:
    b cond_end_1396
cond_false_1395:
    adr x0, sign_id
cond_end_1396:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1371
    ldr x0, [x29, #-64]
blk_end_1371:
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
    b cond_end_1365
cond_false_1364:
    adr x0, sign_id
cond_end_1365:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block_rest
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1428
    tst x1, #1
    b.eq do_concat_1428
do_apply_1427:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1429
do_concat_1428:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1429:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1425
    b after_func_1430_1431
func_1430:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1434
    tst x1, #1
    b.eq do_concat_1434
do_apply_1433:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1435
do_concat_1434:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1435:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1432
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1438
    adr x0, sign_id
    b cmp_end_1439
cmp_true_1438:
cmp_end_1439:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1436
    mov x0, #0
    b cond_end_1437
cond_false_1436:
    adr x0, sign_id
cond_end_1437:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1432
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1442
    adr x0, sign_id
    b cmp_end_1443
cmp_true_1442:
cmp_end_1443:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1440
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Check
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1446
    tst x1, #1
    b.eq do_concat_1446
do_apply_1445:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1447
do_concat_1446:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1447:
    str x0, [sp, #-16]!
    adr x0, if
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1449
    tst x1, #1
    b.eq do_concat_1449
do_apply_1448:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1450
do_concat_1449:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1450:
    str x0, [sp, #-16]!
    adr x0, it
    str x0, [sp, #-16]!
    adr x0, str_0
    mov x1, x0
    ldr x0, [sp], #16
    bl _dict_get
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1452
    tst x1, #1
    b.eq do_concat_1452
do_apply_1451:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1453
do_concat_1452:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1453:
    str x0, [sp, #-16]!
    adr x0, a
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1455
    tst x1, #1
    b.eq do_concat_1455
do_apply_1454:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1456
do_concat_1455:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1456:
    str x0, [sp, #-16]!
    adr x0, closing
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1458
    tst x1, #1
    b.eq do_concat_1458
do_apply_1457:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1459
do_concat_1458:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1459:
    str x0, [sp, #-16]!
    adr x0, paren
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1461
    tst x1, #1
    b.eq do_concat_1461
do_apply_1460:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1462
do_concat_1461:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1462:
    str x0, [sp, #-16]!
    adr x0, or
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1464
    tst x1, #1
    b.eq do_concat_1464
do_apply_1463:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1465
do_concat_1464:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1465:
    str x0, [sp, #-16]!
    adr x0, dedent
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1467
    tst x1, #1
    b.eq do_concat_1467
do_apply_1466:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1468
do_concat_1467:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1468:
    str x0, [sp, #-16]!
    adr x0, implicit
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1470
    tst x1, #1
    b.eq do_concat_1470
do_apply_1469:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1471
do_concat_1470:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1471:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1474
    adr x0, sign_id
    b cmp_end_1475
cmp_true_1474:
cmp_end_1475:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1472
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, Also
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1476
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1478
xor_true_1476:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1477
    adr x0, sign_id
    b xor_end_1478
xor_false_1477:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, should
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1480
    tst x1, #1
    b.eq do_concat_1480
do_apply_1479:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1481
do_concat_1480:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1481:
    str x0, [sp, #-16]!
    adr x0, check
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1483
    tst x1, #1
    b.eq do_concat_1483
do_apply_1482:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1484
do_concat_1483:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1484:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1486
    tst x1, #1
    b.eq do_concat_1486
do_apply_1485:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1487
do_concat_1486:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1487:
    str x0, [sp, #-16]!
    adr x0, dedent
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1489
    tst x1, #1
    b.eq do_concat_1489
do_apply_1488:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1490
do_concat_1489:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1490:
    str x0, [sp, #-16]!
    adr x0, if
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1492
    tst x1, #1
    b.eq do_concat_1492
do_apply_1491:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1493
do_concat_1492:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1493:
    str x0, [sp, #-16]!
    adr x0, we
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1495
    tst x1, #1
    b.eq do_concat_1495
do_apply_1494:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1496
do_concat_1495:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1496:
    str x0, [sp, #-16]!
    adr x0, had
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1498
    tst x1, #1
    b.eq do_concat_1498
do_apply_1497:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1499
do_concat_1498:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1499:
    str x0, [sp, #-16]!
    adr x0, indentation
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1501
    tst x1, #1
    b.eq do_concat_1501
do_apply_1500:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1502
do_concat_1501:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1502:
    str x0, [sp, #-16]!
    adr x0, logic
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1504
    tst x1, #1
    b.eq do_concat_1504
do_apply_1503:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1505
do_concat_1504:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1505:
    b cond_end_1473
cond_false_1472:
    adr x0, sign_id
cond_end_1473:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    mov x0, #0
blk_end_1444:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1507
    tst x1, #1
    b.eq do_concat_1507
do_apply_1506:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1508
do_concat_1507:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1508:
    b cond_end_1441
cond_false_1440:
    adr x0, sign_id
cond_end_1441:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1432
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1511
    adr x0, sign_id
    b cmp_end_1512
cmp_true_1511:
cmp_end_1512:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1509
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1515
    tst x1, #1
    b.eq do_concat_1515
do_apply_1514:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1516
do_concat_1515:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1516:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1513
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1518
    tst x1, #1
    b.eq do_concat_1518
do_apply_1517:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1519
do_concat_1518:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1519:
blk_end_1513:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1521
    tst x1, #1
    b.eq do_concat_1521
do_apply_1520:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1522
do_concat_1521:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1522:
    b cond_end_1510
cond_false_1509:
    adr x0, sign_id
cond_end_1510:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1432
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1524
    tst x1, #1
    b.eq do_concat_1524
do_apply_1523:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1525
do_concat_1524:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1525:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1432
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1527
    tst x1, #1
    b.eq do_concat_1527
do_apply_1526:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1528
do_concat_1527:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1528:
    str x0, [sp, #-16]!
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1530
    tst x1, #1
    b.eq do_concat_1530
do_apply_1529:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1531
do_concat_1530:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1531:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1533
    tst x1, #1
    b.eq do_concat_1533
do_apply_1532:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1534
do_concat_1533:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1534:
blk_end_1432:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1430_1431:
    // Closure for func_1430
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1430
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1426
cond_false_1425:
    adr x0, sign_id
cond_end_1426:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1538
    tst x1, #1
    b.eq do_concat_1538
do_apply_1537:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1539
do_concat_1538:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1539:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1535
    b after_func_1540_1541
func_1540:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, parse_primary
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1544
    tst x1, #1
    b.eq do_concat_1544
do_apply_1543:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1545
do_concat_1544:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1545:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1542
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1547
    tst x1, #1
    b.eq do_concat_1547
do_apply_1546:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1548
do_concat_1547:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1548:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1550
    tst x1, #1
    b.eq do_concat_1550
do_apply_1549:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1551
do_concat_1550:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1551:
blk_end_1542:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1540_1541:
    // Closure for func_1540
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1540
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1536
cond_false_1535:
    adr x0, sign_id
cond_end_1536:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1555
    tst x1, #1
    b.eq do_concat_1555
do_apply_1554:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1556
do_concat_1555:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1556:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1552
    b after_func_1557_1558
func_1557:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1559_1560
func_1559:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, can_start_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1563
    tst x1, #1
    b.eq do_concat_1563
do_apply_1562:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1564
do_concat_1563:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1564:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    ldr x0, [x29, #-64]
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1567
    adr x0, PREC_APPLY
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1569
    adr x0, sign_id
    b cmp_end_1570
cmp_true_1569:
cmp_end_1570:
    b and_end_1568
and_fail_1567:
    adr x0, sign_id
and_end_1568:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1565
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, PREC_APPLY
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1573
    tst x1, #1
    b.eq do_concat_1573
do_apply_1572:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1574
do_concat_1573:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1574:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1571
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1576
    tst x1, #1
    b.eq do_concat_1576
do_apply_1575:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1577
do_concat_1576:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1577:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1579
    tst x1, #1
    b.eq do_concat_1579
do_apply_1578:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1580
do_concat_1579:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1580:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1582
    tst x1, #1
    b.eq do_concat_1582
do_apply_1581:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1583
do_concat_1582:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1583:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1585
    tst x1, #1
    b.eq do_concat_1585
do_apply_1584:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1586
do_concat_1585:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1586:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1588
    tst x1, #1
    b.eq do_concat_1588
do_apply_1587:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1589
do_concat_1588:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1589:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1591
    tst x1, #1
    b.eq do_concat_1591
do_apply_1590:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1592
do_concat_1591:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1592:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1571
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1594
    tst x1, #1
    b.eq do_concat_1594
do_apply_1593:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1595
do_concat_1594:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1595:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1597
    tst x1, #1
    b.eq do_concat_1597
do_apply_1596:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1598
do_concat_1597:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1598:
blk_end_1571:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1600
    tst x1, #1
    b.eq do_concat_1600
do_apply_1599:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1601
do_concat_1600:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1601:
    b cond_end_1566
cond_false_1565:
    adr x0, sign_id
cond_end_1566:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1603
    tst x1, #1
    b.eq do_concat_1603
do_apply_1602:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1604
do_concat_1603:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1604:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1607
    adr x0, sign_id
    b cmp_end_1608
cmp_true_1607:
cmp_end_1608:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1605
    ldr x0, [x29, #-48]
    b cond_end_1606
cond_false_1605:
    adr x0, sign_id
cond_end_1606:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1610
    tst x1, #1
    b.eq do_concat_1610
do_apply_1609:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1611
do_concat_1610:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1611:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    adr x0, get_prec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1613
    tst x1, #1
    b.eq do_concat_1613
do_apply_1612:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1614
do_concat_1613:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1614:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1617
    adr x0, sign_id
    b cmp_end_1618
cmp_true_1617:
cmp_end_1618:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1615
    ldr x0, [x29, #-48]
    b cond_end_1616
cond_false_1615:
    adr x0, sign_id
cond_end_1616:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1620
    tst x1, #1
    b.eq do_concat_1620
do_apply_1619:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1621
do_concat_1620:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1621:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    b after_next_min_prec_impl_1622
next_min_prec_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1623_1624
func_1623:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1626
    tst x1, #1
    b.eq do_concat_1626
do_apply_1625:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1627
do_concat_1626:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1627:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1623_1624:
    // Closure for func_1623
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1623
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_next_min_prec_impl_1622:
    // Closure for next_min_prec_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, next_min_prec_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, next_min_prec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1629
    tst x1, #1
    b.eq do_concat_1629
do_apply_1628:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1630
do_concat_1629:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1630:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1632
    tst x1, #1
    b.eq do_concat_1632
do_apply_1631:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1633
do_concat_1632:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1633:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1635
    tst x1, #1
    b.eq do_concat_1635
do_apply_1634:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1636
do_concat_1635:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1636:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1638
    tst x1, #1
    b.eq do_concat_1638
do_apply_1637:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1639
do_concat_1638:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1639:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1641
    tst x1, #1
    b.eq do_concat_1641
do_apply_1640:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1642
do_concat_1641:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1642:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1644
    tst x1, #1
    b.eq do_concat_1644
do_apply_1643:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1645
do_concat_1644:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1645:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1647
    tst x1, #1
    b.eq do_concat_1647
do_apply_1646:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1648
do_concat_1647:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1648:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1650
    tst x1, #1
    b.eq do_concat_1650
do_apply_1649:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1651
do_concat_1650:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1651:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1653
    tst x1, #1
    b.eq do_concat_1653
do_apply_1652:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1654
do_concat_1653:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1654:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1561
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1656
    tst x1, #1
    b.eq do_concat_1656
do_apply_1655:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1657
do_concat_1656:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1657:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1659
    tst x1, #1
    b.eq do_concat_1659
do_apply_1658:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1660
do_concat_1659:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1660:
blk_end_1561:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1559_1560:
    // Closure for func_1559
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1559
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1557_1558:
    // Closure for func_1557
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1557
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1553
cond_false_1552:
    adr x0, sign_id
cond_end_1553:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_primary
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1664
    tst x1, #1
    b.eq do_concat_1664
do_apply_1663:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1665
do_concat_1664:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1665:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1661
    b after_func_1666_1667
func_1666:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1670
    tst x1, #1
    b.eq do_concat_1670
do_apply_1669:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1671
do_concat_1670:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1671:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1668
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1673
    tst x1, #1
    b.eq do_concat_1673
do_apply_1672:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1674
do_concat_1673:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1674:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1668
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1677
    adr x0, sign_id
    b cmp_end_1678
cmp_true_1677:
cmp_end_1678:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1675
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1681
    tst x1, #1
    b.eq do_concat_1681
do_apply_1680:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1682
do_concat_1681:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1682:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1679
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1684
    tst x1, #1
    b.eq do_concat_1684
do_apply_1683:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1685
do_concat_1684:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1685:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1687
    tst x1, #1
    b.eq do_concat_1687
do_apply_1686:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1688
do_concat_1687:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1688:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1690
    tst x1, #1
    b.eq do_concat_1690
do_apply_1689:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1691
do_concat_1690:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1691:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1693
    tst x1, #1
    b.eq do_concat_1693
do_apply_1692:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1694
do_concat_1693:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1694:
blk_end_1679:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1696
    tst x1, #1
    b.eq do_concat_1696
do_apply_1695:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1697
do_concat_1696:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1697:
    b cond_end_1676
cond_false_1675:
    adr x0, sign_id
cond_end_1676:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1668
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1700
    adr x0, sign_id
    b cmp_end_1701
cmp_true_1700:
cmp_end_1701:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1698
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1704
    tst x1, #1
    b.eq do_concat_1704
do_apply_1703:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1705
do_concat_1704:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1705:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1702
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1707
    tst x1, #1
    b.eq do_concat_1707
do_apply_1706:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1708
do_concat_1707:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1708:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1710
    tst x1, #1
    b.eq do_concat_1710
do_apply_1709:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1711
do_concat_1710:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1711:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1713
    tst x1, #1
    b.eq do_concat_1713
do_apply_1712:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1714
do_concat_1713:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1714:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1716
    tst x1, #1
    b.eq do_concat_1716
do_apply_1715:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1717
do_concat_1716:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1717:
blk_end_1702:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1719
    tst x1, #1
    b.eq do_concat_1719
do_apply_1718:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1720
do_concat_1719:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1720:
    b cond_end_1699
cond_false_1698:
    adr x0, sign_id
cond_end_1699:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1668
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1723
    adr x0, sign_id
    b cmp_end_1724
cmp_true_1723:
cmp_end_1724:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1721
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1727
    tst x1, #1
    b.eq do_concat_1727
do_apply_1726:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1728
do_concat_1727:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1728:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1725
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1730
    tst x1, #1
    b.eq do_concat_1730
do_apply_1729:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1731
do_concat_1730:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1731:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1725
    adr x0, expect_type
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1733
    tst x1, #1
    b.eq do_concat_1733
do_apply_1732:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1734
do_concat_1733:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1734:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1725
    ldr x0, [x29, #-80]
blk_end_1725:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1736
    tst x1, #1
    b.eq do_concat_1736
do_apply_1735:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1737
do_concat_1736:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1737:
    b cond_end_1722
cond_false_1721:
    adr x0, sign_id
cond_end_1722:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1668
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1739
    tst x1, #1
    b.eq do_concat_1739
do_apply_1738:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1740
do_concat_1739:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1740:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #999
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1742
    tst x1, #1
    b.eq do_concat_1742
do_apply_1741:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1743
do_concat_1742:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1743:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1745
    tst x1, #1
    b.eq do_concat_1745
do_apply_1744:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1746
do_concat_1745:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1746:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1748
    tst x1, #1
    b.eq do_concat_1748
do_apply_1747:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1749
do_concat_1748:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1749:
blk_end_1668:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1666_1667:
    // Closure for func_1666
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1666
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1662
cond_false_1661:
    adr x0, sign_id
cond_end_1662:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Self
    str x0, [sp, #-16]!
    adr x0, Hosting
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1751
    tst x1, #1
    b.eq do_concat_1751
do_apply_1750:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1752
do_concat_1751:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1752:
    str x0, [sp, #-16]!
    adr x0, Compiler
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1754
    tst x1, #1
    b.eq do_concat_1754
do_apply_1753:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1755
do_concat_1754:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1755:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Compiles
    str x0, [sp, #-16]!
    adr x0, AST
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1757
    tst x1, #1
    b.eq do_concat_1757
do_apply_1756:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1758
do_concat_1757:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1758:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1760
    tst x1, #1
    b.eq do_concat_1760
do_apply_1759:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1761
do_concat_1760:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1761:
    str x0, [sp, #-16]!
    adr x0, AArch64
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1763
    tst x1, #1
    b.eq do_concat_1763
do_apply_1762:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1764
do_concat_1763:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1764:
    str x0, [sp, #-16]!
    adr x0, Assembly
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1766
    tst x1, #1
    b.eq do_concat_1766
do_apply_1765:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1767
do_concat_1766:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1767:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, str_len
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1771
    tst x1, #1
    b.eq do_concat_1771
do_apply_1770:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1772
do_concat_1771:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1772:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1768
    b after_func_1773_1774
func_1773:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1775
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1778
    adr x0, sign_id
    b cmp_end_1779
cmp_true_1778:
cmp_end_1779:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1776
    mov x0, #0
    b cond_end_1777
cond_false_1776:
    adr x0, sign_id
cond_end_1777:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1775
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, str_len
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1781
    tst x1, #1
    b.eq do_concat_1781
do_apply_1780:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1782
do_concat_1781:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1782:
blk_end_1775:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1773_1774:
    // Closure for func_1773
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1773
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1769
cond_false_1768:
    adr x0, sign_id
cond_end_1769:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, str_cpy
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1786
    tst x1, #1
    b.eq do_concat_1786
do_apply_1785:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1787
do_concat_1786:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1787:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1783
    b after_func_1788_1789
func_1788:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1790_1791
func_1790:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1792
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1795
    adr x0, sign_id
    b cmp_end_1796
cmp_true_1795:
cmp_end_1796:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1793
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1797
    ldr x0, [x29, #-48]
blk_end_1797:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1799
    tst x1, #1
    b.eq do_concat_1799
do_apply_1798:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1800
do_concat_1799:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1800:
    b cond_end_1794
cond_false_1793:
    adr x0, sign_id
cond_end_1794:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1792
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1792
    adr x0, str_cpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1802
    tst x1, #1
    b.eq do_concat_1802
do_apply_1801:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1803
do_concat_1802:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1803:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1805
    tst x1, #1
    b.eq do_concat_1805
do_apply_1804:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1806
do_concat_1805:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1806:
blk_end_1792:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1790_1791:
    // Closure for func_1790
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1790
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1788_1789:
    // Closure for func_1788
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1788
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1784
cond_false_1783:
    adr x0, sign_id
cond_end_1784:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, str_cat
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1810
    tst x1, #1
    b.eq do_concat_1810
do_apply_1809:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1811
do_concat_1810:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1811:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1807
    b after_func_1812_1813
func_1812:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1814_1815
func_1814:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, str_len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1818
    tst x1, #1
    b.eq do_concat_1818
do_apply_1817:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1819
do_concat_1818:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1819:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1816
    adr x0, str_len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1821
    tst x1, #1
    b.eq do_concat_1821
do_apply_1820:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1822
do_concat_1821:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1822:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1816
    adr x0, alloc
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1824
    tst x1, #1
    b.eq do_concat_1824
do_apply_1823:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1825
do_concat_1824:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1825:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1816
    adr x0, str_cpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1827
    tst x1, #1
    b.eq do_concat_1827
do_apply_1826:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1828
do_concat_1827:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1828:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, end_s1
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1829
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1831
xor_true_1829:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1830
    adr x0, sign_id
    b xor_end_1831
xor_false_1830:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1833
    tst x1, #1
    b.eq do_concat_1833
do_apply_1832:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1834
do_concat_1833:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1834:
    str x0, [sp, #-16]!
    adr x0, points
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1836
    tst x1, #1
    b.eq do_concat_1836
do_apply_1835:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1837
do_concat_1836:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1837:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1839
    tst x1, #1
    b.eq do_concat_1839
do_apply_1838:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1840
do_concat_1839:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1840:
    str x0, [sp, #-16]!
    adr x0, null
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1842
    tst x1, #1
    b.eq do_concat_1842
do_apply_1841:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1843
do_concat_1842:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1843:
    str x0, [sp, #-16]!
    adr x0, terminator
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1845
    tst x1, #1
    b.eq do_concat_1845
do_apply_1844:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1846
do_concat_1845:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1846:
    str x0, [sp, #-16]!
    adr x0, of
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1848
    tst x1, #1
    b.eq do_concat_1848
do_apply_1847:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1849
do_concat_1848:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1849:
    str x0, [sp, #-16]!
    adr x0, first
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1851
    tst x1, #1
    b.eq do_concat_1851
do_apply_1850:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1852
do_concat_1851:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1852:
    str x0, [sp, #-16]!
    adr x0, copy
    str x0, [sp, #-16]!
    adr x0, str_cpy
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1853
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1855
xor_true_1853:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1854
    adr x0, sign_id
    b xor_end_1855
xor_false_1854:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1857
    tst x1, #1
    b.eq do_concat_1857
do_apply_1856:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1858
do_concat_1857:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1858:
    str x0, [sp, #-16]!
    adr x0, returns
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1860
    tst x1, #1
    b.eq do_concat_1860
do_apply_1859:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1861
do_concat_1860:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1861:
    str x0, [sp, #-16]!
    adr x0, pointer
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1863
    tst x1, #1
    b.eq do_concat_1863
do_apply_1862:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1864
do_concat_1863:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1864:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1866
    tst x1, #1
    b.eq do_concat_1866
do_apply_1865:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1867
do_concat_1866:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1867:
    str x0, [sp, #-16]!
    adr x0, null
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1869
    tst x1, #1
    b.eq do_concat_1869
do_apply_1868:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1870
do_concat_1869:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1870:
    str x0, [sp, #-16]!
    adr x0, terminator
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1872
    tst x1, #1
    b.eq do_concat_1872
do_apply_1871:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1873
do_concat_1872:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1873:
    str x0, [sp, #-16]!
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, My
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1874
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1876
xor_true_1874:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1875
    adr x0, sign_id
    b xor_end_1876
xor_false_1875:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1878
    tst x1, #1
    b.eq do_concat_1878
do_apply_1877:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1879
do_concat_1878:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1879:
    str x0, [sp, #-16]!
    adr x0, impl
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1881
    tst x1, #1
    b.eq do_concat_1881
do_apply_1880:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1882
do_concat_1881:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1882:
    str x0, [sp, #-16]!
    adr x0, above
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1884
    tst x1, #1
    b.eq do_concat_1884
do_apply_1883:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1885
do_concat_1884:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1885:
    str x0, [sp, #-16]!
    adr x0, returns
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1887
    tst x1, #1
    b.eq do_concat_1887
do_apply_1886:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1888
do_concat_1887:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1888:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1890
    tst x1, #1
    b.eq do_concat_1890
do_apply_1889:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1891
do_concat_1890:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1891:
    str x0, [sp, #-16]!
    adr x0, ptr
    str x0, [sp, #-16]!
    adr x0, to
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1893
    tst x1, #1
    b.eq do_concat_1893
do_apply_1892:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1894
do_concat_1893:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1894:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1896
    tst x1, #1
    b.eq do_concat_1896
do_apply_1895:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1897
do_concat_1896:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1897:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1899
    tst x1, #1
    b.eq do_concat_1899
do_apply_1898:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1900
do_concat_1899:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1900:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, So
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1901
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1903
xor_true_1901:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1902
    adr x0, sign_id
    b xor_end_1903
xor_false_1902:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1905
    tst x1, #1
    b.eq do_concat_1905
do_apply_1904:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1906
do_concat_1905:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1906:
    str x0, [sp, #-16]!
    adr x0, we
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1908
    tst x1, #1
    b.eq do_concat_1908
do_apply_1907:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1909
do_concat_1908:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1909:
    str x0, [sp, #-16]!
    adr x0, can
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1911
    tst x1, #1
    b.eq do_concat_1911
do_apply_1910:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1912
do_concat_1911:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1912:
    str x0, [sp, #-16]!
    adr x0, chain
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1914
    tst x1, #1
    b.eq do_concat_1914
do_apply_1913:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1915
do_concat_1914:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1915:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1917
    tst x1, #1
    b.eq do_concat_1917
do_apply_1916:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1918
do_concat_1917:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1918:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1816
    adr x0, str_cpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1920
    tst x1, #1
    b.eq do_concat_1920
do_apply_1919:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1921
do_concat_1920:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1921:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1923
    tst x1, #1
    b.eq do_concat_1923
do_apply_1922:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1924
do_concat_1923:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1924:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1816
    ldr x0, [x29, #-96]
blk_end_1816:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1814_1815:
    // Closure for func_1814
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1814
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1812_1813:
    // Closure for func_1812
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1812
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1808
cond_false_1807:
    adr x0, sign_id
cond_end_1808:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, int_to_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1928
    tst x1, #1
    b.eq do_concat_1928
do_apply_1927:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1929
do_concat_1928:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1929:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1925
    b after_func_1930_1931
func_1930:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1935
    adr x0, sign_id
    b cmp_end_1936
cmp_true_1935:
cmp_end_1936:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1933
    mov x0, #48
    b cond_end_1934
cond_false_1933:
    adr x0, sign_id
cond_end_1934:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1932
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1939
    adr x0, sign_id
    b cmp_end_1940
cmp_true_1939:
cmp_end_1940:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1937
    adr x0, str_cat
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1942
    tst x1, #1
    b.eq do_concat_1942
do_apply_1941:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1943
do_concat_1942:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1943:
    str x0, [sp, #-16]!
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1945
    tst x1, #1
    b.eq do_concat_1945
do_apply_1944:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1946
do_concat_1945:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1946:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1948
    tst x1, #1
    b.eq do_concat_1948
do_apply_1947:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1949
do_concat_1948:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1949:
    b cond_end_1938
cond_false_1937:
    adr x0, sign_id
cond_end_1938:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1932
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1951
    tst x1, #1
    b.eq do_concat_1951
do_apply_1950:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1952
do_concat_1951:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1952:
blk_end_1932:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1930_1931:
    // Closure for func_1930
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1930
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1926
cond_false_1925:
    adr x0, sign_id
cond_end_1926:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, int_to_str_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1956
    tst x1, #1
    b.eq do_concat_1956
do_apply_1955:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1957
do_concat_1956:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1957:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1953
    b after_func_1958_1959
func_1958:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1963
    adr x0, sign_id
    b cmp_end_1964
cmp_true_1963:
cmp_end_1964:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1961
    adr x0, str_2
    b cond_end_1962
cond_false_1961:
    adr x0, sign_id
cond_end_1962:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1960
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1966
    tst x1, #1
    b.eq do_concat_1966
do_apply_1965:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1967
do_concat_1966:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1967:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1960
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    adr x0, Append
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1973
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1975
xor_true_1973:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1974
    adr x0, sign_id
    b xor_end_1975
xor_false_1974:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, digit
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1977
    tst x1, #1
    b.eq do_concat_1977
do_apply_1976:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1978
do_concat_1977:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1978:
    str x0, [sp, #-16]!
    adr x0, char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1980
    tst x1, #1
    b.eq do_concat_1980
do_apply_1979:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1981
do_concat_1980:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1981:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1983
    tst x1, #1
    b.eq do_concat_1983
do_apply_1982:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1984
do_concat_1983:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1984:
    str x0, [sp, #-16]!
    adr x0, string
    str x0, [sp, #-16]!
    adr x0, Since
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1985
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1987
xor_true_1985:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1986
    adr x0, sign_id
    b xor_end_1987
xor_false_1986:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1989
    tst x1, #1
    b.eq do_concat_1989
do_apply_1988:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1990
do_concat_1989:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1990:
    str x0, [sp, #-16]!
    adr x0, we
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1992
    tst x1, #1
    b.eq do_concat_1992
do_apply_1991:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1993
do_concat_1992:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1993:
    str x0, [sp, #-16]!
    adr x0, don
    str x0, [sp, #-16]!
    adr x0, str_3
    mov x1, x0
    ldr x0, [sp], #16
    bl _dict_get
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1995
    tst x1, #1
    b.eq do_concat_1995
do_apply_1994:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1996
do_concat_1995:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1996:
    str x0, [sp, #-16]!
    adr x0, have
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1998
    tst x1, #1
    b.eq do_concat_1998
do_apply_1997:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1999
do_concat_1998:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1999:
    str x0, [sp, #-16]!
    adr x0, mutable
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2001
    tst x1, #1
    b.eq do_concat_2001
do_apply_2000:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2002
do_concat_2001:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2002:
    str x0, [sp, #-16]!
    adr x0, buffer
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2004
    tst x1, #1
    b.eq do_concat_2004
do_apply_2003:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2005
do_concat_2004:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2005:
    str x0, [sp, #-16]!
    adr x0, easily
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2007
    tst x1, #1
    b.eq do_concat_2007
do_apply_2006:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2008
do_concat_2007:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2008:
    str x0, [sp, #-16]!
    adr x0, in
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2010
    tst x1, #1
    b.eq do_concat_2010
do_apply_2009:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2011
do_concat_2010:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2011:
    str x0, [sp, #-16]!
    adr x0, functional
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2013
    tst x1, #1
    b.eq do_concat_2013
do_apply_2012:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2014
do_concat_2013:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2014:
    str x0, [sp, #-16]!
    adr x0, style
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2016
    tst x1, #1
    b.eq do_concat_2016
do_apply_2015:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2017
do_concat_2016:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2017:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, we
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1970
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1972
xor_true_1970:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1971
    adr x0, sign_id
    b xor_end_1972
xor_false_1971:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, might
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2019
    tst x1, #1
    b.eq do_concat_2019
do_apply_2018:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2020
do_concat_2019:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2020:
    str x0, [sp, #-16]!
    adr x0, recurse
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2022
    tst x1, #1
    b.eq do_concat_2022
do_apply_2021:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2023
do_concat_2022:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2023:
    str x0, [sp, #-16]!
    adr x0, differently
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2025
    tst x1, #1
    b.eq do_concat_2025
do_apply_2024:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2026
do_concat_2025:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2026:
    str x0, [sp, #-16]!
    adr x0, or
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2028
    tst x1, #1
    b.eq do_concat_2028
do_apply_2027:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2029
do_concat_2028:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2029:
    str x0, [sp, #-16]!
    adr x0, stick
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2031
    tst x1, #1
    b.eq do_concat_2031
do_apply_2030:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2032
do_concat_2031:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2032:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2034
    tst x1, #1
    b.eq do_concat_2034
do_apply_2033:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2035
do_concat_2034:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2035:
    str x0, [sp, #-16]!
    adr x0, str_cat
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2037
    tst x1, #1
    b.eq do_concat_2037
do_apply_2036:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2038
do_concat_2037:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2038:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, str_cat
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2039
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2041
xor_true_2039:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2040
    adr x0, sign_id
    b xor_end_2041
xor_false_2040:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2043
    tst x1, #1
    b.eq do_concat_2043
do_apply_2042:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2044
do_concat_2043:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2044:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2046
    tst x1, #1
    b.eq do_concat_2046
do_apply_2045:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2047
do_concat_2046:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2047:
    str x0, [sp, #-16]!
    adr x0, expensive
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2049
    tst x1, #1
    b.eq do_concat_2049
do_apply_2048:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2050
do_concat_2049:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2050:
    str x0, [sp, #-16]!
    adr x0, allocs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2052
    tst x1, #1
    b.eq do_concat_2052
do_apply_2051:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2053
do_concat_2052:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2053:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Optimization
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2054
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2056
xor_true_2054:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2055
    adr x0, sign_id
    b xor_end_2056
xor_false_2055:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2058
    tst x1, #1
    b.eq do_concat_2058
do_apply_2057:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2059
do_concat_2058:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2059:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1968
    adr x0, Use
    str x0, [sp, #-16]!
    adr x0, a
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2061
    tst x1, #1
    b.eq do_concat_2061
do_apply_2060:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2062
do_concat_2061:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2062:
    str x0, [sp, #-16]!
    adr x0, local
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2064
    tst x1, #1
    b.eq do_concat_2064
do_apply_2063:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2065
do_concat_2064:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2065:
    str x0, [sp, #-16]!
    adr x0, buffer
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2067
    tst x1, #1
    b.eq do_concat_2067
do_apply_2066:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2068
do_concat_2067:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2068:
    str x0, [sp, #-16]!
    adr x0, or
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2070
    tst x1, #1
    b.eq do_concat_2070
do_apply_2069:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2071
do_concat_2070:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2071:
    str x0, [sp, #-16]!
    adr x0, list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2073
    tst x1, #1
    b.eq do_concat_2073
do_apply_2072:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2074
do_concat_2073:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2074:
    str x0, [sp, #-16]!
    adr x0, then
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2076
    tst x1, #1
    b.eq do_concat_2076
do_apply_2075:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2077
do_concat_2076:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2077:
    str x0, [sp, #-16]!
    adr x0, convert
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2079
    tst x1, #1
    b.eq do_concat_2079
do_apply_2078:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2080
do_concat_2079:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2080:
    str x0, [sp, #-16]!
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, For
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2081
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2083
xor_true_2081:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2082
    adr x0, sign_id
    b xor_end_2083
xor_false_2082:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2085
    tst x1, #1
    b.eq do_concat_2085
do_apply_2084:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2086
do_concat_2085:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2086:
    str x0, [sp, #-16]!
    adr x0, now
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2088
    tst x1, #1
    b.eq do_concat_2088
do_apply_2087:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2089
do_concat_2088:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2089:
    str x0, [sp, #-16]!
    adr x0, use
    str x0, [sp, #-16]!
    adr x0, str_cat
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2091
    tst x1, #1
    b.eq do_concat_2091
do_apply_2090:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2092
do_concat_2091:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2092:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2094
    tst x1, #1
    b.eq do_concat_2094
do_apply_2093:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2095
do_concat_2094:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2095:
    str x0, [sp, #-16]!
    adr x0, correctness
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2097
    tst x1, #1
    b.eq do_concat_2097
do_apply_2096:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2098
do_concat_2097:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2098:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2100
    tst x1, #1
    b.eq do_concat_2100
do_apply_2099:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2101
do_concat_2100:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2101:
    ldr x1, [sp], #16
    bl _cons
    b cond_end_1969
cond_false_1968:
    adr x0, sign_id
cond_end_1969:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1960
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2103
    tst x1, #1
    b.eq do_concat_2103
do_apply_2102:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2104
do_concat_2103:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2104:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1960
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1960
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1960
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2106
    tst x1, #1
    b.eq do_concat_2106
do_apply_2105:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2107
do_concat_2106:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2107:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2109
    tst x1, #1
    b.eq do_concat_2109
do_apply_2108:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2110
do_concat_2109:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2110:
blk_end_1960:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1958_1959:
    // Closure for func_1958
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1958
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1954
cond_false_1953:
    adr x0, sign_id
cond_end_1954:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_program
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2114
    tst x1, #1
    b.eq do_concat_2114
do_apply_2113:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2115
do_concat_2114:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2115:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2111
    b after_func_2116_2117
func_2116:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2121
    adr x0, sign_id
    b cmp_end_2122
cmp_true_2121:
cmp_end_2122:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2119
    adr x0, str_2
    b cond_end_2120
cond_false_2119:
    adr x0, sign_id
cond_end_2120:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2118
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, Check
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2123
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2125
xor_true_2123:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2124
    adr x0, sign_id
    b xor_end_2125
xor_false_2124:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, if
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2127
    tst x1, #1
    b.eq do_concat_2127
do_apply_2126:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2128
do_concat_2127:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2128:
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2130
    tst x1, #1
    b.eq do_concat_2130
do_apply_2129:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2131
do_concat_2130:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2131:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2133
    tst x1, #1
    b.eq do_concat_2133
do_apply_2132:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2134
do_concat_2133:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2134:
    str x0, [sp, #-16]!
    adr x0, definition
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2136
    tst x1, #1
    b.eq do_concat_2136
do_apply_2135:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2137
do_concat_2136:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2137:
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2139
    tst x1, #1
    b.eq do_concat_2139
do_apply_2138:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2140
do_concat_2139:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2140:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2118
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2118
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2143
    adr x0, sign_id
    b cmp_end_2144
cmp_true_2143:
cmp_end_2144:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2141
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2148
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2152
    tst x1, #1
    b.eq do_concat_2152
do_apply_2151:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2153
do_concat_2152:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2153:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2155
    tst x1, #1
    b.eq do_concat_2155
do_apply_2154:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2156
do_concat_2155:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2156:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2149
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_global_def
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2159
    tst x1, #1
    b.eq do_concat_2159
do_apply_2158:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2160
do_concat_2159:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2160:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2157
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2162
    tst x1, #1
    b.eq do_concat_2162
do_apply_2161:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2163
do_concat_2162:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2163:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2165
    tst x1, #1
    b.eq do_concat_2165
do_apply_2164:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2166
do_concat_2165:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2166:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2157
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2168
    tst x1, #1
    b.eq do_concat_2168
do_apply_2167:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2169
do_concat_2168:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2169:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2171
    tst x1, #1
    b.eq do_concat_2171
do_apply_2170:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2172
do_concat_2171:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2172:
blk_end_2157:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2174
    tst x1, #1
    b.eq do_concat_2174
do_apply_2173:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2175
do_concat_2174:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2175:
    b cond_end_2150
cond_false_2149:
    adr x0, sign_id
cond_end_2150:
blk_end_2148:
    str x0, [sp, #-16]!
    adr x0, Skip
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2145
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2147
xor_true_2145:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2146
    adr x0, sign_id
    b xor_end_2147
xor_false_2146:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2177
    tst x1, #1
    b.eq do_concat_2177
do_apply_2176:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2178
do_concat_2177:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2178:
    str x0, [sp, #-16]!
    adr x0, non
    str x0, [sp, #-16]!
    adr x0, definitions
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2180
    tst x1, #1
    b.eq do_concat_2180
do_apply_2179:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2181
do_concat_2180:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2181:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2183
    tst x1, #1
    b.eq do_concat_2183
do_apply_2182:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2184
do_concat_2183:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2184:
    str x0, [sp, #-16]!
    adr x0, now
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2186
    tst x1, #1
    b.eq do_concat_2186
do_apply_2185:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2187
do_concat_2186:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2187:
    b cond_end_2142
cond_false_2141:
    adr x0, sign_id
cond_end_2142:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2118
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2189
    tst x1, #1
    b.eq do_concat_2189
do_apply_2188:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2190
do_concat_2189:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2190:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2192
    tst x1, #1
    b.eq do_concat_2192
do_apply_2191:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2193
do_concat_2192:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2193:
blk_end_2118:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2116_2117:
    // Closure for func_2116
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2116
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2112
cond_false_2111:
    adr x0, sign_id
cond_end_2112:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_global_def
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2197
    tst x1, #1
    b.eq do_concat_2197
do_apply_2196:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2198
do_concat_2197:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2198:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2194
    b after_func_2199_2200
func_2199:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2201
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2202
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2204
xor_true_2202:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2203
    adr x0, sign_id
    b xor_end_2204
xor_false_2203:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, should
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2206
    tst x1, #1
    b.eq do_concat_2206
do_apply_2205:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2207
do_concat_2206:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2207:
    str x0, [sp, #-16]!
    adr x0, be
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2209
    tst x1, #1
    b.eq do_concat_2209
do_apply_2208:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2210
do_concat_2209:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2210:
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2212
    tst x1, #1
    b.eq do_concat_2212
do_apply_2211:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2213
do_concat_2212:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2213:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2215
    tst x1, #1
    b.eq do_concat_2215
do_apply_2214:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2216
do_concat_2215:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2216:
    str x0, [sp, #-16]!
    adr x0, function
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2218
    tst x1, #1
    b.eq do_concat_2218
do_apply_2217:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2219
do_concat_2218:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2219:
    str x0, [sp, #-16]!
    adr x0, name
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2221
    tst x1, #1
    b.eq do_concat_2221
do_apply_2220:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2222
do_concat_2221:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2222:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2201
    b after_name_impl_2223
name_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_2224_2225
func_2224:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2226_2227
func_2226:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2228_2229
func_2228:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, for
    str x0, [sp, #-16]!
    adr x0, function
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2231
    tst x1, #1
    b.eq do_concat_2231
do_apply_2230:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2232
do_concat_2231:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2232:
    str x0, [sp, #-16]!
    adr x0, body
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2234
    tst x1, #1
    b.eq do_concat_2234
do_apply_2233:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2235
do_concat_2234:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2235:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2228_2229:
    // Closure for func_2228
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2228
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2226_2227:
    // Closure for func_2226
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2226
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2224_2225:
    // Closure for func_2224
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2224
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_name_impl_2223:
    // Closure for name_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, name_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2201
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2201
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2238
    adr x0, sign_id
    b cmp_end_2239
cmp_true_2238:
cmp_end_2239:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2236
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2240
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2244
    tst x1, #1
    b.eq do_concat_2244
do_apply_2243:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2245
do_concat_2244:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2245:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2247
    tst x1, #1
    b.eq do_concat_2247
do_apply_2246:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2248
do_concat_2247:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2248:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2241
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_function_def
    str x0, [sp, #-16]!
    adr x0, name
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2250
    tst x1, #1
    b.eq do_concat_2250
do_apply_2249:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2251
do_concat_2250:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2251:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2253
    tst x1, #1
    b.eq do_concat_2253
do_apply_2252:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2254
do_concat_2253:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2254:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2256
    tst x1, #1
    b.eq do_concat_2256
do_apply_2255:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2257
do_concat_2256:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2257:
    b cond_end_2242
cond_false_2241:
    adr x0, sign_id
cond_end_2242:
blk_end_2240:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2259
    tst x1, #1
    b.eq do_concat_2259
do_apply_2258:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2260
do_concat_2259:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2260:
    b cond_end_2237
cond_false_2236:
    adr x0, sign_id
cond_end_2237:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2201
    adr x0, str_4
blk_end_2201:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2199_2200:
    // Closure for func_2199
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2199
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2195
cond_false_2194:
    adr x0, sign_id
cond_end_2195:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_function_def
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2264
    tst x1, #1
    b.eq do_concat_2264
do_apply_2263:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2265
do_concat_2264:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2265:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2261
    b after_func_2266_2267
func_2266:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2268_2269
func_2268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, ;
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2272
    tst x1, #1
    b.eq do_concat_2272
do_apply_2271:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2273
do_concat_2272:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2273:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2275
    tst x1, #1
    b.eq do_concat_2275
do_apply_2274:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2276
do_concat_2275:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2276:
    str x0, [sp, #-16]!
    b after_func_2277_2278
func_2277:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, args
    str x0, [sp, #-16]!
    adr x0, body
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2280
    tst x1, #1
    b.eq do_concat_2280
do_apply_2279:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2281
do_concat_2280:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2281:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2277_2278:
    // Closure for func_2277
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2277
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2283
    tst x1, #1
    b.eq do_concat_2283
do_apply_2282:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2284
do_concat_2283:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2284:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2270
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2270
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2270
    adr x0, str_cat
    str x0, [sp, #-16]!
    mov x0, #95
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2286
    tst x1, #1
    b.eq do_concat_2286
do_apply_2285:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2287
do_concat_2286:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2287:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2289
    tst x1, #1
    b.eq do_concat_2289
do_apply_2288:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2290
do_concat_2289:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2290:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2270
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2292
    tst x1, #1
    b.eq do_concat_2292
do_apply_2291:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2293
do_concat_2292:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2293:
    str x0, [sp, #-16]!
    adr x0, str_5
    str x0, [sp, #-16]!
    adr x0, Generate
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2294
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2296
xor_true_2294:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2295
    adr x0, sign_id
    b xor_end_2296
xor_false_2295:
    mov x0, x1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2298
    tst x1, #1
    b.eq do_concat_2298
do_apply_2297:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2299
do_concat_2298:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2299:
    str x0, [sp, #-16]!
    adr x0, end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2301
    tst x1, #1
    b.eq do_concat_2301
do_apply_2300:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2302
do_concat_2301:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2302:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2304
    tst x1, #1
    b.eq do_concat_2304
do_apply_2303:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2305
do_concat_2304:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2305:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2307
    tst x1, #1
    b.eq do_concat_2307
do_apply_2306:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2308
do_concat_2307:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2308:
    str x0, [sp, #-16]!
    adr x0, recursive
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2310
    tst x1, #1
    b.eq do_concat_2310
do_apply_2309:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2311
do_concat_2310:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2311:
    str x0, [sp, #-16]!
    adr x0, blocks
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2313
    tst x1, #1
    b.eq do_concat_2313
do_apply_2312:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2314
do_concat_2313:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2314:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2316
    tst x1, #1
    b.eq do_concat_2316
do_apply_2315:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2317
do_concat_2316:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2317:
    str x0, [sp, #-16]!
    adr x0, jump
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2319
    tst x1, #1
    b.eq do_concat_2319
do_apply_2318:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2320
do_concat_2319:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2320:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2322
    tst x1, #1
    b.eq do_concat_2322
do_apply_2321:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2323
do_concat_2322:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2323:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2270
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2325
    tst x1, #1
    b.eq do_concat_2325
do_apply_2324:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2326
do_concat_2325:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2326:
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2328
    tst x1, #1
    b.eq do_concat_2328
do_apply_2327:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2329
do_concat_2328:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2329:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2270
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2331
    tst x1, #1
    b.eq do_concat_2331
do_apply_2330:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2332
do_concat_2331:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2332:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2334
    tst x1, #1
    b.eq do_concat_2334
do_apply_2333:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2335
do_concat_2334:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2335:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2270
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2337
    tst x1, #1
    b.eq do_concat_2337
do_apply_2336:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2338
do_concat_2337:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2338:
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2340
    tst x1, #1
    b.eq do_concat_2340
do_apply_2339:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2341
do_concat_2340:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2341:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2270
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2343
    tst x1, #1
    b.eq do_concat_2343
do_apply_2342:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2344
do_concat_2343:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2344:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2346
    tst x1, #1
    b.eq do_concat_2346
do_apply_2345:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2347
do_concat_2346:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2347:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2349
    tst x1, #1
    b.eq do_concat_2349
do_apply_2348:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2350
do_concat_2349:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2350:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2352
    tst x1, #1
    b.eq do_concat_2352
do_apply_2351:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2353
do_concat_2352:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2353:
blk_end_2270:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2268_2269:
    // Closure for func_2268
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2268
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2266_2267:
    // Closure for func_2266
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2266
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2262
cond_false_2261:
    adr x0, sign_id
cond_end_2262:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2357
    tst x1, #1
    b.eq do_concat_2357
do_apply_2356:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2358
do_concat_2357:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2358:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2354
    b after_func_2359_2360
func_2359:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2361_2362
func_2361:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2366
    adr x0, sign_id
    b cmp_end_2367
cmp_true_2366:
cmp_end_2367:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2364
    adr x0, str_2
    b cond_end_2365
cond_false_2364:
    adr x0, sign_id
cond_end_2365:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2363
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2363
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2363
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2370
    adr x0, sign_id
    b cmp_end_2371
cmp_true_2370:
cmp_end_2371:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2368
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2374
    tst x1, #1
    b.eq do_concat_2374
do_apply_2373:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2375
do_concat_2374:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2375:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2372
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_8
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2377
    tst x1, #1
    b.eq do_concat_2377
do_apply_2376:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2378
do_concat_2377:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2378:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2380
    tst x1, #1
    b.eq do_concat_2380
do_apply_2379:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2381
do_concat_2380:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2381:
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2383
    tst x1, #1
    b.eq do_concat_2383
do_apply_2382:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2384
do_concat_2383:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2384:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2386
    tst x1, #1
    b.eq do_concat_2386
do_apply_2385:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2387
do_concat_2386:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2387:
blk_end_2372:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2389
    tst x1, #1
    b.eq do_concat_2389
do_apply_2388:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2390
do_concat_2389:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2390:
    b cond_end_2369
cond_false_2368:
    adr x0, sign_id
cond_end_2369:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2363
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2393
    adr x0, sign_id
    b cmp_end_2394
cmp_true_2393:
cmp_end_2394:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2391
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_block
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2396
    tst x1, #1
    b.eq do_concat_2396
do_apply_2395:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2397
do_concat_2396:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2397:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2399
    tst x1, #1
    b.eq do_concat_2399
do_apply_2398:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2400
do_concat_2399:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2400:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2402
    tst x1, #1
    b.eq do_concat_2402
do_apply_2401:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2403
do_concat_2402:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2403:
    b cond_end_2392
cond_false_2391:
    adr x0, sign_id
cond_end_2392:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2363
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2406
    adr x0, sign_id
    b cmp_end_2407
cmp_true_2406:
cmp_end_2407:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2404
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2409
    tst x1, #1
    b.eq do_concat_2409
do_apply_2408:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2410
do_concat_2409:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2410:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2412
    tst x1, #1
    b.eq do_concat_2412
do_apply_2411:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2413
do_concat_2412:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2413:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2415
    tst x1, #1
    b.eq do_concat_2415
do_apply_2414:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2416
do_concat_2415:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2416:
    b cond_end_2405
cond_false_2404:
    adr x0, sign_id
cond_end_2405:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2363
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2419
    adr x0, sign_id
    b cmp_end_2420
cmp_true_2419:
cmp_end_2420:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2417
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_apply
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2422
    tst x1, #1
    b.eq do_concat_2422
do_apply_2421:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2423
do_concat_2422:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2423:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2425
    tst x1, #1
    b.eq do_concat_2425
do_apply_2424:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2426
do_concat_2425:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2426:
    b cond_end_2418
cond_false_2417:
    adr x0, sign_id
cond_end_2418:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2363
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2429
    adr x0, sign_id
    b cmp_end_2430
cmp_true_2429:
cmp_end_2430:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2427
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2432
    tst x1, #1
    b.eq do_concat_2432
do_apply_2431:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2433
do_concat_2432:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2433:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2435
    tst x1, #1
    b.eq do_concat_2435
do_apply_2434:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2436
do_concat_2435:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2436:
    b cond_end_2428
cond_false_2427:
    adr x0, sign_id
cond_end_2428:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2363
    adr x0, str_2
blk_end_2363:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2361_2362:
    // Closure for func_2361
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2361
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2359_2360:
    // Closure for func_2359
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2359
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2355
cond_false_2354:
    adr x0, sign_id
cond_end_2355:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_id
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2440
    tst x1, #1
    b.eq do_concat_2440
do_apply_2439:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2441
do_concat_2440:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2441:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2437
    b after_func_2442_2443
func_2442:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    mov x0, #95
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2446
    tst x1, #1
    b.eq do_concat_2446
do_apply_2445:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2447
do_concat_2446:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2447:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2449
    tst x1, #1
    b.eq do_concat_2449
do_apply_2448:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2450
do_concat_2449:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2450:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2444
    adr x0, str_10
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2444
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_11
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2452
    tst x1, #1
    b.eq do_concat_2452
do_apply_2451:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2453
do_concat_2452:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2453:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2455
    tst x1, #1
    b.eq do_concat_2455
do_apply_2454:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2456
do_concat_2455:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2456:
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2458
    tst x1, #1
    b.eq do_concat_2458
do_apply_2457:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2459
do_concat_2458:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2459:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2461
    tst x1, #1
    b.eq do_concat_2461
do_apply_2460:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2462
do_concat_2461:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2462:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2444
    adr x0, str_12
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2444
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2464
    tst x1, #1
    b.eq do_concat_2464
do_apply_2463:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2465
do_concat_2464:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2465:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2467
    tst x1, #1
    b.eq do_concat_2467
do_apply_2466:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2468
do_concat_2467:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2468:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2470
    tst x1, #1
    b.eq do_concat_2470
do_apply_2469:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2471
do_concat_2470:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2471:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2473
    tst x1, #1
    b.eq do_concat_2473
do_apply_2472:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2474
do_concat_2473:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2474:
blk_end_2444:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2442_2443:
    // Closure for func_2442
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2442
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2438
cond_false_2437:
    adr x0, sign_id
cond_end_2438:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_apply
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2478
    tst x1, #1
    b.eq do_concat_2478
do_apply_2477:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2479
do_concat_2478:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2479:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2475
    b after_func_2480_2481
func_2480:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2484
    tst x1, #1
    b.eq do_concat_2484
do_apply_2483:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2485
do_concat_2484:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2485:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2487
    tst x1, #1
    b.eq do_concat_2487
do_apply_2486:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2488
do_concat_2487:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2488:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2490
    tst x1, #1
    b.eq do_concat_2490
do_apply_2489:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2491
do_concat_2490:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2491:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2493
    tst x1, #1
    b.eq do_concat_2493
do_apply_2492:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2494
do_concat_2493:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2494:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    adr x0, str_13
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    adr x0, str_14
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    adr x0, str_15
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    adr x0, str_16
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2482
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2496
    tst x1, #1
    b.eq do_concat_2496
do_apply_2495:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2497
do_concat_2496:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2497:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2499
    tst x1, #1
    b.eq do_concat_2499
do_apply_2498:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2500
do_concat_2499:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2500:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2502
    tst x1, #1
    b.eq do_concat_2502
do_apply_2501:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2503
do_concat_2502:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2503:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2505
    tst x1, #1
    b.eq do_concat_2505
do_apply_2504:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2506
do_concat_2505:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2506:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2508
    tst x1, #1
    b.eq do_concat_2508
do_apply_2507:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2509
do_concat_2508:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2509:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2511
    tst x1, #1
    b.eq do_concat_2511
do_apply_2510:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2512
do_concat_2511:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2512:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2514
    tst x1, #1
    b.eq do_concat_2514
do_apply_2513:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2515
do_concat_2514:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2515:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2517
    tst x1, #1
    b.eq do_concat_2517
do_apply_2516:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2518
do_concat_2517:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2518:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2520
    tst x1, #1
    b.eq do_concat_2520
do_apply_2519:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2521
do_concat_2520:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2521:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2523
    tst x1, #1
    b.eq do_concat_2523
do_apply_2522:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2524
do_concat_2523:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2524:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2526
    tst x1, #1
    b.eq do_concat_2526
do_apply_2525:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2527
do_concat_2526:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2527:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2529
    tst x1, #1
    b.eq do_concat_2529
do_apply_2528:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2530
do_concat_2529:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2530:
blk_end_2482:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2480_2481:
    // Closure for func_2480
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2480
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2476
cond_false_2475:
    adr x0, sign_id
cond_end_2476:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_infix
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2534
    tst x1, #1
    b.eq do_concat_2534
do_apply_2533:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2535
do_concat_2534:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2535:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2531
    b after_func_2536_2537
func_2536:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2538_2539
func_2538:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2540
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2540
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2540
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2542
    tst x1, #1
    b.eq do_concat_2542
do_apply_2541:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2543
do_concat_2542:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2543:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2545
    tst x1, #1
    b.eq do_concat_2545
do_apply_2544:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2546
do_concat_2545:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2546:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2540
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Match
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2551
    tst x1, #1
    b.eq do_concat_2551
do_apply_2550:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2552
do_concat_2551:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2552:
    str x0, [sp, #-16]!
    adr x0, Case
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2554
    tst x1, #1
    b.eq do_concat_2554
do_apply_2553:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2555
do_concat_2554:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2555:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2548
    adr x0, val
    str x0, [sp, #-16]!
    adr x0, sign_id
    b cond_end_2549
cond_false_2548:
    adr x0, sign_id
cond_end_2549:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2547
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2557
    tst x1, #1
    b.eq do_concat_2557
do_apply_2556:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2558
do_concat_2557:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2558:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2560
    tst x1, #1
    b.eq do_concat_2560
do_apply_2559:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2561
do_concat_2560:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2561:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2547
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2563
    tst x1, #1
    b.eq do_concat_2563
do_apply_2562:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2564
do_concat_2563:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2564:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2566
    tst x1, #1
    b.eq do_concat_2566
do_apply_2565:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2567
do_concat_2566:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2567:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2547
    adr x0, str_18
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2547
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2569
    tst x1, #1
    b.eq do_concat_2569
do_apply_2568:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2570
do_concat_2569:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2570:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_19
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2572
    tst x1, #1
    b.eq do_concat_2572
do_apply_2571:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2573
do_concat_2572:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2573:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2575
    tst x1, #1
    b.eq do_concat_2575
do_apply_2574:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2576
do_concat_2575:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2576:
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2578
    tst x1, #1
    b.eq do_concat_2578
do_apply_2577:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2579
do_concat_2578:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2579:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2581
    tst x1, #1
    b.eq do_concat_2581
do_apply_2580:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2582
do_concat_2581:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2582:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2584
    tst x1, #1
    b.eq do_concat_2584
do_apply_2583:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2585
do_concat_2584:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2585:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2547
    adr x0, str_20
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2547
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2587
    tst x1, #1
    b.eq do_concat_2587
do_apply_2586:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2588
do_concat_2587:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2588:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2590
    tst x1, #1
    b.eq do_concat_2590
do_apply_2589:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2591
do_concat_2590:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2591:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2593
    tst x1, #1
    b.eq do_concat_2593
do_apply_2592:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2594
do_concat_2593:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2594:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-208]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2596
    tst x1, #1
    b.eq do_concat_2596
do_apply_2595:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2597
do_concat_2596:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2597:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2599
    tst x1, #1
    b.eq do_concat_2599
do_apply_2598:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2600
do_concat_2599:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2600:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2602
    tst x1, #1
    b.eq do_concat_2602
do_apply_2601:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2603
do_concat_2602:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2603:
blk_end_2547:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2605
    tst x1, #1
    b.eq do_concat_2605
do_apply_2604:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2606
do_concat_2605:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2606:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2540
    ldr x0, [x29, #-224]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2609
    adr x0, sign_id
    b cmp_end_2610
cmp_true_2609:
cmp_end_2610:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2607
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2613
    tst x1, #1
    b.eq do_concat_2613
do_apply_2612:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2614
do_concat_2613:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2614:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2616
    tst x1, #1
    b.eq do_concat_2616
do_apply_2615:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2617
do_concat_2616:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2617:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2611
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2619
    tst x1, #1
    b.eq do_concat_2619
do_apply_2618:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2620
do_concat_2619:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2620:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2622
    tst x1, #1
    b.eq do_concat_2622
do_apply_2621:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2623
do_concat_2622:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2623:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2611
    adr x0, str_13
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2611
    adr x0, str_21
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2611
    adr x0, emit_op
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2625
    tst x1, #1
    b.eq do_concat_2625
do_apply_2624:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2626
do_concat_2625:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2626:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2611
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2628
    tst x1, #1
    b.eq do_concat_2628
do_apply_2627:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2629
do_concat_2628:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2629:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-272]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2631
    tst x1, #1
    b.eq do_concat_2631
do_apply_2630:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2632
do_concat_2631:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2632:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-256]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2634
    tst x1, #1
    b.eq do_concat_2634
do_apply_2633:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2635
do_concat_2634:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2635:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-288]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2637
    tst x1, #1
    b.eq do_concat_2637
do_apply_2636:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2638
do_concat_2637:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2638:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-304]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2640
    tst x1, #1
    b.eq do_concat_2640
do_apply_2639:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2641
do_concat_2640:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2641:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2643
    tst x1, #1
    b.eq do_concat_2643
do_apply_2642:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2644
do_concat_2643:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2644:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2646
    tst x1, #1
    b.eq do_concat_2646
do_apply_2645:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2647
do_concat_2646:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2647:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2649
    tst x1, #1
    b.eq do_concat_2649
do_apply_2648:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2650
do_concat_2649:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2650:
blk_end_2611:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2652
    tst x1, #1
    b.eq do_concat_2652
do_apply_2651:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2653
do_concat_2652:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2653:
    b cond_end_2608
cond_false_2607:
    adr x0, sign_id
cond_end_2608:
blk_end_2540:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2538_2539:
    // Closure for func_2538
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2538
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2536_2537:
    // Closure for func_2536
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2536
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2532
cond_false_2531:
    adr x0, sign_id
cond_end_2532:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, emit_op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2657
    tst x1, #1
    b.eq do_concat_2657
do_apply_2656:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2658
do_concat_2657:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2658:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2654
    b after_func_2659_2660
func_2659:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2665
    tst x1, #1
    b.eq do_concat_2665
do_apply_2664:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2666
do_concat_2665:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2666:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2668
    tst x1, #1
    b.eq do_concat_2668
do_apply_2667:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2669
do_concat_2668:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2669:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2662
    adr x0, str_22
    b cond_end_2663
cond_false_2662:
    adr x0, sign_id
cond_end_2663:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2661
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2673
    tst x1, #1
    b.eq do_concat_2673
do_apply_2672:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2674
do_concat_2673:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2674:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2676
    tst x1, #1
    b.eq do_concat_2676
do_apply_2675:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2677
do_concat_2676:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2677:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2670
    adr x0, str_23
    b cond_end_2671
cond_false_2670:
    adr x0, sign_id
cond_end_2671:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2661
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2681
    tst x1, #1
    b.eq do_concat_2681
do_apply_2680:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2682
do_concat_2681:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2682:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2684
    tst x1, #1
    b.eq do_concat_2684
do_apply_2683:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2685
do_concat_2684:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2685:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2678
    adr x0, str_24
    b cond_end_2679
cond_false_2678:
    adr x0, sign_id
cond_end_2679:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2661
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2689
    tst x1, #1
    b.eq do_concat_2689
do_apply_2688:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2690
do_concat_2689:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2690:
    str x0, [sp, #-16]!
    mov x0, #124
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2692
    tst x1, #1
    b.eq do_concat_2692
do_apply_2691:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2693
do_concat_2692:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2693:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2686
    adr x0, str_25
    b cond_end_2687
cond_false_2686:
    adr x0, sign_id
cond_end_2687:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2661
    adr x0, str_26
blk_end_2661:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2659_2660:
    // Closure for func_2659
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2659
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2655
cond_false_2654:
    adr x0, sign_id
cond_end_2655:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_block
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2697
    tst x1, #1
    b.eq do_concat_2697
do_apply_2696:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2698
do_concat_2697:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2698:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2694
    b after_func_2699_2700
func_2699:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2701_2702
func_2701:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2706
    adr x0, sign_id
    b cmp_end_2707
cmp_true_2706:
cmp_end_2707:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2704
    adr x0, str_2
    b cond_end_2705
cond_false_2704:
    adr x0, sign_id
cond_end_2705:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2703
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2703
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2709
    tst x1, #1
    b.eq do_concat_2709
do_apply_2708:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2710
do_concat_2709:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2710:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2712
    tst x1, #1
    b.eq do_concat_2712
do_apply_2711:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2713
do_concat_2712:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2713:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2703
    adr x0, compile_block
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2715
    tst x1, #1
    b.eq do_concat_2715
do_apply_2714:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2716
do_concat_2715:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2716:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2718
    tst x1, #1
    b.eq do_concat_2718
do_apply_2717:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2719
do_concat_2718:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2719:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2721
    tst x1, #1
    b.eq do_concat_2721
do_apply_2720:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2722
do_concat_2721:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2722:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2703
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2724
    tst x1, #1
    b.eq do_concat_2724
do_apply_2723:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2725
do_concat_2724:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2725:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2727
    tst x1, #1
    b.eq do_concat_2727
do_apply_2726:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2728
do_concat_2727:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2728:
blk_end_2703:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2701_2702:
    // Closure for func_2701
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2701
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2699_2700:
    // Closure for func_2699
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2699
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2695
cond_false_2694:
    adr x0, sign_id
cond_end_2695:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, main
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2732
    tst x1, #1
    b.eq do_concat_2732
do_apply_2731:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2733
do_concat_2732:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2733:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2729
    b after_func_2734_2735
func_2734:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_27
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_28
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2738
    tst x1, #1
    b.eq do_concat_2738
do_apply_2737:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2739
do_concat_2738:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2739:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2741
    tst x1, #1
    b.eq do_concat_2741
do_apply_2740:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2742
do_concat_2741:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2742:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2744
    tst x1, #1
    b.eq do_concat_2744
do_apply_2743:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2745
do_concat_2744:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2745:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, init_lexer
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2747
    tst x1, #1
    b.eq do_concat_2747
do_apply_2746:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2748
do_concat_2747:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2748:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2750
    tst x1, #1
    b.eq do_concat_2750
do_apply_2749:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2751
do_concat_2750:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2751:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, init_parser
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2753
    tst x1, #1
    b.eq do_concat_2753
do_apply_2752:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2754
do_concat_2753:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2754:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2756
    tst x1, #1
    b.eq do_concat_2756
do_apply_2755:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2757
do_concat_2756:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2757:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, compile_program
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2759
    tst x1, #1
    b.eq do_concat_2759
do_apply_2758:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2760
do_concat_2759:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2760:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2736
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2762
    tst x1, #1
    b.eq do_concat_2762
do_apply_2761:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2763
do_concat_2762:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2763:
blk_end_2736:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2734_2735:
    // Closure for func_2734
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2734
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2730
cond_false_2729:
    adr x0, sign_id
cond_end_2730:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_program
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2767
    tst x1, #1
    b.eq do_concat_2767
do_apply_2766:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2768
do_concat_2767:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2768:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2764
    b after_func_2769_2770
func_2769:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_29
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2769_2770:
    // Closure for func_2769
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2769
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2765
cond_false_2764:
    adr x0, sign_id
cond_end_2765:
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
tok_eof: .quad 0
tok_id: .quad 0
tok_num: .quad 0
tok_str: .quad 0
tok_op: .quad 0
tok_punc: .quad 0
tok_sep: .quad 0
tok_lparen: .quad 0
tok_rparen: .quad 0
ast_num: .quad 0
ast_id: .quad 0
ast_str: .quad 0
ast_op: .quad 0
ast_def: .quad 0
ast_apply: .quad 0
ast_block: .quad 0
ast_infix: .quad 0
PREC_APPLY: .quad 0
PREC_XOR: .quad 0
PREC_OR: .quad 0
PREC_AND: .quad 0
PREC_CMP: .quad 0
PREC_ADD: .quad 0
PREC_MUL: .quad 0
PREC_PREFIX: .quad 0


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


.data
.balign 8
.global _str_start
_str_start:
str_0:
    .asciz "s"
str_1:
    .asciz "dest"
str_2:
    .asciz ""
str_3:
    .asciz "t"
str_4:
    .asciz "; TODO: Global variable def\n"
str_5:
    .asciz ":\n"
str_6:
    .asciz "_end"
str_7:
    .asciz ":\n    ret\n"
str_8:
    .asciz "    mov x0, #"
str_9:
    .asciz "\n"
str_10:
    .asciz "    adr x0, sign_id\n"
str_11:
    .asciz "    adr x1, "
str_12:
    .asciz "    bl _cons\n"
str_13:
    .asciz "    str x0, [sp, #-16]!\n"
str_14:
    .asciz "    ldr x9, [sp], #16\n"
str_15:
    .asciz "    ldr x10, [x9]\n"
str_16:
    .asciz "    ldr x9, [x9, #8]\n"
str_17:
    .asciz "    blr x10\n"
str_18:
    .asciz "    cmp x0, #0\n    beq 1f\n"
str_19:
    .asciz "    b "
str_20:
    .asciz "1:\n"
str_21:
    .asciz "    ldr x1, [sp], #16\n"
str_22:
    .asciz "    bl _add\n"
str_23:
    .asciz "    sub x0, x1, x0\n"
str_24:
    .asciz "    mul x0, x1, x0\n"
str_25:
    .asciz "    orr x0, x1, x0\n"
str_26:
    .asciz "    ; Unknown Op\n"
str_27:
    .asciz "#main : ? print_num 123"
str_28:
    .asciz "Source: "
str_29:
    .asciz "// TODO: Generate Assembly\n"

.global _str_end
_str_end:
