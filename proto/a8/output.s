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

    adr x0, print_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1
    b after_func_5_6
func_5:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, buf
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5_6:
    // Closure for func_5
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_7
do_apply_8:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_9
do_compose_7:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_9:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_10
do_apply_11:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_12
do_compose_10:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_12:
    b cond_end_4
cond_false_3:
    adr x0, sign_id
cond_end_4:
    b cond_end_2
cond_false_1:
    adr x0, sign_id
cond_end_2:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_13
do_apply_14:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_15
do_compose_13:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_15:
    str x0, [sp, #-16]!
    adr x0, buf
    cmp x0, #4096
    b.hi do_compose_16
do_apply_17:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_18
do_compose_16:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_18:
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_19
do_apply_20:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_21
do_compose_19:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_21:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_22
    b after_func_26_27
func_26:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, len
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_26_27:
    // Closure for func_26
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_26
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_24
    b after_func_28_29
func_28:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_33_34
func_33:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_35_36
func_35:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_37_38
func_37:
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
after_func_37_38:
    // Closure for func_37
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_37
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_39
do_apply_40:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_41
do_compose_39:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_41:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_42
do_apply_43:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_44
do_compose_42:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_44:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_33_34:
    // Closure for func_33
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_33
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_45_46
func_45:
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
after_func_45_46:
    // Closure for func_45
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_45
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_30
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_32
xor_true_30:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_31
    adr x0, sign_id
    b xor_end_32
xor_false_31:
    mov x0, x1
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
    b cond_end_25
cond_false_24:
    adr x0, sign_id
cond_end_25:
    b cond_end_23
cond_false_22:
    adr x0, sign_id
cond_end_23:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, p
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #2
    adr x1, cnt
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    adr x1, char
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, char
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_49
    adr x0, sign_id
    b cmp_end_50
cmp_true_49:
cmp_end_50:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_47
    adr x0, cnt
    ldr x0, [x0]
    b cond_end_48
cond_false_47:
    adr x0, sign_id
cond_end_48:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, len_loop
    str x0, [sp, #-16]!
    adr x0, p
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_51
do_apply_52:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_53
do_compose_51:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_53:
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_54
do_apply_55:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_56
do_compose_54:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_56:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_57
do_apply_58:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_59
do_compose_57:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_59:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_60
do_apply_61:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_62
do_compose_60:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_62:
    str x0, [sp, #-16]!
    adr x0, str
    cmp x0, #4096
    b.hi do_compose_63
do_apply_64:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_65
do_compose_63:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_65:
    str x0, [sp, #-16]!
    adr x0, len
    cmp x0, #4096
    b.hi do_compose_66
do_apply_67:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_68
do_compose_66:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_68:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_num
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_69
    b after_func_73_74
func_73:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_75
    adr x0, sign_id
    b cmp_end_76
cmp_true_75:
cmp_end_76:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_73_74:
    // Closure for func_73
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_73
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_71
    adr x0, sign_id
    b cond_end_72
cond_false_71:
    adr x0, sign_id
cond_end_72:
    b cond_end_70
cond_false_69:
    adr x0, sign_id
cond_end_70:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #48
    cmp x0, #4096
    b.hi do_compose_77
do_apply_78:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_79
do_compose_77:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_79:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_82
    adr x0, sign_id
    b cmp_end_83
cmp_true_82:
cmp_end_83:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_80
    adr x0, sign_id
    b cond_end_81
cond_false_80:
    adr x0, sign_id
cond_end_81:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #45
    cmp x0, #4096
    b.hi do_compose_84
do_apply_85:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_86
do_compose_84:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_86:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_num
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, n
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_87
do_apply_88:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_89
do_compose_87:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_89:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_90
do_apply_91:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_92
do_compose_90:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_92:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_num_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_93
    b after_func_97_98
func_97:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_99
    adr x0, sign_id
    b cmp_end_100
cmp_true_99:
cmp_end_100:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_97_98:
    // Closure for func_97
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_97
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_95
    mov x0, #0
    b cond_end_96
cond_false_95:
    adr x0, sign_id
cond_end_96:
    b cond_end_94
cond_false_93:
    adr x0, sign_id
cond_end_94:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_101
do_apply_102:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_103
do_compose_101:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_103:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #48
    str x0, [sp, #-16]!
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_104
do_apply_105:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_106
do_compose_104:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_106:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str_ln
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_107
    b after_func_109_110
func_109:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_111
do_apply_112:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_113
do_compose_111:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_113:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_109_110:
    // Closure for func_109
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_109
    ldr x0, [sp], #16
    bl _cons
    b cond_end_108
cond_false_107:
    adr x0, sign_id
cond_end_108:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_114
do_apply_115:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_116
do_compose_114:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_116:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_list_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_117
    b after_func_121_122
func_121:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_123
    adr x0, sign_id
    b cmp_end_124
cmp_true_123:
cmp_end_124:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_121_122:
    // Closure for func_121
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_121
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_119
    mov x0, #0
    b cond_end_120
cond_false_119:
    adr x0, sign_id
cond_end_120:
    b cond_end_118
cond_false_117:
    adr x0, sign_id
cond_end_118:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_125
do_apply_126:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_127
do_compose_125:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_127:
    cmp x0, #4096
    b.hi do_compose_128
do_apply_129:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_130
do_compose_128:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_130:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_list_str
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_131
do_apply_132:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_133
do_compose_131:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_133:
    cmp x0, #4096
    b.hi do_compose_134
do_apply_135:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_136
do_compose_134:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_136:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sys_brk
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_137
do_apply_138:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_139
do_compose_137:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_139:
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
    cmp x0, #4096
    b.hi do_compose_140
do_apply_141:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_142
do_compose_140:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_142:
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
    adr x0, alloc
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_143
    b after_func_145_146
func_145:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, curr
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
    adr x0, heap_addr
    ldr x0, [x0]
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_144
cond_false_143:
    adr x0, sign_id
cond_end_144:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, heap_addr
    str x0, [sp, #-16]!
    adr x0, curr
    str x0, [sp, #-16]!
    adr x0, size
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, curr
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_147
    b after_func_151_152
func_151:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, addr
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_151_152:
    // Closure for func_151
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_151
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_149
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #16
    cmp x0, #4096
    b.hi do_compose_153
do_apply_154:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_155
do_compose_153:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_155:
    b cond_end_150
cond_false_149:
    adr x0, sign_id
cond_end_150:
    b cond_end_148
cond_false_147:
    adr x0, sign_id
cond_end_148:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, addr
    str x0, [sp, #-16]!
    adr x0, head
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, addr
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, tail
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, addr
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_156
    b after_func_158_159
func_158:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_158_159:
    // Closure for func_158
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_158
    ldr x0, [sp], #16
    bl _cons
    b cond_end_157
cond_false_156:
    adr x0, sign_id
cond_end_157:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tail
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_160
    b after_func_162_163
func_162:
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
after_func_162_163:
    // Closure for func_162
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_162
    ldr x0, [sp], #16
    bl _cons
    b cond_end_161
cond_false_160:
    adr x0, sign_id
cond_end_161:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, nth
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_164
    b after_func_168_169
func_168:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, index
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_170
    adr x0, sign_id
    b cmp_end_171
cmp_true_170:
cmp_end_171:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_166
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_172
do_apply_173:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_174
do_compose_172:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_174:
    b cond_end_167
cond_false_166:
    adr x0, sign_id
cond_end_167:
    b cond_end_165
cond_false_164:
    adr x0, sign_id
cond_end_165:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_175
do_apply_176:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_177
do_compose_175:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_177:
    cmp x0, #4096
    b.hi do_compose_178
do_apply_179:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_180
do_compose_178:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_180:
    str x0, [sp, #-16]!
    adr x0, index
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_181
do_apply_182:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_183
do_compose_181:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_183:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Pure
    cmp x0, #4096
    b.hi do_compose_184
do_apply_185:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_186
do_compose_184:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_186:
    str x0, [sp, #-16]!
    adr x0, Functional
    cmp x0, #4096
    b.hi do_compose_187
do_apply_188:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_189
do_compose_187:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_189:
    str x0, [sp, #-16]!
    adr x0, Lexer
    cmp x0, #4096
    b.hi do_compose_190
do_apply_191:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_192
do_compose_190:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_192:
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
    cmp x0, #4096
    b.hi do_compose_193
do_apply_194:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_195
do_compose_193:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_195:
    str x0, [sp, #-16]!
    adr x0, Version
    cmp x0, #4096
    b.hi do_compose_196
do_apply_197:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_198
do_compose_196:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_198:
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
    adr x0, is_space
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_199
    b after_func_201_202
func_201:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_207
    adr x0, sign_id
    b cmp_end_208
cmp_true_207:
cmp_end_208:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_205
    b or_end_206
or_right_205:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_209
    adr x0, sign_id
    b cmp_end_210
cmp_true_209:
cmp_end_210:
or_end_206:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_203
    b or_end_204
or_right_203:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_211
    adr x0, sign_id
    b cmp_end_212
cmp_true_211:
cmp_end_212:
or_end_204:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_201_202:
    // Closure for func_201
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_201
    ldr x0, [sp], #16
    bl _cons
    b cond_end_200
cond_false_199:
    adr x0, sign_id
cond_end_200:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_digit
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_213
    b after_func_215_216
func_215:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_219
    adr x0, sign_id
    b cmp_end_220
cmp_true_219:
cmp_end_220:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_217
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_221
    adr x0, sign_id
    b cmp_end_222
cmp_true_221:
cmp_end_222:
    b and_end_218
and_fail_217:
    adr x0, sign_id
and_end_218:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_215_216:
    // Closure for func_215
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_215
    ldr x0, [sp], #16
    bl _cons
    b cond_end_214
cond_false_213:
    adr x0, sign_id
cond_end_214:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_alpha
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_223
    b after_func_225_226
func_225:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_233
    adr x0, sign_id
    b cmp_end_234
cmp_true_233:
cmp_end_234:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_231
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_235
    adr x0, sign_id
    b cmp_end_236
cmp_true_235:
cmp_end_236:
    b and_end_232
and_fail_231:
    adr x0, sign_id
and_end_232:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_229
    b or_end_230
or_right_229:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_239
    adr x0, sign_id
    b cmp_end_240
cmp_true_239:
cmp_end_240:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_237
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_241
    adr x0, sign_id
    b cmp_end_242
cmp_true_241:
cmp_end_242:
    b and_end_238
and_fail_237:
    adr x0, sign_id
and_end_238:
or_end_230:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_227
    b or_end_228
or_right_227:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_243
    adr x0, sign_id
    b cmp_end_244
cmp_true_243:
cmp_end_244:
or_end_228:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_225_226:
    // Closure for func_225
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_225
    ldr x0, [sp], #16
    bl _cons
    b cond_end_224
cond_false_223:
    adr x0, sign_id
cond_end_224:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_op_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_245
    b after_func_247_248
func_247:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_279
    adr x0, sign_id
    b cmp_end_280
cmp_true_279:
cmp_end_280:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_277
    b or_end_278
or_right_277:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_281
    adr x0, sign_id
    b cmp_end_282
cmp_true_281:
cmp_end_282:
or_end_278:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_275
    b or_end_276
or_right_275:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_283
    adr x0, sign_id
    b cmp_end_284
cmp_true_283:
cmp_end_284:
or_end_276:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_273
    b or_end_274
or_right_273:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_285
    adr x0, sign_id
    b cmp_end_286
cmp_true_285:
cmp_end_286:
or_end_274:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_271
    b or_end_272
or_right_271:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_287
    adr x0, sign_id
    b cmp_end_288
cmp_true_287:
cmp_end_288:
or_end_272:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_269
    b or_end_270
or_right_269:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_289
    adr x0, sign_id
    b cmp_end_290
cmp_true_289:
cmp_end_290:
or_end_270:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_267
    b or_end_268
or_right_267:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_291
    adr x0, sign_id
    b cmp_end_292
cmp_true_291:
cmp_end_292:
or_end_268:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_265
    b or_end_266
or_right_265:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_293
    adr x0, sign_id
    b cmp_end_294
cmp_true_293:
cmp_end_294:
or_end_266:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_263
    b or_end_264
or_right_263:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_295
    adr x0, sign_id
    b cmp_end_296
cmp_true_295:
cmp_end_296:
or_end_264:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_261
    b or_end_262
or_right_261:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_297
    adr x0, sign_id
    b cmp_end_298
cmp_true_297:
cmp_end_298:
or_end_262:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_259
    b or_end_260
or_right_259:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_299
    adr x0, sign_id
    b cmp_end_300
cmp_true_299:
cmp_end_300:
or_end_260:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_257
    b or_end_258
or_right_257:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_301
    adr x0, sign_id
    b cmp_end_302
cmp_true_301:
cmp_end_302:
or_end_258:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_255
    b or_end_256
or_right_255:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_303
    adr x0, sign_id
    b cmp_end_304
cmp_true_303:
cmp_end_304:
or_end_256:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_253
    b or_end_254
or_right_253:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_305
    adr x0, sign_id
    b cmp_end_306
cmp_true_305:
cmp_end_306:
or_end_254:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_251
    b or_end_252
or_right_251:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_307
    adr x0, sign_id
    b cmp_end_308
cmp_true_307:
cmp_end_308:
or_end_252:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_249
    b or_end_250
or_right_249:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_309
    adr x0, sign_id
    b cmp_end_310
cmp_true_309:
cmp_end_310:
or_end_250:
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
    b cond_end_246
cond_false_245:
    adr x0, sign_id
cond_end_246:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, length
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_311
    b after_func_315_316
func_315:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_317
    adr x0, sign_id
    b cmp_end_318
cmp_true_317:
cmp_end_318:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_315_316:
    // Closure for func_315
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_315
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_313
    mov x0, #0
    b cond_end_314
cond_false_313:
    adr x0, sign_id
cond_end_314:
    b cond_end_312
cond_false_311:
    adr x0, sign_id
cond_end_312:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, length
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_319
do_apply_320:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_321
do_compose_319:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_321:
    cmp x0, #4096
    b.hi do_compose_322
do_apply_323:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_324
do_compose_322:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_324:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, reverse
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_325
    b after_func_327_328
func_327:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _rev
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_329
do_apply_330:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_331
do_compose_329:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_331:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_332
do_apply_333:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_334
do_compose_332:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_334:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_327_328:
    // Closure for func_327
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_327
    ldr x0, [sp], #16
    bl _cons
    b cond_end_326
cond_false_325:
    adr x0, sign_id
cond_end_326:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _rev
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_335
    b after_func_339_340
func_339:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_341
    adr x0, sign_id
    b cmp_end_342
cmp_true_341:
cmp_end_342:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_339_340:
    // Closure for func_339
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_339
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_337
    adr x0, acc
    b cond_end_338
cond_false_337:
    adr x0, sign_id
cond_end_338:
    b cond_end_336
cond_false_335:
    adr x0, sign_id
cond_end_336:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _rev
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_343
do_apply_344:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_345
do_compose_343:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_345:
    cmp x0, #4096
    b.hi do_compose_346
do_apply_347:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_348
do_compose_346:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_348:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_349
do_apply_350:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_351
do_compose_349:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_351:
    cmp x0, #4096
    b.hi do_compose_352
do_apply_353:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_354
do_compose_352:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_354:
    str x0, [sp, #-16]!
    adr x0, acc
    cmp x0, #4096
    b.hi do_compose_355
do_apply_356:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_357
do_compose_355:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_357:
    cmp x0, #4096
    b.hi do_compose_358
do_apply_359:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_360
do_compose_358:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_360:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list_to_string
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_361
    b after_func_363_364
func_363:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_365_366
func_365:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_370_371
func_370:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_372_373
func_372:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_374_375
func_374:
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
after_func_374_375:
    // Closure for func_374
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_374
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_376
do_apply_377:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_378
do_compose_376:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_378:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_379
do_apply_380:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_381
do_compose_379:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_381:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_370_371:
    // Closure for func_370
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_370
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_382_383
func_382:
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
after_func_382_383:
    // Closure for func_382
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_382
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_367
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_369
xor_true_367:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_368
    adr x0, sign_id
    b xor_end_369
xor_false_368:
    mov x0, x1
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_363_364:
    // Closure for func_363
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_363
    ldr x0, [sp], #16
    bl _cons
    b cond_end_362
cond_false_361:
    adr x0, sign_id
cond_end_362:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_384_385
func_384:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_389_390
func_389:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_391_392
func_391:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_393_394
func_393:
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
after_func_393_394:
    // Closure for func_393
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_393
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_391_392:
    // Closure for func_391
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_391
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_395
do_apply_396:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_397
do_compose_395:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_397:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_398
do_apply_399:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_400
do_compose_398:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_400:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_389_390:
    // Closure for func_389
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_389
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_401_402
func_401:
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
after_func_401_402:
    // Closure for func_401
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_401
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_386
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_388
xor_true_386:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_387
    adr x0, sign_id
    b xor_end_388
xor_false_387:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_384_385:
    // Closure for func_384
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_384
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_403
do_apply_404:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_405
do_compose_403:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_405:
    str x0, [sp, #-16]!
    adr x0, str
    cmp x0, #4096
    b.hi do_compose_406
do_apply_407:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_408
do_compose_406:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_408:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_409
do_apply_410:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_411
do_compose_409:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_411:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne blk_end_0
    adr x0, str
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_412
do_apply_413:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_414
do_compose_412:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_414:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, length
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_415
do_apply_416:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_417
do_compose_415:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_417:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _write_list
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_418
    b after_func_422_423
func_422:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_424
    adr x0, sign_id
    b cmp_end_425
cmp_true_424:
cmp_end_425:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_422_423:
    // Closure for func_422
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_422
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_420
    mov x0, #0
    b cond_end_421
cond_false_420:
    adr x0, sign_id
cond_end_421:
    b cond_end_419
cond_false_418:
    adr x0, sign_id
cond_end_419:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, buf
    str x0, [sp, #-16]!
    adr x0, idx
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_426
do_apply_427:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_428
do_compose_426:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_428:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_429
do_apply_430:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_431
do_compose_429:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_431:
    cmp x0, #4096
    b.hi do_compose_432
do_apply_433:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_434
do_compose_432:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_434:
    str x0, [sp, #-16]!
    adr x0, buf
    cmp x0, #4096
    b.hi do_compose_435
do_apply_436:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_437
do_compose_435:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_437:
    str x0, [sp, #-16]!
    adr x0, idx
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_438
do_apply_439:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_440
do_compose_438:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_440:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tokenize
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_441
    b after_func_443_444
func_443:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_445
do_apply_446:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_447
do_compose_445:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_447:
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_448
do_apply_449:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_450
do_compose_448:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_450:
    cmp x0, #4096
    b.hi do_compose_451
do_apply_452:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_453
do_compose_451:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_453:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_454
do_apply_455:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_456
do_compose_454:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_456:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_443_444:
    // Closure for func_443
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_443
    ldr x0, [sp], #16
    bl _cons
    b cond_end_442
cond_false_441:
    adr x0, sign_id
cond_end_442:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _tokenize_loop
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_457
    b after_func_459_460
func_459:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_461_462
func_461:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_466_467
func_466:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_468_469
func_468:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_470_471
func_470:
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
after_func_470_471:
    // Closure for func_470
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_470
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_468_469:
    // Closure for func_468
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_468
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_472
do_apply_473:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_474
do_compose_472:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_474:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_475
do_apply_476:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_477
do_compose_475:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_477:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_466_467:
    // Closure for func_466
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_466
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_478_479
func_478:
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
after_func_478_479:
    // Closure for func_478
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_478
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_463
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_465
xor_true_463:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_464
    adr x0, sign_id
    b xor_end_465
xor_false_464:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_461_462:
    // Closure for func_461
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_461
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_459_460:
    // Closure for func_459
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_459
    ldr x0, [sp], #16
    bl _cons
    b cond_end_458
cond_false_457:
    adr x0, sign_id
cond_end_458:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_480_481
func_480:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_485_486
func_485:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_487_488
func_487:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_489_490
func_489:
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
after_func_489_490:
    // Closure for func_489
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_489
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_487_488:
    // Closure for func_487
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_487
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_491
do_apply_492:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_493
do_compose_491:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_493:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_494
do_apply_495:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_496
do_compose_494:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_496:
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
    b after_func_497_498
func_497:
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
after_func_497_498:
    // Closure for func_497
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_497
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_482
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_484
xor_true_482:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_483
    adr x0, sign_id
    b xor_end_484
xor_false_483:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_480_481:
    // Closure for func_480
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_480
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_499_500
func_499:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_504_505
func_504:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_506_507
func_506:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_508_509
func_508:
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
after_func_508_509:
    // Closure for func_508
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_508
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_506_507:
    // Closure for func_506
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_506
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_510
do_apply_511:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_512
do_compose_510:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_512:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_513
do_apply_514:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_515
do_compose_513:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_515:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_504_505:
    // Closure for func_504
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_504
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-48]
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_501
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_503
xor_true_501:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_502
    adr x0, sign_id
    b xor_end_503
xor_false_502:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_499_500:
    // Closure for func_499
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_499
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_520
    adr x0, sign_id
    b cmp_end_521
cmp_true_520:
cmp_end_521:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_518
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, token
    cmp x0, #4096
    b.hi do_compose_522
do_apply_523:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_524
do_compose_522:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_524:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_525
do_apply_526:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_527
do_compose_525:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_527:
    b cond_end_519
cond_false_518:
    adr x0, sign_id
cond_end_519:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, token
    cmp x0, #4096
    b.hi do_compose_528
do_apply_529:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_530
do_compose_528:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_530:
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_531
do_apply_532:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_533
do_compose_531:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_533:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_534
do_apply_535:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_536
do_compose_534:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_536:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_537
do_apply_538:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_539
do_compose_537:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_539:
    cmp x0, #4096
    b.hi do_compose_540
do_apply_541:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_542
do_compose_540:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_542:
    cmp x0, #4096
    b.hi do_compose_543
do_apply_544:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_545
do_compose_543:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_545:
    cmp x0, #4096
    b.hi do_compose_546
do_apply_547:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_548
do_compose_546:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_548:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_549_550
func_549:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_554_555
func_554:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_556_557
func_556:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, token
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_556_557:
    // Closure for func_556
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_556
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_558
do_apply_559:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_560
do_compose_558:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_560:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_561
do_apply_562:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_563
do_compose_561:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_563:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_554_555:
    // Closure for func_554
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_554
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, token
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
    b.ne xor_true_551
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_553
xor_true_551:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_552
    adr x0, sign_id
    b xor_end_553
xor_false_552:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_549_550:
    // Closure for func_549
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_549
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_564
do_apply_565:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_566
do_compose_564:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_566:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_token
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_567
do_apply_568:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_569
do_compose_567:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_569:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_570
do_apply_571:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_572
do_compose_570:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_572:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_573
do_apply_574:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_575
do_compose_573:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_575:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_token
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_576
    b after_func_580_581
func_580:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    adr x0, source_len
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_582
    adr x0, sign_id
    b cmp_end_583
cmp_true_582:
cmp_end_583:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_580_581:
    // Closure for func_580
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_580
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_578
    adr x0, sign_id
    b cond_end_579
cond_false_578:
    adr x0, sign_id
cond_end_579:
    b cond_end_577
cond_false_576:
    adr x0, sign_id
cond_end_577:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_584
do_apply_585:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_586
do_compose_584:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_586:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_587
do_apply_588:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_589
do_compose_587:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_589:
    cmp x0, #4096
    b.hi do_compose_590
do_apply_591:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_592
do_compose_590:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_592:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_593
do_apply_594:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_595
do_compose_593:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_595:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_596
do_apply_597:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_598
do_compose_596:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_598:
    cmp x0, #4096
    b.hi do_compose_599
do_apply_600:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_601
do_compose_599:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_601:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_602_603
func_602:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_607_608
func_607:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_609_610
func_609:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_611_612
func_611:
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
after_func_611_612:
    // Closure for func_611
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_611
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_613
do_apply_614:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_615
do_compose_613:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_615:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_616
do_apply_617:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_618
do_compose_616:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_618:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_607_608:
    // Closure for func_607
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_607
    ldr x0, [sp], #16
    bl _cons
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_604
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_606
xor_true_604:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_605
    adr x0, sign_id
    b xor_end_606
xor_false_605:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_602_603:
    // Closure for func_602
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_602
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_623
do_apply_624:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_625
do_compose_623:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_625:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_621
    adr x0, sign_id
    b cond_end_622
cond_false_621:
    adr x0, sign_id
cond_end_622:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_token
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_626
do_apply_627:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_628
do_compose_626:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_628:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_629
do_apply_630:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_631
do_compose_629:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_631:
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_632
do_apply_633:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_634
do_compose_632:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_634:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_637
    adr x0, sign_id
    b cmp_end_638
cmp_true_637:
cmp_end_638:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_635
    adr x0, sign_id
    b cond_end_636
cond_false_635:
    adr x0, sign_id
cond_end_636:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_639
do_apply_640:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_641
do_compose_639:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_641:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_642
do_apply_643:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_644
do_compose_642:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_644:
    cmp x0, #4096
    b.hi do_compose_645
do_apply_646:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_647
do_compose_645:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_647:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_648
do_apply_649:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_650
do_compose_648:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_650:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_651
do_apply_652:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_653
do_compose_651:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_653:
    cmp x0, #4096
    b.hi do_compose_654
do_apply_655:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_656
do_compose_654:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_656:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_digit
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_659
do_apply_660:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_661
do_compose_659:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_661:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_657
    adr x0, sign_id
    b cond_end_658
cond_false_657:
    adr x0, sign_id
cond_end_658:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_662_663
func_662:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_667_668
func_667:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_669_670
func_669:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_671_672
func_671:
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
after_func_671_672:
    // Closure for func_671
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_671
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_673
do_apply_674:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_675
do_compose_673:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_675:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_676
do_apply_677:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_678
do_compose_676:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_678:
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
    str x0, [sp, #-16]!
    b after_func_679_680
func_679:
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
after_func_679_680:
    // Closure for func_679
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_679
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_664
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_666
xor_true_664:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_665
    adr x0, sign_id
    b xor_end_666
xor_false_665:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_662_663:
    // Closure for func_662
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_662
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_681_682
func_681:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_686_687
func_686:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_688_689
func_688:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_690_691
func_690:
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
after_func_690_691:
    // Closure for func_690
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_690
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_688_689:
    // Closure for func_688
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_688
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_692
do_apply_693:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_694
do_compose_692:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_694:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_695
do_apply_696:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_697
do_compose_695:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_697:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_686_687:
    // Closure for func_686
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_686
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_698_699
func_698:
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
after_func_698_699:
    // Closure for func_698
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_698
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_683
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_685
xor_true_683:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_684
    adr x0, sign_id
    b xor_end_685
xor_false_684:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_681_682:
    // Closure for func_681
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_681
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_700_701
func_700:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_705_706
func_705:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_707_708
func_707:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_709_710
func_709:
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
after_func_709_710:
    // Closure for func_709
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_709
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_707_708:
    // Closure for func_707
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_707
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_711
do_apply_712:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_713
do_compose_711:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_713:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_714
do_apply_715:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_716
do_compose_714:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_716:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_705_706:
    // Closure for func_705
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_705
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_717_718
func_717:
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
after_func_717_718:
    // Closure for func_717
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_717
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_702
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_704
xor_true_702:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_703
    adr x0, sign_id
    b xor_end_704
xor_false_703:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_700_701:
    // Closure for func_700
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_700
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_719
do_apply_720:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_721
do_compose_719:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_721:
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_722
do_apply_723:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_724
do_compose_722:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_724:
    cmp x0, #4096
    b.hi do_compose_725
do_apply_726:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_727
do_compose_725:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_727:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_728
do_apply_729:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_730
do_compose_728:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_730:
    cmp x0, #4096
    b.hi do_compose_731
do_apply_732:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_733
do_compose_731:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_733:
    cmp x0, #4096
    b.hi do_compose_734
do_apply_735:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_736
do_compose_734:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_736:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_737
do_apply_738:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_739
do_compose_737:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_739:
    cmp x0, #4096
    b.hi do_compose_740
do_apply_741:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_742
do_compose_740:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_742:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_int
    str x0, [sp, #-16]!
    adr x0, val_str
    cmp x0, #4096
    b.hi do_compose_743
do_apply_744:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_745
do_compose_743:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_745:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_746
do_apply_747:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_748
do_compose_746:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_748:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_num
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_749
do_apply_750:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_751
do_compose_749:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_751:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_752
do_apply_753:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_754
do_compose_752:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_754:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_755
do_apply_756:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_757
do_compose_755:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_757:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_alpha
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_760
do_apply_761:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_762
do_compose_760:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_762:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_758
    adr x0, sign_id
    b cond_end_759
cond_false_758:
    adr x0, sign_id
cond_end_759:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_763_764
func_763:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_768_769
func_768:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_770_771
func_770:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_772_773
func_772:
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
after_func_772_773:
    // Closure for func_772
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_772
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_770_771:
    // Closure for func_770
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_770
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_774
do_apply_775:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_776
do_compose_774:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_776:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_777
do_apply_778:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_779
do_compose_777:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_779:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_768_769:
    // Closure for func_768
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_768
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_780_781
func_780:
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
after_func_780_781:
    // Closure for func_780
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_780
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_765
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_767
xor_true_765:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_766
    adr x0, sign_id
    b xor_end_767
xor_false_766:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_763_764:
    // Closure for func_763
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_763
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_782
do_apply_783:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_784
do_compose_782:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_784:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_785
do_apply_786:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_787
do_compose_785:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_787:
    cmp x0, #4096
    b.hi do_compose_788
do_apply_789:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_790
do_compose_788:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_790:
    cmp x0, #4096
    b.hi do_compose_791
do_apply_792:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_793
do_compose_791:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_793:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_794
do_apply_795:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_796
do_compose_794:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_796:
    cmp x0, #4096
    b.hi do_compose_797
do_apply_798:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_799
do_compose_797:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_799:
    cmp x0, #4096
    b.hi do_compose_800
do_apply_801:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_802
do_compose_800:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_802:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_803
do_apply_804:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_805
do_compose_803:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_805:
    cmp x0, #4096
    b.hi do_compose_806
do_apply_807:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_808
do_compose_806:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_808:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_809
do_apply_810:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_811
do_compose_809:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_811:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_812
do_apply_813:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_814
do_compose_812:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_814:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_815
do_apply_816:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_817
do_compose_815:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_817:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_op_char
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_820
do_apply_821:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_822
do_compose_820:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_822:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_818
    adr x0, sign_id
    b cond_end_819
cond_false_818:
    adr x0, sign_id
cond_end_819:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_823_824
func_823:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_828_829
func_828:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_830_831
func_830:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_832_833
func_832:
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
after_func_832_833:
    // Closure for func_832
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_832
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_830_831:
    // Closure for func_830
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_830
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_834
do_apply_835:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_836
do_compose_834:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_836:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_837
do_apply_838:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_839
do_compose_837:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_839:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_828_829:
    // Closure for func_828
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_828
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_840_841
func_840:
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
after_func_840_841:
    // Closure for func_840
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_840
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_825
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_827
xor_true_825:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_826
    adr x0, sign_id
    b xor_end_827
xor_false_826:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_823_824:
    // Closure for func_823
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_823
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_842
do_apply_843:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_844
do_compose_842:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_844:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_845
do_apply_846:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_847
do_compose_845:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_847:
    cmp x0, #4096
    b.hi do_compose_848
do_apply_849:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_850
do_compose_848:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_850:
    cmp x0, #4096
    b.hi do_compose_851
do_apply_852:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_853
do_compose_851:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_853:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_854
do_apply_855:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_856
do_compose_854:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_856:
    cmp x0, #4096
    b.hi do_compose_857
do_apply_858:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_859
do_compose_857:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_859:
    cmp x0, #4096
    b.hi do_compose_860
do_apply_861:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_862
do_compose_860:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_862:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_863
do_apply_864:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_865
do_compose_863:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_865:
    cmp x0, #4096
    b.hi do_compose_866
do_apply_867:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_868
do_compose_866:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_868:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_op
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_869
do_apply_870:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_871
do_compose_869:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_871:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_872
do_apply_873:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_874
do_compose_872:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_874:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_875
do_apply_876:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_877
do_compose_875:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_877:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_880
    adr x0, sign_id
    b cmp_end_881
cmp_true_880:
cmp_end_881:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_878
    adr x0, sign_id
    b cond_end_879
cond_false_878:
    adr x0, sign_id
cond_end_879:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_882_883
func_882:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_887_888
func_887:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_889_890
func_889:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_891_892
func_891:
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
after_func_891_892:
    // Closure for func_891
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_891
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_889_890:
    // Closure for func_889
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_889
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_893
do_apply_894:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_895
do_compose_893:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_895:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_896
do_apply_897:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_898
do_compose_896:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_898:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_887_888:
    // Closure for func_887
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_887
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_899_900
func_899:
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
after_func_899_900:
    // Closure for func_899
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_899
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_884
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_886
xor_true_884:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_885
    adr x0, sign_id
    b xor_end_886
xor_false_885:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_901
do_apply_902:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_903
do_compose_901:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_903:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_904
do_apply_905:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_906
do_compose_904:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_906:
    cmp x0, #4096
    b.hi do_compose_907
do_apply_908:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_909
do_compose_907:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_909:
    cmp x0, #4096
    b.hi do_compose_910
do_apply_911:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_912
do_compose_910:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_912:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_913
do_apply_914:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_915
do_compose_913:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_915:
    cmp x0, #4096
    b.hi do_compose_916
do_apply_917:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_918
do_compose_916:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_918:
    cmp x0, #4096
    b.hi do_compose_919
do_apply_920:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_921
do_compose_919:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_921:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_922
do_apply_923:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_924
do_compose_922:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_924:
    cmp x0, #4096
    b.hi do_compose_925
do_apply_926:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_927
do_compose_925:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_927:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_str
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_928
do_apply_929:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_930
do_compose_928:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_930:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_931
do_apply_932:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_933
do_compose_931:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_933:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_934
do_apply_935:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_936
do_compose_934:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_936:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_937
do_apply_938:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_939
do_compose_937:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_939:
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_940
do_apply_941:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_942
do_compose_940:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_942:
    cmp x0, #4096
    b.hi do_compose_943
do_apply_944:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_945
do_compose_943:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_945:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_946
do_apply_947:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_948
do_compose_946:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_948:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_949
do_apply_950:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_951
do_compose_949:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_951:
    cmp x0, #4096
    b.hi do_compose_952
do_apply_953:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_954
do_compose_952:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_954:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_955
do_apply_956:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_957
do_compose_955:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_957:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_958
do_apply_959:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_960
do_compose_958:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_960:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_num
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_961
    b after_func_963_964
func_963:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_while
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_965
do_apply_966:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_967
do_compose_965:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_967:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_968
do_apply_969:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_970
do_compose_968:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_970:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_971
do_apply_972:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_973
do_compose_971:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_973:
    str x0, [sp, #-16]!
    adr x0, is_digit
    cmp x0, #4096
    b.hi do_compose_974
do_apply_975:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_976
do_compose_974:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_976:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_963_964:
    // Closure for func_963
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_963
    ldr x0, [sp], #16
    bl _cons
    b cond_end_962
cond_false_961:
    adr x0, sign_id
cond_end_962:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_id
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_977
    b after_func_979_980
func_979:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_979_980:
    // Closure for func_979
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_979
    ldr x0, [sp], #16
    bl _cons
    b cond_end_978
cond_false_977:
    adr x0, sign_id
cond_end_978:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_while
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_981
do_apply_982:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_983
do_compose_981:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_983:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_984
do_apply_985:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_986
do_compose_984:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_986:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_987
do_apply_988:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_989
do_compose_987:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_989:
    str x0, [sp, #-16]!
    b after_func_990_991
func_990:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_992
    b or_end_993
or_right_992:
    adr x0, is_digit
or_end_993:
    cmp x0, #4096
    b.hi do_compose_994
do_apply_995:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_996
do_compose_994:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_996:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_997
do_apply_998:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_999
do_compose_997:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_999:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_990_991:
    // Closure for func_990
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_990
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1000
do_apply_1001:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1002
do_compose_1000:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1002:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_op
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1003
    b after_func_1005_1006
func_1005:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_while
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1007
do_apply_1008:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1009
do_compose_1007:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1009:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_1010
do_apply_1011:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1012
do_compose_1010:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1012:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_1013
do_apply_1014:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1015
do_compose_1013:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1015:
    str x0, [sp, #-16]!
    adr x0, is_op_char
    cmp x0, #4096
    b.hi do_compose_1016
do_apply_1017:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1018
do_compose_1016:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1018:
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
    b cond_end_1004
cond_false_1003:
    adr x0, sign_id
cond_end_1004:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_while
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1019
    b after_func_1021_1022
func_1021:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1023_1024
func_1023:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1028_1029
func_1028:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1030_1031
func_1030:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1032_1033
func_1032:
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
after_func_1032_1033:
    // Closure for func_1032
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1032
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_1034
do_apply_1035:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1036
do_compose_1034:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1036:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1037
do_apply_1038:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1039
do_compose_1037:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1039:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1028_1029:
    // Closure for func_1028
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1028
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1040_1041
func_1040:
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
after_func_1040_1041:
    // Closure for func_1040
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1040
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1025
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1027
xor_true_1025:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1026
    adr x0, sign_id
    b xor_end_1027
xor_false_1026:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1023_1024:
    // Closure for func_1023
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1023
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1021_1022:
    // Closure for func_1021
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1021
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1020
cond_false_1019:
    adr x0, sign_id
cond_end_1020:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1042_1043
func_1042:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1047_1048
func_1047:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1049_1050
func_1049:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1051_1052
func_1051:
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
after_func_1051_1052:
    // Closure for func_1051
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1051
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_1053
do_apply_1054:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1055
do_compose_1053:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1055:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1056
do_apply_1057:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1058
do_compose_1056:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1058:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1047_1048:
    // Closure for func_1047
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1047
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1059_1060
func_1059:
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
after_func_1059_1060:
    // Closure for func_1059
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1059
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1044
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1046
xor_true_1044:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1045
    adr x0, sign_id
    b xor_end_1046
xor_false_1045:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1042_1043:
    // Closure for func_1042
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1042
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1061_1062
func_1061:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1066_1067
func_1066:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1068_1069
func_1068:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1070_1071
func_1070:
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
after_func_1070_1071:
    // Closure for func_1070
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1070
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_1072
do_apply_1073:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1074
do_compose_1072:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1074:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1075
do_apply_1076:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1077
do_compose_1075:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1077:
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
    str x0, [sp, #-16]!
    b after_func_1078_1079
func_1078:
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
after_func_1078_1079:
    // Closure for func_1078
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1078
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1063
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1065
xor_true_1063:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1064
    adr x0, sign_id
    b xor_end_1065
xor_false_1064:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1061_1062:
    // Closure for func_1061
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1061
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    cmp x0, #4096
    b.hi do_compose_1080
do_apply_1081:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1082
do_compose_1080:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1082:
    cmp x0, #4096
    b.hi do_compose_1083
do_apply_1084:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1085
do_compose_1083:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1085:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_1086
do_apply_1087:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1088
do_compose_1086:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1088:
    cmp x0, #4096
    b.hi do_compose_1089
do_apply_1090:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1091
do_compose_1089:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1091:
    cmp x0, #4096
    b.hi do_compose_1092
do_apply_1093:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1094
do_compose_1092:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1094:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1095
do_apply_1096:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1097
do_compose_1095:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1097:
    cmp x0, #4096
    b.hi do_compose_1098
do_apply_1099:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1100
do_compose_1098:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1100:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, reverse
    str x0, [sp, #-16]!
    adr x0, chars_rev
    cmp x0, #4096
    b.hi do_compose_1101
do_apply_1102:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1103
do_compose_1101:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1103:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_1104
do_apply_1105:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1106
do_compose_1104:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1106:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_while_rec
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_1107
do_apply_1108:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1109
do_compose_1107:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1109:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_1110
do_apply_1111:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1112
do_compose_1110:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1112:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_1113
do_apply_1114:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1115
do_compose_1113:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1115:
    str x0, [sp, #-16]!
    adr x0, pred
    cmp x0, #4096
    b.hi do_compose_1116
do_apply_1117:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1118
do_compose_1116:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1118:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1119
do_apply_1120:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1121
do_compose_1119:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1121:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_while_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1122
    b after_func_1126_1127
func_1126:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    adr x0, source_len
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1128
    adr x0, sign_id
    b cmp_end_1129
cmp_true_1128:
cmp_end_1129:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1124
    adr x0, sign_id
    b cond_end_1125
cond_false_1124:
    adr x0, sign_id
cond_end_1125:
    b cond_end_1123
cond_false_1122:
    adr x0, sign_id
cond_end_1123:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, acc
    cmp x0, #4096
    b.hi do_compose_1130
do_apply_1131:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1132
do_compose_1130:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1132:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_1133
do_apply_1134:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1135
do_compose_1133:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1135:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1136
do_apply_1137:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1138
do_compose_1136:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1138:
    cmp x0, #4096
    b.hi do_compose_1139
do_apply_1140:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1141
do_compose_1139:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1141:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1142_1143
func_1142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1147_1148
func_1147:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1149_1150
func_1149:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1151_1152
func_1151:
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
after_func_1151_1152:
    // Closure for func_1151
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1151
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1149_1150:
    // Closure for func_1149
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1149
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1153
do_apply_1154:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1155
do_compose_1153:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1155:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1156
do_apply_1157:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1158
do_compose_1156:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1158:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1147_1148:
    // Closure for func_1147
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1147
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1159_1160
func_1159:
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
after_func_1159_1160:
    // Closure for func_1159
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1159
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1144
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1146
xor_true_1144:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1145
    adr x0, sign_id
    b xor_end_1146
xor_false_1145:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1142_1143:
    // Closure for func_1142
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1142
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, pred
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_1163
do_apply_1164:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1165
do_compose_1163:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1165:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1161
    adr x0, sign_id
    b cond_end_1162
cond_false_1161:
    adr x0, sign_id
cond_end_1162:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_while_rec
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_1166
do_apply_1167:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1168
do_compose_1166:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1168:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_1169
do_apply_1170:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1171
do_compose_1169:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1171:
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1172
do_apply_1173:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1174
do_compose_1172:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1174:
    str x0, [sp, #-16]!
    adr x0, pred
    cmp x0, #4096
    b.hi do_compose_1175
do_apply_1176:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1177
do_compose_1175:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1177:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_1178
do_apply_1179:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1180
do_compose_1178:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1180:
    str x0, [sp, #-16]!
    adr x0, acc
    cmp x0, #4096
    b.hi do_compose_1181
do_apply_1182:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1183
do_compose_1181:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1183:
    cmp x0, #4096
    b.hi do_compose_1184
do_apply_1185:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1186
do_compose_1184:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1186:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, acc
    cmp x0, #4096
    b.hi do_compose_1187
do_apply_1188:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1189
do_compose_1187:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1189:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_1190
do_apply_1191:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1192
do_compose_1190:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1192:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1193
do_apply_1194:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1195
do_compose_1193:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1195:
    cmp x0, #4096
    b.hi do_compose_1196
do_apply_1197:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1198
do_compose_1196:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1198:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_1199
do_apply_1200:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1201
do_compose_1199:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1201:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_1202
do_apply_1203:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1204
do_compose_1202:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1204:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1205
    b after_func_1207_1208
func_1207:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_2
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
    b cond_end_1206
cond_false_1205:
    adr x0, sign_id
cond_end_1206:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1209_1210
func_1209:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1214_1215
func_1214:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1216_1217
func_1216:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1218_1219
func_1218:
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
after_func_1218_1219:
    // Closure for func_1218
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1218
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1216_1217:
    // Closure for func_1216
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1216
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1220
do_apply_1221:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1222
do_compose_1220:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1222:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1223
do_apply_1224:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1225
do_compose_1223:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1225:
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
    b after_func_1226_1227
func_1226:
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
after_func_1226_1227:
    // Closure for func_1226
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1226
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1211
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1213
xor_true_1211:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1212
    adr x0, sign_id
    b xor_end_1213
xor_false_1212:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1228_1229
func_1228:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1233_1234
func_1233:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1235_1236
func_1235:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1237_1238
func_1237:
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
after_func_1237_1238:
    // Closure for func_1237
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1237
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1235_1236:
    // Closure for func_1235
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1235
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1239
do_apply_1240:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1241
do_compose_1239:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1241:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1242
do_apply_1243:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1244
do_compose_1242:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1244:
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
    b after_func_1245_1246
func_1245:
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
after_func_1245_1246:
    // Closure for func_1245
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1245
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1230
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1232
xor_true_1230:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1231
    adr x0, sign_id
    b xor_end_1232
xor_false_1231:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1228_1229:
    // Closure for func_1228
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1228
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1247_1248
func_1247:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1252_1253
func_1252:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1254_1255
func_1254:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1256_1257
func_1256:
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
after_func_1256_1257:
    // Closure for func_1256
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1256
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1254_1255:
    // Closure for func_1254
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1254
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1258
do_apply_1259:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1260
do_compose_1258:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1260:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1261
do_apply_1262:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1263
do_compose_1261:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1263:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1252_1253:
    // Closure for func_1252
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1252
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1264_1265
func_1264:
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
after_func_1264_1265:
    // Closure for func_1264
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1264
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1249
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1251
xor_true_1249:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1250
    adr x0, sign_id
    b xor_end_1251
xor_false_1250:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1247_1248:
    // Closure for func_1247
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1247
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1266_1267
func_1266:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1271_1272
func_1271:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1273_1274
func_1273:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1275_1276
func_1275:
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
after_func_1275_1276:
    // Closure for func_1275
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1275
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1273_1274:
    // Closure for func_1273
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1273
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1277
do_apply_1278:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1279
do_compose_1277:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1279:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1280
do_apply_1281:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1282
do_compose_1280:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1282:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1271_1272:
    // Closure for func_1271
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1271
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1283_1284
func_1283:
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
after_func_1283_1284:
    // Closure for func_1283
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1283
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1268
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1270
xor_true_1268:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1269
    adr x0, sign_id
    b xor_end_1270
xor_false_1269:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    cmp x0, #4096
    b.hi do_compose_1285
do_apply_1286:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1287
do_compose_1285:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1287:
    cmp x0, #4096
    b.hi do_compose_1288
do_apply_1289:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1290
do_compose_1288:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1290:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_1291
do_apply_1292:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1293
do_compose_1291:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1293:
    cmp x0, #4096
    b.hi do_compose_1294
do_apply_1295:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1296
do_compose_1294:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1296:
    cmp x0, #4096
    b.hi do_compose_1297
do_apply_1298:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1299
do_compose_1297:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1299:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1300
do_apply_1301:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1302
do_compose_1300:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1302:
    cmp x0, #4096
    b.hi do_compose_1303
do_apply_1304:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1305
do_compose_1303:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1305:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, reverse
    str x0, [sp, #-16]!
    adr x0, chars_rev
    cmp x0, #4096
    b.hi do_compose_1306
do_apply_1307:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1308
do_compose_1306:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1308:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_1309
do_apply_1310:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1311
do_compose_1309:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1311:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_1312
do_apply_1313:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1314
do_compose_1312:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1314:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_1315
do_apply_1316:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1317
do_compose_1315:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1317:
    str x0, [sp, #-16]!
    adr x0, start_pos
    cmp x0, #4096
    b.hi do_compose_1318
do_apply_1319:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1320
do_compose_1318:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1320:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1321
do_apply_1322:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1323
do_compose_1321:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1323:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_str_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1324
    b after_func_1328_1329
func_1328:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    adr x0, source_len
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1330
    adr x0, sign_id
    b cmp_end_1331
cmp_true_1330:
cmp_end_1331:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1326
    adr x0, sign_id
    b cond_end_1327
cond_false_1326:
    adr x0, sign_id
cond_end_1327:
    b cond_end_1325
cond_false_1324:
    adr x0, sign_id
cond_end_1325:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, acc
    cmp x0, #4096
    b.hi do_compose_1332
do_apply_1333:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1334
do_compose_1332:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1334:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_1335
do_apply_1336:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1337
do_compose_1335:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1337:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1338
do_apply_1339:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1340
do_compose_1338:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1340:
    cmp x0, #4096
    b.hi do_compose_1341
do_apply_1342:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1343
do_compose_1341:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1343:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1344_1345
func_1344:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1349_1350
func_1349:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1351_1352
func_1351:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1351_1352:
    // Closure for func_1351
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1351
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1355
do_apply_1356:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1357
do_compose_1355:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1357:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1358
do_apply_1359:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1360
do_compose_1358:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1360:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1349_1350:
    // Closure for func_1349
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1349
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1361_1362
func_1361:
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
    adr x1, func_1361
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1346
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1348
xor_true_1346:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1347
    adr x0, sign_id
    b xor_end_1348
xor_false_1347:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1344_1345:
    // Closure for func_1344
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1344
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1367
    adr x0, sign_id
    b cmp_end_1368
cmp_true_1367:
cmp_end_1368:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1365
    b or_end_1366
or_right_1365:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1369
    adr x0, sign_id
    b cmp_end_1370
cmp_true_1369:
cmp_end_1370:
or_end_1366:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1363
    adr x0, sign_id
    b cond_end_1364
cond_false_1363:
    adr x0, sign_id
cond_end_1364:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, acc
    cmp x0, #4096
    b.hi do_compose_1371
do_apply_1372:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1373
do_compose_1371:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1373:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1374
do_apply_1375:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1376
do_compose_1374:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1376:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1377
do_apply_1378:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1379
do_compose_1377:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1379:
    cmp x0, #4096
    b.hi do_compose_1380
do_apply_1381:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1382
do_compose_1380:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1382:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_1383
do_apply_1384:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1385
do_compose_1383:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1385:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_1386
do_apply_1387:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1388
do_compose_1386:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1388:
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1389
do_apply_1390:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1391
do_compose_1389:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1391:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    cmp x0, #4096
    b.hi do_compose_1392
do_apply_1393:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1394
do_compose_1392:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1394:
    str x0, [sp, #-16]!
    adr x0, acc
    cmp x0, #4096
    b.hi do_compose_1395
do_apply_1396:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1397
do_compose_1395:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1397:
    cmp x0, #4096
    b.hi do_compose_1398
do_apply_1399:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1400
do_compose_1398:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1400:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_1401
do_apply_1402:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1403
do_compose_1401:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1403:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_1404
do_apply_1405:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1406
do_compose_1404:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1406:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_int
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1407
    b after_func_1409_1410
func_1409:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1409_1410:
    // Closure for func_1409
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1409
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1408
cond_false_1407:
    adr x0, sign_id
cond_end_1408:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Pure
    cmp x0, #4096
    b.hi do_compose_1411
do_apply_1412:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1413
do_compose_1411:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1413:
    str x0, [sp, #-16]!
    adr x0, Functional
    cmp x0, #4096
    b.hi do_compose_1414
do_apply_1415:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1416
do_compose_1414:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1416:
    str x0, [sp, #-16]!
    adr x0, Parser
    cmp x0, #4096
    b.hi do_compose_1417
do_apply_1418:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1419
do_compose_1417:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1419:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, -
    str x0, [sp, #-16]!
    adr x0, No
    cmp x0, #4096
    b.hi do_compose_1420
do_apply_1421:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1422
do_compose_1420:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1422:
    str x0, [sp, #-16]!
    adr x0, global
    cmp x0, #4096
    b.hi do_compose_1423
do_apply_1424:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1425
do_compose_1423:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1425:
    str x0, [sp, #-16]!
    adr x0, state
    cmp x0, #4096
    b.hi do_compose_1426
do_apply_1427:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1428
do_compose_1426:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1428:
    adr x1, Philosophy
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, -
    str x0, [sp, #-16]!
    adr x0, No
    cmp x0, #4096
    b.hi do_compose_1429
do_apply_1430:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1431
do_compose_1429:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1431:
    str x0, [sp, #-16]!
    adr x0, local
    cmp x0, #4096
    b.hi do_compose_1432
do_apply_1433:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1434
do_compose_1432:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1434:
    str x0, [sp, #-16]!
    adr x0, bindings
    cmp x0, #4096
    b.hi do_compose_1435
do_apply_1436:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1437
do_compose_1435:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1437:
    str x0, [sp, #-16]!
    b after_func_1438_1439
func_1438:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1443_1444
func_1443:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1445_1446
func_1445:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1447_1448
func_1447:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1447_1448:
    // Closure for func_1447
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1447
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1445_1446:
    // Closure for func_1445
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1445
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1449
do_apply_1450:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1451
do_compose_1449:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1451:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1452
do_apply_1453:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1454
do_compose_1452:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1454:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1443_1444:
    // Closure for func_1443
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1443
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1455_1456
func_1455:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1455_1456:
    // Closure for func_1455
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1455
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1440
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1442
xor_true_1440:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1441
    adr x0, sign_id
    b xor_end_1442
xor_false_1441:
    mov x0, x1
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
    cmp x0, #4096
    b.hi do_compose_1457
do_apply_1458:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1459
do_compose_1457:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1459:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, -
    str x0, [sp, #-16]!
    adr x0, Logic
    cmp x0, #4096
    b.hi do_compose_1462
do_apply_1463:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1464
do_compose_1462:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1464:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1460
    adr x0, tokens
    str x0, [sp, #-16]!
    adr x0, >
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, ast_node
    str x0, [sp, #-16]!
    adr x0, remaining_tokens
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1465
do_apply_1466:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1467
do_compose_1465:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1467:
    b cond_end_1461
cond_false_1460:
    adr x0, sign_id
cond_end_1461:
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
    adr x0, tok_type
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1468
    b after_func_1470_1471
func_1470:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1470_1471:
    // Closure for func_1470
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1470
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1469
cond_false_1468:
    adr x0, sign_id
cond_end_1469:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1472
    b after_func_1474_1475
func_1474:
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
after_func_1474_1475:
    // Closure for func_1474
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1474
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1473
cond_false_1472:
    adr x0, sign_id
cond_end_1473:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1476
    b after_func_1478_1479
func_1478:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1480_1481
func_1480:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1485_1486
func_1485:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1487_1488
func_1487:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1489_1490
func_1489:
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
after_func_1489_1490:
    // Closure for func_1489
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1489
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1487_1488:
    // Closure for func_1487
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1487
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1491
do_apply_1492:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1493
do_compose_1491:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1493:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1494
do_apply_1495:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1496
do_compose_1494:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1496:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1485_1486:
    // Closure for func_1485
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1485
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1497_1498
func_1497:
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
after_func_1497_1498:
    // Closure for func_1497
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1497
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1482
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1484
xor_true_1482:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1483
    adr x0, sign_id
    b xor_end_1484
xor_false_1483:
    mov x0, x1
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1478_1479:
    // Closure for func_1478
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1478
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1477
cond_false_1476:
    adr x0, sign_id
cond_end_1477:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1499_1500
func_1499:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1504_1505
func_1504:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1506_1507
func_1506:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1508_1509
func_1508:
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
after_func_1508_1509:
    // Closure for func_1508
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1508
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1506_1507:
    // Closure for func_1506
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1506
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1510
do_apply_1511:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1512
do_compose_1510:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1512:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1513
do_apply_1514:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1515
do_compose_1513:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1515:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1504_1505:
    // Closure for func_1504
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1504
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1516_1517
func_1516:
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
after_func_1516_1517:
    // Closure for func_1516
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1516
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1501
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1503
xor_true_1501:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1502
    adr x0, sign_id
    b xor_end_1503
xor_false_1502:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1499_1500:
    // Closure for func_1499
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1499
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c1
    str x0, [sp, #-16]!
    adr x0, c2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1520
    adr x0, sign_id
    b cmp_end_1521
cmp_true_1520:
cmp_end_1521:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1518
    mov x0, #0
    b cond_end_1519
cond_false_1518:
    adr x0, sign_id
cond_end_1519:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c1
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1524
    adr x0, sign_id
    b cmp_end_1525
cmp_true_1524:
cmp_end_1525:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1522
    mov x0, #1
    b cond_end_1523
cond_false_1522:
    adr x0, sign_id
cond_end_1523:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, s1
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1526
do_apply_1527:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1528
do_compose_1526:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1528:
    str x0, [sp, #-16]!
    adr x0, s2
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1529
do_apply_1530:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1531
do_compose_1529:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1531:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1532_1533
func_1532:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1537_1538
func_1537:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1539_1540
func_1539:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, s2
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1539_1540:
    // Closure for func_1539
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1539
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1541
do_apply_1542:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1543
do_compose_1541:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1543:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1544
do_apply_1545:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1546
do_compose_1544:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1546:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, s2
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
    b.ne xor_true_1534
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1536
xor_true_1534:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1535
    adr x0, sign_id
    b xor_end_1536
xor_false_1535:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1532_1533:
    // Closure for func_1532
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1532
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1547_1548
func_1547:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1552_1553
func_1552:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1554_1555
func_1554:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, s1
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1554_1555:
    // Closure for func_1554
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1554
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1556
do_apply_1557:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1558
do_compose_1556:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1558:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1559
do_apply_1560:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1561
do_compose_1559:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1561:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1552_1553:
    // Closure for func_1552
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1552
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, s1
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
    b.ne xor_true_1549
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1551
xor_true_1549:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1550
    adr x0, sign_id
    b xor_end_1551
xor_false_1550:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1547_1548:
    // Closure for func_1547
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1547
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_prec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1562
    b after_func_1566_1567
func_1566:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1568
do_apply_1569:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1570
do_compose_1568:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1570:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1571
do_apply_1572:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1573
do_compose_1571:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1573:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1566_1567:
    // Closure for func_1566
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1566
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1564
    mov x0, #15
    b cond_end_1565
cond_false_1564:
    adr x0, sign_id
cond_end_1565:
    b cond_end_1563
cond_false_1562:
    adr x0, sign_id
cond_end_1563:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1576
do_apply_1577:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1578
do_compose_1576:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1578:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1579
do_apply_1580:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1581
do_compose_1579:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1581:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1574
    mov x0, #15
    b cond_end_1575
cond_false_1574:
    adr x0, sign_id
cond_end_1575:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1584
do_apply_1585:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1586
do_compose_1584:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1586:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    mul x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1587
do_apply_1588:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1589
do_compose_1587:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1589:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1582
    mov x0, #16
    b cond_end_1583
cond_false_1582:
    adr x0, sign_id
cond_end_1583:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1592
do_apply_1593:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1594
do_compose_1592:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1594:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1595
do_apply_1596:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1597
do_compose_1595:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1597:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1590
    mov x0, #16
    b cond_end_1591
cond_false_1590:
    adr x0, sign_id
cond_end_1591:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1600
do_apply_1601:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1602
do_compose_1600:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1602:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    cmp x0, #4096
    b.hi do_compose_1603
do_apply_1604:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1605
do_compose_1603:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1605:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1598
    mov x0, #16
    b cond_end_1599
cond_false_1598:
    adr x0, sign_id
cond_end_1599:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1608
do_apply_1609:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1610
do_compose_1608:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1610:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1611
do_apply_1612:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1613
do_compose_1611:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1613:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1606
    mov x0, #2
    adr x1, "
    str x0, [x1]
    adr x0, sign_id
    b cond_end_1607
cond_false_1606:
    adr x0, sign_id
cond_end_1607:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1616_1617
func_1616:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1616_1617:
    // Closure for func_1616
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1616
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1614
    mov x0, #5
    b cond_end_1615
cond_false_1614:
    adr x0, sign_id
cond_end_1615:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1620
do_apply_1621:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1622
do_compose_1620:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1622:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1623
do_apply_1624:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1625
do_compose_1623:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1625:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1618
    mov x0, #6
    b cond_end_1619
cond_false_1618:
    adr x0, sign_id
cond_end_1619:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1628
do_apply_1629:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1630
do_compose_1628:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1630:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1631
    adr x0, sign_id
    b cmp_end_1632
cmp_true_1631:
cmp_end_1632:
    cmp x0, #4096
    b.hi do_compose_1633
do_apply_1634:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1635
do_compose_1633:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1635:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1626
    mov x0, #14
    b cond_end_1627
cond_false_1626:
    adr x0, sign_id
cond_end_1627:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1638
do_apply_1639:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1640
do_compose_1638:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1640:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    cmp x0, #4096
    b.hi do_compose_1641
do_apply_1642:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1643
do_compose_1641:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1643:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1636
    mov x0, #14
    b cond_end_1637
cond_false_1636:
    adr x0, sign_id
cond_end_1637:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1646
do_apply_1647:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1648
do_compose_1646:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1648:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1649
    adr x0, sign_id
    b cmp_end_1650
cmp_true_1649:
cmp_end_1650:
    cmp x0, #4096
    b.hi do_compose_1651
do_apply_1652:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1653
do_compose_1651:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1653:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1644
    mov x0, #14
    b cond_end_1645
cond_false_1644:
    adr x0, sign_id
cond_end_1645:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1656
do_apply_1657:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1658
do_compose_1656:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1658:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_1659
    adr x0, sign_id
    b cmp_end_1660
cmp_true_1659:
cmp_end_1660:
    cmp x0, #4096
    b.hi do_compose_1661
do_apply_1662:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1663
do_compose_1661:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1663:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1654
    mov x0, #14
    b cond_end_1655
cond_false_1654:
    adr x0, sign_id
cond_end_1655:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1666
do_apply_1667:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1668
do_compose_1666:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1668:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_1669
    adr x0, sign_id
    b cmp_end_1670
cmp_true_1669:
cmp_end_1670:
    cmp x0, #4096
    b.hi do_compose_1671
do_apply_1672:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1673
do_compose_1671:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1673:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1664
    mov x0, #14
    b cond_end_1665
cond_false_1664:
    adr x0, sign_id
cond_end_1665:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1676
do_apply_1677:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1678
do_compose_1676:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1678:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1679
    adr x0, sign_id
    b cmp_end_1680
cmp_true_1679:
cmp_end_1680:
    cmp x0, #4096
    b.hi do_compose_1681
do_apply_1682:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1683
do_compose_1681:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1683:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1674
    mov x0, #14
    b cond_end_1675
cond_false_1674:
    adr x0, sign_id
cond_end_1675:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1686
do_apply_1687:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1688
do_compose_1686:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1688:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1689
    adr x0, sign_id
    b cmp_end_1690
cmp_true_1689:
cmp_end_1690:
    cmp x0, #4096
    b.hi do_compose_1691
do_apply_1692:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1693
do_compose_1691:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1693:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1684
    mov x0, #14
    b cond_end_1685
cond_false_1684:
    adr x0, sign_id
cond_end_1685:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_right_assoc
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1694
    b after_func_1698_1699
func_1698:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1700
do_apply_1701:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1702
do_compose_1700:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1702:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1703
do_apply_1704:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1705
do_compose_1703:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1705:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1698_1699:
    // Closure for func_1698
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1698
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1696
    mov x0, #1
    adr x1, "
    str x0, [x1]
    adr x0, sign_id
    b cond_end_1697
cond_false_1696:
    adr x0, sign_id
cond_end_1697:
    b cond_end_1695
cond_false_1694:
    adr x0, sign_id
cond_end_1695:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1708_1709
func_1708:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1708_1709:
    // Closure for func_1708
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1708
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1706
    mov x0, #1
    b cond_end_1707
cond_false_1706:
    adr x0, sign_id
cond_end_1707:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1712
do_apply_1713:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1714
do_compose_1712:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1714:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1715
do_apply_1716:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1717
do_compose_1715:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1717:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1710
    mov x0, #1
    b cond_end_1711
cond_false_1710:
    adr x0, sign_id
cond_end_1711:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_1720
do_apply_1721:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1722
do_compose_1720:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1722:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _pow
    cmp x0, #4096
    b.hi do_compose_1723
do_apply_1724:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1725
do_compose_1723:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1725:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1718
    mov x0, #1
    b cond_end_1719
cond_false_1718:
    adr x0, sign_id
cond_end_1719:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1726
    b after_func_1730_1731
func_1730:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1732
    adr x0, sign_id
    b cmp_end_1733
cmp_true_1732:
cmp_end_1733:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1730_1731:
    // Closure for func_1730
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1730
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1728
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1734
do_apply_1735:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1736
do_compose_1734:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1736:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1737
do_apply_1738:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1739
do_compose_1737:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1739:
    b cond_end_1729
cond_false_1728:
    adr x0, sign_id
cond_end_1729:
    b cond_end_1727
cond_false_1726:
    adr x0, sign_id
cond_end_1727:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_1740
do_apply_1741:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1742
do_compose_1740:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1742:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, next
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1743
    b after_func_1747_1748
func_1747:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1749
    adr x0, sign_id
    b cmp_end_1750
cmp_true_1749:
cmp_end_1750:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1747_1748:
    // Closure for func_1747
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1747
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1745
    mov x0, #0
    b cond_end_1746
cond_false_1745:
    adr x0, sign_id
cond_end_1746:
    b cond_end_1744
cond_false_1743:
    adr x0, sign_id
cond_end_1744:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_1751
do_apply_1752:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1753
do_compose_1751:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1753:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expect
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1754
    b after_func_1756_1757
func_1756:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1758_1759
func_1758:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1763_1764
func_1763:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1765_1766
func_1765:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1767_1768
func_1767:
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
after_func_1767_1768:
    // Closure for func_1767
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1767
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1765_1766:
    // Closure for func_1765
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1765
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1769
do_apply_1770:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1771
do_compose_1769:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1771:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1772
do_apply_1773:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1774
do_compose_1772:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1774:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1763_1764:
    // Closure for func_1763
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1763
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1775_1776
func_1775:
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
after_func_1775_1776:
    // Closure for func_1775
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1775
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1760
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1762
xor_true_1760:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1761
    adr x0, sign_id
    b xor_end_1762
xor_false_1761:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1758_1759:
    // Closure for func_1758
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1758
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1756_1757:
    // Closure for func_1756
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1756
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1755
cond_false_1754:
    adr x0, sign_id
cond_end_1755:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1777_1778
func_1777:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1782_1783
func_1782:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1784_1785
func_1784:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1786_1787
func_1786:
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
after_func_1786_1787:
    // Closure for func_1786
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1786
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1784_1785:
    // Closure for func_1784
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1784
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1788
do_apply_1789:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1790
do_compose_1788:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1790:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1791
do_apply_1792:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1793
do_compose_1791:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1793:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1782_1783:
    // Closure for func_1782
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1782
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1794_1795
func_1794:
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
after_func_1794_1795:
    // Closure for func_1794
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1794
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1779
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1781
xor_true_1779:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1780
    adr x0, sign_id
    b xor_end_1781
xor_false_1780:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1777_1778:
    // Closure for func_1777
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1777
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_t
    str x0, [sp, #-16]!
    adr x0, type
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1798
    adr x0, sign_id
    b cmp_end_1799
cmp_true_1798:
cmp_end_1799:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1796
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_1800
do_apply_1801:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1802
do_compose_1800:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1802:
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_1803
do_apply_1804:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1805
do_compose_1803:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1805:
    cmp x0, #4096
    b.hi do_compose_1806
do_apply_1807:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1808
do_compose_1806:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1808:
    b cond_end_1797
cond_false_1796:
    adr x0, sign_id
cond_end_1797:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1809
do_apply_1810:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1811
do_compose_1809:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1811:
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_1812
do_apply_1813:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1814
do_compose_1812:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1814:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_1815
do_apply_1816:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1817
do_compose_1815:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1817:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_1818
do_apply_1819:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1820
do_compose_1818:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1820:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1821
    b after_func_1823_1824
func_1823:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1825_1826
func_1825:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1830_1831
func_1830:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1832_1833
func_1832:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1834_1835
func_1834:
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
after_func_1834_1835:
    // Closure for func_1834
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1834
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1832_1833:
    // Closure for func_1832
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1832
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1836
do_apply_1837:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1838
do_compose_1836:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1838:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1839
do_apply_1840:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1841
do_compose_1839:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1841:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1830_1831:
    // Closure for func_1830
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1830
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1842_1843
func_1842:
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
after_func_1842_1843:
    // Closure for func_1842
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1842
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1827
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1829
xor_true_1827:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1828
    adr x0, sign_id
    b xor_end_1829
xor_false_1828:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1825_1826:
    // Closure for func_1825
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1825
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1823_1824:
    // Closure for func_1823
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1823
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1822
cond_false_1821:
    adr x0, sign_id
cond_end_1822:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1844
do_apply_1845:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1846
do_compose_1844:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1846:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_1847
do_apply_1848:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1849
do_compose_1847:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1849:
    cmp x0, #4096
    b.hi do_compose_1850
do_apply_1851:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1852
do_compose_1850:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1852:
    cmp x0, #4096
    b.hi do_compose_1853
do_apply_1854:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1855
do_compose_1853:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1855:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_1856
do_apply_1857:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1858
do_compose_1856:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1858:
    cmp x0, #4096
    b.hi do_compose_1859
do_apply_1860:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1861
do_compose_1859:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1861:
    cmp x0, #4096
    b.hi do_compose_1862
do_apply_1863:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1864
do_compose_1862:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1864:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1865
do_apply_1866:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1867
do_compose_1865:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1867:
    cmp x0, #4096
    b.hi do_compose_1868
do_apply_1869:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1870
do_compose_1868:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1870:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_1871
do_apply_1872:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1873
do_compose_1871:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1873:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_stmts
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1874
    b after_func_1876_1877
func_1876:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1878_1879
func_1878:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1883_1884
func_1883:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1885_1886
func_1885:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1887_1888
func_1887:
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
after_func_1887_1888:
    // Closure for func_1887
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1887
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1885_1886:
    // Closure for func_1885
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1885
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1889
do_apply_1890:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1891
do_compose_1889:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1891:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1892
do_apply_1893:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1894
do_compose_1892:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1894:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1883_1884:
    // Closure for func_1883
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1883
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1895_1896
func_1895:
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
after_func_1895_1896:
    // Closure for func_1895
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1895
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1880
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1882
xor_true_1880:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1881
    adr x0, sign_id
    b xor_end_1882
xor_false_1881:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1878_1879:
    // Closure for func_1878
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1878
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1876_1877:
    // Closure for func_1876
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1876
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1875
cond_false_1874:
    adr x0, sign_id
cond_end_1875:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1897_1898
func_1897:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1902_1903
func_1902:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1904_1905
func_1904:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1906_1907
func_1906:
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
after_func_1906_1907:
    // Closure for func_1906
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1906
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1904_1905:
    // Closure for func_1904
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1904
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1908
do_apply_1909:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1910
do_compose_1908:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1910:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1911
do_apply_1912:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1913
do_compose_1911:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1913:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1902_1903:
    // Closure for func_1902
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1902
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1914_1915
func_1914:
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
after_func_1914_1915:
    // Closure for func_1914
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1914
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1899
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1901
xor_true_1899:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1900
    adr x0, sign_id
    b xor_end_1901
xor_false_1900:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1897_1898:
    // Closure for func_1897
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1897
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1918
    adr x0, sign_id
    b cmp_end_1919
cmp_true_1918:
cmp_end_1919:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1916
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1920
do_apply_1921:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1922
do_compose_1920:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1922:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_1923
do_apply_1924:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1925
do_compose_1923:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1925:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1926
do_apply_1927:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1928
do_compose_1926:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1928:
    cmp x0, #4096
    b.hi do_compose_1929
do_apply_1930:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1931
do_compose_1929:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1931:
    b cond_end_1917
cond_false_1916:
    adr x0, sign_id
cond_end_1917:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1934
    adr x0, sign_id
    b cmp_end_1935
cmp_true_1934:
cmp_end_1935:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1932
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_1936
do_apply_1937:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1938
do_compose_1936:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1938:
    cmp x0, #4096
    b.hi do_compose_1939
do_apply_1940:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1941
do_compose_1939:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1941:
    b cond_end_1933
cond_false_1932:
    adr x0, sign_id
cond_end_1933:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_4
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1942_1943
func_1942:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1947_1948
func_1947:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1949_1950
func_1949:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1951_1952
func_1951:
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
after_func_1951_1952:
    // Closure for func_1951
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1951
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_1953
do_apply_1954:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1955
do_compose_1953:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1955:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1956
do_apply_1957:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1958
do_compose_1956:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1958:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1947_1948:
    // Closure for func_1947
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1947
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1959_1960
func_1959:
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
after_func_1959_1960:
    // Closure for func_1959
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1959
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1944
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1946
xor_true_1944:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1945
    adr x0, sign_id
    b xor_end_1946
xor_false_1945:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1942_1943:
    // Closure for func_1942
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1942
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1961_1962
func_1961:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1966_1967
func_1966:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1968_1969
func_1968:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1970_1971
func_1970:
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
after_func_1970_1971:
    // Closure for func_1970
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1970
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1968_1969:
    // Closure for func_1968
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1968
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1972
do_apply_1973:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1974
do_compose_1972:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1974:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1975
do_apply_1976:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1977
do_compose_1975:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1977:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1966_1967:
    // Closure for func_1966
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1966
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1978_1979
func_1978:
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
after_func_1978_1979:
    // Closure for func_1978
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1978
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1963
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1965
xor_true_1963:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1964
    adr x0, sign_id
    b xor_end_1965
xor_false_1964:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1961_1962:
    // Closure for func_1961
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1961
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1980_1981
func_1980:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1985_1986
func_1985:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1987_1988
func_1987:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1989_1990
func_1989:
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
after_func_1989_1990:
    // Closure for func_1989
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1989
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1987_1988:
    // Closure for func_1987
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1987
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1991
do_apply_1992:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1993
do_compose_1991:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1993:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1994
do_apply_1995:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1996
do_compose_1994:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1996:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1985_1986:
    // Closure for func_1985
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1985
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1997_1998
func_1997:
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
after_func_1997_1998:
    // Closure for func_1997
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1997
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1982
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1984
xor_true_1982:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1983
    adr x0, sign_id
    b xor_end_1984
xor_false_1983:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1980_1981:
    // Closure for func_1980
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1980
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1999_2000
func_1999:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2004_2005
func_2004:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2006_2007
func_2006:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2008_2009
func_2008:
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
after_func_2008_2009:
    // Closure for func_2008
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2008
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_2010
do_apply_2011:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2012
do_compose_2010:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2012:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2013
do_apply_2014:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2015
do_compose_2013:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2015:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2004_2005:
    // Closure for func_2004
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2004
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2016_2017
func_2016:
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
after_func_2016_2017:
    // Closure for func_2016
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2016
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2001
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2003
xor_true_2001:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2002
    adr x0, sign_id
    b xor_end_2003
xor_false_2002:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1999_2000:
    // Closure for func_1999
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1999
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, expr
    cmp x0, #4096
    b.hi do_compose_2018
do_apply_2019:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2020
do_compose_2018:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2020:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res2
    cmp x0, #4096
    b.hi do_compose_2021
do_apply_2022:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2023
do_compose_2021:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2023:
    cmp x0, #4096
    b.hi do_compose_2024
do_apply_2025:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2026
do_compose_2024:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2026:
    cmp x0, #4096
    b.hi do_compose_2027
do_apply_2028:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2029
do_compose_2027:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2029:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res2
    cmp x0, #4096
    b.hi do_compose_2030
do_apply_2031:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2032
do_compose_2030:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2032:
    cmp x0, #4096
    b.hi do_compose_2033
do_apply_2034:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2035
do_compose_2033:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2035:
    cmp x0, #4096
    b.hi do_compose_2036
do_apply_2037:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2038
do_compose_2036:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2038:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2039
do_apply_2040:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2041
do_compose_2039:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2041:
    cmp x0, #4096
    b.hi do_compose_2042
do_apply_2043:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2044
do_compose_2042:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2044:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, rest
    cmp x0, #4096
    b.hi do_compose_2045
do_apply_2046:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2047
do_compose_2045:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2047:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_2048
do_apply_2049:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2050
do_compose_2048:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2050:
    cmp x0, #4096
    b.hi do_compose_2051
do_apply_2052:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2053
do_compose_2051:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2053:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_2054
do_apply_2055:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2056
do_compose_2054:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2056:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2057
do_apply_2058:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2059
do_compose_2057:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2059:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2060
do_apply_2061:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2062
do_compose_2060:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2062:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_2063
do_apply_2064:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2065
do_compose_2063:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2065:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2066
do_apply_2067:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2068
do_compose_2066:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2068:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2069
    b after_func_2071_2072
func_2071:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_5
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2071_2072:
    // Closure for func_2071
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2071
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2070
cond_false_2069:
    adr x0, sign_id
cond_end_2070:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2073
do_apply_2074:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2075
do_compose_2073:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2075:
    str x0, [sp, #-16]!
    adr x0, str_6
    cmp x0, #4096
    b.hi do_compose_2076
do_apply_2077:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2078
do_compose_2076:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2078:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2079
    b after_func_2081_2082
func_2081:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2083_2084
func_2083:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2088_2089
func_2088:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2090_2091
func_2090:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2092_2093
func_2092:
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
after_func_2092_2093:
    // Closure for func_2092
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2092
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2090_2091:
    // Closure for func_2090
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2090
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2094
do_apply_2095:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2096
do_compose_2094:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2096:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2097
do_apply_2098:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2099
do_compose_2097:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2099:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2088_2089:
    // Closure for func_2088
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2088
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2100_2101
func_2100:
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
after_func_2100_2101:
    // Closure for func_2100
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2100
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2085
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2087
xor_true_2085:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2086
    adr x0, sign_id
    b xor_end_2087
xor_false_2086:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2083_2084:
    // Closure for func_2083
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2083
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2081_2082:
    // Closure for func_2081
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2081
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2080
cond_false_2079:
    adr x0, sign_id
cond_end_2080:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2102_2103
func_2102:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2107_2108
func_2107:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2109_2110
func_2109:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2111_2112
func_2111:
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
after_func_2111_2112:
    // Closure for func_2111
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2111
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2109_2110:
    // Closure for func_2109
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2109
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2113
do_apply_2114:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2115
do_compose_2113:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2115:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2116
do_apply_2117:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2118
do_compose_2116:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2118:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2107_2108:
    // Closure for func_2107
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2107
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2119_2120
func_2119:
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
after_func_2119_2120:
    // Closure for func_2119
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2119
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2104
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2106
xor_true_2104:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2105
    adr x0, sign_id
    b xor_end_2106
xor_false_2105:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2102_2103:
    // Closure for func_2102
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2102
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2121_2122
func_2121:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2126_2127
func_2126:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2128_2129
func_2128:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2130_2131
func_2130:
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
after_func_2130_2131:
    // Closure for func_2130
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2130
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2128_2129:
    // Closure for func_2128
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2128
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2132
do_apply_2133:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2134
do_compose_2132:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2134:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2135
do_apply_2136:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2137
do_compose_2135:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2137:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2126_2127:
    // Closure for func_2126
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2126
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2138_2139
func_2138:
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
after_func_2138_2139:
    // Closure for func_2138
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2138
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2121_2122:
    // Closure for func_2121
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2121
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_2140
do_apply_2141:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2142
do_compose_2140:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2142:
    str x0, [sp, #-16]!
    adr x0, rest_1
    cmp x0, #4096
    b.hi do_compose_2143
do_apply_2144:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2145
do_compose_2143:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2145:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_2146
do_apply_2147:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2148
do_compose_2146:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2148:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_lhs
    cmp x0, #4096
    b.hi do_compose_2149
do_apply_2150:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2151
do_compose_2149:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2151:
    cmp x0, #4096
    b.hi do_compose_2152
do_apply_2153:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2154
do_compose_2152:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2154:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_lhs
    cmp x0, #4096
    b.hi do_compose_2155
do_apply_2156:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2157
do_compose_2155:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2157:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_primary
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2158
do_apply_2159:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2160
do_compose_2158:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2160:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2161
    b after_func_2163_2164
func_2163:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2165_2166
func_2165:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2170_2171
func_2170:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2172_2173
func_2172:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2174_2175
func_2174:
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
after_func_2174_2175:
    // Closure for func_2174
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2174
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2172_2173:
    // Closure for func_2172
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2172
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2176
do_apply_2177:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2178
do_compose_2176:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2178:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2179
do_apply_2180:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2181
do_compose_2179:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2181:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2170_2171:
    // Closure for func_2170
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2170
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2182_2183
func_2182:
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
after_func_2182_2183:
    // Closure for func_2182
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2182
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2167
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2169
xor_true_2167:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2168
    adr x0, sign_id
    b xor_end_2169
xor_false_2168:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2165_2166:
    // Closure for func_2165
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2165
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2163_2164:
    // Closure for func_2163
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2163
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2162
cond_false_2161:
    adr x0, sign_id
cond_end_2162:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2184_2185
func_2184:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2189_2190
func_2189:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2191_2192
func_2191:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2193_2194
func_2193:
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
after_func_2193_2194:
    // Closure for func_2193
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2193
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2191_2192:
    // Closure for func_2191
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2191
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2195
do_apply_2196:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2197
do_compose_2195:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2197:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2198
do_apply_2199:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2200
do_compose_2198:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2200:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2189_2190:
    // Closure for func_2189
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2189
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2201_2202
func_2201:
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
after_func_2201_2202:
    // Closure for func_2201
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2201
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2186
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2188
xor_true_2186:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2187
    adr x0, sign_id
    b xor_end_2188
xor_false_2187:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2184_2185:
    // Closure for func_2184
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2184
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_7
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, can_start_expr
    str x0, [sp, #-16]!
    adr x0, type
    cmp x0, #4096
    b.hi do_compose_2205
do_apply_2206:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2207
do_compose_2205:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2207:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2203
    adr x0, sign_id
    b cond_end_2204
cond_false_2203:
    adr x0, sign_id
cond_end_2204:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_8
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2208_2209
func_2208:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2213_2214
func_2213:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2215_2216
func_2215:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2217_2218
func_2217:
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
after_func_2217_2218:
    // Closure for func_2217
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2217
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2215_2216:
    // Closure for func_2215
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2215
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2219
do_apply_2220:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2221
do_compose_2219:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2221:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2222
do_apply_2223:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2224
do_compose_2222:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2224:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2213_2214:
    // Closure for func_2213
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2213
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2225_2226
func_2225:
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
after_func_2225_2226:
    // Closure for func_2225
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2225
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2210
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2212
xor_true_2210:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2211
    adr x0, sign_id
    b xor_end_2212
xor_false_2211:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2208_2209:
    // Closure for func_2208
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2208
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2227_2228
func_2227:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2232_2233
func_2232:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2234_2235
func_2234:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2236_2237
func_2236:
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
after_func_2236_2237:
    // Closure for func_2236
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2236
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2234_2235:
    // Closure for func_2234
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2234
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2238
do_apply_2239:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2240
do_compose_2238:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2240:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2241
do_apply_2242:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2243
do_compose_2241:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2243:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2232_2233:
    // Closure for func_2232
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2232
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2244_2245
func_2244:
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
after_func_2244_2245:
    // Closure for func_2244
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2244
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2229
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2231
xor_true_2229:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2230
    adr x0, sign_id
    b xor_end_2231
xor_false_2230:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2227_2228:
    // Closure for func_2227
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2227
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2246_2247
func_2246:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2251_2252
func_2251:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2253_2254
func_2253:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2255_2256
func_2255:
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
after_func_2255_2256:
    // Closure for func_2255
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2255
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2253_2254:
    // Closure for func_2253
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2253
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2257
do_apply_2258:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2259
do_compose_2257:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2259:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2260
do_apply_2261:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2262
do_compose_2260:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2262:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2251_2252:
    // Closure for func_2251
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2251
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2263_2264
func_2263:
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
after_func_2263_2264:
    // Closure for func_2263
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2263
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2248
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2250
xor_true_2248:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2249
    adr x0, sign_id
    b xor_end_2250
xor_false_2249:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2246_2247:
    // Closure for func_2246
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2246
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2265_2266
func_2265:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2270_2271
func_2270:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2272_2273
func_2272:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2274_2275
func_2274:
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
after_func_2274_2275:
    // Closure for func_2274
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2274
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2272_2273:
    // Closure for func_2272
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2272
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2276
do_apply_2277:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2278
do_compose_2276:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2278:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2279
do_apply_2280:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2281
do_compose_2279:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2281:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2270_2271:
    // Closure for func_2270
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2270
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2282_2283
func_2282:
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
after_func_2282_2283:
    // Closure for func_2282
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2282
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2267
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2269
xor_true_2267:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2268
    adr x0, sign_id
    b xor_end_2269
xor_false_2268:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2265_2266:
    // Closure for func_2265
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2265
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, new_lhs
    cmp x0, #4096
    b.hi do_compose_2284
do_apply_2285:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2286
do_compose_2284:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2286:
    str x0, [sp, #-16]!
    adr x0, rest_rhs
    cmp x0, #4096
    b.hi do_compose_2287
do_apply_2288:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2289
do_compose_2287:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2289:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_2290
do_apply_2291:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2292
do_compose_2290:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2292:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2293
do_apply_2294:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2295
do_compose_2293:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2295:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_2296
do_apply_2297:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2298
do_compose_2296:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2298:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_2299
do_apply_2300:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2301
do_compose_2299:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2301:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2302
do_apply_2303:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2304
do_compose_2302:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2304:
    cmp x0, #4096
    b.hi do_compose_2305
do_apply_2306:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2307
do_compose_2305:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2307:
    cmp x0, #4096
    b.hi do_compose_2308
do_apply_2309:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2310
do_compose_2308:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2310:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs
    cmp x0, #4096
    b.hi do_compose_2311
do_apply_2312:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2313
do_compose_2311:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2313:
    cmp x0, #4096
    b.hi do_compose_2314
do_apply_2315:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2316
do_compose_2314:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2316:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_rhs
    cmp x0, #4096
    b.hi do_compose_2317
do_apply_2318:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2319
do_compose_2317:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2319:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2320
do_apply_2321:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2322
do_compose_2320:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2322:
    str x0, [sp, #-16]!
    mov x0, #6
    cmp x0, #4096
    b.hi do_compose_2323
do_apply_2324:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2325
do_compose_2323:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2325:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_9
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_2328
    adr x0, sign_id
    b cmp_end_2329
cmp_true_2328:
cmp_end_2329:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2326
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_2330
do_apply_2331:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2332
do_compose_2330:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2332:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2333
do_apply_2334:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2335
do_compose_2333:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2335:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2336
do_apply_2337:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2338
do_compose_2336:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2338:
    cmp x0, #4096
    b.hi do_compose_2339
do_apply_2340:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2341
do_compose_2339:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2341:
    b cond_end_2327
cond_false_2326:
    adr x0, sign_id
cond_end_2327:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2342_2343
func_2342:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2347_2348
func_2347:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2349_2350
func_2349:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2351_2352
func_2351:
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
after_func_2351_2352:
    // Closure for func_2351
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2351
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2349_2350:
    // Closure for func_2349
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2349
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2353
do_apply_2354:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2355
do_compose_2353:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2355:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2356
do_apply_2357:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2358
do_compose_2356:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2358:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2347_2348:
    // Closure for func_2347
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2347
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2359_2360
func_2359:
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
after_func_2359_2360:
    // Closure for func_2359
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2359
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2344
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2346
xor_true_2344:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2345
    adr x0, sign_id
    b xor_end_2346
xor_false_2345:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2342_2343:
    // Closure for func_2342
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2342
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2361_2362
func_2361:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2366_2367
func_2366:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2368_2369
func_2368:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2370_2371
func_2370:
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
after_func_2370_2371:
    // Closure for func_2370
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2370
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2368_2369:
    // Closure for func_2368
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2368
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2372
do_apply_2373:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2374
do_compose_2372:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2374:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2375
do_apply_2376:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2377
do_compose_2375:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2377:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2366_2367:
    // Closure for func_2366
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2366
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2378_2379
func_2378:
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
after_func_2378_2379:
    // Closure for func_2378
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2378
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2363
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2365
xor_true_2363:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2364
    adr x0, sign_id
    b xor_end_2365
xor_false_2364:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2361_2362:
    // Closure for func_2361
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2361
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, prec
    str x0, [sp, #-16]!
    adr x0, min_prec
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_2382
    adr x0, sign_id
    b cmp_end_2383
cmp_true_2382:
cmp_end_2383:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2380
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_2384
do_apply_2385:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2386
do_compose_2384:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2386:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2387
do_apply_2388:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2389
do_compose_2387:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2389:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2390
do_apply_2391:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2392
do_compose_2390:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2392:
    cmp x0, #4096
    b.hi do_compose_2393
do_apply_2394:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2395
do_compose_2393:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2395:
    b cond_end_2381
cond_false_2380:
    adr x0, sign_id
cond_end_2381:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2396_2397
func_2396:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2401_2402
func_2401:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2403_2404
func_2403:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2405_2406
func_2405:
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
after_func_2405_2406:
    // Closure for func_2405
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2405
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2403_2404:
    // Closure for func_2403
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2403
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2407
do_apply_2408:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2409
do_compose_2407:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2409:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2410
do_apply_2411:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2412
do_compose_2410:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2412:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2401_2402:
    // Closure for func_2401
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2401
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2413_2414
func_2413:
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
after_func_2413_2414:
    // Closure for func_2413
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2413
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2398
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2400
xor_true_2398:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2399
    adr x0, sign_id
    b xor_end_2400
xor_false_2399:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2396_2397:
    // Closure for func_2396
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2396
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2415_2416
func_2415:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2420_2421
func_2420:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2422_2423
func_2422:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2424_2425
func_2424:
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
after_func_2424_2425:
    // Closure for func_2424
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2424
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2422_2423:
    // Closure for func_2422
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2422
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2426
do_apply_2427:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2428
do_compose_2426:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2428:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2429
do_apply_2430:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2431
do_compose_2429:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2431:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2420_2421:
    // Closure for func_2420
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2420
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2432_2433
func_2432:
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
after_func_2432_2433:
    // Closure for func_2432
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2432
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2417
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2419
xor_true_2417:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2418
    adr x0, sign_id
    b xor_end_2419
xor_false_2418:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2415_2416:
    // Closure for func_2415
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2415
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2434_2435
func_2434:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2439_2440
func_2439:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2441_2442
func_2441:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2443_2444
func_2443:
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
after_func_2443_2444:
    // Closure for func_2443
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2443
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2441_2442:
    // Closure for func_2441
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2441
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2445
do_apply_2446:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2447
do_compose_2445:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2447:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2448
do_apply_2449:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2450
do_compose_2448:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2450:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2439_2440:
    // Closure for func_2439
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2439
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2451_2452
func_2451:
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
after_func_2451_2452:
    // Closure for func_2451
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2451
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2436
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2438
xor_true_2436:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2437
    adr x0, sign_id
    b xor_end_2438
xor_false_2437:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2434_2435:
    // Closure for func_2434
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2434
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2453_2454
func_2453:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2458_2459
func_2458:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2460_2461
func_2460:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2462_2463
func_2462:
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
after_func_2462_2463:
    // Closure for func_2462
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2462
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2460_2461:
    // Closure for func_2460
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2460
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2464
do_apply_2465:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2466
do_compose_2464:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2466:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2467
do_apply_2468:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2469
do_compose_2467:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2469:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2458_2459:
    // Closure for func_2458
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2458
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2470_2471
func_2470:
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
after_func_2470_2471:
    // Closure for func_2470
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2470
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2455
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2457
xor_true_2455:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2456
    adr x0, sign_id
    b xor_end_2457
xor_false_2456:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2453_2454:
    // Closure for func_2453
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2453
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2472_2473
func_2472:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2477_2478
func_2477:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2479_2480
func_2479:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2481_2482
func_2481:
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
after_func_2481_2482:
    // Closure for func_2481
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2481
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2479_2480:
    // Closure for func_2479
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2479
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2483
do_apply_2484:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2485
do_compose_2483:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2485:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2486
do_apply_2487:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2488
do_compose_2486:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2488:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2477_2478:
    // Closure for func_2477
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2477
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2489_2490
func_2489:
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
after_func_2489_2490:
    // Closure for func_2489
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2489
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2474
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2476
xor_true_2474:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2475
    adr x0, sign_id
    b xor_end_2476
xor_false_2475:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2472_2473:
    // Closure for func_2472
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2472
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2491_2492
func_2491:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2496_2497
func_2496:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2498_2499
func_2498:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2500_2501
func_2500:
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
after_func_2500_2501:
    // Closure for func_2500
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2500
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2498_2499:
    // Closure for func_2498
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2498
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2502
do_apply_2503:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2504
do_compose_2502:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2504:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2505
do_apply_2506:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2507
do_compose_2505:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2507:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2496_2497:
    // Closure for func_2496
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2496
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2508_2509
func_2508:
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
after_func_2508_2509:
    // Closure for func_2508
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2508
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2493
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2495
xor_true_2493:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2494
    adr x0, sign_id
    b xor_end_2495
xor_false_2494:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2491_2492:
    // Closure for func_2491
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2491
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, new_lhs
    cmp x0, #4096
    b.hi do_compose_2510
do_apply_2511:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2512
do_compose_2510:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2512:
    str x0, [sp, #-16]!
    adr x0, rest_rhs
    cmp x0, #4096
    b.hi do_compose_2513
do_apply_2514:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2515
do_compose_2513:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2515:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_2516
do_apply_2517:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2518
do_compose_2516:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2518:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2519
do_apply_2520:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2521
do_compose_2519:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2521:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_2522
do_apply_2523:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2524
do_compose_2522:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2524:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_2525
do_apply_2526:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2527
do_compose_2525:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2527:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_2528
do_apply_2529:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2530
do_compose_2528:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2530:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2531
do_apply_2532:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2533
do_compose_2531:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2533:
    cmp x0, #4096
    b.hi do_compose_2534
do_apply_2535:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2536
do_compose_2534:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2536:
    cmp x0, #4096
    b.hi do_compose_2537
do_apply_2538:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2539
do_compose_2537:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2539:
    cmp x0, #4096
    b.hi do_compose_2540
do_apply_2541:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2542
do_compose_2540:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2542:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs
    cmp x0, #4096
    b.hi do_compose_2543
do_apply_2544:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2545
do_compose_2543:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2545:
    cmp x0, #4096
    b.hi do_compose_2546
do_apply_2547:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2548
do_compose_2546:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2548:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_rhs
    cmp x0, #4096
    b.hi do_compose_2549
do_apply_2550:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2551
do_compose_2549:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2551:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, next_tokens
    cmp x0, #4096
    b.hi do_compose_2552
do_apply_2553:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2554
do_compose_2552:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2554:
    str x0, [sp, #-16]!
    adr x0, next_min_prec
    cmp x0, #4096
    b.hi do_compose_2555
do_apply_2556:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2557
do_compose_2555:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2557:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2558_2559
func_2558:
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
    cmp x0, #4096
    b.hi do_compose_2560
do_apply_2561:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2562
do_compose_2560:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2562:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2558_2559:
    // Closure for func_2558
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2558
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2563
do_apply_2564:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2565
do_compose_2563:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2565:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_prec
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_2566
do_apply_2567:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2568
do_compose_2566:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2568:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_2569
do_apply_2570:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2571
do_compose_2569:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2571:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_2572
do_apply_2573:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2574
do_compose_2572:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2574:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_2575
do_apply_2576:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2577
do_compose_2575:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2577:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, can_start_expr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2578
    b after_func_2582_2583
func_2582:
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
    b.eq cmp_true_2584
    adr x0, sign_id
    b cmp_end_2585
cmp_true_2584:
cmp_end_2585:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2582_2583:
    // Closure for func_2582
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2582
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2580
    mov x0, #1
    b cond_end_2581
cond_false_2580:
    adr x0, sign_id
cond_end_2581:
    b cond_end_2579
cond_false_2578:
    adr x0, sign_id
cond_end_2579:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2588
    adr x0, sign_id
    b cmp_end_2589
cmp_true_2588:
cmp_end_2589:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2586
    mov x0, #1
    b cond_end_2587
cond_false_2586:
    adr x0, sign_id
cond_end_2587:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2592
    adr x0, sign_id
    b cmp_end_2593
cmp_true_2592:
cmp_end_2593:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2590
    mov x0, #1
    b cond_end_2591
cond_false_2590:
    adr x0, sign_id
cond_end_2591:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2596
    adr x0, sign_id
    b cmp_end_2597
cmp_true_2596:
cmp_end_2597:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2594
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, str_10
    cmp x0, #4096
    b.hi do_compose_2598
do_apply_2599:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2600
do_compose_2598:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2600:
    b cond_end_2595
cond_false_2594:
    adr x0, sign_id
cond_end_2595:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_prefix_op
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2601
    b after_func_2605_2606
func_2605:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2607
do_apply_2608:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2609
do_compose_2607:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2609:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    bl _factorial
    cmp x0, #4096
    b.hi do_compose_2610
do_apply_2611:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2612
do_compose_2610:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2612:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2613
do_apply_2614:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2615
do_compose_2613:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2615:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2605_2606:
    // Closure for func_2605
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2605
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2603
    mov x0, #1
    b cond_end_2604
cond_false_2603:
    adr x0, sign_id
cond_end_2604:
    b cond_end_2602
cond_false_2601:
    adr x0, sign_id
cond_end_2602:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_2618
do_apply_2619:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2620
do_compose_2618:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2620:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2621
do_apply_2622:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2623
do_compose_2621:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2623:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2616
    mov x0, #1
    b cond_end_2617
cond_false_2616:
    adr x0, sign_id
cond_end_2617:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_2626
do_apply_2627:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2628
do_compose_2626:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2628:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2629
do_apply_2630:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2631
do_compose_2629:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2631:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_2632
do_apply_2633:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2634
do_compose_2632:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2634:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2624
    mov x0, #1
    b cond_end_2625
cond_false_2624:
    adr x0, sign_id
cond_end_2625:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_2637
do_apply_2638:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2639
do_compose_2637:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2639:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    cmp x0, #4096
    b.hi do_compose_2640
do_apply_2641:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2642
do_compose_2640:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2642:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2635
    mov x0, #1
    b cond_end_2636
cond_false_2635:
    adr x0, sign_id
cond_end_2636:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_primary
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2643
    b after_func_2645_2646
func_2645:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2647_2648
func_2647:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2652_2653
func_2652:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2654_2655
func_2654:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2656_2657
func_2656:
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
after_func_2656_2657:
    // Closure for func_2656
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2656
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2654_2655:
    // Closure for func_2654
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2654
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2658
do_apply_2659:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2660
do_compose_2658:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2660:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2661
do_apply_2662:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2663
do_compose_2661:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2663:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2652_2653:
    // Closure for func_2652
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2652
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2664_2665
func_2664:
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
after_func_2664_2665:
    // Closure for func_2664
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2664
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2649
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2651
xor_true_2649:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2650
    adr x0, sign_id
    b xor_end_2651
xor_false_2650:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2647_2648:
    // Closure for func_2647
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2647
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2645_2646:
    // Closure for func_2645
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2645
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2644
cond_false_2643:
    adr x0, sign_id
cond_end_2644:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2666_2667
func_2666:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2671_2672
func_2671:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2673_2674
func_2673:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2675_2676
func_2675:
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
after_func_2675_2676:
    // Closure for func_2675
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2675
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_2677
do_apply_2678:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2679
do_compose_2677:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2679:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2680
do_apply_2681:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2682
do_compose_2680:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2682:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2671_2672:
    // Closure for func_2671
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2671
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2683_2684
func_2683:
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
after_func_2683_2684:
    // Closure for func_2683
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2683
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2668
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2670
xor_true_2668:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2669
    adr x0, sign_id
    b xor_end_2670
xor_false_2669:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2666_2667:
    // Closure for func_2666
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2666
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2685_2686
func_2685:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2690_2691
func_2690:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2692_2693
func_2692:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2694_2695
func_2694:
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
after_func_2694_2695:
    // Closure for func_2694
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2694
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2692_2693:
    // Closure for func_2692
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2692
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2696
do_apply_2697:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2698
do_compose_2696:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2698:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2699
do_apply_2700:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2701
do_compose_2699:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2701:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2690_2691:
    // Closure for func_2690
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2690
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2702_2703
func_2702:
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
after_func_2702_2703:
    // Closure for func_2702
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2702
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2687
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2689
xor_true_2687:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2688
    adr x0, sign_id
    b xor_end_2689
xor_false_2688:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2685_2686:
    // Closure for func_2685
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2685
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
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
    adr x0, sign_id
    b cond_end_2705
cond_false_2704:
    adr x0, sign_id
cond_end_2705:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2708_2709
func_2708:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2713_2714
func_2713:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2715_2716
func_2715:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2717_2718
func_2717:
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
after_func_2717_2718:
    // Closure for func_2717
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2717
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_2719
do_apply_2720:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2721
do_compose_2719:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2721:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2722
do_apply_2723:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2724
do_compose_2722:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2724:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2713_2714:
    // Closure for func_2713
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2713
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2725_2726
func_2725:
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
after_func_2725_2726:
    // Closure for func_2725
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2725
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2710
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2712
xor_true_2710:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2711
    adr x0, sign_id
    b xor_end_2712
xor_false_2711:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2727
do_apply_2728:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2729
do_compose_2727:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2729:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_2730
do_apply_2731:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2732
do_compose_2730:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2732:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2733
do_apply_2734:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2735
do_compose_2733:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2735:
    cmp x0, #4096
    b.hi do_compose_2736
do_apply_2737:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2738
do_compose_2736:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2738:
    cmp x0, #4096
    b.hi do_compose_2739
do_apply_2740:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2741
do_compose_2739:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2741:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_2742
do_apply_2743:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2744
do_compose_2742:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2744:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2745
do_apply_2746:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2747
do_compose_2745:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2747:
    cmp x0, #4096
    b.hi do_compose_2748
do_apply_2749:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2750
do_compose_2748:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2750:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_2751
do_apply_2752:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2753
do_compose_2751:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2753:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2756
    adr x0, sign_id
    b cmp_end_2757
cmp_true_2756:
cmp_end_2757:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2754
    adr x0, sign_id
    b cond_end_2755
cond_false_2754:
    adr x0, sign_id
cond_end_2755:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2758_2759
func_2758:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2763_2764
func_2763:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2765_2766
func_2765:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2767_2768
func_2767:
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
after_func_2767_2768:
    // Closure for func_2767
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2767
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2765_2766:
    // Closure for func_2765
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2765
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2769
do_apply_2770:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2771
do_compose_2769:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2771:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2772
do_apply_2773:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2774
do_compose_2772:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2774:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2763_2764:
    // Closure for func_2763
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2763
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2775_2776
func_2775:
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
after_func_2775_2776:
    // Closure for func_2775
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2775
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2760
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2762
xor_true_2760:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2761
    adr x0, sign_id
    b xor_end_2762
xor_false_2761:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2758_2759:
    // Closure for func_2758
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2758
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2777
do_apply_2778:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2779
do_compose_2777:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2779:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_2780
do_apply_2781:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2782
do_compose_2780:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2782:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2783
do_apply_2784:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2785
do_compose_2783:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2785:
    cmp x0, #4096
    b.hi do_compose_2786
do_apply_2787:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2788
do_compose_2786:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2788:
    cmp x0, #4096
    b.hi do_compose_2789
do_apply_2790:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2791
do_compose_2789:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2791:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_2792
do_apply_2793:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2794
do_compose_2792:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2794:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2795
do_apply_2796:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2797
do_compose_2795:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2797:
    cmp x0, #4096
    b.hi do_compose_2798
do_apply_2799:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2800
do_compose_2798:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2800:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_2801
do_apply_2802:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2803
do_compose_2801:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2803:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2806
    adr x0, sign_id
    b cmp_end_2807
cmp_true_2806:
cmp_end_2807:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2804
    adr x0, sign_id
    b cond_end_2805
cond_false_2804:
    adr x0, sign_id
cond_end_2805:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2808_2809
func_2808:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2813_2814
func_2813:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2815_2816
func_2815:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2817_2818
func_2817:
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
after_func_2817_2818:
    // Closure for func_2817
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2817
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2815_2816:
    // Closure for func_2815
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2815
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2819
do_apply_2820:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2821
do_compose_2819:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2821:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2822
do_apply_2823:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2824
do_compose_2822:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2824:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2813_2814:
    // Closure for func_2813
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2813
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2825_2826
func_2825:
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
after_func_2825_2826:
    // Closure for func_2825
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2825
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2810
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2812
xor_true_2810:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2811
    adr x0, sign_id
    b xor_end_2812
xor_false_2811:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2808_2809:
    // Closure for func_2808
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2808
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2827
do_apply_2828:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2829
do_compose_2827:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2829:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_2830
do_apply_2831:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2832
do_compose_2830:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2832:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2833
do_apply_2834:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2835
do_compose_2833:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2835:
    cmp x0, #4096
    b.hi do_compose_2836
do_apply_2837:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2838
do_compose_2836:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2838:
    cmp x0, #4096
    b.hi do_compose_2839
do_apply_2840:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2841
do_compose_2839:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2841:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_2842
do_apply_2843:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2844
do_compose_2842:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2844:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2845
do_apply_2846:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2847
do_compose_2845:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2847:
    cmp x0, #4096
    b.hi do_compose_2848
do_apply_2849:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2850
do_compose_2848:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2850:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_2851
do_apply_2852:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2853
do_compose_2851:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2853:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2856
    adr x0, sign_id
    b cmp_end_2857
cmp_true_2856:
cmp_end_2857:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2854
    adr x0, sign_id
    b cond_end_2855
cond_false_2854:
    adr x0, sign_id
cond_end_2855:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2858_2859
func_2858:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2863_2864
func_2863:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2865_2866
func_2865:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2867_2868
func_2867:
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
after_func_2867_2868:
    // Closure for func_2867
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2867
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2865_2866:
    // Closure for func_2865
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2865
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2869
do_apply_2870:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2871
do_compose_2869:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2871:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2872
do_apply_2873:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2874
do_compose_2872:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2874:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2863_2864:
    // Closure for func_2863
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2863
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2875_2876
func_2875:
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
after_func_2875_2876:
    // Closure for func_2875
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2875
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2860
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2862
xor_true_2860:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2861
    adr x0, sign_id
    b xor_end_2862
xor_false_2861:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2858_2859:
    // Closure for func_2858
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2858
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_prefix_op
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_2879
do_apply_2880:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2881
do_compose_2879:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2881:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2877
    adr x0, sign_id
    b cond_end_2878
cond_false_2877:
    adr x0, sign_id
cond_end_2878:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_11
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2882_2883
func_2882:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2887_2888
func_2887:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2889_2890
func_2889:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2891_2892
func_2891:
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
after_func_2891_2892:
    // Closure for func_2891
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2891
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2889_2890:
    // Closure for func_2889
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2889
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2893
do_apply_2894:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2895
do_compose_2893:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2895:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2896
do_apply_2897:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2898
do_compose_2896:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2898:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2887_2888:
    // Closure for func_2887
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2887
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2899_2900
func_2899:
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
after_func_2899_2900:
    // Closure for func_2899
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2899
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2884
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2886
xor_true_2884:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2885
    adr x0, sign_id
    b xor_end_2886
xor_false_2885:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2882_2883:
    // Closure for func_2882
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2882
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_prefix
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2901
do_apply_2902:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2903
do_compose_2901:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2903:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_2904
do_apply_2905:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2906
do_compose_2904:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2906:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_2907
do_apply_2908:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2909
do_compose_2907:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2909:
    cmp x0, #4096
    b.hi do_compose_2910
do_apply_2911:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2912
do_compose_2910:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2912:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2913
do_apply_2914:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2915
do_compose_2913:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2915:
    cmp x0, #4096
    b.hi do_compose_2916
do_apply_2917:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2918
do_compose_2916:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2918:
    cmp x0, #4096
    b.hi do_compose_2919
do_apply_2920:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2921
do_compose_2919:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2921:
    cmp x0, #4096
    b.hi do_compose_2922
do_apply_2923:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2924
do_compose_2922:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2924:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_2925
do_apply_2926:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2927
do_compose_2925:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2927:
    cmp x0, #4096
    b.hi do_compose_2928
do_apply_2929:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2930
do_compose_2928:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2930:
    cmp x0, #4096
    b.hi do_compose_2931
do_apply_2932:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2933
do_compose_2931:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2933:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2934
do_apply_2935:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2936
do_compose_2934:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2936:
    cmp x0, #4096
    b.hi do_compose_2937
do_apply_2938:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2939
do_compose_2937:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2939:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_2940
do_apply_2941:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2942
do_compose_2940:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2942:
    str x0, [sp, #-16]!
    mov x0, #20
    cmp x0, #4096
    b.hi do_compose_2943
do_apply_2944:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2945
do_compose_2943:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2945:
    str x0, [sp, #-16]!
    adr x0, str_12
    cmp x0, #4096
    b.hi do_compose_2946
do_apply_2947:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2948
do_compose_2946:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2948:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_13
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2949
do_apply_2950:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2951
do_compose_2949:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2951:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_2952
do_apply_2953:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2954
do_compose_2952:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2954:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2955
do_apply_2956:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2957
do_compose_2955:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2957:
    cmp x0, #4096
    b.hi do_compose_2958
do_apply_2959:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2960
do_compose_2958:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2960:
    cmp x0, #4096
    b.hi do_compose_2961
do_apply_2962:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2963
do_compose_2961:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2963:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_2964
do_apply_2965:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2966
do_compose_2964:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2966:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2967
do_apply_2968:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2969
do_compose_2967:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2969:
    cmp x0, #4096
    b.hi do_compose_2970
do_apply_2971:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2972
do_compose_2970:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2972:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_2973
do_apply_2974:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2975
do_compose_2973:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2975:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2978
    adr x0, sign_id
    b cmp_end_2979
cmp_true_2978:
cmp_end_2979:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2976
    adr x0, sign_id
    b cond_end_2977
cond_false_2976:
    adr x0, sign_id
cond_end_2977:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_2980_2981
func_2980:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2985_2986
func_2985:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_2987_2988
func_2987:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2989_2990
func_2989:
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
after_func_2989_2990:
    // Closure for func_2989
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2989
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2987_2988:
    // Closure for func_2987
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2987
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_2991
do_apply_2992:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2993
do_compose_2991:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2993:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2994
do_apply_2995:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2996
do_compose_2994:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2996:
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
    b after_func_2997_2998
func_2997:
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
after_func_2997_2998:
    // Closure for func_2997
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2997
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2982
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2984
xor_true_2982:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2983
    adr x0, sign_id
    b xor_end_2984
xor_false_2983:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2980_2981:
    // Closure for func_2980
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2980
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3001
    adr x0, sign_id
    b cmp_end_3002
cmp_true_3001:
cmp_end_3002:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2999
    adr x0, sign_id
    b cond_end_3000
cond_false_2999:
    adr x0, sign_id
cond_end_3000:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_14
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_3003
do_apply_3004:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3005
do_compose_3003:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3005:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    str x0, [sp, #-16]!
    mov x0, #40
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3008
    adr x0, sign_id
    b cmp_end_3009
cmp_true_3008:
cmp_end_3009:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3006
    adr x0, sign_id
    b cond_end_3007
cond_false_3006:
    adr x0, sign_id
cond_end_3007:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_15
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3010_3011
func_3010:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3015_3016
func_3015:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3017_3018
func_3017:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3019_3020
func_3019:
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
after_func_3019_3020:
    // Closure for func_3019
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3019
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3017_3018:
    // Closure for func_3017
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3017
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3021
do_apply_3022:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3023
do_compose_3021:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3023:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3024
do_apply_3025:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3026
do_compose_3024:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3026:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3015_3016:
    // Closure for func_3015
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3015
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3027_3028
func_3027:
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
after_func_3027_3028:
    // Closure for func_3027
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3027
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3012
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3014
xor_true_3012:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3013
    adr x0, sign_id
    b xor_end_3014
xor_false_3013:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3010_3011:
    // Closure for func_3010
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3010
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3029_3030
func_3029:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3034_3035
func_3034:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3036_3037
func_3036:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3038_3039
func_3038:
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
after_func_3038_3039:
    // Closure for func_3038
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3038
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3036_3037:
    // Closure for func_3036
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3036
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3040
do_apply_3041:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3042
do_compose_3040:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3042:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3043
do_apply_3044:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3045
do_compose_3043:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3045:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3034_3035:
    // Closure for func_3034
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3034
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3046_3047
func_3046:
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
after_func_3046_3047:
    // Closure for func_3046
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3046
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3031
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3033
xor_true_3031:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3032
    adr x0, sign_id
    b xor_end_3033
xor_false_3032:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3029_3030:
    // Closure for func_3029
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3029
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3048_3049
func_3048:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3053_3054
func_3053:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3055_3056
func_3055:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3057_3058
func_3057:
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
after_func_3057_3058:
    // Closure for func_3057
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3057
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3055_3056:
    // Closure for func_3055
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3055
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3059
do_apply_3060:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3061
do_compose_3059:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3061:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3062
do_apply_3063:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3064
do_compose_3062:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3064:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3053_3054:
    // Closure for func_3053
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3053
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3065_3066
func_3065:
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
after_func_3065_3066:
    // Closure for func_3065
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3065
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3050
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3052
xor_true_3050:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3051
    adr x0, sign_id
    b xor_end_3052
xor_false_3051:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3048_3049:
    // Closure for func_3048
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3048
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_16
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3067_3068
func_3067:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3072_3073
func_3072:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3074_3075
func_3074:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3076_3077
func_3076:
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
after_func_3076_3077:
    // Closure for func_3076
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3076
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3074_3075:
    // Closure for func_3074
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3074
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3078
do_apply_3079:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3080
do_compose_3078:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3080:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3081
do_apply_3082:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3083
do_compose_3081:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3083:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3072_3073:
    // Closure for func_3072
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3072
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3084_3085
func_3084:
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
after_func_3084_3085:
    // Closure for func_3084
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3084
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3069
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3071
xor_true_3069:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3070
    adr x0, sign_id
    b xor_end_3071
xor_false_3070:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3067_3068:
    // Closure for func_3067
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3067
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_17
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_18
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3086_3087
func_3086:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3091_3092
func_3091:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3093_3094
func_3093:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3095_3096
func_3095:
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
after_func_3095_3096:
    // Closure for func_3095
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3095
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3093_3094:
    // Closure for func_3093
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3093
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3097
do_apply_3098:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3099
do_compose_3097:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3099:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3100
do_apply_3101:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3102
do_compose_3100:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3102:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3091_3092:
    // Closure for func_3091
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3091
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3103_3104
func_3103:
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
after_func_3103_3104:
    // Closure for func_3103
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3103
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3088
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3090
xor_true_3088:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3089
    adr x0, sign_id
    b xor_end_3090
xor_false_3089:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3086_3087:
    // Closure for func_3086
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3086
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3105
do_apply_3106:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3107
do_compose_3105:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3107:
    cmp x0, #4096
    b.hi do_compose_3108
do_apply_3109:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3110
do_compose_3108:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3110:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    cmp x0, #4096
    b.hi do_compose_3111
do_apply_3112:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3113
do_compose_3111:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3113:
    cmp x0, #4096
    b.hi do_compose_3114
do_apply_3115:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3116
do_compose_3114:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3116:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3117
do_apply_3118:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3119
do_compose_3117:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3119:
    cmp x0, #4096
    b.hi do_compose_3120
do_apply_3121:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3122
do_compose_3120:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3122:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3123
do_apply_3124:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3125
do_compose_3123:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3125:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3126
do_apply_3127:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3128
do_compose_3126:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3128:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3129
do_apply_3130:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3131
do_compose_3129:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3131:
    cmp x0, #4096
    b.hi do_compose_3132
do_apply_3133:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3134
do_compose_3132:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3134:
    cmp x0, #4096
    b.hi do_compose_3135
do_apply_3136:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3137
do_compose_3135:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3137:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    cmp x0, #4096
    b.hi do_compose_3138
do_apply_3139:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3140
do_compose_3138:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3140:
    cmp x0, #4096
    b.hi do_compose_3141
do_apply_3142:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3143
do_compose_3141:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3143:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3144
do_apply_3145:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3146
do_compose_3144:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3146:
    cmp x0, #4096
    b.hi do_compose_3147
do_apply_3148:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3149
do_compose_3147:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3149:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_null
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3150
do_apply_3151:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3152
do_compose_3150:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3152:
    cmp x0, #4096
    b.hi do_compose_3153
do_apply_3154:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3155
do_compose_3153:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3155:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, rest
    cmp x0, #4096
    b.hi do_compose_3156
do_apply_3157:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3158
do_compose_3156:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3158:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_3159
do_apply_3160:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3161
do_compose_3159:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3161:
    cmp x0, #4096
    b.hi do_compose_3162
do_apply_3163:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3164
do_compose_3162:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3164:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_3165
do_apply_3166:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3167
do_compose_3165:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3167:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_3168
do_apply_3169:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3170
do_compose_3168:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3170:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_19
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3171
do_apply_3172:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3173
do_compose_3171:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3173:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3174
do_apply_3175:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3176
do_compose_3174:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3176:
    cmp x0, #4096
    b.hi do_compose_3177
do_apply_3178:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3179
do_compose_3177:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3179:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_3180
do_apply_3181:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3182
do_compose_3180:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3182:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3183
do_apply_3184:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3185
do_compose_3183:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3185:
    cmp x0, #4096
    b.hi do_compose_3186
do_apply_3187:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3188
do_compose_3186:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3188:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_3189
do_apply_3190:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3191
do_compose_3189:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3191:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_20
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3192
do_apply_3193:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3194
do_compose_3192:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3194:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3195
do_apply_3196:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3197
do_compose_3195:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3197:
    cmp x0, #4096
    b.hi do_compose_3198
do_apply_3199:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3200
do_compose_3198:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3200:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tokens_next
    cmp x0, #4096
    b.hi do_compose_3201
do_apply_3202:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3203
do_compose_3201:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3203:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3204
do_apply_3205:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3206
do_compose_3204:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3206:
    cmp x0, #4096
    b.hi do_compose_3207
do_apply_3208:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3209
do_compose_3207:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3209:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_3210
do_apply_3211:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3212
do_compose_3210:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3212:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_3213
do_apply_3214:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3215
do_compose_3213:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3215:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_3216
do_apply_3217:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3218
do_compose_3216:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3218:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3219
    b after_func_3221_3222
func_3221:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3223_3224
func_3223:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3228_3229
func_3228:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3230_3231
func_3230:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3232_3233
func_3232:
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
after_func_3232_3233:
    // Closure for func_3232
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3232
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3230_3231:
    // Closure for func_3230
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3230
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3234
do_apply_3235:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3236
do_compose_3234:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3236:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3237
do_apply_3238:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3239
do_compose_3237:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3239:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3228_3229:
    // Closure for func_3228
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3228
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3240_3241
func_3240:
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
after_func_3240_3241:
    // Closure for func_3240
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3240
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3225
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3227
xor_true_3225:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3226
    adr x0, sign_id
    b xor_end_3227
xor_false_3226:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3223_3224:
    // Closure for func_3223
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3223
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3221_3222:
    // Closure for func_3221
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3221
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3220
cond_false_3219:
    adr x0, sign_id
cond_end_3220:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3242_3243
func_3242:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3247_3248
func_3247:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3249_3250
func_3249:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3251_3252
func_3251:
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
after_func_3251_3252:
    // Closure for func_3251
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3251
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_3253
do_apply_3254:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3255
do_compose_3253:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3255:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3256
do_apply_3257:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3258
do_compose_3256:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3258:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3247_3248:
    // Closure for func_3247
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3247
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3259_3260
func_3259:
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
after_func_3259_3260:
    // Closure for func_3259
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3259
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3244
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3246
xor_true_3244:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3245
    adr x0, sign_id
    b xor_end_3246
xor_false_3245:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3242_3243:
    // Closure for func_3242
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3242
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3261_3262
func_3261:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3266_3267
func_3266:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3268_3269
func_3268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3270_3271
func_3270:
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
after_func_3270_3271:
    // Closure for func_3270
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3270
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3268_3269:
    // Closure for func_3268
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3268
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3272
do_apply_3273:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3274
do_compose_3272:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3274:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3275
do_apply_3276:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3277
do_compose_3275:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3277:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3266_3267:
    // Closure for func_3266
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3266
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3278_3279
func_3278:
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
after_func_3278_3279:
    // Closure for func_3278
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3278
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3263
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3265
xor_true_3263:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3264
    adr x0, sign_id
    b xor_end_3265
xor_false_3264:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3261_3262:
    // Closure for func_3261
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3261
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_21
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3280_3281
func_3280:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3285_3286
func_3285:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3287_3288
func_3287:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3289_3290
func_3289:
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
after_func_3289_3290:
    // Closure for func_3289
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3289
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3287_3288:
    // Closure for func_3287
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3287
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3291
do_apply_3292:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3293
do_compose_3291:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3293:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3294
do_apply_3295:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3296
do_compose_3294:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3296:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3285_3286:
    // Closure for func_3285
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3285
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3297_3298
func_3297:
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
after_func_3297_3298:
    // Closure for func_3297
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3297
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3282
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3284
xor_true_3282:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3283
    adr x0, sign_id
    b xor_end_3284
xor_false_3283:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3280_3281:
    // Closure for func_3280
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3280
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_22
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3299_3300
func_3299:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3304_3305
func_3304:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3306_3307
func_3306:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3308_3309
func_3308:
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
after_func_3308_3309:
    // Closure for func_3308
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3308
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3306_3307:
    // Closure for func_3306
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3306
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3310
do_apply_3311:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3312
do_compose_3310:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3312:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3313
do_apply_3314:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3315
do_compose_3313:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3315:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3304_3305:
    // Closure for func_3304
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3304
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3316_3317
func_3316:
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
after_func_3316_3317:
    // Closure for func_3316
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3316
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3301
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3303
xor_true_3301:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3302
    adr x0, sign_id
    b xor_end_3303
xor_false_3302:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3299_3300:
    // Closure for func_3299
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3299
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_3318
do_apply_3319:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3320
do_compose_3318:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3320:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    cmp x0, #4096
    b.hi do_compose_3321
do_apply_3322:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3323
do_compose_3321:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3323:
    cmp x0, #4096
    b.hi do_compose_3324
do_apply_3325:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3326
do_compose_3324:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3326:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3327
do_apply_3328:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3329
do_compose_3327:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3329:
    cmp x0, #4096
    b.hi do_compose_3330
do_apply_3331:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3332
do_compose_3330:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3332:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, transform_section
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3333
do_apply_3334:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3335
do_compose_3333:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3335:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, rest
    cmp x0, #4096
    b.hi do_compose_3336
do_apply_3337:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3338
do_compose_3336:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3338:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_3339
do_apply_3340:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3341
do_compose_3339:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3341:
    cmp x0, #4096
    b.hi do_compose_3342
do_apply_3343:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3344
do_compose_3342:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3344:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_3345
do_apply_3346:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3347
do_compose_3345:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3347:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_3348
do_apply_3349:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3350
do_compose_3348:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3350:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_null
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3351
    b after_func_3355_3356
func_3355:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3357
    adr x0, sign_id
    b cmp_end_3358
cmp_true_3357:
cmp_end_3358:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3355_3356:
    // Closure for func_3355
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3355
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3353
    mov x0, #1
    b cond_end_3354
cond_false_3353:
    adr x0, sign_id
cond_end_3354:
    b cond_end_3352
cond_false_3351:
    adr x0, sign_id
cond_end_3352:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_node
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3359
    b after_func_3361_3362
func_3361:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3363
do_apply_3364:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3365
do_compose_3363:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3365:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_3366
do_apply_3367:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3368
do_compose_3366:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3368:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3369
do_apply_3370:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3371
do_compose_3369:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3371:
    cmp x0, #4096
    b.hi do_compose_3372
do_apply_3373:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3374
do_compose_3372:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3374:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3361_3362:
    // Closure for func_3361
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3361
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3360
cond_false_3359:
    adr x0, sign_id
cond_end_3360:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_num
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3375
    b after_func_3377_3378
func_3377:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3379
do_apply_3380:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3381
do_compose_3379:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3381:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3382
do_apply_3383:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3384
do_compose_3382:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3384:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3377_3378:
    // Closure for func_3377
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3377
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3376
cond_false_3375:
    adr x0, sign_id
cond_end_3376:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_id
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3385
    b after_func_3387_3388
func_3387:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3389
do_apply_3390:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3391
do_compose_3389:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3391:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3392
do_apply_3393:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3394
do_compose_3392:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3394:
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
    b cond_end_3386
cond_false_3385:
    adr x0, sign_id
cond_end_3386:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_op
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3395
    b after_func_3397_3398
func_3397:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3399
do_apply_3400:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3401
do_compose_3399:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3401:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3402
do_apply_3403:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3404
do_compose_3402:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3404:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3397_3398:
    // Closure for func_3397
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3397
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3396
cond_false_3395:
    adr x0, sign_id
cond_end_3396:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3405
    b after_func_3407_3408
func_3407:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3409
do_apply_3410:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3411
do_compose_3409:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3411:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3412
do_apply_3413:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3414
do_compose_3412:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3414:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3407_3408:
    // Closure for func_3407
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3407
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3406
cond_false_3405:
    adr x0, sign_id
cond_end_3406:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_infix
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3415
    b after_func_3417_3418
func_3417:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3419
do_apply_3420:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3421
do_compose_3419:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3421:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3422
do_apply_3423:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3424
do_compose_3422:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3424:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_3425
do_apply_3426:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3427
do_compose_3425:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3427:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_3428
do_apply_3429:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3430
do_compose_3428:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3430:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3431
do_apply_3432:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3433
do_compose_3431:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3433:
    cmp x0, #4096
    b.hi do_compose_3434
do_apply_3435:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3436
do_compose_3434:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3436:
    cmp x0, #4096
    b.hi do_compose_3437
do_apply_3438:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3439
do_compose_3437:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3439:
    cmp x0, #4096
    b.hi do_compose_3440
do_apply_3441:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3442
do_compose_3440:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3442:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3417_3418:
    // Closure for func_3417
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3417
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3416
cond_false_3415:
    adr x0, sign_id
cond_end_3416:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_lambda
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3443
    b after_func_3445_3446
func_3445:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3447_3448
func_3447:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_3449
do_apply_3450:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3451
do_compose_3449:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3451:
    str x0, [sp, #-16]!
    adr x0, body
    cmp x0, #4096
    b.hi do_compose_3452
do_apply_3453:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3454
do_compose_3452:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3454:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3447_3448:
    // Closure for func_3447
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3447
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3445_3446:
    // Closure for func_3445
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3445
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3444
cond_false_3443:
    adr x0, sign_id
cond_end_3444:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, transform_section
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3455
    b after_func_3457_3458
func_3457:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3459_3460
func_3459:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3464_3465
func_3464:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3468_3469:
    // Closure for func_3468
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_3470
do_apply_3471:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3472
do_compose_3470:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3472:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3473
do_apply_3474:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3475
do_compose_3473:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3475:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3464_3465:
    // Closure for func_3464
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3464
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3476_3477
func_3476:
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
after_func_3476_3477:
    // Closure for func_3476
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3476
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3461
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3463
xor_true_3461:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3462
    adr x0, sign_id
    b xor_end_3463
xor_false_3462:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3459_3460:
    // Closure for func_3459
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3459
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3457_3458:
    // Closure for func_3457
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3457
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3456
cond_false_3455:
    adr x0, sign_id
cond_end_3456:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3478_3479
func_3478:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3480_3481
func_3480:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3485_3486
func_3485:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3487_3488
func_3487:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3489_3490
func_3489:
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
after_func_3489_3490:
    // Closure for func_3489
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3489
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3487_3488:
    // Closure for func_3487
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3487
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3491
do_apply_3492:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3493
do_compose_3491:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3493:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3494
do_apply_3495:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3496
do_compose_3494:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3496:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3485_3486:
    // Closure for func_3485
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3485
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3497_3498
func_3497:
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
after_func_3497_3498:
    // Closure for func_3497
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3497
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3482
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3484
xor_true_3482:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3483
    adr x0, sign_id
    b xor_end_3484
xor_false_3483:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3480_3481:
    // Closure for func_3480
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3480
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3478_3479:
    // Closure for func_3478
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3478
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3501
    adr x0, sign_id
    b cmp_end_3502
cmp_true_3501:
cmp_end_3502:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3499
    adr x0, sign_id
    b cond_end_3500
cond_false_3499:
    adr x0, sign_id
cond_end_3500:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3503_3504
func_3503:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3508_3509
func_3508:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3510_3511
func_3510:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3512_3513
func_3512:
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
after_func_3512_3513:
    // Closure for func_3512
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3512
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3510_3511:
    // Closure for func_3510
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3510
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3514
do_apply_3515:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3516
do_compose_3514:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3516:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3517
do_apply_3518:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3519
do_compose_3517:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3519:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3508_3509:
    // Closure for func_3508
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3508
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3520_3521
func_3520:
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
after_func_3520_3521:
    // Closure for func_3520
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3520
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3505
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3507
xor_true_3505:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3506
    adr x0, sign_id
    b xor_end_3507
xor_false_3506:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3503_3504:
    // Closure for func_3503
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3503
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3522_3523
func_3522:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3527_3528
func_3527:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3529_3530
func_3529:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3531_3532
func_3531:
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
after_func_3531_3532:
    // Closure for func_3531
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3531
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3529_3530:
    // Closure for func_3529
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3529
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3533
do_apply_3534:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3535
do_compose_3533:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3535:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3536
do_apply_3537:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3538
do_compose_3536:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3538:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3527_3528:
    // Closure for func_3527
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3527
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3539_3540
func_3539:
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
after_func_3539_3540:
    // Closure for func_3539
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3539
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3524
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3526
xor_true_3524:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3525
    adr x0, sign_id
    b xor_end_3526
xor_false_3525:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3522_3523:
    // Closure for func_3522
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3522
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3543
    adr x0, sign_id
    b cmp_end_3544
cmp_true_3543:
cmp_end_3544:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3541
    adr x0, sign_id
    b cond_end_3542
cond_false_3541:
    adr x0, sign_id
cond_end_3542:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_23
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3545_3546
func_3545:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3550_3551
func_3550:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3552_3553
func_3552:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3554_3555
func_3554:
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
after_func_3554_3555:
    // Closure for func_3554
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3554
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3552_3553:
    // Closure for func_3552
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3552
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3556
do_apply_3557:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3558
do_compose_3556:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3558:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3559
do_apply_3560:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3561
do_compose_3559:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3561:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3550_3551:
    // Closure for func_3550
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3550
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3562_3563
func_3562:
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
after_func_3562_3563:
    // Closure for func_3562
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3562
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3547
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3549
xor_true_3547:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3548
    adr x0, sign_id
    b xor_end_3549
xor_false_3548:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3545_3546:
    // Closure for func_3545
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3545
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_lambda
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3564
do_apply_3565:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3566
do_compose_3564:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3566:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, p1
    cmp x0, #4096
    b.hi do_compose_3567
do_apply_3568:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3569
do_compose_3567:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3569:
    str x0, [sp, #-16]!
    adr x0, p2
    cmp x0, #4096
    b.hi do_compose_3570
do_apply_3571:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3572
do_compose_3570:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3572:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_3573
do_apply_3574:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3575
do_compose_3573:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3575:
    str x0, [sp, #-16]!
    adr x0, p1
    cmp x0, #4096
    b.hi do_compose_3576
do_apply_3577:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3578
do_compose_3576:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3578:
    str x0, [sp, #-16]!
    adr x0, p2
    cmp x0, #4096
    b.hi do_compose_3579
do_apply_3580:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3581
do_compose_3579:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3581:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e1
    cmp x0, #4096
    b.hi do_compose_3582
do_apply_3583:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3584
do_compose_3582:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3584:
    cmp x0, #4096
    b.hi do_compose_3585
do_apply_3586:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3587
do_compose_3585:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3587:
    cmp x0, #4096
    b.hi do_compose_3588
do_apply_3589:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3590
do_compose_3588:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3590:
    str x0, [sp, #-16]!
    adr x0, str_24
    cmp x0, #4096
    b.hi do_compose_3591
do_apply_3592:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3593
do_compose_3591:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3593:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3594
do_apply_3595:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3596
do_compose_3594:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3596:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3597
do_apply_3598:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3599
do_compose_3597:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3599:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3600
do_apply_3601:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3602
do_compose_3600:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3602:
    cmp x0, #4096
    b.hi do_compose_3603
do_apply_3604:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3605
do_compose_3603:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3605:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e1
    cmp x0, #4096
    b.hi do_compose_3606
do_apply_3607:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3608
do_compose_3606:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3608:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3609
do_apply_3610:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3611
do_compose_3609:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3611:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3614
    adr x0, sign_id
    b cmp_end_3615
cmp_true_3614:
cmp_end_3615:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3612
    adr x0, sign_id
    b cond_end_3613
cond_false_3612:
    adr x0, sign_id
cond_end_3613:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3616_3617
func_3616:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3621_3622
func_3621:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3623_3624
func_3623:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3625_3626
func_3625:
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
after_func_3625_3626:
    // Closure for func_3625
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3625
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3623_3624:
    // Closure for func_3623
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3623
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3627
do_apply_3628:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3629
do_compose_3627:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3629:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3630
do_apply_3631:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3632
do_compose_3630:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3632:
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
    b after_func_3633_3634
func_3633:
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
after_func_3633_3634:
    // Closure for func_3633
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3633
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3618
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3620
xor_true_3618:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3619
    adr x0, sign_id
    b xor_end_3620
xor_false_3619:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3616_3617:
    // Closure for func_3616
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3616
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3635_3636
func_3635:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3640_3641
func_3640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3642_3643
func_3642:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3644_3645
func_3644:
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
after_func_3644_3645:
    // Closure for func_3644
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3644
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3642_3643:
    // Closure for func_3642
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3642
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3646
do_apply_3647:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3648
do_compose_3646:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3648:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3649
do_apply_3650:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3651
do_compose_3649:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3651:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3640_3641:
    // Closure for func_3640
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3640
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3652_3653
func_3652:
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
after_func_3652_3653:
    // Closure for func_3652
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3652
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3637
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3639
xor_true_3637:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3638
    adr x0, sign_id
    b xor_end_3639
xor_false_3638:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3635_3636:
    // Closure for func_3635
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3635
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3654_3655
func_3654:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3659_3660
func_3659:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3661_3662
func_3661:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3663_3664
func_3663:
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
after_func_3663_3664:
    // Closure for func_3663
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3663
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3661_3662:
    // Closure for func_3661
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3661
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3665
do_apply_3666:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3667
do_compose_3665:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3667:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3668
do_apply_3669:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3670
do_compose_3668:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3670:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3659_3660:
    // Closure for func_3659
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3659
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3671_3672
func_3671:
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
after_func_3671_3672:
    // Closure for func_3671
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3671
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3656
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3658
xor_true_3656:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3657
    adr x0, sign_id
    b xor_end_3658
xor_false_3657:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3654_3655:
    // Closure for func_3654
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3654
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3673_3674
func_3673:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3678_3679
func_3678:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3680_3681
func_3680:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3682_3683
func_3682:
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
after_func_3682_3683:
    // Closure for func_3682
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3682
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3680_3681:
    // Closure for func_3680
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3680
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3684
do_apply_3685:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3686
do_compose_3684:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3686:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3687
do_apply_3688:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3689
do_compose_3687:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3689:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3678_3679:
    // Closure for func_3678
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3678
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3690_3691
func_3690:
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
after_func_3690_3691:
    // Closure for func_3690
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3690
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3675
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3677
xor_true_3675:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3676
    adr x0, sign_id
    b xor_end_3677
xor_false_3676:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3673_3674:
    // Closure for func_3673
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3673
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t1
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3694
    adr x0, sign_id
    b cmp_end_3695
cmp_true_3694:
cmp_end_3695:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3692
    adr x0, sign_id
    b cond_end_3693
cond_false_3692:
    adr x0, sign_id
cond_end_3693:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_25
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3696_3697
func_3696:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3701_3702
func_3701:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3703_3704
func_3703:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3705_3706
func_3705:
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
after_func_3705_3706:
    // Closure for func_3705
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3705
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3703_3704:
    // Closure for func_3703
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3703
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3707
do_apply_3708:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3709
do_compose_3707:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3709:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3710
do_apply_3711:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3712
do_compose_3710:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3712:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3701_3702:
    // Closure for func_3701
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3701
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3713_3714
func_3713:
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
after_func_3713_3714:
    // Closure for func_3713
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3713
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3698
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3700
xor_true_3698:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3699
    adr x0, sign_id
    b xor_end_3700
xor_false_3699:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3696_3697:
    // Closure for func_3696
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3696
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, p1
    cmp x0, #4096
    b.hi do_compose_3715
do_apply_3716:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3717
do_compose_3715:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3717:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_3718
do_apply_3719:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3720
do_compose_3718:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3720:
    str x0, [sp, #-16]!
    adr x0, p1
    cmp x0, #4096
    b.hi do_compose_3721
do_apply_3722:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3723
do_compose_3721:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3723:
    str x0, [sp, #-16]!
    adr x0, e2
    cmp x0, #4096
    b.hi do_compose_3724
do_apply_3725:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3726
do_compose_3724:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3726:
    cmp x0, #4096
    b.hi do_compose_3727
do_apply_3728:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3729
do_compose_3727:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3729:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e1
    cmp x0, #4096
    b.hi do_compose_3730
do_apply_3731:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3732
do_compose_3730:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3732:
    cmp x0, #4096
    b.hi do_compose_3733
do_apply_3734:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3735
do_compose_3733:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3735:
    cmp x0, #4096
    b.hi do_compose_3736
do_apply_3737:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3738
do_compose_3736:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3738:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t2
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3741
    adr x0, sign_id
    b cmp_end_3742
cmp_true_3741:
cmp_end_3742:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3739
    adr x0, sign_id
    b cond_end_3740
cond_false_3739:
    adr x0, sign_id
cond_end_3740:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_26
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3743_3744
func_3743:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3748_3749
func_3748:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3750_3751
func_3750:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3752_3753
func_3752:
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
after_func_3752_3753:
    // Closure for func_3752
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3752
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3750_3751:
    // Closure for func_3750
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3750
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3754
do_apply_3755:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3756
do_compose_3754:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3756:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3757
do_apply_3758:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3759
do_compose_3757:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3759:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3748_3749:
    // Closure for func_3748
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3748
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3760_3761
func_3760:
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
after_func_3760_3761:
    // Closure for func_3760
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3760
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3745
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3747
xor_true_3745:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3746
    adr x0, sign_id
    b xor_end_3747
xor_false_3746:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3743_3744:
    // Closure for func_3743
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3743
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, p1
    cmp x0, #4096
    b.hi do_compose_3762
do_apply_3763:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3764
do_compose_3762:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3764:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_3765
do_apply_3766:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3767
do_compose_3765:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3767:
    str x0, [sp, #-16]!
    adr x0, e1
    cmp x0, #4096
    b.hi do_compose_3768
do_apply_3769:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3770
do_compose_3768:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3770:
    str x0, [sp, #-16]!
    adr x0, p1
    cmp x0, #4096
    b.hi do_compose_3771
do_apply_3772:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3773
do_compose_3771:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3773:
    cmp x0, #4096
    b.hi do_compose_3774
do_apply_3775:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3776
do_compose_3774:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3776:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e2
    cmp x0, #4096
    b.hi do_compose_3777
do_apply_3778:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3779
do_compose_3777:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3779:
    cmp x0, #4096
    b.hi do_compose_3780
do_apply_3781:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3782
do_compose_3780:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3782:
    cmp x0, #4096
    b.hi do_compose_3783
do_apply_3784:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3785
do_compose_3783:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3785:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3786
do_apply_3787:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3788
do_compose_3786:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3788:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3789
do_apply_3790:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3791
do_compose_3789:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3791:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3792
do_apply_3793:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3794
do_compose_3792:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3794:
    cmp x0, #4096
    b.hi do_compose_3795
do_apply_3796:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3797
do_compose_3795:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3797:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e2
    cmp x0, #4096
    b.hi do_compose_3798
do_apply_3799:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3800
do_compose_3798:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3800:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, e1
    cmp x0, #4096
    b.hi do_compose_3801
do_apply_3802:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3803
do_compose_3801:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3803:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3804
do_apply_3805:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3806
do_compose_3804:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3806:
    cmp x0, #4096
    b.hi do_compose_3807
do_apply_3808:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3809
do_compose_3807:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3809:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3810
do_apply_3811:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3812
do_compose_3810:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3812:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3813
do_apply_3814:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3815
do_compose_3813:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3815:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3816
do_apply_3817:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3818
do_compose_3816:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3818:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3819
do_apply_3820:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3821
do_compose_3819:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3821:
    cmp x0, #4096
    b.hi do_compose_3822
do_apply_3823:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3824
do_compose_3822:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3824:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_id
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3825
do_apply_3826:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3827
do_compose_3825:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3827:
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_3828
do_apply_3829:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3830
do_compose_3828:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3830:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3831
do_apply_3832:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3833
do_compose_3831:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3833:
    str x0, [sp, #-16]!
    adr x0, make_id
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3834
do_apply_3835:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3836
do_compose_3834:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3836:
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_3837
do_apply_3838:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3839
do_compose_3837:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3839:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_3840
do_apply_3841:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3842
do_compose_3840:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3842:
    cmp x0, #4096
    b.hi do_compose_3843
do_apply_3844:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3845
do_compose_3843:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3845:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, length
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_3846
do_apply_3847:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3848
do_compose_3846:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3848:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Self
    str x0, [sp, #-16]!
    adr x0, Hosted
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_3849
do_apply_3850:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3851
do_compose_3849:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3851:
    str x0, [sp, #-16]!
    adr x0, Compiler
    cmp x0, #4096
    b.hi do_compose_3852
do_apply_3853:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3854
do_compose_3852:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3854:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ARM64
    str x0, [sp, #-16]!
    adr x0, Assembly
    cmp x0, #4096
    b.hi do_compose_3855
do_apply_3856:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3857
do_compose_3855:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3857:
    adr x1, Target
    str x0, [x1]
    adr x0, sign_id
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
    adr x0, get_lbl_cnt
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3858
    b after_func_3860_3861
func_3860:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3860_3861:
    // Closure for func_3860
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3860
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3859
cond_false_3858:
    adr x0, sign_id
cond_end_3859:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_strs
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3862
    b after_func_3864_3865
func_3864:
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
after_func_3864_3865:
    // Closure for func_3864
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3864
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3863
cond_false_3862:
    adr x0, sign_id
cond_end_3863:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_env
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3866
    b after_func_3868_3869
func_3868:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3868_3869:
    // Closure for func_3868
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3868
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3867
cond_false_3866:
    adr x0, sign_id
cond_end_3867:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, mk_ctx
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3870
    b after_func_3872_3873
func_3872:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3874
do_apply_3875:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3876
do_compose_3874:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3876:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, strs
    cmp x0, #4096
    b.hi do_compose_3877
do_apply_3878:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3879
do_compose_3877:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3879:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, env
    cmp x0, #4096
    b.hi do_compose_3880
do_apply_3881:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3882
do_compose_3880:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3882:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_3883
do_apply_3884:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3885
do_compose_3883:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3885:
    cmp x0, #4096
    b.hi do_compose_3886
do_apply_3887:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3888
do_compose_3886:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3888:
    cmp x0, #4096
    b.hi do_compose_3889
do_apply_3890:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3891
do_compose_3889:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3891:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3872_3873:
    // Closure for func_3872
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3872
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3871
cond_false_3870:
    adr x0, sign_id
cond_end_3871:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, update_ctx_lbl
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3892
    b after_func_3894_3895
func_3894:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, mk_ctx
    str x0, [sp, #-16]!
    adr x0, new_lbl
    cmp x0, #4096
    b.hi do_compose_3896
do_apply_3897:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3898
do_compose_3896:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3898:
    str x0, [sp, #-16]!
    adr x0, get_strs
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3899
do_apply_3900:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3901
do_compose_3899:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3901:
    cmp x0, #4096
    b.hi do_compose_3902
do_apply_3903:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3904
do_compose_3902:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3904:
    str x0, [sp, #-16]!
    adr x0, get_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3905
do_apply_3906:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3907
do_compose_3905:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3907:
    cmp x0, #4096
    b.hi do_compose_3908
do_apply_3909:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3910
do_compose_3908:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3910:
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
    b cond_end_3893
cond_false_3892:
    adr x0, sign_id
cond_end_3893:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, update_ctx_strs
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3911
    b after_func_3913_3914
func_3913:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, mk_ctx
    str x0, [sp, #-16]!
    adr x0, get_lbl_cnt
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3915
do_apply_3916:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3917
do_compose_3915:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3917:
    cmp x0, #4096
    b.hi do_compose_3918
do_apply_3919:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3920
do_compose_3918:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3920:
    str x0, [sp, #-16]!
    adr x0, new_strs
    cmp x0, #4096
    b.hi do_compose_3921
do_apply_3922:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3923
do_compose_3921:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3923:
    str x0, [sp, #-16]!
    adr x0, get_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3924
do_apply_3925:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3926
do_compose_3924:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3926:
    cmp x0, #4096
    b.hi do_compose_3927
do_apply_3928:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3929
do_compose_3927:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3929:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3913_3914:
    // Closure for func_3913
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3913
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3912
cond_false_3911:
    adr x0, sign_id
cond_end_3912:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, update_ctx_env
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3930
    b after_func_3932_3933
func_3932:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, mk_ctx
    str x0, [sp, #-16]!
    adr x0, get_lbl_cnt
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3934
do_apply_3935:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3936
do_compose_3934:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3936:
    cmp x0, #4096
    b.hi do_compose_3937
do_apply_3938:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3939
do_compose_3937:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3939:
    str x0, [sp, #-16]!
    adr x0, get_strs
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3940
do_apply_3941:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3942
do_compose_3940:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3942:
    cmp x0, #4096
    b.hi do_compose_3943
do_apply_3944:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3945
do_compose_3943:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3945:
    str x0, [sp, #-16]!
    adr x0, new_env
    cmp x0, #4096
    b.hi do_compose_3946
do_apply_3947:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3948
do_compose_3946:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3948:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3932_3933:
    // Closure for func_3932
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3932
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3931
cond_false_3930:
    adr x0, sign_id
cond_end_3931:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, add_string
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3949
    b after_func_3951_3952
func_3951:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3953_3954
func_3953:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3958_3959
func_3958:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3960_3961
func_3960:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3962_3963
func_3962:
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
after_func_3962_3963:
    // Closure for func_3962
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3962
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3960_3961:
    // Closure for func_3960
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3960
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3964
do_apply_3965:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3966
do_compose_3964:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3966:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3967
do_apply_3968:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3969
do_compose_3967:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3969:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3958_3959:
    // Closure for func_3958
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3958
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3970_3971
func_3970:
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
after_func_3970_3971:
    // Closure for func_3970
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3970
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3955
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3957
xor_true_3955:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3956
    adr x0, sign_id
    b xor_end_3957
xor_false_3956:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3953_3954:
    // Closure for func_3953
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3953
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3951_3952:
    // Closure for func_3951
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3951
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3950
cond_false_3949:
    adr x0, sign_id
cond_end_3950:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_27
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_28
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3972_3973
func_3972:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3977_3978
func_3977:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3979_3980
func_3979:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3981_3982
func_3981:
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
after_func_3981_3982:
    // Closure for func_3981
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3981
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3979_3980:
    // Closure for func_3979
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3979
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_3983
do_apply_3984:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3985
do_compose_3983:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3985:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_3986
do_apply_3987:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3988
do_compose_3986:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3988:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3977_3978:
    // Closure for func_3977
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3977
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_3989_3990
func_3989:
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
after_func_3989_3990:
    // Closure for func_3989
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3989
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3974
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3976
xor_true_3974:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3975
    adr x0, sign_id
    b xor_end_3976
xor_false_3975:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3972_3973:
    // Closure for func_3972
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3972
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_3991_3992
func_3991:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3996_3997
func_3996:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_3998_3999
func_3998:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4000_4001
func_4000:
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
after_func_4000_4001:
    // Closure for func_4000
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4000
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3998_3999:
    // Closure for func_3998
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3998
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4002
do_apply_4003:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4004
do_compose_4002:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4004:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4005
do_apply_4006:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4007
do_compose_4005:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4007:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3996_3997:
    // Closure for func_3996
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3996
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-48]
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_3993
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_3995
xor_true_3993:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_3994
    adr x0, sign_id
    b xor_end_3995
xor_false_3994:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3991_3992:
    // Closure for func_3991
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3991
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4010_4011
func_4010:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4015_4016
func_4015:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4017_4018
func_4017:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4019_4020
func_4019:
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
after_func_4019_4020:
    // Closure for func_4019
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4019
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4017_4018:
    // Closure for func_4017
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4017
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4021
do_apply_4022:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4023
do_compose_4021:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4023:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4024
do_apply_4025:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4026
do_compose_4024:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4026:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4015_4016:
    // Closure for func_4015
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4015
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4027_4028
func_4027:
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
after_func_4027_4028:
    // Closure for func_4027
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4027
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4012
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4014
xor_true_4012:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4013
    adr x0, sign_id
    b xor_end_4014
xor_false_4013:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4010_4011:
    // Closure for func_4010
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4010
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lbl
    cmp x0, #4096
    b.hi do_compose_4029
do_apply_4030:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4031
do_compose_4029:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4031:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str
    cmp x0, #4096
    b.hi do_compose_4032
do_apply_4033:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4034
do_compose_4032:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4034:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4035
do_apply_4036:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4037
do_compose_4035:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4037:
    cmp x0, #4096
    b.hi do_compose_4038
do_apply_4039:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4040
do_compose_4038:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4040:
    cmp x0, #4096
    b.hi do_compose_4041
do_apply_4042:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4043
do_compose_4041:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4043:
    str x0, [sp, #-16]!
    adr x0, curr_strs
    cmp x0, #4096
    b.hi do_compose_4044
do_apply_4045:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4046
do_compose_4044:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4046:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, mk_ctx
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4047
do_apply_4048:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4049
do_compose_4047:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4049:
    str x0, [sp, #-16]!
    adr x0, new_node
    cmp x0, #4096
    b.hi do_compose_4050
do_apply_4051:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4052
do_compose_4050:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4052:
    str x0, [sp, #-16]!
    adr x0, get_env
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4053
do_apply_4054:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4055
do_compose_4053:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4055:
    cmp x0, #4096
    b.hi do_compose_4056
do_apply_4057:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4058
do_compose_4056:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4058:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_label
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4059
do_apply_4060:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4061
do_compose_4059:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4061:
    str x0, [sp, #-16]!
    adr x0, str_
    cmp x0, #4096
    b.hi do_compose_4062
do_apply_4063:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4064
do_compose_4062:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4064:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4065
do_apply_4066:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4067
do_compose_4065:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4067:
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4068
do_apply_4069:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4070
do_compose_4068:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4070:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_lbl_cnt
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4071
do_apply_4072:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4073
do_compose_4071:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4073:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_strs
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4074
do_apply_4075:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4076
do_compose_4074:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4076:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_label
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4077
    b after_func_4079_4080
func_4079:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4081
do_apply_4082:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4083
do_compose_4081:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4083:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4084
do_apply_4085:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4086
do_compose_4084:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4086:
    cmp x0, #4096
    b.hi do_compose_4087
do_apply_4088:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4089
do_compose_4087:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4089:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4079_4080:
    // Closure for func_4079
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4079
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4078
cond_false_4077:
    adr x0, sign_id
cond_end_4078:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4090
    b after_func_4092_4093
func_4092:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4094
do_apply_4095:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4096
do_compose_4094:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4096:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4097
do_apply_4098:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4099
do_compose_4097:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4099:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4092_4093:
    // Closure for func_4092
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4092
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4091
cond_false_4090:
    adr x0, sign_id
cond_end_4091:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit_seq
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4100
    b after_func_4102_4103
func_4102:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4102_4103:
    // Closure for func_4102
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4102
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4101
cond_false_4100:
    adr x0, sign_id
cond_end_4101:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_len
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4104
    b after_func_4106_4107
func_4106:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4108_4109
func_4108:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4113_4114
func_4113:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4115_4116
func_4115:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4117_4118
func_4117:
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
    adr x1, func_4115
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4119
do_apply_4120:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4121
do_compose_4119:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4121:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4122
do_apply_4123:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4124
do_compose_4122:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4124:
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
    str x0, [sp, #-16]!
    b after_func_4125_4126
func_4125:
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
after_func_4125_4126:
    // Closure for func_4125
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4125
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4110
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4112
xor_true_4110:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4111
    adr x0, sign_id
    b xor_end_4112
xor_false_4111:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4108_4109:
    // Closure for func_4108
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4108
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4106_4107:
    // Closure for func_4106
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4106
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4105
cond_false_4104:
    adr x0, sign_id
cond_end_4105:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4129
    adr x0, sign_id
    b cmp_end_4130
cmp_true_4129:
cmp_end_4130:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4127
    mov x0, #0
    b cond_end_4128
cond_false_4127:
    adr x0, sign_id
cond_end_4128:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, str_len
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, str
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4131
do_apply_4132:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4133
do_compose_4131:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4133:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4134_4135
func_4134:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4139_4140
func_4139:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4141_4142
func_4141:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4141_4142:
    // Closure for func_4141
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4141
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4143
do_apply_4144:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4145
do_compose_4143:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4145:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4146
do_apply_4147:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4148
do_compose_4146:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4148:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4139_4140:
    // Closure for func_4139
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4139
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str
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
    b.ne xor_true_4136
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4138
xor_true_4136:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4137
    adr x0, sign_id
    b xor_end_4138
xor_false_4137:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4134_4135:
    // Closure for func_4134
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4134
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_concat
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4149
    b after_func_4151_4152
func_4151:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4153_4154
func_4153:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4158_4159
func_4158:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4160_4161
func_4160:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4162_4163
func_4162:
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
after_func_4162_4163:
    // Closure for func_4162
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4162
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4160_4161:
    // Closure for func_4160
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4160
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4164
do_apply_4165:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4166
do_compose_4164:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4166:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4167
do_apply_4168:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4169
do_compose_4167:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4169:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4158_4159:
    // Closure for func_4158
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4158
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4170_4171
func_4170:
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
after_func_4170_4171:
    // Closure for func_4170
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4170
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4155
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4157
xor_true_4155:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4156
    adr x0, sign_id
    b xor_end_4157
xor_false_4156:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4153_4154:
    // Closure for func_4153
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4153
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4151_4152:
    // Closure for func_4151
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4151
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4150
cond_false_4149:
    adr x0, sign_id
cond_end_4150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4172_4173
func_4172:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4177_4178
func_4177:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4179_4180
func_4179:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4181_4182
func_4181:
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
after_func_4181_4182:
    // Closure for func_4181
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4181
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4179_4180:
    // Closure for func_4179
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4179
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4183
do_apply_4184:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4185
do_compose_4183:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4185:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4186
do_apply_4187:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4188
do_compose_4186:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4188:
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
    str x0, [sp, #-16]!
    b after_func_4189_4190
func_4189:
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
after_func_4189_4190:
    // Closure for func_4189
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4189
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4174
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4176
xor_true_4174:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4175
    adr x0, sign_id
    b xor_end_4176
xor_false_4175:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4172_4173:
    // Closure for func_4172
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4172
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4191_4192
func_4191:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4196_4197
func_4196:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4200_4201:
    // Closure for func_4200
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_4202
do_apply_4203:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4204
do_compose_4202:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4204:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4205
do_apply_4206:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4207
do_compose_4205:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4207:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4196_4197:
    // Closure for func_4196
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4196
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4208_4209
func_4208:
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
after_func_4208_4209:
    // Closure for func_4208
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4208
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4193
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4195
xor_true_4193:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4194
    adr x0, sign_id
    b xor_end_4195
xor_false_4194:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4191_4192:
    // Closure for func_4191
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4191
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _str_cpy
    str x0, [sp, #-16]!
    adr x0, s1
    cmp x0, #4096
    b.hi do_compose_4210
do_apply_4211:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4212
do_compose_4210:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4212:
    str x0, [sp, #-16]!
    adr x0, new_str
    cmp x0, #4096
    b.hi do_compose_4213
do_apply_4214:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4215
do_compose_4213:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4215:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _str_cpy
    str x0, [sp, #-16]!
    adr x0, s2
    cmp x0, #4096
    b.hi do_compose_4216
do_apply_4217:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4218
do_compose_4216:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4218:
    str x0, [sp, #-16]!
    adr x0, new_str
    str x0, [sp, #-16]!
    adr x0, len1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4219
do_apply_4220:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4221
do_compose_4219:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4221:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, new_str
    str x0, [sp, #-16]!
    adr x0, len1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, len2
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, str_29
    cmp x0, #4096
    b.hi do_compose_4222
do_apply_4223:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4224
do_compose_4222:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4224:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, new_str
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    cmp x0, #4096
    b.hi do_compose_4225
do_apply_4226:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4227
do_compose_4225:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4227:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_len
    str x0, [sp, #-16]!
    adr x0, s2
    cmp x0, #4096
    b.hi do_compose_4228
do_apply_4229:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4230
do_compose_4228:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4230:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_len
    str x0, [sp, #-16]!
    adr x0, s1
    cmp x0, #4096
    b.hi do_compose_4231
do_apply_4232:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4233
do_compose_4231:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4233:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _str_cpy
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4234
    b after_func_4236_4237
func_4236:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4238_4239
func_4238:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4243_4244
func_4243:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4245_4246
func_4245:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4247_4248
func_4247:
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
after_func_4247_4248:
    // Closure for func_4247
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4247
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4245_4246:
    // Closure for func_4245
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4245
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4249
do_apply_4250:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4251
do_compose_4249:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4251:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4252
do_apply_4253:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4254
do_compose_4252:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4254:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4243_4244:
    // Closure for func_4243
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4243
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-48]
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4240
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4242
xor_true_4240:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4241
    adr x0, sign_id
    b xor_end_4242
xor_false_4241:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4238_4239:
    // Closure for func_4238
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4238
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4236_4237:
    // Closure for func_4236
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4236
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4235
cond_false_4234:
    adr x0, sign_id
cond_end_4235:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4259
    adr x0, sign_id
    b cmp_end_4260
cmp_true_4259:
cmp_end_4260:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4257
    adr x0, dst
    b cond_end_4258
cond_false_4257:
    adr x0, sign_id
cond_end_4258:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, dst
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _str_cpy
    str x0, [sp, #-16]!
    adr x0, src
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4261
do_apply_4262:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4263
do_compose_4261:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4263:
    str x0, [sp, #-16]!
    adr x0, dst
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4264
do_apply_4265:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4266
do_compose_4264:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4266:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4267_4268
func_4267:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4272_4273
func_4272:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4274_4275
func_4274:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, src
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4274_4275:
    // Closure for func_4274
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4274
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4276
do_apply_4277:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4278
do_compose_4276:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4278:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4279
do_apply_4280:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4281
do_compose_4279:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4281:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4272_4273:
    // Closure for func_4272
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4272
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, src
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
    b.ne xor_true_4269
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4271
xor_true_4269:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4270
    adr x0, sign_id
    b xor_end_4271
xor_false_4270:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4267_4268:
    // Closure for func_4267
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4267
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, int_to_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4282
    b after_func_4286_4287
func_4286:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4288
    adr x0, sign_id
    b cmp_end_4289
cmp_true_4288:
cmp_end_4289:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4286_4287:
    // Closure for func_4286
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4286
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4284
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4290
do_apply_4291:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4292
do_compose_4290:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4292:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4293
do_apply_4294:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4295
do_compose_4293:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4295:
    b cond_end_4285
cond_false_4284:
    adr x0, sign_id
cond_end_4285:
    b cond_end_4283
cond_false_4282:
    adr x0, sign_id
cond_end_4283:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4296_4297
func_4296:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4301_4302
func_4301:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4303_4304
func_4303:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4305_4306
func_4305:
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
after_func_4305_4306:
    // Closure for func_4305
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4305
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4303_4304:
    // Closure for func_4303
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4303
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4307
do_apply_4308:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4309
do_compose_4307:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4309:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4310
do_apply_4311:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4312
do_compose_4310:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4312:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4301_4302:
    // Closure for func_4301
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4301
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4313_4314
func_4313:
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
after_func_4313_4314:
    // Closure for func_4313
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4313
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4298
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4300
xor_true_4298:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4299
    adr x0, sign_id
    b xor_end_4300
xor_false_4299:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4296_4297:
    // Closure for func_4296
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4296
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4315_4316
func_4315:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4320_4321
func_4320:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4322_4323
func_4322:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4324_4325
func_4324:
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
after_func_4324_4325:
    // Closure for func_4324
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4324
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4322_4323:
    // Closure for func_4322
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4322
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4326
do_apply_4327:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4328
do_compose_4326:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4328:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4329
do_apply_4330:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4331
do_compose_4329:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4331:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4320_4321:
    // Closure for func_4320
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4320
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4332_4333
func_4332:
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
after_func_4332_4333:
    // Closure for func_4332
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4332
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4317
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4319
xor_true_4317:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4318
    adr x0, sign_id
    b xor_end_4319
xor_false_4318:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4315_4316:
    // Closure for func_4315
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4315
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _int_to_str_rec
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_4334
do_apply_4335:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4336
do_compose_4334:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4336:
    str x0, [sp, #-16]!
    adr x0, str
    str x0, [sp, #-16]!
    adr x0, len
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4337
do_apply_4338:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4339
do_compose_4337:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4339:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne blk_end_0
    adr x0, str
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4340
do_apply_4341:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4342
do_compose_4340:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4342:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _num_digits
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_4343
do_apply_4344:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4345
do_compose_4343:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4345:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _num_digits
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4346
    b after_func_4350_4351
func_4350:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_4352
    adr x0, sign_id
    b cmp_end_4353
cmp_true_4352:
cmp_end_4353:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4350_4351:
    // Closure for func_4350
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4350
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4348
    mov x0, #1
    b cond_end_4349
cond_false_4348:
    adr x0, sign_id
cond_end_4349:
    b cond_end_4347
cond_false_4346:
    adr x0, sign_id
cond_end_4347:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, _num_digits
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4354
do_apply_4355:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4356
do_compose_4354:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4356:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _int_to_str_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4357
    b after_func_4359_4360
func_4359:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, ptr
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4359_4360:
    // Closure for func_4359
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4359
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #48
    str x0, [sp, #-16]!
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_4358
cond_false_4357:
    adr x0, sign_id
cond_end_4358:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #10
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_4363
    adr x0, sign_id
    b cmp_end_4364
cmp_true_4363:
cmp_end_4364:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4361
    mov x0, #0
    b cond_end_4362
cond_false_4361:
    adr x0, sign_id
cond_end_4362:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _int_to_str_rec
    str x0, [sp, #-16]!
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4365
do_apply_4366:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4367
do_compose_4365:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4367:
    str x0, [sp, #-16]!
    adr x0, ptr
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_4368
do_apply_4369:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4370
do_compose_4368:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4370:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, lookup_id
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4371
    b after_func_4375_4376
func_4375:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4377
    adr x0, sign_id
    b cmp_end_4378
cmp_true_4377:
cmp_end_4378:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4375_4376:
    // Closure for func_4375
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4375
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4373
    mov x0, #0
    b cond_end_4374
cond_false_4373:
    adr x0, sign_id
cond_end_4374:
    b cond_end_4372
cond_false_4371:
    adr x0, sign_id
cond_end_4372:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4379_4380
func_4379:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4384_4385
func_4384:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4386_4387
func_4386:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4388_4389
func_4388:
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
after_func_4388_4389:
    // Closure for func_4388
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4388
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4386_4387:
    // Closure for func_4386
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4386
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4390
do_apply_4391:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4392
do_compose_4390:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4392:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4393
do_apply_4394:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4395
do_compose_4393:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4395:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4384_4385:
    // Closure for func_4384
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4384
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4396_4397
func_4396:
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
after_func_4396_4397:
    // Closure for func_4396
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4396
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4381
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4383
xor_true_4381:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4382
    adr x0, sign_id
    b xor_end_4383
xor_false_4382:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4379_4380:
    // Closure for func_4379
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4379
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4398_4399
func_4398:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4403_4404
func_4403:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4405_4406
func_4405:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4407_4408
func_4407:
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
after_func_4407_4408:
    // Closure for func_4407
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4407
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4405_4406:
    // Closure for func_4405
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4405
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4409
do_apply_4410:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4411
do_compose_4409:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4411:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4412
do_apply_4413:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4414
do_compose_4412:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4414:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4403_4404:
    // Closure for func_4403
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4403
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4415_4416
func_4415:
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
after_func_4415_4416:
    // Closure for func_4415
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4415
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4400
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4402
xor_true_4400:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4401
    adr x0, sign_id
    b xor_end_4402
xor_false_4401:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4398_4399:
    // Closure for func_4398
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4398
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, name
    cmp x0, #4096
    b.hi do_compose_4419
do_apply_4420:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4421
do_compose_4419:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4421:
    str x0, [sp, #-16]!
    adr x0, id
    cmp x0, #4096
    b.hi do_compose_4422
do_apply_4423:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4424
do_compose_4422:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4424:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4417
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, entry
    cmp x0, #4096
    b.hi do_compose_4425
do_apply_4426:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4427
do_compose_4425:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4427:
    b cond_end_4418
cond_false_4417:
    adr x0, sign_id
cond_end_4418:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, lookup_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, env
    cmp x0, #4096
    b.hi do_compose_4428
do_apply_4429:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4430
do_compose_4428:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4430:
    cmp x0, #4096
    b.hi do_compose_4431
do_apply_4432:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4433
do_compose_4431:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4433:
    str x0, [sp, #-16]!
    adr x0, id
    cmp x0, #4096
    b.hi do_compose_4434
do_apply_4435:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4436
do_compose_4434:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4436:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, entry
    cmp x0, #4096
    b.hi do_compose_4437
do_apply_4438:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4439
do_compose_4437:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4439:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, env
    cmp x0, #4096
    b.hi do_compose_4440
do_apply_4441:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4442
do_compose_4440:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4442:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_program
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4443
    b after_func_4445_4446
func_4445:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4447_4448
func_4447:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4452_4453
func_4452:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4454_4455
func_4454:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4456_4457
func_4456:
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
after_func_4456_4457:
    // Closure for func_4456
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4456
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4454_4455:
    // Closure for func_4454
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4454
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4458
do_apply_4459:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4460
do_compose_4458:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4460:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4461
do_apply_4462:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4463
do_compose_4461:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4463:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4452_4453:
    // Closure for func_4452
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4452
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4464_4465
func_4464:
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
after_func_4464_4465:
    // Closure for func_4464
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4464
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4449
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4451
xor_true_4449:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4450
    adr x0, sign_id
    b xor_end_4451
xor_false_4450:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4447_4448:
    // Closure for func_4447
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4447
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4445_4446:
    // Closure for func_4445
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4445
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4444
cond_false_4443:
    adr x0, sign_id
cond_end_4444:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4466_4467
func_4466:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4471_4472
func_4471:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4473_4474
func_4473:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4475_4476
func_4475:
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
after_func_4475_4476:
    // Closure for func_4475
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4475
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4473_4474:
    // Closure for func_4473
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4473
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4477
do_apply_4478:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4479
do_compose_4477:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4479:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4480
do_apply_4481:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4482
do_compose_4480:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4482:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4471_4472:
    // Closure for func_4471
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4471
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4483_4484
func_4483:
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
after_func_4483_4484:
    // Closure for func_4483
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4483
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4468
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4470
xor_true_4468:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4469
    adr x0, sign_id
    b xor_end_4470
xor_false_4469:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4466_4467:
    // Closure for func_4466
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4466
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4485_4486
func_4485:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4490_4491
func_4490:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4492_4493
func_4492:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4494_4495
func_4494:
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
after_func_4494_4495:
    // Closure for func_4494
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4494
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4492_4493:
    // Closure for func_4492
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4492
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4496
do_apply_4497:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4498
do_compose_4496:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4498:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4499
do_apply_4500:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4501
do_compose_4499:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4501:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4490_4491:
    // Closure for func_4490
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4490
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4502_4503
func_4502:
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
after_func_4502_4503:
    // Closure for func_4502
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4502
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4487
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4489
xor_true_4487:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4488
    adr x0, sign_id
    b xor_end_4489
xor_false_4488:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4485_4486:
    // Closure for func_4485
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4485
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_30
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, asm
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    cmp x0, #4096
    b.hi do_compose_4504
do_apply_4505:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4506
do_compose_4504:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4506:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    adr x0, ast
    cmp x0, #4096
    b.hi do_compose_4507
do_apply_4508:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4509
do_compose_4507:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4509:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4510
do_apply_4511:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4512
do_compose_4510:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4512:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, mk_ctx
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4513
do_apply_4514:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4515
do_compose_4513:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4515:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4516
do_apply_4517:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4518
do_compose_4516:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4518:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4519
do_apply_4520:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4521
do_compose_4519:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4521:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_stmts
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4522
    b after_func_4526_4527
func_4526:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4528
    adr x0, sign_id
    b cmp_end_4529
cmp_true_4528:
cmp_end_4529:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4526_4527:
    // Closure for func_4526
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4526
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4524
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4530
do_apply_4531:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4532
do_compose_4530:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4532:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4533
do_apply_4534:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4535
do_compose_4533:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4535:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4536
do_apply_4537:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4538
do_compose_4536:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4538:
    cmp x0, #4096
    b.hi do_compose_4539
do_apply_4540:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4541
do_compose_4539:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4541:
    b cond_end_4525
cond_false_4524:
    adr x0, sign_id
cond_end_4525:
    b cond_end_4523
cond_false_4522:
    adr x0, sign_id
cond_end_4523:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4542_4543
func_4542:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4547_4548
func_4547:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4549_4550
func_4549:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4551_4552
func_4551:
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
after_func_4551_4552:
    // Closure for func_4551
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4551
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4549_4550:
    // Closure for func_4549
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4549
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4553
do_apply_4554:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4555
do_compose_4553:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4555:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4556
do_apply_4557:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4558
do_compose_4556:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4558:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4547_4548:
    // Closure for func_4547
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4547
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4559_4560
func_4559:
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
after_func_4559_4560:
    // Closure for func_4559
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4559
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4544
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4546
xor_true_4544:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4545
    adr x0, sign_id
    b xor_end_4546
xor_false_4545:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4542_4543:
    // Closure for func_4542
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4542
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4561_4562
func_4561:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4566_4567
func_4566:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4568_4569
func_4568:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4570_4571
func_4570:
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
after_func_4570_4571:
    // Closure for func_4570
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4570
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4568_4569:
    // Closure for func_4568
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4568
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4572
do_apply_4573:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4574
do_compose_4572:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4574:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4575
do_apply_4576:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4577
do_compose_4575:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4577:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4566_4567:
    // Closure for func_4566
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4566
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4578_4579
func_4578:
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
after_func_4578_4579:
    // Closure for func_4578
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4578
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4563
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4565
xor_true_4563:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4564
    adr x0, sign_id
    b xor_end_4565
xor_false_4564:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4561_4562:
    // Closure for func_4561
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4561
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4580_4581
func_4580:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4585_4586
func_4585:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4587_4588
func_4587:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4589_4590
func_4589:
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
after_func_4589_4590:
    // Closure for func_4589
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4589
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4587_4588:
    // Closure for func_4587
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4587
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4591
do_apply_4592:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4593
do_compose_4591:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4593:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4594
do_apply_4595:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4596
do_compose_4594:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4596:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4585_4586:
    // Closure for func_4585
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4585
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4597_4598
func_4597:
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
after_func_4597_4598:
    // Closure for func_4597
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4597
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4582
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4584
xor_true_4582:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4583
    adr x0, sign_id
    b xor_end_4584
xor_false_4583:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4580_4581:
    // Closure for func_4580
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4580
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4599_4600
func_4599:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4604_4605
func_4604:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4606_4607
func_4606:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4608_4609
func_4608:
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
after_func_4608_4609:
    // Closure for func_4608
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4608
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4606_4607:
    // Closure for func_4606
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4606
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4610
do_apply_4611:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4612
do_compose_4610:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4612:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4613
do_apply_4614:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4615
do_compose_4613:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4615:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4604_4605:
    // Closure for func_4604
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4604
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4616_4617
func_4616:
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
after_func_4616_4617:
    // Closure for func_4616
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4616
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4601
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4603
xor_true_4601:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4602
    adr x0, sign_id
    b xor_end_4603
xor_false_4602:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4599_4600:
    // Closure for func_4599
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4599
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4618_4619
func_4618:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4623_4624
func_4623:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4625_4626
func_4625:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4627_4628
func_4627:
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
after_func_4627_4628:
    // Closure for func_4627
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4627
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4625_4626:
    // Closure for func_4625
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4625
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4629
do_apply_4630:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4631
do_compose_4629:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4631:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4632
do_apply_4633:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4634
do_compose_4632:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4634:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4623_4624:
    // Closure for func_4623
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4623
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4635_4636
func_4635:
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
after_func_4635_4636:
    // Closure for func_4635
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4635
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4620
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4622
xor_true_4620:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4621
    adr x0, sign_id
    b xor_end_4622
xor_false_4621:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4618_4619:
    // Closure for func_4618
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4618
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4637_4638
func_4637:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4642_4643
func_4642:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4644_4645
func_4644:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4646_4647
func_4646:
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
after_func_4646_4647:
    // Closure for func_4646
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4646
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4644_4645:
    // Closure for func_4644
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4644
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4648
do_apply_4649:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4650
do_compose_4648:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4650:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4651
do_apply_4652:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4653
do_compose_4651:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4653:
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
    str x0, [sp, #-16]!
    b after_func_4654_4655
func_4654:
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
after_func_4654_4655:
    // Closure for func_4654
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4654
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4639
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4641
xor_true_4639:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4640
    adr x0, sign_id
    b xor_end_4641
xor_false_4640:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4637_4638:
    // Closure for func_4637
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4637
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm1
    cmp x0, #4096
    b.hi do_compose_4656
do_apply_4657:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4658
do_compose_4656:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4658:
    str x0, [sp, #-16]!
    adr x0, asm2
    cmp x0, #4096
    b.hi do_compose_4659
do_apply_4660:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4661
do_compose_4659:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4661:
    cmp x0, #4096
    b.hi do_compose_4662
do_apply_4663:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4664
do_compose_4662:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4664:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx2
    cmp x0, #4096
    b.hi do_compose_4665
do_apply_4666:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4667
do_compose_4665:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4667:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4668
do_apply_4669:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4670
do_compose_4668:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4670:
    cmp x0, #4096
    b.hi do_compose_4671
do_apply_4672:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4673
do_compose_4671:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4673:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res2
    cmp x0, #4096
    b.hi do_compose_4674
do_apply_4675:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4676
do_compose_4674:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4676:
    cmp x0, #4096
    b.hi do_compose_4677
do_apply_4678:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4679
do_compose_4677:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4679:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res2
    cmp x0, #4096
    b.hi do_compose_4680
do_apply_4681:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4682
do_compose_4680:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4682:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, stmts
    cmp x0, #4096
    b.hi do_compose_4683
do_apply_4684:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4685
do_compose_4683:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4685:
    cmp x0, #4096
    b.hi do_compose_4686
do_apply_4687:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4688
do_compose_4686:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4688:
    str x0, [sp, #-16]!
    adr x0, ctx1
    cmp x0, #4096
    b.hi do_compose_4689
do_apply_4690:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4691
do_compose_4689:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4691:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res1
    cmp x0, #4096
    b.hi do_compose_4692
do_apply_4693:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4694
do_compose_4692:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4694:
    cmp x0, #4096
    b.hi do_compose_4695
do_apply_4696:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4697
do_compose_4695:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4697:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res1
    cmp x0, #4096
    b.hi do_compose_4698
do_apply_4699:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4700
do_compose_4698:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4700:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, stmts
    cmp x0, #4096
    b.hi do_compose_4701
do_apply_4702:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4703
do_compose_4701:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4703:
    cmp x0, #4096
    b.hi do_compose_4704
do_apply_4705:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4706
do_compose_4704:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4706:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4707
do_apply_4708:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4709
do_compose_4707:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4709:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4710
    b after_func_4712_4713
func_4712:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4714_4715
func_4714:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4719_4720
func_4719:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4721_4722
func_4721:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4723_4724
func_4723:
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
after_func_4723_4724:
    // Closure for func_4723
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4723
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4721_4722:
    // Closure for func_4721
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4721
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4725
do_apply_4726:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4727
do_compose_4725:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4727:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4728
do_apply_4729:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4730
do_compose_4728:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4730:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4719_4720:
    // Closure for func_4719
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4719
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4731_4732
func_4731:
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
after_func_4731_4732:
    // Closure for func_4731
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4731
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4716
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4718
xor_true_4716:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4717
    adr x0, sign_id
    b xor_end_4718
xor_false_4717:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4714_4715:
    // Closure for func_4714
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4714
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4712_4713:
    // Closure for func_4712
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4712
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4711
cond_false_4710:
    adr x0, sign_id
cond_end_4711:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4735
    adr x0, sign_id
    b cmp_end_4736
cmp_true_4735:
cmp_end_4736:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4733
    adr x0, compile_num
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_4737
do_apply_4738:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4739
do_compose_4737:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4739:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4740
do_apply_4741:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4742
do_compose_4740:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4742:
    b cond_end_4734
cond_false_4733:
    adr x0, sign_id
cond_end_4734:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4745
    adr x0, sign_id
    b cmp_end_4746
cmp_true_4745:
cmp_end_4746:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4743
    adr x0, compile_id
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_4747
do_apply_4748:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4749
do_compose_4747:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4749:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4750
do_apply_4751:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4752
do_compose_4750:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4752:
    b cond_end_4744
cond_false_4743:
    adr x0, sign_id
cond_end_4744:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4755
    adr x0, sign_id
    b cmp_end_4756
cmp_true_4755:
cmp_end_4756:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4753
    adr x0, compile_apply
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_4757
do_apply_4758:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4759
do_compose_4757:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4759:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4760
do_apply_4761:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4762
do_compose_4760:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4762:
    b cond_end_4754
cond_false_4753:
    adr x0, sign_id
cond_end_4754:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4765
    adr x0, sign_id
    b cmp_end_4766
cmp_true_4765:
cmp_end_4766:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4763
    adr x0, compile_infix
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_4767
do_apply_4768:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4769
do_compose_4767:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4769:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4770
do_apply_4771:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4772
do_compose_4770:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4772:
    b cond_end_4764
cond_false_4763:
    adr x0, sign_id
cond_end_4764:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_31
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4773
do_apply_4774:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4775
do_compose_4773:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4775:
    str x0, [sp, #-16]!
    adr x0, mov
    cmp x0, #4096
    b.hi do_compose_4776
do_apply_4777:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4778
do_compose_4776:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4778:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_4779
do_apply_4780:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4781
do_compose_4779:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4781:
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_4782
do_apply_4783:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4784
do_compose_4782:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4784:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4785
do_apply_4786:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4787
do_compose_4785:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4787:
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4788
do_apply_4789:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4790
do_compose_4788:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4790:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4791
do_apply_4792:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4793
do_compose_4791:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4793:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4794
do_apply_4795:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4796
do_compose_4794:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4796:
    cmp x0, #4096
    b.hi do_compose_4797
do_apply_4798:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4799
do_compose_4797:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4799:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_4800
do_apply_4801:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4802
do_compose_4800:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4802:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_num
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4803
    b after_func_4805_4806
func_4805:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4807_4808
func_4807:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4812_4813
func_4812:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4814_4815
func_4814:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4816_4817
func_4816:
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
after_func_4816_4817:
    // Closure for func_4816
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4816
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4814_4815:
    // Closure for func_4814
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4814
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4818
do_apply_4819:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4820
do_compose_4818:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4820:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4821
do_apply_4822:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4823
do_compose_4821:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4823:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4812_4813:
    // Closure for func_4812
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4812
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4824_4825
func_4824:
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
after_func_4824_4825:
    // Closure for func_4824
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4824
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4809
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4811
xor_true_4809:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4810
    adr x0, sign_id
    b xor_end_4811
xor_false_4810:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4807_4808:
    // Closure for func_4807
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4807
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4805_4806:
    // Closure for func_4805
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4805
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4804
cond_false_4803:
    adr x0, sign_id
cond_end_4804:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4826_4827
func_4826:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4831_4832
func_4831:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4833_4834
func_4833:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4835_4836
func_4835:
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
after_func_4835_4836:
    // Closure for func_4835
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4835
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4833_4834:
    // Closure for func_4833
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4833
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4837
do_apply_4838:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4839
do_compose_4837:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4839:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4840
do_apply_4841:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4842
do_compose_4840:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4842:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4831_4832:
    // Closure for func_4831
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4831
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4843_4844
func_4843:
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
after_func_4843_4844:
    // Closure for func_4843
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4843
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4828
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4830
xor_true_4828:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4829
    adr x0, sign_id
    b xor_end_4830
xor_false_4829:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4826_4827:
    // Closure for func_4826
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4826
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, asm
    cmp x0, #4096
    b.hi do_compose_4845
do_apply_4846:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4847
do_compose_4845:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4847:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4848
do_apply_4849:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4850
do_compose_4848:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4850:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4851
do_apply_4852:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4853
do_compose_4851:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4853:
    cmp x0, #4096
    b.hi do_compose_4854
do_apply_4855:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4856
do_compose_4854:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4856:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4857
do_apply_4858:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4859
do_compose_4857:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4859:
    str x0, [sp, #-16]!
    adr x0, mov
    cmp x0, #4096
    b.hi do_compose_4860
do_apply_4861:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4862
do_compose_4860:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4862:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_4863
do_apply_4864:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4865
do_compose_4863:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4865:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_4866
do_apply_4867:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4868
do_compose_4866:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4868:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4869
do_apply_4870:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4871
do_compose_4869:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4871:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_4872
do_apply_4873:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4874
do_compose_4872:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4874:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4875
do_apply_4876:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4877
do_compose_4875:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4877:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4878
do_apply_4879:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4880
do_compose_4878:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4880:
    cmp x0, #4096
    b.hi do_compose_4881
do_apply_4882:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4883
do_compose_4881:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4883:
    cmp x0, #4096
    b.hi do_compose_4884
do_apply_4885:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4886
do_compose_4884:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4886:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_4887
do_apply_4888:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4889
do_compose_4887:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4889:
    cmp x0, #4096
    b.hi do_compose_4890
do_apply_4891:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4892
do_compose_4890:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4892:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_id
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4893
    b after_func_4895_4896
func_4895:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4897_4898
func_4897:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4902_4903
func_4902:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4904_4905
func_4904:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4906_4907
func_4906:
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
after_func_4906_4907:
    // Closure for func_4906
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4906
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4904_4905:
    // Closure for func_4904
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4904
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4908
do_apply_4909:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4910
do_compose_4908:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4910:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4911
do_apply_4912:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4913
do_compose_4911:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4913:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4902_4903:
    // Closure for func_4902
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4902
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4914_4915
func_4914:
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
after_func_4914_4915:
    // Closure for func_4914
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4914
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4899
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4901
xor_true_4899:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4900
    adr x0, sign_id
    b xor_end_4901
xor_false_4900:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4897_4898:
    // Closure for func_4897
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4897
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4895_4896:
    // Closure for func_4895
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4895
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4894
cond_false_4893:
    adr x0, sign_id
cond_end_4894:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4916_4917
func_4916:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4921_4922
func_4921:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4925_4926:
    // Closure for func_4925
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_4927
do_apply_4928:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4929
do_compose_4927:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4929:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4930
do_apply_4931:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4932
do_compose_4930:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4932:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4921_4922:
    // Closure for func_4921
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4921
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4933_4934
func_4933:
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
after_func_4933_4934:
    // Closure for func_4933
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4933
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4918
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4920
xor_true_4918:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4919
    adr x0, sign_id
    b xor_end_4920
xor_false_4919:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4916_4917:
    // Closure for func_4916
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4916
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, offset
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4937
    adr x0, sign_id
    b cmp_end_4938
cmp_true_4937:
cmp_end_4938:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4935
    adr x0, sign_id
    b cond_end_4936
cond_false_4935:
    adr x0, sign_id
cond_end_4936:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_32
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4939
do_apply_4940:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4941
do_compose_4939:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4941:
    str x0, [sp, #-16]!
    adr x0, mov
    cmp x0, #4096
    b.hi do_compose_4942
do_apply_4943:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4944
do_compose_4942:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4944:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_4945
do_apply_4946:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4947
do_compose_4945:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4947:
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, /
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, Unknown
    cmp x0, #4096
    b.hi do_compose_4948
do_apply_4949:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4950
do_compose_4948:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4950:
    str x0, [sp, #-16]!
    adr x0, var
    cmp x0, #4096
    b.hi do_compose_4951
do_apply_4952:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4953
do_compose_4951:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4953:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_4954
do_apply_4955:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4956
do_compose_4954:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4956:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_4957
do_apply_4958:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4959
do_compose_4957:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4959:
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4960
do_apply_4961:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4962
do_compose_4960:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4962:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4963
do_apply_4964:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4965
do_compose_4963:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4965:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4966
do_apply_4967:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4968
do_compose_4966:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4968:
    cmp x0, #4096
    b.hi do_compose_4969
do_apply_4970:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4971
do_compose_4969:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4971:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_4972_4973
func_4972:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4977_4978
func_4977:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_4979_4980
func_4979:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4981_4982
func_4981:
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
after_func_4981_4982:
    // Closure for func_4981
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4981
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4979_4980:
    // Closure for func_4979
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4979
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_4983
do_apply_4984:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4985
do_compose_4983:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4985:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_4986
do_apply_4987:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4988
do_compose_4986:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4988:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4977_4978:
    // Closure for func_4977
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4977
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_4989_4990
func_4989:
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
after_func_4989_4990:
    // Closure for func_4989
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4989
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_4974
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_4976
xor_true_4974:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_4975
    adr x0, sign_id
    b xor_end_4976
xor_false_4975:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4972_4973:
    // Closure for func_4972
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4972
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, asm
    cmp x0, #4096
    b.hi do_compose_4991
do_apply_4992:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4993
do_compose_4991:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4993:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_4994
do_apply_4995:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4996
do_compose_4994:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4996:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_4997
do_apply_4998:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4999
do_compose_4997:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_4999:
    cmp x0, #4096
    b.hi do_compose_5000
do_apply_5001:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5002
do_compose_5000:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5002:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5003
do_apply_5004:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5005
do_compose_5003:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5005:
    str x0, [sp, #-16]!
    adr x0, ldr
    cmp x0, #4096
    b.hi do_compose_5006
do_apply_5007:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5008
do_compose_5006:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5008:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_5009
do_apply_5010:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5011
do_compose_5009:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5011:
    str x0, [sp, #-16]!
    adr x0, x29
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    adr x0, offset
    cmp x0, #4096
    b.hi do_compose_5012
do_apply_5013:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5014
do_compose_5012:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5014:
    cmp x0, #4096
    b.hi do_compose_5015
do_apply_5016:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5017
do_compose_5015:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5017:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5018
do_apply_5019:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5020
do_compose_5018:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5020:
    cmp x0, #4096
    b.hi do_compose_5021
do_apply_5022:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5023
do_compose_5021:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5023:
    str x0, [sp, #-16]!
    mov x0, #110
    cmp x0, #4096
    b.hi do_compose_5024
do_apply_5025:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5026
do_compose_5024:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5026:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5027
do_apply_5028:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5029
do_compose_5027:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5029:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, lookup_id
    str x0, [sp, #-16]!
    adr x0, get_env
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_5030
do_apply_5031:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5032
do_compose_5030:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5032:
    cmp x0, #4096
    b.hi do_compose_5033
do_apply_5034:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5035
do_compose_5033:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5035:
    str x0, [sp, #-16]!
    adr x0, id
    cmp x0, #4096
    b.hi do_compose_5036
do_apply_5037:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5038
do_compose_5036:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5038:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_5039
do_apply_5040:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5041
do_compose_5039:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5041:
    cmp x0, #4096
    b.hi do_compose_5042
do_apply_5043:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5044
do_compose_5042:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5044:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_apply
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5045
    b after_func_5047_5048
func_5047:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5049_5050
func_5049:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5054_5055
func_5054:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5056_5057
func_5056:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5058_5059
func_5058:
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
after_func_5058_5059:
    // Closure for func_5058
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5058
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5056_5057:
    // Closure for func_5056
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5056
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5060
do_apply_5061:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5062
do_compose_5060:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5062:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5063
do_apply_5064:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5065
do_compose_5063:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5065:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5054_5055:
    // Closure for func_5054
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5054
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5066_5067
func_5066:
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
after_func_5066_5067:
    // Closure for func_5066
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5066
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5051
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5053
xor_true_5051:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5052
    adr x0, sign_id
    b xor_end_5053
xor_false_5052:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5049_5050:
    // Closure for func_5049
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5049
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5047_5048:
    // Closure for func_5047
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5047
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5046
cond_false_5045:
    adr x0, sign_id
cond_end_5046:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5068_5069
func_5068:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5073_5074
func_5073:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5077_5078:
    // Closure for func_5077
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_5079
do_apply_5080:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5081
do_compose_5079:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5081:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5082
do_apply_5083:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5084
do_compose_5082:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5084:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5073_5074:
    // Closure for func_5073
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5073
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5085_5086
func_5085:
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
after_func_5085_5086:
    // Closure for func_5085
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5085
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5070
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5072
xor_true_5070:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5071
    adr x0, sign_id
    b xor_end_5072
xor_false_5071:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5068_5069:
    // Closure for func_5068
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5068
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5087_5088
func_5087:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5092_5093
func_5092:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5094_5095
func_5094:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5096_5097
func_5096:
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
after_func_5096_5097:
    // Closure for func_5096
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5096
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5094_5095:
    // Closure for func_5094
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5094
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5098
do_apply_5099:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5100
do_compose_5098:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5100:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5101
do_apply_5102:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5103
do_compose_5101:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5103:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5092_5093:
    // Closure for func_5092
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5092
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5104_5105
func_5104:
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
after_func_5104_5105:
    // Closure for func_5104
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5104
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5089
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5091
xor_true_5089:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5090
    adr x0, sign_id
    b xor_end_5091
xor_false_5090:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5106_5107
func_5106:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5111_5112
func_5111:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5113_5114
func_5113:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5115_5116
func_5115:
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
after_func_5115_5116:
    // Closure for func_5115
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5115
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5113_5114:
    // Closure for func_5113
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5113
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5117
do_apply_5118:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5119
do_compose_5117:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5119:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5120
do_apply_5121:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5122
do_compose_5120:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5122:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5111_5112:
    // Closure for func_5111
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5111
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5123_5124
func_5123:
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
after_func_5123_5124:
    // Closure for func_5123
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5123
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5108
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5110
xor_true_5108:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5109
    adr x0, sign_id
    b xor_end_5110
xor_false_5109:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5106_5107:
    // Closure for func_5106
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5106
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5125_5126
func_5125:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5130_5131
func_5130:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5132_5133
func_5132:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5134_5135
func_5134:
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
after_func_5134_5135:
    // Closure for func_5134
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5134
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5132_5133:
    // Closure for func_5132
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5132
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5136
do_apply_5137:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5138
do_compose_5136:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5138:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5139
do_apply_5140:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5141
do_compose_5139:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5141:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5130_5131:
    // Closure for func_5130
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5130
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5142_5143
func_5142:
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
after_func_5142_5143:
    // Closure for func_5142
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5142
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5127
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5129
xor_true_5127:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5128
    adr x0, sign_id
    b xor_end_5129
xor_false_5128:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5125_5126:
    // Closure for func_5125
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5125
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5144_5145
func_5144:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5149_5150
func_5149:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5151_5152
func_5151:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5153_5154
func_5153:
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
after_func_5153_5154:
    // Closure for func_5153
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5153
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5151_5152:
    // Closure for func_5151
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5151
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5155
do_apply_5156:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5157
do_compose_5155:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5157:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5158
do_apply_5159:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5160
do_compose_5158:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5160:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5149_5150:
    // Closure for func_5149
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5149
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5161_5162
func_5161:
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
after_func_5161_5162:
    // Closure for func_5161
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5161
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5146
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5148
xor_true_5146:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5147
    adr x0, sign_id
    b xor_end_5148
xor_false_5147:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5144_5145:
    // Closure for func_5144
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5144
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5163_5164
func_5163:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5168_5169
func_5168:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5170_5171
func_5170:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5172_5173
func_5172:
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
after_func_5172_5173:
    // Closure for func_5172
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5172
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5170_5171:
    // Closure for func_5170
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5170
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5174
do_apply_5175:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5176
do_compose_5174:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5176:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5177
do_apply_5178:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5179
do_compose_5177:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5179:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5168_5169:
    // Closure for func_5168
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5168
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5180_5181
func_5180:
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
after_func_5180_5181:
    // Closure for func_5180
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5180
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5165
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5167
xor_true_5165:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5166
    adr x0, sign_id
    b xor_end_5167
xor_false_5166:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5163_5164:
    // Closure for func_5163
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5163
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5182_5183
func_5182:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5187_5188
func_5187:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5189_5190
func_5189:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5191_5192
func_5191:
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
after_func_5191_5192:
    // Closure for func_5191
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5191
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5189_5190:
    // Closure for func_5189
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5189
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5193
do_apply_5194:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5195
do_compose_5193:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5195:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5196
do_apply_5197:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5198
do_compose_5196:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5198:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5187_5188:
    // Closure for func_5187
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5187
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5199_5200
func_5199:
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
after_func_5199_5200:
    // Closure for func_5199
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5199
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5184
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5186
xor_true_5184:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5185
    adr x0, sign_id
    b xor_end_5186
xor_false_5185:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5182_5183:
    // Closure for func_5182
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5182
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_33
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_34
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5201_5202
func_5201:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5206_5207
func_5206:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5208_5209
func_5208:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5210_5211
func_5210:
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
after_func_5210_5211:
    // Closure for func_5210
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5210
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5208_5209:
    // Closure for func_5208
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5208
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5212
do_apply_5213:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5214
do_compose_5212:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5214:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5215
do_apply_5216:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5217
do_compose_5215:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5217:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5206_5207:
    // Closure for func_5206
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5206
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5218_5219
func_5218:
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
after_func_5218_5219:
    // Closure for func_5218
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5218
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5203
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5205
xor_true_5203:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5204
    adr x0, sign_id
    b xor_end_5205
xor_false_5204:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5201_5202:
    // Closure for func_5201
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5201
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, asm
    cmp x0, #4096
    b.hi do_compose_5220
do_apply_5221:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5222
do_compose_5220:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5222:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx2
    cmp x0, #4096
    b.hi do_compose_5223
do_apply_5224:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5225
do_compose_5223:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5225:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_5226
do_apply_5227:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5228
do_compose_5226:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5228:
    cmp x0, #4096
    b.hi do_compose_5229
do_apply_5230:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5231
do_compose_5229:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5231:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm2
    cmp x0, #4096
    b.hi do_compose_5232
do_apply_5233:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5234
do_compose_5232:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5234:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5235
do_apply_5236:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5237
do_compose_5235:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5237:
    str x0, [sp, #-16]!
    adr x0, str
    cmp x0, #4096
    b.hi do_compose_5238
do_apply_5239:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5240
do_compose_5238:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5240:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_5241
do_apply_5242:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5243
do_compose_5241:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5243:
    str x0, [sp, #-16]!
    adr x0, sp
    str x0, [sp, #-16]!
    adr x0, -
    str x0, [sp, #-16]!
    mov x0, #16
    cmp x0, #4096
    b.hi do_compose_5244
do_apply_5245:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5246
do_compose_5244:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5246:
    ldr x1, [sp], #16
    bl _cons
    bl _factorial
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_5247
do_apply_5248:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5249
do_compose_5247:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5249:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5250
do_apply_5251:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5252
do_compose_5250:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5252:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm1
    cmp x0, #4096
    b.hi do_compose_5253
do_apply_5254:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5255
do_compose_5253:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5255:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5256
do_apply_5257:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5258
do_compose_5256:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5258:
    str x0, [sp, #-16]!
    adr x0, blr
    cmp x0, #4096
    b.hi do_compose_5259
do_apply_5260:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5261
do_compose_5259:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5261:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_5262
do_apply_5263:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5264
do_compose_5262:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5264:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_5265
do_apply_5266:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5267
do_compose_5265:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5267:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5268
do_apply_5269:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5270
do_compose_5268:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5270:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5271
do_apply_5272:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5273
do_compose_5271:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5273:
    str x0, [sp, #-16]!
    adr x0, add
    cmp x0, #4096
    b.hi do_compose_5274
do_apply_5275:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5276
do_compose_5274:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5276:
    str x0, [sp, #-16]!
    adr x0, sp
    cmp x0, #4096
    b.hi do_compose_5277
do_apply_5278:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5279
do_compose_5277:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5279:
    str x0, [sp, #-16]!
    adr x0, sp
    str x0, [sp, #-16]!
    mov x0, #16
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_5280
do_apply_5281:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5282
do_compose_5280:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5282:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5283
do_apply_5284:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5285
do_compose_5283:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5285:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res2
    cmp x0, #4096
    b.hi do_compose_5286
do_apply_5287:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5288
do_compose_5286:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5288:
    cmp x0, #4096
    b.hi do_compose_5289
do_apply_5290:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5291
do_compose_5289:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5291:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res2
    cmp x0, #4096
    b.hi do_compose_5292
do_apply_5293:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5294
do_compose_5292:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5294:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_5295
do_apply_5296:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5297
do_compose_5295:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5297:
    str x0, [sp, #-16]!
    adr x0, ctx1
    cmp x0, #4096
    b.hi do_compose_5298
do_apply_5299:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5300
do_compose_5298:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5300:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res1
    cmp x0, #4096
    b.hi do_compose_5301
do_apply_5302:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5303
do_compose_5301:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5303:
    cmp x0, #4096
    b.hi do_compose_5304
do_apply_5305:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5306
do_compose_5304:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5306:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res1
    cmp x0, #4096
    b.hi do_compose_5307
do_apply_5308:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5309
do_compose_5307:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5309:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_5310
do_apply_5311:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5312
do_compose_5310:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5312:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_5313
do_apply_5314:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5315
do_compose_5313:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5315:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_5316
do_apply_5317:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5318
do_compose_5316:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5318:
    cmp x0, #4096
    b.hi do_compose_5319
do_apply_5320:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5321
do_compose_5319:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5321:
    cmp x0, #4096
    b.hi do_compose_5322
do_apply_5323:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5324
do_compose_5322:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5324:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_5325
do_apply_5326:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5327
do_compose_5325:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5327:
    cmp x0, #4096
    b.hi do_compose_5328
do_apply_5329:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5330
do_compose_5328:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5330:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_infix
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5331
    b after_func_5333_5334
func_5333:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5335_5336
func_5335:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5340_5341
func_5340:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5342_5343
func_5342:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5344_5345
func_5344:
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
after_func_5344_5345:
    // Closure for func_5344
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5344
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5342_5343:
    // Closure for func_5342
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5342
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5346
do_apply_5347:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5348
do_compose_5346:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5348:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5349
do_apply_5350:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5351
do_compose_5349:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5351:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5340_5341:
    // Closure for func_5340
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5340
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5352_5353
func_5352:
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
after_func_5352_5353:
    // Closure for func_5352
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5352
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5337
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5339
xor_true_5337:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5338
    adr x0, sign_id
    b xor_end_5339
xor_false_5338:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5335_5336:
    // Closure for func_5335
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5335
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5333_5334:
    // Closure for func_5333
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5333
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5332
cond_false_5331:
    adr x0, sign_id
cond_end_5332:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5354_5355
func_5354:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5359_5360
func_5359:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5361_5362
func_5361:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5363_5364
func_5363:
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
after_func_5363_5364:
    // Closure for func_5363
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5363
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5361_5362:
    // Closure for func_5361
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5361
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5365
do_apply_5366:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5367
do_compose_5365:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5367:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5368
do_apply_5369:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5370
do_compose_5368:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5370:
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
    str x0, [sp, #-16]!
    b after_func_5371_5372
func_5371:
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
after_func_5371_5372:
    // Closure for func_5371
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5371
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5356
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5358
xor_true_5356:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5357
    adr x0, sign_id
    b xor_end_5358
xor_false_5357:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5373_5374
func_5373:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5378_5379
func_5378:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5380_5381
func_5380:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5382_5383
func_5382:
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
after_func_5382_5383:
    // Closure for func_5382
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5382
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5380_5381:
    // Closure for func_5380
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5380
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5384
do_apply_5385:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5386
do_compose_5384:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5386:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5387
do_apply_5388:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5389
do_compose_5387:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5389:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5378_5379:
    // Closure for func_5378
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5378
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5390_5391
func_5390:
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
after_func_5390_5391:
    // Closure for func_5390
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5390
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5375
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5377
xor_true_5375:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5376
    adr x0, sign_id
    b xor_end_5377
xor_false_5376:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_5394
do_apply_5395:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5396
do_compose_5394:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5396:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5397
do_apply_5398:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5399
do_compose_5397:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5399:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5392
    adr x0, compile_if
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_5400
do_apply_5401:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5402
do_compose_5400:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5402:
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_5403
do_apply_5404:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5405
do_compose_5403:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5405:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_5406
do_apply_5407:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5408
do_compose_5406:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5408:
    adr x1, "
    str x0, [x1]
    adr x0, sign_id
    b cond_end_5393
cond_false_5392:
    adr x0, sign_id
cond_end_5393:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_5411
do_apply_5412:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5413
do_compose_5411:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5413:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5414
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5416
xor_true_5414:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5415
    adr x0, sign_id
    b xor_end_5416
xor_false_5415:
    mov x0, x1
    cmp x0, #4096
    b.hi do_compose_5417
do_apply_5418:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5419
do_compose_5417:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5419:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5409
    adr x0, compile_else
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_5420
do_apply_5421:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5422
do_compose_5420:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5422:
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_5423
do_apply_5424:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5425
do_compose_5423:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5425:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_5426
do_apply_5427:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5428
do_compose_5426:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5428:
    b cond_end_5410
cond_false_5409:
    adr x0, sign_id
cond_end_5410:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5431_5432
func_5431:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5431_5432:
    // Closure for func_5431
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5431
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5429
    adr x0, compile_lambda
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_5433
do_apply_5434:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5435
do_compose_5433:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5435:
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_5436
do_apply_5437:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5438
do_compose_5436:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5438:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_5439
do_apply_5440:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5441
do_compose_5439:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5441:
    b cond_end_5430
cond_false_5429:
    adr x0, sign_id
cond_end_5430:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5442_5443
func_5442:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5447_5448
func_5447:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5449_5450
func_5449:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5451_5452
func_5451:
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
after_func_5451_5452:
    // Closure for func_5451
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5451
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_5453
do_apply_5454:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5455
do_compose_5453:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5455:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5456
do_apply_5457:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5458
do_compose_5456:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5458:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5447_5448:
    // Closure for func_5447
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5447
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5459_5460
func_5459:
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
after_func_5459_5460:
    // Closure for func_5459
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5459
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5444
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5446
xor_true_5444:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5445
    adr x0, sign_id
    b xor_end_5446
xor_false_5445:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5442_5443:
    // Closure for func_5442
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5442
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5461_5462
func_5461:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5466_5467
func_5466:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5468_5469
func_5468:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5470_5471
func_5470:
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
after_func_5470_5471:
    // Closure for func_5470
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5470
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5468_5469:
    // Closure for func_5468
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5468
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5472
do_apply_5473:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5474
do_compose_5472:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5474:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5475
do_apply_5476:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5477
do_compose_5475:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5477:
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
    b after_func_5478_5479
func_5478:
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
after_func_5478_5479:
    // Closure for func_5478
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5478
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5463
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5465
xor_true_5463:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5464
    adr x0, sign_id
    b xor_end_5465
xor_false_5464:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5461_5462:
    // Closure for func_5461
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5461
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5480_5481
func_5480:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5485_5486
func_5485:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5487_5488
func_5487:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5489_5490
func_5489:
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
after_func_5489_5490:
    // Closure for func_5489
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5489
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5487_5488:
    // Closure for func_5487
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5487
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5491
do_apply_5492:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5493
do_compose_5491:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5493:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5494
do_apply_5495:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5496
do_compose_5494:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5496:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5485_5486:
    // Closure for func_5485
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5485
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5497_5498
func_5497:
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
after_func_5497_5498:
    // Closure for func_5497
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5497
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5482
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5484
xor_true_5482:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5483
    adr x0, sign_id
    b xor_end_5484
xor_false_5483:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5480_5481:
    // Closure for func_5480
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5480
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5499_5500
func_5499:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5504_5505
func_5504:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5506_5507
func_5506:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5508_5509
func_5508:
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
after_func_5508_5509:
    // Closure for func_5508
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5508
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5506_5507:
    // Closure for func_5506
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5506
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5510
do_apply_5511:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5512
do_compose_5510:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5512:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5513
do_apply_5514:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5515
do_compose_5513:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5515:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5504_5505:
    // Closure for func_5504
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5504
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5516_5517
func_5516:
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
after_func_5516_5517:
    // Closure for func_5516
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5516
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5501
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5503
xor_true_5501:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5502
    adr x0, sign_id
    b xor_end_5503
xor_false_5502:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5518_5519
func_5518:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5523_5524
func_5523:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5525_5526
func_5525:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5527_5528
func_5527:
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
after_func_5527_5528:
    // Closure for func_5527
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5527
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5525_5526:
    // Closure for func_5525
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5525
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5529
do_apply_5530:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5531
do_compose_5529:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5531:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5532
do_apply_5533:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5534
do_compose_5532:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5534:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5523_5524:
    // Closure for func_5523
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5523
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5535_5536
func_5535:
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
after_func_5535_5536:
    // Closure for func_5535
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5535
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5520
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5522
xor_true_5520:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5521
    adr x0, sign_id
    b xor_end_5522
xor_false_5521:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5518_5519:
    // Closure for func_5518
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5518
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5537_5538
func_5537:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5542_5543
func_5542:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5544_5545
func_5544:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5546_5547
func_5546:
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
after_func_5546_5547:
    // Closure for func_5546
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5546
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5544_5545:
    // Closure for func_5544
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5544
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5548
do_apply_5549:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5550
do_compose_5548:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5550:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5551
do_apply_5552:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5553
do_compose_5551:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5553:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5542_5543:
    // Closure for func_5542
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5542
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5554_5555
func_5554:
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
after_func_5554_5555:
    // Closure for func_5554
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5554
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5539
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5541
xor_true_5539:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5540
    adr x0, sign_id
    b xor_end_5541
xor_false_5540:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5537_5538:
    // Closure for func_5537
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5537
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_35
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_36
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5556_5557
func_5556:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5561_5562
func_5561:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5563_5564
func_5563:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5565_5566
func_5565:
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
after_func_5565_5566:
    // Closure for func_5565
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5565
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5563_5564:
    // Closure for func_5563
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5563
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5567
do_apply_5568:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5569
do_compose_5567:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5569:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5570
do_apply_5571:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5572
do_compose_5570:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5572:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5561_5562:
    // Closure for func_5561
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5561
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5573_5574
func_5573:
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
after_func_5573_5574:
    // Closure for func_5573
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5573
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5558
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5560
xor_true_5558:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5559
    adr x0, sign_id
    b xor_end_5560
xor_false_5559:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5556_5557:
    // Closure for func_5556
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5556
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm1
    cmp x0, #4096
    b.hi do_compose_5575
do_apply_5576:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5577
do_compose_5575:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5577:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5578
do_apply_5579:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5580
do_compose_5578:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5580:
    str x0, [sp, #-16]!
    adr x0, str
    cmp x0, #4096
    b.hi do_compose_5581
do_apply_5582:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5583
do_compose_5581:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5583:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_5584
do_apply_5585:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5586
do_compose_5584:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5586:
    str x0, [sp, #-16]!
    adr x0, sp
    str x0, [sp, #-16]!
    adr x0, -
    str x0, [sp, #-16]!
    mov x0, #16
    cmp x0, #4096
    b.hi do_compose_5587
do_apply_5588:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5589
do_compose_5587:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5589:
    ldr x1, [sp], #16
    bl _cons
    bl _factorial
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_5590
do_apply_5591:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5592
do_compose_5590:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5592:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5593
do_apply_5594:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5595
do_compose_5593:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5595:
    str x0, [sp, #-16]!
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm2
    cmp x0, #4096
    b.hi do_compose_5596
do_apply_5597:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5598
do_compose_5596:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5598:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5599
do_apply_5600:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5601
do_compose_5599:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5601:
    str x0, [sp, #-16]!
    adr x0, ldr
    cmp x0, #4096
    b.hi do_compose_5602
do_apply_5603:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5604
do_compose_5602:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5604:
    str x0, [sp, #-16]!
    adr x0, x1
    cmp x0, #4096
    b.hi do_compose_5605
do_apply_5606:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5607
do_compose_5605:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5607:
    str x0, [sp, #-16]!
    adr x0, sp
    str x0, [sp, #-16]!
    mov x0, #16
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_5608
do_apply_5609:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5610
do_compose_5608:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5610:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5611
do_apply_5612:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5613
do_compose_5611:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5613:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op_asm
    cmp x0, #4096
    b.hi do_compose_5614
do_apply_5615:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5616
do_compose_5614:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5616:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_5617
do_apply_5618:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5619
do_compose_5617:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5619:
    cmp x0, #4096
    b.hi do_compose_5620
do_apply_5621:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5622
do_compose_5620:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5622:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5623
do_apply_5624:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5625
do_compose_5623:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5625:
    cmp x0, #4096
    b.hi do_compose_5626
do_apply_5627:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5628
do_compose_5626:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5628:
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5629
do_apply_5630:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5631
do_compose_5629:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5631:
    cmp x0, #4096
    b.hi do_compose_5632
do_apply_5633:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5634
do_compose_5632:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5634:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx2
    cmp x0, #4096
    b.hi do_compose_5635
do_apply_5636:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5637
do_compose_5635:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5637:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_5638
do_apply_5639:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5640
do_compose_5638:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5640:
    cmp x0, #4096
    b.hi do_compose_5641
do_apply_5642:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5643
do_compose_5641:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5643:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_op_asm
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_5644
do_apply_5645:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5646
do_compose_5644:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5646:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res2
    cmp x0, #4096
    b.hi do_compose_5647
do_apply_5648:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5649
do_compose_5647:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5649:
    cmp x0, #4096
    b.hi do_compose_5650
do_apply_5651:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5652
do_compose_5650:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5652:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res2
    cmp x0, #4096
    b.hi do_compose_5653
do_apply_5654:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5655
do_compose_5653:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5655:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_5656
do_apply_5657:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5658
do_compose_5656:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5658:
    str x0, [sp, #-16]!
    adr x0, ctx1
    cmp x0, #4096
    b.hi do_compose_5659
do_apply_5660:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5661
do_compose_5659:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5661:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res1
    cmp x0, #4096
    b.hi do_compose_5662
do_apply_5663:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5664
do_compose_5662:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5664:
    cmp x0, #4096
    b.hi do_compose_5665
do_apply_5666:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5667
do_compose_5665:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5667:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res1
    cmp x0, #4096
    b.hi do_compose_5668
do_apply_5669:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5670
do_compose_5668:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5670:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_5671
do_apply_5672:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5673
do_compose_5671:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5673:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_5674
do_apply_5675:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5676
do_compose_5674:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5676:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_5677
do_apply_5678:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5679
do_compose_5677:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5679:
    cmp x0, #4096
    b.hi do_compose_5680
do_apply_5681:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5682
do_compose_5680:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5682:
    cmp x0, #4096
    b.hi do_compose_5683
do_apply_5684:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5685
do_compose_5683:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5685:
    cmp x0, #4096
    b.hi do_compose_5686
do_apply_5687:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5688
do_compose_5686:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5688:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_5689
do_apply_5690:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5691
do_compose_5689:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5691:
    cmp x0, #4096
    b.hi do_compose_5692
do_apply_5693:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5694
do_compose_5692:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5694:
    cmp x0, #4096
    b.hi do_compose_5695
do_apply_5696:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5697
do_compose_5695:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5697:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_5698
do_apply_5699:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5700
do_compose_5698:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5700:
    cmp x0, #4096
    b.hi do_compose_5701
do_apply_5702:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5703
do_compose_5701:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5703:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_lambda
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5704
    b after_func_5706_5707
func_5706:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_37
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5706_5707:
    // Closure for func_5706
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5706
    ldr x0, [sp], #16
    bl _cons
    b cond_end_5705
cond_false_5704:
    adr x0, sign_id
cond_end_5705:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5708_5709
func_5708:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5713_5714
func_5713:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5715_5716
func_5715:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5717_5718
func_5717:
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
after_func_5717_5718:
    // Closure for func_5717
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5717
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5715_5716:
    // Closure for func_5715
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5715
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5719
do_apply_5720:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5721
do_compose_5719:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5721:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5722
do_apply_5723:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5724
do_compose_5722:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5724:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5713_5714:
    // Closure for func_5713
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5713
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5725_5726
func_5725:
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
after_func_5725_5726:
    // Closure for func_5725
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5725
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5710
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5712
xor_true_5710:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5711
    adr x0, sign_id
    b xor_end_5712
xor_false_5711:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5729
    adr x0, sign_id
    b cmp_end_5730
cmp_true_5729:
cmp_end_5730:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5727
    adr x0, sign_id
    b cond_end_5728
cond_false_5727:
    adr x0, sign_id
cond_end_5728:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_38
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5731_5732
func_5731:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5736_5737
func_5736:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5738_5739
func_5738:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5740_5741
func_5740:
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
after_func_5740_5741:
    // Closure for func_5740
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5740
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5738_5739:
    // Closure for func_5738
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5738
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5742
do_apply_5743:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5744
do_compose_5742:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5744:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5745
do_apply_5746:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5747
do_compose_5745:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5747:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5736_5737:
    // Closure for func_5736
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5736
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5748_5749
func_5748:
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
after_func_5748_5749:
    // Closure for func_5748
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5748
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5733
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5735
xor_true_5733:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5734
    adr x0, sign_id
    b xor_end_5735
xor_false_5734:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5731_5732:
    // Closure for func_5731
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5731
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5750_5751
func_5750:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5755_5756
func_5755:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5757_5758
func_5757:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5759_5760
func_5759:
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
after_func_5759_5760:
    // Closure for func_5759
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5759
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5757_5758:
    // Closure for func_5757
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5757
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5761
do_apply_5762:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5763
do_compose_5761:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5763:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5764
do_apply_5765:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5766
do_compose_5764:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5766:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5755_5756:
    // Closure for func_5755
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5755
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5767_5768
func_5767:
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
after_func_5767_5768:
    // Closure for func_5767
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5767
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5752
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5754
xor_true_5752:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5753
    adr x0, sign_id
    b xor_end_5754
xor_false_5753:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5750_5751:
    // Closure for func_5750
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5750
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_lambda
    str x0, [sp, #-16]!
    adr x0, p1
    cmp x0, #4096
    b.hi do_compose_5769
do_apply_5770:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5771
do_compose_5769:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5771:
    str x0, [sp, #-16]!
    b after_func_5772_5773
func_5772:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, p2
    cmp x0, #4096
    b.hi do_compose_5774
do_apply_5775:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5776
do_compose_5774:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5776:
    str x0, [sp, #-16]!
    adr x0, body
    cmp x0, #4096
    b.hi do_compose_5777
do_apply_5778:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5779
do_compose_5777:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5779:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5772_5773:
    // Closure for func_5772
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5772
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5780
do_apply_5781:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5782
do_compose_5780:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5782:
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_5783
do_apply_5784:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5785
do_compose_5783:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5785:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, params
    cmp x0, #4096
    b.hi do_compose_5786
do_apply_5787:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5788
do_compose_5786:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5788:
    cmp x0, #4096
    b.hi do_compose_5789
do_apply_5790:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5791
do_compose_5789:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5791:
    cmp x0, #4096
    b.hi do_compose_5792
do_apply_5793:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5794
do_compose_5792:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5794:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, params
    cmp x0, #4096
    b.hi do_compose_5795
do_apply_5796:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5797
do_compose_5795:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5797:
    cmp x0, #4096
    b.hi do_compose_5798
do_apply_5799:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5800
do_compose_5798:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5800:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_5803
    adr x0, sign_id
    b cmp_end_5804
cmp_true_5803:
cmp_end_5804:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5801
    adr x0, sign_id
    b cond_end_5802
cond_false_5801:
    adr x0, sign_id
cond_end_5802:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_39
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5805_5806
func_5805:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5810_5811
func_5810:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5812_5813
func_5812:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5814_5815
func_5814:
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
after_func_5814_5815:
    // Closure for func_5814
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5814
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5812_5813:
    // Closure for func_5812
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5812
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5816
do_apply_5817:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5818
do_compose_5816:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5818:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5819
do_apply_5820:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5821
do_compose_5819:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5821:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5810_5811:
    // Closure for func_5810
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5810
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5822_5823
func_5822:
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
after_func_5822_5823:
    // Closure for func_5822
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5822
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5807
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5809
xor_true_5807:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5808
    adr x0, sign_id
    b xor_end_5809
xor_false_5808:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5805_5806:
    // Closure for func_5805
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5805
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5824_5825
func_5824:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5829_5830
func_5829:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5831_5832
func_5831:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5833_5834
func_5833:
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
after_func_5833_5834:
    // Closure for func_5833
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5833
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5831_5832:
    // Closure for func_5831
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5831
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5835
do_apply_5836:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5837
do_compose_5835:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5837:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5838
do_apply_5839:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5840
do_compose_5838:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5840:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5829_5830:
    // Closure for func_5829
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5829
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5841_5842
func_5841:
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
after_func_5841_5842:
    // Closure for func_5841
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5841
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5826
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5828
xor_true_5826:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5827
    adr x0, sign_id
    b xor_end_5828
xor_false_5827:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5824_5825:
    // Closure for func_5824
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5824
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5843_5844
func_5843:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5848_5849
func_5848:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5850_5851
func_5850:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5852_5853
func_5852:
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
after_func_5852_5853:
    // Closure for func_5852
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5852
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5850_5851:
    // Closure for func_5850
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5850
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5854
do_apply_5855:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5856
do_compose_5854:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5856:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5857
do_apply_5858:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5859
do_compose_5857:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5859:
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
    b after_func_5860_5861
func_5860:
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
after_func_5860_5861:
    // Closure for func_5860
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5860
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5845
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5847
xor_true_5845:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5846
    adr x0, sign_id
    b xor_end_5847
xor_false_5846:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5862_5863
func_5862:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5867_5868
func_5867:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5869_5870
func_5869:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5871_5872
func_5871:
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
after_func_5871_5872:
    // Closure for func_5871
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5871
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5869_5870:
    // Closure for func_5869
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5869
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5873
do_apply_5874:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5875
do_compose_5873:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5875:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5876
do_apply_5877:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5878
do_compose_5876:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5878:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5867_5868:
    // Closure for func_5867
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5867
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5879_5880
func_5879:
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
after_func_5879_5880:
    // Closure for func_5879
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5879
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5864
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5866
xor_true_5864:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5865
    adr x0, sign_id
    b xor_end_5866
xor_false_5865:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5862_5863:
    // Closure for func_5862
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5862
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5881_5882
func_5881:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5886_5887
func_5886:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5888_5889
func_5888:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5890_5891
func_5890:
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
after_func_5890_5891:
    // Closure for func_5890
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5890
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5888_5889:
    // Closure for func_5888
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5888
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5892
do_apply_5893:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5894
do_compose_5892:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5894:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5895
do_apply_5896:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5897
do_compose_5895:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5897:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5886_5887:
    // Closure for func_5886
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5886
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5898_5899
func_5898:
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
after_func_5898_5899:
    // Closure for func_5898
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5898
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5883
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5885
xor_true_5883:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5884
    adr x0, sign_id
    b xor_end_5885
xor_false_5884:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5881_5882:
    // Closure for func_5881
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5881
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5900_5901
func_5900:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5905_5906
func_5905:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5907_5908
func_5907:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5909_5910
func_5909:
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
after_func_5909_5910:
    // Closure for func_5909
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5909
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5907_5908:
    // Closure for func_5907
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5907
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5911
do_apply_5912:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5913
do_compose_5911:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5913:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5914
do_apply_5915:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5916
do_compose_5914:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5916:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5905_5906:
    // Closure for func_5905
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5905
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5917_5918
func_5917:
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
after_func_5917_5918:
    // Closure for func_5917
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5917
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5902
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5904
xor_true_5902:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5903
    adr x0, sign_id
    b xor_end_5904
xor_false_5903:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5900_5901:
    // Closure for func_5900
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5900
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5919_5920
func_5919:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5924_5925
func_5924:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5926_5927
func_5926:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5928_5929
func_5928:
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
after_func_5928_5929:
    // Closure for func_5928
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5928
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5926_5927:
    // Closure for func_5926
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5926
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5930
do_apply_5931:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5932
do_compose_5930:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5932:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5933
do_apply_5934:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5935
do_compose_5933:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5935:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5924_5925:
    // Closure for func_5924
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5924
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5936_5937
func_5936:
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
after_func_5936_5937:
    // Closure for func_5936
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5936
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5921
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5923
xor_true_5921:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5922
    adr x0, sign_id
    b xor_end_5923
xor_false_5922:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5919_5920:
    // Closure for func_5919
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5919
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5938_5939
func_5938:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5943_5944
func_5943:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5945_5946
func_5945:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5947_5948
func_5947:
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
after_func_5947_5948:
    // Closure for func_5947
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5947
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5945_5946:
    // Closure for func_5945
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5945
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5949
do_apply_5950:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5951
do_compose_5949:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5951:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5952
do_apply_5953:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5954
do_compose_5952:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5954:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5943_5944:
    // Closure for func_5943
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5943
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5955_5956
func_5955:
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
after_func_5955_5956:
    // Closure for func_5955
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5955
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5940
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5942
xor_true_5940:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5941
    adr x0, sign_id
    b xor_end_5942
xor_false_5941:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5938_5939:
    // Closure for func_5938
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5938
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_5957_5958
func_5957:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5962_5963
func_5962:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_5964_5965
func_5964:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_5966_5967
func_5966:
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
after_func_5966_5967:
    // Closure for func_5966
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5966
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5964_5965:
    // Closure for func_5964
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5964
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_5968
do_apply_5969:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5970
do_compose_5968:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5970:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_5971
do_apply_5972:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5973
do_compose_5971:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5973:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5962_5963:
    // Closure for func_5962
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5962
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_5974_5975
func_5974:
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
after_func_5974_5975:
    // Closure for func_5974
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_5974
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_5959
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5961
xor_true_5959:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_5960
    adr x0, sign_id
    b xor_end_5961
xor_false_5960:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_5957_5958:
    // Closure for func_5957
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_5957
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5976
do_apply_5977:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5978
do_compose_5976:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5978:
    str x0, [sp, #-16]!
    adr x0, b
    cmp x0, #4096
    b.hi do_compose_5979
do_apply_5980:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5981
do_compose_5979:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5981:
    str x0, [sp, #-16]!
    adr x0, after_
    cmp x0, #4096
    b.hi do_compose_5982
do_apply_5983:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5984
do_compose_5982:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5984:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5985
do_apply_5986:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5987
do_compose_5985:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5987:
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, lbl
    cmp x0, #4096
    b.hi do_compose_5988
do_apply_5989:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5990
do_compose_5988:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5990:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5991
do_apply_5992:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5993
do_compose_5991:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5993:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_5994
do_apply_5995:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5996
do_compose_5994:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5996:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_5997
do_apply_5998:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5999
do_compose_5997:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_5999:
    cmp x0, #4096
    b.hi do_compose_6000
do_apply_6001:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6002
do_compose_6000:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6002:
    cmp x0, #4096
    b.hi do_compose_6003
do_apply_6004:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6005
do_compose_6003:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6005:
    cmp x0, #4096
    b.hi do_compose_6006
do_apply_6007:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6008
do_compose_6006:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6008:
    cmp x0, #4096
    b.hi do_compose_6009
do_apply_6010:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6011
do_compose_6009:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6011:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, func_asm
    cmp x0, #4096
    b.hi do_compose_6012
do_apply_6013:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6014
do_compose_6012:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6014:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6015
do_apply_6016:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6017
do_compose_6015:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6017:
    str x0, [sp, #-16]!
    adr x0, after_
    cmp x0, #4096
    b.hi do_compose_6018
do_apply_6019:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6020
do_compose_6018:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6020:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6021
do_apply_6022:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6023
do_compose_6021:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6023:
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, lbl
    cmp x0, #4096
    b.hi do_compose_6026
do_apply_6027:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6028
do_compose_6026:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6028:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6029
do_apply_6030:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6031
do_compose_6029:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6031:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6024
    mov x0, #110
    str x0, [sp, #-16]!
    adr x0, ldr
    cmp x0, #4096
    b.hi do_compose_6032
do_apply_6033:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6034
do_compose_6032:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6034:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_6035
do_apply_6036:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6037
do_compose_6035:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6037:
    str x0, [sp, #-16]!
    adr x0, =
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6038
do_apply_6039:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6040
do_compose_6038:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6040:
    ldr x1, [sp], #16
    bl _cons
    b cond_end_6025
cond_false_6024:
    adr x0, sign_id
cond_end_6025:
    cmp x0, #4096
    b.hi do_compose_6041
do_apply_6042:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6043
do_compose_6041:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6043:
    cmp x0, #4096
    b.hi do_compose_6044
do_apply_6045:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6046
do_compose_6044:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6046:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lbl
    cmp x0, #4096
    b.hi do_compose_6047
do_apply_6048:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6049
do_compose_6047:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6049:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6050
do_apply_6051:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6052
do_compose_6050:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6052:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6053
do_apply_6054:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6055
do_compose_6053:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6055:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6056
do_apply_6057:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6058
do_compose_6056:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6058:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_6059
do_apply_6060:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6061
do_compose_6059:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6061:
    cmp x0, #4096
    b.hi do_compose_6062
do_apply_6063:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6064
do_compose_6062:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6064:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_final
    cmp x0, #4096
    b.hi do_compose_6065
do_apply_6066:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6067
do_compose_6065:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6067:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_6068
do_apply_6069:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6070
do_compose_6068:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6070:
    cmp x0, #4096
    b.hi do_compose_6071
do_apply_6072:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6073
do_compose_6071:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6073:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, lbl
    cmp x0, #4096
    b.hi do_compose_6076
do_apply_6077:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6078
do_compose_6076:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6078:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6079
do_apply_6080:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6081
do_compose_6079:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6081:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6074
    mov x0, #110
    str x0, [sp, #-16]!
    adr x0, stp
    cmp x0, #4096
    b.hi do_compose_6082
do_apply_6083:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6084
do_compose_6082:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6084:
    str x0, [sp, #-16]!
    adr x0, x29
    cmp x0, #4096
    b.hi do_compose_6085
do_apply_6086:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6087
do_compose_6085:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6087:
    str x0, [sp, #-16]!
    adr x0, x30
    str x0, [sp, #-16]!
    adr x0, sp
    str x0, [sp, #-16]!
    adr x0, -
    str x0, [sp, #-16]!
    mov x0, #16
    cmp x0, #4096
    b.hi do_compose_6088
do_apply_6089:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6090
do_compose_6088:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6090:
    ldr x1, [sp], #16
    bl _cons
    bl _factorial
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6091
do_apply_6092:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6093
do_compose_6091:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6093:
    str x0, [sp, #-16]!
    adr x0, mov
    cmp x0, #4096
    b.hi do_compose_6094
do_apply_6095:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6096
do_compose_6094:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6096:
    str x0, [sp, #-16]!
    adr x0, x29
    cmp x0, #4096
    b.hi do_compose_6097
do_apply_6098:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6099
do_compose_6097:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6099:
    str x0, [sp, #-16]!
    adr x0, sp
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6100
do_apply_6101:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6102
do_compose_6100:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6102:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6103
do_apply_6104:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6105
do_compose_6103:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6105:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    b cond_end_6075
cond_false_6074:
    adr x0, sign_id
cond_end_6075:
    cmp x0, #4096
    b.hi do_compose_6106
do_apply_6107:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6108
do_compose_6106:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6108:
    cmp x0, #4096
    b.hi do_compose_6109
do_apply_6110:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6111
do_compose_6109:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6111:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm_body
    cmp x0, #4096
    b.hi do_compose_6112
do_apply_6113:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6114
do_compose_6112:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6114:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6115
do_apply_6116:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6117
do_compose_6115:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6117:
    str x0, [sp, #-16]!
    adr x0, ldp
    cmp x0, #4096
    b.hi do_compose_6118
do_apply_6119:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6120
do_compose_6118:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6120:
    str x0, [sp, #-16]!
    adr x0, x29
    cmp x0, #4096
    b.hi do_compose_6121
do_apply_6122:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6123
do_compose_6121:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6123:
    str x0, [sp, #-16]!
    adr x0, x30
    str x0, [sp, #-16]!
    adr x0, sp
    str x0, [sp, #-16]!
    mov x0, #16
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6124
do_apply_6125:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6126
do_compose_6124:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6126:
    str x0, [sp, #-16]!
    adr x0, ret
    cmp x0, #4096
    b.hi do_compose_6127
do_apply_6128:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6129
do_compose_6127:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6129:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6130
do_apply_6131:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6132
do_compose_6130:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6132:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6133
do_apply_6134:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6135
do_compose_6133:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6135:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_body
    cmp x0, #4096
    b.hi do_compose_6136
do_apply_6137:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6138
do_compose_6136:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6138:
    cmp x0, #4096
    b.hi do_compose_6139
do_apply_6140:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6141
do_compose_6139:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6141:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_body
    cmp x0, #4096
    b.hi do_compose_6142
do_apply_6143:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6144
do_compose_6142:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6144:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, body
    cmp x0, #4096
    b.hi do_compose_6145
do_apply_6146:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6147
do_compose_6145:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6147:
    str x0, [sp, #-16]!
    adr x0, ctx_body
    cmp x0, #4096
    b.hi do_compose_6148
do_apply_6149:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6150
do_compose_6148:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, update_ctx_env
    str x0, [sp, #-16]!
    adr x0, update_ctx_lbl
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_6151
do_apply_6152:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6153
do_compose_6151:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6153:
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_6154
do_apply_6155:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6156
do_compose_6154:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6156:
    cmp x0, #4096
    b.hi do_compose_6157
do_apply_6158:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6159
do_compose_6157:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6159:
    str x0, [sp, #-16]!
    adr x0, new_env
    cmp x0, #4096
    b.hi do_compose_6160
do_apply_6161:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6162
do_compose_6160:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6162:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, param_name
    cmp x0, #4096
    b.hi do_compose_6163
do_apply_6164:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6165
do_compose_6163:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6165:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #16
    cmp x0, #4096
    b.hi do_compose_6166
do_apply_6167:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6168
do_compose_6166:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6168:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_6169
do_apply_6170:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6171
do_compose_6169:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6171:
    cmp x0, #4096
    b.hi do_compose_6172
do_apply_6173:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6174
do_compose_6172:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6174:
    cmp x0, #4096
    b.hi do_compose_6175
do_apply_6176:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6177
do_compose_6175:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6177:
    str x0, [sp, #-16]!
    adr x0, get_env
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_6178
do_apply_6179:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6180
do_compose_6178:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6180:
    cmp x0, #4096
    b.hi do_compose_6181
do_apply_6182:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6183
do_compose_6181:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6183:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_label
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6184
do_apply_6185:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6186
do_compose_6184:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6186:
    str x0, [sp, #-16]!
    adr x0, fn_
    cmp x0, #4096
    b.hi do_compose_6187
do_apply_6188:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6189
do_compose_6187:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6189:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6190
do_apply_6191:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6192
do_compose_6190:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6192:
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6193
do_apply_6194:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6195
do_compose_6193:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6195:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_lbl_cnt
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_6196
do_apply_6197:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6198
do_compose_6196:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6198:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, params
    cmp x0, #4096
    b.hi do_compose_6199
do_apply_6200:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6201
do_compose_6199:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6201:
    cmp x0, #4096
    b.hi do_compose_6202
do_apply_6203:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6204
do_compose_6202:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6204:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_40
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6205
do_apply_6206:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6207
do_compose_6205:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6207:
    str x0, [sp, #-16]!
    adr x0, mov
    cmp x0, #4096
    b.hi do_compose_6208
do_apply_6209:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6210
do_compose_6208:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6210:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_6211
do_apply_6212:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6213
do_compose_6211:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6213:
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, /
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, Invalid
    cmp x0, #4096
    b.hi do_compose_6214
do_apply_6215:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6216
do_compose_6214:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6216:
    str x0, [sp, #-16]!
    adr x0, param
    cmp x0, #4096
    b.hi do_compose_6217
do_apply_6218:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6219
do_compose_6217:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6219:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6220
do_apply_6221:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6222
do_compose_6220:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6222:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6223
do_apply_6224:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6225
do_compose_6223:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6225:
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6226
do_apply_6227:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6228
do_compose_6226:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6228:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_6229
do_apply_6230:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6231
do_compose_6229:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6231:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_6232
do_apply_6233:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6234
do_compose_6232:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6234:
    cmp x0, #4096
    b.hi do_compose_6235
do_apply_6236:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6237
do_compose_6235:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6237:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, params
    cmp x0, #4096
    b.hi do_compose_6238
do_apply_6239:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6240
do_compose_6238:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6240:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_if
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6241
    b after_func_6243_6244
func_6243:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_41
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6243_6244:
    // Closure for func_6243
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6243
    ldr x0, [sp], #16
    bl _cons
    b cond_end_6242
cond_false_6241:
    adr x0, sign_id
cond_end_6242:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6245_6246
func_6245:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6250_6251
func_6250:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6252_6253
func_6252:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6254_6255
func_6254:
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
after_func_6254_6255:
    // Closure for func_6254
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6254
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6252_6253:
    // Closure for func_6252
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6252
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6256
do_apply_6257:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6258
do_compose_6256:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6258:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6259
do_apply_6260:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6261
do_compose_6259:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6261:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6250_6251:
    // Closure for func_6250
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6250
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6262_6263
func_6262:
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
after_func_6262_6263:
    // Closure for func_6262
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6262
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6247
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6249
xor_true_6247:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6248
    adr x0, sign_id
    b xor_end_6249
xor_false_6248:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6245_6246:
    // Closure for func_6245
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6245
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6264_6265
func_6264:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6269_6270
func_6269:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6271_6272
func_6271:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6273_6274
func_6273:
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
after_func_6273_6274:
    // Closure for func_6273
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6273
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6271_6272:
    // Closure for func_6271
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6271
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6275
do_apply_6276:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6277
do_compose_6275:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6277:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6278
do_apply_6279:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6280
do_compose_6278:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6280:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6269_6270:
    // Closure for func_6269
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6269
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6281_6282
func_6281:
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
after_func_6281_6282:
    // Closure for func_6281
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6281
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6266
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6268
xor_true_6266:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6267
    adr x0, sign_id
    b xor_end_6268
xor_false_6267:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6264_6265:
    // Closure for func_6264
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6264
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6283_6284
func_6283:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6288_6289
func_6288:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6290_6291
func_6290:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6292_6293
func_6292:
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
after_func_6292_6293:
    // Closure for func_6292
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6292
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6290_6291:
    // Closure for func_6290
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6290
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6294
do_apply_6295:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6296
do_compose_6294:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6296:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6297
do_apply_6298:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6299
do_compose_6297:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6299:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6288_6289:
    // Closure for func_6288
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6288
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6300_6301
func_6300:
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
after_func_6300_6301:
    // Closure for func_6300
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6300
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6285
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6287
xor_true_6285:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6286
    adr x0, sign_id
    b xor_end_6287
xor_false_6286:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6283_6284:
    // Closure for func_6283
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6283
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6302_6303
func_6302:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6307_6308
func_6307:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6309_6310
func_6309:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6311_6312
func_6311:
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
after_func_6311_6312:
    // Closure for func_6311
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6311
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6309_6310:
    // Closure for func_6309
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6309
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6313
do_apply_6314:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6315
do_compose_6313:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6315:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6316
do_apply_6317:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6318
do_compose_6316:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6318:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6307_6308:
    // Closure for func_6307
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6307
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6319_6320
func_6319:
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
after_func_6319_6320:
    // Closure for func_6319
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6319
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6304
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6306
xor_true_6304:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6305
    adr x0, sign_id
    b xor_end_6306
xor_false_6305:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6302_6303:
    // Closure for func_6302
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6302
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6321_6322
func_6321:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6326_6327
func_6326:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6328_6329
func_6328:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6330_6331
func_6330:
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
after_func_6330_6331:
    // Closure for func_6330
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6330
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6328_6329:
    // Closure for func_6328
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6328
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6332
do_apply_6333:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6334
do_compose_6332:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6334:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6335
do_apply_6336:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6337
do_compose_6335:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6337:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6326_6327:
    // Closure for func_6326
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6326
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6338_6339
func_6338:
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
after_func_6338_6339:
    // Closure for func_6338
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6338
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6323
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6325
xor_true_6323:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6324
    adr x0, sign_id
    b xor_end_6325
xor_false_6324:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6321_6322:
    // Closure for func_6321
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6321
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6340_6341
func_6340:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6345_6346
func_6345:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6347_6348
func_6347:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6349_6350
func_6349:
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
after_func_6349_6350:
    // Closure for func_6349
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6349
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6347_6348:
    // Closure for func_6347
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6347
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6351
do_apply_6352:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6353
do_compose_6351:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6353:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6354
do_apply_6355:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6356
do_compose_6354:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6356:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6345_6346:
    // Closure for func_6345
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6345
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6357_6358
func_6357:
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
after_func_6357_6358:
    // Closure for func_6357
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6357
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6342
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6344
xor_true_6342:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6343
    adr x0, sign_id
    b xor_end_6344
xor_false_6343:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6340_6341:
    // Closure for func_6340
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6340
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6359_6360
func_6359:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6364_6365
func_6364:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6366_6367
func_6366:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6368_6369
func_6368:
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
after_func_6368_6369:
    // Closure for func_6368
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6368
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6366_6367:
    // Closure for func_6366
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6366
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6370
do_apply_6371:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6372
do_compose_6370:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6372:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6373
do_apply_6374:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6375
do_compose_6373:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6375:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6364_6365:
    // Closure for func_6364
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6364
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6376_6377
func_6376:
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
after_func_6376_6377:
    // Closure for func_6376
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6376
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6361
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6363
xor_true_6361:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6362
    adr x0, sign_id
    b xor_end_6363
xor_false_6362:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6359_6360:
    // Closure for func_6359
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6359
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6378_6379
func_6378:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6383_6384
func_6383:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6385_6386
func_6385:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6387_6388
func_6387:
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
after_func_6387_6388:
    // Closure for func_6387
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6387
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6385_6386:
    // Closure for func_6385
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6385
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6389
do_apply_6390:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6391
do_compose_6389:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6391:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6392
do_apply_6393:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6394
do_compose_6392:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6394:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6383_6384:
    // Closure for func_6383
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6383
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6395_6396
func_6395:
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
after_func_6395_6396:
    // Closure for func_6395
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6395
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6380
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6382
xor_true_6380:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6381
    adr x0, sign_id
    b xor_end_6382
xor_false_6381:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6378_6379:
    // Closure for func_6378
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6378
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6397_6398
func_6397:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6402_6403
func_6402:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6404_6405
func_6404:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6406_6407
func_6406:
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
after_func_6406_6407:
    // Closure for func_6406
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6406
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6404_6405:
    // Closure for func_6404
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6404
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6408
do_apply_6409:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6410
do_compose_6408:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6410:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6411
do_apply_6412:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6413
do_compose_6411:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6413:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6402_6403:
    // Closure for func_6402
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6402
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6414_6415
func_6414:
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
after_func_6414_6415:
    // Closure for func_6414
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6414
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6399
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6401
xor_true_6399:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6400
    adr x0, sign_id
    b xor_end_6401
xor_false_6400:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6397_6398:
    // Closure for func_6397
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6397
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_42
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6416_6417
func_6416:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6421_6422
func_6421:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6423_6424
func_6423:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6425_6426
func_6425:
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
after_func_6425_6426:
    // Closure for func_6425
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6425
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6423_6424:
    // Closure for func_6423
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6423
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6427
do_apply_6428:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6429
do_compose_6427:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6429:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6430
do_apply_6431:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6432
do_compose_6430:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6432:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6421_6422:
    // Closure for func_6421
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6421
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6433_6434
func_6433:
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
after_func_6433_6434:
    // Closure for func_6433
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6433
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6418
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6420
xor_true_6418:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6419
    adr x0, sign_id
    b xor_end_6420
xor_false_6419:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6416_6417:
    // Closure for func_6416
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6416
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, asm
    cmp x0, #4096
    b.hi do_compose_6435
do_apply_6436:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6437
do_compose_6435:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6437:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_val
    cmp x0, #4096
    b.hi do_compose_6438
do_apply_6439:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6440
do_compose_6438:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6440:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_6441
do_apply_6442:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6443
do_compose_6441:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6443:
    cmp x0, #4096
    b.hi do_compose_6444
do_apply_6445:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6446
do_compose_6444:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6446:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm_cond
    cmp x0, #4096
    b.hi do_compose_6447
do_apply_6448:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6449
do_compose_6447:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6449:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6450
do_apply_6451:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6452
do_compose_6450:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6452:
    str x0, [sp, #-16]!
    adr x0, cmp
    cmp x0, #4096
    b.hi do_compose_6453
do_apply_6454:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6455
do_compose_6453:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6455:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_6456
do_apply_6457:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6458
do_compose_6456:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6458:
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6459
do_apply_6460:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6461
do_compose_6459:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6461:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6462
do_apply_6463:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6464
do_compose_6462:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6464:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6465
do_apply_6466:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6467
do_compose_6465:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6467:
    str x0, [sp, #-16]!
    adr x0, beq
    cmp x0, #4096
    b.hi do_compose_6468
do_apply_6469:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6470
do_compose_6468:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6470:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6471
do_apply_6472:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6473
do_compose_6471:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6473:
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    cmp x0, #4096
    b.hi do_compose_6474
do_apply_6475:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6476
do_compose_6474:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6476:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6477
do_apply_6478:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6479
do_compose_6477:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6479:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6480
do_apply_6481:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6482
do_compose_6480:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6482:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6483
do_apply_6484:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6485
do_compose_6483:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6485:
    cmp x0, #4096
    b.hi do_compose_6486
do_apply_6487:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6488
do_compose_6486:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6488:
    cmp x0, #4096
    b.hi do_compose_6489
do_apply_6490:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6491
do_compose_6489:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6491:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm_val
    cmp x0, #4096
    b.hi do_compose_6492
do_apply_6493:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6494
do_compose_6492:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6494:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    cmp x0, #4096
    b.hi do_compose_6497
do_apply_6498:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6499
do_compose_6497:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6499:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6500
do_apply_6501:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6502
do_compose_6500:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6502:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6495
    mov x0, #110
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6503
do_apply_6504:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6505
do_compose_6503:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6505:
    b cond_end_6496
cond_false_6495:
    adr x0, sign_id
cond_end_6496:
    cmp x0, #4096
    b.hi do_compose_6506
do_apply_6507:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6508
do_compose_6506:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6508:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_val
    cmp x0, #4096
    b.hi do_compose_6509
do_apply_6510:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6511
do_compose_6509:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6511:
    cmp x0, #4096
    b.hi do_compose_6512
do_apply_6513:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6514
do_compose_6512:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6514:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_val
    cmp x0, #4096
    b.hi do_compose_6515
do_apply_6516:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6517
do_compose_6515:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6517:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_6518
do_apply_6519:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6520
do_compose_6518:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6520:
    str x0, [sp, #-16]!
    adr x0, ctx_cond
    cmp x0, #4096
    b.hi do_compose_6521
do_apply_6522:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6523
do_compose_6521:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6523:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_cond
    cmp x0, #4096
    b.hi do_compose_6524
do_apply_6525:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6526
do_compose_6524:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6526:
    cmp x0, #4096
    b.hi do_compose_6527
do_apply_6528:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6529
do_compose_6527:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6529:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_cond
    cmp x0, #4096
    b.hi do_compose_6530
do_apply_6531:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6532
do_compose_6530:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6532:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, cond
    cmp x0, #4096
    b.hi do_compose_6533
do_apply_6534:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6535
do_compose_6533:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6535:
    str x0, [sp, #-16]!
    adr x0, ctx_lbl
    cmp x0, #4096
    b.hi do_compose_6536
do_apply_6537:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6538
do_compose_6536:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6538:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, update_ctx_lbl
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_6539
do_apply_6540:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6541
do_compose_6539:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6541:
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_6542
do_apply_6543:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6544
do_compose_6542:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6544:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_label
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6545
do_apply_6546:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6547
do_compose_6545:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6547:
    str x0, [sp, #-16]!
    adr x0, if_end_
    cmp x0, #4096
    b.hi do_compose_6548
do_apply_6549:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6550
do_compose_6548:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6550:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6551
do_apply_6552:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6553
do_compose_6551:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6553:
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6554
do_apply_6555:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6556
do_compose_6554:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6556:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_lbl_cnt
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_6557
do_apply_6558:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6559
do_compose_6557:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6559:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_else
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6560
    b after_func_6562_6563
func_6562:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_43
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6562_6563:
    // Closure for func_6562
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6562
    ldr x0, [sp], #16
    bl _cons
    b cond_end_6561
cond_false_6560:
    adr x0, sign_id
cond_end_6561:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_41
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6564_6565
func_6564:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6569_6570
func_6569:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6571_6572
func_6571:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6573_6574
func_6573:
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
after_func_6573_6574:
    // Closure for func_6573
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6573
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6571_6572:
    // Closure for func_6571
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6571
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6575
do_apply_6576:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6577
do_compose_6575:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6577:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6578
do_apply_6579:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6580
do_compose_6578:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6580:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6569_6570:
    // Closure for func_6569
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6569
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6581_6582
func_6581:
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
after_func_6581_6582:
    // Closure for func_6581
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6581
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6566
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6568
xor_true_6566:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6567
    adr x0, sign_id
    b xor_end_6568
xor_false_6567:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6564_6565:
    // Closure for func_6564
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6564
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6583_6584
func_6583:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6588_6589
func_6588:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6590_6591
func_6590:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6592_6593
func_6592:
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
after_func_6592_6593:
    // Closure for func_6592
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6592
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6590_6591:
    // Closure for func_6590
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6590
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6594
do_apply_6595:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6596
do_compose_6594:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6596:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6597
do_apply_6598:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6599
do_compose_6597:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6599:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6588_6589:
    // Closure for func_6588
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6588
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6600_6601
func_6600:
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
after_func_6600_6601:
    // Closure for func_6600
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6600
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6585
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6587
xor_true_6585:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6586
    adr x0, sign_id
    b xor_end_6587
xor_false_6586:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6583_6584:
    // Closure for func_6583
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6583
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6602_6603
func_6602:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6607_6608
func_6607:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6609_6610
func_6609:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6611_6612
func_6611:
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
after_func_6611_6612:
    // Closure for func_6611
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6611
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6609_6610:
    // Closure for func_6609
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6609
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6613
do_apply_6614:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6615
do_compose_6613:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6615:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6616
do_apply_6617:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6618
do_compose_6616:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6618:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6607_6608:
    // Closure for func_6607
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6607
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6619_6620
func_6619:
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
after_func_6619_6620:
    // Closure for func_6619
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6619
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6604
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6606
xor_true_6604:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6605
    adr x0, sign_id
    b xor_end_6606
xor_false_6605:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6602_6603:
    // Closure for func_6602
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6602
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6621_6622
func_6621:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6626_6627
func_6626:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6628_6629
func_6628:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6630_6631
func_6630:
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
after_func_6630_6631:
    // Closure for func_6630
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6630
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6628_6629:
    // Closure for func_6628
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6628
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6632
do_apply_6633:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6634
do_compose_6632:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6634:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6635
do_apply_6636:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6637
do_compose_6635:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6637:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6626_6627:
    // Closure for func_6626
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6626
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6638_6639
func_6638:
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
after_func_6638_6639:
    // Closure for func_6638
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6638
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6623
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6625
xor_true_6623:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6624
    adr x0, sign_id
    b xor_end_6625
xor_false_6624:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6621_6622:
    // Closure for func_6621
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6621
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6640_6641
func_6640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6645_6646
func_6645:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6647_6648
func_6647:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6649_6650
func_6649:
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
after_func_6649_6650:
    // Closure for func_6649
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6649
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6647_6648:
    // Closure for func_6647
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6647
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6651
do_apply_6652:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6653
do_compose_6651:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6653:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6654
do_apply_6655:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6656
do_compose_6654:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6656:
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
    str x0, [sp, #-16]!
    b after_func_6657_6658
func_6657:
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
after_func_6657_6658:
    // Closure for func_6657
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6657
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6642
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6644
xor_true_6642:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6643
    adr x0, sign_id
    b xor_end_6644
xor_false_6643:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6640_6641:
    // Closure for func_6640
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6640
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6659_6660
func_6659:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6664_6665
func_6664:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6666_6667
func_6666:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6668_6669
func_6668:
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
after_func_6668_6669:
    // Closure for func_6668
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6668
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_6670
do_apply_6671:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6672
do_compose_6670:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6672:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6673
do_apply_6674:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6675
do_compose_6673:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6675:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6664_6665:
    // Closure for func_6664
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6664
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6676_6677
func_6676:
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
after_func_6676_6677:
    // Closure for func_6676
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6676
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6661
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6663
xor_true_6661:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6662
    adr x0, sign_id
    b xor_end_6663
xor_false_6662:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6659_6660:
    // Closure for func_6659
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6659
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6678_6679
func_6678:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6683_6684
func_6683:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6685_6686
func_6685:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6687_6688
func_6687:
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
after_func_6687_6688:
    // Closure for func_6687
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6687
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6685_6686:
    // Closure for func_6685
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6685
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6689
do_apply_6690:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6691
do_compose_6689:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6691:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6692
do_apply_6693:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6694
do_compose_6692:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6694:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6683_6684:
    // Closure for func_6683
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6683
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6695_6696
func_6695:
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
after_func_6695_6696:
    // Closure for func_6695
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6695
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6680
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6682
xor_true_6680:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6681
    adr x0, sign_id
    b xor_end_6682
xor_false_6681:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6678_6679:
    // Closure for func_6678
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6678
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6697_6698
func_6697:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6702_6703
func_6702:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6704_6705
func_6704:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6706_6707
func_6706:
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
after_func_6706_6707:
    // Closure for func_6706
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6706
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6704_6705:
    // Closure for func_6704
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6704
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6708
do_apply_6709:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6710
do_compose_6708:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6710:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6711
do_apply_6712:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6713
do_compose_6711:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6713:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6702_6703:
    // Closure for func_6702
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6702
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6714_6715
func_6714:
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
after_func_6714_6715:
    // Closure for func_6714
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6714
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6699
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6701
xor_true_6699:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6700
    adr x0, sign_id
    b xor_end_6701
xor_false_6700:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6697_6698:
    // Closure for func_6697
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6697
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6716_6717
func_6716:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6721_6722
func_6721:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6723_6724
func_6723:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6725_6726
func_6725:
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
after_func_6725_6726:
    // Closure for func_6725
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6725
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6723_6724:
    // Closure for func_6723
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6723
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6727
do_apply_6728:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6729
do_compose_6727:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6729:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6730
do_apply_6731:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6732
do_compose_6730:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6732:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6721_6722:
    // Closure for func_6721
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6721
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6733_6734
func_6733:
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
after_func_6733_6734:
    // Closure for func_6733
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6733
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6718
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6720
xor_true_6718:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6719
    adr x0, sign_id
    b xor_end_6720
xor_false_6719:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6716_6717:
    // Closure for func_6716
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6716
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_44
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_6735_6736
func_6735:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6740_6741
func_6740:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_6742_6743
func_6742:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_6744_6745
func_6744:
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
after_func_6744_6745:
    // Closure for func_6744
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6744
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6742_6743:
    // Closure for func_6742
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6742
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_6746
do_apply_6747:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6748
do_compose_6746:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6748:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6749
do_apply_6750:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6751
do_compose_6749:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6751:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6740_6741:
    // Closure for func_6740
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6740
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_6752_6753
func_6752:
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
after_func_6752_6753:
    // Closure for func_6752
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_6752
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_6737
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_6739
xor_true_6737:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_6738
    adr x0, sign_id
    b xor_end_6739
xor_false_6738:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6735_6736:
    // Closure for func_6735
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6735
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, asm
    cmp x0, #4096
    b.hi do_compose_6754
do_apply_6755:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6756
do_compose_6754:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6756:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ctx_rhs
    cmp x0, #4096
    b.hi do_compose_6757
do_apply_6758:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6759
do_compose_6757:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6759:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_6760
do_apply_6761:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6762
do_compose_6760:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6762:
    cmp x0, #4096
    b.hi do_compose_6763
do_apply_6764:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6765
do_compose_6763:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6765:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm_lhs
    cmp x0, #4096
    b.hi do_compose_6766
do_apply_6767:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6768
do_compose_6766:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6768:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6769
do_apply_6770:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6771
do_compose_6769:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6771:
    str x0, [sp, #-16]!
    adr x0, cmp
    cmp x0, #4096
    b.hi do_compose_6772
do_apply_6773:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6774
do_compose_6772:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6774:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_6775
do_apply_6776:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6777
do_compose_6775:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6777:
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6778
do_apply_6779:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6780
do_compose_6778:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6780:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6781
do_apply_6782:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6783
do_compose_6781:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6783:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6784
do_apply_6785:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6786
do_compose_6784:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6786:
    str x0, [sp, #-16]!
    adr x0, bne
    cmp x0, #4096
    b.hi do_compose_6787
do_apply_6788:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6789
do_compose_6787:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6789:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6790
do_apply_6791:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6792
do_compose_6790:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6792:
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    cmp x0, #4096
    b.hi do_compose_6793
do_apply_6794:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6795
do_compose_6793:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6795:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6796
do_apply_6797:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6798
do_compose_6796:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6798:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6799
do_apply_6800:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6801
do_compose_6799:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6801:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6802
do_apply_6803:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6804
do_compose_6802:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6804:
    cmp x0, #4096
    b.hi do_compose_6805
do_apply_6806:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6807
do_compose_6805:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6807:
    cmp x0, #4096
    b.hi do_compose_6808
do_apply_6809:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6810
do_compose_6808:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6810:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, asm_rhs
    cmp x0, #4096
    b.hi do_compose_6811
do_apply_6812:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6813
do_compose_6811:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6813:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit
    str x0, [sp, #-16]!
    adr x0, str_concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    cmp x0, #4096
    b.hi do_compose_6816
do_apply_6817:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6818
do_compose_6816:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6818:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6819
do_apply_6820:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6821
do_compose_6819:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6821:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6814
    mov x0, #110
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6822
do_apply_6823:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6824
do_compose_6822:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6824:
    b cond_end_6815
cond_false_6814:
    adr x0, sign_id
cond_end_6815:
    cmp x0, #4096
    b.hi do_compose_6825
do_apply_6826:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6827
do_compose_6825:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6827:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs
    cmp x0, #4096
    b.hi do_compose_6828
do_apply_6829:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6830
do_compose_6828:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6830:
    cmp x0, #4096
    b.hi do_compose_6831
do_apply_6832:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6833
do_compose_6831:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6833:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_rhs
    cmp x0, #4096
    b.hi do_compose_6834
do_apply_6835:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6836
do_compose_6834:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6836:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_6837
do_apply_6838:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6839
do_compose_6837:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6839:
    str x0, [sp, #-16]!
    adr x0, ctx_lhs
    cmp x0, #4096
    b.hi do_compose_6840
do_apply_6841:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6842
do_compose_6840:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6842:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_lhs
    cmp x0, #4096
    b.hi do_compose_6843
do_apply_6844:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6845
do_compose_6843:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6845:
    cmp x0, #4096
    b.hi do_compose_6846
do_apply_6847:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6848
do_compose_6846:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6848:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_lhs
    cmp x0, #4096
    b.hi do_compose_6849
do_apply_6850:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6851
do_compose_6849:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6851:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_6852
do_apply_6853:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6854
do_compose_6852:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6854:
    str x0, [sp, #-16]!
    adr x0, ctx_lbl
    cmp x0, #4096
    b.hi do_compose_6855
do_apply_6856:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6857
do_compose_6855:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6857:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, update_ctx_lbl
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_6858
do_apply_6859:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6860
do_compose_6858:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6860:
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_6861
do_apply_6862:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6863
do_compose_6861:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6863:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, make_label
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6864
do_apply_6865:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6866
do_compose_6864:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6866:
    str x0, [sp, #-16]!
    adr x0, else_end_
    cmp x0, #4096
    b.hi do_compose_6867
do_apply_6868:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6869
do_compose_6867:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6869:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6870
do_apply_6871:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6872
do_compose_6870:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6872:
    str x0, [sp, #-16]!
    adr x0, cnt
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6873
do_apply_6874:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6875
do_compose_6873:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6875:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_lbl_cnt
    str x0, [sp, #-16]!
    adr x0, ctx
    cmp x0, #4096
    b.hi do_compose_6876
do_apply_6877:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6878
do_compose_6876:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6878:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_op_asm
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6879
    b after_func_6883_6884
func_6883:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_6885
do_apply_6886:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6887
do_compose_6885:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6887:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_6888
do_apply_6889:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6890
do_compose_6888:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6890:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6883_6884:
    // Closure for func_6883
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6883
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6881
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, add
    cmp x0, #4096
    b.hi do_compose_6891
do_apply_6892:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6893
do_compose_6891:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6893:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_6894
do_apply_6895:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6896
do_compose_6894:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6896:
    str x0, [sp, #-16]!
    adr x0, x0
    str x0, [sp, #-16]!
    adr x0, x1
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6897
do_apply_6898:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6899
do_compose_6897:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6899:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6900
do_apply_6901:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6902
do_compose_6900:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6902:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    b cond_end_6882
cond_false_6881:
    adr x0, sign_id
cond_end_6882:
    b cond_end_6880
cond_false_6879:
    adr x0, sign_id
cond_end_6880:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_6905
do_apply_6906:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6907
do_compose_6905:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6907:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_6908
do_apply_6909:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6910
do_compose_6908:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6910:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6903
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sub
    cmp x0, #4096
    b.hi do_compose_6911
do_apply_6912:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6913
do_compose_6911:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6913:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_6914
do_apply_6915:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6916
do_compose_6914:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6916:
    str x0, [sp, #-16]!
    adr x0, x0
    str x0, [sp, #-16]!
    adr x0, x1
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6917
do_apply_6918:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6919
do_compose_6917:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6919:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6920
do_apply_6921:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6922
do_compose_6920:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6922:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    b cond_end_6904
cond_false_6903:
    adr x0, sign_id
cond_end_6904:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_6925
do_apply_6926:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6927
do_compose_6925:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6927:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    mul x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_6928
do_apply_6929:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6930
do_compose_6928:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6930:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6923
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, mul
    cmp x0, #4096
    b.hi do_compose_6931
do_apply_6932:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6933
do_compose_6931:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6933:
    str x0, [sp, #-16]!
    adr x0, x0
    cmp x0, #4096
    b.hi do_compose_6934
do_apply_6935:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6936
do_compose_6934:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6936:
    str x0, [sp, #-16]!
    adr x0, x0
    str x0, [sp, #-16]!
    adr x0, x1
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6937
do_apply_6938:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6939
do_compose_6937:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6939:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6940
do_apply_6941:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6942
do_compose_6940:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6942:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    b cond_end_6924
cond_false_6923:
    adr x0, sign_id
cond_end_6924:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, nop
    cmp x0, #4096
    b.hi do_compose_6943
do_apply_6944:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6945
do_compose_6943:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6945:
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_6946
do_apply_6947:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6948
do_compose_6946:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6948:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6949
do_apply_6950:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6951
do_compose_6949:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6951:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, append
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6952
    b after_func_6956_6957
func_6956:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6958
    adr x0, sign_id
    b cmp_end_6959
cmp_true_6958:
cmp_end_6959:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6956_6957:
    // Closure for func_6956
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6956
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6954
    adr x0, l2
    b cond_end_6955
cond_false_6954:
    adr x0, sign_id
cond_end_6955:
    b cond_end_6953
cond_false_6952:
    adr x0, sign_id
cond_end_6953:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, l1
    cmp x0, #4096
    b.hi do_compose_6960
do_apply_6961:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6962
do_compose_6960:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6962:
    cmp x0, #4096
    b.hi do_compose_6963
do_apply_6964:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6965
do_compose_6963:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6965:
    str x0, [sp, #-16]!
    adr x0, append
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, l1
    cmp x0, #4096
    b.hi do_compose_6966
do_apply_6967:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6968
do_compose_6966:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6968:
    cmp x0, #4096
    b.hi do_compose_6969
do_apply_6970:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6971
do_compose_6969:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6971:
    str x0, [sp, #-16]!
    adr x0, l2
    cmp x0, #4096
    b.hi do_compose_6972
do_apply_6973:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6974
do_compose_6972:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6974:
    cmp x0, #4096
    b.hi do_compose_6975
do_apply_6976:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6977
do_compose_6975:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6977:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, main
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6978
    b after_func_6982_6983
func_6982:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, src
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_6982_6983:
    // Closure for func_6982
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_6982
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6980
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    add x0, x1, x0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6984
    adr x0, sign_id
    b cmp_end_6985
cmp_true_6984:
cmp_end_6985:
    cmp x0, #4096
    b.hi do_compose_6986
do_apply_6987:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6988
do_compose_6986:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6988:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6989
do_apply_6990:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6991
do_compose_6989:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6991:
    b cond_end_6981
cond_false_6980:
    adr x0, sign_id
cond_end_6981:
    b cond_end_6979
cond_false_6978:
    adr x0, sign_id
cond_end_6979:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_6994
do_apply_6995:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6996
do_compose_6994:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6996:
    str x0, [sp, #-16]!
    adr x0, Source
    cmp x0, #4096
    b.hi do_compose_6997
do_apply_6998:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6999
do_compose_6997:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6999:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_6992
    adr x0, "
    ldr x0, [x0]
    b cond_end_6993
cond_false_6992:
    adr x0, sign_id
cond_end_6993:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str_ln
    str x0, [sp, #-16]!
    adr x0, src
    cmp x0, #4096
    b.hi do_compose_7000
do_apply_7001:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7002
do_compose_7000:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7002:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tokenize
    str x0, [sp, #-16]!
    adr x0, src
    cmp x0, #4096
    b.hi do_compose_7003
do_apply_7004:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7005
do_compose_7003:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7005:
    adr x1, tokens
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str_ln
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, -
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, Tokens
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, -
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_7006
do_apply_7007:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7008
do_compose_7006:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7008:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_tokens
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7009
do_apply_7010:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7011
do_compose_7009:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7011:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7012
do_apply_7013:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7014
do_compose_7012:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7014:
    adr x1, ast_res
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, ast_res
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7015
do_apply_7016:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7017
do_compose_7015:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7017:
    adr x1, ast
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str_ln
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, -
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, AST
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_7018
do_apply_7019:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7020
do_compose_7018:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7020:
    str x0, [sp, #-16]!
    adr x0, Parsed
    str x0, [sp, #-16]!
    adr x0, -
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_7021
do_apply_7022:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7023
do_compose_7021:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7023:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, ast
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7024
do_apply_7025:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7026
do_compose_7024:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7026:
    adr x1, asm_res
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, asm_res
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7027
do_apply_7028:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7029
do_compose_7027:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7029:
    adr x1, asm
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str_ln
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, -
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, Assembly
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, -
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_7030
do_apply_7031:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7032
do_compose_7030:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7032:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_list_str
    str x0, [sp, #-16]!
    adr x0, asm
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7033
do_apply_7034:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7035
do_compose_7033:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7035:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str_ln
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, -
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, End
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, -
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_7036
do_apply_7037:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7038
do_compose_7036:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7038:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_tokens
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7039
    b after_func_7043_7044
func_7043:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_7045
    adr x0, sign_id
    b cmp_end_7046
cmp_true_7045:
cmp_end_7046:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_7043_7044:
    // Closure for func_7043
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_7043
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7041
    mov x0, #0
    b cond_end_7042
cond_false_7041:
    adr x0, sign_id
cond_end_7042:
    b cond_end_7040
cond_false_7039:
    adr x0, sign_id
cond_end_7040:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, toks
    cmp x0, #4096
    b.hi do_compose_7047
do_apply_7048:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7049
do_compose_7047:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7049:
    adr x1, tok
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7050
do_apply_7051:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7052
do_compose_7050:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7052:
    adr x1, type
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_7055
    adr x0, sign_id
    b cmp_end_7056
cmp_true_7055:
cmp_end_7056:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7053
    adr x0, sign_id
    b cond_end_7054
cond_false_7053:
    adr x0, sign_id
cond_end_7054:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str_ln
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7057
do_apply_7058:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7059
do_compose_7057:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7059:
    str x0, [sp, #-16]!
    adr x0, EOF
    cmp x0, #4096
    b.hi do_compose_7060
do_apply_7061:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7062
do_compose_7060:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7062:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7063
do_apply_7064:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7065
do_compose_7063:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7065:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7066
do_apply_7067:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7068
do_compose_7066:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7068:
    cmp x0, #4096
    b.hi do_compose_7069
do_apply_7070:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7071
do_compose_7069:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7071:
    adr x1, val
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_45
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_46
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7074
do_apply_7075:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7076
do_compose_7074:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7076:
    str x0, [sp, #-16]!
    adr x0, Tok
    cmp x0, #4096
    b.hi do_compose_7077
do_apply_7078:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7079
do_compose_7077:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7079:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7072
    adr x0, "
    ldr x0, [x0]
    b cond_end_7073
cond_false_7072:
    adr x0, sign_id
cond_end_7073:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_num
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7080
do_apply_7081:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7082
do_compose_7080:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7082:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7085
do_apply_7086:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7087
do_compose_7085:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7087:
    str x0, [sp, #-16]!
    adr x0, Val
    cmp x0, #4096
    b.hi do_compose_7088
do_apply_7089:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7090
do_compose_7088:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7090:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7083
    adr x0, "
    ldr x0, [x0]
    b cond_end_7084
cond_false_7083:
    adr x0, sign_id
cond_end_7084:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #5
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_7093
    adr x0, sign_id
    b cmp_end_7094
cmp_true_7093:
cmp_end_7094:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7091
    adr x0, print_char
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7095
do_apply_7096:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7097
do_compose_7095:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7097:
    b cond_end_7092
cond_false_7091:
    adr x0, sign_id
cond_end_7092:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #5
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_7100
    adr x0, sign_id
    b cmp_end_7101
cmp_true_7100:
cmp_end_7101:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7098
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_7102
do_apply_7103:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7104
do_compose_7102:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7104:
    b cond_end_7099
cond_false_7098:
    adr x0, sign_id
cond_end_7099:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_7105
do_apply_7106:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7107
do_compose_7105:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7107:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_tokens
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, toks
    cmp x0, #4096
    b.hi do_compose_7108
do_apply_7109:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7110
do_compose_7108:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7110:
    cmp x0, #4096
    b.hi do_compose_7111
do_apply_7112:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_7113
do_compose_7111:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_7113:
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
p: .quad 0
cnt: .quad 0
char: .quad 0
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
": .quad 0
Target: .quad 0
tokens: .quad 0
ast_res: .quad 0
ast: .quad 0
asm_res: .quad 0
asm: .quad 0
tok: .quad 0
type: .quad 0
val: .quad 0


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

