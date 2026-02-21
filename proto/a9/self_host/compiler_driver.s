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

    adr x0, sys_brk
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
    adr x0, sys_brk
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_17
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #16
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
    b cond_end_18
cond_false_17:
    adr x0, sign_id
cond_end_18:
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
    b.eq cond_false_22
    b after_func_24_25
func_24:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_26_27
func_26:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_31_32
func_31:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_33_34
func_33:
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
after_func_33_34:
    // Closure for func_33
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_33
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_38
do_apply_39:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_40
do_compose_38:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_40:
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
    b.ne xor_true_28
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_30
xor_true_28:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_29
    adr x0, sign_id
    b xor_end_30
xor_false_29:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_26_27:
    // Closure for func_26
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_26
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_24_25:
    // Closure for func_24
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_24
    ldr x0, [sp], #16
    bl _cons
    b cond_end_23
cond_false_22:
    adr x0, sign_id
cond_end_23:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tail
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_41
    b after_func_43_44
func_43:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    b after_func_50_51
func_50:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_52_53
func_52:
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
after_func_52_53:
    // Closure for func_52
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_52
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_54
do_apply_55:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_56
do_compose_54:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_56:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_57
do_apply_58:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_59
do_compose_57:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_59:
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
    b.ne xor_true_47
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_49
xor_true_47:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_48
    adr x0, sign_id
    b xor_end_49
xor_false_48:
    mov x0, x1
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_43_44:
    // Closure for func_43
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_43
    ldr x0, [sp], #16
    bl _cons
    b cond_end_42
cond_false_41:
    adr x0, sign_id
cond_end_42:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, nth
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_60
    b after_func_62_63
func_62:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, index
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_67
    adr x0, sign_id
    b cmp_end_68
cmp_true_67:
cmp_end_68:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_65
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_69
do_apply_70:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_71
do_compose_69:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_71:
    b cond_end_66
cond_false_65:
    adr x0, sign_id
cond_end_66:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_64
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_72
do_apply_73:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_74
do_compose_72:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_74:
    cmp x0, #4096
    b.hi do_compose_75
