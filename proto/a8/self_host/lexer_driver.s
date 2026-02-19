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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_16_17
func_16:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_18_19
func_18:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_21
    b or_end_22
or_right_21:
    adr x0, c
or_end_22:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_20
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_27
    adr x0, sign_id
    b cmp_end_28
cmp_true_27:
cmp_end_28:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_25
    b or_end_26
or_right_25:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_29
    adr x0, sign_id
    b cmp_end_30
cmp_true_29:
cmp_end_30:
or_end_26:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_23
    b or_end_24
or_right_23:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_31
    adr x0, sign_id
    b cmp_end_32
cmp_true_31:
cmp_end_32:
or_end_24:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_16_17:
    // Closure for func_16
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_16
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_33_34
func_33:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_35_36
func_35:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_38
    b or_end_39
or_right_38:
    adr x0, c
or_end_39:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_37
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_42
    adr x0, sign_id
    b cmp_end_43
cmp_true_42:
cmp_end_43:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_40
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_44
    adr x0, sign_id
    b cmp_end_45
cmp_true_44:
cmp_end_45:
    b and_end_41
and_fail_40:
    adr x0, sign_id
and_end_41:
blk_end_37:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_46_47
func_46:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_48_49
func_48:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_51
    b or_end_52
or_right_51:
    adr x0, c
or_end_52:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_50
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_59
    adr x0, sign_id
    b cmp_end_60
cmp_true_59:
cmp_end_60:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_57
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_61
    adr x0, sign_id
    b cmp_end_62
cmp_true_61:
cmp_end_62:
    b and_end_58
and_fail_57:
    adr x0, sign_id
and_end_58:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_55
    b or_end_56
or_right_55:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_65
    adr x0, sign_id
    b cmp_end_66
cmp_true_65:
cmp_end_66:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_63
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_67
    adr x0, sign_id
    b cmp_end_68
cmp_true_67:
cmp_end_68:
    b and_end_64
and_fail_63:
    adr x0, sign_id
and_end_64:
or_end_56:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_53
    b or_end_54
or_right_53:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_69
    adr x0, sign_id
    b cmp_end_70
cmp_true_69:
cmp_end_70:
or_end_54:
blk_end_50:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_48_49:
    // Closure for func_48
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_48
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_46_47:
    // Closure for func_46
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_46
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_71_72
func_71:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_73_74
func_73:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_76
    b or_end_77
or_right_76:
    adr x0, c
or_end_77:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_75
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_108
    adr x0, sign_id
    b cmp_end_109
cmp_true_108:
cmp_end_109:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_106
    b or_end_107
or_right_106:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_110
    adr x0, sign_id
    b cmp_end_111
cmp_true_110:
cmp_end_111:
or_end_107:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_104
    b or_end_105
or_right_104:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_112
    adr x0, sign_id
    b cmp_end_113
cmp_true_112:
cmp_end_113:
or_end_105:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_102
    b or_end_103
or_right_102:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_114
    adr x0, sign_id
    b cmp_end_115
cmp_true_114:
cmp_end_115:
or_end_103:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_100
    b or_end_101
or_right_100:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_116
    adr x0, sign_id
    b cmp_end_117
cmp_true_116:
cmp_end_117:
or_end_101:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_98
    b or_end_99
or_right_98:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_118
    adr x0, sign_id
    b cmp_end_119
cmp_true_118:
cmp_end_119:
or_end_99:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_96
    b or_end_97
or_right_96:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_120
    adr x0, sign_id
    b cmp_end_121
cmp_true_120:
cmp_end_121:
or_end_97:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_94
    b or_end_95
or_right_94:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_122
    adr x0, sign_id
    b cmp_end_123
cmp_true_122:
cmp_end_123:
or_end_95:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_92
    b or_end_93
or_right_92:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_124
    adr x0, sign_id
    b cmp_end_125
cmp_true_124:
cmp_end_125:
or_end_93:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_90
    b or_end_91
or_right_90:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_126
    adr x0, sign_id
    b cmp_end_127
cmp_true_126:
cmp_end_127:
or_end_91:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_88
    b or_end_89
or_right_88:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_128
    adr x0, sign_id
    b cmp_end_129
cmp_true_128:
cmp_end_129:
or_end_89:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_86
    b or_end_87
or_right_86:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_130
    adr x0, sign_id
    b cmp_end_131
