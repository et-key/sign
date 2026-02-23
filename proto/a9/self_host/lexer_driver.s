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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2
    tst x1, #1
    b.eq do_concat_2
do_apply_1:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3
do_concat_2:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3:
    str x0, [sp, #-16]!
    adr x0, Lexer
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_5
    tst x1, #1
    b.eq do_concat_5
do_apply_4:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_6
do_concat_5:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_6:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Ported
    str x0, [sp, #-16]!
    adr x0, from
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_8
    tst x1, #1
    b.eq do_concat_8
do_apply_7:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_9
do_concat_8:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_9:
    str x0, [sp, #-16]!
    adr x0, prepare_lexer
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_11
    tst x1, #1
    b.eq do_concat_11
do_apply_10:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_12
do_concat_11:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_12:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_14
    tst x1, #1
    b.eq do_concat_14
do_apply_13:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_15
do_concat_14:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_15:
    str x0, [sp, #-16]!
    adr x0, js
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_17
    tst x1, #1
    b.eq do_concat_17
do_apply_16:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_18
do_concat_17:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_18:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_20
    tst x1, #1
    b.eq do_concat_20
do_apply_19:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_21
do_concat_20:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_21:
    str x0, [sp, #-16]!
    adr x0, js
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_23
    tst x1, #1
    b.eq do_concat_23
do_apply_22:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_24
do_concat_23:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_24:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_28
    tst x1, #1
    b.eq do_concat_28
do_apply_27:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_29
do_concat_28:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_29:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_25
    b after_func_30_31
func_30:
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
    b.ne blk_end_32
    adr x0, src_len
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_34
    tst x1, #1
    b.eq do_concat_34
do_apply_33:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_35
do_concat_34:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_35:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_32
    adr x0, pos
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_32
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_37
    tst x1, #1
    b.eq do_concat_37
do_apply_36:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_38
do_concat_37:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_38:
blk_end_32:
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
    b cond_end_26
cond_false_25:
    adr x0, sign_id
cond_end_26:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, read_char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_42
    tst x1, #1
    b.eq do_concat_42
do_apply_41:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_43
do_concat_42:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_43:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_39
    b after_func_44_45
func_44:
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
    b.ne blk_end_46
    adr x0, p
    str x0, [sp, #-16]!
    adr x0, src_len
    ldr x0, [x0] // @ load
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_49
    adr x0, sign_id
    b cmp_end_50
cmp_true_49:
cmp_end_50:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_47
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, ch
    str x0, [sp, #-16]!
    mov x0, #-1
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_51
    mov x0, #0
blk_end_51:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_53
    tst x1, #1
    b.eq do_concat_53
do_apply_52:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_54
do_concat_53:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_54:
    b cond_end_48
cond_false_47:
    adr x0, sign_id
cond_end_48:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_46
    adr x0, c
    str x0, [sp, #-16]!
    adr x0, nth
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_46
    adr x0, src
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, p
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_56
    tst x1, #1
    b.eq do_concat_56
do_apply_55:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_57
do_concat_56:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_57:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_46
    adr x0, ch
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_46
    adr x0, pos
    str x0, [sp, #-16]!
    adr x0, p
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_46
    adr x0, c
blk_end_46:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_44_45:
    // Closure for func_44
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_44
    ldr x0, [sp], #16
    bl _cons
    b cond_end_40
cond_false_39:
    adr x0, sign_id
cond_end_40:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_space
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_61
    tst x1, #1
    b.eq do_concat_61
do_apply_60:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_62
do_concat_61:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_62:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_58
    b after_func_63_64
func_63:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_69
    adr x0, sign_id
    b cmp_end_70
cmp_true_69:
cmp_end_70:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_67
    b or_end_68
or_right_67:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_71
    adr x0, sign_id
    b cmp_end_72
cmp_true_71:
cmp_end_72:
or_end_68:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_65
    b or_end_66
or_right_65:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_73
    adr x0, sign_id
    b cmp_end_74
cmp_true_73:
cmp_end_74:
or_end_66:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_63_64:
    // Closure for func_63
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_63
    ldr x0, [sp], #16
    bl _cons
    b cond_end_59
cond_false_58:
    adr x0, sign_id
cond_end_59:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_digit
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_78
    tst x1, #1
    b.eq do_concat_78
do_apply_77:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_79
do_concat_78:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_79:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_75
    b after_func_80_81
func_80:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_84
    adr x0, sign_id
    b cmp_end_85
cmp_true_84:
cmp_end_85:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_82
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_86
    adr x0, sign_id
    b cmp_end_87
cmp_true_86:
cmp_end_87:
    b and_end_83
and_fail_82:
    adr x0, sign_id
and_end_83:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_80_81:
    // Closure for func_80
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_80
    ldr x0, [sp], #16
    bl _cons
    b cond_end_76
cond_false_75:
    adr x0, sign_id
cond_end_76:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_alpha
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_91
    tst x1, #1
    b.eq do_concat_91
do_apply_90:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_92
do_concat_91:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_92:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_88
    b after_func_93_94
func_93:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_101
    adr x0, sign_id
    b cmp_end_102
cmp_true_101:
cmp_end_102:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_99
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_103
    adr x0, sign_id
    b cmp_end_104
cmp_true_103:
cmp_end_104:
    b and_end_100
and_fail_99:
    adr x0, sign_id
and_end_100:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_97
    b or_end_98
or_right_97:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_107
    adr x0, sign_id
    b cmp_end_108
cmp_true_107:
cmp_end_108:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_105
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_109
    adr x0, sign_id
    b cmp_end_110
cmp_true_109:
cmp_end_110:
    b and_end_106
and_fail_105:
    adr x0, sign_id
and_end_106:
or_end_98:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_95
    b or_end_96
or_right_95:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_111
    adr x0, sign_id
    b cmp_end_112
cmp_true_111:
cmp_end_112:
or_end_96:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_93_94:
    // Closure for func_93
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_93
    ldr x0, [sp], #16
    bl _cons
    b cond_end_89
cond_false_88:
    adr x0, sign_id
cond_end_89:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_op_char
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_116
    tst x1, #1
    b.eq do_concat_116
do_apply_115:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_117
do_concat_116:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_117:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_113
    b after_func_118_119
func_118:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_150
    adr x0, sign_id
    b cmp_end_151
cmp_true_150:
cmp_end_151:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_148
    b or_end_149
or_right_148:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_152
    adr x0, sign_id
    b cmp_end_153
cmp_true_152:
cmp_end_153:
or_end_149:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_146
    b or_end_147
or_right_146:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_154
    adr x0, sign_id
    b cmp_end_155
cmp_true_154:
cmp_end_155:
or_end_147:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_144
    b or_end_145
or_right_144:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_156
    adr x0, sign_id
    b cmp_end_157
cmp_true_156:
cmp_end_157:
or_end_145:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_142
    b or_end_143
or_right_142:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_158
    adr x0, sign_id
    b cmp_end_159
cmp_true_158:
cmp_end_159:
or_end_143:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_140
    b or_end_141
or_right_140:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_160
    adr x0, sign_id
    b cmp_end_161
cmp_true_160:
cmp_end_161:
or_end_141:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_138
    b or_end_139
or_right_138:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_162
    adr x0, sign_id
    b cmp_end_163
cmp_true_162:
cmp_end_163:
or_end_139:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_136
    b or_end_137
or_right_136:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_164
    adr x0, sign_id
    b cmp_end_165
cmp_true_164:
cmp_end_165:
or_end_137:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_134
    b or_end_135
or_right_134:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_166
    adr x0, sign_id
    b cmp_end_167
cmp_true_166:
cmp_end_167:
or_end_135:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_132
    b or_end_133
or_right_132:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_168
    adr x0, sign_id
    b cmp_end_169
cmp_true_168:
cmp_end_169:
or_end_133:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_130
    b or_end_131
or_right_130:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_170
    adr x0, sign_id
    b cmp_end_171
cmp_true_170:
cmp_end_171:
or_end_131:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_128
    b or_end_129
or_right_128:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_172
    adr x0, sign_id
    b cmp_end_173
cmp_true_172:
cmp_end_173:
or_end_129:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_126
    b or_end_127
or_right_126:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_174
    adr x0, sign_id
    b cmp_end_175
cmp_true_174:
cmp_end_175:
or_end_127:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_124
    b or_end_125
or_right_124:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_176
    adr x0, sign_id
    b cmp_end_177
cmp_true_176:
cmp_end_177:
or_end_125:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_122
    b or_end_123
or_right_122:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_178
    adr x0, sign_id
    b cmp_end_179
cmp_true_178:
cmp_end_179:
or_end_123:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_120
    b or_end_121
or_right_120:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_180
    adr x0, sign_id
    b cmp_end_181
cmp_true_180:
cmp_end_181:
or_end_121:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_118_119:
    // Closure for func_118
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_118
    ldr x0, [sp], #16
    bl _cons
    b cond_end_114
cond_false_113:
    adr x0, sign_id
cond_end_114:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, length
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_185
    tst x1, #1
    b.eq do_concat_185
do_apply_184:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_186
do_concat_185:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_186:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_182
    b after_func_187_188
func_187:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_192
    adr x0, sign_id
    b cmp_end_193
cmp_true_192:
cmp_end_193:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_190
    mov x0, #0
    b cond_end_191
cond_false_190:
    adr x0, sign_id
cond_end_191:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_189
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, length
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_195
    tst x1, #1
    b.eq do_concat_195
do_apply_194:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_196
do_concat_195:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_196:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_198
    tst x1, #1
    b.eq do_concat_198
do_apply_197:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_199
do_concat_198:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_199:
blk_end_189:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_187_188:
    // Closure for func_187
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_187
    ldr x0, [sp], #16
    bl _cons
    b cond_end_183
cond_false_182:
    adr x0, sign_id
cond_end_183:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, list_to_string
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_203
    tst x1, #1
    b.eq do_concat_203
do_apply_202:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_204
do_concat_203:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_204:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_200
    b after_func_205_206
func_205:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, length
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_209
    tst x1, #1
    b.eq do_concat_209
do_apply_208:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_210
do_concat_209:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_210:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_207
    adr x0, alloc
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_212
    tst x1, #1
    b.eq do_concat_212
do_apply_211:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_213
do_concat_212:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_213:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_207
    adr x0, _write_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_215
    tst x1, #1
    b.eq do_concat_215
do_apply_214:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_216
do_concat_215:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_216:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_218
    tst x1, #1
    b.eq do_concat_218
do_apply_217:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_219
do_concat_218:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_219:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_221
    tst x1, #1
    b.eq do_concat_221
do_apply_220:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_222
do_concat_221:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_222:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_207
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_207
    ldr x0, [x29, #-64]
blk_end_207:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_205_206:
    // Closure for func_205
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_205
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
    adr x0, _write_list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_226
    tst x1, #1
    b.eq do_concat_226
do_apply_225:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_227
do_concat_226:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_227:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_223
    b after_func_228_229
func_228:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_230_231
func_230:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_232_233
func_232:
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
    b.eq cmp_true_237
    adr x0, sign_id
    b cmp_end_238
cmp_true_237:
cmp_end_238:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_235
    mov x0, #0
    b cond_end_236
cond_false_235:
    adr x0, sign_id
cond_end_236:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_234
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_240
    tst x1, #1
    b.eq do_concat_240
do_apply_239:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_241
do_concat_240:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_241:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_234
    adr x0, _write_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_243
    tst x1, #1
    b.eq do_concat_243
do_apply_242:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_244
do_concat_243:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_244:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_246
    tst x1, #1
    b.eq do_concat_246
do_apply_245:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_247
do_concat_246:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_247:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_249
    tst x1, #1
    b.eq do_concat_249
do_apply_248:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_250
do_concat_249:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_250:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_252
    tst x1, #1
    b.eq do_concat_252
do_apply_251:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_253
do_concat_252:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_253:
blk_end_234:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_232_233:
    // Closure for func_232
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
    adr x1, func_232
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_230_231:
    // Closure for func_230
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_230
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_228_229:
    // Closure for func_228
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_228
    ldr x0, [sp], #16
    bl _cons
    b cond_end_224
cond_false_223:
    adr x0, sign_id
cond_end_224:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, tokenize
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_257
    tst x1, #1
    b.eq do_concat_257
do_apply_256:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_258
do_concat_257:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_258:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_254
    b after_func_259_260
func_259:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, scan
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_263
    tst x1, #1
    b.eq do_concat_263
do_apply_262:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_264
do_concat_263:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_264:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_261
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_261
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_267
    adr x0, sign_id
    b cmp_end_268
cmp_true_267:
cmp_end_268:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_265
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_270
    tst x1, #1
    b.eq do_concat_270
do_apply_269:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_271
do_concat_270:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_271:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_273
    tst x1, #1
    b.eq do_concat_273
do_apply_272:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_274
do_concat_273:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_274:
    b cond_end_266
cond_false_265:
    adr x0, sign_id
cond_end_266:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_261
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_276
    tst x1, #1
    b.eq do_concat_276
do_apply_275:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_277
do_concat_276:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_277:
    str x0, [sp, #-16]!
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_279
    tst x1, #1
    b.eq do_concat_279
do_apply_278:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_280
do_concat_279:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_280:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_282
    tst x1, #1
    b.eq do_concat_282
do_apply_281:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_283
do_concat_282:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_283:
blk_end_261:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_259_260:
    // Closure for func_259
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_259
    ldr x0, [sp], #16
    bl _cons
    b cond_end_255
cond_false_254:
    adr x0, sign_id
cond_end_255:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_287
    tst x1, #1
    b.eq do_concat_287
do_apply_286:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_288
do_concat_287:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_288:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_284
    b after_func_289_290
func_289:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_293
    tst x1, #1
    b.eq do_concat_293
do_apply_292:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_294
do_concat_293:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_294:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    adr x0, ch
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #-1
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_300
    tst x1, #1
    b.eq do_concat_300
do_apply_299:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_301
do_concat_300:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_301:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_303
    tst x1, #1
    b.eq do_concat_303
do_apply_302:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_304
do_concat_303:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_304:
    b cond_end_296
cond_false_295:
    adr x0, sign_id
cond_end_296:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    adr x0, is_digit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_308
    tst x1, #1
    b.eq do_concat_308
do_apply_307:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_309
do_concat_308:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_309:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_305
    adr x0, scan_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_311
    tst x1, #1
    b.eq do_concat_311
do_apply_310:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_312
do_concat_311:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_312:
    b cond_end_306
cond_false_305:
    adr x0, sign_id
cond_end_306:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_316
    tst x1, #1
    b.eq do_concat_316
do_apply_315:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_317
do_concat_316:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_317:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_313
    adr x0, scan_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_319
    tst x1, #1
    b.eq do_concat_319
do_apply_318:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_320
do_concat_319:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_320:
    b cond_end_314
cond_false_313:
    adr x0, sign_id
cond_end_314:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_324
    tst x1, #1
    b.eq do_concat_324
do_apply_323:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_325
do_concat_324:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_325:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_321
    adr x0, scan_op
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_327
    tst x1, #1
    b.eq do_concat_327
do_apply_326:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_328
do_concat_327:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_328:
    b cond_end_322
cond_false_321:
    adr x0, sign_id
cond_end_322:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_331
    adr x0, sign_id
    b cmp_end_332
cmp_true_331:
cmp_end_332:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_329
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_334
    tst x1, #1
    b.eq do_concat_334
do_apply_333:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_335
do_concat_334:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_335:
    b cond_end_330
cond_false_329:
    adr x0, sign_id
cond_end_330:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_338
    adr x0, sign_id
    b cmp_end_339
cmp_true_338:
cmp_end_339:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_336
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_342
    tst x1, #1
    b.eq do_concat_342
do_apply_341:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_343
do_concat_342:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_343:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_340
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_345
    tst x1, #1
    b.eq do_concat_345
do_apply_344:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_346
do_concat_345:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_346:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_348
    tst x1, #1
    b.eq do_concat_348
do_apply_347:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_349
do_concat_348:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_349:
blk_end_340:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_351
    tst x1, #1
    b.eq do_concat_351
do_apply_350:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_352
do_concat_351:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_352:
    b cond_end_337
cond_false_336:
    adr x0, sign_id
cond_end_337:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_354
    tst x1, #1
    b.eq do_concat_354
do_apply_353:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_355
do_concat_354:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_355:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_291
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_357
    tst x1, #1
    b.eq do_concat_357
do_apply_356:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_358
do_concat_357:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_358:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_360
    tst x1, #1
    b.eq do_concat_360
do_apply_359:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_361
do_concat_360:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_361:
blk_end_291:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_289_290:
    // Closure for func_289
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_289
    ldr x0, [sp], #16
    bl _cons
    b cond_end_285
cond_false_284:
    adr x0, sign_id
cond_end_285:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, skip_space
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_365
    tst x1, #1
    b.eq do_concat_365
do_apply_364:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_366
do_concat_365:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_366:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_362
    b after_func_367_368
func_367:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x0, [x0] // @ load
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_373
    tst x1, #1
    b.eq do_concat_373
do_apply_372:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_374
do_concat_373:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_374:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_370
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_377
    tst x1, #1
    b.eq do_concat_377
do_apply_376:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_378
do_concat_377:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_378:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_375
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_380
    tst x1, #1
    b.eq do_concat_380
do_apply_379:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_381
do_concat_380:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_381:
blk_end_375:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_383
    tst x1, #1
    b.eq do_concat_383
do_apply_382:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_384
do_concat_383:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_384:
    b cond_end_371
cond_false_370:
    adr x0, sign_id
cond_end_371:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_369
    mov x0, #0
blk_end_369:
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
    b cond_end_363
cond_false_362:
    adr x0, sign_id
cond_end_363:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_id
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_388
    tst x1, #1
    b.eq do_concat_388
do_apply_387:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_389
do_concat_388:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_389:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_385
    b after_func_390_391
func_390:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_394
    tst x1, #1
    b.eq do_concat_394
do_apply_393:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_395
do_concat_394:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_395:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_392
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_397
    tst x1, #1
    b.eq do_concat_397
do_apply_396:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_398
do_concat_397:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_398:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_392
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_400
    tst x1, #1
    b.eq do_concat_400
do_apply_399:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_401
do_concat_400:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_401:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_403
    tst x1, #1
    b.eq do_concat_403
do_apply_402:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_404
do_concat_403:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_404:
blk_end_392:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_390_391:
    // Closure for func_390
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_390
    ldr x0, [sp], #16
    bl _cons
    b cond_end_386
cond_false_385:
    adr x0, sign_id
cond_end_386:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_408
    tst x1, #1
    b.eq do_concat_408
do_apply_407:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_409
do_concat_408:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_409:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_405
    b after_func_410_411
func_410:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_415
    b or_end_416
or_right_415:
    adr x0, is_digit
or_end_416:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_418
    tst x1, #1
    b.eq do_concat_418
do_apply_417:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_419
do_concat_418:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_419:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_421
    tst x1, #1
    b.eq do_concat_421
do_apply_420:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_422
do_concat_421:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_422:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_413
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_424
    tst x1, #1
    b.eq do_concat_424
do_apply_423:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_425
do_concat_424:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_425:
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_427
    tst x1, #1
    b.eq do_concat_427
do_apply_426:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_428
do_concat_427:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_428:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_430
    tst x1, #1
    b.eq do_concat_430
do_apply_429:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_431
do_concat_430:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_431:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_433
    tst x1, #1
    b.eq do_concat_433
do_apply_432:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_434
do_concat_433:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_434:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_436
    tst x1, #1
    b.eq do_concat_436
do_apply_435:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_437
do_concat_436:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_437:
    b cond_end_414
cond_false_413:
    adr x0, sign_id
cond_end_414:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_412
    mov x0, #0
blk_end_412:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_410_411:
    // Closure for func_410
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_410
    ldr x0, [sp], #16
    bl _cons
    b cond_end_406
cond_false_405:
    adr x0, sign_id
cond_end_406:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_441
    tst x1, #1
    b.eq do_concat_441
do_apply_440:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_442
do_concat_441:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_442:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_438
    b after_func_443_444
func_443:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_446
    tst x1, #1
    b.eq do_concat_446
do_apply_445:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_447
do_concat_446:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_447:
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_449
    tst x1, #1
    b.eq do_concat_449
do_apply_448:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_450
do_concat_449:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_450:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_452
    tst x1, #1
    b.eq do_concat_452
do_apply_451:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_453
do_concat_452:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_453:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_455
    tst x1, #1
    b.eq do_concat_455
do_apply_454:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_456
do_concat_455:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
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
    b cond_end_439
cond_false_438:
    adr x0, sign_id
cond_end_439:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_num_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_460
    tst x1, #1
    b.eq do_concat_460
do_apply_459:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_461
do_concat_460:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_461:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_457
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, is_digit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_470
    tst x1, #1
    b.eq do_concat_470
do_apply_469:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_471
do_concat_470:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_471:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_467
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
    bl _add
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_472
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_474
    tst x1, #1
    b.eq do_concat_474
do_apply_473:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_475
do_concat_474:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_475:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_477
    tst x1, #1
    b.eq do_concat_477
do_apply_476:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_478
do_concat_477:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_478:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_480
    tst x1, #1
    b.eq do_concat_480
do_apply_479:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_481
do_concat_480:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_481:
blk_end_472:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_483
    tst x1, #1
    b.eq do_concat_483
do_apply_482:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_484
do_concat_483:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_484:
    b cond_end_468
cond_false_467:
    adr x0, sign_id
cond_end_468:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_466
    ldr x0, [x29, #-32]
blk_end_466:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_464_465:
    // Closure for func_464
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    b cond_end_458
cond_false_457:
    adr x0, sign_id
cond_end_458:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_488
    tst x1, #1
    b.eq do_concat_488
do_apply_487:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_489
do_concat_488:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_489:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_485
    b after_func_490_491
func_490:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, ch
    ldr x0, [x0] // @ load
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_494
    tst x1, #1
    b.eq do_concat_494
do_apply_493:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_495
do_concat_494:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_495:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_492
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_497
    tst x1, #1
    b.eq do_concat_497
do_apply_496:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_498
do_concat_497:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_498:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_492
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_500
    tst x1, #1
    b.eq do_concat_500
do_apply_499:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_501
do_concat_500:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_501:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_503
    tst x1, #1
    b.eq do_concat_503
do_apply_502:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_504
do_concat_503:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_504:
blk_end_492:
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
    b cond_end_486
cond_false_485:
    adr x0, sign_id
cond_end_486:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_508
    tst x1, #1
    b.eq do_concat_508
do_apply_507:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_509
do_concat_508:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_509:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_505
    b after_func_510_511
func_510:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_516
    tst x1, #1
    b.eq do_concat_516
do_apply_515:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_517
do_concat_516:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_517:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_513
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_519
    tst x1, #1
    b.eq do_concat_519
do_apply_518:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_520
do_concat_519:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_520:
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_522
    tst x1, #1
    b.eq do_concat_522
do_apply_521:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_523
do_concat_522:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_523:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_525
    tst x1, #1
    b.eq do_concat_525
do_apply_524:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_526
do_concat_525:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_526:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_528
    tst x1, #1
    b.eq do_concat_528
do_apply_527:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_529
do_concat_528:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_529:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_531
    tst x1, #1
    b.eq do_concat_531
do_apply_530:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_532
do_concat_531:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_532:
    b cond_end_514
cond_false_513:
    adr x0, sign_id
cond_end_514:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_512
    mov x0, #0
blk_end_512:
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
    b cond_end_506
cond_false_505:
    adr x0, sign_id
cond_end_506:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, scan_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_536
    tst x1, #1
    b.eq do_concat_536
do_apply_535:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_537
do_concat_536:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_537:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_533
    b after_func_538_539
func_538:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_542
    tst x1, #1
    b.eq do_concat_542
do_apply_541:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_543
do_concat_542:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_543:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_540
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_545
    tst x1, #1
    b.eq do_concat_545
do_apply_544:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_546
do_concat_545:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_546:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_548
    tst x1, #1
    b.eq do_concat_548
do_apply_547:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_549
do_concat_548:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_549:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_540
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_551
    tst x1, #1
    b.eq do_concat_551
do_apply_550:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_552
do_concat_551:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_552:
    str x0, [sp, #-16]!
    adr x0, list_to_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_554
    tst x1, #1
    b.eq do_concat_554
do_apply_553:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_555
do_concat_554:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_555:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_557
    tst x1, #1
    b.eq do_concat_557
do_apply_556:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_558
do_concat_557:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_558:
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
    b cond_end_534
cond_false_533:
    adr x0, sign_id
cond_end_534:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_562
    tst x1, #1
    b.eq do_concat_562
do_apply_561:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_563
do_concat_562:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_563:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_559
    b after_func_564_565
func_564:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_571
    adr x0, sign_id
    b cmp_end_572
cmp_true_571:
cmp_end_572:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_569
    b or_end_570
or_right_569:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_573
    adr x0, sign_id
    b cmp_end_574
cmp_true_573:
cmp_end_574:
or_end_570:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_567
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_577
    tst x1, #1
    b.eq do_concat_577
do_apply_576:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_578
do_concat_577:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_578:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_575
    mov x0, #0
blk_end_575:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_580
    tst x1, #1
    b.eq do_concat_580
do_apply_579:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_581
do_concat_580:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_581:
    b cond_end_568
cond_false_567:
    adr x0, sign_id
cond_end_568:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_566
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_583
    tst x1, #1
    b.eq do_concat_583
do_apply_582:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_584
do_concat_583:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_584:
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_586
    tst x1, #1
    b.eq do_concat_586
do_apply_585:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_587
do_concat_586:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_587:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_589
    tst x1, #1
    b.eq do_concat_589
do_apply_588:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_590
do_concat_589:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_590:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_592
    tst x1, #1
    b.eq do_concat_592
do_apply_591:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_593
do_concat_592:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_593:
blk_end_566:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_564_565:
    // Closure for func_564
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_564
    ldr x0, [sp], #16
    bl _cons
    b cond_end_560
cond_false_559:
    adr x0, sign_id
cond_end_560:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, main
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_597
    tst x1, #1
    b.eq do_concat_597
do_apply_596:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_598
do_concat_597:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_598:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_594
    b after_func_599_600
func_599:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_0
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_603
    tst x1, #1
    b.eq do_concat_603
do_apply_602:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_604
do_concat_603:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_604:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_606
    tst x1, #1
    b.eq do_concat_606
do_apply_605:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_607
do_concat_606:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_607:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_609
    tst x1, #1
    b.eq do_concat_609
do_apply_608:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_610
do_concat_609:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_610:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    adr x0, init_lexer
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_612
    tst x1, #1
    b.eq do_concat_612
do_apply_611:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_613
do_concat_612:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_613:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_615
    tst x1, #1
    b.eq do_concat_615
do_apply_614:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_616
do_concat_615:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_616:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_601
    adr x0, _process_list
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_618
    tst x1, #1
    b.eq do_concat_618
do_apply_617:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_619
do_concat_618:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_619:
blk_end_601:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_599_600:
    // Closure for func_599
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_599
    ldr x0, [sp], #16
    bl _cons
    b cond_end_595
cond_false_594:
    adr x0, sign_id
cond_end_595:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _process_list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_623
    tst x1, #1
    b.eq do_concat_623
do_apply_622:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_624
do_concat_623:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_624:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_620
    b after_func_625_626
func_625:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_630
    adr x0, sign_id
    b cmp_end_631
cmp_true_630:
cmp_end_631:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_628
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_634
    tst x1, #1
    b.eq do_concat_634
do_apply_633:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_635
do_concat_634:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_635:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_632
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_637
    tst x1, #1
    b.eq do_concat_637
do_apply_636:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_638
do_concat_637:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_638:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_632
    mov x0, #0
blk_end_632:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_640
    tst x1, #1
    b.eq do_concat_640
do_apply_639:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_641
do_concat_640:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_641:
    b cond_end_629
cond_false_628:
    adr x0, sign_id
cond_end_629:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_627
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_627
    adr x0, _print_token
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_643
    tst x1, #1
    b.eq do_concat_643
do_apply_642:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_644
do_concat_643:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_644:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_627
    adr x0, _process_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_646
    tst x1, #1
    b.eq do_concat_646
do_apply_645:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_647
do_concat_646:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_647:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_649
    tst x1, #1
    b.eq do_concat_649
do_apply_648:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_650
do_concat_649:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_650:
blk_end_627:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_625_626:
    // Closure for func_625
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_625
    ldr x0, [sp], #16
    bl _cons
    b cond_end_621
cond_false_620:
    adr x0, sign_id
cond_end_621:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _print_token
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_654
    tst x1, #1
    b.eq do_concat_654
do_apply_653:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_655
do_concat_654:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_655:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_651
    b after_func_656_657
func_656:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_661
    adr x0, sign_id
    b cmp_end_662
cmp_true_661:
cmp_end_662:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_659
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_3
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_665
    tst x1, #1
    b.eq do_concat_665
do_apply_664:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_666
do_concat_665:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_666:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_663
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_668
    tst x1, #1
    b.eq do_concat_668
do_apply_667:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_669
do_concat_668:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_669:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_663
    mov x0, #0
blk_end_663:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_671
    tst x1, #1
    b.eq do_concat_671
do_apply_670:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_672
do_concat_671:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_672:
    b cond_end_660
cond_false_659:
    adr x0, sign_id
cond_end_660:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    bl _add
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_675
    adr x0, sign_id
    b cmp_end_676
cmp_true_675:
cmp_end_676:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_673
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_4
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_679
    tst x1, #1
    b.eq do_concat_679
do_apply_678:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_680
do_concat_679:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_680:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_677
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_682
    tst x1, #1
    b.eq do_concat_682
do_apply_681:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_683
do_concat_682:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_683:
blk_end_677:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_685
    tst x1, #1
    b.eq do_concat_685
do_apply_684:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_686
do_concat_685:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_686:
    b cond_end_674
cond_false_673:
    adr x0, sign_id
cond_end_674:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_689
    adr x0, sign_id
    b cmp_end_690
cmp_true_689:
cmp_end_690:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_687
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_5
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_693
    tst x1, #1
    b.eq do_concat_693
do_apply_692:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_694
do_concat_693:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_694:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_691
    adr x0, print_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_696
    tst x1, #1
    b.eq do_concat_696
do_apply_695:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_697
do_concat_696:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_697:
blk_end_691:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_699
    tst x1, #1
    b.eq do_concat_699
do_apply_698:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_700
do_concat_699:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_700:
    b cond_end_688
cond_false_687:
    adr x0, sign_id
cond_end_688:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_703
    adr x0, sign_id
    b cmp_end_704
cmp_true_703:
cmp_end_704:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_701
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_707
    tst x1, #1
    b.eq do_concat_707
do_apply_706:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_708
do_concat_707:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_708:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_705
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_710
    tst x1, #1
    b.eq do_concat_710
do_apply_709:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_711
do_concat_710:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_711:
blk_end_705:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_713
    tst x1, #1
    b.eq do_concat_713
do_apply_712:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_714
do_concat_713:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_714:
    b cond_end_702
cond_false_701:
    adr x0, sign_id
cond_end_702:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_717
    adr x0, sign_id
    b cmp_end_718
cmp_true_717:
cmp_end_718:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_715
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_7
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_721
    tst x1, #1
    b.eq do_concat_721
do_apply_720:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_722
do_concat_721:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_722:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_719
    adr x0, print_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_724
    tst x1, #1
    b.eq do_concat_724
do_apply_723:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_725
do_concat_724:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_725:
blk_end_719:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_727
    tst x1, #1
    b.eq do_concat_727
do_apply_726:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_728
do_concat_727:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_728:
    b cond_end_716
cond_false_715:
    adr x0, sign_id
cond_end_716:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_731
    adr x0, sign_id
    b cmp_end_732
cmp_true_731:
cmp_end_732:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_729
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_8
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_735
    tst x1, #1
    b.eq do_concat_735
do_apply_734:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_736
do_concat_735:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_736:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_733
    adr x0, print_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_738
    tst x1, #1
    b.eq do_concat_738
do_apply_737:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_739
do_concat_738:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_739:
blk_end_733:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_741
    tst x1, #1
    b.eq do_concat_741
do_apply_740:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_742
do_concat_741:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_742:
    b cond_end_730
cond_false_729:
    adr x0, sign_id
cond_end_730:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_745
    adr x0, sign_id
    b cmp_end_746
cmp_true_745:
cmp_end_746:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_743
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_9
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_748
    tst x1, #1
    b.eq do_concat_748
do_apply_747:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_749
do_concat_748:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_749:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_751
    tst x1, #1
    b.eq do_concat_751
do_apply_750:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_752
do_concat_751:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_752:
    b cond_end_744
cond_false_743:
    adr x0, sign_id
cond_end_744:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_658
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_754
    tst x1, #1
    b.eq do_concat_754
do_apply_753:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_755
do_concat_754:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_755:
blk_end_658:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_656_657:
    // Closure for func_656
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_656
    ldr x0, [sp], #16
    bl _cons
    b cond_end_652
cond_false_651:
    adr x0, sign_id
cond_end_652:
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
.balign 8
.global _str_start
_str_start:
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

.global _str_end
_str_end:
