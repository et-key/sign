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

    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, Sign
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
    adr x0, Self
    str x0, [sp, #-16]!
    adr x0, Hosting
    ldr x1, [sp], #16
    sub x0, x1, x0
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
    adr x0, Ported
    str x0, [sp, #-16]!
    adr x0, from
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
    adr x0, prepare_lexer
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
    adr x0, .
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
    adr x0, js
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x1, [sp], #16
    sdiv x0, x1, x0
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
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_22
do_apply_23:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_24
do_compose_22:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_24:
    str x0, [sp, #-16]!
    adr x0, js
    cmp x0, #4096
    b.hi do_compose_25
do_apply_26:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_27
do_compose_25:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_27:
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
    adr x0, init_lexer
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_28
    b after_func_30_31
func_30:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, src
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_30_31:
    // Closure for func_30
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_30
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, source
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_29
cond_false_28:
    adr x0, sign_id
cond_end_29:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, src_len
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_32
do_apply_33:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_34
do_compose_32:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_34:
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
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_35
do_apply_36:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_37
do_compose_35:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_37:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_38
    b after_func_40_41
func_40:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_40_41:
    // Closure for func_40
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_40
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, pos
    ldr x0, [x0] // @ load
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_39
cond_false_38:
    adr x0, sign_id
cond_end_39:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p
    str x0, [sp, #-16]!
    adr x0, src_len
    ldr x0, [x0] // @ load
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_44
    adr x0, sign_id
    b cmp_end_45
cmp_true_44:
cmp_end_45:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_42
    adr x0, sign_id
    b cond_end_43
cond_false_42:
    adr x0, sign_id
cond_end_43:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ch
    str x0, [sp, #-16]!
    mov x0, #-1
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    str x0, [sp, #-16]!
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, src
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    str x0, [sp, #-16]!
    adr x0, p
    cmp x0, #4096
    b.hi do_compose_46
do_apply_47:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_48
do_compose_46:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_48:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ch
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne blk_end_0
    adr x0, c
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_space
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_49
    b after_func_51_52
func_51:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_57
    adr x0, sign_id
    b cmp_end_58
cmp_true_57:
cmp_end_58:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_55
    b or_end_56
or_right_55:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_59
    adr x0, sign_id
    b cmp_end_60
cmp_true_59:
cmp_end_60:
or_end_56:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_53
    b or_end_54
or_right_53:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_61
    adr x0, sign_id
    b cmp_end_62
cmp_true_61:
cmp_end_62:
or_end_54:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_51_52:
    // Closure for func_51
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_51
    ldr x0, [sp], #16
    bl _cons
    b cond_end_50
cond_false_49:
    adr x0, sign_id
cond_end_50:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_digit
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_63
    b after_func_65_66
func_65:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_69
    adr x0, sign_id
    b cmp_end_70
cmp_true_69:
cmp_end_70:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_67
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_71
    adr x0, sign_id
    b cmp_end_72
cmp_true_71:
cmp_end_72:
    b and_end_68
and_fail_67:
    adr x0, sign_id
and_end_68:
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
    b cond_end_64
cond_false_63:
    adr x0, sign_id
cond_end_64:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_alpha
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_73
    b after_func_75_76
func_75:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_83
    adr x0, sign_id
    b cmp_end_84
cmp_true_83:
cmp_end_84:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_81
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_85
    adr x0, sign_id
    b cmp_end_86
cmp_true_85:
cmp_end_86:
    b and_end_82
and_fail_81:
    adr x0, sign_id
and_end_82:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_79
    b or_end_80
or_right_79:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_89
    adr x0, sign_id
    b cmp_end_90
cmp_true_89:
cmp_end_90:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_87
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_91
    adr x0, sign_id
    b cmp_end_92
cmp_true_91:
cmp_end_92:
    b and_end_88
and_fail_87:
    adr x0, sign_id
and_end_88:
or_end_80:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_77
    b or_end_78
or_right_77:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_93
    adr x0, sign_id
    b cmp_end_94
cmp_true_93:
cmp_end_94:
or_end_78:
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
    b cond_end_74
cond_false_73:
    adr x0, sign_id
cond_end_74:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_op_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_95
    b after_func_97_98
func_97:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_129
    adr x0, sign_id
    b cmp_end_130
cmp_true_129:
cmp_end_130:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_127
    b or_end_128
or_right_127:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_131
    adr x0, sign_id
    b cmp_end_132
cmp_true_131:
cmp_end_132:
or_end_128:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_125
    b or_end_126
or_right_125:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_133
    adr x0, sign_id
    b cmp_end_134
cmp_true_133:
cmp_end_134:
or_end_126:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_123
    b or_end_124
or_right_123:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_135
    adr x0, sign_id
    b cmp_end_136
cmp_true_135:
cmp_end_136:
or_end_124:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_121
    b or_end_122
or_right_121:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_137
    adr x0, sign_id
    b cmp_end_138
cmp_true_137:
cmp_end_138:
or_end_122:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_119
    b or_end_120
or_right_119:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_139
    adr x0, sign_id
    b cmp_end_140
cmp_true_139:
cmp_end_140:
or_end_120:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_117
    b or_end_118
or_right_117:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_141
    adr x0, sign_id
    b cmp_end_142
cmp_true_141:
cmp_end_142:
or_end_118:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_115
    b or_end_116
or_right_115:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_143
    adr x0, sign_id
    b cmp_end_144
cmp_true_143:
cmp_end_144:
or_end_116:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_113
    b or_end_114
or_right_113:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_145
    adr x0, sign_id
    b cmp_end_146
cmp_true_145:
cmp_end_146:
or_end_114:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_111
    b or_end_112
or_right_111:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_147
    adr x0, sign_id
    b cmp_end_148
cmp_true_147:
cmp_end_148:
or_end_112:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_109
    b or_end_110
or_right_109:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_149
    adr x0, sign_id
    b cmp_end_150
cmp_true_149:
cmp_end_150:
or_end_110:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_107
    b or_end_108
or_right_107:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_151
    adr x0, sign_id
    b cmp_end_152
cmp_true_151:
cmp_end_152:
or_end_108:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_105
    b or_end_106
or_right_105:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_153
    adr x0, sign_id
    b cmp_end_154
cmp_true_153:
cmp_end_154:
or_end_106:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_103
    b or_end_104
or_right_103:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_155
    adr x0, sign_id
    b cmp_end_156
cmp_true_155:
cmp_end_156:
or_end_104:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_101
    b or_end_102
or_right_101:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_157
    adr x0, sign_id
    b cmp_end_158
cmp_true_157:
cmp_end_158:
or_end_102:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_99
    b or_end_100
or_right_99:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_159
    adr x0, sign_id
    b cmp_end_160
cmp_true_159:
cmp_end_160:
or_end_100:
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
    b cond_end_96
cond_false_95:
    adr x0, sign_id
cond_end_96:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, length
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_161
    b after_func_165_166
func_165:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_167
    adr x0, sign_id
    b cmp_end_168
cmp_true_167:
cmp_end_168:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_163
    mov x0, #0
    b cond_end_164
cond_false_163:
    adr x0, sign_id
cond_end_164:
    b cond_end_162
cond_false_161:
    adr x0, sign_id
cond_end_162:
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
    b.hi do_compose_169
do_apply_170:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_171
do_compose_169:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_171:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list_to_string
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_175
    b after_func_179_180
func_179:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, len
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_179_180:
    // Closure for func_179
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_179
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_177
    adr x0, length
    str x0, [sp, #-16]!
    adr x0, list
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
    b cond_end_178
cond_false_177:
    adr x0, sign_id
cond_end_178:
    b cond_end_176
cond_false_175:
    adr x0, sign_id
cond_end_176:
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
    adr x1, str
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, list
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
    adr x0, str
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str
    ldr x0, [x0]
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
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _write_list
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_196
    b after_func_200_201
func_200:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_202
    adr x0, sign_id
    b cmp_end_203
cmp_true_202:
cmp_end_203:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_200_201:
    // Closure for func_200
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_200
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_198
    mov x0, #0
    b cond_end_199
cond_false_198:
    adr x0, sign_id
cond_end_199:
    b cond_end_197
cond_false_196:
    adr x0, sign_id
cond_end_197:
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
    str x0, [sp, #-16]!
    adr x0, buf
    cmp x0, #4096
    b.hi do_compose_213
do_apply_214:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_215
do_compose_213:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_215:
    str x0, [sp, #-16]!
    adr x0, idx
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_216
do_apply_217:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_218
do_compose_216:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_218:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tokenize
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_219
    b after_func_223_224
func_223:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, tok
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_223_224:
    // Closure for func_223
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_223
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_221
    adr x0, scan
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_225
do_apply_226:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_227
do_compose_225:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_227:
    b cond_end_222
cond_false_221:
    adr x0, sign_id
cond_end_222:
    b cond_end_220
cond_false_219:
    adr x0, sign_id
cond_end_220:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok
    ldr x0, [x0] // @ load
    adr x1, type
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_230
    adr x0, sign_id
    b cmp_end_231
cmp_true_230:
cmp_end_231:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_228
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_232
do_apply_233:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_234
do_compose_232:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_234:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_235
do_apply_236:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_237
do_compose_235:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_237:
    b cond_end_229
cond_false_228:
    adr x0, sign_id
cond_end_229:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok
    cmp x0, #4096
    b.hi do_compose_238
do_apply_239:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_240
do_compose_238:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_240:
    str x0, [sp, #-16]!
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_241
do_apply_242:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_243
do_compose_241:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_243:
    cmp x0, #4096
    b.hi do_compose_244
do_apply_245:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_246
do_compose_244:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_246:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_247
    b after_func_249_250
func_249:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_251
do_apply_252:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_253
do_compose_251:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_253:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_249_250:
    // Closure for func_249
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_249
    ldr x0, [sp], #16
    bl _cons
    b cond_end_248
cond_false_247:
    adr x0, sign_id
cond_end_248:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ch
    ldr x0, [x0] // @ load
    adr x1, c
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #-1
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
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
    mov x0, #0
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
    b cond_end_255
cond_false_254:
    adr x0, sign_id
cond_end_255:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_digit
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_266
do_apply_267:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_268
do_compose_266:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_268:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_264
    adr x0, scan_num
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_269
do_apply_270:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_271
do_compose_269:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_271:
    b cond_end_265
cond_false_264:
    adr x0, sign_id
cond_end_265:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_alpha
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_274
do_apply_275:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_276
do_compose_274:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_276:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_272
    adr x0, scan_id
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_277
do_apply_278:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_279
do_compose_277:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_279:
    b cond_end_273
cond_false_272:
    adr x0, sign_id
cond_end_273:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_op_char
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_282
do_apply_283:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_284
do_compose_282:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_284:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_280
    adr x0, scan_op
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_285
do_apply_286:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_287
do_compose_285:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_287:
    b cond_end_281
cond_false_280:
    adr x0, sign_id
cond_end_281:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_290
    adr x0, sign_id
    b cmp_end_291
cmp_true_290:
cmp_end_291:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_288
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_292
do_apply_293:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_294
do_compose_292:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_294:
    b cond_end_289
cond_false_288:
    adr x0, sign_id
cond_end_289:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_297
    adr x0, sign_id
    b cmp_end_298
cmp_true_297:
cmp_end_298:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_295
    adr x0, sign_id
    b cond_end_296
cond_false_295:
    adr x0, sign_id
cond_end_296:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_299
do_apply_300:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_301
do_compose_299:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_301:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_302
do_apply_303:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_304
do_compose_302:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_304:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_305
do_apply_306:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_307
do_compose_305:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_307:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_308
do_apply_309:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_310
do_compose_308:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_310:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_311
do_apply_312:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_313
do_compose_311:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_313:
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_314
do_apply_315:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_316
do_compose_314:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_316:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, skip_space
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_317
    b after_func_321_322
func_321:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    b after_func_323_324
func_323:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_328_329
func_328:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_330_331
func_330:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_335
do_apply_336:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_337
do_compose_335:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_337:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_328_329:
    // Closure for func_328
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_328
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ch
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
    b.ne xor_true_325
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_327
xor_true_325:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_326
    adr x0, sign_id
    b xor_end_327
xor_false_326:
    mov x0, x1
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
    cmp x0, #4096
    b.hi do_compose_338
do_apply_339:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_340
do_compose_338:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_340:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_319
    adr x0, sign_id
    b cond_end_320
cond_false_319:
    adr x0, sign_id
cond_end_320:
    b cond_end_318
cond_false_317:
    adr x0, sign_id
cond_end_318:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_341
do_apply_342:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_343
do_compose_341:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_343:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_344
do_apply_345:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_346
do_compose_344:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_346:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_id
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_347
    b after_func_351_352
func_351:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, chars
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_351_352:
    // Closure for func_351
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_351
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_349
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    b cond_end_350
cond_false_349:
    adr x0, sign_id
cond_end_350:
    b cond_end_348
cond_false_347:
    adr x0, sign_id
cond_end_348:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
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
    adr x1, str
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
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
    adr x0, str
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_id_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_365
    b after_func_369_370
func_369:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_371
    b or_end_372
or_right_371:
    adr x0, is_digit
or_end_372:
    cmp x0, #4096
    b.hi do_compose_373
do_apply_374:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_375
do_compose_373:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_375:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_369_370:
    // Closure for func_369
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_369
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_367
    adr x0, sign_id
    b cond_end_368
cond_false_367:
    adr x0, sign_id
cond_end_368:
    b cond_end_366
cond_false_365:
    adr x0, sign_id
cond_end_366:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_382
do_apply_383:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_384
do_compose_382:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_384:
    cmp x0, #4096
    b.hi do_compose_385
do_apply_386:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_387
do_compose_385:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_387:
    cmp x0, #4096
    b.hi do_compose_388
do_apply_389:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_390
do_compose_388:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_390:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_num
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_391
    b after_func_393_394
func_393:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
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
    adr x0, _scan_num_rec
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
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_401
do_apply_402:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_403
do_compose_401:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_403:
    cmp x0, #4096
    b.hi do_compose_404
do_apply_405:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_406
do_compose_404:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_406:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_393_394:
    // Closure for func_393
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_393
    ldr x0, [sp], #16
    bl _cons
    b cond_end_392
cond_false_391:
    adr x0, sign_id
cond_end_392:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_num_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_407
    b after_func_411_412
func_411:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_digit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_413
do_apply_414:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_415
do_compose_413:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_415:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_411_412:
    // Closure for func_411
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_411
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_409
    adr x0, sign_id
    b cond_end_410
cond_false_409:
    adr x0, sign_id
cond_end_410:
    b cond_end_408
cond_false_407:
    adr x0, sign_id
cond_end_408:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, acc
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x1, val
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_416
do_apply_417:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_418
do_compose_416:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_418:
    cmp x0, #4096
    b.hi do_compose_419
do_apply_420:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_421
do_compose_419:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_421:
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_422
do_apply_423:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_424
do_compose_422:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_424:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, acc
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_op
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_425
    b after_func_429_430
func_429:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, chars
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_429_430:
    // Closure for func_429
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_429
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_427
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    b after_func_431_432
func_431:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_436_437
func_436:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_438_439
func_438:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
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
    cmp x0, #4096
    b.hi do_compose_440
do_apply_441:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_442
do_compose_440:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_442:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_443
do_apply_444:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_445
do_compose_443:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_445:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_436_437:
    // Closure for func_436
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_436
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ch
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
    b.ne xor_true_433
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_435
xor_true_433:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_434
    adr x0, sign_id
    b xor_end_435
xor_false_434:
    mov x0, x1
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
    cmp x0, #4096
    b.hi do_compose_446
do_apply_447:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_448
do_compose_446:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_448:
    b cond_end_428
cond_false_427:
    adr x0, sign_id
cond_end_428:
    b cond_end_426
cond_false_425:
    adr x0, sign_id
cond_end_426:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    cmp x0, #4096
    b.hi do_compose_449
do_apply_450:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_451
do_compose_449:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_451:
    adr x1, str
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_452
do_apply_453:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_454
do_compose_452:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_454:
    str x0, [sp, #-16]!
    adr x0, str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_455
do_apply_456:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_457
do_compose_455:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_457:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_op_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_458
    b after_func_462_463
func_462:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_460
    adr x0, sign_id
    b cond_end_461
cond_false_460:
    adr x0, sign_id
cond_end_461:
    b cond_end_459
cond_false_458:
    adr x0, sign_id
cond_end_459:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    cmp x0, #4096
    b.hi do_compose_473
do_apply_474:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_475
do_compose_473:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_475:
    cmp x0, #4096
    b.hi do_compose_476
do_apply_477:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_478
do_compose_476:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_478:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_479
    b after_func_481_482
func_481:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_480
cond_false_479:
    adr x0, sign_id
cond_end_480:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_486
do_apply_487:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_488
do_compose_486:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_488:
    cmp x0, #4096
    b.hi do_compose_489
do_apply_490:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_491
do_compose_489:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_491:
    adr x1, chars
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_492
do_apply_493:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_494
do_compose_492:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_494:
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_str_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_501
    b after_func_505_506
func_505:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_509
    adr x0, sign_id
    b cmp_end_510
cmp_true_509:
cmp_end_510:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_507
    b or_end_508
or_right_507:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_511
    adr x0, sign_id
    b cmp_end_512
cmp_true_511:
cmp_end_512:
or_end_508:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_505_506:
    // Closure for func_505
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_505
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_503
    adr x0, sign_id
    b cond_end_504
cond_false_503:
    adr x0, sign_id
cond_end_504:
    b cond_end_502
cond_false_501:
    adr x0, sign_id
cond_end_502:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_516
do_apply_517:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_518
do_compose_516:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_518:
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_519
do_apply_520:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_521
do_compose_519:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_521:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, main
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_528
    b after_func_532_533
func_532:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, src
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_532_533:
    // Closure for func_532
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_532
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_530
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    mov x0, #123
    str x0, [sp, #-16]!
    adr x0, str_0
    ldr x1, [sp], #16
    add x0, x1, x0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_534
    adr x0, sign_id
    b cmp_end_535
cmp_true_534:
cmp_end_535:
    cmp x0, #4096
    b.hi do_compose_536
do_apply_537:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_538
do_compose_536:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_538:
    b cond_end_531
cond_false_530:
    adr x0, sign_id
cond_end_531:
    b cond_end_529
cond_false_528:
    adr x0, sign_id
cond_end_529:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_541
do_apply_542:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_543
do_compose_541:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_543:
    str x0, [sp, #-16]!
    adr x0, Source
    cmp x0, #4096
    b.hi do_compose_544
do_apply_545:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_546
do_compose_544:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_546:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_539
    adr x0, "
    b cond_end_540
cond_false_539:
    adr x0, sign_id
cond_end_540:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, src
    cmp x0, #4096
    b.hi do_compose_547
do_apply_548:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_549
do_compose_547:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_549:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_550
do_apply_551:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_552
do_compose_550:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_552:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, init_lexer
    str x0, [sp, #-16]!
    adr x0, src
    cmp x0, #4096
    b.hi do_compose_553
do_apply_554:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_555
do_compose_553:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_555:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_556
do_apply_557:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_558
do_compose_556:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_558:
    adr x1, tokens
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _process_list
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_559
do_apply_560:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_561
do_compose_559:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_561:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _process_list
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_562
    b after_func_566_567
func_566:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_568
    adr x0, sign_id
    b cmp_end_569
cmp_true_568:
cmp_end_569:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_566_567:
    // Closure for func_566
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_566
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_564
    adr x0, sign_id
    b cond_end_565
cond_false_564:
    adr x0, sign_id
cond_end_565:
    b cond_end_563
cond_false_562:
    adr x0, sign_id
cond_end_563:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
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
    adr x0, End
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
    adr x0, of
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
    str x0, [sp, #-16]!
    adr x0, List
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
    adr x0, "
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list
    ldr x0, [x0] // @ load
    adr x1, tok
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_token
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _process_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_token
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_597
    b after_func_601_602
func_601:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_599
    adr x0, tok
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    b cond_end_600
cond_false_599:
    adr x0, sign_id
cond_end_600:
    b cond_end_598
cond_false_597:
    adr x0, sign_id
cond_end_598:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_605
    adr x0, sign_id
    b cmp_end_606
cmp_true_605:
cmp_end_606:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_603
    adr x0, sign_id
    b cond_end_604
cond_false_603:
    adr x0, sign_id
cond_end_604:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_607
do_apply_608:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_609
do_compose_607:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_609:
    str x0, [sp, #-16]!
    adr x0, EOF
    cmp x0, #4096
    b.hi do_compose_610
do_apply_611:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_612
do_compose_610:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_612:
    str x0, [sp, #-16]!
    adr x0, "
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tok
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, val
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_621
    adr x0, sign_id
    b cmp_end_622
cmp_true_621:
cmp_end_622:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_619
    adr x0, sign_id
    b cond_end_620
cond_false_619:
    adr x0, sign_id
cond_end_620:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_625
do_apply_626:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_627
do_compose_625:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_627:
    str x0, [sp, #-16]!
    adr x0, ID
    cmp x0, #4096
    b.hi do_compose_628
do_apply_629:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_630
do_compose_628:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_630:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_623
    adr x0, "
    b cond_end_624
cond_false_623:
    adr x0, sign_id
cond_end_624:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_631
do_apply_632:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_633
do_compose_631:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_633:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_636
    adr x0, sign_id
    b cmp_end_637
cmp_true_636:
cmp_end_637:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_634
    adr x0, sign_id
    b cond_end_635
cond_false_634:
    adr x0, sign_id
cond_end_635:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_640
do_apply_641:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_642
do_compose_640:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_642:
    str x0, [sp, #-16]!
    adr x0, NUM
    cmp x0, #4096
    b.hi do_compose_643
do_apply_644:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_645
do_compose_643:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_645:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_638
    adr x0, "
    b cond_end_639
cond_false_638:
    adr x0, sign_id
cond_end_639:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_num
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_646
do_apply_647:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_648
do_compose_646:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_648:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_651
    adr x0, sign_id
    b cmp_end_652
cmp_true_651:
cmp_end_652:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_649
    adr x0, sign_id
    b cond_end_650
cond_false_649:
    adr x0, sign_id
cond_end_650:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_655
do_apply_656:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_657
do_compose_655:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_657:
    str x0, [sp, #-16]!
    adr x0, STR
    cmp x0, #4096
    b.hi do_compose_658
do_apply_659:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_660
do_compose_658:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_660:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_653
    adr x0, "
    b cond_end_654
cond_false_653:
    adr x0, sign_id
cond_end_654:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_661
do_apply_662:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_663
do_compose_661:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_663:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_666
    adr x0, sign_id
    b cmp_end_667
cmp_true_666:
cmp_end_667:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_664
    adr x0, sign_id
    b cond_end_665
cond_false_664:
    adr x0, sign_id
cond_end_665:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_670
do_apply_671:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_672
do_compose_670:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_672:
    str x0, [sp, #-16]!
    adr x0, OP
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_668
    adr x0, "
    b cond_end_669
cond_false_668:
    adr x0, sign_id
cond_end_669:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_681
    adr x0, sign_id
    b cmp_end_682
cmp_true_681:
cmp_end_682:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_679
    adr x0, sign_id
    b cond_end_680
cond_false_679:
    adr x0, sign_id
cond_end_680:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_685
do_apply_686:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_687
do_compose_685:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_687:
    str x0, [sp, #-16]!
    adr x0, PUNC
    cmp x0, #4096
    b.hi do_compose_688
do_apply_689:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_690
do_compose_688:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_690:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_683
    adr x0, "
    b cond_end_684
cond_false_683:
    adr x0, sign_id
cond_end_684:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_691
do_apply_692:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_693
do_compose_691:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_693:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_696
    adr x0, sign_id
    b cmp_end_697
cmp_true_696:
cmp_end_697:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_694
    adr x0, sign_id
    b cond_end_695
cond_false_694:
    adr x0, sign_id
cond_end_695:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_698
do_apply_699:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_700
do_compose_698:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_700:
    str x0, [sp, #-16]!
    adr x0, SEP
    cmp x0, #4096
    b.hi do_compose_701
do_apply_702:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_703
do_compose_701:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_703:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_704
do_apply_705:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_706
do_compose_704:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_706:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_707
do_apply_708:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_709
do_compose_707:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_709:
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
str: .quad 0
type: .quad 0
c: .quad 0
val: .quad 0
chars: .quad 0
tokens: .quad 0
tok: .quad 0


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

