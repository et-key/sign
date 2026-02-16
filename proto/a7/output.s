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

    ldr x0, =0xc076126be37de93a
    adr x1, x
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    ldr x0, =0x40af42b510f5c696
    adr x1, y
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_0
    adr x1, Hello
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_1
    adr x1, World
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x1, yep
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, nop
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, none
    str x0, [x1]
    adr x0, sign_id
    adr x1, unit
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, none
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, unit
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, none
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, unit
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, id
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_5
    adr x0, sign_id
    b cmp_end_6
cmp_true_5:
cmp_end_6:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_7
    adr x0, sign_id
    b cmp_end_8
cmp_true_7:
cmp_end_8:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3
    adr x0, sign_id
    b cmp_end_4
cmp_true_3:
cmp_end_4:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1
    adr x0, x
    ldr x0, [x0]
    b and_end_2
and_fail_1:
    adr x0, sign_id
and_end_2:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_13
    adr x0, sign_id
    b cmp_end_14
cmp_true_13:
cmp_end_14:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_15
    adr x0, sign_id
    b cmp_end_16
cmp_true_15:
cmp_end_16:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_11
    adr x0, sign_id
    b cmp_end_12
cmp_true_11:
cmp_end_12:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_9
    adr x0, x
    ldr x0, [x0]
    b and_end_10
and_fail_9:
    adr x0, sign_id
and_end_10:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_21
    adr x0, sign_id
    b cmp_end_22
cmp_true_21:
cmp_end_22:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_23
    adr x0, sign_id
    b cmp_end_24
cmp_true_23:
cmp_end_24:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_19
    adr x0, sign_id
    b cmp_end_20
cmp_true_19:
cmp_end_20:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_17
    adr x0, x
    ldr x0, [x0]
    b and_end_18
and_fail_17:
    adr x0, sign_id
and_end_18:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_29
    adr x0, sign_id
    b cmp_end_30
cmp_true_29:
cmp_end_30:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_31
    adr x0, sign_id
    b cmp_end_32
cmp_true_31:
cmp_end_32:
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
    b.eq and_fail_25
    adr x0, x
    ldr x0, [x0]
    b and_end_26
and_fail_25:
    adr x0, sign_id
and_end_26:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_37
    adr x0, sign_id
    b cmp_end_38
cmp_true_37:
cmp_end_38:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_39
    adr x0, sign_id
    b cmp_end_40
cmp_true_39:
cmp_end_40:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_35
    adr x0, sign_id
    b cmp_end_36
cmp_true_35:
cmp_end_36:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_33
    adr x0, x
    ldr x0, [x0]
    b and_end_34
and_fail_33:
    adr x0, sign_id
and_end_34:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_47
    adr x0, sign_id
    b cmp_end_48
cmp_true_47:
    mov x0, x1
