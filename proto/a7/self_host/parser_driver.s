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
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #40
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_314
    adr x0, sign_id
    b cmp_end_315
cmp_true_314:
cmp_end_315:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_312
    b or_end_313
or_right_312:
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_316
    adr x0, sign_id
    b cmp_end_317
cmp_true_316:
cmp_end_317:
or_end_313:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_310
    b or_end_311
or_right_310:
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #123
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_318
    adr x0, sign_id
    b cmp_end_319
cmp_true_318:
cmp_end_319:
or_end_311:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_308
    b after_func_320_321
func_320:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_325_326
func_325:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_327_328
func_327:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_329
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_331
xor_true_329:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_330
    adr x0, sign_id
    b xor_end_331
xor_false_330:
    mov x0, x1
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
after_func_325_326:
    // Closure for func_325
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_325
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_338
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_340
xor_true_338:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_339
    adr x0, sign_id
    b xor_end_340
xor_false_339:
    mov x0, x1
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_322
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_324
xor_true_322:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_323
    adr x0, sign_id
    b xor_end_324
xor_false_323:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_320_321:
    // Closure for func_320
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_320
    ldr x0, [sp], #16
    bl _cons
    b cond_end_309
cond_false_308:
    adr x0, sign_id
cond_end_309:
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_347
do_apply_348:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_349
do_compose_347:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_349:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #41
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_356
    adr x0, sign_id
    b cmp_end_357
cmp_true_356:
cmp_end_357:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_354
    b or_end_355
or_right_354:
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #93
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_358
    adr x0, sign_id
    b cmp_end_359
cmp_true_358:
cmp_end_359:
or_end_355:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_352
    b or_end_353
or_right_352:
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #125
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_360
    adr x0, sign_id
    b cmp_end_361
cmp_true_360:
cmp_end_361:
or_end_353:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_350
    b after_func_362_363
func_362:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_367_368
func_367:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_369_370
func_369:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_371_372
func_371:
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
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_373
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_375
xor_true_373:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_374
    adr x0, sign_id
    b xor_end_375
xor_false_374:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_371_372:
    // Closure for func_371
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_371
    ldr x0, [sp], #16
    bl _cons
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
after_func_367_368:
    // Closure for func_367
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_367
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_384
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_386
xor_true_384:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_385
    adr x0, sign_id
    b xor_end_386
xor_false_385:
    mov x0, x1
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
    b.ne xor_true_364
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_366
xor_true_364:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_365
    adr x0, sign_id
    b xor_end_366
xor_false_365:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_362_363:
    // Closure for func_362
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_362
    ldr x0, [sp], #16
    bl _cons
    b cond_end_351
cond_false_350:
    adr x0, sign_id
cond_end_351:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, skip_space
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_405
    b after_func_409_410
func_409:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    b after_func_411_412
func_411:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_416_417
func_416:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_418_419
func_418:
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
after_func_418_419:
    // Closure for func_418
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_418
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_420
do_apply_421:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_422
do_compose_420:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_422:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_423
do_apply_424:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_425
do_compose_423:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_425:
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
    b.ne xor_true_413
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_415
xor_true_413:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_414
    adr x0, sign_id
    b xor_end_415
xor_false_414:
    mov x0, x1
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_409_410:
    // Closure for func_409
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_409
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_407
    adr x0, sign_id
    b cond_end_408
cond_false_407:
    adr x0, sign_id
cond_end_408:
    b cond_end_406
cond_false_405:
    adr x0, sign_id
cond_end_406:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.eq cond_false_435
    b after_func_439_440
func_439:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, chars
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_439_440:
    // Closure for func_439
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_439
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_437
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_441
do_apply_442:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_443
do_compose_441:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_443:
    b cond_end_438
cond_false_437:
    adr x0, sign_id
cond_end_438:
    b cond_end_436
cond_false_435:
    adr x0, sign_id
cond_end_436:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    cmp x0, #4096
    b.hi do_compose_444
do_apply_445:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_446
do_compose_444:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_446:
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
    b.hi do_compose_447
