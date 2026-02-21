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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_13
    tst x0, #1
    b.ne do_compose_11
do_apply_12:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_14
do_compose_11:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_14
do_concat_13:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_14:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_9
    b after_func_15_16
func_15:
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
    b.ne blk_end_17
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
    b.ne blk_end_17
    adr x0, curr
blk_end_17:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_15_16:
    // Closure for func_15
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_15
    ldr x0, [sp], #16
    bl _cons
    b cond_end_10
cond_false_9:
    adr x0, sign_id
cond_end_10:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_22
    tst x0, #1
    b.ne do_compose_20
do_apply_21:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_23
do_compose_20:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_23
do_concat_22:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_23:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_18
    b after_func_24_25
func_24:
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
    adr x0, addr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_29
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_33
    tst x0, #1
    b.ne do_compose_31
do_apply_32:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_34
do_compose_31:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_34
do_concat_33:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_34:
    b cond_end_30
cond_false_29:
    adr x0, sign_id
cond_end_30:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_28
    adr x0, addr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_28
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
    b.ne blk_end_28
    adr x0, addr
blk_end_28:
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
after_func_24_25:
    // Closure for func_24
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_24
    ldr x0, [sp], #16
    bl _cons
    b cond_end_19
cond_false_18:
    adr x0, sign_id
cond_end_19:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, head
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_39
    tst x0, #1
    b.ne do_compose_37
do_apply_38:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_40
do_compose_37:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_40
do_concat_39:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_40:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_35
    b after_func_41_42
func_41:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_41_42:
    // Closure for func_41
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_41
    ldr x0, [sp], #16
    bl _cons
    b cond_end_36
cond_false_35:
    adr x0, sign_id
cond_end_36:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tail
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_47
    tst x0, #1
    b.ne do_compose_45
do_apply_46:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_48
do_compose_45:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_48
do_concat_47:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_48:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_43
    b after_func_49_50
func_49:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
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
    b cond_end_44
cond_false_43:
    adr x0, sign_id
cond_end_44:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, nth
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_51
    b after_func_57_58
func_57:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_59_60
func_59:
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
    b.le cmp_true_64
    adr x0, sign_id
    b cmp_end_65
cmp_true_64:
cmp_end_65:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_62
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_68
    tst x0, #1
    b.ne do_compose_66
do_apply_67:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_69
do_compose_66:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_69
do_concat_68:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_69:
    b cond_end_63
cond_false_62:
    adr x0, sign_id
cond_end_63:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_61
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_72
    tst x0, #1
    b.ne do_compose_70
do_apply_71:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_73
do_compose_70:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_73
do_concat_72:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_73:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_76
    tst x0, #1
    b.ne do_compose_74
do_apply_75:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_77
do_compose_74:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_77
do_concat_76:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_77:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_80
    tst x0, #1
    b.ne do_compose_78
do_apply_79:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_81
do_compose_78:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_81
do_concat_80:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_81:
blk_end_61:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_59_60:
    // Closure for func_59
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_59
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_57_58:
    // Closure for func_57
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_57
    ldr x0, [sp], #16
    bl _cons
    b cond_end_52
cond_false_51:
    adr x0, sign_id
cond_end_52:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, factorial
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_86
    tst x0, #1
    b.ne do_compose_84
do_apply_85:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_87
do_compose_84:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_87
do_concat_86:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_87:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_82
    b after_func_88_89
func_88:
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
after_func_88_89:
    // Closure for func_88
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_88
    ldr x0, [sp], #16
    bl _cons
    b cond_end_83
cond_false_82:
    adr x0, sign_id
cond_end_83:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, range
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_103
    tst x0, #1
    b.ne do_compose_101
do_apply_102:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_104
do_compose_101:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_104
do_concat_103:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_104:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_99
    b after_func_105_106
func_105:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_107_108
func_107:
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
    b.gt cmp_true_112
    adr x0, sign_id
    b cmp_end_113
cmp_true_112:
cmp_end_113:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_110
    mov x0, #0
    b cond_end_111
cond_false_110:
    adr x0, sign_id
cond_end_111:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_109
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_116
    tst x0, #1
    b.ne do_compose_114