cmp_end_48:
    str x0, [sp, #-16]!
    mov x0, #5
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_45
    adr x0, sign_id
    b cmp_end_46
cmp_true_45:
cmp_end_46:
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_49
    adr x0, sign_id
    b cmp_end_50
cmp_true_49:
cmp_end_50:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_43
    adr x0, sign_id
    b cmp_end_44
cmp_true_43:
cmp_end_44:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_41
    adr x0, y
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #5
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_51
    adr x0, sign_id
    b cmp_end_52
cmp_true_51:
cmp_end_52:
    b and_end_42
and_fail_41:
    adr x0, sign_id
and_end_42:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_59
    adr x0, sign_id
    b cmp_end_60
cmp_true_59:
    mov x0, x1
cmp_end_60:
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_57
    adr x0, sign_id
    b cmp_end_58
cmp_true_57:
cmp_end_58:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_61
    adr x0, sign_id
    b cmp_end_62
cmp_true_61:
cmp_end_62:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_55
    adr x0, sign_id
    b cmp_end_56
cmp_true_55:
cmp_end_56:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_53
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_63
    adr x0, sign_id
    b cmp_end_64
cmp_true_63:
cmp_end_64:
    b and_end_54
and_fail_53:
    adr x0, sign_id
and_end_54:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_65_66
func_65:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    ldr x1, [sp], #16
    add x0, x1, x0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_67_68
func_67:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_67_68:
    // Closure for func_67
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_67
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_inline_composed_69_70
inline_composed_69:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    // Inline: Left Body
    b after_func_74_75
func_74:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_76_77
func_76:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_78_79
func_78:
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
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_78_79:
    // Closure for func_78
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_78
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_76_77:
    // Closure for func_76
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_76
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_80
do_apply_81:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_82
do_compose_80:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_82:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_83
do_apply_84:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_85
do_compose_83:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_85:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_74_75:
    // Closure for func_74
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_74
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_86_87
func_86:
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
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_86_87:
    // Closure for func_86
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_86
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_71
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_73
xor_true_71:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_72
    adr x0, sign_id
    b xor_end_73
xor_false_72:
    mov x0, x1
    // Inline: Chaining (Update $1)
    str x0, [x29, #-32]
    // Inline: Right Body
    b after_func_91_92
func_91:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_93_94
func_93:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
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
    cmp x0, #4096
    b.hi do_compose_95
do_apply_96:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_97
do_compose_95:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_97:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_98
do_apply_99:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_100
do_compose_98:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_100:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_91_92:
    // Closure for func_91
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_91
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_88
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_90
xor_true_88:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_89
    adr x0, sign_id
    b xor_end_90
xor_false_89:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_inline_composed_69_70:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, inline_composed_69
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_inline_composed_101_102
inline_composed_101:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    // Inline: Left Body
    b after_func_106_107
func_106:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_108_109
func_108:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_108_109:
    // Closure for func_108
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_108
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_113
do_apply_114:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_115
do_compose_113:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_115:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_106_107:
    // Closure for func_106
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_106
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_103
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_105
xor_true_103:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_104
    adr x0, sign_id
    b xor_end_105
xor_false_104:
    mov x0, x1
    // Inline: Chaining (Update $1)
    str x0, [x29, #-32]
    // Inline: Right Body
    b after_func_119_120
func_119:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_121_122
func_121:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_123_124
func_123:
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
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_123_124:
    // Closure for func_123
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_123
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_121_122:
    // Closure for func_121
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_121
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_128
do_apply_129:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_130
do_compose_128:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_130:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_119_120:
    // Closure for func_119
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_119
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_131_132
func_131:
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
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_131_132:
    // Closure for func_131
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_131
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_116
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_118
xor_true_116:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_117
    adr x0, sign_id
    b xor_end_118
xor_false_117:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_inline_composed_101_102:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, inline_composed_101
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_133_134
func_133:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_138_139
func_138:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_140_141
func_140:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_138_139:
    // Closure for func_138
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_138
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_135
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_137
xor_true_135:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_136
    adr x0, sign_id
    b xor_end_137
xor_false_136:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_133_134:
    // Closure for func_133
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_133
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_148
do_apply_149:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_150
do_compose_148:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_151_152
func_151:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_156_157
func_156:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_158_159
func_158:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_158_159:
    // Closure for func_158
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_158
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_163
do_apply_164:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_165
do_compose_163:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_165:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_156_157:
    // Closure for func_156
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_156
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_153
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_155
xor_true_153:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_154
    adr x0, sign_id
    b xor_end_155
xor_false_154:
    mov x0, x1
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
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, 以
    str x0, [sp, #-16]!
    adr x0, 下
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
    str x0, [sp, #-16]!
    adr x0, は
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
    adr x0, 即
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
    str x0, [sp, #-16]!
    adr x0, 時
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
    adr x0, 評
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
    adr x0, 価
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
    str x0, [sp, #-16]!
    adr x0, さ
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
    str x0, [sp, #-16]!
    adr x0, れ
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
    adr x0, る
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_193_194
func_193:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_198_199
func_198:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_200_201
func_200:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
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
    cmp x0, #4096
    b.hi do_compose_202
do_apply_203:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_204
do_compose_202:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_204:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_195
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_197
xor_true_195:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_196
    adr x0, sign_id
    b xor_end_197
xor_false_196:
    mov x0, x1
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
    str x0, [sp, #-16]!
    mov x0, #2
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, 後
    str x0, [sp, #-16]!
    adr x0, 置
    cmp x0, #4096
    b.hi do_compose_211
do_apply_212:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_213
do_compose_211:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_213:
    str x0, [sp, #-16]!
    adr x0, チ
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
    adr x0, ル
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
    adr x0, ダ
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
    adr x0, を
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
    str x0, [sp, #-16]!
    adr x0, 用
    cmp x0, #4096
    b.hi do_compose_226
do_apply_227:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_228
do_compose_226:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_228:
    str x0, [sp, #-16]!
    adr x0, い
    cmp x0, #4096
    b.hi do_compose_229
do_apply_230:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_231
do_compose_229:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_231:
    str x0, [sp, #-16]!
    adr x0, る
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
    adr x0, こ
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
    adr x0, と
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
    adr x0, で
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
    str x0, [sp, #-16]!
    adr x0, 、
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
    adr x0, 即
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
    adr x0, 時
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
    adr x0, 評
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
    adr x0, 価
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
    adr x0, さ
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
    str x0, [sp, #-16]!
    adr x0, れ
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
    adr x0, る
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_268_269
func_268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_273_274
func_273:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_275_276
func_275:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_270
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_272
xor_true_270:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_271
    adr x0, sign_id
    b xor_end_272
xor_false_271:
    mov x0, x1
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
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _cons
    adr x1, list
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    adr x1, evaluate
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, evaluate
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #4
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
    b.ne blk_end_0
    b after_func_285_286
func_285:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_290_291
func_290:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_292_293
func_292:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_292_293:
    // Closure for func_292
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_292
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_294
do_apply_295:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_296
do_compose_294:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_296:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_297
do_apply_298:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_299
do_compose_297:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_299:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_287
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_289
xor_true_287:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_288
    adr x0, sign_id
    b xor_end_289
xor_false_288:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_285_286:
    // Closure for func_285
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_285
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, =
    ldr x1, [sp], #16
    bl _range
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_300
do_apply_301:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_302
do_compose_300:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_302:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_Filter_impl_303
Filter_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_304
do_apply_305:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_306
do_compose_304:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_306:
    str x0, [sp, #-16]!
    adr x0, Filter
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_Filter_impl_303:
    // Closure for Filter_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, Filter_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Filter
    ldr x0, [x0]
    str x0, [sp, #-16]!
    b after_func_313_314
func_313:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_318_319
func_318:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_320_321
func_320:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_322
    adr x0, sign_id
    b cmp_end_323
cmp_true_322:
cmp_end_323:
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_318_319:
    // Closure for func_318
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_318
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_330
    adr x0, sign_id
    b cmp_end_331
cmp_true_330:
cmp_end_331:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_315
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_317
xor_true_315:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_316
    adr x0, sign_id
    b xor_end_317
xor_false_316:
    mov x0, x1
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
    mov x0, #-2
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    bl _range
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_inline_composed_338_339
inline_composed_338:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    // Inline: Left Body
    b after_func_343_344
func_343:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_345_346
func_345:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_345_346:
    // Closure for func_345
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_345
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_343_344:
    // Closure for func_343
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_343
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_340
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_342
xor_true_340:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_341
    adr x0, sign_id
    b xor_end_342
xor_false_341:
    mov x0, x1
    // Inline: Chaining (Update $1)
    str x0, [x29, #-32]
    // Inline: Right Body
    b after_func_356_357
func_356:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_358_359
func_358:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_358_359:
    // Closure for func_358
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_358
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_356_357:
    // Closure for func_356
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_356
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_353
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_355
xor_true_353:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_354
    adr x0, sign_id
    b xor_end_355
xor_false_354:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_inline_composed_338_339:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, inline_composed_338
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #5
    str x0, [sp, #-16]!
    b after_func_368_369
func_368:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_373_374
func_373:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_375_376
func_375:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_375_376:
    // Closure for func_375
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_375
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_373_374:
    // Closure for func_373
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_373
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_370
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_372
xor_true_370:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_371
    adr x0, sign_id
    b xor_end_372
xor_false_371:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_368_369:
    // Closure for func_368
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_368
    ldr x0, [sp], #16
    bl _cons
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_366
    adr x0, sign_id
    b cmp_end_367
cmp_true_366:
    mov x0, x1
cmp_end_367:
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
    b after_func_388_389
func_388:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_393_394
func_393:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_395_396
func_395:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_395_396:
    // Closure for func_395
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_395
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_397
do_apply_398:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_399
do_compose_397:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_399:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_400
do_apply_401:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_402
do_compose_400:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_402:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_390
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_392
xor_true_390:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_391
    adr x0, sign_id
    b xor_end_392
xor_false_391:
    mov x0, x1
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
    str x0, [sp, #-16]!
    mov x0, #5
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
    str x0, [sp, #-16]!
    mov x0, #12
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_386
    adr x0, sign_id
    b cmp_end_387
cmp_true_386:
cmp_end_387:
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
    b.ne blk_end_0
    b after_func_409_410
func_409:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    mov x0, #1
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
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_417
    adr x0, sign_id
    b cmp_end_418
cmp_true_417:
    mov x0, x1
cmp_end_418:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_422_423
func_422:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_422_423:
    // Closure for func_422
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_422
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
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
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_427
    adr x0, sign_id
    b cmp_end_428
cmp_true_427:
    mov x0, x1
cmp_end_428:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #1
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
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_435
    adr x0, sign_id
    b cmp_end_436
cmp_true_435:
    mov x0, x1
cmp_end_436:
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
    b.ne blk_end_0
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #1
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
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_443
    adr x0, sign_id
    b cmp_end_444
cmp_true_443:
    mov x0, x1
cmp_end_444:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
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
    mov x0, #3
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
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_445
    adr x0, sign_id
    b cmp_end_446
cmp_true_445:
cmp_end_446:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_453
    adr x0, sign_id
    b cmp_end_454
cmp_true_453:
cmp_end_454:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_455_456
func_455:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, y
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_455_456:
    // Closure for func_455
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_455
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
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
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_460
do_apply_461:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_462
do_compose_460:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_462:
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_463
    adr x0, sign_id
    b cmp_end_464
cmp_true_463:
    mov x0, x1
cmp_end_464:
    cmp x0, #4096
    b.hi do_compose_465
do_apply_466:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_467
do_compose_465:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_467:
    str x0, [sp, #-16]!
    mov x0, #3
    cmp x0, #4096
    b.hi do_compose_468
do_apply_469:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_470
do_compose_468:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_470:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_471_472
func_471:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, y
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_471_472:
    // Closure for func_471
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_471
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
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
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_476
    adr x0, sign_id
    b cmp_end_477
cmp_true_476:
    mov x0, x1
cmp_end_477:
    str x0, [sp, #-16]!
    mov x0, #3
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
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
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
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    adr x0, =
    ldr x1, [sp], #16
    bl _range
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_487
do_apply_488:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_489
do_compose_487:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_489:
    str x0, [sp, #-16]!
    mov x0, #3
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
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    adr x0, =
    ldr x1, [sp], #16
    bl _range
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
    cmp x0, #4096
    b.hi do_compose_496
do_apply_497:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_498
do_compose_496:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_498:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_499_500
func_499:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, y
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_501
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    ldr x1, [sp], #16
    add x0, x1, x0
blk_end_501:
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
    b.ne blk_end_0
    b after_func_502_503
func_502:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_507_508
func_507:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_509_510
func_509:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_511_512
func_511:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_511_512:
    // Closure for func_511
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_511
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_509_510:
    // Closure for func_509
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_509
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_507_508:
    // Closure for func_507
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_507
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_519_520
func_519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_519_520:
    // Closure for func_519
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_519
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_504
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_506
xor_true_504:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_505
    adr x0, sign_id
    b xor_end_506
xor_false_505:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_502_503:
    // Closure for func_502
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_502
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_524
    adr x0, sign_id
    b cmp_end_525
cmp_true_524:
cmp_end_525:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_522
    mov x0, #0
    b cond_end_523
cond_false_522:
    adr x0, sign_id
cond_end_523:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_521
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_528
    adr x0, sign_id
    b cmp_end_529
cmp_true_528:
cmp_end_529:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_526
    adr x0, str_2
    b cond_end_527
cond_false_526:
    adr x0, sign_id
cond_end_527:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_521
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_532
    adr x0, sign_id
    b cmp_end_533
cmp_true_532:
cmp_end_533:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_530
    adr x0, str_3
    b cond_end_531
cond_false_530:
    adr x0, sign_id
cond_end_531:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_521
    adr x0, str_4
blk_end_521:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_534_535
func_534:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_539_540
func_539:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_541_542
func_541:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_543_544
func_543:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_543_544:
    // Closure for func_543
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_543
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_541_542:
    // Closure for func_541
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_541
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_545
do_apply_546:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_547
do_compose_545:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_547:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_539_540:
    // Closure for func_539
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_539
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-48]
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_536
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_538
xor_true_536:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_537
    adr x0, sign_id
    b xor_end_538
xor_false_537:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_554
    adr x0, sign_id
    b cmp_end_555
cmp_true_554:
cmp_end_555:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_553
    adr x0, sign_id
    cmp x0, #0
    b.ge abs_pos_556
    neg x0, x0
abs_pos_556:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_559
    adr x0, sign_id
    b cmp_end_560
cmp_true_559:
cmp_end_560:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_557
    adr x0, str_2
    b and_end_558
and_fail_557:
    adr x0, sign_id
and_end_558:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_553
    adr x0, sign_id
    cmp x0, #0
    b.ge abs_pos_564
    neg x0, x0
abs_pos_564:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_567
    adr x0, sign_id
    b cmp_end_568
cmp_true_567:
cmp_end_568:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_565
    adr x0, str_3
    b and_end_566
and_fail_565:
    adr x0, sign_id
and_end_566:
    cmp x0, #4096
    b.hi do_compose_569
do_apply_570:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_571
do_compose_569:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_571:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_553
    adr x0, sign_id
    cmp x0, #0
    b.ge abs_pos_572
    neg x0, x0
abs_pos_572:
    str x0, [sp, #-16]!
    adr x0, str_4
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
blk_end_553:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_Person_impl_576
Person_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_577
    adr x0, age
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_577
    adr x0, etc
    ldr x0, [x0] // @ load
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_578
    adr x0, x
    ldr x0, [x0]
    b cond_end_579
cond_false_578:
    adr x0, sign_id
cond_end_579:
blk_end_577:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_Person_impl_576:
    // Closure for Person_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, Person_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Person
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_5
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
    mov x0, #18
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
    adr x0, str_6
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
    str x0, [sp, #-16]!
    adr x0, Like
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
    str x0, [sp, #-16]!
    adr x0, str_6
    cmp x0, #4096
    b.hi do_compose_592
do_apply_593:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_594
do_compose_592:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_594:
    str x0, [sp, #-16]!
    adr x0, str_7
    cmp x0, #4096
    b.hi do_compose_595
do_apply_596:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_597
do_compose_595:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_597:
    adr x1, john
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, john
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, name
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    adr x0, john
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_8
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_598
    adr x0, sign_id
    b cmp_end_599
cmp_true_598:
cmp_end_599:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_600_601
func_600:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_605_606
func_605:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_607_608
func_607:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_611
    b after_func_613_614
func_613:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_618_619
func_618:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_620_621
func_620:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_620_621:
    // Closure for func_620
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_620
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_618_619:
    // Closure for func_618
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_618
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_615
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_617
xor_true_615:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_616
    adr x0, sign_id
    b xor_end_617
xor_false_616:
    mov x0, x1
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
    b cond_end_612
cond_false_611:
    adr x0, sign_id
cond_end_612:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_609
    adr x0, sign_id
    b cmp_end_610
cmp_true_609:
cmp_end_610:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_607_608:
    // Closure for func_607
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_607
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_605_606:
    // Closure for func_605
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_605
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_636
    b after_func_638_639
func_638:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_643_644
func_643:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_645_646
func_645:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_645_646:
    // Closure for func_645
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_645
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_640
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_642
xor_true_640:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_641
    adr x0, sign_id
    b xor_end_642
xor_false_641:
    mov x0, x1
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
    b cond_end_637
cond_false_636:
    adr x0, sign_id
cond_end_637:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_634
    adr x0, sign_id
    b cmp_end_635
cmp_true_634:
cmp_end_635:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_602
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_604
xor_true_602:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_603
    adr x0, sign_id
    b xor_end_604
xor_false_603:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_600_601:
    // Closure for func_600
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_600
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #3
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
    mov x0, #4
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_656
    adr x0, sign_id
    b cmp_end_657
cmp_true_656:
    mov x0, x1
cmp_end_657:
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
    b.ne blk_end_0
    adr x0, MyGame
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_661
    adr x0, Existence
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_663
    adr x0, Durability
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_663
    adr x0, Mentality
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_663
    adr x0, Wisdom
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_663
    adr x0, Agility
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_663
    adr x0, Equipment
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_663
    adr x0, Bag
blk_end_663:
    adr x1, State
    str x0, [x1]
    adr x0, sign_id
    b cond_end_662
cond_false_661:
    adr x0, sign_id
cond_end_662:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Mob
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_664
    adr x0, MyGame
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    b cond_end_665
cond_false_664:
    adr x0, sign_id
cond_end_665:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, State
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    adr x1, Base
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_666
    adr x0, State
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
blk_end_666:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Magician
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_667
    adr x0, Mob
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    b cond_end_668
cond_false_667:
    adr x0, sign_id
cond_end_668:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, Existence
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_670
    mov x0, #3
    adr x1, Durability
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_670
    mov x0, #10
    adr x1, Mentality
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_670
    mov x0, #8
    adr x1, Wisdom
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_670
    mov x0, #5
    adr x1, agility
    str x0, [x1]
    adr x0, sign_id
blk_end_670:
    adr x1, Base
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_669
    adr x0, Magician
    str x0, [sp, #-16]!
    adr x0, Base
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    adr x1, State
    str x0, [x1]
    adr x0, sign_id
blk_end_669:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Magician
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    adr x1, myMagician
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    b after_func_672_673
func_672:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_677_678
func_677:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_679_680
func_679:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #4
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_679_680:
    // Closure for func_679
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_679
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #4
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_674
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_676
xor_true_674:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_675
    adr x0, sign_id
    b xor_end_676
xor_false_675:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_672_673:
    // Closure for func_672
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_672
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_671
    b after_func_687_688
func_687:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_692_693
func_692:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_694_695
func_694:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_694_695:
    // Closure for func_694
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_694
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_692_693:
    // Closure for func_692
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_692
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_689
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_691
xor_true_689:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_690
    adr x0, sign_id
    b xor_end_691
xor_false_690:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_687_688:
    // Closure for func_687
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_687
    ldr x0, [sp], #16
    bl _cons
blk_end_671:
    adr x1, myValue
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
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
    str x0, [sp, #-16]!
    mov x0, #4
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
    str x0, [sp, #-16]!
    mov x0, #5
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
    adr x1, myPairs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_714_715
func_714:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_719_720
func_719:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_721_722
func_721:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_723_724
func_723:
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
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_723_724:
    // Closure for func_723
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_723
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_731_732
func_731:
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
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_731_732:
    // Closure for func_731
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_731
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_716
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_718
xor_true_716:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_717
    adr x0, sign_id
    b xor_end_718
xor_false_717:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_714_715:
    // Closure for func_714
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_714
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_733
do_apply_734:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_735
do_compose_733:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_735:
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_736
do_apply_737:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_738
do_compose_736:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_738:
    str x0, [sp, #-16]!
    mov x0, #3
    cmp x0, #4096
    b.hi do_compose_739
do_apply_740:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_741
do_compose_739:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_741:
    str x0, [sp, #-16]!
    mov x0, #4
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
    str x0, [sp, #-16]!
    mov x0, #5
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
    adr x1, myPairs0
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #4
    str x0, [sp, #-16]!
    mov x0, #5
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x1, myPairs1
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, myPairs0
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_750
    adr x0, sign_id
    b cmp_end_751
cmp_true_750:
cmp_end_751:
    str x0, [sp, #-16]!
    adr x0, myPairs1
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_748
    adr x0, sign_id
    b cmp_end_749
cmp_true_748:
cmp_end_749:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    bl _range
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_752
    adr x0, sign_id
    b cmp_end_753
cmp_true_752:
cmp_end_753:
    str x0, [sp, #-16]!
    mov x0, #3
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
    str x0, [sp, #-16]!
    mov x0, #4
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_760_761
func_760:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_765_766
func_765:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_767_768
func_767:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_769_770
func_769:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_774_775
func_774:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_778_779:
    // Closure for func_778
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_783
do_apply_784:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_785
do_compose_783:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_785:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_774_775:
    // Closure for func_774
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_774
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_786_787
func_786:
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
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_786_787:
    // Closure for func_786
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_786
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_771
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_773
xor_true_771:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_772
    adr x0, sign_id
    b xor_end_773
xor_false_772:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_769_770:
    // Closure for func_769
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_769
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_788
do_apply_789:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_790
do_compose_788:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_790:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_791
do_apply_792:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_793
do_compose_791:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_793:
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
    str x0, [sp, #-16]!
    b after_func_794_795
func_794:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_799_800
func_799:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_801_802
func_801:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_803_804
func_803:
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
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_803_804:
    // Closure for func_803
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_803
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_801_802:
    // Closure for func_801
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_801
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_811_812
func_811:
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
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_811_812:
    // Closure for func_811
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_811
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_796
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_798
xor_true_796:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_797
    adr x0, sign_id
    b xor_end_798
xor_false_797:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_794_795:
    // Closure for func_794
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_794
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_762
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_764
xor_true_762:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_763
    adr x0, sign_id
    b xor_end_764
xor_false_763:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_760_761:
    // Closure for func_760
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_760
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_813
    adr x0, sign_id
    b cmp_end_814
cmp_true_813:
cmp_end_814:
    cmp x0, #4096
    b.hi do_compose_815
do_apply_816:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_817
do_compose_815:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_817:
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #4
    str x0, [sp, #-16]!
    mov x0, #5
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
    b.ne blk_end_0
    b after_func_818_819
func_818:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_823_824
func_823:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_825_826
func_825:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_827_828
func_827:
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
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_827_828:
    // Closure for func_827
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_827
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_825_826:
    // Closure for func_825
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_825
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_832
do_apply_833:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_834
do_compose_832:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_834:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_823_824:
    // Closure for func_823
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_823
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_835_836
func_835:
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
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_835_836:
    // Closure for func_835
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_835
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_820
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_822
xor_true_820:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_821
    adr x0, sign_id
    b xor_end_822
xor_false_821:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_818_819:
    // Closure for func_818
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_818
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #15
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_837
    adr x0, sign_id
    b cmp_end_838
cmp_true_837:
cmp_end_838:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_842_843
func_842:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_847_848
func_847:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_849_850
func_849:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_849_850:
    // Closure for func_849
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_849
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_851
do_apply_852:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_853
do_compose_851:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_853:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_854
do_apply_855:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_856
do_compose_854:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_856:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_844
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_846
xor_true_844:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_845
    adr x0, sign_id
    b xor_end_846
xor_false_845:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_842_843:
    // Closure for func_842
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_842
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_857
    adr x0, sign_id
    b cmp_end_858
cmp_true_857:
cmp_end_858:
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
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_862
do_apply_863:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_864
do_compose_862:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_864:
    str x0, [sp, #-16]!
    mov x0, #6
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
    str x0, [sp, #-16]!
    mov x0, #8
    cmp x0, #4096
    b.hi do_compose_868
do_apply_869:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_870
do_compose_868:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_870:
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_871
do_apply_872:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_873
do_compose_871:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_873:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_874_875
func_874:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_879_880
func_879:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_881_882
func_881:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_883
    adr x0, sign_id
    b cmp_end_884
cmp_true_883:
cmp_end_884:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_881_882:
    // Closure for func_881
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_881
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_879_880:
    // Closure for func_879
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_879
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_891
    adr x0, sign_id
    b cmp_end_892
cmp_true_891:
cmp_end_892:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_876
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_878
xor_true_876:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_877
    adr x0, sign_id
    b xor_end_878
xor_false_877:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_874_875:
    // Closure for func_874
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_874
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #3
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_893
    adr x0, sign_id
    b cmp_end_894
cmp_true_893:
cmp_end_894:
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
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_898
do_apply_899:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_900
do_compose_898:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_900:
    str x0, [sp, #-16]!
    mov x0, #5
    cmp x0, #4096
    b.hi do_compose_901
do_apply_902:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_903
do_compose_901:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_903:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_907
do_apply_908:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_909
do_compose_907:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_909:
    cmp x0, #4096
    b.hi do_compose_910
do_apply_911:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_912
do_compose_910:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_912:
    adr x1, r
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_913
do_apply_914:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_915
do_compose_913:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_915:
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_916
do_apply_917:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_918
do_compose_916:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_918:
    ldr x1, [sp], #16
    bl _cons
    adr x1, s0
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_919
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_923
do_apply_924:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_925
do_compose_923:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_925:
blk_end_919:
    adr x1, s1
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_9
    adr x1, hello
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_927
    adr x0, str_10
    adr x1, welcome
    str x0, [x1]
    adr x0, sign_id
blk_end_927:
    adr x1, greet
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_926
    adr x0, str_11
    adr x1, world
    str x0, [x1]
    adr x0, sign_id
blk_end_926:
    adr x1, myGreet
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, myGreet
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, greet
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    adr x0, hello
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    adr x0, str_9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_928
    adr x0, sign_id
    b cmp_end_929
cmp_true_928:
cmp_end_929:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, myGreet
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, '
    str x0, [sp, #-16]!
    adr x0, greet
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_931
do_apply_932:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_933
do_compose_931:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_933:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_930
    b after_func_934_935
func_934:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_939_940
func_939:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_941_942
func_941:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, welcome
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_941_942:
    // Closure for func_941
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_941
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_939_940:
    // Closure for func_939
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_939
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, welcome
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _nth
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_936
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_938
xor_true_936:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_937
    adr x0, sign_id
    b xor_end_938
xor_false_937:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_934_935:
    // Closure for func_934
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_934
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_930
    adr x0, '
    str x0, [sp, #-16]!
    adr x0, world
    ldr x0, [x0]
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
blk_end_930:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, =
    str x0, [sp, #-16]!
    adr x0, str_12
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, myGreet
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, '
    str x0, [sp, #-16]!
    adr x0, greet
    ldr x0, [x0]
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
    b after_func_959_960
func_959:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_964_965
func_964:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_966_967
func_966:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str_13
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_966_967:
    // Closure for func_966
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_966
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str_13
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _nth
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_961
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_963
xor_true_961:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_962
    adr x0, sign_id
    b xor_end_963
xor_false_962:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_955
    adr x0, '
    str x0, [sp, #-16]!
    adr x0, world
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_974
    adr x0, str_14
    b cond_end_975
cond_false_974:
    adr x0, sign_id
cond_end_975:
blk_end_955:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, y
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_979
    mov x0, #0
    adr x1, n
    str x0, [x1]
    adr x0, sign_id
blk_end_979:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, y
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_980
    adr x0, sign_id
    b cmp_end_981
cmp_true_980:
cmp_end_981:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, io
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, say
    str x0, [sp, #-16]!
    adr x0, Hello
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, World
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, say
    str x0, [sp, #-16]!
    adr x0, Hello
    ldr x0, [x0]
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
    adr x0, World
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, io
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_inline_composed_994_995
inline_composed_994:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    // Inline: Left Body
    b after_func_999_1000
func_999:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1001_1002
func_1001:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #4
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1001_1002:
    // Closure for func_1001
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1001
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_999_1000:
    // Closure for func_999
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_999
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #4
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_996
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_998
xor_true_996:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_997
    adr x0, sign_id
    b xor_end_998
xor_false_997:
    mov x0, x1
    // Inline: Chaining (Update $1)
    str x0, [x29, #-32]
    // Inline: Right Body
    b after_func_1012_1013
func_1012:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1014_1015
func_1014:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1016_1017
func_1016:
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
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1016_1017:
    // Closure for func_1016
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1016
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1014_1015:
    // Closure for func_1014
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1014
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1012_1013:
    // Closure for func_1012
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1012
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1024_1025
func_1024:
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
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1024_1025:
    // Closure for func_1024
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1024
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1009
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1011
xor_true_1009:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1010
    adr x0, sign_id
    b xor_end_1011
xor_false_1010:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_inline_composed_994_995:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, inline_composed_994
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #5
    ldr x1, [sp], #16
    bl _range
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1026
    adr x0, sign_id
    b cmp_end_1027
cmp_true_1026:
cmp_end_1027:
    cmp x0, #4096
    b.hi do_compose_1028
do_apply_1029:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1030
do_compose_1028:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1030:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #77
    adr x1, M
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, M
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1031
do_apply_1032:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1033
do_compose_1031:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1033:
    adr x1, My
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, My
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, M
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1034
    adr x0, sign_id
    b cmp_end_1035
cmp_true_1034:
cmp_end_1035:
    str x0, [sp, #-16]!
    mov x0, #121
    cmp x0, #4096
    b.hi do_compose_1036
do_apply_1037:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1038
do_compose_1036:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1038:
    str x0, [sp, #-16]!
    mov x0, #32
    cmp x0, #4096
    b.hi do_compose_1039
do_apply_1040:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1041
do_compose_1039:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1041:
    str x0, [sp, #-16]!
    mov x0, #68
    cmp x0, #4096
    b.hi do_compose_1042
do_apply_1043:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1044
do_compose_1042:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1044:
    str x0, [sp, #-16]!
    mov x0, #111
    cmp x0, #4096
    b.hi do_compose_1045
do_apply_1046:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1047
do_compose_1045:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1047:
    str x0, [sp, #-16]!
    mov x0, #109
    cmp x0, #4096
    b.hi do_compose_1048
do_apply_1049:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1050
do_compose_1048:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1050:
    str x0, [sp, #-16]!
    mov x0, #101
    cmp x0, #4096
    b.hi do_compose_1051
do_apply_1052:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1053
do_compose_1051:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1053:
    str x0, [sp, #-16]!
    mov x0, #115
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
    mov x0, #116
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
    mov x0, #105
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
    mov x0, #99
    str x0, [sp, #-16]!
    adr x0, str_15
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1063
    adr x0, sign_id
    b cmp_end_1064
cmp_true_1063:
cmp_end_1064:
    cmp x0, #4096
    b.hi do_compose_1065
do_apply_1066:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1067
do_compose_1065:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1067:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_16
    str x0, [sp, #-16]!
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1069
    adr x0, sign_id
    b cmp_end_1070
cmp_true_1069:
    mov x0, x1
cmp_end_1070:
    cmp x0, #4096
    b.hi do_compose_1071
do_apply_1072:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1073
do_compose_1071:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1073:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1068
    adr x0, str_0
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1074
    adr x0, sign_id
    b cmp_end_1075
cmp_true_1074:
cmp_end_1075:
    cmp x0, #4096
    b.hi do_compose_1076
do_apply_1077:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1078
do_compose_1076:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1078:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1068
    mov x0, #72
    str x0, [sp, #-16]!
    adr x0, str_19
    cmp x0, #4096
    b.hi do_compose_1079
do_apply_1080:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1081
do_compose_1079:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1081:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1082
do_apply_1083:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1084
do_compose_1082:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1084:
    str x0, [sp, #-16]!
    mov x0, #33
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1085
    adr x0, sign_id
    b cmp_end_1086
cmp_true_1085:
cmp_end_1086:
    cmp x0, #4096
    b.hi do_compose_1087
do_apply_1088:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1089
do_compose_1087:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1089:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1068
    adr x0, str_16
    str x0, [sp, #-16]!
    adr x0, My
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1090
do_apply_1091:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1092
do_compose_1090:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1092:
    str x0, [sp, #-16]!
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, str_20
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1093
    adr x0, sign_id
    b cmp_end_1094
cmp_true_1093:
    mov x0, x1
cmp_end_1094:
    cmp x0, #4096
    b.hi do_compose_1095
do_apply_1096:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1097
do_compose_1095:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1097:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1068
    adr x0, Hello
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1098
do_apply_1099:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1100
do_compose_1098:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1100:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1101
do_apply_1102:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1103
do_compose_1101:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1103:
    str x0, [sp, #-16]!
    mov x0, #33
    str x0, [sp, #-16]!
    adr x0, str_20
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1104
    adr x0, sign_id
    b cmp_end_1105
cmp_true_1104:
cmp_end_1105:
    cmp x0, #4096
    b.hi do_compose_1106
do_apply_1107:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1108
do_compose_1106:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1108:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1068
    adr x0, str_0
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
    str x0, [sp, #-16]!
    adr x0, World
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    mov x0, #33
    str x0, [sp, #-16]!
    adr x0, str_21
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1115
    adr x0, sign_id
    b cmp_end_1116
cmp_true_1115:
cmp_end_1116:
    cmp x0, #4096
    b.hi do_compose_1117
do_apply_1118:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1119
do_compose_1117:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1119:
blk_end_1068:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_0
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1120
do_apply_1121:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1122
do_compose_1120:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1122:
    str x0, [sp, #-16]!
    adr x0, str_17
    cmp x0, #4096
    b.hi do_compose_1123
do_apply_1124:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1125
do_compose_1123:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1125:
    adr x1, InEnter
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, myDict
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1126
    b after_func_1128_1129
func_1128:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, 
    ldr x1, [sp], #16
    bl _range
    str x0, [sp, #-16]!
    adr x0, value
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1128_1129:
    // Closure for func_1128
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1128
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1127
cond_false_1126:
    adr x0, sign_id
cond_end_1127:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, gets
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1133
    b after_func_1135_1136
func_1135:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, myDict
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1135_1136:
    // Closure for func_1135
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1135
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1134
cond_false_1133:
    adr x0, sign_id
cond_end_1134:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1137
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1139
    adr x0, sign_id
    b cmp_end_1140
cmp_true_1139:
    mov x0, x1
cmp_end_1140:
    b and_end_1138
and_fail_1137:
    adr x0, sign_id
and_end_1138:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1141
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, str_22
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1143
    adr x0, sign_id
    b cmp_end_1144
cmp_true_1143:
    mov x0, x1
cmp_end_1144:
    b and_end_1142
and_fail_1141:
    adr x0, sign_id
and_end_1142:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1145
    b or_end_1146
or_right_1145:
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, str_22
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1147
    adr x0, sign_id
    b cmp_end_1148
cmp_true_1147:
    mov x0, x1
cmp_end_1148:
or_end_1146:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1149
    b or_end_1150
or_right_1149:
    adr x0, str_22
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1151
    adr x0, sign_id
    b cmp_end_1152
cmp_true_1151:
    mov x0, x1
cmp_end_1152:
or_end_1150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1156
    adr x0, sign_id
    b cmp_end_1157
cmp_true_1156:
    mov x0, x1
cmp_end_1157:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1153
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1155
xor_true_1153:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1154
    adr x0, sign_id
    b xor_end_1155
xor_false_1154:
    mov x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, str_22
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1161
    adr x0, sign_id
    b cmp_end_1162
cmp_true_1161:
    mov x0, x1
cmp_end_1162:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1158
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1160
xor_true_1158:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1159
    adr x0, sign_id
    b xor_end_1160
xor_false_1159:
    mov x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1166
    adr x0, sign_id
    b cmp_end_1167
cmp_true_1166:
cmp_end_1167:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1163
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1165
xor_true_1163:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1164
    adr x0, sign_id
    b xor_end_1165
xor_false_1164:
    mov x0, x1
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1171
    adr x0, sign_id
    b cmp_end_1172
cmp_true_1171:
cmp_end_1172:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1168
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1170
xor_true_1168:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1169
    adr x0, sign_id
    b xor_end_1170
xor_false_1169:
    mov x0, x1
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
x: .quad 0
y: .quad 0
Hello: .quad 0
World: .quad 0
yep: .quad 0
nop: .quad 0
unit: .quad 0
none: .quad 0
id: .quad 0
list: .quad 0
evaluate: .quad 0
Filter: .quad 0
Person: .quad 0
john: .quad 0
State: .quad 0
Base: .quad 0
Existence: .quad 0
Durability: .quad 0
Mentality: .quad 0
Wisdom: .quad 0
agility: .quad 0
myMagician: .quad 0
myValue: .quad 0
myPairs: .quad 0
myPairs0: .quad 0
myPairs1: .quad 0
r: .quad 0
s0: .quad 0
s1: .quad 0
myGreet: .quad 0
greet: .quad 0
hello: .quad 0
welcome: .quad 0
world: .quad 0
n: .quad 0
M: .quad 0
My: .quad 0
InEnter: .quad 0

