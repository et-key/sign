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
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, list_to_string
    str x0, [x1]
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, list
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_199
    adr x0, length
    adr x1, len
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_200
do_apply_201:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_202
do_compose_200:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_202:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_199
    adr x0, alloc
    adr x1, str
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, len
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
blk_end_199:
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
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, list
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
    adr x0, str
    ldr x0, [x0]
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
    mov x0, #0
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
    b.ne blk_end_209
    adr x0, str
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, len
    ldr x0, [x0]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_209
    adr x0, str
    ldr x0, [x0]
blk_end_209:
    cmp x0, #4096
    b.hi do_compose_219
do_apply_220:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_221
do_compose_219:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_221:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_222_223
func_222:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_224_225
func_224:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_227
    b or_end_228
or_right_227:
    adr x0, list
or_end_228:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_226
    b after_func_229_230
func_229:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_231_232
func_231:
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
    b.eq cmp_true_236
    adr x0, sign_id
    b cmp_end_237
cmp_true_236:
cmp_end_237:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_234
    mov x0, #0
    b cond_end_235
cond_false_234:
    adr x0, sign_id
cond_end_235:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_233
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_233
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, list
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_247
do_apply_248:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_249
do_compose_247:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_249:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_250
do_apply_251:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_252
do_compose_250:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_252:
blk_end_233:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_231_232:
    // Closure for func_231
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
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_229
    ldr x0, [sp], #16
    bl _cons
blk_end_226:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_224_225:
    // Closure for func_224
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_224
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_222_223:
    // Closure for func_222
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_222
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_253_254
func_253:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_255_256
func_255:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_258
    b or_end_259
or_right_258:
    adr x0, source
