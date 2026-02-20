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
    cmp x0, #4096
    b.hi do_compose_1
do_apply_2:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3
do_compose_1:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_3:
    str x0, [sp, #-16]!
    adr x0, Functional
    cmp x0, #4096
    b.hi do_compose_4
do_apply_5:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_6
do_compose_4:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_6:
    str x0, [sp, #-16]!
    adr x0, Lexer
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
    str x0, [sp, #-16]!
    adr x0, Version
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
    b after_is_space_impl_16
is_space_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_21
    adr x0, sign_id
    b cmp_end_22
cmp_true_21:
cmp_end_22:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_19
    b or_end_20
or_right_19:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_23
    adr x0, sign_id
    b cmp_end_24
cmp_true_23:
cmp_end_24:
or_end_20:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_17
    b or_end_18
or_right_17:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_25
    adr x0, sign_id
    b cmp_end_26
cmp_true_25:
cmp_end_26:
or_end_18:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_space_impl_16:
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
    b after_is_digit_impl_27
is_digit_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_30
    adr x0, sign_id
    b cmp_end_31
cmp_true_30:
cmp_end_31:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_28
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_32
    adr x0, sign_id
    b cmp_end_33
cmp_true_32:
cmp_end_33:
    b and_end_29
and_fail_28:
    adr x0, sign_id
and_end_29:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_digit_impl_27:
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
    b after_is_alpha_impl_34
is_alpha_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_41
    adr x0, sign_id
    b cmp_end_42
cmp_true_41:
cmp_end_42:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_39
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_43
    adr x0, sign_id
    b cmp_end_44
cmp_true_43:
cmp_end_44:
    b and_end_40
and_fail_39:
    adr x0, sign_id
and_end_40:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_37
    b or_end_38
or_right_37:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_47
    adr x0, sign_id
    b cmp_end_48
cmp_true_47:
cmp_end_48:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_45
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_49
    adr x0, sign_id
    b cmp_end_50
cmp_true_49:
cmp_end_50:
    b and_end_46
and_fail_45:
    adr x0, sign_id
and_end_46:
or_end_38:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_35
    b or_end_36
or_right_35:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_51
    adr x0, sign_id
    b cmp_end_52
cmp_true_51:
cmp_end_52:
or_end_36:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_alpha_impl_34:
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
    b after_is_op_char_impl_53
is_op_char_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
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
    mov x0, #43
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
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_88
    adr x0, sign_id
    b cmp_end_89
cmp_true_88:
cmp_end_89:
or_end_81:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_78
    b or_end_79
or_right_78:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_90
    adr x0, sign_id
    b cmp_end_91
cmp_true_90:
cmp_end_91:
or_end_79:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_76
    b or_end_77
or_right_76:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_92
    adr x0, sign_id
    b cmp_end_93
cmp_true_92:
cmp_end_93:
or_end_77:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_74
    b or_end_75
or_right_74:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_94
    adr x0, sign_id
    b cmp_end_95
cmp_true_94:
cmp_end_95:
or_end_75:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_72
    b or_end_73
or_right_72:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_96
    adr x0, sign_id
    b cmp_end_97
cmp_true_96:
cmp_end_97:
or_end_73:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_70
    b or_end_71
or_right_70:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_98
    adr x0, sign_id
    b cmp_end_99
cmp_true_98:
cmp_end_99:
or_end_71:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_68
    b or_end_69
or_right_68:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_100
    adr x0, sign_id
    b cmp_end_101
cmp_true_100:
cmp_end_101:
or_end_69:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_66
    b or_end_67
or_right_66:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_102
    adr x0, sign_id
    b cmp_end_103
cmp_true_102:
cmp_end_103:
or_end_67:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_64
    b or_end_65
or_right_64:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_104
    adr x0, sign_id
    b cmp_end_105
cmp_true_104:
cmp_end_105:
or_end_65:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_62
    b or_end_63
or_right_62:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_106
    adr x0, sign_id
    b cmp_end_107
cmp_true_106:
cmp_end_107:
or_end_63:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_60
    b or_end_61
or_right_60:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_108
    adr x0, sign_id
    b cmp_end_109
cmp_true_108:
cmp_end_109:
or_end_61:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_58
    b or_end_59
or_right_58:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_110
    adr x0, sign_id
    b cmp_end_111
cmp_true_110:
cmp_end_111:
or_end_59:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_56
    b or_end_57
or_right_56:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_112
    adr x0, sign_id
    b cmp_end_113
cmp_true_112:
cmp_end_113:
or_end_57:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_54
    b or_end_55
or_right_54:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_114
    adr x0, sign_id
    b cmp_end_115
cmp_true_114:
cmp_end_115:
or_end_55:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_op_char_impl_53:
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
    b after_length_impl_116
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
    b.eq cmp_true_120
    adr x0, sign_id
    b cmp_end_121
cmp_true_120:
cmp_end_121:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_118
    mov x0, #0
    b cond_end_119
cond_false_118:
    adr x0, sign_id
cond_end_119:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_117
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
    cmp x0, #4096
    b.hi do_compose_122
do_apply_123:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_124
do_compose_122:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_124:
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
blk_end_117:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_length_impl_116:
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
    b after_reverse_impl_128
reverse_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _rev
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_129
do_apply_130:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_131
do_compose_129:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_131:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_132
do_apply_133:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_134
do_compose_132:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_134:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_reverse_impl_128:
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
    b after_func_135_136
func_135:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_138
    b or_end_139
or_right_138:
    adr x0, list
or_end_139:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_137
    b after_func_140_141
func_140:
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
    b.eq cmp_true_145
    adr x0, sign_id
    b cmp_end_146
cmp_true_145:
cmp_end_146:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_143
    ldr x0, [x29, #-32]
    b cond_end_144
cond_false_143:
    adr x0, sign_id
cond_end_144:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_142
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_147
do_apply_148:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_149
do_compose_147:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_149:
    cmp x0, #4096
    b.hi do_compose_150
do_apply_151:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_152
do_compose_150:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_152:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_156
do_apply_157:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_158
do_compose_156:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_158:
blk_end_142:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_140_141:
    // Closure for func_140
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_140
    ldr x0, [sp], #16
    bl _cons
blk_end_137:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_135_136:
    // Closure for func_135
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_135
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_list_to_string_impl_159
list_to_string_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_160_161
func_160:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_163
    b or_end_164
or_right_163:
    adr x0, length
    ldr x0, [x0]
or_end_164:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_162
    b after_func_165_166
func_165:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_167_168
func_167:
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
    b.eq or_right_170
    b or_end_171
or_right_170:
    adr x0, alloc
or_end_171:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_169
    b after_func_172_173
func_172:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    mov x0, #0
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
    b.ne blk_end_174
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
    b.ne blk_end_174
    ldr x0, [x29, #-48]
blk_end_174:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_172_173:
    // Closure for func_172
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
    adr x1, func_172
    ldr x0, [sp], #16
    bl _cons
blk_end_169:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_167_168:
    // Closure for func_167
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
    adr x1, func_167
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_165_166:
    // Closure for func_165
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_165
    ldr x0, [sp], #16
    bl _cons
blk_end_162:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_160_161:
    // Closure for func_160
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_160
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_list_to_string_impl_159:
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
    b after_func_184_185
func_184:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_187
    b or_end_188
or_right_187:
    adr x0, list
or_end_188:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_186
    b after_func_189_190
func_189:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_191_192
func_191:
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
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_198
do_apply_199:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_200
do_compose_198:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_200:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_193
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_201
do_apply_202:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_203
do_compose_201:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_203:
    cmp x0, #4096
    b.hi do_compose_204
do_apply_205:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_206
do_compose_204:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_206:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_207
do_apply_208:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_209
do_compose_207:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_209:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_210
do_apply_211:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_212
do_compose_210:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_212:
blk_end_193:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_191_192:
    // Closure for func_191
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
    adr x1, func_191
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_189_190:
    // Closure for func_189
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_189
    ldr x0, [sp], #16
    bl _cons
blk_end_186:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_184_185:
    // Closure for func_184
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_184
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_tokenize_impl_213
tokenize_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_214
do_apply_215:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_216
do_compose_214:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_216:
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_217
do_apply_218:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_219
do_compose_217:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_219:
    cmp x0, #4096
    b.hi do_compose_220
do_apply_221:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_222
do_compose_220:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_222:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_223
do_apply_224:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_225
do_compose_223:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_225:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_tokenize_impl_213:
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
    b after__tokenize_loop_impl_226
_tokenize_loop_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_227_228
func_227:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_234
    b or_end_235
or_right_234:
    adr x0, scan_token
or_end_235:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_233
    b after_func_236_237
func_236:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_238_239
func_238:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_240_241
func_240:
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
    b after_func_242_243
func_242:
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
    b.eq or_right_245
    b or_end_246
or_right_245:
    adr x0, head
or_end_246:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_244
    b after_func_247_248
func_247:
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
    b after_func_249_250
func_249:
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
    b.eq or_right_252
    b or_end_253
or_right_252:
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
or_end_253:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_251
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_256
    adr x0, sign_id
    b cmp_end_257
cmp_true_256:
cmp_end_257:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_254
    ldr x0, [x29, #-48]
    b cond_end_255
cond_false_254:
    adr x0, sign_id
cond_end_255:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_251
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_258
do_apply_259:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_260
do_compose_258:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_260:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_261
do_apply_262:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_263
do_compose_261:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_263:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    cmp x0, #4096
    b.hi do_compose_264
do_apply_265:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_266
do_compose_264:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_266:
    cmp x0, #4096
    b.hi do_compose_267
do_apply_268:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_269
do_compose_267:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_269:
    cmp x0, #4096
    b.hi do_compose_270
do_apply_271:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_272
do_compose_270:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_272:
    ldr x1, [sp], #16
    bl _cons
blk_end_251:
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
    adr x1, func_247
    ldr x0, [sp], #16
    bl _cons
blk_end_244:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_242_243:
    // Closure for func_242
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
    adr x1, func_242
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_238
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_236_237:
    // Closure for func_236
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_236
    ldr x0, [sp], #16
    bl _cons
blk_end_233:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_231_232:
    // Closure for func_231
    adr x0, sign_id
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after__tokenize_loop_impl_226:
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
    b after_scan_token_impl_273
scan_token_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_274_275
func_274:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_276_277
func_276:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_278_279
func_278:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_281
    b or_end_282
or_right_281:
    adr x0, nth
or_end_282:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_280
    b after_func_283_284
func_283:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_285_286
func_285:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_287_288
func_287:
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
    b.eq or_right_290
    b or_end_291
or_right_290:
    adr x0, scan_num
or_end_291:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_289
    b after_func_292_293
func_292:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_294_295
func_294:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_296_297
func_296:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_298_299
func_298:
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
    b.eq or_right_301
    b or_end_302
or_right_301:
    adr x0, head
or_end_302:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_300
    b after_func_303_304
func_303:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_305_306
func_305:
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
    b.eq or_right_308
    b or_end_309
or_right_308:
    adr x0, _parse_int
or_end_309:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_307
    b after_func_310_311
func_310:
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
    b after_func_312_313
func_312:
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
    b.eq or_right_315
    b or_end_316
or_right_315:
    adr x0, scan_id
or_end_316:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    b after_func_317_318
func_317:
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
    b after_func_319_320
func_319:
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
    b after_func_321_322
func_321:
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
    b after_func_323_324
func_323:
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
    b.eq or_right_326
    b or_end_327
or_right_326:
    adr x0, scan_op
or_end_327:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_325
    b after_func_328_329
func_328:
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
    b after_func_330_331
func_330:
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
    b after_func_332_333
func_332:
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
    b after_func_334_335
func_334:
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
    b.eq or_right_337
    b or_end_338
or_right_337:
    adr x0, scan_str
or_end_338:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_336
    b after_func_339_340
func_339:
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
    b after_func_341_342
func_341:
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
    b after_func_343_344
func_343:
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
    b.ge cmp_true_348
    adr x0, sign_id
    b cmp_end_349
cmp_true_348:
cmp_end_349:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_346
    adr x0, sign_id
    b cond_end_347
cond_false_346:
    adr x0, sign_id
cond_end_347:
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
    cmp x0, #4096
    b.hi do_compose_350
do_apply_351:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_352
do_compose_350:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_352:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_345
    adr x0, is_space
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_353
do_apply_354:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_355
do_compose_353:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_355:
    str x0, [sp, #-16]!
    adr x0, scan_token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_356
do_apply_357:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_358
do_compose_356:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_358:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_359
do_apply_360:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_361
do_compose_359:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_361:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_362
do_apply_363:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_364
do_compose_362:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_364:
    cmp x0, #4096
    b.hi do_compose_365
do_apply_366:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_367
do_compose_365:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_367:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_345
    ldr x0, [x29, #-176]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_370
    adr x0, sign_id
    b cmp_end_371
cmp_true_370:
cmp_end_371:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_368
    adr x0, sign_id
    b cond_end_369
cond_false_368:
    adr x0, sign_id
cond_end_369:
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
    cmp x0, #4096
    b.hi do_compose_372
do_apply_373:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_374
do_compose_372:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_374:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_345
    adr x0, is_digit
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_375
do_apply_376:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_377
do_compose_375:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_377:
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
    cmp x0, #4096
    b.hi do_compose_378
do_apply_379:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_380
do_compose_378:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_380:
    cmp x0, #4096
    b.hi do_compose_381
do_apply_382:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_383
do_compose_381:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_383:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_384
do_apply_385:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_386
do_compose_384:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_386:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_345
    adr x0, is_alpha
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_387
do_apply_388:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_389
do_compose_387:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_389:
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    cmp x0, #4096
    b.hi do_compose_390
do_apply_391:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_392
do_compose_390:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_392:
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    cmp x0, #4096
    b.hi do_compose_393
do_apply_394:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_395
do_compose_393:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_395:
    cmp x0, #4096
    b.hi do_compose_396
do_apply_397:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_398
do_compose_396:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_398:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_399
do_apply_400:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_401
do_compose_399:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_401:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_345
    adr x0, is_op_char
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_402
do_apply_403:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_404
do_compose_402:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_404:
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    cmp x0, #4096
    b.hi do_compose_405
do_apply_406:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_407
do_compose_405:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_407:
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    cmp x0, #4096
    b.hi do_compose_408
do_apply_409:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_410
do_compose_408:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_410:
    cmp x0, #4096
    b.hi do_compose_411
do_apply_412:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_413
do_compose_411:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_413:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_414
do_apply_415:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_416
do_compose_414:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_416:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_345
    ldr x0, [x29, #-224]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_419
    adr x0, sign_id
    b cmp_end_420
cmp_true_419:
cmp_end_420:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_417
    adr x0, sign_id
    b cond_end_418
cond_false_417:
    adr x0, sign_id
cond_end_418:
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    cmp x0, #4096
    b.hi do_compose_421
do_apply_422:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_423
do_compose_421:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_423:
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    cmp x0, #4096
    b.hi do_compose_424
do_apply_425:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_426
do_compose_424:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_426:
    cmp x0, #4096
    b.hi do_compose_427
do_apply_428:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_429
do_compose_427:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_429:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_430
do_apply_431:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_432
do_compose_430:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_432:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_345
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_345
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
blk_end_345:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_343_344:
    // Closure for func_343
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
    adr x1, func_341
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_339_340:
    // Closure for func_339
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
    adr x1, func_339
    ldr x0, [sp], #16
    bl _cons
blk_end_336:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_334_335:
    // Closure for func_334
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
    adr x1, func_332
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_330_331:
    // Closure for func_330
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
    adr x1, func_330
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_328_329:
    // Closure for func_328
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
    adr x1, func_328
    ldr x0, [sp], #16
    bl _cons
blk_end_325:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_323_324:
    // Closure for func_323
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
    adr x1, func_321
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_319_320:
    // Closure for func_319
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
    adr x1, func_319
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_317_318:
    // Closure for func_317
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
    adr x1, func_317
    ldr x0, [sp], #16
    bl _cons
blk_end_314:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_312_313:
    // Closure for func_312
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
    adr x1, func_312
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_310_311:
    // Closure for func_310
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
    adr x1, func_310
    ldr x0, [sp], #16
    bl _cons
blk_end_307:
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
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_303
    ldr x0, [sp], #16
    bl _cons
blk_end_300:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_298_299:
    // Closure for func_298
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_298
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_296_297:
    // Closure for func_296
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_296
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_294_295:
    // Closure for func_294
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_294
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_292_293:
    // Closure for func_292
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_292
    ldr x0, [sp], #16
    bl _cons
blk_end_289:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_287_288:
    // Closure for func_287
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_287
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_285_286:
    // Closure for func_285
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_283
    ldr x0, [sp], #16
    bl _cons
blk_end_280:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_278_279:
    // Closure for func_278
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_278
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_276_277:
    // Closure for func_276
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_276
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_274_275:
    // Closure for func_274
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_274
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_scan_token_impl_273:
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
    b after_func_433_434
func_433:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_436
    b or_end_437
or_right_436:
    adr x0, source
or_end_437:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_435
    b after_func_438_439
func_438:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_440_441
func_440:
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
    cmp x0, #4096
    b.hi do_compose_442
do_apply_443:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_444
do_compose_442:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_444:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    adr x0, is_digit
    ldr x0, [x0]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_440_441:
    // Closure for func_440
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_440
    ldr x0, [sp], #16
    bl _cons
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
blk_end_435:
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
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_454_455
func_454:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_457
    b or_end_458
or_right_457:
    adr x0, source
or_end_458:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_456
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, str_1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_463
    adr x0, _scan_while
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_464
do_apply_465:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_466
do_compose_464:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_466:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_467
do_apply_468:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_469
do_compose_467:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_469:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_470
do_apply_471:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_472
do_compose_470:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_472:
    str x0, [sp, #-16]!
    b after_func_473_474
func_473:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_475
    b or_end_476
or_right_475:
    adr x0, is_digit
    ldr x0, [x0]
or_end_476:
    cmp x0, #4096
    b.hi do_compose_477
do_apply_478:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_479
do_compose_477:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_479:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_480
do_apply_481:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_482
do_compose_480:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_482:
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
    cmp x0, #4096
    b.hi do_compose_483
do_apply_484:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_485
do_compose_483:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_485:
blk_end_463:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_461_462:
    // Closure for func_461
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_func_486_487
func_486:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_489
    b or_end_490
or_right_489:
    adr x0, source
or_end_490:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_488
    b after_func_491_492
func_491:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_493_494
func_493:
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
    cmp x0, #4096
    b.hi do_compose_495
do_apply_496:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_497
do_compose_495:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_497:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_498
do_apply_499:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_500
do_compose_498:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_500:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_501
do_apply_502:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_503
do_compose_501:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_503:
    str x0, [sp, #-16]!
    adr x0, is_op_char
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_504
do_apply_505:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_506
do_compose_504:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_506:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_493_494:
    // Closure for func_493
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_493
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_491_492:
    // Closure for func_491
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_491
    ldr x0, [sp], #16
    bl _cons
blk_end_488:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_486_487:
    // Closure for func_486
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_486
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after__scan_while_impl_507
_scan_while_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_508_509
func_508:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_510_511
func_510:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_512_513
func_512:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_514_515
func_514:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_517
    b or_end_518
or_right_517:
    adr x0, _scan_while_rec
or_end_518:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_516
    b after_func_519_520
func_519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_521_522
func_521:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_523_524
func_523:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_525_526
func_525:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_527_528
func_527:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_529_530
func_529:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_532
    b or_end_533
or_right_532:
    adr x0, head
or_end_533:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_531
    b after_func_534_535
func_534:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_536_537
func_536:
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
    b.eq or_right_539
    b or_end_540
or_right_539:
    adr x0, reverse
    ldr x0, [x0]
or_end_540:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_538
    b after_func_541_542
func_541:
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
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    cmp x0, #4096
    b.hi do_compose_549
do_apply_550:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_551
do_compose_549:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_551:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_541_542:
    // Closure for func_541
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
    adr x1, func_541
    ldr x0, [sp], #16
    bl _cons
blk_end_538:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_536_537:
    // Closure for func_536
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_536
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_534_535:
    // Closure for func_534
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_534
    ldr x0, [sp], #16
    bl _cons
blk_end_531:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_529_530:
    // Closure for func_529
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_529
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_525_526:
    // Closure for func_525
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_525
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_523_524:
    // Closure for func_523
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_523
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_521_522:
    // Closure for func_521
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_521
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_519_520:
    // Closure for func_519
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_519
    ldr x0, [sp], #16
    bl _cons
blk_end_516:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_512_513:
    // Closure for func_512
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_512
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_508_509:
    // Closure for func_508
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_508
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after__scan_while_impl_507:
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
    b after_func_552_553
func_552:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_555
    b or_end_556
or_right_555:
    adr x0, source
or_end_556:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_554
    b after_func_557_558
func_557:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_559_560
func_559:
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
    b after_func_561_562
func_561:
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
    b after_func_563_564
func_563:
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
    b.ge cmp_true_568
    adr x0, sign_id
    b cmp_end_569
cmp_true_568:
cmp_end_569:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_566
    adr x0, sign_id
    b cond_end_567
cond_false_566:
    adr x0, sign_id
cond_end_567:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_565
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_576
do_apply_577:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_578
do_compose_576:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_578:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_565
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_579
do_apply_580:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_581
do_compose_579:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_581:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_582
do_apply_583:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_584
do_compose_582:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_584:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_585
do_apply_586:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_587
do_compose_585:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_587:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_588
do_apply_589:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_590
do_compose_588:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_590:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_591
do_apply_592:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_593
do_compose_591:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_593:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_594
do_apply_595:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_596
do_compose_594:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_596:
    cmp x0, #4096
    b.hi do_compose_597
do_apply_598:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_599
do_compose_597:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_599:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_565
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_565:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_563_564:
    // Closure for func_563
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
    adr x1, func_563
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_561_562:
    // Closure for func_561
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
    adr x1, func_561
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_559_560:
    // Closure for func_559
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
    adr x1, func_559
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_557_558:
    // Closure for func_557
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_557
    ldr x0, [sp], #16
    bl _cons
blk_end_554:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_552_553:
    // Closure for func_552
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_552
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after_scan_str_impl_600
scan_str_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_601_602
func_601:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_603_604
func_603:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_605_606
func_605:
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
    b.eq or_right_608
    b or_end_609
or_right_608:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
or_end_609:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_607
    b after_func_610_611
func_610:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_613
    b or_end_614
or_right_613:
    adr x0, _scan_str_rec
or_end_614:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_612
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
    adr x0, str_2
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_637
    adr x0, list_to_string
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_638
do_apply_639:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_640
do_compose_638:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_640:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_641
do_apply_642:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_643
do_compose_641:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_643:
    cmp x0, #4096
    b.hi do_compose_644
do_apply_645:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_646
do_compose_644:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_646:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_637:
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
blk_end_612:
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
blk_end_607:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_605_606:
    // Closure for func_605
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_605
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_601_602:
    // Closure for func_601
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_601
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_scan_str_impl_600:
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
    b after_func_647_648
func_647:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_650
    b or_end_651
or_right_650:
    adr x0, source
or_end_651:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_649
    b after_func_652_653
func_652:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_654_655
func_654:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_661
    adr x0, sign_id
    b cmp_end_662
cmp_true_661:
cmp_end_662:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_659
    adr x0, sign_id
    b cond_end_660
cond_false_659:
    adr x0, sign_id
cond_end_660:
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
    cmp x0, #4096
    b.hi do_compose_663
do_apply_664:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_665
do_compose_663:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_665:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_666
do_apply_667:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_668
do_compose_666:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_668:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_669
do_apply_670:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_671
do_compose_669:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_671:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_676
    adr x0, sign_id
    b cmp_end_677
cmp_true_676:
cmp_end_677:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_674
    b or_end_675
or_right_674:
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_678
    adr x0, sign_id
    b cmp_end_679
cmp_true_678:
cmp_end_679:
or_end_675:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_672
    adr x0, sign_id
    b cond_end_673
cond_false_672:
    adr x0, sign_id
cond_end_673:
    str x0, [sp, #-16]!
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_680
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
blk_end_680:
    cmp x0, #4096
    b.hi do_compose_681
do_apply_682:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_683
do_compose_681:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_683:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_684
do_apply_685:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_686
do_compose_684:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_686:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_687
do_apply_688:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_689
do_compose_687:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_689:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_690
do_apply_691:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_692
do_compose_690:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_692:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_693
do_apply_694:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_695
do_compose_693:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_695:
blk_end_658:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_656_657:
    // Closure for func_656
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_654
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_652_653:
    // Closure for func_652
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_652
    ldr x0, [sp], #16
    bl _cons
blk_end_649:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_647_648:
    // Closure for func_647
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_647
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [x1]
    str x0, [sp, #-16]!
    b after__parse_int_impl_696
_parse_int_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after__parse_int_impl_696:
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

