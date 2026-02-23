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
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #40
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_414
    adr x0, sign_id
    b cmp_end_415
cmp_true_414:
cmp_end_415:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_412
    b or_end_413
or_right_412:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_416
    adr x0, sign_id
    b cmp_end_417
cmp_true_416:
cmp_end_417:
or_end_413:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_410
    b or_end_411
or_right_410:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #123
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_418
    adr x0, sign_id
    b cmp_end_419
cmp_true_418:
cmp_end_419:
or_end_411:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_408
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_422
    tst x0, #1
    b.ne do_compose_420
do_apply_421:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_423
do_compose_420:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_423
do_concat_422:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_423:
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_424
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_431
    tst x0, #1
    b.ne do_compose_429
do_apply_430:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_432
do_compose_429:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_432
do_concat_431:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_432:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_435
    tst x0, #1
    b.ne do_compose_433
do_apply_434:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_436
do_compose_433:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_436
do_concat_435:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_436:
blk_end_424:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_439
    tst x0, #1
    b.ne do_compose_437
do_apply_438:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_440
do_compose_437:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_440
do_concat_439:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_440:
    b cond_end_409
cond_false_408:
    adr x0, sign_id
cond_end_409:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #41
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_447
    adr x0, sign_id
    b cmp_end_448
cmp_true_447:
cmp_end_448:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_445
    b or_end_446
or_right_445:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #93
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_449
    adr x0, sign_id
    b cmp_end_450
cmp_true_449:
cmp_end_450:
or_end_446:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_443
    b or_end_444
or_right_443:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #125
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_451
    adr x0, sign_id
    b cmp_end_452
cmp_true_451:
cmp_end_452:
or_end_444:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_441
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_453
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_460
    tst x0, #1
    b.ne do_compose_458
do_apply_459:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_461
do_compose_458:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_461
do_concat_460:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_461:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_464
    tst x0, #1
    b.ne do_compose_462
do_apply_463:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_465
do_compose_462:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_465
do_concat_464:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_465:
blk_end_453:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_468
    tst x0, #1
    b.ne do_compose_466
do_apply_467:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_469
do_compose_466:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_469
do_concat_468:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_469:
    b cond_end_442
cond_false_441:
    adr x0, sign_id
cond_end_442:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_472
    tst x0, #1
    b.ne do_compose_470
do_apply_471:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_473
do_compose_470:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_473
do_concat_472:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_473:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_332
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_476
    tst x0, #1
    b.ne do_compose_474
do_apply_475:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_477
do_compose_474:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_477
do_concat_476:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_477:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_480
    tst x0, #1
    b.ne do_compose_478
do_apply_479:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_481
do_compose_478:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_481
do_concat_480:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_481:
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
    b.eq do_concat_486
    tst x0, #1
    b.ne do_compose_484
do_apply_485:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_487
do_compose_484:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_487
do_concat_486:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_487:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_482
    b after_func_488_489
func_488:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x0, [x0] // @ load
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_495
    tst x0, #1
    b.ne do_compose_493
do_apply_494:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_496
do_compose_493:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_496
do_concat_495:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_496:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_491
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_497
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_497:
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
    b cond_end_492
cond_false_491:
    adr x0, sign_id
cond_end_492:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_490
    mov x0, #0
blk_end_490:
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
    b cond_end_483
cond_false_482:
    adr x0, sign_id
cond_end_483:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_514
    tst x0, #1
    b.ne do_compose_512
do_apply_513:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_515
do_compose_512:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_515
do_concat_514:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_515:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_510
    b after_func_516_517
func_516:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_521
    tst x0, #1
    b.ne do_compose_519
do_apply_520:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_522
do_compose_519:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_522
do_concat_521:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_522:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_518
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_525
    tst x0, #1
    b.ne do_compose_523
do_apply_524:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_526
do_compose_523:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_526
do_concat_525:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_526:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_518
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_529
    tst x0, #1
    b.ne do_compose_527
do_apply_528:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_530
do_compose_527:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_530
do_concat_529:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_530:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_533
    tst x0, #1
    b.ne do_compose_531
do_apply_532:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_534
do_compose_531:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_534
do_concat_533:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_534:
blk_end_518:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_516_517:
    // Closure for func_516
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_516
    ldr x0, [sp], #16
    bl _cons
    b cond_end_511
cond_false_510:
    adr x0, sign_id
cond_end_511:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_539
    tst x0, #1
    b.ne do_compose_537
do_apply_538:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_540
do_compose_537:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_540
do_concat_539:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_540:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_535
    b after_func_541_542
func_541:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_546
    b or_end_547
or_right_546:
    adr x0, is_digit
or_end_547:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_554
    tst x0, #1
    b.ne do_compose_552
do_apply_553:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_555
do_compose_552:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_555
do_concat_554:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_555:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_544
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_574
    tst x0, #1
    b.ne do_compose_572
do_apply_573:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_575
do_compose_572:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_575
do_concat_574:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_575:
    b cond_end_545
cond_false_544:
    adr x0, sign_id
cond_end_545:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_543
    mov x0, #0
blk_end_543:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_541_542:
    // Closure for func_541
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_541
    ldr x0, [sp], #16
    bl _cons
    b cond_end_536
cond_false_535:
    adr x0, sign_id
cond_end_536:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_num
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_580
    tst x0, #1
    b.ne do_compose_578
do_apply_579:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_581
do_compose_578:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_581
do_concat_580:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_581:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_576
    b after_func_582_583
func_582:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_586
    tst x0, #1
    b.ne do_compose_584
do_apply_585:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_587
do_compose_584:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_587
do_concat_586:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_587:
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_590
    tst x0, #1
    b.ne do_compose_588
do_apply_589:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_591
do_compose_588:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_591
do_concat_590:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_591:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_594
    tst x0, #1
    b.ne do_compose_592
do_apply_593:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_595
do_compose_592:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_595
do_concat_594:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_595:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_598
    tst x0, #1
    b.ne do_compose_596
do_apply_597:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_599
do_compose_596:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_599
do_concat_598:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_599:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_582_583:
    // Closure for func_582
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_582
    ldr x0, [sp], #16
    bl _cons
    b cond_end_577
cond_false_576:
    adr x0, sign_id
cond_end_577:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_604
    tst x0, #1
    b.ne do_compose_602
do_apply_603:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_605
do_compose_602:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_605
do_concat_604:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_605:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_600
    b after_func_606_607
func_606:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_608_609
func_608:
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
    b.eq do_concat_615
    tst x0, #1
    b.ne do_compose_613
do_apply_614:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_616
do_compose_613:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_616
do_concat_615:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_616:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_611
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
    b.ne blk_end_617
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_620
    tst x0, #1
    b.ne do_compose_618
do_apply_619:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_621
do_compose_618:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_621
do_concat_620:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_621:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_624
    tst x0, #1
    b.ne do_compose_622
do_apply_623:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_625
do_compose_622:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_625
do_concat_624:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_625:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_628
    tst x0, #1
    b.ne do_compose_626
do_apply_627:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_629
do_compose_626:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_629
do_concat_628:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_629:
blk_end_617:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_632
    tst x0, #1
    b.ne do_compose_630
do_apply_631:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_633
do_compose_630:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_633
do_concat_632:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_633:
    b cond_end_612
cond_false_611:
    adr x0, sign_id