do_apply_448:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_449
do_compose_447:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_449:
    str x0, [sp, #-16]!
    adr x0, str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_450
do_apply_451:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_452
do_compose_450:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_452:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_id_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_453
    b after_func_457_458
func_457:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_459
    b or_end_460
or_right_459:
    adr x0, is_digit
or_end_460:
    cmp x0, #4096
    b.hi do_compose_461
do_apply_462:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_463
do_compose_461:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_463:
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
after_func_457_458:
    // Closure for func_457
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_457
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_455
    adr x0, sign_id
    b cond_end_456
cond_false_455:
    adr x0, sign_id
cond_end_456:
    b cond_end_454
cond_false_453:
    adr x0, sign_id
cond_end_454:
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
    adr x0, _scan_id_rec
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
    adr x0, scan_num
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_479
    b after_func_481_482
func_481:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, _scan_num_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_495
    b after_func_499_500
func_499:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_digit
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
    b.eq cond_false_497
    adr x0, sign_id
    b cond_end_498
cond_false_497:
    adr x0, sign_id
cond_end_498:
    b cond_end_496
cond_false_495:
    adr x0, sign_id
cond_end_496:
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
    cmp x0, #4096
    b.hi do_compose_507
do_apply_508:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_509
do_compose_507:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_509:
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
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
    b.eq cond_false_513
    b after_func_517_518
func_517:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, chars
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_517_518:
    // Closure for func_517
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_517
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_515
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    b after_func_519_520
func_519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_524_525
func_524:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_526_527
func_526:
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
after_func_526_527:
    // Closure for func_526
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_526
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_524_525:
    // Closure for func_524
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_524
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
    b.ne xor_true_521
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_523
xor_true_521:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_522
    adr x0, sign_id
    b xor_end_523
xor_false_522:
    mov x0, x1
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
    b cond_end_516
cond_false_515:
    adr x0, sign_id
cond_end_516:
    b cond_end_514
cond_false_513:
    adr x0, sign_id
cond_end_514:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
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
    str x0, [sp, #-16]!
    adr x0, str
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_op_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_546
    b after_func_550_551
func_550:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_552
do_apply_553:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_554
do_compose_552:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_554:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_550_551:
    // Closure for func_550
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_550
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_548
    adr x0, sign_id
    b cond_end_549
cond_false_548:
    adr x0, sign_id
cond_end_549:
    b cond_end_547
cond_false_546:
    adr x0, sign_id
cond_end_547:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_555
do_apply_556:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_557
do_compose_555:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_557:
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_567
    b after_func_569_570
func_569:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_571
do_apply_572:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_573
do_compose_571:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_573:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_569_570:
    // Closure for func_569
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_569
    ldr x0, [sp], #16
    bl _cons
    b cond_end_568
cond_false_567:
    adr x0, sign_id
cond_end_568:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_574
do_apply_575:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_576
do_compose_574:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_576:
    cmp x0, #4096
    b.hi do_compose_577
do_apply_578:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_579
do_compose_577:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_579:
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
    b.hi do_compose_580
do_apply_581:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_582
do_compose_580:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_582:
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_583
do_apply_584:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_585
do_compose_583:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_585:
    cmp x0, #4096
    b.hi do_compose_586
do_apply_587:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_588
do_compose_586:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_588:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_str_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_589
    b after_func_593_594
func_593:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_597
    adr x0, sign_id
    b cmp_end_598
cmp_true_597:
cmp_end_598:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_595
    b or_end_596
or_right_595:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_599
    adr x0, sign_id
    b cmp_end_600
cmp_true_599:
cmp_end_600:
or_end_596:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_593_594:
    // Closure for func_593
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_593
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_591
    adr x0, sign_id
    b cond_end_592
cond_false_591:
    adr x0, sign_id
cond_end_592:
    b cond_end_590
cond_false_589:
    adr x0, sign_id
cond_end_590:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_601
do_apply_602:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_603
do_compose_601:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_603:
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
    b.hi do_compose_604
do_apply_605:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_606
do_compose_604:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_606:
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Self
    str x0, [sp, #-16]!
    adr x0, Hosting
    ldr x1, [sp], #16
    sub x0, x1, x0
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
    str x0, [sp, #-16]!
    adr x0, Parser
    cmp x0, #4096
    b.hi do_compose_619
do_apply_620:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_621
do_compose_619:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_621:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Parses
    str x0, [sp, #-16]!
    adr x0, token
    cmp x0, #4096
    b.hi do_compose_622
do_apply_623:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_624
do_compose_622:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_624:
    str x0, [sp, #-16]!
    adr x0, list
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
    adr x0, into
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
    str x0, [sp, #-16]!
    adr x0, AST
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
    str x0, [sp, #-16]!
    adr x0, S
    str x0, [sp, #-16]!
    adr x0, expressions
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_634
do_apply_635:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_636
do_compose_634:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_636:
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
    b.ne xor_true_637
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_639
xor_true_637:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_638
    adr x0, sign_id
    b xor_end_639
xor_false_638:
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
    adr x0, streq
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_640
    b after_func_644_645
func_644:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, s2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_646
    adr x0, sign_id
    b cmp_end_647
cmp_true_646:
cmp_end_647:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_644_645:
    // Closure for func_644
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_644
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_642
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, Ptr
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_648
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_650
xor_true_648:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_649
    adr x0, sign_id
    b xor_end_650
xor_false_649:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, equality
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
    str x0, [sp, #-16]!
    adr x0, optimize
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
    b cond_end_643
cond_false_642:
    adr x0, sign_id
cond_end_643:
    b cond_end_641
cond_false_640:
    adr x0, sign_id
cond_end_641:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, s1
    ldr x0, [x0] // @ load
    adr x1, c1
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, s2
    ldr x0, [x0] // @ load
    adr x1, c2
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c1
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, c2
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_659
    adr x0, sign_id
    b cmp_end_660
cmp_true_659:
cmp_end_660:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_657
    mov x0, #0
    b cond_end_658
cond_false_657:
    adr x0, sign_id
cond_end_658:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c1
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_663
    adr x0, sign_id
    b cmp_end_664
cmp_true_663:
cmp_end_664:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_661
    mov x0, #1
    b cond_end_662
cond_false_661:
    adr x0, sign_id
cond_end_662:
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
    b.hi do_compose_665
do_apply_666:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_667
do_compose_665:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_667:
    str x0, [sp, #-16]!
    adr x0, s2
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_668
do_apply_669:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_670
do_compose_668:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_670:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_prec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_671
    b after_func_675_676
func_675:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_677
do_apply_678:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_679
do_compose_677:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_679:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    mul x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_680
do_apply_681:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_682
do_compose_680:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_682:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_675_676:
    // Closure for func_675
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_675
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_673
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_674
cond_false_673:
    adr x0, sign_id
cond_end_674:
    b cond_end_672
cond_false_671:
    adr x0, sign_id
cond_end_672:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sdiv x0, x1, x0
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
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_684
cond_false_683:
    adr x0, sign_id
cond_end_684:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    cmp x0, #4096
    b.hi do_compose_696
do_apply_697:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_698
do_compose_696:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_698:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_691
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_692
cond_false_691:
    adr x0, sign_id
cond_end_692:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    add x0, x1, x0
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
    b.eq cond_false_699
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_700
cond_false_699:
    adr x0, sign_id
cond_end_700:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_709
do_apply_710:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_711
do_compose_709:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_711:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_712
do_apply_713:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_714
do_compose_712:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_714:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_707
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_708
cond_false_707:
    adr x0, sign_id
cond_end_708:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_717
do_apply_718:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_719
do_compose_717:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_719:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_720
    adr x0, sign_id
    b cmp_end_721
cmp_true_720:
cmp_end_721:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_715
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_716
cond_false_715:
    adr x0, sign_id
cond_end_716:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_727
do_apply_728:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_729
do_compose_727:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_729:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_730
    adr x0, sign_id
    b cmp_end_731
cmp_true_730:
cmp_end_731:
    cmp x0, #4096
    b.hi do_compose_732
do_apply_733:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_734
do_compose_732:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_734:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_725
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_726
cond_false_725:
    adr x0, sign_id
cond_end_726:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_740
    adr x0, sign_id
    b cmp_end_741
cmp_true_740:
cmp_end_741:
    cmp x0, #4096
    b.hi do_compose_742
do_apply_743:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_744
do_compose_742:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_744:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_735
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_736
cond_false_735:
    adr x0, sign_id
cond_end_736:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_747
do_apply_748:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_749
do_compose_747:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_749:
    str x0, [sp, #-16]!
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_750
    adr x0, "
    b and_end_751
and_fail_750:
    adr x0, sign_id
and_end_751:
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_745
    adr x0, PREC_AND
    ldr x0, [x0]
    b cond_end_746
cond_false_745:
    adr x0, sign_id
cond_end_746:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_757
do_apply_758:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_759
do_compose_757:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_759:
    str x0, [sp, #-16]!
    adr x0, "
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_760
    b or_end_761
or_right_760:
    adr x0, "
or_end_761:
    cmp x0, #4096
    b.hi do_compose_762
do_apply_763:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_764
do_compose_762:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_764:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_755
    adr x0, PREC_OR
    ldr x0, [x0]
    b cond_end_756
cond_false_755:
    adr x0, sign_id
cond_end_756:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_767
do_apply_768:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_769
do_compose_767:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_769:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_770
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_772
xor_true_770:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_771
    adr x0, sign_id
    b xor_end_772
xor_false_771:
    mov x0, x1
    cmp x0, #4096
    b.hi do_compose_773
do_apply_774:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_775
do_compose_773:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_775:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_765
    adr x0, PREC_XOR
    ldr x0, [x0]
    b cond_end_766
cond_false_765:
    adr x0, sign_id
cond_end_766:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
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
    b.ne xor_true_776
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_778
xor_true_776:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_777
    adr x0, sign_id
    b xor_end_778
xor_false_777:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_779
do_apply_780:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_781
do_compose_779:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_781:
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
    b.ne xor_true_782
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_784
xor_true_782:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_783
    adr x0, sign_id
    b xor_end_784
xor_false_783:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, token
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, init_parser
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_788
    b after_func_790_791
func_790:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p_tokens
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_790_791:
    // Closure for func_790
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_790
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, toks
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_789
cond_false_788:
    adr x0, sign_id
cond_end_789:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_792
do_apply_793:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_794
do_compose_792:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_794:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_795
    b after_func_799_800
func_799:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p_tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_801
    adr x0, sign_id
    b cmp_end_802
cmp_true_801:
cmp_end_802:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_799_800:
    // Closure for func_799
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_799
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_797
    adr x0, sign_id
    b cond_end_798
cond_false_797:
    adr x0, sign_id
cond_end_798:
    b cond_end_796
cond_false_795:
    adr x0, sign_id
cond_end_796:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_curr
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_curr
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, p_tokens
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_tokens
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, p_tokens
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_curr
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_type
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_815
    b after_func_817_818
func_817:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_819
do_apply_820:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_821
do_compose_819:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_821:
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_817_818:
    // Closure for func_817
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_817
    ldr x0, [sp], #16
    bl _cons
    b cond_end_816
cond_false_815:
    adr x0, sign_id
cond_end_816:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_val
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_822
    b after_func_824_825
func_824:
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
    cmp x0, #4096
    b.hi do_compose_826
do_apply_827:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_828
do_compose_826:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_828:
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_824_825:
    // Closure for func_824
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_824
    ldr x0, [sp], #16
    bl _cons
    b cond_end_823
cond_false_822:
    adr x0, sign_id
cond_end_823:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expect_val
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_829
    b after_func_833_834
func_833:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, v
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_833_834:
    // Closure for func_833
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_833
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_831
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_835
do_apply_836:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_837
do_compose_835:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_837:
    b cond_end_832
cond_false_831:
    adr x0, sign_id
cond_end_832:
    b cond_end_830
cond_false_829:
    adr x0, sign_id
cond_end_830:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, v
    str x0, [sp, #-16]!
    adr x0, val
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
    b cond_end_839
cond_false_838:
    adr x0, sign_id
cond_end_839:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, TODO
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_847
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_849
xor_true_847:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_848
    adr x0, sign_id
    b xor_end_849
xor_false_848:
    mov x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_845
    adr x0, Error
    str x0, [sp, #-16]!
    adr x0, handling
    cmp x0, #4096
    b.hi do_compose_850
do_apply_851:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_852
do_compose_850:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_852:
    b cond_end_846
cond_false_845:
    adr x0, sign_id
cond_end_846:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expect_type
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_853
    b after_func_857_858
func_857:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, t
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_857_858:
    // Closure for func_857
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_857
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_855
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_859
do_apply_860:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_861
do_compose_859:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_861:
    b cond_end_856
cond_false_855:
    adr x0, sign_id
cond_end_856:
    b cond_end_854
cond_false_853:
    adr x0, sign_id
cond_end_854:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_864
    adr x0, sign_id
    b cmp_end_865
cmp_true_864:
cmp_end_865:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_862
    adr x0, sign_id
    b cond_end_863
cond_false_862:
    adr x0, sign_id
cond_end_863:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
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
    mov x0, #1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, can_start_expr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_869
    b after_func_873_874
func_873:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, t
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_871
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_872
cond_false_871:
    adr x0, sign_id
cond_end_872:
    b cond_end_870
cond_false_869:
    adr x0, sign_id
cond_end_870:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
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
    mov x0, #1
    b cond_end_879
cond_false_878:
    adr x0, sign_id
cond_end_879:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_884
    adr x0, sign_id
    b cmp_end_885
cmp_true_884:
cmp_end_885:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_882
    mov x0, #1
    b cond_end_883
cond_false_882:
    adr x0, sign_id
cond_end_883:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, tok_lparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_888
    adr x0, sign_id
    b cmp_end_889
cmp_true_888:
cmp_end_889:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_886
    mov x0, #1
    b cond_end_887
cond_false_886:
    adr x0, sign_id
cond_end_887:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, TODO
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_892
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_894
xor_true_892:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_893
    adr x0, sign_id
    b xor_end_894
xor_false_893:
    mov x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_890
    adr x0, strings
    str x0, [sp, #-16]!
    adr x0, parens
    str x0, [sp, #-16]!
    adr x0, prefix
    str x0, [sp, #-16]!
    adr x0, ops
    cmp x0, #4096
    b.hi do_compose_895
do_apply_896:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_897
do_compose_895:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_897:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    b cond_end_891
cond_false_890:
    adr x0, sign_id
cond_end_891:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_898
    b after_func_902_903
func_902:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_902_903:
    // Closure for func_902
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_902
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_900
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_901
cond_false_900:
    adr x0, sign_id
cond_end_901:
    b cond_end_899
cond_false_898:
    adr x0, sign_id
cond_end_899:
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
    b.eq cmp_true_909
    adr x0, sign_id
    b cmp_end_910
cmp_true_909:
cmp_end_910:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_907
    mov x0, #0
    b cond_end_908
cond_false_907:
    adr x0, sign_id
cond_end_908:
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
    b.eq cmp_true_913
    adr x0, sign_id
    b cmp_end_914
cmp_true_913:
cmp_end_914:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_911
    adr x0, sign_id
    b cond_end_912
cond_false_911:
    adr x0, sign_id
cond_end_912:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_915
do_apply_916:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_917
do_compose_915:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_917:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_918
do_apply_919:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_920
do_compose_918:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_920:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_def
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_921
do_apply_922:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_923
do_compose_921:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_923:
    adr x1, def
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, def
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_924
do_apply_925:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_926
do_compose_924:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_926:
    str x0, [sp, #-16]!
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_927
do_apply_928:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_929
do_compose_927:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_929:
    cmp x0, #4096
    b.hi do_compose_930
do_apply_931:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_932
do_compose_930:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_932:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_def
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_933
    b after_func_935_936
func_935:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, expect_val
    str x0, [sp, #-16]!
    mov x0, #35
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_937
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_939
xor_true_937:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_938
    adr x0, sign_id
    b xor_end_939
xor_false_938:
    mov x0, x1
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_935_936:
    // Closure for func_935
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_935
    ldr x0, [sp], #16
    bl _cons
    b cond_end_934
cond_false_933:
    adr x0, sign_id
cond_end_934:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x1, name
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expect_type
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne xor_true_951
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_953
xor_true_951:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_952
    adr x0, sign_id
    b xor_end_953
xor_false_952:
    mov x0, x1
    cmp x0, #4096
    b.hi do_compose_954
do_apply_955:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_956
do_compose_954:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_956:
    str x0, [sp, #-16]!
    adr x0, args
    cmp x0, #4096
    b.hi do_compose_957
do_apply_958:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_959
do_compose_957:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_959:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_949
    adr x0, parse_args
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_960
do_apply_961:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_962
do_compose_960:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_962:
    b cond_end_950
cond_false_949:
    adr x0, sign_id
cond_end_950:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne xor_true_965
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_967
xor_true_965:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_966
    adr x0, sign_id
    b xor_end_967
xor_false_966:
    mov x0, x1
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
    adr x0, body
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_963
    adr x0, parse_block
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_964
cond_false_963:
    adr x0, sign_id
cond_end_964:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_def
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_977
do_apply_978:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_979
do_compose_977:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_979:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, name
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_980
do_apply_981:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_982
do_compose_980:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_982:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, args
    cmp x0, #4096
    b.hi do_compose_983
do_apply_984:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_985
do_compose_983:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_985:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, body
    cmp x0, #4096
    b.hi do_compose_986
do_apply_987:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_988
do_compose_986:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_988:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_989
do_apply_990:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_991
do_compose_989:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_991:
    cmp x0, #4096
    b.hi do_compose_992
do_apply_993:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_994
do_compose_992:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_994:
    cmp x0, #4096
    b.hi do_compose_995
do_apply_996:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_997
do_compose_995:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_997:
    cmp x0, #4096
    b.hi do_compose_998
do_apply_999:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1000
do_compose_998:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1000:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1001
    b after_func_1005_1006
func_1005:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1003
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_1004
cond_false_1003:
    adr x0, sign_id
cond_end_1004:
    b cond_end_1002
cond_false_1001:
    adr x0, sign_id
cond_end_1002:
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
    b.eq cmp_true_1012
    adr x0, sign_id
    b cmp_end_1013
cmp_true_1012:
cmp_end_1013:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1010
    adr x0, sign_id
    b cond_end_1011
cond_false_1010:
    adr x0, sign_id
cond_end_1011:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1014
do_apply_1015:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1016
do_compose_1014:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1016:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1017
do_apply_1018:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1019
do_compose_1017:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1019:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1020
do_apply_1021:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1022
do_compose_1020:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1022:
    adr x1, expr
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1023
do_apply_1024:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1025
do_compose_1023:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1025:
    adr x1, type
    str x0, [x1]
    adr x0, sign_id
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
    b.eq cmp_true_1028
    adr x0, sign_id
    b cmp_end_1029
cmp_true_1028:
cmp_end_1029:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1026
    adr x0, sign_id
    b cond_end_1027
cond_false_1026:
    adr x0, sign_id
cond_end_1027:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1030
do_apply_1031:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1032
do_compose_1030:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1032:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1033
do_apply_1034:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1035
do_compose_1033:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1035:
    adr x1, rest
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, rest
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1038
    adr x0, sign_id
    b cmp_end_1039
cmp_true_1038:
cmp_end_1039:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1036
    adr x0, expr
    ldr x0, [x0]
    b cond_end_1037
cond_false_1036:
    adr x0, sign_id
cond_end_1037:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1040
do_apply_1041:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1042
do_compose_1040:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1042:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1043
do_apply_1044:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1045
do_compose_1043:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1045:
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1046
do_apply_1047:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1048
do_compose_1046:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1048:
    cmp x0, #4096
    b.hi do_compose_1049
do_apply_1050:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1051
do_compose_1049:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1051:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expr
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block_rest
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1052
    b after_func_1056_1057
func_1056:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1056_1057:
    // Closure for func_1056
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1056
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1054
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1058
do_apply_1059:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1060
do_compose_1058:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1060:
    b cond_end_1055
cond_false_1054:
    adr x0, sign_id
cond_end_1055:
    b cond_end_1053
cond_false_1052:
    adr x0, sign_id
cond_end_1053:
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
    b.eq cmp_true_1063
    adr x0, sign_id
    b cmp_end_1064
cmp_true_1063:
cmp_end_1064:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1061
    mov x0, #0
    b cond_end_1062
cond_false_1061:
    adr x0, sign_id
cond_end_1062:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #35
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1067
    adr x0, sign_id
    b cmp_end_1068
cmp_true_1067:
cmp_end_1068:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1065
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, start
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1069
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1071
xor_true_1069:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1070
    adr x0, sign_id
    b xor_end_1071
xor_false_1070:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, of
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
    adr x0, next
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
    str x0, [sp, #-16]!
    adr x0, def
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1078
do_apply_1079:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1080
do_compose_1078:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1080:
    b cond_end_1066
cond_false_1065:
    adr x0, sign_id
cond_end_1066:
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
    b.eq cmp_true_1083
    adr x0, sign_id
    b cmp_end_1084
cmp_true_1083:
cmp_end_1084:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1081
    adr x0, sign_id
    b cond_end_1082
cond_false_1081:
    adr x0, sign_id
cond_end_1082:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1085
do_apply_1086:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1087
do_compose_1085:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1087:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1088
do_apply_1089:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1090
do_compose_1088:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1090:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1091
do_apply_1092:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1093
do_compose_1091:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1093:
    adr x1, expr
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1094
do_apply_1095:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1096
do_compose_1094:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1096:
    str x0, [sp, #-16]!
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1097
do_apply_1098:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1099
do_compose_1097:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1099:
    cmp x0, #4096
    b.hi do_compose_1100
do_apply_1101:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1102
do_compose_1100:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1102:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_args
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1103
    b after_func_1107_1108
func_1107:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, t
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1107_1108:
    // Closure for func_1107
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1107
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1105
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1109
do_apply_1110:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1111
do_compose_1109:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1111:
    b cond_end_1106
cond_false_1105:
    adr x0, sign_id
cond_end_1106:
    b cond_end_1104
cond_false_1103:
    adr x0, sign_id
cond_end_1104:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1112
do_apply_1113:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1114
do_compose_1112:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1114:
    adr x1, v
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1117_1118
func_1117:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, v
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1119
    adr x0, sign_id
    b cmp_end_1120
cmp_true_1119:
cmp_end_1120:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1117_1118:
    // Closure for func_1117
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1117
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1115
    mov x0, #0
    b cond_end_1116
cond_false_1115:
    adr x0, sign_id
cond_end_1116:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expect_type
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1121
do_apply_1122:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1123
do_compose_1121:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1123:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, v
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1124
do_apply_1125:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1126
do_compose_1124:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1126:
    str x0, [sp, #-16]!
    adr x0, parse_args
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1127
do_apply_1128:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1129
do_compose_1127:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1129:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1133
    b after_func_1137_1138
func_1137:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, lhs
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1137_1138:
    // Closure for func_1137
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1137
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1135
    adr x0, parse_primary
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_1136
cond_false_1135:
    adr x0, sign_id
cond_end_1136:
    b cond_end_1134
cond_false_1133:
    adr x0, sign_id
cond_end_1134:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_1142
do_apply_1143:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1144
do_compose_1142:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1144:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_1145
do_apply_1146:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1147
do_compose_1145:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1147:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1148
    b after_func_1150_1151
func_1150:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, ;
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_1152
do_apply_1153:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1154
do_compose_1152:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1154:
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_1155
do_apply_1156:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1157
do_compose_1155:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1157:
    str x0, [sp, #-16]!
    adr x0, Check
    cmp x0, #4096
    b.hi do_compose_1158
do_apply_1159:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1160
do_compose_1158:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1160:
    str x0, [sp, #-16]!
    adr x0, for
    cmp x0, #4096
    b.hi do_compose_1161
do_apply_1162:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1163
do_compose_1161:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1163:
    str x0, [sp, #-16]!
    adr x0, application
    cmp x0, #4096
    b.hi do_compose_1164
do_apply_1165:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1166
do_compose_1164:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1166:
    str x0, [sp, #-16]!
    adr x0, Juxtaposition
    cmp x0, #4096
    b.hi do_compose_1167
do_apply_1168:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1169
do_compose_1167:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1169:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1150_1151:
    // Closure for func_1150
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1150
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1149
cond_false_1148:
    adr x0, sign_id
cond_end_1149:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, can_start_expr
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1170
do_apply_1171:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1172
do_compose_1170:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1172:
    adr x1, is_app
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_app
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1175
    adr x0, PREC_APPLY
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, min_prec
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1177
    adr x0, sign_id
    b cmp_end_1178
cmp_true_1177:
cmp_end_1178:
    b and_end_1176
and_fail_1175:
    adr x0, sign_id
and_end_1176:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1173
    adr x0, sign_id
    b cond_end_1174
cond_false_1173:
    adr x0, sign_id
cond_end_1174:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, PREC_APPLY
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1179
do_apply_1180:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1181
do_compose_1179:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1181:
    adr x1, rhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1182
do_apply_1183:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1184
do_compose_1182:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1184:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_1185
do_apply_1186:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1187
do_compose_1185:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1187:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1188
do_apply_1189:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1190
do_compose_1188:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1190:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1191
do_apply_1192:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1193
do_compose_1191:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1193:
    cmp x0, #4096
    b.hi do_compose_1194
do_apply_1195:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1196
do_compose_1194:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1196:
    cmp x0, #4096
    b.hi do_compose_1197
do_apply_1198:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1199
do_compose_1197:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1199:
    adr x1, new_lhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, new_lhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1200
do_apply_1201:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1202
do_compose_1200:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1202:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_1203
do_apply_1204:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1205
do_compose_1203:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1205:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1206
do_apply_1207:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1208
do_compose_1206:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1208:
    adr x1, type
    str x0, [x1]
    adr x0, sign_id
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
    b.ne cmp_true_1211
    adr x0, sign_id
    b cmp_end_1212
cmp_true_1211:
cmp_end_1212:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1209
    adr x0, lhs
    b cond_end_1210
cond_false_1209:
    adr x0, sign_id
cond_end_1210:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1213
do_apply_1214:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1215
do_compose_1213:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1215:
    adr x1, op
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_prec
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1216
do_apply_1217:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1218
do_compose_1216:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1218:
    adr x1, prec
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, prec
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, min_prec
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1221
    adr x0, sign_id
    b cmp_end_1222
cmp_true_1221:
cmp_end_1222:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1219
    adr x0, lhs
    b cond_end_1220
cond_false_1219:
    adr x0, sign_id
cond_end_1220:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne xor_true_1223
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1225
xor_true_1223:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1224
    adr x0, sign_id
    b xor_end_1225
xor_false_1224:
    mov x0, x1
    cmp x0, #4096
    b.hi do_compose_1226
do_apply_1227:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1228
do_compose_1226:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1228:
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1229
do_apply_1230:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1231
do_compose_1229:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1231:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_rhs_impl_1232
rhs_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, No
    str x0, [sp, #-16]!
    adr x0, left
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_1233
do_apply_1234:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1235
do_compose_1233:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1235:
    str x0, [sp, #-16]!
    adr x0, prec
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1236
do_apply_1237:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1238
do_compose_1236:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1238:
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_rhs_impl_1232:
    // Closure for rhs_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, rhs_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_1245
do_apply_1246:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1247
do_compose_1245:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1247:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1248
do_apply_1249:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1250
do_compose_1248:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1250:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1251
do_apply_1252:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1253
do_compose_1251:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1253:
    cmp x0, #4096
    b.hi do_compose_1254
do_apply_1255:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1256
do_compose_1254:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1256:
    cmp x0, #4096
    b.hi do_compose_1257
do_apply_1258:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1259
do_compose_1257:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1259:
    cmp x0, #4096
    b.hi do_compose_1260
do_apply_1261:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1262
do_compose_1260:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1262:
    adr x1, new_lhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, new_lhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1263
do_apply_1264:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1265
do_compose_1263:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1265:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_1266
do_apply_1267:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1268
do_compose_1266:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1268:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_primary
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1269
    b after_func_1273_1274
func_1273:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, t
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1271
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1275
do_apply_1276:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1277
do_compose_1275:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1277:
    b cond_end_1272
cond_false_1271:
    adr x0, sign_id
cond_end_1272:
    b cond_end_1270
cond_false_1269:
    adr x0, sign_id
cond_end_1270:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1278
do_apply_1279:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1280
do_compose_1278:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1280:
    adr x1, v
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1283
    adr x0, sign_id
    b cmp_end_1284
cmp_true_1283:
cmp_end_1284:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1281
    adr x0, sign_id
    b cond_end_1282
cond_false_1281:
    adr x0, sign_id
cond_end_1282:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
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
    adr x0, v
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1302
    adr x0, sign_id
    b cmp_end_1303
cmp_true_1302:
cmp_end_1303:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1300
    adr x0, sign_id
    b cond_end_1301
cond_false_1300:
    adr x0, sign_id
cond_end_1301:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1304
do_apply_1305:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1306
do_compose_1304:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1306:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1307
do_apply_1308:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1309
do_compose_1307:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1309:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, v
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1310
do_apply_1311:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1312
do_compose_1310:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1312:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1313
do_apply_1314:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1315
do_compose_1313:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1315:
    cmp x0, #4096
    b.hi do_compose_1316
do_apply_1317:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1318
do_compose_1316:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1318:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, t
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
    adr x0, sign_id
    b cond_end_1320
cond_false_1319:
    adr x0, sign_id
cond_end_1320:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1323
do_apply_1324:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1325
do_compose_1323:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1325:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1326
do_apply_1327:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1328
do_compose_1326:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1328:
    adr x1, expr
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expect_type
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1329
do_apply_1330:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1331
do_compose_1329:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1331:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expr
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
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
    mov x0, #999
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
    str x0, [sp, #-16]!
    mov x0, #0
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
    str x0, [sp, #-16]!
    adr x0, Fallback
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1335
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1337
xor_true_1335:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1336
    adr x0, sign_id
    b xor_end_1337
xor_false_1336:
    mov x0, x1
    cmp x0, #4096
    b.hi do_compose_1344
do_apply_1345:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1346
do_compose_1344:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1346:
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
    adr x0, main
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1347
    b after_func_1351_1352
func_1351:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, src
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1349
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, main
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1353
    adr x0, ?
    str x0, [sp, #-16]!
    mov x0, #10
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
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    add x0, x1, x0
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
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1361
do_apply_1362:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1363
do_compose_1361:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1363:
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1366
    adr x0, sign_id
    b cmp_end_1367
cmp_true_1366:
cmp_end_1367:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1364
    b or_end_1365
or_right_1364:
    adr x0, z
or_end_1365:
    cmp x0, #4096
    b.hi do_compose_1368
do_apply_1369:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1370
do_compose_1368:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1370:
    str x0, [sp, #-16]!
    mov x0, #10
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
    adr x0, a
    str x0, [sp, #-16]!
    adr x0, b
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1374
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1376
xor_true_1374:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1375
    adr x0, sign_id
    b xor_end_1376
xor_false_1375:
    mov x0, x1
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
    str x0, [sp, #-16]!
    mov x0, #10
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
    str x0, [sp, #-16]!
    adr x0, f
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
    adr x0, x
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
    adr x0, y
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
    mov x0, #10
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
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    mul x0, x1, x0
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
    str x0, [sp, #-16]!
    mov x0, #10
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
    mov x0, #10
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
    cmp x0, #4096
    b.hi do_compose_1407
do_apply_1408:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1409
do_compose_1407:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1409:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1410
do_apply_1411:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1412
do_compose_1410:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1412:
    b cond_end_1354
cond_false_1353:
    adr x0, sign_id
cond_end_1354:
    b cond_end_1350
cond_false_1349:
    adr x0, sign_id
cond_end_1350:
    b cond_end_1348
cond_false_1347:
    adr x0, sign_id
cond_end_1348:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1415
do_apply_1416:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1417
do_compose_1415:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1417:
    str x0, [sp, #-16]!
    adr x0, Source
    cmp x0, #4096
    b.hi do_compose_1418
do_apply_1419:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1420
do_compose_1418:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1420:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1413
    adr x0, "
    b cond_end_1414
cond_false_1413:
    adr x0, sign_id
cond_end_1414:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, src
    cmp x0, #4096
    b.hi do_compose_1421
do_apply_1422:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1423
do_compose_1421:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1423:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1424
do_apply_1425:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1426
do_compose_1424:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1426:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, init_lexer
    str x0, [sp, #-16]!
    adr x0, src
    cmp x0, #4096
    b.hi do_compose_1427
do_apply_1428:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1429
do_compose_1427:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1429:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1430
do_apply_1431:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1432
do_compose_1430:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1432:
    adr x1, tokens
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, init_parser
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1433
do_apply_1434:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1435
do_compose_1433:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1435:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1436
do_apply_1437:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1438
do_compose_1436:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1438:
    adr x1, ast
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1439
do_apply_1440:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1441
do_compose_1439:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1441:
    str x0, [sp, #-16]!
    adr x0, AST
    cmp x0, #4096
    b.hi do_compose_1442
do_apply_1443:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1444
do_compose_1442:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1444:
    str x0, [sp, #-16]!
    adr x0, Generated
    cmp x0, #4096
    b.hi do_compose_1445
do_apply_1446:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1447
do_compose_1445:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1447:
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_1448
do_apply_1449:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1450
do_compose_1448:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1450:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1451
do_apply_1452:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1453
do_compose_1451:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1453:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1454
do_apply_1455:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1456
do_compose_1454:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1456:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, ast
    ldr x0, [x0]
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
    adr x0, _print_ast
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1460
    b after_func_1464_1465
func_1464:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1466
    adr x0, sign_id
    b cmp_end_1467
cmp_true_1466:
cmp_end_1467:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1464_1465:
    // Closure for func_1464
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1464
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1462
    mov x0, #0
    b cond_end_1463
cond_false_1462:
    adr x0, sign_id
cond_end_1463:
    b cond_end_1461
cond_false_1460:
    adr x0, sign_id
cond_end_1461:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, node
    ldr x0, [x0] // @ load
    adr x1, type
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, node
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
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, List
    cmp x0, #4096
    b.hi do_compose_1468
do_apply_1469:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1470
do_compose_1468:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1470:
    str x0, [sp, #-16]!
    adr x0, of
    cmp x0, #4096
    b.hi do_compose_1471
do_apply_1472:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1473
do_compose_1471:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1473:
    str x0, [sp, #-16]!
    adr x0, Defs
    cmp x0, #4096
    b.hi do_compose_1474
do_apply_1475:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1476
do_compose_1474:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1476:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_def
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1479
    adr x0, sign_id
    b cmp_end_1480
cmp_true_1479:
cmp_end_1480:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1477
    adr x0, sign_id
    b cond_end_1478
cond_false_1477:
    adr x0, sign_id
cond_end_1478:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1481
do_apply_1482:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1483
do_compose_1481:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1483:
    str x0, [sp, #-16]!
    adr x0, DEF
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1484
do_apply_1485:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1486
do_compose_1484:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1486:
    cmp x0, #4096
    b.hi do_compose_1487
do_apply_1488:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1489
do_compose_1487:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1489:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    adr x1, name
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, name
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1490
do_apply_1491:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1492
do_compose_1490:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1492:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1493
do_apply_1494:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1495
do_compose_1493:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1495:
    str x0, [sp, #-16]!
    adr x0, ARGS
    cmp x0, #4096
    b.hi do_compose_1496
do_apply_1497:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1498
do_compose_1496:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1498:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1499
do_apply_1500:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1501
do_compose_1499:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1501:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, args
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, TODO
    cmp x0, #4096
    b.hi do_compose_1502
do_apply_1503:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1504
do_compose_1502:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1504:
    str x0, [sp, #-16]!
    adr x0, print
    cmp x0, #4096
    b.hi do_compose_1505
do_apply_1506:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1507
do_compose_1505:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1507:
    str x0, [sp, #-16]!
    adr x0, args
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1508
do_apply_1509:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1510
do_compose_1508:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1510:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1511
do_apply_1512:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1513
do_compose_1511:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1513:
    str x0, [sp, #-16]!
    adr x0, BODY
    cmp x0, #4096
    b.hi do_compose_1514
do_apply_1515:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1516
do_compose_1514:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1516:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1517
do_apply_1518:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1519
do_compose_1517:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1519:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, body
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, body
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1520
do_apply_1521:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1522
do_compose_1520:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1522:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1523
do_apply_1524:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1525
do_compose_1523:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1525:
    str x0, [sp, #-16]!
    adr x0, "
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
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
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1534
    adr x0, sign_id
    b cmp_end_1535
cmp_true_1534:
cmp_end_1535:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1532
    adr x0, sign_id
    b cond_end_1533
cond_false_1532:
    adr x0, sign_id
cond_end_1533:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1536
do_apply_1537:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1538
do_compose_1536:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1538:
    str x0, [sp, #-16]!
    adr x0, BLOCK
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1539
do_apply_1540:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1541
do_compose_1539:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1541:
    cmp x0, #4096
    b.hi do_compose_1542
do_apply_1543:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1544
do_compose_1542:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1544:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1545
do_apply_1546:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1547
do_compose_1545:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1547:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1548
do_apply_1549:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1550
do_compose_1548:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1550:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1551
do_apply_1552:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1553
do_compose_1551:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1553:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1554
do_apply_1555:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1556
do_compose_1554:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1556:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1559
    adr x0, sign_id
    b cmp_end_1560
cmp_true_1559:
cmp_end_1560:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1557
    adr x0, sign_id
    b cond_end_1558
cond_false_1557:
    adr x0, sign_id
cond_end_1558:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1561
do_apply_1562:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1563
do_compose_1561:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1563:
    str x0, [sp, #-16]!
    adr x0, APPLY
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1564
do_apply_1565:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1566
do_compose_1564:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1566:
    cmp x0, #4096
    b.hi do_compose_1567
do_apply_1568:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1569
do_compose_1567:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1569:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    adr x1, func
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, func
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1570
do_apply_1571:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1572
do_compose_1570:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1572:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #32
    cmp x0, #4096
    b.hi do_compose_1573
do_apply_1574:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1575
do_compose_1573:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1575:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, arg
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, arg
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
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
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1582
do_apply_1583:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1584
do_compose_1582:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1584:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1587
    adr x0, sign_id
    b cmp_end_1588
cmp_true_1587:
cmp_end_1588:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1585
    adr x0, sign_id
    b cond_end_1586
cond_false_1585:
    adr x0, sign_id
cond_end_1586:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1589
do_apply_1590:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1591
do_compose_1589:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1591:
    str x0, [sp, #-16]!
    adr x0, "
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    adr x1, op
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
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
    b.ne blk_end_0
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
    b.ne xor_true_1598
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1600
xor_true_1598:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1599
    adr x0, sign_id
    b xor_end_1600
xor_false_1599:
    mov x0, x1
    cmp x0, #4096
    b.hi do_compose_1601
do_apply_1602:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1603
do_compose_1601:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1603:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, lhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1604
do_apply_1605:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1606
do_compose_1604:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1606:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #32
    cmp x0, #4096
    b.hi do_compose_1607
do_apply_1608:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1609
do_compose_1607:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1609:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, rhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1610
do_apply_1611:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1612
do_compose_1610:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1612:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1613
do_apply_1614:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1615
do_compose_1613:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1615:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1616
do_apply_1617:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1618
do_compose_1616:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1618:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1621
    adr x0, sign_id
    b cmp_end_1622
cmp_true_1621:
cmp_end_1622:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1619
    adr x0, sign_id
    b cond_end_1620
cond_false_1619:
    adr x0, sign_id
cond_end_1620:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
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
    adr x0, NUM
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1626
do_apply_1627:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1628
do_compose_1626:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1628:
    cmp x0, #4096
    b.hi do_compose_1629
do_apply_1630:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1631
do_compose_1629:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1631:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_num
    str x0, [sp, #-16]!
    b after_func_1632_1633
func_1632:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1637_1638
func_1637:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1639_1640
func_1639:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1639_1640:
    // Closure for func_1639
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1639
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1644
do_apply_1645:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1646
do_compose_1644:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1646:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1637_1638:
    // Closure for func_1637
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1637
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
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
    b.ne xor_true_1634
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1636
xor_true_1634:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1635
    adr x0, sign_id
    b xor_end_1636
xor_false_1635:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1632_1633:
    // Closure for func_1632
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1632
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1647
do_apply_1648:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1649
do_compose_1647:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1649:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1650
do_apply_1651:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1652
do_compose_1650:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1652:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1653
do_apply_1654:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1655
do_compose_1653:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1655:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1658
    adr x0, sign_id
    b cmp_end_1659
cmp_true_1658:
cmp_end_1659:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1656
    adr x0, sign_id
    b cond_end_1657
cond_false_1656:
    adr x0, sign_id
cond_end_1657:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1660
do_apply_1661:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1662
do_compose_1660:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1662:
    str x0, [sp, #-16]!
    adr x0, ID
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1663
do_apply_1664:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1665
do_compose_1663:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1665:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    b after_func_1669_1670
func_1669:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1674_1675
func_1674:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1676_1677
func_1676:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1676_1677:
    // Closure for func_1676
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1676
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1678
do_apply_1679:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1680
do_compose_1678:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1680:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1674_1675:
    // Closure for func_1674
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1674
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
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
    b.ne xor_true_1671
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1673
xor_true_1671:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1672
    adr x0, sign_id
    b xor_end_1673
xor_false_1672:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1669_1670:
    // Closure for func_1669
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1669
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1684
do_apply_1685:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1686
do_compose_1684:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1686:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1687
do_apply_1688:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1689
do_compose_1687:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1689:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_1690
do_apply_1691:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1692
do_compose_1690:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1692:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, If
    cmp x0, #4096
    b.hi do_compose_1693
do_apply_1694:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1695
do_compose_1693:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1695:
    str x0, [sp, #-16]!
    adr x0, it
    str x0, [sp, #-16]!
    adr x0, s
    ldr x1, [sp], #16
    bl _nth
    cmp x0, #4096
    b.hi do_compose_1696
do_apply_1697:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1698
do_compose_1696:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1698:
    str x0, [sp, #-16]!
    adr x0, a
    cmp x0, #4096
    b.hi do_compose_1699
do_apply_1700:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1701
do_compose_1699:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1701:
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_1702
do_apply_1703:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1704
do_compose_1702:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1704:
    str x0, [sp, #-16]!
    adr x0, Program
    cmp x0, #4096
    b.hi do_compose_1705
do_apply_1706:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1707
do_compose_1705:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1707:
    str x0, [sp, #-16]!
    adr x0, iterate
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    b after_func_1708_1709
func_1708:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1713_1714
func_1713:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1715_1716
func_1715:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, node
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1715_1716:
    // Closure for func_1715
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1715
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1717
do_apply_1718:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1719
do_compose_1717:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1719:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1713_1714:
    // Closure for func_1713
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1713
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, node
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
    b.ne xor_true_1710
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1712
xor_true_1710:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1711
    adr x0, sign_id
    b xor_end_1712
xor_false_1711:
    mov x0, x1
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
    b.ne blk_end_0
    adr x0, _print_ast
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_1726
do_apply_1727:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1728
do_compose_1726:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1728:
    cmp x0, #4096
    b.hi do_compose_1729
do_apply_1730:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1731
do_compose_1729:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1731:
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
str: .quad 0
type: .quad 0
c: .quad 0
val: .quad 0
chars: .quad 0
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
c1: .quad 0
c2: .quad 0
def: .quad 0
name: .quad 0
expr: .quad 0
rest: .quad 0
v: .quad 0
is_app: .quad 0
rhs: .quad 0
new_lhs: .quad 0
op: .quad 0
prec: .quad 0
tokens: .quad 0
ast: .quad 0
args: .quad 0
body: .quad 0
func: .quad 0
arg: .quad 0
lhs: .quad 0


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