cmp_true_130:
cmp_end_131:
or_end_87:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_84
    b or_end_85
or_right_84:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_132
    adr x0, sign_id
    b cmp_end_133
cmp_true_132:
cmp_end_133:
or_end_85:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_82
    b or_end_83
or_right_82:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_134
    adr x0, sign_id
    b cmp_end_135
cmp_true_134:
cmp_end_135:
or_end_83:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_80
    b or_end_81
or_right_80:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_136
    adr x0, sign_id
    b cmp_end_137
cmp_true_136:
cmp_end_137:
or_end_81:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_78
    b or_end_79
or_right_78:
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_138
    adr x0, sign_id
    b cmp_end_139
cmp_true_138:
cmp_end_139:
or_end_79:
blk_end_75:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_71_72:
    // Closure for func_71
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_71
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_140_141
func_140:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_142_143
func_142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_145
    b or_end_146
or_right_145:
    adr x0, list
or_end_146:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_144
    adr x0, list
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_149
    adr x0, sign_id
    b cmp_end_150
cmp_true_149:
cmp_end_150:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_147
    mov x0, #0
    b cond_end_148
cond_false_147:
    adr x0, sign_id
cond_end_148:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_144
    mov x0, #1
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_151
do_apply_152:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_153
do_compose_151:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_153:
    cmp x0, #4096
    b.hi do_compose_154
do_apply_155:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_156
do_compose_154:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_156:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_140_141:
    // Closure for func_140
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_140
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_157_158
func_157:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_159_160
func_159:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_162
    b or_end_163
or_right_162:
    adr x0, list
or_end_163:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_161
    adr x0, _rev
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_164
do_apply_165:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_166
do_compose_164:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_166:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_167
do_apply_168:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_169
do_compose_167:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_169:
blk_end_161:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_159_160:
    // Closure for func_159
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_159
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_157_158:
    // Closure for func_157
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_157
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_170_171
func_170:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_172_173
func_172:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_175
    b or_end_176
or_right_175:
    adr x0, list
or_end_176:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_174
    b after_func_177_178
func_177:
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
    b.eq cmp_true_182
    adr x0, sign_id
    b cmp_end_183