or_end_259:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_257
    adr x0, _tokenize_loop
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_260
do_apply_261:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_262
do_compose_260:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_262:
    str x0, [sp, #-16]!
    adr x0, len
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_263
do_apply_264:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_265
do_compose_263:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_265:
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
    str x0, [sp, #-16]!
    mov x0, #0
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
blk_end_257:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_255_256:
    // Closure for func_255
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_255
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_253_254:
    // Closure for func_253
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_253
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, _tokenize_loop
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_272
do_apply_273:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_274
do_compose_272:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_274:
    str x0, [sp, #-16]!
    adr x0, source
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_275
    adr x0, source_len
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_275
    adr x0, pos
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_275
    adr x0, scan_token
    adr x1, res
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_276
do_apply_277:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_278
do_compose_276:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_278:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_279
do_apply_280:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_281
do_compose_279:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_281:
    str x0, [sp, #-16]!
    adr x0, pos
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
    b.ne blk_end_275
    adr x0, head
    adr x1, token
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, res
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_275
    adr x0, token
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    adr x1, type
    str x0, [x1]
    adr x0, sign_id
blk_end_275:
    cmp x0, #4096
    b.hi do_compose_288
do_apply_289:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_290
do_compose_288:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_290:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
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
    adr x0, token
    ldr x0, [x0]
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
    b.ne blk_end_291
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, _tokenize_loop
    ldr x0, [x0]
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
    adr x0, source_len
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
    adr x0, res
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
blk_end_291:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, scan_token
    str x0, [x1]
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, source
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, source_len
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, pos
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, nth
    adr x1, c
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_318
do_apply_319:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_320
do_compose_318:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_320:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_321
do_apply_322:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_323
do_compose_321:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_323:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, scan_num
    adr x1, res_num
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_324
do_apply_325:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_326
do_compose_324:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_326:
    str x0, [sp, #-16]!
    adr x0, source_len
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
    str x0, [sp, #-16]!
    adr x0, pos
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, head
    adr x1, val_str
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, res_num
    ldr x0, [x0]
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
    b.ne blk_end_317
    adr x0, _parse_int
    adr x1, val
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, val_str
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, scan_id
    adr x1, res_id
    str x0, [x1]
    adr x0, sign_id
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
    adr x0, source_len
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
    adr x0, pos
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, scan_op
    adr x1, res_op
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_351
do_apply_352:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_353
do_compose_351:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_353:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_354
do_apply_355:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_356
do_compose_354:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_356:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, scan_str
    adr x1, res_str
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_357
do_apply_358:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_359
do_compose_357:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_359:
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_360
do_apply_361:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_362
do_compose_360:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_362:
    str x0, [sp, #-16]!
    adr x0, pos
    cmp x0, #4096
    b.hi do_compose_363
do_apply_364:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_365
do_compose_363:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_365:
blk_end_317:
    cmp x0, #4096
    b.hi do_compose_366
do_apply_367:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_368
do_compose_366:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_368:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    adr x0, source_len
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_372
    adr x0, sign_id
    b cmp_end_373
cmp_true_372:
cmp_end_373:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_370
    adr x0, sign_id
    b cond_end_371
cond_false_370:
    adr x0, sign_id
cond_end_371:
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
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
    b.ne blk_end_369
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, c
    str x0, [x1]
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, scan_token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, source
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
    adr x0, source_len
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
    str x0, [sp, #-16]!
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    cmp x0, #4096
    b.hi do_compose_389
do_apply_390:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_391
do_compose_389:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_391:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_369
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_394
    adr x0, sign_id
    b cmp_end_395
cmp_true_394:
cmp_end_395:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_392
    adr x0, sign_id
    b cond_end_393
cond_false_392:
    adr x0, sign_id
cond_end_393:
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, pos
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
    b.ne blk_end_369
    adr x0, is_digit
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, c
    str x0, [x1]
    adr x0, sign_id
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
    adr x0, tok_num
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_num
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
    b.ne blk_end_369
    adr x0, is_alpha
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, c
    str x0, [x1]
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
    adr x0, tok_id
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_id
    ldr x0, [x0]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_417
do_apply_418:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_419
do_compose_417:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_419:
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
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_369
    adr x0, is_op_char
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, c
    str x0, [x1]
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_op
    ldr x0, [x0]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_op
    ldr x0, [x0]
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
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
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
    b.ne blk_end_369
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_443
    adr x0, sign_id
    b cmp_end_444
cmp_true_443:
cmp_end_444:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_441
    adr x0, sign_id
    b cond_end_442
cond_false_441:
    adr x0, sign_id
cond_end_442:
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_str
    ldr x0, [x0]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_str
    ldr x0, [x0]
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
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_369
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_369
    adr x0, tok_punc
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, pos
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
blk_end_369:
    cmp x0, #4096
    b.hi do_compose_457
do_apply_458:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_459
do_compose_457:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_459:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_460_461
func_460:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_462_463
func_462:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_465
    b or_end_466
or_right_465:
    adr x0, source
or_end_466:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_464
    b after_func_467_468
func_467:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_469_470
func_469:
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
    b.hi do_compose_471
do_apply_472:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_473
do_compose_471:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_473:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_474
do_apply_475:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_476
do_compose_474:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_476:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x0, is_digit
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
after_func_469_470:
    // Closure for func_469
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_469
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_467_468:
    // Closure for func_467
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_467
    ldr x0, [sp], #16
    bl _cons
blk_end_464:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_460_461:
    // Closure for func_460
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_460
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_483_484
func_483:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_485_486
func_485:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_488
    b or_end_489
or_right_488:
    adr x0, source
or_end_489:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_487
    b after_func_490_491
func_490:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_492_493
func_492:
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
    b.ne blk_end_494
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
    b after_func_504_505
func_504:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_506
    b or_end_507
or_right_506:
    adr x0, is_digit
or_end_507:
    cmp x0, #4096
    b.hi do_compose_508
do_apply_509:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_510
do_compose_508:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_510:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_511
do_apply_512:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_513
do_compose_511:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_513:
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
    cmp x0, #4096
    b.hi do_compose_514
do_apply_515:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_516
do_compose_514:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_516:
blk_end_494:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_492_493:
    // Closure for func_492
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_492
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_490_491:
    // Closure for func_490
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_490
    ldr x0, [sp], #16
    bl _cons
blk_end_487:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_483_484:
    // Closure for func_483
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_483
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_517_518
func_517:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_519_520
func_519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_522
    b or_end_523
or_right_522:
    adr x0, source
or_end_523:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_521
    b after_func_524_525
func_524:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_526_527
func_526:
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
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-32]
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
    adr x0, is_op_char
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_526_527:
    // Closure for func_526
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_526
    ldr x0, [sp], #16
    bl _cons
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
blk_end_521:
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
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, _scan_while
    str x0, [x1]
    adr x0, sign_id
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
    adr x0, source
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_543
    adr x0, source_len
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_543
    adr x0, pos
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_543
    adr x0, pred
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_543
    adr x0, _scan_while_rec
    adr x1, res
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    adr x0, source_len
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
    str x0, [sp, #-16]!
    adr x0, pos
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
    str x0, [sp, #-16]!
    adr x0, pred
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_543
    adr x0, head
    adr x1, chars_rev
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, res
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
    b.ne blk_end_543
    adr x0, reverse
    adr x1, chars
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, chars_rev
    ldr x0, [x0]
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
blk_end_543:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, list_to_string
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_580_581
func_580:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_582_583
func_582:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_585
    b or_end_586
or_right_585:
    adr x0, source
or_end_586:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_584
    b after_func_587_588
func_587:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_589_590
func_589:
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
    b after_func_591_592
func_591:
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
    b after_func_593_594
func_593:
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
    b.ge cmp_true_598
    adr x0, sign_id
    b cmp_end_599
cmp_true_598:
cmp_end_599:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_596
    adr x0, sign_id
    b cond_end_597
cond_false_596:
    adr x0, sign_id
cond_end_597:
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
    b.hi do_compose_600
do_apply_601:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_602
do_compose_600:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_602:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_595
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_603
do_apply_604:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_605
do_compose_603:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_605:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    b.ne blk_end_595
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    ldr x0, [x29, #-80]
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
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_595
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_595:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_593_594:
    // Closure for func_593
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
    adr x1, func_593
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_591_592:
    // Closure for func_591
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
    adr x1, func_591
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_589_590:
    // Closure for func_589
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
    adr x1, func_589
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_587_588:
    // Closure for func_587
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_587
    ldr x0, [sp], #16
    bl _cons
blk_end_584:
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
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, scan_str
    str x0, [x1]
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, source
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_633
    adr x0, source_len
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_633
    adr x0, pos
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_633
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x1, start_pos
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_633
    adr x0, _scan_str_rec
    adr x1, res
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    adr x0, source_len
    cmp x0, #4096
    b.hi do_compose_637
do_apply_638:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_639
do_compose_637:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_639:
    str x0, [sp, #-16]!
    adr x0, start_pos
    ldr x0, [x0]
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
    mov x0, #0
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
    b.ne blk_end_633
    adr x0, head
    adr x1, chars_rev
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, res
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
    b.ne blk_end_633
    adr x0, reverse
    adr x1, chars
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, chars_rev
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_649
do_apply_650:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_651
do_compose_649:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_651:
blk_end_633:
    cmp x0, #4096
    b.hi do_compose_652
do_apply_653:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_654
do_compose_652:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_654:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, str_2
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_655
    adr x0, list_to_string
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_656
do_apply_657:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_658
do_compose_656:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_658:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x0, [x0]
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
    cmp x0, #4096
    b.hi do_compose_662
do_apply_663:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_664
do_compose_662:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_664:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_655:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_668_669
func_668:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_670_671
func_670:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_673
    b or_end_674
or_right_673:
    adr x0, source
or_end_674:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_672
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
    b after_func_679_680
func_679:
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
    b.ge cmp_true_684
    adr x0, sign_id
    b cmp_end_685
cmp_true_684:
cmp_end_685:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_682
    adr x0, sign_id
    b cond_end_683
cond_false_682:
    adr x0, sign_id
cond_end_683:
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
    b.hi do_compose_686
do_apply_687:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_688
do_compose_686:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_688:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_681
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_689
do_apply_690:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_691
do_compose_689:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_691:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_681
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_699
    adr x0, sign_id
    b cmp_end_700
cmp_true_699:
cmp_end_700:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_697
    b or_end_698
or_right_697:
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_701
    adr x0, sign_id
    b cmp_end_702
cmp_true_701:
cmp_end_702:
or_end_698:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_695
    adr x0, sign_id
    b cond_end_696
cond_false_695:
    adr x0, sign_id
cond_end_696:
    str x0, [sp, #-16]!
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_703
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
blk_end_703:
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
    b.ne blk_end_681
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, source
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_710
do_apply_711:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_712
do_compose_710:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_712:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_713
do_apply_714:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_715
do_compose_713:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_715:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_716
do_apply_717:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_718
do_compose_716:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_718:
blk_end_681:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_679_680:
    // Closure for func_679
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
    adr x1, func_679
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_677_678:
    // Closure for func_677
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
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_675
    ldr x0, [sp], #16
    bl _cons
blk_end_672:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_670_671:
    // Closure for func_670
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_670
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_668_669:
    // Closure for func_668
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_668
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_719_720
func_719:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_721_722
func_721:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_724
    b or_end_725
or_right_724:
    adr x0, str
    ldr x0, [x0]
or_end_725:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_723
    adr x0, str
    ldr x0, [x0]
blk_end_723:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_721_722:
    // Closure for func_721
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_721
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_719_720:
    // Closure for func_719
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_719
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
list_to_string: .quad 0
len: .quad 0
str: .quad 0
_tokenize_loop: .quad 0
res: .quad 0
token: .quad 0
type: .quad 0
scan_token: .quad 0
c: .quad 0
res_num: .quad 0
val_str: .quad 0
val: .quad 0
res_id: .quad 0
res_op: .quad 0
res_str: .quad 0
_scan_while: .quad 0
chars_rev: .quad 0
chars: .quad 0
scan_str: .quad 0
start_pos: .quad 0


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

