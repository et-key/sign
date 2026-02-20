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
    b after_func_70_71
func_70:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_72_73
func_72:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_75
    b or_end_76
or_right_75:
    adr x0, s1
or_end_76:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_74
    b after_func_77_78
func_77:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, s1
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_79
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_79
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_82
    adr x0, sign_id
    b cmp_end_83
cmp_true_82:
cmp_end_83:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_80
    mov x0, #0
    b cond_end_81
cond_false_80:
    adr x0, sign_id
cond_end_81:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_79
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_86
    adr x0, sign_id
    b cmp_end_87
cmp_true_86:
cmp_end_87:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_84
    mov x0, #1
    b cond_end_85
cond_false_84:
    adr x0, sign_id
cond_end_85:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_79
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, s1
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_88
do_apply_89:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_90
do_compose_88:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_90:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_91
do_apply_92:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_93
do_compose_91:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_93:
blk_end_79:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_77_78:
    // Closure for func_77
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_77
    ldr x0, [sp], #16
    bl _cons
blk_end_74:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_72_73:
    // Closure for func_72
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_72
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_70_71:
    // Closure for func_70
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_70
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_94_95
func_94:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_96_97
func_96:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_99
    b or_end_100
or_right_99:
    adr x0, op_str
or_end_100:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_101
do_apply_102:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_103
do_compose_101:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_103:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_104
    mov x0, #15
    b cond_end_105
cond_false_104:
    adr x0, sign_id
cond_end_105:
    cmp x0, #4096
    b.hi do_compose_106
do_apply_107:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_108
do_compose_106:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_108:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_109
do_apply_110:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_111
do_compose_109:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_111:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sub x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_112
    mov x0, #15
    b cond_end_113
cond_false_112:
    adr x0, sign_id
cond_end_113:
    cmp x0, #4096
    b.hi do_compose_114
do_apply_115:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_116
do_compose_114:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_116:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_117
do_apply_118:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_119
do_compose_117:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_119:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    mul x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_120
    mov x0, #16
    b cond_end_121
cond_false_120:
    adr x0, sign_id
cond_end_121:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
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
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_128
    mov x0, #16
    b cond_end_129
cond_false_128:
    adr x0, sign_id
cond_end_129:
    cmp x0, #4096
    b.hi do_compose_130
