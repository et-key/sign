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

    adr x0, ﻿
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sys_brk
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4
    tst x9, #1
    b.eq do_concat_3
    tst x0, #1
    b.ne do_compose_1
do_apply_2:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5
do_compose_1:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5
do_concat_3:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5
id_morphism_4:
    b apply_end_5
apply_end_5:
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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_9
    tst x9, #1
    b.eq do_concat_8
    tst x0, #1
    b.ne do_compose_6
do_apply_7:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_10
do_compose_6:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_10
do_concat_8:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_10
id_morphism_9:
    b apply_end_10
apply_end_10:
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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_16
    tst x9, #1
    b.eq do_concat_15
    tst x0, #1
    b.ne do_compose_13
do_apply_14:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_17
do_compose_13:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_17
do_concat_15:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_17
id_morphism_16:
    b apply_end_17
apply_end_17:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_11
    b after_func_18_19
func_18:
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
    b.ne blk_end_20
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
    b.ne blk_end_20
    adr x0, curr
blk_end_20:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_18_19:
    // Closure for func_18
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_18
    ldr x0, [sp], #16
    bl _cons
    b cond_end_12
cond_false_11:
    adr x0, sign_id
cond_end_12:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_26
    tst x9, #1
    b.eq do_concat_25
    tst x0, #1
    b.ne do_compose_23
do_apply_24:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_27
do_compose_23:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_27
do_concat_25:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_27
id_morphism_26:
    b apply_end_27
apply_end_27:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_21
    b after_func_28_29
func_28:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_30_31
func_30:
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
    b.eq cond_false_33
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_38
    tst x9, #1
    b.eq do_concat_37
    tst x0, #1
    b.ne do_compose_35
do_apply_36:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_39
do_compose_35:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_39
do_concat_37:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_39
id_morphism_38:
    b apply_end_39
apply_end_39:
    b cond_end_34
cond_false_33:
    adr x0, sign_id
cond_end_34:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_32
    adr x0, addr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_32
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
    b.ne blk_end_32
    adr x0, addr
blk_end_32:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_30_31:
    // Closure for func_30
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_30
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_28_29:
    // Closure for func_28
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_28
    ldr x0, [sp], #16
    bl _cons
    b cond_end_22
cond_false_21:
    adr x0, sign_id
cond_end_22:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, head
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_45
    tst x9, #1
    b.eq do_concat_44
    tst x0, #1
    b.ne do_compose_42
do_apply_43:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_46
do_compose_42:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_46
do_concat_44:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_46
id_morphism_45:
    b apply_end_46
apply_end_46:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_40
    b after_func_47_48
func_47:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_47_48:
    // Closure for func_47
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_47
    ldr x0, [sp], #16
    bl _cons
    b cond_end_41
cond_false_40:
    adr x0, sign_id
cond_end_41:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tail
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_54
    tst x9, #1
    b.eq do_concat_53
    tst x0, #1
    b.ne do_compose_51
do_apply_52:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_55
do_compose_51:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_55
do_concat_53:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_55
id_morphism_54:
    b apply_end_55
apply_end_55:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_49
    b after_func_56_57
func_56:
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
after_func_56_57:
    // Closure for func_56
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_56
    ldr x0, [sp], #16
    bl _cons
    b cond_end_50
cond_false_49:
    adr x0, sign_id
cond_end_50:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, nth
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_63
    tst x9, #1
    b.eq do_concat_62
    tst x0, #1
    b.ne do_compose_60
do_apply_61:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_64
do_compose_60:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_64
do_concat_62:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_64
id_morphism_63:
    b apply_end_64
apply_end_64:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_58
    b after_func_65_66
func_65:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_67_68
func_67:
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
    b.le cmp_true_72
    adr x0, sign_id
    b cmp_end_73
cmp_true_72:
cmp_end_73:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_70
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_77
    tst x9, #1
    b.eq do_concat_76
    tst x0, #1
    b.ne do_compose_74
do_apply_75:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_78
do_compose_74:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_78
do_concat_76:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_78
id_morphism_77:
    b apply_end_78
apply_end_78:
    b cond_end_71
cond_false_70:
    adr x0, sign_id
cond_end_71:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_69
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_82
    tst x9, #1
    b.eq do_concat_81
    tst x0, #1
    b.ne do_compose_79
do_apply_80:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_83
do_compose_79:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_83
do_concat_81:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_83
id_morphism_82:
    b apply_end_83
apply_end_83:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_87
    tst x9, #1
    b.eq do_concat_86
    tst x0, #1
    b.ne do_compose_84
do_apply_85:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_88
do_compose_84:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_88
do_concat_86:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_88
id_morphism_87:
    b apply_end_88
apply_end_88:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_92
    tst x9, #1
    b.eq do_concat_91
    tst x0, #1
    b.ne do_compose_89
do_apply_90:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_93
do_compose_89:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_93
do_concat_91:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_93
id_morphism_92:
    b apply_end_93
apply_end_93:
blk_end_69:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_67_68:
    // Closure for func_67
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_67
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_65_66:
    // Closure for func_65
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_65
    ldr x0, [sp], #16
    bl _cons
    b cond_end_59
cond_false_58:
    adr x0, sign_id
cond_end_59:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, factorial
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_99
    tst x9, #1
    b.eq do_concat_98
    tst x0, #1
    b.ne do_compose_96
do_apply_97:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_100
do_compose_96:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_100
do_concat_98:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_100
id_morphism_99:
    b apply_end_100
apply_end_100:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_94
    b after_func_101_102
func_101:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_106
    adr x0, sign_id
    b cmp_end_107
cmp_true_106:
cmp_end_107:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_104
    mov x0, #1
    b cond_end_105
cond_false_104:
    adr x0, sign_id
cond_end_105:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_103
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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_111
    tst x9, #1
    b.eq do_concat_110
    tst x0, #1
    b.ne do_compose_108
do_apply_109:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_112
do_compose_108:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_112
do_concat_110:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_112
id_morphism_111:
    b apply_end_112
apply_end_112:
blk_end_103:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_101_102:
    // Closure for func_101
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_101
    ldr x0, [sp], #16
    bl _cons
    b cond_end_95
cond_false_94:
    adr x0, sign_id
cond_end_95:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, range
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_118
    tst x9, #1
    b.eq do_concat_117
    tst x0, #1
    b.ne do_compose_115
do_apply_116:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_119
do_compose_115:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_119
do_concat_117:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_119
id_morphism_118:
    b apply_end_119
apply_end_119:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_113
    b after_func_120_121
func_120:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_122_123
func_122:
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
    b.gt cmp_true_127
    adr x0, sign_id
    b cmp_end_128
cmp_true_127:
cmp_end_128:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_125
    mov x0, #0
    b cond_end_126
cond_false_125:
    adr x0, sign_id
cond_end_126:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_124
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_132
    tst x9, #1
    b.eq do_concat_131
    tst x0, #1
    b.ne do_compose_129
do_apply_130:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_133
do_compose_129:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_133
do_concat_131:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_133
id_morphism_132:
    b apply_end_133
apply_end_133:
    str x0, [sp, #-16]!
    adr x0, range
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_137
    tst x9, #1
    b.eq do_concat_136
    tst x0, #1
    b.ne do_compose_134
do_apply_135:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_138
do_compose_134:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_138
do_concat_136:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_138
id_morphism_137:
    b apply_end_138
apply_end_138:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_142
    tst x9, #1
    b.eq do_concat_141
    tst x0, #1
    b.ne do_compose_139
do_apply_140:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_143
do_compose_139:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_143
do_concat_141:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_143
id_morphism_142:
    b apply_end_143
apply_end_143:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_147
    tst x9, #1
    b.eq do_concat_146
    tst x0, #1
    b.ne do_compose_144
do_apply_145:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_148
do_compose_144:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_148
do_concat_146:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_148
id_morphism_147:
    b apply_end_148
apply_end_148:
blk_end_124:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_122_123:
    // Closure for func_122
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_122
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_120_121:
    // Closure for func_120
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_120
    ldr x0, [sp], #16
    bl _cons
    b cond_end_114
cond_false_113:
    adr x0, sign_id
cond_end_114:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_char
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_154
    tst x9, #1
    b.eq do_concat_153
    tst x0, #1
    b.ne do_compose_151
do_apply_152:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_155
do_compose_151:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_155
do_concat_153:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_155
id_morphism_154:
    b apply_end_155
apply_end_155:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_149
    b after_func_156_157
func_156:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_162
    tst x9, #1
    b.eq do_concat_161
    tst x0, #1
    b.ne do_compose_159
do_apply_160:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_163
do_compose_159:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_163
do_concat_161:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_163
id_morphism_162:
    b apply_end_163
apply_end_163:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_167
    tst x9, #1
    b.eq do_concat_166
    tst x0, #1
    b.ne do_compose_164
do_apply_165:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_168
do_compose_164:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_168
do_concat_166:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_168
id_morphism_167:
    b apply_end_168
apply_end_168:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_158
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_172
    tst x9, #1
    b.eq do_concat_171
    tst x0, #1
    b.ne do_compose_169
do_apply_170:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_173
do_compose_169:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_173
do_concat_171:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_173
id_morphism_172:
    b apply_end_173
apply_end_173:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_177
    tst x9, #1
    b.eq do_concat_176
    tst x0, #1
    b.ne do_compose_174
do_apply_175:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_178
do_compose_174:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_178
do_concat_176:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_178
id_morphism_177:
    b apply_end_178
apply_end_178:
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_182
    tst x9, #1
    b.eq do_concat_181
    tst x0, #1
    b.ne do_compose_179
do_apply_180:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_183
do_compose_179:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_183
do_concat_181:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_183
id_morphism_182:
    b apply_end_183
apply_end_183:
blk_end_158:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_156_157:
    // Closure for func_156
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_156
    ldr x0, [sp], #16
    bl _cons
    b cond_end_150
cond_false_149:
    adr x0, sign_id
cond_end_150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_189
    tst x9, #1
    b.eq do_concat_188
    tst x0, #1
    b.ne do_compose_186
do_apply_187:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_190
do_compose_186:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_190
do_concat_188:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_190
id_morphism_189:
    b apply_end_190
apply_end_190:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_184
    b after_func_191_192
func_191:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_196
    adr x0, sign_id
    b cmp_end_197
cmp_true_196:
cmp_end_197:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_194
    mov x0, #0
    b cond_end_195
cond_false_194:
    adr x0, sign_id
cond_end_195:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_193
    b after_func_198_199
func_198:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_198_199:
    // Closure for func_198
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_198
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_200
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_200
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_200
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_203
    adr x0, sign_id
    b cmp_end_204
cmp_true_203:
cmp_end_204:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_201
    ldr x0, [x29, #-64]
    b cond_end_202
cond_false_201:
    adr x0, sign_id
cond_end_202:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_200
    adr x0, len_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_208
    tst x9, #1
    b.eq do_concat_207
    tst x0, #1
    b.ne do_compose_205
do_apply_206:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_209
do_compose_205:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_209
do_concat_207:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_209
id_morphism_208:
    b apply_end_209
apply_end_209:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_213
    tst x9, #1
    b.eq do_concat_212
    tst x0, #1
    b.ne do_compose_210
do_apply_211:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_214
do_compose_210:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_214
do_concat_212:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_214
id_morphism_213:
    b apply_end_214
apply_end_214:
blk_end_200:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_218
    tst x9, #1
    b.eq do_concat_217
    tst x0, #1
    b.ne do_compose_215
do_apply_216:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_219
do_compose_215:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_219
do_concat_217:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_219
id_morphism_218:
    b apply_end_219
apply_end_219:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_193
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_223
    tst x9, #1
    b.eq do_concat_222
    tst x0, #1
    b.ne do_compose_220
do_apply_221:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_224
do_compose_220:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_224
do_concat_222:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_224
id_morphism_223:
    b apply_end_224
apply_end_224:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_193
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_228
    tst x9, #1
    b.eq do_concat_227
    tst x0, #1
    b.ne do_compose_225
do_apply_226:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_229
do_compose_225:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_229
do_concat_227:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_229
id_morphism_228:
    b apply_end_229
apply_end_229:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_233
    tst x9, #1
    b.eq do_concat_232
    tst x0, #1
    b.ne do_compose_230
do_apply_231:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_234
do_compose_230:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_234
do_concat_232:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_234
id_morphism_233:
    b apply_end_234
apply_end_234:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_238
    tst x9, #1
    b.eq do_concat_237
    tst x0, #1
    b.ne do_compose_235
do_apply_236:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_239
do_compose_235:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_239
do_concat_237:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_239
id_morphism_238:
    b apply_end_239
apply_end_239:
blk_end_193:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_191_192:
    // Closure for func_191
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_191
    ldr x0, [sp], #16
    bl _cons
    b cond_end_185
cond_false_184:
    adr x0, sign_id
cond_end_185:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_num
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_245
    tst x9, #1
    b.eq do_concat_244
    tst x0, #1
    b.ne do_compose_242
do_apply_243:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_246
do_compose_242:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_246
do_concat_244:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_246
id_morphism_245:
    b apply_end_246
apply_end_246:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_240
    b after_func_247_248
func_247:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_252
    adr x0, sign_id
    b cmp_end_253
cmp_true_252:
cmp_end_253:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_250
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_258
    tst x9, #1
    b.eq do_concat_257
    tst x0, #1
    b.ne do_compose_255
do_apply_256:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_259
do_compose_255:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_259
do_concat_257:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_259
id_morphism_258:
    b apply_end_259
apply_end_259:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_254
    mov x0, #0
blk_end_254:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_263
    tst x9, #1
    b.eq do_concat_262
    tst x0, #1
    b.ne do_compose_260
do_apply_261:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_264
do_compose_260:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_264
do_concat_262:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_264
id_morphism_263:
    b apply_end_264
apply_end_264:
    b cond_end_251
cond_false_250:
    adr x0, sign_id
cond_end_251:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_249
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_267
    adr x0, sign_id
    b cmp_end_268
cmp_true_267:
cmp_end_268:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_265
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_273
    tst x9, #1
    b.eq do_concat_272
    tst x0, #1
    b.ne do_compose_270
do_apply_271:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_274
do_compose_270:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_274
do_concat_272:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_274
id_morphism_273:
    b apply_end_274
apply_end_274:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_269
    adr x0, print_num
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_278
    tst x9, #1
    b.eq do_concat_277
    tst x0, #1
    b.ne do_compose_275
do_apply_276:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_279
do_compose_275:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_279
do_concat_277:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_279
id_morphism_278:
    b apply_end_279
apply_end_279:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_269
    mov x0, #0
blk_end_269:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_283
    tst x9, #1
    b.eq do_concat_282
    tst x0, #1
    b.ne do_compose_280
do_apply_281:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_284
do_compose_280:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_284
do_concat_282:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_284
id_morphism_283:
    b apply_end_284
apply_end_284:
    b cond_end_266
cond_false_265:
    adr x0, sign_id
cond_end_266:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_249
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_288
    tst x9, #1
    b.eq do_concat_287
    tst x0, #1
    b.ne do_compose_285
do_apply_286:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_289
do_compose_285:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_289
do_concat_287:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_289
id_morphism_288:
    b apply_end_289
apply_end_289:
blk_end_249:
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
    b cond_end_241
cond_false_240:
    adr x0, sign_id
cond_end_241:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _print_num_rec
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_295
    tst x9, #1
    b.eq do_concat_294
    tst x0, #1
    b.ne do_compose_292
do_apply_293:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_296
do_compose_292:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_296
do_concat_294:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_296
id_morphism_295:
    b apply_end_296
apply_end_296:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_290
    b after_func_297_298
func_297:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_302
    adr x0, sign_id
    b cmp_end_303
cmp_true_302:
cmp_end_303:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_300
    mov x0, #0
    b cond_end_301
cond_false_300:
    adr x0, sign_id
cond_end_301:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_299
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_307
    tst x9, #1
    b.eq do_concat_306
    tst x0, #1
    b.ne do_compose_304
do_apply_305:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_308
do_compose_304:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_308
do_concat_306:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_308
id_morphism_307:
    b apply_end_308
apply_end_308:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_299
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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_312
    tst x9, #1
    b.eq do_concat_311
    tst x0, #1
    b.ne do_compose_309
do_apply_310:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_313
do_compose_309:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_313
do_concat_311:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_313
id_morphism_312:
    b apply_end_313
apply_end_313:
blk_end_299:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_297_298:
    // Closure for func_297
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_297
    ldr x0, [sp], #16
    bl _cons
    b cond_end_291
cond_false_290:
    adr x0, sign_id
cond_end_291:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, add
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_319
    tst x9, #1
    b.eq do_concat_318
    tst x0, #1
    b.ne do_compose_316
do_apply_317:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_320
do_compose_316:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_320
do_concat_318:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_320
id_morphism_319:
    b apply_end_320
apply_end_320:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_314
    b after_func_321_322
func_321:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_323_324
func_323:
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
after_func_323_324:
    // Closure for func_323
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_323
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_321_322:
    // Closure for func_321
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_321
    ldr x0, [sp], #16
    bl _cons
    b cond_end_315
cond_false_314:
    adr x0, sign_id
cond_end_315:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sub
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_330
    tst x9, #1
    b.eq do_concat_329
    tst x0, #1
    b.ne do_compose_327
do_apply_328:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_331
do_compose_327:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_331
do_concat_329:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_331
id_morphism_330:
    b apply_end_331
apply_end_331:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_325
    b after_func_332_333
func_332:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_334_335
func_334:
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
after_func_334_335:
    // Closure for func_334
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_334
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_332_333:
    // Closure for func_332
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_332
    ldr x0, [sp], #16
    bl _cons
    b cond_end_326
cond_false_325:
    adr x0, sign_id
cond_end_326:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, mul
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_341
    tst x9, #1
    b.eq do_concat_340
    tst x0, #1
    b.ne do_compose_338
do_apply_339:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_342
do_compose_338:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_342
do_concat_340:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_342
id_morphism_341:
    b apply_end_342
apply_end_342:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_336
    b after_func_343_344
func_343:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_345_346
func_345:
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
after_func_345_346:
    // Closure for func_345
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_345
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_343_344:
    // Closure for func_343
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_343
    ldr x0, [sp], #16
    bl _cons
    b cond_end_337
cond_false_336:
    adr x0, sign_id
cond_end_337:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, div
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_352
    tst x9, #1
    b.eq do_concat_351
    tst x0, #1
    b.ne do_compose_349
do_apply_350:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_353
do_compose_349:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_353
do_concat_351:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_353
id_morphism_352:
    b apply_end_353
apply_end_353:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_347
    b after_func_354_355
func_354:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_356_357
func_356:
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
after_func_356_357:
    // Closure for func_356
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_356
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_354_355:
    // Closure for func_354
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_354
    ldr x0, [sp], #16
    bl _cons
    b cond_end_348
cond_false_347:
    adr x0, sign_id
cond_end_348:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, mod
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_363
    tst x9, #1
    b.eq do_concat_362
    tst x0, #1
    b.ne do_compose_360
do_apply_361:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_364
do_compose_360:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_364
do_concat_362:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_364
id_morphism_363:
    b apply_end_364
apply_end_364:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_358
    b after_func_365_366
func_365:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_367_368
func_367:
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
after_func_367_368:
    // Closure for func_367
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_367
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_359
cond_false_358:
    adr x0, sign_id
cond_end_359:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Pure
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_372
    tst x9, #1
    b.eq do_concat_371
    tst x0, #1
    b.ne do_compose_369
do_apply_370:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_373
do_compose_369:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_373
do_concat_371:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_373
id_morphism_372:
    b apply_end_373
apply_end_373:
    str x0, [sp, #-16]!
    adr x0, Functional
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_377
    tst x9, #1
    b.eq do_concat_376
    tst x0, #1
    b.ne do_compose_374
do_apply_375:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_378
do_compose_374:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_378
do_concat_376:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_378
id_morphism_377:
    b apply_end_378
apply_end_378:
    str x0, [sp, #-16]!
    adr x0, Lexer
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_382
    tst x9, #1
    b.eq do_concat_381
    tst x0, #1
    b.ne do_compose_379
do_apply_380:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_383
do_compose_379:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_383
do_concat_381:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_383
id_morphism_382:
    b apply_end_383
apply_end_383:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Strict
    str x0, [sp, #-16]!
    adr x0, No
    str x0, [sp, #-16]!
    adr x0, Local
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, Binding
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_387
    tst x9, #1
    b.eq do_concat_386
    tst x0, #1
    b.ne do_compose_384
do_apply_385:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_388
do_compose_384:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_388
do_concat_386:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_388
id_morphism_387:
    b apply_end_388
apply_end_388:
    str x0, [sp, #-16]!
    adr x0, Version
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_392
    tst x9, #1
    b.eq do_concat_391
    tst x0, #1
    b.ne do_compose_389
do_apply_390:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_393
do_compose_389:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_393
do_concat_391:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_393
id_morphism_392:
    b apply_end_393
apply_end_393:
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
    mov x0, #0
    adr x1, tok_unit
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_space
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_399
    tst x9, #1
    b.eq do_concat_398
    tst x0, #1
    b.ne do_compose_396
do_apply_397:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_400
do_compose_396:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_400
do_concat_398:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_400
id_morphism_399:
    b apply_end_400
apply_end_400:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_394
    b after_func_401_402
func_401:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_407
    adr x0, sign_id
    b cmp_end_408
cmp_true_407:
cmp_end_408:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_405
    b or_end_406
or_right_405:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_409
    adr x0, sign_id
    b cmp_end_410
cmp_true_409:
cmp_end_410:
or_end_406:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_403
    b or_end_404
or_right_403:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_411
    adr x0, sign_id
    b cmp_end_412
cmp_true_411:
cmp_end_412:
or_end_404:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_401_402:
    // Closure for func_401
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_401
    ldr x0, [sp], #16
    bl _cons
    b cond_end_395
cond_false_394:
    adr x0, sign_id
cond_end_395:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_digit
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_418
    tst x9, #1
    b.eq do_concat_417
    tst x0, #1
    b.ne do_compose_415
do_apply_416:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_419
do_compose_415:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_419
do_concat_417:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_419
id_morphism_418:
    b apply_end_419
apply_end_419:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_413
    b after_func_420_421
func_420:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_424
    adr x0, sign_id
    b cmp_end_425
cmp_true_424:
cmp_end_425:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_422
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_426
    adr x0, sign_id
    b cmp_end_427
cmp_true_426:
cmp_end_427:
    b and_end_423
and_fail_422:
    adr x0, sign_id
and_end_423:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_420_421:
    // Closure for func_420
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_420
    ldr x0, [sp], #16
    bl _cons
    b cond_end_414
cond_false_413:
    adr x0, sign_id
cond_end_414:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_alpha
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_433
    tst x9, #1
    b.eq do_concat_432
    tst x0, #1
    b.ne do_compose_430
do_apply_431:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_434
do_compose_430:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_434
do_concat_432:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_434
id_morphism_433:
    b apply_end_434
apply_end_434:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_428
    b after_func_435_436
func_435:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_443
    adr x0, sign_id
    b cmp_end_444
cmp_true_443:
cmp_end_444:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_441
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_445
    adr x0, sign_id
    b cmp_end_446
cmp_true_445:
cmp_end_446:
    b and_end_442
and_fail_441:
    adr x0, sign_id
and_end_442:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_439
    b or_end_440
or_right_439:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_449
    adr x0, sign_id
    b cmp_end_450
cmp_true_449:
cmp_end_450:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_447
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_451
    adr x0, sign_id
    b cmp_end_452
cmp_true_451:
cmp_end_452:
    b and_end_448
and_fail_447:
    adr x0, sign_id
and_end_448:
or_end_440:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_437
    b or_end_438
or_right_437:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_453
    adr x0, sign_id
    b cmp_end_454
cmp_true_453:
cmp_end_454:
or_end_438:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_435_436:
    // Closure for func_435
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_435
    ldr x0, [sp], #16
    bl _cons
    b cond_end_429
cond_false_428:
    adr x0, sign_id
cond_end_429:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_op_char
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_460
    tst x9, #1
    b.eq do_concat_459
    tst x0, #1
    b.ne do_compose_457
do_apply_458:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_461
do_compose_457:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_461
do_concat_459:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_461
id_morphism_460:
    b apply_end_461
apply_end_461:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_455
    b after_func_462_463
func_462:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_494
    adr x0, sign_id
    b cmp_end_495
cmp_true_494:
cmp_end_495:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_492
    b or_end_493
or_right_492:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_496
    adr x0, sign_id
    b cmp_end_497
cmp_true_496:
cmp_end_497:
or_end_493:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_490
    b or_end_491
or_right_490:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_498
    adr x0, sign_id
    b cmp_end_499
cmp_true_498:
cmp_end_499:
or_end_491:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_488
    b or_end_489
or_right_488:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_500
    adr x0, sign_id
    b cmp_end_501
cmp_true_500:
cmp_end_501:
or_end_489:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_486
    b or_end_487
or_right_486:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_502
    adr x0, sign_id
    b cmp_end_503
cmp_true_502:
cmp_end_503:
or_end_487:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_484
    b or_end_485
or_right_484:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_504
    adr x0, sign_id
    b cmp_end_505
cmp_true_504:
cmp_end_505:
or_end_485:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_482
    b or_end_483
or_right_482:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_506
    adr x0, sign_id
    b cmp_end_507
cmp_true_506:
cmp_end_507:
or_end_483:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_480
    b or_end_481
or_right_480:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_508
    adr x0, sign_id
    b cmp_end_509
cmp_true_508:
cmp_end_509:
or_end_481:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_478
    b or_end_479
or_right_478:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_510
    adr x0, sign_id
    b cmp_end_511
cmp_true_510:
cmp_end_511:
or_end_479:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_476
    b or_end_477
or_right_476:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_512
    adr x0, sign_id
    b cmp_end_513
cmp_true_512:
cmp_end_513:
or_end_477:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_474
    b or_end_475
or_right_474:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_514
    adr x0, sign_id
    b cmp_end_515
cmp_true_514:
cmp_end_515:
or_end_475:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_472
    b or_end_473
or_right_472:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_516
    adr x0, sign_id
    b cmp_end_517
cmp_true_516:
cmp_end_517:
or_end_473:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_470
    b or_end_471
or_right_470:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_518
    adr x0, sign_id
    b cmp_end_519
cmp_true_518:
cmp_end_519:
or_end_471:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_468
    b or_end_469
or_right_468:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_520
    adr x0, sign_id
    b cmp_end_521
cmp_true_520:
cmp_end_521:
or_end_469:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_466
    b or_end_467
or_right_466:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_522
    adr x0, sign_id
    b cmp_end_523
cmp_true_522:
cmp_end_523:
or_end_467:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_464
    b or_end_465
or_right_464:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_524
    adr x0, sign_id
    b cmp_end_525
cmp_true_524:
cmp_end_525:
or_end_465:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_462_463:
    // Closure for func_462
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_462
    ldr x0, [sp], #16
    bl _cons
    b cond_end_456
cond_false_455:
    adr x0, sign_id
cond_end_456:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, length
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_531
    tst x9, #1
    b.eq do_concat_530
    tst x0, #1
    b.ne do_compose_528
do_apply_529:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_532
do_compose_528:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_532
do_concat_530:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_532
id_morphism_531:
    b apply_end_532
apply_end_532:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_526
    b after_func_533_534
func_533:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_538
    adr x0, sign_id
    b cmp_end_539
cmp_true_538:
cmp_end_539:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_536
    mov x0, #0
    b cond_end_537
cond_false_536:
    adr x0, sign_id
cond_end_537:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_535
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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_543
    tst x9, #1
    b.eq do_concat_542
    tst x0, #1
    b.ne do_compose_540
do_apply_541:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_544
do_compose_540:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_544
do_concat_542:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_544
id_morphism_543:
    b apply_end_544
apply_end_544:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_548
    tst x9, #1
    b.eq do_concat_547
    tst x0, #1
    b.ne do_compose_545
do_apply_546:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_549
do_compose_545:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_549
do_concat_547:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_549
id_morphism_548:
    b apply_end_549
apply_end_549:
blk_end_535:
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
    b cond_end_527
cond_false_526:
    adr x0, sign_id
cond_end_527:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, reverse
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_555
    tst x9, #1
    b.eq do_concat_554
    tst x0, #1
    b.ne do_compose_552
do_apply_553:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_556
do_compose_552:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_556
do_concat_554:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_556
id_morphism_555:
    b apply_end_556
apply_end_556:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_550
    b after_func_557_558
func_557:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _rev
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_562
    tst x9, #1
    b.eq do_concat_561
    tst x0, #1
    b.ne do_compose_559
do_apply_560:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_563
do_compose_559:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_563
do_concat_561:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_563
id_morphism_562:
    b apply_end_563
apply_end_563:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_567
    tst x9, #1
    b.eq do_concat_566
    tst x0, #1
    b.ne do_compose_564
do_apply_565:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_568
do_compose_564:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_568
do_concat_566:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_568
id_morphism_567:
    b apply_end_568
apply_end_568:
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
    b cond_end_551
cond_false_550:
    adr x0, sign_id
cond_end_551:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _rev
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_574
    tst x9, #1
    b.eq do_concat_573
    tst x0, #1
    b.ne do_compose_571
do_apply_572:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_575
do_compose_571:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_575
do_concat_573:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_575
id_morphism_574:
    b apply_end_575
apply_end_575:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_569
    b after_func_576_577
func_576:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_578_579
func_578:
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
    b.eq cmp_true_583
    adr x0, sign_id
    b cmp_end_584
cmp_true_583:
cmp_end_584:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_581
    ldr x0, [x29, #-32]
    b cond_end_582
cond_false_581:
    adr x0, sign_id
cond_end_582:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_580
    adr x0, _rev
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_588
    tst x9, #1
    b.eq do_concat_587
    tst x0, #1
    b.ne do_compose_585
do_apply_586:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_589
do_compose_585:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_589
do_concat_587:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_589
id_morphism_588:
    b apply_end_589
apply_end_589:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_593
    tst x9, #1
    b.eq do_concat_592
    tst x0, #1
    b.ne do_compose_590
do_apply_591:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_594
do_compose_590:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_594
do_concat_592:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_594
id_morphism_593:
    b apply_end_594
apply_end_594:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_598
    tst x9, #1
    b.eq do_concat_597
    tst x0, #1
    b.ne do_compose_595
do_apply_596:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_599
do_compose_595:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_599
do_concat_597:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_599
id_morphism_598:
    b apply_end_599
apply_end_599:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_603
    tst x9, #1
    b.eq do_concat_602
    tst x0, #1
    b.ne do_compose_600
do_apply_601:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_604
do_compose_600:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_604
do_concat_602:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_604
id_morphism_603:
    b apply_end_604
apply_end_604:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_608
    tst x9, #1
    b.eq do_concat_607
    tst x0, #1
    b.ne do_compose_605
do_apply_606:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_609
do_compose_605:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_609
do_concat_607:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_609
id_morphism_608:
    b apply_end_609
apply_end_609:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_613
    tst x9, #1
    b.eq do_concat_612
    tst x0, #1
    b.ne do_compose_610
do_apply_611:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_614
do_compose_610:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_614
do_concat_612:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_614
id_morphism_613:
    b apply_end_614
apply_end_614:
blk_end_580:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_578_579:
    // Closure for func_578
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_578
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_576_577:
    // Closure for func_576
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_576
    ldr x0, [sp], #16
    bl _cons
    b cond_end_570
cond_false_569:
    adr x0, sign_id
cond_end_570:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, list_to_string
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_620
    tst x9, #1
    b.eq do_concat_619
    tst x0, #1
    b.ne do_compose_617
do_apply_618:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_621
do_compose_617:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_621
do_concat_619:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_621
id_morphism_620:
    b apply_end_621
apply_end_621:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_615
    b after_func_622_623
func_622:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_625_626
func_625:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_625_626:
    // Closure for func_625
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_625
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_628_629
func_628:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_628_629:
    // Closure for func_628
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_628
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, _write_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_634
    tst x9, #1
    b.eq do_concat_633
    tst x0, #1
    b.ne do_compose_631
do_apply_632:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_635
do_compose_631:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_635
do_concat_633:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_635
id_morphism_634:
    b apply_end_635
apply_end_635:
    str x0, [sp, #-16]!
    adr x0, str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_639
    tst x9, #1
    b.eq do_concat_638
    tst x0, #1
    b.ne do_compose_636
do_apply_637:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_640
do_compose_636:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_640
do_concat_638:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_640
id_morphism_639:
    b apply_end_640
apply_end_640:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_644
    tst x9, #1
    b.eq do_concat_643
    tst x0, #1
    b.ne do_compose_641
do_apply_642:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_645
do_compose_641:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_645
do_concat_643:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_645
id_morphism_644:
    b apply_end_645
apply_end_645:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_630
    adr x0, str
    str x0, [sp, #-16]!
    adr x0, len
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_630
    adr x0, str
blk_end_630:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_649
    tst x9, #1
    b.eq do_concat_648
    tst x0, #1
    b.ne do_compose_646
do_apply_647:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_650
do_compose_646:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_650
do_concat_648:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_650
id_morphism_649:
    b apply_end_650
apply_end_650:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_627
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_654
    tst x9, #1
    b.eq do_concat_653
    tst x0, #1
    b.ne do_compose_651
do_apply_652:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_655
do_compose_651:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_655
do_concat_653:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_655
id_morphism_654:
    b apply_end_655
apply_end_655:
blk_end_627:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_659
    tst x9, #1
    b.eq do_concat_658
    tst x0, #1
    b.ne do_compose_656
do_apply_657:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_660
do_compose_656:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_660
do_concat_658:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_660
id_morphism_659:
    b apply_end_660
apply_end_660:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_624
    adr x0, length
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_664
    tst x9, #1
    b.eq do_concat_663
    tst x0, #1
    b.ne do_compose_661
do_apply_662:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_665
do_compose_661:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_665
do_concat_663:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_665
id_morphism_664:
    b apply_end_665
apply_end_665:
blk_end_624:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_622_623:
    // Closure for func_622
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_622
    ldr x0, [sp], #16
    bl _cons
    b cond_end_616
cond_false_615:
    adr x0, sign_id
cond_end_616:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _write_list
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_671
    tst x9, #1
    b.eq do_concat_670
    tst x0, #1
    b.ne do_compose_668
do_apply_669:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_672
do_compose_668:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_672
do_concat_670:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_672
id_morphism_671:
    b apply_end_672
apply_end_672:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_666
    b after_func_673_674
func_673:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_675_676
func_675:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_677_678
func_677:
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
    b.eq cmp_true_682
    adr x0, sign_id
    b cmp_end_683
cmp_true_682:
cmp_end_683:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_680
    mov x0, #0
    b cond_end_681
cond_false_680:
    adr x0, sign_id
cond_end_681:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_679
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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_687
    tst x9, #1
    b.eq do_concat_686
    tst x0, #1
    b.ne do_compose_684
do_apply_685:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_688
do_compose_684:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_688
do_concat_686:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_688
id_morphism_687:
    b apply_end_688
apply_end_688:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_679
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_692
    tst x9, #1
    b.eq do_concat_691
    tst x0, #1
    b.ne do_compose_689
do_apply_690:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_693
do_compose_689:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_693
do_concat_691:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_693
id_morphism_692:
    b apply_end_693
apply_end_693:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_697
    tst x9, #1
    b.eq do_concat_696
    tst x0, #1
    b.ne do_compose_694
do_apply_695:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_698
do_compose_694:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_698
do_concat_696:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_698
id_morphism_697:
    b apply_end_698
apply_end_698:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_702
    tst x9, #1
    b.eq do_concat_701
    tst x0, #1
    b.ne do_compose_699
do_apply_700:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_703
do_compose_699:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_703
do_concat_701:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_703
id_morphism_702:
    b apply_end_703
apply_end_703:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_707
    tst x9, #1
    b.eq do_concat_706
    tst x0, #1
    b.ne do_compose_704
do_apply_705:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_708
do_compose_704:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_708
do_concat_706:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_708
id_morphism_707:
    b apply_end_708
apply_end_708:
blk_end_679:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_677_678:
    // Closure for func_677
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
    adr x1, func_677
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_675_676:
    // Closure for func_675
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_675
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_673_674:
    // Closure for func_673
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_673
    ldr x0, [sp], #16
    bl _cons
    b cond_end_667
cond_false_666:
    adr x0, sign_id
cond_end_667:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tokenize
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_714
    tst x9, #1
    b.eq do_concat_713
    tst x0, #1
    b.ne do_compose_711
do_apply_712:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_715
do_compose_711:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_715
do_concat_713:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_715
id_morphism_714:
    b apply_end_715
apply_end_715:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_709
    b after_func_716_717
func_716:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_721
    tst x9, #1
    b.eq do_concat_720
    tst x0, #1
    b.ne do_compose_718
do_apply_719:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_722
do_compose_718:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_722
do_concat_720:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_722
id_morphism_721:
    b apply_end_722
apply_end_722:
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_726
    tst x9, #1
    b.eq do_concat_725
    tst x0, #1
    b.ne do_compose_723
do_apply_724:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_727
do_compose_723:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_727
do_concat_725:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_727
id_morphism_726:
    b apply_end_727
apply_end_727:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_731
    tst x9, #1
    b.eq do_concat_730
    tst x0, #1
    b.ne do_compose_728
do_apply_729:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_732
do_compose_728:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_732
do_concat_730:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_732
id_morphism_731:
    b apply_end_732
apply_end_732:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_736
    tst x9, #1
    b.eq do_concat_735
    tst x0, #1
    b.ne do_compose_733
do_apply_734:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_737
do_compose_733:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_737
do_concat_735:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_737
id_morphism_736:
    b apply_end_737
apply_end_737:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_716_717:
    // Closure for func_716
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_716
    ldr x0, [sp], #16
    bl _cons
    b cond_end_710
cond_false_709:
    adr x0, sign_id
cond_end_710:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_743
    tst x9, #1
    b.eq do_concat_742
    tst x0, #1
    b.ne do_compose_740
do_apply_741:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_744
do_compose_740:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_744
do_concat_742:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_744
id_morphism_743:
    b apply_end_744
apply_end_744:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_738
    b after_func_745_746
func_745:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_747_748
func_747:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_749_750
func_749:
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
    b after_func_752_753
func_752:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    b after_func_755_756
func_755:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_755_756:
    // Closure for func_755
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_755
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_758_759
func_758:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_758_759:
    // Closure for func_758
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_758
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_763
    adr x0, sign_id
    b cmp_end_764
cmp_true_763:
cmp_end_764:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_761
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, token
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_768
    tst x9, #1
    b.eq do_concat_767
    tst x0, #1
    b.ne do_compose_765
do_apply_766:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_769
do_compose_765:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_769
do_concat_767:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_769
id_morphism_768:
    b apply_end_769
apply_end_769:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_773
    tst x9, #1
    b.eq do_concat_772
    tst x0, #1
    b.ne do_compose_770
do_apply_771:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_774
do_compose_770:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_774
do_concat_772:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_774
id_morphism_773:
    b apply_end_774
apply_end_774:
    b cond_end_762
cond_false_761:
    adr x0, sign_id
cond_end_762:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_760
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, token
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_778
    tst x9, #1
    b.eq do_concat_777
    tst x0, #1
    b.ne do_compose_775
do_apply_776:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_779
do_compose_775:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_779
do_concat_777:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_779
id_morphism_778:
    b apply_end_779
apply_end_779:
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_783
    tst x9, #1
    b.eq do_concat_782
    tst x0, #1
    b.ne do_compose_780
do_apply_781:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_784
do_compose_780:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_784
do_concat_782:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_784
id_morphism_783:
    b apply_end_784
apply_end_784:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_788
    tst x9, #1
    b.eq do_concat_787
    tst x0, #1
    b.ne do_compose_785
do_apply_786:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_789
do_compose_785:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_789
do_concat_787:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_789
id_morphism_788:
    b apply_end_789
apply_end_789:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_793
    tst x9, #1
    b.eq do_concat_792
    tst x0, #1
    b.ne do_compose_790
do_apply_791:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_794
do_compose_790:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_794
do_concat_792:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_794
id_morphism_793:
    b apply_end_794
apply_end_794:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_798
    tst x9, #1
    b.eq do_concat_797
    tst x0, #1
    b.ne do_compose_795
do_apply_796:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_799
do_compose_795:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_799
do_concat_797:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_799
id_morphism_798:
    b apply_end_799
apply_end_799:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_803
    tst x9, #1
    b.eq do_concat_802
    tst x0, #1
    b.ne do_compose_800
do_apply_801:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_804
do_compose_800:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_804
do_concat_802:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_804
id_morphism_803:
    b apply_end_804
apply_end_804:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_808
    tst x9, #1
    b.eq do_concat_807
    tst x0, #1
    b.ne do_compose_805
do_apply_806:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_809
do_compose_805:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_809
do_concat_807:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_809
id_morphism_808:
    b apply_end_809
apply_end_809:
blk_end_760:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_813
    tst x9, #1
    b.eq do_concat_812
    tst x0, #1
    b.ne do_compose_810
do_apply_811:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_814
do_compose_810:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_814
do_concat_812:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_814
id_morphism_813:
    b apply_end_814
apply_end_814:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_757
    adr x0, token
    ldr x0, [x0] // @ load
blk_end_757:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_818
    tst x9, #1
    b.eq do_concat_817
    tst x0, #1
    b.ne do_compose_815
do_apply_816:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_819
do_compose_815:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_819
do_concat_817:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_819
id_morphism_818:
    b apply_end_819
apply_end_819:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_754
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_823
    tst x9, #1
    b.eq do_concat_822
    tst x0, #1
    b.ne do_compose_820
do_apply_821:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_824
do_compose_820:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_824
do_concat_822:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_824
id_morphism_823:
    b apply_end_824
apply_end_824:
blk_end_754:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_828
    tst x9, #1
    b.eq do_concat_827
    tst x0, #1
    b.ne do_compose_825
do_apply_826:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_829
do_compose_825:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_829
do_concat_827:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_829
id_morphism_828:
    b apply_end_829
apply_end_829:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_751
    adr x0, scan_token
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_833
    tst x9, #1
    b.eq do_concat_832
    tst x0, #1
    b.ne do_compose_830
do_apply_831:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_834
do_compose_830:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_834
do_concat_832:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_834
id_morphism_833:
    b apply_end_834
apply_end_834:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_838
    tst x9, #1
    b.eq do_concat_837
    tst x0, #1
    b.ne do_compose_835
do_apply_836:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_839
do_compose_835:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_839
do_concat_837:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_839
id_morphism_838:
    b apply_end_839
apply_end_839:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_843
    tst x9, #1
    b.eq do_concat_842
    tst x0, #1
    b.ne do_compose_840
do_apply_841:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_844
do_compose_840:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_844
do_concat_842:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_844
id_morphism_843:
    b apply_end_844
apply_end_844:
blk_end_751:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_749_750:
    // Closure for func_749
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
    adr x1, func_749
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_747_748:
    // Closure for func_747
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_747
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_739
cond_false_738:
    adr x0, sign_id
cond_end_739:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_token
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_850
    tst x9, #1
    b.eq do_concat_849
    tst x0, #1
    b.ne do_compose_847
do_apply_848:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_851
do_compose_847:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_851
do_concat_849:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_851
id_morphism_850:
    b apply_end_851
apply_end_851:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_845
    b after_func_852_853
func_852:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_854_855
func_854:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_856_857
func_856:
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
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_861
    adr x0, sign_id
    b cmp_end_862
cmp_true_861:
cmp_end_862:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_859
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_866
    tst x9, #1
    b.eq do_concat_865
    tst x0, #1
    b.ne do_compose_863
do_apply_864:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_867
do_compose_863:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_867
do_concat_865:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_867
id_morphism_866:
    b apply_end_867
apply_end_867:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_871
    tst x9, #1
    b.eq do_concat_870
    tst x0, #1
    b.ne do_compose_868
do_apply_869:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_872
do_compose_868:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_872
do_concat_870:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_872
id_morphism_871:
    b apply_end_872
apply_end_872:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_876
    tst x9, #1
    b.eq do_concat_875
    tst x0, #1
    b.ne do_compose_873
do_apply_874:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_877
do_compose_873:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_877
do_concat_875:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_877
id_morphism_876:
    b apply_end_877
apply_end_877:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_881
    tst x9, #1
    b.eq do_concat_880
    tst x0, #1
    b.ne do_compose_878
do_apply_879:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_882
do_compose_878:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_882
do_concat_880:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_882
id_morphism_881:
    b apply_end_882
apply_end_882:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_886
    tst x9, #1
    b.eq do_concat_885
    tst x0, #1
    b.ne do_compose_883
do_apply_884:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_887
do_compose_883:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_887
do_concat_885:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_887
id_morphism_886:
    b apply_end_887
apply_end_887:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_891
    tst x9, #1
    b.eq do_concat_890
    tst x0, #1
    b.ne do_compose_888
do_apply_889:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_892
do_compose_888:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_892
do_concat_890:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_892
id_morphism_891:
    b apply_end_892
apply_end_892:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_896
    tst x9, #1
    b.eq do_concat_895
    tst x0, #1
    b.ne do_compose_893
do_apply_894:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_897
do_compose_893:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_897
do_concat_895:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_897
id_morphism_896:
    b apply_end_897
apply_end_897:
    b cond_end_860
cond_false_859:
    adr x0, sign_id
cond_end_860:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_858
    b after_func_898_899
func_898:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_898_899:
    // Closure for func_898
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_898
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, c
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_906
    tst x9, #1
    b.eq do_concat_905
    tst x0, #1
    b.ne do_compose_903
do_apply_904:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_907
do_compose_903:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_907
do_concat_905:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_907
id_morphism_906:
    b apply_end_907
apply_end_907:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_901
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, scan_token
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_911
    tst x9, #1
    b.eq do_concat_910
    tst x0, #1
    b.ne do_compose_908
do_apply_909:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_912
do_compose_908:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_912
do_concat_910:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_912
id_morphism_911:
    b apply_end_912
apply_end_912:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_916
    tst x9, #1
    b.eq do_concat_915
    tst x0, #1
    b.ne do_compose_913
do_apply_914:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_917
do_compose_913:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_917
do_concat_915:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_917
id_morphism_916:
    b apply_end_917
apply_end_917:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_921
    tst x9, #1
    b.eq do_concat_920
    tst x0, #1
    b.ne do_compose_918
do_apply_919:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_922
do_compose_918:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_922
do_concat_920:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_922
id_morphism_921:
    b apply_end_922
apply_end_922:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_926
    tst x9, #1
    b.eq do_concat_925
    tst x0, #1
    b.ne do_compose_923
do_apply_924:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_927
do_compose_923:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_927
do_concat_925:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_927
id_morphism_926:
    b apply_end_927
apply_end_927:
    b cond_end_902
cond_false_901:
    adr x0, sign_id
cond_end_902:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_900
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_930
    adr x0, sign_id
    b cmp_end_931
cmp_true_930:
cmp_end_931:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_928
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_935
    tst x9, #1
    b.eq do_concat_934
    tst x0, #1
    b.ne do_compose_932
do_apply_933:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_936
do_compose_932:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_936
do_concat_934:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_936
id_morphism_935:
    b apply_end_936
apply_end_936:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_940
    tst x9, #1
    b.eq do_concat_939
    tst x0, #1
    b.ne do_compose_937
do_apply_938:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_941
do_compose_937:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_941
do_concat_939:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_941
id_morphism_940:
    b apply_end_941
apply_end_941:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_945
    tst x9, #1
    b.eq do_concat_944
    tst x0, #1
    b.ne do_compose_942
do_apply_943:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_946
do_compose_942:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_946
do_concat_944:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_946
id_morphism_945:
    b apply_end_946
apply_end_946:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_950
    tst x9, #1
    b.eq do_concat_949
    tst x0, #1
    b.ne do_compose_947
do_apply_948:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_951
do_compose_947:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_951
do_concat_949:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_951
id_morphism_950:
    b apply_end_951
apply_end_951:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_955
    tst x9, #1
    b.eq do_concat_954
    tst x0, #1
    b.ne do_compose_952
do_apply_953:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_956
do_compose_952:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_956
do_concat_954:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_956
id_morphism_955:
    b apply_end_956
apply_end_956:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_960
    tst x9, #1
    b.eq do_concat_959
    tst x0, #1
    b.ne do_compose_957
do_apply_958:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_961
do_compose_957:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_961
do_concat_959:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_961
id_morphism_960:
    b apply_end_961
apply_end_961:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_965
    tst x9, #1
    b.eq do_concat_964
    tst x0, #1
    b.ne do_compose_962
do_apply_963:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_966
do_compose_962:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_966
do_concat_964:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_966
id_morphism_965:
    b apply_end_966
apply_end_966:
    b cond_end_929
cond_false_928:
    adr x0, sign_id
cond_end_929:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_900
    adr x0, is_digit
    str x0, [sp, #-16]!
    adr x0, c
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_972
    tst x9, #1
    b.eq do_concat_971
    tst x0, #1
    b.ne do_compose_969
do_apply_970:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_973
do_compose_969:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_973
do_concat_971:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_973
id_morphism_972:
    b apply_end_973
apply_end_973:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_967
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_975_976
func_975:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_975_976:
    // Closure for func_975
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_975
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_978_979
func_978:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b after_func_981_982
func_981:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_981_982:
    // Closure for func_981
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_981
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_986
    tst x9, #1
    b.eq do_concat_985
    tst x0, #1
    b.ne do_compose_983
do_apply_984:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_987
do_compose_983:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_987
do_concat_985:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_987
id_morphism_986:
    b apply_end_987
apply_end_987:
    str x0, [sp, #-16]!
    adr x0, val
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_991
    tst x9, #1
    b.eq do_concat_990
    tst x0, #1
    b.ne do_compose_988
do_apply_989:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_992
do_compose_988:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_992
do_concat_990:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_992
id_morphism_991:
    b apply_end_992
apply_end_992:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_996
    tst x9, #1
    b.eq do_concat_995
    tst x0, #1
    b.ne do_compose_993
do_apply_994:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_997
do_compose_993:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_997
do_concat_995:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_997
id_morphism_996:
    b apply_end_997
apply_end_997:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1001
    tst x9, #1
    b.eq do_concat_1000
    tst x0, #1
    b.ne do_compose_998
do_apply_999:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1002
do_compose_998:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1002
do_concat_1000:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1002
id_morphism_1001:
    b apply_end_1002
apply_end_1002:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1006
    tst x9, #1
    b.eq do_concat_1005
    tst x0, #1
    b.ne do_compose_1003
do_apply_1004:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1007
do_compose_1003:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1007
do_concat_1005:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1007
id_morphism_1006:
    b apply_end_1007
apply_end_1007:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1011
    tst x9, #1
    b.eq do_concat_1010
    tst x0, #1
    b.ne do_compose_1008
do_apply_1009:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1012
do_compose_1008:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1012
do_concat_1010:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1012
id_morphism_1011:
    b apply_end_1012
apply_end_1012:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1016
    tst x9, #1
    b.eq do_concat_1015
    tst x0, #1
    b.ne do_compose_1013
do_apply_1014:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1017
do_compose_1013:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1017
do_concat_1015:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1017
id_morphism_1016:
    b apply_end_1017
apply_end_1017:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1021
    tst x9, #1
    b.eq do_concat_1020
    tst x0, #1
    b.ne do_compose_1018
do_apply_1019:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1022
do_compose_1018:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1022
do_concat_1020:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1022
id_morphism_1021:
    b apply_end_1022
apply_end_1022:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1026
    tst x9, #1
    b.eq do_concat_1025
    tst x0, #1
    b.ne do_compose_1023
do_apply_1024:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1027
do_compose_1023:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1027
do_concat_1025:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1027
id_morphism_1026:
    b apply_end_1027
apply_end_1027:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_980
    adr x0, _parse_int
    str x0, [sp, #-16]!
    adr x0, val_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1031
    tst x9, #1
    b.eq do_concat_1030
    tst x0, #1
    b.ne do_compose_1028
do_apply_1029:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1032
do_compose_1028:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1032
do_concat_1030:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1032
id_morphism_1031:
    b apply_end_1032
apply_end_1032:
blk_end_980:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1036
    tst x9, #1
    b.eq do_concat_1035
    tst x0, #1
    b.ne do_compose_1033
do_apply_1034:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1037
do_compose_1033:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1037
do_concat_1035:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1037
id_morphism_1036:
    b apply_end_1037
apply_end_1037:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_977
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1041
    tst x9, #1
    b.eq do_concat_1040
    tst x0, #1
    b.ne do_compose_1038
do_apply_1039:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1042
do_compose_1038:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1042
do_concat_1040:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1042
id_morphism_1041:
    b apply_end_1042
apply_end_1042:
blk_end_977:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1046
    tst x9, #1
    b.eq do_concat_1045
    tst x0, #1
    b.ne do_compose_1043
do_apply_1044:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1047
do_compose_1043:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1047
do_concat_1045:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1047
id_morphism_1046:
    b apply_end_1047
apply_end_1047:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_974
    adr x0, scan_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1051
    tst x9, #1
    b.eq do_concat_1050
    tst x0, #1
    b.ne do_compose_1048
do_apply_1049:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1052
do_compose_1048:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1052
do_concat_1050:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1052
id_morphism_1051:
    b apply_end_1052
apply_end_1052:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1056
    tst x9, #1
    b.eq do_concat_1055
    tst x0, #1
    b.ne do_compose_1053
do_apply_1054:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1057
do_compose_1053:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1057
do_concat_1055:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1057
id_morphism_1056:
    b apply_end_1057
apply_end_1057:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1061
    tst x9, #1
    b.eq do_concat_1060
    tst x0, #1
    b.ne do_compose_1058
do_apply_1059:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1062
do_compose_1058:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1062
do_concat_1060:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1062
id_morphism_1061:
    b apply_end_1062
apply_end_1062:
blk_end_974:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1066
    tst x9, #1
    b.eq do_concat_1065
    tst x0, #1
    b.ne do_compose_1063
do_apply_1064:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1067
do_compose_1063:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1067
do_concat_1065:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1067
id_morphism_1066:
    b apply_end_1067
apply_end_1067:
    b cond_end_968
cond_false_967:
    adr x0, sign_id
cond_end_968:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_900
    adr x0, is_alpha
    str x0, [sp, #-16]!
    adr x0, c
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1073
    tst x9, #1
    b.eq do_concat_1072
    tst x0, #1
    b.ne do_compose_1070
do_apply_1071:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1074
do_compose_1070:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1074
do_concat_1072:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1074
id_morphism_1073:
    b apply_end_1074
apply_end_1074:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1068
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_1076_1077
func_1076:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1076_1077:
    // Closure for func_1076
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1076
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1081
    tst x9, #1
    b.eq do_concat_1080
    tst x0, #1
    b.ne do_compose_1078
do_apply_1079:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1082
do_compose_1078:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1082
do_concat_1080:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1082
id_morphism_1081:
    b apply_end_1082
apply_end_1082:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1086
    tst x9, #1
    b.eq do_concat_1085
    tst x0, #1
    b.ne do_compose_1083
do_apply_1084:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1087
do_compose_1083:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1087
do_concat_1085:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1087
id_morphism_1086:
    b apply_end_1087
apply_end_1087:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1091
    tst x9, #1
    b.eq do_concat_1090
    tst x0, #1
    b.ne do_compose_1088
do_apply_1089:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1092
do_compose_1088:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1092
do_concat_1090:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1092
id_morphism_1091:
    b apply_end_1092
apply_end_1092:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1096
    tst x9, #1
    b.eq do_concat_1095
    tst x0, #1
    b.ne do_compose_1093
do_apply_1094:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1097
do_compose_1093:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1097
do_concat_1095:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1097
id_morphism_1096:
    b apply_end_1097
apply_end_1097:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1101
    tst x9, #1
    b.eq do_concat_1100
    tst x0, #1
    b.ne do_compose_1098
do_apply_1099:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1102
do_compose_1098:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1102
do_concat_1100:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1102
id_morphism_1101:
    b apply_end_1102
apply_end_1102:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1106
    tst x9, #1
    b.eq do_concat_1105
    tst x0, #1
    b.ne do_compose_1103
do_apply_1104:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1107
do_compose_1103:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1107
do_concat_1105:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1107
id_morphism_1106:
    b apply_end_1107
apply_end_1107:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1111
    tst x9, #1
    b.eq do_concat_1110
    tst x0, #1
    b.ne do_compose_1108
do_apply_1109:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1112
do_compose_1108:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1112
do_concat_1110:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1112
id_morphism_1111:
    b apply_end_1112
apply_end_1112:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1116
    tst x9, #1
    b.eq do_concat_1115
    tst x0, #1
    b.ne do_compose_1113
do_apply_1114:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1117
do_compose_1113:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1117
do_concat_1115:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1117
id_morphism_1116:
    b apply_end_1117
apply_end_1117:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1121
    tst x9, #1
    b.eq do_concat_1120
    tst x0, #1
    b.ne do_compose_1118
do_apply_1119:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1122
do_compose_1118:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1122
do_concat_1120:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1122
id_morphism_1121:
    b apply_end_1122
apply_end_1122:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1126
    tst x9, #1
    b.eq do_concat_1125
    tst x0, #1
    b.ne do_compose_1123
do_apply_1124:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1127
do_compose_1123:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1127
do_concat_1125:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1127
id_morphism_1126:
    b apply_end_1127
apply_end_1127:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1075
    adr x0, scan_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1131
    tst x9, #1
    b.eq do_concat_1130
    tst x0, #1
    b.ne do_compose_1128
do_apply_1129:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1132
do_compose_1128:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1132
do_concat_1130:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1132
id_morphism_1131:
    b apply_end_1132
apply_end_1132:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1136
    tst x9, #1
    b.eq do_concat_1135
    tst x0, #1
    b.ne do_compose_1133
do_apply_1134:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1137
do_compose_1133:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1137
do_concat_1135:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1137
id_morphism_1136:
    b apply_end_1137
apply_end_1137:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1141
    tst x9, #1
    b.eq do_concat_1140
    tst x0, #1
    b.ne do_compose_1138
do_apply_1139:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1142
do_compose_1138:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1142
do_concat_1140:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1142
id_morphism_1141:
    b apply_end_1142
apply_end_1142:
blk_end_1075:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1146
    tst x9, #1
    b.eq do_concat_1145
    tst x0, #1
    b.ne do_compose_1143
do_apply_1144:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1147
do_compose_1143:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1147
do_concat_1145:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1147
id_morphism_1146:
    b apply_end_1147
apply_end_1147:
    b cond_end_1069
cond_false_1068:
    adr x0, sign_id
cond_end_1069:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_900
    adr x0, is_op_char
    str x0, [sp, #-16]!
    adr x0, c
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1153
    tst x9, #1
    b.eq do_concat_1152
    tst x0, #1
    b.ne do_compose_1150
do_apply_1151:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1154
do_compose_1150:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1154
do_concat_1152:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1154
id_morphism_1153:
    b apply_end_1154
apply_end_1154:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1148
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_1156_1157
func_1156:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1156_1157:
    // Closure for func_1156
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1156
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1161
    tst x9, #1
    b.eq do_concat_1160
    tst x0, #1
    b.ne do_compose_1158
do_apply_1159:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1162
do_compose_1158:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1162
do_concat_1160:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1162
id_morphism_1161:
    b apply_end_1162
apply_end_1162:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1166
    tst x9, #1
    b.eq do_concat_1165
    tst x0, #1
    b.ne do_compose_1163
do_apply_1164:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1167
do_compose_1163:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1167
do_concat_1165:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1167
id_morphism_1166:
    b apply_end_1167
apply_end_1167:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1171
    tst x9, #1
    b.eq do_concat_1170
    tst x0, #1
    b.ne do_compose_1168
do_apply_1169:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1172
do_compose_1168:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1172
do_concat_1170:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1172
id_morphism_1171:
    b apply_end_1172
apply_end_1172:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1176
    tst x9, #1
    b.eq do_concat_1175
    tst x0, #1
    b.ne do_compose_1173
do_apply_1174:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1177
do_compose_1173:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1177
do_concat_1175:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1177
id_morphism_1176:
    b apply_end_1177
apply_end_1177:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1181
    tst x9, #1
    b.eq do_concat_1180
    tst x0, #1
    b.ne do_compose_1178
do_apply_1179:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1182
do_compose_1178:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1182
do_concat_1180:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1182
id_morphism_1181:
    b apply_end_1182
apply_end_1182:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1186
    tst x9, #1
    b.eq do_concat_1185
    tst x0, #1
    b.ne do_compose_1183
do_apply_1184:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1187
do_compose_1183:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1187
do_concat_1185:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1187
id_morphism_1186:
    b apply_end_1187
apply_end_1187:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1191
    tst x9, #1
    b.eq do_concat_1190
    tst x0, #1
    b.ne do_compose_1188
do_apply_1189:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1192
do_compose_1188:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1192
do_concat_1190:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1192
id_morphism_1191:
    b apply_end_1192
apply_end_1192:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1196
    tst x9, #1
    b.eq do_concat_1195
    tst x0, #1
    b.ne do_compose_1193
do_apply_1194:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1197
do_compose_1193:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1197
do_concat_1195:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1197
id_morphism_1196:
    b apply_end_1197
apply_end_1197:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1201
    tst x9, #1
    b.eq do_concat_1200
    tst x0, #1
    b.ne do_compose_1198
do_apply_1199:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1202
do_compose_1198:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1202
do_concat_1200:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1202
id_morphism_1201:
    b apply_end_1202
apply_end_1202:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1206
    tst x9, #1
    b.eq do_concat_1205
    tst x0, #1
    b.ne do_compose_1203
do_apply_1204:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1207
do_compose_1203:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1207
do_concat_1205:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1207
id_morphism_1206:
    b apply_end_1207
apply_end_1207:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1155
    adr x0, scan_op
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1211
    tst x9, #1
    b.eq do_concat_1210
    tst x0, #1
    b.ne do_compose_1208
do_apply_1209:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1212
do_compose_1208:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1212
do_concat_1210:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1212
id_morphism_1211:
    b apply_end_1212
apply_end_1212:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1216
    tst x9, #1
    b.eq do_concat_1215
    tst x0, #1
    b.ne do_compose_1213
do_apply_1214:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1217
do_compose_1213:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1217
do_concat_1215:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1217
id_morphism_1216:
    b apply_end_1217
apply_end_1217:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1221
    tst x9, #1
    b.eq do_concat_1220
    tst x0, #1
    b.ne do_compose_1218
do_apply_1219:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1222
do_compose_1218:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1222
do_concat_1220:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1222
id_morphism_1221:
    b apply_end_1222
apply_end_1222:
blk_end_1155:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1226
    tst x9, #1
    b.eq do_concat_1225
    tst x0, #1
    b.ne do_compose_1223
do_apply_1224:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1227
do_compose_1223:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1227
do_concat_1225:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1227
id_morphism_1226:
    b apply_end_1227
apply_end_1227:
    b cond_end_1149
cond_false_1148:
    adr x0, sign_id
cond_end_1149:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_900
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1230
    adr x0, sign_id
    b cmp_end_1231
cmp_true_1230:
cmp_end_1231:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1228
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_1233_1234
func_1233:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1233_1234:
    // Closure for func_1233
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1233
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1238
    tst x9, #1
    b.eq do_concat_1237
    tst x0, #1
    b.ne do_compose_1235
do_apply_1236:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1239
do_compose_1235:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1239
do_concat_1237:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1239
id_morphism_1238:
    b apply_end_1239
apply_end_1239:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1243
    tst x9, #1
    b.eq do_concat_1242
    tst x0, #1
    b.ne do_compose_1240
do_apply_1241:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1244
do_compose_1240:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1244
do_concat_1242:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1244
id_morphism_1243:
    b apply_end_1244
apply_end_1244:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1248
    tst x9, #1
    b.eq do_concat_1247
    tst x0, #1
    b.ne do_compose_1245
do_apply_1246:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1249
do_compose_1245:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1249
do_concat_1247:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1249
id_morphism_1248:
    b apply_end_1249
apply_end_1249:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1253
    tst x9, #1
    b.eq do_concat_1252
    tst x0, #1
    b.ne do_compose_1250
do_apply_1251:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1254
do_compose_1250:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1254
do_concat_1252:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1254
id_morphism_1253:
    b apply_end_1254
apply_end_1254:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1258
    tst x9, #1
    b.eq do_concat_1257
    tst x0, #1
    b.ne do_compose_1255
do_apply_1256:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1259
do_compose_1255:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1259
do_concat_1257:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1259
id_morphism_1258:
    b apply_end_1259
apply_end_1259:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1263
    tst x9, #1
    b.eq do_concat_1262
    tst x0, #1
    b.ne do_compose_1260
do_apply_1261:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1264
do_compose_1260:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1264
do_concat_1262:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1264
id_morphism_1263:
    b apply_end_1264
apply_end_1264:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1268
    tst x9, #1
    b.eq do_concat_1267
    tst x0, #1
    b.ne do_compose_1265
do_apply_1266:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1269
do_compose_1265:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1269
do_concat_1267:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1269
id_morphism_1268:
    b apply_end_1269
apply_end_1269:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1273
    tst x9, #1
    b.eq do_concat_1272
    tst x0, #1
    b.ne do_compose_1270
do_apply_1271:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1274
do_compose_1270:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1274
do_concat_1272:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1274
id_morphism_1273:
    b apply_end_1274
apply_end_1274:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1278
    tst x9, #1
    b.eq do_concat_1277
    tst x0, #1
    b.ne do_compose_1275
do_apply_1276:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1279
do_compose_1275:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1279
do_concat_1277:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1279
id_morphism_1278:
    b apply_end_1279
apply_end_1279:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1283
    tst x9, #1
    b.eq do_concat_1282
    tst x0, #1
    b.ne do_compose_1280
do_apply_1281:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1284
do_compose_1280:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1284
do_concat_1282:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1284
id_morphism_1283:
    b apply_end_1284
apply_end_1284:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1232
    adr x0, scan_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1288
    tst x9, #1
    b.eq do_concat_1287
    tst x0, #1
    b.ne do_compose_1285
do_apply_1286:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1289
do_compose_1285:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1289
do_concat_1287:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1289
id_morphism_1288:
    b apply_end_1289
apply_end_1289:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1293
    tst x9, #1
    b.eq do_concat_1292
    tst x0, #1
    b.ne do_compose_1290
do_apply_1291:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1294
do_compose_1290:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1294
do_concat_1292:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1294
id_morphism_1293:
    b apply_end_1294
apply_end_1294:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1298
    tst x9, #1
    b.eq do_concat_1297
    tst x0, #1
    b.ne do_compose_1295
do_apply_1296:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1299
do_compose_1295:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1299
do_concat_1297:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1299
id_morphism_1298:
    b apply_end_1299
apply_end_1299:
blk_end_1232:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1303
    tst x9, #1
    b.eq do_concat_1302
    tst x0, #1
    b.ne do_compose_1300
do_apply_1301:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1304
do_compose_1300:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1304
do_concat_1302:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1304
id_morphism_1303:
    b apply_end_1304
apply_end_1304:
    b cond_end_1229
cond_false_1228:
    adr x0, sign_id
cond_end_1229:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_900
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_900
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1308
    tst x9, #1
    b.eq do_concat_1307
    tst x0, #1
    b.ne do_compose_1305
do_apply_1306:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1309
do_compose_1305:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1309
do_concat_1307:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1309
id_morphism_1308:
    b apply_end_1309
apply_end_1309:
    str x0, [sp, #-16]!
    adr x0, c
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1313
    tst x9, #1
    b.eq do_concat_1312
    tst x0, #1
    b.ne do_compose_1310
do_apply_1311:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1314
do_compose_1310:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1314
do_concat_1312:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1314
id_morphism_1313:
    b apply_end_1314
apply_end_1314:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1318
    tst x9, #1
    b.eq do_concat_1317
    tst x0, #1
    b.ne do_compose_1315
do_apply_1316:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1319
do_compose_1315:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1319
do_concat_1317:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1319
id_morphism_1318:
    b apply_end_1319
apply_end_1319:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1323
    tst x9, #1
    b.eq do_concat_1322
    tst x0, #1
    b.ne do_compose_1320
do_apply_1321:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1324
do_compose_1320:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1324
do_concat_1322:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1324
id_morphism_1323:
    b apply_end_1324
apply_end_1324:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1328
    tst x9, #1
    b.eq do_concat_1327
    tst x0, #1
    b.ne do_compose_1325
do_apply_1326:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1329
do_compose_1325:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1329
do_concat_1327:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1329
id_morphism_1328:
    b apply_end_1329
apply_end_1329:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1333
    tst x9, #1
    b.eq do_concat_1332
    tst x0, #1
    b.ne do_compose_1330
do_apply_1331:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1334
do_compose_1330:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1334
do_concat_1332:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1334
id_morphism_1333:
    b apply_end_1334
apply_end_1334:
blk_end_900:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1338
    tst x9, #1
    b.eq do_concat_1337
    tst x0, #1
    b.ne do_compose_1335
do_apply_1336:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1339
do_compose_1335:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1339
do_concat_1337:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1339
id_morphism_1338:
    b apply_end_1339
apply_end_1339:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_858
    adr x0, nth
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1343
    tst x9, #1
    b.eq do_concat_1342
    tst x0, #1
    b.ne do_compose_1340
do_apply_1341:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1344
do_compose_1340:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1344
do_concat_1342:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1344
id_morphism_1343:
    b apply_end_1344
apply_end_1344:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1348
    tst x9, #1
    b.eq do_concat_1347
    tst x0, #1
    b.ne do_compose_1345
do_apply_1346:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1349
do_compose_1345:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1349
do_concat_1347:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1349
id_morphism_1348:
    b apply_end_1349
apply_end_1349:
blk_end_858:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_856_857:
    // Closure for func_856
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_856
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_854_855:
    // Closure for func_854
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_854
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_852_853:
    // Closure for func_852
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_852
    ldr x0, [sp], #16
    bl _cons
    b cond_end_846
cond_false_845:
    adr x0, sign_id
cond_end_846:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_num
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1355
    tst x9, #1
    b.eq do_concat_1354
    tst x0, #1
    b.ne do_compose_1352
do_apply_1353:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1356
do_compose_1352:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1356
do_concat_1354:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1356
id_morphism_1355:
    b apply_end_1356
apply_end_1356:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1350
    b after_func_1357_1358
func_1357:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1359_1360
func_1359:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1361_1362
func_1361:
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
    adr x0, _scan_while
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1366
    tst x9, #1
    b.eq do_concat_1365
    tst x0, #1
    b.ne do_compose_1363
do_apply_1364:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1367
do_compose_1363:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1367
do_concat_1365:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1367
id_morphism_1366:
    b apply_end_1367
apply_end_1367:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1371
    tst x9, #1
    b.eq do_concat_1370
    tst x0, #1
    b.ne do_compose_1368
do_apply_1369:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1372
do_compose_1368:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1372
do_concat_1370:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1372
id_morphism_1371:
    b apply_end_1372
apply_end_1372:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1376
    tst x9, #1
    b.eq do_concat_1375
    tst x0, #1
    b.ne do_compose_1373
do_apply_1374:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1377
do_compose_1373:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1377
do_concat_1375:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1377
id_morphism_1376:
    b apply_end_1377
apply_end_1377:
    str x0, [sp, #-16]!
    adr x0, is_digit
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1381
    tst x9, #1
    b.eq do_concat_1380
    tst x0, #1
    b.ne do_compose_1378
do_apply_1379:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1382
do_compose_1378:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1382
do_concat_1380:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1382
id_morphism_1381:
    b apply_end_1382
apply_end_1382:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1361_1362:
    // Closure for func_1361
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
    adr x1, func_1361
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1359_1360:
    // Closure for func_1359
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1359
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1351
cond_false_1350:
    adr x0, sign_id
cond_end_1351:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_id
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1388
    tst x9, #1
    b.eq do_concat_1387
    tst x0, #1
    b.ne do_compose_1385
do_apply_1386:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1389
do_compose_1385:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1389
do_concat_1387:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1389
id_morphism_1388:
    b apply_end_1389
apply_end_1389:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1383
    b after_func_1390_1391
func_1390:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1392_1393
func_1392:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1394_1395
func_1394:
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
    adr x0, str_1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1396
    adr x0, _scan_while
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1400
    tst x9, #1
    b.eq do_concat_1399
    tst x0, #1
    b.ne do_compose_1397
do_apply_1398:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1401
do_compose_1397:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1401
do_concat_1399:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1401
id_morphism_1400:
    b apply_end_1401
apply_end_1401:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1405
    tst x9, #1
    b.eq do_concat_1404
    tst x0, #1
    b.ne do_compose_1402
do_apply_1403:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1406
do_compose_1402:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1406
do_concat_1404:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1406
id_morphism_1405:
    b apply_end_1406
apply_end_1406:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1410
    tst x9, #1
    b.eq do_concat_1409
    tst x0, #1
    b.ne do_compose_1407
do_apply_1408:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1411
do_compose_1407:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1411
do_concat_1409:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1411
id_morphism_1410:
    b apply_end_1411
apply_end_1411:
    str x0, [sp, #-16]!
    b after_func_1412_1413
func_1412:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1414
    b or_end_1415
or_right_1414:
    adr x0, is_digit
or_end_1415:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1419
    tst x9, #1
    b.eq do_concat_1418
    tst x0, #1
    b.ne do_compose_1416
do_apply_1417:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1420
do_compose_1416:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1420
do_concat_1418:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1420
id_morphism_1419:
    b apply_end_1420
apply_end_1420:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1424
    tst x9, #1
    b.eq do_concat_1423
    tst x0, #1
    b.ne do_compose_1421
do_apply_1422:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1425
do_compose_1421:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1425
do_concat_1423:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1425
id_morphism_1424:
    b apply_end_1425
apply_end_1425:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1412_1413:
    // Closure for func_1412
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1412
    ldr x0, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1429
    tst x9, #1
    b.eq do_concat_1428
    tst x0, #1
    b.ne do_compose_1426
do_apply_1427:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1430
do_compose_1426:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1430
do_concat_1428:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1430
id_morphism_1429:
    b apply_end_1430
apply_end_1430:
blk_end_1396:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1394_1395:
    // Closure for func_1394
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
    adr x1, func_1394
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1392_1393:
    // Closure for func_1392
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1392
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1390_1391:
    // Closure for func_1390
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1390
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1384
cond_false_1383:
    adr x0, sign_id
cond_end_1384:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1436
    tst x9, #1
    b.eq do_concat_1435
    tst x0, #1
    b.ne do_compose_1433
do_apply_1434:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1437
do_compose_1433:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1437
do_concat_1435:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1437
id_morphism_1436:
    b apply_end_1437
apply_end_1437:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1431
    b after_func_1438_1439
func_1438:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1440_1441
func_1440:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1442_1443
func_1442:
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
    adr x0, _scan_while
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1447
    tst x9, #1
    b.eq do_concat_1446
    tst x0, #1
    b.ne do_compose_1444
do_apply_1445:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1448
do_compose_1444:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1448
do_concat_1446:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1448
id_morphism_1447:
    b apply_end_1448
apply_end_1448:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1452
    tst x9, #1
    b.eq do_concat_1451
    tst x0, #1
    b.ne do_compose_1449
do_apply_1450:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1453
do_compose_1449:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1453
do_concat_1451:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1453
id_morphism_1452:
    b apply_end_1453
apply_end_1453:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1457
    tst x9, #1
    b.eq do_concat_1456
    tst x0, #1
    b.ne do_compose_1454
do_apply_1455:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1458
do_compose_1454:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1458
do_concat_1456:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1458
id_morphism_1457:
    b apply_end_1458
apply_end_1458:
    str x0, [sp, #-16]!
    adr x0, is_op_char
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1462
    tst x9, #1
    b.eq do_concat_1461
    tst x0, #1
    b.ne do_compose_1459
do_apply_1460:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1463
do_compose_1459:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1463
do_concat_1461:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1463
id_morphism_1462:
    b apply_end_1463
apply_end_1463:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1442_1443:
    // Closure for func_1442
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
    adr x1, func_1442
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1440_1441:
    // Closure for func_1440
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1440
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1438_1439:
    // Closure for func_1438
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1438
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
    adr x0, _scan_while
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1469
    tst x9, #1
    b.eq do_concat_1468
    tst x0, #1
    b.ne do_compose_1466
do_apply_1467:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1470
do_compose_1466:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1470
do_concat_1468:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1470
id_morphism_1469:
    b apply_end_1470
apply_end_1470:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1464
    b after_func_1471_1472
func_1471:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    b after_func_1475_1476
func_1475:
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
    b after_func_1477_1478
func_1477:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1480_1481
func_1480:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1480_1481:
    // Closure for func_1480
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1480
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1483_1484
func_1483:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1483_1484:
    // Closure for func_1483
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1483
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1486_1487
func_1486:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1486_1487:
    // Closure for func_1486
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1486
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1491
    tst x9, #1
    b.eq do_concat_1490
    tst x0, #1
    b.ne do_compose_1488
do_apply_1489:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1492
do_compose_1488:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1492
do_concat_1490:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1492
id_morphism_1491:
    b apply_end_1492
apply_end_1492:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1496
    tst x9, #1
    b.eq do_concat_1495
    tst x0, #1
    b.ne do_compose_1493
do_apply_1494:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1497
do_compose_1493:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1497
do_concat_1495:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1497
id_morphism_1496:
    b apply_end_1497
apply_end_1497:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1501
    tst x9, #1
    b.eq do_concat_1500
    tst x0, #1
    b.ne do_compose_1498
do_apply_1499:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1502
do_compose_1498:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1502
do_concat_1500:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1502
id_morphism_1501:
    b apply_end_1502
apply_end_1502:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1506
    tst x9, #1
    b.eq do_concat_1505
    tst x0, #1
    b.ne do_compose_1503
do_apply_1504:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1507
do_compose_1503:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1507
do_concat_1505:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1507
id_morphism_1506:
    b apply_end_1507
apply_end_1507:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1511
    tst x9, #1
    b.eq do_concat_1510
    tst x0, #1
    b.ne do_compose_1508
do_apply_1509:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1512
do_compose_1508:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1512
do_concat_1510:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1512
id_morphism_1511:
    b apply_end_1512
apply_end_1512:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1516
    tst x9, #1
    b.eq do_concat_1515
    tst x0, #1
    b.ne do_compose_1513
do_apply_1514:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1517
do_compose_1513:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1517
do_concat_1515:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1517
id_morphism_1516:
    b apply_end_1517
apply_end_1517:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1521
    tst x9, #1
    b.eq do_concat_1520
    tst x0, #1
    b.ne do_compose_1518
do_apply_1519:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1522
do_compose_1518:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1522
do_concat_1520:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1522
id_morphism_1521:
    b apply_end_1522
apply_end_1522:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1526
    tst x9, #1
    b.eq do_concat_1525
    tst x0, #1
    b.ne do_compose_1523
do_apply_1524:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1527
do_compose_1523:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1527
do_concat_1525:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1527
id_morphism_1526:
    b apply_end_1527
apply_end_1527:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1485
    adr x0, reverse
    str x0, [sp, #-16]!
    adr x0, chars_rev
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1531
    tst x9, #1
    b.eq do_concat_1530
    tst x0, #1
    b.ne do_compose_1528
do_apply_1529:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1532
do_compose_1528:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1532
do_concat_1530:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1532
id_morphism_1531:
    b apply_end_1532
apply_end_1532:
blk_end_1485:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1536
    tst x9, #1
    b.eq do_concat_1535
    tst x0, #1
    b.ne do_compose_1533
do_apply_1534:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1537
do_compose_1533:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1537
do_concat_1535:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1537
id_morphism_1536:
    b apply_end_1537
apply_end_1537:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1482
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1541
    tst x9, #1
    b.eq do_concat_1540
    tst x0, #1
    b.ne do_compose_1538
do_apply_1539:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1542
do_compose_1538:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1542
do_concat_1540:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1542
id_morphism_1541:
    b apply_end_1542
apply_end_1542:
blk_end_1482:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1546
    tst x9, #1
    b.eq do_concat_1545
    tst x0, #1
    b.ne do_compose_1543
do_apply_1544:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1547
do_compose_1543:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1547
do_concat_1545:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1547
id_morphism_1546:
    b apply_end_1547
apply_end_1547:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1479
    adr x0, _scan_while_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1551
    tst x9, #1
    b.eq do_concat_1550
    tst x0, #1
    b.ne do_compose_1548
do_apply_1549:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1552
do_compose_1548:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1552
do_concat_1550:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1552
id_morphism_1551:
    b apply_end_1552
apply_end_1552:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1556
    tst x9, #1
    b.eq do_concat_1555
    tst x0, #1
    b.ne do_compose_1553
do_apply_1554:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1557
do_compose_1553:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1557
do_concat_1555:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1557
id_morphism_1556:
    b apply_end_1557
apply_end_1557:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1561
    tst x9, #1
    b.eq do_concat_1560
    tst x0, #1
    b.ne do_compose_1558
do_apply_1559:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1562
do_compose_1558:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1562
do_concat_1560:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1562
id_morphism_1561:
    b apply_end_1562
apply_end_1562:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1566
    tst x9, #1
    b.eq do_concat_1565
    tst x0, #1
    b.ne do_compose_1563
do_apply_1564:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1567
do_compose_1563:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1567
do_concat_1565:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1567
id_morphism_1566:
    b apply_end_1567
apply_end_1567:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1571
    tst x9, #1
    b.eq do_concat_1570
    tst x0, #1
    b.ne do_compose_1568
do_apply_1569:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1572
do_compose_1568:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1572
do_concat_1570:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1572
id_morphism_1571:
    b apply_end_1572
apply_end_1572:
blk_end_1479:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1477_1478:
    // Closure for func_1477
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x1, func_1477
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1475_1476:
    // Closure for func_1475
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
    adr x1, func_1475
    ldr x0, [sp], #16
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1471_1472:
    // Closure for func_1471
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1471
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1465
cond_false_1464:
    adr x0, sign_id
cond_end_1465:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_while_rec
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1578
    tst x9, #1
    b.eq do_concat_1577
    tst x0, #1
    b.ne do_compose_1575
do_apply_1576:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1579
do_compose_1575:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1579
do_concat_1577:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1579
id_morphism_1578:
    b apply_end_1579
apply_end_1579:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1573
    b after_func_1580_1581
func_1580:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1582_1583
func_1582:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1584_1585
func_1584:
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
    b after_func_1586_1587
func_1586:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1588_1589
func_1588:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1593
    adr x0, sign_id
    b cmp_end_1594
cmp_true_1593:
cmp_end_1594:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1591
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1598
    tst x9, #1
    b.eq do_concat_1597
    tst x0, #1
    b.ne do_compose_1595
do_apply_1596:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1599
do_compose_1595:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1599
do_concat_1597:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1599
id_morphism_1598:
    b apply_end_1599
apply_end_1599:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1603
    tst x9, #1
    b.eq do_concat_1602
    tst x0, #1
    b.ne do_compose_1600
do_apply_1601:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1604
do_compose_1600:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1604
do_concat_1602:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1604
id_morphism_1603:
    b apply_end_1604
apply_end_1604:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1608
    tst x9, #1
    b.eq do_concat_1607
    tst x0, #1
    b.ne do_compose_1605
do_apply_1606:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1609
do_compose_1605:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1609
do_concat_1607:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1609
id_morphism_1608:
    b apply_end_1609
apply_end_1609:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1613
    tst x9, #1
    b.eq do_concat_1612
    tst x0, #1
    b.ne do_compose_1610
do_apply_1611:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1614
do_compose_1610:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1614
do_concat_1612:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1614
id_morphism_1613:
    b apply_end_1614
apply_end_1614:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1618
    tst x9, #1
    b.eq do_concat_1617
    tst x0, #1
    b.ne do_compose_1615
do_apply_1616:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1619
do_compose_1615:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1619
do_concat_1617:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1619
id_morphism_1618:
    b apply_end_1619
apply_end_1619:
    b cond_end_1592
cond_false_1591:
    adr x0, sign_id
cond_end_1592:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1590
    b after_func_1620_1621
func_1620:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1620_1621:
    // Closure for func_1620
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1620
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, c
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1628
    tst x9, #1
    b.eq do_concat_1627
    tst x0, #1
    b.ne do_compose_1625
do_apply_1626:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1629
do_compose_1625:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1629
do_concat_1627:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1629
id_morphism_1628:
    b apply_end_1629
apply_end_1629:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1623
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, _scan_while_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1633
    tst x9, #1
    b.eq do_concat_1632
    tst x0, #1
    b.ne do_compose_1630
do_apply_1631:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1634
do_compose_1630:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1634
do_concat_1632:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1634
id_morphism_1633:
    b apply_end_1634
apply_end_1634:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1638
    tst x9, #1
    b.eq do_concat_1637
    tst x0, #1
    b.ne do_compose_1635
do_apply_1636:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1639
do_compose_1635:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1639
do_concat_1637:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1639
id_morphism_1638:
    b apply_end_1639
apply_end_1639:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1643
    tst x9, #1
    b.eq do_concat_1642
    tst x0, #1
    b.ne do_compose_1640
do_apply_1641:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1644
do_compose_1640:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1644
do_concat_1642:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1644
id_morphism_1643:
    b apply_end_1644
apply_end_1644:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1648
    tst x9, #1
    b.eq do_concat_1647
    tst x0, #1
    b.ne do_compose_1645
do_apply_1646:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1649
do_compose_1645:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1649
do_concat_1647:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1649
id_morphism_1648:
    b apply_end_1649
apply_end_1649:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1653
    tst x9, #1
    b.eq do_concat_1652
    tst x0, #1
    b.ne do_compose_1650
do_apply_1651:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1654
do_compose_1650:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1654
do_concat_1652:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1654
id_morphism_1653:
    b apply_end_1654
apply_end_1654:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1658
    tst x9, #1
    b.eq do_concat_1657
    tst x0, #1
    b.ne do_compose_1655
do_apply_1656:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1659
do_compose_1655:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1659
do_concat_1657:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1659
id_morphism_1658:
    b apply_end_1659
apply_end_1659:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1663
    tst x9, #1
    b.eq do_concat_1662
    tst x0, #1
    b.ne do_compose_1660
do_apply_1661:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1664
do_compose_1660:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1664
do_concat_1662:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1664
id_morphism_1663:
    b apply_end_1664
apply_end_1664:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1668
    tst x9, #1
    b.eq do_concat_1667
    tst x0, #1
    b.ne do_compose_1665
do_apply_1666:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1669
do_compose_1665:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1669
do_concat_1667:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1669
id_morphism_1668:
    b apply_end_1669
apply_end_1669:
    b cond_end_1624
cond_false_1623:
    adr x0, sign_id
cond_end_1624:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1622
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1673
    tst x9, #1
    b.eq do_concat_1672
    tst x0, #1
    b.ne do_compose_1670
do_apply_1671:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1674
do_compose_1670:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1674
do_concat_1672:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1674
id_morphism_1673:
    b apply_end_1674
apply_end_1674:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1678
    tst x9, #1
    b.eq do_concat_1677
    tst x0, #1
    b.ne do_compose_1675
do_apply_1676:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1679
do_compose_1675:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1679
do_concat_1677:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1679
id_morphism_1678:
    b apply_end_1679
apply_end_1679:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1683
    tst x9, #1
    b.eq do_concat_1682
    tst x0, #1
    b.ne do_compose_1680
do_apply_1681:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1684
do_compose_1680:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1684
do_concat_1682:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1684
id_morphism_1683:
    b apply_end_1684
apply_end_1684:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1688
    tst x9, #1
    b.eq do_concat_1687
    tst x0, #1
    b.ne do_compose_1685
do_apply_1686:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1689
do_compose_1685:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1689
do_concat_1687:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1689
id_morphism_1688:
    b apply_end_1689
apply_end_1689:
blk_end_1622:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1693
    tst x9, #1
    b.eq do_concat_1692
    tst x0, #1
    b.ne do_compose_1690
do_apply_1691:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1694
do_compose_1690:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1694
do_concat_1692:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1694
id_morphism_1693:
    b apply_end_1694
apply_end_1694:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1590
    adr x0, nth
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1698
    tst x9, #1
    b.eq do_concat_1697
    tst x0, #1
    b.ne do_compose_1695
do_apply_1696:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1699
do_compose_1695:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1699
do_concat_1697:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1699
id_morphism_1698:
    b apply_end_1699
apply_end_1699:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1703
    tst x9, #1
    b.eq do_concat_1702
    tst x0, #1
    b.ne do_compose_1700
do_apply_1701:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1704
do_compose_1700:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1704
do_concat_1702:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1704
id_morphism_1703:
    b apply_end_1704
apply_end_1704:
blk_end_1590:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1588_1589:
    // Closure for func_1588
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x1, func_1588
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1586_1587:
    // Closure for func_1586
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1586
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1584_1585:
    // Closure for func_1584
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1584
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1582_1583:
    // Closure for func_1582
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1582
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1580_1581:
    // Closure for func_1580
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1580
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1574
cond_false_1573:
    adr x0, sign_id
cond_end_1574:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1710
    tst x9, #1
    b.eq do_concat_1709
    tst x0, #1
    b.ne do_compose_1707
do_apply_1708:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1711
do_compose_1707:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1711
do_concat_1709:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1711
id_morphism_1710:
    b apply_end_1711
apply_end_1711:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1705
    b after_func_1712_1713
func_1712:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1714_1715
func_1714:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1716_1717
func_1716:
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
    adr x0, str_2
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1718
    b after_func_1719_1720
func_1719:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1719_1720:
    // Closure for func_1719
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1719
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1722_1723
func_1722:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1722_1723:
    // Closure for func_1722
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1722
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1725_1726
func_1725:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1725_1726:
    // Closure for func_1725
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1725
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1728_1729
func_1728:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1728_1729:
    // Closure for func_1728
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1728
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1733
    tst x9, #1
    b.eq do_concat_1732
    tst x0, #1
    b.ne do_compose_1730
do_apply_1731:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1734
do_compose_1730:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1734
do_concat_1732:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1734
id_morphism_1733:
    b apply_end_1734
apply_end_1734:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1738
    tst x9, #1
    b.eq do_concat_1737
    tst x0, #1
    b.ne do_compose_1735
do_apply_1736:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1739
do_compose_1735:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1739
do_concat_1737:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1739
id_morphism_1738:
    b apply_end_1739
apply_end_1739:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1743
    tst x9, #1
    b.eq do_concat_1742
    tst x0, #1
    b.ne do_compose_1740
do_apply_1741:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1744
do_compose_1740:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1744
do_concat_1742:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1744
id_morphism_1743:
    b apply_end_1744
apply_end_1744:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1748
    tst x9, #1
    b.eq do_concat_1747
    tst x0, #1
    b.ne do_compose_1745
do_apply_1746:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1749
do_compose_1745:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1749
do_concat_1747:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1749
id_morphism_1748:
    b apply_end_1749
apply_end_1749:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1753
    tst x9, #1
    b.eq do_concat_1752
    tst x0, #1
    b.ne do_compose_1750
do_apply_1751:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1754
do_compose_1750:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1754
do_concat_1752:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1754
id_morphism_1753:
    b apply_end_1754
apply_end_1754:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1758
    tst x9, #1
    b.eq do_concat_1757
    tst x0, #1
    b.ne do_compose_1755
do_apply_1756:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1759
do_compose_1755:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1759
do_concat_1757:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1759
id_morphism_1758:
    b apply_end_1759
apply_end_1759:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1763
    tst x9, #1
    b.eq do_concat_1762
    tst x0, #1
    b.ne do_compose_1760
do_apply_1761:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1764
do_compose_1760:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1764
do_concat_1762:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1764
id_morphism_1763:
    b apply_end_1764
apply_end_1764:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1768
    tst x9, #1
    b.eq do_concat_1767
    tst x0, #1
    b.ne do_compose_1765
do_apply_1766:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1769
do_compose_1765:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1769
do_concat_1767:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1769
id_morphism_1768:
    b apply_end_1769
apply_end_1769:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1727
    adr x0, reverse
    str x0, [sp, #-16]!
    adr x0, chars_rev
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1773
    tst x9, #1
    b.eq do_concat_1772
    tst x0, #1
    b.ne do_compose_1770
do_apply_1771:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1774
do_compose_1770:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1774
do_concat_1772:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1774
id_morphism_1773:
    b apply_end_1774
apply_end_1774:
blk_end_1727:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1778
    tst x9, #1
    b.eq do_concat_1777
    tst x0, #1
    b.ne do_compose_1775
do_apply_1776:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1779
do_compose_1775:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1779
do_concat_1777:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1779
id_morphism_1778:
    b apply_end_1779
apply_end_1779:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1724
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1783
    tst x9, #1
    b.eq do_concat_1782
    tst x0, #1
    b.ne do_compose_1780
do_apply_1781:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1784
do_compose_1780:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1784
do_concat_1782:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1784
id_morphism_1783:
    b apply_end_1784
apply_end_1784:
blk_end_1724:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1788
    tst x9, #1
    b.eq do_concat_1787
    tst x0, #1
    b.ne do_compose_1785
do_apply_1786:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1789
do_compose_1785:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1789
do_concat_1787:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1789
id_morphism_1788:
    b apply_end_1789
apply_end_1789:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1721
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1793
    tst x9, #1
    b.eq do_concat_1792
    tst x0, #1
    b.ne do_compose_1790
do_apply_1791:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1794
do_compose_1790:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1794
do_concat_1792:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1794
id_morphism_1793:
    b apply_end_1794
apply_end_1794:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1798
    tst x9, #1
    b.eq do_concat_1797
    tst x0, #1
    b.ne do_compose_1795
do_apply_1796:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1799
do_compose_1795:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1799
do_concat_1797:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1799
id_morphism_1798:
    b apply_end_1799
apply_end_1799:
    str x0, [sp, #-16]!
    adr x0, start_pos
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1803
    tst x9, #1
    b.eq do_concat_1802
    tst x0, #1
    b.ne do_compose_1800
do_apply_1801:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1804
do_compose_1800:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1804
do_concat_1802:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1804
id_morphism_1803:
    b apply_end_1804
apply_end_1804:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1808
    tst x9, #1
    b.eq do_concat_1807
    tst x0, #1
    b.ne do_compose_1805
do_apply_1806:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1809
do_compose_1805:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1809
do_concat_1807:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1809
id_morphism_1808:
    b apply_end_1809
apply_end_1809:
blk_end_1721:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1813
    tst x9, #1
    b.eq do_concat_1812
    tst x0, #1
    b.ne do_compose_1810
do_apply_1811:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1814
do_compose_1810:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1814
do_concat_1812:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1814
id_morphism_1813:
    b apply_end_1814
apply_end_1814:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1718
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
blk_end_1718:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1716_1717:
    // Closure for func_1716
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
    adr x1, func_1716
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1714_1715:
    // Closure for func_1714
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1714
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1712_1713:
    // Closure for func_1712
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1712
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1706
cond_false_1705:
    adr x0, sign_id
cond_end_1706:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1820
    tst x9, #1
    b.eq do_concat_1819
    tst x0, #1
    b.ne do_compose_1817
do_apply_1818:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1821
do_compose_1817:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1821
do_concat_1819:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1821
id_morphism_1820:
    b apply_end_1821
apply_end_1821:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1815
    b after_func_1822_1823
func_1822:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1824_1825
func_1824:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1826_1827
func_1826:
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
    b after_func_1828_1829
func_1828:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1833
    adr x0, sign_id
    b cmp_end_1834
cmp_true_1833:
cmp_end_1834:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1831
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1838
    tst x9, #1
    b.eq do_concat_1837
    tst x0, #1
    b.ne do_compose_1835
do_apply_1836:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1839
do_compose_1835:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1839
do_concat_1837:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1839
id_morphism_1838:
    b apply_end_1839
apply_end_1839:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1843
    tst x9, #1
    b.eq do_concat_1842
    tst x0, #1
    b.ne do_compose_1840
do_apply_1841:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1844
do_compose_1840:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1844
do_concat_1842:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1844
id_morphism_1843:
    b apply_end_1844
apply_end_1844:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1848
    tst x9, #1
    b.eq do_concat_1847
    tst x0, #1
    b.ne do_compose_1845
do_apply_1846:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1849
do_compose_1845:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1849
do_concat_1847:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1849
id_morphism_1848:
    b apply_end_1849
apply_end_1849:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1853
    tst x9, #1
    b.eq do_concat_1852
    tst x0, #1
    b.ne do_compose_1850
do_apply_1851:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1854
do_compose_1850:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1854
do_concat_1852:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1854
id_morphism_1853:
    b apply_end_1854
apply_end_1854:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1858
    tst x9, #1
    b.eq do_concat_1857
    tst x0, #1
    b.ne do_compose_1855
do_apply_1856:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1859
do_compose_1855:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1859
do_concat_1857:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1859
id_morphism_1858:
    b apply_end_1859
apply_end_1859:
    b cond_end_1832
cond_false_1831:
    adr x0, sign_id
cond_end_1832:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1830
    b after_func_1860_1861
func_1860:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1860_1861:
    // Closure for func_1860
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1860
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1867
    adr x0, sign_id
    b cmp_end_1868
cmp_true_1867:
cmp_end_1868:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1865
    b or_end_1866
or_right_1865:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1869
    adr x0, sign_id
    b cmp_end_1870
cmp_true_1869:
cmp_end_1870:
or_end_1866:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1863
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1871
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1875
    tst x9, #1
    b.eq do_concat_1874
    tst x0, #1
    b.ne do_compose_1872
do_apply_1873:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1876
do_compose_1872:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1876
do_concat_1874:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1876
id_morphism_1875:
    b apply_end_1876
apply_end_1876:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1880
    tst x9, #1
    b.eq do_concat_1879
    tst x0, #1
    b.ne do_compose_1877
do_apply_1878:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1881
do_compose_1877:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1881
do_concat_1879:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1881
id_morphism_1880:
    b apply_end_1881
apply_end_1881:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1885
    tst x9, #1
    b.eq do_concat_1884
    tst x0, #1
    b.ne do_compose_1882
do_apply_1883:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1886
do_compose_1882:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1886
do_concat_1884:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1886
id_morphism_1885:
    b apply_end_1886
apply_end_1886:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1890
    tst x9, #1
    b.eq do_concat_1889
    tst x0, #1
    b.ne do_compose_1887
do_apply_1888:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1891
do_compose_1887:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1891
do_concat_1889:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1891
id_morphism_1890:
    b apply_end_1891
apply_end_1891:
blk_end_1871:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1895
    tst x9, #1
    b.eq do_concat_1894
    tst x0, #1
    b.ne do_compose_1892
do_apply_1893:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1896
do_compose_1892:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1896
do_concat_1894:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1896
id_morphism_1895:
    b apply_end_1896
apply_end_1896:
    b cond_end_1864
cond_false_1863:
    adr x0, sign_id
cond_end_1864:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1862
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1900
    tst x9, #1
    b.eq do_concat_1899
    tst x0, #1
    b.ne do_compose_1897
do_apply_1898:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1901
do_compose_1897:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1901
do_concat_1899:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1901
id_morphism_1900:
    b apply_end_1901
apply_end_1901:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1905
    tst x9, #1
    b.eq do_concat_1904
    tst x0, #1
    b.ne do_compose_1902
do_apply_1903:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1906
do_compose_1902:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1906
do_concat_1904:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1906
id_morphism_1905:
    b apply_end_1906
apply_end_1906:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1910
    tst x9, #1
    b.eq do_concat_1909
    tst x0, #1
    b.ne do_compose_1907
do_apply_1908:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1911
do_compose_1907:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1911
do_concat_1909:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1911
id_morphism_1910:
    b apply_end_1911
apply_end_1911:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1915
    tst x9, #1
    b.eq do_concat_1914
    tst x0, #1
    b.ne do_compose_1912
do_apply_1913:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1916
do_compose_1912:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1916
do_concat_1914:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1916
id_morphism_1915:
    b apply_end_1916
apply_end_1916:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1920
    tst x9, #1
    b.eq do_concat_1919
    tst x0, #1
    b.ne do_compose_1917
do_apply_1918:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1921
do_compose_1917:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1921
do_concat_1919:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1921
id_morphism_1920:
    b apply_end_1921
apply_end_1921:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1925
    tst x9, #1
    b.eq do_concat_1924
    tst x0, #1
    b.ne do_compose_1922
do_apply_1923:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1926
do_compose_1922:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1926
do_concat_1924:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1926
id_morphism_1925:
    b apply_end_1926
apply_end_1926:
blk_end_1862:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1930
    tst x9, #1
    b.eq do_concat_1929
    tst x0, #1
    b.ne do_compose_1927
do_apply_1928:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1931
do_compose_1927:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1931
do_concat_1929:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1931
id_morphism_1930:
    b apply_end_1931
apply_end_1931:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1830
    adr x0, nth
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1935
    tst x9, #1
    b.eq do_concat_1934
    tst x0, #1
    b.ne do_compose_1932
do_apply_1933:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1936
do_compose_1932:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1936
do_concat_1934:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1936
id_morphism_1935:
    b apply_end_1936
apply_end_1936:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1940
    tst x9, #1
    b.eq do_concat_1939
    tst x0, #1
    b.ne do_compose_1937
do_apply_1938:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1941
do_compose_1937:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1941
do_concat_1939:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1941
id_morphism_1940:
    b apply_end_1941
apply_end_1941:
blk_end_1830:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1828_1829:
    // Closure for func_1828
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1828
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1826_1827:
    // Closure for func_1826
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1826
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1824_1825:
    // Closure for func_1824
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1824
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1822_1823:
    // Closure for func_1822
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1822
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1816
cond_false_1815:
    adr x0, sign_id
cond_end_1816:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _parse_int
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1947
    tst x9, #1
    b.eq do_concat_1946
    tst x0, #1
    b.ne do_compose_1944
do_apply_1945:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1948
do_compose_1944:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1948
do_concat_1946:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1948
id_morphism_1947:
    b apply_end_1948
apply_end_1948:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1942
    b after_func_1949_1950
func_1949:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1949_1950:
    // Closure for func_1949
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1949
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1943
cond_false_1942:
    adr x0, sign_id
cond_end_1943:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Pure
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1954
    tst x9, #1
    b.eq do_concat_1953
    tst x0, #1
    b.ne do_compose_1951
do_apply_1952:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1955
do_compose_1951:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1955
do_concat_1953:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1955
id_morphism_1954:
    b apply_end_1955
apply_end_1955:
    str x0, [sp, #-16]!
    adr x0, Functional
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1959
    tst x9, #1
    b.eq do_concat_1958
    tst x0, #1
    b.ne do_compose_1956
do_apply_1957:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1960
do_compose_1956:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1960
do_concat_1958:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1960
id_morphism_1959:
    b apply_end_1960
apply_end_1960:
    str x0, [sp, #-16]!
    adr x0, Parser
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1964
    tst x9, #1
    b.eq do_concat_1963
    tst x0, #1
    b.ne do_compose_1961
do_apply_1962:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1965
do_compose_1961:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1965
do_concat_1963:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1965
id_morphism_1964:
    b apply_end_1965
apply_end_1965:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, Philosophy
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, No
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, global
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1971
    tst x9, #1
    b.eq do_concat_1970
    tst x0, #1
    b.ne do_compose_1968
do_apply_1969:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1972
do_compose_1968:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1972
do_concat_1970:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1972
id_morphism_1971:
    b apply_end_1972
apply_end_1972:
    str x0, [sp, #-16]!
    adr x0, state
    str x0, [sp, #-16]!
    adr x0, No
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1976
    tst x9, #1
    b.eq do_concat_1975
    tst x0, #1
    b.ne do_compose_1973
do_apply_1974:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1977
do_compose_1973:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1977
do_concat_1975:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1977
id_morphism_1976:
    b apply_end_1977
apply_end_1977:
    str x0, [sp, #-16]!
    adr x0, local
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1981
    tst x9, #1
    b.eq do_concat_1980
    tst x0, #1
    b.ne do_compose_1978
do_apply_1979:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1982
do_compose_1978:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1982
do_concat_1980:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1982
id_morphism_1981:
    b apply_end_1982
apply_end_1982:
    str x0, [sp, #-16]!
    adr x0, bindings
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1986
    tst x9, #1
    b.eq do_concat_1985
    tst x0, #1
    b.ne do_compose_1983
do_apply_1984:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1987
do_compose_1983:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1987
do_concat_1985:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1987
id_morphism_1986:
    b apply_end_1987
apply_end_1987:
    str x0, [sp, #-16]!
    adr x0, 
    str x0, [sp, #-16]!
    adr x0, Logic
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1991
    tst x9, #1
    b.eq do_concat_1990
    tst x0, #1
    b.ne do_compose_1988
do_apply_1989:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1992
do_compose_1988:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1992
do_concat_1990:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1992
id_morphism_1991:
    b apply_end_1992
apply_end_1992:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1966
    adr x0, tokens
    b cond_end_1967
cond_false_1966:
    adr x0, sign_id
cond_end_1967:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, -
    str x0, [sp, #-16]!
    adr x0, >
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1996
    tst x9, #1
    b.eq do_concat_1995
    tst x0, #1
    b.ne do_compose_1993
do_apply_1994:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1997
do_compose_1993:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1997
do_concat_1995:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1997
id_morphism_1996:
    b apply_end_1997
apply_end_1997:
    str x0, [sp, #-16]!
    adr x0, ast_node
    str x0, [sp, #-16]!
    adr x0, remaining_tokens
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2001
    tst x9, #1
    b.eq do_concat_2000
    tst x0, #1
    b.ne do_compose_1998
do_apply_1999:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2002
do_compose_1998:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2002
do_concat_2000:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2002
id_morphism_2001:
    b apply_end_2002
apply_end_2002:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x1, ast_unit
    str x0, [x1]
    adr x0, sign_id
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
    mov x0, #9
    adr x1, ast_prefix
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #10
    adr x1, ast_postfix
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #11
    adr x1, ast_lambda
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #12
    adr x1, ast_char
    str x0, [x1]
    adr x0, sign_id
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
    mov x0, #0
    adr x1, tok_unit
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tok_type
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2008
    tst x9, #1
    b.eq do_concat_2007
    tst x0, #1
    b.ne do_compose_2005
do_apply_2006:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2009
do_compose_2005:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2009
do_concat_2007:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2009
id_morphism_2008:
    b apply_end_2009
apply_end_2009:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2003
    b after_func_2010_2011
func_2010:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2010_2011:
    // Closure for func_2010
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2010
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2004
cond_false_2003:
    adr x0, sign_id
cond_end_2004:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tok_val
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2017
    tst x9, #1
    b.eq do_concat_2016
    tst x0, #1
    b.ne do_compose_2014
do_apply_2015:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2018
do_compose_2014:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2018
do_concat_2016:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2018
id_morphism_2017:
    b apply_end_2018
apply_end_2018:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2012
    b after_func_2019_2020
func_2019:
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
after_func_2019_2020:
    // Closure for func_2019
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2019
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2013
cond_false_2012:
    adr x0, sign_id
cond_end_2013:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, streq
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2026
    tst x9, #1
    b.eq do_concat_2025
    tst x0, #1
    b.ne do_compose_2023
do_apply_2024:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2027
do_compose_2023:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2027
do_concat_2025:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2027
id_morphism_2026:
    b apply_end_2027
apply_end_2027:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2021
    b after_func_2028_2029
func_2028:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2030_2031
func_2030:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2033_2034
func_2033:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2033_2034:
    // Closure for func_2033
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2033
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2036_2037
func_2036:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2036_2037:
    // Closure for func_2036
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2036
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c1
    str x0, [sp, #-16]!
    adr x0, c2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_2041
    adr x0, sign_id
    b cmp_end_2042
cmp_true_2041:
cmp_end_2042:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2039
    mov x0, #0
    b cond_end_2040
cond_false_2039:
    adr x0, sign_id
cond_end_2040:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2038
    adr x0, c1
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2045
    adr x0, sign_id
    b cmp_end_2046
cmp_true_2045:
cmp_end_2046:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2043
    mov x0, #1
    b cond_end_2044
cond_false_2043:
    adr x0, sign_id
cond_end_2044:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2038
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2050
    tst x9, #1
    b.eq do_concat_2049
    tst x0, #1
    b.ne do_compose_2047
do_apply_2048:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2051
do_compose_2047:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2051
do_concat_2049:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2051
id_morphism_2050:
    b apply_end_2051
apply_end_2051:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2055
    tst x9, #1
    b.eq do_concat_2054
    tst x0, #1
    b.ne do_compose_2052
do_apply_2053:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2056
do_compose_2052:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2056
do_concat_2054:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2056
id_morphism_2055:
    b apply_end_2056
apply_end_2056:
blk_end_2038:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2060
    tst x9, #1
    b.eq do_concat_2059
    tst x0, #1
    b.ne do_compose_2057
do_apply_2058:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2061
do_compose_2057:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2061
do_concat_2059:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2061
id_morphism_2060:
    b apply_end_2061
apply_end_2061:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2035
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_2035:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2065
    tst x9, #1
    b.eq do_concat_2064
    tst x0, #1
    b.ne do_compose_2062
do_apply_2063:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2066
do_compose_2062:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2066
do_concat_2064:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2066
id_morphism_2065:
    b apply_end_2066
apply_end_2066:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2032
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
blk_end_2032:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2030_2031:
    // Closure for func_2030
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2030
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2028_2029:
    // Closure for func_2028
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2028
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2022
cond_false_2021:
    adr x0, sign_id
cond_end_2022:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_prec
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2072
    tst x9, #1
    b.eq do_concat_2071
    tst x0, #1
    b.ne do_compose_2069
do_apply_2070:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2073
do_compose_2069:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2073
do_concat_2071:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2073
id_morphism_2072:
    b apply_end_2073
apply_end_2073:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2067
    b after_func_2074_2075
func_2074:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2082
    tst x9, #1
    b.eq do_concat_2081
    tst x0, #1
    b.ne do_compose_2079
do_apply_2080:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2083
do_compose_2079:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2083
do_concat_2081:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2083
id_morphism_2082:
    b apply_end_2083
apply_end_2083:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2087
    tst x9, #1
    b.eq do_concat_2086
    tst x0, #1
    b.ne do_compose_2084
do_apply_2085:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2088
do_compose_2084:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2088
do_concat_2086:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2088
id_morphism_2087:
    b apply_end_2088
apply_end_2088:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2077
    mov x0, #15
    b cond_end_2078
cond_false_2077:
    adr x0, sign_id
cond_end_2078:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2094
    tst x9, #1
    b.eq do_concat_2093
    tst x0, #1
    b.ne do_compose_2091
do_apply_2092:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2095
do_compose_2091:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2095
do_concat_2093:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2095
id_morphism_2094:
    b apply_end_2095
apply_end_2095:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2099
    tst x9, #1
    b.eq do_concat_2098
    tst x0, #1
    b.ne do_compose_2096
do_apply_2097:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2100
do_compose_2096:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2100
do_concat_2098:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2100
id_morphism_2099:
    b apply_end_2100
apply_end_2100:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2089
    mov x0, #15
    b cond_end_2090
cond_false_2089:
    adr x0, sign_id
cond_end_2090:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2106
    tst x9, #1
    b.eq do_concat_2105
    tst x0, #1
    b.ne do_compose_2103
do_apply_2104:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2107
do_compose_2103:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2107
do_concat_2105:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2107
id_morphism_2106:
    b apply_end_2107
apply_end_2107:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2111
    tst x9, #1
    b.eq do_concat_2110
    tst x0, #1
    b.ne do_compose_2108
do_apply_2109:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2112
do_compose_2108:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2112
do_concat_2110:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2112
id_morphism_2111:
    b apply_end_2112
apply_end_2112:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2101
    mov x0, #16
    b cond_end_2102
cond_false_2101:
    adr x0, sign_id
cond_end_2102:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2118
    tst x9, #1
    b.eq do_concat_2117
    tst x0, #1
    b.ne do_compose_2115
do_apply_2116:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2119
do_compose_2115:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2119
do_concat_2117:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2119
id_morphism_2118:
    b apply_end_2119
apply_end_2119:
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2123
    tst x9, #1
    b.eq do_concat_2122
    tst x0, #1
    b.ne do_compose_2120
do_apply_2121:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2124
do_compose_2120:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2124
do_concat_2122:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2124
id_morphism_2123:
    b apply_end_2124
apply_end_2124:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2113
    mov x0, #16
    b cond_end_2114
cond_false_2113:
    adr x0, sign_id
cond_end_2114:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2130
    tst x9, #1
    b.eq do_concat_2129
    tst x0, #1
    b.ne do_compose_2127
do_apply_2128:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2131
do_compose_2127:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2131
do_concat_2129:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2131
id_morphism_2130:
    b apply_end_2131
apply_end_2131:
    str x0, [sp, #-16]!
    mov x0, #37
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2135
    tst x9, #1
    b.eq do_concat_2134
    tst x0, #1
    b.ne do_compose_2132
do_apply_2133:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2136
do_compose_2132:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2136
do_concat_2134:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2136
id_morphism_2135:
    b apply_end_2136
apply_end_2136:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2125
    mov x0, #16
    b cond_end_2126
cond_false_2125:
    adr x0, sign_id
cond_end_2126:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2142
    tst x9, #1
    b.eq do_concat_2141
    tst x0, #1
    b.ne do_compose_2139
do_apply_2140:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2143
do_compose_2139:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2143
do_concat_2141:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2143
id_morphism_2142:
    b apply_end_2143
apply_end_2143:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2147
    tst x9, #1
    b.eq do_concat_2146
    tst x0, #1
    b.ne do_compose_2144
do_apply_2145:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2148
do_compose_2144:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2148
do_concat_2146:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2148
id_morphism_2147:
    b apply_end_2148
apply_end_2148:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2137
    mov x0, #2
    b cond_end_2138
cond_false_2137:
    adr x0, sign_id
cond_end_2138:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2154
    tst x9, #1
    b.eq do_concat_2153
    tst x0, #1
    b.ne do_compose_2151
do_apply_2152:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2155
do_compose_2151:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2155
do_concat_2153:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2155
id_morphism_2154:
    b apply_end_2155
apply_end_2155:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2159
    tst x9, #1
    b.eq do_concat_2158
    tst x0, #1
    b.ne do_compose_2156
do_apply_2157:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2160
do_compose_2156:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2160
do_concat_2158:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2160
id_morphism_2159:
    b apply_end_2160
apply_end_2160:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2149
    mov x0, #5
    b cond_end_2150
cond_false_2149:
    adr x0, sign_id
cond_end_2150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2166
    tst x9, #1
    b.eq do_concat_2165
    tst x0, #1
    b.ne do_compose_2163
do_apply_2164:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2167
do_compose_2163:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2167
do_concat_2165:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2167
id_morphism_2166:
    b apply_end_2167
apply_end_2167:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2171
    tst x9, #1
    b.eq do_concat_2170
    tst x0, #1
    b.ne do_compose_2168
do_apply_2169:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2172
do_compose_2168:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2172
do_concat_2170:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2172
id_morphism_2171:
    b apply_end_2172
apply_end_2172:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2161
    mov x0, #6
    b cond_end_2162
cond_false_2161:
    adr x0, sign_id
cond_end_2162:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2178
    tst x9, #1
    b.eq do_concat_2177
    tst x0, #1
    b.ne do_compose_2175
do_apply_2176:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2179
do_compose_2175:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2179
do_concat_2177:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2179
id_morphism_2178:
    b apply_end_2179
apply_end_2179:
    str x0, [sp, #-16]!
    mov x0, #61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2183
    tst x9, #1
    b.eq do_concat_2182
    tst x0, #1
    b.ne do_compose_2180
do_apply_2181:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2184
do_compose_2180:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2184
do_concat_2182:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2184
id_morphism_2183:
    b apply_end_2184
apply_end_2184:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2173
    mov x0, #14
    b cond_end_2174
cond_false_2173:
    adr x0, sign_id
cond_end_2174:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2190
    tst x9, #1
    b.eq do_concat_2189
    tst x0, #1
    b.ne do_compose_2187
do_apply_2188:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2191
do_compose_2187:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2191
do_concat_2189:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2191
id_morphism_2190:
    b apply_end_2191
apply_end_2191:
    str x0, [sp, #-16]!
    adr x0, str_4
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2195
    tst x9, #1
    b.eq do_concat_2194
    tst x0, #1
    b.ne do_compose_2192
do_apply_2193:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2196
do_compose_2192:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2196
do_concat_2194:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2196
id_morphism_2195:
    b apply_end_2196
apply_end_2196:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2185
    mov x0, #14
    b cond_end_2186
cond_false_2185:
    adr x0, sign_id
cond_end_2186:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2202
    tst x9, #1
    b.eq do_concat_2201
    tst x0, #1
    b.ne do_compose_2199
do_apply_2200:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2203
do_compose_2199:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2203
do_concat_2201:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2203
id_morphism_2202:
    b apply_end_2203
apply_end_2203:
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2207
    tst x9, #1
    b.eq do_concat_2206
    tst x0, #1
    b.ne do_compose_2204
do_apply_2205:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2208
do_compose_2204:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2208
do_concat_2206:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2208
id_morphism_2207:
    b apply_end_2208
apply_end_2208:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2197
    mov x0, #14
    b cond_end_2198
cond_false_2197:
    adr x0, sign_id
cond_end_2198:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2214
    tst x9, #1
    b.eq do_concat_2213
    tst x0, #1
    b.ne do_compose_2211
do_apply_2212:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2215
do_compose_2211:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2215
do_concat_2213:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2215
id_morphism_2214:
    b apply_end_2215
apply_end_2215:
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2219
    tst x9, #1
    b.eq do_concat_2218
    tst x0, #1
    b.ne do_compose_2216
do_apply_2217:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2220
do_compose_2216:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2220
do_concat_2218:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2220
id_morphism_2219:
    b apply_end_2220
apply_end_2220:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2209
    mov x0, #14
    b cond_end_2210
cond_false_2209:
    adr x0, sign_id
cond_end_2210:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2226
    tst x9, #1
    b.eq do_concat_2225
    tst x0, #1
    b.ne do_compose_2223
do_apply_2224:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2227
do_compose_2223:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2227
do_concat_2225:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2227
id_morphism_2226:
    b apply_end_2227
apply_end_2227:
    str x0, [sp, #-16]!
    adr x0, str_5
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2231
    tst x9, #1
    b.eq do_concat_2230
    tst x0, #1
    b.ne do_compose_2228
do_apply_2229:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2232
do_compose_2228:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2232
do_concat_2230:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2232
id_morphism_2231:
    b apply_end_2232
apply_end_2232:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2221
    mov x0, #14
    b cond_end_2222
cond_false_2221:
    adr x0, sign_id
cond_end_2222:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2238
    tst x9, #1
    b.eq do_concat_2237
    tst x0, #1
    b.ne do_compose_2235
do_apply_2236:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2239
do_compose_2235:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2239
do_concat_2237:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2239
id_morphism_2238:
    b apply_end_2239
apply_end_2239:
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2243
    tst x9, #1
    b.eq do_concat_2242
    tst x0, #1
    b.ne do_compose_2240
do_apply_2241:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2244
do_compose_2240:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2244
do_concat_2242:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2244
id_morphism_2243:
    b apply_end_2244
apply_end_2244:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2233
    mov x0, #14
    b cond_end_2234
cond_false_2233:
    adr x0, sign_id
cond_end_2234:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2250
    tst x9, #1
    b.eq do_concat_2249
    tst x0, #1
    b.ne do_compose_2247
do_apply_2248:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2251
do_compose_2247:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2251
do_concat_2249:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2251
id_morphism_2250:
    b apply_end_2251
apply_end_2251:
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2255
    tst x9, #1
    b.eq do_concat_2254
    tst x0, #1
    b.ne do_compose_2252
do_apply_2253:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2256
do_compose_2252:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2256
do_concat_2254:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2256
id_morphism_2255:
    b apply_end_2256
apply_end_2256:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2245
    mov x0, #14
    b cond_end_2246
cond_false_2245:
    adr x0, sign_id
cond_end_2246:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2076
    mov x0, #0
blk_end_2076:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2074_2075:
    // Closure for func_2074
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2074
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2068
cond_false_2067:
    adr x0, sign_id
cond_end_2068:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_right_assoc
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2262
    tst x9, #1
    b.eq do_concat_2261
    tst x0, #1
    b.ne do_compose_2259
do_apply_2260:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2263
do_compose_2259:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2263
do_concat_2261:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2263
id_morphism_2262:
    b apply_end_2263
apply_end_2263:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2257
    b after_func_2264_2265
func_2264:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2272
    tst x9, #1
    b.eq do_concat_2271
    tst x0, #1
    b.ne do_compose_2269
do_apply_2270:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2273
do_compose_2269:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2273
do_concat_2271:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2273
id_morphism_2272:
    b apply_end_2273
apply_end_2273:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2277
    tst x9, #1
    b.eq do_concat_2276
    tst x0, #1
    b.ne do_compose_2274
do_apply_2275:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2278
do_compose_2274:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2278
do_concat_2276:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2278
id_morphism_2277:
    b apply_end_2278
apply_end_2278:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2267
    mov x0, #1
    b cond_end_2268
cond_false_2267:
    adr x0, sign_id
cond_end_2268:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2266
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2284
    tst x9, #1
    b.eq do_concat_2283
    tst x0, #1
    b.ne do_compose_2281
do_apply_2282:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2285
do_compose_2281:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2285
do_concat_2283:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2285
id_morphism_2284:
    b apply_end_2285
apply_end_2285:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2289
    tst x9, #1
    b.eq do_concat_2288
    tst x0, #1
    b.ne do_compose_2286
do_apply_2287:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2290
do_compose_2286:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2290
do_concat_2288:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2290
id_morphism_2289:
    b apply_end_2290
apply_end_2290:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2279
    mov x0, #1
    b cond_end_2280
cond_false_2279:
    adr x0, sign_id
cond_end_2280:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2266
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2296
    tst x9, #1
    b.eq do_concat_2295
    tst x0, #1
    b.ne do_compose_2293
do_apply_2294:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2297
do_compose_2293:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2297
do_concat_2295:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2297
id_morphism_2296:
    b apply_end_2297
apply_end_2297:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2301
    tst x9, #1
    b.eq do_concat_2300
    tst x0, #1
    b.ne do_compose_2298
do_apply_2299:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2302
do_compose_2298:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2302
do_concat_2300:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2302
id_morphism_2301:
    b apply_end_2302
apply_end_2302:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2291
    mov x0, #1
    b cond_end_2292
cond_false_2291:
    adr x0, sign_id
cond_end_2292:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2266
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2308
    tst x9, #1
    b.eq do_concat_2307
    tst x0, #1
    b.ne do_compose_2305
do_apply_2306:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2309
do_compose_2305:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2309
do_concat_2307:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2309
id_morphism_2308:
    b apply_end_2309
apply_end_2309:
    str x0, [sp, #-16]!
    mov x0, #94
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2313
    tst x9, #1
    b.eq do_concat_2312
    tst x0, #1
    b.ne do_compose_2310
do_apply_2311:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2314
do_compose_2310:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2314
do_concat_2312:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2314
id_morphism_2313:
    b apply_end_2314
apply_end_2314:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2303
    mov x0, #1
    b cond_end_2304
cond_false_2303:
    adr x0, sign_id
cond_end_2304:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2266
    mov x0, #0
blk_end_2266:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2264_2265:
    // Closure for func_2264
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2264
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2258
cond_false_2257:
    adr x0, sign_id
cond_end_2258:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, peek
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2320
    tst x9, #1
    b.eq do_concat_2319
    tst x0, #1
    b.ne do_compose_2317
do_apply_2318:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2321
do_compose_2317:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2321
do_concat_2319:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2321
id_morphism_2320:
    b apply_end_2321
apply_end_2321:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2315
    b after_func_2322_2323
func_2322:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2327
    adr x0, sign_id
    b cmp_end_2328
cmp_true_2327:
cmp_end_2328:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2325
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2332
    tst x9, #1
    b.eq do_concat_2331
    tst x0, #1
    b.ne do_compose_2329
do_apply_2330:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2333
do_compose_2329:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2333
do_concat_2331:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2333
id_morphism_2332:
    b apply_end_2333
apply_end_2333:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2337
    tst x9, #1
    b.eq do_concat_2336
    tst x0, #1
    b.ne do_compose_2334
do_apply_2335:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2338
do_compose_2334:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2338
do_concat_2336:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2338
id_morphism_2337:
    b apply_end_2338
apply_end_2338:
    b cond_end_2326
cond_false_2325:
    adr x0, sign_id
cond_end_2326:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2324
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2342
    tst x9, #1
    b.eq do_concat_2341
    tst x0, #1
    b.ne do_compose_2339
do_apply_2340:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2343
do_compose_2339:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2343
do_concat_2341:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2343
id_morphism_2342:
    b apply_end_2343
apply_end_2343:
blk_end_2324:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2322_2323:
    // Closure for func_2322
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2322
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2316
cond_false_2315:
    adr x0, sign_id
cond_end_2316:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2349
    tst x9, #1
    b.eq do_concat_2348
    tst x0, #1
    b.ne do_compose_2346
do_apply_2347:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2350
do_compose_2346:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2350
do_concat_2348:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2350
id_morphism_2349:
    b apply_end_2350
apply_end_2350:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2344
    b after_func_2351_2352
func_2351:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2356
    adr x0, sign_id
    b cmp_end_2357
cmp_true_2356:
cmp_end_2357:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2354
    mov x0, #0
    b cond_end_2355
cond_false_2354:
    adr x0, sign_id
cond_end_2355:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2353
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2361
    tst x9, #1
    b.eq do_concat_2360
    tst x0, #1
    b.ne do_compose_2358
do_apply_2359:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2362
do_compose_2358:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2362
do_concat_2360:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2362
id_morphism_2361:
    b apply_end_2362
apply_end_2362:
blk_end_2353:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2351_2352:
    // Closure for func_2351
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2351
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2345
cond_false_2344:
    adr x0, sign_id
cond_end_2345:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expect
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2368
    tst x9, #1
    b.eq do_concat_2367
    tst x0, #1
    b.ne do_compose_2365
do_apply_2366:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2369
do_compose_2365:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2369
do_concat_2367:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2369
id_morphism_2368:
    b apply_end_2369
apply_end_2369:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2363
    b after_func_2370_2371
func_2370:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2372_2373
func_2372:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2375_2376
func_2375:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2375_2376:
    // Closure for func_2375
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2375
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2378_2379
func_2378:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2378_2379:
    // Closure for func_2378
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2378
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tok_t
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2383
    adr x0, sign_id
    b cmp_end_2384
cmp_true_2383:
cmp_end_2384:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2381
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2388
    tst x9, #1
    b.eq do_concat_2387
    tst x0, #1
    b.ne do_compose_2385
do_apply_2386:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2389
do_compose_2385:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2389
do_concat_2387:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2389
id_morphism_2388:
    b apply_end_2389
apply_end_2389:
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2393
    tst x9, #1
    b.eq do_concat_2392
    tst x0, #1
    b.ne do_compose_2390
do_apply_2391:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2394
do_compose_2390:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2394
do_concat_2392:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2394
id_morphism_2393:
    b apply_end_2394
apply_end_2394:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2398
    tst x9, #1
    b.eq do_concat_2397
    tst x0, #1
    b.ne do_compose_2395
do_apply_2396:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2399
do_compose_2395:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2399
do_concat_2397:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2399
id_morphism_2398:
    b apply_end_2399
apply_end_2399:
    b cond_end_2382
cond_false_2381:
    adr x0, sign_id
cond_end_2382:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2380
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2403
    tst x9, #1
    b.eq do_concat_2402
    tst x0, #1
    b.ne do_compose_2400
do_apply_2401:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2404
do_compose_2400:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2404
do_concat_2402:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2404
id_morphism_2403:
    b apply_end_2404
apply_end_2404:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2408
    tst x9, #1
    b.eq do_concat_2407
    tst x0, #1
    b.ne do_compose_2405
do_apply_2406:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2409
do_compose_2405:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2409
do_concat_2407:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2409
id_morphism_2408:
    b apply_end_2409
apply_end_2409:
blk_end_2380:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2413
    tst x9, #1
    b.eq do_concat_2412
    tst x0, #1
    b.ne do_compose_2410
do_apply_2411:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2414
do_compose_2410:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2414
do_concat_2412:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2414
id_morphism_2413:
    b apply_end_2414
apply_end_2414:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2377
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2418
    tst x9, #1
    b.eq do_concat_2417
    tst x0, #1
    b.ne do_compose_2415
do_apply_2416:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2419
do_compose_2415:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2419
do_concat_2417:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2419
id_morphism_2418:
    b apply_end_2419
apply_end_2419:
blk_end_2377:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2423
    tst x9, #1
    b.eq do_concat_2422
    tst x0, #1
    b.ne do_compose_2420
do_apply_2421:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2424
do_compose_2420:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2424
do_concat_2422:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2424
id_morphism_2423:
    b apply_end_2424
apply_end_2424:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2374
    adr x0, peek
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2428
    tst x9, #1
    b.eq do_concat_2427
    tst x0, #1
    b.ne do_compose_2425
do_apply_2426:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2429
do_compose_2425:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2429
do_concat_2427:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2429
id_morphism_2428:
    b apply_end_2429
apply_end_2429:
blk_end_2374:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2372_2373:
    // Closure for func_2372
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2372
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2370_2371:
    // Closure for func_2370
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2370
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2364
cond_false_2363:
    adr x0, sign_id
cond_end_2364:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_program
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2435
    tst x9, #1
    b.eq do_concat_2434
    tst x0, #1
    b.ne do_compose_2432
do_apply_2433:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2436
do_compose_2432:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2436
do_concat_2434:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2436
id_morphism_2435:
    b apply_end_2436
apply_end_2436:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2430
    b after_func_2437_2438
func_2437:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2440_2441
func_2440:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2440_2441:
    // Closure for func_2440
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2440
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2445
    tst x9, #1
    b.eq do_concat_2444
    tst x0, #1
    b.ne do_compose_2442
do_apply_2443:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2446
do_compose_2442:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2446
do_concat_2444:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2446
id_morphism_2445:
    b apply_end_2446
apply_end_2446:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2450
    tst x9, #1
    b.eq do_concat_2449
    tst x0, #1
    b.ne do_compose_2447
do_apply_2448:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2451
do_compose_2447:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2451
do_concat_2449:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2451
id_morphism_2450:
    b apply_end_2451
apply_end_2451:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2455
    tst x9, #1
    b.eq do_concat_2454
    tst x0, #1
    b.ne do_compose_2452
do_apply_2453:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2456
do_compose_2452:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2456
do_concat_2454:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2456
id_morphism_2455:
    b apply_end_2456
apply_end_2456:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2460
    tst x9, #1
    b.eq do_concat_2459
    tst x0, #1
    b.ne do_compose_2457
do_apply_2458:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2461
do_compose_2457:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2461
do_concat_2459:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2461
id_morphism_2460:
    b apply_end_2461
apply_end_2461:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2465
    tst x9, #1
    b.eq do_concat_2464
    tst x0, #1
    b.ne do_compose_2462
do_apply_2463:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2466
do_compose_2462:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2466
do_concat_2464:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2466
id_morphism_2465:
    b apply_end_2466
apply_end_2466:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2470
    tst x9, #1
    b.eq do_concat_2469
    tst x0, #1
    b.ne do_compose_2467
do_apply_2468:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2471
do_compose_2467:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2471
do_concat_2469:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2471
id_morphism_2470:
    b apply_end_2471
apply_end_2471:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2475
    tst x9, #1
    b.eq do_concat_2474
    tst x0, #1
    b.ne do_compose_2472
do_apply_2473:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2476
do_compose_2472:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2476
do_concat_2474:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2476
id_morphism_2475:
    b apply_end_2476
apply_end_2476:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2480
    tst x9, #1
    b.eq do_concat_2479
    tst x0, #1
    b.ne do_compose_2477
do_apply_2478:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2481
do_compose_2477:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2481
do_concat_2479:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2481
id_morphism_2480:
    b apply_end_2481
apply_end_2481:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2485
    tst x9, #1
    b.eq do_concat_2484
    tst x0, #1
    b.ne do_compose_2482
do_apply_2483:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2486
do_compose_2482:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2486
do_concat_2484:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2486
id_morphism_2485:
    b apply_end_2486
apply_end_2486:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2490
    tst x9, #1
    b.eq do_concat_2489
    tst x0, #1
    b.ne do_compose_2487
do_apply_2488:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2491
do_compose_2487:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2491
do_concat_2489:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2491
id_morphism_2490:
    b apply_end_2491
apply_end_2491:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2439
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2495
    tst x9, #1
    b.eq do_concat_2494
    tst x0, #1
    b.ne do_compose_2492
do_apply_2493:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2496
do_compose_2492:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2496
do_concat_2494:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2496
id_morphism_2495:
    b apply_end_2496
apply_end_2496:
blk_end_2439:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2437_2438:
    // Closure for func_2437
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2437
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2431
cond_false_2430:
    adr x0, sign_id
cond_end_2431:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2502
    tst x9, #1
    b.eq do_concat_2501
    tst x0, #1
    b.ne do_compose_2499
do_apply_2500:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2503
do_compose_2499:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2503
do_concat_2501:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2503
id_morphism_2502:
    b apply_end_2503
apply_end_2503:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2497
    b after_func_2504_2505
func_2504:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2507_2508
func_2507:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2507_2508:
    // Closure for func_2507
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2507
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2510_2511
func_2510:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2510_2511:
    // Closure for func_2510
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2510
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2515
    adr x0, sign_id
    b cmp_end_2516
cmp_true_2515:
cmp_end_2516:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2513
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2520
    tst x9, #1
    b.eq do_concat_2519
    tst x0, #1
    b.ne do_compose_2517
do_apply_2518:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2521
do_compose_2517:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2521
do_concat_2519:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2521
id_morphism_2520:
    b apply_end_2521
apply_end_2521:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2525
    tst x9, #1
    b.eq do_concat_2524
    tst x0, #1
    b.ne do_compose_2522
do_apply_2523:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2526
do_compose_2522:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2526
do_concat_2524:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2526
id_morphism_2525:
    b apply_end_2526
apply_end_2526:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2530
    tst x9, #1
    b.eq do_concat_2529
    tst x0, #1
    b.ne do_compose_2527
do_apply_2528:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2531
do_compose_2527:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2531
do_concat_2529:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2531
id_morphism_2530:
    b apply_end_2531
apply_end_2531:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2535
    tst x9, #1
    b.eq do_concat_2534
    tst x0, #1
    b.ne do_compose_2532
do_apply_2533:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2536
do_compose_2532:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2536
do_concat_2534:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2536
id_morphism_2535:
    b apply_end_2536
apply_end_2536:
    b cond_end_2514
cond_false_2513:
    adr x0, sign_id
cond_end_2514:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2512
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2539
    adr x0, sign_id
    b cmp_end_2540
cmp_true_2539:
cmp_end_2540:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2537
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2544
    tst x9, #1
    b.eq do_concat_2543
    tst x0, #1
    b.ne do_compose_2541
do_apply_2542:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2545
do_compose_2541:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2545
do_concat_2543:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2545
id_morphism_2544:
    b apply_end_2545
apply_end_2545:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2549
    tst x9, #1
    b.eq do_concat_2548
    tst x0, #1
    b.ne do_compose_2546
do_apply_2547:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2550
do_compose_2546:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2550
do_concat_2548:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2550
id_morphism_2549:
    b apply_end_2550
apply_end_2550:
    b cond_end_2538
cond_false_2537:
    adr x0, sign_id
cond_end_2538:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2512
    adr x0, str_8
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2512
    b after_func_2551_2552
func_2551:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2551_2552:
    // Closure for func_2551
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2551
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2554_2555
func_2554:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2554_2555:
    // Closure for func_2554
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2554
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2557_2558
func_2557:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2557_2558:
    // Closure for func_2557
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2557
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2560_2561
func_2560:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2560_2561:
    // Closure for func_2560
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2560
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2565
    tst x9, #1
    b.eq do_concat_2564
    tst x0, #1
    b.ne do_compose_2562
do_apply_2563:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2566
do_compose_2562:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2566
do_concat_2564:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2566
id_morphism_2565:
    b apply_end_2566
apply_end_2566:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2570
    tst x9, #1
    b.eq do_concat_2569
    tst x0, #1
    b.ne do_compose_2567
do_apply_2568:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2571
do_compose_2567:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2571
do_concat_2569:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2571
id_morphism_2570:
    b apply_end_2571
apply_end_2571:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2575
    tst x9, #1
    b.eq do_concat_2574
    tst x0, #1
    b.ne do_compose_2572
do_apply_2573:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2576
do_compose_2572:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2576
do_concat_2574:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2576
id_morphism_2575:
    b apply_end_2576
apply_end_2576:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2580
    tst x9, #1
    b.eq do_concat_2579
    tst x0, #1
    b.ne do_compose_2577
do_apply_2578:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2581
do_compose_2577:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2581
do_concat_2579:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2581
id_morphism_2580:
    b apply_end_2581
apply_end_2581:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2585
    tst x9, #1
    b.eq do_concat_2584
    tst x0, #1
    b.ne do_compose_2582
do_apply_2583:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2586
do_compose_2582:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2586
do_concat_2584:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2586
id_morphism_2585:
    b apply_end_2586
apply_end_2586:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2590
    tst x9, #1
    b.eq do_concat_2589
    tst x0, #1
    b.ne do_compose_2587
do_apply_2588:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2591
do_compose_2587:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2591
do_concat_2589:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2591
id_morphism_2590:
    b apply_end_2591
apply_end_2591:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2595
    tst x9, #1
    b.eq do_concat_2594
    tst x0, #1
    b.ne do_compose_2592
do_apply_2593:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2596
do_compose_2592:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2596
do_concat_2594:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2596
id_morphism_2595:
    b apply_end_2596
apply_end_2596:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2600
    tst x9, #1
    b.eq do_concat_2599
    tst x0, #1
    b.ne do_compose_2597
do_apply_2598:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2601
do_compose_2597:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2601
do_concat_2599:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2601
id_morphism_2600:
    b apply_end_2601
apply_end_2601:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2605
    tst x9, #1
    b.eq do_concat_2604
    tst x0, #1
    b.ne do_compose_2602
do_apply_2603:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2606
do_compose_2602:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2606
do_concat_2604:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2606
id_morphism_2605:
    b apply_end_2606
apply_end_2606:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2610
    tst x9, #1
    b.eq do_concat_2609
    tst x0, #1
    b.ne do_compose_2607
do_apply_2608:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2611
do_compose_2607:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2611
do_concat_2609:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2611
id_morphism_2610:
    b apply_end_2611
apply_end_2611:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2559
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2615
    tst x9, #1
    b.eq do_concat_2614
    tst x0, #1
    b.ne do_compose_2612
do_apply_2613:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2616
do_compose_2612:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2616
do_concat_2614:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2616
id_morphism_2615:
    b apply_end_2616
apply_end_2616:
blk_end_2559:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2620
    tst x9, #1
    b.eq do_concat_2619
    tst x0, #1
    b.ne do_compose_2617
do_apply_2618:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2621
do_compose_2617:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2621
do_concat_2619:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2621
id_morphism_2620:
    b apply_end_2621
apply_end_2621:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2556
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2625
    tst x9, #1
    b.eq do_concat_2624
    tst x0, #1
    b.ne do_compose_2622
do_apply_2623:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2626
do_compose_2622:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2626
do_concat_2624:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2626
id_morphism_2625:
    b apply_end_2626
apply_end_2626:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2630
    tst x9, #1
    b.eq do_concat_2629
    tst x0, #1
    b.ne do_compose_2627
do_apply_2628:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2631
do_compose_2627:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2631
do_concat_2629:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2631
id_morphism_2630:
    b apply_end_2631
apply_end_2631:
blk_end_2556:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2635
    tst x9, #1
    b.eq do_concat_2634
    tst x0, #1
    b.ne do_compose_2632
do_apply_2633:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2636
do_compose_2632:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2636
do_concat_2634:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2636
id_morphism_2635:
    b apply_end_2636
apply_end_2636:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2553
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2640
    tst x9, #1
    b.eq do_concat_2639
    tst x0, #1
    b.ne do_compose_2637
do_apply_2638:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2641
do_compose_2637:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2641
do_concat_2639:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2641
id_morphism_2640:
    b apply_end_2641
apply_end_2641:
blk_end_2553:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2645
    tst x9, #1
    b.eq do_concat_2644
    tst x0, #1
    b.ne do_compose_2642
do_apply_2643:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2646
do_compose_2642:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2646
do_concat_2644:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2646
id_morphism_2645:
    b apply_end_2646
apply_end_2646:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2512
    adr x0, parse_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2650
    tst x9, #1
    b.eq do_concat_2649
    tst x0, #1
    b.ne do_compose_2647
do_apply_2648:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2651
do_compose_2647:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2651
do_concat_2649:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2651
id_morphism_2650:
    b apply_end_2651
apply_end_2651:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2655
    tst x9, #1
    b.eq do_concat_2654
    tst x0, #1
    b.ne do_compose_2652
do_apply_2653:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2656
do_compose_2652:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2656
do_concat_2654:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2656
id_morphism_2655:
    b apply_end_2656
apply_end_2656:
blk_end_2512:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2660
    tst x9, #1
    b.eq do_concat_2659
    tst x0, #1
    b.ne do_compose_2657
do_apply_2658:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2661
do_compose_2657:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2661
do_concat_2659:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2661
id_morphism_2660:
    b apply_end_2661
apply_end_2661:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2509
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2665
    tst x9, #1
    b.eq do_concat_2664
    tst x0, #1
    b.ne do_compose_2662
do_apply_2663:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2666
do_compose_2662:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2666
do_concat_2664:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2666
id_morphism_2665:
    b apply_end_2666
apply_end_2666:
blk_end_2509:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2670
    tst x9, #1
    b.eq do_concat_2669
    tst x0, #1
    b.ne do_compose_2667
do_apply_2668:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2671
do_compose_2667:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2671
do_concat_2669:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2671
id_morphism_2670:
    b apply_end_2671
apply_end_2671:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2506
    adr x0, peek
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2675
    tst x9, #1
    b.eq do_concat_2674
    tst x0, #1
    b.ne do_compose_2672
do_apply_2673:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2676
do_compose_2672:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2676
do_concat_2674:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2676
id_morphism_2675:
    b apply_end_2676
apply_end_2676:
blk_end_2506:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2504_2505:
    // Closure for func_2504
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2504
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2498
cond_false_2497:
    adr x0, sign_id
cond_end_2498:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2682
    tst x9, #1
    b.eq do_concat_2681
    tst x0, #1
    b.ne do_compose_2679
do_apply_2680:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2683
do_compose_2679:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2683
do_concat_2681:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2683
id_morphism_2682:
    b apply_end_2683
apply_end_2683:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2677
    b after_func_2684_2685
func_2684:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_9
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2686
    adr x0, parse_program
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2690
    tst x9, #1
    b.eq do_concat_2689
    tst x0, #1
    b.ne do_compose_2687
do_apply_2688:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2691
do_compose_2687:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2691
do_concat_2689:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2691
id_morphism_2690:
    b apply_end_2691
apply_end_2691:
    str x0, [sp, #-16]!
    adr x0, str_10
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2695
    tst x9, #1
    b.eq do_concat_2694
    tst x0, #1
    b.ne do_compose_2692
do_apply_2693:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2696
do_compose_2692:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2696
do_concat_2694:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2696
id_morphism_2695:
    b apply_end_2696
apply_end_2696:
blk_end_2686:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2684_2685:
    // Closure for func_2684
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2684
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2678
cond_false_2677:
    adr x0, sign_id
cond_end_2678:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2702
    tst x9, #1
    b.eq do_concat_2701
    tst x0, #1
    b.ne do_compose_2699
do_apply_2700:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2703
do_compose_2699:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2703
do_concat_2701:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2703
id_morphism_2702:
    b apply_end_2703
apply_end_2703:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2697
    b after_func_2704_2705
func_2704:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2706_2707
func_2706:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2709_2710
func_2709:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2709_2710:
    // Closure for func_2709
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2709
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2712_2713
func_2712:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2712_2713:
    // Closure for func_2712
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2712
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2715_2716
func_2715:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2715_2716:
    // Closure for func_2715
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2715
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2720
    tst x9, #1
    b.eq do_concat_2719
    tst x0, #1
    b.ne do_compose_2717
do_apply_2718:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2721
do_compose_2717:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2721
do_concat_2719:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2721
id_morphism_2720:
    b apply_end_2721
apply_end_2721:
    str x0, [sp, #-16]!
    adr x0, rest_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2725
    tst x9, #1
    b.eq do_concat_2724
    tst x0, #1
    b.ne do_compose_2722
do_apply_2723:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2726
do_compose_2722:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2726
do_concat_2724:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2726
id_morphism_2725:
    b apply_end_2726
apply_end_2726:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2730
    tst x9, #1
    b.eq do_concat_2729
    tst x0, #1
    b.ne do_compose_2727
do_apply_2728:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2731
do_compose_2727:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2731
do_concat_2729:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2731
id_morphism_2730:
    b apply_end_2731
apply_end_2731:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2735
    tst x9, #1
    b.eq do_concat_2734
    tst x0, #1
    b.ne do_compose_2732
do_apply_2733:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2736
do_compose_2732:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2736
do_concat_2734:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2736
id_morphism_2735:
    b apply_end_2736
apply_end_2736:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2714
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2740
    tst x9, #1
    b.eq do_concat_2739
    tst x0, #1
    b.ne do_compose_2737
do_apply_2738:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2741
do_compose_2737:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2741
do_concat_2739:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2741
id_morphism_2740:
    b apply_end_2741
apply_end_2741:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2745
    tst x9, #1
    b.eq do_concat_2744
    tst x0, #1
    b.ne do_compose_2742
do_apply_2743:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2746
do_compose_2742:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2746
do_concat_2744:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2746
id_morphism_2745:
    b apply_end_2746
apply_end_2746:
blk_end_2714:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2750
    tst x9, #1
    b.eq do_concat_2749
    tst x0, #1
    b.ne do_compose_2747
do_apply_2748:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2751
do_compose_2747:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2751
do_concat_2749:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2751
id_morphism_2750:
    b apply_end_2751
apply_end_2751:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2711
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2755
    tst x9, #1
    b.eq do_concat_2754
    tst x0, #1
    b.ne do_compose_2752
do_apply_2753:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2756
do_compose_2752:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2756
do_concat_2754:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2756
id_morphism_2755:
    b apply_end_2756
apply_end_2756:
blk_end_2711:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2760
    tst x9, #1
    b.eq do_concat_2759
    tst x0, #1
    b.ne do_compose_2757
do_apply_2758:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2761
do_compose_2757:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2761
do_concat_2759:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2761
id_morphism_2760:
    b apply_end_2761
apply_end_2761:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2708
    adr x0, parse_primary
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2765
    tst x9, #1
    b.eq do_concat_2764
    tst x0, #1
    b.ne do_compose_2762
do_apply_2763:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2766
do_compose_2762:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2766
do_concat_2764:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2766
id_morphism_2765:
    b apply_end_2766
apply_end_2766:
blk_end_2708:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2706_2707:
    // Closure for func_2706
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2706
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2704_2705:
    // Closure for func_2704
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2704
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2698
cond_false_2697:
    adr x0, sign_id
cond_end_2698:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2772
    tst x9, #1
    b.eq do_concat_2771
    tst x0, #1
    b.ne do_compose_2769
do_apply_2770:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2773
do_compose_2769:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2773
do_concat_2771:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2773
id_morphism_2772:
    b apply_end_2773
apply_end_2773:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2767
    b after_func_2774_2775
func_2774:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2776_2777
func_2776:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2778_2779
func_2778:
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
    b after_func_2781_2782
func_2781:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2781_2782:
    // Closure for func_2781
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2781
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2784_2785
func_2784:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2784_2785:
    // Closure for func_2784
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2784
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_11
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2786
    adr x0, can_start_expr
    str x0, [sp, #-16]!
    adr x0, type
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2792
    tst x9, #1
    b.eq do_concat_2791
    tst x0, #1
    b.ne do_compose_2789
do_apply_2790:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2793
do_compose_2789:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2793
do_concat_2791:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2793
id_morphism_2792:
    b apply_end_2793
apply_end_2793:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2787
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_12
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2794
    b after_func_2795_2796
func_2795:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2795_2796:
    // Closure for func_2795
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2795
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2798_2799
func_2798:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2798_2799:
    // Closure for func_2798
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2798
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2801_2802
func_2801:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2801_2802:
    // Closure for func_2801
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2801
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2804_2805
func_2804:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2804_2805:
    // Closure for func_2804
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2804
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, new_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2809
    tst x9, #1
    b.eq do_concat_2808
    tst x0, #1
    b.ne do_compose_2806
do_apply_2807:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2810
do_compose_2806:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2810
do_concat_2808:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2810
id_morphism_2809:
    b apply_end_2810
apply_end_2810:
    str x0, [sp, #-16]!
    adr x0, rest_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2814
    tst x9, #1
    b.eq do_concat_2813
    tst x0, #1
    b.ne do_compose_2811
do_apply_2812:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2815
do_compose_2811:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2815
do_concat_2813:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2815
id_morphism_2814:
    b apply_end_2815
apply_end_2815:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2819
    tst x9, #1
    b.eq do_concat_2818
    tst x0, #1
    b.ne do_compose_2816
do_apply_2817:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2820
do_compose_2816:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2820
do_concat_2818:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2820
id_morphism_2819:
    b apply_end_2820
apply_end_2820:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2824
    tst x9, #1
    b.eq do_concat_2823
    tst x0, #1
    b.ne do_compose_2821
do_apply_2822:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2825
do_compose_2821:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2825
do_concat_2823:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2825
id_morphism_2824:
    b apply_end_2825
apply_end_2825:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2803
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2829
    tst x9, #1
    b.eq do_concat_2828
    tst x0, #1
    b.ne do_compose_2826
do_apply_2827:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2830
do_compose_2826:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2830
do_concat_2828:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2830
id_morphism_2829:
    b apply_end_2830
apply_end_2830:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2834
    tst x9, #1
    b.eq do_concat_2833
    tst x0, #1
    b.ne do_compose_2831
do_apply_2832:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2835
do_compose_2831:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2835
do_concat_2833:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2835
id_morphism_2834:
    b apply_end_2835
apply_end_2835:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2839
    tst x9, #1
    b.eq do_concat_2838
    tst x0, #1
    b.ne do_compose_2836
do_apply_2837:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2840
do_compose_2836:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2840
do_concat_2838:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2840
id_morphism_2839:
    b apply_end_2840
apply_end_2840:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2844
    tst x9, #1
    b.eq do_concat_2843
    tst x0, #1
    b.ne do_compose_2841
do_apply_2842:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2845
do_compose_2841:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2845
do_concat_2843:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2845
id_morphism_2844:
    b apply_end_2845
apply_end_2845:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2849
    tst x9, #1
    b.eq do_concat_2848
    tst x0, #1
    b.ne do_compose_2846
do_apply_2847:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2850
do_compose_2846:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2850
do_concat_2848:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2850
id_morphism_2849:
    b apply_end_2850
apply_end_2850:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2854
    tst x9, #1
    b.eq do_concat_2853
    tst x0, #1
    b.ne do_compose_2851
do_apply_2852:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2855
do_compose_2851:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2855
do_concat_2853:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2855
id_morphism_2854:
    b apply_end_2855
apply_end_2855:
blk_end_2803:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2859
    tst x9, #1
    b.eq do_concat_2858
    tst x0, #1
    b.ne do_compose_2856
do_apply_2857:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2860
do_compose_2856:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2860
do_concat_2858:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2860
id_morphism_2859:
    b apply_end_2860
apply_end_2860:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2800
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2864
    tst x9, #1
    b.eq do_concat_2863
    tst x0, #1
    b.ne do_compose_2861
do_apply_2862:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2865
do_compose_2861:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2865
do_concat_2863:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2865
id_morphism_2864:
    b apply_end_2865
apply_end_2865:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2869
    tst x9, #1
    b.eq do_concat_2868
    tst x0, #1
    b.ne do_compose_2866
do_apply_2867:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2870
do_compose_2866:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2870
do_concat_2868:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2870
id_morphism_2869:
    b apply_end_2870
apply_end_2870:
blk_end_2800:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2874
    tst x9, #1
    b.eq do_concat_2873
    tst x0, #1
    b.ne do_compose_2871
do_apply_2872:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2875
do_compose_2871:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2875
do_concat_2873:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2875
id_morphism_2874:
    b apply_end_2875
apply_end_2875:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2797
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2879
    tst x9, #1
    b.eq do_concat_2878
    tst x0, #1
    b.ne do_compose_2876
do_apply_2877:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2880
do_compose_2876:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2880
do_concat_2878:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2880
id_morphism_2879:
    b apply_end_2880
apply_end_2880:
blk_end_2797:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2884
    tst x9, #1
    b.eq do_concat_2883
    tst x0, #1
    b.ne do_compose_2881
do_apply_2882:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2885
do_compose_2881:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2885
do_concat_2883:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2885
id_morphism_2884:
    b apply_end_2885
apply_end_2885:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2794
    adr x0, parse_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2889
    tst x9, #1
    b.eq do_concat_2888
    tst x0, #1
    b.ne do_compose_2886
do_apply_2887:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2890
do_compose_2886:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2890
do_concat_2888:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2890
id_morphism_2889:
    b apply_end_2890
apply_end_2890:
    str x0, [sp, #-16]!
    mov x0, #6
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2894
    tst x9, #1
    b.eq do_concat_2893
    tst x0, #1
    b.ne do_compose_2891
do_apply_2892:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2895
do_compose_2891:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2895
do_concat_2893:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2895
id_morphism_2894:
    b apply_end_2895
apply_end_2895:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2794
    adr x0, str_13
blk_end_2794:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2899
    tst x9, #1
    b.eq do_concat_2898
    tst x0, #1
    b.ne do_compose_2896
do_apply_2897:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2900
do_compose_2896:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2900
do_concat_2898:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2900
id_morphism_2899:
    b apply_end_2900
apply_end_2900:
    b cond_end_2788
cond_false_2787:
    adr x0, sign_id
cond_end_2788:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2786
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_2903
    adr x0, sign_id
    b cmp_end_2904
cmp_true_2903:
cmp_end_2904:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2901
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2908
    tst x9, #1
    b.eq do_concat_2907
    tst x0, #1
    b.ne do_compose_2905
do_apply_2906:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2909
do_compose_2905:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2909
do_concat_2907:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2909
id_morphism_2908:
    b apply_end_2909
apply_end_2909:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2913
    tst x9, #1
    b.eq do_concat_2912
    tst x0, #1
    b.ne do_compose_2910
do_apply_2911:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2914
do_compose_2910:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2914
do_concat_2912:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2914
id_morphism_2913:
    b apply_end_2914
apply_end_2914:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2918
    tst x9, #1
    b.eq do_concat_2917
    tst x0, #1
    b.ne do_compose_2915
do_apply_2916:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2919
do_compose_2915:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2919
do_concat_2917:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2919
id_morphism_2918:
    b apply_end_2919
apply_end_2919:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2923
    tst x9, #1
    b.eq do_concat_2922
    tst x0, #1
    b.ne do_compose_2920
do_apply_2921:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2924
do_compose_2920:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2924
do_concat_2922:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2924
id_morphism_2923:
    b apply_end_2924
apply_end_2924:
    b cond_end_2902
cond_false_2901:
    adr x0, sign_id
cond_end_2902:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2786
    b after_func_2925_2926
func_2925:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2925_2926:
    // Closure for func_2925
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2925
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2928_2929
func_2928:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2928_2929:
    // Closure for func_2928
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2928
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, prec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_2933
    adr x0, sign_id
    b cmp_end_2934
cmp_true_2933:
cmp_end_2934:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2931
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2938
    tst x9, #1
    b.eq do_concat_2937
    tst x0, #1
    b.ne do_compose_2935
do_apply_2936:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2939
do_compose_2935:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2939
do_concat_2937:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2939
id_morphism_2938:
    b apply_end_2939
apply_end_2939:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2943
    tst x9, #1
    b.eq do_concat_2942
    tst x0, #1
    b.ne do_compose_2940
do_apply_2941:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2944
do_compose_2940:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2944
do_concat_2942:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2944
id_morphism_2943:
    b apply_end_2944
apply_end_2944:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2948
    tst x9, #1
    b.eq do_concat_2947
    tst x0, #1
    b.ne do_compose_2945
do_apply_2946:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2949
do_compose_2945:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2949
do_concat_2947:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2949
id_morphism_2948:
    b apply_end_2949
apply_end_2949:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2953
    tst x9, #1
    b.eq do_concat_2952
    tst x0, #1
    b.ne do_compose_2950
do_apply_2951:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2954
do_compose_2950:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2954
do_concat_2952:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2954
id_morphism_2953:
    b apply_end_2954
apply_end_2954:
    b cond_end_2932
cond_false_2931:
    adr x0, sign_id
cond_end_2932:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2930
    b after_func_2955_2956
func_2955:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2955_2956:
    // Closure for func_2955
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2955
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2958_2959
func_2958:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2958_2959:
    // Closure for func_2958
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2958
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2961_2962
func_2961:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2961_2962:
    // Closure for func_2961
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2961
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2964_2965
func_2964:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2964_2965:
    // Closure for func_2964
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2964
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2967_2968
func_2967:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2967_2968:
    // Closure for func_2967
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2967
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2970_2971
func_2970:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2970_2971:
    // Closure for func_2970
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2970
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, new_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2975
    tst x9, #1
    b.eq do_concat_2974
    tst x0, #1
    b.ne do_compose_2972
do_apply_2973:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2976
do_compose_2972:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2976
do_concat_2974:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2976
id_morphism_2975:
    b apply_end_2976
apply_end_2976:
    str x0, [sp, #-16]!
    adr x0, rest_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2980
    tst x9, #1
    b.eq do_concat_2979
    tst x0, #1
    b.ne do_compose_2977
do_apply_2978:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2981
do_compose_2977:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2981
do_concat_2979:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2981
id_morphism_2980:
    b apply_end_2981
apply_end_2981:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2985
    tst x9, #1
    b.eq do_concat_2984
    tst x0, #1
    b.ne do_compose_2982
do_apply_2983:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2986
do_compose_2982:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2986
do_concat_2984:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2986
id_morphism_2985:
    b apply_end_2986
apply_end_2986:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2990
    tst x9, #1
    b.eq do_concat_2989
    tst x0, #1
    b.ne do_compose_2987
do_apply_2988:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2991
do_compose_2987:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2991
do_concat_2989:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2991
id_morphism_2990:
    b apply_end_2991
apply_end_2991:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2969
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2995
    tst x9, #1
    b.eq do_concat_2994
    tst x0, #1
    b.ne do_compose_2992
do_apply_2993:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2996
do_compose_2992:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2996
do_concat_2994:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2996
id_morphism_2995:
    b apply_end_2996
apply_end_2996:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3000
    tst x9, #1
    b.eq do_concat_2999
    tst x0, #1
    b.ne do_compose_2997
do_apply_2998:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3001
do_compose_2997:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3001
do_concat_2999:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3001
id_morphism_3000:
    b apply_end_3001
apply_end_3001:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3005
    tst x9, #1
    b.eq do_concat_3004
    tst x0, #1
    b.ne do_compose_3002
do_apply_3003:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3006
do_compose_3002:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3006
do_concat_3004:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3006
id_morphism_3005:
    b apply_end_3006
apply_end_3006:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3010
    tst x9, #1
    b.eq do_concat_3009
    tst x0, #1
    b.ne do_compose_3007
do_apply_3008:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3011
do_compose_3007:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3011
do_concat_3009:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3011
id_morphism_3010:
    b apply_end_3011
apply_end_3011:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3015
    tst x9, #1
    b.eq do_concat_3014
    tst x0, #1
    b.ne do_compose_3012
do_apply_3013:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3016
do_compose_3012:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3016
do_concat_3014:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3016
id_morphism_3015:
    b apply_end_3016
apply_end_3016:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3020
    tst x9, #1
    b.eq do_concat_3019
    tst x0, #1
    b.ne do_compose_3017
do_apply_3018:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3021
do_compose_3017:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3021
do_concat_3019:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3021
id_morphism_3020:
    b apply_end_3021
apply_end_3021:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3025
    tst x9, #1
    b.eq do_concat_3024
    tst x0, #1
    b.ne do_compose_3022
do_apply_3023:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3026
do_compose_3022:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3026
do_concat_3024:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3026
id_morphism_3025:
    b apply_end_3026
apply_end_3026:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3030
    tst x9, #1
    b.eq do_concat_3029
    tst x0, #1
    b.ne do_compose_3027
do_apply_3028:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3031
do_compose_3027:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3031
do_concat_3029:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3031
id_morphism_3030:
    b apply_end_3031
apply_end_3031:
blk_end_2969:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3035
    tst x9, #1
    b.eq do_concat_3034
    tst x0, #1
    b.ne do_compose_3032
do_apply_3033:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3036
do_compose_3032:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3036
do_concat_3034:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3036
id_morphism_3035:
    b apply_end_3036
apply_end_3036:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2966
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3040
    tst x9, #1
    b.eq do_concat_3039
    tst x0, #1
    b.ne do_compose_3037
do_apply_3038:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3041
do_compose_3037:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3041
do_concat_3039:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3041
id_morphism_3040:
    b apply_end_3041
apply_end_3041:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3045
    tst x9, #1
    b.eq do_concat_3044
    tst x0, #1
    b.ne do_compose_3042
do_apply_3043:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3046
do_compose_3042:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3046
do_concat_3044:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3046
id_morphism_3045:
    b apply_end_3046
apply_end_3046:
blk_end_2966:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3050
    tst x9, #1
    b.eq do_concat_3049
    tst x0, #1
    b.ne do_compose_3047
do_apply_3048:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3051
do_compose_3047:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3051
do_concat_3049:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3051
id_morphism_3050:
    b apply_end_3051
apply_end_3051:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2963
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3055
    tst x9, #1
    b.eq do_concat_3054
    tst x0, #1
    b.ne do_compose_3052
do_apply_3053:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3056
do_compose_3052:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3056
do_concat_3054:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3056
id_morphism_3055:
    b apply_end_3056
apply_end_3056:
blk_end_2963:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3060
    tst x9, #1
    b.eq do_concat_3059
    tst x0, #1
    b.ne do_compose_3057
do_apply_3058:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3061
do_compose_3057:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3061
do_concat_3059:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3061
id_morphism_3060:
    b apply_end_3061
apply_end_3061:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2960
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, next_tokens
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3065
    tst x9, #1
    b.eq do_concat_3064
    tst x0, #1
    b.ne do_compose_3062
do_apply_3063:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3066
do_compose_3062:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3066
do_concat_3064:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3066
id_morphism_3065:
    b apply_end_3066
apply_end_3066:
    str x0, [sp, #-16]!
    adr x0, next_min_prec
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3070
    tst x9, #1
    b.eq do_concat_3069
    tst x0, #1
    b.ne do_compose_3067
do_apply_3068:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3071
do_compose_3067:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3071
do_concat_3069:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3071
id_morphism_3070:
    b apply_end_3071
apply_end_3071:
blk_end_2960:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3075
    tst x9, #1
    b.eq do_concat_3074
    tst x0, #1
    b.ne do_compose_3072
do_apply_3073:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3076
do_compose_3072:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3076
do_concat_3074:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3076
id_morphism_3075:
    b apply_end_3076
apply_end_3076:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2957
    b after_func_3077_3078
func_3077:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3079_3080
func_3079:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, prec
    str x0, [sp, #-16]!
    adr x0, prec
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3084
    tst x9, #1
    b.eq do_concat_3083
    tst x0, #1
    b.ne do_compose_3081
do_apply_3082:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3085
do_compose_3081:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3085
do_concat_3083:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3085
id_morphism_3084:
    b apply_end_3085
apply_end_3085:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3079_3080:
    // Closure for func_3079
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3079
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3077_3078:
    // Closure for func_3077
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3077
    ldr x0, [sp], #16
    bl _cons
blk_end_2957:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3089
    tst x9, #1
    b.eq do_concat_3088
    tst x0, #1
    b.ne do_compose_3086
do_apply_3087:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3090
do_compose_3086:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3090
do_concat_3088:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3090
id_morphism_3089:
    b apply_end_3090
apply_end_3090:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2930
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3094
    tst x9, #1
    b.eq do_concat_3093
    tst x0, #1
    b.ne do_compose_3091
do_apply_3092:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3095
do_compose_3091:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3095
do_concat_3093:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3095
id_morphism_3094:
    b apply_end_3095
apply_end_3095:
blk_end_2930:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3099
    tst x9, #1
    b.eq do_concat_3098
    tst x0, #1
    b.ne do_compose_3096
do_apply_3097:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3100
do_compose_3096:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3100
do_concat_3098:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3100
id_morphism_3099:
    b apply_end_3100
apply_end_3100:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2927
    adr x0, get_prec
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3104
    tst x9, #1
    b.eq do_concat_3103
    tst x0, #1
    b.ne do_compose_3101
do_apply_3102:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3105
do_compose_3101:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3105
do_concat_3103:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3105
id_morphism_3104:
    b apply_end_3105
apply_end_3105:
blk_end_2927:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3109
    tst x9, #1
    b.eq do_concat_3108
    tst x0, #1
    b.ne do_compose_3106
do_apply_3107:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3110
do_compose_3106:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3110
do_concat_3108:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3110
id_morphism_3109:
    b apply_end_3110
apply_end_3110:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2786
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3114
    tst x9, #1
    b.eq do_concat_3113
    tst x0, #1
    b.ne do_compose_3111
do_apply_3112:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3115
do_compose_3111:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3115
do_concat_3113:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3115
id_morphism_3114:
    b apply_end_3115
apply_end_3115:
blk_end_2786:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3119
    tst x9, #1
    b.eq do_concat_3118
    tst x0, #1
    b.ne do_compose_3116
do_apply_3117:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3120
do_compose_3116:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3120
do_concat_3118:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3120
id_morphism_3119:
    b apply_end_3120
apply_end_3120:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2783
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3124
    tst x9, #1
    b.eq do_concat_3123
    tst x0, #1
    b.ne do_compose_3121
do_apply_3122:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3125
do_compose_3121:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3125
do_concat_3123:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3125
id_morphism_3124:
    b apply_end_3125
apply_end_3125:
blk_end_2783:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3129
    tst x9, #1
    b.eq do_concat_3128
    tst x0, #1
    b.ne do_compose_3126
do_apply_3127:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3130
do_compose_3126:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3130
do_concat_3128:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3130
id_morphism_3129:
    b apply_end_3130
apply_end_3130:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2780
    adr x0, peek
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3134
    tst x9, #1
    b.eq do_concat_3133
    tst x0, #1
    b.ne do_compose_3131
do_apply_3132:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3135
do_compose_3131:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3135
do_concat_3133:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3135
id_morphism_3134:
    b apply_end_3135
apply_end_3135:
blk_end_2780:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2778_2779:
    // Closure for func_2778
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
    adr x1, func_2778
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2776_2777:
    // Closure for func_2776
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2776
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2774_2775:
    // Closure for func_2774
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2774
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2768
cond_false_2767:
    adr x0, sign_id
cond_end_2768:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, can_start_expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3141
    tst x9, #1
    b.eq do_concat_3140
    tst x0, #1
    b.ne do_compose_3138
do_apply_3139:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3142
do_compose_3138:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3142
do_concat_3140:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3142
id_morphism_3141:
    b apply_end_3142
apply_end_3142:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3136
    b after_func_3143_3144
func_3143:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3148
    adr x0, sign_id
    b cmp_end_3149
cmp_true_3148:
cmp_end_3149:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3146
    mov x0, #1
    b cond_end_3147
cond_false_3146:
    adr x0, sign_id
cond_end_3147:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3145
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3152
    adr x0, sign_id
    b cmp_end_3153
cmp_true_3152:
cmp_end_3153:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3150
    mov x0, #1
    b cond_end_3151
cond_false_3150:
    adr x0, sign_id
cond_end_3151:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3145
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3156
    adr x0, sign_id
    b cmp_end_3157
cmp_true_3156:
cmp_end_3157:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3154
    mov x0, #1
    b cond_end_3155
cond_false_3154:
    adr x0, sign_id
cond_end_3155:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3145
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3160
    adr x0, sign_id
    b cmp_end_3161
cmp_true_3160:
cmp_end_3161:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3158
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #40
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3165
    tst x9, #1
    b.eq do_concat_3164
    tst x0, #1
    b.ne do_compose_3162
do_apply_3163:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3166
do_compose_3162:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3166
do_concat_3164:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3166
id_morphism_3165:
    b apply_end_3166
apply_end_3166:
    b cond_end_3159
cond_false_3158:
    adr x0, sign_id
cond_end_3159:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3145
    mov x0, #0
blk_end_3145:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3143_3144:
    // Closure for func_3143
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3143
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3137
cond_false_3136:
    adr x0, sign_id
cond_end_3137:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_prefix_op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3172
    tst x9, #1
    b.eq do_concat_3171
    tst x0, #1
    b.ne do_compose_3169
do_apply_3170:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3173
do_compose_3169:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3173
do_concat_3171:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3173
id_morphism_3172:
    b apply_end_3173
apply_end_3173:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3167
    b after_func_3174_3175
func_3174:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3182
    tst x9, #1
    b.eq do_concat_3181
    tst x0, #1
    b.ne do_compose_3179
do_apply_3180:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3183
do_compose_3179:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3183
do_concat_3181:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3183
id_morphism_3182:
    b apply_end_3183
apply_end_3183:
    str x0, [sp, #-16]!
    mov x0, #33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3187
    tst x9, #1
    b.eq do_concat_3186
    tst x0, #1
    b.ne do_compose_3184
do_apply_3185:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3188
do_compose_3184:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3188
do_concat_3186:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3188
id_morphism_3187:
    b apply_end_3188
apply_end_3188:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3177
    mov x0, #1
    b cond_end_3178
cond_false_3177:
    adr x0, sign_id
cond_end_3178:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3176
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3194
    tst x9, #1
    b.eq do_concat_3193
    tst x0, #1
    b.ne do_compose_3191
do_apply_3192:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3195
do_compose_3191:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3195
do_concat_3193:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3195
id_morphism_3194:
    b apply_end_3195
apply_end_3195:
    str x0, [sp, #-16]!
    mov x0, #35
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3199
    tst x9, #1
    b.eq do_concat_3198
    tst x0, #1
    b.ne do_compose_3196
do_apply_3197:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3200
do_compose_3196:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3200
do_concat_3198:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3200
id_morphism_3199:
    b apply_end_3200
apply_end_3200:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3189
    mov x0, #1
    b cond_end_3190
cond_false_3189:
    adr x0, sign_id
cond_end_3190:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3176
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3206
    tst x9, #1
    b.eq do_concat_3205
    tst x0, #1
    b.ne do_compose_3203
do_apply_3204:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3207
do_compose_3203:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3207
do_concat_3205:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3207
id_morphism_3206:
    b apply_end_3207
apply_end_3207:
    str x0, [sp, #-16]!
    mov x0, #36
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3211
    tst x9, #1
    b.eq do_concat_3210
    tst x0, #1
    b.ne do_compose_3208
do_apply_3209:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3212
do_compose_3208:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3212
do_concat_3210:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3212
id_morphism_3211:
    b apply_end_3212
apply_end_3212:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3201
    mov x0, #1
    b cond_end_3202
cond_false_3201:
    adr x0, sign_id
cond_end_3202:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3176
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3218
    tst x9, #1
    b.eq do_concat_3217
    tst x0, #1
    b.ne do_compose_3215
do_apply_3216:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3219
do_compose_3215:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3219
do_concat_3217:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3219
id_morphism_3218:
    b apply_end_3219
apply_end_3219:
    str x0, [sp, #-16]!
    mov x0, #64
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3223
    tst x9, #1
    b.eq do_concat_3222
    tst x0, #1
    b.ne do_compose_3220
do_apply_3221:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3224
do_compose_3220:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3224
do_concat_3222:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3224
id_morphism_3223:
    b apply_end_3224
apply_end_3224:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3213
    mov x0, #1
    b cond_end_3214
cond_false_3213:
    adr x0, sign_id
cond_end_3214:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3176
    mov x0, #0
blk_end_3176:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3174_3175:
    // Closure for func_3174
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3174
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3168
cond_false_3167:
    adr x0, sign_id
cond_end_3168:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_primary
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3230
    tst x9, #1
    b.eq do_concat_3229
    tst x0, #1
    b.ne do_compose_3227
do_apply_3228:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3231
do_compose_3227:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3231
do_concat_3229:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3231
id_morphism_3230:
    b apply_end_3231
apply_end_3231:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3225
    b after_func_3232_3233
func_3232:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3235_3236
func_3235:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3235_3236:
    // Closure for func_3235
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3235
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3238_3239
func_3238:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3238_3239:
    // Closure for func_3238
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3238
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3241_3242
func_3241:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3241_3242:
    // Closure for func_3241
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3241
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3246
    adr x0, sign_id
    b cmp_end_3247
cmp_true_3246:
cmp_end_3247:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3244
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_3249_3250
func_3249:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3249_3250:
    // Closure for func_3249
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3249
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3254
    tst x9, #1
    b.eq do_concat_3253
    tst x0, #1
    b.ne do_compose_3251
do_apply_3252:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3255
do_compose_3251:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3255
do_concat_3253:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3255
id_morphism_3254:
    b apply_end_3255
apply_end_3255:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3259
    tst x9, #1
    b.eq do_concat_3258
    tst x0, #1
    b.ne do_compose_3256
do_apply_3257:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3260
do_compose_3256:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3260
do_concat_3258:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3260
id_morphism_3259:
    b apply_end_3260
apply_end_3260:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3264
    tst x9, #1
    b.eq do_concat_3263
    tst x0, #1
    b.ne do_compose_3261
do_apply_3262:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3265
do_compose_3261:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3265
do_concat_3263:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3265
id_morphism_3264:
    b apply_end_3265
apply_end_3265:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3269
    tst x9, #1
    b.eq do_concat_3268
    tst x0, #1
    b.ne do_compose_3266
do_apply_3267:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3270
do_compose_3266:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3270
do_concat_3268:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3270
id_morphism_3269:
    b apply_end_3270
apply_end_3270:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3274
    tst x9, #1
    b.eq do_concat_3273
    tst x0, #1
    b.ne do_compose_3271
do_apply_3272:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3275
do_compose_3271:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3275
do_concat_3273:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3275
id_morphism_3274:
    b apply_end_3275
apply_end_3275:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3279
    tst x9, #1
    b.eq do_concat_3278
    tst x0, #1
    b.ne do_compose_3276
do_apply_3277:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3280
do_compose_3276:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3280
do_concat_3278:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3280
id_morphism_3279:
    b apply_end_3280
apply_end_3280:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3284
    tst x9, #1
    b.eq do_concat_3283
    tst x0, #1
    b.ne do_compose_3281
do_apply_3282:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3285
do_compose_3281:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3285
do_concat_3283:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3285
id_morphism_3284:
    b apply_end_3285
apply_end_3285:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3289
    tst x9, #1
    b.eq do_concat_3288
    tst x0, #1
    b.ne do_compose_3286
do_apply_3287:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3290
do_compose_3286:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3290
do_concat_3288:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3290
id_morphism_3289:
    b apply_end_3290
apply_end_3290:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3294
    tst x9, #1
    b.eq do_concat_3293
    tst x0, #1
    b.ne do_compose_3291
do_apply_3292:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3295
do_compose_3291:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3295
do_concat_3293:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3295
id_morphism_3294:
    b apply_end_3295
apply_end_3295:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3248
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3299
    tst x9, #1
    b.eq do_concat_3298
    tst x0, #1
    b.ne do_compose_3296
do_apply_3297:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3300
do_compose_3296:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3300
do_concat_3298:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3300
id_morphism_3299:
    b apply_end_3300
apply_end_3300:
blk_end_3248:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3304
    tst x9, #1
    b.eq do_concat_3303
    tst x0, #1
    b.ne do_compose_3301
do_apply_3302:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3305
do_compose_3301:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3305
do_concat_3303:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3305
id_morphism_3304:
    b apply_end_3305
apply_end_3305:
    b cond_end_3245
cond_false_3244:
    adr x0, sign_id
cond_end_3245:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3243
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3308
    adr x0, sign_id
    b cmp_end_3309
cmp_true_3308:
cmp_end_3309:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3306
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_3311_3312
func_3311:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3311_3312:
    // Closure for func_3311
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3311
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3316
    tst x9, #1
    b.eq do_concat_3315
    tst x0, #1
    b.ne do_compose_3313
do_apply_3314:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3317
do_compose_3313:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3317
do_concat_3315:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3317
id_morphism_3316:
    b apply_end_3317
apply_end_3317:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3321
    tst x9, #1
    b.eq do_concat_3320
    tst x0, #1
    b.ne do_compose_3318
do_apply_3319:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3322
do_compose_3318:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3322
do_concat_3320:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3322
id_morphism_3321:
    b apply_end_3322
apply_end_3322:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3326
    tst x9, #1
    b.eq do_concat_3325
    tst x0, #1
    b.ne do_compose_3323
do_apply_3324:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3327
do_compose_3323:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3327
do_concat_3325:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3327
id_morphism_3326:
    b apply_end_3327
apply_end_3327:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3331
    tst x9, #1
    b.eq do_concat_3330
    tst x0, #1
    b.ne do_compose_3328
do_apply_3329:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3332
do_compose_3328:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3332
do_concat_3330:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3332
id_morphism_3331:
    b apply_end_3332
apply_end_3332:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3336
    tst x9, #1
    b.eq do_concat_3335
    tst x0, #1
    b.ne do_compose_3333
do_apply_3334:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3337
do_compose_3333:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3337
do_concat_3335:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3337
id_morphism_3336:
    b apply_end_3337
apply_end_3337:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3341
    tst x9, #1
    b.eq do_concat_3340
    tst x0, #1
    b.ne do_compose_3338
do_apply_3339:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3342
do_compose_3338:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3342
do_concat_3340:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3342
id_morphism_3341:
    b apply_end_3342
apply_end_3342:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3346
    tst x9, #1
    b.eq do_concat_3345
    tst x0, #1
    b.ne do_compose_3343
do_apply_3344:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3347
do_compose_3343:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3347
do_concat_3345:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3347
id_morphism_3346:
    b apply_end_3347
apply_end_3347:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3351
    tst x9, #1
    b.eq do_concat_3350
    tst x0, #1
    b.ne do_compose_3348
do_apply_3349:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3352
do_compose_3348:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3352
do_concat_3350:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3352
id_morphism_3351:
    b apply_end_3352
apply_end_3352:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3356
    tst x9, #1
    b.eq do_concat_3355
    tst x0, #1
    b.ne do_compose_3353
do_apply_3354:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3357
do_compose_3353:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3357
do_concat_3355:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3357
id_morphism_3356:
    b apply_end_3357
apply_end_3357:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3310
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3361
    tst x9, #1
    b.eq do_concat_3360
    tst x0, #1
    b.ne do_compose_3358
do_apply_3359:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3362
do_compose_3358:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3362
do_concat_3360:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3362
id_morphism_3361:
    b apply_end_3362
apply_end_3362:
blk_end_3310:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3366
    tst x9, #1
    b.eq do_concat_3365
    tst x0, #1
    b.ne do_compose_3363
do_apply_3364:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3367
do_compose_3363:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3367
do_concat_3365:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3367
id_morphism_3366:
    b apply_end_3367
apply_end_3367:
    b cond_end_3307
cond_false_3306:
    adr x0, sign_id
cond_end_3307:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3243
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3370
    adr x0, sign_id
    b cmp_end_3371
cmp_true_3370:
cmp_end_3371:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3368
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_3373_3374
func_3373:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3373_3374:
    // Closure for func_3373
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3373
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3378
    tst x9, #1
    b.eq do_concat_3377
    tst x0, #1
    b.ne do_compose_3375
do_apply_3376:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3379
do_compose_3375:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3379
do_concat_3377:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3379
id_morphism_3378:
    b apply_end_3379
apply_end_3379:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3383
    tst x9, #1
    b.eq do_concat_3382
    tst x0, #1
    b.ne do_compose_3380
do_apply_3381:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3384
do_compose_3380:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3384
do_concat_3382:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3384
id_morphism_3383:
    b apply_end_3384
apply_end_3384:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3388
    tst x9, #1
    b.eq do_concat_3387
    tst x0, #1
    b.ne do_compose_3385
do_apply_3386:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3389
do_compose_3385:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3389
do_concat_3387:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3389
id_morphism_3388:
    b apply_end_3389
apply_end_3389:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3393
    tst x9, #1
    b.eq do_concat_3392
    tst x0, #1
    b.ne do_compose_3390
do_apply_3391:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3394
do_compose_3390:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3394
do_concat_3392:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3394
id_morphism_3393:
    b apply_end_3394
apply_end_3394:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3398
    tst x9, #1
    b.eq do_concat_3397
    tst x0, #1
    b.ne do_compose_3395
do_apply_3396:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3399
do_compose_3395:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3399
do_concat_3397:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3399
id_morphism_3398:
    b apply_end_3399
apply_end_3399:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3403
    tst x9, #1
    b.eq do_concat_3402
    tst x0, #1
    b.ne do_compose_3400
do_apply_3401:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3404
do_compose_3400:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3404
do_concat_3402:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3404
id_morphism_3403:
    b apply_end_3404
apply_end_3404:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3408
    tst x9, #1
    b.eq do_concat_3407
    tst x0, #1
    b.ne do_compose_3405
do_apply_3406:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3409
do_compose_3405:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3409
do_concat_3407:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3409
id_morphism_3408:
    b apply_end_3409
apply_end_3409:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3413
    tst x9, #1
    b.eq do_concat_3412
    tst x0, #1
    b.ne do_compose_3410
do_apply_3411:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3414
do_compose_3410:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3414
do_concat_3412:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3414
id_morphism_3413:
    b apply_end_3414
apply_end_3414:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3418
    tst x9, #1
    b.eq do_concat_3417
    tst x0, #1
    b.ne do_compose_3415
do_apply_3416:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3419
do_compose_3415:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3419
do_concat_3417:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3419
id_morphism_3418:
    b apply_end_3419
apply_end_3419:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3372
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3423
    tst x9, #1
    b.eq do_concat_3422
    tst x0, #1
    b.ne do_compose_3420
do_apply_3421:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3424
do_compose_3420:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3424
do_concat_3422:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3424
id_morphism_3423:
    b apply_end_3424
apply_end_3424:
blk_end_3372:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3428
    tst x9, #1
    b.eq do_concat_3427
    tst x0, #1
    b.ne do_compose_3425
do_apply_3426:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3429
do_compose_3425:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3429
do_concat_3427:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3429
id_morphism_3428:
    b apply_end_3429
apply_end_3429:
    b cond_end_3369
cond_false_3368:
    adr x0, sign_id
cond_end_3369:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3243
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3432
    adr x0, sign_id
    b cmp_end_3433
cmp_true_3432:
cmp_end_3433:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3430
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_3435_3436
func_3435:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3435_3436:
    // Closure for func_3435
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3435
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, is_prefix_op
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3443
    tst x9, #1
    b.eq do_concat_3442
    tst x0, #1
    b.ne do_compose_3440
do_apply_3441:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3444
do_compose_3440:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3444
do_concat_3442:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3444
id_morphism_3443:
    b apply_end_3444
apply_end_3444:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3438
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_14
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3445
    b after_func_3446_3447
func_3446:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3446_3447:
    // Closure for func_3446
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3446
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_prefix
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3451
    tst x9, #1
    b.eq do_concat_3450
    tst x0, #1
    b.ne do_compose_3448
do_apply_3449:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3452
do_compose_3448:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3452
do_concat_3450:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3452
id_morphism_3451:
    b apply_end_3452
apply_end_3452:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3456
    tst x9, #1
    b.eq do_concat_3455
    tst x0, #1
    b.ne do_compose_3453
do_apply_3454:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3457
do_compose_3453:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3457
do_concat_3455:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3457
id_morphism_3456:
    b apply_end_3457
apply_end_3457:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3461
    tst x9, #1
    b.eq do_concat_3460
    tst x0, #1
    b.ne do_compose_3458
do_apply_3459:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3462
do_compose_3458:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3462
do_concat_3460:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3462
id_morphism_3461:
    b apply_end_3462
apply_end_3462:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3466
    tst x9, #1
    b.eq do_concat_3465
    tst x0, #1
    b.ne do_compose_3463
do_apply_3464:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3467
do_compose_3463:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3467
do_concat_3465:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3467
id_morphism_3466:
    b apply_end_3467
apply_end_3467:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3471
    tst x9, #1
    b.eq do_concat_3470
    tst x0, #1
    b.ne do_compose_3468
do_apply_3469:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3472
do_compose_3468:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3472
do_concat_3470:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3472
id_morphism_3471:
    b apply_end_3472
apply_end_3472:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3476
    tst x9, #1
    b.eq do_concat_3475
    tst x0, #1
    b.ne do_compose_3473
do_apply_3474:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3477
do_compose_3473:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3477
do_concat_3475:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3477
id_morphism_3476:
    b apply_end_3477
apply_end_3477:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3481
    tst x9, #1
    b.eq do_concat_3480
    tst x0, #1
    b.ne do_compose_3478
do_apply_3479:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3482
do_compose_3478:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3482
do_concat_3480:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3482
id_morphism_3481:
    b apply_end_3482
apply_end_3482:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3486
    tst x9, #1
    b.eq do_concat_3485
    tst x0, #1
    b.ne do_compose_3483
do_apply_3484:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3487
do_compose_3483:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3487
do_concat_3485:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3487
id_morphism_3486:
    b apply_end_3487
apply_end_3487:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3491
    tst x9, #1
    b.eq do_concat_3490
    tst x0, #1
    b.ne do_compose_3488
do_apply_3489:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3492
do_compose_3488:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3492
do_concat_3490:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3492
id_morphism_3491:
    b apply_end_3492
apply_end_3492:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3496
    tst x9, #1
    b.eq do_concat_3495
    tst x0, #1
    b.ne do_compose_3493
do_apply_3494:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3497
do_compose_3493:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3497
do_concat_3495:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3497
id_morphism_3496:
    b apply_end_3497
apply_end_3497:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3501
    tst x9, #1
    b.eq do_concat_3500
    tst x0, #1
    b.ne do_compose_3498
do_apply_3499:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3502
do_compose_3498:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3502
do_concat_3500:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3502
id_morphism_3501:
    b apply_end_3502
apply_end_3502:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3506
    tst x9, #1
    b.eq do_concat_3505
    tst x0, #1
    b.ne do_compose_3503
do_apply_3504:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3507
do_compose_3503:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3507
do_concat_3505:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3507
id_morphism_3506:
    b apply_end_3507
apply_end_3507:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3511
    tst x9, #1
    b.eq do_concat_3510
    tst x0, #1
    b.ne do_compose_3508
do_apply_3509:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3512
do_compose_3508:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3512
do_concat_3510:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3512
id_morphism_3511:
    b apply_end_3512
apply_end_3512:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3516
    tst x9, #1
    b.eq do_concat_3515
    tst x0, #1
    b.ne do_compose_3513
do_apply_3514:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3517
do_compose_3513:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3517
do_concat_3515:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3517
id_morphism_3516:
    b apply_end_3517
apply_end_3517:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3445
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3521
    tst x9, #1
    b.eq do_concat_3520
    tst x0, #1
    b.ne do_compose_3518
do_apply_3519:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3522
do_compose_3518:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3522
do_concat_3520:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3522
id_morphism_3521:
    b apply_end_3522
apply_end_3522:
    str x0, [sp, #-16]!
    mov x0, #20
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3526
    tst x9, #1
    b.eq do_concat_3525
    tst x0, #1
    b.ne do_compose_3523
do_apply_3524:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3527
do_compose_3523:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3527
do_concat_3525:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3527
id_morphism_3526:
    b apply_end_3527
apply_end_3527:
    str x0, [sp, #-16]!
    adr x0, str_15
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3531
    tst x9, #1
    b.eq do_concat_3530
    tst x0, #1
    b.ne do_compose_3528
do_apply_3529:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3532
do_compose_3528:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3532
do_concat_3530:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3532
id_morphism_3531:
    b apply_end_3532
apply_end_3532:
blk_end_3445:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3536
    tst x9, #1
    b.eq do_concat_3535
    tst x0, #1
    b.ne do_compose_3533
do_apply_3534:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3537
do_compose_3533:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3537
do_concat_3535:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3537
id_morphism_3536:
    b apply_end_3537
apply_end_3537:
    b cond_end_3439
cond_false_3438:
    adr x0, sign_id
cond_end_3439:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3437
    adr x0, str_16
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3437
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3541
    tst x9, #1
    b.eq do_concat_3540
    tst x0, #1
    b.ne do_compose_3538
do_apply_3539:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3542
do_compose_3538:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3542
do_concat_3540:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3542
id_morphism_3541:
    b apply_end_3542
apply_end_3542:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3546
    tst x9, #1
    b.eq do_concat_3545
    tst x0, #1
    b.ne do_compose_3543
do_apply_3544:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3547
do_compose_3543:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3547
do_concat_3545:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3547
id_morphism_3546:
    b apply_end_3547
apply_end_3547:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3551
    tst x9, #1
    b.eq do_concat_3550
    tst x0, #1
    b.ne do_compose_3548
do_apply_3549:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3552
do_compose_3548:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3552
do_concat_3550:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3552
id_morphism_3551:
    b apply_end_3552
apply_end_3552:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3556
    tst x9, #1
    b.eq do_concat_3555
    tst x0, #1
    b.ne do_compose_3553
do_apply_3554:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3557
do_compose_3553:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3557
do_concat_3555:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3557
id_morphism_3556:
    b apply_end_3557
apply_end_3557:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3561
    tst x9, #1
    b.eq do_concat_3560
    tst x0, #1
    b.ne do_compose_3558
do_apply_3559:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3562
do_compose_3558:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3562
do_concat_3560:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3562
id_morphism_3561:
    b apply_end_3562
apply_end_3562:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3566
    tst x9, #1
    b.eq do_concat_3565
    tst x0, #1
    b.ne do_compose_3563
do_apply_3564:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3567
do_compose_3563:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3567
do_concat_3565:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3567
id_morphism_3566:
    b apply_end_3567
apply_end_3567:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3571
    tst x9, #1
    b.eq do_concat_3570
    tst x0, #1
    b.ne do_compose_3568
do_apply_3569:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3572
do_compose_3568:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3572
do_concat_3570:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3572
id_morphism_3571:
    b apply_end_3572
apply_end_3572:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3576
    tst x9, #1
    b.eq do_concat_3575
    tst x0, #1
    b.ne do_compose_3573
do_apply_3574:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3577
do_compose_3573:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3577
do_concat_3575:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3577
id_morphism_3576:
    b apply_end_3577
apply_end_3577:
blk_end_3437:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3581
    tst x9, #1
    b.eq do_concat_3580
    tst x0, #1
    b.ne do_compose_3578
do_apply_3579:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3582
do_compose_3578:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3582
do_concat_3580:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3582
id_morphism_3581:
    b apply_end_3582
apply_end_3582:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3434
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3586
    tst x9, #1
    b.eq do_concat_3585
    tst x0, #1
    b.ne do_compose_3583
do_apply_3584:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3587
do_compose_3583:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3587
do_concat_3585:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3587
id_morphism_3586:
    b apply_end_3587
apply_end_3587:
blk_end_3434:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3591
    tst x9, #1
    b.eq do_concat_3590
    tst x0, #1
    b.ne do_compose_3588
do_apply_3589:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3592
do_compose_3588:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3592
do_concat_3590:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3592
id_morphism_3591:
    b apply_end_3592
apply_end_3592:
    b cond_end_3431
cond_false_3430:
    adr x0, sign_id
cond_end_3431:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3243
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3595
    adr x0, sign_id
    b cmp_end_3596
cmp_true_3595:
cmp_end_3596:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3593
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_3598_3599
func_3598:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3598_3599:
    // Closure for func_3598
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3598
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, val
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3603
    adr x0, sign_id
    b cmp_end_3604
cmp_true_3603:
cmp_end_3604:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3601
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_17
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3605
    adr x0, parse_block
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3609
    tst x9, #1
    b.eq do_concat_3608
    tst x0, #1
    b.ne do_compose_3606
do_apply_3607:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3610
do_compose_3606:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3610
do_concat_3608:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3610
id_morphism_3609:
    b apply_end_3610
apply_end_3610:
blk_end_3605:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3614
    tst x9, #1
    b.eq do_concat_3613
    tst x0, #1
    b.ne do_compose_3611
do_apply_3612:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3615
do_compose_3611:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3615
do_concat_3613:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3615
id_morphism_3614:
    b apply_end_3615
apply_end_3615:
    b cond_end_3602
cond_false_3601:
    adr x0, sign_id
cond_end_3602:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3600
    adr x0, val
    str x0, [sp, #-16]!
    mov x0, #40
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3618
    adr x0, sign_id
    b cmp_end_3619
cmp_true_3618:
cmp_end_3619:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3616
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_18
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3620
    b after_func_3621_3622
func_3621:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3621_3622:
    // Closure for func_3621
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3621
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3624_3625
func_3624:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3624_3625:
    // Closure for func_3624
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3624
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3627_3628
func_3627:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3627_3628:
    // Closure for func_3627
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3627
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_19
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3629
    b after_func_3630_3631
func_3630:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3630_3631:
    // Closure for func_3630
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3630
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_20
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3632
    adr x0, str_21
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3632
    b after_func_3633_3634
func_3633:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3633_3634:
    // Closure for func_3633
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3633
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3639
    tst x9, #1
    b.eq do_concat_3638
    tst x0, #1
    b.ne do_compose_3636
do_apply_3637:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3640
do_compose_3636:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3640
do_concat_3638:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3640
id_morphism_3639:
    b apply_end_3640
apply_end_3640:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3644
    tst x9, #1
    b.eq do_concat_3643
    tst x0, #1
    b.ne do_compose_3641
do_apply_3642:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3645
do_compose_3641:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3645
do_concat_3643:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3645
id_morphism_3644:
    b apply_end_3645
apply_end_3645:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3649
    tst x9, #1
    b.eq do_concat_3648
    tst x0, #1
    b.ne do_compose_3646
do_apply_3647:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3650
do_compose_3646:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3650
do_concat_3648:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3650
id_morphism_3649:
    b apply_end_3650
apply_end_3650:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3654
    tst x9, #1
    b.eq do_concat_3653
    tst x0, #1
    b.ne do_compose_3651
do_apply_3652:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3655
do_compose_3651:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3655
do_concat_3653:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3655
id_morphism_3654:
    b apply_end_3655
apply_end_3655:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3659
    tst x9, #1
    b.eq do_concat_3658
    tst x0, #1
    b.ne do_compose_3656
do_apply_3657:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3660
do_compose_3656:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3660
do_concat_3658:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3660
id_morphism_3659:
    b apply_end_3660
apply_end_3660:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3664
    tst x9, #1
    b.eq do_concat_3663
    tst x0, #1
    b.ne do_compose_3661
do_apply_3662:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3665
do_compose_3661:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3665
do_concat_3663:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3665
id_morphism_3664:
    b apply_end_3665
apply_end_3665:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3635
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3669
    tst x9, #1
    b.eq do_concat_3668
    tst x0, #1
    b.ne do_compose_3666
do_apply_3667:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3670
do_compose_3666:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3670
do_concat_3668:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3670
id_morphism_3669:
    b apply_end_3670
apply_end_3670:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3674
    tst x9, #1
    b.eq do_concat_3673
    tst x0, #1
    b.ne do_compose_3671
do_apply_3672:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3675
do_compose_3671:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3675
do_concat_3673:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3675
id_morphism_3674:
    b apply_end_3675
apply_end_3675:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3679
    tst x9, #1
    b.eq do_concat_3678
    tst x0, #1
    b.ne do_compose_3676
do_apply_3677:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3680
do_compose_3676:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3680
do_concat_3678:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3680
id_morphism_3679:
    b apply_end_3680
apply_end_3680:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3684
    tst x9, #1
    b.eq do_concat_3683
    tst x0, #1
    b.ne do_compose_3681
do_apply_3682:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3685
do_compose_3681:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3685
do_concat_3683:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3685
id_morphism_3684:
    b apply_end_3685
apply_end_3685:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3689
    tst x9, #1
    b.eq do_concat_3688
    tst x0, #1
    b.ne do_compose_3686
do_apply_3687:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3690
do_compose_3686:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3690
do_concat_3688:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3690
id_morphism_3689:
    b apply_end_3690
apply_end_3690:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3694
    tst x9, #1
    b.eq do_concat_3693
    tst x0, #1
    b.ne do_compose_3691
do_apply_3692:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3695
do_compose_3691:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3695
do_concat_3693:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3695
id_morphism_3694:
    b apply_end_3695
apply_end_3695:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3699
    tst x9, #1
    b.eq do_concat_3698
    tst x0, #1
    b.ne do_compose_3696
do_apply_3697:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3700
do_compose_3696:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3700
do_concat_3698:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3700
id_morphism_3699:
    b apply_end_3700
apply_end_3700:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3704
    tst x9, #1
    b.eq do_concat_3703
    tst x0, #1
    b.ne do_compose_3701
do_apply_3702:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3705
do_compose_3701:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3705
do_concat_3703:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3705
id_morphism_3704:
    b apply_end_3705
apply_end_3705:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3709
    tst x9, #1
    b.eq do_concat_3708
    tst x0, #1
    b.ne do_compose_3706
do_apply_3707:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3710
do_compose_3706:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3710
do_concat_3708:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3710
id_morphism_3709:
    b apply_end_3710
apply_end_3710:
blk_end_3635:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3714
    tst x9, #1
    b.eq do_concat_3713
    tst x0, #1
    b.ne do_compose_3711
do_apply_3712:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3715
do_compose_3711:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3715
do_concat_3713:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3715
id_morphism_3714:
    b apply_end_3715
apply_end_3715:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3632
    adr x0, is_null
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3719
    tst x9, #1
    b.eq do_concat_3718
    tst x0, #1
    b.ne do_compose_3716
do_apply_3717:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3720
do_compose_3716:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3720
do_concat_3718:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3720
id_morphism_3719:
    b apply_end_3720
apply_end_3720:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3724
    tst x9, #1
    b.eq do_concat_3723
    tst x0, #1
    b.ne do_compose_3721
do_apply_3722:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3725
do_compose_3721:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3725
do_concat_3723:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3725
id_morphism_3724:
    b apply_end_3725
apply_end_3725:
blk_end_3632:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3729
    tst x9, #1
    b.eq do_concat_3728
    tst x0, #1
    b.ne do_compose_3726
do_apply_3727:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3730
do_compose_3726:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3730
do_concat_3728:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3730
id_morphism_3729:
    b apply_end_3730
apply_end_3730:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3629
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3734
    tst x9, #1
    b.eq do_concat_3733
    tst x0, #1
    b.ne do_compose_3731
do_apply_3732:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3735
do_compose_3731:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3735
do_concat_3733:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3735
id_morphism_3734:
    b apply_end_3735
apply_end_3735:
blk_end_3629:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3739
    tst x9, #1
    b.eq do_concat_3738
    tst x0, #1
    b.ne do_compose_3736
do_apply_3737:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3740
do_compose_3736:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3740
do_concat_3738:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3740
id_morphism_3739:
    b apply_end_3740
apply_end_3740:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3626
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3744
    tst x9, #1
    b.eq do_concat_3743
    tst x0, #1
    b.ne do_compose_3741
do_apply_3742:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3745
do_compose_3741:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3745
do_concat_3743:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3745
id_morphism_3744:
    b apply_end_3745
apply_end_3745:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3749
    tst x9, #1
    b.eq do_concat_3748
    tst x0, #1
    b.ne do_compose_3746
do_apply_3747:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3750
do_compose_3746:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3750
do_concat_3748:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3750
id_morphism_3749:
    b apply_end_3750
apply_end_3750:
blk_end_3626:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3754
    tst x9, #1
    b.eq do_concat_3753
    tst x0, #1
    b.ne do_compose_3751
do_apply_3752:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3755
do_compose_3751:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3755
do_concat_3753:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3755
id_morphism_3754:
    b apply_end_3755
apply_end_3755:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3623
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3759
    tst x9, #1
    b.eq do_concat_3758
    tst x0, #1
    b.ne do_compose_3756
do_apply_3757:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3760
do_compose_3756:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3760
do_concat_3758:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3760
id_morphism_3759:
    b apply_end_3760
apply_end_3760:
blk_end_3623:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3764
    tst x9, #1
    b.eq do_concat_3763
    tst x0, #1
    b.ne do_compose_3761
do_apply_3762:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3765
do_compose_3761:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3765
do_concat_3763:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3765
id_morphism_3764:
    b apply_end_3765
apply_end_3765:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3620
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3769
    tst x9, #1
    b.eq do_concat_3768
    tst x0, #1
    b.ne do_compose_3766
do_apply_3767:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3770
do_compose_3766:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3770
do_concat_3768:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3770
id_morphism_3769:
    b apply_end_3770
apply_end_3770:
blk_end_3620:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3774
    tst x9, #1
    b.eq do_concat_3773
    tst x0, #1
    b.ne do_compose_3771
do_apply_3772:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3775
do_compose_3771:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3775
do_concat_3773:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3775
id_morphism_3774:
    b apply_end_3775
apply_end_3775:
    b cond_end_3617
cond_false_3616:
    adr x0, sign_id
cond_end_3617:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3600
    adr x0, str_22
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3600
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3779
    tst x9, #1
    b.eq do_concat_3778
    tst x0, #1
    b.ne do_compose_3776
do_apply_3777:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3780
do_compose_3776:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3780
do_concat_3778:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3780
id_morphism_3779:
    b apply_end_3780
apply_end_3780:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3784
    tst x9, #1
    b.eq do_concat_3783
    tst x0, #1
    b.ne do_compose_3781
do_apply_3782:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3785
do_compose_3781:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3785
do_concat_3783:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3785
id_morphism_3784:
    b apply_end_3785
apply_end_3785:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3789
    tst x9, #1
    b.eq do_concat_3788
    tst x0, #1
    b.ne do_compose_3786
do_apply_3787:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3790
do_compose_3786:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3790
do_concat_3788:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3790
id_morphism_3789:
    b apply_end_3790
apply_end_3790:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3794
    tst x9, #1
    b.eq do_concat_3793
    tst x0, #1
    b.ne do_compose_3791
do_apply_3792:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3795
do_compose_3791:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3795
do_concat_3793:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3795
id_morphism_3794:
    b apply_end_3795
apply_end_3795:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3799
    tst x9, #1
    b.eq do_concat_3798
    tst x0, #1
    b.ne do_compose_3796
do_apply_3797:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3800
do_compose_3796:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3800
do_concat_3798:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3800
id_morphism_3799:
    b apply_end_3800
apply_end_3800:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3804
    tst x9, #1
    b.eq do_concat_3803
    tst x0, #1
    b.ne do_compose_3801
do_apply_3802:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3805
do_compose_3801:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3805
do_concat_3803:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3805
id_morphism_3804:
    b apply_end_3805
apply_end_3805:
blk_end_3600:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3809
    tst x9, #1
    b.eq do_concat_3808
    tst x0, #1
    b.ne do_compose_3806
do_apply_3807:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3810
do_compose_3806:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3810
do_concat_3808:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3810
id_morphism_3809:
    b apply_end_3810
apply_end_3810:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3597
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3814
    tst x9, #1
    b.eq do_concat_3813
    tst x0, #1
    b.ne do_compose_3811
do_apply_3812:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3815
do_compose_3811:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3815
do_concat_3813:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3815
id_morphism_3814:
    b apply_end_3815
apply_end_3815:
blk_end_3597:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3819
    tst x9, #1
    b.eq do_concat_3818
    tst x0, #1
    b.ne do_compose_3816
do_apply_3817:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3820
do_compose_3816:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3820
do_concat_3818:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3820
id_morphism_3819:
    b apply_end_3820
apply_end_3820:
    b cond_end_3594
cond_false_3593:
    adr x0, sign_id
cond_end_3594:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3243
    adr x0, str_23
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3243
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3824
    tst x9, #1
    b.eq do_concat_3823
    tst x0, #1
    b.ne do_compose_3821
do_apply_3822:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3825
do_compose_3821:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3825
do_concat_3823:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3825
id_morphism_3824:
    b apply_end_3825
apply_end_3825:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3829
    tst x9, #1
    b.eq do_concat_3828
    tst x0, #1
    b.ne do_compose_3826
do_apply_3827:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3830
do_compose_3826:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3830
do_concat_3828:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3830
id_morphism_3829:
    b apply_end_3830
apply_end_3830:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3834
    tst x9, #1
    b.eq do_concat_3833
    tst x0, #1
    b.ne do_compose_3831
do_apply_3832:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3835
do_compose_3831:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3835
do_concat_3833:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3835
id_morphism_3834:
    b apply_end_3835
apply_end_3835:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3839
    tst x9, #1
    b.eq do_concat_3838
    tst x0, #1
    b.ne do_compose_3836
do_apply_3837:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3840
do_compose_3836:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3840
do_concat_3838:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3840
id_morphism_3839:
    b apply_end_3840
apply_end_3840:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3844
    tst x9, #1
    b.eq do_concat_3843
    tst x0, #1
    b.ne do_compose_3841
do_apply_3842:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3845
do_compose_3841:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3845
do_concat_3843:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3845
id_morphism_3844:
    b apply_end_3845
apply_end_3845:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3849
    tst x9, #1
    b.eq do_concat_3848
    tst x0, #1
    b.ne do_compose_3846
do_apply_3847:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3850
do_compose_3846:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3850
do_concat_3848:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3850
id_morphism_3849:
    b apply_end_3850
apply_end_3850:
blk_end_3243:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3854
    tst x9, #1
    b.eq do_concat_3853
    tst x0, #1
    b.ne do_compose_3851
do_apply_3852:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3855
do_compose_3851:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3855
do_concat_3853:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3855
id_morphism_3854:
    b apply_end_3855
apply_end_3855:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3240
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3859
    tst x9, #1
    b.eq do_concat_3858
    tst x0, #1
    b.ne do_compose_3856
do_apply_3857:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3860
do_compose_3856:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3860
do_concat_3858:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3860
id_morphism_3859:
    b apply_end_3860
apply_end_3860:
blk_end_3240:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3864
    tst x9, #1
    b.eq do_concat_3863
    tst x0, #1
    b.ne do_compose_3861
do_apply_3862:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3865
do_compose_3861:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3865
do_concat_3863:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3865
id_morphism_3864:
    b apply_end_3865
apply_end_3865:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3237
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3869
    tst x9, #1
    b.eq do_concat_3868
    tst x0, #1
    b.ne do_compose_3866
do_apply_3867:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3870
do_compose_3866:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3870
do_concat_3868:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3870
id_morphism_3869:
    b apply_end_3870
apply_end_3870:
blk_end_3237:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3874
    tst x9, #1
    b.eq do_concat_3873
    tst x0, #1
    b.ne do_compose_3871
do_apply_3872:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3875
do_compose_3871:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3875
do_concat_3873:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3875
id_morphism_3874:
    b apply_end_3875
apply_end_3875:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3234
    adr x0, peek
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3879
    tst x9, #1
    b.eq do_concat_3878
    tst x0, #1
    b.ne do_compose_3876
do_apply_3877:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3880
do_compose_3876:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3880
do_concat_3878:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3880
id_morphism_3879:
    b apply_end_3880
apply_end_3880:
blk_end_3234:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3232_3233:
    // Closure for func_3232
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3232
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3226
cond_false_3225:
    adr x0, sign_id
cond_end_3226:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3886
    tst x9, #1
    b.eq do_concat_3885
    tst x0, #1
    b.ne do_compose_3883
do_apply_3884:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3887
do_compose_3883:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3887
do_concat_3885:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3887
id_morphism_3886:
    b apply_end_3887
apply_end_3887:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3881
    b after_func_3888_3889
func_3888:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3891_3892
func_3891:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3891_3892:
    // Closure for func_3891
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3891
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3894_3895
func_3894:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3894_3895:
    // Closure for func_3894
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3894
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3897_3898
func_3897:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3897_3898:
    // Closure for func_3897
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3897
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_24
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3899
    b after_func_3900_3901
func_3900:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3900_3901:
    // Closure for func_3900
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3900
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_25
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3902
    b after_func_3903_3904
func_3903:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3903_3904:
    // Closure for func_3903
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3903
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, node
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3908
    tst x9, #1
    b.eq do_concat_3907
    tst x0, #1
    b.ne do_compose_3905
do_apply_3906:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3909
do_compose_3905:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3909
do_concat_3907:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3909
id_morphism_3908:
    b apply_end_3909
apply_end_3909:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3913
    tst x9, #1
    b.eq do_concat_3912
    tst x0, #1
    b.ne do_compose_3910
do_apply_3911:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3914
do_compose_3910:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3914
do_concat_3912:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3914
id_morphism_3913:
    b apply_end_3914
apply_end_3914:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3918
    tst x9, #1
    b.eq do_concat_3917
    tst x0, #1
    b.ne do_compose_3915
do_apply_3916:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3919
do_compose_3915:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3919
do_concat_3917:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3919
id_morphism_3918:
    b apply_end_3919
apply_end_3919:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3923
    tst x9, #1
    b.eq do_concat_3922
    tst x0, #1
    b.ne do_compose_3920
do_apply_3921:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3924
do_compose_3920:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3924
do_concat_3922:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3924
id_morphism_3923:
    b apply_end_3924
apply_end_3924:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3928
    tst x9, #1
    b.eq do_concat_3927
    tst x0, #1
    b.ne do_compose_3925
do_apply_3926:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3929
do_compose_3925:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3929
do_concat_3927:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3929
id_morphism_3928:
    b apply_end_3929
apply_end_3929:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3933
    tst x9, #1
    b.eq do_concat_3932
    tst x0, #1
    b.ne do_compose_3930
do_apply_3931:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3934
do_compose_3930:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3934
do_concat_3932:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3934
id_morphism_3933:
    b apply_end_3934
apply_end_3934:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3902
    adr x0, transform_section
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3938
    tst x9, #1
    b.eq do_concat_3937
    tst x0, #1
    b.ne do_compose_3935
do_apply_3936:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3939
do_compose_3935:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3939
do_concat_3937:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3939
id_morphism_3938:
    b apply_end_3939
apply_end_3939:
blk_end_3902:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3943
    tst x9, #1
    b.eq do_concat_3942
    tst x0, #1
    b.ne do_compose_3940
do_apply_3941:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3944
do_compose_3940:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3944
do_concat_3942:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3944
id_morphism_3943:
    b apply_end_3944
apply_end_3944:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3899
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3948
    tst x9, #1
    b.eq do_concat_3947
    tst x0, #1
    b.ne do_compose_3945
do_apply_3946:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3949
do_compose_3945:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3949
do_concat_3947:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3949
id_morphism_3948:
    b apply_end_3949
apply_end_3949:
blk_end_3899:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3953
    tst x9, #1
    b.eq do_concat_3952
    tst x0, #1
    b.ne do_compose_3950
do_apply_3951:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3954
do_compose_3950:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3954
do_concat_3952:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3954
id_morphism_3953:
    b apply_end_3954
apply_end_3954:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3896
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3958
    tst x9, #1
    b.eq do_concat_3957
    tst x0, #1
    b.ne do_compose_3955
do_apply_3956:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3959
do_compose_3955:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3959
do_concat_3957:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3959
id_morphism_3958:
    b apply_end_3959
apply_end_3959:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3963
    tst x9, #1
    b.eq do_concat_3962
    tst x0, #1
    b.ne do_compose_3960
do_apply_3961:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3964
do_compose_3960:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3964
do_concat_3962:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3964
id_morphism_3963:
    b apply_end_3964
apply_end_3964:
blk_end_3896:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3968
    tst x9, #1
    b.eq do_concat_3967
    tst x0, #1
    b.ne do_compose_3965
do_apply_3966:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3969
do_compose_3965:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3969
do_concat_3967:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3969
id_morphism_3968:
    b apply_end_3969
apply_end_3969:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3893
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3973
    tst x9, #1
    b.eq do_concat_3972
    tst x0, #1
    b.ne do_compose_3970
do_apply_3971:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3974
do_compose_3970:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3974
do_concat_3972:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3974
id_morphism_3973:
    b apply_end_3974
apply_end_3974:
blk_end_3893:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3978
    tst x9, #1
    b.eq do_concat_3977
    tst x0, #1
    b.ne do_compose_3975
do_apply_3976:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3979
do_compose_3975:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3979
do_concat_3977:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3979
id_morphism_3978:
    b apply_end_3979
apply_end_3979:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3890
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3983
    tst x9, #1
    b.eq do_concat_3982
    tst x0, #1
    b.ne do_compose_3980
do_apply_3981:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3984
do_compose_3980:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3984
do_concat_3982:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3984
id_morphism_3983:
    b apply_end_3984
apply_end_3984:
blk_end_3890:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3888_3889:
    // Closure for func_3888
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3888
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3882
cond_false_3881:
    adr x0, sign_id
cond_end_3882:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_null
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3990
    tst x9, #1
    b.eq do_concat_3989
    tst x0, #1
    b.ne do_compose_3987
do_apply_3988:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3991
do_compose_3987:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3991
do_concat_3989:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3991
id_morphism_3990:
    b apply_end_3991
apply_end_3991:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3985
    b after_func_3992_3993
func_3992:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3997
    adr x0, sign_id
    b cmp_end_3998
cmp_true_3997:
cmp_end_3998:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3995
    mov x0, #1
    b cond_end_3996
cond_false_3995:
    adr x0, sign_id
cond_end_3996:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3994
    mov x0, #0
blk_end_3994:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3992_3993:
    // Closure for func_3992
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3992
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3986
cond_false_3985:
    adr x0, sign_id
cond_end_3986:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_node
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4004
    tst x9, #1
    b.eq do_concat_4003
    tst x0, #1
    b.ne do_compose_4001
do_apply_4002:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4005
do_compose_4001:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4005
do_concat_4003:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4005
id_morphism_4004:
    b apply_end_4005
apply_end_4005:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3999
    b after_func_4006_4007
func_4006:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4008_4009
func_4008:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4013
    tst x9, #1
    b.eq do_concat_4012
    tst x0, #1
    b.ne do_compose_4010
do_apply_4011:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4014
do_compose_4010:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4014
do_concat_4012:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4014
id_morphism_4013:
    b apply_end_4014
apply_end_4014:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4018
    tst x9, #1
    b.eq do_concat_4017
    tst x0, #1
    b.ne do_compose_4015
do_apply_4016:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4019
do_compose_4015:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4019
do_concat_4017:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4019
id_morphism_4018:
    b apply_end_4019
apply_end_4019:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4023
    tst x9, #1
    b.eq do_concat_4022
    tst x0, #1
    b.ne do_compose_4020
do_apply_4021:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4024
do_compose_4020:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4024
do_concat_4022:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4024
id_morphism_4023:
    b apply_end_4024
apply_end_4024:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4028
    tst x9, #1
    b.eq do_concat_4027
    tst x0, #1
    b.ne do_compose_4025
do_apply_4026:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4029
do_compose_4025:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4029
do_concat_4027:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4029
id_morphism_4028:
    b apply_end_4029
apply_end_4029:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4008_4009:
    // Closure for func_4008
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4008
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4006_4007:
    // Closure for func_4006
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4006
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4000
cond_false_3999:
    adr x0, sign_id
cond_end_4000:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_num
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4035
    tst x9, #1
    b.eq do_concat_4034
    tst x0, #1
    b.ne do_compose_4032
do_apply_4033:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4036
do_compose_4032:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4036
do_concat_4034:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4036
id_morphism_4035:
    b apply_end_4036
apply_end_4036:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4030
    b after_func_4037_4038
func_4037:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4042
    tst x9, #1
    b.eq do_concat_4041
    tst x0, #1
    b.ne do_compose_4039
do_apply_4040:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4043
do_compose_4039:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4043
do_concat_4041:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4043
id_morphism_4042:
    b apply_end_4043
apply_end_4043:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4047
    tst x9, #1
    b.eq do_concat_4046
    tst x0, #1
    b.ne do_compose_4044
do_apply_4045:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4048
do_compose_4044:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4048
do_concat_4046:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4048
id_morphism_4047:
    b apply_end_4048
apply_end_4048:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4037_4038:
    // Closure for func_4037
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4037
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4031
cond_false_4030:
    adr x0, sign_id
cond_end_4031:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_id
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4054
    tst x9, #1
    b.eq do_concat_4053
    tst x0, #1
    b.ne do_compose_4051
do_apply_4052:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4055
do_compose_4051:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4055
do_concat_4053:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4055
id_morphism_4054:
    b apply_end_4055
apply_end_4055:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4049
    b after_func_4056_4057
func_4056:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4061
    tst x9, #1
    b.eq do_concat_4060
    tst x0, #1
    b.ne do_compose_4058
do_apply_4059:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4062
do_compose_4058:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4062
do_concat_4060:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4062
id_morphism_4061:
    b apply_end_4062
apply_end_4062:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4066
    tst x9, #1
    b.eq do_concat_4065
    tst x0, #1
    b.ne do_compose_4063
do_apply_4064:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4067
do_compose_4063:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4067
do_concat_4065:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4067
id_morphism_4066:
    b apply_end_4067
apply_end_4067:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4056_4057:
    // Closure for func_4056
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4056
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4050
cond_false_4049:
    adr x0, sign_id
cond_end_4050:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4073
    tst x9, #1
    b.eq do_concat_4072
    tst x0, #1
    b.ne do_compose_4070
do_apply_4071:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4074
do_compose_4070:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4074
do_concat_4072:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4074
id_morphism_4073:
    b apply_end_4074
apply_end_4074:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4068
    b after_func_4075_4076
func_4075:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4080
    tst x9, #1
    b.eq do_concat_4079
    tst x0, #1
    b.ne do_compose_4077
do_apply_4078:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4081
do_compose_4077:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4081
do_concat_4079:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4081
id_morphism_4080:
    b apply_end_4081
apply_end_4081:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4085
    tst x9, #1
    b.eq do_concat_4084
    tst x0, #1
    b.ne do_compose_4082
do_apply_4083:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4086
do_compose_4082:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4086
do_concat_4084:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4086
id_morphism_4085:
    b apply_end_4086
apply_end_4086:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4075_4076:
    // Closure for func_4075
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4075
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4069
cond_false_4068:
    adr x0, sign_id
cond_end_4069:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4092
    tst x9, #1
    b.eq do_concat_4091
    tst x0, #1
    b.ne do_compose_4089
do_apply_4090:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4093
do_compose_4089:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4093
do_concat_4091:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4093
id_morphism_4092:
    b apply_end_4093
apply_end_4093:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4087
    b after_func_4094_4095
func_4094:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4099
    tst x9, #1
    b.eq do_concat_4098
    tst x0, #1
    b.ne do_compose_4096
do_apply_4097:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4100
do_compose_4096:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4100
do_concat_4098:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4100
id_morphism_4099:
    b apply_end_4100
apply_end_4100:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4104
    tst x9, #1
    b.eq do_concat_4103
    tst x0, #1
    b.ne do_compose_4101
do_apply_4102:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4105
do_compose_4101:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4105
do_concat_4103:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4105
id_morphism_4104:
    b apply_end_4105
apply_end_4105:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4094_4095:
    // Closure for func_4094
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4094
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4088
cond_false_4087:
    adr x0, sign_id
cond_end_4088:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_infix
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4111
    tst x9, #1
    b.eq do_concat_4110
    tst x0, #1
    b.ne do_compose_4108
do_apply_4109:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4112
do_compose_4108:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4112
do_concat_4110:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4112
id_morphism_4111:
    b apply_end_4112
apply_end_4112:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4106
    b after_func_4113_4114
func_4113:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4115_4116
func_4115:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4117_4118
func_4117:
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4122
    tst x9, #1
    b.eq do_concat_4121
    tst x0, #1
    b.ne do_compose_4119
do_apply_4120:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4123
do_compose_4119:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4123
do_concat_4121:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4123
id_morphism_4122:
    b apply_end_4123
apply_end_4123:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4127
    tst x9, #1
    b.eq do_concat_4126
    tst x0, #1
    b.ne do_compose_4124
do_apply_4125:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4128
do_compose_4124:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4128
do_concat_4126:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4128
id_morphism_4127:
    b apply_end_4128
apply_end_4128:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4132
    tst x9, #1
    b.eq do_concat_4131
    tst x0, #1
    b.ne do_compose_4129
do_apply_4130:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4133
do_compose_4129:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4133
do_concat_4131:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4133
id_morphism_4132:
    b apply_end_4133
apply_end_4133:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4137
    tst x9, #1
    b.eq do_concat_4136
    tst x0, #1
    b.ne do_compose_4134
do_apply_4135:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4138
do_compose_4134:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4138
do_concat_4136:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4138
id_morphism_4137:
    b apply_end_4138
apply_end_4138:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4142
    tst x9, #1
    b.eq do_concat_4141
    tst x0, #1
    b.ne do_compose_4139
do_apply_4140:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4143
do_compose_4139:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4143
do_concat_4141:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4143
id_morphism_4142:
    b apply_end_4143
apply_end_4143:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4147
    tst x9, #1
    b.eq do_concat_4146
    tst x0, #1
    b.ne do_compose_4144
do_apply_4145:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4148
do_compose_4144:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4148
do_concat_4146:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4148
id_morphism_4147:
    b apply_end_4148
apply_end_4148:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4152
    tst x9, #1
    b.eq do_concat_4151
    tst x0, #1
    b.ne do_compose_4149
do_apply_4150:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4153
do_compose_4149:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4153
do_concat_4151:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4153
id_morphism_4152:
    b apply_end_4153
apply_end_4153:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4157
    tst x9, #1
    b.eq do_concat_4156
    tst x0, #1
    b.ne do_compose_4154
do_apply_4155:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4158
do_compose_4154:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4158
do_concat_4156:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4158
id_morphism_4157:
    b apply_end_4158
apply_end_4158:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4117_4118:
    // Closure for func_4117
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
    adr x1, func_4117
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4115_4116:
    // Closure for func_4115
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4115
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4113_4114:
    // Closure for func_4113
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4113
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4107
cond_false_4106:
    adr x0, sign_id
cond_end_4107:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_lambda
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4164
    tst x9, #1
    b.eq do_concat_4163
    tst x0, #1
    b.ne do_compose_4161
do_apply_4162:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4165
do_compose_4161:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4165
do_concat_4163:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4165
id_morphism_4164:
    b apply_end_4165
apply_end_4165:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4159
    b after_func_4166_4167
func_4166:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4168_4169
func_4168:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, make_infix
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4173
    tst x9, #1
    b.eq do_concat_4172
    tst x0, #1
    b.ne do_compose_4170
do_apply_4171:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4174
do_compose_4170:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4174
do_concat_4172:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4174
id_morphism_4173:
    b apply_end_4174
apply_end_4174:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4178
    tst x9, #1
    b.eq do_concat_4177
    tst x0, #1
    b.ne do_compose_4175
do_apply_4176:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4179
do_compose_4175:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4179
do_concat_4177:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4179
id_morphism_4178:
    b apply_end_4179
apply_end_4179:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4183
    tst x9, #1
    b.eq do_concat_4182
    tst x0, #1
    b.ne do_compose_4180
do_apply_4181:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4184
do_compose_4180:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4184
do_concat_4182:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4184
id_morphism_4183:
    b apply_end_4184
apply_end_4184:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4168_4169:
    // Closure for func_4168
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4168
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4166_4167:
    // Closure for func_4166
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4166
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4160
cond_false_4159:
    adr x0, sign_id
cond_end_4160:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, transform_section
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4190
    tst x9, #1
    b.eq do_concat_4189
    tst x0, #1
    b.ne do_compose_4187
do_apply_4188:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4191
do_compose_4187:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4191
do_concat_4189:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4191
id_morphism_4190:
    b apply_end_4191
apply_end_4191:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4185
    b after_func_4192_4193
func_4192:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4195_4196
func_4195:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4195_4196:
    // Closure for func_4195
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4195
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4198_4199
func_4198:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4200_4201
func_4200:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4200_4201:
    // Closure for func_4200
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4200
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4198_4199:
    // Closure for func_4198
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4198
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4205
    adr x0, sign_id
    b cmp_end_4206
cmp_true_4205:
cmp_end_4206:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4203
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_4208_4209
func_4208:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4208_4209:
    // Closure for func_4208
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4208
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4211_4212
func_4211:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4211_4212:
    // Closure for func_4211
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4211
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4216
    adr x0, sign_id
    b cmp_end_4217
cmp_true_4216:
cmp_end_4217:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4214
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_26
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4218
    b after_func_4219_4220
func_4219:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4219_4220:
    // Closure for func_4219
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4219
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4225
    tst x9, #1
    b.eq do_concat_4224
    tst x0, #1
    b.ne do_compose_4222
do_apply_4223:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4226
do_compose_4222:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4226
do_concat_4224:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4226
id_morphism_4225:
    b apply_end_4226
apply_end_4226:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4230
    tst x9, #1
    b.eq do_concat_4229
    tst x0, #1
    b.ne do_compose_4227
do_apply_4228:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4231
do_compose_4227:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4231
do_concat_4229:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4231
id_morphism_4230:
    b apply_end_4231
apply_end_4231:
    str x0, [sp, #-16]!
    adr x0, p2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4235
    tst x9, #1
    b.eq do_concat_4234
    tst x0, #1
    b.ne do_compose_4232
do_apply_4233:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4236
do_compose_4232:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4236
do_concat_4234:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4236
id_morphism_4235:
    b apply_end_4236
apply_end_4236:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4221
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4240
    tst x9, #1
    b.eq do_concat_4239
    tst x0, #1
    b.ne do_compose_4237
do_apply_4238:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4241
do_compose_4237:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4241
do_concat_4239:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4241
id_morphism_4240:
    b apply_end_4241
apply_end_4241:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4245
    tst x9, #1
    b.eq do_concat_4244
    tst x0, #1
    b.ne do_compose_4242
do_apply_4243:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4246
do_compose_4242:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4246
do_concat_4244:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4246
id_morphism_4245:
    b apply_end_4246
apply_end_4246:
    str x0, [sp, #-16]!
    adr x0, p2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4250
    tst x9, #1
    b.eq do_concat_4249
    tst x0, #1
    b.ne do_compose_4247
do_apply_4248:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4251
do_compose_4247:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4251
do_concat_4249:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4251
id_morphism_4250:
    b apply_end_4251
apply_end_4251:
blk_end_4221:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4255
    tst x9, #1
    b.eq do_concat_4254
    tst x0, #1
    b.ne do_compose_4252
do_apply_4253:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4256
do_compose_4252:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4256
do_concat_4254:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4256
id_morphism_4255:
    b apply_end_4256
apply_end_4256:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4260
    tst x9, #1
    b.eq do_concat_4259
    tst x0, #1
    b.ne do_compose_4257
do_apply_4258:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4261
do_compose_4257:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4261
do_concat_4259:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4261
id_morphism_4260:
    b apply_end_4261
apply_end_4261:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4218
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4265
    tst x9, #1
    b.eq do_concat_4264
    tst x0, #1
    b.ne do_compose_4262
do_apply_4263:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4266
do_compose_4262:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4266
do_concat_4264:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4266
id_morphism_4265:
    b apply_end_4266
apply_end_4266:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4270
    tst x9, #1
    b.eq do_concat_4269
    tst x0, #1
    b.ne do_compose_4267
do_apply_4268:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4271
do_compose_4267:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4271
do_concat_4269:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4271
id_morphism_4270:
    b apply_end_4271
apply_end_4271:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4275
    tst x9, #1
    b.eq do_concat_4274
    tst x0, #1
    b.ne do_compose_4272
do_apply_4273:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4276
do_compose_4272:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4276
do_concat_4274:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4276
id_morphism_4275:
    b apply_end_4276
apply_end_4276:
    str x0, [sp, #-16]!
    adr x0, str_27
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4280
    tst x9, #1
    b.eq do_concat_4279
    tst x0, #1
    b.ne do_compose_4277
do_apply_4278:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4281
do_compose_4277:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4281
do_concat_4279:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4281
id_morphism_4280:
    b apply_end_4281
apply_end_4281:
blk_end_4218:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4285
    tst x9, #1
    b.eq do_concat_4284
    tst x0, #1
    b.ne do_compose_4282
do_apply_4283:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4286
do_compose_4282:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4286
do_concat_4284:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4286
id_morphism_4285:
    b apply_end_4286
apply_end_4286:
    b cond_end_4215
cond_false_4214:
    adr x0, sign_id
cond_end_4215:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4213
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4290
    tst x9, #1
    b.eq do_concat_4289
    tst x0, #1
    b.ne do_compose_4287
do_apply_4288:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4291
do_compose_4287:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4291
do_concat_4289:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4291
id_morphism_4290:
    b apply_end_4291
apply_end_4291:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4295
    tst x9, #1
    b.eq do_concat_4294
    tst x0, #1
    b.ne do_compose_4292
do_apply_4293:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4296
do_compose_4292:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4296
do_concat_4294:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4296
id_morphism_4295:
    b apply_end_4296
apply_end_4296:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4300
    tst x9, #1
    b.eq do_concat_4299
    tst x0, #1
    b.ne do_compose_4297
do_apply_4298:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4301
do_compose_4297:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4301
do_concat_4299:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4301
id_morphism_4300:
    b apply_end_4301
apply_end_4301:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4305
    tst x9, #1
    b.eq do_concat_4304
    tst x0, #1
    b.ne do_compose_4302
do_apply_4303:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4306
do_compose_4302:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4306
do_concat_4304:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4306
id_morphism_4305:
    b apply_end_4306
apply_end_4306:
blk_end_4213:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4310
    tst x9, #1
    b.eq do_concat_4309
    tst x0, #1
    b.ne do_compose_4307
do_apply_4308:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4311
do_compose_4307:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4311
do_concat_4309:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4311
id_morphism_4310:
    b apply_end_4311
apply_end_4311:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4210
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4315
    tst x9, #1
    b.eq do_concat_4314
    tst x0, #1
    b.ne do_compose_4312
do_apply_4313:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4316
do_compose_4312:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4316
do_concat_4314:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4316
id_morphism_4315:
    b apply_end_4316
apply_end_4316:
blk_end_4210:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4320
    tst x9, #1
    b.eq do_concat_4319
    tst x0, #1
    b.ne do_compose_4317
do_apply_4318:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4321
do_compose_4317:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4321
do_concat_4319:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4321
id_morphism_4320:
    b apply_end_4321
apply_end_4321:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4207
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4325
    tst x9, #1
    b.eq do_concat_4324
    tst x0, #1
    b.ne do_compose_4322
do_apply_4323:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4326
do_compose_4322:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4326
do_concat_4324:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4326
id_morphism_4325:
    b apply_end_4326
apply_end_4326:
blk_end_4207:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4330
    tst x9, #1
    b.eq do_concat_4329
    tst x0, #1
    b.ne do_compose_4327
do_apply_4328:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4331
do_compose_4327:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4331
do_concat_4329:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4331
id_morphism_4330:
    b apply_end_4331
apply_end_4331:
    b cond_end_4204
cond_false_4203:
    adr x0, sign_id
cond_end_4204:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4202
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4334
    adr x0, sign_id
    b cmp_end_4335
cmp_true_4334:
cmp_end_4335:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4332
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_4337_4338
func_4337:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4337_4338:
    // Closure for func_4337
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4337
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4340_4341
func_4340:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4340_4341:
    // Closure for func_4340
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4340
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4343_4344
func_4343:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4343_4344:
    // Closure for func_4343
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4343
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4346_4347
func_4346:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4346_4347:
    // Closure for func_4346
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4346
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, t1
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4351
    adr x0, sign_id
    b cmp_end_4352
cmp_true_4351:
cmp_end_4352:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4349
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_28
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4353
    b after_func_4354_4355
func_4354:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4354_4355:
    // Closure for func_4354
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4354
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4359
    tst x9, #1
    b.eq do_concat_4358
    tst x0, #1
    b.ne do_compose_4356
do_apply_4357:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4360
do_compose_4356:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4360
do_concat_4358:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4360
id_morphism_4359:
    b apply_end_4360
apply_end_4360:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4364
    tst x9, #1
    b.eq do_concat_4363
    tst x0, #1
    b.ne do_compose_4361
do_apply_4362:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4365
do_compose_4361:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4365
do_concat_4363:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4365
id_morphism_4364:
    b apply_end_4365
apply_end_4365:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4369
    tst x9, #1
    b.eq do_concat_4368
    tst x0, #1
    b.ne do_compose_4366
do_apply_4367:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4370
do_compose_4366:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4370
do_concat_4368:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4370
id_morphism_4369:
    b apply_end_4370
apply_end_4370:
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4374
    tst x9, #1
    b.eq do_concat_4373
    tst x0, #1
    b.ne do_compose_4371
do_apply_4372:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4375
do_compose_4371:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4375
do_concat_4373:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4375
id_morphism_4374:
    b apply_end_4375
apply_end_4375:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4379
    tst x9, #1
    b.eq do_concat_4378
    tst x0, #1
    b.ne do_compose_4376
do_apply_4377:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4380
do_compose_4376:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4380
do_concat_4378:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4380
id_morphism_4379:
    b apply_end_4380
apply_end_4380:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4384
    tst x9, #1
    b.eq do_concat_4383
    tst x0, #1
    b.ne do_compose_4381
do_apply_4382:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4385
do_compose_4381:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4385
do_concat_4383:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4385
id_morphism_4384:
    b apply_end_4385
apply_end_4385:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4353
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4389
    tst x9, #1
    b.eq do_concat_4388
    tst x0, #1
    b.ne do_compose_4386
do_apply_4387:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4390
do_compose_4386:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4390
do_concat_4388:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4390
id_morphism_4389:
    b apply_end_4390
apply_end_4390:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4394
    tst x9, #1
    b.eq do_concat_4393
    tst x0, #1
    b.ne do_compose_4391
do_apply_4392:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4395
do_compose_4391:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4395
do_concat_4393:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4395
id_morphism_4394:
    b apply_end_4395
apply_end_4395:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4399
    tst x9, #1
    b.eq do_concat_4398
    tst x0, #1
    b.ne do_compose_4396
do_apply_4397:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4400
do_compose_4396:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4400
do_concat_4398:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4400
id_morphism_4399:
    b apply_end_4400
apply_end_4400:
blk_end_4353:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4404
    tst x9, #1
    b.eq do_concat_4403
    tst x0, #1
    b.ne do_compose_4401
do_apply_4402:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4405
do_compose_4401:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4405
do_concat_4403:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4405
id_morphism_4404:
    b apply_end_4405
apply_end_4405:
    b cond_end_4350
cond_false_4349:
    adr x0, sign_id
cond_end_4350:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4348
    adr x0, t2
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4408
    adr x0, sign_id
    b cmp_end_4409
cmp_true_4408:
cmp_end_4409:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4406
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_29
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4410
    b after_func_4411_4412
func_4411:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4411_4412:
    // Closure for func_4411
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4411
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4416
    tst x9, #1
    b.eq do_concat_4415
    tst x0, #1
    b.ne do_compose_4413
do_apply_4414:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4417
do_compose_4413:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4417
do_concat_4415:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4417
id_morphism_4416:
    b apply_end_4417
apply_end_4417:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4421
    tst x9, #1
    b.eq do_concat_4420
    tst x0, #1
    b.ne do_compose_4418
do_apply_4419:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4422
do_compose_4418:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4422
do_concat_4420:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4422
id_morphism_4421:
    b apply_end_4422
apply_end_4422:
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4426
    tst x9, #1
    b.eq do_concat_4425
    tst x0, #1
    b.ne do_compose_4423
do_apply_4424:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4427
do_compose_4423:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4427
do_concat_4425:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4427
id_morphism_4426:
    b apply_end_4427
apply_end_4427:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4431
    tst x9, #1
    b.eq do_concat_4430
    tst x0, #1
    b.ne do_compose_4428
do_apply_4429:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4432
do_compose_4428:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4432
do_concat_4430:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4432
id_morphism_4431:
    b apply_end_4432
apply_end_4432:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4436
    tst x9, #1
    b.eq do_concat_4435
    tst x0, #1
    b.ne do_compose_4433
do_apply_4434:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4437
do_compose_4433:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4437
do_concat_4435:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4437
id_morphism_4436:
    b apply_end_4437
apply_end_4437:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4441
    tst x9, #1
    b.eq do_concat_4440
    tst x0, #1
    b.ne do_compose_4438
do_apply_4439:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4442
do_compose_4438:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4442
do_concat_4440:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4442
id_morphism_4441:
    b apply_end_4442
apply_end_4442:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4410
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4446
    tst x9, #1
    b.eq do_concat_4445
    tst x0, #1
    b.ne do_compose_4443
do_apply_4444:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4447
do_compose_4443:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4447
do_concat_4445:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4447
id_morphism_4446:
    b apply_end_4447
apply_end_4447:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4451
    tst x9, #1
    b.eq do_concat_4450
    tst x0, #1
    b.ne do_compose_4448
do_apply_4449:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4452
do_compose_4448:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4452
do_concat_4450:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4452
id_morphism_4451:
    b apply_end_4452
apply_end_4452:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4456
    tst x9, #1
    b.eq do_concat_4455
    tst x0, #1
    b.ne do_compose_4453
do_apply_4454:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4457
do_compose_4453:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4457
do_concat_4455:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4457
id_morphism_4456:
    b apply_end_4457
apply_end_4457:
blk_end_4410:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4461
    tst x9, #1
    b.eq do_concat_4460
    tst x0, #1
    b.ne do_compose_4458
do_apply_4459:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4462
do_compose_4458:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4462
do_concat_4460:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4462
id_morphism_4461:
    b apply_end_4462
apply_end_4462:
    b cond_end_4407
cond_false_4406:
    adr x0, sign_id
cond_end_4407:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4348
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4466
    tst x9, #1
    b.eq do_concat_4465
    tst x0, #1
    b.ne do_compose_4463
do_apply_4464:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4467
do_compose_4463:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4467
do_concat_4465:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4467
id_morphism_4466:
    b apply_end_4467
apply_end_4467:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4471
    tst x9, #1
    b.eq do_concat_4470
    tst x0, #1
    b.ne do_compose_4468
do_apply_4469:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4472
do_compose_4468:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4472
do_concat_4470:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4472
id_morphism_4471:
    b apply_end_4472
apply_end_4472:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4476
    tst x9, #1
    b.eq do_concat_4475
    tst x0, #1
    b.ne do_compose_4473
do_apply_4474:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4477
do_compose_4473:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4477
do_concat_4475:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4477
id_morphism_4476:
    b apply_end_4477
apply_end_4477:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4481
    tst x9, #1
    b.eq do_concat_4480
    tst x0, #1
    b.ne do_compose_4478
do_apply_4479:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4482
do_compose_4478:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4482
do_concat_4480:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4482
id_morphism_4481:
    b apply_end_4482
apply_end_4482:
blk_end_4348:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4486
    tst x9, #1
    b.eq do_concat_4485
    tst x0, #1
    b.ne do_compose_4483
do_apply_4484:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4487
do_compose_4483:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4487
do_concat_4485:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4487
id_morphism_4486:
    b apply_end_4487
apply_end_4487:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4345
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4491
    tst x9, #1
    b.eq do_concat_4490
    tst x0, #1
    b.ne do_compose_4488
do_apply_4489:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4492
do_compose_4488:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4492
do_concat_4490:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4492
id_morphism_4491:
    b apply_end_4492
apply_end_4492:
blk_end_4345:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4496
    tst x9, #1
    b.eq do_concat_4495
    tst x0, #1
    b.ne do_compose_4493
do_apply_4494:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4497
do_compose_4493:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4497
do_concat_4495:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4497
id_morphism_4496:
    b apply_end_4497
apply_end_4497:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4342
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4501
    tst x9, #1
    b.eq do_concat_4500
    tst x0, #1
    b.ne do_compose_4498
do_apply_4499:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4502
do_compose_4498:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4502
do_concat_4500:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4502
id_morphism_4501:
    b apply_end_4502
apply_end_4502:
blk_end_4342:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4506
    tst x9, #1
    b.eq do_concat_4505
    tst x0, #1
    b.ne do_compose_4503
do_apply_4504:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4507
do_compose_4503:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4507
do_concat_4505:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4507
id_morphism_4506:
    b apply_end_4507
apply_end_4507:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4339
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4511
    tst x9, #1
    b.eq do_concat_4510
    tst x0, #1
    b.ne do_compose_4508
do_apply_4509:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4512
do_compose_4508:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4512
do_concat_4510:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4512
id_morphism_4511:
    b apply_end_4512
apply_end_4512:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4516
    tst x9, #1
    b.eq do_concat_4515
    tst x0, #1
    b.ne do_compose_4513
do_apply_4514:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4517
do_compose_4513:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4517
do_concat_4515:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4517
id_morphism_4516:
    b apply_end_4517
apply_end_4517:
blk_end_4339:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4521
    tst x9, #1
    b.eq do_concat_4520
    tst x0, #1
    b.ne do_compose_4518
do_apply_4519:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4522
do_compose_4518:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4522
do_concat_4520:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4522
id_morphism_4521:
    b apply_end_4522
apply_end_4522:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4336
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4526
    tst x9, #1
    b.eq do_concat_4525
    tst x0, #1
    b.ne do_compose_4523
do_apply_4524:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4527
do_compose_4523:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4527
do_concat_4525:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4527
id_morphism_4526:
    b apply_end_4527
apply_end_4527:
blk_end_4336:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4531
    tst x9, #1
    b.eq do_concat_4530
    tst x0, #1
    b.ne do_compose_4528
do_apply_4529:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4532
do_compose_4528:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4532
do_concat_4530:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4532
id_morphism_4531:
    b apply_end_4532
apply_end_4532:
    b cond_end_4333
cond_false_4332:
    adr x0, sign_id
cond_end_4333:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4202
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4536
    tst x9, #1
    b.eq do_concat_4535
    tst x0, #1
    b.ne do_compose_4533
do_apply_4534:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4537
do_compose_4533:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4537
do_concat_4535:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4537
id_morphism_4536:
    b apply_end_4537
apply_end_4537:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4541
    tst x9, #1
    b.eq do_concat_4540
    tst x0, #1
    b.ne do_compose_4538
do_apply_4539:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4542
do_compose_4538:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4542
do_concat_4540:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4542
id_morphism_4541:
    b apply_end_4542
apply_end_4542:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4546
    tst x9, #1
    b.eq do_concat_4545
    tst x0, #1
    b.ne do_compose_4543
do_apply_4544:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4547
do_compose_4543:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4547
do_concat_4545:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4547
id_morphism_4546:
    b apply_end_4547
apply_end_4547:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4551
    tst x9, #1
    b.eq do_concat_4550
    tst x0, #1
    b.ne do_compose_4548
do_apply_4549:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4552
do_compose_4548:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4552
do_concat_4550:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4552
id_morphism_4551:
    b apply_end_4552
apply_end_4552:
blk_end_4202:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4556
    tst x9, #1
    b.eq do_concat_4555
    tst x0, #1
    b.ne do_compose_4553
do_apply_4554:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4557
do_compose_4553:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4557
do_concat_4555:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4557
id_morphism_4556:
    b apply_end_4557
apply_end_4557:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4197
    adr x0, make_id
    str x0, [sp, #-16]!
    adr x0, str_30
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4561
    tst x9, #1
    b.eq do_concat_4560
    tst x0, #1
    b.ne do_compose_4558
do_apply_4559:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4562
do_compose_4558:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4562
do_concat_4560:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4562
id_morphism_4561:
    b apply_end_4562
apply_end_4562:
    str x0, [sp, #-16]!
    adr x0, make_id
    str x0, [sp, #-16]!
    adr x0, str_31
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4566
    tst x9, #1
    b.eq do_concat_4565
    tst x0, #1
    b.ne do_compose_4563
do_apply_4564:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4567
do_compose_4563:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4567
do_concat_4565:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4567
id_morphism_4566:
    b apply_end_4567
apply_end_4567:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4571
    tst x9, #1
    b.eq do_concat_4570
    tst x0, #1
    b.ne do_compose_4568
do_apply_4569:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4572
do_compose_4568:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4572
do_concat_4570:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4572
id_morphism_4571:
    b apply_end_4572
apply_end_4572:
blk_end_4197:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4576
    tst x9, #1
    b.eq do_concat_4575
    tst x0, #1
    b.ne do_compose_4573
do_apply_4574:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4577
do_compose_4573:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4577
do_concat_4575:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4577
id_morphism_4576:
    b apply_end_4577
apply_end_4577:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4194
    adr x0, length
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4581
    tst x9, #1
    b.eq do_concat_4580
    tst x0, #1
    b.ne do_compose_4578
do_apply_4579:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4582
do_compose_4578:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4582
do_concat_4580:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4582
id_morphism_4581:
    b apply_end_4582
apply_end_4582:
blk_end_4194:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4192_4193:
    // Closure for func_4192
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4192
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4186
cond_false_4185:
    adr x0, sign_id
cond_end_4186:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Pure
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4586
    tst x9, #1
    b.eq do_concat_4585
    tst x0, #1
    b.ne do_compose_4583
do_apply_4584:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4587
do_compose_4583:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4587
do_concat_4585:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4587
id_morphism_4586:
    b apply_end_4587
apply_end_4587:
    str x0, [sp, #-16]!
    adr x0, Functional
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4591
    tst x9, #1
    b.eq do_concat_4590
    tst x0, #1
    b.ne do_compose_4588
do_apply_4589:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4592
do_compose_4588:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4592
do_concat_4590:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4592
id_morphism_4591:
    b apply_end_4592
apply_end_4592:
    str x0, [sp, #-16]!
    adr x0, Compiler
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4596
    tst x9, #1
    b.eq do_concat_4595
    tst x0, #1
    b.ne do_compose_4593
do_apply_4594:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4597
do_compose_4593:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4597
do_concat_4595:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4597
id_morphism_4596:
    b apply_end_4597
apply_end_4597:
    str x0, [sp, #-16]!
    adr x0, Code
    str x0, [sp, #-16]!
    adr x0, Generator
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4601
    tst x9, #1
    b.eq do_concat_4600
    tst x0, #1
    b.ne do_compose_4598
do_apply_4599:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4602
do_compose_4598:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4602
do_concat_4600:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4602
id_morphism_4601:
    b apply_end_4602
apply_end_4602:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4606
    tst x9, #1
    b.eq do_concat_4605
    tst x0, #1
    b.ne do_compose_4603
do_apply_4604:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4607
do_compose_4603:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4607
do_concat_4605:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4607
id_morphism_4606:
    b apply_end_4607
apply_end_4607:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Transforms
    str x0, [sp, #-16]!
    adr x0, AST
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4611
    tst x9, #1
    b.eq do_concat_4610
    tst x0, #1
    b.ne do_compose_4608
do_apply_4609:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4612
do_compose_4608:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4612
do_concat_4610:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4612
id_morphism_4611:
    b apply_end_4612
apply_end_4612:
    str x0, [sp, #-16]!
    adr x0, from
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4616
    tst x9, #1
    b.eq do_concat_4615
    tst x0, #1
    b.ne do_compose_4613
do_apply_4614:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4617
do_compose_4613:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4617
do_concat_4615:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4617
id_morphism_4616:
    b apply_end_4617
apply_end_4617:
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4621
    tst x9, #1
    b.eq do_concat_4620
    tst x0, #1
    b.ne do_compose_4618
do_apply_4619:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4622
do_compose_4618:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4622
do_concat_4620:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4622
id_morphism_4621:
    b apply_end_4622
apply_end_4622:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4626
    tst x9, #1
    b.eq do_concat_4625
    tst x0, #1
    b.ne do_compose_4623
do_apply_4624:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4627
do_compose_4623:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4627
do_concat_4625:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4627
id_morphism_4626:
    b apply_end_4627
apply_end_4627:
    str x0, [sp, #-16]!
    adr x0, sn
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4631
    tst x9, #1
    b.eq do_concat_4630
    tst x0, #1
    b.ne do_compose_4628
do_apply_4629:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4632
do_compose_4628:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4632
do_concat_4630:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4632
id_morphism_4631:
    b apply_end_4632
apply_end_4632:
    str x0, [sp, #-16]!
    adr x0, into
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4636
    tst x9, #1
    b.eq do_concat_4635
    tst x0, #1
    b.ne do_compose_4633
do_apply_4634:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4637
do_compose_4633:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4637
do_concat_4635:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4637
id_morphism_4636:
    b apply_end_4637
apply_end_4637:
    str x0, [sp, #-16]!
    adr x0, ARM64
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4641
    tst x9, #1
    b.eq do_concat_4640
    tst x0, #1
    b.ne do_compose_4638
do_apply_4639:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4642
do_compose_4638:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4642
do_concat_4640:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4642
id_morphism_4641:
    b apply_end_4642
apply_end_4642:
    str x0, [sp, #-16]!
    adr x0, Assembly
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4646
    tst x9, #1
    b.eq do_concat_4645
    tst x0, #1
    b.ne do_compose_4643
do_apply_4644:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4647
do_compose_4643:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4647
do_concat_4645:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4647
id_morphism_4646:
    b apply_end_4647
apply_end_4647:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4651
    tst x9, #1
    b.eq do_concat_4650
    tst x0, #1
    b.ne do_compose_4648
do_apply_4649:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4652
do_compose_4648:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4652
do_concat_4650:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4652
id_morphism_4651:
    b apply_end_4652
apply_end_4652:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, Philosophy
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, Pure
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, Functional
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4658
    tst x9, #1
    b.eq do_concat_4657
    tst x0, #1
    b.ne do_compose_4655
do_apply_4656:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4659
do_compose_4655:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4659
do_concat_4657:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4659
id_morphism_4658:
    b apply_end_4659
apply_end_4659:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4653
    adr x0, State
    str x0, [sp, #-16]!
    adr x0, LabelCount
    str x0, [sp, #-16]!
    adr x0, StringTable
    str x0, [sp, #-16]!
    adr x0, Env
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4665
    tst x9, #1
    b.eq do_concat_4664
    tst x0, #1
    b.ne do_compose_4662
do_apply_4663:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4666
do_compose_4662:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4666
do_concat_4664:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4666
id_morphism_4665:
    b apply_end_4666
apply_end_4666:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4670
    tst x9, #1
    b.eq do_concat_4669
    tst x0, #1
    b.ne do_compose_4667
do_apply_4668:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4671
do_compose_4667:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4671
do_concat_4669:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4671
id_morphism_4670:
    b apply_end_4671
apply_end_4671:
    str x0, [sp, #-16]!
    adr x0, threaded
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4675
    tst x9, #1
    b.eq do_concat_4674
    tst x0, #1
    b.ne do_compose_4672
do_apply_4673:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4676
do_compose_4672:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4676
do_concat_4674:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4676
id_morphism_4675:
    b apply_end_4676
apply_end_4676:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Stack
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4680
    tst x9, #1
    b.eq do_concat_4679
    tst x0, #1
    b.ne do_compose_4677
do_apply_4678:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4681
do_compose_4677:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4681
do_concat_4679:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4681
id_morphism_4680:
    b apply_end_4681
apply_end_4681:
    str x0, [sp, #-16]!
    adr x0, Machine
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4685
    tst x9, #1
    b.eq do_concat_4684
    tst x0, #1
    b.ne do_compose_4682
do_apply_4683:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4686
do_compose_4682:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4686
do_concat_4684:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4686
id_morphism_4685:
    b apply_end_4686
apply_end_4686:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4660
    adr x0, Context
    str x0, [sp, #-16]!
    adr x0, is
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4692
    tst x9, #1
    b.eq do_concat_4691
    tst x0, #1
    b.ne do_compose_4689
do_apply_4690:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4693
do_compose_4689:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4693
do_concat_4691:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4693
id_morphism_4692:
    b apply_end_4693
apply_end_4693:
    str x0, [sp, #-16]!
    adr x0, passed
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4697
    tst x9, #1
    b.eq do_concat_4696
    tst x0, #1
    b.ne do_compose_4694
do_apply_4695:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4698
do_compose_4694:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4698
do_concat_4696:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4698
id_morphism_4697:
    b apply_end_4698
apply_end_4698:
    str x0, [sp, #-16]!
    adr x0, as
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4702
    tst x9, #1
    b.eq do_concat_4701
    tst x0, #1
    b.ne do_compose_4699
do_apply_4700:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4703
do_compose_4699:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4703
do_concat_4701:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4703
id_morphism_4702:
    b apply_end_4703
apply_end_4703:
    str x0, [sp, #-16]!
    adr x0, arguments
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4707
    tst x9, #1
    b.eq do_concat_4706
    tst x0, #1
    b.ne do_compose_4704
do_apply_4705:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4708
do_compose_4704:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4708
do_concat_4706:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4708
id_morphism_4707:
    b apply_end_4708
apply_end_4708:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Output
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4712
    tst x9, #1
    b.eq do_concat_4711
    tst x0, #1
    b.ne do_compose_4709
do_apply_4710:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4713
do_compose_4709:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4713
do_concat_4711:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4713
id_morphism_4712:
    b apply_end_4713
apply_end_4713:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4687
    adr x0, List
    str x0, [sp, #-16]!
    adr x0, of
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4717
    tst x9, #1
    b.eq do_concat_4716
    tst x0, #1
    b.ne do_compose_4714
do_apply_4715:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4718
do_compose_4714:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4718
do_concat_4716:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4718
id_morphism_4717:
    b apply_end_4718
apply_end_4718:
    str x0, [sp, #-16]!
    adr x0, assembly
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4722
    tst x9, #1
    b.eq do_concat_4721
    tst x0, #1
    b.ne do_compose_4719
do_apply_4720:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4723
do_compose_4719:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4723
do_concat_4721:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4723
id_morphism_4722:
    b apply_end_4723
apply_end_4723:
    str x0, [sp, #-16]!
    adr x0, instruction
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4727
    tst x9, #1
    b.eq do_concat_4726
    tst x0, #1
    b.ne do_compose_4724
do_apply_4725:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4728
do_compose_4724:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4728
do_concat_4726:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4728
id_morphism_4727:
    b apply_end_4728
apply_end_4728:
    str x0, [sp, #-16]!
    adr x0, strings
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4732
    tst x9, #1
    b.eq do_concat_4731
    tst x0, #1
    b.ne do_compose_4729
do_apply_4730:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4733
do_compose_4729:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4733
do_concat_4731:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4733
id_morphism_4732:
    b apply_end_4733
apply_end_4733:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4737
    tst x9, #1
    b.eq do_concat_4736
    tst x0, #1
    b.ne do_compose_4734
do_apply_4735:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4738
do_compose_4734:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4738
do_concat_4736:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4738
id_morphism_4737:
    b apply_end_4738
apply_end_4738:
    b cond_end_4688
cond_false_4687:
    adr x0, sign_id
cond_end_4688:
    b cond_end_4661
cond_false_4660:
    adr x0, sign_id
cond_end_4661:
    b cond_end_4654
cond_false_4653:
    adr x0, sign_id
cond_end_4654:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x1, ast_unit
    str x0, [x1]
    adr x0, sign_id
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
    mov x0, #9
    adr x1, ast_prefix
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #10
    adr x1, ast_postfix
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #11
    adr x1, ast_lambda
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #12
    adr x1, ast_char
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_context
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4744
    tst x9, #1
    b.eq do_concat_4743
    tst x0, #1
    b.ne do_compose_4741
do_apply_4742:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4745
do_compose_4741:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4745
do_concat_4743:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4745
id_morphism_4744:
    b apply_end_4745
apply_end_4745:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4739
    b after_func_4746_4747
func_4746:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4748_4749
func_4748:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4750_4751
func_4750:
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
    b after_func_4752_4753
func_4752:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4757
    tst x9, #1
    b.eq do_concat_4756
    tst x0, #1
    b.ne do_compose_4754
do_apply_4755:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4758
do_compose_4754:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4758
do_concat_4756:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4758
id_morphism_4757:
    b apply_end_4758
apply_end_4758:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4762
    tst x9, #1
    b.eq do_concat_4761
    tst x0, #1
    b.ne do_compose_4759
do_apply_4760:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4763
do_compose_4759:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4763
do_concat_4761:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4763
id_morphism_4762:
    b apply_end_4763
apply_end_4763:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4767
    tst x9, #1
    b.eq do_concat_4766
    tst x0, #1
    b.ne do_compose_4764
do_apply_4765:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4768
do_compose_4764:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4768
do_concat_4766:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4768
id_morphism_4767:
    b apply_end_4768
apply_end_4768:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4772
    tst x9, #1
    b.eq do_concat_4771
    tst x0, #1
    b.ne do_compose_4769
do_apply_4770:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4773
do_compose_4769:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4773
do_concat_4771:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4773
id_morphism_4772:
    b apply_end_4773
apply_end_4773:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4777
    tst x9, #1
    b.eq do_concat_4776
    tst x0, #1
    b.ne do_compose_4774
do_apply_4775:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4778
do_compose_4774:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4778
do_concat_4776:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4778
id_morphism_4777:
    b apply_end_4778
apply_end_4778:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4782
    tst x9, #1
    b.eq do_concat_4781
    tst x0, #1
    b.ne do_compose_4779
do_apply_4780:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4783
do_compose_4779:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4783
do_concat_4781:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4783
id_morphism_4782:
    b apply_end_4783
apply_end_4783:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4787
    tst x9, #1
    b.eq do_concat_4786
    tst x0, #1
    b.ne do_compose_4784
do_apply_4785:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4788
do_compose_4784:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4788
do_concat_4786:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4788
id_morphism_4787:
    b apply_end_4788
apply_end_4788:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4792
    tst x9, #1
    b.eq do_concat_4791
    tst x0, #1
    b.ne do_compose_4789
do_apply_4790:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4793
do_compose_4789:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4793
do_concat_4791:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4793
id_morphism_4792:
    b apply_end_4793
apply_end_4793:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4752_4753:
    // Closure for func_4752
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x1, func_4752
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4750_4751:
    // Closure for func_4750
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
    adr x1, func_4750
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4748_4749:
    // Closure for func_4748
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4748
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4746_4747:
    // Closure for func_4746
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4746
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4740
cond_false_4739:
    adr x0, sign_id
cond_end_4740:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_label_count
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4799
    tst x9, #1
    b.eq do_concat_4798
    tst x0, #1
    b.ne do_compose_4796
do_apply_4797:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4800
do_compose_4796:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4800
do_concat_4798:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4800
id_morphism_4799:
    b apply_end_4800
apply_end_4800:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4794
    b after_func_4801_4802
func_4801:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4806
    tst x9, #1
    b.eq do_concat_4805
    tst x0, #1
    b.ne do_compose_4803
do_apply_4804:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4807
do_compose_4803:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4807
do_concat_4805:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4807
id_morphism_4806:
    b apply_end_4807
apply_end_4807:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4801_4802:
    // Closure for func_4801
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4801
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4795
cond_false_4794:
    adr x0, sign_id
cond_end_4795:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_strings
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4813
    tst x9, #1
    b.eq do_concat_4812
    tst x0, #1
    b.ne do_compose_4810
do_apply_4811:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4814
do_compose_4810:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4814
do_concat_4812:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4814
id_morphism_4813:
    b apply_end_4814
apply_end_4814:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4808
    b after_func_4815_4816
func_4815:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4820
    tst x9, #1
    b.eq do_concat_4819
    tst x0, #1
    b.ne do_compose_4817
do_apply_4818:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4821
do_compose_4817:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4821
do_concat_4819:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4821
id_morphism_4820:
    b apply_end_4821
apply_end_4821:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4825
    tst x9, #1
    b.eq do_concat_4824
    tst x0, #1
    b.ne do_compose_4822
do_apply_4823:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4826
do_compose_4822:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4826
do_concat_4824:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4826
id_morphism_4825:
    b apply_end_4826
apply_end_4826:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4815_4816:
    // Closure for func_4815
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4815
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4809
cond_false_4808:
    adr x0, sign_id
cond_end_4809:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_env
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4832
    tst x9, #1
    b.eq do_concat_4831
    tst x0, #1
    b.ne do_compose_4829
do_apply_4830:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4833
do_compose_4829:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4833
do_concat_4831:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4833
id_morphism_4832:
    b apply_end_4833
apply_end_4833:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4827
    b after_func_4834_4835
func_4834:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4839
    tst x9, #1
    b.eq do_concat_4838
    tst x0, #1
    b.ne do_compose_4836
do_apply_4837:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4840
do_compose_4836:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4840
do_concat_4838:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4840
id_morphism_4839:
    b apply_end_4840
apply_end_4840:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4844
    tst x9, #1
    b.eq do_concat_4843
    tst x0, #1
    b.ne do_compose_4841
do_apply_4842:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4845
do_compose_4841:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4845
do_concat_4843:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4845
id_morphism_4844:
    b apply_end_4845
apply_end_4845:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4849
    tst x9, #1
    b.eq do_concat_4848
    tst x0, #1
    b.ne do_compose_4846
do_apply_4847:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4850
do_compose_4846:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4850
do_concat_4848:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4850
id_morphism_4849:
    b apply_end_4850
apply_end_4850:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4834_4835:
    // Closure for func_4834
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4834
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4828
cond_false_4827:
    adr x0, sign_id
cond_end_4828:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_stack_offset
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4856
    tst x9, #1
    b.eq do_concat_4855
    tst x0, #1
    b.ne do_compose_4853
do_apply_4854:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4857
do_compose_4853:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4857
do_concat_4855:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4857
id_morphism_4856:
    b apply_end_4857
apply_end_4857:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4851
    b after_func_4858_4859
func_4858:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4863
    tst x9, #1
    b.eq do_concat_4862
    tst x0, #1
    b.ne do_compose_4860
do_apply_4861:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4864
do_compose_4860:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4864
do_concat_4862:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4864
id_morphism_4863:
    b apply_end_4864
apply_end_4864:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4868
    tst x9, #1
    b.eq do_concat_4867
    tst x0, #1
    b.ne do_compose_4865
do_apply_4866:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4869
do_compose_4865:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4869
do_concat_4867:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4869
id_morphism_4868:
    b apply_end_4869
apply_end_4869:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4873
    tst x9, #1
    b.eq do_concat_4872
    tst x0, #1
    b.ne do_compose_4870
do_apply_4871:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4874
do_compose_4870:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4874
do_concat_4872:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4874
id_morphism_4873:
    b apply_end_4874
apply_end_4874:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4878
    tst x9, #1
    b.eq do_concat_4877
    tst x0, #1
    b.ne do_compose_4875
do_apply_4876:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4879
do_compose_4875:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4879
do_concat_4877:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4879
id_morphism_4878:
    b apply_end_4879
apply_end_4879:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4858_4859:
    // Closure for func_4858
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4858
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4852
cond_false_4851:
    adr x0, sign_id
cond_end_4852:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, lookup_var
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4885
    tst x9, #1
    b.eq do_concat_4884
    tst x0, #1
    b.ne do_compose_4882
do_apply_4883:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4886
do_compose_4882:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4886
do_concat_4884:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4886
id_morphism_4885:
    b apply_end_4886
apply_end_4886:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4880
    b after_func_4887_4888
func_4887:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4889_4890
func_4889:
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
    b.eq cmp_true_4894
    adr x0, sign_id
    b cmp_end_4895
cmp_true_4894:
cmp_end_4895:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4892
    mov x0, #0
    b cond_end_4893
cond_false_4892:
    adr x0, sign_id
cond_end_4893:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4891
    b after_func_4896_4897
func_4896:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4896_4897:
    // Closure for func_4896
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4896
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4904
    tst x9, #1
    b.eq do_concat_4903
    tst x0, #1
    b.ne do_compose_4901
do_apply_4902:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4905
do_compose_4901:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4905
do_concat_4903:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4905
id_morphism_4904:
    b apply_end_4905
apply_end_4905:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4909
    tst x9, #1
    b.eq do_concat_4908
    tst x0, #1
    b.ne do_compose_4906
do_apply_4907:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4910
do_compose_4906:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4910
do_concat_4908:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4910
id_morphism_4909:
    b apply_end_4910
apply_end_4910:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4914
    tst x9, #1
    b.eq do_concat_4913
    tst x0, #1
    b.ne do_compose_4911
do_apply_4912:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4915
do_compose_4911:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4915
do_concat_4913:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4915
id_morphism_4914:
    b apply_end_4915
apply_end_4915:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4899
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4919
    tst x9, #1
    b.eq do_concat_4918
    tst x0, #1
    b.ne do_compose_4916
do_apply_4917:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4920
do_compose_4916:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4920
do_concat_4918:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4920
id_morphism_4919:
    b apply_end_4920
apply_end_4920:
    b cond_end_4900
cond_false_4899:
    adr x0, sign_id
cond_end_4900:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4898
    adr x0, lookup_var
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4924
    tst x9, #1
    b.eq do_concat_4923
    tst x0, #1
    b.ne do_compose_4921
do_apply_4922:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4925
do_compose_4921:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4925
do_concat_4923:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4925
id_morphism_4924:
    b apply_end_4925
apply_end_4925:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4929
    tst x9, #1
    b.eq do_concat_4928
    tst x0, #1
    b.ne do_compose_4926
do_apply_4927:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4930
do_compose_4926:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4930
do_concat_4928:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4930
id_morphism_4929:
    b apply_end_4930
apply_end_4930:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4934
    tst x9, #1
    b.eq do_concat_4933
    tst x0, #1
    b.ne do_compose_4931
do_apply_4932:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4935
do_compose_4931:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4935
do_concat_4933:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4935
id_morphism_4934:
    b apply_end_4935
apply_end_4935:
blk_end_4898:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4939
    tst x9, #1
    b.eq do_concat_4938
    tst x0, #1
    b.ne do_compose_4936
do_apply_4937:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4940
do_compose_4936:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4940
do_concat_4938:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4940
id_morphism_4939:
    b apply_end_4940
apply_end_4940:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4891
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4944
    tst x9, #1
    b.eq do_concat_4943
    tst x0, #1
    b.ne do_compose_4941
do_apply_4942:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4945
do_compose_4941:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4945
do_concat_4943:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4945
id_morphism_4944:
    b apply_end_4945
apply_end_4945:
blk_end_4891:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4889_4890:
    // Closure for func_4889
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4889
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4887_4888:
    // Closure for func_4887
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4887
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4881
cond_false_4880:
    adr x0, sign_id
cond_end_4881:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4951
    tst x9, #1
    b.eq do_concat_4950
    tst x0, #1
    b.ne do_compose_4948
do_apply_4949:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4952
do_compose_4948:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4952
do_concat_4950:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4952
id_morphism_4951:
    b apply_end_4952
apply_end_4952:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4946
    b after_func_4953_4954
func_4953:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4955_4956
func_4955:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4958_4959
func_4958:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4958_4959:
    // Closure for func_4958
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4958
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4961_4962
func_4961:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4961_4962:
    // Closure for func_4961
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4961
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4964_4965
func_4964:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4966_4967
func_4966:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4966_4967:
    // Closure for func_4966
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4966
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4964_4965:
    // Closure for func_4964
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4964
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_32
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4971
    tst x9, #1
    b.eq do_concat_4970
    tst x0, #1
    b.ne do_compose_4968
do_apply_4969:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4972
do_compose_4968:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4972
do_concat_4970:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4972
id_morphism_4971:
    b apply_end_4972
apply_end_4972:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4976
    tst x9, #1
    b.eq do_concat_4975
    tst x0, #1
    b.ne do_compose_4973
do_apply_4974:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4977
do_compose_4973:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4977
do_concat_4975:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4977
id_morphism_4976:
    b apply_end_4977
apply_end_4977:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4981
    tst x9, #1
    b.eq do_concat_4980
    tst x0, #1
    b.ne do_compose_4978
do_apply_4979:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4982
do_compose_4978:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4982
do_concat_4980:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4982
id_morphism_4981:
    b apply_end_4982
apply_end_4982:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4986
    tst x9, #1
    b.eq do_concat_4985
    tst x0, #1
    b.ne do_compose_4983
do_apply_4984:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4987
do_compose_4983:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4987
do_concat_4985:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4987
id_morphism_4986:
    b apply_end_4987
apply_end_4987:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4991
    tst x9, #1
    b.eq do_concat_4990
    tst x0, #1
    b.ne do_compose_4988
do_apply_4989:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4992
do_compose_4988:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4992
do_concat_4990:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4992
id_morphism_4991:
    b apply_end_4992
apply_end_4992:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4996
    tst x9, #1
    b.eq do_concat_4995
    tst x0, #1
    b.ne do_compose_4993
do_apply_4994:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4997
do_compose_4993:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4997
do_concat_4995:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4997
id_morphism_4996:
    b apply_end_4997
apply_end_4997:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5001
    tst x9, #1
    b.eq do_concat_5000
    tst x0, #1
    b.ne do_compose_4998
do_apply_4999:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5002
do_compose_4998:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5002
do_concat_5000:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5002
id_morphism_5001:
    b apply_end_5002
apply_end_5002:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, new_ctx
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5006
    tst x9, #1
    b.eq do_concat_5005
    tst x0, #1
    b.ne do_compose_5003
do_apply_5004:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5007
do_compose_5003:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5007
do_concat_5005:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5007
id_morphism_5006:
    b apply_end_5007
apply_end_5007:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5011
    tst x9, #1
    b.eq do_concat_5010
    tst x0, #1
    b.ne do_compose_5008
do_apply_5009:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5012
do_compose_5008:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5012
do_concat_5010:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5012
id_morphism_5011:
    b apply_end_5012
apply_end_5012:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5016
    tst x9, #1
    b.eq do_concat_5015
    tst x0, #1
    b.ne do_compose_5013
do_apply_5014:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5017
do_compose_5013:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5017
do_concat_5015:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5017
id_morphism_5016:
    b apply_end_5017
apply_end_5017:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5021
    tst x9, #1
    b.eq do_concat_5020
    tst x0, #1
    b.ne do_compose_5018
do_apply_5019:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5022
do_compose_5018:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5022
do_concat_5020:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5022
id_morphism_5021:
    b apply_end_5022
apply_end_5022:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4963
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_add
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5026
    tst x9, #1
    b.eq do_concat_5025
    tst x0, #1
    b.ne do_compose_5023
do_apply_5024:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5027
do_compose_5023:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5027
do_concat_5025:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5027
id_morphism_5026:
    b apply_end_5027
apply_end_5027:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_add
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5031
    tst x9, #1
    b.eq do_concat_5030
    tst x0, #1
    b.ne do_compose_5028
do_apply_5029:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5032
do_compose_5028:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5032
do_concat_5030:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5032
id_morphism_5031:
    b apply_end_5032
apply_end_5032:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5036
    tst x9, #1
    b.eq do_concat_5035
    tst x0, #1
    b.ne do_compose_5033
do_apply_5034:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5037
do_compose_5033:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5037
do_concat_5035:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5037
id_morphism_5036:
    b apply_end_5037
apply_end_5037:
blk_end_4963:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5041
    tst x9, #1
    b.eq do_concat_5040
    tst x0, #1
    b.ne do_compose_5038
do_apply_5039:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5042
do_compose_5038:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5042
do_concat_5040:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5042
id_morphism_5041:
    b apply_end_5042
apply_end_5042:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4960
    adr x0, add_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5046
    tst x9, #1
    b.eq do_concat_5045
    tst x0, #1
    b.ne do_compose_5043
do_apply_5044:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5047
do_compose_5043:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5047
do_concat_5045:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5047
id_morphism_5046:
    b apply_end_5047
apply_end_5047:
    str x0, [sp, #-16]!
    adr x0, content
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5051
    tst x9, #1
    b.eq do_concat_5050
    tst x0, #1
    b.ne do_compose_5048
do_apply_5049:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5052
do_compose_5048:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5052
do_concat_5050:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5052
id_morphism_5051:
    b apply_end_5052
apply_end_5052:
blk_end_4960:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5056
    tst x9, #1
    b.eq do_concat_5055
    tst x0, #1
    b.ne do_compose_5053
do_apply_5054:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5057
do_compose_5053:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5057
do_concat_5055:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5057
id_morphism_5056:
    b apply_end_5057
apply_end_5057:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4957
    adr x0, tok_val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5061
    tst x9, #1
    b.eq do_concat_5060
    tst x0, #1
    b.ne do_compose_5058
do_apply_5059:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5062
do_compose_5058:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5062
do_concat_5060:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5062
id_morphism_5061:
    b apply_end_5062
apply_end_5062:
blk_end_4957:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4955_4956:
    // Closure for func_4955
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4955
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4953_4954:
    // Closure for func_4953
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4953
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4947
cond_false_4946:
    adr x0, sign_id
cond_end_4947:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_apply
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5068
    tst x9, #1
    b.eq do_concat_5067
    tst x0, #1
    b.ne do_compose_5065
do_apply_5066:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5069
do_compose_5065:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5069
do_concat_5067:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5069
id_morphism_5068:
    b apply_end_5069
apply_end_5069:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5063
    b after_func_5070_5071
func_5070:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5072_5073
func_5072:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5075_5076
func_5075:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5077_5078
func_5077:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5077_5078:
    // Closure for func_5077
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5077
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5075_5076:
    // Closure for func_5075
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5075
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5080_5081
func_5080:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5080_5081:
    // Closure for func_5080
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5080
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5083_5084
func_5083:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5085_5086
func_5085:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5085_5086:
    // Closure for func_5085
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5085
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5083_5084:
    // Closure for func_5083
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5083
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5088_5089
func_5088:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5088_5089:
    // Closure for func_5088
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5088
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5091_5092
func_5091:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5093_5094
func_5093:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5093_5094:
    // Closure for func_5093
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5093
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5091_5092:
    // Closure for func_5091
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5091
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_func
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5099
    tst x9, #1
    b.eq do_concat_5098
    tst x0, #1
    b.ne do_compose_5096
do_apply_5097:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5100
do_compose_5096:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5100
do_concat_5098:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5100
id_morphism_5099:
    b apply_end_5100
apply_end_5100:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5104
    tst x9, #1
    b.eq do_concat_5103
    tst x0, #1
    b.ne do_compose_5101
do_apply_5102:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5105
do_compose_5101:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5105
do_concat_5103:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5105
id_morphism_5104:
    b apply_end_5105
apply_end_5105:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_arg
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5109
    tst x9, #1
    b.eq do_concat_5108
    tst x0, #1
    b.ne do_compose_5106
do_apply_5107:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5110
do_compose_5106:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5110
do_concat_5108:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5110
id_morphism_5109:
    b apply_end_5110
apply_end_5110:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_35
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5114
    tst x9, #1
    b.eq do_concat_5113
    tst x0, #1
    b.ne do_compose_5111
do_apply_5112:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5115
do_compose_5111:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5115
do_concat_5113:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5115
id_morphism_5114:
    b apply_end_5115
apply_end_5115:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_36
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5119
    tst x9, #1
    b.eq do_concat_5118
    tst x0, #1
    b.ne do_compose_5116
do_apply_5117:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5120
do_compose_5116:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5120
do_concat_5118:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5120
id_morphism_5119:
    b apply_end_5120
apply_end_5120:
    str x0, [sp, #-16]!
    adr x0, str_37
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5124
    tst x9, #1
    b.eq do_concat_5123
    tst x0, #1
    b.ne do_compose_5121
do_apply_5122:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5125
do_compose_5121:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5125
do_concat_5123:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5125
id_morphism_5124:
    b apply_end_5125
apply_end_5125:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_38
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5129
    tst x9, #1
    b.eq do_concat_5128
    tst x0, #1
    b.ne do_compose_5126
do_apply_5127:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5130
do_compose_5126:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5130
do_concat_5128:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5130
id_morphism_5129:
    b apply_end_5130
apply_end_5130:
    str x0, [sp, #-16]!
    adr x0, str_39
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5134
    tst x9, #1
    b.eq do_concat_5133
    tst x0, #1
    b.ne do_compose_5131
do_apply_5132:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5135
do_compose_5131:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5135
do_concat_5133:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5135
id_morphism_5134:
    b apply_end_5135
apply_end_5135:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_40
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5139
    tst x9, #1
    b.eq do_concat_5138
    tst x0, #1
    b.ne do_compose_5136
do_apply_5137:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5140
do_compose_5136:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5140
do_concat_5138:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5140
id_morphism_5139:
    b apply_end_5140
apply_end_5140:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5144
    tst x9, #1
    b.eq do_concat_5143
    tst x0, #1
    b.ne do_compose_5141
do_apply_5142:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5145
do_compose_5141:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5145
do_concat_5143:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5145
id_morphism_5144:
    b apply_end_5145
apply_end_5145:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5149
    tst x9, #1
    b.eq do_concat_5148
    tst x0, #1
    b.ne do_compose_5146
do_apply_5147:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5150
do_compose_5146:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5150
do_concat_5148:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5150
id_morphism_5149:
    b apply_end_5150
apply_end_5150:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5154
    tst x9, #1
    b.eq do_concat_5153
    tst x0, #1
    b.ne do_compose_5151
do_apply_5152:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5155
do_compose_5151:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5155
do_concat_5153:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5155
id_morphism_5154:
    b apply_end_5155
apply_end_5155:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5159
    tst x9, #1
    b.eq do_concat_5158
    tst x0, #1
    b.ne do_compose_5156
do_apply_5157:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5160
do_compose_5156:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5160
do_concat_5158:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5160
id_morphism_5159:
    b apply_end_5160
apply_end_5160:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5164
    tst x9, #1
    b.eq do_concat_5163
    tst x0, #1
    b.ne do_compose_5161
do_apply_5162:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5165
do_compose_5161:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5165
do_concat_5163:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5165
id_morphism_5164:
    b apply_end_5165
apply_end_5165:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5169
    tst x9, #1
    b.eq do_concat_5168
    tst x0, #1
    b.ne do_compose_5166
do_apply_5167:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5170
do_compose_5166:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5170
do_concat_5168:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5170
id_morphism_5169:
    b apply_end_5170
apply_end_5170:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5174
    tst x9, #1
    b.eq do_concat_5173
    tst x0, #1
    b.ne do_compose_5171
do_apply_5172:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5175
do_compose_5171:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5175
do_concat_5173:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5175
id_morphism_5174:
    b apply_end_5175
apply_end_5175:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5095
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_arg
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5179
    tst x9, #1
    b.eq do_concat_5178
    tst x0, #1
    b.ne do_compose_5176
do_apply_5177:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5180
do_compose_5176:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5180
do_concat_5178:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5180
id_morphism_5179:
    b apply_end_5180
apply_end_5180:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5184
    tst x9, #1
    b.eq do_concat_5183
    tst x0, #1
    b.ne do_compose_5181
do_apply_5182:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5185
do_compose_5181:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5185
do_concat_5183:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5185
id_morphism_5184:
    b apply_end_5185
apply_end_5185:
blk_end_5095:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5189
    tst x9, #1
    b.eq do_concat_5188
    tst x0, #1
    b.ne do_compose_5186
do_apply_5187:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5190
do_compose_5186:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5190
do_concat_5188:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5190
id_morphism_5189:
    b apply_end_5190
apply_end_5190:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5194
    tst x9, #1
    b.eq do_concat_5193
    tst x0, #1
    b.ne do_compose_5191
do_apply_5192:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5195
do_compose_5191:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5195
do_concat_5193:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5195
id_morphism_5194:
    b apply_end_5195
apply_end_5195:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5090
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_arg
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5199
    tst x9, #1
    b.eq do_concat_5198
    tst x0, #1
    b.ne do_compose_5196
do_apply_5197:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5200
do_compose_5196:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5200
do_concat_5198:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5200
id_morphism_5199:
    b apply_end_5200
apply_end_5200:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_arg
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5204
    tst x9, #1
    b.eq do_concat_5203
    tst x0, #1
    b.ne do_compose_5201
do_apply_5202:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5205
do_compose_5201:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5205
do_concat_5203:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5205
id_morphism_5204:
    b apply_end_5205
apply_end_5205:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5209
    tst x9, #1
    b.eq do_concat_5208
    tst x0, #1
    b.ne do_compose_5206
do_apply_5207:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5210
do_compose_5206:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5210
do_concat_5208:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5210
id_morphism_5209:
    b apply_end_5210
apply_end_5210:
blk_end_5090:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5214
    tst x9, #1
    b.eq do_concat_5213
    tst x0, #1
    b.ne do_compose_5211
do_apply_5212:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5215
do_compose_5211:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5215
do_concat_5213:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5215
id_morphism_5214:
    b apply_end_5215
apply_end_5215:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5087
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, arg
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5219
    tst x9, #1
    b.eq do_concat_5218
    tst x0, #1
    b.ne do_compose_5216
do_apply_5217:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5220
do_compose_5216:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5220
do_concat_5218:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5220
id_morphism_5219:
    b apply_end_5220
apply_end_5220:
    str x0, [sp, #-16]!
    adr x0, ctx_func
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5224
    tst x9, #1
    b.eq do_concat_5223
    tst x0, #1
    b.ne do_compose_5221
do_apply_5222:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5225
do_compose_5221:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5225
do_concat_5223:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5225
id_morphism_5224:
    b apply_end_5225
apply_end_5225:
blk_end_5087:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5229
    tst x9, #1
    b.eq do_concat_5228
    tst x0, #1
    b.ne do_compose_5226
do_apply_5227:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5230
do_compose_5226:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5230
do_concat_5228:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5230
id_morphism_5229:
    b apply_end_5230
apply_end_5230:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5082
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_func
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5234
    tst x9, #1
    b.eq do_concat_5233
    tst x0, #1
    b.ne do_compose_5231
do_apply_5232:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5235
do_compose_5231:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5235
do_concat_5233:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5235
id_morphism_5234:
    b apply_end_5235
apply_end_5235:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_func
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5239
    tst x9, #1
    b.eq do_concat_5238
    tst x0, #1
    b.ne do_compose_5236
do_apply_5237:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5240
do_compose_5236:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5240
do_concat_5238:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5240
id_morphism_5239:
    b apply_end_5240
apply_end_5240:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5244
    tst x9, #1
    b.eq do_concat_5243
    tst x0, #1
    b.ne do_compose_5241
do_apply_5242:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5245
do_compose_5241:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5245
do_concat_5243:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5245
id_morphism_5244:
    b apply_end_5245
apply_end_5245:
blk_end_5082:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5249
    tst x9, #1
    b.eq do_concat_5248
    tst x0, #1
    b.ne do_compose_5246
do_apply_5247:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5250
do_compose_5246:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5250
do_concat_5248:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5250
id_morphism_5249:
    b apply_end_5250
apply_end_5250:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5079
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, func
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5254
    tst x9, #1
    b.eq do_concat_5253
    tst x0, #1
    b.ne do_compose_5251
do_apply_5252:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5255
do_compose_5251:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5255
do_concat_5253:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5255
id_morphism_5254:
    b apply_end_5255
apply_end_5255:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5259
    tst x9, #1
    b.eq do_concat_5258
    tst x0, #1
    b.ne do_compose_5256
do_apply_5257:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5260
do_compose_5256:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5260
do_concat_5258:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5260
id_morphism_5259:
    b apply_end_5260
apply_end_5260:
blk_end_5079:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5264
    tst x9, #1
    b.eq do_concat_5263
    tst x0, #1
    b.ne do_compose_5261
do_apply_5262:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5265
do_compose_5261:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5265
do_concat_5263:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5265
id_morphism_5264:
    b apply_end_5265
apply_end_5265:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5074
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5269
    tst x9, #1
    b.eq do_concat_5268
    tst x0, #1
    b.ne do_compose_5266
do_apply_5267:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5270
do_compose_5266:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5270
do_concat_5268:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5270
id_morphism_5269:
    b apply_end_5270
apply_end_5270:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5274
    tst x9, #1
    b.eq do_concat_5273
    tst x0, #1
    b.ne do_compose_5271
do_apply_5272:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5275
do_compose_5271:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5275
do_concat_5273:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5275
id_morphism_5274:
    b apply_end_5275
apply_end_5275:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5279
    tst x9, #1
    b.eq do_concat_5278
    tst x0, #1
    b.ne do_compose_5276
do_apply_5277:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5280
do_compose_5276:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5280
do_concat_5278:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5280
id_morphism_5279:
    b apply_end_5280
apply_end_5280:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5284
    tst x9, #1
    b.eq do_concat_5283
    tst x0, #1
    b.ne do_compose_5281
do_apply_5282:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5285
do_compose_5281:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5285
do_concat_5283:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5285
id_morphism_5284:
    b apply_end_5285
apply_end_5285:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5289
    tst x9, #1
    b.eq do_concat_5288
    tst x0, #1
    b.ne do_compose_5286
do_apply_5287:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5290
do_compose_5286:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5290
do_concat_5288:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5290
id_morphism_5289:
    b apply_end_5290
apply_end_5290:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5294
    tst x9, #1
    b.eq do_concat_5293
    tst x0, #1
    b.ne do_compose_5291
do_apply_5292:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5295
do_compose_5291:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5295
do_concat_5293:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5295
id_morphism_5294:
    b apply_end_5295
apply_end_5295:
blk_end_5074:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5072_5073:
    // Closure for func_5072
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5072
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5070_5071:
    // Closure for func_5070
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5070
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5064
cond_false_5063:
    adr x0, sign_id
cond_end_5064:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, push_var
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5301
    tst x9, #1
    b.eq do_concat_5300
    tst x0, #1
    b.ne do_compose_5298
do_apply_5299:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5302
do_compose_5298:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5302
do_concat_5300:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5302
id_morphism_5301:
    b apply_end_5302
apply_end_5302:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5296
    b after_func_5303_5304
func_5303:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5305_5306
func_5305:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5308_5309
func_5308:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5308_5309:
    // Closure for func_5308
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5308
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5314
    tst x9, #1
    b.eq do_concat_5313
    tst x0, #1
    b.ne do_compose_5311
do_apply_5312:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5315
do_compose_5311:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5315
do_concat_5313:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5315
id_morphism_5314:
    b apply_end_5315
apply_end_5315:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5310
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5319
    tst x9, #1
    b.eq do_concat_5318
    tst x0, #1
    b.ne do_compose_5316
do_apply_5317:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5320
do_compose_5316:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5320
do_concat_5318:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5320
id_morphism_5319:
    b apply_end_5320
apply_end_5320:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5310
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5324
    tst x9, #1
    b.eq do_concat_5323
    tst x0, #1
    b.ne do_compose_5321
do_apply_5322:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5325
do_compose_5321:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5325
do_concat_5323:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5325
id_morphism_5324:
    b apply_end_5325
apply_end_5325:
    str x0, [sp, #-16]!
    adr x0, offset
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5329
    tst x9, #1
    b.eq do_concat_5328
    tst x0, #1
    b.ne do_compose_5326
do_apply_5327:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5330
do_compose_5326:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5330
do_concat_5328:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5330
id_morphism_5329:
    b apply_end_5330
apply_end_5330:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5334
    tst x9, #1
    b.eq do_concat_5333
    tst x0, #1
    b.ne do_compose_5331
do_apply_5332:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5335
do_compose_5331:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5335
do_concat_5333:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5335
id_morphism_5334:
    b apply_end_5335
apply_end_5335:
    str x0, [sp, #-16]!
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5339
    tst x9, #1
    b.eq do_concat_5338
    tst x0, #1
    b.ne do_compose_5336
do_apply_5337:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5340
do_compose_5336:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5340
do_concat_5338:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5340
id_morphism_5339:
    b apply_end_5340
apply_end_5340:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5344
    tst x9, #1
    b.eq do_concat_5343
    tst x0, #1
    b.ne do_compose_5341
do_apply_5342:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5345
do_compose_5341:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5345
do_concat_5343:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5345
id_morphism_5344:
    b apply_end_5345
apply_end_5345:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5310
    adr x0, offset
blk_end_5310:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5349
    tst x9, #1
    b.eq do_concat_5348
    tst x0, #1
    b.ne do_compose_5346
do_apply_5347:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5350
do_compose_5346:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5350
do_concat_5348:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5350
id_morphism_5349:
    b apply_end_5350
apply_end_5350:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5354
    tst x9, #1
    b.eq do_concat_5353
    tst x0, #1
    b.ne do_compose_5351
do_apply_5352:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5355
do_compose_5351:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5355
do_concat_5353:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5355
id_morphism_5354:
    b apply_end_5355
apply_end_5355:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5307
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5359
    tst x9, #1
    b.eq do_concat_5358
    tst x0, #1
    b.ne do_compose_5356
do_apply_5357:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5360
do_compose_5356:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5360
do_concat_5358:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5360
id_morphism_5359:
    b apply_end_5360
apply_end_5360:
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    sub x0, x1, x0
blk_end_5307:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5305_5306:
    // Closure for func_5305
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5305
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5303_5304:
    // Closure for func_5303
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5303
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5297
cond_false_5296:
    adr x0, sign_id
cond_end_5297:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, add_string
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5366
    tst x9, #1
    b.eq do_concat_5365
    tst x0, #1
    b.ne do_compose_5363
do_apply_5364:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5367
do_compose_5363:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5367
do_concat_5365:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5367
id_morphism_5366:
    b apply_end_5367
apply_end_5367:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5361
    b after_func_5368_5369
func_5368:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5370_5371
func_5370:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, str_41
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5372
    b after_func_5373_5374
func_5373:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5373_5374:
    // Closure for func_5373
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5373
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5376_5377
func_5376:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5376_5377:
    // Closure for func_5376
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5376
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, label
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5378
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, count
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5379
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, label
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5383
    tst x9, #1
    b.eq do_concat_5382
    tst x0, #1
    b.ne do_compose_5380
do_apply_5381:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5384
do_compose_5380:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5384
do_concat_5382:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5384
id_morphism_5383:
    b apply_end_5384
apply_end_5384:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5388
    tst x9, #1
    b.eq do_concat_5387
    tst x0, #1
    b.ne do_compose_5385
do_apply_5386:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5389
do_compose_5385:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5389
do_concat_5387:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5389
id_morphism_5388:
    b apply_end_5389
apply_end_5389:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5393
    tst x9, #1
    b.eq do_concat_5392
    tst x0, #1
    b.ne do_compose_5390
do_apply_5391:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5394
do_compose_5390:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5394
do_concat_5392:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5394
id_morphism_5393:
    b apply_end_5394
apply_end_5394:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5398
    tst x9, #1
    b.eq do_concat_5397
    tst x0, #1
    b.ne do_compose_5395
do_apply_5396:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5399
do_compose_5395:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5399
do_concat_5397:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5399
id_morphism_5398:
    b apply_end_5399
apply_end_5399:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5403
    tst x9, #1
    b.eq do_concat_5402
    tst x0, #1
    b.ne do_compose_5400
do_apply_5401:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5404
do_compose_5400:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5404
do_concat_5402:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5404
id_morphism_5403:
    b apply_end_5404
apply_end_5404:
    str x0, [sp, #-16]!
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5408
    tst x9, #1
    b.eq do_concat_5407
    tst x0, #1
    b.ne do_compose_5405
do_apply_5406:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5409
do_compose_5405:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5409
do_concat_5407:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5409
id_morphism_5408:
    b apply_end_5409
apply_end_5409:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5413
    tst x9, #1
    b.eq do_concat_5412
    tst x0, #1
    b.ne do_compose_5410
do_apply_5411:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5414
do_compose_5410:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5414
do_concat_5412:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5414
id_morphism_5413:
    b apply_end_5414
apply_end_5414:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5379
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5418
    tst x9, #1
    b.eq do_concat_5417
    tst x0, #1
    b.ne do_compose_5415
do_apply_5416:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5419
do_compose_5415:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5419
do_concat_5417:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5419
id_morphism_5418:
    b apply_end_5419
apply_end_5419:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5379
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5423
    tst x9, #1
    b.eq do_concat_5422
    tst x0, #1
    b.ne do_compose_5420
do_apply_5421:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5424
do_compose_5420:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5424
do_concat_5422:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5424
id_morphism_5423:
    b apply_end_5424
apply_end_5424:
blk_end_5379:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5428
    tst x9, #1
    b.eq do_concat_5427
    tst x0, #1
    b.ne do_compose_5425
do_apply_5426:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5429
do_compose_5425:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5429
do_concat_5427:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5429
id_morphism_5428:
    b apply_end_5429
apply_end_5429:
blk_end_5378:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5433
    tst x9, #1
    b.eq do_concat_5432
    tst x0, #1
    b.ne do_compose_5430
do_apply_5431:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5434
do_compose_5430:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5434
do_concat_5432:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5434
id_morphism_5433:
    b apply_end_5434
apply_end_5434:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5438
    tst x9, #1
    b.eq do_concat_5437
    tst x0, #1
    b.ne do_compose_5435
do_apply_5436:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5439
do_compose_5435:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5439
do_concat_5437:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5439
id_morphism_5438:
    b apply_end_5439
apply_end_5439:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5375
    adr x0, make_label
    str x0, [sp, #-16]!
    adr x0, str_42
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5443
    tst x9, #1
    b.eq do_concat_5442
    tst x0, #1
    b.ne do_compose_5440
do_apply_5441:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5444
do_compose_5440:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5444
do_concat_5442:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5444
id_morphism_5443:
    b apply_end_5444
apply_end_5444:
    str x0, [sp, #-16]!
    adr x0, count
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5448
    tst x9, #1
    b.eq do_concat_5447
    tst x0, #1
    b.ne do_compose_5445
do_apply_5446:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5449
do_compose_5445:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5449
do_concat_5447:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5449
id_morphism_5448:
    b apply_end_5449
apply_end_5449:
blk_end_5375:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5453
    tst x9, #1
    b.eq do_concat_5452
    tst x0, #1
    b.ne do_compose_5450
do_apply_5451:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5454
do_compose_5450:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5454
do_concat_5452:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5454
id_morphism_5453:
    b apply_end_5454
apply_end_5454:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5372
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5458
    tst x9, #1
    b.eq do_concat_5457
    tst x0, #1
    b.ne do_compose_5455
do_apply_5456:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5459
do_compose_5455:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5459
do_concat_5457:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5459
id_morphism_5458:
    b apply_end_5459
apply_end_5459:
blk_end_5372:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5370_5371:
    // Closure for func_5370
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5370
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5368_5369:
    // Closure for func_5368
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5368
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5362
cond_false_5361:
    adr x0, sign_id
cond_end_5362:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strlen
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5465
    tst x9, #1
    b.eq do_concat_5464
    tst x0, #1
    b.ne do_compose_5462
do_apply_5463:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5466
do_compose_5462:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5466
do_concat_5464:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5466
id_morphism_5465:
    b apply_end_5466
apply_end_5466:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5460
    b after_func_5467_5468
func_5467:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5470_5471
func_5470:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5470_5471:
    // Closure for func_5470
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5470
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5475
    adr x0, sign_id
    b cmp_end_5476
cmp_true_5475:
cmp_end_5476:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5473
    mov x0, #0
    b cond_end_5474
cond_false_5473:
    adr x0, sign_id
cond_end_5474:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5472
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, strlen
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5480
    tst x9, #1
    b.eq do_concat_5479
    tst x0, #1
    b.ne do_compose_5477
do_apply_5478:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5481
do_compose_5477:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5481
do_concat_5479:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5481
id_morphism_5480:
    b apply_end_5481
apply_end_5481:
blk_end_5472:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5485
    tst x9, #1
    b.eq do_concat_5484
    tst x0, #1
    b.ne do_compose_5482
do_apply_5483:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5486
do_compose_5482:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5486
do_concat_5484:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5486
id_morphism_5485:
    b apply_end_5486
apply_end_5486:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5469
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_5469:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5467_5468:
    // Closure for func_5467
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5467
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5461
cond_false_5460:
    adr x0, sign_id
cond_end_5461:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strcpy
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5492
    tst x9, #1
    b.eq do_concat_5491
    tst x0, #1
    b.ne do_compose_5489
do_apply_5490:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5493
do_compose_5489:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5493
do_concat_5491:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5493
id_morphism_5492:
    b apply_end_5493
apply_end_5493:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5487
    b after_func_5494_5495
func_5494:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5496_5497
func_5496:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5499_5500
func_5499:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5499_5500:
    // Closure for func_5499
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5499
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5504
    adr x0, sign_id
    b cmp_end_5505
cmp_true_5504:
cmp_end_5505:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5502
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5506
    ldr x0, [x29, #-48]
blk_end_5506:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5510
    tst x9, #1
    b.eq do_concat_5509
    tst x0, #1
    b.ne do_compose_5507
do_apply_5508:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5511
do_compose_5507:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5511
do_concat_5509:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5511
id_morphism_5510:
    b apply_end_5511
apply_end_5511:
    b cond_end_5503
cond_false_5502:
    adr x0, sign_id
cond_end_5503:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5501
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5501
    adr x0, strcpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5515
    tst x9, #1
    b.eq do_concat_5514
    tst x0, #1
    b.ne do_compose_5512
do_apply_5513:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5516
do_compose_5512:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5516
do_concat_5514:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5516
id_morphism_5515:
    b apply_end_5516
apply_end_5516:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5520
    tst x9, #1
    b.eq do_concat_5519
    tst x0, #1
    b.ne do_compose_5517
do_apply_5518:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5521
do_compose_5517:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5521
do_concat_5519:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5521
id_morphism_5520:
    b apply_end_5521
apply_end_5521:
blk_end_5501:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5525
    tst x9, #1
    b.eq do_concat_5524
    tst x0, #1
    b.ne do_compose_5522
do_apply_5523:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5526
do_compose_5522:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5526
do_concat_5524:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5526
id_morphism_5525:
    b apply_end_5526
apply_end_5526:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5498
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_5498:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5496_5497:
    // Closure for func_5496
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5496
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5494_5495:
    // Closure for func_5494
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5494
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5488
cond_false_5487:
    adr x0, sign_id
cond_end_5488:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strcat
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5532
    tst x9, #1
    b.eq do_concat_5531
    tst x0, #1
    b.ne do_compose_5529
do_apply_5530:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5533
do_compose_5529:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5533
do_concat_5531:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5533
id_morphism_5532:
    b apply_end_5533
apply_end_5533:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5527
    b after_func_5534_5535
func_5534:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5536_5537
func_5536:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5539_5540
func_5539:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5539_5540:
    // Closure for func_5539
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5539
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, strcpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, len
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5545
    tst x9, #1
    b.eq do_concat_5544
    tst x0, #1
    b.ne do_compose_5542
do_apply_5543:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5546
do_compose_5542:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5546
do_concat_5544:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5546
id_morphism_5545:
    b apply_end_5546
apply_end_5546:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5550
    tst x9, #1
    b.eq do_concat_5549
    tst x0, #1
    b.ne do_compose_5547
do_apply_5548:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5551
do_compose_5547:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5551
do_concat_5549:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5551
id_morphism_5550:
    b apply_end_5551
apply_end_5551:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5541
    ldr x0, [x29, #-48]
blk_end_5541:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5555
    tst x9, #1
    b.eq do_concat_5554
    tst x0, #1
    b.ne do_compose_5552
do_apply_5553:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5556
do_compose_5552:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5556
do_concat_5554:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5556
id_morphism_5555:
    b apply_end_5556
apply_end_5556:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5538
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5560
    tst x9, #1
    b.eq do_concat_5559
    tst x0, #1
    b.ne do_compose_5557
do_apply_5558:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5561
do_compose_5557:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5561
do_concat_5559:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5561
id_morphism_5560:
    b apply_end_5561
apply_end_5561:
blk_end_5538:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5536_5537:
    // Closure for func_5536
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5536
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5534_5535:
    // Closure for func_5534
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5534
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5528
cond_false_5527:
    adr x0, sign_id
cond_end_5528:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5567
    tst x9, #1
    b.eq do_concat_5566
    tst x0, #1
    b.ne do_compose_5564
do_apply_5565:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5568
do_compose_5564:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5568
do_concat_5566:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5568
id_morphism_5567:
    b apply_end_5568
apply_end_5568:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5562
    b after_func_5569_5570
func_5569:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5571_5572
func_5571:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5574_5575
func_5574:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5574_5575:
    // Closure for func_5574
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5574
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5577_5578
func_5577:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5577_5578:
    // Closure for func_5577
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5577
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5580_5581
func_5580:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5580_5581:
    // Closure for func_5580
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5580
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, strcpy
    str x0, [sp, #-16]!
    adr x0, new_s
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5586
    tst x9, #1
    b.eq do_concat_5585
    tst x0, #1
    b.ne do_compose_5583
do_apply_5584:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5587
do_compose_5583:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5587
do_concat_5585:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5587
id_morphism_5586:
    b apply_end_5587
apply_end_5587:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5591
    tst x9, #1
    b.eq do_concat_5590
    tst x0, #1
    b.ne do_compose_5588
do_apply_5589:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5592
do_compose_5588:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5592
do_concat_5590:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5592
id_morphism_5591:
    b apply_end_5592
apply_end_5592:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5582
    adr x0, strcpy
    str x0, [sp, #-16]!
    adr x0, new_s
    str x0, [sp, #-16]!
    adr x0, len1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5596
    tst x9, #1
    b.eq do_concat_5595
    tst x0, #1
    b.ne do_compose_5593
do_apply_5594:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5597
do_compose_5593:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5597
do_concat_5595:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5597
id_morphism_5596:
    b apply_end_5597
apply_end_5597:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5601
    tst x9, #1
    b.eq do_concat_5600
    tst x0, #1
    b.ne do_compose_5598
do_apply_5599:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5602
do_compose_5598:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5602
do_concat_5600:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5602
id_morphism_5601:
    b apply_end_5602
apply_end_5602:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5582
    adr x0, new_s
blk_end_5582:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5606
    tst x9, #1
    b.eq do_concat_5605
    tst x0, #1
    b.ne do_compose_5603
do_apply_5604:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5607
do_compose_5603:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5607
do_concat_5605:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5607
id_morphism_5606:
    b apply_end_5607
apply_end_5607:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5579
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, len1
    str x0, [sp, #-16]!
    adr x0, len2
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5611
    tst x9, #1
    b.eq do_concat_5610
    tst x0, #1
    b.ne do_compose_5608
do_apply_5609:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5612
do_compose_5608:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5612
do_concat_5610:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5612
id_morphism_5611:
    b apply_end_5612
apply_end_5612:
blk_end_5579:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5616
    tst x9, #1
    b.eq do_concat_5615
    tst x0, #1
    b.ne do_compose_5613
do_apply_5614:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5617
do_compose_5613:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5617
do_concat_5615:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5617
id_morphism_5616:
    b apply_end_5617
apply_end_5617:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5576
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5621
    tst x9, #1
    b.eq do_concat_5620
    tst x0, #1
    b.ne do_compose_5618
do_apply_5619:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5622
do_compose_5618:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5622
do_concat_5620:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5622
id_morphism_5621:
    b apply_end_5622
apply_end_5622:
blk_end_5576:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5626
    tst x9, #1
    b.eq do_concat_5625
    tst x0, #1
    b.ne do_compose_5623
do_apply_5624:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5627
do_compose_5623:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5627
do_concat_5625:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5627
id_morphism_5626:
    b apply_end_5627
apply_end_5627:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5573
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5631
    tst x9, #1
    b.eq do_concat_5630
    tst x0, #1
    b.ne do_compose_5628
do_apply_5629:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5632
do_compose_5628:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5632
do_concat_5630:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5632
id_morphism_5631:
    b apply_end_5632
apply_end_5632:
blk_end_5573:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5571_5572:
    // Closure for func_5571
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5571
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5569_5570:
    // Closure for func_5569
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5569
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5563
cond_false_5562:
    adr x0, sign_id
cond_end_5563:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat_list
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5638
    tst x9, #1
    b.eq do_concat_5637
    tst x0, #1
    b.ne do_compose_5635
do_apply_5636:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5639
do_compose_5635:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5639
do_concat_5637:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5639
id_morphism_5638:
    b apply_end_5639
apply_end_5639:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5633
    b after_func_5640_5641
func_5640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5645
    adr x0, sign_id
    b cmp_end_5646
cmp_true_5645:
cmp_end_5646:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5643
    adr x0, str_43
    b cond_end_5644
cond_false_5643:
    adr x0, sign_id
cond_end_5644:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5642
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5650
    tst x9, #1
    b.eq do_concat_5649
    tst x0, #1
    b.ne do_compose_5647
do_apply_5648:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5651
do_compose_5647:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5651
do_concat_5649:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5651
id_morphism_5650:
    b apply_end_5651
apply_end_5651:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5655
    tst x9, #1
    b.eq do_concat_5654
    tst x0, #1
    b.ne do_compose_5652
do_apply_5653:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5656
do_compose_5652:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5656
do_concat_5654:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5656
id_morphism_5655:
    b apply_end_5656
apply_end_5656:
    str x0, [sp, #-16]!
    adr x0, concat_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5660
    tst x9, #1
    b.eq do_concat_5659
    tst x0, #1
    b.ne do_compose_5657
do_apply_5658:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5661
do_compose_5657:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5661
do_concat_5659:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5661
id_morphism_5660:
    b apply_end_5661
apply_end_5661:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5665
    tst x9, #1
    b.eq do_concat_5664
    tst x0, #1
    b.ne do_compose_5662
do_apply_5663:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5666
do_compose_5662:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5666
do_concat_5664:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5666
id_morphism_5665:
    b apply_end_5666
apply_end_5666:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5670
    tst x9, #1
    b.eq do_concat_5669
    tst x0, #1
    b.ne do_compose_5667
do_apply_5668:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5671
do_compose_5667:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5671
do_concat_5669:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5671
id_morphism_5670:
    b apply_end_5671
apply_end_5671:
blk_end_5642:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5640_5641:
    // Closure for func_5640
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5640
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5634
cond_false_5633:
    adr x0, sign_id
cond_end_5634:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, int_to_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5677
    tst x9, #1
    b.eq do_concat_5676
    tst x0, #1
    b.ne do_compose_5674
do_apply_5675:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5678
do_compose_5674:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5678
do_concat_5676:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5678
id_morphism_5677:
    b apply_end_5678
apply_end_5678:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5672
    b after_func_5679_5680
func_5679:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5684
    adr x0, sign_id
    b cmp_end_5685
cmp_true_5684:
cmp_end_5685:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5682
    mov x0, #48
    b cond_end_5683
cond_false_5682:
    adr x0, sign_id
cond_end_5683:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5681
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_5688
    adr x0, sign_id
    b cmp_end_5689
cmp_true_5688:
cmp_end_5689:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5686
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5693
    tst x9, #1
    b.eq do_concat_5692
    tst x0, #1
    b.ne do_compose_5690
do_apply_5691:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5694
do_compose_5690:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5694
do_concat_5692:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5694
id_morphism_5693:
    b apply_end_5694
apply_end_5694:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5698
    tst x9, #1
    b.eq do_concat_5697
    tst x0, #1
    b.ne do_compose_5695
do_apply_5696:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5699
do_compose_5695:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5699
do_concat_5697:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5699
id_morphism_5698:
    b apply_end_5699
apply_end_5699:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5703
    tst x9, #1
    b.eq do_concat_5702
    tst x0, #1
    b.ne do_compose_5700
do_apply_5701:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5704
do_compose_5700:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5704
do_concat_5702:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5704
id_morphism_5703:
    b apply_end_5704
apply_end_5704:
    b cond_end_5687
cond_false_5686:
    adr x0, sign_id
cond_end_5687:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5681
    adr x0, _int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5708
    tst x9, #1
    b.eq do_concat_5707
    tst x0, #1
    b.ne do_compose_5705
do_apply_5706:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5709
do_compose_5705:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5709
do_concat_5707:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5709
id_morphism_5708:
    b apply_end_5709
apply_end_5709:
blk_end_5681:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5679_5680:
    // Closure for func_5679
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5679
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5673
cond_false_5672:
    adr x0, sign_id
cond_end_5673:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _int_to_str_rec
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5715
    tst x9, #1
    b.eq do_concat_5714
    tst x0, #1
    b.ne do_compose_5712
do_apply_5713:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5716
do_compose_5712:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5716
do_concat_5714:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5716
id_morphism_5715:
    b apply_end_5716
apply_end_5716:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5710
    b after_func_5717_5718
func_5717:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5722
    adr x0, sign_id
    b cmp_end_5723
cmp_true_5722:
cmp_end_5723:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5720
    adr x0, str_43
    b cond_end_5721
cond_false_5720:
    adr x0, sign_id
cond_end_5721:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5719
    b after_func_5724_5725
func_5724:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5724_5725:
    // Closure for func_5724
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5724
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, _int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5729
    tst x9, #1
    b.eq do_concat_5728
    tst x0, #1
    b.ne do_compose_5726
do_apply_5727:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5730
do_compose_5726:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5730
do_concat_5728:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5730
id_morphism_5729:
    b apply_end_5730
apply_end_5730:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5734
    tst x9, #1
    b.eq do_concat_5733
    tst x0, #1
    b.ne do_compose_5731
do_apply_5732:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5735
do_compose_5731:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5735
do_concat_5733:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5735
id_morphism_5734:
    b apply_end_5735
apply_end_5735:
    str x0, [sp, #-16]!
    adr x0, char_to_str
    str x0, [sp, #-16]!
    adr x0, digit
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5739
    tst x9, #1
    b.eq do_concat_5738
    tst x0, #1
    b.ne do_compose_5736
do_apply_5737:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5740
do_compose_5736:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5740
do_concat_5738:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5740
id_morphism_5739:
    b apply_end_5740
apply_end_5740:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5744
    tst x9, #1
    b.eq do_concat_5743
    tst x0, #1
    b.ne do_compose_5741
do_apply_5742:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5745
do_compose_5741:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5745
do_concat_5743:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5745
id_morphism_5744:
    b apply_end_5745
apply_end_5745:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5749
    tst x9, #1
    b.eq do_concat_5748
    tst x0, #1
    b.ne do_compose_5746
do_apply_5747:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5750
do_compose_5746:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5750
do_concat_5748:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5750
id_morphism_5749:
    b apply_end_5750
apply_end_5750:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5719
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
blk_end_5719:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5717_5718:
    // Closure for func_5717
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5717
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5711
cond_false_5710:
    adr x0, sign_id
cond_end_5711:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, char_to_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5756
    tst x9, #1
    b.eq do_concat_5755
    tst x0, #1
    b.ne do_compose_5753
do_apply_5754:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5757
do_compose_5753:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5757
do_concat_5755:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5757
id_morphism_5756:
    b apply_end_5757
apply_end_5757:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5751
    b after_func_5758_5759
func_5758:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5761_5762
func_5761:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5761_5762:
    // Closure for func_5761
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5761
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, s
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5763
    adr x0, s
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
    b.ne blk_end_5763
    adr x0, s
blk_end_5763:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5767
    tst x9, #1
    b.eq do_concat_5766
    tst x0, #1
    b.ne do_compose_5764
do_apply_5765:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5768
do_compose_5764:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5768
do_concat_5766:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5768
id_morphism_5767:
    b apply_end_5768
apply_end_5768:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5760
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5772
    tst x9, #1
    b.eq do_concat_5771
    tst x0, #1
    b.ne do_compose_5769
do_apply_5770:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5773
do_compose_5769:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5773
do_concat_5771:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5773
id_morphism_5772:
    b apply_end_5773
apply_end_5773:
blk_end_5760:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5758_5759:
    // Closure for func_5758
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5758
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5752
cond_false_5751:
    adr x0, sign_id
cond_end_5752:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, emit_num
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5779
    tst x9, #1
    b.eq do_concat_5778
    tst x0, #1
    b.ne do_compose_5776
do_apply_5777:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5780
do_compose_5776:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5780
do_concat_5778:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5780
id_morphism_5779:
    b apply_end_5780
apply_end_5780:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5774
    b after_func_5781_5782
func_5781:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5783_5784
func_5783:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5788
    tst x9, #1
    b.eq do_concat_5787
    tst x0, #1
    b.ne do_compose_5785
do_apply_5786:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5789
do_compose_5785:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5789
do_concat_5787:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5789
id_morphism_5788:
    b apply_end_5789
apply_end_5789:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5793
    tst x9, #1
    b.eq do_concat_5792
    tst x0, #1
    b.ne do_compose_5790
do_apply_5791:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5794
do_compose_5790:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5794
do_concat_5792:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5794
id_morphism_5793:
    b apply_end_5794
apply_end_5794:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5798
    tst x9, #1
    b.eq do_concat_5797
    tst x0, #1
    b.ne do_compose_5795
do_apply_5796:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5799
do_compose_5795:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5799
do_concat_5797:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5799
id_morphism_5798:
    b apply_end_5799
apply_end_5799:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5783_5784:
    // Closure for func_5783
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5783
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5781_5782:
    // Closure for func_5781
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5781
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5775
cond_false_5774:
    adr x0, sign_id
cond_end_5775:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_label
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5805
    tst x9, #1
    b.eq do_concat_5804
    tst x0, #1
    b.ne do_compose_5802
do_apply_5803:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5806
do_compose_5802:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5806
do_concat_5804:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5806
id_morphism_5805:
    b apply_end_5806
apply_end_5806:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5800
    b after_func_5807_5808
func_5807:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5809_5810
func_5809:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5814
    tst x9, #1
    b.eq do_concat_5813
    tst x0, #1
    b.ne do_compose_5811
do_apply_5812:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5815
do_compose_5811:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5815
do_concat_5813:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5815
id_morphism_5814:
    b apply_end_5815
apply_end_5815:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #95
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5819
    tst x9, #1
    b.eq do_concat_5818
    tst x0, #1
    b.ne do_compose_5816
do_apply_5817:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5820
do_compose_5816:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5820
do_concat_5818:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5820
id_morphism_5819:
    b apply_end_5820
apply_end_5820:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5824
    tst x9, #1
    b.eq do_concat_5823
    tst x0, #1
    b.ne do_compose_5821
do_apply_5822:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5825
do_compose_5821:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5825
do_concat_5823:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5825
id_morphism_5824:
    b apply_end_5825
apply_end_5825:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5829
    tst x9, #1
    b.eq do_concat_5828
    tst x0, #1
    b.ne do_compose_5826
do_apply_5827:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5830
do_compose_5826:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5830
do_concat_5828:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5830
id_morphism_5829:
    b apply_end_5830
apply_end_5830:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5834
    tst x9, #1
    b.eq do_concat_5833
    tst x0, #1
    b.ne do_compose_5831
do_apply_5832:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5835
do_compose_5831:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5835
do_concat_5833:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5835
id_morphism_5834:
    b apply_end_5835
apply_end_5835:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5809_5810:
    // Closure for func_5809
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5809
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5807_5808:
    // Closure for func_5807
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5807
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5801
cond_false_5800:
    adr x0, sign_id
cond_end_5801:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, new_label
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5841
    tst x9, #1
    b.eq do_concat_5840
    tst x0, #1
    b.ne do_compose_5838
do_apply_5839:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5842
do_compose_5838:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5842
do_concat_5840:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5842
id_morphism_5841:
    b apply_end_5842
apply_end_5842:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5836
    b after_func_5843_5844
func_5843:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5845_5846
func_5845:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5848_5849
func_5848:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5848_5849:
    // Closure for func_5848
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5848
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5851_5852
func_5851:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5851_5852:
    // Closure for func_5851
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5851
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lbl
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5853
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, count
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5854
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5858
    tst x9, #1
    b.eq do_concat_5857
    tst x0, #1
    b.ne do_compose_5855
do_apply_5856:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5859
do_compose_5855:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5859
do_concat_5857:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5859
id_morphism_5858:
    b apply_end_5859
apply_end_5859:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5854
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5863
    tst x9, #1
    b.eq do_concat_5862
    tst x0, #1
    b.ne do_compose_5860
do_apply_5861:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5864
do_compose_5860:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5864
do_concat_5862:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5864
id_morphism_5863:
    b apply_end_5864
apply_end_5864:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5854
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5868
    tst x9, #1
    b.eq do_concat_5867
    tst x0, #1
    b.ne do_compose_5865
do_apply_5866:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5869
do_compose_5865:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5869
do_concat_5867:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5869
id_morphism_5868:
    b apply_end_5869
apply_end_5869:
blk_end_5854:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5873
    tst x9, #1
    b.eq do_concat_5872
    tst x0, #1
    b.ne do_compose_5870
do_apply_5871:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5874
do_compose_5870:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5874
do_concat_5872:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5874
id_morphism_5873:
    b apply_end_5874
apply_end_5874:
blk_end_5853:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5878
    tst x9, #1
    b.eq do_concat_5877
    tst x0, #1
    b.ne do_compose_5875
do_apply_5876:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5879
do_compose_5875:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5879
do_concat_5877:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5879
id_morphism_5878:
    b apply_end_5879
apply_end_5879:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5883
    tst x9, #1
    b.eq do_concat_5882
    tst x0, #1
    b.ne do_compose_5880
do_apply_5881:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5884
do_compose_5880:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5884
do_concat_5882:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5884
id_morphism_5883:
    b apply_end_5884
apply_end_5884:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5850
    adr x0, make_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5888
    tst x9, #1
    b.eq do_concat_5887
    tst x0, #1
    b.ne do_compose_5885
do_apply_5886:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5889
do_compose_5885:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5889
do_concat_5887:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5889
id_morphism_5888:
    b apply_end_5889
apply_end_5889:
    str x0, [sp, #-16]!
    adr x0, count
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5893
    tst x9, #1
    b.eq do_concat_5892
    tst x0, #1
    b.ne do_compose_5890
do_apply_5891:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5894
do_compose_5890:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5894
do_concat_5892:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5894
id_morphism_5893:
    b apply_end_5894
apply_end_5894:
blk_end_5850:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5898
    tst x9, #1
    b.eq do_concat_5897
    tst x0, #1
    b.ne do_compose_5895
do_apply_5896:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5899
do_compose_5895:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5899
do_concat_5897:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5899
id_morphism_5898:
    b apply_end_5899
apply_end_5899:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5847
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5903
    tst x9, #1
    b.eq do_concat_5902
    tst x0, #1
    b.ne do_compose_5900
do_apply_5901:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5904
do_compose_5900:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5904
do_concat_5902:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5904
id_morphism_5903:
    b apply_end_5904
apply_end_5904:
blk_end_5847:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5845_5846:
    // Closure for func_5845
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5845
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5843_5844:
    // Closure for func_5843
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5843
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5837
cond_false_5836:
    adr x0, sign_id
cond_end_5837:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_program
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5910
    tst x9, #1
    b.eq do_concat_5909
    tst x0, #1
    b.ne do_compose_5907
do_apply_5908:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5911
do_compose_5907:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5911
do_concat_5909:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5911
id_morphism_5910:
    b apply_end_5911
apply_end_5911:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5905
    b after_func_5912_5913
func_5912:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5915_5916
func_5915:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5915_5916:
    // Closure for func_5915
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5915
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5918_5919
func_5918:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5918_5919:
    // Closure for func_5918
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5918
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat_list
    str x0, [sp, #-16]!
    adr x0, asm_list
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5923
    tst x9, #1
    b.eq do_concat_5922
    tst x0, #1
    b.ne do_compose_5920
do_apply_5921:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5924
do_compose_5920:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5924
do_concat_5922:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5924
id_morphism_5923:
    b apply_end_5924
apply_end_5924:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5928
    tst x9, #1
    b.eq do_concat_5927
    tst x0, #1
    b.ne do_compose_5925
do_apply_5926:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5929
do_compose_5925:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5929
do_concat_5927:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5929
id_morphism_5928:
    b apply_end_5929
apply_end_5929:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5917
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5933
    tst x9, #1
    b.eq do_concat_5932
    tst x0, #1
    b.ne do_compose_5930
do_apply_5931:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5934
do_compose_5930:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5934
do_concat_5932:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5934
id_morphism_5933:
    b apply_end_5934
apply_end_5934:
blk_end_5917:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5938
    tst x9, #1
    b.eq do_concat_5937
    tst x0, #1
    b.ne do_compose_5935
do_apply_5936:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5939
do_compose_5935:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5939
do_concat_5937:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5939
id_morphism_5938:
    b apply_end_5939
apply_end_5939:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5914
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5943
    tst x9, #1
    b.eq do_concat_5942
    tst x0, #1
    b.ne do_compose_5940
do_apply_5941:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5944
do_compose_5940:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5944
do_concat_5942:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5944
id_morphism_5943:
    b apply_end_5944
apply_end_5944:
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5948
    tst x9, #1
    b.eq do_concat_5947
    tst x0, #1
    b.ne do_compose_5945
do_apply_5946:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5949
do_compose_5945:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5949
do_concat_5947:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5949
id_morphism_5948:
    b apply_end_5949
apply_end_5949:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5953
    tst x9, #1
    b.eq do_concat_5952
    tst x0, #1
    b.ne do_compose_5950
do_apply_5951:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5954
do_compose_5950:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5954
do_concat_5952:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5954
id_morphism_5953:
    b apply_end_5954
apply_end_5954:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5958
    tst x9, #1
    b.eq do_concat_5957
    tst x0, #1
    b.ne do_compose_5955
do_apply_5956:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5959
do_compose_5955:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5959
do_concat_5957:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5959
id_morphism_5958:
    b apply_end_5959
apply_end_5959:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5963
    tst x9, #1
    b.eq do_concat_5962
    tst x0, #1
    b.ne do_compose_5960
do_apply_5961:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5964
do_compose_5960:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5964
do_concat_5962:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5964
id_morphism_5963:
    b apply_end_5964
apply_end_5964:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5968
    tst x9, #1
    b.eq do_concat_5967
    tst x0, #1
    b.ne do_compose_5965
do_apply_5966:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5969
do_compose_5965:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5969
do_concat_5967:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5969
id_morphism_5968:
    b apply_end_5969
apply_end_5969:
blk_end_5914:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5912_5913:
    // Closure for func_5912
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5912
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5906
cond_false_5905:
    adr x0, sign_id
cond_end_5906:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_node
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5975
    tst x9, #1
    b.eq do_concat_5974
    tst x0, #1
    b.ne do_compose_5972
do_apply_5973:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5976
do_compose_5972:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5976
do_concat_5974:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5976
id_morphism_5975:
    b apply_end_5976
apply_end_5976:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5970
    b after_func_5977_5978
func_5977:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5979_5980
func_5979:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5982_5983
func_5982:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5982_5983:
    // Closure for func_5982
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5982
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5987
    adr x0, sign_id
    b cmp_end_5988
cmp_true_5987:
cmp_end_5988:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5985
    adr x0, compile_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5992
    tst x9, #1
    b.eq do_concat_5991
    tst x0, #1
    b.ne do_compose_5989
do_apply_5990:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5993
do_compose_5989:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5993
do_concat_5991:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5993
id_morphism_5992:
    b apply_end_5993
apply_end_5993:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_5997
    tst x9, #1
    b.eq do_concat_5996
    tst x0, #1
    b.ne do_compose_5994
do_apply_5995:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5998
do_compose_5994:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5998
do_concat_5996:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5998
id_morphism_5997:
    b apply_end_5998
apply_end_5998:
    b cond_end_5986
cond_false_5985:
    adr x0, sign_id
cond_end_5986:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5984
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6001
    adr x0, sign_id
    b cmp_end_6002
cmp_true_6001:
cmp_end_6002:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5999
    adr x0, compile_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6006
    tst x9, #1
    b.eq do_concat_6005
    tst x0, #1
    b.ne do_compose_6003
do_apply_6004:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6007
do_compose_6003:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6007
do_concat_6005:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6007
id_morphism_6006:
    b apply_end_6007
apply_end_6007:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6011
    tst x9, #1
    b.eq do_concat_6010
    tst x0, #1
    b.ne do_compose_6008
do_apply_6009:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6012
do_compose_6008:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6012
do_concat_6010:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6012
id_morphism_6011:
    b apply_end_6012
apply_end_6012:
    b cond_end_6000
cond_false_5999:
    adr x0, sign_id
cond_end_6000:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5984
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6015
    adr x0, sign_id
    b cmp_end_6016
cmp_true_6015:
cmp_end_6016:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6013
    adr x0, compile_block
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6020
    tst x9, #1
    b.eq do_concat_6019
    tst x0, #1
    b.ne do_compose_6017
do_apply_6018:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6021
do_compose_6017:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6021
do_concat_6019:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6021
id_morphism_6020:
    b apply_end_6021
apply_end_6021:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6025
    tst x9, #1
    b.eq do_concat_6024
    tst x0, #1
    b.ne do_compose_6022
do_apply_6023:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6026
do_compose_6022:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6026
do_concat_6024:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6026
id_morphism_6025:
    b apply_end_6026
apply_end_6026:
    b cond_end_6014
cond_false_6013:
    adr x0, sign_id
cond_end_6014:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5984
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6029
    adr x0, sign_id
    b cmp_end_6030
cmp_true_6029:
cmp_end_6030:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6027
    adr x0, compile_unit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6034
    tst x9, #1
    b.eq do_concat_6033
    tst x0, #1
    b.ne do_compose_6031
do_apply_6032:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6035
do_compose_6031:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6035
do_concat_6033:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6035
id_morphism_6034:
    b apply_end_6035
apply_end_6035:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6039
    tst x9, #1
    b.eq do_concat_6038
    tst x0, #1
    b.ne do_compose_6036
do_apply_6037:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6040
do_compose_6036:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6040
do_concat_6038:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6040
id_morphism_6039:
    b apply_end_6040
apply_end_6040:
    b cond_end_6028
cond_false_6027:
    adr x0, sign_id
cond_end_6028:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5984
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6043
    adr x0, sign_id
    b cmp_end_6044
cmp_true_6043:
cmp_end_6044:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6041
    adr x0, compile_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6048
    tst x9, #1
    b.eq do_concat_6047
    tst x0, #1
    b.ne do_compose_6045
do_apply_6046:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6049
do_compose_6045:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6049
do_concat_6047:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6049
id_morphism_6048:
    b apply_end_6049
apply_end_6049:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6053
    tst x9, #1
    b.eq do_concat_6052
    tst x0, #1
    b.ne do_compose_6050
do_apply_6051:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6054
do_compose_6050:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6054
do_concat_6052:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6054
id_morphism_6053:
    b apply_end_6054
apply_end_6054:
    b cond_end_6042
cond_false_6041:
    adr x0, sign_id
cond_end_6042:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5984
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6057
    adr x0, sign_id
    b cmp_end_6058
cmp_true_6057:
cmp_end_6058:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6055
    adr x0, compile_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6062
    tst x9, #1
    b.eq do_concat_6061
    tst x0, #1
    b.ne do_compose_6059
do_apply_6060:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6063
do_compose_6059:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6063
do_concat_6061:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6063
id_morphism_6062:
    b apply_end_6063
apply_end_6063:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6067
    tst x9, #1
    b.eq do_concat_6066
    tst x0, #1
    b.ne do_compose_6064
do_apply_6065:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6068
do_compose_6064:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6068
do_concat_6066:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6068
id_morphism_6067:
    b apply_end_6068
apply_end_6068:
    b cond_end_6056
cond_false_6055:
    adr x0, sign_id
cond_end_6056:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5984
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6071
    adr x0, sign_id
    b cmp_end_6072
cmp_true_6071:
cmp_end_6072:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6069
    adr x0, compile_apply
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6076
    tst x9, #1
    b.eq do_concat_6075
    tst x0, #1
    b.ne do_compose_6073
do_apply_6074:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6077
do_compose_6073:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6077
do_concat_6075:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6077
id_morphism_6076:
    b apply_end_6077
apply_end_6077:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6081
    tst x9, #1
    b.eq do_concat_6080
    tst x0, #1
    b.ne do_compose_6078
do_apply_6079:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6082
do_compose_6078:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6082
do_concat_6080:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6082
id_morphism_6081:
    b apply_end_6082
apply_end_6082:
    b cond_end_6070
cond_false_6069:
    adr x0, sign_id
cond_end_6070:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5984
    adr x0, str_44
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5984
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_45
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6086
    tst x9, #1
    b.eq do_concat_6085
    tst x0, #1
    b.ne do_compose_6083
do_apply_6084:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6087
do_compose_6083:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6087
do_concat_6085:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6087
id_morphism_6086:
    b apply_end_6087
apply_end_6087:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6091
    tst x9, #1
    b.eq do_concat_6090
    tst x0, #1
    b.ne do_compose_6088
do_apply_6089:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6092
do_compose_6088:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6092
do_concat_6090:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6092
id_morphism_6091:
    b apply_end_6092
apply_end_6092:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6096
    tst x9, #1
    b.eq do_concat_6095
    tst x0, #1
    b.ne do_compose_6093
do_apply_6094:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6097
do_compose_6093:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6097
do_concat_6095:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6097
id_morphism_6096:
    b apply_end_6097
apply_end_6097:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6101
    tst x9, #1
    b.eq do_concat_6100
    tst x0, #1
    b.ne do_compose_6098
do_apply_6099:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6102
do_compose_6098:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6102
do_concat_6100:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6102
id_morphism_6101:
    b apply_end_6102
apply_end_6102:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6106
    tst x9, #1
    b.eq do_concat_6105
    tst x0, #1
    b.ne do_compose_6103
do_apply_6104:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6107
do_compose_6103:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6107
do_concat_6105:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6107
id_morphism_6106:
    b apply_end_6107
apply_end_6107:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6111
    tst x9, #1
    b.eq do_concat_6110
    tst x0, #1
    b.ne do_compose_6108
do_apply_6109:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6112
do_compose_6108:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6112
do_concat_6110:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6112
id_morphism_6111:
    b apply_end_6112
apply_end_6112:
blk_end_5984:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6116
    tst x9, #1
    b.eq do_concat_6115
    tst x0, #1
    b.ne do_compose_6113
do_apply_6114:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6117
do_compose_6113:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6117
do_concat_6115:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6117
id_morphism_6116:
    b apply_end_6117
apply_end_6117:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5981
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6121
    tst x9, #1
    b.eq do_concat_6120
    tst x0, #1
    b.ne do_compose_6118
do_apply_6119:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6122
do_compose_6118:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6122
do_concat_6120:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6122
id_morphism_6121:
    b apply_end_6122
apply_end_6122:
blk_end_5981:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5979_5980:
    // Closure for func_5979
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5979
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5977_5978:
    // Closure for func_5977
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5977
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5971
cond_false_5970:
    adr x0, sign_id
cond_end_5971:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_num
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6128
    tst x9, #1
    b.eq do_concat_6127
    tst x0, #1
    b.ne do_compose_6125
do_apply_6126:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6129
do_compose_6125:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6129
do_concat_6127:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6129
id_morphism_6128:
    b apply_end_6129
apply_end_6129:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6123
    b after_func_6130_6131
func_6130:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6132_6133
func_6132:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_6135_6136
func_6135:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6135_6136:
    // Closure for func_6135
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6135
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_46
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6141
    tst x9, #1
    b.eq do_concat_6140
    tst x0, #1
    b.ne do_compose_6138
do_apply_6139:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6142
do_compose_6138:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6142
do_concat_6140:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6142
id_morphism_6141:
    b apply_end_6142
apply_end_6142:
    str x0, [sp, #-16]!
    adr x0, emit_num
    str x0, [sp, #-16]!
    adr x0, val
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6146
    tst x9, #1
    b.eq do_concat_6145
    tst x0, #1
    b.ne do_compose_6143
do_apply_6144:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6147
do_compose_6143:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6147
do_concat_6145:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6147
id_morphism_6146:
    b apply_end_6147
apply_end_6147:
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6151
    tst x9, #1
    b.eq do_concat_6150
    tst x0, #1
    b.ne do_compose_6148
do_apply_6149:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6152
do_compose_6148:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6152
do_concat_6150:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6152
id_morphism_6151:
    b apply_end_6152
apply_end_6152:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6156
    tst x9, #1
    b.eq do_concat_6155
    tst x0, #1
    b.ne do_compose_6153
do_apply_6154:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6157
do_compose_6153:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6157
do_concat_6155:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6157
id_morphism_6156:
    b apply_end_6157
apply_end_6157:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6161
    tst x9, #1
    b.eq do_concat_6160
    tst x0, #1
    b.ne do_compose_6158
do_apply_6159:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6162
do_compose_6158:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6162
do_concat_6160:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6162
id_morphism_6161:
    b apply_end_6162
apply_end_6162:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6166
    tst x9, #1
    b.eq do_concat_6165
    tst x0, #1
    b.ne do_compose_6163
do_apply_6164:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6167
do_compose_6163:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6167
do_concat_6165:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6167
id_morphism_6166:
    b apply_end_6167
apply_end_6167:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6137
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6171
    tst x9, #1
    b.eq do_concat_6170
    tst x0, #1
    b.ne do_compose_6168
do_apply_6169:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6172
do_compose_6168:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6172
do_concat_6170:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6172
id_morphism_6171:
    b apply_end_6172
apply_end_6172:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6176
    tst x9, #1
    b.eq do_concat_6175
    tst x0, #1
    b.ne do_compose_6173
do_apply_6174:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6177
do_compose_6173:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6177
do_concat_6175:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6177
id_morphism_6176:
    b apply_end_6177
apply_end_6177:
blk_end_6137:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6181
    tst x9, #1
    b.eq do_concat_6180
    tst x0, #1
    b.ne do_compose_6178
do_apply_6179:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6182
do_compose_6178:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6182
do_concat_6180:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6182
id_morphism_6181:
    b apply_end_6182
apply_end_6182:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6186
    tst x9, #1
    b.eq do_concat_6185
    tst x0, #1
    b.ne do_compose_6183
do_apply_6184:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6187
do_compose_6183:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6187
do_concat_6185:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6187
id_morphism_6186:
    b apply_end_6187
apply_end_6187:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6134
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6191
    tst x9, #1
    b.eq do_concat_6190
    tst x0, #1
    b.ne do_compose_6188
do_apply_6189:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6192
do_compose_6188:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6192
do_concat_6190:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6192
id_morphism_6191:
    b apply_end_6192
apply_end_6192:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6196
    tst x9, #1
    b.eq do_concat_6195
    tst x0, #1
    b.ne do_compose_6193
do_apply_6194:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6197
do_compose_6193:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6197
do_concat_6195:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6197
id_morphism_6196:
    b apply_end_6197
apply_end_6197:
blk_end_6134:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6132_6133:
    // Closure for func_6132
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6132
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6130_6131:
    // Closure for func_6130
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6130
    ldr x0, [sp], #16
    bl _cons
    b cond_end_6124
cond_false_6123:
    adr x0, sign_id
cond_end_6124:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_unit
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6203
    tst x9, #1
    b.eq do_concat_6202
    tst x0, #1
    b.ne do_compose_6200
do_apply_6201:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6204
do_compose_6200:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6204
do_concat_6202:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6204
id_morphism_6203:
    b apply_end_6204
apply_end_6204:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6198
    b after_func_6205_6206
func_6205:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6207_6208
func_6207:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6212
    tst x9, #1
    b.eq do_concat_6211
    tst x0, #1
    b.ne do_compose_6209
do_apply_6210:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6213
do_compose_6209:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6213
do_concat_6211:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6213
id_morphism_6212:
    b apply_end_6213
apply_end_6213:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6217
    tst x9, #1
    b.eq do_concat_6216
    tst x0, #1
    b.ne do_compose_6214
do_apply_6215:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6218
do_compose_6214:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6218
do_concat_6216:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6218
id_morphism_6217:
    b apply_end_6218
apply_end_6218:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6222
    tst x9, #1
    b.eq do_concat_6221
    tst x0, #1
    b.ne do_compose_6219
do_apply_6220:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6223
do_compose_6219:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6223
do_concat_6221:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6223
id_morphism_6222:
    b apply_end_6223
apply_end_6223:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6227
    tst x9, #1
    b.eq do_concat_6226
    tst x0, #1
    b.ne do_compose_6224
do_apply_6225:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6228
do_compose_6224:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6228
do_concat_6226:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6228
id_morphism_6227:
    b apply_end_6228
apply_end_6228:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6232
    tst x9, #1
    b.eq do_concat_6231
    tst x0, #1
    b.ne do_compose_6229
do_apply_6230:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6233
do_compose_6229:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6233
do_concat_6231:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6233
id_morphism_6232:
    b apply_end_6233
apply_end_6233:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6237
    tst x9, #1
    b.eq do_concat_6236
    tst x0, #1
    b.ne do_compose_6234
do_apply_6235:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6238
do_compose_6234:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6238
do_concat_6236:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6238
id_morphism_6237:
    b apply_end_6238
apply_end_6238:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6207_6208:
    // Closure for func_6207
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6207
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6205_6206:
    // Closure for func_6205
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6205
    ldr x0, [sp], #16
    bl _cons
    b cond_end_6199
cond_false_6198:
    adr x0, sign_id
cond_end_6199:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_infix
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6244
    tst x9, #1
    b.eq do_concat_6243
    tst x0, #1
    b.ne do_compose_6241
do_apply_6242:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6245
do_compose_6241:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6245
do_concat_6243:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6245
id_morphism_6244:
    b apply_end_6245
apply_end_6245:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6239
    b after_func_6246_6247
func_6246:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6248_6249
func_6248:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_6251_6252
func_6251:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6251_6252:
    // Closure for func_6251
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6251
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6259
    tst x9, #1
    b.eq do_concat_6258
    tst x0, #1
    b.ne do_compose_6256
do_apply_6257:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6260
do_compose_6256:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6260
do_concat_6258:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6260
id_morphism_6259:
    b apply_end_6260
apply_end_6260:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6264
    tst x9, #1
    b.eq do_concat_6263
    tst x0, #1
    b.ne do_compose_6261
do_apply_6262:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6265
do_compose_6261:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6265
do_concat_6263:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6265
id_morphism_6264:
    b apply_end_6265
apply_end_6265:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6254
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6269
    tst x9, #1
    b.eq do_concat_6268
    tst x0, #1
    b.ne do_compose_6266
do_apply_6267:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6270
do_compose_6266:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6270
do_concat_6268:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6270
id_morphism_6269:
    b apply_end_6270
apply_end_6270:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6274
    tst x9, #1
    b.eq do_concat_6273
    tst x0, #1
    b.ne do_compose_6271
do_apply_6272:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6275
do_compose_6271:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6275
do_concat_6273:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6275
id_morphism_6274:
    b apply_end_6275
apply_end_6275:
    str x0, [sp, #-16]!
    adr x0, str_48
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6279
    tst x9, #1
    b.eq do_concat_6278
    tst x0, #1
    b.ne do_compose_6276
do_apply_6277:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6280
do_compose_6276:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6280
do_concat_6278:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6280
id_morphism_6279:
    b apply_end_6280
apply_end_6280:
    b cond_end_6255
cond_false_6254:
    adr x0, sign_id
cond_end_6255:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6286
    tst x9, #1
    b.eq do_concat_6285
    tst x0, #1
    b.ne do_compose_6283
do_apply_6284:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6287
do_compose_6283:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6287
do_concat_6285:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6287
id_morphism_6286:
    b apply_end_6287
apply_end_6287:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6291
    tst x9, #1
    b.eq do_concat_6290
    tst x0, #1
    b.ne do_compose_6288
do_apply_6289:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6292
do_compose_6288:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6292
do_concat_6290:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6292
id_morphism_6291:
    b apply_end_6292
apply_end_6292:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6281
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6296
    tst x9, #1
    b.eq do_concat_6295
    tst x0, #1
    b.ne do_compose_6293
do_apply_6294:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6297
do_compose_6293:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6297
do_concat_6295:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6297
id_morphism_6296:
    b apply_end_6297
apply_end_6297:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6301
    tst x9, #1
    b.eq do_concat_6300
    tst x0, #1
    b.ne do_compose_6298
do_apply_6299:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6302
do_compose_6298:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6302
do_concat_6300:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6302
id_morphism_6301:
    b apply_end_6302
apply_end_6302:
    str x0, [sp, #-16]!
    adr x0, str_49
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6306
    tst x9, #1
    b.eq do_concat_6305
    tst x0, #1
    b.ne do_compose_6303
do_apply_6304:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6307
do_compose_6303:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6307
do_concat_6305:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6307
id_morphism_6306:
    b apply_end_6307
apply_end_6307:
    b cond_end_6282
cond_false_6281:
    adr x0, sign_id
cond_end_6282:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6313
    tst x9, #1
    b.eq do_concat_6312
    tst x0, #1
    b.ne do_compose_6310
do_apply_6311:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6314
do_compose_6310:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6314
do_concat_6312:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6314
id_morphism_6313:
    b apply_end_6314
apply_end_6314:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6318
    tst x9, #1
    b.eq do_concat_6317
    tst x0, #1
    b.ne do_compose_6315
do_apply_6316:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6319
do_compose_6315:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6319
do_concat_6317:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6319
id_morphism_6318:
    b apply_end_6319
apply_end_6319:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6308
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6323
    tst x9, #1
    b.eq do_concat_6322
    tst x0, #1
    b.ne do_compose_6320
do_apply_6321:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6324
do_compose_6320:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6324
do_concat_6322:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6324
id_morphism_6323:
    b apply_end_6324
apply_end_6324:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6328
    tst x9, #1
    b.eq do_concat_6327
    tst x0, #1
    b.ne do_compose_6325
do_apply_6326:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6329
do_compose_6325:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6329
do_concat_6327:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6329
id_morphism_6328:
    b apply_end_6329
apply_end_6329:
    str x0, [sp, #-16]!
    adr x0, str_50
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6333
    tst x9, #1
    b.eq do_concat_6332
    tst x0, #1
    b.ne do_compose_6330
do_apply_6331:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6334
do_compose_6330:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6334
do_concat_6332:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6334
id_morphism_6333:
    b apply_end_6334
apply_end_6334:
    b cond_end_6309
cond_false_6308:
    adr x0, sign_id
cond_end_6309:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6340
    tst x9, #1
    b.eq do_concat_6339
    tst x0, #1
    b.ne do_compose_6337
do_apply_6338:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6341
do_compose_6337:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6341
do_concat_6339:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6341
id_morphism_6340:
    b apply_end_6341
apply_end_6341:
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6345
    tst x9, #1
    b.eq do_concat_6344
    tst x0, #1
    b.ne do_compose_6342
do_apply_6343:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6346
do_compose_6342:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6346
do_concat_6344:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6346
id_morphism_6345:
    b apply_end_6346
apply_end_6346:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6335
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6350
    tst x9, #1
    b.eq do_concat_6349
    tst x0, #1
    b.ne do_compose_6347
do_apply_6348:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6351
do_compose_6347:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6351
do_concat_6349:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6351
id_morphism_6350:
    b apply_end_6351
apply_end_6351:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6355
    tst x9, #1
    b.eq do_concat_6354
    tst x0, #1
    b.ne do_compose_6352
do_apply_6353:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6356
do_compose_6352:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6356
do_concat_6354:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6356
id_morphism_6355:
    b apply_end_6356
apply_end_6356:
    str x0, [sp, #-16]!
    adr x0, str_51
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6360
    tst x9, #1
    b.eq do_concat_6359
    tst x0, #1
    b.ne do_compose_6357
do_apply_6358:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6361
do_compose_6357:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6361
do_concat_6359:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6361
id_morphism_6360:
    b apply_end_6361
apply_end_6361:
    b cond_end_6336
cond_false_6335:
    adr x0, sign_id
cond_end_6336:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6367
    tst x9, #1
    b.eq do_concat_6366
    tst x0, #1
    b.ne do_compose_6364
do_apply_6365:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6368
do_compose_6364:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6368
do_concat_6366:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6368
id_morphism_6367:
    b apply_end_6368
apply_end_6368:
    str x0, [sp, #-16]!
    mov x0, #61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6372
    tst x9, #1
    b.eq do_concat_6371
    tst x0, #1
    b.ne do_compose_6369
do_apply_6370:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6373
do_compose_6369:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6373
do_concat_6371:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6373
id_morphism_6372:
    b apply_end_6373
apply_end_6373:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6362
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6377
    tst x9, #1
    b.eq do_concat_6376
    tst x0, #1
    b.ne do_compose_6374
do_apply_6375:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6378
do_compose_6374:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6378
do_concat_6376:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6378
id_morphism_6377:
    b apply_end_6378
apply_end_6378:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6382
    tst x9, #1
    b.eq do_concat_6381
    tst x0, #1
    b.ne do_compose_6379
do_apply_6380:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6383
do_compose_6379:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6383
do_concat_6381:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6383
id_morphism_6382:
    b apply_end_6383
apply_end_6383:
    str x0, [sp, #-16]!
    adr x0, str_52
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6387
    tst x9, #1
    b.eq do_concat_6386
    tst x0, #1
    b.ne do_compose_6384
do_apply_6385:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6388
do_compose_6384:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6388
do_concat_6386:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6388
id_morphism_6387:
    b apply_end_6388
apply_end_6388:
    b cond_end_6363
cond_false_6362:
    adr x0, sign_id
cond_end_6363:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6394
    tst x9, #1
    b.eq do_concat_6393
    tst x0, #1
    b.ne do_compose_6391
do_apply_6392:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6395
do_compose_6391:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6395
do_concat_6393:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6395
id_morphism_6394:
    b apply_end_6395
apply_end_6395:
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6399
    tst x9, #1
    b.eq do_concat_6398
    tst x0, #1
    b.ne do_compose_6396
do_apply_6397:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6400
do_compose_6396:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6400
do_concat_6398:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6400
id_morphism_6399:
    b apply_end_6400
apply_end_6400:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6389
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6404
    tst x9, #1
    b.eq do_concat_6403
    tst x0, #1
    b.ne do_compose_6401
do_apply_6402:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6405
do_compose_6401:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6405
do_concat_6403:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6405
id_morphism_6404:
    b apply_end_6405
apply_end_6405:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6409
    tst x9, #1
    b.eq do_concat_6408
    tst x0, #1
    b.ne do_compose_6406
do_apply_6407:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6410
do_compose_6406:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6410
do_concat_6408:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6410
id_morphism_6409:
    b apply_end_6410
apply_end_6410:
    str x0, [sp, #-16]!
    adr x0, str_53
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6414
    tst x9, #1
    b.eq do_concat_6413
    tst x0, #1
    b.ne do_compose_6411
do_apply_6412:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6415
do_compose_6411:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6415
do_concat_6413:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6415
id_morphism_6414:
    b apply_end_6415
apply_end_6415:
    b cond_end_6390
cond_false_6389:
    adr x0, sign_id
cond_end_6390:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6421
    tst x9, #1
    b.eq do_concat_6420
    tst x0, #1
    b.ne do_compose_6418
do_apply_6419:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6422
do_compose_6418:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6422
do_concat_6420:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6422
id_morphism_6421:
    b apply_end_6422
apply_end_6422:
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6426
    tst x9, #1
    b.eq do_concat_6425
    tst x0, #1
    b.ne do_compose_6423
do_apply_6424:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6427
do_compose_6423:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6427
do_concat_6425:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6427
id_morphism_6426:
    b apply_end_6427
apply_end_6427:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6416
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6431
    tst x9, #1
    b.eq do_concat_6430
    tst x0, #1
    b.ne do_compose_6428
do_apply_6429:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6432
do_compose_6428:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6432
do_concat_6430:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6432
id_morphism_6431:
    b apply_end_6432
apply_end_6432:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6436
    tst x9, #1
    b.eq do_concat_6435
    tst x0, #1
    b.ne do_compose_6433
do_apply_6434:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6437
do_compose_6433:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6437
do_concat_6435:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6437
id_morphism_6436:
    b apply_end_6437
apply_end_6437:
    str x0, [sp, #-16]!
    adr x0, str_54
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6441
    tst x9, #1
    b.eq do_concat_6440
    tst x0, #1
    b.ne do_compose_6438
do_apply_6439:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6442
do_compose_6438:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6442
do_concat_6440:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6442
id_morphism_6441:
    b apply_end_6442
apply_end_6442:
    b cond_end_6417
cond_false_6416:
    adr x0, sign_id
cond_end_6417:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6448
    tst x9, #1
    b.eq do_concat_6447
    tst x0, #1
    b.ne do_compose_6445
do_apply_6446:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6449
do_compose_6445:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6449
do_concat_6447:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6449
id_morphism_6448:
    b apply_end_6449
apply_end_6449:
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6453
    tst x9, #1
    b.eq do_concat_6452
    tst x0, #1
    b.ne do_compose_6450
do_apply_6451:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6454
do_compose_6450:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6454
do_concat_6452:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6454
id_morphism_6453:
    b apply_end_6454
apply_end_6454:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6443
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6458
    tst x9, #1
    b.eq do_concat_6457
    tst x0, #1
    b.ne do_compose_6455
do_apply_6456:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6459
do_compose_6455:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6459
do_concat_6457:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6459
id_morphism_6458:
    b apply_end_6459
apply_end_6459:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6463
    tst x9, #1
    b.eq do_concat_6462
    tst x0, #1
    b.ne do_compose_6460
do_apply_6461:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6464
do_compose_6460:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6464
do_concat_6462:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6464
id_morphism_6463:
    b apply_end_6464
apply_end_6464:
    str x0, [sp, #-16]!
    adr x0, str_55
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6468
    tst x9, #1
    b.eq do_concat_6467
    tst x0, #1
    b.ne do_compose_6465
do_apply_6466:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6469
do_compose_6465:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6469
do_concat_6467:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6469
id_morphism_6468:
    b apply_end_6469
apply_end_6469:
    b cond_end_6444
cond_false_6443:
    adr x0, sign_id
cond_end_6444:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6475
    tst x9, #1
    b.eq do_concat_6474
    tst x0, #1
    b.ne do_compose_6472
do_apply_6473:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6476
do_compose_6472:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6476
do_concat_6474:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6476
id_morphism_6475:
    b apply_end_6476
apply_end_6476:
    str x0, [sp, #-16]!
    adr x0, str_5
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6480
    tst x9, #1
    b.eq do_concat_6479
    tst x0, #1
    b.ne do_compose_6477
do_apply_6478:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6481
do_compose_6477:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6481
do_concat_6479:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6481
id_morphism_6480:
    b apply_end_6481
apply_end_6481:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6470
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6485
    tst x9, #1
    b.eq do_concat_6484
    tst x0, #1
    b.ne do_compose_6482
do_apply_6483:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6486
do_compose_6482:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6486
do_concat_6484:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6486
id_morphism_6485:
    b apply_end_6486
apply_end_6486:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6490
    tst x9, #1
    b.eq do_concat_6489
    tst x0, #1
    b.ne do_compose_6487
do_apply_6488:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6491
do_compose_6487:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6491
do_concat_6489:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6491
id_morphism_6490:
    b apply_end_6491
apply_end_6491:
    str x0, [sp, #-16]!
    adr x0, str_56
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6495
    tst x9, #1
    b.eq do_concat_6494
    tst x0, #1
    b.ne do_compose_6492
do_apply_6493:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6496
do_compose_6492:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6496
do_concat_6494:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6496
id_morphism_6495:
    b apply_end_6496
apply_end_6496:
    b cond_end_6471
cond_false_6470:
    adr x0, sign_id
cond_end_6471:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6502
    tst x9, #1
    b.eq do_concat_6501
    tst x0, #1
    b.ne do_compose_6499
do_apply_6500:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6503
do_compose_6499:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6503
do_concat_6501:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6503
id_morphism_6502:
    b apply_end_6503
apply_end_6503:
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6507
    tst x9, #1
    b.eq do_concat_6506
    tst x0, #1
    b.ne do_compose_6504
do_apply_6505:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6508
do_compose_6504:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6508
do_concat_6506:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6508
id_morphism_6507:
    b apply_end_6508
apply_end_6508:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6497
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6512
    tst x9, #1
    b.eq do_concat_6511
    tst x0, #1
    b.ne do_compose_6509
do_apply_6510:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6513
do_compose_6509:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6513
do_concat_6511:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6513
id_morphism_6512:
    b apply_end_6513
apply_end_6513:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6517
    tst x9, #1
    b.eq do_concat_6516
    tst x0, #1
    b.ne do_compose_6514
do_apply_6515:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6518
do_compose_6514:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6518
do_concat_6516:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6518
id_morphism_6517:
    b apply_end_6518
apply_end_6518:
    str x0, [sp, #-16]!
    adr x0, str_57
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6522
    tst x9, #1
    b.eq do_concat_6521
    tst x0, #1
    b.ne do_compose_6519
do_apply_6520:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6523
do_compose_6519:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6523
do_concat_6521:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6523
id_morphism_6522:
    b apply_end_6523
apply_end_6523:
    b cond_end_6498
cond_false_6497:
    adr x0, sign_id
cond_end_6498:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6529
    tst x9, #1
    b.eq do_concat_6528
    tst x0, #1
    b.ne do_compose_6526
do_apply_6527:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6530
do_compose_6526:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6530
do_concat_6528:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6530
id_morphism_6529:
    b apply_end_6530
apply_end_6530:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6534
    tst x9, #1
    b.eq do_concat_6533
    tst x0, #1
    b.ne do_compose_6531
do_apply_6532:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6535
do_compose_6531:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6535
do_concat_6533:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6535
id_morphism_6534:
    b apply_end_6535
apply_end_6535:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6524
    adr x0, compile_bind
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6539
    tst x9, #1
    b.eq do_concat_6538
    tst x0, #1
    b.ne do_compose_6536
do_apply_6537:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6540
do_compose_6536:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6540
do_concat_6538:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6540
id_morphism_6539:
    b apply_end_6540
apply_end_6540:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6544
    tst x9, #1
    b.eq do_concat_6543
    tst x0, #1
    b.ne do_compose_6541
do_apply_6542:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6545
do_compose_6541:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6545
do_concat_6543:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6545
id_morphism_6544:
    b apply_end_6545
apply_end_6545:
    b cond_end_6525
cond_false_6524:
    adr x0, sign_id
cond_end_6525:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6551
    tst x9, #1
    b.eq do_concat_6550
    tst x0, #1
    b.ne do_compose_6548
do_apply_6549:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6552
do_compose_6548:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6552
do_concat_6550:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6552
id_morphism_6551:
    b apply_end_6552
apply_end_6552:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6556
    tst x9, #1
    b.eq do_concat_6555
    tst x0, #1
    b.ne do_compose_6553
do_apply_6554:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6557
do_compose_6553:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6557
do_concat_6555:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6557
id_morphism_6556:
    b apply_end_6557
apply_end_6557:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6546
    adr x0, compile_lambda
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6561
    tst x9, #1
    b.eq do_concat_6560
    tst x0, #1
    b.ne do_compose_6558
do_apply_6559:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6562
do_compose_6558:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6562
do_concat_6560:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6562
id_morphism_6561:
    b apply_end_6562
apply_end_6562:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6566
    tst x9, #1
    b.eq do_concat_6565
    tst x0, #1
    b.ne do_compose_6563
do_apply_6564:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6567
do_compose_6563:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6567
do_concat_6565:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6567
id_morphism_6566:
    b apply_end_6567
apply_end_6567:
    b cond_end_6547
cond_false_6546:
    adr x0, sign_id
cond_end_6547:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, str_44
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6253
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_58
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6571
    tst x9, #1
    b.eq do_concat_6570
    tst x0, #1
    b.ne do_compose_6568
do_apply_6569:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6572
do_compose_6568:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6572
do_concat_6570:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6572
id_morphism_6571:
    b apply_end_6572
apply_end_6572:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6576
    tst x9, #1
    b.eq do_concat_6575
    tst x0, #1
    b.ne do_compose_6573
do_apply_6574:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6577
do_compose_6573:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6577
do_concat_6575:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6577
id_morphism_6576:
    b apply_end_6577
apply_end_6577:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6581
    tst x9, #1
    b.eq do_concat_6580
    tst x0, #1
    b.ne do_compose_6578
do_apply_6579:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6582
do_compose_6578:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6582
do_concat_6580:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6582
id_morphism_6581:
    b apply_end_6582
apply_end_6582:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6586
    tst x9, #1
    b.eq do_concat_6585
    tst x0, #1
    b.ne do_compose_6583
do_apply_6584:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6587
do_compose_6583:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6587
do_concat_6585:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6587
id_morphism_6586:
    b apply_end_6587
apply_end_6587:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6591
    tst x9, #1
    b.eq do_concat_6590
    tst x0, #1
    b.ne do_compose_6588
do_apply_6589:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6592
do_compose_6588:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6592
do_concat_6590:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6592
id_morphism_6591:
    b apply_end_6592
apply_end_6592:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6596
    tst x9, #1
    b.eq do_concat_6595
    tst x0, #1
    b.ne do_compose_6593
do_apply_6594:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6597
do_compose_6593:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6597
do_concat_6595:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6597
id_morphism_6596:
    b apply_end_6597
apply_end_6597:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6601
    tst x9, #1
    b.eq do_concat_6600
    tst x0, #1
    b.ne do_compose_6598
do_apply_6599:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6602
do_compose_6598:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6602
do_concat_6600:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6602
id_morphism_6601:
    b apply_end_6602
apply_end_6602:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6606
    tst x9, #1
    b.eq do_concat_6605
    tst x0, #1
    b.ne do_compose_6603
do_apply_6604:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6607
do_compose_6603:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6607
do_concat_6605:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6607
id_morphism_6606:
    b apply_end_6607
apply_end_6607:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6611
    tst x9, #1
    b.eq do_concat_6610
    tst x0, #1
    b.ne do_compose_6608
do_apply_6609:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6612
do_compose_6608:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6612
do_concat_6610:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6612
id_morphism_6611:
    b apply_end_6612
apply_end_6612:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6616
    tst x9, #1
    b.eq do_concat_6615
    tst x0, #1
    b.ne do_compose_6613
do_apply_6614:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6617
do_compose_6613:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6617
do_concat_6615:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6617
id_morphism_6616:
    b apply_end_6617
apply_end_6617:
blk_end_6253:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6621
    tst x9, #1
    b.eq do_concat_6620
    tst x0, #1
    b.ne do_compose_6618
do_apply_6619:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6622
do_compose_6618:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6622
do_concat_6620:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6622
id_morphism_6621:
    b apply_end_6622
apply_end_6622:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6250
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6626
    tst x9, #1
    b.eq do_concat_6625
    tst x0, #1
    b.ne do_compose_6623
do_apply_6624:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6627
do_compose_6623:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6627
do_concat_6625:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6627
id_morphism_6626:
    b apply_end_6627
apply_end_6627:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6631
    tst x9, #1
    b.eq do_concat_6630
    tst x0, #1
    b.ne do_compose_6628
do_apply_6629:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6632
do_compose_6628:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6632
do_concat_6630:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6632
id_morphism_6631:
    b apply_end_6632
apply_end_6632:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6636
    tst x9, #1
    b.eq do_concat_6635
    tst x0, #1
    b.ne do_compose_6633
do_apply_6634:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6637
do_compose_6633:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6637
do_concat_6635:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6637
id_morphism_6636:
    b apply_end_6637
apply_end_6637:
blk_end_6250:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6248_6249:
    // Closure for func_6248
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6248
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6246_6247:
    // Closure for func_6246
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6246
    ldr x0, [sp], #16
    bl _cons
    b cond_end_6240
cond_false_6239:
    adr x0, sign_id
cond_end_6240:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_bind
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6643
    tst x9, #1
    b.eq do_concat_6642
    tst x0, #1
    b.ne do_compose_6640
do_apply_6641:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6644
do_compose_6640:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6644
do_concat_6642:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6644
id_morphism_6643:
    b apply_end_6644
apply_end_6644:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6638
    b after_func_6645_6646
func_6645:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6647_6648
func_6647:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_6650_6651
func_6650:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6652_6653
func_6652:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6652_6653:
    // Closure for func_6652
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6652
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6650_6651:
    // Closure for func_6650
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6650
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6655_6656
func_6655:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6655_6656:
    // Closure for func_6655
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6655
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6658_6659
func_6658:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6658_6659:
    // Closure for func_6658
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6658
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6661_6662
func_6661:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6663_6664
func_6663:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6663_6664:
    // Closure for func_6663
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6663
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6661_6662:
    // Closure for func_6661
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6661
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6666_6667
func_6666:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6666_6667:
    // Closure for func_6666
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6666
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6672
    tst x9, #1
    b.eq do_concat_6671
    tst x0, #1
    b.ne do_compose_6669
do_apply_6670:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6673
do_compose_6669:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6673
do_concat_6671:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6673
id_morphism_6672:
    b apply_end_6673
apply_end_6673:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6677
    tst x9, #1
    b.eq do_concat_6676
    tst x0, #1
    b.ne do_compose_6674
do_apply_6675:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6678
do_compose_6674:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6678
do_concat_6676:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6678
id_morphism_6677:
    b apply_end_6678
apply_end_6678:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6682
    tst x9, #1
    b.eq do_concat_6681
    tst x0, #1
    b.ne do_compose_6679
do_apply_6680:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6683
do_compose_6679:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6683
do_concat_6681:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6683
id_morphism_6682:
    b apply_end_6683
apply_end_6683:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6687
    tst x9, #1
    b.eq do_concat_6686
    tst x0, #1
    b.ne do_compose_6684
do_apply_6685:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6688
do_compose_6684:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6688
do_concat_6686:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6688
id_morphism_6687:
    b apply_end_6688
apply_end_6688:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6692
    tst x9, #1
    b.eq do_concat_6691
    tst x0, #1
    b.ne do_compose_6689
do_apply_6690:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6693
do_compose_6689:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6693
do_concat_6691:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6693
id_morphism_6692:
    b apply_end_6693
apply_end_6693:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6697
    tst x9, #1
    b.eq do_concat_6696
    tst x0, #1
    b.ne do_compose_6694
do_apply_6695:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6698
do_compose_6694:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6698
do_concat_6696:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6698
id_morphism_6697:
    b apply_end_6698
apply_end_6698:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6668
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, new_ctx
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6702
    tst x9, #1
    b.eq do_concat_6701
    tst x0, #1
    b.ne do_compose_6699
do_apply_6700:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6703
do_compose_6699:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6703
do_concat_6701:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6703
id_morphism_6702:
    b apply_end_6703
apply_end_6703:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6707
    tst x9, #1
    b.eq do_concat_6706
    tst x0, #1
    b.ne do_compose_6704
do_apply_6705:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6708
do_compose_6704:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6708
do_concat_6706:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6708
id_morphism_6707:
    b apply_end_6708
apply_end_6708:
blk_end_6668:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6712
    tst x9, #1
    b.eq do_concat_6711
    tst x0, #1
    b.ne do_compose_6709
do_apply_6710:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6713
do_compose_6709:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6713
do_concat_6711:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6713
id_morphism_6712:
    b apply_end_6713
apply_end_6713:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6717
    tst x9, #1
    b.eq do_concat_6716
    tst x0, #1
    b.ne do_compose_6714
do_apply_6715:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6718
do_compose_6714:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6718
do_concat_6716:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6718
id_morphism_6717:
    b apply_end_6718
apply_end_6718:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6665
    adr x0, push_var
    str x0, [sp, #-16]!
    adr x0, ctx_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6722
    tst x9, #1
    b.eq do_concat_6721
    tst x0, #1
    b.ne do_compose_6719
do_apply_6720:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6723
do_compose_6719:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6723
do_concat_6721:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6723
id_morphism_6722:
    b apply_end_6723
apply_end_6723:
    str x0, [sp, #-16]!
    adr x0, name
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6727
    tst x9, #1
    b.eq do_concat_6726
    tst x0, #1
    b.ne do_compose_6724
do_apply_6725:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6728
do_compose_6724:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6728
do_concat_6726:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6728
id_morphism_6727:
    b apply_end_6728
apply_end_6728:
blk_end_6665:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6732
    tst x9, #1
    b.eq do_concat_6731
    tst x0, #1
    b.ne do_compose_6729
do_apply_6730:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6733
do_compose_6729:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6733
do_concat_6731:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6733
id_morphism_6732:
    b apply_end_6733
apply_end_6733:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6660
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6737
    tst x9, #1
    b.eq do_concat_6736
    tst x0, #1
    b.ne do_compose_6734
do_apply_6735:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6738
do_compose_6734:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6738
do_concat_6736:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6738
id_morphism_6737:
    b apply_end_6738
apply_end_6738:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6742
    tst x9, #1
    b.eq do_concat_6741
    tst x0, #1
    b.ne do_compose_6739
do_apply_6740:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6743
do_compose_6739:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6743
do_concat_6741:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6743
id_morphism_6742:
    b apply_end_6743
apply_end_6743:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6747
    tst x9, #1
    b.eq do_concat_6746
    tst x0, #1
    b.ne do_compose_6744
do_apply_6745:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6748
do_compose_6744:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6748
do_concat_6746:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6748
id_morphism_6747:
    b apply_end_6748
apply_end_6748:
blk_end_6660:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6752
    tst x9, #1
    b.eq do_concat_6751
    tst x0, #1
    b.ne do_compose_6749
do_apply_6750:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6753
do_compose_6749:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6753
do_concat_6751:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6753
id_morphism_6752:
    b apply_end_6753
apply_end_6753:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6657
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6757
    tst x9, #1
    b.eq do_concat_6756
    tst x0, #1
    b.ne do_compose_6754
do_apply_6755:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6758
do_compose_6754:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6758
do_concat_6756:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6758
id_morphism_6757:
    b apply_end_6758
apply_end_6758:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6762
    tst x9, #1
    b.eq do_concat_6761
    tst x0, #1
    b.ne do_compose_6759
do_apply_6760:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6763
do_compose_6759:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6763
do_concat_6761:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6763
id_morphism_6762:
    b apply_end_6763
apply_end_6763:
blk_end_6657:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6767
    tst x9, #1
    b.eq do_concat_6766
    tst x0, #1
    b.ne do_compose_6764
do_apply_6765:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6768
do_compose_6764:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6768
do_concat_6766:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6768
id_morphism_6767:
    b apply_end_6768
apply_end_6768:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6654
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6772
    tst x9, #1
    b.eq do_concat_6771
    tst x0, #1
    b.ne do_compose_6769
do_apply_6770:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6773
do_compose_6769:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6773
do_concat_6771:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6773
id_morphism_6772:
    b apply_end_6773
apply_end_6773:
    str x0, [sp, #-16]!
    adr x0, str_59
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6777
    tst x9, #1
    b.eq do_concat_6776
    tst x0, #1
    b.ne do_compose_6774
do_apply_6775:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6778
do_compose_6774:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6778
do_concat_6776:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6778
id_morphism_6777:
    b apply_end_6778
apply_end_6778:
blk_end_6654:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6782
    tst x9, #1
    b.eq do_concat_6781
    tst x0, #1
    b.ne do_compose_6779
do_apply_6780:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6783
do_compose_6779:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6783
do_concat_6781:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6783
id_morphism_6782:
    b apply_end_6783
apply_end_6783:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6649
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6787
    tst x9, #1
    b.eq do_concat_6786
    tst x0, #1
    b.ne do_compose_6784
do_apply_6785:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6788
do_compose_6784:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6788
do_concat_6786:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6788
id_morphism_6787:
    b apply_end_6788
apply_end_6788:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6792
    tst x9, #1
    b.eq do_concat_6791
    tst x0, #1
    b.ne do_compose_6789
do_apply_6790:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6793
do_compose_6789:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6793
do_concat_6791:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6793
id_morphism_6792:
    b apply_end_6793
apply_end_6793:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6797
    tst x9, #1
    b.eq do_concat_6796
    tst x0, #1
    b.ne do_compose_6794
do_apply_6795:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6798
do_compose_6794:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6798
do_concat_6796:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6798
id_morphism_6797:
    b apply_end_6798
apply_end_6798:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6802
    tst x9, #1
    b.eq do_concat_6801
    tst x0, #1
    b.ne do_compose_6799
do_apply_6800:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6803
do_compose_6799:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6803
do_concat_6801:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6803
id_morphism_6802:
    b apply_end_6803
apply_end_6803:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6807
    tst x9, #1
    b.eq do_concat_6806
    tst x0, #1
    b.ne do_compose_6804
do_apply_6805:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6808
do_compose_6804:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6808
do_concat_6806:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6808
id_morphism_6807:
    b apply_end_6808
apply_end_6808:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6812
    tst x9, #1
    b.eq do_concat_6811
    tst x0, #1
    b.ne do_compose_6809
do_apply_6810:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6813
do_compose_6809:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6813
do_concat_6811:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6813
id_morphism_6812:
    b apply_end_6813
apply_end_6813:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6817
    tst x9, #1
    b.eq do_concat_6816
    tst x0, #1
    b.ne do_compose_6814
do_apply_6815:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6818
do_compose_6814:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6818
do_concat_6816:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6818
id_morphism_6817:
    b apply_end_6818
apply_end_6818:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6822
    tst x9, #1
    b.eq do_concat_6821
    tst x0, #1
    b.ne do_compose_6819
do_apply_6820:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6823
do_compose_6819:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6823
do_concat_6821:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6823
id_morphism_6822:
    b apply_end_6823
apply_end_6823:
blk_end_6649:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6647_6648:
    // Closure for func_6647
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6647
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6645_6646:
    // Closure for func_6645
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6645
    ldr x0, [sp], #16
    bl _cons
    b cond_end_6639
cond_false_6638:
    adr x0, sign_id
cond_end_6639:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_lambda
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6829
    tst x9, #1
    b.eq do_concat_6828
    tst x0, #1
    b.ne do_compose_6826
do_apply_6827:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6830
do_compose_6826:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6830
do_concat_6828:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6830
id_morphism_6829:
    b apply_end_6830
apply_end_6830:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6824
    b after_func_6831_6832
func_6831:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6833_6834
func_6833:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_6836_6837
func_6836:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6838_6839
func_6838:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6838_6839:
    // Closure for func_6838
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6838
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6836_6837:
    // Closure for func_6836
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6836
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6841_6842
func_6841:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6843_6844
func_6843:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6845_6846
func_6845:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6845_6846:
    // Closure for func_6845
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6845
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6843_6844:
    // Closure for func_6843
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6843
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6841_6842:
    // Closure for func_6841
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6841
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6848_6849
func_6848:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6850_6851
func_6850:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6852_6853
func_6852:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6852_6853:
    // Closure for func_6852
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6852
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6850_6851:
    // Closure for func_6850
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6850
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6848_6849:
    // Closure for func_6848
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6848
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6855_6856
func_6855:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6855_6856:
    // Closure for func_6855
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6855
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6858_6859
func_6858:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6858_6859:
    // Closure for func_6858
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6858
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6861_6862
func_6861:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6861_6862:
    // Closure for func_6861
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6861
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6863_6864
func_6863:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6865_6866
func_6865:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6865_6866:
    // Closure for func_6865
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6865
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6863_6864:
    // Closure for func_6863
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6863
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_60
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6872
    tst x9, #1
    b.eq do_concat_6871
    tst x0, #1
    b.ne do_compose_6869
do_apply_6870:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6873
do_compose_6869:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6873
do_concat_6871:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6873
id_morphism_6872:
    b apply_end_6873
apply_end_6873:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_after
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6877
    tst x9, #1
    b.eq do_concat_6876
    tst x0, #1
    b.ne do_compose_6874
do_apply_6875:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6878
do_compose_6874:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6878
do_concat_6876:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6878
id_morphism_6877:
    b apply_end_6878
apply_end_6878:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6882
    tst x9, #1
    b.eq do_concat_6881
    tst x0, #1
    b.ne do_compose_6879
do_apply_6880:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6883
do_compose_6879:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6883
do_concat_6881:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6883
id_morphism_6882:
    b apply_end_6883
apply_end_6883:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6887
    tst x9, #1
    b.eq do_concat_6886
    tst x0, #1
    b.ne do_compose_6884
do_apply_6885:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6888
do_compose_6884:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6888
do_concat_6886:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6888
id_morphism_6887:
    b apply_end_6888
apply_end_6888:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6892
    tst x9, #1
    b.eq do_concat_6891
    tst x0, #1
    b.ne do_compose_6889
do_apply_6890:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6893
do_compose_6889:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6893
do_concat_6891:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6893
id_morphism_6892:
    b apply_end_6893
apply_end_6893:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_func
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6897
    tst x9, #1
    b.eq do_concat_6896
    tst x0, #1
    b.ne do_compose_6894
do_apply_6895:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6898
do_compose_6894:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6898
do_concat_6896:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6898
id_morphism_6897:
    b apply_end_6898
apply_end_6898:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6902
    tst x9, #1
    b.eq do_concat_6901
    tst x0, #1
    b.ne do_compose_6899
do_apply_6900:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6903
do_compose_6899:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6903
do_concat_6901:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6903
id_morphism_6902:
    b apply_end_6903
apply_end_6903:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6907
    tst x9, #1
    b.eq do_concat_6906
    tst x0, #1
    b.ne do_compose_6904
do_apply_6905:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6908
do_compose_6904:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6908
do_concat_6906:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6908
id_morphism_6907:
    b apply_end_6908
apply_end_6908:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_62
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6912
    tst x9, #1
    b.eq do_concat_6911
    tst x0, #1
    b.ne do_compose_6909
do_apply_6910:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6913
do_compose_6909:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6913
do_concat_6911:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6913
id_morphism_6912:
    b apply_end_6913
apply_end_6913:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_63
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6917
    tst x9, #1
    b.eq do_concat_6916
    tst x0, #1
    b.ne do_compose_6914
do_apply_6915:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6918
do_compose_6914:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6918
do_concat_6916:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6918
id_morphism_6917:
    b apply_end_6918
apply_end_6918:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_64
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6922
    tst x9, #1
    b.eq do_concat_6921
    tst x0, #1
    b.ne do_compose_6919
do_apply_6920:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6923
do_compose_6919:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6923
do_concat_6921:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6923
id_morphism_6922:
    b apply_end_6923
apply_end_6923:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_body
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6927
    tst x9, #1
    b.eq do_concat_6926
    tst x0, #1
    b.ne do_compose_6924
do_apply_6925:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6928
do_compose_6924:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6928
do_concat_6926:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6928
id_morphism_6927:
    b apply_end_6928
apply_end_6928:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_65
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6932
    tst x9, #1
    b.eq do_concat_6931
    tst x0, #1
    b.ne do_compose_6929
do_apply_6930:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6933
do_compose_6929:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6933
do_concat_6931:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6933
id_morphism_6932:
    b apply_end_6933
apply_end_6933:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_66
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6937
    tst x9, #1
    b.eq do_concat_6936
    tst x0, #1
    b.ne do_compose_6934
do_apply_6935:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6938
do_compose_6934:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6938
do_concat_6936:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6938
id_morphism_6937:
    b apply_end_6938
apply_end_6938:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_67
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6942
    tst x9, #1
    b.eq do_concat_6941
    tst x0, #1
    b.ne do_compose_6939
do_apply_6940:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6943
do_compose_6939:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6943
do_concat_6941:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6943
id_morphism_6942:
    b apply_end_6943
apply_end_6943:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_after
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6947
    tst x9, #1
    b.eq do_concat_6946
    tst x0, #1
    b.ne do_compose_6944
do_apply_6945:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6948
do_compose_6944:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6948
do_concat_6946:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6948
id_morphism_6947:
    b apply_end_6948
apply_end_6948:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6952
    tst x9, #1
    b.eq do_concat_6951
    tst x0, #1
    b.ne do_compose_6949
do_apply_6950:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6953
do_compose_6949:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6953
do_concat_6951:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6953
id_morphism_6952:
    b apply_end_6953
apply_end_6953:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6957
    tst x9, #1
    b.eq do_concat_6956
    tst x0, #1
    b.ne do_compose_6954
do_apply_6955:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6958
do_compose_6954:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6958
do_concat_6956:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6958
id_morphism_6957:
    b apply_end_6958
apply_end_6958:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6962
    tst x9, #1
    b.eq do_concat_6961
    tst x0, #1
    b.ne do_compose_6959
do_apply_6960:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6963
do_compose_6959:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6963
do_concat_6961:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6963
id_morphism_6962:
    b apply_end_6963
apply_end_6963:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6967
    tst x9, #1
    b.eq do_concat_6966
    tst x0, #1
    b.ne do_compose_6964
do_apply_6965:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6968
do_compose_6964:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6968
do_concat_6966:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6968
id_morphism_6967:
    b apply_end_6968
apply_end_6968:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_68
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6972
    tst x9, #1
    b.eq do_concat_6971
    tst x0, #1
    b.ne do_compose_6969
do_apply_6970:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6973
do_compose_6969:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6973
do_concat_6971:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6973
id_morphism_6972:
    b apply_end_6973
apply_end_6973:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_func
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6977
    tst x9, #1
    b.eq do_concat_6976
    tst x0, #1
    b.ne do_compose_6974
do_apply_6975:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6978
do_compose_6974:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6978
do_concat_6976:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6978
id_morphism_6977:
    b apply_end_6978
apply_end_6978:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6982
    tst x9, #1
    b.eq do_concat_6981
    tst x0, #1
    b.ne do_compose_6979
do_apply_6980:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6983
do_compose_6979:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6983
do_concat_6981:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6983
id_morphism_6982:
    b apply_end_6983
apply_end_6983:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6987
    tst x9, #1
    b.eq do_concat_6986
    tst x0, #1
    b.ne do_compose_6984
do_apply_6985:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6988
do_compose_6984:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6988
do_concat_6986:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6988
id_morphism_6987:
    b apply_end_6988
apply_end_6988:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6992
    tst x9, #1
    b.eq do_concat_6991
    tst x0, #1
    b.ne do_compose_6989
do_apply_6990:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6993
do_compose_6989:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6993
do_concat_6991:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6993
id_morphism_6992:
    b apply_end_6993
apply_end_6993:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_69
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_6997
    tst x9, #1
    b.eq do_concat_6996
    tst x0, #1
    b.ne do_compose_6994
do_apply_6995:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6998
do_compose_6994:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_6998
do_concat_6996:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_6998
id_morphism_6997:
    b apply_end_6998
apply_end_6998:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_70
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7002
    tst x9, #1
    b.eq do_concat_7001
    tst x0, #1
    b.ne do_compose_6999
do_apply_7000:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7003
do_compose_6999:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7003
do_concat_7001:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7003
id_morphism_7002:
    b apply_end_7003
apply_end_7003:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7007
    tst x9, #1
    b.eq do_concat_7006
    tst x0, #1
    b.ne do_compose_7004
do_apply_7005:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7008
do_compose_7004:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7008
do_concat_7006:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7008
id_morphism_7007:
    b apply_end_7008
apply_end_7008:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7012
    tst x9, #1
    b.eq do_concat_7011
    tst x0, #1
    b.ne do_compose_7009
do_apply_7010:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7013
do_compose_7009:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7013
do_concat_7011:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7013
id_morphism_7012:
    b apply_end_7013
apply_end_7013:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7017
    tst x9, #1
    b.eq do_concat_7016
    tst x0, #1
    b.ne do_compose_7014
do_apply_7015:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7018
do_compose_7014:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7018
do_concat_7016:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7018
id_morphism_7017:
    b apply_end_7018
apply_end_7018:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7022
    tst x9, #1
    b.eq do_concat_7021
    tst x0, #1
    b.ne do_compose_7019
do_apply_7020:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7023
do_compose_7019:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7023
do_concat_7021:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7023
id_morphism_7022:
    b apply_end_7023
apply_end_7023:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7027
    tst x9, #1
    b.eq do_concat_7026
    tst x0, #1
    b.ne do_compose_7024
do_apply_7025:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7028
do_compose_7024:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7028
do_concat_7026:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7028
id_morphism_7027:
    b apply_end_7028
apply_end_7028:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7032
    tst x9, #1
    b.eq do_concat_7031
    tst x0, #1
    b.ne do_compose_7029
do_apply_7030:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7033
do_compose_7029:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7033
do_concat_7031:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7033
id_morphism_7032:
    b apply_end_7033
apply_end_7033:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7037
    tst x9, #1
    b.eq do_concat_7036
    tst x0, #1
    b.ne do_compose_7034
do_apply_7035:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7038
do_compose_7034:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7038
do_concat_7036:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7038
id_morphism_7037:
    b apply_end_7038
apply_end_7038:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7042
    tst x9, #1
    b.eq do_concat_7041
    tst x0, #1
    b.ne do_compose_7039
do_apply_7040:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7043
do_compose_7039:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7043
do_concat_7041:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7043
id_morphism_7042:
    b apply_end_7043
apply_end_7043:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7047
    tst x9, #1
    b.eq do_concat_7046
    tst x0, #1
    b.ne do_compose_7044
do_apply_7045:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7048
do_compose_7044:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7048
do_concat_7046:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7048
id_morphism_7047:
    b apply_end_7048
apply_end_7048:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7052
    tst x9, #1
    b.eq do_concat_7051
    tst x0, #1
    b.ne do_compose_7049
do_apply_7050:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7053
do_compose_7049:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7053
do_concat_7051:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7053
id_morphism_7052:
    b apply_end_7053
apply_end_7053:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7057
    tst x9, #1
    b.eq do_concat_7056
    tst x0, #1
    b.ne do_compose_7054
do_apply_7055:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7058
do_compose_7054:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7058
do_concat_7056:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7058
id_morphism_7057:
    b apply_end_7058
apply_end_7058:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7062
    tst x9, #1
    b.eq do_concat_7061
    tst x0, #1
    b.ne do_compose_7059
do_apply_7060:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7063
do_compose_7059:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7063
do_concat_7061:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7063
id_morphism_7062:
    b apply_end_7063
apply_end_7063:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7067
    tst x9, #1
    b.eq do_concat_7066
    tst x0, #1
    b.ne do_compose_7064
do_apply_7065:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7068
do_compose_7064:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7068
do_concat_7066:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7068
id_morphism_7067:
    b apply_end_7068
apply_end_7068:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7072
    tst x9, #1
    b.eq do_concat_7071
    tst x0, #1
    b.ne do_compose_7069
do_apply_7070:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7073
do_compose_7069:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7073
do_concat_7071:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7073
id_morphism_7072:
    b apply_end_7073
apply_end_7073:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7077
    tst x9, #1
    b.eq do_concat_7076
    tst x0, #1
    b.ne do_compose_7074
do_apply_7075:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7078
do_compose_7074:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7078
do_concat_7076:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7078
id_morphism_7077:
    b apply_end_7078
apply_end_7078:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6868
    mov x0, #0
blk_end_6868:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7082
    tst x9, #1
    b.eq do_concat_7081
    tst x0, #1
    b.ne do_compose_7079
do_apply_7080:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7083
do_compose_7079:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7083
do_concat_7081:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7083
id_morphism_7082:
    b apply_end_7083
apply_end_7083:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6867
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_body
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7087
    tst x9, #1
    b.eq do_concat_7086
    tst x0, #1
    b.ne do_compose_7084
do_apply_7085:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7088
do_compose_7084:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7088
do_concat_7086:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7088
id_morphism_7087:
    b apply_end_7088
apply_end_7088:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7092
    tst x9, #1
    b.eq do_concat_7091
    tst x0, #1
    b.ne do_compose_7089
do_apply_7090:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7093
do_compose_7089:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7093
do_concat_7091:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7093
id_morphism_7092:
    b apply_end_7093
apply_end_7093:
blk_end_6867:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7097
    tst x9, #1
    b.eq do_concat_7096
    tst x0, #1
    b.ne do_compose_7094
do_apply_7095:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7098
do_compose_7094:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7098
do_concat_7096:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7098
id_morphism_7097:
    b apply_end_7098
apply_end_7098:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7102
    tst x9, #1
    b.eq do_concat_7101
    tst x0, #1
    b.ne do_compose_7099
do_apply_7100:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7103
do_compose_7099:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7103
do_concat_7101:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7103
id_morphism_7102:
    b apply_end_7103
apply_end_7103:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7107
    tst x9, #1
    b.eq do_concat_7106
    tst x0, #1
    b.ne do_compose_7104
do_apply_7105:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7108
do_compose_7104:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7108
do_concat_7106:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7108
id_morphism_7107:
    b apply_end_7108
apply_end_7108:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6860
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_body
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7112
    tst x9, #1
    b.eq do_concat_7111
    tst x0, #1
    b.ne do_compose_7109
do_apply_7110:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7113
do_compose_7109:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7113
do_concat_7111:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7113
id_morphism_7112:
    b apply_end_7113
apply_end_7113:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_body
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7117
    tst x9, #1
    b.eq do_concat_7116
    tst x0, #1
    b.ne do_compose_7114
do_apply_7115:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7118
do_compose_7114:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7118
do_concat_7116:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7118
id_morphism_7117:
    b apply_end_7118
apply_end_7118:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7122
    tst x9, #1
    b.eq do_concat_7121
    tst x0, #1
    b.ne do_compose_7119
do_apply_7120:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7123
do_compose_7119:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7123
do_concat_7121:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7123
id_morphism_7122:
    b apply_end_7123
apply_end_7123:
blk_end_6860:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7127
    tst x9, #1
    b.eq do_concat_7126
    tst x0, #1
    b.ne do_compose_7124
do_apply_7125:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7128
do_compose_7124:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7128
do_concat_7126:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7128
id_morphism_7127:
    b apply_end_7128
apply_end_7128:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6857
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, body
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7132
    tst x9, #1
    b.eq do_concat_7131
    tst x0, #1
    b.ne do_compose_7129
do_apply_7130:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7133
do_compose_7129:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7133
do_concat_7131:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7133
id_morphism_7132:
    b apply_end_7133
apply_end_7133:
    str x0, [sp, #-16]!
    adr x0, ctx_with_arg
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7137
    tst x9, #1
    b.eq do_concat_7136
    tst x0, #1
    b.ne do_compose_7134
do_apply_7135:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7138
do_compose_7134:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7138
do_concat_7136:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7138
id_morphism_7137:
    b apply_end_7138
apply_end_7138:
blk_end_6857:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7142
    tst x9, #1
    b.eq do_concat_7141
    tst x0, #1
    b.ne do_compose_7139
do_apply_7140:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7143
do_compose_7139:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7143
do_concat_7141:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7143
id_morphism_7142:
    b apply_end_7143
apply_end_7143:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6854
    adr x0, push_var
    str x0, [sp, #-16]!
    adr x0, ctx_lbl
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7147
    tst x9, #1
    b.eq do_concat_7146
    tst x0, #1
    b.ne do_compose_7144
do_apply_7145:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7148
do_compose_7144:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7148
do_concat_7146:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7148
id_morphism_7147:
    b apply_end_7148
apply_end_7148:
    str x0, [sp, #-16]!
    adr x0, param_name
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7152
    tst x9, #1
    b.eq do_concat_7151
    tst x0, #1
    b.ne do_compose_7149
do_apply_7150:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7153
do_compose_7149:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7153
do_concat_7151:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7153
id_morphism_7152:
    b apply_end_7153
apply_end_7153:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, params
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7157
    tst x9, #1
    b.eq do_concat_7156
    tst x0, #1
    b.ne do_compose_7154
do_apply_7155:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7158
do_compose_7154:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7158
do_concat_7156:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7158
id_morphism_7157:
    b apply_end_7158
apply_end_7158:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7162
    tst x9, #1
    b.eq do_concat_7161
    tst x0, #1
    b.ne do_compose_7159
do_apply_7160:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7163
do_compose_7159:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7163
do_concat_7161:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7163
id_morphism_7162:
    b apply_end_7163
apply_end_7163:
    str x0, [sp, #-16]!
    adr x0, str_71
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7167
    tst x9, #1
    b.eq do_concat_7166
    tst x0, #1
    b.ne do_compose_7164
do_apply_7165:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7168
do_compose_7164:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7168
do_concat_7166:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7168
id_morphism_7167:
    b apply_end_7168
apply_end_7168:
blk_end_6854:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7172
    tst x9, #1
    b.eq do_concat_7171
    tst x0, #1
    b.ne do_compose_7169
do_apply_7170:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7173
do_compose_7169:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7173
do_concat_7171:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7173
id_morphism_7172:
    b apply_end_7173
apply_end_7173:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6847
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_after
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7177
    tst x9, #1
    b.eq do_concat_7176
    tst x0, #1
    b.ne do_compose_7174
do_apply_7175:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7178
do_compose_7174:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7178
do_concat_7176:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7178
id_morphism_7177:
    b apply_end_7178
apply_end_7178:
    str x0, [sp, #-16]!
    adr x0, new_label
    str x0, [sp, #-16]!
    adr x0, ctx_lbl
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7182
    tst x9, #1
    b.eq do_concat_7181
    tst x0, #1
    b.ne do_compose_7179
do_apply_7180:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7183
do_compose_7179:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7183
do_concat_7181:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7183
id_morphism_7182:
    b apply_end_7183
apply_end_7183:
    str x0, [sp, #-16]!
    adr x0, str_72
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7187
    tst x9, #1
    b.eq do_concat_7186
    tst x0, #1
    b.ne do_compose_7184
do_apply_7185:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7188
do_compose_7184:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7188
do_concat_7186:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7188
id_morphism_7187:
    b apply_end_7188
apply_end_7188:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7192
    tst x9, #1
    b.eq do_concat_7191
    tst x0, #1
    b.ne do_compose_7189
do_apply_7190:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7193
do_compose_7189:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7193
do_concat_7191:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7193
id_morphism_7192:
    b apply_end_7193
apply_end_7193:
blk_end_6847:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7197
    tst x9, #1
    b.eq do_concat_7196
    tst x0, #1
    b.ne do_compose_7194
do_apply_7195:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7198
do_compose_7194:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7198
do_concat_7196:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7198
id_morphism_7197:
    b apply_end_7198
apply_end_7198:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6840
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_lbl
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7202
    tst x9, #1
    b.eq do_concat_7201
    tst x0, #1
    b.ne do_compose_7199
do_apply_7200:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7203
do_compose_7199:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7203
do_concat_7201:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7203
id_morphism_7202:
    b apply_end_7203
apply_end_7203:
    str x0, [sp, #-16]!
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7207
    tst x9, #1
    b.eq do_concat_7206
    tst x0, #1
    b.ne do_compose_7204
do_apply_7205:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7208
do_compose_7204:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7208
do_concat_7206:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7208
id_morphism_7207:
    b apply_end_7208
apply_end_7208:
    str x0, [sp, #-16]!
    adr x0, str_73
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7212
    tst x9, #1
    b.eq do_concat_7211
    tst x0, #1
    b.ne do_compose_7209
do_apply_7210:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7213
do_compose_7209:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7213
do_concat_7211:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7213
id_morphism_7212:
    b apply_end_7213
apply_end_7213:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7217
    tst x9, #1
    b.eq do_concat_7216
    tst x0, #1
    b.ne do_compose_7214
do_apply_7215:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7218
do_compose_7214:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7218
do_concat_7216:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7218
id_morphism_7217:
    b apply_end_7218
apply_end_7218:
blk_end_6840:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7222
    tst x9, #1
    b.eq do_concat_7221
    tst x0, #1
    b.ne do_compose_7219
do_apply_7220:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7223
do_compose_7219:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7223
do_concat_7221:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7223
id_morphism_7222:
    b apply_end_7223
apply_end_7223:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_6835
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7227
    tst x9, #1
    b.eq do_concat_7226
    tst x0, #1
    b.ne do_compose_7224
do_apply_7225:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7228
do_compose_7224:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7228
do_concat_7226:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7228
id_morphism_7227:
    b apply_end_7228
apply_end_7228:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7232
    tst x9, #1
    b.eq do_concat_7231
    tst x0, #1
    b.ne do_compose_7229
do_apply_7230:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7233
do_compose_7229:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7233
do_concat_7231:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7233
id_morphism_7232:
    b apply_end_7233
apply_end_7233:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7237
    tst x9, #1
    b.eq do_concat_7236
    tst x0, #1
    b.ne do_compose_7234
do_apply_7235:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7238
do_compose_7234:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7238
do_concat_7236:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7238
id_morphism_7237:
    b apply_end_7238
apply_end_7238:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7242
    tst x9, #1
    b.eq do_concat_7241
    tst x0, #1
    b.ne do_compose_7239
do_apply_7240:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7243
do_compose_7239:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7243
do_concat_7241:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7243
id_morphism_7242:
    b apply_end_7243
apply_end_7243:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7247
    tst x9, #1
    b.eq do_concat_7246
    tst x0, #1
    b.ne do_compose_7244
do_apply_7245:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7248
do_compose_7244:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7248
do_concat_7246:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7248
id_morphism_7247:
    b apply_end_7248
apply_end_7248:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7252
    tst x9, #1
    b.eq do_concat_7251
    tst x0, #1
    b.ne do_compose_7249
do_apply_7250:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7253
do_compose_7249:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7253
do_concat_7251:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7253
id_morphism_7252:
    b apply_end_7253
apply_end_7253:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7257
    tst x9, #1
    b.eq do_concat_7256
    tst x0, #1
    b.ne do_compose_7254
do_apply_7255:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7258
do_compose_7254:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7258
do_concat_7256:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7258
id_morphism_7257:
    b apply_end_7258
apply_end_7258:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7262
    tst x9, #1
    b.eq do_concat_7261
    tst x0, #1
    b.ne do_compose_7259
do_apply_7260:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7263
do_compose_7259:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7263
do_concat_7261:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7263
id_morphism_7262:
    b apply_end_7263
apply_end_7263:
blk_end_6835:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6833_6834:
    // Closure for func_6833
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6833
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6831_6832:
    // Closure for func_6831
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6831
    ldr x0, [sp], #16
    bl _cons
    b cond_end_6825
cond_false_6824:
    adr x0, sign_id
cond_end_6825:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_binop
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7269
    tst x9, #1
    b.eq do_concat_7268
    tst x0, #1
    b.ne do_compose_7266
do_apply_7267:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7270
do_compose_7266:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7270
do_concat_7268:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7270
id_morphism_7269:
    b apply_end_7270
apply_end_7270:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7264
    b after_func_7271_7272
func_7271:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7273_7274
func_7273:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_7275_7276
func_7275:
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
    b after_func_7278_7279
func_7278:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7280_7281
func_7280:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7280_7281:
    // Closure for func_7280
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7280
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7278_7279:
    // Closure for func_7278
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7278
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7283_7284
func_7283:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7283_7284:
    // Closure for func_7283
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7283
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7286_7287
func_7286:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7288_7289
func_7288:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7288_7289:
    // Closure for func_7288
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7288
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7286_7287:
    // Closure for func_7286
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7286
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7291_7292
func_7291:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7291_7292:
    // Closure for func_7291
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7291
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7294_7295
func_7294:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7296_7297
func_7296:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7296_7297:
    // Closure for func_7296
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7296
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7294_7295:
    // Closure for func_7294
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7294
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7302
    tst x9, #1
    b.eq do_concat_7301
    tst x0, #1
    b.ne do_compose_7299
do_apply_7300:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7303
do_compose_7299:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7303
do_concat_7301:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7303
id_morphism_7302:
    b apply_end_7303
apply_end_7303:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7307
    tst x9, #1
    b.eq do_concat_7306
    tst x0, #1
    b.ne do_compose_7304
do_apply_7305:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7308
do_compose_7304:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7308
do_concat_7306:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7308
id_morphism_7307:
    b apply_end_7308
apply_end_7308:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7312
    tst x9, #1
    b.eq do_concat_7311
    tst x0, #1
    b.ne do_compose_7309
do_apply_7310:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7313
do_compose_7309:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7313
do_concat_7311:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7313
id_morphism_7312:
    b apply_end_7313
apply_end_7313:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_74
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7317
    tst x9, #1
    b.eq do_concat_7316
    tst x0, #1
    b.ne do_compose_7314
do_apply_7315:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7318
do_compose_7314:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7318
do_concat_7316:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7318
id_morphism_7317:
    b apply_end_7318
apply_end_7318:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_69
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7322
    tst x9, #1
    b.eq do_concat_7321
    tst x0, #1
    b.ne do_compose_7319
do_apply_7320:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7323
do_compose_7319:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7323
do_concat_7321:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7323
id_morphism_7322:
    b apply_end_7323
apply_end_7323:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7327
    tst x9, #1
    b.eq do_concat_7326
    tst x0, #1
    b.ne do_compose_7324
do_apply_7325:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7328
do_compose_7324:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7328
do_concat_7326:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7328
id_morphism_7327:
    b apply_end_7328
apply_end_7328:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7332
    tst x9, #1
    b.eq do_concat_7331
    tst x0, #1
    b.ne do_compose_7329
do_apply_7330:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7333
do_compose_7329:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7333
do_concat_7331:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7333
id_morphism_7332:
    b apply_end_7333
apply_end_7333:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7337
    tst x9, #1
    b.eq do_concat_7336
    tst x0, #1
    b.ne do_compose_7334
do_apply_7335:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7338
do_compose_7334:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7338
do_concat_7336:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7338
id_morphism_7337:
    b apply_end_7338
apply_end_7338:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7342
    tst x9, #1
    b.eq do_concat_7341
    tst x0, #1
    b.ne do_compose_7339
do_apply_7340:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7343
do_compose_7339:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7343
do_concat_7341:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7343
id_morphism_7342:
    b apply_end_7343
apply_end_7343:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7347
    tst x9, #1
    b.eq do_concat_7346
    tst x0, #1
    b.ne do_compose_7344
do_apply_7345:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7348
do_compose_7344:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7348
do_concat_7346:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7348
id_morphism_7347:
    b apply_end_7348
apply_end_7348:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7352
    tst x9, #1
    b.eq do_concat_7351
    tst x0, #1
    b.ne do_compose_7349
do_apply_7350:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7353
do_compose_7349:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7353
do_concat_7351:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7353
id_morphism_7352:
    b apply_end_7353
apply_end_7353:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7357
    tst x9, #1
    b.eq do_concat_7356
    tst x0, #1
    b.ne do_compose_7354
do_apply_7355:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7358
do_compose_7354:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7358
do_concat_7356:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7358
id_morphism_7357:
    b apply_end_7358
apply_end_7358:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7298
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7362
    tst x9, #1
    b.eq do_concat_7361
    tst x0, #1
    b.ne do_compose_7359
do_apply_7360:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7363
do_compose_7359:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7363
do_concat_7361:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7363
id_morphism_7362:
    b apply_end_7363
apply_end_7363:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7367
    tst x9, #1
    b.eq do_concat_7366
    tst x0, #1
    b.ne do_compose_7364
do_apply_7365:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7368
do_compose_7364:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7368
do_concat_7366:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7368
id_morphism_7367:
    b apply_end_7368
apply_end_7368:
blk_end_7298:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7372
    tst x9, #1
    b.eq do_concat_7371
    tst x0, #1
    b.ne do_compose_7369
do_apply_7370:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7373
do_compose_7369:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7373
do_concat_7371:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7373
id_morphism_7372:
    b apply_end_7373
apply_end_7373:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7377
    tst x9, #1
    b.eq do_concat_7376
    tst x0, #1
    b.ne do_compose_7374
do_apply_7375:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7378
do_compose_7374:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7378
do_concat_7376:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7378
id_morphism_7377:
    b apply_end_7378
apply_end_7378:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7293
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7382
    tst x9, #1
    b.eq do_concat_7381
    tst x0, #1
    b.ne do_compose_7379
do_apply_7380:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7383
do_compose_7379:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7383
do_concat_7381:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7383
id_morphism_7382:
    b apply_end_7383
apply_end_7383:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7387
    tst x9, #1
    b.eq do_concat_7386
    tst x0, #1
    b.ne do_compose_7384
do_apply_7385:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7388
do_compose_7384:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7388
do_concat_7386:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7388
id_morphism_7387:
    b apply_end_7388
apply_end_7388:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7392
    tst x9, #1
    b.eq do_concat_7391
    tst x0, #1
    b.ne do_compose_7389
do_apply_7390:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7393
do_compose_7389:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7393
do_concat_7391:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7393
id_morphism_7392:
    b apply_end_7393
apply_end_7393:
blk_end_7293:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7397
    tst x9, #1
    b.eq do_concat_7396
    tst x0, #1
    b.ne do_compose_7394
do_apply_7395:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7398
do_compose_7394:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7398
do_concat_7396:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7398
id_morphism_7397:
    b apply_end_7398
apply_end_7398:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7290
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7402
    tst x9, #1
    b.eq do_concat_7401
    tst x0, #1
    b.ne do_compose_7399
do_apply_7400:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7403
do_compose_7399:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7403
do_concat_7401:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7403
id_morphism_7402:
    b apply_end_7403
apply_end_7403:
    str x0, [sp, #-16]!
    adr x0, ctx_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7407
    tst x9, #1
    b.eq do_concat_7406
    tst x0, #1
    b.ne do_compose_7404
do_apply_7405:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7408
do_compose_7404:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7408
do_concat_7406:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7408
id_morphism_7407:
    b apply_end_7408
apply_end_7408:
blk_end_7290:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7412
    tst x9, #1
    b.eq do_concat_7411
    tst x0, #1
    b.ne do_compose_7409
do_apply_7410:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7413
do_compose_7409:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7413
do_concat_7411:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7413
id_morphism_7412:
    b apply_end_7413
apply_end_7413:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7285
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7417
    tst x9, #1
    b.eq do_concat_7416
    tst x0, #1
    b.ne do_compose_7414
do_apply_7415:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7418
do_compose_7414:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7418
do_concat_7416:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7418
id_morphism_7417:
    b apply_end_7418
apply_end_7418:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7422
    tst x9, #1
    b.eq do_concat_7421
    tst x0, #1
    b.ne do_compose_7419
do_apply_7420:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7423
do_compose_7419:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7423
do_concat_7421:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7423
id_morphism_7422:
    b apply_end_7423
apply_end_7423:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7427
    tst x9, #1
    b.eq do_concat_7426
    tst x0, #1
    b.ne do_compose_7424
do_apply_7425:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7428
do_compose_7424:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7428
do_concat_7426:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7428
id_morphism_7427:
    b apply_end_7428
apply_end_7428:
blk_end_7285:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7432
    tst x9, #1
    b.eq do_concat_7431
    tst x0, #1
    b.ne do_compose_7429
do_apply_7430:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7433
do_compose_7429:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7433
do_concat_7431:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7433
id_morphism_7432:
    b apply_end_7433
apply_end_7433:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7282
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7437
    tst x9, #1
    b.eq do_concat_7436
    tst x0, #1
    b.ne do_compose_7434
do_apply_7435:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7438
do_compose_7434:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7438
do_concat_7436:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7438
id_morphism_7437:
    b apply_end_7438
apply_end_7438:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7442
    tst x9, #1
    b.eq do_concat_7441
    tst x0, #1
    b.ne do_compose_7439
do_apply_7440:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7443
do_compose_7439:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7443
do_concat_7441:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7443
id_morphism_7442:
    b apply_end_7443
apply_end_7443:
blk_end_7282:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7447
    tst x9, #1
    b.eq do_concat_7446
    tst x0, #1
    b.ne do_compose_7444
do_apply_7445:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7448
do_compose_7444:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7448
do_concat_7446:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7448
id_morphism_7447:
    b apply_end_7448
apply_end_7448:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7277
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7452
    tst x9, #1
    b.eq do_concat_7451
    tst x0, #1
    b.ne do_compose_7449
do_apply_7450:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7453
do_compose_7449:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7453
do_concat_7451:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7453
id_morphism_7452:
    b apply_end_7453
apply_end_7453:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7457
    tst x9, #1
    b.eq do_concat_7456
    tst x0, #1
    b.ne do_compose_7454
do_apply_7455:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7458
do_compose_7454:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7458
do_concat_7456:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7458
id_morphism_7457:
    b apply_end_7458
apply_end_7458:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7462
    tst x9, #1
    b.eq do_concat_7461
    tst x0, #1
    b.ne do_compose_7459
do_apply_7460:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7463
do_compose_7459:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7463
do_concat_7461:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7463
id_morphism_7462:
    b apply_end_7463
apply_end_7463:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7467
    tst x9, #1
    b.eq do_concat_7466
    tst x0, #1
    b.ne do_compose_7464
do_apply_7465:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7468
do_compose_7464:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7468
do_concat_7466:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7468
id_morphism_7467:
    b apply_end_7468
apply_end_7468:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7472
    tst x9, #1
    b.eq do_concat_7471
    tst x0, #1
    b.ne do_compose_7469
do_apply_7470:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7473
do_compose_7469:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7473
do_concat_7471:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7473
id_morphism_7472:
    b apply_end_7473
apply_end_7473:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7477
    tst x9, #1
    b.eq do_concat_7476
    tst x0, #1
    b.ne do_compose_7474
do_apply_7475:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7478
do_compose_7474:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7478
do_concat_7476:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7478
id_morphism_7477:
    b apply_end_7478
apply_end_7478:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7482
    tst x9, #1
    b.eq do_concat_7481
    tst x0, #1
    b.ne do_compose_7479
do_apply_7480:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7483
do_compose_7479:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7483
do_concat_7481:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7483
id_morphism_7482:
    b apply_end_7483
apply_end_7483:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7487
    tst x9, #1
    b.eq do_concat_7486
    tst x0, #1
    b.ne do_compose_7484
do_apply_7485:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7488
do_compose_7484:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7488
do_concat_7486:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7488
id_morphism_7487:
    b apply_end_7488
apply_end_7488:
blk_end_7277:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7275_7276:
    // Closure for func_7275
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_7275
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7273_7274:
    // Closure for func_7273
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_7273
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7271_7272:
    // Closure for func_7271
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7271
    ldr x0, [sp], #16
    bl _cons
    b cond_end_7265
cond_false_7264:
    adr x0, sign_id
cond_end_7265:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_cmp
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7494
    tst x9, #1
    b.eq do_concat_7493
    tst x0, #1
    b.ne do_compose_7491
do_apply_7492:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7495
do_compose_7491:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7495
do_concat_7493:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7495
id_morphism_7494:
    b apply_end_7495
apply_end_7495:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7489
    b after_func_7496_7497
func_7496:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7498_7499
func_7498:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_7500_7501
func_7500:
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
    b after_func_7503_7504
func_7503:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7505_7506
func_7505:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7505_7506:
    // Closure for func_7505
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7505
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7503_7504:
    // Closure for func_7503
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7503
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7508_7509
func_7508:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7508_7509:
    // Closure for func_7508
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7508
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7511_7512
func_7511:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7513_7514
func_7513:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7513_7514:
    // Closure for func_7513
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7513
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7511_7512:
    // Closure for func_7511
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7511
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7516_7517
func_7516:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7516_7517:
    // Closure for func_7516
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7516
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7519_7520
func_7519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7521_7522
func_7521:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7521_7522:
    // Closure for func_7521
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7521
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7519_7520:
    // Closure for func_7519
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7519
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7524_7525
func_7524:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7526_7527
func_7526:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7528_7529
func_7528:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7528_7529:
    // Closure for func_7528
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7528
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7526_7527:
    // Closure for func_7526
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7526
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7524_7525:
    // Closure for func_7524
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7524
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7531_7532
func_7531:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7531_7532:
    // Closure for func_7531
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7531
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7537
    tst x9, #1
    b.eq do_concat_7536
    tst x0, #1
    b.ne do_compose_7534
do_apply_7535:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7538
do_compose_7534:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7538
do_concat_7536:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7538
id_morphism_7537:
    b apply_end_7538
apply_end_7538:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7542
    tst x9, #1
    b.eq do_concat_7541
    tst x0, #1
    b.ne do_compose_7539
do_apply_7540:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7543
do_compose_7539:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7543
do_concat_7541:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7543
id_morphism_7542:
    b apply_end_7543
apply_end_7543:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7547
    tst x9, #1
    b.eq do_concat_7546
    tst x0, #1
    b.ne do_compose_7544
do_apply_7545:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7548
do_compose_7544:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7548
do_concat_7546:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7548
id_morphism_7547:
    b apply_end_7548
apply_end_7548:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_74
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7552
    tst x9, #1
    b.eq do_concat_7551
    tst x0, #1
    b.ne do_compose_7549
do_apply_7550:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7553
do_compose_7549:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7553
do_concat_7551:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7553
id_morphism_7552:
    b apply_end_7553
apply_end_7553:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_69
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7557
    tst x9, #1
    b.eq do_concat_7556
    tst x0, #1
    b.ne do_compose_7554
do_apply_7555:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7558
do_compose_7554:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7558
do_concat_7556:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7558
id_morphism_7557:
    b apply_end_7558
apply_end_7558:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_75
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7562
    tst x9, #1
    b.eq do_concat_7561
    tst x0, #1
    b.ne do_compose_7559
do_apply_7560:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7563
do_compose_7559:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7563
do_concat_7561:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7563
id_morphism_7562:
    b apply_end_7563
apply_end_7563:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_76
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7567
    tst x9, #1
    b.eq do_concat_7566
    tst x0, #1
    b.ne do_compose_7564
do_apply_7565:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7568
do_compose_7564:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7568
do_concat_7566:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7568
id_morphism_7567:
    b apply_end_7568
apply_end_7568:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7572
    tst x9, #1
    b.eq do_concat_7571
    tst x0, #1
    b.ne do_compose_7569
do_apply_7570:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7573
do_compose_7569:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7573
do_concat_7571:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7573
id_morphism_7572:
    b apply_end_7573
apply_end_7573:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #32
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7577
    tst x9, #1
    b.eq do_concat_7576
    tst x0, #1
    b.ne do_compose_7574
do_apply_7575:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7578
do_compose_7574:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7578
do_concat_7576:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7578
id_morphism_7577:
    b apply_end_7578
apply_end_7578:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_true
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7582
    tst x9, #1
    b.eq do_concat_7581
    tst x0, #1
    b.ne do_compose_7579
do_apply_7580:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7583
do_compose_7579:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7583
do_concat_7581:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7583
id_morphism_7582:
    b apply_end_7583
apply_end_7583:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7587
    tst x9, #1
    b.eq do_concat_7586
    tst x0, #1
    b.ne do_compose_7584
do_apply_7585:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7588
do_compose_7584:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7588
do_concat_7586:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7588
id_morphism_7587:
    b apply_end_7588
apply_end_7588:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7592
    tst x9, #1
    b.eq do_concat_7591
    tst x0, #1
    b.ne do_compose_7589
do_apply_7590:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7593
do_compose_7589:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7593
do_concat_7591:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7593
id_morphism_7592:
    b apply_end_7593
apply_end_7593:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7597
    tst x9, #1
    b.eq do_concat_7596
    tst x0, #1
    b.ne do_compose_7594
do_apply_7595:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7598
do_compose_7594:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7598
do_concat_7596:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7598
id_morphism_7597:
    b apply_end_7598
apply_end_7598:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7602
    tst x9, #1
    b.eq do_concat_7601
    tst x0, #1
    b.ne do_compose_7599
do_apply_7600:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7603
do_compose_7599:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7603
do_concat_7601:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7603
id_morphism_7602:
    b apply_end_7603
apply_end_7603:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7607
    tst x9, #1
    b.eq do_concat_7606
    tst x0, #1
    b.ne do_compose_7604
do_apply_7605:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7608
do_compose_7604:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7608
do_concat_7606:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7608
id_morphism_7607:
    b apply_end_7608
apply_end_7608:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_77
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7612
    tst x9, #1
    b.eq do_concat_7611
    tst x0, #1
    b.ne do_compose_7609
do_apply_7610:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7613
do_compose_7609:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7613
do_concat_7611:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7613
id_morphism_7612:
    b apply_end_7613
apply_end_7613:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_60
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7617
    tst x9, #1
    b.eq do_concat_7616
    tst x0, #1
    b.ne do_compose_7614
do_apply_7615:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7618
do_compose_7614:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7618
do_concat_7616:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7618
id_morphism_7617:
    b apply_end_7618
apply_end_7618:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7622
    tst x9, #1
    b.eq do_concat_7621
    tst x0, #1
    b.ne do_compose_7619
do_apply_7620:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7623
do_compose_7619:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7623
do_concat_7621:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7623
id_morphism_7622:
    b apply_end_7623
apply_end_7623:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7627
    tst x9, #1
    b.eq do_concat_7626
    tst x0, #1
    b.ne do_compose_7624
do_apply_7625:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7628
do_compose_7624:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7628
do_concat_7626:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7628
id_morphism_7627:
    b apply_end_7628
apply_end_7628:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7632
    tst x9, #1
    b.eq do_concat_7631
    tst x0, #1
    b.ne do_compose_7629
do_apply_7630:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7633
do_compose_7629:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7633
do_concat_7631:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7633
id_morphism_7632:
    b apply_end_7633
apply_end_7633:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7637
    tst x9, #1
    b.eq do_concat_7636
    tst x0, #1
    b.ne do_compose_7634
do_apply_7635:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7638
do_compose_7634:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7638
do_concat_7636:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7638
id_morphism_7637:
    b apply_end_7638
apply_end_7638:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_true
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7642
    tst x9, #1
    b.eq do_concat_7641
    tst x0, #1
    b.ne do_compose_7639
do_apply_7640:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7643
do_compose_7639:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7643
do_concat_7641:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7643
id_morphism_7642:
    b apply_end_7643
apply_end_7643:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7647
    tst x9, #1
    b.eq do_concat_7646
    tst x0, #1
    b.ne do_compose_7644
do_apply_7645:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7648
do_compose_7644:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7648
do_concat_7646:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7648
id_morphism_7647:
    b apply_end_7648
apply_end_7648:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7652
    tst x9, #1
    b.eq do_concat_7651
    tst x0, #1
    b.ne do_compose_7649
do_apply_7650:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7653
do_compose_7649:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7653
do_concat_7651:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7653
id_morphism_7652:
    b apply_end_7653
apply_end_7653:
    str x0, [sp, #-16]!
    adr x0, str_78
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7654
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7658
    tst x9, #1
    b.eq do_concat_7657
    tst x0, #1
    b.ne do_compose_7655
do_apply_7656:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7659
do_compose_7655:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7659
do_concat_7657:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7659
id_morphism_7658:
    b apply_end_7659
apply_end_7659:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7663
    tst x9, #1
    b.eq do_concat_7662
    tst x0, #1
    b.ne do_compose_7660
do_apply_7661:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7664
do_compose_7660:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7664
do_concat_7662:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7664
id_morphism_7663:
    b apply_end_7664
apply_end_7664:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7668
    tst x9, #1
    b.eq do_concat_7667
    tst x0, #1
    b.ne do_compose_7665
do_apply_7666:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7669
do_compose_7665:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7669
do_concat_7667:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7669
id_morphism_7668:
    b apply_end_7669
apply_end_7669:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7673
    tst x9, #1
    b.eq do_concat_7672
    tst x0, #1
    b.ne do_compose_7670
do_apply_7671:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7674
do_compose_7670:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7674
do_concat_7672:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7674
id_morphism_7673:
    b apply_end_7674
apply_end_7674:
blk_end_7654:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7678
    tst x9, #1
    b.eq do_concat_7677
    tst x0, #1
    b.ne do_compose_7675
do_apply_7676:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7679
do_compose_7675:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7679
do_concat_7677:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7679
id_morphism_7678:
    b apply_end_7679
apply_end_7679:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7683
    tst x9, #1
    b.eq do_concat_7682
    tst x0, #1
    b.ne do_compose_7680
do_apply_7681:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7684
do_compose_7680:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7684
do_concat_7682:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7684
id_morphism_7683:
    b apply_end_7684
apply_end_7684:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7688
    tst x9, #1
    b.eq do_concat_7687
    tst x0, #1
    b.ne do_compose_7685
do_apply_7686:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7689
do_compose_7685:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7689
do_concat_7687:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7689
id_morphism_7688:
    b apply_end_7689
apply_end_7689:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7693
    tst x9, #1
    b.eq do_concat_7692
    tst x0, #1
    b.ne do_compose_7690
do_apply_7691:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7694
do_compose_7690:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7694
do_concat_7692:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7694
id_morphism_7693:
    b apply_end_7694
apply_end_7694:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7698
    tst x9, #1
    b.eq do_concat_7697
    tst x0, #1
    b.ne do_compose_7695
do_apply_7696:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7699
do_compose_7695:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7699
do_concat_7697:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7699
id_morphism_7698:
    b apply_end_7699
apply_end_7699:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7703
    tst x9, #1
    b.eq do_concat_7702
    tst x0, #1
    b.ne do_compose_7700
do_apply_7701:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7704
do_compose_7700:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7704
do_concat_7702:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7704
id_morphism_7703:
    b apply_end_7704
apply_end_7704:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7708
    tst x9, #1
    b.eq do_concat_7707
    tst x0, #1
    b.ne do_compose_7705
do_apply_7706:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7709
do_compose_7705:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7709
do_concat_7707:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7709
id_morphism_7708:
    b apply_end_7709
apply_end_7709:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7713
    tst x9, #1
    b.eq do_concat_7712
    tst x0, #1
    b.ne do_compose_7710
do_apply_7711:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7714
do_compose_7710:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7714
do_concat_7712:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7714
id_morphism_7713:
    b apply_end_7714
apply_end_7714:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7718
    tst x9, #1
    b.eq do_concat_7717
    tst x0, #1
    b.ne do_compose_7715
do_apply_7716:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7719
do_compose_7715:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7719
do_concat_7717:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7719
id_morphism_7718:
    b apply_end_7719
apply_end_7719:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7723
    tst x9, #1
    b.eq do_concat_7722
    tst x0, #1
    b.ne do_compose_7720
do_apply_7721:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7724
do_compose_7720:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7724
do_concat_7722:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7724
id_morphism_7723:
    b apply_end_7724
apply_end_7724:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7533
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_final
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7728
    tst x9, #1
    b.eq do_concat_7727
    tst x0, #1
    b.ne do_compose_7725
do_apply_7726:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7729
do_compose_7725:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7729
do_concat_7727:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7729
id_morphism_7728:
    b apply_end_7729
apply_end_7729:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7733
    tst x9, #1
    b.eq do_concat_7732
    tst x0, #1
    b.ne do_compose_7730
do_apply_7731:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7734
do_compose_7730:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7734
do_concat_7732:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7734
id_morphism_7733:
    b apply_end_7734
apply_end_7734:
blk_end_7533:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7738
    tst x9, #1
    b.eq do_concat_7737
    tst x0, #1
    b.ne do_compose_7735
do_apply_7736:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7739
do_compose_7735:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7739
do_concat_7737:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7739
id_morphism_7738:
    b apply_end_7739
apply_end_7739:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7743
    tst x9, #1
    b.eq do_concat_7742
    tst x0, #1
    b.ne do_compose_7740
do_apply_7741:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7744
do_compose_7740:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7744
do_concat_7742:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7744
id_morphism_7743:
    b apply_end_7744
apply_end_7744:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7530
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_lbl_end
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7748
    tst x9, #1
    b.eq do_concat_7747
    tst x0, #1
    b.ne do_compose_7745
do_apply_7746:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7749
do_compose_7745:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7749
do_concat_7747:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7749
id_morphism_7748:
    b apply_end_7749
apply_end_7749:
blk_end_7530:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7753
    tst x9, #1
    b.eq do_concat_7752
    tst x0, #1
    b.ne do_compose_7750
do_apply_7751:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7754
do_compose_7750:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7754
do_concat_7752:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7754
id_morphism_7753:
    b apply_end_7754
apply_end_7754:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7523
    adr x0, new_label
    str x0, [sp, #-16]!
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7758
    tst x9, #1
    b.eq do_concat_7757
    tst x0, #1
    b.ne do_compose_7755
do_apply_7756:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7759
do_compose_7755:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7759
do_concat_7757:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7759
id_morphism_7758:
    b apply_end_7759
apply_end_7759:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7763
    tst x9, #1
    b.eq do_concat_7762
    tst x0, #1
    b.ne do_compose_7760
do_apply_7761:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7764
do_compose_7760:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7764
do_concat_7762:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7764
id_morphism_7763:
    b apply_end_7764
apply_end_7764:
    str x0, [sp, #-16]!
    adr x0, str_79
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7768
    tst x9, #1
    b.eq do_concat_7767
    tst x0, #1
    b.ne do_compose_7765
do_apply_7766:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7769
do_compose_7765:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7769
do_concat_7767:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7769
id_morphism_7768:
    b apply_end_7769
apply_end_7769:
    str x0, [sp, #-16]!
    adr x0, new_label
    str x0, [sp, #-16]!
    adr x0, ctx_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7773
    tst x9, #1
    b.eq do_concat_7772
    tst x0, #1
    b.ne do_compose_7770
do_apply_7771:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7774
do_compose_7770:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7774
do_concat_7772:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7774
id_morphism_7773:
    b apply_end_7774
apply_end_7774:
    str x0, [sp, #-16]!
    adr x0, str_80
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7778
    tst x9, #1
    b.eq do_concat_7777
    tst x0, #1
    b.ne do_compose_7775
do_apply_7776:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7779
do_compose_7775:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7779
do_concat_7777:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7779
id_morphism_7778:
    b apply_end_7779
apply_end_7779:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7783
    tst x9, #1
    b.eq do_concat_7782
    tst x0, #1
    b.ne do_compose_7780
do_apply_7781:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7784
do_compose_7780:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7784
do_concat_7782:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7784
id_morphism_7783:
    b apply_end_7784
apply_end_7784:
blk_end_7523:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7788
    tst x9, #1
    b.eq do_concat_7787
    tst x0, #1
    b.ne do_compose_7785
do_apply_7786:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7789
do_compose_7785:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7789
do_concat_7787:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7789
id_morphism_7788:
    b apply_end_7789
apply_end_7789:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7518
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7793
    tst x9, #1
    b.eq do_concat_7792
    tst x0, #1
    b.ne do_compose_7790
do_apply_7791:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7794
do_compose_7790:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7794
do_concat_7792:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7794
id_morphism_7793:
    b apply_end_7794
apply_end_7794:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7798
    tst x9, #1
    b.eq do_concat_7797
    tst x0, #1
    b.ne do_compose_7795
do_apply_7796:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7799
do_compose_7795:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7799
do_concat_7797:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7799
id_morphism_7798:
    b apply_end_7799
apply_end_7799:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7803
    tst x9, #1
    b.eq do_concat_7802
    tst x0, #1
    b.ne do_compose_7800
do_apply_7801:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7804
do_compose_7800:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7804
do_concat_7802:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7804
id_morphism_7803:
    b apply_end_7804
apply_end_7804:
blk_end_7518:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7808
    tst x9, #1
    b.eq do_concat_7807
    tst x0, #1
    b.ne do_compose_7805
do_apply_7806:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7809
do_compose_7805:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7809
do_concat_7807:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7809
id_morphism_7808:
    b apply_end_7809
apply_end_7809:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7515
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7813
    tst x9, #1
    b.eq do_concat_7812
    tst x0, #1
    b.ne do_compose_7810
do_apply_7811:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7814
do_compose_7810:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7814
do_concat_7812:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7814
id_morphism_7813:
    b apply_end_7814
apply_end_7814:
    str x0, [sp, #-16]!
    adr x0, ctx_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7818
    tst x9, #1
    b.eq do_concat_7817
    tst x0, #1
    b.ne do_compose_7815
do_apply_7816:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7819
do_compose_7815:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7819
do_concat_7817:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7819
id_morphism_7818:
    b apply_end_7819
apply_end_7819:
blk_end_7515:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7823
    tst x9, #1
    b.eq do_concat_7822
    tst x0, #1
    b.ne do_compose_7820
do_apply_7821:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7824
do_compose_7820:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7824
do_concat_7822:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7824
id_morphism_7823:
    b apply_end_7824
apply_end_7824:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7510
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7828
    tst x9, #1
    b.eq do_concat_7827
    tst x0, #1
    b.ne do_compose_7825
do_apply_7826:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7829
do_compose_7825:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7829
do_concat_7827:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7829
id_morphism_7828:
    b apply_end_7829
apply_end_7829:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7833
    tst x9, #1
    b.eq do_concat_7832
    tst x0, #1
    b.ne do_compose_7830
do_apply_7831:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7834
do_compose_7830:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7834
do_concat_7832:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7834
id_morphism_7833:
    b apply_end_7834
apply_end_7834:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7838
    tst x9, #1
    b.eq do_concat_7837
    tst x0, #1
    b.ne do_compose_7835
do_apply_7836:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7839
do_compose_7835:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7839
do_concat_7837:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7839
id_morphism_7838:
    b apply_end_7839
apply_end_7839:
blk_end_7510:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7843
    tst x9, #1
    b.eq do_concat_7842
    tst x0, #1
    b.ne do_compose_7840
do_apply_7841:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7844
do_compose_7840:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7844
do_concat_7842:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7844
id_morphism_7843:
    b apply_end_7844
apply_end_7844:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7507
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7848
    tst x9, #1
    b.eq do_concat_7847
    tst x0, #1
    b.ne do_compose_7845
do_apply_7846:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7849
do_compose_7845:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7849
do_concat_7847:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7849
id_morphism_7848:
    b apply_end_7849
apply_end_7849:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7853
    tst x9, #1
    b.eq do_concat_7852
    tst x0, #1
    b.ne do_compose_7850
do_apply_7851:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7854
do_compose_7850:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7854
do_concat_7852:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7854
id_morphism_7853:
    b apply_end_7854
apply_end_7854:
blk_end_7507:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7858
    tst x9, #1
    b.eq do_concat_7857
    tst x0, #1
    b.ne do_compose_7855
do_apply_7856:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7859
do_compose_7855:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7859
do_concat_7857:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7859
id_morphism_7858:
    b apply_end_7859
apply_end_7859:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7502
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7863
    tst x9, #1
    b.eq do_concat_7862
    tst x0, #1
    b.ne do_compose_7860
do_apply_7861:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7864
do_compose_7860:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7864
do_concat_7862:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7864
id_morphism_7863:
    b apply_end_7864
apply_end_7864:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7868
    tst x9, #1
    b.eq do_concat_7867
    tst x0, #1
    b.ne do_compose_7865
do_apply_7866:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7869
do_compose_7865:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7869
do_concat_7867:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7869
id_morphism_7868:
    b apply_end_7869
apply_end_7869:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7873
    tst x9, #1
    b.eq do_concat_7872
    tst x0, #1
    b.ne do_compose_7870
do_apply_7871:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7874
do_compose_7870:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7874
do_concat_7872:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7874
id_morphism_7873:
    b apply_end_7874
apply_end_7874:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7878
    tst x9, #1
    b.eq do_concat_7877
    tst x0, #1
    b.ne do_compose_7875
do_apply_7876:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7879
do_compose_7875:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7879
do_concat_7877:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7879
id_morphism_7878:
    b apply_end_7879
apply_end_7879:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7883
    tst x9, #1
    b.eq do_concat_7882
    tst x0, #1
    b.ne do_compose_7880
do_apply_7881:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7884
do_compose_7880:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7884
do_concat_7882:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7884
id_morphism_7883:
    b apply_end_7884
apply_end_7884:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7888
    tst x9, #1
    b.eq do_concat_7887
    tst x0, #1
    b.ne do_compose_7885
do_apply_7886:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7889
do_compose_7885:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7889
do_concat_7887:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7889
id_morphism_7888:
    b apply_end_7889
apply_end_7889:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7893
    tst x9, #1
    b.eq do_concat_7892
    tst x0, #1
    b.ne do_compose_7890
do_apply_7891:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7894
do_compose_7890:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7894
do_concat_7892:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7894
id_morphism_7893:
    b apply_end_7894
apply_end_7894:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7898
    tst x9, #1
    b.eq do_concat_7897
    tst x0, #1
    b.ne do_compose_7895
do_apply_7896:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7899
do_compose_7895:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7899
do_concat_7897:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7899
id_morphism_7898:
    b apply_end_7899
apply_end_7899:
blk_end_7502:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7500_7501:
    // Closure for func_7500
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_7500
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7498_7499:
    // Closure for func_7498
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_7498
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7496_7497:
    // Closure for func_7496
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7496
    ldr x0, [sp], #16
    bl _cons
    b cond_end_7490
cond_false_7489:
    adr x0, sign_id
cond_end_7490:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_block
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7905
    tst x9, #1
    b.eq do_concat_7904
    tst x0, #1
    b.ne do_compose_7902
do_apply_7903:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7906
do_compose_7902:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7906
do_concat_7904:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7906
id_morphism_7905:
    b apply_end_7906
apply_end_7906:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7900
    b after_func_7907_7908
func_7907:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7909_7910
func_7909:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_7912_7913
func_7912:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7912_7913:
    // Closure for func_7912
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7912
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, stmts
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_7917
    adr x0, sign_id
    b cmp_end_7918
cmp_true_7917:
cmp_end_7918:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7915
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7922
    tst x9, #1
    b.eq do_concat_7921
    tst x0, #1
    b.ne do_compose_7919
do_apply_7920:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7923
do_compose_7919:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7923
do_concat_7921:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7923
id_morphism_7922:
    b apply_end_7923
apply_end_7923:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7927
    tst x9, #1
    b.eq do_concat_7926
    tst x0, #1
    b.ne do_compose_7924
do_apply_7925:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7928
do_compose_7924:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7928
do_concat_7926:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7928
id_morphism_7927:
    b apply_end_7928
apply_end_7928:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7932
    tst x9, #1
    b.eq do_concat_7931
    tst x0, #1
    b.ne do_compose_7929
do_apply_7930:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7933
do_compose_7929:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7933
do_concat_7931:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7933
id_morphism_7932:
    b apply_end_7933
apply_end_7933:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7937
    tst x9, #1
    b.eq do_concat_7936
    tst x0, #1
    b.ne do_compose_7934
do_apply_7935:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7938
do_compose_7934:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7938
do_concat_7936:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7938
id_morphism_7937:
    b apply_end_7938
apply_end_7938:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7942
    tst x9, #1
    b.eq do_concat_7941
    tst x0, #1
    b.ne do_compose_7939
do_apply_7940:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7943
do_compose_7939:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7943
do_concat_7941:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7943
id_morphism_7942:
    b apply_end_7943
apply_end_7943:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7947
    tst x9, #1
    b.eq do_concat_7946
    tst x0, #1
    b.ne do_compose_7944
do_apply_7945:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7948
do_compose_7944:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7948
do_concat_7946:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7948
id_morphism_7947:
    b apply_end_7948
apply_end_7948:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7952
    tst x9, #1
    b.eq do_concat_7951
    tst x0, #1
    b.ne do_compose_7949
do_apply_7950:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7953
do_compose_7949:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7953
do_concat_7951:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7953
id_morphism_7952:
    b apply_end_7953
apply_end_7953:
    b cond_end_7916
cond_false_7915:
    adr x0, sign_id
cond_end_7916:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7914
    b after_func_7954_7955
func_7954:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7954_7955:
    // Closure for func_7954
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7954
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7957_7958
func_7957:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7957_7958:
    // Closure for func_7957
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7957
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_7960_7961
func_7960:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_7962_7963
func_7962:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7962_7963:
    // Closure for func_7962
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7962
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7960_7961:
    // Closure for func_7960
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7960
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7968
    tst x9, #1
    b.eq do_concat_7967
    tst x0, #1
    b.ne do_compose_7965
do_apply_7966:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7969
do_compose_7965:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7969
do_concat_7967:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7969
id_morphism_7968:
    b apply_end_7969
apply_end_7969:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7973
    tst x9, #1
    b.eq do_concat_7972
    tst x0, #1
    b.ne do_compose_7970
do_apply_7971:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7974
do_compose_7970:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7974
do_concat_7972:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7974
id_morphism_7973:
    b apply_end_7974
apply_end_7974:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7978
    tst x9, #1
    b.eq do_concat_7977
    tst x0, #1
    b.ne do_compose_7975
do_apply_7976:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7979
do_compose_7975:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7979
do_concat_7977:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7979
id_morphism_7978:
    b apply_end_7979
apply_end_7979:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7983
    tst x9, #1
    b.eq do_concat_7982
    tst x0, #1
    b.ne do_compose_7980
do_apply_7981:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7984
do_compose_7980:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7984
do_concat_7982:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7984
id_morphism_7983:
    b apply_end_7984
apply_end_7984:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7988
    tst x9, #1
    b.eq do_concat_7987
    tst x0, #1
    b.ne do_compose_7985
do_apply_7986:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7989
do_compose_7985:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7989
do_concat_7987:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7989
id_morphism_7988:
    b apply_end_7989
apply_end_7989:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7993
    tst x9, #1
    b.eq do_concat_7992
    tst x0, #1
    b.ne do_compose_7990
do_apply_7991:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7994
do_compose_7990:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7994
do_concat_7992:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7994
id_morphism_7993:
    b apply_end_7994
apply_end_7994:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7964
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_7998
    tst x9, #1
    b.eq do_concat_7997
    tst x0, #1
    b.ne do_compose_7995
do_apply_7996:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7999
do_compose_7995:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_7999
do_concat_7997:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_7999
id_morphism_7998:
    b apply_end_7999
apply_end_7999:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8003
    tst x9, #1
    b.eq do_concat_8002
    tst x0, #1
    b.ne do_compose_8000
do_apply_8001:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8004
do_compose_8000:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8004
do_concat_8002:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8004
id_morphism_8003:
    b apply_end_8004
apply_end_8004:
blk_end_7964:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8008
    tst x9, #1
    b.eq do_concat_8007
    tst x0, #1
    b.ne do_compose_8005
do_apply_8006:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8009
do_compose_8005:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8009
do_concat_8007:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8009
id_morphism_8008:
    b apply_end_8009
apply_end_8009:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8013
    tst x9, #1
    b.eq do_concat_8012
    tst x0, #1
    b.ne do_compose_8010
do_apply_8011:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8014
do_compose_8010:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8014
do_concat_8012:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8014
id_morphism_8013:
    b apply_end_8014
apply_end_8014:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7959
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8018
    tst x9, #1
    b.eq do_concat_8017
    tst x0, #1
    b.ne do_compose_8015
do_apply_8016:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8019
do_compose_8015:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8019
do_concat_8017:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8019
id_morphism_8018:
    b apply_end_8019
apply_end_8019:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8023
    tst x9, #1
    b.eq do_concat_8022
    tst x0, #1
    b.ne do_compose_8020
do_apply_8021:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8024
do_compose_8020:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8024
do_concat_8022:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8024
id_morphism_8023:
    b apply_end_8024
apply_end_8024:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8028
    tst x9, #1
    b.eq do_concat_8027
    tst x0, #1
    b.ne do_compose_8025
do_apply_8026:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8029
do_compose_8025:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8029
do_concat_8027:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8029
id_morphism_8028:
    b apply_end_8029
apply_end_8029:
blk_end_7959:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8033
    tst x9, #1
    b.eq do_concat_8032
    tst x0, #1
    b.ne do_compose_8030
do_apply_8031:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8034
do_compose_8030:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8034
do_concat_8032:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8034
id_morphism_8033:
    b apply_end_8034
apply_end_8034:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7956
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    adr x0, stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8038
    tst x9, #1
    b.eq do_concat_8037
    tst x0, #1
    b.ne do_compose_8035
do_apply_8036:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8039
do_compose_8035:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8039
do_concat_8037:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8039
id_morphism_8038:
    b apply_end_8039
apply_end_8039:
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8043
    tst x9, #1
    b.eq do_concat_8042
    tst x0, #1
    b.ne do_compose_8040
do_apply_8041:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8044
do_compose_8040:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8044
do_concat_8042:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8044
id_morphism_8043:
    b apply_end_8044
apply_end_8044:
    str x0, [sp, #-16]!
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    adr x0, res_lbl_end
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8048
    tst x9, #1
    b.eq do_concat_8047
    tst x0, #1
    b.ne do_compose_8045
do_apply_8046:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8049
do_compose_8045:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8049
do_concat_8047:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8049
id_morphism_8048:
    b apply_end_8049
apply_end_8049:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8053
    tst x9, #1
    b.eq do_concat_8052
    tst x0, #1
    b.ne do_compose_8050
do_apply_8051:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8054
do_compose_8050:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8054
do_concat_8052:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8054
id_morphism_8053:
    b apply_end_8054
apply_end_8054:
blk_end_7956:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8058
    tst x9, #1
    b.eq do_concat_8057
    tst x0, #1
    b.ne do_compose_8055
do_apply_8056:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8059
do_compose_8055:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8059
do_concat_8057:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8059
id_morphism_8058:
    b apply_end_8059
apply_end_8059:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7914
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8063
    tst x9, #1
    b.eq do_concat_8062
    tst x0, #1
    b.ne do_compose_8060
do_apply_8061:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8064
do_compose_8060:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8064
do_concat_8062:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8064
id_morphism_8063:
    b apply_end_8064
apply_end_8064:
    str x0, [sp, #-16]!
    adr x0, str_81
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8068
    tst x9, #1
    b.eq do_concat_8067
    tst x0, #1
    b.ne do_compose_8065
do_apply_8066:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8069
do_compose_8065:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8069
do_concat_8067:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8069
id_morphism_8068:
    b apply_end_8069
apply_end_8069:
blk_end_7914:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8073
    tst x9, #1
    b.eq do_concat_8072
    tst x0, #1
    b.ne do_compose_8070
do_apply_8071:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8074
do_compose_8070:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8074
do_concat_8072:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8074
id_morphism_8073:
    b apply_end_8074
apply_end_8074:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_7911
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8078
    tst x9, #1
    b.eq do_concat_8077
    tst x0, #1
    b.ne do_compose_8075
do_apply_8076:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8079
do_compose_8075:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8079
do_concat_8077:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8079
id_morphism_8078:
    b apply_end_8079
apply_end_8079:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8083
    tst x9, #1
    b.eq do_concat_8082
    tst x0, #1
    b.ne do_compose_8080
do_apply_8081:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8084
do_compose_8080:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8084
do_concat_8082:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8084
id_morphism_8083:
    b apply_end_8084
apply_end_8084:
blk_end_7911:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7909_7910:
    // Closure for func_7909
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_7909
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7907_7908:
    // Closure for func_7907
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7907
    ldr x0, [sp], #16
    bl _cons
    b cond_end_7901
cond_false_7900:
    adr x0, sign_id
cond_end_7901:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8090
    tst x9, #1
    b.eq do_concat_8089
    tst x0, #1
    b.ne do_compose_8087
do_apply_8088:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8091
do_compose_8087:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8091
do_concat_8089:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8091
id_morphism_8090:
    b apply_end_8091
apply_end_8091:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8085
    b after_func_8092_8093
func_8092:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_8094_8095
func_8094:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_8096_8097
func_8096:
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
    b after_func_8099_8100
func_8099:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8099_8100:
    // Closure for func_8099
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8099
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_8102_8103
func_8102:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8102_8103:
    // Closure for func_8102
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8102
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tail_stmts
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_8107
    adr x0, sign_id
    b cmp_end_8108
cmp_true_8107:
cmp_end_8108:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8105
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_82
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8109
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, head_stmt
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8113
    tst x9, #1
    b.eq do_concat_8112
    tst x0, #1
    b.ne do_compose_8110
do_apply_8111:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8114
do_compose_8110:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8114
do_concat_8112:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8114
id_morphism_8113:
    b apply_end_8114
apply_end_8114:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8118
    tst x9, #1
    b.eq do_concat_8117
    tst x0, #1
    b.ne do_compose_8115
do_apply_8116:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8119
do_compose_8115:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8119
do_concat_8117:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8119
id_morphism_8118:
    b apply_end_8119
apply_end_8119:
blk_end_8109:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8123
    tst x9, #1
    b.eq do_concat_8122
    tst x0, #1
    b.ne do_compose_8120
do_apply_8121:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8124
do_compose_8120:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8124
do_concat_8122:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8124
id_morphism_8123:
    b apply_end_8124
apply_end_8124:
    b cond_end_8106
cond_false_8105:
    adr x0, sign_id
cond_end_8106:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8104
    adr x0, str_83
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8104
    b after_func_8125_8126
func_8125:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8125_8126:
    // Closure for func_8125
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8125
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_8128_8129
func_8128:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_8130_8131
func_8130:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8130_8131:
    // Closure for func_8130
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8130
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8128_8129:
    // Closure for func_8128
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8128
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_8133_8134
func_8133:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8133_8134:
    // Closure for func_8133
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8133
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_8136_8137
func_8136:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_8138_8139
func_8138:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8138_8139:
    // Closure for func_8138
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8138
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8136_8137:
    // Closure for func_8136
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8136
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_head
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8144
    tst x9, #1
    b.eq do_concat_8143
    tst x0, #1
    b.ne do_compose_8141
do_apply_8142:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8145
do_compose_8141:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8145
do_concat_8143:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8145
id_morphism_8144:
    b apply_end_8145
apply_end_8145:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_84
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8149
    tst x9, #1
    b.eq do_concat_8148
    tst x0, #1
    b.ne do_compose_8146
do_apply_8147:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8150
do_compose_8146:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8150
do_concat_8148:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8150
id_morphism_8149:
    b apply_end_8150
apply_end_8150:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_85
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8154
    tst x9, #1
    b.eq do_concat_8153
    tst x0, #1
    b.ne do_compose_8151
do_apply_8152:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8155
do_compose_8151:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8155
do_concat_8153:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8155
id_morphism_8154:
    b apply_end_8155
apply_end_8155:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_86
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8159
    tst x9, #1
    b.eq do_concat_8158
    tst x0, #1
    b.ne do_compose_8156
do_apply_8157:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8160
do_compose_8156:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8160
do_concat_8158:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8160
id_morphism_8159:
    b apply_end_8160
apply_end_8160:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8164
    tst x9, #1
    b.eq do_concat_8163
    tst x0, #1
    b.ne do_compose_8161
do_apply_8162:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8165
do_compose_8161:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8165
do_concat_8163:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8165
id_morphism_8164:
    b apply_end_8165
apply_end_8165:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8169
    tst x9, #1
    b.eq do_concat_8168
    tst x0, #1
    b.ne do_compose_8166
do_apply_8167:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8170
do_compose_8166:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8170
do_concat_8168:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8170
id_morphism_8169:
    b apply_end_8170
apply_end_8170:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8174
    tst x9, #1
    b.eq do_concat_8173
    tst x0, #1
    b.ne do_compose_8171
do_apply_8172:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8175
do_compose_8171:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8175
do_concat_8173:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8175
id_morphism_8174:
    b apply_end_8175
apply_end_8175:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8179
    tst x9, #1
    b.eq do_concat_8178
    tst x0, #1
    b.ne do_compose_8176
do_apply_8177:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8180
do_compose_8176:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8180
do_concat_8178:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8180
id_morphism_8179:
    b apply_end_8180
apply_end_8180:
    str x0, [sp, #-16]!
    adr x0, asm_tail
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8184
    tst x9, #1
    b.eq do_concat_8183
    tst x0, #1
    b.ne do_compose_8181
do_apply_8182:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8185
do_compose_8181:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8185
do_concat_8183:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8185
id_morphism_8184:
    b apply_end_8185
apply_end_8185:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8189
    tst x9, #1
    b.eq do_concat_8188
    tst x0, #1
    b.ne do_compose_8186
do_apply_8187:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8190
do_compose_8186:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8190
do_concat_8188:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8190
id_morphism_8189:
    b apply_end_8190
apply_end_8190:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8194
    tst x9, #1
    b.eq do_concat_8193
    tst x0, #1
    b.ne do_compose_8191
do_apply_8192:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8195
do_compose_8191:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8195
do_concat_8193:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8195
id_morphism_8194:
    b apply_end_8195
apply_end_8195:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8199
    tst x9, #1
    b.eq do_concat_8198
    tst x0, #1
    b.ne do_compose_8196
do_apply_8197:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8200
do_compose_8196:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8200
do_concat_8198:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8200
id_morphism_8199:
    b apply_end_8200
apply_end_8200:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8140
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_tail
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8204
    tst x9, #1
    b.eq do_concat_8203
    tst x0, #1
    b.ne do_compose_8201
do_apply_8202:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8205
do_compose_8201:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8205
do_concat_8203:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8205
id_morphism_8204:
    b apply_end_8205
apply_end_8205:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8209
    tst x9, #1
    b.eq do_concat_8208
    tst x0, #1
    b.ne do_compose_8206
do_apply_8207:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8210
do_compose_8206:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8210
do_concat_8208:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8210
id_morphism_8209:
    b apply_end_8210
apply_end_8210:
blk_end_8140:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8214
    tst x9, #1
    b.eq do_concat_8213
    tst x0, #1
    b.ne do_compose_8211
do_apply_8212:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8215
do_compose_8211:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8215
do_concat_8213:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8215
id_morphism_8214:
    b apply_end_8215
apply_end_8215:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8219
    tst x9, #1
    b.eq do_concat_8218
    tst x0, #1
    b.ne do_compose_8216
do_apply_8217:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8220
do_compose_8216:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8220
do_concat_8218:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8220
id_morphism_8219:
    b apply_end_8220
apply_end_8220:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8135
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_tail
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8224
    tst x9, #1
    b.eq do_concat_8223
    tst x0, #1
    b.ne do_compose_8221
do_apply_8222:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8225
do_compose_8221:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8225
do_concat_8223:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8225
id_morphism_8224:
    b apply_end_8225
apply_end_8225:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_tail
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8229
    tst x9, #1
    b.eq do_concat_8228
    tst x0, #1
    b.ne do_compose_8226
do_apply_8227:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8230
do_compose_8226:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8230
do_concat_8228:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8230
id_morphism_8229:
    b apply_end_8230
apply_end_8230:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8234
    tst x9, #1
    b.eq do_concat_8233
    tst x0, #1
    b.ne do_compose_8231
do_apply_8232:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8235
do_compose_8231:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8235
do_concat_8233:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8235
id_morphism_8234:
    b apply_end_8235
apply_end_8235:
blk_end_8135:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8239
    tst x9, #1
    b.eq do_concat_8238
    tst x0, #1
    b.ne do_compose_8236
do_apply_8237:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8240
do_compose_8236:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8240
do_concat_8238:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8240
id_morphism_8239:
    b apply_end_8240
apply_end_8240:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8132
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    adr x0, tail_stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8244
    tst x9, #1
    b.eq do_concat_8243
    tst x0, #1
    b.ne do_compose_8241
do_apply_8242:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8245
do_compose_8241:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8245
do_concat_8243:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8245
id_morphism_8244:
    b apply_end_8245
apply_end_8245:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8249
    tst x9, #1
    b.eq do_concat_8248
    tst x0, #1
    b.ne do_compose_8246
do_apply_8247:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8250
do_compose_8246:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8250
do_concat_8248:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8250
id_morphism_8249:
    b apply_end_8250
apply_end_8250:
    str x0, [sp, #-16]!
    adr x0, ctx_head
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8254
    tst x9, #1
    b.eq do_concat_8253
    tst x0, #1
    b.ne do_compose_8251
do_apply_8252:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8255
do_compose_8251:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8255
do_concat_8253:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8255
id_morphism_8254:
    b apply_end_8255
apply_end_8255:
blk_end_8132:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8259
    tst x9, #1
    b.eq do_concat_8258
    tst x0, #1
    b.ne do_compose_8256
do_apply_8257:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8260
do_compose_8256:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8260
do_concat_8258:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8260
id_morphism_8259:
    b apply_end_8260
apply_end_8260:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8127
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_head
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8264
    tst x9, #1
    b.eq do_concat_8263
    tst x0, #1
    b.ne do_compose_8261
do_apply_8262:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8265
do_compose_8261:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8265
do_concat_8263:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8265
id_morphism_8264:
    b apply_end_8265
apply_end_8265:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_head
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8269
    tst x9, #1
    b.eq do_concat_8268
    tst x0, #1
    b.ne do_compose_8266
do_apply_8267:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8270
do_compose_8266:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8270
do_concat_8268:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8270
id_morphism_8269:
    b apply_end_8270
apply_end_8270:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8274
    tst x9, #1
    b.eq do_concat_8273
    tst x0, #1
    b.ne do_compose_8271
do_apply_8272:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8275
do_compose_8271:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8275
do_concat_8273:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8275
id_morphism_8274:
    b apply_end_8275
apply_end_8275:
blk_end_8127:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8279
    tst x9, #1
    b.eq do_concat_8278
    tst x0, #1
    b.ne do_compose_8276
do_apply_8277:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8280
do_compose_8276:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8280
do_concat_8278:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8280
id_morphism_8279:
    b apply_end_8280
apply_end_8280:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8104
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, head_stmt
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8284
    tst x9, #1
    b.eq do_concat_8283
    tst x0, #1
    b.ne do_compose_8281
do_apply_8282:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8285
do_compose_8281:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8285
do_concat_8283:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8285
id_morphism_8284:
    b apply_end_8285
apply_end_8285:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8289
    tst x9, #1
    b.eq do_concat_8288
    tst x0, #1
    b.ne do_compose_8286
do_apply_8287:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8290
do_compose_8286:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8290
do_concat_8288:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8290
id_morphism_8289:
    b apply_end_8290
apply_end_8290:
blk_end_8104:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8294
    tst x9, #1
    b.eq do_concat_8293
    tst x0, #1
    b.ne do_compose_8291
do_apply_8292:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8295
do_compose_8291:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8295
do_concat_8293:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8295
id_morphism_8294:
    b apply_end_8295
apply_end_8295:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8101
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8299
    tst x9, #1
    b.eq do_concat_8298
    tst x0, #1
    b.ne do_compose_8296
do_apply_8297:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8300
do_compose_8296:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8300
do_concat_8298:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8300
id_morphism_8299:
    b apply_end_8300
apply_end_8300:
blk_end_8101:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8304
    tst x9, #1
    b.eq do_concat_8303
    tst x0, #1
    b.ne do_compose_8301
do_apply_8302:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8305
do_compose_8301:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8305
do_concat_8303:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8305
id_morphism_8304:
    b apply_end_8305
apply_end_8305:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8098
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8309
    tst x9, #1
    b.eq do_concat_8308
    tst x0, #1
    b.ne do_compose_8306
do_apply_8307:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8310
do_compose_8306:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8310
do_concat_8308:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8310
id_morphism_8309:
    b apply_end_8310
apply_end_8310:
blk_end_8098:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8096_8097:
    // Closure for func_8096
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_8096
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8094_8095:
    // Closure for func_8094
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_8094
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8092_8093:
    // Closure for func_8092
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8092
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8086
cond_false_8085:
    adr x0, sign_id
cond_end_8086:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat_lists
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8316
    tst x9, #1
    b.eq do_concat_8315
    tst x0, #1
    b.ne do_compose_8313
do_apply_8314:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8317
do_compose_8313:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8317
do_concat_8315:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8317
id_morphism_8316:
    b apply_end_8317
apply_end_8317:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8311
    b after_func_8318_8319
func_8318:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_8320_8321
func_8320:
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
    b.eq cmp_true_8325
    adr x0, sign_id
    b cmp_end_8326
cmp_true_8325:
cmp_end_8326:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8323
    ldr x0, [x29, #-32]
    b cond_end_8324
cond_false_8323:
    adr x0, sign_id
cond_end_8324:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8322
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8330
    tst x9, #1
    b.eq do_concat_8329
    tst x0, #1
    b.ne do_compose_8327
do_apply_8328:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8331
do_compose_8327:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8331
do_concat_8329:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8331
id_morphism_8330:
    b apply_end_8331
apply_end_8331:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8335
    tst x9, #1
    b.eq do_concat_8334
    tst x0, #1
    b.ne do_compose_8332
do_apply_8333:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8336
do_compose_8332:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8336
do_concat_8334:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8336
id_morphism_8335:
    b apply_end_8336
apply_end_8336:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8340
    tst x9, #1
    b.eq do_concat_8339
    tst x0, #1
    b.ne do_compose_8337
do_apply_8338:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8341
do_compose_8337:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8341
do_concat_8339:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8341
id_morphism_8340:
    b apply_end_8341
apply_end_8341:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8345
    tst x9, #1
    b.eq do_concat_8344
    tst x0, #1
    b.ne do_compose_8342
do_apply_8343:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8346
do_compose_8342:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8346
do_concat_8344:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8346
id_morphism_8345:
    b apply_end_8346
apply_end_8346:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8350
    tst x9, #1
    b.eq do_concat_8349
    tst x0, #1
    b.ne do_compose_8347
do_apply_8348:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8351
do_compose_8347:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8351
do_concat_8349:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8351
id_morphism_8350:
    b apply_end_8351
apply_end_8351:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8355
    tst x9, #1
    b.eq do_concat_8354
    tst x0, #1
    b.ne do_compose_8352
do_apply_8353:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8356
do_compose_8352:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8356
do_concat_8354:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8356
id_morphism_8355:
    b apply_end_8356
apply_end_8356:
blk_end_8322:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8320_8321:
    // Closure for func_8320
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_8320
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8318_8319:
    // Closure for func_8318
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8318
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8312
cond_false_8311:
    adr x0, sign_id
cond_end_8312:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8362
    tst x9, #1
    b.eq do_concat_8361
    tst x0, #1
    b.ne do_compose_8359
do_apply_8360:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8363
do_compose_8359:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8363
do_concat_8361:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8363
id_morphism_8362:
    b apply_end_8363
apply_end_8363:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8357
    b after_func_8364_8365
func_8364:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8369
    tst x9, #1
    b.eq do_concat_8368
    tst x0, #1
    b.ne do_compose_8366
do_apply_8367:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8370
do_compose_8366:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8370
do_concat_8368:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8370
id_morphism_8369:
    b apply_end_8370
apply_end_8370:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8364_8365:
    // Closure for func_8364
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8364
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8358
cond_false_8357:
    adr x0, sign_id
cond_end_8358:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_from_res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8376
    tst x9, #1
    b.eq do_concat_8375
    tst x0, #1
    b.ne do_compose_8373
do_apply_8374:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8377
do_compose_8373:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8377
do_concat_8375:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8377
id_morphism_8376:
    b apply_end_8377
apply_end_8377:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8371
    b after_func_8378_8379
func_8378:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8383
    tst x9, #1
    b.eq do_concat_8382
    tst x0, #1
    b.ne do_compose_8380
do_apply_8381:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8384
do_compose_8380:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8384
do_concat_8382:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8384
id_morphism_8383:
    b apply_end_8384
apply_end_8384:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8388
    tst x9, #1
    b.eq do_concat_8387
    tst x0, #1
    b.ne do_compose_8385
do_apply_8386:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8389
do_compose_8385:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8389
do_concat_8387:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8389
id_morphism_8388:
    b apply_end_8389
apply_end_8389:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8378_8379:
    // Closure for func_8378
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8378
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8372
cond_false_8371:
    adr x0, sign_id
cond_end_8372:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, res_lbl_end
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8395
    tst x9, #1
    b.eq do_concat_8394
    tst x0, #1
    b.ne do_compose_8392
do_apply_8393:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8396
do_compose_8392:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8396
do_concat_8394:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8396
id_morphism_8395:
    b apply_end_8396
apply_end_8396:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8390
    b after_func_8397_8398
func_8397:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str_87
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8402
    tst x9, #1
    b.eq do_concat_8401
    tst x0, #1
    b.ne do_compose_8399
do_apply_8400:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8403
do_compose_8399:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8403
do_concat_8401:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8403
id_morphism_8402:
    b apply_end_8403
apply_end_8403:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8397_8398:
    // Closure for func_8397
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8397
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8391
cond_false_8390:
    adr x0, sign_id
cond_end_8391:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_from_lbl
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8409
    tst x9, #1
    b.eq do_concat_8408
    tst x0, #1
    b.ne do_compose_8406
do_apply_8407:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8410
do_compose_8406:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8410
do_concat_8408:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8410
id_morphism_8409:
    b apply_end_8410
apply_end_8410:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8404
    b after_func_8411_8412
func_8411:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8416
    tst x9, #1
    b.eq do_concat_8415
    tst x0, #1
    b.ne do_compose_8413
do_apply_8414:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8417
do_compose_8413:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8417
do_concat_8415:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8417
id_morphism_8416:
    b apply_end_8417
apply_end_8417:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8421
    tst x9, #1
    b.eq do_concat_8420
    tst x0, #1
    b.ne do_compose_8418
do_apply_8419:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8422
do_compose_8418:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8422
do_concat_8420:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8422
id_morphism_8421:
    b apply_end_8422
apply_end_8422:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8411_8412:
    // Closure for func_8411
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8411
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8405
cond_false_8404:
    adr x0, sign_id
cond_end_8405:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, main
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8428
    tst x9, #1
    b.eq do_concat_8427
    tst x0, #1
    b.ne do_compose_8425
do_apply_8426:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8429
do_compose_8425:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8429
do_concat_8427:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8429
id_morphism_8428:
    b apply_end_8429
apply_end_8429:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8423
    b after_func_8430_8431
func_8430:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _test
    str x0, [sp, #-16]!
    adr x0, str_88
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8436
    tst x9, #1
    b.eq do_concat_8435
    tst x0, #1
    b.ne do_compose_8433
do_apply_8434:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8437
do_compose_8433:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8437
do_concat_8435:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8437
id_morphism_8436:
    b apply_end_8437
apply_end_8437:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8432
    adr x0, _test
    str x0, [sp, #-16]!
    adr x0, str_89
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8441
    tst x9, #1
    b.eq do_concat_8440
    tst x0, #1
    b.ne do_compose_8438
do_apply_8439:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8442
do_compose_8438:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8442
do_concat_8440:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8442
id_morphism_8441:
    b apply_end_8442
apply_end_8442:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8432
    adr x0, _test
    str x0, [sp, #-16]!
    adr x0, str_90
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8446
    tst x9, #1
    b.eq do_concat_8445
    tst x0, #1
    b.ne do_compose_8443
do_apply_8444:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8447
do_compose_8443:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8447
do_concat_8445:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8447
id_morphism_8446:
    b apply_end_8447
apply_end_8447:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8432
    adr x0, _test
    str x0, [sp, #-16]!
    adr x0, str_91
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8451
    tst x9, #1
    b.eq do_concat_8450
    tst x0, #1
    b.ne do_compose_8448
do_apply_8449:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8452
do_compose_8448:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8452
do_concat_8450:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8452
id_morphism_8451:
    b apply_end_8452
apply_end_8452:
blk_end_8432:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8430_8431:
    // Closure for func_8430
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8430
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8424
cond_false_8423:
    adr x0, sign_id
cond_end_8424:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _test
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8458
    tst x9, #1
    b.eq do_concat_8457
    tst x0, #1
    b.ne do_compose_8455
do_apply_8456:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8459
do_compose_8455:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8459
do_concat_8457:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8459
id_morphism_8458:
    b apply_end_8459
apply_end_8459:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_8453
    b after_func_8460_8461
func_8460:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_92
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8466
    tst x9, #1
    b.eq do_concat_8465
    tst x0, #1
    b.ne do_compose_8463
do_apply_8464:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8467
do_compose_8463:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8467
do_concat_8465:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8467
id_morphism_8466:
    b apply_end_8467
apply_end_8467:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8462
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8471
    tst x9, #1
    b.eq do_concat_8470
    tst x0, #1
    b.ne do_compose_8468
do_apply_8469:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8472
do_compose_8468:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8472
do_concat_8470:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8472
id_morphism_8471:
    b apply_end_8472
apply_end_8472:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8462
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_93
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8476
    tst x9, #1
    b.eq do_concat_8475
    tst x0, #1
    b.ne do_compose_8473
do_apply_8474:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8477
do_compose_8473:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8477
do_concat_8475:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8477
id_morphism_8476:
    b apply_end_8477
apply_end_8477:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8462
    adr x0, tokenize
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8481
    tst x9, #1
    b.eq do_concat_8480
    tst x0, #1
    b.ne do_compose_8478
do_apply_8479:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8482
do_compose_8478:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8482
do_concat_8480:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8482
id_morphism_8481:
    b apply_end_8482
apply_end_8482:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8462
    b after_func_8483_8484
func_8483:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8483_8484:
    // Closure for func_8483
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8483
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_8486_8487
func_8486:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8486_8487:
    // Closure for func_8486
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8486
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_8489_8490
func_8489:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8489_8490:
    // Closure for func_8489
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8489
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, res_compile
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8495
    tst x9, #1
    b.eq do_concat_8494
    tst x0, #1
    b.ne do_compose_8492
do_apply_8493:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8496
do_compose_8492:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8496
do_concat_8494:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8496
id_morphism_8495:
    b apply_end_8496
apply_end_8496:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8491
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8500
    tst x9, #1
    b.eq do_concat_8499
    tst x0, #1
    b.ne do_compose_8497
do_apply_8498:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8501
do_compose_8497:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8501
do_concat_8499:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8501
id_morphism_8500:
    b apply_end_8501
apply_end_8501:
blk_end_8491:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8505
    tst x9, #1
    b.eq do_concat_8504
    tst x0, #1
    b.ne do_compose_8502
do_apply_8503:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8506
do_compose_8502:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8506
do_concat_8504:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8506
id_morphism_8505:
    b apply_end_8506
apply_end_8506:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8488
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, ast
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8510
    tst x9, #1
    b.eq do_concat_8509
    tst x0, #1
    b.ne do_compose_8507
do_apply_8508:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8511
do_compose_8507:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8511
do_concat_8509:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8511
id_morphism_8510:
    b apply_end_8511
apply_end_8511:
blk_end_8488:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8515
    tst x9, #1
    b.eq do_concat_8514
    tst x0, #1
    b.ne do_compose_8512
do_apply_8513:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8516
do_compose_8512:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8516
do_concat_8514:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8516
id_morphism_8515:
    b apply_end_8516
apply_end_8516:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8485
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_parse
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8520
    tst x9, #1
    b.eq do_concat_8519
    tst x0, #1
    b.ne do_compose_8517
do_apply_8518:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8521
do_compose_8517:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8521
do_concat_8519:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8521
id_morphism_8520:
    b apply_end_8521
apply_end_8521:
blk_end_8485:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8525
    tst x9, #1
    b.eq do_concat_8524
    tst x0, #1
    b.ne do_compose_8522
do_apply_8523:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8526
do_compose_8522:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8526
do_concat_8524:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8526
id_morphism_8525:
    b apply_end_8526
apply_end_8526:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8462
    adr x0, parse_program
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8530
    tst x9, #1
    b.eq do_concat_8529
    tst x0, #1
    b.ne do_compose_8527
do_apply_8528:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8531
do_compose_8527:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8531
do_concat_8529:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8531
id_morphism_8530:
    b apply_end_8531
apply_end_8531:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_8462
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_8535
    tst x9, #1
    b.eq do_concat_8534
    tst x0, #1
    b.ne do_compose_8532
do_apply_8533:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_8536
do_compose_8532:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_8536
do_concat_8534:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_8536
id_morphism_8535:
    b apply_end_8536
apply_end_8536:
blk_end_8462:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_8460_8461:
    // Closure for func_8460
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_8460
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8454
cond_false_8453:
    adr x0, sign_id
cond_end_8454:
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
tok_unit: .quad 0
Philosophy: .quad 0
ast_unit: .quad 0
ast_num: .quad 0
ast_id: .quad 0
ast_str: .quad 0
ast_op: .quad 0
ast_def: .quad 0
ast_apply: .quad 0
ast_block: .quad 0
ast_infix: .quad 0
ast_prefix: .quad 0
ast_postfix: .quad 0
ast_lambda: .quad 0
ast_char: .quad 0


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
    .asciz "Default: Punctuation"
str_1:
    .asciz "ID can contain alpha or digit after first char"
str_2:
    .asciz "Skip opening backtick"
str_3:
    .asciz "End of string"
str_4:
    .asciz "=="
str_5:
    .asciz "<="
str_6:
    .asciz ">="
str_7:
    .asciz "!="
str_8:
    .asciz "Parse Expression"
str_9:
    .asciz "TODO: Block logic, Section logic"
str_10:
    .asciz "Temporary: Treat block same as program for now"
str_11:
    .asciz "Check for Apply (Implicit)"
str_12:
    .asciz "Apply: lhs next_expr"
str_13:
    .asciz "6 is Apply Precedence"
str_14:
    .asciz "Prefix Ops"
str_15:
    .asciz "Prefix Prec"
str_16:
    .asciz "Standalone Operator (for Sections)"
str_17:
    .asciz "LBRACKET -> Block (Potential Section)"
str_18:
    .asciz "LPAREN -> Group (No Section)"
str_19:
    .asciz "Expect RPAREN (val 41)"
str_20:
    .asciz "Consume RPAREN"
str_21:
    .asciz "Check if single expr for paren group"
str_22:
    .asciz "Default Unknown"
str_23:
    .asciz "Unknown"
str_24:
    .asciz "Expect RBRACKET (93)"
str_25:
    .asciz "Consume RBRACKET"
str_26:
    .asciz "[op] -> (p1 p2 ? p1 op p2)"
str_27:
    .asciz "e1=(type val). val=op"
str_28:
    .asciz "[op expr] -> (p1 ? p1 op expr)"
str_29:
    .asciz "[expr op] -> (p1 ? expr op p1)"
str_30:
    .asciz "$2"
str_31:
    .asciz "$1"
str_32:
    .asciz "    adr x0, "
str_33:
    .asciz "\n"
str_34:
    .asciz "    str x0, [sp, #-16]!\n"
str_35:
    .asciz "    ldr x1, [sp], #16\n"
str_36:
    .asciz "    ldr x2, [x1]\n"
str_37:
    .asciz "Code"
str_38:
    .asciz "    ldr x9, [x1, #8]\n"
str_39:
    .asciz "Env"
str_40:
    .asciz "    blr x2\n"
str_41:
    .asciz "TODO: Check existence, return label. For now just add."
str_42:
    .asciz "str_"
str_43:
    .asciz ""
str_44:
    .asciz "Default"
str_45:
    .asciz "    // Unknown Node Type\n"
str_46:
    .asciz "    mov x0, #"
str_47:
    .asciz "    adr x0, sign_id\n"
str_48:
    .asciz "    add x0, x0, x1\n"
str_49:
    .asciz "    sub x0, x0, x1\n"
str_50:
    .asciz "    mul x0, x0, x1\n"
str_51:
    .asciz "    sdiv x0, x0, x1\n"
str_52:
    .asciz "eq"
str_53:
    .asciz "ne"
str_54:
    .asciz "lt"
str_55:
    .asciz "gt"
str_56:
    .asciz "le"
str_57:
    .asciz "ge"
str_58:
    .asciz "    // Unknown Infix: "
str_59:
    .asciz "Expect lhs to be ID"
str_60:
    .asciz "    b "
str_61:
    .asciz ":\n"
str_62:
    .asciz "    stp x29, x30, [sp, #-16]!\n"
str_63:
    .asciz "    mov x29, sp\n"
str_64:
    .asciz "    str x0, [sp, #-16]!\n\ Push Arg"
str_65:
    .asciz "    mov sp, x29\n"
str_66:
    .asciz "    ldp x29, x30, [sp], #16\n"
str_67:
    .asciz "    ret\n"
str_68:
    .asciz "    adr x1, "
str_69:
    .asciz "    ldr x0, [sp], #16\n"
str_70:
    .asciz "    bl _cons\n"
str_71:
    .asciz "Assume single param ID"
str_72:
    .asciz "after_func"
str_73:
    .asciz "func"
str_74:
    .asciz "    mov x1, x0\n"
str_75:
    .asciz "    cmp x0, x1\n"
str_76:
    .asciz "    b."
str_77:
    .asciz "    mov x0, #0\n"
str_78:
    .asciz "True Case: Return LHS (x0) already in x0 from ldr"
str_79:
    .asciz "cmp_end"
str_80:
    .asciz "cmp_true"
str_81:
    .asciz "blk_end"
str_82:
    .asciz "Last Statement"
str_83:
    .asciz "Not Last Statement"
str_84:
    .asciz "    adr x9, sign_id\n"
str_85:
    .asciz "    cmp x0, x9\n"
str_86:
    .asciz "    b.ne "
str_87:
    .asciz "Typo fix context usage above"
str_88:
    .asciz "1 + 2"
str_89:
    .asciz "f : 10; f + 5"
str_90:
    .asciz "[+ 1]\ Lambda Section"
str_91:
    .asciz "f : (x ? x + x); f 5\ Function Call"
str_92:
    .asciz "--- Compiling: "
str_93:
    .asciz " ---\n"