cond_end_612:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_610
    ldr x0, [x29, #-32]
blk_end_610:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_608_609:
    // Closure for func_608
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_608
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_606_607:
    // Closure for func_606
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_606
    ldr x0, [sp], #16
    bl _cons
    b cond_end_601
cond_false_600:
    adr x0, sign_id
cond_end_601:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_op
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_634
    b after_func_640_641
func_640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x0, [x0] // @ load
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_645
    tst x0, #1
    b.ne do_compose_643
do_apply_644:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_646
do_compose_643:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_646
do_concat_645:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_646:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_642
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_649
    tst x0, #1
    b.ne do_compose_647
do_apply_648:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_650
do_compose_647:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_650
do_concat_649:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_650:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_642
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_653
    tst x0, #1
    b.ne do_compose_651
do_apply_652:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_654
do_compose_651:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_654
do_concat_653:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_654:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_657
    tst x0, #1
    b.ne do_compose_655
do_apply_656:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_658
do_compose_655:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_658
do_concat_657:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_658:
blk_end_642:
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
    b cond_end_635
cond_false_634:
    adr x0, sign_id
cond_end_635:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_659
    b after_func_665_666
func_665:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_672
    tst x0, #1
    b.ne do_compose_670
do_apply_671:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_673
do_compose_670:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_673
do_concat_672:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_673:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_668
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_676
    tst x0, #1
    b.ne do_compose_674
do_apply_675:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_677
do_compose_674:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_677
do_concat_676:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_677:
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_680
    tst x0, #1
    b.ne do_compose_678
do_apply_679:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_681
do_compose_678:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_681
do_concat_680:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_681:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_684
    tst x0, #1
    b.ne do_compose_682
do_apply_683:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_685
do_compose_682:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_685
do_concat_684:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_685:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_688
    tst x0, #1
    b.ne do_compose_686
do_apply_687:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_689
do_compose_686:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_689
do_concat_688:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_689:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_692
    tst x0, #1
    b.ne do_compose_690
do_apply_691:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_693
do_compose_690:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_693
do_concat_692:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_693:
    b cond_end_669
cond_false_668:
    adr x0, sign_id
cond_end_669:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_667
    mov x0, #0
blk_end_667:
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
    b cond_end_660
cond_false_659:
    adr x0, sign_id
cond_end_660:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_str
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_698
    tst x0, #1
    b.ne do_compose_696
do_apply_697:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_699
do_compose_696:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_699
do_concat_698:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_699:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_694
    b after_func_700_701
func_700:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_702
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_713
    tst x0, #1
    b.ne do_compose_711
do_apply_712:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_714
do_compose_711:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_714
do_concat_713:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_714:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_702
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_717
    tst x0, #1
    b.ne do_compose_715
do_apply_716:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_718
do_compose_715:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_718
do_concat_717:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_718:
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_721
    tst x0, #1
    b.ne do_compose_719
do_apply_720:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_722
do_compose_719:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_722
do_concat_721:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_722:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_725
    tst x0, #1
    b.ne do_compose_723
do_apply_724:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_726
do_compose_723:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_726
do_concat_725:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_726:
blk_end_702:
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
    b cond_end_695
cond_false_694:
    adr x0, sign_id
cond_end_695:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_731
    tst x0, #1
    b.ne do_compose_729
do_apply_730:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_732
do_compose_729:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_732
do_concat_731:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_732:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_727
    b after_func_733_734
func_733:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_740
    adr x0, sign_id
    b cmp_end_741
cmp_true_740:
cmp_end_741:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_738
    b or_end_739
or_right_738:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_742
    adr x0, sign_id
    b cmp_end_743
cmp_true_742:
cmp_end_743:
or_end_739:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_736
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
    mov x0, #0
blk_end_744:
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
    b cond_end_737
cond_false_736:
    adr x0, sign_id
cond_end_737:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_735
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_763
    tst x0, #1
    b.ne do_compose_761
do_apply_762:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_764
do_compose_761:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_764
do_concat_763:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_764:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_767
    tst x0, #1
    b.ne do_compose_765
do_apply_766:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_768
do_compose_765:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_768
do_concat_767:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_768:
blk_end_735:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_733_734:
    // Closure for func_733
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_733
    ldr x0, [sp], #16
    bl _cons
    b cond_end_728
cond_false_727:
    adr x0, sign_id
cond_end_728:
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
    b.eq do_concat_771
    tst x0, #1
    b.ne do_compose_769
do_apply_770:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_772
do_compose_769:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_772
do_concat_771:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_772:
    str x0, [sp, #-16]!
    adr x0, Parser
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_775
    tst x0, #1
    b.ne do_compose_773
do_apply_774:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_776
do_compose_773:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_776
do_concat_775:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_776:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Parses
    str x0, [sp, #-16]!
    adr x0, token
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_779
    tst x0, #1
    b.ne do_compose_777
do_apply_778:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_780
do_compose_777:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_780
do_concat_779:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_780:
    str x0, [sp, #-16]!
    adr x0, list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_783
    tst x0, #1
    b.ne do_compose_781
do_apply_782:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_784
do_compose_781:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_784
do_concat_783:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_784:
    str x0, [sp, #-16]!
    adr x0, into
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_787
    tst x0, #1
    b.ne do_compose_785
do_apply_786:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_788
do_compose_785:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_788
do_concat_787:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_788:
    str x0, [sp, #-16]!
    adr x0, AST
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
    adr x0, S
    str x0, [sp, #-16]!
    adr x0, expressions
    ldr x1, [sp], #16
    sub x0, x1, x0
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
    str x0, [sp, #-16]!
    adr x0, prefix
    str x0, [sp, #-16]!
    adr x0, infix
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_797
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_799
xor_true_797:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_798
    adr x0, sign_id
    b xor_end_799
xor_false_798:
    mov x0, x1
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
    b.eq do_concat_804
    tst x0, #1
    b.ne do_compose_802
do_apply_803:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_805
do_compose_802:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_805
do_concat_804:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_805:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_800
    b after_func_806_807
func_806:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_808_809
func_808:
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
    b.eq cmp_true_813
    adr x0, sign_id
    b cmp_end_814
cmp_true_813:
cmp_end_814:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_811
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, Ptr
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_815
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_817
xor_true_815:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_816
    adr x0, sign_id
    b xor_end_817
xor_false_816:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, equality
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
    str x0, [sp, #-16]!
    adr x0, optimize
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
    b cond_end_812
cond_false_811:
    adr x0, sign_id
cond_end_812:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_810
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_810
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_810
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_828
    adr x0, sign_id
    b cmp_end_829
cmp_true_828:
cmp_end_829:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_826
    mov x0, #0
    b cond_end_827
cond_false_826:
    adr x0, sign_id
cond_end_827:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_810
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_832
    adr x0, sign_id
    b cmp_end_833
cmp_true_832:
cmp_end_833:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_830
    mov x0, #1
    b cond_end_831
cond_false_830:
    adr x0, sign_id
cond_end_831:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_810
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_840
    tst x0, #1
    b.ne do_compose_838
do_apply_839:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_841
do_compose_838:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_841
do_concat_840:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_841:
blk_end_810:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_808_809:
    // Closure for func_808
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_808
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_806_807:
    // Closure for func_806
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_806
    ldr x0, [sp], #16
    bl _cons
    b cond_end_801
cond_false_800:
    adr x0, sign_id
cond_end_801:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, get_prec
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_846
    tst x0, #1
    b.ne do_compose_844
do_apply_845:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_847
do_compose_844:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_847
do_concat_846:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_847:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_842
    b after_func_848_849
func_848:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_855
    tst x0, #1
    b.ne do_compose_853
do_apply_854:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_856
do_compose_853:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_856
do_concat_855:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_856:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_859
    tst x0, #1
    b.ne do_compose_857
do_apply_858:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_860
do_compose_857:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_860
do_concat_859:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_860:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_851
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_852
cond_false_851:
    adr x0, sign_id
cond_end_852:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_869
    tst x0, #1
    b.ne do_compose_867
do_apply_868:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_870
do_compose_867:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_870
do_concat_869:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_870:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_861
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_862
cond_false_861:
    adr x0, sign_id
cond_end_862:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_875
    tst x0, #1
    b.ne do_compose_873
do_apply_874:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_876
do_compose_873:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_876
do_concat_875:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_876:
    str x0, [sp, #-16]!
    mov x0, #37
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
    b.eq cond_false_871
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_872
cond_false_871:
    adr x0, sign_id
cond_end_872:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_885
    tst x0, #1
    b.ne do_compose_883
do_apply_884:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_886
do_compose_883:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_886
do_concat_885:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_886:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_889
    tst x0, #1
    b.ne do_compose_887
do_apply_888:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_890
do_compose_887:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_890
do_concat_889:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_890:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_881
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_882
cond_false_881:
    adr x0, sign_id
cond_end_882:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    mov x0, #45
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_891
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_892
cond_false_891:
    adr x0, sign_id
cond_end_892:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_905
    tst x0, #1
    b.ne do_compose_903
do_apply_904:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_906
do_compose_903:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_906
do_concat_905:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_906:
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_909
    tst x0, #1
    b.ne do_compose_907
do_apply_908:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_910
do_compose_907:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_910
do_concat_909:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_910:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_901
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_902
cond_false_901:
    adr x0, sign_id
cond_end_902:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_915
    tst x0, #1
    b.ne do_compose_913
do_apply_914:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_916
do_compose_913:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_916
do_concat_915:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_916:
    str x0, [sp, #-16]!
    mov x0, #62
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_911
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_912
cond_false_911:
    adr x0, sign_id
cond_end_912:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_925
    tst x0, #1
    b.ne do_compose_923
do_apply_924:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_926
do_compose_923:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_926
do_concat_925:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_926:
    str x0, [sp, #-16]!
    mov x0, #61
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_929
    tst x0, #1
    b.ne do_compose_927
do_apply_928:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_930
do_compose_927:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_930
do_concat_929:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_930:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_921
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_922
cond_false_921:
    adr x0, sign_id
cond_end_922:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_935
    tst x0, #1
    b.ne do_compose_933
do_apply_934:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_936
do_compose_933:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_936
do_concat_935:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_936:
    str x0, [sp, #-16]!
    mov x0, #38
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_939
    tst x0, #1
    b.ne do_compose_937
do_apply_938:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_940
do_compose_937:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_940
do_concat_939:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_940:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_931
    adr x0, PREC_AND
    ldr x0, [x0]
    b cond_end_932
cond_false_931:
    adr x0, sign_id
cond_end_932:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_945
    tst x0, #1
    b.ne do_compose_943
do_apply_944:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_946
do_compose_943:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_946
do_concat_945:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_946:
    str x0, [sp, #-16]!
    mov x0, #124
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_949
    tst x0, #1
    b.ne do_compose_947
do_apply_948:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_950
do_compose_947:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_950
do_concat_949:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_950:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_941
    adr x0, PREC_OR
    ldr x0, [x0]
    b cond_end_942
cond_false_941:
    adr x0, sign_id
cond_end_942:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_955
    tst x0, #1
    b.ne do_compose_953
do_apply_954:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_956
do_compose_953:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_956
do_concat_955:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_956:
    str x0, [sp, #-16]!
    mov x0, #59
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_959
    tst x0, #1
    b.ne do_compose_957
do_apply_958:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_960
do_compose_957:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_960
do_concat_959:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_960:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_951
    adr x0, PREC_XOR
    ldr x0, [x0]
    b cond_end_952
cond_false_951:
    adr x0, sign_id
cond_end_952:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_850
    mov x0, #0
blk_end_850:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_848_849:
    // Closure for func_848
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_848
    ldr x0, [sp], #16
    bl _cons
    b cond_end_843
cond_false_842:
    adr x0, sign_id
cond_end_843:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_tokens
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, Remaining
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_961
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_963
xor_true_961:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_962
    adr x0, sign_id
    b xor_end_963
xor_false_962:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_966
    tst x0, #1
    b.ne do_compose_964
do_apply_965:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_967
do_compose_964:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_967
do_concat_966:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_967:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_curr
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, Current
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_968
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_970
xor_true_968:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_969
    adr x0, sign_id
    b xor_end_970
xor_false_969:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, token
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_973
    tst x0, #1
    b.ne do_compose_971
do_apply_972:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_974
do_compose_971:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_974
do_concat_973:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_974:
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
    b.eq do_concat_979
    tst x0, #1
    b.ne do_compose_977
do_apply_978:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_980
do_compose_977:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_980
do_concat_979:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_980:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_975
    b after_func_981_982
func_981:
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
    b.ne blk_end_983
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_983:
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
    b cond_end_976
cond_false_975:
    adr x0, sign_id
cond_end_976:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, advance
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_992
    tst x0, #1
    b.ne do_compose_990
do_apply_991:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_993
do_compose_990:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_993
do_concat_992:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_993:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_988
    b after_func_994_995
func_994:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p_tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_999
    adr x0, sign_id
    b cmp_end_1000
cmp_true_999:
cmp_end_1000:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_997
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
    b.eq do_concat_1004
    tst x0, #1
    b.ne do_compose_1002
do_apply_1003:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1005
do_compose_1002:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1005
do_concat_1004:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1005:
    str x0, [sp, #-16]!
    mov x0, #0
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1001
    mov x0, #0
blk_end_1001:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1012
    tst x0, #1
    b.ne do_compose_1010
do_apply_1011:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1013
do_compose_1010:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1013
do_concat_1012:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1013:
    b cond_end_998
cond_false_997:
    adr x0, sign_id
cond_end_998:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_996
    adr x0, p_curr
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, p_tokens
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1016
    tst x0, #1
    b.ne do_compose_1014
do_apply_1015:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1017
do_compose_1014:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1017
do_concat_1016:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1017:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_996
    adr x0, p_tokens
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, p_tokens
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1020
    tst x0, #1
    b.ne do_compose_1018
do_apply_1019:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1021
do_compose_1018:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1021
do_concat_1020:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1021:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_996
    adr x0, p_curr
blk_end_996:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_994_995:
    // Closure for func_994
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_994
    ldr x0, [sp], #16
    bl _cons
    b cond_end_989
cond_false_988:
    adr x0, sign_id
cond_end_989:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, peek_type
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1026
    tst x0, #1
    b.ne do_compose_1024
do_apply_1025:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1027
do_compose_1024:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1027
do_concat_1026:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1027:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1022
    b after_func_1028_1029
func_1028:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1032
    tst x0, #1
    b.ne do_compose_1030
do_apply_1031:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1033
do_compose_1030:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1033
do_concat_1032:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1033:
    ldr x0, [x0] // @ load
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
    b cond_end_1023
cond_false_1022:
    adr x0, sign_id
cond_end_1023:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, peek_val
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1038
    tst x0, #1
    b.ne do_compose_1036
do_apply_1037:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1039
do_compose_1036:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1039
do_concat_1038:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1039:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1034
    b after_func_1040_1041
func_1040:
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
    b.eq do_concat_1044
    tst x0, #1
    b.ne do_compose_1042
do_apply_1043:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1045
do_compose_1042:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1045
do_concat_1044:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1045:
    ldr x0, [x0] // @ load
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
    b cond_end_1035
cond_false_1034:
    adr x0, sign_id
cond_end_1035:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expect_val
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1046
    b after_func_1052_1053
func_1052:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1057
    tst x0, #1
    b.ne do_compose_1055
do_apply_1056:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1058
do_compose_1055:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1058
do_concat_1057:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1058:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1054
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1061
    adr x0, sign_id
    b cmp_end_1062
cmp_true_1061:
cmp_end_1062:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1059
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1063
    mov x0, #1
blk_end_1063:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1070
    tst x0, #1
    b.ne do_compose_1068
do_apply_1069:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1071
do_compose_1068:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1071
do_concat_1070:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1071:
    b cond_end_1060
cond_false_1059:
    adr x0, sign_id
cond_end_1060:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1054
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, TODO
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1074
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1076
xor_true_1074:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1075
    adr x0, sign_id
    b xor_end_1076
xor_false_1075:
    mov x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1072
    adr x0, Error
    str x0, [sp, #-16]!
    adr x0, handling
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1079
    tst x0, #1
    b.ne do_compose_1077
do_apply_1078:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1080
do_compose_1077:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1080
do_concat_1079:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1080:
    b cond_end_1073
cond_false_1072:
    adr x0, sign_id
cond_end_1073:
blk_end_1054:
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
    b cond_end_1047
cond_false_1046:
    adr x0, sign_id
cond_end_1047:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expect_type
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1085
    tst x0, #1
    b.ne do_compose_1083
do_apply_1084:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1086
do_compose_1083:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1086
do_concat_1085:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1086:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1081
    b after_func_1087_1088
func_1087:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1089
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1096
    adr x0, sign_id
    b cmp_end_1097
cmp_true_1096:
cmp_end_1097:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1094
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1101
    tst x0, #1
    b.ne do_compose_1099
do_apply_1100:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1102
do_compose_1099:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1102
do_concat_1101:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1102:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1098
    mov x0, #1
blk_end_1098:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1105
    tst x0, #1
    b.ne do_compose_1103
do_apply_1104:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1106
do_compose_1103:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1106
do_concat_1105:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1106:
    b cond_end_1095
cond_false_1094:
    adr x0, sign_id
cond_end_1095:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1089
    mov x0, #0
blk_end_1089:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1087_1088:
    // Closure for func_1087
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1087
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1082
cond_false_1081:
    adr x0, sign_id
cond_end_1082:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, can_start_expr
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1111
    tst x0, #1
    b.ne do_compose_1109
do_apply_1110:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1112
do_compose_1109:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1112
do_concat_1111:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1112:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1107
    b after_func_1113_1114
func_1113:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1118
    tst x0, #1
    b.ne do_compose_1116
do_apply_1117:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1119
do_compose_1116:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1119
do_concat_1118:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1119:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1115
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1122
    adr x0, sign_id
    b cmp_end_1123
cmp_true_1122:
cmp_end_1123:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1120
    mov x0, #1
    b cond_end_1121
cond_false_1120:
    adr x0, sign_id
cond_end_1121:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1115
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1126
    adr x0, sign_id
    b cmp_end_1127
cmp_true_1126:
cmp_end_1127:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1124
    mov x0, #1
    b cond_end_1125
cond_false_1124:
    adr x0, sign_id
cond_end_1125:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1115
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1130
    adr x0, sign_id
    b cmp_end_1131
cmp_true_1130:
cmp_end_1131:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1128
    mov x0, #1
    b cond_end_1129
cond_false_1128:
    adr x0, sign_id
cond_end_1129:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1115
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, TODO
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1134
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1136
xor_true_1134:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1135
    adr x0, sign_id
    b xor_end_1136
xor_false_1135:
    mov x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1132
    adr x0, strings
    str x0, [sp, #-16]!
    adr x0, parens
    str x0, [sp, #-16]!
    adr x0, prefix
    str x0, [sp, #-16]!
    adr x0, ops
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1139
    tst x0, #1
    b.ne do_compose_1137
do_apply_1138:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1140
do_compose_1137:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1140
do_concat_1139:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1140:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    b cond_end_1133
cond_false_1132:
    adr x0, sign_id
cond_end_1133:
blk_end_1115:
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
    b cond_end_1108
cond_false_1107:
    adr x0, sign_id
cond_end_1108:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_program
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1145
    tst x0, #1
    b.ne do_compose_1143
do_apply_1144:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1146
do_compose_1143:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1146
do_concat_1145:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1146:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1141
    b after_func_1147_1148
func_1147:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1152
    tst x0, #1
    b.ne do_compose_1150
do_apply_1151:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1153
do_compose_1150:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1153
do_concat_1152:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1153:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1149
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1156
    adr x0, sign_id
    b cmp_end_1157
cmp_true_1156:
cmp_end_1157:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1154
    mov x0, #0
    b cond_end_1155
cond_false_1154:
    adr x0, sign_id
cond_end_1155:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1149
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1160
    adr x0, sign_id
    b cmp_end_1161
cmp_true_1160:
cmp_end_1161:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1158
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1162
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_1162:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1173
    tst x0, #1
    b.ne do_compose_1171
do_apply_1172:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1174
do_compose_1171:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1174
do_concat_1173:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1174:
    b cond_end_1159
cond_false_1158:
    adr x0, sign_id
cond_end_1159:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1149
    adr x0, parse_def
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1177
    tst x0, #1
    b.ne do_compose_1175
do_apply_1176:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1178
do_compose_1175:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1178
do_concat_1177:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1178:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1149
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1181
    tst x0, #1
    b.ne do_compose_1179
do_apply_1180:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1182
do_compose_1179:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1182
do_concat_1181:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1182:
    str x0, [sp, #-16]!
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_1149:
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
    b cond_end_1142
cond_false_1141:
    adr x0, sign_id
cond_end_1142:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_def
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
    adr x0, expect_val
    str x0, [sp, #-16]!
    mov x0, #35
    str x0, [sp, #-16]!
    adr x0, #
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1200
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1202
xor_true_1200:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1201
    adr x0, sign_id
    b xor_end_1202
xor_false_1201:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1205
    tst x0, #1
    b.ne do_compose_1203
do_apply_1204:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1206
do_compose_1203:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1206
do_concat_1205:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1206:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1209
    tst x0, #1
    b.ne do_compose_1207
do_apply_1208:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1210
do_compose_1207:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1210
do_concat_1209:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1210:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    adr x0, expect_type
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1213
    tst x0, #1
    b.ne do_compose_1211
do_apply_1212:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1214
do_compose_1211:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1214
do_concat_1213:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1214:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    adr x0, expect_val
    str x0, [sp, #-16]!
    mov x0, #58
    str x0, [sp, #-16]!
    adr x0, 
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1215
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1217
xor_true_1215:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1216
    adr x0, sign_id
    b xor_end_1217
xor_false_1216:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1220
    tst x0, #1
    b.ne do_compose_1218
do_apply_1219:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1221
do_compose_1218:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1221
do_concat_1220:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1221:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    adr x0, parse_args
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1224
    tst x0, #1
    b.ne do_compose_1222
do_apply_1223:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1225
do_compose_1222:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1225
do_concat_1224:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1225:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    adr x0, expect_val
    str x0, [sp, #-16]!
    mov x0, #63
    str x0, [sp, #-16]!
    adr x0, ?
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1226
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1228
xor_true_1226:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1227
    adr x0, sign_id
    b xor_end_1228
xor_false_1227:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1231
    tst x0, #1
    b.ne do_compose_1229
do_apply_1230:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1232
do_compose_1229:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1232
do_concat_1231:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1232:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    adr x0, parse_block
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1235
    tst x0, #1
    b.ne do_compose_1233
do_apply_1234:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1236
do_compose_1233:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1236
do_concat_1235:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1236:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1199
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_def
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1239
    tst x0, #1
    b.ne do_compose_1237
do_apply_1238:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1240
do_compose_1237:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1240
do_concat_1239:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1240:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1243
    tst x0, #1
    b.ne do_compose_1241
do_apply_1242:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1244
do_compose_1241:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1244
do_concat_1243:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1244:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1247
    tst x0, #1
    b.ne do_compose_1245
do_apply_1246:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1248
do_compose_1245:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1248
do_concat_1247:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1248:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1251
    tst x0, #1
    b.ne do_compose_1249
do_apply_1250:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1252
do_compose_1249:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1252
do_concat_1251:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1252:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1255
    tst x0, #1
    b.ne do_compose_1253
do_apply_1254:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1256
do_compose_1253:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1256
do_concat_1255:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1256:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1259
    tst x0, #1
    b.ne do_compose_1257
do_apply_1258:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1260
do_compose_1257:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1260
do_concat_1259:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1260:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1263
    tst x0, #1
    b.ne do_compose_1261
do_apply_1262:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1264
do_compose_1261:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1264
do_concat_1263:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1264:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1267
    tst x0, #1
    b.ne do_compose_1265
do_apply_1266:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1268
do_compose_1265:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1268
do_concat_1267:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1268:
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
    adr x0, parse_block
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1273
    tst x0, #1
    b.ne do_compose_1271
do_apply_1272:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1274
do_compose_1271:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1274
do_concat_1273:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1274:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1269
    b after_func_1275_1276
func_1275:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1277
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1284
    adr x0, sign_id
    b cmp_end_1285
cmp_true_1284:
cmp_end_1285:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1282
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1289
    tst x0, #1
    b.ne do_compose_1287
do_apply_1288:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1290
do_compose_1287:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1290
do_concat_1289:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1290:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1286
    adr x0, parse_block
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1293
    tst x0, #1
    b.ne do_compose_1291
do_apply_1292:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1294
do_compose_1291:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1294
do_concat_1293:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1294:
blk_end_1286:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1297
    tst x0, #1
    b.ne do_compose_1295
do_apply_1296:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1298
do_compose_1295:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1298
do_concat_1297:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1298:
    b cond_end_1283
cond_false_1282:
    adr x0, sign_id
cond_end_1283:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1277
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1301
    tst x0, #1
    b.ne do_compose_1299
do_apply_1300:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1302
do_compose_1299:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1302
do_concat_1301:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1302:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1277
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1305
    tst x0, #1
    b.ne do_compose_1303
do_apply_1304:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1306
do_compose_1303:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1306
do_concat_1305:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1306:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1277
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1309
    adr x0, sign_id
    b cmp_end_1310
cmp_true_1309:
cmp_end_1310:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1307
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1314
    tst x0, #1
    b.ne do_compose_1312
do_apply_1313:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1315
do_compose_1312:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1315
do_concat_1314:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1315:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1311
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1311
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1322
    adr x0, sign_id
    b cmp_end_1323
cmp_true_1322:
cmp_end_1323:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1320
    ldr x0, [x29, #-64]
    b cond_end_1321
cond_false_1320:
    adr x0, sign_id
cond_end_1321:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1311
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1330
    tst x0, #1
    b.ne do_compose_1328
do_apply_1329:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1331
do_compose_1328:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1331
do_concat_1330:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1331:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1334
    tst x0, #1
    b.ne do_compose_1332
do_apply_1333:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1335
do_compose_1332:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1335
do_concat_1334:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1335:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1338
    tst x0, #1
    b.ne do_compose_1336
do_apply_1337:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1339
do_compose_1336:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1339
do_concat_1338:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1339:
blk_end_1311:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1342
    tst x0, #1
    b.ne do_compose_1340
do_apply_1341:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1343
do_compose_1340:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1343
do_concat_1342:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1343:
    b cond_end_1308
cond_false_1307:
    adr x0, sign_id
cond_end_1308:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1277
    ldr x0, [x29, #-64]
blk_end_1277:
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
    b cond_end_1270
cond_false_1269:
    adr x0, sign_id
cond_end_1270:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_block_rest
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1348
    tst x0, #1
    b.ne do_compose_1346
do_apply_1347:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1349
do_compose_1346:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1349
do_concat_1348:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1349:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1344
    b after_func_1350_1351
func_1350:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1355
    tst x0, #1
    b.ne do_compose_1353
do_apply_1354:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1356
do_compose_1353:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1356
do_concat_1355:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1356:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1352
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1359
    adr x0, sign_id
    b cmp_end_1360
cmp_true_1359:
cmp_end_1360:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1357
    mov x0, #0
    b cond_end_1358
cond_false_1357:
    adr x0, sign_id
cond_end_1358:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1352
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #35
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1363
    adr x0, sign_id
    b cmp_end_1364
cmp_true_1363:
cmp_end_1364:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1361
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, #
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1365
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1367
xor_true_1365:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1366
    adr x0, sign_id
    b xor_end_1367
xor_false_1366:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, start
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
    str x0, [sp, #-16]!
    adr x0, of
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1374
    tst x0, #1
    b.ne do_compose_1372
do_apply_1373:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1375
do_compose_1372:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1375
do_concat_1374:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1375:
    str x0, [sp, #-16]!
    adr x0, next
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1378
    tst x0, #1
    b.ne do_compose_1376
do_apply_1377:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1379
do_compose_1376:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1379
do_concat_1378:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1379:
    str x0, [sp, #-16]!
    adr x0, def
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1382
    tst x0, #1
    b.ne do_compose_1380
do_apply_1381:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1383
do_compose_1380:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1383
do_concat_1382:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1383:
    b cond_end_1362
cond_false_1361:
    adr x0, sign_id
cond_end_1362:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1352
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1386
    adr x0, sign_id
    b cmp_end_1387
cmp_true_1386:
cmp_end_1387:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1384
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1391
    tst x0, #1
    b.ne do_compose_1389
do_apply_1390:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1392
do_compose_1389:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1392
do_concat_1391:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1392:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1388
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_1388:
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
    b cond_end_1385
cond_false_1384:
    adr x0, sign_id
cond_end_1385:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1352
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1403
    tst x0, #1
    b.ne do_compose_1401
do_apply_1402:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1404
do_compose_1401:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1404
do_concat_1403:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1404:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1352
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_1352:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1350_1351:
    // Closure for func_1350
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1350
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1345
cond_false_1344:
    adr x0, sign_id
cond_end_1345:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_args
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1421
    tst x0, #1
    b.ne do_compose_1419
do_apply_1420:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1422
do_compose_1419:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1422
do_concat_1421:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1422:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1417
    b after_func_1423_1424
func_1423:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1428
    tst x0, #1
    b.ne do_compose_1426
do_apply_1427:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1429
do_compose_1426:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1429
do_concat_1428:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1429:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1425
    b after_v_impl_1430
v_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1431_1432
func_1431:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_1433_1434
func_1433:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1433_1434:
    // Closure for func_1433
    adr x0, sign_id
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_v_impl_1430:
    // Closure for v_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, v_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1425
    adr x0, v
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1437
    adr x0, sign_id
    b cmp_end_1438
cmp_true_1437:
cmp_end_1438:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1435
    mov x0, #0
    b cond_end_1436
cond_false_1435:
    adr x0, sign_id
cond_end_1436:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1425
    adr x0, expect_type
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1425
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, v
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1445
    tst x0, #1
    b.ne do_compose_1443
do_apply_1444:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1446
do_compose_1443:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1446
do_concat_1445:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1446:
    str x0, [sp, #-16]!
    adr x0, parse_args
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1449
    tst x0, #1
    b.ne do_compose_1447
do_apply_1448:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1450
do_compose_1447:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1450
do_concat_1449:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1450:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1453
    tst x0, #1
    b.ne do_compose_1451
do_apply_1452:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1454
do_compose_1451:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1454
do_concat_1453:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1454:
blk_end_1425:
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
    b cond_end_1418
cond_false_1417:
    adr x0, sign_id
cond_end_1418:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_expr
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1459
    tst x0, #1
    b.ne do_compose_1457
do_apply_1458:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1460
do_compose_1457:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1460
do_concat_1459:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1460:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1455
    b after_func_1461_1462
func_1461:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, parse_primary
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1466
    tst x0, #1
    b.ne do_compose_1464
do_apply_1465:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1467
do_compose_1464:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1467
do_concat_1466:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1467:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1463
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1470
    tst x0, #1
    b.ne do_compose_1468
do_apply_1469:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1471
do_compose_1468:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1471
do_concat_1470:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1471:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1474
    tst x0, #1
    b.ne do_compose_1472
do_apply_1473:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1475
do_compose_1472:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1475
do_concat_1474:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1475:
blk_end_1463:
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
    b cond_end_1456
cond_false_1455:
    adr x0, sign_id
cond_end_1456:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1480
    tst x0, #1
    b.ne do_compose_1478
do_apply_1479:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1481
do_compose_1478:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1481
do_concat_1480:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1481:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1476
    b after_func_1482_1483
func_1482:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1484_1485
func_1484:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, ;
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1489
    tst x0, #1
    b.ne do_compose_1487
do_apply_1488:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1490
do_compose_1487:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1490
do_concat_1489:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1490:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1493
    tst x0, #1
    b.ne do_compose_1491
do_apply_1492:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1494
do_compose_1491:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1494
do_concat_1493:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1494:
    str x0, [sp, #-16]!
    adr x0, Check
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
    adr x0, for
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
    str x0, [sp, #-16]!
    adr x0, application
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1505
    tst x0, #1
    b.ne do_compose_1503
do_apply_1504:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1506
do_compose_1503:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1506
do_concat_1505:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1506:
    str x0, [sp, #-16]!
    adr x0, Juxtaposition
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1509
    tst x0, #1
    b.ne do_compose_1507
do_apply_1508:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1510
do_compose_1507:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1510
do_concat_1509:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1510:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    adr x0, can_start_expr
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
    b.ne blk_end_1486
    ldr x0, [x29, #-64]
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1517
    adr x0, PREC_APPLY
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1519
    adr x0, sign_id
    b cmp_end_1520
cmp_true_1519:
cmp_end_1520:
    b and_end_1518
and_fail_1517:
    adr x0, sign_id
and_end_1518:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1515
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
    b.eq do_concat_1524
    tst x0, #1
    b.ne do_compose_1522
do_apply_1523:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1525
do_compose_1522:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1525
do_concat_1524:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1525:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1521
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1528
    tst x0, #1
    b.ne do_compose_1526
do_apply_1527:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1529
do_compose_1526:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1529
do_concat_1528:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1529:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1536
    tst x0, #1
    b.ne do_compose_1534
do_apply_1535:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1537
do_compose_1534:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1537
do_concat_1536:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1537:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1540
    tst x0, #1
    b.ne do_compose_1538
do_apply_1539:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1541
do_compose_1538:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1541
do_concat_1540:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1541:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1544
    tst x0, #1
    b.ne do_compose_1542
do_apply_1543:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1545
do_compose_1542:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1545
do_concat_1544:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1545:
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1521
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
blk_end_1521:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1560
    tst x0, #1
    b.ne do_compose_1558
do_apply_1559:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1561
do_compose_1558:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1561
do_concat_1560:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1561:
    b cond_end_1516
cond_false_1515:
    adr x0, sign_id
cond_end_1516:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1564
    tst x0, #1
    b.ne do_compose_1562
do_apply_1563:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1565
do_compose_1562:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1565
do_concat_1564:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1565:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_1568
    adr x0, sign_id
    b cmp_end_1569
cmp_true_1568:
cmp_end_1569:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1566
    ldr x0, [x29, #-48]
    b cond_end_1567
cond_false_1566:
    adr x0, sign_id
cond_end_1567:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1572
    tst x0, #1
    b.ne do_compose_1570
do_apply_1571:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1573
do_compose_1570:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1573
do_concat_1572:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1573:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    adr x0, get_prec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1576
    tst x0, #1
    b.ne do_compose_1574
do_apply_1575:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1577
do_compose_1574:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1577
do_concat_1576:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1577:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1580
    adr x0, sign_id
    b cmp_end_1581
cmp_true_1580:
cmp_end_1581:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1578
    ldr x0, [x29, #-48]
    b cond_end_1579
cond_false_1578:
    adr x0, sign_id
cond_end_1579:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, Consume
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1582
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1584
xor_true_1582:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1583
    adr x0, sign_id
    b xor_end_1584
xor_false_1583:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1587
    tst x0, #1
    b.ne do_compose_1585
do_apply_1586:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1588
do_compose_1585:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1588
do_concat_1587:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1588:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1591
    tst x0, #1
    b.ne do_compose_1589
do_apply_1590:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1592
do_compose_1589:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1592
do_concat_1591:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1592:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    adr x0, parse_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, Right
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1593
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1595
xor_true_1593:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1594
    adr x0, sign_id
    b xor_end_1595
xor_false_1594:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1598
    tst x0, #1
    b.ne do_compose_1596
do_apply_1597:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1599
do_compose_1596:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1599
do_concat_1598:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1599:
    str x0, [sp, #-16]!
    adr x0, associative
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1602
    tst x0, #1
    b.ne do_compose_1600
do_apply_1601:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1603
do_compose_1600:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1603
do_concat_1602:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1603:
    str x0, [sp, #-16]!
    adr x0, ?
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1606
    tst x0, #1
    b.ne do_compose_1604
do_apply_1605:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1607
do_compose_1604:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1607
do_concat_1606:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1607:
    str x0, [sp, #-16]!
    adr x0, No
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1610
    tst x0, #1
    b.ne do_compose_1608
do_apply_1609:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1611
do_compose_1608:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1611
do_concat_1610:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1611:
    str x0, [sp, #-16]!
    adr x0, left
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1614
    tst x0, #1
    b.ne do_compose_1612
do_apply_1613:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1615
do_compose_1612:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1615
do_concat_1614:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1615:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1618
    tst x0, #1
    b.ne do_compose_1616
do_apply_1617:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1619
do_compose_1616:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1619
do_concat_1618:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1619:
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1622
    tst x0, #1
    b.ne do_compose_1620
do_apply_1621:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1623
do_compose_1620:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1623
do_concat_1622:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1623:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1626
    tst x0, #1
    b.ne do_compose_1624
do_apply_1625:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1627
do_compose_1624:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1627
do_concat_1626:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1627:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1630
    tst x0, #1
    b.ne do_compose_1628
do_apply_1629:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1631
do_compose_1628:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1631
do_concat_1630:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1631:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1634
    tst x0, #1
    b.ne do_compose_1632
do_apply_1633:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1635
do_compose_1632:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1635
do_concat_1634:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1635:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1638
    tst x0, #1
    b.ne do_compose_1636
do_apply_1637:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1639
do_compose_1636:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1639
do_concat_1638:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1639:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1642
    tst x0, #1
    b.ne do_compose_1640
do_apply_1641:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1643
do_compose_1640:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1643
do_concat_1642:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1643:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1646
    tst x0, #1
    b.ne do_compose_1644
do_apply_1645:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1647
do_compose_1644:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1647
do_concat_1646:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1647:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1650
    tst x0, #1
    b.ne do_compose_1648
do_apply_1649:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1651
do_compose_1648:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1651
do_concat_1650:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1651:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1486
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1654
    tst x0, #1
    b.ne do_compose_1652
do_apply_1653:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1655
do_compose_1652:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1655
do_concat_1654:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1655:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1658
    tst x0, #1
    b.ne do_compose_1656
do_apply_1657:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1659
do_compose_1656:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1659
do_concat_1658:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1659:
blk_end_1486:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1484_1485:
    // Closure for func_1484
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1484
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1482_1483:
    // Closure for func_1482
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1482
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1477
cond_false_1476:
    adr x0, sign_id
cond_end_1477:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, parse_primary
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1664
    tst x0, #1
    b.ne do_compose_1662
do_apply_1663:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1665
do_compose_1662:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1665
do_concat_1664:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1665:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1660
    b after_func_1666_1667
func_1666:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1671
    tst x0, #1
    b.ne do_compose_1669
do_apply_1670:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1672
do_compose_1669:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1672
do_concat_1671:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1672:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1668
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1675
    tst x0, #1
    b.ne do_compose_1673
do_apply_1674:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1676
do_compose_1673:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1676
do_concat_1675:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1676:
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
    b.eq cmp_true_1679
    adr x0, sign_id
    b cmp_end_1680
cmp_true_1679:
cmp_end_1680:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1677
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1684
    tst x0, #1
    b.ne do_compose_1682
do_apply_1683:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1685
do_compose_1682:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1685
do_concat_1684:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1685:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1681
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1688
    tst x0, #1
    b.ne do_compose_1686
do_apply_1687:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1689
do_compose_1686:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1689
do_concat_1688:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1689:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1692
    tst x0, #1
    b.ne do_compose_1690
do_apply_1691:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1693
do_compose_1690:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1693
do_concat_1692:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1693:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1696
    tst x0, #1
    b.ne do_compose_1694
do_apply_1695:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1697
do_compose_1694:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1697
do_concat_1696:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1697:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1700
    tst x0, #1
    b.ne do_compose_1698
do_apply_1699:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1701
do_compose_1698:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1701
do_concat_1700:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1701:
blk_end_1681:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1704
    tst x0, #1
    b.ne do_compose_1702
do_apply_1703:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1705
do_compose_1702:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1705
do_concat_1704:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1705:
    b cond_end_1678
cond_false_1677:
    adr x0, sign_id
cond_end_1678:
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
    b.eq cmp_true_1708
    adr x0, sign_id
    b cmp_end_1709
cmp_true_1708:
cmp_end_1709:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1706
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1713
    tst x0, #1
    b.ne do_compose_1711
do_apply_1712:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1714
do_compose_1711:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1714
do_concat_1713:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1714:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1710
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1717
    tst x0, #1
    b.ne do_compose_1715
do_apply_1716:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1718
do_compose_1715:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1718
do_concat_1717:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1718:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1721
    tst x0, #1
    b.ne do_compose_1719
do_apply_1720:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1722
do_compose_1719:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1722
do_concat_1721:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1722:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1725
    tst x0, #1
    b.ne do_compose_1723
do_apply_1724:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1726
do_compose_1723:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1726
do_concat_1725:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1726:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1729
    tst x0, #1
    b.ne do_compose_1727
do_apply_1728:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1730
do_compose_1727:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1730
do_concat_1729:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1730:
blk_end_1710:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1733
    tst x0, #1
    b.ne do_compose_1731
do_apply_1732:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1734
do_compose_1731:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1734
do_concat_1733:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1734:
    b cond_end_1707
cond_false_1706:
    adr x0, sign_id
cond_end_1707:
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
    b.eq cmp_true_1737
    adr x0, sign_id
    b cmp_end_1738
cmp_true_1737:
cmp_end_1738:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1735
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1742
    tst x0, #1
    b.ne do_compose_1740
do_apply_1741:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1743
do_compose_1740:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1743
do_concat_1742:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1743:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1739
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1746
    tst x0, #1
    b.ne do_compose_1744
do_apply_1745:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1747
do_compose_1744:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1747
do_concat_1746:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1747:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1739
    adr x0, expect_type
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1750
    tst x0, #1
    b.ne do_compose_1748
do_apply_1749:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1751
do_compose_1748:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1751
do_concat_1750:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1751:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1739
    ldr x0, [x29, #-80]
blk_end_1739:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1754
    tst x0, #1
    b.ne do_compose_1752
do_apply_1753:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1755
do_compose_1752:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1755
do_concat_1754:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1755:
    b cond_end_1736
cond_false_1735:
    adr x0, sign_id
cond_end_1736:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1668
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1758
    tst x0, #1
    b.ne do_compose_1756
do_apply_1757:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1759
do_compose_1756:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1759
do_concat_1758:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1759:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #999
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1765
    tst x0, #1
    b.ne do_compose_1763
do_apply_1764:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1766
do_compose_1763:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1766
do_concat_1765:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1766:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1769
    tst x0, #1
    b.ne do_compose_1767
do_apply_1768:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1770
do_compose_1767:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1770
do_concat_1769:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1770:
    str x0, [sp, #-16]!
    adr x0, Fallback
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1773
    tst x0, #1
    b.ne do_compose_1771
do_apply_1772:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1774
do_compose_1771:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1774
do_concat_1773:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1774:
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
    b cond_end_1661
cond_false_1660:
    adr x0, sign_id
cond_end_1661:
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
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, main
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1775
    b after_func_1781_1782
func_1781:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1784
    adr x0, ?
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1788
    tst x0, #1
    b.ne do_compose_1786
do_apply_1787:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1789
do_compose_1786:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1789
do_concat_1788:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1789:
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1792
    tst x0, #1
    b.ne do_compose_1790
do_apply_1791:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1793
do_compose_1790:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1793
do_concat_1792:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1793:
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1796
    tst x0, #1
    b.ne do_compose_1794
do_apply_1795:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1797
do_compose_1794:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1797
do_concat_1796:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1797:
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1800
    adr x0, sign_id
    b cmp_end_1801
cmp_true_1800:
cmp_end_1801:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1798
    b or_end_1799
or_right_1798:
    adr x0, z
or_end_1799:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1804
    tst x0, #1
    b.ne do_compose_1802
do_apply_1803:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1805
do_compose_1802:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1805
do_concat_1804:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1805:
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1808
    tst x0, #1
    b.ne do_compose_1806
do_apply_1807:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1809
do_compose_1806:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1809
do_concat_1808:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1809:
    str x0, [sp, #-16]!
    adr x0, a
    str x0, [sp, #-16]!
    adr x0, b
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1810
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1812
xor_true_1810:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1811
    adr x0, sign_id
    b xor_end_1812
xor_false_1811:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1815
    tst x0, #1
    b.ne do_compose_1813
do_apply_1814:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1816
do_compose_1813:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1816
do_concat_1815:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1816:
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1819
    tst x0, #1
    b.ne do_compose_1817
do_apply_1818:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1820
do_compose_1817:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1820
do_concat_1819:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1820:
    str x0, [sp, #-16]!
    adr x0, f
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1823
    tst x0, #1
    b.ne do_compose_1821
do_apply_1822:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1824
do_compose_1821:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1824
do_concat_1823:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1824:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1827
    tst x0, #1
    b.ne do_compose_1825
do_apply_1826:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1828
do_compose_1825:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1828
do_concat_1827:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1828:
    str x0, [sp, #-16]!
    adr x0, y
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1831
    tst x0, #1
    b.ne do_compose_1829
do_apply_1830:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1832
do_compose_1829:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1832
do_concat_1831:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1832:
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1835
    tst x0, #1
    b.ne do_compose_1833
do_apply_1834:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1836
do_compose_1833:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1836
do_concat_1835:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1836:
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1839
    tst x0, #1
    b.ne do_compose_1837
do_apply_1838:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1840
do_compose_1837:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1840
do_concat_1839:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1840:
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1843
    tst x0, #1
    b.ne do_compose_1841
do_apply_1842:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1844
do_compose_1841:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1844
do_concat_1843:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1844:
    str x0, [sp, #-16]!
    mov x0, #4
    str x0, [sp, #-16]!
    mov x0, #5
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #6
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1847
    tst x0, #1
    b.ne do_compose_1845
do_apply_1846:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1848
do_compose_1845:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1848
do_concat_1847:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1848:
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1851
    tst x0, #1
    b.ne do_compose_1849
do_apply_1850:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1852
do_compose_1849:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1852
do_concat_1851:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1852:
    str x0, [sp, #-16]!
    mov x0, #7
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #9
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1855
    tst x0, #1
    b.ne do_compose_1853
do_apply_1854:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1856
do_compose_1853:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1856
do_concat_1855:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1856:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1859
    tst x0, #1
    b.ne do_compose_1857
do_apply_1858:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1860
do_compose_1857:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1860
do_concat_1859:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1860:
    b cond_end_1785
cond_false_1784:
    adr x0, sign_id
cond_end_1785:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1783
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_2
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1863
    tst x0, #1
    b.ne do_compose_1861
do_apply_1862:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1864
do_compose_1861:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1864
do_concat_1863:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1864:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1783
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    b.ne blk_end_1783
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1871
    tst x0, #1
    b.ne do_compose_1869
do_apply_1870:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1872
do_compose_1869:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1872
do_concat_1871:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1872:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1783
    adr x0, init_lexer
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1875
    tst x0, #1
    b.ne do_compose_1873
do_apply_1874:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1876
do_compose_1873:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1876
do_concat_1875:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1876:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1783
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1879
    tst x0, #1
    b.ne do_compose_1877
do_apply_1878:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1880
do_compose_1877:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1880
do_concat_1879:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1880:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1783
    adr x0, init_parser
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1883
    tst x0, #1
    b.ne do_compose_1881
do_apply_1882:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1884
do_compose_1881:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1884
do_concat_1883:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1884:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1783
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.ne blk_end_1783
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_3
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1783
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1783
    adr x0, _print_ast
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
blk_end_1783:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1781_1782:
    // Closure for func_1781
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1781
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1776
cond_false_1775:
    adr x0, sign_id
cond_end_1776:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _print_ast
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1905
    tst x0, #1
    b.ne do_compose_1903
do_apply_1904:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1906
do_compose_1903:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1906
do_concat_1905:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1906:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1901
    b after_func_1907_1908
func_1907:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1912
    adr x0, sign_id
    b cmp_end_1913
cmp_true_1912:
cmp_end_1913:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1910
    mov x0, #0
    b cond_end_1911
cond_false_1910:
    adr x0, sign_id
cond_end_1911:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, List
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1914
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1916
xor_true_1914:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1915
    adr x0, sign_id
    b xor_end_1916
xor_false_1915:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, of
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
    str x0, [sp, #-16]!
    adr x0, Defs
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, ast_def
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1927
    adr x0, sign_id
    b cmp_end_1928
cmp_true_1927:
cmp_end_1928:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1925
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_4
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1932
    tst x0, #1
    b.ne do_compose_1930
do_apply_1931:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1933
do_compose_1930:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1933
do_concat_1932:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1933:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1936
    tst x0, #1
    b.ne do_compose_1934
do_apply_1935:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1937
do_compose_1934:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1937
do_concat_1936:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1937:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_5
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1940
    tst x0, #1
    b.ne do_compose_1938
do_apply_1939:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1941
do_compose_1938:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1941
do_concat_1940:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1941:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, TODO
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1942
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1944
xor_true_1942:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1943
    adr x0, sign_id
    b xor_end_1944
xor_false_1943:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, print
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
    str x0, [sp, #-16]!
    adr x0, args
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1951
    tst x0, #1
    b.ne do_compose_1949
do_apply_1950:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1952
do_compose_1949:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1952
do_concat_1951:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1952:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1955
    tst x0, #1
    b.ne do_compose_1953
do_apply_1954:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1956
do_compose_1953:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1956
do_concat_1955:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1956:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    adr x0, _print_ast
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1959
    tst x0, #1
    b.ne do_compose_1957
do_apply_1958:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1960
do_compose_1957:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1960
do_concat_1959:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1960:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    adr x0, print_str
    str x0, [sp, #-16]!
    mov x0, #41
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1963
    tst x0, #1
    b.ne do_compose_1961
do_apply_1962:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1964
do_compose_1961:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1964
do_concat_1963:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1964:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1967
    tst x0, #1
    b.ne do_compose_1965
do_apply_1966:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1968
do_compose_1965:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1968
do_concat_1967:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1968:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1929
    mov x0, #0
blk_end_1929:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1971
    tst x0, #1
    b.ne do_compose_1969
do_apply_1970:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1972
do_compose_1969:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1972
do_concat_1971:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1972:
    b cond_end_1926
cond_false_1925:
    adr x0, sign_id
cond_end_1926:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1975
    adr x0, sign_id
    b cmp_end_1976
cmp_true_1975:
cmp_end_1976:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1973
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1980
    tst x0, #1
    b.ne do_compose_1978
do_apply_1979:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1981
do_compose_1978:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1981
do_concat_1980:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1981:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1977
    adr x0, _print_ast
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1984
    tst x0, #1
    b.ne do_compose_1982
do_apply_1983:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1985
do_compose_1982:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1985
do_concat_1984:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1985:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1977
    adr x0, print_str
    str x0, [sp, #-16]!
    mov x0, #41
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1988
    tst x0, #1
    b.ne do_compose_1986
do_apply_1987:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1989
do_compose_1986:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1989
do_concat_1988:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1989:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1977
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1992
    tst x0, #1
    b.ne do_compose_1990
do_apply_1991:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1993
do_compose_1990:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1993
do_concat_1992:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1993:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1977
    mov x0, #0
blk_end_1977:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_1996
    tst x0, #1
    b.ne do_compose_1994
do_apply_1995:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1997
do_compose_1994:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1997
do_concat_1996:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_1997:
    b cond_end_1974
cond_false_1973:
    adr x0, sign_id
cond_end_1974:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2000
    adr x0, sign_id
    b cmp_end_2001
cmp_true_2000:
cmp_end_2001:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1998
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_8
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2005
    tst x0, #1
    b.ne do_compose_2003
do_apply_2004:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2006
do_compose_2003:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2006
do_concat_2005:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2006:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2002
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2002
    adr x0, _print_ast
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2009
    tst x0, #1
    b.ne do_compose_2007
do_apply_2008:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2010
do_compose_2007:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2010
do_concat_2009:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2010:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2002
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #32
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2013
    tst x0, #1
    b.ne do_compose_2011
do_apply_2012:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2014
do_compose_2011:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2014
do_concat_2013:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2014:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2002
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
    b.ne blk_end_2002
    adr x0, _print_ast
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2017
    tst x0, #1
    b.ne do_compose_2015
do_apply_2016:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2018
do_compose_2015:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2018
do_concat_2017:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2018:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2002
    adr x0, print_str
    str x0, [sp, #-16]!
    mov x0, #41
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2021
    tst x0, #1
    b.ne do_compose_2019
do_apply_2020:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2022
do_compose_2019:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2022
do_concat_2021:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2022:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2002
    mov x0, #0
blk_end_2002:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2025
    tst x0, #1
    b.ne do_compose_2023
do_apply_2024:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2026
do_compose_2023:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2026
do_concat_2025:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2026:
    b cond_end_1999
cond_false_1998:
    adr x0, sign_id
cond_end_1999:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2029
    adr x0, sign_id
    b cmp_end_2030
cmp_true_2029:
cmp_end_2030:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2027
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    mov x0, #40
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2034
    tst x0, #1
    b.ne do_compose_2032
do_apply_2033:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2035
do_compose_2032:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2035
do_concat_2034:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2035:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2031
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2031
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2038
    tst x0, #1
    b.ne do_compose_2036
do_apply_2037:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2039
do_compose_2036:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2039
do_concat_2038:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2039:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2031
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #32
    str x0, [sp, #-16]!
    adr x0, space
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2040
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2042
xor_true_2040:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2041
    adr x0, sign_id
    b xor_end_2042
xor_false_2041:
    mov x0, x1
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2045
    tst x0, #1
    b.ne do_compose_2043
do_apply_2044:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2046
do_compose_2043:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2046
do_concat_2045:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2046:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2031
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
    b.ne blk_end_2031
    adr x0, _print_ast
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2049
    tst x0, #1
    b.ne do_compose_2047
do_apply_2048:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2050
do_compose_2047:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2050
do_concat_2049:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2050:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2031
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #32
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
    b.ne blk_end_2031
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2031
    adr x0, _print_ast
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2031
    adr x0, print_str
    str x0, [sp, #-16]!
    mov x0, #41
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2031
    mov x0, #0
blk_end_2031:
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
    b cond_end_2028
cond_false_2027:
    adr x0, sign_id
cond_end_2028:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2069
    adr x0, sign_id
    b cmp_end_2070
cmp_true_2069:
cmp_end_2070:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2067
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2074
    tst x0, #1
    b.ne do_compose_2072
do_apply_2073:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2075
do_compose_2072:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2075
do_concat_2074:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2075:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2071
    adr x0, print_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2078
    tst x0, #1
    b.ne do_compose_2076
do_apply_2077:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2079
do_compose_2076:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2079
do_concat_2078:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2079:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2071
    adr x0, print_str
    str x0, [sp, #-16]!
    mov x0, #41
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
    b.ne blk_end_2071
    mov x0, #0
blk_end_2071:
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
    b cond_end_2068
cond_false_2067:
    adr x0, sign_id
cond_end_2068:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2090
    adr x0, sign_id
    b cmp_end_2091
cmp_true_2090:
cmp_end_2091:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2088
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_10
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2095
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2095
    adr x0, print_str
    str x0, [sp, #-16]!
    mov x0, #41
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2095
    mov x0, #0
blk_end_2095:
    str x0, [sp, #-16]!
    adr x0, If
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_2092
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2094
xor_true_2092:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_2093
    adr x0, sign_id
    b xor_end_2094
xor_false_2093:
    mov x0, x1
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
    str x0, [sp, #-16]!
    adr x0, it
    str x0, [sp, #-16]!
    adr x0, str_11
    mov x1, x0
    ldr x0, [sp], #16
    bl _dict_get
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
    adr x0, a
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
    str x0, [sp, #-16]!
    adr x0, list
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
    adr x0, Program
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
    adr x0, iterate
    ldr x1, [sp], #16
    bl _cons
    b cond_end_2089
cond_false_2088:
    adr x0, sign_id
cond_end_2089:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    adr x0, _print_ast
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1909
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_2138
    tst x0, #1
    b.ne do_compose_2136
do_apply_2137:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2139
do_compose_2136:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2139
do_concat_2138:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_2139:
blk_end_1909:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1907_1908:
    // Closure for func_1907
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1907
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1902
cond_false_1901:
    adr x0, sign_id
cond_end_1902:
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
    .asciz "#mai"
str_1:
    .asciz ""
str_2:
    .asciz "Source: "
str_3:
    .asciz "AST Generated."
str_4:
    .asciz "(DEF "
str_5:
    .asciz " ARGS "
str_6:
    .asciz " BODY "
str_7:
    .asciz "(BLOCK "
str_8:
    .asciz "(APPLY "
str_9:
    .asciz "(NUM "
str_10:
    .asciz "(ID "
str_11:
    .asciz "s"