do_apply_76:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_77
do_compose_75:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_77:
    str x0, [sp, #-16]!
    adr x0, index
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_78
do_apply_79:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_80
do_compose_78:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_80:
blk_end_64:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_62_63:
    // Closure for func_62
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_62
    ldr x0, [sp], #16
    bl _cons
    b cond_end_61
cond_false_60:
    adr x0, sign_id
cond_end_61:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, factorial
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_81
    b after_func_83_84
func_83:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_88
    adr x0, sign_id
    b cmp_end_89
cmp_true_88:
cmp_end_89:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_86
    mov x0, #1
    b cond_end_87
cond_false_86:
    adr x0, sign_id
cond_end_87:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_85
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
    b.hi do_compose_90
do_apply_91:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_92
do_compose_90:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_92:
blk_end_85:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_83_84:
    // Closure for func_83
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_83
    ldr x0, [sp], #16
    bl _cons
    b cond_end_82
cond_false_81:
    adr x0, sign_id
cond_end_82:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, range
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_93
    b after_func_95_96
func_95:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, end
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_100
    adr x0, sign_id
    b cmp_end_101
cmp_true_100:
cmp_end_101:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_98
    mov x0, #0
    b cond_end_99
cond_false_98:
    adr x0, sign_id
cond_end_99:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_97
    adr x0, cons
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
    str x0, [sp, #-16]!
    adr x0, range
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_105
do_apply_106:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_107
do_compose_105:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_107:
    str x0, [sp, #-16]!
    adr x0, end
    cmp x0, #4096
    b.hi do_compose_108
do_apply_109:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_110
do_compose_108:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_110:
    cmp x0, #4096
    b.hi do_compose_111
do_apply_112:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_113
do_compose_111:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_113:
blk_end_97:
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
    b cond_end_94
cond_false_93:
    adr x0, sign_id
cond_end_94:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_114
    b after_func_116_117
func_116:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_119
do_apply_120:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_121
do_compose_119:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_121:
    str x0, [sp, #-16]!
    mov x0, #0
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_118
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
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
    ldr x0, [x29, #-48]
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
    str x0, [sp, #-16]!
    mov x0, #1
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
blk_end_118:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_116_117:
    // Closure for func_116
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_116
    ldr x0, [sp], #16
    bl _cons
    b cond_end_115
cond_false_114:
    adr x0, sign_id
cond_end_115:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_134
    b after_func_136_137
func_136:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_len_impl_139
len_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_143_144
func_143:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_145_146
func_145:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_147_148
func_147:
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
after_func_147_148:
    // Closure for func_147
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_147
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_145_146:
    // Closure for func_145
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_145
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_155_156
func_155:
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
after_func_155_156:
    // Closure for func_155
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_155
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_140
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_142
xor_true_140:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_141
    adr x0, sign_id
    b xor_end_142
xor_false_141:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_len_impl_139:
    // Closure for len_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, len_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_138
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_157
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_157
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_157
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_160
    adr x0, sign_id
    b cmp_end_161
cmp_true_160:
cmp_end_161:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_158
    ldr x0, [x29, #-64]
    b cond_end_159
cond_false_158:
    adr x0, sign_id
cond_end_159:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_157
    adr x0, len_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_162
do_apply_163:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_164
do_compose_162:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_164:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_165
do_apply_166:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_167
do_compose_165:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_167:
blk_end_157:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_138
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_168
do_apply_169:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_170
do_compose_168:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_170:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_138
    adr x0, sys_write
    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_171
do_apply_172:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_173
do_compose_171:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_173:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, len
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
blk_end_138:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_136_137:
    // Closure for func_136
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_136
    ldr x0, [sp], #16
    bl _cons
    b cond_end_135
cond_false_134:
    adr x0, sign_id
cond_end_135:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_num
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_180
    b after_func_182_183
func_182:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_187
    adr x0, sign_id
    b cmp_end_188
cmp_true_187:
cmp_end_188:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_185
    adr x0, sign_id
    b cond_end_186
cond_false_185:
    adr x0, sign_id
cond_end_186:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_184
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #48
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
    b.ne blk_end_189
    mov x0, #0
blk_end_189:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_184
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_195
    adr x0, sign_id
    b cmp_end_196
cmp_true_195:
cmp_end_196:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_193
    adr x0, sign_id
    b cond_end_194
cond_false_193:
    adr x0, sign_id
cond_end_194:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_184
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #45
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_197
    adr x0, print_num
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_197
    mov x0, #0
blk_end_197:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_184
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
blk_end_184:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_182_183:
    // Closure for func_182
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_182
    ldr x0, [sp], #16
    bl _cons
    b cond_end_181
cond_false_180:
    adr x0, sign_id
cond_end_181:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _print_num_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_207
    b after_func_209_210
func_209:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_214
    adr x0, sign_id
    b cmp_end_215
cmp_true_214:
cmp_end_215:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_212
    mov x0, #0
    b cond_end_213
cond_false_212:
    adr x0, sign_id
cond_end_213:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_211
    adr x0, _print_num_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
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
    b.ne blk_end_211
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #48
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    ldr x1, [sp], #16
    add x0, x1, x0
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
blk_end_211:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_209_210:
    // Closure for func_209
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_209
    ldr x0, [sp], #16
    bl _cons
    b cond_end_208
cond_false_207:
    adr x0, sign_id
cond_end_208:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, add
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_222
    b after_func_224_225
func_224:
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
after_func_224_225:
    // Closure for func_224
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_224
    ldr x0, [sp], #16
    bl _cons
    b cond_end_223
cond_false_222:
    adr x0, sign_id
cond_end_223:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sub
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_226
    b after_func_228_229
func_228:
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
after_func_228_229:
    // Closure for func_228
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_228
    ldr x0, [sp], #16
    bl _cons
    b cond_end_227
cond_false_226:
    adr x0, sign_id
cond_end_227:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, mul
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_230
    b after_func_232_233
func_232:
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
after_func_232_233:
    // Closure for func_232
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_232
    ldr x0, [sp], #16
    bl _cons
    b cond_end_231
cond_false_230:
    adr x0, sign_id
cond_end_231:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, div
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_234
    b after_func_236_237
func_236:
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
after_func_236_237:
    // Closure for func_236
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_236
    ldr x0, [sp], #16
    bl _cons
    b cond_end_235
cond_false_234:
    adr x0, sign_id
cond_end_235:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, mod
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_238
    b after_func_240_241
func_240:
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
after_func_240_241:
    // Closure for func_240
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_240
    ldr x0, [sp], #16
    bl _cons
    b cond_end_239
cond_false_238:
    adr x0, sign_id
cond_end_239:
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
    adr x0, Lexer
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Ported
    str x0, [sp, #-16]!
    adr x0, from
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
    adr x0, prepare_lexer
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
    adr x0, .
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
    adr x0, js
    str x0, [sp, #-16]!
    adr x0, parser
    ldr x1, [sp], #16
    sdiv x0, x1, x0
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
    adr x0, .
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
    adr x0, js
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
    b.eq cond_false_266
    b after_func_268_269
func_268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, src
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
    adr x0, source
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_267
cond_false_266:
    adr x0, sign_id
cond_end_267:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, src_len
    str x0, [sp, #-16]!
    adr x0, len
    str x0, [sp, #-16]!
    adr x0, source
    cmp x0, #4096
    b.hi do_compose_270
do_apply_271:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_272
do_compose_270:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_272:
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
    b.hi do_compose_273
do_apply_274:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_275
do_compose_273:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_275:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_276
    b after_func_278_279
func_278:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_278_279:
    // Closure for func_278
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_278
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, pos
    ldr x0, [x0] // @ load
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_277
cond_false_276:
    adr x0, sign_id
cond_end_277:
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
    b.ge cmp_true_282
    adr x0, sign_id
    b cmp_end_283
cmp_true_282:
cmp_end_283:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_280
    adr x0, sign_id
    b cond_end_281
cond_false_280:
    adr x0, sign_id
cond_end_281:
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
    b.eq cond_false_287
    b after_func_289_290
func_289:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #32
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_295
    adr x0, sign_id
    b cmp_end_296
cmp_true_295:
cmp_end_296:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_293
    b or_end_294
or_right_293:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #9
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_297
    adr x0, sign_id
    b cmp_end_298
cmp_true_297:
cmp_end_298:
or_end_294:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_291
    b or_end_292
or_right_291:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #13
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_299
    adr x0, sign_id
    b cmp_end_300
cmp_true_299:
cmp_end_300:
or_end_292:
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
    b cond_end_288
cond_false_287:
    adr x0, sign_id
cond_end_288:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_digit
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_301
    b after_func_303_304
func_303:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #48
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_307
    adr x0, sign_id
    b cmp_end_308
cmp_true_307:
cmp_end_308:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_305
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #57
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_309
    adr x0, sign_id
    b cmp_end_310
cmp_true_309:
cmp_end_310:
    b and_end_306
and_fail_305:
    adr x0, sign_id
and_end_306:
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
    b cond_end_302
cond_false_301:
    adr x0, sign_id
cond_end_302:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_alpha
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_311
    b after_func_313_314
func_313:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #65
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_321
    adr x0, sign_id
    b cmp_end_322
cmp_true_321:
cmp_end_322:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_319
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #90
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_323
    adr x0, sign_id
    b cmp_end_324
cmp_true_323:
cmp_end_324:
    b and_end_320
and_fail_319:
    adr x0, sign_id
and_end_320:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_317
    b or_end_318
or_right_317:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #97
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_327
    adr x0, sign_id
    b cmp_end_328
cmp_true_327:
cmp_end_328:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_325
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #122
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_329
    adr x0, sign_id
    b cmp_end_330
cmp_true_329:
cmp_end_330:
    b and_end_326
and_fail_325:
    adr x0, sign_id
and_end_326:
or_end_318:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_315
    b or_end_316
or_right_315:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #95
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_331
    adr x0, sign_id
    b cmp_end_332
cmp_true_331:
cmp_end_332:
or_end_316:
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
    b cond_end_312
cond_false_311:
    adr x0, sign_id
cond_end_312:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_op_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_333
    b after_func_335_336
func_335:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #61
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_367
    adr x0, sign_id
    b cmp_end_368
cmp_true_367:
cmp_end_368:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_365
    b or_end_366
or_right_365:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #43
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_369
    adr x0, sign_id
    b cmp_end_370
cmp_true_369:
cmp_end_370:
or_end_366:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_363
    b or_end_364
or_right_363:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #45
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_371
    adr x0, sign_id
    b cmp_end_372
cmp_true_371:
cmp_end_372:
or_end_364:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_361
    b or_end_362
or_right_361:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #42
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_373
    adr x0, sign_id
    b cmp_end_374
cmp_true_373:
cmp_end_374:
or_end_362:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_359
    b or_end_360
or_right_359:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #47
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_375
    adr x0, sign_id
    b cmp_end_376
cmp_true_375:
cmp_end_376:
or_end_360:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_357
    b or_end_358
or_right_357:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #37
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_377
    adr x0, sign_id
    b cmp_end_378
cmp_true_377:
cmp_end_378:
or_end_358:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_355
    b or_end_356
or_right_355:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #94
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_379
    adr x0, sign_id
    b cmp_end_380
cmp_true_379:
cmp_end_380:
or_end_356:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_353
    b or_end_354
or_right_353:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #38
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_381
    adr x0, sign_id
    b cmp_end_382
cmp_true_381:
cmp_end_382:
or_end_354:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_351
    b or_end_352
or_right_351:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #124
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_383
    adr x0, sign_id
    b cmp_end_384
cmp_true_383:
cmp_end_384:
or_end_352:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_349
    b or_end_350
or_right_349:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #33
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_385
    adr x0, sign_id
    b cmp_end_386
cmp_true_385:
cmp_end_386:
or_end_350:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_347
    b or_end_348
or_right_347:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #60
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_387
    adr x0, sign_id
    b cmp_end_388
cmp_true_387:
cmp_end_388:
or_end_348:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_345
    b or_end_346
or_right_345:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #62
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_389
    adr x0, sign_id
    b cmp_end_390
cmp_true_389:
cmp_end_390:
or_end_346:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_343
    b or_end_344
or_right_343:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #63
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_391
    adr x0, sign_id
    b cmp_end_392
cmp_true_391:
cmp_end_392:
or_end_344:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_341
    b or_end_342
or_right_341:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #58
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_393
    adr x0, sign_id
    b cmp_end_394
cmp_true_393:
cmp_end_394:
or_end_342:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_339
    b or_end_340
or_right_339:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #59
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_395
    adr x0, sign_id
    b cmp_end_396
cmp_true_395:
cmp_end_396:
or_end_340:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_337
    b or_end_338
or_right_337:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #126
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_397
    adr x0, sign_id
    b cmp_end_398
cmp_true_397:
cmp_end_398:
or_end_338:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_335_336:
    // Closure for func_335
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_335
    ldr x0, [sp], #16
    bl _cons
    b cond_end_334
cond_false_333:
    adr x0, sign_id
cond_end_334:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, length
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_399
    b after_func_403_404
func_403:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_405
    adr x0, sign_id
    b cmp_end_406
cmp_true_405:
cmp_end_406:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_403_404:
    // Closure for func_403
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_403
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_401
    mov x0, #0
    b cond_end_402
cond_false_401:
    adr x0, sign_id
cond_end_402:
    b cond_end_400
cond_false_399:
    adr x0, sign_id
cond_end_400:
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
    b.ne blk_end_0
    adr x0, list_to_string
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_413
    b after_func_417_418
func_417:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, len
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_415
    adr x0, length
    str x0, [sp, #-16]!
    adr x0, list
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
    b cond_end_416
cond_false_415:
    adr x0, sign_id
cond_end_416:
    b cond_end_414
cond_false_413:
    adr x0, sign_id
cond_end_414:
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
    str x0, [sp, #-16]!
    adr x0, str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_428
do_apply_429:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_430
do_compose_428:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_430:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_431
do_apply_432:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_433
do_compose_431:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_433:
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
    b.eq cond_false_434
    b after_func_438_439
func_438:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_440
    adr x0, sign_id
    b cmp_end_441
cmp_true_440:
cmp_end_441:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_438_439:
    // Closure for func_438
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_438
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_436
    mov x0, #0
    b cond_end_437
cond_false_436:
    adr x0, sign_id
cond_end_437:
    b cond_end_435
cond_false_434:
    adr x0, sign_id
cond_end_435:
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
    adr x0, buf
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
    adr x0, idx
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    b.ne blk_end_0
    adr x0, tokenize
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_457
    b after_func_461_462
func_461:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, tok
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_461_462:
    // Closure for func_461
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_461
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_459
    adr x0, scan
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_460
cond_false_459:
    adr x0, sign_id
cond_end_460:
    b cond_end_458
cond_false_457:
    adr x0, sign_id
cond_end_458:
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
    b.eq cmp_true_468
    adr x0, sign_id
    b cmp_end_469
cmp_true_468:
cmp_end_469:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_466
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok
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
    mov x0, #0
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
    b cond_end_467
cond_false_466:
    adr x0, sign_id
cond_end_467:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok
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
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_485
    b after_func_487_488
func_487:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, skip_space
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
    b cond_end_486
cond_false_485:
    adr x0, sign_id
cond_end_486:
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
    b.eq cmp_true_494
    adr x0, sign_id
    b cmp_end_495
cmp_true_494:
cmp_end_495:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_492
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_eof
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_499
do_apply_500:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_501
do_compose_499:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_501:
    b cond_end_493
cond_false_492:
    adr x0, sign_id
cond_end_493:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_digit
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    b.eq cond_false_502
    adr x0, scan_num
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    b cond_end_503
cond_false_502:
    adr x0, sign_id
cond_end_503:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_alpha
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_512
do_apply_513:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_514
do_compose_512:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_514:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_510
    adr x0, scan_id
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_515
do_apply_516:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_517
do_compose_515:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_517:
    b cond_end_511
cond_false_510:
    adr x0, sign_id
cond_end_511:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_op_char
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    b.eq cond_false_518
    adr x0, scan_op
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_519
cond_false_518:
    adr x0, sign_id
cond_end_519:
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
    b.eq cmp_true_528
    adr x0, sign_id
    b cmp_end_529
cmp_true_528:
cmp_end_529:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_526
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_527
cond_false_526:
    adr x0, sign_id
cond_end_527:
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
    b.eq cmp_true_535
    adr x0, sign_id
    b cmp_end_536
cmp_true_535:
cmp_end_536:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_533
    adr x0, scan_str
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_534
cond_false_533:
    adr x0, sign_id
cond_end_534:
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
    b.eq cmp_true_542
    adr x0, sign_id
    b cmp_end_543
cmp_true_542:
cmp_end_543:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_540
    adr x0, sign_id
    b cond_end_541
cond_false_540:
    adr x0, sign_id
cond_end_541:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_sep
    ldr x0, [x0]
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
    mov x0, #0
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
    b.eq cmp_true_559
    adr x0, sign_id
    b cmp_end_560
cmp_true_559:
cmp_end_560:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_557
    b or_end_558
or_right_557:
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #91
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_561
    adr x0, sign_id
    b cmp_end_562
cmp_true_561:
cmp_end_562:
or_end_558:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_555
    b or_end_556
or_right_555:
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #123
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_563
    adr x0, sign_id
    b cmp_end_564
cmp_true_563:
cmp_end_564:
or_end_556:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_553
    adr x0, sign_id
    b cond_end_554
cond_false_553:
    adr x0, sign_id
cond_end_554:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_lparen
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
    b.eq cmp_true_580
    adr x0, sign_id
    b cmp_end_581
cmp_true_580:
cmp_end_581:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_578
    b or_end_579
or_right_578:
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #93
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_582
    adr x0, sign_id
    b cmp_end_583
cmp_true_582:
cmp_end_583:
or_end_579:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_576
    b or_end_577
or_right_576:
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #125
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_584
    adr x0, sign_id
    b cmp_end_585
cmp_true_584:
cmp_end_585:
or_end_577:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_574
    adr x0, sign_id
    b cond_end_575
cond_false_574:
    adr x0, sign_id
cond_end_575:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
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
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_punc
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_598
do_apply_599:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_600
do_compose_598:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_600:
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    adr x0, skip_space
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_604
    b after_func_608_609
func_608:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_space
    str x0, [sp, #-16]!
    b after_func_610_611
func_610:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_615_616
func_615:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_617_618
func_617:
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
after_func_617_618:
    // Closure for func_617
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_617
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_615_616:
    // Closure for func_615
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_615
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
    b.ne xor_true_612
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_614
xor_true_612:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_613
    adr x0, sign_id
    b xor_end_614
xor_false_613:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_610_611:
    // Closure for func_610
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_610
    ldr x0, [sp], #16
    bl _cons
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
after_func_608_609:
    // Closure for func_608
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_608
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_606
    adr x0, sign_id
    b cond_end_607
cond_false_606:
    adr x0, sign_id
cond_end_607:
    b cond_end_605
cond_false_604:
    adr x0, sign_id
cond_end_605:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.ne blk_end_0
    adr x0, skip_space
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.eq cond_false_634
    b after_func_638_639
func_638:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, chars
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_636
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, first_char
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
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
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
    b cond_end_637
cond_false_636:
    adr x0, sign_id
cond_end_637:
    b cond_end_635
cond_false_634:
    adr x0, sign_id
cond_end_635:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
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
    b.hi do_compose_655
do_apply_656:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_657
do_compose_655:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_657:
    str x0, [sp, #-16]!
    adr x0, str
    ldr x0, [x0]
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
    adr x0, _scan_id_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_661
    b after_func_665_666
func_665:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_alpha
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_667
    b or_end_668
or_right_667:
    adr x0, is_digit
or_end_668:
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
    ldr x0, [x29, #-32]
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
after_func_665_666:
    // Closure for func_665
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_665
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_663
    adr x0, sign_id
    b cond_end_664
cond_false_663:
    adr x0, sign_id
cond_end_664:
    b cond_end_662
cond_false_661:
    adr x0, sign_id
cond_end_662:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, _scan_id_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_678
do_apply_679:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_680
do_compose_678:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_680:
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
    b.eq cond_false_687
    b after_func_691_692
func_691:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, res
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_691_692:
    // Closure for func_691
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_691
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_689
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    adr x0, acc
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
    mov x0, #0
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
    b cond_end_690
cond_false_689:
    adr x0, sign_id
cond_end_690:
    b cond_end_688
cond_false_687:
    adr x0, sign_id
cond_end_688:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_num
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, res
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
    adr x0, _scan_num_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_705
    b after_func_709_710
func_709:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_digit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_707
    adr x0, val
    str x0, [sp, #-16]!
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
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_708
cond_false_707:
    adr x0, sign_id
cond_end_708:
    b cond_end_706
cond_false_705:
    adr x0, sign_id
cond_end_706:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_num_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, val
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
    b.ne blk_end_0
    adr x0, acc
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, scan_op
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_723
    b after_func_727_728
func_727:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, chars
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_727_728:
    // Closure for func_727
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_727
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_725
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    str x0, [sp, #-16]!
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    cmp x0, #4096
    b.hi do_compose_741
do_apply_742:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_743
do_compose_741:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_743:
    b cond_end_726
cond_false_725:
    adr x0, sign_id
cond_end_726:
    b cond_end_724
cond_false_723:
    adr x0, sign_id
cond_end_724:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, chars
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
    adr x0, str
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_op_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_753
    b after_func_757_758
func_757:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_op_char
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_757_758:
    // Closure for func_757
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_757
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_755
    adr x0, sign_id
    b cond_end_756
cond_false_755:
    adr x0, sign_id
cond_end_756:
    b cond_end_754
cond_false_753:
    adr x0, sign_id
cond_end_754:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
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
    adr x0, _scan_op_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_765
do_apply_766:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_767
do_compose_765:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_767:
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
    b.eq cond_false_774
    b after_func_778_779
func_778:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_776
    adr x0, list_to_string
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    cmp x0, #4096
    b.hi do_compose_786
do_apply_787:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_788
do_compose_786:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_788:
    b cond_end_777
cond_false_776:
    adr x0, sign_id
cond_end_777:
    b cond_end_775
cond_false_774:
    adr x0, sign_id
cond_end_775:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, tok_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_789
do_apply_790:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_791
do_compose_789:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_791:
    str x0, [sp, #-16]!
    adr x0, str
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _scan_str_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_795
    b after_func_799_800
func_799:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #96
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_803
    adr x0, sign_id
    b cmp_end_804
cmp_true_803:
cmp_end_804:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_801
    b or_end_802
or_right_801:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #-1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_805
    adr x0, sign_id
    b cmp_end_806
cmp_true_805:
cmp_end_806:
or_end_802:
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
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_807
do_apply_808:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_809
do_compose_807:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_809:
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
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_810
do_apply_811:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_812
do_compose_810:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_812:
    str x0, [sp, #-16]!
    adr x0, _scan_str_rec
    str x0, [sp, #-16]!
    adr x0, read_char
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, Parser
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Parses
    str x0, [sp, #-16]!
    adr x0, token
    cmp x0, #4096
    b.hi do_compose_828
do_apply_829:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_830
do_compose_828:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_830:
    str x0, [sp, #-16]!
    adr x0, list
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
    adr x0, into
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
    str x0, [sp, #-16]!
    adr x0, AST
    cmp x0, #4096
    b.hi do_compose_837
do_apply_838:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_839
do_compose_837:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_839:
    str x0, [sp, #-16]!
    adr x0, S
    str x0, [sp, #-16]!
    adr x0, expressions
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_840
do_apply_841:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_842
do_compose_840:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_842:
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
    b.eq cond_false_843
    b after_func_847_848
func_847:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, s2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_849
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
    adr x1, func_847
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_845
    mov x0, #1
    b cond_end_846
cond_false_845:
    adr x0, sign_id
cond_end_846:
    b cond_end_844
cond_false_843:
    adr x0, sign_id
cond_end_844:
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
    b.ne cmp_true_853
    adr x0, sign_id
    b cmp_end_854
cmp_true_853:
cmp_end_854:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_851
    mov x0, #0
    b cond_end_852
cond_false_851:
    adr x0, sign_id
cond_end_852:
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
    b.eq cmp_true_857
    adr x0, sign_id
    b cmp_end_858
cmp_true_857:
cmp_end_858:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_855
    mov x0, #1
    b cond_end_856
cond_false_855:
    adr x0, sign_id
cond_end_856:
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
    adr x0, s2
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_semicolon_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_865
    b after_func_869_870
func_869:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_867
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
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
    b cond_end_868
cond_false_867:
    adr x0, sign_id
cond_end_868:
    b cond_end_866
cond_false_865:
    adr x0, sign_id
cond_end_866:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, s
    str x0, [sp, #-16]!
    mov x0, #59
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne blk_end_0
    adr x0, s
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_bar_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_874
    b after_func_878_879
func_878:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_878_879:
    // Closure for func_878
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_878
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_876
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
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
    b cond_end_877
cond_false_876:
    adr x0, sign_id
cond_end_877:
    b cond_end_875
cond_false_874:
    adr x0, sign_id
cond_end_875:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, s
    str x0, [sp, #-16]!
    mov x0, #124
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne blk_end_0
    adr x0, s
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_lt_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_883
    b after_func_887_888
func_887:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_887_888:
    // Closure for func_887
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_887
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_885
    adr x0, alloc
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
    b cond_end_886
cond_false_885:
    adr x0, sign_id
cond_end_886:
    b cond_end_884
cond_false_883:
    adr x0, sign_id
cond_end_884:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, s
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne blk_end_0
    adr x0, s
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_gt_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_892
    b after_func_896_897
func_896:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, s
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_896_897:
    // Closure for func_896
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_896
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_894
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
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
    b cond_end_895
cond_false_894:
    adr x0, sign_id
cond_end_895:
    b cond_end_893
cond_false_892:
    adr x0, sign_id
cond_end_893:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, s
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
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
    b.ne blk_end_0
    adr x0, s
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, get_prec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_901
    b after_func_905_906
func_905:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
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
    str x0, [sp, #-16]!
    adr x0, str_0
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_905_906:
    // Closure for func_905
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_905
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_903
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_904
cond_false_903:
    adr x0, sign_id
cond_end_904:
    b cond_end_902
cond_false_901:
    adr x0, sign_id
cond_end_902:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, str_1
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
    b.eq cond_false_913
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_914
cond_false_913:
    adr x0, sign_id
cond_end_914:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, str_2
    cmp x0, #4096
    b.hi do_compose_926
do_apply_927:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_928
do_compose_926:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_928:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_921
    adr x0, PREC_MUL
    ldr x0, [x0]
    b cond_end_922
cond_false_921:
    adr x0, sign_id
cond_end_922:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, str_3
    cmp x0, #4096
    b.hi do_compose_934
do_apply_935:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_936
do_compose_934:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_936:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_929
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_930
cond_false_929:
    adr x0, sign_id
cond_end_930:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, str_4
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_937
    adr x0, PREC_ADD
    ldr x0, [x0]
    b cond_end_938
cond_false_937:
    adr x0, sign_id
cond_end_938:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_947
do_apply_948:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_949
do_compose_947:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_949:
    str x0, [sp, #-16]!
    adr x0, get_lt_str
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_950
do_apply_951:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_952
do_compose_950:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_952:
    cmp x0, #4096
    b.hi do_compose_953
do_apply_954:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_955
do_compose_953:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_955:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_945
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_946
cond_false_945:
    adr x0, sign_id
cond_end_946:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, get_gt_str
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_961
do_apply_962:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_963
do_compose_961:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_963:
    cmp x0, #4096
    b.hi do_compose_964
do_apply_965:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_966
do_compose_964:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_966:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_956
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_957
cond_false_956:
    adr x0, sign_id
cond_end_957:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, str_5
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_967
    adr x0, PREC_CMP
    ldr x0, [x0]
    b cond_end_968
cond_false_967:
    adr x0, sign_id
cond_end_968:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    adr x0, get_semicolon_str
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_975
    adr x0, PREC_XOR
    ldr x0, [x0]
    b cond_end_976
cond_false_975:
    adr x0, sign_id
cond_end_976:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    adr x0, get_bar_str
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.eq cond_false_986
    adr x0, PREC_OR
    ldr x0, [x0]
    b cond_end_987
cond_false_986:
    adr x0, sign_id
cond_end_987:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_999
do_apply_1000:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1001
do_compose_999:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1001:
    str x0, [sp, #-16]!
    adr x0, str_6
    cmp x0, #4096
    b.hi do_compose_1002
do_apply_1003:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1004
do_compose_1002:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1004:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_997
    adr x0, PREC_AND
    ldr x0, [x0]
    b cond_end_998
cond_false_997:
    adr x0, sign_id
cond_end_998:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, str_7
    cmp x0, #4096
    b.hi do_compose_1010
do_apply_1011:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1012
do_compose_1010:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1012:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1005
    mov x0, #5
    b cond_end_1006
cond_false_1005:
    adr x0, sign_id
cond_end_1006:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    str x0, [sp, #-16]!
    adr x0, str_8
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1013
    mov x0, #6
    b cond_end_1014
cond_false_1013:
    adr x0, sign_id
cond_end_1014:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    adr x0, str_9
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1021
    mov x0, #2
    b cond_end_1022
cond_false_1021:
    adr x0, sign_id
cond_end_1022:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_right_assoc
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1029
    b after_func_1033_1034
func_1033:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x0, str_7
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1033_1034:
    // Closure for func_1033
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1033
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1031
    mov x0, #1
    b cond_end_1032
cond_false_1031:
    adr x0, sign_id
cond_end_1032:
    b cond_end_1030
cond_false_1029:
    adr x0, sign_id
cond_end_1030:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    adr x0, str_9
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
    b.eq cond_false_1041
    mov x0, #1
    b cond_end_1042
cond_false_1041:
    adr x0, sign_id
cond_end_1042:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
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
    adr x0, str_8
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1049
    mov x0, #1
    b cond_end_1050
cond_false_1049:
    adr x0, sign_id
cond_end_1050:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    cmp x0, #4096
    b.hi do_compose_1059
do_apply_1060:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1061
do_compose_1059:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1061:
    str x0, [sp, #-16]!
    adr x0, str_10
    cmp x0, #4096
    b.hi do_compose_1062
do_apply_1063:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1064
do_compose_1062:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1064:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1057
    mov x0, #1
    b cond_end_1058
cond_false_1057:
    adr x0, sign_id
cond_end_1058:
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, p_curr
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, init_parser
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1065
    b after_func_1067_1068
func_1067:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p_tokens
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
    adr x0, toks
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_1066
cond_false_1065:
    adr x0, sign_id
cond_end_1066:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1072
    b after_func_1076_1077
func_1076:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, p_tokens
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1078
    adr x0, sign_id
    b cmp_end_1079
cmp_true_1078:
cmp_end_1079:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1076_1077:
    // Closure for func_1076
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1076
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1074
    adr x0, sign_id
    b cond_end_1075
cond_false_1074:
    adr x0, sign_id
cond_end_1075:
    b cond_end_1073
cond_false_1072:
    adr x0, sign_id
cond_end_1073:
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
    b.hi do_compose_1080
do_apply_1081:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1082
do_compose_1080:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1082:
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.eq cond_false_1092
    b after_func_1094_1095
func_1094:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, peek
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1096
do_apply_1097:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1098
do_compose_1096:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1098:
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1094_1095:
    // Closure for func_1094
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1094
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1093
cond_false_1092:
    adr x0, sign_id
cond_end_1093:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_val
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1099
    b after_func_1101_1102
func_1101:
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
    b.hi do_compose_1103
do_apply_1104:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1105
do_compose_1103:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1105:
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1101_1102:
    // Closure for func_1101
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1101
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1100
cond_false_1099:
    adr x0, sign_id
cond_end_1100:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expect_val
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1106
    b after_func_1110_1111
func_1110:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, v
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1110_1111:
    // Closure for func_1110
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1110
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1108
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
    b cond_end_1109
cond_false_1108:
    adr x0, sign_id
cond_end_1109:
    b cond_end_1107
cond_false_1106:
    adr x0, sign_id
cond_end_1107:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, v
    str x0, [sp, #-16]!
    adr x0, val
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1117
    adr x0, sign_id
    b cmp_end_1118
cmp_true_1117:
cmp_end_1118:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1115
    adr x0, sign_id
    b cond_end_1116
cond_false_1115:
    adr x0, sign_id
cond_end_1116:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1119
do_apply_1120:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1121
do_compose_1119:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1121:
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
    adr x0, expect_type
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1122
    b after_func_1126_1127
func_1126:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, t
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1126_1127:
    // Closure for func_1126
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1126
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1124
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1128
do_apply_1129:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1130
do_compose_1128:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1130:
    b cond_end_1125
cond_false_1124:
    adr x0, sign_id
cond_end_1125:
    b cond_end_1123
cond_false_1122:
    adr x0, sign_id
cond_end_1123:
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
    b.eq cmp_true_1133
    adr x0, sign_id
    b cmp_end_1134
cmp_true_1133:
cmp_end_1134:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1131
    adr x0, sign_id
    b cond_end_1132
cond_false_1131:
    adr x0, sign_id
cond_end_1132:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1135
do_apply_1136:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1137
do_compose_1135:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1137:
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
    b.eq cond_false_1138
    b after_func_1142_1143
func_1142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, t
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1140
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1144
do_apply_1145:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1146
do_compose_1144:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1146:
    b cond_end_1141
cond_false_1140:
    adr x0, sign_id
cond_end_1141:
    b cond_end_1139
cond_false_1138:
    adr x0, sign_id
cond_end_1139:
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
    b.eq cmp_true_1149
    adr x0, sign_id
    b cmp_end_1150
cmp_true_1149:
cmp_end_1150:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1147
    mov x0, #1
    b cond_end_1148
cond_false_1147:
    adr x0, sign_id
cond_end_1148:
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
    b.eq cmp_true_1153
    adr x0, sign_id
    b cmp_end_1154
cmp_true_1153:
cmp_end_1154:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1151
    mov x0, #1
    b cond_end_1152
cond_false_1151:
    adr x0, sign_id
cond_end_1152:
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
    b.eq cmp_true_1157
    adr x0, sign_id
    b cmp_end_1158
cmp_true_1157:
cmp_end_1158:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1155
    mov x0, #1
    b cond_end_1156
cond_false_1155:
    adr x0, sign_id
cond_end_1156:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1159
    b after_func_1163_1164
func_1163:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1163_1164:
    // Closure for func_1163
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1163
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1161
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1165
do_apply_1166:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1167
do_compose_1165:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1167:
    b cond_end_1162
cond_false_1161:
    adr x0, sign_id
cond_end_1162:
    b cond_end_1160
cond_false_1159:
    adr x0, sign_id
cond_end_1160:
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
    b.eq cmp_true_1170
    adr x0, sign_id
    b cmp_end_1171
cmp_true_1170:
cmp_end_1171:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1168
    mov x0, #0
    b cond_end_1169
cond_false_1168:
    adr x0, sign_id
cond_end_1169:
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
    b.eq cmp_true_1174
    adr x0, sign_id
    b cmp_end_1175
cmp_true_1174:
cmp_end_1175:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1172
    adr x0, sign_id
    b cond_end_1173
cond_false_1172:
    adr x0, sign_id
cond_end_1173:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1176
do_apply_1177:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1178
do_compose_1176:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1178:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1194
    b after_func_1198_1199
func_1198:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1198_1199:
    // Closure for func_1198
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1198
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1196
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
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
    b cond_end_1197
cond_false_1196:
    adr x0, sign_id
cond_end_1197:
    b cond_end_1195
cond_false_1194:
    adr x0, sign_id
cond_end_1195:
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
    b.eq cmp_true_1205
    adr x0, sign_id
    b cmp_end_1206
cmp_true_1205:
cmp_end_1206:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1203
    adr x0, sign_id
    b cond_end_1204
cond_false_1203:
    adr x0, sign_id
cond_end_1204:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1207
do_apply_1208:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1209
do_compose_1207:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1209:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1210
do_apply_1211:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1212
do_compose_1210:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1212:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
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
    b.eq cmp_true_1221
    adr x0, sign_id
    b cmp_end_1222
cmp_true_1221:
cmp_end_1222:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1219
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.eq cmp_true_1231
    adr x0, sign_id
    b cmp_end_1232
cmp_true_1231:
cmp_end_1232:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1229
    adr x0, expr
    ldr x0, [x0]
    b cond_end_1230
cond_false_1229:
    adr x0, sign_id
cond_end_1230:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
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
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x0, [x0]
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
    str x0, [sp, #-16]!
    adr x0, rest
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
    b.eq cond_false_1245
    b after_func_1249_1250
func_1249:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, type
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1249_1250:
    // Closure for func_1249
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1249
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1247
    adr x0, peek_type
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
    b cond_end_1248
cond_false_1247:
    adr x0, sign_id
cond_end_1248:
    b cond_end_1246
cond_false_1245:
    adr x0, sign_id
cond_end_1246:
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
    b.eq cmp_true_1256
    adr x0, sign_id
    b cmp_end_1257
cmp_true_1256:
cmp_end_1257:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1254
    mov x0, #0
    b cond_end_1255
cond_false_1254:
    adr x0, sign_id
cond_end_1255:
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
    b.ne cmp_true_1260
    adr x0, sign_id
    b cmp_end_1261
cmp_true_1260:
cmp_end_1261:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1258
    adr x0, sign_id
    b cond_end_1259
cond_false_1258:
    adr x0, sign_id
cond_end_1259:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Check
    cmp x0, #4096
    b.hi do_compose_1262
do_apply_1263:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1264
do_compose_1262:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1264:
    str x0, [sp, #-16]!
    adr x0, if
    cmp x0, #4096
    b.hi do_compose_1265
do_apply_1266:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1267
do_compose_1265:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1267:
    str x0, [sp, #-16]!
    adr x0, it
    str x0, [sp, #-16]!
    adr x0, s
    ldr x1, [sp], #16
    bl _nth
    cmp x0, #4096
    b.hi do_compose_1268
do_apply_1269:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1270
do_compose_1268:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1270:
    str x0, [sp, #-16]!
    adr x0, a
    cmp x0, #4096
    b.hi do_compose_1271
do_apply_1272:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1273
do_compose_1271:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1273:
    str x0, [sp, #-16]!
    adr x0, closing
    cmp x0, #4096
    b.hi do_compose_1274
do_apply_1275:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1276
do_compose_1274:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1276:
    str x0, [sp, #-16]!
    adr x0, paren
    cmp x0, #4096
    b.hi do_compose_1277
do_apply_1278:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1279
do_compose_1277:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1279:
    str x0, [sp, #-16]!
    adr x0, or
    cmp x0, #4096
    b.hi do_compose_1280
do_apply_1281:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1282
do_compose_1280:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1282:
    str x0, [sp, #-16]!
    adr x0, dedent
    cmp x0, #4096
    b.hi do_compose_1283
do_apply_1284:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1285
do_compose_1283:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1285:
    str x0, [sp, #-16]!
    adr x0, implicit
    cmp x0, #4096
    b.hi do_compose_1286
do_apply_1287:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1288
do_compose_1286:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1288:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, tok_rparen
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1291
    adr x0, sign_id
    b cmp_end_1292
cmp_true_1291:
cmp_end_1292:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1289
    mov x0, #0
    b cond_end_1290
cond_false_1289:
    adr x0, sign_id
cond_end_1290:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Also
    cmp x0, #4096
    b.hi do_compose_1293
do_apply_1294:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1295
do_compose_1293:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1295:
    str x0, [sp, #-16]!
    adr x0, should
    cmp x0, #4096
    b.hi do_compose_1296
do_apply_1297:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1298
do_compose_1296:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1298:
    str x0, [sp, #-16]!
    adr x0, check
    cmp x0, #4096
    b.hi do_compose_1299
do_apply_1300:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1301
do_compose_1299:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1301:
    str x0, [sp, #-16]!
    adr x0, for
    cmp x0, #4096
    b.hi do_compose_1302
do_apply_1303:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1304
do_compose_1302:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1304:
    str x0, [sp, #-16]!
    adr x0, dedent
    cmp x0, #4096
    b.hi do_compose_1305
do_apply_1306:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1307
do_compose_1305:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1307:
    str x0, [sp, #-16]!
    adr x0, if
    cmp x0, #4096
    b.hi do_compose_1308
do_apply_1309:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1310
do_compose_1308:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1310:
    str x0, [sp, #-16]!
    adr x0, we
    cmp x0, #4096
    b.hi do_compose_1311
do_apply_1312:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1313
do_compose_1311:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1313:
    str x0, [sp, #-16]!
    adr x0, had
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
    adr x0, indentation
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
    str x0, [sp, #-16]!
    adr x0, logic
    cmp x0, #4096
    b.hi do_compose_1320
do_apply_1321:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1322
do_compose_1320:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1322:
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
    adr x0, tok_sep
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1325
    adr x0, sign_id
    b cmp_end_1326
cmp_true_1325:
cmp_end_1326:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1323
    adr x0, sign_id
    b cond_end_1324
cond_false_1323:
    adr x0, sign_id
cond_end_1324:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1327
do_apply_1328:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1329
do_compose_1327:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1329:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1330
do_apply_1331:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1332
do_compose_1330:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1332:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1333
do_apply_1334:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1335
do_compose_1333:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1335:
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
    b.hi do_compose_1336
do_apply_1337:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1338
do_compose_1336:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1338:
    str x0, [sp, #-16]!
    adr x0, parse_block_rest
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1339
do_apply_1340:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1341
do_compose_1339:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1341:
    cmp x0, #4096
    b.hi do_compose_1342
do_apply_1343:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1344
do_compose_1342:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1344:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1345
    b after_func_1349_1350
func_1349:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, lhs
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1349_1350:
    // Closure for func_1349
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1349
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1347
    adr x0, parse_primary
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1351
do_apply_1352:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1353
do_compose_1351:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1353:
    b cond_end_1348
cond_false_1347:
    adr x0, sign_id
cond_end_1348:
    b cond_end_1346
cond_false_1345:
    adr x0, sign_id
cond_end_1346:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_1354
do_apply_1355:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1356
do_compose_1354:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1356:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_1357
do_apply_1358:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1359
do_compose_1357:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1359:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _parse_expr_loop
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1360
    b after_func_1364_1365
func_1364:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, is_app
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1364_1365:
    // Closure for func_1364
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1364
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1362
    adr x0, can_start_expr
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1366
do_apply_1367:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1368
do_compose_1366:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1368:
    b cond_end_1363
cond_false_1362:
    adr x0, sign_id
cond_end_1363:
    b cond_end_1361
cond_false_1360:
    adr x0, sign_id
cond_end_1361:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_app
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1371
    adr x0, PREC_APPLY
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, min_prec
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_1373
    adr x0, sign_id
    b cmp_end_1374
cmp_true_1373:
cmp_end_1374:
    b and_end_1372
and_fail_1371:
    adr x0, sign_id
and_end_1372:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1369
    adr x0, sign_id
    b cond_end_1370
cond_false_1369:
    adr x0, sign_id
cond_end_1370:
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
    b.hi do_compose_1375
do_apply_1376:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1377
do_compose_1375:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1377:
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
    b.hi do_compose_1378
do_apply_1379:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1380
do_compose_1378:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1380:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_1381
do_apply_1382:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1383
do_compose_1381:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1383:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1384
do_apply_1385:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1386
do_compose_1384:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1386:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1387
do_apply_1388:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1389
do_compose_1387:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1389:
    cmp x0, #4096
    b.hi do_compose_1390
do_apply_1391:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1392
do_compose_1390:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1392:
    cmp x0, #4096
    b.hi do_compose_1393
do_apply_1394:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1395
do_compose_1393:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1395:
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
    b.hi do_compose_1396
do_apply_1397:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1398
do_compose_1396:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1398:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_1399
do_apply_1400:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1401
do_compose_1399:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1401:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1402
do_apply_1403:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1404
do_compose_1402:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1404:
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
    b.ne cmp_true_1407
    adr x0, sign_id
    b cmp_end_1408
cmp_true_1407:
cmp_end_1408:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1405
    adr x0, lhs
    b cond_end_1406
cond_false_1405:
    adr x0, sign_id
cond_end_1406:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1409
do_apply_1410:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1411
do_compose_1409:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1411:
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
    b.hi do_compose_1412
do_apply_1413:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1414
do_compose_1412:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1414:
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
    b.lt cmp_true_1417
    adr x0, sign_id
    b cmp_end_1418
cmp_true_1417:
cmp_end_1418:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1415
    adr x0, lhs
    b cond_end_1416
cond_false_1415:
    adr x0, sign_id
cond_end_1416:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1419
do_apply_1420:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1421
do_compose_1419:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1421:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_next_min_prec_impl_1422
next_min_prec_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, prec
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, prec
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1423
do_apply_1424:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1425
do_compose_1423:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1425:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_next_min_prec_impl_1422:
    // Closure for next_min_prec_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, next_min_prec_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    adr x0, next_min_prec
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1426
do_apply_1427:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1428
do_compose_1426:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1428:
    adr x1, rhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1429
do_apply_1430:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1431
do_compose_1429:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1431:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1432
do_apply_1433:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1434
do_compose_1432:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1434:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_1435
do_apply_1436:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1437
do_compose_1435:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1437:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1438
do_apply_1439:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1440
do_compose_1438:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1440:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1441
do_apply_1442:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1443
do_compose_1441:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1443:
    cmp x0, #4096
    b.hi do_compose_1444
do_apply_1445:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1446
do_compose_1444:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1446:
    cmp x0, #4096
    b.hi do_compose_1447
do_apply_1448:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1449
do_compose_1447:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1449:
    cmp x0, #4096
    b.hi do_compose_1450
do_apply_1451:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1452
do_compose_1450:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1452:
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
    b.hi do_compose_1453
do_apply_1454:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1455
do_compose_1453:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1455:
    str x0, [sp, #-16]!
    adr x0, min_prec
    cmp x0, #4096
    b.hi do_compose_1456
do_apply_1457:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1458
do_compose_1456:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1458:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_primary
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1459
    b after_func_1463_1464
func_1463:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, t
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1463_1464:
    // Closure for func_1463
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1463
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1461
    adr x0, peek_type
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1465
do_apply_1466:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1467
do_compose_1465:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1467:
    b cond_end_1462
cond_false_1461:
    adr x0, sign_id
cond_end_1462:
    b cond_end_1460
cond_false_1459:
    adr x0, sign_id
cond_end_1460:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, peek_val
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.eq cmp_true_1473
    adr x0, sign_id
    b cmp_end_1474
cmp_true_1473:
cmp_end_1474:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1471
    adr x0, sign_id
    b cond_end_1472
cond_false_1471:
    adr x0, sign_id
cond_end_1472:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1475
do_apply_1476:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1477
do_compose_1475:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1477:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1478
do_apply_1479:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1480
do_compose_1478:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1480:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, v
    ldr x0, [x0]
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
    mov x0, #0
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
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, tok_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1492
    adr x0, sign_id
    b cmp_end_1493
cmp_true_1492:
cmp_end_1493:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1490
    adr x0, sign_id
    b cond_end_1491
cond_false_1490:
    adr x0, sign_id
cond_end_1491:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1494
do_apply_1495:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1496
do_compose_1494:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1496:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1497
do_apply_1498:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1499
do_compose_1497:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1499:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    adr x0, v
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1500
do_apply_1501:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1502
do_compose_1500:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1502:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1503
do_apply_1504:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1505
do_compose_1503:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1505:
    cmp x0, #4096
    b.hi do_compose_1506
do_apply_1507:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1508
do_compose_1506:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1508:
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
    b.eq cmp_true_1511
    adr x0, sign_id
    b cmp_end_1512
cmp_true_1511:
cmp_end_1512:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1509
    adr x0, sign_id
    b cond_end_1510
cond_false_1509:
    adr x0, sign_id
cond_end_1510:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, advance
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1513
do_apply_1514:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1515
do_compose_1513:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1515:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_expr
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1516
do_apply_1517:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1518
do_compose_1516:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1518:
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
    b.hi do_compose_1519
do_apply_1520:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1521
do_compose_1519:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1521:
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
    b.hi do_compose_1522
do_apply_1523:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1524
do_compose_1522:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1524:
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    mov x0, #999
    cmp x0, #4096
    b.hi do_compose_1525
do_apply_1526:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1527
do_compose_1525:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1527:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1528
do_apply_1529:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1530
do_compose_1528:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1530:
    cmp x0, #4096
    b.hi do_compose_1531
do_apply_1532:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1533
do_compose_1531:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1533:
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
    b.hi do_compose_1534
do_apply_1535:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1536
do_compose_1534:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1536:
    str x0, [sp, #-16]!
    adr x0, Compiler
    cmp x0, #4096
    b.hi do_compose_1537
do_apply_1538:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1539
do_compose_1537:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1539:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Compiles
    str x0, [sp, #-16]!
    adr x0, AST
    cmp x0, #4096
    b.hi do_compose_1540
do_apply_1541:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1542
do_compose_1540:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1542:
    str x0, [sp, #-16]!
    adr x0, to
    cmp x0, #4096
    b.hi do_compose_1543
do_apply_1544:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1545
do_compose_1543:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1545:
    str x0, [sp, #-16]!
    adr x0, AArch64
    cmp x0, #4096
    b.hi do_compose_1546
do_apply_1547:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1548
do_compose_1546:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1548:
    str x0, [sp, #-16]!
    adr x0, Assembly
    cmp x0, #4096
    b.hi do_compose_1549
do_apply_1550:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1551
do_compose_1549:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1551:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_len
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1552
    b after_func_1556_1557
func_1556:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1556_1557:
    // Closure for func_1556
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1556
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1554
    adr x0, s
    ldr x0, [x0] // @ load
    b cond_end_1555
cond_false_1554:
    adr x0, sign_id
cond_end_1555:
    b cond_end_1553
cond_false_1552:
    adr x0, sign_id
cond_end_1553:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1560
    adr x0, sign_id
    b cmp_end_1561
cmp_true_1560:
cmp_end_1561:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1558
    mov x0, #0
    b cond_end_1559
cond_false_1558:
    adr x0, sign_id
cond_end_1559:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, str_len
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, s
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1562
do_apply_1563:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1564
do_compose_1562:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1564:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cpy
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1565
    b after_func_1569_1570
func_1569:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1569_1570:
    // Closure for func_1569
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1569
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1567
    adr x0, src
    ldr x0, [x0] // @ load
    b cond_end_1568
cond_false_1567:
    adr x0, sign_id
cond_end_1568:
    b cond_end_1566
cond_false_1565:
    adr x0, sign_id
cond_end_1566:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1573
    adr x0, sign_id
    b cmp_end_1574
cmp_true_1573:
cmp_end_1574:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1571
    adr x0, sign_id
    b cond_end_1572
cond_false_1571:
    adr x0, sign_id
cond_end_1572:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, dest
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, dest
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, dest
    str x0, [sp, #-16]!
    adr x0, c
    ldr x0, [x0]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cpy
    str x0, [sp, #-16]!
    adr x0, dest
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1575
do_apply_1576:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1577
do_compose_1575:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1577:
    str x0, [sp, #-16]!
    adr x0, src
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1578
do_apply_1579:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1580
do_compose_1578:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1580:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1581
    b after_func_1585_1586
func_1585:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, len1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1585_1586:
    // Closure for func_1585
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1585
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1583
    adr x0, str_len
    str x0, [sp, #-16]!
    adr x0, s1
    cmp x0, #4096
    b.hi do_compose_1587
do_apply_1588:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1589
do_compose_1587:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1589:
    b cond_end_1584
cond_false_1583:
    adr x0, sign_id
cond_end_1584:
    b cond_end_1582
cond_false_1581:
    adr x0, sign_id
cond_end_1582:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_len
    str x0, [sp, #-16]!
    adr x0, s2
    cmp x0, #4096
    b.hi do_compose_1590
do_apply_1591:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1592
do_compose_1590:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1592:
    adr x1, len2
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, len1
    str x0, [sp, #-16]!
    adr x0, len2
    ldr x0, [x0]
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1593
do_apply_1594:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1595
do_compose_1593:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1595:
    adr x1, new_s
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cpy
    str x0, [sp, #-16]!
    adr x0, new_s
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1596
do_apply_1597:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1598
do_compose_1596:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1598:
    str x0, [sp, #-16]!
    adr x0, s1
    cmp x0, #4096
    b.hi do_compose_1599
do_apply_1600:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1601
do_compose_1599:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1601:
    adr x1, end_s1
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, end_s1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1602
do_apply_1603:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1604
do_compose_1602:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1604:
    str x0, [sp, #-16]!
    adr x0, points
    cmp x0, #4096
    b.hi do_compose_1605
do_apply_1606:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1607
do_compose_1605:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1607:
    str x0, [sp, #-16]!
    adr x0, to
    cmp x0, #4096
    b.hi do_compose_1608
do_apply_1609:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1610
do_compose_1608:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1610:
    str x0, [sp, #-16]!
    adr x0, null
    cmp x0, #4096
    b.hi do_compose_1611
do_apply_1612:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1613
do_compose_1611:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1613:
    str x0, [sp, #-16]!
    adr x0, terminator
    cmp x0, #4096
    b.hi do_compose_1614
do_apply_1615:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1616
do_compose_1614:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1616:
    str x0, [sp, #-16]!
    adr x0, of
    cmp x0, #4096
    b.hi do_compose_1617
do_apply_1618:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1619
do_compose_1617:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1619:
    str x0, [sp, #-16]!
    adr x0, first
    cmp x0, #4096
    b.hi do_compose_1620
do_apply_1621:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1622
do_compose_1620:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1622:
    str x0, [sp, #-16]!
    adr x0, copy
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1626_1627
func_1626:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1626_1627:
    // Closure for func_1626
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1626
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, My
    cmp x0, #4096
    b.hi do_compose_1628
do_apply_1629:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1630
do_compose_1628:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1630:
    str x0, [sp, #-16]!
    adr x0, impl
    cmp x0, #4096
    b.hi do_compose_1631
do_apply_1632:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1633
do_compose_1631:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1633:
    str x0, [sp, #-16]!
    adr x0, above
    cmp x0, #4096
    b.hi do_compose_1634
do_apply_1635:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1636
do_compose_1634:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1636:
    str x0, [sp, #-16]!
    adr x0, returns
    cmp x0, #4096
    b.hi do_compose_1637
do_apply_1638:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1639
do_compose_1637:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1639:
    str x0, [sp, #-16]!
    adr x0, str_11
    cmp x0, #4096
    b.hi do_compose_1640
do_apply_1641:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1642
do_compose_1640:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1642:
    str x0, [sp, #-16]!
    adr x0, ptr
    str x0, [sp, #-16]!
    adr x0, to
    cmp x0, #4096
    b.hi do_compose_1643
do_apply_1644:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1645
do_compose_1643:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1645:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_1646
do_apply_1647:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1648
do_compose_1646:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1648:
    cmp x0, #4096
    b.hi do_compose_1649
do_apply_1650:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1651
do_compose_1649:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1651:
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_1652
do_apply_1653:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1654
do_compose_1652:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1654:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, So
    cmp x0, #4096
    b.hi do_compose_1655
do_apply_1656:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1657
do_compose_1655:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1657:
    str x0, [sp, #-16]!
    adr x0, we
    cmp x0, #4096
    b.hi do_compose_1658
do_apply_1659:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1660
do_compose_1658:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1660:
    str x0, [sp, #-16]!
    adr x0, can
    cmp x0, #4096
    b.hi do_compose_1661
do_apply_1662:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1663
do_compose_1661:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1663:
    str x0, [sp, #-16]!
    adr x0, chain
    cmp x0, #4096
    b.hi do_compose_1664
do_apply_1665:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1666
do_compose_1664:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1666:
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_1667
do_apply_1668:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1669
do_compose_1667:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1669:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cpy
    str x0, [sp, #-16]!
    adr x0, end_s1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1670
do_apply_1671:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1672
do_compose_1670:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1672:
    str x0, [sp, #-16]!
    adr x0, s2
    cmp x0, #4096
    b.hi do_compose_1673
do_apply_1674:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1675
do_compose_1673:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1675:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, new_s
    ldr x0, [x0]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, int_to_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1676
    b after_func_1680_1681
func_1680:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1682
    adr x0, sign_id
    b cmp_end_1683
cmp_true_1682:
cmp_end_1683:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1680_1681:
    // Closure for func_1680
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1680
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1678
    adr x0, str_12
    b cond_end_1679
cond_false_1678:
    adr x0, sign_id
cond_end_1679:
    b cond_end_1677
cond_false_1676:
    adr x0, sign_id
cond_end_1677:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1686
    adr x0, sign_id
    b cmp_end_1687
cmp_true_1686:
cmp_end_1687:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1684
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_4
    cmp x0, #4096
    b.hi do_compose_1688
do_apply_1689:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1690
do_compose_1688:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1690:
    str x0, [sp, #-16]!
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, n
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1691
do_apply_1692:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1693
do_compose_1691:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1693:
    cmp x0, #4096
    b.hi do_compose_1694
do_apply_1695:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1696
do_compose_1694:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1696:
    b cond_end_1685
cond_false_1684:
    adr x0, sign_id
cond_end_1685:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    adr x0, n
    cmp x0, #4096
    b.hi do_compose_1697
do_apply_1698:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1699
do_compose_1697:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1699:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, int_to_str_rec
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1700
    b after_func_1704_1705
func_1704:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1706
    adr x0, sign_id
    b cmp_end_1707
cmp_true_1706:
cmp_end_1707:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1704_1705:
    // Closure for func_1704
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1704
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1702
    adr x0, str_13
    b cond_end_1703
cond_false_1702:
    adr x0, sign_id
cond_end_1703:
    b cond_end_1701
cond_false_1700:
    adr x0, sign_id
cond_end_1701:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, int_to_str_rec
    str x0, [sp, #-16]!
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1708
do_apply_1709:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1710
do_compose_1708:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1710:
    adr x1, str
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, n
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    add x0, x1, x0
    adr x1, digit
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Append
    cmp x0, #4096
    b.hi do_compose_1711
do_apply_1712:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1713
do_compose_1711:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1713:
    str x0, [sp, #-16]!
    adr x0, digit
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1714
do_apply_1715:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1716
do_compose_1714:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1716:
    str x0, [sp, #-16]!
    adr x0, char
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
    adr x0, to
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
    str x0, [sp, #-16]!
    adr x0, string
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
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Since
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
    str x0, [sp, #-16]!
    adr x0, we
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
    str x0, [sp, #-16]!
    adr x0, don
    str x0, [sp, #-16]!
    adr x0, t
    ldr x1, [sp], #16
    bl _nth
    cmp x0, #4096
    b.hi do_compose_1732
do_apply_1733:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1734
do_compose_1732:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1734:
    str x0, [sp, #-16]!
    adr x0, have
    cmp x0, #4096
    b.hi do_compose_1735
do_apply_1736:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1737
do_compose_1735:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1737:
    str x0, [sp, #-16]!
    adr x0, mutable
    cmp x0, #4096
    b.hi do_compose_1738
do_apply_1739:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1740
do_compose_1738:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1740:
    str x0, [sp, #-16]!
    adr x0, buffer
    cmp x0, #4096
    b.hi do_compose_1741
do_apply_1742:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1743
do_compose_1741:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1743:
    str x0, [sp, #-16]!
    adr x0, easily
    cmp x0, #4096
    b.hi do_compose_1744
do_apply_1745:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1746
do_compose_1744:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1746:
    str x0, [sp, #-16]!
    adr x0, in
    cmp x0, #4096
    b.hi do_compose_1747
do_apply_1748:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1749
do_compose_1747:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1749:
    str x0, [sp, #-16]!
    adr x0, functional
    cmp x0, #4096
    b.hi do_compose_1750
do_apply_1751:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1752
do_compose_1750:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1752:
    str x0, [sp, #-16]!
    adr x0, style
    cmp x0, #4096
    b.hi do_compose_1753
do_apply_1754:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1755
do_compose_1753:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1755:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, we
    cmp x0, #4096
    b.hi do_compose_1756
do_apply_1757:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1758
do_compose_1756:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1758:
    str x0, [sp, #-16]!
    adr x0, might
    cmp x0, #4096
    b.hi do_compose_1759
do_apply_1760:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1761
do_compose_1759:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1761:
    str x0, [sp, #-16]!
    adr x0, recurse
    cmp x0, #4096
    b.hi do_compose_1762
do_apply_1763:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1764
do_compose_1762:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1764:
    str x0, [sp, #-16]!
    adr x0, differently
    cmp x0, #4096
    b.hi do_compose_1765
do_apply_1766:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1767
do_compose_1765:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1767:
    str x0, [sp, #-16]!
    adr x0, or
    cmp x0, #4096
    b.hi do_compose_1768
do_apply_1769:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1770
do_compose_1768:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1770:
    str x0, [sp, #-16]!
    adr x0, stick
    cmp x0, #4096
    b.hi do_compose_1771
do_apply_1772:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1773
do_compose_1771:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1773:
    str x0, [sp, #-16]!
    adr x0, to
    cmp x0, #4096
    b.hi do_compose_1774
do_apply_1775:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1776
do_compose_1774:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1776:
    str x0, [sp, #-16]!
    adr x0, str_cat
    cmp x0, #4096
    b.hi do_compose_1777
do_apply_1778:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1779
do_compose_1777:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1779:
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_1780
do_apply_1781:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1782
do_compose_1780:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1782:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, str_cat
    cmp x0, #4096
    b.hi do_compose_1783
do_apply_1784:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1785
do_compose_1783:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1785:
    str x0, [sp, #-16]!
    adr x0, is
    cmp x0, #4096
    b.hi do_compose_1786
do_apply_1787:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1788
do_compose_1786:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1788:
    str x0, [sp, #-16]!
    adr x0, expensive
    cmp x0, #4096
    b.hi do_compose_1789
do_apply_1790:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1791
do_compose_1789:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1791:
    str x0, [sp, #-16]!
    adr x0, allocs
    cmp x0, #4096
    b.hi do_compose_1792
do_apply_1793:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1794
do_compose_1792:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1794:
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_1795
do_apply_1796:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1797
do_compose_1795:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1797:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Optimization
    cmp x0, #4096
    b.hi do_compose_1800
do_apply_1801:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1802
do_compose_1800:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1802:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1798
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
    b cond_end_1799
cond_false_1798:
    adr x0, sign_id
cond_end_1799:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, For
    cmp x0, #4096
    b.hi do_compose_1805
do_apply_1806:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1807
do_compose_1805:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1807:
    str x0, [sp, #-16]!
    adr x0, now
    cmp x0, #4096
    b.hi do_compose_1808
do_apply_1809:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1810
do_compose_1808:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1810:
    str x0, [sp, #-16]!
    adr x0, use
    str x0, [sp, #-16]!
    adr x0, str_cat
    cmp x0, #4096
    b.hi do_compose_1811
do_apply_1812:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1813
do_compose_1811:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1813:
    str x0, [sp, #-16]!
    adr x0, for
    cmp x0, #4096
    b.hi do_compose_1814
do_apply_1815:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1816
do_compose_1814:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1816:
    str x0, [sp, #-16]!
    adr x0, correctness
    cmp x0, #4096
    b.hi do_compose_1817
do_apply_1818:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1819
do_compose_1817:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1819:
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_1820
do_apply_1821:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1822
do_compose_1820:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1822:
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    cmp x0, #4096
    b.hi do_compose_1823
do_apply_1824:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1825
do_compose_1823:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1825:
    adr x1, char_str
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, char_str
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, digit
    ldr x0, [x0]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, char_str
    ldr x0, [x0]
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
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1826
do_apply_1827:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1828
do_compose_1826:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1828:
    str x0, [sp, #-16]!
    adr x0, char_str
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1829
do_apply_1830:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1831
do_compose_1829:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1831:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_program
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1832
    b after_func_1836_1837
func_1836:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1838
    adr x0, sign_id
    b cmp_end_1839
cmp_true_1838:
cmp_end_1839:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1836_1837:
    // Closure for func_1836
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1836
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1834
    adr x0, str_13
    b cond_end_1835
cond_false_1834:
    adr x0, sign_id
cond_end_1835:
    b cond_end_1833
cond_false_1832:
    adr x0, sign_id
cond_end_1833:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ast
    ldr x0, [x0] // @ load
    adr x1, expr
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Check
    cmp x0, #4096
    b.hi do_compose_1840
do_apply_1841:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1842
do_compose_1840:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1842:
    str x0, [sp, #-16]!
    adr x0, if
    cmp x0, #4096
    b.hi do_compose_1843
do_apply_1844:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1845
do_compose_1843:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1845:
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1846
do_apply_1847:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1848
do_compose_1846:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1848:
    str x0, [sp, #-16]!
    adr x0, is
    cmp x0, #4096
    b.hi do_compose_1849
do_apply_1850:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1851
do_compose_1849:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1851:
    str x0, [sp, #-16]!
    adr x0, definition
    cmp x0, #4096
    b.hi do_compose_1852
do_apply_1853:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1854
do_compose_1852:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1854:
    str x0, [sp, #-16]!
    b after_func_1855_1856
func_1855:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1860_1861
func_1860:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1862_1863
func_1862:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1862_1863:
    // Closure for func_1862
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1862
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1864
do_apply_1865:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1866
do_compose_1864:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1866:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1867
do_apply_1868:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1869
do_compose_1867:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1869:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1860_1861:
    // Closure for func_1860
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1860
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
    b.ne xor_true_1857
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1859
xor_true_1857:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1858
    adr x0, sign_id
    b xor_end_1859
xor_false_1858:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1855_1856:
    // Closure for func_1855
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1855
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1870
do_apply_1871:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1872
do_compose_1870:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1872:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expr
    ldr x0, [x0]
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
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1875
    adr x0, sign_id
    b cmp_end_1876
cmp_true_1875:
cmp_end_1876:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1873
    adr x0, sign_id
    b cond_end_1874
cond_false_1873:
    adr x0, sign_id
cond_end_1874:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, expr
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, op
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1879
do_apply_1880:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1881
do_compose_1879:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1881:
    str x0, [sp, #-16]!
    adr x0, str_9
    cmp x0, #4096
    b.hi do_compose_1882
do_apply_1883:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1884
do_compose_1882:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1884:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1877
    adr x0, sign_id
    b cond_end_1878
cond_false_1877:
    adr x0, sign_id
cond_end_1878:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_global_def
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1885
do_apply_1886:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1887
do_compose_1885:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1887:
    adr x1, code
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, ast
    cmp x0, #4096
    b.hi do_compose_1888
do_apply_1889:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1890
do_compose_1888:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1890:
    cmp x0, #4096
    b.hi do_compose_1891
do_apply_1892:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1893
do_compose_1891:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1893:
    adr x1, rest
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, code
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1894
do_apply_1895:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1896
do_compose_1894:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1896:
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1897
do_apply_1898:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1899
do_compose_1897:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1899:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Skip
    cmp x0, #4096
    b.hi do_compose_1900
do_apply_1901:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1902
do_compose_1900:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1902:
    str x0, [sp, #-16]!
    adr x0, non
    str x0, [sp, #-16]!
    adr x0, definitions
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_1903
do_apply_1904:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1905
do_compose_1903:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1905:
    str x0, [sp, #-16]!
    adr x0, for
    cmp x0, #4096
    b.hi do_compose_1906
do_apply_1907:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1908
do_compose_1906:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1908:
    str x0, [sp, #-16]!
    adr x0, now
    cmp x0, #4096
    b.hi do_compose_1909
do_apply_1910:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1911
do_compose_1909:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1911:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, ast
    cmp x0, #4096
    b.hi do_compose_1912
do_apply_1913:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1914
do_compose_1912:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1914:
    cmp x0, #4096
    b.hi do_compose_1915
do_apply_1916:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1917
do_compose_1915:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1917:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_global_def
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1918
    b after_func_1922_1923
func_1922:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, lhs
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1922_1923:
    // Closure for func_1922
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1922
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1920
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    b cond_end_1921
cond_false_1920:
    adr x0, sign_id
cond_end_1921:
    b cond_end_1919
cond_false_1918:
    adr x0, sign_id
cond_end_1919:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, rhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, lhs
    cmp x0, #4096
    b.hi do_compose_1924
do_apply_1925:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1926
do_compose_1924:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1926:
    str x0, [sp, #-16]!
    adr x0, should
    cmp x0, #4096
    b.hi do_compose_1927
do_apply_1928:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1929
do_compose_1927:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1929:
    str x0, [sp, #-16]!
    adr x0, be
    cmp x0, #4096
    b.hi do_compose_1930
do_apply_1931:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1932
do_compose_1930:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1932:
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1933
do_apply_1934:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1935
do_compose_1933:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1935:
    str x0, [sp, #-16]!
    adr x0, for
    cmp x0, #4096
    b.hi do_compose_1936
do_apply_1937:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1938
do_compose_1936:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1938:
    str x0, [sp, #-16]!
    adr x0, function
    cmp x0, #4096
    b.hi do_compose_1939
do_apply_1940:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1941
do_compose_1939:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1941:
    str x0, [sp, #-16]!
    adr x0, name
    cmp x0, #4096
    b.hi do_compose_1942
do_apply_1943:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1944
do_compose_1942:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1944:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, lhs
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, name
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1945_1946
func_1945:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, for
    str x0, [sp, #-16]!
    adr x0, function
    cmp x0, #4096
    b.hi do_compose_1947
do_apply_1948:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1949
do_compose_1947:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1949:
    str x0, [sp, #-16]!
    adr x0, body
    cmp x0, #4096
    b.hi do_compose_1950
do_apply_1951:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1952
do_compose_1950:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1952:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1945_1946:
    // Closure for func_1945
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1945
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, rhs
    ldr x0, [x0]
    ldr x0, [x0] // @ load
    adr x1, rhs_type
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, rhs_type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1955
    adr x0, sign_id
    b cmp_end_1956
cmp_true_1955:
cmp_end_1956:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1953
    adr x0, sign_id
    b cond_end_1954
cond_false_1953:
    adr x0, sign_id
cond_end_1954:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, rhs
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, op
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1959
do_apply_1960:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1961
do_compose_1959:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1961:
    str x0, [sp, #-16]!
    adr x0, str_7
    cmp x0, #4096
    b.hi do_compose_1962
do_apply_1963:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1964
do_compose_1962:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1964:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1957
    adr x0, sign_id
    b cond_end_1958
cond_false_1957:
    adr x0, sign_id
cond_end_1958:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_function_def
    str x0, [sp, #-16]!
    adr x0, name
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1965
do_apply_1966:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1967
do_compose_1965:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1967:
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1968
do_apply_1969:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1970
do_compose_1968:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1970:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_14
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_function_def
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1971
    b after_func_1973_1974
func_1973:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, node
    cmp x0, #4096
    b.hi do_compose_1975
do_apply_1976:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1977
do_compose_1975:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1977:
    str x0, [sp, #-16]!
    adr x0, is
    cmp x0, #4096
    b.hi do_compose_1978
do_apply_1979:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1980
do_compose_1978:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1980:
    str x0, [sp, #-16]!
    b after_func_1981_1982
func_1981:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, args
    str x0, [sp, #-16]!
    adr x0, body
    cmp x0, #4096
    b.hi do_compose_1983
do_apply_1984:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1985
do_compose_1983:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1985:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1981_1982:
    // Closure for func_1981
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1981
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1986
do_apply_1987:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1988
do_compose_1986:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1988:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1973_1974:
    // Closure for func_1973
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1973
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1972
cond_false_1971:
    adr x0, sign_id
cond_end_1972:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, args_node
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, body_node
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_15
    cmp x0, #4096
    b.hi do_compose_1989
do_apply_1990:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1991
do_compose_1989:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1991:
    str x0, [sp, #-16]!
    adr x0, name
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1992
do_apply_1993:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1994
do_compose_1992:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1994:
    adr x1, label
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1995
do_apply_1996:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1997
do_compose_1995:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1997:
    str x0, [sp, #-16]!
    adr x0, str_16
    cmp x0, #4096
    b.hi do_compose_1998
do_apply_1999:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2000
do_compose_1998:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2000:
    adr x1, label_colon
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Generate
    cmp x0, #4096
    b.hi do_compose_2001
do_apply_2002:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2003
do_compose_2001:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2003:
    str x0, [sp, #-16]!
    adr x0, end
    cmp x0, #4096
    b.hi do_compose_2004
do_apply_2005:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2006
do_compose_2004:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2006:
    str x0, [sp, #-16]!
    adr x0, label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2007
do_apply_2008:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2009
do_compose_2007:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2009:
    str x0, [sp, #-16]!
    adr x0, for
    cmp x0, #4096
    b.hi do_compose_2010
do_apply_2011:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2012
do_compose_2010:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2012:
    str x0, [sp, #-16]!
    adr x0, recursive
    cmp x0, #4096
    b.hi do_compose_2013
do_apply_2014:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2015
do_compose_2013:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2015:
    str x0, [sp, #-16]!
    adr x0, blocks
    cmp x0, #4096
    b.hi do_compose_2016
do_apply_2017:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2018
do_compose_2016:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2018:
    str x0, [sp, #-16]!
    adr x0, to
    cmp x0, #4096
    b.hi do_compose_2019
do_apply_2020:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2021
do_compose_2019:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2021:
    str x0, [sp, #-16]!
    adr x0, jump
    cmp x0, #4096
    b.hi do_compose_2022
do_apply_2023:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2024
do_compose_2022:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2024:
    str x0, [sp, #-16]!
    adr x0, to
    cmp x0, #4096
    b.hi do_compose_2025
do_apply_2026:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2027
do_compose_2025:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2027:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2028
do_apply_2029:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2030
do_compose_2028:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2030:
    str x0, [sp, #-16]!
    adr x0, str_17
    cmp x0, #4096
    b.hi do_compose_2031
do_apply_2032:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2033
do_compose_2031:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2033:
    adr x1, end_label
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    str x0, [sp, #-16]!
    adr x0, body_node
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2034
do_apply_2035:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2036
do_compose_2034:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2036:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2037
do_apply_2038:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2039
do_compose_2037:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2039:
    adr x1, body_code
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2040
do_apply_2041:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2042
do_compose_2040:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2042:
    str x0, [sp, #-16]!
    adr x0, str_18
    cmp x0, #4096
    b.hi do_compose_2043
do_apply_2044:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2045
do_compose_2043:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2045:
    adr x1, ret_label
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, label_colon
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2046
do_apply_2047:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2048
do_compose_2046:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2048:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, body_code
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2049
do_apply_2050:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2051
do_compose_2049:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2051:
    str x0, [sp, #-16]!
    adr x0, ret_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2052
do_apply_2053:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2054
do_compose_2052:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2054:
    cmp x0, #4096
    b.hi do_compose_2055
do_apply_2056:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2057
do_compose_2055:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2057:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2058
    b after_func_2062_2063
func_2062:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2064
    adr x0, sign_id
    b cmp_end_2065
cmp_true_2064:
cmp_end_2065:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2062_2063:
    // Closure for func_2062
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2062
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2060
    adr x0, str_13
    b cond_end_2061
cond_false_2060:
    adr x0, sign_id
cond_end_2061:
    b cond_end_2059
cond_false_2058:
    adr x0, sign_id
cond_end_2059:
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
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2068
    adr x0, sign_id
    b cmp_end_2069
cmp_true_2068:
cmp_end_2069:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2066
    adr x0, sign_id
    b cond_end_2067
cond_false_2066:
    adr x0, sign_id
cond_end_2067:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, int_to_str
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2070
do_apply_2071:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2072
do_compose_2070:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2072:
    adr x1, s_val
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_19
    cmp x0, #4096
    b.hi do_compose_2073
do_apply_2074:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2075
do_compose_2073:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2075:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, s_val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2076
do_apply_2077:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2078
do_compose_2076:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2078:
    str x0, [sp, #-16]!
    adr x0, str_20
    cmp x0, #4096
    b.hi do_compose_2079
do_apply_2080:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2081
do_compose_2079:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2081:
    cmp x0, #4096
    b.hi do_compose_2082
do_apply_2083:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2084
do_compose_2082:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2084:
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
    b.eq cmp_true_2087
    adr x0, sign_id
    b cmp_end_2088
cmp_true_2087:
cmp_end_2088:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2085
    adr x0, sign_id
    b cond_end_2086
cond_false_2085:
    adr x0, sign_id
cond_end_2086:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_block
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2089
do_apply_2090:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2091
do_compose_2089:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2091:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2092
do_apply_2093:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2094
do_compose_2092:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2094:
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
    b.eq cmp_true_2097
    adr x0, sign_id
    b cmp_end_2098
cmp_true_2097:
cmp_end_2098:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2095
    adr x0, sign_id
    b cond_end_2096
cond_false_2095:
    adr x0, sign_id
cond_end_2096:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_infix
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2099
do_apply_2100:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2101
do_compose_2099:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2101:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2102
do_apply_2103:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2104
do_compose_2102:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2104:
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
    b.eq cmp_true_2107
    adr x0, sign_id
    b cmp_end_2108
cmp_true_2107:
cmp_end_2108:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2105
    adr x0, sign_id
    b cond_end_2106
cond_false_2105:
    adr x0, sign_id
cond_end_2106:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_apply
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2109
do_apply_2110:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2111
do_compose_2109:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2111:
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
    b.eq cmp_true_2114
    adr x0, sign_id
    b cmp_end_2115
cmp_true_2114:
cmp_end_2115:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2112
    adr x0, sign_id
    b cond_end_2113
cond_false_2112:
    adr x0, sign_id
cond_end_2113:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_id
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2116
do_apply_2117:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2118
do_compose_2116:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2118:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_13
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_id
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2119
    b after_func_2123_2124
func_2123:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, label
    ldr x0, [x0]
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2121
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_15
    cmp x0, #4096
    b.hi do_compose_2125
do_apply_2126:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2127
do_compose_2125:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2127:
    str x0, [sp, #-16]!
    adr x0, name
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2128
do_apply_2129:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2130
do_compose_2128:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2130:
    b cond_end_2122
cond_false_2121:
    adr x0, sign_id
cond_end_2122:
    b cond_end_2120
cond_false_2119:
    adr x0, sign_id
cond_end_2120:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_21
    adr x1, load_env
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_22
    cmp x0, #4096
    b.hi do_compose_2131
do_apply_2132:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2133
do_compose_2131:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2133:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2134
do_apply_2135:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2136
do_compose_2134:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2136:
    str x0, [sp, #-16]!
    adr x0, str_20
    cmp x0, #4096
    b.hi do_compose_2137
do_apply_2138:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2139
do_compose_2137:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2139:
    cmp x0, #4096
    b.hi do_compose_2140
do_apply_2141:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2142
do_compose_2140:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2142:
    adr x1, load_code
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_23
    adr x1, make_cons
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, load_env
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2143
do_apply_2144:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2145
do_compose_2143:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2145:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, load_code
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2146
do_apply_2147:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2148
do_compose_2146:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2148:
    str x0, [sp, #-16]!
    adr x0, make_cons
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2149
do_apply_2150:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2151
do_compose_2149:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2151:
    cmp x0, #4096
    b.hi do_compose_2152
do_apply_2153:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2154
do_compose_2152:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2154:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_apply
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2155
    b after_func_2159_2160
func_2159:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, func
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2159_2160:
    // Closure for func_2159
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2159
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2157
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    b cond_end_2158
cond_false_2157:
    adr x0, sign_id
cond_end_2158:
    b cond_end_2156
cond_false_2155:
    adr x0, sign_id
cond_end_2156:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, arg
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    str x0, [sp, #-16]!
    adr x0, func
    cmp x0, #4096
    b.hi do_compose_2161
do_apply_2162:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2163
do_compose_2161:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2163:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2164
do_apply_2165:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2166
do_compose_2164:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2166:
    adr x1, code_f
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    str x0, [sp, #-16]!
    adr x0, arg
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2167
do_apply_2168:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2169
do_compose_2167:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2169:
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2170
do_apply_2171:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2172
do_compose_2170:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2172:
    adr x1, code_a
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_24
    adr x1, push_f
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_25
    adr x1, pop_f
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_26
    adr x1, load_code
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_27
    adr x1, load_env
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_28
    adr x1, call
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, code_f
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2173
do_apply_2174:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2175
do_compose_2173:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2175:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, push_f
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2176
do_apply_2177:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2178
do_compose_2176:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2178:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, code_a
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2179
do_apply_2180:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2181
do_compose_2179:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2181:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, pop_f
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2182
do_apply_2183:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2184
do_compose_2182:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2184:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, load_code
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2185
do_apply_2186:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2187
do_compose_2185:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2187:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, load_env
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2188
do_apply_2189:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2190
do_compose_2188:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2190:
    str x0, [sp, #-16]!
    adr x0, call
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2191
do_apply_2192:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2193
do_compose_2191:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2193:
    cmp x0, #4096
    b.hi do_compose_2194
do_apply_2195:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2196
do_compose_2194:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2196:
    cmp x0, #4096
    b.hi do_compose_2197
do_apply_2198:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2199
do_compose_2197:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2199:
    cmp x0, #4096
    b.hi do_compose_2200
do_apply_2201:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2202
do_compose_2200:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2202:
    cmp x0, #4096
    b.hi do_compose_2203
do_apply_2204:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2205
do_compose_2203:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2205:
    cmp x0, #4096
    b.hi do_compose_2206
do_apply_2207:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2208
do_compose_2206:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2208:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_infix
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2209
    b after_func_2213_2214
func_2213:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2213_2214:
    // Closure for func_2213
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2213
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2211
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    b cond_end_2212
cond_false_2211:
    adr x0, sign_id
cond_end_2212:
    b cond_end_2210
cond_false_2209:
    adr x0, sign_id
cond_end_2210:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, lhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, node
    str x0, [sp, #-16]!
    mov x0, #24
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x0, [x0] // @ load
    adr x1, rhs
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2215
do_apply_2216:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2217
do_compose_2215:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2217:
    str x0, [sp, #-16]!
    adr x0, str_9
    cmp x0, #4096
    b.hi do_compose_2218
do_apply_2219:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2220
do_compose_2218:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2220:
    adr x1, is_match
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x1, is_match
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, ;
    str x0, [sp, #-16]!
    adr x0, Match
    cmp x0, #4096
    b.hi do_compose_2223
do_apply_2224:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2225
do_compose_2223:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2225:
    str x0, [sp, #-16]!
    adr x0, Case
    cmp x0, #4096
    b.hi do_compose_2226
do_apply_2227:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2228
do_compose_2226:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2228:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2221
    adr x0, val
    ldr x0, [x0]
    adr x1, cond
    str x0, [x1]
    adr x0, sign_id
    b cond_end_2222
cond_false_2221:
    adr x0, sign_id
cond_end_2222:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2229
do_apply_2230:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2231
do_compose_2229:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2231:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2232
do_apply_2233:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2234
do_compose_2232:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2234:
    adr x1, cond_code
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2235
do_apply_2236:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2237
do_compose_2235:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2237:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2238
do_apply_2239:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2240
do_compose_2238:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2240:
    adr x1, val_code
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_29
    adr x1, check
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, val_code
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2241
do_apply_2242:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2243
do_compose_2241:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2243:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, str_30
    cmp x0, #4096
    b.hi do_compose_2244
do_apply_2245:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2246
do_compose_2244:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2246:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2247
do_apply_2248:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2249
do_compose_2247:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2249:
    str x0, [sp, #-16]!
    adr x0, str_20
    cmp x0, #4096
    b.hi do_compose_2250
do_apply_2251:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2252
do_compose_2250:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2252:
    cmp x0, #4096
    b.hi do_compose_2253
do_apply_2254:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2255
do_compose_2253:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2255:
    cmp x0, #4096
    b.hi do_compose_2256
do_apply_2257:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2258
do_compose_2256:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2258:
    adr x1, docase
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_31
    adr x1, next
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, cond_code
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2259
do_apply_2260:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2261
do_compose_2259:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2261:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, check
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2262
do_apply_2263:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2264
do_compose_2262:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2264:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, docase
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2265
do_apply_2266:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2267
do_compose_2265:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2267:
    str x0, [sp, #-16]!
    adr x0, next
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2268
do_apply_2269:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2270
do_compose_2268:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2270:
    cmp x0, #4096
    b.hi do_compose_2271
do_apply_2272:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2273
do_compose_2271:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2273:
    cmp x0, #4096
    b.hi do_compose_2274
do_apply_2275:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2276
do_compose_2274:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2276:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, is_match
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2279
    adr x0, sign_id
    b cmp_end_2280
cmp_true_2279:
cmp_end_2280:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2277
    adr x0, sign_id
    b cond_end_2278
cond_false_2277:
    adr x0, sign_id
cond_end_2278:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    str x0, [sp, #-16]!
    adr x0, lhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2281
do_apply_2282:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2283
do_compose_2281:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2283:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2284
do_apply_2285:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2286
do_compose_2284:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2286:
    adr x1, code_l
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    str x0, [sp, #-16]!
    adr x0, rhs
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2287
do_apply_2288:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2289
do_compose_2287:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2289:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2290
do_apply_2291:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2292
do_compose_2290:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2292:
    adr x1, code_r
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_24
    adr x1, push_x0
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_32
    adr x1, pop_x1
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit_op
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2293
do_apply_2294:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2295
do_compose_2293:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2295:
    adr x1, op_code
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, code_l
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2296
do_apply_2297:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2298
do_compose_2296:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2298:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, push_x0
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2299
do_apply_2300:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2301
do_compose_2299:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2301:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, code_r
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2302
do_apply_2303:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2304
do_compose_2302:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2304:
    str x0, [sp, #-16]!
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, pop_x1
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2305
do_apply_2306:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2307
do_compose_2305:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2307:
    str x0, [sp, #-16]!
    adr x0, op_code
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2308
do_apply_2309:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2310
do_compose_2308:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2310:
    cmp x0, #4096
    b.hi do_compose_2311
do_apply_2312:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2313
do_compose_2311:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2313:
    cmp x0, #4096
    b.hi do_compose_2314
do_apply_2315:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2316
do_compose_2314:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2316:
    cmp x0, #4096
    b.hi do_compose_2317
do_apply_2318:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2319
do_compose_2317:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2319:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, emit_op
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2320
    b after_func_2324_2325
func_2324:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_2326
do_apply_2327:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2328
do_compose_2326:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2328:
    str x0, [sp, #-16]!
    adr x0, str_3
    cmp x0, #4096
    b.hi do_compose_2329
do_apply_2330:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2331
do_compose_2329:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2331:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2324_2325:
    // Closure for func_2324
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2324
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2322
    adr x0, str_33
    b cond_end_2323
cond_false_2322:
    adr x0, sign_id
cond_end_2323:
    b cond_end_2321
cond_false_2320:
    adr x0, sign_id
cond_end_2321:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2334
do_apply_2335:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2336
do_compose_2334:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2336:
    str x0, [sp, #-16]!
    adr x0, str_4
    cmp x0, #4096
    b.hi do_compose_2337
do_apply_2338:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2339
do_compose_2337:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2339:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2332
    adr x0, str_34
    b cond_end_2333
cond_false_2332:
    adr x0, sign_id
cond_end_2333:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2342
do_apply_2343:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2344
do_compose_2342:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2344:
    str x0, [sp, #-16]!
    adr x0, str_0
    cmp x0, #4096
    b.hi do_compose_2345
do_apply_2346:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2347
do_compose_2345:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2347:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2340
    adr x0, str_35
    b cond_end_2341
cond_false_2340:
    adr x0, sign_id
cond_end_2341:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2350
do_apply_2351:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2352
do_compose_2350:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2352:
    str x0, [sp, #-16]!
    adr x0, str_36
    cmp x0, #4096
    b.hi do_compose_2353
do_apply_2354:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2355
do_compose_2353:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2355:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2348
    adr x0, str_37
    b cond_end_2349
cond_false_2348:
    adr x0, sign_id
cond_end_2349:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_38
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_block
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2356
    b after_func_2360_2361
func_2360:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2362
    adr x0, sign_id
    b cmp_end_2363
cmp_true_2362:
cmp_end_2363:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2360_2361:
    // Closure for func_2360
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2360
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2358
    adr x0, str_13
    b cond_end_2359
cond_false_2358:
    adr x0, sign_id
cond_end_2359:
    b cond_end_2357
cond_false_2356:
    adr x0, sign_id
cond_end_2357:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, exprs
    ldr x0, [x0] // @ load
    adr x1, expr
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_expr
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2364
do_apply_2365:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2366
do_compose_2364:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2366:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2367
do_apply_2368:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2369
do_compose_2367:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2369:
    adr x1, code
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_block
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, exprs
    cmp x0, #4096
    b.hi do_compose_2370
do_apply_2371:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2372
do_compose_2370:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2372:
    cmp x0, #4096
    b.hi do_compose_2373
do_apply_2374:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2375
do_compose_2373:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2375:
    str x0, [sp, #-16]!
    adr x0, end_label
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2376
do_apply_2377:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2378
do_compose_2376:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2378:
    adr x1, rest
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_cat
    str x0, [sp, #-16]!
    adr x0, code
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2379
do_apply_2380:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2381
do_compose_2379:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2381:
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2382
do_apply_2383:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2384
do_compose_2382:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2384:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, main
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2385
    b after_func_2389_2390
func_2389:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, src
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2389_2390:
    // Closure for func_2389
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2389
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2387
    adr x0, str_39
    b cond_end_2388
cond_false_2387:
    adr x0, sign_id
cond_end_2388:
    b cond_end_2386
cond_false_2385:
    adr x0, sign_id
cond_end_2386:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, str_40
    cmp x0, #4096
    b.hi do_compose_2391
do_apply_2392:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2393
do_compose_2391:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2393:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, src
    cmp x0, #4096
    b.hi do_compose_2394
do_apply_2395:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2396
do_compose_2394:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2396:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_2397
do_apply_2398:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2399
do_compose_2397:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2399:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, init_lexer
    str x0, [sp, #-16]!
    adr x0, src
    cmp x0, #4096
    b.hi do_compose_2400
do_apply_2401:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2402
do_compose_2400:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2402:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, tokenize
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2403
do_apply_2404:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2405
do_compose_2403:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2405:
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
    b.hi do_compose_2406
do_apply_2407:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2408
do_compose_2406:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2408:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, parse_program
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_2409
do_apply_2410:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2411
do_compose_2409:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2411:
    adr x1, ast
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_program
    str x0, [sp, #-16]!
    adr x0, ast
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2412
do_apply_2413:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2414
do_compose_2412:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2414:
    adr x1, asm
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, asm
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_2415
do_apply_2416:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_2417
do_compose_2415:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_2417:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, compile_program
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2418
    b after_func_2420_2421
func_2420:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_41
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2420_2421:
    // Closure for func_2420
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2420
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2419
cond_false_2418:
    adr x0, sign_id
cond_end_2419:
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
expr: .quad 0
rest: .quad 0
rhs: .quad 0
new_lhs: .quad 0
op: .quad 0
prec: .quad 0
next_min_prec: .quad 0
v: .quad 0
len2: .quad 0
new_s: .quad 0
end_s1: .quad 0
digit: .quad 0
char_str: .quad 0
code: .quad 0
name: .quad 0
rhs_type: .quad 0
args_node: .quad 0
body_node: .quad 0
label: .quad 0
label_colon: .quad 0
end_label: .quad 0
body_code: .quad 0
ret_label: .quad 0
val: .quad 0
s_val: .quad 0
load_env: .quad 0
load_code: .quad 0
make_cons: .quad 0
arg: .quad 0
code_f: .quad 0
code_a: .quad 0
push_f: .quad 0
pop_f: .quad 0
call: .quad 0
lhs: .quad 0
is_match: .quad 0
cond: .quad 0
cond_code: .quad 0
val_code: .quad 0
check: .quad 0
docase: .quad 0
next: .quad 0
code_l: .quad 0
code_r: .quad 0
push_x0: .quad 0
pop_x1: .quad 0
op_code: .quad 0
tokens: .quad 0
ast: .quad 0
asm: .quad 0


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

