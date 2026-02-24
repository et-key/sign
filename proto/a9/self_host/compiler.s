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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4
    tst x9, #1
    b.eq do_concat_3
    tst x0, #1
    b.ne do_compose_1
do_apply_2:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_5
do_compose_1:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_5
do_concat_3:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_5
id_morphism_4:
    b apply_end_5
apply_end_5:
    str x0, [sp, #-16]!
    adr x0, Functional
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_9
    tst x9, #1
    b.eq do_concat_8
    tst x0, #1
    b.ne do_compose_6
do_apply_7:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_10
do_compose_6:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_10
do_concat_8:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_10
id_morphism_9:
    b apply_end_10
apply_end_10:
    str x0, [sp, #-16]!
    adr x0, Compiler
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_14
    tst x9, #1
    b.eq do_concat_13
    tst x0, #1
    b.ne do_compose_11
do_apply_12:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_15
do_compose_11:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_15
do_concat_13:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_15
id_morphism_14:
    b apply_end_15
apply_end_15:
    str x0, [sp, #-16]!
    adr x0, Code
    str x0, [sp, #-16]!
    adr x0, Generator
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_19
    tst x9, #1
    b.eq do_concat_18
    tst x0, #1
    b.ne do_compose_16
do_apply_17:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_20
do_compose_16:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_20
do_concat_18:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_20
id_morphism_19:
    b apply_end_20
apply_end_20:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_24
    tst x9, #1
    b.eq do_concat_23
    tst x0, #1
    b.ne do_compose_21
do_apply_22:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_25
do_compose_21:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_25
do_concat_23:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_25
id_morphism_24:
    b apply_end_25
apply_end_25:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Transforms
    str x0, [sp, #-16]!
    adr x0, AST
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_29
    tst x9, #1
    b.eq do_concat_28
    tst x0, #1
    b.ne do_compose_26
do_apply_27:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_30
do_compose_26:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_30
do_concat_28:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_30
id_morphism_29:
    b apply_end_30
apply_end_30:
    str x0, [sp, #-16]!
    adr x0, from
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_34
    tst x9, #1
    b.eq do_concat_33
    tst x0, #1
    b.ne do_compose_31
do_apply_32:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_35
do_compose_31:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_35
do_concat_33:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_35
id_morphism_34:
    b apply_end_35
apply_end_35:
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_39
    tst x9, #1
    b.eq do_concat_38
    tst x0, #1
    b.ne do_compose_36
do_apply_37:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_40
do_compose_36:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_40
do_concat_38:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_40
id_morphism_39:
    b apply_end_40
apply_end_40:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_44
    tst x9, #1
    b.eq do_concat_43
    tst x0, #1
    b.ne do_compose_41
do_apply_42:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_45
do_compose_41:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_45
do_concat_43:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_45
id_morphism_44:
    b apply_end_45
apply_end_45:
    str x0, [sp, #-16]!
    adr x0, sn
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_49
    tst x9, #1
    b.eq do_concat_48
    tst x0, #1
    b.ne do_compose_46
do_apply_47:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_50
do_compose_46:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_50
do_concat_48:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_50
id_morphism_49:
    b apply_end_50
apply_end_50:
    str x0, [sp, #-16]!
    adr x0, into
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_54
    tst x9, #1
    b.eq do_concat_53
    tst x0, #1
    b.ne do_compose_51
do_apply_52:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_55
do_compose_51:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_55
do_concat_53:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_55
id_morphism_54:
    b apply_end_55
apply_end_55:
    str x0, [sp, #-16]!
    adr x0, ARM64
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_59
    tst x9, #1
    b.eq do_concat_58
    tst x0, #1
    b.ne do_compose_56
do_apply_57:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_60
do_compose_56:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_60
do_concat_58:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_60
id_morphism_59:
    b apply_end_60
apply_end_60:
    str x0, [sp, #-16]!
    adr x0, Assembly
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_64
    tst x9, #1
    b.eq do_concat_63
    tst x0, #1
    b.ne do_compose_61
do_apply_62:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_65
do_compose_61:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_65
do_concat_63:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_65
id_morphism_64:
    b apply_end_65
apply_end_65:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_69
    tst x9, #1
    b.eq do_concat_68
    tst x0, #1
    b.ne do_compose_66
do_apply_67:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_70
do_compose_66:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_70
do_concat_68:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_70
id_morphism_69:
    b apply_end_70
apply_end_70:
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_76
    tst x9, #1
    b.eq do_concat_75
    tst x0, #1
    b.ne do_compose_73
do_apply_74:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_77
do_compose_73:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_77
do_concat_75:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_77
id_morphism_76:
    b apply_end_77
apply_end_77:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_71
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_83
    tst x9, #1
    b.eq do_concat_82
    tst x0, #1
    b.ne do_compose_80
do_apply_81:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_84
do_compose_80:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_84
do_concat_82:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_84
id_morphism_83:
    b apply_end_84
apply_end_84:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_88
    tst x9, #1
    b.eq do_concat_87
    tst x0, #1
    b.ne do_compose_85
do_apply_86:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_89
do_compose_85:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_89
do_concat_87:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_89
id_morphism_88:
    b apply_end_89
apply_end_89:
    str x0, [sp, #-16]!
    adr x0, threaded
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_93
    tst x9, #1
    b.eq do_concat_92
    tst x0, #1
    b.ne do_compose_90
do_apply_91:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_94
do_compose_90:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_94
do_concat_92:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_94
id_morphism_93:
    b apply_end_94
apply_end_94:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Stack
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_98
    tst x9, #1
    b.eq do_concat_97
    tst x0, #1
    b.ne do_compose_95
do_apply_96:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_99
do_compose_95:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_99
do_concat_97:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_99
id_morphism_98:
    b apply_end_99
apply_end_99:
    str x0, [sp, #-16]!
    adr x0, Machine
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_103
    tst x9, #1
    b.eq do_concat_102
    tst x0, #1
    b.ne do_compose_100
do_apply_101:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_104
do_compose_100:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_104
do_concat_102:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_104
id_morphism_103:
    b apply_end_104
apply_end_104:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_78
    adr x0, Context
    str x0, [sp, #-16]!
    adr x0, is
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_110
    tst x9, #1
    b.eq do_concat_109
    tst x0, #1
    b.ne do_compose_107
do_apply_108:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_111
do_compose_107:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_111
do_concat_109:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_111
id_morphism_110:
    b apply_end_111
apply_end_111:
    str x0, [sp, #-16]!
    adr x0, passed
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_115
    tst x9, #1
    b.eq do_concat_114
    tst x0, #1
    b.ne do_compose_112
do_apply_113:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_116
do_compose_112:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_116
do_concat_114:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_116
id_morphism_115:
    b apply_end_116
apply_end_116:
    str x0, [sp, #-16]!
    adr x0, as
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_120
    tst x9, #1
    b.eq do_concat_119
    tst x0, #1
    b.ne do_compose_117
do_apply_118:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_121
do_compose_117:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_121
do_concat_119:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_121
id_morphism_120:
    b apply_end_121
apply_end_121:
    str x0, [sp, #-16]!
    adr x0, arguments
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_125
    tst x9, #1
    b.eq do_concat_124
    tst x0, #1
    b.ne do_compose_122
do_apply_123:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_126
do_compose_122:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_126
do_concat_124:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_126
id_morphism_125:
    b apply_end_126
apply_end_126:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Output
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_130
    tst x9, #1
    b.eq do_concat_129
    tst x0, #1
    b.ne do_compose_127
do_apply_128:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_131
do_compose_127:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_131
do_concat_129:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_131
id_morphism_130:
    b apply_end_131
apply_end_131:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_105
    adr x0, List
    str x0, [sp, #-16]!
    adr x0, of
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_135
    tst x9, #1
    b.eq do_concat_134
    tst x0, #1
    b.ne do_compose_132
do_apply_133:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_136
do_compose_132:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_136
do_concat_134:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_136
id_morphism_135:
    b apply_end_136
apply_end_136:
    str x0, [sp, #-16]!
    adr x0, assembly
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_140
    tst x9, #1
    b.eq do_concat_139
    tst x0, #1
    b.ne do_compose_137
do_apply_138:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_141
do_compose_137:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_141
do_concat_139:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_141
id_morphism_140:
    b apply_end_141
apply_end_141:
    str x0, [sp, #-16]!
    adr x0, instruction
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_145
    tst x9, #1
    b.eq do_concat_144
    tst x0, #1
    b.ne do_compose_142
do_apply_143:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_146
do_compose_142:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_146
do_concat_144:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_146
id_morphism_145:
    b apply_end_146
apply_end_146:
    str x0, [sp, #-16]!
    adr x0, strings
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_150
    tst x9, #1
    b.eq do_concat_149
    tst x0, #1
    b.ne do_compose_147
do_apply_148:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_151
do_compose_147:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_151
do_concat_149:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_151
id_morphism_150:
    b apply_end_151
apply_end_151:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_155
    tst x9, #1
    b.eq do_concat_154
    tst x0, #1
    b.ne do_compose_152
do_apply_153:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_156
do_compose_152:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_156
do_concat_154:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_156
id_morphism_155:
    b apply_end_156
apply_end_156:
    b cond_end_106
cond_false_105:
    adr x0, sign_id
cond_end_106:
    b cond_end_79
cond_false_78:
    adr x0, sign_id
cond_end_79:
    b cond_end_72
cond_false_71:
    adr x0, sign_id
cond_end_72:
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_162
    tst x9, #1
    b.eq do_concat_161
    tst x0, #1
    b.ne do_compose_159
do_apply_160:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_163
do_compose_159:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_163
do_concat_161:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_163
id_morphism_162:
    b apply_end_163
apply_end_163:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_157
    b after_func_164_165
func_164:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_166_167
func_166:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_168_169
func_168:
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
    b after_func_170_171
func_170:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_170_171:
    // Closure for func_170
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
    adr x1, func_170
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_168_169:
    // Closure for func_168
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
    adr x1, func_168
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_166_167:
    // Closure for func_166
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_166
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_164_165:
    // Closure for func_164
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_164
    ldr x0, [sp], #16
    bl _cons
    b cond_end_158
cond_false_157:
    adr x0, sign_id
cond_end_158:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_label_count
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_177
    tst x9, #1
    b.eq do_concat_176
    tst x0, #1
    b.ne do_compose_174
do_apply_175:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_178
do_compose_174:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_178
do_concat_176:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_178
id_morphism_177:
    b apply_end_178
apply_end_178:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_172
    b after_func_179_180
func_179:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_184
    tst x9, #1
    b.eq do_concat_183
    tst x0, #1
    b.ne do_compose_181
do_apply_182:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_185
do_compose_181:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_185
do_concat_183:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_185
id_morphism_184:
    b apply_end_185
apply_end_185:
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
    b cond_end_173
cond_false_172:
    adr x0, sign_id
cond_end_173:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_strings
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_191
    tst x9, #1
    b.eq do_concat_190
    tst x0, #1
    b.ne do_compose_188
do_apply_189:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_192
do_compose_188:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_192
do_concat_190:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_192
id_morphism_191:
    b apply_end_192
apply_end_192:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_186
    b after_func_193_194
func_193:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_198
    tst x9, #1
    b.eq do_concat_197
    tst x0, #1
    b.ne do_compose_195
do_apply_196:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_199
do_compose_195:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_199
do_concat_197:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_199
id_morphism_198:
    b apply_end_199
apply_end_199:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_203
    tst x9, #1
    b.eq do_concat_202
    tst x0, #1
    b.ne do_compose_200
do_apply_201:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_204
do_compose_200:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_204
do_concat_202:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_204
id_morphism_203:
    b apply_end_204
apply_end_204:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_193_194:
    // Closure for func_193
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_193
    ldr x0, [sp], #16
    bl _cons
    b cond_end_187
cond_false_186:
    adr x0, sign_id
cond_end_187:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_env
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_210
    tst x9, #1
    b.eq do_concat_209
    tst x0, #1
    b.ne do_compose_207
do_apply_208:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_211
do_compose_207:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_211
do_concat_209:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_211
id_morphism_210:
    b apply_end_211
apply_end_211:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_205
    b after_func_212_213
func_212:
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_217
    tst x9, #1
    b.eq do_concat_216
    tst x0, #1
    b.ne do_compose_214
do_apply_215:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_218
do_compose_214:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_218
do_concat_216:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_218
id_morphism_217:
    b apply_end_218
apply_end_218:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_222
    tst x9, #1
    b.eq do_concat_221
    tst x0, #1
    b.ne do_compose_219
do_apply_220:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_223
do_compose_219:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_223
do_concat_221:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_223
id_morphism_222:
    b apply_end_223
apply_end_223:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_227
    tst x9, #1
    b.eq do_concat_226
    tst x0, #1
    b.ne do_compose_224
do_apply_225:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_228
do_compose_224:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_228
do_concat_226:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_228
id_morphism_227:
    b apply_end_228
apply_end_228:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_212_213:
    // Closure for func_212
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_212
    ldr x0, [sp], #16
    bl _cons
    b cond_end_206
cond_false_205:
    adr x0, sign_id
cond_end_206:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_stack_offset
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_234
    tst x9, #1
    b.eq do_concat_233
    tst x0, #1
    b.ne do_compose_231
do_apply_232:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_235
do_compose_231:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_235
do_concat_233:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_235
id_morphism_234:
    b apply_end_235
apply_end_235:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_229
    b after_func_236_237
func_236:
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_241
    tst x9, #1
    b.eq do_concat_240
    tst x0, #1
    b.ne do_compose_238
do_apply_239:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_242
do_compose_238:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_242
do_concat_240:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_242
id_morphism_241:
    b apply_end_242
apply_end_242:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_246
    tst x9, #1
    b.eq do_concat_245
    tst x0, #1
    b.ne do_compose_243
do_apply_244:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_247
do_compose_243:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_247
do_concat_245:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_247
id_morphism_246:
    b apply_end_247
apply_end_247:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_251
    tst x9, #1
    b.eq do_concat_250
    tst x0, #1
    b.ne do_compose_248
do_apply_249:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_252
do_compose_248:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_252
do_concat_250:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_252
id_morphism_251:
    b apply_end_252
apply_end_252:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_256
    tst x9, #1
    b.eq do_concat_255
    tst x0, #1
    b.ne do_compose_253
do_apply_254:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_257
do_compose_253:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_257
do_concat_255:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_257
id_morphism_256:
    b apply_end_257
apply_end_257:
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
    b cond_end_230
cond_false_229:
    adr x0, sign_id
cond_end_230:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, lookup_var
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_263
    tst x9, #1
    b.eq do_concat_262
    tst x0, #1
    b.ne do_compose_260
do_apply_261:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_264
do_compose_260:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_264
do_concat_262:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_264
id_morphism_263:
    b apply_end_264
apply_end_264:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_258
    b after_func_265_266
func_265:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_267_268
func_267:
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
    b.eq cmp_true_272
    adr x0, sign_id
    b cmp_end_273
cmp_true_272:
cmp_end_273:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_270
    mov x0, #0
    b cond_end_271
cond_false_270:
    adr x0, sign_id
cond_end_271:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_269
    b after_func_274_275
func_274:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_282
    tst x9, #1
    b.eq do_concat_281
    tst x0, #1
    b.ne do_compose_279
do_apply_280:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_283
do_compose_279:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_283
do_concat_281:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_283
id_morphism_282:
    b apply_end_283
apply_end_283:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_287
    tst x9, #1
    b.eq do_concat_286
    tst x0, #1
    b.ne do_compose_284
do_apply_285:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_288
do_compose_284:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_288
do_concat_286:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_288
id_morphism_287:
    b apply_end_288
apply_end_288:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_292
    tst x9, #1
    b.eq do_concat_291
    tst x0, #1
    b.ne do_compose_289
do_apply_290:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_293
do_compose_289:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_293
do_concat_291:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_293
id_morphism_292:
    b apply_end_293
apply_end_293:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_277
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_297
    tst x9, #1
    b.eq do_concat_296
    tst x0, #1
    b.ne do_compose_294
do_apply_295:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_298
do_compose_294:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_298
do_concat_296:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_298
id_morphism_297:
    b apply_end_298
apply_end_298:
    b cond_end_278
cond_false_277:
    adr x0, sign_id
cond_end_278:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_276
    adr x0, lookup_var
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_302
    tst x9, #1
    b.eq do_concat_301
    tst x0, #1
    b.ne do_compose_299
do_apply_300:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_303
do_compose_299:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_303
do_concat_301:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_303
id_morphism_302:
    b apply_end_303
apply_end_303:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_307
    tst x9, #1
    b.eq do_concat_306
    tst x0, #1
    b.ne do_compose_304
do_apply_305:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_308
do_compose_304:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_308
do_concat_306:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_308
id_morphism_307:
    b apply_end_308
apply_end_308:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_312
    tst x9, #1
    b.eq do_concat_311
    tst x0, #1
    b.ne do_compose_309
do_apply_310:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_313
do_compose_309:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_313
do_concat_311:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_313
id_morphism_312:
    b apply_end_313
apply_end_313:
blk_end_276:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_317
    tst x9, #1
    b.eq do_concat_316
    tst x0, #1
    b.ne do_compose_314
do_apply_315:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_318
do_compose_314:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_318
do_concat_316:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_318
id_morphism_317:
    b apply_end_318
apply_end_318:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_269
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_322
    tst x9, #1
    b.eq do_concat_321
    tst x0, #1
    b.ne do_compose_319
do_apply_320:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_323
do_compose_319:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_323
do_concat_321:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_323
id_morphism_322:
    b apply_end_323
apply_end_323:
blk_end_269:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_267_268:
    // Closure for func_267
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_267
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_265_266:
    // Closure for func_265
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_265
    ldr x0, [sp], #16
    bl _cons
    b cond_end_259
cond_false_258:
    adr x0, sign_id
cond_end_259:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_329
    tst x9, #1
    b.eq do_concat_328
    tst x0, #1
    b.ne do_compose_326
do_apply_327:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_330
do_compose_326:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_330
do_concat_328:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_330
id_morphism_329:
    b apply_end_330
apply_end_330:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_324
    b after_func_331_332
func_331:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_333_334
func_333:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_335_336
func_335:
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
    b.eq or_right_338
    b or_end_339
or_right_338:
    adr x0, tok_val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_343
    tst x9, #1
    b.eq do_concat_342
    tst x0, #1
    b.ne do_compose_340
do_apply_341:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_344
do_compose_340:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_344
do_concat_342:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_344
id_morphism_343:
    b apply_end_344
apply_end_344:
or_end_339:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_337
    b after_func_345_346
func_345:
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
    b.eq or_right_348
    b or_end_349
or_right_348:
    adr x0, add_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_353
    tst x9, #1
    b.eq do_concat_352
    tst x0, #1
    b.ne do_compose_350
do_apply_351:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_354
do_compose_350:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_354
do_concat_352:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_354
id_morphism_353:
    b apply_end_354
apply_end_354:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_358
    tst x9, #1
    b.eq do_concat_357
    tst x0, #1
    b.ne do_compose_355
do_apply_356:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_359
do_compose_355:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_359
do_concat_357:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_359
id_morphism_358:
    b apply_end_359
apply_end_359:
or_end_349:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_347
    b after_func_360_361
func_360:
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
    b.eq or_right_363
    b or_end_364
or_right_363:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_368
    tst x9, #1
    b.eq do_concat_367
    tst x0, #1
    b.ne do_compose_365
do_apply_366:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_369
do_compose_365:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_369
do_concat_367:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_369
id_morphism_368:
    b apply_end_369
apply_end_369:
or_end_364:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_362
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_373
    b or_end_374
or_right_373:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_378
    tst x9, #1
    b.eq do_concat_377
    tst x0, #1
    b.ne do_compose_375
do_apply_376:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_379
do_compose_375:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_379
do_concat_377:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_379
id_morphism_378:
    b apply_end_379
apply_end_379:
or_end_374:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_372
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_383
    tst x9, #1
    b.eq do_concat_382
    tst x0, #1
    b.ne do_compose_380
do_apply_381:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_384
do_compose_380:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_384
do_concat_382:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_384
id_morphism_383:
    b apply_end_384
apply_end_384:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_388
    tst x9, #1
    b.eq do_concat_387
    tst x0, #1
    b.ne do_compose_385
do_apply_386:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_389
do_compose_385:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_389
do_concat_387:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_389
id_morphism_388:
    b apply_end_389
apply_end_389:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_393
    tst x9, #1
    b.eq do_concat_392
    tst x0, #1
    b.ne do_compose_390
do_apply_391:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_394
do_compose_390:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_394
do_concat_392:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_394
id_morphism_393:
    b apply_end_394
apply_end_394:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_398
    tst x9, #1
    b.eq do_concat_397
    tst x0, #1
    b.ne do_compose_395
do_apply_396:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_399
do_compose_395:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_399
do_concat_397:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_399
id_morphism_398:
    b apply_end_399
apply_end_399:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_372:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_370_371:
    // Closure for func_370
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
    adr x1, func_370
    ldr x0, [sp], #16
    bl _cons
blk_end_362:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_360_361:
    // Closure for func_360
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_360
    ldr x0, [sp], #16
    bl _cons
blk_end_347:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_345_346:
    // Closure for func_345
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
    adr x1, func_345
    ldr x0, [sp], #16
    bl _cons
blk_end_337:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_335_336:
    // Closure for func_335
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
    adr x1, func_335
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_333_334:
    // Closure for func_333
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_333
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_331_332:
    // Closure for func_331
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_331
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
    adr x0, compile_apply
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_405
    tst x9, #1
    b.eq do_concat_404
    tst x0, #1
    b.ne do_compose_402
do_apply_403:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_406
do_compose_402:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_406
do_concat_404:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_406
id_morphism_405:
    b apply_end_406
apply_end_406:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_400
    b after_func_407_408
func_407:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_409_410
func_409:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_415
    tst x9, #1
    b.eq do_concat_414
    tst x0, #1
    b.ne do_compose_412
do_apply_413:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_416
do_compose_412:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_416
do_concat_414:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_416
id_morphism_415:
    b apply_end_416
apply_end_416:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_420
    tst x9, #1
    b.eq do_concat_419
    tst x0, #1
    b.ne do_compose_417
do_apply_418:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_421
do_compose_417:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_421
do_concat_419:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_421
id_morphism_420:
    b apply_end_421
apply_end_421:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_425
    tst x9, #1
    b.eq do_concat_424
    tst x0, #1
    b.ne do_compose_422
do_apply_423:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_426
do_compose_422:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_426
do_concat_424:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_426
id_morphism_425:
    b apply_end_426
apply_end_426:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_430
    tst x9, #1
    b.eq do_concat_429
    tst x0, #1
    b.ne do_compose_427
do_apply_428:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_431
do_compose_427:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_431
do_concat_429:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_431
id_morphism_430:
    b apply_end_431
apply_end_431:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_435
    tst x9, #1
    b.eq do_concat_434
    tst x0, #1
    b.ne do_compose_432
do_apply_433:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_436
do_compose_432:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_436
do_concat_434:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_436
id_morphism_435:
    b apply_end_436
apply_end_436:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, is_spread_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_440
    tst x9, #1
    b.eq do_concat_439
    tst x0, #1
    b.ne do_compose_437
do_apply_438:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_441
do_compose_437:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_441
do_concat_439:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_441
id_morphism_440:
    b apply_end_441
apply_end_441:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_2
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_442
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_446
    tst x9, #1
    b.eq do_concat_445
    tst x0, #1
    b.ne do_compose_443
do_apply_444:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_447
do_compose_443:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_447
do_concat_445:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_447
id_morphism_446:
    b apply_end_447
apply_end_447:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_451
    tst x9, #1
    b.eq do_concat_450
    tst x0, #1
    b.ne do_compose_448
do_apply_449:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_452
do_compose_448:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_452
do_concat_450:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_452
id_morphism_451:
    b apply_end_452
apply_end_452:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_456
    tst x9, #1
    b.eq do_concat_455
    tst x0, #1
    b.ne do_compose_453
do_apply_454:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_457
do_compose_453:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_457
do_concat_455:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_457
id_morphism_456:
    b apply_end_457
apply_end_457:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_442
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_461
    tst x9, #1
    b.eq do_concat_460
    tst x0, #1
    b.ne do_compose_458
do_apply_459:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_462
do_compose_458:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_462
do_concat_460:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_462
id_morphism_461:
    b apply_end_462
apply_end_462:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_466
    tst x9, #1
    b.eq do_concat_465
    tst x0, #1
    b.ne do_compose_463
do_apply_464:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_467
do_compose_463:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_467
do_concat_465:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_467
id_morphism_466:
    b apply_end_467
apply_end_467:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_442
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_471
    tst x9, #1
    b.eq do_concat_470
    tst x0, #1
    b.ne do_compose_468
do_apply_469:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_472
do_compose_468:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_472
do_concat_470:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_472
id_morphism_471:
    b apply_end_472
apply_end_472:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_442
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_476
    tst x9, #1
    b.eq do_concat_475
    tst x0, #1
    b.ne do_compose_473
do_apply_474:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_477
do_compose_473:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_477
do_concat_475:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_477
id_morphism_476:
    b apply_end_477
apply_end_477:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_442
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_481
    tst x9, #1
    b.eq do_concat_480
    tst x0, #1
    b.ne do_compose_478
do_apply_479:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_482
do_compose_478:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_482
do_concat_480:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_482
id_morphism_481:
    b apply_end_482
apply_end_482:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_486
    tst x9, #1
    b.eq do_concat_485
    tst x0, #1
    b.ne do_compose_483
do_apply_484:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_487
do_compose_483:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_487
do_concat_485:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_487
id_morphism_486:
    b apply_end_487
apply_end_487:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_442
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_491
    tst x9, #1
    b.eq do_concat_490
    tst x0, #1
    b.ne do_compose_488
do_apply_489:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_492
do_compose_488:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_492
do_concat_490:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_492
id_morphism_491:
    b apply_end_492
apply_end_492:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_442
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_496
    tst x9, #1
    b.eq do_concat_495
    tst x0, #1
    b.ne do_compose_493
do_apply_494:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_497
do_compose_493:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_497
do_concat_495:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_497
id_morphism_496:
    b apply_end_497
apply_end_497:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_442
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_4
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_5
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_498
    adr x0, str_6
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_498:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_502
    tst x9, #1
    b.eq do_concat_501
    tst x0, #1
    b.ne do_compose_499
do_apply_500:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_503
do_compose_499:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_503
do_concat_501:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_503
id_morphism_502:
    b apply_end_503
apply_end_503:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_507
    tst x9, #1
    b.eq do_concat_506
    tst x0, #1
    b.ne do_compose_504
do_apply_505:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_508
do_compose_504:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_508
do_concat_506:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_508
id_morphism_507:
    b apply_end_508
apply_end_508:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_512
    tst x9, #1
    b.eq do_concat_511
    tst x0, #1
    b.ne do_compose_509
do_apply_510:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_513
do_compose_509:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_513
do_concat_511:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_513
id_morphism_512:
    b apply_end_513
apply_end_513:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_517
    tst x9, #1
    b.eq do_concat_516
    tst x0, #1
    b.ne do_compose_514
do_apply_515:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_518
do_compose_514:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_518
do_concat_516:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_518
id_morphism_517:
    b apply_end_518
apply_end_518:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-208]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_442:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_522
    tst x9, #1
    b.eq do_concat_521
    tst x0, #1
    b.ne do_compose_519
do_apply_520:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_523
do_compose_519:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_523
do_concat_521:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_523
id_morphism_522:
    b apply_end_523
apply_end_523:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, str_7
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_527
    tst x9, #1
    b.eq do_concat_526
    tst x0, #1
    b.ne do_compose_524
do_apply_525:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_528
do_compose_524:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_528
do_concat_526:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_528
id_morphism_527:
    b apply_end_528
apply_end_528:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_532
    tst x9, #1
    b.eq do_concat_531
    tst x0, #1
    b.ne do_compose_529
do_apply_530:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_533
do_compose_529:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_533
do_concat_531:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_533
id_morphism_532:
    b apply_end_533
apply_end_533:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_537
    tst x9, #1
    b.eq do_concat_536
    tst x0, #1
    b.ne do_compose_534
do_apply_535:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_538
do_compose_534:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_538
do_concat_536:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_538
id_morphism_537:
    b apply_end_538
apply_end_538:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_542
    tst x9, #1
    b.eq do_concat_541
    tst x0, #1
    b.ne do_compose_539
do_apply_540:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_543
do_compose_539:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_543
do_concat_541:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_543
id_morphism_542:
    b apply_end_543
apply_end_543:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_547
    tst x9, #1
    b.eq do_concat_546
    tst x0, #1
    b.ne do_compose_544
do_apply_545:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_548
do_compose_544:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_548
do_concat_546:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_548
id_morphism_547:
    b apply_end_548
apply_end_548:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-272]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_552
    tst x9, #1
    b.eq do_concat_551
    tst x0, #1
    b.ne do_compose_549
do_apply_550:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_553
do_compose_549:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_553
do_concat_551:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_553
id_morphism_552:
    b apply_end_553
apply_end_553:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-288]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_557
    tst x9, #1
    b.eq do_concat_556
    tst x0, #1
    b.ne do_compose_554
do_apply_555:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_558
do_compose_554:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_558
do_concat_556:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_558
id_morphism_557:
    b apply_end_558
apply_end_558:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-288]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_562
    tst x9, #1
    b.eq do_concat_561
    tst x0, #1
    b.ne do_compose_559
do_apply_560:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_563
do_compose_559:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_563
do_concat_561:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_563
id_morphism_562:
    b apply_end_563
apply_end_563:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-320]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_567
    tst x9, #1
    b.eq do_concat_566
    tst x0, #1
    b.ne do_compose_564
do_apply_565:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_568
do_compose_564:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_568
do_concat_566:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_568
id_morphism_567:
    b apply_end_568
apply_end_568:
    str x0, [sp, #-16]!
    adr x0, str_8
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_572
    tst x9, #1
    b.eq do_concat_571
    tst x0, #1
    b.ne do_compose_569
do_apply_570:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_573
do_compose_569:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_573
do_concat_571:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_573
id_morphism_572:
    b apply_end_573
apply_end_573:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-336]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_577
    tst x9, #1
    b.eq do_concat_576
    tst x0, #1
    b.ne do_compose_574
do_apply_575:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_578
do_compose_574:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_578
do_concat_576:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_578
id_morphism_577:
    b apply_end_578
apply_end_578:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-336]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_582
    tst x9, #1
    b.eq do_concat_581
    tst x0, #1
    b.ne do_compose_579
do_apply_580:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_583
do_compose_579:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_583
do_concat_581:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_583
id_morphism_582:
    b apply_end_583
apply_end_583:
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_587
    tst x9, #1
    b.eq do_concat_586
    tst x0, #1
    b.ne do_compose_584
do_apply_585:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_588
do_compose_584:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_588
do_concat_586:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_588
id_morphism_587:
    b apply_end_588
apply_end_588:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-368]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_592
    tst x9, #1
    b.eq do_concat_591
    tst x0, #1
    b.ne do_compose_589
do_apply_590:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_593
do_compose_589:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_593
do_concat_591:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_593
id_morphism_592:
    b apply_end_593
apply_end_593:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_411
    ldr x0, [x29, #-256]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-304]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_10
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_11
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_12
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_13
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_598
    tst x9, #1
    b.eq do_concat_597
    tst x0, #1
    b.ne do_compose_595
do_apply_596:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_599
do_compose_595:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_599
do_concat_597:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_599
id_morphism_598:
    b apply_end_599
apply_end_599:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-384]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_603
    tst x9, #1
    b.eq do_concat_602
    tst x0, #1
    b.ne do_compose_600
do_apply_601:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_604
do_compose_600:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_604
do_concat_602:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_604
id_morphism_603:
    b apply_end_604
apply_end_604:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_608
    tst x9, #1
    b.eq do_concat_607
    tst x0, #1
    b.ne do_compose_605
do_apply_606:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_609
do_compose_605:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_609
do_concat_607:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_609
id_morphism_608:
    b apply_end_609
apply_end_609:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_613
    tst x9, #1
    b.eq do_concat_612
    tst x0, #1
    b.ne do_compose_610
do_apply_611:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_614
do_compose_610:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_614
do_concat_612:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_614
id_morphism_613:
    b apply_end_614
apply_end_614:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_14
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_15
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_16
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_618
    tst x9, #1
    b.eq do_concat_617
    tst x0, #1
    b.ne do_compose_615
do_apply_616:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_619
do_compose_615:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_619
do_concat_617:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_619
id_morphism_618:
    b apply_end_619
apply_end_619:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-352]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_623
    tst x9, #1
    b.eq do_concat_622
    tst x0, #1
    b.ne do_compose_620
do_apply_621:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_624
do_compose_620:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_624
do_concat_622:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_624
id_morphism_623:
    b apply_end_624
apply_end_624:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_628
    tst x9, #1
    b.eq do_concat_627
    tst x0, #1
    b.ne do_compose_625
do_apply_626:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_629
do_compose_625:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_629
do_concat_627:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_629
id_morphism_628:
    b apply_end_629
apply_end_629:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_633
    tst x9, #1
    b.eq do_concat_632
    tst x0, #1
    b.ne do_compose_630
do_apply_631:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_634
do_compose_630:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_634
do_concat_632:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_634
id_morphism_633:
    b apply_end_634
apply_end_634:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_13
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_638
    tst x9, #1
    b.eq do_concat_637
    tst x0, #1
    b.ne do_compose_635
do_apply_636:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_639
do_compose_635:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_639
do_concat_637:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_639
id_morphism_638:
    b apply_end_639
apply_end_639:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-352]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_643
    tst x9, #1
    b.eq do_concat_642
    tst x0, #1
    b.ne do_compose_640
do_apply_641:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_644
do_compose_640:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_644
do_concat_642:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_644
id_morphism_643:
    b apply_end_644
apply_end_644:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_648
    tst x9, #1
    b.eq do_concat_647
    tst x0, #1
    b.ne do_compose_645
do_apply_646:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_649
do_compose_645:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_649
do_concat_647:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_649
id_morphism_648:
    b apply_end_649
apply_end_649:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_653
    tst x9, #1
    b.eq do_concat_652
    tst x0, #1
    b.ne do_compose_650
do_apply_651:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_654
do_compose_650:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_654
do_concat_652:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_654
id_morphism_653:
    b apply_end_654
apply_end_654:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_18
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_19
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_20
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_21
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_22
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_658
    tst x9, #1
    b.eq do_concat_657
    tst x0, #1
    b.ne do_compose_655
do_apply_656:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_659
do_compose_655:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_659
do_concat_657:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_659
id_morphism_658:
    b apply_end_659
apply_end_659:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-384]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_663
    tst x9, #1
    b.eq do_concat_662
    tst x0, #1
    b.ne do_compose_660
do_apply_661:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_664
do_compose_660:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_664
do_concat_662:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_664
id_morphism_663:
    b apply_end_664
apply_end_664:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_668
    tst x9, #1
    b.eq do_concat_667
    tst x0, #1
    b.ne do_compose_665
do_apply_666:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_669
do_compose_665:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_669
do_concat_667:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_669
id_morphism_668:
    b apply_end_669
apply_end_669:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_673
    tst x9, #1
    b.eq do_concat_672
    tst x0, #1
    b.ne do_compose_670
do_apply_671:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_674
do_compose_670:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_674
do_concat_672:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_674
id_morphism_673:
    b apply_end_674
apply_end_674:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-352]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_678
    tst x9, #1
    b.eq do_concat_677
    tst x0, #1
    b.ne do_compose_675
do_apply_676:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_679
do_compose_675:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_679
do_concat_677:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_679
id_morphism_678:
    b apply_end_679
apply_end_679:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_683
    tst x9, #1
    b.eq do_concat_682
    tst x0, #1
    b.ne do_compose_680
do_apply_681:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_684
do_compose_680:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_684
do_concat_682:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_684
id_morphism_683:
    b apply_end_684
apply_end_684:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_24
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_25
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_26
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, str_6
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_594
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-384]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_688
    tst x9, #1
    b.eq do_concat_687
    tst x0, #1
    b.ne do_compose_685
do_apply_686:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_689
do_compose_685:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_689
do_concat_687:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_689
id_morphism_688:
    b apply_end_689
apply_end_689:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_693
    tst x9, #1
    b.eq do_concat_692
    tst x0, #1
    b.ne do_compose_690
do_apply_691:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_694
do_compose_690:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_694
do_concat_692:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_694
id_morphism_693:
    b apply_end_694
apply_end_694:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_594:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_698
    tst x9, #1
    b.eq do_concat_697
    tst x0, #1
    b.ne do_compose_695
do_apply_696:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_699
do_compose_695:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_699
do_concat_697:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_699
id_morphism_698:
    b apply_end_699
apply_end_699:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_703
    tst x9, #1
    b.eq do_concat_702
    tst x0, #1
    b.ne do_compose_700
do_apply_701:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_704
do_compose_700:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_704
do_concat_702:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_704
id_morphism_703:
    b apply_end_704
apply_end_704:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_708
    tst x9, #1
    b.eq do_concat_707
    tst x0, #1
    b.ne do_compose_705
do_apply_706:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_709
do_compose_705:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_709
do_concat_707:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_709
id_morphism_708:
    b apply_end_709
apply_end_709:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_713
    tst x9, #1
    b.eq do_concat_712
    tst x0, #1
    b.ne do_compose_710
do_apply_711:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_714
do_compose_710:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_714
do_concat_712:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_714
id_morphism_713:
    b apply_end_714
apply_end_714:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-368]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_411:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_409_410:
    // Closure for func_409
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_409
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_407_408:
    // Closure for func_407
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_407
    ldr x0, [sp], #16
    bl _cons
    b cond_end_401
cond_false_400:
    adr x0, sign_id
cond_end_401:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_spread_node
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_720
    tst x9, #1
    b.eq do_concat_719
    tst x0, #1
    b.ne do_compose_717
do_apply_718:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_721
do_compose_717:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_721
do_concat_719:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_721
id_morphism_720:
    b apply_end_721
apply_end_721:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_715
    b after_func_722_723
func_722:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_731
    tst x9, #1
    b.eq do_concat_730
    tst x0, #1
    b.ne do_compose_728
do_apply_729:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_732
do_compose_728:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_732
do_concat_730:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_732
id_morphism_731:
    b apply_end_732
apply_end_732:
    str x0, [sp, #-16]!
    adr x0, ast_postfix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_726
    adr x0, sign_id
    b cmp_end_727
cmp_true_726:
cmp_end_727:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_724
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_736
    tst x9, #1
    b.eq do_concat_735
    tst x0, #1
    b.ne do_compose_733
do_apply_734:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_737
do_compose_733:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_737
do_concat_735:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_737
id_morphism_736:
    b apply_end_737
apply_end_737:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_741
    tst x9, #1
    b.eq do_concat_740
    tst x0, #1
    b.ne do_compose_738
do_apply_739:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_742
do_compose_738:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_742
do_concat_740:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_742
id_morphism_741:
    b apply_end_742
apply_end_742:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_746
    tst x9, #1
    b.eq do_concat_745
    tst x0, #1
    b.ne do_compose_743
do_apply_744:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_747
do_compose_743:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_747
do_concat_745:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_747
id_morphism_746:
    b apply_end_747
apply_end_747:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_751
    tst x9, #1
    b.eq do_concat_750
    tst x0, #1
    b.ne do_compose_748
do_apply_749:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_752
do_compose_748:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_752
do_concat_750:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_752
id_morphism_751:
    b apply_end_752
apply_end_752:
    str x0, [sp, #-16]!
    mov x0, #126
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_756
    tst x9, #1
    b.eq do_concat_755
    tst x0, #1
    b.ne do_compose_753
do_apply_754:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_757
do_compose_753:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_757
do_concat_755:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_757
id_morphism_756:
    b apply_end_757
apply_end_757:
    b and_end_725
and_fail_724:
    adr x0, sign_id
and_end_725:
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
    b cond_end_716
cond_false_715:
    adr x0, sign_id
cond_end_716:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, push_var
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_763
    tst x9, #1
    b.eq do_concat_762
    tst x0, #1
    b.ne do_compose_760
do_apply_761:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_764
do_compose_760:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_764
do_concat_762:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_764
id_morphism_763:
    b apply_end_764
apply_end_764:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_758
    b after_func_765_766
func_765:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_767_768
func_767:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_offset_impl_769
offset_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_774
    tst x9, #1
    b.eq do_concat_773
    tst x0, #1
    b.ne do_compose_771
do_apply_772:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_775
do_compose_771:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_775
do_concat_773:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_775
id_morphism_774:
    b apply_end_775
apply_end_775:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_770
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_779
    tst x9, #1
    b.eq do_concat_778
    tst x0, #1
    b.ne do_compose_776
do_apply_777:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_780
do_compose_776:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_780
do_concat_778:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_780
id_morphism_779:
    b apply_end_780
apply_end_780:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_770
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, offset
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_784
    tst x9, #1
    b.eq do_concat_783
    tst x0, #1
    b.ne do_compose_781
do_apply_782:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_785
do_compose_781:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_785
do_concat_783:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_785
id_morphism_784:
    b apply_end_785
apply_end_785:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_770
    adr x0, offset
blk_end_770:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_789
    tst x9, #1
    b.eq do_concat_788
    tst x0, #1
    b.ne do_compose_786
do_apply_787:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_790
do_compose_786:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_790
do_concat_788:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_790
id_morphism_789:
    b apply_end_790
apply_end_790:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_offset_impl_769:
    // Closure for offset_impl
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
    adr x1, offset_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_767_768:
    // Closure for func_767
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_767
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_765_766:
    // Closure for func_765
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_765
    ldr x0, [sp], #16
    bl _cons
    b cond_end_759
cond_false_758:
    adr x0, sign_id
cond_end_759:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, add_string
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_796
    tst x9, #1
    b.eq do_concat_795
    tst x0, #1
    b.ne do_compose_793
do_apply_794:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_797
do_compose_793:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_797
do_concat_795:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_797
id_morphism_796:
    b apply_end_797
apply_end_797:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_791
    b after_func_798_799
func_798:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_800_801
func_800:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_802_803
func_802:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_804_805
func_804:
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
    b.eq or_right_807
    b or_end_808
or_right_807:
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_812
    tst x9, #1
    b.eq do_concat_811
    tst x0, #1
    b.ne do_compose_809
do_apply_810:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_813
do_compose_809:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_813
do_concat_811:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_813
id_morphism_812:
    b apply_end_813
apply_end_813:
or_end_808:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_806
    b after_func_814_815
func_814:
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
    b.eq or_right_817
    b or_end_818
or_right_817:
    adr x0, make_label
    str x0, [sp, #-16]!
    adr x0, str_27
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_822
    tst x9, #1
    b.eq do_concat_821
    tst x0, #1
    b.ne do_compose_819
do_apply_820:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_823
do_compose_819:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_823
do_concat_821:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_823
id_morphism_822:
    b apply_end_823
apply_end_823:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_827
    tst x9, #1
    b.eq do_concat_826
    tst x0, #1
    b.ne do_compose_824
do_apply_825:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_828
do_compose_824:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_828
do_concat_826:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_828
id_morphism_827:
    b apply_end_828
apply_end_828:
or_end_818:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_816
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_829
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_833
    tst x9, #1
    b.eq do_concat_832
    tst x0, #1
    b.ne do_compose_830
do_apply_831:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_834
do_compose_830:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_834
do_concat_832:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_834
id_morphism_833:
    b apply_end_834
apply_end_834:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_829
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_838
    tst x9, #1
    b.eq do_concat_837
    tst x0, #1
    b.ne do_compose_835
do_apply_836:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_839
do_compose_835:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_839
do_concat_837:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_839
id_morphism_838:
    b apply_end_839
apply_end_839:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_829
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_843
    tst x9, #1
    b.eq do_concat_842
    tst x0, #1
    b.ne do_compose_840
do_apply_841:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_844
do_compose_840:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_844
do_concat_842:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_844
id_morphism_843:
    b apply_end_844
apply_end_844:
blk_end_829:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_848
    tst x9, #1
    b.eq do_concat_847
    tst x0, #1
    b.ne do_compose_845
do_apply_846:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_849
do_compose_845:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_849
do_concat_847:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_849
id_morphism_848:
    b apply_end_849
apply_end_849:
    ldr x1, [sp], #16
    bl _cons
blk_end_816:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_814_815:
    // Closure for func_814
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
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_814
    ldr x0, [sp], #16
    bl _cons
blk_end_806:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_804_805:
    // Closure for func_804
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
    adr x1, func_804
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_802_803:
    // Closure for func_802
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
    adr x1, func_802
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_800_801:
    // Closure for func_800
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_800
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_798_799:
    // Closure for func_798
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_798
    ldr x0, [sp], #16
    bl _cons
    b cond_end_792
cond_false_791:
    adr x0, sign_id
cond_end_792:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strlen
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_855
    tst x9, #1
    b.eq do_concat_854
    tst x0, #1
    b.ne do_compose_852
do_apply_853:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_856
do_compose_852:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_856
do_concat_854:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_856
id_morphism_855:
    b apply_end_856
apply_end_856:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_850
    b after_func_857_858
func_857:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_860_861
func_860:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_860_861:
    // Closure for func_860
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_860
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_865
    adr x0, sign_id
    b cmp_end_866
cmp_true_865:
cmp_end_866:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_863
    mov x0, #0
    b cond_end_864
cond_false_863:
    adr x0, sign_id
cond_end_864:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_862
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, strlen
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_870
    tst x9, #1
    b.eq do_concat_869
    tst x0, #1
    b.ne do_compose_867
do_apply_868:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_871
do_compose_867:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_871
do_concat_869:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_871
id_morphism_870:
    b apply_end_871
apply_end_871:
blk_end_862:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_875
    tst x9, #1
    b.eq do_concat_874
    tst x0, #1
    b.ne do_compose_872
do_apply_873:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_876
do_compose_872:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_876
do_concat_874:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_876
id_morphism_875:
    b apply_end_876
apply_end_876:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_859
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_859:
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
    b cond_end_851
cond_false_850:
    adr x0, sign_id
cond_end_851:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strcpy
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_882
    tst x9, #1
    b.eq do_concat_881
    tst x0, #1
    b.ne do_compose_879
do_apply_880:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_883
do_compose_879:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_883
do_concat_881:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_883
id_morphism_882:
    b apply_end_883
apply_end_883:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_877
    b after_func_884_885
func_884:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_886_887
func_886:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_889_890
func_889:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_894
    adr x0, sign_id
    b cmp_end_895
cmp_true_894:
cmp_end_895:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_892
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_896
    ldr x0, [x29, #-48]
blk_end_896:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_900
    tst x9, #1
    b.eq do_concat_899
    tst x0, #1
    b.ne do_compose_897
do_apply_898:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_901
do_compose_897:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_901
do_concat_899:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_901
id_morphism_900:
    b apply_end_901
apply_end_901:
    b cond_end_893
cond_false_892:
    adr x0, sign_id
cond_end_893:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_891
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_891
    adr x0, strcpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_905
    tst x9, #1
    b.eq do_concat_904
    tst x0, #1
    b.ne do_compose_902
do_apply_903:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_906
do_compose_902:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_906
do_concat_904:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_906
id_morphism_905:
    b apply_end_906
apply_end_906:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_910
    tst x9, #1
    b.eq do_concat_909
    tst x0, #1
    b.ne do_compose_907
do_apply_908:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_911
do_compose_907:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_911
do_concat_909:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_911
id_morphism_910:
    b apply_end_911
apply_end_911:
blk_end_891:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_915
    tst x9, #1
    b.eq do_concat_914
    tst x0, #1
    b.ne do_compose_912
do_apply_913:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_916
do_compose_912:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_916
do_concat_914:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_916
id_morphism_915:
    b apply_end_916
apply_end_916:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_888
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_888:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_886_887:
    // Closure for func_886
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_886
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_878
cond_false_877:
    adr x0, sign_id
cond_end_878:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strcat
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_922
    tst x9, #1
    b.eq do_concat_921
    tst x0, #1
    b.ne do_compose_919
do_apply_920:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_923
do_compose_919:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_923
do_concat_921:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_923
id_morphism_922:
    b apply_end_923
apply_end_923:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_917
    b after_func_924_925
func_924:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_926_927
func_926:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_929_930
func_929:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_929_930:
    // Closure for func_929
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_929
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, strcpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, len
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_935
    tst x9, #1
    b.eq do_concat_934
    tst x0, #1
    b.ne do_compose_932
do_apply_933:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_936
do_compose_932:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_936
do_concat_934:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_936
id_morphism_935:
    b apply_end_936
apply_end_936:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_940
    tst x9, #1
    b.eq do_concat_939
    tst x0, #1
    b.ne do_compose_937
do_apply_938:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_941
do_compose_937:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_941
do_concat_939:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_941
id_morphism_940:
    b apply_end_941
apply_end_941:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_931
    ldr x0, [x29, #-48]
blk_end_931:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_945
    tst x9, #1
    b.eq do_concat_944
    tst x0, #1
    b.ne do_compose_942
do_apply_943:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_946
do_compose_942:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_946
do_concat_944:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_946
id_morphism_945:
    b apply_end_946
apply_end_946:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_928
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_950
    tst x9, #1
    b.eq do_concat_949
    tst x0, #1
    b.ne do_compose_947
do_apply_948:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_951
do_compose_947:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_951
do_concat_949:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_951
id_morphism_950:
    b apply_end_951
apply_end_951:
blk_end_928:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_926_927:
    // Closure for func_926
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_926
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_924_925:
    // Closure for func_924
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_924
    ldr x0, [sp], #16
    bl _cons
    b cond_end_918
cond_false_917:
    adr x0, sign_id
cond_end_918:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_957
    tst x9, #1
    b.eq do_concat_956
    tst x0, #1
    b.ne do_compose_954
do_apply_955:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_958
do_compose_954:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_958
do_concat_956:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_958
id_morphism_957:
    b apply_end_958
apply_end_958:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_952
    b after_func_959_960
func_959:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_961_962
func_961:
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
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_964_965:
    // Closure for func_964
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_964
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_967_968
func_967:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_967_968:
    // Closure for func_967
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_967
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_970_971
func_970:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_970_971:
    // Closure for func_970
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_970
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, strcpy
    str x0, [sp, #-16]!
    adr x0, new_s
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_976
    tst x9, #1
    b.eq do_concat_975
    tst x0, #1
    b.ne do_compose_973
do_apply_974:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_977
do_compose_973:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_977
do_concat_975:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_977
id_morphism_976:
    b apply_end_977
apply_end_977:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_981
    tst x9, #1
    b.eq do_concat_980
    tst x0, #1
    b.ne do_compose_978
do_apply_979:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_982
do_compose_978:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_982
do_concat_980:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_982
id_morphism_981:
    b apply_end_982
apply_end_982:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_972
    adr x0, strcpy
    str x0, [sp, #-16]!
    adr x0, new_s
    str x0, [sp, #-16]!
    adr x0, len1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_986
    tst x9, #1
    b.eq do_concat_985
    tst x0, #1
    b.ne do_compose_983
do_apply_984:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_987
do_compose_983:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_987
do_concat_985:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_987
id_morphism_986:
    b apply_end_987
apply_end_987:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_991
    tst x9, #1
    b.eq do_concat_990
    tst x0, #1
    b.ne do_compose_988
do_apply_989:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_992
do_compose_988:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_992
do_concat_990:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_992
id_morphism_991:
    b apply_end_992
apply_end_992:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_972
    adr x0, new_s
blk_end_972:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_996
    tst x9, #1
    b.eq do_concat_995
    tst x0, #1
    b.ne do_compose_993
do_apply_994:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_997
do_compose_993:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_997
do_concat_995:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_997
id_morphism_996:
    b apply_end_997
apply_end_997:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_969
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1001
    tst x9, #1
    b.eq do_concat_1000
    tst x0, #1
    b.ne do_compose_998
do_apply_999:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1002
do_compose_998:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1002
do_concat_1000:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1002
id_morphism_1001:
    b apply_end_1002
apply_end_1002:
blk_end_969:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1006
    tst x9, #1
    b.eq do_concat_1005
    tst x0, #1
    b.ne do_compose_1003
do_apply_1004:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1007
do_compose_1003:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1007
do_concat_1005:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1007
id_morphism_1006:
    b apply_end_1007
apply_end_1007:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_966
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1011
    tst x9, #1
    b.eq do_concat_1010
    tst x0, #1
    b.ne do_compose_1008
do_apply_1009:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1012
do_compose_1008:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1012
do_concat_1010:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1012
id_morphism_1011:
    b apply_end_1012
apply_end_1012:
blk_end_966:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1016
    tst x9, #1
    b.eq do_concat_1015
    tst x0, #1
    b.ne do_compose_1013
do_apply_1014:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1017
do_compose_1013:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1017
do_concat_1015:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1017
id_morphism_1016:
    b apply_end_1017
apply_end_1017:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_963
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1021
    tst x9, #1
    b.eq do_concat_1020
    tst x0, #1
    b.ne do_compose_1018
do_apply_1019:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1022
do_compose_1018:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1022
do_concat_1020:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1022
id_morphism_1021:
    b apply_end_1022
apply_end_1022:
blk_end_963:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_961_962:
    // Closure for func_961
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_961
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_959_960:
    // Closure for func_959
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_959
    ldr x0, [sp], #16
    bl _cons
    b cond_end_953
cond_false_952:
    adr x0, sign_id
cond_end_953:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat_list
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1028
    tst x9, #1
    b.eq do_concat_1027
    tst x0, #1
    b.ne do_compose_1025
do_apply_1026:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1029
do_compose_1025:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1029
do_concat_1027:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1029
id_morphism_1028:
    b apply_end_1029
apply_end_1029:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1023
    b after_func_1030_1031
func_1030:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1035
    adr x0, sign_id
    b cmp_end_1036
cmp_true_1035:
cmp_end_1036:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1033
    adr x0, str_28
    b cond_end_1034
cond_false_1033:
    adr x0, sign_id
cond_end_1034:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1032
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1040
    tst x9, #1
    b.eq do_concat_1039
    tst x0, #1
    b.ne do_compose_1037
do_apply_1038:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1041
do_compose_1037:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1041
do_concat_1039:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1041
id_morphism_1040:
    b apply_end_1041
apply_end_1041:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1045
    tst x9, #1
    b.eq do_concat_1044
    tst x0, #1
    b.ne do_compose_1042
do_apply_1043:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1046
do_compose_1042:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1046
do_concat_1044:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1046
id_morphism_1045:
    b apply_end_1046
apply_end_1046:
    str x0, [sp, #-16]!
    adr x0, concat_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1050
    tst x9, #1
    b.eq do_concat_1049
    tst x0, #1
    b.ne do_compose_1047
do_apply_1048:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1051
do_compose_1047:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1051
do_concat_1049:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1051
id_morphism_1050:
    b apply_end_1051
apply_end_1051:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1055
    tst x9, #1
    b.eq do_concat_1054
    tst x0, #1
    b.ne do_compose_1052
do_apply_1053:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1056
do_compose_1052:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1056
do_concat_1054:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1056
id_morphism_1055:
    b apply_end_1056
apply_end_1056:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1060
    tst x9, #1
    b.eq do_concat_1059
    tst x0, #1
    b.ne do_compose_1057
do_apply_1058:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1061
do_compose_1057:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1061
do_concat_1059:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1061
id_morphism_1060:
    b apply_end_1061
apply_end_1061:
blk_end_1032:
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
    b cond_end_1024
cond_false_1023:
    adr x0, sign_id
cond_end_1024:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, int_to_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1067
    tst x9, #1
    b.eq do_concat_1066
    tst x0, #1
    b.ne do_compose_1064
do_apply_1065:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1068
do_compose_1064:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1068
do_concat_1066:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1068
id_morphism_1067:
    b apply_end_1068
apply_end_1068:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1062
    b after_func_1069_1070
func_1069:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1074
    adr x0, sign_id
    b cmp_end_1075
cmp_true_1074:
cmp_end_1075:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1072
    mov x0, #48
    b cond_end_1073
cond_false_1072:
    adr x0, sign_id
cond_end_1073:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1071
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1078
    adr x0, sign_id
    b cmp_end_1079
cmp_true_1078:
cmp_end_1079:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1076
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1083
    tst x9, #1
    b.eq do_concat_1082
    tst x0, #1
    b.ne do_compose_1080
do_apply_1081:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1084
do_compose_1080:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1084
do_concat_1082:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1084
id_morphism_1083:
    b apply_end_1084
apply_end_1084:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1088
    tst x9, #1
    b.eq do_concat_1087
    tst x0, #1
    b.ne do_compose_1085
do_apply_1086:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1089
do_compose_1085:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1089
do_concat_1087:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1089
id_morphism_1088:
    b apply_end_1089
apply_end_1089:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1093
    tst x9, #1
    b.eq do_concat_1092
    tst x0, #1
    b.ne do_compose_1090
do_apply_1091:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1094
do_compose_1090:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1094
do_concat_1092:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1094
id_morphism_1093:
    b apply_end_1094
apply_end_1094:
    b cond_end_1077
cond_false_1076:
    adr x0, sign_id
cond_end_1077:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1071
    adr x0, _int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1098
    tst x9, #1
    b.eq do_concat_1097
    tst x0, #1
    b.ne do_compose_1095
do_apply_1096:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1099
do_compose_1095:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1099
do_concat_1097:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1099
id_morphism_1098:
    b apply_end_1099
apply_end_1099:
blk_end_1071:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1069_1070:
    // Closure for func_1069
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1069
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1063
cond_false_1062:
    adr x0, sign_id
cond_end_1063:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _int_to_str_rec
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1105
    tst x9, #1
    b.eq do_concat_1104
    tst x0, #1
    b.ne do_compose_1102
do_apply_1103:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1106
do_compose_1102:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1106
do_concat_1104:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1106
id_morphism_1105:
    b apply_end_1106
apply_end_1106:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1100
    b after_func_1107_1108
func_1107:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1112
    adr x0, sign_id
    b cmp_end_1113
cmp_true_1112:
cmp_end_1113:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1110
    adr x0, str_28
    b cond_end_1111
cond_false_1110:
    adr x0, sign_id
cond_end_1111:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1109
    b after_func_1114_1115
func_1114:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1114_1115:
    // Closure for func_1114
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1114
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1119
    tst x9, #1
    b.eq do_concat_1118
    tst x0, #1
    b.ne do_compose_1116
do_apply_1117:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1120
do_compose_1116:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1120
do_concat_1118:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1120
id_morphism_1119:
    b apply_end_1120
apply_end_1120:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1124
    tst x9, #1
    b.eq do_concat_1123
    tst x0, #1
    b.ne do_compose_1121
do_apply_1122:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1125
do_compose_1121:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1125
do_concat_1123:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1125
id_morphism_1124:
    b apply_end_1125
apply_end_1125:
    str x0, [sp, #-16]!
    adr x0, char_to_str
    str x0, [sp, #-16]!
    adr x0, digit
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1129
    tst x9, #1
    b.eq do_concat_1128
    tst x0, #1
    b.ne do_compose_1126
do_apply_1127:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1130
do_compose_1126:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1130
do_concat_1128:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1130
id_morphism_1129:
    b apply_end_1130
apply_end_1130:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1134
    tst x9, #1
    b.eq do_concat_1133
    tst x0, #1
    b.ne do_compose_1131
do_apply_1132:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1135
do_compose_1131:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1135
do_concat_1133:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1135
id_morphism_1134:
    b apply_end_1135
apply_end_1135:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1139
    tst x9, #1
    b.eq do_concat_1138
    tst x0, #1
    b.ne do_compose_1136
do_apply_1137:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1140
do_compose_1136:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1140
do_concat_1138:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1140
id_morphism_1139:
    b apply_end_1140
apply_end_1140:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1109
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
blk_end_1109:
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
    b cond_end_1101
cond_false_1100:
    adr x0, sign_id
cond_end_1101:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, char_to_str
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1146
    tst x9, #1
    b.eq do_concat_1145
    tst x0, #1
    b.ne do_compose_1143
do_apply_1144:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1147
do_compose_1143:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1147
do_concat_1145:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1147
id_morphism_1146:
    b apply_end_1147
apply_end_1147:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1141
    b after_func_1148_1149
func_1148:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1151_1152
func_1151:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1151_1152:
    // Closure for func_1151
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1151
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
    b.ne blk_end_1153
    adr x0, s
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1153
    adr x0, s
blk_end_1153:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1157
    tst x9, #1
    b.eq do_concat_1156
    tst x0, #1
    b.ne do_compose_1154
do_apply_1155:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1158
do_compose_1154:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1158
do_concat_1156:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1158
id_morphism_1157:
    b apply_end_1158
apply_end_1158:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1150
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1162
    tst x9, #1
    b.eq do_concat_1161
    tst x0, #1
    b.ne do_compose_1159
do_apply_1160:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1163
do_compose_1159:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1163
do_concat_1161:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1163
id_morphism_1162:
    b apply_end_1163
apply_end_1163:
blk_end_1150:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1148_1149:
    // Closure for func_1148
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1148
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
    adr x0, emit_num
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1169
    tst x9, #1
    b.eq do_concat_1168
    tst x0, #1
    b.ne do_compose_1166
do_apply_1167:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1170
do_compose_1166:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1170
do_concat_1168:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1170
id_morphism_1169:
    b apply_end_1170
apply_end_1170:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1164
    b after_func_1171_1172
func_1171:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1173_1174
func_1173:
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1178
    tst x9, #1
    b.eq do_concat_1177
    tst x0, #1
    b.ne do_compose_1175
do_apply_1176:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1179
do_compose_1175:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1179
do_concat_1177:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1179
id_morphism_1178:
    b apply_end_1179
apply_end_1179:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1183
    tst x9, #1
    b.eq do_concat_1182
    tst x0, #1
    b.ne do_compose_1180
do_apply_1181:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1184
do_compose_1180:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1184
do_concat_1182:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1184
id_morphism_1183:
    b apply_end_1184
apply_end_1184:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1188
    tst x9, #1
    b.eq do_concat_1187
    tst x0, #1
    b.ne do_compose_1185
do_apply_1186:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1189
do_compose_1185:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1189
do_concat_1187:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1189
id_morphism_1188:
    b apply_end_1189
apply_end_1189:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1173_1174:
    // Closure for func_1173
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1173
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1171_1172:
    // Closure for func_1171
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1171
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1165
cond_false_1164:
    adr x0, sign_id
cond_end_1165:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_label
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1195
    tst x9, #1
    b.eq do_concat_1194
    tst x0, #1
    b.ne do_compose_1192
do_apply_1193:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1196
do_compose_1192:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1196
do_concat_1194:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1196
id_morphism_1195:
    b apply_end_1196
apply_end_1196:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1190
    b after_func_1197_1198
func_1197:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1199_1200
func_1199:
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
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1204
    tst x9, #1
    b.eq do_concat_1203
    tst x0, #1
    b.ne do_compose_1201
do_apply_1202:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1205
do_compose_1201:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1205
do_concat_1203:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1205
id_morphism_1204:
    b apply_end_1205
apply_end_1205:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #95
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1209
    tst x9, #1
    b.eq do_concat_1208
    tst x0, #1
    b.ne do_compose_1206
do_apply_1207:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1210
do_compose_1206:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1210
do_concat_1208:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1210
id_morphism_1209:
    b apply_end_1210
apply_end_1210:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1214
    tst x9, #1
    b.eq do_concat_1213
    tst x0, #1
    b.ne do_compose_1211
do_apply_1212:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1215
do_compose_1211:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1215
do_concat_1213:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1215
id_morphism_1214:
    b apply_end_1215
apply_end_1215:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1219
    tst x9, #1
    b.eq do_concat_1218
    tst x0, #1
    b.ne do_compose_1216
do_apply_1217:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1220
do_compose_1216:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1220
do_concat_1218:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1220
id_morphism_1219:
    b apply_end_1220
apply_end_1220:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1224
    tst x9, #1
    b.eq do_concat_1223
    tst x0, #1
    b.ne do_compose_1221
do_apply_1222:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1225
do_compose_1221:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1225
do_concat_1223:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1225
id_morphism_1224:
    b apply_end_1225
apply_end_1225:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1199_1200:
    // Closure for func_1199
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1199
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1191
cond_false_1190:
    adr x0, sign_id
cond_end_1191:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, new_label
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1231
    tst x9, #1
    b.eq do_concat_1230
    tst x0, #1
    b.ne do_compose_1228
do_apply_1229:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1232
do_compose_1228:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1232
do_concat_1230:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1232
id_morphism_1231:
    b apply_end_1232
apply_end_1232:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1226
    b after_func_1233_1234
func_1233:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1235_1236
func_1235:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1237_1238
func_1237:
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
    b.eq or_right_1240
    b or_end_1241
or_right_1240:
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1245
    tst x9, #1
    b.eq do_concat_1244
    tst x0, #1
    b.ne do_compose_1242
do_apply_1243:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1246
do_compose_1242:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1246
do_concat_1244:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1246
id_morphism_1245:
    b apply_end_1246
apply_end_1246:
or_end_1241:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1239
    b after_func_1247_1248
func_1247:
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
    b.eq or_right_1250
    b or_end_1251
or_right_1250:
    adr x0, make_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1255
    tst x9, #1
    b.eq do_concat_1254
    tst x0, #1
    b.ne do_compose_1252
do_apply_1253:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1256
do_compose_1252:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1256
do_concat_1254:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1256
id_morphism_1255:
    b apply_end_1256
apply_end_1256:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1260
    tst x9, #1
    b.eq do_concat_1259
    tst x0, #1
    b.ne do_compose_1257
do_apply_1258:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1261
do_compose_1257:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1261
do_concat_1259:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1261
id_morphism_1260:
    b apply_end_1261
apply_end_1261:
or_end_1251:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1249
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1262
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1266
    tst x9, #1
    b.eq do_concat_1265
    tst x0, #1
    b.ne do_compose_1263
do_apply_1264:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1267
do_compose_1263:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1267
do_concat_1265:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1267
id_morphism_1266:
    b apply_end_1267
apply_end_1267:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1262
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1271
    tst x9, #1
    b.eq do_concat_1270
    tst x0, #1
    b.ne do_compose_1268
do_apply_1269:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1272
do_compose_1268:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1272
do_concat_1270:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1272
id_morphism_1271:
    b apply_end_1272
apply_end_1272:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1262
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1276
    tst x9, #1
    b.eq do_concat_1275
    tst x0, #1
    b.ne do_compose_1273
do_apply_1274:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1277
do_compose_1273:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1277
do_concat_1275:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1277
id_morphism_1276:
    b apply_end_1277
apply_end_1277:
blk_end_1262:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1281
    tst x9, #1
    b.eq do_concat_1280
    tst x0, #1
    b.ne do_compose_1278
do_apply_1279:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1282
do_compose_1278:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1282
do_concat_1280:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1282
id_morphism_1281:
    b apply_end_1282
apply_end_1282:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_1249:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1247_1248:
    // Closure for func_1247
    adr x0, sign_id
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
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1247
    ldr x0, [sp], #16
    bl _cons
blk_end_1239:
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
    ldr x0, [x29, #-48]
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1235
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1227
cond_false_1226:
    adr x0, sign_id
cond_end_1227:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, format_str_list
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1288
    tst x9, #1
    b.eq do_concat_1287
    tst x0, #1
    b.ne do_compose_1285
do_apply_1286:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1289
do_compose_1285:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1289
do_concat_1287:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1289
id_morphism_1288:
    b apply_end_1289
apply_end_1289:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1283
    b after_func_1290_1291
func_1290:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1292_1293
func_1292:
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
    b.eq cmp_true_1297
    adr x0, sign_id
    b cmp_end_1298
cmp_true_1297:
cmp_end_1298:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1295
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1299
    b or_end_1300
or_right_1299:
    adr x0, str_29
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
or_end_1300:
    b cond_end_1296
cond_false_1295:
    adr x0, sign_id
cond_end_1296:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1294
    b after_func_1301_1302
func_1301:
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
    b.eq or_right_1304
    b or_end_1305
or_right_1304:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1309
    tst x9, #1
    b.eq do_concat_1308
    tst x0, #1
    b.ne do_compose_1306
do_apply_1307:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1310
do_compose_1306:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1310
do_concat_1308:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1310
id_morphism_1309:
    b apply_end_1310
apply_end_1310:
or_end_1305:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1303
    b after_func_1311_1312
func_1311:
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
    b.eq or_right_1314
    b or_end_1315
or_right_1314:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1319
    tst x9, #1
    b.eq do_concat_1318
    tst x0, #1
    b.ne do_compose_1316
do_apply_1317:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1320
do_compose_1316:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1320
do_concat_1318:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1320
id_morphism_1319:
    b apply_end_1320
apply_end_1320:
or_end_1315:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1313
    b after_func_1321_1322
func_1321:
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
    b.eq or_right_1324
    b or_end_1325
or_right_1324:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1329
    tst x9, #1
    b.eq do_concat_1328
    tst x0, #1
    b.ne do_compose_1326
do_apply_1327:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1330
do_compose_1326:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1330
do_concat_1328:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1330
id_morphism_1329:
    b apply_end_1330
apply_end_1330:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1334
    tst x9, #1
    b.eq do_concat_1333
    tst x0, #1
    b.ne do_compose_1331
do_apply_1332:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1335
do_compose_1331:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1335
do_concat_1333:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1335
id_morphism_1334:
    b apply_end_1335
apply_end_1335:
or_end_1325:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1323
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, str_30
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, str_31
    str x0, [sp, #-16]!
    adr x0, format_str_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1339
    tst x9, #1
    b.eq do_concat_1338
    tst x0, #1
    b.ne do_compose_1336
do_apply_1337:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1340
do_compose_1336:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1340
do_concat_1338:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1340
id_morphism_1339:
    b apply_end_1340
apply_end_1340:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1344
    tst x9, #1
    b.eq do_concat_1343
    tst x0, #1
    b.ne do_compose_1341
do_apply_1342:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1345
do_compose_1341:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1345
do_concat_1343:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1345
id_morphism_1344:
    b apply_end_1345
apply_end_1345:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_1323:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1321_1322:
    // Closure for func_1321
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
    adr x1, func_1321
    ldr x0, [sp], #16
    bl _cons
blk_end_1313:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1311_1312:
    // Closure for func_1311
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
    adr x1, func_1311
    ldr x0, [sp], #16
    bl _cons
blk_end_1303:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1301_1302:
    // Closure for func_1301
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1301
    ldr x0, [sp], #16
    bl _cons
blk_end_1294:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1292_1293:
    // Closure for func_1292
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1292
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1290_1291:
    // Closure for func_1290
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1290
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1284
cond_false_1283:
    adr x0, sign_id
cond_end_1284:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_program
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1351
    tst x9, #1
    b.eq do_concat_1350
    tst x0, #1
    b.ne do_compose_1348
do_apply_1349:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1352
do_compose_1348:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1352
do_concat_1350:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1352
id_morphism_1351:
    b apply_end_1352
apply_end_1352:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1346
    b after_func_1353_1354
func_1353:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1355_1356
func_1355:
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
    b.eq or_right_1358
    b or_end_1359
or_right_1358:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1363
    tst x9, #1
    b.eq do_concat_1362
    tst x0, #1
    b.ne do_compose_1360
do_apply_1361:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1364
do_compose_1360:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1364
do_concat_1362:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1364
id_morphism_1363:
    b apply_end_1364
apply_end_1364:
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1368
    tst x9, #1
    b.eq do_concat_1367
    tst x0, #1
    b.ne do_compose_1365
do_apply_1366:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1369
do_compose_1365:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1369
do_concat_1367:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1369
id_morphism_1368:
    b apply_end_1369
apply_end_1369:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1373
    tst x9, #1
    b.eq do_concat_1372
    tst x0, #1
    b.ne do_compose_1370
do_apply_1371:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1374
do_compose_1370:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1374
do_concat_1372:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1374
id_morphism_1373:
    b apply_end_1374
apply_end_1374:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1378
    tst x9, #1
    b.eq do_concat_1377
    tst x0, #1
    b.ne do_compose_1375
do_apply_1376:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1379
do_compose_1375:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1379
do_concat_1377:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1379
id_morphism_1378:
    b apply_end_1379
apply_end_1379:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1383
    tst x9, #1
    b.eq do_concat_1382
    tst x0, #1
    b.ne do_compose_1380
do_apply_1381:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1384
do_compose_1380:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1384
do_concat_1382:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1384
id_morphism_1383:
    b apply_end_1384
apply_end_1384:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1388
    tst x9, #1
    b.eq do_concat_1387
    tst x0, #1
    b.ne do_compose_1385
do_apply_1386:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1389
do_compose_1385:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1389
do_concat_1387:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1389
id_morphism_1388:
    b apply_end_1389
apply_end_1389:
or_end_1359:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1357
    b after_func_1390_1391
func_1390:
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
    b.eq or_right_1393
    b or_end_1394
or_right_1393:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1398
    tst x9, #1
    b.eq do_concat_1397
    tst x0, #1
    b.ne do_compose_1395
do_apply_1396:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1399
do_compose_1395:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1399
do_concat_1397:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1399
id_morphism_1398:
    b apply_end_1399
apply_end_1399:
or_end_1394:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1392
    b after_func_1400_1401
func_1400:
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
    b.eq or_right_1403
    b or_end_1404
or_right_1403:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1408
    tst x9, #1
    b.eq do_concat_1407
    tst x0, #1
    b.ne do_compose_1405
do_apply_1406:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1409
do_compose_1405:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1409
do_concat_1407:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1409
id_morphism_1408:
    b apply_end_1409
apply_end_1409:
or_end_1404:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1402
    b after_func_1410_1411
func_1410:
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
    b.eq or_right_1413
    b or_end_1414
or_right_1413:
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1418
    tst x9, #1
    b.eq do_concat_1417
    tst x0, #1
    b.ne do_compose_1415
do_apply_1416:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1419
do_compose_1415:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1419
do_concat_1417:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1419
id_morphism_1418:
    b apply_end_1419
apply_end_1419:
or_end_1414:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1412
    adr x0, concat_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, str_32
    str x0, [sp, #-16]!
    adr x0, format_str_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1423
    tst x9, #1
    b.eq do_concat_1422
    tst x0, #1
    b.ne do_compose_1420
do_apply_1421:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1424
do_compose_1420:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1424
do_concat_1422:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1424
id_morphism_1423:
    b apply_end_1424
apply_end_1424:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _concat
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1428
    tst x9, #1
    b.eq do_concat_1427
    tst x0, #1
    b.ne do_compose_1425
do_apply_1426:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1429
do_compose_1425:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1429
do_concat_1427:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1429
id_morphism_1428:
    b apply_end_1429
apply_end_1429:
blk_end_1412:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1410_1411:
    // Closure for func_1410
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
    adr x1, func_1410
    ldr x0, [sp], #16
    bl _cons
blk_end_1402:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1400_1401:
    // Closure for func_1400
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
    adr x1, func_1400
    ldr x0, [sp], #16
    bl _cons
blk_end_1392:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1390_1391:
    // Closure for func_1390
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1390
    ldr x0, [sp], #16
    bl _cons
blk_end_1357:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1355_1356:
    // Closure for func_1355
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1355
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1353_1354:
    // Closure for func_1353
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1353
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1347
cond_false_1346:
    adr x0, sign_id
cond_end_1347:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_node
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1435
    tst x9, #1
    b.eq do_concat_1434
    tst x0, #1
    b.ne do_compose_1432
do_apply_1433:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1436
do_compose_1432:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1436
do_concat_1434:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1436
id_morphism_1435:
    b apply_end_1436
apply_end_1436:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1430
    b after_func_1437_1438
func_1437:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1439_1440
func_1439:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1442_1443
func_1442:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1442_1443:
    // Closure for func_1442
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1442
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
    b.eq cmp_true_1447
    adr x0, sign_id
    b cmp_end_1448
cmp_true_1447:
cmp_end_1448:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1445
    adr x0, compile_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1452
    tst x9, #1
    b.eq do_concat_1451
    tst x0, #1
    b.ne do_compose_1449
do_apply_1450:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1453
do_compose_1449:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1453
do_concat_1451:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1453
id_morphism_1452:
    b apply_end_1453
apply_end_1453:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1457
    tst x9, #1
    b.eq do_concat_1456
    tst x0, #1
    b.ne do_compose_1454
do_apply_1455:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1458
do_compose_1454:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1458
do_concat_1456:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1458
id_morphism_1457:
    b apply_end_1458
apply_end_1458:
    b cond_end_1446
cond_false_1445:
    adr x0, sign_id
cond_end_1446:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1461
    adr x0, sign_id
    b cmp_end_1462
cmp_true_1461:
cmp_end_1462:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1459
    adr x0, compile_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1466
    tst x9, #1
    b.eq do_concat_1465
    tst x0, #1
    b.ne do_compose_1463
do_apply_1464:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1467
do_compose_1463:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1467
do_concat_1465:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1467
id_morphism_1466:
    b apply_end_1467
apply_end_1467:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1471
    tst x9, #1
    b.eq do_concat_1470
    tst x0, #1
    b.ne do_compose_1468
do_apply_1469:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1472
do_compose_1468:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1472
do_concat_1470:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1472
id_morphism_1471:
    b apply_end_1472
apply_end_1472:
    b cond_end_1460
cond_false_1459:
    adr x0, sign_id
cond_end_1460:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_prefix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1475
    adr x0, sign_id
    b cmp_end_1476
cmp_true_1475:
cmp_end_1476:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1473
    adr x0, compile_prefix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1480
    tst x9, #1
    b.eq do_concat_1479
    tst x0, #1
    b.ne do_compose_1477
do_apply_1478:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1481
do_compose_1477:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1481
do_concat_1479:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1481
id_morphism_1480:
    b apply_end_1481
apply_end_1481:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1485
    tst x9, #1
    b.eq do_concat_1484
    tst x0, #1
    b.ne do_compose_1482
do_apply_1483:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1486
do_compose_1482:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1486
do_concat_1484:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1486
id_morphism_1485:
    b apply_end_1486
apply_end_1486:
    b cond_end_1474
cond_false_1473:
    adr x0, sign_id
cond_end_1474:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_postfix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1489
    adr x0, sign_id
    b cmp_end_1490
cmp_true_1489:
cmp_end_1490:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1487
    adr x0, compile_postfix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1494
    tst x9, #1
    b.eq do_concat_1493
    tst x0, #1
    b.ne do_compose_1491
do_apply_1492:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1495
do_compose_1491:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1495
do_concat_1493:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1495
id_morphism_1494:
    b apply_end_1495
apply_end_1495:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1499
    tst x9, #1
    b.eq do_concat_1498
    tst x0, #1
    b.ne do_compose_1496
do_apply_1497:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1500
do_compose_1496:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1500
do_concat_1498:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1500
id_morphism_1499:
    b apply_end_1500
apply_end_1500:
    b cond_end_1488
cond_false_1487:
    adr x0, sign_id
cond_end_1488:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1503
    adr x0, sign_id
    b cmp_end_1504
cmp_true_1503:
cmp_end_1504:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1501
    adr x0, compile_block
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1508
    tst x9, #1
    b.eq do_concat_1507
    tst x0, #1
    b.ne do_compose_1505
do_apply_1506:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1509
do_compose_1505:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1509
do_concat_1507:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1509
id_morphism_1508:
    b apply_end_1509
apply_end_1509:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1513
    tst x9, #1
    b.eq do_concat_1512
    tst x0, #1
    b.ne do_compose_1510
do_apply_1511:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1514
do_compose_1510:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1514
do_concat_1512:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1514
id_morphism_1513:
    b apply_end_1514
apply_end_1514:
    b cond_end_1502
cond_false_1501:
    adr x0, sign_id
cond_end_1502:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1517
    adr x0, sign_id
    b cmp_end_1518
cmp_true_1517:
cmp_end_1518:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1515
    adr x0, compile_unit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1522
    tst x9, #1
    b.eq do_concat_1521
    tst x0, #1
    b.ne do_compose_1519
do_apply_1520:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1523
do_compose_1519:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1523
do_concat_1521:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1523
id_morphism_1522:
    b apply_end_1523
apply_end_1523:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1527
    tst x9, #1
    b.eq do_concat_1526
    tst x0, #1
    b.ne do_compose_1524
do_apply_1525:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1528
do_compose_1524:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1528
do_concat_1526:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1528
id_morphism_1527:
    b apply_end_1528
apply_end_1528:
    b cond_end_1516
cond_false_1515:
    adr x0, sign_id
cond_end_1516:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1531
    adr x0, sign_id
    b cmp_end_1532
cmp_true_1531:
cmp_end_1532:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1529
    adr x0, compile_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1536
    tst x9, #1
    b.eq do_concat_1535
    tst x0, #1
    b.ne do_compose_1533
do_apply_1534:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1537
do_compose_1533:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1537
do_concat_1535:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1537
id_morphism_1536:
    b apply_end_1537
apply_end_1537:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1541
    tst x9, #1
    b.eq do_concat_1540
    tst x0, #1
    b.ne do_compose_1538
do_apply_1539:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1542
do_compose_1538:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1542
do_concat_1540:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1542
id_morphism_1541:
    b apply_end_1542
apply_end_1542:
    b cond_end_1530
cond_false_1529:
    adr x0, sign_id
cond_end_1530:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1545
    adr x0, sign_id
    b cmp_end_1546
cmp_true_1545:
cmp_end_1546:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1543
    adr x0, compile_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1550
    tst x9, #1
    b.eq do_concat_1549
    tst x0, #1
    b.ne do_compose_1547
do_apply_1548:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1551
do_compose_1547:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1551
do_concat_1549:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1551
id_morphism_1550:
    b apply_end_1551
apply_end_1551:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1555
    tst x9, #1
    b.eq do_concat_1554
    tst x0, #1
    b.ne do_compose_1552
do_apply_1553:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1556
do_compose_1552:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1556
do_concat_1554:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1556
id_morphism_1555:
    b apply_end_1556
apply_end_1556:
    b cond_end_1544
cond_false_1543:
    adr x0, sign_id
cond_end_1544:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, type
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
    adr x0, compile_apply
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1564
    tst x9, #1
    b.eq do_concat_1563
    tst x0, #1
    b.ne do_compose_1561
do_apply_1562:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1565
do_compose_1561:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1565
do_concat_1563:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1565
id_morphism_1564:
    b apply_end_1565
apply_end_1565:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1569
    tst x9, #1
    b.eq do_concat_1568
    tst x0, #1
    b.ne do_compose_1566
do_apply_1567:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1570
do_compose_1566:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1570
do_concat_1568:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1570
id_morphism_1569:
    b apply_end_1570
apply_end_1570:
    b cond_end_1558
cond_false_1557:
    adr x0, sign_id
cond_end_1558:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, str_33
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1444
    adr x0, str_34
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
blk_end_1444:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1574
    tst x9, #1
    b.eq do_concat_1573
    tst x0, #1
    b.ne do_compose_1571
do_apply_1572:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1575
do_compose_1571:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1575
do_concat_1573:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1575
id_morphism_1574:
    b apply_end_1575
apply_end_1575:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1441
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1579
    tst x9, #1
    b.eq do_concat_1578
    tst x0, #1
    b.ne do_compose_1576
do_apply_1577:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1580
do_compose_1576:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1580
do_concat_1578:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1580
id_morphism_1579:
    b apply_end_1580
apply_end_1580:
blk_end_1441:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1439_1440:
    // Closure for func_1439
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1439
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1437_1438:
    // Closure for func_1437
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1437
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1431
cond_false_1430:
    adr x0, sign_id
cond_end_1431:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_num
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1586
    tst x9, #1
    b.eq do_concat_1585
    tst x0, #1
    b.ne do_compose_1583
do_apply_1584:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1587
do_compose_1583:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1587
do_concat_1585:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1587
id_morphism_1586:
    b apply_end_1587
apply_end_1587:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1581
    b after_func_1588_1589
func_1588:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1590_1591
func_1590:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1593_1594
func_1593:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1593_1594:
    // Closure for func_1593
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1593
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_35
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1598
    tst x9, #1
    b.eq do_concat_1597
    tst x0, #1
    b.ne do_compose_1595
do_apply_1596:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1599
do_compose_1595:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1599
do_concat_1597:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1599
id_morphism_1598:
    b apply_end_1599
apply_end_1599:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    adr x0, val
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1603
    tst x9, #1
    b.eq do_concat_1602
    tst x0, #1
    b.ne do_compose_1600
do_apply_1601:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1604
do_compose_1600:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1604
do_concat_1602:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1604
id_morphism_1603:
    b apply_end_1604
apply_end_1604:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1608
    tst x9, #1
    b.eq do_concat_1607
    tst x0, #1
    b.ne do_compose_1605
do_apply_1606:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1609
do_compose_1605:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1609
do_concat_1607:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1609
id_morphism_1608:
    b apply_end_1609
apply_end_1609:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1613
    tst x9, #1
    b.eq do_concat_1612
    tst x0, #1
    b.ne do_compose_1610
do_apply_1611:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1614
do_compose_1610:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1614
do_concat_1612:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1614
id_morphism_1613:
    b apply_end_1614
apply_end_1614:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1618
    tst x9, #1
    b.eq do_concat_1617
    tst x0, #1
    b.ne do_compose_1615
do_apply_1616:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1619
do_compose_1615:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1619
do_concat_1617:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1619
id_morphism_1618:
    b apply_end_1619
apply_end_1619:
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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1623
    tst x9, #1
    b.eq do_concat_1622
    tst x0, #1
    b.ne do_compose_1620
do_apply_1621:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1624
do_compose_1620:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1624
do_concat_1622:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1624
id_morphism_1623:
    b apply_end_1624
apply_end_1624:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1592
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1628
    tst x9, #1
    b.eq do_concat_1627
    tst x0, #1
    b.ne do_compose_1625
do_apply_1626:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1629
do_compose_1625:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1629
do_concat_1627:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1629
id_morphism_1628:
    b apply_end_1629
apply_end_1629:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1633
    tst x9, #1
    b.eq do_concat_1632
    tst x0, #1
    b.ne do_compose_1630
do_apply_1631:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1634
do_compose_1630:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1634
do_concat_1632:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1634
id_morphism_1633:
    b apply_end_1634
apply_end_1634:
blk_end_1592:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1590_1591:
    // Closure for func_1590
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1590
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1588_1589:
    // Closure for func_1588
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1588
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1582
cond_false_1581:
    adr x0, sign_id
cond_end_1582:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_unit
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1640
    tst x9, #1
    b.eq do_concat_1639
    tst x0, #1
    b.ne do_compose_1637
do_apply_1638:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1641
do_compose_1637:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1641
do_concat_1639:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1641
id_morphism_1640:
    b apply_end_1641
apply_end_1641:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1635
    b after_func_1642_1643
func_1642:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1644_1645
func_1644:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_36
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1644_1645:
    // Closure for func_1644
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1644
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1642_1643:
    // Closure for func_1642
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1642
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
    adr x0, compile_prefix
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1651
    tst x9, #1
    b.eq do_concat_1650
    tst x0, #1
    b.ne do_compose_1648
do_apply_1649:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1652
do_compose_1648:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1652
do_concat_1650:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1652
id_morphism_1651:
    b apply_end_1652
apply_end_1652:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1646
    b after_func_1653_1654
func_1653:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1655_1656
func_1655:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1658_1659
func_1658:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1658_1659:
    // Closure for func_1658
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1658
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1668
    tst x9, #1
    b.eq do_concat_1667
    tst x0, #1
    b.ne do_compose_1665
do_apply_1666:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1669
do_compose_1665:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1669
do_concat_1667:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1669
id_morphism_1668:
    b apply_end_1669
apply_end_1669:
    str x0, [sp, #-16]!
    mov x0, #64
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1673
    tst x9, #1
    b.eq do_concat_1672
    tst x0, #1
    b.ne do_compose_1670
do_apply_1671:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1674
do_compose_1670:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1674
do_concat_1672:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1674
id_morphism_1673:
    b apply_end_1674
apply_end_1674:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1663
    adr x0, compile_prefix_at
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1678
    tst x9, #1
    b.eq do_concat_1677
    tst x0, #1
    b.ne do_compose_1675
do_apply_1676:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1679
do_compose_1675:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1679
do_concat_1677:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1679
id_morphism_1678:
    b apply_end_1679
apply_end_1679:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1683
    tst x9, #1
    b.eq do_concat_1682
    tst x0, #1
    b.ne do_compose_1680
do_apply_1681:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1684
do_compose_1680:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1684
do_concat_1682:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1684
id_morphism_1683:
    b apply_end_1684
apply_end_1684:
    b cond_end_1664
cond_false_1663:
    adr x0, sign_id
cond_end_1664:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1662
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1690
    tst x9, #1
    b.eq do_concat_1689
    tst x0, #1
    b.ne do_compose_1687
do_apply_1688:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1691
do_compose_1687:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1691
do_concat_1689:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1691
id_morphism_1690:
    b apply_end_1691
apply_end_1691:
    str x0, [sp, #-16]!
    mov x0, #33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1695
    tst x9, #1
    b.eq do_concat_1694
    tst x0, #1
    b.ne do_compose_1692
do_apply_1693:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1696
do_compose_1692:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1696
do_concat_1694:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1696
id_morphism_1695:
    b apply_end_1696
apply_end_1696:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1685
    adr x0, compile_prefix_not
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1700
    tst x9, #1
    b.eq do_concat_1699
    tst x0, #1
    b.ne do_compose_1697
do_apply_1698:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1701
do_compose_1697:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1701
do_concat_1699:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1701
id_morphism_1700:
    b apply_end_1701
apply_end_1701:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1705
    tst x9, #1
    b.eq do_concat_1704
    tst x0, #1
    b.ne do_compose_1702
do_apply_1703:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1706
do_compose_1702:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1706
do_concat_1704:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1706
id_morphism_1705:
    b apply_end_1706
apply_end_1706:
    b cond_end_1686
cond_false_1685:
    adr x0, sign_id
cond_end_1686:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1662
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1712
    tst x9, #1
    b.eq do_concat_1711
    tst x0, #1
    b.ne do_compose_1709
do_apply_1710:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1713
do_compose_1709:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1713
do_concat_1711:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1713
id_morphism_1712:
    b apply_end_1713
apply_end_1713:
    str x0, [sp, #-16]!
    adr x0, str_37
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1717
    tst x9, #1
    b.eq do_concat_1716
    tst x0, #1
    b.ne do_compose_1714
do_apply_1715:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1718
do_compose_1714:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1718
do_concat_1716:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1718
id_morphism_1717:
    b apply_end_1718
apply_end_1718:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1707
    adr x0, compile_prefix_bitwise_not
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1722
    tst x9, #1
    b.eq do_concat_1721
    tst x0, #1
    b.ne do_compose_1719
do_apply_1720:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1723
do_compose_1719:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1723
do_concat_1721:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1723
id_morphism_1722:
    b apply_end_1723
apply_end_1723:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1727
    tst x9, #1
    b.eq do_concat_1726
    tst x0, #1
    b.ne do_compose_1724
do_apply_1725:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1728
do_compose_1724:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1728
do_concat_1726:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1728
id_morphism_1727:
    b apply_end_1728
apply_end_1728:
    b cond_end_1708
cond_false_1707:
    adr x0, sign_id
cond_end_1708:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1662
    adr x0, str_38
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1662
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1732
    tst x9, #1
    b.eq do_concat_1731
    tst x0, #1
    b.ne do_compose_1729
do_apply_1730:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1733
do_compose_1729:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1733
do_concat_1731:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1733
id_morphism_1732:
    b apply_end_1733
apply_end_1733:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1737
    tst x9, #1
    b.eq do_concat_1736
    tst x0, #1
    b.ne do_compose_1734
do_apply_1735:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1738
do_compose_1734:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1738
do_concat_1736:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1738
id_morphism_1737:
    b apply_end_1738
apply_end_1738:
blk_end_1662:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1742
    tst x9, #1
    b.eq do_concat_1741
    tst x0, #1
    b.ne do_compose_1739
do_apply_1740:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1743
do_compose_1739:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1743
do_concat_1741:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1743
id_morphism_1742:
    b apply_end_1743
apply_end_1743:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1657
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1747
    tst x9, #1
    b.eq do_concat_1746
    tst x0, #1
    b.ne do_compose_1744
do_apply_1745:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1748
do_compose_1744:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1748
do_concat_1746:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1748
id_morphism_1747:
    b apply_end_1748
apply_end_1748:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1752
    tst x9, #1
    b.eq do_concat_1751
    tst x0, #1
    b.ne do_compose_1749
do_apply_1750:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1753
do_compose_1749:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1753
do_concat_1751:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1753
id_morphism_1752:
    b apply_end_1753
apply_end_1753:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1757
    tst x9, #1
    b.eq do_concat_1756
    tst x0, #1
    b.ne do_compose_1754
do_apply_1755:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1758
do_compose_1754:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1758
do_concat_1756:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1758
id_morphism_1757:
    b apply_end_1758
apply_end_1758:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1762
    tst x9, #1
    b.eq do_concat_1761
    tst x0, #1
    b.ne do_compose_1759
do_apply_1760:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1763
do_compose_1759:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1763
do_concat_1761:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1763
id_morphism_1762:
    b apply_end_1763
apply_end_1763:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1767
    tst x9, #1
    b.eq do_concat_1766
    tst x0, #1
    b.ne do_compose_1764
do_apply_1765:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1768
do_compose_1764:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1768
do_concat_1766:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1768
id_morphism_1767:
    b apply_end_1768
apply_end_1768:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1772
    tst x9, #1
    b.eq do_concat_1771
    tst x0, #1
    b.ne do_compose_1769
do_apply_1770:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1773
do_compose_1769:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1773
do_concat_1771:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1773
id_morphism_1772:
    b apply_end_1773
apply_end_1773:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1777
    tst x9, #1
    b.eq do_concat_1776
    tst x0, #1
    b.ne do_compose_1774
do_apply_1775:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1778
do_compose_1774:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1778
do_concat_1776:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1778
id_morphism_1777:
    b apply_end_1778
apply_end_1778:
blk_end_1657:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1655_1656:
    // Closure for func_1655
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1655
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1653_1654:
    // Closure for func_1653
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1653
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1647
cond_false_1646:
    adr x0, sign_id
cond_end_1647:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_prefix_at
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1784
    tst x9, #1
    b.eq do_concat_1783
    tst x0, #1
    b.ne do_compose_1781
do_apply_1782:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1785
do_compose_1781:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1785
do_concat_1783:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1785
id_morphism_1784:
    b apply_end_1785
apply_end_1785:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1779
    b after_func_1786_1787
func_1786:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1788_1789
func_1788:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, expr_is_zero_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1796
    tst x9, #1
    b.eq do_concat_1795
    tst x0, #1
    b.ne do_compose_1793
do_apply_1794:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1797
do_compose_1793:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1797
do_concat_1795:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1797
id_morphism_1796:
    b apply_end_1797
apply_end_1797:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1791
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_39
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
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1801
    tst x9, #1
    b.eq do_concat_1800
    tst x0, #1
    b.ne do_compose_1798
do_apply_1799:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1802
do_compose_1798:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1802
do_concat_1800:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1802
id_morphism_1801:
    b apply_end_1802
apply_end_1802:
    b cond_end_1792
cond_false_1791:
    adr x0, sign_id
cond_end_1792:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1790
    b after_func_1803_1804
func_1803:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1803_1804:
    // Closure for func_1803
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1803
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1806_1807
func_1806:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1808_1809
func_1808:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1808_1809:
    // Closure for func_1808
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1808
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1806_1807:
    // Closure for func_1806
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1806
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, asm
    str x0, [sp, #-16]!
    adr x0, str_40
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1813
    tst x9, #1
    b.eq do_concat_1812
    tst x0, #1
    b.ne do_compose_1810
do_apply_1811:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1814
do_compose_1810:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1814
do_concat_1812:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1814
id_morphism_1813:
    b apply_end_1814
apply_end_1814:
    str x0, [sp, #-16]!
    adr x0, ctx_new
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1818
    tst x9, #1
    b.eq do_concat_1817
    tst x0, #1
    b.ne do_compose_1815
do_apply_1816:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1819
do_compose_1815:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1819
do_concat_1817:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1819
id_morphism_1818:
    b apply_end_1819
apply_end_1819:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1805
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1823
    tst x9, #1
    b.eq do_concat_1822
    tst x0, #1
    b.ne do_compose_1820
do_apply_1821:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1824
do_compose_1820:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1824
do_concat_1822:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1824
id_morphism_1823:
    b apply_end_1824
apply_end_1824:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1828
    tst x9, #1
    b.eq do_concat_1827
    tst x0, #1
    b.ne do_compose_1825
do_apply_1826:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1829
do_compose_1825:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1829
do_concat_1827:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1829
id_morphism_1828:
    b apply_end_1829
apply_end_1829:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1833
    tst x9, #1
    b.eq do_concat_1832
    tst x0, #1
    b.ne do_compose_1830
do_apply_1831:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1834
do_compose_1830:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1834
do_concat_1832:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1834
id_morphism_1833:
    b apply_end_1834
apply_end_1834:
blk_end_1805:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1838
    tst x9, #1
    b.eq do_concat_1837
    tst x0, #1
    b.ne do_compose_1835
do_apply_1836:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1839
do_compose_1835:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1839
do_concat_1837:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1839
id_morphism_1838:
    b apply_end_1839
apply_end_1839:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1790
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1843
    tst x9, #1
    b.eq do_concat_1842
    tst x0, #1
    b.ne do_compose_1840
do_apply_1841:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1844
do_compose_1840:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1844
do_concat_1842:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1844
id_morphism_1843:
    b apply_end_1844
apply_end_1844:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1848
    tst x9, #1
    b.eq do_concat_1847
    tst x0, #1
    b.ne do_compose_1845
do_apply_1846:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1849
do_compose_1845:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1849
do_concat_1847:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1849
id_morphism_1848:
    b apply_end_1849
apply_end_1849:
blk_end_1790:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1788_1789:
    // Closure for func_1788
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1788
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1780
cond_false_1779:
    adr x0, sign_id
cond_end_1780:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expr_is_zero_num
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1855
    tst x9, #1
    b.eq do_concat_1854
    tst x0, #1
    b.ne do_compose_1852
do_apply_1853:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1856
do_compose_1852:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1856
do_concat_1854:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1856
id_morphism_1855:
    b apply_end_1856
apply_end_1856:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1850
    b after_func_1857_1858
func_1857:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1866
    tst x9, #1
    b.eq do_concat_1865
    tst x0, #1
    b.ne do_compose_1863
do_apply_1864:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1867
do_compose_1863:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1867
do_concat_1865:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1867
id_morphism_1866:
    b apply_end_1867
apply_end_1867:
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1861
    adr x0, sign_id
    b cmp_end_1862
cmp_true_1861:
cmp_end_1862:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1859
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1873
    tst x9, #1
    b.eq do_concat_1872
    tst x0, #1
    b.ne do_compose_1870
do_apply_1871:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1874
do_compose_1870:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1874
do_concat_1872:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1874
id_morphism_1873:
    b apply_end_1874
apply_end_1874:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1878
    tst x9, #1
    b.eq do_concat_1877
    tst x0, #1
    b.ne do_compose_1875
do_apply_1876:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1879
do_compose_1875:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1879
do_concat_1877:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1879
id_morphism_1878:
    b apply_end_1879
apply_end_1879:
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1868
    adr x0, sign_id
    b cmp_end_1869
cmp_true_1868:
cmp_end_1869:
    b and_end_1860
and_fail_1859:
    adr x0, sign_id
and_end_1860:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1857_1858:
    // Closure for func_1857
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1857
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1851
cond_false_1850:
    adr x0, sign_id
cond_end_1851:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_prefix_not
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1885
    tst x9, #1
    b.eq do_concat_1884
    tst x0, #1
    b.ne do_compose_1882
do_apply_1883:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1886
do_compose_1882:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1886
do_concat_1884:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1886
id_morphism_1885:
    b apply_end_1886
apply_end_1886:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1880
    b after_func_1887_1888
func_1887:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1889_1890
func_1889:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1891_1892
func_1891:
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
    b.eq or_right_1894
    b or_end_1895
or_right_1894:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1899
    tst x9, #1
    b.eq do_concat_1898
    tst x0, #1
    b.ne do_compose_1896
do_apply_1897:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1900
do_compose_1896:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1900
do_concat_1898:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1900
id_morphism_1899:
    b apply_end_1900
apply_end_1900:
    str x0, [sp, #-16]!
    adr x0, str_41
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1904
    tst x9, #1
    b.eq do_concat_1903
    tst x0, #1
    b.ne do_compose_1901
do_apply_1902:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1905
do_compose_1901:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1905
do_concat_1903:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1905
id_morphism_1904:
    b apply_end_1905
apply_end_1905:
or_end_1895:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1893
    b after_func_1906_1907
func_1906:
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
    b.eq or_right_1909
    b or_end_1910
or_right_1909:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1914
    tst x9, #1
    b.eq do_concat_1913
    tst x0, #1
    b.ne do_compose_1911
do_apply_1912:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1915
do_compose_1911:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1915
do_concat_1913:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1915
id_morphism_1914:
    b apply_end_1915
apply_end_1915:
or_end_1910:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1908
    b after_func_1916_1917
func_1916:
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
    b.eq or_right_1919
    b or_end_1920
or_right_1919:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1924
    tst x9, #1
    b.eq do_concat_1923
    tst x0, #1
    b.ne do_compose_1921
do_apply_1922:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1925
do_compose_1921:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1925
do_concat_1923:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1925
id_morphism_1924:
    b apply_end_1925
apply_end_1925:
    str x0, [sp, #-16]!
    adr x0, str_42
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1929
    tst x9, #1
    b.eq do_concat_1928
    tst x0, #1
    b.ne do_compose_1926
do_apply_1927:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1930
do_compose_1926:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1930
do_concat_1928:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1930
id_morphism_1929:
    b apply_end_1930
apply_end_1930:
or_end_1920:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1918
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1934
    b or_end_1935
or_right_1934:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1939
    tst x9, #1
    b.eq do_concat_1938
    tst x0, #1
    b.ne do_compose_1936
do_apply_1937:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1940
do_compose_1936:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1940
do_concat_1938:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1940
id_morphism_1939:
    b apply_end_1940
apply_end_1940:
or_end_1935:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1933
    b after_func_1941_1942
func_1941:
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
    b.eq or_right_1944
    b or_end_1945
or_right_1944:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1949
    tst x9, #1
    b.eq do_concat_1948
    tst x0, #1
    b.ne do_compose_1946
do_apply_1947:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1950
do_compose_1946:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1950
do_concat_1948:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1950
id_morphism_1949:
    b apply_end_1950
apply_end_1950:
or_end_1945:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1943
    b after_func_1951_1952
func_1951:
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
    b.eq or_right_1954
    b or_end_1955
or_right_1954:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1959
    tst x9, #1
    b.eq do_concat_1958
    tst x0, #1
    b.ne do_compose_1956
do_apply_1957:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1960
do_compose_1956:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1960
do_concat_1958:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1960
id_morphism_1959:
    b apply_end_1960
apply_end_1960:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1964
    tst x9, #1
    b.eq do_concat_1963
    tst x0, #1
    b.ne do_compose_1961
do_apply_1962:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1965
do_compose_1961:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1965
do_concat_1963:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1965
id_morphism_1964:
    b apply_end_1965
apply_end_1965:
or_end_1955:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1953
    b after_func_1966_1967
func_1966:
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
    b.eq or_right_1969
    b or_end_1970
or_right_1969:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1974
    tst x9, #1
    b.eq do_concat_1973
    tst x0, #1
    b.ne do_compose_1971
do_apply_1972:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1975
do_compose_1971:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1975
do_concat_1973:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1975
id_morphism_1974:
    b apply_end_1975
apply_end_1975:
or_end_1970:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1968
    b after_func_1976_1977
func_1976:
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
    b.eq or_right_1979
    b or_end_1980
or_right_1979:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1984
    tst x9, #1
    b.eq do_concat_1983
    tst x0, #1
    b.ne do_compose_1981
do_apply_1982:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1985
do_compose_1981:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1985
do_concat_1983:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1985
id_morphism_1984:
    b apply_end_1985
apply_end_1985:
or_end_1980:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1978
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_43
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_44
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1986
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_13
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1990
    tst x9, #1
    b.eq do_concat_1989
    tst x0, #1
    b.ne do_compose_1987
do_apply_1988:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1991
do_compose_1987:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1991
do_concat_1989:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1991
id_morphism_1990:
    b apply_end_1991
apply_end_1991:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_1995
    tst x9, #1
    b.eq do_concat_1994
    tst x0, #1
    b.ne do_compose_1992
do_apply_1993:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1996
do_compose_1992:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_1996
do_concat_1994:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_1996
id_morphism_1995:
    b apply_end_1996
apply_end_1996:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2000
    tst x9, #1
    b.eq do_concat_1999
    tst x0, #1
    b.ne do_compose_1997
do_apply_1998:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2001
do_compose_1997:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2001
do_concat_1999:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2001
id_morphism_2000:
    b apply_end_2001
apply_end_2001:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2005
    tst x9, #1
    b.eq do_concat_2004
    tst x0, #1
    b.ne do_compose_2002
do_apply_2003:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2006
do_compose_2002:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2006
do_concat_2004:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2006
id_morphism_2005:
    b apply_end_2006
apply_end_2006:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1986
    adr x0, str_36
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1986
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_22
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2010
    tst x9, #1
    b.eq do_concat_2009
    tst x0, #1
    b.ne do_compose_2007
do_apply_2008:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2011
do_compose_2007:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2011
do_concat_2009:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2011
id_morphism_2010:
    b apply_end_2011
apply_end_2011:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2015
    tst x9, #1
    b.eq do_concat_2014
    tst x0, #1
    b.ne do_compose_2012
do_apply_2013:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2016
do_compose_2012:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2016
do_concat_2014:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2016
id_morphism_2015:
    b apply_end_2016
apply_end_2016:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2020
    tst x9, #1
    b.eq do_concat_2019
    tst x0, #1
    b.ne do_compose_2017
do_apply_2018:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2021
do_compose_2017:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2021
do_concat_2019:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2021
id_morphism_2020:
    b apply_end_2021
apply_end_2021:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2025
    tst x9, #1
    b.eq do_concat_2024
    tst x0, #1
    b.ne do_compose_2022
do_apply_2023:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2026
do_compose_2022:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2026
do_concat_2024:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2026
id_morphism_2025:
    b apply_end_2026
apply_end_2026:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1986
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2030
    tst x9, #1
    b.eq do_concat_2029
    tst x0, #1
    b.ne do_compose_2027
do_apply_2028:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2031
do_compose_2027:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2031
do_concat_2029:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2031
id_morphism_2030:
    b apply_end_2031
apply_end_2031:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2035
    tst x9, #1
    b.eq do_concat_2034
    tst x0, #1
    b.ne do_compose_2032
do_apply_2033:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2036
do_compose_2032:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2036
do_concat_2034:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2036
id_morphism_2035:
    b apply_end_2036
apply_end_2036:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1986
    adr x0, str_45
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1986
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2040
    tst x9, #1
    b.eq do_concat_2039
    tst x0, #1
    b.ne do_compose_2037
do_apply_2038:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2041
do_compose_2037:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2041
do_concat_2039:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2041
id_morphism_2040:
    b apply_end_2041
apply_end_2041:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2045
    tst x9, #1
    b.eq do_concat_2044
    tst x0, #1
    b.ne do_compose_2042
do_apply_2043:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2046
do_compose_2042:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2046
do_concat_2044:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2046
id_morphism_2045:
    b apply_end_2046
apply_end_2046:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_1986:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2050
    tst x9, #1
    b.eq do_concat_2049
    tst x0, #1
    b.ne do_compose_2047
do_apply_2048:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2051
do_compose_2047:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2051
do_concat_2049:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2051
id_morphism_2050:
    b apply_end_2051
apply_end_2051:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2055
    tst x9, #1
    b.eq do_concat_2054
    tst x0, #1
    b.ne do_compose_2052
do_apply_2053:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2056
do_compose_2052:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2056
do_concat_2054:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2056
id_morphism_2055:
    b apply_end_2056
apply_end_2056:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_1978:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1976_1977:
    // Closure for func_1976
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
    ldr x0, [x29, #-96]
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
    adr x1, func_1976
    ldr x0, [sp], #16
    bl _cons
blk_end_1968:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1966_1967:
    // Closure for func_1966
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1966
    ldr x0, [sp], #16
    bl _cons
blk_end_1953:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1951_1952:
    // Closure for func_1951
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
    ldr x0, [x29, #-112]
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
    adr x1, func_1951
    ldr x0, [sp], #16
    bl _cons
blk_end_1943:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1941_1942:
    // Closure for func_1941
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
    adr x1, func_1941
    ldr x0, [sp], #16
    bl _cons
blk_end_1933:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1931_1932:
    // Closure for func_1931
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
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1931
    ldr x0, [sp], #16
    bl _cons
blk_end_1918:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1916_1917:
    // Closure for func_1916
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
    adr x1, func_1916
    ldr x0, [sp], #16
    bl _cons
blk_end_1908:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1906_1907:
    // Closure for func_1906
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
    adr x1, func_1906
    ldr x0, [sp], #16
    bl _cons
blk_end_1893:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1891_1892:
    // Closure for func_1891
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
    adr x1, func_1891
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1889_1890:
    // Closure for func_1889
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1889
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1881
cond_false_1880:
    adr x0, sign_id
cond_end_1881:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_prefix_bitwise_not
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2062
    tst x9, #1
    b.eq do_concat_2061
    tst x0, #1
    b.ne do_compose_2059
do_apply_2060:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2063
do_compose_2059:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2063
do_concat_2061:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2063
id_morphism_2062:
    b apply_end_2063
apply_end_2063:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2057
    b after_func_2064_2065
func_2064:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2066_2067
func_2066:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2069_2070
func_2069:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2069_2070:
    // Closure for func_2069
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2069
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2072_2073
func_2072:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2074_2075
func_2074:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2074_2075:
    // Closure for func_2074
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2074
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2072_2073:
    // Closure for func_2072
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2072
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, asm
    str x0, [sp, #-16]!
    adr x0, str_46
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2079
    tst x9, #1
    b.eq do_concat_2078
    tst x0, #1
    b.ne do_compose_2076
do_apply_2077:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2080
do_compose_2076:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2080
do_concat_2078:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2080
id_morphism_2079:
    b apply_end_2080
apply_end_2080:
    str x0, [sp, #-16]!
    adr x0, ctx_new
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2084
    tst x9, #1
    b.eq do_concat_2083
    tst x0, #1
    b.ne do_compose_2081
do_apply_2082:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2085
do_compose_2081:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2085
do_concat_2083:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2085
id_morphism_2084:
    b apply_end_2085
apply_end_2085:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2071
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2089
    tst x9, #1
    b.eq do_concat_2088
    tst x0, #1
    b.ne do_compose_2086
do_apply_2087:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2090
do_compose_2086:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2090
do_concat_2088:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2090
id_morphism_2089:
    b apply_end_2090
apply_end_2090:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2094
    tst x9, #1
    b.eq do_concat_2093
    tst x0, #1
    b.ne do_compose_2091
do_apply_2092:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2095
do_compose_2091:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2095
do_concat_2093:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2095
id_morphism_2094:
    b apply_end_2095
apply_end_2095:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2099
    tst x9, #1
    b.eq do_concat_2098
    tst x0, #1
    b.ne do_compose_2096
do_apply_2097:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2100
do_compose_2096:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2100
do_concat_2098:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2100
id_morphism_2099:
    b apply_end_2100
apply_end_2100:
blk_end_2071:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2104
    tst x9, #1
    b.eq do_concat_2103
    tst x0, #1
    b.ne do_compose_2101
do_apply_2102:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2105
do_compose_2101:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2105
do_concat_2103:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2105
id_morphism_2104:
    b apply_end_2105
apply_end_2105:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2068
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2109
    tst x9, #1
    b.eq do_concat_2108
    tst x0, #1
    b.ne do_compose_2106
do_apply_2107:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2110
do_compose_2106:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2110
do_concat_2108:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2110
id_morphism_2109:
    b apply_end_2110
apply_end_2110:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2114
    tst x9, #1
    b.eq do_concat_2113
    tst x0, #1
    b.ne do_compose_2111
do_apply_2112:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2115
do_compose_2111:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2115
do_concat_2113:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2115
id_morphism_2114:
    b apply_end_2115
apply_end_2115:
blk_end_2068:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2066_2067:
    // Closure for func_2066
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2066
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_2058
cond_false_2057:
    adr x0, sign_id
cond_end_2058:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_postfix
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2121
    tst x9, #1
    b.eq do_concat_2120
    tst x0, #1
    b.ne do_compose_2118
do_apply_2119:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2122
do_compose_2118:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2122
do_concat_2120:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2122
id_morphism_2121:
    b apply_end_2122
apply_end_2122:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2116
    b after_func_2123_2124
func_2123:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2125_2126
func_2125:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
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
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2130_2131:
    // Closure for func_2130
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2138
    tst x9, #1
    b.eq do_concat_2137
    tst x0, #1
    b.ne do_compose_2135
do_apply_2136:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2139
do_compose_2135:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2139
do_concat_2137:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2139
id_morphism_2138:
    b apply_end_2139
apply_end_2139:
    str x0, [sp, #-16]!
    mov x0, #33
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2143
    tst x9, #1
    b.eq do_concat_2142
    tst x0, #1
    b.ne do_compose_2140
do_apply_2141:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2144
do_compose_2140:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2144
do_concat_2142:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2144
id_morphism_2143:
    b apply_end_2144
apply_end_2144:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2133
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_2146_2147
func_2146:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2146_2147:
    // Closure for func_2146
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2146
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2149_2150
func_2149:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2151_2152
func_2151:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2151_2152:
    // Closure for func_2151
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2151
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2149_2150:
    // Closure for func_2149
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2149
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, asm
    str x0, [sp, #-16]!
    adr x0, str_47
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2156
    tst x9, #1
    b.eq do_concat_2155
    tst x0, #1
    b.ne do_compose_2153
do_apply_2154:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2157
do_compose_2153:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2157
do_concat_2155:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2157
id_morphism_2156:
    b apply_end_2157
apply_end_2157:
    str x0, [sp, #-16]!
    adr x0, ctx_new
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2161
    tst x9, #1
    b.eq do_concat_2160
    tst x0, #1
    b.ne do_compose_2158
do_apply_2159:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2162
do_compose_2158:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2162
do_concat_2160:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2162
id_morphism_2161:
    b apply_end_2162
apply_end_2162:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2148
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2166
    tst x9, #1
    b.eq do_concat_2165
    tst x0, #1
    b.ne do_compose_2163
do_apply_2164:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2167
do_compose_2163:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2167
do_concat_2165:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2167
id_morphism_2166:
    b apply_end_2167
apply_end_2167:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2171
    tst x9, #1
    b.eq do_concat_2170
    tst x0, #1
    b.ne do_compose_2168
do_apply_2169:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2172
do_compose_2168:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2172
do_concat_2170:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2172
id_morphism_2171:
    b apply_end_2172
apply_end_2172:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2176
    tst x9, #1
    b.eq do_concat_2175
    tst x0, #1
    b.ne do_compose_2173
do_apply_2174:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2177
do_compose_2173:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2177
do_concat_2175:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2177
id_morphism_2176:
    b apply_end_2177
apply_end_2177:
blk_end_2148:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2181
    tst x9, #1
    b.eq do_concat_2180
    tst x0, #1
    b.ne do_compose_2178
do_apply_2179:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2182
do_compose_2178:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2182
do_concat_2180:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2182
id_morphism_2181:
    b apply_end_2182
apply_end_2182:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2145
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2186
    tst x9, #1
    b.eq do_concat_2185
    tst x0, #1
    b.ne do_compose_2183
do_apply_2184:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2187
do_compose_2183:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2187
do_concat_2185:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2187
id_morphism_2186:
    b apply_end_2187
apply_end_2187:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2191
    tst x9, #1
    b.eq do_concat_2190
    tst x0, #1
    b.ne do_compose_2188
do_apply_2189:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2192
do_compose_2188:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2192
do_concat_2190:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2192
id_morphism_2191:
    b apply_end_2192
apply_end_2192:
blk_end_2145:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2196
    tst x9, #1
    b.eq do_concat_2195
    tst x0, #1
    b.ne do_compose_2193
do_apply_2194:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2197
do_compose_2193:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2197
do_concat_2195:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2197
id_morphism_2196:
    b apply_end_2197
apply_end_2197:
    b cond_end_2134
cond_false_2133:
    adr x0, sign_id
cond_end_2134:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2132
    adr x0, str_38
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2132
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2201
    tst x9, #1
    b.eq do_concat_2200
    tst x0, #1
    b.ne do_compose_2198
do_apply_2199:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2202
do_compose_2198:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2202
do_concat_2200:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2202
id_morphism_2201:
    b apply_end_2202
apply_end_2202:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2206
    tst x9, #1
    b.eq do_concat_2205
    tst x0, #1
    b.ne do_compose_2203
do_apply_2204:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2207
do_compose_2203:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2207
do_concat_2205:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2207
id_morphism_2206:
    b apply_end_2207
apply_end_2207:
blk_end_2132:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2211
    tst x9, #1
    b.eq do_concat_2210
    tst x0, #1
    b.ne do_compose_2208
do_apply_2209:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2212
do_compose_2208:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2212
do_concat_2210:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2212
id_morphism_2211:
    b apply_end_2212
apply_end_2212:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2127
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2216
    tst x9, #1
    b.eq do_concat_2215
    tst x0, #1
    b.ne do_compose_2213
do_apply_2214:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2217
do_compose_2213:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2217
do_concat_2215:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2217
id_morphism_2216:
    b apply_end_2217
apply_end_2217:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2221
    tst x9, #1
    b.eq do_concat_2220
    tst x0, #1
    b.ne do_compose_2218
do_apply_2219:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2222
do_compose_2218:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2222
do_concat_2220:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2222
id_morphism_2221:
    b apply_end_2222
apply_end_2222:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2226
    tst x9, #1
    b.eq do_concat_2225
    tst x0, #1
    b.ne do_compose_2223
do_apply_2224:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2227
do_compose_2223:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2227
do_concat_2225:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2227
id_morphism_2226:
    b apply_end_2227
apply_end_2227:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2231
    tst x9, #1
    b.eq do_concat_2230
    tst x0, #1
    b.ne do_compose_2228
do_apply_2229:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2232
do_compose_2228:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2232
do_concat_2230:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2232
id_morphism_2231:
    b apply_end_2232
apply_end_2232:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2236
    tst x9, #1
    b.eq do_concat_2235
    tst x0, #1
    b.ne do_compose_2233
do_apply_2234:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2237
do_compose_2233:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2237
do_concat_2235:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2237
id_morphism_2236:
    b apply_end_2237
apply_end_2237:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2241
    tst x9, #1
    b.eq do_concat_2240
    tst x0, #1
    b.ne do_compose_2238
do_apply_2239:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2242
do_compose_2238:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2242
do_concat_2240:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2242
id_morphism_2241:
    b apply_end_2242
apply_end_2242:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2246
    tst x9, #1
    b.eq do_concat_2245
    tst x0, #1
    b.ne do_compose_2243
do_apply_2244:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2247
do_compose_2243:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2247
do_concat_2245:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2247
id_morphism_2246:
    b apply_end_2247
apply_end_2247:
blk_end_2127:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2125_2126:
    // Closure for func_2125
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2125
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2123_2124:
    // Closure for func_2123
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2123
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2117
cond_false_2116:
    adr x0, sign_id
cond_end_2117:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_infix
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2253
    tst x9, #1
    b.eq do_concat_2252
    tst x0, #1
    b.ne do_compose_2250
do_apply_2251:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2254
do_compose_2250:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2254
do_concat_2252:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2254
id_morphism_2253:
    b apply_end_2254
apply_end_2254:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2248
    b after_func_2255_2256
func_2255:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2257_2258
func_2257:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2260_2261
func_2260:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2260_2261:
    // Closure for func_2260
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2260
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2268
    tst x9, #1
    b.eq do_concat_2267
    tst x0, #1
    b.ne do_compose_2265
do_apply_2266:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2269
do_compose_2265:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2269
do_concat_2267:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2269
id_morphism_2268:
    b apply_end_2269
apply_end_2269:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2273
    tst x9, #1
    b.eq do_concat_2272
    tst x0, #1
    b.ne do_compose_2270
do_apply_2271:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2274
do_compose_2270:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2274
do_concat_2272:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2274
id_morphism_2273:
    b apply_end_2274
apply_end_2274:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2263
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2278
    tst x9, #1
    b.eq do_concat_2277
    tst x0, #1
    b.ne do_compose_2275
do_apply_2276:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2279
do_compose_2275:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2279
do_concat_2277:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2279
id_morphism_2278:
    b apply_end_2279
apply_end_2279:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2283
    tst x9, #1
    b.eq do_concat_2282
    tst x0, #1
    b.ne do_compose_2280
do_apply_2281:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2284
do_compose_2280:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2284
do_concat_2282:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2284
id_morphism_2283:
    b apply_end_2284
apply_end_2284:
    str x0, [sp, #-16]!
    adr x0, str_48
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2288
    tst x9, #1
    b.eq do_concat_2287
    tst x0, #1
    b.ne do_compose_2285
do_apply_2286:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2289
do_compose_2285:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2289
do_concat_2287:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2289
id_morphism_2288:
    b apply_end_2289
apply_end_2289:
    b cond_end_2264
cond_false_2263:
    adr x0, sign_id
cond_end_2264:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2295
    tst x9, #1
    b.eq do_concat_2294
    tst x0, #1
    b.ne do_compose_2292
do_apply_2293:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2296
do_compose_2292:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2296
do_concat_2294:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2296
id_morphism_2295:
    b apply_end_2296
apply_end_2296:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2300
    tst x9, #1
    b.eq do_concat_2299
    tst x0, #1
    b.ne do_compose_2297
do_apply_2298:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2301
do_compose_2297:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2301
do_concat_2299:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2301
id_morphism_2300:
    b apply_end_2301
apply_end_2301:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2290
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2305
    tst x9, #1
    b.eq do_concat_2304
    tst x0, #1
    b.ne do_compose_2302
do_apply_2303:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2306
do_compose_2302:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2306
do_concat_2304:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2306
id_morphism_2305:
    b apply_end_2306
apply_end_2306:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2310
    tst x9, #1
    b.eq do_concat_2309
    tst x0, #1
    b.ne do_compose_2307
do_apply_2308:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2311
do_compose_2307:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2311
do_concat_2309:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2311
id_morphism_2310:
    b apply_end_2311
apply_end_2311:
    str x0, [sp, #-16]!
    adr x0, str_49
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2315
    tst x9, #1
    b.eq do_concat_2314
    tst x0, #1
    b.ne do_compose_2312
do_apply_2313:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2316
do_compose_2312:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2316
do_concat_2314:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2316
id_morphism_2315:
    b apply_end_2316
apply_end_2316:
    b cond_end_2291
cond_false_2290:
    adr x0, sign_id
cond_end_2291:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2322
    tst x9, #1
    b.eq do_concat_2321
    tst x0, #1
    b.ne do_compose_2319
do_apply_2320:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2323
do_compose_2319:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2323
do_concat_2321:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2323
id_morphism_2322:
    b apply_end_2323
apply_end_2323:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2327
    tst x9, #1
    b.eq do_concat_2326
    tst x0, #1
    b.ne do_compose_2324
do_apply_2325:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2328
do_compose_2324:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2328
do_concat_2326:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2328
id_morphism_2327:
    b apply_end_2328
apply_end_2328:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2317
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2332
    tst x9, #1
    b.eq do_concat_2331
    tst x0, #1
    b.ne do_compose_2329
do_apply_2330:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2333
do_compose_2329:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2333
do_concat_2331:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2333
id_morphism_2332:
    b apply_end_2333
apply_end_2333:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2337
    tst x9, #1
    b.eq do_concat_2336
    tst x0, #1
    b.ne do_compose_2334
do_apply_2335:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2338
do_compose_2334:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2338
do_concat_2336:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2338
id_morphism_2337:
    b apply_end_2338
apply_end_2338:
    str x0, [sp, #-16]!
    adr x0, str_50
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2342
    tst x9, #1
    b.eq do_concat_2341
    tst x0, #1
    b.ne do_compose_2339
do_apply_2340:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2343
do_compose_2339:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2343
do_concat_2341:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2343
id_morphism_2342:
    b apply_end_2343
apply_end_2343:
    b cond_end_2318
cond_false_2317:
    adr x0, sign_id
cond_end_2318:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2349
    tst x9, #1
    b.eq do_concat_2348
    tst x0, #1
    b.ne do_compose_2346
do_apply_2347:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2350
do_compose_2346:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2350
do_concat_2348:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2350
id_morphism_2349:
    b apply_end_2350
apply_end_2350:
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2354
    tst x9, #1
    b.eq do_concat_2353
    tst x0, #1
    b.ne do_compose_2351
do_apply_2352:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2355
do_compose_2351:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2355
do_concat_2353:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2355
id_morphism_2354:
    b apply_end_2355
apply_end_2355:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2344
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2359
    tst x9, #1
    b.eq do_concat_2358
    tst x0, #1
    b.ne do_compose_2356
do_apply_2357:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2360
do_compose_2356:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2360
do_concat_2358:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2360
id_morphism_2359:
    b apply_end_2360
apply_end_2360:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2364
    tst x9, #1
    b.eq do_concat_2363
    tst x0, #1
    b.ne do_compose_2361
do_apply_2362:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2365
do_compose_2361:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2365
do_concat_2363:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2365
id_morphism_2364:
    b apply_end_2365
apply_end_2365:
    str x0, [sp, #-16]!
    adr x0, str_51
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2369
    tst x9, #1
    b.eq do_concat_2368
    tst x0, #1
    b.ne do_compose_2366
do_apply_2367:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2370
do_compose_2366:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2370
do_concat_2368:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2370
id_morphism_2369:
    b apply_end_2370
apply_end_2370:
    b cond_end_2345
cond_false_2344:
    adr x0, sign_id
cond_end_2345:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2376
    tst x9, #1
    b.eq do_concat_2375
    tst x0, #1
    b.ne do_compose_2373
do_apply_2374:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2377
do_compose_2373:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2377
do_concat_2375:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2377
id_morphism_2376:
    b apply_end_2377
apply_end_2377:
    str x0, [sp, #-16]!
    mov x0, #61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2381
    tst x9, #1
    b.eq do_concat_2380
    tst x0, #1
    b.ne do_compose_2378
do_apply_2379:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2382
do_compose_2378:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2382
do_concat_2380:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2382
id_morphism_2381:
    b apply_end_2382
apply_end_2382:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2371
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2386
    tst x9, #1
    b.eq do_concat_2385
    tst x0, #1
    b.ne do_compose_2383
do_apply_2384:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2387
do_compose_2383:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2387
do_concat_2385:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2387
id_morphism_2386:
    b apply_end_2387
apply_end_2387:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2391
    tst x9, #1
    b.eq do_concat_2390
    tst x0, #1
    b.ne do_compose_2388
do_apply_2389:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2392
do_compose_2388:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2392
do_concat_2390:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2392
id_morphism_2391:
    b apply_end_2392
apply_end_2392:
    str x0, [sp, #-16]!
    adr x0, str_52
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2396
    tst x9, #1
    b.eq do_concat_2395
    tst x0, #1
    b.ne do_compose_2393
do_apply_2394:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2397
do_compose_2393:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2397
do_concat_2395:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2397
id_morphism_2396:
    b apply_end_2397
apply_end_2397:
    b cond_end_2372
cond_false_2371:
    adr x0, sign_id
cond_end_2372:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2403
    tst x9, #1
    b.eq do_concat_2402
    tst x0, #1
    b.ne do_compose_2400
do_apply_2401:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2404
do_compose_2400:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2404
do_concat_2402:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2404
id_morphism_2403:
    b apply_end_2404
apply_end_2404:
    str x0, [sp, #-16]!
    adr x0, str_53
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2408
    tst x9, #1
    b.eq do_concat_2407
    tst x0, #1
    b.ne do_compose_2405
do_apply_2406:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2409
do_compose_2405:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2409
do_concat_2407:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2409
id_morphism_2408:
    b apply_end_2409
apply_end_2409:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2398
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2413
    tst x9, #1
    b.eq do_concat_2412
    tst x0, #1
    b.ne do_compose_2410
do_apply_2411:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2414
do_compose_2410:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2414
do_concat_2412:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2414
id_morphism_2413:
    b apply_end_2414
apply_end_2414:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2418
    tst x9, #1
    b.eq do_concat_2417
    tst x0, #1
    b.ne do_compose_2415
do_apply_2416:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2419
do_compose_2415:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2419
do_concat_2417:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2419
id_morphism_2418:
    b apply_end_2419
apply_end_2419:
    str x0, [sp, #-16]!
    adr x0, str_54
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2423
    tst x9, #1
    b.eq do_concat_2422
    tst x0, #1
    b.ne do_compose_2420
do_apply_2421:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2424
do_compose_2420:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2424
do_concat_2422:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2424
id_morphism_2423:
    b apply_end_2424
apply_end_2424:
    b cond_end_2399
cond_false_2398:
    adr x0, sign_id
cond_end_2399:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2430
    tst x9, #1
    b.eq do_concat_2429
    tst x0, #1
    b.ne do_compose_2427
do_apply_2428:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2431
do_compose_2427:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2431
do_concat_2429:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2431
id_morphism_2430:
    b apply_end_2431
apply_end_2431:
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2435
    tst x9, #1
    b.eq do_concat_2434
    tst x0, #1
    b.ne do_compose_2432
do_apply_2433:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2436
do_compose_2432:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2436
do_concat_2434:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2436
id_morphism_2435:
    b apply_end_2436
apply_end_2436:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2425
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2440
    tst x9, #1
    b.eq do_concat_2439
    tst x0, #1
    b.ne do_compose_2437
do_apply_2438:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2441
do_compose_2437:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2441
do_concat_2439:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2441
id_morphism_2440:
    b apply_end_2441
apply_end_2441:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2445
    tst x9, #1
    b.eq do_concat_2444
    tst x0, #1
    b.ne do_compose_2442
do_apply_2443:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2446
do_compose_2442:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2446
do_concat_2444:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2446
id_morphism_2445:
    b apply_end_2446
apply_end_2446:
    str x0, [sp, #-16]!
    adr x0, str_55
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2450
    tst x9, #1
    b.eq do_concat_2449
    tst x0, #1
    b.ne do_compose_2447
do_apply_2448:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2451
do_compose_2447:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2451
do_concat_2449:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2451
id_morphism_2450:
    b apply_end_2451
apply_end_2451:
    b cond_end_2426
cond_false_2425:
    adr x0, sign_id
cond_end_2426:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2457
    tst x9, #1
    b.eq do_concat_2456
    tst x0, #1
    b.ne do_compose_2454
do_apply_2455:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2458
do_compose_2454:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2458
do_concat_2456:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2458
id_morphism_2457:
    b apply_end_2458
apply_end_2458:
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2462
    tst x9, #1
    b.eq do_concat_2461
    tst x0, #1
    b.ne do_compose_2459
do_apply_2460:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2463
do_compose_2459:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2463
do_concat_2461:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2463
id_morphism_2462:
    b apply_end_2463
apply_end_2463:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2452
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2467
    tst x9, #1
    b.eq do_concat_2466
    tst x0, #1
    b.ne do_compose_2464
do_apply_2465:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2468
do_compose_2464:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2468
do_concat_2466:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2468
id_morphism_2467:
    b apply_end_2468
apply_end_2468:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2472
    tst x9, #1
    b.eq do_concat_2471
    tst x0, #1
    b.ne do_compose_2469
do_apply_2470:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2473
do_compose_2469:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2473
do_concat_2471:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2473
id_morphism_2472:
    b apply_end_2473
apply_end_2473:
    str x0, [sp, #-16]!
    adr x0, str_56
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2477
    tst x9, #1
    b.eq do_concat_2476
    tst x0, #1
    b.ne do_compose_2474
do_apply_2475:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2478
do_compose_2474:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2478
do_concat_2476:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2478
id_morphism_2477:
    b apply_end_2478
apply_end_2478:
    b cond_end_2453
cond_false_2452:
    adr x0, sign_id
cond_end_2453:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2484
    tst x9, #1
    b.eq do_concat_2483
    tst x0, #1
    b.ne do_compose_2481
do_apply_2482:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2485
do_compose_2481:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2485
do_concat_2483:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2485
id_morphism_2484:
    b apply_end_2485
apply_end_2485:
    str x0, [sp, #-16]!
    adr x0, str_57
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2489
    tst x9, #1
    b.eq do_concat_2488
    tst x0, #1
    b.ne do_compose_2486
do_apply_2487:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2490
do_compose_2486:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2490
do_concat_2488:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2490
id_morphism_2489:
    b apply_end_2490
apply_end_2490:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2479
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2494
    tst x9, #1
    b.eq do_concat_2493
    tst x0, #1
    b.ne do_compose_2491
do_apply_2492:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2495
do_compose_2491:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2495
do_concat_2493:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2495
id_morphism_2494:
    b apply_end_2495
apply_end_2495:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2499
    tst x9, #1
    b.eq do_concat_2498
    tst x0, #1
    b.ne do_compose_2496
do_apply_2497:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2500
do_compose_2496:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2500
do_concat_2498:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2500
id_morphism_2499:
    b apply_end_2500
apply_end_2500:
    str x0, [sp, #-16]!
    adr x0, str_58
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2504
    tst x9, #1
    b.eq do_concat_2503
    tst x0, #1
    b.ne do_compose_2501
do_apply_2502:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2505
do_compose_2501:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2505
do_concat_2503:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2505
id_morphism_2504:
    b apply_end_2505
apply_end_2505:
    b cond_end_2480
cond_false_2479:
    adr x0, sign_id
cond_end_2480:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2511
    tst x9, #1
    b.eq do_concat_2510
    tst x0, #1
    b.ne do_compose_2508
do_apply_2509:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2512
do_compose_2508:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2512
do_concat_2510:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2512
id_morphism_2511:
    b apply_end_2512
apply_end_2512:
    str x0, [sp, #-16]!
    adr x0, str_59
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2516
    tst x9, #1
    b.eq do_concat_2515
    tst x0, #1
    b.ne do_compose_2513
do_apply_2514:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2517
do_compose_2513:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2517
do_concat_2515:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2517
id_morphism_2516:
    b apply_end_2517
apply_end_2517:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2506
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2521
    tst x9, #1
    b.eq do_concat_2520
    tst x0, #1
    b.ne do_compose_2518
do_apply_2519:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2522
do_compose_2518:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2522
do_concat_2520:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2522
id_morphism_2521:
    b apply_end_2522
apply_end_2522:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2526
    tst x9, #1
    b.eq do_concat_2525
    tst x0, #1
    b.ne do_compose_2523
do_apply_2524:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2527
do_compose_2523:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2527
do_concat_2525:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2527
id_morphism_2526:
    b apply_end_2527
apply_end_2527:
    str x0, [sp, #-16]!
    adr x0, str_60
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2531
    tst x9, #1
    b.eq do_concat_2530
    tst x0, #1
    b.ne do_compose_2528
do_apply_2529:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2532
do_compose_2528:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2532
do_concat_2530:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2532
id_morphism_2531:
    b apply_end_2532
apply_end_2532:
    b cond_end_2507
cond_false_2506:
    adr x0, sign_id
cond_end_2507:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2538
    tst x9, #1
    b.eq do_concat_2537
    tst x0, #1
    b.ne do_compose_2535
do_apply_2536:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2539
do_compose_2535:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2539
do_concat_2537:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2539
id_morphism_2538:
    b apply_end_2539
apply_end_2539:
    str x0, [sp, #-16]!
    mov x0, #124
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2543
    tst x9, #1
    b.eq do_concat_2542
    tst x0, #1
    b.ne do_compose_2540
do_apply_2541:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2544
do_compose_2540:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2544
do_concat_2542:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2544
id_morphism_2543:
    b apply_end_2544
apply_end_2544:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2533
    adr x0, compile_logic_or
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2548
    tst x9, #1
    b.eq do_concat_2547
    tst x0, #1
    b.ne do_compose_2545
do_apply_2546:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2549
do_compose_2545:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2549
do_concat_2547:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2549
id_morphism_2548:
    b apply_end_2549
apply_end_2549:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2553
    tst x9, #1
    b.eq do_concat_2552
    tst x0, #1
    b.ne do_compose_2550
do_apply_2551:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2554
do_compose_2550:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2554
do_concat_2552:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2554
id_morphism_2553:
    b apply_end_2554
apply_end_2554:
    b cond_end_2534
cond_false_2533:
    adr x0, sign_id
cond_end_2534:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2560
    tst x9, #1
    b.eq do_concat_2559
    tst x0, #1
    b.ne do_compose_2557
do_apply_2558:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2561
do_compose_2557:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2561
do_concat_2559:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2561
id_morphism_2560:
    b apply_end_2561
apply_end_2561:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2565
    tst x9, #1
    b.eq do_concat_2564
    tst x0, #1
    b.ne do_compose_2562
do_apply_2563:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2566
do_compose_2562:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2566
do_concat_2564:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2566
id_morphism_2565:
    b apply_end_2566
apply_end_2566:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2555
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2570
    tst x9, #1
    b.eq do_concat_2569
    tst x0, #1
    b.ne do_compose_2567
do_apply_2568:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2571
do_compose_2567:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2571
do_concat_2569:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2571
id_morphism_2570:
    b apply_end_2571
apply_end_2571:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2575
    tst x9, #1
    b.eq do_concat_2574
    tst x0, #1
    b.ne do_compose_2572
do_apply_2573:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2576
do_compose_2572:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2576
do_concat_2574:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2576
id_morphism_2575:
    b apply_end_2576
apply_end_2576:
    str x0, [sp, #-16]!
    adr x0, str_62
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2580
    tst x9, #1
    b.eq do_concat_2579
    tst x0, #1
    b.ne do_compose_2577
do_apply_2578:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2581
do_compose_2577:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2581
do_concat_2579:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2581
id_morphism_2580:
    b apply_end_2581
apply_end_2581:
    b cond_end_2556
cond_false_2555:
    adr x0, sign_id
cond_end_2556:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2587
    tst x9, #1
    b.eq do_concat_2586
    tst x0, #1
    b.ne do_compose_2584
do_apply_2585:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2588
do_compose_2584:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2588
do_concat_2586:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2588
id_morphism_2587:
    b apply_end_2588
apply_end_2588:
    str x0, [sp, #-16]!
    mov x0, #38
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2592
    tst x9, #1
    b.eq do_concat_2591
    tst x0, #1
    b.ne do_compose_2589
do_apply_2590:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2593
do_compose_2589:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2593
do_concat_2591:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2593
id_morphism_2592:
    b apply_end_2593
apply_end_2593:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2582
    adr x0, compile_logic_and
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2597
    tst x9, #1
    b.eq do_concat_2596
    tst x0, #1
    b.ne do_compose_2594
do_apply_2595:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2598
do_compose_2594:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2598
do_concat_2596:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2598
id_morphism_2597:
    b apply_end_2598
apply_end_2598:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2602
    tst x9, #1
    b.eq do_concat_2601
    tst x0, #1
    b.ne do_compose_2599
do_apply_2600:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2603
do_compose_2599:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2603
do_concat_2601:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2603
id_morphism_2602:
    b apply_end_2603
apply_end_2603:
    b cond_end_2583
cond_false_2582:
    adr x0, sign_id
cond_end_2583:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2609
    tst x9, #1
    b.eq do_concat_2608
    tst x0, #1
    b.ne do_compose_2606
do_apply_2607:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2610
do_compose_2606:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2610
do_concat_2608:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2610
id_morphism_2609:
    b apply_end_2610
apply_end_2610:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2614
    tst x9, #1
    b.eq do_concat_2613
    tst x0, #1
    b.ne do_compose_2611
do_apply_2612:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2615
do_compose_2611:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2615
do_concat_2613:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2615
id_morphism_2614:
    b apply_end_2615
apply_end_2615:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2604
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2619
    tst x9, #1
    b.eq do_concat_2618
    tst x0, #1
    b.ne do_compose_2616
do_apply_2617:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2620
do_compose_2616:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2620
do_concat_2618:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2620
id_morphism_2619:
    b apply_end_2620
apply_end_2620:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2624
    tst x9, #1
    b.eq do_concat_2623
    tst x0, #1
    b.ne do_compose_2621
do_apply_2622:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2625
do_compose_2621:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2625
do_concat_2623:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2625
id_morphism_2624:
    b apply_end_2625
apply_end_2625:
    str x0, [sp, #-16]!
    adr x0, str_63
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2629
    tst x9, #1
    b.eq do_concat_2628
    tst x0, #1
    b.ne do_compose_2626
do_apply_2627:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2630
do_compose_2626:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2630
do_concat_2628:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2630
id_morphism_2629:
    b apply_end_2630
apply_end_2630:
    b cond_end_2605
cond_false_2604:
    adr x0, sign_id
cond_end_2605:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2636
    tst x9, #1
    b.eq do_concat_2635
    tst x0, #1
    b.ne do_compose_2633
do_apply_2634:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2637
do_compose_2633:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2637
do_concat_2635:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2637
id_morphism_2636:
    b apply_end_2637
apply_end_2637:
    str x0, [sp, #-16]!
    mov x0, #126
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2641
    tst x9, #1
    b.eq do_concat_2640
    tst x0, #1
    b.ne do_compose_2638
do_apply_2639:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2642
do_compose_2638:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2642
do_concat_2640:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2642
id_morphism_2641:
    b apply_end_2642
apply_end_2642:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2631
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2646
    tst x9, #1
    b.eq do_concat_2645
    tst x0, #1
    b.ne do_compose_2643
do_apply_2644:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2647
do_compose_2643:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2647
do_concat_2645:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2647
id_morphism_2646:
    b apply_end_2647
apply_end_2647:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2651
    tst x9, #1
    b.eq do_concat_2650
    tst x0, #1
    b.ne do_compose_2648
do_apply_2649:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2652
do_compose_2648:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2652
do_concat_2650:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2652
id_morphism_2651:
    b apply_end_2652
apply_end_2652:
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2656
    tst x9, #1
    b.eq do_concat_2655
    tst x0, #1
    b.ne do_compose_2653
do_apply_2654:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2657
do_compose_2653:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2657
do_concat_2655:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2657
id_morphism_2656:
    b apply_end_2657
apply_end_2657:
    b cond_end_2632
cond_false_2631:
    adr x0, sign_id
cond_end_2632:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2663
    tst x9, #1
    b.eq do_concat_2662
    tst x0, #1
    b.ne do_compose_2660
do_apply_2661:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2664
do_compose_2660:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2664
do_concat_2662:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2664
id_morphism_2663:
    b apply_end_2664
apply_end_2664:
    str x0, [sp, #-16]!
    adr x0, str_64
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2668
    tst x9, #1
    b.eq do_concat_2667
    tst x0, #1
    b.ne do_compose_2665
do_apply_2666:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2669
do_compose_2665:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2669
do_concat_2667:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2669
id_morphism_2668:
    b apply_end_2669
apply_end_2669:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2658
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2673
    tst x9, #1
    b.eq do_concat_2672
    tst x0, #1
    b.ne do_compose_2670
do_apply_2671:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2674
do_compose_2670:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2674
do_concat_2672:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2674
id_morphism_2673:
    b apply_end_2674
apply_end_2674:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2678
    tst x9, #1
    b.eq do_concat_2677
    tst x0, #1
    b.ne do_compose_2675
do_apply_2676:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2679
do_compose_2675:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2679
do_concat_2677:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2679
id_morphism_2678:
    b apply_end_2679
apply_end_2679:
    str x0, [sp, #-16]!
    adr x0, str_65
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2683
    tst x9, #1
    b.eq do_concat_2682
    tst x0, #1
    b.ne do_compose_2680
do_apply_2681:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2684
do_compose_2680:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2684
do_concat_2682:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2684
id_morphism_2683:
    b apply_end_2684
apply_end_2684:
    b cond_end_2659
cond_false_2658:
    adr x0, sign_id
cond_end_2659:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2690
    tst x9, #1
    b.eq do_concat_2689
    tst x0, #1
    b.ne do_compose_2687
do_apply_2688:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2691
do_compose_2687:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2691
do_concat_2689:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2691
id_morphism_2690:
    b apply_end_2691
apply_end_2691:
    str x0, [sp, #-16]!
    mov x0, #39
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2695
    tst x9, #1
    b.eq do_concat_2694
    tst x0, #1
    b.ne do_compose_2692
do_apply_2693:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2696
do_compose_2692:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2696
do_concat_2694:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2696
id_morphism_2695:
    b apply_end_2696
apply_end_2696:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2685
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2700
    tst x9, #1
    b.eq do_concat_2699
    tst x0, #1
    b.ne do_compose_2697
do_apply_2698:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2701
do_compose_2697:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2701
do_concat_2699:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2701
id_morphism_2700:
    b apply_end_2701
apply_end_2701:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2705
    tst x9, #1
    b.eq do_concat_2704
    tst x0, #1
    b.ne do_compose_2702
do_apply_2703:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2706
do_compose_2702:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2706
do_concat_2704:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2706
id_morphism_2705:
    b apply_end_2706
apply_end_2706:
    str x0, [sp, #-16]!
    adr x0, str_66
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2710
    tst x9, #1
    b.eq do_concat_2709
    tst x0, #1
    b.ne do_compose_2707
do_apply_2708:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2711
do_compose_2707:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2711
do_concat_2709:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2711
id_morphism_2710:
    b apply_end_2711
apply_end_2711:
    b cond_end_2686
cond_false_2685:
    adr x0, sign_id
cond_end_2686:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2717
    tst x9, #1
    b.eq do_concat_2716
    tst x0, #1
    b.ne do_compose_2714
do_apply_2715:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2718
do_compose_2714:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2718
do_concat_2716:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2718
id_morphism_2717:
    b apply_end_2718
apply_end_2718:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2722
    tst x9, #1
    b.eq do_concat_2721
    tst x0, #1
    b.ne do_compose_2719
do_apply_2720:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2723
do_compose_2719:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2723
do_concat_2721:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2723
id_morphism_2722:
    b apply_end_2723
apply_end_2723:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2712
    adr x0, compile_bind
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2727
    tst x9, #1
    b.eq do_concat_2726
    tst x0, #1
    b.ne do_compose_2724
do_apply_2725:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2728
do_compose_2724:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2728
do_concat_2726:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2728
id_morphism_2727:
    b apply_end_2728
apply_end_2728:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2732
    tst x9, #1
    b.eq do_concat_2731
    tst x0, #1
    b.ne do_compose_2729
do_apply_2730:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2733
do_compose_2729:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2733
do_concat_2731:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2733
id_morphism_2732:
    b apply_end_2733
apply_end_2733:
    b cond_end_2713
cond_false_2712:
    adr x0, sign_id
cond_end_2713:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2739
    tst x9, #1
    b.eq do_concat_2738
    tst x0, #1
    b.ne do_compose_2736
do_apply_2737:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2740
do_compose_2736:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2740
do_concat_2738:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2740
id_morphism_2739:
    b apply_end_2740
apply_end_2740:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2744
    tst x9, #1
    b.eq do_concat_2743
    tst x0, #1
    b.ne do_compose_2741
do_apply_2742:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2745
do_compose_2741:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2745
do_concat_2743:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2745
id_morphism_2744:
    b apply_end_2745
apply_end_2745:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2734
    adr x0, compile_lambda
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2749
    tst x9, #1
    b.eq do_concat_2748
    tst x0, #1
    b.ne do_compose_2746
do_apply_2747:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2750
do_compose_2746:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2750
do_concat_2748:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2750
id_morphism_2749:
    b apply_end_2750
apply_end_2750:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2754
    tst x9, #1
    b.eq do_concat_2753
    tst x0, #1
    b.ne do_compose_2751
do_apply_2752:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2755
do_compose_2751:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2755
do_concat_2753:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2755
id_morphism_2754:
    b apply_end_2755
apply_end_2755:
    b cond_end_2735
cond_false_2734:
    adr x0, sign_id
cond_end_2735:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, str_33
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2262
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_67
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2759
    tst x9, #1
    b.eq do_concat_2758
    tst x0, #1
    b.ne do_compose_2756
do_apply_2757:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2760
do_compose_2756:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2760
do_concat_2758:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2760
id_morphism_2759:
    b apply_end_2760
apply_end_2760:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, op
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2764
    tst x9, #1
    b.eq do_concat_2763
    tst x0, #1
    b.ne do_compose_2761
do_apply_2762:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2765
do_compose_2761:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2765
do_concat_2763:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2765
id_morphism_2764:
    b apply_end_2765
apply_end_2765:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2769
    tst x9, #1
    b.eq do_concat_2768
    tst x0, #1
    b.ne do_compose_2766
do_apply_2767:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2770
do_compose_2766:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2770
do_concat_2768:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2770
id_morphism_2769:
    b apply_end_2770
apply_end_2770:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2774
    tst x9, #1
    b.eq do_concat_2773
    tst x0, #1
    b.ne do_compose_2771
do_apply_2772:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2775
do_compose_2771:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2775
do_concat_2773:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2775
id_morphism_2774:
    b apply_end_2775
apply_end_2775:
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
blk_end_2262:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2779
    tst x9, #1
    b.eq do_concat_2778
    tst x0, #1
    b.ne do_compose_2776
do_apply_2777:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2780
do_compose_2776:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2780
do_concat_2778:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2780
id_morphism_2779:
    b apply_end_2780
apply_end_2780:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2259
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2784
    tst x9, #1
    b.eq do_concat_2783
    tst x0, #1
    b.ne do_compose_2781
do_apply_2782:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2785
do_compose_2781:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2785
do_concat_2783:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2785
id_morphism_2784:
    b apply_end_2785
apply_end_2785:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2789
    tst x9, #1
    b.eq do_concat_2788
    tst x0, #1
    b.ne do_compose_2786
do_apply_2787:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2790
do_compose_2786:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2790
do_concat_2788:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2790
id_morphism_2789:
    b apply_end_2790
apply_end_2790:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2794
    tst x9, #1
    b.eq do_concat_2793
    tst x0, #1
    b.ne do_compose_2791
do_apply_2792:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2795
do_compose_2791:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2795
do_concat_2793:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2795
id_morphism_2794:
    b apply_end_2795
apply_end_2795:
blk_end_2259:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2257_2258:
    // Closure for func_2257
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2257
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2255_2256:
    // Closure for func_2255
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2255
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2249
cond_false_2248:
    adr x0, sign_id
cond_end_2249:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_bind
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2801
    tst x9, #1
    b.eq do_concat_2800
    tst x0, #1
    b.ne do_compose_2798
do_apply_2799:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2802
do_compose_2798:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2802
do_concat_2800:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2802
id_morphism_2801:
    b apply_end_2802
apply_end_2802:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2796
    b after_func_2803_2804
func_2803:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2805_2806
func_2805:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2807_2808
func_2807:
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
    b.eq or_right_2810
    b or_end_2811
or_right_2810:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2815
    tst x9, #1
    b.eq do_concat_2814
    tst x0, #1
    b.ne do_compose_2812
do_apply_2813:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2816
do_compose_2812:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2816
do_concat_2814:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2816
id_morphism_2815:
    b apply_end_2816
apply_end_2816:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2820
    tst x9, #1
    b.eq do_concat_2819
    tst x0, #1
    b.ne do_compose_2817
do_apply_2818:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2821
do_compose_2817:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2821
do_concat_2819:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2821
id_morphism_2820:
    b apply_end_2821
apply_end_2821:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2825
    tst x9, #1
    b.eq do_concat_2824
    tst x0, #1
    b.ne do_compose_2822
do_apply_2823:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2826
do_compose_2822:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2826
do_concat_2824:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2826
id_morphism_2825:
    b apply_end_2826
apply_end_2826:
or_end_2811:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2809
    b after_func_2827_2828
func_2827:
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
    b.eq or_right_2830
    b or_end_2831
or_right_2830:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2835
    tst x9, #1
    b.eq do_concat_2834
    tst x0, #1
    b.ne do_compose_2832
do_apply_2833:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2836
do_compose_2832:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2836
do_concat_2834:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2836
id_morphism_2835:
    b apply_end_2836
apply_end_2836:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2840
    tst x9, #1
    b.eq do_concat_2839
    tst x0, #1
    b.ne do_compose_2837
do_apply_2838:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2841
do_compose_2837:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2841
do_concat_2839:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2841
id_morphism_2840:
    b apply_end_2841
apply_end_2841:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2845
    tst x9, #1
    b.eq do_concat_2844
    tst x0, #1
    b.ne do_compose_2842
do_apply_2843:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2846
do_compose_2842:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2846
do_concat_2844:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2846
id_morphism_2845:
    b apply_end_2846
apply_end_2846:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2850
    tst x9, #1
    b.eq do_concat_2849
    tst x0, #1
    b.ne do_compose_2847
do_apply_2848:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2851
do_compose_2847:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2851
do_concat_2849:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2851
id_morphism_2850:
    b apply_end_2851
apply_end_2851:
or_end_2831:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2829
    b after_func_2852_2853
func_2852:
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
    b.eq or_right_2855
    b or_end_2856
or_right_2855:
    adr x0, tok_val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2860
    tst x9, #1
    b.eq do_concat_2859
    tst x0, #1
    b.ne do_compose_2857
do_apply_2858:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2861
do_compose_2857:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2861
do_concat_2859:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2861
id_morphism_2860:
    b apply_end_2861
apply_end_2861:
or_end_2856:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2854
    b after_func_2862_2863
func_2862:
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
    b.eq or_right_2865
    b or_end_2866
or_right_2865:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2870
    tst x9, #1
    b.eq do_concat_2869
    tst x0, #1
    b.ne do_compose_2867
do_apply_2868:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2871
do_compose_2867:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2871
do_concat_2869:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2871
id_morphism_2870:
    b apply_end_2871
apply_end_2871:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2875
    tst x9, #1
    b.eq do_concat_2874
    tst x0, #1
    b.ne do_compose_2872
do_apply_2873:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2876
do_compose_2872:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2876
do_concat_2874:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2876
id_morphism_2875:
    b apply_end_2876
apply_end_2876:
or_end_2866:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2864
    b after_func_2877_2878
func_2877:
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
    b.eq or_right_2880
    b or_end_2881
or_right_2880:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2885
    tst x9, #1
    b.eq do_concat_2884
    tst x0, #1
    b.ne do_compose_2882
do_apply_2883:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2886
do_compose_2882:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2886
do_concat_2884:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2886
id_morphism_2885:
    b apply_end_2886
apply_end_2886:
or_end_2881:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2879
    b after_func_2887_2888
func_2887:
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
    b.eq or_right_2890
    b or_end_2891
or_right_2890:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2895
    tst x9, #1
    b.eq do_concat_2894
    tst x0, #1
    b.ne do_compose_2892
do_apply_2893:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2896
do_compose_2892:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2896
do_concat_2894:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2896
id_morphism_2895:
    b apply_end_2896
apply_end_2896:
or_end_2891:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2889
    b after_func_2897_2898
func_2897:
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
    b.eq or_right_2900
    b or_end_2901
or_right_2900:
    adr x0, push_var
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2905
    tst x9, #1
    b.eq do_concat_2904
    tst x0, #1
    b.ne do_compose_2902
do_apply_2903:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2906
do_compose_2902:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2906
do_concat_2904:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2906
id_morphism_2905:
    b apply_end_2906
apply_end_2906:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2910
    tst x9, #1
    b.eq do_concat_2909
    tst x0, #1
    b.ne do_compose_2907
do_apply_2908:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2911
do_compose_2907:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2911
do_concat_2909:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2911
id_morphism_2910:
    b apply_end_2911
apply_end_2911:
or_end_2901:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2899
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, str_36
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_2899:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2897_2898:
    // Closure for func_2897
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
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2897
    ldr x0, [sp], #16
    bl _cons
blk_end_2889:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2887_2888:
    // Closure for func_2887
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
    adr x1, func_2887
    ldr x0, [sp], #16
    bl _cons
blk_end_2879:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2877_2878:
    // Closure for func_2877
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_2877
    ldr x0, [sp], #16
    bl _cons
blk_end_2864:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2862_2863:
    // Closure for func_2862
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
    adr x1, func_2862
    ldr x0, [sp], #16
    bl _cons
blk_end_2854:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2852_2853:
    // Closure for func_2852
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2852
    ldr x0, [sp], #16
    bl _cons
blk_end_2829:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2827_2828:
    // Closure for func_2827
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
    adr x1, func_2827
    ldr x0, [sp], #16
    bl _cons
blk_end_2809:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2807_2808:
    // Closure for func_2807
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
    adr x1, func_2807
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2805_2806:
    // Closure for func_2805
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2805
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2803_2804:
    // Closure for func_2803
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2803
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2797
cond_false_2796:
    adr x0, sign_id
cond_end_2797:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_lambda
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2917
    tst x9, #1
    b.eq do_concat_2916
    tst x0, #1
    b.ne do_compose_2914
do_apply_2915:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2918
do_compose_2914:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2918
do_concat_2916:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2918
id_morphism_2917:
    b apply_end_2918
apply_end_2918:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2912
    b after_func_2919_2920
func_2919:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2921_2922
func_2921:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2923_2924
func_2923:
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
    b.eq or_right_2926
    b or_end_2927
or_right_2926:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2931
    tst x9, #1
    b.eq do_concat_2930
    tst x0, #1
    b.ne do_compose_2928
do_apply_2929:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2932
do_compose_2928:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2932
do_concat_2930:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2932
id_morphism_2931:
    b apply_end_2932
apply_end_2932:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2936
    tst x9, #1
    b.eq do_concat_2935
    tst x0, #1
    b.ne do_compose_2933
do_apply_2934:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2937
do_compose_2933:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2937
do_concat_2935:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2937
id_morphism_2936:
    b apply_end_2937
apply_end_2937:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2941
    tst x9, #1
    b.eq do_concat_2940
    tst x0, #1
    b.ne do_compose_2938
do_apply_2939:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2942
do_compose_2938:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2942
do_concat_2940:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2942
id_morphism_2941:
    b apply_end_2942
apply_end_2942:
or_end_2927:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2925
    b after_func_2943_2944
func_2943:
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
    b.eq or_right_2946
    b or_end_2947
or_right_2946:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2951
    tst x9, #1
    b.eq do_concat_2950
    tst x0, #1
    b.ne do_compose_2948
do_apply_2949:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2952
do_compose_2948:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2952
do_concat_2950:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2952
id_morphism_2951:
    b apply_end_2952
apply_end_2952:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2956
    tst x9, #1
    b.eq do_concat_2955
    tst x0, #1
    b.ne do_compose_2953
do_apply_2954:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2957
do_compose_2953:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2957
do_concat_2955:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2957
id_morphism_2956:
    b apply_end_2957
apply_end_2957:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2961
    tst x9, #1
    b.eq do_concat_2960
    tst x0, #1
    b.ne do_compose_2958
do_apply_2959:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2962
do_compose_2958:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2962
do_concat_2960:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2962
id_morphism_2961:
    b apply_end_2962
apply_end_2962:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2966
    tst x9, #1
    b.eq do_concat_2965
    tst x0, #1
    b.ne do_compose_2963
do_apply_2964:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2967
do_compose_2963:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2967
do_concat_2965:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2967
id_morphism_2966:
    b apply_end_2967
apply_end_2967:
or_end_2947:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2945
    b after_func_2968_2969
func_2968:
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
    b.eq or_right_2971
    b or_end_2972
or_right_2971:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2976
    tst x9, #1
    b.eq do_concat_2975
    tst x0, #1
    b.ne do_compose_2973
do_apply_2974:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2977
do_compose_2973:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2977
do_concat_2975:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2977
id_morphism_2976:
    b apply_end_2977
apply_end_2977:
    str x0, [sp, #-16]!
    adr x0, str_68
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2981
    tst x9, #1
    b.eq do_concat_2980
    tst x0, #1
    b.ne do_compose_2978
do_apply_2979:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2982
do_compose_2978:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2982
do_concat_2980:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2982
id_morphism_2981:
    b apply_end_2982
apply_end_2982:
or_end_2972:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2970
    b after_func_2983_2984
func_2983:
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
    b.eq or_right_2986
    b or_end_2987
or_right_2986:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_2991
    tst x9, #1
    b.eq do_concat_2990
    tst x0, #1
    b.ne do_compose_2988
do_apply_2989:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2992
do_compose_2988:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_2992
do_concat_2990:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_2992
id_morphism_2991:
    b apply_end_2992
apply_end_2992:
or_end_2987:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2985
    b after_func_2993_2994
func_2993:
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
    b.eq or_right_2996
    b or_end_2997
or_right_2996:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3001
    tst x9, #1
    b.eq do_concat_3000
    tst x0, #1
    b.ne do_compose_2998
do_apply_2999:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3002
do_compose_2998:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3002
do_concat_3000:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3002
id_morphism_3001:
    b apply_end_3002
apply_end_3002:
or_end_2997:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2995
    b after_func_3003_3004
func_3003:
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
    b.eq or_right_3006
    b or_end_3007
or_right_3006:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3011
    tst x9, #1
    b.eq do_concat_3010
    tst x0, #1
    b.ne do_compose_3008
do_apply_3009:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3012
do_compose_3008:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3012
do_concat_3010:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3012
id_morphism_3011:
    b apply_end_3012
apply_end_3012:
    str x0, [sp, #-16]!
    adr x0, str_69
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3016
    tst x9, #1
    b.eq do_concat_3015
    tst x0, #1
    b.ne do_compose_3013
do_apply_3014:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3017
do_compose_3013:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3017
do_concat_3015:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3017
id_morphism_3016:
    b apply_end_3017
apply_end_3017:
or_end_3007:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3005
    b after_func_3018_3019
func_3018:
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
    b.eq or_right_3021
    b or_end_3022
or_right_3021:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3026
    tst x9, #1
    b.eq do_concat_3025
    tst x0, #1
    b.ne do_compose_3023
do_apply_3024:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3027
do_compose_3023:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3027
do_concat_3025:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3027
id_morphism_3026:
    b apply_end_3027
apply_end_3027:
or_end_3022:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3020
    b after_func_3028_3029
func_3028:
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
    b.eq or_right_3031
    b or_end_3032
or_right_3031:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3036
    tst x9, #1
    b.eq do_concat_3035
    tst x0, #1
    b.ne do_compose_3033
do_apply_3034:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3037
do_compose_3033:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3037
do_concat_3035:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3037
id_morphism_3036:
    b apply_end_3037
apply_end_3037:
or_end_3032:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3030
    b after_func_3038_3039
func_3038:
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
    b.eq or_right_3041
    b or_end_3042
or_right_3041:
    adr x0, tok_val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3046
    tst x9, #1
    b.eq do_concat_3045
    tst x0, #1
    b.ne do_compose_3043
do_apply_3044:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3047
do_compose_3043:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3047
do_concat_3045:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3047
id_morphism_3046:
    b apply_end_3047
apply_end_3047:
or_end_3042:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3040
    b after_func_3048_3049
func_3048:
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
    b.eq or_right_3051
    b or_end_3052
or_right_3051:
    adr x0, push_var
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3056
    tst x9, #1
    b.eq do_concat_3055
    tst x0, #1
    b.ne do_compose_3053
do_apply_3054:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3057
do_compose_3053:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3057
do_concat_3055:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3057
id_morphism_3056:
    b apply_end_3057
apply_end_3057:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3061
    tst x9, #1
    b.eq do_concat_3060
    tst x0, #1
    b.ne do_compose_3058
do_apply_3059:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3062
do_compose_3058:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3062
do_concat_3060:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3062
id_morphism_3061:
    b apply_end_3062
apply_end_3062:
or_end_3052:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3050
    b after_func_3063_3064
func_3063:
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
    b.eq or_right_3066
    b or_end_3067
or_right_3066:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3071
    tst x9, #1
    b.eq do_concat_3070
    tst x0, #1
    b.ne do_compose_3068
do_apply_3069:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3072
do_compose_3068:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3072
do_concat_3070:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3072
id_morphism_3071:
    b apply_end_3072
apply_end_3072:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3076
    tst x9, #1
    b.eq do_concat_3075
    tst x0, #1
    b.ne do_compose_3073
do_apply_3074:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3077
do_compose_3073:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3077
do_concat_3075:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3077
id_morphism_3076:
    b apply_end_3077
apply_end_3077:
or_end_3067:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3065
    b after_func_3078_3079
func_3078:
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
    b.eq or_right_3081
    b or_end_3082
or_right_3081:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3086
    tst x9, #1
    b.eq do_concat_3085
    tst x0, #1
    b.ne do_compose_3083
do_apply_3084:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3087
do_compose_3083:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3087
do_concat_3085:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3087
id_morphism_3086:
    b apply_end_3087
apply_end_3087:
or_end_3082:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3080
    b after_func_3088_3089
func_3088:
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
    b.eq or_right_3091
    b or_end_3092
or_right_3091:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3096
    tst x9, #1
    b.eq do_concat_3095
    tst x0, #1
    b.ne do_compose_3093
do_apply_3094:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3097
do_compose_3093:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3097
do_concat_3095:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3097
id_morphism_3096:
    b apply_end_3097
apply_end_3097:
or_end_3092:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3090
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_22
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3101
    tst x9, #1
    b.eq do_concat_3100
    tst x0, #1
    b.ne do_compose_3098
do_apply_3099:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3102
do_compose_3098:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3102
do_concat_3100:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3102
id_morphism_3101:
    b apply_end_3102
apply_end_3102:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3106
    tst x9, #1
    b.eq do_concat_3105
    tst x0, #1
    b.ne do_compose_3103
do_apply_3104:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3107
do_compose_3103:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3107
do_concat_3105:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3107
id_morphism_3106:
    b apply_end_3107
apply_end_3107:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3111
    tst x9, #1
    b.eq do_concat_3110
    tst x0, #1
    b.ne do_compose_3108
do_apply_3109:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3112
do_compose_3108:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3112
do_concat_3110:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3112
id_morphism_3111:
    b apply_end_3112
apply_end_3112:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3116
    tst x9, #1
    b.eq do_concat_3115
    tst x0, #1
    b.ne do_compose_3113
do_apply_3114:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3117
do_compose_3113:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3117
do_concat_3115:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3117
id_morphism_3116:
    b apply_end_3117
apply_end_3117:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3122
    tst x9, #1
    b.eq do_concat_3121
    tst x0, #1
    b.ne do_compose_3119
do_apply_3120:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3123
do_compose_3119:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3123
do_concat_3121:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3123
id_morphism_3122:
    b apply_end_3123
apply_end_3123:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3127
    tst x9, #1
    b.eq do_concat_3126
    tst x0, #1
    b.ne do_compose_3124
do_apply_3125:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3128
do_compose_3124:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3128
do_concat_3126:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3128
id_morphism_3127:
    b apply_end_3128
apply_end_3128:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3118
    adr x0, str_70
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3118
    adr x0, str_71
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3118
    adr x0, str_72
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_3118:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3132
    tst x9, #1
    b.eq do_concat_3131
    tst x0, #1
    b.ne do_compose_3129
do_apply_3130:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3133
do_compose_3129:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3133
do_concat_3131:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3133
id_morphism_3132:
    b apply_end_3133
apply_end_3133:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3090
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3090
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_73
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_74
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3134
    adr x0, str_75
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3134
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3138
    tst x9, #1
    b.eq do_concat_3137
    tst x0, #1
    b.ne do_compose_3135
do_apply_3136:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3139
do_compose_3135:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3139
do_concat_3137:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3139
id_morphism_3138:
    b apply_end_3139
apply_end_3139:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3143
    tst x9, #1
    b.eq do_concat_3142
    tst x0, #1
    b.ne do_compose_3140
do_apply_3141:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3144
do_compose_3140:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3144
do_concat_3142:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3144
id_morphism_3143:
    b apply_end_3144
apply_end_3144:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3134
    adr x0, str_36
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3134
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3134
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_76
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3148
    tst x9, #1
    b.eq do_concat_3147
    tst x0, #1
    b.ne do_compose_3145
do_apply_3146:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3149
do_compose_3145:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3149
do_concat_3147:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3149
id_morphism_3148:
    b apply_end_3149
apply_end_3149:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3153
    tst x9, #1
    b.eq do_concat_3152
    tst x0, #1
    b.ne do_compose_3150
do_apply_3151:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3154
do_compose_3150:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3154
do_concat_3152:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3154
id_morphism_3153:
    b apply_end_3154
apply_end_3154:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3158
    tst x9, #1
    b.eq do_concat_3157
    tst x0, #1
    b.ne do_compose_3155
do_apply_3156:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3159
do_compose_3155:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3159
do_concat_3157:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3159
id_morphism_3158:
    b apply_end_3159
apply_end_3159:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3163
    tst x9, #1
    b.eq do_concat_3162
    tst x0, #1
    b.ne do_compose_3160
do_apply_3161:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3164
do_compose_3160:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3164
do_concat_3162:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3164
id_morphism_3163:
    b apply_end_3164
apply_end_3164:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3134
    adr x0, str_5
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3134
    adr x0, str_63
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3134
    adr x0, str_77
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_3134:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3168
    tst x9, #1
    b.eq do_concat_3167
    tst x0, #1
    b.ne do_compose_3165
do_apply_3166:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3169
do_compose_3165:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3169
do_concat_3167:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3169
id_morphism_3168:
    b apply_end_3169
apply_end_3169:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3173
    tst x9, #1
    b.eq do_concat_3172
    tst x0, #1
    b.ne do_compose_3170
do_apply_3171:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3174
do_compose_3170:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3174
do_concat_3172:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3174
id_morphism_3173:
    b apply_end_3174
apply_end_3174:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_3090:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3088_3089:
    // Closure for func_3088
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
    adr x1, func_3088
    ldr x0, [sp], #16
    bl _cons
blk_end_3080:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3078_3079:
    // Closure for func_3078
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3078
    ldr x0, [sp], #16
    bl _cons
blk_end_3065:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3063_3064:
    // Closure for func_3063
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
    ldr x0, [x29, #-128]
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
    adr x1, func_3063
    ldr x0, [sp], #16
    bl _cons
blk_end_3050:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3048_3049:
    // Closure for func_3048
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
    ldr x0, [x29, #-128]
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
    adr x1, func_3048
    ldr x0, [sp], #16
    bl _cons
blk_end_3040:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3038_3039:
    // Closure for func_3038
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
    ldr x0, [x29, #-128]
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
    adr x1, func_3038
    ldr x0, [sp], #16
    bl _cons
blk_end_3030:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3028_3029:
    // Closure for func_3028
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x1, func_3028
    ldr x0, [sp], #16
    bl _cons
blk_end_3020:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3018_3019:
    // Closure for func_3018
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3018
    ldr x0, [sp], #16
    bl _cons
blk_end_3005:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3003_3004:
    // Closure for func_3003
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3003
    ldr x0, [sp], #16
    bl _cons
blk_end_2995:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2993_2994:
    // Closure for func_2993
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
    adr x1, func_2993
    ldr x0, [sp], #16
    bl _cons
blk_end_2985:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2983_2984:
    // Closure for func_2983
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
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2983
    ldr x0, [sp], #16
    bl _cons
blk_end_2970:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2968_2969:
    // Closure for func_2968
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
    adr x1, func_2968
    ldr x0, [sp], #16
    bl _cons
blk_end_2945:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2943_2944:
    // Closure for func_2943
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
    adr x1, func_2943
    ldr x0, [sp], #16
    bl _cons
blk_end_2925:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2923_2924:
    // Closure for func_2923
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
    adr x1, func_2923
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2921_2922:
    // Closure for func_2921
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2921
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2919_2920:
    // Closure for func_2919
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2919
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2913
cond_false_2912:
    adr x0, sign_id
cond_end_2913:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_binop
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3180
    tst x9, #1
    b.eq do_concat_3179
    tst x0, #1
    b.ne do_compose_3177
do_apply_3178:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3181
do_compose_3177:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3181
do_concat_3179:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3181
id_morphism_3180:
    b apply_end_3181
apply_end_3181:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3175
    b after_func_3182_3183
func_3182:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3184_3185
func_3184:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3186_3187
func_3186:
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
    b after_func_3188_3189
func_3188:
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
    b.eq or_right_3191
    b or_end_3192
or_right_3191:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3196
    tst x9, #1
    b.eq do_concat_3195
    tst x0, #1
    b.ne do_compose_3193
do_apply_3194:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3197
do_compose_3193:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3197
do_concat_3195:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3197
id_morphism_3196:
    b apply_end_3197
apply_end_3197:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3201
    tst x9, #1
    b.eq do_concat_3200
    tst x0, #1
    b.ne do_compose_3198
do_apply_3199:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3202
do_compose_3198:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3202
do_concat_3200:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3202
id_morphism_3201:
    b apply_end_3202
apply_end_3202:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3206
    tst x9, #1
    b.eq do_concat_3205
    tst x0, #1
    b.ne do_compose_3203
do_apply_3204:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3207
do_compose_3203:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3207
do_concat_3205:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3207
id_morphism_3206:
    b apply_end_3207
apply_end_3207:
or_end_3192:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3190
    b after_func_3208_3209
func_3208:
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
    b.eq or_right_3211
    b or_end_3212
or_right_3211:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3216
    tst x9, #1
    b.eq do_concat_3215
    tst x0, #1
    b.ne do_compose_3213
do_apply_3214:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3217
do_compose_3213:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3217
do_concat_3215:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3217
id_morphism_3216:
    b apply_end_3217
apply_end_3217:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3221
    tst x9, #1
    b.eq do_concat_3220
    tst x0, #1
    b.ne do_compose_3218
do_apply_3219:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3222
do_compose_3218:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3222
do_concat_3220:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3222
id_morphism_3221:
    b apply_end_3222
apply_end_3222:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3226
    tst x9, #1
    b.eq do_concat_3225
    tst x0, #1
    b.ne do_compose_3223
do_apply_3224:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3227
do_compose_3223:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3227
do_concat_3225:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3227
id_morphism_3226:
    b apply_end_3227
apply_end_3227:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3231
    tst x9, #1
    b.eq do_concat_3230
    tst x0, #1
    b.ne do_compose_3228
do_apply_3229:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3232
do_compose_3228:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3232
do_concat_3230:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3232
id_morphism_3231:
    b apply_end_3232
apply_end_3232:
or_end_3212:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3210
    b after_func_3233_3234
func_3233:
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
    b.eq or_right_3236
    b or_end_3237
or_right_3236:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3241
    tst x9, #1
    b.eq do_concat_3240
    tst x0, #1
    b.ne do_compose_3238
do_apply_3239:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3242
do_compose_3238:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3242
do_concat_3240:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3242
id_morphism_3241:
    b apply_end_3242
apply_end_3242:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3246
    tst x9, #1
    b.eq do_concat_3245
    tst x0, #1
    b.ne do_compose_3243
do_apply_3244:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3247
do_compose_3243:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3247
do_concat_3245:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3247
id_morphism_3246:
    b apply_end_3247
apply_end_3247:
or_end_3237:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3235
    b after_func_3248_3249
func_3248:
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
    b.eq or_right_3251
    b or_end_3252
or_right_3251:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3256
    tst x9, #1
    b.eq do_concat_3255
    tst x0, #1
    b.ne do_compose_3253
do_apply_3254:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3257
do_compose_3253:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3257
do_concat_3255:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3257
id_morphism_3256:
    b apply_end_3257
apply_end_3257:
or_end_3252:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3250
    b after_func_3258_3259
func_3258:
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
    b.eq or_right_3261
    b or_end_3262
or_right_3261:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3266
    tst x9, #1
    b.eq do_concat_3265
    tst x0, #1
    b.ne do_compose_3263
do_apply_3264:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3267
do_compose_3263:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3267
do_concat_3265:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3267
id_morphism_3266:
    b apply_end_3267
apply_end_3267:
or_end_3262:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3260
    b after_func_3268_3269
func_3268:
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
    b.eq or_right_3271
    b or_end_3272
or_right_3271:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3276
    tst x9, #1
    b.eq do_concat_3275
    tst x0, #1
    b.ne do_compose_3273
do_apply_3274:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3277
do_compose_3273:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3277
do_concat_3275:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3277
id_morphism_3276:
    b apply_end_3277
apply_end_3277:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3281
    tst x9, #1
    b.eq do_concat_3280
    tst x0, #1
    b.ne do_compose_3278
do_apply_3279:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3282
do_compose_3278:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3282
do_concat_3280:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3282
id_morphism_3281:
    b apply_end_3282
apply_end_3282:
or_end_3272:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3270
    b after_func_3283_3284
func_3283:
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
    b.eq or_right_3286
    b or_end_3287
or_right_3286:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3291
    tst x9, #1
    b.eq do_concat_3290
    tst x0, #1
    b.ne do_compose_3288
do_apply_3289:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3292
do_compose_3288:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3292
do_concat_3290:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3292
id_morphism_3291:
    b apply_end_3292
apply_end_3292:
or_end_3287:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3285
    b after_func_3293_3294
func_3293:
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
    b.eq or_right_3296
    b or_end_3297
or_right_3296:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3301
    tst x9, #1
    b.eq do_concat_3300
    tst x0, #1
    b.ne do_compose_3298
do_apply_3299:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3302
do_compose_3298:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3302
do_concat_3300:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3302
id_morphism_3301:
    b apply_end_3302
apply_end_3302:
or_end_3297:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3295
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_4
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_5
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3303
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_3303:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3307
    tst x9, #1
    b.eq do_concat_3306
    tst x0, #1
    b.ne do_compose_3304
do_apply_3305:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3308
do_compose_3304:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3308
do_concat_3306:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3308
id_morphism_3307:
    b apply_end_3308
apply_end_3308:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3312
    tst x9, #1
    b.eq do_concat_3311
    tst x0, #1
    b.ne do_compose_3309
do_apply_3310:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3313
do_compose_3309:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3313
do_concat_3311:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3313
id_morphism_3312:
    b apply_end_3313
apply_end_3313:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3317
    tst x9, #1
    b.eq do_concat_3316
    tst x0, #1
    b.ne do_compose_3314
do_apply_3315:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3318
do_compose_3314:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3318
do_concat_3316:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3318
id_morphism_3317:
    b apply_end_3318
apply_end_3318:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3322
    tst x9, #1
    b.eq do_concat_3321
    tst x0, #1
    b.ne do_compose_3319
do_apply_3320:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3323
do_compose_3319:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3323
do_concat_3321:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3323
id_morphism_3322:
    b apply_end_3323
apply_end_3323:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_3295:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3293_3294:
    // Closure for func_3293
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_3293
    ldr x0, [sp], #16
    bl _cons
blk_end_3285:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3283_3284:
    // Closure for func_3283
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3283
    ldr x0, [sp], #16
    bl _cons
blk_end_3270:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3268_3269:
    // Closure for func_3268
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
    ldr x0, [x29, #-112]
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
    adr x1, func_3268
    ldr x0, [sp], #16
    bl _cons
blk_end_3260:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3258_3259:
    // Closure for func_3258
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_3258
    ldr x0, [sp], #16
    bl _cons
blk_end_3250:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3248_3249:
    // Closure for func_3248
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3248
    ldr x0, [sp], #16
    bl _cons
blk_end_3235:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3233_3234:
    // Closure for func_3233
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x1, func_3233
    ldr x0, [sp], #16
    bl _cons
blk_end_3210:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3208_3209:
    // Closure for func_3208
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
    ldr x0, [x29, #-96]
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
    adr x1, func_3208
    ldr x0, [sp], #16
    bl _cons
blk_end_3190:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3188_3189:
    // Closure for func_3188
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
    adr x1, func_3188
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3186_3187:
    // Closure for func_3186
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
    adr x1, func_3186
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3184_3185:
    // Closure for func_3184
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3184
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3182_3183:
    // Closure for func_3182
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3182
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3176
cond_false_3175:
    adr x0, sign_id
cond_end_3176:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_cmp
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3329
    tst x9, #1
    b.eq do_concat_3328
    tst x0, #1
    b.ne do_compose_3326
do_apply_3327:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3330
do_compose_3326:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3330
do_concat_3328:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3330
id_morphism_3329:
    b apply_end_3330
apply_end_3330:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3324
    b after_func_3331_3332
func_3331:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3333_3334
func_3333:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3335_3336
func_3335:
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
    b after_func_3337_3338
func_3337:
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
    b.eq or_right_3340
    b or_end_3341
or_right_3340:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3345
    tst x9, #1
    b.eq do_concat_3344
    tst x0, #1
    b.ne do_compose_3342
do_apply_3343:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3346
do_compose_3342:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3346
do_concat_3344:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3346
id_morphism_3345:
    b apply_end_3346
apply_end_3346:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3350
    tst x9, #1
    b.eq do_concat_3349
    tst x0, #1
    b.ne do_compose_3347
do_apply_3348:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3351
do_compose_3347:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3351
do_concat_3349:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3351
id_morphism_3350:
    b apply_end_3351
apply_end_3351:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3355
    tst x9, #1
    b.eq do_concat_3354
    tst x0, #1
    b.ne do_compose_3352
do_apply_3353:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3356
do_compose_3352:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3356
do_concat_3354:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3356
id_morphism_3355:
    b apply_end_3356
apply_end_3356:
or_end_3341:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3339
    b after_func_3357_3358
func_3357:
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
    b.eq or_right_3360
    b or_end_3361
or_right_3360:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3365
    tst x9, #1
    b.eq do_concat_3364
    tst x0, #1
    b.ne do_compose_3362
do_apply_3363:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3366
do_compose_3362:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3366
do_concat_3364:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3366
id_morphism_3365:
    b apply_end_3366
apply_end_3366:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3370
    tst x9, #1
    b.eq do_concat_3369
    tst x0, #1
    b.ne do_compose_3367
do_apply_3368:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3371
do_compose_3367:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3371
do_concat_3369:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3371
id_morphism_3370:
    b apply_end_3371
apply_end_3371:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3375
    tst x9, #1
    b.eq do_concat_3374
    tst x0, #1
    b.ne do_compose_3372
do_apply_3373:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3376
do_compose_3372:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3376
do_concat_3374:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3376
id_morphism_3375:
    b apply_end_3376
apply_end_3376:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3380
    tst x9, #1
    b.eq do_concat_3379
    tst x0, #1
    b.ne do_compose_3377
do_apply_3378:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3381
do_compose_3377:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3381
do_concat_3379:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3381
id_morphism_3380:
    b apply_end_3381
apply_end_3381:
or_end_3361:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3359
    b after_func_3382_3383
func_3382:
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
    b.eq or_right_3385
    b or_end_3386
or_right_3385:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3390
    tst x9, #1
    b.eq do_concat_3389
    tst x0, #1
    b.ne do_compose_3387
do_apply_3388:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3391
do_compose_3387:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3391
do_concat_3389:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3391
id_morphism_3390:
    b apply_end_3391
apply_end_3391:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3395
    tst x9, #1
    b.eq do_concat_3394
    tst x0, #1
    b.ne do_compose_3392
do_apply_3393:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3396
do_compose_3392:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3396
do_concat_3394:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3396
id_morphism_3395:
    b apply_end_3396
apply_end_3396:
or_end_3386:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3384
    b after_func_3397_3398
func_3397:
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
    b.eq or_right_3400
    b or_end_3401
or_right_3400:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3405
    tst x9, #1
    b.eq do_concat_3404
    tst x0, #1
    b.ne do_compose_3402
do_apply_3403:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3406
do_compose_3402:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3406
do_concat_3404:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3406
id_morphism_3405:
    b apply_end_3406
apply_end_3406:
or_end_3401:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3399
    b after_func_3407_3408
func_3407:
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
    b.eq or_right_3410
    b or_end_3411
or_right_3410:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3415
    tst x9, #1
    b.eq do_concat_3414
    tst x0, #1
    b.ne do_compose_3412
do_apply_3413:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3416
do_compose_3412:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3416
do_concat_3414:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3416
id_morphism_3415:
    b apply_end_3416
apply_end_3416:
or_end_3411:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3409
    b after_func_3417_3418
func_3417:
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
    b.eq or_right_3420
    b or_end_3421
or_right_3420:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3425
    tst x9, #1
    b.eq do_concat_3424
    tst x0, #1
    b.ne do_compose_3422
do_apply_3423:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3426
do_compose_3422:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3426
do_concat_3424:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3426
id_morphism_3425:
    b apply_end_3426
apply_end_3426:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3430
    tst x9, #1
    b.eq do_concat_3429
    tst x0, #1
    b.ne do_compose_3427
do_apply_3428:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3431
do_compose_3427:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3431
do_concat_3429:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3431
id_morphism_3430:
    b apply_end_3431
apply_end_3431:
or_end_3421:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3419
    b after_func_3432_3433
func_3432:
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
    b.eq or_right_3435
    b or_end_3436
or_right_3435:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3440
    tst x9, #1
    b.eq do_concat_3439
    tst x0, #1
    b.ne do_compose_3437
do_apply_3438:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3441
do_compose_3437:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3441
do_concat_3439:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3441
id_morphism_3440:
    b apply_end_3441
apply_end_3441:
or_end_3436:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3434
    b after_func_3442_3443
func_3442:
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
    b.eq or_right_3445
    b or_end_3446
or_right_3445:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3450
    tst x9, #1
    b.eq do_concat_3449
    tst x0, #1
    b.ne do_compose_3447
do_apply_3448:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3451
do_compose_3447:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3451
do_concat_3449:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3451
id_morphism_3450:
    b apply_end_3451
apply_end_3451:
or_end_3446:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3444
    b after_func_3452_3453
func_3452:
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
    b.eq or_right_3455
    b or_end_3456
or_right_3455:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3460
    tst x9, #1
    b.eq do_concat_3459
    tst x0, #1
    b.ne do_compose_3457
do_apply_3458:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3461
do_compose_3457:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3461
do_concat_3459:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3461
id_morphism_3460:
    b apply_end_3461
apply_end_3461:
    str x0, [sp, #-16]!
    adr x0, str_78
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3465
    tst x9, #1
    b.eq do_concat_3464
    tst x0, #1
    b.ne do_compose_3462
do_apply_3463:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3466
do_compose_3462:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3466
do_concat_3464:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3466
id_morphism_3465:
    b apply_end_3466
apply_end_3466:
or_end_3456:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3454
    b after_func_3467_3468
func_3467:
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
    b.eq or_right_3470
    b or_end_3471
or_right_3470:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3475
    tst x9, #1
    b.eq do_concat_3474
    tst x0, #1
    b.ne do_compose_3472
do_apply_3473:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3476
do_compose_3472:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3476
do_concat_3474:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3476
id_morphism_3475:
    b apply_end_3476
apply_end_3476:
or_end_3471:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3469
    b after_func_3477_3478
func_3477:
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
    b.eq or_right_3480
    b or_end_3481
or_right_3480:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3485
    tst x9, #1
    b.eq do_concat_3484
    tst x0, #1
    b.ne do_compose_3482
do_apply_3483:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3486
do_compose_3482:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3486
do_concat_3484:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3486
id_morphism_3485:
    b apply_end_3486
apply_end_3486:
    str x0, [sp, #-16]!
    adr x0, str_79
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3490
    tst x9, #1
    b.eq do_concat_3489
    tst x0, #1
    b.ne do_compose_3487
do_apply_3488:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3491
do_compose_3487:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3491
do_concat_3489:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3491
id_morphism_3490:
    b apply_end_3491
apply_end_3491:
or_end_3481:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3479
    b after_func_3492_3493
func_3492:
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
    b.eq or_right_3495
    b or_end_3496
or_right_3495:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3500
    tst x9, #1
    b.eq do_concat_3499
    tst x0, #1
    b.ne do_compose_3497
do_apply_3498:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3501
do_compose_3497:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3501
do_concat_3499:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3501
id_morphism_3500:
    b apply_end_3501
apply_end_3501:
or_end_3496:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3494
    b after_func_3502_3503
func_3502:
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_3505
    b or_end_3506
or_right_3505:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3510
    tst x9, #1
    b.eq do_concat_3509
    tst x0, #1
    b.ne do_compose_3507
do_apply_3508:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3511
do_compose_3507:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3511
do_concat_3509:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3511
id_morphism_3510:
    b apply_end_3511
apply_end_3511:
or_end_3506:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3504
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_4
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_5
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3512
    adr x0, str_80
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3512
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_81
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3516
    tst x9, #1
    b.eq do_concat_3515
    tst x0, #1
    b.ne do_compose_3513
do_apply_3514:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3517
do_compose_3513:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3517
do_concat_3515:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3517
id_morphism_3516:
    b apply_end_3517
apply_end_3517:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3521
    tst x9, #1
    b.eq do_concat_3520
    tst x0, #1
    b.ne do_compose_3518
do_apply_3519:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3522
do_compose_3518:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3522
do_concat_3520:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3522
id_morphism_3521:
    b apply_end_3522
apply_end_3522:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #32
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3526
    tst x9, #1
    b.eq do_concat_3525
    tst x0, #1
    b.ne do_compose_3523
do_apply_3524:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3527
do_compose_3523:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3527
do_concat_3525:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3527
id_morphism_3526:
    b apply_end_3527
apply_end_3527:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3531
    tst x9, #1
    b.eq do_concat_3530
    tst x0, #1
    b.ne do_compose_3528
do_apply_3529:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3532
do_compose_3528:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3532
do_concat_3530:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3532
id_morphism_3531:
    b apply_end_3532
apply_end_3532:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3536
    tst x9, #1
    b.eq do_concat_3535
    tst x0, #1
    b.ne do_compose_3533
do_apply_3534:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3537
do_compose_3533:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3537
do_concat_3535:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3537
id_morphism_3536:
    b apply_end_3537
apply_end_3537:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3541
    tst x9, #1
    b.eq do_concat_3540
    tst x0, #1
    b.ne do_compose_3538
do_apply_3539:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3542
do_compose_3538:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3542
do_concat_3540:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3542
id_morphism_3541:
    b apply_end_3542
apply_end_3542:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3546
    tst x9, #1
    b.eq do_concat_3545
    tst x0, #1
    b.ne do_compose_3543
do_apply_3544:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3547
do_compose_3543:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3547
do_concat_3545:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3547
id_morphism_3546:
    b apply_end_3547
apply_end_3547:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3551
    tst x9, #1
    b.eq do_concat_3550
    tst x0, #1
    b.ne do_compose_3548
do_apply_3549:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3552
do_compose_3548:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3552
do_concat_3550:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3552
id_morphism_3551:
    b apply_end_3552
apply_end_3552:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3512
    adr x0, str_45
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3512
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_22
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3556
    tst x9, #1
    b.eq do_concat_3555
    tst x0, #1
    b.ne do_compose_3553
do_apply_3554:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3557
do_compose_3553:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3557
do_concat_3555:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3557
id_morphism_3556:
    b apply_end_3557
apply_end_3557:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3561
    tst x9, #1
    b.eq do_concat_3560
    tst x0, #1
    b.ne do_compose_3558
do_apply_3559:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3562
do_compose_3558:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3562
do_concat_3560:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3562
id_morphism_3561:
    b apply_end_3562
apply_end_3562:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3566
    tst x9, #1
    b.eq do_concat_3565
    tst x0, #1
    b.ne do_compose_3563
do_apply_3564:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3567
do_compose_3563:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3567
do_concat_3565:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3567
id_morphism_3566:
    b apply_end_3567
apply_end_3567:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3571
    tst x9, #1
    b.eq do_concat_3570
    tst x0, #1
    b.ne do_compose_3568
do_apply_3569:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3572
do_compose_3568:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3572
do_concat_3570:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3572
id_morphism_3571:
    b apply_end_3572
apply_end_3572:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3512
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3576
    tst x9, #1
    b.eq do_concat_3575
    tst x0, #1
    b.ne do_compose_3573
do_apply_3574:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3577
do_compose_3573:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3577
do_concat_3575:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3577
id_morphism_3576:
    b apply_end_3577
apply_end_3577:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3581
    tst x9, #1
    b.eq do_concat_3580
    tst x0, #1
    b.ne do_compose_3578
do_apply_3579:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3582
do_compose_3578:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3582
do_concat_3580:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3582
id_morphism_3581:
    b apply_end_3582
apply_end_3582:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3512
    b after_func_3583_3584
func_3583:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3585_3586
func_3585:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_25
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_3587
    b or_end_3588
or_right_3587:
    mov x0, #0
or_end_3588:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3585_3586:
    // Closure for func_3585
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3585
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3583_3584:
    // Closure for func_3583
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3583
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3592
    tst x9, #1
    b.eq do_concat_3591
    tst x0, #1
    b.ne do_compose_3589
do_apply_3590:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3593
do_compose_3589:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3593
do_concat_3591:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3593
id_morphism_3592:
    b apply_end_3593
apply_end_3593:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3597
    tst x9, #1
    b.eq do_concat_3596
    tst x0, #1
    b.ne do_compose_3594
do_apply_3595:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3598
do_compose_3594:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3598
do_concat_3596:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3598
id_morphism_3597:
    b apply_end_3598
apply_end_3598:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3602
    tst x9, #1
    b.eq do_concat_3601
    tst x0, #1
    b.ne do_compose_3599
do_apply_3600:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3603
do_compose_3599:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3603
do_concat_3601:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3603
id_morphism_3602:
    b apply_end_3603
apply_end_3603:
blk_end_3512:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3607
    tst x9, #1
    b.eq do_concat_3606
    tst x0, #1
    b.ne do_compose_3604
do_apply_3605:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3608
do_compose_3604:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3608
do_concat_3606:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3608
id_morphism_3607:
    b apply_end_3608
apply_end_3608:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3612
    tst x9, #1
    b.eq do_concat_3611
    tst x0, #1
    b.ne do_compose_3609
do_apply_3610:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3613
do_compose_3609:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3613
do_concat_3611:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3613
id_morphism_3612:
    b apply_end_3613
apply_end_3613:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3617
    tst x9, #1
    b.eq do_concat_3616
    tst x0, #1
    b.ne do_compose_3614
do_apply_3615:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3618
do_compose_3614:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3618
do_concat_3616:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3618
id_morphism_3617:
    b apply_end_3618
apply_end_3618:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3622
    tst x9, #1
    b.eq do_concat_3621
    tst x0, #1
    b.ne do_compose_3619
do_apply_3620:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3623
do_compose_3619:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3623
do_concat_3621:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3623
id_morphism_3622:
    b apply_end_3623
apply_end_3623:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_3504:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3502_3503:
    // Closure for func_3502
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
    adr x1, func_3502
    ldr x0, [sp], #16
    bl _cons
blk_end_3494:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3492_3493:
    // Closure for func_3492
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
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3492
    ldr x0, [sp], #16
    bl _cons
blk_end_3479:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3477_3478:
    // Closure for func_3477
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
    adr x1, func_3477
    ldr x0, [sp], #16
    bl _cons
blk_end_3469:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3467_3468:
    // Closure for func_3467
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3467
    ldr x0, [sp], #16
    bl _cons
blk_end_3454:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3452_3453:
    // Closure for func_3452
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3452
    ldr x0, [sp], #16
    bl _cons
blk_end_3444:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3442_3443:
    // Closure for func_3442
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_3442
    ldr x0, [sp], #16
    bl _cons
blk_end_3434:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3432_3433:
    // Closure for func_3432
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3432
    ldr x0, [sp], #16
    bl _cons
blk_end_3419:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3417_3418:
    // Closure for func_3417
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
    ldr x0, [x29, #-112]
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
    adr x1, func_3417
    ldr x0, [sp], #16
    bl _cons
blk_end_3409:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3407_3408:
    // Closure for func_3407
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x1, func_3407
    ldr x0, [sp], #16
    bl _cons
blk_end_3399:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3397_3398:
    // Closure for func_3397
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3397
    ldr x0, [sp], #16
    bl _cons
blk_end_3384:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3382_3383:
    // Closure for func_3382
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x1, func_3382
    ldr x0, [sp], #16
    bl _cons
blk_end_3359:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3357_3358:
    // Closure for func_3357
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
    ldr x0, [x29, #-96]
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
    adr x1, func_3357
    ldr x0, [sp], #16
    bl _cons
blk_end_3339:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3337_3338:
    // Closure for func_3337
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
    adr x1, func_3337
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3335_3336:
    // Closure for func_3335
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
    adr x1, func_3335
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3333_3334:
    // Closure for func_3333
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3333
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3331_3332:
    // Closure for func_3331
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3331
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3325
cond_false_3324:
    adr x0, sign_id
cond_end_3325:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_logic_or
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3629
    tst x9, #1
    b.eq do_concat_3628
    tst x0, #1
    b.ne do_compose_3626
do_apply_3627:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3630
do_compose_3626:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3630
do_concat_3628:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3630
id_morphism_3629:
    b apply_end_3630
apply_end_3630:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3624
    b after_func_3631_3632
func_3631:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    b after_func_3635_3636
func_3635:
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
    b.eq or_right_3638
    b or_end_3639
or_right_3638:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3643
    tst x9, #1
    b.eq do_concat_3642
    tst x0, #1
    b.ne do_compose_3640
do_apply_3641:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3644
do_compose_3640:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3644
do_concat_3642:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3644
id_morphism_3643:
    b apply_end_3644
apply_end_3644:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3648
    tst x9, #1
    b.eq do_concat_3647
    tst x0, #1
    b.ne do_compose_3645
do_apply_3646:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3649
do_compose_3645:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3649
do_concat_3647:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3649
id_morphism_3648:
    b apply_end_3649
apply_end_3649:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3653
    tst x9, #1
    b.eq do_concat_3652
    tst x0, #1
    b.ne do_compose_3650
do_apply_3651:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3654
do_compose_3650:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3654
do_concat_3652:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3654
id_morphism_3653:
    b apply_end_3654
apply_end_3654:
or_end_3639:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3637
    b after_func_3655_3656
func_3655:
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
    b.eq or_right_3658
    b or_end_3659
or_right_3658:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3663
    tst x9, #1
    b.eq do_concat_3662
    tst x0, #1
    b.ne do_compose_3660
do_apply_3661:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3664
do_compose_3660:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3664
do_concat_3662:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3664
id_morphism_3663:
    b apply_end_3664
apply_end_3664:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3668
    tst x9, #1
    b.eq do_concat_3667
    tst x0, #1
    b.ne do_compose_3665
do_apply_3666:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3669
do_compose_3665:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3669
do_concat_3667:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3669
id_morphism_3668:
    b apply_end_3669
apply_end_3669:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3673
    tst x9, #1
    b.eq do_concat_3672
    tst x0, #1
    b.ne do_compose_3670
do_apply_3671:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3674
do_compose_3670:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3674
do_concat_3672:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3674
id_morphism_3673:
    b apply_end_3674
apply_end_3674:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3678
    tst x9, #1
    b.eq do_concat_3677
    tst x0, #1
    b.ne do_compose_3675
do_apply_3676:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3679
do_compose_3675:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3679
do_concat_3677:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3679
id_morphism_3678:
    b apply_end_3679
apply_end_3679:
or_end_3659:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3657
    b after_func_3680_3681
func_3680:
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
    b.eq or_right_3683
    b or_end_3684
or_right_3683:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3688
    tst x9, #1
    b.eq do_concat_3687
    tst x0, #1
    b.ne do_compose_3685
do_apply_3686:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3689
do_compose_3685:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3689
do_concat_3687:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3689
id_morphism_3688:
    b apply_end_3689
apply_end_3689:
    str x0, [sp, #-16]!
    adr x0, str_82
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3693
    tst x9, #1
    b.eq do_concat_3692
    tst x0, #1
    b.ne do_compose_3690
do_apply_3691:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3694
do_compose_3690:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3694
do_concat_3692:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3694
id_morphism_3693:
    b apply_end_3694
apply_end_3694:
or_end_3684:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3682
    b after_func_3695_3696
func_3695:
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
    b.eq or_right_3698
    b or_end_3699
or_right_3698:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3703
    tst x9, #1
    b.eq do_concat_3702
    tst x0, #1
    b.ne do_compose_3700
do_apply_3701:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3704
do_compose_3700:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3704
do_concat_3702:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3704
id_morphism_3703:
    b apply_end_3704
apply_end_3704:
or_end_3699:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3697
    b after_func_3705_3706
func_3705:
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
    b.eq or_right_3708
    b or_end_3709
or_right_3708:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3713
    tst x9, #1
    b.eq do_concat_3712
    tst x0, #1
    b.ne do_compose_3710
do_apply_3711:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3714
do_compose_3710:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3714
do_concat_3712:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3714
id_morphism_3713:
    b apply_end_3714
apply_end_3714:
    str x0, [sp, #-16]!
    adr x0, str_83
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3718
    tst x9, #1
    b.eq do_concat_3717
    tst x0, #1
    b.ne do_compose_3715
do_apply_3716:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3719
do_compose_3715:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3719
do_concat_3717:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3719
id_morphism_3718:
    b apply_end_3719
apply_end_3719:
or_end_3709:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3707
    b after_func_3720_3721
func_3720:
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
    b.eq or_right_3723
    b or_end_3724
or_right_3723:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3728
    tst x9, #1
    b.eq do_concat_3727
    tst x0, #1
    b.ne do_compose_3725
do_apply_3726:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3729
do_compose_3725:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3729
do_concat_3727:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3729
id_morphism_3728:
    b apply_end_3729
apply_end_3729:
or_end_3724:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3722
    b after_func_3730_3731
func_3730:
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
    b.eq or_right_3733
    b or_end_3734
or_right_3733:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3738
    tst x9, #1
    b.eq do_concat_3737
    tst x0, #1
    b.ne do_compose_3735
do_apply_3736:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3739
do_compose_3735:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3739
do_concat_3737:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3739
id_morphism_3738:
    b apply_end_3739
apply_end_3739:
or_end_3734:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3732
    b after_func_3740_3741
func_3740:
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
    b.eq or_right_3743
    b or_end_3744
or_right_3743:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3748
    tst x9, #1
    b.eq do_concat_3747
    tst x0, #1
    b.ne do_compose_3745
do_apply_3746:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3749
do_compose_3745:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3749
do_concat_3747:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3749
id_morphism_3748:
    b apply_end_3749
apply_end_3749:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3753
    tst x9, #1
    b.eq do_concat_3752
    tst x0, #1
    b.ne do_compose_3750
do_apply_3751:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3754
do_compose_3750:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3754
do_concat_3752:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3754
id_morphism_3753:
    b apply_end_3754
apply_end_3754:
or_end_3744:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3742
    b after_func_3755_3756
func_3755:
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
    b.eq or_right_3758
    b or_end_3759
or_right_3758:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3763
    tst x9, #1
    b.eq do_concat_3762
    tst x0, #1
    b.ne do_compose_3760
do_apply_3761:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3764
do_compose_3760:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3764
do_concat_3762:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3764
id_morphism_3763:
    b apply_end_3764
apply_end_3764:
or_end_3759:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3757
    b after_func_3765_3766
func_3765:
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
    b.eq or_right_3768
    b or_end_3769
or_right_3768:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3773
    tst x9, #1
    b.eq do_concat_3772
    tst x0, #1
    b.ne do_compose_3770
do_apply_3771:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3774
do_compose_3770:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3774
do_concat_3772:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3774
id_morphism_3773:
    b apply_end_3774
apply_end_3774:
or_end_3769:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3767
    b after_func_3775_3776
func_3775:
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
    b.eq or_right_3778
    b or_end_3779
or_right_3778:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3783
    tst x9, #1
    b.eq do_concat_3782
    tst x0, #1
    b.ne do_compose_3780
do_apply_3781:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3784
do_compose_3780:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3784
do_concat_3782:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3784
id_morphism_3783:
    b apply_end_3784
apply_end_3784:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3788
    tst x9, #1
    b.eq do_concat_3787
    tst x0, #1
    b.ne do_compose_3785
do_apply_3786:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3789
do_compose_3785:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3789
do_concat_3787:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3789
id_morphism_3788:
    b apply_end_3789
apply_end_3789:
or_end_3779:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3777
    b after_func_3790_3791
func_3790:
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
    b.eq or_right_3793
    b or_end_3794
or_right_3793:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3798
    tst x9, #1
    b.eq do_concat_3797
    tst x0, #1
    b.ne do_compose_3795
do_apply_3796:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3799
do_compose_3795:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3799
do_concat_3797:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3799
id_morphism_3798:
    b apply_end_3799
apply_end_3799:
or_end_3794:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3792
    b after_func_3800_3801
func_3800:
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
    b.eq or_right_3803
    b or_end_3804
or_right_3803:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3808
    tst x9, #1
    b.eq do_concat_3807
    tst x0, #1
    b.ne do_compose_3805
do_apply_3806:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3809
do_compose_3805:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3809
do_concat_3807:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3809
id_morphism_3808:
    b apply_end_3809
apply_end_3809:
or_end_3804:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3802
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_43
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_44
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3810
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_13
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3814
    tst x9, #1
    b.eq do_concat_3813
    tst x0, #1
    b.ne do_compose_3811
do_apply_3812:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3815
do_compose_3811:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3815
do_concat_3813:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3815
id_morphism_3814:
    b apply_end_3815
apply_end_3815:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3819
    tst x9, #1
    b.eq do_concat_3818
    tst x0, #1
    b.ne do_compose_3816
do_apply_3817:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3820
do_compose_3816:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3820
do_concat_3818:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3820
id_morphism_3819:
    b apply_end_3820
apply_end_3820:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3824
    tst x9, #1
    b.eq do_concat_3823
    tst x0, #1
    b.ne do_compose_3821
do_apply_3822:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3825
do_compose_3821:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3825
do_concat_3823:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3825
id_morphism_3824:
    b apply_end_3825
apply_end_3825:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3829
    tst x9, #1
    b.eq do_concat_3828
    tst x0, #1
    b.ne do_compose_3826
do_apply_3827:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3830
do_compose_3826:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3830
do_concat_3828:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3830
id_morphism_3829:
    b apply_end_3830
apply_end_3830:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3810
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_22
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3834
    tst x9, #1
    b.eq do_concat_3833
    tst x0, #1
    b.ne do_compose_3831
do_apply_3832:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3835
do_compose_3831:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3835
do_concat_3833:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3835
id_morphism_3834:
    b apply_end_3835
apply_end_3835:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3839
    tst x9, #1
    b.eq do_concat_3838
    tst x0, #1
    b.ne do_compose_3836
do_apply_3837:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3840
do_compose_3836:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3840
do_concat_3838:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3840
id_morphism_3839:
    b apply_end_3840
apply_end_3840:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3844
    tst x9, #1
    b.eq do_concat_3843
    tst x0, #1
    b.ne do_compose_3841
do_apply_3842:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3845
do_compose_3841:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3845
do_concat_3843:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3845
id_morphism_3844:
    b apply_end_3845
apply_end_3845:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3849
    tst x9, #1
    b.eq do_concat_3848
    tst x0, #1
    b.ne do_compose_3846
do_apply_3847:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3850
do_compose_3846:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3850
do_concat_3848:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3850
id_morphism_3849:
    b apply_end_3850
apply_end_3850:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3810
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3854
    tst x9, #1
    b.eq do_concat_3853
    tst x0, #1
    b.ne do_compose_3851
do_apply_3852:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3855
do_compose_3851:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3855
do_concat_3853:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3855
id_morphism_3854:
    b apply_end_3855
apply_end_3855:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3859
    tst x9, #1
    b.eq do_concat_3858
    tst x0, #1
    b.ne do_compose_3856
do_apply_3857:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3860
do_compose_3856:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3860
do_concat_3858:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3860
id_morphism_3859:
    b apply_end_3860
apply_end_3860:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3810
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3864
    tst x9, #1
    b.eq do_concat_3863
    tst x0, #1
    b.ne do_compose_3861
do_apply_3862:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3865
do_compose_3861:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3865
do_concat_3863:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3865
id_morphism_3864:
    b apply_end_3865
apply_end_3865:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3869
    tst x9, #1
    b.eq do_concat_3868
    tst x0, #1
    b.ne do_compose_3866
do_apply_3867:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3870
do_compose_3866:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3870
do_concat_3868:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3870
id_morphism_3869:
    b apply_end_3870
apply_end_3870:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _concat
blk_end_3810:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3874
    tst x9, #1
    b.eq do_concat_3873
    tst x0, #1
    b.ne do_compose_3871
do_apply_3872:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3875
do_compose_3871:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3875
do_concat_3873:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3875
id_morphism_3874:
    b apply_end_3875
apply_end_3875:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3879
    tst x9, #1
    b.eq do_concat_3878
    tst x0, #1
    b.ne do_compose_3876
do_apply_3877:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3880
do_compose_3876:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3880
do_concat_3878:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3880
id_morphism_3879:
    b apply_end_3880
apply_end_3880:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_3802:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3800_3801:
    // Closure for func_3800
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
    adr x1, func_3800
    ldr x0, [sp], #16
    bl _cons
blk_end_3792:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3790_3791:
    // Closure for func_3790
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
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3790
    ldr x0, [sp], #16
    bl _cons
blk_end_3777:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3775_3776:
    // Closure for func_3775
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
    ldr x0, [x29, #-128]
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
    adr x1, func_3775
    ldr x0, [sp], #16
    bl _cons
blk_end_3767:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3765_3766:
    // Closure for func_3765
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
    ldr x0, [x29, #-112]
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
    adr x1, func_3765
    ldr x0, [sp], #16
    bl _cons
blk_end_3757:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3755_3756:
    // Closure for func_3755
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
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3755
    ldr x0, [sp], #16
    bl _cons
blk_end_3742:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3740_3741:
    // Closure for func_3740
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
    ldr x0, [x29, #-128]
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
    adr x1, func_3740
    ldr x0, [sp], #16
    bl _cons
blk_end_3732:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3730_3731:
    // Closure for func_3730
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
    adr x1, func_3730
    ldr x0, [sp], #16
    bl _cons
blk_end_3722:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3720_3721:
    // Closure for func_3720
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3720
    ldr x0, [sp], #16
    bl _cons
blk_end_3707:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3705_3706:
    // Closure for func_3705
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
    adr x1, func_3705
    ldr x0, [sp], #16
    bl _cons
blk_end_3697:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3695_3696:
    // Closure for func_3695
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
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3695
    ldr x0, [sp], #16
    bl _cons
blk_end_3682:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3680_3681:
    // Closure for func_3680
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
    adr x1, func_3680
    ldr x0, [sp], #16
    bl _cons
blk_end_3657:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3655_3656:
    // Closure for func_3655
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
    adr x1, func_3655
    ldr x0, [sp], #16
    bl _cons
blk_end_3637:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3635_3636:
    // Closure for func_3635
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
    adr x1, func_3635
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3631_3632:
    // Closure for func_3631
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3631
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3625
cond_false_3624:
    adr x0, sign_id
cond_end_3625:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_logic_and
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3886
    tst x9, #1
    b.eq do_concat_3885
    tst x0, #1
    b.ne do_compose_3883
do_apply_3884:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3887
do_compose_3883:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3887
do_concat_3885:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3887
id_morphism_3886:
    b apply_end_3887
apply_end_3887:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3881
    b after_func_3888_3889
func_3888:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3890_3891
func_3890:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_3892_3893
func_3892:
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
    b.eq or_right_3895
    b or_end_3896
or_right_3895:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3900
    tst x9, #1
    b.eq do_concat_3899
    tst x0, #1
    b.ne do_compose_3897
do_apply_3898:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3901
do_compose_3897:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3901
do_concat_3899:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3901
id_morphism_3900:
    b apply_end_3901
apply_end_3901:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3905
    tst x9, #1
    b.eq do_concat_3904
    tst x0, #1
    b.ne do_compose_3902
do_apply_3903:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3906
do_compose_3902:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3906
do_concat_3904:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3906
id_morphism_3905:
    b apply_end_3906
apply_end_3906:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3910
    tst x9, #1
    b.eq do_concat_3909
    tst x0, #1
    b.ne do_compose_3907
do_apply_3908:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3911
do_compose_3907:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3911
do_concat_3909:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3911
id_morphism_3910:
    b apply_end_3911
apply_end_3911:
or_end_3896:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3894
    b after_func_3912_3913
func_3912:
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
    b.eq or_right_3915
    b or_end_3916
or_right_3915:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3920
    tst x9, #1
    b.eq do_concat_3919
    tst x0, #1
    b.ne do_compose_3917
do_apply_3918:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3921
do_compose_3917:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3921
do_concat_3919:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3921
id_morphism_3920:
    b apply_end_3921
apply_end_3921:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3925
    tst x9, #1
    b.eq do_concat_3924
    tst x0, #1
    b.ne do_compose_3922
do_apply_3923:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3926
do_compose_3922:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3926
do_concat_3924:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3926
id_morphism_3925:
    b apply_end_3926
apply_end_3926:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3930
    tst x9, #1
    b.eq do_concat_3929
    tst x0, #1
    b.ne do_compose_3927
do_apply_3928:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3931
do_compose_3927:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3931
do_concat_3929:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3931
id_morphism_3930:
    b apply_end_3931
apply_end_3931:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3935
    tst x9, #1
    b.eq do_concat_3934
    tst x0, #1
    b.ne do_compose_3932
do_apply_3933:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3936
do_compose_3932:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3936
do_concat_3934:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3936
id_morphism_3935:
    b apply_end_3936
apply_end_3936:
or_end_3916:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3914
    b after_func_3937_3938
func_3937:
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
    b.eq or_right_3940
    b or_end_3941
or_right_3940:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3945
    tst x9, #1
    b.eq do_concat_3944
    tst x0, #1
    b.ne do_compose_3942
do_apply_3943:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3946
do_compose_3942:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3946
do_concat_3944:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3946
id_morphism_3945:
    b apply_end_3946
apply_end_3946:
    str x0, [sp, #-16]!
    adr x0, str_84
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3950
    tst x9, #1
    b.eq do_concat_3949
    tst x0, #1
    b.ne do_compose_3947
do_apply_3948:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3951
do_compose_3947:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3951
do_concat_3949:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3951
id_morphism_3950:
    b apply_end_3951
apply_end_3951:
or_end_3941:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3939
    b after_func_3952_3953
func_3952:
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
    b.eq or_right_3955
    b or_end_3956
or_right_3955:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3960
    tst x9, #1
    b.eq do_concat_3959
    tst x0, #1
    b.ne do_compose_3957
do_apply_3958:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3961
do_compose_3957:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3961
do_concat_3959:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3961
id_morphism_3960:
    b apply_end_3961
apply_end_3961:
or_end_3956:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3954
    b after_func_3962_3963
func_3962:
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
    b.eq or_right_3965
    b or_end_3966
or_right_3965:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3970
    tst x9, #1
    b.eq do_concat_3969
    tst x0, #1
    b.ne do_compose_3967
do_apply_3968:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3971
do_compose_3967:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3971
do_concat_3969:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3971
id_morphism_3970:
    b apply_end_3971
apply_end_3971:
    str x0, [sp, #-16]!
    adr x0, str_85
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3975
    tst x9, #1
    b.eq do_concat_3974
    tst x0, #1
    b.ne do_compose_3972
do_apply_3973:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3976
do_compose_3972:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3976
do_concat_3974:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3976
id_morphism_3975:
    b apply_end_3976
apply_end_3976:
or_end_3966:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3964
    b after_func_3977_3978
func_3977:
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
    b.eq or_right_3980
    b or_end_3981
or_right_3980:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3985
    tst x9, #1
    b.eq do_concat_3984
    tst x0, #1
    b.ne do_compose_3982
do_apply_3983:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3986
do_compose_3982:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3986
do_concat_3984:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3986
id_morphism_3985:
    b apply_end_3986
apply_end_3986:
or_end_3981:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3979
    b after_func_3987_3988
func_3987:
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
    b.eq or_right_3990
    b or_end_3991
or_right_3990:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_3995
    tst x9, #1
    b.eq do_concat_3994
    tst x0, #1
    b.ne do_compose_3992
do_apply_3993:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_3996
do_compose_3992:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_3996
do_concat_3994:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_3996
id_morphism_3995:
    b apply_end_3996
apply_end_3996:
or_end_3991:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3989
    b after_func_3997_3998
func_3997:
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
    b.eq or_right_4000
    b or_end_4001
or_right_4000:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4005
    tst x9, #1
    b.eq do_concat_4004
    tst x0, #1
    b.ne do_compose_4002
do_apply_4003:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4006
do_compose_4002:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4006
do_concat_4004:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4006
id_morphism_4005:
    b apply_end_4006
apply_end_4006:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4010
    tst x9, #1
    b.eq do_concat_4009
    tst x0, #1
    b.ne do_compose_4007
do_apply_4008:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4011
do_compose_4007:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4011
do_concat_4009:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4011
id_morphism_4010:
    b apply_end_4011
apply_end_4011:
or_end_4001:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_3999
    b after_func_4012_4013
func_4012:
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
    b.eq or_right_4015
    b or_end_4016
or_right_4015:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4020
    tst x9, #1
    b.eq do_concat_4019
    tst x0, #1
    b.ne do_compose_4017
do_apply_4018:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4021
do_compose_4017:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4021
do_concat_4019:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4021
id_morphism_4020:
    b apply_end_4021
apply_end_4021:
or_end_4016:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4014
    b after_func_4022_4023
func_4022:
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
    b.eq or_right_4025
    b or_end_4026
or_right_4025:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4030
    tst x9, #1
    b.eq do_concat_4029
    tst x0, #1
    b.ne do_compose_4027
do_apply_4028:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4031
do_compose_4027:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4031
do_concat_4029:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4031
id_morphism_4030:
    b apply_end_4031
apply_end_4031:
or_end_4026:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4024
    b after_func_4032_4033
func_4032:
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
    b.eq or_right_4035
    b or_end_4036
or_right_4035:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4040
    tst x9, #1
    b.eq do_concat_4039
    tst x0, #1
    b.ne do_compose_4037
do_apply_4038:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4041
do_compose_4037:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4041
do_concat_4039:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4041
id_morphism_4040:
    b apply_end_4041
apply_end_4041:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4045
    tst x9, #1
    b.eq do_concat_4044
    tst x0, #1
    b.ne do_compose_4042
do_apply_4043:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4046
do_compose_4042:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4046
do_concat_4044:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4046
id_morphism_4045:
    b apply_end_4046
apply_end_4046:
or_end_4036:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4034
    b after_func_4047_4048
func_4047:
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
    b.eq or_right_4050
    b or_end_4051
or_right_4050:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4055
    tst x9, #1
    b.eq do_concat_4054
    tst x0, #1
    b.ne do_compose_4052
do_apply_4053:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4056
do_compose_4052:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4056
do_concat_4054:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4056
id_morphism_4055:
    b apply_end_4056
apply_end_4056:
or_end_4051:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4049
    b after_func_4057_4058
func_4057:
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
    b.eq or_right_4060
    b or_end_4061
or_right_4060:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4065
    tst x9, #1
    b.eq do_concat_4064
    tst x0, #1
    b.ne do_compose_4062
do_apply_4063:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4066
do_compose_4062:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4066
do_concat_4064:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4066
id_morphism_4065:
    b apply_end_4066
apply_end_4066:
or_end_4061:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4059
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_43
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_44
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4067
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_13
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4071
    tst x9, #1
    b.eq do_concat_4070
    tst x0, #1
    b.ne do_compose_4068
do_apply_4069:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4072
do_compose_4068:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4072
do_concat_4070:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4072
id_morphism_4071:
    b apply_end_4072
apply_end_4072:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4076
    tst x9, #1
    b.eq do_concat_4075
    tst x0, #1
    b.ne do_compose_4073
do_apply_4074:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4077
do_compose_4073:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4077
do_concat_4075:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4077
id_morphism_4076:
    b apply_end_4077
apply_end_4077:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4081
    tst x9, #1
    b.eq do_concat_4080
    tst x0, #1
    b.ne do_compose_4078
do_apply_4079:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4082
do_compose_4078:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4082
do_concat_4080:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4082
id_morphism_4081:
    b apply_end_4082
apply_end_4082:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4086
    tst x9, #1
    b.eq do_concat_4085
    tst x0, #1
    b.ne do_compose_4083
do_apply_4084:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4087
do_compose_4083:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4087
do_concat_4085:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4087
id_morphism_4086:
    b apply_end_4087
apply_end_4087:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4067
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_22
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4091
    tst x9, #1
    b.eq do_concat_4090
    tst x0, #1
    b.ne do_compose_4088
do_apply_4089:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4092
do_compose_4088:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4092
do_concat_4090:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4092
id_morphism_4091:
    b apply_end_4092
apply_end_4092:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4096
    tst x9, #1
    b.eq do_concat_4095
    tst x0, #1
    b.ne do_compose_4093
do_apply_4094:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4097
do_compose_4093:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4097
do_concat_4095:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4097
id_morphism_4096:
    b apply_end_4097
apply_end_4097:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4101
    tst x9, #1
    b.eq do_concat_4100
    tst x0, #1
    b.ne do_compose_4098
do_apply_4099:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4102
do_compose_4098:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4102
do_concat_4100:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4102
id_morphism_4101:
    b apply_end_4102
apply_end_4102:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4106
    tst x9, #1
    b.eq do_concat_4105
    tst x0, #1
    b.ne do_compose_4103
do_apply_4104:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4107
do_compose_4103:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4107
do_concat_4105:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4107
id_morphism_4106:
    b apply_end_4107
apply_end_4107:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4112
    tst x9, #1
    b.eq do_concat_4111
    tst x0, #1
    b.ne do_compose_4109
do_apply_4110:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4113
do_compose_4109:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4113
do_concat_4111:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4113
id_morphism_4112:
    b apply_end_4113
apply_end_4113:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4117
    tst x9, #1
    b.eq do_concat_4116
    tst x0, #1
    b.ne do_compose_4114
do_apply_4115:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4118
do_compose_4114:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4118
do_concat_4116:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4118
id_morphism_4117:
    b apply_end_4118
apply_end_4118:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4108
    adr x0, str_36
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4108
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4122
    tst x9, #1
    b.eq do_concat_4121
    tst x0, #1
    b.ne do_compose_4119
do_apply_4120:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4123
do_compose_4119:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4123
do_concat_4121:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4123
id_morphism_4122:
    b apply_end_4123
apply_end_4123:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4127
    tst x9, #1
    b.eq do_concat_4126
    tst x0, #1
    b.ne do_compose_4124
do_apply_4125:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4128
do_compose_4124:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4128
do_concat_4126:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4128
id_morphism_4127:
    b apply_end_4128
apply_end_4128:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_4108:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4132
    tst x9, #1
    b.eq do_concat_4131
    tst x0, #1
    b.ne do_compose_4129
do_apply_4130:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4133
do_compose_4129:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4133
do_concat_4131:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4133
id_morphism_4132:
    b apply_end_4133
apply_end_4133:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4137
    tst x9, #1
    b.eq do_concat_4136
    tst x0, #1
    b.ne do_compose_4134
do_apply_4135:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4138
do_compose_4134:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4138
do_concat_4136:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4138
id_morphism_4137:
    b apply_end_4138
apply_end_4138:
blk_end_4067:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4142
    tst x9, #1
    b.eq do_concat_4141
    tst x0, #1
    b.ne do_compose_4139
do_apply_4140:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4143
do_compose_4139:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4143
do_concat_4141:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4143
id_morphism_4142:
    b apply_end_4143
apply_end_4143:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4147
    tst x9, #1
    b.eq do_concat_4146
    tst x0, #1
    b.ne do_compose_4144
do_apply_4145:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4148
do_compose_4144:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4148
do_concat_4146:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4148
id_morphism_4147:
    b apply_end_4148
apply_end_4148:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_4059:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4057_4058:
    // Closure for func_4057
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x1, func_4057
    ldr x0, [sp], #16
    bl _cons
blk_end_4049:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4047_4048:
    // Closure for func_4047
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
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4047
    ldr x0, [sp], #16
    bl _cons
blk_end_4034:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4032_4033:
    // Closure for func_4032
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
    ldr x0, [x29, #-128]
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
    adr x1, func_4032
    ldr x0, [sp], #16
    bl _cons
blk_end_4024:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4022_4023:
    // Closure for func_4022
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
    ldr x0, [x29, #-112]
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
    adr x1, func_4022
    ldr x0, [sp], #16
    bl _cons
blk_end_4014:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4012_4013:
    // Closure for func_4012
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
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4012
    ldr x0, [sp], #16
    bl _cons
blk_end_3999:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3997_3998:
    // Closure for func_3997
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
    ldr x0, [x29, #-128]
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
    adr x1, func_3997
    ldr x0, [sp], #16
    bl _cons
blk_end_3989:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3987_3988:
    // Closure for func_3987
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
    adr x1, func_3987
    ldr x0, [sp], #16
    bl _cons
blk_end_3979:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3977_3978:
    // Closure for func_3977
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3977
    ldr x0, [sp], #16
    bl _cons
blk_end_3964:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3962_3963:
    // Closure for func_3962
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
    adr x1, func_3962
    ldr x0, [sp], #16
    bl _cons
blk_end_3954:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3952_3953:
    // Closure for func_3952
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
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3952
    ldr x0, [sp], #16
    bl _cons
blk_end_3939:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3937_3938:
    // Closure for func_3937
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
    adr x1, func_3937
    ldr x0, [sp], #16
    bl _cons
blk_end_3914:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3912_3913:
    // Closure for func_3912
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
    adr x1, func_3912
    ldr x0, [sp], #16
    bl _cons
blk_end_3894:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3892_3893:
    // Closure for func_3892
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
    adr x1, func_3892
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3890_3891:
    // Closure for func_3890
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_3890
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3888_3889:
    // Closure for func_3888
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3888
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3882
cond_false_3881:
    adr x0, sign_id
cond_end_3882:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_block
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4154
    tst x9, #1
    b.eq do_concat_4153
    tst x0, #1
    b.ne do_compose_4151
do_apply_4152:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4155
do_compose_4151:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4155
do_concat_4153:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4155
id_morphism_4154:
    b apply_end_4155
apply_end_4155:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4149
    b after_func_4156_4157
func_4156:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4158_4159
func_4158:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4160_4161
func_4160:
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
    b.eq or_right_4163
    b or_end_4164
or_right_4163:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4168
    tst x9, #1
    b.eq do_concat_4167
    tst x0, #1
    b.ne do_compose_4165
do_apply_4166:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4169
do_compose_4165:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4169
do_concat_4167:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4169
id_morphism_4168:
    b apply_end_4169
apply_end_4169:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4173
    tst x9, #1
    b.eq do_concat_4172
    tst x0, #1
    b.ne do_compose_4170
do_apply_4171:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4174
do_compose_4170:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4174
do_concat_4172:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4174
id_morphism_4173:
    b apply_end_4174
apply_end_4174:
or_end_4164:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4162
    b after_func_4175_4176
func_4175:
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
    b.eq cmp_true_4180
    adr x0, sign_id
    b cmp_end_4181
cmp_true_4180:
cmp_end_4181:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4178
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_4182
    b or_end_4183
or_right_4182:
    adr x0, str_36
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
or_end_4183:
    b cond_end_4179
cond_false_4178:
    adr x0, sign_id
cond_end_4179:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4177
    b after_func_4184_4185
func_4184:
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
    b.eq or_right_4187
    b or_end_4188
or_right_4187:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4192
    tst x9, #1
    b.eq do_concat_4191
    tst x0, #1
    b.ne do_compose_4189
do_apply_4190:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4193
do_compose_4189:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4193
do_concat_4191:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4193
id_morphism_4192:
    b apply_end_4193
apply_end_4193:
    str x0, [sp, #-16]!
    adr x0, str_86
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4197
    tst x9, #1
    b.eq do_concat_4196
    tst x0, #1
    b.ne do_compose_4194
do_apply_4195:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4198
do_compose_4194:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4198
do_concat_4196:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4198
id_morphism_4197:
    b apply_end_4198
apply_end_4198:
or_end_4188:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4186
    b after_func_4199_4200
func_4199:
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
    b.eq or_right_4202
    b or_end_4203
or_right_4202:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4207
    tst x9, #1
    b.eq do_concat_4206
    tst x0, #1
    b.ne do_compose_4204
do_apply_4205:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4208
do_compose_4204:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4208
do_concat_4206:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4208
id_morphism_4207:
    b apply_end_4208
apply_end_4208:
or_end_4203:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4201
    b after_func_4209_4210
func_4209:
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
    b.eq or_right_4212
    b or_end_4213
or_right_4212:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4217
    tst x9, #1
    b.eq do_concat_4216
    tst x0, #1
    b.ne do_compose_4214
do_apply_4215:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4218
do_compose_4214:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4218
do_concat_4216:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4218
id_morphism_4217:
    b apply_end_4218
apply_end_4218:
or_end_4213:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4211
    b after_func_4219_4220
func_4219:
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
    b.eq or_right_4222
    b or_end_4223
or_right_4222:
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4227
    tst x9, #1
    b.eq do_concat_4226
    tst x0, #1
    b.ne do_compose_4224
do_apply_4225:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4228
do_compose_4224:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4228
do_concat_4226:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4228
id_morphism_4227:
    b apply_end_4228
apply_end_4228:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4232
    tst x9, #1
    b.eq do_concat_4231
    tst x0, #1
    b.ne do_compose_4229
do_apply_4230:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4233
do_compose_4229:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4233
do_concat_4231:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4233
id_morphism_4232:
    b apply_end_4233
apply_end_4233:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4237
    tst x9, #1
    b.eq do_concat_4236
    tst x0, #1
    b.ne do_compose_4234
do_apply_4235:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4238
do_compose_4234:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4238
do_concat_4236:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4238
id_morphism_4237:
    b apply_end_4238
apply_end_4238:
or_end_4223:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4221
    b after_func_4239_4240
func_4239:
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
    b.eq or_right_4242
    b or_end_4243
or_right_4242:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4247
    tst x9, #1
    b.eq do_concat_4246
    tst x0, #1
    b.ne do_compose_4244
do_apply_4245:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4248
do_compose_4244:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4248
do_concat_4246:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4248
id_morphism_4247:
    b apply_end_4248
apply_end_4248:
or_end_4243:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4241
    b after_func_4249_4250
func_4249:
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
    b.eq or_right_4252
    b or_end_4253
or_right_4252:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4257
    tst x9, #1
    b.eq do_concat_4256
    tst x0, #1
    b.ne do_compose_4254
do_apply_4255:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4258
do_compose_4254:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4258
do_concat_4256:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4258
id_morphism_4257:
    b apply_end_4258
apply_end_4258:
or_end_4253:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4251
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4262
    tst x9, #1
    b.eq do_concat_4261
    tst x0, #1
    b.ne do_compose_4259
do_apply_4260:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4263
do_compose_4259:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4263
do_concat_4261:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4263
id_morphism_4262:
    b apply_end_4263
apply_end_4263:
    str x0, [sp, #-16]!
    adr x0, str_23
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4267
    tst x9, #1
    b.eq do_concat_4266
    tst x0, #1
    b.ne do_compose_4264
do_apply_4265:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4268
do_compose_4264:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4268
do_concat_4266:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4268
id_morphism_4267:
    b apply_end_4268
apply_end_4268:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_4251:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4249_4250:
    // Closure for func_4249
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
    adr x1, func_4249
    ldr x0, [sp], #16
    bl _cons
blk_end_4241:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4239_4240:
    // Closure for func_4239
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x1, func_4239
    ldr x0, [sp], #16
    bl _cons
blk_end_4221:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4219_4220:
    // Closure for func_4219
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
    adr x1, func_4219
    ldr x0, [sp], #16
    bl _cons
blk_end_4211:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4209_4210:
    // Closure for func_4209
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
    adr x1, func_4209
    ldr x0, [sp], #16
    bl _cons
blk_end_4201:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4199_4200:
    // Closure for func_4199
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
    adr x1, func_4199
    ldr x0, [sp], #16
    bl _cons
blk_end_4186:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4184_4185:
    // Closure for func_4184
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
    adr x1, func_4184
    ldr x0, [sp], #16
    bl _cons
blk_end_4177:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4175_4176:
    // Closure for func_4175
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
    adr x1, func_4175
    ldr x0, [sp], #16
    bl _cons
blk_end_4162:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4160_4161:
    // Closure for func_4160
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
    adr x1, func_4160
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4158_4159:
    // Closure for func_4158
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4158
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4156_4157:
    // Closure for func_4156
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4156
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4150
cond_false_4149:
    adr x0, sign_id
cond_end_4150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_stmts
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4274
    tst x9, #1
    b.eq do_concat_4273
    tst x0, #1
    b.ne do_compose_4271
do_apply_4272:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4275
do_compose_4271:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4275
do_concat_4273:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4275
id_morphism_4274:
    b apply_end_4275
apply_end_4275:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4269
    b after_func_4276_4277
func_4276:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4278_4279
func_4278:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4280_4281
func_4280:
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
    b after_func_4282_4283
func_4282:
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
    b.eq or_right_4285
    b or_end_4286
or_right_4285:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4290
    tst x9, #1
    b.eq do_concat_4289
    tst x0, #1
    b.ne do_compose_4287
do_apply_4288:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4291
do_compose_4287:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4291
do_concat_4289:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4291
id_morphism_4290:
    b apply_end_4291
apply_end_4291:
or_end_4286:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4284
    b after_func_4292_4293
func_4292:
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
    b.eq or_right_4295
    b or_end_4296
or_right_4295:
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4300
    tst x9, #1
    b.eq do_concat_4299
    tst x0, #1
    b.ne do_compose_4297
do_apply_4298:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4301
do_compose_4297:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4301
do_concat_4299:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4301
id_morphism_4300:
    b apply_end_4301
apply_end_4301:
or_end_4296:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4294
    b after_func_4302_4303
func_4302:
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
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4307
    adr x0, sign_id
    b cmp_end_4308
cmp_true_4307:
cmp_end_4308:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4305
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_4309
    b or_end_4310
or_right_4309:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_87
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4311
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4315
    tst x9, #1
    b.eq do_concat_4314
    tst x0, #1
    b.ne do_compose_4312
do_apply_4313:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4316
do_compose_4312:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4316
do_concat_4314:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4316
id_morphism_4315:
    b apply_end_4316
apply_end_4316:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4320
    tst x9, #1
    b.eq do_concat_4319
    tst x0, #1
    b.ne do_compose_4317
do_apply_4318:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4321
do_compose_4317:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4321
do_concat_4319:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4321
id_morphism_4320:
    b apply_end_4321
apply_end_4321:
blk_end_4311:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4325
    tst x9, #1
    b.eq do_concat_4324
    tst x0, #1
    b.ne do_compose_4322
do_apply_4323:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4326
do_compose_4322:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4326
do_concat_4324:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4326
id_morphism_4325:
    b apply_end_4326
apply_end_4326:
or_end_4310:
    b cond_end_4306
cond_false_4305:
    adr x0, sign_id
cond_end_4306:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4304
    b after_func_4327_4328
func_4327:
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
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_4329_4330
func_4329:
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
    b.eq or_right_4332
    b or_end_4333
or_right_4332:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4337
    tst x9, #1
    b.eq do_concat_4336
    tst x0, #1
    b.ne do_compose_4334
do_apply_4335:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4338
do_compose_4334:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4338
do_concat_4336:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4338
id_morphism_4337:
    b apply_end_4338
apply_end_4338:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4342
    tst x9, #1
    b.eq do_concat_4341
    tst x0, #1
    b.ne do_compose_4339
do_apply_4340:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4343
do_compose_4339:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4343
do_concat_4341:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4343
id_morphism_4342:
    b apply_end_4343
apply_end_4343:
or_end_4333:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4331
    b after_func_4344_4345
func_4344:
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
    b.eq or_right_4347
    b or_end_4348
or_right_4347:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4352
    tst x9, #1
    b.eq do_concat_4351
    tst x0, #1
    b.ne do_compose_4349
do_apply_4350:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4353
do_compose_4349:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4353
do_concat_4351:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4353
id_morphism_4352:
    b apply_end_4353
apply_end_4353:
or_end_4348:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4346
    b after_func_4354_4355
func_4354:
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
    b.eq or_right_4357
    b or_end_4358
or_right_4357:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4362
    tst x9, #1
    b.eq do_concat_4361
    tst x0, #1
    b.ne do_compose_4359
do_apply_4360:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4363
do_compose_4359:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4363
do_concat_4361:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4363
id_morphism_4362:
    b apply_end_4363
apply_end_4363:
or_end_4358:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4356
    b after_func_4364_4365
func_4364:
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
    b.eq or_right_4367
    b or_end_4368
or_right_4367:
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4372
    tst x9, #1
    b.eq do_concat_4371
    tst x0, #1
    b.ne do_compose_4369
do_apply_4370:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4373
do_compose_4369:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4373
do_concat_4371:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4373
id_morphism_4372:
    b apply_end_4373
apply_end_4373:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4377
    tst x9, #1
    b.eq do_concat_4376
    tst x0, #1
    b.ne do_compose_4374
do_apply_4375:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4378
do_compose_4374:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4378
do_concat_4376:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4378
id_morphism_4377:
    b apply_end_4378
apply_end_4378:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4382
    tst x9, #1
    b.eq do_concat_4381
    tst x0, #1
    b.ne do_compose_4379
do_apply_4380:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4383
do_compose_4379:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4383
do_concat_4381:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4383
id_morphism_4382:
    b apply_end_4383
apply_end_4383:
or_end_4368:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4366
    b after_func_4384_4385
func_4384:
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
    b.eq or_right_4387
    b or_end_4388
or_right_4387:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4392
    tst x9, #1
    b.eq do_concat_4391
    tst x0, #1
    b.ne do_compose_4389
do_apply_4390:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4393
do_compose_4389:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4393
do_concat_4391:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4393
id_morphism_4392:
    b apply_end_4393
apply_end_4393:
or_end_4388:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4386
    b after_func_4394_4395
func_4394:
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
    b.eq or_right_4397
    b or_end_4398
or_right_4397:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4402
    tst x9, #1
    b.eq do_concat_4401
    tst x0, #1
    b.ne do_compose_4399
do_apply_4400:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4403
do_compose_4399:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4403
do_concat_4401:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4403
id_morphism_4402:
    b apply_end_4403
apply_end_4403:
or_end_4398:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4396
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_43
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_44
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4404
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_88
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4408
    tst x9, #1
    b.eq do_concat_4407
    tst x0, #1
    b.ne do_compose_4405
do_apply_4406:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4409
do_compose_4405:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4409
do_concat_4407:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4409
id_morphism_4408:
    b apply_end_4409
apply_end_4409:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4413
    tst x9, #1
    b.eq do_concat_4412
    tst x0, #1
    b.ne do_compose_4410
do_apply_4411:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4414
do_compose_4410:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4414
do_concat_4412:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4414
id_morphism_4413:
    b apply_end_4414
apply_end_4414:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4418
    tst x9, #1
    b.eq do_concat_4417
    tst x0, #1
    b.ne do_compose_4415
do_apply_4416:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4419
do_compose_4415:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4419
do_concat_4417:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4419
id_morphism_4418:
    b apply_end_4419
apply_end_4419:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4423
    tst x9, #1
    b.eq do_concat_4422
    tst x0, #1
    b.ne do_compose_4420
do_apply_4421:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4424
do_compose_4420:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4424
do_concat_4422:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4424
id_morphism_4423:
    b apply_end_4424
apply_end_4424:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_4404
    ldr x0, [x29, #-96]
blk_end_4404:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4428
    tst x9, #1
    b.eq do_concat_4427
    tst x0, #1
    b.ne do_compose_4425
do_apply_4426:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4429
do_compose_4425:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4429
do_concat_4427:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4429
id_morphism_4428:
    b apply_end_4429
apply_end_4429:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4433
    tst x9, #1
    b.eq do_concat_4432
    tst x0, #1
    b.ne do_compose_4430
do_apply_4431:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4434
do_compose_4430:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4434
do_concat_4432:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4434
id_morphism_4433:
    b apply_end_4434
apply_end_4434:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_4396:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4394_4395:
    // Closure for func_4394
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
    adr x1, func_4394
    ldr x0, [sp], #16
    bl _cons
blk_end_4386:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4384_4385:
    // Closure for func_4384
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4384
    ldr x0, [sp], #16
    bl _cons
blk_end_4366:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4364_4365:
    // Closure for func_4364
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x1, func_4364
    ldr x0, [sp], #16
    bl _cons
blk_end_4356:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4354_4355:
    // Closure for func_4354
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
    adr x1, func_4354
    ldr x0, [sp], #16
    bl _cons
blk_end_4346:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4344_4345:
    // Closure for func_4344
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4344
    ldr x0, [sp], #16
    bl _cons
blk_end_4331:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4329_4330:
    // Closure for func_4329
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
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4329
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4327_4328:
    // Closure for func_4327
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4327
    ldr x0, [sp], #16
    bl _cons
blk_end_4304:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4302_4303:
    // Closure for func_4302
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
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4302
    ldr x0, [sp], #16
    bl _cons
blk_end_4294:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4292_4293:
    // Closure for func_4292
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
    ldr x0, [x29, #-96]
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
    adr x1, func_4292
    ldr x0, [sp], #16
    bl _cons
blk_end_4284:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4282_4283:
    // Closure for func_4282
    adr x0, sign_id
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
    adr x1, func_4282
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4280_4281:
    // Closure for func_4280
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
    adr x1, func_4280
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4278_4279:
    // Closure for func_4278
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_4278
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4276_4277:
    // Closure for func_4276
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4276
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4270
cond_false_4269:
    adr x0, sign_id
cond_end_4270:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4440
    tst x9, #1
    b.eq do_concat_4439
    tst x0, #1
    b.ne do_compose_4437
do_apply_4438:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4441
do_compose_4437:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4441
do_concat_4439:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4441
id_morphism_4440:
    b apply_end_4441
apply_end_4441:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4435
    b after_func_4442_4443
func_4442:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4447
    tst x9, #1
    b.eq do_concat_4446
    tst x0, #1
    b.ne do_compose_4444
do_apply_4445:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4448
do_compose_4444:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4448
do_concat_4446:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4448
id_morphism_4447:
    b apply_end_4448
apply_end_4448:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4442_4443:
    // Closure for func_4442
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4442
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4436
cond_false_4435:
    adr x0, sign_id
cond_end_4436:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_from_res
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4454
    tst x9, #1
    b.eq do_concat_4453
    tst x0, #1
    b.ne do_compose_4451
do_apply_4452:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4455
do_compose_4451:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4455
do_concat_4453:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4455
id_morphism_4454:
    b apply_end_4455
apply_end_4455:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4449
    b after_func_4456_4457
func_4456:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4461
    tst x9, #1
    b.eq do_concat_4460
    tst x0, #1
    b.ne do_compose_4458
do_apply_4459:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4462
do_compose_4458:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4462
do_concat_4460:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4462
id_morphism_4461:
    b apply_end_4462
apply_end_4462:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4466
    tst x9, #1
    b.eq do_concat_4465
    tst x0, #1
    b.ne do_compose_4463
do_apply_4464:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4467
do_compose_4463:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4467
do_concat_4465:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4467
id_morphism_4466:
    b apply_end_4467
apply_end_4467:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4456_4457:
    // Closure for func_4456
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4456
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4450
cond_false_4449:
    adr x0, sign_id
cond_end_4450:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_from_lbl
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4473
    tst x9, #1
    b.eq do_concat_4472
    tst x0, #1
    b.ne do_compose_4470
do_apply_4471:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4474
do_compose_4470:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4474
do_concat_4472:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4474
id_morphism_4473:
    b apply_end_4474
apply_end_4474:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4468
    b after_func_4475_4476
func_4475:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4480
    tst x9, #1
    b.eq do_concat_4479
    tst x0, #1
    b.ne do_compose_4477
do_apply_4478:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4481
do_compose_4477:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4481
do_concat_4479:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4481
id_morphism_4480:
    b apply_end_4481
apply_end_4481:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4485
    tst x9, #1
    b.eq do_concat_4484
    tst x0, #1
    b.ne do_compose_4482
do_apply_4483:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4486
do_compose_4482:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4486
do_concat_4484:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4486
id_morphism_4485:
    b apply_end_4486
apply_end_4486:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4475_4476:
    // Closure for func_4475
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4475
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4469
cond_false_4468:
    adr x0, sign_id
cond_end_4469:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_literal_expr
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4492
    tst x9, #1
    b.eq do_concat_4491
    tst x0, #1
    b.ne do_compose_4489
do_apply_4490:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4493
do_compose_4489:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4493
do_concat_4491:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4493
id_morphism_4492:
    b apply_end_4493
apply_end_4493:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_4487
    b after_func_4494_4495
func_4494:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_4496_4497
func_4496:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4502
    adr x0, sign_id
    b cmp_end_4503
cmp_true_4502:
cmp_end_4503:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_4500
    b or_end_4501
or_right_4500:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4504
    adr x0, sign_id
    b cmp_end_4505
cmp_true_4504:
cmp_end_4505:
or_end_4501:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_4498
    b or_end_4499
or_right_4498:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ast_char
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_4506
    adr x0, sign_id
    b cmp_end_4507
cmp_true_4506:
cmp_end_4507:
or_end_4499:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4496_4497:
    // Closure for func_4496
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4496
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4511
    tst x9, #1
    b.eq do_concat_4510
    tst x0, #1
    b.ne do_compose_4508
do_apply_4509:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4512
do_compose_4508:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4512
do_concat_4510:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4512
id_morphism_4511:
    b apply_end_4512
apply_end_4512:
    ldr x9, [sp], #16
    adr x10, sign_id
    cmp x9, x10
    b.eq id_morphism_4516
    tst x9, #1
    b.eq do_concat_4515
    tst x0, #1
    b.ne do_compose_4513
do_apply_4514:
    bic x9, x9, #1
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_4517
do_compose_4513:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_4517
do_concat_4515:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_4517
id_morphism_4516:
    b apply_end_4517
apply_end_4517:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_4494_4495:
    // Closure for func_4494
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_4494
    ldr x0, [sp], #16
    bl _cons
    b cond_end_4488
cond_false_4487:
    adr x0, sign_id
cond_end_4488:
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
str_0:
    .asciz "    adr x0, "
str_1:
    .asciz "\n"
str_2:
    .asciz "Spread Concat via Whitespace Apply"
str_3:
    .asciz "    str x0, [sp, #-16]!\n"
str_4:
    .asciz "    mov x1, x0\n"
str_5:
    .asciz "    ldr x0, [sp], #16\n"
str_6:
    .asciz "    bl _concat\n"
str_7:
    .asciz "Standard Function Call"
str_8:
    .asciz "do_concat"
str_9:
    .asciz "apply_end"
str_10:
    .asciz "    ldr x1, [sp], #16\n"
str_11:
    .asciz "    adr x10, sign_id\n"
str_12:
    .asciz "    cmp x1, x10\n"
str_13:
    .asciz "    b.eq "
str_14:
    .asciz "    adr x9, heap_buffer\n"
str_15:
    .asciz "    cmp x1, x9\n"
str_16:
    .asciz "    b.lo "
str_17:
    .asciz "    tst x1, #1\n"
str_18:
    .asciz "    bic x1, x1, #1\n"
str_19:
    .asciz "    ldr x2, [x1]\n"
str_20:
    .asciz "    ldr x9, [x1, #8]\n"
str_21:
    .asciz "    blr x2\n"
str_22:
    .asciz "    b "
str_23:
    .asciz ":\n"
str_24:
    .asciz "    mov x2, x0\n"
str_25:
    .asciz "    mov x0, x1\n"
str_26:
    .asciz "    mov x1, x2\n"
str_27:
    .asciz "str_"
str_28:
    .asciz ""
str_29:
    .asciz ".global _str_end\n_str_end:\n"
str_30:
    .asciz ":\n    .asciz \""
str_31:
    .asciz "\"\n"
str_32:
    .asciz "\n.data\n.balign 8\n.global _str_start\n_str_start:\n"
str_33:
    .asciz "Default"
str_34:
    .asciz "    // Unknown Node Type\n"
str_35:
    .asciz "    mov x0, #"
str_36:
    .asciz "    adr x0, sign_id\n"
str_37:
    .asciz "!!"
str_38:
    .asciz "Fallback"
str_39:
    .asciz "    bl _read_char\n"
str_40:
    .asciz "    ldr x0, [x0] // @ load\n"
str_41:
    .asciz "not_true"
str_42:
    .asciz "not_end"
str_43:
    .asciz "    adr x9, sign_id\n"
str_44:
    .asciz "    cmp x0, x9\n"
str_45:
    .asciz "    mov x0, #0\n"
str_46:
    .asciz "    mvn x0, x0\n"
str_47:
    .asciz "    bl _factorial\n"
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
    .asciz "!="
str_54:
    .asciz "ne"
str_55:
    .asciz "lt"
str_56:
    .asciz "gt"
str_57:
    .asciz "<="
str_58:
    .asciz "le"
str_59:
    .asciz ">="
str_60:
    .asciz "ge"
str_61:
    .asciz "||"
str_62:
    .asciz "    orr x0, x1, x0\n"
str_63:
    .asciz "    bl _cons\n"
str_64:
    .asciz "~+"
str_65:
    .asciz "    bl _range\n"
str_66:
    .asciz "    bl _dict_get\n"
str_67:
    .asciz "    // Unknown Infix: "
str_68:
    .asciz "func"
str_69:
    .asciz "after_func"
str_70:
    .asciz "    stp x29, x30, [sp, #-16]!\n"
str_71:
    .asciz "    mov x29, sp\n"
str_72:
    .asciz "    str x0, [sp, #-16]!\n\ Push Arg"
str_73:
    .asciz "    mov sp, x29\n"
str_74:
    .asciz "    ldp x29, x30, [sp], #16\n"
str_75:
    .asciz "    ret\n"
str_76:
    .asciz "    adr x1, "
str_77:
    .asciz "    orr x0, x0, #1 // Tag closure\n"
str_78:
    .asciz "cmp_true"
str_79:
    .asciz "cmp_end"
str_80:
    .asciz "    cmp x0, x1\n"
str_81:
    .asciz "    b."
str_82:
    .asciz "or_right"
str_83:
    .asciz "or_end"
str_84:
    .asciz "and_fail"
str_85:
    .asciz "and_end"
str_86:
    .asciz "blk_end"
str_87:
    .asciz "Last Statement"
str_88:
    .asciz "    b.ne "
