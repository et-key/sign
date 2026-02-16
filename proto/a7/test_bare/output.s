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
    adr x1, heap_ptr
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_7
    b after_func_9_10
func_9:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, heap_ptr
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_11
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_11
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_11
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #16
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, heap_ptr
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_11
    ldr x0, [x29, #-48]
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
    adr x0, head
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_12
    b after_func_14_15
func_14:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_16_17
func_16:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_21_22
func_21:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_23_24
func_23:
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
after_func_23_24:
    // Closure for func_23
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_23
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_28
do_apply_29:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_30
do_compose_28:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_30:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_21_22:
    // Closure for func_21
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_21
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
    b.ne xor_true_18
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_20
xor_true_18:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_19
    adr x0, sign_id
    b xor_end_20
xor_false_19:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_16_17:
    // Closure for func_16
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_16
    ldr x0, [sp], #16
    bl _cons
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
    adr x0, tail
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_31
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_40_41
func_40:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_42_43
func_42:
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
after_func_42_43:
    // Closure for func_42
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_42
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_44
do_apply_45:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_46
do_compose_44:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_46:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_40_41:
    // Closure for func_40
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_40
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
    b.ne xor_true_37
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_39
xor_true_37:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_38
    adr x0, sign_id
    b xor_end_39
xor_false_38:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_35_36:
    // Closure for func_35
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    b cond_end_32
cond_false_31:
    adr x0, sign_id
cond_end_32:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, nth
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_50
    b after_func_52_53
func_52:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, index
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_57
    adr x0, sign_id
    b cmp_end_58
cmp_true_57:
cmp_end_58:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_55
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_59
do_apply_60:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_61
do_compose_59:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_61:
    b cond_end_56
cond_false_55:
    adr x0, sign_id
cond_end_56:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_54
    adr x0, nth
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_62
do_apply_63:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_64
do_compose_62:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_64:
    cmp x0, #4096
    b.hi do_compose_65
do_apply_66:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_67
do_compose_65:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_67:
    str x0, [sp, #-16]!
    adr x0, index
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    sub x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_68
do_apply_69:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_70
do_compose_68:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_70:
blk_end_54:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_52_53:
    // Closure for func_52
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_52
    ldr x0, [sp], #16
    bl _cons
    b cond_end_51
cond_false_50:
    adr x0, sign_id
cond_end_51:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, factorial
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_71
    b after_func_73_74
func_73:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_78
    adr x0, sign_id
    b cmp_end_79
cmp_true_78:
cmp_end_79:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_76
    mov x0, #1
    b cond_end_77
cond_false_76:
    adr x0, sign_id
cond_end_77:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_75
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
    b cond_end_72
cond_false_71:
    adr x0, sign_id
cond_end_72:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, range
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_83
    b after_func_85_86
func_85:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, end
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_90
    adr x0, sign_id
    b cmp_end_91
cmp_true_90:
cmp_end_91:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_88
    mov x0, #0
    b cond_end_89
cond_false_88:
    adr x0, sign_id
cond_end_89:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_87
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, range
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    adr x0, end
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
blk_end_87:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_85_86:
    // Closure for func_85
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_85
    ldr x0, [sp], #16
    bl _cons
    b cond_end_84
cond_false_83:
    adr x0, sign_id
cond_end_84:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_104
    b after_func_106_107
func_106:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, cons
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_112
do_apply_113:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_114
do_compose_112:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_114:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_108
    mov x0,     adr x0, _sys_write

    str x0, [sp, #-16]!
    mov x0, #1
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_121
do_apply_122:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_123
do_compose_121:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_123:
blk_end_108:
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
    b cond_end_105
cond_false_104:
    adr x0, sign_id
cond_end_105:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_124
    b after_func_126_127
func_126:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_len_impl_129
len_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_133_134
func_133:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_135_136
func_135:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_137_138
func_137:
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
after_func_137_138:
    // Closure for func_137
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_137
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_135_136:
    // Closure for func_135
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_135
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_130
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_132
xor_true_130:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_131
    adr x0, sign_id
    b xor_end_132
xor_false_131:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_len_impl_129:
    // Closure for len_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, len_impl
    ldr x0, [sp], #16
    bl _cons
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_128
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_147
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_147
    ldr x0, [x29, #-48]
    ldr x0, [x0] // @ load
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_147
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    mov x0, #0
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
    b.eq cond_false_148
    ldr x0, [x29, #-64]
    b cond_end_149
cond_false_148:
    adr x0, sign_id
cond_end_149:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_147
    adr x0, len_loop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    cmp x0, #4096
    b.hi do_compose_155
do_apply_156:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_157
do_compose_155:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_157:
blk_end_147:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_128
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    cmp x0, #4096
    b.hi do_compose_158
do_apply_159:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_160
do_compose_158:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_160:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_128
    mov x0,     adr x0, _sys_write

    str x0, [sp, #-16]!
    mov x0, #1
    cmp x0, #4096
    b.hi do_compose_161
do_apply_162:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_163
do_compose_161:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_163:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    adr x0, len
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
blk_end_128:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_126_127:
    // Closure for func_126
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_126
    ldr x0, [sp], #16
    bl _cons
    b cond_end_125
cond_false_124:
    adr x0, sign_id
cond_end_125:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, add
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_170
    b after_func_172_173
func_172:
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
after_func_172_173:
    // Closure for func_172
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_172
    ldr x0, [sp], #16
    bl _cons
    b cond_end_171
cond_false_170:
    adr x0, sign_id
cond_end_171:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sub
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_174
    b after_func_176_177
func_176:
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
after_func_176_177:
    // Closure for func_176
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_176
    ldr x0, [sp], #16
    bl _cons
    b cond_end_175
cond_false_174:
    adr x0, sign_id
cond_end_175:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, mul
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
    mul x0, x1, x0
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
    adr x0, div
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
    sdiv x0, x1, x0
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
    adr x0, mod
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
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
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
    adr x0, Sign
    str x0, [sp, #-16]!
    adr x0, Language
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
    adr x0, Operator
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
    str x0, [sp, #-16]!
    adr x0, Table
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
    adr x0, operator
    str x0, [sp, #-16]!
    adr x0, .
    cmp x0, #4096
    b.hi do_compose_199
do_apply_200:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_201
do_compose_199:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_201:
    str x0, [sp, #-16]!
    adr x0, sn
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
    b.ne blk_end_0
    adr x0, Wraps
    str x0, [sp, #-16]!
    adr x0, standard
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
    adr x0, operators
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
    adr x0, as
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
    adr x0, first
    str x0, [sp, #-16]!
    adr x0, class
    ldr x1, [sp], #16
    sub x0, x1, x0
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
    adr x0, functions
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
    adr x0, using
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
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, syntax
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
    adr x0, .
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
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, A_Operator_Table
    str x0, [sp, #-16]!
    adr x0, .
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
    adr x0, md
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
    adr x1, Reference
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_240_241
func_240:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_245_246
func_245:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_247_248
func_247:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_249_250
func_249:
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
after_func_249_250:
    // Closure for func_249
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_249
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_247_248:
    // Closure for func_247
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_247
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_242
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_244
xor_true_242:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_243
    adr x0, sign_id
    b xor_end_244
xor_false_243:
    mov x0, x1
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
    b.eq cond_false_238
    b after_func_259_260
func_259:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
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
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b.ne blk_end_261
    b after_func_269_270
func_269:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, h
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_268
    b after_func_271_272
func_271:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    adr x0, y
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
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_271_272:
    // Closure for func_271
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_271
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_268
    b after_func_280_281
func_280:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, h
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, t
    ldr x1, [sp], #16
    add x0, x1, x0
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_280_281:
    // Closure for func_280
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_280
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_279
    b after_func_282_283
func_282:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    add x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_282_283:
    // Closure for func_282
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_282
    ldr x0, [sp], #16
    bl _cons
blk_end_279:
blk_end_268:
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
    b cond_end_239
cond_false_238:
    adr x0, sign_id
cond_end_239:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_286_287
func_286:
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
    b after_func_295_296
func_295:
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
after_func_295_296:
    // Closure for func_295
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_295
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    b after_func_303_304
func_303:
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
after_func_303_304:
    // Closure for func_303
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_303
    ldr x0, [sp], #16
    bl _cons
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
after_func_286_287:
    // Closure for func_286
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_286
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_284
    b after_func_305_306
func_305:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b.ne blk_end_307
    b after_func_315_316
func_315:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, h
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    b after_func_317_318
func_317:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    adr x0, y
    cmp x0, #4096
    b.hi do_compose_319
do_apply_320:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_321
do_compose_319:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_321:
    str x0, [sp, #-16]!
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_322
do_apply_323:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_324
do_compose_322:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_324:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_317_318:
    // Closure for func_317
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_317
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_314
    b after_func_326_327
func_326:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, h
    ldr x1, [sp], #16
    sub x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, t
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_326_327:
    // Closure for func_326
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_326
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_325
    b after_func_328_329
func_328:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sub x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_328_329:
    // Closure for func_328
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_328
    ldr x0, [sp], #16
    bl _cons
blk_end_325:
blk_end_314:
blk_end_307:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_305_306:
    // Closure for func_305
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_305
    ldr x0, [sp], #16
    bl _cons
    b cond_end_285
cond_false_284:
    adr x0, sign_id
cond_end_285:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_332_333
func_332:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_337_338
func_337:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_339_340
func_339:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_341_342
func_341:
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
after_func_341_342:
    // Closure for func_341
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_341
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_339_340:
    // Closure for func_339
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_339
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_343
do_apply_344:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_345
do_compose_343:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_345:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_346
do_apply_347:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_348
do_compose_346:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_348:
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
    str x0, [sp, #-16]!
    b after_func_349_350
func_349:
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
after_func_349_350:
    // Closure for func_349
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_349
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_334
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_336
xor_true_334:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_335
    adr x0, sign_id
    b xor_end_336
xor_false_335:
    mov x0, x1
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
    b.eq cond_false_330
    b after_func_351_352
func_351:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_353
    b after_func_361_362
func_361:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, h
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_361_362:
    // Closure for func_361
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_361
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_360
    b after_func_363_364
func_363:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    adr x0, y
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
    adr x0, sign_id
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_363_364:
    // Closure for func_363
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_363
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_360
    b after_func_372_373
func_372:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, h
    ldr x1, [sp], #16
    mul x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, t
    ldr x1, [sp], #16
    mul x0, x1, x0
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_372_373:
    // Closure for func_372
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_372
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_371
    b after_func_374_375
func_374:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    mul x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_374_375:
    // Closure for func_374
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_374
    ldr x0, [sp], #16
    bl _cons
blk_end_371:
blk_end_360:
blk_end_353:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_351_352:
    // Closure for func_351
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_351
    ldr x0, [sp], #16
    bl _cons
    b cond_end_331
cond_false_330:
    adr x0, sign_id
cond_end_331:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_378_379
func_378:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_383_384
func_383:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_385_386
func_385:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_387_388
func_387:
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
after_func_387_388:
    // Closure for func_387
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_387
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_385_386:
    // Closure for func_385
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_385
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_392
do_apply_393:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_394
do_compose_392:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_394:
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
    str x0, [sp, #-16]!
    b after_func_395_396
func_395:
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
after_func_395_396:
    // Closure for func_395
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_395
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_380
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_382
xor_true_380:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_381
    adr x0, sign_id
    b xor_end_382
xor_false_381:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_378_379:
    // Closure for func_378
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_378
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_376
    b after_func_397_398
func_397:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
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
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b.ne blk_end_399
    b after_func_407_408
func_407:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, h
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x1, [sp], #16
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_406
    b after_func_409_410
func_409:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    adr x0, y
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
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_406
    b after_func_418_419
func_418:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, h
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, t
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_418_419:
    // Closure for func_418
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_418
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_417
    b after_func_420_421
func_420:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_420_421:
    // Closure for func_420
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_420
    ldr x0, [sp], #16
    bl _cons
blk_end_417:
blk_end_406:
blk_end_399:
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
    b cond_end_377
cond_false_376:
    adr x0, sign_id
cond_end_377:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_424_425
func_424:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_429_430
func_429:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_431_432
func_431:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_433_434
func_433:
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
after_func_433_434:
    // Closure for func_433
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_433
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_431_432:
    // Closure for func_431
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_431
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_429_430:
    // Closure for func_429
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_429
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_441_442
func_441:
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
after_func_441_442:
    // Closure for func_441
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_441
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_426
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_428
xor_true_426:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_427
    adr x0, sign_id
    b xor_end_428
xor_false_427:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_424_425:
    // Closure for func_424
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_424
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_422
    b after_func_443_444
func_443:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_445
    b after_func_453_454
func_453:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, h
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    str x0, [sp, #-16]!
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_453_454:
    // Closure for func_453
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_453
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_452
    b after_func_455_456
func_455:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    adr x0, y
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
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_452
    b after_func_464_465
func_464:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, h
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, t
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
    ldr x1, [sp], #16
    bl _cons
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_463
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
    adr x0, y
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
blk_end_463:
blk_end_452:
blk_end_445:
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
    b cond_end_423
cond_false_422:
    adr x0, sign_id
cond_end_423:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_470_471
func_470:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_475_476
func_475:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_477_478
func_477:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_479_480
func_479:
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
after_func_479_480:
    // Closure for func_479
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_479
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_477_478:
    // Closure for func_477
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_477
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_475_476:
    // Closure for func_475
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_475
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_487_488
func_487:
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
after_func_487_488:
    // Closure for func_487
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_487
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_472
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_474
xor_true_472:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_473
    adr x0, sign_id
    b xor_end_474
xor_false_473:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_470_471:
    // Closure for func_470
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_470
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_468
    b after_func_489_490
func_489:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_491
    b after_func_499_500
func_499:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x0, h
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    bl _pow
    str x0, [sp, #-16]!
    adr x0, t
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    bl _pow
    ldr x1, [sp], #16
    bl _cons
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
    b.ne blk_end_498
    b after_func_501_502
func_501:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, match
    str x0, [sp, #-16]!
    adr x0, y
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
    adr x0, sign_id
    cmp x0, #4096
    b.hi do_compose_506
do_apply_507:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_508
do_compose_506:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_508:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_498
    b after_func_510_511
func_510:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, h
    ldr x1, [sp], #16
    bl _pow
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, t
    ldr x1, [sp], #16
    bl _pow
    ldr x1, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_510_511:
    // Closure for func_510
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_510
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_509
    b after_func_512_513
func_512:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    bl _pow
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_512_513:
    // Closure for func_512
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_512
    ldr x0, [sp], #16
    bl _cons
blk_end_509:
blk_end_498:
blk_end_491:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_489_490:
    // Closure for func_489
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_489
    ldr x0, [sp], #16
    bl _cons
    b cond_end_469
cond_false_468:
    adr x0, sign_id
cond_end_469:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_516_517
func_516:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_521_522
func_521:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_523_524
func_523:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_525_526
func_525:
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
    b.lt cmp_true_527
    adr x0, sign_id
    b cmp_end_528
cmp_true_527:
cmp_end_528:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_525_526:
    // Closure for func_525
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_525
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_529
do_apply_530:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_531
do_compose_529:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_531:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_532
do_apply_533:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_534
do_compose_532:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_534:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_537
    adr x0, sign_id
    b cmp_end_538
cmp_true_537:
cmp_end_538:
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
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_518
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_520
xor_true_518:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_519
    adr x0, sign_id
    b xor_end_520
xor_false_519:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_516_517:
    // Closure for func_516
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_516
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_514
    b after_func_539_540
func_539:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_541
    adr x0, sign_id
    b cmp_end_542
cmp_true_541:
cmp_end_542:
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
    b cond_end_515
cond_false_514:
    adr x0, sign_id
cond_end_515:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_545_546
func_545:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_550_551
func_550:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
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
    b.le cmp_true_556
    adr x0, sign_id
    b cmp_end_557
cmp_true_556:
cmp_end_557:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_554_555:
    // Closure for func_554
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_564_565
func_564:
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
    b.le cmp_true_566
    adr x0, sign_id
    b cmp_end_567
cmp_true_566:
cmp_end_567:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_564_565:
    // Closure for func_564
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_564
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_547
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_549
xor_true_547:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_548
    adr x0, sign_id
    b xor_end_549
xor_false_548:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_545_546:
    // Closure for func_545
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_545
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_543
    b after_func_568_569
func_568:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le cmp_true_570
    adr x0, sign_id
    b cmp_end_571
cmp_true_570:
cmp_end_571:
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
    b cond_end_544
cond_false_543:
    adr x0, sign_id
cond_end_544:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_574_575
func_574:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_579_580
func_579:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_581_582
func_581:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_583_584
func_583:
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
    b.gt cmp_true_585
    adr x0, sign_id
    b cmp_end_586
cmp_true_585:
cmp_end_586:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_583_584:
    // Closure for func_583
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_583
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_581_582:
    // Closure for func_581
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_581
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_579_580:
    // Closure for func_579
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_579
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_593_594
func_593:
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
    b.gt cmp_true_595
    adr x0, sign_id
    b cmp_end_596
cmp_true_595:
cmp_end_596:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_593_594:
    // Closure for func_593
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_593
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_576
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_578
xor_true_576:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_577
    adr x0, sign_id
    b xor_end_578
xor_false_577:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_574_575:
    // Closure for func_574
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_574
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_572
    b after_func_597_598
func_597:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_599
    adr x0, sign_id
    b cmp_end_600
cmp_true_599:
cmp_end_600:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_597_598:
    // Closure for func_597
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_597
    ldr x0, [sp], #16
    bl _cons
    b cond_end_573
cond_false_572:
    adr x0, sign_id
cond_end_573:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_603_604
func_603:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_608_609
func_608:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_610_611
func_610:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_612_613
func_612:
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
    b.ge cmp_true_614
    adr x0, sign_id
    b cmp_end_615
cmp_true_614:
cmp_end_615:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_612_613:
    // Closure for func_612
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_612
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
after_func_608_609:
    // Closure for func_608
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_608
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_622_623
func_622:
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
    b.ge cmp_true_624
    adr x0, sign_id
    b cmp_end_625
cmp_true_624:
cmp_end_625:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_622_623:
    // Closure for func_622
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_622
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_605
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_607
xor_true_605:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_606
    adr x0, sign_id
    b xor_end_607
xor_false_606:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_601
    b after_func_626_627
func_626:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge cmp_true_628
    adr x0, sign_id
    b cmp_end_629
cmp_true_628:
cmp_end_629:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_626_627:
    // Closure for func_626
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_626
    ldr x0, [sp], #16
    bl _cons
    b cond_end_602
cond_false_601:
    adr x0, sign_id
cond_end_602:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_632_633
func_632:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_637_638
func_637:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_639_640
func_639:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_641_642
func_641:
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
    b.eq cmp_true_643
    adr x0, sign_id
    b cmp_end_644
cmp_true_643:
cmp_end_644:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_641_642:
    // Closure for func_641
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_641
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_639_640:
    // Closure for func_639
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_639
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_645
do_apply_646:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_647
do_compose_645:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_647:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_637_638:
    // Closure for func_637
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_637
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_651_652
func_651:
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
    b.eq cmp_true_653
    adr x0, sign_id
    b cmp_end_654
cmp_true_653:
cmp_end_654:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_651_652:
    // Closure for func_651
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_651
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_634
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_636
xor_true_634:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_635
    adr x0, sign_id
    b xor_end_636
xor_false_635:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_632_633:
    // Closure for func_632
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_632
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_630
    b after_func_655_656
func_655:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_657
    adr x0, sign_id
    b cmp_end_658
cmp_true_657:
cmp_end_658:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_655_656:
    // Closure for func_655
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_655
    ldr x0, [sp], #16
    bl _cons
    b cond_end_631
cond_false_630:
    adr x0, sign_id
cond_end_631:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_661_662
func_661:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_666_667
func_666:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
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
after_func_670_671:
    // Closure for func_670
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_666_667:
    // Closure for func_666
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_666
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_678_679
func_678:
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
after_func_678_679:
    // Closure for func_678
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_678
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_663
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_665
xor_true_663:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_664
    adr x0, sign_id
    b xor_end_665
xor_false_664:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_661_662:
    // Closure for func_661
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_661
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_659
    b after_func_680_681
func_680:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    ldr x1, [sp], #16
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_680_681:
    // Closure for func_680
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_680
    ldr x0, [sp], #16
    bl _cons
    b cond_end_660
cond_false_659:
    adr x0, sign_id
cond_end_660:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_684_685
func_684:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_689_690
func_689:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_691_692
func_691:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_693_694
func_693:
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
    b.ne cmp_true_695
    adr x0, sign_id
    b cmp_end_696
cmp_true_695:
cmp_end_696:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_693_694:
    // Closure for func_693
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_693
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_697
do_apply_698:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_699
do_compose_697:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_699:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_700
do_apply_701:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_702
do_compose_700:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_702:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_689_690:
    // Closure for func_689
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_689
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_703_704
func_703:
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
    b.ne cmp_true_705
    adr x0, sign_id
    b cmp_end_706
cmp_true_705:
cmp_end_706:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_703_704:
    // Closure for func_703
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_703
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_686
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_688
xor_true_686:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_687
    adr x0, sign_id
    b xor_end_688
xor_false_687:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_682
    b after_func_707_708
func_707:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, y
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ne cmp_true_709
    adr x0, sign_id
    b cmp_end_710
cmp_true_709:
cmp_end_710:
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
    b cond_end_683
cond_false_682:
    adr x0, sign_id
cond_end_683:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.eq not_true_713
    adr x0, sign_id
    b not_end_714
not_true_713:
    mov x0, #0
not_end_714:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_711
    b after_func_715_716
func_715:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq not_true_717
    adr x0, sign_id
    b not_end_718
not_true_717:
    mov x0, #0
not_end_718:
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
    b cond_end_712
cond_false_711:
    adr x0, sign_id
cond_end_712:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_721_722
func_721:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_726_727
func_726:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_728_729
func_728:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_730_731
func_730:
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
after_func_730_731:
    // Closure for func_730
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_730
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_738_739
func_738:
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
after_func_738_739:
    // Closure for func_738
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_738
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_723
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_725
xor_true_723:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_724
    adr x0, sign_id
    b xor_end_725
xor_false_724:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_719
    b after_func_740_741
func_740:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mvn x0, x0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_740_741:
    // Closure for func_740
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_740
    ldr x0, [sp], #16
    bl _cons
    b cond_end_720
cond_false_719:
    adr x0, sign_id
cond_end_720:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_744_745
func_744:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_749_750
func_749:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_751_752
func_751:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_753_754
func_753:
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
after_func_753_754:
    // Closure for func_753
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_753
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_751_752:
    // Closure for func_751
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_751
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_755
do_apply_756:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_757
do_compose_755:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_757:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_758
do_apply_759:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_760
do_compose_758:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_760:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_749_750:
    // Closure for func_749
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_749
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_761_762
func_761:
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
after_func_761_762:
    // Closure for func_761
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_761
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_746
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_748
xor_true_746:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_747
    adr x0, sign_id
    b xor_end_748
xor_false_747:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_744_745:
    // Closure for func_744
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_744
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_742
    b after_func_763_764
func_763:
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
after_func_763_764:
    // Closure for func_763
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_763
    ldr x0, [sp], #16
    bl _cons
    b cond_end_743
cond_false_742:
    adr x0, sign_id
cond_end_743:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_767_768
func_767:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_772_773
func_772:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_774_775
func_774:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_776_777
func_776:
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
after_func_776_777:
    // Closure for func_776
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_776
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_772_773:
    // Closure for func_772
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_772
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_784_785
func_784:
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
after_func_784_785:
    // Closure for func_784
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_784
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_769
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_771
xor_true_769:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_770
    adr x0, sign_id
    b xor_end_771
xor_false_770:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_765
    b after_func_786_787
func_786:
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
after_func_786_787:
    // Closure for func_786
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_786
    ldr x0, [sp], #16
    bl _cons
    b cond_end_766
cond_false_765:
    adr x0, sign_id
cond_end_766:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_790_791
func_790:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_795_796
func_795:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_797_798
func_797:
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
    b.ne xor_true_799
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_801
xor_true_799:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_800
    adr x0, sign_id
    b xor_end_801
xor_false_800:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_797_798:
    // Closure for func_797
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_797
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_802
do_apply_803:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_804
do_compose_802:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_804:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ;
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_808
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_810
xor_true_808:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_809
    adr x0, sign_id
    b xor_end_810
xor_false_809:
    mov x0, x1
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_792
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_794
xor_true_792:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_793
    adr x0, sign_id
    b xor_end_794
xor_false_793:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_788
    b after_func_811_812
func_811:
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
    str x0, [sp, #-16]!
    adr x0, y
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
    b cond_end_789
cond_false_788:
    adr x0, sign_id
cond_end_789:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_821_822
func_821:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_826_827
func_826:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_828_829
func_828:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_830_831
func_830:
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
after_func_830_831:
    // Closure for func_830
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_830
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_835
do_apply_836:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_837
do_compose_835:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_837:
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
    str x0, [sp, #-16]!
    b after_func_838_839
func_838:
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
after_func_838_839:
    // Closure for func_838
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_838
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_823
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_825
xor_true_823:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_824
    adr x0, sign_id
    b xor_end_825
xor_false_824:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_819
    b after_func_840_841
func_840:
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
after_func_840_841:
    // Closure for func_840
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_840
    ldr x0, [sp], #16
    bl _cons
    b cond_end_820
cond_false_819:
    adr x0, sign_id
cond_end_820:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_844_845
func_844:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_849_850
func_849:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_851_852
func_851:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    asr x0, x1, x0
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_858
do_apply_859:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_860
do_compose_858:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_860:
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
    str x0, [sp, #-16]!
    b after_func_861_862
func_861:
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
after_func_861_862:
    // Closure for func_861
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_861
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_846
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_848
xor_true_846:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_847
    adr x0, sign_id
    b xor_end_848
xor_false_847:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_842
    b after_func_863_864
func_863:
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
after_func_863_864:
    // Closure for func_863
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_863
    ldr x0, [sp], #16
    bl _cons
    b cond_end_843
cond_false_842:
    adr x0, sign_id
cond_end_843:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_867_868
func_867:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_872_873
func_872:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_874_875
func_874:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_876_877
func_876:
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
after_func_876_877:
    // Closure for func_876
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_876
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_872_873:
    // Closure for func_872
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_872
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_884_885
func_884:
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
after_func_884_885:
    // Closure for func_884
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_884
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_869
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_871
xor_true_869:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_870
    adr x0, sign_id
    b xor_end_871
xor_false_870:
    mov x0, x1
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_865
    b after_func_886_887
func_886:
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
after_func_886_887:
    // Closure for func_886
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_886
    ldr x0, [sp], #16
    bl _cons
    b cond_end_866
cond_false_865:
    adr x0, sign_id
cond_end_866:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_890_891
func_890:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_895_896
func_895:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_897_898
func_897:
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
after_func_897_898:
    // Closure for func_897
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_897
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_899
do_apply_900:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_901
do_compose_899:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_901:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_902
do_apply_903:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_904
do_compose_902:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_904:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_895_896:
    // Closure for func_895
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_895
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
    b.ne xor_true_892
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_894
xor_true_892:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_893
    adr x0, sign_id
    b xor_end_894
xor_false_893:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_890_891:
    // Closure for func_890
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_890
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_888
    b after_func_905_906
func_905:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    b cond_end_889
cond_false_888:
    adr x0, sign_id
cond_end_889:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_909_910
func_909:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_914_915
func_914:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_916_917
func_916:
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
after_func_916_917:
    // Closure for func_916
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_916
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_921
do_apply_922:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_923
do_compose_921:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_923:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_914_915:
    // Closure for func_914
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_914
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
    b.ne xor_true_911
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_913
xor_true_911:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_912
    adr x0, sign_id
    b xor_end_913
xor_false_912:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_909_910:
    // Closure for func_909
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_909
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_907
    b after_func_924_925
func_924:
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
after_func_924_925:
    // Closure for func_924
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_924
    ldr x0, [sp], #16
    bl _cons
    b cond_end_908
cond_false_907:
    adr x0, sign_id
cond_end_908:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_928_929
func_928:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_933_934
func_933:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_935_936
func_935:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_937_938
func_937:
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
after_func_937_938:
    // Closure for func_937
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_937
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_933_934:
    // Closure for func_933
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_933
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_945_946
func_945:
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
after_func_945_946:
    // Closure for func_945
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_945
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_930
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_932
xor_true_930:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_931
    adr x0, sign_id
    b xor_end_932
xor_false_931:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_928_929:
    // Closure for func_928
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_928
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_926
    b after_func_947_948
func_947:
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
after_func_947_948:
    // Closure for func_947
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_947
    ldr x0, [sp], #16
    bl _cons
    b cond_end_927
cond_false_926:
    adr x0, sign_id
cond_end_927:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_951_952
func_951:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_956_957
func_956:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_958_959
func_958:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_960_961
func_960:
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
after_func_960_961:
    // Closure for func_960
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_960
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_958_959:
    // Closure for func_958
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_958
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
after_func_956_957:
    // Closure for func_956
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_956
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_968_969
func_968:
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
after_func_968_969:
    // Closure for func_968
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_968
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_953
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_955
xor_true_953:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_954
    adr x0, sign_id
    b xor_end_955
xor_false_954:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_951_952:
    // Closure for func_951
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_951
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_949
    b after_func_970_971
func_970:
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
after_func_970_971:
    // Closure for func_970
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_970
    ldr x0, [sp], #16
    bl _cons
    b cond_end_950
cond_false_949:
    adr x0, sign_id
cond_end_950:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_974_975
func_974:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_979_980
func_979:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_981_982
func_981:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_983_984
func_983:
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
after_func_983_984:
    // Closure for func_983
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_983
    ldr x0, [sp], #16
    bl _cons
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
after_func_979_980:
    // Closure for func_979
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_979
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_991_992
func_991:
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
after_func_991_992:
    // Closure for func_991
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_991
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_976
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_978
xor_true_976:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_977
    adr x0, sign_id
    b xor_end_978
xor_false_977:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_974_975:
    // Closure for func_974
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_974
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_972
    b after_func_993_994
func_993:
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
after_func_993_994:
    // Closure for func_993
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_993
    ldr x0, [sp], #16
    bl _cons
    b cond_end_973
cond_false_972:
    adr x0, sign_id
cond_end_973:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_997_998
func_997:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1002_1003
func_1002:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1004_1005
func_1004:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1006_1007
func_1006:
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
after_func_1006_1007:
    // Closure for func_1006
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1006
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1004_1005:
    // Closure for func_1004
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1004
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1002_1003:
    // Closure for func_1002
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1002
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1014_1015
func_1014:
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
after_func_1014_1015:
    // Closure for func_1014
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1014
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_999
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1001
xor_true_999:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1000
    adr x0, sign_id
    b xor_end_1001
xor_false_1000:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_997_998:
    // Closure for func_997
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_997
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_995
    b after_func_1016_1017
func_1016:
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
after_func_1016_1017:
    // Closure for func_1016
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1016
    ldr x0, [sp], #16
    bl _cons
    b cond_end_996
cond_false_995:
    adr x0, sign_id
cond_end_996:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1020_1021
func_1020:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1025_1026
func_1025:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1027_1028
func_1027:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1029_1030
func_1029:
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
after_func_1029_1030:
    // Closure for func_1029
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1029
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1027_1028:
    // Closure for func_1027
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1027
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1034
do_apply_1035:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1036
do_compose_1034:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1036:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1025_1026:
    // Closure for func_1025
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1025
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1037_1038
func_1037:
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
after_func_1037_1038:
    // Closure for func_1037
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1037
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1022
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1024
xor_true_1022:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1023
    adr x0, sign_id
    b xor_end_1024
xor_false_1023:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1020_1021:
    // Closure for func_1020
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1020
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1018
    b after_func_1039_1040
func_1039:
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
after_func_1039_1040:
    // Closure for func_1039
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1039
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1019
cond_false_1018:
    adr x0, sign_id
cond_end_1019:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1043_1044
func_1043:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1048_1049
func_1048:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1050_1051
func_1050:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1052_1053
func_1052:
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
after_func_1052_1053:
    // Closure for func_1052
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1052
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1050_1051:
    // Closure for func_1050
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1050
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1048_1049:
    // Closure for func_1048
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1048
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1060_1061
func_1060:
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
after_func_1060_1061:
    // Closure for func_1060
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1060
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1045
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1047
xor_true_1045:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1046
    adr x0, sign_id
    b xor_end_1047
xor_false_1046:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1043_1044:
    // Closure for func_1043
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1043
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1041
    b after_func_1062_1063
func_1062:
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
after_func_1062_1063:
    // Closure for func_1062
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1062
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1042
cond_false_1041:
    adr x0, sign_id
cond_end_1042:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1066_1067
func_1066:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1071_1072
func_1071:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1073_1074
func_1073:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1075_1076
func_1075:
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
after_func_1075_1076:
    // Closure for func_1075
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1075
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_1077
do_apply_1078:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1079
do_compose_1077:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1079:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1071_1072:
    // Closure for func_1071
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1071
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1083_1084
func_1083:
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
after_func_1083_1084:
    // Closure for func_1083
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1083
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1068
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1070
xor_true_1068:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1069
    adr x0, sign_id
    b xor_end_1070
xor_false_1069:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1066_1067:
    // Closure for func_1066
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1066
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1064
    b after_func_1085_1086
func_1085:
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
after_func_1085_1086:
    // Closure for func_1085
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1085
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1065
cond_false_1064:
    adr x0, sign_id
cond_end_1065:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1089_1090
func_1089:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1094_1095
func_1094:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1096_1097
func_1096:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1098_1099
func_1098:
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
after_func_1098_1099:
    // Closure for func_1098
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1098
    ldr x0, [sp], #16
    bl _cons
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
    cmp x0, #4096
    b.hi do_compose_1100
do_apply_1101:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1102
do_compose_1100:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1102:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
    str x0, [sp, #-16]!
    b after_func_1106_1107
func_1106:
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
after_func_1106_1107:
    // Closure for func_1106
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1106
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1091
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1093
xor_true_1091:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1092
    adr x0, sign_id
    b xor_end_1093
xor_false_1092:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1089_1090:
    // Closure for func_1089
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1089
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1087
    b after_func_1108_1109
func_1108:
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
after_func_1108_1109:
    // Closure for func_1108
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1108
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1088
cond_false_1087:
    adr x0, sign_id
cond_end_1088:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1112_1113
func_1112:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1117_1118
func_1117:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1119_1120
func_1119:
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
after_func_1119_1120:
    // Closure for func_1119
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1119
    ldr x0, [sp], #16
    bl _cons
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
    ldr x0, [x29, #-32]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1117_1118:
    // Closure for func_1117
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1117
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
    b.ne xor_true_1114
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1116
xor_true_1114:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1115
    adr x0, sign_id
    b xor_end_1116
xor_false_1115:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1112_1113:
    // Closure for func_1112
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1112
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1110
    b after_func_1127_1128
func_1127:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1127_1128:
    // Closure for func_1127
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1127
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1111
cond_false_1110:
    adr x0, sign_id
cond_end_1111:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1131_1132
func_1131:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1136_1137
func_1136:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1138_1139
func_1138:
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
after_func_1138_1139:
    // Closure for func_1138
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1138
    ldr x0, [sp], #16
    bl _cons
    cmp x0, #4096
    b.hi do_compose_1140
do_apply_1141:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1142
do_compose_1140:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1142:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1143
do_apply_1144:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1145
do_compose_1143:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1145:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1136_1137:
    // Closure for func_1136
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1136
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
    b.ne xor_true_1133
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1135
xor_true_1133:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1134
    adr x0, sign_id
    b xor_end_1135
xor_false_1134:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1131_1132:
    // Closure for func_1131
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1131
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1129
    b after_func_1146_1147
func_1146:
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
after_func_1146_1147:
    // Closure for func_1146
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1146
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1130
cond_false_1129:
    adr x0, sign_id
cond_end_1130:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, _
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1148
    b after_func_1150_1151
func_1150:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    add x0, x29, #-32
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1150_1151:
    // Closure for func_1150
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1150
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1149
cond_false_1148:
    adr x0, sign_id
cond_end_1149:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_1154_1155
func_1154:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1159_1160
func_1159:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, _compose
    str x0, [sp, #-16]!
    b after_func_1161_1162
func_1161:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    str x0, [x1]
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1161_1162:
    // Closure for func_1161
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1161
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    cmp x0, #4096
    b.hi do_compose_1168
do_apply_1169:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1170
do_compose_1168:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1170:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1159_1160:
    // Closure for func_1159
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1159
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1171_1172
func_1171:
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
after_func_1171_1172:
    // Closure for func_1171
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1171
    ldr x0, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_1156
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_1158
xor_true_1156:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_1157
    adr x0, sign_id
    b xor_end_1158
xor_false_1157:
    mov x0, x1
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1154_1155:
    // Closure for func_1154
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1154
    ldr x0, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1152
    b after_func_1173_1174
func_1173:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1173_1174:
    // Closure for func_1173
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1173
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, val
    ldr x1, [sp], #16
    str x0, [x1]
    b cond_end_1153
cond_false_1152:
    adr x0, sign_id
cond_end_1153:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #98
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
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #110
    cmp x0, #4096
    b.hi do_compose_1181
do_apply_1182:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1183
do_compose_1181:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1183:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1184
do_apply_1185:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1186
do_compose_1184:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1186:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #92
    cmp x0, #4096
    b.hi do_compose_1187
do_apply_1188:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1189
do_compose_1187:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1189:
    str x0, [sp, #-16]!
    adr x0, 

    cmp x0, #4096
    b.hi do_compose_1190
do_apply_1191:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1192
do_compose_1190:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1192:
    str x0, [sp, #-16]!
    adr x0, print_char
    cmp x0, #4096
    b.hi do_compose_1193
do_apply_1194:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1195
do_compose_1193:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1195:
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1196
do_apply_1197:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1198
do_compose_1196:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1198:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1199
do_apply_1200:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1201
do_compose_1199:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1201:
    str x0, [sp, #-16]!
    adr x0, print_char
    cmp x0, #4096
    b.hi do_compose_1202
do_apply_1203:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1204
do_compose_1202:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1204:
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1205
do_apply_1206:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1207
do_compose_1205:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1207:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_0
    adr x1, msg
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_str
    str x0, [sp, #-16]!
    adr x0, msg
    ldr x0, [x0]
    cmp x0, #4096
    b.hi do_compose_1208
do_apply_1209:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1210
do_compose_1208:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1210:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, print_char
    str x0, [sp, #-16]!
    mov x0, #10
    cmp x0, #4096
    b.hi do_compose_1211
do_apply_1212:
    ldr x9, [sp], #16
    ldr x10, [x9]
    ldr x9, [x9, #8]
    blr x10
    b apply_end_1213
do_compose_1211:
    mov x1, x0
    ldr x0, [sp], #16
    bl _compose
apply_end_1213:
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
heap_ptr: .quad 0
Reference: .quad 0
msg: .quad 0

