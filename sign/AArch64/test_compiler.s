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

    adr x0, �
    str x0, [sp, #-16]!
    adr x0, �
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sys_brk
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.lo do_concat_8
    tst x1, #1
    b.eq do_concat_8
do_apply_7:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_9
do_concat_8:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_9:
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
    b.lo do_concat_13
    tst x1, #1
    b.eq do_concat_13
do_apply_12:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_14
do_concat_13:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_14:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_10
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
    bl _add
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
    b cond_end_11
cond_false_10:
    adr x0, sign_id
cond_end_11:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_21
    tst x1, #1
    b.eq do_concat_21
do_apply_20:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_22
do_concat_21:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_22:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_18
    b after_func_23_24
func_23:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_25_26
func_25:
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
    b.eq cond_false_28
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_31
    tst x1, #1
    b.eq do_concat_31
do_apply_30:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_32
do_concat_31:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_32:
    b cond_end_29
cond_false_28:
    adr x0, sign_id
cond_end_29:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_27
    adr x0, addr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_27
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
    b.ne blk_end_27
    adr x0, addr
blk_end_27:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_25_26:
    // Closure for func_25
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_25
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_23_24:
    // Closure for func_23
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_23
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_36
    tst x1, #1
    b.eq do_concat_36
do_apply_35:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_37
do_concat_36:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_37:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_33
    b after_func_38_39
func_38:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_38_39:
    // Closure for func_38
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_38
    ldr x0, [sp], #16
    bl _cons
    b cond_end_34
cond_false_33:
    adr x0, sign_id
cond_end_34:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tail
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_43
    tst x1, #1
    b.eq do_concat_43
do_apply_42:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_44
do_concat_43:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_44:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_40
    b after_func_45_46
func_45:
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
after_func_45_46:
    // Closure for func_45
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_45
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
    adr x0, nth
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_50
    tst x1, #1
    b.eq do_concat_50
do_apply_49:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_51
do_concat_50:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_51:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_47
    b after_func_52_53
func_52:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_54_55
func_54:
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
    b.le cmp_true_59
    adr x0, sign_id
    b cmp_end_60
cmp_true_59:
cmp_end_60:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_57
    adr x0, head
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
    b cond_end_58
cond_false_57:
    adr x0, sign_id
cond_end_58:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_56
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_71
    tst x1, #1
    b.eq do_concat_71
do_apply_70:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_72
do_concat_71:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_72:
blk_end_56:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_54_55:
    // Closure for func_54
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_54
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_52_53:
    // Closure for func_52
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_52
    ldr x0, [sp], #16
    bl _cons
    b cond_end_48
cond_false_47:
    adr x0, sign_id
cond_end_48:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, factorial
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_76
    tst x1, #1
    b.eq do_concat_76
do_apply_75:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_77
do_concat_76:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_77:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_73
    b after_func_78_79
func_78:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_83
    adr x0, sign_id
    b cmp_end_84
cmp_true_83:
cmp_end_84:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_81
    mov x0, #1
    b cond_end_82
cond_false_81:
    adr x0, sign_id
cond_end_82:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_80
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
    b.lo do_concat_86
    tst x1, #1
    b.eq do_concat_86
do_apply_85:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_87
do_concat_86:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_87:
blk_end_80:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_78_79:
    // Closure for func_78
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_78
    ldr x0, [sp], #16
    bl _cons
    b cond_end_74
cond_false_73:
    adr x0, sign_id
cond_end_74:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, range
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_91
    tst x1, #1
    b.eq do_concat_91
do_apply_90:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_92
do_concat_91:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_92:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_88
    b after_func_93_94
func_93:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_95_96
func_95:
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
    b.gt cmp_true_100
    adr x0, sign_id
    b cmp_end_101
cmp_true_100:
cmp_end_101:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_98
    mov x0, #0
    b cond_end_99
cond_false_98:
    adr x0, sign_id
cond_end_99:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_97
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_112
    tst x1, #1
    b.eq do_concat_112
do_apply_111:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_113
do_concat_112:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_113:
blk_end_97:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_95_96:
    // Closure for func_95
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_95
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_93_94:
    // Closure for func_93
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_93
    ldr x0, [sp], #16
    bl _cons
    b cond_end_89
cond_false_88:
    adr x0, sign_id
cond_end_89:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_117
    tst x1, #1
    b.eq do_concat_117
do_apply_116:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_118
do_concat_117:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_118:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_114
    b after_func_119_120
func_119:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov x0, #0
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
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_121
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
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
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_135
    tst x1, #1
    b.eq do_concat_135
do_apply_134:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_136
do_concat_135:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_136:
blk_end_121:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_119_120:
    // Closure for func_119
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_119
    ldr x0, [sp], #16
    bl _cons
    b cond_end_115
cond_false_114:
    adr x0, sign_id
cond_end_115:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_140
    tst x1, #1
    b.eq do_concat_140
do_apply_139:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_141
do_concat_140:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_141:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_137
    b after_func_142_143
func_142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_145_146
func_145:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_145_146:
    // Closure for func_145
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_145
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_147
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_147
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_147
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_150
    adr x0, sign_id
    b cmp_end_151
cmp_true_150:
cmp_end_151:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_148
    ldr x0, [x29, #-64]
    b cond_end_149
cond_false_148:
    adr x0, sign_id
cond_end_149:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_147
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
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
blk_end_147:
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_144
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_144
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_171
    tst x1, #1
    b.eq do_concat_171
do_apply_170:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_172
do_concat_171:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_172:
blk_end_144:
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
    b cond_end_138
cond_false_137:
    adr x0, sign_id
cond_end_138:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, print_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_176
    tst x1, #1
    b.eq do_concat_176
do_apply_175:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_177
do_concat_176:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_177:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_173
    b after_func_178_179
func_178:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_183
    adr x0, sign_id
    b cmp_end_184
cmp_true_183:
cmp_end_184:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_181
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #48
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_185
    mov x0, #0
blk_end_185:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_190
    tst x1, #1
    b.eq do_concat_190
do_apply_189:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_191
do_concat_190:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_191:
    b cond_end_182
cond_false_181:
    adr x0, sign_id
cond_end_182:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_180
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_194
    adr x0, sign_id
    b cmp_end_195
cmp_true_194:
cmp_end_195:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_192
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #45
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
    b.ne blk_end_196
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_196
    mov x0, #0
blk_end_196:
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
    b cond_end_193
cond_false_192:
    adr x0, sign_id
cond_end_193:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_180
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_207
    tst x1, #1
    b.eq do_concat_207
do_apply_206:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_208
do_concat_207:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_208:
blk_end_180:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_178_179:
    // Closure for func_178
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_178
    ldr x0, [sp], #16
    bl _cons
    b cond_end_174
cond_false_173:
    adr x0, sign_id
cond_end_174:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _print_num_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_212
    tst x1, #1
    b.eq do_concat_212
do_apply_211:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_213
do_concat_212:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_213:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_209
    b after_func_214_215
func_214:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_219
    adr x0, sign_id
    b cmp_end_220
cmp_true_219:
cmp_end_220:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_217
    mov x0, #0
    b cond_end_218
cond_false_217:
    adr x0, sign_id
cond_end_218:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_216
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_216
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
    b.lo do_concat_225
    tst x1, #1
    b.eq do_concat_225
do_apply_224:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_226
do_concat_225:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_226:
blk_end_216:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_214_215:
    // Closure for func_214
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_214
    ldr x0, [sp], #16
    bl _cons
    b cond_end_210
cond_false_209:
    adr x0, sign_id
cond_end_210:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_230
    tst x1, #1
    b.eq do_concat_230
do_apply_229:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_231
do_concat_230:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_231:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_227
    b after_func_232_233
func_232:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_234_235
func_234:
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
after_func_234_235:
    // Closure for func_234
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_234
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_232_233:
    // Closure for func_232
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_232
    ldr x0, [sp], #16
    bl _cons
    b cond_end_228
cond_false_227:
    adr x0, sign_id
cond_end_228:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sub
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_239
    tst x1, #1
    b.eq do_concat_239
do_apply_238:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_240
do_concat_239:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_240:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_236
    b after_func_241_242
func_241:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_243_244
func_243:
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
after_func_243_244:
    // Closure for func_243
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_243
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_241_242:
    // Closure for func_241
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_241
    ldr x0, [sp], #16
    bl _cons
    b cond_end_237
cond_false_236:
    adr x0, sign_id
cond_end_237:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, mul
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_248
    tst x1, #1
    b.eq do_concat_248
do_apply_247:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_249
do_concat_248:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_249:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_245
    b after_func_250_251
func_250:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_252_253
func_252:
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
after_func_252_253:
    // Closure for func_252
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_252
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_250_251:
    // Closure for func_250
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_250
    ldr x0, [sp], #16
    bl _cons
    b cond_end_246
cond_false_245:
    adr x0, sign_id
cond_end_246:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, div
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_257
    tst x1, #1
    b.eq do_concat_257
do_apply_256:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_258
do_concat_257:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_258:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_254
    b after_func_259_260
func_259:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_261_262
func_261:
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
after_func_261_262:
    // Closure for func_261
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_261
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_255
cond_false_254:
    adr x0, sign_id
cond_end_255:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, mod
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_266
    tst x1, #1
    b.eq do_concat_266
do_apply_265:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_267
do_concat_266:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_267:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_263
    b after_func_268_269
func_268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_270_271
func_270:
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
after_func_270_271:
    // Closure for func_270
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_270
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_264
cond_false_263:
    adr x0, sign_id
cond_end_264:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Pure
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
    str x0, [sp, #-16]!
    adr x0, Functional
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
    adr x0, Lexer
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
    adr x0, Version
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_290
    tst x1, #1
    b.eq do_concat_290
do_apply_289:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_291
do_concat_290:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_291:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_287
    b after_func_292_293
func_292:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_298
    adr x0, sign_id
    b cmp_end_299
cmp_true_298:
cmp_end_299:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_296
    b or_end_297
or_right_296:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_300
    adr x0, sign_id
    b cmp_end_301
cmp_true_300:
cmp_end_301:
or_end_297:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_294
    b or_end_295
or_right_294:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_302
    adr x0, sign_id
    b cmp_end_303
cmp_true_302:
cmp_end_303:
or_end_295:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_292_293:
    // Closure for func_292
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_292
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
    adr x0, is_digit
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_307
    tst x1, #1
    b.eq do_concat_307
do_apply_306:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_308
do_concat_307:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_308:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_304
    b after_func_309_310
func_309:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_313
    adr x0, sign_id
    b cmp_end_314
cmp_true_313:
cmp_end_314:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_311
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_315
    adr x0, sign_id
    b cmp_end_316
cmp_true_315:
cmp_end_316:
    b and_end_312
and_fail_311:
    adr x0, sign_id
and_end_312:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_309_310:
    // Closure for func_309
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_309
    ldr x0, [sp], #16
    bl _cons
    b cond_end_305
cond_false_304:
    adr x0, sign_id
cond_end_305:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_alpha
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_320
    tst x1, #1
    b.eq do_concat_320
do_apply_319:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_321
do_concat_320:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_321:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_317
    b after_func_322_323
func_322:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_330
    adr x0, sign_id
    b cmp_end_331
cmp_true_330:
cmp_end_331:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_328
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_332
    adr x0, sign_id
    b cmp_end_333
cmp_true_332:
cmp_end_333:
    b and_end_329
and_fail_328:
    adr x0, sign_id
and_end_329:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_326
    b or_end_327
or_right_326:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_336
    adr x0, sign_id
    b cmp_end_337
cmp_true_336:
cmp_end_337:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_334
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_338
    adr x0, sign_id
    b cmp_end_339
cmp_true_338:
cmp_end_339:
    b and_end_335
and_fail_334:
    adr x0, sign_id
and_end_335:
or_end_327:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_324
    b or_end_325
or_right_324:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_340
    adr x0, sign_id
    b cmp_end_341
cmp_true_340:
cmp_end_341:
or_end_325:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_322_323:
    // Closure for func_322
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_322
    ldr x0, [sp], #16
    bl _cons
    b cond_end_318
cond_false_317:
    adr x0, sign_id
cond_end_318:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_op_char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_345
    tst x1, #1
    b.eq do_concat_345
do_apply_344:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_346
do_concat_345:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_346:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_342
    b after_func_347_348
func_347:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_379
    adr x0, sign_id
    b cmp_end_380
cmp_true_379:
cmp_end_380:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_377
    b or_end_378
or_right_377:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_381
    adr x0, sign_id
    b cmp_end_382
cmp_true_381:
cmp_end_382:
or_end_378:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_375
    b or_end_376
or_right_375:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_383
    adr x0, sign_id
    b cmp_end_384
cmp_true_383:
cmp_end_384:
or_end_376:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_373
    b or_end_374
or_right_373:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_385
    adr x0, sign_id
    b cmp_end_386
cmp_true_385:
cmp_end_386:
or_end_374:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_371
    b or_end_372
or_right_371:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_387
    adr x0, sign_id
    b cmp_end_388
cmp_true_387:
cmp_end_388:
or_end_372:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_369
    b or_end_370
or_right_369:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_389
    adr x0, sign_id
    b cmp_end_390
cmp_true_389:
cmp_end_390:
or_end_370:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_367
    b or_end_368
or_right_367:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_391
    adr x0, sign_id
    b cmp_end_392
cmp_true_391:
cmp_end_392:
or_end_368:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_365
    b or_end_366
or_right_365:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_393
    adr x0, sign_id
    b cmp_end_394
cmp_true_393:
cmp_end_394:
or_end_366:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_363
    b or_end_364
or_right_363:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_395
    adr x0, sign_id
    b cmp_end_396
cmp_true_395:
cmp_end_396:
or_end_364:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_361
    b or_end_362
or_right_361:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_397
    adr x0, sign_id
    b cmp_end_398
cmp_true_397:
cmp_end_398:
or_end_362:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_359
    b or_end_360
or_right_359:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_399
    adr x0, sign_id
    b cmp_end_400
cmp_true_399:
cmp_end_400:
or_end_360:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_357
    b or_end_358
or_right_357:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_401
    adr x0, sign_id
    b cmp_end_402
cmp_true_401:
cmp_end_402:
or_end_358:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_355
    b or_end_356
or_right_355:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_403
    adr x0, sign_id
    b cmp_end_404
cmp_true_403:
cmp_end_404:
or_end_356:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_353
    b or_end_354
or_right_353:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_405
    adr x0, sign_id
    b cmp_end_406
cmp_true_405:
cmp_end_406:
or_end_354:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_351
    b or_end_352
or_right_351:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_407
    adr x0, sign_id
    b cmp_end_408
cmp_true_407:
cmp_end_408:
or_end_352:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_349
    b or_end_350
or_right_349:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_409
    adr x0, sign_id
    b cmp_end_410
cmp_true_409:
cmp_end_410:
or_end_350:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_347_348:
    // Closure for func_347
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_347
    ldr x0, [sp], #16
    bl _cons
    b cond_end_343
cond_false_342:
    adr x0, sign_id
cond_end_343:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, length
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_414
    tst x1, #1
    b.eq do_concat_414
do_apply_413:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_415
do_concat_414:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_415:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_411
    b after_func_416_417
func_416:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_421
    adr x0, sign_id
    b cmp_end_422
cmp_true_421:
cmp_end_422:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_419
    mov x0, #0
    b cond_end_420
cond_false_419:
    adr x0, sign_id
cond_end_420:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_418
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
    b.lo do_concat_424
    tst x1, #1
    b.eq do_concat_424
do_apply_423:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_425
do_concat_424:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_425:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_427
    tst x1, #1
    b.eq do_concat_427
do_apply_426:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_428
do_concat_427:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_428:
blk_end_418:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_416_417:
    // Closure for func_416
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_416
    ldr x0, [sp], #16
    bl _cons
    b cond_end_412
cond_false_411:
    adr x0, sign_id
cond_end_412:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, reverse
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_432
    tst x1, #1
    b.eq do_concat_432
do_apply_431:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_433
do_concat_432:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_433:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_429
    b after_func_434_435
func_434:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _rev
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_437
    tst x1, #1
    b.eq do_concat_437
do_apply_436:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_438
do_concat_437:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_438:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_440
    tst x1, #1
    b.eq do_concat_440
do_apply_439:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_441
do_concat_440:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_441:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_434_435:
    // Closure for func_434
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_434
    ldr x0, [sp], #16
    bl _cons
    b cond_end_430
cond_false_429:
    adr x0, sign_id
cond_end_430:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _rev
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_445
    tst x1, #1
    b.eq do_concat_445
do_apply_444:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_446
do_concat_445:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_446:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_442
    b after_func_447_448
func_447:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_449_450
func_449:
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
    b.eq cmp_true_454
    adr x0, sign_id
    b cmp_end_455
cmp_true_454:
cmp_end_455:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_452
    ldr x0, [x29, #-32]
    b cond_end_453
cond_false_452:
    adr x0, sign_id
cond_end_453:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_451
    adr x0, _rev
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_457
    tst x1, #1
    b.eq do_concat_457
do_apply_456:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_458
do_concat_457:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_458:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_460
    tst x1, #1
    b.eq do_concat_460
do_apply_459:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_461
do_concat_460:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_461:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_469
    tst x1, #1
    b.eq do_concat_469
do_apply_468:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_470
do_concat_469:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_470:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_472
    tst x1, #1
    b.eq do_concat_472
do_apply_471:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_473
do_concat_472:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_473:
blk_end_451:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_449_450:
    // Closure for func_449
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_449
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_447_448:
    // Closure for func_447
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_447
    ldr x0, [sp], #16
    bl _cons
    b cond_end_443
cond_false_442:
    adr x0, sign_id
cond_end_443:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, list_to_string
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_474
    b after_func_479_480
func_479:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_482_483
func_482:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_482_483:
    // Closure for func_482
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_482
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_485_486
func_485:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_485_486:
    // Closure for func_485
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_485
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, _write_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_492
    tst x1, #1
    b.eq do_concat_492
do_apply_491:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_493
do_concat_492:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_493:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_495
    tst x1, #1
    b.eq do_concat_495
do_apply_494:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_496
do_concat_495:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_496:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_487
    adr x0, str
    str x0, [sp, #-16]!
    adr x0, len
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_487
    adr x0, str
blk_end_487:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_498
    tst x1, #1
    b.eq do_concat_498
do_apply_497:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_499
do_concat_498:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_499:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_484
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_501
    tst x1, #1
    b.eq do_concat_501
do_apply_500:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_502
do_concat_501:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_502:
blk_end_484:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_504
    tst x1, #1
    b.eq do_concat_504
do_apply_503:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_505
do_concat_504:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_505:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_481
    adr x0, length
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_507
    tst x1, #1
    b.eq do_concat_507
do_apply_506:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_508
do_concat_507:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_508:
blk_end_481:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_479_480:
    // Closure for func_479
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_479
    ldr x0, [sp], #16
    bl _cons
    b cond_end_475
cond_false_474:
    adr x0, sign_id
cond_end_475:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _write_list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_512
    tst x1, #1
    b.eq do_concat_512
do_apply_511:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_513
do_concat_512:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_513:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_509
    b after_func_514_515
func_514:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_516_517
func_516:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_518_519
func_518:
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
    b.eq cmp_true_523
    adr x0, sign_id
    b cmp_end_524
cmp_true_523:
cmp_end_524:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_521
    mov x0, #0
    b cond_end_522
cond_false_521:
    adr x0, sign_id
cond_end_522:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_520
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
    b.lo do_concat_526
    tst x1, #1
    b.eq do_concat_526
do_apply_525:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_527
do_concat_526:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_527:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_520
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_529
    tst x1, #1
    b.eq do_concat_529
do_apply_528:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_530
do_concat_529:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_530:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_532
    tst x1, #1
    b.eq do_concat_532
do_apply_531:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_533
do_concat_532:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_533:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_535
    tst x1, #1
    b.eq do_concat_535
do_apply_534:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_536
do_concat_535:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_536:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
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
blk_end_520:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_518_519:
    // Closure for func_518
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
    adr x1, func_518
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_516_517:
    // Closure for func_516
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_516
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_514_515:
    // Closure for func_514
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_514
    ldr x0, [sp], #16
    bl _cons
    b cond_end_510
cond_false_509:
    adr x0, sign_id
cond_end_510:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tokenize
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_543
    tst x1, #1
    b.eq do_concat_543
do_apply_542:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_544
do_concat_543:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_544:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_540
    b after_func_545_546
func_545:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_548
    tst x1, #1
    b.eq do_concat_548
do_apply_547:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_549
do_concat_548:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_549:
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_551
    tst x1, #1
    b.eq do_concat_551
do_apply_550:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_552
do_concat_551:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_552:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_554
    tst x1, #1
    b.eq do_concat_554
do_apply_553:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_555
do_concat_554:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_555:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_557
    tst x1, #1
    b.eq do_concat_557
do_apply_556:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_558
do_concat_557:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_558:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_545_546:
    // Closure for func_545
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_545
    ldr x0, [sp], #16
    bl _cons
    b cond_end_541
cond_false_540:
    adr x0, sign_id
cond_end_541:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_562
    tst x1, #1
    b.eq do_concat_562
do_apply_561:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_563
do_concat_562:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_563:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_559
    b after_func_564_565
func_564:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_566_567
func_566:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_568_569
func_568:
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
    b after_func_571_572
func_571:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_571_572:
    // Closure for func_571
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_571
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_574_575
func_574:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_574_575:
    // Closure for func_574
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_574
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_577_578
func_577:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_577_578:
    // Closure for func_577
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_577
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
    b.eq cmp_true_582
    adr x0, sign_id
    b cmp_end_583
cmp_true_582:
cmp_end_583:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_580
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, token
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_585
    tst x1, #1
    b.eq do_concat_585
do_apply_584:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_586
do_concat_585:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_586:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_588
    tst x1, #1
    b.eq do_concat_588
do_apply_587:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_589
do_concat_588:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_589:
    b cond_end_581
cond_false_580:
    adr x0, sign_id
cond_end_581:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_579
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, token
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_591
    tst x1, #1
    b.eq do_concat_591
do_apply_590:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_592
do_concat_591:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_592:
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_594
    tst x1, #1
    b.eq do_concat_594
do_apply_593:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_595
do_concat_594:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_595:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_597
    tst x1, #1
    b.eq do_concat_597
do_apply_596:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_598
do_concat_597:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_598:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_600
    tst x1, #1
    b.eq do_concat_600
do_apply_599:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_601
do_concat_600:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_601:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_603
    tst x1, #1
    b.eq do_concat_603
do_apply_602:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_604
do_concat_603:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_604:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_606
    tst x1, #1
    b.eq do_concat_606
do_apply_605:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_607
do_concat_606:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_607:
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
blk_end_579:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_612
    tst x1, #1
    b.eq do_concat_612
do_apply_611:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_613
do_concat_612:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_613:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_576
    adr x0, token
    ldr x0, [x0] // @ load
blk_end_576:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_615
    tst x1, #1
    b.eq do_concat_615
do_apply_614:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_616
do_concat_615:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_616:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_573
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_618
    tst x1, #1
    b.eq do_concat_618
do_apply_617:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_619
do_concat_618:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_619:
blk_end_573:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_621
    tst x1, #1
    b.eq do_concat_621
do_apply_620:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_622
do_concat_621:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_622:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_570
    adr x0, scan_token
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_624
    tst x1, #1
    b.eq do_concat_624
do_apply_623:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_625
do_concat_624:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_625:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_627
    tst x1, #1
    b.eq do_concat_627
do_apply_626:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_628
do_concat_627:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_628:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_630
    tst x1, #1
    b.eq do_concat_630
do_apply_629:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_631
do_concat_630:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_631:
blk_end_570:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_568_569:
    // Closure for func_568
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
    adr x1, func_568
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_566_567:
    // Closure for func_566
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_566
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_564_565:
    // Closure for func_564
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_564
    ldr x0, [sp], #16
    bl _cons
    b cond_end_560
cond_false_559:
    adr x0, sign_id
cond_end_560:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_token
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_635
    tst x1, #1
    b.eq do_concat_635
do_apply_634:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_636
do_concat_635:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_636:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_632
    b after_func_637_638
func_637:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_639_640
func_639:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_641_642
func_641:
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
    b.ge cmp_true_646
    adr x0, sign_id
    b cmp_end_647
cmp_true_646:
cmp_end_647:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_644
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_649
    tst x1, #1
    b.eq do_concat_649
do_apply_648:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_650
do_concat_649:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_650:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_652
    tst x1, #1
    b.eq do_concat_652
do_apply_651:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_653
do_concat_652:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_653:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_655
    tst x1, #1
    b.eq do_concat_655
do_apply_654:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_656
do_concat_655:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_656:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_658
    tst x1, #1
    b.eq do_concat_658
do_apply_657:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_659
do_concat_658:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_659:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_661
    tst x1, #1
    b.eq do_concat_661
do_apply_660:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_662
do_concat_661:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_662:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_664
    tst x1, #1
    b.eq do_concat_664
do_apply_663:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_665
do_concat_664:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_665:
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
    b cond_end_645
cond_false_644:
    adr x0, sign_id
cond_end_645:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_643
    b after_func_669_670
func_669:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_669_670:
    // Closure for func_669
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_669
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_675
    tst x1, #1
    b.eq do_concat_675
do_apply_674:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_676
do_concat_675:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_676:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_672
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, scan_token
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_678
    tst x1, #1
    b.eq do_concat_678
do_apply_677:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_679
do_concat_678:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_679:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_681
    tst x1, #1
    b.eq do_concat_681
do_apply_680:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_682
do_concat_681:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_682:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_684
    tst x1, #1
    b.eq do_concat_684
do_apply_683:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_685
do_concat_684:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_685:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_687
    tst x1, #1
    b.eq do_concat_687
do_apply_686:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_688
do_concat_687:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_688:
    b cond_end_673
cond_false_672:
    adr x0, sign_id
cond_end_673:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_691
    adr x0, sign_id
    b cmp_end_692
cmp_true_691:
cmp_end_692:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_689
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_694
    tst x1, #1
    b.eq do_concat_694
do_apply_693:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_695
do_concat_694:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_695:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_697
    tst x1, #1
    b.eq do_concat_697
do_apply_696:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_698
do_concat_697:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_698:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_700
    tst x1, #1
    b.eq do_concat_700
do_apply_699:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_701
do_concat_700:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_701:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_703
    tst x1, #1
    b.eq do_concat_703
do_apply_702:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_704
do_concat_703:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_704:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_706
    tst x1, #1
    b.eq do_concat_706
do_apply_705:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_707
do_concat_706:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_707:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_709
    tst x1, #1
    b.eq do_concat_709
do_apply_708:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_710
do_concat_709:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_710:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_712
    tst x1, #1
    b.eq do_concat_712
do_apply_711:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_713
do_concat_712:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_713:
    b cond_end_690
cond_false_689:
    adr x0, sign_id
cond_end_690:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    adr x0, is_digit
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_717
    tst x1, #1
    b.eq do_concat_717
do_apply_716:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_718
do_concat_717:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_718:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_714
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_720_721
func_720:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_720_721:
    // Closure for func_720
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_720
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_723_724
func_723:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b after_func_726_727
func_726:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_726_727:
    // Closure for func_726
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_726
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_729
    tst x1, #1
    b.eq do_concat_729
do_apply_728:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_730
do_concat_729:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_730:
    str x0, [sp, #-16]!
    adr x0, val
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_732
    tst x1, #1
    b.eq do_concat_732
do_apply_731:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_733
do_concat_732:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_733:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_735
    tst x1, #1
    b.eq do_concat_735
do_apply_734:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_736
do_concat_735:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_736:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_738
    tst x1, #1
    b.eq do_concat_738
do_apply_737:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_739
do_concat_738:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_739:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_741
    tst x1, #1
    b.eq do_concat_741
do_apply_740:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_742
do_concat_741:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_742:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_744
    tst x1, #1
    b.eq do_concat_744
do_apply_743:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_745
do_concat_744:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_745:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_747
    tst x1, #1
    b.eq do_concat_747
do_apply_746:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_748
do_concat_747:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_748:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_750
    tst x1, #1
    b.eq do_concat_750
do_apply_749:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_751
do_concat_750:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_751:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_753
    tst x1, #1
    b.eq do_concat_753
do_apply_752:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_754
do_concat_753:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_754:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_725
    adr x0, _parse_int
    str x0, [sp, #-16]!
    adr x0, val_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_756
    tst x1, #1
    b.eq do_concat_756
do_apply_755:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_757
do_concat_756:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_757:
blk_end_725:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_759
    tst x1, #1
    b.eq do_concat_759
do_apply_758:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_760
do_concat_759:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_760:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_722
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_762
    tst x1, #1
    b.eq do_concat_762
do_apply_761:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_763
do_concat_762:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_763:
blk_end_722:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_765
    tst x1, #1
    b.eq do_concat_765
do_apply_764:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_766
do_concat_765:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_766:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_719
    adr x0, scan_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_768
    tst x1, #1
    b.eq do_concat_768
do_apply_767:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_769
do_concat_768:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_769:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_771
    tst x1, #1
    b.eq do_concat_771
do_apply_770:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_772
do_concat_771:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_772:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_774
    tst x1, #1
    b.eq do_concat_774
do_apply_773:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_775
do_concat_774:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_775:
blk_end_719:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_777
    tst x1, #1
    b.eq do_concat_777
do_apply_776:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_778
do_concat_777:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_778:
    b cond_end_715
cond_false_714:
    adr x0, sign_id
cond_end_715:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    adr x0, is_alpha
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_782
    tst x1, #1
    b.eq do_concat_782
do_apply_781:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_783
do_concat_782:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_783:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_779
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_785_786
func_785:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_785_786:
    // Closure for func_785
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_785
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_788
    tst x1, #1
    b.eq do_concat_788
do_apply_787:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_789
do_concat_788:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_789:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_791
    tst x1, #1
    b.eq do_concat_791
do_apply_790:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_792
do_concat_791:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_792:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_794
    tst x1, #1
    b.eq do_concat_794
do_apply_793:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_795
do_concat_794:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_795:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_797
    tst x1, #1
    b.eq do_concat_797
do_apply_796:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_798
do_concat_797:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_798:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_800
    tst x1, #1
    b.eq do_concat_800
do_apply_799:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_801
do_concat_800:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_801:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_803
    tst x1, #1
    b.eq do_concat_803
do_apply_802:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_804
do_concat_803:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_804:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_806
    tst x1, #1
    b.eq do_concat_806
do_apply_805:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_807
do_concat_806:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_807:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_784
    adr x0, scan_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_818
    tst x1, #1
    b.eq do_concat_818
do_apply_817:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_819
do_concat_818:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_819:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_821
    tst x1, #1
    b.eq do_concat_821
do_apply_820:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_822
do_concat_821:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_822:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_824
    tst x1, #1
    b.eq do_concat_824
do_apply_823:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_825
do_concat_824:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_825:
blk_end_784:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_827
    tst x1, #1
    b.eq do_concat_827
do_apply_826:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_828
do_concat_827:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_828:
    b cond_end_780
cond_false_779:
    adr x0, sign_id
cond_end_780:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    adr x0, is_op_char
    str x0, [sp, #-16]!
    adr x0, c
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_829
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_835_836
func_835:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_835_836:
    // Closure for func_835
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_835
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
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
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
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
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_850
    tst x1, #1
    b.eq do_concat_850
do_apply_849:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_851
do_concat_850:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_851:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_853
    tst x1, #1
    b.eq do_concat_853
do_apply_852:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_854
do_concat_853:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_854:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_856
    tst x1, #1
    b.eq do_concat_856
do_apply_855:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_857
do_concat_856:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_857:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_859
    tst x1, #1
    b.eq do_concat_859
do_apply_858:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_860
do_concat_859:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_860:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_862
    tst x1, #1
    b.eq do_concat_862
do_apply_861:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_863
do_concat_862:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_863:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_865
    tst x1, #1
    b.eq do_concat_865
do_apply_864:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_866
do_concat_865:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_866:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_834
    adr x0, scan_op
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_868
    tst x1, #1
    b.eq do_concat_868
do_apply_867:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_869
do_concat_868:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_869:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_871
    tst x1, #1
    b.eq do_concat_871
do_apply_870:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_872
do_concat_871:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_872:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_874
    tst x1, #1
    b.eq do_concat_874
do_apply_873:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_875
do_concat_874:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_875:
blk_end_834:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_877
    tst x1, #1
    b.eq do_concat_877
do_apply_876:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_878
do_concat_877:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_878:
    b cond_end_830
cond_false_829:
    adr x0, sign_id
cond_end_830:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_881
    adr x0, sign_id
    b cmp_end_882
cmp_true_881:
cmp_end_882:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_879
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_884_885
func_884:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_884_885:
    // Closure for func_884
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_884
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_887
    tst x1, #1
    b.eq do_concat_887
do_apply_886:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_888
do_concat_887:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_888:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_890
    tst x1, #1
    b.eq do_concat_890
do_apply_889:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_891
do_concat_890:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_891:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_893
    tst x1, #1
    b.eq do_concat_893
do_apply_892:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_894
do_concat_893:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_894:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_896
    tst x1, #1
    b.eq do_concat_896
do_apply_895:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_897
do_concat_896:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_897:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_899
    tst x1, #1
    b.eq do_concat_899
do_apply_898:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_900
do_concat_899:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_900:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_902
    tst x1, #1
    b.eq do_concat_902
do_apply_901:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_903
do_concat_902:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_903:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_905
    tst x1, #1
    b.eq do_concat_905
do_apply_904:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_906
do_concat_905:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_906:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_908
    tst x1, #1
    b.eq do_concat_908
do_apply_907:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_909
do_concat_908:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_909:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_911
    tst x1, #1
    b.eq do_concat_911
do_apply_910:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_912
do_concat_911:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_912:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_914
    tst x1, #1
    b.eq do_concat_914
do_apply_913:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_915
do_concat_914:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_915:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_883
    adr x0, scan_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_917
    tst x1, #1
    b.eq do_concat_917
do_apply_916:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_918
do_concat_917:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_918:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_920
    tst x1, #1
    b.eq do_concat_920
do_apply_919:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_921
do_concat_920:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_921:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_923
    tst x1, #1
    b.eq do_concat_923
do_apply_922:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_924
do_concat_923:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_924:
blk_end_883:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_926
    tst x1, #1
    b.eq do_concat_926
do_apply_925:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_927
do_concat_926:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_927:
    b cond_end_880
cond_false_879:
    adr x0, sign_id
cond_end_880:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_929
    tst x1, #1
    b.eq do_concat_929
do_apply_928:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_930
do_concat_929:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_930:
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_932
    tst x1, #1
    b.eq do_concat_932
do_apply_931:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_933
do_concat_932:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_933:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_935
    tst x1, #1
    b.eq do_concat_935
do_apply_934:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_936
do_concat_935:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_936:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_938
    tst x1, #1
    b.eq do_concat_938
do_apply_937:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_939
do_concat_938:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_939:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_941
    tst x1, #1
    b.eq do_concat_941
do_apply_940:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_942
do_concat_941:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_942:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_944
    tst x1, #1
    b.eq do_concat_944
do_apply_943:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_945
do_concat_944:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_945:
blk_end_671:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_947
    tst x1, #1
    b.eq do_concat_947
do_apply_946:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_948
do_concat_947:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_948:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_643
    adr x0, nth
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_950
    tst x1, #1
    b.eq do_concat_950
do_apply_949:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_951
do_concat_950:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_951:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_953
    tst x1, #1
    b.eq do_concat_953
do_apply_952:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_954
do_concat_953:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_954:
blk_end_643:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_641_642:
    // Closure for func_641
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
    adr x1, func_641
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_639_640:
    // Closure for func_639
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_639
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_637_638:
    // Closure for func_637
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_637
    ldr x0, [sp], #16
    bl _cons
    b cond_end_633
cond_false_632:
    adr x0, sign_id
cond_end_633:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_958
    tst x1, #1
    b.eq do_concat_958
do_apply_957:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_959
do_concat_958:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_959:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_955
    b after_func_960_961
func_960:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_962_963
func_962:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_964_965
func_964:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_967
    tst x1, #1
    b.eq do_concat_967
do_apply_966:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_968
do_concat_967:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_968:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_970
    tst x1, #1
    b.eq do_concat_970
do_apply_969:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_971
do_concat_970:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_971:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_973
    tst x1, #1
    b.eq do_concat_973
do_apply_972:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_974
do_concat_973:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_974:
    str x0, [sp, #-16]!
    adr x0, is_digit
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_964_965:
    // Closure for func_964
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
    adr x1, func_964
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_962_963:
    // Closure for func_962
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_962
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_960_961:
    // Closure for func_960
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_960
    ldr x0, [sp], #16
    bl _cons
    b cond_end_956
cond_false_955:
    adr x0, sign_id
cond_end_956:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_id
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_981
    tst x1, #1
    b.eq do_concat_981
do_apply_980:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_982
do_concat_981:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_982:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_978
    b after_func_983_984
func_983:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_985_986
func_985:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_987_988
func_987:
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
    b.ne blk_end_989
    adr x0, _scan_while
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_991
    tst x1, #1
    b.eq do_concat_991
do_apply_990:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_992
do_concat_991:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_992:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_994
    tst x1, #1
    b.eq do_concat_994
do_apply_993:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_995
do_concat_994:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_995:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_997
    tst x1, #1
    b.eq do_concat_997
do_apply_996:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_998
do_concat_997:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_998:
    str x0, [sp, #-16]!
    b after_func_999_1000
func_999:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1001
    b or_end_1002
or_right_1001:
    adr x0, is_digit
or_end_1002:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1004
    tst x1, #1
    b.eq do_concat_1004
do_apply_1003:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1005
do_concat_1004:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1005:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1007
    tst x1, #1
    b.eq do_concat_1007
do_apply_1006:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1008
do_concat_1007:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1008:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_999_1000:
    // Closure for func_999
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_999
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1010
    tst x1, #1
    b.eq do_concat_1010
do_apply_1009:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1011
do_concat_1010:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1011:
blk_end_989:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_987_988:
    // Closure for func_987
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
    adr x1, func_987
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_985_986:
    // Closure for func_985
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_985
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_983_984:
    // Closure for func_983
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_983
    ldr x0, [sp], #16
    bl _cons
    b cond_end_979
cond_false_978:
    adr x0, sign_id
cond_end_979:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1015
    tst x1, #1
    b.eq do_concat_1015
do_apply_1014:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1016
do_concat_1015:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1016:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1012
    b after_func_1017_1018
func_1017:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1019_1020
func_1019:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1021_1022
func_1021:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1024
    tst x1, #1
    b.eq do_concat_1024
do_apply_1023:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1025
do_concat_1024:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1025:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1027
    tst x1, #1
    b.eq do_concat_1027
do_apply_1026:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1028
do_concat_1027:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1028:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1030
    tst x1, #1
    b.eq do_concat_1030
do_apply_1029:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1031
do_concat_1030:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1031:
    str x0, [sp, #-16]!
    adr x0, is_op_char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1033
    tst x1, #1
    b.eq do_concat_1033
do_apply_1032:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1034
do_concat_1033:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1034:
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
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1021
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1019_1020:
    // Closure for func_1019
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1019
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1017_1018:
    // Closure for func_1017
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1017
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1013
cond_false_1012:
    adr x0, sign_id
cond_end_1013:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_while
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1038
    tst x1, #1
    b.eq do_concat_1038
do_apply_1037:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1039
do_concat_1038:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1039:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1035
    b after_func_1040_1041
func_1040:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1042_1043
func_1042:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1044_1045
func_1044:
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
    b after_func_1046_1047
func_1046:
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
    b after_func_1049_1050
func_1049:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1049_1050:
    // Closure for func_1049
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1049
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1052_1053
func_1052:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1052_1053:
    // Closure for func_1052
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1052
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1055_1056
func_1055:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1055_1056:
    // Closure for func_1055
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1055
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1058
    tst x1, #1
    b.eq do_concat_1058
do_apply_1057:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1059
do_concat_1058:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1059:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1061
    tst x1, #1
    b.eq do_concat_1061
do_apply_1060:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1062
do_concat_1061:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1062:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1064
    tst x1, #1
    b.eq do_concat_1064
do_apply_1063:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1065
do_concat_1064:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1065:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1067
    tst x1, #1
    b.eq do_concat_1067
do_apply_1066:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1068
do_concat_1067:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1068:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1070
    tst x1, #1
    b.eq do_concat_1070
do_apply_1069:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1071
do_concat_1070:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1071:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1073
    tst x1, #1
    b.eq do_concat_1073
do_apply_1072:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1074
do_concat_1073:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1074:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1054
    adr x0, reverse
    str x0, [sp, #-16]!
    adr x0, chars_rev
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
blk_end_1054:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1085
    tst x1, #1
    b.eq do_concat_1085
do_apply_1084:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1086
do_concat_1085:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1086:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1051
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1088
    tst x1, #1
    b.eq do_concat_1088
do_apply_1087:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1089
do_concat_1088:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1089:
blk_end_1051:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1091
    tst x1, #1
    b.eq do_concat_1091
do_apply_1090:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1092
do_concat_1091:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1092:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1048
    adr x0, _scan_while_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1094
    tst x1, #1
    b.eq do_concat_1094
do_apply_1093:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1095
do_concat_1094:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1095:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1097
    tst x1, #1
    b.eq do_concat_1097
do_apply_1096:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1098
do_concat_1097:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1098:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1100
    tst x1, #1
    b.eq do_concat_1100
do_apply_1099:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1101
do_concat_1100:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1101:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1103
    tst x1, #1
    b.eq do_concat_1103
do_apply_1102:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1104
do_concat_1103:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1104:
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_1048:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1046_1047:
    // Closure for func_1046
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
    adr x1, func_1046
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1044_1045:
    // Closure for func_1044
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
    adr x1, func_1044
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1042_1043:
    // Closure for func_1042
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1042
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1040_1041:
    // Closure for func_1040
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1040
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1036
cond_false_1035:
    adr x0, sign_id
cond_end_1036:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_while_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1111
    tst x1, #1
    b.eq do_concat_1111
do_apply_1110:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1112
do_concat_1111:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1112:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1108
    b after_func_1113_1114
func_1113:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1115_1116
func_1115:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1117_1118
func_1117:
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
    b after_func_1119_1120
func_1119:
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
    b after_func_1121_1122
func_1121:
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
    b.ge cmp_true_1126
    adr x0, sign_id
    b cmp_end_1127
cmp_true_1126:
cmp_end_1127:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1124
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1129
    tst x1, #1
    b.eq do_concat_1129
do_apply_1128:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1130
do_concat_1129:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1130:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1132
    tst x1, #1
    b.eq do_concat_1132
do_apply_1131:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1133
do_concat_1132:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1133:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1135
    tst x1, #1
    b.eq do_concat_1135
do_apply_1134:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1136
do_concat_1135:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1136:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1138
    tst x1, #1
    b.eq do_concat_1138
do_apply_1137:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1139
do_concat_1138:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1139:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1141
    tst x1, #1
    b.eq do_concat_1141
do_apply_1140:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1142
do_concat_1141:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1142:
    b cond_end_1125
cond_false_1124:
    adr x0, sign_id
cond_end_1125:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1123
    b after_func_1143_1144
func_1143:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1143_1144:
    // Closure for func_1143
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1143
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1149
    tst x1, #1
    b.eq do_concat_1149
do_apply_1148:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1150
do_concat_1149:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1150:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1146
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, _scan_while_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    ldr x0, [x29, #-64]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1158
    tst x1, #1
    b.eq do_concat_1158
do_apply_1157:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1159
do_concat_1158:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1159:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1161
    tst x1, #1
    b.eq do_concat_1161
do_apply_1160:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1162
do_concat_1161:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1162:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1164
    tst x1, #1
    b.eq do_concat_1164
do_apply_1163:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1165
do_concat_1164:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1165:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1167
    tst x1, #1
    b.eq do_concat_1167
do_apply_1166:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1168
do_concat_1167:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1168:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1170
    tst x1, #1
    b.eq do_concat_1170
do_apply_1169:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1171
do_concat_1170:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1171:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1173
    tst x1, #1
    b.eq do_concat_1173
do_apply_1172:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1174
do_concat_1173:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1174:
    b cond_end_1147
cond_false_1146:
    adr x0, sign_id
cond_end_1147:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1145
    adr x0, cons
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
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1182
    tst x1, #1
    b.eq do_concat_1182
do_apply_1181:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1183
do_concat_1182:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1183:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1185
    tst x1, #1
    b.eq do_concat_1185
do_apply_1184:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1186
do_concat_1185:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1186:
blk_end_1145:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1188
    tst x1, #1
    b.eq do_concat_1188
do_apply_1187:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1189
do_concat_1188:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1189:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1123
    adr x0, nth
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1191
    tst x1, #1
    b.eq do_concat_1191
do_apply_1190:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1192
do_concat_1191:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1192:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1194
    tst x1, #1
    b.eq do_concat_1194
do_apply_1193:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1195
do_concat_1194:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1195:
blk_end_1123:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1121_1122:
    // Closure for func_1121
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
    adr x1, func_1121
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1119_1120:
    // Closure for func_1119
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
    adr x1, func_1119
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1117_1118:
    // Closure for func_1117
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
    adr x1, func_1117
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1115_1116:
    // Closure for func_1115
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1115
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1113_1114:
    // Closure for func_1113
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1113
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1109
cond_false_1108:
    adr x0, sign_id
cond_end_1109:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1199
    tst x1, #1
    b.eq do_concat_1199
do_apply_1198:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1200
do_concat_1199:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1200:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1196
    b after_func_1201_1202
func_1201:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1203_1204
func_1203:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1205_1206
func_1205:
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
    b.ne blk_end_1207
    b after_func_1208_1209
func_1208:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1208_1209:
    // Closure for func_1208
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1208
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1211_1212
func_1211:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1211_1212:
    // Closure for func_1211
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1211
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1214_1215
func_1214:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1214_1215:
    // Closure for func_1214
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1214
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1217_1218
func_1217:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1217_1218:
    // Closure for func_1217
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1217
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1220
    tst x1, #1
    b.eq do_concat_1220
do_apply_1219:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1221
do_concat_1220:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1221:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1223
    tst x1, #1
    b.eq do_concat_1223
do_apply_1222:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1224
do_concat_1223:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1224:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1226
    tst x1, #1
    b.eq do_concat_1226
do_apply_1225:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1227
do_concat_1226:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1227:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1229
    tst x1, #1
    b.eq do_concat_1229
do_apply_1228:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1230
do_concat_1229:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1230:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1232
    tst x1, #1
    b.eq do_concat_1232
do_apply_1231:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1233
do_concat_1232:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1233:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1235
    tst x1, #1
    b.eq do_concat_1235
do_apply_1234:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1236
do_concat_1235:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1236:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1238
    tst x1, #1
    b.eq do_concat_1238
do_apply_1237:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1239
do_concat_1238:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1239:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1241
    tst x1, #1
    b.eq do_concat_1241
do_apply_1240:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1242
do_concat_1241:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1242:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1216
    adr x0, reverse
    str x0, [sp, #-16]!
    adr x0, chars_rev
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
blk_end_1216:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1247
    tst x1, #1
    b.eq do_concat_1247
do_apply_1246:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1248
do_concat_1247:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1248:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1213
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1250
    tst x1, #1
    b.eq do_concat_1250
do_apply_1249:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1251
do_concat_1250:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1251:
blk_end_1213:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1253
    tst x1, #1
    b.eq do_concat_1253
do_apply_1252:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1254
do_concat_1253:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1254:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1210
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1256
    tst x1, #1
    b.eq do_concat_1256
do_apply_1255:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1257
do_concat_1256:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1257:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    str x0, [sp, #-16]!
    adr x0, start_pos
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1262
    tst x1, #1
    b.eq do_concat_1262
do_apply_1261:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1263
do_concat_1262:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1263:
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
blk_end_1210:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1268
    tst x1, #1
    b.eq do_concat_1268
do_apply_1267:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1269
do_concat_1268:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1269:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1207
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
blk_end_1207:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1205_1206:
    // Closure for func_1205
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
    adr x1, func_1205
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1203_1204:
    // Closure for func_1203
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1203
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1201_1202:
    // Closure for func_1201
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1201
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1197
cond_false_1196:
    adr x0, sign_id
cond_end_1197:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
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
    b.eq cond_false_1270
    b after_func_1275_1276
func_1275:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1277_1278
func_1277:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1279_1280
func_1279:
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
    b after_func_1281_1282
func_1281:
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
    b.ge cmp_true_1286
    adr x0, sign_id
    b cmp_end_1287
cmp_true_1286:
cmp_end_1287:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1284
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1289
    tst x1, #1
    b.eq do_concat_1289
do_apply_1288:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1290
do_concat_1289:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1290:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1292
    tst x1, #1
    b.eq do_concat_1292
do_apply_1291:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1293
do_concat_1292:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1293:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1301
    tst x1, #1
    b.eq do_concat_1301
do_apply_1300:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1302
do_concat_1301:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1302:
    b cond_end_1285
cond_false_1284:
    adr x0, sign_id
cond_end_1285:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1283
    b after_func_1303_1304
func_1303:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1303_1304:
    // Closure for func_1303
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1303
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1310
    adr x0, sign_id
    b cmp_end_1311
cmp_true_1310:
cmp_end_1311:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1308
    b or_end_1309
or_right_1308:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1312
    adr x0, sign_id
    b cmp_end_1313
cmp_true_1312:
cmp_end_1313:
or_end_1309:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1306
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1314
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1316
    tst x1, #1
    b.eq do_concat_1316
do_apply_1315:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1317
do_concat_1316:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1317:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1319
    tst x1, #1
    b.eq do_concat_1319
do_apply_1318:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1320
do_concat_1319:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1320:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1322
    tst x1, #1
    b.eq do_concat_1322
do_apply_1321:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1323
do_concat_1322:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1323:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1325
    tst x1, #1
    b.eq do_concat_1325
do_apply_1324:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1326
do_concat_1325:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1326:
blk_end_1314:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1328
    tst x1, #1
    b.eq do_concat_1328
do_apply_1327:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1329
do_concat_1328:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1329:
    b cond_end_1307
cond_false_1306:
    adr x0, sign_id
cond_end_1307:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1305
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1331
    tst x1, #1
    b.eq do_concat_1331
do_apply_1330:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1332
do_concat_1331:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1332:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1334
    tst x1, #1
    b.eq do_concat_1334
do_apply_1333:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1335
do_concat_1334:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1335:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1337
    tst x1, #1
    b.eq do_concat_1337
do_apply_1336:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1338
do_concat_1337:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1338:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1340
    tst x1, #1
    b.eq do_concat_1340
do_apply_1339:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1341
do_concat_1340:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1341:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1343
    tst x1, #1
    b.eq do_concat_1343
do_apply_1342:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1344
do_concat_1343:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1344:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1346
    tst x1, #1
    b.eq do_concat_1346
do_apply_1345:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1347
do_concat_1346:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1347:
blk_end_1305:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1349
    tst x1, #1
    b.eq do_concat_1349
do_apply_1348:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1350
do_concat_1349:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1350:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1283
    adr x0, nth
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1352
    tst x1, #1
    b.eq do_concat_1352
do_apply_1351:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1353
do_concat_1352:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1353:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1355
    tst x1, #1
    b.eq do_concat_1355
do_apply_1354:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1356
do_concat_1355:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1356:
blk_end_1283:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1281_1282:
    // Closure for func_1281
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
    adr x1, func_1281
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1279_1280:
    // Closure for func_1279
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
    adr x1, func_1279
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1277_1278:
    // Closure for func_1277
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1277
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1275_1276:
    // Closure for func_1275
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1275
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1271
cond_false_1270:
    adr x0, sign_id
cond_end_1271:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _parse_int
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1360
    tst x1, #1
    b.eq do_concat_1360
do_apply_1359:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1361
do_concat_1360:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1361:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1357
    b after_func_1362_1363
func_1362:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1362_1363:
    // Closure for func_1362
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1362
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1358
cond_false_1357:
    adr x0, sign_id
cond_end_1358:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Pure
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1365
    tst x1, #1
    b.eq do_concat_1365
do_apply_1364:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1366
do_concat_1365:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1366:
    str x0, [sp, #-16]!
    adr x0, Functional
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1368
    tst x1, #1
    b.eq do_concat_1368
do_apply_1367:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1369
do_concat_1368:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1369:
    str x0, [sp, #-16]!
    adr x0, Parser
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1371
    tst x1, #1
    b.eq do_concat_1371
do_apply_1370:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1372
do_concat_1371:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1372:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1376
    tst x1, #1
    b.eq do_concat_1376
do_apply_1375:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1377
do_concat_1376:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1377:
    str x0, [sp, #-16]!
    adr x0, state
    str x0, [sp, #-16]!
    adr x0, No
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1379
    tst x1, #1
    b.eq do_concat_1379
do_apply_1378:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1380
do_concat_1379:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1380:
    str x0, [sp, #-16]!
    adr x0, local
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1382
    tst x1, #1
    b.eq do_concat_1382
do_apply_1381:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1383
do_concat_1382:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1383:
    str x0, [sp, #-16]!
    adr x0, bindings
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1385
    tst x1, #1
    b.eq do_concat_1385
do_apply_1384:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1386
do_concat_1385:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1386:
    str x0, [sp, #-16]!
    adr x0, 
    str x0, [sp, #-16]!
    adr x0, Logic
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1388
    tst x1, #1
    b.eq do_concat_1388
do_apply_1387:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1389
do_concat_1388:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1389:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1373
    adr x0, tokens
    b cond_end_1374
cond_false_1373:
    adr x0, sign_id
cond_end_1374:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, -
    str x0, [sp, #-16]!
    adr x0, >
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1391
    tst x1, #1
    b.eq do_concat_1391
do_apply_1390:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1392
do_concat_1391:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1392:
    str x0, [sp, #-16]!
    adr x0, ast_node
    str x0, [sp, #-16]!
    adr x0, remaining_tokens
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1394
    tst x1, #1
    b.eq do_concat_1394
do_apply_1393:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1395
do_concat_1394:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1395:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1399
    tst x1, #1
    b.eq do_concat_1399
do_apply_1398:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1400
do_concat_1399:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1400:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1396
    b after_func_1401_1402
func_1401:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
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
    b cond_end_1397
cond_false_1396:
    adr x0, sign_id
cond_end_1397:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tok_val
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1406
    tst x1, #1
    b.eq do_concat_1406
do_apply_1405:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1407
do_concat_1406:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1407:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1403
    b after_func_1408_1409
func_1408:
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
after_func_1408_1409:
    // Closure for func_1408
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1408
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1404
cond_false_1403:
    adr x0, sign_id
cond_end_1404:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, streq
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1413
    tst x1, #1
    b.eq do_concat_1413
do_apply_1412:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1414
do_concat_1413:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1414:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1410
    b after_func_1415_1416
func_1415:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1417_1418
func_1417:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1420_1421
func_1420:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1420_1421:
    // Closure for func_1420
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1420
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1423_1424
func_1423:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1423_1424:
    // Closure for func_1423
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1423
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c1
    str x0, [sp, #-16]!
    adr x0, c2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1428
    adr x0, sign_id
    b cmp_end_1429
cmp_true_1428:
cmp_end_1429:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1426
    mov x0, #0
    b cond_end_1427
cond_false_1426:
    adr x0, sign_id
cond_end_1427:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1425
    adr x0, c1
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1432
    adr x0, sign_id
    b cmp_end_1433
cmp_true_1432:
cmp_end_1433:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1430
    mov x0, #1
    b cond_end_1431
cond_false_1430:
    adr x0, sign_id
cond_end_1431:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1425
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
    b.lo do_concat_1435
    tst x1, #1
    b.eq do_concat_1435
do_apply_1434:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1436
do_concat_1435:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1436:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1438
    tst x1, #1
    b.eq do_concat_1438
do_apply_1437:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1439
do_concat_1438:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1439:
blk_end_1425:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1441
    tst x1, #1
    b.eq do_concat_1441
do_apply_1440:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1442
do_concat_1441:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1442:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1422
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_1422:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1444
    tst x1, #1
    b.eq do_concat_1444
do_apply_1443:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1445
do_concat_1444:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1445:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1419
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
blk_end_1419:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1417_1418:
    // Closure for func_1417
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1417
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1415_1416:
    // Closure for func_1415
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1415
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1411
cond_false_1410:
    adr x0, sign_id
cond_end_1411:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_prec
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1446
    b after_func_1451_1452
func_1451:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1457
    tst x1, #1
    b.eq do_concat_1457
do_apply_1456:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1458
do_concat_1457:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1458:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1460
    tst x1, #1
    b.eq do_concat_1460
do_apply_1459:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1461
do_concat_1460:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1461:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1454
    mov x0, #15
    b cond_end_1455
cond_false_1454:
    adr x0, sign_id
cond_end_1455:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1465
    tst x1, #1
    b.eq do_concat_1465
do_apply_1464:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1466
do_concat_1465:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1466:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1468
    tst x1, #1
    b.eq do_concat_1468
do_apply_1467:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1469
do_concat_1468:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1469:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1462
    mov x0, #15
    b cond_end_1463
cond_false_1462:
    adr x0, sign_id
cond_end_1463:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1473
    tst x1, #1
    b.eq do_concat_1473
do_apply_1472:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1474
do_concat_1473:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1474:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1476
    tst x1, #1
    b.eq do_concat_1476
do_apply_1475:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1477
do_concat_1476:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1477:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1470
    mov x0, #16
    b cond_end_1471
cond_false_1470:
    adr x0, sign_id
cond_end_1471:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1481
    tst x1, #1
    b.eq do_concat_1481
do_apply_1480:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1482
do_concat_1481:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1482:
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1484
    tst x1, #1
    b.eq do_concat_1484
do_apply_1483:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1485
do_concat_1484:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1485:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1478
    mov x0, #16
    b cond_end_1479
cond_false_1478:
    adr x0, sign_id
cond_end_1479:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov x0, #37
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1486
    mov x0, #16
    b cond_end_1487
cond_false_1486:
    adr x0, sign_id
cond_end_1487:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1497
    tst x1, #1
    b.eq do_concat_1497
do_apply_1496:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1498
do_concat_1497:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1498:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1500
    tst x1, #1
    b.eq do_concat_1500
do_apply_1499:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1501
do_concat_1500:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1501:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1494
    mov x0, #2
    b cond_end_1495
cond_false_1494:
    adr x0, sign_id
cond_end_1495:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1505
    tst x1, #1
    b.eq do_concat_1505
do_apply_1504:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1506
do_concat_1505:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1506:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1508
    tst x1, #1
    b.eq do_concat_1508
do_apply_1507:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1509
do_concat_1508:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1509:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1502
    mov x0, #5
    b cond_end_1503
cond_false_1502:
    adr x0, sign_id
cond_end_1503:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1513
    tst x1, #1
    b.eq do_concat_1513
do_apply_1512:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1514
do_concat_1513:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1514:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1516
    tst x1, #1
    b.eq do_concat_1516
do_apply_1515:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1517
do_concat_1516:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1517:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1510
    mov x0, #6
    b cond_end_1511
cond_false_1510:
    adr x0, sign_id
cond_end_1511:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    mov x0, #61
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1518
    mov x0, #14
    b cond_end_1519
cond_false_1518:
    adr x0, sign_id
cond_end_1519:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1529
    tst x1, #1
    b.eq do_concat_1529
do_apply_1528:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1530
do_concat_1529:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1530:
    str x0, [sp, #-16]!
    adr x0, str_4
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1532
    tst x1, #1
    b.eq do_concat_1532
do_apply_1531:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1533
do_concat_1532:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1533:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1526
    mov x0, #14
    b cond_end_1527
cond_false_1526:
    adr x0, sign_id
cond_end_1527:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1537
    tst x1, #1
    b.eq do_concat_1537
do_apply_1536:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1538
do_concat_1537:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1538:
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1540
    tst x1, #1
    b.eq do_concat_1540
do_apply_1539:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1541
do_concat_1540:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1541:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1534
    mov x0, #14
    b cond_end_1535
cond_false_1534:
    adr x0, sign_id
cond_end_1535:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1545
    tst x1, #1
    b.eq do_concat_1545
do_apply_1544:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1546
do_concat_1545:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1546:
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1548
    tst x1, #1
    b.eq do_concat_1548
do_apply_1547:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1549
do_concat_1548:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1549:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1542
    mov x0, #14
    b cond_end_1543
cond_false_1542:
    adr x0, sign_id
cond_end_1543:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1553
    tst x1, #1
    b.eq do_concat_1553
do_apply_1552:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1554
do_concat_1553:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1554:
    str x0, [sp, #-16]!
    adr x0, str_5
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1556
    tst x1, #1
    b.eq do_concat_1556
do_apply_1555:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1557
do_concat_1556:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1557:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1550
    mov x0, #14
    b cond_end_1551
cond_false_1550:
    adr x0, sign_id
cond_end_1551:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1561
    tst x1, #1
    b.eq do_concat_1561
do_apply_1560:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1562
do_concat_1561:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1562:
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1564
    tst x1, #1
    b.eq do_concat_1564
do_apply_1563:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1565
do_concat_1564:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1565:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1558
    mov x0, #14
    b cond_end_1559
cond_false_1558:
    adr x0, sign_id
cond_end_1559:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1569
    tst x1, #1
    b.eq do_concat_1569
do_apply_1568:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1570
do_concat_1569:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1570:
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1572
    tst x1, #1
    b.eq do_concat_1572
do_apply_1571:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1573
do_concat_1572:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1573:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1566
    mov x0, #14
    b cond_end_1567
cond_false_1566:
    adr x0, sign_id
cond_end_1567:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1453
    mov x0, #0
blk_end_1453:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1451_1452:
    // Closure for func_1451
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1451
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1447
cond_false_1446:
    adr x0, sign_id
cond_end_1447:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_right_assoc
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1577
    tst x1, #1
    b.eq do_concat_1577
do_apply_1576:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1578
do_concat_1577:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1578:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1574
    b after_func_1579_1580
func_1579:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    mov x0, #58
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1582
    mov x0, #1
    b cond_end_1583
cond_false_1582:
    adr x0, sign_id
cond_end_1583:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1581
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1593
    tst x1, #1
    b.eq do_concat_1593
do_apply_1592:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1594
do_concat_1593:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1594:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1596
    tst x1, #1
    b.eq do_concat_1596
do_apply_1595:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1597
do_concat_1596:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1597:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1590
    mov x0, #1
    b cond_end_1591
cond_false_1590:
    adr x0, sign_id
cond_end_1591:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1581
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1601
    tst x1, #1
    b.eq do_concat_1601
do_apply_1600:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1602
do_concat_1601:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1602:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1604
    tst x1, #1
    b.eq do_concat_1604
do_apply_1603:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1605
do_concat_1604:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1605:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1598
    mov x0, #1
    b cond_end_1599
cond_false_1598:
    adr x0, sign_id
cond_end_1599:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1581
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1609
    tst x1, #1
    b.eq do_concat_1609
do_apply_1608:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1610
do_concat_1609:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1610:
    str x0, [sp, #-16]!
    mov x0, #94
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1612
    tst x1, #1
    b.eq do_concat_1612
do_apply_1611:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1613
do_concat_1612:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1613:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1606
    mov x0, #1
    b cond_end_1607
cond_false_1606:
    adr x0, sign_id
cond_end_1607:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1581
    mov x0, #0
blk_end_1581:
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
    b cond_end_1575
cond_false_1574:
    adr x0, sign_id
cond_end_1575:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, peek
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1617
    tst x1, #1
    b.eq do_concat_1617
do_apply_1616:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1618
do_concat_1617:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1618:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1614
    b after_func_1619_1620
func_1619:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1624
    adr x0, sign_id
    b cmp_end_1625
cmp_true_1624:
cmp_end_1625:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1622
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1627
    tst x1, #1
    b.eq do_concat_1627
do_apply_1626:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1628
do_concat_1627:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1628:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1630
    tst x1, #1
    b.eq do_concat_1630
do_apply_1629:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1631
do_concat_1630:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1631:
    b cond_end_1623
cond_false_1622:
    adr x0, sign_id
cond_end_1623:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1621
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1633
    tst x1, #1
    b.eq do_concat_1633
do_apply_1632:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1634
do_concat_1633:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1634:
blk_end_1621:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1619_1620:
    // Closure for func_1619
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1619
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1615
cond_false_1614:
    adr x0, sign_id
cond_end_1615:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, next
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1635
    b after_func_1640_1641
func_1640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1645
    adr x0, sign_id
    b cmp_end_1646
cmp_true_1645:
cmp_end_1646:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1643
    mov x0, #0
    b cond_end_1644
cond_false_1643:
    adr x0, sign_id
cond_end_1644:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1642
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1648
    tst x1, #1
    b.eq do_concat_1648
do_apply_1647:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1649
do_concat_1648:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1649:
blk_end_1642:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1640_1641:
    // Closure for func_1640
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1640
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1636
cond_false_1635:
    adr x0, sign_id
cond_end_1636:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expect
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1650
    b after_func_1655_1656
func_1655:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1657_1658
func_1657:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1660_1661
func_1660:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1660_1661:
    // Closure for func_1660
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1660
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1663_1664
func_1663:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1663_1664:
    // Closure for func_1663
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1663
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tok_t
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1668
    adr x0, sign_id
    b cmp_end_1669
cmp_true_1668:
cmp_end_1669:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1666
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1671
    tst x1, #1
    b.eq do_concat_1671
do_apply_1670:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1672
do_concat_1671:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1672:
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1674
    tst x1, #1
    b.eq do_concat_1674
do_apply_1673:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1675
do_concat_1674:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1675:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1677
    tst x1, #1
    b.eq do_concat_1677
do_apply_1676:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1678
do_concat_1677:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1678:
    b cond_end_1667
cond_false_1666:
    adr x0, sign_id
cond_end_1667:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1665
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1680
    tst x1, #1
    b.eq do_concat_1680
do_apply_1679:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1681
do_concat_1680:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1681:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1683
    tst x1, #1
    b.eq do_concat_1683
do_apply_1682:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1684
do_concat_1683:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1684:
blk_end_1665:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1686
    tst x1, #1
    b.eq do_concat_1686
do_apply_1685:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1687
do_concat_1686:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1687:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1662
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1689
    tst x1, #1
    b.eq do_concat_1689
do_apply_1688:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1690
do_concat_1689:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1690:
blk_end_1662:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1692
    tst x1, #1
    b.eq do_concat_1692
do_apply_1691:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1693
do_concat_1692:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1693:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1659
    adr x0, peek
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1695
    tst x1, #1
    b.eq do_concat_1695
do_apply_1694:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1696
do_concat_1695:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1696:
blk_end_1659:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1657_1658:
    // Closure for func_1657
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1657
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1655_1656:
    // Closure for func_1655
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1655
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1651
cond_false_1650:
    adr x0, sign_id
cond_end_1651:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_program
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1700
    tst x1, #1
    b.eq do_concat_1700
do_apply_1699:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1701
do_concat_1700:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1701:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1697
    b after_func_1702_1703
func_1702:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1705_1706
func_1705:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1705_1706:
    // Closure for func_1705
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1705
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1708
    tst x1, #1
    b.eq do_concat_1708
do_apply_1707:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1709
do_concat_1708:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1709:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1711
    tst x1, #1
    b.eq do_concat_1711
do_apply_1710:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1712
do_concat_1711:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1712:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1714
    tst x1, #1
    b.eq do_concat_1714
do_apply_1713:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1715
do_concat_1714:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1715:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1717
    tst x1, #1
    b.eq do_concat_1717
do_apply_1716:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1718
do_concat_1717:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1718:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1720
    tst x1, #1
    b.eq do_concat_1720
do_apply_1719:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1721
do_concat_1720:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1721:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1723
    tst x1, #1
    b.eq do_concat_1723
do_apply_1722:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1724
do_concat_1723:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1724:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1726
    tst x1, #1
    b.eq do_concat_1726
do_apply_1725:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1727
do_concat_1726:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1727:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1729
    tst x1, #1
    b.eq do_concat_1729
do_apply_1728:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1730
do_concat_1729:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1730:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1732
    tst x1, #1
    b.eq do_concat_1732
do_apply_1731:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1733
do_concat_1732:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1733:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1735
    tst x1, #1
    b.eq do_concat_1735
do_apply_1734:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1736
do_concat_1735:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1736:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1704
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1738
    tst x1, #1
    b.eq do_concat_1738
do_apply_1737:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1739
do_concat_1738:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1739:
blk_end_1704:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1702_1703:
    // Closure for func_1702
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1702
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1698
cond_false_1697:
    adr x0, sign_id
cond_end_1698:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1743
    tst x1, #1
    b.eq do_concat_1743
do_apply_1742:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1744
do_concat_1743:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1744:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1740
    b after_func_1745_1746
func_1745:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1748_1749
func_1748:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1748_1749:
    // Closure for func_1748
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1748
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1751_1752
func_1751:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1751_1752:
    // Closure for func_1751
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1751
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
    b.eq cmp_true_1756
    adr x0, sign_id
    b cmp_end_1757
cmp_true_1756:
cmp_end_1757:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1754
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1759
    tst x1, #1
    b.eq do_concat_1759
do_apply_1758:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1760
do_concat_1759:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1760:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1762
    tst x1, #1
    b.eq do_concat_1762
do_apply_1761:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1763
do_concat_1762:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1763:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1765
    tst x1, #1
    b.eq do_concat_1765
do_apply_1764:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1766
do_concat_1765:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1766:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1768
    tst x1, #1
    b.eq do_concat_1768
do_apply_1767:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1769
do_concat_1768:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1769:
    b cond_end_1755
cond_false_1754:
    adr x0, sign_id
cond_end_1755:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1753
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1772
    adr x0, sign_id
    b cmp_end_1773
cmp_true_1772:
cmp_end_1773:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1770
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1775
    tst x1, #1
    b.eq do_concat_1775
do_apply_1774:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1776
do_concat_1775:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1776:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1778
    tst x1, #1
    b.eq do_concat_1778
do_apply_1777:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1779
do_concat_1778:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1779:
    b cond_end_1771
cond_false_1770:
    adr x0, sign_id
cond_end_1771:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1753
    adr x0, str_8
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1753
    b after_func_1780_1781
func_1780:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1780_1781:
    // Closure for func_1780
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1780
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1783_1784
func_1783:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1783_1784:
    // Closure for func_1783
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1783
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1786_1787
func_1786:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1786_1787:
    // Closure for func_1786
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1786
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1789_1790
func_1789:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1789_1790:
    // Closure for func_1789
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1789
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1792
    tst x1, #1
    b.eq do_concat_1792
do_apply_1791:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1793
do_concat_1792:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1793:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1795
    tst x1, #1
    b.eq do_concat_1795
do_apply_1794:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1796
do_concat_1795:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1796:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1798
    tst x1, #1
    b.eq do_concat_1798
do_apply_1797:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1799
do_concat_1798:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1799:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1801
    tst x1, #1
    b.eq do_concat_1801
do_apply_1800:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1802
do_concat_1801:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1802:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1804
    tst x1, #1
    b.eq do_concat_1804
do_apply_1803:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1805
do_concat_1804:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1805:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1807
    tst x1, #1
    b.eq do_concat_1807
do_apply_1806:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1808
do_concat_1807:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1808:
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1813
    tst x1, #1
    b.eq do_concat_1813
do_apply_1812:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1814
do_concat_1813:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1814:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1816
    tst x1, #1
    b.eq do_concat_1816
do_apply_1815:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1817
do_concat_1816:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1817:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1819
    tst x1, #1
    b.eq do_concat_1819
do_apply_1818:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1820
do_concat_1819:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1820:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1788
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1822
    tst x1, #1
    b.eq do_concat_1822
do_apply_1821:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1823
do_concat_1822:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1823:
blk_end_1788:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1825
    tst x1, #1
    b.eq do_concat_1825
do_apply_1824:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1826
do_concat_1825:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1826:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1785
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1828
    tst x1, #1
    b.eq do_concat_1828
do_apply_1827:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1829
do_concat_1828:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1829:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1831
    tst x1, #1
    b.eq do_concat_1831
do_apply_1830:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1832
do_concat_1831:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1832:
blk_end_1785:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1834
    tst x1, #1
    b.eq do_concat_1834
do_apply_1833:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1835
do_concat_1834:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1835:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1782
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1837
    tst x1, #1
    b.eq do_concat_1837
do_apply_1836:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1838
do_concat_1837:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1838:
blk_end_1782:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1840
    tst x1, #1
    b.eq do_concat_1840
do_apply_1839:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1841
do_concat_1840:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1841:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1753
    adr x0, parse_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1843
    tst x1, #1
    b.eq do_concat_1843
do_apply_1842:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1844
do_concat_1843:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1844:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1846
    tst x1, #1
    b.eq do_concat_1846
do_apply_1845:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1847
do_concat_1846:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1847:
blk_end_1753:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1849
    tst x1, #1
    b.eq do_concat_1849
do_apply_1848:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1850
do_concat_1849:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1850:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1750
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1852
    tst x1, #1
    b.eq do_concat_1852
do_apply_1851:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1853
do_concat_1852:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1853:
blk_end_1750:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1855
    tst x1, #1
    b.eq do_concat_1855
do_apply_1854:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1856
do_concat_1855:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1856:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1747
    adr x0, peek
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1858
    tst x1, #1
    b.eq do_concat_1858
do_apply_1857:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1859
do_concat_1858:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1859:
blk_end_1747:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1745_1746:
    // Closure for func_1745
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1745
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1741
cond_false_1740:
    adr x0, sign_id
cond_end_1741:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1860
    b after_func_1865_1866
func_1865:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_9
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1867
    adr x0, parse_program
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x0, str_10
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
blk_end_1867:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1865_1866:
    // Closure for func_1865
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1865
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1861
cond_false_1860:
    adr x0, sign_id
cond_end_1861:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1877
    tst x1, #1
    b.eq do_concat_1877
do_apply_1876:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1878
do_concat_1877:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1878:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1874
    b after_func_1879_1880
func_1879:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1881_1882
func_1881:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1884_1885
func_1884:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1884_1885:
    // Closure for func_1884
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1884
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1887_1888
func_1887:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1887_1888:
    // Closure for func_1887
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1887
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1890_1891
func_1890:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1890_1891:
    // Closure for func_1890
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1890
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, lhs
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
    adr x0, rest_1
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1902
    tst x1, #1
    b.eq do_concat_1902
do_apply_1901:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1903
do_concat_1902:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1903:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1889
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_lhs
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
blk_end_1889:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1886
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_lhs
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
blk_end_1886:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1883
    adr x0, parse_primary
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
blk_end_1883:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1881_1882:
    // Closure for func_1881
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1881
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1879_1880:
    // Closure for func_1879
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1879
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1875
cond_false_1874:
    adr x0, sign_id
cond_end_1875:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1925
    tst x1, #1
    b.eq do_concat_1925
do_apply_1924:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1926
do_concat_1925:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1926:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1922
    b after_func_1927_1928
func_1927:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1929_1930
func_1929:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1931_1932
func_1931:
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
    b after_func_1934_1935
func_1934:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1934_1935:
    // Closure for func_1934
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1934
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1937_1938
func_1937:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1937_1938:
    // Closure for func_1937
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1937
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_11
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1939
    adr x0, can_start_expr
    str x0, [sp, #-16]!
    adr x0, type
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1943
    tst x1, #1
    b.eq do_concat_1943
do_apply_1942:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1944
do_concat_1943:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1944:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1940
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_12
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1945
    b after_func_1946_1947
func_1946:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1946_1947:
    // Closure for func_1946
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1946
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1949_1950
func_1949:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    b after_func_1952_1953
func_1952:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1952_1953:
    // Closure for func_1952
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1952
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1955_1956
func_1955:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1955_1956:
    // Closure for func_1955
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1955
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, new_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1958
    tst x1, #1
    b.eq do_concat_1958
do_apply_1957:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1959
do_concat_1958:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1959:
    str x0, [sp, #-16]!
    adr x0, rest_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1961
    tst x1, #1
    b.eq do_concat_1961
do_apply_1960:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1962
do_concat_1961:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1962:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1964
    tst x1, #1
    b.eq do_concat_1964
do_apply_1963:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1965
do_concat_1964:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1965:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1967
    tst x1, #1
    b.eq do_concat_1967
do_apply_1966:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1968
do_concat_1967:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1968:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1954
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1970
    tst x1, #1
    b.eq do_concat_1970
do_apply_1969:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1971
do_concat_1970:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1971:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1973
    tst x1, #1
    b.eq do_concat_1973
do_apply_1972:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1974
do_concat_1973:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1974:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1976
    tst x1, #1
    b.eq do_concat_1976
do_apply_1975:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1977
do_concat_1976:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1977:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1979
    tst x1, #1
    b.eq do_concat_1979
do_apply_1978:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1980
do_concat_1979:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1980:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1982
    tst x1, #1
    b.eq do_concat_1982
do_apply_1981:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1983
do_concat_1982:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1983:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1985
    tst x1, #1
    b.eq do_concat_1985
do_apply_1984:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1986
do_concat_1985:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1986:
blk_end_1954:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1988
    tst x1, #1
    b.eq do_concat_1988
do_apply_1987:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1989
do_concat_1988:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1989:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1951
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1991
    tst x1, #1
    b.eq do_concat_1991
do_apply_1990:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1992
do_concat_1991:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1992:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1994
    tst x1, #1
    b.eq do_concat_1994
do_apply_1993:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1995
do_concat_1994:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1995:
blk_end_1951:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1997
    tst x1, #1
    b.eq do_concat_1997
do_apply_1996:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1998
do_concat_1997:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1998:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1948
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2000
    tst x1, #1
    b.eq do_concat_2000
do_apply_1999:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2001
do_concat_2000:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2001:
blk_end_1948:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2003
    tst x1, #1
    b.eq do_concat_2003
do_apply_2002:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2004
do_concat_2003:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2004:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1945
    adr x0, parse_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2006
    tst x1, #1
    b.eq do_concat_2006
do_apply_2005:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2007
do_concat_2006:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2007:
    str x0, [sp, #-16]!
    mov x0, #6
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2009
    tst x1, #1
    b.eq do_concat_2009
do_apply_2008:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2010
do_concat_2009:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2010:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1945
    adr x0, str_13
blk_end_1945:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2012
    tst x1, #1
    b.eq do_concat_2012
do_apply_2011:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2013
do_concat_2012:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2013:
    b cond_end_1941
cond_false_1940:
    adr x0, sign_id
cond_end_1941:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1939
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_2016
    adr x0, sign_id
    b cmp_end_2017
cmp_true_2016:
cmp_end_2017:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2014
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    mov x0, #0
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
    b cond_end_2015
cond_false_2014:
    adr x0, sign_id
cond_end_2015:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1939
    b after_func_2030_2031
func_2030:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2030_2031:
    // Closure for func_2030
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2030
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
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
    adr x0, prec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_2038
    adr x0, sign_id
    b cmp_end_2039
cmp_true_2038:
cmp_end_2039:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2036
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2041
    tst x1, #1
    b.eq do_concat_2041
do_apply_2040:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2042
do_concat_2041:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2042:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2044
    tst x1, #1
    b.eq do_concat_2044
do_apply_2043:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2045
do_concat_2044:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2045:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2047
    tst x1, #1
    b.eq do_concat_2047
do_apply_2046:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2048
do_concat_2047:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2048:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2050
    tst x1, #1
    b.eq do_concat_2050
do_apply_2049:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2051
do_concat_2050:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2051:
    b cond_end_2037
cond_false_2036:
    adr x0, sign_id
cond_end_2037:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2035
    b after_func_2052_2053
func_2052:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2052_2053:
    // Closure for func_2052
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2052
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2055_2056
func_2055:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2055_2056:
    // Closure for func_2055
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2055
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2058_2059
func_2058:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2058_2059:
    // Closure for func_2058
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2058
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2061_2062
func_2061:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2061_2062:
    // Closure for func_2061
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2061
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2064_2065
func_2064:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2064_2065:
    // Closure for func_2064
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2064
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2067_2068
func_2067:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2067_2068:
    // Closure for func_2067
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2067
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, new_lhs
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
    adr x0, rest_rhs
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
    ldr x0, [x29, #-32]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2066
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2082
    tst x1, #1
    b.eq do_concat_2082
do_apply_2081:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2083
do_concat_2082:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2083:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op_str
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
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
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
    mov x0, #0
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
blk_end_2066:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2063
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2112
    tst x1, #1
    b.eq do_concat_2112
do_apply_2111:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2113
do_concat_2112:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2113:
blk_end_2063:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2115
    tst x1, #1
    b.eq do_concat_2115
do_apply_2114:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2116
do_concat_2115:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2116:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2060
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2118
    tst x1, #1
    b.eq do_concat_2118
do_apply_2117:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2119
do_concat_2118:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2119:
blk_end_2060:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2121
    tst x1, #1
    b.eq do_concat_2121
do_apply_2120:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2122
do_concat_2121:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2122:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2057
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, next_tokens
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2124
    tst x1, #1
    b.eq do_concat_2124
do_apply_2123:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2125
do_concat_2124:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2125:
    str x0, [sp, #-16]!
    adr x0, next_min_prec
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
blk_end_2057:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2054
    b after_func_2132_2133
func_2132:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2134_2135
func_2134:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, prec
    str x0, [sp, #-16]!
    adr x0, prec
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2137
    tst x1, #1
    b.eq do_concat_2137
do_apply_2136:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2138
do_concat_2137:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2138:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2134_2135:
    // Closure for func_2134
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2134
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2132_2133:
    // Closure for func_2132
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2132
    ldr x0, [sp], #16
    bl _cons
blk_end_2054:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2140
    tst x1, #1
    b.eq do_concat_2140
do_apply_2139:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2141
do_concat_2140:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2141:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2035
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2143
    tst x1, #1
    b.eq do_concat_2143
do_apply_2142:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2144
do_concat_2143:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2144:
blk_end_2035:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2146
    tst x1, #1
    b.eq do_concat_2146
do_apply_2145:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2147
do_concat_2146:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2147:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2032
    adr x0, get_prec
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2149
    tst x1, #1
    b.eq do_concat_2149
do_apply_2148:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2150
do_concat_2149:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2150:
blk_end_2032:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1939
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
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
blk_end_1939:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2158
    tst x1, #1
    b.eq do_concat_2158
do_apply_2157:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2159
do_concat_2158:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2159:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1936
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2161
    tst x1, #1
    b.eq do_concat_2161
do_apply_2160:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2162
do_concat_2161:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2162:
blk_end_1936:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2164
    tst x1, #1
    b.eq do_concat_2164
do_apply_2163:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2165
do_concat_2164:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2165:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1933
    adr x0, peek
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2167
    tst x1, #1
    b.eq do_concat_2167
do_apply_2166:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2168
do_concat_2167:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2168:
blk_end_1933:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1931_1932:
    // Closure for func_1931
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
    adr x1, func_1931
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1929_1930:
    // Closure for func_1929
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1929
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1927_1928:
    // Closure for func_1927
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1927
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1923
cond_false_1922:
    adr x0, sign_id
cond_end_1923:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, can_start_expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2172
    tst x1, #1
    b.eq do_concat_2172
do_apply_2171:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2173
do_concat_2172:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2173:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2169
    b after_func_2174_2175
func_2174:
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
    b.eq cmp_true_2179
    adr x0, sign_id
    b cmp_end_2180
cmp_true_2179:
cmp_end_2180:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2177
    mov x0, #1
    b cond_end_2178
cond_false_2177:
    adr x0, sign_id
cond_end_2178:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2176
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2183
    adr x0, sign_id
    b cmp_end_2184
cmp_true_2183:
cmp_end_2184:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2181
    mov x0, #1
    b cond_end_2182
cond_false_2181:
    adr x0, sign_id
cond_end_2182:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2176
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2187
    adr x0, sign_id
    b cmp_end_2188
cmp_true_2187:
cmp_end_2188:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2185
    mov x0, #1
    b cond_end_2186
cond_false_2185:
    adr x0, sign_id
cond_end_2186:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2176
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2191
    adr x0, sign_id
    b cmp_end_2192
cmp_true_2191:
cmp_end_2192:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2189
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #40
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2194
    tst x1, #1
    b.eq do_concat_2194
do_apply_2193:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2195
do_concat_2194:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2195:
    b cond_end_2190
cond_false_2189:
    adr x0, sign_id
cond_end_2190:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2176
    mov x0, #0
blk_end_2176:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2174_2175:
    // Closure for func_2174
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2174
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2170
cond_false_2169:
    adr x0, sign_id
cond_end_2170:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_prefix_op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2199
    tst x1, #1
    b.eq do_concat_2199
do_apply_2198:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2200
do_concat_2199:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2200:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2196
    b after_func_2201_2202
func_2201:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2207
    tst x1, #1
    b.eq do_concat_2207
do_apply_2206:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2208
do_concat_2207:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2208:
    str x0, [sp, #-16]!
    mov x0, #33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2210
    tst x1, #1
    b.eq do_concat_2210
do_apply_2209:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2211
do_concat_2210:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2211:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2204
    mov x0, #1
    b cond_end_2205
cond_false_2204:
    adr x0, sign_id
cond_end_2205:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2203
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov x0, #35
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2212
    mov x0, #1
    b cond_end_2213
cond_false_2212:
    adr x0, sign_id
cond_end_2213:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2203
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2223
    tst x1, #1
    b.eq do_concat_2223
do_apply_2222:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2224
do_concat_2223:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2224:
    str x0, [sp, #-16]!
    mov x0, #36
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2226
    tst x1, #1
    b.eq do_concat_2226
do_apply_2225:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2227
do_concat_2226:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2227:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2220
    mov x0, #1
    b cond_end_2221
cond_false_2220:
    adr x0, sign_id
cond_end_2221:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2203
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov x0, #64
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2228
    mov x0, #1
    b cond_end_2229
cond_false_2228:
    adr x0, sign_id
cond_end_2229:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2203
    mov x0, #0
blk_end_2203:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2201_2202:
    // Closure for func_2201
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2201
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2197
cond_false_2196:
    adr x0, sign_id
cond_end_2197:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_primary
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2239
    tst x1, #1
    b.eq do_concat_2239
do_apply_2238:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2240
do_concat_2239:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2240:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2236
    b after_func_2241_2242
func_2241:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2244_2245
func_2244:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2244_2245:
    // Closure for func_2244
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2244
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2247_2248
func_2247:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2247_2248:
    // Closure for func_2247
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2247
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2250_2251
func_2250:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2250_2251:
    // Closure for func_2250
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2250
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
    b.eq cmp_true_2255
    adr x0, sign_id
    b cmp_end_2256
cmp_true_2255:
cmp_end_2256:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2253
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_2258_2259
func_2258:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2258_2259:
    // Closure for func_2258
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2258
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2261
    tst x1, #1
    b.eq do_concat_2261
do_apply_2260:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2262
do_concat_2261:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2262:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2267
    tst x1, #1
    b.eq do_concat_2267
do_apply_2266:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2268
do_concat_2267:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2268:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2270
    tst x1, #1
    b.eq do_concat_2270
do_apply_2269:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2271
do_concat_2270:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2271:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2273
    tst x1, #1
    b.eq do_concat_2273
do_apply_2272:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2274
do_concat_2273:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2274:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2276
    tst x1, #1
    b.eq do_concat_2276
do_apply_2275:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2277
do_concat_2276:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2277:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2279
    tst x1, #1
    b.eq do_concat_2279
do_apply_2278:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2280
do_concat_2279:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2280:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2282
    tst x1, #1
    b.eq do_concat_2282
do_apply_2281:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2283
do_concat_2282:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2283:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2285
    tst x1, #1
    b.eq do_concat_2285
do_apply_2284:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2286
do_concat_2285:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2286:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2257
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2288
    tst x1, #1
    b.eq do_concat_2288
do_apply_2287:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2289
do_concat_2288:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2289:
blk_end_2257:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2291
    tst x1, #1
    b.eq do_concat_2291
do_apply_2290:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2292
do_concat_2291:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2292:
    b cond_end_2254
cond_false_2253:
    adr x0, sign_id
cond_end_2254:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2252
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2295
    adr x0, sign_id
    b cmp_end_2296
cmp_true_2295:
cmp_end_2296:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2293
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_2298_2299
func_2298:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2298_2299:
    // Closure for func_2298
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2298
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
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
    mov x0, #0
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
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
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2297
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
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
blk_end_2297:
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
    b cond_end_2294
cond_false_2293:
    adr x0, sign_id
cond_end_2294:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2252
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2335
    adr x0, sign_id
    b cmp_end_2336
cmp_true_2335:
cmp_end_2336:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2333
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_2338_2339
func_2338:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2341
    tst x1, #1
    b.eq do_concat_2341
do_apply_2340:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2342
do_concat_2341:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2342:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2344
    tst x1, #1
    b.eq do_concat_2344
do_apply_2343:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2345
do_concat_2344:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2345:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2347
    tst x1, #1
    b.eq do_concat_2347
do_apply_2346:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2348
do_concat_2347:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2348:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2350
    tst x1, #1
    b.eq do_concat_2350
do_apply_2349:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2351
do_concat_2350:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2351:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2353
    tst x1, #1
    b.eq do_concat_2353
do_apply_2352:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2354
do_concat_2353:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2354:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2356
    tst x1, #1
    b.eq do_concat_2356
do_apply_2355:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2357
do_concat_2356:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2357:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2359
    tst x1, #1
    b.eq do_concat_2359
do_apply_2358:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2360
do_concat_2359:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2360:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2362
    tst x1, #1
    b.eq do_concat_2362
do_apply_2361:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2363
do_concat_2362:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2363:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2365
    tst x1, #1
    b.eq do_concat_2365
do_apply_2364:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2366
do_concat_2365:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2366:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2337
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2368
    tst x1, #1
    b.eq do_concat_2368
do_apply_2367:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2369
do_concat_2368:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2369:
blk_end_2337:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2371
    tst x1, #1
    b.eq do_concat_2371
do_apply_2370:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2372
do_concat_2371:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2372:
    b cond_end_2334
cond_false_2333:
    adr x0, sign_id
cond_end_2334:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2252
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2375
    adr x0, sign_id
    b cmp_end_2376
cmp_true_2375:
cmp_end_2376:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2373
    adr x0, sign_id
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
    adr x0, is_prefix_op
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2384
    tst x1, #1
    b.eq do_concat_2384
do_apply_2383:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2385
do_concat_2384:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2385:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2381
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_14
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2386
    b after_func_2387_2388
func_2387:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2387_2388:
    // Closure for func_2387
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2387
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_prefix
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2390
    tst x1, #1
    b.eq do_concat_2390
do_apply_2389:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2391
do_concat_2390:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2391:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2393
    tst x1, #1
    b.eq do_concat_2393
do_apply_2392:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2394
do_concat_2393:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2394:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2405
    tst x1, #1
    b.eq do_concat_2405
do_apply_2404:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2406
do_concat_2405:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2406:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2408
    tst x1, #1
    b.eq do_concat_2408
do_apply_2407:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2409
do_concat_2408:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2409:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2411
    tst x1, #1
    b.eq do_concat_2411
do_apply_2410:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2412
do_concat_2411:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2412:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2414
    tst x1, #1
    b.eq do_concat_2414
do_apply_2413:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2415
do_concat_2414:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2415:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2417
    tst x1, #1
    b.eq do_concat_2417
do_apply_2416:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2418
do_concat_2417:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2418:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2420
    tst x1, #1
    b.eq do_concat_2420
do_apply_2419:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2421
do_concat_2420:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2421:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2423
    tst x1, #1
    b.eq do_concat_2423
do_apply_2422:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2424
do_concat_2423:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2424:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2426
    tst x1, #1
    b.eq do_concat_2426
do_apply_2425:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2427
do_concat_2426:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2427:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2429
    tst x1, #1
    b.eq do_concat_2429
do_apply_2428:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2430
do_concat_2429:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2430:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2386
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, tokens_next
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
    str x0, [sp, #-16]!
    mov x0, #20
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
    str x0, [sp, #-16]!
    adr x0, str_15
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2438
    tst x1, #1
    b.eq do_concat_2438
do_apply_2437:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2439
do_concat_2438:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2439:
blk_end_2386:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2441
    tst x1, #1
    b.eq do_concat_2441
do_apply_2440:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2442
do_concat_2441:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2442:
    b cond_end_2382
cond_false_2381:
    adr x0, sign_id
cond_end_2382:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2380
    adr x0, str_16
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2380
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2444
    tst x1, #1
    b.eq do_concat_2444
do_apply_2443:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2445
do_concat_2444:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2445:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2447
    tst x1, #1
    b.eq do_concat_2447
do_apply_2446:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2448
do_concat_2447:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2448:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2450
    tst x1, #1
    b.eq do_concat_2450
do_apply_2449:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2451
do_concat_2450:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2451:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2453
    tst x1, #1
    b.eq do_concat_2453
do_apply_2452:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2454
do_concat_2453:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2454:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2456
    tst x1, #1
    b.eq do_concat_2456
do_apply_2455:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2457
do_concat_2456:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2457:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2459
    tst x1, #1
    b.eq do_concat_2459
do_apply_2458:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2460
do_concat_2459:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2460:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2462
    tst x1, #1
    b.eq do_concat_2462
do_apply_2461:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2463
do_concat_2462:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2463:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2465
    tst x1, #1
    b.eq do_concat_2465
do_apply_2464:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2466
do_concat_2465:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2466:
blk_end_2380:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2468
    tst x1, #1
    b.eq do_concat_2468
do_apply_2467:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2469
do_concat_2468:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2469:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2377
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2471
    tst x1, #1
    b.eq do_concat_2471
do_apply_2470:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2472
do_concat_2471:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2472:
blk_end_2377:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2474
    tst x1, #1
    b.eq do_concat_2474
do_apply_2473:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2475
do_concat_2474:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2475:
    b cond_end_2374
cond_false_2373:
    adr x0, sign_id
cond_end_2374:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2252
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2478
    adr x0, sign_id
    b cmp_end_2479
cmp_true_2478:
cmp_end_2479:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2476
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_2481_2482
func_2481:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2481_2482:
    // Closure for func_2481
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2481
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, val
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2486
    adr x0, sign_id
    b cmp_end_2487
cmp_true_2486:
cmp_end_2487:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2484
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_17
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2488
    adr x0, parse_block
    str x0, [sp, #-16]!
    adr x0, tokens_next
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
blk_end_2488:
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
    b cond_end_2485
cond_false_2484:
    adr x0, sign_id
cond_end_2485:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2483
    adr x0, val
    str x0, [sp, #-16]!
    mov x0, #40
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2497
    adr x0, sign_id
    b cmp_end_2498
cmp_true_2497:
cmp_end_2498:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2495
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_18
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2499
    b after_func_2500_2501
func_2500:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2500_2501:
    // Closure for func_2500
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2500
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2503_2504
func_2503:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2503_2504:
    // Closure for func_2503
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2503
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2506_2507
func_2506:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2506_2507:
    // Closure for func_2506
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2506
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_19
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2508
    b after_func_2509_2510
func_2509:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2509_2510:
    // Closure for func_2509
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2509
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_20
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2511
    adr x0, str_21
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2511
    b after_func_2512_2513
func_2512:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2512_2513:
    // Closure for func_2512
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2512
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2516
    tst x1, #1
    b.eq do_concat_2516
do_apply_2515:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2517
do_concat_2516:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2517:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2519
    tst x1, #1
    b.eq do_concat_2519
do_apply_2518:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2520
do_concat_2519:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2520:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2522
    tst x1, #1
    b.eq do_concat_2522
do_apply_2521:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2523
do_concat_2522:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2523:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2525
    tst x1, #1
    b.eq do_concat_2525
do_apply_2524:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2526
do_concat_2525:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2526:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2528
    tst x1, #1
    b.eq do_concat_2528
do_apply_2527:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2529
do_concat_2528:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2529:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2531
    tst x1, #1
    b.eq do_concat_2531
do_apply_2530:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2532
do_concat_2531:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2532:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2514
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2537
    tst x1, #1
    b.eq do_concat_2537
do_apply_2536:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2538
do_concat_2537:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2538:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2540
    tst x1, #1
    b.eq do_concat_2540
do_apply_2539:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2541
do_concat_2540:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2541:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2543
    tst x1, #1
    b.eq do_concat_2543
do_apply_2542:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2544
do_concat_2543:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2544:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2546
    tst x1, #1
    b.eq do_concat_2546
do_apply_2545:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2547
do_concat_2546:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2547:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2549
    tst x1, #1
    b.eq do_concat_2549
do_apply_2548:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2550
do_concat_2549:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2550:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2552
    tst x1, #1
    b.eq do_concat_2552
do_apply_2551:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2553
do_concat_2552:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2553:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2555
    tst x1, #1
    b.eq do_concat_2555
do_apply_2554:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2556
do_concat_2555:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2556:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2558
    tst x1, #1
    b.eq do_concat_2558
do_apply_2557:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2559
do_concat_2558:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2559:
blk_end_2514:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2561
    tst x1, #1
    b.eq do_concat_2561
do_apply_2560:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2562
do_concat_2561:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2562:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2511
    adr x0, is_null
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2564
    tst x1, #1
    b.eq do_concat_2564
do_apply_2563:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2565
do_concat_2564:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2565:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2567
    tst x1, #1
    b.eq do_concat_2567
do_apply_2566:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2568
do_concat_2567:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2568:
blk_end_2511:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2570
    tst x1, #1
    b.eq do_concat_2570
do_apply_2569:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2571
do_concat_2570:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2571:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2508
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2573
    tst x1, #1
    b.eq do_concat_2573
do_apply_2572:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2574
do_concat_2573:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2574:
blk_end_2508:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2576
    tst x1, #1
    b.eq do_concat_2576
do_apply_2575:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2577
do_concat_2576:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2577:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2505
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2579
    tst x1, #1
    b.eq do_concat_2579
do_apply_2578:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2580
do_concat_2579:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2580:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2582
    tst x1, #1
    b.eq do_concat_2582
do_apply_2581:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2583
do_concat_2582:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2583:
blk_end_2505:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2585
    tst x1, #1
    b.eq do_concat_2585
do_apply_2584:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2586
do_concat_2585:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2586:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2502
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2588
    tst x1, #1
    b.eq do_concat_2588
do_apply_2587:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2589
do_concat_2588:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2589:
blk_end_2502:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2591
    tst x1, #1
    b.eq do_concat_2591
do_apply_2590:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2592
do_concat_2591:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2592:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2499
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2594
    tst x1, #1
    b.eq do_concat_2594
do_apply_2593:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2595
do_concat_2594:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2595:
blk_end_2499:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2597
    tst x1, #1
    b.eq do_concat_2597
do_apply_2596:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2598
do_concat_2597:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2598:
    b cond_end_2496
cond_false_2495:
    adr x0, sign_id
cond_end_2496:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2483
    adr x0, str_22
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2483
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2600
    tst x1, #1
    b.eq do_concat_2600
do_apply_2599:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2601
do_concat_2600:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2601:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2603
    tst x1, #1
    b.eq do_concat_2603
do_apply_2602:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2604
do_concat_2603:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2604:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2606
    tst x1, #1
    b.eq do_concat_2606
do_apply_2605:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2607
do_concat_2606:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2607:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2609
    tst x1, #1
    b.eq do_concat_2609
do_apply_2608:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2610
do_concat_2609:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2610:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2612
    tst x1, #1
    b.eq do_concat_2612
do_apply_2611:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2613
do_concat_2612:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2613:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2615
    tst x1, #1
    b.eq do_concat_2615
do_apply_2614:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2616
do_concat_2615:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2616:
blk_end_2483:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2618
    tst x1, #1
    b.eq do_concat_2618
do_apply_2617:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2619
do_concat_2618:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2619:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2480
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2621
    tst x1, #1
    b.eq do_concat_2621
do_apply_2620:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2622
do_concat_2621:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2622:
blk_end_2480:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2624
    tst x1, #1
    b.eq do_concat_2624
do_apply_2623:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2625
do_concat_2624:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2625:
    b cond_end_2477
cond_false_2476:
    adr x0, sign_id
cond_end_2477:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2252
    adr x0, str_23
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2252
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2627
    tst x1, #1
    b.eq do_concat_2627
do_apply_2626:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2628
do_concat_2627:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2628:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2630
    tst x1, #1
    b.eq do_concat_2630
do_apply_2629:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2631
do_concat_2630:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2631:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2633
    tst x1, #1
    b.eq do_concat_2633
do_apply_2632:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2634
do_concat_2633:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2634:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2636
    tst x1, #1
    b.eq do_concat_2636
do_apply_2635:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2637
do_concat_2636:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2637:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2639
    tst x1, #1
    b.eq do_concat_2639
do_apply_2638:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2640
do_concat_2639:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2640:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2642
    tst x1, #1
    b.eq do_concat_2642
do_apply_2641:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2643
do_concat_2642:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2643:
blk_end_2252:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2645
    tst x1, #1
    b.eq do_concat_2645
do_apply_2644:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2646
do_concat_2645:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2646:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2249
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2648
    tst x1, #1
    b.eq do_concat_2648
do_apply_2647:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2649
do_concat_2648:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2649:
blk_end_2249:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2651
    tst x1, #1
    b.eq do_concat_2651
do_apply_2650:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2652
do_concat_2651:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2652:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2246
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2654
    tst x1, #1
    b.eq do_concat_2654
do_apply_2653:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2655
do_concat_2654:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2655:
blk_end_2246:
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
    b.ne blk_end_2243
    adr x0, peek
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2660
    tst x1, #1
    b.eq do_concat_2660
do_apply_2659:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2661
do_concat_2660:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2661:
blk_end_2243:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2241_2242:
    // Closure for func_2241
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2241
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2237
cond_false_2236:
    adr x0, sign_id
cond_end_2237:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2662
    b after_func_2667_2668
func_2667:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2670_2671
func_2670:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2670_2671:
    // Closure for func_2670
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2670
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2673_2674
func_2673:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2673_2674:
    // Closure for func_2673
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2673
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2676_2677
func_2676:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2676_2677:
    // Closure for func_2676
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2676
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_24
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2678
    b after_func_2679_2680
func_2679:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2679_2680:
    // Closure for func_2679
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2679
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_25
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2681
    b after_func_2682_2683
func_2682:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2682_2683:
    // Closure for func_2682
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2682
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, node
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2685
    tst x1, #1
    b.eq do_concat_2685
do_apply_2684:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2686
do_concat_2685:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2686:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2688
    tst x1, #1
    b.eq do_concat_2688
do_apply_2687:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2689
do_concat_2688:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2689:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2691
    tst x1, #1
    b.eq do_concat_2691
do_apply_2690:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2692
do_concat_2691:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2692:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2694
    tst x1, #1
    b.eq do_concat_2694
do_apply_2693:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2695
do_concat_2694:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2695:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2700
    tst x1, #1
    b.eq do_concat_2700
do_apply_2699:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2701
do_concat_2700:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2701:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2681
    adr x0, transform_section
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2703
    tst x1, #1
    b.eq do_concat_2703
do_apply_2702:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2704
do_concat_2703:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2704:
blk_end_2681:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2706
    tst x1, #1
    b.eq do_concat_2706
do_apply_2705:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2707
do_concat_2706:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2707:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2678
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, rest
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
blk_end_2678:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2675
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
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
blk_end_2675:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2672
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
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
blk_end_2672:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2669
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2730
    tst x1, #1
    b.eq do_concat_2730
do_apply_2729:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2731
do_concat_2730:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2731:
blk_end_2669:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2667_2668:
    // Closure for func_2667
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2667
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2663
cond_false_2662:
    adr x0, sign_id
cond_end_2663:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_null
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2735
    tst x1, #1
    b.eq do_concat_2735
do_apply_2734:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2736
do_concat_2735:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2736:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2732
    b after_func_2737_2738
func_2737:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2742
    adr x0, sign_id
    b cmp_end_2743
cmp_true_2742:
cmp_end_2743:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2740
    mov x0, #1
    b cond_end_2741
cond_false_2740:
    adr x0, sign_id
cond_end_2741:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2739
    mov x0, #0
blk_end_2739:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2737_2738:
    // Closure for func_2737
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2737
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2733
cond_false_2732:
    adr x0, sign_id
cond_end_2733:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_node
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
    b.eq cond_false_2744
    b after_func_2749_2750
func_2749:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2751_2752
func_2751:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2754
    tst x1, #1
    b.eq do_concat_2754
do_apply_2753:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2755
do_concat_2754:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2755:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2757
    tst x1, #1
    b.eq do_concat_2757
do_apply_2756:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2758
do_concat_2757:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2758:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2760
    tst x1, #1
    b.eq do_concat_2760
do_apply_2759:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2761
do_concat_2760:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2761:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2763
    tst x1, #1
    b.eq do_concat_2763
do_apply_2762:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2764
do_concat_2763:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2764:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2751_2752:
    // Closure for func_2751
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2751
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2749_2750:
    // Closure for func_2749
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2749
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2745
cond_false_2744:
    adr x0, sign_id
cond_end_2745:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2768
    tst x1, #1
    b.eq do_concat_2768
do_apply_2767:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2769
do_concat_2768:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2769:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2765
    b after_func_2770_2771
func_2770:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2773
    tst x1, #1
    b.eq do_concat_2773
do_apply_2772:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2774
do_concat_2773:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2774:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2776
    tst x1, #1
    b.eq do_concat_2776
do_apply_2775:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2777
do_concat_2776:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2777:
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
    b cond_end_2766
cond_false_2765:
    adr x0, sign_id
cond_end_2766:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_id
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2781
    tst x1, #1
    b.eq do_concat_2781
do_apply_2780:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2782
do_concat_2781:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2782:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2778
    b after_func_2783_2784
func_2783:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2786
    tst x1, #1
    b.eq do_concat_2786
do_apply_2785:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2787
do_concat_2786:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2787:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2789
    tst x1, #1
    b.eq do_concat_2789
do_apply_2788:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2790
do_concat_2789:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2790:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2783_2784:
    // Closure for func_2783
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2783
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2779
cond_false_2778:
    adr x0, sign_id
cond_end_2779:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2794
    tst x1, #1
    b.eq do_concat_2794
do_apply_2793:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2795
do_concat_2794:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2795:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2791
    b after_func_2796_2797
func_2796:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2799
    tst x1, #1
    b.eq do_concat_2799
do_apply_2798:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2800
do_concat_2799:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2800:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2802
    tst x1, #1
    b.eq do_concat_2802
do_apply_2801:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2803
do_concat_2802:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2803:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2796_2797:
    // Closure for func_2796
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2796
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2792
cond_false_2791:
    adr x0, sign_id
cond_end_2792:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2807
    tst x1, #1
    b.eq do_concat_2807
do_apply_2806:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2808
do_concat_2807:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2808:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2804
    b after_func_2809_2810
func_2809:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2812
    tst x1, #1
    b.eq do_concat_2812
do_apply_2811:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2813
do_concat_2812:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2813:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2815
    tst x1, #1
    b.eq do_concat_2815
do_apply_2814:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2816
do_concat_2815:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2816:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2809_2810:
    // Closure for func_2809
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2809
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2805
cond_false_2804:
    adr x0, sign_id
cond_end_2805:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_infix
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2820
    tst x1, #1
    b.eq do_concat_2820
do_apply_2819:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2821
do_concat_2820:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2821:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2817
    b after_func_2822_2823
func_2822:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2824_2825
func_2824:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2826_2827
func_2826:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2829
    tst x1, #1
    b.eq do_concat_2829
do_apply_2828:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2830
do_concat_2829:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2830:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2832
    tst x1, #1
    b.eq do_concat_2832
do_apply_2831:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2833
do_concat_2832:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2833:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2835
    tst x1, #1
    b.eq do_concat_2835
do_apply_2834:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2836
do_concat_2835:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2836:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2838
    tst x1, #1
    b.eq do_concat_2838
do_apply_2837:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2839
do_concat_2838:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2839:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2841
    tst x1, #1
    b.eq do_concat_2841
do_apply_2840:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2842
do_concat_2841:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2842:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2844
    tst x1, #1
    b.eq do_concat_2844
do_apply_2843:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2845
do_concat_2844:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2845:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2847
    tst x1, #1
    b.eq do_concat_2847
do_apply_2846:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2848
do_concat_2847:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2848:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2850
    tst x1, #1
    b.eq do_concat_2850
do_apply_2849:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2851
do_concat_2850:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2851:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2826_2827:
    // Closure for func_2826
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
    adr x1, func_2826
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2824_2825:
    // Closure for func_2824
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2824
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2822_2823:
    // Closure for func_2822
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2822
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2818
cond_false_2817:
    adr x0, sign_id
cond_end_2818:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_lambda
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2855
    tst x1, #1
    b.eq do_concat_2855
do_apply_2854:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2856
do_concat_2855:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2856:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2852
    b after_func_2857_2858
func_2857:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2859_2860
func_2859:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2862
    tst x1, #1
    b.eq do_concat_2862
do_apply_2861:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2863
do_concat_2862:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2863:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2865
    tst x1, #1
    b.eq do_concat_2865
do_apply_2864:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2866
do_concat_2865:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2866:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2868
    tst x1, #1
    b.eq do_concat_2868
do_apply_2867:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2869
do_concat_2868:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2869:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2859_2860:
    // Closure for func_2859
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2859
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2857_2858:
    // Closure for func_2857
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2857
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2853
cond_false_2852:
    adr x0, sign_id
cond_end_2853:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, transform_section
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2873
    tst x1, #1
    b.eq do_concat_2873
do_apply_2872:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2874
do_concat_2873:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2874:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2870
    b after_func_2875_2876
func_2875:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2878_2879
func_2878:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2878_2879:
    // Closure for func_2878
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2878
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2881_2882
func_2881:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2883_2884
func_2883:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2883_2884:
    // Closure for func_2883
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2883
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2881_2882:
    // Closure for func_2881
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2881
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #1
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
    b after_func_2891_2892
func_2891:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2891_2892:
    // Closure for func_2891
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2891
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2894_2895
func_2894:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2894_2895:
    // Closure for func_2894
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2894
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
    b.eq cmp_true_2899
    adr x0, sign_id
    b cmp_end_2900
cmp_true_2899:
cmp_end_2900:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2897
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_26
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2901
    b after_func_2902_2903
func_2902:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2902_2903:
    // Closure for func_2902
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2902
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2906
    tst x1, #1
    b.eq do_concat_2906
do_apply_2905:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2907
do_concat_2906:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2907:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2909
    tst x1, #1
    b.eq do_concat_2909
do_apply_2908:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2910
do_concat_2909:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2910:
    str x0, [sp, #-16]!
    adr x0, p2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2912
    tst x1, #1
    b.eq do_concat_2912
do_apply_2911:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2913
do_concat_2912:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2913:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2904
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2915
    tst x1, #1
    b.eq do_concat_2915
do_apply_2914:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2916
do_concat_2915:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2916:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2918
    tst x1, #1
    b.eq do_concat_2918
do_apply_2917:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2919
do_concat_2918:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2919:
    str x0, [sp, #-16]!
    adr x0, p2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2921
    tst x1, #1
    b.eq do_concat_2921
do_apply_2920:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2922
do_concat_2921:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2922:
blk_end_2904:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2924
    tst x1, #1
    b.eq do_concat_2924
do_apply_2923:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2925
do_concat_2924:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2925:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2927
    tst x1, #1
    b.eq do_concat_2927
do_apply_2926:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2928
do_concat_2927:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2928:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2901
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2930
    tst x1, #1
    b.eq do_concat_2930
do_apply_2929:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2931
do_concat_2930:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2931:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2933
    tst x1, #1
    b.eq do_concat_2933
do_apply_2932:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2934
do_concat_2933:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2934:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2936
    tst x1, #1
    b.eq do_concat_2936
do_apply_2935:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2937
do_concat_2936:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2937:
    str x0, [sp, #-16]!
    adr x0, str_27
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2939
    tst x1, #1
    b.eq do_concat_2939
do_apply_2938:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2940
do_concat_2939:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2940:
blk_end_2901:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2942
    tst x1, #1
    b.eq do_concat_2942
do_apply_2941:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2943
do_concat_2942:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2943:
    b cond_end_2898
cond_false_2897:
    adr x0, sign_id
cond_end_2898:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2896
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2945
    tst x1, #1
    b.eq do_concat_2945
do_apply_2944:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2946
do_concat_2945:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2946:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2948
    tst x1, #1
    b.eq do_concat_2948
do_apply_2947:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2949
do_concat_2948:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2949:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2951
    tst x1, #1
    b.eq do_concat_2951
do_apply_2950:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2952
do_concat_2951:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2952:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2954
    tst x1, #1
    b.eq do_concat_2954
do_apply_2953:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2955
do_concat_2954:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2955:
blk_end_2896:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2957
    tst x1, #1
    b.eq do_concat_2957
do_apply_2956:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2958
do_concat_2957:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2958:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2893
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2960
    tst x1, #1
    b.eq do_concat_2960
do_apply_2959:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2961
do_concat_2960:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2961:
blk_end_2893:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2963
    tst x1, #1
    b.eq do_concat_2963
do_apply_2962:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2964
do_concat_2963:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2964:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2890
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2966
    tst x1, #1
    b.eq do_concat_2966
do_apply_2965:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2967
do_concat_2966:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2967:
blk_end_2890:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2969
    tst x1, #1
    b.eq do_concat_2969
do_apply_2968:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2970
do_concat_2969:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2970:
    b cond_end_2887
cond_false_2886:
    adr x0, sign_id
cond_end_2887:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2885
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2973
    adr x0, sign_id
    b cmp_end_2974
cmp_true_2973:
cmp_end_2974:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2971
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_2976_2977
func_2976:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2976_2977:
    // Closure for func_2976
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2976
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2979_2980
func_2979:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2979_2980:
    // Closure for func_2979
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2979
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2982_2983
func_2982:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2982_2983:
    // Closure for func_2982
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2982
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2985_2986
func_2985:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2985_2986:
    // Closure for func_2985
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2985
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
    b.eq cmp_true_2990
    adr x0, sign_id
    b cmp_end_2991
cmp_true_2990:
cmp_end_2991:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2988
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_28
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2992
    b after_func_2993_2994
func_2993:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2993_2994:
    // Closure for func_2993
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2993
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2996
    tst x1, #1
    b.eq do_concat_2996
do_apply_2995:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2997
do_concat_2996:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2997:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2999
    tst x1, #1
    b.eq do_concat_2999
do_apply_2998:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3000
do_concat_2999:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3000:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3002
    tst x1, #1
    b.eq do_concat_3002
do_apply_3001:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3003
do_concat_3002:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3003:
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3005
    tst x1, #1
    b.eq do_concat_3005
do_apply_3004:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3006
do_concat_3005:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3006:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3008
    tst x1, #1
    b.eq do_concat_3008
do_apply_3007:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3009
do_concat_3008:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3009:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3011
    tst x1, #1
    b.eq do_concat_3011
do_apply_3010:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3012
do_concat_3011:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3012:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2992
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3014
    tst x1, #1
    b.eq do_concat_3014
do_apply_3013:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3015
do_concat_3014:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3015:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3017
    tst x1, #1
    b.eq do_concat_3017
do_apply_3016:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3018
do_concat_3017:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3018:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3020
    tst x1, #1
    b.eq do_concat_3020
do_apply_3019:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3021
do_concat_3020:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3021:
blk_end_2992:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3023
    tst x1, #1
    b.eq do_concat_3023
do_apply_3022:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3024
do_concat_3023:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3024:
    b cond_end_2989
cond_false_2988:
    adr x0, sign_id
cond_end_2989:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2987
    adr x0, t2
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3027
    adr x0, sign_id
    b cmp_end_3028
cmp_true_3027:
cmp_end_3028:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3025
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_29
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3029
    b after_func_3030_3031
func_3030:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3030_3031:
    // Closure for func_3030
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3030
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3033
    tst x1, #1
    b.eq do_concat_3033
do_apply_3032:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3034
do_concat_3033:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3034:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3036
    tst x1, #1
    b.eq do_concat_3036
do_apply_3035:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3037
do_concat_3036:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3037:
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3039
    tst x1, #1
    b.eq do_concat_3039
do_apply_3038:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3040
do_concat_3039:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3040:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3042
    tst x1, #1
    b.eq do_concat_3042
do_apply_3041:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3043
do_concat_3042:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3043:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3045
    tst x1, #1
    b.eq do_concat_3045
do_apply_3044:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3046
do_concat_3045:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3046:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3048
    tst x1, #1
    b.eq do_concat_3048
do_apply_3047:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3049
do_concat_3048:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3049:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3029
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3051
    tst x1, #1
    b.eq do_concat_3051
do_apply_3050:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3052
do_concat_3051:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3052:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3054
    tst x1, #1
    b.eq do_concat_3054
do_apply_3053:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3055
do_concat_3054:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3055:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3057
    tst x1, #1
    b.eq do_concat_3057
do_apply_3056:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3058
do_concat_3057:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3058:
blk_end_3029:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3060
    tst x1, #1
    b.eq do_concat_3060
do_apply_3059:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3061
do_concat_3060:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3061:
    b cond_end_3026
cond_false_3025:
    adr x0, sign_id
cond_end_3026:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2987
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3063
    tst x1, #1
    b.eq do_concat_3063
do_apply_3062:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3064
do_concat_3063:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3064:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3066
    tst x1, #1
    b.eq do_concat_3066
do_apply_3065:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3067
do_concat_3066:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3067:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3069
    tst x1, #1
    b.eq do_concat_3069
do_apply_3068:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3070
do_concat_3069:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3070:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3072
    tst x1, #1
    b.eq do_concat_3072
do_apply_3071:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3073
do_concat_3072:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3073:
blk_end_2987:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3075
    tst x1, #1
    b.eq do_concat_3075
do_apply_3074:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3076
do_concat_3075:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3076:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2984
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3078
    tst x1, #1
    b.eq do_concat_3078
do_apply_3077:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3079
do_concat_3078:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3079:
blk_end_2984:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3081
    tst x1, #1
    b.eq do_concat_3081
do_apply_3080:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3082
do_concat_3081:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3082:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2981
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3084
    tst x1, #1
    b.eq do_concat_3084
do_apply_3083:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3085
do_concat_3084:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3085:
blk_end_2981:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3087
    tst x1, #1
    b.eq do_concat_3087
do_apply_3086:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3088
do_concat_3087:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3088:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2978
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3090
    tst x1, #1
    b.eq do_concat_3090
do_apply_3089:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3091
do_concat_3090:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3091:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3093
    tst x1, #1
    b.eq do_concat_3093
do_apply_3092:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3094
do_concat_3093:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3094:
blk_end_2978:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3096
    tst x1, #1
    b.eq do_concat_3096
do_apply_3095:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3097
do_concat_3096:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3097:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2975
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3099
    tst x1, #1
    b.eq do_concat_3099
do_apply_3098:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3100
do_concat_3099:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3100:
blk_end_2975:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3102
    tst x1, #1
    b.eq do_concat_3102
do_apply_3101:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3103
do_concat_3102:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3103:
    b cond_end_2972
cond_false_2971:
    adr x0, sign_id
cond_end_2972:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2885
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3105
    tst x1, #1
    b.eq do_concat_3105
do_apply_3104:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3106
do_concat_3105:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3106:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3108
    tst x1, #1
    b.eq do_concat_3108
do_apply_3107:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3109
do_concat_3108:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3109:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3111
    tst x1, #1
    b.eq do_concat_3111
do_apply_3110:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3112
do_concat_3111:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3112:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3114
    tst x1, #1
    b.eq do_concat_3114
do_apply_3113:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3115
do_concat_3114:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3115:
blk_end_2885:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3117
    tst x1, #1
    b.eq do_concat_3117
do_apply_3116:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3118
do_concat_3117:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3118:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2880
    adr x0, make_id
    str x0, [sp, #-16]!
    adr x0, str_30
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3120
    tst x1, #1
    b.eq do_concat_3120
do_apply_3119:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3121
do_concat_3120:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3121:
    str x0, [sp, #-16]!
    adr x0, make_id
    str x0, [sp, #-16]!
    adr x0, str_31
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3123
    tst x1, #1
    b.eq do_concat_3123
do_apply_3122:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3124
do_concat_3123:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3124:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3126
    tst x1, #1
    b.eq do_concat_3126
do_apply_3125:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3127
do_concat_3126:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3127:
blk_end_2880:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3129
    tst x1, #1
    b.eq do_concat_3129
do_apply_3128:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3130
do_concat_3129:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3130:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2877
    adr x0, length
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3132
    tst x1, #1
    b.eq do_concat_3132
do_apply_3131:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3133
do_concat_3132:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3133:
blk_end_2877:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2875_2876:
    // Closure for func_2875
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2875
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2871
cond_false_2870:
    adr x0, sign_id
cond_end_2871:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Pure
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3135
    tst x1, #1
    b.eq do_concat_3135
do_apply_3134:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3136
do_concat_3135:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3136:
    str x0, [sp, #-16]!
    adr x0, Functional
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3138
    tst x1, #1
    b.eq do_concat_3138
do_apply_3137:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3139
do_concat_3138:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3139:
    str x0, [sp, #-16]!
    adr x0, Compiler
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3141
    tst x1, #1
    b.eq do_concat_3141
do_apply_3140:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3142
do_concat_3141:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3142:
    str x0, [sp, #-16]!
    adr x0, Code
    str x0, [sp, #-16]!
    adr x0, Generator
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3144
    tst x1, #1
    b.eq do_concat_3144
do_apply_3143:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3145
do_concat_3144:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3145:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3147
    tst x1, #1
    b.eq do_concat_3147
do_apply_3146:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3148
do_concat_3147:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3148:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Transforms
    str x0, [sp, #-16]!
    adr x0, AST
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3150
    tst x1, #1
    b.eq do_concat_3150
do_apply_3149:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3151
do_concat_3150:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3151:
    str x0, [sp, #-16]!
    adr x0, from
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3153
    tst x1, #1
    b.eq do_concat_3153
do_apply_3152:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3154
do_concat_3153:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3154:
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3156
    tst x1, #1
    b.eq do_concat_3156
do_apply_3155:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3157
do_concat_3156:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3157:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3159
    tst x1, #1
    b.eq do_concat_3159
do_apply_3158:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3160
do_concat_3159:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3160:
    str x0, [sp, #-16]!
    adr x0, sn
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3162
    tst x1, #1
    b.eq do_concat_3162
do_apply_3161:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3163
do_concat_3162:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3163:
    str x0, [sp, #-16]!
    adr x0, into
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3165
    tst x1, #1
    b.eq do_concat_3165
do_apply_3164:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3166
do_concat_3165:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3166:
    str x0, [sp, #-16]!
    adr x0, ARM64
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3168
    tst x1, #1
    b.eq do_concat_3168
do_apply_3167:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3169
do_concat_3168:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3169:
    str x0, [sp, #-16]!
    adr x0, Assembly
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3171
    tst x1, #1
    b.eq do_concat_3171
do_apply_3170:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3172
do_concat_3171:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3172:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3174
    tst x1, #1
    b.eq do_concat_3174
do_apply_3173:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3175
do_concat_3174:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3175:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3179
    tst x1, #1
    b.eq do_concat_3179
do_apply_3178:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3180
do_concat_3179:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3180:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3176
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3184
    tst x1, #1
    b.eq do_concat_3184
do_apply_3183:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3185
do_concat_3184:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3185:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3187
    tst x1, #1
    b.eq do_concat_3187
do_apply_3186:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3188
do_concat_3187:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3188:
    str x0, [sp, #-16]!
    adr x0, threaded
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3190
    tst x1, #1
    b.eq do_concat_3190
do_apply_3189:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3191
do_concat_3190:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3191:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Stack
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3193
    tst x1, #1
    b.eq do_concat_3193
do_apply_3192:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3194
do_concat_3193:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3194:
    str x0, [sp, #-16]!
    adr x0, Machine
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3196
    tst x1, #1
    b.eq do_concat_3196
do_apply_3195:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3197
do_concat_3196:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3197:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3181
    adr x0, Context
    str x0, [sp, #-16]!
    adr x0, is
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3201
    tst x1, #1
    b.eq do_concat_3201
do_apply_3200:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3202
do_concat_3201:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3202:
    str x0, [sp, #-16]!
    adr x0, passed
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3204
    tst x1, #1
    b.eq do_concat_3204
do_apply_3203:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3205
do_concat_3204:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3205:
    str x0, [sp, #-16]!
    adr x0, as
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3207
    tst x1, #1
    b.eq do_concat_3207
do_apply_3206:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3208
do_concat_3207:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3208:
    str x0, [sp, #-16]!
    adr x0, arguments
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3210
    tst x1, #1
    b.eq do_concat_3210
do_apply_3209:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3211
do_concat_3210:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3211:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Output
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3213
    tst x1, #1
    b.eq do_concat_3213
do_apply_3212:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3214
do_concat_3213:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3214:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3198
    adr x0, List
    str x0, [sp, #-16]!
    adr x0, of
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3216
    tst x1, #1
    b.eq do_concat_3216
do_apply_3215:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3217
do_concat_3216:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3217:
    str x0, [sp, #-16]!
    adr x0, assembly
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3219
    tst x1, #1
    b.eq do_concat_3219
do_apply_3218:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3220
do_concat_3219:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3220:
    str x0, [sp, #-16]!
    adr x0, instruction
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3222
    tst x1, #1
    b.eq do_concat_3222
do_apply_3221:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3223
do_concat_3222:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3223:
    str x0, [sp, #-16]!
    adr x0, strings
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3225
    tst x1, #1
    b.eq do_concat_3225
do_apply_3224:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3226
do_concat_3225:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3226:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3228
    tst x1, #1
    b.eq do_concat_3228
do_apply_3227:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3229
do_concat_3228:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3229:
    b cond_end_3199
cond_false_3198:
    adr x0, sign_id
cond_end_3199:
    b cond_end_3182
cond_false_3181:
    adr x0, sign_id
cond_end_3182:
    b cond_end_3177
cond_false_3176:
    adr x0, sign_id
cond_end_3177:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3233
    tst x1, #1
    b.eq do_concat_3233
do_apply_3232:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3234
do_concat_3233:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3234:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3230
    b after_func_3235_3236
func_3235:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3237_3238
func_3237:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3239_3240
func_3239:
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
    b after_func_3241_3242
func_3241:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3244
    tst x1, #1
    b.eq do_concat_3244
do_apply_3243:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3245
do_concat_3244:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3245:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3247
    tst x1, #1
    b.eq do_concat_3247
do_apply_3246:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3248
do_concat_3247:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3248:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3250
    tst x1, #1
    b.eq do_concat_3250
do_apply_3249:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3251
do_concat_3250:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3251:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3253
    tst x1, #1
    b.eq do_concat_3253
do_apply_3252:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3254
do_concat_3253:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3254:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3256
    tst x1, #1
    b.eq do_concat_3256
do_apply_3255:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3257
do_concat_3256:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3257:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3259
    tst x1, #1
    b.eq do_concat_3259
do_apply_3258:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3260
do_concat_3259:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3260:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3262
    tst x1, #1
    b.eq do_concat_3262
do_apply_3261:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3263
do_concat_3262:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3263:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3265
    tst x1, #1
    b.eq do_concat_3265
do_apply_3264:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3266
do_concat_3265:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3266:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3241_3242:
    // Closure for func_3241
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
    adr x1, func_3241
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3239_3240:
    // Closure for func_3239
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
    adr x1, func_3239
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3237_3238:
    // Closure for func_3237
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3237
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_3231
cond_false_3230:
    adr x0, sign_id
cond_end_3231:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_label_count
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3270
    tst x1, #1
    b.eq do_concat_3270
do_apply_3269:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3271
do_concat_3270:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3271:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3267
    b after_func_3272_3273
func_3272:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3275
    tst x1, #1
    b.eq do_concat_3275
do_apply_3274:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3276
do_concat_3275:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3276:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3272_3273:
    // Closure for func_3272
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3272
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3268
cond_false_3267:
    adr x0, sign_id
cond_end_3268:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_strings
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3280
    tst x1, #1
    b.eq do_concat_3280
do_apply_3279:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3281
do_concat_3280:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3281:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3277
    b after_func_3282_3283
func_3282:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3285
    tst x1, #1
    b.eq do_concat_3285
do_apply_3284:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3286
do_concat_3285:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3286:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3288
    tst x1, #1
    b.eq do_concat_3288
do_apply_3287:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3289
do_concat_3288:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3289:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3282_3283:
    // Closure for func_3282
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3282
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3278
cond_false_3277:
    adr x0, sign_id
cond_end_3278:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_env
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3293
    tst x1, #1
    b.eq do_concat_3293
do_apply_3292:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3294
do_concat_3293:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3294:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3290
    b after_func_3295_3296
func_3295:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3298
    tst x1, #1
    b.eq do_concat_3298
do_apply_3297:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3299
do_concat_3298:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3299:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3301
    tst x1, #1
    b.eq do_concat_3301
do_apply_3300:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3302
do_concat_3301:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3302:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3304
    tst x1, #1
    b.eq do_concat_3304
do_apply_3303:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3305
do_concat_3304:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3305:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3295_3296:
    // Closure for func_3295
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3295
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3291
cond_false_3290:
    adr x0, sign_id
cond_end_3291:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_stack_offset
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3309
    tst x1, #1
    b.eq do_concat_3309
do_apply_3308:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3310
do_concat_3309:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3310:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3306
    b after_func_3311_3312
func_3311:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3314
    tst x1, #1
    b.eq do_concat_3314
do_apply_3313:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3315
do_concat_3314:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3315:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3317
    tst x1, #1
    b.eq do_concat_3317
do_apply_3316:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3318
do_concat_3317:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3318:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3320
    tst x1, #1
    b.eq do_concat_3320
do_apply_3319:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3321
do_concat_3320:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3321:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3323
    tst x1, #1
    b.eq do_concat_3323
do_apply_3322:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3324
do_concat_3323:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3324:
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
    b cond_end_3307
cond_false_3306:
    adr x0, sign_id
cond_end_3307:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, lookup_var
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3328
    tst x1, #1
    b.eq do_concat_3328
do_apply_3327:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3329
do_concat_3328:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3329:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3325
    b after_func_3330_3331
func_3330:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3332_3333
func_3332:
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
    b.eq cmp_true_3337
    adr x0, sign_id
    b cmp_end_3338
cmp_true_3337:
cmp_end_3338:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3335
    mov x0, #0
    b cond_end_3336
cond_false_3335:
    adr x0, sign_id
cond_end_3336:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3334
    b after_func_3339_3340
func_3339:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3339_3340:
    // Closure for func_3339
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3339
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3345
    tst x1, #1
    b.eq do_concat_3345
do_apply_3344:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3346
do_concat_3345:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3346:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3348
    tst x1, #1
    b.eq do_concat_3348
do_apply_3347:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3349
do_concat_3348:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3349:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3351
    tst x1, #1
    b.eq do_concat_3351
do_apply_3350:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3352
do_concat_3351:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3352:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3342
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3354
    tst x1, #1
    b.eq do_concat_3354
do_apply_3353:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3355
do_concat_3354:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3355:
    b cond_end_3343
cond_false_3342:
    adr x0, sign_id
cond_end_3343:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3341
    adr x0, lookup_var
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3357
    tst x1, #1
    b.eq do_concat_3357
do_apply_3356:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3358
do_concat_3357:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3358:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3360
    tst x1, #1
    b.eq do_concat_3360
do_apply_3359:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3361
do_concat_3360:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3361:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3363
    tst x1, #1
    b.eq do_concat_3363
do_apply_3362:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3364
do_concat_3363:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3364:
blk_end_3341:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3366
    tst x1, #1
    b.eq do_concat_3366
do_apply_3365:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3367
do_concat_3366:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3367:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3334
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3369
    tst x1, #1
    b.eq do_concat_3369
do_apply_3368:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3370
do_concat_3369:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3370:
blk_end_3334:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3332_3333:
    // Closure for func_3332
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3332
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3330_3331:
    // Closure for func_3330
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3330
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3326
cond_false_3325:
    adr x0, sign_id
cond_end_3326:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3374
    tst x1, #1
    b.eq do_concat_3374
do_apply_3373:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3375
do_concat_3374:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3375:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3371
    b after_func_3376_3377
func_3376:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3378_3379
func_3378:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3381_3382
func_3381:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3381_3382:
    // Closure for func_3381
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3381
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3384_3385
func_3384:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3384_3385:
    // Closure for func_3384
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3384
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3387_3388
func_3387:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3389_3390
func_3389:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3389_3390:
    // Closure for func_3389
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3389
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3387_3388:
    // Closure for func_3387
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3387
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3392
    tst x1, #1
    b.eq do_concat_3392
do_apply_3391:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3393
do_concat_3392:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3393:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3395
    tst x1, #1
    b.eq do_concat_3395
do_apply_3394:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3396
do_concat_3395:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3396:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3398
    tst x1, #1
    b.eq do_concat_3398
do_apply_3397:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3399
do_concat_3398:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3399:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3401
    tst x1, #1
    b.eq do_concat_3401
do_apply_3400:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3402
do_concat_3401:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3402:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3404
    tst x1, #1
    b.eq do_concat_3404
do_apply_3403:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3405
do_concat_3404:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3405:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3407
    tst x1, #1
    b.eq do_concat_3407
do_apply_3406:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3408
do_concat_3407:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3408:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3410
    tst x1, #1
    b.eq do_concat_3410
do_apply_3409:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3411
do_concat_3410:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3411:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, new_ctx
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3413
    tst x1, #1
    b.eq do_concat_3413
do_apply_3412:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3414
do_concat_3413:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3414:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3416
    tst x1, #1
    b.eq do_concat_3416
do_apply_3415:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3417
do_concat_3416:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3417:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3419
    tst x1, #1
    b.eq do_concat_3419
do_apply_3418:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3420
do_concat_3419:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3420:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3422
    tst x1, #1
    b.eq do_concat_3422
do_apply_3421:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3423
do_concat_3422:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3423:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3386
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3425
    tst x1, #1
    b.eq do_concat_3425
do_apply_3424:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3426
do_concat_3425:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3426:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3428
    tst x1, #1
    b.eq do_concat_3428
do_apply_3427:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3429
do_concat_3428:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3429:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3431
    tst x1, #1
    b.eq do_concat_3431
do_apply_3430:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3432
do_concat_3431:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3432:
blk_end_3386:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3434
    tst x1, #1
    b.eq do_concat_3434
do_apply_3433:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3435
do_concat_3434:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3435:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3383
    adr x0, add_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3437
    tst x1, #1
    b.eq do_concat_3437
do_apply_3436:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3438
do_concat_3437:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3438:
    str x0, [sp, #-16]!
    adr x0, content
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3440
    tst x1, #1
    b.eq do_concat_3440
do_apply_3439:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3441
do_concat_3440:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3441:
blk_end_3383:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3443
    tst x1, #1
    b.eq do_concat_3443
do_apply_3442:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3444
do_concat_3443:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3444:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3380
    adr x0, tok_val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3446
    tst x1, #1
    b.eq do_concat_3446
do_apply_3445:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3447
do_concat_3446:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3447:
blk_end_3380:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3378_3379:
    // Closure for func_3378
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3378
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3376_3377:
    // Closure for func_3376
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3376
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3372
cond_false_3371:
    adr x0, sign_id
cond_end_3372:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_apply
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3451
    tst x1, #1
    b.eq do_concat_3451
do_apply_3450:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3452
do_concat_3451:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3452:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3448
    b after_func_3453_3454
func_3453:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3455_3456
func_3455:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3458_3459
func_3458:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3460_3461
func_3460:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3460_3461:
    // Closure for func_3460
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3460
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3458_3459:
    // Closure for func_3458
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3458
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3463_3464
func_3463:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3463_3464:
    // Closure for func_3463
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3463
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3466_3467
func_3466:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3468_3469
func_3468:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3468_3469:
    // Closure for func_3468
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3468
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3466_3467:
    // Closure for func_3466
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3466
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3471_3472
func_3471:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3471_3472:
    // Closure for func_3471
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3471
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3474_3475
func_3474:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3476_3477
func_3476:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3476_3477:
    // Closure for func_3476
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3476
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3474_3475:
    // Closure for func_3474
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3474
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_func
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3480
    tst x1, #1
    b.eq do_concat_3480
do_apply_3479:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3481
do_concat_3480:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3481:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3483
    tst x1, #1
    b.eq do_concat_3483
do_apply_3482:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3484
do_concat_3483:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3484:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_arg
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3486
    tst x1, #1
    b.eq do_concat_3486
do_apply_3485:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3487
do_concat_3486:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3487:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_35
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3489
    tst x1, #1
    b.eq do_concat_3489
do_apply_3488:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3490
do_concat_3489:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3490:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_36
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3492
    tst x1, #1
    b.eq do_concat_3492
do_apply_3491:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3493
do_concat_3492:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3493:
    str x0, [sp, #-16]!
    adr x0, str_37
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3495
    tst x1, #1
    b.eq do_concat_3495
do_apply_3494:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3496
do_concat_3495:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3496:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_38
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3498
    tst x1, #1
    b.eq do_concat_3498
do_apply_3497:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3499
do_concat_3498:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3499:
    str x0, [sp, #-16]!
    adr x0, str_39
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3501
    tst x1, #1
    b.eq do_concat_3501
do_apply_3500:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3502
do_concat_3501:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3502:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_40
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3504
    tst x1, #1
    b.eq do_concat_3504
do_apply_3503:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3505
do_concat_3504:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3505:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3507
    tst x1, #1
    b.eq do_concat_3507
do_apply_3506:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3508
do_concat_3507:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3508:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3510
    tst x1, #1
    b.eq do_concat_3510
do_apply_3509:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3511
do_concat_3510:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3511:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3513
    tst x1, #1
    b.eq do_concat_3513
do_apply_3512:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3514
do_concat_3513:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3514:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3516
    tst x1, #1
    b.eq do_concat_3516
do_apply_3515:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3517
do_concat_3516:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3517:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3519
    tst x1, #1
    b.eq do_concat_3519
do_apply_3518:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3520
do_concat_3519:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3520:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3522
    tst x1, #1
    b.eq do_concat_3522
do_apply_3521:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3523
do_concat_3522:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3523:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3525
    tst x1, #1
    b.eq do_concat_3525
do_apply_3524:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3526
do_concat_3525:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3526:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3478
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_arg
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3528
    tst x1, #1
    b.eq do_concat_3528
do_apply_3527:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3529
do_concat_3528:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3529:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3531
    tst x1, #1
    b.eq do_concat_3531
do_apply_3530:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3532
do_concat_3531:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3532:
blk_end_3478:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3534
    tst x1, #1
    b.eq do_concat_3534
do_apply_3533:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3535
do_concat_3534:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3535:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3537
    tst x1, #1
    b.eq do_concat_3537
do_apply_3536:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3538
do_concat_3537:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3538:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3473
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_arg
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3540
    tst x1, #1
    b.eq do_concat_3540
do_apply_3539:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3541
do_concat_3540:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3541:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_arg
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3543
    tst x1, #1
    b.eq do_concat_3543
do_apply_3542:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3544
do_concat_3543:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3544:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3546
    tst x1, #1
    b.eq do_concat_3546
do_apply_3545:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3547
do_concat_3546:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3547:
blk_end_3473:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3549
    tst x1, #1
    b.eq do_concat_3549
do_apply_3548:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3550
do_concat_3549:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3550:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3470
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, arg
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3552
    tst x1, #1
    b.eq do_concat_3552
do_apply_3551:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3553
do_concat_3552:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3553:
    str x0, [sp, #-16]!
    adr x0, ctx_func
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3555
    tst x1, #1
    b.eq do_concat_3555
do_apply_3554:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3556
do_concat_3555:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3556:
blk_end_3470:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3558
    tst x1, #1
    b.eq do_concat_3558
do_apply_3557:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3559
do_concat_3558:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3559:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3465
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_func
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3561
    tst x1, #1
    b.eq do_concat_3561
do_apply_3560:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3562
do_concat_3561:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3562:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_func
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3564
    tst x1, #1
    b.eq do_concat_3564
do_apply_3563:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3565
do_concat_3564:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3565:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3567
    tst x1, #1
    b.eq do_concat_3567
do_apply_3566:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3568
do_concat_3567:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3568:
blk_end_3465:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3570
    tst x1, #1
    b.eq do_concat_3570
do_apply_3569:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3571
do_concat_3570:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3571:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3462
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, func
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3573
    tst x1, #1
    b.eq do_concat_3573
do_apply_3572:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3574
do_concat_3573:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3574:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3576
    tst x1, #1
    b.eq do_concat_3576
do_apply_3575:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3577
do_concat_3576:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3577:
blk_end_3462:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3579
    tst x1, #1
    b.eq do_concat_3579
do_apply_3578:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3580
do_concat_3579:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3580:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3457
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3582
    tst x1, #1
    b.eq do_concat_3582
do_apply_3581:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3583
do_concat_3582:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3583:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3585
    tst x1, #1
    b.eq do_concat_3585
do_apply_3584:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3586
do_concat_3585:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3586:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3588
    tst x1, #1
    b.eq do_concat_3588
do_apply_3587:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3589
do_concat_3588:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3589:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3591
    tst x1, #1
    b.eq do_concat_3591
do_apply_3590:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3592
do_concat_3591:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3592:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3594
    tst x1, #1
    b.eq do_concat_3594
do_apply_3593:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3595
do_concat_3594:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3595:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3597
    tst x1, #1
    b.eq do_concat_3597
do_apply_3596:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3598
do_concat_3597:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3598:
blk_end_3457:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3455_3456:
    // Closure for func_3455
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3455
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3453_3454:
    // Closure for func_3453
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3453
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3449
cond_false_3448:
    adr x0, sign_id
cond_end_3449:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, push_var
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3602
    tst x1, #1
    b.eq do_concat_3602
do_apply_3601:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3603
do_concat_3602:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3603:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3599
    b after_func_3604_3605
func_3604:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3606_3607
func_3606:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3609_3610
func_3609:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3609_3610:
    // Closure for func_3609
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3609
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3613
    tst x1, #1
    b.eq do_concat_3613
do_apply_3612:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3614
do_concat_3613:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3614:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3611
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3616
    tst x1, #1
    b.eq do_concat_3616
do_apply_3615:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3617
do_concat_3616:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3617:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3611
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3619
    tst x1, #1
    b.eq do_concat_3619
do_apply_3618:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3620
do_concat_3619:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3620:
    str x0, [sp, #-16]!
    adr x0, offset
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3622
    tst x1, #1
    b.eq do_concat_3622
do_apply_3621:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3623
do_concat_3622:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3623:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3625
    tst x1, #1
    b.eq do_concat_3625
do_apply_3624:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3626
do_concat_3625:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3626:
    str x0, [sp, #-16]!
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3628
    tst x1, #1
    b.eq do_concat_3628
do_apply_3627:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3629
do_concat_3628:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3629:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3631
    tst x1, #1
    b.eq do_concat_3631
do_apply_3630:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3632
do_concat_3631:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3632:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3611
    adr x0, offset
blk_end_3611:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3634
    tst x1, #1
    b.eq do_concat_3634
do_apply_3633:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3635
do_concat_3634:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3635:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3637
    tst x1, #1
    b.eq do_concat_3637
do_apply_3636:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3638
do_concat_3637:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3638:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3608
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3640
    tst x1, #1
    b.eq do_concat_3640
do_apply_3639:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3641
do_concat_3640:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3641:
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    sub x0, x1, x0
blk_end_3608:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3606_3607:
    // Closure for func_3606
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3606
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3604_3605:
    // Closure for func_3604
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3604
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3600
cond_false_3599:
    adr x0, sign_id
cond_end_3600:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, add_string
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3645
    tst x1, #1
    b.eq do_concat_3645
do_apply_3644:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3646
do_concat_3645:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3646:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3642
    b after_func_3647_3648
func_3647:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3649_3650
func_3649:
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
    b.ne blk_end_3651
    b after_func_3652_3653
func_3652:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3652_3653:
    // Closure for func_3652
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3652
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3655_3656
func_3655:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3655_3656:
    // Closure for func_3655
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3655
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, label
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3657
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, count
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3658
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, label
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3660
    tst x1, #1
    b.eq do_concat_3660
do_apply_3659:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3661
do_concat_3660:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3661:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3663
    tst x1, #1
    b.eq do_concat_3663
do_apply_3662:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3664
do_concat_3663:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3664:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3666
    tst x1, #1
    b.eq do_concat_3666
do_apply_3665:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3667
do_concat_3666:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3667:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3669
    tst x1, #1
    b.eq do_concat_3669
do_apply_3668:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3670
do_concat_3669:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3670:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3672
    tst x1, #1
    b.eq do_concat_3672
do_apply_3671:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3673
do_concat_3672:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3673:
    str x0, [sp, #-16]!
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3675
    tst x1, #1
    b.eq do_concat_3675
do_apply_3674:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3676
do_concat_3675:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3676:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3678
    tst x1, #1
    b.eq do_concat_3678
do_apply_3677:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3679
do_concat_3678:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3679:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3658
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3681
    tst x1, #1
    b.eq do_concat_3681
do_apply_3680:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3682
do_concat_3681:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3682:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3658
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3684
    tst x1, #1
    b.eq do_concat_3684
do_apply_3683:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3685
do_concat_3684:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3685:
blk_end_3658:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3687
    tst x1, #1
    b.eq do_concat_3687
do_apply_3686:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3688
do_concat_3687:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3688:
blk_end_3657:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3690
    tst x1, #1
    b.eq do_concat_3690
do_apply_3689:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3691
do_concat_3690:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3691:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3693
    tst x1, #1
    b.eq do_concat_3693
do_apply_3692:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3694
do_concat_3693:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3694:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3654
    adr x0, make_label
    str x0, [sp, #-16]!
    adr x0, str_42
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3696
    tst x1, #1
    b.eq do_concat_3696
do_apply_3695:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3697
do_concat_3696:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3697:
    str x0, [sp, #-16]!
    adr x0, count
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3699
    tst x1, #1
    b.eq do_concat_3699
do_apply_3698:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3700
do_concat_3699:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3700:
blk_end_3654:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3702
    tst x1, #1
    b.eq do_concat_3702
do_apply_3701:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3703
do_concat_3702:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3703:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3651
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3705
    tst x1, #1
    b.eq do_concat_3705
do_apply_3704:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3706
do_concat_3705:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3706:
blk_end_3651:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3649_3650:
    // Closure for func_3649
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3649
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3647_3648:
    // Closure for func_3647
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3647
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3643
cond_false_3642:
    adr x0, sign_id
cond_end_3643:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strlen
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3710
    tst x1, #1
    b.eq do_concat_3710
do_apply_3709:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3711
do_concat_3710:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3711:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3707
    b after_func_3712_3713
func_3712:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3715_3716
func_3715:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3715_3716:
    // Closure for func_3715
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3715
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3720
    adr x0, sign_id
    b cmp_end_3721
cmp_true_3720:
cmp_end_3721:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3718
    mov x0, #0
    b cond_end_3719
cond_false_3718:
    adr x0, sign_id
cond_end_3719:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3717
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, strlen
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
    b.lo do_concat_3723
    tst x1, #1
    b.eq do_concat_3723
do_apply_3722:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3724
do_concat_3723:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3724:
blk_end_3717:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3726
    tst x1, #1
    b.eq do_concat_3726
do_apply_3725:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3727
do_concat_3726:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3727:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3714
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_3714:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3712_3713:
    // Closure for func_3712
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3712
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3708
cond_false_3707:
    adr x0, sign_id
cond_end_3708:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strcpy
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3731
    tst x1, #1
    b.eq do_concat_3731
do_apply_3730:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3732
do_concat_3731:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3732:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3728
    b after_func_3733_3734
func_3733:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3735_3736
func_3735:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3738_3739
func_3738:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3738_3739:
    // Closure for func_3738
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3738
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3743
    adr x0, sign_id
    b cmp_end_3744
cmp_true_3743:
cmp_end_3744:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3741
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3745
    ldr x0, [x29, #-48]
blk_end_3745:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3747
    tst x1, #1
    b.eq do_concat_3747
do_apply_3746:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3748
do_concat_3747:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3748:
    b cond_end_3742
cond_false_3741:
    adr x0, sign_id
cond_end_3742:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3740
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3740
    adr x0, strcpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3750
    tst x1, #1
    b.eq do_concat_3750
do_apply_3749:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3751
do_concat_3750:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3751:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3753
    tst x1, #1
    b.eq do_concat_3753
do_apply_3752:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3754
do_concat_3753:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3754:
blk_end_3740:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3756
    tst x1, #1
    b.eq do_concat_3756
do_apply_3755:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3757
do_concat_3756:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3757:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3737
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_3737:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3735_3736:
    // Closure for func_3735
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3735
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3733_3734:
    // Closure for func_3733
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3733
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3729
cond_false_3728:
    adr x0, sign_id
cond_end_3729:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strcat
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3761
    tst x1, #1
    b.eq do_concat_3761
do_apply_3760:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3762
do_concat_3761:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3762:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3758
    b after_func_3763_3764
func_3763:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3765_3766
func_3765:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3768_3769
func_3768:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3768_3769:
    // Closure for func_3768
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3768
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, strcpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, len
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3772
    tst x1, #1
    b.eq do_concat_3772
do_apply_3771:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3773
do_concat_3772:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3773:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3775
    tst x1, #1
    b.eq do_concat_3775
do_apply_3774:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3776
do_concat_3775:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3776:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3770
    ldr x0, [x29, #-48]
blk_end_3770:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3778
    tst x1, #1
    b.eq do_concat_3778
do_apply_3777:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3779
do_concat_3778:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3779:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3767
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3781
    tst x1, #1
    b.eq do_concat_3781
do_apply_3780:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3782
do_concat_3781:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3782:
blk_end_3767:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3765_3766:
    // Closure for func_3765
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3765
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3763_3764:
    // Closure for func_3763
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3763
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3759
cond_false_3758:
    adr x0, sign_id
cond_end_3759:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3786
    tst x1, #1
    b.eq do_concat_3786
do_apply_3785:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3787
do_concat_3786:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3787:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3783
    b after_func_3788_3789
func_3788:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3790_3791
func_3790:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3793_3794
func_3793:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3793_3794:
    // Closure for func_3793
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3793
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3796_3797
func_3796:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3796_3797:
    // Closure for func_3796
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3796
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3799_3800
func_3799:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3799_3800:
    // Closure for func_3799
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3799
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, strcpy
    str x0, [sp, #-16]!
    adr x0, new_s
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3803
    tst x1, #1
    b.eq do_concat_3803
do_apply_3802:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3804
do_concat_3803:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3804:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3806
    tst x1, #1
    b.eq do_concat_3806
do_apply_3805:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3807
do_concat_3806:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3807:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3801
    adr x0, strcpy
    str x0, [sp, #-16]!
    adr x0, new_s
    str x0, [sp, #-16]!
    adr x0, len1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3809
    tst x1, #1
    b.eq do_concat_3809
do_apply_3808:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3810
do_concat_3809:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3810:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3812
    tst x1, #1
    b.eq do_concat_3812
do_apply_3811:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3813
do_concat_3812:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3813:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3801
    adr x0, new_s
blk_end_3801:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3815
    tst x1, #1
    b.eq do_concat_3815
do_apply_3814:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3816
do_concat_3815:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3816:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3798
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, len1
    str x0, [sp, #-16]!
    adr x0, len2
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3818
    tst x1, #1
    b.eq do_concat_3818
do_apply_3817:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3819
do_concat_3818:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3819:
blk_end_3798:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3821
    tst x1, #1
    b.eq do_concat_3821
do_apply_3820:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3822
do_concat_3821:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3822:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3795
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3824
    tst x1, #1
    b.eq do_concat_3824
do_apply_3823:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3825
do_concat_3824:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3825:
blk_end_3795:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3827
    tst x1, #1
    b.eq do_concat_3827
do_apply_3826:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3828
do_concat_3827:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3828:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3792
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3830
    tst x1, #1
    b.eq do_concat_3830
do_apply_3829:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3831
do_concat_3830:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3831:
blk_end_3792:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3790_3791:
    // Closure for func_3790
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3790
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3788_3789:
    // Closure for func_3788
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3788
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3784
cond_false_3783:
    adr x0, sign_id
cond_end_3784:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat_list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3835
    tst x1, #1
    b.eq do_concat_3835
do_apply_3834:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3836
do_concat_3835:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3836:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3832
    b after_func_3837_3838
func_3837:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3842
    adr x0, sign_id
    b cmp_end_3843
cmp_true_3842:
cmp_end_3843:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3840
    adr x0, str_43
    b cond_end_3841
cond_false_3840:
    adr x0, sign_id
cond_end_3841:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3839
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3845
    tst x1, #1
    b.eq do_concat_3845
do_apply_3844:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3846
do_concat_3845:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3846:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3848
    tst x1, #1
    b.eq do_concat_3848
do_apply_3847:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3849
do_concat_3848:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3849:
    str x0, [sp, #-16]!
    adr x0, concat_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3851
    tst x1, #1
    b.eq do_concat_3851
do_apply_3850:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3852
do_concat_3851:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3852:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3854
    tst x1, #1
    b.eq do_concat_3854
do_apply_3853:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3855
do_concat_3854:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3855:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3857
    tst x1, #1
    b.eq do_concat_3857
do_apply_3856:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3858
do_concat_3857:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3858:
blk_end_3839:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3837_3838:
    // Closure for func_3837
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3837
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3833
cond_false_3832:
    adr x0, sign_id
cond_end_3833:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, int_to_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3862
    tst x1, #1
    b.eq do_concat_3862
do_apply_3861:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3863
do_concat_3862:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3863:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3859
    b after_func_3864_3865
func_3864:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3869
    adr x0, sign_id
    b cmp_end_3870
cmp_true_3869:
cmp_end_3870:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3867
    mov x0, #48
    b cond_end_3868
cond_false_3867:
    adr x0, sign_id
cond_end_3868:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3866
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_3873
    adr x0, sign_id
    b cmp_end_3874
cmp_true_3873:
cmp_end_3874:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3871
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3876
    tst x1, #1
    b.eq do_concat_3876
do_apply_3875:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3877
do_concat_3876:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3877:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3879
    tst x1, #1
    b.eq do_concat_3879
do_apply_3878:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3880
do_concat_3879:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3880:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3882
    tst x1, #1
    b.eq do_concat_3882
do_apply_3881:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3883
do_concat_3882:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3883:
    b cond_end_3872
cond_false_3871:
    adr x0, sign_id
cond_end_3872:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3866
    adr x0, _int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3885
    tst x1, #1
    b.eq do_concat_3885
do_apply_3884:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3886
do_concat_3885:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3886:
blk_end_3866:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3864_3865:
    // Closure for func_3864
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3864
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3860
cond_false_3859:
    adr x0, sign_id
cond_end_3860:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _int_to_str_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3890
    tst x1, #1
    b.eq do_concat_3890
do_apply_3889:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3891
do_concat_3890:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3891:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3887
    b after_func_3892_3893
func_3892:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3897
    adr x0, sign_id
    b cmp_end_3898
cmp_true_3897:
cmp_end_3898:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3895
    adr x0, str_43
    b cond_end_3896
cond_false_3895:
    adr x0, sign_id
cond_end_3896:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3894
    b after_func_3899_3900
func_3899:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3899_3900:
    // Closure for func_3899
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3899
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3902
    tst x1, #1
    b.eq do_concat_3902
do_apply_3901:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3903
do_concat_3902:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3903:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3905
    tst x1, #1
    b.eq do_concat_3905
do_apply_3904:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3906
do_concat_3905:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3906:
    str x0, [sp, #-16]!
    adr x0, char_to_str
    str x0, [sp, #-16]!
    adr x0, digit
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3908
    tst x1, #1
    b.eq do_concat_3908
do_apply_3907:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3909
do_concat_3908:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3909:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3911
    tst x1, #1
    b.eq do_concat_3911
do_apply_3910:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3912
do_concat_3911:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3912:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3914
    tst x1, #1
    b.eq do_concat_3914
do_apply_3913:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3915
do_concat_3914:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3915:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3894
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
blk_end_3894:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3892_3893:
    // Closure for func_3892
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3892
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3888
cond_false_3887:
    adr x0, sign_id
cond_end_3888:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, char_to_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3919
    tst x1, #1
    b.eq do_concat_3919
do_apply_3918:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3920
do_concat_3919:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3920:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3916
    b after_func_3921_3922
func_3921:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3924_3925
func_3924:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3924_3925:
    // Closure for func_3924
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3924
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
    b.ne blk_end_3926
    adr x0, s
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
    b.ne blk_end_3926
    adr x0, s
blk_end_3926:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3928
    tst x1, #1
    b.eq do_concat_3928
do_apply_3927:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3929
do_concat_3928:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3929:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3923
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3931
    tst x1, #1
    b.eq do_concat_3931
do_apply_3930:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3932
do_concat_3931:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3932:
blk_end_3923:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3921_3922:
    // Closure for func_3921
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3921
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3917
cond_false_3916:
    adr x0, sign_id
cond_end_3917:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, emit_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3936
    tst x1, #1
    b.eq do_concat_3936
do_apply_3935:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3937
do_concat_3936:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3937:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3933
    b after_func_3938_3939
func_3938:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3940_3941
func_3940:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3943
    tst x1, #1
    b.eq do_concat_3943
do_apply_3942:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3944
do_concat_3943:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3944:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3946
    tst x1, #1
    b.eq do_concat_3946
do_apply_3945:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3947
do_concat_3946:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3947:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3949
    tst x1, #1
    b.eq do_concat_3949
do_apply_3948:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3950
do_concat_3949:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3950:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3940_3941:
    // Closure for func_3940
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3940
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3938_3939:
    // Closure for func_3938
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3938
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3934
cond_false_3933:
    adr x0, sign_id
cond_end_3934:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_label
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3954
    tst x1, #1
    b.eq do_concat_3954
do_apply_3953:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3955
do_concat_3954:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3955:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3951
    b after_func_3956_3957
func_3956:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3958_3959
func_3958:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3961
    tst x1, #1
    b.eq do_concat_3961
do_apply_3960:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3962
do_concat_3961:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3962:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #95
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3964
    tst x1, #1
    b.eq do_concat_3964
do_apply_3963:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3965
do_concat_3964:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3965:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3967
    tst x1, #1
    b.eq do_concat_3967
do_apply_3966:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3968
do_concat_3967:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3968:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3970
    tst x1, #1
    b.eq do_concat_3970
do_apply_3969:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3971
do_concat_3970:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3971:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3973
    tst x1, #1
    b.eq do_concat_3973
do_apply_3972:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3974
do_concat_3973:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3974:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3958_3959:
    // Closure for func_3958
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3958
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3956_3957:
    // Closure for func_3956
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3956
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3952
cond_false_3951:
    adr x0, sign_id
cond_end_3952:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, new_label
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3978
    tst x1, #1
    b.eq do_concat_3978
do_apply_3977:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3979
do_concat_3978:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3979:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3975
    b after_func_3980_3981
func_3980:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3982_3983
func_3982:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3985_3986
func_3985:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3985_3986:
    // Closure for func_3985
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3985
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3988_3989
func_3988:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3988_3989:
    // Closure for func_3988
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3988
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lbl
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3990
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, count
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3991
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3993
    tst x1, #1
    b.eq do_concat_3993
do_apply_3992:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3994
do_concat_3993:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3994:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3991
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3996
    tst x1, #1
    b.eq do_concat_3996
do_apply_3995:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3997
do_concat_3996:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3997:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3991
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3999
    tst x1, #1
    b.eq do_concat_3999
do_apply_3998:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4000
do_concat_3999:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4000:
blk_end_3991:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4002
    tst x1, #1
    b.eq do_concat_4002
do_apply_4001:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4003
do_concat_4002:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4003:
blk_end_3990:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4005
    tst x1, #1
    b.eq do_concat_4005
do_apply_4004:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4006
do_concat_4005:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4006:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4008
    tst x1, #1
    b.eq do_concat_4008
do_apply_4007:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4009
do_concat_4008:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4009:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3987
    adr x0, make_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4011
    tst x1, #1
    b.eq do_concat_4011
do_apply_4010:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4012
do_concat_4011:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4012:
    str x0, [sp, #-16]!
    adr x0, count
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4014
    tst x1, #1
    b.eq do_concat_4014
do_apply_4013:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4015
do_concat_4014:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4015:
blk_end_3987:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4017
    tst x1, #1
    b.eq do_concat_4017
do_apply_4016:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4018
do_concat_4017:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4018:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3984
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4020
    tst x1, #1
    b.eq do_concat_4020
do_apply_4019:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4021
do_concat_4020:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4021:
blk_end_3984:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3982_3983:
    // Closure for func_3982
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3982
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3980_3981:
    // Closure for func_3980
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3980
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3976
cond_false_3975:
    adr x0, sign_id
cond_end_3976:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_program
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4025
    tst x1, #1
    b.eq do_concat_4025
do_apply_4024:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4026
do_concat_4025:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4026:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4022
    b after_func_4027_4028
func_4027:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4030_4031
func_4030:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4030_4031:
    // Closure for func_4030
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4030
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4033_4034
func_4033:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4033_4034:
    // Closure for func_4033
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4033
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat_list
    str x0, [sp, #-16]!
    adr x0, asm_list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4036
    tst x1, #1
    b.eq do_concat_4036
do_apply_4035:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4037
do_concat_4036:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4037:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4039
    tst x1, #1
    b.eq do_concat_4039
do_apply_4038:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4040
do_concat_4039:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4040:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4032
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4042
    tst x1, #1
    b.eq do_concat_4042
do_apply_4041:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4043
do_concat_4042:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4043:
blk_end_4032:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4045
    tst x1, #1
    b.eq do_concat_4045
do_apply_4044:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4046
do_concat_4045:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4046:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4029
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4048
    tst x1, #1
    b.eq do_concat_4048
do_apply_4047:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4049
do_concat_4048:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4049:
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4051
    tst x1, #1
    b.eq do_concat_4051
do_apply_4050:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4052
do_concat_4051:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4052:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4054
    tst x1, #1
    b.eq do_concat_4054
do_apply_4053:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4055
do_concat_4054:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4055:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4057
    tst x1, #1
    b.eq do_concat_4057
do_apply_4056:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4058
do_concat_4057:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4058:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4060
    tst x1, #1
    b.eq do_concat_4060
do_apply_4059:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4061
do_concat_4060:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4061:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4063
    tst x1, #1
    b.eq do_concat_4063
do_apply_4062:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4064
do_concat_4063:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4064:
blk_end_4029:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4027_4028:
    // Closure for func_4027
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4027
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4023
cond_false_4022:
    adr x0, sign_id
cond_end_4023:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_node
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4068
    tst x1, #1
    b.eq do_concat_4068
do_apply_4067:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4069
do_concat_4068:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4069:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4065
    b after_func_4070_4071
func_4070:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4072_4073
func_4072:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4075_4076
func_4075:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4080
    adr x0, sign_id
    b cmp_end_4081
cmp_true_4080:
cmp_end_4081:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4078
    adr x0, compile_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4083
    tst x1, #1
    b.eq do_concat_4083
do_apply_4082:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4084
do_concat_4083:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4084:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4086
    tst x1, #1
    b.eq do_concat_4086
do_apply_4085:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4087
do_concat_4086:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4087:
    b cond_end_4079
cond_false_4078:
    adr x0, sign_id
cond_end_4079:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4077
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4090
    adr x0, sign_id
    b cmp_end_4091
cmp_true_4090:
cmp_end_4091:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4088
    adr x0, compile_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4093
    tst x1, #1
    b.eq do_concat_4093
do_apply_4092:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4094
do_concat_4093:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4094:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4096
    tst x1, #1
    b.eq do_concat_4096
do_apply_4095:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4097
do_concat_4096:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4097:
    b cond_end_4089
cond_false_4088:
    adr x0, sign_id
cond_end_4089:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4077
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4100
    adr x0, sign_id
    b cmp_end_4101
cmp_true_4100:
cmp_end_4101:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4098
    adr x0, compile_block
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4103
    tst x1, #1
    b.eq do_concat_4103
do_apply_4102:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4104
do_concat_4103:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4104:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4106
    tst x1, #1
    b.eq do_concat_4106
do_apply_4105:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4107
do_concat_4106:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4107:
    b cond_end_4099
cond_false_4098:
    adr x0, sign_id
cond_end_4099:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4077
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4110
    adr x0, sign_id
    b cmp_end_4111
cmp_true_4110:
cmp_end_4111:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4108
    adr x0, compile_unit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4113
    tst x1, #1
    b.eq do_concat_4113
do_apply_4112:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4114
do_concat_4113:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4114:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4116
    tst x1, #1
    b.eq do_concat_4116
do_apply_4115:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4117
do_concat_4116:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4117:
    b cond_end_4109
cond_false_4108:
    adr x0, sign_id
cond_end_4109:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4077
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4120
    adr x0, sign_id
    b cmp_end_4121
cmp_true_4120:
cmp_end_4121:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4118
    adr x0, compile_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4123
    tst x1, #1
    b.eq do_concat_4123
do_apply_4122:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4124
do_concat_4123:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4124:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4126
    tst x1, #1
    b.eq do_concat_4126
do_apply_4125:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4127
do_concat_4126:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4127:
    b cond_end_4119
cond_false_4118:
    adr x0, sign_id
cond_end_4119:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4077
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4130
    adr x0, sign_id
    b cmp_end_4131
cmp_true_4130:
cmp_end_4131:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4128
    adr x0, compile_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4133
    tst x1, #1
    b.eq do_concat_4133
do_apply_4132:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4134
do_concat_4133:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4134:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4136
    tst x1, #1
    b.eq do_concat_4136
do_apply_4135:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4137
do_concat_4136:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4137:
    b cond_end_4129
cond_false_4128:
    adr x0, sign_id
cond_end_4129:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4077
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4140
    adr x0, sign_id
    b cmp_end_4141
cmp_true_4140:
cmp_end_4141:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4138
    adr x0, compile_apply
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4143
    tst x1, #1
    b.eq do_concat_4143
do_apply_4142:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4144
do_concat_4143:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4144:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4146
    tst x1, #1
    b.eq do_concat_4146
do_apply_4145:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4147
do_concat_4146:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4147:
    b cond_end_4139
cond_false_4138:
    adr x0, sign_id
cond_end_4139:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4077
    adr x0, str_44
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4077
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4149
    tst x1, #1
    b.eq do_concat_4149
do_apply_4148:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4150
do_concat_4149:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4150:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4152
    tst x1, #1
    b.eq do_concat_4152
do_apply_4151:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4153
do_concat_4152:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4153:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4155
    tst x1, #1
    b.eq do_concat_4155
do_apply_4154:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4156
do_concat_4155:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4156:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4158
    tst x1, #1
    b.eq do_concat_4158
do_apply_4157:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4159
do_concat_4158:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4159:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4161
    tst x1, #1
    b.eq do_concat_4161
do_apply_4160:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4162
do_concat_4161:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4162:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4164
    tst x1, #1
    b.eq do_concat_4164
do_apply_4163:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4165
do_concat_4164:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4165:
blk_end_4077:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4167
    tst x1, #1
    b.eq do_concat_4167
do_apply_4166:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4168
do_concat_4167:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4168:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4074
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4170
    tst x1, #1
    b.eq do_concat_4170
do_apply_4169:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4171
do_concat_4170:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4171:
blk_end_4074:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4072_4073:
    // Closure for func_4072
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4072
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4070_4071:
    // Closure for func_4070
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4070
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4066
cond_false_4065:
    adr x0, sign_id
cond_end_4066:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4175
    tst x1, #1
    b.eq do_concat_4175
do_apply_4174:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4176
do_concat_4175:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4176:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4172
    b after_func_4177_4178
func_4177:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4179_4180
func_4179:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4182_4183
func_4182:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4182_4183:
    // Closure for func_4182
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4182
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_46
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4186
    tst x1, #1
    b.eq do_concat_4186
do_apply_4185:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4187
do_concat_4186:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4187:
    str x0, [sp, #-16]!
    adr x0, emit_num
    str x0, [sp, #-16]!
    adr x0, val
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4189
    tst x1, #1
    b.eq do_concat_4189
do_apply_4188:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4190
do_concat_4189:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4190:
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4192
    tst x1, #1
    b.eq do_concat_4192
do_apply_4191:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4193
do_concat_4192:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4193:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4195
    tst x1, #1
    b.eq do_concat_4195
do_apply_4194:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4196
do_concat_4195:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4196:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4198
    tst x1, #1
    b.eq do_concat_4198
do_apply_4197:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4199
do_concat_4198:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4199:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4201
    tst x1, #1
    b.eq do_concat_4201
do_apply_4200:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4202
do_concat_4201:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4202:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4184
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4204
    tst x1, #1
    b.eq do_concat_4204
do_apply_4203:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4205
do_concat_4204:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4205:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4207
    tst x1, #1
    b.eq do_concat_4207
do_apply_4206:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4208
do_concat_4207:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4208:
blk_end_4184:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4210
    tst x1, #1
    b.eq do_concat_4210
do_apply_4209:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4211
do_concat_4210:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4211:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4213
    tst x1, #1
    b.eq do_concat_4213
do_apply_4212:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4214
do_concat_4213:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4214:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4181
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4216
    tst x1, #1
    b.eq do_concat_4216
do_apply_4215:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4217
do_concat_4216:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4217:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4219
    tst x1, #1
    b.eq do_concat_4219
do_apply_4218:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4220
do_concat_4219:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4220:
blk_end_4181:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4179_4180:
    // Closure for func_4179
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4179
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4177_4178:
    // Closure for func_4177
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4177
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4173
cond_false_4172:
    adr x0, sign_id
cond_end_4173:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_unit
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4224
    tst x1, #1
    b.eq do_concat_4224
do_apply_4223:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4225
do_concat_4224:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4225:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4221
    b after_func_4226_4227
func_4226:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4228_4229
func_4228:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4231
    tst x1, #1
    b.eq do_concat_4231
do_apply_4230:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4232
do_concat_4231:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4232:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4234
    tst x1, #1
    b.eq do_concat_4234
do_apply_4233:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4235
do_concat_4234:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4235:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4237
    tst x1, #1
    b.eq do_concat_4237
do_apply_4236:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4238
do_concat_4237:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4238:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4240
    tst x1, #1
    b.eq do_concat_4240
do_apply_4239:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4241
do_concat_4240:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4241:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4243
    tst x1, #1
    b.eq do_concat_4243
do_apply_4242:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4244
do_concat_4243:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4244:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4246
    tst x1, #1
    b.eq do_concat_4246
do_apply_4245:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4247
do_concat_4246:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4247:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4228_4229:
    // Closure for func_4228
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4228
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4226_4227:
    // Closure for func_4226
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4226
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4222
cond_false_4221:
    adr x0, sign_id
cond_end_4222:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_infix
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4251
    tst x1, #1
    b.eq do_concat_4251
do_apply_4250:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4252
do_concat_4251:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4252:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4248
    b after_func_4253_4254
func_4253:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4255_4256
func_4255:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4258_4259
func_4258:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4258_4259:
    // Closure for func_4258
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4258
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4264
    tst x1, #1
    b.eq do_concat_4264
do_apply_4263:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4265
do_concat_4264:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4265:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4267
    tst x1, #1
    b.eq do_concat_4267
do_apply_4266:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4268
do_concat_4267:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4268:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4261
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4270
    tst x1, #1
    b.eq do_concat_4270
do_apply_4269:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4271
do_concat_4270:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4271:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4273
    tst x1, #1
    b.eq do_concat_4273
do_apply_4272:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4274
do_concat_4273:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4274:
    str x0, [sp, #-16]!
    adr x0, str_48
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4276
    tst x1, #1
    b.eq do_concat_4276
do_apply_4275:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4277
do_concat_4276:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4277:
    b cond_end_4262
cond_false_4261:
    adr x0, sign_id
cond_end_4262:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4281
    tst x1, #1
    b.eq do_concat_4281
do_apply_4280:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4282
do_concat_4281:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4282:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4284
    tst x1, #1
    b.eq do_concat_4284
do_apply_4283:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4285
do_concat_4284:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4285:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4278
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4287
    tst x1, #1
    b.eq do_concat_4287
do_apply_4286:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4288
do_concat_4287:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4288:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4290
    tst x1, #1
    b.eq do_concat_4290
do_apply_4289:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4291
do_concat_4290:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4291:
    str x0, [sp, #-16]!
    adr x0, str_49
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4293
    tst x1, #1
    b.eq do_concat_4293
do_apply_4292:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4294
do_concat_4293:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4294:
    b cond_end_4279
cond_false_4278:
    adr x0, sign_id
cond_end_4279:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4298
    tst x1, #1
    b.eq do_concat_4298
do_apply_4297:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4299
do_concat_4298:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4299:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4301
    tst x1, #1
    b.eq do_concat_4301
do_apply_4300:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4302
do_concat_4301:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4302:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4295
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4304
    tst x1, #1
    b.eq do_concat_4304
do_apply_4303:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4305
do_concat_4304:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4305:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4307
    tst x1, #1
    b.eq do_concat_4307
do_apply_4306:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4308
do_concat_4307:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4308:
    str x0, [sp, #-16]!
    adr x0, str_50
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4310
    tst x1, #1
    b.eq do_concat_4310
do_apply_4309:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4311
do_concat_4310:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4311:
    b cond_end_4296
cond_false_4295:
    adr x0, sign_id
cond_end_4296:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4315
    tst x1, #1
    b.eq do_concat_4315
do_apply_4314:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4316
do_concat_4315:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4316:
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4318
    tst x1, #1
    b.eq do_concat_4318
do_apply_4317:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4319
do_concat_4318:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4319:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4312
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4321
    tst x1, #1
    b.eq do_concat_4321
do_apply_4320:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4322
do_concat_4321:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4322:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4324
    tst x1, #1
    b.eq do_concat_4324
do_apply_4323:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4325
do_concat_4324:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4325:
    str x0, [sp, #-16]!
    adr x0, str_51
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4327
    tst x1, #1
    b.eq do_concat_4327
do_apply_4326:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4328
do_concat_4327:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4328:
    b cond_end_4313
cond_false_4312:
    adr x0, sign_id
cond_end_4313:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4332
    tst x1, #1
    b.eq do_concat_4332
do_apply_4331:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4333
do_concat_4332:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4333:
    str x0, [sp, #-16]!
    mov x0, #61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4335
    tst x1, #1
    b.eq do_concat_4335
do_apply_4334:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4336
do_concat_4335:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4336:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4329
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4338
    tst x1, #1
    b.eq do_concat_4338
do_apply_4337:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4339
do_concat_4338:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4339:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4341
    tst x1, #1
    b.eq do_concat_4341
do_apply_4340:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4342
do_concat_4341:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4342:
    str x0, [sp, #-16]!
    adr x0, str_52
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4344
    tst x1, #1
    b.eq do_concat_4344
do_apply_4343:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4345
do_concat_4344:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4345:
    b cond_end_4330
cond_false_4329:
    adr x0, sign_id
cond_end_4330:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4349
    tst x1, #1
    b.eq do_concat_4349
do_apply_4348:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4350
do_concat_4349:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4350:
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4352
    tst x1, #1
    b.eq do_concat_4352
do_apply_4351:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4353
do_concat_4352:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4353:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4346
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4355
    tst x1, #1
    b.eq do_concat_4355
do_apply_4354:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4356
do_concat_4355:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4356:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4358
    tst x1, #1
    b.eq do_concat_4358
do_apply_4357:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4359
do_concat_4358:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4359:
    str x0, [sp, #-16]!
    adr x0, str_53
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4361
    tst x1, #1
    b.eq do_concat_4361
do_apply_4360:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4362
do_concat_4361:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4362:
    b cond_end_4347
cond_false_4346:
    adr x0, sign_id
cond_end_4347:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4366
    tst x1, #1
    b.eq do_concat_4366
do_apply_4365:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4367
do_concat_4366:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4367:
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4369
    tst x1, #1
    b.eq do_concat_4369
do_apply_4368:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4370
do_concat_4369:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4370:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4363
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4372
    tst x1, #1
    b.eq do_concat_4372
do_apply_4371:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4373
do_concat_4372:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4373:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4375
    tst x1, #1
    b.eq do_concat_4375
do_apply_4374:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4376
do_concat_4375:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4376:
    str x0, [sp, #-16]!
    adr x0, str_54
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4378
    tst x1, #1
    b.eq do_concat_4378
do_apply_4377:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4379
do_concat_4378:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4379:
    b cond_end_4364
cond_false_4363:
    adr x0, sign_id
cond_end_4364:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4383
    tst x1, #1
    b.eq do_concat_4383
do_apply_4382:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4384
do_concat_4383:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4384:
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4386
    tst x1, #1
    b.eq do_concat_4386
do_apply_4385:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4387
do_concat_4386:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4387:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4380
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4389
    tst x1, #1
    b.eq do_concat_4389
do_apply_4388:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4390
do_concat_4389:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4390:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4392
    tst x1, #1
    b.eq do_concat_4392
do_apply_4391:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4393
do_concat_4392:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4393:
    str x0, [sp, #-16]!
    adr x0, str_55
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4395
    tst x1, #1
    b.eq do_concat_4395
do_apply_4394:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4396
do_concat_4395:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4396:
    b cond_end_4381
cond_false_4380:
    adr x0, sign_id
cond_end_4381:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4400
    tst x1, #1
    b.eq do_concat_4400
do_apply_4399:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4401
do_concat_4400:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4401:
    str x0, [sp, #-16]!
    adr x0, str_5
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4403
    tst x1, #1
    b.eq do_concat_4403
do_apply_4402:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4404
do_concat_4403:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4404:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4397
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4406
    tst x1, #1
    b.eq do_concat_4406
do_apply_4405:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4407
do_concat_4406:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4407:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4409
    tst x1, #1
    b.eq do_concat_4409
do_apply_4408:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4410
do_concat_4409:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4410:
    str x0, [sp, #-16]!
    adr x0, str_56
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4412
    tst x1, #1
    b.eq do_concat_4412
do_apply_4411:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4413
do_concat_4412:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4413:
    b cond_end_4398
cond_false_4397:
    adr x0, sign_id
cond_end_4398:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4417
    tst x1, #1
    b.eq do_concat_4417
do_apply_4416:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4418
do_concat_4417:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4418:
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4420
    tst x1, #1
    b.eq do_concat_4420
do_apply_4419:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4421
do_concat_4420:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4421:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4414
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4423
    tst x1, #1
    b.eq do_concat_4423
do_apply_4422:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4424
do_concat_4423:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4424:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4426
    tst x1, #1
    b.eq do_concat_4426
do_apply_4425:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4427
do_concat_4426:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4427:
    str x0, [sp, #-16]!
    adr x0, str_57
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4429
    tst x1, #1
    b.eq do_concat_4429
do_apply_4428:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4430
do_concat_4429:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4430:
    b cond_end_4415
cond_false_4414:
    adr x0, sign_id
cond_end_4415:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4434
    tst x1, #1
    b.eq do_concat_4434
do_apply_4433:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4435
do_concat_4434:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4435:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4437
    tst x1, #1
    b.eq do_concat_4437
do_apply_4436:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4438
do_concat_4437:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4438:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4431
    adr x0, compile_bind
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4440
    tst x1, #1
    b.eq do_concat_4440
do_apply_4439:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4441
do_concat_4440:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4441:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4443
    tst x1, #1
    b.eq do_concat_4443
do_apply_4442:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4444
do_concat_4443:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4444:
    b cond_end_4432
cond_false_4431:
    adr x0, sign_id
cond_end_4432:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4448
    tst x1, #1
    b.eq do_concat_4448
do_apply_4447:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4449
do_concat_4448:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4449:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4451
    tst x1, #1
    b.eq do_concat_4451
do_apply_4450:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4452
do_concat_4451:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4452:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4445
    adr x0, compile_lambda
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4454
    tst x1, #1
    b.eq do_concat_4454
do_apply_4453:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4455
do_concat_4454:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4455:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4457
    tst x1, #1
    b.eq do_concat_4457
do_apply_4456:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4458
do_concat_4457:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4458:
    b cond_end_4446
cond_false_4445:
    adr x0, sign_id
cond_end_4446:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, str_44
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4260
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4460
    tst x1, #1
    b.eq do_concat_4460
do_apply_4459:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4461
do_concat_4460:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4461:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4463
    tst x1, #1
    b.eq do_concat_4463
do_apply_4462:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4464
do_concat_4463:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4464:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4466
    tst x1, #1
    b.eq do_concat_4466
do_apply_4465:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4467
do_concat_4466:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4467:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4469
    tst x1, #1
    b.eq do_concat_4469
do_apply_4468:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4470
do_concat_4469:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4470:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4472
    tst x1, #1
    b.eq do_concat_4472
do_apply_4471:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4473
do_concat_4472:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4473:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4475
    tst x1, #1
    b.eq do_concat_4475
do_apply_4474:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4476
do_concat_4475:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4476:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4478
    tst x1, #1
    b.eq do_concat_4478
do_apply_4477:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4479
do_concat_4478:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4479:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4481
    tst x1, #1
    b.eq do_concat_4481
do_apply_4480:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4482
do_concat_4481:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4482:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4484
    tst x1, #1
    b.eq do_concat_4484
do_apply_4483:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4485
do_concat_4484:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4485:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4487
    tst x1, #1
    b.eq do_concat_4487
do_apply_4486:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4488
do_concat_4487:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4488:
blk_end_4260:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4490
    tst x1, #1
    b.eq do_concat_4490
do_apply_4489:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4491
do_concat_4490:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4491:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4257
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4493
    tst x1, #1
    b.eq do_concat_4493
do_apply_4492:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4494
do_concat_4493:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4494:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4496
    tst x1, #1
    b.eq do_concat_4496
do_apply_4495:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4497
do_concat_4496:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4497:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4499
    tst x1, #1
    b.eq do_concat_4499
do_apply_4498:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4500
do_concat_4499:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4500:
blk_end_4257:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4255_4256:
    // Closure for func_4255
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4255
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4253_4254:
    // Closure for func_4253
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4253
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4249
cond_false_4248:
    adr x0, sign_id
cond_end_4249:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_bind
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4504
    tst x1, #1
    b.eq do_concat_4504
do_apply_4503:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4505
do_concat_4504:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4505:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4501
    b after_func_4506_4507
func_4506:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4508_4509
func_4508:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4511_4512
func_4511:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4513_4514
func_4513:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4513_4514:
    // Closure for func_4513
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4513
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4511_4512:
    // Closure for func_4511
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4511
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4516_4517
func_4516:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4516_4517:
    // Closure for func_4516
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4516
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4519_4520
func_4519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4519_4520:
    // Closure for func_4519
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4519
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4522_4523
func_4522:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4524_4525
func_4524:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4524_4525:
    // Closure for func_4524
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4524
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4522_4523:
    // Closure for func_4522
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4522
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4527_4528
func_4527:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4527_4528:
    // Closure for func_4527
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4527
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4531
    tst x1, #1
    b.eq do_concat_4531
do_apply_4530:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4532
do_concat_4531:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4532:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4534
    tst x1, #1
    b.eq do_concat_4534
do_apply_4533:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4535
do_concat_4534:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4535:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4537
    tst x1, #1
    b.eq do_concat_4537
do_apply_4536:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4538
do_concat_4537:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4538:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4540
    tst x1, #1
    b.eq do_concat_4540
do_apply_4539:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4541
do_concat_4540:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4541:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4543
    tst x1, #1
    b.eq do_concat_4543
do_apply_4542:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4544
do_concat_4543:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4544:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4546
    tst x1, #1
    b.eq do_concat_4546
do_apply_4545:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4547
do_concat_4546:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4547:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4529
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, new_ctx
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4549
    tst x1, #1
    b.eq do_concat_4549
do_apply_4548:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4550
do_concat_4549:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4550:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4552
    tst x1, #1
    b.eq do_concat_4552
do_apply_4551:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4553
do_concat_4552:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4553:
blk_end_4529:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4555
    tst x1, #1
    b.eq do_concat_4555
do_apply_4554:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4556
do_concat_4555:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4556:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4558
    tst x1, #1
    b.eq do_concat_4558
do_apply_4557:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4559
do_concat_4558:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4559:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4526
    adr x0, push_var
    str x0, [sp, #-16]!
    adr x0, ctx_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4561
    tst x1, #1
    b.eq do_concat_4561
do_apply_4560:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4562
do_concat_4561:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4562:
    str x0, [sp, #-16]!
    adr x0, name
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4564
    tst x1, #1
    b.eq do_concat_4564
do_apply_4563:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4565
do_concat_4564:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4565:
blk_end_4526:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4567
    tst x1, #1
    b.eq do_concat_4567
do_apply_4566:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4568
do_concat_4567:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4568:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4521
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4570
    tst x1, #1
    b.eq do_concat_4570
do_apply_4569:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4571
do_concat_4570:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4571:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4573
    tst x1, #1
    b.eq do_concat_4573
do_apply_4572:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4574
do_concat_4573:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4574:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4576
    tst x1, #1
    b.eq do_concat_4576
do_apply_4575:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4577
do_concat_4576:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4577:
blk_end_4521:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4579
    tst x1, #1
    b.eq do_concat_4579
do_apply_4578:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4580
do_concat_4579:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4580:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4518
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4582
    tst x1, #1
    b.eq do_concat_4582
do_apply_4581:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4583
do_concat_4582:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4583:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4585
    tst x1, #1
    b.eq do_concat_4585
do_apply_4584:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4586
do_concat_4585:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4586:
blk_end_4518:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4588
    tst x1, #1
    b.eq do_concat_4588
do_apply_4587:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4589
do_concat_4588:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4589:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4515
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4591
    tst x1, #1
    b.eq do_concat_4591
do_apply_4590:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4592
do_concat_4591:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4592:
    str x0, [sp, #-16]!
    adr x0, str_59
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4594
    tst x1, #1
    b.eq do_concat_4594
do_apply_4593:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4595
do_concat_4594:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4595:
blk_end_4515:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4597
    tst x1, #1
    b.eq do_concat_4597
do_apply_4596:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4598
do_concat_4597:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4598:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4510
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4600
    tst x1, #1
    b.eq do_concat_4600
do_apply_4599:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4601
do_concat_4600:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4601:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4603
    tst x1, #1
    b.eq do_concat_4603
do_apply_4602:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4604
do_concat_4603:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4604:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4606
    tst x1, #1
    b.eq do_concat_4606
do_apply_4605:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4607
do_concat_4606:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4607:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4609
    tst x1, #1
    b.eq do_concat_4609
do_apply_4608:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4610
do_concat_4609:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4610:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4612
    tst x1, #1
    b.eq do_concat_4612
do_apply_4611:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4613
do_concat_4612:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4613:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4615
    tst x1, #1
    b.eq do_concat_4615
do_apply_4614:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4616
do_concat_4615:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4616:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4618
    tst x1, #1
    b.eq do_concat_4618
do_apply_4617:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4619
do_concat_4618:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4619:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4621
    tst x1, #1
    b.eq do_concat_4621
do_apply_4620:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4622
do_concat_4621:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4622:
blk_end_4510:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4508_4509:
    // Closure for func_4508
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4508
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4506_4507:
    // Closure for func_4506
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4506
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4502
cond_false_4501:
    adr x0, sign_id
cond_end_4502:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_lambda
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4626
    tst x1, #1
    b.eq do_concat_4626
do_apply_4625:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4627
do_concat_4626:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4627:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4623
    b after_func_4628_4629
func_4628:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4630_4631
func_4630:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4633_4634
func_4633:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4635_4636
func_4635:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4635_4636:
    // Closure for func_4635
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4635
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4633_4634:
    // Closure for func_4633
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4633
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4638_4639
func_4638:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4640_4641
func_4640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4642_4643
func_4642:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4642_4643:
    // Closure for func_4642
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4642
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4640_4641:
    // Closure for func_4640
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4640
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4638_4639:
    // Closure for func_4638
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4638
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4645_4646
func_4645:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4647_4648
func_4647:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4649_4650
func_4649:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4649_4650:
    // Closure for func_4649
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4649
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4647_4648:
    // Closure for func_4647
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4647
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4645_4646:
    // Closure for func_4645
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4645
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4652_4653
func_4652:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4652_4653:
    // Closure for func_4652
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4652
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4655_4656
func_4655:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4655_4656:
    // Closure for func_4655
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4655
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4658_4659
func_4658:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4658_4659:
    // Closure for func_4658
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4658
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4660_4661
func_4660:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4662_4663
func_4662:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4662_4663:
    // Closure for func_4662
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4662
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4660_4661:
    // Closure for func_4660
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4660
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4667
    tst x1, #1
    b.eq do_concat_4667
do_apply_4666:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4668
do_concat_4667:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4668:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_after
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4670
    tst x1, #1
    b.eq do_concat_4670
do_apply_4669:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4671
do_concat_4670:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4671:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4673
    tst x1, #1
    b.eq do_concat_4673
do_apply_4672:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4674
do_concat_4673:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4674:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4676
    tst x1, #1
    b.eq do_concat_4676
do_apply_4675:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4677
do_concat_4676:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4677:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4679
    tst x1, #1
    b.eq do_concat_4679
do_apply_4678:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4680
do_concat_4679:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4680:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_func
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4682
    tst x1, #1
    b.eq do_concat_4682
do_apply_4681:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4683
do_concat_4682:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4683:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4685
    tst x1, #1
    b.eq do_concat_4685
do_apply_4684:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4686
do_concat_4685:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4686:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4688
    tst x1, #1
    b.eq do_concat_4688
do_apply_4687:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4689
do_concat_4688:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4689:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_62
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4691
    tst x1, #1
    b.eq do_concat_4691
do_apply_4690:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4692
do_concat_4691:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4692:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4694
    tst x1, #1
    b.eq do_concat_4694
do_apply_4693:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4695
do_concat_4694:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4695:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_64
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4697
    tst x1, #1
    b.eq do_concat_4697
do_apply_4696:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4698
do_concat_4697:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4698:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_body
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4700
    tst x1, #1
    b.eq do_concat_4700
do_apply_4699:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4701
do_concat_4700:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4701:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_65
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4703
    tst x1, #1
    b.eq do_concat_4703
do_apply_4702:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4704
do_concat_4703:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4704:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_66
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4706
    tst x1, #1
    b.eq do_concat_4706
do_apply_4705:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4707
do_concat_4706:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4707:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_67
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4709
    tst x1, #1
    b.eq do_concat_4709
do_apply_4708:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4710
do_concat_4709:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4710:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_after
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4712
    tst x1, #1
    b.eq do_concat_4712
do_apply_4711:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4713
do_concat_4712:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4713:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4715
    tst x1, #1
    b.eq do_concat_4715
do_apply_4714:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4716
do_concat_4715:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4716:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4718
    tst x1, #1
    b.eq do_concat_4718
do_apply_4717:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4719
do_concat_4718:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4719:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4721
    tst x1, #1
    b.eq do_concat_4721
do_apply_4720:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4722
do_concat_4721:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4722:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4724
    tst x1, #1
    b.eq do_concat_4724
do_apply_4723:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4725
do_concat_4724:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4725:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_68
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4727
    tst x1, #1
    b.eq do_concat_4727
do_apply_4726:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4728
do_concat_4727:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4728:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_func
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4730
    tst x1, #1
    b.eq do_concat_4730
do_apply_4729:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4731
do_concat_4730:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4731:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4733
    tst x1, #1
    b.eq do_concat_4733
do_apply_4732:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4734
do_concat_4733:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4734:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4736
    tst x1, #1
    b.eq do_concat_4736
do_apply_4735:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4737
do_concat_4736:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4737:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4739
    tst x1, #1
    b.eq do_concat_4739
do_apply_4738:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4740
do_concat_4739:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4740:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_69
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4742
    tst x1, #1
    b.eq do_concat_4742
do_apply_4741:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4743
do_concat_4742:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4743:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_70
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4745
    tst x1, #1
    b.eq do_concat_4745
do_apply_4744:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4746
do_concat_4745:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4746:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4748
    tst x1, #1
    b.eq do_concat_4748
do_apply_4747:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4749
do_concat_4748:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4749:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4751
    tst x1, #1
    b.eq do_concat_4751
do_apply_4750:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4752
do_concat_4751:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4752:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4754
    tst x1, #1
    b.eq do_concat_4754
do_apply_4753:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4755
do_concat_4754:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4755:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4757
    tst x1, #1
    b.eq do_concat_4757
do_apply_4756:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4758
do_concat_4757:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4758:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4760
    tst x1, #1
    b.eq do_concat_4760
do_apply_4759:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4761
do_concat_4760:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4761:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4763
    tst x1, #1
    b.eq do_concat_4763
do_apply_4762:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4764
do_concat_4763:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4764:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4766
    tst x1, #1
    b.eq do_concat_4766
do_apply_4765:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4767
do_concat_4766:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4767:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4769
    tst x1, #1
    b.eq do_concat_4769
do_apply_4768:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4770
do_concat_4769:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4770:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4772
    tst x1, #1
    b.eq do_concat_4772
do_apply_4771:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4773
do_concat_4772:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4773:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4775
    tst x1, #1
    b.eq do_concat_4775
do_apply_4774:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4776
do_concat_4775:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4776:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4778
    tst x1, #1
    b.eq do_concat_4778
do_apply_4777:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4779
do_concat_4778:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4779:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4781
    tst x1, #1
    b.eq do_concat_4781
do_apply_4780:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4782
do_concat_4781:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4782:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4784
    tst x1, #1
    b.eq do_concat_4784
do_apply_4783:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4785
do_concat_4784:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4785:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4787
    tst x1, #1
    b.eq do_concat_4787
do_apply_4786:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4788
do_concat_4787:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4788:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4790
    tst x1, #1
    b.eq do_concat_4790
do_apply_4789:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4791
do_concat_4790:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4791:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4665
    mov x0, #0
blk_end_4665:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4793
    tst x1, #1
    b.eq do_concat_4793
do_apply_4792:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4794
do_concat_4793:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4794:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4664
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_body
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4796
    tst x1, #1
    b.eq do_concat_4796
do_apply_4795:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4797
do_concat_4796:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4797:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4799
    tst x1, #1
    b.eq do_concat_4799
do_apply_4798:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4800
do_concat_4799:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4800:
blk_end_4664:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4802
    tst x1, #1
    b.eq do_concat_4802
do_apply_4801:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4803
do_concat_4802:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4803:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4805
    tst x1, #1
    b.eq do_concat_4805
do_apply_4804:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4806
do_concat_4805:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4806:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4808
    tst x1, #1
    b.eq do_concat_4808
do_apply_4807:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4809
do_concat_4808:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4809:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4657
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_body
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4811
    tst x1, #1
    b.eq do_concat_4811
do_apply_4810:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4812
do_concat_4811:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4812:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_body
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4814
    tst x1, #1
    b.eq do_concat_4814
do_apply_4813:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4815
do_concat_4814:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4815:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4817
    tst x1, #1
    b.eq do_concat_4817
do_apply_4816:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4818
do_concat_4817:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4818:
blk_end_4657:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4820
    tst x1, #1
    b.eq do_concat_4820
do_apply_4819:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4821
do_concat_4820:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4821:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4654
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, body
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4823
    tst x1, #1
    b.eq do_concat_4823
do_apply_4822:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4824
do_concat_4823:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4824:
    str x0, [sp, #-16]!
    adr x0, ctx_with_arg
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4826
    tst x1, #1
    b.eq do_concat_4826
do_apply_4825:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4827
do_concat_4826:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4827:
blk_end_4654:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4829
    tst x1, #1
    b.eq do_concat_4829
do_apply_4828:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4830
do_concat_4829:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4830:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4651
    adr x0, push_var
    str x0, [sp, #-16]!
    adr x0, ctx_lbl
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4832
    tst x1, #1
    b.eq do_concat_4832
do_apply_4831:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4833
do_concat_4832:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4833:
    str x0, [sp, #-16]!
    adr x0, param_name
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4835
    tst x1, #1
    b.eq do_concat_4835
do_apply_4834:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4836
do_concat_4835:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4836:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, params
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4838
    tst x1, #1
    b.eq do_concat_4838
do_apply_4837:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4839
do_concat_4838:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4839:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4841
    tst x1, #1
    b.eq do_concat_4841
do_apply_4840:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4842
do_concat_4841:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4842:
    str x0, [sp, #-16]!
    adr x0, str_71
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4844
    tst x1, #1
    b.eq do_concat_4844
do_apply_4843:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4845
do_concat_4844:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4845:
blk_end_4651:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4847
    tst x1, #1
    b.eq do_concat_4847
do_apply_4846:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4848
do_concat_4847:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4848:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4644
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_after
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4850
    tst x1, #1
    b.eq do_concat_4850
do_apply_4849:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4851
do_concat_4850:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4851:
    str x0, [sp, #-16]!
    adr x0, new_label
    str x0, [sp, #-16]!
    adr x0, ctx_lbl
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4853
    tst x1, #1
    b.eq do_concat_4853
do_apply_4852:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4854
do_concat_4853:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4854:
    str x0, [sp, #-16]!
    adr x0, str_72
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4856
    tst x1, #1
    b.eq do_concat_4856
do_apply_4855:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4857
do_concat_4856:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4857:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4859
    tst x1, #1
    b.eq do_concat_4859
do_apply_4858:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4860
do_concat_4859:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4860:
blk_end_4644:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4862
    tst x1, #1
    b.eq do_concat_4862
do_apply_4861:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4863
do_concat_4862:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4863:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4637
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_lbl
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4865
    tst x1, #1
    b.eq do_concat_4865
do_apply_4864:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4866
do_concat_4865:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4866:
    str x0, [sp, #-16]!
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4868
    tst x1, #1
    b.eq do_concat_4868
do_apply_4867:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4869
do_concat_4868:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4869:
    str x0, [sp, #-16]!
    adr x0, str_73
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4871
    tst x1, #1
    b.eq do_concat_4871
do_apply_4870:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4872
do_concat_4871:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4872:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4874
    tst x1, #1
    b.eq do_concat_4874
do_apply_4873:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4875
do_concat_4874:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4875:
blk_end_4637:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4877
    tst x1, #1
    b.eq do_concat_4877
do_apply_4876:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4878
do_concat_4877:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4878:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4632
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4880
    tst x1, #1
    b.eq do_concat_4880
do_apply_4879:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4881
do_concat_4880:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4881:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4883
    tst x1, #1
    b.eq do_concat_4883
do_apply_4882:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4884
do_concat_4883:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4884:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4886
    tst x1, #1
    b.eq do_concat_4886
do_apply_4885:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4887
do_concat_4886:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4887:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4889
    tst x1, #1
    b.eq do_concat_4889
do_apply_4888:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4890
do_concat_4889:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4890:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4892
    tst x1, #1
    b.eq do_concat_4892
do_apply_4891:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4893
do_concat_4892:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4893:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4895
    tst x1, #1
    b.eq do_concat_4895
do_apply_4894:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4896
do_concat_4895:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4896:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4898
    tst x1, #1
    b.eq do_concat_4898
do_apply_4897:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4899
do_concat_4898:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4899:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4901
    tst x1, #1
    b.eq do_concat_4901
do_apply_4900:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4902
do_concat_4901:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4902:
blk_end_4632:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4630_4631:
    // Closure for func_4630
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4630
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4628_4629:
    // Closure for func_4628
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4628
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4624
cond_false_4623:
    adr x0, sign_id
cond_end_4624:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_binop
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4906
    tst x1, #1
    b.eq do_concat_4906
do_apply_4905:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4907
do_concat_4906:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4907:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4903
    b after_func_4908_4909
func_4908:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4910_4911
func_4910:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4912_4913
func_4912:
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
    b after_func_4915_4916
func_4915:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4917_4918
func_4917:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4917_4918:
    // Closure for func_4917
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4917
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4915_4916:
    // Closure for func_4915
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4915
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4920_4921
func_4920:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4920_4921:
    // Closure for func_4920
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4920
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4923_4924
func_4923:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4925_4926
func_4925:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4925_4926:
    // Closure for func_4925
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4925
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4923_4924:
    // Closure for func_4923
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4923
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4928_4929
func_4928:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4928_4929:
    // Closure for func_4928
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4928
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4931_4932
func_4931:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4933_4934
func_4933:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4933_4934:
    // Closure for func_4933
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4933
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4931_4932:
    // Closure for func_4931
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4931
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4937
    tst x1, #1
    b.eq do_concat_4937
do_apply_4936:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4938
do_concat_4937:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4938:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4940
    tst x1, #1
    b.eq do_concat_4940
do_apply_4939:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4941
do_concat_4940:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4941:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4943
    tst x1, #1
    b.eq do_concat_4943
do_apply_4942:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4944
do_concat_4943:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4944:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_74
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4946
    tst x1, #1
    b.eq do_concat_4946
do_apply_4945:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4947
do_concat_4946:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4947:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_69
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4949
    tst x1, #1
    b.eq do_concat_4949
do_apply_4948:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4950
do_concat_4949:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4950:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4952
    tst x1, #1
    b.eq do_concat_4952
do_apply_4951:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4953
do_concat_4952:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4953:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4955
    tst x1, #1
    b.eq do_concat_4955
do_apply_4954:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4956
do_concat_4955:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4956:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4958
    tst x1, #1
    b.eq do_concat_4958
do_apply_4957:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4959
do_concat_4958:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4959:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4961
    tst x1, #1
    b.eq do_concat_4961
do_apply_4960:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4962
do_concat_4961:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4962:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4964
    tst x1, #1
    b.eq do_concat_4964
do_apply_4963:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4965
do_concat_4964:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4965:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4967
    tst x1, #1
    b.eq do_concat_4967
do_apply_4966:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4968
do_concat_4967:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4968:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4970
    tst x1, #1
    b.eq do_concat_4970
do_apply_4969:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4971
do_concat_4970:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4971:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4935
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4973
    tst x1, #1
    b.eq do_concat_4973
do_apply_4972:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4974
do_concat_4973:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4974:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4976
    tst x1, #1
    b.eq do_concat_4976
do_apply_4975:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4977
do_concat_4976:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4977:
blk_end_4935:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4979
    tst x1, #1
    b.eq do_concat_4979
do_apply_4978:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4980
do_concat_4979:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4980:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4982
    tst x1, #1
    b.eq do_concat_4982
do_apply_4981:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4983
do_concat_4982:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4983:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4930
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4985
    tst x1, #1
    b.eq do_concat_4985
do_apply_4984:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4986
do_concat_4985:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4986:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4988
    tst x1, #1
    b.eq do_concat_4988
do_apply_4987:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4989
do_concat_4988:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4989:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4991
    tst x1, #1
    b.eq do_concat_4991
do_apply_4990:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4992
do_concat_4991:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4992:
blk_end_4930:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4994
    tst x1, #1
    b.eq do_concat_4994
do_apply_4993:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4995
do_concat_4994:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4995:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4927
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4997
    tst x1, #1
    b.eq do_concat_4997
do_apply_4996:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_4998
do_concat_4997:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_4998:
    str x0, [sp, #-16]!
    adr x0, ctx_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5000
    tst x1, #1
    b.eq do_concat_5000
do_apply_4999:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5001
do_concat_5000:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5001:
blk_end_4927:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5003
    tst x1, #1
    b.eq do_concat_5003
do_apply_5002:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5004
do_concat_5003:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5004:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4922
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5006
    tst x1, #1
    b.eq do_concat_5006
do_apply_5005:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5007
do_concat_5006:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5007:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5009
    tst x1, #1
    b.eq do_concat_5009
do_apply_5008:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5010
do_concat_5009:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5010:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5012
    tst x1, #1
    b.eq do_concat_5012
do_apply_5011:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5013
do_concat_5012:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5013:
blk_end_4922:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5015
    tst x1, #1
    b.eq do_concat_5015
do_apply_5014:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5016
do_concat_5015:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5016:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4919
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5018
    tst x1, #1
    b.eq do_concat_5018
do_apply_5017:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5019
do_concat_5018:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5019:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5021
    tst x1, #1
    b.eq do_concat_5021
do_apply_5020:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5022
do_concat_5021:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5022:
blk_end_4919:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5024
    tst x1, #1
    b.eq do_concat_5024
do_apply_5023:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5025
do_concat_5024:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5025:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4914
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5027
    tst x1, #1
    b.eq do_concat_5027
do_apply_5026:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5028
do_concat_5027:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5028:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5030
    tst x1, #1
    b.eq do_concat_5030
do_apply_5029:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5031
do_concat_5030:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5031:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5033
    tst x1, #1
    b.eq do_concat_5033
do_apply_5032:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5034
do_concat_5033:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5034:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5036
    tst x1, #1
    b.eq do_concat_5036
do_apply_5035:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5037
do_concat_5036:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5037:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5039
    tst x1, #1
    b.eq do_concat_5039
do_apply_5038:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5040
do_concat_5039:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5040:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5042
    tst x1, #1
    b.eq do_concat_5042
do_apply_5041:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5043
do_concat_5042:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5043:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5045
    tst x1, #1
    b.eq do_concat_5045
do_apply_5044:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5046
do_concat_5045:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5046:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5048
    tst x1, #1
    b.eq do_concat_5048
do_apply_5047:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5049
do_concat_5048:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5049:
blk_end_4914:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4912_4913:
    // Closure for func_4912
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
    adr x1, func_4912
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4910_4911:
    // Closure for func_4910
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4910
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4908_4909:
    // Closure for func_4908
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4908
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4904
cond_false_4903:
    adr x0, sign_id
cond_end_4904:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_cmp
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5053
    tst x1, #1
    b.eq do_concat_5053
do_apply_5052:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5054
do_concat_5053:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5054:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5050
    b after_func_5055_5056
func_5055:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5057_5058
func_5057:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5059_5060
func_5059:
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
    b after_func_5062_5063
func_5062:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5064_5065
func_5064:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5064_5065:
    // Closure for func_5064
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5064
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5062_5063:
    // Closure for func_5062
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5062
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5067_5068
func_5067:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5067_5068:
    // Closure for func_5067
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5067
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
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
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5072_5073:
    // Closure for func_5072
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    b after_func_5075_5076
func_5075:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b after_func_5078_5079
func_5078:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5078_5079:
    // Closure for func_5078
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5078
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
    b after_func_5087_5088
func_5087:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5087_5088:
    // Closure for func_5087
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5087
    ldr x0, [sp], #16
    bl _cons
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
    b after_func_5090_5091
func_5090:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5090_5091:
    // Closure for func_5090
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5090
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5094
    tst x1, #1
    b.eq do_concat_5094
do_apply_5093:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5095
do_concat_5094:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5095:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5097
    tst x1, #1
    b.eq do_concat_5097
do_apply_5096:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5098
do_concat_5097:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5098:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5100
    tst x1, #1
    b.eq do_concat_5100
do_apply_5099:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5101
do_concat_5100:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5101:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_74
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5103
    tst x1, #1
    b.eq do_concat_5103
do_apply_5102:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5104
do_concat_5103:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5104:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_69
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5106
    tst x1, #1
    b.eq do_concat_5106
do_apply_5105:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5107
do_concat_5106:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5107:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_75
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5109
    tst x1, #1
    b.eq do_concat_5109
do_apply_5108:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5110
do_concat_5109:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5110:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_76
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5112
    tst x1, #1
    b.eq do_concat_5112
do_apply_5111:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5113
do_concat_5112:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5113:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5115
    tst x1, #1
    b.eq do_concat_5115
do_apply_5114:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5116
do_concat_5115:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5116:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #32
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5118
    tst x1, #1
    b.eq do_concat_5118
do_apply_5117:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5119
do_concat_5118:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5119:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_true
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5121
    tst x1, #1
    b.eq do_concat_5121
do_apply_5120:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5122
do_concat_5121:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5122:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5124
    tst x1, #1
    b.eq do_concat_5124
do_apply_5123:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5125
do_concat_5124:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5125:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5127
    tst x1, #1
    b.eq do_concat_5127
do_apply_5126:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5128
do_concat_5127:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5128:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5130
    tst x1, #1
    b.eq do_concat_5130
do_apply_5129:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5131
do_concat_5130:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5131:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5133
    tst x1, #1
    b.eq do_concat_5133
do_apply_5132:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5134
do_concat_5133:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5134:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5136
    tst x1, #1
    b.eq do_concat_5136
do_apply_5135:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5137
do_concat_5136:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5137:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_77
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5139
    tst x1, #1
    b.eq do_concat_5139
do_apply_5138:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5140
do_concat_5139:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5140:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_60
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5142
    tst x1, #1
    b.eq do_concat_5142
do_apply_5141:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5143
do_concat_5142:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5143:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5145
    tst x1, #1
    b.eq do_concat_5145
do_apply_5144:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5146
do_concat_5145:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5146:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5148
    tst x1, #1
    b.eq do_concat_5148
do_apply_5147:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5149
do_concat_5148:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5149:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5151
    tst x1, #1
    b.eq do_concat_5151
do_apply_5150:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5152
do_concat_5151:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5152:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5154
    tst x1, #1
    b.eq do_concat_5154
do_apply_5153:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5155
do_concat_5154:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5155:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_true
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5157
    tst x1, #1
    b.eq do_concat_5157
do_apply_5156:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5158
do_concat_5157:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5158:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5160
    tst x1, #1
    b.eq do_concat_5160
do_apply_5159:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5161
do_concat_5160:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5161:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5163
    tst x1, #1
    b.eq do_concat_5163
do_apply_5162:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5164
do_concat_5163:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5164:
    str x0, [sp, #-16]!
    adr x0, str_78
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5165
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5167
    tst x1, #1
    b.eq do_concat_5167
do_apply_5166:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5168
do_concat_5167:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5168:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5170
    tst x1, #1
    b.eq do_concat_5170
do_apply_5169:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5171
do_concat_5170:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5171:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5173
    tst x1, #1
    b.eq do_concat_5173
do_apply_5172:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5174
do_concat_5173:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5174:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5176
    tst x1, #1
    b.eq do_concat_5176
do_apply_5175:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5177
do_concat_5176:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5177:
blk_end_5165:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5179
    tst x1, #1
    b.eq do_concat_5179
do_apply_5178:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5180
do_concat_5179:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5180:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5182
    tst x1, #1
    b.eq do_concat_5182
do_apply_5181:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5183
do_concat_5182:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5183:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5185
    tst x1, #1
    b.eq do_concat_5185
do_apply_5184:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5186
do_concat_5185:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5186:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5188
    tst x1, #1
    b.eq do_concat_5188
do_apply_5187:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5189
do_concat_5188:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5189:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5191
    tst x1, #1
    b.eq do_concat_5191
do_apply_5190:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5192
do_concat_5191:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5192:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5194
    tst x1, #1
    b.eq do_concat_5194
do_apply_5193:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5195
do_concat_5194:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5195:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5197
    tst x1, #1
    b.eq do_concat_5197
do_apply_5196:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5198
do_concat_5197:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5198:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5200
    tst x1, #1
    b.eq do_concat_5200
do_apply_5199:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5201
do_concat_5200:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5201:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5203
    tst x1, #1
    b.eq do_concat_5203
do_apply_5202:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5204
do_concat_5203:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5204:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5206
    tst x1, #1
    b.eq do_concat_5206
do_apply_5205:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5207
do_concat_5206:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5207:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5092
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_final
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5209
    tst x1, #1
    b.eq do_concat_5209
do_apply_5208:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5210
do_concat_5209:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5210:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5212
    tst x1, #1
    b.eq do_concat_5212
do_apply_5211:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5213
do_concat_5212:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5213:
blk_end_5092:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5215
    tst x1, #1
    b.eq do_concat_5215
do_apply_5214:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5216
do_concat_5215:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5216:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5218
    tst x1, #1
    b.eq do_concat_5218
do_apply_5217:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5219
do_concat_5218:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5219:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5089
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5221
    tst x1, #1
    b.eq do_concat_5221
do_apply_5220:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5222
do_concat_5221:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5222:
blk_end_5089:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5224
    tst x1, #1
    b.eq do_concat_5224
do_apply_5223:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5225
do_concat_5224:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5225:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5082
    adr x0, new_label
    str x0, [sp, #-16]!
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5227
    tst x1, #1
    b.eq do_concat_5227
do_apply_5226:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5228
do_concat_5227:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5228:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5230
    tst x1, #1
    b.eq do_concat_5230
do_apply_5229:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5231
do_concat_5230:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5231:
    str x0, [sp, #-16]!
    adr x0, str_79
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5233
    tst x1, #1
    b.eq do_concat_5233
do_apply_5232:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5234
do_concat_5233:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5234:
    str x0, [sp, #-16]!
    adr x0, new_label
    str x0, [sp, #-16]!
    adr x0, ctx_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5236
    tst x1, #1
    b.eq do_concat_5236
do_apply_5235:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5237
do_concat_5236:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5237:
    str x0, [sp, #-16]!
    adr x0, str_80
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5239
    tst x1, #1
    b.eq do_concat_5239
do_apply_5238:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5240
do_concat_5239:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5240:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5242
    tst x1, #1
    b.eq do_concat_5242
do_apply_5241:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5243
do_concat_5242:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5243:
blk_end_5082:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5245
    tst x1, #1
    b.eq do_concat_5245
do_apply_5244:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5246
do_concat_5245:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5246:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5077
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5248
    tst x1, #1
    b.eq do_concat_5248
do_apply_5247:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5249
do_concat_5248:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5249:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5251
    tst x1, #1
    b.eq do_concat_5251
do_apply_5250:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5252
do_concat_5251:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5252:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5254
    tst x1, #1
    b.eq do_concat_5254
do_apply_5253:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5255
do_concat_5254:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5255:
blk_end_5077:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5257
    tst x1, #1
    b.eq do_concat_5257
do_apply_5256:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5258
do_concat_5257:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5258:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5074
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5260
    tst x1, #1
    b.eq do_concat_5260
do_apply_5259:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5261
do_concat_5260:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5261:
    str x0, [sp, #-16]!
    adr x0, ctx_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5263
    tst x1, #1
    b.eq do_concat_5263
do_apply_5262:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5264
do_concat_5263:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5264:
blk_end_5074:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5266
    tst x1, #1
    b.eq do_concat_5266
do_apply_5265:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5267
do_concat_5266:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5267:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5069
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5269
    tst x1, #1
    b.eq do_concat_5269
do_apply_5268:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5270
do_concat_5269:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5270:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5272
    tst x1, #1
    b.eq do_concat_5272
do_apply_5271:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5273
do_concat_5272:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5273:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5275
    tst x1, #1
    b.eq do_concat_5275
do_apply_5274:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5276
do_concat_5275:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5276:
blk_end_5069:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5278
    tst x1, #1
    b.eq do_concat_5278
do_apply_5277:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5279
do_concat_5278:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5279:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5066
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5281
    tst x1, #1
    b.eq do_concat_5281
do_apply_5280:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5282
do_concat_5281:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5282:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5284
    tst x1, #1
    b.eq do_concat_5284
do_apply_5283:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5285
do_concat_5284:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5285:
blk_end_5066:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5287
    tst x1, #1
    b.eq do_concat_5287
do_apply_5286:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5288
do_concat_5287:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5288:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5061
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5290
    tst x1, #1
    b.eq do_concat_5290
do_apply_5289:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5291
do_concat_5290:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5291:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5293
    tst x1, #1
    b.eq do_concat_5293
do_apply_5292:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5294
do_concat_5293:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5294:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5296
    tst x1, #1
    b.eq do_concat_5296
do_apply_5295:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5297
do_concat_5296:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5297:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5299
    tst x1, #1
    b.eq do_concat_5299
do_apply_5298:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5300
do_concat_5299:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5300:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5302
    tst x1, #1
    b.eq do_concat_5302
do_apply_5301:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5303
do_concat_5302:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5303:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5305
    tst x1, #1
    b.eq do_concat_5305
do_apply_5304:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5306
do_concat_5305:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5306:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5308
    tst x1, #1
    b.eq do_concat_5308
do_apply_5307:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5309
do_concat_5308:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5309:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5311
    tst x1, #1
    b.eq do_concat_5311
do_apply_5310:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5312
do_concat_5311:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5312:
blk_end_5061:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5059_5060:
    // Closure for func_5059
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
    adr x1, func_5059
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5057_5058:
    // Closure for func_5057
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5057
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5055_5056:
    // Closure for func_5055
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5055
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5051
cond_false_5050:
    adr x0, sign_id
cond_end_5051:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_block
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5316
    tst x1, #1
    b.eq do_concat_5316
do_apply_5315:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5317
do_concat_5316:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5317:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5313
    b after_func_5318_5319
func_5318:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5320_5321
func_5320:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5323_5324
func_5323:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5323_5324:
    // Closure for func_5323
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5323
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, stmts
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5328
    adr x0, sign_id
    b cmp_end_5329
cmp_true_5328:
cmp_end_5329:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5326
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5331
    tst x1, #1
    b.eq do_concat_5331
do_apply_5330:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5332
do_concat_5331:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5332:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5334
    tst x1, #1
    b.eq do_concat_5334
do_apply_5333:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5335
do_concat_5334:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5335:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5337
    tst x1, #1
    b.eq do_concat_5337
do_apply_5336:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5338
do_concat_5337:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5338:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5340
    tst x1, #1
    b.eq do_concat_5340
do_apply_5339:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5341
do_concat_5340:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5341:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5343
    tst x1, #1
    b.eq do_concat_5343
do_apply_5342:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5344
do_concat_5343:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5344:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5346
    tst x1, #1
    b.eq do_concat_5346
do_apply_5345:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5347
do_concat_5346:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5347:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5349
    tst x1, #1
    b.eq do_concat_5349
do_apply_5348:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5350
do_concat_5349:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5350:
    b cond_end_5327
cond_false_5326:
    adr x0, sign_id
cond_end_5327:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5325
    b after_func_5351_5352
func_5351:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5351_5352:
    // Closure for func_5351
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5351
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5354_5355
func_5354:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5354_5355:
    // Closure for func_5354
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5354
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5357_5358
func_5357:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5359_5360
func_5359:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5359_5360:
    // Closure for func_5359
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5359
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5357_5358:
    // Closure for func_5357
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5357
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5363
    tst x1, #1
    b.eq do_concat_5363
do_apply_5362:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5364
do_concat_5363:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5364:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5366
    tst x1, #1
    b.eq do_concat_5366
do_apply_5365:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5367
do_concat_5366:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5367:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5369
    tst x1, #1
    b.eq do_concat_5369
do_apply_5368:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5370
do_concat_5369:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5370:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5372
    tst x1, #1
    b.eq do_concat_5372
do_apply_5371:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5373
do_concat_5372:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5373:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5375
    tst x1, #1
    b.eq do_concat_5375
do_apply_5374:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5376
do_concat_5375:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5376:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5378
    tst x1, #1
    b.eq do_concat_5378
do_apply_5377:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5379
do_concat_5378:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5379:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5361
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5381
    tst x1, #1
    b.eq do_concat_5381
do_apply_5380:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5382
do_concat_5381:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5382:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5384
    tst x1, #1
    b.eq do_concat_5384
do_apply_5383:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5385
do_concat_5384:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5385:
blk_end_5361:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5387
    tst x1, #1
    b.eq do_concat_5387
do_apply_5386:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5388
do_concat_5387:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5388:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5390
    tst x1, #1
    b.eq do_concat_5390
do_apply_5389:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5391
do_concat_5390:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5391:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5356
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5393
    tst x1, #1
    b.eq do_concat_5393
do_apply_5392:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5394
do_concat_5393:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5394:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5396
    tst x1, #1
    b.eq do_concat_5396
do_apply_5395:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5397
do_concat_5396:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5397:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5399
    tst x1, #1
    b.eq do_concat_5399
do_apply_5398:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5400
do_concat_5399:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5400:
blk_end_5356:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5402
    tst x1, #1
    b.eq do_concat_5402
do_apply_5401:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5403
do_concat_5402:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5403:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5353
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    adr x0, stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5405
    tst x1, #1
    b.eq do_concat_5405
do_apply_5404:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5406
do_concat_5405:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5406:
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5408
    tst x1, #1
    b.eq do_concat_5408
do_apply_5407:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5409
do_concat_5408:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5409:
    str x0, [sp, #-16]!
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    adr x0, res_lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5411
    tst x1, #1
    b.eq do_concat_5411
do_apply_5410:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5412
do_concat_5411:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5412:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5414
    tst x1, #1
    b.eq do_concat_5414
do_apply_5413:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5415
do_concat_5414:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5415:
blk_end_5353:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5417
    tst x1, #1
    b.eq do_concat_5417
do_apply_5416:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5418
do_concat_5417:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5418:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5325
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5420
    tst x1, #1
    b.eq do_concat_5420
do_apply_5419:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5421
do_concat_5420:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5421:
    str x0, [sp, #-16]!
    adr x0, str_81
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5423
    tst x1, #1
    b.eq do_concat_5423
do_apply_5422:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5424
do_concat_5423:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5424:
blk_end_5325:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5426
    tst x1, #1
    b.eq do_concat_5426
do_apply_5425:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5427
do_concat_5426:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5427:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5322
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5429
    tst x1, #1
    b.eq do_concat_5429
do_apply_5428:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5430
do_concat_5429:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5430:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5432
    tst x1, #1
    b.eq do_concat_5432
do_apply_5431:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5433
do_concat_5432:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5433:
blk_end_5322:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5320_5321:
    // Closure for func_5320
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5320
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5318_5319:
    // Closure for func_5318
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5318
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5314
cond_false_5313:
    adr x0, sign_id
cond_end_5314:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5437
    tst x1, #1
    b.eq do_concat_5437
do_apply_5436:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5438
do_concat_5437:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5438:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5434
    b after_func_5439_5440
func_5439:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5441_5442
func_5441:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_5443_5444
func_5443:
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
    b after_func_5446_5447
func_5446:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5446_5447:
    // Closure for func_5446
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5446
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5449_5450
func_5449:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5449_5450:
    // Closure for func_5449
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5449
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tail_stmts
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5454
    adr x0, sign_id
    b cmp_end_5455
cmp_true_5454:
cmp_end_5455:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5452
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_82
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5456
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, head_stmt
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5458
    tst x1, #1
    b.eq do_concat_5458
do_apply_5457:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5459
do_concat_5458:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5459:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5461
    tst x1, #1
    b.eq do_concat_5461
do_apply_5460:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5462
do_concat_5461:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5462:
blk_end_5456:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5464
    tst x1, #1
    b.eq do_concat_5464
do_apply_5463:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5465
do_concat_5464:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5465:
    b cond_end_5453
cond_false_5452:
    adr x0, sign_id
cond_end_5453:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5451
    adr x0, str_83
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5451
    b after_func_5466_5467
func_5466:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5466_5467:
    // Closure for func_5466
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5466
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5469_5470
func_5469:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5471_5472
func_5471:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5471_5472:
    // Closure for func_5471
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5471
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5469_5470:
    // Closure for func_5469
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5469
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5474_5475
func_5474:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5474_5475:
    // Closure for func_5474
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5474
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5477_5478
func_5477:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5479_5480
func_5479:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5479_5480:
    // Closure for func_5479
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5479
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5477_5478:
    // Closure for func_5477
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5477
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, asm_head
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5483
    tst x1, #1
    b.eq do_concat_5483
do_apply_5482:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5484
do_concat_5483:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5484:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_84
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5486
    tst x1, #1
    b.eq do_concat_5486
do_apply_5485:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5487
do_concat_5486:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5487:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_85
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5489
    tst x1, #1
    b.eq do_concat_5489
do_apply_5488:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5490
do_concat_5489:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5490:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_86
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5492
    tst x1, #1
    b.eq do_concat_5492
do_apply_5491:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5493
do_concat_5492:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5493:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5495
    tst x1, #1
    b.eq do_concat_5495
do_apply_5494:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5496
do_concat_5495:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5496:
    str x0, [sp, #-16]!
    adr x0, str_33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5498
    tst x1, #1
    b.eq do_concat_5498
do_apply_5497:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5499
do_concat_5498:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5499:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5501
    tst x1, #1
    b.eq do_concat_5501
do_apply_5500:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5502
do_concat_5501:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5502:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5504
    tst x1, #1
    b.eq do_concat_5504
do_apply_5503:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5505
do_concat_5504:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5505:
    str x0, [sp, #-16]!
    adr x0, asm_tail
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5507
    tst x1, #1
    b.eq do_concat_5507
do_apply_5506:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5508
do_concat_5507:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5508:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5510
    tst x1, #1
    b.eq do_concat_5510
do_apply_5509:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5511
do_concat_5510:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5511:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5513
    tst x1, #1
    b.eq do_concat_5513
do_apply_5512:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5514
do_concat_5513:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5514:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5516
    tst x1, #1
    b.eq do_concat_5516
do_apply_5515:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5517
do_concat_5516:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5517:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5481
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_tail
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5519
    tst x1, #1
    b.eq do_concat_5519
do_apply_5518:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5520
do_concat_5519:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5520:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5522
    tst x1, #1
    b.eq do_concat_5522
do_apply_5521:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5523
do_concat_5522:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5523:
blk_end_5481:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5525
    tst x1, #1
    b.eq do_concat_5525
do_apply_5524:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5526
do_concat_5525:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5526:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5528
    tst x1, #1
    b.eq do_concat_5528
do_apply_5527:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5529
do_concat_5528:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5529:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5476
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_tail
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5531
    tst x1, #1
    b.eq do_concat_5531
do_apply_5530:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5532
do_concat_5531:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5532:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_tail
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5534
    tst x1, #1
    b.eq do_concat_5534
do_apply_5533:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5535
do_concat_5534:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5535:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5537
    tst x1, #1
    b.eq do_concat_5537
do_apply_5536:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5538
do_concat_5537:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5538:
blk_end_5476:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5540
    tst x1, #1
    b.eq do_concat_5540
do_apply_5539:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5541
do_concat_5540:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5541:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5473
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    adr x0, tail_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5543
    tst x1, #1
    b.eq do_concat_5543
do_apply_5542:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5544
do_concat_5543:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5544:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5546
    tst x1, #1
    b.eq do_concat_5546
do_apply_5545:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5547
do_concat_5546:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5547:
    str x0, [sp, #-16]!
    adr x0, ctx_head
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5549
    tst x1, #1
    b.eq do_concat_5549
do_apply_5548:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5550
do_concat_5549:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5550:
blk_end_5473:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5552
    tst x1, #1
    b.eq do_concat_5552
do_apply_5551:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5553
do_concat_5552:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5553:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5468
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_head
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5555
    tst x1, #1
    b.eq do_concat_5555
do_apply_5554:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5556
do_concat_5555:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5556:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_head
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5558
    tst x1, #1
    b.eq do_concat_5558
do_apply_5557:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5559
do_concat_5558:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5559:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5561
    tst x1, #1
    b.eq do_concat_5561
do_apply_5560:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5562
do_concat_5561:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5562:
blk_end_5468:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5564
    tst x1, #1
    b.eq do_concat_5564
do_apply_5563:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5565
do_concat_5564:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5565:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5451
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, head_stmt
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5567
    tst x1, #1
    b.eq do_concat_5567
do_apply_5566:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5568
do_concat_5567:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5568:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5570
    tst x1, #1
    b.eq do_concat_5570
do_apply_5569:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5571
do_concat_5570:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5571:
blk_end_5451:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5573
    tst x1, #1
    b.eq do_concat_5573
do_apply_5572:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5574
do_concat_5573:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5574:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5448
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5576
    tst x1, #1
    b.eq do_concat_5576
do_apply_5575:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5577
do_concat_5576:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5577:
blk_end_5448:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5579
    tst x1, #1
    b.eq do_concat_5579
do_apply_5578:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5580
do_concat_5579:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5580:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5445
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5582
    tst x1, #1
    b.eq do_concat_5582
do_apply_5581:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5583
do_concat_5582:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5583:
blk_end_5445:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5443_5444:
    // Closure for func_5443
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
    adr x1, func_5443
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5441_5442:
    // Closure for func_5441
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5441
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5439_5440:
    // Closure for func_5439
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5439
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5435
cond_false_5434:
    adr x0, sign_id
cond_end_5435:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat_lists
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5587
    tst x1, #1
    b.eq do_concat_5587
do_apply_5586:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5588
do_concat_5587:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5588:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5584
    b after_func_5589_5590
func_5589:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5591_5592
func_5591:
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
    b.eq cmp_true_5596
    adr x0, sign_id
    b cmp_end_5597
cmp_true_5596:
cmp_end_5597:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5594
    ldr x0, [x29, #-32]
    b cond_end_5595
cond_false_5594:
    adr x0, sign_id
cond_end_5595:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5593
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5599
    tst x1, #1
    b.eq do_concat_5599
do_apply_5598:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5600
do_concat_5599:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5600:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5602
    tst x1, #1
    b.eq do_concat_5602
do_apply_5601:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5603
do_concat_5602:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5603:
    str x0, [sp, #-16]!
    adr x0, concat_lists
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5605
    tst x1, #1
    b.eq do_concat_5605
do_apply_5604:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5606
do_concat_5605:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5606:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5608
    tst x1, #1
    b.eq do_concat_5608
do_apply_5607:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5609
do_concat_5608:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5609:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5611
    tst x1, #1
    b.eq do_concat_5611
do_apply_5610:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5612
do_concat_5611:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5612:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5614
    tst x1, #1
    b.eq do_concat_5614
do_apply_5613:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5615
do_concat_5614:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5615:
blk_end_5593:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5591_5592:
    // Closure for func_5591
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5591
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5589_5590:
    // Closure for func_5589
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5589
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5585
cond_false_5584:
    adr x0, sign_id
cond_end_5585:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5619
    tst x1, #1
    b.eq do_concat_5619
do_apply_5618:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5620
do_concat_5619:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5620:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5616
    b after_func_5621_5622
func_5621:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5624
    tst x1, #1
    b.eq do_concat_5624
do_apply_5623:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5625
do_concat_5624:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5625:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5621_5622:
    // Closure for func_5621
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5621
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5617
cond_false_5616:
    adr x0, sign_id
cond_end_5617:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_from_res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5629
    tst x1, #1
    b.eq do_concat_5629
do_apply_5628:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5630
do_concat_5629:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5630:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5626
    b after_func_5631_5632
func_5631:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5634
    tst x1, #1
    b.eq do_concat_5634
do_apply_5633:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5635
do_concat_5634:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5635:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5637
    tst x1, #1
    b.eq do_concat_5637
do_apply_5636:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5638
do_concat_5637:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5638:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5631_5632:
    // Closure for func_5631
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5631
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5627
cond_false_5626:
    adr x0, sign_id
cond_end_5627:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, res_lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5642
    tst x1, #1
    b.eq do_concat_5642
do_apply_5641:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5643
do_concat_5642:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5643:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5639
    b after_func_5644_5645
func_5644:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str_87
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5647
    tst x1, #1
    b.eq do_concat_5647
do_apply_5646:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5648
do_concat_5647:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5648:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5644_5645:
    // Closure for func_5644
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5644
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5640
cond_false_5639:
    adr x0, sign_id
cond_end_5640:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_from_lbl
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5652
    tst x1, #1
    b.eq do_concat_5652
do_apply_5651:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5653
do_concat_5652:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5653:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5649
    b after_func_5654_5655
func_5654:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5657
    tst x1, #1
    b.eq do_concat_5657
do_apply_5656:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5658
do_concat_5657:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5658:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5660
    tst x1, #1
    b.eq do_concat_5660
do_apply_5659:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5661
do_concat_5660:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5661:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5654_5655:
    // Closure for func_5654
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5654
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5650
cond_false_5649:
    adr x0, sign_id
cond_end_5650:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, main
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5665
    tst x1, #1
    b.eq do_concat_5665
do_apply_5664:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5666
do_concat_5665:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5666:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5662
    b after_func_5667_5668
func_5667:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _test
    str x0, [sp, #-16]!
    adr x0, str_88
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5671
    tst x1, #1
    b.eq do_concat_5671
do_apply_5670:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5672
do_concat_5671:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5672:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5669
    adr x0, _test
    str x0, [sp, #-16]!
    adr x0, str_89
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5674
    tst x1, #1
    b.eq do_concat_5674
do_apply_5673:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5675
do_concat_5674:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5675:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5669
    adr x0, _test
    str x0, [sp, #-16]!
    adr x0, str_90
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5677
    tst x1, #1
    b.eq do_concat_5677
do_apply_5676:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5678
do_concat_5677:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5678:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5669
    adr x0, _test
    str x0, [sp, #-16]!
    adr x0, str_91
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5680
    tst x1, #1
    b.eq do_concat_5680
do_apply_5679:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5681
do_concat_5680:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5681:
blk_end_5669:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5667_5668:
    // Closure for func_5667
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5667
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5663
cond_false_5662:
    adr x0, sign_id
cond_end_5663:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _test
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5685
    tst x1, #1
    b.eq do_concat_5685
do_apply_5684:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5686
do_concat_5685:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5686:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5682
    b after_func_5687_5688
func_5687:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_92
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5691
    tst x1, #1
    b.eq do_concat_5691
do_apply_5690:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5692
do_concat_5691:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5692:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5689
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5694
    tst x1, #1
    b.eq do_concat_5694
do_apply_5693:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5695
do_concat_5694:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5695:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5689
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_93
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5697
    tst x1, #1
    b.eq do_concat_5697
do_apply_5696:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5698
do_concat_5697:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5698:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5689
    adr x0, tokenize
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5700
    tst x1, #1
    b.eq do_concat_5700
do_apply_5699:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5701
do_concat_5700:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5701:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5689
    b after_func_5702_5703
func_5702:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5702_5703:
    // Closure for func_5702
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5702
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5705_5706
func_5705:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5705_5706:
    // Closure for func_5705
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5705
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5708_5709
func_5708:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5708_5709:
    // Closure for func_5708
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5708
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, res_compile
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5712
    tst x1, #1
    b.eq do_concat_5712
do_apply_5711:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5713
do_concat_5712:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5713:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5710
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5715
    tst x1, #1
    b.eq do_concat_5715
do_apply_5714:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5716
do_concat_5715:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5716:
blk_end_5710:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5718
    tst x1, #1
    b.eq do_concat_5718
do_apply_5717:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5719
do_concat_5718:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5719:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5707
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, ast
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5721
    tst x1, #1
    b.eq do_concat_5721
do_apply_5720:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5722
do_concat_5721:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5722:
blk_end_5707:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5724
    tst x1, #1
    b.eq do_concat_5724
do_apply_5723:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5725
do_concat_5724:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5725:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5704
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_parse
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5727
    tst x1, #1
    b.eq do_concat_5727
do_apply_5726:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5728
do_concat_5727:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5728:
blk_end_5704:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5730
    tst x1, #1
    b.eq do_concat_5730
do_apply_5729:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5731
do_concat_5730:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5731:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5689
    adr x0, parse_program
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5733
    tst x1, #1
    b.eq do_concat_5733
do_apply_5732:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5734
do_concat_5733:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5734:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_5689
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5736
    tst x1, #1
    b.eq do_concat_5736
do_apply_5735:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5737
do_concat_5736:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5737:
blk_end_5689:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5687_5688:
    // Closure for func_5687
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5687
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5683
cond_false_5682:
    adr x0, sign_id
cond_end_5683:
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
.balign 8
.global _str_start
_str_start:
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

.global _str_end
_str_end:
