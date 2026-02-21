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
    adr x0, Pure
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
    adr x0, Functional
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
    str x0, [sp, #-16]!
    adr x0, Lexer
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
    adr x0, Version
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
    str x0, [sp, #-16]!
    b after_is_space_impl_21
is_space_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_22
    adr x0, sign_id
    b cmp_end_23
cmp_true_22:
cmp_end_23:
    str x0, [sp, #-16]!
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_26
    b or_end_27
or_right_26:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_28
    adr x0, sign_id
    b cmp_end_29
cmp_true_28:
cmp_end_29:
or_end_27:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_24
    b or_end_25
or_right_24:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_30
    adr x0, sign_id
    b cmp_end_31
cmp_true_30:
cmp_end_31:
or_end_25:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_34
    tst x0, #1
    b.ne do_compose_32
do_apply_33:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_35
do_compose_32:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_35
do_concat_34:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_35:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_space_impl_21:
    // Closure for is_space_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, is_space_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_is_digit_impl_36
is_digit_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_37
    adr x0, sign_id
    b cmp_end_38
cmp_true_37:
cmp_end_38:
    str x0, [sp, #-16]!
    mov x0, #0
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
    str x0, [sp, #-16]!
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_43
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_45
    adr x0, sign_id
    b cmp_end_46
cmp_true_45:
cmp_end_46:
    b and_end_44
and_fail_43:
    adr x0, sign_id
and_end_44:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_49
    tst x0, #1
    b.ne do_compose_47
do_apply_48:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_50
do_compose_47:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_50
do_concat_49:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_50:
    str x0, [sp, #-16]!
    mov x0, #9
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_53
    tst x0, #1
    b.ne do_compose_51
do_apply_52:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_54
do_compose_51:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_54
do_concat_53:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_54:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_57
    tst x0, #1
    b.ne do_compose_55
do_apply_56:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_58
do_compose_55:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_58
do_concat_57:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_58:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_digit_impl_36:
    // Closure for is_digit_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, is_digit_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_is_alpha_impl_59
is_alpha_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_64
    adr x0, sign_id
    b cmp_end_65
cmp_true_64:
cmp_end_65:
    str x0, [sp, #-16]!
    adr x0, A
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
    str x0, [sp, #-16]!
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_70
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_72
    adr x0, sign_id
    b cmp_end_73
cmp_true_72:
cmp_end_73:
    b and_end_71
and_fail_70:
    adr x0, sign_id
and_end_71:
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
    adr x0, Z
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
    str x0, [sp, #-16]!
    adr x0, "
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_84
    tst x0, #1
    b.ne do_compose_82
do_apply_83:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_85
do_compose_82:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_85
do_concat_84:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_85:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_62
    b or_end_63
or_right_62:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_86
    adr x0, sign_id
    b cmp_end_87
cmp_true_86:
cmp_end_87:
    str x0, [sp, #-16]!
    adr x0, a
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_90
    tst x0, #1
    b.ne do_compose_88
do_apply_89:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_91
do_compose_88:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_91
do_concat_90:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_91:
    str x0, [sp, #-16]!
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_92
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_94
    adr x0, sign_id
    b cmp_end_95
cmp_true_94:
cmp_end_95:
    b and_end_93
and_fail_92:
    adr x0, sign_id
and_end_93:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_98
    tst x0, #1
    b.ne do_compose_96
do_apply_97:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_99
do_compose_96:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_99
do_concat_98:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_99:
    str x0, [sp, #-16]!
    adr x0, z
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_102
    tst x0, #1
    b.ne do_compose_100
do_apply_101:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_103
do_compose_100:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_103
do_concat_102:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_103:
    str x0, [sp, #-16]!
    adr x0, "
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_106
    tst x0, #1
    b.ne do_compose_104
do_apply_105:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_107
do_compose_104:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_107
do_concat_106:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_107:
or_end_63:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_60
    b or_end_61
or_right_60:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_108
    adr x0, sign_id
    b cmp_end_109
cmp_true_108:
cmp_end_109:
or_end_61:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_112
    tst x0, #1
    b.ne do_compose_110
do_apply_111:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_113
do_compose_110:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_113
do_concat_112:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_113:
    str x0, [sp, #-16]!
    adr x0, "
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_alpha_impl_59:
    // Closure for is_alpha_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, is_alpha_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_is_op_char_impl_118
is_op_char_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_119_120
func_119:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_121_122
func_121:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_125
    b or_end_126
or_right_125:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_127
    adr x0, sign_id
    b cmp_end_128
cmp_true_127:
cmp_end_128:
or_end_126:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_123
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_132
    b or_end_133
or_right_132:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_134
    adr x0, sign_id
    b cmp_end_135
cmp_true_134:
cmp_end_135:
or_end_133:
    str x0, [sp, #-16]!
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_136
    b or_end_137
or_right_136:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_138
    adr x0, sign_id
    b cmp_end_139
cmp_true_138:
cmp_end_139:
or_end_137:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_129
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_131
xor_true_129:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_130
    adr x0, sign_id
    b xor_end_131
xor_false_130:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    bl _range
    b cond_end_124
cond_false_123:
    adr x0, sign_id
cond_end_124:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_121_122:
    // Closure for func_121
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_121
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_119_120:
    // Closure for func_119
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_119
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_op_char_impl_118:
    // Closure for is_op_char_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, is_op_char_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_length_impl_140
length_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_144
    adr x0, sign_id
    b cmp_end_145
cmp_true_144:
cmp_end_145:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_142
    mov x0, #0
    b cond_end_143
cond_false_142:
    adr x0, sign_id
cond_end_143:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_141
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, length
    ldr x0, [x0]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_148
    tst x0, #1
    b.ne do_compose_146
do_apply_147:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_149
do_compose_146:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_149
do_concat_148:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_149:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_152
    tst x0, #1
    b.ne do_compose_150
do_apply_151:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_153
do_compose_150:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_153
do_concat_152:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_153:
blk_end_141:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_length_impl_140:
    // Closure for length_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, length_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_reverse_impl_154
reverse_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _rev
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_161
    tst x0, #1
    b.ne do_compose_159
do_apply_160:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_162
do_compose_159:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_162
do_concat_161:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_162:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_reverse_impl_154:
    // Closure for reverse_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, reverse_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_163_164
func_163:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_166
    b or_end_167
or_right_166:
    adr x0, list
or_end_167:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_165
    b after_func_168_169
func_168:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, list
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
    ldr x0, [x29, #-32]
    b cond_end_172
cond_false_171:
    adr x0, sign_id
cond_end_172:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_170
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
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
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
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
blk_end_170:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_168_169:
    // Closure for func_168
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_168
    ldr x0, [sp], #16
    bl _cons
blk_end_165:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_163_164:
    // Closure for func_163
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_163
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_list_to_string_impl_191
list_to_string_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_192_193
func_192:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_195
    b or_end_196
or_right_195:
    adr x0, length
    ldr x0, [x0]
or_end_196:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_194
    b after_func_197_198
func_197:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_199_200
func_199:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_202
    b or_end_203
or_right_202:
    adr x0, alloc
or_end_203:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_201
    b after_func_204_205
func_204:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    adr x0, _write_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_209
    tst x0, #1
    b.ne do_compose_207
do_apply_208:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_210
do_compose_207:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_210
do_concat_209:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_210:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.ne blk_end_206
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_206
    ldr x0, [x29, #-48]
blk_end_206:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_204_205:
    // Closure for func_204
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_204
    ldr x0, [sp], #16
    bl _cons
blk_end_201:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_199_200:
    // Closure for func_199
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
    adr x1, func_199
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_197_198:
    // Closure for func_197
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_197
    ldr x0, [sp], #16
    bl _cons
blk_end_194:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_192_193:
    // Closure for func_192
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_192
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_list_to_string_impl_191:
    // Closure for list_to_string_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, list_to_string_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_219_220
func_219:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_222
    b or_end_223
or_right_222:
    adr x0, list
or_end_223:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_221
    b after_func_224_225
func_224:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_226_227
func_226:
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
    adr x0, list
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_231
    adr x0, sign_id
    b cmp_end_232
cmp_true_231:
cmp_end_232:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_229
    mov x0, #0
    b cond_end_230
cond_false_229:
    adr x0, sign_id
cond_end_230:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_228
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_235
    tst x0, #1
    b.ne do_compose_233
do_apply_234:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_236
do_compose_233:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_236
do_concat_235:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_236:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_228
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_239
    tst x0, #1
    b.ne do_compose_237
do_apply_238:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_240
do_compose_237:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_240
do_concat_239:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_240:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_243
    tst x0, #1
    b.ne do_compose_241
do_apply_242:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_244
do_compose_241:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_244
do_concat_243:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_244:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_247
    tst x0, #1
    b.ne do_compose_245
do_apply_246:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_248
do_compose_245:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_248
do_concat_247:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_248:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_251
    tst x0, #1
    b.ne do_compose_249
do_apply_250:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_252
do_compose_249:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_252
do_concat_251:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_252:
blk_end_228:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_226_227:
    // Closure for func_226
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
    adr x1, func_226
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_224_225:
    // Closure for func_224
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_224
    ldr x0, [sp], #16
    bl _cons
blk_end_221:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_219_220:
    // Closure for func_219
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_219
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_tokenize_impl_253
tokenize_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_256
    tst x0, #1
    b.ne do_compose_254
do_apply_255:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_257
do_compose_254:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_257
do_concat_256:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_257:
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_260
    tst x0, #1
    b.ne do_compose_258
do_apply_259:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_261
do_compose_258:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_261
do_concat_260:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_261:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_264
    tst x0, #1
    b.ne do_compose_262
do_apply_263:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_265
do_compose_262:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_265
do_concat_264:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_265:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_268
    tst x0, #1
    b.ne do_compose_266
do_apply_267:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_269
do_compose_266:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_269
do_concat_268:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_269:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_tokenize_impl_253:
    // Closure for tokenize_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, tokenize_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after__tokenize_loop_impl_270
_tokenize_loop_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_271_272
func_271:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_278
    b or_end_279
or_right_278:
    adr x0, scan_token
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
    b after_func_282_283
func_282:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_284_285
func_284:
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
    b after_func_286_287
func_286:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_289
    b or_end_290
or_right_289:
    adr x0, head
or_end_290:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_288
    b after_func_291_292
func_291:
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
    b after_func_293_294
func_293:
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_296
    b or_end_297
or_right_296:
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
or_end_297:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_295
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_300
    adr x0, sign_id
    b cmp_end_301
cmp_true_300:
cmp_end_301:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_298
    ldr x0, [x29, #-48]
    b cond_end_299
cond_false_298:
    adr x0, sign_id
cond_end_299:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_295
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    ldr x1, [sp], #16
    bl _cons
blk_end_295:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_293_294:
    // Closure for func_293
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_293
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_291_292:
    // Closure for func_291
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
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_291
    ldr x0, [sp], #16
    bl _cons
blk_end_288:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_286_287:
    // Closure for func_286
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
    adr x1, func_286
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_284_285:
    // Closure for func_284
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
    adr x1, func_284
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_282_283:
    // Closure for func_282
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_282
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_271_272:
    // Closure for func_271
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_271
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after__tokenize_loop_impl_270:
    // Closure for _tokenize_loop_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, _tokenize_loop_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_scan_token_impl_322
scan_token_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_323_324
func_323:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_325_326
func_325:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_327_328
func_327:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_330
    b or_end_331
or_right_330:
    adr x0, nth
or_end_331:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_329
    b after_func_332_333
func_332:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_334_335
func_334:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_336_337
func_336:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_339
    b or_end_340
or_right_339:
    adr x0, scan_num
or_end_340:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_338
    b after_func_341_342
func_341:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_343_344
func_343:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_345_346
func_345:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_347_348
func_347:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_350
    b or_end_351
or_right_350:
    adr x0, head
or_end_351:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_349
    b after_func_352_353
func_352:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_354_355
func_354:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_357
    b or_end_358
or_right_357:
    adr x0, _parse_int
or_end_358:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_356
    b after_func_359_360
func_359:
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
    b after_func_361_362
func_361:
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_364
    b or_end_365
or_right_364:
    adr x0, scan_id
or_end_365:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_363
    b after_func_366_367
func_366:
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
    b after_func_368_369
func_368:
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
    b after_func_370_371
func_370:
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
    b after_func_372_373
func_372:
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_375
    b or_end_376
or_right_375:
    adr x0, scan_op
or_end_376:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_374
    b after_func_377_378
func_377:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_379_380
func_379:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_381_382
func_381:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_383_384
func_383:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_386
    b or_end_387
or_right_386:
    adr x0, scan_str
or_end_387:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_385
    b after_func_388_389
func_388:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_390_391
func_390:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_392_393
func_392:
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
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_397
    adr x0, sign_id
    b cmp_end_398
cmp_true_397:
cmp_end_398:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_395
    adr x0, sign_id
    b cond_end_396
cond_false_395:
    adr x0, sign_id
cond_end_396:
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_401
    tst x0, #1
    b.ne do_compose_399
do_apply_400:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_402
do_compose_399:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_402
do_concat_401:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_402:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_394
    adr x0, is_space
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_405
    tst x0, #1
    b.ne do_compose_403
do_apply_404:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_406
do_compose_403:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_406
do_concat_405:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_406:
    str x0, [sp, #-16]!
    adr x0, scan_token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_409
    tst x0, #1
    b.ne do_compose_407
do_apply_408:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_410
do_compose_407:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_410
do_concat_409:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_410:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_413
    tst x0, #1
    b.ne do_compose_411
do_apply_412:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_414
do_compose_411:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_414
do_concat_413:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_414:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_417
    tst x0, #1
    b.ne do_compose_415
do_apply_416:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_418
do_compose_415:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_418
do_concat_417:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_418:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_421
    tst x0, #1
    b.ne do_compose_419
do_apply_420:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_422
do_compose_419:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_422
do_concat_421:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_422:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_394
    ldr x0, [x29, #-176]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_425
    adr x0, sign_id
    b cmp_end_426
cmp_true_425:
cmp_end_426:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_423
    adr x0, sign_id
    b cond_end_424
cond_false_423:
    adr x0, sign_id
cond_end_424:
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_429
    tst x0, #1
    b.ne do_compose_427
do_apply_428:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_430
do_compose_427:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_430
do_concat_429:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_430:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_394
    adr x0, is_digit
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_437
    tst x0, #1
    b.ne do_compose_435
do_apply_436:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_438
do_compose_435:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_438
do_concat_437:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_438:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_441
    tst x0, #1
    b.ne do_compose_439
do_apply_440:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_442
do_compose_439:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_442
do_concat_441:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_442:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_445
    tst x0, #1
    b.ne do_compose_443
do_apply_444:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_446
do_compose_443:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_446
do_concat_445:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_446:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_394
    adr x0, is_alpha
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_449
    tst x0, #1
    b.ne do_compose_447
do_apply_448:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_450
do_compose_447:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_450
do_concat_449:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_450:
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_453
    tst x0, #1
    b.ne do_compose_451
do_apply_452:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_454
do_compose_451:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_454
do_concat_453:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_454:
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_457
    tst x0, #1
    b.ne do_compose_455
do_apply_456:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_458
do_compose_455:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_458
do_concat_457:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_458:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_461
    tst x0, #1
    b.ne do_compose_459
do_apply_460:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_462
do_compose_459:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_462
do_concat_461:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_462:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_465
    tst x0, #1
    b.ne do_compose_463
do_apply_464:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_466
do_compose_463:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_466
do_concat_465:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_466:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_394
    adr x0, is_op_char
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_469
    tst x0, #1
    b.ne do_compose_467
do_apply_468:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_470
do_compose_467:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_470
do_concat_469:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_470:
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
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
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_481
    tst x0, #1
    b.ne do_compose_479
do_apply_480:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_482
do_compose_479:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_482
do_concat_481:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_482:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_485
    tst x0, #1
    b.ne do_compose_483
do_apply_484:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_486
do_compose_483:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_486
do_concat_485:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_486:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_394
    ldr x0, [x29, #-224]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_487
    adr x0, sign_id
    b cmp_end_488
cmp_true_487:
cmp_end_488:
    str x0, [sp, #-16]!
    adr x0, str_0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_491
    tst x0, #1
    b.ne do_compose_489
do_apply_490:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_492
do_compose_489:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_492
do_concat_491:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_492:
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_499
    tst x0, #1
    b.ne do_compose_497
do_apply_498:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_500
do_compose_497:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_500
do_concat_499:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_500:
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_503
    tst x0, #1
    b.ne do_compose_501
do_apply_502:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_504
do_compose_501:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_504
do_concat_503:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_504:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_507
    tst x0, #1
    b.ne do_compose_505
do_apply_506:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_508
do_compose_505:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_508
do_concat_507:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_508:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_511
    tst x0, #1
    b.ne do_compose_509
do_apply_510:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_512
do_compose_509:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_512
do_concat_511:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_512:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_394
    adr x0, str_1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_394
    adr x0, tok_punc
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_394:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_392_393:
    // Closure for func_392
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_390
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_388_389:
    // Closure for func_388
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_388
    ldr x0, [sp], #16
    bl _cons
blk_end_385:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_383_384:
    // Closure for func_383
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_383
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_381_382:
    // Closure for func_381
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_381
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_379_380:
    // Closure for func_379
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_379
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_377_378:
    // Closure for func_377
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_377
    ldr x0, [sp], #16
    bl _cons
blk_end_374:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_372_373:
    // Closure for func_372
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_372
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_370_371:
    // Closure for func_370
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_370
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_368_369:
    // Closure for func_368
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_368
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_366_367:
    // Closure for func_366
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_366
    ldr x0, [sp], #16
    bl _cons
blk_end_363:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_361_362:
    // Closure for func_361
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_361
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_359_360:
    // Closure for func_359
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_359
    ldr x0, [sp], #16
    bl _cons
blk_end_356:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_354_355:
    // Closure for func_354
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
    adr x1, func_354
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_352_353:
    // Closure for func_352
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_352
    ldr x0, [sp], #16
    bl _cons
blk_end_349:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_347_348:
    // Closure for func_347
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_347
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_345_346:
    // Closure for func_345
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_343
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_341_342:
    // Closure for func_341
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_341
    ldr x0, [sp], #16
    bl _cons
blk_end_338:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_336_337:
    // Closure for func_336
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_336
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_334_335:
    // Closure for func_334
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_332
    ldr x0, [sp], #16
    bl _cons
blk_end_329:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_325_326:
    // Closure for func_325
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_325
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_323_324:
    // Closure for func_323
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_323
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_scan_token_impl_322:
    // Closure for scan_token_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, scan_token_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_513_514
func_513:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_516
    b or_end_517
or_right_516:
    adr x0, source
or_end_517:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_515
    b after_func_518_519
func_518:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_520_521
func_520:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _scan_while
    str x0, [sp, #-16]!
    adr x0, source
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
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, is_digit
    ldr x0, [x0]
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_520
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_518_519:
    // Closure for func_518
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_518
    ldr x0, [sp], #16
    bl _cons
blk_end_515:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_513_514:
    // Closure for func_513
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_513
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_538_539
func_538:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_541
    b or_end_542
or_right_541:
    adr x0, source
or_end_542:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_540
    b after_func_543_544
func_543:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_545_546
func_545:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, str_2
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_547
    adr x0, _scan_while
    str x0, [sp, #-16]!
    adr x0, source
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
    ldr x0, [x29, #-48]
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
    b after_func_560_561
func_560:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_562
    b or_end_563
or_right_562:
    adr x0, is_digit
    ldr x0, [x0]
or_end_563:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
blk_end_547:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_545_546:
    // Closure for func_545
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_545
    ldr x0, [sp], #16
    bl _cons
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
blk_end_540:
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
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_576_577
func_576:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_579
    b or_end_580
or_right_579:
    adr x0, source
or_end_580:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_578
    b after_func_581_582
func_581:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_583_584
func_583:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _scan_while
    str x0, [sp, #-16]!
    adr x0, source
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
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, is_op_char
    ldr x0, [x0]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_599
    tst x0, #1
    b.ne do_compose_597
do_apply_598:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_600
do_compose_597:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_600
do_concat_599:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_600:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_583_584:
    // Closure for func_583
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_583
    ldr x0, [sp], #16
    bl _cons
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
blk_end_578:
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
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after__scan_while_impl_601
_scan_while_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_602_603
func_602:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_604_605
func_604:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_611
    b or_end_612
or_right_611:
    adr x0, _scan_while_rec
or_end_612:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_610
    b after_func_613_614
func_613:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_615_616
func_615:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    b after_func_621_622
func_621:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_623_624
func_623:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_626
    b or_end_627
or_right_626:
    adr x0, head
or_end_627:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_625
    b after_func_628_629
func_628:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_630_631
func_630:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_633
    b or_end_634
or_right_633:
    adr x0, reverse
    ldr x0, [x0]
or_end_634:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_632
    b after_func_635_636
func_635:
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
    adr x0, list_to_string
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_639
    tst x0, #1
    b.ne do_compose_637
do_apply_638:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_640
do_compose_637:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_640
do_concat_639:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_640:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_635_636:
    // Closure for func_635
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x1, func_635
    ldr x0, [sp], #16
    bl _cons
blk_end_632:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_630_631:
    // Closure for func_630
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_630
    ldr x0, [sp], #16
    bl _cons
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
blk_end_625:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_623_624:
    // Closure for func_623
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_623
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_621_622:
    // Closure for func_621
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_621
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_619_620:
    // Closure for func_619
    adr x0, sign_id
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_613_614:
    // Closure for func_613
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_613
    ldr x0, [sp], #16
    bl _cons
blk_end_610:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_608_609:
    // Closure for func_608
    adr x0, sign_id
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_604_605:
    // Closure for func_604
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_604
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after__scan_while_impl_601:
    // Closure for _scan_while_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, _scan_while_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_649_650
func_649:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_652
    b or_end_653
or_right_652:
    adr x0, source
or_end_653:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_651
    b after_func_654_655
func_654:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_656_657
func_656:
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
    b after_func_658_659
func_658:
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
    b after_func_660_661
func_660:
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
    b.ge cmp_true_665
    adr x0, sign_id
    b cmp_end_666
cmp_true_665:
cmp_end_666:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_663
    adr x0, sign_id
    b cond_end_664
cond_false_663:
    adr x0, sign_id
cond_end_664:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
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
    b.ne blk_end_662
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_677
    tst x0, #1
    b.ne do_compose_675
do_apply_676:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_678
do_compose_675:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_678
do_concat_677:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_678:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_662
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_681
    tst x0, #1
    b.ne do_compose_679
do_apply_680:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_682
do_compose_679:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_682
do_concat_681:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_682:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_662
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_662:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_660_661:
    // Closure for func_660
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
    adr x1, func_660
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_658_659:
    // Closure for func_658
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
    adr x1, func_658
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_656_657:
    // Closure for func_656
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
    adr x1, func_656
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_654_655:
    // Closure for func_654
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_654
    ldr x0, [sp], #16
    bl _cons
blk_end_651:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_649_650:
    // Closure for func_649
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_649
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_scan_str_impl_707
scan_str_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_708_709
func_708:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_710_711
func_710:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_712_713
func_712:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_715
    b or_end_716
or_right_715:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
or_end_716:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_714
    b after_func_717_718
func_717:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_720
    b or_end_721
or_right_720:
    adr x0, _scan_str_rec
or_end_721:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_719
    b after_func_722_723
func_722:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_724_725
func_724:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_726_727
func_726:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_728_729
func_728:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_730_731
func_730:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_733
    b or_end_734
or_right_733:
    adr x0, head
or_end_734:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_732
    b after_func_735_736
func_735:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_737_738
func_737:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_740
    b or_end_741
or_right_740:
    adr x0, reverse
    ldr x0, [x0]
or_end_741:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_739
    b after_func_742_743
func_742:
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
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_744
    adr x0, list_to_string
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_744:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_742_743:
    // Closure for func_742
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x1, func_742
    ldr x0, [sp], #16
    bl _cons
blk_end_739:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_737_738:
    // Closure for func_737
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_737
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_735_736:
    // Closure for func_735
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_735
    ldr x0, [sp], #16
    bl _cons
blk_end_732:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_730_731:
    // Closure for func_730
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_730
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_728_729:
    // Closure for func_728
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_728
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_724_725:
    // Closure for func_724
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_724
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_722_723:
    // Closure for func_722
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_722
    ldr x0, [sp], #16
    bl _cons
blk_end_719:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_717_718:
    // Closure for func_717
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_717
    ldr x0, [sp], #16
    bl _cons
blk_end_714:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_712_713:
    // Closure for func_712
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_712
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_710_711:
    // Closure for func_710
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_710
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_708_709:
    // Closure for func_708
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_708
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_scan_str_impl_707:
    // Closure for scan_str_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, scan_str_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_757_758
func_757:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_760
    b or_end_761
or_right_760:
    adr x0, source
or_end_761:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_759
    b after_func_762_763
func_762:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_764_765
func_764:
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
    b after_func_766_767
func_766:
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
    b.ge cmp_true_771
    adr x0, sign_id
    b cmp_end_772
cmp_true_771:
cmp_end_772:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_769
    adr x0, sign_id
    b cond_end_770
cond_false_769:
    adr x0, sign_id
cond_end_770:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
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
    b.ne blk_end_768
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_768
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_787
    adr x0, sign_id
    b cmp_end_788
cmp_true_787:
cmp_end_788:
    str x0, [sp, #-16]!
    adr x0, str_0
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
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_793
    b or_end_794
or_right_793:
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_795
    adr x0, sign_id
    b cmp_end_796
cmp_true_795:
cmp_end_796:
or_end_794:
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_799
    tst x0, #1
    b.ne do_compose_797
do_apply_798:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_800
do_compose_797:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_800
do_concat_799:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_800:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_785
    adr x0, sign_id
    b cond_end_786
cond_false_785:
    adr x0, sign_id
cond_end_786:
    str x0, [sp, #-16]!
    adr x0, str_4
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_801
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_801:
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
    b.ne blk_end_768
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, source
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_808
    tst x0, #1
    b.ne do_compose_806
do_apply_807:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_809
do_compose_806:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_809
do_concat_808:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_809:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_812
    tst x0, #1
    b.ne do_compose_810
do_apply_811:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_813
do_compose_810:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_813
do_concat_812:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_813:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    tst x9, #1
    b.eq do_concat_816
    tst x0, #1
    b.ne do_compose_814
do_apply_815:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_817
do_compose_814:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_817
do_concat_816:
    mov x1, x0
    mov x0, x9
    bl _concat
apply_end_817:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
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
blk_end_768:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_766_767:
    // Closure for func_766
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
    adr x1, func_766
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_764_765:
    // Closure for func_764
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
    adr x1, func_764
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_762_763:
    // Closure for func_762
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_762
    ldr x0, [sp], #16
    bl _cons
blk_end_759:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_757_758:
    // Closure for func_757
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_757
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after__parse_int_impl_822
_parse_int_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after__parse_int_impl_822:
    // Closure for _parse_int_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, _parse_int_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
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
tok_eof: .quad 0
tok_id: .quad 0
tok_num: .quad 0
tok_str: .quad 0
tok_op: .quad 0
tok_punc: .quad 0
tok_sep: .quad 0
tok_unit: .quad 0
is_space: .quad 0
is_digit: .quad 0
is_alpha: .quad 0
is_op_char: .quad 0
length: .quad 0
reverse: .quad 0
list_to_string: .quad 0
tokenize: .quad 0
_tokenize_loop: .quad 0
scan_token: .quad 0
_scan_while: .quad 0
scan_str: .quad 0
_parse_int: .quad 0


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

