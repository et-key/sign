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
    adr x0, Parser
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
    adr x0, sign_id
    adr x1, Philosophy
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, -
    str x0, [sp, #-16]!
    adr x0, No
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
    adr x0, global
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
    adr x0, state
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, -
    str x0, [sp, #-16]!
    adr x0, No
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
    adr x0, local
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
    adr x0, bindings
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
    str x0, [sp, #-16]!
    b after_func_28_29
func_28:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_33_34
func_33:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_35_36
func_35:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_37_38
func_37:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_37_38:
    // Closure for func_37
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_37
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_39
do_apply_40:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_41
do_compose_39:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_41:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_42
do_apply_43:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_44
do_compose_42:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_44:
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
    str x0, [sp, #-16]!
    b after_func_45_46
func_45:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_45_46:
    // Closure for func_45
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_45
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_30
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_32
xor_true_30:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_31
    adr x0, sign_id
    b xor_end_32
xor_false_31:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_28_29:
    // Closure for func_28
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_28
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_47
do_apply_48:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_49
do_compose_47:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_49:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, -
    str x0, [sp, #-16]!
    adr x0, tokens
    str x0, [sp, #-16]!
    adr x0, >
    ldr x1, [sp], #16
    sub x0, x1, x0
    adr x1, Logic
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_50
do_apply_51:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_52
do_compose_50:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_52:
    str x0, [sp, #-16]!
    adr x0, ast_node
    str x0, [sp, #-16]!
    adr x0, remaining_tokens
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_53
do_apply_54:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_55
do_compose_53:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_55:
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
    b after_func_56_57
func_56:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_58_59
func_58:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_61
    b or_end_62
or_right_61:
    adr x0, tok
or_end_62:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_60
    adr x0, tok
    ldr x0, [x0] // @ load
blk_end_60:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_58_59:
    // Closure for func_58
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_58
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_63_64
func_63:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_65_66
func_65:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_68
    b or_end_69
or_right_68:
    adr x0, tok
or_end_69:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_67
    adr x0, tok
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
blk_end_67:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, streq
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_70
do_apply_71:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_72
do_compose_70:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_72:
    str x0, [sp, #-16]!
    adr x0, s1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_73
    adr x0, s2
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_73
    adr x0, s1
    ldr x0, [x0] // @ load
    adr x1, c1
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_73
    adr x0, s2
    ldr x0, [x0] // @ load
    adr x1, c2
    str x0, [x1]
    adr x0, sign_id
blk_end_73:
    cmp x0, #4096
    b.hi do_compose_74
do_apply_75:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_76
do_compose_74:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_76:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, c1
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, c2
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_80
    adr x0, sign_id
    b cmp_end_81
cmp_true_80:
cmp_end_81:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_78
    mov x0, #0
    b cond_end_79
cond_false_78:
    adr x0, sign_id
cond_end_79:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_77
    adr x0, c1
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.eq cond_false_82
    mov x0, #1
    b cond_end_83
cond_false_82:
    adr x0, sign_id
cond_end_83:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_77
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, s1
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_86
do_apply_87:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_88
do_compose_86:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_88:
    str x0, [sp, #-16]!
    adr x0, s2
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_89
do_apply_90:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_91
do_compose_89:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_91:
blk_end_77:
    cmp x0, #4096
    b.hi do_compose_92
do_apply_93:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_94
do_compose_92:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_94:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_95_96
func_95:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_97_98
func_97:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_100
    b or_end_101
or_right_100:
    adr x0, op_str
or_end_101:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_102
do_apply_103:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_104
do_compose_102:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_104:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_105
    mov x0, #15
    b cond_end_106
cond_false_105:
    adr x0, sign_id
cond_end_106:
    cmp x0, #4096
    b.hi do_compose_107
do_apply_108:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_109
do_compose_107:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_109:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_110
do_apply_111:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_112
do_compose_110:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_112:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sub x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_113
    mov x0, #15
    b cond_end_114
cond_false_113:
    adr x0, sign_id
cond_end_114:
    cmp x0, #4096
    b.hi do_compose_115
do_apply_116:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_117
do_compose_115:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_117:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_118
do_apply_119:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_120
do_compose_118:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_120:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    mul x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_121
    mov x0, #16
    b cond_end_122
cond_false_121:
    adr x0, sign_id
cond_end_122:
    cmp x0, #4096
    b.hi do_compose_123
do_apply_124:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_125
do_compose_123:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_125:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_126
do_apply_127:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_128
do_compose_126:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_128:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_129
    mov x0, #16
    b cond_end_130
cond_false_129:
    adr x0, sign_id
cond_end_130:
    cmp x0, #4096
    b.hi do_compose_131
do_apply_132:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_133
do_compose_131:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_133:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_134
do_apply_135:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_136
do_compose_134:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_136:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_137
    mov x0, #16
    b cond_end_138
cond_false_137:
    adr x0, sign_id
cond_end_138:
    cmp x0, #4096
    b.hi do_compose_139
do_apply_140:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_141
do_compose_139:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_141:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_142
do_apply_143:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_144
do_compose_142:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_144:
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_145
do_apply_146:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_147
do_compose_145:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_147:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    b after_func_148_149
func_148:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_150_151
func_150:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_152_153
func_152:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    mov x0, #5
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_152_153:
    // Closure for func_152
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_152
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_150_151:
    // Closure for func_150
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_150
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_148_149:
    // Closure for func_148
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_148
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_157
do_apply_158:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_159
do_compose_157:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_159:
    str x0, [sp, #-16]!
    mov x0, #6
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_160
do_apply_161:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_162
do_compose_160:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_162:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_165
    adr x0, sign_id
    b cmp_end_166
cmp_true_165:
cmp_end_166:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_163
    mov x0, #14
    b cond_end_164
cond_false_163:
    adr x0, sign_id
cond_end_164:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_170
do_apply_171:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_172
do_compose_170:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_172:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_173
    mov x0, #14
    b cond_end_174
cond_false_173:
    adr x0, sign_id
cond_end_174:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
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
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_183
    adr x0, sign_id
    b cmp_end_184
cmp_true_183:
cmp_end_184:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_181
    mov x0, #14
    b cond_end_182
cond_false_181:
    adr x0, sign_id
cond_end_182:
    cmp x0, #4096
    b.hi do_compose_185
do_apply_186:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_187
do_compose_185:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_187:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_188
do_apply_189:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_190
do_compose_188:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_190:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_193
    adr x0, sign_id
    b cmp_end_194
cmp_true_193:
cmp_end_194:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_191
    mov x0, #14
    b cond_end_192
cond_false_191:
    adr x0, sign_id
cond_end_192:
    cmp x0, #4096
    b.hi do_compose_195
do_apply_196:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_197
do_compose_195:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_197:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_203
    adr x0, sign_id
    b cmp_end_204
cmp_true_203:
cmp_end_204:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_201
    mov x0, #14
    b cond_end_202
cond_false_201:
    adr x0, sign_id
cond_end_202:
    cmp x0, #4096
    b.hi do_compose_205
do_apply_206:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_207
do_compose_205:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_207:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_208
do_apply_209:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_210
do_compose_208:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_210:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_213
    adr x0, sign_id
    b cmp_end_214
cmp_true_213:
cmp_end_214:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_211
    mov x0, #14
    b cond_end_212
cond_false_211:
    adr x0, sign_id
cond_end_212:
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
    b.ne blk_end_99
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_218
do_apply_219:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_220
do_compose_218:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_220:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_223
    adr x0, sign_id
    b cmp_end_224
cmp_true_223:
cmp_end_224:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_221
    mov x0, #14
    b cond_end_222
cond_false_221:
    adr x0, sign_id
cond_end_222:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_99
    mov x0, #0
blk_end_99:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_95_96:
    // Closure for func_95
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_95
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_233
    b or_end_234
or_right_233:
    adr x0, op_str
or_end_234:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_232
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
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
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_232
    b after_func_241_242
func_241:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_243_244
func_243:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_245_246
func_245:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_245_246:
    // Closure for func_245
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_245
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_243_244:
    // Closure for func_243
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_243
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_241_242:
    // Closure for func_241
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_241
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_232
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
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
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_232
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_253
do_apply_254:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_255
do_compose_253:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_255:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    bl _pow
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_256
    mov x0, #1
    b cond_end_257
cond_false_256:
    adr x0, sign_id
cond_end_257:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_232
    mov x0, #0
blk_end_232:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_230_231:
    // Closure for func_230
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_261_262
func_261:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_263_264
func_263:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_266
    b or_end_267
or_right_266:
    adr x0, tokens
or_end_267:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_265
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_270
    adr x0, sign_id
    b cmp_end_271
cmp_true_270:
cmp_end_271:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_268
    adr x0, tok_eof
    ldr x0, [x0]
    b cond_end_269
cond_false_268:
    adr x0, sign_id
cond_end_269:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_265
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tokens
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
blk_end_265:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_263_264:
    // Closure for func_263
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_263
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_261_262:
    // Closure for func_261
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_261
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_275_276
func_275:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_277_278
func_277:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_280
    b or_end_281
or_right_280:
    adr x0, tokens
or_end_281:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_279
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_284
    adr x0, sign_id
    b cmp_end_285
cmp_true_284:
cmp_end_285:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_282
    mov x0, #0
    b cond_end_283
cond_false_282:
    adr x0, sign_id
cond_end_283:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_279
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tokens
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
blk_end_279:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_277_278:
    // Closure for func_277
    adr x0, sign_id
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
    adr x1, func_275
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, expect
    str x0, [x1]
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, tokens
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_292
    adr x0, type
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_292
    adr x0, peek
    adr x1, tok
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_293
do_apply_294:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_295
do_compose_293:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_295:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_292
    adr x0, tok_type
    adr x1, tok_t
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x0, [x0]
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
blk_end_292:
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
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, tok_t
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, type
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_305
    adr x0, sign_id
    b cmp_end_306
cmp_true_305:
cmp_end_306:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_303
    mov x0, #1
    b cond_end_304
cond_false_303:
    adr x0, sign_id
cond_end_304:
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_307
do_apply_308:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_309
do_compose_307:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_309:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_302
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x1, [sp], #16
    bl _cons
blk_end_302:
    cmp x0, #4096
    b.hi do_compose_310
do_apply_311:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_312
do_compose_310:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_312:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_313_314
func_313:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_315_316
func_315:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_318
    b or_end_319
or_right_318:
    adr x0, tokens
or_end_319:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_320
do_apply_321:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_322
do_compose_320:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_322:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_317
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_323
do_apply_324:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_325
do_compose_323:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_325:
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_326
do_apply_327:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_328
do_compose_326:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_328:
    cmp x0, #4096
    b.hi do_compose_329
do_apply_330:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_331
do_compose_329:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_331:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_317:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_315_316:
    // Closure for func_315
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_315
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_332_333
func_332:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_334_335
func_334:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_337
    b or_end_338
or_right_337:
    adr x0, tokens
or_end_338:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_336
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_336
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_336
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_347
    adr x0, sign_id
    b cmp_end_348
cmp_true_347:
cmp_end_348:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_345
    mov x0, #0
    b cond_end_346
cond_false_345:
    adr x0, sign_id
cond_end_346:
    str x0, [sp, #-16]!
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_336
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_351
    adr x0, sign_id
    b cmp_end_352
cmp_true_351:
cmp_end_352:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_349
    ldr x0, [x29, #-48]
    b cond_end_350
cond_false_349:
    adr x0, sign_id
cond_end_350:
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, tokens
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_336
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_336
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    mov x0, #0
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
    b.ne blk_end_336
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    b.ne blk_end_336
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    b.ne blk_end_336
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
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
    b.ne blk_end_336
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
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
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_336:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_334_335:
    // Closure for func_334
    adr x0, sign_id
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
    adr x1, func_332
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_386_387
func_386:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_388_389
func_388:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_391
    b or_end_392
or_right_391:
    adr x0, tokens
or_end_392:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_390
    adr x0, str_1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_390
    adr x0, parse_program
    str x0, [sp, #-16]!
    adr x0, tokens
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
    adr x0, str_2
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
blk_end_390:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_388_389:
    // Closure for func_388
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_388
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_386_387:
    // Closure for func_386
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_386
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, parse_expr
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
    adr x0, tokens
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_402
    adr x0, min_prec
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_402
    adr x0, parse_primary
    adr x1, res_lhs
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_403
do_apply_404:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_405
do_compose_403:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_405:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_402
    adr x0, head
    adr x1, lhs
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_406
do_apply_407:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_408
do_compose_406:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_408:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_402
    adr x0, head
    adr x1, rest_1
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_lhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_409
do_apply_410:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_411
do_compose_409:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_411:
    cmp x0, #4096
    b.hi do_compose_412
do_apply_413:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_414
do_compose_412:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_414:
blk_end_402:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x0, [x0]
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
    adr x0, rest_1
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, min_prec
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, _parse_expr_loop
    str x0, [x1]
    adr x0, sign_id
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
    adr x0, lhs
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, tokens
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, min_prec
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, peek
    adr x1, tok
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_434
do_apply_435:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_436
do_compose_434:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_436:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, tok_type
    adr x1, type
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tok
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_437
do_apply_438:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_439
do_compose_437:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_439:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, parse_expr
    ldr x0, [x0]
    adr x1, res_rhs_apply
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    mov x0, #6
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, head
    adr x1, rhs_apply
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, res_rhs_apply
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, head
    adr x1, rest_rhs_apply
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs_apply
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, ast_apply
    ldr x0, [x0]
    adr x1, new_lhs_apply
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, rhs_apply
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, str_4
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, tok_val
    adr x1, op_str
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tok
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
    b.ne blk_end_433
    adr x0, get_prec
    adr x1, prec
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_458
do_apply_459:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_460
do_compose_458:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_460:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, next
    adr x1, next_tokens
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    b after_next_min_prec_impl_464
next_min_prec_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_465_466
func_465:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, prec
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_467
    b or_end_468
or_right_467:
    adr x0, prec
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
or_end_468:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_465_466:
    // Closure for func_465
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_465
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_next_min_prec_impl_464:
    // Closure for next_min_prec_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, next_min_prec_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, parse_expr
    ldr x0, [x0]
    adr x1, res_rhs_infix
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, next_tokens
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_469
do_apply_470:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_471
do_compose_469:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_471:
    str x0, [sp, #-16]!
    adr x0, next_min_prec
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_472
do_apply_473:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_474
do_compose_472:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_474:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, head
    adr x1, rhs_infix
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, res_rhs_infix
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_475
do_apply_476:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_477
do_compose_475:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_477:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, head
    adr x1, rest_rhs_infix
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res_rhs_infix
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_478
do_apply_479:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_480
do_compose_478:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_480:
    cmp x0, #4096
    b.hi do_compose_481
do_apply_482:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_483
do_compose_481:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_483:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_433
    adr x0, ast_infix
    ldr x0, [x0]
    adr x1, new_lhs_infix
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, rhs_infix
    ldr x0, [x0]
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
blk_end_433:
    cmp x0, #4096
    b.hi do_compose_484
do_apply_485:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_486
do_compose_484:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_486:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, str_5
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_487
    adr x0, can_start_expr
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_490
do_apply_491:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_492
do_compose_490:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_492:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_488
    adr x0, sign_id
    b cond_end_489
cond_false_488:
    adr x0, sign_id
cond_end_489:
    str x0, [sp, #-16]!
    adr x0, str_6
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_493
    adr x0, _parse_expr_loop
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, new_lhs_apply
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_494
do_apply_495:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_496
do_compose_494:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_496:
    str x0, [sp, #-16]!
    adr x0, rest_rhs_apply
    ldr x0, [x0]
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
    adr x0, min_prec
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
blk_end_493:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_487
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_508
    adr x0, sign_id
    b cmp_end_509
cmp_true_508:
cmp_end_509:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_506
    adr x0, lhs
    ldr x0, [x0]
    b cond_end_507
cond_false_506:
    adr x0, sign_id
cond_end_507:
    str x0, [sp, #-16]!
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_487
    adr x0, prec
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, min_prec
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_512
    adr x0, sign_id
    b cmp_end_513
cmp_true_512:
cmp_end_513:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_510
    adr x0, lhs
    ldr x0, [x0]
    b cond_end_511
cond_false_510:
    adr x0, sign_id
cond_end_511:
    str x0, [sp, #-16]!
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_487
    adr x0, _parse_expr_loop
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, new_lhs_infix
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, rest_rhs_infix
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_517
do_apply_518:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_519
do_compose_517:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_519:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_520
do_apply_521:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_522
do_compose_520:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_522:
blk_end_487:
    cmp x0, #4096
    b.hi do_compose_523
do_apply_524:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_525
do_compose_523:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_525:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_531
    b or_end_532
or_right_531:
    adr x0, type
    ldr x0, [x0]
or_end_532:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_530
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_535
    adr x0, sign_id
    b cmp_end_536
cmp_true_535:
cmp_end_536:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_533
    mov x0, #1
    b cond_end_534
cond_false_533:
    adr x0, sign_id
cond_end_534:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_530
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_539
    adr x0, sign_id
    b cmp_end_540
cmp_true_539:
cmp_end_540:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_537
    mov x0, #1
    b cond_end_538
cond_false_537:
    adr x0, sign_id
cond_end_538:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_530
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_543
    adr x0, sign_id
    b cmp_end_544
cmp_true_543:
cmp_end_544:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_541
    mov x0, #1
    b cond_end_542
cond_false_541:
    adr x0, sign_id
cond_end_542:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_530
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_547
    adr x0, sign_id
    b cmp_end_548
cmp_true_547:
cmp_end_548:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_545
    mov x0, #1
    b cond_end_546
cond_false_545:
    adr x0, sign_id
cond_end_546:
    str x0, [sp, #-16]!
    adr x0, str_7
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_530
    mov x0, #0
blk_end_530:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_528_529:
    // Closure for func_528
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_552_553
func_552:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_554_555
func_554:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_557
    b or_end_558
or_right_557:
    adr x0, op
or_end_558:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_556
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op
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
    adr x0, "
    bl _factorial
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
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b.ne blk_end_556
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op
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
    ldr x0, [x29, #-64]
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
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_556
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op
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
    ldr x0, [x29, #-80]
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
    add x0, x29, #-80
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_580
    mov x0, #1
    b cond_end_581
cond_false_580:
    adr x0, sign_id
cond_end_581:
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
    b.ne blk_end_556
    adr x0, streq
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op
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
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_588
    mov x0, #1
    b cond_end_589
cond_false_588:
    adr x0, sign_id
cond_end_589:
    cmp x0, #4096
    b.hi do_compose_590
do_apply_591:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_592
do_compose_590:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_592:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_556
    mov x0, #0
blk_end_556:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_554_555:
    // Closure for func_554
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_554
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_593_594
func_593:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_595_596
func_595:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_598
    b or_end_599
or_right_598:
    adr x0, tokens
or_end_599:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_597
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    b.ne blk_end_597
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_597
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    b.ne blk_end_597
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_611
    adr x0, sign_id
    b cmp_end_612
cmp_true_611:
cmp_end_612:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_609
    adr x0, sign_id
    b cond_end_610
cond_false_609:
    adr x0, sign_id
cond_end_610:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_614
do_apply_615:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_616
do_compose_614:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_616:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_613
    adr x0, ast_num
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_613:
    cmp x0, #4096
    b.hi do_compose_617
do_apply_618:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_619
do_compose_617:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_619:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_597
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_622
    adr x0, sign_id
    b cmp_end_623
cmp_true_622:
cmp_end_623:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_620
    adr x0, sign_id
    b cond_end_621
cond_false_620:
    adr x0, sign_id
cond_end_621:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_624
    adr x0, ast_id
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_624:
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
    b.ne blk_end_597
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_633
    adr x0, sign_id
    b cmp_end_634
cmp_true_633:
cmp_end_634:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_631
    adr x0, sign_id
    b cond_end_632
cond_false_631:
    adr x0, sign_id
cond_end_632:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_636
do_apply_637:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_638
do_compose_636:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_638:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_635
    adr x0, ast_str
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_635:
    cmp x0, #4096
    b.hi do_compose_639
do_apply_640:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_641
do_compose_639:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_641:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_597
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_644
    adr x0, sign_id
    b cmp_end_645
cmp_true_644:
cmp_end_645:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_642
    adr x0, sign_id
    b cond_end_643
cond_false_642:
    adr x0, sign_id
cond_end_643:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_647
do_apply_648:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_649
do_compose_647:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_649:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_646
    adr x0, is_prefix_op
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_650
do_apply_651:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_652
do_compose_650:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_652:
    str x0, [sp, #-16]!
    adr x0, str_8
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_653
    adr x0, parse_expr
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    mov x0, #20
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
    str x0, [sp, #-16]!
    adr x0, str_9
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
    b.ne blk_end_653
    adr x0, ast_prefix
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_653:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_646
    adr x0, str_10
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_646
    adr x0, ast_op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_646:
    cmp x0, #4096
    b.hi do_compose_675
do_apply_676:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_677
do_compose_675:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_677:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_597
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_680
    adr x0, sign_id
    b cmp_end_681
cmp_true_680:
cmp_end_681:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_678
    adr x0, sign_id
    b cond_end_679
cond_false_678:
    adr x0, sign_id
cond_end_679:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_683
do_apply_684:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_685
do_compose_683:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_685:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_682
    ldr x0, [x29, #-208]
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_688
    adr x0, sign_id
    b cmp_end_689
cmp_true_688:
cmp_end_689:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_686
    adr x0, sign_id
    b cond_end_687
cond_false_686:
    adr x0, sign_id
cond_end_687:
    str x0, [sp, #-16]!
    adr x0, str_11
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_690
    adr x0, parse_block
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
blk_end_690:
    cmp x0, #4096
    b.hi do_compose_694
do_apply_695:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_696
do_compose_694:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_696:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_682
    ldr x0, [x29, #-208]
    str x0, [sp, #-16]!
    mov x0, #40
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
    b.eq cond_false_697
    adr x0, sign_id
    b cond_end_698
cond_false_697:
    adr x0, sign_id
cond_end_698:
    str x0, [sp, #-16]!
    adr x0, str_12
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    cmp x0, #4096
    b.hi do_compose_702
do_apply_703:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_704
do_compose_702:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_704:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
    cmp x0, #4096
    b.hi do_compose_705
do_apply_706:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_707
do_compose_705:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_707:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
    cmp x0, #4096
    b.hi do_compose_708
do_apply_709:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_710
do_compose_708:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_710:
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
    b.ne blk_end_701
    adr x0, str_13
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-256]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, str_14
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, str_15
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, is_null
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-256]
    cmp x0, #4096
    b.hi do_compose_726
do_apply_727:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_728
do_compose_726:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_728:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-256]
    cmp x0, #4096
    b.hi do_compose_729
do_apply_730:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_731
do_compose_729:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_731:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_701:
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
    b.ne blk_end_682
    adr x0, str_16
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_682
    adr x0, ast_unit
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_682:
    cmp x0, #4096
    b.hi do_compose_735
do_apply_736:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_737
do_compose_735:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_737:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_597
    adr x0, str_17
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_597
    adr x0, ast_unit
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_597:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_595_596:
    // Closure for func_595
    adr x0, sign_id
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
    adr x1, func_593
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, parse_block_impl
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_738
do_apply_739:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_740
do_compose_738:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_740:
    str x0, [sp, #-16]!
    adr x0, tokens
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, parse_stmts
    adr x1, res
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    b.ne blk_end_741
    adr x0, head
    adr x1, exprs
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, res
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_745
do_apply_746:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_747
do_compose_745:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_747:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, head
    adr x1, rest
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, res
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_748
do_apply_749:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_750
do_compose_748:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_750:
    cmp x0, #4096
    b.hi do_compose_751
do_apply_752:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_753
do_compose_751:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_753:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, peek
    adr x1, tok_r
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_754
do_apply_755:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_756
do_compose_754:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_756:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, transform_section
    adr x1, node
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
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
blk_end_741:
    cmp x0, #4096
    b.hi do_compose_760
do_apply_761:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_762
do_compose_760:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_762:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_763
do_apply_764:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_765
do_compose_763:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_765:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_766
do_apply_767:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_768
do_compose_766:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_768:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, is_null
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_769
do_apply_770:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_771
do_compose_769:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_771:
    str x0, [sp, #-16]!
    adr x0, list
    cmp x0, #4096
    b.hi do_compose_772
do_apply_773:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_774
do_compose_772:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_774:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, list
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_778
    adr x0, sign_id
    b cmp_end_779
cmp_true_778:
cmp_end_779:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_776
    mov x0, #1
    b cond_end_777
cond_false_776:
    adr x0, sign_id
cond_end_777:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_775
    mov x0, #0
blk_end_775:
    cmp x0, #4096
    b.hi do_compose_780
do_apply_781:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_782
do_compose_780:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_782:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_783_784
func_783:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_785_786
func_785:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_788
    b or_end_789
or_right_788:
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_790
do_apply_791:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_792
do_compose_790:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_792:
or_end_789:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_787
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, val
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_787:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_785_786:
    // Closure for func_785
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_785
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_783_784:
    // Closure for func_783
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_783
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_793_794
func_793:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_795_796
func_795:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_798
    b or_end_799
or_right_798:
    adr x0, val
or_end_799:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_797
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_800
do_apply_801:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_802
do_compose_800:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_802:
    str x0, [sp, #-16]!
    adr x0, val
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
blk_end_797:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_795_796:
    // Closure for func_795
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_795
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_793_794:
    // Closure for func_793
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_793
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_811
    b or_end_812
or_right_811:
    adr x0, val
or_end_812:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_810
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_813
do_apply_814:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_815
do_compose_813:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_815:
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_816
do_apply_817:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_818
do_compose_816:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_818:
blk_end_810:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_808_809:
    // Closure for func_808
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_819_820
func_819:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_821_822
func_821:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_824
    b or_end_825
or_right_824:
    adr x0, val
or_end_825:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_823
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_829
do_apply_830:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_831
do_compose_829:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_831:
blk_end_823:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_821_822:
    // Closure for func_821
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_821
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_819_820:
    // Closure for func_819
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_819
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_832_833
func_832:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_834_835
func_834:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_837
    b or_end_838
or_right_837:
    adr x0, val
or_end_838:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_836
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_839
do_apply_840:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_841
do_compose_839:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_841:
    str x0, [sp, #-16]!
    adr x0, val
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
blk_end_836:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_834_835:
    // Closure for func_834
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_834
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_832_833:
    // Closure for func_832
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_832
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_845_846
func_845:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_847_848
func_847:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_850
    b or_end_851
or_right_850:
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_852
do_apply_853:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_854
do_compose_852:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_854:
    str x0, [sp, #-16]!
    adr x0, rhs
    cmp x0, #4096
    b.hi do_compose_855
do_apply_856:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_857
do_compose_855:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_857:
or_end_851:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_849
    adr x0, ast_infix
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, rhs
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
blk_end_849:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_847_848:
    // Closure for func_847
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_847
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_845_846:
    // Closure for func_845
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_845
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_858_859
func_858:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_860_861
func_860:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_863
    b or_end_864
or_right_863:
    adr x0, params
    str x0, [sp, #-16]!
    adr x0, body
    cmp x0, #4096
    b.hi do_compose_865
do_apply_866:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_867
do_compose_865:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_867:
or_end_864:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_862
    b after_func_868_869
func_868:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_870_871
func_870:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, params
    cmp x0, #4096
    b.hi do_compose_872
do_apply_873:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_874
do_compose_872:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_874:
    str x0, [sp, #-16]!
    adr x0, body
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_870_871:
    // Closure for func_870
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_870
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_868_869:
    // Closure for func_868
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_868
    ldr x0, [sp], #16
    bl _cons
blk_end_862:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_858_859:
    // Closure for func_858
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_858
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, transform_section
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_878
do_apply_879:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_880
do_compose_878:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_880:
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_881
    adr x0, length
    adr x1, len
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_882
do_apply_883:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_884
do_compose_882:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_884:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_881
    adr x0, make_id
    adr x1, p1
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_885
do_apply_886:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_887
do_compose_885:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_887:
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_888
do_apply_889:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_890
do_compose_888:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_890:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_891
do_apply_892:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_893
do_compose_891:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_893:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_881
    adr x0, make_id
    adr x1, p2
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_894
do_apply_895:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_896
do_compose_894:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_896:
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_897
do_apply_898:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_899
do_compose_897:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_899:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_900
do_apply_901:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_902
do_compose_900:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_902:
blk_end_881:
    cmp x0, #4096
    b.hi do_compose_903
do_apply_904:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_905
do_compose_903:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_905:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, len
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
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
    adr x0, _transform_section_1
    b cond_end_908
cond_false_907:
    adr x0, sign_id
cond_end_908:
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_911
do_apply_912:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_913
do_compose_911:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_913:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_914
do_apply_915:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_916
do_compose_914:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_916:
    str x0, [sp, #-16]!
    adr x0, p2
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_917
do_apply_918:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_919
do_compose_917:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_919:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_906
    adr x0, len
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_922
    adr x0, sign_id
    b cmp_end_923
cmp_true_922:
cmp_end_923:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_920
    adr x0, _transform_section_2
    b cond_end_921
cond_false_920:
    adr x0, sign_id
cond_end_921:
    str x0, [sp, #-16]!
    adr x0, exprs
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
    adr x0, p1
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, p2
    ldr x0, [x0]
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
    b.ne blk_end_906
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_906:
    cmp x0, #4096
    b.hi do_compose_933
do_apply_934:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_935
do_compose_933:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_935:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, _transform_section_1
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_936
do_apply_937:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_938
do_compose_936:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_938:
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_939
    adr x0, p1
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_939
    adr x0, p2
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_939
    adr x0, head
    adr x1, e1
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_939
    adr x0, head
    adr x1, type
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_939
    adr x0, tok_val
    adr x1, op_str
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e1
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
    cmp x0, #4096
    b.hi do_compose_949
do_apply_950:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_951
do_compose_949:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_951:
    cmp x0, #4096
    b.hi do_compose_952
do_apply_953:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_954
do_compose_952:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_954:
blk_end_939:
    cmp x0, #4096
    b.hi do_compose_955
do_apply_956:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_957
do_compose_955:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_957:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_961
    adr x0, sign_id
    b cmp_end_962
cmp_true_961:
cmp_end_962:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_959
    adr x0, make_lambda
    b cond_end_960
cond_false_959:
    adr x0, sign_id
cond_end_960:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_963
do_apply_964:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_965
do_compose_963:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_965:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_966
do_apply_967:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_968
do_compose_966:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_968:
    str x0, [sp, #-16]!
    adr x0, p2
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_969
do_apply_970:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_971
do_compose_969:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_971:
    ldr x1, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_972
do_apply_973:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_974
do_compose_972:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_974:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_975
do_apply_976:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_977
do_compose_975:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_977:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_978
do_apply_979:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_980
do_compose_978:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_980:
    str x0, [sp, #-16]!
    adr x0, p2
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_981
do_apply_982:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_983
do_compose_981:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_983:
    cmp x0, #4096
    b.hi do_compose_984
do_apply_985:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_986
do_compose_984:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_986:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_958
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_958:
    cmp x0, #4096
    b.hi do_compose_987
do_apply_988:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_989
do_compose_987:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_989:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x1, _transform_section_2
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_990
do_apply_991:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_992
do_compose_990:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_992:
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_993
    adr x0, p1
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_993
    adr x0, p2
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_993
    adr x0, head
    adr x1, e1
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_994
do_apply_995:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_996
do_compose_994:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_996:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_993
    adr x0, head
    adr x1, e2
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_997
do_apply_998:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_999
do_compose_997:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_999:
    cmp x0, #4096
    b.hi do_compose_1000
do_apply_1001:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1002
do_compose_1000:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1002:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_993
    adr x0, head
    adr x1, t1
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1003
do_apply_1004:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1005
do_compose_1003:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1005:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_993
    adr x0, head
    adr x1, t2
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1006
do_apply_1007:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1008
do_compose_1006:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1008:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_993
    adr x0, tok_val
    adr x1, op_str_1
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1009
do_apply_1010:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1011
do_compose_1009:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1011:
    cmp x0, #4096
    b.hi do_compose_1012
do_apply_1013:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1014
do_compose_1012:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1014:
    cmp x0, #4096
    b.hi do_compose_1015
do_apply_1016:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1017
do_compose_1015:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1017:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_993
    adr x0, tok_val
    adr x1, op_str_2
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1018
do_apply_1019:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1020
do_compose_1018:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1020:
    cmp x0, #4096
    b.hi do_compose_1021
do_apply_1022:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1023
do_compose_1021:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1023:
    cmp x0, #4096
    b.hi do_compose_1024
do_apply_1025:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1026
do_compose_1024:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1026:
blk_end_993:
    cmp x0, #4096
    b.hi do_compose_1027
do_apply_1028:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1029
do_compose_1027:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1029:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ?
    str x0, [sp, #-16]!
    adr x0, t1
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1033
    adr x0, sign_id
    b cmp_end_1034
cmp_true_1033:
cmp_end_1034:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1031
    adr x0, make_lambda
    b cond_end_1032
cond_false_1031:
    adr x0, sign_id
cond_end_1032:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1035
do_apply_1036:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1037
do_compose_1035:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1037:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str_1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1038
do_apply_1039:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1040
do_compose_1038:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1040:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1041
do_apply_1042:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1043
do_compose_1041:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1043:
    str x0, [sp, #-16]!
    adr x0, e2
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1044
do_apply_1045:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1046
do_compose_1044:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1046:
    cmp x0, #4096
    b.hi do_compose_1047
do_apply_1048:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1049
do_compose_1047:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1049:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1030
    adr x0, t2
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1052
    adr x0, sign_id
    b cmp_end_1053
cmp_true_1052:
cmp_end_1053:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1050
    adr x0, make_lambda
    b cond_end_1051
cond_false_1050:
    adr x0, sign_id
cond_end_1051:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1054
do_apply_1055:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1056
do_compose_1054:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1056:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, op_str_2
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1057
do_apply_1058:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1059
do_compose_1057:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1059:
    str x0, [sp, #-16]!
    adr x0, e1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1060
do_apply_1061:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1062
do_compose_1060:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1062:
    str x0, [sp, #-16]!
    adr x0, p1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1063
do_apply_1064:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1065
do_compose_1063:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1065:
    cmp x0, #4096
    b.hi do_compose_1066
do_apply_1067:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1068
do_compose_1066:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1068:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1030
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, exprs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_1030:
    cmp x0, #4096
    b.hi do_compose_1069
do_apply_1070:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1071
do_compose_1069:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1071:
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
Logic: .quad 0
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
tok_eof: .quad 0
tok_id: .quad 0
tok_num: .quad 0
tok_str: .quad 0
tok_op: .quad 0
tok_punc: .quad 0
tok_sep: .quad 0
tok_unit: .quad 0
streq: .quad 0
c1: .quad 0
c2: .quad 0
expect: .quad 0
tok: .quad 0
tok_t: .quad 0
parse_expr: .quad 0
res_lhs: .quad 0
lhs: .quad 0
rest_1: .quad 0
_parse_expr_loop: .quad 0
type: .quad 0
res_rhs_apply: .quad 0
rhs_apply: .quad 0
rest_rhs_apply: .quad 0
new_lhs_apply: .quad 0
op_str: .quad 0
prec: .quad 0
next_tokens: .quad 0
next_min_prec: .quad 0
res_rhs_infix: .quad 0
rhs_infix: .quad 0
rest_rhs_infix: .quad 0
new_lhs_infix: .quad 0
parse_block_impl: .quad 0
res: .quad 0
exprs: .quad 0
rest: .quad 0
tok_r: .quad 0
node: .quad 0
is_null: .quad 0
transform_section: .quad 0
len: .quad 0
p1: .quad 0
p2: .quad 0
_transform_section_1: .quad 0
e1: .quad 0
_transform_section_2: .quad 0
e2: .quad 0
t1: .quad 0
t2: .quad 0
op_str_1: .quad 0
op_str_2: .quad 0


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