cmp_true_182:
cmp_end_183:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_180
    ldr x0, [x29, #-32]
    b cond_end_181
cond_false_180:
    adr x0, sign_id
cond_end_181:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_179
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
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
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, list
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
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
blk_end_179:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_177_178:
    // Closure for func_177
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_177
    ldr x0, [sp], #16
    bl _cons
blk_end_174:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_172_173:
    // Closure for func_172
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_172
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_170_171:
    // Closure for func_170
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_170
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_196_197
func_196:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_198_199
func_198:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_201
    b or_end_202
or_right_201:
    adr x0, list
or_end_202:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_200
    adr x0, length
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_203
do_apply_204:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_205
do_compose_203:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_205:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_200
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_206
do_apply_207:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_208
do_compose_206:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_208:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_200
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_209
do_apply_210:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_211
do_compose_209:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_211:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_212
do_apply_213:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_214
do_compose_212:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_214:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_215
do_apply_216:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_217
do_compose_215:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_217:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_200
    ldr x0, [x29, #-80]
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
    b.ne blk_end_200
    ldr x0, [x29, #-80]
blk_end_200:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_196_197:
    // Closure for func_196
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_196
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_218_219
func_218:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_220_221
func_220:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_223
    b or_end_224
or_right_223:
    adr x0, list
or_end_224:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_222
    b after_func_225_226
func_225:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_227_228
func_227:
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
    b.eq cmp_true_232
    adr x0, sign_id
    b cmp_end_233
cmp_true_232:
cmp_end_233:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_230
    mov x0, #0
    b cond_end_231
cond_false_230:
    adr x0, sign_id
cond_end_231:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_229
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
    b.hi do_compose_234
do_apply_235:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_236
do_compose_234:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_236:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_229
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_237
do_apply_238:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_239
do_compose_237:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_239:
    cmp x0, #4096
    b.hi do_compose_240
do_apply_241:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_242
do_compose_240:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_242:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_243
do_apply_244:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_245
do_compose_243:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_245:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_246
do_apply_247:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_248
do_compose_246:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_248:
blk_end_229:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_227_228:
    // Closure for func_227
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
    adr x1, func_227
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_225_226:
    // Closure for func_225
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_225
    ldr x0, [sp], #16
    bl _cons
blk_end_222:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_220_221:
    // Closure for func_220
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_220
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_218_219:
    // Closure for func_218
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_218
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_249_250
func_249:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_251_252
func_251:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_254
    b or_end_255
or_right_254:
    adr x0, source
or_end_255:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_253
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_256
do_apply_257:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_258
do_compose_256:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_258:
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_259
do_apply_260:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_261
do_compose_259:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_261:
    cmp x0, #4096
    b.hi do_compose_262
do_apply_263:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_264
do_compose_262:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_264:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_265
do_apply_266:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_267
do_compose_265:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_267:
blk_end_253:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_251_252:
    // Closure for func_251
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_251
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_273
    b or_end_274
or_right_273:
    adr x0, source
or_end_274:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_272
    b after_func_275_276
func_275:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_277_278
func_277:
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
    adr x0, scan_token
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_280
do_apply_281:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_282
do_compose_280:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_282:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_283
do_apply_284:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_285
do_compose_283:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_285:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_286
do_apply_287:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_288
do_compose_286:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_288:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_279
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_289
do_apply_290:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_291
do_compose_289:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_291:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_279
    ldr x0, [x29, #-96]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_279
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_294
    adr x0, sign_id
    b cmp_end_295
cmp_true_294:
cmp_end_295:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_292
    ldr x0, [x29, #-96]
    b cond_end_293
cond_false_292:
    adr x0, sign_id
cond_end_293:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_279
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_296
do_apply_297:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_298
do_compose_296:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_298:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    ldr x1, [sp], #16
    bl _cons
blk_end_279:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_277_278:
    // Closure for func_277
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
    adr x1, func_277
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_275_276:
    // Closure for func_275
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_275
    ldr x0, [sp], #16
    bl _cons
blk_end_272:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_270_271:
    // Closure for func_270
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_311_312
func_311:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_313_314
func_313:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_316
    b or_end_317
or_right_316:
    adr x0, source
or_end_317:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_315
    b after_func_318_319
func_318:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_320_321
func_320:
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
    b.ge cmp_true_325
    adr x0, sign_id
    b cmp_end_326
cmp_true_325:
cmp_end_326:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_323
    adr x0, sign_id
    b cond_end_324
cond_false_323:
    adr x0, sign_id
cond_end_324:
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
    b.hi do_compose_327
do_apply_328:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_329
do_compose_327:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_329:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_330
do_apply_331:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_332
do_compose_330:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_332:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_333
do_apply_334:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_335
do_compose_333:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_335:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_336
do_apply_337:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_338
do_compose_336:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_338:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_339
do_apply_340:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_341
do_compose_339:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_341:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_342
do_apply_343:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_344
do_compose_342:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_344:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_345
do_apply_346:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_347
do_compose_345:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_347:
    cmp x0, #4096
    b.hi do_compose_348
do_apply_349:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_350
do_compose_348:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_350:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_353
    adr x0, sign_id
    b cmp_end_354
cmp_true_353:
cmp_end_354:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_351
    adr x0, sign_id
    b cond_end_352
cond_false_351:
    adr x0, sign_id
cond_end_352:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    adr x0, is_digit
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, scan_num
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_368
do_apply_369:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_370
do_compose_368:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_370:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_361
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    cmp x0, #4096
    b.hi do_compose_371
do_apply_372:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_373
do_compose_371:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_373:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_361
    adr x0, _parse_int
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    cmp x0, #4096
    b.hi do_compose_374
do_apply_375:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_376
do_compose_374:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_376:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_361
    adr x0, tok_num
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    cmp x0, #4096
    b.hi do_compose_377
do_apply_378:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_379
do_compose_377:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_379:
    cmp x0, #4096
    b.hi do_compose_380
do_apply_381:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_382
do_compose_380:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_382:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_361:
    cmp x0, #4096
    b.hi do_compose_383
do_apply_384:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_385
do_compose_383:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_385:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    adr x0, is_alpha
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_386
do_apply_387:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_388
do_compose_386:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_388:
    str x0, [sp, #-16]!
    adr x0, scan_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    b.ne blk_end_389
    adr x0, tok_id
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_389:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    adr x0, is_op_char
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x0, scan_op
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_418
do_apply_419:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_420
do_compose_418:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_420:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_414
    adr x0, tok_op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_414:
    cmp x0, #4096
    b.hi do_compose_433
do_apply_434:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_435
do_compose_433:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_435:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    ldr x0, [x29, #-208]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_438
    adr x0, sign_id
    b cmp_end_439
cmp_true_438:
cmp_end_439:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_436
    adr x0, sign_id
    b cond_end_437
cond_false_436:
    adr x0, sign_id
cond_end_437:
    str x0, [sp, #-16]!
    adr x0, scan_str
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_440
    adr x0, tok_str
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
    cmp x0, #4096
    b.hi do_compose_453
do_apply_454:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_455
do_compose_453:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_455:
    cmp x0, #4096
    b.hi do_compose_456
do_apply_457:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_458
do_compose_456:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_458:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_440:
    cmp x0, #4096
    b.hi do_compose_459
do_apply_460:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_461
do_compose_459:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_461:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_322
    adr x0, tok_punc
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-208]
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
blk_end_322:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_320_321:
    // Closure for func_320
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
    adr x1, func_320
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_318_319:
    // Closure for func_318
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_318
    ldr x0, [sp], #16
    bl _cons
blk_end_315:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_311_312:
    // Closure for func_311
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_311
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_462_463
func_462:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_464_465
func_464:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_467
    b or_end_468
or_right_467:
    adr x0, source
or_end_468:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_466
    b after_func_469_470
func_469:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_471_472
func_471:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_479
do_apply_480:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_481
do_compose_479:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_481:
    str x0, [sp, #-16]!
    adr x0, is_digit
    cmp x0, #4096
    b.hi do_compose_482
do_apply_483:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_484
do_compose_482:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_484:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_471_472:
    // Closure for func_471
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_471
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_469_470:
    // Closure for func_469
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_469
    ldr x0, [sp], #16
    bl _cons
blk_end_466:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_464_465:
    // Closure for func_464
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_464
    ldr x0, [sp], #16
    bl _cons
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
    b.ne blk_end_0
    b after_func_485_486
func_485:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_487_488
func_487:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_490
    b or_end_491
or_right_490:
    adr x0, source
or_end_491:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_489
    b after_func_492_493
func_492:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_494_495
func_494:
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
    b.ne blk_end_496
    adr x0, _scan_while
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_497
do_apply_498:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_499
do_compose_497:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_499:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_500
do_apply_501:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_502
do_compose_500:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_502:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_503
do_apply_504:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_505
do_compose_503:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_505:
    str x0, [sp, #-16]!
    b after_func_506_507
func_506:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_508
    b or_end_509
or_right_508:
    adr x0, is_digit
or_end_509:
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
after_func_506_507:
    // Closure for func_506
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_506
    ldr x0, [sp], #16
    bl _cons
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
blk_end_496:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_494_495:
    // Closure for func_494
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_494
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_492_493:
    // Closure for func_492
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_492
    ldr x0, [sp], #16
    bl _cons
blk_end_489:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_524
    b or_end_525
or_right_524:
    adr x0, source
or_end_525:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_523
    b after_func_526_527
func_526:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_528_529
func_528:
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
    b.hi do_compose_530
do_apply_531:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_532
do_compose_530:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_532:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_533
do_apply_534:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_535
do_compose_533:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_535:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, is_op_char
    cmp x0, #4096
    b.hi do_compose_539
do_apply_540:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_541
do_compose_539:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_541:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_528_529:
    // Closure for func_528
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_528
    ldr x0, [sp], #16
    bl _cons
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
blk_end_523:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_542_543
func_542:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_544_545
func_544:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_547
    b or_end_548
or_right_547:
    adr x0, source
or_end_548:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_546
    b after_func_549_550
func_549:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_551_552
func_551:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_553_554
func_553:
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
    adr x0, _scan_while_rec
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_562
do_apply_563:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_564
do_compose_562:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_564:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_565
do_apply_566:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_567
do_compose_565:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_567:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_568
do_apply_569:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_570
do_compose_568:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_570:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_555
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_555
    adr x0, reverse
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_555
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
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
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_555:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_553_554:
    // Closure for func_553
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
    adr x1, func_553
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_551_552:
    // Closure for func_551
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_551
    ldr x0, [sp], #16
    bl _cons
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
blk_end_546:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_542_543:
    // Closure for func_542
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_542
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_586_587
func_586:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_588_589
func_588:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_591
    b or_end_592
or_right_591:
    adr x0, source
or_end_592:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_590
    b after_func_593_594
func_593:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_595_596
func_595:
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
    b after_func_597_598
func_597:
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
    b after_func_599_600
func_599:
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
    b.ge cmp_true_604
    adr x0, sign_id
    b cmp_end_605
cmp_true_604:
cmp_end_605:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_602
    adr x0, sign_id
    b cond_end_603
cond_false_602:
    adr x0, sign_id
cond_end_603:
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
    b.hi do_compose_606
do_apply_607:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_608
do_compose_606:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_608:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_609
do_apply_610:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_611
do_compose_609:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_611:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_612
do_apply_613:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_614
do_compose_612:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_614:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_615
do_apply_616:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_617
do_compose_615:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_617:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_618
do_apply_619:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_620
do_compose_618:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_620:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_621
do_apply_622:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_623
do_compose_621:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_623:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_624
do_apply_625:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_626
do_compose_624:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_626:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_627
do_apply_628:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_629
do_compose_627:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_629:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_630
do_apply_631:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_632
do_compose_630:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_632:
    cmp x0, #4096
    b.hi do_compose_633
do_apply_634:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_635
do_compose_633:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_635:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_601:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_599_600:
    // Closure for func_599
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
    adr x1, func_599
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_597_598:
    // Closure for func_597
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
    adr x1, func_597
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_595_596:
    // Closure for func_595
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
    adr x1, func_595
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_593_594:
    // Closure for func_593
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_593
    ldr x0, [sp], #16
    bl _cons
blk_end_590:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_588_589:
    // Closure for func_588
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_588
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_586_587:
    // Closure for func_586
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_586
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_636_637
func_636:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_638_639
func_638:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_641
    b or_end_642
or_right_641:
    adr x0, source
or_end_642:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_640
    b after_func_643_644
func_643:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_645_646
func_645:
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
    b.ne blk_end_647
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_647
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-64]
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
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_657
do_apply_658:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_659
do_compose_657:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_659:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_647
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_660
do_apply_661:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_662
do_compose_660:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_662:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_647
    adr x0, reverse
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    b.ne blk_end_647
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
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
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    cmp x0, #4096
    b.hi do_compose_672
do_apply_673:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_674
do_compose_672:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_674:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_647:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_645_646:
    // Closure for func_645
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_645
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_643_644:
    // Closure for func_643
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_643
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_636_637:
    // Closure for func_636
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_636
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_675_676
func_675:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_677_678
func_677:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_680
    b or_end_681
or_right_680:
    adr x0, source
or_end_681:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_679
    b after_func_682_683
func_682:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_684_685
func_684:
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
    b after_func_686_687
func_686:
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
    b.ge cmp_true_691
    adr x0, sign_id
    b cmp_end_692
cmp_true_691:
cmp_end_692:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_689
    adr x0, sign_id
    b cond_end_690
cond_false_689:
    adr x0, sign_id
cond_end_690:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_688
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_699
do_apply_700:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_701
do_compose_699:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_701:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_688
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_706
    adr x0, sign_id
    b cmp_end_707
cmp_true_706:
cmp_end_707:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_704
    b or_end_705
or_right_704:
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_708
    adr x0, sign_id
    b cmp_end_709
cmp_true_708:
cmp_end_709:
or_end_705:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_702
    adr x0, sign_id
    b cond_end_703
cond_false_702:
    adr x0, sign_id
cond_end_703:
    str x0, [sp, #-16]!
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_710
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
blk_end_710:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_688
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_720
do_apply_721:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_722
do_compose_720:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_722:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_723
do_apply_724:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_725
do_compose_723:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_725:
blk_end_688:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_686_687:
    // Closure for func_686
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
    adr x1, func_686
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_684_685:
    // Closure for func_684
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
    adr x1, func_684
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_682_683:
    // Closure for func_682
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_682
    ldr x0, [sp], #16
    bl _cons
blk_end_679:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_677_678:
    // Closure for func_677
    adr x0, sign_id
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
    adr x1, func_675
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_726_727
func_726:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_728_729
func_728:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_731
    b or_end_732
or_right_731:
    adr x0, str
or_end_732:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_730
    adr x0, str
blk_end_730:
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