do_apply_131:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_132
do_compose_130:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_132:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_133
do_apply_134:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_135
do_compose_133:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_135:
    str x0, [sp, #-16]!
    adr x0, "
    str x0, [sp, #-16]!
    adr x0, "
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_136
    mov x0, #16
    b cond_end_137
cond_false_136:
    adr x0, sign_id
cond_end_137:
    cmp x0, #4096
    b.hi do_compose_138
do_apply_139:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_140
do_compose_138:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_140:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_141
do_apply_142:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_143
do_compose_141:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_143:
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_144
do_apply_145:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_146
do_compose_144:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_146:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    b after_func_147_148
func_147:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_149_150
func_149:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_151_152
func_151:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    mov x0, #5
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_151_152:
    // Closure for func_151
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_151
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_149_150:
    // Closure for func_149
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_149
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_147_148:
    // Closure for func_147
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_147
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
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
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    mov x0, #6
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_159
do_apply_160:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_161
do_compose_159:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_161:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_164
    adr x0, sign_id
    b cmp_end_165
cmp_true_164:
cmp_end_165:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_162
    mov x0, #14
    b cond_end_163
cond_false_162:
    adr x0, sign_id
cond_end_163:
    cmp x0, #4096
    b.hi do_compose_166
do_apply_167:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_168
do_compose_166:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_168:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_172
    mov x0, #14
    b cond_end_173
cond_false_172:
    adr x0, sign_id
cond_end_173:
    cmp x0, #4096
    b.hi do_compose_174
do_apply_175:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_176
do_compose_174:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_176:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_177
do_apply_178:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_179
do_compose_177:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_179:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_182
    adr x0, sign_id
    b cmp_end_183
cmp_true_182:
cmp_end_183:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_180
    mov x0, #14
    b cond_end_181
cond_false_180:
    adr x0, sign_id
cond_end_181:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
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
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_192
    adr x0, sign_id
    b cmp_end_193
cmp_true_192:
cmp_end_193:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_190
    mov x0, #14
    b cond_end_191
cond_false_190:
    adr x0, sign_id
cond_end_191:
    cmp x0, #4096
    b.hi do_compose_194
do_apply_195:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_196
do_compose_194:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_196:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_197
do_apply_198:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_199
do_compose_197:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_199:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_202
    adr x0, sign_id
    b cmp_end_203
cmp_true_202:
cmp_end_203:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_200
    mov x0, #14
    b cond_end_201
cond_false_200:
    adr x0, sign_id
cond_end_201:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
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
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_212
    adr x0, sign_id
    b cmp_end_213
cmp_true_212:
cmp_end_213:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_210
    mov x0, #14
    b cond_end_211
cond_false_210:
    adr x0, sign_id
cond_end_211:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_222
    adr x0, sign_id
    b cmp_end_223
cmp_true_222:
cmp_end_223:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_220
    mov x0, #14
    b cond_end_221
cond_false_220:
    adr x0, sign_id
cond_end_221:
    cmp x0, #4096
    b.hi do_compose_224
do_apply_225:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_226
do_compose_224:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_226:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_98
    mov x0, #0
blk_end_98:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_94_95:
    // Closure for func_94
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_94
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_232
    b or_end_233
or_right_232:
    adr x0, op_str
or_end_233:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_231
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
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
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_231
    b after_func_240_241
func_240:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_242_243
func_242:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_244_245
func_244:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_244_245:
    // Closure for func_244
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_244
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_242_243:
    // Closure for func_242
    adr x0, sign_id
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
    adr x1, func_240
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_231
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_249
do_apply_250:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_251
do_compose_249:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_251:
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_231
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op_str
    cmp x0, #4096
    b.hi do_compose_252
do_apply_253:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_254
do_compose_252:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_254:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    bl _pow
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_255
    mov x0, #1
    b cond_end_256
cond_false_255:
    adr x0, sign_id
cond_end_256:
    cmp x0, #4096
    b.hi do_compose_257
do_apply_258:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_259
do_compose_257:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_259:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_231
    mov x0, #0
blk_end_231:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_260_261
func_260:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_262_263
func_262:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_265
    b or_end_266
or_right_265:
    adr x0, tokens
or_end_266:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_264
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_269
    adr x0, sign_id
    b cmp_end_270
cmp_true_269:
cmp_end_270:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_267
    adr x0, tok_eof
    ldr x0, [x0]
    b cond_end_268
cond_false_267:
    adr x0, sign_id
cond_end_268:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_264
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_271
do_apply_272:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_273
do_compose_271:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_273:
blk_end_264:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_262_263:
    // Closure for func_262
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_262
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_260_261:
    // Closure for func_260
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_260
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_279
    b or_end_280
or_right_279:
    adr x0, tokens
or_end_280:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_278
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_283
    adr x0, sign_id
    b cmp_end_284
cmp_true_283:
cmp_end_284:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_281
    mov x0, #0
    b cond_end_282
cond_false_281:
    adr x0, sign_id
cond_end_282:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_278
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tokens
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
blk_end_278:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_288_289
func_288:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_290_291
func_290:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_293
    b or_end_294
or_right_293:
    adr x0, tokens
or_end_294:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_292
    b after_func_295_296
func_295:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_298
do_apply_299:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_300
do_compose_298:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_300:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_297
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_301
do_apply_302:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_303
do_compose_301:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_303:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_297
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_306
    adr x0, sign_id
    b cmp_end_307
cmp_true_306:
cmp_end_307:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_304
    mov x0, #1
    b cond_end_305
cond_false_304:
    adr x0, sign_id
cond_end_305:
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, tokens
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_297
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x1, [sp], #16
    bl _cons
blk_end_297:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_295_296:
    // Closure for func_295
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_295
    ldr x0, [sp], #16
    bl _cons
blk_end_292:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_290_291:
    // Closure for func_290
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_290
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_288_289:
    // Closure for func_288
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_288
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
    adr x0, tokens
or_end_317:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_315
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_315
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
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
    b after_func_330_331
func_330:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_332_333
func_332:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_335
    b or_end_336
or_right_335:
    adr x0, tokens
or_end_336:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_334
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_337
do_apply_338:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_339
do_compose_337:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_339:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_334
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_340
do_apply_341:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_342
do_compose_340:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_342:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_334
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_345
    adr x0, sign_id
    b cmp_end_346
cmp_true_345:
cmp_end_346:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_343
    mov x0, #0
    b cond_end_344
cond_false_343:
    adr x0, sign_id
cond_end_344:
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
    b.ne blk_end_334
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_349
    adr x0, sign_id
    b cmp_end_350
cmp_true_349:
cmp_end_350:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_347
    ldr x0, [x29, #-48]
    b cond_end_348
cond_false_347:
    adr x0, sign_id
cond_end_348:
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, tokens
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
    b.ne blk_end_334
    adr x0, str_0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_334
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
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
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_334
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_334
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    cmp x0, #4096
    b.hi do_compose_369
do_apply_370:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_371
do_compose_369:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_371:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_334
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
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
    b.ne blk_end_334
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
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
blk_end_334:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_384_385
func_384:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_386_387
func_386:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_389
    b or_end_390
or_right_389:
    adr x0, tokens
or_end_390:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_388
    adr x0, str_1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_388
    adr x0, parse_program
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_391
do_apply_392:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_393
do_compose_391:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_393:
    str x0, [sp, #-16]!
    adr x0, str_2
    cmp x0, #4096
    b.hi do_compose_394
do_apply_395:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_396
do_compose_394:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_396:
blk_end_388:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_384_385:
    // Closure for func_384
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_384
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_397_398
func_397:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_399_400
func_399:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_402
    b or_end_403
or_right_402:
    adr x0, tokens
or_end_403:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_401
    b after_func_404_405
func_404:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, parse_primary
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_407
do_apply_408:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_409
do_compose_407:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_409:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_406
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_410
do_apply_411:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_412
do_compose_410:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_412:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_406
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_406
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_425
do_apply_426:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_427
do_compose_425:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_427:
blk_end_406:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_404_405:
    // Closure for func_404
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_404
    ldr x0, [sp], #16
    bl _cons
blk_end_401:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_399_400:
    // Closure for func_399
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_399
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_397_398:
    // Closure for func_397
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_397
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_428_429
func_428:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_430_431
func_430:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_433
    b or_end_434
or_right_433:
    adr x0, lhs
or_end_434:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_432
    b after_func_435_436
func_435:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_437_438
func_437:
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
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    b.ne blk_end_439
    adr x0, str_3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    adr x0, can_start_expr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_446
    adr x0, sign_id
    b cond_end_447
cond_false_446:
    adr x0, sign_id
cond_end_447:
    str x0, [sp, #-16]!
    adr x0, str_4
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_451
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    mov x0, #6
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
    b.ne blk_end_451
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
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
    b.ne blk_end_451
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_451
    adr x0, ast_apply
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, lhs
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
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
    b.ne blk_end_451
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
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
    ldr x0, [x29, #-144]
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
    ldr x0, [x29, #-32]
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
blk_end_451:
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
    b.ne blk_end_439
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_481
    adr x0, sign_id
    b cmp_end_482
cmp_true_481:
cmp_end_482:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_479
    adr x0, lhs
    b cond_end_480
cond_false_479:
    adr x0, sign_id
cond_end_480:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    adr x0, get_prec
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    ldr x0, [x29, #-192]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_491
    adr x0, sign_id
    b cmp_end_492
cmp_true_491:
cmp_end_492:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_489
    adr x0, lhs
    b cond_end_490
cond_false_489:
    adr x0, sign_id
cond_end_490:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_493
do_apply_494:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_495
do_compose_493:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_495:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    b after_next_min_prec_impl_496
next_min_prec_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_497_498
func_497:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_499
    b or_end_500
or_right_499:
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
or_end_500:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_497_498:
    // Closure for func_497
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_497
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_next_min_prec_impl_496:
    // Closure for next_min_prec_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, next_min_prec_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-208]
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
    adr x0, next_min_prec
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
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
    b.ne blk_end_439
    adr x0, ast_infix
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    str x0, [sp, #-16]!
    adr x0, lhs
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_439
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-272]
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
    ldr x0, [x29, #-256]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
blk_end_439:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_437_438:
    // Closure for func_437
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
    adr x1, func_437
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_435_436:
    // Closure for func_435
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_435
    ldr x0, [sp], #16
    bl _cons
blk_end_432:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_430_431:
    // Closure for func_430
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_430
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_428_429:
    // Closure for func_428
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_428
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_525_526
func_525:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_527_528
func_527:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_530
    b or_end_531
or_right_530:
    adr x0, type
or_end_531:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_534
    adr x0, sign_id
    b cmp_end_535
cmp_true_534:
cmp_end_535:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_532
    mov x0, #1
    b cond_end_533
cond_false_532:
    adr x0, sign_id
cond_end_533:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_538
    adr x0, sign_id
    b cmp_end_539
cmp_true_538:
cmp_end_539:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_536
    mov x0, #1
    b cond_end_537
cond_false_536:
    adr x0, sign_id
cond_end_537:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_542
    adr x0, sign_id
    b cmp_end_543
cmp_true_542:
cmp_end_543:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_540
    mov x0, #1
    b cond_end_541
cond_false_540:
    adr x0, sign_id
cond_end_541:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_546
    adr x0, sign_id
    b cmp_end_547
cmp_true_546:
cmp_end_547:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_544
    mov x0, #1
    b cond_end_545
cond_false_544:
    adr x0, sign_id
cond_end_545:
    str x0, [sp, #-16]!
    adr x0, str_5
    cmp x0, #4096
    b.hi do_compose_548
do_apply_549:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_550
do_compose_548:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_550:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    mov x0, #0
blk_end_529:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_551_552
func_551:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_553_554
func_553:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_556
    b or_end_557
or_right_556:
    adr x0, op
or_end_557:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_555
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, "
    bl _factorial
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
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b.ne blk_end_555
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_567
do_apply_568:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_569
do_compose_567:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_569:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_555
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    ldr x0, [x29, #-80]
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
    add x0, x29, #-80
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_579
    mov x0, #1
    b cond_end_580
cond_false_579:
    adr x0, sign_id
cond_end_580:
    cmp x0, #4096
    b.hi do_compose_581
do_apply_582:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_583
do_compose_581:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_583:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_555
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_584
do_apply_585:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_586
do_compose_584:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_586:
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
    b.eq cond_false_587
    mov x0, #1
    b cond_end_588
cond_false_587:
    adr x0, sign_id
cond_end_588:
    cmp x0, #4096
    b.hi do_compose_589
do_apply_590:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_591
do_compose_589:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_591:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_555
    mov x0, #0
blk_end_555:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_553_554:
    // Closure for func_553
    adr x0, sign_id
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
    adr x1, func_551
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_592_593
func_592:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_594_595
func_594:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_597
    b or_end_598
or_right_597:
    adr x0, tokens
or_end_598:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_596
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_599
do_apply_600:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_601
do_compose_599:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_601:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_596
    adr x0, tok_type
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_602
do_apply_603:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_604
do_compose_602:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_604:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_596
    adr x0, next
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_605
do_apply_606:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_607
do_compose_605:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_607:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_596
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_610
    adr x0, sign_id
    b cmp_end_611
cmp_true_610:
cmp_end_611:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_608
    adr x0, sign_id
    b cond_end_609
cond_false_608:
    adr x0, sign_id
cond_end_609:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    b.ne blk_end_612
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
blk_end_612:
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
    b.ne blk_end_596
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_623
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
blk_end_623:
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
    b.ne blk_end_596
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_632
    adr x0, sign_id
    b cmp_end_633
cmp_true_632:
cmp_end_633:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_630
    adr x0, sign_id
    b cond_end_631
cond_false_630:
    adr x0, sign_id
cond_end_631:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_635
do_apply_636:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_637
do_compose_635:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_637:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_634
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
blk_end_634:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_596
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_643
    adr x0, sign_id
    b cmp_end_644
cmp_true_643:
cmp_end_644:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_641
    adr x0, sign_id
    b cond_end_642
cond_false_641:
    adr x0, sign_id
cond_end_642:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    b.ne blk_end_645
    adr x0, is_prefix_op
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, str_6
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_652
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    cmp x0, #4096
    b.hi do_compose_653
do_apply_654:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_655
do_compose_653:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_655:
    str x0, [sp, #-16]!
    mov x0, #20
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
    adr x0, str_7
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_652
    adr x0, ast_prefix
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
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
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-192]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_652:
    cmp x0, #4096
    b.hi do_compose_671
do_apply_672:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_673
do_compose_671:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_673:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_645
    adr x0, str_8
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_645
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
blk_end_645:
    cmp x0, #4096
    b.hi do_compose_674
do_apply_675:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_676
do_compose_674:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_676:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_596
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_679
    adr x0, sign_id
    b cmp_end_680
cmp_true_679:
cmp_end_680:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_677
    adr x0, sign_id
    b cond_end_678
cond_false_677:
    adr x0, sign_id
cond_end_678:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_682
do_apply_683:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_684
do_compose_682:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_684:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_681
    ldr x0, [x29, #-208]
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_687
    adr x0, sign_id
    b cmp_end_688
cmp_true_687:
cmp_end_688:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_685
    adr x0, sign_id
    b cond_end_686
cond_false_685:
    adr x0, sign_id
cond_end_686:
    str x0, [sp, #-16]!
    adr x0, str_9
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_689
    adr x0, parse_block
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
blk_end_689:
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
    b.ne blk_end_681
    ldr x0, [x29, #-208]
    str x0, [sp, #-16]!
    mov x0, #40
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_698
    adr x0, sign_id
    b cmp_end_699
cmp_true_698:
cmp_end_699:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_696
    adr x0, sign_id
    b cond_end_697
cond_false_696:
    adr x0, sign_id
cond_end_697:
    str x0, [sp, #-16]!
    adr x0, str_10
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
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
    b.ne blk_end_700
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, str_11
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-256]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, str_12
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, str_13
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, is_null
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
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
    cmp x0, #4096
    b.hi do_compose_719
do_apply_720:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_721
do_compose_719:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_721:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-256]
    cmp x0, #4096
    b.hi do_compose_725
do_apply_726:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_727
do_compose_725:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_727:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_700
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
    b.hi do_compose_728
do_apply_729:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_730
do_compose_728:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_730:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_700:
    cmp x0, #4096
    b.hi do_compose_731
do_apply_732:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_733
do_compose_731:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_733:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_681
    adr x0, str_14
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_681
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
blk_end_681:
    cmp x0, #4096
    b.hi do_compose_734
do_apply_735:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_736
do_compose_734:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_736:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_596
    adr x0, str_15
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_596
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
blk_end_596:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_594_595:
    // Closure for func_594
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_594
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_592_593:
    // Closure for func_592
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_592
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_737_738
func_737:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_739_740
func_739:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_742
    b or_end_743
or_right_742:
    adr x0, tokens
or_end_743:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, parse_stmts
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    cmp x0, #4096
    b.hi do_compose_744
do_apply_745:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_746
do_compose_744:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_746:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    cmp x0, #4096
    b.hi do_compose_750
do_apply_751:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_752
do_compose_750:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_752:
    cmp x0, #4096
    b.hi do_compose_753
do_apply_754:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_755
do_compose_753:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_755:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, str_16
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, peek
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    cmp x0, #4096
    b.hi do_compose_756
do_apply_757:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_758
do_compose_756:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_758:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, str_17
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    adr x0, transform_section
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_759
do_apply_760:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_761
do_compose_759:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_761:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_741
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    adr x0, next
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_741:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_739_740:
    // Closure for func_739
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_739
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_737_738:
    // Closure for func_737
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_737
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_770
    b or_end_771
or_right_770:
    adr x0, list
or_end_771:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_769
    adr x0, list
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_774
    adr x0, sign_id
    b cmp_end_775
cmp_true_774:
cmp_end_775:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_772
    mov x0, #1
    b cond_end_773
cond_false_772:
    adr x0, sign_id
cond_end_773:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_769
    mov x0, #0
blk_end_769:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_767_768:
    // Closure for func_767
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_776_777
func_776:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_778_779
func_778:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_781
    b or_end_782
or_right_781:
    adr x0, type
or_end_782:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_780
    b after_func_783_784
func_783:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, type
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
after_func_783_784:
    // Closure for func_783
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_783
    ldr x0, [sp], #16
    bl _cons
blk_end_780:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_778_779:
    // Closure for func_778
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_778
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_776_777:
    // Closure for func_776
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_776
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_785_786
func_785:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_787_788
func_787:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_790
    b or_end_791
or_right_790:
    adr x0, val
or_end_791:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_789
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_795
do_apply_796:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_797
do_compose_795:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_797:
blk_end_789:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_787_788:
    // Closure for func_787
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_787
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_803
    b or_end_804
or_right_803:
    adr x0, val
or_end_804:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_802
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_805
do_apply_806:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_807
do_compose_805:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_807:
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_808
do_apply_809:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_810
do_compose_808:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_810:
blk_end_802:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_800_801:
    // Closure for func_800
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_811_812
func_811:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_813_814
func_813:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_816
    b or_end_817
or_right_816:
    adr x0, val
or_end_817:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_815
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_818
do_apply_819:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_820
do_compose_818:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_820:
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_821
do_apply_822:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_823
do_compose_821:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_823:
blk_end_815:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_813_814:
    // Closure for func_813
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_813
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_811_812:
    // Closure for func_811
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_811
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_824_825
func_824:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_826_827
func_826:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_829
    b or_end_830
or_right_829:
    adr x0, val
or_end_830:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_828
    adr x0, make_node
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_831
do_apply_832:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_833
do_compose_831:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_833:
    str x0, [sp, #-16]!
    adr x0, val
    cmp x0, #4096
    b.hi do_compose_834
do_apply_835:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_836
do_compose_834:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_836:
blk_end_828:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_826_827:
    // Closure for func_826
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_826
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_837_838
func_837:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_839_840
func_839:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_842
    b or_end_843
or_right_842:
    adr x0, op
or_end_843:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_841
    b after_func_844_845
func_844:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_846_847
func_846:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, ast_infix
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, op
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
after_func_846_847:
    // Closure for func_846
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_846
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_844_845:
    // Closure for func_844
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_844
    ldr x0, [sp], #16
    bl _cons
blk_end_841:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_839_840:
    // Closure for func_839
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_839
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_837_838:
    // Closure for func_837
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_837
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_848_849
func_848:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_850_851
func_850:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_853
    b or_end_854
or_right_853:
    adr x0, params
or_end_854:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_852
    b after_func_855_856
func_855:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_857_858
func_857:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_859_860
func_859:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, params
    cmp x0, #4096
    b.hi do_compose_861
do_apply_862:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_863
do_compose_861:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_863:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    cmp x0, #4096
    b.hi do_compose_864
do_apply_865:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_866
do_compose_864:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_866:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_859_860:
    // Closure for func_859
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_859
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_857_858:
    // Closure for func_857
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_857
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_855_856:
    // Closure for func_855
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_855
    ldr x0, [sp], #16
    bl _cons
blk_end_852:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_850_851:
    // Closure for func_850
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_850
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_867_868
func_867:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_869_870
func_869:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_872
    b or_end_873
or_right_872:
    adr x0, exprs
or_end_873:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_871
    adr x0, length
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_874
do_apply_875:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_876
do_compose_874:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_876:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_871
    adr x0, make_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_877
do_apply_878:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_879
do_compose_877:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_879:
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_880
do_apply_881:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_882
do_compose_880:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_882:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_883
do_apply_884:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_885
do_compose_883:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_885:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_871
    adr x0, make_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_886
do_apply_887:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_888
do_compose_886:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_888:
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_889
do_apply_890:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_891
do_compose_889:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_891:
    str x0, [sp, #-16]!
    adr x0, "
    cmp x0, #4096
    b.hi do_compose_892
do_apply_893:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_894
do_compose_892:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_894:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_871
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_897
    adr x0, sign_id
    b cmp_end_898
cmp_true_897:
cmp_end_898:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_895
    adr x0, sign_id
    b cond_end_896
cond_false_895:
    adr x0, sign_id
cond_end_896:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, exprs
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_899
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
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
    b.ne blk_end_899
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_908
    adr x0, sign_id
    b cmp_end_909
cmp_true_908:
cmp_end_909:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_906
    adr x0, sign_id
    b cond_end_907
cond_false_906:
    adr x0, sign_id
cond_end_907:
    str x0, [sp, #-16]!
    adr x0, str_18
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_910
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
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
    str x0, [sp, #-16]!
    adr x0, str_19
    cmp x0, #4096
    b.hi do_compose_920
do_apply_921:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_922
do_compose_920:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_922:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_910
    adr x0, make_lambda
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    adr x0, "
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
    adr x0, "
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    ldr x0, [x29, #-96]
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
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_923
    adr x0, make_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    ldr x0, [x29, #-96]
    cmp x0, #4096
    b.hi do_compose_939
do_apply_940:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_941
do_compose_939:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_941:
blk_end_923:
    cmp x0, #4096
    b.hi do_compose_942
do_apply_943:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_944
do_compose_942:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_944:
blk_end_910:
    cmp x0, #4096
    b.hi do_compose_945
do_apply_946:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_947
do_compose_945:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_947:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_899
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, exprs
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_899:
    cmp x0, #4096
    b.hi do_compose_948
do_apply_949:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_950
do_compose_948:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_950:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_871
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_953
    adr x0, sign_id
    b cmp_end_954
cmp_true_953:
cmp_end_954:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_951
    adr x0, sign_id
    b cond_end_952
cond_false_951:
    adr x0, sign_id
cond_end_952:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_956
do_apply_957:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_958
do_compose_956:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_958:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_955
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_959
do_apply_960:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_961
do_compose_959:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_961:
    cmp x0, #4096
    b.hi do_compose_962
do_apply_963:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_964
do_compose_962:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_964:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_955
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    cmp x0, #4096
    b.hi do_compose_965
do_apply_966:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_967
do_compose_965:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_967:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_955
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_955
    ldr x0, [x29, #-192]
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_973
    adr x0, sign_id
    b cmp_end_974
cmp_true_973:
cmp_end_974:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_971
    adr x0, sign_id
    b cond_end_972
cond_false_971:
    adr x0, sign_id
cond_end_972:
    str x0, [sp, #-16]!
    adr x0, str_20
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_975
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
    cmp x0, #4096
    b.hi do_compose_976
do_apply_977:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_978
do_compose_976:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_978:
    cmp x0, #4096
    b.hi do_compose_979
do_apply_980:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_981
do_compose_979:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_981:
    cmp x0, #4096
    b.hi do_compose_982
do_apply_983:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_984
do_compose_982:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_984:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_975
    adr x0, make_lambda
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_985
do_apply_986:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_987
do_compose_985:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_987:
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-224]
    cmp x0, #4096
    b.hi do_compose_988
do_apply_989:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_990
do_compose_988:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_990:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_991
do_apply_992:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_993
do_compose_991:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_993:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
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
blk_end_975:
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
    b.ne blk_end_955
    ldr x0, [x29, #-208]
    str x0, [sp, #-16]!
    adr x0, ast_op
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1005
    adr x0, sign_id
    b cmp_end_1006
cmp_true_1005:
cmp_end_1006:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1003
    adr x0, sign_id
    b cond_end_1004
cond_false_1003:
    adr x0, sign_id
cond_end_1004:
    str x0, [sp, #-16]!
    adr x0, str_21
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1007
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    cmp x0, #4096
    b.hi do_compose_1008
do_apply_1009:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1010
do_compose_1008:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1010:
    cmp x0, #4096
    b.hi do_compose_1011
do_apply_1012:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1013
do_compose_1011:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1013:
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
    b.ne blk_end_1007
    adr x0, make_lambda
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    adr x0, make_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    cmp x0, #4096
    b.hi do_compose_1026
do_apply_1027:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1028
do_compose_1026:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1028:
    cmp x0, #4096
    b.hi do_compose_1029
do_apply_1030:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1031
do_compose_1029:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1031:
blk_end_1007:
    cmp x0, #4096
    b.hi do_compose_1032
do_apply_1033:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1034
do_compose_1032:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1034:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_955
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, exprs
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_955:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_871
    adr x0, ast_block
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, exprs
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_871:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_869_870:
    // Closure for func_869
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_869
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_867_868:
    // Closure for func_867
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_867
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