do_apply_115:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_117
do_compose_114:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_117
do_concat_116:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_117:
    str x0, [sp, #-16]!
    adr x0, range
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_120
    tst x0, #1
    b.ne do_compose_118
do_apply_119:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_121
do_compose_118:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_121
do_concat_120:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_121:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_124
    tst x0, #1
    b.ne do_compose_122
do_apply_123:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_125
do_compose_122:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_125
do_concat_124:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_125:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_128
    tst x0, #1
    b.ne do_compose_126
do_apply_127:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_129
do_compose_126:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_129
do_concat_128:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_129:
blk_end_109:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_107_108:
    // Closure for func_107
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_107
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_105_106:
    // Closure for func_105
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_105
    ldr x0, [sp], #16
    bl _cons
    b cond_end_100
cond_false_99:
    adr x0, sign_id
cond_end_100:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_char
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_134
    tst x0, #1
    b.ne do_compose_132
do_apply_133:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_135
do_compose_132:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_135
do_concat_134:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_135:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_130
    b after_func_136_137
func_136:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_141
    tst x0, #1
    b.ne do_compose_139
do_apply_140:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_142
do_compose_139:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_142
do_concat_141:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_142:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_145
    tst x0, #1
    b.ne do_compose_143
do_apply_144:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_146
do_compose_143:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_146
do_concat_145:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_146:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_138
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_149
    tst x0, #1
    b.ne do_compose_147
do_apply_148:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_150
do_compose_147:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_150
do_concat_149:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_150:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_153
    tst x0, #1
    b.ne do_compose_151
do_apply_152:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_154
do_compose_151:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_154
do_concat_153:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_154:
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_157
    tst x0, #1
    b.ne do_compose_155
do_apply_156:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_158
do_compose_155:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_158
do_concat_157:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_158:
blk_end_138:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_136_137:
    // Closure for func_136
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_136
    ldr x0, [sp], #16
    bl _cons
    b cond_end_131
cond_false_130:
    adr x0, sign_id
cond_end_131:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_str
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_159
    b after_func_165_166
func_165:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_168_169
func_168:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_168_169:
    // Closure for func_168
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_168
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_170
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_170
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_170
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_173
    adr x0, sign_id
    b cmp_end_174
cmp_true_173:
cmp_end_174:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_171
    ldr x0, [x29, #-64]
    b cond_end_172
cond_false_171:
    adr x0, sign_id
cond_end_172:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_170
    adr x0, len_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_177
    tst x0, #1
    b.ne do_compose_175
do_apply_176:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_178
do_compose_175:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_178
do_concat_177:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_178:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_181
    tst x0, #1
    b.ne do_compose_179
do_apply_180:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_182
do_compose_179:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_182
do_concat_181:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_182:
blk_end_170:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_185
    tst x0, #1
    b.ne do_compose_183
do_apply_184:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_186
do_compose_183:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_186
do_concat_185:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_186:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_167
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_189
    tst x0, #1
    b.ne do_compose_187
do_apply_188:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_190
do_compose_187:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_190
do_concat_189:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_190:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_167
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_193
    tst x0, #1
    b.ne do_compose_191
do_apply_192:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_194
do_compose_191:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_194
do_concat_193:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_194:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_197
    tst x0, #1
    b.ne do_compose_195
do_apply_196:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_198
do_compose_195:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_198
do_concat_197:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_198:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_201
    tst x0, #1
    b.ne do_compose_199
do_apply_200:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_202
do_compose_199:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_202
do_concat_201:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_202:
blk_end_167:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_165_166:
    // Closure for func_165
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_165
    ldr x0, [sp], #16
    bl _cons
    b cond_end_160
cond_false_159:
    adr x0, sign_id
cond_end_160:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_num
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_207
    tst x0, #1
    b.ne do_compose_205
do_apply_206:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_208
do_compose_205:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_208
do_concat_207:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_208:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_203
    b after_func_209_210
func_209:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_214
    adr x0, sign_id
    b cmp_end_215
cmp_true_214:
cmp_end_215:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_212
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_219
    tst x0, #1
    b.ne do_compose_217
do_apply_218:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_220
do_compose_217:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_220
do_concat_219:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_220:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_216
    mov x0, #0
blk_end_216:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_223
    tst x0, #1
    b.ne do_compose_221
do_apply_222:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_224
do_compose_221:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_224
do_concat_223:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_224:
    b cond_end_213
cond_false_212:
    adr x0, sign_id
cond_end_213:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_211
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_227
    adr x0, sign_id
    b cmp_end_228
cmp_true_227:
cmp_end_228:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_225
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_232
    tst x0, #1
    b.ne do_compose_230
do_apply_231:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_233
do_compose_230:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_233
do_concat_232:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_233:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_229
    adr x0, print_num
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_236
    tst x0, #1
    b.ne do_compose_234
do_apply_235:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_237
do_compose_234:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_237
do_concat_236:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_237:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_229
    mov x0, #0
blk_end_229:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_240
    tst x0, #1
    b.ne do_compose_238
do_apply_239:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_241
do_compose_238:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_241
do_concat_240:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_241:
    b cond_end_226
cond_false_225:
    adr x0, sign_id
cond_end_226:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_211
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_244
    tst x0, #1
    b.ne do_compose_242
do_apply_243:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_245
do_compose_242:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_245
do_concat_244:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_245:
blk_end_211:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_209_210:
    // Closure for func_209
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_209
    ldr x0, [sp], #16
    bl _cons
    b cond_end_204
cond_false_203:
    adr x0, sign_id
cond_end_204:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _print_num_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_250
    tst x0, #1
    b.ne do_compose_248
do_apply_249:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_251
do_compose_248:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_251
do_concat_250:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_251:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_246
    b after_func_252_253
func_252:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_257
    adr x0, sign_id
    b cmp_end_258
cmp_true_257:
cmp_end_258:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_255
    mov x0, #0
    b cond_end_256
cond_false_255:
    adr x0, sign_id
cond_end_256:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_254
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_261
    tst x0, #1
    b.ne do_compose_259
do_apply_260:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_262
do_compose_259:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_262
do_concat_261:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_262:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_254
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
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_265
    tst x0, #1
    b.ne do_compose_263
do_apply_264:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_266
do_compose_263:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_266
do_concat_265:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_266:
blk_end_254:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_252_253:
    // Closure for func_252
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_252
    ldr x0, [sp], #16
    bl _cons
    b cond_end_247
cond_false_246:
    adr x0, sign_id
cond_end_247:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, add
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_271
    tst x0, #1
    b.ne do_compose_269
do_apply_270:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_272
do_compose_269:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_272
do_concat_271:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_272:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_267
    b after_func_273_274
func_273:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_275_276
func_275:
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
after_func_275_276:
    // Closure for func_275
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_275
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_268
cond_false_267:
    adr x0, sign_id
cond_end_268:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sub
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_281
    tst x0, #1
    b.ne do_compose_279
do_apply_280:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_282
do_compose_279:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_282
do_concat_281:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_282:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_277
    b after_func_283_284
func_283:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_285_286
func_285:
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
after_func_285_286:
    // Closure for func_285
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_285
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_283_284:
    // Closure for func_283
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_283
    ldr x0, [sp], #16
    bl _cons
    b cond_end_278
cond_false_277:
    adr x0, sign_id
cond_end_278:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, mul
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_291
    tst x0, #1
    b.ne do_compose_289
do_apply_290:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_292
do_compose_289:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_292
do_concat_291:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_292:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_287
    b after_func_293_294
func_293:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_295_296
func_295:
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
after_func_295_296:
    // Closure for func_295
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_295
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_293_294:
    // Closure for func_293
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_293
    ldr x0, [sp], #16
    bl _cons
    b cond_end_288
cond_false_287:
    adr x0, sign_id
cond_end_288:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, div
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_301
    tst x0, #1
    b.ne do_compose_299
do_apply_300:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_302
do_compose_299:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_302
do_concat_301:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_302:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_297
    b after_func_303_304
func_303:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_305_306
func_305:
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
after_func_305_306:
    // Closure for func_305
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_305
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_303_304:
    // Closure for func_303
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_303
    ldr x0, [sp], #16
    bl _cons
    b cond_end_298
cond_false_297:
    adr x0, sign_id
cond_end_298:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, mod
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_311
    tst x0, #1
    b.ne do_compose_309
do_apply_310:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_312
do_compose_309:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_312
do_concat_311:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_312:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_307
    b after_func_313_314
func_313:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_315_316
func_315:
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
after_func_315_316:
    // Closure for func_315
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_315
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_313_314:
    // Closure for func_313
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_313
    ldr x0, [sp], #16
    bl _cons
    b cond_end_308
cond_false_307:
    adr x0, sign_id
cond_end_308:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_319
    tst x0, #1
    b.ne do_compose_317
do_apply_318:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_320
do_compose_317:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_320
do_concat_319:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_320:
    str x0, [sp, #-16]!
    adr x0, Lexer
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_323
    tst x0, #1
    b.ne do_compose_321
do_apply_322:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_324
do_compose_321:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_324
do_concat_323:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_324:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Ported
    str x0, [sp, #-16]!
    adr x0, from
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_327
    tst x0, #1
    b.ne do_compose_325
do_apply_326:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_328
do_compose_325:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_328
do_concat_327:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_328:
    str x0, [sp, #-16]!
    adr x0, prepare_lexer
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_331
    tst x0, #1
    b.ne do_compose_329
do_apply_330:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_332
do_compose_329:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_332
do_concat_331:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_332:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_335
    tst x0, #1
    b.ne do_compose_333
do_apply_334:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_336
do_compose_333:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_336
do_concat_335:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_336:
    str x0, [sp, #-16]!
    adr x0, js
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_339
    tst x0, #1
    b.ne do_compose_337
do_apply_338:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_340
do_compose_337:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_340
do_concat_339:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_340:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_343
    tst x0, #1
    b.ne do_compose_341
do_apply_342:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_344
do_compose_341:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_344
do_concat_343:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_344:
    str x0, [sp, #-16]!
    adr x0, js
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_347
    tst x0, #1
    b.ne do_compose_345
do_apply_346:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_348
do_compose_345:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_348
do_concat_347:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_348:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_353
    tst x0, #1
    b.ne do_compose_351
do_apply_352:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_354
do_compose_351:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_354
do_concat_353:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_354:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_349
    b after_func_355_356
func_355:
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
    b.ne blk_end_357
    adr x0, src_len
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_360
    tst x0, #1
    b.ne do_compose_358
do_apply_359:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_361
do_compose_358:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_361
do_concat_360:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_361:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_357
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_357
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_364
    tst x0, #1
    b.ne do_compose_362
do_apply_363:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_365
do_compose_362:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_365
do_concat_364:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_365:
blk_end_357:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_355_356:
    // Closure for func_355
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_355
    ldr x0, [sp], #16
    bl _cons
    b cond_end_350
cond_false_349:
    adr x0, sign_id
cond_end_350:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, read_char
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_370
    tst x0, #1
    b.ne do_compose_368
do_apply_369:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_371
do_compose_368:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_371
do_concat_370:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_371:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_366
    b after_func_372_373
func_372:
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
    b.ne blk_end_374
    adr x0, p
    str x0, [sp, #-16]!
    adr x0, src_len
    ldr x0, [x0] // @ load
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_377
    adr x0, sign_id
    b cmp_end_378
cmp_true_377:
cmp_end_378:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_375
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, ch
    str x0, [sp, #-16]!
    mov x0, #-1
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_379
    mov x0, #0
blk_end_379:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_382
    tst x0, #1
    b.ne do_compose_380
do_apply_381:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_383
do_compose_380:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_383
do_concat_382:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_383:
    b cond_end_376
cond_false_375:
    adr x0, sign_id
cond_end_376:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_374
    adr x0, c
    str x0, [sp, #-16]!
    adr x0, nth
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_374
    adr x0, src
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, p
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_386
    tst x0, #1
    b.ne do_compose_384
do_apply_385:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_387
do_compose_384:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_387
do_concat_386:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_387:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_374
    adr x0, ch
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_374
    adr x0, pos
    str x0, [sp, #-16]!
    adr x0, p
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_374
    adr x0, c
blk_end_374:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_372_373:
    // Closure for func_372
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_372
    ldr x0, [sp], #16
    bl _cons
    b cond_end_367
cond_false_366:
    adr x0, sign_id
cond_end_367:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_space
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_392
    tst x0, #1
    b.ne do_compose_390
do_apply_391:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_393
do_compose_390:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_393
do_concat_392:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_393:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_388
    b after_func_394_395
func_394:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_400
    adr x0, sign_id
    b cmp_end_401
cmp_true_400:
cmp_end_401:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_398
    b or_end_399
or_right_398:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_402
    adr x0, sign_id
    b cmp_end_403
cmp_true_402:
cmp_end_403:
or_end_399:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_396
    b or_end_397
or_right_396:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_404
    adr x0, sign_id
    b cmp_end_405
cmp_true_404:
cmp_end_405:
or_end_397:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_394_395:
    // Closure for func_394
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_394
    ldr x0, [sp], #16
    bl _cons
    b cond_end_389
cond_false_388:
    adr x0, sign_id
cond_end_389:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_digit
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_410
    tst x0, #1
    b.ne do_compose_408
do_apply_409:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_411
do_compose_408:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_411
do_concat_410:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_411:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_406
    b after_func_412_413
func_412:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_416
    adr x0, sign_id
    b cmp_end_417
cmp_true_416:
cmp_end_417:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_414
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_418
    adr x0, sign_id
    b cmp_end_419
cmp_true_418:
cmp_end_419:
    b and_end_415
and_fail_414:
    adr x0, sign_id
and_end_415:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_412_413:
    // Closure for func_412
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_412
    ldr x0, [sp], #16
    bl _cons
    b cond_end_407
cond_false_406:
    adr x0, sign_id
cond_end_407:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_alpha
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_424
    tst x0, #1
    b.ne do_compose_422
do_apply_423:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_425
do_compose_422:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_425
do_concat_424:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_425:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_420
    b after_func_426_427
func_426:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_434
    adr x0, sign_id
    b cmp_end_435
cmp_true_434:
cmp_end_435:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_432
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_436
    adr x0, sign_id
    b cmp_end_437
cmp_true_436:
cmp_end_437:
    b and_end_433
and_fail_432:
    adr x0, sign_id
and_end_433:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_430
    b or_end_431
or_right_430:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_440
    adr x0, sign_id
    b cmp_end_441
cmp_true_440:
cmp_end_441:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_438
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_442
    adr x0, sign_id
    b cmp_end_443
cmp_true_442:
cmp_end_443:
    b and_end_439
and_fail_438:
    adr x0, sign_id
and_end_439:
or_end_431:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_428
    b or_end_429
or_right_428:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_444
    adr x0, sign_id
    b cmp_end_445
cmp_true_444:
cmp_end_445:
or_end_429:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_426_427:
    // Closure for func_426
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_426
    ldr x0, [sp], #16
    bl _cons
    b cond_end_421
cond_false_420:
    adr x0, sign_id
cond_end_421:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_op_char
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_446
    b after_func_452_453
func_452:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_484
    adr x0, sign_id
    b cmp_end_485
cmp_true_484:
cmp_end_485:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_482
    b or_end_483
or_right_482:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_486
    adr x0, sign_id
    b cmp_end_487
cmp_true_486:
cmp_end_487:
or_end_483:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_480
    b or_end_481
or_right_480:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_488
    adr x0, sign_id
    b cmp_end_489
cmp_true_488:
cmp_end_489:
or_end_481:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_478
    b or_end_479
or_right_478:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_490
    adr x0, sign_id
    b cmp_end_491
cmp_true_490:
cmp_end_491:
or_end_479:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_476
    b or_end_477
or_right_476:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_492
    adr x0, sign_id
    b cmp_end_493
cmp_true_492:
cmp_end_493:
or_end_477:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_474
    b or_end_475
or_right_474:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_494
    adr x0, sign_id
    b cmp_end_495
cmp_true_494:
cmp_end_495:
or_end_475:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_472
    b or_end_473
or_right_472:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_496
    adr x0, sign_id
    b cmp_end_497
cmp_true_496:
cmp_end_497:
or_end_473:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_470
    b or_end_471
or_right_470:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_498
    adr x0, sign_id
    b cmp_end_499
cmp_true_498:
cmp_end_499:
or_end_471:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_468
    b or_end_469
or_right_468:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_500
    adr x0, sign_id
    b cmp_end_501
cmp_true_500:
cmp_end_501:
or_end_469:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_466
    b or_end_467
or_right_466:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_502
    adr x0, sign_id
    b cmp_end_503
cmp_true_502:
cmp_end_503:
or_end_467:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_464
    b or_end_465
or_right_464:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_504
    adr x0, sign_id
    b cmp_end_505
cmp_true_504:
cmp_end_505:
or_end_465:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_462
    b or_end_463
or_right_462:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_506
    adr x0, sign_id
    b cmp_end_507
cmp_true_506:
cmp_end_507:
or_end_463:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_460
    b or_end_461
or_right_460:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_508
    adr x0, sign_id
    b cmp_end_509
cmp_true_508:
cmp_end_509:
or_end_461:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_458
    b or_end_459
or_right_458:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_510
    adr x0, sign_id
    b cmp_end_511
cmp_true_510:
cmp_end_511:
or_end_459:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_456
    b or_end_457
or_right_456:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_512
    adr x0, sign_id
    b cmp_end_513
cmp_true_512:
cmp_end_513:
or_end_457:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_454
    b or_end_455
or_right_454:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_514
    adr x0, sign_id
    b cmp_end_515
cmp_true_514:
cmp_end_515:
or_end_455:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_452_453:
    // Closure for func_452
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_452
    ldr x0, [sp], #16
    bl _cons
    b cond_end_447
cond_false_446:
    adr x0, sign_id
cond_end_447:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, length
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_520
    tst x0, #1
    b.ne do_compose_518
do_apply_519:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_521
do_compose_518:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_521
do_concat_520:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_521:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_516
    b after_func_522_523
func_522:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_527
    adr x0, sign_id
    b cmp_end_528
cmp_true_527:
cmp_end_528:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_525
    mov x0, #0
    b cond_end_526
cond_false_525:
    adr x0, sign_id
cond_end_526:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_524
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, length
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_531
    tst x0, #1
    b.ne do_compose_529
do_apply_530:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_532
do_compose_529:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_532
do_concat_531:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_532:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_535
    tst x0, #1
    b.ne do_compose_533
do_apply_534:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_536
do_compose_533:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_536
do_concat_535:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_536:
blk_end_524:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_522_523:
    // Closure for func_522
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_522
    ldr x0, [sp], #16
    bl _cons
    b cond_end_517
cond_false_516:
    adr x0, sign_id
cond_end_517:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, list_to_string
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_541
    tst x0, #1
    b.ne do_compose_539
do_apply_540:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_542
do_compose_539:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_542
do_concat_541:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_542:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_537
    b after_func_543_544
func_543:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, length
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_548
    tst x0, #1
    b.ne do_compose_546
do_apply_547:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_549
do_compose_546:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_549
do_concat_548:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_549:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_545
    adr x0, alloc
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_552
    tst x0, #1
    b.ne do_compose_550
do_apply_551:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_553
do_compose_550:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_553
do_concat_552:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_553:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_545
    adr x0, _write_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_560
    tst x0, #1
    b.ne do_compose_558
do_apply_559:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_561
do_compose_558:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_561
do_concat_560:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_561:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_564
    tst x0, #1
    b.ne do_compose_562
do_apply_563:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_565
do_compose_562:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_565
do_concat_564:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_565:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_545
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_545
    ldr x0, [x29, #-64]
blk_end_545:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_543_544:
    // Closure for func_543
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_543
    ldr x0, [sp], #16
    bl _cons
    b cond_end_538
cond_false_537:
    adr x0, sign_id
cond_end_538:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _write_list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_570
    tst x0, #1
    b.ne do_compose_568
do_apply_569:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_571
do_compose_568:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_571
do_concat_570:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_571:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_566
    b after_func_572_573
func_572:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_574_575
func_574:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_576_577
func_576:
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
    b.eq cmp_true_581
    adr x0, sign_id
    b cmp_end_582
cmp_true_581:
cmp_end_582:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_579
    mov x0, #0
    b cond_end_580
cond_false_579:
    adr x0, sign_id
cond_end_580:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_578
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_585
    tst x0, #1
    b.ne do_compose_583
do_apply_584:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_586
do_compose_583:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_586
do_concat_585:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_586:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_578
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_589
    tst x0, #1
    b.ne do_compose_587
do_apply_588:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_590
do_compose_587:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_590
do_concat_589:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_590:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_593
    tst x0, #1
    b.ne do_compose_591
do_apply_592:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_594
do_compose_591:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_594
do_concat_593:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_594:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_597
    tst x0, #1
    b.ne do_compose_595
do_apply_596:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_598
do_compose_595:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_598
do_concat_597:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_598:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_601
    tst x0, #1
    b.ne do_compose_599
do_apply_600:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_602
do_compose_599:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_602
do_concat_601:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_602:
blk_end_578:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_576_577:
    // Closure for func_576
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
    adr x1, func_576
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_574_575:
    // Closure for func_574
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_574
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_572_573:
    // Closure for func_572
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_572
    ldr x0, [sp], #16
    bl _cons
    b cond_end_567
cond_false_566:
    adr x0, sign_id
cond_end_567:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tokenize
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_607
    tst x0, #1
    b.ne do_compose_605
do_apply_606:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_608
do_compose_605:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_608
do_concat_607:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_608:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_603
    b after_func_609_610
func_609:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, scan
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_614
    tst x0, #1
    b.ne do_compose_612
do_apply_613:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_615
do_compose_612:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_615
do_concat_614:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_615:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_611
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_611
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_618
    adr x0, sign_id
    b cmp_end_619
cmp_true_618:
cmp_end_619:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_616
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_622
    tst x0, #1
    b.ne do_compose_620
do_apply_621:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_623
do_compose_620:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_623
do_concat_622:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_623:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_626
    tst x0, #1
    b.ne do_compose_624
do_apply_625:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_627
do_compose_624:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_627
do_concat_626:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_627:
    b cond_end_617
cond_false_616:
    adr x0, sign_id
cond_end_617:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_611
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_630
    tst x0, #1
    b.ne do_compose_628
do_apply_629:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_631
do_compose_628:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_631
do_concat_630:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_631:
    str x0, [sp, #-16]!
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_634
    tst x0, #1
    b.ne do_compose_632
do_apply_633:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_635
do_compose_632:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_635
do_concat_634:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_635:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_638
    tst x0, #1
    b.ne do_compose_636
do_apply_637:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_639
do_compose_636:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_639
do_concat_638:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_639:
blk_end_611:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_609_610:
    // Closure for func_609
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_609
    ldr x0, [sp], #16
    bl _cons
    b cond_end_604
cond_false_603:
    adr x0, sign_id
cond_end_604:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_644
    tst x0, #1
    b.ne do_compose_642
do_apply_643:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_645
do_compose_642:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_645
do_concat_644:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_645:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_640
    b after_func_646_647
func_646:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_651
    tst x0, #1
    b.ne do_compose_649
do_apply_650:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_652
do_compose_649:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_652
do_concat_651:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_652:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    adr x0, ch
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_655
    adr x0, sign_id
    b cmp_end_656
cmp_true_655:
cmp_end_656:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_653
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_659
    tst x0, #1
    b.ne do_compose_657
do_apply_658:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_660
do_compose_657:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_660
do_concat_659:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_660:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_663
    tst x0, #1
    b.ne do_compose_661
do_apply_662:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_664
do_compose_661:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_664
do_concat_663:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_664:
    b cond_end_654
cond_false_653:
    adr x0, sign_id
cond_end_654:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    adr x0, is_digit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_669
    tst x0, #1
    b.ne do_compose_667
do_apply_668:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_670
do_compose_667:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_670
do_concat_669:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_670:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_665
    adr x0, scan_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_673
    tst x0, #1
    b.ne do_compose_671
do_apply_672:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_674
do_compose_671:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_674
do_concat_673:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_674:
    b cond_end_666
cond_false_665:
    adr x0, sign_id
cond_end_666:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_675
    adr x0, scan_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_683
    tst x0, #1
    b.ne do_compose_681
do_apply_682:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_684
do_compose_681:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_684
do_concat_683:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_684:
    b cond_end_676
cond_false_675:
    adr x0, sign_id
cond_end_676:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_689
    tst x0, #1
    b.ne do_compose_687
do_apply_688:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_690
do_compose_687:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_690
do_concat_689:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_690:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_685
    adr x0, scan_op
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_693
    tst x0, #1
    b.ne do_compose_691
do_apply_692:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_694
do_compose_691:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_694
do_concat_693:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_694:
    b cond_end_686
cond_false_685:
    adr x0, sign_id
cond_end_686:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_697
    adr x0, sign_id
    b cmp_end_698
cmp_true_697:
cmp_end_698:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_695
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_701
    tst x0, #1
    b.ne do_compose_699
do_apply_700:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_702
do_compose_699:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_702
do_concat_701:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_702:
    b cond_end_696
cond_false_695:
    adr x0, sign_id
cond_end_696:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_705
    adr x0, sign_id
    b cmp_end_706
cmp_true_705:
cmp_end_706:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_703
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_709
    tst x0, #1
    b.ne do_compose_707
do_apply_708:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_710
do_compose_707:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_710
do_concat_709:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_710:
    b cond_end_704
cond_false_703:
    adr x0, sign_id
cond_end_704:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_713
    adr x0, sign_id
    b cmp_end_714
cmp_true_713:
cmp_end_714:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_711
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_718
    tst x0, #1
    b.ne do_compose_716
do_apply_717:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_719
do_compose_716:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_719
do_concat_718:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_719:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_715
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_722
    tst x0, #1
    b.ne do_compose_720
do_apply_721:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_723
do_compose_720:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_723
do_concat_722:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_723:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_726
    tst x0, #1
    b.ne do_compose_724
do_apply_725:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_727
do_compose_724:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_727
do_concat_726:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_727:
blk_end_715:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_730
    tst x0, #1
    b.ne do_compose_728
do_apply_729:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_731
do_compose_728:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_731
do_concat_730:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_731:
    b cond_end_712
cond_false_711:
    adr x0, sign_id
cond_end_712:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #40
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_738
    adr x0, sign_id
    b cmp_end_739
cmp_true_738:
cmp_end_739:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_736
    b or_end_737
or_right_736:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_740
    adr x0, sign_id
    b cmp_end_741
cmp_true_740:
cmp_end_741:
or_end_737:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_734
    b or_end_735
or_right_734:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #123
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_742
    adr x0, sign_id
    b cmp_end_743
cmp_true_742:
cmp_end_743:
or_end_735:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_732
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_747
    tst x0, #1
    b.ne do_compose_745
do_apply_746:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_748
do_compose_745:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_748
do_concat_747:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_748:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_744
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_751
    tst x0, #1
    b.ne do_compose_749
do_apply_750:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_752
do_compose_749:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_752
do_concat_751:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_752:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_755
    tst x0, #1
    b.ne do_compose_753
do_apply_754:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_756
do_compose_753:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_756
do_concat_755:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_756:
blk_end_744:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_759
    tst x0, #1
    b.ne do_compose_757
do_apply_758:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_760
do_compose_757:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_760
do_concat_759:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_760:
    b cond_end_733
cond_false_732:
    adr x0, sign_id
cond_end_733:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #41
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_767
    adr x0, sign_id
    b cmp_end_768
cmp_true_767:
cmp_end_768:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_765
    b or_end_766
or_right_765:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #93
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_769
    adr x0, sign_id
    b cmp_end_770
cmp_true_769:
cmp_end_770:
or_end_766:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_763
    b or_end_764
or_right_763:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #125
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_771
    adr x0, sign_id
    b cmp_end_772
cmp_true_771:
cmp_end_772:
or_end_764:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_761
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_776
    tst x0, #1
    b.ne do_compose_774
do_apply_775:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_777
do_compose_774:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_777
do_concat_776:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_777:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_773
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_780
    tst x0, #1
    b.ne do_compose_778
do_apply_779:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_781
do_compose_778:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_781
do_concat_780:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_781:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_784
    tst x0, #1
    b.ne do_compose_782
do_apply_783:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_785
do_compose_782:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_785
do_concat_784:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_785:
blk_end_773:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_788
    tst x0, #1
    b.ne do_compose_786
do_apply_787:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_789
do_compose_786:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_789
do_concat_788:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_789:
    b cond_end_762
cond_false_761:
    adr x0, sign_id
cond_end_762:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_792
    tst x0, #1
    b.ne do_compose_790
do_apply_791:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_793
do_compose_790:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_793
do_concat_792:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_793:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_648
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_796
    tst x0, #1
    b.ne do_compose_794
do_apply_795:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_797
do_compose_794:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_797
do_concat_796:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_797:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_800
    tst x0, #1
    b.ne do_compose_798
do_apply_799:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_801
do_compose_798:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_801
do_concat_800:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_801:
blk_end_648:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_646_647:
    // Closure for func_646
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_646
    ldr x0, [sp], #16
    bl _cons
    b cond_end_641
cond_false_640:
    adr x0, sign_id
cond_end_641:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, skip_space
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_806
    tst x0, #1
    b.ne do_compose_804
do_apply_805:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_807
do_compose_804:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_807
do_concat_806:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_807:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_802
    b after_func_808_809
func_808:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x0, [x0] // @ load
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_815
    tst x0, #1
    b.ne do_compose_813
do_apply_814:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_816
do_compose_813:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_816
do_concat_815:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_816:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_811
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_820
    tst x0, #1
    b.ne do_compose_818
do_apply_819:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_821
do_compose_818:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_821
do_concat_820:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_821:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_817
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_824
    tst x0, #1
    b.ne do_compose_822
do_apply_823:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_825
do_compose_822:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_825
do_concat_824:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_825:
blk_end_817:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_828
    tst x0, #1
    b.ne do_compose_826
do_apply_827:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_829
do_compose_826:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_829
do_concat_828:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_829:
    b cond_end_812
cond_false_811:
    adr x0, sign_id
cond_end_812:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_810
    mov x0, #0
blk_end_810:
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
    b cond_end_803
cond_false_802:
    adr x0, sign_id
cond_end_803:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_834
    tst x0, #1
    b.ne do_compose_832
do_apply_833:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_835
do_compose_832:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_835
do_concat_834:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_835:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_830
    b after_func_836_837
func_836:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_841
    tst x0, #1
    b.ne do_compose_839
do_apply_840:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_842
do_compose_839:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_842
do_concat_841:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_842:
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_845
    tst x0, #1
    b.ne do_compose_843
do_apply_844:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_846
do_compose_843:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_846
do_concat_845:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_846:
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_838
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_857
    tst x0, #1
    b.ne do_compose_855
do_apply_856:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_858
do_compose_855:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_858
do_concat_857:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_858:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_838
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_861
    tst x0, #1
    b.ne do_compose_859
do_apply_860:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_862
do_compose_859:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_862
do_concat_861:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_862:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_865
    tst x0, #1
    b.ne do_compose_863
do_apply_864:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_866
do_compose_863:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_866
do_concat_865:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_866:
blk_end_838:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_836_837:
    // Closure for func_836
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_836
    ldr x0, [sp], #16
    bl _cons
    b cond_end_831
cond_false_830:
    adr x0, sign_id
cond_end_831:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_871
    tst x0, #1
    b.ne do_compose_869
do_apply_870:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_872
do_compose_869:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_872
do_concat_871:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_872:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_867
    b after_func_873_874
func_873:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_878
    b or_end_879
or_right_878:
    adr x0, is_digit
or_end_879:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_882
    tst x0, #1
    b.ne do_compose_880
do_apply_881:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_883
do_compose_880:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_883
do_concat_882:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_883:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_886
    tst x0, #1
    b.ne do_compose_884
do_apply_885:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_887
do_compose_884:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_887
do_concat_886:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_887:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_876
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_890
    tst x0, #1
    b.ne do_compose_888
do_apply_889:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_891
do_compose_888:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_891
do_concat_890:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_891:
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_894
    tst x0, #1
    b.ne do_compose_892
do_apply_893:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_895
do_compose_892:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_895
do_concat_894:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_895:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_898
    tst x0, #1
    b.ne do_compose_896
do_apply_897:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_899
do_compose_896:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_899
do_concat_898:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_899:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_902
    tst x0, #1
    b.ne do_compose_900
do_apply_901:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_903
do_compose_900:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_903
do_concat_902:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_903:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_906
    tst x0, #1
    b.ne do_compose_904
do_apply_905:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_907
do_compose_904:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_907
do_concat_906:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_907:
    b cond_end_877
cond_false_876:
    adr x0, sign_id
cond_end_877:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_875
    mov x0, #0
blk_end_875:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_873_874:
    // Closure for func_873
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_873
    ldr x0, [sp], #16
    bl _cons
    b cond_end_868
cond_false_867:
    adr x0, sign_id
cond_end_868:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_num
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_912
    tst x0, #1
    b.ne do_compose_910
do_apply_911:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_913
do_compose_910:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_913
do_concat_912:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_913:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_908
    b after_func_914_915
func_914:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_919
    tst x0, #1
    b.ne do_compose_917
do_apply_918:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_920
do_compose_917:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_920
do_concat_919:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_920:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_923
    tst x0, #1
    b.ne do_compose_921
do_apply_922:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_924
do_compose_921:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_924
do_concat_923:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_924:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_916
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_927
    tst x0, #1
    b.ne do_compose_925
do_apply_926:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_928
do_compose_925:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_928
do_concat_927:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_928:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_931
    tst x0, #1
    b.ne do_compose_929
do_apply_930:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_932
do_compose_929:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_932
do_concat_931:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_932:
blk_end_916:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_914_915:
    // Closure for func_914
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_914
    ldr x0, [sp], #16
    bl _cons
    b cond_end_909
cond_false_908:
    adr x0, sign_id
cond_end_909:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_937
    tst x0, #1
    b.ne do_compose_935
do_apply_936:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_938
do_compose_935:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_938
do_concat_937:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_938:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_933
    b after_func_939_940
func_939:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_941_942
func_941:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_948
    tst x0, #1
    b.ne do_compose_946
do_apply_947:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_949
do_compose_946:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_949
do_concat_948:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_949:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_944
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
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_950
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_953
    tst x0, #1
    b.ne do_compose_951
do_apply_952:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_954
do_compose_951:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_954
do_concat_953:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_954:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_957
    tst x0, #1
    b.ne do_compose_955
do_apply_956:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_958
do_compose_955:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_958
do_concat_957:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_958:
    str x0, [sp, #-16]!
    adr x0, val
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_961
    tst x0, #1
    b.ne do_compose_959
do_apply_960:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_962
do_compose_959:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_962
do_concat_961:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_962:
blk_end_950:
    b cond_end_945
cond_false_944:
    adr x0, sign_id
cond_end_945:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_943
    ldr x0, [x29, #-32]
blk_end_943:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_941_942:
    // Closure for func_941
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_941
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_939_940:
    // Closure for func_939
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_939
    ldr x0, [sp], #16
    bl _cons
    b cond_end_934
cond_false_933:
    adr x0, sign_id
cond_end_934:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_op
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_963
    b after_func_969_970
func_969:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_974
    tst x0, #1
    b.ne do_compose_972
do_apply_973:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_975
do_compose_972:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_975
do_concat_974:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_975:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_978
    tst x0, #1
    b.ne do_compose_976
do_apply_977:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_979
do_compose_976:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_979
do_concat_978:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_979:
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_982
    tst x0, #1
    b.ne do_compose_980
do_apply_981:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_983
do_compose_980:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_983
do_concat_982:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_983:
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_971
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_994
    tst x0, #1
    b.ne do_compose_992
do_apply_993:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_995
do_compose_992:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_995
do_concat_994:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_995:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_971
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_998
    tst x0, #1
    b.ne do_compose_996
do_apply_997:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_999
do_compose_996:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_999
do_concat_998:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_999:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1002
    tst x0, #1
    b.ne do_compose_1000
do_apply_1001:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1003
do_compose_1000:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1003
do_concat_1002:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1003:
blk_end_971:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_969_970:
    // Closure for func_969
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_969
    ldr x0, [sp], #16
    bl _cons
    b cond_end_964
cond_false_963:
    adr x0, sign_id
cond_end_964:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1008
    tst x0, #1
    b.ne do_compose_1006
do_apply_1007:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1009
do_compose_1006:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1009
do_concat_1008:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1009:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1004
    b after_func_1010_1011
func_1010:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1017
    tst x0, #1
    b.ne do_compose_1015
do_apply_1016:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1018
do_compose_1015:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1018
do_concat_1017:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1018:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1013
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1021
    tst x0, #1
    b.ne do_compose_1019
do_apply_1020:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1022
do_compose_1019:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1022
do_concat_1021:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1022:
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1025
    tst x0, #1
    b.ne do_compose_1023
do_apply_1024:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1026
do_compose_1023:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1026
do_concat_1025:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1026:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1029
    tst x0, #1
    b.ne do_compose_1027
do_apply_1028:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1030
do_compose_1027:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1030
do_concat_1029:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1030:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1033
    tst x0, #1
    b.ne do_compose_1031
do_apply_1032:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1034
do_compose_1031:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1034
do_concat_1033:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1034:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1037
    tst x0, #1
    b.ne do_compose_1035
do_apply_1036:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1038
do_compose_1035:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1038
do_concat_1037:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1038:
    b cond_end_1014
cond_false_1013:
    adr x0, sign_id
cond_end_1014:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1012
    mov x0, #0
blk_end_1012:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1010_1011:
    // Closure for func_1010
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1010
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1005
cond_false_1004:
    adr x0, sign_id
cond_end_1005:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_str
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1043
    tst x0, #1
    b.ne do_compose_1041
do_apply_1042:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1044
do_compose_1041:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1044
do_concat_1043:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1044:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1039
    b after_func_1045_1046
func_1045:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1050
    tst x0, #1
    b.ne do_compose_1048
do_apply_1049:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1051
do_compose_1048:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1051
do_concat_1050:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1051:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1058
    tst x0, #1
    b.ne do_compose_1056
do_apply_1057:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1059
do_compose_1056:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1059
do_concat_1058:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1059:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1047
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1062
    tst x0, #1
    b.ne do_compose_1060
do_apply_1061:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1063
do_compose_1060:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1063
do_concat_1062:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1063:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1066
    tst x0, #1
    b.ne do_compose_1064
do_apply_1065:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1067
do_compose_1064:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1067
do_concat_1066:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1067:
blk_end_1047:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1045_1046:
    // Closure for func_1045
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1045
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1040
cond_false_1039:
    adr x0, sign_id
cond_end_1040:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1072
    tst x0, #1
    b.ne do_compose_1070
do_apply_1071:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1073
do_compose_1070:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1073
do_concat_1072:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1073:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1068
    b after_func_1074_1075
func_1074:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1081
    adr x0, sign_id
    b cmp_end_1082
cmp_true_1081:
cmp_end_1082:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1079
    b or_end_1080
or_right_1079:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1083
    adr x0, sign_id
    b cmp_end_1084
cmp_true_1083:
cmp_end_1084:
or_end_1080:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1077
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1088
    tst x0, #1
    b.ne do_compose_1086
do_apply_1087:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1089
do_compose_1086:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1089
do_concat_1088:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1089:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1085
    mov x0, #0
blk_end_1085:
    b cond_end_1078
cond_false_1077:
    adr x0, sign_id
cond_end_1078:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1076
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1092
    tst x0, #1
    b.ne do_compose_1090
do_apply_1091:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1093
do_compose_1090:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1093
do_concat_1092:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1093:
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1096
    tst x0, #1
    b.ne do_compose_1094
do_apply_1095:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1097
do_compose_1094:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1097
do_concat_1096:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1097:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1100
    tst x0, #1
    b.ne do_compose_1098
do_apply_1099:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1101
do_compose_1098:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1101
do_concat_1100:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1101:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1104
    tst x0, #1
    b.ne do_compose_1102
do_apply_1103:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1105
do_compose_1102:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1105
do_concat_1104:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1105:
blk_end_1076:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1074_1075:
    // Closure for func_1074
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1074
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1069
cond_false_1068:
    adr x0, sign_id
cond_end_1069:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1108
    tst x0, #1
    b.ne do_compose_1106
do_apply_1107:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1109
do_compose_1106:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1109
do_concat_1108:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1109:
    str x0, [sp, #-16]!
    adr x0, Parser
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1112
    tst x0, #1
    b.ne do_compose_1110
do_apply_1111:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1113
do_compose_1110:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1113
do_concat_1112:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1113:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Parses
    str x0, [sp, #-16]!
    adr x0, token
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
    adr x0, list
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
    str x0, [sp, #-16]!
    adr x0, into
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1124
    tst x0, #1
    b.ne do_compose_1122
do_apply_1123:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1125
do_compose_1122:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1125
do_concat_1124:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1125:
    str x0, [sp, #-16]!
    adr x0, AST
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1128
    tst x0, #1
    b.ne do_compose_1126
do_apply_1127:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1129
do_compose_1126:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1129
do_concat_1128:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1129:
    str x0, [sp, #-16]!
    adr x0, S
    str x0, [sp, #-16]!
    adr x0, expressions
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1132
    tst x0, #1
    b.ne do_compose_1130
do_apply_1131:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1133
do_compose_1130:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1133
do_concat_1132:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1133:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1138
    tst x0, #1
    b.ne do_compose_1136
do_apply_1137:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1139
do_compose_1136:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1139
do_concat_1138:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1139:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1134
    b after_func_1140_1141
func_1140:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1142_1143
func_1142:
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
    b.eq cmp_true_1147
    adr x0, sign_id
    b cmp_end_1148
cmp_true_1147:
cmp_end_1148:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1145
    mov x0, #1
    b cond_end_1146
cond_false_1145:
    adr x0, sign_id
cond_end_1146:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1151
    adr x0, sign_id
    b cmp_end_1152
cmp_true_1151:
cmp_end_1152:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1149
    mov x0, #0
    b cond_end_1150
cond_false_1149:
    adr x0, sign_id
cond_end_1150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1155
    adr x0, sign_id
    b cmp_end_1156
cmp_true_1155:
cmp_end_1156:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1153
    mov x0, #1
    b cond_end_1154
cond_false_1153:
    adr x0, sign_id
cond_end_1154:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1159
    tst x0, #1
    b.ne do_compose_1157
do_apply_1158:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1160
do_compose_1157:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1160
do_concat_1159:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1160:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1163
    tst x0, #1
    b.ne do_compose_1161
do_apply_1162:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1164
do_compose_1161:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1164
do_concat_1163:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1164:
blk_end_1144:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1142_1143:
    // Closure for func_1142
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1142
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1135
cond_false_1134:
    adr x0, sign_id
cond_end_1135:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_semicolon_str
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1169
    tst x0, #1
    b.ne do_compose_1167
do_apply_1168:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1170
do_compose_1167:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1170
do_concat_1169:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1170:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1165
    b after_func_1171_1172
func_1171:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1176
    tst x0, #1
    b.ne do_compose_1174
do_apply_1175:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1177
do_compose_1174:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1177
do_concat_1176:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1177:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1173
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #59
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1173
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1173
    ldr x0, [x29, #-48]
blk_end_1173:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1171_1172:
    // Closure for func_1171
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1171
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1166
cond_false_1165:
    adr x0, sign_id
cond_end_1166:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_bar_str
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1182
    tst x0, #1
    b.ne do_compose_1180
do_apply_1181:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1183
do_compose_1180:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1183
do_concat_1182:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1183:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1178
    b after_func_1184_1185
func_1184:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1186
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #124
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1186
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1186
    ldr x0, [x29, #-48]
blk_end_1186:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1184_1185:
    // Closure for func_1184
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1184
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1179
cond_false_1178:
    adr x0, sign_id
cond_end_1179:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_lt_str
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1195
    tst x0, #1
    b.ne do_compose_1193
do_apply_1194:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1196
do_compose_1193:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1196
do_concat_1195:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1196:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1191
    b after_func_1197_1198
func_1197:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1202
    tst x0, #1
    b.ne do_compose_1200
do_apply_1201:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1203
do_compose_1200:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1203
do_concat_1202:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1203:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    ldr x0, [x29, #-48]
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
    b cond_end_1192
cond_false_1191:
    adr x0, sign_id
cond_end_1192:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_gt_str
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1208
    tst x0, #1
    b.ne do_compose_1206
do_apply_1207:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1209
do_compose_1206:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1209
do_concat_1208:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1209:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1204
    b after_func_1210_1211
func_1210:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
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
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1212
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1212
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1212
    ldr x0, [x29, #-48]
blk_end_1212:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1210_1211:
    // Closure for func_1210
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1210
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1205
cond_false_1204:
    adr x0, sign_id
cond_end_1205:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_prec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1221
    tst x0, #1
    b.ne do_compose_1219
do_apply_1220:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1222
do_compose_1219:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1222
do_concat_1221:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1222:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1217
    b after_func_1223_1224
func_1223:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1230
    tst x0, #1
    b.ne do_compose_1228
do_apply_1229:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1231
do_compose_1228:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1231
do_concat_1230:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1231:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1234
    tst x0, #1
    b.ne do_compose_1232
do_apply_1233:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1235
do_compose_1232:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1235
do_concat_1234:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1235:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1226
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_1227
cond_false_1226:
    adr x0, sign_id
cond_end_1227:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1240
    tst x0, #1
    b.ne do_compose_1238
do_apply_1239:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1241
do_compose_1238:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1241
do_concat_1240:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1241:
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1244
    tst x0, #1
    b.ne do_compose_1242
do_apply_1243:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1245
do_compose_1242:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1245
do_concat_1244:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1245:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1236
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_1237
cond_false_1236:
    adr x0, sign_id
cond_end_1237:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1250
    tst x0, #1
    b.ne do_compose_1248
do_apply_1249:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1251
do_compose_1248:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1251
do_concat_1250:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1251:
    str x0, [sp, #-16]!
    mov x0, #37
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1254
    tst x0, #1
    b.ne do_compose_1252
do_apply_1253:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1255
do_compose_1252:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1255
do_concat_1254:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1255:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1246
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_1247
cond_false_1246:
    adr x0, sign_id
cond_end_1247:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1260
    tst x0, #1
    b.ne do_compose_1258
do_apply_1259:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1261
do_compose_1258:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1261
do_concat_1260:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1261:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1264
    tst x0, #1
    b.ne do_compose_1262
do_apply_1263:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1265
do_compose_1262:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1265
do_concat_1264:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1265:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1256
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_1257
cond_false_1256:
    adr x0, sign_id
cond_end_1257:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov x0, #45
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1266
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_1267
cond_false_1266:
    adr x0, sign_id
cond_end_1267:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1280
    tst x0, #1
    b.ne do_compose_1278
do_apply_1279:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1281
do_compose_1278:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1281
do_concat_1280:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1281:
    str x0, [sp, #-16]!
    adr x0, get_lt_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1284
    tst x0, #1
    b.ne do_compose_1282
do_apply_1283:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1285
do_compose_1282:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1285
do_concat_1284:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1285:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1288
    tst x0, #1
    b.ne do_compose_1286
do_apply_1287:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1289
do_compose_1286:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1289
do_concat_1288:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1289:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1276
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_1277
cond_false_1276:
    adr x0, sign_id
cond_end_1277:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1294
    tst x0, #1
    b.ne do_compose_1292
do_apply_1293:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1295
do_compose_1292:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1295
do_concat_1294:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1295:
    str x0, [sp, #-16]!
    adr x0, get_gt_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1298
    tst x0, #1
    b.ne do_compose_1296
do_apply_1297:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1299
do_compose_1296:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1299
do_concat_1298:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1299:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1302
    tst x0, #1
    b.ne do_compose_1300
do_apply_1301:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1303
do_compose_1300:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1303
do_concat_1302:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1303:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1290
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_1291
cond_false_1290:
    adr x0, sign_id
cond_end_1291:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1308
    tst x0, #1
    b.ne do_compose_1306
do_apply_1307:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1309
do_compose_1306:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1309
do_concat_1308:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1309:
    str x0, [sp, #-16]!
    mov x0, #61
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1312
    tst x0, #1
    b.ne do_compose_1310
do_apply_1311:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1313
do_compose_1310:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1313
do_concat_1312:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1313:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1304
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_1305
cond_false_1304:
    adr x0, sign_id
cond_end_1305:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1318
    tst x0, #1
    b.ne do_compose_1316
do_apply_1317:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1319
do_compose_1316:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1319
do_concat_1318:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1319:
    str x0, [sp, #-16]!
    adr x0, get_semicolon_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1322
    tst x0, #1
    b.ne do_compose_1320
do_apply_1321:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1323
do_compose_1320:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1323
do_concat_1322:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1323:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1326
    tst x0, #1
    b.ne do_compose_1324
do_apply_1325:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1327
do_compose_1324:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1327
do_concat_1326:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1327:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1314
    adr x0, PREC_XOR
    ldr x0, [x0]
    b cond_end_1315
cond_false_1314:
    adr x0, sign_id
cond_end_1315:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1332
    tst x0, #1
    b.ne do_compose_1330
do_apply_1331:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1333
do_compose_1330:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1333
do_concat_1332:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1333:
    str x0, [sp, #-16]!
    adr x0, get_bar_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1336
    tst x0, #1
    b.ne do_compose_1334
do_apply_1335:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1337
do_compose_1334:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1337
do_concat_1336:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1337:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1340
    tst x0, #1
    b.ne do_compose_1338
do_apply_1339:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1341
do_compose_1338:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1341
do_concat_1340:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1341:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1328
    adr x0, PREC_OR
    ldr x0, [x0]
    b cond_end_1329
cond_false_1328:
    adr x0, sign_id
cond_end_1329:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1346
    tst x0, #1
    b.ne do_compose_1344
do_apply_1345:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1347
do_compose_1344:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1347
do_concat_1346:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1347:
    str x0, [sp, #-16]!
    mov x0, #38
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1350
    tst x0, #1
    b.ne do_compose_1348
do_apply_1349:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1351
do_compose_1348:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1351
do_concat_1350:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1351:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1342
    adr x0, PREC_AND
    ldr x0, [x0]
    b cond_end_1343
cond_false_1342:
    adr x0, sign_id
cond_end_1343:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1356
    tst x0, #1
    b.ne do_compose_1354
do_apply_1355:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1357
do_compose_1354:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1357
do_concat_1356:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1357:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1360
    tst x0, #1
    b.ne do_compose_1358
do_apply_1359:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1361
do_compose_1358:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1361
do_concat_1360:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1361:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1352
    mov x0, #5
    b cond_end_1353
cond_false_1352:
    adr x0, sign_id
cond_end_1353:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1366
    tst x0, #1
    b.ne do_compose_1364
do_apply_1365:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1367
do_compose_1364:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1367
do_concat_1366:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1367:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1370
    tst x0, #1
    b.ne do_compose_1368
do_apply_1369:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1371
do_compose_1368:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1371
do_concat_1370:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1371:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1362
    mov x0, #6
    b cond_end_1363
cond_false_1362:
    adr x0, sign_id
cond_end_1363:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1376
    tst x0, #1
    b.ne do_compose_1374
do_apply_1375:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1377
do_compose_1374:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1377
do_concat_1376:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1377:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1380
    tst x0, #1
    b.ne do_compose_1378
do_apply_1379:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1381
do_compose_1378:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1381
do_concat_1380:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1381:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1372
    mov x0, #2
    b cond_end_1373
cond_false_1372:
    adr x0, sign_id
cond_end_1373:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1225
    mov x0, #0
blk_end_1225:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1223_1224:
    // Closure for func_1223
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1223
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1218
cond_false_1217:
    adr x0, sign_id
cond_end_1218:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_right_assoc
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1386
    tst x0, #1
    b.ne do_compose_1384
do_apply_1385:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1387
do_compose_1384:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1387
do_concat_1386:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1387:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1382
    b after_func_1388_1389
func_1388:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1395
    tst x0, #1
    b.ne do_compose_1393
do_apply_1394:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1396
do_compose_1393:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1396
do_concat_1395:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1396:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1399
    tst x0, #1
    b.ne do_compose_1397
do_apply_1398:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1400
do_compose_1397:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1400
do_concat_1399:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1400:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1391
    mov x0, #1
    b cond_end_1392
cond_false_1391:
    adr x0, sign_id
cond_end_1392:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1390
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1405
    tst x0, #1
    b.ne do_compose_1403
do_apply_1404:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1406
do_compose_1403:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1406
do_concat_1405:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1406:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1409
    tst x0, #1
    b.ne do_compose_1407
do_apply_1408:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1410
do_compose_1407:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1410
do_concat_1409:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1410:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1401
    mov x0, #1
    b cond_end_1402
cond_false_1401:
    adr x0, sign_id
cond_end_1402:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1390
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1415
    tst x0, #1
    b.ne do_compose_1413
do_apply_1414:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1416
do_compose_1413:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1416
do_concat_1415:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1416:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1419
    tst x0, #1
    b.ne do_compose_1417
do_apply_1418:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1420
do_compose_1417:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1420
do_concat_1419:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1420:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1411
    mov x0, #1
    b cond_end_1412
cond_false_1411:
    adr x0, sign_id
cond_end_1412:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1390
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1425
    tst x0, #1
    b.ne do_compose_1423
do_apply_1424:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1426
do_compose_1423:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1426
do_concat_1425:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1426:
    str x0, [sp, #-16]!
    mov x0, #94
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1429
    tst x0, #1
    b.ne do_compose_1427
do_apply_1428:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1430
do_compose_1427:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1430
do_concat_1429:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1430:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1421
    mov x0, #1
    b cond_end_1422
cond_false_1421:
    adr x0, sign_id
cond_end_1422:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1390
    mov x0, #0
blk_end_1390:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1388_1389:
    // Closure for func_1388
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1388
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1383
cond_false_1382:
    adr x0, sign_id
cond_end_1383:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1435
    tst x0, #1
    b.ne do_compose_1433
do_apply_1434:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1436
do_compose_1433:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1436
do_concat_1435:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1436:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1431
    b after_func_1437_1438
func_1437:
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
    b.ne blk_end_1439
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1442
    tst x0, #1
    b.ne do_compose_1440
do_apply_1441:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1443
do_compose_1440:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1443
do_concat_1442:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1443:
blk_end_1439:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1437_1438:
    // Closure for func_1437
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1437
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1432
cond_false_1431:
    adr x0, sign_id
cond_end_1432:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, advance
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1448
    tst x0, #1
    b.ne do_compose_1446
do_apply_1447:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1449
do_compose_1446:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1449
do_concat_1448:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1449:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1444
    b after_func_1450_1451
func_1450:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p_tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1455
    adr x0, sign_id
    b cmp_end_1456
cmp_true_1455:
cmp_end_1456:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1453
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, p_curr
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1460
    tst x0, #1
    b.ne do_compose_1458
do_apply_1459:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1461
do_compose_1458:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1461
do_concat_1460:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1461:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1464
    tst x0, #1
    b.ne do_compose_1462
do_apply_1463:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1465
do_compose_1462:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1465
do_concat_1464:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1465:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1457
    mov x0, #0
blk_end_1457:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1468
    tst x0, #1
    b.ne do_compose_1466
do_apply_1467:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1469
do_compose_1466:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1469
do_concat_1468:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1469:
    b cond_end_1454
cond_false_1453:
    adr x0, sign_id
cond_end_1454:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1452
    adr x0, p_curr
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, p_tokens
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1472
    tst x0, #1
    b.ne do_compose_1470
do_apply_1471:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1473
do_compose_1470:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1473
do_concat_1472:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1473:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1452
    adr x0, p_tokens
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, p_tokens
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1476
    tst x0, #1
    b.ne do_compose_1474
do_apply_1475:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1477
do_compose_1474:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1477
do_concat_1476:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1477:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1452
    adr x0, p_curr
blk_end_1452:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1450_1451:
    // Closure for func_1450
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1450
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1445
cond_false_1444:
    adr x0, sign_id
cond_end_1445:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, peek_type
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1482
    tst x0, #1
    b.ne do_compose_1480
do_apply_1481:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1483
do_compose_1480:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1483
do_concat_1482:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1483:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1478
    b after_func_1484_1485
func_1484:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1488
    tst x0, #1
    b.ne do_compose_1486
do_apply_1487:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1489
do_compose_1486:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1489
do_concat_1488:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1489:
    ldr x0, [x0] // @ load
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
    b cond_end_1479
cond_false_1478:
    adr x0, sign_id
cond_end_1479:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, peek_val
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1494
    tst x0, #1
    b.ne do_compose_1492
do_apply_1493:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1495
do_compose_1492:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1495
do_concat_1494:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1495:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1490
    b after_func_1496_1497
func_1496:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1500
    tst x0, #1
    b.ne do_compose_1498
do_apply_1499:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1501
do_compose_1498:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1501
do_concat_1500:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1501:
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1496_1497:
    // Closure for func_1496
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1496
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1491
cond_false_1490:
    adr x0, sign_id
cond_end_1491:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expect_val
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1506
    tst x0, #1
    b.ne do_compose_1504
do_apply_1505:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1507
do_compose_1504:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1507
do_concat_1506:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1507:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1502
    b after_func_1508_1509
func_1508:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1513
    tst x0, #1
    b.ne do_compose_1511
do_apply_1512:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1514
do_compose_1511:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1514
do_concat_1513:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1514:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1510
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1517
    adr x0, sign_id
    b cmp_end_1518
cmp_true_1517:
cmp_end_1518:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1515
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1522
    tst x0, #1
    b.ne do_compose_1520
do_apply_1521:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1523
do_compose_1520:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1523
do_concat_1522:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1523:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1519
    mov x0, #1
blk_end_1519:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1526
    tst x0, #1
    b.ne do_compose_1524
do_apply_1525:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1527
do_compose_1524:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1527
do_concat_1526:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1527:
    b cond_end_1516
cond_false_1515:
    adr x0, sign_id
cond_end_1516:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1510
    mov x0, #0
blk_end_1510:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1508_1509:
    // Closure for func_1508
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1508
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1503
cond_false_1502:
    adr x0, sign_id
cond_end_1503:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expect_type
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1532
    tst x0, #1
    b.ne do_compose_1530
do_apply_1531:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1533
do_compose_1530:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1533
do_concat_1532:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1533:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1528
    b after_func_1534_1535
func_1534:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1539
    tst x0, #1
    b.ne do_compose_1537
do_apply_1538:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1540
do_compose_1537:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1540
do_concat_1539:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1540:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1536
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1543
    adr x0, sign_id
    b cmp_end_1544
cmp_true_1543:
cmp_end_1544:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1541
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1548
    tst x0, #1
    b.ne do_compose_1546
do_apply_1547:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1549
do_compose_1546:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1549
do_concat_1548:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1549:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    mov x0, #1
blk_end_1545:
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
    b cond_end_1542
cond_false_1541:
    adr x0, sign_id
cond_end_1542:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1536
    mov x0, #0
blk_end_1536:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1534_1535:
    // Closure for func_1534
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1534
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1529
cond_false_1528:
    adr x0, sign_id
cond_end_1529:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, can_start_expr
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1558
    tst x0, #1
    b.ne do_compose_1556
do_apply_1557:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1559
do_compose_1556:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1559
do_concat_1558:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1559:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1554
    b after_func_1560_1561
func_1560:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1565
    tst x0, #1
    b.ne do_compose_1563
do_apply_1564:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1566
do_compose_1563:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1566
do_concat_1565:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1566:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1562
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1569
    adr x0, sign_id
    b cmp_end_1570
cmp_true_1569:
cmp_end_1570:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1567
    mov x0, #1
    b cond_end_1568
cond_false_1567:
    adr x0, sign_id
cond_end_1568:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1562
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1573
    adr x0, sign_id
    b cmp_end_1574
cmp_true_1573:
cmp_end_1574:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1571
    mov x0, #1
    b cond_end_1572
cond_false_1571:
    adr x0, sign_id
cond_end_1572:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1562
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1577
    adr x0, sign_id
    b cmp_end_1578
cmp_true_1577:
cmp_end_1578:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1575
    mov x0, #1
    b cond_end_1576
cond_false_1575:
    adr x0, sign_id
cond_end_1576:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1562
    mov x0, #0
blk_end_1562:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1560_1561:
    // Closure for func_1560
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1560
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1555
cond_false_1554:
    adr x0, sign_id
cond_end_1555:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_program
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1583
    tst x0, #1
    b.ne do_compose_1581
do_apply_1582:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1584
do_compose_1581:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1584
do_concat_1583:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1584:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1579
    b after_func_1585_1586
func_1585:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1590
    tst x0, #1
    b.ne do_compose_1588
do_apply_1589:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1591
do_compose_1588:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1591
do_concat_1590:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1591:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1587
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1594
    adr x0, sign_id
    b cmp_end_1595
cmp_true_1594:
cmp_end_1595:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1592
    mov x0, #0
    b cond_end_1593
cond_false_1592:
    adr x0, sign_id
cond_end_1593:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1587
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1598
    adr x0, sign_id
    b cmp_end_1599
cmp_true_1598:
cmp_end_1599:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1596
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1600
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_1600:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1611
    tst x0, #1
    b.ne do_compose_1609
do_apply_1610:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1612
do_compose_1609:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1612
do_concat_1611:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1612:
    b cond_end_1597
cond_false_1596:
    adr x0, sign_id
cond_end_1597:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1587
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1615
    tst x0, #1
    b.ne do_compose_1613
do_apply_1614:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1616
do_compose_1613:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1616
do_concat_1615:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1616:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1587
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1619
    tst x0, #1
    b.ne do_compose_1617
do_apply_1618:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1620
do_compose_1617:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1620
do_concat_1619:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1620:
    str x0, [sp, #-16]!
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1623
    tst x0, #1
    b.ne do_compose_1621
do_apply_1622:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1624
do_compose_1621:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1624
do_concat_1623:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1624:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1627
    tst x0, #1
    b.ne do_compose_1625
do_apply_1626:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1628
do_compose_1625:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1628
do_concat_1627:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1628:
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
    b cond_end_1580
cond_false_1579:
    adr x0, sign_id
cond_end_1580:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1629
    b after_func_1635_1636
func_1635:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1640
    tst x0, #1
    b.ne do_compose_1638
do_apply_1639:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1641
do_compose_1638:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1641
do_concat_1640:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1641:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1637
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1644
    adr x0, sign_id
    b cmp_end_1645
cmp_true_1644:
cmp_end_1645:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1642
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1649
    tst x0, #1
    b.ne do_compose_1647
do_apply_1648:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1650
do_compose_1647:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1650
do_concat_1649:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1650:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1646
    adr x0, parse_block
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1653
    tst x0, #1
    b.ne do_compose_1651
do_apply_1652:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1654
do_compose_1651:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1654
do_concat_1653:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1654:
blk_end_1646:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1657
    tst x0, #1
    b.ne do_compose_1655
do_apply_1656:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1658
do_compose_1655:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1658
do_concat_1657:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1658:
    b cond_end_1643
cond_false_1642:
    adr x0, sign_id
cond_end_1643:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1637
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1661
    tst x0, #1
    b.ne do_compose_1659
do_apply_1660:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1662
do_compose_1659:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1662
do_concat_1661:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1662:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1637
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1665
    tst x0, #1
    b.ne do_compose_1663
do_apply_1664:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1666
do_compose_1663:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1666
do_concat_1665:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1666:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1637
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1669
    adr x0, sign_id
    b cmp_end_1670
cmp_true_1669:
cmp_end_1670:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1667
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1674
    tst x0, #1
    b.ne do_compose_1672
do_apply_1673:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1675
do_compose_1672:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1675
do_concat_1674:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1675:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1671
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1678
    tst x0, #1
    b.ne do_compose_1676
do_apply_1677:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1679
do_compose_1676:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1679
do_concat_1678:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1679:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1671
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1682
    adr x0, sign_id
    b cmp_end_1683
cmp_true_1682:
cmp_end_1683:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1680
    ldr x0, [x29, #-64]
    b cond_end_1681
cond_false_1680:
    adr x0, sign_id
cond_end_1681:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1671
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1686
    tst x0, #1
    b.ne do_compose_1684
do_apply_1685:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1687
do_compose_1684:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1687
do_concat_1686:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1687:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1690
    tst x0, #1
    b.ne do_compose_1688
do_apply_1689:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1691
do_compose_1688:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1691
do_concat_1690:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1691:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1694
    tst x0, #1
    b.ne do_compose_1692
do_apply_1693:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1695
do_compose_1692:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1695
do_concat_1694:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1695:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1698
    tst x0, #1
    b.ne do_compose_1696
do_apply_1697:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1699
do_compose_1696:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1699
do_concat_1698:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1699:
blk_end_1671:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1702
    tst x0, #1
    b.ne do_compose_1700
do_apply_1701:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1703
do_compose_1700:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1703
do_concat_1702:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1703:
    b cond_end_1668
cond_false_1667:
    adr x0, sign_id
cond_end_1668:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1637
    ldr x0, [x29, #-64]
blk_end_1637:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1635_1636:
    // Closure for func_1635
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1635
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1630
cond_false_1629:
    adr x0, sign_id
cond_end_1630:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block_rest
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1708
    tst x0, #1
    b.ne do_compose_1706
do_apply_1707:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1709
do_compose_1706:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1709
do_concat_1708:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1709:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1704
    b after_func_1710_1711
func_1710:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1715
    tst x0, #1
    b.ne do_compose_1713
do_apply_1714:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1716
do_compose_1713:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1716
do_concat_1715:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1716:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1712
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1719
    adr x0, sign_id
    b cmp_end_1720
cmp_true_1719:
cmp_end_1720:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1717
    mov x0, #0
    b cond_end_1718
cond_false_1717:
    adr x0, sign_id
cond_end_1718:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1712
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1723
    adr x0, sign_id
    b cmp_end_1724
cmp_true_1723:
cmp_end_1724:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1721
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Check
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1728
    tst x0, #1
    b.ne do_compose_1726
do_apply_1727:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1729
do_compose_1726:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1729
do_concat_1728:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1729:
    str x0, [sp, #-16]!
    adr x0, if
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1732
    tst x0, #1
    b.ne do_compose_1730
do_apply_1731:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1733
do_compose_1730:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1733
do_concat_1732:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1733:
    str x0, [sp, #-16]!
    adr x0, it
    str x0, [sp, #-16]!
    adr x0, str_0
    mov x1, x0
    ldr x0, [sp], #16
    bl _dict_get
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1736
    tst x0, #1
    b.ne do_compose_1734
do_apply_1735:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1737
do_compose_1734:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1737
do_concat_1736:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1737:
    str x0, [sp, #-16]!
    adr x0, a
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1740
    tst x0, #1
    b.ne do_compose_1738
do_apply_1739:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1741
do_compose_1738:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1741
do_concat_1740:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1741:
    str x0, [sp, #-16]!
    adr x0, closing
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1744
    tst x0, #1
    b.ne do_compose_1742
do_apply_1743:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1745
do_compose_1742:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1745
do_concat_1744:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1745:
    str x0, [sp, #-16]!
    adr x0, paren
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1748
    tst x0, #1
    b.ne do_compose_1746
do_apply_1747:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1749
do_compose_1746:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1749
do_concat_1748:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1749:
    str x0, [sp, #-16]!
    adr x0, or
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1752
    tst x0, #1
    b.ne do_compose_1750
do_apply_1751:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1753
do_compose_1750:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1753
do_concat_1752:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1753:
    str x0, [sp, #-16]!
    adr x0, dedent
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1756
    tst x0, #1
    b.ne do_compose_1754
do_apply_1755:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1757
do_compose_1754:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1757
do_concat_1756:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1757:
    str x0, [sp, #-16]!
    adr x0, implicit
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1760
    tst x0, #1
    b.ne do_compose_1758
do_apply_1759:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1761
do_compose_1758:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1761
do_concat_1760:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1761:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1725
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1764
    adr x0, sign_id
    b cmp_end_1765
cmp_true_1764:
cmp_end_1765:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1762
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, Also
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1766
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1768
xor_true_1766:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1767
    adr x0, sign_id
    b xor_end_1768
xor_false_1767:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, should
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1771
    tst x0, #1
    b.ne do_compose_1769
do_apply_1770:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1772
do_compose_1769:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1772
do_concat_1771:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1772:
    str x0, [sp, #-16]!
    adr x0, check
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1775
    tst x0, #1
    b.ne do_compose_1773
do_apply_1774:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1776
do_compose_1773:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1776
do_concat_1775:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1776:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1779
    tst x0, #1
    b.ne do_compose_1777
do_apply_1778:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1780
do_compose_1777:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1780
do_concat_1779:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1780:
    str x0, [sp, #-16]!
    adr x0, dedent
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1783
    tst x0, #1
    b.ne do_compose_1781
do_apply_1782:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1784
do_compose_1781:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1784
do_concat_1783:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1784:
    str x0, [sp, #-16]!
    adr x0, if
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1787
    tst x0, #1
    b.ne do_compose_1785
do_apply_1786:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1788
do_compose_1785:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1788
do_concat_1787:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1788:
    str x0, [sp, #-16]!
    adr x0, we
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1791
    tst x0, #1
    b.ne do_compose_1789
do_apply_1790:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1792
do_compose_1789:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1792
do_concat_1791:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1792:
    str x0, [sp, #-16]!
    adr x0, had
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1795
    tst x0, #1
    b.ne do_compose_1793
do_apply_1794:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1796
do_compose_1793:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1796
do_concat_1795:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1796:
    str x0, [sp, #-16]!
    adr x0, indentation
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1799
    tst x0, #1
    b.ne do_compose_1797
do_apply_1798:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1800
do_compose_1797:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1800
do_concat_1799:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1800:
    str x0, [sp, #-16]!
    adr x0, logic
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1803
    tst x0, #1
    b.ne do_compose_1801
do_apply_1802:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1804
do_compose_1801:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1804
do_concat_1803:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1804:
    b cond_end_1763
cond_false_1762:
    adr x0, sign_id
cond_end_1763:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1725
    mov x0, #0
blk_end_1725:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1807
    tst x0, #1
    b.ne do_compose_1805
do_apply_1806:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1808
do_compose_1805:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1808
do_concat_1807:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1808:
    b cond_end_1722
cond_false_1721:
    adr x0, sign_id
cond_end_1722:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1712
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1811
    adr x0, sign_id
    b cmp_end_1812
cmp_true_1811:
cmp_end_1812:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1809
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1816
    tst x0, #1
    b.ne do_compose_1814
do_apply_1815:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1817
do_compose_1814:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1817
do_concat_1816:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1817:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1813
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1820
    tst x0, #1
    b.ne do_compose_1818
do_apply_1819:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1821
do_compose_1818:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1821
do_concat_1820:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1821:
blk_end_1813:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1824
    tst x0, #1
    b.ne do_compose_1822
do_apply_1823:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1825
do_compose_1822:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1825
do_concat_1824:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1825:
    b cond_end_1810
cond_false_1809:
    adr x0, sign_id
cond_end_1810:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1712
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1828
    tst x0, #1
    b.ne do_compose_1826
do_apply_1827:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1829
do_compose_1826:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1829
do_concat_1828:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1829:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1712
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1832
    tst x0, #1
    b.ne do_compose_1830
do_apply_1831:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1833
do_compose_1830:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1833
do_concat_1832:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1833:
    str x0, [sp, #-16]!
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1836
    tst x0, #1
    b.ne do_compose_1834
do_apply_1835:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1837
do_compose_1834:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1837
do_concat_1836:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1837:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1840
    tst x0, #1
    b.ne do_compose_1838
do_apply_1839:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1841
do_compose_1838:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1841
do_concat_1840:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1841:
blk_end_1712:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1710_1711:
    // Closure for func_1710
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1710
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1705
cond_false_1704:
    adr x0, sign_id
cond_end_1705:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_expr
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1846
    tst x0, #1
    b.ne do_compose_1844
do_apply_1845:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1847
do_compose_1844:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1847
do_concat_1846:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1847:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1842
    b after_func_1848_1849
func_1848:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, parse_primary
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1853
    tst x0, #1
    b.ne do_compose_1851
do_apply_1852:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1854
do_compose_1851:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1854
do_concat_1853:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1854:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1850
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1857
    tst x0, #1
    b.ne do_compose_1855
do_apply_1856:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1858
do_compose_1855:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1858
do_concat_1857:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1858:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1861
    tst x0, #1
    b.ne do_compose_1859
do_apply_1860:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1862
do_compose_1859:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1862
do_concat_1861:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1862:
blk_end_1850:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1848_1849:
    // Closure for func_1848
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1848
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1843
cond_false_1842:
    adr x0, sign_id
cond_end_1843:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1867
    tst x0, #1
    b.ne do_compose_1865
do_apply_1866:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1868
do_compose_1865:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1868
do_concat_1867:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1868:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1863
    b after_func_1869_1870
func_1869:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1871_1872
func_1871:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1876
    tst x0, #1
    b.ne do_compose_1874
do_apply_1875:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1877
do_compose_1874:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1877
do_concat_1876:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1877:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    ldr x0, [x29, #-64]
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1880
    adr x0, PREC_APPLY
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1882
    adr x0, sign_id
    b cmp_end_1883
cmp_true_1882:
cmp_end_1883:
    b and_end_1881
and_fail_1880:
    adr x0, sign_id
and_end_1881:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1878
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, PREC_APPLY
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1887
    tst x0, #1
    b.ne do_compose_1885
do_apply_1886:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1888
do_compose_1885:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1888
do_concat_1887:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1888:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1884
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1891
    tst x0, #1
    b.ne do_compose_1889
do_apply_1890:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1892
do_compose_1889:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1892
do_concat_1891:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1892:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1895
    tst x0, #1
    b.ne do_compose_1893
do_apply_1894:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1896
do_compose_1893:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1896
do_concat_1895:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1896:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1899
    tst x0, #1
    b.ne do_compose_1897
do_apply_1898:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1900
do_compose_1897:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1900
do_concat_1899:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1900:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1903
    tst x0, #1
    b.ne do_compose_1901
do_apply_1902:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1904
do_compose_1901:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1904
do_concat_1903:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1904:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1907
    tst x0, #1
    b.ne do_compose_1905
do_apply_1906:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1908
do_compose_1905:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1908
do_concat_1907:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1908:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1911
    tst x0, #1
    b.ne do_compose_1909
do_apply_1910:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1912
do_compose_1909:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1912
do_concat_1911:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1912:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1884
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1915
    tst x0, #1
    b.ne do_compose_1913
do_apply_1914:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1916
do_compose_1913:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1916
do_concat_1915:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1916:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1919
    tst x0, #1
    b.ne do_compose_1917
do_apply_1918:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1920
do_compose_1917:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1920
do_concat_1919:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1920:
blk_end_1884:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1923
    tst x0, #1
    b.ne do_compose_1921
do_apply_1922:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1924
do_compose_1921:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1924
do_concat_1923:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1924:
    b cond_end_1879
cond_false_1878:
    adr x0, sign_id
cond_end_1879:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1927
    tst x0, #1
    b.ne do_compose_1925
do_apply_1926:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1928
do_compose_1925:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1928
do_concat_1927:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1928:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1931
    adr x0, sign_id
    b cmp_end_1932
cmp_true_1931:
cmp_end_1932:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1929
    ldr x0, [x29, #-48]
    b cond_end_1930
cond_false_1929:
    adr x0, sign_id
cond_end_1930:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1935
    tst x0, #1
    b.ne do_compose_1933
do_apply_1934:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1936
do_compose_1933:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1936
do_concat_1935:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1936:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    adr x0, get_prec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1939
    tst x0, #1
    b.ne do_compose_1937
do_apply_1938:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1940
do_compose_1937:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1940
do_concat_1939:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1940:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1943
    adr x0, sign_id
    b cmp_end_1944
cmp_true_1943:
cmp_end_1944:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1941
    ldr x0, [x29, #-48]
    b cond_end_1942
cond_false_1941:
    adr x0, sign_id
cond_end_1942:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1947
    tst x0, #1
    b.ne do_compose_1945
do_apply_1946:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1948
do_compose_1945:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1948
do_concat_1947:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1948:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    b after_next_min_prec_impl_1949
next_min_prec_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1950_1951
func_1950:
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
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1954
    tst x0, #1
    b.ne do_compose_1952
do_apply_1953:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1955
do_compose_1952:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1955
do_concat_1954:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1955:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1950_1951:
    // Closure for func_1950
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1950
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_next_min_prec_impl_1949:
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
    b.ne blk_end_1873
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, next_min_prec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1958
    tst x0, #1
    b.ne do_compose_1956
do_apply_1957:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1959
do_compose_1956:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1959
do_concat_1958:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1959:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1962
    tst x0, #1
    b.ne do_compose_1960
do_apply_1961:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1963
do_compose_1960:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1963
do_concat_1962:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1963:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1966
    tst x0, #1
    b.ne do_compose_1964
do_apply_1965:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1967
do_compose_1964:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1967
do_concat_1966:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1967:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1970
    tst x0, #1
    b.ne do_compose_1968
do_apply_1969:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1971
do_compose_1968:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1971
do_concat_1970:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1971:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1974
    tst x0, #1
    b.ne do_compose_1972
do_apply_1973:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1975
do_compose_1972:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1975
do_concat_1974:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1975:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1978
    tst x0, #1
    b.ne do_compose_1976
do_apply_1977:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1979
do_compose_1976:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1979
do_concat_1978:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1979:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1982
    tst x0, #1
    b.ne do_compose_1980
do_apply_1981:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1983
do_compose_1980:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1983
do_concat_1982:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1983:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1986
    tst x0, #1
    b.ne do_compose_1984
do_apply_1985:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1987
do_compose_1984:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1987
do_concat_1986:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1987:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1990
    tst x0, #1
    b.ne do_compose_1988
do_apply_1989:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1991
do_compose_1988:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1991
do_concat_1990:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1991:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1873
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1994
    tst x0, #1
    b.ne do_compose_1992
do_apply_1993:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1995
do_compose_1992:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1995
do_concat_1994:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1995:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1998
    tst x0, #1
    b.ne do_compose_1996
do_apply_1997:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1999
do_compose_1996:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1999
do_concat_1998:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1999:
blk_end_1873:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1871_1872:
    // Closure for func_1871
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1871
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1869_1870:
    // Closure for func_1869
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1869
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1864
cond_false_1863:
    adr x0, sign_id
cond_end_1864:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_primary
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2004
    tst x0, #1
    b.ne do_compose_2002
do_apply_2003:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2005
do_compose_2002:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2005
do_concat_2004:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2005:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2000
    b after_func_2006_2007
func_2006:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2011
    tst x0, #1
    b.ne do_compose_2009
do_apply_2010:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2012
do_compose_2009:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2012
do_concat_2011:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2012:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2008
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2015
    tst x0, #1
    b.ne do_compose_2013
do_apply_2014:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2016
do_compose_2013:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2016
do_concat_2015:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2016:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2008
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2019
    adr x0, sign_id
    b cmp_end_2020
cmp_true_2019:
cmp_end_2020:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2017
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2024
    tst x0, #1
    b.ne do_compose_2022
do_apply_2023:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2025
do_compose_2022:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2025
do_concat_2024:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2025:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2021
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2028
    tst x0, #1
    b.ne do_compose_2026
do_apply_2027:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2029
do_compose_2026:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2029
do_concat_2028:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2029:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2032
    tst x0, #1
    b.ne do_compose_2030
do_apply_2031:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2033
do_compose_2030:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2033
do_concat_2032:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2033:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2036
    tst x0, #1
    b.ne do_compose_2034
do_apply_2035:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2037
do_compose_2034:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2037
do_concat_2036:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2037:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2040
    tst x0, #1
    b.ne do_compose_2038
do_apply_2039:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2041
do_compose_2038:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2041
do_concat_2040:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2041:
blk_end_2021:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2044
    tst x0, #1
    b.ne do_compose_2042
do_apply_2043:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2045
do_compose_2042:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2045
do_concat_2044:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2045:
    b cond_end_2018
cond_false_2017:
    adr x0, sign_id
cond_end_2018:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2008
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2048
    adr x0, sign_id
    b cmp_end_2049
cmp_true_2048:
cmp_end_2049:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2046
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2053
    tst x0, #1
    b.ne do_compose_2051
do_apply_2052:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2054
do_compose_2051:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2054
do_concat_2053:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2054:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2050
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2057
    tst x0, #1
    b.ne do_compose_2055
do_apply_2056:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2058
do_compose_2055:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2058
do_concat_2057:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2058:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2061
    tst x0, #1
    b.ne do_compose_2059
do_apply_2060:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2062
do_compose_2059:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2062
do_concat_2061:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2062:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2065
    tst x0, #1
    b.ne do_compose_2063
do_apply_2064:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2066
do_compose_2063:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2066
do_concat_2065:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2066:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2069
    tst x0, #1
    b.ne do_compose_2067
do_apply_2068:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2070
do_compose_2067:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2070
do_concat_2069:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2070:
blk_end_2050:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2073
    tst x0, #1
    b.ne do_compose_2071
do_apply_2072:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2074
do_compose_2071:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2074
do_concat_2073:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2074:
    b cond_end_2047
cond_false_2046:
    adr x0, sign_id
cond_end_2047:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2008
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2077
    adr x0, sign_id
    b cmp_end_2078
cmp_true_2077:
cmp_end_2078:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2075
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2082
    tst x0, #1
    b.ne do_compose_2080
do_apply_2081:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2083
do_compose_2080:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2083
do_concat_2082:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2083:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2079
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2086
    tst x0, #1
    b.ne do_compose_2084
do_apply_2085:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2087
do_compose_2084:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2087
do_concat_2086:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2087:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2079
    adr x0, expect_type
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2090
    tst x0, #1
    b.ne do_compose_2088
do_apply_2089:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2091
do_compose_2088:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2091
do_concat_2090:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2091:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2079
    ldr x0, [x29, #-80]
blk_end_2079:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2094
    tst x0, #1
    b.ne do_compose_2092
do_apply_2093:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2095
do_compose_2092:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2095
do_concat_2094:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2095:
    b cond_end_2076
cond_false_2075:
    adr x0, sign_id
cond_end_2076:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2008
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2098
    tst x0, #1
    b.ne do_compose_2096
do_apply_2097:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2099
do_compose_2096:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2099
do_concat_2098:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2099:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #999
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2102
    tst x0, #1
    b.ne do_compose_2100
do_apply_2101:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2103
do_compose_2100:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2103
do_concat_2102:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2103:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2106
    tst x0, #1
    b.ne do_compose_2104
do_apply_2105:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2107
do_compose_2104:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2107
do_concat_2106:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2107:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2110
    tst x0, #1
    b.ne do_compose_2108
do_apply_2109:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2111
do_compose_2108:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2111
do_concat_2110:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2111:
blk_end_2008:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2006_2007:
    // Closure for func_2006
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2006
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2001
cond_false_2000:
    adr x0, sign_id
cond_end_2001:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2114
    tst x0, #1
    b.ne do_compose_2112
do_apply_2113:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2115
do_compose_2112:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2115
do_concat_2114:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2115:
    str x0, [sp, #-16]!
    adr x0, Compiler
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2118
    tst x0, #1
    b.ne do_compose_2116
do_apply_2117:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2119
do_compose_2116:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2119
do_concat_2118:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2119:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Compiles
    str x0, [sp, #-16]!
    adr x0, AST
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2122
    tst x0, #1
    b.ne do_compose_2120
do_apply_2121:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2123
do_compose_2120:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2123
do_concat_2122:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2123:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2126
    tst x0, #1
    b.ne do_compose_2124
do_apply_2125:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2127
do_compose_2124:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2127
do_concat_2126:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2127:
    str x0, [sp, #-16]!
    adr x0, AArch64
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2130
    tst x0, #1
    b.ne do_compose_2128
do_apply_2129:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2131
do_compose_2128:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2131
do_concat_2130:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2131:
    str x0, [sp, #-16]!
    adr x0, Assembly
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2134
    tst x0, #1
    b.ne do_compose_2132
do_apply_2133:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2135
do_compose_2132:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2135
do_concat_2134:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2135:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, str_len
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2140
    tst x0, #1
    b.ne do_compose_2138
do_apply_2139:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2141
do_compose_2138:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2141
do_concat_2140:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2141:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2136
    b after_func_2142_2143
func_2142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2144
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2147
    adr x0, sign_id
    b cmp_end_2148
cmp_true_2147:
cmp_end_2148:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2145
    mov x0, #0
    b cond_end_2146
cond_false_2145:
    adr x0, sign_id
cond_end_2146:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2144
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, str_len
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2151
    tst x0, #1
    b.ne do_compose_2149
do_apply_2150:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2152
do_compose_2149:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2152
do_concat_2151:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2152:
blk_end_2144:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2142_2143:
    // Closure for func_2142
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2142
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2137
cond_false_2136:
    adr x0, sign_id
cond_end_2137:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, str_cpy
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2157
    tst x0, #1
    b.ne do_compose_2155
do_apply_2156:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2158
do_compose_2155:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2158
do_concat_2157:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2158:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2153
    b after_func_2159_2160
func_2159:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2161_2162
func_2161:
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
    b.ne blk_end_2163
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2166
    adr x0, sign_id
    b cmp_end_2167
cmp_true_2166:
cmp_end_2167:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2164
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2168
    ldr x0, [x29, #-48]
blk_end_2168:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2171
    tst x0, #1
    b.ne do_compose_2169
do_apply_2170:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2172
do_compose_2169:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2172
do_concat_2171:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2172:
    b cond_end_2165
cond_false_2164:
    adr x0, sign_id
cond_end_2165:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2163
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2163
    adr x0, str_cpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2175
    tst x0, #1
    b.ne do_compose_2173
do_apply_2174:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2176
do_compose_2173:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2176
do_concat_2175:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2176:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2179
    tst x0, #1
    b.ne do_compose_2177
do_apply_2178:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2180
do_compose_2177:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2180
do_concat_2179:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2180:
blk_end_2163:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2161_2162:
    // Closure for func_2161
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2161
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2159_2160:
    // Closure for func_2159
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2159
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2154
cond_false_2153:
    adr x0, sign_id
cond_end_2154:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, str_cat
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2185
    tst x0, #1
    b.ne do_compose_2183
do_apply_2184:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2186
do_compose_2183:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2186
do_concat_2185:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2186:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2181
    b after_func_2187_2188
func_2187:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2189_2190
func_2189:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2194
    tst x0, #1
    b.ne do_compose_2192
do_apply_2193:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2195
do_compose_2192:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2195
do_concat_2194:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2195:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2191
    adr x0, str_len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2198
    tst x0, #1
    b.ne do_compose_2196
do_apply_2197:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2199
do_compose_2196:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2199
do_concat_2198:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2199:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2191
    adr x0, alloc
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2202
    tst x0, #1
    b.ne do_compose_2200
do_apply_2201:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2203
do_compose_2200:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2203
do_concat_2202:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2203:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2191
    adr x0, str_cpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2206
    tst x0, #1
    b.ne do_compose_2204
do_apply_2205:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2207
do_compose_2204:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2207
do_concat_2206:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2207:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, end_s1
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2208
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2210
xor_true_2208:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2209
    adr x0, sign_id
    b xor_end_2210
xor_false_2209:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2213
    tst x0, #1
    b.ne do_compose_2211
do_apply_2212:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2214
do_compose_2211:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2214
do_concat_2213:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2214:
    str x0, [sp, #-16]!
    adr x0, points
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2217
    tst x0, #1
    b.ne do_compose_2215
do_apply_2216:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2218
do_compose_2215:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2218
do_concat_2217:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2218:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2221
    tst x0, #1
    b.ne do_compose_2219
do_apply_2220:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2222
do_compose_2219:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2222
do_concat_2221:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2222:
    str x0, [sp, #-16]!
    adr x0, null
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2225
    tst x0, #1
    b.ne do_compose_2223
do_apply_2224:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2226
do_compose_2223:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2226
do_concat_2225:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2226:
    str x0, [sp, #-16]!
    adr x0, terminator
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2229
    tst x0, #1
    b.ne do_compose_2227
do_apply_2228:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2230
do_compose_2227:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2230
do_concat_2229:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2230:
    str x0, [sp, #-16]!
    adr x0, of
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2233
    tst x0, #1
    b.ne do_compose_2231
do_apply_2232:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2234
do_compose_2231:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2234
do_concat_2233:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2234:
    str x0, [sp, #-16]!
    adr x0, first
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2237
    tst x0, #1
    b.ne do_compose_2235
do_apply_2236:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2238
do_compose_2235:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2238
do_concat_2237:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2238:
    str x0, [sp, #-16]!
    adr x0, copy
    str x0, [sp, #-16]!
    adr x0, str_cpy
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2239
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2241
xor_true_2239:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2240
    adr x0, sign_id
    b xor_end_2241
xor_false_2240:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2244
    tst x0, #1
    b.ne do_compose_2242
do_apply_2243:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2245
do_compose_2242:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2245
do_concat_2244:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2245:
    str x0, [sp, #-16]!
    adr x0, returns
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2248
    tst x0, #1
    b.ne do_compose_2246
do_apply_2247:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2249
do_compose_2246:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2249
do_concat_2248:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2249:
    str x0, [sp, #-16]!
    adr x0, pointer
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2252
    tst x0, #1
    b.ne do_compose_2250
do_apply_2251:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2253
do_compose_2250:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2253
do_concat_2252:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2253:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2256
    tst x0, #1
    b.ne do_compose_2254
do_apply_2255:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2257
do_compose_2254:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2257
do_concat_2256:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2257:
    str x0, [sp, #-16]!
    adr x0, null
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2260
    tst x0, #1
    b.ne do_compose_2258
do_apply_2259:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2261
do_compose_2258:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2261
do_concat_2260:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2261:
    str x0, [sp, #-16]!
    adr x0, terminator
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2264
    tst x0, #1
    b.ne do_compose_2262
do_apply_2263:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2265
do_compose_2262:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2265
do_concat_2264:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2265:
    str x0, [sp, #-16]!
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, My
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2266
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2268
xor_true_2266:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2267
    adr x0, sign_id
    b xor_end_2268
xor_false_2267:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2271
    tst x0, #1
    b.ne do_compose_2269
do_apply_2270:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2272
do_compose_2269:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2272
do_concat_2271:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2272:
    str x0, [sp, #-16]!
    adr x0, impl
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2275
    tst x0, #1
    b.ne do_compose_2273
do_apply_2274:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2276
do_compose_2273:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2276
do_concat_2275:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2276:
    str x0, [sp, #-16]!
    adr x0, above
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2279
    tst x0, #1
    b.ne do_compose_2277
do_apply_2278:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2280
do_compose_2277:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2280
do_concat_2279:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2280:
    str x0, [sp, #-16]!
    adr x0, returns
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2283
    tst x0, #1
    b.ne do_compose_2281
do_apply_2282:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2284
do_compose_2281:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2284
do_concat_2283:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2284:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2287
    tst x0, #1
    b.ne do_compose_2285
do_apply_2286:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2288
do_compose_2285:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2288
do_concat_2287:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2288:
    str x0, [sp, #-16]!
    adr x0, ptr
    str x0, [sp, #-16]!
    adr x0, to
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2291
    tst x0, #1
    b.ne do_compose_2289
do_apply_2290:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2292
do_compose_2289:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2292
do_concat_2291:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2292:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2295
    tst x0, #1
    b.ne do_compose_2293
do_apply_2294:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2296
do_compose_2293:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2296
do_concat_2295:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2296:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2299
    tst x0, #1
    b.ne do_compose_2297
do_apply_2298:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2300
do_compose_2297:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2300
do_concat_2299:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2300:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, So
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2301
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2303
xor_true_2301:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2302
    adr x0, sign_id
    b xor_end_2303
xor_false_2302:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2306
    tst x0, #1
    b.ne do_compose_2304
do_apply_2305:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2307
do_compose_2304:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2307
do_concat_2306:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2307:
    str x0, [sp, #-16]!
    adr x0, we
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2310
    tst x0, #1
    b.ne do_compose_2308
do_apply_2309:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2311
do_compose_2308:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2311
do_concat_2310:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2311:
    str x0, [sp, #-16]!
    adr x0, can
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2314
    tst x0, #1
    b.ne do_compose_2312
do_apply_2313:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2315
do_compose_2312:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2315
do_concat_2314:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2315:
    str x0, [sp, #-16]!
    adr x0, chain
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2318
    tst x0, #1
    b.ne do_compose_2316
do_apply_2317:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2319
do_compose_2316:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2319
do_concat_2318:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2319:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2322
    tst x0, #1
    b.ne do_compose_2320
do_apply_2321:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2323
do_compose_2320:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2323
do_concat_2322:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2323:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2191
    adr x0, str_cpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2326
    tst x0, #1
    b.ne do_compose_2324
do_apply_2325:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2327
do_compose_2324:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2327
do_concat_2326:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2327:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2330
    tst x0, #1
    b.ne do_compose_2328
do_apply_2329:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2331
do_compose_2328:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2331
do_concat_2330:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2331:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2191
    ldr x0, [x29, #-96]
blk_end_2191:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2189_2190:
    // Closure for func_2189
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2189
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2187_2188:
    // Closure for func_2187
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2187
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2182
cond_false_2181:
    adr x0, sign_id
cond_end_2182:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, int_to_str
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2336
    tst x0, #1
    b.ne do_compose_2334
do_apply_2335:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2337
do_compose_2334:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2337
do_concat_2336:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2337:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2332
    b after_func_2338_2339
func_2338:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2343
    adr x0, sign_id
    b cmp_end_2344
cmp_true_2343:
cmp_end_2344:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2341
    mov x0, #48
    b cond_end_2342
cond_false_2341:
    adr x0, sign_id
cond_end_2342:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2340
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_2347
    adr x0, sign_id
    b cmp_end_2348
cmp_true_2347:
cmp_end_2348:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2345
    adr x0, str_cat
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2351
    tst x0, #1
    b.ne do_compose_2349
do_apply_2350:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2352
do_compose_2349:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2352
do_concat_2351:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2352:
    str x0, [sp, #-16]!
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2355
    tst x0, #1
    b.ne do_compose_2353
do_apply_2354:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2356
do_compose_2353:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2356
do_concat_2355:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2356:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2359
    tst x0, #1
    b.ne do_compose_2357
do_apply_2358:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2360
do_compose_2357:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2360
do_concat_2359:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2360:
    b cond_end_2346
cond_false_2345:
    adr x0, sign_id
cond_end_2346:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2340
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2363
    tst x0, #1
    b.ne do_compose_2361
do_apply_2362:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2364
do_compose_2361:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2364
do_concat_2363:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2364:
blk_end_2340:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2338_2339:
    // Closure for func_2338
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2338
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2333
cond_false_2332:
    adr x0, sign_id
cond_end_2333:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, int_to_str_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2369
    tst x0, #1
    b.ne do_compose_2367
do_apply_2368:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2370
do_compose_2367:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2370
do_concat_2369:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2370:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2365
    b after_func_2371_2372
func_2371:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2376
    adr x0, sign_id
    b cmp_end_2377
cmp_true_2376:
cmp_end_2377:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2374
    adr x0, str_2
    b cond_end_2375
cond_false_2374:
    adr x0, sign_id
cond_end_2375:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2373
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2380
    tst x0, #1
    b.ne do_compose_2378
do_apply_2379:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2381
do_compose_2378:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2381
do_concat_2380:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2381:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2373
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, Append
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2387
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2389
xor_true_2387:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2388
    adr x0, sign_id
    b xor_end_2389
xor_false_2388:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, digit
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2392
    tst x0, #1
    b.ne do_compose_2390
do_apply_2391:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2393
do_compose_2390:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2393
do_concat_2392:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2393:
    str x0, [sp, #-16]!
    adr x0, char
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2396
    tst x0, #1
    b.ne do_compose_2394
do_apply_2395:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2397
do_compose_2394:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2397
do_concat_2396:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2397:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2400
    tst x0, #1
    b.ne do_compose_2398
do_apply_2399:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2401
do_compose_2398:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2401
do_concat_2400:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2401:
    str x0, [sp, #-16]!
    adr x0, string
    str x0, [sp, #-16]!
    adr x0, Since
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2402
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2404
xor_true_2402:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2403
    adr x0, sign_id
    b xor_end_2404
xor_false_2403:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2407
    tst x0, #1
    b.ne do_compose_2405
do_apply_2406:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2408
do_compose_2405:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2408
do_concat_2407:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2408:
    str x0, [sp, #-16]!
    adr x0, we
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2411
    tst x0, #1
    b.ne do_compose_2409
do_apply_2410:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2412
do_compose_2409:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2412
do_concat_2411:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2412:
    str x0, [sp, #-16]!
    adr x0, don
    str x0, [sp, #-16]!
    adr x0, str_3
    mov x1, x0
    ldr x0, [sp], #16
    bl _dict_get
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2415
    tst x0, #1
    b.ne do_compose_2413
do_apply_2414:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2416
do_compose_2413:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2416
do_concat_2415:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2416:
    str x0, [sp, #-16]!
    adr x0, have
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2419
    tst x0, #1
    b.ne do_compose_2417
do_apply_2418:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2420
do_compose_2417:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2420
do_concat_2419:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2420:
    str x0, [sp, #-16]!
    adr x0, mutable
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2423
    tst x0, #1
    b.ne do_compose_2421
do_apply_2422:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2424
do_compose_2421:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2424
do_concat_2423:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2424:
    str x0, [sp, #-16]!
    adr x0, buffer
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2427
    tst x0, #1
    b.ne do_compose_2425
do_apply_2426:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2428
do_compose_2425:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2428
do_concat_2427:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2428:
    str x0, [sp, #-16]!
    adr x0, easily
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2431
    tst x0, #1
    b.ne do_compose_2429
do_apply_2430:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2432
do_compose_2429:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2432
do_concat_2431:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2432:
    str x0, [sp, #-16]!
    adr x0, in
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2435
    tst x0, #1
    b.ne do_compose_2433
do_apply_2434:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2436
do_compose_2433:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2436
do_concat_2435:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2436:
    str x0, [sp, #-16]!
    adr x0, functional
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2439
    tst x0, #1
    b.ne do_compose_2437
do_apply_2438:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2440
do_compose_2437:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2440
do_concat_2439:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2440:
    str x0, [sp, #-16]!
    adr x0, style
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2443
    tst x0, #1
    b.ne do_compose_2441
do_apply_2442:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2444
do_compose_2441:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2444
do_concat_2443:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2444:
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
    b.ne xor_true_2384
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2386
xor_true_2384:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2385
    adr x0, sign_id
    b xor_end_2386
xor_false_2385:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, might
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2447
    tst x0, #1
    b.ne do_compose_2445
do_apply_2446:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2448
do_compose_2445:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2448
do_concat_2447:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2448:
    str x0, [sp, #-16]!
    adr x0, recurse
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2451
    tst x0, #1
    b.ne do_compose_2449
do_apply_2450:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2452
do_compose_2449:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2452
do_concat_2451:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2452:
    str x0, [sp, #-16]!
    adr x0, differently
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2455
    tst x0, #1
    b.ne do_compose_2453
do_apply_2454:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2456
do_compose_2453:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2456
do_concat_2455:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2456:
    str x0, [sp, #-16]!
    adr x0, or
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2459
    tst x0, #1
    b.ne do_compose_2457
do_apply_2458:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2460
do_compose_2457:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2460
do_concat_2459:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2460:
    str x0, [sp, #-16]!
    adr x0, stick
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2463
    tst x0, #1
    b.ne do_compose_2461
do_apply_2462:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2464
do_compose_2461:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2464
do_concat_2463:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2464:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2467
    tst x0, #1
    b.ne do_compose_2465
do_apply_2466:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2468
do_compose_2465:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2468
do_concat_2467:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2468:
    str x0, [sp, #-16]!
    adr x0, str_cat
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2471
    tst x0, #1
    b.ne do_compose_2469
do_apply_2470:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2472
do_compose_2469:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2472
do_concat_2471:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2472:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, str_cat
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2473
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2475
xor_true_2473:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2474
    adr x0, sign_id
    b xor_end_2475
xor_false_2474:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2478
    tst x0, #1
    b.ne do_compose_2476
do_apply_2477:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2479
do_compose_2476:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2479
do_concat_2478:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2479:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2482
    tst x0, #1
    b.ne do_compose_2480
do_apply_2481:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2483
do_compose_2480:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2483
do_concat_2482:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2483:
    str x0, [sp, #-16]!
    adr x0, expensive
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2486
    tst x0, #1
    b.ne do_compose_2484
do_apply_2485:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2487
do_compose_2484:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2487
do_concat_2486:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2487:
    str x0, [sp, #-16]!
    adr x0, allocs
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2490
    tst x0, #1
    b.ne do_compose_2488
do_apply_2489:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2491
do_compose_2488:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2491
do_concat_2490:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2491:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Optimization
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2492
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2494
xor_true_2492:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2493
    adr x0, sign_id
    b xor_end_2494
xor_false_2493:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2497
    tst x0, #1
    b.ne do_compose_2495
do_apply_2496:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2498
do_compose_2495:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2498
do_concat_2497:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2498:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2382
    adr x0, Use
    str x0, [sp, #-16]!
    adr x0, a
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2501
    tst x0, #1
    b.ne do_compose_2499
do_apply_2500:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2502
do_compose_2499:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2502
do_concat_2501:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2502:
    str x0, [sp, #-16]!
    adr x0, local
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2505
    tst x0, #1
    b.ne do_compose_2503
do_apply_2504:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2506
do_compose_2503:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2506
do_concat_2505:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2506:
    str x0, [sp, #-16]!
    adr x0, buffer
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2509
    tst x0, #1
    b.ne do_compose_2507
do_apply_2508:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2510
do_compose_2507:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2510
do_concat_2509:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2510:
    str x0, [sp, #-16]!
    adr x0, or
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2513
    tst x0, #1
    b.ne do_compose_2511
do_apply_2512:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2514
do_compose_2511:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2514
do_concat_2513:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2514:
    str x0, [sp, #-16]!
    adr x0, list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2517
    tst x0, #1
    b.ne do_compose_2515
do_apply_2516:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2518
do_compose_2515:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2518
do_concat_2517:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2518:
    str x0, [sp, #-16]!
    adr x0, then
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2521
    tst x0, #1
    b.ne do_compose_2519
do_apply_2520:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2522
do_compose_2519:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2522
do_concat_2521:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2522:
    str x0, [sp, #-16]!
    adr x0, convert
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2525
    tst x0, #1
    b.ne do_compose_2523
do_apply_2524:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2526
do_compose_2523:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2526
do_concat_2525:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2526:
    str x0, [sp, #-16]!
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, For
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2527
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2529
xor_true_2527:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2528
    adr x0, sign_id
    b xor_end_2529
xor_false_2528:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2532
    tst x0, #1
    b.ne do_compose_2530
do_apply_2531:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2533
do_compose_2530:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2533
do_concat_2532:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2533:
    str x0, [sp, #-16]!
    adr x0, now
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2536
    tst x0, #1
    b.ne do_compose_2534
do_apply_2535:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2537
do_compose_2534:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2537
do_concat_2536:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2537:
    str x0, [sp, #-16]!
    adr x0, use
    str x0, [sp, #-16]!
    adr x0, str_cat
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2540
    tst x0, #1
    b.ne do_compose_2538
do_apply_2539:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2541
do_compose_2538:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2541
do_concat_2540:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2541:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2544
    tst x0, #1
    b.ne do_compose_2542
do_apply_2543:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2545
do_compose_2542:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2545
do_concat_2544:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2545:
    str x0, [sp, #-16]!
    adr x0, correctness
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2548
    tst x0, #1
    b.ne do_compose_2546
do_apply_2547:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2549
do_compose_2546:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2549
do_concat_2548:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2549:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2552
    tst x0, #1
    b.ne do_compose_2550
do_apply_2551:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2553
do_compose_2550:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2553
do_concat_2552:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2553:
    ldr x1, [sp], #16
    bl _cons
    b cond_end_2383
cond_false_2382:
    adr x0, sign_id
cond_end_2383:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2373
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2556
    tst x0, #1
    b.ne do_compose_2554
do_apply_2555:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2557
do_compose_2554:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2557
do_concat_2556:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2557:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2373
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2373
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2373
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2560
    tst x0, #1
    b.ne do_compose_2558
do_apply_2559:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2561
do_compose_2558:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2561
do_concat_2560:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2561:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2564
    tst x0, #1
    b.ne do_compose_2562
do_apply_2563:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2565
do_compose_2562:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2565
do_concat_2564:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2565:
blk_end_2373:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2371_2372:
    // Closure for func_2371
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2371
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2366
cond_false_2365:
    adr x0, sign_id
cond_end_2366:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_program
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2570
    tst x0, #1
    b.ne do_compose_2568
do_apply_2569:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2571
do_compose_2568:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2571
do_concat_2570:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2571:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2566
    b after_func_2572_2573
func_2572:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2577
    adr x0, sign_id
    b cmp_end_2578
cmp_true_2577:
cmp_end_2578:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2575
    adr x0, str_2
    b cond_end_2576
cond_false_2575:
    adr x0, sign_id
cond_end_2576:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2574
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, Check
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2579
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2581
xor_true_2579:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2580
    adr x0, sign_id
    b xor_end_2581
xor_false_2580:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, if
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2584
    tst x0, #1
    b.ne do_compose_2582
do_apply_2583:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2585
do_compose_2582:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2585
do_concat_2584:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2585:
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2588
    tst x0, #1
    b.ne do_compose_2586
do_apply_2587:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2589
do_compose_2586:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2589
do_concat_2588:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2589:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2592
    tst x0, #1
    b.ne do_compose_2590
do_apply_2591:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2593
do_compose_2590:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2593
do_concat_2592:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2593:
    str x0, [sp, #-16]!
    adr x0, definition
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2596
    tst x0, #1
    b.ne do_compose_2594
do_apply_2595:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2597
do_compose_2594:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2597
do_concat_2596:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2597:
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2600
    tst x0, #1
    b.ne do_compose_2598
do_apply_2599:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2601
do_compose_2598:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2601
do_concat_2600:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2601:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2574
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2574
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2604
    adr x0, sign_id
    b cmp_end_2605
cmp_true_2604:
cmp_end_2605:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2602
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2609
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2614
    tst x0, #1
    b.ne do_compose_2612
do_apply_2613:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2615
do_compose_2612:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2615
do_concat_2614:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2615:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2618
    tst x0, #1
    b.ne do_compose_2616
do_apply_2617:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2619
do_compose_2616:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2619
do_concat_2618:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2619:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2610
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_global_def
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2623
    tst x0, #1
    b.ne do_compose_2621
do_apply_2622:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2624
do_compose_2621:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2624
do_concat_2623:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2624:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2620
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2627
    tst x0, #1
    b.ne do_compose_2625
do_apply_2626:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2628
do_compose_2625:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2628
do_concat_2627:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2628:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2631
    tst x0, #1
    b.ne do_compose_2629
do_apply_2630:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2632
do_compose_2629:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2632
do_concat_2631:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2632:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2620
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2635
    tst x0, #1
    b.ne do_compose_2633
do_apply_2634:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2636
do_compose_2633:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2636
do_concat_2635:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2636:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2639
    tst x0, #1
    b.ne do_compose_2637
do_apply_2638:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2640
do_compose_2637:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2640
do_concat_2639:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2640:
blk_end_2620:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2643
    tst x0, #1
    b.ne do_compose_2641
do_apply_2642:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2644
do_compose_2641:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2644
do_concat_2643:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2644:
    b cond_end_2611
cond_false_2610:
    adr x0, sign_id
cond_end_2611:
blk_end_2609:
    str x0, [sp, #-16]!
    adr x0, Skip
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2606
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2608
xor_true_2606:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2607
    adr x0, sign_id
    b xor_end_2608
xor_false_2607:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2647
    tst x0, #1
    b.ne do_compose_2645
do_apply_2646:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2648
do_compose_2645:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2648
do_concat_2647:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2648:
    str x0, [sp, #-16]!
    adr x0, non
    str x0, [sp, #-16]!
    adr x0, definitions
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2651
    tst x0, #1
    b.ne do_compose_2649
do_apply_2650:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2652
do_compose_2649:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2652
do_concat_2651:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2652:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2655
    tst x0, #1
    b.ne do_compose_2653
do_apply_2654:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2656
do_compose_2653:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2656
do_concat_2655:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2656:
    str x0, [sp, #-16]!
    adr x0, now
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2659
    tst x0, #1
    b.ne do_compose_2657
do_apply_2658:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2660
do_compose_2657:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2660
do_concat_2659:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2660:
    b cond_end_2603
cond_false_2602:
    adr x0, sign_id
cond_end_2603:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2574
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2663
    tst x0, #1
    b.ne do_compose_2661
do_apply_2662:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2664
do_compose_2661:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2664
do_concat_2663:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2664:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2667
    tst x0, #1
    b.ne do_compose_2665
do_apply_2666:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2668
do_compose_2665:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2668
do_concat_2667:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2668:
blk_end_2574:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2572_2573:
    // Closure for func_2572
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2572
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2567
cond_false_2566:
    adr x0, sign_id
cond_end_2567:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_global_def
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2673
    tst x0, #1
    b.ne do_compose_2671
do_apply_2672:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2674
do_compose_2671:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2674
do_concat_2673:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2674:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2669
    b after_func_2675_2676
func_2675:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2677
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2678
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2680
xor_true_2678:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2679
    adr x0, sign_id
    b xor_end_2680
xor_false_2679:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, should
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2683
    tst x0, #1
    b.ne do_compose_2681
do_apply_2682:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2684
do_compose_2681:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2684
do_concat_2683:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2684:
    str x0, [sp, #-16]!
    adr x0, be
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2687
    tst x0, #1
    b.ne do_compose_2685
do_apply_2686:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2688
do_compose_2685:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2688
do_concat_2687:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2688:
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2691
    tst x0, #1
    b.ne do_compose_2689
do_apply_2690:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2692
do_compose_2689:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2692
do_concat_2691:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2692:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2695
    tst x0, #1
    b.ne do_compose_2693
do_apply_2694:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2696
do_compose_2693:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2696
do_concat_2695:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2696:
    str x0, [sp, #-16]!
    adr x0, function
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2699
    tst x0, #1
    b.ne do_compose_2697
do_apply_2698:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2700
do_compose_2697:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2700
do_concat_2699:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2700:
    str x0, [sp, #-16]!
    adr x0, name
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2703
    tst x0, #1
    b.ne do_compose_2701
do_apply_2702:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2704
do_compose_2701:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2704
do_concat_2703:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2704:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2677
    b after_name_impl_2705
name_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_2706_2707
func_2706:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2708_2709
func_2708:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2710_2711
func_2710:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, for
    str x0, [sp, #-16]!
    adr x0, function
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2714
    tst x0, #1
    b.ne do_compose_2712
do_apply_2713:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2715
do_compose_2712:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2715
do_concat_2714:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2715:
    str x0, [sp, #-16]!
    adr x0, body
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2718
    tst x0, #1
    b.ne do_compose_2716
do_apply_2717:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2719
do_compose_2716:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2719
do_concat_2718:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2719:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2710_2711:
    // Closure for func_2710
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2710
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2708_2709:
    // Closure for func_2708
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2708
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2706_2707:
    // Closure for func_2706
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2706
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_name_impl_2705:
    // Closure for name_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, name_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2677
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2677
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2722
    adr x0, sign_id
    b cmp_end_2723
cmp_true_2722:
cmp_end_2723:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2720
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2724
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2729
    tst x0, #1
    b.ne do_compose_2727
do_apply_2728:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2730
do_compose_2727:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2730
do_concat_2729:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2730:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2733
    tst x0, #1
    b.ne do_compose_2731
do_apply_2732:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2734
do_compose_2731:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2734
do_concat_2733:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2734:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2725
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_function_def
    str x0, [sp, #-16]!
    adr x0, name
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2737
    tst x0, #1
    b.ne do_compose_2735
do_apply_2736:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2738
do_compose_2735:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2738
do_concat_2737:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2738:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2741
    tst x0, #1
    b.ne do_compose_2739
do_apply_2740:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2742
do_compose_2739:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2742
do_concat_2741:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2742:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2745
    tst x0, #1
    b.ne do_compose_2743
do_apply_2744:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2746
do_compose_2743:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2746
do_concat_2745:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2746:
    b cond_end_2726
cond_false_2725:
    adr x0, sign_id
cond_end_2726:
blk_end_2724:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2749
    tst x0, #1
    b.ne do_compose_2747
do_apply_2748:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2750
do_compose_2747:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2750
do_concat_2749:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2750:
    b cond_end_2721
cond_false_2720:
    adr x0, sign_id
cond_end_2721:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2677
    adr x0, str_4
blk_end_2677:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2675_2676:
    // Closure for func_2675
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2675
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2670
cond_false_2669:
    adr x0, sign_id
cond_end_2670:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_function_def
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2755
    tst x0, #1
    b.ne do_compose_2753
do_apply_2754:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2756
do_compose_2753:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2756
do_concat_2755:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2756:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2751
    b after_func_2757_2758
func_2757:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2759_2760
func_2759:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2764
    tst x0, #1
    b.ne do_compose_2762
do_apply_2763:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2765
do_compose_2762:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2765
do_concat_2764:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2765:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2768
    tst x0, #1
    b.ne do_compose_2766
do_apply_2767:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2769
do_compose_2766:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2769
do_concat_2768:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2769:
    str x0, [sp, #-16]!
    b after_func_2770_2771
func_2770:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, args
    str x0, [sp, #-16]!
    adr x0, body
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2774
    tst x0, #1
    b.ne do_compose_2772
do_apply_2773:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2775
do_compose_2772:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2775
do_concat_2774:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2775:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2770_2771:
    // Closure for func_2770
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2770
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2778
    tst x0, #1
    b.ne do_compose_2776
do_apply_2777:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2779
do_compose_2776:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2779
do_concat_2778:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2779:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2761
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2761
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2761
    adr x0, str_cat
    str x0, [sp, #-16]!
    mov x0, #95
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2782
    tst x0, #1
    b.ne do_compose_2780
do_apply_2781:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2783
do_compose_2780:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2783
do_concat_2782:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2783:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2786
    tst x0, #1
    b.ne do_compose_2784
do_apply_2785:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2787
do_compose_2784:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2787
do_concat_2786:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2787:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2761
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2790
    tst x0, #1
    b.ne do_compose_2788
do_apply_2789:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2791
do_compose_2788:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2791
do_concat_2790:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2791:
    str x0, [sp, #-16]!
    adr x0, str_5
    str x0, [sp, #-16]!
    adr x0, Generate
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2792
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2794
xor_true_2792:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2793
    adr x0, sign_id
    b xor_end_2794
xor_false_2793:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2797
    tst x0, #1
    b.ne do_compose_2795
do_apply_2796:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2798
do_compose_2795:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2798
do_concat_2797:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2798:
    str x0, [sp, #-16]!
    adr x0, end
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2801
    tst x0, #1
    b.ne do_compose_2799
do_apply_2800:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2802
do_compose_2799:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2802
do_concat_2801:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2802:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2805
    tst x0, #1
    b.ne do_compose_2803
do_apply_2804:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2806
do_compose_2803:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2806
do_concat_2805:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2806:
    str x0, [sp, #-16]!
    adr x0, for
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2809
    tst x0, #1
    b.ne do_compose_2807
do_apply_2808:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2810
do_compose_2807:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2810
do_concat_2809:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2810:
    str x0, [sp, #-16]!
    adr x0, recursive
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2813
    tst x0, #1
    b.ne do_compose_2811
do_apply_2812:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2814
do_compose_2811:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2814
do_concat_2813:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2814:
    str x0, [sp, #-16]!
    adr x0, blocks
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2817
    tst x0, #1
    b.ne do_compose_2815
do_apply_2816:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2818
do_compose_2815:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2818
do_concat_2817:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2818:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2821
    tst x0, #1
    b.ne do_compose_2819
do_apply_2820:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2822
do_compose_2819:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2822
do_concat_2821:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2822:
    str x0, [sp, #-16]!
    adr x0, jump
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2825
    tst x0, #1
    b.ne do_compose_2823
do_apply_2824:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2826
do_compose_2823:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2826
do_concat_2825:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2826:
    str x0, [sp, #-16]!
    adr x0, to
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2829
    tst x0, #1
    b.ne do_compose_2827
do_apply_2828:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2830
do_compose_2827:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2830
do_concat_2829:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2830:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2761
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2833
    tst x0, #1
    b.ne do_compose_2831
do_apply_2832:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2834
do_compose_2831:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2834
do_concat_2833:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2834:
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2837
    tst x0, #1
    b.ne do_compose_2835
do_apply_2836:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2838
do_compose_2835:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2838
do_concat_2837:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2838:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2761
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2841
    tst x0, #1
    b.ne do_compose_2839
do_apply_2840:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2842
do_compose_2839:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2842
do_concat_2841:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2842:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2845
    tst x0, #1
    b.ne do_compose_2843
do_apply_2844:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2846
do_compose_2843:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2846
do_concat_2845:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2846:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2761
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2849
    tst x0, #1
    b.ne do_compose_2847
do_apply_2848:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2850
do_compose_2847:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2850
do_concat_2849:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2850:
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2853
    tst x0, #1
    b.ne do_compose_2851
do_apply_2852:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2854
do_compose_2851:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2854
do_concat_2853:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2854:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2761
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2857
    tst x0, #1
    b.ne do_compose_2855
do_apply_2856:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2858
do_compose_2855:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2858
do_concat_2857:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2858:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2861
    tst x0, #1
    b.ne do_compose_2859
do_apply_2860:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2862
do_compose_2859:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2862
do_concat_2861:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2862:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2865
    tst x0, #1
    b.ne do_compose_2863
do_apply_2864:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2866
do_compose_2863:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2866
do_concat_2865:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2866:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2869
    tst x0, #1
    b.ne do_compose_2867
do_apply_2868:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2870
do_compose_2867:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2870
do_concat_2869:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2870:
blk_end_2761:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2759_2760:
    // Closure for func_2759
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2759
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2757_2758:
    // Closure for func_2757
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2757
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2752
cond_false_2751:
    adr x0, sign_id
cond_end_2752:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_expr
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2875
    tst x0, #1
    b.ne do_compose_2873
do_apply_2874:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2876
do_compose_2873:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2876
do_concat_2875:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2876:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2871
    b after_func_2877_2878
func_2877:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2879_2880
func_2879:
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
    b.eq cmp_true_2884
    adr x0, sign_id
    b cmp_end_2885
cmp_true_2884:
cmp_end_2885:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2882
    adr x0, str_2
    b cond_end_2883
cond_false_2882:
    adr x0, sign_id
cond_end_2883:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2881
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2881
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2881
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2888
    adr x0, sign_id
    b cmp_end_2889
cmp_true_2888:
cmp_end_2889:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2886
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2893
    tst x0, #1
    b.ne do_compose_2891
do_apply_2892:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2894
do_compose_2891:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2894
do_concat_2893:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2894:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2890
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_8
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2897
    tst x0, #1
    b.ne do_compose_2895
do_apply_2896:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2898
do_compose_2895:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2898
do_concat_2897:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2898:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2901
    tst x0, #1
    b.ne do_compose_2899
do_apply_2900:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2902
do_compose_2899:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2902
do_concat_2901:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2902:
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2905
    tst x0, #1
    b.ne do_compose_2903
do_apply_2904:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2906
do_compose_2903:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2906
do_concat_2905:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2906:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2909
    tst x0, #1
    b.ne do_compose_2907
do_apply_2908:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2910
do_compose_2907:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2910
do_concat_2909:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2910:
blk_end_2890:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2913
    tst x0, #1
    b.ne do_compose_2911
do_apply_2912:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2914
do_compose_2911:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2914
do_concat_2913:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2914:
    b cond_end_2887
cond_false_2886:
    adr x0, sign_id
cond_end_2887:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2881
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2917
    adr x0, sign_id
    b cmp_end_2918
cmp_true_2917:
cmp_end_2918:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2915
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_block
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2921
    tst x0, #1
    b.ne do_compose_2919
do_apply_2920:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2922
do_compose_2919:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2922
do_concat_2921:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2922:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2925
    tst x0, #1
    b.ne do_compose_2923
do_apply_2924:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2926
do_compose_2923:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2926
do_concat_2925:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2926:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2929
    tst x0, #1
    b.ne do_compose_2927
do_apply_2928:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2930
do_compose_2927:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2930
do_concat_2929:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2930:
    b cond_end_2916
cond_false_2915:
    adr x0, sign_id
cond_end_2916:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2881
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2933
    adr x0, sign_id
    b cmp_end_2934
cmp_true_2933:
cmp_end_2934:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2931
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2937
    tst x0, #1
    b.ne do_compose_2935
do_apply_2936:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2938
do_compose_2935:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2938
do_concat_2937:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2938:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2941
    tst x0, #1
    b.ne do_compose_2939
do_apply_2940:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2942
do_compose_2939:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2942
do_concat_2941:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2942:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2945
    tst x0, #1
    b.ne do_compose_2943
do_apply_2944:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2946
do_compose_2943:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2946
do_concat_2945:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2946:
    b cond_end_2932
cond_false_2931:
    adr x0, sign_id
cond_end_2932:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2881
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2949
    adr x0, sign_id
    b cmp_end_2950
cmp_true_2949:
cmp_end_2950:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2947
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_apply
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2953
    tst x0, #1
    b.ne do_compose_2951
do_apply_2952:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2954
do_compose_2951:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2954
do_concat_2953:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2954:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2957
    tst x0, #1
    b.ne do_compose_2955
do_apply_2956:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2958
do_compose_2955:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2958
do_concat_2957:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2958:
    b cond_end_2948
cond_false_2947:
    adr x0, sign_id
cond_end_2948:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2881
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2961
    adr x0, sign_id
    b cmp_end_2962
cmp_true_2961:
cmp_end_2962:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2959
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2965
    tst x0, #1
    b.ne do_compose_2963
do_apply_2964:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2966
do_compose_2963:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2966
do_concat_2965:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2966:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2969
    tst x0, #1
    b.ne do_compose_2967
do_apply_2968:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2970
do_compose_2967:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2970
do_concat_2969:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2970:
    b cond_end_2960
cond_false_2959:
    adr x0, sign_id
cond_end_2960:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2881
    adr x0, str_2
blk_end_2881:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2879_2880:
    // Closure for func_2879
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2879
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2877_2878:
    // Closure for func_2877
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2877
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2872
cond_false_2871:
    adr x0, sign_id
cond_end_2872:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2975
    tst x0, #1
    b.ne do_compose_2973
do_apply_2974:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2976
do_compose_2973:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2976
do_concat_2975:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2976:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2971
    b after_func_2977_2978
func_2977:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    mov x0, #95
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2982
    tst x0, #1
    b.ne do_compose_2980
do_apply_2981:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2983
do_compose_2980:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2983
do_concat_2982:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2983:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2986
    tst x0, #1
    b.ne do_compose_2984
do_apply_2985:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2987
do_compose_2984:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2987
do_concat_2986:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2987:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2979
    adr x0, str_10
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2979
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_11
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2990
    tst x0, #1
    b.ne do_compose_2988
do_apply_2989:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2991
do_compose_2988:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2991
do_concat_2990:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2991:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2994
    tst x0, #1
    b.ne do_compose_2992
do_apply_2993:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2995
do_compose_2992:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2995
do_concat_2994:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2995:
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2998
    tst x0, #1
    b.ne do_compose_2996
do_apply_2997:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2999
do_compose_2996:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2999
do_concat_2998:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2999:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3002
    tst x0, #1
    b.ne do_compose_3000
do_apply_3001:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3003
do_compose_3000:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3003
do_concat_3002:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3003:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2979
    adr x0, str_12
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2979
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3006
    tst x0, #1
    b.ne do_compose_3004
do_apply_3005:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3007
do_compose_3004:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3007
do_concat_3006:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3007:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3010
    tst x0, #1
    b.ne do_compose_3008
do_apply_3009:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3011
do_compose_3008:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3011
do_concat_3010:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3011:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3014
    tst x0, #1
    b.ne do_compose_3012
do_apply_3013:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3015
do_compose_3012:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3015
do_concat_3014:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3015:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3018
    tst x0, #1
    b.ne do_compose_3016
do_apply_3017:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3019
do_compose_3016:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3019
do_concat_3018:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3019:
blk_end_2979:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2977_2978:
    // Closure for func_2977
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2977
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2972
cond_false_2971:
    adr x0, sign_id
cond_end_2972:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_apply
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3024
    tst x0, #1
    b.ne do_compose_3022
do_apply_3023:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3025
do_compose_3022:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3025
do_concat_3024:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3025:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3020
    b after_func_3026_3027
func_3026:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3031
    tst x0, #1
    b.ne do_compose_3029
do_apply_3030:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3032
do_compose_3029:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3032
do_concat_3031:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3032:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3035
    tst x0, #1
    b.ne do_compose_3033
do_apply_3034:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3036
do_compose_3033:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3036
do_concat_3035:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3036:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3039
    tst x0, #1
    b.ne do_compose_3037
do_apply_3038:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3040
do_compose_3037:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3040
do_concat_3039:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3040:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3043
    tst x0, #1
    b.ne do_compose_3041
do_apply_3042:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3044
do_compose_3041:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3044
do_concat_3043:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3044:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    adr x0, str_13
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    adr x0, str_14
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    adr x0, str_15
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    adr x0, str_16
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3028
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3047
    tst x0, #1
    b.ne do_compose_3045
do_apply_3046:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3048
do_compose_3045:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3048
do_concat_3047:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3048:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3051
    tst x0, #1
    b.ne do_compose_3049
do_apply_3050:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3052
do_compose_3049:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3052
do_concat_3051:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3052:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3055
    tst x0, #1
    b.ne do_compose_3053
do_apply_3054:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3056
do_compose_3053:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3056
do_concat_3055:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3056:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3059
    tst x0, #1
    b.ne do_compose_3057
do_apply_3058:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3060
do_compose_3057:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3060
do_concat_3059:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3060:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3063
    tst x0, #1
    b.ne do_compose_3061
do_apply_3062:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3064
do_compose_3061:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3064
do_concat_3063:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3064:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3067
    tst x0, #1
    b.ne do_compose_3065
do_apply_3066:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3068
do_compose_3065:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3068
do_concat_3067:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3068:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3071
    tst x0, #1
    b.ne do_compose_3069
do_apply_3070:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3072
do_compose_3069:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3072
do_concat_3071:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3072:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3075
    tst x0, #1
    b.ne do_compose_3073
do_apply_3074:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3076
do_compose_3073:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3076
do_concat_3075:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3076:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3079
    tst x0, #1
    b.ne do_compose_3077
do_apply_3078:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3080
do_compose_3077:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3080
do_concat_3079:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3080:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3083
    tst x0, #1
    b.ne do_compose_3081
do_apply_3082:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3084
do_compose_3081:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3084
do_concat_3083:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3084:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3087
    tst x0, #1
    b.ne do_compose_3085
do_apply_3086:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3088
do_compose_3085:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3088
do_concat_3087:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3088:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3091
    tst x0, #1
    b.ne do_compose_3089
do_apply_3090:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3092
do_compose_3089:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3092
do_concat_3091:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3092:
blk_end_3028:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3026_3027:
    // Closure for func_3026
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3026
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3021
cond_false_3020:
    adr x0, sign_id
cond_end_3021:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_infix
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3097
    tst x0, #1
    b.ne do_compose_3095
do_apply_3096:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3098
do_compose_3095:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3098
do_concat_3097:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3098:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3093
    b after_func_3099_3100
func_3099:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3101_3102
func_3101:
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
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3103
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3103
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3103
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3106
    tst x0, #1
    b.ne do_compose_3104
do_apply_3105:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3107
do_compose_3104:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3107
do_concat_3106:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3107:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3110
    tst x0, #1
    b.ne do_compose_3108
do_apply_3109:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3111
do_compose_3108:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3111
do_concat_3110:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3111:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3103
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Match
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3117
    tst x0, #1
    b.ne do_compose_3115
do_apply_3116:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3118
do_compose_3115:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3118
do_concat_3117:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3118:
    str x0, [sp, #-16]!
    adr x0, Case
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3121
    tst x0, #1
    b.ne do_compose_3119
do_apply_3120:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3122
do_compose_3119:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3122
do_concat_3121:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3122:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3113
    adr x0, val
    str x0, [sp, #-16]!
    adr x0, sign_id
    b cond_end_3114
cond_false_3113:
    adr x0, sign_id
cond_end_3114:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3112
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3125
    tst x0, #1
    b.ne do_compose_3123
do_apply_3124:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3126
do_compose_3123:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3126
do_concat_3125:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3126:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3129
    tst x0, #1
    b.ne do_compose_3127
do_apply_3128:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3130
do_compose_3127:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3130
do_concat_3129:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3130:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3112
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3133
    tst x0, #1
    b.ne do_compose_3131
do_apply_3132:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3134
do_compose_3131:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3134
do_concat_3133:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3134:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3137
    tst x0, #1
    b.ne do_compose_3135
do_apply_3136:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3138
do_compose_3135:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3138
do_concat_3137:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3138:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3112
    adr x0, str_18
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3112
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3141
    tst x0, #1
    b.ne do_compose_3139
do_apply_3140:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3142
do_compose_3139:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3142
do_concat_3141:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3142:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_19
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3145
    tst x0, #1
    b.ne do_compose_3143
do_apply_3144:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3146
do_compose_3143:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3146
do_concat_3145:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3146:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3149
    tst x0, #1
    b.ne do_compose_3147
do_apply_3148:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3150
do_compose_3147:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3150
do_concat_3149:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3150:
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3153
    tst x0, #1
    b.ne do_compose_3151
do_apply_3152:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3154
do_compose_3151:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3154
do_concat_3153:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3154:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3157
    tst x0, #1
    b.ne do_compose_3155
do_apply_3156:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3158
do_compose_3155:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3158
do_concat_3157:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3158:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3161
    tst x0, #1
    b.ne do_compose_3159
do_apply_3160:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3162
do_compose_3159:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3162
do_concat_3161:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3162:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3112
    adr x0, str_20
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3112
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3165
    tst x0, #1
    b.ne do_compose_3163
do_apply_3164:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3166
do_compose_3163:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3166
do_concat_3165:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3166:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3169
    tst x0, #1
    b.ne do_compose_3167
do_apply_3168:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3170
do_compose_3167:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3170
do_concat_3169:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3170:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3173
    tst x0, #1
    b.ne do_compose_3171
do_apply_3172:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3174
do_compose_3171:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3174
do_concat_3173:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3174:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-208]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3177
    tst x0, #1
    b.ne do_compose_3175
do_apply_3176:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3178
do_compose_3175:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3178
do_concat_3177:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3178:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3181
    tst x0, #1
    b.ne do_compose_3179
do_apply_3180:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3182
do_compose_3179:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3182
do_concat_3181:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3182:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3185
    tst x0, #1
    b.ne do_compose_3183
do_apply_3184:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3186
do_compose_3183:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3186
do_concat_3185:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3186:
blk_end_3112:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3189
    tst x0, #1
    b.ne do_compose_3187
do_apply_3188:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3190
do_compose_3187:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3190
do_concat_3189:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3190:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3103
    ldr x0, [x29, #-224]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3193
    adr x0, sign_id
    b cmp_end_3194
cmp_true_3193:
cmp_end_3194:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3191
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3198
    tst x0, #1
    b.ne do_compose_3196
do_apply_3197:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3199
do_compose_3196:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3199
do_concat_3198:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3199:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3202
    tst x0, #1
    b.ne do_compose_3200
do_apply_3201:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3203
do_compose_3200:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3203
do_concat_3202:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3203:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3195
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3206
    tst x0, #1
    b.ne do_compose_3204
do_apply_3205:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3207
do_compose_3204:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3207
do_concat_3206:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3207:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3210
    tst x0, #1
    b.ne do_compose_3208
do_apply_3209:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3211
do_compose_3208:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3211
do_concat_3210:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3211:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3195
    adr x0, str_13
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3195
    adr x0, str_21
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3195
    adr x0, emit_op
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3214
    tst x0, #1
    b.ne do_compose_3212
do_apply_3213:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3215
do_compose_3212:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3215
do_concat_3214:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3215:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3195
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3218
    tst x0, #1
    b.ne do_compose_3216
do_apply_3217:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3219
do_compose_3216:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3219
do_concat_3218:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3219:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-272]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3222
    tst x0, #1
    b.ne do_compose_3220
do_apply_3221:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3223
do_compose_3220:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3223
do_concat_3222:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3223:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-256]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3226
    tst x0, #1
    b.ne do_compose_3224
do_apply_3225:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3227
do_compose_3224:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3227
do_concat_3226:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3227:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-288]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3230
    tst x0, #1
    b.ne do_compose_3228
do_apply_3229:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3231
do_compose_3228:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3231
do_concat_3230:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3231:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-304]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3234
    tst x0, #1
    b.ne do_compose_3232
do_apply_3233:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3235
do_compose_3232:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3235
do_concat_3234:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3235:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3238
    tst x0, #1
    b.ne do_compose_3236
do_apply_3237:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3239
do_compose_3236:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3239
do_concat_3238:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3239:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3242
    tst x0, #1
    b.ne do_compose_3240
do_apply_3241:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3243
do_compose_3240:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3243
do_concat_3242:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3243:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3246
    tst x0, #1
    b.ne do_compose_3244
do_apply_3245:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3247
do_compose_3244:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3247
do_concat_3246:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3247:
blk_end_3195:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3250
    tst x0, #1
    b.ne do_compose_3248
do_apply_3249:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3251
do_compose_3248:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3251
do_concat_3250:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3251:
    b cond_end_3192
cond_false_3191:
    adr x0, sign_id
cond_end_3192:
blk_end_3103:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3101_3102:
    // Closure for func_3101
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3101
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3099_3100:
    // Closure for func_3099
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3099
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3094
cond_false_3093:
    adr x0, sign_id
cond_end_3094:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, emit_op
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3256
    tst x0, #1
    b.ne do_compose_3254
do_apply_3255:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3257
do_compose_3254:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3257
do_concat_3256:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3257:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3252
    b after_func_3258_3259
func_3258:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3265
    tst x0, #1
    b.ne do_compose_3263
do_apply_3264:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3266
do_compose_3263:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3266
do_concat_3265:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3266:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3269
    tst x0, #1
    b.ne do_compose_3267
do_apply_3268:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3270
do_compose_3267:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3270
do_concat_3269:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3270:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3261
    adr x0, str_22
    b cond_end_3262
cond_false_3261:
    adr x0, sign_id
cond_end_3262:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3260
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3275
    tst x0, #1
    b.ne do_compose_3273
do_apply_3274:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3276
do_compose_3273:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3276
do_concat_3275:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3276:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3279
    tst x0, #1
    b.ne do_compose_3277
do_apply_3278:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3280
do_compose_3277:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3280
do_concat_3279:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3280:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3271
    adr x0, str_23
    b cond_end_3272
cond_false_3271:
    adr x0, sign_id
cond_end_3272:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3260
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3285
    tst x0, #1
    b.ne do_compose_3283
do_apply_3284:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3286
do_compose_3283:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3286
do_concat_3285:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3286:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3289
    tst x0, #1
    b.ne do_compose_3287
do_apply_3288:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3290
do_compose_3287:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3290
do_concat_3289:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3290:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3281
    adr x0, str_24
    b cond_end_3282
cond_false_3281:
    adr x0, sign_id
cond_end_3282:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3260
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3295
    tst x0, #1
    b.ne do_compose_3293
do_apply_3294:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3296
do_compose_3293:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3296
do_concat_3295:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3296:
    str x0, [sp, #-16]!
    mov x0, #124
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3299
    tst x0, #1
    b.ne do_compose_3297
do_apply_3298:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3300
do_compose_3297:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3300
do_concat_3299:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3300:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3291
    adr x0, str_25
    b cond_end_3292
cond_false_3291:
    adr x0, sign_id
cond_end_3292:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3260
    adr x0, str_26
blk_end_3260:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3258_3259:
    // Closure for func_3258
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3258
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3253
cond_false_3252:
    adr x0, sign_id
cond_end_3253:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_block
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3305
    tst x0, #1
    b.ne do_compose_3303
do_apply_3304:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3306
do_compose_3303:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3306
do_concat_3305:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3306:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3301
    b after_func_3307_3308
func_3307:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3309_3310
func_3309:
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
    b.eq cmp_true_3314
    adr x0, sign_id
    b cmp_end_3315
cmp_true_3314:
cmp_end_3315:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3312
    adr x0, str_2
    b cond_end_3313
cond_false_3312:
    adr x0, sign_id
cond_end_3313:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3311
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3311
    adr x0, compile_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3318
    tst x0, #1
    b.ne do_compose_3316
do_apply_3317:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3319
do_compose_3316:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3319
do_concat_3318:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3319:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3322
    tst x0, #1
    b.ne do_compose_3320
do_apply_3321:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3323
do_compose_3320:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3323
do_concat_3322:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3323:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3311
    adr x0, compile_block
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3326
    tst x0, #1
    b.ne do_compose_3324
do_apply_3325:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3327
do_compose_3324:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3327
do_concat_3326:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3327:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3330
    tst x0, #1
    b.ne do_compose_3328
do_apply_3329:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3331
do_compose_3328:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3331
do_concat_3330:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3331:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3334
    tst x0, #1
    b.ne do_compose_3332
do_apply_3333:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3335
do_compose_3332:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3335
do_concat_3334:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3335:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3311
    adr x0, str_cat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3338
    tst x0, #1
    b.ne do_compose_3336
do_apply_3337:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3339
do_compose_3336:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3339
do_concat_3338:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3339:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3342
    tst x0, #1
    b.ne do_compose_3340
do_apply_3341:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3343
do_compose_3340:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3343
do_concat_3342:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3343:
blk_end_3311:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3309_3310:
    // Closure for func_3309
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3309
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3307_3308:
    // Closure for func_3307
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3307
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3302
cond_false_3301:
    adr x0, sign_id
cond_end_3302:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, main
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3348
    tst x0, #1
    b.ne do_compose_3346
do_apply_3347:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3349
do_compose_3346:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3349
do_concat_3348:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3349:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3344
    b after_func_3350_3351
func_3350:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_27
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_28
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3355
    tst x0, #1
    b.ne do_compose_3353
do_apply_3354:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3356
do_compose_3353:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3356
do_concat_3355:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3356:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3359
    tst x0, #1
    b.ne do_compose_3357
do_apply_3358:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3360
do_compose_3357:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3360
do_concat_3359:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3360:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3363
    tst x0, #1
    b.ne do_compose_3361
do_apply_3362:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3364
do_compose_3361:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3364
do_concat_3363:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3364:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, init_lexer
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3367
    tst x0, #1
    b.ne do_compose_3365
do_apply_3366:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3368
do_compose_3365:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3368
do_concat_3367:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3368:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3371
    tst x0, #1
    b.ne do_compose_3369
do_apply_3370:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3372
do_compose_3369:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3372
do_concat_3371:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3372:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, init_parser
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3375
    tst x0, #1
    b.ne do_compose_3373
do_apply_3374:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3376
do_compose_3373:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3376
do_concat_3375:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3376:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3379
    tst x0, #1
    b.ne do_compose_3377
do_apply_3378:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3380
do_compose_3377:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3380
do_concat_3379:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3380:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, compile_program
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3383
    tst x0, #1
    b.ne do_compose_3381
do_apply_3382:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3384
do_compose_3381:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3384
do_concat_3383:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3384:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3352
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3387
    tst x0, #1
    b.ne do_compose_3385
do_apply_3386:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3388
do_compose_3385:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3388
do_concat_3387:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3388:
blk_end_3352:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3350_3351:
    // Closure for func_3350
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3350
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3345
cond_false_3344:
    adr x0, sign_id
cond_end_3345:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_program
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_3393
    tst x0, #1
    b.ne do_compose_3391
do_apply_3392:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3394
do_compose_3391:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3394
do_concat_3393:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_3394:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3389
    b after_func_3395_3396
func_3395:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_29
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3395_3396:
    // Closure for func_3395
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3395
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3390
cond_false_3389:
    adr x0, sign_id
cond_end_3390:
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
    .asciz "    add x0, x1, x0\n"
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
