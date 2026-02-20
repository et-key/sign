// Sign Compiler Output
// Target: aarch64
// Mode: compile
// Exception Level: 0
// Link: static
// Options: debug=false, optimize=false

.global __sign_init
.text
__sign_init:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    mov x0,     adr x0, _sys_brk

    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x1, heap_start
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0,     adr x0, _sys_brk

    str x0, [sp, #-16]!
    adr x0, heap_start
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, =0x4130000000000000
    ldr x1, [sp], #16
    add x0, x1, x0
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
    adr x1, heap_end
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, heap_start
    ldr x0, [x0]
    adr x1, heap_addr
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, alloc
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7
    b after_func_9_10
func_9:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, curr
    str x0, [sp, #-16]!
    adr x0, heap_addr
    ldr x0, [x0]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_11
    adr x0, heap_addr
    str x0, [sp, #-16]!
    adr x0, curr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_11
    adr x0, curr
blk_end_11:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_9_10:
    // Closure for func_9
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_9
    ldr x0, [sp], #16
    bl _cons
    b cond_end_8
cond_false_7:
    adr x0, sign_id
cond_end_8:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_12
    b after_func_14_15
func_14:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, addr
    str x0, [sp, #-16]!
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #16
    cmp x0, #4096
    b.hi do_compose_17
do_apply_18:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_19
do_compose_17:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_19:
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_16
    adr x0, addr
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_16
    adr x0, addr
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, tail
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_16
    adr x0, addr
blk_end_16:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_14_15:
    // Closure for func_14
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_14
    ldr x0, [sp], #16
    bl _cons
    b cond_end_13
cond_false_12:
    adr x0, sign_id
cond_end_13:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, head
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_20
    b after_func_22_23
func_22:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_24_25
func_24:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_29_30
func_29:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_31_32
func_31:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_31_32:
    // Closure for func_31
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_31
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_33
do_apply_34:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_35
do_compose_33:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_35:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_36
do_apply_37:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_38
do_compose_36:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_38:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_29_30:
    // Closure for func_29
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_29
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    b.ne xor_true_26
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_28
xor_true_26:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_27
    adr x0, sign_id
    b xor_end_28
xor_false_27:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_24_25:
    // Closure for func_24
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_24
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_22_23:
    // Closure for func_22
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_22
    ldr x0, [sp], #16
    bl _cons
    b cond_end_21
cond_false_20:
    adr x0, sign_id
cond_end_21:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tail
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_39
    b after_func_41_42
func_41:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_43_44
func_43:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_48_49
func_48:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_50_51
func_50:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_50_51:
    // Closure for func_50
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_50
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_52
do_apply_53:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_54
do_compose_52:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_54:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_55
do_apply_56:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_57
do_compose_55:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_57:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_48_49:
    // Closure for func_48
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_48
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
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
    b.ne xor_true_45
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_47
xor_true_45:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_46
    adr x0, sign_id
    b xor_end_47
xor_false_46:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_43_44:
    // Closure for func_43
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_43
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_41_42:
    // Closure for func_41
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_41
    ldr x0, [sp], #16
    bl _cons
    b cond_end_40
cond_false_39:
    adr x0, sign_id
cond_end_40:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, nth
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_58
    b after_func_60_61
func_60:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, index
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_65
    adr x0, sign_id
    b cmp_end_66
cmp_true_65:
cmp_end_66:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_63
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_67
do_apply_68:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_69
do_compose_67:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_69:
    b cond_end_64
cond_false_63:
    adr x0, sign_id
cond_end_64:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_62
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    cmp x0, #4096
    b.hi do_compose_73
do_apply_74:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_75
do_compose_73:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_75:
    str x0, [sp, #-16]!
    adr x0, index
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_76
do_apply_77:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_78
do_compose_76:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_78:
blk_end_62:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_60_61:
    // Closure for func_60
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_60
    ldr x0, [sp], #16
    bl _cons
    b cond_end_59
cond_false_58:
    adr x0, sign_id
cond_end_59:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, factorial
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_79
    b after_func_81_82
func_81:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_86
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
    b.ne blk_end_83
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, factorial
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
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
blk_end_83:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_81_82:
    // Closure for func_81
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_81
    ldr x0, [sp], #16
    bl _cons
    b cond_end_80
cond_false_79:
    adr x0, sign_id
cond_end_80:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, range
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_91
    b after_func_93_94
func_93:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, end
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_98
    adr x0, sign_id
    b cmp_end_99
cmp_true_98:
cmp_end_99:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_96
    mov x0, #0
    b cond_end_97
cond_false_96:
    adr x0, sign_id
cond_end_97:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_95
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_100
do_apply_101:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_102
do_compose_100:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_102:
    str x0, [sp, #-16]!
    adr x0, range
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_103
do_apply_104:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_105
do_compose_103:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_105:
    str x0, [sp, #-16]!
    adr x0, end
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
blk_end_95:
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
    b cond_end_92
cond_false_91:
    adr x0, sign_id
cond_end_92:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_112
    b after_func_114_115
func_114:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
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
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_120
do_apply_121:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_122
do_compose_120:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_122:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_116
    mov x0,     adr x0, _sys_write

    str x0, [sp, #-16]!
    mov x0, #1
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    mov x0, #1
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
blk_end_116:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_114_115:
    // Closure for func_114
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_114
    ldr x0, [sp], #16
    bl _cons
    b cond_end_113
cond_false_112:
    adr x0, sign_id
cond_end_113:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_132
    b after_func_134_135
func_134:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_len_impl_137
len_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_141_142
func_141:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_143_144
func_143:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_145_146
func_145:
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
after_func_145_146:
    // Closure for func_145
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_145
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_143_144:
    // Closure for func_143
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_143
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_147
do_apply_148:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_149
do_compose_147:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_149:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_150
do_apply_151:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_152
do_compose_150:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_152:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_141_142:
    // Closure for func_141
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_141
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_153_154
func_153:
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
after_func_153_154:
    // Closure for func_153
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_153
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_138
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_140
xor_true_138:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_139
    adr x0, sign_id
    b xor_end_140
xor_false_139:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_len_impl_137:
    // Closure for len_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, len_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_136
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_155
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_155
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_155
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_158
    adr x0, sign_id
    b cmp_end_159
cmp_true_158:
cmp_end_159:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_156
    ldr x0, [x29, #-64]
    b cond_end_157
cond_false_156:
    adr x0, sign_id
cond_end_157:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_155
    adr x0, len_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
blk_end_155:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_136
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.ne blk_end_136
    mov x0,     adr x0, _sys_write

    str x0, [sp, #-16]!
    mov x0, #1
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
    ldr x0, [x29, #-32]
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
    adr x0, len
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
blk_end_136:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_134_135:
    // Closure for func_134
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_134
    ldr x0, [sp], #16
    bl _cons
    b cond_end_133
cond_false_132:
    adr x0, sign_id
cond_end_133:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, add
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_178
    b after_func_180_181
func_180:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_180_181:
    // Closure for func_180
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_180
    ldr x0, [sp], #16
    bl _cons
    b cond_end_179
cond_false_178:
    adr x0, sign_id
cond_end_179:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sub
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_182
    b after_func_184_185
func_184:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_184_185:
    // Closure for func_184
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_184
    ldr x0, [sp], #16
    bl _cons
    b cond_end_183
cond_false_182:
    adr x0, sign_id
cond_end_183:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, mul
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_186
    b after_func_188_189
func_188:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_188_189:
    // Closure for func_188
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_188
    ldr x0, [sp], #16
    bl _cons
    b cond_end_187
cond_false_186:
    adr x0, sign_id
cond_end_187:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, div
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_190
    b after_func_192_193
func_192:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_192_193:
    // Closure for func_192
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_192
    ldr x0, [sp], #16
    bl _cons
    b cond_end_191
cond_false_190:
    adr x0, sign_id
cond_end_191:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, mod
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_194
    b after_func_196_197
func_196:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
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
    b cond_end_195
cond_false_194:
    adr x0, sign_id
cond_end_195:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Language
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
    adr x0, Operator
    cmp x0, #4096
    b.hi do_compose_201
do_apply_202:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_203
do_compose_201:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_203:
    str x0, [sp, #-16]!
    adr x0, Table
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
    str x0, [sp, #-16]!
    adr x0, operator
    str x0, [sp, #-16]!
    adr x0, .
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
    adr x0, sn
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Wraps
    str x0, [sp, #-16]!
    adr x0, standard
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
    str x0, [sp, #-16]!
    adr x0, operators
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
    str x0, [sp, #-16]!
    adr x0, as
    cmp x0, #4096
    b.hi do_compose_222
do_apply_223:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_224
do_compose_222:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_224:
    str x0, [sp, #-16]!
    adr x0, first
    str x0, [sp, #-16]!
    adr x0, class
    ldr x1, [sp], #16
    sub x0, x1, x0
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
    str x0, [sp, #-16]!
    adr x0, functions
    cmp x0, #4096
    b.hi do_compose_228
do_apply_229:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_230
do_compose_228:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_230:
    str x0, [sp, #-16]!
    adr x0, using
    cmp x0, #4096
    b.hi do_compose_231
do_apply_232:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_233
do_compose_231:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_233:
    str x0, [sp, #-16]!
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, syntax
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
    adr x0, .
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, A_Operator_Table
    str x0, [sp, #-16]!
    adr x0, .
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
    adr x0, md
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
    adr x1, Reference
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_248_249
func_248:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_253_254
func_253:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_255_256
func_255:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_257_258
func_257:
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
after_func_257_258:
    // Closure for func_257
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_257
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_265_266
func_265:
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
after_func_265_266:
    // Closure for func_265
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_265
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_250
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_252
xor_true_250:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_251
    adr x0, sign_id
    b xor_end_252
xor_false_251:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_248_249:
    // Closure for func_248
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_248
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_246
    b after_func_267_268
func_267:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_269_270
func_269:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_274_275
func_274:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_276_277
func_276:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_278_279
func_278:
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
after_func_278_279:
    // Closure for func_278
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_278
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    b after_func_286_287
func_286:
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
after_func_286_287:
    // Closure for func_286
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_286
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_271
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_273
xor_true_271:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_272
    adr x0, sign_id
    b xor_end_273
xor_false_272:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_269_270:
    // Closure for func_269
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_269
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_267_268:
    // Closure for func_267
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_267
    ldr x0, [sp], #16
    bl _cons
    b cond_end_247
cond_false_246:
    adr x0, sign_id
cond_end_247:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_293_294
func_293:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_298_299
func_298:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_300_301
func_300:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_302_303
func_302:
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
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_302_303:
    // Closure for func_302
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_302
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_300_301:
    // Closure for func_300
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_300
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_298_299:
    // Closure for func_298
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_298
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_310_311
func_310:
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
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_310_311:
    // Closure for func_310
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_310
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_295
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_297
xor_true_295:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_296
    adr x0, sign_id
    b xor_end_297
xor_false_296:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_291
    b after_func_312_313
func_312:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_314_315
func_314:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_319_320
func_319:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_321_322
func_321:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_323_324
func_323:
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
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_323_324:
    // Closure for func_323
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_323
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_325
do_apply_326:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_327
do_compose_325:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_327:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_319_320:
    // Closure for func_319
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_319
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_331_332
func_331:
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
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_331_332:
    // Closure for func_331
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_331
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_316
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_318
xor_true_316:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_317
    adr x0, sign_id
    b xor_end_318
xor_false_317:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_314_315:
    // Closure for func_314
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_314
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_312_313:
    // Closure for func_312
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_312
    ldr x0, [sp], #16
    bl _cons
    b cond_end_292
cond_false_291:
    adr x0, sign_id
cond_end_292:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_338_339
func_338:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
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
    b after_func_347_348
func_347:
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
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_347_348:
    // Closure for func_347
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_347
    ldr x0, [sp], #16
    bl _cons
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
    b.hi do_compose_349
do_apply_350:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_351
do_compose_349:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_351:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_352
do_apply_353:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_354
do_compose_352:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_354:
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
    b after_func_355_356
func_355:
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
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_355_356:
    // Closure for func_355
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_355
    ldr x0, [sp], #16
    bl _cons
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_338_339:
    // Closure for func_338
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_338
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_336
    b after_func_357_358
func_357:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_359_360
func_359:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_364_365
func_364:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_366_367
func_366:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_368_369
func_368:
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
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_368_369:
    // Closure for func_368
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_368
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_366_367:
    // Closure for func_366
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_366
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_370
do_apply_371:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_372
do_compose_370:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_372:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_364_365:
    // Closure for func_364
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_364
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_376_377
func_376:
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
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_376_377:
    // Closure for func_376
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_376
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_361
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_363
xor_true_361:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_362
    adr x0, sign_id
    b xor_end_363
xor_false_362:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_359_360:
    // Closure for func_359
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_359
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_357_358:
    // Closure for func_357
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_357
    ldr x0, [sp], #16
    bl _cons
    b cond_end_337
cond_false_336:
    adr x0, sign_id
cond_end_337:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_383_384
func_383:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_388_389
func_388:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_390_391
func_390:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_392_393
func_392:
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
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_392_393:
    // Closure for func_392
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_392
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    b after_func_400_401
func_400:
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
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_400_401:
    // Closure for func_400
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_400
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_385
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_387
xor_true_385:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_386
    adr x0, sign_id
    b xor_end_387
xor_false_386:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_383_384:
    // Closure for func_383
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_383
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_381
    b after_func_402_403
func_402:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_404_405
func_404:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_409_410
func_409:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_411_412
func_411:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_413_414
func_413:
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
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_413_414:
    // Closure for func_413
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_413
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    b after_func_421_422
func_421:
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
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_421_422:
    // Closure for func_421
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_421
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_406
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_408
xor_true_406:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_407
    adr x0, sign_id
    b xor_end_408
xor_false_407:
    mov x0, x1
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
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
after_func_402_403:
    // Closure for func_402
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_402
    ldr x0, [sp], #16
    bl _cons
    b cond_end_382
cond_false_381:
    adr x0, sign_id
cond_end_382:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_428_429
func_428:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_433_434
func_433:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_435_436
func_435:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_437_438
func_437:
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
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_437_438:
    // Closure for func_437
    adr x0, sign_id
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
    adr x1, func_435
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_439
do_apply_440:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_441
do_compose_439:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_441:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_442
do_apply_443:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_444
do_compose_442:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_444:
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
    b after_func_445_446
func_445:
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
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_445_446:
    // Closure for func_445
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_445
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_430
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_432
xor_true_430:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_431
    adr x0, sign_id
    b xor_end_432
xor_false_431:
    mov x0, x1
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
    b.eq cond_false_426
    b after_func_447_448
func_447:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_449_450
func_449:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_454_455
func_454:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_456_457
func_456:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_458_459
func_458:
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
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_458_459:
    // Closure for func_458
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_458
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_456_457:
    // Closure for func_456
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_456
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_463
do_apply_464:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_465
do_compose_463:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_465:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_454_455:
    // Closure for func_454
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_454
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_466_467
func_466:
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
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_466_467:
    // Closure for func_466
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_466
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_451
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_453
xor_true_451:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_452
    adr x0, sign_id
    b xor_end_453
xor_false_452:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_449_450:
    // Closure for func_449
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_449
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_447_448:
    // Closure for func_447
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_447
    ldr x0, [sp], #16
    bl _cons
    b cond_end_427
cond_false_426:
    adr x0, sign_id
cond_end_427:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_473_474
func_473:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_478_479
func_478:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_480_481
func_480:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_482_483
func_482:
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
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_482_483:
    // Closure for func_482
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_482
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_480_481:
    // Closure for func_480
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_480
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_478_479:
    // Closure for func_478
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_478
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_490_491
func_490:
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
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_490_491:
    // Closure for func_490
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_490
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_475
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_477
xor_true_475:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_476
    adr x0, sign_id
    b xor_end_477
xor_false_476:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_473_474:
    // Closure for func_473
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_473
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_471
    b after_func_492_493
func_492:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_494_495
func_494:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_499_500
func_499:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_501_502
func_501:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_503_504
func_503:
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
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_503_504:
    // Closure for func_503
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_503
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_501_502:
    // Closure for func_501
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_501
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _pow
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_496
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_498
xor_true_496:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_497
    adr x0, sign_id
    b xor_end_498
xor_false_497:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_494_495:
    // Closure for func_494
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_494
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
after_func_492_493:
    // Closure for func_492
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_492
    ldr x0, [sp], #16
    bl _cons
    b cond_end_472
cond_false_471:
    adr x0, sign_id
cond_end_472:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_518_519
func_518:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_523_524
func_523:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_529
    adr x0, sign_id
    b cmp_end_530
cmp_true_529:
cmp_end_530:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_527_528:
    // Closure for func_527
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    str x0, [sp, #-16]!
    b after_func_537_538
func_537:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_539
    adr x0, sign_id
    b cmp_end_540
cmp_true_539:
cmp_end_540:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_537_538:
    // Closure for func_537
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_537
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_520
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_522
xor_true_520:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_521
    adr x0, sign_id
    b xor_end_522
xor_false_521:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_518_519:
    // Closure for func_518
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_518
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_516
    b after_func_541_542
func_541:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_543_544
func_543:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_548_549
func_548:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_550_551
func_550:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_552_553
func_552:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_554
    adr x0, sign_id
    b cmp_end_555
cmp_true_554:
cmp_end_555:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_552_553:
    // Closure for func_552
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_552
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_548_549:
    // Closure for func_548
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_548
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_562_563
func_562:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_564
    adr x0, sign_id
    b cmp_end_565
cmp_true_564:
cmp_end_565:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_562_563:
    // Closure for func_562
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_562
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_545
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_547
xor_true_545:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_546
    adr x0, sign_id
    b xor_end_547
xor_false_546:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_543_544:
    // Closure for func_543
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_543
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    cmp x0, #4096
    b.hi do_compose_566
do_apply_567:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_568
do_compose_566:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_568:
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
    b cond_end_517
cond_false_516:
    adr x0, sign_id
cond_end_517:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_571_572
func_571:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_576_577
func_576:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_578_579
func_578:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_580_581
func_580:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_582
    adr x0, sign_id
    b cmp_end_583
cmp_true_582:
cmp_end_583:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_580_581:
    // Closure for func_580
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_580
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_578_579:
    // Closure for func_578
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_578
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_587
do_apply_588:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_589
do_compose_587:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_589:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_576_577:
    // Closure for func_576
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_576
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_590_591
func_590:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_592
    adr x0, sign_id
    b cmp_end_593
cmp_true_592:
cmp_end_593:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_590_591:
    // Closure for func_590
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_590
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_573
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_575
xor_true_573:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_574
    adr x0, sign_id
    b xor_end_575
xor_false_574:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_571_572:
    // Closure for func_571
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_571
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_569
    b after_func_594_595
func_594:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_596_597
func_596:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_601_602
func_601:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_603_604
func_603:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_605_606
func_605:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_607
    adr x0, sign_id
    b cmp_end_608
cmp_true_607:
cmp_end_608:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_605_606:
    // Closure for func_605
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_605
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_603_604:
    // Closure for func_603
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_603
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_615_616
func_615:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_617
    adr x0, sign_id
    b cmp_end_618
cmp_true_617:
cmp_end_618:
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
    adr x1, func_615
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_598
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_600
xor_true_598:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_599
    adr x0, sign_id
    b xor_end_600
xor_false_599:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_596_597:
    // Closure for func_596
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_596
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    b cond_end_570
cond_false_569:
    adr x0, sign_id
cond_end_570:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_624_625
func_624:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_629_630
func_629:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_631_632
func_631:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_633_634
func_633:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_635
    adr x0, sign_id
    b cmp_end_636
cmp_true_635:
cmp_end_636:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_633_634:
    // Closure for func_633
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_633
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_631_632:
    // Closure for func_631
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_631
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_629_630:
    // Closure for func_629
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_629
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_643_644
func_643:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_645
    adr x0, sign_id
    b cmp_end_646
cmp_true_645:
cmp_end_646:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_643_644:
    // Closure for func_643
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_643
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_626
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_628
xor_true_626:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_627
    adr x0, sign_id
    b xor_end_628
xor_false_627:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_624_625:
    // Closure for func_624
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_624
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_622
    b after_func_647_648
func_647:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_649_650
func_649:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_654_655
func_654:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_656_657
func_656:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_658_659
func_658:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_660
    adr x0, sign_id
    b cmp_end_661
cmp_true_660:
cmp_end_661:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_658_659:
    // Closure for func_658
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_658
    ldr x0, [sp], #16
    bl _cons
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
after_func_654_655:
    // Closure for func_654
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_654
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_668_669
func_668:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_670
    adr x0, sign_id
    b cmp_end_671
cmp_true_670:
cmp_end_671:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_668_669:
    // Closure for func_668
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_668
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_651
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_653
xor_true_651:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_652
    adr x0, sign_id
    b xor_end_653
xor_false_652:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_649_650:
    // Closure for func_649
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_649
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    b cond_end_623
cond_false_622:
    adr x0, sign_id
cond_end_623:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_677_678
func_677:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_682_683
func_682:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_684_685
func_684:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_686_687
func_686:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_688
    adr x0, sign_id
    b cmp_end_689
cmp_true_688:
cmp_end_689:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_686_687:
    // Closure for func_686
    adr x0, sign_id
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
    adr x1, func_684
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_682_683:
    // Closure for func_682
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_682
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_696_697
func_696:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_698
    adr x0, sign_id
    b cmp_end_699
cmp_true_698:
cmp_end_699:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_696_697:
    // Closure for func_696
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_696
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_679
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_681
xor_true_679:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_680
    adr x0, sign_id
    b xor_end_681
xor_false_680:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_675
    b after_func_700_701
func_700:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_702_703
func_702:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_707_708
func_707:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_709_710
func_709:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_711_712
func_711:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_713
    adr x0, sign_id
    b cmp_end_714
cmp_true_713:
cmp_end_714:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_711_712:
    // Closure for func_711
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_711
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_709_710:
    // Closure for func_709
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_709
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_715
do_apply_716:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_717
do_compose_715:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_717:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_718
do_apply_719:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_720
do_compose_718:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_720:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_707_708:
    // Closure for func_707
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_707
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_721_722
func_721:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_723
    adr x0, sign_id
    b cmp_end_724
cmp_true_723:
cmp_end_724:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_721_722:
    // Closure for func_721
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_721
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_704
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_706
xor_true_704:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_705
    adr x0, sign_id
    b xor_end_706
xor_false_705:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_702_703:
    // Closure for func_702
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_702
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_700_701:
    // Closure for func_700
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_700
    ldr x0, [sp], #16
    bl _cons
    b cond_end_676
cond_false_675:
    adr x0, sign_id
cond_end_676:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b after_func_739_740
func_739:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_741
    adr x0, sign_id
    b cmp_end_742
cmp_true_741:
cmp_end_742:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_739_740:
    // Closure for func_739
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_743
do_apply_744:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_745
do_compose_743:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_745:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_746
do_apply_747:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_748
do_compose_746:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_748:
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
    b after_func_749_750
func_749:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_751
    adr x0, sign_id
    b cmp_end_752
cmp_true_751:
cmp_end_752:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_749_750:
    // Closure for func_749
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_749
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_728
    b after_func_753_754
func_753:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_755_756
func_755:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_760_761
func_760:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_762_763
func_762:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_764_765
func_764:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_766
    adr x0, sign_id
    b cmp_end_767
cmp_true_766:
cmp_end_767:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_764_765:
    // Closure for func_764
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_764
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_762_763:
    // Closure for func_762
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_762
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_768
do_apply_769:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_770
do_compose_768:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_770:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_771
do_apply_772:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_773
do_compose_771:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_773:
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
    b after_func_774_775
func_774:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_776
    adr x0, sign_id
    b cmp_end_777
cmp_true_776:
cmp_end_777:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_774_775:
    // Closure for func_774
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_774
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_757
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_759
xor_true_757:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_758
    adr x0, sign_id
    b xor_end_759
xor_false_758:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_755_756:
    // Closure for func_755
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_755
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_753_754:
    // Closure for func_753
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_753
    ldr x0, [sp], #16
    bl _cons
    b cond_end_729
cond_false_728:
    adr x0, sign_id
cond_end_729:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_783_784
func_783:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_788_789
func_788:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_790_791
func_790:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_792_793
func_792:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_792_793:
    // Closure for func_792
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_792
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_794
do_apply_795:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_796
do_compose_794:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_796:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_797
do_apply_798:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_799
do_compose_797:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_799:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_788_789:
    // Closure for func_788
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_788
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_785
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_787
xor_true_785:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_786
    adr x0, sign_id
    b xor_end_787
xor_false_786:
    mov x0, x1
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
    b.eq cond_false_781
    b after_func_802_803
func_802:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_804_805
func_804:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_809_810
func_809:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_813_814:
    // Closure for func_813
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_821_822
func_821:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_821_822:
    // Closure for func_821
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_821
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_806
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_808
xor_true_806:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_807
    adr x0, sign_id
    b xor_end_808
xor_false_807:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_804_805:
    // Closure for func_804
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_804
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    cmp x0, #4096
    b.hi do_compose_823
do_apply_824:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_825
do_compose_823:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_825:
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
    b cond_end_782
cond_false_781:
    adr x0, sign_id
cond_end_782:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_828_829
func_828:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_833_834
func_833:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_835_836
func_835:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_837_838
func_837:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_839
    adr x0, sign_id
    b cmp_end_840
cmp_true_839:
cmp_end_840:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_837_838:
    // Closure for func_837
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_837
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_835_836:
    // Closure for func_835
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_835
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_841
do_apply_842:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_843
do_compose_841:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_843:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_844
do_apply_845:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_846
do_compose_844:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_846:
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
    str x0, [sp, #-16]!
    b after_func_847_848
func_847:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_849
    adr x0, sign_id
    b cmp_end_850
cmp_true_849:
cmp_end_850:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_847_848:
    // Closure for func_847
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_847
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_830
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_832
xor_true_830:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_831
    adr x0, sign_id
    b xor_end_832
xor_false_831:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_828_829:
    // Closure for func_828
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_828
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_826
    b after_func_851_852
func_851:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    b after_func_853_854
func_853:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_858_859
func_858:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_860_861
func_860:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_862_863
func_862:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_864
    adr x0, sign_id
    b cmp_end_865
cmp_true_864:
cmp_end_865:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_862_863:
    // Closure for func_862
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_862
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_869
do_apply_870:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_871
do_compose_869:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_871:
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
    str x0, [sp, #-16]!
    b after_func_872_873
func_872:
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
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_874
    adr x0, sign_id
    b cmp_end_875
cmp_true_874:
cmp_end_875:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_872_873:
    // Closure for func_872
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_872
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_855
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_857
xor_true_855:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_856
    adr x0, sign_id
    b xor_end_857
xor_false_856:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_853_854:
    // Closure for func_853
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_853
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, x
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    cmp x0, #4096
    b.hi do_compose_876
do_apply_877:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_878
do_compose_876:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_878:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_851_852:
    // Closure for func_851
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_851
    ldr x0, [sp], #16
    bl _cons
    b cond_end_827
cond_false_826:
    adr x0, sign_id
cond_end_827:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.eq not_true_881
    adr x0, sign_id
    b not_end_882
not_true_881:
    mov x0, #0
not_end_882:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_879
    b after_func_883_884
func_883:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq not_true_885
    adr x0, sign_id
    b not_end_886
not_true_885:
    mov x0, #0
not_end_886:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_883_884:
    // Closure for func_883
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_883
    ldr x0, [sp], #16
    bl _cons
    b cond_end_880
cond_false_879:
    adr x0, sign_id
cond_end_880:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    mvn x0, x0
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_887
    b after_func_889_890
func_889:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mvn x0, x0
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
    b cond_end_888
cond_false_887:
    adr x0, sign_id
cond_end_888:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_893_894
func_893:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_898_899
func_898:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_900_901
func_900:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_902_903
func_902:
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
    mov x1, x0
    ldr x0, [sp], #16
    orr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_902_903:
    // Closure for func_902
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_902
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_900_901:
    // Closure for func_900
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_900
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_898_899:
    // Closure for func_898
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_898
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_910_911
func_910:
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
    mov x1, x0
    ldr x0, [sp], #16
    orr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_910_911:
    // Closure for func_910
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_910
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_895
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_897
xor_true_895:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_896
    adr x0, sign_id
    b xor_end_897
xor_false_896:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_893_894:
    // Closure for func_893
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_893
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_891
    b after_func_912_913
func_912:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    orr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_912_913:
    // Closure for func_912
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_912
    ldr x0, [sp], #16
    bl _cons
    b cond_end_892
cond_false_891:
    adr x0, sign_id
cond_end_892:
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
    b after_func_925_926
func_925:
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
    and x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_925_926:
    // Closure for func_925
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_925
    ldr x0, [sp], #16
    bl _cons
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
    b after_func_933_934
func_933:
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
    and x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_933_934:
    // Closure for func_933
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_933
    ldr x0, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_914
    b after_func_935_936
func_935:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    and x0, x1, x0
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
    b cond_end_915
cond_false_914:
    adr x0, sign_id
cond_end_915:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_939_940
func_939:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_944_945
func_944:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_946_947
func_946:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ;
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_948
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_950
xor_true_948:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_949
    adr x0, sign_id
    b xor_end_950
xor_false_949:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_946_947:
    // Closure for func_946
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_946
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_951
do_apply_952:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_953
do_compose_951:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_953:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_944_945:
    // Closure for func_944
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_944
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ;
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_957
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_959
xor_true_957:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_958
    adr x0, sign_id
    b xor_end_959
xor_false_958:
    mov x0, x1
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_941
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_943
xor_true_941:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_942
    adr x0, sign_id
    b xor_end_943
xor_false_942:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_937
    b after_func_960_961
func_960:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ;
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_962
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_964
xor_true_962:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_963
    adr x0, sign_id
    b xor_end_964
xor_false_963:
    mov x0, x1
    str x0, [sp, #-16]!
    adr x0, y
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_960_961:
    // Closure for func_960
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_960
    ldr x0, [sp], #16
    bl _cons
    b cond_end_938
cond_false_937:
    adr x0, sign_id
cond_end_938:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_970_971
func_970:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_975_976
func_975:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_977_978
func_977:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_979_980
func_979:
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
    lsl x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_979_980:
    // Closure for func_979
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_979
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_977_978:
    // Closure for func_977
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_977
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_975_976:
    // Closure for func_975
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_975
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_987_988
func_987:
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
    lsl x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_987_988:
    // Closure for func_987
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_987
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_972
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_974
xor_true_972:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_973
    adr x0, sign_id
    b xor_end_974
xor_false_973:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_968
    b after_func_989_990
func_989:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    lsl x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_989_990:
    // Closure for func_989
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_989
    ldr x0, [sp], #16
    bl _cons
    b cond_end_969
cond_false_968:
    adr x0, sign_id
cond_end_969:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_993_994
func_993:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_998_999
func_998:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1000_1001
func_1000:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1002_1003
func_1002:
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
    asr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1002_1003:
    // Closure for func_1002
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1002
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1000_1001:
    // Closure for func_1000
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1000
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_998_999:
    // Closure for func_998
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_998
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1010_1011
func_1010:
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
    asr x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1010_1011:
    // Closure for func_1010
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1010
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_995
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_997
xor_true_995:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_996
    adr x0, sign_id
    b xor_end_997
xor_false_996:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_993_994:
    // Closure for func_993
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_993
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_991
    b after_func_1012_1013
func_1012:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    asr x0, x1, x0
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
    b cond_end_992
cond_false_991:
    adr x0, sign_id
cond_end_992:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1016_1017
func_1016:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1021_1022
func_1021:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1023_1024
func_1023:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1025_1026
func_1025:
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
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1025_1026:
    // Closure for func_1025
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1025
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1023_1024:
    // Closure for func_1023
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1023
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1021_1022:
    // Closure for func_1021
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1021
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1033_1034
func_1033:
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
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1033_1034:
    // Closure for func_1033
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1033
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1018
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1020
xor_true_1018:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1019
    adr x0, sign_id
    b xor_end_1020
xor_false_1019:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1016_1017:
    // Closure for func_1016
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1016
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1014
    b after_func_1035_1036
func_1035:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, e
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1035_1036:
    // Closure for func_1035
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1035
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1015
cond_false_1014:
    adr x0, sign_id
cond_end_1015:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1039_1040
func_1039:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1044_1045
func_1044:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1046_1047
func_1046:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1046_1047:
    // Closure for func_1046
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1046
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1044_1045:
    // Closure for func_1044
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1044
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1041
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1043
xor_true_1041:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1042
    adr x0, sign_id
    b xor_end_1043
xor_false_1042:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1039_1040:
    // Closure for func_1039
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1039
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1037
    b after_func_1054_1055
func_1054:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    b cond_end_1038
cond_false_1037:
    adr x0, sign_id
cond_end_1038:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1058_1059
func_1058:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1063_1064
func_1063:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1065_1066
func_1065:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1065_1066:
    // Closure for func_1065
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1065
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1067
do_apply_1068:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1069
do_compose_1067:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1069:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1070
do_apply_1071:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1072
do_compose_1070:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1072:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1063_1064:
    // Closure for func_1063
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1063
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    bl _range
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1060
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1062
xor_true_1060:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1061
    adr x0, sign_id
    b xor_end_1062
xor_false_1061:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1058_1059:
    // Closure for func_1058
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1058
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1056
    b after_func_1073_1074
func_1073:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _range
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1073_1074:
    // Closure for func_1073
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1073
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1057
cond_false_1056:
    adr x0, sign_id
cond_end_1057:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1077_1078
func_1077:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1082_1083
func_1082:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1084_1085
func_1084:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1086_1087
func_1086:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1086_1087:
    // Closure for func_1086
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1086
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1084_1085:
    // Closure for func_1084
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1084
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1082_1083:
    // Closure for func_1082
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1082
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1094_1095
func_1094:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1094_1095:
    // Closure for func_1094
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1094
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1079
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1081
xor_true_1079:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1080
    adr x0, sign_id
    b xor_end_1081
xor_false_1080:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1077_1078:
    // Closure for func_1077
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1077
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1075
    b after_func_1096_1097
func_1096:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, e
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1096_1097:
    // Closure for func_1096
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1096
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1076
cond_false_1075:
    adr x0, sign_id
cond_end_1076:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1100_1101
func_1100:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1105_1106
func_1105:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1107_1108
func_1107:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1109_1110
func_1109:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1109_1110:
    // Closure for func_1109
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1109
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_1111
do_apply_1112:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1113
do_compose_1111:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1113:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1114
do_apply_1115:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1116
do_compose_1114:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1116:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1105_1106:
    // Closure for func_1105
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1105
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1117_1118
func_1117:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1117_1118:
    // Closure for func_1117
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1117
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1102
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1104
xor_true_1102:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1103
    adr x0, sign_id
    b xor_end_1104
xor_false_1103:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1100_1101:
    // Closure for func_1100
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1100
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1098
    b after_func_1119_1120
func_1119:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, e
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1119_1120:
    // Closure for func_1119
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1119
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1099
cond_false_1098:
    adr x0, sign_id
cond_end_1099:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1123_1124
func_1123:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1128_1129
func_1128:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1130_1131
func_1130:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1132_1133
func_1132:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1132_1133:
    // Closure for func_1132
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1132
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1130_1131:
    // Closure for func_1130
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1130
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1134
do_apply_1135:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1136
do_compose_1134:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1136:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1137
do_apply_1138:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1139
do_compose_1137:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1139:
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
    str x0, [sp, #-16]!
    b after_func_1140_1141
func_1140:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1140_1141:
    // Closure for func_1140
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1140
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1125
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1127
xor_true_1125:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1126
    adr x0, sign_id
    b xor_end_1127
xor_false_1126:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1123_1124:
    // Closure for func_1123
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1123
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1121
    b after_func_1142_1143
func_1142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, e
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1142_1143:
    // Closure for func_1142
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1142
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1122
cond_false_1121:
    adr x0, sign_id
cond_end_1122:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1146_1147
func_1146:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1151_1152
func_1151:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1153_1154
func_1153:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1155_1156
func_1155:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1155_1156:
    // Closure for func_1155
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1155
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1153_1154:
    // Closure for func_1153
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1153
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1157
do_apply_1158:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1159
do_compose_1157:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1159:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1160
do_apply_1161:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1162
do_compose_1160:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1162:
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
    b after_func_1163_1164
func_1163:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1163_1164:
    // Closure for func_1163
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1163
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1148
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1150
xor_true_1148:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1149
    adr x0, sign_id
    b xor_end_1150
xor_false_1149:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1146_1147:
    // Closure for func_1146
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1146
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1144
    b after_func_1165_1166
func_1165:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, e
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1165_1166:
    // Closure for func_1165
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1165
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1145
cond_false_1144:
    adr x0, sign_id
cond_end_1145:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1169_1170
func_1169:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1174_1175
func_1174:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1176_1177
func_1176:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1178_1179
func_1178:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1178_1179:
    // Closure for func_1178
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1178
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1176_1177:
    // Closure for func_1176
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1176
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1180
do_apply_1181:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1182
do_compose_1180:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1182:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1174_1175:
    // Closure for func_1174
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1174
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1186_1187
func_1186:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1186_1187:
    // Closure for func_1186
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1186
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1171
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1173
xor_true_1171:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1172
    adr x0, sign_id
    b xor_end_1173
xor_false_1172:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1169_1170:
    // Closure for func_1169
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1169
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1167
    b after_func_1188_1189
func_1188:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, e
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1188_1189:
    // Closure for func_1188
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1188
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1168
cond_false_1167:
    adr x0, sign_id
cond_end_1168:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1192_1193
func_1192:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1197_1198
func_1197:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1199_1200
func_1199:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1201_1202
func_1201:
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
after_func_1201_1202:
    // Closure for func_1201
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1201
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1199_1200:
    // Closure for func_1199
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1199
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_1209_1210
func_1209:
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
after_func_1209_1210:
    // Closure for func_1209
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1209
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1194
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1196
xor_true_1194:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1195
    adr x0, sign_id
    b xor_end_1196
xor_false_1195:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1192_1193:
    // Closure for func_1192
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1192
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1190
    b after_func_1211_1212
func_1211:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1211_1212:
    // Closure for func_1211
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1211
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1191
cond_false_1190:
    adr x0, sign_id
cond_end_1191:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1215_1216
func_1215:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1220_1221
func_1220:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1222_1223
func_1222:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1224_1225
func_1224:
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
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1224_1225:
    // Closure for func_1224
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1224
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1222_1223:
    // Closure for func_1222
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1222
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1220_1221:
    // Closure for func_1220
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1220
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1232_1233
func_1232:
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
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1232_1233:
    // Closure for func_1232
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1232
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1217
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1219
xor_true_1217:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1218
    adr x0, sign_id
    b xor_end_1219
xor_false_1218:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1215_1216:
    // Closure for func_1215
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1215
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1213
    b after_func_1234_1235
func_1234:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, key
    ldr x1, [sp], #16
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1234_1235:
    // Closure for func_1234
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1234
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1214
cond_false_1213:
    adr x0, sign_id
cond_end_1214:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1238_1239
func_1238:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1243_1244
func_1243:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1245_1246
func_1245:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1247_1248
func_1247:
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
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1247_1248:
    // Closure for func_1247
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1247
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1245_1246:
    // Closure for func_1245
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1245
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1249
do_apply_1250:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1251
do_compose_1249:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1251:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1252
do_apply_1253:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1254
do_compose_1252:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1254:
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
    str x0, [sp, #-16]!
    b after_func_1255_1256
func_1255:
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
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1255_1256:
    // Closure for func_1255
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1255
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1240
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1242
xor_true_1240:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1241
    adr x0, sign_id
    b xor_end_1242
xor_false_1241:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1238_1239:
    // Closure for func_1238
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1238
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1236
    b after_func_1257_1258
func_1257:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, key
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1257_1258:
    // Closure for func_1257
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1257
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1237
cond_false_1236:
    adr x0, sign_id
cond_end_1237:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1261_1262
func_1261:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1266_1267
func_1266:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1268_1269
func_1268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1268_1269:
    // Closure for func_1268
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1268
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1270
do_apply_1271:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1272
do_compose_1270:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1272:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1273
do_apply_1274:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1275
do_compose_1273:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1275:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1266_1267:
    // Closure for func_1266
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1266
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b.ne xor_true_1263
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1265
xor_true_1263:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1264
    adr x0, sign_id
    b xor_end_1265
xor_false_1264:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1261_1262:
    // Closure for func_1261
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1261
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1259
    b after_func_1276_1277
func_1276:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1276_1277:
    // Closure for func_1276
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1276
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1260
cond_false_1259:
    adr x0, sign_id
cond_end_1260:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1280_1281
func_1280:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1285_1286
func_1285:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1287_1288
func_1287:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1287_1288:
    // Closure for func_1287
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1287
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1289
do_apply_1290:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1291
do_compose_1289:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1291:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1292
do_apply_1293:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1294
do_compose_1292:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1294:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1285_1286:
    // Closure for func_1285
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1285
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    b.ne xor_true_1282
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1284
xor_true_1282:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1283
    adr x0, sign_id
    b xor_end_1284
xor_false_1283:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1280_1281:
    // Closure for func_1280
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1280
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1278
    b after_func_1295_1296
func_1295:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1295_1296:
    // Closure for func_1295
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1295
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1279
cond_false_1278:
    adr x0, sign_id
cond_end_1279:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1297
    b after_func_1299_1300
func_1299:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    add x0, x29, #-32
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1299_1300:
    // Closure for func_1299
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1299
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1298
cond_false_1297:
    adr x0, sign_id
cond_end_1298:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1303_1304
func_1303:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1308_1309
func_1308:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1310_1311
func_1310:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1312_1313
func_1312:
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
    str x0, [x1]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1312_1313:
    // Closure for func_1312
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1312
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1310_1311:
    // Closure for func_1310
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1310
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1314
do_apply_1315:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1316
do_compose_1314:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1316:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1317
do_apply_1318:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1319
do_compose_1317:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1319:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1308_1309:
    // Closure for func_1308
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1308
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1320_1321
func_1320:
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
    str x0, [x1]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1320_1321:
    // Closure for func_1320
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1320
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1305
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1307
xor_true_1305:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1306
    adr x0, sign_id
    b xor_end_1307
xor_false_1306:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1303_1304:
    // Closure for func_1303
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1303
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1301
    b after_func_1322_1323
func_1322:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1322_1323:
    // Closure for func_1322
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1322
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, val
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_1302
cond_false_1301:
    adr x0, sign_id
cond_end_1302:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1324
do_apply_1325:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1326
do_compose_1324:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1326:
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
heap_start: .quad 0
heap_end: .quad 0
heap_addr: .quad 0
Reference: .quad 0


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

