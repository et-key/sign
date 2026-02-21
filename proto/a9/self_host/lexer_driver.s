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

    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Self
    str x0, [sp, #-16]!
    adr x0, Hosting
    ldr x1, [sp], #16
    sub x0, x1, x0
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
    str x0, [sp, #-16]!
    adr x0, Lexer
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
    adr x0, Ported
    str x0, [sp, #-16]!
    adr x0, from
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_11
    tst x0, #1
    b.ne do_compose_9
do_apply_10:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_12
do_compose_9:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_12
do_concat_11:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_12:
    str x0, [sp, #-16]!
    adr x0, prepare_lexer
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_15
    tst x0, #1
    b.ne do_compose_13
do_apply_14:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_16
do_compose_13:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_16
do_concat_15:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_16:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_19
    tst x0, #1
    b.ne do_compose_17
do_apply_18:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_20
do_compose_17:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_20
do_concat_19:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_20:
    str x0, [sp, #-16]!
    adr x0, js
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x1, [sp], #16
    sdiv x0, x1, x0
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
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_27
    tst x0, #1
    b.ne do_compose_25
do_apply_26:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_28
do_compose_25:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_28
do_concat_27:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_28:
    str x0, [sp, #-16]!
    adr x0, js
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_31
    tst x0, #1
    b.ne do_compose_29
do_apply_30:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_32
do_compose_29:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_32
do_concat_31:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_32:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_33
    b after_func_39_40
func_39:
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
    b.ne blk_end_41
    adr x0, src_len
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_44
    tst x0, #1
    b.ne do_compose_42
do_apply_43:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_45
do_compose_42:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_45
do_concat_44:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_45:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_41
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_41
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_48
    tst x0, #1
    b.ne do_compose_46
do_apply_47:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_49
do_compose_46:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_49
do_concat_48:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_49:
blk_end_41:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_39_40:
    // Closure for func_39
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_39
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
    adr x0, read_char
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_54
    tst x0, #1
    b.ne do_compose_52
do_apply_53:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_55
do_compose_52:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_55
do_concat_54:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_55:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_50
    b after_func_56_57
func_56:
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
    b.ne blk_end_58
    adr x0, p
    str x0, [sp, #-16]!
    adr x0, src_len
    ldr x0, [x0] // @ load
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_61
    adr x0, sign_id
    b cmp_end_62
cmp_true_61:
cmp_end_62:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_59
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, ch
    str x0, [sp, #-16]!
    mov x0, #-1
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_63
    mov x0, #0
blk_end_63:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_66
    tst x0, #1
    b.ne do_compose_64
do_apply_65:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_67
do_compose_64:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_67
do_concat_66:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_67:
    b cond_end_60
cond_false_59:
    adr x0, sign_id
cond_end_60:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_58
    adr x0, c
    str x0, [sp, #-16]!
    adr x0, nth
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_58
    adr x0, src
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, p
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_70
    tst x0, #1
    b.ne do_compose_68
do_apply_69:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_71
do_compose_68:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_71
do_concat_70:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_71:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_58
    adr x0, ch
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_58
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
    b.ne blk_end_58
    adr x0, c
blk_end_58:
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
    b cond_end_51
cond_false_50:
    adr x0, sign_id
cond_end_51:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_space
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_72
    b after_func_78_79
func_78:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_84
    adr x0, sign_id
    b cmp_end_85
cmp_true_84:
cmp_end_85:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_82
    b or_end_83
or_right_82:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_86
    adr x0, sign_id
    b cmp_end_87
cmp_true_86:
cmp_end_87:
or_end_83:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_80
    b or_end_81
or_right_80:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_88
    adr x0, sign_id
    b cmp_end_89
cmp_true_88:
cmp_end_89:
or_end_81:
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
    b cond_end_73
cond_false_72:
    adr x0, sign_id
cond_end_73:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_digit
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_94
    tst x0, #1
    b.ne do_compose_92
do_apply_93:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_95
do_compose_92:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_95
do_concat_94:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_95:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_90
    b after_func_96_97
func_96:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_100
    adr x0, sign_id
    b cmp_end_101
cmp_true_100:
cmp_end_101:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_98
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_102
    adr x0, sign_id
    b cmp_end_103
cmp_true_102:
cmp_end_103:
    b and_end_99
and_fail_98:
    adr x0, sign_id
and_end_99:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_96_97:
    // Closure for func_96
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_96
    ldr x0, [sp], #16
    bl _cons
    b cond_end_91
cond_false_90:
    adr x0, sign_id
cond_end_91:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_alpha
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_108
    tst x0, #1
    b.ne do_compose_106
do_apply_107:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_109
do_compose_106:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_109
do_concat_108:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_109:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_104
    b after_func_110_111
func_110:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_118
    adr x0, sign_id
    b cmp_end_119
cmp_true_118:
cmp_end_119:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_116
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_120
    adr x0, sign_id
    b cmp_end_121
cmp_true_120:
cmp_end_121:
    b and_end_117
and_fail_116:
    adr x0, sign_id
and_end_117:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_114
    b or_end_115
or_right_114:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_124
    adr x0, sign_id
    b cmp_end_125
cmp_true_124:
cmp_end_125:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_122
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_126
    adr x0, sign_id
    b cmp_end_127
cmp_true_126:
cmp_end_127:
    b and_end_123
and_fail_122:
    adr x0, sign_id
and_end_123:
or_end_115:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_112
    b or_end_113
or_right_112:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_128
    adr x0, sign_id
    b cmp_end_129
cmp_true_128:
cmp_end_129:
or_end_113:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_110_111:
    // Closure for func_110
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_110
    ldr x0, [sp], #16
    bl _cons
    b cond_end_105
cond_false_104:
    adr x0, sign_id
cond_end_105:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_op_char
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
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_168
    adr x0, sign_id
    b cmp_end_169
cmp_true_168:
cmp_end_169:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_166
    b or_end_167
or_right_166:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_170
    adr x0, sign_id
    b cmp_end_171
cmp_true_170:
cmp_end_171:
or_end_167:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_164
    b or_end_165
or_right_164:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_172
    adr x0, sign_id
    b cmp_end_173
cmp_true_172:
cmp_end_173:
or_end_165:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_162
    b or_end_163
or_right_162:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_174
    adr x0, sign_id
    b cmp_end_175
cmp_true_174:
cmp_end_175:
or_end_163:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_160
    b or_end_161
or_right_160:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_176
    adr x0, sign_id
    b cmp_end_177
cmp_true_176:
cmp_end_177:
or_end_161:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_158
    b or_end_159
or_right_158:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_178
    adr x0, sign_id
    b cmp_end_179
cmp_true_178:
cmp_end_179:
or_end_159:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_156
    b or_end_157
or_right_156:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_180
    adr x0, sign_id
    b cmp_end_181
cmp_true_180:
cmp_end_181:
or_end_157:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_154
    b or_end_155
or_right_154:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_182
    adr x0, sign_id
    b cmp_end_183
cmp_true_182:
cmp_end_183:
or_end_155:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_152
    b or_end_153
or_right_152:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_184
    adr x0, sign_id
    b cmp_end_185
cmp_true_184:
cmp_end_185:
or_end_153:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_150
    b or_end_151
or_right_150:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_186
    adr x0, sign_id
    b cmp_end_187
cmp_true_186:
cmp_end_187:
or_end_151:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_148
    b or_end_149
or_right_148:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_188
    adr x0, sign_id
    b cmp_end_189
cmp_true_188:
cmp_end_189:
or_end_149:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_146
    b or_end_147
or_right_146:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_190
    adr x0, sign_id
    b cmp_end_191
cmp_true_190:
cmp_end_191:
or_end_147:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_144
    b or_end_145
or_right_144:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_192
    adr x0, sign_id
    b cmp_end_193
cmp_true_192:
cmp_end_193:
or_end_145:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_142
    b or_end_143
or_right_142:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_194
    adr x0, sign_id
    b cmp_end_195
cmp_true_194:
cmp_end_195:
or_end_143:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_140
    b or_end_141
or_right_140:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_196
    adr x0, sign_id
    b cmp_end_197
cmp_true_196:
cmp_end_197:
or_end_141:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_138
    b or_end_139
or_right_138:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_198
    adr x0, sign_id
    b cmp_end_199
cmp_true_198:
cmp_end_199:
or_end_139:
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
    adr x0, length
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_204
    tst x0, #1
    b.ne do_compose_202
do_apply_203:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_205
do_compose_202:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_205
do_concat_204:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_205:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_200
    b after_func_206_207
func_206:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_211
    adr x0, sign_id
    b cmp_end_212
cmp_true_211:
cmp_end_212:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_209
    mov x0, #0
    b cond_end_210
cond_false_209:
    adr x0, sign_id
cond_end_210:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_208
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
    b.eq do_concat_215
    tst x0, #1
    b.ne do_compose_213
do_apply_214:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_216
do_compose_213:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_216
do_concat_215:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_216:
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
blk_end_208:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_206_207:
    // Closure for func_206
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_206
    ldr x0, [sp], #16
    bl _cons
    b cond_end_201
cond_false_200:
    adr x0, sign_id
cond_end_201:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, list_to_string
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_225
    tst x0, #1
    b.ne do_compose_223
do_apply_224:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_226
do_compose_223:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_226
do_concat_225:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_226:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_221
    b after_func_227_228
func_227:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, length
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_229
    adr x0, alloc
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_229
    adr x0, _write_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.ne blk_end_229
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
    b.ne blk_end_229
    ldr x0, [x29, #-64]
blk_end_229:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_227_228:
    // Closure for func_227
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_227
    ldr x0, [sp], #16
    bl _cons
    b cond_end_222
cond_false_221:
    adr x0, sign_id
cond_end_222:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _write_list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_254
    tst x0, #1
    b.ne do_compose_252
do_apply_253:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_255
do_compose_252:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_255
do_concat_254:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_255:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_250
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
    b after_func_260_261
func_260:
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
    b.eq cmp_true_265
    adr x0, sign_id
    b cmp_end_266
cmp_true_265:
cmp_end_266:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_263
    mov x0, #0
    b cond_end_264
cond_false_263:
    adr x0, sign_id
cond_end_264:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_262
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
    b.eq do_concat_269
    tst x0, #1
    b.ne do_compose_267
do_apply_268:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_270
do_compose_267:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_270
do_concat_269:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_270:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_262
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_273
    tst x0, #1
    b.ne do_compose_271
do_apply_272:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_274
do_compose_271:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_274
do_concat_273:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_274:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_277
    tst x0, #1
    b.ne do_compose_275
do_apply_276:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_278
do_compose_275:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_278
do_concat_277:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_278:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_285
    tst x0, #1
    b.ne do_compose_283
do_apply_284:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_286
do_compose_283:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_286
do_concat_285:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_286:
blk_end_262:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_260_261:
    // Closure for func_260
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
    adr x1, func_260
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_251
cond_false_250:
    adr x0, sign_id
cond_end_251:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tokenize
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
    adr x0, scan
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_298
    tst x0, #1
    b.ne do_compose_296
do_apply_297:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_299
do_compose_296:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_299
do_concat_298:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_299:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_295
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_295
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
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
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_306
    tst x0, #1
    b.ne do_compose_304
do_apply_305:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_307
do_compose_304:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_307
do_concat_306:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_307:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_310
    tst x0, #1
    b.ne do_compose_308
do_apply_309:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_311
do_compose_308:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_311
do_concat_310:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_311:
    b cond_end_301
cond_false_300:
    adr x0, sign_id
cond_end_301:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_295
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_314
    tst x0, #1
    b.ne do_compose_312
do_apply_313:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_315
do_compose_312:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_315
do_concat_314:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_315:
    str x0, [sp, #-16]!
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_318
    tst x0, #1
    b.ne do_compose_316
do_apply_317:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_319
do_compose_316:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_319
do_concat_318:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_319:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_322
    tst x0, #1
    b.ne do_compose_320
do_apply_321:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_323
do_compose_320:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_323
do_concat_322:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_323:
blk_end_295:
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
    adr x0, scan
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_324
    b after_func_330_331
func_330:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    adr x0, ch
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_339
    adr x0, sign_id
    b cmp_end_340
cmp_true_339:
cmp_end_340:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_337
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
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
    mov x0, #0
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
    b cond_end_338
cond_false_337:
    adr x0, sign_id
cond_end_338:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    adr x0, is_digit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x0, scan_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_357
    tst x0, #1
    b.ne do_compose_355
do_apply_356:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_358
do_compose_355:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_358
do_concat_357:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_358:
    b cond_end_350
cond_false_349:
    adr x0, sign_id
cond_end_350:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_363
    tst x0, #1
    b.ne do_compose_361
do_apply_362:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_364
do_compose_361:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_364
do_concat_363:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_364:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_359
    adr x0, scan_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_367
    tst x0, #1
    b.ne do_compose_365
do_apply_366:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_368
do_compose_365:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_368
do_concat_367:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_368:
    b cond_end_360
cond_false_359:
    adr x0, sign_id
cond_end_360:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_369
    adr x0, scan_op
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_370
cond_false_369:
    adr x0, sign_id
cond_end_370:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_381
    adr x0, sign_id
    b cmp_end_382
cmp_true_381:
cmp_end_382:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_379
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_385
    tst x0, #1
    b.ne do_compose_383
do_apply_384:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_386
do_compose_383:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_386
do_concat_385:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_386:
    b cond_end_380
cond_false_379:
    adr x0, sign_id
cond_end_380:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_389
    adr x0, sign_id
    b cmp_end_390
cmp_true_389:
cmp_end_390:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_387
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_394
    tst x0, #1
    b.ne do_compose_392
do_apply_393:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_395
do_compose_392:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_395
do_concat_394:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_395:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_391
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_398
    tst x0, #1
    b.ne do_compose_396
do_apply_397:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_399
do_compose_396:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_399
do_concat_398:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_399:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_402
    tst x0, #1
    b.ne do_compose_400
do_apply_401:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_403
do_compose_400:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_403
do_concat_402:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_403:
blk_end_391:
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
    b cond_end_388
cond_false_387:
    adr x0, sign_id
cond_end_388:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.ne blk_end_332
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_414
    tst x0, #1
    b.ne do_compose_412
do_apply_413:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_415
do_compose_412:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_415
do_concat_414:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_415:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_418
    tst x0, #1
    b.ne do_compose_416
do_apply_417:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_419
do_compose_416:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_419
do_concat_418:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_419:
blk_end_332:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_330_331:
    // Closure for func_330
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_330
    ldr x0, [sp], #16
    bl _cons
    b cond_end_325
cond_false_324:
    adr x0, sign_id
cond_end_325:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, skip_space
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
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x0, [x0] // @ load
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_433
    tst x0, #1
    b.ne do_compose_431
do_apply_432:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_434
do_compose_431:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_434
do_concat_433:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_434:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_429
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_438
    tst x0, #1
    b.ne do_compose_436
do_apply_437:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_439
do_compose_436:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_439
do_concat_438:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_439:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_435
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_442
    tst x0, #1
    b.ne do_compose_440
do_apply_441:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_443
do_compose_440:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_443
do_concat_442:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_443:
blk_end_435:
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
    b cond_end_430
cond_false_429:
    adr x0, sign_id
cond_end_430:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_428
    mov x0, #0
blk_end_428:
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
    adr x0, scan_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_452
    tst x0, #1
    b.ne do_compose_450
do_apply_451:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_453
do_compose_450:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_453
do_concat_452:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_453:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_448
    b after_func_454_455
func_454:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_459
    tst x0, #1
    b.ne do_compose_457
do_apply_458:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_460
do_compose_457:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_460
do_concat_459:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_460:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_456
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_463
    tst x0, #1
    b.ne do_compose_461
do_apply_462:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_464
do_compose_461:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_464
do_concat_463:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_464:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_456
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_467
    tst x0, #1
    b.ne do_compose_465
do_apply_466:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_468
do_compose_465:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_468
do_concat_467:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_468:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_471
    tst x0, #1
    b.ne do_compose_469
do_apply_470:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_472
do_compose_469:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_472
do_concat_471:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_472:
blk_end_456:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_454_455:
    // Closure for func_454
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_454
    ldr x0, [sp], #16
    bl _cons
    b cond_end_449
cond_false_448:
    adr x0, sign_id
cond_end_449:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_473
    b after_func_479_480
func_479:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_484
    b or_end_485
or_right_484:
    adr x0, is_digit
or_end_485:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_488
    tst x0, #1
    b.ne do_compose_486
do_apply_487:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_489
do_compose_486:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_489
do_concat_488:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_489:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_492
    tst x0, #1
    b.ne do_compose_490
do_apply_491:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_493
do_compose_490:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_493
do_concat_492:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_493:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_482
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_504
    tst x0, #1
    b.ne do_compose_502
do_apply_503:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_505
do_compose_502:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_505
do_concat_504:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_505:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_508
    tst x0, #1
    b.ne do_compose_506
do_apply_507:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_509
do_compose_506:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_509
do_concat_508:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_509:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_512
    tst x0, #1
    b.ne do_compose_510
do_apply_511:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_513
do_compose_510:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_513
do_concat_512:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_513:
    b cond_end_483
cond_false_482:
    adr x0, sign_id
cond_end_483:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_481
    mov x0, #0
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
    b cond_end_474
cond_false_473:
    adr x0, sign_id
cond_end_474:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_num
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_518
    tst x0, #1
    b.ne do_compose_516
do_apply_517:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_519
do_compose_516:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_519
do_concat_518:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_519:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_514
    b after_func_520_521
func_520:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_524
    tst x0, #1
    b.ne do_compose_522
do_apply_523:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_525
do_compose_522:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_525
do_concat_524:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_525:
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_528
    tst x0, #1
    b.ne do_compose_526
do_apply_527:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_529
do_compose_526:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_529
do_concat_528:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_529:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_532
    tst x0, #1
    b.ne do_compose_530
do_apply_531:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_533
do_compose_530:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_533
do_concat_532:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_533:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_536
    tst x0, #1
    b.ne do_compose_534
do_apply_535:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_537
do_compose_534:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_537
do_concat_536:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_537:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_520_521:
    // Closure for func_520
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_520
    ldr x0, [sp], #16
    bl _cons
    b cond_end_515
cond_false_514:
    adr x0, sign_id
cond_end_515:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_542
    tst x0, #1
    b.ne do_compose_540
do_apply_541:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_543
do_compose_540:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_543
do_concat_542:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_543:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_538
    b after_func_544_545
func_544:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_546_547
func_546:
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
    b.eq do_concat_553
    tst x0, #1
    b.ne do_compose_551
do_apply_552:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_554
do_compose_551:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_554
do_concat_553:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_554:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_549
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_555
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_558
    tst x0, #1
    b.ne do_compose_556
do_apply_557:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_559
do_compose_556:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_559
do_concat_558:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_559:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_562
    tst x0, #1
    b.ne do_compose_560
do_apply_561:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_563
do_compose_560:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_563
do_concat_562:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_563:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_566
    tst x0, #1
    b.ne do_compose_564
do_apply_565:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_567
do_compose_564:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_567
do_concat_566:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_567:
blk_end_555:
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
    b cond_end_550
cond_false_549:
    adr x0, sign_id
cond_end_550:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_548
    ldr x0, [x29, #-32]
blk_end_548:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_546_547:
    // Closure for func_546
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_546
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_544_545:
    // Closure for func_544
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_544
    ldr x0, [sp], #16
    bl _cons
    b cond_end_539
cond_false_538:
    adr x0, sign_id
cond_end_539:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_op
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_576
    tst x0, #1
    b.ne do_compose_574
do_apply_575:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_577
do_compose_574:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_577
do_concat_576:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_577:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_572
    b after_func_578_579
func_578:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x0, [x0] // @ load
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_583
    tst x0, #1
    b.ne do_compose_581
do_apply_582:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_584
do_compose_581:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_584
do_concat_583:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_584:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_580
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_587
    tst x0, #1
    b.ne do_compose_585
do_apply_586:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_588
do_compose_585:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_588
do_concat_587:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_588:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_580
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_591
    tst x0, #1
    b.ne do_compose_589
do_apply_590:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_592
do_compose_589:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_592
do_concat_591:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_592:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_595
    tst x0, #1
    b.ne do_compose_593
do_apply_594:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_596
do_compose_593:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_596
do_concat_595:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_596:
blk_end_580:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_578_579:
    // Closure for func_578
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_578
    ldr x0, [sp], #16
    bl _cons
    b cond_end_573
cond_false_572:
    adr x0, sign_id
cond_end_573:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_597
    b after_func_603_604
func_603:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_610
    tst x0, #1
    b.ne do_compose_608
do_apply_609:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_611
do_compose_608:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_611
do_concat_610:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_611:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_606
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_618
    tst x0, #1
    b.ne do_compose_616
do_apply_617:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_619
do_compose_616:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_619
do_concat_618:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_619:
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
    b cond_end_607
cond_false_606:
    adr x0, sign_id
cond_end_607:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_605
    mov x0, #0
blk_end_605:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_603_604:
    // Closure for func_603
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_603
    ldr x0, [sp], #16
    bl _cons
    b cond_end_598
cond_false_597:
    adr x0, sign_id
cond_end_598:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_str
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_636
    tst x0, #1
    b.ne do_compose_634
do_apply_635:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_637
do_compose_634:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_637
do_concat_636:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_637:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_632
    b after_func_638_639
func_638:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_643
    tst x0, #1
    b.ne do_compose_641
do_apply_642:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_644
do_compose_641:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_644
do_concat_643:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_644:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_640
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_647
    tst x0, #1
    b.ne do_compose_645
do_apply_646:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_648
do_compose_645:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_648
do_concat_647:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_648:
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_640
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_655
    tst x0, #1
    b.ne do_compose_653
do_apply_654:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_656
do_compose_653:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_656
do_concat_655:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_656:
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
blk_end_640:
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
    b cond_end_633
cond_false_632:
    adr x0, sign_id
cond_end_633:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
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
    b after_func_671_672
func_671:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_678
    adr x0, sign_id
    b cmp_end_679
cmp_true_678:
cmp_end_679:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_676
    b or_end_677
or_right_676:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_680
    adr x0, sign_id
    b cmp_end_681
cmp_true_680:
cmp_end_681:
or_end_677:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_674
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_685
    tst x0, #1
    b.ne do_compose_683
do_apply_684:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_686
do_compose_683:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_686
do_concat_685:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_686:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_682
    mov x0, #0
blk_end_682:
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
    b cond_end_675
cond_false_674:
    adr x0, sign_id
cond_end_675:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_673
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_697
    tst x0, #1
    b.ne do_compose_695
do_apply_696:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_698
do_compose_695:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_698
do_concat_697:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_698:
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_705
    tst x0, #1
    b.ne do_compose_703
do_apply_704:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_706
do_compose_703:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_706
do_concat_705:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_706:
blk_end_673:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_671_672:
    // Closure for func_671
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_671
    ldr x0, [sp], #16
    bl _cons
    b cond_end_666
cond_false_665:
    adr x0, sign_id
cond_end_666:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, main
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_711
    tst x0, #1
    b.ne do_compose_709
do_apply_710:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_712
do_compose_709:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_712
do_concat_711:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_712:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_707
    b after_func_713_714
func_713:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_0
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_715
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_1
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
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_715
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_715
    adr x0, init_lexer
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_715
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_734
    tst x0, #1
    b.ne do_compose_732
do_apply_733:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_735
do_compose_732:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_735
do_concat_734:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_735:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_715
    adr x0, _process_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_738
    tst x0, #1
    b.ne do_compose_736
do_apply_737:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_739
do_compose_736:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_739
do_concat_738:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_739:
blk_end_715:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_713_714:
    // Closure for func_713
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_713
    ldr x0, [sp], #16
    bl _cons
    b cond_end_708
cond_false_707:
    adr x0, sign_id
cond_end_708:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _process_list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_744
    tst x0, #1
    b.ne do_compose_742
do_apply_743:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_745
do_compose_742:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_745
do_concat_744:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_745:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_740
    b after_func_746_747
func_746:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_751
    adr x0, sign_id
    b cmp_end_752
cmp_true_751:
cmp_end_752:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_749
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_2
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_756
    tst x0, #1
    b.ne do_compose_754
do_apply_755:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_757
do_compose_754:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_757
do_concat_756:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_757:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_753
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_753
    mov x0, #0
blk_end_753:
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
    b cond_end_750
cond_false_749:
    adr x0, sign_id
cond_end_750:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_748
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_748
    adr x0, _print_token
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_768
    tst x0, #1
    b.ne do_compose_766
do_apply_767:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_769
do_compose_766:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_769
do_concat_768:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_769:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_748
    adr x0, _process_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
blk_end_748:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_746_747:
    // Closure for func_746
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_746
    ldr x0, [sp], #16
    bl _cons
    b cond_end_741
cond_false_740:
    adr x0, sign_id
cond_end_741:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _print_token
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_782
    tst x0, #1
    b.ne do_compose_780
do_apply_781:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_783
do_compose_780:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_783
do_concat_782:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_783:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_778
    b after_func_784_785
func_784:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_786
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_789
    adr x0, sign_id
    b cmp_end_790
cmp_true_789:
cmp_end_790:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_787
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_3
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_794
    tst x0, #1
    b.ne do_compose_792
do_apply_793:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_795
do_compose_792:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_795
do_concat_794:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_795:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_791
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_798
    tst x0, #1
    b.ne do_compose_796
do_apply_797:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_799
do_compose_796:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_799
do_concat_798:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_799:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_791
    mov x0, #0
blk_end_791:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_802
    tst x0, #1
    b.ne do_compose_800
do_apply_801:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_803
do_compose_800:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_803
do_concat_802:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_803:
    b cond_end_788
cond_false_787:
    adr x0, sign_id
cond_end_788:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_786
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
    b.ne blk_end_786
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_806
    adr x0, sign_id
    b cmp_end_807
cmp_true_806:
cmp_end_807:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_804
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_4
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_811
    tst x0, #1
    b.ne do_compose_809
do_apply_810:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_812
do_compose_809:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_812
do_concat_811:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_812:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_808
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
blk_end_808:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_819
    tst x0, #1
    b.ne do_compose_817
do_apply_818:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_820
do_compose_817:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_820
do_concat_819:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_820:
    b cond_end_805
cond_false_804:
    adr x0, sign_id
cond_end_805:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_786
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_823
    adr x0, sign_id
    b cmp_end_824
cmp_true_823:
cmp_end_824:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_821
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_5
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_825
    adr x0, print_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_832
    tst x0, #1
    b.ne do_compose_830
do_apply_831:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_833
do_compose_830:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_833
do_concat_832:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_833:
blk_end_825:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_836
    tst x0, #1
    b.ne do_compose_834
do_apply_835:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_837
do_compose_834:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_837
do_concat_836:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_837:
    b cond_end_822
cond_false_821:
    adr x0, sign_id
cond_end_822:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_786
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_840
    adr x0, sign_id
    b cmp_end_841
cmp_true_840:
cmp_end_841:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_838
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_6
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_842
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
blk_end_842:
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
    b cond_end_839
cond_false_838:
    adr x0, sign_id
cond_end_839:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_786
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_857
    adr x0, sign_id
    b cmp_end_858
cmp_true_857:
cmp_end_858:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_855
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_862
    tst x0, #1
    b.ne do_compose_860
do_apply_861:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_863
do_compose_860:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_863
do_concat_862:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_863:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_859
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_866
    tst x0, #1
    b.ne do_compose_864
do_apply_865:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_867
do_compose_864:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_867
do_concat_866:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_867:
blk_end_859:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_870
    tst x0, #1
    b.ne do_compose_868
do_apply_869:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_871
do_compose_868:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_871
do_concat_870:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_871:
    b cond_end_856
cond_false_855:
    adr x0, sign_id
cond_end_856:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_786
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_874
    adr x0, sign_id
    b cmp_end_875
cmp_true_874:
cmp_end_875:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_872
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_8
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_879
    tst x0, #1
    b.ne do_compose_877
do_apply_878:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_880
do_compose_877:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_880
do_concat_879:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_880:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_876
    adr x0, print_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_883
    tst x0, #1
    b.ne do_compose_881
do_apply_882:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_884
do_compose_881:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_884
do_concat_883:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_884:
blk_end_876:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_887
    tst x0, #1
    b.ne do_compose_885
do_apply_886:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_888
do_compose_885:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_888
do_concat_887:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_888:
    b cond_end_873
cond_false_872:
    adr x0, sign_id
cond_end_873:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_786
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_891
    adr x0, sign_id
    b cmp_end_892
cmp_true_891:
cmp_end_892:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_889
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_895
    tst x0, #1
    b.ne do_compose_893
do_apply_894:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_896
do_compose_893:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_896
do_concat_895:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_896:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_899
    tst x0, #1
    b.ne do_compose_897
do_apply_898:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_900
do_compose_897:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_900
do_concat_899:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_900:
    b cond_end_890
cond_false_889:
    adr x0, sign_id
cond_end_890:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_786
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_903
    tst x0, #1
    b.ne do_compose_901
do_apply_902:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_904
do_compose_901:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_904
do_concat_903:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_904:
blk_end_786:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_784_785:
    // Closure for func_784
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_784
    ldr x0, [sp], #16
    bl _cons
    b cond_end_779
cond_false_778:
    adr x0, sign_id
cond_end_779:
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
tok_eof: .quad 0
tok_id: .quad 0
tok_num: .quad 0
tok_str: .quad 0
tok_op: .quad 0
tok_punc: .quad 0
tok_sep: .quad 0


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
    .asciz "x = 123 + `foo`"
str_1:
    .asciz "Source: "
str_2:
    .asciz "End of List"
str_3:
    .asciz "EOF"
str_4:
    .asciz "ID: "
str_5:
    .asciz "NUM: "
str_6:
    .asciz "STR: "
str_7:
    .asciz "OP: "
str_8:
    .asciz "PUNC: "
str_9:
    .asciz "SEP"
