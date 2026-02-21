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
    b after_func_67_68
func_67:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    str x0, [sp, #-16]!
    mov x0, #2
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_67_68:
    // Closure for func_67
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_67
    ldr x0, [sp], #16
    bl _cons
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
    b after_func_69_70
func_69:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_71_72
func_71:
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
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_71_72:
    // Closure for func_71
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_71
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_69_70:
    // Closure for func_69
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_69
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_inline_composed_73_74
inline_composed_73:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    // Inline: Left Body
    b after_func_78_79
func_78:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_80_81
func_80:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_82_83
func_82:
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
after_func_82_83:
    // Closure for func_82
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_82
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_84
do_apply_85:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_86
do_compose_84:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_86:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_87
do_apply_88:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_89
do_compose_87:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_89:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_78_79:
    // Closure for func_78
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_78
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_90_91
func_90:
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
after_func_90_91:
    // Closure for func_90
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_90
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_75
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_77
xor_true_75:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_76
    adr x0, sign_id
    b xor_end_77
xor_false_76:
    mov x0, x1
    // Inline: Chaining (Update $1)
    str x0, [x29, #-32]
    // Inline: Right Body
    b after_func_95_96
func_95:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_97_98
func_97:
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
after_func_97_98:
    // Closure for func_97
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_97
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_99
do_apply_100:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_101
do_compose_99:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_101:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    b.ne xor_true_92
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_94
xor_true_92:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_93
    adr x0, sign_id
    b xor_end_94
xor_false_93:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_inline_composed_73_74:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, inline_composed_73
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_inline_composed_105_106
inline_composed_105:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    // Inline: Left Body
    b after_func_110_111
func_110:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_112_113
func_112:
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
after_func_112_113:
    // Closure for func_112
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_112
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_110_111:
    // Closure for func_110
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_110
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
    b.ne xor_true_107
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_109
xor_true_107:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_108
    adr x0, sign_id
    b xor_end_109
xor_false_108:
    mov x0, x1
    // Inline: Chaining (Update $1)
    str x0, [x29, #-32]
    // Inline: Right Body
    b after_func_123_124
func_123:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_125_126
func_125:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_127_128
func_127:
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
after_func_127_128:
    // Closure for func_127
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_127
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_125_126:
    // Closure for func_125
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_125
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
after_func_123_124:
    // Closure for func_123
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_123
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_135_136
func_135:
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
after_func_135_136:
    // Closure for func_135
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_135
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_120
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_122
xor_true_120:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_121
    adr x0, sign_id
    b xor_end_122
xor_false_121:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_inline_composed_105_106:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, inline_composed_105
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_137_138
func_137:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_142_143
func_142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_144_145
func_144:
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
after_func_144_145:
    // Closure for func_144
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_144
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_146
do_apply_147:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_148
do_compose_146:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_148:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_149
do_apply_150:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_151
do_compose_149:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_151:
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
    b.ne xor_true_139
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_141
xor_true_139:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_140
    adr x0, sign_id
    b xor_end_141
xor_false_140:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_137_138:
    // Closure for func_137
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_137
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_152
do_apply_153:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_154
do_compose_152:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_154:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_155_156
func_155:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_160_161
func_160:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_162_163
func_162:
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
after_func_162_163:
    // Closure for func_162
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_162
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    b.ne xor_true_157
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_159
xor_true_157:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_158
    adr x0, sign_id
    b xor_end_159
xor_false_158:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_155_156:
    // Closure for func_155
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_155
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
    adr x0, �
    cmp x0, #4096
    b.hi do_compose_173
do_apply_174:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_175
do_compose_173:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_175:
    str x0, [sp, #-16]!
    adr x0, E
    cmp x0, #4096
    b.hi do_compose_176
do_apply_177:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_178
do_compose_176:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_178:
    str x0, [sp, #-16]!
    adr x0, 即
    cmp x0, #4096
    b.hi do_compose_179
do_apply_180:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_181
do_compose_179:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_181:
    str x0, [sp, #-16]!
    adr x0, 時
    cmp x0, #4096
    b.hi do_compose_182
do_apply_183:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_184
do_compose_182:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_184:
    str x0, [sp, #-16]!
    adr x0, 評
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
    str x0, [sp, #-16]!
    adr x0, 価
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
    adr x0, さ
    cmp x0, #4096
    b.hi do_compose_191
do_apply_192:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_193
do_compose_191:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_193:
    str x0, [sp, #-16]!
    adr x0, れ
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
    str x0, [sp, #-16]!
    adr x0, め
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
    adr x0, E
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
    b.ne blk_end_0
    b after_func_203_204
func_203:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_208_209
func_208:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_210_211
func_210:
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
after_func_210_211:
    // Closure for func_210
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_210
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_208_209:
    // Closure for func_208
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_208
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
    b.ne xor_true_205
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_207
xor_true_205:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_206
    adr x0, sign_id
    b xor_end_207
xor_false_206:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_203_204:
    // Closure for func_203
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_203
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #2
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, 後
    str x0, [sp, #-16]!
    adr x0, 置
    cmp x0, #4096
    b.hi do_compose_221
do_apply_222:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_223
do_compose_221:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_223:
    str x0, [sp, #-16]!
    adr x0, チ
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
    str x0, [sp, #-16]!
    adr x0, ル
    cmp x0, #4096
    b.hi do_compose_227
do_apply_228:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_229
do_compose_227:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_229:
    str x0, [sp, #-16]!
    adr x0, ダ
    cmp x0, #4096
    b.hi do_compose_230
do_apply_231:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_232
do_compose_230:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_232:
    str x0, [sp, #-16]!
    adr x0, を
    cmp x0, #4096
    b.hi do_compose_233
do_apply_234:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_235
do_compose_233:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_235:
    str x0, [sp, #-16]!
    adr x0, 用
    cmp x0, #4096
    b.hi do_compose_236
do_apply_237:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_238
do_compose_236:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_238:
    str x0, [sp, #-16]!
    adr x0, ぁ
    cmp x0, #4096
    b.hi do_compose_239
do_apply_240:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_241
do_compose_239:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_241:
    str x0, [sp, #-16]!
    adr x0, E
    cmp x0, #4096
    b.hi do_compose_242
do_apply_243:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_244
do_compose_242:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_244:
    str x0, [sp, #-16]!
    adr x0, �
    cmp x0, #4096
    b.hi do_compose_245
do_apply_246:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_247
do_compose_245:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_247:
    str x0, [sp, #-16]!
    adr x0, �
    cmp x0, #4096
    b.hi do_compose_248
do_apply_249:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_250
do_compose_248:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_250:
    str x0, [sp, #-16]!
    adr x0, こ
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
    str x0, [sp, #-16]!
    adr x0, と
    cmp x0, #4096
    b.hi do_compose_254
do_apply_255:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_256
do_compose_254:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_256:
    str x0, [sp, #-16]!
    adr x0, で
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
    str x0, [sp, #-16]!
    adr x0, 、
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
    adr x0, 即
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
    str x0, [sp, #-16]!
    adr x0, 時
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
    adr x0, 評
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
    str x0, [sp, #-16]!
    adr x0, 価
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
    adr x0, さ
    cmp x0, #4096
    b.hi do_compose_275
do_apply_276:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_277
do_compose_275:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_277:
    str x0, [sp, #-16]!
    adr x0, れ
    cmp x0, #4096
    b.hi do_compose_278
do_apply_279:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_280
do_compose_278:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_280:
    str x0, [sp, #-16]!
    adr x0, め
    cmp x0, #4096
    b.hi do_compose_281
do_apply_282:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_283
do_compose_281:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_283:
    str x0, [sp, #-16]!
    adr x0, E
    cmp x0, #4096
    b.hi do_compose_284
do_apply_285:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_286
do_compose_284:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_286:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_list_impl_287
list_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_291_292
func_291:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_293_294
func_293:
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
after_func_293_294:
    // Closure for func_293
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_293
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_295
do_apply_296:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_297
do_compose_295:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_297:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_291_292:
    // Closure for func_291
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_291
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
    b.ne xor_true_288
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_290
xor_true_288:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_289
    adr x0, sign_id
    b xor_end_290
xor_false_289:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_list_impl_287:
    // Closure for list_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, list_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _cons
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
    b.eq cmp_true_301
    adr x0, sign_id
    b cmp_end_302
cmp_true_301:
cmp_end_302:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_303_304
func_303:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_308_309
func_308:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_310_311
func_310:
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
after_func_310_311:
    // Closure for func_310
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_310
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_312
do_apply_313:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_314
do_compose_312:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_314:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_315
do_apply_316:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_317
do_compose_315:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_317:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_308_309:
    // Closure for func_308
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_308
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
    b.ne xor_true_305
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_307
xor_true_305:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_306
    adr x0, sign_id
    b xor_end_307
xor_false_306:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_303_304:
    // Closure for func_303
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_303
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
    b.ne blk_end_0
    b after_func_321_322
func_321:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_324
    b or_end_325
or_right_324:
    adr x0, f
or_end_325:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_323
    b after_func_326_327
func_326:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, f
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_328
do_apply_329:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_330
do_compose_328:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_330:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, f
    cmp x0, #4096
    b.hi do_compose_331
do_apply_332:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_333
do_compose_331:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_333:
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    cmp x0, #4096
    b.hi do_compose_334
do_apply_335:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_336
do_compose_334:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_336:
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_326_327:
    // Closure for func_326
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_326
    ldr x0, [sp], #16
    bl _cons
blk_end_323:
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
    b.ne blk_end_0
    adr x0, Filter
    str x0, [sp, #-16]!
    b after_func_337_338
func_337:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_342_343
func_342:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_344_345
func_344:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_346
    adr x0, sign_id
    b cmp_end_347
cmp_true_346:
cmp_end_347:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_344_345:
    // Closure for func_344
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_344
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_342_343:
    // Closure for func_342
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_342
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_354
    adr x0, sign_id
    b cmp_end_355
cmp_true_354:
cmp_end_355:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_339
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_341
xor_true_339:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_340
    adr x0, sign_id
    b xor_end_341
xor_false_340:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_337_338:
    // Closure for func_337
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_337
    ldr x0, [sp], #16
    bl _cons
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
    mov x0, #-2
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    bl _range
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_inline_composed_362_363
inline_composed_362:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    // Inline: Left Body
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
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    // Inline: Chaining (Update $1)
    str x0, [x29, #-32]
    // Inline: Right Body
    b after_func_380_381
func_380:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_382_383
func_382:
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
after_func_382_383:
    // Closure for func_382
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_382
    ldr x0, [sp], #16
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_380_381:
    // Closure for func_380
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_380
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
    b.ne xor_true_377
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_379
xor_true_377:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_378
    adr x0, sign_id
    b xor_end_379
xor_false_378:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_inline_composed_362_363:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, inline_composed_362
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #5
    str x0, [sp, #-16]!
    b after_func_392_393
func_392:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_397_398
func_397:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_399_400
func_399:
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
after_func_399_400:
    // Closure for func_399
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_399
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
after_func_397_398:
    // Closure for func_397
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_397
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
    b.ne xor_true_394
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_396
xor_true_394:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_395
    adr x0, sign_id
    b xor_end_396
xor_false_395:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_392_393:
    // Closure for func_392
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_392
    ldr x0, [sp], #16
    bl _cons
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_390
    adr x0, sign_id
    b cmp_end_391
cmp_true_390:
    mov x0, x1
cmp_end_391:
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
    str x0, [sp, #-16]!
    b after_func_412_413
func_412:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_417_418
func_417:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_419_420
func_419:
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
after_func_419_420:
    // Closure for func_419
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_419
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_417_418:
    // Closure for func_417
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_417
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
    b.ne xor_true_414
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_416
xor_true_414:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_415
    adr x0, sign_id
    b xor_end_416
xor_false_415:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_412_413:
    // Closure for func_412
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_412
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #5
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
    mov x0, #12
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_410
    adr x0, sign_id
    b cmp_end_411
cmp_true_410:
cmp_end_411:
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
    b.ne blk_end_0
    b after_func_433_434
func_433:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    mov x0, #1
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
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_441
    adr x0, sign_id
    b cmp_end_442
cmp_true_441:
    mov x0, x1
cmp_end_442:
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
    b.ne blk_end_0
    b after_func_446_447
func_446:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_446_447:
    // Closure for func_446
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_446
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
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
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_451
    adr x0, sign_id
    b cmp_end_452
cmp_true_451:
    mov x0, x1
cmp_end_452:
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
    str x0, [sp, #-16]!
    mov x0, #2
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
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_459
    adr x0, sign_id
    b cmp_end_460
cmp_true_459:
    mov x0, x1
cmp_end_460:
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
    b.ne blk_end_0
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #1
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
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_467
    adr x0, sign_id
    b cmp_end_468
cmp_true_467:
    mov x0, x1
cmp_end_468:
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
    mov x0, #3
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
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_469
    adr x0, sign_id
    b cmp_end_470
cmp_true_469:
cmp_end_470:
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
    b.eq cmp_true_477
    adr x0, sign_id
    b cmp_end_478
cmp_true_477:
cmp_end_478:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_479_480
func_479:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, y
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_479_480:
    // Closure for func_479
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_479
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
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
    mov x0, #2
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
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_487
    adr x0, sign_id
    b cmp_end_488
cmp_true_487:
    mov x0, x1
cmp_end_488:
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
    str x0, [sp, #-16]!
    mov x0, #3
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_495_496
func_495:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, y
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_495_496:
    // Closure for func_495
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_495
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #1
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
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_500
    adr x0, sign_id
    b cmp_end_501
cmp_true_500:
    mov x0, x1
cmp_end_501:
    str x0, [sp, #-16]!
    mov x0, #3
    cmp x0, #4096
    b.hi do_compose_502
do_apply_503:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_504
do_compose_502:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_504:
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
    b.hi do_compose_505
do_apply_506:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_507
do_compose_505:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_507:
    str x0, [sp, #-16]!
    mov x0, #3
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
    str x0, [sp, #-16]!
    mov x0, #3
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
    mov x0, #3
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_523_524
func_523:
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
    b.ne blk_end_525
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    ldr x1, [sp], #16
    add x0, x1, x0
blk_end_525:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_526_527
func_526:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_531_532
func_531:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_533_534
func_533:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_535_536
func_535:
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
after_func_535_536:
    // Closure for func_535
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_535
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_533_534:
    // Closure for func_533
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_533
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_531_532:
    // Closure for func_531
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_531
    ldr x0, [sp], #16
    bl _cons
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_528
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_530
xor_true_528:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_529
    adr x0, sign_id
    b xor_end_530
xor_false_529:
    mov x0, x1
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
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_548
    adr x0, sign_id
    b cmp_end_549
cmp_true_548:
cmp_end_549:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_546
    mov x0, #0
    b cond_end_547
cond_false_546:
    adr x0, sign_id
cond_end_547:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_545
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_552
    adr x0, sign_id
    b cmp_end_553
cmp_true_552:
cmp_end_553:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_550
    adr x0, str_2
    b cond_end_551
cond_false_550:
    adr x0, sign_id
cond_end_551:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_545
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_556
    adr x0, sign_id
    b cmp_end_557
cmp_true_556:
cmp_end_557:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_554
    adr x0, str_3
    b cond_end_555
cond_false_554:
    adr x0, sign_id
cond_end_555:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_545
    adr x0, str_4
blk_end_545:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_561_562
func_561:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_566_567
func_566:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_568_569
func_568:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_570_571
func_570:
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
after_func_570_571:
    // Closure for func_570
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_570
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_568_569:
    // Closure for func_568
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_568
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_572
do_apply_573:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_574
do_compose_572:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_574:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_575
do_apply_576:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_577
do_compose_575:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_577:
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
    str x0, [sp, #-16]!
    b after_func_578_579
func_578:
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
after_func_578_579:
    // Closure for func_578
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_578
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_563
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_565
xor_true_563:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_564
    adr x0, sign_id
    b xor_end_565
xor_false_564:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_561_562:
    // Closure for func_561
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_561
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_581
    adr x0, sign_id
    b cmp_end_582
cmp_true_581:
cmp_end_582:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_580
    adr x0, sign_id
    cmp x0, #0
    b.ge abs_pos_583
    neg x0, x0
abs_pos_583:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_586
    adr x0, sign_id
    b cmp_end_587
cmp_true_586:
cmp_end_587:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_584
    adr x0, str_2
    b and_end_585
and_fail_584:
    adr x0, sign_id
and_end_585:
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
    b.ne blk_end_580
    adr x0, sign_id
    cmp x0, #0
    b.ge abs_pos_591
    neg x0, x0
abs_pos_591:
    str x0, [sp, #-16]!
    adr x0, x
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_594
    adr x0, sign_id
    b cmp_end_595
cmp_true_594:
cmp_end_595:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_592
    adr x0, str_3
    b and_end_593
and_fail_592:
    adr x0, sign_id
and_end_593:
    cmp x0, #4096
    b.hi do_compose_596
do_apply_597:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_598
do_compose_596:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_598:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_580
    adr x0, sign_id
    cmp x0, #0
    b.ge abs_pos_599
    neg x0, x0
abs_pos_599:
    str x0, [sp, #-16]!
    adr x0, str_4
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
blk_end_580:
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
    b.ne blk_end_0
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_606_607
func_606:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_609
    b or_end_610
or_right_609:
    adr x0, name
or_end_610:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_608
    b after_func_611_612
func_611:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_613_614
func_613:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_615_616
func_615:
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
    adr x0, name
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_617
    ldr x0, [x29, #-48]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_617
    ldr x0, [x29, #-64]
    ldr x0, [x0] // @ load
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_618
    ldr x0, [x29, #-32]
    b cond_end_619
cond_false_618:
    adr x0, sign_id
cond_end_619:
blk_end_617:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_615_616:
    // Closure for func_615
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
    adr x1, func_615
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_613_614:
    // Closure for func_613
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_613
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_611_612:
    // Closure for func_611
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_611
    ldr x0, [sp], #16
    bl _cons
blk_end_608:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_606_607:
    // Closure for func_606
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_606
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Person
    adr x1, john
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_5
    cmp x0, #4096
    b.hi do_compose_620
do_apply_621:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_622
do_compose_620:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_622:
    str x0, [sp, #-16]!
    mov x0, #18
    cmp x0, #4096
    b.hi do_compose_623
do_apply_624:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_625
do_compose_623:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_625:
    str x0, [sp, #-16]!
    adr x0, str_6
    cmp x0, #4096
    b.hi do_compose_626
do_apply_627:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_628
do_compose_626:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_628:
    str x0, [sp, #-16]!
    adr x0, Like
    cmp x0, #4096
    b.hi do_compose_629
do_apply_630:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_631
do_compose_629:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_631:
    str x0, [sp, #-16]!
    adr x0, str_6
    cmp x0, #4096
    b.hi do_compose_632
do_apply_633:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_634
do_compose_632:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_634:
    str x0, [sp, #-16]!
    adr x0, str_7
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
    b.eq cmp_true_638
    adr x0, sign_id
    b cmp_end_639
cmp_true_638:
cmp_end_639:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_640_641
func_640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_645_646
func_645:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_647_648
func_647:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_651
    b after_func_653_654
func_653:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_658_659
func_658:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_660_661
func_660:
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
after_func_660_661:
    // Closure for func_660
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_660
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_658_659:
    // Closure for func_658
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_658
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
    b.ne xor_true_655
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_657
xor_true_655:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_656
    adr x0, sign_id
    b xor_end_657
xor_false_656:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_653_654:
    // Closure for func_653
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_653
    ldr x0, [sp], #16
    bl _cons
    b cond_end_652
cond_false_651:
    adr x0, sign_id
cond_end_652:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_649
    adr x0, sign_id
    b cmp_end_650
cmp_true_649:
cmp_end_650:
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #3
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_676
    b after_func_678_679
func_678:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_683_684
func_683:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_685_686
func_685:
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
after_func_685_686:
    // Closure for func_685
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_685
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_683_684:
    // Closure for func_683
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_683
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
    b.ne xor_true_680
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_682
xor_true_680:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_681
    adr x0, sign_id
    b xor_end_682
xor_false_681:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_678_679:
    // Closure for func_678
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_678
    ldr x0, [sp], #16
    bl _cons
    b cond_end_677
cond_false_676:
    adr x0, sign_id
cond_end_677:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_674
    adr x0, sign_id
    b cmp_end_675
cmp_true_674:
cmp_end_675:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_642
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_644
xor_true_642:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_643
    adr x0, sign_id
    b xor_end_644
xor_false_643:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_640_641:
    // Closure for func_640
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_640
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    mov x0, #3
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
    mov x0, #4
    str x0, [sp, #-16]!
    mov x0, #4
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_696
    adr x0, sign_id
    b cmp_end_697
cmp_true_696:
    mov x0, x1
cmp_end_697:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, Existence
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, Durability
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, Mentality
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, Wisdom
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, Agility
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, Equipment
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_701
    adr x0, Bag
blk_end_701:
    adr x1, State
    str x0, [x1]
    adr x0, sign_id
    adr x1, MyGame
    str x0, [x1]
    adr x0, sign_id
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
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, MyGame
    ldr x0, [x0]
    str x0, [sp, #-16]!
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
    b.ne blk_end_705
    adr x0, State
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
blk_end_705:
    ldr x1, [sp], #16
    bl _range
    adr x1, Mob
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_706
do_apply_707:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_708
do_compose_706:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_708:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, Mob
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    adr x1, Existence
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_710
    mov x0, #3
    adr x1, Durability
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_710
    mov x0, #10
    adr x1, Mentality
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_710
    mov x0, #8
    adr x1, Wisdom
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_710
    mov x0, #5
    adr x1, agility
    str x0, [x1]
    adr x0, sign_id
blk_end_710:
    adr x1, Base
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_709
    adr x0, Magician
    ldr x0, [x0]
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
blk_end_709:
    ldr x1, [sp], #16
    bl _range
    adr x1, Magician
    str x0, [x1]
    adr x0, sign_id
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
    b.ne blk_end_0
    adr x0, Magician
    ldr x0, [x0]
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
    b.ne blk_end_714
    b after_func_715_716
func_715:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_720_721
func_720:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_722_723
func_722:
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
after_func_722_723:
    // Closure for func_722
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_722
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_724
do_apply_725:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_726
do_compose_724:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_726:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_720_721:
    // Closure for func_720
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_720
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
    b.ne xor_true_717
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_719
xor_true_717:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_718
    adr x0, sign_id
    b xor_end_719
xor_false_718:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_715_716:
    // Closure for func_715
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_715
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_714
    b after_func_730_731
func_730:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_735_736
func_735:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_737_738
func_737:
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
after_func_737_738:
    // Closure for func_737
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_737
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_735_736:
    // Closure for func_735
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_735
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
    b.ne xor_true_732
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_734
xor_true_732:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_733
    adr x0, sign_id
    b xor_end_734
xor_false_733:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_730_731:
    // Closure for func_730
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_730
    ldr x0, [sp], #16
    bl _cons
blk_end_714:
    adr x1, myValue
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, myPairs
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
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
    str x0, [sp, #-16]!
    mov x0, #4
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
    str x0, [sp, #-16]!
    mov x0, #5
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
    b.ne blk_end_0
    b after_myPairs0_impl_757
myPairs0_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_761_762
func_761:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_763_764
func_763:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_765_766
func_765:
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
after_func_765_766:
    // Closure for func_765
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_765
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_763_764:
    // Closure for func_763
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_763
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_770
do_apply_771:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_772
do_compose_770:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_772:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_761_762:
    // Closure for func_761
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_761
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_773_774
func_773:
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
after_func_773_774:
    // Closure for func_773
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_773
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_758
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_760
xor_true_758:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_759
    adr x0, sign_id
    b xor_end_760
xor_false_759:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_myPairs0_impl_757:
    // Closure for myPairs0_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, myPairs0_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_775
do_apply_776:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_777
do_compose_775:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_777:
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_778
do_apply_779:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_780
do_compose_778:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_780:
    str x0, [sp, #-16]!
    mov x0, #3
    cmp x0, #4096
    b.hi do_compose_781
do_apply_782:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_783
do_compose_781:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_783:
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_784
do_apply_785:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_786
do_compose_784:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_786:
    str x0, [sp, #-16]!
    mov x0, #5
    cmp x0, #4096
    b.hi do_compose_787
do_apply_788:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_789
do_compose_787:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_789:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, myPairs1
    str x0, [x1]
    adr x0, sign_id
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
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, myPairs0
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_792
    adr x0, sign_id
    b cmp_end_793
cmp_true_792:
cmp_end_793:
    str x0, [sp, #-16]!
    adr x0, myPairs1
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_790
    adr x0, sign_id
    b cmp_end_791
cmp_true_790:
cmp_end_791:
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
    b.eq cmp_true_794
    adr x0, sign_id
    b cmp_end_795
cmp_true_794:
cmp_end_795:
    str x0, [sp, #-16]!
    mov x0, #3
    cmp x0, #4096
    b.hi do_compose_796
do_apply_797:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_798
do_compose_796:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_798:
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_799
do_apply_800:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_801
do_compose_799:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_801:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_802_803
func_802:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_807_808
func_807:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_809_810
func_809:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_811_812
func_811:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_816_817
func_816:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_818_819
func_818:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_820_821
func_820:
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
after_func_820_821:
    // Closure for func_820
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_820
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_822
do_apply_823:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_824
do_compose_822:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_824:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_825
do_apply_826:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_827
do_compose_825:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_827:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_816_817:
    // Closure for func_816
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_816
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_828_829
func_828:
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
after_func_828_829:
    // Closure for func_828
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_828
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_813
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_815
xor_true_813:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_814
    adr x0, sign_id
    b xor_end_815
xor_false_814:
    mov x0, x1
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_809_810:
    // Closure for func_809
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_809
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_830
do_apply_831:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_832
do_compose_830:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_832:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_833
do_apply_834:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_835
do_compose_833:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_835:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_807_808:
    // Closure for func_807
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_807
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_836_837
func_836:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_841_842
func_841:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_843_844
func_843:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_845_846
func_845:
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
after_func_845_846:
    // Closure for func_845
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_845
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_843_844:
    // Closure for func_843
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_843
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_847
do_apply_848:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_849
do_compose_847:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_849:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_841_842:
    // Closure for func_841
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_841
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_853_854
func_853:
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
after_func_853_854:
    // Closure for func_853
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_853
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_838
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_840
xor_true_838:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_839
    adr x0, sign_id
    b xor_end_840
xor_false_839:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_836_837:
    // Closure for func_836
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_836
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
    b.ne xor_true_804
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_806
xor_true_804:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_805
    adr x0, sign_id
    b xor_end_806
xor_false_805:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_802_803:
    // Closure for func_802
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_802
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
    b.eq cmp_true_855
    adr x0, sign_id
    b cmp_end_856
cmp_true_855:
cmp_end_856:
    cmp x0, #4096
    b.hi do_compose_857
do_apply_858:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_859
do_compose_857:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_859:
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
    b after_func_860_861
func_860:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_865_866
func_865:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
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
after_func_869_870:
    // Closure for func_869
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_865_866:
    // Closure for func_865
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_865
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_877_878
func_877:
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
after_func_877_878:
    // Closure for func_877
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_877
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_862
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_864
xor_true_862:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_863
    adr x0, sign_id
    b xor_end_864
xor_false_863:
    mov x0, x1
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
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #15
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_879
    adr x0, sign_id
    b cmp_end_880
cmp_true_879:
cmp_end_880:
    cmp x0, #4096
    b.hi do_compose_881
do_apply_882:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_883
do_compose_881:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_883:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_884_885
func_884:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_889_890
func_889:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_891_892
func_891:
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
after_func_891_892:
    // Closure for func_891
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_891
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_893
do_apply_894:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_895
do_compose_893:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_895:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_896
do_apply_897:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_898
do_compose_896:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_898:
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
    b.ne xor_true_886
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_888
xor_true_886:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_887
    adr x0, sign_id
    b xor_end_888
xor_false_887:
    mov x0, x1
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
    str x0, [sp, #-16]!
    adr x0, myPairs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_899
    adr x0, sign_id
    b cmp_end_900
cmp_true_899:
cmp_end_900:
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
    str x0, [sp, #-16]!
    mov x0, #4
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
    mov x0, #6
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
    str x0, [sp, #-16]!
    mov x0, #8
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
    str x0, [sp, #-16]!
    mov x0, #10
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_916_917
func_916:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_921_922
func_921:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_923_924
func_923:
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
    b.gt cmp_true_925
    adr x0, sign_id
    b cmp_end_926
cmp_true_925:
cmp_end_926:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_923_924:
    // Closure for func_923
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_923
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_921_922:
    // Closure for func_921
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_921
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
    b.gt cmp_true_933
    adr x0, sign_id
    b cmp_end_934
cmp_true_933:
cmp_end_934:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_918
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_920
xor_true_918:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_919
    adr x0, sign_id
    b xor_end_920
xor_false_919:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_916_917:
    // Closure for func_916
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_916
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
    b.eq cmp_true_935
    adr x0, sign_id
    b cmp_end_936
cmp_true_935:
cmp_end_936:
    cmp x0, #4096
    b.hi do_compose_937
do_apply_938:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_939
do_compose_937:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_939:
    str x0, [sp, #-16]!
    mov x0, #4
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
    str x0, [sp, #-16]!
    mov x0, #5
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
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
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
    adr x1, r
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #4
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x1, s0
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #4
    cmp x0, #4096
    b.hi do_compose_958
do_apply_959:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_960
do_compose_958:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_960:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_961
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #4
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
blk_end_961:
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
    b.ne blk_end_969
    adr x0, str_10
    adr x1, welcome
    str x0, [x1]
    adr x0, sign_id
blk_end_969:
    adr x1, greet
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_968
    adr x0, str_11
    adr x1, world
    str x0, [x1]
    adr x0, sign_id
blk_end_968:
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
    b.eq cmp_true_970
    adr x0, sign_id
    b cmp_end_971
cmp_true_970:
cmp_end_971:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, myGreet
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, '
    str x0, [sp, #-16]!
    adr x0, greet
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_973
do_apply_974:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_975
do_compose_973:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_975:
    str x0, [sp, #-16]!
    b after_func_976_977
func_976:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_981_982
func_981:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_983_984
func_983:
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
after_func_983_984:
    // Closure for func_983
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_983
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_981_982:
    // Closure for func_981
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_981
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
    b.ne xor_true_978
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_980
xor_true_978:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_979
    adr x0, sign_id
    b xor_end_980
xor_false_979:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_976_977:
    // Closure for func_976
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_976
    ldr x0, [sp], #16
    bl _cons
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
    b.ne blk_end_972
    adr x0, '
    str x0, [sp, #-16]!
    adr x0, world
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
blk_end_972:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, =
    str x0, [sp, #-16]!
    adr x0, str_12
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
    b.ne blk_end_0
    adr x0, myGreet
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, '
    str x0, [sp, #-16]!
    adr x0, greet
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1004
do_apply_1005:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1006
do_compose_1004:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1006:
    str x0, [sp, #-16]!
    b after_func_1007_1008
func_1007:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
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
after_func_1014_1015:
    // Closure for func_1014
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1014
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1016
do_apply_1017:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1018
do_compose_1016:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1018:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1019
do_apply_1020:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1021
do_compose_1019:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1021:
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
after_func_1007_1008:
    // Closure for func_1007
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1007
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1022
do_apply_1023:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1024
do_compose_1022:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1024:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1003
    adr x0, '
    str x0, [sp, #-16]!
    adr x0, str_14
    adr x1, world
    str x0, [x1]
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_1025
do_apply_1026:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1027
do_compose_1025:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1027:
blk_end_1003:
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
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #1
    adr x1, y
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1031
    mov x0, #0
    adr x1, n
    str x0, [x1]
    adr x0, sign_id
blk_end_1031:
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
    b.eq cmp_true_1035
    adr x0, sign_id
    b cmp_end_1036
cmp_true_1035:
cmp_end_1036:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, io
    str x0, [sp, #-16]!
    adr x0, say
    str x0, [sp, #-16]!
    adr x0, Hello
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1037
do_apply_1038:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1039
do_compose_1037:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1039:
    str x0, [sp, #-16]!
    adr x0, World
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
    adr x0, World
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
    b after_inline_composed_1049_1050
inline_composed_1049:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    // Inline: Left Body
    b after_func_1054_1055
func_1054:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1056_1057
func_1056:
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
after_func_1056_1057:
    // Closure for func_1056
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1056
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1061
do_apply_1062:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1063
do_compose_1061:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1063:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1054_1055:
    // Closure for func_1054
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1054
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
    b.ne xor_true_1051
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1053
xor_true_1051:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1052
    adr x0, sign_id
    b xor_end_1053
xor_false_1052:
    mov x0, x1
    // Inline: Chaining (Update $1)
    str x0, [x29, #-32]
    // Inline: Right Body
    b after_func_1067_1068
func_1067:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1069_1070
func_1069:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1071_1072
func_1071:
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
after_func_1071_1072:
    // Closure for func_1071
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1071
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_1073
do_apply_1074:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1075
do_compose_1073:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1075:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1067_1068:
    // Closure for func_1067
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1067
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1079_1080
func_1079:
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
after_func_1079_1080:
    // Closure for func_1079
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1079
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1064
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1066
xor_true_1064:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1065
    adr x0, sign_id
    b xor_end_1066
xor_false_1065:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_inline_composed_1049_1050:
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, inline_composed_1049
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
    b.eq cmp_true_1081
    adr x0, sign_id
    b cmp_end_1082
cmp_true_1081:
cmp_end_1082:
    cmp x0, #4096
    b.hi do_compose_1083
do_apply_1084:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1085
do_compose_1083:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1085:
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
    adr x1, My
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #121
    cmp x0, #4096
    b.hi do_compose_1086
do_apply_1087:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1088
do_compose_1086:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1088:
    str x0, [sp, #-16]!
    mov x0, #32
    cmp x0, #4096
    b.hi do_compose_1089
do_apply_1090:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1091
do_compose_1089:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1091:
    str x0, [sp, #-16]!
    mov x0, #68
    cmp x0, #4096
    b.hi do_compose_1092
do_apply_1093:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1094
do_compose_1092:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1094:
    str x0, [sp, #-16]!
    mov x0, #111
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
    str x0, [sp, #-16]!
    mov x0, #109
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
    mov x0, #101
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
    mov x0, #115
    cmp x0, #4096
    b.hi do_compose_1104
do_apply_1105:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1106
do_compose_1104:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1106:
    str x0, [sp, #-16]!
    mov x0, #116
    cmp x0, #4096
    b.hi do_compose_1107
do_apply_1108:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1109
do_compose_1107:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1109:
    str x0, [sp, #-16]!
    mov x0, #105
    cmp x0, #4096
    b.hi do_compose_1110
do_apply_1111:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1112
do_compose_1110:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1112:
    str x0, [sp, #-16]!
    mov x0, #99
    cmp x0, #4096
    b.hi do_compose_1113
do_apply_1114:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1115
do_compose_1113:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1115:
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
    b.eq cmp_true_1116
    adr x0, sign_id
    b cmp_end_1117
cmp_true_1116:
cmp_end_1117:
    str x0, [sp, #-16]!
    mov x0, #121
    cmp x0, #4096
    b.hi do_compose_1118
do_apply_1119:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1120
do_compose_1118:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1120:
    str x0, [sp, #-16]!
    mov x0, #32
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
    str x0, [sp, #-16]!
    mov x0, #68
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
    mov x0, #111
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
    str x0, [sp, #-16]!
    mov x0, #109
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
    str x0, [sp, #-16]!
    mov x0, #101
    cmp x0, #4096
    b.hi do_compose_1133
do_apply_1134:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1135
do_compose_1133:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1135:
    str x0, [sp, #-16]!
    mov x0, #115
    cmp x0, #4096
    b.hi do_compose_1136
do_apply_1137:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1138
do_compose_1136:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1138:
    str x0, [sp, #-16]!
    mov x0, #116
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
    str x0, [sp, #-16]!
    mov x0, #105
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
    mov x0, #99
    str x0, [sp, #-16]!
    adr x0, str_15
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1145
    adr x0, sign_id
    b cmp_end_1146
cmp_true_1145:
cmp_end_1146:
    cmp x0, #4096
    b.hi do_compose_1147
do_apply_1148:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1149
do_compose_1147:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1149:
    str x0, [sp, #-16]!
    adr x0, str_16
    str x0, [sp, #-16]!
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1151
    adr x0, sign_id
    b cmp_end_1152
cmp_true_1151:
    mov x0, x1
cmp_end_1152:
    cmp x0, #4096
    b.hi do_compose_1153
do_apply_1154:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1155
do_compose_1153:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1155:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1150
    adr x0, str_0
    str x0, [sp, #-16]!
    mov x0, #32
    cmp x0, #4096
    b.hi do_compose_1156
do_apply_1157:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1158
do_compose_1156:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1158:
    str x0, [sp, #-16]!
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1159
    adr x0, sign_id
    b cmp_end_1160
cmp_true_1159:
    mov x0, x1
cmp_end_1160:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1150
    mov x0, #72
    str x0, [sp, #-16]!
    adr x0, str_19
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
    mov x0, #32
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
    str x0, [sp, #-16]!
    adr x0, str_1
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
    str x0, [sp, #-16]!
    mov x0, #33
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1173
    adr x0, sign_id
    b cmp_end_1174
cmp_true_1173:
cmp_end_1174:
    cmp x0, #4096
    b.hi do_compose_1175
do_apply_1176:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1177
do_compose_1175:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1177:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1150
    adr x0, str_16
    str x0, [sp, #-16]!
    adr x0, My
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1178
do_apply_1179:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1180
do_compose_1178:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1180:
    str x0, [sp, #-16]!
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, str_20
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1181
    adr x0, sign_id
    b cmp_end_1182
cmp_true_1181:
    mov x0, x1
cmp_end_1182:
    cmp x0, #4096
    b.hi do_compose_1183
do_apply_1184:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1185
do_compose_1183:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1185:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1150
    adr x0, Hello
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #32
    cmp x0, #4096
    b.hi do_compose_1186
do_apply_1187:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1188
do_compose_1186:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1188:
    str x0, [sp, #-16]!
    adr x0, My
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1189
do_apply_1190:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1191
do_compose_1189:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1191:
    str x0, [sp, #-16]!
    mov x0, #32
    cmp x0, #4096
    b.hi do_compose_1192
do_apply_1193:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1194
do_compose_1192:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1194:
    str x0, [sp, #-16]!
    adr x0, str_1
    cmp x0, #4096
    b.hi do_compose_1195
do_apply_1196:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1197
do_compose_1195:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1197:
    str x0, [sp, #-16]!
    mov x0, #33
    str x0, [sp, #-16]!
    adr x0, str_20
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1198
    adr x0, sign_id
    b cmp_end_1199
cmp_true_1198:
cmp_end_1199:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1150
    adr x0, str_0
    str x0, [sp, #-16]!
    mov x0, #33
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
    str x0, [sp, #-16]!
    mov x0, #32
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
    str x0, [sp, #-16]!
    adr x0, My
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1209
do_apply_1210:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1211
do_compose_1209:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1211:
    str x0, [sp, #-16]!
    adr x0, World
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1212
do_apply_1213:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1214
do_compose_1212:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1214:
    str x0, [sp, #-16]!
    mov x0, #33
    str x0, [sp, #-16]!
    adr x0, str_21
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1215
    adr x0, sign_id
    b cmp_end_1216
cmp_true_1215:
cmp_end_1216:
    cmp x0, #4096
    b.hi do_compose_1217
do_apply_1218:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1219
do_compose_1217:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1219:
blk_end_1150:
    cmp x0, #4096
    b.hi do_compose_1220
do_apply_1221:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1222
do_compose_1220:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1222:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_0
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1223
do_apply_1224:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1225
do_compose_1223:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1225:
    str x0, [sp, #-16]!
    adr x0, str_17
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
    adr x1, InEnter
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1229_1230
func_1229:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1231_1232
func_1231:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1234
    b or_end_1235
or_right_1234:
    adr x0, name
or_end_1235:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1233
    b after_func_1236_1237
func_1236:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, name
    str x0, [sp, #-16]!
    adr x0, 
    ldr x1, [sp], #16
    bl _range
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1238
do_apply_1239:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1240
do_compose_1238:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1240:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1236_1237:
    // Closure for func_1236
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1236
    ldr x0, [sp], #16
    bl _cons
blk_end_1233:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1231_1232:
    // Closure for func_1231
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1231
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1229_1230:
    // Closure for func_1229
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1229
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1241_1242
func_1241:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1243_1244
func_1243:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1246
    b or_end_1247
or_right_1246:
    adr x0, name
or_end_1247:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1245
    adr x0, myDict
    str x0, [sp, #-16]!
    adr x0, name
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
blk_end_1245:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1243_1244:
    // Closure for func_1243
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1243
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1241_1242:
    // Closure for func_1241
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1241
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1248
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1250
    adr x0, sign_id
    b cmp_end_1251
cmp_true_1250:
    mov x0, x1
cmp_end_1251:
    b and_end_1249
and_fail_1248:
    adr x0, sign_id
and_end_1249:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1252
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, str_22
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1254
    adr x0, sign_id
    b cmp_end_1255
cmp_true_1254:
    mov x0, x1
cmp_end_1255:
    b and_end_1253
and_fail_1252:
    adr x0, sign_id
and_end_1253:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1256
    b or_end_1257
or_right_1256:
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, str_22
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1258
    adr x0, sign_id
    b cmp_end_1259
cmp_true_1258:
    mov x0, x1
cmp_end_1259:
or_end_1257:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1260
    b or_end_1261
or_right_1260:
    adr x0, str_22
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1262
    adr x0, sign_id
    b cmp_end_1263
cmp_true_1262:
    mov x0, x1
cmp_end_1263:
or_end_1261:
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
    b.eq cmp_true_1267
    adr x0, sign_id
    b cmp_end_1268
cmp_true_1267:
    mov x0, x1
cmp_end_1268:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1264
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1266
xor_true_1264:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1265
    adr x0, sign_id
    b xor_end_1266
xor_false_1265:
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
    b.eq cmp_true_1272
    adr x0, sign_id
    b cmp_end_1273
cmp_true_1272:
    mov x0, x1
cmp_end_1273:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1269
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1271
xor_true_1269:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1270
    adr x0, sign_id
    b xor_end_1271
xor_false_1270:
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
    b.eq cmp_true_1277
    adr x0, sign_id
    b cmp_end_1278
cmp_true_1277:
cmp_end_1278:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1274
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1276
xor_true_1274:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1275
    adr x0, sign_id
    b xor_end_1276
xor_false_1275:
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
    b.eq cmp_true_1282
    adr x0, sign_id
    b cmp_end_1283
cmp_true_1282:
cmp_end_1283:
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1279
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1281
xor_true_1279:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1280
    adr x0, sign_id
    b xor_end_1281
xor_false_1280:
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
john: .quad 0
MyGame: .quad 0
State: .quad 0
Mob: .quad 0
Base: .quad 0
Magician: .quad 0
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

